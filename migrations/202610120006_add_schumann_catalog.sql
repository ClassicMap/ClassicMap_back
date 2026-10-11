-- 슈만 작품을 출판 단위로 채운다. 작품 172개(묶음 99, 다악장 31, 낱곡 42), part 822, 그 아래 30.
-- 새 작품 166개, 기존 6개.
--
-- 정한 것
--   피아노 연작과 가곡집은 묶음이다(안의 곡이 part). 고유 제목 묶음은 제목에 작품번호를 넣지 않는다.
--   「어린이의 정경」은 운영에 둘(135 manual, 464 seed)이라 MBID·비교 구간이 있는 464 에 곡을 붙이고,
--     464 의 기존 seed part(3번)는 이름을 채워 잠근다. 135 는 그대로 둔다.
--   134 <시인의 사랑>·136 피아노 협주곡·137 교향곡 3번의 기존 MBID 는 편곡 work 라 원곡 work 를 식별자로 더한다.
--   교향적 연습곡 Op. 13 은 지금 연주를 다 덮는 1837년 판 구조(주제와 연습곡 12곡)로 둔다.
--   <사랑의 봄> Op. 37 의 클라라 슈만 곡 세 곡은 이름 끝에 "(클라라 슈만 작곡)" 을 붙여 함께 둔다.
--   미완성 "츠비카우" 교향곡 WoO 29 와 Op. 46 첫 판 WoO 10 은 뺀다.
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

-- Op. 1 아베크 변주곡 F장조

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '아베크 변주곡 F장조', 'Variations on the Name "Abegg" in F major', 'album', 'Op. 1', NULL, NULL, 1830, 'manual', 1
FROM composers c
WHERE c.id = 29
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '아베크 변주곡 F장조'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '898d68dc-0cde-3210-8f2e-89e3ba163ddd'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '898d68dc-0cde-3210-8f2e-89e3ba163ddd'
FROM pieces p
WHERE p.composer_id = 29 AND p.title = '아베크 변주곡 F장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '898d68dc-0cde-3210-8f2e-89e3ba163ddd'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:818e67d2-bec1-3c63-ae1b-1194b36020cc', 1, NULL, '주제', 'Theme', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 29 AND p.title = '아베크 변주곡 F장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:818e67d2-bec1-3c63-ae1b-1194b36020cc'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:326c6334-40f5-347c-abb0-b8e55ded3c19', 2, NULL, '1변주', 'Variation 1', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 29 AND p.title = '아베크 변주곡 F장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:326c6334-40f5-347c-abb0-b8e55ded3c19'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:c5b47049-85b6-3751-adc3-e57d1cd8d943', 3, NULL, '2변주', 'Variation 2', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 29 AND p.title = '아베크 변주곡 F장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:c5b47049-85b6-3751-adc3-e57d1cd8d943'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:ab6a08e6-7442-3847-9cb6-cdb35bfb3a8f', 4, NULL, '3변주', 'Variation 3', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 29 AND p.title = '아베크 변주곡 F장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:ab6a08e6-7442-3847-9cb6-cdb35bfb3a8f'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:12fd5009-2454-35ca-9b7e-786d41f8e61d', 5, NULL, 'Cantabile', 'Cantabile', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 29 AND p.title = '아베크 변주곡 F장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:12fd5009-2454-35ca-9b7e-786d41f8e61d'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:d40076c8-15fd-3429-963b-995dd01ac131', 6, NULL, '피날레 alla fantasia', 'Finale alla fantasia', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 29 AND p.title = '아베크 변주곡 F장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:d40076c8-15fd-3429-963b-995dd01ac131'
);


-- Op. 2 피아노 모음곡 <나비>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '피아노 모음곡 <나비>', 'Papillons', 'album', 'Op. 2', NULL, NULL, 1831, 'manual', 1
FROM composers c
WHERE c.id = 29
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '피아노 모음곡 <나비>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '51bf8c8f-06ee-38b2-aaff-f94563911928'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '51bf8c8f-06ee-38b2-aaff-f94563911928'
FROM pieces p
WHERE p.composer_id = 29 AND p.title = '피아노 모음곡 <나비>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '51bf8c8f-06ee-38b2-aaff-f94563911928'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:0b0cdad3-3472-3c2d-9dcd-1db14ab37570', 1, NULL, '서주. Moderato', 'Introduction. Moderato', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 29 AND p.title = '피아노 모음곡 <나비>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:0b0cdad3-3472-3c2d-9dcd-1db14ab37570'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:1071174b-6c69-4f3d-93d3-442e517538ee', 2, NULL, '왈츠 D장조', 'No. 1. Waltz in D major', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 29 AND p.title = '피아노 모음곡 <나비>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:1071174b-6c69-4f3d-93d3-442e517538ee'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:3a8ba611-ce03-3dce-b85a-3c8cdc2b2467', 3, NULL, '왈츠 E♭장조. Prestissimo', 'No. 2. Waltz in E♭ major. Prestissimo', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 29 AND p.title = '피아노 모음곡 <나비>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:3a8ba611-ce03-3dce-b85a-3c8cdc2b2467'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:6eb4361e-c119-3b4f-b0bb-813bc7b5804d', 4, NULL, '왈츠 F#단조. Pomposo', 'No. 3. Waltz in F# minor. Pomposo', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 29 AND p.title = '피아노 모음곡 <나비>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:6eb4361e-c119-3b4f-b0bb-813bc7b5804d'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:d7e8a340-791b-3c34-9ab3-fa393659e9b6', 5, NULL, '왈츠 A장조. Allegretto vivace', 'No. 4. Waltz in A major. Allegretto vivace', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 29 AND p.title = '피아노 모음곡 <나비>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:d7e8a340-791b-3c34-9ab3-fa393659e9b6'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:2517d790-a1b4-3ef5-8095-1d44ae2c0c51', 6, NULL, '폴로네즈 B♭장조. Allegretto cantabile', 'No. 5. Polonaise in B♭ major. Allegretto cantabile', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 29 AND p.title = '피아노 모음곡 <나비>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:2517d790-a1b4-3ef5-8095-1d44ae2c0c51'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:8f884824-96f8-3012-90ca-d38691351401', 7, NULL, '왈츠 D단조. Allegro molto', 'No. 6. Waltz in D minor. Allegro molto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 29 AND p.title = '피아노 모음곡 <나비>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:8f884824-96f8-3012-90ca-d38691351401'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:a6623c4a-3f1c-389c-a77f-6b6cc8018312', 8, NULL, '왈츠 F단조. Semplice', 'No. 7. Waltz in F minor. Semplice', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 29 AND p.title = '피아노 모음곡 <나비>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:a6623c4a-3f1c-389c-a77f-6b6cc8018312'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:aca4156e-fe15-36b5-bf85-57e66d5b05fc', 9, NULL, '왈츠 C#단조. Allegro con brio', 'No. 8. Waltz in C# minor. Allegro con brio', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 29 AND p.title = '피아노 모음곡 <나비>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:aca4156e-fe15-36b5-bf85-57e66d5b05fc'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:6887d4ed-c1f2-3b8d-ad1e-7f68334fc837', 10, NULL, '왈츠 B♭단조. Prestissimo', 'No. 9. Waltz in B♭ minor. Prestissimo', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 29 AND p.title = '피아노 모음곡 <나비>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:6887d4ed-c1f2-3b8d-ad1e-7f68334fc837'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:129ba132-df45-35d2-a7a3-9b3fa0075f87', 11, NULL, '왈츠 C장조. Vivo', 'No. 10. Waltz in C major. Vivo', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 29 AND p.title = '피아노 모음곡 <나비>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:129ba132-df45-35d2-a7a3-9b3fa0075f87'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:c2e59e8b-6b2a-3688-908a-0d0cf48e250e', 12, NULL, '폴로네즈 D장조. Allegro con spirito', 'No. 11. Polonaise in D major. Allegro con spirito', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 29 AND p.title = '피아노 모음곡 <나비>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:c2e59e8b-6b2a-3688-908a-0d0cf48e250e'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:7dd1e494-bea8-3102-9a08-6d9c86abefa8', 13, NULL, '피날레 D장조', 'No. 12. Finale in D major', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 29 AND p.title = '피아노 모음곡 <나비>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:7dd1e494-bea8-3102-9a08-6d9c86abefa8'
);


-- Op. 3 파가니니 카프리스에 의한 연습곡 Op. 3

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '파가니니 카프리스에 의한 연습곡 Op. 3', '6 Études after Paganini Caprices, Op. 3', 'album', NULL, 'Op.', '3', 1832, 'manual', 1
FROM composers c
WHERE c.id = 29
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '파가니니 카프리스에 의한 연습곡 Op. 3'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'b38b844a-a291-4e0a-b35d-c77a63158d2d'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'b38b844a-a291-4e0a-b35d-c77a63158d2d'
FROM pieces p
WHERE p.composer_id = 29 AND p.title = '파가니니 카프리스에 의한 연습곡 Op. 3' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'b38b844a-a291-4e0a-b35d-c77a63158d2d'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:9913b1c3-d9f7-420e-9002-1fd56195c4a4', 1, NULL, 'A단조. Agitato', 'No. 1 in A minor. Agitato', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 29 AND p.title = '파가니니 카프리스에 의한 연습곡 Op. 3' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:9913b1c3-d9f7-420e-9002-1fd56195c4a4'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:7c92195e-05d7-44d4-a339-f891d8ddffdd', 2, NULL, 'E장조. Allegretto', 'No. 2 in E major. Allegretto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 29 AND p.title = '파가니니 카프리스에 의한 연습곡 Op. 3' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:7c92195e-05d7-44d4-a339-f891d8ddffdd'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:1acaf77a-6b1e-4185-8e5e-1c17f2c3ba12', 3, NULL, 'C장조. Andante', 'No. 3 in C major. Andante', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 29 AND p.title = '파가니니 카프리스에 의한 연습곡 Op. 3' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:1acaf77a-6b1e-4185-8e5e-1c17f2c3ba12'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:ee5b3171-8871-456a-9bf7-092292e5f6ce', 4, NULL, 'B장조. Allegro', 'No. 4 in B major. Allegro', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 29 AND p.title = '파가니니 카프리스에 의한 연습곡 Op. 3' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:ee5b3171-8871-456a-9bf7-092292e5f6ce'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:c911b490-fb78-405a-8805-39bd4a04526e', 5, NULL, 'E♭장조. Lento – Allegro assai', 'No. 5 in E♭ major. Lento – Allegro assai', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 29 AND p.title = '파가니니 카프리스에 의한 연습곡 Op. 3' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:c911b490-fb78-405a-8805-39bd4a04526e'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:c23ba323-3e11-4710-95db-ad195645af70', 6, NULL, 'G단조. Allegro molto', 'No. 6 in G minor. Allegro molto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 29 AND p.title = '파가니니 카프리스에 의한 연습곡 Op. 3' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:c23ba323-3e11-4710-95db-ad195645af70'
);


-- Op. 4 간주곡 Op. 4

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '간주곡 Op. 4', '6 Intermezzi, Op. 4', 'album', NULL, 'Op.', '4', 1832, 'manual', 1
FROM composers c
WHERE c.id = 29
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '간주곡 Op. 4'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '56962af4-ac41-4e83-bae5-ebc6094c61c8'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '56962af4-ac41-4e83-bae5-ebc6094c61c8'
FROM pieces p
WHERE p.composer_id = 29 AND p.title = '간주곡 Op. 4' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '56962af4-ac41-4e83-bae5-ebc6094c61c8'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:61b4a9cd-9b91-3943-b601-ccd417b76eaf', 1, NULL, 'Allegro quasi maestoso', 'No. 1. Allegro quasi maestoso', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 29 AND p.title = '간주곡 Op. 4' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:61b4a9cd-9b91-3943-b601-ccd417b76eaf'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:88722472-bbcc-363a-89e7-be5f1504135a', 2, NULL, 'Presto a capriccio', 'No. 2. Presto a capriccio', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 29 AND p.title = '간주곡 Op. 4' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:88722472-bbcc-363a-89e7-be5f1504135a'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:d58d1d90-c19a-3df1-b182-bca093a58791', 3, NULL, 'Allegro marcato', 'No. 3. Allegro marcato', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 29 AND p.title = '간주곡 Op. 4' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:d58d1d90-c19a-3df1-b182-bca093a58791'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:55999978-5e05-33ed-86e2-febde9284f63', 4, NULL, 'Allegro semplice', 'No. 4. Allegro semplice', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 29 AND p.title = '간주곡 Op. 4' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:55999978-5e05-33ed-86e2-febde9284f63'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:236c2167-e5b7-34b4-8a22-e73b452bc393', 5, NULL, 'Allegro moderato', 'No. 5. Allegro moderato', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 29 AND p.title = '간주곡 Op. 4' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:236c2167-e5b7-34b4-8a22-e73b452bc393'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:5f83aaea-9d37-3238-8db3-ebb79ec5e7f3', 6, NULL, 'Allegro', 'No. 6. Allegro', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 29 AND p.title = '간주곡 Op. 4' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:5f83aaea-9d37-3238-8db3-ebb79ec5e7f3'
);


-- Op. 5 클라라 비크의 주제에 의한 즉흥곡 C장조

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '클라라 비크의 주제에 의한 즉흥곡 C장조', 'Impromptus on a Theme by Clara Wieck in C major', 'song', 'Op. 5', NULL, NULL, 1850, 'manual', 1
FROM composers c
WHERE c.id = 29
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '클라라 비크의 주제에 의한 즉흥곡 C장조'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'a8098807-302c-41da-86a1-d35d65a3c4f7'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'a8098807-302c-41da-86a1-d35d65a3c4f7'
FROM pieces p
WHERE p.composer_id = 29 AND p.title = '클라라 비크의 주제에 의한 즉흥곡 C장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'a8098807-302c-41da-86a1-d35d65a3c4f7'
);


-- Op. 6 피아노 모음곡 <다비드 동맹 무곡>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '피아노 모음곡 <다비드 동맹 무곡>', 'Davidsbündlertänze', 'album', 'Op. 6', NULL, NULL, 1837, 'manual', 1
FROM composers c
WHERE c.id = 29
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '피아노 모음곡 <다비드 동맹 무곡>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '304bda09-95e1-49f0-9cea-4b2c3fd4e94d'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '304bda09-95e1-49f0-9cea-4b2c3fd4e94d'
FROM pieces p
WHERE p.composer_id = 29 AND p.title = '피아노 모음곡 <다비드 동맹 무곡>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '304bda09-95e1-49f0-9cea-4b2c3fd4e94d'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:fde3c587-1328-3d05-9fa4-7bbd2108590d', 1, NULL, 'Lebhaft', 'No. 1. Lebhaft', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 29 AND p.title = '피아노 모음곡 <다비드 동맹 무곡>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:fde3c587-1328-3d05-9fa4-7bbd2108590d'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:f517455c-e622-3b6c-8345-f1d30f36ba56', 2, NULL, 'Innig', 'No. 2. Innig', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 29 AND p.title = '피아노 모음곡 <다비드 동맹 무곡>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:f517455c-e622-3b6c-8345-f1d30f36ba56'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:98078091-090c-3374-b2a2-2b3c0bfe922e', 3, NULL, 'Mit Humor (Etwas hahnbüchen)', 'No. 3. Mit Humor (Etwas hahnbüchen)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 29 AND p.title = '피아노 모음곡 <다비드 동맹 무곡>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:98078091-090c-3374-b2a2-2b3c0bfe922e'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:9569621e-5edf-3729-a27e-291b8ee21270', 4, NULL, 'Ungeduldig', 'No. 4. Ungeduldig', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 29 AND p.title = '피아노 모음곡 <다비드 동맹 무곡>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:9569621e-5edf-3729-a27e-291b8ee21270'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:4f2fdf6c-1661-3d95-962c-4a0f16f40241', 5, NULL, 'Einfach', 'No. 5. Einfach', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 29 AND p.title = '피아노 모음곡 <다비드 동맹 무곡>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:4f2fdf6c-1661-3d95-962c-4a0f16f40241'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:573beb74-19ff-3288-82fe-dd787328c08c', 6, NULL, 'Sehr rasch und in sich hinein', 'No. 6. Sehr rasch und in sich hinein', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 29 AND p.title = '피아노 모음곡 <다비드 동맹 무곡>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:573beb74-19ff-3288-82fe-dd787328c08c'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:a955561e-61e7-35d8-8ee7-f22876e788ea', 7, NULL, 'Nicht schnell mit äußerst starker Empfindung', 'No. 7. Nicht schnell mit äußerst starker Empfindung', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 29 AND p.title = '피아노 모음곡 <다비드 동맹 무곡>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:a955561e-61e7-35d8-8ee7-f22876e788ea'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:73f63dad-072e-39c1-b46b-326e0205df66', 8, NULL, 'Frisch', 'No. 8. Frisch', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 29 AND p.title = '피아노 모음곡 <다비드 동맹 무곡>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:73f63dad-072e-39c1-b46b-326e0205df66'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:c3c83ee6-ee72-3b09-89a7-2eac35198873', 9, NULL, 'Lebhaft', 'No. 9. Lebhaft', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 29 AND p.title = '피아노 모음곡 <다비드 동맹 무곡>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:c3c83ee6-ee72-3b09-89a7-2eac35198873'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:d71d1df1-a08a-38b7-bd2d-f44140c2e920', 10, NULL, 'Balladenmäßig. Sehr rasch', 'No. 10. Balladenmäßig. Sehr rasch', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 29 AND p.title = '피아노 모음곡 <다비드 동맹 무곡>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:d71d1df1-a08a-38b7-bd2d-f44140c2e920'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:658d613f-049e-3c7c-8cb0-8955d9004817', 11, NULL, 'Einfach', 'No. 11. Einfach', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 29 AND p.title = '피아노 모음곡 <다비드 동맹 무곡>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:658d613f-049e-3c7c-8cb0-8955d9004817'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:92d01b88-f291-319a-b29b-ad29d35f5cef', 12, NULL, 'Mit Humor', 'No. 12. Mit Humor', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 29 AND p.title = '피아노 모음곡 <다비드 동맹 무곡>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:92d01b88-f291-319a-b29b-ad29d35f5cef'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:16958c57-af20-3ef2-87cb-440c418dbb01', 13, NULL, 'Wild und lustig', 'No. 13. Wild und lustig', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 29 AND p.title = '피아노 모음곡 <다비드 동맹 무곡>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:16958c57-af20-3ef2-87cb-440c418dbb01'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:2fecebf0-5f79-3495-b47d-30c14be36f12', 14, NULL, 'Zart und singend', 'No. 14. Zart und singend', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 29 AND p.title = '피아노 모음곡 <다비드 동맹 무곡>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:2fecebf0-5f79-3495-b47d-30c14be36f12'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:92ce9cdc-9387-3b06-8d4d-8d6181ce5c67', 15, NULL, 'Frisch', 'No. 15. Frisch', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 29 AND p.title = '피아노 모음곡 <다비드 동맹 무곡>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:92ce9cdc-9387-3b06-8d4d-8d6181ce5c67'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:48deb484-e63e-39a2-923e-02b97a6df3fe', 16, NULL, 'Mit gutem Humor', 'No. 16. Mit gutem Humor', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 29 AND p.title = '피아노 모음곡 <다비드 동맹 무곡>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:48deb484-e63e-39a2-923e-02b97a6df3fe'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:08fd00cf-3ccf-37ac-9e8a-8a9d35607665', 17, NULL, 'Wie aus der Ferne', 'No. 17. Wie aus der Ferne', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 29 AND p.title = '피아노 모음곡 <다비드 동맹 무곡>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:08fd00cf-3ccf-37ac-9e8a-8a9d35607665'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:c31520c6-02c1-3e49-9ad1-330ce0cf1ec4', 18, NULL, 'Nicht schnell (Ganz zum Überfluss)', 'No. 18. Nicht schnell (Ganz zum Überfluss)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 29 AND p.title = '피아노 모음곡 <다비드 동맹 무곡>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:c31520c6-02c1-3e49-9ad1-330ce0cf1ec4'
);


-- Op. 7 토카타 C장조

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '토카타 C장조', 'Toccata in C major', 'song', 'Op. 7', NULL, NULL, 1832, 'manual', 1
FROM composers c
WHERE c.id = 29
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '토카타 C장조'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '6636e0db-6958-3650-915f-c5a902816400'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '6636e0db-6958-3650-915f-c5a902816400'
FROM pieces p
WHERE p.composer_id = 29 AND p.title = '토카타 C장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '6636e0db-6958-3650-915f-c5a902816400'
);


-- Op. 8 알레그로 B단조

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '알레그로 B단조', 'Allegro in B minor', 'song', 'Op. 8', NULL, NULL, 1831, 'manual', 1
FROM composers c
WHERE c.id = 29
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '알레그로 B단조'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'a08755a1-c470-3756-911c-1e07a8667625'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'a08755a1-c470-3756-911c-1e07a8667625'
FROM pieces p
WHERE p.composer_id = 29 AND p.title = '알레그로 B단조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'a08755a1-c470-3756-911c-1e07a8667625'
);


-- Op. 9 피아노 모음곡 <카니발>

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:521e6d1d-cbe6-3560-88e0-7d88d86a0285', 1, NULL, 'Préambule', 'Préambule', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 138 AND p.composer_id = 29
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:521e6d1d-cbe6-3560-88e0-7d88d86a0285'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:5b2efa67-9cae-39b5-80a8-3f6a0a19a0d9', 2, NULL, 'Pierrot', 'Pierrot', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 138 AND p.composer_id = 29
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:5b2efa67-9cae-39b5-80a8-3f6a0a19a0d9'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:32add338-f218-3a22-a9c0-2c0a4b8435ae', 3, NULL, 'Arlequin', 'Arlequin', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 138 AND p.composer_id = 29
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:32add338-f218-3a22-a9c0-2c0a4b8435ae'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:73bba6fd-0923-38d4-b256-3c110018d191', 4, NULL, 'Valse noble', 'Valse noble', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 138 AND p.composer_id = 29
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:73bba6fd-0923-38d4-b256-3c110018d191'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:6c4898a2-1514-3ee7-80f2-013de20108f5', 5, NULL, 'Eusebius', 'Eusebius', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 138 AND p.composer_id = 29
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:6c4898a2-1514-3ee7-80f2-013de20108f5'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:8da41266-ba51-354b-b304-d93181994e77', 6, NULL, 'Florestan', 'Florestan', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 138 AND p.composer_id = 29
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:8da41266-ba51-354b-b304-d93181994e77'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:0972131a-22db-327b-a9dc-e5adae5b74cb', 7, NULL, 'Coquette', 'Coquette', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 138 AND p.composer_id = 29
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:0972131a-22db-327b-a9dc-e5adae5b74cb'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:efc30438-4371-328a-930b-8a39dbce729c', 8, NULL, 'Réplique', 'Réplique', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 138 AND p.composer_id = 29
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:efc30438-4371-328a-930b-8a39dbce729c'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:335409d7-3d92-37b9-9f15-ed91dd685fb2', 9, NULL, 'Papillons', 'Papillons', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 138 AND p.composer_id = 29
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:335409d7-3d92-37b9-9f15-ed91dd685fb2'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:d29107ed-c087-3fec-970d-013c1c49cd80', 10, NULL, 'A.S.C.H. – S.C.H.A. (Lettres dansantes)', 'A.S.C.H. – S.C.H.A. (Lettres dansantes)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 138 AND p.composer_id = 29
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:d29107ed-c087-3fec-970d-013c1c49cd80'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:37b8d32e-6c9c-3f00-93c7-880f2a079500', 11, NULL, 'Chiarina', 'Chiarina', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 138 AND p.composer_id = 29
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:37b8d32e-6c9c-3f00-93c7-880f2a079500'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:cea4364b-5e48-3457-a112-29507b422a45', 12, NULL, 'Chopin', 'Chopin', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 138 AND p.composer_id = 29
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:cea4364b-5e48-3457-a112-29507b422a45'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:c2b90f64-f500-35d0-858b-880b0cba10bf', 13, NULL, 'Estrella', 'Estrella', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 138 AND p.composer_id = 29
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:c2b90f64-f500-35d0-858b-880b0cba10bf'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:936e7ee9-f67c-3a69-b388-0116a6cff365', 14, NULL, 'Reconnaissance', 'Reconnaissance', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 138 AND p.composer_id = 29
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:936e7ee9-f67c-3a69-b388-0116a6cff365'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:d6126b11-f4fa-333e-b1bd-6925a0ea05ed', 15, NULL, 'Pantalon et Colombine', 'Pantalon et Colombine', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 138 AND p.composer_id = 29
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:d6126b11-f4fa-333e-b1bd-6925a0ea05ed'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:f3f2a3b3-fd96-31d8-8c8f-290da37eb695', 16, NULL, 'Valse allemande', 'Valse allemande', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 138 AND p.composer_id = 29
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:f3f2a3b3-fd96-31d8-8c8f-290da37eb695'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:48d15db5-f344-3721-9ccf-881d91a0db92', 17, NULL, 'Paganini (Intermezzo)', 'Paganini (Intermezzo)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 138 AND p.composer_id = 29
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:48d15db5-f344-3721-9ccf-881d91a0db92'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:18b7cff9-7912-38df-8fb4-fa6784645d5e', 18, NULL, 'Aveu', 'Aveu', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 138 AND p.composer_id = 29
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:18b7cff9-7912-38df-8fb4-fa6784645d5e'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:741af0cf-e42e-3697-9267-ad2541b99f23', 19, NULL, 'Promenade', 'Promenade', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 138 AND p.composer_id = 29
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:741af0cf-e42e-3697-9267-ad2541b99f23'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:5aff2c24-595d-3419-ac8f-063721f38854', 20, NULL, 'Pause', 'Pause', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 138 AND p.composer_id = 29
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:5aff2c24-595d-3419-ac8f-063721f38854'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:bf19cc69-eda3-335c-b465-2fbde7ce27a8', 21, NULL, 'Marche des "Davidsbündler" contre les Philistins', 'Marche des "Davidsbündler" contre les Philistins', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 138 AND p.composer_id = 29
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:bf19cc69-eda3-335c-b465-2fbde7ce27a8'
);


-- Op. 10 파가니니 카프리스에 의한 연주회용 연습곡 Op. 10

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '파가니니 카프리스에 의한 연주회용 연습곡 Op. 10', '6 Concert Études after Paganini Caprices, Op. 10', 'album', NULL, 'Op.', '10', 1833, 'manual', 1
FROM composers c
WHERE c.id = 29
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '파가니니 카프리스에 의한 연주회용 연습곡 Op. 10'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'e1340768-c489-4dbf-a652-d48a6b5b1bf2'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'e1340768-c489-4dbf-a652-d48a6b5b1bf2'
FROM pieces p
WHERE p.composer_id = 29 AND p.title = '파가니니 카프리스에 의한 연주회용 연습곡 Op. 10' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'e1340768-c489-4dbf-a652-d48a6b5b1bf2'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:206ecf28-8ef6-47a4-80ce-3ef522581415', 1, NULL, 'A♭장조. Allegro molto', 'No. 1 in A♭ major. Allegro molto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 29 AND p.title = '파가니니 카프리스에 의한 연주회용 연습곡 Op. 10' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:206ecf28-8ef6-47a4-80ce-3ef522581415'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:6e6f0455-9250-4849-b045-592022f67d72', 2, NULL, 'G단조. Non troppo lento', 'No. 2 in G minor. Non troppo lento', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 29 AND p.title = '파가니니 카프리스에 의한 연주회용 연습곡 Op. 10' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:6e6f0455-9250-4849-b045-592022f67d72'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:992146e2-2836-4ffc-a824-fb648bcaad0c', 3, NULL, 'G단조. Vivace', 'No. 3 in G minor. Vivace', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 29 AND p.title = '파가니니 카프리스에 의한 연주회용 연습곡 Op. 10' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:992146e2-2836-4ffc-a824-fb648bcaad0c'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:b9be40f7-a635-4da2-82a7-955cc37a2dab', 4, NULL, 'C단조. Maestoso', 'No. 4 in C minor. Maestoso', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 29 AND p.title = '파가니니 카프리스에 의한 연주회용 연습곡 Op. 10' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:b9be40f7-a635-4da2-82a7-955cc37a2dab'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:f264e47d-cdbc-46b5-88b7-6b8b54ddc930', 5, NULL, 'B단조', 'No. 5 in B minor', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 29 AND p.title = '파가니니 카프리스에 의한 연주회용 연습곡 Op. 10' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:f264e47d-cdbc-46b5-88b7-6b8b54ddc930'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:39a5f7a1-f6b7-4e0d-bb54-3f1e72baca12', 6, NULL, 'E단조. Sostenuto – Allegro – Sostenuto', 'No. 6 in E minor. Sostenuto – Allegro – Sostenuto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 29 AND p.title = '파가니니 카프리스에 의한 연주회용 연습곡 Op. 10' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:39a5f7a1-f6b7-4e0d-bb54-3f1e72baca12'
);


-- Op. 11 피아노 소나타 1번 F#단조

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '피아노 소나타 1번 F#단조', 'Piano Sonata No. 1 in F# minor', 'album', 'Op. 11', NULL, NULL, 1835, 'manual', 1
FROM composers c
WHERE c.id = 29
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '피아노 소나타 1번 F#단조'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '3261c571-c8f7-4321-87f3-e4b93265efdd'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '3261c571-c8f7-4321-87f3-e4b93265efdd'
FROM pieces p
WHERE p.composer_id = 29 AND p.title = '피아노 소나타 1번 F#단조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '3261c571-c8f7-4321-87f3-e4b93265efdd'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:822b90e3-0a94-3c63-a5aa-b315dda6b3a8', 1, 'I', '서주. Allegro vivace', 'I. Introduzione. Allegro vivace', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 29 AND p.title = '피아노 소나타 1번 F#단조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:822b90e3-0a94-3c63-a5aa-b315dda6b3a8'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:b3837d1f-b8ba-336d-abd1-1e073e1c8d0b', 2, 'II', '아리아', 'II. Aria', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 29 AND p.title = '피아노 소나타 1번 F#단조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:b3837d1f-b8ba-336d-abd1-1e073e1c8d0b'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:adaadd04-d800-3320-8f38-e7b971a9d233', 3, 'III', '스케르초와 간주곡', 'III. Scherzo e Intermezzo', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 29 AND p.title = '피아노 소나타 1번 F#단조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:adaadd04-d800-3320-8f38-e7b971a9d233'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:41601844-eb5c-384e-bce0-2a5fc3986670', 4, 'IV', '피날레. Allegro un poco maestoso', 'IV. Finale. Allegro un poco maestoso', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 29 AND p.title = '피아노 소나타 1번 F#단조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:41601844-eb5c-384e-bce0-2a5fc3986670'
);


-- Op. 12 환상소곡집 Op. 12

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '환상소곡집 Op. 12', 'Fantasiestücke, Op. 12', 'album', NULL, 'Op.', '12', 1837, 'manual', 1
FROM composers c
WHERE c.id = 29
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '환상소곡집 Op. 12'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'e0af92df-05e8-4efd-9aa1-29540d1095cd'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'e0af92df-05e8-4efd-9aa1-29540d1095cd'
FROM pieces p
WHERE p.composer_id = 29 AND p.title = '환상소곡집 Op. 12' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'e0af92df-05e8-4efd-9aa1-29540d1095cd'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:ea8befbb-1c1a-342e-b203-99bd0e24160a', 1, NULL, '저녁에 (Des Abends)', 'Des Abends', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 29 AND p.title = '환상소곡집 Op. 12' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:ea8befbb-1c1a-342e-b203-99bd0e24160a'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:d76f2dfa-e57c-330d-96d4-26c79e88c0fb', 2, NULL, '비상 (Aufschwung)', 'Aufschwung', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 29 AND p.title = '환상소곡집 Op. 12' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:d76f2dfa-e57c-330d-96d4-26c79e88c0fb'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:1aca26f5-4d08-3481-8a92-5a83b32c0b97', 3, NULL, '왜? (Warum?)', 'Warum?', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 29 AND p.title = '환상소곡집 Op. 12' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:1aca26f5-4d08-3481-8a92-5a83b32c0b97'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:3019ad08-9a14-3499-bd5b-e9601dc4db19', 4, NULL, 'Grillen', 'Grillen', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 29 AND p.title = '환상소곡집 Op. 12' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:3019ad08-9a14-3499-bd5b-e9601dc4db19'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:e5052ed5-bbe1-3dab-95fa-a62941307fb0', 5, NULL, '밤에 (In der Nacht)', 'In der Nacht', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 29 AND p.title = '환상소곡집 Op. 12' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:e5052ed5-bbe1-3dab-95fa-a62941307fb0'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:4570997e-2c00-3dbb-bec3-c159123c7721', 6, NULL, 'Fabel', 'Fabel', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 29 AND p.title = '환상소곡집 Op. 12' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:4570997e-2c00-3dbb-bec3-c159123c7721'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:9b7508a5-d765-3103-9da7-f276ea0c028b', 7, NULL, 'Traumes Wirren', 'Traumes Wirren', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 29 AND p.title = '환상소곡집 Op. 12' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:9b7508a5-d765-3103-9da7-f276ea0c028b'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:01334b57-59fb-3976-9153-6147db145225', 8, NULL, 'Ende vom Lied', 'Ende vom Lied', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 29 AND p.title = '환상소곡집 Op. 12' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:01334b57-59fb-3976-9153-6147db145225'
);


-- Op. 13 교향적 연습곡 C#단조

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '교향적 연습곡 C#단조', 'Symphonic Études in C# minor', 'album', 'Op. 13', NULL, NULL, 1834, 'manual', 1
FROM composers c
WHERE c.id = 29
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '교향적 연습곡 C#단조'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '5dfe1c03-1c37-4dec-b438-9328a0601d8a'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '5dfe1c03-1c37-4dec-b438-9328a0601d8a'
FROM pieces p
WHERE p.composer_id = 29 AND p.title = '교향적 연습곡 C#단조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '5dfe1c03-1c37-4dec-b438-9328a0601d8a'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:657cb24e-9a57-3ea5-be06-0ead6889ef43', 1, NULL, '주제. Andante', 'Theme. Andante', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 29 AND p.title = '교향적 연습곡 C#단조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:657cb24e-9a57-3ea5-be06-0ead6889ef43'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:c2cafdf8-ae3a-3ce9-aae6-b68661bed35b', 2, NULL, '연습곡 I (변주 1). Un poco più vivo', 'Étude I (Variation 1). Un poco più vivo', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 29 AND p.title = '교향적 연습곡 C#단조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:c2cafdf8-ae3a-3ce9-aae6-b68661bed35b'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:de9911cf-2536-33d0-9e70-91d60439396b', 3, NULL, '연습곡 II (변주 2). Andante', 'Étude II (Variation 2). Andante', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 29 AND p.title = '교향적 연습곡 C#단조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:de9911cf-2536-33d0-9e70-91d60439396b'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:8a7ce70a-7f72-3737-82d5-8a94b7b88d44', 4, NULL, '연습곡 III. Vivace', 'Étude III. Vivace', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 29 AND p.title = '교향적 연습곡 C#단조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:8a7ce70a-7f72-3737-82d5-8a94b7b88d44'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:8c3c6f9c-06a4-3cbe-a762-b6b48a6b82c4', 5, NULL, '연습곡 IV (변주 3). Allegro marcato', 'Étude IV (Variation 3). Allegro marcato', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 29 AND p.title = '교향적 연습곡 C#단조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:8c3c6f9c-06a4-3cbe-a762-b6b48a6b82c4'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:9b5e61c1-0450-3cff-823e-5fd5881ad118', 6, NULL, '연습곡 V (변주 4). Scherzando', 'Étude V (Variation 4). Scherzando', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 29 AND p.title = '교향적 연습곡 C#단조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:9b5e61c1-0450-3cff-823e-5fd5881ad118'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:f4d4c21f-5483-38d9-b71f-75fb6244f747', 7, NULL, '연습곡 VI (변주 5). Agitato', 'Étude VI (Variation 5). Agitato', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 29 AND p.title = '교향적 연습곡 C#단조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:f4d4c21f-5483-38d9-b71f-75fb6244f747'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:0639cd96-d9a9-3505-be40-edf4196a94b9', 8, NULL, '연습곡 VII (변주 6). Allegro molto', 'Étude VII (Variation 6). Allegro molto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 29 AND p.title = '교향적 연습곡 C#단조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:0639cd96-d9a9-3505-be40-edf4196a94b9'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:4bbb615d-b4a6-3a74-af1b-f6b44f7f5277', 9, NULL, '연습곡 VIII (변주 7). Sempre marcatissimo', 'Étude VIII (Variation 7). Sempre marcatissimo', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 29 AND p.title = '교향적 연습곡 C#단조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:4bbb615d-b4a6-3a74-af1b-f6b44f7f5277'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:4e1de781-b223-303c-ae22-b8381da3971d', 10, NULL, '연습곡 IX. Presto possibile', 'Étude IX. Presto possibile', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 29 AND p.title = '교향적 연습곡 C#단조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:4e1de781-b223-303c-ae22-b8381da3971d'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:dcb86560-2eb6-3b64-a438-c4cbe6f3701a', 11, NULL, '연습곡 X (변주 8). Allegro con energia', 'Étude X (Variation 8). Allegro con energia', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 29 AND p.title = '교향적 연습곡 C#단조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:dcb86560-2eb6-3b64-a438-c4cbe6f3701a'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:9c99e66d-df94-3e47-8678-213e1f65f4df', 12, NULL, '연습곡 XI (변주 9). Andante espressivo', 'Étude XI (Variation 9). Andante espressivo', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 29 AND p.title = '교향적 연습곡 C#단조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:9c99e66d-df94-3e47-8678-213e1f65f4df'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:7a75f8f3-93fc-307a-ab13-b938d0c80ffa', 13, NULL, '연습곡 XII (피날레). Allegro brillante', 'Étude XII (Finale). Allegro brillante', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 29 AND p.title = '교향적 연습곡 C#단조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:7a75f8f3-93fc-307a-ab13-b938d0c80ffa'
);


-- Op. 14 피아노 소나타 3번 F단조 "관현악 없는 협주곡"

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '피아노 소나타 3번 F단조 "관현악 없는 협주곡"', 'Piano Sonata No. 3 in F minor "Concerto without Orchestra"', 'album', 'Op. 14', NULL, NULL, 1853, 'manual', 1
FROM composers c
WHERE c.id = 29
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '피아노 소나타 3번 F단조 "관현악 없는 협주곡"'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '29286535-a2ec-4b84-a146-ec5390e211b9'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '29286535-a2ec-4b84-a146-ec5390e211b9'
FROM pieces p
WHERE p.composer_id = 29 AND p.title = '피아노 소나타 3번 F단조 "관현악 없는 협주곡"' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '29286535-a2ec-4b84-a146-ec5390e211b9'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:92d551b5-fcf0-46b3-af8f-72603e7dbdd4', 1, 'I', 'Allegro brillante', 'I. Allegro brillante', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 29 AND p.title = '피아노 소나타 3번 F단조 "관현악 없는 협주곡"' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:92d551b5-fcf0-46b3-af8f-72603e7dbdd4'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:9fbe5d84-31b9-42ef-be82-1ed8a17040ae', 2, 'II', '스케르초. Molto comodo', 'II. Scherzo. Molto comodo', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 29 AND p.title = '피아노 소나타 3번 F단조 "관현악 없는 협주곡"' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:9fbe5d84-31b9-42ef-be82-1ed8a17040ae'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:5fa5e9b0-98e6-4502-a447-2b7f236ab746', 3, 'III', 'Quasi Variazioni. Andantino de Clara Wieck', 'III. Quasi Variazioni. Andantino de Clara Wieck', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 29 AND p.title = '피아노 소나타 3번 F단조 "관현악 없는 협주곡"' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:5fa5e9b0-98e6-4502-a447-2b7f236ab746'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:77265cf7-da76-4e3d-9d01-f1079e9173dc', 4, 'IV', '피날레. Prestissimo possibile', 'IV. Finale. Prestissimo possibile', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 29 AND p.title = '피아노 소나타 3번 F단조 "관현악 없는 협주곡"' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:77265cf7-da76-4e3d-9d01-f1079e9173dc'
);


-- Op. 15 피아노 모음곡 <어린이의 정경>

UPDATE pieces piece
SET piece.catalogue_system = 'Op.', piece.catalogue_number = '15'
WHERE piece.id = 464 AND piece.composer_id = 29
  AND piece.catalogue_number IS NULL AND piece.opus_number IS NULL;
UPDATE pieces piece
SET piece.composition_year = 1838
WHERE piece.id = 464 AND piece.composer_id = 29 AND piece.composition_year IS NULL;

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:04bf8808-7a43-30e1-97e9-5a6a8bcfdb96', 1, NULL, 'Von fremden Ländern und Menschen', 'Von fremden Ländern und Menschen', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 464 AND p.composer_id = 29
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:04bf8808-7a43-30e1-97e9-5a6a8bcfdb96'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:aafe4a73-09ed-3917-b187-4c3f515ac2c3', 2, NULL, 'Kuriose Geschichte', 'Kuriose Geschichte', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 464 AND p.composer_id = 29
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:aafe4a73-09ed-3917-b187-4c3f515ac2c3'
);

UPDATE piece_parts part
SET part.name_ko = 'Hasche-Mann', part.name_en = 'Hasche-Mann',
    part.movement_number = NULL,
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE part.id = 3 AND part.piece_id = 464
  AND part.part_key = 'musicbrainz:7a8d4ff2-f178-39c5-b03b-4050606e11ef' AND part.editor_locked = 0;

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:47da16ab-9b11-3089-90a0-ceb4ad102b5d', 4, NULL, 'Bittendes Kind', 'Bittendes Kind', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 464 AND p.composer_id = 29
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:47da16ab-9b11-3089-90a0-ceb4ad102b5d'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:73bc48de-e12b-3263-b6d0-54ba8c81466c', 5, NULL, 'Glückes genug', 'Glückes genug', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 464 AND p.composer_id = 29
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:73bc48de-e12b-3263-b6d0-54ba8c81466c'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:ff539270-fcb9-3996-9247-bf382901278f', 6, NULL, 'Wichtige Begebenheit', 'Wichtige Begebenheit', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 464 AND p.composer_id = 29
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:ff539270-fcb9-3996-9247-bf382901278f'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:437982b9-be3c-3b17-a102-f34cc46504aa', 7, NULL, '트로이메라이 (Träumerei)', 'Träumerei', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 464 AND p.composer_id = 29
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:437982b9-be3c-3b17-a102-f34cc46504aa'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:2fe296f5-9409-3e9c-9606-d0be330e6f73', 8, NULL, 'Am Kamin', 'Am Kamin', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 464 AND p.composer_id = 29
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:2fe296f5-9409-3e9c-9606-d0be330e6f73'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:856d54fc-8fe3-35f8-a4e2-7aec962d40e3', 9, NULL, 'Ritter vom Steckenpferd', 'Ritter vom Steckenpferd', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 464 AND p.composer_id = 29
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:856d54fc-8fe3-35f8-a4e2-7aec962d40e3'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:7586187c-8d78-3516-9dc2-cf66c7b7a77b', 10, NULL, 'Fast zu ernst', 'Fast zu ernst', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 464 AND p.composer_id = 29
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:7586187c-8d78-3516-9dc2-cf66c7b7a77b'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:5e1e2af7-25f2-3448-a94c-40ffe3335a7f', 11, NULL, 'Fürchtenmachen', 'Fürchtenmachen', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 464 AND p.composer_id = 29
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:5e1e2af7-25f2-3448-a94c-40ffe3335a7f'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:193d0122-bb3e-3085-bf24-d4445bfc4a53', 12, NULL, 'Kind im Einschlummern', 'Kind im Einschlummern', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 464 AND p.composer_id = 29
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:193d0122-bb3e-3085-bf24-d4445bfc4a53'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:6a5cf298-971f-3959-b1cd-04b632a4db15', 13, NULL, 'Der Dichter spricht', 'Der Dichter spricht', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 464 AND p.composer_id = 29
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:6a5cf298-971f-3959-b1cd-04b632a4db15'
);


-- Op. 16 피아노 모음곡 <크라이슬레리아나>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '피아노 모음곡 <크라이슬레리아나>', 'Kreisleriana', 'album', 'Op. 16', NULL, NULL, 1838, 'manual', 1
FROM composers c
WHERE c.id = 29
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '피아노 모음곡 <크라이슬레리아나>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '103b79e5-1115-464b-9d71-834aee584633'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '103b79e5-1115-464b-9d71-834aee584633'
FROM pieces p
WHERE p.composer_id = 29 AND p.title = '피아노 모음곡 <크라이슬레리아나>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '103b79e5-1115-464b-9d71-834aee584633'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:427970a0-271e-32e3-bc2c-27e37f0358e9', 1, NULL, 'Äußerst bewegt', 'No. 1. Äußerst bewegt', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 29 AND p.title = '피아노 모음곡 <크라이슬레리아나>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:427970a0-271e-32e3-bc2c-27e37f0358e9'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:0bc876d7-c892-3b2c-8090-ecb213d96ccc', 2, NULL, 'Sehr innig und nicht zu rasch', 'No. 2. Sehr innig und nicht zu rasch', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 29 AND p.title = '피아노 모음곡 <크라이슬레리아나>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:0bc876d7-c892-3b2c-8090-ecb213d96ccc'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:db11a41a-a099-37f4-99dc-262c1ca09bb1', 3, NULL, 'Sehr aufgeregt', 'No. 3. Sehr aufgeregt', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 29 AND p.title = '피아노 모음곡 <크라이슬레리아나>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:db11a41a-a099-37f4-99dc-262c1ca09bb1'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:16561d35-49b8-3566-a893-3cc9e653d9e6', 4, NULL, 'Sehr langsam', 'No. 4. Sehr langsam', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 29 AND p.title = '피아노 모음곡 <크라이슬레리아나>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:16561d35-49b8-3566-a893-3cc9e653d9e6'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:4628f2c8-616b-3738-be14-04fb71031886', 5, NULL, 'Sehr lebhaft', 'No. 5. Sehr lebhaft', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 29 AND p.title = '피아노 모음곡 <크라이슬레리아나>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:4628f2c8-616b-3738-be14-04fb71031886'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:9ae3bcc9-21f1-37e0-aa80-1981e50a9574', 6, NULL, 'Sehr langsam', 'No. 6. Sehr langsam', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 29 AND p.title = '피아노 모음곡 <크라이슬레리아나>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:9ae3bcc9-21f1-37e0-aa80-1981e50a9574'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:e62c1cae-c32d-3266-b16d-980edbfc4d86', 7, NULL, 'Sehr rasch', 'No. 7. Sehr rasch', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 29 AND p.title = '피아노 모음곡 <크라이슬레리아나>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:e62c1cae-c32d-3266-b16d-980edbfc4d86'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:e2619551-b46a-3317-be41-a9fb2041f194', 8, NULL, 'Schnell und spielend', 'No. 8. Schnell und spielend', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 29 AND p.title = '피아노 모음곡 <크라이슬레리아나>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:e2619551-b46a-3317-be41-a9fb2041f194'
);


-- Op. 17 환상곡 C장조

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '환상곡 C장조', 'Fantasie in C major', 'album', 'Op. 17', NULL, NULL, 1839, 'manual', 1
FROM composers c
WHERE c.id = 29
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '환상곡 C장조'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '27c866d2-6128-4360-a80e-c691ec3ca4c6'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '27c866d2-6128-4360-a80e-c691ec3ca4c6'
FROM pieces p
WHERE p.composer_id = 29 AND p.title = '환상곡 C장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '27c866d2-6128-4360-a80e-c691ec3ca4c6'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:86975947-b0c8-3335-957a-14912b26c767', 1, 'I', 'Durchaus phantastisch und leidenschaftlich vorzutragen – Adagio – Im lebhaften Tempo – Im Legenden Ton', 'I. Durchaus phantastisch und leidenschaftlich vorzutragen – Adagio – Im lebhaften Tempo – Im Legenden Ton', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 29 AND p.title = '환상곡 C장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:86975947-b0c8-3335-957a-14912b26c767'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:9ae19ad5-e2ff-3bf7-a4cd-8453017e1901', 2, 'II', 'Mäßig. Durchaus energisch – Etwas langsamer – Viel bewegter', 'II. Mäßig. Durchaus energisch – Etwas langsamer – Viel bewegter', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 29 AND p.title = '환상곡 C장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:9ae19ad5-e2ff-3bf7-a4cd-8453017e1901'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:52ec8820-28ae-3084-b14b-e67b6518c8eb', 3, 'III', 'Langsam getragen. Durchweg leise zu halten – Etwas bewegter', 'III. Langsam getragen. Durchweg leise zu halten – Etwas bewegter', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 29 AND p.title = '환상곡 C장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:52ec8820-28ae-3084-b14b-e67b6518c8eb'
);


-- Op. 18 아라베스크 C장조

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '아라베스크 C장조', 'Arabeske in C major', 'song', 'Op. 18', NULL, NULL, 1839, 'manual', 1
FROM composers c
WHERE c.id = 29
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '아라베스크 C장조'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'f90c60d1-11b5-32e1-b633-bcfd088c0e15'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'f90c60d1-11b5-32e1-b633-bcfd088c0e15'
FROM pieces p
WHERE p.composer_id = 29 AND p.title = '아라베스크 C장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'f90c60d1-11b5-32e1-b633-bcfd088c0e15'
);


-- Op. 19 꽃의 곡 D♭장조

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '꽃의 곡 D♭장조', 'Blumenstück in D♭ major', 'song', 'Op. 19', NULL, NULL, 1839, 'manual', 1
FROM composers c
WHERE c.id = 29
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '꽃의 곡 D♭장조'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '0558f3aa-902c-3cf4-ad3b-8987a15a48e9'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '0558f3aa-902c-3cf4-ad3b-8987a15a48e9'
FROM pieces p
WHERE p.composer_id = 29 AND p.title = '꽃의 곡 D♭장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '0558f3aa-902c-3cf4-ad3b-8987a15a48e9'
);


-- Op. 20 유머레스크 B♭장조

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '유머레스크 B♭장조', 'Humoreske in B♭ major', 'album', 'Op. 20', NULL, NULL, 1839, 'manual', 1
FROM composers c
WHERE c.id = 29
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '유머레스크 B♭장조'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'f28c047f-c0be-43b6-b1bf-4ca19c033487'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'f28c047f-c0be-43b6-b1bf-4ca19c033487'
FROM pieces p
WHERE p.composer_id = 29 AND p.title = '유머레스크 B♭장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'f28c047f-c0be-43b6-b1bf-4ca19c033487'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:405e7ec8-e6a9-3998-9074-b971a25eafbb', 1, 'I', 'Einfach – Sehr rasch und leicht – Noch rascher – Erstes Tempo – Wie im Anfang', 'I. Einfach – Sehr rasch und leicht – Noch rascher – Erstes Tempo – Wie im Anfang', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 29 AND p.title = '유머레스크 B♭장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:405e7ec8-e6a9-3998-9074-b971a25eafbb'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:f0a2c2c9-a6ae-378d-b7ea-038b40858c56', 2, 'II', 'Hastig – Nach und nach immer lebhafter und starker – Wie vorher – Adagio', 'II. Hastig – Nach und nach immer lebhafter und starker – Wie vorher – Adagio', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 29 AND p.title = '유머레스크 B♭장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:f0a2c2c9-a6ae-378d-b7ea-038b40858c56'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:0d66d14b-e957-3d4b-8393-a6140ca83b97', 3, 'III', 'Einfach und zart – Intermezzo', 'III. Einfach und zart – Intermezzo', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 29 AND p.title = '유머레스크 B♭장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:0d66d14b-e957-3d4b-8393-a6140ca83b97'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:5dbbd599-8e08-3a4e-9460-8ce980f17707', 4, 'IV', 'Innig', 'IV. Innig', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 29 AND p.title = '유머레스크 B♭장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:5dbbd599-8e08-3a4e-9460-8ce980f17707'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:d20a744b-29a7-3a7b-8042-19c3da97b526', 5, 'V', 'Sehr lebhaft – Immer lebhafter', 'V. Sehr lebhaft – Immer lebhafter', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 29 AND p.title = '유머레스크 B♭장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:d20a744b-29a7-3a7b-8042-19c3da97b526'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:096e774b-b91f-42d0-b29f-f2e94043312b', 6, 'VI', 'Mit einigem Pomp', 'VI. Mit einigem Pomp', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 29 AND p.title = '유머레스크 B♭장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:096e774b-b91f-42d0-b29f-f2e94043312b'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:25fb95bc-fcec-38f0-bdef-12eec7a1f040', 7, 'VII', 'Zum Beschluss – Adagio – Allegro', 'VII. Zum Beschluss – Adagio – Allegro', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 29 AND p.title = '유머레스크 B♭장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:25fb95bc-fcec-38f0-bdef-12eec7a1f040'
);


-- Op. 21 노벨레테 Op. 21

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '노벨레테 Op. 21', '8 Novelletten, Op. 21', 'album', NULL, 'Op.', '21', 1838, 'manual', 1
FROM composers c
WHERE c.id = 29
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '노벨레테 Op. 21'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '419de2c2-4faf-4b5d-af9e-3b458b2d49ee'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '419de2c2-4faf-4b5d-af9e-3b458b2d49ee'
FROM pieces p
WHERE p.composer_id = 29 AND p.title = '노벨레테 Op. 21' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '419de2c2-4faf-4b5d-af9e-3b458b2d49ee'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:0060760f-676a-3c1b-945a-7e695be0d848', 1, NULL, 'Markiert und kräftig', 'No. 1. Markiert und kräftig', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 29 AND p.title = '노벨레테 Op. 21' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:0060760f-676a-3c1b-945a-7e695be0d848'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:fb142718-d422-3228-90d6-f4fcaa1d7eaf', 2, NULL, 'Äußerst rasch und mit Bravour', 'No. 2. Äußerst rasch und mit Bravour', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 29 AND p.title = '노벨레테 Op. 21' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:fb142718-d422-3228-90d6-f4fcaa1d7eaf'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:b88a46c9-f61e-3653-aa9b-9915f637aeca', 3, NULL, 'Leicht und mit Humor', 'No. 3. Leicht und mit Humor', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 29 AND p.title = '노벨레테 Op. 21' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:b88a46c9-f61e-3653-aa9b-9915f637aeca'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:12f085de-853d-34b2-88be-46ff5de15827', 4, NULL, 'Ballmässig. Sehr munter', 'No. 4. Ballmässig. Sehr munter', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 29 AND p.title = '노벨레테 Op. 21' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:12f085de-853d-34b2-88be-46ff5de15827'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:afd5cdff-db2b-3848-8752-abd926dad8ec', 5, NULL, 'Rauschend und festlich', 'No. 5. Rauschend und festlich', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 29 AND p.title = '노벨레테 Op. 21' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:afd5cdff-db2b-3848-8752-abd926dad8ec'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:dbc74769-e1b4-32db-a937-a9cccc38f314', 6, NULL, 'Sehr lebhaft, mit vielem Humor', 'No. 6. Sehr lebhaft, mit vielem Humor', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 29 AND p.title = '노벨레테 Op. 21' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:dbc74769-e1b4-32db-a937-a9cccc38f314'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:d92f934d-8588-3e34-af77-b0d75120d9c8', 7, NULL, 'Äußerst rasch', 'No. 7. Äußerst rasch', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 29 AND p.title = '노벨레테 Op. 21' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:d92f934d-8588-3e34-af77-b0d75120d9c8'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:e5f6a23d-4e2e-3e00-aae4-3526fa6bdfbc', 8, NULL, 'Sehr lebhaft', 'No. 8. Sehr lebhaft', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 29 AND p.title = '노벨레테 Op. 21' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:e5f6a23d-4e2e-3e00-aae4-3526fa6bdfbc'
);


-- Op. 22 피아노 소나타 2번 G단조

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '피아노 소나타 2번 G단조', 'Piano Sonata No. 2 in G minor', 'album', 'Op. 22', NULL, NULL, 1835, 'manual', 1
FROM composers c
WHERE c.id = 29
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '피아노 소나타 2번 G단조'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '9179cca6-9697-4ac5-aa1e-485bbc80078f'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '9179cca6-9697-4ac5-aa1e-485bbc80078f'
FROM pieces p
WHERE p.composer_id = 29 AND p.title = '피아노 소나타 2번 G단조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '9179cca6-9697-4ac5-aa1e-485bbc80078f'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:0ee3fa28-91b7-3faa-8ec8-27075d4d635a', 1, 'I', 'So rasch wie möglich – Schneller – Noch schneller', 'I. So rasch wie möglich – Schneller – Noch schneller', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 29 AND p.title = '피아노 소나타 2번 G단조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:0ee3fa28-91b7-3faa-8ec8-27075d4d635a'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:ec64fced-3338-3488-bcb5-adf41684a570', 2, 'II', 'Andantino. Getragen', 'II. Andantino. Getragen', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 29 AND p.title = '피아노 소나타 2번 G단조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:ec64fced-3338-3488-bcb5-adf41684a570'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:59bc88a8-e69d-3a76-997b-d57772f1a11f', 3, 'III', '스케르초. Sehr rasch und markiert', 'III. Scherzo. Sehr rasch und markiert', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 29 AND p.title = '피아노 소나타 2번 G단조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:59bc88a8-e69d-3a76-997b-d57772f1a11f'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:ea2081ca-c474-3a17-bf4f-ccb3e17b68a8', 4, 'IV', '론도. Presto – Etwas langsamer – Prestissimo, quasi cadenza – Immer schneller und schneller', 'IV. Rondo. Presto – Etwas langsamer – Prestissimo, quasi cadenza – Immer schneller und schneller', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 29 AND p.title = '피아노 소나타 2번 G단조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:ea2081ca-c474-3a17-bf4f-ccb3e17b68a8'
);


-- Op. 23 밤의 소품 Op. 23

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '밤의 소품 Op. 23', '4 Nachtstücke, Op. 23', 'album', NULL, 'Op.', '23', 1839, 'manual', 1
FROM composers c
WHERE c.id = 29
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '밤의 소품 Op. 23'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '179f16b1-df15-4230-b2aa-7669a503aa86'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '179f16b1-df15-4230-b2aa-7669a503aa86'
FROM pieces p
WHERE p.composer_id = 29 AND p.title = '밤의 소품 Op. 23' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '179f16b1-df15-4230-b2aa-7669a503aa86'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:5955e33e-032d-3f31-882b-b004c5f4ed37', 1, NULL, 'Mehr langsam, oft zurückhaltend', 'No. 1. Mehr langsam, oft zurückhaltend', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 29 AND p.title = '밤의 소품 Op. 23' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:5955e33e-032d-3f31-882b-b004c5f4ed37'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:a35a1fe4-e51e-306d-bb23-b764d740e217', 2, NULL, 'Markiert und lebhaft', 'No. 2. Markiert und lebhaft', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 29 AND p.title = '밤의 소품 Op. 23' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:a35a1fe4-e51e-306d-bb23-b764d740e217'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:b67abcbe-27d3-336a-bbb9-6110da10a75a', 3, NULL, 'Mit großer Lebhaftigkeit', 'No. 3. Mit großer Lebhaftigkeit', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 29 AND p.title = '밤의 소품 Op. 23' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:b67abcbe-27d3-336a-bbb9-6110da10a75a'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:4778dd75-84f7-3ec7-b86a-5fc2c19da176', 4, NULL, 'Ad libitum – Einfach', 'No. 4. Ad libitum – Einfach', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 29 AND p.title = '밤의 소품 Op. 23' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:4778dd75-84f7-3ec7-b86a-5fc2c19da176'
);


-- Op. 24 연가곡집 <리더크라이스> Op. 24

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '연가곡집 <리더크라이스> Op. 24', 'Liederkreis, Op. 24', 'album', NULL, 'Op.', '24', 1840, 'manual', 1
FROM composers c
WHERE c.id = 29
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '연가곡집 <리더크라이스> Op. 24'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '03953d71-75ce-4f8f-af50-986416e94dab'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '03953d71-75ce-4f8f-af50-986416e94dab'
FROM pieces p
WHERE p.composer_id = 29 AND p.title = '연가곡집 <리더크라이스> Op. 24' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '03953d71-75ce-4f8f-af50-986416e94dab'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:128a8ea3-f267-37d7-a027-5853f122a713', 1, NULL, 'Morgens steh'' ich auf und frage', 'Morgens steh'' ich auf und frage', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 29 AND p.title = '연가곡집 <리더크라이스> Op. 24' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:128a8ea3-f267-37d7-a027-5853f122a713'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:a8449113-7640-34b7-988f-a780b2b04d95', 2, NULL, 'Es treibt mich hin, es treibt mich her', 'Es treibt mich hin, es treibt mich her', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 29 AND p.title = '연가곡집 <리더크라이스> Op. 24' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:a8449113-7640-34b7-988f-a780b2b04d95'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:4e36874c-41f0-3199-bcae-7899027cee2a', 3, NULL, 'Ich wandelte unter den Bäumen', 'Ich wandelte unter den Bäumen', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 29 AND p.title = '연가곡집 <리더크라이스> Op. 24' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:4e36874c-41f0-3199-bcae-7899027cee2a'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:a0fe87e1-a061-30fa-89d4-b8616dc3ac8d', 4, NULL, 'Lieb'' Liebchen, leg''s Händchen', 'Lieb'' Liebchen, leg''s Händchen', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 29 AND p.title = '연가곡집 <리더크라이스> Op. 24' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:a0fe87e1-a061-30fa-89d4-b8616dc3ac8d'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:6fd5655b-ec7d-34b6-bb30-6a227b56f64c', 5, NULL, 'Schöne Wiege meiner Leiden', 'Schöne Wiege meiner Leiden', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 29 AND p.title = '연가곡집 <리더크라이스> Op. 24' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:6fd5655b-ec7d-34b6-bb30-6a227b56f64c'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:c281c930-6ff6-39ab-a591-5e1bac9b44ef', 6, NULL, 'Warte, warte, wilder Schiffmann', 'Warte, warte, wilder Schiffmann', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 29 AND p.title = '연가곡집 <리더크라이스> Op. 24' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:c281c930-6ff6-39ab-a591-5e1bac9b44ef'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:6ea3abb3-e2cf-3a56-8d42-651575db132f', 7, NULL, 'Berg'' und Burgen schaun herunter', 'Berg'' und Burgen schaun herunter', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 29 AND p.title = '연가곡집 <리더크라이스> Op. 24' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:6ea3abb3-e2cf-3a56-8d42-651575db132f'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:356c08cf-8ac6-3214-86cc-323ab7093441', 8, NULL, 'Anfangs wollt'' ich fast verzagen', 'Anfangs wollt'' ich fast verzagen', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 29 AND p.title = '연가곡집 <리더크라이스> Op. 24' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:356c08cf-8ac6-3214-86cc-323ab7093441'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:38409cf1-60a4-3de8-a0ab-9edf662b0127', 9, NULL, 'Mit Myrten und Rosen, lieblich und hold', 'Mit Myrten und Rosen, lieblich und hold', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 29 AND p.title = '연가곡집 <리더크라이스> Op. 24' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:38409cf1-60a4-3de8-a0ab-9edf662b0127'
);


-- Op. 25 가곡집 <미르테의 꽃>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '가곡집 <미르테의 꽃>', 'Myrthen', 'album', 'Op. 25', NULL, NULL, 1840, 'manual', 1
FROM composers c
WHERE c.id = 29
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '가곡집 <미르테의 꽃>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '97fb8652-fe29-4e55-96a8-168e3b0d3073'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '97fb8652-fe29-4e55-96a8-168e3b0d3073'
FROM pieces p
WHERE p.composer_id = 29 AND p.title = '가곡집 <미르테의 꽃>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '97fb8652-fe29-4e55-96a8-168e3b0d3073'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:82efe4de-b544-358b-8f6f-b6af98106337', 1, NULL, '헌정 (Widmung)', 'Widmung', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 29 AND p.title = '가곡집 <미르테의 꽃>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:82efe4de-b544-358b-8f6f-b6af98106337'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:79ad1eb4-d80a-38b5-ab21-fa0f5b3ae0b1', 2, NULL, 'Freisinn', 'Freisinn', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 29 AND p.title = '가곡집 <미르테의 꽃>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:79ad1eb4-d80a-38b5-ab21-fa0f5b3ae0b1'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:f597951b-34e2-314c-b666-4dc1c2ac9e79', 3, NULL, '호두나무 (Der Nussbaum)', 'Der Nussbaum', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 29 AND p.title = '가곡집 <미르테의 꽃>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:f597951b-34e2-314c-b666-4dc1c2ac9e79'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:9263d6c9-8773-4abc-9b6a-6651d55aa817', 4, NULL, 'Jemand', 'Jemand', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 29 AND p.title = '가곡집 <미르테의 꽃>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:9263d6c9-8773-4abc-9b6a-6651d55aa817'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:522e4920-f18f-325a-a306-fabff8e9a9a7', 5, NULL, 'Sitz'' ich allein', 'Sitz'' ich allein', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 29 AND p.title = '가곡집 <미르테의 꽃>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:522e4920-f18f-325a-a306-fabff8e9a9a7'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:a9101595-1753-3982-8ded-b6625d54f648', 6, NULL, 'Setze mir nicht, du Grobian', 'Setze mir nicht, du Grobian', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 29 AND p.title = '가곡집 <미르테의 꽃>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:a9101595-1753-3982-8ded-b6625d54f648'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:1eebf522-11d9-3bb4-a2af-06fac85ead20', 7, NULL, '연꽃 (Die Lotosblume)', 'Die Lotosblume', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 29 AND p.title = '가곡집 <미르테의 꽃>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:1eebf522-11d9-3bb4-a2af-06fac85ead20'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:4cdee769-8a53-3965-8c01-04cff2639215', 8, NULL, 'Talismane', 'Talismane', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 29 AND p.title = '가곡집 <미르테의 꽃>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:4cdee769-8a53-3965-8c01-04cff2639215'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:26ef0282-7593-439b-a0ca-e6bd8c28a5ae', 9, NULL, 'Lied der Suleika', 'Lied der Suleika', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 29 AND p.title = '가곡집 <미르테의 꽃>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:26ef0282-7593-439b-a0ca-e6bd8c28a5ae'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:1ef0fb14-eeb4-470e-99cc-b0bd87685607', 10, NULL, 'Die Hochländer-Witwe', 'Die Hochländer-Witwe', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 29 AND p.title = '가곡집 <미르테의 꽃>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:1ef0fb14-eeb4-470e-99cc-b0bd87685607'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:4846d5a2-7f63-4364-86ce-7a878169a229', 11, NULL, 'Lied der Braut I ("Mutter! Mutter!")', 'Lied der Braut I ("Mutter! Mutter!")', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 29 AND p.title = '가곡집 <미르테의 꽃>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:4846d5a2-7f63-4364-86ce-7a878169a229'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:d868fb99-8b62-4a46-beda-c36299a41860', 12, NULL, 'Lied der Braut II ("Lass mich ihm am Busen hangen")', 'Lied der Braut II ("Lass mich ihm am Busen hangen")', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 29 AND p.title = '가곡집 <미르테의 꽃>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:d868fb99-8b62-4a46-beda-c36299a41860'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:f8fee20b-2284-35c5-91a1-f70131882fcb', 13, NULL, 'Hochländers Abschied', 'Hochländers Abschied', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 29 AND p.title = '가곡집 <미르테의 꽃>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:f8fee20b-2284-35c5-91a1-f70131882fcb'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:7f389dcb-46cd-461e-9871-977342a6aea0', 14, NULL, 'Hochländers Wiegenlied', 'Hochländers Wiegenlied', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 29 AND p.title = '가곡집 <미르테의 꽃>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:7f389dcb-46cd-461e-9871-977342a6aea0'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:b9362ec2-ff58-3e6e-9af4-b64c3e9deb9b', 15, NULL, 'Aus den hebräischen Gesängen ("Mein Herz ist schwer")', 'Aus den hebräischen Gesängen ("Mein Herz ist schwer")', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 29 AND p.title = '가곡집 <미르테의 꽃>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:b9362ec2-ff58-3e6e-9af4-b64c3e9deb9b'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:2965077e-8303-30ce-b40a-8cbbcdc8794d', 16, NULL, 'Rätsel', 'Rätsel', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 29 AND p.title = '가곡집 <미르테의 꽃>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:2965077e-8303-30ce-b40a-8cbbcdc8794d'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:7a33405b-c889-3a78-be5f-3a6cb91fd554', 17, NULL, 'Venetianisches Lied I ("Leis'' rudern hier")', 'Venetianisches Lied I ("Leis'' rudern hier")', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 29 AND p.title = '가곡집 <미르테의 꽃>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:7a33405b-c889-3a78-be5f-3a6cb91fd554'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:065c3273-49f5-3e3c-848e-017ee3ab2188', 18, NULL, 'Venetianisches Lied II ("Wenn durch die Piazzetta")', 'Venetianisches Lied II ("Wenn durch die Piazzetta")', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 29 AND p.title = '가곡집 <미르테의 꽃>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:065c3273-49f5-3e3c-848e-017ee3ab2188'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:6ccb221e-a044-3a42-a0e3-5db726765d39', 19, NULL, 'Hauptmanns Weib', 'Hauptmanns Weib', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 29 AND p.title = '가곡집 <미르테의 꽃>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:6ccb221e-a044-3a42-a0e3-5db726765d39'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:9b18cc4e-0698-4c97-be38-0fcc80e1c60c', 20, NULL, 'Weit, weit', 'Weit, weit', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 29 AND p.title = '가곡집 <미르테의 꽃>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:9b18cc4e-0698-4c97-be38-0fcc80e1c60c'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:edd55e04-96cd-3a0d-83f3-08ed884e4e5f', 21, NULL, 'Was will die einsame Träne?', 'Was will die einsame Träne?', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 29 AND p.title = '가곡집 <미르테의 꽃>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:edd55e04-96cd-3a0d-83f3-08ed884e4e5f'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:f1bafb43-4745-32e4-adc7-d4a58c030d75', 22, NULL, 'Niemand', 'Niemand', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 29 AND p.title = '가곡집 <미르테의 꽃>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:f1bafb43-4745-32e4-adc7-d4a58c030d75'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:ec688f3d-13e1-4c5e-9993-94a488d9ee46', 23, NULL, 'Im Westen', 'Im Westen', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 29 AND p.title = '가곡집 <미르테의 꽃>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:ec688f3d-13e1-4c5e-9993-94a488d9ee46'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:712598d3-8bcd-3876-99b2-e2d80cc872e9', 24, NULL, 'Du bist wie eine Blume', 'Du bist wie eine Blume', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 29 AND p.title = '가곡집 <미르테의 꽃>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:712598d3-8bcd-3876-99b2-e2d80cc872e9'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:23c75ee7-7fa0-3c85-849f-10701bf245fe', 25, NULL, 'Aus den östlichen Rosen', 'Aus den östlichen Rosen', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 29 AND p.title = '가곡집 <미르테의 꽃>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:23c75ee7-7fa0-3c85-849f-10701bf245fe'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:aaeaca27-2546-36c5-a38c-0ec121c3bbfd', 26, NULL, 'Zum Schluss', 'Zum Schluss', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 29 AND p.title = '가곡집 <미르테의 꽃>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:aaeaca27-2546-36c5-a38c-0ec121c3bbfd'
);


-- Op. 26 피아노 모음곡 <빈 사육제의 어릿광대>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '피아노 모음곡 <빈 사육제의 어릿광대>', 'Faschingsschwank aus Wien', 'album', 'Op. 26', NULL, NULL, 1839, 'manual', 1
FROM composers c
WHERE c.id = 29
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '피아노 모음곡 <빈 사육제의 어릿광대>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '8aa6f584-d39e-4bf5-96de-e342a747d41a'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '8aa6f584-d39e-4bf5-96de-e342a747d41a'
FROM pieces p
WHERE p.composer_id = 29 AND p.title = '피아노 모음곡 <빈 사육제의 어릿광대>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '8aa6f584-d39e-4bf5-96de-e342a747d41a'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:d15a4412-e2d1-3107-8720-a05d97a4430a', 1, 'I', 'Allegro. Sehr lebhaft', 'I. Allegro. Sehr lebhaft', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 29 AND p.title = '피아노 모음곡 <빈 사육제의 어릿광대>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:d15a4412-e2d1-3107-8720-a05d97a4430a'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:0234a545-70a7-3251-9085-ac0794c85f09', 2, 'II', '로망스. Ziemlich langsam', 'II. Romanze. Ziemlich langsam', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 29 AND p.title = '피아노 모음곡 <빈 사육제의 어릿광대>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:0234a545-70a7-3251-9085-ac0794c85f09'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:2b8b4366-f19e-3f09-891f-27a5506be376', 3, 'III', '스케르치노', 'III. Scherzino', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 29 AND p.title = '피아노 모음곡 <빈 사육제의 어릿광대>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:2b8b4366-f19e-3f09-891f-27a5506be376'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:ad085799-27b5-3508-acda-21571677aa55', 4, 'IV', '간주곡. Mit größter Energie', 'IV. Intermezzo. Mit größter Energie', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 29 AND p.title = '피아노 모음곡 <빈 사육제의 어릿광대>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:ad085799-27b5-3508-acda-21571677aa55'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:4311bea8-83b0-362e-9681-0f85876300ed', 5, 'V', '피날레. Höchst lebhaft', 'V. Finale. Höchst lebhaft', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 29 AND p.title = '피아노 모음곡 <빈 사육제의 어릿광대>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:4311bea8-83b0-362e-9681-0f85876300ed'
);


-- Op. 27 가곡과 노래 1집 Op. 27

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '가곡과 노래 1집 Op. 27', 'Lieder und Gesänge, Vol. I, Op. 27', 'album', NULL, 'Op.', '27', 1840, 'manual', 1
FROM composers c
WHERE c.id = 29
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '가곡과 노래 1집 Op. 27'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '66c6eb7f-f3ac-449c-aedb-9588a09b5eb8'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '66c6eb7f-f3ac-449c-aedb-9588a09b5eb8'
FROM pieces p
WHERE p.composer_id = 29 AND p.title = '가곡과 노래 1집 Op. 27' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '66c6eb7f-f3ac-449c-aedb-9588a09b5eb8'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:26dd2efb-ce92-3239-9e4d-c355e92d02f8', 1, NULL, 'Sag an, o lieber Vogel mein', 'Sag an, o lieber Vogel mein', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 29 AND p.title = '가곡과 노래 1집 Op. 27' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:26dd2efb-ce92-3239-9e4d-c355e92d02f8'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:a12e7f0e-e339-3b39-8cd9-9ddbc7b4f096', 2, NULL, 'Dem roten Röslein gleicht mein Lieb', 'Dem roten Röslein gleicht mein Lieb', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 29 AND p.title = '가곡과 노래 1집 Op. 27' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:a12e7f0e-e339-3b39-8cd9-9ddbc7b4f096'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:fe0e3e7a-46ac-3d47-a34c-ac78a1e49327', 3, NULL, 'Was soll ich sagen', 'Was soll ich sagen', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 29 AND p.title = '가곡과 노래 1집 Op. 27' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:fe0e3e7a-46ac-3d47-a34c-ac78a1e49327'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:d7643d37-5ccf-3bc0-9bba-c68764e8d800', 4, NULL, 'Jasminenstrauch', 'Jasminenstrauch', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 29 AND p.title = '가곡과 노래 1집 Op. 27' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:d7643d37-5ccf-3bc0-9bba-c68764e8d800'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:29e78201-60c2-36e2-a2cb-2c7f3aa69109', 5, NULL, 'Nur ein lächelnder Blick', 'Nur ein lächelnder Blick', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 29 AND p.title = '가곡과 노래 1집 Op. 27' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:29e78201-60c2-36e2-a2cb-2c7f3aa69109'
);


-- Op. 28 로망스 Op. 28

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '로망스 Op. 28', '3 Romanzen, Op. 28', 'album', NULL, 'Op.', '28', 1839, 'manual', 1
FROM composers c
WHERE c.id = 29
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '로망스 Op. 28'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '6642f474-48d5-4e99-8859-6499f316737d'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '6642f474-48d5-4e99-8859-6499f316737d'
FROM pieces p
WHERE p.composer_id = 29 AND p.title = '로망스 Op. 28' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '6642f474-48d5-4e99-8859-6499f316737d'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:ccd8ef3b-3e60-3c39-b3d7-985bf3ff808e', 1, NULL, 'B♭단조. Sehr markiert', 'No. 1 in B♭ minor. Sehr markiert', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 29 AND p.title = '로망스 Op. 28' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:ccd8ef3b-3e60-3c39-b3d7-985bf3ff808e'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:7653e390-2e88-313e-8390-696adbb95d38', 2, NULL, 'F#장조. Einfach', 'No. 2 in F# major. Einfach', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 29 AND p.title = '로망스 Op. 28' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:7653e390-2e88-313e-8390-696adbb95d38'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:9d6ae048-ae3e-3c10-9a3b-d27e802b90b7', 3, NULL, 'B장조. Sehr markiert', 'No. 3 in B major. Sehr markiert', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 29 AND p.title = '로망스 Op. 28' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:9d6ae048-ae3e-3c10-9a3b-d27e802b90b7'
);


-- Op. 29 3개의 시 Op. 29

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '3개의 시 Op. 29', '3 Gedichte, Op. 29', 'album', NULL, 'Op.', '29', 1840, 'manual', 1
FROM composers c
WHERE c.id = 29
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '3개의 시 Op. 29'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '0c82d0a8-d9b1-4125-ab1c-fa880938976f'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '0c82d0a8-d9b1-4125-ab1c-fa880938976f'
FROM pieces p
WHERE p.composer_id = 29 AND p.title = '3개의 시 Op. 29' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '0c82d0a8-d9b1-4125-ab1c-fa880938976f'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:3eb44913-93dd-4ed9-a7f4-4c54985d6851', 1, NULL, 'Ländliches Lied', 'Ländliches Lied', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 29 AND p.title = '3개의 시 Op. 29' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:3eb44913-93dd-4ed9-a7f4-4c54985d6851'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:81d164fc-51db-494c-a3bd-645e0db51c52', 2, NULL, 'Lied', 'Lied', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 29 AND p.title = '3개의 시 Op. 29' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:81d164fc-51db-494c-a3bd-645e0db51c52'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:cc2b46c9-74a2-3a43-8cad-e92b4b96383a', 3, NULL, 'Zigeunerleben', 'Zigeunerleben', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 29 AND p.title = '3개의 시 Op. 29' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:cc2b46c9-74a2-3a43-8cad-e92b4b96383a'
);


-- Op. 30 3개의 시 Op. 30

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '3개의 시 Op. 30', '3 Gedichte, Op. 30', 'album', NULL, 'Op.', '30', 1840, 'manual', 1
FROM composers c
WHERE c.id = 29
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '3개의 시 Op. 30'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '38b159f9-e24a-458d-b907-c8bf98fc44a6'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '38b159f9-e24a-458d-b907-c8bf98fc44a6'
FROM pieces p
WHERE p.composer_id = 29 AND p.title = '3개의 시 Op. 30' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '38b159f9-e24a-458d-b907-c8bf98fc44a6'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:9880ceba-c146-3064-ae52-012e03a7a0dc', 1, NULL, 'Der Knabe mit dem Wunderhorn', 'Der Knabe mit dem Wunderhorn', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 29 AND p.title = '3개의 시 Op. 30' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:9880ceba-c146-3064-ae52-012e03a7a0dc'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:1768411e-43cd-3ea0-949b-a4e8cccf73a4', 2, NULL, 'Der Page', 'Der Page', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 29 AND p.title = '3개의 시 Op. 30' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:1768411e-43cd-3ea0-949b-a4e8cccf73a4'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:fa687970-6ad4-3372-af91-77c643c35d1a', 3, NULL, 'Der Hidalgo', 'Der Hidalgo', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 29 AND p.title = '3개의 시 Op. 30' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:fa687970-6ad4-3372-af91-77c643c35d1a'
);


-- Op. 31 3개의 노래 Op. 31

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '3개의 노래 Op. 31', '3 Gesänge, Op. 31', 'album', NULL, 'Op.', '31', 1840, 'manual', 1
FROM composers c
WHERE c.id = 29
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '3개의 노래 Op. 31'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '6836c9a8-1ce4-4b18-a405-781a244fa566'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '6836c9a8-1ce4-4b18-a405-781a244fa566'
FROM pieces p
WHERE p.composer_id = 29 AND p.title = '3개의 노래 Op. 31' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '6836c9a8-1ce4-4b18-a405-781a244fa566'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:22e98a72-b183-3ea3-a794-25063fc04e32', 1, NULL, 'Die Löwenbraut', 'Die Löwenbraut', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 29 AND p.title = '3개의 노래 Op. 31' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:22e98a72-b183-3ea3-a794-25063fc04e32'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:6c1bede9-60ca-3500-8134-fecbf5bb5f9b', 2, NULL, 'Die Kartenlegerin', 'Die Kartenlegerin', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 29 AND p.title = '3개의 노래 Op. 31' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:6c1bede9-60ca-3500-8134-fecbf5bb5f9b'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:8f1984fa-12a1-3211-8a39-618942789f6e', 3, NULL, 'Die rote Hanne', 'Die rote Hanne', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 29 AND p.title = '3개의 노래 Op. 31' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:8f1984fa-12a1-3211-8a39-618942789f6e'
);


-- Op. 32 피아노 소품 Op. 32

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '피아노 소품 Op. 32', '4 Klavierstücke, Op. 32', 'album', NULL, 'Op.', '32', 1839, 'manual', 1
FROM composers c
WHERE c.id = 29
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '피아노 소품 Op. 32'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'f9e08ca5-19b0-428b-a9bd-c12dcf15c84e'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'f9e08ca5-19b0-428b-a9bd-c12dcf15c84e'
FROM pieces p
WHERE p.composer_id = 29 AND p.title = '피아노 소품 Op. 32' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'f9e08ca5-19b0-428b-a9bd-c12dcf15c84e'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:64189c37-4bc4-4a59-b02b-cf9f2242724f', 1, NULL, '스케르초', 'Scherzo', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 29 AND p.title = '피아노 소품 Op. 32' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:64189c37-4bc4-4a59-b02b-cf9f2242724f'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:0489208e-1697-4cca-a67b-b0eee2f1c640', 2, NULL, '지그', 'Gigue', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 29 AND p.title = '피아노 소품 Op. 32' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:0489208e-1697-4cca-a67b-b0eee2f1c640'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:7af0c468-9326-45f6-bce7-d2c6f7939c83', 3, NULL, '로망스', 'Romanze', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 29 AND p.title = '피아노 소품 Op. 32' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:7af0c468-9326-45f6-bce7-d2c6f7939c83'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:6a54829f-0eeb-4e6c-8038-5faa34c6a54c', 4, NULL, '푸게타', 'Fughette', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 29 AND p.title = '피아노 소품 Op. 32' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:6a54829f-0eeb-4e6c-8038-5faa34c6a54c'
);


-- Op. 33 6개의 남성 합창곡 Op. 33

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '6개의 남성 합창곡 Op. 33', '6 Lieder for male chorus, Op. 33', 'album', NULL, 'Op.', '33', 1840, 'manual', 1
FROM composers c
WHERE c.id = 29
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '6개의 남성 합창곡 Op. 33'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'b02b63a5-45ed-4b94-a066-993b61359407'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'b02b63a5-45ed-4b94-a066-993b61359407'
FROM pieces p
WHERE p.composer_id = 29 AND p.title = '6개의 남성 합창곡 Op. 33' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'b02b63a5-45ed-4b94-a066-993b61359407'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:de991ef3-77b6-443b-9e3a-1a35d00cf7f9', 1, NULL, 'Der träumende See', 'Der träumende See', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 29 AND p.title = '6개의 남성 합창곡 Op. 33' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:de991ef3-77b6-443b-9e3a-1a35d00cf7f9'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:bd9ff6df-0ef5-4255-9d99-056a7293de0d', 2, NULL, 'Die Minnesänger', 'Die Minnesänger', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 29 AND p.title = '6개의 남성 합창곡 Op. 33' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:bd9ff6df-0ef5-4255-9d99-056a7293de0d'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:3608e5d5-0a36-403d-bd3f-c0d58060ca75', 3, NULL, 'Die Lotosblume', 'Die Lotosblume', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 29 AND p.title = '6개의 남성 합창곡 Op. 33' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:3608e5d5-0a36-403d-bd3f-c0d58060ca75'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:0240faae-cb67-4261-8145-91cc63980d63', 4, NULL, 'Der Zecher als Doktrinär', 'Der Zecher als Doktrinär', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 29 AND p.title = '6개의 남성 합창곡 Op. 33' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:0240faae-cb67-4261-8145-91cc63980d63'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:3bb5ec3d-b800-4d04-8f80-414e4d25240d', 5, NULL, 'Rastlose Liebe', 'Rastlose Liebe', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 29 AND p.title = '6개의 남성 합창곡 Op. 33' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:3bb5ec3d-b800-4d04-8f80-414e4d25240d'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:d2c53c7b-18c4-4ade-b2d7-cdbb3a196ef3', 6, NULL, 'Frühlingsglocken', 'Frühlingsglocken', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 29 AND p.title = '6개의 남성 합창곡 Op. 33' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:d2c53c7b-18c4-4ade-b2d7-cdbb3a196ef3'
);


-- Op. 34 4개의 이중창 Op. 34

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '4개의 이중창 Op. 34', '4 Duets, Op. 34', 'album', NULL, 'Op.', '34', 1840, 'manual', 1
FROM composers c
WHERE c.id = 29
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '4개의 이중창 Op. 34'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'dea0a0ad-aab5-44d8-9285-4fc1b215bce3'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'dea0a0ad-aab5-44d8-9285-4fc1b215bce3'
FROM pieces p
WHERE p.composer_id = 29 AND p.title = '4개의 이중창 Op. 34' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'dea0a0ad-aab5-44d8-9285-4fc1b215bce3'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:7c2466b6-0223-43f1-933c-8eb61b4b9eb8', 1, NULL, 'Liebesgarten', 'Liebesgarten', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 29 AND p.title = '4개의 이중창 Op. 34' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:7c2466b6-0223-43f1-933c-8eb61b4b9eb8'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:2470b28c-6cdd-4a51-bdcd-d35ece785055', 2, NULL, 'Liebhabers Ständchen', 'Liebhabers Ständchen', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 29 AND p.title = '4개의 이중창 Op. 34' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:2470b28c-6cdd-4a51-bdcd-d35ece785055'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:2101c7ec-b62c-4985-89bb-c2c12383f9ce', 3, NULL, 'Unterm Fenster', 'Unterm Fenster', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 29 AND p.title = '4개의 이중창 Op. 34' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:2101c7ec-b62c-4985-89bb-c2c12383f9ce'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:8e5ff3f6-9113-4e57-a30c-fe7e613d5190', 4, NULL, 'Familien-Gemälde', 'Familien-Gemälde', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 29 AND p.title = '4개의 이중창 Op. 34' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:8e5ff3f6-9113-4e57-a30c-fe7e613d5190'
);


-- Op. 35 12개의 시 Op. 35

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '12개의 시 Op. 35', '12 Gedichte, Op. 35', 'album', NULL, 'Op.', '35', 1840, 'manual', 1
FROM composers c
WHERE c.id = 29
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '12개의 시 Op. 35'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'adfd1a07-4f3c-446f-9e4e-c9d28bc70488'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'adfd1a07-4f3c-446f-9e4e-c9d28bc70488'
FROM pieces p
WHERE p.composer_id = 29 AND p.title = '12개의 시 Op. 35' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'adfd1a07-4f3c-446f-9e4e-c9d28bc70488'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:c64a0d68-5506-3589-9f0c-9e999e34d7ac', 1, NULL, 'Lust der Sturmnacht', 'Lust der Sturmnacht', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 29 AND p.title = '12개의 시 Op. 35' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:c64a0d68-5506-3589-9f0c-9e999e34d7ac'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:63349aa5-454a-3698-ac9d-99f85759a262', 2, NULL, 'Stirb, Lieb'' und Freud''!', 'Stirb, Lieb'' und Freud''!', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 29 AND p.title = '12개의 시 Op. 35' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:63349aa5-454a-3698-ac9d-99f85759a262'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:38612d5f-0329-3dfc-853f-df11a9e3b722', 3, NULL, 'Wanderlied', 'Wanderlied', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 29 AND p.title = '12개의 시 Op. 35' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:38612d5f-0329-3dfc-853f-df11a9e3b722'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:59ab030d-ed4a-3f78-8f10-0fdd09f74d4a', 4, NULL, 'Erstes Grün', 'Erstes Grün', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 29 AND p.title = '12개의 시 Op. 35' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:59ab030d-ed4a-3f78-8f10-0fdd09f74d4a'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:89b281c2-19f5-36db-a285-684a6be0fa6f', 5, NULL, 'Sehnsucht nach der Waldgegend', 'Sehnsucht nach der Waldgegend', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 29 AND p.title = '12개의 시 Op. 35' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:89b281c2-19f5-36db-a285-684a6be0fa6f'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:2621fc50-a3db-32f7-a2c1-0d7a843742a6', 6, NULL, 'Auf das Trinkglas eines verstorbenen Freundes', 'Auf das Trinkglas eines verstorbenen Freundes', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 29 AND p.title = '12개의 시 Op. 35' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:2621fc50-a3db-32f7-a2c1-0d7a843742a6'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:028aae86-1589-3175-9ce9-f607cbaf576f', 7, NULL, 'Wanderung', 'Wanderung', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 29 AND p.title = '12개의 시 Op. 35' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:028aae86-1589-3175-9ce9-f607cbaf576f'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:69d0ea42-cd85-3f9f-98ff-3efe59114757', 8, NULL, 'Stille Liebe', 'Stille Liebe', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 29 AND p.title = '12개의 시 Op. 35' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:69d0ea42-cd85-3f9f-98ff-3efe59114757'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:a24c7421-34cf-35a5-8ab7-d634111a04f6', 9, NULL, 'Frage', 'Frage', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 29 AND p.title = '12개의 시 Op. 35' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:a24c7421-34cf-35a5-8ab7-d634111a04f6'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:418e480d-967d-35bc-8987-715ef8e46cff', 10, NULL, 'Stille Tränen', 'Stille Tränen', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 29 AND p.title = '12개의 시 Op. 35' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:418e480d-967d-35bc-8987-715ef8e46cff'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:86785065-1630-3364-8776-0c0268431236', 11, NULL, 'Wer machte dich so krank?', 'Wer machte dich so krank?', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 29 AND p.title = '12개의 시 Op. 35' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:86785065-1630-3364-8776-0c0268431236'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:bf879176-12b7-3774-bfc4-f5dafe87fb58', 12, NULL, 'Alte Laute', 'Alte Laute', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 29 AND p.title = '12개의 시 Op. 35' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:bf879176-12b7-3774-bfc4-f5dafe87fb58'
);


-- Op. 36 6개의 시 Op. 36

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '6개의 시 Op. 36', '6 Gedichte aus dem Liederbuch eines Malers, Op. 36', 'album', NULL, 'Op.', '36', 1840, 'manual', 1
FROM composers c
WHERE c.id = 29
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '6개의 시 Op. 36'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '8420fcf5-7ea5-4691-8b98-02af8af1f907'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '8420fcf5-7ea5-4691-8b98-02af8af1f907'
FROM pieces p
WHERE p.composer_id = 29 AND p.title = '6개의 시 Op. 36' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '8420fcf5-7ea5-4691-8b98-02af8af1f907'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:f33eee98-0454-35f6-8041-6edff38b58ee', 1, NULL, 'Sonntags am Rhein', 'Sonntags am Rhein', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 29 AND p.title = '6개의 시 Op. 36' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:f33eee98-0454-35f6-8041-6edff38b58ee'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:122deb8f-9bac-3ea2-aff2-c71c8faf6291', 2, NULL, 'Ständchen', 'Ständchen', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 29 AND p.title = '6개의 시 Op. 36' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:122deb8f-9bac-3ea2-aff2-c71c8faf6291'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:bc193d5c-ed94-35d8-b698-46be82df776b', 3, NULL, 'Nichts Schöneres', 'Nichts Schöneres', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 29 AND p.title = '6개의 시 Op. 36' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:bc193d5c-ed94-35d8-b698-46be82df776b'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:2679eb4d-9a88-3a14-a67c-8d13c0638034', 4, NULL, 'An den Sonnenschein', 'An den Sonnenschein', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 29 AND p.title = '6개의 시 Op. 36' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:2679eb4d-9a88-3a14-a67c-8d13c0638034'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:0392e859-3125-3a65-89db-47065ca2ecc9', 5, NULL, 'Dichters Genesung', 'Dichters Genesung', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 29 AND p.title = '6개의 시 Op. 36' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:0392e859-3125-3a65-89db-47065ca2ecc9'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:a69fad17-c5d6-3118-88ff-97c147261639', 6, NULL, 'Liebesbotschaft', 'Liebesbotschaft', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 29 AND p.title = '6개의 시 Op. 36' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:a69fad17-c5d6-3118-88ff-97c147261639'
);


-- Op. 37 가곡집 <사랑의 봄>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '가곡집 <사랑의 봄>', 'Gedichte aus "Liebesfrühling"', 'album', 'Op. 37', NULL, NULL, 1841, 'manual', 1
FROM composers c
WHERE c.id = 29
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '가곡집 <사랑의 봄>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'e1134265-69b8-42da-8307-6b473998cbed'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'e1134265-69b8-42da-8307-6b473998cbed'
FROM pieces p
WHERE p.composer_id = 29 AND p.title = '가곡집 <사랑의 봄>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'e1134265-69b8-42da-8307-6b473998cbed'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:af5e533c-1697-375b-8223-b5b1344f3b71', 1, NULL, 'Der Himmel hat eine Träne geweint', 'Der Himmel hat eine Träne geweint', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 29 AND p.title = '가곡집 <사랑의 봄>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:af5e533c-1697-375b-8223-b5b1344f3b71'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:0a973bff-3062-47f1-a455-6bcbfa05defe', 2, NULL, 'Er ist gekommen in Sturm und Regen (클라라 슈만 작곡)', 'Er ist gekommen in Sturm und Regen', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 29 AND p.title = '가곡집 <사랑의 봄>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:0a973bff-3062-47f1-a455-6bcbfa05defe'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:72523b91-b967-40d3-aa6d-95337664b607', 3, NULL, 'O ihr Herren', 'O ihr Herren', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 29 AND p.title = '가곡집 <사랑의 봄>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:72523b91-b967-40d3-aa6d-95337664b607'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:23d17c15-b032-41e5-80f2-0bb67024763a', 4, NULL, 'Liebst du um Schönheit (클라라 슈만 작곡)', 'Liebst du um Schönheit', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 29 AND p.title = '가곡집 <사랑의 봄>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:23d17c15-b032-41e5-80f2-0bb67024763a'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:c1627412-02a8-304c-b3ff-ba51c8a266d5', 5, NULL, 'Ich hab'' in mich gesogen', 'Ich hab'' in mich gesogen', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 29 AND p.title = '가곡집 <사랑의 봄>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:c1627412-02a8-304c-b3ff-ba51c8a266d5'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:6bcbc994-2095-482c-b83f-26746da3774d', 6, NULL, 'Liebste, was kann denn uns scheiden', 'Liebste, was kann denn uns scheiden', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 29 AND p.title = '가곡집 <사랑의 봄>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:6bcbc994-2095-482c-b83f-26746da3774d'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:51dbd1fd-3125-473a-9a6b-2eae7bfcc911', 7, NULL, 'Schön ist das Fest des Lenzes', 'Schön ist das Fest des Lenzes', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 29 AND p.title = '가곡집 <사랑의 봄>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:51dbd1fd-3125-473a-9a6b-2eae7bfcc911'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:0b593bd3-d9f1-3593-b620-9f9d4b2799ad', 8, NULL, 'Flügel! Flügel! um zu fliegen', 'Flügel! Flügel! um zu fliegen', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 29 AND p.title = '가곡집 <사랑의 봄>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:0b593bd3-d9f1-3593-b620-9f9d4b2799ad'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:d0148e77-a662-3a46-b9fb-a7a5d67849be', 9, NULL, 'Rose, Meer und Sonne', 'Rose, Meer und Sonne', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 29 AND p.title = '가곡집 <사랑의 봄>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:d0148e77-a662-3a46-b9fb-a7a5d67849be'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:a30e9f07-7bd8-406c-b1fc-b8b199badcc3', 10, NULL, 'O Sonn'', o Meer, o Rose', 'O Sonn'', o Meer, o Rose', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 29 AND p.title = '가곡집 <사랑의 봄>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:a30e9f07-7bd8-406c-b1fc-b8b199badcc3'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:6cbcd73e-c3ec-4685-93a6-9d60d4a26746', 11, NULL, 'Warum willst du and''re fragen (클라라 슈만 작곡)', 'Warum willst du and''re fragen', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 29 AND p.title = '가곡집 <사랑의 봄>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:6cbcd73e-c3ec-4685-93a6-9d60d4a26746'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:c75f07f9-3d79-4889-97d3-7e5b9b887b65', 12, NULL, 'So wahr die Sonne scheinet', 'So wahr die Sonne scheinet', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 29 AND p.title = '가곡집 <사랑의 봄>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:c75f07f9-3d79-4889-97d3-7e5b9b887b65'
);


-- Op. 38 교향곡 1번 B♭장조 "봄"

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '교향곡 1번 B♭장조 "봄"', 'Symphony No. 1 in B♭ major "Spring"', 'album', 'Op. 38', NULL, NULL, 1841, 'manual', 1
FROM composers c
WHERE c.id = 29
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '교향곡 1번 B♭장조 "봄"'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '0ea0e0e3-80e1-3a3c-82d4-70f83ae7ba0d'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '0ea0e0e3-80e1-3a3c-82d4-70f83ae7ba0d'
FROM pieces p
WHERE p.composer_id = 29 AND p.title = '교향곡 1번 B♭장조 "봄"' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '0ea0e0e3-80e1-3a3c-82d4-70f83ae7ba0d'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:06b86391-cec4-30a6-b705-1db6ddc911de', 1, 'I', 'Andante un poco maestoso – Allegro molto vivace', 'I. Andante un poco maestoso – Allegro molto vivace', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 29 AND p.title = '교향곡 1번 B♭장조 "봄"' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:06b86391-cec4-30a6-b705-1db6ddc911de'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:f28c70d9-31ef-3062-848a-025a2be18ba8', 2, 'II', 'Larghetto', 'II. Larghetto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 29 AND p.title = '교향곡 1번 B♭장조 "봄"' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:f28c70d9-31ef-3062-848a-025a2be18ba8'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:907b2bcf-7de5-3d1b-8d80-b03055850d42', 3, 'III', '스케르초. Molto vivace', 'III. Scherzo. Molto vivace', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 29 AND p.title = '교향곡 1번 B♭장조 "봄"' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:907b2bcf-7de5-3d1b-8d80-b03055850d42'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:b5c7e258-b881-3c93-ba90-6360ca55df7f', 4, 'IV', 'Allegro animato e grazioso', 'IV. Allegro animato e grazioso', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 29 AND p.title = '교향곡 1번 B♭장조 "봄"' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:b5c7e258-b881-3c93-ba90-6360ca55df7f'
);


-- Op. 39 연가곡집 <리더크라이스> Op. 39

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '연가곡집 <리더크라이스> Op. 39', 'Liederkreis, Op. 39', 'album', NULL, 'Op.', '39', 1840, 'manual', 1
FROM composers c
WHERE c.id = 29
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '연가곡집 <리더크라이스> Op. 39'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'd35e916a-78b6-495f-b102-002326085e4b'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'd35e916a-78b6-495f-b102-002326085e4b'
FROM pieces p
WHERE p.composer_id = 29 AND p.title = '연가곡집 <리더크라이스> Op. 39' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'd35e916a-78b6-495f-b102-002326085e4b'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:b4d6805c-f700-3637-9c91-0d49b403d7d2', 1, NULL, 'In der Fremde ("Aus der Heimat hinter den Blitzen rot")', 'In der Fremde ("Aus der Heimat hinter den Blitzen rot")', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 29 AND p.title = '연가곡집 <리더크라이스> Op. 39' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:b4d6805c-f700-3637-9c91-0d49b403d7d2'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:754505ae-0fe1-3a25-87dd-a410e281b036', 2, NULL, 'Intermezzo', 'Intermezzo', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 29 AND p.title = '연가곡집 <리더크라이스> Op. 39' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:754505ae-0fe1-3a25-87dd-a410e281b036'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:d81c8bf6-f122-3d08-af95-11e77057f34e', 3, NULL, 'Waldesgespräch', 'Waldesgespräch', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 29 AND p.title = '연가곡집 <리더크라이스> Op. 39' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:d81c8bf6-f122-3d08-af95-11e77057f34e'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:e2474c84-f5c3-36ae-9ad4-f46f80c5965e', 4, NULL, 'Die Stille', 'Die Stille', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 29 AND p.title = '연가곡집 <리더크라이스> Op. 39' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:e2474c84-f5c3-36ae-9ad4-f46f80c5965e'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:3c2809ea-bd3c-3c0f-ace4-cbeb965678e8', 5, NULL, '달밤 (Mondnacht)', 'Mondnacht', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 29 AND p.title = '연가곡집 <리더크라이스> Op. 39' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:3c2809ea-bd3c-3c0f-ace4-cbeb965678e8'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:59c9c200-401b-352c-ac63-0d314699b9ad', 6, NULL, 'Schöne Fremde', 'Schöne Fremde', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 29 AND p.title = '연가곡집 <리더크라이스> Op. 39' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:59c9c200-401b-352c-ac63-0d314699b9ad'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:dfff586c-ae68-3c5f-8ca3-dba0bf4796ed', 7, NULL, 'Auf einer Burg', 'Auf einer Burg', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 29 AND p.title = '연가곡집 <리더크라이스> Op. 39' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:dfff586c-ae68-3c5f-8ca3-dba0bf4796ed'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:9435eed9-1d1d-3d90-8c64-479e43702956', 8, NULL, 'In der Fremde ("Ich hör'' die Bächlein rauschen")', 'In der Fremde ("Ich hör'' die Bächlein rauschen")', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 29 AND p.title = '연가곡집 <리더크라이스> Op. 39' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:9435eed9-1d1d-3d90-8c64-479e43702956'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:b4ecf55d-9dd7-339c-be09-42ad21978b5b', 9, NULL, 'Wehmut', 'Wehmut', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 29 AND p.title = '연가곡집 <리더크라이스> Op. 39' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:b4ecf55d-9dd7-339c-be09-42ad21978b5b'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:cbc98b7a-700e-385c-b859-6191b121b2f5', 10, NULL, 'Zwielicht', 'Zwielicht', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 29 AND p.title = '연가곡집 <리더크라이스> Op. 39' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:cbc98b7a-700e-385c-b859-6191b121b2f5'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:58884708-60c8-34dd-8d9a-28e64bdf6cfc', 11, NULL, 'Im Walde', 'Im Walde', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 29 AND p.title = '연가곡집 <리더크라이스> Op. 39' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:58884708-60c8-34dd-8d9a-28e64bdf6cfc'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:9d6c9291-7d2b-3fdb-b606-11988064f5be', 12, NULL, 'Frühlingsnacht', 'Frühlingsnacht', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 29 AND p.title = '연가곡집 <리더크라이스> Op. 39' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:9d6c9291-7d2b-3fdb-b606-11988064f5be'
);


-- Op. 40 5개의 가곡 Op. 40

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '5개의 가곡 Op. 40', '5 Lieder, Op. 40', 'album', NULL, 'Op.', '40', 1840, 'manual', 1
FROM composers c
WHERE c.id = 29
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '5개의 가곡 Op. 40'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'db34c3c1-dccc-4476-b85e-eb6489999761'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'db34c3c1-dccc-4476-b85e-eb6489999761'
FROM pieces p
WHERE p.composer_id = 29 AND p.title = '5개의 가곡 Op. 40' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'db34c3c1-dccc-4476-b85e-eb6489999761'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:0a673fd0-7086-3623-a365-34a427511cdc', 1, NULL, 'Märzveilchen', 'Märzveilchen', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 29 AND p.title = '5개의 가곡 Op. 40' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:0a673fd0-7086-3623-a365-34a427511cdc'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:cd17a445-0d12-3ade-ad6a-9a3a35b12eac', 2, NULL, 'Muttertraum', 'Muttertraum', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 29 AND p.title = '5개의 가곡 Op. 40' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:cd17a445-0d12-3ade-ad6a-9a3a35b12eac'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:ab7a7703-89ec-3bb1-bd23-a7fa6c86ebd0', 3, NULL, 'Der Soldat', 'Der Soldat', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 29 AND p.title = '5개의 가곡 Op. 40' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:ab7a7703-89ec-3bb1-bd23-a7fa6c86ebd0'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:505726e4-204b-3c95-a8de-1d9a33457930', 4, NULL, 'Der Spielmann', 'Der Spielmann', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 29 AND p.title = '5개의 가곡 Op. 40' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:505726e4-204b-3c95-a8de-1d9a33457930'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:481eeb1c-6a9f-3b7b-9684-b5b3bbcd5bb1', 5, NULL, 'Verratene Liebe', 'Verratene Liebe', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 29 AND p.title = '5개의 가곡 Op. 40' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:481eeb1c-6a9f-3b7b-9684-b5b3bbcd5bb1'
);


-- Op. 41 현악 4중주 Op. 41

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '현악 4중주 Op. 41', '3 String Quartets, Op. 41', 'album', NULL, 'Op.', '41', 1842, 'manual', 1
FROM composers c
WHERE c.id = 29
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '현악 4중주 Op. 41'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '608c47d7-938d-4030-b4a1-53237d506d3b'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '608c47d7-938d-4030-b4a1-53237d506d3b'
FROM pieces p
WHERE p.composer_id = 29 AND p.title = '현악 4중주 Op. 41' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '608c47d7-938d-4030-b4a1-53237d506d3b'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:4b3ee944-4e80-43ca-86d6-6de662ee68bd', 1, NULL, '현악 4중주 1번 A단조', 'No. 1 in A minor', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 29 AND p.title = '현악 4중주 Op. 41' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:4b3ee944-4e80-43ca-86d6-6de662ee68bd'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:82028d6b-9474-4c21-850b-7e80a3d51b5b', 1, 'I', '서주. Andante espressivo – Allegro', 'I. Introduzione. Andante espressivo – Allegro', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:4b3ee944-4e80-43ca-86d6-6de662ee68bd'
WHERE p.composer_id = 29 AND p.title = '현악 4중주 Op. 41' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:82028d6b-9474-4c21-850b-7e80a3d51b5b'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:e7e63240-f1d0-4456-be14-59c16df54252', 2, 'II', '스케르초. Presto', 'II. Scherzo. Presto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:4b3ee944-4e80-43ca-86d6-6de662ee68bd'
WHERE p.composer_id = 29 AND p.title = '현악 4중주 Op. 41' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:e7e63240-f1d0-4456-be14-59c16df54252'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:031af152-6ce2-4e63-8e3e-7e5b25047254', 3, 'III', 'Adagio', 'III. Adagio', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:4b3ee944-4e80-43ca-86d6-6de662ee68bd'
WHERE p.composer_id = 29 AND p.title = '현악 4중주 Op. 41' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:031af152-6ce2-4e63-8e3e-7e5b25047254'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:82120c5a-cfe0-43bc-a164-126591b618c6', 4, 'IV', 'Presto', 'IV. Presto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:4b3ee944-4e80-43ca-86d6-6de662ee68bd'
WHERE p.composer_id = 29 AND p.title = '현악 4중주 Op. 41' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:82120c5a-cfe0-43bc-a164-126591b618c6'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:b8726a39-a6d4-44b4-921c-2a0fddd2a07c', 2, NULL, '현악 4중주 2번 F장조', 'No. 2 in F major', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 29 AND p.title = '현악 4중주 Op. 41' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:b8726a39-a6d4-44b4-921c-2a0fddd2a07c'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:02e81c87-09d3-4083-ae7f-9f73ff6c04b2', 1, 'I', 'Allegro vivace', 'I. Allegro vivace', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:b8726a39-a6d4-44b4-921c-2a0fddd2a07c'
WHERE p.composer_id = 29 AND p.title = '현악 4중주 Op. 41' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:02e81c87-09d3-4083-ae7f-9f73ff6c04b2'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:56c50af8-9c74-4342-bcaa-d70f773cf3a7', 2, 'II', 'Andante, quasi variazioni', 'II. Andante, quasi variazioni', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:b8726a39-a6d4-44b4-921c-2a0fddd2a07c'
WHERE p.composer_id = 29 AND p.title = '현악 4중주 Op. 41' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:56c50af8-9c74-4342-bcaa-d70f773cf3a7'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:838e3f16-d4cf-4d9b-86f6-3269c7b35b70', 3, 'III', '스케르초. Presto – Trio – L''istesso tempo', 'III. Scherzo. Presto – Trio – L''istesso tempo', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:b8726a39-a6d4-44b4-921c-2a0fddd2a07c'
WHERE p.composer_id = 29 AND p.title = '현악 4중주 Op. 41' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:838e3f16-d4cf-4d9b-86f6-3269c7b35b70'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:39e1e2d0-7d27-4db8-b676-daf9f3d48e16', 4, 'IV', 'Allegro molto vivace', 'IV. Allegro molto vivace', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:b8726a39-a6d4-44b4-921c-2a0fddd2a07c'
WHERE p.composer_id = 29 AND p.title = '현악 4중주 Op. 41' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:39e1e2d0-7d27-4db8-b676-daf9f3d48e16'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:88d18be7-01fc-4a53-8750-adb6ec354354', 3, NULL, '현악 4중주 3번 A장조', 'No. 3 in A major', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 29 AND p.title = '현악 4중주 Op. 41' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:88d18be7-01fc-4a53-8750-adb6ec354354'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:bac1682b-8369-438c-95b0-19212e658cbb', 1, 'I', 'Andante espressivo – Allegro molto moderato', 'I. Andante espressivo – Allegro molto moderato', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:88d18be7-01fc-4a53-8750-adb6ec354354'
WHERE p.composer_id = 29 AND p.title = '현악 4중주 Op. 41' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:bac1682b-8369-438c-95b0-19212e658cbb'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:68926180-6a7c-40b0-8c6f-5078e53f7f2f', 2, 'II', 'Assai agitato – Un poco adagio – Tempo risoluto', 'II. Assai agitato – Un poco adagio – Tempo risoluto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:88d18be7-01fc-4a53-8750-adb6ec354354'
WHERE p.composer_id = 29 AND p.title = '현악 4중주 Op. 41' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:68926180-6a7c-40b0-8c6f-5078e53f7f2f'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:7c93b83d-476e-4f92-bca8-1dc23f5f42bf', 3, 'III', 'Adagio molto', 'III. Adagio molto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:88d18be7-01fc-4a53-8750-adb6ec354354'
WHERE p.composer_id = 29 AND p.title = '현악 4중주 Op. 41' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:7c93b83d-476e-4f92-bca8-1dc23f5f42bf'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:33f0f6fa-4f35-4c15-8be0-889a1024be31', 4, 'IV', 'Allegro molto vivace', 'IV. Allegro molto vivace', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:88d18be7-01fc-4a53-8750-adb6ec354354'
WHERE p.composer_id = 29 AND p.title = '현악 4중주 Op. 41' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:33f0f6fa-4f35-4c15-8be0-889a1024be31'
);


-- Op. 42 연가곡집 <여인의 사랑과 생애>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '연가곡집 <여인의 사랑과 생애>', 'Frauenliebe und -leben', 'album', 'Op. 42', NULL, NULL, 1840, 'manual', 1
FROM composers c
WHERE c.id = 29
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '연가곡집 <여인의 사랑과 생애>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'a84f5671-7440-4f85-971b-7ac979d4b855'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'a84f5671-7440-4f85-971b-7ac979d4b855'
FROM pieces p
WHERE p.composer_id = 29 AND p.title = '연가곡집 <여인의 사랑과 생애>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'a84f5671-7440-4f85-971b-7ac979d4b855'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:b2ee7b3d-66f3-3bc6-a9db-cbbb005cf8ff', 1, NULL, 'Seit ich ihn gesehen', 'Seit ich ihn gesehen', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 29 AND p.title = '연가곡집 <여인의 사랑과 생애>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:b2ee7b3d-66f3-3bc6-a9db-cbbb005cf8ff'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:b13fcbcb-4e62-3fca-b2b0-e5d2cedf2dec', 2, NULL, 'Er, der Herrlichste von allen', 'Er, der Herrlichste von allen', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 29 AND p.title = '연가곡집 <여인의 사랑과 생애>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:b13fcbcb-4e62-3fca-b2b0-e5d2cedf2dec'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:eef515aa-1ee8-3e48-9711-a29c996a76d5', 3, NULL, 'Ich kann''s nicht fassen, nicht glauben', 'Ich kann''s nicht fassen, nicht glauben', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 29 AND p.title = '연가곡집 <여인의 사랑과 생애>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:eef515aa-1ee8-3e48-9711-a29c996a76d5'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:a0e46fca-8c84-3d15-95d4-53602c191573', 4, NULL, 'Du Ring an meinem Finger', 'Du Ring an meinem Finger', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 29 AND p.title = '연가곡집 <여인의 사랑과 생애>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:a0e46fca-8c84-3d15-95d4-53602c191573'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:5f8ca9c4-1cd9-3917-9dcd-1cca29e491e4', 5, NULL, 'Helft mir, ihr Schwestern', 'Helft mir, ihr Schwestern', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 29 AND p.title = '연가곡집 <여인의 사랑과 생애>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:5f8ca9c4-1cd9-3917-9dcd-1cca29e491e4'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:fc7bb604-b9e2-3794-aab6-39cb2bf688ef', 6, NULL, 'Süßer Freund, du blickest', 'Süßer Freund, du blickest', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 29 AND p.title = '연가곡집 <여인의 사랑과 생애>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:fc7bb604-b9e2-3794-aab6-39cb2bf688ef'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:0a255c84-0178-3e9f-86af-2033b3f94499', 7, NULL, 'An meinem Herzen, an meiner Brust', 'An meinem Herzen, an meiner Brust', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 29 AND p.title = '연가곡집 <여인의 사랑과 생애>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:0a255c84-0178-3e9f-86af-2033b3f94499'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:66c3a509-4bfc-342f-a6bc-2a80749506a8', 8, NULL, 'Nun hast du mir den ersten Schmerz getan', 'Nun hast du mir den ersten Schmerz getan', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 29 AND p.title = '연가곡집 <여인의 사랑과 생애>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:66c3a509-4bfc-342f-a6bc-2a80749506a8'
);


-- Op. 43 3개의 이중창 Op. 43

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '3개의 이중창 Op. 43', '3 zweistimmige Lieder, Op. 43', 'album', NULL, 'Op.', '43', 1840, 'manual', 1
FROM composers c
WHERE c.id = 29
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '3개의 이중창 Op. 43'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '45f0fc44-56a9-48bf-a7c0-0d775ed72cfd'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '45f0fc44-56a9-48bf-a7c0-0d775ed72cfd'
FROM pieces p
WHERE p.composer_id = 29 AND p.title = '3개의 이중창 Op. 43' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '45f0fc44-56a9-48bf-a7c0-0d775ed72cfd'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:7922238c-a814-4fea-92f1-3f14e04e6098', 1, NULL, 'Wenn ich ein Vöglein wär!', 'Wenn ich ein Vöglein wär!', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 29 AND p.title = '3개의 이중창 Op. 43' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:7922238c-a814-4fea-92f1-3f14e04e6098'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:931fb47e-1307-4251-89ac-e031401feea5', 2, NULL, 'Herbstlied', 'Herbstlied', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 29 AND p.title = '3개의 이중창 Op. 43' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:931fb47e-1307-4251-89ac-e031401feea5'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:f14e50f2-31f8-4612-bd8e-7f9cd85217d1', 3, NULL, 'Schön Blümelein', 'Schön Blümelein', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 29 AND p.title = '3개의 이중창 Op. 43' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:f14e50f2-31f8-4612-bd8e-7f9cd85217d1'
);


-- Op. 44 피아노 5중주 E♭장조

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:a4ca91dd-b768-31ce-9b51-c9265ca4d7a3', 1, 'I', 'Allegro brillante', 'I. Allegro brillante', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 448 AND p.composer_id = 29
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:a4ca91dd-b768-31ce-9b51-c9265ca4d7a3'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:7b3cf7c9-46b1-3398-8fe6-86722d3f388a', 2, 'II', 'In modo d''una marcia. Un poco largamente', 'II. In modo d''una marcia. Un poco largamente', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 448 AND p.composer_id = 29
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:7b3cf7c9-46b1-3398-8fe6-86722d3f388a'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:c708a87c-6429-3fae-9936-5b33e5ff9399', 3, 'III', '스케르초. Molto vivace', 'III. Scherzo. Molto vivace', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 448 AND p.composer_id = 29
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:c708a87c-6429-3fae-9936-5b33e5ff9399'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:df8c421f-d588-3b4f-8344-728ce51de9c4', 4, 'IV', 'Allegro, ma non troppo', 'IV. Allegro, ma non troppo', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 448 AND p.composer_id = 29
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:df8c421f-d588-3b4f-8344-728ce51de9c4'
);


-- Op. 45 로망스와 발라드 1집 Op. 45

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '로망스와 발라드 1집 Op. 45', 'Romanzen und Balladen, Vol. I, Op. 45', 'album', NULL, 'Op.', '45', 1840, 'manual', 1
FROM composers c
WHERE c.id = 29
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '로망스와 발라드 1집 Op. 45'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'f71ea2a8-5d3c-4812-85d5-05cfb58dd716'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'f71ea2a8-5d3c-4812-85d5-05cfb58dd716'
FROM pieces p
WHERE p.composer_id = 29 AND p.title = '로망스와 발라드 1집 Op. 45' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'f71ea2a8-5d3c-4812-85d5-05cfb58dd716'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:9bfe27a9-083b-3738-a745-7929c1108a03', 1, NULL, 'Der Schatzgräber', 'Der Schatzgräber', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 29 AND p.title = '로망스와 발라드 1집 Op. 45' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:9bfe27a9-083b-3738-a745-7929c1108a03'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:ff6deae0-4e7c-3462-a3ec-918fd5db2e90', 2, NULL, 'Frühlingsfahrt', 'Frühlingsfahrt', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 29 AND p.title = '로망스와 발라드 1집 Op. 45' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:ff6deae0-4e7c-3462-a3ec-918fd5db2e90'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:6f605ab4-d9ff-39d8-9d4c-3b3f7a401f2a', 3, NULL, 'Abends am Strand', 'Abends am Strand', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 29 AND p.title = '로망스와 발라드 1집 Op. 45' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:6f605ab4-d9ff-39d8-9d4c-3b3f7a401f2a'
);


-- Op. 46 두 대의 피아노를 위한 안단테와 변주곡 B♭장조

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '두 대의 피아노를 위한 안단테와 변주곡 B♭장조', 'Andante and Variations in B♭ major for two pianos', 'song', 'Op. 46', NULL, NULL, 1843, 'manual', 1
FROM composers c
WHERE c.id = 29
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '두 대의 피아노를 위한 안단테와 변주곡 B♭장조'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'd7de4744-446d-4029-a999-9ac6622f0342'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'd7de4744-446d-4029-a999-9ac6622f0342'
FROM pieces p
WHERE p.composer_id = 29 AND p.title = '두 대의 피아노를 위한 안단테와 변주곡 B♭장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'd7de4744-446d-4029-a999-9ac6622f0342'
);


-- Op. 47 피아노 4중주 E♭장조

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '피아노 4중주 E♭장조', 'Piano Quartet in E♭ major', 'album', 'Op. 47', NULL, NULL, 1842, 'manual', 1
FROM composers c
WHERE c.id = 29
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '피아노 4중주 E♭장조'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'efcc3125-046d-4cdc-856b-6e3bbd223a2e'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'efcc3125-046d-4cdc-856b-6e3bbd223a2e'
FROM pieces p
WHERE p.composer_id = 29 AND p.title = '피아노 4중주 E♭장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'efcc3125-046d-4cdc-856b-6e3bbd223a2e'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:144e7625-6f90-3c4b-9328-841af8b21984', 1, 'I', 'Sostenuto assai – Allegro ma non troppo', 'I. Sostenuto assai – Allegro ma non troppo', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 29 AND p.title = '피아노 4중주 E♭장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:144e7625-6f90-3c4b-9328-841af8b21984'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:97690c2c-339e-3b8c-a93d-3afc7335b4b8', 2, 'II', '스케르초. Molto vivace – Trio I – Trio II', 'II. Scherzo. Molto vivace – Trio I – Trio II', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 29 AND p.title = '피아노 4중주 E♭장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:97690c2c-339e-3b8c-a93d-3afc7335b4b8'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:07796b99-cf79-3436-96dc-d7b58b2e3253', 3, 'III', 'Andante cantabile', 'III. Andante cantabile', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 29 AND p.title = '피아노 4중주 E♭장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:07796b99-cf79-3436-96dc-d7b58b2e3253'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:697cfd0b-f904-3980-a576-dbca3a3eb231', 4, 'IV', '피날레. Vivace', 'IV. Finale. Vivace', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 29 AND p.title = '피아노 4중주 E♭장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:697cfd0b-f904-3980-a576-dbca3a3eb231'
);


-- Op. 48 연가곡집 <시인의 사랑>

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '9416f9f5-d5aa-472b-a7c5-0038bfae7412'
FROM pieces p
WHERE p.id = 134 AND p.composer_id = 29
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '9416f9f5-d5aa-472b-a7c5-0038bfae7412'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:d359381f-ec30-3377-afd9-d53472549e23', 1, NULL, '아름다운 5월에 (Im wunderschönen Monat Mai)', 'Im wunderschönen Monat Mai', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 134 AND p.composer_id = 29
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:d359381f-ec30-3377-afd9-d53472549e23'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:5c5c5fc9-dfaf-377b-93f2-50d92dc9486e', 2, NULL, 'Aus meinen Tränen sprießen', 'Aus meinen Tränen sprießen', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 134 AND p.composer_id = 29
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:5c5c5fc9-dfaf-377b-93f2-50d92dc9486e'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:7a62ba25-be73-34f6-8e60-3646e2f7c146', 3, NULL, 'Die Rose, die Lilie, die Taube, die Sonne', 'Die Rose, die Lilie, die Taube, die Sonne', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 134 AND p.composer_id = 29
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:7a62ba25-be73-34f6-8e60-3646e2f7c146'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:946135dc-a35a-31a6-9a3d-4cb0c5c801fa', 4, NULL, 'Wenn ich in deine Augen seh''', 'Wenn ich in deine Augen seh''', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 134 AND p.composer_id = 29
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:946135dc-a35a-31a6-9a3d-4cb0c5c801fa'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:9e86ef80-cce7-316b-95c5-95d2686202b8', 5, NULL, 'Ich will meine Seele tauchen', 'Ich will meine Seele tauchen', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 134 AND p.composer_id = 29
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:9e86ef80-cce7-316b-95c5-95d2686202b8'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:f8c88412-574a-3b71-8be5-317dbe850d3d', 6, NULL, 'Im Rhein, im heiligen Strome', 'Im Rhein, im heiligen Strome', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 134 AND p.composer_id = 29
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:f8c88412-574a-3b71-8be5-317dbe850d3d'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:564410f4-ebfc-3646-9560-3e020cc0dfd9', 7, NULL, '나는 원망하지 않으리 (Ich grolle nicht)', 'Ich grolle nicht', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 134 AND p.composer_id = 29
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:564410f4-ebfc-3646-9560-3e020cc0dfd9'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:0a3e723c-59a0-30b8-80c7-2bdd4ae28843', 8, NULL, 'Und wüssten''s die Blumen, die kleinen', 'Und wüssten''s die Blumen, die kleinen', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 134 AND p.composer_id = 29
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:0a3e723c-59a0-30b8-80c7-2bdd4ae28843'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:2e0c98c1-578b-3304-ac6d-c829de4669c3', 9, NULL, 'Das ist ein Flöten und Geigen', 'Das ist ein Flöten und Geigen', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 134 AND p.composer_id = 29
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:2e0c98c1-578b-3304-ac6d-c829de4669c3'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:e558735b-3901-3407-aa2b-3d4a83395382', 10, NULL, 'Hör'' ich das Liedchen klingen', 'Hör'' ich das Liedchen klingen', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 134 AND p.composer_id = 29
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:e558735b-3901-3407-aa2b-3d4a83395382'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:67b2a3a3-0bcd-3238-af75-76072280c5ec', 11, NULL, 'Ein Jüngling liebt ein Mädchen', 'Ein Jüngling liebt ein Mädchen', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 134 AND p.composer_id = 29
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:67b2a3a3-0bcd-3238-af75-76072280c5ec'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:aec15bb6-ac3e-33a2-aa38-362e1f1c6f9d', 12, NULL, 'Am leuchtenden Sommermorgen', 'Am leuchtenden Sommermorgen', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 134 AND p.composer_id = 29
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:aec15bb6-ac3e-33a2-aa38-362e1f1c6f9d'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:e817fd41-4ce0-33dd-bcbe-6a930b1da296', 13, NULL, 'Ich hab'' im Traum geweinet', 'Ich hab'' im Traum geweinet', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 134 AND p.composer_id = 29
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:e817fd41-4ce0-33dd-bcbe-6a930b1da296'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:be19b29f-88a3-39d7-b492-45bf2c739941', 14, NULL, 'Allnächtlich im Traume', 'Allnächtlich im Traume', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 134 AND p.composer_id = 29
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:be19b29f-88a3-39d7-b492-45bf2c739941'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:344394b6-bf43-390c-b0da-44d00b265ac7', 15, NULL, 'Aus alten Märchen winkt es', 'Aus alten Märchen winkt es', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 134 AND p.composer_id = 29
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:344394b6-bf43-390c-b0da-44d00b265ac7'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:2c9412ed-5cf4-33f5-93cc-24abefeaa179', 16, NULL, 'Die alten, bösen Lieder', 'Die alten, bösen Lieder', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 134 AND p.composer_id = 29
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:2c9412ed-5cf4-33f5-93cc-24abefeaa179'
);


-- Op. 49 로망스와 발라드 2집 Op. 49

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '로망스와 발라드 2집 Op. 49', 'Romanzen und Balladen, Vol. II, Op. 49', 'album', NULL, 'Op.', '49', 1840, 'manual', 1
FROM composers c
WHERE c.id = 29
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '로망스와 발라드 2집 Op. 49'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'f9ccbe6b-3553-4b40-bc3a-dfc21933d3b8'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'f9ccbe6b-3553-4b40-bc3a-dfc21933d3b8'
FROM pieces p
WHERE p.composer_id = 29 AND p.title = '로망스와 발라드 2집 Op. 49' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'f9ccbe6b-3553-4b40-bc3a-dfc21933d3b8'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:1c0b469b-5b0e-3c32-949e-d0477b607641', 1, NULL, '두 사람의 척탄병 (Die beiden Grenadiere)', 'Die beiden Grenadiere', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 29 AND p.title = '로망스와 발라드 2집 Op. 49' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:1c0b469b-5b0e-3c32-949e-d0477b607641'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:60140a5b-ffab-3e5c-ad80-0e32eb85db9a', 2, NULL, 'Die feindlichen Brüder', 'Die feindlichen Brüder', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 29 AND p.title = '로망스와 발라드 2집 Op. 49' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:60140a5b-ffab-3e5c-ad80-0e32eb85db9a'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:99a99004-f8a1-4b9e-9813-20d4cf15f73b', 3, NULL, 'Die Nonne', 'Die Nonne', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 29 AND p.title = '로망스와 발라드 2집 Op. 49' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:99a99004-f8a1-4b9e-9813-20d4cf15f73b'
);


-- Op. 50 오라토리오 <낙원과 페리>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '오라토리오 <낙원과 페리>', 'Das Paradies und die Peri', 'song', 'Op. 50', NULL, NULL, 1843, 'manual', 1
FROM composers c
WHERE c.id = 29
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '오라토리오 <낙원과 페리>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'dc9b3aa4-0caa-4ffc-aa0f-d90a427d2551'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'dc9b3aa4-0caa-4ffc-aa0f-d90a427d2551'
FROM pieces p
WHERE p.composer_id = 29 AND p.title = '오라토리오 <낙원과 페리>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'dc9b3aa4-0caa-4ffc-aa0f-d90a427d2551'
);


-- Op. 51 가곡과 노래 2집 Op. 51

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '가곡과 노래 2집 Op. 51', 'Lieder und Gesänge, Vol. II, Op. 51', 'album', NULL, 'Op.', '51', 1842, 'manual', 1
FROM composers c
WHERE c.id = 29
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '가곡과 노래 2집 Op. 51'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '0ef6b225-2348-4b06-8432-8fc5aea666f9'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '0ef6b225-2348-4b06-8432-8fc5aea666f9'
FROM pieces p
WHERE p.composer_id = 29 AND p.title = '가곡과 노래 2집 Op. 51' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '0ef6b225-2348-4b06-8432-8fc5aea666f9'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:1e689af4-5289-4b24-a3f7-bc31329a614c', 1, NULL, 'Sehnsucht', 'Sehnsucht', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 29 AND p.title = '가곡과 노래 2집 Op. 51' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:1e689af4-5289-4b24-a3f7-bc31329a614c'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:d28b7f28-8dfd-4ad1-aa57-1f6b713434cc', 2, NULL, 'Volksliedchen', 'Volksliedchen', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 29 AND p.title = '가곡과 노래 2집 Op. 51' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:d28b7f28-8dfd-4ad1-aa57-1f6b713434cc'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:a650742b-a328-4f7d-965f-00e95530d9bd', 3, NULL, 'Ich wandre nicht', 'Ich wandre nicht', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 29 AND p.title = '가곡과 노래 2집 Op. 51' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:a650742b-a328-4f7d-965f-00e95530d9bd'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:7c1633d9-e96c-3c8c-a339-dfe2a99c4a27', 4, NULL, 'Auf dem Rhein', 'Auf dem Rhein', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 29 AND p.title = '가곡과 노래 2집 Op. 51' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:7c1633d9-e96c-3c8c-a339-dfe2a99c4a27'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:ab3522f4-eb97-4ed9-ad5a-44661ebc89a9', 5, NULL, 'Liebeslied', 'Liebeslied', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 29 AND p.title = '가곡과 노래 2집 Op. 51' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:ab3522f4-eb97-4ed9-ad5a-44661ebc89a9'
);


-- Op. 52 서곡, 스케르초와 피날레 E장조

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '서곡, 스케르초와 피날레 E장조', 'Overture, Scherzo and Finale in E major', 'album', 'Op. 52', NULL, NULL, 1841, 'manual', 1
FROM composers c
WHERE c.id = 29
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '서곡, 스케르초와 피날레 E장조'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '7b0abc31-99b9-4487-aaf9-f0c44a6cc3eb'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '7b0abc31-99b9-4487-aaf9-f0c44a6cc3eb'
FROM pieces p
WHERE p.composer_id = 29 AND p.title = '서곡, 스케르초와 피날레 E장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '7b0abc31-99b9-4487-aaf9-f0c44a6cc3eb'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:1a4186da-0013-3588-8773-b971f48cadf2', 1, 'I', '서곡. Andante con moto – Allegro', 'I. Overture. Andante con moto – Allegro', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 29 AND p.title = '서곡, 스케르초와 피날레 E장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:1a4186da-0013-3588-8773-b971f48cadf2'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:d97b3af8-60eb-3a8f-83d1-19a867733f1f', 2, 'II', '스케르초. Vivo', 'II. Scherzo. Vivo', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 29 AND p.title = '서곡, 스케르초와 피날레 E장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:d97b3af8-60eb-3a8f-83d1-19a867733f1f'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:9467cff4-21c3-37ab-bf4e-6c1782ccdd71', 3, 'III', '피날레. Allegro molto vivace', 'III. Finale. Allegro molto vivace', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 29 AND p.title = '서곡, 스케르초와 피날레 E장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:9467cff4-21c3-37ab-bf4e-6c1782ccdd71'
);


-- Op. 53 로망스와 발라드 3집 Op. 53

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '로망스와 발라드 3집 Op. 53', 'Romanzen und Balladen, Vol. III, Op. 53', 'album', NULL, 'Op.', '53', 1840, 'manual', 1
FROM composers c
WHERE c.id = 29
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '로망스와 발라드 3집 Op. 53'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '901b3854-2568-4462-9043-e5ce97250b77'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '901b3854-2568-4462-9043-e5ce97250b77'
FROM pieces p
WHERE p.composer_id = 29 AND p.title = '로망스와 발라드 3집 Op. 53' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '901b3854-2568-4462-9043-e5ce97250b77'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:2bdfe999-3c45-3f4b-b47f-638f49a49dce', 1, NULL, 'Blondels Lied', 'Blondels Lied', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 29 AND p.title = '로망스와 발라드 3집 Op. 53' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:2bdfe999-3c45-3f4b-b47f-638f49a49dce'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:f0025503-c1be-31d3-98d4-99ce5cbc61d9', 2, NULL, 'Loreley', 'Loreley', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 29 AND p.title = '로망스와 발라드 3집 Op. 53' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:f0025503-c1be-31d3-98d4-99ce5cbc61d9'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:969ebd61-0b9c-4a6f-b670-d22e9a417693', 3, NULL, 'Der arme Peter', 'Der arme Peter', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 29 AND p.title = '로망스와 발라드 3집 Op. 53' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:969ebd61-0b9c-4a6f-b670-d22e9a417693'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:4211280d-cb91-37cc-aa0f-aeedcae32dfb', 1, 'I', 'Der Hans und die Grete tanzen herum', 'Der Hans und die Grete tanzen herum', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:969ebd61-0b9c-4a6f-b670-d22e9a417693'
WHERE p.composer_id = 29 AND p.title = '로망스와 발라드 3집 Op. 53' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:4211280d-cb91-37cc-aa0f-aeedcae32dfb'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:3cdc1867-ff0b-37a2-bd05-34c198584788', 2, 'II', 'In meiner Brust, da sitzt ein Weh', 'In meiner Brust, da sitzt ein Weh', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:969ebd61-0b9c-4a6f-b670-d22e9a417693'
WHERE p.composer_id = 29 AND p.title = '로망스와 발라드 3집 Op. 53' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:3cdc1867-ff0b-37a2-bd05-34c198584788'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:20c407d5-a67c-3564-8f1f-ab27fe8304a2', 3, 'III', 'Der arme Peter wankt vorbei', 'Der arme Peter wankt vorbei', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:969ebd61-0b9c-4a6f-b670-d22e9a417693'
WHERE p.composer_id = 29 AND p.title = '로망스와 발라드 3집 Op. 53' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:20c407d5-a67c-3564-8f1f-ab27fe8304a2'
);


-- Op. 54 피아노 협주곡 A단조

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '0883b91a-f2c5-32b1-befb-f009af0ffbd7'
FROM pieces p
WHERE p.id = 136 AND p.composer_id = 29
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '0883b91a-f2c5-32b1-befb-f009af0ffbd7'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:5da1e3dd-6adf-3bbd-9f18-3dd72a535c63', 1, 'I', 'Allegro affettuoso', 'I. Allegro affettuoso', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 136 AND p.composer_id = 29
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:5da1e3dd-6adf-3bbd-9f18-3dd72a535c63'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:bb636e91-b4ec-3e94-bb09-0e5757a5d178', 2, 'II', '간주곡. Andantino grazioso', 'II. Intermezzo. Andantino grazioso', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 136 AND p.composer_id = 29
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:bb636e91-b4ec-3e94-bb09-0e5757a5d178'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:d99878bf-924d-3709-b4f0-9e573014b3fd', 3, 'III', 'Allegro vivace', 'III. Allegro vivace', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 136 AND p.composer_id = 29
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:d99878bf-924d-3709-b4f0-9e573014b3fd'
);


-- Op. 55 번스 시에 의한 5개의 합창곡 Op. 55

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '번스 시에 의한 5개의 합창곡 Op. 55', '5 Lieder nach Robert Burns, Op. 55', 'album', NULL, 'Op.', '55', 1846, 'manual', 1
FROM composers c
WHERE c.id = 29
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '번스 시에 의한 5개의 합창곡 Op. 55'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '79c3a9e8-0307-4e90-b135-041ea0b6fcc7'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '79c3a9e8-0307-4e90-b135-041ea0b6fcc7'
FROM pieces p
WHERE p.composer_id = 29 AND p.title = '번스 시에 의한 5개의 합창곡 Op. 55' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '79c3a9e8-0307-4e90-b135-041ea0b6fcc7'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:a09b8625-bd8b-402e-8f46-2cb68f13ff4c', 1, NULL, 'Das Hochlandmädchen', 'Das Hochlandmädchen', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 29 AND p.title = '번스 시에 의한 5개의 합창곡 Op. 55' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:a09b8625-bd8b-402e-8f46-2cb68f13ff4c'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:25f3b489-dd1e-37af-986d-e15178c0ccba', 2, NULL, 'Zahnweh', 'Zahnweh', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 29 AND p.title = '번스 시에 의한 5개의 합창곡 Op. 55' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:25f3b489-dd1e-37af-986d-e15178c0ccba'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:b7078e63-01a2-450c-9414-54a939b38ef8', 3, NULL, 'Mich zieht es nach dem Dörfchen hin', 'Mich zieht es nach dem Dörfchen hin', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 29 AND p.title = '번스 시에 의한 5개의 합창곡 Op. 55' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:b7078e63-01a2-450c-9414-54a939b38ef8'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:96efa37a-2674-4804-8bdc-bfd9d6345787', 4, NULL, 'Die alte gute Zeit', 'Die alte gute Zeit', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 29 AND p.title = '번스 시에 의한 5개의 합창곡 Op. 55' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:96efa37a-2674-4804-8bdc-bfd9d6345787'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:409ac589-03a1-409f-b884-22f170768aa2', 5, NULL, 'Hochlandbursch', 'Hochlandbursch', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 29 AND p.title = '번스 시에 의한 5개의 합창곡 Op. 55' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:409ac589-03a1-409f-b884-22f170768aa2'
);


-- Op. 56 카논 형식의 연습곡 Op. 56

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '카논 형식의 연습곡 Op. 56', '6 Studies in Canonic Form, Op. 56', 'album', NULL, 'Op.', '56', 1845, 'manual', 1
FROM composers c
WHERE c.id = 29
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '카논 형식의 연습곡 Op. 56'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'aaa537df-fa01-456a-b363-e173bd0e6f8b'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'aaa537df-fa01-456a-b363-e173bd0e6f8b'
FROM pieces p
WHERE p.composer_id = 29 AND p.title = '카논 형식의 연습곡 Op. 56' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'aaa537df-fa01-456a-b363-e173bd0e6f8b'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:c965fc1a-11bb-3a2d-8add-9a9ed925fced', 1, NULL, 'Pas trop vite', 'No. 1. Pas trop vite', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 29 AND p.title = '카논 형식의 연습곡 Op. 56' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:c965fc1a-11bb-3a2d-8add-9a9ed925fced'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:170d664a-fa15-3307-a0f6-67316aa6d2dc', 2, NULL, 'Avec beaucoup d''expression', 'No. 2. Avec beaucoup d''expression', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 29 AND p.title = '카논 형식의 연습곡 Op. 56' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:170d664a-fa15-3307-a0f6-67316aa6d2dc'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:ba2b750e-a09e-3dc4-b0a6-a7ce5a710684', 3, NULL, 'Andantino', 'No. 3. Andantino', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 29 AND p.title = '카논 형식의 연습곡 Op. 56' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:ba2b750e-a09e-3dc4-b0a6-a7ce5a710684'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:e4d5d73e-cc92-32a1-886d-ac6aa1e2d21d', 4, NULL, 'Espressivo', 'No. 4. Espressivo', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 29 AND p.title = '카논 형식의 연습곡 Op. 56' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:e4d5d73e-cc92-32a1-886d-ac6aa1e2d21d'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:8ba6942d-2754-3ea6-b608-022d2b6ec8a8', 5, NULL, 'Pas trop vite', 'No. 5. Pas trop vite', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 29 AND p.title = '카논 형식의 연습곡 Op. 56' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:8ba6942d-2754-3ea6-b608-022d2b6ec8a8'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:56524ec6-fb61-3a8b-85ec-2378de525e02', 6, NULL, 'Adagio', 'No. 6. Adagio', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 29 AND p.title = '카논 형식의 연습곡 Op. 56' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:56524ec6-fb61-3a8b-85ec-2378de525e02'
);


-- Op. 57 발라드 <벨사차르>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '발라드 <벨사차르>', 'Belsatzar', 'song', 'Op. 57', NULL, NULL, 1840, 'manual', 1
FROM composers c
WHERE c.id = 29
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '발라드 <벨사차르>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '16f65159-c4b1-3fdb-b44d-6f1f4ecca446'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '16f65159-c4b1-3fdb-b44d-6f1f4ecca446'
FROM pieces p
WHERE p.composer_id = 29 AND p.title = '발라드 <벨사차르>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '16f65159-c4b1-3fdb-b44d-6f1f4ecca446'
);


-- Op. 58 스케치 Op. 58

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '스케치 Op. 58', '4 Sketches, Op. 58', 'album', NULL, 'Op.', '58', 1845, 'manual', 1
FROM composers c
WHERE c.id = 29
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '스케치 Op. 58'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'bf643229-ff26-485e-b992-fdbde6bab913'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'bf643229-ff26-485e-b992-fdbde6bab913'
FROM pieces p
WHERE p.composer_id = 29 AND p.title = '스케치 Op. 58' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'bf643229-ff26-485e-b992-fdbde6bab913'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:e2e8caec-d708-4d7a-986c-e6016a3f104e', 1, NULL, 'C단조. Nicht schnell und sehr markirt', 'No. 1 in C minor. Nicht schnell und sehr markirt', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 29 AND p.title = '스케치 Op. 58' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:e2e8caec-d708-4d7a-986c-e6016a3f104e'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:524a6cd7-2573-4e83-9ee9-ffe6d916b4d0', 2, NULL, 'C장조. Nicht schnell und sehr markirt', 'No. 2 in C major. Nicht schnell und sehr markirt', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 29 AND p.title = '스케치 Op. 58' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:524a6cd7-2573-4e83-9ee9-ffe6d916b4d0'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:7fe99302-8934-4371-a2d4-88e9d3fa48b3', 3, NULL, 'F단조. Lebhaft', 'No. 3 in F minor. Lebhaft', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 29 AND p.title = '스케치 Op. 58' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:7fe99302-8934-4371-a2d4-88e9d3fa48b3'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:4690842c-1b99-4d75-a111-03af4ddc67bf', 4, NULL, 'D♭장조. Allegretto', 'No. 4 in D♭ major. Allegretto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 29 AND p.title = '스케치 Op. 58' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:4690842c-1b99-4d75-a111-03af4ddc67bf'
);


-- Op. 59 4개의 합창곡 Op. 59

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '4개의 합창곡 Op. 59', '4 Gesänge, Op. 59', 'album', NULL, 'Op.', '59', 1846, 'manual', 1
FROM composers c
WHERE c.id = 29
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '4개의 합창곡 Op. 59'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'd3e3477c-4c05-4d38-a125-2f952e2ae6d5'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'd3e3477c-4c05-4d38-a125-2f952e2ae6d5'
FROM pieces p
WHERE p.composer_id = 29 AND p.title = '4개의 합창곡 Op. 59' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'd3e3477c-4c05-4d38-a125-2f952e2ae6d5'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:57e4ec74-b0c1-4f87-b086-4c5b52052981', 1, NULL, 'Nord oder Süd', 'Nord oder Süd', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 29 AND p.title = '4개의 합창곡 Op. 59' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:57e4ec74-b0c1-4f87-b086-4c5b52052981'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:c37a96c4-dc66-4039-9745-6f00eb207e23', 2, NULL, 'Am Bodensee', 'Am Bodensee', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 29 AND p.title = '4개의 합창곡 Op. 59' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:c37a96c4-dc66-4039-9745-6f00eb207e23'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:6a21de73-2240-4031-aa62-a1ea5c0b3109', 3, NULL, 'Jägerlied', 'Jägerlied', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 29 AND p.title = '4개의 합창곡 Op. 59' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:6a21de73-2240-4031-aa62-a1ea5c0b3109'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:3c5ec595-5751-4b9d-bf59-c31f2a6a93b9', 4, NULL, 'Gute Nacht', 'Gute Nacht', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 29 AND p.title = '4개의 합창곡 Op. 59' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:3c5ec595-5751-4b9d-bf59-c31f2a6a93b9'
);


-- Op. 60 B-A-C-H에 의한 푸가 Op. 60

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, 'B-A-C-H에 의한 푸가 Op. 60', '6 Fugues on B-A-C-H, Op. 60', 'album', NULL, 'Op.', '60', 1845, 'manual', 1
FROM composers c
WHERE c.id = 29
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = 'B-A-C-H에 의한 푸가 Op. 60'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '586465f3-2d72-4504-8e72-5f7709225b8d'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '586465f3-2d72-4504-8e72-5f7709225b8d'
FROM pieces p
WHERE p.composer_id = 29 AND p.title = 'B-A-C-H에 의한 푸가 Op. 60' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '586465f3-2d72-4504-8e72-5f7709225b8d'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:511a5b25-9fcc-4ef2-93b3-e4ef19af48ba', 1, NULL, 'B♭장조', 'No. 1 in B♭ major', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 29 AND p.title = 'B-A-C-H에 의한 푸가 Op. 60' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:511a5b25-9fcc-4ef2-93b3-e4ef19af48ba'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:8f82fba0-1a95-4bdd-a5a7-1837c4f6946b', 2, NULL, 'B♭장조', 'No. 2 in B♭ major', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 29 AND p.title = 'B-A-C-H에 의한 푸가 Op. 60' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:8f82fba0-1a95-4bdd-a5a7-1837c4f6946b'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:87c019d5-c5a3-46b3-b6ad-e4256d8636ed', 3, NULL, 'G단조', 'No. 3 in G minor', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 29 AND p.title = 'B-A-C-H에 의한 푸가 Op. 60' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:87c019d5-c5a3-46b3-b6ad-e4256d8636ed'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:49e04e26-4048-40ea-8dcb-b7f9ebc8014e', 4, NULL, 'B♭장조', 'No. 4 in B♭ major', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 29 AND p.title = 'B-A-C-H에 의한 푸가 Op. 60' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:49e04e26-4048-40ea-8dcb-b7f9ebc8014e'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:1a38ba60-42b3-4ee8-beda-ef98942bf3a9', 5, NULL, 'F장조', 'No. 5 in F major', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 29 AND p.title = 'B-A-C-H에 의한 푸가 Op. 60' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:1a38ba60-42b3-4ee8-beda-ef98942bf3a9'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:af00ed37-1a85-45a6-86cf-4c3328a2fbb7', 6, NULL, 'B♭장조', 'No. 6 in B♭ major', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 29 AND p.title = 'B-A-C-H에 의한 푸가 Op. 60' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:af00ed37-1a85-45a6-86cf-4c3328a2fbb7'
);


-- Op. 61 교향곡 2번 C장조

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '교향곡 2번 C장조', 'Symphony No. 2 in C major', 'album', 'Op. 61', NULL, NULL, 1846, 'manual', 1
FROM composers c
WHERE c.id = 29
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '교향곡 2번 C장조'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '46f8f519-c3a8-4ec7-b204-f6aa35acaf5e'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '46f8f519-c3a8-4ec7-b204-f6aa35acaf5e'
FROM pieces p
WHERE p.composer_id = 29 AND p.title = '교향곡 2번 C장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '46f8f519-c3a8-4ec7-b204-f6aa35acaf5e'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:6e280809-c1f9-3bea-9b72-85bcbe191209', 1, 'I', 'Sostenuto assai – Un poco più vivace – Allegro ma non troppo – Con fuoco', 'I. Sostenuto assai – Un poco più vivace – Allegro ma non troppo – Con fuoco', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 29 AND p.title = '교향곡 2번 C장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:6e280809-c1f9-3bea-9b72-85bcbe191209'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:28beb94d-b7a3-306c-bb47-800eb41967cc', 2, 'II', '스케르초. Allegro vivace', 'II. Scherzo. Allegro vivace', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 29 AND p.title = '교향곡 2번 C장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:28beb94d-b7a3-306c-bb47-800eb41967cc'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:e93bbadb-3a7a-3cbb-aeeb-ce8078d56ea6', 3, 'III', 'Adagio espressivo', 'III. Adagio espressivo', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 29 AND p.title = '교향곡 2번 C장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:e93bbadb-3a7a-3cbb-aeeb-ce8078d56ea6'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:5fc59147-b4c5-34fd-bd5a-2f13d64ec1c0', 4, 'IV', 'Allegro molto vivace', 'IV. Allegro molto vivace', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 29 AND p.title = '교향곡 2번 C장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:5fc59147-b4c5-34fd-bd5a-2f13d64ec1c0'
);


-- Op. 62 3개의 남성 합창곡 Op. 62

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '3개의 남성 합창곡 Op. 62', '3 Gesänge for male chorus, Op. 62', 'album', NULL, 'Op.', '62', 1847, 'manual', 1
FROM composers c
WHERE c.id = 29
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '3개의 남성 합창곡 Op. 62'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '139f01f9-06e1-46fb-8ae6-e1ad2207d7fd'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '139f01f9-06e1-46fb-8ae6-e1ad2207d7fd'
FROM pieces p
WHERE p.composer_id = 29 AND p.title = '3개의 남성 합창곡 Op. 62' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '139f01f9-06e1-46fb-8ae6-e1ad2207d7fd'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:533d2e38-b20f-47fd-aa33-2e4013ef1a4c', 1, NULL, 'Der Eidgenossen Nachtwache', 'Der Eidgenossen Nachtwache', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 29 AND p.title = '3개의 남성 합창곡 Op. 62' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:533d2e38-b20f-47fd-aa33-2e4013ef1a4c'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:d5e1b82e-ed9b-46c5-901f-a9dd0668062c', 2, NULL, 'Freiheitslied', 'Freiheitslied', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 29 AND p.title = '3개의 남성 합창곡 Op. 62' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:d5e1b82e-ed9b-46c5-901f-a9dd0668062c'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:5275f31b-a304-47e4-b4cc-f3c43d5c0bf9', 3, NULL, 'Schlachtgesang', 'Schlachtgesang', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 29 AND p.title = '3개의 남성 합창곡 Op. 62' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:5275f31b-a304-47e4-b4cc-f3c43d5c0bf9'
);


-- Op. 63 피아노 3중주 1번 D단조

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '피아노 3중주 1번 D단조', 'Piano Trio No. 1 in D minor', 'album', 'Op. 63', NULL, NULL, 1847, 'manual', 1
FROM composers c
WHERE c.id = 29
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '피아노 3중주 1번 D단조'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '31d85eb7-fd28-4503-9d45-06bdf46a13fd'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '31d85eb7-fd28-4503-9d45-06bdf46a13fd'
FROM pieces p
WHERE p.composer_id = 29 AND p.title = '피아노 3중주 1번 D단조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '31d85eb7-fd28-4503-9d45-06bdf46a13fd'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:f972d4f8-c1dd-39ad-9ef3-da9ffa25c909', 1, 'I', 'Mit Energie und Leidenschaft', 'I. Mit Energie und Leidenschaft', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 29 AND p.title = '피아노 3중주 1번 D단조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:f972d4f8-c1dd-39ad-9ef3-da9ffa25c909'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:0f609f67-2f49-32da-9a36-3dad1a47fd1a', 2, 'II', 'Lebhaft, doch nicht zu rasch', 'II. Lebhaft, doch nicht zu rasch', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 29 AND p.title = '피아노 3중주 1번 D단조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:0f609f67-2f49-32da-9a36-3dad1a47fd1a'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:a40361c0-47db-3a60-99b1-282633686843', 3, 'III', 'Langsam, mit inniger Empfindung', 'III. Langsam, mit inniger Empfindung', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 29 AND p.title = '피아노 3중주 1번 D단조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:a40361c0-47db-3a60-99b1-282633686843'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:76178a3f-a4e3-37f1-a550-be6f999da4c8', 4, 'IV', 'Mit Feuer', 'IV. Mit Feuer', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 29 AND p.title = '피아노 3중주 1번 D단조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:76178a3f-a4e3-37f1-a550-be6f999da4c8'
);


-- Op. 64 로망스와 발라드 4집 Op. 64

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '로망스와 발라드 4집 Op. 64', 'Romanzen und Balladen, Vol. IV, Op. 64', 'album', NULL, 'Op.', '64', 1847, 'manual', 1
FROM composers c
WHERE c.id = 29
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '로망스와 발라드 4집 Op. 64'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'd4438fab-a67b-4fcb-86a3-934309133b6b'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'd4438fab-a67b-4fcb-86a3-934309133b6b'
FROM pieces p
WHERE p.composer_id = 29 AND p.title = '로망스와 발라드 4집 Op. 64' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'd4438fab-a67b-4fcb-86a3-934309133b6b'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:60d4d2de-9c1b-4fb4-88a5-4032deac5521', 1, NULL, 'Die Soldatenbraut', 'Die Soldatenbraut', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 29 AND p.title = '로망스와 발라드 4집 Op. 64' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:60d4d2de-9c1b-4fb4-88a5-4032deac5521'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:6ae4c66a-773c-4640-8cff-f582fb97f704', 2, NULL, 'Das verlassene Mägdelein', 'Das verlassene Mägdelein', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 29 AND p.title = '로망스와 발라드 4집 Op. 64' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:6ae4c66a-773c-4640-8cff-f582fb97f704'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:3724469f-e538-4e01-8712-b2bd6a3f617d', 3, NULL, 'Tragödie', 'Tragödie', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 29 AND p.title = '로망스와 발라드 4집 Op. 64' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:3724469f-e538-4e01-8712-b2bd6a3f617d'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:82a780d2-0545-3d3e-969d-3227c5470237', 1, 'I', 'Entflieh mit mir und sei mein Weib', 'Entflieh mit mir und sei mein Weib', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:3724469f-e538-4e01-8712-b2bd6a3f617d'
WHERE p.composer_id = 29 AND p.title = '로망스와 발라드 4집 Op. 64' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:82a780d2-0545-3d3e-969d-3227c5470237'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:268c050e-2cb3-3ed9-bd8a-9debb2068768', 2, 'II', 'Es fiel ein Reif in der Frühlingsnacht', 'Es fiel ein Reif in der Frühlingsnacht', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:3724469f-e538-4e01-8712-b2bd6a3f617d'
WHERE p.composer_id = 29 AND p.title = '로망스와 발라드 4집 Op. 64' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:268c050e-2cb3-3ed9-bd8a-9debb2068768'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:0b842e94-d6a7-41e3-9099-6f8298147560', 3, 'III', 'Auf ihrem Grab', 'Auf ihrem Grab', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:3724469f-e538-4e01-8712-b2bd6a3f617d'
WHERE p.composer_id = 29 AND p.title = '로망스와 발라드 4집 Op. 64' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:0b842e94-d6a7-41e3-9099-6f8298147560'
);


-- Op. 65 카논풍의 리토르넬로 Op. 65

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '카논풍의 리토르넬로 Op. 65', 'Ritornelle in canonischen Weisen, Op. 65', 'album', NULL, 'Op.', '65', 1847, 'manual', 1
FROM composers c
WHERE c.id = 29
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '카논풍의 리토르넬로 Op. 65'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'de95ab27-302d-4ca4-8a95-b77f8a0d655c'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'de95ab27-302d-4ca4-8a95-b77f8a0d655c'
FROM pieces p
WHERE p.composer_id = 29 AND p.title = '카논풍의 리토르넬로 Op. 65' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'de95ab27-302d-4ca4-8a95-b77f8a0d655c'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:ae9db7d2-302c-3a4e-8dc3-7304e6e151c6', 1, NULL, 'Die Rose stand im Tau', 'Die Rose stand im Tau', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 29 AND p.title = '카논풍의 리토르넬로 Op. 65' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:ae9db7d2-302c-3a4e-8dc3-7304e6e151c6'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:54cbbd52-f8fc-4d42-953f-e603eaa72d88', 2, NULL, 'Lasst Lautenspiel und Becherklang', 'Lasst Lautenspiel und Becherklang', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 29 AND p.title = '카논풍의 리토르넬로 Op. 65' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:54cbbd52-f8fc-4d42-953f-e603eaa72d88'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:c8c63dab-8208-4246-9cae-3c8c54df146e', 3, NULL, 'Blüt'' oder Schnee! Lust oder Weh', 'Blüt'' oder Schnee! Lust oder Weh', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 29 AND p.title = '카논풍의 리토르넬로 Op. 65' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:c8c63dab-8208-4246-9cae-3c8c54df146e'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:f72fb9d3-5abd-4d0a-8ef7-e40fe3611203', 4, NULL, 'Gebt mir zu trinken', 'Gebt mir zu trinken', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 29 AND p.title = '카논풍의 리토르넬로 Op. 65' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:f72fb9d3-5abd-4d0a-8ef7-e40fe3611203'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:4ce76c58-b623-4627-b5e2-47ea38755671', 5, NULL, 'Zürne nicht des Herbstes Wind', 'Zürne nicht des Herbstes Wind', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 29 AND p.title = '카논풍의 리토르넬로 Op. 65' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:4ce76c58-b623-4627-b5e2-47ea38755671'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:0a47da1b-4f01-4426-ac28-98376e494afe', 6, NULL, 'In Sommertagen rüste den Schlitten', 'In Sommertagen rüste den Schlitten', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 29 AND p.title = '카논풍의 리토르넬로 Op. 65' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:0a47da1b-4f01-4426-ac28-98376e494afe'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:f84a826a-685e-44df-aa04-1e9edd417d1b', 7, NULL, 'In Meeres Mitten', 'In Meeres Mitten', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 29 AND p.title = '카논풍의 리토르넬로 Op. 65' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:f84a826a-685e-44df-aa04-1e9edd417d1b'
);


-- Op. 66 피아노 연탄 모음곡 <동방의 그림>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '피아노 연탄 모음곡 <동방의 그림>', 'Bilder aus Osten', 'album', 'Op. 66', NULL, NULL, 1848, 'manual', 1
FROM composers c
WHERE c.id = 29
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '피아노 연탄 모음곡 <동방의 그림>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'd1c8fb88-dc37-4068-89b0-c40c24728a3f'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'd1c8fb88-dc37-4068-89b0-c40c24728a3f'
FROM pieces p
WHERE p.composer_id = 29 AND p.title = '피아노 연탄 모음곡 <동방의 그림>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'd1c8fb88-dc37-4068-89b0-c40c24728a3f'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:5718eb6e-0017-4cfb-8130-2869b25fc780', 1, NULL, 'Lebhaft', 'No. 1. Lebhaft', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 29 AND p.title = '피아노 연탄 모음곡 <동방의 그림>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:5718eb6e-0017-4cfb-8130-2869b25fc780'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:41c0b1dd-6df9-4f0c-8d44-f0093f702dee', 2, NULL, 'Nicht schnell und sehr gesangvoll zu spielen', 'No. 2. Nicht schnell und sehr gesangvoll zu spielen', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 29 AND p.title = '피아노 연탄 모음곡 <동방의 그림>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:41c0b1dd-6df9-4f0c-8d44-f0093f702dee'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:5f9f6dfc-4372-4b6a-b10e-9b209af03f14', 3, NULL, 'Im Volkston', 'No. 3. Im Volkston', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 29 AND p.title = '피아노 연탄 모음곡 <동방의 그림>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:5f9f6dfc-4372-4b6a-b10e-9b209af03f14'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:2c8cb969-4319-4977-b68a-652e1160c6dd', 4, NULL, 'Nicht schnell', 'No. 4. Nicht schnell', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 29 AND p.title = '피아노 연탄 모음곡 <동방의 그림>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:2c8cb969-4319-4977-b68a-652e1160c6dd'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:f946b6ad-6655-4a73-9f91-a62e54569155', 5, NULL, 'Lebhaft', 'No. 5. Lebhaft', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 29 AND p.title = '피아노 연탄 모음곡 <동방의 그림>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:f946b6ad-6655-4a73-9f91-a62e54569155'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:a4f4db3e-9d19-46ba-8eb5-198c08f678b0', 6, NULL, 'Reuig andächtig', 'No. 6. Reuig andächtig', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 29 AND p.title = '피아노 연탄 모음곡 <동방의 그림>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:a4f4db3e-9d19-46ba-8eb5-198c08f678b0'
);


-- Op. 67 합창을 위한 로망스와 발라드 1집 Op. 67

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '합창을 위한 로망스와 발라드 1집 Op. 67', 'Romanzen und Balladen for chorus, Vol. I, Op. 67', 'album', NULL, 'Op.', '67', 1849, 'manual', 1
FROM composers c
WHERE c.id = 29
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '합창을 위한 로망스와 발라드 1집 Op. 67'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '15844409-be14-469d-83e1-3e73cb4288ff'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '15844409-be14-469d-83e1-3e73cb4288ff'
FROM pieces p
WHERE p.composer_id = 29 AND p.title = '합창을 위한 로망스와 발라드 1집 Op. 67' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '15844409-be14-469d-83e1-3e73cb4288ff'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:b69020a6-4ab2-47d9-9f03-a832039c6be7', 1, NULL, 'Der König von Thule', 'Der König von Thule', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 29 AND p.title = '합창을 위한 로망스와 발라드 1집 Op. 67' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:b69020a6-4ab2-47d9-9f03-a832039c6be7'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:19d12830-d400-4df9-b543-5b7d6da5edd7', 2, NULL, 'Schön-Rohtraut', 'Schön-Rohtraut', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 29 AND p.title = '합창을 위한 로망스와 발라드 1집 Op. 67' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:19d12830-d400-4df9-b543-5b7d6da5edd7'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:1a82bea4-04a3-3a04-81a3-ec19a5b60b0c', 3, NULL, 'Heidenröslein', 'Heidenröslein', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 29 AND p.title = '합창을 위한 로망스와 발라드 1집 Op. 67' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:1a82bea4-04a3-3a04-81a3-ec19a5b60b0c'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:68edca02-99f5-4bf0-8525-251cddc2a912', 4, NULL, 'Ungewitter', 'Ungewitter', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 29 AND p.title = '합창을 위한 로망스와 발라드 1집 Op. 67' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:68edca02-99f5-4bf0-8525-251cddc2a912'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:fd83c8a6-c711-4f33-9c8e-1ab86afb664d', 5, NULL, 'John Anderson', 'John Anderson', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 29 AND p.title = '합창을 위한 로망스와 발라드 1집 Op. 67' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:fd83c8a6-c711-4f33-9c8e-1ab86afb664d'
);


-- Op. 68 피아노 모음곡 <어린이를 위한 앨범>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '피아노 모음곡 <어린이를 위한 앨범>', 'Album für die Jugend', 'album', 'Op. 68', NULL, NULL, 1848, 'manual', 1
FROM composers c
WHERE c.id = 29
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '피아노 모음곡 <어린이를 위한 앨범>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '6b335c2f-b94c-43f7-a961-84d25c9befc2'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '6b335c2f-b94c-43f7-a961-84d25c9befc2'
FROM pieces p
WHERE p.composer_id = 29 AND p.title = '피아노 모음곡 <어린이를 위한 앨범>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '6b335c2f-b94c-43f7-a961-84d25c9befc2'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:b28d39bf-ffbb-371b-8191-6a45a7d70533', 1, NULL, 'Melodie', 'Melodie', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 29 AND p.title = '피아노 모음곡 <어린이를 위한 앨범>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:b28d39bf-ffbb-371b-8191-6a45a7d70533'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:1e49d3ab-63d1-3413-8bdd-da08ade6ae0a', 2, NULL, '병정 행진곡 (Soldatenmarsch)', 'Soldatenmarsch', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 29 AND p.title = '피아노 모음곡 <어린이를 위한 앨범>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:1e49d3ab-63d1-3413-8bdd-da08ade6ae0a'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:ce33b62f-3262-375f-a73e-7598e502ef24', 3, NULL, 'Trällerliedchen', 'Trällerliedchen', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 29 AND p.title = '피아노 모음곡 <어린이를 위한 앨범>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:ce33b62f-3262-375f-a73e-7598e502ef24'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:e7ba6cab-1aaa-3bfb-b2c4-b946b4439d77', 4, NULL, 'Ein Choral', 'Ein Choral', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 29 AND p.title = '피아노 모음곡 <어린이를 위한 앨범>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:e7ba6cab-1aaa-3bfb-b2c4-b946b4439d77'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:e0093979-3ed0-3de1-bc86-d078751eb242', 5, NULL, 'Stückchen', 'Stückchen', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 29 AND p.title = '피아노 모음곡 <어린이를 위한 앨범>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:e0093979-3ed0-3de1-bc86-d078751eb242'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:988ee6f7-6ddf-3c33-9e65-792c1cefbaf5', 6, NULL, 'Armes Waisenkind', 'Armes Waisenkind', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 29 AND p.title = '피아노 모음곡 <어린이를 위한 앨범>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:988ee6f7-6ddf-3c33-9e65-792c1cefbaf5'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:5bbec8c1-2076-3f9c-baea-48fbf1a2e54a', 7, NULL, 'Jägerliedchen', 'Jägerliedchen', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 29 AND p.title = '피아노 모음곡 <어린이를 위한 앨범>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:5bbec8c1-2076-3f9c-baea-48fbf1a2e54a'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:5eb5e2dd-501a-3b5c-addd-52485c17eb1b', 8, NULL, 'Wilder Reiter', 'Wilder Reiter', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 29 AND p.title = '피아노 모음곡 <어린이를 위한 앨범>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:5eb5e2dd-501a-3b5c-addd-52485c17eb1b'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:1a170438-0956-3f44-ad1d-e7271f974e86', 9, NULL, 'Volksliedchen', 'Volksliedchen', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 29 AND p.title = '피아노 모음곡 <어린이를 위한 앨범>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:1a170438-0956-3f44-ad1d-e7271f974e86'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:f2d19525-5067-350b-8476-2e8718786ded', 10, NULL, '즐거운 농부 (Fröhlicher Landmann)', 'Fröhlicher Landmann, von der Arbeit zurückkehrend', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 29 AND p.title = '피아노 모음곡 <어린이를 위한 앨범>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:f2d19525-5067-350b-8476-2e8718786ded'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:6b08c88d-2e89-307c-83d4-fa7be73d0e38', 11, NULL, 'Sizilianisch', 'Sizilianisch', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 29 AND p.title = '피아노 모음곡 <어린이를 위한 앨범>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:6b08c88d-2e89-307c-83d4-fa7be73d0e38'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:d13abcce-c0f4-3556-8dac-bb360e6a5bd6', 12, NULL, 'Knecht Ruprecht', 'Knecht Ruprecht', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 29 AND p.title = '피아노 모음곡 <어린이를 위한 앨범>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:d13abcce-c0f4-3556-8dac-bb360e6a5bd6'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:f446dea9-abd8-3e6b-9d9e-d14b9e47fb09', 13, NULL, 'Mai, lieber Mai', 'Mai, lieber Mai', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 29 AND p.title = '피아노 모음곡 <어린이를 위한 앨범>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:f446dea9-abd8-3e6b-9d9e-d14b9e47fb09'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:65653267-f853-32d0-93c8-7a886e19faf7', 14, NULL, 'Kleine Studie', 'Kleine Studie', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 29 AND p.title = '피아노 모음곡 <어린이를 위한 앨범>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:65653267-f853-32d0-93c8-7a886e19faf7'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:640ee495-7759-3618-ad1b-eaaae06d5017', 15, NULL, 'Frühlingsgesang', 'Frühlingsgesang', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 29 AND p.title = '피아노 모음곡 <어린이를 위한 앨범>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:640ee495-7759-3618-ad1b-eaaae06d5017'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:9d6a2c31-817a-3e74-9072-79129ba5a9e6', 16, NULL, 'Erster Verlust', 'Erster Verlust', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 29 AND p.title = '피아노 모음곡 <어린이를 위한 앨범>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:9d6a2c31-817a-3e74-9072-79129ba5a9e6'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:99f7b355-78bd-3f2d-bc40-9c4c7ab6e5dd', 17, NULL, 'Kleiner Morgenwanderer', 'Kleiner Morgenwanderer', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 29 AND p.title = '피아노 모음곡 <어린이를 위한 앨범>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:99f7b355-78bd-3f2d-bc40-9c4c7ab6e5dd'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:56a3316e-80a7-38f9-94df-b597f21310df', 18, NULL, 'Schnitterliedchen', 'Schnitterliedchen', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 29 AND p.title = '피아노 모음곡 <어린이를 위한 앨범>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:56a3316e-80a7-38f9-94df-b597f21310df'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:1c60b30a-1c96-3ef0-951b-a3ba752db44e', 19, NULL, 'Kleine Romanze', 'Kleine Romanze', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 29 AND p.title = '피아노 모음곡 <어린이를 위한 앨범>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:1c60b30a-1c96-3ef0-951b-a3ba752db44e'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:84e7c35d-9006-3104-8265-0189665b62da', 20, NULL, 'Ländliches Lied', 'Ländliches Lied', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 29 AND p.title = '피아노 모음곡 <어린이를 위한 앨범>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:84e7c35d-9006-3104-8265-0189665b62da'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:450ccce5-608a-39f0-bb80-b8a71e0a0fa8', 21, NULL, '*** (Andante espressivo)', '*** (Andante espressivo)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 29 AND p.title = '피아노 모음곡 <어린이를 위한 앨범>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:450ccce5-608a-39f0-bb80-b8a71e0a0fa8'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:83862b98-9a4d-3cbf-9745-adf4e4d1b8bd', 22, NULL, 'Rundgesang', 'Rundgesang', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 29 AND p.title = '피아노 모음곡 <어린이를 위한 앨범>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:83862b98-9a4d-3cbf-9745-adf4e4d1b8bd'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:78842333-0f39-3a6f-a44f-91566e382a97', 23, NULL, 'Reiterstück', 'Reiterstück', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 29 AND p.title = '피아노 모음곡 <어린이를 위한 앨범>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:78842333-0f39-3a6f-a44f-91566e382a97'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:183a1fd3-d94b-32b5-9701-d1a5d7a5d5e8', 24, NULL, 'Ernteliedchen', 'Ernteliedchen', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 29 AND p.title = '피아노 모음곡 <어린이를 위한 앨범>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:183a1fd3-d94b-32b5-9701-d1a5d7a5d5e8'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:0437672c-c6ad-3e56-83de-9cd719c2bccc', 25, NULL, 'Nachklänge aus dem Theater', 'Nachklänge aus dem Theater', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 29 AND p.title = '피아노 모음곡 <어린이를 위한 앨범>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:0437672c-c6ad-3e56-83de-9cd719c2bccc'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:ea8483bc-7563-399c-9f0c-55eefbe9666d', 26, NULL, '*** (Moderato e espressivo)', '*** (Moderato e espressivo)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 29 AND p.title = '피아노 모음곡 <어린이를 위한 앨범>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:ea8483bc-7563-399c-9f0c-55eefbe9666d'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:45e49625-2c25-36bd-8b21-c758a3a83ab5', 27, NULL, 'Canonisches Liedchen', 'Canonisches Liedchen', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 29 AND p.title = '피아노 모음곡 <어린이를 위한 앨범>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:45e49625-2c25-36bd-8b21-c758a3a83ab5'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:f51914de-f87a-357b-8c78-bdb81e2f2f39', 28, NULL, 'Erinnerung (4. November 1847)', 'Erinnerung (4. November 1847)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 29 AND p.title = '피아노 모음곡 <어린이를 위한 앨범>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:f51914de-f87a-357b-8c78-bdb81e2f2f39'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:8aea909e-7ce7-32eb-b5f3-e146fdcef168', 29, NULL, 'Fremder Mann', 'Fremder Mann', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 29 AND p.title = '피아노 모음곡 <어린이를 위한 앨범>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:8aea909e-7ce7-32eb-b5f3-e146fdcef168'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:2dcb6641-d87b-332e-9fa2-8235dd953259', 30, NULL, '*** (Lento assai)', '*** (Lento assai)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 29 AND p.title = '피아노 모음곡 <어린이를 위한 앨범>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:2dcb6641-d87b-332e-9fa2-8235dd953259'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:548907ce-a24e-3d57-84c0-73a8e9cbf43c', 31, NULL, 'Kriegslied', 'Kriegslied', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 29 AND p.title = '피아노 모음곡 <어린이를 위한 앨범>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:548907ce-a24e-3d57-84c0-73a8e9cbf43c'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:2a40ffbe-8748-36aa-9bca-4af4e5eb1632', 32, NULL, 'Scheherazade', 'Scheherazade', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 29 AND p.title = '피아노 모음곡 <어린이를 위한 앨범>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:2a40ffbe-8748-36aa-9bca-4af4e5eb1632'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:33f9c95b-938f-3cea-9515-01526de2b034', 33, NULL, 'Weinlesezeit – fröhliche Zeit!', 'Weinlesezeit – fröhliche Zeit!', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 29 AND p.title = '피아노 모음곡 <어린이를 위한 앨범>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:33f9c95b-938f-3cea-9515-01526de2b034'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:0a7d2cb9-5a42-3e72-ba67-e4be8b6bf50f', 34, NULL, 'Thema', 'Thema', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 29 AND p.title = '피아노 모음곡 <어린이를 위한 앨범>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:0a7d2cb9-5a42-3e72-ba67-e4be8b6bf50f'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:ea9e7f4b-1b86-3bda-9c41-c7ead19bd013', 35, NULL, 'Mignon', 'Mignon', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 29 AND p.title = '피아노 모음곡 <어린이를 위한 앨범>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:ea9e7f4b-1b86-3bda-9c41-c7ead19bd013'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:d70f899a-ee29-3dbc-9b55-0224affce5b1', 36, NULL, 'Lied italienischer Marinari', 'Lied italienischer Marinari', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 29 AND p.title = '피아노 모음곡 <어린이를 위한 앨범>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:d70f899a-ee29-3dbc-9b55-0224affce5b1'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:ae73bacd-6eb4-3706-97af-6ced934d2862', 37, NULL, 'Matrosenlied', 'Matrosenlied', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 29 AND p.title = '피아노 모음곡 <어린이를 위한 앨범>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:ae73bacd-6eb4-3706-97af-6ced934d2862'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:d7fe8499-9243-30b7-b212-cf2478b5c426', 38, NULL, 'Winterszeit I', 'Winterszeit I', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 29 AND p.title = '피아노 모음곡 <어린이를 위한 앨범>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:d7fe8499-9243-30b7-b212-cf2478b5c426'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:d0994586-e5aa-3e7c-a9f2-3f540c90d351', 39, NULL, 'Winterszeit II', 'Winterszeit II', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 29 AND p.title = '피아노 모음곡 <어린이를 위한 앨범>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:d0994586-e5aa-3e7c-a9f2-3f540c90d351'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:2941105b-a9c8-4b9f-a71c-97d9aee63fd7', 40, NULL, 'Kleine Fuge', 'Kleine Fuge', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 29 AND p.title = '피아노 모음곡 <어린이를 위한 앨범>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:2941105b-a9c8-4b9f-a71c-97d9aee63fd7'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:5b92db30-71d3-3ee7-bef2-a5b0eedff1f3', 41, NULL, 'Nordisches Lied', 'Nordisches Lied', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 29 AND p.title = '피아노 모음곡 <어린이를 위한 앨범>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:5b92db30-71d3-3ee7-bef2-a5b0eedff1f3'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:528b9ad4-e976-309e-9c83-bf9f9ca7de3c', 42, NULL, 'Figurierter Choral', 'Figurierter Choral', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 29 AND p.title = '피아노 모음곡 <어린이를 위한 앨범>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:528b9ad4-e976-309e-9c83-bf9f9ca7de3c'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:80e18ad0-08a1-36d7-b179-b9974c2865dc', 43, NULL, 'Sylvesterlied', 'Sylvesterlied', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 29 AND p.title = '피아노 모음곡 <어린이를 위한 앨범>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:80e18ad0-08a1-36d7-b179-b9974c2865dc'
);


-- Op. 69 여성 합창을 위한 로망스 1집 Op. 69

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '여성 합창을 위한 로망스 1집 Op. 69', 'Romanzen for female voices, Vol. I, Op. 69', 'album', NULL, 'Op.', '69', 1849, 'manual', 1
FROM composers c
WHERE c.id = 29
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '여성 합창을 위한 로망스 1집 Op. 69'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'a8c54f89-9b5a-4d86-a571-761c2d5019ea'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'a8c54f89-9b5a-4d86-a571-761c2d5019ea'
FROM pieces p
WHERE p.composer_id = 29 AND p.title = '여성 합창을 위한 로망스 1집 Op. 69' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'a8c54f89-9b5a-4d86-a571-761c2d5019ea'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:85df62a9-bf1f-4970-bef9-d7a1bae4a4e2', 1, NULL, 'Tamburinschlägerin', 'Tamburinschlägerin', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 29 AND p.title = '여성 합창을 위한 로망스 1집 Op. 69' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:85df62a9-bf1f-4970-bef9-d7a1bae4a4e2'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:875f07cf-6eab-4b77-9b65-53d3e67b7ebf', 2, NULL, 'Waldmädchen', 'Waldmädchen', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 29 AND p.title = '여성 합창을 위한 로망스 1집 Op. 69' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:875f07cf-6eab-4b77-9b65-53d3e67b7ebf'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:c292e51f-f7c8-44e6-ac4a-e6e57c2139d3', 3, NULL, 'Klosterfräulein', 'Klosterfräulein', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 29 AND p.title = '여성 합창을 위한 로망스 1집 Op. 69' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:c292e51f-f7c8-44e6-ac4a-e6e57c2139d3'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:bb6e880b-edc5-4037-88cd-58aed4edea0f', 4, NULL, 'Soldatenbraut', 'Soldatenbraut', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 29 AND p.title = '여성 합창을 위한 로망스 1집 Op. 69' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:bb6e880b-edc5-4037-88cd-58aed4edea0f'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:9422d39b-b9d0-43a3-a484-3f443902126a', 5, NULL, 'Meerfey', 'Meerfey', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 29 AND p.title = '여성 합창을 위한 로망스 1집 Op. 69' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:9422d39b-b9d0-43a3-a484-3f443902126a'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:c5d74acd-1cbb-4003-8fa4-39266dbd2eed', 6, NULL, 'Die Kapelle', 'Die Kapelle', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 29 AND p.title = '여성 합창을 위한 로망스 1집 Op. 69' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:c5d74acd-1cbb-4003-8fa4-39266dbd2eed'
);


-- Op. 70 아다지오와 알레그로 A♭장조

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '아다지오와 알레그로 A♭장조', 'Adagio and Allegro in A♭ major', 'album', 'Op. 70', NULL, NULL, 1849, 'manual', 1
FROM composers c
WHERE c.id = 29
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '아다지오와 알레그로 A♭장조'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '8b6fde5c-6e0b-4909-ad7f-f197ff3ae916'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '8b6fde5c-6e0b-4909-ad7f-f197ff3ae916'
FROM pieces p
WHERE p.composer_id = 29 AND p.title = '아다지오와 알레그로 A♭장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '8b6fde5c-6e0b-4909-ad7f-f197ff3ae916'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:5986a983-25ce-41b6-8328-283f99691443', 1, 'I', 'Adagio', 'I. Adagio', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 29 AND p.title = '아다지오와 알레그로 A♭장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:5986a983-25ce-41b6-8328-283f99691443'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:e2692d30-ecdc-46c8-9a0a-717a15f5e0ad', 2, 'II', 'Allegro', 'II. Allegro', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 29 AND p.title = '아다지오와 알레그로 A♭장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:e2692d30-ecdc-46c8-9a0a-717a15f5e0ad'
);


-- Op. 71 <강림절 노래>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '<강림절 노래>', 'Adventlied', 'song', 'Op. 71', NULL, NULL, 1848, 'manual', 1
FROM composers c
WHERE c.id = 29
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '<강림절 노래>'
);


-- Op. 72 푸가 Op. 72

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '푸가 Op. 72', '4 Fugues, Op. 72', 'album', NULL, 'Op.', '72', 1845, 'manual', 1
FROM composers c
WHERE c.id = 29
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '푸가 Op. 72'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '8a00fc73-d25e-460f-b711-24bcabb74a8f'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '8a00fc73-d25e-460f-b711-24bcabb74a8f'
FROM pieces p
WHERE p.composer_id = 29 AND p.title = '푸가 Op. 72' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '8a00fc73-d25e-460f-b711-24bcabb74a8f'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:720daf57-7213-461e-81f1-25b72f814dc7', 1, NULL, 'D단조. Nicht schnell', 'No. 1 in D minor. Nicht schnell', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 29 AND p.title = '푸가 Op. 72' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:720daf57-7213-461e-81f1-25b72f814dc7'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:9838392b-7534-41ed-863b-4ec2acd2cdb4', 2, NULL, 'D단조. Sehr lebhaft', 'No. 2 in D minor. Sehr lebhaft', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 29 AND p.title = '푸가 Op. 72' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:9838392b-7534-41ed-863b-4ec2acd2cdb4'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:32fc9abc-c73a-4295-a34f-9c3fd8def531', 3, NULL, 'F단조. Nicht schnell und sehr ausdrucksvoll', 'No. 3 in F minor. Nicht schnell und sehr ausdrucksvoll', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 29 AND p.title = '푸가 Op. 72' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:32fc9abc-c73a-4295-a34f-9c3fd8def531'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:4b2b5912-e5ea-4bc3-88ff-40ed9909de37', 4, NULL, 'F장조. Im mäßigen Tempo', 'No. 4 in F major. Im mäßigen Tempo', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 29 AND p.title = '푸가 Op. 72' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:4b2b5912-e5ea-4bc3-88ff-40ed9909de37'
);


-- Op. 73 환상소곡집 Op. 73

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '환상소곡집 Op. 73', '3 Fantasiestücke for clarinet and piano, Op. 73', 'album', NULL, 'Op.', '73', 1849, 'manual', 1
FROM composers c
WHERE c.id = 29
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '환상소곡집 Op. 73'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'c418c7e2-d396-42e8-bdee-8344bc85e824'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'c418c7e2-d396-42e8-bdee-8344bc85e824'
FROM pieces p
WHERE p.composer_id = 29 AND p.title = '환상소곡집 Op. 73' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'c418c7e2-d396-42e8-bdee-8344bc85e824'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:f7c7f073-7001-3f6b-950f-4831d7084926', 1, NULL, 'Zart und mit Ausdruck', 'No. 1. Zart und mit Ausdruck', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 29 AND p.title = '환상소곡집 Op. 73' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:f7c7f073-7001-3f6b-950f-4831d7084926'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:b1eb260f-cabf-37f2-b9b2-3583faff8305', 2, NULL, 'Lebhaft, leicht', 'No. 2. Lebhaft, leicht', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 29 AND p.title = '환상소곡집 Op. 73' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:b1eb260f-cabf-37f2-b9b2-3583faff8305'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:23f0e6eb-c2dc-3f4f-a1f5-b6b0c676986f', 3, NULL, 'Rasch und mit Feuer', 'No. 3. Rasch und mit Feuer', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 29 AND p.title = '환상소곡집 Op. 73' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:23f0e6eb-c2dc-3f4f-a1f5-b6b0c676986f'
);


-- Op. 74 가곡집 <스페인 가곡극>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '가곡집 <스페인 가곡극>', 'Spanisches Liederspiel', 'album', 'Op. 74', NULL, NULL, 1849, 'manual', 1
FROM composers c
WHERE c.id = 29
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '가곡집 <스페인 가곡극>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '0277c6ae-5869-4ec5-88ee-c1e9e55c4afc'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '0277c6ae-5869-4ec5-88ee-c1e9e55c4afc'
FROM pieces p
WHERE p.composer_id = 29 AND p.title = '가곡집 <스페인 가곡극>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '0277c6ae-5869-4ec5-88ee-c1e9e55c4afc'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:d56e8ff9-0466-4781-91d5-698f276f3e1d', 1, NULL, 'Erste Begegnung', 'Erste Begegnung', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 29 AND p.title = '가곡집 <스페인 가곡극>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:d56e8ff9-0466-4781-91d5-698f276f3e1d'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:dd5674bc-94f0-4e88-967d-ac81eff47875', 2, NULL, 'Intermezzo', 'Intermezzo', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 29 AND p.title = '가곡집 <스페인 가곡극>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:dd5674bc-94f0-4e88-967d-ac81eff47875'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:223f6404-a49d-4e54-b9b6-a54aac44c87b', 3, NULL, 'Liebesgram', 'Liebesgram', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 29 AND p.title = '가곡집 <스페인 가곡극>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:223f6404-a49d-4e54-b9b6-a54aac44c87b'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:f0026ef3-bb9c-43fe-b60c-ddc9fc4f93ca', 4, NULL, 'In der Nacht', 'In der Nacht', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 29 AND p.title = '가곡집 <스페인 가곡극>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:f0026ef3-bb9c-43fe-b60c-ddc9fc4f93ca'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:98af3638-eaf1-4b44-b5b5-725a65366590', 5, NULL, 'Es ist verraten', 'Es ist verraten', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 29 AND p.title = '가곡집 <스페인 가곡극>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:98af3638-eaf1-4b44-b5b5-725a65366590'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:a97f8c0c-1e02-3df0-acb5-c6aaa375b27e', 6, NULL, 'Melancholie', 'Melancholie', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 29 AND p.title = '가곡집 <스페인 가곡극>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:a97f8c0c-1e02-3df0-acb5-c6aaa375b27e'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:4ee815d1-bd1d-3513-b812-5099a9f0700d', 7, NULL, 'Geständnis', 'Geständnis', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 29 AND p.title = '가곡집 <스페인 가곡극>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:4ee815d1-bd1d-3513-b812-5099a9f0700d'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:84746936-f5cb-4571-8eeb-0a41e5a1b1bb', 8, NULL, 'Botschaft', 'Botschaft', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 29 AND p.title = '가곡집 <스페인 가곡극>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:84746936-f5cb-4571-8eeb-0a41e5a1b1bb'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:401a0f03-a6c8-40c0-ba93-9d3a3a06e215', 9, NULL, 'Ich bin geliebt', 'Ich bin geliebt', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 29 AND p.title = '가곡집 <스페인 가곡극>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:401a0f03-a6c8-40c0-ba93-9d3a3a06e215'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:20434912-1aa8-3db9-a786-ed4057e1217d', 10, NULL, 'Der Contrabandiste (부록)', 'Der Contrabandiste (Anhang)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 29 AND p.title = '가곡집 <스페인 가곡극>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:20434912-1aa8-3db9-a786-ed4057e1217d'
);


-- Op. 75 합창을 위한 로망스와 발라드 2집 Op. 75

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '합창을 위한 로망스와 발라드 2집 Op. 75', 'Romanzen und Balladen for chorus, Vol. II, Op. 75', 'album', NULL, 'Op.', '75', 1849, 'manual', 1
FROM composers c
WHERE c.id = 29
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '합창을 위한 로망스와 발라드 2집 Op. 75'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'bd844d0b-2120-4391-aeeb-8510a50b7dd4'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'bd844d0b-2120-4391-aeeb-8510a50b7dd4'
FROM pieces p
WHERE p.composer_id = 29 AND p.title = '합창을 위한 로망스와 발라드 2집 Op. 75' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'bd844d0b-2120-4391-aeeb-8510a50b7dd4'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:ffa035e6-7877-4ab2-8ed0-482a3f82431b', 1, NULL, 'Schnitter Tod', 'Schnitter Tod', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 29 AND p.title = '합창을 위한 로망스와 발라드 2집 Op. 75' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:ffa035e6-7877-4ab2-8ed0-482a3f82431b'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:c8d9fdee-95ef-4eb2-9f82-e12be90c582e', 2, NULL, 'Im Walde', 'Im Walde', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 29 AND p.title = '합창을 위한 로망스와 발라드 2집 Op. 75' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:c8d9fdee-95ef-4eb2-9f82-e12be90c582e'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:45fc43d8-c768-4861-9ad3-748be1faa988', 3, NULL, 'Der traurige Jäger', 'Der traurige Jäger', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 29 AND p.title = '합창을 위한 로망스와 발라드 2집 Op. 75' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:45fc43d8-c768-4861-9ad3-748be1faa988'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:b5ba1408-7651-492f-b2f8-39d3ef3f8a0d', 4, NULL, 'Der Rekrut', 'Der Rekrut', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 29 AND p.title = '합창을 위한 로망스와 발라드 2집 Op. 75' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:b5ba1408-7651-492f-b2f8-39d3ef3f8a0d'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:ad6e97a1-4ae1-4371-b85c-75661c3fb100', 5, NULL, 'Vom verwundeten Knaben', 'Vom verwundeten Knaben', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 29 AND p.title = '합창을 위한 로망스와 발라드 2집 Op. 75' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:ad6e97a1-4ae1-4371-b85c-75661c3fb100'
);


-- Op. 76 행진곡 Op. 76

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '행진곡 Op. 76', '4 Marches, Op. 76', 'album', NULL, 'Op.', '76', 1849, 'manual', 1
FROM composers c
WHERE c.id = 29
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '행진곡 Op. 76'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '09487c94-9b55-4832-87b2-95f936166250'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '09487c94-9b55-4832-87b2-95f936166250'
FROM pieces p
WHERE p.composer_id = 29 AND p.title = '행진곡 Op. 76' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '09487c94-9b55-4832-87b2-95f936166250'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:11d7b472-a055-41b2-a89f-2ee2d395dece', 1, NULL, 'E♭장조. Mit größter Energie', 'No. 1 in E♭ major. Mit größter Energie', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 29 AND p.title = '행진곡 Op. 76' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:11d7b472-a055-41b2-a89f-2ee2d395dece'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:bf77ea87-b963-4629-bcc8-8b395bb37ed2', 2, NULL, 'G단조. Sehr kräftig', 'No. 2 in G minor. Sehr kräftig', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 29 AND p.title = '행진곡 Op. 76' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:bf77ea87-b963-4629-bcc8-8b395bb37ed2'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:b752639c-d994-4a9b-ba39-aba44d8c01bf', 3, NULL, 'B♭장조 "Lagerszene". Sehr mäßig', 'No. 3 in B♭ major. Lagerszene. Sehr mäßig', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 29 AND p.title = '행진곡 Op. 76' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:b752639c-d994-4a9b-ba39-aba44d8c01bf'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:64b072e3-be7b-4b09-ba73-b4885c15c1e2', 4, NULL, 'E♭장조. Mit Kraft und Feuer', 'No. 4 in E♭ major. Mit Kraft und Feuer', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 29 AND p.title = '행진곡 Op. 76' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:64b072e3-be7b-4b09-ba73-b4885c15c1e2'
);


-- Op. 77 가곡과 노래 3집 Op. 77

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '가곡과 노래 3집 Op. 77', 'Lieder und Gesänge, Vol. III, Op. 77', 'album', NULL, 'Op.', '77', 1850, 'manual', 1
FROM composers c
WHERE c.id = 29
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '가곡과 노래 3집 Op. 77'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '6084ea3d-0751-4244-b07e-6172dc110f3f'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '6084ea3d-0751-4244-b07e-6172dc110f3f'
FROM pieces p
WHERE p.composer_id = 29 AND p.title = '가곡과 노래 3집 Op. 77' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '6084ea3d-0751-4244-b07e-6172dc110f3f'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:164ab101-d60e-3f91-94b6-28dc95223a65', 1, NULL, 'Der frohe Wandersmann', 'Der frohe Wandersmann', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 29 AND p.title = '가곡과 노래 3집 Op. 77' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:164ab101-d60e-3f91-94b6-28dc95223a65'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:4a2e6cec-bc4c-49ce-ae19-0accf7ceb7b6', 2, NULL, 'Mein Garten', 'Mein Garten', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 29 AND p.title = '가곡과 노래 3집 Op. 77' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:4a2e6cec-bc4c-49ce-ae19-0accf7ceb7b6'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:841d2702-3b52-4724-9ee6-bc66d76f9dea', 3, NULL, 'Geisternähe', 'Geisternähe', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 29 AND p.title = '가곡과 노래 3집 Op. 77' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:841d2702-3b52-4724-9ee6-bc66d76f9dea'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:d1db9e76-78df-41be-a0f7-4f0b2d211775', 4, NULL, 'Stiller Vorwurf', 'Stiller Vorwurf', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 29 AND p.title = '가곡과 노래 3집 Op. 77' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:d1db9e76-78df-41be-a0f7-4f0b2d211775'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:4d8c374e-1368-3fee-8741-f543f6ed7ea6', 5, NULL, 'Aufträge', 'Aufträge', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 29 AND p.title = '가곡과 노래 3집 Op. 77' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:4d8c374e-1368-3fee-8741-f543f6ed7ea6'
);


-- Op. 78 4개의 이중창 Op. 78

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '4개의 이중창 Op. 78', '4 Duets, Op. 78', 'album', NULL, 'Op.', '78', 1849, 'manual', 1
FROM composers c
WHERE c.id = 29
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '4개의 이중창 Op. 78'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '0e4ec478-a666-4bcc-a5c6-1c6bf11b4ffc'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '0e4ec478-a666-4bcc-a5c6-1c6bf11b4ffc'
FROM pieces p
WHERE p.composer_id = 29 AND p.title = '4개의 이중창 Op. 78' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '0e4ec478-a666-4bcc-a5c6-1c6bf11b4ffc'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:045d7dba-785f-4093-8fcb-e67e151f3915', 1, NULL, 'Tanzlied', 'Tanzlied', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 29 AND p.title = '4개의 이중창 Op. 78' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:045d7dba-785f-4093-8fcb-e67e151f3915'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:9eefe274-cd86-4580-8d3f-817132732710', 2, NULL, 'Er und Sie', 'Er und Sie', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 29 AND p.title = '4개의 이중창 Op. 78' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:9eefe274-cd86-4580-8d3f-817132732710'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:450af4d5-806f-4363-9df3-78bd827f5010', 3, NULL, 'Ich denke Dein', 'Ich denke Dein', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 29 AND p.title = '4개의 이중창 Op. 78' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:450af4d5-806f-4363-9df3-78bd827f5010'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:46c92c9f-5483-4f06-b8bf-36bfbbd1e20d', 4, NULL, 'Wiegenlied am Lager eines kranken Kindes', 'Wiegenlied am Lager eines kranken Kindes', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 29 AND p.title = '4개의 이중창 Op. 78' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:46c92c9f-5483-4f06-b8bf-36bfbbd1e20d'
);


-- Op. 79 가곡집 <어린이를 위한 노래 앨범>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '가곡집 <어린이를 위한 노래 앨범>', 'Liederalbum für die Jugend', 'album', 'Op. 79', NULL, NULL, 1849, 'manual', 1
FROM composers c
WHERE c.id = 29
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '가곡집 <어린이를 위한 노래 앨범>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'de6b9ca9-462c-4f2f-95d3-cfa3e7685a35'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'de6b9ca9-462c-4f2f-95d3-cfa3e7685a35'
FROM pieces p
WHERE p.composer_id = 29 AND p.title = '가곡집 <어린이를 위한 노래 앨범>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'de6b9ca9-462c-4f2f-95d3-cfa3e7685a35'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:288a08b8-496e-49ac-8c24-f1ae31ac0463', 1, NULL, 'Der Abendstern', 'Der Abendstern', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 29 AND p.title = '가곡집 <어린이를 위한 노래 앨범>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:288a08b8-496e-49ac-8c24-f1ae31ac0463'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:8e343a84-63bf-4b6d-8929-07fe9fdc5cde', 2, NULL, 'Schmetterling', 'Schmetterling', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 29 AND p.title = '가곡집 <어린이를 위한 노래 앨범>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:8e343a84-63bf-4b6d-8929-07fe9fdc5cde'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:73b38984-5c69-4aee-8d73-7719d61863e6', 3, NULL, 'Frühlingsbotschaft', 'Frühlingsbotschaft', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 29 AND p.title = '가곡집 <어린이를 위한 노래 앨범>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:73b38984-5c69-4aee-8d73-7719d61863e6'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:82d7615d-9013-413b-ba15-31a802d34649', 4, NULL, 'Frühlingsgruß', 'Frühlingsgruß', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 29 AND p.title = '가곡집 <어린이를 위한 노래 앨범>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:82d7615d-9013-413b-ba15-31a802d34649'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:3c5bea6b-db29-4414-8217-ee344a10a353', 5, NULL, 'Vom Schlaraffenland', 'Vom Schlaraffenland', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 29 AND p.title = '가곡집 <어린이를 위한 노래 앨범>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:3c5bea6b-db29-4414-8217-ee344a10a353'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:3bc70264-68d3-4b17-8807-265ccf5cafc7', 6, NULL, 'Sonntag', 'Sonntag', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 29 AND p.title = '가곡집 <어린이를 위한 노래 앨범>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:3bc70264-68d3-4b17-8807-265ccf5cafc7'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:9c0917ca-fee0-32f0-aa88-2ca818539979', 7, NULL, 'Zigeunerliedchen I', 'Zigeunerliedchen I', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 29 AND p.title = '가곡집 <어린이를 위한 노래 앨범>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:9c0917ca-fee0-32f0-aa88-2ca818539979'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:84ad8c6b-00eb-3e26-ba0b-cafca0db56cf', 8, NULL, 'Zigeunerliedchen II', 'Zigeunerliedchen II', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 29 AND p.title = '가곡집 <어린이를 위한 노래 앨범>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:84ad8c6b-00eb-3e26-ba0b-cafca0db56cf'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:6743ca5e-8611-4e80-b2bb-ae99bf2cf309', 9, NULL, 'Des Knaben Berglied', 'Des Knaben Berglied', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 29 AND p.title = '가곡집 <어린이를 위한 노래 앨범>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:6743ca5e-8611-4e80-b2bb-ae99bf2cf309'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:3b8d798d-ff68-4365-bb1a-4a4563d9b99c', 10, NULL, 'Mailied', 'Mailied', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 29 AND p.title = '가곡집 <어린이를 위한 노래 앨범>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:3b8d798d-ff68-4365-bb1a-4a4563d9b99c'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:fb65a1a7-3bdd-437f-89f5-80f9a95f73ee', 11, NULL, 'Das Käuzlein', 'Das Käuzlein', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 29 AND p.title = '가곡집 <어린이를 위한 노래 앨범>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:fb65a1a7-3bdd-437f-89f5-80f9a95f73ee'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:32e8d9d4-490d-4f78-ac05-7fca2598de00', 12, NULL, 'Hinaus ins Freie!', 'Hinaus ins Freie!', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 29 AND p.title = '가곡집 <어린이를 위한 노래 앨범>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:32e8d9d4-490d-4f78-ac05-7fca2598de00'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:d64b3a85-5a6f-419e-b54b-9f866b9eb282', 13, NULL, 'Der Sandmann', 'Der Sandmann', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 29 AND p.title = '가곡집 <어린이를 위한 노래 앨범>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:d64b3a85-5a6f-419e-b54b-9f866b9eb282'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:f319b878-db17-3989-9968-5e849d7d28ba', 14, NULL, 'Marienwürmchen', 'Marienwürmchen', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 29 AND p.title = '가곡집 <어린이를 위한 노래 앨범>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:f319b878-db17-3989-9968-5e849d7d28ba'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:3cc906e3-17c6-42b6-ad43-1c453c8d81cc', 15, NULL, 'Die Waise', 'Die Waise', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 29 AND p.title = '가곡집 <어린이를 위한 노래 앨범>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:3cc906e3-17c6-42b6-ad43-1c453c8d81cc'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:f7e4e58e-2570-4553-b70f-0065fb066f63', 16, NULL, 'Das Glück', 'Das Glück', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 29 AND p.title = '가곡집 <어린이를 위한 노래 앨범>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:f7e4e58e-2570-4553-b70f-0065fb066f63'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:0ae5071c-b603-45bf-95cb-384965676dce', 17, NULL, 'Weihnachtslied', 'Weihnachtslied', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 29 AND p.title = '가곡집 <어린이를 위한 노래 앨범>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:0ae5071c-b603-45bf-95cb-384965676dce'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:3037ba8f-cbe6-39c1-a085-d416605bf2e1', 18, NULL, 'Die wandelnde Glocke', 'Die wandelnde Glocke', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 29 AND p.title = '가곡집 <어린이를 위한 노래 앨범>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:3037ba8f-cbe6-39c1-a085-d416605bf2e1'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:9deecdbb-6af4-4333-a99c-005f5d3777db', 19, NULL, 'Frühlingslied', 'Frühlingslied', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 29 AND p.title = '가곡집 <어린이를 위한 노래 앨범>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:9deecdbb-6af4-4333-a99c-005f5d3777db'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:1a0e7062-da07-4004-9e51-699e810fa20e', 20, NULL, 'Frühlings Ankunft', 'Frühlings Ankunft', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 29 AND p.title = '가곡집 <어린이를 위한 노래 앨범>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:1a0e7062-da07-4004-9e51-699e810fa20e'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:6b4c7925-4882-45ce-8710-397297b07aee', 21, NULL, 'Die Schwalben', 'Die Schwalben', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 29 AND p.title = '가곡집 <어린이를 위한 노래 앨범>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:6b4c7925-4882-45ce-8710-397297b07aee'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:08d8615c-b657-4b05-9354-b27296f00094', 22, NULL, 'Kinderwacht', 'Kinderwacht', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 29 AND p.title = '가곡집 <어린이를 위한 노래 앨범>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:08d8615c-b657-4b05-9354-b27296f00094'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:b12cf9e8-802b-34cd-92f1-274e04fe4982', 23, NULL, 'Des Sennen Abschied', 'Des Sennen Abschied', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 29 AND p.title = '가곡집 <어린이를 위한 노래 앨범>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:b12cf9e8-802b-34cd-92f1-274e04fe4982'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:b7b15672-3446-360c-a768-c081c32b4038', 24, NULL, 'Er ist''s', 'Er ist''s', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 29 AND p.title = '가곡집 <어린이를 위한 노래 앨범>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:b7b15672-3446-360c-a768-c081c32b4038'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:68520fdb-fb03-4415-b1fb-e2c4493b3a82', 25, NULL, 'Spinnelied', 'Spinnelied', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 29 AND p.title = '가곡집 <어린이를 위한 노래 앨범>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:68520fdb-fb03-4415-b1fb-e2c4493b3a82'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:81e74aa5-3ff1-4d4a-9908-4bca13375fe0', 26, NULL, 'Des Buben Schützenlied', 'Des Buben Schützenlied', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 29 AND p.title = '가곡집 <어린이를 위한 노래 앨범>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:81e74aa5-3ff1-4d4a-9908-4bca13375fe0'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:8b392bcc-809b-32f1-a539-da2382a47590', 27, NULL, 'Schneeglöckchen', 'Schneeglöckchen', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 29 AND p.title = '가곡집 <어린이를 위한 노래 앨범>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:8b392bcc-809b-32f1-a539-da2382a47590'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:a4559632-2f1c-3098-a96e-1e3b64d0dace', 28, NULL, 'Lied Lynceus'' des Türmers', 'Lied Lynceus'' des Türmers', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 29 AND p.title = '가곡집 <어린이를 위한 노래 앨범>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:a4559632-2f1c-3098-a96e-1e3b64d0dace'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:d2dbf3f6-7c69-4938-ade1-466ac8c3fb2f', 29, NULL, 'Mignon', 'Mignon', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 29 AND p.title = '가곡집 <어린이를 위한 노래 앨범>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:d2dbf3f6-7c69-4938-ade1-466ac8c3fb2f'
);


-- Op. 80 피아노 3중주 2번 F장조

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '피아노 3중주 2번 F장조', 'Piano Trio No. 2 in F major', 'album', 'Op. 80', NULL, NULL, 1847, 'manual', 1
FROM composers c
WHERE c.id = 29
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '피아노 3중주 2번 F장조'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'b30b1d31-ba36-4db4-b92d-8b5ab0ccae82'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'b30b1d31-ba36-4db4-b92d-8b5ab0ccae82'
FROM pieces p
WHERE p.composer_id = 29 AND p.title = '피아노 3중주 2번 F장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'b30b1d31-ba36-4db4-b92d-8b5ab0ccae82'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:05f51a57-2075-4c0d-bff7-87def16e9d21', 1, 'I', 'Sehr lebhaft', 'I. Sehr lebhaft', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 29 AND p.title = '피아노 3중주 2번 F장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:05f51a57-2075-4c0d-bff7-87def16e9d21'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:f9ba4ad1-06ec-49ee-9a0d-544261257b12', 2, 'II', 'Mit innigem Ausdruck', 'II. Mit innigem Ausdruck', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 29 AND p.title = '피아노 3중주 2번 F장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:f9ba4ad1-06ec-49ee-9a0d-544261257b12'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:8740ddc8-67a6-3b7b-8093-269d11e3845c', 3, 'III', 'In mässiger Bewegung', 'III. In mässiger Bewegung', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 29 AND p.title = '피아노 3중주 2번 F장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:8740ddc8-67a6-3b7b-8093-269d11e3845c'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:d2d9dae5-20db-4027-8b5b-103e8c68ed7c', 4, 'IV', 'Nicht zu rasch', 'IV. Nicht zu rasch', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 29 AND p.title = '피아노 3중주 2번 F장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:d2d9dae5-20db-4027-8b5b-103e8c68ed7c'
);


-- Op. 81 오페라 <게노베바>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '오페라 <게노베바>', 'Genoveva', 'song', 'Op. 81', NULL, NULL, 1848, 'manual', 1
FROM composers c
WHERE c.id = 29
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '오페라 <게노베바>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'a732b63a-c4f2-4f67-a76e-d21accd755c1'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'a732b63a-c4f2-4f67-a76e-d21accd755c1'
FROM pieces p
WHERE p.composer_id = 29 AND p.title = '오페라 <게노베바>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'a732b63a-c4f2-4f67-a76e-d21accd755c1'
);


-- Op. 82 피아노 모음곡 <숲의 정경>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '피아노 모음곡 <숲의 정경>', 'Waldszenen', 'album', 'Op. 82', NULL, NULL, 1849, 'manual', 1
FROM composers c
WHERE c.id = 29
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '피아노 모음곡 <숲의 정경>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '5c5a1180-3d87-4ad7-be49-9a7f1efc527c'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '5c5a1180-3d87-4ad7-be49-9a7f1efc527c'
FROM pieces p
WHERE p.composer_id = 29 AND p.title = '피아노 모음곡 <숲의 정경>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '5c5a1180-3d87-4ad7-be49-9a7f1efc527c'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:bcf19737-d566-3162-bc8a-4126b2966489', 1, NULL, 'Eintritt. Nicht zu schnell', 'Eintritt. Nicht zu schnell', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 29 AND p.title = '피아노 모음곡 <숲의 정경>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:bcf19737-d566-3162-bc8a-4126b2966489'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:a1a8c34c-f73c-39fc-b210-47a5ae9d317b', 2, NULL, 'Jäger auf der Lauer. Höchst lebhaft', 'Jäger auf der Lauer. Höchst lebhaft', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 29 AND p.title = '피아노 모음곡 <숲의 정경>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:a1a8c34c-f73c-39fc-b210-47a5ae9d317b'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:c1180505-04ff-3044-a785-884888bde683', 3, NULL, 'Einsame Blumen. Einfach', 'Einsame Blumen. Einfach', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 29 AND p.title = '피아노 모음곡 <숲의 정경>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:c1180505-04ff-3044-a785-884888bde683'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:2b44f3d2-0e41-3748-97fc-c7663112b424', 4, NULL, 'Verrufene Stelle. Ziemlich langsam', 'Verrufene Stelle. Ziemlich langsam', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 29 AND p.title = '피아노 모음곡 <숲의 정경>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:2b44f3d2-0e41-3748-97fc-c7663112b424'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:15dd232e-02db-3081-8b1b-39518e460a4c', 5, NULL, 'Freundliche Landschaft. Schnell', 'Freundliche Landschaft. Schnell', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 29 AND p.title = '피아노 모음곡 <숲의 정경>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:15dd232e-02db-3081-8b1b-39518e460a4c'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:f7475b07-a2f6-3331-bd41-9100faf65d5c', 6, NULL, 'Herberge. Mäßig', 'Herberge. Mäßig', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 29 AND p.title = '피아노 모음곡 <숲의 정경>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:f7475b07-a2f6-3331-bd41-9100faf65d5c'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:c414c626-59de-306e-acbc-9a2edf3e12e4', 7, NULL, '예언하는 새 (Vogel als Prophet)', 'Vogel als Prophet. Langsam, sehr zart', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 29 AND p.title = '피아노 모음곡 <숲의 정경>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:c414c626-59de-306e-acbc-9a2edf3e12e4'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:f0ba688f-701e-3074-88de-6275ca6da4de', 8, NULL, 'Jagdlied. Rasch, kräftig', 'Jagdlied. Rasch, kräftig', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 29 AND p.title = '피아노 모음곡 <숲의 정경>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:f0ba688f-701e-3074-88de-6275ca6da4de'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:90baf32e-fe02-3ffd-a5eb-a763cf5b673c', 9, NULL, 'Abschied. Nicht zu schnell', 'Abschied. Nicht zu schnell', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 29 AND p.title = '피아노 모음곡 <숲의 정경>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:90baf32e-fe02-3ffd-a5eb-a763cf5b673c'
);


-- Op. 83 3개의 노래 Op. 83

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '3개의 노래 Op. 83', '3 Gesänge, Op. 83', 'album', NULL, 'Op.', '83', 1850, 'manual', 1
FROM composers c
WHERE c.id = 29
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '3개의 노래 Op. 83'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'b6c8418b-47fd-49bf-82f9-0045fbda78da'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'b6c8418b-47fd-49bf-82f9-0045fbda78da'
FROM pieces p
WHERE p.composer_id = 29 AND p.title = '3개의 노래 Op. 83' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'b6c8418b-47fd-49bf-82f9-0045fbda78da'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:62f37e00-869d-386f-b729-2cee24fef51e', 1, NULL, 'Resignation', 'Resignation', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 29 AND p.title = '3개의 노래 Op. 83' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:62f37e00-869d-386f-b729-2cee24fef51e'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:2b70b75d-5411-49cf-b425-4969b754e558', 2, NULL, 'Die Blume der Ergebung', 'Die Blume der Ergebung', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 29 AND p.title = '3개의 노래 Op. 83' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:2b70b75d-5411-49cf-b425-4969b754e558'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:8064b3ec-920e-302a-92fd-c4dc7529306e', 3, NULL, 'Der Einsiedler', 'Der Einsiedler', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 29 AND p.title = '3개의 노래 Op. 83' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:8064b3ec-920e-302a-92fd-c4dc7529306e'
);


-- Op. 84 <이별에 부르는 노래>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '<이별에 부르는 노래>', 'Beim Abschied zu singen', 'song', 'Op. 84', NULL, NULL, 1848, 'manual', 1
FROM composers c
WHERE c.id = 29
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '<이별에 부르는 노래>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '6147ceb9-ec7f-43b0-8c52-a0fbb904ef6c'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '6147ceb9-ec7f-43b0-8c52-a0fbb904ef6c'
FROM pieces p
WHERE p.composer_id = 29 AND p.title = '<이별에 부르는 노래>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '6147ceb9-ec7f-43b0-8c52-a0fbb904ef6c'
);


-- Op. 85 어린이와 어른을 위한 피아노 연탄곡 Op. 85

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '어린이와 어른을 위한 피아노 연탄곡 Op. 85', '12 Klavierstücke für kleine und große Kinder, Op. 85', 'album', NULL, 'Op.', '85', 1849, 'manual', 1
FROM composers c
WHERE c.id = 29
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '어린이와 어른을 위한 피아노 연탄곡 Op. 85'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'e1419e9b-8d91-43fd-b8d9-2603501113fc'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'e1419e9b-8d91-43fd-b8d9-2603501113fc'
FROM pieces p
WHERE p.composer_id = 29 AND p.title = '어린이와 어른을 위한 피아노 연탄곡 Op. 85' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'e1419e9b-8d91-43fd-b8d9-2603501113fc'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:611e7e0a-986f-4791-b92d-0235ebd98265', 1, NULL, 'Geburtstagsmarsch', 'Geburtstagsmarsch', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 29 AND p.title = '어린이와 어른을 위한 피아노 연탄곡 Op. 85' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:611e7e0a-986f-4791-b92d-0235ebd98265'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:5df7561b-5c3c-49c1-a3ff-b40950c3d315', 2, NULL, 'Bärentanz', 'Bärentanz', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 29 AND p.title = '어린이와 어른을 위한 피아노 연탄곡 Op. 85' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:5df7561b-5c3c-49c1-a3ff-b40950c3d315'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:cb20081a-18cd-4e14-b263-4a3b24eebd7e', 3, NULL, 'Gartenmelodie', 'Gartenmelodie', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 29 AND p.title = '어린이와 어른을 위한 피아노 연탄곡 Op. 85' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:cb20081a-18cd-4e14-b263-4a3b24eebd7e'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:6910a960-6f47-43ab-aa86-a589f6f83b58', 4, NULL, 'Turniermarsch', 'Turniermarsch', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 29 AND p.title = '어린이와 어른을 위한 피아노 연탄곡 Op. 85' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:6910a960-6f47-43ab-aa86-a589f6f83b58'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:6122e2c2-558b-4f77-8666-2787b50a8e9f', 5, NULL, 'Reigen', 'Reigen', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 29 AND p.title = '어린이와 어른을 위한 피아노 연탄곡 Op. 85' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:6122e2c2-558b-4f77-8666-2787b50a8e9f'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:917fb126-4113-48cf-abf9-a794c5d1674f', 6, NULL, 'Am Springbrunnen', 'Am Springbrunnen', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 29 AND p.title = '어린이와 어른을 위한 피아노 연탄곡 Op. 85' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:917fb126-4113-48cf-abf9-a794c5d1674f'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:51c0d22c-916c-4f92-9a4f-732b14fe8ddf', 7, NULL, 'Beim Kränzewinden', 'Beim Kränzewinden', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 29 AND p.title = '어린이와 어른을 위한 피아노 연탄곡 Op. 85' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:51c0d22c-916c-4f92-9a4f-732b14fe8ddf'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:7d59c40f-4927-4c2e-a81b-9331aa00dcc9', 8, NULL, 'Croatenmarsch', 'Croatenmarsch', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 29 AND p.title = '어린이와 어른을 위한 피아노 연탄곡 Op. 85' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:7d59c40f-4927-4c2e-a81b-9331aa00dcc9'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:7f441f0d-94db-48f7-a333-0226c8036f2a', 9, NULL, 'Trauer', 'Trauer', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 29 AND p.title = '어린이와 어른을 위한 피아노 연탄곡 Op. 85' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:7f441f0d-94db-48f7-a333-0226c8036f2a'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:19fc1833-bd7f-4a29-ac84-74535ce9e388', 10, NULL, 'Verstecken', 'Verstecken', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 29 AND p.title = '어린이와 어른을 위한 피아노 연탄곡 Op. 85' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:19fc1833-bd7f-4a29-ac84-74535ce9e388'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:80f97023-7f1c-4fac-9e64-bb5e75a89250', 11, NULL, 'Gespenstermärchen', 'Gespenstermärchen', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 29 AND p.title = '어린이와 어른을 위한 피아노 연탄곡 Op. 85' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:80f97023-7f1c-4fac-9e64-bb5e75a89250'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:dd717f5b-f80b-48f3-9a67-e9940ec9b2fb', 12, NULL, 'Abendlied', 'Abendlied', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 29 AND p.title = '어린이와 어른을 위한 피아노 연탄곡 Op. 85' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:dd717f5b-f80b-48f3-9a67-e9940ec9b2fb'
);


-- Op. 86 4대의 호른과 관현악을 위한 콘체르트슈튀크 F장조

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '4대의 호른과 관현악을 위한 콘체르트슈튀크 F장조', 'Konzertstück in F major for four horns and orchestra', 'album', 'Op. 86', NULL, NULL, 1849, 'manual', 1
FROM composers c
WHERE c.id = 29
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '4대의 호른과 관현악을 위한 콘체르트슈튀크 F장조'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '5d641b7f-b3cf-481e-8e15-646ccc975699'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '5d641b7f-b3cf-481e-8e15-646ccc975699'
FROM pieces p
WHERE p.composer_id = 29 AND p.title = '4대의 호른과 관현악을 위한 콘체르트슈튀크 F장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '5d641b7f-b3cf-481e-8e15-646ccc975699'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:6b776ed5-096c-3d2e-b6a9-c3e9788addea', 1, 'I', 'Lebhaft', 'I. Lebhaft', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 29 AND p.title = '4대의 호른과 관현악을 위한 콘체르트슈튀크 F장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:6b776ed5-096c-3d2e-b6a9-c3e9788addea'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:a60b2860-1078-3bdd-8166-d494bdefa727', 2, 'II', '로망스', 'II. Romanze', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 29 AND p.title = '4대의 호른과 관현악을 위한 콘체르트슈튀크 F장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:a60b2860-1078-3bdd-8166-d494bdefa727'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:72f07871-7ecb-39c0-9eba-16564fea5648', 3, 'III', 'Sehr lebhaft', 'III. Sehr lebhaft', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 29 AND p.title = '4대의 호른과 관현악을 위한 콘체르트슈튀크 F장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:72f07871-7ecb-39c0-9eba-16564fea5648'
);


-- Op. 87 발라드 <장갑>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '발라드 <장갑>', 'Der Handschuh', 'song', 'Op. 87', NULL, NULL, 1850, 'manual', 1
FROM composers c
WHERE c.id = 29
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '발라드 <장갑>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'dee14a90-955c-3b73-82b7-7357cce88cac'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'dee14a90-955c-3b73-82b7-7357cce88cac'
FROM pieces p
WHERE p.composer_id = 29 AND p.title = '발라드 <장갑>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'dee14a90-955c-3b73-82b7-7357cce88cac'
);


-- Op. 88 피아노 3중주를 위한 환상소곡집 Op. 88

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '피아노 3중주를 위한 환상소곡집 Op. 88', 'Phantasiestücke for piano trio, Op. 88', 'album', NULL, 'Op.', '88', 1842, 'manual', 1
FROM composers c
WHERE c.id = 29
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '피아노 3중주를 위한 환상소곡집 Op. 88'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '17dc2767-a8e2-3ebf-9713-599e506ecf07'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '17dc2767-a8e2-3ebf-9713-599e506ecf07'
FROM pieces p
WHERE p.composer_id = 29 AND p.title = '피아노 3중주를 위한 환상소곡집 Op. 88' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '17dc2767-a8e2-3ebf-9713-599e506ecf07'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:4d6a2754-3194-4b5b-aa06-8872bf93218b', 1, NULL, '로망스', 'Romanze', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 29 AND p.title = '피아노 3중주를 위한 환상소곡집 Op. 88' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:4d6a2754-3194-4b5b-aa06-8872bf93218b'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:37c52c0d-1a50-4a83-b0be-5537db9e2baf', 2, NULL, '유머레스크', 'Humoreske', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 29 AND p.title = '피아노 3중주를 위한 환상소곡집 Op. 88' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:37c52c0d-1a50-4a83-b0be-5537db9e2baf'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:f8926273-a6b8-46df-b749-c0e7d1d57614', 3, NULL, '듀엣', 'Duett', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 29 AND p.title = '피아노 3중주를 위한 환상소곡집 Op. 88' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:f8926273-a6b8-46df-b749-c0e7d1d57614'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:9203cb72-3bb6-44cb-9a39-0724d8123f9d', 4, NULL, '피날레. Im Marschtempo', 'Finale. Im Marschtempo', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 29 AND p.title = '피아노 3중주를 위한 환상소곡집 Op. 88' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:9203cb72-3bb6-44cb-9a39-0724d8123f9d'
);


-- Op. 89 6개의 노래 Op. 89

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '6개의 노래 Op. 89', '6 Gesänge, Op. 89', 'album', NULL, 'Op.', '89', 1850, 'manual', 1
FROM composers c
WHERE c.id = 29
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '6개의 노래 Op. 89'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '1dab0f2b-f802-404e-ac30-310ea4a797e8'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '1dab0f2b-f802-404e-ac30-310ea4a797e8'
FROM pieces p
WHERE p.composer_id = 29 AND p.title = '6개의 노래 Op. 89' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '1dab0f2b-f802-404e-ac30-310ea4a797e8'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:7a801bd8-faeb-33e0-9c2f-51e71918410d', 1, NULL, 'Es stürmet am Abendhimmel', 'Es stürmet am Abendhimmel', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 29 AND p.title = '6개의 노래 Op. 89' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:7a801bd8-faeb-33e0-9c2f-51e71918410d'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:aa206882-0017-36e2-b2d4-8087cfeab37b', 2, NULL, 'Heimliches Verschwinden', 'Heimliches Verschwinden', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 29 AND p.title = '6개의 노래 Op. 89' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:aa206882-0017-36e2-b2d4-8087cfeab37b'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:660cc019-64a5-3603-895d-81d2f48a1dfd', 3, NULL, 'Herbstlied', 'Herbstlied', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 29 AND p.title = '6개의 노래 Op. 89' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:660cc019-64a5-3603-895d-81d2f48a1dfd'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:38546da6-79b3-3c18-904e-cbe926c19bde', 4, NULL, 'Abschied vom Walde', 'Abschied vom Walde', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 29 AND p.title = '6개의 노래 Op. 89' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:38546da6-79b3-3c18-904e-cbe926c19bde'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:1f15d272-93de-377f-a221-f6833f7cd15e', 5, NULL, 'Ins Freie', 'Ins Freie', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 29 AND p.title = '6개의 노래 Op. 89' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:1f15d272-93de-377f-a221-f6833f7cd15e'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:a0d88251-842c-401c-9b62-a547f590ae01', 6, NULL, 'Röselein, Röselein!', 'Röselein, Röselein!', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 29 AND p.title = '6개의 노래 Op. 89' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:a0d88251-842c-401c-9b62-a547f590ae01'
);


-- Op. 90 6개의 시와 레퀴엠 Op. 90

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '6개의 시와 레퀴엠 Op. 90', '6 Gedichte von Nikolaus Lenau und Requiem, Op. 90', 'album', NULL, 'Op.', '90', 1850, 'manual', 1
FROM composers c
WHERE c.id = 29
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '6개의 시와 레퀴엠 Op. 90'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'ba81a7d1-4c74-44c5-a645-87e6e77e4429'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'ba81a7d1-4c74-44c5-a645-87e6e77e4429'
FROM pieces p
WHERE p.composer_id = 29 AND p.title = '6개의 시와 레퀴엠 Op. 90' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'ba81a7d1-4c74-44c5-a645-87e6e77e4429'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:55f7e08c-881f-38a2-acd0-7e086961ab9b', 1, NULL, 'Lied eines Schmiedes', 'Lied eines Schmiedes', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 29 AND p.title = '6개의 시와 레퀴엠 Op. 90' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:55f7e08c-881f-38a2-acd0-7e086961ab9b'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:edb583db-4c7d-35b2-bc2f-8da0759ac041', 2, NULL, 'Meine Rose', 'Meine Rose', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 29 AND p.title = '6개의 시와 레퀴엠 Op. 90' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:edb583db-4c7d-35b2-bc2f-8da0759ac041'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:d17bbc42-7e2c-3c06-af6f-8f148de00b0a', 3, NULL, 'Kommen und Scheiden', 'Kommen und Scheiden', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 29 AND p.title = '6개의 시와 레퀴엠 Op. 90' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:d17bbc42-7e2c-3c06-af6f-8f148de00b0a'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:e18b3c33-7d10-32be-a76d-21ec7645ada4', 4, NULL, 'Die Sennin', 'Die Sennin', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 29 AND p.title = '6개의 시와 레퀴엠 Op. 90' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:e18b3c33-7d10-32be-a76d-21ec7645ada4'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:b1d2c24e-c225-3808-98ee-1030dfcb8e6e', 5, NULL, 'Einsamkeit', 'Einsamkeit', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 29 AND p.title = '6개의 시와 레퀴엠 Op. 90' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:b1d2c24e-c225-3808-98ee-1030dfcb8e6e'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:8bfc496e-4d1e-3127-a89d-2c86695239e9', 6, NULL, 'Der schwere Abend', 'Der schwere Abend', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 29 AND p.title = '6개의 시와 레퀴엠 Op. 90' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:8bfc496e-4d1e-3127-a89d-2c86695239e9'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:ac3be125-6f28-3363-967f-c307f9cfecf5', 7, NULL, 'Requiem', 'Requiem', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 29 AND p.title = '6개의 시와 레퀴엠 Op. 90' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:ac3be125-6f28-3363-967f-c307f9cfecf5'
);


-- Op. 91 여성 합창을 위한 로망스 2집 Op. 91

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '여성 합창을 위한 로망스 2집 Op. 91', 'Romanzen for female voices, Vol. II, Op. 91', 'album', NULL, 'Op.', '91', 1849, 'manual', 1
FROM composers c
WHERE c.id = 29
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '여성 합창을 위한 로망스 2집 Op. 91'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'ba7fb803-fc06-4007-9c8e-5af4507947c4'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'ba7fb803-fc06-4007-9c8e-5af4507947c4'
FROM pieces p
WHERE p.composer_id = 29 AND p.title = '여성 합창을 위한 로망스 2집 Op. 91' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'ba7fb803-fc06-4007-9c8e-5af4507947c4'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:59005f06-7379-4ad3-a357-42f938e9107e', 1, NULL, 'Rosmarien', 'Rosmarien', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 29 AND p.title = '여성 합창을 위한 로망스 2집 Op. 91' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:59005f06-7379-4ad3-a357-42f938e9107e'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:56c8f371-c6b7-4c87-8f12-6e54529ac3e7', 2, NULL, 'Jäger Wohlgemut', 'Jäger Wohlgemut', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 29 AND p.title = '여성 합창을 위한 로망스 2집 Op. 91' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:56c8f371-c6b7-4c87-8f12-6e54529ac3e7'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:c3e928a0-ec6d-4faa-abba-456c6a9edae6', 3, NULL, 'Der Wassermann', 'Der Wassermann', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 29 AND p.title = '여성 합창을 위한 로망스 2집 Op. 91' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:c3e928a0-ec6d-4faa-abba-456c6a9edae6'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:58023d27-6226-4592-a7b9-c15e7ea37512', 4, NULL, 'Das verlassene Mägdlein', 'Das verlassene Mägdlein', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 29 AND p.title = '여성 합창을 위한 로망스 2집 Op. 91' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:58023d27-6226-4592-a7b9-c15e7ea37512'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:8efd3415-f81e-4294-8770-3a65926c76b0', 5, NULL, 'Der Bleicherin Nachtlied', 'Der Bleicherin Nachtlied', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 29 AND p.title = '여성 합창을 위한 로망스 2집 Op. 91' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:8efd3415-f81e-4294-8770-3a65926c76b0'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:ecbb1b9c-c345-4915-829d-c2102097d0c2', 6, NULL, 'In Meeres Mitten', 'In Meeres Mitten', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 29 AND p.title = '여성 합창을 위한 로망스 2집 Op. 91' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:ecbb1b9c-c345-4915-829d-c2102097d0c2'
);


-- Op. 92 서주와 알레그로 아파시오나토 G장조

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '서주와 알레그로 아파시오나토 G장조', 'Introduction and Allegro appassionato in G major', 'album', 'Op. 92', NULL, NULL, 1849, 'manual', 1
FROM composers c
WHERE c.id = 29
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '서주와 알레그로 아파시오나토 G장조'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '21560c8d-d56c-3540-b550-3f91607fb052'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '21560c8d-d56c-3540-b550-3f91607fb052'
FROM pieces p
WHERE p.composer_id = 29 AND p.title = '서주와 알레그로 아파시오나토 G장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '21560c8d-d56c-3540-b550-3f91607fb052'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:632168ca-1016-4402-836f-55fca998e7a3', 1, 'I', '서주. Langsam', 'I. Introduction. Langsam', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 29 AND p.title = '서주와 알레그로 아파시오나토 G장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:632168ca-1016-4402-836f-55fca998e7a3'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:329df87c-5fef-4409-b573-f92308d6aa33', 2, 'II', 'Allegro appassionato', 'II. Allegro appassionato', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 29 AND p.title = '서주와 알레그로 아파시오나토 G장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:329df87c-5fef-4409-b573-f92308d6aa33'
);


-- Op. 93 모테트 <슬픔의 골짜기에서 절망하지 말라>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '모테트 <슬픔의 골짜기에서 절망하지 말라>', 'Motet "Verzweifle nicht im Schmerzenstal"', 'song', 'Op. 93', NULL, NULL, 1852, 'manual', 1
FROM composers c
WHERE c.id = 29
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '모테트 <슬픔의 골짜기에서 절망하지 말라>'
);


-- Op. 94 로망스 Op. 94

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '로망스 Op. 94', '3 Romanzen for oboe and piano, Op. 94', 'album', NULL, 'Op.', '94', 1849, 'manual', 1
FROM composers c
WHERE c.id = 29
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '로망스 Op. 94'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '82fd9848-9cc5-4123-91de-28e60ffae2f3'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '82fd9848-9cc5-4123-91de-28e60ffae2f3'
FROM pieces p
WHERE p.composer_id = 29 AND p.title = '로망스 Op. 94' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '82fd9848-9cc5-4123-91de-28e60ffae2f3'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:de477541-d1dd-401f-ac32-6fc6fdadb0ec', 1, NULL, 'Nicht schnell', 'No. 1. Nicht schnell', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 29 AND p.title = '로망스 Op. 94' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:de477541-d1dd-401f-ac32-6fc6fdadb0ec'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:f1f1eb87-0586-490e-9544-f6a2b65ff38a', 2, NULL, 'Einfach, innig', 'No. 2. Einfach, innig', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 29 AND p.title = '로망스 Op. 94' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:f1f1eb87-0586-490e-9544-f6a2b65ff38a'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:fe3b3704-a3e9-4ffd-aa05-330b09105c5a', 3, NULL, 'Nicht schnell', 'No. 3. Nicht schnell', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 29 AND p.title = '로망스 Op. 94' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:fe3b3704-a3e9-4ffd-aa05-330b09105c5a'
);


-- Op. 95 3개의 노래 Op. 95

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '3개의 노래 Op. 95', '3 Gesänge aus Lord Byrons "Hebräischen Gesängen", Op. 95', 'album', NULL, 'Op.', '95', 1849, 'manual', 1
FROM composers c
WHERE c.id = 29
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '3개의 노래 Op. 95'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '50f46b1e-4dcd-4580-8ba8-2e5c04d892db'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '50f46b1e-4dcd-4580-8ba8-2e5c04d892db'
FROM pieces p
WHERE p.composer_id = 29 AND p.title = '3개의 노래 Op. 95' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '50f46b1e-4dcd-4580-8ba8-2e5c04d892db'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:70581fb4-042e-47b4-bbce-7f0c1ae6bc97', 1, NULL, 'Die Tochter Jephtas', 'Die Tochter Jephtas', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 29 AND p.title = '3개의 노래 Op. 95' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:70581fb4-042e-47b4-bbce-7f0c1ae6bc97'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:6fa930e3-9a0e-3978-a227-09c9f457569d', 2, NULL, 'An den Mond', 'An den Mond', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 29 AND p.title = '3개의 노래 Op. 95' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:6fa930e3-9a0e-3978-a227-09c9f457569d'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:5ab5370a-0f13-4c29-aed0-04a42094453c', 3, NULL, 'Dem Helden', 'Dem Helden', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 29 AND p.title = '3개의 노래 Op. 95' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:5ab5370a-0f13-4c29-aed0-04a42094453c'
);


-- Op. 96 가곡과 노래 4집 Op. 96

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '가곡과 노래 4집 Op. 96', 'Lieder und Gesänge, Vol. IV, Op. 96', 'album', NULL, 'Op.', '96', 1850, 'manual', 1
FROM composers c
WHERE c.id = 29
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '가곡과 노래 4집 Op. 96'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '927026e2-1d73-43d9-9839-3e2edd218aae'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '927026e2-1d73-43d9-9839-3e2edd218aae'
FROM pieces p
WHERE p.composer_id = 29 AND p.title = '가곡과 노래 4집 Op. 96' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '927026e2-1d73-43d9-9839-3e2edd218aae'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:b3c7a4b6-d0ec-3bee-af01-d37b4381a1d6', 1, NULL, 'Nachtlied', 'Nachtlied', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 29 AND p.title = '가곡과 노래 4집 Op. 96' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:b3c7a4b6-d0ec-3bee-af01-d37b4381a1d6'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:12ece67c-6a17-3f90-90cd-996c3a233881', 2, NULL, 'Schneeglöckchen', 'Schneeglöckchen', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 29 AND p.title = '가곡과 노래 4집 Op. 96' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:12ece67c-6a17-3f90-90cd-996c3a233881'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:231d170e-d492-3a77-bed4-3ee0d73c6c24', 3, NULL, 'Ihre Stimme', 'Ihre Stimme', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 29 AND p.title = '가곡과 노래 4집 Op. 96' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:231d170e-d492-3a77-bed4-3ee0d73c6c24'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:47d0b20b-e36c-44f5-834f-48aa31c47fad', 4, NULL, 'Gesungen!', 'Gesungen!', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 29 AND p.title = '가곡과 노래 4집 Op. 96' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:47d0b20b-e36c-44f5-834f-48aa31c47fad'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:24dff521-184f-435a-aa1c-e60a44416f7b', 5, NULL, 'Himmel und Erde', 'Himmel und Erde', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 29 AND p.title = '가곡과 노래 4집 Op. 96' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:24dff521-184f-435a-aa1c-e60a44416f7b'
);


-- Op. 97 교향곡 3번 E♭장조 "라인"

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '458186d5-a2a3-3779-bb42-495be84966ae'
FROM pieces p
WHERE p.id = 137 AND p.composer_id = 29
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '458186d5-a2a3-3779-bb42-495be84966ae'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:8b708315-b420-369b-b488-e2cb015374f7', 1, 'I', 'Lebhaft', 'I. Lebhaft', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 137 AND p.composer_id = 29
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:8b708315-b420-369b-b488-e2cb015374f7'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:fbb0900e-e851-35a3-83f8-8f8d0a8f4f6e', 2, 'II', '스케르초. Sehr mäßig', 'II. Scherzo. Sehr mäßig', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 137 AND p.composer_id = 29
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:fbb0900e-e851-35a3-83f8-8f8d0a8f4f6e'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:dff57147-71ce-3f65-8faf-c2f63a4e2700', 3, 'III', 'Nicht schnell', 'III. Nicht schnell', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 137 AND p.composer_id = 29
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:dff57147-71ce-3f65-8faf-c2f63a4e2700'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:48641987-624b-3b71-9913-25a272be8232', 4, 'IV', 'Feierlich', 'IV. Feierlich', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 137 AND p.composer_id = 29
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:48641987-624b-3b71-9913-25a272be8232'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:da11a6bc-4eb4-337d-afdc-facff96eeee4', 5, 'V', 'Lebhaft', 'V. Lebhaft', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 137 AND p.composer_id = 29
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:da11a6bc-4eb4-337d-afdc-facff96eeee4'
);


-- Op. 98a <빌헬름 마이스터>에 의한 가곡과 노래

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '<빌헬름 마이스터>에 의한 가곡과 노래', 'Lieder und Gesänge aus "Wilhelm Meister"', 'album', 'Op. 98a', NULL, NULL, 1849, 'manual', 1
FROM composers c
WHERE c.id = 29
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '<빌헬름 마이스터>에 의한 가곡과 노래'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'cebcdda0-f07f-4b2b-9109-aaa620402a4a'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'cebcdda0-f07f-4b2b-9109-aaa620402a4a'
FROM pieces p
WHERE p.composer_id = 29 AND p.title = '<빌헬름 마이스터>에 의한 가곡과 노래' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'cebcdda0-f07f-4b2b-9109-aaa620402a4a'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:3768928b-faab-4c01-bcc7-1ad0f2a6de22', 1, NULL, 'Mignon ("Kennst du das Land")', 'Mignon ("Kennst du das Land")', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 29 AND p.title = '<빌헬름 마이스터>에 의한 가곡과 노래' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:3768928b-faab-4c01-bcc7-1ad0f2a6de22'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:c94e2bd4-2195-44ea-a220-f70a84e4e831', 2, NULL, 'Ballade des Harfners', 'Ballade des Harfners', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 29 AND p.title = '<빌헬름 마이스터>에 의한 가곡과 노래' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:c94e2bd4-2195-44ea-a220-f70a84e4e831'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:fbf0a316-9ef4-4ace-97d9-5ddedbee98ba', 3, NULL, 'Nur wer die Sehnsucht kennt', 'Nur wer die Sehnsucht kennt', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 29 AND p.title = '<빌헬름 마이스터>에 의한 가곡과 노래' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:fbf0a316-9ef4-4ace-97d9-5ddedbee98ba'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:73318e11-c000-413f-88ad-64419cf661b6', 4, NULL, 'Wie nie sein Brot mit Tränen aß', 'Wie nie sein Brot mit Tränen aß', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 29 AND p.title = '<빌헬름 마이스터>에 의한 가곡과 노래' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:73318e11-c000-413f-88ad-64419cf661b6'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:bafff1b0-663d-4cc6-b037-3dc4704469b7', 5, NULL, 'Heiss mich nicht reden', 'Heiss mich nicht reden', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 29 AND p.title = '<빌헬름 마이스터>에 의한 가곡과 노래' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:bafff1b0-663d-4cc6-b037-3dc4704469b7'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:f2480ee2-2b1b-40df-a369-e3db64ac2d38', 6, NULL, 'Wer sich der Einsamkeit ergibt', 'Wer sich der Einsamkeit ergibt', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 29 AND p.title = '<빌헬름 마이스터>에 의한 가곡과 노래' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:f2480ee2-2b1b-40df-a369-e3db64ac2d38'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:cd4098ca-0bd8-463e-b75a-f4516c463066', 7, NULL, 'Singet nicht in Trauertönen', 'Singet nicht in Trauertönen', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 29 AND p.title = '<빌헬름 마이스터>에 의한 가곡과 노래' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:cd4098ca-0bd8-463e-b75a-f4516c463066'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:9392d0ff-8ff3-4cc5-a636-89e2ef04b1a1', 8, NULL, 'An die Türen will ich schleichen', 'An die Türen will ich schleichen', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 29 AND p.title = '<빌헬름 마이스터>에 의한 가곡과 노래' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:9392d0ff-8ff3-4cc5-a636-89e2ef04b1a1'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:49b2d767-fad4-4196-9ae5-0d5b3781aa19', 9, NULL, 'So lasst mich scheinen, bis ich werde', 'So lasst mich scheinen, bis ich werde', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 29 AND p.title = '<빌헬름 마이스터>에 의한 가곡과 노래' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:49b2d767-fad4-4196-9ae5-0d5b3781aa19'
);


-- Op. 98b <미뇽을 위한 레퀴엠>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '<미뇽을 위한 레퀴엠>', 'Requiem für Mignon', 'song', 'Op. 98b', NULL, NULL, 1849, 'manual', 1
FROM composers c
WHERE c.id = 29
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '<미뇽을 위한 레퀴엠>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '79b06147-751a-4553-bd8c-c1d936817957'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '79b06147-751a-4553-bd8c-c1d936817957'
FROM pieces p
WHERE p.composer_id = 29 AND p.title = '<미뇽을 위한 레퀴엠>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '79b06147-751a-4553-bd8c-c1d936817957'
);


-- Op. 99 피아노 모음곡 <다채로운 잎>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '피아노 모음곡 <다채로운 잎>', 'Bunte Blätter', 'album', 'Op. 99', NULL, NULL, 1849, 'manual', 1
FROM composers c
WHERE c.id = 29
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '피아노 모음곡 <다채로운 잎>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'c2012c1f-912e-42f6-9590-ce894ba9aab4'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'c2012c1f-912e-42f6-9590-ce894ba9aab4'
FROM pieces p
WHERE p.composer_id = 29 AND p.title = '피아노 모음곡 <다채로운 잎>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'c2012c1f-912e-42f6-9590-ce894ba9aab4'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:5c0d5b37-7200-4d45-a166-4bd14d16e6c4', 1, NULL, 'Nicht schnell, mit Innigkeit', 'No. 1. Nicht schnell, mit Innigkeit', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 29 AND p.title = '피아노 모음곡 <다채로운 잎>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:5c0d5b37-7200-4d45-a166-4bd14d16e6c4'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:13db86fc-bd6a-40c4-aeaa-1a16f81dff4b', 2, NULL, 'Sehr rasch', 'No. 2. Sehr rasch', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 29 AND p.title = '피아노 모음곡 <다채로운 잎>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:13db86fc-bd6a-40c4-aeaa-1a16f81dff4b'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:82590445-c822-4562-9371-27deb6b21565', 3, NULL, 'Frisch', 'No. 3. Frisch', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 29 AND p.title = '피아노 모음곡 <다채로운 잎>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:82590445-c822-4562-9371-27deb6b21565'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:5dd2c17f-ed5a-421f-8f31-88454e3faa08', 4, NULL, 'Ziemlich langsam', 'No. 4. Ziemlich langsam', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 29 AND p.title = '피아노 모음곡 <다채로운 잎>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:5dd2c17f-ed5a-421f-8f31-88454e3faa08'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:a84f052e-80b8-4c52-abc5-5f43ffbe5611', 5, NULL, 'Schnell', 'No. 5. Schnell', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 29 AND p.title = '피아노 모음곡 <다채로운 잎>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:a84f052e-80b8-4c52-abc5-5f43ffbe5611'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:21580539-8d57-429f-ba3b-ce798a6e511b', 6, NULL, 'Ziemlich langsam, sehr gesangsvoll', 'No. 6. Ziemlich langsam, sehr gesangsvoll', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 29 AND p.title = '피아노 모음곡 <다채로운 잎>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:21580539-8d57-429f-ba3b-ce798a6e511b'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:3ce3ad98-d105-4cff-a49c-0764dbba74f2', 7, NULL, 'Sehr langsam', 'No. 7. Sehr langsam', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 29 AND p.title = '피아노 모음곡 <다채로운 잎>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:3ce3ad98-d105-4cff-a49c-0764dbba74f2'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:e5680727-cada-446e-8b8f-e27f0074d238', 8, NULL, 'Langsam', 'No. 8. Langsam', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 29 AND p.title = '피아노 모음곡 <다채로운 잎>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:e5680727-cada-446e-8b8f-e27f0074d238'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:6f73deb8-625a-43cb-a269-61090a75351a', 9, NULL, '노벨레테', 'Novellette', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 29 AND p.title = '피아노 모음곡 <다채로운 잎>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:6f73deb8-625a-43cb-a269-61090a75351a'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:065ccb46-a041-4645-ac53-ea904ef42731', 10, NULL, '전주곡', 'Präludium', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 29 AND p.title = '피아노 모음곡 <다채로운 잎>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:065ccb46-a041-4645-ac53-ea904ef42731'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:87b6314b-12e4-404b-ab3f-40e2f448ff29', 11, NULL, '행진곡', 'Marsch', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 29 AND p.title = '피아노 모음곡 <다채로운 잎>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:87b6314b-12e4-404b-ab3f-40e2f448ff29'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:a9b883f5-f489-4e80-8535-3bec98ba24fe', 12, NULL, 'Abendmusik', 'Abendmusik', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 29 AND p.title = '피아노 모음곡 <다채로운 잎>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:a9b883f5-f489-4e80-8535-3bec98ba24fe'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:63d29de7-75a6-4098-a7e6-5f80848cd8b2', 13, NULL, '스케르초', 'Scherzo', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 29 AND p.title = '피아노 모음곡 <다채로운 잎>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:63d29de7-75a6-4098-a7e6-5f80848cd8b2'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:26494a0b-e106-4e03-b84c-2a300e7345be', 14, NULL, 'Geschwindmarsch', 'Geschwindmarsch', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 29 AND p.title = '피아노 모음곡 <다채로운 잎>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:26494a0b-e106-4e03-b84c-2a300e7345be'
);


-- Op. 100 서곡 <메시나의 신부>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '서곡 <메시나의 신부>', 'Overture to Die Braut von Messina', 'song', 'Op. 100', NULL, NULL, 1851, 'manual', 1
FROM composers c
WHERE c.id = 29
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '서곡 <메시나의 신부>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'c3169814-a98b-351f-8b04-56aecbb1a099'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'c3169814-a98b-351f-8b04-56aecbb1a099'
FROM pieces p
WHERE p.composer_id = 29 AND p.title = '서곡 <메시나의 신부>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'c3169814-a98b-351f-8b04-56aecbb1a099'
);


-- Op. 101 가곡집 <민네슈필>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '가곡집 <민네슈필>', 'Minnespiel', 'album', 'Op. 101', NULL, NULL, 1849, 'manual', 1
FROM composers c
WHERE c.id = 29
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '가곡집 <민네슈필>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '092a451b-a51d-48c2-9bda-fae8ab753daf'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '092a451b-a51d-48c2-9bda-fae8ab753daf'
FROM pieces p
WHERE p.composer_id = 29 AND p.title = '가곡집 <민네슈필>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '092a451b-a51d-48c2-9bda-fae8ab753daf'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:4291e56f-e4b0-4e59-bad3-8dba9da6da56', 1, NULL, 'Meine Töne still und heiter', 'Meine Töne still und heiter', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 29 AND p.title = '가곡집 <민네슈필>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:4291e56f-e4b0-4e59-bad3-8dba9da6da56'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:31fb6137-95b3-45b6-acd4-e73e0eec0f92', 2, NULL, 'Liebster, deine Worte stehlen', 'Liebster, deine Worte stehlen', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 29 AND p.title = '가곡집 <민네슈필>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:31fb6137-95b3-45b6-acd4-e73e0eec0f92'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:a565f5a8-6765-46b8-8a20-1aac79783c42', 3, NULL, 'Ich bin dein Baum', 'Ich bin dein Baum', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 29 AND p.title = '가곡집 <민네슈필>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:a565f5a8-6765-46b8-8a20-1aac79783c42'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:b7ffb074-7011-3a2f-9ec5-b59d747b8477', 4, NULL, 'Mein schöner Stern!', 'Mein schöner Stern!', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 29 AND p.title = '가곡집 <민네슈필>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:b7ffb074-7011-3a2f-9ec5-b59d747b8477'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:dc8063fa-7d8d-4957-8ba3-f1e9e9ddc988', 5, NULL, 'Schön ist das Fest des Lenzes', 'Schön ist das Fest des Lenzes', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 29 AND p.title = '가곡집 <민네슈필>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:dc8063fa-7d8d-4957-8ba3-f1e9e9ddc988'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:387a16fb-7d19-45b5-a29d-b2eee587fcf1', 6, NULL, 'O Freund, mein Schirm, mein Schütz!', 'O Freund, mein Schirm, mein Schütz!', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 29 AND p.title = '가곡집 <민네슈필>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:387a16fb-7d19-45b5-a29d-b2eee587fcf1'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:e6891983-3f90-40d8-a6b0-868f56aa632d', 7, NULL, 'Die tausend Grüße', 'Die tausend Grüße', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 29 AND p.title = '가곡집 <민네슈필>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:e6891983-3f90-40d8-a6b0-868f56aa632d'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:f87ff6bb-c400-4e54-8408-0e6020ff479b', 8, NULL, 'So wahr die Sonne scheinet', 'So wahr die Sonne scheinet', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 29 AND p.title = '가곡집 <민네슈필>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:f87ff6bb-c400-4e54-8408-0e6020ff479b'
);


-- Op. 102 민요풍의 소품 Op. 102

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '민요풍의 소품 Op. 102', '5 Stücke im Volkston, Op. 102', 'album', NULL, 'Op.', '102', 1849, 'manual', 1
FROM composers c
WHERE c.id = 29
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '민요풍의 소품 Op. 102'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '5b5854f8-8fed-47fc-89e3-0129af58856d'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '5b5854f8-8fed-47fc-89e3-0129af58856d'
FROM pieces p
WHERE p.composer_id = 29 AND p.title = '민요풍의 소품 Op. 102' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '5b5854f8-8fed-47fc-89e3-0129af58856d'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:7cd8f4fc-a20a-481f-8775-d59ae8a6e604', 1, NULL, 'Vanitas vanitatum (Mit Humor)', 'No. 1. Vanitas vanitatum (Mit Humor)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 29 AND p.title = '민요풍의 소품 Op. 102' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:7cd8f4fc-a20a-481f-8775-d59ae8a6e604'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:75e0628f-b584-4e45-a45c-565065a4c1a4', 2, NULL, 'Langsam', 'No. 2. Langsam', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 29 AND p.title = '민요풍의 소품 Op. 102' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:75e0628f-b584-4e45-a45c-565065a4c1a4'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:0ef2543a-5e89-4d90-a475-e074750e6528', 3, NULL, 'Nicht schnell, mit viel Ton zu spielen', 'No. 3. Nicht schnell, mit viel Ton zu spielen', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 29 AND p.title = '민요풍의 소품 Op. 102' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:0ef2543a-5e89-4d90-a475-e074750e6528'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:70e4feaa-1e38-4d37-81f5-5aef8d24dac6', 4, NULL, 'Nicht zu rasch', 'No. 4. Nicht zu rasch', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 29 AND p.title = '민요풍의 소품 Op. 102' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:70e4feaa-1e38-4d37-81f5-5aef8d24dac6'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:674926b1-6f08-4f61-a785-41be8e900c5d', 5, NULL, 'Stark und markiert', 'No. 5. Stark und markiert', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 29 AND p.title = '민요풍의 소품 Op. 102' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:674926b1-6f08-4f61-a785-41be8e900c5d'
);


-- Op. 103 가곡집 <소녀의 노래>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '가곡집 <소녀의 노래>', 'Mädchenlieder', 'album', 'Op. 103', NULL, NULL, 1851, 'manual', 1
FROM composers c
WHERE c.id = 29
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '가곡집 <소녀의 노래>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'a4594401-3389-4353-a585-35c1e5b7269a'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'a4594401-3389-4353-a585-35c1e5b7269a'
FROM pieces p
WHERE p.composer_id = 29 AND p.title = '가곡집 <소녀의 노래>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'a4594401-3389-4353-a585-35c1e5b7269a'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:a7d352c9-4ba2-4528-8312-769ccb2aaa14', 1, NULL, 'Mailied', 'Mailied', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 29 AND p.title = '가곡집 <소녀의 노래>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:a7d352c9-4ba2-4528-8312-769ccb2aaa14'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:0750aaee-727a-4727-9318-c333dc83e7d9', 2, NULL, 'Frühlingslied', 'Frühlingslied', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 29 AND p.title = '가곡집 <소녀의 노래>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:0750aaee-727a-4727-9318-c333dc83e7d9'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:36e3bfc4-e300-428c-82ac-ea982099eb31', 3, NULL, 'An die Nachtigall', 'An die Nachtigall', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 29 AND p.title = '가곡집 <소녀의 노래>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:36e3bfc4-e300-428c-82ac-ea982099eb31'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:c42953ad-9a51-40a6-98d9-fd58af81b45f', 4, NULL, 'An den Abendstern', 'An den Abendstern', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 29 AND p.title = '가곡집 <소녀의 노래>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:c42953ad-9a51-40a6-98d9-fd58af81b45f'
);


-- Op. 104 7개의 가곡 Op. 104

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '7개의 가곡 Op. 104', '7 Lieder, Op. 104', 'album', NULL, 'Op.', '104', 1851, 'manual', 1
FROM composers c
WHERE c.id = 29
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '7개의 가곡 Op. 104'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '06ada113-e4a8-4238-839a-43ca573188d5'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '06ada113-e4a8-4238-839a-43ca573188d5'
FROM pieces p
WHERE p.composer_id = 29 AND p.title = '7개의 가곡 Op. 104' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '06ada113-e4a8-4238-839a-43ca573188d5'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:2b9cf4e6-1b12-404a-8242-b5572847c033', 1, NULL, 'Mond, meiner Seele Liebling', 'Mond, meiner Seele Liebling', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 29 AND p.title = '7개의 가곡 Op. 104' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:2b9cf4e6-1b12-404a-8242-b5572847c033'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:2ab45505-9919-4610-84ca-ac8b5cabb173', 2, NULL, 'Viel Glück zur Reise', 'Viel Glück zur Reise', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 29 AND p.title = '7개의 가곡 Op. 104' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:2ab45505-9919-4610-84ca-ac8b5cabb173'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:03f572dd-aa0e-4b9f-8fd6-1056358618e4', 3, NULL, 'Du nennst mich armes Mädchen', 'Du nennst mich armes Mädchen', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 29 AND p.title = '7개의 가곡 Op. 104' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:03f572dd-aa0e-4b9f-8fd6-1056358618e4'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:7ba7b0e5-03b2-42e4-b9c1-ae52bac92049', 4, NULL, 'Der Zeisig', 'Der Zeisig', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 29 AND p.title = '7개의 가곡 Op. 104' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:7ba7b0e5-03b2-42e4-b9c1-ae52bac92049'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:4bbb163b-b06a-46f7-b369-199b7e4b8bd2', 5, NULL, 'Reich'' mir die Hand', 'Reich'' mir die Hand', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 29 AND p.title = '7개의 가곡 Op. 104' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:4bbb163b-b06a-46f7-b369-199b7e4b8bd2'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:650876f0-ed12-4686-a377-d714a5d22d6f', 6, NULL, 'Die letzten Blumen starben', 'Die letzten Blumen starben', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 29 AND p.title = '7개의 가곡 Op. 104' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:650876f0-ed12-4686-a377-d714a5d22d6f'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:b3455df4-6a5e-4f4e-9b6c-79415e991290', 7, NULL, 'Gekämpft hat meine Barke', 'Gekämpft hat meine Barke', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 29 AND p.title = '7개의 가곡 Op. 104' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:b3455df4-6a5e-4f4e-9b6c-79415e991290'
);


-- Op. 105 바이올린 소나타 1번 A단조

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '바이올린 소나타 1번 A단조', 'Violin Sonata No. 1 in A minor', 'album', 'Op. 105', NULL, NULL, 1851, 'manual', 1
FROM composers c
WHERE c.id = 29
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '바이올린 소나타 1번 A단조'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '43277b1d-4a2d-45eb-90f9-9811892dc624'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '43277b1d-4a2d-45eb-90f9-9811892dc624'
FROM pieces p
WHERE p.composer_id = 29 AND p.title = '바이올린 소나타 1번 A단조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '43277b1d-4a2d-45eb-90f9-9811892dc624'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:2cdc4423-e3a4-30b9-8298-64d698a45ef4', 1, 'I', 'Mit leidenschaftlichem Ausdruck', 'I. Mit leidenschaftlichem Ausdruck', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 29 AND p.title = '바이올린 소나타 1번 A단조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:2cdc4423-e3a4-30b9-8298-64d698a45ef4'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:bbb9c51b-c72c-327a-b2f1-0dc367aefa26', 2, 'II', 'Allegretto', 'II. Allegretto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 29 AND p.title = '바이올린 소나타 1번 A단조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:bbb9c51b-c72c-327a-b2f1-0dc367aefa26'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:8e9674bf-284d-37d8-bbf3-9ff16702a4db', 3, 'III', 'Lebhaft', 'III. Lebhaft', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 29 AND p.title = '바이올린 소나타 1번 A단조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:8e9674bf-284d-37d8-bbf3-9ff16702a4db'
);


-- Op. 106 낭송곡 <아름다운 헤트비히>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '낭송곡 <아름다운 헤트비히>', 'Schön Hedwig', 'song', 'Op. 106', NULL, NULL, 1849, 'manual', 1
FROM composers c
WHERE c.id = 29
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '낭송곡 <아름다운 헤트비히>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'b734a074-bb2e-35ee-9203-3ff58f9a2861'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'b734a074-bb2e-35ee-9203-3ff58f9a2861'
FROM pieces p
WHERE p.composer_id = 29 AND p.title = '낭송곡 <아름다운 헤트비히>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'b734a074-bb2e-35ee-9203-3ff58f9a2861'
);


-- Op. 107 6개의 노래 Op. 107

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '6개의 노래 Op. 107', '6 Gesänge, Op. 107', 'album', NULL, 'Op.', '107', 1852, 'manual', 1
FROM composers c
WHERE c.id = 29
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '6개의 노래 Op. 107'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '03b3a141-68ab-41dd-8557-02aaa982749c'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '03b3a141-68ab-41dd-8557-02aaa982749c'
FROM pieces p
WHERE p.composer_id = 29 AND p.title = '6개의 노래 Op. 107' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '03b3a141-68ab-41dd-8557-02aaa982749c'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:09a3bc46-262a-4563-86d7-1f559d297dcd', 1, NULL, 'Herzeleid', 'Herzeleid', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 29 AND p.title = '6개의 노래 Op. 107' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:09a3bc46-262a-4563-86d7-1f559d297dcd'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:61fb936a-c7ad-4114-9962-9e0406201bf3', 2, NULL, 'Die Fensterscheibe', 'Die Fensterscheibe', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 29 AND p.title = '6개의 노래 Op. 107' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:61fb936a-c7ad-4114-9962-9e0406201bf3'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:3e230d49-aa09-37bd-9ede-06de4491671c', 3, NULL, 'Der Gärtner', 'Der Gärtner', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 29 AND p.title = '6개의 노래 Op. 107' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:3e230d49-aa09-37bd-9ede-06de4491671c'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:a9b6acac-2e37-4cf7-97c3-d254da25dc77', 4, NULL, 'Die Spinnerin', 'Die Spinnerin', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 29 AND p.title = '6개의 노래 Op. 107' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:a9b6acac-2e37-4cf7-97c3-d254da25dc77'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:d08497f9-4c3d-471f-a19c-01e4a5996e3f', 5, NULL, 'Im Wald', 'Im Wald', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 29 AND p.title = '6개의 노래 Op. 107' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:d08497f9-4c3d-471f-a19c-01e4a5996e3f'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:712928ac-a518-31e8-b5d4-61f0e2985f73', 6, NULL, 'Abendlied', 'Abendlied', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 29 AND p.title = '6개의 노래 Op. 107' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:712928ac-a518-31e8-b5d4-61f0e2985f73'
);


-- Op. 108 합창과 관현악을 위한 <밤의 노래>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '합창과 관현악을 위한 <밤의 노래>', 'Nachtlied', 'song', 'Op. 108', NULL, NULL, 1849, 'manual', 1
FROM composers c
WHERE c.id = 29
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '합창과 관현악을 위한 <밤의 노래>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '143d8363-65e3-46ea-a030-313a95beda86'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '143d8363-65e3-46ea-a030-313a95beda86'
FROM pieces p
WHERE p.composer_id = 29 AND p.title = '합창과 관현악을 위한 <밤의 노래>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '143d8363-65e3-46ea-a030-313a95beda86'
);


-- Op. 109 피아노 연탄 모음곡 <무도회 장면>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '피아노 연탄 모음곡 <무도회 장면>', 'Ballszenen', 'album', 'Op. 109', NULL, NULL, 1851, 'manual', 1
FROM composers c
WHERE c.id = 29
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '피아노 연탄 모음곡 <무도회 장면>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '064286e9-a7b1-44da-a16c-0861d814e352'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '064286e9-a7b1-44da-a16c-0861d814e352'
FROM pieces p
WHERE p.composer_id = 29 AND p.title = '피아노 연탄 모음곡 <무도회 장면>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '064286e9-a7b1-44da-a16c-0861d814e352'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:b31a1519-bfa7-4ffa-a433-63f32f738137', 1, NULL, 'Préambule. Festlich', 'Préambule. Festlich', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 29 AND p.title = '피아노 연탄 모음곡 <무도회 장면>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:b31a1519-bfa7-4ffa-a433-63f32f738137'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:4be45283-ece3-4a6f-ada1-fb107163bb97', 2, NULL, '폴로네즈. Nicht zu schnell', 'Polonaise. Nicht zu schnell', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 29 AND p.title = '피아노 연탄 모음곡 <무도회 장면>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:4be45283-ece3-4a6f-ada1-fb107163bb97'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:38b6f664-e61c-47d9-b4a2-f1d97879bff7', 3, NULL, '왈츠. Mäßiges Tempo', 'Walzer. Mäßiges Tempo', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 29 AND p.title = '피아노 연탄 모음곡 <무도회 장면>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:38b6f664-e61c-47d9-b4a2-f1d97879bff7'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:eae3147c-ff4b-4dc1-8bf8-5b8ce01d9191', 4, NULL, 'Ungarisch. Lebhaft', 'Ungarisch. Lebhaft', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 29 AND p.title = '피아노 연탄 모음곡 <무도회 장면>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:eae3147c-ff4b-4dc1-8bf8-5b8ce01d9191'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:f74ddbce-7fe1-404d-9130-91223a409f80', 5, NULL, '프랑세즈. Ziemlich schnell', 'Française. Ziemlich schnell', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 29 AND p.title = '피아노 연탄 모음곡 <무도회 장면>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:f74ddbce-7fe1-404d-9130-91223a409f80'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:db019e8c-d11f-4ae2-a6f1-88f440f4b474', 6, NULL, '마주르카', 'Mazurka', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 29 AND p.title = '피아노 연탄 모음곡 <무도회 장면>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:db019e8c-d11f-4ae2-a6f1-88f440f4b474'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:631c7c77-3567-4e50-99d0-4ecb82bb846f', 7, NULL, '에코세즈. Lebhaft, doch nicht zu schnell', 'Ecossaise. Lebhaft, doch nicht zu schnell', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 29 AND p.title = '피아노 연탄 모음곡 <무도회 장면>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:631c7c77-3567-4e50-99d0-4ecb82bb846f'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:d151b4ea-9537-417d-b0cd-f86dead9bd4b', 8, NULL, '왈츠. Lebhaft', 'Walzer. Lebhaft', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 29 AND p.title = '피아노 연탄 모음곡 <무도회 장면>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:d151b4ea-9537-417d-b0cd-f86dead9bd4b'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:92bd653a-1fa9-4f6f-b49e-74405b10f487', 9, NULL, 'Promenade. Nicht schnell, feierlich', 'Promenade. Nicht schnell, feierlich', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 29 AND p.title = '피아노 연탄 모음곡 <무도회 장면>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:92bd653a-1fa9-4f6f-b49e-74405b10f487'
);


-- Op. 110 피아노 3중주 3번 G단조

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '피아노 3중주 3번 G단조', 'Piano Trio No. 3 in G minor', 'album', 'Op. 110', NULL, NULL, 1851, 'manual', 1
FROM composers c
WHERE c.id = 29
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '피아노 3중주 3번 G단조'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '05656440-f034-4454-b998-53207069ccfb'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '05656440-f034-4454-b998-53207069ccfb'
FROM pieces p
WHERE p.composer_id = 29 AND p.title = '피아노 3중주 3번 G단조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '05656440-f034-4454-b998-53207069ccfb'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:655174ca-3706-49b7-ad28-2eb53bc9c840', 1, 'I', 'Bewegt, doch nicht zu rasch', 'I. Bewegt, doch nicht zu rasch', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 29 AND p.title = '피아노 3중주 3번 G단조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:655174ca-3706-49b7-ad28-2eb53bc9c840'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:2c9fd609-cf6d-46d4-b5db-71a70a135d50', 2, 'II', 'Ziemlich langsam', 'II. Ziemlich langsam', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 29 AND p.title = '피아노 3중주 3번 G단조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:2c9fd609-cf6d-46d4-b5db-71a70a135d50'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:a10b7e29-c2aa-4d6a-ab4d-1bd14feb5488', 3, 'III', 'Rasch', 'III. Rasch', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 29 AND p.title = '피아노 3중주 3번 G단조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:a10b7e29-c2aa-4d6a-ab4d-1bd14feb5488'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:2bfb4198-2a28-4ce2-9373-0021568aac10', 4, 'IV', 'Kräftig, mit Humor', 'IV. Kräftig, mit Humor', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 29 AND p.title = '피아노 3중주 3번 G단조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:2bfb4198-2a28-4ce2-9373-0021568aac10'
);


-- Op. 111 환상소곡집 Op. 111

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '환상소곡집 Op. 111', '3 Fantasiestücke, Op. 111', 'album', NULL, 'Op.', '111', 1851, 'manual', 1
FROM composers c
WHERE c.id = 29
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '환상소곡집 Op. 111'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '032e3ed4-4bca-4a7d-8358-774f163c6353'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '032e3ed4-4bca-4a7d-8358-774f163c6353'
FROM pieces p
WHERE p.composer_id = 29 AND p.title = '환상소곡집 Op. 111' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '032e3ed4-4bca-4a7d-8358-774f163c6353'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:a13aef4f-fd08-3c77-9486-18eff2da3c01', 1, NULL, 'C단조. Sehr rasch, mit leidenschaftlichem Vortrag', 'No. 1 in C minor. Sehr rasch, mit leidenschaftlichem Vortrag', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 29 AND p.title = '환상소곡집 Op. 111' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:a13aef4f-fd08-3c77-9486-18eff2da3c01'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:a1509ec8-e5af-3c53-b9ee-b542f75ea218', 2, NULL, 'A♭장조. Ziemlich langsam', 'No. 2 in A♭ major. Ziemlich langsam', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 29 AND p.title = '환상소곡집 Op. 111' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:a1509ec8-e5af-3c53-b9ee-b542f75ea218'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:3cb8ef47-56f0-388c-8058-3f580bdcfcb6', 3, NULL, 'C단조. Kräftig und sehr markiert', 'No. 3 in C minor. Kräftig und sehr markiert', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 29 AND p.title = '환상소곡집 Op. 111' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:3cb8ef47-56f0-388c-8058-3f580bdcfcb6'
);


-- Op. 112 <장미의 순례>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '<장미의 순례>', 'Der Rose Pilgerfahrt', 'song', 'Op. 112', NULL, NULL, 1851, 'manual', 1
FROM composers c
WHERE c.id = 29
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '<장미의 순례>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '133fa44d-9ff9-44c5-a725-b8c5bbea78fb'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '133fa44d-9ff9-44c5-a725-b8c5bbea78fb'
FROM pieces p
WHERE p.composer_id = 29 AND p.title = '<장미의 순례>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '133fa44d-9ff9-44c5-a725-b8c5bbea78fb'
);


-- Op. 113 비올라와 피아노를 위한 <동화의 그림>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '비올라와 피아노를 위한 <동화의 그림>', 'Märchenbilder', 'album', 'Op. 113', NULL, NULL, 1851, 'manual', 1
FROM composers c
WHERE c.id = 29
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '비올라와 피아노를 위한 <동화의 그림>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'a8f84136-0de0-4807-aca1-fd97c854260a'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'a8f84136-0de0-4807-aca1-fd97c854260a'
FROM pieces p
WHERE p.composer_id = 29 AND p.title = '비올라와 피아노를 위한 <동화의 그림>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'a8f84136-0de0-4807-aca1-fd97c854260a'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:bc8cfc46-b992-39b7-9546-d0b0aab404fb', 1, NULL, 'Nicht schnell', 'No. 1. Nicht schnell', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 29 AND p.title = '비올라와 피아노를 위한 <동화의 그림>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:bc8cfc46-b992-39b7-9546-d0b0aab404fb'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:69e7e4e2-f3d7-3504-a825-5e13a9de2b7d', 2, NULL, 'Lebhaft', 'No. 2. Lebhaft', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 29 AND p.title = '비올라와 피아노를 위한 <동화의 그림>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:69e7e4e2-f3d7-3504-a825-5e13a9de2b7d'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:69fd86aa-9200-32da-af7c-05fc5e8c48b6', 3, NULL, 'Rasch', 'No. 3. Rasch', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 29 AND p.title = '비올라와 피아노를 위한 <동화의 그림>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:69fd86aa-9200-32da-af7c-05fc5e8c48b6'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:7f0cc7b7-acda-37cb-bfa8-538d1de2e93e', 4, NULL, 'Langsam, mit melancholischem Ausdruck', 'No. 4. Langsam, mit melancholischem Ausdruck', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 29 AND p.title = '비올라와 피아노를 위한 <동화의 그림>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:7f0cc7b7-acda-37cb-bfa8-538d1de2e93e'
);


-- Op. 114 3개의 여성 3중창 Op. 114

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '3개의 여성 3중창 Op. 114', '3 Lieder for three female voices, Op. 114', 'album', NULL, 'Op.', '114', 1853, 'manual', 1
FROM composers c
WHERE c.id = 29
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '3개의 여성 3중창 Op. 114'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '5635dc5c-7aa6-49fc-a9ff-025537655b37'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '5635dc5c-7aa6-49fc-a9ff-025537655b37'
FROM pieces p
WHERE p.composer_id = 29 AND p.title = '3개의 여성 3중창 Op. 114' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '5635dc5c-7aa6-49fc-a9ff-025537655b37'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:89e0e11e-684f-47e6-ae73-0e1f9943a430', 1, NULL, 'Nänie', 'Nänie', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 29 AND p.title = '3개의 여성 3중창 Op. 114' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:89e0e11e-684f-47e6-ae73-0e1f9943a430'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:0b333dfa-2593-4801-9696-8580d6c41a38', 2, NULL, 'Triolett', 'Triolett', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 29 AND p.title = '3개의 여성 3중창 Op. 114' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:0b333dfa-2593-4801-9696-8580d6c41a38'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:4f4ec0d8-40ed-4123-81c7-7d0021616661', 3, NULL, 'Spruch', 'Spruch', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 29 AND p.title = '3개의 여성 3중창 Op. 114' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:4f4ec0d8-40ed-4123-81c7-7d0021616661'
);


-- Op. 115 부수음악 <만프레드>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '부수음악 <만프레드>', 'Manfred', 'song', 'Op. 115', NULL, NULL, 1849, 'manual', 1
FROM composers c
WHERE c.id = 29
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '부수음악 <만프레드>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '91da238f-1934-4a8c-a5dd-d430066f1e87'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '91da238f-1934-4a8c-a5dd-d430066f1e87'
FROM pieces p
WHERE p.composer_id = 29 AND p.title = '부수음악 <만프레드>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '91da238f-1934-4a8c-a5dd-d430066f1e87'
);


-- Op. 116 발라드 <왕자>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '발라드 <왕자>', 'Der Königssohn', 'song', 'Op. 116', NULL, NULL, 1851, 'manual', 1
FROM composers c
WHERE c.id = 29
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '발라드 <왕자>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '68217f1e-35f2-482f-854b-bbffbfd9ab75'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '68217f1e-35f2-482f-854b-bbffbfd9ab75'
FROM pieces p
WHERE p.composer_id = 29 AND p.title = '발라드 <왕자>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '68217f1e-35f2-482f-854b-bbffbfd9ab75'
);


-- Op. 117 4개의 경기병 노래 Op. 117

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '4개의 경기병 노래 Op. 117', '4 Husarenlieder, Op. 117', 'album', NULL, 'Op.', '117', 1851, 'manual', 1
FROM composers c
WHERE c.id = 29
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '4개의 경기병 노래 Op. 117'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '61e99381-daf6-4271-ac94-0d2099da5025'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '61e99381-daf6-4271-ac94-0d2099da5025'
FROM pieces p
WHERE p.composer_id = 29 AND p.title = '4개의 경기병 노래 Op. 117' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '61e99381-daf6-4271-ac94-0d2099da5025'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:7b8b63a3-2b08-38ca-9f8a-8391a72435b3', 1, NULL, 'Der Husar, trara!', 'Der Husar, trara!', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 29 AND p.title = '4개의 경기병 노래 Op. 117' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:7b8b63a3-2b08-38ca-9f8a-8391a72435b3'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:3a5c3f32-3f3c-36a8-8fce-c17bb0a62627', 2, NULL, 'Der leidige Frieden', 'Der leidige Frieden', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 29 AND p.title = '4개의 경기병 노래 Op. 117' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:3a5c3f32-3f3c-36a8-8fce-c17bb0a62627'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:97a27ef2-9ec6-3f80-9251-20259e3c851c', 3, NULL, 'Den grünen Zeigern', 'Den grünen Zeigern', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 29 AND p.title = '4개의 경기병 노래 Op. 117' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:97a27ef2-9ec6-3f80-9251-20259e3c851c'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:cadb139f-c521-352a-856f-615309bbf519', 4, NULL, 'Da liegt der Feinde gestreckte Schar', 'Da liegt der Feinde gestreckte Schar', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 29 AND p.title = '4개의 경기병 노래 Op. 117' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:cadb139f-c521-352a-856f-615309bbf519'
);


-- Op. 118 어린이를 위한 피아노 소나타 Op. 118

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '어린이를 위한 피아노 소나타 Op. 118', '3 Piano Sonatas for the Young, Op. 118', 'album', NULL, 'Op.', '118', 1853, 'manual', 1
FROM composers c
WHERE c.id = 29
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '어린이를 위한 피아노 소나타 Op. 118'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'eb17802d-2224-4b90-9aa6-4438461ac693'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'eb17802d-2224-4b90-9aa6-4438461ac693'
FROM pieces p
WHERE p.composer_id = 29 AND p.title = '어린이를 위한 피아노 소나타 Op. 118' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'eb17802d-2224-4b90-9aa6-4438461ac693'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:0be9d901-c945-4280-8d49-556cf5d2731f', 1, NULL, '소나타 G장조', 'Sonata No. 1 in G major', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 29 AND p.title = '어린이를 위한 피아노 소나타 Op. 118' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:0be9d901-c945-4280-8d49-556cf5d2731f'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:f03ff3d0-88a9-3f89-ab5c-75cc963d9ab5', 1, 'I', 'Allegro', 'I. Allegro', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:0be9d901-c945-4280-8d49-556cf5d2731f'
WHERE p.composer_id = 29 AND p.title = '어린이를 위한 피아노 소나타 Op. 118' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:f03ff3d0-88a9-3f89-ab5c-75cc963d9ab5'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:a66dfabb-2945-37c0-9453-3b714d5e53ad', 2, 'II', '주제와 변주', 'II. Thema und Variationen', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:0be9d901-c945-4280-8d49-556cf5d2731f'
WHERE p.composer_id = 29 AND p.title = '어린이를 위한 피아노 소나타 Op. 118' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:a66dfabb-2945-37c0-9453-3b714d5e53ad'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:cef37373-1d5c-3fff-bc75-314f1667df43', 3, 'III', 'Puppenwiegenlied', 'III. Puppenwiegenlied', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:0be9d901-c945-4280-8d49-556cf5d2731f'
WHERE p.composer_id = 29 AND p.title = '어린이를 위한 피아노 소나타 Op. 118' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:cef37373-1d5c-3fff-bc75-314f1667df43'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:2e6769d7-eaea-3754-88c2-8c834a3198b9', 4, 'IV', '론돌레토', 'IV. Rondoletto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:0be9d901-c945-4280-8d49-556cf5d2731f'
WHERE p.composer_id = 29 AND p.title = '어린이를 위한 피아노 소나타 Op. 118' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:2e6769d7-eaea-3754-88c2-8c834a3198b9'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:f7796d1a-e264-4f27-b979-1ac68c67516f', 2, NULL, '소나타 D장조', 'Sonata No. 2 in D major', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 29 AND p.title = '어린이를 위한 피아노 소나타 Op. 118' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:f7796d1a-e264-4f27-b979-1ac68c67516f'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:a568c08b-6acf-32ce-b283-eff71699b2a8', 1, 'I', 'Allegro', 'I. Allegro', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:f7796d1a-e264-4f27-b979-1ac68c67516f'
WHERE p.composer_id = 29 AND p.title = '어린이를 위한 피아노 소나타 Op. 118' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:a568c08b-6acf-32ce-b283-eff71699b2a8'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:5e4ba6b4-c19a-3327-a1a4-0bed5f1c9f2c', 2, 'II', '카논', 'II. Canon', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:f7796d1a-e264-4f27-b979-1ac68c67516f'
WHERE p.composer_id = 29 AND p.title = '어린이를 위한 피아노 소나타 Op. 118' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:5e4ba6b4-c19a-3327-a1a4-0bed5f1c9f2c'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:2db084c1-9edc-3f23-847b-199897abc4cd', 3, 'III', 'Abendlied', 'III. Abendlied', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:f7796d1a-e264-4f27-b979-1ac68c67516f'
WHERE p.composer_id = 29 AND p.title = '어린이를 위한 피아노 소나타 Op. 118' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:2db084c1-9edc-3f23-847b-199897abc4cd'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:182ff52b-1e0a-3251-a7e1-52e4696ecd6c', 4, 'IV', 'Kindergesellschaft', 'IV. Kindergesellschaft', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:f7796d1a-e264-4f27-b979-1ac68c67516f'
WHERE p.composer_id = 29 AND p.title = '어린이를 위한 피아노 소나타 Op. 118' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:182ff52b-1e0a-3251-a7e1-52e4696ecd6c'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:d376e999-c56b-4c84-9c35-db301ae7a14b', 3, NULL, '소나타 C장조', 'Sonata No. 3 in C major', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 29 AND p.title = '어린이를 위한 피아노 소나타 Op. 118' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:d376e999-c56b-4c84-9c35-db301ae7a14b'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:43e23a87-1491-309f-9d34-d73f2123a58c', 1, 'I', 'Allegro', 'I. Allegro', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:d376e999-c56b-4c84-9c35-db301ae7a14b'
WHERE p.composer_id = 29 AND p.title = '어린이를 위한 피아노 소나타 Op. 118' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:43e23a87-1491-309f-9d34-d73f2123a58c'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:b283fe2b-725d-3fd0-bb85-3a975912879c', 2, 'II', 'Andante', 'II. Andante', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:d376e999-c56b-4c84-9c35-db301ae7a14b'
WHERE p.composer_id = 29 AND p.title = '어린이를 위한 피아노 소나타 Op. 118' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:b283fe2b-725d-3fd0-bb85-3a975912879c'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:7cba9a1e-93a7-3379-9929-09dfa2458d35', 3, 'III', 'Zigeunertanz', 'III. Zigeunertanz', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:d376e999-c56b-4c84-9c35-db301ae7a14b'
WHERE p.composer_id = 29 AND p.title = '어린이를 위한 피아노 소나타 Op. 118' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:7cba9a1e-93a7-3379-9929-09dfa2458d35'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:505cfac4-303a-3cad-9213-9580ccaacc9c', 4, 'IV', 'Traum eines Kindes', 'IV. Traum eines Kindes', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:d376e999-c56b-4c84-9c35-db301ae7a14b'
WHERE p.composer_id = 29 AND p.title = '어린이를 위한 피아노 소나타 Op. 118' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:505cfac4-303a-3cad-9213-9580ccaacc9c'
);


-- Op. 119 3개의 시 Op. 119

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '3개의 시 Op. 119', '3 Gedichte aus den Waldliedern, Op. 119', 'album', NULL, 'Op.', '119', 1851, 'manual', 1
FROM composers c
WHERE c.id = 29
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '3개의 시 Op. 119'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '47a04945-9617-484d-8f15-7306b74be450'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '47a04945-9617-484d-8f15-7306b74be450'
FROM pieces p
WHERE p.composer_id = 29 AND p.title = '3개의 시 Op. 119' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '47a04945-9617-484d-8f15-7306b74be450'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:7f7013c2-ba67-4dd2-9110-476e7e1e2083', 1, NULL, 'Die Hütte', 'Die Hütte', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 29 AND p.title = '3개의 시 Op. 119' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:7f7013c2-ba67-4dd2-9110-476e7e1e2083'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:774e6ef9-fef1-3a7b-a06a-217e37cfe2ea', 2, NULL, 'Warnung', 'Warnung', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 29 AND p.title = '3개의 시 Op. 119' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:774e6ef9-fef1-3a7b-a06a-217e37cfe2ea'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:cce4f90a-e671-4f1d-ab8d-7b0914450d36', 3, NULL, 'Der Bräutigam und die Birke', 'Der Bräutigam und die Birke', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 29 AND p.title = '3개의 시 Op. 119' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:cce4f90a-e671-4f1d-ab8d-7b0914450d36'
);


-- Op. 120 교향곡 4번 D단조

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '교향곡 4번 D단조', 'Symphony No. 4 in D minor', 'album', 'Op. 120', NULL, NULL, 1851, 'manual', 1
FROM composers c
WHERE c.id = 29
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '교향곡 4번 D단조'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '7b0a78cd-49a6-4d78-99fe-2712e4190565'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '7b0a78cd-49a6-4d78-99fe-2712e4190565'
FROM pieces p
WHERE p.composer_id = 29 AND p.title = '교향곡 4번 D단조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '7b0a78cd-49a6-4d78-99fe-2712e4190565'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:339d8c1e-e375-38a7-9c67-d75065d04ec9', 1, 'I', 'Ziemlich langsam – Lebhaft', 'I. Ziemlich langsam – Lebhaft', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 29 AND p.title = '교향곡 4번 D단조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:339d8c1e-e375-38a7-9c67-d75065d04ec9'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:058da660-c0a0-30e3-888c-97844be30dc1', 2, 'II', '로망스. Ziemlich langsam', 'II. Romanze. Ziemlich langsam', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 29 AND p.title = '교향곡 4번 D단조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:058da660-c0a0-30e3-888c-97844be30dc1'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:8dad1720-296c-3009-b3c8-265f6d8aca41', 3, 'III', '스케르초. Lebhaft', 'III. Scherzo. Lebhaft', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 29 AND p.title = '교향곡 4번 D단조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:8dad1720-296c-3009-b3c8-265f6d8aca41'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:3c7d5aa2-869e-3e43-9d06-21657269969d', 4, 'IV', 'Langsam – Lebhaft', 'IV. Langsam – Lebhaft', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 29 AND p.title = '교향곡 4번 D단조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:3c7d5aa2-869e-3e43-9d06-21657269969d'
);


-- Op. 121 바이올린 소나타 2번 D단조

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '바이올린 소나타 2번 D단조', 'Violin Sonata No. 2 in D minor', 'album', 'Op. 121', NULL, NULL, 1851, 'manual', 1
FROM composers c
WHERE c.id = 29
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '바이올린 소나타 2번 D단조'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '3c2b098a-7117-41d5-aa35-ed255d5ad27e'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '3c2b098a-7117-41d5-aa35-ed255d5ad27e'
FROM pieces p
WHERE p.composer_id = 29 AND p.title = '바이올린 소나타 2번 D단조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '3c2b098a-7117-41d5-aa35-ed255d5ad27e'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:49af6e7b-d4ee-3e5b-9727-0b14e085a973', 1, 'I', 'Ziemlich langsam – Lebhaft', 'I. Ziemlich langsam – Lebhaft', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 29 AND p.title = '바이올린 소나타 2번 D단조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:49af6e7b-d4ee-3e5b-9727-0b14e085a973'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:bbfe626d-17ee-3324-acc7-894f3bf0b46f', 2, 'II', 'Sehr lebhaft', 'II. Sehr lebhaft', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 29 AND p.title = '바이올린 소나타 2번 D단조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:bbfe626d-17ee-3324-acc7-894f3bf0b46f'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:69566b77-9f0e-3b0a-a56d-3e2ca0b85666', 3, 'III', 'Leise, einfach', 'III. Leise, einfach', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 29 AND p.title = '바이올린 소나타 2번 D단조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:69566b77-9f0e-3b0a-a56d-3e2ca0b85666'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:e77a4d94-cb07-37da-b7b3-f2fad8947205', 4, 'IV', 'Bewegt', 'IV. Bewegt', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 29 AND p.title = '바이올린 소나타 2번 D단조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:e77a4d94-cb07-37da-b7b3-f2fad8947205'
);


-- Op. 122 낭송을 위한 발라드 Op. 122

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '낭송을 위한 발라드 Op. 122', '2 Balladen for declamation, Op. 122', 'album', NULL, 'Op.', '122', 1852, 'manual', 1
FROM composers c
WHERE c.id = 29
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '낭송을 위한 발라드 Op. 122'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '93485a51-3d34-4c74-a062-abf0774638d4'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '93485a51-3d34-4c74-a062-abf0774638d4'
FROM pieces p
WHERE p.composer_id = 29 AND p.title = '낭송을 위한 발라드 Op. 122' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '93485a51-3d34-4c74-a062-abf0774638d4'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:5335e837-8eae-342c-839c-a1039006ad6c', 1, NULL, 'Ballade vom Heideknaben', 'Ballade vom Heideknaben', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 29 AND p.title = '낭송을 위한 발라드 Op. 122' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:5335e837-8eae-342c-839c-a1039006ad6c'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:dd007cb4-d31c-3f59-8517-a42582120764', 2, NULL, 'Die Flüchtlinge', 'Die Flüchtlinge', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 29 AND p.title = '낭송을 위한 발라드 Op. 122' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:dd007cb4-d31c-3f59-8517-a42582120764'
);


-- Op. 123 <라인 포도주의 노래>에 의한 축전 서곡

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '<라인 포도주의 노래>에 의한 축전 서곡', 'Festival Overture on the Rheinweinlied', 'song', 'Op. 123', NULL, NULL, 1853, 'manual', 1
FROM composers c
WHERE c.id = 29
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '<라인 포도주의 노래>에 의한 축전 서곡'
);


-- Op. 124 피아노 모음곡 <앨범의 잎>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '피아노 모음곡 <앨범의 잎>', 'Albumblätter', 'album', 'Op. 124', NULL, NULL, 1845, 'manual', 1
FROM composers c
WHERE c.id = 29
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '피아노 모음곡 <앨범의 잎>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'dfc78d2d-98cc-4162-aaee-d29af127c613'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'dfc78d2d-98cc-4162-aaee-d29af127c613'
FROM pieces p
WHERE p.composer_id = 29 AND p.title = '피아노 모음곡 <앨범의 잎>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'dfc78d2d-98cc-4162-aaee-d29af127c613'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:eb2ba18f-49fb-486a-86b0-031bac21bde1', 1, NULL, '즉흥곡. Sehr schnell', 'Impromptu. Sehr schnell', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 29 AND p.title = '피아노 모음곡 <앨범의 잎>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:eb2ba18f-49fb-486a-86b0-031bac21bde1'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:64bd4537-4bfe-4d55-a701-3f67361af203', 2, NULL, 'Leides Ahnung. Langsam', 'Leides Ahnung. Langsam', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 29 AND p.title = '피아노 모음곡 <앨범의 잎>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:64bd4537-4bfe-4d55-a701-3f67361af203'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:3f0a1bfa-f713-4808-a16a-721a269c35c1', 3, NULL, '스케르치노. Rasch', 'Scherzino. Rasch', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 29 AND p.title = '피아노 모음곡 <앨범의 잎>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:3f0a1bfa-f713-4808-a16a-721a269c35c1'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:c8d1ec79-d613-4e1d-bafc-1bbeb3b32451', 4, NULL, '왈츠. Lebhaft', 'Walzer. Lebhaft', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 29 AND p.title = '피아노 모음곡 <앨범의 잎>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:c8d1ec79-d613-4e1d-bafc-1bbeb3b32451'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:68a4eece-454b-4ab2-94da-02f882322aab', 5, NULL, 'Phantasietanz. Sehr rasch', 'Phantasietanz. Sehr rasch', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 29 AND p.title = '피아노 모음곡 <앨범의 잎>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:68a4eece-454b-4ab2-94da-02f882322aab'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:70d13b8e-d8aa-4b9a-8915-fa523538698b', 6, NULL, 'Wiegenliedchen. Nicht schnell', 'Wiegenliedchen. Nicht schnell', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 29 AND p.title = '피아노 모음곡 <앨범의 잎>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:70d13b8e-d8aa-4b9a-8915-fa523538698b'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:1b1f8e1c-ca3b-4f7b-9c5b-de47b477568c', 7, NULL, '렌틀러. Sehr mäßig', 'Ländler. Sehr mäßig', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 29 AND p.title = '피아노 모음곡 <앨범의 잎>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:1b1f8e1c-ca3b-4f7b-9c5b-de47b477568c'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:980bb827-3167-4efd-9610-57317e91d654', 8, NULL, 'Leid ohne Ende. Langsam', 'Leid ohne Ende. Langsam', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 29 AND p.title = '피아노 모음곡 <앨범의 잎>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:980bb827-3167-4efd-9610-57317e91d654'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:8b73a962-cee0-4519-b664-eb453bcc672d', 9, NULL, '즉흥곡. Mit zartem Vortrag', 'Impromptu. Mit zartem Vortrag', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 29 AND p.title = '피아노 모음곡 <앨범의 잎>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:8b73a962-cee0-4519-b664-eb453bcc672d'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:bab01566-3fa3-4bc7-b959-4d18bb7a03d3', 10, NULL, '왈츠. Mit Lebhaftigkeit', 'Walzer. Mit Lebhaftigkeit', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 29 AND p.title = '피아노 모음곡 <앨범의 잎>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:bab01566-3fa3-4bc7-b959-4d18bb7a03d3'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:264ad8f4-2c86-4c0c-a79c-08f5caf01f55', 11, NULL, '로망스. Nicht schnell', 'Romanze. Nicht schnell', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 29 AND p.title = '피아노 모음곡 <앨범의 잎>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:264ad8f4-2c86-4c0c-a79c-08f5caf01f55'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:3b986087-2d41-4aa2-b9a3-ae2d61165bc7', 12, NULL, 'Burla. Presto', 'Burla. Presto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 29 AND p.title = '피아노 모음곡 <앨범의 잎>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:3b986087-2d41-4aa2-b9a3-ae2d61165bc7'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:ba8c8126-fe52-4b2a-b3ac-ef6e8658e2a9', 13, NULL, 'Larghetto', 'Larghetto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 29 AND p.title = '피아노 모음곡 <앨범의 잎>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:ba8c8126-fe52-4b2a-b3ac-ef6e8658e2a9'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:3654a84b-eb9f-47ec-be9c-eb92f7765af3', 14, NULL, 'Vision. Sehr rasch', 'Vision. Sehr rasch', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 29 AND p.title = '피아노 모음곡 <앨범의 잎>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:3654a84b-eb9f-47ec-be9c-eb92f7765af3'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:44330bef-d710-4f1d-b22e-ba11303769c0', 15, NULL, '왈츠', 'Walzer', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 29 AND p.title = '피아노 모음곡 <앨범의 잎>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:44330bef-d710-4f1d-b22e-ba11303769c0'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:059dc488-6e4a-4e17-8480-edd39ed1b028', 16, NULL, 'Schlummerlied', 'Schlummerlied', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 29 AND p.title = '피아노 모음곡 <앨범의 잎>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:059dc488-6e4a-4e17-8480-edd39ed1b028'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:2634ca5b-3e81-410a-918e-c19d42ab2d0f', 17, NULL, 'Elfe. So schnell als möglich', 'Elfe. So schnell als möglich', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 29 AND p.title = '피아노 모음곡 <앨범의 잎>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:2634ca5b-3e81-410a-918e-c19d42ab2d0f'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:a2a2f0d8-b7d6-47c9-a194-e56575015250', 18, NULL, 'Botschaft. Mit zartem Vortrag', 'Botschaft. Mit zartem Vortrag', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 29 AND p.title = '피아노 모음곡 <앨범의 잎>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:a2a2f0d8-b7d6-47c9-a194-e56575015250'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:7fec68c7-cf4a-4bcd-90c3-55b276bf20d7', 19, NULL, '환상 소곡', 'Phantasiestück', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 29 AND p.title = '피아노 모음곡 <앨범의 잎>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:7fec68c7-cf4a-4bcd-90c3-55b276bf20d7'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:996777d0-ad3e-4575-a8ad-694b5795659d', 20, NULL, '카논. Langsam', 'Canon. Langsam', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 29 AND p.title = '피아노 모음곡 <앨범의 잎>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:996777d0-ad3e-4575-a8ad-694b5795659d'
);


-- Op. 125 5개의 즐거운 노래 Op. 125

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '5개의 즐거운 노래 Op. 125', '5 heitere Gesänge, Op. 125', 'album', NULL, 'Op.', '125', 1851, 'manual', 1
FROM composers c
WHERE c.id = 29
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '5개의 즐거운 노래 Op. 125'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '40807d36-cf44-441e-8050-a4f9a710cf95'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '40807d36-cf44-441e-8050-a4f9a710cf95'
FROM pieces p
WHERE p.composer_id = 29 AND p.title = '5개의 즐거운 노래 Op. 125' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '40807d36-cf44-441e-8050-a4f9a710cf95'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:febaa236-667f-3dbb-86fc-09fd1749fbf4', 1, NULL, 'Die Meerfee', 'Die Meerfee', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 29 AND p.title = '5개의 즐거운 노래 Op. 125' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:febaa236-667f-3dbb-86fc-09fd1749fbf4'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:1d191fb9-fabe-3bdb-bdcd-a88f54de3e26', 2, NULL, 'Husarenabzug', 'Husarenabzug', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 29 AND p.title = '5개의 즐거운 노래 Op. 125' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:1d191fb9-fabe-3bdb-bdcd-a88f54de3e26'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:9f076313-7b88-3905-ac97-0db593f868ff', 3, NULL, 'Jung Volkers Lied', 'Jung Volkers Lied', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 29 AND p.title = '5개의 즐거운 노래 Op. 125' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:9f076313-7b88-3905-ac97-0db593f868ff'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:52161702-2a2f-4b99-a67a-1deea52fc916', 4, NULL, 'Frühlingslied', 'Frühlingslied', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 29 AND p.title = '5개의 즐거운 노래 Op. 125' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:52161702-2a2f-4b99-a67a-1deea52fc916'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:a64410c5-a7d7-4a50-8175-94fc870a1985', 5, NULL, 'Frühlingslust', 'Frühlingslust', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 29 AND p.title = '5개의 즐거운 노래 Op. 125' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:a64410c5-a7d7-4a50-8175-94fc870a1985'
);


-- Op. 126 푸게타 형식의 소품 Op. 126

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '푸게타 형식의 소품 Op. 126', '7 Klavierstücke in Fughettenform, Op. 126', 'album', NULL, 'Op.', '126', 1853, 'manual', 1
FROM composers c
WHERE c.id = 29
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '푸게타 형식의 소품 Op. 126'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '0da3972a-8e4e-47dc-90a5-ab9241ffb368'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '0da3972a-8e4e-47dc-90a5-ab9241ffb368'
FROM pieces p
WHERE p.composer_id = 29 AND p.title = '푸게타 형식의 소품 Op. 126' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '0da3972a-8e4e-47dc-90a5-ab9241ffb368'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:e14b8e07-5974-4695-ac04-d6075647d8b5', 1, NULL, 'Nicht schnell, leise vorzutragen', 'No. 1. Nicht schnell, leise vorzutragen', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 29 AND p.title = '푸게타 형식의 소품 Op. 126' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:e14b8e07-5974-4695-ac04-d6075647d8b5'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:c716631b-eaf1-45be-8546-1cda1c4320a1', 2, NULL, 'Mäßig', 'No. 2. Mäßig', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 29 AND p.title = '푸게타 형식의 소품 Op. 126' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:c716631b-eaf1-45be-8546-1cda1c4320a1'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:9200c328-cfda-4599-afa8-99a222f1333c', 3, NULL, 'Ziemlich bewegt', 'No. 3. Ziemlich bewegt', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 29 AND p.title = '푸게타 형식의 소품 Op. 126' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:9200c328-cfda-4599-afa8-99a222f1333c'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:fa07039b-b43d-48ee-af80-c5f70e9f39dc', 4, NULL, 'Lebhaft', 'No. 4. Lebhaft', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 29 AND p.title = '푸게타 형식의 소품 Op. 126' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:fa07039b-b43d-48ee-af80-c5f70e9f39dc'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:403b4ab0-0a70-407b-bdcd-476d620d7714', 5, NULL, 'Ziemlich langsam, empfindungsvoll vorzutragen', 'No. 5. Ziemlich langsam, empfindungsvoll vorzutragen', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 29 AND p.title = '푸게타 형식의 소품 Op. 126' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:403b4ab0-0a70-407b-bdcd-476d620d7714'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:1010d4d3-a87c-4a03-99af-c9cdc324f6ab', 6, NULL, 'Sehr schnell', 'No. 6. Sehr schnell', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 29 AND p.title = '푸게타 형식의 소품 Op. 126' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:1010d4d3-a87c-4a03-99af-c9cdc324f6ab'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:48dd1a86-2139-4ace-a8e5-6fc9b6523e37', 7, NULL, 'Langsam, ausdrucksvoll', 'No. 7. Langsam, ausdrucksvoll', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 29 AND p.title = '푸게타 형식의 소품 Op. 126' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:48dd1a86-2139-4ace-a8e5-6fc9b6523e37'
);


-- Op. 127 5개의 가곡과 노래 Op. 127

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '5개의 가곡과 노래 Op. 127', '5 Lieder und Gesänge, Op. 127', 'album', NULL, 'Op.', '127', 1851, 'manual', 1
FROM composers c
WHERE c.id = 29
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '5개의 가곡과 노래 Op. 127'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'd5b9022e-c806-4bcd-92ad-9c3bf6187b54'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'd5b9022e-c806-4bcd-92ad-9c3bf6187b54'
FROM pieces p
WHERE p.composer_id = 29 AND p.title = '5개의 가곡과 노래 Op. 127' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'd5b9022e-c806-4bcd-92ad-9c3bf6187b54'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:824a848e-0e13-477c-90f0-de23442d1f2b', 1, NULL, 'Sängers Trost', 'Sängers Trost', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 29 AND p.title = '5개의 가곡과 노래 Op. 127' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:824a848e-0e13-477c-90f0-de23442d1f2b'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:c566e0d8-3cb6-38df-a924-8f168c5c2c5d', 2, NULL, 'Dein Angesicht', 'Dein Angesicht', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 29 AND p.title = '5개의 가곡과 노래 Op. 127' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:c566e0d8-3cb6-38df-a924-8f168c5c2c5d'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:f424b180-c4b9-3121-a092-a623bb618ede', 3, NULL, 'Es leuchtet meine Liebe', 'Es leuchtet meine Liebe', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 29 AND p.title = '5개의 가곡과 노래 Op. 127' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:f424b180-c4b9-3121-a092-a623bb618ede'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:f8faa84e-df13-44fa-a1d9-d23ea5612375', 4, NULL, 'Mein altes Ross', 'Mein altes Ross', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 29 AND p.title = '5개의 가곡과 노래 Op. 127' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:f8faa84e-df13-44fa-a1d9-d23ea5612375'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:17347691-eb9b-467e-94d9-45c8e4d5b8de', 5, NULL, 'Schlusslied des Narren', 'Schlusslied des Narren', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 29 AND p.title = '5개의 가곡과 노래 Op. 127' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:17347691-eb9b-467e-94d9-45c8e4d5b8de'
);


-- Op. 128 서곡 <율리우스 카이사르>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '서곡 <율리우스 카이사르>', 'Overture to Julius Caesar', 'song', 'Op. 128', NULL, NULL, 1851, 'manual', 1
FROM composers c
WHERE c.id = 29
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '서곡 <율리우스 카이사르>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '9de269d3-7ae3-3eee-8065-464640c3c8ff'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '9de269d3-7ae3-3eee-8065-464640c3c8ff'
FROM pieces p
WHERE p.composer_id = 29 AND p.title = '서곡 <율리우스 카이사르>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '9de269d3-7ae3-3eee-8065-464640c3c8ff'
);


-- Op. 129 첼로 협주곡 A단조

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '첼로 협주곡 A단조', 'Cello Concerto in A minor', 'album', 'Op. 129', NULL, NULL, 1850, 'manual', 1
FROM composers c
WHERE c.id = 29
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '첼로 협주곡 A단조'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'c7c7addd-c2cd-47dd-8137-9428627bd8f3'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'c7c7addd-c2cd-47dd-8137-9428627bd8f3'
FROM pieces p
WHERE p.composer_id = 29 AND p.title = '첼로 협주곡 A단조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'c7c7addd-c2cd-47dd-8137-9428627bd8f3'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:ad933d2f-b53f-3233-830c-2e3e40c14117', 1, 'I', 'Nicht zu schnell', 'I. Nicht zu schnell', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 29 AND p.title = '첼로 협주곡 A단조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:ad933d2f-b53f-3233-830c-2e3e40c14117'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:06156db8-48ea-3851-833e-f94a2f32ae6a', 2, 'II', 'Langsam', 'II. Langsam', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 29 AND p.title = '첼로 협주곡 A단조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:06156db8-48ea-3851-833e-f94a2f32ae6a'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:3a24d82a-5216-364b-8216-1735cc1ec0f5', 3, 'III', 'Sehr lebhaft', 'III. Sehr lebhaft', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 29 AND p.title = '첼로 협주곡 A단조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:3a24d82a-5216-364b-8216-1735cc1ec0f5'
);


-- Op. 130 피아노 연탄 모음곡 <어린이 무도회>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '피아노 연탄 모음곡 <어린이 무도회>', 'Kinderball', 'album', 'Op. 130', NULL, NULL, 1853, 'manual', 1
FROM composers c
WHERE c.id = 29
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '피아노 연탄 모음곡 <어린이 무도회>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'abaf1baa-82fe-4647-b6ab-5a9cee5e08af'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'abaf1baa-82fe-4647-b6ab-5a9cee5e08af'
FROM pieces p
WHERE p.composer_id = 29 AND p.title = '피아노 연탄 모음곡 <어린이 무도회>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'abaf1baa-82fe-4647-b6ab-5a9cee5e08af'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:566ea7b1-0a49-450f-bf37-1bef632badd7', 1, NULL, '폴로네즈. Langsam und gemessen', 'Polonaise. Langsam und gemessen', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 29 AND p.title = '피아노 연탄 모음곡 <어린이 무도회>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:566ea7b1-0a49-450f-bf37-1bef632badd7'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:bd51b3ae-3ea7-4dba-93a7-4290dee50306', 2, NULL, '왈츠. Munter', 'Walzer. Munter', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 29 AND p.title = '피아노 연탄 모음곡 <어린이 무도회>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:bd51b3ae-3ea7-4dba-93a7-4290dee50306'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:b9c52765-45fd-480f-8b7d-2deb5e8f9b69', 3, NULL, '미뉴에트. Nicht schnell, etwas gravitätisch', 'Menuett. Nicht schnell, etwas gravitätisch', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 29 AND p.title = '피아노 연탄 모음곡 <어린이 무도회>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:b9c52765-45fd-480f-8b7d-2deb5e8f9b69'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:e4599697-4679-4081-a670-a7ad2071d8d6', 4, NULL, '에코세즈. Lebhaft', 'Ecossaise. Lebhaft', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 29 AND p.title = '피아노 연탄 모음곡 <어린이 무도회>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:e4599697-4679-4081-a670-a7ad2071d8d6'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:499cc821-a934-4563-b198-f8212b35b045', 5, NULL, '프랑세즈. Belebt, doch nicht zu rasch', 'Française. Belebt, doch nicht zu rasch', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 29 AND p.title = '피아노 연탄 모음곡 <어린이 무도회>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:499cc821-a934-4563-b198-f8212b35b045'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:704652c9-82a0-4ab3-82ef-16c1b0235c0d', 6, NULL, 'Ringelreihe. Lebhaft', 'Ringelreihe. Lebhaft', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 29 AND p.title = '피아노 연탄 모음곡 <어린이 무도회>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:704652c9-82a0-4ab3-82ef-16c1b0235c0d'
);


-- Op. 131 바이올린과 관현악을 위한 환상곡 C장조

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '바이올린과 관현악을 위한 환상곡 C장조', 'Fantasy in C major for violin and orchestra', 'song', 'Op. 131', NULL, NULL, 1853, 'manual', 1
FROM composers c
WHERE c.id = 29
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '바이올린과 관현악을 위한 환상곡 C장조'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'af3372ee-902d-3bf1-839a-ab6034a86cfc'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'af3372ee-902d-3bf1-839a-ab6034a86cfc'
FROM pieces p
WHERE p.composer_id = 29 AND p.title = '바이올린과 관현악을 위한 환상곡 C장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'af3372ee-902d-3bf1-839a-ab6034a86cfc'
);


-- Op. 132 클라리넷, 비올라, 피아노를 위한 <동화 이야기>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '클라리넷, 비올라, 피아노를 위한 <동화 이야기>', 'Märchenerzählungen', 'album', 'Op. 132', NULL, NULL, 1853, 'manual', 1
FROM composers c
WHERE c.id = 29
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '클라리넷, 비올라, 피아노를 위한 <동화 이야기>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '8d25ed1b-ff02-4299-8f9d-f61d7f6c9be0'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '8d25ed1b-ff02-4299-8f9d-f61d7f6c9be0'
FROM pieces p
WHERE p.composer_id = 29 AND p.title = '클라리넷, 비올라, 피아노를 위한 <동화 이야기>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '8d25ed1b-ff02-4299-8f9d-f61d7f6c9be0'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:f4e2eef1-1eb2-4395-a325-013f3a597f77', 1, NULL, 'Lebhaft, nicht zu schnell', 'No. 1. Lebhaft, nicht zu schnell', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 29 AND p.title = '클라리넷, 비올라, 피아노를 위한 <동화 이야기>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:f4e2eef1-1eb2-4395-a325-013f3a597f77'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:fd6b9dc9-2dac-4e52-b08e-e9b340f422fd', 2, NULL, 'Lebhaft und sehr markiert', 'No. 2. Lebhaft und sehr markiert', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 29 AND p.title = '클라리넷, 비올라, 피아노를 위한 <동화 이야기>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:fd6b9dc9-2dac-4e52-b08e-e9b340f422fd'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:a3f7605f-8792-4357-9464-599ae6ba7e0c', 3, NULL, 'Ruhiges Tempo, mit zartem Ausdruck', 'No. 3. Ruhiges Tempo, mit zartem Ausdruck', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 29 AND p.title = '클라리넷, 비올라, 피아노를 위한 <동화 이야기>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:a3f7605f-8792-4357-9464-599ae6ba7e0c'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:b1384cc0-04a0-45d6-b28c-5c27917b07bc', 4, NULL, 'Lebhaft, sehr markiert – Etwas ruhigeres Tempo', 'No. 4. Lebhaft, sehr markiert – Etwas ruhigeres Tempo', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 29 AND p.title = '클라리넷, 비올라, 피아노를 위한 <동화 이야기>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:b1384cc0-04a0-45d6-b28c-5c27917b07bc'
);


-- Op. 133 피아노 모음곡 <새벽의 노래>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '피아노 모음곡 <새벽의 노래>', 'Gesänge der Frühe', 'album', 'Op. 133', NULL, NULL, 1853, 'manual', 1
FROM composers c
WHERE c.id = 29
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '피아노 모음곡 <새벽의 노래>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '3df936ec-820e-4f61-880d-48582e597c9e'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '3df936ec-820e-4f61-880d-48582e597c9e'
FROM pieces p
WHERE p.composer_id = 29 AND p.title = '피아노 모음곡 <새벽의 노래>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '3df936ec-820e-4f61-880d-48582e597c9e'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:d8a1c65b-883d-339c-8ec3-d7af7f44a16a', 1, NULL, 'Im ruhigen Tempo', 'No. 1. Im ruhigen Tempo', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 29 AND p.title = '피아노 모음곡 <새벽의 노래>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:d8a1c65b-883d-339c-8ec3-d7af7f44a16a'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:e9ac7a03-bb8e-3b2c-ae6d-b8029531756a', 2, NULL, 'Belebt, nicht zu rasch', 'No. 2. Belebt, nicht zu rasch', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 29 AND p.title = '피아노 모음곡 <새벽의 노래>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:e9ac7a03-bb8e-3b2c-ae6d-b8029531756a'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:f0357c33-28f7-3f8f-9e41-7538af7eeed7', 3, NULL, 'Lebhaft', 'No. 3. Lebhaft', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 29 AND p.title = '피아노 모음곡 <새벽의 노래>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:f0357c33-28f7-3f8f-9e41-7538af7eeed7'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:aacbd720-0d1f-358e-b147-2e959843c1a3', 4, NULL, 'Bewegt', 'No. 4. Bewegt', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 29 AND p.title = '피아노 모음곡 <새벽의 노래>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:aacbd720-0d1f-358e-b147-2e959843c1a3'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:d455e7a6-910f-3d9c-ba41-7e7f6f78de9f', 5, NULL, 'Im Anfange ruhiges, im Verlauf bewegtes Tempo', 'No. 5. Im Anfange ruhiges, im Verlauf bewegtes Tempo', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 29 AND p.title = '피아노 모음곡 <새벽의 노래>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:d455e7a6-910f-3d9c-ba41-7e7f6f78de9f'
);


-- Op. 134 서주와 협주풍 알레그로 D단조

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '서주와 협주풍 알레그로 D단조', 'Introduction and Concert Allegro in D minor', 'song', 'Op. 134', NULL, NULL, 1853, 'manual', 1
FROM composers c
WHERE c.id = 29
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '서주와 협주풍 알레그로 D단조'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'bdcc8cbb-fcdf-39c8-8364-76c07cbbacc1'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'bdcc8cbb-fcdf-39c8-8364-76c07cbbacc1'
FROM pieces p
WHERE p.composer_id = 29 AND p.title = '서주와 협주풍 알레그로 D단조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'bdcc8cbb-fcdf-39c8-8364-76c07cbbacc1'
);


-- Op. 135 가곡집 <메리 스튜어트 여왕의 시>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '가곡집 <메리 스튜어트 여왕의 시>', 'Gedichte der Königin Maria Stuart', 'album', 'Op. 135', NULL, NULL, 1852, 'manual', 1
FROM composers c
WHERE c.id = 29
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '가곡집 <메리 스튜어트 여왕의 시>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '3ceaf8f9-8855-4220-a3f0-bbe17353441c'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '3ceaf8f9-8855-4220-a3f0-bbe17353441c'
FROM pieces p
WHERE p.composer_id = 29 AND p.title = '가곡집 <메리 스튜어트 여왕의 시>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '3ceaf8f9-8855-4220-a3f0-bbe17353441c'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:0e70149e-2494-4ef0-8af1-cae54d3627ae', 1, NULL, 'Abschied von Frankreich', 'Abschied von Frankreich', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 29 AND p.title = '가곡집 <메리 스튜어트 여왕의 시>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:0e70149e-2494-4ef0-8af1-cae54d3627ae'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:a1c119de-f5c0-4a7f-bc00-59440f0debe2', 2, NULL, 'Nach der Geburt ihres Sohnes', 'Nach der Geburt ihres Sohnes', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 29 AND p.title = '가곡집 <메리 스튜어트 여왕의 시>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:a1c119de-f5c0-4a7f-bc00-59440f0debe2'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:043d70c7-037c-4280-8650-b8d548497306', 3, NULL, 'An die Königin Elisabeth', 'An die Königin Elisabeth', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 29 AND p.title = '가곡집 <메리 스튜어트 여왕의 시>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:043d70c7-037c-4280-8650-b8d548497306'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:c6fcf533-fae3-4948-8e8c-ce14476ad16d', 4, NULL, 'Abschied von der Welt', 'Abschied von der Welt', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 29 AND p.title = '가곡집 <메리 스튜어트 여왕의 시>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:c6fcf533-fae3-4948-8e8c-ce14476ad16d'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:82c7caf1-4f91-4204-bd43-1e39fc65a92d', 5, NULL, 'Gebet', 'Gebet', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 29 AND p.title = '가곡집 <메리 스튜어트 여왕의 시>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:82c7caf1-4f91-4204-bd43-1e39fc65a92d'
);


-- Op. 136 서곡 <헤르만과 도로테아>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '서곡 <헤르만과 도로테아>', 'Overture to Hermann und Dorothea', 'song', 'Op. 136', NULL, NULL, 1851, 'manual', 1
FROM composers c
WHERE c.id = 29
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '서곡 <헤르만과 도로테아>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'a3760a99-260f-3455-ae8a-823b8b13030f'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'a3760a99-260f-3455-ae8a-823b8b13030f'
FROM pieces p
WHERE p.composer_id = 29 AND p.title = '서곡 <헤르만과 도로테아>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'a3760a99-260f-3455-ae8a-823b8b13030f'
);


-- Op. 137 5개의 사냥 노래 Op. 137

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '5개의 사냥 노래 Op. 137', '5 Jagdlieder, Op. 137', 'album', NULL, 'Op.', '137', 1849, 'manual', 1
FROM composers c
WHERE c.id = 29
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '5개의 사냥 노래 Op. 137'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '7ef93bc5-2a5a-44b3-b08f-37eb7c4657e1'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '7ef93bc5-2a5a-44b3-b08f-37eb7c4657e1'
FROM pieces p
WHERE p.composer_id = 29 AND p.title = '5개의 사냥 노래 Op. 137' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '7ef93bc5-2a5a-44b3-b08f-37eb7c4657e1'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:8526f27a-2777-4c7f-9c2b-cbfcbff2aaba', 1, NULL, 'Zu hoher Jagd', 'Zu hoher Jagd', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 29 AND p.title = '5개의 사냥 노래 Op. 137' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:8526f27a-2777-4c7f-9c2b-cbfcbff2aaba'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:51a0faf0-a8b6-4998-b0b6-f6c1c17dd3ce', 2, NULL, 'Habet Acht!', 'Habet Acht!', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 29 AND p.title = '5개의 사냥 노래 Op. 137' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:51a0faf0-a8b6-4998-b0b6-f6c1c17dd3ce'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:6cffe0e2-53e5-4ea1-b826-02a95adb9ce8', 3, NULL, 'Jagdmorgen', 'Jagdmorgen', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 29 AND p.title = '5개의 사냥 노래 Op. 137' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:6cffe0e2-53e5-4ea1-b826-02a95adb9ce8'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:2abd68ce-9639-4e59-8cdc-34fca283c92e', 4, NULL, 'Frühe', 'Frühe', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 29 AND p.title = '5개의 사냥 노래 Op. 137' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:2abd68ce-9639-4e59-8cdc-34fca283c92e'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:07aa87cf-490d-4b71-8af4-a61bb055cfd9', 5, NULL, 'Bei der Flasche', 'Bei der Flasche', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 29 AND p.title = '5개의 사냥 노래 Op. 137' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:07aa87cf-490d-4b71-8af4-a61bb055cfd9'
);


-- Op. 138 가곡집 <스페인 사랑의 노래>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '가곡집 <스페인 사랑의 노래>', 'Spanische Liebeslieder', 'album', 'Op. 138', NULL, NULL, 1849, 'manual', 1
FROM composers c
WHERE c.id = 29
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '가곡집 <스페인 사랑의 노래>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '5f1508f5-3106-497c-9db8-5e093a8ce7e2'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '5f1508f5-3106-497c-9db8-5e093a8ce7e2'
FROM pieces p
WHERE p.composer_id = 29 AND p.title = '가곡집 <스페인 사랑의 노래>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '5f1508f5-3106-497c-9db8-5e093a8ce7e2'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:78c7aa8c-05f5-4ff0-b3c2-2ad787b5d09c', 1, NULL, '전주곡', 'Vorspiel', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 29 AND p.title = '가곡집 <스페인 사랑의 노래>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:78c7aa8c-05f5-4ff0-b3c2-2ad787b5d09c'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:b691fc0b-ed53-4511-a98e-1cccdb6dff49', 2, NULL, 'Tief im Herzen trag'' ich Pein', 'Tief im Herzen trag'' ich Pein', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 29 AND p.title = '가곡집 <스페인 사랑의 노래>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:b691fc0b-ed53-4511-a98e-1cccdb6dff49'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:81e5c519-2d8b-4bcf-bd6a-dd1de03fc842', 3, NULL, 'O wie lieblich ist das Mädchen', 'O wie lieblich ist das Mädchen', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 29 AND p.title = '가곡집 <스페인 사랑의 노래>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:81e5c519-2d8b-4bcf-bd6a-dd1de03fc842'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:cd5fc405-656e-4d89-8f1d-d74b0be64915', 4, NULL, 'Bedeckt mich mit Blumen', 'Bedeckt mich mit Blumen', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 29 AND p.title = '가곡집 <스페인 사랑의 노래>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:cd5fc405-656e-4d89-8f1d-d74b0be64915'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:168eef36-d747-4a18-be65-3587f4f06288', 5, NULL, 'Romanze', 'Romanze', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 29 AND p.title = '가곡집 <스페인 사랑의 노래>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:168eef36-d747-4a18-be65-3587f4f06288'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:19d1d5c8-e4de-4097-af3c-5fad30e275c9', 6, NULL, '간주곡', 'Intermezzo', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 29 AND p.title = '가곡집 <스페인 사랑의 노래>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:19d1d5c8-e4de-4097-af3c-5fad30e275c9'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:19b21a53-a3ba-301e-ab28-8530edb91e9f', 7, NULL, 'Weh, wie zornig ist das Mädchen', 'Weh, wie zornig ist das Mädchen', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 29 AND p.title = '가곡집 <스페인 사랑의 노래>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:19b21a53-a3ba-301e-ab28-8530edb91e9f'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:c2395d33-e029-48d2-b624-3a5f544f3bed', 8, NULL, 'Hoch, hoch sind die Berge', 'Hoch, hoch sind die Berge', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 29 AND p.title = '가곡집 <스페인 사랑의 노래>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:c2395d33-e029-48d2-b624-3a5f544f3bed'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:912a3b94-2092-45b3-8852-2d5600cb9774', 9, NULL, 'Blaue Augen hat das Mädchen', 'Blaue Augen hat das Mädchen', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 29 AND p.title = '가곡집 <스페인 사랑의 노래>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:912a3b94-2092-45b3-8852-2d5600cb9774'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:05f7239c-4ef6-4201-a6f6-be5393da8489', 10, NULL, 'Dunkler Lichtglanz blinder Blick', 'Dunkler Lichtglanz blinder Blick', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 29 AND p.title = '가곡집 <스페인 사랑의 노래>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:05f7239c-4ef6-4201-a6f6-be5393da8489'
);


-- Op. 139 발라드 <가인의 저주>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '발라드 <가인의 저주>', 'Des Sängers Fluch', 'song', 'Op. 139', NULL, NULL, 1852, 'manual', 1
FROM composers c
WHERE c.id = 29
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '발라드 <가인의 저주>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'e8fbe472-fbc3-4b85-a8c2-5f3e535b18a7'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'e8fbe472-fbc3-4b85-a8c2-5f3e535b18a7'
FROM pieces p
WHERE p.composer_id = 29 AND p.title = '발라드 <가인의 저주>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'e8fbe472-fbc3-4b85-a8c2-5f3e535b18a7'
);


-- Op. 140 발라드 <시동과 공주>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '발라드 <시동과 공주>', 'Vom Pagen und der Königstochter', 'song', 'Op. 140', NULL, NULL, 1852, 'manual', 1
FROM composers c
WHERE c.id = 29
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '발라드 <시동과 공주>'
);


-- Op. 141 이중 합창을 위한 4개의 노래 Op. 141

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '이중 합창을 위한 4개의 노래 Op. 141', '4 doppelchörige Gesänge, Op. 141', 'album', NULL, 'Op.', '141', 1849, 'manual', 1
FROM composers c
WHERE c.id = 29
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '이중 합창을 위한 4개의 노래 Op. 141'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '2e54187b-d4bf-4cac-aff4-391717a7e533'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '2e54187b-d4bf-4cac-aff4-391717a7e533'
FROM pieces p
WHERE p.composer_id = 29 AND p.title = '이중 합창을 위한 4개의 노래 Op. 141' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '2e54187b-d4bf-4cac-aff4-391717a7e533'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:093f0258-2af2-4b69-8226-722444d2ee29', 1, NULL, 'An die Sterne', 'An die Sterne', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 29 AND p.title = '이중 합창을 위한 4개의 노래 Op. 141' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:093f0258-2af2-4b69-8226-722444d2ee29'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:9826cc30-275a-4022-9536-da02df504e83', 2, NULL, 'Ungewisses Licht', 'Ungewisses Licht', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 29 AND p.title = '이중 합창을 위한 4개의 노래 Op. 141' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:9826cc30-275a-4022-9536-da02df504e83'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:c760d1db-17aa-45f1-a4df-c762788e03dd', 3, NULL, 'Zuversicht', 'Zuversicht', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 29 AND p.title = '이중 합창을 위한 4개의 노래 Op. 141' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:c760d1db-17aa-45f1-a4df-c762788e03dd'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:24daf19c-0b30-43a2-b9bb-150ae867d202', 4, NULL, 'Talismane', 'Talismane', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 29 AND p.title = '이중 합창을 위한 4개의 노래 Op. 141' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:24daf19c-0b30-43a2-b9bb-150ae867d202'
);


-- Op. 142 4개의 노래 Op. 142

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '4개의 노래 Op. 142', '4 Gesänge, Op. 142', 'album', NULL, 'Op.', '142', 1852, 'manual', 1
FROM composers c
WHERE c.id = 29
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '4개의 노래 Op. 142'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '6ab10e48-2bad-4f76-a105-d0a085cdd1e8'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '6ab10e48-2bad-4f76-a105-d0a085cdd1e8'
FROM pieces p
WHERE p.composer_id = 29 AND p.title = '4개의 노래 Op. 142' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '6ab10e48-2bad-4f76-a105-d0a085cdd1e8'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:78655dd1-b891-3373-a34a-4944b8030326', 1, NULL, 'Trost im Gesang', 'Trost im Gesang', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 29 AND p.title = '4개의 노래 Op. 142' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:78655dd1-b891-3373-a34a-4944b8030326'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:0568c0c4-44df-3a5d-a45a-f3ee97828a6b', 2, NULL, 'Lehn deine Wang''', 'Lehn deine Wang''', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 29 AND p.title = '4개의 노래 Op. 142' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:0568c0c4-44df-3a5d-a45a-f3ee97828a6b'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:eee612c2-1f7a-49fd-a22d-b799720d34f1', 3, NULL, 'Mädchen-Schwermut', 'Mädchen-Schwermut', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 29 AND p.title = '4개의 노래 Op. 142' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:eee612c2-1f7a-49fd-a22d-b799720d34f1'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:879ff29d-45c3-353c-b578-695f4bf21113', 4, NULL, 'Mein Wagen rollet langsam', 'Mein Wagen rollet langsam', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 29 AND p.title = '4개의 노래 Op. 142' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:879ff29d-45c3-353c-b578-695f4bf21113'
);


-- Op. 143 발라드 <에덴홀의 행운>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '발라드 <에덴홀의 행운>', 'Das Glück von Edenhall', 'song', 'Op. 143', NULL, NULL, 1853, 'manual', 1
FROM composers c
WHERE c.id = 29
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '발라드 <에덴홀의 행운>'
);


-- Op. 144 <새해의 노래>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '<새해의 노래>', 'Neujahrslied', 'song', 'Op. 144', NULL, NULL, 1850, 'manual', 1
FROM composers c
WHERE c.id = 29
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '<새해의 노래>'
);


-- Op. 145 합창을 위한 로망스와 발라드 3집 Op. 145

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '합창을 위한 로망스와 발라드 3집 Op. 145', 'Romanzen und Balladen for chorus, Vol. III, Op. 145', 'album', NULL, 'Op.', '145', 1851, 'manual', 1
FROM composers c
WHERE c.id = 29
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '합창을 위한 로망스와 발라드 3집 Op. 145'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'ae12bd08-b4de-4a40-a08f-94b1ae0e3086'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'ae12bd08-b4de-4a40-a08f-94b1ae0e3086'
FROM pieces p
WHERE p.composer_id = 29 AND p.title = '합창을 위한 로망스와 발라드 3집 Op. 145' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'ae12bd08-b4de-4a40-a08f-94b1ae0e3086'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:56145cad-5335-4651-8fc6-c5a9eec641f8', 1, NULL, 'Der Schmied', 'Der Schmied', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 29 AND p.title = '합창을 위한 로망스와 발라드 3집 Op. 145' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:56145cad-5335-4651-8fc6-c5a9eec641f8'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:bc832df1-a00c-49d8-af9b-4c0be224ba55', 2, NULL, 'Die Nonne', 'Die Nonne', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 29 AND p.title = '합창을 위한 로망스와 발라드 3집 Op. 145' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:bc832df1-a00c-49d8-af9b-4c0be224ba55'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:7c8300ad-8b48-4414-9402-4a976290f061', 3, NULL, 'Der Sänger', 'Der Sänger', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 29 AND p.title = '합창을 위한 로망스와 발라드 3집 Op. 145' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:7c8300ad-8b48-4414-9402-4a976290f061'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:feb7930d-e643-461d-998a-f0418a52f671', 4, NULL, 'John Anderson', 'John Anderson', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 29 AND p.title = '합창을 위한 로망스와 발라드 3집 Op. 145' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:feb7930d-e643-461d-998a-f0418a52f671'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:4ce42930-af0d-446d-9e66-4f5ef1533b77', 5, NULL, 'Romanze vom Gänsebuben', 'Romanze vom Gänsebuben', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 29 AND p.title = '합창을 위한 로망스와 발라드 3집 Op. 145' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:4ce42930-af0d-446d-9e66-4f5ef1533b77'
);


-- Op. 146 합창을 위한 로망스와 발라드 4집 Op. 146

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '합창을 위한 로망스와 발라드 4집 Op. 146', 'Romanzen und Balladen for chorus, Vol. IV, Op. 146', 'album', NULL, 'Op.', '146', 1849, 'manual', 1
FROM composers c
WHERE c.id = 29
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '합창을 위한 로망스와 발라드 4집 Op. 146'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'b4463ad4-7324-4660-abb7-e0f1aaaf2957'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'b4463ad4-7324-4660-abb7-e0f1aaaf2957'
FROM pieces p
WHERE p.composer_id = 29 AND p.title = '합창을 위한 로망스와 발라드 4집 Op. 146' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'b4463ad4-7324-4660-abb7-e0f1aaaf2957'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:4019ef75-ed74-49ef-a883-d31911b4e483', 1, NULL, 'Brautgesang', 'Brautgesang', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 29 AND p.title = '합창을 위한 로망스와 발라드 4집 Op. 146' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:4019ef75-ed74-49ef-a883-d31911b4e483'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:ce39c5b0-8228-49c4-a812-7889364e7d4e', 2, NULL, 'Bänkelsänger Willie', 'Bänkelsänger Willie', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 29 AND p.title = '합창을 위한 로망스와 발라드 4집 Op. 146' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:ce39c5b0-8228-49c4-a812-7889364e7d4e'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:4b1cf477-5f2d-45ad-8810-853c53007f0e', 3, NULL, 'Der Traum', 'Der Traum', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 29 AND p.title = '합창을 위한 로망스와 발라드 4집 Op. 146' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:4b1cf477-5f2d-45ad-8810-853c53007f0e'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:4244051d-1295-4b88-8831-4a75830cfc72', 4, NULL, 'Sommerlied', 'Sommerlied', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 29 AND p.title = '합창을 위한 로망스와 발라드 4집 Op. 146' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:4244051d-1295-4b88-8831-4a75830cfc72'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:45d1f516-7980-44d3-bb88-d12752a0cf52', 5, NULL, 'Das Schifflein', 'Das Schifflein', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 29 AND p.title = '합창을 위한 로망스와 발라드 4집 Op. 146' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:45d1f516-7980-44d3-bb88-d12752a0cf52'
);


-- Op. 147 미사 C단조

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '미사 C단조', 'Mass in C minor (Missa sacra)', 'album', 'Op. 147', NULL, NULL, 1852, 'manual', 1
FROM composers c
WHERE c.id = 29
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '미사 C단조'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '985cd0d7-4aff-49df-a3d2-65dab4fdeb28'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '985cd0d7-4aff-49df-a3d2-65dab4fdeb28'
FROM pieces p
WHERE p.composer_id = 29 AND p.title = '미사 C단조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '985cd0d7-4aff-49df-a3d2-65dab4fdeb28'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:7310be14-a60e-4d7b-9b5e-9f0d435eb2af', 1, 'I', '키리에', 'I. Kyrie', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 29 AND p.title = '미사 C단조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:7310be14-a60e-4d7b-9b5e-9f0d435eb2af'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:46804ff9-94e9-406e-bb52-6133299aab47', 2, 'II', '글로리아', 'II. Gloria', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 29 AND p.title = '미사 C단조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:46804ff9-94e9-406e-bb52-6133299aab47'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:aa75450d-6aab-4063-88bd-96822b34be6d', 3, 'III', '크레도', 'III. Credo', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 29 AND p.title = '미사 C단조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:aa75450d-6aab-4063-88bd-96822b34be6d'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:15f287bf-ab77-4ccc-9561-c93a3a347667', 4, 'IV', '봉헌송', 'IV. Offertorium', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 29 AND p.title = '미사 C단조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:15f287bf-ab77-4ccc-9561-c93a3a347667'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:354d244b-3105-428b-8fc2-192d6df25dbe', 5, 'V', '상투스', 'V. Sanctus', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 29 AND p.title = '미사 C단조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:354d244b-3105-428b-8fc2-192d6df25dbe'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:95cfe670-77f5-4ce1-a903-90c95e8e487d', 6, 'VI', '아뉴스 데이', 'VI. Agnus Dei', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 29 AND p.title = '미사 C단조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:95cfe670-77f5-4ce1-a903-90c95e8e487d'
);


-- Op. 148 레퀴엠 D♭장조

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '레퀴엠 D♭장조', 'Requiem in D♭ major', 'album', 'Op. 148', NULL, NULL, 1852, 'manual', 1
FROM composers c
WHERE c.id = 29
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '레퀴엠 D♭장조'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'fd52ede7-039f-45d5-b1fe-fd9f7bbf94d9'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'fd52ede7-039f-45d5-b1fe-fd9f7bbf94d9'
FROM pieces p
WHERE p.composer_id = 29 AND p.title = '레퀴엠 D♭장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'fd52ede7-039f-45d5-b1fe-fd9f7bbf94d9'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:89df6470-cf7f-4162-8185-1d7c93a16906', 1, 'I', '레퀴엠 에테르남', 'I. Requiem aeternam', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 29 AND p.title = '레퀴엠 D♭장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:89df6470-cf7f-4162-8185-1d7c93a16906'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:d4ea6837-906d-44a7-b8ce-6c6036bf0442', 2, 'II', '테 데케트 힘누스', 'II. Te decet hymnus', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 29 AND p.title = '레퀴엠 D♭장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:d4ea6837-906d-44a7-b8ce-6c6036bf0442'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:0ff9890d-b793-4887-af10-4a2f2b3d2a74', 3, 'III', '디에스 이레', 'III. Dies irae', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 29 AND p.title = '레퀴엠 D♭장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:0ff9890d-b793-4887-af10-4a2f2b3d2a74'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:3d2f113a-0da2-4125-9d29-cbd28d336a94', 4, 'IV', '리베르 스크립투스', 'IV. Liber scriptus proferetur', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 29 AND p.title = '레퀴엠 D♭장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:3d2f113a-0da2-4125-9d29-cbd28d336a94'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:4272ad4b-1227-497f-b8f4-b71ceb5199ab', 5, 'V', '퀴 마리암 압솔비스티', 'V. Qui Mariam absolvisti', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 29 AND p.title = '레퀴엠 D♭장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:4272ad4b-1227-497f-b8f4-b71ceb5199ab'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:fefc67ee-512b-4a2a-9277-f67c880ac336', 6, 'VI', '도미네 예수 크리스테', 'VI. Domine Jesu Christe', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 29 AND p.title = '레퀴엠 D♭장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:fefc67ee-512b-4a2a-9277-f67c880ac336'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:48a10b20-9607-4032-8fb4-d3633261aa00', 7, 'VII', '호스티아스', 'VII. Hostias', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 29 AND p.title = '레퀴엠 D♭장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:48a10b20-9607-4032-8fb4-d3633261aa00'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:5f55138b-3935-41fe-b25c-1d2bd862471e', 8, 'VIII', '상투스', 'VIII. Sanctus', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 29 AND p.title = '레퀴엠 D♭장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:5f55138b-3935-41fe-b25c-1d2bd862471e'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:9983d9fb-8977-4ea3-9807-889bc022ddf0', 9, 'IX', '베네딕투스', 'IX. Benedictus', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 29 AND p.title = '레퀴엠 D♭장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:9983d9fb-8977-4ea3-9807-889bc022ddf0'
);


-- WoO 1 가곡 <독일의 라인>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '가곡 <독일의 라인>', 'Der deutsche Rhein', 'song', 'WoO 1', NULL, NULL, 1840, 'manual', 1
FROM composers c
WHERE c.id = 29
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '가곡 <독일의 라인>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '64d233b5-8ee2-4bde-ae1f-7304fbf13c95'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '64d233b5-8ee2-4bde-ae1f-7304fbf13c95'
FROM pieces p
WHERE p.composer_id = 29 AND p.title = '가곡 <독일의 라인>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '64d233b5-8ee2-4bde-ae1f-7304fbf13c95'
);


-- WoO 2 바이올린 소나타 3번 A단조

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '바이올린 소나타 3번 A단조', 'Violin Sonata No. 3 in A minor', 'album', 'WoO 2', NULL, NULL, 1853, 'manual', 1
FROM composers c
WHERE c.id = 29
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '바이올린 소나타 3번 A단조'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '9479a2e0-9922-4611-8ae5-7fae5d9ec0ff'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '9479a2e0-9922-4611-8ae5-7fae5d9ec0ff'
FROM pieces p
WHERE p.composer_id = 29 AND p.title = '바이올린 소나타 3번 A단조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '9479a2e0-9922-4611-8ae5-7fae5d9ec0ff'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:49b9b9f3-e3a0-41d9-a889-7670fca4b0c4', 1, 'I', 'Ziemlich langsam – Lebhaft', 'I. Ziemlich langsam – Lebhaft', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 29 AND p.title = '바이올린 소나타 3번 A단조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:49b9b9f3-e3a0-41d9-a889-7670fca4b0c4'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:3d19aef4-4a9e-4d65-941c-1048dd871072', 2, 'II', '스케르초. Lebhaft', 'II. Scherzo. Lebhaft', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 29 AND p.title = '바이올린 소나타 3번 A단조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:3d19aef4-4a9e-4d65-941c-1048dd871072'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:f6e4f602-99ad-455b-9234-f6270c32d75f', 3, 'III', '간주곡. Bewegt, doch nicht zu schnell', 'III. Intermezzo. Bewegt, doch nicht zu schnell', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 29 AND p.title = '바이올린 소나타 3번 A단조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:f6e4f602-99ad-455b-9234-f6270c32d75f'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:2927803e-b372-4b95-973b-3a6de0addbc9', 4, 'IV', '피날레. Markiertes, ziemlich lebhaftes Tempo', 'IV. Finale. Markiertes, ziemlich lebhaftes Tempo', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 29 AND p.title = '바이올린 소나타 3번 A단조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:2927803e-b372-4b95-973b-3a6de0addbc9'
);


-- WoO 3 <괴테의 파우스트 장면>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '<괴테의 파우스트 장면>', 'Szenen aus Goethes Faust', 'song', 'WoO 3', NULL, NULL, 1853, 'manual', 1
FROM composers c
WHERE c.id = 29
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '<괴테의 파우스트 장면>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '8cce6a19-4acd-44ff-8bb7-928b72f75fcd'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '8cce6a19-4acd-44ff-8bb7-928b72f75fcd'
FROM pieces p
WHERE p.composer_id = 29 AND p.title = '<괴테의 파우스트 장면>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '8cce6a19-4acd-44ff-8bb7-928b72f75fcd'
);


-- WoO 4 힘멜의 "An Alexis send' ich dich"에 의한 카논 A♭장조

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '힘멜의 "An Alexis send'' ich dich"에 의한 카논 A♭장조', 'Canon on F. H. Himmel''s "An Alexis send'' ich dich" in A♭ major', 'song', 'WoO 4', NULL, NULL, 1833, 'manual', 1
FROM composers c
WHERE c.id = 29
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '힘멜의 "An Alexis send'' ich dich"에 의한 카논 A♭장조'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '8aa5e598-8d52-4211-b134-fb60aa271423'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '8aa5e598-8d52-4211-b134-fb60aa271423'
FROM pieces p
WHERE p.composer_id = 29 AND p.title = '힘멜의 "An Alexis send'' ich dich"에 의한 카논 A♭장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '8aa5e598-8d52-4211-b134-fb60aa271423'
);


-- WoO 5 스케르초와 프레스토 파시오나토

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '스케르초와 프레스토 파시오나토', 'Scherzo and Presto passionato', 'album', 'WoO 5', NULL, NULL, 1835, 'manual', 1
FROM composers c
WHERE c.id = 29
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '스케르초와 프레스토 파시오나토'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:301a5bcf-0031-44f9-a174-ef69382c264c', 1, NULL, '스케르초 F단조', 'Scherzo in F minor', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 29 AND p.title = '스케르초와 프레스토 파시오나토' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:301a5bcf-0031-44f9-a174-ef69382c264c'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:f8af6aea-9dcb-34a1-ae5c-3bdf92a346ff', 2, NULL, '프레스토 파시오나토 G단조', 'Presto passionato in G minor', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 29 AND p.title = '스케르초와 프레스토 파시오나토' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:f8af6aea-9dcb-34a1-ae5c-3bdf92a346ff'
);


-- WoO 6 교향적 연습곡의 유작 변주

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '교향적 연습곡의 유작 변주', 'Supplementary Variations to the Symphonic Études', 'album', 'WoO 6', NULL, NULL, 1837, 'manual', 1
FROM composers c
WHERE c.id = 29
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '교향적 연습곡의 유작 변주'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '2edb342f-e5b6-4f81-b423-d7d6b2f7b5f5'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '2edb342f-e5b6-4f81-b423-d7d6b2f7b5f5'
FROM pieces p
WHERE p.composer_id = 29 AND p.title = '교향적 연습곡의 유작 변주' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '2edb342f-e5b6-4f81-b423-d7d6b2f7b5f5'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:d77088d9-b390-3804-b8da-e1552cf989ec', 1, NULL, '1변주', 'Variation I', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 29 AND p.title = '교향적 연습곡의 유작 변주' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:d77088d9-b390-3804-b8da-e1552cf989ec'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:e9e1f130-a580-3136-9872-d6654abb56f8', 2, NULL, '2변주', 'Variation II', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 29 AND p.title = '교향적 연습곡의 유작 변주' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:e9e1f130-a580-3136-9872-d6654abb56f8'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:a80220cf-2cdc-377d-9629-29edf5f228c6', 3, NULL, '3변주', 'Variation III', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 29 AND p.title = '교향적 연습곡의 유작 변주' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:a80220cf-2cdc-377d-9629-29edf5f228c6'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:10a6351d-47a4-3a71-a111-50515b369f87', 4, NULL, '4변주', 'Variation IV', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 29 AND p.title = '교향적 연습곡의 유작 변주' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:10a6351d-47a4-3a71-a111-50515b369f87'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:524e10c9-64ef-3b84-9445-25b41225f8fe', 5, NULL, '5변주', 'Variation V', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 29 AND p.title = '교향적 연습곡의 유작 변주' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:524e10c9-64ef-3b84-9445-25b41225f8fe'
);


-- WoO 7 가곡 <병사의 노래>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '가곡 <병사의 노래>', 'Soldatenlied', 'song', 'WoO 7', NULL, NULL, 1844, 'manual', 1
FROM composers c
WHERE c.id = 29
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '가곡 <병사의 노래>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '4288f20e-a688-406c-86e0-09e51c4e7051'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '4288f20e-a688-406c-86e0-09e51c4e7051'
FROM pieces p
WHERE p.composer_id = 29 AND p.title = '가곡 <병사의 노래>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '4288f20e-a688-406c-86e0-09e51c4e7051'
);


-- WoO 8 가곡 <다시 만날 때까지>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '가곡 <다시 만날 때까지>', 'Albumblatt "Auf Wiedersehen" für Niels W. Gade', 'song', 'WoO 8', NULL, NULL, 1844, 'manual', 1
FROM composers c
WHERE c.id = 29
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '가곡 <다시 만날 때까지>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'c2a8fd84-3c76-44bf-ad86-5a31eac52f20'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'c2a8fd84-3c76-44bf-ad86-5a31eac52f20'
FROM pieces p
WHERE p.composer_id = 29 AND p.title = '가곡 <다시 만날 때까지>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'c2a8fd84-3c76-44bf-ad86-5a31eac52f20'
);


-- WoO 9 이중창 <여름의 휴식>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '이중창 <여름의 휴식>', 'Sommerruh', 'song', 'WoO 9', NULL, NULL, 1849, 'manual', 1
FROM composers c
WHERE c.id = 29
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '이중창 <여름의 휴식>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '360848c8-72b3-4d0b-822e-d9c4ec6c469f'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '360848c8-72b3-4d0b-822e-d9c4ec6c469f'
FROM pieces p
WHERE p.composer_id = 29 AND p.title = '이중창 <여름의 휴식>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '360848c8-72b3-4d0b-822e-d9c4ec6c469f'
);


-- WoO 11 2개의 발라드 WoO 11

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '2개의 발라드 WoO 11', '2 Balladen, WoO 11', 'album', NULL, 'WoO', '11', 1840, 'manual', 1
FROM composers c
WHERE c.id = 29
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '2개의 발라드 WoO 11'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:9d3edcec-378e-450b-b7f8-b883415176eb', 1, NULL, 'Der Reiter und der Bodensee', 'Der Reiter und der Bodensee', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 29 AND p.title = '2개의 발라드 WoO 11' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:9d3edcec-378e-450b-b7f8-b883415176eb'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:e9cde5de-320f-429e-a2d3-bd4a99773195', 2, NULL, 'Die nächtliche Heerschau', 'Die nächtliche Heerschau', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 29 AND p.title = '2개의 발라드 WoO 11' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:e9cde5de-320f-429e-a2d3-bd4a99773195'
);


-- WoO 12 남성 합창을 위한 카논 "Hätte zu einem Traubenkerne"

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '남성 합창을 위한 카논 "Hätte zu einem Traubenkerne"', 'Canon for male voices "Hätte zu einem Traubenkerne"', 'song', 'WoO 12', NULL, NULL, 1847, 'manual', 1
FROM composers c
WHERE c.id = 29
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '남성 합창을 위한 카논 "Hätte zu einem Traubenkerne"'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'c42ec90e-5cc6-4850-8226-08ddc0246fc1'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'c42ec90e-5cc6-4850-8226-08ddc0246fc1'
FROM pieces p
WHERE p.composer_id = 29 AND p.title = '남성 합창을 위한 카논 "Hätte zu einem Traubenkerne"' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'c42ec90e-5cc6-4850-8226-08ddc0246fc1'
);


-- WoO 13–15 3개의 자유의 노래

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '3개의 자유의 노래', '3 Freiheitsgesänge', 'album', 'WoO 13–15', NULL, NULL, 1848, 'manual', 1
FROM composers c
WHERE c.id = 29
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '3개의 자유의 노래'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:edb69d65-d9e6-4799-95a9-0d5d540b8eca', 1, NULL, 'Schwarz-Rot-Gold', 'Schwarz-Rot-Gold', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 29 AND p.title = '3개의 자유의 노래' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:edb69d65-d9e6-4799-95a9-0d5d540b8eca'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:d013e208-fa30-4f83-bd9f-4d458b207291', 2, NULL, 'Zu den Waffen', 'Zu den Waffen', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 29 AND p.title = '3개의 자유의 노래' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:d013e208-fa30-4f83-bd9f-4d458b207291'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:bd899d14-4110-48c4-b8d6-5574fcb5a9c7', 3, NULL, 'Deutscher Freiheitsgesang', 'Deutscher Freiheitsgesang', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 29 AND p.title = '3개의 자유의 노래' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:bd899d14-4110-48c4-b8d6-5574fcb5a9c7'
);


-- WoO 16 4개의 작은 피아노 소품 WoO 16

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '4개의 작은 피아노 소품 WoO 16', '4 Little Piano Pieces, WoO 16', 'album', NULL, 'WoO', '16', 1848, 'manual', 1
FROM composers c
WHERE c.id = 29
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '4개의 작은 피아노 소품 WoO 16'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '1b482417-9bd0-467a-a044-45ac43c2b60f'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '1b482417-9bd0-467a-a044-45ac43c2b60f'
FROM pieces p
WHERE p.composer_id = 29 AND p.title = '4개의 작은 피아노 소품 WoO 16' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '1b482417-9bd0-467a-a044-45ac43c2b60f'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:97e30a5b-311c-41e1-a027-2f9f4bfba81c', 1, NULL, 'Kuckuck im Versteck', 'Kuckuck im Versteck', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 29 AND p.title = '4개의 작은 피아노 소품 WoO 16' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:97e30a5b-311c-41e1-a027-2f9f4bfba81c'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:cf4b87a9-382d-40f7-b789-679592e1b6d2', 2, NULL, 'Lagune in Venedig', 'Lagune in Venedig', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 29 AND p.title = '4개의 작은 피아노 소품 WoO 16' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:cf4b87a9-382d-40f7-b789-679592e1b6d2'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:6f9fa17f-2fa1-4e9f-94cb-ae6447cc36f6', 3, NULL, 'Haschemann', 'Haschemann', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 29 AND p.title = '4개의 작은 피아노 소품 WoO 16' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:6f9fa17f-2fa1-4e9f-94cb-ae6447cc36f6'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:1cd3d23c-8631-4b36-8981-a35ae028fc92', 4, NULL, 'Kleiner Walzer', 'Kleiner Walzer', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 29 AND p.title = '4개의 작은 피아노 소품 WoO 16' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:1cd3d23c-8631-4b36-8981-a35ae028fc92'
);


-- WoO 17 남성 합창을 위한 카논 "Zum Anfang"

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '남성 합창을 위한 카논 "Zum Anfang"', 'Canon for male voices "Zum Anfang"', 'song', 'WoO 17', NULL, NULL, 1847, 'manual', 1
FROM composers c
WHERE c.id = 29
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '남성 합창을 위한 카논 "Zum Anfang"'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '30d65507-9ed4-48c9-bee8-7bcd08f36005'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '30d65507-9ed4-48c9-bee8-7bcd08f36005'
FROM pieces p
WHERE p.composer_id = 29 AND p.title = '남성 합창을 위한 카논 "Zum Anfang"' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '30d65507-9ed4-48c9-bee8-7bcd08f36005'
);


-- WoO 18 합창곡 <목동의 노래>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '합창곡 <목동의 노래>', 'Hirtenknaben-Gesang', 'song', 'WoO 18', NULL, NULL, 1846, 'manual', 1
FROM composers c
WHERE c.id = 29
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '합창곡 <목동의 노래>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '8aa562c5-c9bc-446c-a43d-6090b08dfc2e'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '8aa562c5-c9bc-446c-a43d-6090b08dfc2e'
FROM pieces p
WHERE p.composer_id = 29 AND p.title = '합창곡 <목동의 노래>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '8aa562c5-c9bc-446c-a43d-6090b08dfc2e'
);


-- WoO 19 가곡 <어부>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '가곡 <어부>', 'Der Fischer', 'song', 'WoO 19', NULL, NULL, 1828, 'manual', 1
FROM composers c
WHERE c.id = 29
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '가곡 <어부>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'c277ac1d-bac9-4d2b-b34a-9c1c26f9df24'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'c277ac1d-bac9-4d2b-b34a-9c1c26f9df24'
FROM pieces p
WHERE p.composer_id = 29 AND p.title = '가곡 <어부>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'c277ac1d-bac9-4d2b-b34a-9c1c26f9df24'
);


-- WoO 20 피아노 연탄을 위한 8개의 폴로네즈

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '피아노 연탄을 위한 8개의 폴로네즈', '8 Polonaises for piano four hands', 'song', 'WoO 20', NULL, NULL, 1828, 'manual', 1
FROM composers c
WHERE c.id = 29
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '피아노 연탄을 위한 8개의 폴로네즈'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '536f2af7-920a-4344-8dbe-79d475fce30a'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '536f2af7-920a-4344-8dbe-79d475fce30a'
FROM pieces p
WHERE p.composer_id = 29 AND p.title = '피아노 연탄을 위한 8개의 폴로네즈' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '536f2af7-920a-4344-8dbe-79d475fce30a'
);


-- WoO 21 6개의 청년기 가곡 WoO 21

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '6개의 청년기 가곡 WoO 21', '6 Jugendlieder, WoO 21', 'album', NULL, 'WoO', '21', 1828, 'manual', 1
FROM composers c
WHERE c.id = 29
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '6개의 청년기 가곡 WoO 21'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'ed02ecaf-dcad-49af-83c9-f0443952424c'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'ed02ecaf-dcad-49af-83c9-f0443952424c'
FROM pieces p
WHERE p.composer_id = 29 AND p.title = '6개의 청년기 가곡 WoO 21' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'ed02ecaf-dcad-49af-83c9-f0443952424c'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:627e2fe9-3149-3a42-9fab-d246a9e81ae6', 1, NULL, 'Sehnsucht', 'Sehnsucht', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 29 AND p.title = '6개의 청년기 가곡 WoO 21' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:627e2fe9-3149-3a42-9fab-d246a9e81ae6'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:be1be34e-7786-3775-8eeb-99a6d6b0563e', 2, NULL, 'Die Weinende', 'Die Weinende', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 29 AND p.title = '6개의 청년기 가곡 WoO 21' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:be1be34e-7786-3775-8eeb-99a6d6b0563e'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:994974a4-ea54-33a3-bde7-ac082e276d9b', 3, NULL, 'Erinnerung', 'Erinnerung', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 29 AND p.title = '6개의 청년기 가곡 WoO 21' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:994974a4-ea54-33a3-bde7-ac082e276d9b'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:908205a7-1a51-3214-bae9-7eeed1c47c87', 4, NULL, 'Kurzes Erwachen', 'Kurzes Erwachen', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 29 AND p.title = '6개의 청년기 가곡 WoO 21' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:908205a7-1a51-3214-bae9-7eeed1c47c87'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:67afb755-a488-3121-bdd2-c4d65de7b222', 5, NULL, 'Gesanges Erwachen', 'Gesanges Erwachen', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 29 AND p.title = '6개의 청년기 가곡 WoO 21' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:67afb755-a488-3121-bdd2-c4d65de7b222'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:2a0025f4-105e-3e2f-b2bf-0b312462da8f', 6, NULL, 'An Anna', 'An Anna', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 29 AND p.title = '6개의 청년기 가곡 WoO 21' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:2a0025f4-105e-3e2f-b2bf-0b312462da8f'
);


-- WoO 23 바이올린 협주곡 D단조

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '바이올린 협주곡 D단조', 'Violin Concerto in D minor', 'album', 'WoO 23', NULL, NULL, 1853, 'manual', 1
FROM composers c
WHERE c.id = 29
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '바이올린 협주곡 D단조'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '3ffacbfd-1f8f-4991-ab98-ffde8ad18c9d'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '3ffacbfd-1f8f-4991-ab98-ffde8ad18c9d'
FROM pieces p
WHERE p.composer_id = 29 AND p.title = '바이올린 협주곡 D단조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '3ffacbfd-1f8f-4991-ab98-ffde8ad18c9d'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:e4479209-b6bb-3abe-b3db-3470b354e104', 1, 'I', 'In kräftigem, nicht zu schnellem Tempo', 'I. In kräftigem, nicht zu schnellem Tempo', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 29 AND p.title = '바이올린 협주곡 D단조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:e4479209-b6bb-3abe-b3db-3470b354e104'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:bf84127d-0914-3436-8180-901ae6a26465', 2, 'II', 'Langsam', 'II. Langsam', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 29 AND p.title = '바이올린 협주곡 D단조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:bf84127d-0914-3436-8180-901ae6a26465'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:73c884bc-4f4f-30cb-93db-af350752faad', 3, 'III', 'Lebhaft, doch nicht schnell', 'III. Lebhaft, doch nicht schnell', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 29 AND p.title = '바이올린 협주곡 D단조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:73c884bc-4f4f-30cb-93db-af350752faad'
);


-- WoO 24 유령 변주곡 E♭장조

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '유령 변주곡 E♭장조', 'Geistervariationen in E♭ major', 'album', 'WoO 24', NULL, NULL, 1854, 'manual', 1
FROM composers c
WHERE c.id = 29
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '유령 변주곡 E♭장조'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '054f14c0-8edf-43b5-8946-88f9bd6c3dc1'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '054f14c0-8edf-43b5-8946-88f9bd6c3dc1'
FROM pieces p
WHERE p.composer_id = 29 AND p.title = '유령 변주곡 E♭장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '054f14c0-8edf-43b5-8946-88f9bd6c3dc1'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:82e4367a-7334-3f48-800d-1f3b3ba4799d', 1, NULL, '주제', 'Thema', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 29 AND p.title = '유령 변주곡 E♭장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:82e4367a-7334-3f48-800d-1f3b3ba4799d'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:03962b81-77aa-3edc-8f6c-712a4b2cbfda', 2, NULL, '1변주', 'Variation I', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 29 AND p.title = '유령 변주곡 E♭장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:03962b81-77aa-3edc-8f6c-712a4b2cbfda'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:d559ba02-486b-3dc6-aa2c-fb3695a0232e', 3, NULL, '2변주', 'Variation II', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 29 AND p.title = '유령 변주곡 E♭장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:d559ba02-486b-3dc6-aa2c-fb3695a0232e'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:912b22f0-e188-3973-9d8b-a9b830583e4e', 4, NULL, '3변주', 'Variation III', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 29 AND p.title = '유령 변주곡 E♭장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:912b22f0-e188-3973-9d8b-a9b830583e4e'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:6b1f0dac-af18-374a-b838-b50974d3711a', 5, NULL, '4변주', 'Variation IV', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 29 AND p.title = '유령 변주곡 E♭장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:6b1f0dac-af18-374a-b838-b50974d3711a'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:d164096e-b391-3c78-b394-5a79cc79dcb7', 6, NULL, '5변주', 'Variation V', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 29 AND p.title = '유령 변주곡 E♭장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:d164096e-b391-3c78-b394-5a79cc79dcb7'
);


-- WoO 28 환상소곡 (Op. 12 부록)

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '환상소곡 (Op. 12 부록)', 'Fantasiestück (Supplement to Op. 12)', 'song', 'WoO 28', NULL, NULL, 1837, 'manual', 1
FROM composers c
WHERE c.id = 29
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '환상소곡 (Op. 12 부록)'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '967a6cc7-7259-3ca5-a011-13ce04983a89'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '967a6cc7-7259-3ca5-a011-13ce04983a89'
FROM pieces p
WHERE p.composer_id = 29 AND p.title = '환상소곡 (Op. 12 부록)' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '967a6cc7-7259-3ca5-a011-13ce04983a89'
);


-- WoO 31 베토벤 주제에 의한 자유 변주 형식의 연습곡

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '베토벤 주제에 의한 자유 변주 형식의 연습곡', 'Studies in the Form of Free Variations on a Theme by Beethoven', 'song', 'WoO 31', NULL, NULL, 1835, 'manual', 1
FROM composers c
WHERE c.id = 29
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '베토벤 주제에 의한 자유 변주 형식의 연습곡'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '126b0400-60e1-47b2-96e1-e249a27e459c'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '126b0400-60e1-47b2-96e1-e249a27e459c'
FROM pieces p
WHERE p.composer_id = 29 AND p.title = '베토벤 주제에 의한 자유 변주 형식의 연습곡' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '126b0400-60e1-47b2-96e1-e249a27e459c'
);


-- WoO 32 피아노 4중주 C단조

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '피아노 4중주 C단조', 'Piano Quartet in C minor', 'album', 'WoO 32', NULL, NULL, 1829, 'manual', 1
FROM composers c
WHERE c.id = 29
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '피아노 4중주 C단조'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '3948cc50-8334-4b9c-aad0-7023481cc536'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '3948cc50-8334-4b9c-aad0-7023481cc536'
FROM pieces p
WHERE p.composer_id = 29 AND p.title = '피아노 4중주 C단조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '3948cc50-8334-4b9c-aad0-7023481cc536'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:ddb7ed63-3dc9-443e-b373-835348828f09', 1, 'I', 'Allegro molto affettuoso', 'I. Allegro molto affettuoso', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 29 AND p.title = '피아노 4중주 C단조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:ddb7ed63-3dc9-443e-b373-835348828f09'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:42a1511d-5831-464d-b6a9-ddef6f4cab24', 2, 'II', '미뉴에트. Presto', 'II. Minuetto. Presto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 29 AND p.title = '피아노 4중주 C단조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:42a1511d-5831-464d-b6a9-ddef6f4cab24'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:68b172d5-127c-42c0-af2b-382a991c3691', 3, 'III', 'Andante', 'III. Andante', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 29 AND p.title = '피아노 4중주 C단조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:68b172d5-127c-42c0-af2b-382a991c3691'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:f31d3282-a754-4512-89cc-db3981879549', 4, 'IV', 'Allegro giusto – Presto', 'IV. Allegro giusto – Presto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 29 AND p.title = '피아노 4중주 C단조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:f31d3282-a754-4512-89cc-db3981879549'
);

