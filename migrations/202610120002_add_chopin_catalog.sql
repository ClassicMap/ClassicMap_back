-- 쇼팽 작품을 출판 단위로 채운다. 묶음(연습곡 Op. 10 등)은 작품 하나, 그 안의 곡은 piece_parts 로 둔다.
--
-- 목록은 MusicBrainz work 와 위키백과 "List of compositions by Frédéric Chopin by opus number/genre" 를 맞춘
-- 것이다. Op. 1~74 의 묶음 안 곡 수와 조성, B. 번호가 위키백과와 같다. 이미 있는 쇼팽 작품 17개는 MBID 로
-- 짝을 지어 새로 만들지 않는다(463 연습곡 Op. 25, 465 24개의 전주곡 Op. 28 도 그대로 쓴다).
--
-- 정한 것
--   묶음 제목: 463·465 꼴을 따라 제목에 작품번호를 넣고("마주르카 Op. 6") opus_number 는 비운다. 작품번호
--     순 정렬을 위해 catalogue_system·catalogue_number 를 채운다. 낱곡·다악장 작품은 기존대로 opus_number.
--   낱곡이 이미 따로 있는 곡(127 혁명, 447 이별의 곡, 26048 Op. 10-1, 131 Op. 9-2, 133 Op. 64-1,
--     446 빗방울)은 part.linked_piece_id 로 잇는다. 그 작품 행은 건드리지 않는다.
--   part 이름은 묶음 안 이름이다. 번호는 sequence_number 가 맡으므로 "1번"·"1악장" 을 빼고 조성·별명·빠르기만
--     둔다. 악장으로 나뉜 작품만 movement_number(I, II …)를 채운다.
--   Op. 72 는 두 겹이다(3번 "3개의 에코세즈" 아래 세 곡을 parent_part_id 로 둔다).
--   Op. 74 가곡 제목은 출처 있는 우리말 번역이 없어 폴란드어 원제를 괄호로 함께 둔다.
--   Op. 2·13·14(변주곡·환상곡·론도)는 MusicBrainz 가 부분으로 나눴지만 낱곡으로 둔다. Op. 22 는 안단테
--     스피아나토만 따로 연주하기도 해서 두 곡으로 둔다.
--   넣지 않은 것: 위작 의심(B. 4·9·17, KK Anh. Ia/2–3, 2024년 발견 왈츠 A단조), 민요를 받아 적은 묶음
--     (B. 160b, KK VIIb/7–8), 위키백과가 독립 창작곡이 아니라고 적은 라르고 B. 109.
--   기존 seed part 둘(463 의 9번, 465 의 7번)은 이름을 채우고 editor_locked 로 잠근다.
--
-- part 는 EDITOR_REVIEWED 로 넣는다. 작곡가 화면은 이 상태 이상인 part 만 묶음 안 곡으로 센다.
-- 같은 MBID 가 이미 다른 작품에 있으면 작품도 식별자도 넣지 않는다. 방금 넣은 작품은 (작곡가, 제목,
-- origin='manual') 로 찾는다. 두 번 돌려도 같다.

-- Op. 1 론도 C단조

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '론도 C단조', 'Rondo in C minor', 'song', 'Op. 1', NULL, NULL, 1825, 'manual', 1
FROM composers c
WHERE c.id = 28
AND NOT EXISTS (
    SELECT 1 FROM (SELECT composer_id, title FROM pieces) existing
    WHERE existing.composer_id = c.id AND existing.title = '론도 C단조'
)
AND NOT EXISTS (
    SELECT 1 FROM (SELECT namespace, external_id FROM piece_identifiers) taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '0205cab2-c960-40cc-8218-04215a0b47fa'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '0205cab2-c960-40cc-8218-04215a0b47fa'
FROM pieces p
WHERE p.composer_id = 28 AND p.title = '론도 C단조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM (SELECT namespace, external_id FROM piece_identifiers) taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '0205cab2-c960-40cc-8218-04215a0b47fa'
);


-- Op. 2 <돈 조반니>의 "라 치 다렘 라 마노" 주제에 의한 변주곡 B♭장조

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '<돈 조반니>의 "라 치 다렘 라 마노" 주제에 의한 변주곡 B♭장조', 'Variations in B♭ major on "Là ci darem la mano" from Mozart''s Don Giovanni', 'song', 'Op. 2', NULL, NULL, 1827, 'manual', 1
FROM composers c
WHERE c.id = 28
AND NOT EXISTS (
    SELECT 1 FROM (SELECT composer_id, title FROM pieces) existing
    WHERE existing.composer_id = c.id AND existing.title = '<돈 조반니>의 "라 치 다렘 라 마노" 주제에 의한 변주곡 B♭장조'
)
AND NOT EXISTS (
    SELECT 1 FROM (SELECT namespace, external_id FROM piece_identifiers) taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '76d9aed3-6912-3b9a-a18b-10f8285c2d9c'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '76d9aed3-6912-3b9a-a18b-10f8285c2d9c'
FROM pieces p
WHERE p.composer_id = 28 AND p.title = '<돈 조반니>의 "라 치 다렘 라 마노" 주제에 의한 변주곡 B♭장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM (SELECT namespace, external_id FROM piece_identifiers) taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '76d9aed3-6912-3b9a-a18b-10f8285c2d9c'
);


-- Op. 3 서주와 화려한 폴로네즈 C장조

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '서주와 화려한 폴로네즈 C장조', 'Introduction and Polonaise brillante in C major', 'song', 'Op. 3', NULL, NULL, 1829, 'manual', 1
FROM composers c
WHERE c.id = 28
AND NOT EXISTS (
    SELECT 1 FROM (SELECT composer_id, title FROM pieces) existing
    WHERE existing.composer_id = c.id AND existing.title = '서주와 화려한 폴로네즈 C장조'
)
AND NOT EXISTS (
    SELECT 1 FROM (SELECT namespace, external_id FROM piece_identifiers) taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'a7edf93f-0b82-35c1-bc27-f9c2efc29923'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'a7edf93f-0b82-35c1-bc27-f9c2efc29923'
FROM pieces p
WHERE p.composer_id = 28 AND p.title = '서주와 화려한 폴로네즈 C장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM (SELECT namespace, external_id FROM piece_identifiers) taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'a7edf93f-0b82-35c1-bc27-f9c2efc29923'
);


-- Op. 4 피아노 소나타 1번 C단조

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '피아노 소나타 1번 C단조', 'Piano Sonata No. 1 in C minor', 'album', 'Op. 4', NULL, NULL, 1828, 'manual', 1
FROM composers c
WHERE c.id = 28
AND NOT EXISTS (
    SELECT 1 FROM (SELECT composer_id, title FROM pieces) existing
    WHERE existing.composer_id = c.id AND existing.title = '피아노 소나타 1번 C단조'
)
AND NOT EXISTS (
    SELECT 1 FROM (SELECT namespace, external_id FROM piece_identifiers) taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'f37059d7-7725-4a49-9c11-39354eac6d81'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'f37059d7-7725-4a49-9c11-39354eac6d81'
FROM pieces p
WHERE p.composer_id = 28 AND p.title = '피아노 소나타 1번 C단조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM (SELECT namespace, external_id FROM piece_identifiers) taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'f37059d7-7725-4a49-9c11-39354eac6d81'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:5e03ae72-0959-3f7e-9007-2557f746f95a', 1, 'I', 'Allegro maestoso', 'I. Allegro maestoso', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 28 AND p.title = '피아노 소나타 1번 C단조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM (SELECT piece_id, part_key FROM piece_parts) existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:5e03ae72-0959-3f7e-9007-2557f746f95a'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:d2e9efbd-3d0f-37ce-830f-b15c8e5be487', 2, 'II', '미뉴에트', 'II. Menuetto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 28 AND p.title = '피아노 소나타 1번 C단조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM (SELECT piece_id, part_key FROM piece_parts) existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:d2e9efbd-3d0f-37ce-830f-b15c8e5be487'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:e03fe2ac-1224-3e39-b93a-6b2de55295fe', 3, 'III', 'Larghetto', 'III. Larghetto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 28 AND p.title = '피아노 소나타 1번 C단조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM (SELECT piece_id, part_key FROM piece_parts) existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:e03fe2ac-1224-3e39-b93a-6b2de55295fe'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:6a52595f-a8b8-349c-942d-9db48c7d104f', 4, 'IV', '피날레. Presto', 'IV. Finale. Presto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 28 AND p.title = '피아노 소나타 1번 C단조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM (SELECT piece_id, part_key FROM piece_parts) existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:6a52595f-a8b8-349c-942d-9db48c7d104f'
);


-- Op. 5 마주르카풍 론도 F장조

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '마주르카풍 론도 F장조', 'Rondo à la mazur in F major', 'song', 'Op. 5', NULL, NULL, 1826, 'manual', 1
FROM composers c
WHERE c.id = 28
AND NOT EXISTS (
    SELECT 1 FROM (SELECT composer_id, title FROM pieces) existing
    WHERE existing.composer_id = c.id AND existing.title = '마주르카풍 론도 F장조'
)
AND NOT EXISTS (
    SELECT 1 FROM (SELECT namespace, external_id FROM piece_identifiers) taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'e30abc66-bfba-43a8-8889-34ec49599d53'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'e30abc66-bfba-43a8-8889-34ec49599d53'
FROM pieces p
WHERE p.composer_id = 28 AND p.title = '마주르카풍 론도 F장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM (SELECT namespace, external_id FROM piece_identifiers) taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'e30abc66-bfba-43a8-8889-34ec49599d53'
);


-- Op. 6 마주르카 Op. 6

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '마주르카 Op. 6', '4 Mazurkas, Op. 6', 'album', NULL, 'Op.', '6', 1830, 'manual', 1
FROM composers c
WHERE c.id = 28
AND NOT EXISTS (
    SELECT 1 FROM (SELECT composer_id, title FROM pieces) existing
    WHERE existing.composer_id = c.id AND existing.title = '마주르카 Op. 6'
)
AND NOT EXISTS (
    SELECT 1 FROM (SELECT namespace, external_id FROM piece_identifiers) taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'ee497326-783e-411d-ab13-6ef64dd4dba5'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'ee497326-783e-411d-ab13-6ef64dd4dba5'
FROM pieces p
WHERE p.composer_id = 28 AND p.title = '마주르카 Op. 6' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM (SELECT namespace, external_id FROM piece_identifiers) taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'ee497326-783e-411d-ab13-6ef64dd4dba5'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:afb3c588-787c-3372-8425-8b46ddf9cf52', 1, NULL, 'F#단조', 'No. 1 in F# minor', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 28 AND p.title = '마주르카 Op. 6' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM (SELECT piece_id, part_key FROM piece_parts) existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:afb3c588-787c-3372-8425-8b46ddf9cf52'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:124c4818-a9e2-3445-ab9e-1e3d31c7c2a5', 2, NULL, 'C#단조', 'No. 2 in C# minor', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 28 AND p.title = '마주르카 Op. 6' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM (SELECT piece_id, part_key FROM piece_parts) existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:124c4818-a9e2-3445-ab9e-1e3d31c7c2a5'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:6e78f863-7068-3211-966b-f8cb1599859d', 3, NULL, 'E장조', 'No. 3 in E major', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 28 AND p.title = '마주르카 Op. 6' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM (SELECT piece_id, part_key FROM piece_parts) existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:6e78f863-7068-3211-966b-f8cb1599859d'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:277cc6f0-601e-3d8f-b337-f90aff78ae63', 4, NULL, 'E♭단조', 'No. 4 in E♭ minor', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 28 AND p.title = '마주르카 Op. 6' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM (SELECT piece_id, part_key FROM piece_parts) existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:277cc6f0-601e-3d8f-b337-f90aff78ae63'
);


-- Op. 7 마주르카 Op. 7

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '마주르카 Op. 7', '5 Mazurkas, Op. 7', 'album', NULL, 'Op.', '7', 1831, 'manual', 1
FROM composers c
WHERE c.id = 28
AND NOT EXISTS (
    SELECT 1 FROM (SELECT composer_id, title FROM pieces) existing
    WHERE existing.composer_id = c.id AND existing.title = '마주르카 Op. 7'
)
AND NOT EXISTS (
    SELECT 1 FROM (SELECT namespace, external_id FROM piece_identifiers) taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'db18d139-d9ee-4aa9-883d-702dace40603'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'db18d139-d9ee-4aa9-883d-702dace40603'
FROM pieces p
WHERE p.composer_id = 28 AND p.title = '마주르카 Op. 7' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM (SELECT namespace, external_id FROM piece_identifiers) taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'db18d139-d9ee-4aa9-883d-702dace40603'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:7c2dfedf-ad3d-3abc-b1c0-32263ca931b3', 1, NULL, 'B♭장조', 'No. 1 in B♭ major', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 28 AND p.title = '마주르카 Op. 7' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM (SELECT piece_id, part_key FROM piece_parts) existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:7c2dfedf-ad3d-3abc-b1c0-32263ca931b3'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:aea292ab-3d0a-4fd7-837e-f095d2c48721', 2, NULL, 'A단조', 'No. 2 in A minor', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 28 AND p.title = '마주르카 Op. 7' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM (SELECT piece_id, part_key FROM piece_parts) existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:aea292ab-3d0a-4fd7-837e-f095d2c48721'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:62809ad0-c222-33bc-aa35-2d52467b9690', 3, NULL, 'F단조', 'No. 3 in F minor', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 28 AND p.title = '마주르카 Op. 7' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM (SELECT piece_id, part_key FROM piece_parts) existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:62809ad0-c222-33bc-aa35-2d52467b9690'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:9eb2b772-9cb6-3d5f-a3a8-7da1f0713705', 4, NULL, 'A♭장조', 'No. 4 in A♭ major', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 28 AND p.title = '마주르카 Op. 7' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM (SELECT piece_id, part_key FROM piece_parts) existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:9eb2b772-9cb6-3d5f-a3a8-7da1f0713705'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:30685f58-c530-313a-8143-09915cd615e1', 5, NULL, 'C장조', 'No. 5 in C major', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 28 AND p.title = '마주르카 Op. 7' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM (SELECT piece_id, part_key FROM piece_parts) existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:30685f58-c530-313a-8143-09915cd615e1'
);


-- Op. 8 피아노 3중주 G단조

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '피아노 3중주 G단조', 'Piano Trio in G minor', 'album', 'Op. 8', NULL, NULL, 1829, 'manual', 1
FROM composers c
WHERE c.id = 28
AND NOT EXISTS (
    SELECT 1 FROM (SELECT composer_id, title FROM pieces) existing
    WHERE existing.composer_id = c.id AND existing.title = '피아노 3중주 G단조'
)
AND NOT EXISTS (
    SELECT 1 FROM (SELECT namespace, external_id FROM piece_identifiers) taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'b3209790-aef8-4a67-bf9d-d12c70c73714'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'b3209790-aef8-4a67-bf9d-d12c70c73714'
FROM pieces p
WHERE p.composer_id = 28 AND p.title = '피아노 3중주 G단조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM (SELECT namespace, external_id FROM piece_identifiers) taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'b3209790-aef8-4a67-bf9d-d12c70c73714'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:e10b287a-d51c-3876-89d0-2af4e129dc44', 1, 'I', 'Allegro con fuoco', 'I. Allegro con fuoco', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 28 AND p.title = '피아노 3중주 G단조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM (SELECT piece_id, part_key FROM piece_parts) existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:e10b287a-d51c-3876-89d0-2af4e129dc44'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:280fc54a-1768-30b2-bc85-315e255489f9', 2, 'II', '스케르초. Con moto, ma non troppo', 'II. Scherzo. Con moto, ma non troppo', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 28 AND p.title = '피아노 3중주 G단조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM (SELECT piece_id, part_key FROM piece_parts) existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:280fc54a-1768-30b2-bc85-315e255489f9'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:cde08b6e-c4ae-384b-bd69-85b898da4026', 3, 'III', 'Adagio sostenuto', 'III. Adagio sostenuto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 28 AND p.title = '피아노 3중주 G단조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM (SELECT piece_id, part_key FROM piece_parts) existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:cde08b6e-c4ae-384b-bd69-85b898da4026'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:4d14f280-e237-3e78-857f-453544b6b4f9', 4, 'IV', '피날레. Allegretto', 'IV. Finale. Allegretto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 28 AND p.title = '피아노 3중주 G단조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM (SELECT piece_id, part_key FROM piece_parts) existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:4d14f280-e237-3e78-857f-453544b6b4f9'
);


-- Op. 9 녹턴 Op. 9

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '녹턴 Op. 9', '3 Nocturnes, Op. 9', 'album', NULL, 'Op.', '9', 1832, 'manual', 1
FROM composers c
WHERE c.id = 28
AND NOT EXISTS (
    SELECT 1 FROM (SELECT composer_id, title FROM pieces) existing
    WHERE existing.composer_id = c.id AND existing.title = '녹턴 Op. 9'
)
AND NOT EXISTS (
    SELECT 1 FROM (SELECT namespace, external_id FROM piece_identifiers) taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '660d0d25-4253-4d30-a818-61fc94e375bf'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '660d0d25-4253-4d30-a818-61fc94e375bf'
FROM pieces p
WHERE p.composer_id = 28 AND p.title = '녹턴 Op. 9' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM (SELECT namespace, external_id FROM piece_identifiers) taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '660d0d25-4253-4d30-a818-61fc94e375bf'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:2f7f4732-9b12-4185-b171-02726ad2f3e5', 1, NULL, 'B♭단조', 'No. 1 in B♭ minor', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 28 AND p.title = '녹턴 Op. 9' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM (SELECT piece_id, part_key FROM piece_parts) existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:2f7f4732-9b12-4185-b171-02726ad2f3e5'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM (SELECT id, composer_id FROM pieces) linked WHERE linked.id = 131 AND linked.composer_id = 28), 'musicbrainz:1e14127f-0686-3b29-b56f-501044d019b3', 2, NULL, 'E♭장조', 'No. 2 in E♭ major', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 28 AND p.title = '녹턴 Op. 9' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM (SELECT piece_id, part_key FROM piece_parts) existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:1e14127f-0686-3b29-b56f-501044d019b3'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:3d474b73-41e9-43c3-92b4-10cb4d1fceb0', 3, NULL, 'B장조', 'No. 3 in B major', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 28 AND p.title = '녹턴 Op. 9' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM (SELECT piece_id, part_key FROM piece_parts) existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:3d474b73-41e9-43c3-92b4-10cb4d1fceb0'
);


-- Op. 10 연습곡 Op. 10

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '연습곡 Op. 10', '12 Études, Op. 10', 'album', NULL, 'Op.', '10', 1832, 'manual', 1
FROM composers c
WHERE c.id = 28
AND NOT EXISTS (
    SELECT 1 FROM (SELECT composer_id, title FROM pieces) existing
    WHERE existing.composer_id = c.id AND existing.title = '연습곡 Op. 10'
)
AND NOT EXISTS (
    SELECT 1 FROM (SELECT namespace, external_id FROM piece_identifiers) taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '09fb2287-f5d3-4bf6-aa2d-ae6b07352b68'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '09fb2287-f5d3-4bf6-aa2d-ae6b07352b68'
FROM pieces p
WHERE p.composer_id = 28 AND p.title = '연습곡 Op. 10' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM (SELECT namespace, external_id FROM piece_identifiers) taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '09fb2287-f5d3-4bf6-aa2d-ae6b07352b68'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM (SELECT id, composer_id FROM pieces) linked WHERE linked.id = 26048 AND linked.composer_id = 28), 'musicbrainz:3c6f04d7-dca0-3f06-b603-0d9d8cecdb27', 1, NULL, 'C장조', 'No. 1 in C major', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 28 AND p.title = '연습곡 Op. 10' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM (SELECT piece_id, part_key FROM piece_parts) existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:3c6f04d7-dca0-3f06-b603-0d9d8cecdb27'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:440b8741-8c2b-31f0-9957-e144dd247ff2', 2, NULL, 'A단조', 'No. 2 in A minor', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 28 AND p.title = '연습곡 Op. 10' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM (SELECT piece_id, part_key FROM piece_parts) existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:440b8741-8c2b-31f0-9957-e144dd247ff2'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM (SELECT id, composer_id FROM pieces) linked WHERE linked.id = 447 AND linked.composer_id = 28), 'musicbrainz:1d9d388e-e80f-3702-96b3-64a0949cadce', 3, NULL, 'E장조 "이별의 곡"', 'No. 3 in E major "Tristesse"', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 28 AND p.title = '연습곡 Op. 10' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM (SELECT piece_id, part_key FROM piece_parts) existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:1d9d388e-e80f-3702-96b3-64a0949cadce'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:c1bcf932-730c-3fd7-b493-dc7830f51a60', 4, NULL, 'C#단조', 'No. 4 in C# minor', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 28 AND p.title = '연습곡 Op. 10' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM (SELECT piece_id, part_key FROM piece_parts) existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:c1bcf932-730c-3fd7-b493-dc7830f51a60'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:f30cac97-ead5-3450-b26e-6dc1d9080ba7', 5, NULL, 'G♭장조 "흑건"', 'No. 5 in G♭ major "Black Keys"', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 28 AND p.title = '연습곡 Op. 10' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM (SELECT piece_id, part_key FROM piece_parts) existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:f30cac97-ead5-3450-b26e-6dc1d9080ba7'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:8341d69f-e587-3bf7-afb0-ea0190821828', 6, NULL, 'E♭단조', 'No. 6 in E♭ minor', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 28 AND p.title = '연습곡 Op. 10' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM (SELECT piece_id, part_key FROM piece_parts) existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:8341d69f-e587-3bf7-afb0-ea0190821828'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:582a9f19-7758-3f22-99f2-7c80bd346f7c', 7, NULL, 'C장조', 'No. 7 in C major', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 28 AND p.title = '연습곡 Op. 10' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM (SELECT piece_id, part_key FROM piece_parts) existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:582a9f19-7758-3f22-99f2-7c80bd346f7c'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:fff87a58-6d69-3b37-b6b9-8f836905aeb8', 8, NULL, 'F장조', 'No. 8 in F major', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 28 AND p.title = '연습곡 Op. 10' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM (SELECT piece_id, part_key FROM piece_parts) existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:fff87a58-6d69-3b37-b6b9-8f836905aeb8'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:2baecdcd-6083-341f-837a-847a20737063', 9, NULL, 'F단조', 'No. 9 in F minor', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 28 AND p.title = '연습곡 Op. 10' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM (SELECT piece_id, part_key FROM piece_parts) existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:2baecdcd-6083-341f-837a-847a20737063'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:f087599c-8ca9-33b5-8296-6e8a7d167ef9', 10, NULL, 'A♭장조', 'No. 10 in A♭ major', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 28 AND p.title = '연습곡 Op. 10' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM (SELECT piece_id, part_key FROM piece_parts) existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:f087599c-8ca9-33b5-8296-6e8a7d167ef9'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:9c3bdc9e-6d03-390d-b78f-9c0e364bd354', 11, NULL, 'E♭장조', 'No. 11 in E♭ major', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 28 AND p.title = '연습곡 Op. 10' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM (SELECT piece_id, part_key FROM piece_parts) existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:9c3bdc9e-6d03-390d-b78f-9c0e364bd354'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM (SELECT id, composer_id FROM pieces) linked WHERE linked.id = 127 AND linked.composer_id = 28), 'musicbrainz:45fc7e48-c655-3f5c-bfe7-704a9784225e', 12, NULL, 'C단조 "혁명"', 'No. 12 in C minor "Revolutionary"', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 28 AND p.title = '연습곡 Op. 10' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM (SELECT piece_id, part_key FROM piece_parts) existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:45fc7e48-c655-3f5c-bfe7-704a9784225e'
);


-- Op. 11 피아노 협주곡 1번 E단조

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:d969c022-6d25-3dbb-8102-95a3d9d3de83', 1, 'I', 'Allegro maestoso', 'I. Allegro maestoso', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 132 AND p.composer_id = 28
AND NOT EXISTS (
    SELECT 1 FROM (SELECT piece_id, part_key FROM piece_parts) existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:d969c022-6d25-3dbb-8102-95a3d9d3de83'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:e84bb55d-522e-3ec1-890a-ae64fe417f53', 2, 'II', '로망스. Larghetto', 'II. Romance. Larghetto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 132 AND p.composer_id = 28
AND NOT EXISTS (
    SELECT 1 FROM (SELECT piece_id, part_key FROM piece_parts) existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:e84bb55d-522e-3ec1-890a-ae64fe417f53'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:e3e7c7e4-ec65-35af-a42d-b698daadcc01', 3, 'III', '론도. Vivace', 'III. Rondo. Vivace', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 132 AND p.composer_id = 28
AND NOT EXISTS (
    SELECT 1 FROM (SELECT piece_id, part_key FROM piece_parts) existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:e3e7c7e4-ec65-35af-a42d-b698daadcc01'
);


-- Op. 12 화려한 변주곡 B♭장조

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '화려한 변주곡 B♭장조', 'Variations brillantes in B♭ major on "Je vends des scapulaires" from Hérold''s Ludovic', 'song', 'Op. 12', NULL, NULL, 1833, 'manual', 1
FROM composers c
WHERE c.id = 28
AND NOT EXISTS (
    SELECT 1 FROM (SELECT composer_id, title FROM pieces) existing
    WHERE existing.composer_id = c.id AND existing.title = '화려한 변주곡 B♭장조'
)
AND NOT EXISTS (
    SELECT 1 FROM (SELECT namespace, external_id FROM piece_identifiers) taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '373c3b40-f270-4326-bca4-d9e4885d7076'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '373c3b40-f270-4326-bca4-d9e4885d7076'
FROM pieces p
WHERE p.composer_id = 28 AND p.title = '화려한 변주곡 B♭장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM (SELECT namespace, external_id FROM piece_identifiers) taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '373c3b40-f270-4326-bca4-d9e4885d7076'
);


-- Op. 13 폴란드 민요에 의한 환상곡 A장조

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '폴란드 민요에 의한 환상곡 A장조', 'Fantasy on Polish Airs in A major', 'song', 'Op. 13', NULL, NULL, 1830, 'manual', 1
FROM composers c
WHERE c.id = 28
AND NOT EXISTS (
    SELECT 1 FROM (SELECT composer_id, title FROM pieces) existing
    WHERE existing.composer_id = c.id AND existing.title = '폴란드 민요에 의한 환상곡 A장조'
)
AND NOT EXISTS (
    SELECT 1 FROM (SELECT namespace, external_id FROM piece_identifiers) taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '953ffa3e-effa-3a72-9d67-b623431a51cc'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '953ffa3e-effa-3a72-9d67-b623431a51cc'
FROM pieces p
WHERE p.composer_id = 28 AND p.title = '폴란드 민요에 의한 환상곡 A장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM (SELECT namespace, external_id FROM piece_identifiers) taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '953ffa3e-effa-3a72-9d67-b623431a51cc'
);


-- Op. 14 크라코비아크풍 론도 F장조

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '크라코비아크풍 론도 F장조', 'Rondo à la Krakowiak in F major', 'song', 'Op. 14', NULL, NULL, 1828, 'manual', 1
FROM composers c
WHERE c.id = 28
AND NOT EXISTS (
    SELECT 1 FROM (SELECT composer_id, title FROM pieces) existing
    WHERE existing.composer_id = c.id AND existing.title = '크라코비아크풍 론도 F장조'
)
AND NOT EXISTS (
    SELECT 1 FROM (SELECT namespace, external_id FROM piece_identifiers) taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '80a00b47-091b-3024-9ea6-5e31bcce9389'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '80a00b47-091b-3024-9ea6-5e31bcce9389'
FROM pieces p
WHERE p.composer_id = 28 AND p.title = '크라코비아크풍 론도 F장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM (SELECT namespace, external_id FROM piece_identifiers) taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '80a00b47-091b-3024-9ea6-5e31bcce9389'
);


-- Op. 15 녹턴 Op. 15

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '녹턴 Op. 15', '3 Nocturnes, Op. 15', 'album', NULL, 'Op.', '15', 1833, 'manual', 1
FROM composers c
WHERE c.id = 28
AND NOT EXISTS (
    SELECT 1 FROM (SELECT composer_id, title FROM pieces) existing
    WHERE existing.composer_id = c.id AND existing.title = '녹턴 Op. 15'
)
AND NOT EXISTS (
    SELECT 1 FROM (SELECT namespace, external_id FROM piece_identifiers) taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '4965815e-43b7-4d51-82dd-c19838b348c8'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '4965815e-43b7-4d51-82dd-c19838b348c8'
FROM pieces p
WHERE p.composer_id = 28 AND p.title = '녹턴 Op. 15' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM (SELECT namespace, external_id FROM piece_identifiers) taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '4965815e-43b7-4d51-82dd-c19838b348c8'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:3faeadb9-d577-3423-8b26-62a796b3bb4a', 1, NULL, 'F장조', 'No. 1 in F major', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 28 AND p.title = '녹턴 Op. 15' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM (SELECT piece_id, part_key FROM piece_parts) existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:3faeadb9-d577-3423-8b26-62a796b3bb4a'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:4043b9eb-01b2-368a-9ef5-3ea929513e8d', 2, NULL, 'F#장조', 'No. 2 in F# major', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 28 AND p.title = '녹턴 Op. 15' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM (SELECT piece_id, part_key FROM piece_parts) existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:4043b9eb-01b2-368a-9ef5-3ea929513e8d'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:296c95d4-e09b-389c-a78e-7c3910e6b494', 3, NULL, 'G단조', 'No. 3 in G minor', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 28 AND p.title = '녹턴 Op. 15' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM (SELECT piece_id, part_key FROM piece_parts) existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:296c95d4-e09b-389c-a78e-7c3910e6b494'
);


-- Op. 16 서주와 론도 E♭장조

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '서주와 론도 E♭장조', 'Introduction and Rondo in E♭ major', 'song', 'Op. 16', NULL, NULL, 1833, 'manual', 1
FROM composers c
WHERE c.id = 28
AND NOT EXISTS (
    SELECT 1 FROM (SELECT composer_id, title FROM pieces) existing
    WHERE existing.composer_id = c.id AND existing.title = '서주와 론도 E♭장조'
)
AND NOT EXISTS (
    SELECT 1 FROM (SELECT namespace, external_id FROM piece_identifiers) taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'eb008df7-0a70-443b-bfee-fa5505b24386'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'eb008df7-0a70-443b-bfee-fa5505b24386'
FROM pieces p
WHERE p.composer_id = 28 AND p.title = '서주와 론도 E♭장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM (SELECT namespace, external_id FROM piece_identifiers) taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'eb008df7-0a70-443b-bfee-fa5505b24386'
);


-- Op. 17 마주르카 Op. 17

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '마주르카 Op. 17', '4 Mazurkas, Op. 17', 'album', NULL, 'Op.', '17', 1833, 'manual', 1
FROM composers c
WHERE c.id = 28
AND NOT EXISTS (
    SELECT 1 FROM (SELECT composer_id, title FROM pieces) existing
    WHERE existing.composer_id = c.id AND existing.title = '마주르카 Op. 17'
)
AND NOT EXISTS (
    SELECT 1 FROM (SELECT namespace, external_id FROM piece_identifiers) taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '99abedc4-c812-42f3-a985-a8d82dc1cce1'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '99abedc4-c812-42f3-a985-a8d82dc1cce1'
FROM pieces p
WHERE p.composer_id = 28 AND p.title = '마주르카 Op. 17' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM (SELECT namespace, external_id FROM piece_identifiers) taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '99abedc4-c812-42f3-a985-a8d82dc1cce1'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:aea0d2a5-72d7-3e3d-9e47-f70beb147ee8', 1, NULL, 'B♭장조', 'No. 1 in B♭ major', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 28 AND p.title = '마주르카 Op. 17' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM (SELECT piece_id, part_key FROM piece_parts) existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:aea0d2a5-72d7-3e3d-9e47-f70beb147ee8'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:9a6da832-bb58-3748-8b90-8d4d1d3bb6be', 2, NULL, 'E단조', 'No. 2 in E minor', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 28 AND p.title = '마주르카 Op. 17' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM (SELECT piece_id, part_key FROM piece_parts) existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:9a6da832-bb58-3748-8b90-8d4d1d3bb6be'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:d7889684-67e8-3279-b054-ea293f79f7f5', 3, NULL, 'A♭장조', 'No. 3 in A♭ major', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 28 AND p.title = '마주르카 Op. 17' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM (SELECT piece_id, part_key FROM piece_parts) existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:d7889684-67e8-3279-b054-ea293f79f7f5'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:f3cd8266-6640-36f9-a8e3-ba3176017620', 4, NULL, 'A단조', 'No. 4 in A minor', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 28 AND p.title = '마주르카 Op. 17' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM (SELECT piece_id, part_key FROM piece_parts) existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:f3cd8266-6640-36f9-a8e3-ba3176017620'
);


-- Op. 18 왈츠 1번 E♭장조 "화려한 대왈츠"

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '왈츠 1번 E♭장조 "화려한 대왈츠"', 'Waltz No. 1 in E♭ major "Grande valse brillante"', 'song', 'Op. 18', NULL, NULL, 1833, 'manual', 1
FROM composers c
WHERE c.id = 28
AND NOT EXISTS (
    SELECT 1 FROM (SELECT composer_id, title FROM pieces) existing
    WHERE existing.composer_id = c.id AND existing.title = '왈츠 1번 E♭장조 "화려한 대왈츠"'
)
AND NOT EXISTS (
    SELECT 1 FROM (SELECT namespace, external_id FROM piece_identifiers) taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'dad62c26-f0f3-3d1d-a491-62078052c449'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'dad62c26-f0f3-3d1d-a491-62078052c449'
FROM pieces p
WHERE p.composer_id = 28 AND p.title = '왈츠 1번 E♭장조 "화려한 대왈츠"' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM (SELECT namespace, external_id FROM piece_identifiers) taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'dad62c26-f0f3-3d1d-a491-62078052c449'
);


-- Op. 19 볼레로 A단조

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '볼레로 A단조', 'Boléro in A minor', 'song', 'Op. 19', NULL, NULL, 1833, 'manual', 1
FROM composers c
WHERE c.id = 28
AND NOT EXISTS (
    SELECT 1 FROM (SELECT composer_id, title FROM pieces) existing
    WHERE existing.composer_id = c.id AND existing.title = '볼레로 A단조'
)
AND NOT EXISTS (
    SELECT 1 FROM (SELECT namespace, external_id FROM piece_identifiers) taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '06213b1a-2f3b-3414-8249-76851159f4d9'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '06213b1a-2f3b-3414-8249-76851159f4d9'
FROM pieces p
WHERE p.composer_id = 28 AND p.title = '볼레로 A단조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM (SELECT namespace, external_id FROM piece_identifiers) taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '06213b1a-2f3b-3414-8249-76851159f4d9'
);


-- Op. 20 스케르초 1번 B단조

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '스케르초 1번 B단조', 'Scherzo No. 1 in B minor', 'song', 'Op. 20', NULL, NULL, 1833, 'manual', 1
FROM composers c
WHERE c.id = 28
AND NOT EXISTS (
    SELECT 1 FROM (SELECT composer_id, title FROM pieces) existing
    WHERE existing.composer_id = c.id AND existing.title = '스케르초 1번 B단조'
)
AND NOT EXISTS (
    SELECT 1 FROM (SELECT namespace, external_id FROM piece_identifiers) taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '64afd6ef-e9ee-3785-a9a3-ffbf0d935b0f'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '64afd6ef-e9ee-3785-a9a3-ffbf0d935b0f'
FROM pieces p
WHERE p.composer_id = 28 AND p.title = '스케르초 1번 B단조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM (SELECT namespace, external_id FROM piece_identifiers) taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '64afd6ef-e9ee-3785-a9a3-ffbf0d935b0f'
);


-- Op. 21 피아노 협주곡 2번 F단조

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '피아노 협주곡 2번 F단조', 'Piano Concerto No. 2 in F minor', 'album', 'Op. 21', NULL, NULL, 1830, 'manual', 1
FROM composers c
WHERE c.id = 28
AND NOT EXISTS (
    SELECT 1 FROM (SELECT composer_id, title FROM pieces) existing
    WHERE existing.composer_id = c.id AND existing.title = '피아노 협주곡 2번 F단조'
)
AND NOT EXISTS (
    SELECT 1 FROM (SELECT namespace, external_id FROM piece_identifiers) taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'dda6229e-96ab-38dc-b48d-9ea6efa48c56'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'dda6229e-96ab-38dc-b48d-9ea6efa48c56'
FROM pieces p
WHERE p.composer_id = 28 AND p.title = '피아노 협주곡 2번 F단조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM (SELECT namespace, external_id FROM piece_identifiers) taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'dda6229e-96ab-38dc-b48d-9ea6efa48c56'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:160658f6-ee32-33f7-8b10-658fad47a544', 1, 'I', 'Maestoso', 'I. Maestoso', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 28 AND p.title = '피아노 협주곡 2번 F단조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM (SELECT piece_id, part_key FROM piece_parts) existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:160658f6-ee32-33f7-8b10-658fad47a544'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:7dcac5ec-59fd-357f-b14e-855ede5240f9', 2, 'II', 'Larghetto', 'II. Larghetto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 28 AND p.title = '피아노 협주곡 2번 F단조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM (SELECT piece_id, part_key FROM piece_parts) existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:7dcac5ec-59fd-357f-b14e-855ede5240f9'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:4f2c391e-2981-3ee4-8337-16a74b79b4dc', 3, 'III', 'Allegro vivace', 'III. Allegro vivace', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 28 AND p.title = '피아노 협주곡 2번 F단조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM (SELECT piece_id, part_key FROM piece_parts) existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:4f2c391e-2981-3ee4-8337-16a74b79b4dc'
);


-- Op. 22 안단테 스피아나토와 화려한 대폴로네즈

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:fe4f1e5e-1220-3bf1-bbe9-9e3b7f384745', 1, NULL, '안단테 스피아나토', 'Andante spianato', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 26036 AND p.composer_id = 28
AND NOT EXISTS (
    SELECT 1 FROM (SELECT piece_id, part_key FROM piece_parts) existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:fe4f1e5e-1220-3bf1-bbe9-9e3b7f384745'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:bfb78610-eb0c-36b6-8a89-29f003a404d2', 2, NULL, '화려한 대폴로네즈. Allegro molto', 'Grande polonaise brillante. Allegro molto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 26036 AND p.composer_id = 28
AND NOT EXISTS (
    SELECT 1 FROM (SELECT piece_id, part_key FROM piece_parts) existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:bfb78610-eb0c-36b6-8a89-29f003a404d2'
);


-- Op. 24 마주르카 Op. 24

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '마주르카 Op. 24', '4 Mazurkas, Op. 24', 'album', NULL, 'Op.', '24', 1835, 'manual', 1
FROM composers c
WHERE c.id = 28
AND NOT EXISTS (
    SELECT 1 FROM (SELECT composer_id, title FROM pieces) existing
    WHERE existing.composer_id = c.id AND existing.title = '마주르카 Op. 24'
)
AND NOT EXISTS (
    SELECT 1 FROM (SELECT namespace, external_id FROM piece_identifiers) taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'd6df8d5e-dd6e-453b-95d7-c9fefb022159'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'd6df8d5e-dd6e-453b-95d7-c9fefb022159'
FROM pieces p
WHERE p.composer_id = 28 AND p.title = '마주르카 Op. 24' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM (SELECT namespace, external_id FROM piece_identifiers) taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'd6df8d5e-dd6e-453b-95d7-c9fefb022159'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:d42840ac-b55b-3a0c-b7ac-62a1455700a4', 1, NULL, 'G단조', 'No. 1 in G minor', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 28 AND p.title = '마주르카 Op. 24' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM (SELECT piece_id, part_key FROM piece_parts) existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:d42840ac-b55b-3a0c-b7ac-62a1455700a4'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:c51f22a9-cdd7-3b1a-aef3-0df13c32e0bf', 2, NULL, 'C장조', 'No. 2 in C major', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 28 AND p.title = '마주르카 Op. 24' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM (SELECT piece_id, part_key FROM piece_parts) existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:c51f22a9-cdd7-3b1a-aef3-0df13c32e0bf'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:14841197-b001-369d-af07-987883fa7708', 3, NULL, 'A♭장조', 'No. 3 in A♭ major', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 28 AND p.title = '마주르카 Op. 24' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM (SELECT piece_id, part_key FROM piece_parts) existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:14841197-b001-369d-af07-987883fa7708'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:60cb4bef-531f-3e5d-a56e-553db3ff3c10', 4, NULL, 'B♭단조', 'No. 4 in B♭ minor', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 28 AND p.title = '마주르카 Op. 24' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM (SELECT piece_id, part_key FROM piece_parts) existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:60cb4bef-531f-3e5d-a56e-553db3ff3c10'
);


-- Op. 25 연습곡 Op. 25

UPDATE pieces piece
SET piece.catalogue_system = 'Op.', piece.catalogue_number = '25'
WHERE piece.id = 463 AND piece.composer_id = 28
  AND piece.catalogue_number IS NULL AND piece.opus_number IS NULL;

UPDATE pieces piece
SET piece.composition_year = 1836
WHERE piece.id = 463 AND piece.composer_id = 28 AND piece.composition_year IS NULL;

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:198affaf-7475-3ea3-adde-0b46f15b2b3d', 1, NULL, 'A♭장조 "에올리언 하프"', 'No. 1 in A♭ major "Aeolian Harp"', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 463 AND p.composer_id = 28
AND NOT EXISTS (
    SELECT 1 FROM (SELECT piece_id, part_key FROM piece_parts) existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:198affaf-7475-3ea3-adde-0b46f15b2b3d'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:33b30b84-b5a7-3a41-9b48-6a1177928dbc', 2, NULL, 'F단조', 'No. 2 in F minor', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 463 AND p.composer_id = 28
AND NOT EXISTS (
    SELECT 1 FROM (SELECT piece_id, part_key FROM piece_parts) existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:33b30b84-b5a7-3a41-9b48-6a1177928dbc'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:498da548-4b62-3f3c-9113-03397d9a53df', 3, NULL, 'F장조', 'No. 3 in F major', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 463 AND p.composer_id = 28
AND NOT EXISTS (
    SELECT 1 FROM (SELECT piece_id, part_key FROM piece_parts) existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:498da548-4b62-3f3c-9113-03397d9a53df'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:5c0a978b-e978-3e04-9cd3-b15bfe3322b6', 4, NULL, 'A단조', 'No. 4 in A minor', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 463 AND p.composer_id = 28
AND NOT EXISTS (
    SELECT 1 FROM (SELECT piece_id, part_key FROM piece_parts) existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:5c0a978b-e978-3e04-9cd3-b15bfe3322b6'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:3420d060-dbe3-33f1-aa57-b342608f94a5', 5, NULL, 'E단조', 'No. 5 in E minor', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 463 AND p.composer_id = 28
AND NOT EXISTS (
    SELECT 1 FROM (SELECT piece_id, part_key FROM piece_parts) existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:3420d060-dbe3-33f1-aa57-b342608f94a5'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:3946dfe0-7b1e-3bcf-bdab-80193dba31c5', 6, NULL, 'G#단조 "3도"', 'No. 6 in G# minor "Thirds"', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 463 AND p.composer_id = 28
AND NOT EXISTS (
    SELECT 1 FROM (SELECT piece_id, part_key FROM piece_parts) existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:3946dfe0-7b1e-3bcf-bdab-80193dba31c5'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:5b2ad9b8-a992-393f-856a-a06d8b987d17', 7, NULL, 'C#단조', 'No. 7 in C# minor', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 463 AND p.composer_id = 28
AND NOT EXISTS (
    SELECT 1 FROM (SELECT piece_id, part_key FROM piece_parts) existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:5b2ad9b8-a992-393f-856a-a06d8b987d17'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:5867e3c8-4ba7-3349-b8d2-cbab143f59bf', 8, NULL, 'D♭장조 "6도"', 'No. 8 in D♭ major "Sixths"', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 463 AND p.composer_id = 28
AND NOT EXISTS (
    SELECT 1 FROM (SELECT piece_id, part_key FROM piece_parts) existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:5867e3c8-4ba7-3349-b8d2-cbab143f59bf'
);

UPDATE piece_parts part
SET part.name_ko = 'G♭장조 "나비"', part.name_en = 'No. 9 in G♭ major "Butterfly"', part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE part.id = 1 AND part.piece_id = 463
  AND part.part_key = 'musicbrainz:0a957e8a-0b86-30c5-bfa9-ad095ee43be8' AND part.sequence_number = 9 AND part.editor_locked = 0;

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:299558f7-e25b-3ada-a0d9-b50b1268d326', 10, NULL, 'B단조 "옥타브"', 'No. 10 in B minor "Octaves"', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 463 AND p.composer_id = 28
AND NOT EXISTS (
    SELECT 1 FROM (SELECT piece_id, part_key FROM piece_parts) existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:299558f7-e25b-3ada-a0d9-b50b1268d326'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:551b5d69-11a0-38f3-9b77-944a151500a3', 11, NULL, 'A단조 "겨울바람"', 'No. 11 in A minor "Winter Wind"', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 463 AND p.composer_id = 28
AND NOT EXISTS (
    SELECT 1 FROM (SELECT piece_id, part_key FROM piece_parts) existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:551b5d69-11a0-38f3-9b77-944a151500a3'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:bdaa998e-7f20-3b63-9c94-4967645affa7', 12, NULL, 'C단조 "대양"', 'No. 12 in C minor "Ocean"', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 463 AND p.composer_id = 28
AND NOT EXISTS (
    SELECT 1 FROM (SELECT piece_id, part_key FROM piece_parts) existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:bdaa998e-7f20-3b63-9c94-4967645affa7'
);


-- Op. 26 폴로네즈 Op. 26

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '폴로네즈 Op. 26', '2 Polonaises, Op. 26', 'album', NULL, 'Op.', '26', 1836, 'manual', 1
FROM composers c
WHERE c.id = 28
AND NOT EXISTS (
    SELECT 1 FROM (SELECT composer_id, title FROM pieces) existing
    WHERE existing.composer_id = c.id AND existing.title = '폴로네즈 Op. 26'
)
AND NOT EXISTS (
    SELECT 1 FROM (SELECT namespace, external_id FROM piece_identifiers) taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '79bce015-c77e-4da4-aecf-bf6a1f4a62ff'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '79bce015-c77e-4da4-aecf-bf6a1f4a62ff'
FROM pieces p
WHERE p.composer_id = 28 AND p.title = '폴로네즈 Op. 26' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM (SELECT namespace, external_id FROM piece_identifiers) taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '79bce015-c77e-4da4-aecf-bf6a1f4a62ff'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:f65ccdc1-d0d4-3c60-83f4-db63f213b89b', 1, NULL, 'C#단조', 'No. 1 in C# minor', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 28 AND p.title = '폴로네즈 Op. 26' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM (SELECT piece_id, part_key FROM piece_parts) existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:f65ccdc1-d0d4-3c60-83f4-db63f213b89b'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:43df241d-43ee-374a-9e94-014680d9d2b0', 2, NULL, 'E♭단조', 'No. 2 in E♭ minor', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 28 AND p.title = '폴로네즈 Op. 26' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM (SELECT piece_id, part_key FROM piece_parts) existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:43df241d-43ee-374a-9e94-014680d9d2b0'
);


-- Op. 27 녹턴 Op. 27

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '녹턴 Op. 27', '2 Nocturnes, Op. 27', 'album', NULL, 'Op.', '27', 1836, 'manual', 1
FROM composers c
WHERE c.id = 28
AND NOT EXISTS (
    SELECT 1 FROM (SELECT composer_id, title FROM pieces) existing
    WHERE existing.composer_id = c.id AND existing.title = '녹턴 Op. 27'
)
AND NOT EXISTS (
    SELECT 1 FROM (SELECT namespace, external_id FROM piece_identifiers) taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'dc6c3632-3852-4d33-8219-0e9c5ae2ba28'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'dc6c3632-3852-4d33-8219-0e9c5ae2ba28'
FROM pieces p
WHERE p.composer_id = 28 AND p.title = '녹턴 Op. 27' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM (SELECT namespace, external_id FROM piece_identifiers) taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'dc6c3632-3852-4d33-8219-0e9c5ae2ba28'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:02d4d111-1a4c-38f0-b599-a2f92f9810d2', 1, NULL, 'C#단조', 'No. 1 in C# minor', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 28 AND p.title = '녹턴 Op. 27' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM (SELECT piece_id, part_key FROM piece_parts) existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:02d4d111-1a4c-38f0-b599-a2f92f9810d2'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:db13a2b1-1bce-3cfa-945d-1cf4df7eeccf', 2, NULL, 'D♭장조', 'No. 2 in D♭ major', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 28 AND p.title = '녹턴 Op. 27' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM (SELECT piece_id, part_key FROM piece_parts) existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:db13a2b1-1bce-3cfa-945d-1cf4df7eeccf'
);


-- Op. 28 24개의 전주곡 Op. 28

UPDATE pieces piece
SET piece.catalogue_system = 'Op.', piece.catalogue_number = '28'
WHERE piece.id = 465 AND piece.composer_id = 28
  AND piece.catalogue_number IS NULL AND piece.opus_number IS NULL;

UPDATE pieces piece
SET piece.composition_year = 1839
WHERE piece.id = 465 AND piece.composer_id = 28 AND piece.composition_year IS NULL;

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:954e6c5e-b4d2-31e8-ad36-e2108e823f80', 1, NULL, 'C장조', 'No. 1 in C major', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 465 AND p.composer_id = 28
AND NOT EXISTS (
    SELECT 1 FROM (SELECT piece_id, part_key FROM piece_parts) existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:954e6c5e-b4d2-31e8-ad36-e2108e823f80'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:e8b29c27-13e9-3220-8faa-6e7f31f48708', 2, NULL, 'A단조', 'No. 2 in A minor', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 465 AND p.composer_id = 28
AND NOT EXISTS (
    SELECT 1 FROM (SELECT piece_id, part_key FROM piece_parts) existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:e8b29c27-13e9-3220-8faa-6e7f31f48708'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:c157a366-5f4c-359d-b59e-61a998e16f19', 3, NULL, 'G장조', 'No. 3 in G major', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 465 AND p.composer_id = 28
AND NOT EXISTS (
    SELECT 1 FROM (SELECT piece_id, part_key FROM piece_parts) existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:c157a366-5f4c-359d-b59e-61a998e16f19'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:f7aea3af-bf76-3bdf-8c59-9cc62e2b8d19', 4, NULL, 'E단조', 'No. 4 in E minor', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 465 AND p.composer_id = 28
AND NOT EXISTS (
    SELECT 1 FROM (SELECT piece_id, part_key FROM piece_parts) existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:f7aea3af-bf76-3bdf-8c59-9cc62e2b8d19'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:fc99e449-1984-3351-b63d-e156d77e1db7', 5, NULL, 'D장조', 'No. 5 in D major', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 465 AND p.composer_id = 28
AND NOT EXISTS (
    SELECT 1 FROM (SELECT piece_id, part_key FROM piece_parts) existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:fc99e449-1984-3351-b63d-e156d77e1db7'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:9e434fce-f530-3b08-89a4-dc9e850c5613', 6, NULL, 'B단조', 'No. 6 in B minor', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 465 AND p.composer_id = 28
AND NOT EXISTS (
    SELECT 1 FROM (SELECT piece_id, part_key FROM piece_parts) existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:9e434fce-f530-3b08-89a4-dc9e850c5613'
);

UPDATE piece_parts part
SET part.name_ko = 'A장조', part.name_en = 'No. 7 in A major', part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE part.id = 2 AND part.piece_id = 465
  AND part.part_key = 'musicbrainz:6ee8d38d-70fb-3442-af41-5669434c494f' AND part.sequence_number = 7 AND part.editor_locked = 0;

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:31969668-4d97-311c-bb45-b8d1f128209a', 8, NULL, 'F#단조', 'No. 8 in F# minor', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 465 AND p.composer_id = 28
AND NOT EXISTS (
    SELECT 1 FROM (SELECT piece_id, part_key FROM piece_parts) existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:31969668-4d97-311c-bb45-b8d1f128209a'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:e56e2039-c79d-30bc-9b8a-d702660b4c71', 9, NULL, 'E장조', 'No. 9 in E major', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 465 AND p.composer_id = 28
AND NOT EXISTS (
    SELECT 1 FROM (SELECT piece_id, part_key FROM piece_parts) existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:e56e2039-c79d-30bc-9b8a-d702660b4c71'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:a2762aaa-2a4a-3148-8ad3-d237e61c75e6', 10, NULL, 'C#단조', 'No. 10 in C# minor', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 465 AND p.composer_id = 28
AND NOT EXISTS (
    SELECT 1 FROM (SELECT piece_id, part_key FROM piece_parts) existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:a2762aaa-2a4a-3148-8ad3-d237e61c75e6'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:82b8b1c4-72ae-3eea-b617-d3b6578be03d', 11, NULL, 'B장조', 'No. 11 in B major', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 465 AND p.composer_id = 28
AND NOT EXISTS (
    SELECT 1 FROM (SELECT piece_id, part_key FROM piece_parts) existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:82b8b1c4-72ae-3eea-b617-d3b6578be03d'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:1cc80de0-df39-3411-b64b-3d8088ed1f2a', 12, NULL, 'G#단조', 'No. 12 in G# minor', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 465 AND p.composer_id = 28
AND NOT EXISTS (
    SELECT 1 FROM (SELECT piece_id, part_key FROM piece_parts) existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:1cc80de0-df39-3411-b64b-3d8088ed1f2a'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:6922b851-604d-32f1-9aa0-4895423e82d9', 13, NULL, 'F#장조', 'No. 13 in F# major', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 465 AND p.composer_id = 28
AND NOT EXISTS (
    SELECT 1 FROM (SELECT piece_id, part_key FROM piece_parts) existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:6922b851-604d-32f1-9aa0-4895423e82d9'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:69ec5ff6-21e6-39a0-9917-be19b9eb2e42', 14, NULL, 'E♭단조', 'No. 14 in E♭ minor', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 465 AND p.composer_id = 28
AND NOT EXISTS (
    SELECT 1 FROM (SELECT piece_id, part_key FROM piece_parts) existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:69ec5ff6-21e6-39a0-9917-be19b9eb2e42'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM (SELECT id, composer_id FROM pieces) linked WHERE linked.id = 446 AND linked.composer_id = 28), 'musicbrainz:aa57f86d-8701-34f6-9cb6-c892e8028c7c', 15, NULL, 'D♭장조 "빗방울"', 'No. 15 in D♭ major "Raindrop"', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 465 AND p.composer_id = 28
AND NOT EXISTS (
    SELECT 1 FROM (SELECT piece_id, part_key FROM piece_parts) existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:aa57f86d-8701-34f6-9cb6-c892e8028c7c'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:9961854d-24c8-342d-b6a1-8200a0ca8946', 16, NULL, 'B♭단조', 'No. 16 in B♭ minor', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 465 AND p.composer_id = 28
AND NOT EXISTS (
    SELECT 1 FROM (SELECT piece_id, part_key FROM piece_parts) existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:9961854d-24c8-342d-b6a1-8200a0ca8946'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:f6575710-965f-3582-bbf9-28edeb7ef0cc', 17, NULL, 'A♭장조', 'No. 17 in A♭ major', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 465 AND p.composer_id = 28
AND NOT EXISTS (
    SELECT 1 FROM (SELECT piece_id, part_key FROM piece_parts) existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:f6575710-965f-3582-bbf9-28edeb7ef0cc'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:d714c12a-4113-32c2-a827-f1d030f153a2', 18, NULL, 'F단조', 'No. 18 in F minor', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 465 AND p.composer_id = 28
AND NOT EXISTS (
    SELECT 1 FROM (SELECT piece_id, part_key FROM piece_parts) existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:d714c12a-4113-32c2-a827-f1d030f153a2'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:8d2d058d-7fae-3bbd-973b-197f051ecfde', 19, NULL, 'E♭장조', 'No. 19 in E♭ major', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 465 AND p.composer_id = 28
AND NOT EXISTS (
    SELECT 1 FROM (SELECT piece_id, part_key FROM piece_parts) existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:8d2d058d-7fae-3bbd-973b-197f051ecfde'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:7676afd2-8d47-38f4-bdc3-6e272367e73d', 20, NULL, 'C단조', 'No. 20 in C minor', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 465 AND p.composer_id = 28
AND NOT EXISTS (
    SELECT 1 FROM (SELECT piece_id, part_key FROM piece_parts) existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:7676afd2-8d47-38f4-bdc3-6e272367e73d'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:e3de446e-12ce-3580-82e2-badd5dadc05f', 21, NULL, 'B♭장조', 'No. 21 in B♭ major', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 465 AND p.composer_id = 28
AND NOT EXISTS (
    SELECT 1 FROM (SELECT piece_id, part_key FROM piece_parts) existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:e3de446e-12ce-3580-82e2-badd5dadc05f'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:ad7cb2a5-36b9-34e7-9743-21eaeef1a5b8', 22, NULL, 'G단조', 'No. 22 in G minor', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 465 AND p.composer_id = 28
AND NOT EXISTS (
    SELECT 1 FROM (SELECT piece_id, part_key FROM piece_parts) existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:ad7cb2a5-36b9-34e7-9743-21eaeef1a5b8'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:7c35607e-c7a6-309d-a961-f3d0f2815bfc', 23, NULL, 'F장조', 'No. 23 in F major', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 465 AND p.composer_id = 28
AND NOT EXISTS (
    SELECT 1 FROM (SELECT piece_id, part_key FROM piece_parts) existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:7c35607e-c7a6-309d-a961-f3d0f2815bfc'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:90a9bf2f-16f5-3e27-85e8-614629e29bc3', 24, NULL, 'D단조', 'No. 24 in D minor', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 465 AND p.composer_id = 28
AND NOT EXISTS (
    SELECT 1 FROM (SELECT piece_id, part_key FROM piece_parts) existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:90a9bf2f-16f5-3e27-85e8-614629e29bc3'
);


-- Op. 29 즉흥곡 1번 A♭장조

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '즉흥곡 1번 A♭장조', 'Impromptu No. 1 in A♭ major', 'song', 'Op. 29', NULL, NULL, 1837, 'manual', 1
FROM composers c
WHERE c.id = 28
AND NOT EXISTS (
    SELECT 1 FROM (SELECT composer_id, title FROM pieces) existing
    WHERE existing.composer_id = c.id AND existing.title = '즉흥곡 1번 A♭장조'
)
AND NOT EXISTS (
    SELECT 1 FROM (SELECT namespace, external_id FROM piece_identifiers) taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '108abf05-3efb-313c-8fa8-3c3e5d8493e7'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '108abf05-3efb-313c-8fa8-3c3e5d8493e7'
FROM pieces p
WHERE p.composer_id = 28 AND p.title = '즉흥곡 1번 A♭장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM (SELECT namespace, external_id FROM piece_identifiers) taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '108abf05-3efb-313c-8fa8-3c3e5d8493e7'
);


-- Op. 30 마주르카 Op. 30

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '마주르카 Op. 30', '4 Mazurkas, Op. 30', 'album', NULL, 'Op.', '30', 1837, 'manual', 1
FROM composers c
WHERE c.id = 28
AND NOT EXISTS (
    SELECT 1 FROM (SELECT composer_id, title FROM pieces) existing
    WHERE existing.composer_id = c.id AND existing.title = '마주르카 Op. 30'
)
AND NOT EXISTS (
    SELECT 1 FROM (SELECT namespace, external_id FROM piece_identifiers) taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '4a277712-246b-4ab1-b7d3-79a0e2bd469b'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '4a277712-246b-4ab1-b7d3-79a0e2bd469b'
FROM pieces p
WHERE p.composer_id = 28 AND p.title = '마주르카 Op. 30' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM (SELECT namespace, external_id FROM piece_identifiers) taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '4a277712-246b-4ab1-b7d3-79a0e2bd469b'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:0c567e9d-fa96-36d8-abb9-9af6f84ee17d', 1, NULL, 'C단조', 'No. 1 in C minor', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 28 AND p.title = '마주르카 Op. 30' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM (SELECT piece_id, part_key FROM piece_parts) existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:0c567e9d-fa96-36d8-abb9-9af6f84ee17d'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:13e317ea-5e50-3d58-8d95-5301862e5e87', 2, NULL, 'B단조', 'No. 2 in B minor', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 28 AND p.title = '마주르카 Op. 30' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM (SELECT piece_id, part_key FROM piece_parts) existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:13e317ea-5e50-3d58-8d95-5301862e5e87'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:6b914d98-6ac7-3247-b640-8d318d8f4c8c', 3, NULL, 'D♭장조', 'No. 3 in D♭ major', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 28 AND p.title = '마주르카 Op. 30' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM (SELECT piece_id, part_key FROM piece_parts) existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:6b914d98-6ac7-3247-b640-8d318d8f4c8c'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:f82c2d5d-e8d5-3457-b57c-3657f73c74f1', 4, NULL, 'C#단조', 'No. 4 in C# minor', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 28 AND p.title = '마주르카 Op. 30' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM (SELECT piece_id, part_key FROM piece_parts) existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:f82c2d5d-e8d5-3457-b57c-3657f73c74f1'
);


-- Op. 31 스케르초 2번 B♭단조

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '스케르초 2번 B♭단조', 'Scherzo No. 2 in B♭ minor', 'song', 'Op. 31', NULL, NULL, 1837, 'manual', 1
FROM composers c
WHERE c.id = 28
AND NOT EXISTS (
    SELECT 1 FROM (SELECT composer_id, title FROM pieces) existing
    WHERE existing.composer_id = c.id AND existing.title = '스케르초 2번 B♭단조'
)
AND NOT EXISTS (
    SELECT 1 FROM (SELECT namespace, external_id FROM piece_identifiers) taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'a8b0ecb3-1d72-3901-b256-4514fcc08ade'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'a8b0ecb3-1d72-3901-b256-4514fcc08ade'
FROM pieces p
WHERE p.composer_id = 28 AND p.title = '스케르초 2번 B♭단조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM (SELECT namespace, external_id FROM piece_identifiers) taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'a8b0ecb3-1d72-3901-b256-4514fcc08ade'
);


-- Op. 32 녹턴 Op. 32

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '녹턴 Op. 32', '2 Nocturnes, Op. 32', 'album', NULL, 'Op.', '32', 1837, 'manual', 1
FROM composers c
WHERE c.id = 28
AND NOT EXISTS (
    SELECT 1 FROM (SELECT composer_id, title FROM pieces) existing
    WHERE existing.composer_id = c.id AND existing.title = '녹턴 Op. 32'
)
AND NOT EXISTS (
    SELECT 1 FROM (SELECT namespace, external_id FROM piece_identifiers) taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '2235fddc-d197-4f33-9faf-d696a4e00546'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '2235fddc-d197-4f33-9faf-d696a4e00546'
FROM pieces p
WHERE p.composer_id = 28 AND p.title = '녹턴 Op. 32' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM (SELECT namespace, external_id FROM piece_identifiers) taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '2235fddc-d197-4f33-9faf-d696a4e00546'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:31883fc0-f2d4-3092-91d7-0f1236b07150', 1, NULL, 'B장조', 'No. 1 in B major', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 28 AND p.title = '녹턴 Op. 32' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM (SELECT piece_id, part_key FROM piece_parts) existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:31883fc0-f2d4-3092-91d7-0f1236b07150'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:2f3f1d1e-2297-493f-8949-094608eced6a', 2, NULL, 'A♭장조', 'No. 2 in A♭ major', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 28 AND p.title = '녹턴 Op. 32' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM (SELECT piece_id, part_key FROM piece_parts) existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:2f3f1d1e-2297-493f-8949-094608eced6a'
);


-- Op. 33 마주르카 Op. 33

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '마주르카 Op. 33', '4 Mazurkas, Op. 33', 'album', NULL, 'Op.', '33', 1838, 'manual', 1
FROM composers c
WHERE c.id = 28
AND NOT EXISTS (
    SELECT 1 FROM (SELECT composer_id, title FROM pieces) existing
    WHERE existing.composer_id = c.id AND existing.title = '마주르카 Op. 33'
)
AND NOT EXISTS (
    SELECT 1 FROM (SELECT namespace, external_id FROM piece_identifiers) taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '78ca3d04-e22e-4db6-95c2-bd162a70d8c1'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '78ca3d04-e22e-4db6-95c2-bd162a70d8c1'
FROM pieces p
WHERE p.composer_id = 28 AND p.title = '마주르카 Op. 33' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM (SELECT namespace, external_id FROM piece_identifiers) taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '78ca3d04-e22e-4db6-95c2-bd162a70d8c1'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:5065427b-0964-3b0d-af2d-e963bf277690', 1, NULL, 'G#단조', 'No. 1 in G# minor', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 28 AND p.title = '마주르카 Op. 33' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM (SELECT piece_id, part_key FROM piece_parts) existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:5065427b-0964-3b0d-af2d-e963bf277690'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:7948353a-b668-3389-845f-4c295bb65ccd', 2, NULL, 'D장조', 'No. 2 in D major', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 28 AND p.title = '마주르카 Op. 33' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM (SELECT piece_id, part_key FROM piece_parts) existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:7948353a-b668-3389-845f-4c295bb65ccd'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:8e25f123-6493-39c2-9af1-fc25f469f687', 3, NULL, 'C장조', 'No. 3 in C major', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 28 AND p.title = '마주르카 Op. 33' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM (SELECT piece_id, part_key FROM piece_parts) existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:8e25f123-6493-39c2-9af1-fc25f469f687'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:996ce68b-d60f-3848-bea6-afaa1585fb66', 4, NULL, 'B단조', 'No. 4 in B minor', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 28 AND p.title = '마주르카 Op. 33' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM (SELECT piece_id, part_key FROM piece_parts) existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:996ce68b-d60f-3848-bea6-afaa1585fb66'
);


-- Op. 34 왈츠 Op. 34

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '왈츠 Op. 34', '3 Waltzes, Op. 34 (Trois grandes valses brillantes)', 'album', NULL, 'Op.', '34', 1838, 'manual', 1
FROM composers c
WHERE c.id = 28
AND NOT EXISTS (
    SELECT 1 FROM (SELECT composer_id, title FROM pieces) existing
    WHERE existing.composer_id = c.id AND existing.title = '왈츠 Op. 34'
)
AND NOT EXISTS (
    SELECT 1 FROM (SELECT namespace, external_id FROM piece_identifiers) taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '91029a84-8965-4b2d-8f1d-c9ff23e15ced'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '91029a84-8965-4b2d-8f1d-c9ff23e15ced'
FROM pieces p
WHERE p.composer_id = 28 AND p.title = '왈츠 Op. 34' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM (SELECT namespace, external_id FROM piece_identifiers) taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '91029a84-8965-4b2d-8f1d-c9ff23e15ced'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:17f54152-63a6-3b20-b191-6a9045274e1d', 1, NULL, 'A♭장조', 'No. 1 in A♭ major', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 28 AND p.title = '왈츠 Op. 34' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM (SELECT piece_id, part_key FROM piece_parts) existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:17f54152-63a6-3b20-b191-6a9045274e1d'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:721b62bc-3590-34da-a3b3-358c2607c987', 2, NULL, 'A단조', 'No. 2 in A minor', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 28 AND p.title = '왈츠 Op. 34' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM (SELECT piece_id, part_key FROM piece_parts) existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:721b62bc-3590-34da-a3b3-358c2607c987'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:19e1a09e-32ab-3f65-8184-8d0d17b202a0', 3, NULL, 'F장조 "고양이 왈츠"', 'No. 3 in F major "Cat Waltz"', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 28 AND p.title = '왈츠 Op. 34' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM (SELECT piece_id, part_key FROM piece_parts) existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:19e1a09e-32ab-3f65-8184-8d0d17b202a0'
);


-- Op. 35 피아노 소나타 2번 B♭단조 "장송"

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:049ff4b5-07f3-3bad-8cf4-be186092c96e', 1, 'I', 'Grave – Doppio movimento', 'I. Grave – Doppio movimento', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 26049 AND p.composer_id = 28
AND NOT EXISTS (
    SELECT 1 FROM (SELECT piece_id, part_key FROM piece_parts) existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:049ff4b5-07f3-3bad-8cf4-be186092c96e'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:70d36c18-186f-35ed-943c-798e85432db6', 2, 'II', '스케르초', 'II. Scherzo', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 26049 AND p.composer_id = 28
AND NOT EXISTS (
    SELECT 1 FROM (SELECT piece_id, part_key FROM piece_parts) existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:70d36c18-186f-35ed-943c-798e85432db6'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:4c44b1e9-6155-36fa-828a-5b99ae82c0f8', 3, 'III', '장송 행진곡. Lento', 'III. Marche funèbre. Lento', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 26049 AND p.composer_id = 28
AND NOT EXISTS (
    SELECT 1 FROM (SELECT piece_id, part_key FROM piece_parts) existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:4c44b1e9-6155-36fa-828a-5b99ae82c0f8'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:2a5ae4c7-34bb-3d2b-8c51-8644bcfe05f6', 4, 'IV', '피날레. Presto', 'IV. Finale. Presto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 26049 AND p.composer_id = 28
AND NOT EXISTS (
    SELECT 1 FROM (SELECT piece_id, part_key FROM piece_parts) existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:2a5ae4c7-34bb-3d2b-8c51-8644bcfe05f6'
);


-- Op. 36 즉흥곡 2번 F#장조

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '즉흥곡 2번 F#장조', 'Impromptu No. 2 in F# major', 'song', 'Op. 36', NULL, NULL, 1839, 'manual', 1
FROM composers c
WHERE c.id = 28
AND NOT EXISTS (
    SELECT 1 FROM (SELECT composer_id, title FROM pieces) existing
    WHERE existing.composer_id = c.id AND existing.title = '즉흥곡 2번 F#장조'
)
AND NOT EXISTS (
    SELECT 1 FROM (SELECT namespace, external_id FROM piece_identifiers) taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '82f36f6a-d851-3ab0-b482-cafdd1990198'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '82f36f6a-d851-3ab0-b482-cafdd1990198'
FROM pieces p
WHERE p.composer_id = 28 AND p.title = '즉흥곡 2번 F#장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM (SELECT namespace, external_id FROM piece_identifiers) taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '82f36f6a-d851-3ab0-b482-cafdd1990198'
);


-- Op. 37 녹턴 Op. 37

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '녹턴 Op. 37', '2 Nocturnes, Op. 37', 'album', NULL, 'Op.', '37', 1839, 'manual', 1
FROM composers c
WHERE c.id = 28
AND NOT EXISTS (
    SELECT 1 FROM (SELECT composer_id, title FROM pieces) existing
    WHERE existing.composer_id = c.id AND existing.title = '녹턴 Op. 37'
)
AND NOT EXISTS (
    SELECT 1 FROM (SELECT namespace, external_id FROM piece_identifiers) taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'e8e197ec-b801-4462-b202-cbf189c257fb'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'e8e197ec-b801-4462-b202-cbf189c257fb'
FROM pieces p
WHERE p.composer_id = 28 AND p.title = '녹턴 Op. 37' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM (SELECT namespace, external_id FROM piece_identifiers) taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'e8e197ec-b801-4462-b202-cbf189c257fb'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:b6489dc2-3ce2-3629-a973-a8db91793a74', 1, NULL, 'G단조', 'No. 1 in G minor', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 28 AND p.title = '녹턴 Op. 37' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM (SELECT piece_id, part_key FROM piece_parts) existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:b6489dc2-3ce2-3629-a973-a8db91793a74'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:374173fe-cb21-3620-b7a4-940bce1669cd', 2, NULL, 'G장조', 'No. 2 in G major', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 28 AND p.title = '녹턴 Op. 37' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM (SELECT piece_id, part_key FROM piece_parts) existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:374173fe-cb21-3620-b7a4-940bce1669cd'
);


-- Op. 38 발라드 2번 F장조

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '발라드 2번 F장조', 'Ballade No. 2 in F major', 'song', 'Op. 38', NULL, NULL, 1839, 'manual', 1
FROM composers c
WHERE c.id = 28
AND NOT EXISTS (
    SELECT 1 FROM (SELECT composer_id, title FROM pieces) existing
    WHERE existing.composer_id = c.id AND existing.title = '발라드 2번 F장조'
)
AND NOT EXISTS (
    SELECT 1 FROM (SELECT namespace, external_id FROM piece_identifiers) taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '30775d65-4977-3836-ad29-c5f2acab2c39'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '30775d65-4977-3836-ad29-c5f2acab2c39'
FROM pieces p
WHERE p.composer_id = 28 AND p.title = '발라드 2번 F장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM (SELECT namespace, external_id FROM piece_identifiers) taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '30775d65-4977-3836-ad29-c5f2acab2c39'
);


-- Op. 39 스케르초 3번 C#단조

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '스케르초 3번 C#단조', 'Scherzo No. 3 in C# minor', 'song', 'Op. 39', NULL, NULL, 1839, 'manual', 1
FROM composers c
WHERE c.id = 28
AND NOT EXISTS (
    SELECT 1 FROM (SELECT composer_id, title FROM pieces) existing
    WHERE existing.composer_id = c.id AND existing.title = '스케르초 3번 C#단조'
)
AND NOT EXISTS (
    SELECT 1 FROM (SELECT namespace, external_id FROM piece_identifiers) taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '6a9152e1-c75f-310c-afa5-2e2d1b8d99c9'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '6a9152e1-c75f-310c-afa5-2e2d1b8d99c9'
FROM pieces p
WHERE p.composer_id = 28 AND p.title = '스케르초 3번 C#단조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM (SELECT namespace, external_id FROM piece_identifiers) taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '6a9152e1-c75f-310c-afa5-2e2d1b8d99c9'
);


-- Op. 40 폴로네즈 Op. 40

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '폴로네즈 Op. 40', '2 Polonaises, Op. 40', 'album', NULL, 'Op.', '40', 1839, 'manual', 1
FROM composers c
WHERE c.id = 28
AND NOT EXISTS (
    SELECT 1 FROM (SELECT composer_id, title FROM pieces) existing
    WHERE existing.composer_id = c.id AND existing.title = '폴로네즈 Op. 40'
)
AND NOT EXISTS (
    SELECT 1 FROM (SELECT namespace, external_id FROM piece_identifiers) taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '4d2d5cc9-459d-44bb-b54f-6e8a96185768'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '4d2d5cc9-459d-44bb-b54f-6e8a96185768'
FROM pieces p
WHERE p.composer_id = 28 AND p.title = '폴로네즈 Op. 40' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM (SELECT namespace, external_id FROM piece_identifiers) taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '4d2d5cc9-459d-44bb-b54f-6e8a96185768'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:b81545eb-d8b3-360b-a5ca-3bb4ec2a7fd6', 1, NULL, 'A장조 "군대"', 'No. 1 in A major "Military"', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 28 AND p.title = '폴로네즈 Op. 40' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM (SELECT piece_id, part_key FROM piece_parts) existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:b81545eb-d8b3-360b-a5ca-3bb4ec2a7fd6'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:dbc4014e-8dd7-3a6e-ad87-0c88b5b847b0', 2, NULL, 'C단조', 'No. 2 in C minor', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 28 AND p.title = '폴로네즈 Op. 40' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM (SELECT piece_id, part_key FROM piece_parts) existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:dbc4014e-8dd7-3a6e-ad87-0c88b5b847b0'
);


-- Op. 41 마주르카 Op. 41

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '마주르카 Op. 41', '4 Mazurkas, Op. 41', 'album', NULL, 'Op.', '41', 1839, 'manual', 1
FROM composers c
WHERE c.id = 28
AND NOT EXISTS (
    SELECT 1 FROM (SELECT composer_id, title FROM pieces) existing
    WHERE existing.composer_id = c.id AND existing.title = '마주르카 Op. 41'
)
AND NOT EXISTS (
    SELECT 1 FROM (SELECT namespace, external_id FROM piece_identifiers) taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '54038089-d1c9-4290-b991-9fe77b9ff83f'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '54038089-d1c9-4290-b991-9fe77b9ff83f'
FROM pieces p
WHERE p.composer_id = 28 AND p.title = '마주르카 Op. 41' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM (SELECT namespace, external_id FROM piece_identifiers) taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '54038089-d1c9-4290-b991-9fe77b9ff83f'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:4723c4a0-596e-3aea-83d4-4891c7863446', 1, NULL, 'C#단조', 'No. 1 in C# minor', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 28 AND p.title = '마주르카 Op. 41' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM (SELECT piece_id, part_key FROM piece_parts) existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:4723c4a0-596e-3aea-83d4-4891c7863446'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:87ad97cd-a9d7-381e-9b2f-68b51f7f284e', 2, NULL, 'E단조', 'No. 2 in E minor', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 28 AND p.title = '마주르카 Op. 41' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM (SELECT piece_id, part_key FROM piece_parts) existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:87ad97cd-a9d7-381e-9b2f-68b51f7f284e'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:da4b3bc9-4b00-3811-af51-decedb9cbf15', 3, NULL, 'B장조', 'No. 3 in B major', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 28 AND p.title = '마주르카 Op. 41' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM (SELECT piece_id, part_key FROM piece_parts) existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:da4b3bc9-4b00-3811-af51-decedb9cbf15'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:22866141-7adc-3b23-a4de-d2dc147de089', 4, NULL, 'A♭장조', 'No. 4 in A♭ major', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 28 AND p.title = '마주르카 Op. 41' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM (SELECT piece_id, part_key FROM piece_parts) existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:22866141-7adc-3b23-a4de-d2dc147de089'
);


-- Op. 42 왈츠 5번 A♭장조

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '왈츠 5번 A♭장조', 'Waltz No. 5 in A♭ major', 'song', 'Op. 42', NULL, NULL, 1840, 'manual', 1
FROM composers c
WHERE c.id = 28
AND NOT EXISTS (
    SELECT 1 FROM (SELECT composer_id, title FROM pieces) existing
    WHERE existing.composer_id = c.id AND existing.title = '왈츠 5번 A♭장조'
)
AND NOT EXISTS (
    SELECT 1 FROM (SELECT namespace, external_id FROM piece_identifiers) taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '234b0fa6-12f8-3c9c-98c4-f6bd8176a30b'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '234b0fa6-12f8-3c9c-98c4-f6bd8176a30b'
FROM pieces p
WHERE p.composer_id = 28 AND p.title = '왈츠 5번 A♭장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM (SELECT namespace, external_id FROM piece_identifiers) taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '234b0fa6-12f8-3c9c-98c4-f6bd8176a30b'
);


-- Op. 43 타란텔라 A♭장조

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '타란텔라 A♭장조', 'Tarantelle in A♭ major', 'song', 'Op. 43', NULL, NULL, 1841, 'manual', 1
FROM composers c
WHERE c.id = 28
AND NOT EXISTS (
    SELECT 1 FROM (SELECT composer_id, title FROM pieces) existing
    WHERE existing.composer_id = c.id AND existing.title = '타란텔라 A♭장조'
)
AND NOT EXISTS (
    SELECT 1 FROM (SELECT namespace, external_id FROM piece_identifiers) taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '806d7cad-4c1e-3605-b3e6-82068c5bb033'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '806d7cad-4c1e-3605-b3e6-82068c5bb033'
FROM pieces p
WHERE p.composer_id = 28 AND p.title = '타란텔라 A♭장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM (SELECT namespace, external_id FROM piece_identifiers) taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '806d7cad-4c1e-3605-b3e6-82068c5bb033'
);


-- Op. 44 폴로네즈 5번 F#단조

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '폴로네즈 5번 F#단조', 'Polonaise No. 5 in F# minor', 'song', 'Op. 44', NULL, NULL, 1841, 'manual', 1
FROM composers c
WHERE c.id = 28
AND NOT EXISTS (
    SELECT 1 FROM (SELECT composer_id, title FROM pieces) existing
    WHERE existing.composer_id = c.id AND existing.title = '폴로네즈 5번 F#단조'
)
AND NOT EXISTS (
    SELECT 1 FROM (SELECT namespace, external_id FROM piece_identifiers) taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'a9047c0f-7dde-38a4-91b4-bb3f24b438f1'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'a9047c0f-7dde-38a4-91b4-bb3f24b438f1'
FROM pieces p
WHERE p.composer_id = 28 AND p.title = '폴로네즈 5번 F#단조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM (SELECT namespace, external_id FROM piece_identifiers) taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'a9047c0f-7dde-38a4-91b4-bb3f24b438f1'
);


-- Op. 45 전주곡 C#단조

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '전주곡 C#단조', 'Prélude in C# minor', 'song', 'Op. 45', NULL, NULL, 1841, 'manual', 1
FROM composers c
WHERE c.id = 28
AND NOT EXISTS (
    SELECT 1 FROM (SELECT composer_id, title FROM pieces) existing
    WHERE existing.composer_id = c.id AND existing.title = '전주곡 C#단조'
)
AND NOT EXISTS (
    SELECT 1 FROM (SELECT namespace, external_id FROM piece_identifiers) taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '287854cf-d199-36de-bbde-d6dbf8b70651'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '287854cf-d199-36de-bbde-d6dbf8b70651'
FROM pieces p
WHERE p.composer_id = 28 AND p.title = '전주곡 C#단조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM (SELECT namespace, external_id FROM piece_identifiers) taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '287854cf-d199-36de-bbde-d6dbf8b70651'
);


-- Op. 46 연주회용 알레그로 A장조

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '연주회용 알레그로 A장조', 'Allegro de concert in A major', 'song', 'Op. 46', NULL, NULL, 1841, 'manual', 1
FROM composers c
WHERE c.id = 28
AND NOT EXISTS (
    SELECT 1 FROM (SELECT composer_id, title FROM pieces) existing
    WHERE existing.composer_id = c.id AND existing.title = '연주회용 알레그로 A장조'
)
AND NOT EXISTS (
    SELECT 1 FROM (SELECT namespace, external_id FROM piece_identifiers) taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'edb74458-f902-4c9a-82f0-a808aa5cf0f1'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'edb74458-f902-4c9a-82f0-a808aa5cf0f1'
FROM pieces p
WHERE p.composer_id = 28 AND p.title = '연주회용 알레그로 A장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM (SELECT namespace, external_id FROM piece_identifiers) taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'edb74458-f902-4c9a-82f0-a808aa5cf0f1'
);


-- Op. 47 발라드 3번 A♭장조

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '발라드 3번 A♭장조', 'Ballade No. 3 in A♭ major', 'song', 'Op. 47', NULL, NULL, 1841, 'manual', 1
FROM composers c
WHERE c.id = 28
AND NOT EXISTS (
    SELECT 1 FROM (SELECT composer_id, title FROM pieces) existing
    WHERE existing.composer_id = c.id AND existing.title = '발라드 3번 A♭장조'
)
AND NOT EXISTS (
    SELECT 1 FROM (SELECT namespace, external_id FROM piece_identifiers) taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '8133796b-6eb1-3e5b-a797-5906630b57a1'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '8133796b-6eb1-3e5b-a797-5906630b57a1'
FROM pieces p
WHERE p.composer_id = 28 AND p.title = '발라드 3번 A♭장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM (SELECT namespace, external_id FROM piece_identifiers) taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '8133796b-6eb1-3e5b-a797-5906630b57a1'
);


-- Op. 48 녹턴 Op. 48

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '녹턴 Op. 48', '2 Nocturnes, Op. 48', 'album', NULL, 'Op.', '48', 1841, 'manual', 1
FROM composers c
WHERE c.id = 28
AND NOT EXISTS (
    SELECT 1 FROM (SELECT composer_id, title FROM pieces) existing
    WHERE existing.composer_id = c.id AND existing.title = '녹턴 Op. 48'
)
AND NOT EXISTS (
    SELECT 1 FROM (SELECT namespace, external_id FROM piece_identifiers) taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'e416ac9b-cf63-4489-9609-52e7f1464516'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'e416ac9b-cf63-4489-9609-52e7f1464516'
FROM pieces p
WHERE p.composer_id = 28 AND p.title = '녹턴 Op. 48' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM (SELECT namespace, external_id FROM piece_identifiers) taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'e416ac9b-cf63-4489-9609-52e7f1464516'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:a9aef1f6-db96-366d-b6ee-59c9ddeabeaf', 1, NULL, 'C단조', 'No. 1 in C minor', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 28 AND p.title = '녹턴 Op. 48' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM (SELECT piece_id, part_key FROM piece_parts) existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:a9aef1f6-db96-366d-b6ee-59c9ddeabeaf'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:529a8bdb-cf0a-3d84-8018-9ad763435788', 2, NULL, 'F#단조', 'No. 2 in F# minor', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 28 AND p.title = '녹턴 Op. 48' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM (SELECT piece_id, part_key FROM piece_parts) existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:529a8bdb-cf0a-3d84-8018-9ad763435788'
);


-- Op. 49 환상곡 F단조

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '환상곡 F단조', 'Fantaisie in F minor', 'song', 'Op. 49', NULL, NULL, 1841, 'manual', 1
FROM composers c
WHERE c.id = 28
AND NOT EXISTS (
    SELECT 1 FROM (SELECT composer_id, title FROM pieces) existing
    WHERE existing.composer_id = c.id AND existing.title = '환상곡 F단조'
)
AND NOT EXISTS (
    SELECT 1 FROM (SELECT namespace, external_id FROM piece_identifiers) taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'e6a65b61-366e-341b-94b0-d238f2a07b9d'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'e6a65b61-366e-341b-94b0-d238f2a07b9d'
FROM pieces p
WHERE p.composer_id = 28 AND p.title = '환상곡 F단조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM (SELECT namespace, external_id FROM piece_identifiers) taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'e6a65b61-366e-341b-94b0-d238f2a07b9d'
);


-- Op. 50 마주르카 Op. 50

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '마주르카 Op. 50', '3 Mazurkas, Op. 50', 'album', NULL, 'Op.', '50', 1842, 'manual', 1
FROM composers c
WHERE c.id = 28
AND NOT EXISTS (
    SELECT 1 FROM (SELECT composer_id, title FROM pieces) existing
    WHERE existing.composer_id = c.id AND existing.title = '마주르카 Op. 50'
)
AND NOT EXISTS (
    SELECT 1 FROM (SELECT namespace, external_id FROM piece_identifiers) taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '90af0be5-b689-4829-ac76-068511488b66'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '90af0be5-b689-4829-ac76-068511488b66'
FROM pieces p
WHERE p.composer_id = 28 AND p.title = '마주르카 Op. 50' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM (SELECT namespace, external_id FROM piece_identifiers) taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '90af0be5-b689-4829-ac76-068511488b66'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:1cb8a7b9-7878-392a-98f7-3ee87d9ef422', 1, NULL, 'G장조', 'No. 1 in G major', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 28 AND p.title = '마주르카 Op. 50' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM (SELECT piece_id, part_key FROM piece_parts) existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:1cb8a7b9-7878-392a-98f7-3ee87d9ef422'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:a29426c9-ab93-39a9-b4c1-10d35f0bfb12', 2, NULL, 'A♭장조', 'No. 2 in A♭ major', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 28 AND p.title = '마주르카 Op. 50' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM (SELECT piece_id, part_key FROM piece_parts) existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:a29426c9-ab93-39a9-b4c1-10d35f0bfb12'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:09083101-aa8d-3e9e-a71c-ffc623c7bc97', 3, NULL, 'C#단조', 'No. 3 in C# minor', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 28 AND p.title = '마주르카 Op. 50' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM (SELECT piece_id, part_key FROM piece_parts) existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:09083101-aa8d-3e9e-a71c-ffc623c7bc97'
);


-- Op. 51 즉흥곡 3번 G♭장조

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '즉흥곡 3번 G♭장조', 'Impromptu No. 3 in G♭ major', 'song', 'Op. 51', NULL, NULL, 1842, 'manual', 1
FROM composers c
WHERE c.id = 28
AND NOT EXISTS (
    SELECT 1 FROM (SELECT composer_id, title FROM pieces) existing
    WHERE existing.composer_id = c.id AND existing.title = '즉흥곡 3번 G♭장조'
)
AND NOT EXISTS (
    SELECT 1 FROM (SELECT namespace, external_id FROM piece_identifiers) taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'e64a4256-32f3-383c-8cc5-a1d669ac3c76'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'e64a4256-32f3-383c-8cc5-a1d669ac3c76'
FROM pieces p
WHERE p.composer_id = 28 AND p.title = '즉흥곡 3번 G♭장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM (SELECT namespace, external_id FROM piece_identifiers) taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'e64a4256-32f3-383c-8cc5-a1d669ac3c76'
);


-- Op. 52 발라드 4번 F단조

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '발라드 4번 F단조', 'Ballade No. 4 in F minor', 'song', 'Op. 52', NULL, NULL, 1842, 'manual', 1
FROM composers c
WHERE c.id = 28
AND NOT EXISTS (
    SELECT 1 FROM (SELECT composer_id, title FROM pieces) existing
    WHERE existing.composer_id = c.id AND existing.title = '발라드 4번 F단조'
)
AND NOT EXISTS (
    SELECT 1 FROM (SELECT namespace, external_id FROM piece_identifiers) taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '43ad4521-d89a-3eb0-b474-ece7a28dd242'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '43ad4521-d89a-3eb0-b474-ece7a28dd242'
FROM pieces p
WHERE p.composer_id = 28 AND p.title = '발라드 4번 F단조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM (SELECT namespace, external_id FROM piece_identifiers) taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '43ad4521-d89a-3eb0-b474-ece7a28dd242'
);


-- Op. 54 스케르초 4번 E장조

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '스케르초 4번 E장조', 'Scherzo No. 4 in E major', 'song', 'Op. 54', NULL, NULL, 1842, 'manual', 1
FROM composers c
WHERE c.id = 28
AND NOT EXISTS (
    SELECT 1 FROM (SELECT composer_id, title FROM pieces) existing
    WHERE existing.composer_id = c.id AND existing.title = '스케르초 4번 E장조'
)
AND NOT EXISTS (
    SELECT 1 FROM (SELECT namespace, external_id FROM piece_identifiers) taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '80d420ed-ec37-3748-9733-900810e29fb5'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '80d420ed-ec37-3748-9733-900810e29fb5'
FROM pieces p
WHERE p.composer_id = 28 AND p.title = '스케르초 4번 E장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM (SELECT namespace, external_id FROM piece_identifiers) taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '80d420ed-ec37-3748-9733-900810e29fb5'
);


-- Op. 55 녹턴 Op. 55

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '녹턴 Op. 55', '2 Nocturnes, Op. 55', 'album', NULL, 'Op.', '55', 1843, 'manual', 1
FROM composers c
WHERE c.id = 28
AND NOT EXISTS (
    SELECT 1 FROM (SELECT composer_id, title FROM pieces) existing
    WHERE existing.composer_id = c.id AND existing.title = '녹턴 Op. 55'
)
AND NOT EXISTS (
    SELECT 1 FROM (SELECT namespace, external_id FROM piece_identifiers) taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'd8373f6d-a9a0-4420-b0be-3e3737425df9'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'd8373f6d-a9a0-4420-b0be-3e3737425df9'
FROM pieces p
WHERE p.composer_id = 28 AND p.title = '녹턴 Op. 55' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM (SELECT namespace, external_id FROM piece_identifiers) taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'd8373f6d-a9a0-4420-b0be-3e3737425df9'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:41c416ce-61b6-3398-ac67-d9d080d3bc07', 1, NULL, 'F단조', 'No. 1 in F minor', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 28 AND p.title = '녹턴 Op. 55' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM (SELECT piece_id, part_key FROM piece_parts) existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:41c416ce-61b6-3398-ac67-d9d080d3bc07'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:349a935c-1cc6-3a2e-8dfe-469846933bd6', 2, NULL, 'E♭장조', 'No. 2 in E♭ major', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 28 AND p.title = '녹턴 Op. 55' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM (SELECT piece_id, part_key FROM piece_parts) existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:349a935c-1cc6-3a2e-8dfe-469846933bd6'
);


-- Op. 56 마주르카 Op. 56

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '마주르카 Op. 56', '3 Mazurkas, Op. 56', 'album', NULL, 'Op.', '56', 1843, 'manual', 1
FROM composers c
WHERE c.id = 28
AND NOT EXISTS (
    SELECT 1 FROM (SELECT composer_id, title FROM pieces) existing
    WHERE existing.composer_id = c.id AND existing.title = '마주르카 Op. 56'
)
AND NOT EXISTS (
    SELECT 1 FROM (SELECT namespace, external_id FROM piece_identifiers) taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'abecce76-c6ea-4acb-95c4-0ce11fcb5116'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'abecce76-c6ea-4acb-95c4-0ce11fcb5116'
FROM pieces p
WHERE p.composer_id = 28 AND p.title = '마주르카 Op. 56' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM (SELECT namespace, external_id FROM piece_identifiers) taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'abecce76-c6ea-4acb-95c4-0ce11fcb5116'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:e7a40dbc-8618-3c64-a884-21be558eddce', 1, NULL, 'B장조', 'No. 1 in B major', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 28 AND p.title = '마주르카 Op. 56' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM (SELECT piece_id, part_key FROM piece_parts) existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:e7a40dbc-8618-3c64-a884-21be558eddce'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:d26d3073-dd16-3164-81b1-40bd228f26ab', 2, NULL, 'C장조', 'No. 2 in C major', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 28 AND p.title = '마주르카 Op. 56' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM (SELECT piece_id, part_key FROM piece_parts) existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:d26d3073-dd16-3164-81b1-40bd228f26ab'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:a66540a5-b42b-3083-b1ae-76db59fb059d', 3, NULL, 'C단조', 'No. 3 in C minor', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 28 AND p.title = '마주르카 Op. 56' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM (SELECT piece_id, part_key FROM piece_parts) existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:a66540a5-b42b-3083-b1ae-76db59fb059d'
);


-- Op. 57 자장가 D♭장조

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '자장가 D♭장조', 'Berceuse in D♭ major', 'song', 'Op. 57', NULL, NULL, 1843, 'manual', 1
FROM composers c
WHERE c.id = 28
AND NOT EXISTS (
    SELECT 1 FROM (SELECT composer_id, title FROM pieces) existing
    WHERE existing.composer_id = c.id AND existing.title = '자장가 D♭장조'
)
AND NOT EXISTS (
    SELECT 1 FROM (SELECT namespace, external_id FROM piece_identifiers) taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'd8c5d27a-04fc-3fe5-99f3-a3201c0428d8'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'd8c5d27a-04fc-3fe5-99f3-a3201c0428d8'
FROM pieces p
WHERE p.composer_id = 28 AND p.title = '자장가 D♭장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM (SELECT namespace, external_id FROM piece_identifiers) taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'd8c5d27a-04fc-3fe5-99f3-a3201c0428d8'
);


-- Op. 58 피아노 소나타 3번 B단조

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:156d62b0-be01-38ab-ada4-fd459feb9fba', 1, 'I', 'Allegro maestoso', 'I. Allegro maestoso', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 26050 AND p.composer_id = 28
AND NOT EXISTS (
    SELECT 1 FROM (SELECT piece_id, part_key FROM piece_parts) existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:156d62b0-be01-38ab-ada4-fd459feb9fba'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:030cc835-f320-3385-8fb3-2a16c86ee31c', 2, 'II', '스케르초. Molto vivace', 'II. Scherzo. Molto vivace', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 26050 AND p.composer_id = 28
AND NOT EXISTS (
    SELECT 1 FROM (SELECT piece_id, part_key FROM piece_parts) existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:030cc835-f320-3385-8fb3-2a16c86ee31c'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:2c3023bb-cb98-3550-8e93-d67f25602059', 3, 'III', 'Largo', 'III. Largo', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 26050 AND p.composer_id = 28
AND NOT EXISTS (
    SELECT 1 FROM (SELECT piece_id, part_key FROM piece_parts) existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:2c3023bb-cb98-3550-8e93-d67f25602059'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:29ca5ba8-1b59-38ba-9f1a-d6d1ec94bc57', 4, 'IV', '피날레. Presto non tanto', 'IV. Finale. Presto non tanto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 26050 AND p.composer_id = 28
AND NOT EXISTS (
    SELECT 1 FROM (SELECT piece_id, part_key FROM piece_parts) existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:29ca5ba8-1b59-38ba-9f1a-d6d1ec94bc57'
);


-- Op. 59 마주르카 Op. 59

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '마주르카 Op. 59', '3 Mazurkas, Op. 59', 'album', NULL, 'Op.', '59', 1845, 'manual', 1
FROM composers c
WHERE c.id = 28
AND NOT EXISTS (
    SELECT 1 FROM (SELECT composer_id, title FROM pieces) existing
    WHERE existing.composer_id = c.id AND existing.title = '마주르카 Op. 59'
)
AND NOT EXISTS (
    SELECT 1 FROM (SELECT namespace, external_id FROM piece_identifiers) taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '0de86236-2ade-4305-8184-ea409fd3e9fc'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '0de86236-2ade-4305-8184-ea409fd3e9fc'
FROM pieces p
WHERE p.composer_id = 28 AND p.title = '마주르카 Op. 59' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM (SELECT namespace, external_id FROM piece_identifiers) taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '0de86236-2ade-4305-8184-ea409fd3e9fc'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:e52e913e-1b78-3f9f-a39b-d0ae32df21a2', 1, NULL, 'A단조', 'No. 1 in A minor', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 28 AND p.title = '마주르카 Op. 59' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM (SELECT piece_id, part_key FROM piece_parts) existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:e52e913e-1b78-3f9f-a39b-d0ae32df21a2'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:d22b9273-c7e6-3bc6-ba89-49806836c1ca', 2, NULL, 'A♭장조', 'No. 2 in A♭ major', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 28 AND p.title = '마주르카 Op. 59' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM (SELECT piece_id, part_key FROM piece_parts) existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:d22b9273-c7e6-3bc6-ba89-49806836c1ca'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:5ddd538f-88ca-3477-930b-768f40be9fb6', 3, NULL, 'F#단조', 'No. 3 in F# minor', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 28 AND p.title = '마주르카 Op. 59' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM (SELECT piece_id, part_key FROM piece_parts) existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:5ddd538f-88ca-3477-930b-768f40be9fb6'
);


-- Op. 61 환상 폴로네즈 A♭장조

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '환상 폴로네즈 A♭장조', 'Polonaise-Fantaisie in A♭ major', 'song', 'Op. 61', NULL, NULL, 1846, 'manual', 1
FROM composers c
WHERE c.id = 28
AND NOT EXISTS (
    SELECT 1 FROM (SELECT composer_id, title FROM pieces) existing
    WHERE existing.composer_id = c.id AND existing.title = '환상 폴로네즈 A♭장조'
)
AND NOT EXISTS (
    SELECT 1 FROM (SELECT namespace, external_id FROM piece_identifiers) taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'a077a0ca-ea1f-3d14-8cf5-e93b68f21fac'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'a077a0ca-ea1f-3d14-8cf5-e93b68f21fac'
FROM pieces p
WHERE p.composer_id = 28 AND p.title = '환상 폴로네즈 A♭장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM (SELECT namespace, external_id FROM piece_identifiers) taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'a077a0ca-ea1f-3d14-8cf5-e93b68f21fac'
);


-- Op. 62 녹턴 Op. 62

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '녹턴 Op. 62', '2 Nocturnes, Op. 62', 'album', NULL, 'Op.', '62', 1846, 'manual', 1
FROM composers c
WHERE c.id = 28
AND NOT EXISTS (
    SELECT 1 FROM (SELECT composer_id, title FROM pieces) existing
    WHERE existing.composer_id = c.id AND existing.title = '녹턴 Op. 62'
)
AND NOT EXISTS (
    SELECT 1 FROM (SELECT namespace, external_id FROM piece_identifiers) taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'd69af78d-0059-4719-8c94-650df2a35caf'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'd69af78d-0059-4719-8c94-650df2a35caf'
FROM pieces p
WHERE p.composer_id = 28 AND p.title = '녹턴 Op. 62' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM (SELECT namespace, external_id FROM piece_identifiers) taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'd69af78d-0059-4719-8c94-650df2a35caf'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:ac842bd9-856b-32a9-a9a6-0ec1fa6fec0e', 1, NULL, 'B장조', 'No. 1 in B major', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 28 AND p.title = '녹턴 Op. 62' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM (SELECT piece_id, part_key FROM piece_parts) existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:ac842bd9-856b-32a9-a9a6-0ec1fa6fec0e'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:bf803b4a-a42a-3ffe-aa53-3a99a6541df5', 2, NULL, 'E장조', 'No. 2 in E major', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 28 AND p.title = '녹턴 Op. 62' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM (SELECT piece_id, part_key FROM piece_parts) existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:bf803b4a-a42a-3ffe-aa53-3a99a6541df5'
);


-- Op. 63 마주르카 Op. 63

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '마주르카 Op. 63', '3 Mazurkas, Op. 63', 'album', NULL, 'Op.', '63', 1846, 'manual', 1
FROM composers c
WHERE c.id = 28
AND NOT EXISTS (
    SELECT 1 FROM (SELECT composer_id, title FROM pieces) existing
    WHERE existing.composer_id = c.id AND existing.title = '마주르카 Op. 63'
)
AND NOT EXISTS (
    SELECT 1 FROM (SELECT namespace, external_id FROM piece_identifiers) taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'e72c4958-1687-4f14-8457-d71612214f59'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'e72c4958-1687-4f14-8457-d71612214f59'
FROM pieces p
WHERE p.composer_id = 28 AND p.title = '마주르카 Op. 63' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM (SELECT namespace, external_id FROM piece_identifiers) taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'e72c4958-1687-4f14-8457-d71612214f59'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:41e76177-c032-3e6d-994b-81b6d7b31a81', 1, NULL, 'B장조', 'No. 1 in B major', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 28 AND p.title = '마주르카 Op. 63' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM (SELECT piece_id, part_key FROM piece_parts) existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:41e76177-c032-3e6d-994b-81b6d7b31a81'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:1f0ddbc8-d09d-3fbe-8cb3-0927d0ce4f6f', 2, NULL, 'F단조', 'No. 2 in F minor', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 28 AND p.title = '마주르카 Op. 63' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM (SELECT piece_id, part_key FROM piece_parts) existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:1f0ddbc8-d09d-3fbe-8cb3-0927d0ce4f6f'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:498ca9d9-d190-3373-86c3-c6e45f2512b3', 3, NULL, 'C#단조', 'No. 3 in C# minor', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 28 AND p.title = '마주르카 Op. 63' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM (SELECT piece_id, part_key FROM piece_parts) existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:498ca9d9-d190-3373-86c3-c6e45f2512b3'
);


-- Op. 64 왈츠 Op. 64

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '왈츠 Op. 64', '3 Waltzes, Op. 64', 'album', NULL, 'Op.', '64', 1847, 'manual', 1
FROM composers c
WHERE c.id = 28
AND NOT EXISTS (
    SELECT 1 FROM (SELECT composer_id, title FROM pieces) existing
    WHERE existing.composer_id = c.id AND existing.title = '왈츠 Op. 64'
)
AND NOT EXISTS (
    SELECT 1 FROM (SELECT namespace, external_id FROM piece_identifiers) taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'c16cdb94-4cc2-443c-b3ab-d7d42037e6ea'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'c16cdb94-4cc2-443c-b3ab-d7d42037e6ea'
FROM pieces p
WHERE p.composer_id = 28 AND p.title = '왈츠 Op. 64' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM (SELECT namespace, external_id FROM piece_identifiers) taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'c16cdb94-4cc2-443c-b3ab-d7d42037e6ea'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM (SELECT id, composer_id FROM pieces) linked WHERE linked.id = 133 AND linked.composer_id = 28), 'musicbrainz:3ea59e6f-4d98-3ef2-93ed-b698fc38ada5', 1, NULL, 'D♭장조 "강아지 왈츠"', 'No. 1 in D♭ major "Minute Waltz"', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 28 AND p.title = '왈츠 Op. 64' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM (SELECT piece_id, part_key FROM piece_parts) existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:3ea59e6f-4d98-3ef2-93ed-b698fc38ada5'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:b985a660-d207-30bc-951b-35853fd8b41e', 2, NULL, 'C#단조', 'No. 2 in C# minor', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 28 AND p.title = '왈츠 Op. 64' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM (SELECT piece_id, part_key FROM piece_parts) existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:b985a660-d207-30bc-951b-35853fd8b41e'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:d686006c-8fbb-36f5-90ae-3984fe6574ea', 3, NULL, 'A♭장조', 'No. 3 in A♭ major', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 28 AND p.title = '왈츠 Op. 64' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM (SELECT piece_id, part_key FROM piece_parts) existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:d686006c-8fbb-36f5-90ae-3984fe6574ea'
);


-- Op. 65 첼로 소나타 G단조

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '첼로 소나타 G단조', 'Cello Sonata in G minor', 'album', 'Op. 65', NULL, NULL, 1847, 'manual', 1
FROM composers c
WHERE c.id = 28
AND NOT EXISTS (
    SELECT 1 FROM (SELECT composer_id, title FROM pieces) existing
    WHERE existing.composer_id = c.id AND existing.title = '첼로 소나타 G단조'
)
AND NOT EXISTS (
    SELECT 1 FROM (SELECT namespace, external_id FROM piece_identifiers) taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '14a6bd0d-2fff-46e0-b11e-ad46ec0410aa'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '14a6bd0d-2fff-46e0-b11e-ad46ec0410aa'
FROM pieces p
WHERE p.composer_id = 28 AND p.title = '첼로 소나타 G단조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM (SELECT namespace, external_id FROM piece_identifiers) taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '14a6bd0d-2fff-46e0-b11e-ad46ec0410aa'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:fddbd53b-200f-3a60-9394-98347e39716d', 1, 'I', 'Allegro moderato', 'I. Allegro moderato', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 28 AND p.title = '첼로 소나타 G단조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM (SELECT piece_id, part_key FROM piece_parts) existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:fddbd53b-200f-3a60-9394-98347e39716d'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:7c7c0ef2-4a16-364e-84e0-4eb9ea2b9d90', 2, 'II', '스케르초. Allegro con brio', 'II. Scherzo. Allegro con brio', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 28 AND p.title = '첼로 소나타 G단조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM (SELECT piece_id, part_key FROM piece_parts) existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:7c7c0ef2-4a16-364e-84e0-4eb9ea2b9d90'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:0bcf246c-9e60-37c1-8237-f66aee187276', 3, 'III', 'Largo', 'III. Largo', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 28 AND p.title = '첼로 소나타 G단조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM (SELECT piece_id, part_key FROM piece_parts) existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:0bcf246c-9e60-37c1-8237-f66aee187276'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:bcea2be2-c57b-3ee9-a082-1e4fb8edd0ee', 4, 'IV', '피날레. Allegro', 'IV. Finale. Allegro', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 28 AND p.title = '첼로 소나타 G단조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM (SELECT piece_id, part_key FROM piece_parts) existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:bcea2be2-c57b-3ee9-a082-1e4fb8edd0ee'
);


-- Op. 67 마주르카 Op. 67

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '마주르카 Op. 67', '4 Mazurkas, Op. 67', 'album', NULL, 'Op.', '67', 1849, 'manual', 1
FROM composers c
WHERE c.id = 28
AND NOT EXISTS (
    SELECT 1 FROM (SELECT composer_id, title FROM pieces) existing
    WHERE existing.composer_id = c.id AND existing.title = '마주르카 Op. 67'
)
AND NOT EXISTS (
    SELECT 1 FROM (SELECT namespace, external_id FROM piece_identifiers) taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'b4e553d9-00f1-4779-a451-ce237ffefa7e'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'b4e553d9-00f1-4779-a451-ce237ffefa7e'
FROM pieces p
WHERE p.composer_id = 28 AND p.title = '마주르카 Op. 67' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM (SELECT namespace, external_id FROM piece_identifiers) taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'b4e553d9-00f1-4779-a451-ce237ffefa7e'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:f4189539-7a50-341e-b2bf-6373cd8edd54', 1, NULL, 'G장조', 'No. 1 in G major', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 28 AND p.title = '마주르카 Op. 67' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM (SELECT piece_id, part_key FROM piece_parts) existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:f4189539-7a50-341e-b2bf-6373cd8edd54'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:eb4fbf72-552a-3ce9-93a1-10f8efb33a83', 2, NULL, 'G단조', 'No. 2 in G minor', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 28 AND p.title = '마주르카 Op. 67' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM (SELECT piece_id, part_key FROM piece_parts) existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:eb4fbf72-552a-3ce9-93a1-10f8efb33a83'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:58465fc3-4c80-326a-acfe-d5335a608057', 3, NULL, 'C장조', 'No. 3 in C major', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 28 AND p.title = '마주르카 Op. 67' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM (SELECT piece_id, part_key FROM piece_parts) existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:58465fc3-4c80-326a-acfe-d5335a608057'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:a83fd481-9935-3645-9786-8a8b19363743', 4, NULL, 'A단조', 'No. 4 in A minor', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 28 AND p.title = '마주르카 Op. 67' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM (SELECT piece_id, part_key FROM piece_parts) existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:a83fd481-9935-3645-9786-8a8b19363743'
);


-- Op. 68 마주르카 Op. 68

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '마주르카 Op. 68', '4 Mazurkas, Op. 68', 'album', NULL, 'Op.', '68', 1849, 'manual', 1
FROM composers c
WHERE c.id = 28
AND NOT EXISTS (
    SELECT 1 FROM (SELECT composer_id, title FROM pieces) existing
    WHERE existing.composer_id = c.id AND existing.title = '마주르카 Op. 68'
)
AND NOT EXISTS (
    SELECT 1 FROM (SELECT namespace, external_id FROM piece_identifiers) taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'c0afa6d3-2aaa-4bd7-8dfb-3ddbbec5db86'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'c0afa6d3-2aaa-4bd7-8dfb-3ddbbec5db86'
FROM pieces p
WHERE p.composer_id = 28 AND p.title = '마주르카 Op. 68' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM (SELECT namespace, external_id FROM piece_identifiers) taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'c0afa6d3-2aaa-4bd7-8dfb-3ddbbec5db86'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:a84e92ea-be35-380e-a444-4dd0443dda2b', 1, NULL, 'C장조', 'No. 1 in C major', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 28 AND p.title = '마주르카 Op. 68' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM (SELECT piece_id, part_key FROM piece_parts) existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:a84e92ea-be35-380e-a444-4dd0443dda2b'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:f1678460-5a8d-34a5-8818-07c2527baaf2', 2, NULL, 'A단조', 'No. 2 in A minor', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 28 AND p.title = '마주르카 Op. 68' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM (SELECT piece_id, part_key FROM piece_parts) existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:f1678460-5a8d-34a5-8818-07c2527baaf2'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:3465f5ba-a680-318e-b25f-157563d562d9', 3, NULL, 'F장조', 'No. 3 in F major', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 28 AND p.title = '마주르카 Op. 68' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM (SELECT piece_id, part_key FROM piece_parts) existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:3465f5ba-a680-318e-b25f-157563d562d9'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:873125f1-57a9-3427-8d12-11daf2faa55e', 4, NULL, 'F단조', 'No. 4 in F minor', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 28 AND p.title = '마주르카 Op. 68' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM (SELECT piece_id, part_key FROM piece_parts) existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:873125f1-57a9-3427-8d12-11daf2faa55e'
);


-- Op. 69 왈츠 Op. 69

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '왈츠 Op. 69', '2 Waltzes, Op. 69', 'album', NULL, 'Op.', '69', 1835, 'manual', 1
FROM composers c
WHERE c.id = 28
AND NOT EXISTS (
    SELECT 1 FROM (SELECT composer_id, title FROM pieces) existing
    WHERE existing.composer_id = c.id AND existing.title = '왈츠 Op. 69'
)
AND NOT EXISTS (
    SELECT 1 FROM (SELECT namespace, external_id FROM piece_identifiers) taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'f3013a02-5ebc-45c8-8821-82427f439a90'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'f3013a02-5ebc-45c8-8821-82427f439a90'
FROM pieces p
WHERE p.composer_id = 28 AND p.title = '왈츠 Op. 69' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM (SELECT namespace, external_id FROM piece_identifiers) taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'f3013a02-5ebc-45c8-8821-82427f439a90'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:cf315953-a2bf-32ec-be4b-0d4bfaf05e97', 1, NULL, 'A♭장조 "이별의 왈츠"', 'No. 1 in A♭ major "L''Adieu"', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 28 AND p.title = '왈츠 Op. 69' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM (SELECT piece_id, part_key FROM piece_parts) existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:cf315953-a2bf-32ec-be4b-0d4bfaf05e97'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:6fb51014-54d6-328f-9074-765c8db731fd', 2, NULL, 'B단조', 'No. 2 in B minor', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 28 AND p.title = '왈츠 Op. 69' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM (SELECT piece_id, part_key FROM piece_parts) existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:6fb51014-54d6-328f-9074-765c8db731fd'
);


-- Op. 70 왈츠 Op. 70

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '왈츠 Op. 70', '3 Waltzes, Op. 70', 'album', NULL, 'Op.', '70', 1841, 'manual', 1
FROM composers c
WHERE c.id = 28
AND NOT EXISTS (
    SELECT 1 FROM (SELECT composer_id, title FROM pieces) existing
    WHERE existing.composer_id = c.id AND existing.title = '왈츠 Op. 70'
)
AND NOT EXISTS (
    SELECT 1 FROM (SELECT namespace, external_id FROM piece_identifiers) taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'a56208f3-a97d-426f-9a23-187f6925b945'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'a56208f3-a97d-426f-9a23-187f6925b945'
FROM pieces p
WHERE p.composer_id = 28 AND p.title = '왈츠 Op. 70' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM (SELECT namespace, external_id FROM piece_identifiers) taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'a56208f3-a97d-426f-9a23-187f6925b945'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:7e8acf98-46ce-33f1-bfa0-d2a4b897a132', 1, NULL, 'G♭장조', 'No. 1 in G♭ major', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 28 AND p.title = '왈츠 Op. 70' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM (SELECT piece_id, part_key FROM piece_parts) existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:7e8acf98-46ce-33f1-bfa0-d2a4b897a132'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:4d494cc0-1376-3cd2-87af-67dfe20a5c06', 2, NULL, 'F단조', 'No. 2 in F minor', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 28 AND p.title = '왈츠 Op. 70' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM (SELECT piece_id, part_key FROM piece_parts) existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:4d494cc0-1376-3cd2-87af-67dfe20a5c06'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:3dd2ca0c-e59c-3743-8ad5-cc480ed61ac3', 3, NULL, 'D♭장조', 'No. 3 in D♭ major', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 28 AND p.title = '왈츠 Op. 70' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM (SELECT piece_id, part_key FROM piece_parts) existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:3dd2ca0c-e59c-3743-8ad5-cc480ed61ac3'
);


-- Op. 71 폴로네즈 Op. 71

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '폴로네즈 Op. 71', '3 Polonaises, Op. 71', 'album', NULL, 'Op.', '71', 1828, 'manual', 1
FROM composers c
WHERE c.id = 28
AND NOT EXISTS (
    SELECT 1 FROM (SELECT composer_id, title FROM pieces) existing
    WHERE existing.composer_id = c.id AND existing.title = '폴로네즈 Op. 71'
)
AND NOT EXISTS (
    SELECT 1 FROM (SELECT namespace, external_id FROM piece_identifiers) taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '5527be0f-3a46-47ad-9bc0-1bd2984515b8'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '5527be0f-3a46-47ad-9bc0-1bd2984515b8'
FROM pieces p
WHERE p.composer_id = 28 AND p.title = '폴로네즈 Op. 71' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM (SELECT namespace, external_id FROM piece_identifiers) taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '5527be0f-3a46-47ad-9bc0-1bd2984515b8'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:8b140678-2ba4-3f76-b18e-5b60fa0a0371', 1, NULL, 'D단조', 'No. 1 in D minor', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 28 AND p.title = '폴로네즈 Op. 71' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM (SELECT piece_id, part_key FROM piece_parts) existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:8b140678-2ba4-3f76-b18e-5b60fa0a0371'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:e2d728d9-16af-376c-9565-6d7a61979175', 2, NULL, 'B♭장조', 'No. 2 in B♭ major', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 28 AND p.title = '폴로네즈 Op. 71' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM (SELECT piece_id, part_key FROM piece_parts) existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:e2d728d9-16af-376c-9565-6d7a61979175'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:72378af3-14d4-4980-b944-f4c1cf929edf', 3, NULL, 'F단조', 'No. 3 in F minor', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 28 AND p.title = '폴로네즈 Op. 71' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM (SELECT piece_id, part_key FROM piece_parts) existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:72378af3-14d4-4980-b944-f4c1cf929edf'
);


-- Op. 72 녹턴, 장송 행진곡과 3개의 에코세즈 Op. 72

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '녹턴, 장송 행진곡과 3개의 에코세즈 Op. 72', 'Nocturne, Marche funèbre et 3 Écossaises, Op. 72', 'album', NULL, 'Op.', '72', 1827, 'manual', 1
FROM composers c
WHERE c.id = 28
AND NOT EXISTS (
    SELECT 1 FROM (SELECT composer_id, title FROM pieces) existing
    WHERE existing.composer_id = c.id AND existing.title = '녹턴, 장송 행진곡과 3개의 에코세즈 Op. 72'
)
AND NOT EXISTS (
    SELECT 1 FROM (SELECT namespace, external_id FROM piece_identifiers) taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '4bf96240-7e3d-4ce3-8d7b-a3736fa6e464'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '4bf96240-7e3d-4ce3-8d7b-a3736fa6e464'
FROM pieces p
WHERE p.composer_id = 28 AND p.title = '녹턴, 장송 행진곡과 3개의 에코세즈 Op. 72' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM (SELECT namespace, external_id FROM piece_identifiers) taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '4bf96240-7e3d-4ce3-8d7b-a3736fa6e464'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:0e42c133-fe9e-386e-ac26-ffe12249d3cc', 1, NULL, '녹턴 E단조', 'No. 1 Nocturne in E minor', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 28 AND p.title = '녹턴, 장송 행진곡과 3개의 에코세즈 Op. 72' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM (SELECT piece_id, part_key FROM piece_parts) existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:0e42c133-fe9e-386e-ac26-ffe12249d3cc'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:3a15846a-3f53-4eb2-b2f8-c1bc9c566256', 2, NULL, '장송 행진곡 C단조', 'No. 2 Marche funèbre in C minor', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 28 AND p.title = '녹턴, 장송 행진곡과 3개의 에코세즈 Op. 72' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM (SELECT piece_id, part_key FROM piece_parts) existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:3a15846a-3f53-4eb2-b2f8-c1bc9c566256'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:96fea892-c789-3516-afe0-391a3218a071', 3, NULL, '3개의 에코세즈', 'No. 3 Trois Écossaises', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 28 AND p.title = '녹턴, 장송 행진곡과 3개의 에코세즈 Op. 72' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM (SELECT piece_id, part_key FROM piece_parts) existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:96fea892-c789-3516-afe0-391a3218a071'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:422176b9-0bfc-3793-af5f-289f5c9dc42a', 1, NULL, 'D장조', 'No. 1 in D major', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN (SELECT id, piece_id, part_key FROM piece_parts) parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:96fea892-c789-3516-afe0-391a3218a071'
WHERE p.composer_id = 28 AND p.title = '녹턴, 장송 행진곡과 3개의 에코세즈 Op. 72' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM (SELECT piece_id, part_key FROM piece_parts) existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:422176b9-0bfc-3793-af5f-289f5c9dc42a'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:4a46f490-0a9f-3d78-9bb4-7911c4707811', 2, NULL, 'G장조', 'No. 2 in G major', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN (SELECT id, piece_id, part_key FROM piece_parts) parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:96fea892-c789-3516-afe0-391a3218a071'
WHERE p.composer_id = 28 AND p.title = '녹턴, 장송 행진곡과 3개의 에코세즈 Op. 72' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM (SELECT piece_id, part_key FROM piece_parts) existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:4a46f490-0a9f-3d78-9bb4-7911c4707811'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:939845a7-7e73-3771-b89d-51e4bae8b69b', 3, NULL, 'D♭장조', 'No. 3 in D♭ major', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN (SELECT id, piece_id, part_key FROM piece_parts) parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:96fea892-c789-3516-afe0-391a3218a071'
WHERE p.composer_id = 28 AND p.title = '녹턴, 장송 행진곡과 3개의 에코세즈 Op. 72' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM (SELECT piece_id, part_key FROM piece_parts) existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:939845a7-7e73-3771-b89d-51e4bae8b69b'
);


-- Op. 73 두 대의 피아노를 위한 론도 C장조

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '두 대의 피아노를 위한 론도 C장조', 'Rondo in C major for two pianos', 'song', 'Op. 73', NULL, NULL, 1828, 'manual', 1
FROM composers c
WHERE c.id = 28
AND NOT EXISTS (
    SELECT 1 FROM (SELECT composer_id, title FROM pieces) existing
    WHERE existing.composer_id = c.id AND existing.title = '두 대의 피아노를 위한 론도 C장조'
)
AND NOT EXISTS (
    SELECT 1 FROM (SELECT namespace, external_id FROM piece_identifiers) taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '039bc553-f984-46e4-95bd-d436e1524a1f'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '039bc553-f984-46e4-95bd-d436e1524a1f'
FROM pieces p
WHERE p.composer_id = 28 AND p.title = '두 대의 피아노를 위한 론도 C장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM (SELECT namespace, external_id FROM piece_identifiers) taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '039bc553-f984-46e4-95bd-d436e1524a1f'
);


-- Op. 74 17개의 폴란드 가곡 Op. 74

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '17개의 폴란드 가곡 Op. 74', '17 Polish Songs, Op. 74', 'album', NULL, 'Op.', '74', 1847, 'manual', 1
FROM composers c
WHERE c.id = 28
AND NOT EXISTS (
    SELECT 1 FROM (SELECT composer_id, title FROM pieces) existing
    WHERE existing.composer_id = c.id AND existing.title = '17개의 폴란드 가곡 Op. 74'
)
AND NOT EXISTS (
    SELECT 1 FROM (SELECT namespace, external_id FROM piece_identifiers) taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'ed0ff8c4-1d48-4c8d-b404-c74aff1ae404'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'ed0ff8c4-1d48-4c8d-b404-c74aff1ae404'
FROM pieces p
WHERE p.composer_id = 28 AND p.title = '17개의 폴란드 가곡 Op. 74' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM (SELECT namespace, external_id FROM piece_identifiers) taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'ed0ff8c4-1d48-4c8d-b404-c74aff1ae404'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:9c02d342-9b1c-387f-9424-74f46e5d927d', 1, NULL, '소원 (Życzenie)', 'No. 1 "Życzenie" (The Wish)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 28 AND p.title = '17개의 폴란드 가곡 Op. 74' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM (SELECT piece_id, part_key FROM piece_parts) existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:9c02d342-9b1c-387f-9424-74f46e5d927d'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:af31ac4b-6498-3b6b-921c-5aabf75365d4', 2, NULL, '봄 (Wiosna)', 'No. 2 "Wiosna" (Spring)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 28 AND p.title = '17개의 폴란드 가곡 Op. 74' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM (SELECT piece_id, part_key FROM piece_parts) existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:af31ac4b-6498-3b6b-921c-5aabf75365d4'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:f9da1e95-290b-49ad-8eb6-fde795d0d7b4', 3, NULL, '슬픈 강 (Smutna rzeka)', 'No. 3 "Smutna rzeka" (The Sad River)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 28 AND p.title = '17개의 폴란드 가곡 Op. 74' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM (SELECT piece_id, part_key FROM piece_parts) existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:f9da1e95-290b-49ad-8eb6-fde795d0d7b4'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:3625f080-f6ed-3642-8f92-bb13e11dfd14', 4, NULL, '술잔치 (Hulanka)', 'No. 4 "Hulanka" (Merrymaking)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 28 AND p.title = '17개의 폴란드 가곡 Op. 74' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM (SELECT piece_id, part_key FROM piece_parts) existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:3625f080-f6ed-3642-8f92-bb13e11dfd14'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:a223efa0-d2b9-4cd9-a7bb-f6150484c675', 5, NULL, '좋아하는 곳 (Gdzie lubi)', 'No. 5 "Gdzie lubi" (What She Likes)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 28 AND p.title = '17개의 폴란드 가곡 Op. 74' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM (SELECT piece_id, part_key FROM piece_parts) existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:a223efa0-d2b9-4cd9-a7bb-f6150484c675'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:a63bc2f3-d91e-4f10-962b-4a49d1637805', 6, NULL, '내 눈앞에서 사라져라 (Precz z moich oczu)', 'No. 6 "Precz z moich oczu" (Out of My Sight)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 28 AND p.title = '17개의 폴란드 가곡 Op. 74' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM (SELECT piece_id, part_key FROM piece_parts) existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:a63bc2f3-d91e-4f10-962b-4a49d1637805'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:2f44afd8-2dfa-4472-9dcd-307f48eaf9fe', 7, NULL, '전령 (Poseł)', 'No. 7 "Poseł" (The Messenger)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 28 AND p.title = '17개의 폴란드 가곡 Op. 74' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM (SELECT piece_id, part_key FROM piece_parts) existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:2f44afd8-2dfa-4472-9dcd-307f48eaf9fe'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:4c3e6484-c834-4907-a9c3-373cb3bef88c', 8, NULL, '멋진 젊은이 (Śliczny chłopiec)', 'No. 8 "Śliczny chłopiec" (Handsome Lad)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 28 AND p.title = '17개의 폴란드 가곡 Op. 74' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM (SELECT piece_id, part_key FROM piece_parts) existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:4c3e6484-c834-4907-a9c3-373cb3bef88c'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:a31ce587-c315-405c-ac78-e9f685da0d81', 9, NULL, '멜로디 (Melodia)', 'No. 9 "Melodia" (Melody)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 28 AND p.title = '17개의 폴란드 가곡 Op. 74' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM (SELECT piece_id, part_key FROM piece_parts) existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:a31ce587-c315-405c-ac78-e9f685da0d81'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:0a8bb0ae-332e-474e-997f-0960f862d7ca', 10, NULL, '전사 (Wojak)', 'No. 10 "Wojak" (The Warrior)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 28 AND p.title = '17개의 폴란드 가곡 Op. 74' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM (SELECT piece_id, part_key FROM piece_parts) existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:0a8bb0ae-332e-474e-997f-0960f862d7ca'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:154d7d28-8d19-4067-9fe4-4898216c4a7b', 11, NULL, '두 가지 결말 (Dwojaki koniec)', 'No. 11 "Dwojaki koniec" (The Double End)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 28 AND p.title = '17개의 폴란드 가곡 Op. 74' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM (SELECT piece_id, part_key FROM piece_parts) existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:154d7d28-8d19-4067-9fe4-4898216c4a7b'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:2fa3e084-3bcf-4633-819c-1b447869d02b', 12, NULL, '나의 귀여운 이 (Moja pieszczotka)', 'No. 12 "Moja pieszczotka" (My Darling)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 28 AND p.title = '17개의 폴란드 가곡 Op. 74' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM (SELECT piece_id, part_key FROM piece_parts) existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:2fa3e084-3bcf-4633-819c-1b447869d02b'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:1666def4-d632-46eb-a84d-7c574d73db65', 13, NULL, '필요한 것이 없네 (Nie ma czego trzeba)', 'No. 13 "Nie ma czego trzeba" (I Want What I Have Not)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 28 AND p.title = '17개의 폴란드 가곡 Op. 74' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM (SELECT piece_id, part_key FROM piece_parts) existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:1666def4-d632-46eb-a84d-7c574d73db65'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:20f8f987-87b8-3650-971c-ec48de2c43b6', 14, NULL, '반지 (Pierścień)', 'No. 14 "Pierścień" (The Ring)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 28 AND p.title = '17개의 폴란드 가곡 Op. 74' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM (SELECT piece_id, part_key FROM piece_parts) existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:20f8f987-87b8-3650-971c-ec48de2c43b6'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:4040702b-1d28-4ea9-a2a3-106a318f159b', 15, NULL, '신랑 (Narzeczony)', 'No. 15 "Narzeczony" (The Bridegroom)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 28 AND p.title = '17개의 폴란드 가곡 Op. 74' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM (SELECT piece_id, part_key FROM piece_parts) existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:4040702b-1d28-4ea9-a2a3-106a318f159b'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:f8ce7557-36d2-441d-b2df-85f1b359627f', 16, NULL, '리투아니아 노래 (Piosnka litewska)', 'No. 16 "Piosnka litewska" (Lithuanian Song)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 28 AND p.title = '17개의 폴란드 가곡 Op. 74' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM (SELECT piece_id, part_key FROM piece_parts) existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:f8ce7557-36d2-441d-b2df-85f1b359627f'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:2d36a492-4664-49ce-b493-cb75b33e958f', 17, NULL, '무덤가의 노래 (Śpiew z mogiłki)', 'No. 17 "Śpiew z mogiłki" (Hymn from the Tomb)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 28 AND p.title = '17개의 폴란드 가곡 Op. 74' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM (SELECT piece_id, part_key FROM piece_parts) existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:2d36a492-4664-49ce-b493-cb75b33e958f'
);


-- B. 1 폴로네즈 G단조

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '폴로네즈 G단조', 'Polonaise in G minor', 'song', 'B. 1', NULL, NULL, 1817, 'manual', 1
FROM composers c
WHERE c.id = 28
AND NOT EXISTS (
    SELECT 1 FROM (SELECT composer_id, title FROM pieces) existing
    WHERE existing.composer_id = c.id AND existing.title = '폴로네즈 G단조'
)
AND NOT EXISTS (
    SELECT 1 FROM (SELECT namespace, external_id FROM piece_identifiers) taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'ca9231b4-b30b-44d7-adec-21b7a02fa5a2'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'ca9231b4-b30b-44d7-adec-21b7a02fa5a2'
FROM pieces p
WHERE p.composer_id = 28 AND p.title = '폴로네즈 G단조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM (SELECT namespace, external_id FROM piece_identifiers) taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'ca9231b4-b30b-44d7-adec-21b7a02fa5a2'
);


-- B. 3 폴로네즈 B♭장조

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '폴로네즈 B♭장조', 'Polonaise in B♭ major', 'song', 'B. 3', NULL, NULL, 1817, 'manual', 1
FROM composers c
WHERE c.id = 28
AND NOT EXISTS (
    SELECT 1 FROM (SELECT composer_id, title FROM pieces) existing
    WHERE existing.composer_id = c.id AND existing.title = '폴로네즈 B♭장조'
)
AND NOT EXISTS (
    SELECT 1 FROM (SELECT namespace, external_id FROM piece_identifiers) taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'b461cbce-3a72-44b6-bcff-6eb7d4f4b0ef'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'b461cbce-3a72-44b6-bcff-6eb7d4f4b0ef'
FROM pieces p
WHERE p.composer_id = 28 AND p.title = '폴로네즈 B♭장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM (SELECT namespace, external_id FROM piece_identifiers) taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'b461cbce-3a72-44b6-bcff-6eb7d4f4b0ef'
);


-- B. 5 폴로네즈 A♭장조

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '폴로네즈 A♭장조', 'Polonaise in A♭ major', 'song', 'B. 5', NULL, NULL, 1821, 'manual', 1
FROM composers c
WHERE c.id = 28
AND NOT EXISTS (
    SELECT 1 FROM (SELECT composer_id, title FROM pieces) existing
    WHERE existing.composer_id = c.id AND existing.title = '폴로네즈 A♭장조'
)
AND NOT EXISTS (
    SELECT 1 FROM (SELECT namespace, external_id FROM piece_identifiers) taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '859e1ec7-ab78-4705-9fd3-9467133fd549'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '859e1ec7-ab78-4705-9fd3-9467133fd549'
FROM pieces p
WHERE p.composer_id = 28 AND p.title = '폴로네즈 A♭장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM (SELECT namespace, external_id FROM piece_identifiers) taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '859e1ec7-ab78-4705-9fd3-9467133fd549'
);


-- B. 6 폴로네즈 G#단조

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '폴로네즈 G#단조', 'Polonaise in G# minor', 'song', 'B. 6', NULL, NULL, 1822, 'manual', 1
FROM composers c
WHERE c.id = 28
AND NOT EXISTS (
    SELECT 1 FROM (SELECT composer_id, title FROM pieces) existing
    WHERE existing.composer_id = c.id AND existing.title = '폴로네즈 G#단조'
)
AND NOT EXISTS (
    SELECT 1 FROM (SELECT namespace, external_id FROM piece_identifiers) taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'ecdbe10e-90fa-43eb-9bf0-a89e23213a0a'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'ecdbe10e-90fa-43eb-9bf0-a89e23213a0a'
FROM pieces p
WHERE p.composer_id = 28 AND p.title = '폴로네즈 G#단조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM (SELECT namespace, external_id FROM piece_identifiers) taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'ecdbe10e-90fa-43eb-9bf0-a89e23213a0a'
);


-- B. 12a 무어의 아일랜드 민요 주제에 의한 변주곡 D장조

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '무어의 아일랜드 민요 주제에 의한 변주곡 D장조', 'Variations in D major on an Irish National Air (Moore)', 'song', 'B. 12a', NULL, NULL, 1826, 'manual', 1
FROM composers c
WHERE c.id = 28
AND NOT EXISTS (
    SELECT 1 FROM (SELECT composer_id, title FROM pieces) existing
    WHERE existing.composer_id = c.id AND existing.title = '무어의 아일랜드 민요 주제에 의한 변주곡 D장조'
)
AND NOT EXISTS (
    SELECT 1 FROM (SELECT namespace, external_id FROM piece_identifiers) taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '33438124-5304-4627-8d40-ff3b9a2c7d05'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '33438124-5304-4627-8d40-ff3b9a2c7d05'
FROM pieces p
WHERE p.composer_id = 28 AND p.title = '무어의 아일랜드 민요 주제에 의한 변주곡 D장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM (SELECT namespace, external_id FROM piece_identifiers) taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '33438124-5304-4627-8d40-ff3b9a2c7d05'
);


-- B. 13 폴로네즈 B♭단조

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '폴로네즈 B♭단조', 'Polonaise in B♭ minor "Adieu à Guillaume Kolberg"', 'song', 'B. 13', NULL, NULL, 1826, 'manual', 1
FROM composers c
WHERE c.id = 28
AND NOT EXISTS (
    SELECT 1 FROM (SELECT composer_id, title FROM pieces) existing
    WHERE existing.composer_id = c.id AND existing.title = '폴로네즈 B♭단조'
)
AND NOT EXISTS (
    SELECT 1 FROM (SELECT namespace, external_id FROM piece_identifiers) taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '5bf96556-9439-4059-ac91-2c03d4929ea8'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '5bf96556-9439-4059-ac91-2c03d4929ea8'
FROM pieces p
WHERE p.composer_id = 28 AND p.title = '폴로네즈 B♭단조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM (SELECT namespace, external_id FROM piece_identifiers) taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '5bf96556-9439-4059-ac91-2c03d4929ea8'
);


-- B. 14 독일 민요 주제에 의한 변주곡 E장조

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '독일 민요 주제에 의한 변주곡 E장조', 'Variations in E major on a German Air ("Der Schweizerbub")', 'song', 'B. 14', NULL, NULL, 1826, 'manual', 1
FROM composers c
WHERE c.id = 28
AND NOT EXISTS (
    SELECT 1 FROM (SELECT composer_id, title FROM pieces) existing
    WHERE existing.composer_id = c.id AND existing.title = '독일 민요 주제에 의한 변주곡 E장조'
)
AND NOT EXISTS (
    SELECT 1 FROM (SELECT namespace, external_id FROM piece_identifiers) taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '5bc37d15-76b8-4c6f-bcb9-089428a9f8a0'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '5bc37d15-76b8-4c6f-bcb9-089428a9f8a0'
FROM pieces p
WHERE p.composer_id = 28 AND p.title = '독일 민요 주제에 의한 변주곡 E장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM (SELECT namespace, external_id FROM piece_identifiers) taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '5bc37d15-76b8-4c6f-bcb9-089428a9f8a0'
);


-- B. 16 마주르카 B. 16

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '마주르카 B. 16', '2 Mazurkas, B. 16', 'album', NULL, 'B.', '16', 1826, 'manual', 1
FROM composers c
WHERE c.id = 28
AND NOT EXISTS (
    SELECT 1 FROM (SELECT composer_id, title FROM pieces) existing
    WHERE existing.composer_id = c.id AND existing.title = '마주르카 B. 16'
)
AND NOT EXISTS (
    SELECT 1 FROM (SELECT namespace, external_id FROM piece_identifiers) taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '1bb71769-3c21-49f5-afa0-15f4a249f8f7'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '1bb71769-3c21-49f5-afa0-15f4a249f8f7'
FROM pieces p
WHERE p.composer_id = 28 AND p.title = '마주르카 B. 16' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM (SELECT namespace, external_id FROM piece_identifiers) taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '1bb71769-3c21-49f5-afa0-15f4a249f8f7'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:d8f75379-6358-4250-ab80-6330eda64ae3', 1, NULL, 'G장조', 'No. 1 in G major', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 28 AND p.title = '마주르카 B. 16' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM (SELECT piece_id, part_key FROM piece_parts) existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:d8f75379-6358-4250-ab80-6330eda64ae3'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:99f0b765-e5ab-403e-8138-e48aad268d90', 2, NULL, 'B♭장조', 'No. 2 in B♭ major', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 28 AND p.title = '마주르카 B. 16' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM (SELECT piece_id, part_key FROM piece_parts) existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:99f0b765-e5ab-403e-8138-e48aad268d90'
);


-- B. 21 왈츠 16번 A♭장조

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '왈츠 16번 A♭장조', 'Waltz No. 16 in A♭ major', 'song', 'B. 21', NULL, NULL, 1827, 'manual', 1
FROM composers c
WHERE c.id = 28
AND NOT EXISTS (
    SELECT 1 FROM (SELECT composer_id, title FROM pieces) existing
    WHERE existing.composer_id = c.id AND existing.title = '왈츠 16번 A♭장조'
)
AND NOT EXISTS (
    SELECT 1 FROM (SELECT namespace, external_id FROM piece_identifiers) taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '0739272d-2603-341c-8347-817f34e28520'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '0739272d-2603-341c-8347-817f34e28520'
FROM pieces p
WHERE p.composer_id = 28 AND p.title = '왈츠 16번 A♭장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM (SELECT namespace, external_id FROM piece_identifiers) taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '0739272d-2603-341c-8347-817f34e28520'
);


-- B. 31 마주르카 D장조 (첫 판)

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '마주르카 D장조 (첫 판)', 'Mazurka in D major (first version)', 'song', 'B. 31', NULL, NULL, 1829, 'manual', 1
FROM composers c
WHERE c.id = 28
AND NOT EXISTS (
    SELECT 1 FROM (SELECT composer_id, title FROM pieces) existing
    WHERE existing.composer_id = c.id AND existing.title = '마주르카 D장조 (첫 판)'
)
AND NOT EXISTS (
    SELECT 1 FROM (SELECT namespace, external_id FROM piece_identifiers) taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '8e33cdb7-44e3-41af-ad57-0eb63a794c37'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '8e33cdb7-44e3-41af-ad57-0eb63a794c37'
FROM pieces p
WHERE p.composer_id = 28 AND p.title = '마주르카 D장조 (첫 판)' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM (SELECT namespace, external_id FROM piece_identifiers) taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '8e33cdb7-44e3-41af-ad57-0eb63a794c37'
);


-- B. 36 폴로네즈 G♭장조

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '폴로네즈 G♭장조', 'Polonaise in G♭ major', 'song', 'B. 36', NULL, NULL, 1829, 'manual', 1
FROM composers c
WHERE c.id = 28
AND NOT EXISTS (
    SELECT 1 FROM (SELECT composer_id, title FROM pieces) existing
    WHERE existing.composer_id = c.id AND existing.title = '폴로네즈 G♭장조'
)
AND NOT EXISTS (
    SELECT 1 FROM (SELECT namespace, external_id FROM piece_identifiers) taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '51b00e6d-b2fb-4dec-a34d-ca8246a6d353'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '51b00e6d-b2fb-4dec-a34d-ca8246a6d353'
FROM pieces p
WHERE p.composer_id = 28 AND p.title = '폴로네즈 G♭장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM (SELECT namespace, external_id FROM piece_identifiers) taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '51b00e6d-b2fb-4dec-a34d-ca8246a6d353'
);


-- B. 37 변주곡 A장조 "파가니니의 추억"

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '변주곡 A장조 "파가니니의 추억"', 'Variations in A major "Souvenir de Paganini"', 'song', 'B. 37', NULL, NULL, 1829, 'manual', 1
FROM composers c
WHERE c.id = 28
AND NOT EXISTS (
    SELECT 1 FROM (SELECT composer_id, title FROM pieces) existing
    WHERE existing.composer_id = c.id AND existing.title = '변주곡 A장조 "파가니니의 추억"'
)
AND NOT EXISTS (
    SELECT 1 FROM (SELECT namespace, external_id FROM piece_identifiers) taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '2086e0ea-2728-3a78-a19b-e84dcaf2056a'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '2086e0ea-2728-3a78-a19b-e84dcaf2056a'
FROM pieces p
WHERE p.composer_id = 28 AND p.title = '변주곡 A장조 "파가니니의 추억"' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM (SELECT namespace, external_id FROM piece_identifiers) taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '2086e0ea-2728-3a78-a19b-e84dcaf2056a'
);


-- B. 39 가곡 "어떤 꽃, 어떤 화관"

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '가곡 "어떤 꽃, 어떤 화관"', 'Song "Jakież kwiaty, jakie wianki" (Mazur)', 'song', 'B. 39', NULL, NULL, 1829, 'manual', 1
FROM composers c
WHERE c.id = 28
AND NOT EXISTS (
    SELECT 1 FROM (SELECT composer_id, title FROM pieces) existing
    WHERE existing.composer_id = c.id AND existing.title = '가곡 "어떤 꽃, 어떤 화관"'
);


-- B. 44 왈츠 15번 E장조

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '왈츠 15번 E장조', 'Waltz No. 15 in E major', 'song', 'B. 44', NULL, NULL, 1829, 'manual', 1
FROM composers c
WHERE c.id = 28
AND NOT EXISTS (
    SELECT 1 FROM (SELECT composer_id, title FROM pieces) existing
    WHERE existing.composer_id = c.id AND existing.title = '왈츠 15번 E장조'
)
AND NOT EXISTS (
    SELECT 1 FROM (SELECT namespace, external_id FROM piece_identifiers) taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '1e51fb41-7a63-3f3f-85b9-121ddc5e706d'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '1e51fb41-7a63-3f3f-85b9-121ddc5e706d'
FROM pieces p
WHERE p.composer_id = 28 AND p.title = '왈츠 15번 E장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM (SELECT namespace, external_id FROM piece_identifiers) taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '1e51fb41-7a63-3f3f-85b9-121ddc5e706d'
);


-- B. 46 왈츠 17번 E♭장조

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '왈츠 17번 E♭장조', 'Waltz No. 17 in E♭ major', 'song', 'B. 46', NULL, NULL, 1827, 'manual', 1
FROM composers c
WHERE c.id = 28
AND NOT EXISTS (
    SELECT 1 FROM (SELECT composer_id, title FROM pieces) existing
    WHERE existing.composer_id = c.id AND existing.title = '왈츠 17번 E♭장조'
)
AND NOT EXISTS (
    SELECT 1 FROM (SELECT namespace, external_id FROM piece_identifiers) taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '239f34ce-88f2-3d90-bd8f-bfcab296dcd4'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '239f34ce-88f2-3d90-bd8f-bfcab296dcd4'
FROM pieces p
WHERE p.composer_id = 28 AND p.title = '왈츠 17번 E♭장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM (SELECT namespace, external_id FROM piece_identifiers) taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '239f34ce-88f2-3d90-bd8f-bfcab296dcd4'
);


-- B. 51 가곡 "마법"

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '가곡 "마법"', 'Song "Czary" (Enchantment)', 'song', 'B. 51', NULL, NULL, 1830, 'manual', 1
FROM composers c
WHERE c.id = 28
AND NOT EXISTS (
    SELECT 1 FROM (SELECT composer_id, title FROM pieces) existing
    WHERE existing.composer_id = c.id AND existing.title = '가곡 "마법"'
)
AND NOT EXISTS (
    SELECT 1 FROM (SELECT namespace, external_id FROM piece_identifiers) taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '9c9e273d-5398-4e3f-88c8-2d3537317b5a'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '9c9e273d-5398-4e3f-88c8-2d3537317b5a'
FROM pieces p
WHERE p.composer_id = 28 AND p.title = '가곡 "마법"' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM (SELECT namespace, external_id FROM piece_identifiers) taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '9c9e273d-5398-4e3f-88c8-2d3537317b5a'
);


-- B. 56 왈츠 14번 E단조

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '왈츠 14번 E단조', 'Waltz No. 14 in E minor', 'song', 'B. 56', NULL, NULL, 1830, 'manual', 1
FROM composers c
WHERE c.id = 28
AND NOT EXISTS (
    SELECT 1 FROM (SELECT composer_id, title FROM pieces) existing
    WHERE existing.composer_id = c.id AND existing.title = '왈츠 14번 E단조'
)
AND NOT EXISTS (
    SELECT 1 FROM (SELECT namespace, external_id FROM piece_identifiers) taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '09560144-c191-3973-b247-be43f7c308c2'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '09560144-c191-3973-b247-be43f7c308c2'
FROM pieces p
WHERE p.composer_id = 28 AND p.title = '왈츠 14번 E단조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM (SELECT namespace, external_id FROM piece_identifiers) taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '09560144-c191-3973-b247-be43f7c308c2'
);


-- B. 70 <악마 로베르> 주제에 의한 협주풍 대이중주 E장조

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '<악마 로베르> 주제에 의한 협주풍 대이중주 E장조', 'Grand Duo concertant in E major on themes from Meyerbeer''s Robert le diable', 'song', 'B. 70', NULL, NULL, 1832, 'manual', 1
FROM composers c
WHERE c.id = 28
AND NOT EXISTS (
    SELECT 1 FROM (SELECT composer_id, title FROM pieces) existing
    WHERE existing.composer_id = c.id AND existing.title = '<악마 로베르> 주제에 의한 협주풍 대이중주 E장조'
)
AND NOT EXISTS (
    SELECT 1 FROM (SELECT namespace, external_id FROM piece_identifiers) taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '9db86bff-bf65-4d21-a053-86b5fc7a15af'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '9db86bff-bf65-4d21-a053-86b5fc7a15af'
FROM pieces p
WHERE p.composer_id = 28 AND p.title = '<악마 로베르> 주제에 의한 협주풍 대이중주 E장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM (SELECT namespace, external_id FROM piece_identifiers) taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '9db86bff-bf65-4d21-a053-86b5fc7a15af'
);


-- B. 71 마주르카 D장조 (고친 판)

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '마주르카 D장조 (고친 판)', 'Mazurka in D major (second version)', 'song', 'B. 71', NULL, NULL, 1832, 'manual', 1
FROM composers c
WHERE c.id = 28
AND NOT EXISTS (
    SELECT 1 FROM (SELECT composer_id, title FROM pieces) existing
    WHERE existing.composer_id = c.id AND existing.title = '마주르카 D장조 (고친 판)'
)
AND NOT EXISTS (
    SELECT 1 FROM (SELECT namespace, external_id FROM piece_identifiers) taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '2412d95c-0ef9-459b-9d3a-52e41ca51ba0'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '2412d95c-0ef9-459b-9d3a-52e41ca51ba0'
FROM pieces p
WHERE p.composer_id = 28 AND p.title = '마주르카 D장조 (고친 판)' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM (SELECT namespace, external_id FROM piece_identifiers) taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '2412d95c-0ef9-459b-9d3a-52e41ca51ba0'
);


-- B. 73 마주르카 B♭장조

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '마주르카 B♭장조', 'Mazurka in B♭ major "à Alexandra Wołowska"', 'song', 'B. 73', NULL, NULL, 1832, 'manual', 1
FROM composers c
WHERE c.id = 28
AND NOT EXISTS (
    SELECT 1 FROM (SELECT composer_id, title FROM pieces) existing
    WHERE existing.composer_id = c.id AND existing.title = '마주르카 B♭장조'
)
AND NOT EXISTS (
    SELECT 1 FROM (SELECT namespace, external_id FROM piece_identifiers) taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'b02da1dd-6d34-406b-9022-2be59a6fab0e'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'b02da1dd-6d34-406b-9022-2be59a6fab0e'
FROM pieces p
WHERE p.composer_id = 28 AND p.title = '마주르카 B♭장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM (SELECT namespace, external_id FROM piece_identifiers) taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'b02da1dd-6d34-406b-9022-2be59a6fab0e'
);


-- B. 82 마주르카 C장조

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '마주르카 C장조', 'Mazurka in C major', 'song', 'B. 82', NULL, NULL, 1833, 'manual', 1
FROM composers c
WHERE c.id = 28
AND NOT EXISTS (
    SELECT 1 FROM (SELECT composer_id, title FROM pieces) existing
    WHERE existing.composer_id = c.id AND existing.title = '마주르카 C장조'
)
AND NOT EXISTS (
    SELECT 1 FROM (SELECT namespace, external_id FROM piece_identifiers) taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'd8fd2536-7cba-4832-bd12-7393c1e669ed'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'd8fd2536-7cba-4832-bd12-7393c1e669ed'
FROM pieces p
WHERE p.composer_id = 28 AND p.title = '마주르카 C장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM (SELECT namespace, external_id FROM piece_identifiers) taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'd8fd2536-7cba-4832-bd12-7393c1e669ed'
);


-- B. 84 칸타빌레 B♭장조

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '칸타빌레 B♭장조', 'Cantabile in B♭ major', 'song', 'B. 84', NULL, NULL, 1834, 'manual', 1
FROM composers c
WHERE c.id = 28
AND NOT EXISTS (
    SELECT 1 FROM (SELECT composer_id, title FROM pieces) existing
    WHERE existing.composer_id = c.id AND existing.title = '칸타빌레 B♭장조'
)
AND NOT EXISTS (
    SELECT 1 FROM (SELECT namespace, external_id FROM piece_identifiers) taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '0c471b8a-3447-37b3-9a17-b13899a6f325'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '0c471b8a-3447-37b3-9a17-b13899a6f325'
FROM pieces p
WHERE p.composer_id = 28 AND p.title = '칸타빌레 B♭장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM (SELECT namespace, external_id FROM piece_identifiers) taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '0c471b8a-3447-37b3-9a17-b13899a6f325'
);


-- B. 85 마주르카 A♭장조

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '마주르카 A♭장조', 'Mazurka in A♭ major', 'song', 'B. 85', NULL, NULL, 1834, 'manual', 1
FROM composers c
WHERE c.id = 28
AND NOT EXISTS (
    SELECT 1 FROM (SELECT composer_id, title FROM pieces) existing
    WHERE existing.composer_id = c.id AND existing.title = '마주르카 A♭장조'
)
AND NOT EXISTS (
    SELECT 1 FROM (SELECT namespace, external_id FROM piece_identifiers) taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'c86873bb-7591-4bf1-8dc9-48d05b66ba61'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'c86873bb-7591-4bf1-8dc9-48d05b66ba61'
FROM pieces p
WHERE p.composer_id = 28 AND p.title = '마주르카 A♭장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM (SELECT namespace, external_id FROM piece_identifiers) taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'c86873bb-7591-4bf1-8dc9-48d05b66ba61'
);


-- B. 86 전주곡 A♭장조

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '전주곡 A♭장조', 'Prélude in A♭ major', 'song', 'B. 86', NULL, NULL, 1834, 'manual', 1
FROM composers c
WHERE c.id = 28
AND NOT EXISTS (
    SELECT 1 FROM (SELECT composer_id, title FROM pieces) existing
    WHERE existing.composer_id = c.id AND existing.title = '전주곡 A♭장조'
)
AND NOT EXISTS (
    SELECT 1 FROM (SELECT namespace, external_id FROM piece_identifiers) taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '06e1a851-e8dc-3543-ab77-eeaa7cd83dca'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '06e1a851-e8dc-3543-ab77-eeaa7cd83dca'
FROM pieces p
WHERE p.composer_id = 28 AND p.title = '전주곡 A♭장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM (SELECT namespace, external_id FROM piece_identifiers) taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '06e1a851-e8dc-3543-ab77-eeaa7cd83dca'
);


-- B. 108 녹턴 21번 C단조

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '녹턴 21번 C단조', 'Nocturne No. 21 in C minor', 'song', 'B. 108', NULL, NULL, 1837, 'manual', 1
FROM composers c
WHERE c.id = 28
AND NOT EXISTS (
    SELECT 1 FROM (SELECT composer_id, title FROM pieces) existing
    WHERE existing.composer_id = c.id AND existing.title = '녹턴 21번 C단조'
)
AND NOT EXISTS (
    SELECT 1 FROM (SELECT namespace, external_id FROM piece_identifiers) taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'a954562c-003a-33df-9e88-b001a759a01c'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'a954562c-003a-33df-9e88-b001a759a01c'
FROM pieces p
WHERE p.composer_id = 28 AND p.title = '녹턴 21번 C단조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM (SELECT namespace, external_id FROM piece_identifiers) taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'a954562c-003a-33df-9e88-b001a759a01c'
);


-- B. 113 <헥사메론> 6변주 E장조

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '<헥사메론> 6변주 E장조', 'Hexaméron: Variation No. 6 in E major', 'song', 'B. 113', NULL, NULL, 1837, 'manual', 1
FROM composers c
WHERE c.id = 28
AND NOT EXISTS (
    SELECT 1 FROM (SELECT composer_id, title FROM pieces) existing
    WHERE existing.composer_id = c.id AND existing.title = '<헥사메론> 6변주 E장조'
)
AND NOT EXISTS (
    SELECT 1 FROM (SELECT namespace, external_id FROM piece_identifiers) taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '731e5306-163e-36c4-80ee-34f984a52178'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '731e5306-163e-36c4-80ee-34f984a52178'
FROM pieces p
WHERE p.composer_id = 28 AND p.title = '<헥사메론> 6변주 E장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM (SELECT namespace, external_id FROM piece_identifiers) taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '731e5306-163e-36c4-80ee-34f984a52178'
);


-- B. 117 안단티노 G단조

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '안단티노 G단조', 'Andantino in G minor', 'song', 'B. 117', NULL, NULL, 1838, 'manual', 1
FROM composers c
WHERE c.id = 28
AND NOT EXISTS (
    SELECT 1 FROM (SELECT composer_id, title FROM pieces) existing
    WHERE existing.composer_id = c.id AND existing.title = '안단티노 G단조'
)
AND NOT EXISTS (
    SELECT 1 FROM (SELECT namespace, external_id FROM piece_identifiers) taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'd7335a80-7b58-4f1a-a236-b8d566ca6196'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'd7335a80-7b58-4f1a-a236-b8d566ca6196'
FROM pieces p
WHERE p.composer_id = 28 AND p.title = '안단티노 G단조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM (SELECT namespace, external_id FROM piece_identifiers) taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'd7335a80-7b58-4f1a-a236-b8d566ca6196'
);


-- B. 129b 카논 F단조

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '카논 F단조', 'Canon in F minor', 'song', 'B. 129b', NULL, NULL, 1839, 'manual', 1
FROM composers c
WHERE c.id = 28
AND NOT EXISTS (
    SELECT 1 FROM (SELECT composer_id, title FROM pieces) existing
    WHERE existing.composer_id = c.id AND existing.title = '카논 F단조'
)
AND NOT EXISTS (
    SELECT 1 FROM (SELECT namespace, external_id FROM piece_identifiers) taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '58968e95-38e0-401c-8e98-b3b3d9d545fb'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '58968e95-38e0-401c-8e98-b3b3d9d545fb'
FROM pieces p
WHERE p.composer_id = 28 AND p.title = '카논 F단조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM (SELECT namespace, external_id FROM piece_identifiers) taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '58968e95-38e0-401c-8e98-b3b3d9d545fb'
);


-- B. 130 3개의 새로운 연습곡

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '3개의 새로운 연습곡', 'Trois nouvelles études, B. 130', 'album', NULL, 'B.', '130', 1839, 'manual', 1
FROM composers c
WHERE c.id = 28
AND NOT EXISTS (
    SELECT 1 FROM (SELECT composer_id, title FROM pieces) existing
    WHERE existing.composer_id = c.id AND existing.title = '3개의 새로운 연습곡'
)
AND NOT EXISTS (
    SELECT 1 FROM (SELECT namespace, external_id FROM piece_identifiers) taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'af95b69f-40b6-331c-aa51-91502d72a4d8'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'af95b69f-40b6-331c-aa51-91502d72a4d8'
FROM pieces p
WHERE p.composer_id = 28 AND p.title = '3개의 새로운 연습곡' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM (SELECT namespace, external_id FROM piece_identifiers) taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'af95b69f-40b6-331c-aa51-91502d72a4d8'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:023ab720-3d68-3bb9-ad4f-b911065f5978', 1, NULL, 'F단조', 'No. 1 in F minor', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 28 AND p.title = '3개의 새로운 연습곡' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM (SELECT piece_id, part_key FROM piece_parts) existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:023ab720-3d68-3bb9-ad4f-b911065f5978'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:9e017be2-2b7e-37b3-b7ef-e642e5f91c69', 2, NULL, 'A♭장조', 'No. 2 in A♭ major', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 28 AND p.title = '3개의 새로운 연습곡' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM (SELECT piece_id, part_key FROM piece_parts) existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:9e017be2-2b7e-37b3-b7ef-e642e5f91c69'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:4051c0e4-044d-3e15-a1b6-db0ab2c3d2f9', 3, NULL, 'D♭장조', 'No. 3 in D♭ major', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 28 AND p.title = '3개의 새로운 연습곡' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM (SELECT piece_id, part_key FROM piece_parts) existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:4051c0e4-044d-3e15-a1b6-db0ab2c3d2f9'
);


-- B. 132 가곡 "둠카"

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '가곡 "둠카"', 'Song "Dumka" (Rêverie)', 'song', 'B. 132', NULL, NULL, 1840, 'manual', 1
FROM composers c
WHERE c.id = 28
AND NOT EXISTS (
    SELECT 1 FROM (SELECT composer_id, title FROM pieces) existing
    WHERE existing.composer_id = c.id AND existing.title = '가곡 "둠카"'
)
AND NOT EXISTS (
    SELECT 1 FROM (SELECT namespace, external_id FROM piece_identifiers) taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'bc3ad36a-650b-4978-bdff-1cc6df7c5152'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'bc3ad36a-650b-4978-bdff-1cc6df7c5152'
FROM pieces p
WHERE p.composer_id = 28 AND p.title = '가곡 "둠카"' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM (SELECT namespace, external_id FROM piece_identifiers) taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'bc3ad36a-650b-4978-bdff-1cc6df7c5152'
);


-- B. 133 왈츠 18번 E♭장조 "소스테누토"

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '왈츠 18번 E♭장조 "소스테누토"', 'Waltz No. 18 in E♭ major "Sostenuto"', 'song', 'B. 133', NULL, NULL, 1840, 'manual', 1
FROM composers c
WHERE c.id = 28
AND NOT EXISTS (
    SELECT 1 FROM (SELECT composer_id, title FROM pieces) existing
    WHERE existing.composer_id = c.id AND existing.title = '왈츠 18번 E♭장조 "소스테누토"'
)
AND NOT EXISTS (
    SELECT 1 FROM (SELECT namespace, external_id FROM piece_identifiers) taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'e13a0f5e-ac3c-3c10-af36-634fe6b16e35'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'e13a0f5e-ac3c-3c10-af36-634fe6b16e35'
FROM pieces p
WHERE p.composer_id = 28 AND p.title = '왈츠 18번 E♭장조 "소스테누토"' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM (SELECT namespace, external_id FROM piece_identifiers) taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'e13a0f5e-ac3c-3c10-af36-634fe6b16e35'
);


-- B. 134 마주르카 A단조 "노트르 탕"

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '마주르카 A단조 "노트르 탕"', 'Mazurka in A minor "Notre temps"', 'song', 'B. 134', NULL, NULL, 1841, 'manual', 1
FROM composers c
WHERE c.id = 28
AND NOT EXISTS (
    SELECT 1 FROM (SELECT composer_id, title FROM pieces) existing
    WHERE existing.composer_id = c.id AND existing.title = '마주르카 A단조 "노트르 탕"'
)
AND NOT EXISTS (
    SELECT 1 FROM (SELECT namespace, external_id FROM piece_identifiers) taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'e07b52fb-b744-36e2-95d8-4d175ab8555d'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'e07b52fb-b744-36e2-95d8-4d175ab8555d'
FROM pieces p
WHERE p.composer_id = 28 AND p.title = '마주르카 A단조 "노트르 탕"' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM (SELECT namespace, external_id FROM piece_identifiers) taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'e07b52fb-b744-36e2-95d8-4d175ab8555d'
);


-- B. 140 마주르카 A단조 "에밀 가야르"

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '마주르카 A단조 "에밀 가야르"', 'Mazurka in A minor "à Émile Gaillard"', 'song', 'B. 140', NULL, NULL, 1840, 'manual', 1
FROM composers c
WHERE c.id = 28
AND NOT EXISTS (
    SELECT 1 FROM (SELECT composer_id, title FROM pieces) existing
    WHERE existing.composer_id = c.id AND existing.title = '마주르카 A단조 "에밀 가야르"'
)
AND NOT EXISTS (
    SELECT 1 FROM (SELECT namespace, external_id FROM piece_identifiers) taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'b7c39eae-e404-3065-8e10-5da55445cca1'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'b7c39eae-e404-3065-8e10-5da55445cca1'
FROM pieces p
WHERE p.composer_id = 28 AND p.title = '마주르카 A단조 "에밀 가야르"' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM (SELECT namespace, external_id FROM piece_identifiers) taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'b7c39eae-e404-3065-8e10-5da55445cca1'
);


-- B. 144 푸가 A단조

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '푸가 A단조', 'Fugue in A minor', 'song', 'B. 144', NULL, NULL, 1842, 'manual', 1
FROM composers c
WHERE c.id = 28
AND NOT EXISTS (
    SELECT 1 FROM (SELECT composer_id, title FROM pieces) existing
    WHERE existing.composer_id = c.id AND existing.title = '푸가 A단조'
)
AND NOT EXISTS (
    SELECT 1 FROM (SELECT namespace, external_id FROM piece_identifiers) taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'b4dac391-be7d-466a-9967-feca790d20a5'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'b4dac391-be7d-466a-9967-feca790d20a5'
FROM pieces p
WHERE p.composer_id = 28 AND p.title = '푸가 A단조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM (SELECT namespace, external_id FROM piece_identifiers) taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'b4dac391-be7d-466a-9967-feca790d20a5'
);


-- B. 150 왈츠 19번 A단조

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '왈츠 19번 A단조', 'Waltz No. 19 in A minor', 'song', 'B. 150', NULL, NULL, 1843, 'manual', 1
FROM composers c
WHERE c.id = 28
AND NOT EXISTS (
    SELECT 1 FROM (SELECT composer_id, title FROM pieces) existing
    WHERE existing.composer_id = c.id AND existing.title = '왈츠 19번 A단조'
)
AND NOT EXISTS (
    SELECT 1 FROM (SELECT namespace, external_id FROM piece_identifiers) taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '8792e229-86f5-3152-a79a-67664d1ee511'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '8792e229-86f5-3152-a79a-67664d1ee511'
FROM pieces p
WHERE p.composer_id = 28 AND p.title = '왈츠 19번 A단조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM (SELECT namespace, external_id FROM piece_identifiers) taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '8792e229-86f5-3152-a79a-67664d1ee511'
);


-- B. 151 앨범의 한 페이지 E장조

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '앨범의 한 페이지 E장조', 'Feuille d''album (Moderato) in E major', 'song', 'B. 151', NULL, NULL, 1843, 'manual', 1
FROM composers c
WHERE c.id = 28
AND NOT EXISTS (
    SELECT 1 FROM (SELECT composer_id, title FROM pieces) existing
    WHERE existing.composer_id = c.id AND existing.title = '앨범의 한 페이지 E장조'
)
AND NOT EXISTS (
    SELECT 1 FROM (SELECT namespace, external_id FROM piece_identifiers) taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'c0d297fa-ece6-3e3a-a39b-2618ac5befff'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'c0d297fa-ece6-3e3a-a39b-2618ac5befff'
FROM pieces p
WHERE p.composer_id = 28 AND p.title = '앨범의 한 페이지 E장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM (SELECT namespace, external_id FROM piece_identifiers) taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'c0d297fa-ece6-3e3a-a39b-2618ac5befff'
);


-- KK IVb/13 갤럽 A♭장조 "마르키"

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '갤럽 A♭장조 "마르키"', 'Galop in A♭ major "Marquis"', 'song', 'KK IVb/13', NULL, NULL, 1846, 'manual', 1
FROM composers c
WHERE c.id = 28
AND NOT EXISTS (
    SELECT 1 FROM (SELECT composer_id, title FROM pieces) existing
    WHERE existing.composer_id = c.id AND existing.title = '갤럽 A♭장조 "마르키"'
)
AND NOT EXISTS (
    SELECT 1 FROM (SELECT namespace, external_id FROM piece_identifiers) taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '640978e9-f62c-4d6f-beb4-601e1dc7089e'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '640978e9-f62c-4d6f-beb4-601e1dc7089e'
FROM pieces p
WHERE p.composer_id = 28 AND p.title = '갤럽 A♭장조 "마르키"' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM (SELECT namespace, external_id FROM piece_identifiers) taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '640978e9-f62c-4d6f-beb4-601e1dc7089e'
);

