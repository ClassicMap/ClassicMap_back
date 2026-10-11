-- 버르토크 작품을 출판 단위로 채운다(카탈로그: Sz.(BB)). 작품 98개(묶음 36, 다악장 46, 낱곡 16),
-- 새 작품 94개, 기존 작품 4개, part 433개, 그 아래 251개, 기존 낱곡 연결 0개.
--
-- 정한 것
--   기악으로 민요를 다룬 곡은 넣고 성악·합창 민요 편곡은 뺀다(반주를 새로 지은 연가곡은 넣는다).
--   330 <미크로코스모스>는 6권 아래 153곡. 331 「6개의 현악 4중주」는 그대로 두고 1~6번은 따로 넣는다.
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

-- Sz. 1 왈츠

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '왈츠', 'Waltz (Walzer)', 'song', 'Sz. 1', NULL, NULL, 1890, 'manual', 1
FROM composers c
WHERE c.id = 85
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '왈츠'
);


-- Sz. 2 마주르카

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '마주르카', 'Mazurka', 'song', 'Sz. 2', NULL, NULL, 1890, 'manual', 1
FROM composers c
WHERE c.id = 85
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '마주르카'
);


-- Sz. 4 <도나우강의 흐름>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '<도나우강의 흐름>', 'The Course of the Danube (A Duna folyása)', 'song', 'Sz. 4', NULL, NULL, 1891, 'manual', 1
FROM composers c
WHERE c.id = 85
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '<도나우강의 흐름>'
);


-- Sz. 8 스케르초 또는 환상곡

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '스케르초 또는 환상곡', 'Scherzo or Fantasy', 'song', 'Sz. 8', NULL, NULL, 1897, 'manual', 1
FROM composers c
WHERE c.id = 85
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '스케르초 또는 환상곡'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'f5c656fc-77ca-4847-bc24-240cbd1afec8'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'f5c656fc-77ca-4847-bc24-240cbd1afec8'
FROM pieces p
WHERE p.composer_id = 85 AND p.title = '스케르초 또는 환상곡' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'f5c656fc-77ca-4847-bc24-240cbd1afec8'
);


-- Sz. 9 피아노 4중주 C단조

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '피아노 4중주 C단조', 'Piano Quartet in C minor', 'album', 'Sz. 9', NULL, NULL, 1898, 'manual', 1
FROM composers c
WHERE c.id = 85
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '피아노 4중주 C단조'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'eaa11c80-700f-4488-b445-5daba5da3d31'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'eaa11c80-700f-4488-b445-5daba5da3d31'
FROM pieces p
WHERE p.composer_id = 85 AND p.title = '피아노 4중주 C단조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'eaa11c80-700f-4488-b445-5daba5da3d31'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:abdf11d8-33b2-411e-9656-6b7871181310', 1, 'I', 'Allegro', 'I. Allegro', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 85 AND p.title = '피아노 4중주 C단조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:abdf11d8-33b2-411e-9656-6b7871181310'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:e4d2bb9d-2479-496d-9a26-2ff4347d0acc', 2, 'II', '스케르초. Allegro molto', 'II. Scherzo. Allegro molto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 85 AND p.title = '피아노 4중주 C단조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:e4d2bb9d-2479-496d-9a26-2ff4347d0acc'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:edaea8f0-c814-4533-8ceb-5823803cfc6b', 3, 'III', 'Adagio espressivo', 'III. Adagio espressivo', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 85 AND p.title = '피아노 4중주 C단조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:edaea8f0-c814-4533-8ceb-5823803cfc6b'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:12776b8c-2027-4966-a262-fde170f8430c', 4, 'IV', '피날레. Allegro vivace', 'IV. Finale. Allegro vivace', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 85 AND p.title = '피아노 4중주 C단조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:12776b8c-2027-4966-a262-fde170f8430c'
);


-- Sz. 6 3개의 피아노 소품

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '3개의 피아노 소품', 'Three Piano Pieces', 'album', 'Sz. 6', NULL, NULL, 1898, 'manual', 1
FROM composers c
WHERE c.id = 85
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '3개의 피아노 소품'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'e5015d2a-449f-4b66-89f7-9fbc9817d6bb'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'e5015d2a-449f-4b66-89f7-9fbc9817d6bb'
FROM pieces p
WHERE p.composer_id = 85 AND p.title = '3개의 피아노 소품' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'e5015d2a-449f-4b66-89f7-9fbc9817d6bb'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:c654d810-2d55-4f84-9252-4e8d6022f9b1', 1, NULL, '간주곡', 'Intermezzo', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 85 AND p.title = '3개의 피아노 소품' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:c654d810-2d55-4f84-9252-4e8d6022f9b1'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:da0f675e-b81a-4940-a488-dc719fdf60f8', 2, NULL, 'Adagio', 'Adagio', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 85 AND p.title = '3개의 피아노 소품' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:da0f675e-b81a-4940-a488-dc719fdf60f8'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:b5df1c3f-bb31-4340-afce-ca9b27cb730c', 3, NULL, '스케르초', 'Scherzo', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 85 AND p.title = '3개의 피아노 소품' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:b5df1c3f-bb31-4340-afce-ca9b27cb730c'
);


-- Sz. 13 가곡집 <Liebeslieder>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '가곡집 <Liebeslieder>', 'Liebeslieder', 'album', 'Sz. 13', NULL, NULL, 1899, 'manual', 1
FROM composers c
WHERE c.id = 85
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '가곡집 <Liebeslieder>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'a1be05c7-67ae-45c0-9395-ed0b828f89c1'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'a1be05c7-67ae-45c0-9395-ed0b828f89c1'
FROM pieces p
WHERE p.composer_id = 85 AND p.title = '가곡집 <Liebeslieder>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'a1be05c7-67ae-45c0-9395-ed0b828f89c1'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:690db3dd-58c5-4ea6-b75f-64e85b5f5e74', 1, NULL, 'Du meine Liebe, du mein Herz', 'Du meine Liebe, du mein Herz', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 85 AND p.title = '가곡집 <Liebeslieder>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:690db3dd-58c5-4ea6-b75f-64e85b5f5e74'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:40ea8b7c-0cf2-4ac9-84df-44dfeaeb3555', 2, NULL, 'Diese Rose pflück ich hier', 'Diese Rose pflück ich hier', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 85 AND p.title = '가곡집 <Liebeslieder>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:40ea8b7c-0cf2-4ac9-84df-44dfeaeb3555'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:bee791ce-117c-4fe8-ad53-f73d907a10ab', 3, NULL, 'Du geleitest mich zum Grabe', 'Du geleitest mich zum Grabe', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 85 AND p.title = '가곡집 <Liebeslieder>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:bee791ce-117c-4fe8-ad53-f73d907a10ab'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:4d37ff19-2c53-4bc6-9c22-03e648365ac1', 4, NULL, 'Ich fühle deinen Odem', 'Ich fühle deinen Odem', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 85 AND p.title = '가곡집 <Liebeslieder>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:4d37ff19-2c53-4bc6-9c22-03e648365ac1'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:a0659e2e-e975-4658-ba70-3e603f6eb970', 5, NULL, 'Wie herrlich leuchtet', 'Wie herrlich leuchtet', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 85 AND p.title = '가곡집 <Liebeslieder>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:a0659e2e-e975-4658-ba70-3e603f6eb970'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:35bee7a5-c381-4fc1-9380-17ed85b547f8', 6, NULL, 'Herr! der du alles wohl gemacht', 'Herr! der du alles wohl gemacht', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 85 AND p.title = '가곡집 <Liebeslieder>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:35bee7a5-c381-4fc1-9380-17ed85b547f8'
);


-- Sz. 15 포사 러요시의 시에 의한 4개의 가곡

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '포사 러요시의 시에 의한 4개의 가곡', 'Four Songs on Texts by Lajos Pósa', 'album', 'Sz. 15', NULL, NULL, 1902, 'manual', 1
FROM composers c
WHERE c.id = 85
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '포사 러요시의 시에 의한 4개의 가곡'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '1674ce03-73fc-43e9-9956-406fc42382a6'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '1674ce03-73fc-43e9-9956-406fc42382a6'
FROM pieces p
WHERE p.composer_id = 85 AND p.title = '포사 러요시의 시에 의한 4개의 가곡' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '1674ce03-73fc-43e9-9956-406fc42382a6'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:26e74f1f-1cc1-43d5-9062-c22cd83e3083', 1, NULL, 'Őszi szellő', 'Őszi szellő', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 85 AND p.title = '포사 러요시의 시에 의한 4개의 가곡' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:26e74f1f-1cc1-43d5-9062-c22cd83e3083'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:b83d21f3-4252-4fdc-9c29-5c7b3af54ad3', 2, NULL, 'Még azt vetik a szememre', 'Még azt vetik a szememre', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 85 AND p.title = '포사 러요시의 시에 의한 4개의 가곡' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:b83d21f3-4252-4fdc-9c29-5c7b3af54ad3'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:720d3a5a-b97e-4db0-8348-481cd2ea0ffa', 3, NULL, 'Nincs olyan bú', 'Nincs olyan bú', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 85 AND p.title = '포사 러요시의 시에 의한 4개의 가곡' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:720d3a5a-b97e-4db0-8348-481cd2ea0ffa'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:0dacab0b-84b3-4c38-afd2-34238b1fbb33', 4, NULL, 'Ejnye, ejnye', 'Ejnye, ejnye', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 85 AND p.title = '포사 러요시의 시에 의한 4개의 가곡' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:0dacab0b-84b3-4c38-afd2-34238b1fbb33'
);


-- Sz. 16 교향곡 E♭장조 중 스케르초 C장조

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '교향곡 E♭장조 중 스케르초 C장조', 'Scherzo in C major from the Symphony in E♭ major', 'song', 'Sz. 16', NULL, NULL, 1903, 'manual', 1
FROM composers c
WHERE c.id = 85
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '교향곡 E♭장조 중 스케르초 C장조'
);


-- Sz. 19 남성 합창을 위한 <저녁>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '남성 합창을 위한 <저녁>', 'Evening (Est), for male chorus', 'song', 'Sz. 19', NULL, NULL, 1903, 'manual', 1
FROM composers c
WHERE c.id = 85
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '남성 합창을 위한 <저녁>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '652a268d-d488-4c91-bd7c-4968f41c667a'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '652a268d-d488-4c91-bd7c-4968f41c667a'
FROM pieces p
WHERE p.composer_id = 85 AND p.title = '남성 합창을 위한 <저녁>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '652a268d-d488-4c91-bd7c-4968f41c667a'
);


-- Sz. 20 바이올린 소나타 E단조

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '바이올린 소나타 E단조', 'Violin Sonata in E minor', 'album', 'Sz. 20', NULL, NULL, 1903, 'manual', 1
FROM composers c
WHERE c.id = 85
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '바이올린 소나타 E단조'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'c4be74a8-d860-4fec-aaa4-5f6f43b3f59a'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'c4be74a8-d860-4fec-aaa4-5f6f43b3f59a'
FROM pieces p
WHERE p.composer_id = 85 AND p.title = '바이올린 소나타 E단조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'c4be74a8-d860-4fec-aaa4-5f6f43b3f59a'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:2c5171df-6586-4440-8654-3bb76fd445ef', 1, 'I', 'Allegro moderato (molto rubato)', 'I. Allegro moderato (molto rubato)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 85 AND p.title = '바이올린 소나타 E단조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:2c5171df-6586-4440-8654-3bb76fd445ef'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:83382d4a-91c1-4c46-bce3-868c32257d24', 2, 'II', 'Andante', 'II. Andante', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 85 AND p.title = '바이올린 소나타 E단조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:83382d4a-91c1-4c46-bce3-868c32257d24'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:c7b85a16-8037-4249-a693-4ce072eeabc7', 3, 'III', 'Vivace', 'III. Vivace', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 85 AND p.title = '바이올린 소나타 E단조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:c7b85a16-8037-4249-a693-4ce072eeabc7'
);


-- Sz. 21 교향시 <코슈트>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '교향시 <코슈트>', 'Kossuth', 'song', 'Sz. 21', NULL, NULL, 1903, 'manual', 1
FROM composers c
WHERE c.id = 85
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '교향시 <코슈트>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'd9148c76-414d-4d0d-8b24-f45fabcf9f44'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'd9148c76-414d-4d0d-8b24-f45fabcf9f44'
FROM pieces p
WHERE p.composer_id = 85 AND p.title = '교향시 <코슈트>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'd9148c76-414d-4d0d-8b24-f45fabcf9f44'
);


-- Sz. 22 4개의 피아노 소품

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '4개의 피아노 소품', 'Four Piano Pieces', 'album', 'Sz. 22', NULL, NULL, 1903, 'manual', 1
FROM composers c
WHERE c.id = 85
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '4개의 피아노 소품'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '55dd09e4-0fa4-46ec-b8e6-c9efba946527'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '55dd09e4-0fa4-46ec-b8e6-c9efba946527'
FROM pieces p
WHERE p.composer_id = 85 AND p.title = '4개의 피아노 소품' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '55dd09e4-0fa4-46ec-b8e6-c9efba946527'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:20d33728-4f30-41c8-bde6-d9548ab72f54', 1, NULL, '왼손을 위한 연습곡', 'Study for the Left Hand', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 85 AND p.title = '4개의 피아노 소품' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:20d33728-4f30-41c8-bde6-d9548ab72f54'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:2bc66eff-703a-469c-b2a6-aaff7ed71531', 2, NULL, '환상곡 1번', 'Fantasy No. 1', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 85 AND p.title = '4개의 피아노 소품' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:2bc66eff-703a-469c-b2a6-aaff7ed71531'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:fc1e8df0-a6d2-4580-83d8-29ee381c6532', 3, NULL, '환상곡 2번', 'Fantasy No. 2', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 85 AND p.title = '4개의 피아노 소품' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:fc1e8df0-a6d2-4580-83d8-29ee381c6532'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:b3578b0b-eabe-4ca8-be17-145bea4e8924', 4, NULL, '스케르초', 'Scherzo', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 85 AND p.title = '4개의 피아노 소품' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:b3578b0b-eabe-4ca8-be17-145bea4e8924'
);


-- Sz. 23 피아노 5중주 C장조

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '피아노 5중주 C장조', 'Piano Quintet in C major', 'album', 'Sz. 23', NULL, NULL, 1904, 'manual', 1
FROM composers c
WHERE c.id = 85
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '피아노 5중주 C장조'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '5a4428a2-494d-4eb9-bbb7-ea54772e3214'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '5a4428a2-494d-4eb9-bbb7-ea54772e3214'
FROM pieces p
WHERE p.composer_id = 85 AND p.title = '피아노 5중주 C장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '5a4428a2-494d-4eb9-bbb7-ea54772e3214'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:1e340408-4f79-4c3c-aeb5-1a67adc7e2c6', 1, 'I', 'Andante', 'I. Andante', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 85 AND p.title = '피아노 5중주 C장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:1e340408-4f79-4c3c-aeb5-1a67adc7e2c6'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:f530390a-dc51-440e-aa06-81b5281a2983', 2, 'II', 'Vivace (scherzando)', 'II. Vivace (scherzando)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 85 AND p.title = '피아노 5중주 C장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:f530390a-dc51-440e-aa06-81b5281a2983'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:8ad949aa-385d-4663-a94b-cb0ebcd3ed3c', 3, 'III', 'Adagio', 'III. Adagio', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 85 AND p.title = '피아노 5중주 C장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:8ad949aa-385d-4663-a94b-cb0ebcd3ed3c'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:2756152b-cb48-44df-8ca9-8a7eef1389ef', 4, 'IV', 'Poco a poco più vivace', 'IV. Poco a poco più vivace', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 85 AND p.title = '피아노 5중주 C장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:2756152b-cb48-44df-8ca9-8a7eef1389ef'
);


-- Sz. 26 피아노를 위한 랩소디

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '피아노를 위한 랩소디', 'Rhapsody for Piano, Op. 1', 'album', 'Sz. 26', NULL, NULL, 1904, 'manual', 1
FROM composers c
WHERE c.id = 85
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '피아노를 위한 랩소디'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '46675b31-f2d8-4cdb-b962-a6dce72f5a55'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '46675b31-f2d8-4cdb-b962-a6dce72f5a55'
FROM pieces p
WHERE p.composer_id = 85 AND p.title = '피아노를 위한 랩소디' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '46675b31-f2d8-4cdb-b962-a6dce72f5a55'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:f1aadb0f-d7ef-4625-b799-112636b5d99c', 1, 'I', 'Adagio molto', 'I. Adagio molto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 85 AND p.title = '피아노를 위한 랩소디' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:f1aadb0f-d7ef-4625-b799-112636b5d99c'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:f26c253d-830b-4219-8fd1-1a919ed8f18b', 2, 'II', 'Poco allegretto', 'II. Poco allegretto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 85 AND p.title = '피아노를 위한 랩소디' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:f26c253d-830b-4219-8fd1-1a919ed8f18b'
);


-- Sz. 27 피아노와 관현악을 위한 랩소디

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '피아노와 관현악을 위한 랩소디', 'Rhapsody for Piano and Orchestra, Op. 1', 'album', 'Sz. 27', NULL, NULL, 1905, 'manual', 1
FROM composers c
WHERE c.id = 85
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '피아노와 관현악을 위한 랩소디'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'bc6ab69e-9bb9-4121-977f-91b2a7bf2b06'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'bc6ab69e-9bb9-4121-977f-91b2a7bf2b06'
FROM pieces p
WHERE p.composer_id = 85 AND p.title = '피아노와 관현악을 위한 랩소디' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'bc6ab69e-9bb9-4121-977f-91b2a7bf2b06'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:5855bdf7-7884-48aa-be35-95ee860ba1e6', 1, 'I', 'Adagio molto', 'I. Adagio molto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 85 AND p.title = '피아노와 관현악을 위한 랩소디' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:5855bdf7-7884-48aa-be35-95ee860ba1e6'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:ead08ce3-90f4-4e10-8140-d399f59c49a7', 2, 'II', 'Poco allegretto', 'II. Poco allegretto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 85 AND p.title = '피아노와 관현악을 위한 랩소디' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:ead08ce3-90f4-4e10-8140-d399f59c49a7'
);


-- Sz. 28 피아노와 관현악을 위한 스케르초

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '피아노와 관현악을 위한 스케르초', 'Scherzo (Burlesque) for Piano and Orchestra, Op. 2', 'album', 'Sz. 28', NULL, NULL, 1904, 'manual', 1
FROM composers c
WHERE c.id = 85
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '피아노와 관현악을 위한 스케르초'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '39ce6839-7b16-4eb9-be66-056054cc1311'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '39ce6839-7b16-4eb9-be66-056054cc1311'
FROM pieces p
WHERE p.composer_id = 85 AND p.title = '피아노와 관현악을 위한 스케르초' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '39ce6839-7b16-4eb9-be66-056054cc1311'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:afd364b6-d1f6-4a0e-9b0b-ec6cf1337129', 1, 'I', 'Adagio ma non troppo', 'I. Adagio ma non troppo', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 85 AND p.title = '피아노와 관현악을 위한 스케르초' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:afd364b6-d1f6-4a0e-9b0b-ec6cf1337129'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:a386aa2a-32a7-463b-9701-6981e12e7a74', 2, 'II', '스케르초. Allegro', 'II. Scherzo. Allegro', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 85 AND p.title = '피아노와 관현악을 위한 스케르초' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:a386aa2a-32a7-463b-9701-6981e12e7a74'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:8974edd4-a070-46b4-ac5e-25ff355c1d07', 3, 'III', '트리오. Andante', 'III. Trio. Andante', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 85 AND p.title = '피아노와 관현악을 위한 스케르초' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:8974edd4-a070-46b4-ac5e-25ff355c1d07'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:4bb8d69a-06f5-4fa1-b263-e4541bb8064e', 4, 'IV', '스케르초 다 카포', 'IV. Scherzo da capo', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 85 AND p.title = '피아노와 관현악을 위한 스케르초' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:4bb8d69a-06f5-4fa1-b263-e4541bb8064e'
);


-- Sz. 31 관현악 모음곡 1번

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '관현악 모음곡 1번', 'Suite No. 1 for Orchestra, Op. 3', 'album', 'Sz. 31', NULL, NULL, 1905, 'manual', 1
FROM composers c
WHERE c.id = 85
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '관현악 모음곡 1번'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '2e1ec0e9-73a2-475f-8f3a-cc133a821597'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '2e1ec0e9-73a2-475f-8f3a-cc133a821597'
FROM pieces p
WHERE p.composer_id = 85 AND p.title = '관현악 모음곡 1번' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '2e1ec0e9-73a2-475f-8f3a-cc133a821597'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:76aa01c9-6fbc-4fec-8cb8-1645feffbcb3', 1, 'I', 'Allegro vivace', 'I. Allegro vivace', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 85 AND p.title = '관현악 모음곡 1번' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:76aa01c9-6fbc-4fec-8cb8-1645feffbcb3'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:bc74e08c-5251-4acb-9440-b1a2e8a245f1', 2, 'II', 'Poco adagio', 'II. Poco adagio', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 85 AND p.title = '관현악 모음곡 1번' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:bc74e08c-5251-4acb-9440-b1a2e8a245f1'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:61763270-d91e-4d46-9e51-7e889379cbea', 3, 'III', 'Presto', 'III. Presto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 85 AND p.title = '관현악 모음곡 1번' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:61763270-d91e-4d46-9e51-7e889379cbea'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:ba592bc4-cada-425c-9c36-3ee5e9d2bccd', 4, 'IV', 'Moderato', 'IV. Moderato', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 85 AND p.title = '관현악 모음곡 1번' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:ba592bc4-cada-425c-9c36-3ee5e9d2bccd'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:3caa083a-a2e7-4c90-a566-6069d2cfacee', 5, 'V', 'Molto vivace', 'V. Molto vivace', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 85 AND p.title = '관현악 모음곡 1번' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:3caa083a-a2e7-4c90-a566-6069d2cfacee'
);


-- Sz. 34 관현악 모음곡 2번

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '관현악 모음곡 2번', 'Suite No. 2 for Small Orchestra, Op. 4', 'album', 'Sz. 34', NULL, NULL, 1907, 'manual', 1
FROM composers c
WHERE c.id = 85
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '관현악 모음곡 2번'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'e87f3360-e198-4b99-8809-c1319ba86721'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'e87f3360-e198-4b99-8809-c1319ba86721'
FROM pieces p
WHERE p.composer_id = 85 AND p.title = '관현악 모음곡 2번' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'e87f3360-e198-4b99-8809-c1319ba86721'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:fee1b5a0-abe2-40fb-b9a7-687ec710a42c', 1, 'I', 'Comodo', 'I. Comodo', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 85 AND p.title = '관현악 모음곡 2번' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:fee1b5a0-abe2-40fb-b9a7-687ec710a42c'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:786800a7-808d-475d-84f1-a20fe28f8d01', 2, 'II', 'Allegro scherzando', 'II. Allegro scherzando', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 85 AND p.title = '관현악 모음곡 2번' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:786800a7-808d-475d-84f1-a20fe28f8d01'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:c72ad76a-e6c2-4e9e-9d27-f801dbf70647', 3, 'III', 'Andante', 'III. Andante', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 85 AND p.title = '관현악 모음곡 2번' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:c72ad76a-e6c2-4e9e-9d27-f801dbf70647'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:53f3efa4-b9cc-4240-976a-f799e5a8b665', 4, 'IV', 'Comodo', 'IV. Comodo', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 85 AND p.title = '관현악 모음곡 2번' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:53f3efa4-b9cc-4240-976a-f799e5a8b665'
);


-- Sz. 35a 치크 지방의 3개의 헝가리 민요

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '치크 지방의 3개의 헝가리 민요', 'Three Hungarian Folksongs from Csík', 'album', 'Sz. 35a', NULL, NULL, 1907, 'manual', 1
FROM composers c
WHERE c.id = 85
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '치크 지방의 3개의 헝가리 민요'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '35e95ef9-2243-4869-a677-17188bdb7d91'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '35e95ef9-2243-4869-a677-17188bdb7d91'
FROM pieces p
WHERE p.composer_id = 85 AND p.title = '치크 지방의 3개의 헝가리 민요' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '35e95ef9-2243-4869-a677-17188bdb7d91'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:08302715-deb9-442f-88a8-a30e27a6cf0e', 1, NULL, 'Rubato', 'Rubato', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 85 AND p.title = '치크 지방의 3개의 헝가리 민요' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:08302715-deb9-442f-88a8-a30e27a6cf0e'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:8ebbdcb7-b856-4f1a-8d83-f87e6758bf4d', 2, NULL, 'L''istesso tempo', 'L''istesso tempo', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 85 AND p.title = '치크 지방의 3개의 헝가리 민요' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:8ebbdcb7-b856-4f1a-8d83-f87e6758bf4d'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:ce4ac1e2-e833-4cfc-93cb-b9a23805393c', 3, NULL, 'Poco vivo', 'Poco vivo', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 85 AND p.title = '치크 지방의 3개의 헝가리 민요' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:ce4ac1e2-e833-4cfc-93cb-b9a23805393c'
);


-- Sz. 36 바이올린 협주곡 1번

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '바이올린 협주곡 1번', 'Violin Concerto No. 1', 'album', 'Sz. 36', NULL, NULL, 1908, 'manual', 1
FROM composers c
WHERE c.id = 85
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '바이올린 협주곡 1번'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '5216f1f1-b33d-443f-a65b-0552f139462e'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '5216f1f1-b33d-443f-a65b-0552f139462e'
FROM pieces p
WHERE p.composer_id = 85 AND p.title = '바이올린 협주곡 1번' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '5216f1f1-b33d-443f-a65b-0552f139462e'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:f5238770-a750-34dc-b4c9-0414de5909ed', 1, 'I', 'Andante sostenuto', 'I. Andante sostenuto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 85 AND p.title = '바이올린 협주곡 1번' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:f5238770-a750-34dc-b4c9-0414de5909ed'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:5283a29b-0b0c-35e6-ab15-7ce17c19510e', 2, 'II', 'Allegro giocoso', 'II. Allegro giocoso', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 85 AND p.title = '바이올린 협주곡 1번' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:5283a29b-0b0c-35e6-ab15-7ce17c19510e'
);


-- Sz. 37 2개의 초상

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '2개의 초상', 'Two Portraits, Op. 5', 'album', 'Sz. 37', NULL, NULL, 1911, 'manual', 1
FROM composers c
WHERE c.id = 85
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '2개의 초상'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'ba92f430-4960-4ce5-bde3-963361fd6e7b'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'ba92f430-4960-4ce5-bde3-963361fd6e7b'
FROM pieces p
WHERE p.composer_id = 85 AND p.title = '2개의 초상' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'ba92f430-4960-4ce5-bde3-963361fd6e7b'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:efefc195-3ac5-4536-9728-82547c7f30b1', 1, 'I', 'One Ideal. Andante', 'I. One Ideal. Andante', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 85 AND p.title = '2개의 초상' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:efefc195-3ac5-4536-9728-82547c7f30b1'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:8e2ff0b2-e031-4524-b7fe-6ef0c1fdeda0', 2, 'II', 'One Grotesque. Presto', 'II. One Grotesque. Presto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 85 AND p.title = '2개의 초상' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:8e2ff0b2-e031-4524-b7fe-6ef0c1fdeda0'
);


-- Sz. 38 14개의 바가텔

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '14개의 바가텔', '14 Bagatelles, Op. 6', 'album', 'Sz. 38', NULL, NULL, 1908, 'manual', 1
FROM composers c
WHERE c.id = 85
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '14개의 바가텔'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '38dfe04b-4f04-4c38-898f-3d461bb30ee3'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '38dfe04b-4f04-4c38-898f-3d461bb30ee3'
FROM pieces p
WHERE p.composer_id = 85 AND p.title = '14개의 바가텔' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '38dfe04b-4f04-4c38-898f-3d461bb30ee3'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:e3e60eff-1475-49ec-97bd-08ab7f55d263', 1, NULL, 'Molto sostenuto', 'Molto sostenuto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 85 AND p.title = '14개의 바가텔' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:e3e60eff-1475-49ec-97bd-08ab7f55d263'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:e2c74747-5995-4752-8061-08e5ea99e955', 2, NULL, 'Allegro giocoso', 'Allegro giocoso', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 85 AND p.title = '14개의 바가텔' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:e2c74747-5995-4752-8061-08e5ea99e955'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:031a5d93-f033-4e3b-b50d-2f096c5523a5', 3, NULL, 'Andante', 'Andante', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 85 AND p.title = '14개의 바가텔' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:031a5d93-f033-4e3b-b50d-2f096c5523a5'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:69f2fbfd-62fe-432e-b6f8-c2a30bf1d6a0', 4, NULL, 'Grave', 'Grave', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 85 AND p.title = '14개의 바가텔' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:69f2fbfd-62fe-432e-b6f8-c2a30bf1d6a0'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:4a727938-a61c-4eca-9e61-775190e8a766', 5, NULL, 'Vivo', 'Vivo', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 85 AND p.title = '14개의 바가텔' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:4a727938-a61c-4eca-9e61-775190e8a766'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:55ad7048-ae97-4bc0-a655-fd81154d4d6d', 6, NULL, 'Lento', 'Lento', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 85 AND p.title = '14개의 바가텔' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:55ad7048-ae97-4bc0-a655-fd81154d4d6d'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:64e94c22-6e82-495d-a823-b3945d577826', 7, NULL, 'Allegretto molto capriccioso', 'Allegretto molto capriccioso', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 85 AND p.title = '14개의 바가텔' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:64e94c22-6e82-495d-a823-b3945d577826'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:84ca6184-bd4f-406b-882f-54b7c309472d', 8, NULL, 'Andante sostenuto', 'Andante sostenuto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 85 AND p.title = '14개의 바가텔' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:84ca6184-bd4f-406b-882f-54b7c309472d'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:85743cb3-adc3-44ee-856a-7295e05dd8d5', 9, NULL, 'Allegretto grazioso', 'Allegretto grazioso', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 85 AND p.title = '14개의 바가텔' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:85743cb3-adc3-44ee-856a-7295e05dd8d5'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:5040f836-b900-3fad-8cea-d620c42b271c', 10, NULL, 'Allegro', 'Allegro', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 85 AND p.title = '14개의 바가텔' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:5040f836-b900-3fad-8cea-d620c42b271c'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:cd0cc047-a871-41aa-aa06-0493b04eb274', 11, NULL, 'Allegretto molto rubato', 'Allegretto molto rubato', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 85 AND p.title = '14개의 바가텔' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:cd0cc047-a871-41aa-aa06-0493b04eb274'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:f83264cb-e551-4947-b187-162e07d0b6bd', 12, NULL, 'Rubato', 'Rubato', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 85 AND p.title = '14개의 바가텔' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:f83264cb-e551-4947-b187-162e07d0b6bd'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:671a26da-2cbc-4948-bf69-a7f67d15c93c', 13, NULL, 'Elle est morte… Lento funebre', 'Elle est morte… Lento funebre', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 85 AND p.title = '14개의 바가텔' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:671a26da-2cbc-4948-bf69-a7f67d15c93c'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:6b5f9d12-4e91-4539-bb44-ec2cea59ed97', 14, NULL, '왈츠 "Ma mie qui danse…". Presto', 'Valse (Ma mie qui danse…). Presto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 85 AND p.title = '14개의 바가텔' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:6b5f9d12-4e91-4539-bb44-ec2cea59ed97'
);


-- Sz. 39 10개의 쉬운 피아노 소품

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '10개의 쉬운 피아노 소품', 'Ten Easy Pieces', 'album', 'Sz. 39', NULL, NULL, 1908, 'manual', 1
FROM composers c
WHERE c.id = 85
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '10개의 쉬운 피아노 소품'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'b2e27ef1-98ad-45a8-be2f-3ec14c6e8382'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'b2e27ef1-98ad-45a8-be2f-3ec14c6e8382'
FROM pieces p
WHERE p.composer_id = 85 AND p.title = '10개의 쉬운 피아노 소품' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'b2e27ef1-98ad-45a8-be2f-3ec14c6e8382'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:a4b124a0-3717-32c0-9f9c-40f1045687a8', 1, NULL, '헌정', 'Dedication', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 85 AND p.title = '10개의 쉬운 피아노 소품' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:a4b124a0-3717-32c0-9f9c-40f1045687a8'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:614c1744-4dd4-3888-898f-c7db724e1a03', 2, NULL, 'Peasant Song', 'Peasant Song', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 85 AND p.title = '10개의 쉬운 피아노 소품' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:614c1744-4dd4-3888-898f-c7db724e1a03'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:b7baa13e-a2dc-369c-ba8e-726ddbb2f5fe', 3, NULL, 'Painful Wrestling', 'Painful Wrestling', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 85 AND p.title = '10개의 쉬운 피아노 소품' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:b7baa13e-a2dc-369c-ba8e-726ddbb2f5fe'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:10246703-7612-3f09-87a1-4e1d15371c91', 4, NULL, 'Slovakian Boys'' Dance', 'Slovakian Boys'' Dance', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 85 AND p.title = '10개의 쉬운 피아노 소품' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:10246703-7612-3f09-87a1-4e1d15371c91'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:d623cf2c-d96d-31ba-9293-8894f464bb49', 5, NULL, 'Sostenuto', 'Sostenuto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 85 AND p.title = '10개의 쉬운 피아노 소품' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:d623cf2c-d96d-31ba-9293-8894f464bb49'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:9450f106-d665-352d-ae1e-b257968c1a64', 6, NULL, 'An Evening in the Village', 'An Evening in the Village', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 85 AND p.title = '10개의 쉬운 피아노 소품' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:9450f106-d665-352d-ae1e-b257968c1a64'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:71fb90da-209d-3f33-b179-bd4468271b32', 7, NULL, 'Hungarian Folksong', 'Hungarian Folksong', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 85 AND p.title = '10개의 쉬운 피아노 소품' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:71fb90da-209d-3f33-b179-bd4468271b32'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:83b43c8f-ce5e-3bfb-9203-872e78865d07', 8, NULL, 'Dawn', 'Dawn', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 85 AND p.title = '10개의 쉬운 피아노 소품' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:83b43c8f-ce5e-3bfb-9203-872e78865d07'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:8fc7ee5a-4b28-389b-acc1-899faee96865', 9, NULL, 'Slovakian Folksong', 'Slovakian Folksong', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 85 AND p.title = '10개의 쉬운 피아노 소품' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:8fc7ee5a-4b28-389b-acc1-899faee96865'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:fbfd98d9-f7f3-39a4-b8b1-2fe2b5ac0b83', 10, NULL, 'Five-Finger Exercise', 'Five-Finger Exercise', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 85 AND p.title = '10개의 쉬운 피아노 소품' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:fbfd98d9-f7f3-39a4-b8b1-2fe2b5ac0b83'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:720d5857-3462-325d-b3e2-39cf01864e2a', 11, NULL, 'Bear Dance', 'Bear Dance', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 85 AND p.title = '10개의 쉬운 피아노 소품' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:720d5857-3462-325d-b3e2-39cf01864e2a'
);


-- Sz. 40 현악 4중주 1번

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '현악 4중주 1번', 'String Quartet No. 1, Op. 7', 'album', 'Sz. 40', NULL, NULL, 1909, 'manual', 1
FROM composers c
WHERE c.id = 85
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '현악 4중주 1번'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '1c308f40-f474-40fa-96b1-f80f55ec9fc2'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '1c308f40-f474-40fa-96b1-f80f55ec9fc2'
FROM pieces p
WHERE p.composer_id = 85 AND p.title = '현악 4중주 1번' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '1c308f40-f474-40fa-96b1-f80f55ec9fc2'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:70f619c1-d9a5-3faa-b972-0e86f5582c6f', 1, 'I', 'Lento', 'I. Lento', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 85 AND p.title = '현악 4중주 1번' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:70f619c1-d9a5-3faa-b972-0e86f5582c6f'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:29db24f9-8ee9-3072-b7f1-5153f85c0585', 2, 'II', 'Allegretto', 'II. Allegretto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 85 AND p.title = '현악 4중주 1번' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:29db24f9-8ee9-3072-b7f1-5153f85c0585'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:4cc1937b-51c5-3576-919b-899e449a8258', 3, 'III', '서주. Allegro – Allegro vivace', 'III. Introduzione. Allegro – Allegro vivace', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 85 AND p.title = '현악 4중주 1번' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:4cc1937b-51c5-3576-919b-899e449a8258'
);


-- Sz. 41 2개의 엘레지

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '2개의 엘레지', 'Two Elegies, Op. 8b', 'album', 'Sz. 41', NULL, NULL, 1909, 'manual', 1
FROM composers c
WHERE c.id = 85
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '2개의 엘레지'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'a7ba51d3-70c2-406a-a479-2106f59dd4ab'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'a7ba51d3-70c2-406a-a479-2106f59dd4ab'
FROM pieces p
WHERE p.composer_id = 85 AND p.title = '2개의 엘레지' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'a7ba51d3-70c2-406a-a479-2106f59dd4ab'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:18468006-c6ce-4eec-96b2-c1aa86f66dec', 1, NULL, 'Grave', 'Grave', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 85 AND p.title = '2개의 엘레지' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:18468006-c6ce-4eec-96b2-c1aa86f66dec'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:e2608dbd-062f-4b74-a41f-0eba3bb50ba3', 2, NULL, 'Molto adagio, sempre rubato', 'Molto adagio, sempre rubato', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 85 AND p.title = '2개의 엘레지' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:e2608dbd-062f-4b74-a41f-0eba3bb50ba3'
);


-- Sz. 42 피아노 모음곡 <어린이를 위하여>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '피아노 모음곡 <어린이를 위하여>', 'For Children', 'album', 'Sz. 42', NULL, NULL, 1909, 'manual', 1
FROM composers c
WHERE c.id = 85
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '피아노 모음곡 <어린이를 위하여>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '8402f95e-8258-4d2b-b5a1-b0c6eec901d4'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '8402f95e-8258-4d2b-b5a1-b0c6eec901d4'
FROM pieces p
WHERE p.composer_id = 85 AND p.title = '피아노 모음곡 <어린이를 위하여>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '8402f95e-8258-4d2b-b5a1-b0c6eec901d4'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'classicmap:bartok:bartok-sz42:1', 1, NULL, '1권 (헝가리 민요)', 'Volume I (Hungarian Folk Tunes)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 85 AND p.title = '피아노 모음곡 <어린이를 위하여>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'classicmap:bartok:bartok-sz42:1'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:a739caf9-492c-499b-bac5-594eb208c08b', 1, NULL, 'Children at Play. Allegro', 'No. 1. Children at Play. Allegro', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'classicmap:bartok:bartok-sz42:1'
WHERE p.composer_id = 85 AND p.title = '피아노 모음곡 <어린이를 위하여>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:a739caf9-492c-499b-bac5-594eb208c08b'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:65bf7301-988b-4ed2-8d08-bc446f0510bd', 2, NULL, 'Children''s Song. Andante', 'No. 2. Children''s Song. Andante', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'classicmap:bartok:bartok-sz42:1'
WHERE p.composer_id = 85 AND p.title = '피아노 모음곡 <어린이를 위하여>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:65bf7301-988b-4ed2-8d08-bc446f0510bd'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:96b59a99-2cb6-4078-85c2-486f2fde1dd5', 3, NULL, 'Quasi adagio', 'No. 3. Quasi adagio', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'classicmap:bartok:bartok-sz42:1'
WHERE p.composer_id = 85 AND p.title = '피아노 모음곡 <어린이를 위하여>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:96b59a99-2cb6-4078-85c2-486f2fde1dd5'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:a0e0c36c-7db3-41e9-9e53-eeda95d7b33a', 4, NULL, 'Pillow Dance. Adagio', 'No. 4. Pillow Dance. Adagio', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'classicmap:bartok:bartok-sz42:1'
WHERE p.composer_id = 85 AND p.title = '피아노 모음곡 <어린이를 위하여>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:a0e0c36c-7db3-41e9-9e53-eeda95d7b33a'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:a7e3be4a-e479-4836-9ffe-740a8b27e868', 5, NULL, 'Play. Allegretto – Più Mosso – Tempo I', 'No. 5. Play. Allegretto – Più Mosso – Tempo I', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'classicmap:bartok:bartok-sz42:1'
WHERE p.composer_id = 85 AND p.title = '피아노 모음곡 <어린이를 위하여>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:a7e3be4a-e479-4836-9ffe-740a8b27e868'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:21920c07-b042-4289-820d-7c383d505c6e', 6, NULL, 'Study for the Left Hand. Allegro', 'No. 6. Study for the Left Hand. Allegro', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'classicmap:bartok:bartok-sz42:1'
WHERE p.composer_id = 85 AND p.title = '피아노 모음곡 <어린이를 위하여>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:21920c07-b042-4289-820d-7c383d505c6e'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:2d3f5e65-69ba-435e-9120-496d6cb9de46', 7, NULL, 'Play Song. Andante grazioso', 'No. 7. Play Song. Andante grazioso', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'classicmap:bartok:bartok-sz42:1'
WHERE p.composer_id = 85 AND p.title = '피아노 모음곡 <어린이를 위하여>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:2d3f5e65-69ba-435e-9120-496d6cb9de46'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:84101744-4ac7-48b5-919e-d0abe880cc4a', 8, NULL, 'Children''s Game. Allegretto', 'No. 8. Children''s Game. Allegretto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'classicmap:bartok:bartok-sz42:1'
WHERE p.composer_id = 85 AND p.title = '피아노 모음곡 <어린이를 위하여>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:84101744-4ac7-48b5-919e-d0abe880cc4a'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:1ed152f7-91a5-4889-81fd-161eaf828558', 9, NULL, 'Song. Adagio', 'No. 9. Song. Adagio', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'classicmap:bartok:bartok-sz42:1'
WHERE p.composer_id = 85 AND p.title = '피아노 모음곡 <어린이를 위하여>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:1ed152f7-91a5-4889-81fd-161eaf828558'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:aadc69fb-f44a-41e4-96d8-43cda0710f2d', 10, NULL, 'Children''s Dance. Allegro molto', 'No. 10. Children''s Dance. Allegro molto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'classicmap:bartok:bartok-sz42:1'
WHERE p.composer_id = 85 AND p.title = '피아노 모음곡 <어린이를 위하여>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:aadc69fb-f44a-41e4-96d8-43cda0710f2d'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:57c31a41-2b4d-4542-aa8d-3ae43d5eaf40', 11, NULL, 'Lento', 'No. 11. Lento', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'classicmap:bartok:bartok-sz42:1'
WHERE p.composer_id = 85 AND p.title = '피아노 모음곡 <어린이를 위하여>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:57c31a41-2b4d-4542-aa8d-3ae43d5eaf40'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:6a71aa33-cbf7-4b14-a440-9c80d6d20d0b', 12, NULL, 'Allegro', 'No. 12. Allegro', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'classicmap:bartok:bartok-sz42:1'
WHERE p.composer_id = 85 AND p.title = '피아노 모음곡 <어린이를 위하여>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:6a71aa33-cbf7-4b14-a440-9c80d6d20d0b'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:73ae6d5f-012b-4090-bf75-9c3cf7ec1bbe', 13, NULL, 'Ballad. Andante', 'No. 13. Ballad. Andante', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'classicmap:bartok:bartok-sz42:1'
WHERE p.composer_id = 85 AND p.title = '피아노 모음곡 <어린이를 위하여>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:73ae6d5f-012b-4090-bf75-9c3cf7ec1bbe'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:7bce56c2-bb8e-46dc-aa23-22dae32b12e3', 14, NULL, 'Allegretto', 'No. 14. Allegretto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'classicmap:bartok:bartok-sz42:1'
WHERE p.composer_id = 85 AND p.title = '피아노 모음곡 <어린이를 위하여>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:7bce56c2-bb8e-46dc-aa23-22dae32b12e3'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:abccb9ef-a7ee-4551-8bce-a3452295722f', 15, NULL, 'Allegro moderato', 'No. 15. Allegro moderato', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'classicmap:bartok:bartok-sz42:1'
WHERE p.composer_id = 85 AND p.title = '피아노 모음곡 <어린이를 위하여>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:abccb9ef-a7ee-4551-8bce-a3452295722f'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:69f150ff-1a00-4e38-a1f5-6a8800467c2c', 16, NULL, 'Old Hungarian Tune. Andante rubato', 'No. 16. Old Hungarian Tune. Andante rubato', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'classicmap:bartok:bartok-sz42:1'
WHERE p.composer_id = 85 AND p.title = '피아노 모음곡 <어린이를 위하여>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:69f150ff-1a00-4e38-a1f5-6a8800467c2c'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:b3068edd-331e-47fc-97b8-2f2304635939', 17, NULL, 'Round Dance. Lento', 'No. 17. Round Dance. Lento', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'classicmap:bartok:bartok-sz42:1'
WHERE p.composer_id = 85 AND p.title = '피아노 모음곡 <어린이를 위하여>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:b3068edd-331e-47fc-97b8-2f2304635939'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:aff9dbaf-786a-4e6e-85df-21eafdf9d247', 18, NULL, 'Soldier''s Song. Andante non troppo', 'No. 18. Soldier''s Song. Andante non troppo', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'classicmap:bartok:bartok-sz42:1'
WHERE p.composer_id = 85 AND p.title = '피아노 모음곡 <어린이를 위하여>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:aff9dbaf-786a-4e6e-85df-21eafdf9d247'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:051b5581-d6d5-4b95-974c-a885e13d33e8', 19, NULL, 'Allegretto', 'No. 19. Allegretto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'classicmap:bartok:bartok-sz42:1'
WHERE p.composer_id = 85 AND p.title = '피아노 모음곡 <어린이를 위하여>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:051b5581-d6d5-4b95-974c-a885e13d33e8'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:0b0ef6a6-6c74-417a-87e3-1ae39819d082', 20, NULL, 'Drinking Song. Allegro', 'No. 20. Drinking Song. Allegro', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'classicmap:bartok:bartok-sz42:1'
WHERE p.composer_id = 85 AND p.title = '피아노 모음곡 <어린이를 위하여>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:0b0ef6a6-6c74-417a-87e3-1ae39819d082'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:581013c4-e6dd-4a2a-b811-3725deb3cc54', 21, NULL, 'Allegro robusto', 'No. 21. Allegro robusto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'classicmap:bartok:bartok-sz42:1'
WHERE p.composer_id = 85 AND p.title = '피아노 모음곡 <어린이를 위하여>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:581013c4-e6dd-4a2a-b811-3725deb3cc54'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:7b1f0a55-d7c1-4f0a-b23a-7608081ad208', 22, NULL, 'Allegretto', 'No. 22. Allegretto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'classicmap:bartok:bartok-sz42:1'
WHERE p.composer_id = 85 AND p.title = '피아노 모음곡 <어린이를 위하여>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:7b1f0a55-d7c1-4f0a-b23a-7608081ad208'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:2a36cb3b-2aba-45e9-bf67-950eddef8acb', 23, NULL, 'Dance Song. Allegro giocoso', 'No. 23. Dance Song. Allegro giocoso', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'classicmap:bartok:bartok-sz42:1'
WHERE p.composer_id = 85 AND p.title = '피아노 모음곡 <어린이를 위하여>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:2a36cb3b-2aba-45e9-bf67-950eddef8acb'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:867ff8b0-4b12-40c3-84a5-4c3f9264447c', 24, NULL, 'Andante sostenuto', 'No. 24. Andante sostenuto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'classicmap:bartok:bartok-sz42:1'
WHERE p.composer_id = 85 AND p.title = '피아노 모음곡 <어린이를 위하여>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:867ff8b0-4b12-40c3-84a5-4c3f9264447c'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:d320f9e7-a8b0-4fc5-9373-77caeaccf2af', 25, NULL, 'Parlando', 'No. 25. Parlando', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'classicmap:bartok:bartok-sz42:1'
WHERE p.composer_id = 85 AND p.title = '피아노 모음곡 <어린이를 위하여>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:d320f9e7-a8b0-4fc5-9373-77caeaccf2af'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:32ba5fbb-da9f-47f2-83fa-fe44e9066b8f', 26, NULL, 'Moderato', 'No. 26. Moderato', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'classicmap:bartok:bartok-sz42:1'
WHERE p.composer_id = 85 AND p.title = '피아노 모음곡 <어린이를 위하여>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:32ba5fbb-da9f-47f2-83fa-fe44e9066b8f'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:4cc88e67-fde4-4dc5-b7ea-084b7fbf23ea', 27, NULL, 'Jest. Allegramente', 'No. 27. Jest. Allegramente', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'classicmap:bartok:bartok-sz42:1'
WHERE p.composer_id = 85 AND p.title = '피아노 모음곡 <어린이를 위하여>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:4cc88e67-fde4-4dc5-b7ea-084b7fbf23ea'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:3fa9bb39-f6b0-4b0c-930a-ac0a51c0885b', 28, NULL, 'Chorale. Andante', 'No. 28. Chorale. Andante', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'classicmap:bartok:bartok-sz42:1'
WHERE p.composer_id = 85 AND p.title = '피아노 모음곡 <어린이를 위하여>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:3fa9bb39-f6b0-4b0c-930a-ac0a51c0885b'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:9fbb1cfd-8281-46db-9d39-f557d4a275f4', 29, NULL, 'Pentatonic Tune. Allegro scherzando', 'No. 29. Pentatonic Tune. Allegro scherzando', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'classicmap:bartok:bartok-sz42:1'
WHERE p.composer_id = 85 AND p.title = '피아노 모음곡 <어린이를 위하여>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:9fbb1cfd-8281-46db-9d39-f557d4a275f4'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:3c011a00-63b5-41a7-a20d-d329353c18f0', 30, NULL, 'Jeering Song. Allegro ironico', 'No. 30. Jeering Song. Allegro ironico', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'classicmap:bartok:bartok-sz42:1'
WHERE p.composer_id = 85 AND p.title = '피아노 모음곡 <어린이를 위하여>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:3c011a00-63b5-41a7-a20d-d329353c18f0'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:f0d7ea1f-02cd-49ae-80f1-c1c1d51fb3e6', 31, NULL, 'Andante tranquillo', 'No. 31. Andante tranquillo', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'classicmap:bartok:bartok-sz42:1'
WHERE p.composer_id = 85 AND p.title = '피아노 모음곡 <어린이를 위하여>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:f0d7ea1f-02cd-49ae-80f1-c1c1d51fb3e6'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:b480e850-c1aa-4c36-9e33-9d19b006b100', 32, NULL, 'Andante', 'No. 32. Andante', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'classicmap:bartok:bartok-sz42:1'
WHERE p.composer_id = 85 AND p.title = '피아노 모음곡 <어린이를 위하여>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:b480e850-c1aa-4c36-9e33-9d19b006b100'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:949fc5e0-c52d-48f6-857e-c476ef0bb26b', 33, NULL, 'Allegro non troppo', 'No. 33. Allegro non troppo', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'classicmap:bartok:bartok-sz42:1'
WHERE p.composer_id = 85 AND p.title = '피아노 모음곡 <어린이를 위하여>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:949fc5e0-c52d-48f6-857e-c476ef0bb26b'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:0f163320-227f-42b5-a4ab-fdf2ef2e7767', 34, NULL, 'Allegretto', 'No. 34. Allegretto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'classicmap:bartok:bartok-sz42:1'
WHERE p.composer_id = 85 AND p.title = '피아노 모음곡 <어린이를 위하여>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:0f163320-227f-42b5-a4ab-fdf2ef2e7767'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:42b25fc4-c1b5-4eaf-a413-714831e6730d', 35, NULL, 'Con moto', 'No. 35. Con moto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'classicmap:bartok:bartok-sz42:1'
WHERE p.composer_id = 85 AND p.title = '피아노 모음곡 <어린이를 위하여>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:42b25fc4-c1b5-4eaf-a413-714831e6730d'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:d29a11a4-3935-4202-9d08-4c520e6165f0', 36, NULL, 'Drunkard''s Song. Vivace', 'No. 36. Drunkard''s Song. Vivace', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'classicmap:bartok:bartok-sz42:1'
WHERE p.composer_id = 85 AND p.title = '피아노 모음곡 <어린이를 위하여>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:d29a11a4-3935-4202-9d08-4c520e6165f0'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:82f21a94-e5dc-4a9d-bfa5-e6cc71ff3c6f', 37, NULL, 'Swineherd''s Song. Allegro', 'No. 37. Swineherd''s Song. Allegro', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'classicmap:bartok:bartok-sz42:1'
WHERE p.composer_id = 85 AND p.title = '피아노 모음곡 <어린이를 위하여>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:82f21a94-e5dc-4a9d-bfa5-e6cc71ff3c6f'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:35248731-5509-4dca-8001-7eeb9d566222', 38, NULL, 'Winter Solstice Song. Molto vivace', 'No. 38. Winter Solstice Song. Molto vivace', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'classicmap:bartok:bartok-sz42:1'
WHERE p.composer_id = 85 AND p.title = '피아노 모음곡 <어린이를 위하여>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:35248731-5509-4dca-8001-7eeb9d566222'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:b70d8c5e-dffb-4289-bd74-5e54fae24fc2', 39, NULL, 'Allegro moderato', 'No. 39. Allegro moderato', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'classicmap:bartok:bartok-sz42:1'
WHERE p.composer_id = 85 AND p.title = '피아노 모음곡 <어린이를 위하여>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:b70d8c5e-dffb-4289-bd74-5e54fae24fc2'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:c1d29b83-6db1-4f54-b656-599dea16a1a6', 40, NULL, 'Swineherd''s Dance. Allegro vivace', 'No. 40. Swineherd''s Dance. Allegro vivace', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'classicmap:bartok:bartok-sz42:1'
WHERE p.composer_id = 85 AND p.title = '피아노 모음곡 <어린이를 위하여>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:c1d29b83-6db1-4f54-b656-599dea16a1a6'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'classicmap:bartok:bartok-sz42:2', 2, NULL, '2권 (슬로바키아 민요)', 'Volume II (Slovak Folk Tunes)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 85 AND p.title = '피아노 모음곡 <어린이를 위하여>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'classicmap:bartok:bartok-sz42:2'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:ca207936-7716-48cc-bb03-93390c90bc45', 1, NULL, 'Allegro', 'No. 1. Allegro', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'classicmap:bartok:bartok-sz42:2'
WHERE p.composer_id = 85 AND p.title = '피아노 모음곡 <어린이를 위하여>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:ca207936-7716-48cc-bb03-93390c90bc45'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:07a8ee78-707c-4bc6-9253-9140bced1714', 2, NULL, 'Andante', 'No. 2. Andante', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'classicmap:bartok:bartok-sz42:2'
WHERE p.composer_id = 85 AND p.title = '피아노 모음곡 <어린이를 위하여>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:07a8ee78-707c-4bc6-9253-9140bced1714'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:f8b4aacd-2a14-4cea-a1a9-017f205672b1', 3, NULL, 'Allegretto', 'No. 3. Allegretto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'classicmap:bartok:bartok-sz42:2'
WHERE p.composer_id = 85 AND p.title = '피아노 모음곡 <어린이를 위하여>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:f8b4aacd-2a14-4cea-a1a9-017f205672b1'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:1f4dff29-578a-46eb-8d27-fc4c2c03ad21', 4, NULL, 'Wedding Song. Andante', 'No. 4. Wedding Song. Andante', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'classicmap:bartok:bartok-sz42:2'
WHERE p.composer_id = 85 AND p.title = '피아노 모음곡 <어린이를 위하여>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:1f4dff29-578a-46eb-8d27-fc4c2c03ad21'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:7ffbdf85-c8fc-4989-8000-1a7d4d7fecce', 5, NULL, 'Variation. Molto andante', 'No. 5. Variation. Molto andante', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'classicmap:bartok:bartok-sz42:2'
WHERE p.composer_id = 85 AND p.title = '피아노 모음곡 <어린이를 위하여>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:7ffbdf85-c8fc-4989-8000-1a7d4d7fecce'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:c74a0e1a-b69b-43f6-9875-52616570f086', 6, NULL, 'Round Dance I. Allegro', 'No. 6. Round Dance I. Allegro', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'classicmap:bartok:bartok-sz42:2'
WHERE p.composer_id = 85 AND p.title = '피아노 모음곡 <어린이를 위하여>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:c74a0e1a-b69b-43f6-9875-52616570f086'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:f317b672-7172-465b-80f0-a5065498f31d', 7, NULL, 'Sorrow. Andante', 'No. 7. Sorrow. Andante', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'classicmap:bartok:bartok-sz42:2'
WHERE p.composer_id = 85 AND p.title = '피아노 모음곡 <어린이를 위하여>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:f317b672-7172-465b-80f0-a5065498f31d'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:1e04e096-adc7-4c3c-a649-7d1e9bace415', 8, NULL, 'Dance. Allegro non troppo', 'No. 8. Dance. Allegro non troppo', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'classicmap:bartok:bartok-sz42:2'
WHERE p.composer_id = 85 AND p.title = '피아노 모음곡 <어린이를 위하여>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:1e04e096-adc7-4c3c-a649-7d1e9bace415'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:af57b6ea-0f9b-491f-ad23-ffe9160bf254', 9, NULL, 'Round Dance II. Andante', 'No. 9. Round Dance II. Andante', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'classicmap:bartok:bartok-sz42:2'
WHERE p.composer_id = 85 AND p.title = '피아노 모음곡 <어린이를 위하여>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:af57b6ea-0f9b-491f-ad23-ffe9160bf254'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:6f896b3d-1d5f-4c02-87ff-0c05a8a9a98e', 10, NULL, 'Funeral Song. Largo', 'No. 10. Funeral Song. Largo', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'classicmap:bartok:bartok-sz42:2'
WHERE p.composer_id = 85 AND p.title = '피아노 모음곡 <어린이를 위하여>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:6f896b3d-1d5f-4c02-87ff-0c05a8a9a98e'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:58e892b5-d4d7-42a5-8c7a-2433e2a95e01', 11, NULL, 'Lento', 'No. 11. Lento', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'classicmap:bartok:bartok-sz42:2'
WHERE p.composer_id = 85 AND p.title = '피아노 모음곡 <어린이를 위하여>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:58e892b5-d4d7-42a5-8c7a-2433e2a95e01'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:75073263-69d7-423d-9e77-18a55faab887', 12, NULL, 'Andante rubato', 'No. 12. Andante rubato', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'classicmap:bartok:bartok-sz42:2'
WHERE p.composer_id = 85 AND p.title = '피아노 모음곡 <어린이를 위하여>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:75073263-69d7-423d-9e77-18a55faab887'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:248dde1d-37e5-49ce-83d3-880089484dc2', 13, NULL, 'Allegro', 'No. 13. Allegro', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'classicmap:bartok:bartok-sz42:2'
WHERE p.composer_id = 85 AND p.title = '피아노 모음곡 <어린이를 위하여>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:248dde1d-37e5-49ce-83d3-880089484dc2'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:9e63f5f3-4a47-474f-b004-b25172014167', 14, NULL, 'Moderato', 'No. 14. Moderato', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'classicmap:bartok:bartok-sz42:2'
WHERE p.composer_id = 85 AND p.title = '피아노 모음곡 <어린이를 위하여>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:9e63f5f3-4a47-474f-b004-b25172014167'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:13adbaf0-3091-40f3-bd21-b2cbd5b7490f', 15, NULL, 'Bagpipe I. Molto tranquillo', 'No. 15. Bagpipe I. Molto tranquillo', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'classicmap:bartok:bartok-sz42:2'
WHERE p.composer_id = 85 AND p.title = '피아노 모음곡 <어린이를 위하여>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:13adbaf0-3091-40f3-bd21-b2cbd5b7490f'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:013bb5eb-f473-4b0a-bdd4-c2dcbcd58bfb', 16, NULL, 'Lament. Lento', 'No. 16. Lament. Lento', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'classicmap:bartok:bartok-sz42:2'
WHERE p.composer_id = 85 AND p.title = '피아노 모음곡 <어린이를 위하여>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:013bb5eb-f473-4b0a-bdd4-c2dcbcd58bfb'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:de1abca2-6ff8-4a6b-9af3-0341b15331d3', 17, NULL, 'Andante', 'No. 17. Andante', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'classicmap:bartok:bartok-sz42:2'
WHERE p.composer_id = 85 AND p.title = '피아노 모음곡 <어린이를 위하여>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:de1abca2-6ff8-4a6b-9af3-0341b15331d3'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:4e217f38-5c1d-475e-ae94-4b7798da9e8e', 18, NULL, 'Teasing Song. Sostenuto', 'No. 18. Teasing Song. Sostenuto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'classicmap:bartok:bartok-sz42:2'
WHERE p.composer_id = 85 AND p.title = '피아노 모음곡 <어린이를 위하여>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:4e217f38-5c1d-475e-ae94-4b7798da9e8e'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:b91b6f74-211d-4572-a7a9-163e15050a64', 19, NULL, 'Romance. Assai lento', 'No. 19. Romance. Assai lento', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'classicmap:bartok:bartok-sz42:2'
WHERE p.composer_id = 85 AND p.title = '피아노 모음곡 <어린이를 위하여>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:b91b6f74-211d-4572-a7a9-163e15050a64'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:65087dd2-328a-4e28-bab7-1796e26aef67', 20, NULL, 'Game of Tag. Presto', 'No. 20. Game of Tag. Presto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'classicmap:bartok:bartok-sz42:2'
WHERE p.composer_id = 85 AND p.title = '피아노 모음곡 <어린이를 위하여>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:65087dd2-328a-4e28-bab7-1796e26aef67'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:f0898f08-4b4d-45d7-b357-b4027cffeef0', 21, NULL, 'Pleasantry. Allegro moderato', 'No. 21. Pleasantry. Allegro moderato', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'classicmap:bartok:bartok-sz42:2'
WHERE p.composer_id = 85 AND p.title = '피아노 모음곡 <어린이를 위하여>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:f0898f08-4b4d-45d7-b357-b4027cffeef0'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:24af100a-a278-428f-854a-074f200743e0', 22, NULL, 'Revelry. Molto allegro', 'No. 22. Revelry. Molto allegro', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'classicmap:bartok:bartok-sz42:2'
WHERE p.composer_id = 85 AND p.title = '피아노 모음곡 <어린이를 위하여>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:24af100a-a278-428f-854a-074f200743e0'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:0e7ece1c-56aa-4703-b31f-6f5d5fb26463', 23, NULL, 'Andante tranquillo', 'No. 23. Andante tranquillo', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'classicmap:bartok:bartok-sz42:2'
WHERE p.composer_id = 85 AND p.title = '피아노 모음곡 <어린이를 위하여>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:0e7ece1c-56aa-4703-b31f-6f5d5fb26463'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:e416d39d-faff-4dbf-bee0-69ea469f512d', 24, NULL, 'Andante', 'No. 24. Andante', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'classicmap:bartok:bartok-sz42:2'
WHERE p.composer_id = 85 AND p.title = '피아노 모음곡 <어린이를 위하여>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:e416d39d-faff-4dbf-bee0-69ea469f512d'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:02e8296b-2079-4b0f-ad3a-e9cad73544e2', 25, NULL, 'Scherzando. Allegretto', 'No. 25. Scherzando. Allegretto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'classicmap:bartok:bartok-sz42:2'
WHERE p.composer_id = 85 AND p.title = '피아노 모음곡 <어린이를 위하여>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:02e8296b-2079-4b0f-ad3a-e9cad73544e2'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:8f6c643f-2df1-4ff4-a24a-e1f13755e6ad', 26, NULL, 'Peasant''s Flute. Andante molto rubato', 'No. 26. Peasant''s Flute. Andante molto rubato', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'classicmap:bartok:bartok-sz42:2'
WHERE p.composer_id = 85 AND p.title = '피아노 모음곡 <어린이를 위하여>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:8f6c643f-2df1-4ff4-a24a-e1f13755e6ad'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:aa102c20-09eb-41e7-833e-71daa839efb9', 27, NULL, 'Pleasantry II. Allegro', 'No. 27. Pleasantry II. Allegro', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'classicmap:bartok:bartok-sz42:2'
WHERE p.composer_id = 85 AND p.title = '피아노 모음곡 <어린이를 위하여>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:aa102c20-09eb-41e7-833e-71daa839efb9'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:ea1949e8-c10b-4a98-9f0c-79a65968ef97', 28, NULL, 'Andante, molto rubato', 'No. 28. Andante, molto rubato', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'classicmap:bartok:bartok-sz42:2'
WHERE p.composer_id = 85 AND p.title = '피아노 모음곡 <어린이를 위하여>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:ea1949e8-c10b-4a98-9f0c-79a65968ef97'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:06805a77-9613-4d87-a89a-0339864515dd', 29, NULL, 'Canon. Allegro non troppo', 'No. 29. Canon. Allegro non troppo', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'classicmap:bartok:bartok-sz42:2'
WHERE p.composer_id = 85 AND p.title = '피아노 모음곡 <어린이를 위하여>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:06805a77-9613-4d87-a89a-0339864515dd'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:5a8a3a09-ae0b-4237-999c-8795462f2342', 30, NULL, 'Bagpipe II. Vivace', 'No. 30. Bagpipe II. Vivace', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'classicmap:bartok:bartok-sz42:2'
WHERE p.composer_id = 85 AND p.title = '피아노 모음곡 <어린이를 위하여>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:5a8a3a09-ae0b-4237-999c-8795462f2342'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:3782570b-30c1-4c7b-bd56-969f1411b26f', 31, NULL, 'The Highway Robber. Allegro', 'No. 31. The Highway Robber. Allegro', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'classicmap:bartok:bartok-sz42:2'
WHERE p.composer_id = 85 AND p.title = '피아노 모음곡 <어린이를 위하여>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:3782570b-30c1-4c7b-bd56-969f1411b26f'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:532c2feb-ced5-4dcb-ba52-42e2e7b62d8b', 32, NULL, 'Pesante', 'No. 32. Pesante', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'classicmap:bartok:bartok-sz42:2'
WHERE p.composer_id = 85 AND p.title = '피아노 모음곡 <어린이를 위하여>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:532c2feb-ced5-4dcb-ba52-42e2e7b62d8b'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:37f02442-422e-4de8-99fb-ca2471174961', 33, NULL, 'Andante tranquillo', 'No. 33. Andante tranquillo', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'classicmap:bartok:bartok-sz42:2'
WHERE p.composer_id = 85 AND p.title = '피아노 모음곡 <어린이를 위하여>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:37f02442-422e-4de8-99fb-ca2471174961'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:621401b5-5287-4c69-b71d-3bf0dddaff7e', 34, NULL, 'Farewell. Adagio', 'No. 34. Farewell. Adagio', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'classicmap:bartok:bartok-sz42:2'
WHERE p.composer_id = 85 AND p.title = '피아노 모음곡 <어린이를 위하여>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:621401b5-5287-4c69-b71d-3bf0dddaff7e'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:cc94ebfb-0f15-4593-bb5f-724783cdfc5e', 35, NULL, 'Ballad. Moderato', 'No. 35. Ballad. Moderato', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'classicmap:bartok:bartok-sz42:2'
WHERE p.composer_id = 85 AND p.title = '피아노 모음곡 <어린이를 위하여>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:cc94ebfb-0f15-4593-bb5f-724783cdfc5e'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:e899d19f-4a37-4844-b07d-a83dedbdc3b7', 36, NULL, 'Rhapsody. Parlando, molto rubato – Allegro moderato', 'No. 36–37. Rhapsody. Parlando, molto rubato – Allegro moderato', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'classicmap:bartok:bartok-sz42:2'
WHERE p.composer_id = 85 AND p.title = '피아노 모음곡 <어린이를 위하여>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:e899d19f-4a37-4844-b07d-a83dedbdc3b7'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:28f6940b-cd25-4c02-8c01-8bda9040aed5', 37, NULL, 'Dirge. Lento', 'No. 38. Dirge. Lento', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'classicmap:bartok:bartok-sz42:2'
WHERE p.composer_id = 85 AND p.title = '피아노 모음곡 <어린이를 위하여>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:28f6940b-cd25-4c02-8c01-8bda9040aed5'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:8d695fca-938b-4495-8816-c902ae8b34da', 38, NULL, 'Mourning Song. Lento', 'No. 39. Mourning Song. Lento', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'classicmap:bartok:bartok-sz42:2'
WHERE p.composer_id = 85 AND p.title = '피아노 모음곡 <어린이를 위하여>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:8d695fca-938b-4495-8816-c902ae8b34da'
);


-- Sz. 43 2개의 루마니아 무곡

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '2개의 루마니아 무곡', 'Two Romanian Dances, Op. 8a', 'album', 'Sz. 43', NULL, NULL, 1910, 'manual', 1
FROM composers c
WHERE c.id = 85
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '2개의 루마니아 무곡'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'a01722b4-69b5-42bf-bda5-aa3d611e0331'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'a01722b4-69b5-42bf-bda5-aa3d611e0331'
FROM pieces p
WHERE p.composer_id = 85 AND p.title = '2개의 루마니아 무곡' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'a01722b4-69b5-42bf-bda5-aa3d611e0331'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:675f1065-e2fc-3ae3-a9c5-0079d56e853b', 1, NULL, 'Allegro vivace', 'Allegro vivace', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 85 AND p.title = '2개의 루마니아 무곡' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:675f1065-e2fc-3ae3-a9c5-0079d56e853b'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:9f166556-aa10-3d19-8872-4cfcb02ca645', 2, NULL, 'Poco allegro', 'Poco allegro', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 85 AND p.title = '2개의 루마니아 무곡' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:9f166556-aa10-3d19-8872-4cfcb02ca645'
);


-- Sz. 45 4개의 만가

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '4개의 만가', 'Four Dirges, Op. 9a', 'album', 'Sz. 45', NULL, NULL, 1910, 'manual', 1
FROM composers c
WHERE c.id = 85
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '4개의 만가'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '5caae459-173e-44c3-b561-1db592cb14f4'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '5caae459-173e-44c3-b561-1db592cb14f4'
FROM pieces p
WHERE p.composer_id = 85 AND p.title = '4개의 만가' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '5caae459-173e-44c3-b561-1db592cb14f4'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:012f0169-844e-3e03-a34f-2deea4c3e5ab', 1, NULL, 'Adagio', 'Adagio', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 85 AND p.title = '4개의 만가' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:012f0169-844e-3e03-a34f-2deea4c3e5ab'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:e7e79e79-6851-36ed-8312-364d2137d391', 2, NULL, 'Andante', 'Andante', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 85 AND p.title = '4개의 만가' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:e7e79e79-6851-36ed-8312-364d2137d391'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:94fd191c-dc3b-3603-9de1-bb37891fa80a', 3, NULL, 'Poco lento', 'Poco lento', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 85 AND p.title = '4개의 만가' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:94fd191c-dc3b-3603-9de1-bb37891fa80a'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:4dbeff71-8c52-3f83-88d6-ada2d57ecf0d', 4, NULL, 'Assai andante', 'Assai andante', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 85 AND p.title = '4개의 만가' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:4dbeff71-8c52-3f83-88d6-ada2d57ecf0d'
);


-- Sz. 44 7개의 스케치

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '7개의 스케치', 'Seven Sketches, Op. 9b', 'album', 'Sz. 44', NULL, NULL, 1910, 'manual', 1
FROM composers c
WHERE c.id = 85
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '7개의 스케치'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'de751ea0-2e04-42e3-83d9-07770b5230bf'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'de751ea0-2e04-42e3-83d9-07770b5230bf'
FROM pieces p
WHERE p.composer_id = 85 AND p.title = '7개의 스케치' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'de751ea0-2e04-42e3-83d9-07770b5230bf'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:300ed6ea-2b98-4de3-88a3-ea05e1561779', 1, NULL, 'Portrait of a Girl. Andante', 'Portrait of a Girl. Andante', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 85 AND p.title = '7개의 스케치' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:300ed6ea-2b98-4de3-88a3-ea05e1561779'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:f79d908f-b74a-4179-bb81-956d9c04cb2c', 2, NULL, 'See-saw. Comodo', 'See-saw. Comodo', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 85 AND p.title = '7개의 스케치' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:f79d908f-b74a-4179-bb81-956d9c04cb2c'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:928031d3-78e2-4fbc-a5d1-ee63586d2bc1', 3, NULL, 'Lento', 'Lento', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 85 AND p.title = '7개의 스케치' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:928031d3-78e2-4fbc-a5d1-ee63586d2bc1'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:1f524e6d-1246-4e38-ba1c-c5b28ef3758c', 4, NULL, 'Non troppo lento', 'Non troppo lento', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 85 AND p.title = '7개의 스케치' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:1f524e6d-1246-4e38-ba1c-c5b28ef3758c'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:3741d696-f276-434c-9727-a49f124c84cf', 5, NULL, 'Romanian Folk Song. Andante', 'Romanian Folk Song. Andante', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 85 AND p.title = '7개의 스케치' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:3741d696-f276-434c-9727-a49f124c84cf'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:d0094829-63ff-4a4b-b731-9759c36cdc86', 6, NULL, 'In Wallachian Style. Allegretto', 'In Wallachian Style. Allegretto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 85 AND p.title = '7개의 스케치' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:d0094829-63ff-4a4b-b731-9759c36cdc86'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:183a7ee0-1296-4400-8278-d1a65dd9b00f', 7, NULL, 'Poco lento', 'Poco lento', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 85 AND p.title = '7개의 스케치' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:183a7ee0-1296-4400-8278-d1a65dd9b00f'
);


-- Sz. 46 2개의 영상

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '2개의 영상', 'Two Pictures, Op. 10', 'album', 'Sz. 46', NULL, NULL, 1910, 'manual', 1
FROM composers c
WHERE c.id = 85
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '2개의 영상'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'b294e780-d11c-4fa1-ab97-df89c02cff59'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'b294e780-d11c-4fa1-ab97-df89c02cff59'
FROM pieces p
WHERE p.composer_id = 85 AND p.title = '2개의 영상' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'b294e780-d11c-4fa1-ab97-df89c02cff59'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:bec7306c-a065-4253-968d-593d2aeb9ed5', 1, 'I', 'In Full Flower', 'I. In Full Flower (Virágzás)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 85 AND p.title = '2개의 영상' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:bec7306c-a065-4253-968d-593d2aeb9ed5'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:d845f050-8cd2-4ff0-bcf9-aad4363ce292', 2, 'II', 'Village Dance', 'II. Village Dance (A falu tánca)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 85 AND p.title = '2개의 영상' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:d845f050-8cd2-4ff0-bcf9-aad4363ce292'
);


-- Sz. 47 3개의 부를레스크

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '3개의 부를레스크', 'Three Burlesques, Op. 8c', 'album', 'Sz. 47', NULL, NULL, 1911, 'manual', 1
FROM composers c
WHERE c.id = 85
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '3개의 부를레스크'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '5c7cf066-cbde-46df-aaa2-d5017b531df8'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '5c7cf066-cbde-46df-aaa2-d5017b531df8'
FROM pieces p
WHERE p.composer_id = 85 AND p.title = '3개의 부를레스크' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '5c7cf066-cbde-46df-aaa2-d5017b531df8'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:83648b6e-ad04-31de-8260-f7f25787a13d', 1, NULL, 'Quarrel. Presto', 'Quarrel. Presto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 85 AND p.title = '3개의 부를레스크' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:83648b6e-ad04-31de-8260-f7f25787a13d'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:b9a8f6f9-c4af-35f5-8928-7b56e720c8ca', 2, NULL, 'A Bit Drunk. Allegretto', 'A Bit Drunk. Allegretto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 85 AND p.title = '3개의 부를레스크' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:b9a8f6f9-c4af-35f5-8928-7b56e720c8ca'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:220516a8-7ddb-3736-a157-8f4f7ce9ec0f', 3, NULL, 'Molto vivo, capriccioso', 'Molto vivo, capriccioso', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 85 AND p.title = '3개의 부를레스크' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:220516a8-7ddb-3736-a157-8f4f7ce9ec0f'
);


-- Sz. 47a 관현악을 위한 루마니아 무곡

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '관현악을 위한 루마니아 무곡', 'Romanian Dance for Orchestra', 'song', 'Sz. 47a', NULL, NULL, 1911, 'manual', 1
FROM composers c
WHERE c.id = 85
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '관현악을 위한 루마니아 무곡'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '6ab74f91-8418-4074-979a-018d60926b31'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '6ab74f91-8418-4074-979a-018d60926b31'
FROM pieces p
WHERE p.composer_id = 85 AND p.title = '관현악을 위한 루마니아 무곡' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '6ab74f91-8418-4074-979a-018d60926b31'
);


-- Sz. 48 오페라 <푸른 수염 영주의 성>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '오페라 <푸른 수염 영주의 성>', 'Bluebeard''s Castle, Op. 11', 'song', 'Sz. 48', NULL, NULL, 1911, 'manual', 1
FROM composers c
WHERE c.id = 85
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '오페라 <푸른 수염 영주의 성>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'b83e28a0-c97e-476a-8473-71c09999c14b'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'b83e28a0-c97e-476a-8473-71c09999c14b'
FROM pieces p
WHERE p.composer_id = 85 AND p.title = '오페라 <푸른 수염 영주의 성>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'b83e28a0-c97e-476a-8473-71c09999c14b'
);


-- Sz. 49 알레그로 바르바로

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '알레그로 바르바로', 'Allegro barbaro', 'song', 'Sz. 49', NULL, NULL, 1911, 'manual', 1
FROM composers c
WHERE c.id = 85
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '알레그로 바르바로'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '199cc677-3c27-3f30-8ed2-6cc059792207'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '199cc677-3c27-3f30-8ed2-6cc059792207'
FROM pieces p
WHERE p.composer_id = 85 AND p.title = '알레그로 바르바로' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '199cc677-3c27-3f30-8ed2-6cc059792207'
);


-- Sz. 51 관현악을 위한 4개의 소품

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '관현악을 위한 4개의 소품', 'Four Pieces for Orchestra, Op. 12', 'album', 'Sz. 51', NULL, NULL, 1921, 'manual', 1
FROM composers c
WHERE c.id = 85
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '관현악을 위한 4개의 소품'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '176f58a8-ce78-4996-9c09-3821db88cf9c'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '176f58a8-ce78-4996-9c09-3821db88cf9c'
FROM pieces p
WHERE p.composer_id = 85 AND p.title = '관현악을 위한 4개의 소품' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '176f58a8-ce78-4996-9c09-3821db88cf9c'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:56d2ddfd-23a8-47ec-9e78-2ffecd4f956a', 1, 'I', '전주곡. Moderato', 'I. Preludio. Moderato', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 85 AND p.title = '관현악을 위한 4개의 소품' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:56d2ddfd-23a8-47ec-9e78-2ffecd4f956a'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:e9423e0c-32eb-41a7-a5d1-ec6865fd5f43', 2, 'II', '스케르초. Allegro', 'II. Scherzo. Allegro', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 85 AND p.title = '관현악을 위한 4개의 소품' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:e9423e0c-32eb-41a7-a5d1-ec6865fd5f43'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:b51de4ae-41ff-4c65-92bc-bfef9a9254d3', 3, 'III', '간주곡. Moderato', 'III. Intermezzo. Moderato', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 85 AND p.title = '관현악을 위한 4개의 소품' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:b51de4ae-41ff-4c65-92bc-bfef9a9254d3'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:87d77c72-537c-462e-9537-c1fc919b1786', 4, 'IV', '장송 행진곡. Maestoso', 'IV. Marcia funebre. Maestoso', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 85 AND p.title = '관현악을 위한 4개의 소품' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:87d77c72-537c-462e-9537-c1fc919b1786'
);


-- Sz. 53 피아노 첫걸음

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '피아노 첫걸음', 'The First Term at the Piano', 'album', 'Sz. 53', NULL, NULL, 1913, 'manual', 1
FROM composers c
WHERE c.id = 85
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '피아노 첫걸음'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '73af0e4f-c563-4904-9690-b0352c77cff4'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '73af0e4f-c563-4904-9690-b0352c77cff4'
FROM pieces p
WHERE p.composer_id = 85 AND p.title = '피아노 첫걸음' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '73af0e4f-c563-4904-9690-b0352c77cff4'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:2931fa86-b679-4518-aee0-8cd5c1b0fa7f', 1, NULL, 'Moderato', 'Moderato', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 85 AND p.title = '피아노 첫걸음' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:2931fa86-b679-4518-aee0-8cd5c1b0fa7f'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:a59e2858-b0af-474a-bc98-081867fe8d9c', 2, NULL, 'Moderato', 'Moderato', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 85 AND p.title = '피아노 첫걸음' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:a59e2858-b0af-474a-bc98-081867fe8d9c'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:0b6ce46b-8c40-483d-8fa3-45a7a64558e7', 3, NULL, 'Dialogue. Moderato', 'Dialogue. Moderato', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 85 AND p.title = '피아노 첫걸음' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:0b6ce46b-8c40-483d-8fa3-45a7a64558e7'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:6488c539-6b53-4c1f-ac30-a4454041da13', 4, NULL, 'Dialogue. Moderato', 'Dialogue. Moderato', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 85 AND p.title = '피아노 첫걸음' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:6488c539-6b53-4c1f-ac30-a4454041da13'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:99a57729-7205-405e-85e9-85499d0b041e', 5, NULL, 'Moderato', 'Moderato', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 85 AND p.title = '피아노 첫걸음' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:99a57729-7205-405e-85e9-85499d0b041e'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:f51d09e4-0a54-499b-ac16-b427c8c0981b', 6, NULL, 'Moderato', 'Moderato', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 85 AND p.title = '피아노 첫걸음' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:f51d09e4-0a54-499b-ac16-b427c8c0981b'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:0e2d6743-0baf-47a8-b44a-cdfe53ef6fcf', 7, NULL, 'Folk Song. Moderato', 'Folk Song. Moderato', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 85 AND p.title = '피아노 첫걸음' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:0e2d6743-0baf-47a8-b44a-cdfe53ef6fcf'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:766f25f1-e0c1-4fbf-aa3c-4dd49f323e55', 8, NULL, 'Andante', 'Andante', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 85 AND p.title = '피아노 첫걸음' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:766f25f1-e0c1-4fbf-aa3c-4dd49f323e55'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:1e3dc8bb-0e0b-4fb8-8fba-afd8859ef1e0', 9, NULL, 'Andante', 'Andante', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 85 AND p.title = '피아노 첫걸음' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:1e3dc8bb-0e0b-4fb8-8fba-afd8859ef1e0'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:bff3b8bc-0d47-4ae2-8db8-b46ab67c748f', 10, NULL, 'Folk Song. Allegro', 'Folk Song. Allegro', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 85 AND p.title = '피아노 첫걸음' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:bff3b8bc-0d47-4ae2-8db8-b46ab67c748f'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:f2cd73a3-b610-4a63-9d13-bc46bcc5bdd7', 11, NULL, 'Minuet. Andante', 'Minuet. Andante', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 85 AND p.title = '피아노 첫걸음' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:f2cd73a3-b610-4a63-9d13-bc46bcc5bdd7'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:e36d2e3a-699c-4b3a-a864-94a58b225151', 12, NULL, 'Swineherd''s Dance. Allegro', 'Swineherd''s Dance. Allegro', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 85 AND p.title = '피아노 첫걸음' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:e36d2e3a-699c-4b3a-a864-94a58b225151'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:50e04277-fcf6-43af-bff5-2b0f25bd7859', 13, NULL, '"Where Have You Been, My Lambkin?" (Folk Song). Andante', '"Where Have You Been, My Lambkin?" (Folk Song). Andante', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 85 AND p.title = '피아노 첫걸음' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:50e04277-fcf6-43af-bff5-2b0f25bd7859'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:85436c03-36d1-4da6-a533-740754875583', 14, NULL, 'Andante', 'Andante', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 85 AND p.title = '피아노 첫걸음' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:85436c03-36d1-4da6-a533-740754875583'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:9bdf5c7d-a62d-40c5-8ba3-368aef17efca', 15, NULL, 'Wedding Song. Moderato', 'Wedding Song. Moderato', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 85 AND p.title = '피아노 첫걸음' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:9bdf5c7d-a62d-40c5-8ba3-368aef17efca'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:e95253aa-6467-4a59-b73e-651a98addb7f', 16, NULL, 'Peasant''s Dance. Allegro moderato', 'Peasant''s Dance. Allegro moderato', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 85 AND p.title = '피아노 첫걸음' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:e95253aa-6467-4a59-b73e-651a98addb7f'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:79e3b436-e9c9-46e0-9fe7-9fa34b1981f0', 17, NULL, 'Allegro deciso', 'Allegro deciso', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 85 AND p.title = '피아노 첫걸음' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:79e3b436-e9c9-46e0-9fe7-9fa34b1981f0'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:e19700a9-4784-4288-a509-982ee1fcd1a4', 18, NULL, 'Waltz. Tempo di valse', 'Waltz. Tempo di valse', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 85 AND p.title = '피아노 첫걸음' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:e19700a9-4784-4288-a509-982ee1fcd1a4'
);


-- Sz. 55 소나티나

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '소나티나', 'Sonatina', 'album', 'Sz. 55', NULL, NULL, 1915, 'manual', 1
FROM composers c
WHERE c.id = 85
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '소나티나'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '53e1d11f-3eb6-47a8-b335-d072e719da65'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '53e1d11f-3eb6-47a8-b335-d072e719da65'
FROM pieces p
WHERE p.composer_id = 85 AND p.title = '소나티나' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '53e1d11f-3eb6-47a8-b335-d072e719da65'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:614b209a-824a-4a7c-bc05-997f4215722d', 1, 'I', 'Bagpipers. Allegretto', 'I. Bagpipers (Dudások). Allegretto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 85 AND p.title = '소나티나' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:614b209a-824a-4a7c-bc05-997f4215722d'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:32fb9c38-21f3-44e6-a0be-88f9253d51eb', 2, 'II', 'Bear Dance. Moderato', 'II. Bear Dance (Medvetánc). Moderato', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 85 AND p.title = '소나티나' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:32fb9c38-21f3-44e6-a0be-88f9253d51eb'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:d976a03f-f42d-48f3-bd96-bce87734fdc9', 3, 'III', '피날레. Allegro vivace', 'III. Finale. Allegro vivace', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 85 AND p.title = '소나티나' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:d976a03f-f42d-48f3-bd96-bce87734fdc9'
);


-- Sz. 56 루마니아 민속 무곡

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '루마니아 민속 무곡', 'Romanian Folk Dances', 'album', 'Sz. 56', NULL, NULL, 1915, 'manual', 1
FROM composers c
WHERE c.id = 85
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '루마니아 민속 무곡'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '4a7a0246-4b06-3611-948f-30bc37774fdc'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '4a7a0246-4b06-3611-948f-30bc37774fdc'
FROM pieces p
WHERE p.composer_id = 85 AND p.title = '루마니아 민속 무곡' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '4a7a0246-4b06-3611-948f-30bc37774fdc'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:60edc820-1045-3b46-bd6d-1360bf4212ee', 1, NULL, 'Jocul cu bâtă', 'Stick Dance (Jocul cu bâtă)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 85 AND p.title = '루마니아 민속 무곡' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:60edc820-1045-3b46-bd6d-1360bf4212ee'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:fc5ceefc-55e5-35c3-aa0d-eb83da5219c4', 2, NULL, 'Brâul', 'Sash Dance (Brâul)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 85 AND p.title = '루마니아 민속 무곡' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:fc5ceefc-55e5-35c3-aa0d-eb83da5219c4'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:3b0458d4-8fd8-3921-bcba-34c89806462d', 3, NULL, 'Pe loc', 'In One Spot (Pe loc)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 85 AND p.title = '루마니아 민속 무곡' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:3b0458d4-8fd8-3921-bcba-34c89806462d'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:23e43db9-fe04-3ac1-a0ae-f0e77d926e17', 4, NULL, 'Buciumeana', 'Dance from Bucsum (Buciumeana)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 85 AND p.title = '루마니아 민속 무곡' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:23e43db9-fe04-3ac1-a0ae-f0e77d926e17'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:41763066-bae9-3e6f-8ddf-5e9ca6953b17', 5, NULL, 'Poarga românească', 'Romanian Polka (Poarga românească)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 85 AND p.title = '루마니아 민속 무곡' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:41763066-bae9-3e6f-8ddf-5e9ca6953b17'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:e76785e5-b87f-3600-a576-2814dc58416d', 6, NULL, 'Mărunțel', 'Fast Dance (Mărunțel)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 85 AND p.title = '루마니아 민속 무곡' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:e76785e5-b87f-3600-a576-2814dc58416d'
);


-- Sz. 57 루마니아 크리스마스 캐럴

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '루마니아 크리스마스 캐럴', 'Romanian Christmas Carols (Colinde)', 'album', 'Sz. 57', NULL, NULL, 1915, 'manual', 1
FROM composers c
WHERE c.id = 85
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '루마니아 크리스마스 캐럴'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'cfbe42f4-f9f7-4190-86c4-e85073eb1def'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'cfbe42f4-f9f7-4190-86c4-e85073eb1def'
FROM pieces p
WHERE p.composer_id = 85 AND p.title = '루마니아 크리스마스 캐럴' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'cfbe42f4-f9f7-4190-86c4-e85073eb1def'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:624b6b32-9dbf-4e9e-b0c6-81e12314d179', 1, NULL, '1집', 'Series I', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 85 AND p.title = '루마니아 크리스마스 캐럴' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:624b6b32-9dbf-4e9e-b0c6-81e12314d179'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:3f2f2fd0-4991-445c-ab15-30aae61bdad4', 1, NULL, 'Allegro', 'Series I, No. 1. Allegro', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:624b6b32-9dbf-4e9e-b0c6-81e12314d179'
WHERE p.composer_id = 85 AND p.title = '루마니아 크리스마스 캐럴' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:3f2f2fd0-4991-445c-ab15-30aae61bdad4'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:a8c9cbce-890a-480f-9ba0-8aeab4772042', 2, NULL, 'Allegro', 'Series I, No. 2. Allegro', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:624b6b32-9dbf-4e9e-b0c6-81e12314d179'
WHERE p.composer_id = 85 AND p.title = '루마니아 크리스마스 캐럴' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:a8c9cbce-890a-480f-9ba0-8aeab4772042'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:7a5268b4-a48b-41b1-9535-5f97f8926636', 3, NULL, 'Allegro', 'Series I, No. 3. Allegro', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:624b6b32-9dbf-4e9e-b0c6-81e12314d179'
WHERE p.composer_id = 85 AND p.title = '루마니아 크리스마스 캐럴' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:7a5268b4-a48b-41b1-9535-5f97f8926636'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:4b425145-d4d4-4db0-9a2e-6e6dd19cd0c0', 4, NULL, 'Andante', 'Series I, No. 4. Andante', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:624b6b32-9dbf-4e9e-b0c6-81e12314d179'
WHERE p.composer_id = 85 AND p.title = '루마니아 크리스마스 캐럴' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:4b425145-d4d4-4db0-9a2e-6e6dd19cd0c0'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:097ec023-2e0e-47d7-b3d2-7a04bd9fc9e7', 5, NULL, 'Allegro moderato', 'Series I, No. 5. Allegro moderato', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:624b6b32-9dbf-4e9e-b0c6-81e12314d179'
WHERE p.composer_id = 85 AND p.title = '루마니아 크리스마스 캐럴' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:097ec023-2e0e-47d7-b3d2-7a04bd9fc9e7'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:ba045081-a13b-4db0-9ed6-ffa66d675d48', 6, NULL, 'Andante', 'Series I, No. 6. Andante', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:624b6b32-9dbf-4e9e-b0c6-81e12314d179'
WHERE p.composer_id = 85 AND p.title = '루마니아 크리스마스 캐럴' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:ba045081-a13b-4db0-9ed6-ffa66d675d48'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:192978f4-bcc6-448e-aa29-7064bfba4f0f', 7, NULL, 'Andante', 'Series I, No. 7. Andante', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:624b6b32-9dbf-4e9e-b0c6-81e12314d179'
WHERE p.composer_id = 85 AND p.title = '루마니아 크리스마스 캐럴' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:192978f4-bcc6-448e-aa29-7064bfba4f0f'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:ea1db5b5-95c2-42d1-93e1-cfbea302cff0', 8, NULL, 'Allegretto', 'Series I, No. 8. Allegretto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:624b6b32-9dbf-4e9e-b0c6-81e12314d179'
WHERE p.composer_id = 85 AND p.title = '루마니아 크리스마스 캐럴' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:ea1db5b5-95c2-42d1-93e1-cfbea302cff0'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:1bd6d707-34c1-4609-bb76-ac7338aa5891', 9, NULL, 'Allegro', 'Series I, No. 9. Allegro', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:624b6b32-9dbf-4e9e-b0c6-81e12314d179'
WHERE p.composer_id = 85 AND p.title = '루마니아 크리스마스 캐럴' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:1bd6d707-34c1-4609-bb76-ac7338aa5891'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:efc1e4d7-a224-4e02-b687-ae5b114b98f8', 10, NULL, 'Più allegro', 'Series I, No. 10. Più allegro', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:624b6b32-9dbf-4e9e-b0c6-81e12314d179'
WHERE p.composer_id = 85 AND p.title = '루마니아 크리스마스 캐럴' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:efc1e4d7-a224-4e02-b687-ae5b114b98f8'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:1aeb7d24-ffbf-4599-a411-bf0e77192d9f', 2, NULL, '2집', 'Series II', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 85 AND p.title = '루마니아 크리스마스 캐럴' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:1aeb7d24-ffbf-4599-a411-bf0e77192d9f'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:046928e1-e5bb-4acf-90d4-991f974bdc40', 1, NULL, 'Molto moderato', 'Series II, No. 1. Molto moderato', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:1aeb7d24-ffbf-4599-a411-bf0e77192d9f'
WHERE p.composer_id = 85 AND p.title = '루마니아 크리스마스 캐럴' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:046928e1-e5bb-4acf-90d4-991f974bdc40'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:dba7231d-4a5c-4525-8d43-54ae60e185a6', 2, NULL, 'Moderato', 'Series II, No. 2. Moderato', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:1aeb7d24-ffbf-4599-a411-bf0e77192d9f'
WHERE p.composer_id = 85 AND p.title = '루마니아 크리스마스 캐럴' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:dba7231d-4a5c-4525-8d43-54ae60e185a6'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:4249ba63-c715-495a-bfe0-4a39782f3886', 3, NULL, 'Andante', 'Series II, No. 3. Andante', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:1aeb7d24-ffbf-4599-a411-bf0e77192d9f'
WHERE p.composer_id = 85 AND p.title = '루마니아 크리스마스 캐럴' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:4249ba63-c715-495a-bfe0-4a39782f3886'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:0db2d704-dbef-42cd-ae82-fa9decff2416', 4, NULL, 'Andante', 'Series II, No. 4. Andante', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:1aeb7d24-ffbf-4599-a411-bf0e77192d9f'
WHERE p.composer_id = 85 AND p.title = '루마니아 크리스마스 캐럴' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:0db2d704-dbef-42cd-ae82-fa9decff2416'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:7e2f1f72-a5de-4640-88dc-51bc3dd22c47', 5, NULL, 'Moderato', 'Series II, No. 5. Moderato', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:1aeb7d24-ffbf-4599-a411-bf0e77192d9f'
WHERE p.composer_id = 85 AND p.title = '루마니아 크리스마스 캐럴' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:7e2f1f72-a5de-4640-88dc-51bc3dd22c47'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:34a042ac-6849-46b3-a633-6e084faffdd7', 6, NULL, 'Andante', 'Series II, No. 6. Andante', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:1aeb7d24-ffbf-4599-a411-bf0e77192d9f'
WHERE p.composer_id = 85 AND p.title = '루마니아 크리스마스 캐럴' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:34a042ac-6849-46b3-a633-6e084faffdd7'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:69a387bd-8d3f-415c-9e6d-d6f41f984c4c', 7, NULL, 'Variante della precedente – (Andante)', 'Series II, No. 7. Variante della precedente – (Andante)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:1aeb7d24-ffbf-4599-a411-bf0e77192d9f'
WHERE p.composer_id = 85 AND p.title = '루마니아 크리스마스 캐럴' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:69a387bd-8d3f-415c-9e6d-d6f41f984c4c'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:0c7829ae-9f52-4b90-9e65-d4da43294440', 8, NULL, 'Allegro', 'Series II, No. 8. Allegro', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:1aeb7d24-ffbf-4599-a411-bf0e77192d9f'
WHERE p.composer_id = 85 AND p.title = '루마니아 크리스마스 캐럴' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:0c7829ae-9f52-4b90-9e65-d4da43294440'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:dd2d893a-49f7-4a2d-8df9-5280d34bb3dd', 9, NULL, 'Allegretto', 'Series II, No. 9. Allegretto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:1aeb7d24-ffbf-4599-a411-bf0e77192d9f'
WHERE p.composer_id = 85 AND p.title = '루마니아 크리스마스 캐럴' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:dd2d893a-49f7-4a2d-8df9-5280d34bb3dd'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:cb3c417d-38fd-4f6b-aac9-778eac0bb964', 10, NULL, 'Allegro', 'Series II, No. 10. Allegro', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:1aeb7d24-ffbf-4599-a411-bf0e77192d9f'
WHERE p.composer_id = 85 AND p.title = '루마니아 크리스마스 캐럴' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:cb3c417d-38fd-4f6b-aac9-778eac0bb964'
);


-- Sz. 60 발레 <나무로 깎은 왕자>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '발레 <나무로 깎은 왕자>', 'The Wooden Prince, Op. 13', 'song', 'Sz. 60', NULL, NULL, 1917, 'manual', 1
FROM composers c
WHERE c.id = 85
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '발레 <나무로 깎은 왕자>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '6742b25e-1012-48cd-9b00-ec4353ccee56'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '6742b25e-1012-48cd-9b00-ec4353ccee56'
FROM pieces p
WHERE p.composer_id = 85 AND p.title = '발레 <나무로 깎은 왕자>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '6742b25e-1012-48cd-9b00-ec4353ccee56'
);


-- BB 74 발레 모음곡 <나무로 깎은 왕자>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '발레 모음곡 <나무로 깎은 왕자>', 'The Wooden Prince, Suite', 'album', 'BB 74', NULL, NULL, 1924, 'manual', 1
FROM composers c
WHERE c.id = 85
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '발레 모음곡 <나무로 깎은 왕자>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '140a91d7-1b2e-4187-a4de-054f5cbf2a00'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '140a91d7-1b2e-4187-a4de-054f5cbf2a00'
FROM pieces p
WHERE p.composer_id = 85 AND p.title = '발레 모음곡 <나무로 깎은 왕자>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '140a91d7-1b2e-4187-a4de-054f5cbf2a00'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:be7d26e7-e032-4587-9e03-648886c2d866', 1, 'I', '전주곡', 'I. Prelude', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 85 AND p.title = '발레 모음곡 <나무로 깎은 왕자>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:be7d26e7-e032-4587-9e03-648886c2d866'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:889d5c98-4ad3-44b6-94a8-fc682a52cf52', 2, 'II', 'Dance of the Princess in the Forest', 'II. Dance of the Princess in the Forest', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 85 AND p.title = '발레 모음곡 <나무로 깎은 왕자>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:889d5c98-4ad3-44b6-94a8-fc682a52cf52'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:14db082e-44f9-45eb-8f2d-b9716b3c3bc5', 3, 'III', 'Dance of the Trees', 'III. Dance of the Trees', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 85 AND p.title = '발레 모음곡 <나무로 깎은 왕자>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:14db082e-44f9-45eb-8f2d-b9716b3c3bc5'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:a481fd70-c6db-4731-b19e-3b1715436848', 4, 'IV', 'Dance of the Waves', 'IV. Dance of the Waves', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 85 AND p.title = '발레 모음곡 <나무로 깎은 왕자>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:a481fd70-c6db-4731-b19e-3b1715436848'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:199e7fa3-e69e-4417-bf7b-39eb67efd993', 5, 'V', 'The Prince and His Wooden Doll', 'V. The Prince and His Wooden Doll', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 85 AND p.title = '발레 모음곡 <나무로 깎은 왕자>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:199e7fa3-e69e-4417-bf7b-39eb67efd993'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:719aea1e-51d4-40e8-8375-eac328a65cb1', 6, 'VI', 'Dance of the Princess with the Wooden Doll', 'VI. Dance of the Princess with the Wooden Doll', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 85 AND p.title = '발레 모음곡 <나무로 깎은 왕자>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:719aea1e-51d4-40e8-8375-eac328a65cb1'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:a1b01d69-a433-4fa9-87a4-a1bd42da5ac2', 7, 'VII', '후주곡', 'VII. Postlude', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 85 AND p.title = '발레 모음곡 <나무로 깎은 왕자>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:a1b01d69-a433-4fa9-87a4-a1bd42da5ac2'
);


-- Sz. 62 피아노 모음곡

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '피아노 모음곡', 'Suite for Piano, Op. 14', 'album', 'Sz. 62', NULL, NULL, 1916, 'manual', 1
FROM composers c
WHERE c.id = 85
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '피아노 모음곡'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'f01bf015-c1ac-449b-a993-83498141e21f'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'f01bf015-c1ac-449b-a993-83498141e21f'
FROM pieces p
WHERE p.composer_id = 85 AND p.title = '피아노 모음곡' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'f01bf015-c1ac-449b-a993-83498141e21f'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:2256a825-012b-4bb8-9a06-6aee12a31884', 1, 'I', 'Allegretto', 'I. Allegretto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 85 AND p.title = '피아노 모음곡' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:2256a825-012b-4bb8-9a06-6aee12a31884'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:93933f49-4cc2-44a7-b241-66bb215e628e', 2, 'II', '스케르초', 'II. Scherzo', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 85 AND p.title = '피아노 모음곡' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:93933f49-4cc2-44a7-b241-66bb215e628e'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:a15d30af-ded8-42b9-a878-dc1a873c186f', 3, 'III', 'Allegro molto', 'III. Allegro molto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 85 AND p.title = '피아노 모음곡' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:a15d30af-ded8-42b9-a878-dc1a873c186f'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:dc4f2470-660c-4394-b67f-8134beaba47b', 4, 'IV', 'Sostenuto', 'IV. Sostenuto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 85 AND p.title = '피아노 모음곡' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:dc4f2470-660c-4394-b67f-8134beaba47b'
);


-- Sz. 61 5개의 가곡

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '5개의 가곡', 'Five Songs, Op. 15', 'album', 'Sz. 61', NULL, NULL, 1916, 'manual', 1
FROM composers c
WHERE c.id = 85
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '5개의 가곡'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'classicmap:bartok:bartok-sz61:1', 1, NULL, 'Az én szerelmem', 'Az én szerelmem (My Love)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 85 AND p.title = '5개의 가곡' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'classicmap:bartok:bartok-sz61:1'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'classicmap:bartok:bartok-sz61:2', 2, NULL, 'Nyár', 'Nyár (Summer)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 85 AND p.title = '5개의 가곡' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'classicmap:bartok:bartok-sz61:2'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'classicmap:bartok:bartok-sz61:3', 3, NULL, 'A vágyak éjjele', 'A vágyak éjjele (Night of Desire)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 85 AND p.title = '5개의 가곡' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'classicmap:bartok:bartok-sz61:3'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'classicmap:bartok:bartok-sz61:4', 4, NULL, 'Színes álomban', 'Színes álomban (In Vivid Dreams)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 85 AND p.title = '5개의 가곡' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'classicmap:bartok:bartok-sz61:4'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'classicmap:bartok:bartok-sz61:5', 5, NULL, 'Itt lent a völgyben', 'Itt lent a völgyben (In the Valley)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 85 AND p.title = '5개의 가곡' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'classicmap:bartok:bartok-sz61:5'
);


-- Sz. 63 아디의 시에 의한 5개의 가곡

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '아디의 시에 의한 5개의 가곡', 'Five Songs on Poems by Endre Ady, Op. 16', 'album', 'Sz. 63', NULL, NULL, 1916, 'manual', 1
FROM composers c
WHERE c.id = 85
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '아디의 시에 의한 5개의 가곡'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '4ac21243-05bf-4d7b-bd49-ae7deb30cc31'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '4ac21243-05bf-4d7b-bd49-ae7deb30cc31'
FROM pieces p
WHERE p.composer_id = 85 AND p.title = '아디의 시에 의한 5개의 가곡' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '4ac21243-05bf-4d7b-bd49-ae7deb30cc31'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:de7197e2-c825-47d4-ac4c-7020a10500f1', 1, NULL, 'Három őszi könnycsepp', 'Három őszi könnycsepp (Three Autumn Teardrops)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 85 AND p.title = '아디의 시에 의한 5개의 가곡' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:de7197e2-c825-47d4-ac4c-7020a10500f1'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:bc2a5c44-dc2b-4a46-a372-82ae22224deb', 2, NULL, 'Az őszi lárma', 'Az őszi lárma (Sounds of Autumn)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 85 AND p.title = '아디의 시에 의한 5개의 가곡' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:bc2a5c44-dc2b-4a46-a372-82ae22224deb'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:1cac7ca1-862c-41ee-b238-12bd18ebd4dc', 3, NULL, 'Az ágyam hívogat', 'Az ágyam hívogat (My Bed Calls Me)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 85 AND p.title = '아디의 시에 의한 5개의 가곡' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:1cac7ca1-862c-41ee-b238-12bd18ebd4dc'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:479b857e-982a-413e-a631-2de21e006ccc', 4, NULL, 'Egyedül a tengerrel', 'Egyedül a tengerrel (Alone with the Sea)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 85 AND p.title = '아디의 시에 의한 5개의 가곡' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:479b857e-982a-413e-a631-2de21e006ccc'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:1bdfd8c8-0af6-49bf-b1bd-11400bd233c1', 5, NULL, 'Nem mehetek hozzád', 'Nem mehetek hozzád (I Cannot Come to You)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 85 AND p.title = '아디의 시에 의한 5개의 가곡' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:1bdfd8c8-0af6-49bf-b1bd-11400bd233c1'
);


-- Sz. 65 피아노를 위한 헝가리 민요

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '피아노를 위한 헝가리 민요', 'Hungarian Folksong', 'song', 'Sz. 65', NULL, NULL, 1917, 'manual', 1
FROM composers c
WHERE c.id = 85
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '피아노를 위한 헝가리 민요'
);


-- Sz. 66 3개의 헝가리 민요 선율

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '3개의 헝가리 민요 선율', 'Three Hungarian Folk Tunes', 'album', 'Sz. 66', NULL, NULL, 1918, 'manual', 1
FROM composers c
WHERE c.id = 85
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '3개의 헝가리 민요 선율'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'f5da1cd9-8e16-44cb-b4c2-2605750d23db'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'f5da1cd9-8e16-44cb-b4c2-2605750d23db'
FROM pieces p
WHERE p.composer_id = 85 AND p.title = '3개의 헝가리 민요 선율' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'f5da1cd9-8e16-44cb-b4c2-2605750d23db'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:f2352224-b6fd-4472-9e10-ee46c157fa95', 1, NULL, 'Andante tranquillo, rubato', 'Andante tranquillo, rubato', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 85 AND p.title = '3개의 헝가리 민요 선율' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:f2352224-b6fd-4472-9e10-ee46c157fa95'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:1279d894-e134-4d99-b867-2ca2ed4e7fa3', 2, NULL, 'Allegro non troppo, un poco rubato', 'Allegro non troppo, un poco rubato', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 85 AND p.title = '3개의 헝가리 민요 선율' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:1279d894-e134-4d99-b867-2ca2ed4e7fa3'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:145fddf4-2a95-475f-b363-2a190d88f63a', 3, NULL, 'Maestoso', 'Maestoso', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 85 AND p.title = '3개의 헝가리 민요 선율' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:145fddf4-2a95-475f-b363-2a190d88f63a'
);


-- Sz. 67 현악 4중주 2번

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '현악 4중주 2번', 'String Quartet No. 2, Op. 17', 'album', 'Sz. 67', NULL, NULL, 1917, 'manual', 1
FROM composers c
WHERE c.id = 85
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '현악 4중주 2번'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'eedcd77e-a8b4-4e2e-94f4-f9e450e5b8fd'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'eedcd77e-a8b4-4e2e-94f4-f9e450e5b8fd'
FROM pieces p
WHERE p.composer_id = 85 AND p.title = '현악 4중주 2번' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'eedcd77e-a8b4-4e2e-94f4-f9e450e5b8fd'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:756fdaf8-6cf4-3c8c-8115-ee7e3209dbe2', 1, 'I', 'Moderato', 'I. Moderato', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 85 AND p.title = '현악 4중주 2번' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:756fdaf8-6cf4-3c8c-8115-ee7e3209dbe2'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:13e96450-2956-3f52-9d08-d847dd88c6b1', 2, 'II', 'Allegro molto capriccioso', 'II. Allegro molto capriccioso', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 85 AND p.title = '현악 4중주 2번' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:13e96450-2956-3f52-9d08-d847dd88c6b1'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:911378a7-9760-38d1-8726-a4b01f6334b8', 3, 'III', 'Lento', 'III. Lento', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 85 AND p.title = '현악 4중주 2번' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:911378a7-9760-38d1-8726-a4b01f6334b8'
);


-- Sz. 68 소관현악을 위한 루마니아 민속 무곡

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '소관현악을 위한 루마니아 민속 무곡', 'Romanian Folk Dances for Small Orchestra', 'album', 'Sz. 68', NULL, NULL, 1917, 'manual', 1
FROM composers c
WHERE c.id = 85
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '소관현악을 위한 루마니아 민속 무곡'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '07598043-07b4-45fd-a975-97747d0d4563'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '07598043-07b4-45fd-a975-97747d0d4563'
FROM pieces p
WHERE p.composer_id = 85 AND p.title = '소관현악을 위한 루마니아 민속 무곡' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '07598043-07b4-45fd-a975-97747d0d4563'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:c5e58810-9dd8-40af-b8a3-d4a14d778210', 1, NULL, 'Jocul cu bâtă', 'Stick Dance (Jocul cu bâtă)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 85 AND p.title = '소관현악을 위한 루마니아 민속 무곡' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:c5e58810-9dd8-40af-b8a3-d4a14d778210'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:be287971-3983-497c-bcdf-0b7f7821d43b', 2, NULL, 'Brâul', 'Sash Dance (Brâul)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 85 AND p.title = '소관현악을 위한 루마니아 민속 무곡' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:be287971-3983-497c-bcdf-0b7f7821d43b'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:1ab96d84-80f8-471d-9a1b-664082e84337', 3, NULL, 'Pe loc', 'In One Spot (Pe loc)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 85 AND p.title = '소관현악을 위한 루마니아 민속 무곡' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:1ab96d84-80f8-471d-9a1b-664082e84337'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:5e69f480-5e87-4977-9ffb-eba40ec7ae44', 4, NULL, 'Buciumeana', 'Dance from Bucsum (Buciumeana)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 85 AND p.title = '소관현악을 위한 루마니아 민속 무곡' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:5e69f480-5e87-4977-9ffb-eba40ec7ae44'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:c014ca90-5497-4735-8654-72d4ab30bd44', 5, NULL, 'Poarga românească', 'Romanian Polka (Poarga românească)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 85 AND p.title = '소관현악을 위한 루마니아 민속 무곡' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:c014ca90-5497-4735-8654-72d4ab30bd44'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'classicmap:bartok:bartok-sz68:6', 6, NULL, 'Mărunțel', 'Fast Dance (Mărunțel)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 85 AND p.title = '소관현악을 위한 루마니아 민속 무곡' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'classicmap:bartok:bartok-sz68:6'
);


-- Sz. 71 15개의 헝가리 농민의 노래

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '15개의 헝가리 농민의 노래', '15 Hungarian Peasant Songs', 'album', 'Sz. 71', NULL, NULL, 1918, 'manual', 1
FROM composers c
WHERE c.id = 85
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '15개의 헝가리 농민의 노래'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '9320c15f-d0d2-40db-8eb4-d6a5f2cea35b'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '9320c15f-d0d2-40db-8eb4-d6a5f2cea35b'
FROM pieces p
WHERE p.composer_id = 85 AND p.title = '15개의 헝가리 농민의 노래' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '9320c15f-d0d2-40db-8eb4-d6a5f2cea35b'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:23ed989a-0d11-4f4d-8497-335fdb56760c', 1, NULL, 'Rubato', 'Rubato', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 85 AND p.title = '15개의 헝가리 농민의 노래' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:23ed989a-0d11-4f4d-8497-335fdb56760c'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:0949b809-ee23-47e2-8619-6379abdc3526', 2, NULL, 'Andante', 'Andante', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 85 AND p.title = '15개의 헝가리 농민의 노래' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:0949b809-ee23-47e2-8619-6379abdc3526'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:8dfc2685-0c6d-48f0-8ad6-70a53ad9b9f5', 3, NULL, 'Poco rubato', 'Poco rubato', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 85 AND p.title = '15개의 헝가리 농민의 노래' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:8dfc2685-0c6d-48f0-8ad6-70a53ad9b9f5'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:e0cc4aa1-c26d-4f82-8fde-6a322d20592c', 4, NULL, 'Andante', 'Andante', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 85 AND p.title = '15개의 헝가리 농민의 노래' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:e0cc4aa1-c26d-4f82-8fde-6a322d20592c'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:9e6d1fb9-f9fb-4e74-91e6-464cfdcdac54', 5, NULL, '스케르초. Allegro', 'Scherzo. Allegro', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 85 AND p.title = '15개의 헝가리 농민의 노래' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:9e6d1fb9-f9fb-4e74-91e6-464cfdcdac54'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:954323fb-ec08-45f7-94e2-e0c797969a7c', 6, NULL, '발라드 (주제와 변주). Andante', 'Ballade (Tema con variazioni). Andante', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 85 AND p.title = '15개의 헝가리 농민의 노래' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:954323fb-ec08-45f7-94e2-e0c797969a7c'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:1cc230e3-1b86-4535-bb82-c94983949689', 7, NULL, 'Allegro', 'Allegro', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 85 AND p.title = '15개의 헝가리 농민의 노래' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:1cc230e3-1b86-4535-bb82-c94983949689'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:499743ad-4271-497e-a81b-c97c23053abd', 8, NULL, 'Allegretto', 'Allegretto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 85 AND p.title = '15개의 헝가리 농민의 노래' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:499743ad-4271-497e-a81b-c97c23053abd'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:f8cf0262-d83a-42fd-92e0-3bd1a3b5ebd0', 9, NULL, 'Allegretto', 'Allegretto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 85 AND p.title = '15개의 헝가리 농민의 노래' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:f8cf0262-d83a-42fd-92e0-3bd1a3b5ebd0'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:4e106ab0-f08e-492d-84b1-e69a061316f4', 10, NULL, 'L''istesso tempo', 'L''istesso tempo', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 85 AND p.title = '15개의 헝가리 농민의 노래' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:4e106ab0-f08e-492d-84b1-e69a061316f4'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:5ca30d5c-e193-4d36-9a98-add7202f8fe5', 11, NULL, 'Assai moderato', 'Assai moderato', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 85 AND p.title = '15개의 헝가리 농민의 노래' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:5ca30d5c-e193-4d36-9a98-add7202f8fe5'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:c86a4a0e-49ea-4adc-a4bb-fbe3cb26076c', 12, NULL, 'Allegretto', 'Allegretto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 85 AND p.title = '15개의 헝가리 농민의 노래' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:c86a4a0e-49ea-4adc-a4bb-fbe3cb26076c'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:258a8ae3-6e66-4481-b303-643ad1a32cb0', 13, NULL, 'Poco più vivo – Allegretto', 'Poco più vivo – Allegretto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 85 AND p.title = '15개의 헝가리 농민의 노래' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:258a8ae3-6e66-4481-b303-643ad1a32cb0'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:150b7c4f-66ab-4ddd-92f9-9c21ea7dbb6f', 14, NULL, 'Allegro', 'Allegro', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 85 AND p.title = '15개의 헝가리 농민의 노래' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:150b7c4f-66ab-4ddd-92f9-9c21ea7dbb6f'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:4e90d2aa-baca-4a04-839b-e32b587875dc', 15, NULL, 'Allegro', 'Allegro', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 85 AND p.title = '15개의 헝가리 농민의 노래' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:4e90d2aa-baca-4a04-839b-e32b587875dc'
);


-- Sz. 72 3개의 연습곡

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '3개의 연습곡', 'Three Studies, Op. 18', 'album', 'Sz. 72', NULL, NULL, 1918, 'manual', 1
FROM composers c
WHERE c.id = 85
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '3개의 연습곡'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '38c750e7-de48-4e1e-8159-fa541d87bef8'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '38c750e7-de48-4e1e-8159-fa541d87bef8'
FROM pieces p
WHERE p.composer_id = 85 AND p.title = '3개의 연습곡' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '38c750e7-de48-4e1e-8159-fa541d87bef8'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:a1268943-4156-42c3-97b1-aaf384a3cfea', 1, NULL, 'Allegro molto', 'Allegro molto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 85 AND p.title = '3개의 연습곡' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:a1268943-4156-42c3-97b1-aaf384a3cfea'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:330e343e-d8ef-440d-99a3-bafe33e3f849', 2, NULL, 'Andante sostenuto – Più mosso', 'Andante sostenuto – Più mosso', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 85 AND p.title = '3개의 연습곡' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:330e343e-d8ef-440d-99a3-bafe33e3f849'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:9ed94644-5afe-4305-9a38-a86538cc310b', 3, NULL, 'Rubato – Molto sostenuto – Tempo giusto – Rubato', 'Rubato – Molto sostenuto – Tempo giusto – Rubato', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 85 AND p.title = '3개의 연습곡' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:9ed94644-5afe-4305-9a38-a86538cc310b'
);


-- Sz. 73 발레 모음곡 <이상한 만다린>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '발레 모음곡 <이상한 만다린>', 'The Miraculous Mandarin, Suite', 'song', 'Sz. 73', NULL, NULL, 1926, 'manual', 1
FROM composers c
WHERE c.id = 85
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '발레 모음곡 <이상한 만다린>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '618b8203-7c95-49bc-afbf-5b2a03682508'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '618b8203-7c95-49bc-afbf-5b2a03682508'
FROM pieces p
WHERE p.composer_id = 85 AND p.title = '발레 모음곡 <이상한 만다린>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '618b8203-7c95-49bc-afbf-5b2a03682508'
);


-- Sz. 74 헝가리 농민 노래에 의한 8개의 즉흥곡

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '헝가리 농민 노래에 의한 8개의 즉흥곡', 'Eight Improvisations on Hungarian Peasant Songs, Op. 20', 'album', 'Sz. 74', NULL, NULL, 1920, 'manual', 1
FROM composers c
WHERE c.id = 85
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '헝가리 농민 노래에 의한 8개의 즉흥곡'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '6a74e914-a47d-4931-9d6d-b5bc3fce6bdc'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '6a74e914-a47d-4931-9d6d-b5bc3fce6bdc'
FROM pieces p
WHERE p.composer_id = 85 AND p.title = '헝가리 농민 노래에 의한 8개의 즉흥곡' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '6a74e914-a47d-4931-9d6d-b5bc3fce6bdc'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:3d15a439-c877-453a-a2e7-07872cb5d271', 1, NULL, 'Molto moderato', 'Molto moderato', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 85 AND p.title = '헝가리 농민 노래에 의한 8개의 즉흥곡' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:3d15a439-c877-453a-a2e7-07872cb5d271'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:aa46c7b6-723a-44f1-bb0f-83f4946bc06f', 2, NULL, 'Molto capriccioso', 'Molto capriccioso', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 85 AND p.title = '헝가리 농민 노래에 의한 8개의 즉흥곡' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:aa46c7b6-723a-44f1-bb0f-83f4946bc06f'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:d46d0c2d-b633-478c-b45a-b8396d2149db', 3, NULL, 'Lento, rubato', 'Lento, rubato', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 85 AND p.title = '헝가리 농민 노래에 의한 8개의 즉흥곡' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:d46d0c2d-b633-478c-b45a-b8396d2149db'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:b2147d51-4d48-42d6-9a00-db216525ac8e', 4, NULL, 'Allegretto scherzando', 'Allegretto scherzando', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 85 AND p.title = '헝가리 농민 노래에 의한 8개의 즉흥곡' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:b2147d51-4d48-42d6-9a00-db216525ac8e'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:708edb48-5149-4423-b938-d0a345a73daf', 5, NULL, 'Allegro molto', 'Allegro molto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 85 AND p.title = '헝가리 농민 노래에 의한 8개의 즉흥곡' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:708edb48-5149-4423-b938-d0a345a73daf'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:efaaf3a7-68f6-40e2-85e1-4cf0dca889a0', 6, NULL, 'Allegro moderato, molto capriccioso', 'Allegro moderato, molto capriccioso', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 85 AND p.title = '헝가리 농민 노래에 의한 8개의 즉흥곡' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:efaaf3a7-68f6-40e2-85e1-4cf0dca889a0'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:839e0599-ede1-4f83-9743-00ab2d5ed728', 7, NULL, 'Sostenuto, rubato', 'Sostenuto, rubato', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 85 AND p.title = '헝가리 농민 노래에 의한 8개의 즉흥곡' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:839e0599-ede1-4f83-9743-00ab2d5ed728'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:3250d32d-a718-4166-bd79-d4096d6e3b30', 8, NULL, 'Allegro', 'Allegro', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 85 AND p.title = '헝가리 농민 노래에 의한 8개의 즉흥곡' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:3250d32d-a718-4166-bd79-d4096d6e3b30'
);


-- Sz. 75 바이올린 소나타 1번

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '바이올린 소나타 1번', 'Violin Sonata No. 1, Op. 21', 'album', 'Sz. 75', NULL, NULL, 1921, 'manual', 1
FROM composers c
WHERE c.id = 85
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '바이올린 소나타 1번'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'acd9908a-ac66-447b-b0fb-2da770d24d6f'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'acd9908a-ac66-447b-b0fb-2da770d24d6f'
FROM pieces p
WHERE p.composer_id = 85 AND p.title = '바이올린 소나타 1번' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'acd9908a-ac66-447b-b0fb-2da770d24d6f'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:98c3e089-e456-37ce-8c51-fc88b711af92', 1, 'I', 'Allegro appassionato', 'I. Allegro appassionato', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 85 AND p.title = '바이올린 소나타 1번' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:98c3e089-e456-37ce-8c51-fc88b711af92'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:bc8716b5-7b05-3fd1-b6ac-63b767d6bcca', 2, 'II', 'Adagio', 'II. Adagio', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 85 AND p.title = '바이올린 소나타 1번' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:bc8716b5-7b05-3fd1-b6ac-63b767d6bcca'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:a044576c-48bd-39ea-86c7-036b5d4bcd26', 3, 'III', 'Allegro molto', 'III. Allegro molto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 85 AND p.title = '바이올린 소나타 1번' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:a044576c-48bd-39ea-86c7-036b5d4bcd26'
);


-- Sz. 76 바이올린 소나타 2번

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '바이올린 소나타 2번', 'Violin Sonata No. 2', 'album', 'Sz. 76', NULL, NULL, 1922, 'manual', 1
FROM composers c
WHERE c.id = 85
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '바이올린 소나타 2번'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '5280ff38-5d16-4d18-baca-ce2e3154cf5a'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '5280ff38-5d16-4d18-baca-ce2e3154cf5a'
FROM pieces p
WHERE p.composer_id = 85 AND p.title = '바이올린 소나타 2번' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '5280ff38-5d16-4d18-baca-ce2e3154cf5a'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:6cc60194-8acb-3586-9c5f-9f38bcf07161', 1, 'I', 'Molto moderato', 'I. Molto moderato', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 85 AND p.title = '바이올린 소나타 2번' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:6cc60194-8acb-3586-9c5f-9f38bcf07161'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:cd10f30e-e842-313c-aea3-259de0b0806a', 2, 'II', 'Allegretto', 'II. Allegretto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 85 AND p.title = '바이올린 소나타 2번' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:cd10f30e-e842-313c-aea3-259de0b0806a'
);


-- Sz. 77 무용 모음곡

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '무용 모음곡', 'Dance Suite', 'album', 'Sz. 77', NULL, NULL, 1923, 'manual', 1
FROM composers c
WHERE c.id = 85
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '무용 모음곡'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '2937b339-65be-46e4-aadf-ed26d1421f5d'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '2937b339-65be-46e4-aadf-ed26d1421f5d'
FROM pieces p
WHERE p.composer_id = 85 AND p.title = '무용 모음곡' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '2937b339-65be-46e4-aadf-ed26d1421f5d'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:257e1603-a7c5-4fe1-96bc-147122caa629', 1, 'I', 'Moderato', 'I. Moderato', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 85 AND p.title = '무용 모음곡' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:257e1603-a7c5-4fe1-96bc-147122caa629'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:2b960c3b-18b1-4618-93ef-74320c879868', 2, 'II', 'Allegro molto', 'II. Allegro molto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 85 AND p.title = '무용 모음곡' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:2b960c3b-18b1-4618-93ef-74320c879868'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:6dbefa2e-3fa3-4a2b-8e8c-7dae0603b767', 3, 'III', 'Allegro vivace', 'III. Allegro vivace', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 85 AND p.title = '무용 모음곡' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:6dbefa2e-3fa3-4a2b-8e8c-7dae0603b767'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:c312c700-8068-42bd-b359-f35065df932b', 4, 'IV', 'Molto tranquillo', 'IV. Molto tranquillo', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 85 AND p.title = '무용 모음곡' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:c312c700-8068-42bd-b359-f35065df932b'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:a0d9497c-2523-4a00-b217-d85eacbf5d1e', 5, 'V', 'Comodo', 'V. Comodo', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 85 AND p.title = '무용 모음곡' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:a0d9497c-2523-4a00-b217-d85eacbf5d1e'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:278f664d-e86d-4fe0-b32e-65c37a110467', 6, 'VI', '피날레. Allegro', 'VI. Finale. Allegro', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 85 AND p.title = '무용 모음곡' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:278f664d-e86d-4fe0-b32e-65c37a110467'
);


-- Sz. 78 마을 풍경

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '마을 풍경', 'Village Scenes', 'album', 'Sz. 78', NULL, NULL, 1924, 'manual', 1
FROM composers c
WHERE c.id = 85
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '마을 풍경'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '5df9593f-9623-41f3-ab35-4b4569f9bfee'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '5df9593f-9623-41f3-ab35-4b4569f9bfee'
FROM pieces p
WHERE p.composer_id = 85 AND p.title = '마을 풍경' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '5df9593f-9623-41f3-ab35-4b4569f9bfee'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:8849ca76-e676-41ef-bd19-dac0507b8520', 1, NULL, 'Pri hrabaní', 'Pri hrabaní (Haymaking)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 85 AND p.title = '마을 풍경' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:8849ca76-e676-41ef-bd19-dac0507b8520'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:1673e531-30de-4541-af5a-5ccc6be6ccb6', 2, NULL, 'Pri neveste', 'Pri neveste (At the Bride''s)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 85 AND p.title = '마을 풍경' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:1673e531-30de-4541-af5a-5ccc6be6ccb6'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:f6fe43c1-7947-4b18-87e8-433fd4db9507', 3, NULL, 'Svatba', 'Svatba (Wedding)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 85 AND p.title = '마을 풍경' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:f6fe43c1-7947-4b18-87e8-433fd4db9507'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:8d031bbe-e794-48c2-9e7e-1aef3784f9e5', 4, NULL, 'Ukoliebavka', 'Ukoliebavka (Lullaby)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 85 AND p.title = '마을 풍경' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:8d031bbe-e794-48c2-9e7e-1aef3784f9e5'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:38beaa28-d02a-452f-8d61-6f22a4765686', 5, NULL, 'Tanec mládencov', 'Tanec mládencov (Lads'' Dance)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 85 AND p.title = '마을 풍경' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:38beaa28-d02a-452f-8d61-6f22a4765686'
);


-- Sz. 79 3개의 마을 풍경

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '3개의 마을 풍경', 'Three Village Scenes', 'album', 'Sz. 79', NULL, NULL, 1926, 'manual', 1
FROM composers c
WHERE c.id = 85
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '3개의 마을 풍경'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '5bb4214d-df6c-4f03-b972-d8c116265820'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '5bb4214d-df6c-4f03-b972-d8c116265820'
FROM pieces p
WHERE p.composer_id = 85 AND p.title = '3개의 마을 풍경' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '5bb4214d-df6c-4f03-b972-d8c116265820'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:75d30705-d6a7-4eaf-8041-d29ad1e4c4be', 1, NULL, 'Svatba', 'Svatba (Wedding)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 85 AND p.title = '3개의 마을 풍경' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:75d30705-d6a7-4eaf-8041-d29ad1e4c4be'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:41ed7cdf-db55-45a3-baf5-356f453f6719', 2, NULL, 'Ukoliebavka', 'Ukoliebavka (Lullaby)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 85 AND p.title = '3개의 마을 풍경' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:41ed7cdf-db55-45a3-baf5-356f453f6719'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:4e406c6c-e575-463b-b220-7d10d0495cb0', 3, NULL, 'Tanec mládencov', 'Tanec mládencov (Lads'' Dance)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 85 AND p.title = '3개의 마을 풍경' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:4e406c6c-e575-463b-b220-7d10d0495cb0'
);


-- Sz. 80 피아노 소나타

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '피아노 소나타', 'Piano Sonata', 'album', 'Sz. 80', NULL, NULL, 1926, 'manual', 1
FROM composers c
WHERE c.id = 85
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '피아노 소나타'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '5a13704e-9183-4cfc-9b2b-41fd72b0e680'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '5a13704e-9183-4cfc-9b2b-41fd72b0e680'
FROM pieces p
WHERE p.composer_id = 85 AND p.title = '피아노 소나타' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '5a13704e-9183-4cfc-9b2b-41fd72b0e680'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:fe53f152-0537-4485-a792-a5ca30e3c5b6', 1, 'I', 'Allegro moderato', 'I. Allegro moderato', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 85 AND p.title = '피아노 소나타' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:fe53f152-0537-4485-a792-a5ca30e3c5b6'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:85019f48-09c2-4d7e-a9b0-04f578f12234', 2, 'II', 'Sostenuto e pesante', 'II. Sostenuto e pesante', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 85 AND p.title = '피아노 소나타' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:85019f48-09c2-4d7e-a9b0-04f578f12234'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:36bfeb37-abaf-4b48-b3e9-e7318c5dfc42', 3, 'III', 'Allegro molto', 'III. Allegro molto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 85 AND p.title = '피아노 소나타' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:36bfeb37-abaf-4b48-b3e9-e7318c5dfc42'
);


-- Sz. 81 피아노 모음곡 <야외에서>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '피아노 모음곡 <야외에서>', 'Out of Doors', 'album', 'Sz. 81', NULL, NULL, 1926, 'manual', 1
FROM composers c
WHERE c.id = 85
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '피아노 모음곡 <야외에서>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '1078e168-7a4c-4e90-bf33-0ddcccf45326'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '1078e168-7a4c-4e90-bf33-0ddcccf45326'
FROM pieces p
WHERE p.composer_id = 85 AND p.title = '피아노 모음곡 <야외에서>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '1078e168-7a4c-4e90-bf33-0ddcccf45326'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:96522caa-2771-3b59-9163-8f2574f7b16f', 1, NULL, 'With Drums and Pipes', 'With Drums and Pipes (Síppal, dobbal)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 85 AND p.title = '피아노 모음곡 <야외에서>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:96522caa-2771-3b59-9163-8f2574f7b16f'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:475821f8-7291-3b7a-841c-a343c89d70d9', 2, NULL, 'Barcarolla', 'Barcarolla', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 85 AND p.title = '피아노 모음곡 <야외에서>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:475821f8-7291-3b7a-841c-a343c89d70d9'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:d59555cb-20bb-36e1-b6ba-7d9d1dd6f9f3', 3, NULL, 'Musettes', 'Musettes', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 85 AND p.title = '피아노 모음곡 <야외에서>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:d59555cb-20bb-36e1-b6ba-7d9d1dd6f9f3'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:16e5f8a5-448d-3af9-a0e7-d7f9f2e866b0', 4, NULL, '밤의 음악', 'The Night''s Music (Az éjszaka zenéje)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 85 AND p.title = '피아노 모음곡 <야외에서>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:16e5f8a5-448d-3af9-a0e7-d7f9f2e866b0'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:08fdc9cc-9895-3ad9-920f-eff809ffbb96', 5, NULL, 'The Chase', 'The Chase (Hajsza)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 85 AND p.title = '피아노 모음곡 <야외에서>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:08fdc9cc-9895-3ad9-920f-eff809ffbb96'
);


-- Sz. 82 9개의 작은 피아노 소품

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '9개의 작은 피아노 소품', 'Nine Little Piano Pieces', 'album', 'Sz. 82', NULL, NULL, 1926, 'manual', 1
FROM composers c
WHERE c.id = 85
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '9개의 작은 피아노 소품'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '8dfee807-688e-46fc-af58-103a6ced660c'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '8dfee807-688e-46fc-af58-103a6ced660c'
FROM pieces p
WHERE p.composer_id = 85 AND p.title = '9개의 작은 피아노 소품' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '8dfee807-688e-46fc-af58-103a6ced660c'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:aff389f6-bcff-404c-9949-de59f756cdf3', 1, NULL, 'Moderato', 'Moderato', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 85 AND p.title = '9개의 작은 피아노 소품' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:aff389f6-bcff-404c-9949-de59f756cdf3'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:fec34d0c-1367-4488-976f-756e7f180ce3', 2, NULL, 'Andante', 'Andante', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 85 AND p.title = '9개의 작은 피아노 소품' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:fec34d0c-1367-4488-976f-756e7f180ce3'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:f1384250-7a76-4a26-8944-0b52e853902f', 3, NULL, 'Lento', 'Lento', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 85 AND p.title = '9개의 작은 피아노 소품' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:f1384250-7a76-4a26-8944-0b52e853902f'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:782ea650-0efa-4a34-b252-a9b9c0f40dd0', 4, NULL, 'Allegro vivace', 'Allegro vivace', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 85 AND p.title = '9개의 작은 피아노 소품' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:782ea650-0efa-4a34-b252-a9b9c0f40dd0'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:bf89ce54-6ec8-430e-b09a-df63691c0d14', 5, NULL, '미뉴에트. Moderato', 'Menuetto. Moderato', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 85 AND p.title = '9개의 작은 피아노 소품' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:bf89ce54-6ec8-430e-b09a-df63691c0d14'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:d1e219f0-dc28-4812-9996-44e50b683095', 6, NULL, '아리아. Allegro – Meno mosso', 'Air. Allegro – Meno mosso', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 85 AND p.title = '9개의 작은 피아노 소품' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:d1e219f0-dc28-4812-9996-44e50b683095'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:d114cccc-7565-4d87-b8e9-e9fb86fec57f', 7, NULL, '동물들의 행진. Comodo', 'Marcia delle bestie. Comodo', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 85 AND p.title = '9개의 작은 피아노 소품' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:d114cccc-7565-4d87-b8e9-e9fb86fec57f'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:203262bf-f79b-4943-a37a-484eb1016017', 8, NULL, '탬버린. Allegro molto', 'Tambourine. Allegro molto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 85 AND p.title = '9개의 작은 피아노 소품' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:203262bf-f79b-4943-a37a-484eb1016017'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:c0fe2870-9410-46cc-a05d-1c689dcf6620', 9, NULL, '전주곡 – All''ungherese', 'Preludio – All''ungherese', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 85 AND p.title = '9개의 작은 피아노 소품' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:c0fe2870-9410-46cc-a05d-1c689dcf6620'
);


-- Sz. 83 피아노 협주곡 1번

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '피아노 협주곡 1번', 'Piano Concerto No. 1', 'album', 'Sz. 83', NULL, NULL, 1926, 'manual', 1
FROM composers c
WHERE c.id = 85
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '피아노 협주곡 1번'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '9ab0f9ef-b35f-4b21-b496-0fd8f98510b9'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '9ab0f9ef-b35f-4b21-b496-0fd8f98510b9'
FROM pieces p
WHERE p.composer_id = 85 AND p.title = '피아노 협주곡 1번' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '9ab0f9ef-b35f-4b21-b496-0fd8f98510b9'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:fcc573db-c0e7-30b1-9947-a5fb44f92df0', 1, 'I', 'Allegro moderato', 'I. Allegro moderato', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 85 AND p.title = '피아노 협주곡 1번' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:fcc573db-c0e7-30b1-9947-a5fb44f92df0'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:9c40a56d-f59f-3390-9e3c-3a6b84f65666', 2, 'II', 'Andante', 'II. Andante', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 85 AND p.title = '피아노 협주곡 1번' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:9c40a56d-f59f-3390-9e3c-3a6b84f65666'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:76cc4ae8-e63b-37c4-bcdc-0f2c3c5a88d4', 3, 'III', 'Allegro molto', 'III. Allegro molto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 85 AND p.title = '피아노 협주곡 1번' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:76cc4ae8-e63b-37c4-bcdc-0f2c3c5a88d4'
);


-- Sz. 84 슬로바키아 민요에 의한 3개의 론도

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '슬로바키아 민요에 의한 3개의 론도', 'Three Rondos on Slovak Folk Tunes', 'album', 'Sz. 84', NULL, NULL, 1927, 'manual', 1
FROM composers c
WHERE c.id = 85
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '슬로바키아 민요에 의한 3개의 론도'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '6f5d8a72-64bf-4fb1-975a-9e8dae4f49cd'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '6f5d8a72-64bf-4fb1-975a-9e8dae4f49cd'
FROM pieces p
WHERE p.composer_id = 85 AND p.title = '슬로바키아 민요에 의한 3개의 론도' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '6f5d8a72-64bf-4fb1-975a-9e8dae4f49cd'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:b1b10d25-6964-4ef4-a413-4b4622b92319', 1, NULL, 'Andante', 'Andante', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 85 AND p.title = '슬로바키아 민요에 의한 3개의 론도' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:b1b10d25-6964-4ef4-a413-4b4622b92319'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:a91dddd7-f137-4730-8138-0a7daf997d13', 2, NULL, 'Vivacissimo', 'Vivacissimo', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 85 AND p.title = '슬로바키아 민요에 의한 3개의 론도' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:a91dddd7-f137-4730-8138-0a7daf997d13'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:8114dd66-639c-4b88-b49c-1f67803b75d5', 3, NULL, 'Allegro molto', 'Allegro molto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 85 AND p.title = '슬로바키아 민요에 의한 3개의 론도' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:8114dd66-639c-4b88-b49c-1f67803b75d5'
);


-- Sz. 85 현악 4중주 3번

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '현악 4중주 3번', 'String Quartet No. 3', 'album', 'Sz. 85', NULL, NULL, 1927, 'manual', 1
FROM composers c
WHERE c.id = 85
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '현악 4중주 3번'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '0bf8e91b-eab2-37d0-8b9a-e182d060790f'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '0bf8e91b-eab2-37d0-8b9a-e182d060790f'
FROM pieces p
WHERE p.composer_id = 85 AND p.title = '현악 4중주 3번' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '0bf8e91b-eab2-37d0-8b9a-e182d060790f'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:8696d19d-a272-3662-9451-c535ec5314c0', 1, 'I', 'Prima parte. Moderato', 'I. Prima parte. Moderato', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 85 AND p.title = '현악 4중주 3번' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:8696d19d-a272-3662-9451-c535ec5314c0'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:6017b9e9-089d-3ac3-b163-b45f4f7c69c5', 2, 'II', 'Seconda parte. Allegro', 'II. Seconda parte. Allegro', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 85 AND p.title = '현악 4중주 3번' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:6017b9e9-089d-3ac3-b163-b45f4f7c69c5'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:09c86e50-b3a5-3c09-bc0b-d6d21e32845e', 3, 'III', 'Ricapitulazione della prima parte. Moderato', 'III. Ricapitulazione della prima parte. Moderato', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 85 AND p.title = '현악 4중주 3번' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:09c86e50-b3a5-3c09-bc0b-d6d21e32845e'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:89a2d69d-4b91-306f-9e79-870315a698c4', 4, 'IV', '코다. Allegro molto', 'IV. Coda. Allegro molto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 85 AND p.title = '현악 4중주 3번' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:89a2d69d-4b91-306f-9e79-870315a698c4'
);


-- Sz. 86 바이올린과 피아노를 위한 랩소디 1번

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '바이올린과 피아노를 위한 랩소디 1번', 'Rhapsody No. 1 for Violin and Piano', 'album', 'Sz. 86', NULL, NULL, 1928, 'manual', 1
FROM composers c
WHERE c.id = 85
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '바이올린과 피아노를 위한 랩소디 1번'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'fd2ee809-b132-4b4c-857e-04e9b4bcbaee'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'fd2ee809-b132-4b4c-857e-04e9b4bcbaee'
FROM pieces p
WHERE p.composer_id = 85 AND p.title = '바이올린과 피아노를 위한 랩소디 1번' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'fd2ee809-b132-4b4c-857e-04e9b4bcbaee'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:de2d9ec4-ea5d-4b09-a70b-cf27bc517441', 1, 'I', 'Prima parte "Lassú". Moderato', 'I. Prima parte "Lassú". Moderato', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 85 AND p.title = '바이올린과 피아노를 위한 랩소디 1번' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:de2d9ec4-ea5d-4b09-a70b-cf27bc517441'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:33abd36c-a809-4cc0-a435-802a6701a20d', 2, 'II', 'Seconda parte "Friss". Allegretto moderato', 'II. Seconda parte "Friss". Allegretto moderato', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 85 AND p.title = '바이올린과 피아노를 위한 랩소디 1번' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:33abd36c-a809-4cc0-a435-802a6701a20d'
);


-- Sz. 87 바이올린과 관현악을 위한 랩소디 1번

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '바이올린과 관현악을 위한 랩소디 1번', 'Rhapsody No. 1 for Violin and Orchestra', 'album', 'Sz. 87', NULL, NULL, 1929, 'manual', 1
FROM composers c
WHERE c.id = 85
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '바이올린과 관현악을 위한 랩소디 1번'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '4ee7c8cc-1b97-4049-a873-fc1c59a83f28'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '4ee7c8cc-1b97-4049-a873-fc1c59a83f28'
FROM pieces p
WHERE p.composer_id = 85 AND p.title = '바이올린과 관현악을 위한 랩소디 1번' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '4ee7c8cc-1b97-4049-a873-fc1c59a83f28'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:2c118eec-48cb-442d-b45b-5104b548d119', 1, 'I', 'Prima parte "Lassú". Moderato', 'I. Prima parte "Lassú". Moderato', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 85 AND p.title = '바이올린과 관현악을 위한 랩소디 1번' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:2c118eec-48cb-442d-b45b-5104b548d119'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:d26c2f83-e3b8-40fd-9bff-c0ff16003980', 2, 'II', 'Seconda parte "Friss". Allegretto moderato', 'II. Seconda parte "Friss". Allegretto moderato', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 85 AND p.title = '바이올린과 관현악을 위한 랩소디 1번' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:d26c2f83-e3b8-40fd-9bff-c0ff16003980'
);


-- Sz. 88 첼로와 피아노를 위한 랩소디

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '첼로와 피아노를 위한 랩소디', 'Rhapsody for Cello and Piano', 'album', 'Sz. 88', NULL, NULL, 1929, 'manual', 1
FROM composers c
WHERE c.id = 85
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '첼로와 피아노를 위한 랩소디'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '5d458978-b139-4037-b0f7-716be62ac9e7'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '5d458978-b139-4037-b0f7-716be62ac9e7'
FROM pieces p
WHERE p.composer_id = 85 AND p.title = '첼로와 피아노를 위한 랩소디' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '5d458978-b139-4037-b0f7-716be62ac9e7'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:fc5c30c8-41e1-461c-8ed1-b13262a407c1', 1, 'I', 'Prima parte "Lassú". Moderato', 'I. Prima parte "Lassú". Moderato', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 85 AND p.title = '첼로와 피아노를 위한 랩소디' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:fc5c30c8-41e1-461c-8ed1-b13262a407c1'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:fbbc675f-65f2-4ea6-89cd-ce7969dd9549', 2, 'II', 'Seconda parte "Friss". Allegretto moderato', 'II. Seconda parte "Friss". Allegretto moderato', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 85 AND p.title = '첼로와 피아노를 위한 랩소디' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:fbbc675f-65f2-4ea6-89cd-ce7969dd9549'
);


-- Sz. 89 바이올린과 피아노를 위한 랩소디 2번

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '바이올린과 피아노를 위한 랩소디 2번', 'Rhapsody No. 2 for Violin and Piano', 'album', 'Sz. 89', NULL, NULL, 1928, 'manual', 1
FROM composers c
WHERE c.id = 85
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '바이올린과 피아노를 위한 랩소디 2번'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'a412df25-c5a2-4d1c-a9b8-bac1876fd360'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'a412df25-c5a2-4d1c-a9b8-bac1876fd360'
FROM pieces p
WHERE p.composer_id = 85 AND p.title = '바이올린과 피아노를 위한 랩소디 2번' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'a412df25-c5a2-4d1c-a9b8-bac1876fd360'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:fb8ad4e7-e680-4a58-aa44-ebcfca48af0d', 1, 'I', 'Prima parte "Lassú". Moderato', 'I. Prima parte "Lassú". Moderato', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 85 AND p.title = '바이올린과 피아노를 위한 랩소디 2번' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:fb8ad4e7-e680-4a58-aa44-ebcfca48af0d'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:43201450-6e1b-41ed-9665-98e06cd58457', 2, 'II', 'Seconda parte "Friss". Allegro moderato', 'II. Seconda parte "Friss". Allegro moderato', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 85 AND p.title = '바이올린과 피아노를 위한 랩소디 2번' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:43201450-6e1b-41ed-9665-98e06cd58457'
);


-- Sz. 90 바이올린과 관현악을 위한 랩소디 2번

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '바이올린과 관현악을 위한 랩소디 2번', 'Rhapsody No. 2 for Violin and Orchestra', 'album', 'Sz. 90', NULL, NULL, 1928, 'manual', 1
FROM composers c
WHERE c.id = 85
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '바이올린과 관현악을 위한 랩소디 2번'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '5569d586-503b-43b8-bb34-4e03ec2278ed'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '5569d586-503b-43b8-bb34-4e03ec2278ed'
FROM pieces p
WHERE p.composer_id = 85 AND p.title = '바이올린과 관현악을 위한 랩소디 2번' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '5569d586-503b-43b8-bb34-4e03ec2278ed'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:003fb3bc-d87b-45dd-accc-12a5f2308370', 1, 'I', 'Prima parte "Lassú". Moderato', 'I. Prima parte "Lassú". Moderato', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 85 AND p.title = '바이올린과 관현악을 위한 랩소디 2번' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:003fb3bc-d87b-45dd-accc-12a5f2308370'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:9bbb2984-a2eb-457f-aa09-f0a3e1505310', 2, 'II', 'Seconda parte "Friss". Allegro moderato', 'II. Seconda parte "Friss". Allegro moderato', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 85 AND p.title = '바이올린과 관현악을 위한 랩소디 2번' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:9bbb2984-a2eb-457f-aa09-f0a3e1505310'
);


-- Sz. 91 현악 4중주 4번

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '현악 4중주 4번', 'String Quartet No. 4', 'album', 'Sz. 91', NULL, NULL, 1928, 'manual', 1
FROM composers c
WHERE c.id = 85
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '현악 4중주 4번'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '03dad614-7dce-4de1-9a91-b9fb7c922d47'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '03dad614-7dce-4de1-9a91-b9fb7c922d47'
FROM pieces p
WHERE p.composer_id = 85 AND p.title = '현악 4중주 4번' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '03dad614-7dce-4de1-9a91-b9fb7c922d47'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:6a25bca8-cdda-3a6d-bc60-fc3933c22d4d', 1, 'I', 'Allegro', 'I. Allegro', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 85 AND p.title = '현악 4중주 4번' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:6a25bca8-cdda-3a6d-bc60-fc3933c22d4d'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:1ea0f1f2-0724-3df4-9e4b-2078bedb83c0', 2, 'II', 'Prestissimo, con sordino', 'II. Prestissimo, con sordino', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 85 AND p.title = '현악 4중주 4번' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:1ea0f1f2-0724-3df4-9e4b-2078bedb83c0'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:4c4797ac-de5f-33cf-bd72-0282b432d869', 3, 'III', 'Non troppo lento', 'III. Non troppo lento', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 85 AND p.title = '현악 4중주 4번' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:4c4797ac-de5f-33cf-bd72-0282b432d869'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:76cca2d1-cf28-3836-949b-023e441fa910', 4, 'IV', 'Allegretto pizzicato', 'IV. Allegretto pizzicato', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 85 AND p.title = '현악 4중주 4번' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:76cca2d1-cf28-3836-949b-023e441fa910'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:9d661d64-df16-3204-8cf7-bc932feffc56', 5, 'V', 'Allegro molto', 'V. Allegro molto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 85 AND p.title = '현악 4중주 4번' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:9d661d64-df16-3204-8cf7-bc932feffc56'
);


-- Sz. 92 20개의 헝가리 민요

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '20개의 헝가리 민요', 'Twenty Hungarian Folksongs', 'album', 'Sz. 92', NULL, NULL, 1929, 'manual', 1
FROM composers c
WHERE c.id = 85
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '20개의 헝가리 민요'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '384d03dc-9f3c-44e0-bf65-33f8ba6e0458'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '384d03dc-9f3c-44e0-bf65-33f8ba6e0458'
FROM pieces p
WHERE p.composer_id = 85 AND p.title = '20개의 헝가리 민요' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '384d03dc-9f3c-44e0-bf65-33f8ba6e0458'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:652c9bdc-2283-436a-bd56-a1c20d8bafe1', 1, NULL, 'A tömlöcben', 'A tömlöcben (In Prison)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 85 AND p.title = '20개의 헝가리 민요' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:652c9bdc-2283-436a-bd56-a1c20d8bafe1'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:158ed4c8-fc70-4220-9d43-c6c9829f7eed', 2, NULL, 'Régi keserves', 'Régi keserves (Old Lament)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 85 AND p.title = '20개의 헝가리 민요' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:158ed4c8-fc70-4220-9d43-c6c9829f7eed'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:b936ef1f-bc85-4d03-a94c-e85e55499db0', 3, NULL, 'Bujdosó ének', 'Bujdosó ének (The Fugitive)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 85 AND p.title = '20개의 헝가리 민요' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:b936ef1f-bc85-4d03-a94c-e85e55499db0'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:dbc1dff6-07f5-4cf8-9fa8-1df25bb9b317', 4, NULL, 'Pásztornóta', 'Pásztornóta (Herdsman''s Song)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 85 AND p.title = '20개의 헝가리 민요' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:dbc1dff6-07f5-4cf8-9fa8-1df25bb9b317'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:b63d274c-14e4-4872-8571-be8e4214c080', 5, NULL, 'Székely „lassú”', 'Székely „lassú” (Székely Slow Dance)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 85 AND p.title = '20개의 헝가리 민요' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:b63d274c-14e4-4872-8571-be8e4214c080'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:8abfc778-8126-4b36-a0ec-fa483d423e05', 6, NULL, 'Székely „friss”', 'Székely „friss” (Székely Fast Dance)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 85 AND p.title = '20개의 헝가리 민요' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:8abfc778-8126-4b36-a0ec-fa483d423e05'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:5fb44ecd-c229-4c7e-81fa-fa2f35ef363b', 7, NULL, 'Kanásztánc', 'Kanásztánc (Swineherd''s Dance)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 85 AND p.title = '20개의 헝가리 민요' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:5fb44ecd-c229-4c7e-81fa-fa2f35ef363b'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:6a0c1c24-ca6c-4a43-8818-619056a497d6', 8, NULL, '„Hatforintos” nóta', '„Hatforintos” nóta (Six-Florin Dance)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 85 AND p.title = '20개의 헝가리 민요' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:6a0c1c24-ca6c-4a43-8818-619056a497d6'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:ea81364a-af86-41e8-ba59-54f1d332c5ba', 9, NULL, 'Juhászcsúfoló', 'Juhászcsúfoló (The Shepherd)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 85 AND p.title = '20개의 헝가리 민요' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:ea81364a-af86-41e8-ba59-54f1d332c5ba'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:d4d0327d-8414-43f4-a456-04ae3c5d64a7', 10, NULL, 'Tréfás nóta', 'Tréfás nóta (Joking Song)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 85 AND p.title = '20개의 헝가리 민요' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:d4d0327d-8414-43f4-a456-04ae3c5d64a7'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:b01c4931-1b56-4d6a-add8-f9f742f272ba', 11, NULL, 'Párosító (1)', 'Párosító (1) (Nuptial Serenade (1))', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 85 AND p.title = '20개의 헝가리 민요' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:b01c4931-1b56-4d6a-add8-f9f742f272ba'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:ab5de988-e29a-41eb-bb3c-3be4de6f857b', 12, NULL, 'Párosító (2)', 'Párosító (2) (Nuptial Serenade (2))', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 85 AND p.title = '20개의 헝가리 민요' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:ab5de988-e29a-41eb-bb3c-3be4de6f857b'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:b2215a77-a0cf-4a19-b203-6a71c6c04052', 13, NULL, 'Pár-ének', 'Pár-ének (Dialogue Song)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 85 AND p.title = '20개의 헝가리 민요' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:b2215a77-a0cf-4a19-b203-6a71c6c04052'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:5786982c-b255-4f09-81fa-4e47d91e72b5', 14, NULL, 'Panasz', 'Panasz (Lament)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 85 AND p.title = '20개의 헝가리 민요' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:5786982c-b255-4f09-81fa-4e47d91e72b5'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:af1f04cb-210f-4242-89f6-687de0bb6c89', 15, NULL, 'Bordal', 'Bordal (Drinking Song)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 85 AND p.title = '20개의 헝가리 민요' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:af1f04cb-210f-4242-89f6-687de0bb6c89'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:bb116c6b-f10a-4a7f-a577-33dc5dd519f3', 16, NULL, 'Hej, édesanyám', 'Hej, édesanyám', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 85 AND p.title = '20개의 헝가리 민요' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:bb116c6b-f10a-4a7f-a577-33dc5dd519f3'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:62c46711-d21f-443e-a2e1-b584cd59e6ca', 17, NULL, 'Érik a ropogós cseresznye', 'Érik a ropogós cseresznye', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 85 AND p.title = '20개의 헝가리 민요' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:62c46711-d21f-443e-a2e1-b584cd59e6ca'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:aa156dbe-b372-4b58-92c9-d4d5beeb7542', 18, NULL, 'Már Dobozon régen leesett a hó', 'Már Dobozon régen leesett a hó', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 85 AND p.title = '20개의 헝가리 민요' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:aa156dbe-b372-4b58-92c9-d4d5beeb7542'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:ebd54dbe-604f-489d-b2b9-8fcb0b22c8fd', 19, NULL, 'Sárga kukoricaszár', 'Sárga kukoricaszár', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 85 AND p.title = '20개의 헝가리 민요' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:ebd54dbe-604f-489d-b2b9-8fcb0b22c8fd'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:f5425540-5435-493e-9059-9424a0c21ea5', 20, NULL, 'Búza, búza, búza', 'Búza, búza, búza', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 85 AND p.title = '20개의 헝가리 민요' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:f5425540-5435-493e-9059-9424a0c21ea5'
);


-- Sz. 94 칸타타 프로파나

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '칸타타 프로파나', 'Cantata profana (The Nine Enchanted Stags)', 'song', 'Sz. 94', NULL, NULL, 1930, 'manual', 1
FROM composers c
WHERE c.id = 85
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '칸타타 프로파나'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '9c4fe133-874c-4024-ae39-6d58a1e44514'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '9c4fe133-874c-4024-ae39-6d58a1e44514'
FROM pieces p
WHERE p.composer_id = 85 AND p.title = '칸타타 프로파나' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '9c4fe133-874c-4024-ae39-6d58a1e44514'
);


-- Sz. 95 피아노 협주곡 2번

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '피아노 협주곡 2번', 'Piano Concerto No. 2', 'album', 'Sz. 95', NULL, NULL, 1931, 'manual', 1
FROM composers c
WHERE c.id = 85
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '피아노 협주곡 2번'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'eb8c4dab-fb27-46d3-a018-25e250905042'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'eb8c4dab-fb27-46d3-a018-25e250905042'
FROM pieces p
WHERE p.composer_id = 85 AND p.title = '피아노 협주곡 2번' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'eb8c4dab-fb27-46d3-a018-25e250905042'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:3a16a450-7a60-3066-b16d-b636de9aeb27', 1, 'I', 'Allegro', 'I. Allegro', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 85 AND p.title = '피아노 협주곡 2번' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:3a16a450-7a60-3066-b16d-b636de9aeb27'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:e55e68c6-b032-32ec-a15f-8520d9ea30d6', 2, 'II', 'Adagio – Più adagio – Presto', 'II. Adagio – Più adagio – Presto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 85 AND p.title = '피아노 협주곡 2번' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:e55e68c6-b032-32ec-a15f-8520d9ea30d6'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:2ce8314c-efbb-308a-a4c4-df54c6b1f6c0', 3, 'III', 'Allegro molto', 'III. Allegro molto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 85 AND p.title = '피아노 협주곡 2번' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:2ce8314c-efbb-308a-a4c4-df54c6b1f6c0'
);


-- Sz. 96 트란실바니아 무곡

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '트란실바니아 무곡', 'Transylvanian Dances', 'album', 'Sz. 96', NULL, NULL, 1931, 'manual', 1
FROM composers c
WHERE c.id = 85
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '트란실바니아 무곡'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '91937d6e-c9b5-4dbc-b8ef-00c874571310'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '91937d6e-c9b5-4dbc-b8ef-00c874571310'
FROM pieces p
WHERE p.composer_id = 85 AND p.title = '트란실바니아 무곡' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '91937d6e-c9b5-4dbc-b8ef-00c874571310'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:0484ee5e-e610-4b14-a3f0-c81c89279af8', 1, 'I', 'Bagpipers. Allegretto', 'I. Bagpipers (Dudások). Allegretto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 85 AND p.title = '트란실바니아 무곡' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:0484ee5e-e610-4b14-a3f0-c81c89279af8'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:b055130a-73c7-48c3-a57c-4f0b6b5a4a60', 2, 'II', 'Bear Dance', 'II. Bear Dance (Medvetánc)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 85 AND p.title = '트란실바니아 무곡' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:b055130a-73c7-48c3-a57c-4f0b6b5a4a60'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:7bfb7b85-30a3-4f95-9581-69426d83b011', 3, 'III', '피날레', 'III. Finale', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 85 AND p.title = '트란실바니아 무곡' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:7bfb7b85-30a3-4f95-9581-69426d83b011'
);


-- Sz. 97 헝가리 스케치

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '헝가리 스케치', 'Hungarian Sketches (Hungarian Pictures)', 'album', 'Sz. 97', NULL, NULL, 1931, 'manual', 1
FROM composers c
WHERE c.id = 85
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '헝가리 스케치'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'ab7b3457-eaf9-47bc-b6d6-3d1c6f777a95'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'ab7b3457-eaf9-47bc-b6d6-3d1c6f777a95'
FROM pieces p
WHERE p.composer_id = 85 AND p.title = '헝가리 스케치' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'ab7b3457-eaf9-47bc-b6d6-3d1c6f777a95'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:e72084e5-b85f-3bab-a265-423e66de4e76', 1, NULL, 'An Evening in the Village', 'An Evening in the Village', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 85 AND p.title = '헝가리 스케치' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:e72084e5-b85f-3bab-a265-423e66de4e76'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:1b349c3f-3994-3d68-957c-61dba4a95f0b', 2, NULL, 'Bear Dance', 'Bear Dance', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 85 AND p.title = '헝가리 스케치' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:1b349c3f-3994-3d68-957c-61dba4a95f0b'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:8db56c1d-77e6-3f36-adcf-9fd9334b7b9f', 3, NULL, 'Melody', 'Melody', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 85 AND p.title = '헝가리 스케치' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:8db56c1d-77e6-3f36-adcf-9fd9334b7b9f'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:76d031a1-31c8-343c-9500-3a2c4dc5078a', 4, NULL, 'Slightly Tipsy', 'Slightly Tipsy', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 85 AND p.title = '헝가리 스케치' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:76d031a1-31c8-343c-9500-3a2c4dc5078a'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:7df151a3-b5ce-3471-a04f-b4b1b19a7a65', 5, NULL, 'Swineherd''s Dance', 'Swineherd''s Dance', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 85 AND p.title = '헝가리 스케치' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:7df151a3-b5ce-3471-a04f-b4b1b19a7a65'
);


-- Sz. 98 두 대의 바이올린을 위한 44개의 2중주

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '두 대의 바이올린을 위한 44개의 2중주', '44 Duos for Two Violins', 'album', 'Sz. 98', NULL, NULL, 1931, 'manual', 1
FROM composers c
WHERE c.id = 85
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '두 대의 바이올린을 위한 44개의 2중주'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'ebd977ba-55fc-43cb-bf04-4d0e2a757ba3'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'ebd977ba-55fc-43cb-bf04-4d0e2a757ba3'
FROM pieces p
WHERE p.composer_id = 85 AND p.title = '두 대의 바이올린을 위한 44개의 2중주' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'ebd977ba-55fc-43cb-bf04-4d0e2a757ba3'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:b8b2cd4d-fd5b-4897-8d49-373f51c95cd3', 1, NULL, 'Párosító', 'Párosító (Teasing Song)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 85 AND p.title = '두 대의 바이올린을 위한 44개의 2중주' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:b8b2cd4d-fd5b-4897-8d49-373f51c95cd3'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:64baebf1-285e-4ad9-a39d-298c6e3fd84c', 2, NULL, 'Kalamajkó', 'Kalamajkó (Maypole Dance)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 85 AND p.title = '두 대의 바이올린을 위한 44개의 2중주' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:64baebf1-285e-4ad9-a39d-298c6e3fd84c'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:89fd6728-4a38-44f8-a019-0879f9e9144d', 3, NULL, 'Menuetto', 'Menuetto (Minuet)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 85 AND p.title = '두 대의 바이올린을 위한 44개의 2중주' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:89fd6728-4a38-44f8-a019-0879f9e9144d'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:78dad590-37f0-4420-986d-21eb30ae1a5b', 4, NULL, 'Szentivánéji', 'Szentivánéji (Midsummer Night Song)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 85 AND p.title = '두 대의 바이올린을 위한 44개의 2중주' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:78dad590-37f0-4420-986d-21eb30ae1a5b'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:51b2097e-136a-4c84-a880-a0dccb341e75', 5, NULL, 'Tót nóta (1)', 'Tót nóta (1) (Slovakian Song (1))', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 85 AND p.title = '두 대의 바이올린을 위한 44개의 2중주' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:51b2097e-136a-4c84-a880-a0dccb341e75'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:1cfa1a72-ebbb-49ea-9575-5d525898e1a7', 6, NULL, 'Magyar nóta (1)', 'Magyar nóta (1) (Hungarian Song (1))', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 85 AND p.title = '두 대의 바이올린을 위한 44개의 2중주' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:1cfa1a72-ebbb-49ea-9575-5d525898e1a7'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:f19c98fa-5c61-42b1-a338-00e3f3ea63bb', 7, NULL, 'Oláh nóta', 'Oláh nóta (Wallachian Song)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 85 AND p.title = '두 대의 바이올린을 위한 44개의 2중주' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:f19c98fa-5c61-42b1-a338-00e3f3ea63bb'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:225582db-3bc7-4129-912c-af6e50600369', 8, NULL, 'Tót nóta (2)', 'Tót nóta (2) (Slovakian Song (2))', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 85 AND p.title = '두 대의 바이올린을 위한 44개의 2중주' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:225582db-3bc7-4129-912c-af6e50600369'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:989f03bc-b5be-4758-8ff4-c02df4eb451a', 9, NULL, 'Játék', 'Játék (Play Song)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 85 AND p.title = '두 대의 바이올린을 위한 44개의 2중주' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:989f03bc-b5be-4758-8ff4-c02df4eb451a'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:a569915e-719c-406a-b8de-305183a61e75', 10, NULL, 'Rutén nóta', 'Rutén nóta (Ruthenian Song)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 85 AND p.title = '두 대의 바이올린을 위한 44개의 2중주' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:a569915e-719c-406a-b8de-305183a61e75'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:22776e6f-0cbb-41ff-9b15-554791993a93', 11, NULL, 'Gyermekrengetéskor', 'Gyermekrengetéskor (Cradle Song)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 85 AND p.title = '두 대의 바이올린을 위한 44개의 2중주' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:22776e6f-0cbb-41ff-9b15-554791993a93'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:e58feccb-4938-4653-b810-2f4a9e879ebc', 12, NULL, 'Szénagyűjtéskor', 'Szénagyűjtéskor (Hay Song)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 85 AND p.title = '두 대의 바이올린을 위한 44개의 2중주' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:e58feccb-4938-4653-b810-2f4a9e879ebc'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:31ef3452-9b8b-476d-858b-ad483824182a', 13, NULL, 'Lakodalmas', 'Lakodalmas (Wedding Song)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 85 AND p.title = '두 대의 바이올린을 위한 44개의 2중주' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:31ef3452-9b8b-476d-858b-ad483824182a'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:2f6659c2-6ac0-46ca-b26c-0dd63854e595', 14, NULL, 'Párnás tánc', 'Párnás tánc (Pillow Dance)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 85 AND p.title = '두 대의 바이올린을 위한 44개의 2중주' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:2f6659c2-6ac0-46ca-b26c-0dd63854e595'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:f797a503-9fff-4711-9a57-9e94bd971b5f', 15, NULL, 'Katonanóta', 'Katonanóta (Soldiers'' Song)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 85 AND p.title = '두 대의 바이올린을 위한 44개의 2중주' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:f797a503-9fff-4711-9a57-9e94bd971b5f'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:cc21dccc-ad9d-4a45-a4ae-df015f6cbf76', 16, NULL, 'Burleszk', 'Burleszk (Burlesque)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 85 AND p.title = '두 대의 바이올린을 위한 44개의 2중주' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:cc21dccc-ad9d-4a45-a4ae-df015f6cbf76'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:fd14c067-2e82-49d9-bf97-836bdbc04986', 17, NULL, 'Menetelő nóta (1)', 'Menetelő nóta (1) (Hungarian March (1))', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 85 AND p.title = '두 대의 바이올린을 위한 44개의 2중주' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:fd14c067-2e82-49d9-bf97-836bdbc04986'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:ff7b58d2-de5d-44f4-aa09-e66ecf8f6d0d', 18, NULL, 'Menetelő nóta (2)', 'Menetelő nóta (2) (Hungarian March (2))', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 85 AND p.title = '두 대의 바이올린을 위한 44개의 2중주' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:ff7b58d2-de5d-44f4-aa09-e66ecf8f6d0d'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:fda36278-0721-441f-927f-34c6e794d25f', 19, NULL, 'Mese', 'Mese (Fairy Tale)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 85 AND p.title = '두 대의 바이올린을 위한 44개의 2중주' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:fda36278-0721-441f-927f-34c6e794d25f'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:04594b37-2a0a-442a-b854-d1b8abccc499', 20, NULL, 'Dal', 'Dal (A Rhythm Song)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 85 AND p.title = '두 대의 바이올린을 위한 44개의 2중주' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:04594b37-2a0a-442a-b854-d1b8abccc499'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:95423296-3e39-408c-8095-63c8ef626120', 21, NULL, 'Újévköszöntő (1)', 'Újévköszöntő (1) (New Year''s Greeting (1))', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 85 AND p.title = '두 대의 바이올린을 위한 44개의 2중주' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:95423296-3e39-408c-8095-63c8ef626120'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:b083c19f-fff5-4158-af27-7cfc307567e5', 22, NULL, 'Szúnyogtánc', 'Szúnyogtánc (Mosquito Dance)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 85 AND p.title = '두 대의 바이올린을 위한 44개의 2중주' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:b083c19f-fff5-4158-af27-7cfc307567e5'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:0d54aab1-8e7b-4dc6-af3b-7f64f7696013', 23, NULL, 'Menyasszonybúcsúztató', 'Menyasszonybúcsúztató (Bride''s Farewell)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 85 AND p.title = '두 대의 바이올린을 위한 44개의 2중주' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:0d54aab1-8e7b-4dc6-af3b-7f64f7696013'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:9e1c5a41-afef-4206-bc45-0f7cc13e185a', 24, NULL, 'Tréfás nóta', 'Tréfás nóta (Comic Song)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 85 AND p.title = '두 대의 바이올린을 위한 44개의 2중주' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:9e1c5a41-afef-4206-bc45-0f7cc13e185a'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:5a466ddd-4700-44b0-8f9a-da47f5b66dac', 25, NULL, 'Magyar nóta (2)', 'Magyar nóta (2) (Hungarian Song (2))', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 85 AND p.title = '두 대의 바이올린을 위한 44개의 2중주' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:5a466ddd-4700-44b0-8f9a-da47f5b66dac'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:546a21cc-75b0-46cf-9725-7680c27f0bc5', 26, NULL, '"Ugyan édes komámasszony…"', '"Ugyan édes komámasszony…" (Teasing Song)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 85 AND p.title = '두 대의 바이올린을 위한 44개의 2중주' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:546a21cc-75b0-46cf-9725-7680c27f0bc5'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:5bcdd12c-1d3e-44bf-82e8-95a1ae92e7d1', 27, NULL, 'Sánta-tánc', 'Sánta-tánc (Limping Dance)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 85 AND p.title = '두 대의 바이올린을 위한 44개의 2중주' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:5bcdd12c-1d3e-44bf-82e8-95a1ae92e7d1'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:451f6dc9-24c1-442c-b1cd-990d0f8cf67d', 28, NULL, 'Bánkódás', 'Bánkódás (Sorrow)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 85 AND p.title = '두 대의 바이올린을 위한 44개의 2중주' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:451f6dc9-24c1-442c-b1cd-990d0f8cf67d'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:b3f8265f-6d0c-4f56-8d12-0260a2275b52', 29, NULL, 'Újévköszöntő (2)', 'Újévköszöntő (2) (New Year''s Greeting (2))', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 85 AND p.title = '두 대의 바이올린을 위한 44개의 2중주' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:b3f8265f-6d0c-4f56-8d12-0260a2275b52'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:53faf234-d158-4008-8ec9-63b14b7e87f7', 30, NULL, 'Újévköszöntő (3)', 'Újévköszöntő (3) (New Year''s Greeting (3))', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 85 AND p.title = '두 대의 바이올린을 위한 44개의 2중주' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:53faf234-d158-4008-8ec9-63b14b7e87f7'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:04c0fe13-a346-4130-9083-02e93423c727', 31, NULL, 'Újévköszöntő (4)', 'Újévköszöntő (4) (New Year''s Greeting (4))', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 85 AND p.title = '두 대의 바이올린을 위한 44개의 2중주' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:04c0fe13-a346-4130-9083-02e93423c727'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:a0b24bab-4e94-4062-9292-1878b2193257', 32, NULL, 'Máramarosi tánc', 'Máramarosi tánc (Dance from Máramaros)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 85 AND p.title = '두 대의 바이올린을 위한 44개의 2중주' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:a0b24bab-4e94-4062-9292-1878b2193257'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:12022ff3-01fb-4630-8ad3-2a61a7a345ea', 33, NULL, 'Aratáskor', 'Aratáskor (Harvest Song)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 85 AND p.title = '두 대의 바이올린을 위한 44개의 2중주' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:12022ff3-01fb-4630-8ad3-2a61a7a345ea'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:bdc2928f-e20d-46d4-b2f7-06b9d73358dc', 34, NULL, 'Számláló nóta', 'Számláló nóta (Enumerating Song)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 85 AND p.title = '두 대의 바이올린을 위한 44개의 2중주' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:bdc2928f-e20d-46d4-b2f7-06b9d73358dc'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:c21292f8-685d-4541-b68e-264e0d2be88c', 35, NULL, 'Rutén kolomejka', 'Rutén kolomejka (Ruthenian Kolomejka)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 85 AND p.title = '두 대의 바이올린을 위한 44개의 2중주' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:c21292f8-685d-4541-b68e-264e0d2be88c'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:c5cea584-fc8a-421c-bbfa-0982c19a0e5b', 36, NULL, 'Szól a duda', 'Szól a duda (Bagpipes)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 85 AND p.title = '두 대의 바이올린을 위한 44개의 2중주' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:c5cea584-fc8a-421c-bbfa-0982c19a0e5b'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:19bcd0be-fdee-4cd6-bdd7-dd8f4332853a', 37, NULL, 'Preludium és kánon', 'Preludium és kánon (Prelude and Canon)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 85 AND p.title = '두 대의 바이올린을 위한 44개의 2중주' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:19bcd0be-fdee-4cd6-bdd7-dd8f4332853a'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:8a3a4e90-7901-4f7d-a725-b9bfb8a6c203', 38, NULL, 'Forgatós', 'Forgatós (Romanian Whirling Dance)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 85 AND p.title = '두 대의 바이올린을 위한 44개의 2중주' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:8a3a4e90-7901-4f7d-a725-b9bfb8a6c203'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:b22762de-b858-499d-b631-e25dd300056b', 39, NULL, 'Szerb tánc', 'Szerb tánc (Serbian Dance)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 85 AND p.title = '두 대의 바이올린을 위한 44개의 2중주' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:b22762de-b858-499d-b631-e25dd300056b'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:15e23ffa-bbab-4f65-933c-0387fcd4f1b7', 40, NULL, 'Oláh tánc', 'Oláh tánc (Wallachian Dance)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 85 AND p.title = '두 대의 바이올린을 위한 44개의 2중주' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:15e23ffa-bbab-4f65-933c-0387fcd4f1b7'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:bd222a61-adfa-46cf-a7d2-187fd69d742c', 41, NULL, 'Scherzo', 'Scherzo', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 85 AND p.title = '두 대의 바이올린을 위한 44개의 2중주' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:bd222a61-adfa-46cf-a7d2-187fd69d742c'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:df72c365-9bf0-499e-8f90-550c503fab87', 42, NULL, 'Arab dal', 'Arab dal (Arabian Song)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 85 AND p.title = '두 대의 바이올린을 위한 44개의 2중주' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:df72c365-9bf0-499e-8f90-550c503fab87'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:2bff7e5f-39d2-4606-835d-1df92341af66', 43, NULL, 'Pizzicato', 'Pizzicato', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 85 AND p.title = '두 대의 바이올린을 위한 44개의 2중주' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:2bff7e5f-39d2-4606-835d-1df92341af66'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:92150078-659e-4e03-99b7-52dc5709619e', 44, NULL, '"Erdélyi" tánc', '"Erdélyi" tánc (Transylvanian Dance)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 85 AND p.title = '두 대의 바이올린을 위한 44개의 2중주' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:92150078-659e-4e03-99b7-52dc5709619e'
);


-- Sz. 100 관현악을 위한 헝가리 농민의 노래

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '관현악을 위한 헝가리 농민의 노래', 'Hungarian Peasant Songs for Orchestra', 'album', 'Sz. 100', NULL, NULL, 1933, 'manual', 1
FROM composers c
WHERE c.id = 85
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '관현악을 위한 헝가리 농민의 노래'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '85ad49f4-993b-41bd-a3e4-ce8b53907ed4'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '85ad49f4-993b-41bd-a3e4-ce8b53907ed4'
FROM pieces p
WHERE p.composer_id = 85 AND p.title = '관현악을 위한 헝가리 농민의 노래' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '85ad49f4-993b-41bd-a3e4-ce8b53907ed4'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:6c5b6dfa-31df-42d4-bb4e-6d2822614eda', 1, 'I', '발라드', 'I. Ballade', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 85 AND p.title = '관현악을 위한 헝가리 농민의 노래' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:6c5b6dfa-31df-42d4-bb4e-6d2822614eda'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:e0b8b0cc-c7ca-4236-8cb8-6a895865cdce', 2, 'II', '헝가리 농민 무곡', 'II. Hungarian Peasant Dances', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 85 AND p.title = '관현악을 위한 헝가리 농민의 노래' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:e0b8b0cc-c7ca-4236-8cb8-6a895865cdce'
);


-- Sz. 101 성악과 관현악을 위한 5개의 헝가리 민요

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '성악과 관현악을 위한 5개의 헝가리 민요', 'Five Hungarian Folksongs for Voice and Orchestra', 'album', 'Sz. 101', NULL, NULL, 1933, 'manual', 1
FROM composers c
WHERE c.id = 85
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '성악과 관현악을 위한 5개의 헝가리 민요'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '8e8e5dbe-2fbf-4d36-9f9e-26dd26473abb'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '8e8e5dbe-2fbf-4d36-9f9e-26dd26473abb'
FROM pieces p
WHERE p.composer_id = 85 AND p.title = '성악과 관현악을 위한 5개의 헝가리 민요' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '8e8e5dbe-2fbf-4d36-9f9e-26dd26473abb'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:9c81eb56-ca1b-42c1-b40a-91e67f49b95e', 1, NULL, 'A tömlöcben', 'A tömlöcben (In Prison)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 85 AND p.title = '성악과 관현악을 위한 5개의 헝가리 민요' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:9c81eb56-ca1b-42c1-b40a-91e67f49b95e'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:b407c94e-661b-459f-b818-616ca0a5a91d', 2, NULL, 'Régi keserves', 'Régi keserves (Old Lament)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 85 AND p.title = '성악과 관현악을 위한 5개의 헝가리 민요' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:b407c94e-661b-459f-b818-616ca0a5a91d'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:f94ee29c-f775-4dd1-8c03-8c676881f6aa', 3, NULL, 'Párosító (1)', 'Párosító (1) (Nuptial Serenade 1)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 85 AND p.title = '성악과 관현악을 위한 5개의 헝가리 민요' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:f94ee29c-f775-4dd1-8c03-8c676881f6aa'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:94bf3d4b-cc28-456e-91bf-cf0eecc7662f', 4, NULL, 'Panasz', 'Panasz (Lament)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 85 AND p.title = '성악과 관현악을 위한 5개의 헝가리 민요' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:94bf3d4b-cc28-456e-91bf-cf0eecc7662f'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:e875af0f-e016-4ccc-ba02-107603862eef', 5, NULL, 'Párosító (2)', 'Párosító (2) (Nuptial Serenade 2)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 85 AND p.title = '성악과 관현악을 위한 5개의 헝가리 민요' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:e875af0f-e016-4ccc-ba02-107603862eef'
);


-- Sz. 102 현악 4중주 5번

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '현악 4중주 5번', 'String Quartet No. 5', 'album', 'Sz. 102', NULL, NULL, 1934, 'manual', 1
FROM composers c
WHERE c.id = 85
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '현악 4중주 5번'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'f36b1df8-c9d8-4cfc-862b-5bbf348e41f9'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'f36b1df8-c9d8-4cfc-862b-5bbf348e41f9'
FROM pieces p
WHERE p.composer_id = 85 AND p.title = '현악 4중주 5번' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'f36b1df8-c9d8-4cfc-862b-5bbf348e41f9'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:8ed2dd06-62ef-3519-9f34-40c4e8ba0008', 1, 'I', 'Allegro', 'I. Allegro', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 85 AND p.title = '현악 4중주 5번' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:8ed2dd06-62ef-3519-9f34-40c4e8ba0008'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:b0644ccc-8041-3075-9dc8-ec8cce8d1d92', 2, 'II', 'Adagio molto', 'II. Adagio molto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 85 AND p.title = '현악 4중주 5번' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:b0644ccc-8041-3075-9dc8-ec8cce8d1d92'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:17ec4ad0-06fd-3f11-bf01-ff38725e6ef2', 3, 'III', '스케르초. Alla bulgarese', 'III. Scherzo. Alla bulgarese', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 85 AND p.title = '현악 4중주 5번' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:17ec4ad0-06fd-3f11-bf01-ff38725e6ef2'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:ac28a220-59de-333b-a313-b96235fc5a9c', 4, 'IV', 'Andante', 'IV. Andante', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 85 AND p.title = '현악 4중주 5번' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:ac28a220-59de-333b-a313-b96235fc5a9c'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:8cdebd45-7560-37bd-b22d-dd8dff91828e', 5, 'V', '피날레. Allegro vivace', 'V. Finale. Allegro vivace', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 85 AND p.title = '현악 4중주 5번' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:8cdebd45-7560-37bd-b22d-dd8dff91828e'
);


-- Sz. 103 27개의 2·3성부 합창곡

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '27개의 2·3성부 합창곡', '27 Two- and Three-Part Choruses', 'album', 'Sz. 103', NULL, NULL, 1936, 'manual', 1
FROM composers c
WHERE c.id = 85
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '27개의 2·3성부 합창곡'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '0949a20d-84c7-48f5-8920-3e096f9aa64c'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '0949a20d-84c7-48f5-8920-3e096f9aa64c'
FROM pieces p
WHERE p.composer_id = 85 AND p.title = '27개의 2·3성부 합창곡' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '0949a20d-84c7-48f5-8920-3e096f9aa64c'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:3c1a00bf-a9c6-4570-b34c-3517aad3d9f1', 1, NULL, 'Tavasz', 'Vol. I, No. 1. Tavasz', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 85 AND p.title = '27개의 2·3성부 합창곡' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:3c1a00bf-a9c6-4570-b34c-3517aad3d9f1'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:278a6899-3edf-491a-b5bc-40e48ab86ebf', 2, NULL, 'Ne hagyj itt!', 'Vol. I, No. 2. Ne hagyj itt!', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 85 AND p.title = '27개의 2·3성부 합창곡' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:278a6899-3edf-491a-b5bc-40e48ab86ebf'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:8d1a332f-f5c6-4f8c-858c-d608e5d5420e', 3, NULL, 'Jószágigéző', 'Vol. I, No. 3. Jószágigéző', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 85 AND p.title = '27개의 2·3성부 합창곡' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:8d1a332f-f5c6-4f8c-858c-d608e5d5420e'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:50f16c0b-a05e-460c-adbe-2331eb2bd81e', 4, NULL, 'Levél az otthoniakhoz', 'Vol. II, No. 1. Levél az otthoniakhoz', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 85 AND p.title = '27개의 2·3성부 합창곡' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:50f16c0b-a05e-460c-adbe-2331eb2bd81e'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:6e0ae12c-02f1-4129-9d6f-62ec914d4e4d', 5, NULL, 'Játék', 'Vol. II, No. 2. Játék', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 85 AND p.title = '27개의 2·3성부 합창곡' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:6e0ae12c-02f1-4129-9d6f-62ec914d4e4d'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:ebe58639-9b57-43b0-91ac-ff4ca830415a', 6, NULL, 'Leánynéző', 'Vol. II, No. 3. Leánynéző', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 85 AND p.title = '27개의 2·3성부 합창곡' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:ebe58639-9b57-43b0-91ac-ff4ca830415a'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:d38b6935-5839-4d56-ac99-f56881aae412', 7, NULL, 'Héjja, héjja, karahéjja', 'Vol. II, No. 4. Héjja, héjja, karahéjja', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 85 AND p.title = '27개의 2·3성부 합창곡' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:d38b6935-5839-4d56-ac99-f56881aae412'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:02cb0089-739a-45b3-af69-69fcf3228ac1', 8, NULL, 'Ne menj el', 'Vol. III, No. 1. Ne menj el', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 85 AND p.title = '27개의 2·3성부 합창곡' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:02cb0089-739a-45b3-af69-69fcf3228ac1'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:9b8597a7-fdaa-41ce-ba54-746d514c9d3a', 9, NULL, 'Van egy gyűrűm, karika', 'Vol. III, No. 2. Van egy gyűrűm, karika', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 85 AND p.title = '27개의 2·3성부 합창곡' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:9b8597a7-fdaa-41ce-ba54-746d514c9d3a'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:ed32bf53-6366-44bc-ab60-1c8cf71af789', 10, NULL, 'Senkim a világon', 'Vol. III, No. 3. Senkim a világon', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 85 AND p.title = '27개의 2·3성부 합창곡' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:ed32bf53-6366-44bc-ab60-1c8cf71af789'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:0718025f-2ba8-4e01-88f0-bb3bfa5a1930', 11, NULL, 'Cipósütés', 'Vol. III, No. 4. Cipósütés', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 85 AND p.title = '27개의 2·3성부 합창곡' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:0718025f-2ba8-4e01-88f0-bb3bfa5a1930'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:bf108c0a-cda1-4adf-8573-09cc12e8e6e5', 12, NULL, 'Huszárnóta', 'Vol. IV, No. 1. Huszárnóta', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 85 AND p.title = '27개의 2·3성부 합창곡' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:bf108c0a-cda1-4adf-8573-09cc12e8e6e5'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:9e21e874-d954-4119-8187-9fd2a8932fd1', 13, NULL, 'Resteknek nótája', 'Vol. IV, No. 2. Resteknek nótája', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 85 AND p.title = '27개의 2·3성부 합창곡' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:9e21e874-d954-4119-8187-9fd2a8932fd1'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:7ec833d0-4744-433a-92d9-1496677ef3c3', 14, NULL, 'Senkim a világon', 'Vol. IV, No. 3. Senkim a világon', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 85 AND p.title = '27개의 2·3성부 합창곡' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:7ec833d0-4744-433a-92d9-1496677ef3c3'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:f805e133-ed6e-40d1-9099-1c44c3abd10e', 15, NULL, 'Leánycsúfoló', 'Vol. IV, No. 4. Leánycsúfoló', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 85 AND p.title = '27개의 2·3성부 합창곡' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:f805e133-ed6e-40d1-9099-1c44c3abd10e'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:87986eee-302d-4f28-b0c9-2bdf96c0093f', 16, NULL, 'Legénycsúfoló', 'Vol. V, No. 1. Legénycsúfoló', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 85 AND p.title = '27개의 2·3성부 합창곡' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:87986eee-302d-4f28-b0c9-2bdf96c0093f'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:7c0dea16-efce-441f-83d0-3ca9ea06d92b', 17, NULL, 'Mihálynapi köszöntő', 'Vol. V, No. 2. Mihálynapi köszöntő', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 85 AND p.title = '27개의 2·3성부 합창곡' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:7c0dea16-efce-441f-83d0-3ca9ea06d92b'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:69934567-6294-4398-b5f7-c01c469576cd', 18, NULL, 'Leánykérő', 'Vol. V, No. 3. Leánykérő', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 85 AND p.title = '27개의 2·3성부 합창곡' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:69934567-6294-4398-b5f7-c01c469576cd'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:013c97a9-ce5d-4860-8ec8-a233ff8595cd', 19, NULL, 'Keserves', 'Vol. VI, No. 1. Keserves', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 85 AND p.title = '27개의 2·3성부 합창곡' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:013c97a9-ce5d-4860-8ec8-a233ff8595cd'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:6506b788-a3bc-4d0e-9813-cce3b5e20ac6', 20, NULL, 'Madárdal', 'Vol. VI, No. 2. Madárdal', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 85 AND p.title = '27개의 2·3성부 합창곡' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:6506b788-a3bc-4d0e-9813-cce3b5e20ac6'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:19436bd4-7c2c-456c-ab51-be6855cf51ea', 21, NULL, 'Csujogató', 'Vol. VI, No. 3. Csujogató', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 85 AND p.title = '27개의 2·3성부 합창곡' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:19436bd4-7c2c-456c-ab51-be6855cf51ea'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:669710cc-5586-4821-b0ba-6e3f05bb7158', 22, NULL, 'Bánat', 'Vol. VII, No. 1. Bánat', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 85 AND p.title = '27개의 2·3성부 합창곡' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:669710cc-5586-4821-b0ba-6e3f05bb7158'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:64ec7126-71e7-4ec2-a48c-7edf3ea43519', 23, NULL, 'Ne láttalak volna', 'Vol. VII, No. 2. Ne láttalak volna', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 85 AND p.title = '27개의 2·3성부 합창곡' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:64ec7126-71e7-4ec2-a48c-7edf3ea43519'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:00b694e2-319f-4843-b45c-f925f87d56c1', 24, NULL, 'Elment a madárka', 'Vol. VII, No. 3. Elment a madárka', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 85 AND p.title = '27개의 2·3성부 합창곡' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:00b694e2-319f-4843-b45c-f925f87d56c1'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:8c7b9a41-7c46-4ec0-a460-1799da45c1aa', 25, NULL, 'Párnás táncdal', 'Vol. VIII, No. 1. Párnás táncdal', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 85 AND p.title = '27개의 2·3성부 합창곡' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:8c7b9a41-7c46-4ec0-a460-1799da45c1aa'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:97034108-5a95-40e9-b634-9dea8cc596c6', 26, NULL, 'Kánon', 'Vol. VIII, No. 2. Kánon', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 85 AND p.title = '27개의 2·3성부 합창곡' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:97034108-5a95-40e9-b634-9dea8cc596c6'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:80349a1f-23cb-4cd2-8125-97bd2d5830b6', 27, NULL, 'Isten veled!', 'Vol. VIII, No. 3. Isten veled!', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 85 AND p.title = '27개의 2·3성부 합창곡' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:80349a1f-23cb-4cd2-8125-97bd2d5830b6'
);


-- Sz. 104 남성 합창을 위한 <옛 시절로부터>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '남성 합창을 위한 <옛 시절로부터>', 'From Olden Times', 'album', 'Sz. 104', NULL, NULL, 1935, 'manual', 1
FROM composers c
WHERE c.id = 85
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '남성 합창을 위한 <옛 시절로부터>'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:5cc84e45-b0bc-4963-a5b2-930bc3c8ba70', 1, NULL, 'Nincs boldogtalanabb', 'Nincs boldogtalanabb', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 85 AND p.title = '남성 합창을 위한 <옛 시절로부터>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:5cc84e45-b0bc-4963-a5b2-930bc3c8ba70'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:fe581e0e-b9e7-4b83-af99-d51cadd84aa5', 2, NULL, 'Egy, kettő, három, négy', 'Egy, kettő, három, négy', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 85 AND p.title = '남성 합창을 위한 <옛 시절로부터>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:fe581e0e-b9e7-4b83-af99-d51cadd84aa5'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:5544585d-e068-4810-93b4-f78a8239b516', 3, NULL, 'Nincsen szerencsésebb', 'Nincsen szerencsésebb', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 85 AND p.title = '남성 합창을 위한 <옛 시절로부터>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:5544585d-e068-4810-93b4-f78a8239b516'
);


-- Sz. 105 작은 모음곡

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '작은 모음곡', 'Petite Suite', 'album', 'Sz. 105', NULL, NULL, 1936, 'manual', 1
FROM composers c
WHERE c.id = 85
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '작은 모음곡'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '48519eba-73b9-4d12-89f8-3273db66479a'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '48519eba-73b9-4d12-89f8-3273db66479a'
FROM pieces p
WHERE p.composer_id = 85 AND p.title = '작은 모음곡' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '48519eba-73b9-4d12-89f8-3273db66479a'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:ccca27dc-bfd5-4141-836b-e39829f4daed', 1, 'I', 'Slow Tune', 'I. Slow Tune', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 85 AND p.title = '작은 모음곡' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:ccca27dc-bfd5-4141-836b-e39829f4daed'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:79165039-270c-4268-9862-6db4dcdba344', 2, 'II', 'Wallachian Dance', 'II. Wallachian Dance', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 85 AND p.title = '작은 모음곡' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:79165039-270c-4268-9862-6db4dcdba344'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:10e01a5f-195c-4426-9c76-85c16b9caebe', 3, 'III', 'Whirling Dance', 'III. Whirling Dance', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 85 AND p.title = '작은 모음곡' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:10e01a5f-195c-4426-9c76-85c16b9caebe'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:e9e6b2d6-ea75-45e4-b137-37956686b46d', 4, 'IV', 'Quasi pizzicato', 'IV. Quasi pizzicato', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 85 AND p.title = '작은 모음곡' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:e9e6b2d6-ea75-45e4-b137-37956686b46d'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:585d9797-293c-48a1-a163-f58597522e42', 5, 'V', 'Ruthenian Dance', 'V. Ruthenian Dance', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 85 AND p.title = '작은 모음곡' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:585d9797-293c-48a1-a163-f58597522e42'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:c8f63be6-4ff4-4c38-96cc-f8709b673988', 6, 'VI', 'Bagpipes', 'VI. Bagpipes', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 85 AND p.title = '작은 모음곡' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:c8f63be6-4ff4-4c38-96cc-f8709b673988'
);


-- Sz. 106 현악기, 타악기, 첼레스타를 위한 음악

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:85af0498-3d32-3498-8245-8fe44358561c', 1, 'I', 'Andante tranquillo', 'I. Andante tranquillo', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 328 AND p.composer_id = 85
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:85af0498-3d32-3498-8245-8fe44358561c'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:eea0433d-5d53-3d92-9cbc-a78644d82fc3', 2, 'II', 'Allegro', 'II. Allegro', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 328 AND p.composer_id = 85
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:eea0433d-5d53-3d92-9cbc-a78644d82fc3'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:8f68c46d-faa8-3062-80f9-e1be8d4527d5', 3, 'III', 'Adagio', 'III. Adagio', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 328 AND p.composer_id = 85
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:8f68c46d-faa8-3062-80f9-e1be8d4527d5'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:44788e71-6f55-389f-a89b-d74363433e9d', 4, 'IV', 'Allegro molto', 'IV. Allegro molto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 328 AND p.composer_id = 85
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:44788e71-6f55-389f-a89b-d74363433e9d'
);


-- Sz. 107 미크로코스모스 (피아노 연습곡집)

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '05e73b3f-7664-4745-ab48-d140dd106a5e'
FROM pieces p
WHERE p.id = 330 AND p.composer_id = 85
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '05e73b3f-7664-4745-ab48-d140dd106a5e'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:38bb7baf-813b-4fbe-83c6-7b61a2dbda75', 1, NULL, '1권 (1–36번)', 'Volume I (Nos. 1–36)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 330 AND p.composer_id = 85
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:38bb7baf-813b-4fbe-83c6-7b61a2dbda75'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:786a4a72-c6b2-404f-85dc-2bf267331790', 1, NULL, 'Six Unison Melodies (1)', 'No. 1. Six Unison Melodies (1)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:38bb7baf-813b-4fbe-83c6-7b61a2dbda75'
WHERE p.id = 330 AND p.composer_id = 85
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:786a4a72-c6b2-404f-85dc-2bf267331790'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:2c368d65-6cf8-45b9-b728-2e3ce1aff7e1', 2, NULL, 'Six Unison Melodies (2)', 'No. 2. Six Unison Melodies (2)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:38bb7baf-813b-4fbe-83c6-7b61a2dbda75'
WHERE p.id = 330 AND p.composer_id = 85
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:2c368d65-6cf8-45b9-b728-2e3ce1aff7e1'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:bd11d0d5-d952-4a45-9a3f-4b57d4de6f8b', 3, NULL, 'Six Unison Melodies (3)', 'No. 3. Six Unison Melodies (3)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:38bb7baf-813b-4fbe-83c6-7b61a2dbda75'
WHERE p.id = 330 AND p.composer_id = 85
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:bd11d0d5-d952-4a45-9a3f-4b57d4de6f8b'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:80c44a5b-7e20-46e0-8f34-20a66acddb5b', 4, NULL, 'Six Unison Melodies (4)', 'No. 4. Six Unison Melodies (4)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:38bb7baf-813b-4fbe-83c6-7b61a2dbda75'
WHERE p.id = 330 AND p.composer_id = 85
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:80c44a5b-7e20-46e0-8f34-20a66acddb5b'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:a856364f-285b-40f3-b74c-f57b233d652f', 5, NULL, 'Six Unison Melodies (5)', 'No. 5. Six Unison Melodies (5)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:38bb7baf-813b-4fbe-83c6-7b61a2dbda75'
WHERE p.id = 330 AND p.composer_id = 85
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:a856364f-285b-40f3-b74c-f57b233d652f'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:062fa153-3867-4848-a07c-2db81300fdaa', 6, NULL, 'Six Unison Melodies (6)', 'No. 6. Six Unison Melodies (6)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:38bb7baf-813b-4fbe-83c6-7b61a2dbda75'
WHERE p.id = 330 AND p.composer_id = 85
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:062fa153-3867-4848-a07c-2db81300fdaa'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:0e402e26-f8bf-42d7-8d33-516bc809f05a', 7, NULL, 'Dotted Notes', 'No. 7. Dotted Notes', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:38bb7baf-813b-4fbe-83c6-7b61a2dbda75'
WHERE p.id = 330 AND p.composer_id = 85
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:0e402e26-f8bf-42d7-8d33-516bc809f05a'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:6e726d4a-5dae-4100-887d-913e8be93a1b', 8, NULL, 'Repetition (1)', 'No. 8. Repetition (1)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:38bb7baf-813b-4fbe-83c6-7b61a2dbda75'
WHERE p.id = 330 AND p.composer_id = 85
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:6e726d4a-5dae-4100-887d-913e8be93a1b'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:5f631ae7-3f4f-4a51-8987-a1c4d7a0cafb', 9, NULL, 'Syncopation (1)', 'No. 9. Syncopation (1)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:38bb7baf-813b-4fbe-83c6-7b61a2dbda75'
WHERE p.id = 330 AND p.composer_id = 85
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:5f631ae7-3f4f-4a51-8987-a1c4d7a0cafb'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:7b976afd-3577-485a-b40f-b6bff07be749', 10, NULL, 'With Alternate Hands', 'No. 10. With Alternate Hands', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:38bb7baf-813b-4fbe-83c6-7b61a2dbda75'
WHERE p.id = 330 AND p.composer_id = 85
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:7b976afd-3577-485a-b40f-b6bff07be749'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:389ba398-7792-4e95-b36c-493af36ba6c3', 11, NULL, 'Parallel Motion', 'No. 11. Parallel Motion', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:38bb7baf-813b-4fbe-83c6-7b61a2dbda75'
WHERE p.id = 330 AND p.composer_id = 85
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:389ba398-7792-4e95-b36c-493af36ba6c3'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:bdf43b88-eb57-4c47-afe1-5108af2c1281', 12, NULL, 'Reflection', 'No. 12. Reflection', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:38bb7baf-813b-4fbe-83c6-7b61a2dbda75'
WHERE p.id = 330 AND p.composer_id = 85
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:bdf43b88-eb57-4c47-afe1-5108af2c1281'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:5c846cba-9cdf-421e-a43a-470e7ef3ee32', 13, NULL, 'Change of Position', 'No. 13. Change of Position', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:38bb7baf-813b-4fbe-83c6-7b61a2dbda75'
WHERE p.id = 330 AND p.composer_id = 85
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:5c846cba-9cdf-421e-a43a-470e7ef3ee32'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:bbc5983e-bc90-4d03-ad25-e029f60a214a', 14, NULL, 'Question and Answer', 'No. 14. Question and Answer', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:38bb7baf-813b-4fbe-83c6-7b61a2dbda75'
WHERE p.id = 330 AND p.composer_id = 85
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:bbc5983e-bc90-4d03-ad25-e029f60a214a'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:3af426e8-a401-4787-a20f-a5092bcffcfb', 15, NULL, 'Village Song', 'No. 15. Village Song', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:38bb7baf-813b-4fbe-83c6-7b61a2dbda75'
WHERE p.id = 330 AND p.composer_id = 85
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:3af426e8-a401-4787-a20f-a5092bcffcfb'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:d744b263-f62c-4a2c-8d96-0c2eefdf5ebc', 16, NULL, 'Parallel Motion with Change of Position', 'No. 16. Parallel Motion with Change of Position', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:38bb7baf-813b-4fbe-83c6-7b61a2dbda75'
WHERE p.id = 330 AND p.composer_id = 85
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:d744b263-f62c-4a2c-8d96-0c2eefdf5ebc'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:e8cb5fa0-b636-4054-9799-bcec2dc7d151', 17, NULL, 'Contrary Motion', 'No. 17. Contrary Motion', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:38bb7baf-813b-4fbe-83c6-7b61a2dbda75'
WHERE p.id = 330 AND p.composer_id = 85
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:e8cb5fa0-b636-4054-9799-bcec2dc7d151'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:7099bf2b-60a1-4fb8-9ac6-864fe1a2820b', 18, NULL, 'Four Unison Melodies (1)', 'No. 18. Four Unison Melodies (1)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:38bb7baf-813b-4fbe-83c6-7b61a2dbda75'
WHERE p.id = 330 AND p.composer_id = 85
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:7099bf2b-60a1-4fb8-9ac6-864fe1a2820b'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:7f912e5c-8ae5-49f5-b1a3-35be85399926', 19, NULL, 'Four Unison Melodies (2)', 'No. 19. Four Unison Melodies (2)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:38bb7baf-813b-4fbe-83c6-7b61a2dbda75'
WHERE p.id = 330 AND p.composer_id = 85
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:7f912e5c-8ae5-49f5-b1a3-35be85399926'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:2ec38eb7-4310-4689-8dd9-572a0c3806cd', 20, NULL, 'Four Unison Melodies (3)', 'No. 20. Four Unison Melodies (3)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:38bb7baf-813b-4fbe-83c6-7b61a2dbda75'
WHERE p.id = 330 AND p.composer_id = 85
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:2ec38eb7-4310-4689-8dd9-572a0c3806cd'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:f167b1cf-bf5c-4f2b-8f3f-ddd9c2b873b8', 21, NULL, 'Four Unison Melodies (4)', 'No. 21. Four Unison Melodies (4)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:38bb7baf-813b-4fbe-83c6-7b61a2dbda75'
WHERE p.id = 330 AND p.composer_id = 85
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:f167b1cf-bf5c-4f2b-8f3f-ddd9c2b873b8'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:4f7ce69c-c520-4630-98fe-7af5d2f8c38e', 22, NULL, 'Imitation and Counterpoint', 'No. 22. Imitation and Counterpoint', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:38bb7baf-813b-4fbe-83c6-7b61a2dbda75'
WHERE p.id = 330 AND p.composer_id = 85
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:4f7ce69c-c520-4630-98fe-7af5d2f8c38e'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:45630d93-7d78-4506-baa6-17fcf0a1bc5f', 23, NULL, 'Imitation and Inversion (1)', 'No. 23. Imitation and Inversion (1)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:38bb7baf-813b-4fbe-83c6-7b61a2dbda75'
WHERE p.id = 330 AND p.composer_id = 85
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:45630d93-7d78-4506-baa6-17fcf0a1bc5f'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:398a41bd-672b-432a-b5df-1a50a1b9ea48', 24, NULL, 'Pastorale', 'No. 24. Pastorale', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:38bb7baf-813b-4fbe-83c6-7b61a2dbda75'
WHERE p.id = 330 AND p.composer_id = 85
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:398a41bd-672b-432a-b5df-1a50a1b9ea48'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:8b1d1d3a-21f6-42b1-b3e4-fdead955ab9b', 25, NULL, 'Imitation and Inversion (2)', 'No. 25. Imitation and Inversion (2)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:38bb7baf-813b-4fbe-83c6-7b61a2dbda75'
WHERE p.id = 330 AND p.composer_id = 85
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:8b1d1d3a-21f6-42b1-b3e4-fdead955ab9b'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:fe203563-5177-4c94-b8bb-bc07e3675636', 26, NULL, 'Repetition (2)', 'No. 26. Repetition (2)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:38bb7baf-813b-4fbe-83c6-7b61a2dbda75'
WHERE p.id = 330 AND p.composer_id = 85
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:fe203563-5177-4c94-b8bb-bc07e3675636'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:14f53b07-01f6-4367-a76f-3ae9d14d07a9', 27, NULL, 'Syncopation (2)', 'No. 27. Syncopation (2)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:38bb7baf-813b-4fbe-83c6-7b61a2dbda75'
WHERE p.id = 330 AND p.composer_id = 85
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:14f53b07-01f6-4367-a76f-3ae9d14d07a9'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:e4e57064-8b17-4edd-9e1e-545a401c7c18', 28, NULL, 'Canon at the Octave', 'No. 28. Canon at the Octave', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:38bb7baf-813b-4fbe-83c6-7b61a2dbda75'
WHERE p.id = 330 AND p.composer_id = 85
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:e4e57064-8b17-4edd-9e1e-545a401c7c18'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:f7f1dadd-c370-41ea-ad6c-89eafe0a4eea', 29, NULL, 'Imitation Reflected', 'No. 29. Imitation Reflected', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:38bb7baf-813b-4fbe-83c6-7b61a2dbda75'
WHERE p.id = 330 AND p.composer_id = 85
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:f7f1dadd-c370-41ea-ad6c-89eafe0a4eea'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:5ef31734-307a-4de0-b382-09d7f264be31', 30, NULL, 'Canon at the Lower Fifth', 'No. 30. Canon at the Lower Fifth', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:38bb7baf-813b-4fbe-83c6-7b61a2dbda75'
WHERE p.id = 330 AND p.composer_id = 85
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:5ef31734-307a-4de0-b382-09d7f264be31'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:df85b8b3-6ae9-4e0d-8646-fc7ba7711b3d', 31, NULL, 'Dance in Canon Form', 'No. 31. Dance in Canon Form', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:38bb7baf-813b-4fbe-83c6-7b61a2dbda75'
WHERE p.id = 330 AND p.composer_id = 85
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:df85b8b3-6ae9-4e0d-8646-fc7ba7711b3d'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:116f90c3-aa52-491e-b373-0ffbd66e0d51', 32, NULL, 'In Dorian Mode', 'No. 32. In Dorian Mode', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:38bb7baf-813b-4fbe-83c6-7b61a2dbda75'
WHERE p.id = 330 AND p.composer_id = 85
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:116f90c3-aa52-491e-b373-0ffbd66e0d51'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:c23572e9-99f4-40d7-828f-5c14f2f12645', 33, NULL, 'Slow Dance', 'No. 33. Slow Dance', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:38bb7baf-813b-4fbe-83c6-7b61a2dbda75'
WHERE p.id = 330 AND p.composer_id = 85
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:c23572e9-99f4-40d7-828f-5c14f2f12645'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:8d86889a-d235-4d33-a650-0071e05dfc80', 34, NULL, 'In Phrygian Mode', 'No. 34. In Phrygian Mode', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:38bb7baf-813b-4fbe-83c6-7b61a2dbda75'
WHERE p.id = 330 AND p.composer_id = 85
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:8d86889a-d235-4d33-a650-0071e05dfc80'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:bc783d4b-144a-41a8-9a64-4e6bbe7a0686', 35, NULL, 'Chorale', 'No. 35. Chorale', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:38bb7baf-813b-4fbe-83c6-7b61a2dbda75'
WHERE p.id = 330 AND p.composer_id = 85
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:bc783d4b-144a-41a8-9a64-4e6bbe7a0686'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:081d9b54-c796-438c-bf36-32a1c9ee10d4', 36, NULL, 'Free Canon', 'No. 36. Free Canon', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:38bb7baf-813b-4fbe-83c6-7b61a2dbda75'
WHERE p.id = 330 AND p.composer_id = 85
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:081d9b54-c796-438c-bf36-32a1c9ee10d4'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:458067e9-3cb2-433e-a36b-5f01573a81a6', 2, NULL, '2권 (37–66번)', 'Volume II (Nos. 37–66)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 330 AND p.composer_id = 85
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:458067e9-3cb2-433e-a36b-5f01573a81a6'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:fe9a3be8-cf9a-4238-a4cc-10aa77d597c7', 1, NULL, 'In Lydian mode (Allegretto)', 'No. 37. In Lydian mode (Allegretto)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:458067e9-3cb2-433e-a36b-5f01573a81a6'
WHERE p.id = 330 AND p.composer_id = 85
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:fe9a3be8-cf9a-4238-a4cc-10aa77d597c7'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:500d3645-635c-43d2-a245-26a23d6c4c99', 2, NULL, 'Staccato and Legato (1)', 'No. 38. Staccato and Legato (1)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:458067e9-3cb2-433e-a36b-5f01573a81a6'
WHERE p.id = 330 AND p.composer_id = 85
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:500d3645-635c-43d2-a245-26a23d6c4c99'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:4e4804a9-b87f-4479-8388-8fa9f49731f4', 3, NULL, 'Staccato and Legato (Canon)', 'No. 39. Staccato and Legato (Canon)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:458067e9-3cb2-433e-a36b-5f01573a81a6'
WHERE p.id = 330 AND p.composer_id = 85
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:4e4804a9-b87f-4479-8388-8fa9f49731f4'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:b8e773d9-604f-4e87-847f-0122da9c2045', 4, NULL, 'In Yugoslavian Mode (Allegretto)', 'No. 40. In Yugoslavian Mode (Allegretto)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:458067e9-3cb2-433e-a36b-5f01573a81a6'
WHERE p.id = 330 AND p.composer_id = 85
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:b8e773d9-604f-4e87-847f-0122da9c2045'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:58ecb8ae-e8bc-4496-96f8-25820ba3bbed', 5, NULL, 'Melody with Accompaniment', 'No. 41. Melody with Accompaniment', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:458067e9-3cb2-433e-a36b-5f01573a81a6'
WHERE p.id = 330 AND p.composer_id = 85
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:58ecb8ae-e8bc-4496-96f8-25820ba3bbed'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:8f7aa685-ddaf-4b39-a2f6-f59800be4035', 6, NULL, 'Accompaniment in Broken Triads', 'No. 42. Accompaniment in Broken Triads', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:458067e9-3cb2-433e-a36b-5f01573a81a6'
WHERE p.id = 330 AND p.composer_id = 85
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:8f7aa685-ddaf-4b39-a2f6-f59800be4035'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:663d4b0f-4c26-46e4-8528-e2d63e579294', 7, NULL, 'In Hungarian Style', 'No. 43. In Hungarian Style', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:458067e9-3cb2-433e-a36b-5f01573a81a6'
WHERE p.id = 330 AND p.composer_id = 85
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:663d4b0f-4c26-46e4-8528-e2d63e579294'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:0071791e-4125-4d0e-9d5a-4cdc850ae2c8', 8, NULL, 'Contrary Motion (2)', 'No. 44. Contrary Motion (2)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:458067e9-3cb2-433e-a36b-5f01573a81a6'
WHERE p.id = 330 AND p.composer_id = 85
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:0071791e-4125-4d0e-9d5a-4cdc850ae2c8'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:63668070-7c1f-4e48-b150-226bbe3bd437', 9, NULL, 'Meditation', 'No. 45. Meditation', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:458067e9-3cb2-433e-a36b-5f01573a81a6'
WHERE p.id = 330 AND p.composer_id = 85
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:63668070-7c1f-4e48-b150-226bbe3bd437'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:95bfb1ba-7be0-43af-bec3-505cfc9e7d25', 10, NULL, 'Increasing – Diminishing', 'No. 46. Increasing – Diminishing', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:458067e9-3cb2-433e-a36b-5f01573a81a6'
WHERE p.id = 330 AND p.composer_id = 85
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:95bfb1ba-7be0-43af-bec3-505cfc9e7d25'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:163cb5bc-f0b8-4a3b-89a6-01f7dcac5c18', 11, NULL, 'County Fair', 'No. 47. County Fair', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:458067e9-3cb2-433e-a36b-5f01573a81a6'
WHERE p.id = 330 AND p.composer_id = 85
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:163cb5bc-f0b8-4a3b-89a6-01f7dcac5c18'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:52099034-2d5e-4d82-9fd7-d54fe243badf', 12, NULL, 'In Mixolydian Mode', 'No. 48. In Mixolydian Mode', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:458067e9-3cb2-433e-a36b-5f01573a81a6'
WHERE p.id = 330 AND p.composer_id = 85
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:52099034-2d5e-4d82-9fd7-d54fe243badf'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:98223610-c4b9-4768-a963-e045cc177606', 13, NULL, 'Crescendo – Diminuendo', 'No. 49. Crescendo – Diminuendo', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:458067e9-3cb2-433e-a36b-5f01573a81a6'
WHERE p.id = 330 AND p.composer_id = 85
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:98223610-c4b9-4768-a963-e045cc177606'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:8f961987-84fd-4687-bbe7-c34cd4a2ea26', 14, NULL, 'Minuetto (Tempo di minuetto)', 'No. 50. Minuetto (Tempo di minuetto)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:458067e9-3cb2-433e-a36b-5f01573a81a6'
WHERE p.id = 330 AND p.composer_id = 85
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:8f961987-84fd-4687-bbe7-c34cd4a2ea26'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:980b1ea9-e390-4fe9-a20f-b64236a9fe95', 15, NULL, 'Waves', 'No. 51. Waves', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:458067e9-3cb2-433e-a36b-5f01573a81a6'
WHERE p.id = 330 AND p.composer_id = 85
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:980b1ea9-e390-4fe9-a20f-b64236a9fe95'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:bbc35b63-93f8-4f84-afd3-fa0afd74acb9', 16, NULL, 'Unison Divided', 'No. 52. Unison Divided', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:458067e9-3cb2-433e-a36b-5f01573a81a6'
WHERE p.id = 330 AND p.composer_id = 85
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:bbc35b63-93f8-4f84-afd3-fa0afd74acb9'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:946e42d1-3cf0-4cf5-8ac5-9da900405f17', 17, NULL, 'In Transylvanian Style', 'No. 53. In Transylvanian Style', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:458067e9-3cb2-433e-a36b-5f01573a81a6'
WHERE p.id = 330 AND p.composer_id = 85
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:946e42d1-3cf0-4cf5-8ac5-9da900405f17'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:1c901010-732b-4e9b-b717-c2ece1e0c68c', 18, NULL, 'Chromatics', 'No. 54. Chromatics', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:458067e9-3cb2-433e-a36b-5f01573a81a6'
WHERE p.id = 330 AND p.composer_id = 85
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:1c901010-732b-4e9b-b717-c2ece1e0c68c'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:42653484-e53b-48df-8689-661f0739ed0c', 19, NULL, 'Triplets in Lydian Mode', 'No. 55. Triplets in Lydian Mode', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:458067e9-3cb2-433e-a36b-5f01573a81a6'
WHERE p.id = 330 AND p.composer_id = 85
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:42653484-e53b-48df-8689-661f0739ed0c'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:1c19f62e-6427-45c5-8bf1-571103f567b2', 20, NULL, 'Melody in Tenths', 'No. 56. Melody in Tenths', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:458067e9-3cb2-433e-a36b-5f01573a81a6'
WHERE p.id = 330 AND p.composer_id = 85
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:1c19f62e-6427-45c5-8bf1-571103f567b2'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:d892902a-b4e0-4127-b320-745f8bfc0d27', 21, NULL, 'Accents', 'No. 57. Accents', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:458067e9-3cb2-433e-a36b-5f01573a81a6'
WHERE p.id = 330 AND p.composer_id = 85
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:d892902a-b4e0-4127-b320-745f8bfc0d27'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:8221114b-6cc2-4db8-ad1e-0fd303c087b3', 22, NULL, 'In Oriental Style', 'No. 58. In Oriental Style', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:458067e9-3cb2-433e-a36b-5f01573a81a6'
WHERE p.id = 330 AND p.composer_id = 85
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:8221114b-6cc2-4db8-ad1e-0fd303c087b3'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:91f4faec-e85a-43f8-adf5-2bc229b7df6f', 23, NULL, 'Major and Minor', 'No. 59. Major and Minor', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:458067e9-3cb2-433e-a36b-5f01573a81a6'
WHERE p.id = 330 AND p.composer_id = 85
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:91f4faec-e85a-43f8-adf5-2bc229b7df6f'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:b36c3164-7f13-4a5a-a9a4-17ab2298cb46', 24, NULL, 'Canon with Sustained Notes', 'No. 60. Canon with Sustained Notes', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:458067e9-3cb2-433e-a36b-5f01573a81a6'
WHERE p.id = 330 AND p.composer_id = 85
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:b36c3164-7f13-4a5a-a9a4-17ab2298cb46'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:38551c01-4e2f-4222-b5b2-02d0f4f0ac37', 25, NULL, 'Pentatonic Melody', 'No. 61. Pentatonic Melody', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:458067e9-3cb2-433e-a36b-5f01573a81a6'
WHERE p.id = 330 AND p.composer_id = 85
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:38551c01-4e2f-4222-b5b2-02d0f4f0ac37'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:b9bb18b2-e4b8-4ac9-96bb-0297117be5fe', 26, NULL, 'Minor Sixths in Parallel Motion', 'No. 62. Minor Sixths in Parallel Motion', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:458067e9-3cb2-433e-a36b-5f01573a81a6'
WHERE p.id = 330 AND p.composer_id = 85
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:b9bb18b2-e4b8-4ac9-96bb-0297117be5fe'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:07d69f58-e268-4f63-931c-2d0cf54c6c09', 27, NULL, 'Buzzing', 'No. 63. Buzzing', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:458067e9-3cb2-433e-a36b-5f01573a81a6'
WHERE p.id = 330 AND p.composer_id = 85
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:07d69f58-e268-4f63-931c-2d0cf54c6c09'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:5b10b3d3-9b6a-4c2e-b18a-68185032d720', 28, NULL, 'Line against Point', 'No. 64. Line against Point', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:458067e9-3cb2-433e-a36b-5f01573a81a6'
WHERE p.id = 330 AND p.composer_id = 85
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:5b10b3d3-9b6a-4c2e-b18a-68185032d720'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:68e89e51-786e-4257-a19d-f1818c8ed02e', 29, NULL, 'Dialogue (with voice)', 'No. 65. Dialogue (with voice)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:458067e9-3cb2-433e-a36b-5f01573a81a6'
WHERE p.id = 330 AND p.composer_id = 85
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:68e89e51-786e-4257-a19d-f1818c8ed02e'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:d127489d-f845-4617-a13f-d5fe3507e0a2', 30, NULL, 'Melody Divided', 'No. 66. Melody Divided', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:458067e9-3cb2-433e-a36b-5f01573a81a6'
WHERE p.id = 330 AND p.composer_id = 85
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:d127489d-f845-4617-a13f-d5fe3507e0a2'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:bdfac650-11ef-4f2c-af18-c40ded4d13ec', 3, NULL, '3권 (67–96번)', 'Volume III (Nos. 67–96)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 330 AND p.composer_id = 85
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:bdfac650-11ef-4f2c-af18-c40ded4d13ec'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:816640fb-a19f-424c-89e7-d856b23a6049', 1, NULL, 'Thirds Against a Single Voice', 'No. 67. Thirds Against a Single Voice', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:bdfac650-11ef-4f2c-af18-c40ded4d13ec'
WHERE p.id = 330 AND p.composer_id = 85
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:816640fb-a19f-424c-89e7-d856b23a6049'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:88d544ab-8779-4d69-920c-a9641fb4f935', 2, NULL, 'Hungarian Dance', 'No. 68. Hungarian Dance', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:bdfac650-11ef-4f2c-af18-c40ded4d13ec'
WHERE p.id = 330 AND p.composer_id = 85
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:88d544ab-8779-4d69-920c-a9641fb4f935'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:7e636560-a1e7-45ab-bec5-30e6b33c1b61', 3, NULL, 'Study in Chords', 'No. 69. Study in Chords', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:bdfac650-11ef-4f2c-af18-c40ded4d13ec'
WHERE p.id = 330 AND p.composer_id = 85
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:7e636560-a1e7-45ab-bec5-30e6b33c1b61'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:da34ecfc-8e0d-460b-b3f3-6485d8b24167', 4, NULL, 'Melody Against Double Notes', 'No. 70. Melody Against Double Notes', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:bdfac650-11ef-4f2c-af18-c40ded4d13ec'
WHERE p.id = 330 AND p.composer_id = 85
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:da34ecfc-8e0d-460b-b3f3-6485d8b24167'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:67337eb1-a3aa-4509-884c-a88e954f96dd', 5, NULL, 'Thirds', 'No. 71. Thirds', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:bdfac650-11ef-4f2c-af18-c40ded4d13ec'
WHERE p.id = 330 AND p.composer_id = 85
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:67337eb1-a3aa-4509-884c-a88e954f96dd'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:486679c3-cd1f-4ce0-88a7-71747269e6e8', 6, NULL, 'Dragons'' Dance', 'No. 72. Dragons'' Dance', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:bdfac650-11ef-4f2c-af18-c40ded4d13ec'
WHERE p.id = 330 AND p.composer_id = 85
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:486679c3-cd1f-4ce0-88a7-71747269e6e8'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:00758e17-f6de-451b-b236-3dcc5dcf9d29', 7, NULL, 'Sixths and Triads (Comodo)', 'No. 73. Sixths and Triads (Comodo)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:bdfac650-11ef-4f2c-af18-c40ded4d13ec'
WHERE p.id = 330 AND p.composer_id = 85
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:00758e17-f6de-451b-b236-3dcc5dcf9d29'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:85def8d2-44bf-4ead-92ac-efba88a26e12', 8, NULL, 'Hungarian Matchmaking Song', 'No. 74. Hungarian Matchmaking Song', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:bdfac650-11ef-4f2c-af18-c40ded4d13ec'
WHERE p.id = 330 AND p.composer_id = 85
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:85def8d2-44bf-4ead-92ac-efba88a26e12'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:c3da4319-e562-4ba6-ad90-3b5d2ef51ef2', 9, NULL, 'Triplets', 'No. 75. Triplets', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:bdfac650-11ef-4f2c-af18-c40ded4d13ec'
WHERE p.id = 330 AND p.composer_id = 85
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:c3da4319-e562-4ba6-ad90-3b5d2ef51ef2'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:39e6b09a-a51e-4dee-aef0-e6190991afa9', 10, NULL, 'In Three Parts', 'No. 76. In Three Parts', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:bdfac650-11ef-4f2c-af18-c40ded4d13ec'
WHERE p.id = 330 AND p.composer_id = 85
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:39e6b09a-a51e-4dee-aef0-e6190991afa9'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:e28ecff8-b16b-4d56-968d-5054280c62e2', 11, NULL, 'Little Study', 'No. 77. Little Study', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:bdfac650-11ef-4f2c-af18-c40ded4d13ec'
WHERE p.id = 330 AND p.composer_id = 85
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:e28ecff8-b16b-4d56-968d-5054280c62e2'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:a4c094de-4d47-4dda-b675-ca58532e5f51', 12, NULL, 'Five-tone Scale', 'No. 78. Five-tone Scale', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:bdfac650-11ef-4f2c-af18-c40ded4d13ec'
WHERE p.id = 330 AND p.composer_id = 85
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:a4c094de-4d47-4dda-b675-ca58532e5f51'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:98fa439f-53c3-4364-ab22-a62f560ef394', 13, NULL, 'Hommage à Johann Sebastian Bach', 'No. 79. Hommage à Johann Sebastian Bach', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:bdfac650-11ef-4f2c-af18-c40ded4d13ec'
WHERE p.id = 330 AND p.composer_id = 85
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:98fa439f-53c3-4364-ab22-a62f560ef394'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:16743efe-30d3-42f8-9b6a-c42638a6bde3', 14, NULL, 'Hommage à Robert Schumann', 'No. 80. Hommage à Robert Schumann', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:bdfac650-11ef-4f2c-af18-c40ded4d13ec'
WHERE p.id = 330 AND p.composer_id = 85
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:16743efe-30d3-42f8-9b6a-c42638a6bde3'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:cec8d8eb-289a-4244-b3c9-f6a2d945c5dc', 15, NULL, 'Wandering', 'No. 81. Wandering', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:bdfac650-11ef-4f2c-af18-c40ded4d13ec'
WHERE p.id = 330 AND p.composer_id = 85
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:cec8d8eb-289a-4244-b3c9-f6a2d945c5dc'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:305ee88e-8c6c-472e-84a7-8439d1c76e44', 16, NULL, 'Scherzo (Allegretto scherzando)', 'No. 82. Scherzo (Allegretto scherzando)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:bdfac650-11ef-4f2c-af18-c40ded4d13ec'
WHERE p.id = 330 AND p.composer_id = 85
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:305ee88e-8c6c-472e-84a7-8439d1c76e44'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:0b6cfc96-a1ca-4c8b-885d-6b185ae62bea', 17, NULL, 'Melody with Interruptions', 'No. 83. Melody with Interruptions', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:bdfac650-11ef-4f2c-af18-c40ded4d13ec'
WHERE p.id = 330 AND p.composer_id = 85
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:0b6cfc96-a1ca-4c8b-885d-6b185ae62bea'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:1d9eb546-2f35-42fe-8565-0ba469c56141', 18, NULL, 'Merriment', 'No. 84. Merriment', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:bdfac650-11ef-4f2c-af18-c40ded4d13ec'
WHERE p.id = 330 AND p.composer_id = 85
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:1d9eb546-2f35-42fe-8565-0ba469c56141'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:4e516def-8cb7-4c8d-87b3-235fed26951a', 19, NULL, 'Broken Chords', 'No. 85. Broken Chords', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:bdfac650-11ef-4f2c-af18-c40ded4d13ec'
WHERE p.id = 330 AND p.composer_id = 85
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:4e516def-8cb7-4c8d-87b3-235fed26951a'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:c740ade9-bee8-4b4c-9d11-b0f5c6701efa', 20, NULL, 'Two Major Pentachords', 'No. 86. Two Major Pentachords', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:bdfac650-11ef-4f2c-af18-c40ded4d13ec'
WHERE p.id = 330 AND p.composer_id = 85
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:c740ade9-bee8-4b4c-9d11-b0f5c6701efa'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:37a4d64a-98f3-4966-a70c-54fb898e0851', 21, NULL, 'Variations (Allegro moderato)', 'No. 87. Variations (Allegro moderato)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:bdfac650-11ef-4f2c-af18-c40ded4d13ec'
WHERE p.id = 330 AND p.composer_id = 85
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:37a4d64a-98f3-4966-a70c-54fb898e0851'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:06b7abff-f211-441f-88e5-b02afd5cfdc1', 22, NULL, 'Duet for Pipes', 'No. 88. Duet for Pipes', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:bdfac650-11ef-4f2c-af18-c40ded4d13ec'
WHERE p.id = 330 AND p.composer_id = 85
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:06b7abff-f211-441f-88e5-b02afd5cfdc1'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:e6e9bf30-4ed0-447d-9eca-b348e14cdc90', 23, NULL, 'In Four Parts (1)', 'No. 89. In Four Parts (1)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:bdfac650-11ef-4f2c-af18-c40ded4d13ec'
WHERE p.id = 330 AND p.composer_id = 85
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:e6e9bf30-4ed0-447d-9eca-b348e14cdc90'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:a7ca9a07-1ecf-4127-bdbb-49c97bbf8d3e', 24, NULL, 'In Russian Style', 'No. 90. In Russian Style', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:bdfac650-11ef-4f2c-af18-c40ded4d13ec'
WHERE p.id = 330 AND p.composer_id = 85
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:a7ca9a07-1ecf-4127-bdbb-49c97bbf8d3e'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:581da2ca-8248-4614-af29-71119363afb8', 25, NULL, 'Chromatic Invention (1)', 'No. 91. Chromatic Invention (1)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:bdfac650-11ef-4f2c-af18-c40ded4d13ec'
WHERE p.id = 330 AND p.composer_id = 85
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:581da2ca-8248-4614-af29-71119363afb8'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:2c024031-7719-43f4-ac02-5fe8d526fda2', 26, NULL, 'Chromatic Invention (2)', 'No. 92. Chromatic Invention (2)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:bdfac650-11ef-4f2c-af18-c40ded4d13ec'
WHERE p.id = 330 AND p.composer_id = 85
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:2c024031-7719-43f4-ac02-5fe8d526fda2'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:35b7ca3e-3709-4725-b90c-1f574dbae54b', 27, NULL, 'In Four Parts (2)', 'No. 93. In Four Parts (2)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:bdfac650-11ef-4f2c-af18-c40ded4d13ec'
WHERE p.id = 330 AND p.composer_id = 85
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:35b7ca3e-3709-4725-b90c-1f574dbae54b'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:0ee1dc36-f030-4b65-8f17-98c02bcd5a82', 28, NULL, 'Once Upon a Time...', 'No. 94. Once Upon a Time...', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:bdfac650-11ef-4f2c-af18-c40ded4d13ec'
WHERE p.id = 330 AND p.composer_id = 85
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:0ee1dc36-f030-4b65-8f17-98c02bcd5a82'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:f4bb3e09-d698-4709-b92c-ce302f45856b', 29, NULL, 'Fox Song', 'No. 95. Fox Song', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:bdfac650-11ef-4f2c-af18-c40ded4d13ec'
WHERE p.id = 330 AND p.composer_id = 85
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:f4bb3e09-d698-4709-b92c-ce302f45856b'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:ebdda92a-b453-4bab-ab69-18ec4eeb8d83', 30, NULL, 'Jolts', 'No. 96. Jolts', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:bdfac650-11ef-4f2c-af18-c40ded4d13ec'
WHERE p.id = 330 AND p.composer_id = 85
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:ebdda92a-b453-4bab-ab69-18ec4eeb8d83'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:c4a13785-f769-417f-9448-47accdd05f4f', 4, NULL, '4권 (97–121번)', 'Volume IV (Nos. 97–121)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 330 AND p.composer_id = 85
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:c4a13785-f769-417f-9448-47accdd05f4f'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:9cb5fdb0-f7af-42ce-a9ce-46ccb38f93f0', 1, NULL, 'Notturno', 'No. 97. Notturno', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:c4a13785-f769-417f-9448-47accdd05f4f'
WHERE p.id = 330 AND p.composer_id = 85
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:9cb5fdb0-f7af-42ce-a9ce-46ccb38f93f0'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:c3656a10-9c27-49c0-b8e8-69275b732094', 2, NULL, 'Thumbs Under', 'No. 98. Thumbs Under', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:c4a13785-f769-417f-9448-47accdd05f4f'
WHERE p.id = 330 AND p.composer_id = 85
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:c3656a10-9c27-49c0-b8e8-69275b732094'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:d7ad98c9-8e62-4c0f-b3f0-fe3cc9b7a15e', 3, NULL, 'Hands Crossing', 'No. 99. Hands Crossing', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:c4a13785-f769-417f-9448-47accdd05f4f'
WHERE p.id = 330 AND p.composer_id = 85
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:d7ad98c9-8e62-4c0f-b3f0-fe3cc9b7a15e'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:271c3863-8251-49fd-9ce5-dc32badd187f', 4, NULL, 'In the Style of a Folk Song (Andante)', 'No. 100. In the Style of a Folk Song (Andante)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:c4a13785-f769-417f-9448-47accdd05f4f'
WHERE p.id = 330 AND p.composer_id = 85
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:271c3863-8251-49fd-9ce5-dc32badd187f'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:ad285bec-8ebf-4a9e-bb1c-e36be3bcf9a1', 5, NULL, 'Diminished Fifth', 'No. 101. Diminished Fifth', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:c4a13785-f769-417f-9448-47accdd05f4f'
WHERE p.id = 330 AND p.composer_id = 85
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:ad285bec-8ebf-4a9e-bb1c-e36be3bcf9a1'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:d387dfce-f37b-4876-b9e3-7ac823c13557', 6, NULL, 'Harmonics', 'No. 102. Harmonics', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:c4a13785-f769-417f-9448-47accdd05f4f'
WHERE p.id = 330 AND p.composer_id = 85
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:d387dfce-f37b-4876-b9e3-7ac823c13557'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:89290e93-61fc-4808-bc6e-d08badc5e427', 7, NULL, 'Minor and Major', 'No. 103. Minor and Major', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:c4a13785-f769-417f-9448-47accdd05f4f'
WHERE p.id = 330 AND p.composer_id = 85
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:89290e93-61fc-4808-bc6e-d08badc5e427'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:eae9d652-0eee-4b5f-aed6-14b35c1af199', 8, NULL, 'Wandering through the Keys (versions A & B)', 'No. 104. Wandering through the Keys (versions A & B)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:c4a13785-f769-417f-9448-47accdd05f4f'
WHERE p.id = 330 AND p.composer_id = 85
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:eae9d652-0eee-4b5f-aed6-14b35c1af199'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:36c1a7e7-7184-4102-a64c-efa0b1190124', 9, NULL, 'Game (with two five-tone scales)', 'No. 105. Game (with two five-tone scales)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:c4a13785-f769-417f-9448-47accdd05f4f'
WHERE p.id = 330 AND p.composer_id = 85
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:36c1a7e7-7184-4102-a64c-efa0b1190124'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:08a4b3b4-899b-4c4c-b931-c6c9ce6a51e0', 10, NULL, 'Children''s Song', 'No. 106. Children''s Song', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:c4a13785-f769-417f-9448-47accdd05f4f'
WHERE p.id = 330 AND p.composer_id = 85
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:08a4b3b4-899b-4c4c-b931-c6c9ce6a51e0'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:5215deb4-f3fe-4faf-9b5b-ba68af1aafe4', 11, NULL, 'Melody in the Mist', 'No. 107. Melody in the Mist', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:c4a13785-f769-417f-9448-47accdd05f4f'
WHERE p.id = 330 AND p.composer_id = 85
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:5215deb4-f3fe-4faf-9b5b-ba68af1aafe4'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:7d53abff-d7ce-4f2b-915a-8b84667d1594', 12, NULL, 'Wrestling', 'No. 108. Wrestling', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:c4a13785-f769-417f-9448-47accdd05f4f'
WHERE p.id = 330 AND p.composer_id = 85
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:7d53abff-d7ce-4f2b-915a-8b84667d1594'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:5b288e42-db16-488b-b151-037796d015a5', 13, NULL, 'From the Island of Bali', 'No. 109. From the Island of Bali', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:c4a13785-f769-417f-9448-47accdd05f4f'
WHERE p.id = 330 AND p.composer_id = 85
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:5b288e42-db16-488b-b151-037796d015a5'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:6a56bc58-72f4-44d5-b7ee-bd903e968ff6', 14, NULL, 'And the Sounds Clash and Clang', 'No. 110. And the Sounds Clash and Clang', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:c4a13785-f769-417f-9448-47accdd05f4f'
WHERE p.id = 330 AND p.composer_id = 85
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:6a56bc58-72f4-44d5-b7ee-bd903e968ff6'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:3c7b3698-9f2d-44a6-a119-869687a0bbda', 15, NULL, 'Intermezzo', 'No. 111. Intermezzo', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:c4a13785-f769-417f-9448-47accdd05f4f'
WHERE p.id = 330 AND p.composer_id = 85
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:3c7b3698-9f2d-44a6-a119-869687a0bbda'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:89dbb328-e38d-408a-b175-bf003c9c4904', 16, NULL, 'Variations on a Folk Tune', 'No. 112. Variations on a Folk Tune', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:c4a13785-f769-417f-9448-47accdd05f4f'
WHERE p.id = 330 AND p.composer_id = 85
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:89dbb328-e38d-408a-b175-bf003c9c4904'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:600152d0-19e7-4302-8f0f-7a24020e4e62', 17, NULL, 'Bulgarian Rhythm (Allegro molto)', 'No. 113. Bulgarian Rhythm (Allegro molto)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:c4a13785-f769-417f-9448-47accdd05f4f'
WHERE p.id = 330 AND p.composer_id = 85
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:600152d0-19e7-4302-8f0f-7a24020e4e62'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:85c91e7f-4199-4a2d-be99-3fa2b99d46cc', 18, NULL, 'Theme and Inversion', 'No. 114. Theme and Inversion', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:c4a13785-f769-417f-9448-47accdd05f4f'
WHERE p.id = 330 AND p.composer_id = 85
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:85c91e7f-4199-4a2d-be99-3fa2b99d46cc'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:44cfae8c-20a3-479b-ac23-35f009c7d706', 19, NULL, 'Bulgarian Rhythm (Vivace)', 'No. 115. Bulgarian Rhythm (Vivace)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:c4a13785-f769-417f-9448-47accdd05f4f'
WHERE p.id = 330 AND p.composer_id = 85
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:44cfae8c-20a3-479b-ac23-35f009c7d706'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:709d5d56-74e1-4dd0-beda-a21954edf31c', 20, NULL, 'Melody (Tempo di Marcia)', 'No. 116. Melody (Tempo di Marcia)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:c4a13785-f769-417f-9448-47accdd05f4f'
WHERE p.id = 330 AND p.composer_id = 85
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:709d5d56-74e1-4dd0-beda-a21954edf31c'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:29f6faa9-c596-4dd9-98de-d6b865965b54', 21, NULL, 'Bourrée', 'No. 117. Bourrée', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:c4a13785-f769-417f-9448-47accdd05f4f'
WHERE p.id = 330 AND p.composer_id = 85
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:29f6faa9-c596-4dd9-98de-d6b865965b54'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:59f421a2-5cce-4729-8899-9bd52e770d4f', 22, NULL, 'Triplets in 9/8 Time', 'No. 118. Triplets in 9/8 Time', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:c4a13785-f769-417f-9448-47accdd05f4f'
WHERE p.id = 330 AND p.composer_id = 85
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:59f421a2-5cce-4729-8899-9bd52e770d4f'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:d9a0e095-dadb-4992-bebb-37a8ef459581', 23, NULL, 'Dance in 3/4 Time', 'No. 119. Dance in 3/4 Time', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:c4a13785-f769-417f-9448-47accdd05f4f'
WHERE p.id = 330 AND p.composer_id = 85
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:d9a0e095-dadb-4992-bebb-37a8ef459581'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:60a71fe6-5aa0-4cae-b0fd-1d83834fa662', 24, NULL, 'Fifth Chords (Allegro)', 'No. 120. Fifth Chords (Allegro)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:c4a13785-f769-417f-9448-47accdd05f4f'
WHERE p.id = 330 AND p.composer_id = 85
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:60a71fe6-5aa0-4cae-b0fd-1d83834fa662'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:7d0ecc3a-71f3-4df1-84c4-ef585649498d', 25, NULL, 'Two-Part Study', 'No. 121. Two-Part Study', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:c4a13785-f769-417f-9448-47accdd05f4f'
WHERE p.id = 330 AND p.composer_id = 85
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:7d0ecc3a-71f3-4df1-84c4-ef585649498d'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:dee24cc3-a926-4972-9105-3294ba27a4bd', 5, NULL, '5권 (122–139번)', 'Volume V (Nos. 122–139)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 330 AND p.composer_id = 85
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:dee24cc3-a926-4972-9105-3294ba27a4bd'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:16a01e47-f38f-4574-b036-17fd87758040', 1, NULL, 'Chords Together and Opposed (Molto vivace)', 'No. 122. Chords Together and Opposed (Molto vivace)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:dee24cc3-a926-4972-9105-3294ba27a4bd'
WHERE p.id = 330 AND p.composer_id = 85
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:16a01e47-f38f-4574-b036-17fd87758040'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:08ad9cc2-68a2-4ee7-a380-2b8ceb5e6560', 2, NULL, 'Staccato and Legato', 'No. 123. Staccato and Legato', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:dee24cc3-a926-4972-9105-3294ba27a4bd'
WHERE p.id = 330 AND p.composer_id = 85
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:08ad9cc2-68a2-4ee7-a380-2b8ceb5e6560'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:435839d8-cdd8-4593-a813-f1897e3a78a3', 3, NULL, 'Staccato', 'No. 124. Staccato', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:dee24cc3-a926-4972-9105-3294ba27a4bd'
WHERE p.id = 330 AND p.composer_id = 85
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:435839d8-cdd8-4593-a813-f1897e3a78a3'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:15f2c01a-56b9-449b-bef9-36110bda11b6', 4, NULL, 'Boating', 'No. 125. Boating', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:dee24cc3-a926-4972-9105-3294ba27a4bd'
WHERE p.id = 330 AND p.composer_id = 85
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:15f2c01a-56b9-449b-bef9-36110bda11b6'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:8ccb2f72-38d6-4c3f-8909-7c08bd9c532a', 5, NULL, 'Change of Time (Allegro pesante)', 'No. 126. Change of Time (Allegro pesante)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:dee24cc3-a926-4972-9105-3294ba27a4bd'
WHERE p.id = 330 AND p.composer_id = 85
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:8ccb2f72-38d6-4c3f-8909-7c08bd9c532a'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:0e1cb53d-b62f-41f6-9f08-3b9e0c5842d0', 6, NULL, 'New Hungarian Folk Song', 'No. 127. New Hungarian Folk Song', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:dee24cc3-a926-4972-9105-3294ba27a4bd'
WHERE p.id = 330 AND p.composer_id = 85
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:0e1cb53d-b62f-41f6-9f08-3b9e0c5842d0'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:24325628-7a66-477b-bc57-ecafd1f0263e', 7, NULL, 'Peasant Dance (Moderato)', 'No. 128. Peasant Dance (Moderato)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:dee24cc3-a926-4972-9105-3294ba27a4bd'
WHERE p.id = 330 AND p.composer_id = 85
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:24325628-7a66-477b-bc57-ecafd1f0263e'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:81975060-3427-456c-b62e-8a26eb104c46', 8, NULL, 'Alternating Thirds (Allegro molto)', 'No. 129. Alternating Thirds (Allegro molto)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:dee24cc3-a926-4972-9105-3294ba27a4bd'
WHERE p.id = 330 AND p.composer_id = 85
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:81975060-3427-456c-b62e-8a26eb104c46'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:d8767e1a-6a2d-4cc6-a631-f6435a858036', 9, NULL, 'Village Joke (Moderato)', 'No. 130. Village Joke (Moderato)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:dee24cc3-a926-4972-9105-3294ba27a4bd'
WHERE p.id = 330 AND p.composer_id = 85
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:d8767e1a-6a2d-4cc6-a631-f6435a858036'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:e5943266-7f62-4a91-8032-67e5f4d75cb5', 10, NULL, 'Fourths (Allegro non troppo)', 'No. 131. Fourths (Allegro non troppo)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:dee24cc3-a926-4972-9105-3294ba27a4bd'
WHERE p.id = 330 AND p.composer_id = 85
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:e5943266-7f62-4a91-8032-67e5f4d75cb5'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:54932688-7354-440f-bcab-768a8ba155f8', 11, NULL, 'Major Seconds Broken and Together', 'No. 132. Major Seconds Broken and Together', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:dee24cc3-a926-4972-9105-3294ba27a4bd'
WHERE p.id = 330 AND p.composer_id = 85
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:54932688-7354-440f-bcab-768a8ba155f8'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:749d519d-7b3f-48dd-8954-de098eb6709a', 12, NULL, 'Syncopation (Allegro)', 'No. 133. Syncopation (Allegro)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:dee24cc3-a926-4972-9105-3294ba27a4bd'
WHERE p.id = 330 AND p.composer_id = 85
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:749d519d-7b3f-48dd-8954-de098eb6709a'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:91076568-bf5a-4b57-bad3-7cb76fcaf4d9', 13, NULL, 'Studies in Double Notes (versions A, B & C)', 'No. 134. Studies in Double Notes (versions A, B & C)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:dee24cc3-a926-4972-9105-3294ba27a4bd'
WHERE p.id = 330 AND p.composer_id = 85
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:91076568-bf5a-4b57-bad3-7cb76fcaf4d9'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:5ec06367-8459-42f4-b2c2-86118b488b65', 14, NULL, 'Perpetuum mobile (Allegro molto)', 'No. 135. Perpetuum mobile (Allegro molto)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:dee24cc3-a926-4972-9105-3294ba27a4bd'
WHERE p.id = 330 AND p.composer_id = 85
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:5ec06367-8459-42f4-b2c2-86118b488b65'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:7e839609-dad2-442e-b7c7-93926214a9b4', 15, NULL, 'Whole-Tone Scales', 'No. 136. Whole-Tone Scales', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:dee24cc3-a926-4972-9105-3294ba27a4bd'
WHERE p.id = 330 AND p.composer_id = 85
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:7e839609-dad2-442e-b7c7-93926214a9b4'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:b800195d-272b-48be-97fa-ef32c0d6e001', 16, NULL, 'Unison', 'No. 137. Unison', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:dee24cc3-a926-4972-9105-3294ba27a4bd'
WHERE p.id = 330 AND p.composer_id = 85
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:b800195d-272b-48be-97fa-ef32c0d6e001'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:778f3c13-f7f2-42d8-8155-c5c1f876b6ec', 17, NULL, 'Bagpipe (Allegretto)', 'No. 138. Bagpipe (Allegretto)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:dee24cc3-a926-4972-9105-3294ba27a4bd'
WHERE p.id = 330 AND p.composer_id = 85
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:778f3c13-f7f2-42d8-8155-c5c1f876b6ec'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:f69b58d8-7786-4442-84b3-684b3b5acde4', 18, NULL, 'Merry Andrew', 'No. 139. Merry Andrew', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:dee24cc3-a926-4972-9105-3294ba27a4bd'
WHERE p.id = 330 AND p.composer_id = 85
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:f69b58d8-7786-4442-84b3-684b3b5acde4'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:6dbef7e0-6ea9-490b-85b0-2a9c1cf1d070', 6, NULL, '6권 (140–153번)', 'Volume VI (Nos. 140–153)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 330 AND p.composer_id = 85
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:6dbef7e0-6ea9-490b-85b0-2a9c1cf1d070'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:826db65e-a5c6-46ea-890f-6d513e37db6f', 1, NULL, 'Free Variations (Allegro molto)', 'No. 140. Free Variations (Allegro molto)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:6dbef7e0-6ea9-490b-85b0-2a9c1cf1d070'
WHERE p.id = 330 AND p.composer_id = 85
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:826db65e-a5c6-46ea-890f-6d513e37db6f'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:5f6900ba-0673-447a-a121-210bcda1fd20', 2, NULL, 'Subject and Reflection', 'No. 141. Subject and Reflection', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:6dbef7e0-6ea9-490b-85b0-2a9c1cf1d070'
WHERE p.id = 330 AND p.composer_id = 85
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:5f6900ba-0673-447a-a121-210bcda1fd20'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:20592094-8392-4905-8b41-4e5932a4f5e8', 3, NULL, 'From the Diary of a Fly', 'No. 142. From the Diary of a Fly', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:6dbef7e0-6ea9-490b-85b0-2a9c1cf1d070'
WHERE p.id = 330 AND p.composer_id = 85
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:20592094-8392-4905-8b41-4e5932a4f5e8'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:919e1d36-de7e-494f-9111-4427fd73e844', 4, NULL, 'Divided Arpeggios', 'No. 143. Divided Arpeggios', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:6dbef7e0-6ea9-490b-85b0-2a9c1cf1d070'
WHERE p.id = 330 AND p.composer_id = 85
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:919e1d36-de7e-494f-9111-4427fd73e844'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:7fe22071-1a6c-4f54-83dc-379c3df59082', 5, NULL, 'Minor Seconds, Major Sevenths (Molto adagio mesto)', 'No. 144. Minor Seconds, Major Sevenths (Molto adagio mesto)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:6dbef7e0-6ea9-490b-85b0-2a9c1cf1d070'
WHERE p.id = 330 AND p.composer_id = 85
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:7fe22071-1a6c-4f54-83dc-379c3df59082'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:6d619edb-83f0-4711-8bea-98be9c94369c', 6, NULL, 'Chromatic Invention', 'No. 145. Chromatic Invention', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:6dbef7e0-6ea9-490b-85b0-2a9c1cf1d070'
WHERE p.id = 330 AND p.composer_id = 85
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:6d619edb-83f0-4711-8bea-98be9c94369c'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:27d3a5ce-7009-4a96-82d4-3deef6c69b1d', 7, NULL, 'Ostinato (Vivacissimo)', 'No. 146. Ostinato (Vivacissimo)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:6dbef7e0-6ea9-490b-85b0-2a9c1cf1d070'
WHERE p.id = 330 AND p.composer_id = 85
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:27d3a5ce-7009-4a96-82d4-3deef6c69b1d'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:d55daffa-032d-4070-a586-8828bbb4a207', 8, NULL, 'March (Allegro)', 'No. 147. March (Allegro)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:6dbef7e0-6ea9-490b-85b0-2a9c1cf1d070'
WHERE p.id = 330 AND p.composer_id = 85
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:d55daffa-032d-4070-a586-8828bbb4a207'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:ab05c176-267c-440e-b1c6-7c4cb96ad0cb', 9, NULL, 'Six Dances in Bulgarian Rhythm (1)', 'No. 148. Six Dances in Bulgarian Rhythm (1)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:6dbef7e0-6ea9-490b-85b0-2a9c1cf1d070'
WHERE p.id = 330 AND p.composer_id = 85
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:ab05c176-267c-440e-b1c6-7c4cb96ad0cb'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:a9c5a96c-a274-4b74-a1fb-6170c19fd0a2', 10, NULL, 'Six Dances in Bulgarian Rhythm (2)', 'No. 149. Six Dances in Bulgarian Rhythm (2)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:6dbef7e0-6ea9-490b-85b0-2a9c1cf1d070'
WHERE p.id = 330 AND p.composer_id = 85
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:a9c5a96c-a274-4b74-a1fb-6170c19fd0a2'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:28a295a2-7b86-44f8-82ab-45522dff8798', 11, NULL, 'Six Dances in Bulgarian Rhythm (3)', 'No. 150. Six Dances in Bulgarian Rhythm (3)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:6dbef7e0-6ea9-490b-85b0-2a9c1cf1d070'
WHERE p.id = 330 AND p.composer_id = 85
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:28a295a2-7b86-44f8-82ab-45522dff8798'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:8ae6cfde-2c9d-45df-aaf2-a79e0994cad4', 12, NULL, 'Six Dances in Bulgarian Rhythm (4)', 'No. 151. Six Dances in Bulgarian Rhythm (4)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:6dbef7e0-6ea9-490b-85b0-2a9c1cf1d070'
WHERE p.id = 330 AND p.composer_id = 85
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:8ae6cfde-2c9d-45df-aaf2-a79e0994cad4'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:2206800a-e462-4c65-9043-34f05bd91b56', 13, NULL, 'Six Dances in Bulgarian Rhythm (5)', 'No. 152. Six Dances in Bulgarian Rhythm (5)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:6dbef7e0-6ea9-490b-85b0-2a9c1cf1d070'
WHERE p.id = 330 AND p.composer_id = 85
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:2206800a-e462-4c65-9043-34f05bd91b56'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:cf9907f4-69dd-4e25-b518-209521efe3f9', 14, NULL, 'Six Dances in Bulgarian Rhythm (6)', 'No. 153. Six Dances in Bulgarian Rhythm (6)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:6dbef7e0-6ea9-490b-85b0-2a9c1cf1d070'
WHERE p.id = 330 AND p.composer_id = 85
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:cf9907f4-69dd-4e25-b518-209521efe3f9'
);


-- Sz. 108 두 대의 피아노를 위한 <미크로코스모스>에서 7개의 소품

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '두 대의 피아노를 위한 <미크로코스모스>에서 7개의 소품', 'Seven Pieces from Mikrokosmos for Two Pianos', 'album', 'Sz. 108', NULL, NULL, 1940, 'manual', 1
FROM composers c
WHERE c.id = 85
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '두 대의 피아노를 위한 <미크로코스모스>에서 7개의 소품'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '0b6f3786-891b-46e8-b935-7853decbb908'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '0b6f3786-891b-46e8-b935-7853decbb908'
FROM pieces p
WHERE p.composer_id = 85 AND p.title = '두 대의 피아노를 위한 <미크로코스모스>에서 7개의 소품' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '0b6f3786-891b-46e8-b935-7853decbb908'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:228e2453-bce3-4bd6-9b44-76498eb82db0', 1, NULL, 'Bulgarian Rhythm', 'Bulgarian Rhythm', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 85 AND p.title = '두 대의 피아노를 위한 <미크로코스모스>에서 7개의 소품' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:228e2453-bce3-4bd6-9b44-76498eb82db0'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:90bbb34c-3076-42f2-aa25-91a6e1710d07', 2, NULL, 'Chord and Trill Study', 'Chord and Trill Study', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 85 AND p.title = '두 대의 피아노를 위한 <미크로코스모스>에서 7개의 소품' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:90bbb34c-3076-42f2-aa25-91a6e1710d07'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:1d3d9b40-1795-4f1a-8164-767e66ef1a6a', 3, NULL, 'Perpetuum mobile', 'Perpetuum mobile', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 85 AND p.title = '두 대의 피아노를 위한 <미크로코스모스>에서 7개의 소품' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:1d3d9b40-1795-4f1a-8164-767e66ef1a6a'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:7241de95-50a2-471f-b0d5-07705b67c8a2', 4, NULL, 'Short Canon and Its Inversion', 'Short Canon and Its Inversion', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 85 AND p.title = '두 대의 피아노를 위한 <미크로코스모스>에서 7개의 소품' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:7241de95-50a2-471f-b0d5-07705b67c8a2'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:ea23c0d2-6858-4cc9-87d3-9929ba5894a1', 5, NULL, 'New Hungarian Folk Song', 'New Hungarian Folk Song', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 85 AND p.title = '두 대의 피아노를 위한 <미크로코스모스>에서 7개의 소품' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:ea23c0d2-6858-4cc9-87d3-9929ba5894a1'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:4069b712-6e21-402f-83cb-7d714bb16dbe', 6, NULL, 'Chromatic Invention', 'Chromatic Invention', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 85 AND p.title = '두 대의 피아노를 위한 <미크로코스모스>에서 7개의 소품' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:4069b712-6e21-402f-83cb-7d714bb16dbe'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:c53e7245-a22b-4248-830a-1613b1ba3579', 7, NULL, 'Ostinato', 'Ostinato', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 85 AND p.title = '두 대의 피아노를 위한 <미크로코스모스>에서 7개의 소품' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:c53e7245-a22b-4248-830a-1613b1ba3579'
);


-- Sz. 110 두 대의 피아노와 타악기를 위한 소나타

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '두 대의 피아노와 타악기를 위한 소나타', 'Sonata for Two Pianos and Percussion', 'album', 'Sz. 110', NULL, NULL, 1937, 'manual', 1
FROM composers c
WHERE c.id = 85
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '두 대의 피아노와 타악기를 위한 소나타'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'c131e7e5-3810-41bb-b92f-992388d34f8d'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'c131e7e5-3810-41bb-b92f-992388d34f8d'
FROM pieces p
WHERE p.composer_id = 85 AND p.title = '두 대의 피아노와 타악기를 위한 소나타' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'c131e7e5-3810-41bb-b92f-992388d34f8d'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:3bab712a-1cd2-34dd-886f-09223ba58b27', 1, 'I', 'Assai lento – Allegro molto', 'I. Assai lento – Allegro molto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 85 AND p.title = '두 대의 피아노와 타악기를 위한 소나타' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:3bab712a-1cd2-34dd-886f-09223ba58b27'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:0d37e53a-aaa3-3170-bd78-a86a640457bd', 2, 'II', 'Lento, ma non troppo', 'II. Lento, ma non troppo', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 85 AND p.title = '두 대의 피아노와 타악기를 위한 소나타' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:0d37e53a-aaa3-3170-bd78-a86a640457bd'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:2152a891-bc39-3fcb-9f8d-936d9241e58f', 3, 'III', 'Allegro non troppo', 'III. Allegro non troppo', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 85 AND p.title = '두 대의 피아노와 타악기를 위한 소나타' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:2152a891-bc39-3fcb-9f8d-936d9241e58f'
);


-- Sz. 111 콘트라스트

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '콘트라스트', 'Contrasts', 'album', 'Sz. 111', NULL, NULL, 1938, 'manual', 1
FROM composers c
WHERE c.id = 85
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '콘트라스트'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '0ea83560-8eee-4f57-b7ee-79fbc825beb0'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '0ea83560-8eee-4f57-b7ee-79fbc825beb0'
FROM pieces p
WHERE p.composer_id = 85 AND p.title = '콘트라스트' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '0ea83560-8eee-4f57-b7ee-79fbc825beb0'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:7fb34c00-c47b-483b-95a9-0af1bd886424', 1, 'I', 'Verbunkos. Moderato, ben ritmico', 'I. Verbunkos (Recruiting Dance). Moderato, ben ritmico', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 85 AND p.title = '콘트라스트' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:7fb34c00-c47b-483b-95a9-0af1bd886424'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:2f7ce862-22e8-4a77-a664-3d4850b2f8d2', 2, 'II', 'Pihenő. Lento', 'II. Pihenő (Relaxation). Lento', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 85 AND p.title = '콘트라스트' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:2f7ce862-22e8-4a77-a664-3d4850b2f8d2'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:250cdb60-f2f8-4e09-92cc-7d3d1bd636f4', 3, 'III', 'Sebes. Allegro vivace', 'III. Sebes (Fast Dance). Allegro vivace', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 85 AND p.title = '콘트라스트' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:250cdb60-f2f8-4e09-92cc-7d3d1bd636f4'
);


-- Sz. 112 바이올린 협주곡 2번

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '바이올린 협주곡 2번', 'Violin Concerto No. 2', 'album', 'Sz. 112', NULL, NULL, 1938, 'manual', 1
FROM composers c
WHERE c.id = 85
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '바이올린 협주곡 2번'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '4adad069-a264-4f34-8380-468860901202'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '4adad069-a264-4f34-8380-468860901202'
FROM pieces p
WHERE p.composer_id = 85 AND p.title = '바이올린 협주곡 2번' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '4adad069-a264-4f34-8380-468860901202'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:22e51466-4f40-4539-9155-1a9825a32608', 1, 'I', 'Allegro non troppo', 'I. Allegro non troppo', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 85 AND p.title = '바이올린 협주곡 2번' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:22e51466-4f40-4539-9155-1a9825a32608'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:74036749-08c5-41b5-95a7-b0665e3d81c3', 2, 'II', 'Andante tranquillo', 'II. Andante tranquillo', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 85 AND p.title = '바이올린 협주곡 2번' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:74036749-08c5-41b5-95a7-b0665e3d81c3'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:f24a078f-0778-436c-824d-c285b0d34088', 3, 'III', 'Allegro molto', 'III. Allegro molto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 85 AND p.title = '바이올린 협주곡 2번' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:f24a078f-0778-436c-824d-c285b0d34088'
);


-- Sz. 113 현을 위한 디베르티멘토

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '현을 위한 디베르티멘토', 'Divertimento for String Orchestra', 'album', 'Sz. 113', NULL, NULL, 1939, 'manual', 1
FROM composers c
WHERE c.id = 85
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '현을 위한 디베르티멘토'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '99e85b2e-6bdb-4219-9b90-e65a7fecaeb3'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '99e85b2e-6bdb-4219-9b90-e65a7fecaeb3'
FROM pieces p
WHERE p.composer_id = 85 AND p.title = '현을 위한 디베르티멘토' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '99e85b2e-6bdb-4219-9b90-e65a7fecaeb3'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:4ea7a897-5107-3846-9b7f-81b45fc4c563', 1, 'I', 'Allegro non troppo', 'I. Allegro non troppo', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 85 AND p.title = '현을 위한 디베르티멘토' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:4ea7a897-5107-3846-9b7f-81b45fc4c563'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:e27e850a-90f6-37ab-9588-6b8a76680516', 2, 'II', 'Molto adagio', 'II. Molto adagio', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 85 AND p.title = '현을 위한 디베르티멘토' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:e27e850a-90f6-37ab-9588-6b8a76680516'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:109fbda0-cf73-3f1d-85f2-096598431a3d', 3, 'III', 'Allegro assai', 'III. Allegro assai', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 85 AND p.title = '현을 위한 디베르티멘토' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:109fbda0-cf73-3f1d-85f2-096598431a3d'
);


-- Sz. 114 현악 4중주 6번

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '현악 4중주 6번', 'String Quartet No. 6', 'album', 'Sz. 114', NULL, NULL, 1939, 'manual', 1
FROM composers c
WHERE c.id = 85
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '현악 4중주 6번'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '86d52673-1353-498c-96fd-46ad1e66edbd'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '86d52673-1353-498c-96fd-46ad1e66edbd'
FROM pieces p
WHERE p.composer_id = 85 AND p.title = '현악 4중주 6번' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '86d52673-1353-498c-96fd-46ad1e66edbd'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:f2456b2a-c786-3eef-a5bc-dcaafb609ed0', 1, 'I', 'Mesto – Vivace', 'I. Mesto – Vivace', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 85 AND p.title = '현악 4중주 6번' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:f2456b2a-c786-3eef-a5bc-dcaafb609ed0'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:07330bbd-1436-35af-8013-71b71a48cd38', 2, 'II', 'Mesto – Marcia', 'II. Mesto – Marcia', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 85 AND p.title = '현악 4중주 6번' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:07330bbd-1436-35af-8013-71b71a48cd38'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:edee7a70-83d3-311a-8422-3e41e47a21c6', 3, 'III', 'Mesto – Burletta. Moderato', 'III. Mesto – Burletta. Moderato', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 85 AND p.title = '현악 4중주 6번' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:edee7a70-83d3-311a-8422-3e41e47a21c6'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:23a3695f-ff35-30fd-aa94-b155b20ae73d', 4, 'IV', 'Mesto', 'IV. Mesto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 85 AND p.title = '현악 4중주 6번' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:23a3695f-ff35-30fd-aa94-b155b20ae73d'
);


-- Sz. 115 두 대의 피아노와 타악기를 위한 협주곡

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '두 대의 피아노와 타악기를 위한 협주곡', 'Concerto for Two Pianos, Percussion and Orchestra', 'album', 'Sz. 115', NULL, NULL, 1940, 'manual', 1
FROM composers c
WHERE c.id = 85
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '두 대의 피아노와 타악기를 위한 협주곡'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '4069b6d4-79f4-402f-a005-e021c98ee40c'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '4069b6d4-79f4-402f-a005-e021c98ee40c'
FROM pieces p
WHERE p.composer_id = 85 AND p.title = '두 대의 피아노와 타악기를 위한 협주곡' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '4069b6d4-79f4-402f-a005-e021c98ee40c'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:aa4bd006-e760-3195-b2d8-1dc2e99afa44', 1, 'I', 'Assai lento – Allegro molto', 'I. Assai lento – Allegro molto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 85 AND p.title = '두 대의 피아노와 타악기를 위한 협주곡' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:aa4bd006-e760-3195-b2d8-1dc2e99afa44'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:1bae950c-ca9c-37f4-9aa2-95103dc0fb04', 2, 'II', 'Lento, ma non troppo', 'II. Lento, ma non troppo', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 85 AND p.title = '두 대의 피아노와 타악기를 위한 협주곡' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:1bae950c-ca9c-37f4-9aa2-95103dc0fb04'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:68b832b2-36a5-3913-ba32-e51136b8ada6', 3, 'III', 'Allegro non troppo', 'III. Allegro non troppo', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 85 AND p.title = '두 대의 피아노와 타악기를 위한 협주곡' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:68b832b2-36a5-3913-ba32-e51136b8ada6'
);


-- Sz. 115a 두 대의 피아노를 위한 모음곡

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '두 대의 피아노를 위한 모음곡', 'Suite for Two Pianos, Op. 4b', 'album', 'Sz. 115a', NULL, NULL, 1941, 'manual', 1
FROM composers c
WHERE c.id = 85
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '두 대의 피아노를 위한 모음곡'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'edd886ae-a6d7-4f18-acad-1f12aa04241f'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'edd886ae-a6d7-4f18-acad-1f12aa04241f'
FROM pieces p
WHERE p.composer_id = 85 AND p.title = '두 대의 피아노를 위한 모음곡' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'edd886ae-a6d7-4f18-acad-1f12aa04241f'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:53d0e40f-fc00-44c6-b3ee-5580d2747223', 1, 'I', '세레나타', 'I. Serenata', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 85 AND p.title = '두 대의 피아노를 위한 모음곡' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:53d0e40f-fc00-44c6-b3ee-5580d2747223'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:208ecd41-76b9-4fe4-9af0-54a802c94df8', 2, 'II', 'Allegro diabolico', 'II. Allegro diabolico', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 85 AND p.title = '두 대의 피아노를 위한 모음곡' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:208ecd41-76b9-4fe4-9af0-54a802c94df8'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:3b47ad62-c33e-47d9-a1de-1a180e58748a', 3, 'III', 'Scena della puszta', 'III. Scena della puszta', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 85 AND p.title = '두 대의 피아노를 위한 모음곡' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:3b47ad62-c33e-47d9-a1de-1a180e58748a'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:caf67dfd-20c1-423b-ad88-7b41ae913371', 4, 'IV', 'Per finire', 'IV. Per finire', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 85 AND p.title = '두 대의 피아노를 위한 모음곡' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:caf67dfd-20c1-423b-ad88-7b41ae913371'
);


-- Sz. 116 관현악을 위한 협주곡

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:490c25b4-fd2f-3cf1-af40-f0e072bc797a', 1, 'I', '서주. Andante non troppo – Allegro vivace', 'I. Introduzione. Andante non troppo – Allegro vivace', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 327 AND p.composer_id = 85
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:490c25b4-fd2f-3cf1-af40-f0e072bc797a'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:c7ee9027-6bb2-3a27-b91f-36da7e26808a', 2, 'II', 'Giuoco delle coppie. Allegretto scherzando', 'II. Giuoco delle coppie. Allegretto scherzando', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 327 AND p.composer_id = 85
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:c7ee9027-6bb2-3a27-b91f-36da7e26808a'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:162bfe29-7970-3c20-bf55-031c76fa3f7c', 3, 'III', '엘레지. Andante non troppo', 'III. Elegia. Andante non troppo', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 327 AND p.composer_id = 85
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:162bfe29-7970-3c20-bf55-031c76fa3f7c'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:8961fa6a-9d99-3bb9-9890-dd1b665d6010', 4, 'IV', 'Intermezzo interrotto. Allegretto', 'IV. Intermezzo interrotto. Allegretto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 327 AND p.composer_id = 85
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:8961fa6a-9d99-3bb9-9890-dd1b665d6010'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:94c914f7-6458-3f70-a697-ab50e4e7f570', 5, 'V', '피날레. Pesante – Presto', 'V. Finale. Pesante – Presto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 327 AND p.composer_id = 85
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:94c914f7-6458-3f70-a697-ab50e4e7f570'
);


-- Sz. 117 무반주 바이올린 소나타

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '무반주 바이올린 소나타', 'Sonata for Solo Violin', 'album', 'Sz. 117', NULL, NULL, 1944, 'manual', 1
FROM composers c
WHERE c.id = 85
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '무반주 바이올린 소나타'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '971885c0-eef6-45dd-ae5f-21f4e8d4401b'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '971885c0-eef6-45dd-ae5f-21f4e8d4401b'
FROM pieces p
WHERE p.composer_id = 85 AND p.title = '무반주 바이올린 소나타' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '971885c0-eef6-45dd-ae5f-21f4e8d4401b'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:b21af8d1-e7cb-4848-bc62-841a0f60aabf', 1, 'I', 'Tempo di ciaccona', 'I. Tempo di ciaccona', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 85 AND p.title = '무반주 바이올린 소나타' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:b21af8d1-e7cb-4848-bc62-841a0f60aabf'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:1f7b6bd9-12ce-4d94-9a93-7a2bc598bf80', 2, 'II', '푸가. Risoluto, non troppo vivo', 'II. Fuga. Risoluto, non troppo vivo', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 85 AND p.title = '무반주 바이올린 소나타' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:1f7b6bd9-12ce-4d94-9a93-7a2bc598bf80'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:4a3f1ed9-e1dd-4939-8103-141950727de4', 3, 'III', 'Melodia. Adagio', 'III. Melodia. Adagio', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 85 AND p.title = '무반주 바이올린 소나타' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:4a3f1ed9-e1dd-4939-8103-141950727de4'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:8673925d-6719-4f24-b025-b92c2c071f9c', 4, 'IV', 'Presto', 'IV. Presto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 85 AND p.title = '무반주 바이올린 소나타' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:8673925d-6719-4f24-b025-b92c2c071f9c'
);


-- Sz. 119 피아노 협주곡 3번

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '피아노 협주곡 3번', 'Piano Concerto No. 3', 'album', 'Sz. 119', NULL, NULL, 1945, 'manual', 1
FROM composers c
WHERE c.id = 85
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '피아노 협주곡 3번'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '8096a4aa-7b33-4053-b5e5-63a9e88ee29a'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '8096a4aa-7b33-4053-b5e5-63a9e88ee29a'
FROM pieces p
WHERE p.composer_id = 85 AND p.title = '피아노 협주곡 3번' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '8096a4aa-7b33-4053-b5e5-63a9e88ee29a'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:9f3c228b-d7a1-3f18-b7c9-186827f3837d', 1, 'I', 'Allegretto', 'I. Allegretto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 85 AND p.title = '피아노 협주곡 3번' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:9f3c228b-d7a1-3f18-b7c9-186827f3837d'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:09640c88-287d-336f-8eaa-39d14689b558', 2, 'II', 'Adagio religioso', 'II. Adagio religioso', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 85 AND p.title = '피아노 협주곡 3번' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:09640c88-287d-336f-8eaa-39d14689b558'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:e1cbddba-b5dc-335c-90c3-ade9135229f2', 3, 'III', 'Allegro vivace', 'III. Allegro vivace', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 85 AND p.title = '피아노 협주곡 3번' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:e1cbddba-b5dc-335c-90c3-ade9135229f2'
);


-- Sz. 120 비올라 협주곡

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '비올라 협주곡', 'Viola Concerto', 'album', 'Sz. 120', NULL, NULL, 1945, 'manual', 1
FROM composers c
WHERE c.id = 85
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '비올라 협주곡'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '1caee8d2-f4ae-4e41-9a6c-269c2c425bc3'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '1caee8d2-f4ae-4e41-9a6c-269c2c425bc3'
FROM pieces p
WHERE p.composer_id = 85 AND p.title = '비올라 협주곡' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '1caee8d2-f4ae-4e41-9a6c-269c2c425bc3'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:69a3536a-5eeb-327a-9ae5-245fb7cfba2e', 1, 'I', 'Moderato', 'I. Moderato', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 85 AND p.title = '비올라 협주곡' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:69a3536a-5eeb-327a-9ae5-245fb7cfba2e'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:e5b1e4fe-50d3-381d-b772-a7b7bd3c568f', 2, 'II', 'Adagio religioso', 'II. Adagio religioso', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 85 AND p.title = '비올라 협주곡' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:e5b1e4fe-50d3-381d-b772-a7b7bd3c568f'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:02b82887-5038-3125-81c0-f2b629ad6fc4', 3, 'III', 'Allegro vivace', 'III. Allegro vivace', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 85 AND p.title = '비올라 협주곡' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:02b82887-5038-3125-81c0-f2b629ad6fc4'
);


-- BB 26 바이올린과 피아노를 위한 안단테 A장조

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '바이올린과 피아노를 위한 안단테 A장조', 'Andante in A major for Violin and Piano', 'song', 'BB 26', NULL, NULL, 1902, 'manual', 1
FROM composers c
WHERE c.id = 85
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '바이올린과 피아노를 위한 안단테 A장조'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'f617982e-1826-4609-b304-097625c7d7a7'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'f617982e-1826-4609-b304-097625c7d7a7'
FROM pieces p
WHERE p.composer_id = 85 AND p.title = '바이올린과 피아노를 위한 안단테 A장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'f617982e-1826-4609-b304-097625c7d7a7'
);

