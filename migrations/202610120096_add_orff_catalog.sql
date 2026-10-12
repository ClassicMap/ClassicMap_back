-- 오르프 작품을 MusicBrainz 작품 구조로 다시 짠다(4차 자동). 작품 13개(묶음 5, 다악장 2, 낱곡 6),
-- 새 작품 2개, part 80개, 그 아래 15개.
-- seed 62개 중 11개를 작품·part 에 잇고, 16개를 숨기고, 35개는 그대로 둔다.
--
-- 4차는 사람·에이전트 판단 없이 규칙으로 만들었다. 자료와 규칙은
-- seed_pipeline/curation/catalog-wave4-2026-10-12/(auto_catalog.py, <작곡가>/catalog.json·seed_map.json).
--   작품: MusicBrainz 에서 이 작곡가가 composer 인 work 중 다른 work 의 part 가 아니고 편곡·다른 판·
--     발췌·단편·리믹스 표시가 없는 것. part 는 MB parts 순서대로 두 겹까지.
--   제목: 「Symphony no. 5 in C minor」 꼴은 「교향곡 5번 C단조」로 옮기고, 못 읽으면 원제를 둔다
--     (MB 갈래가 가곡·오페라 등이면 「가곡 <원제>」).
--   seed 작품: MBID 가 작품이면 그 자리(제목을 위 꼴로 고치고 잠금), part 면 part 로 잇고,
--     편곡·다른 판·중복·리믹스면 hidden_reason='catalog_unmatched' 로 숨긴다(지우지 않음).
--     판단이 서지 않는 seed 는 손대지 않고 보이게 둔다. 숨길 seed 가 카탈로그 제목을 쥐고 있으면
--     그 seed 제목 뒤에 까닭을 붙여 자리를 비운다(숨긴 작품이라 목록에 안 보임).
--   manual 작품: 제목·설명·링크는 바꾸지 않는다. MBID 가 엉뚱한 work 를 가리키면(제목이 전혀 다름)
--     잇지 않고, MBID 가 없으면 영어 제목이 같은 작품에 잇는다(식별자는 더하지 않음).
--   비교 구간이 있거나 part 가 가리키는 작품은 숨기지 않는다. 두 번 돌려도 같다.

-- None Concento di voci

UPDATE pieces piece
SET piece.title = 'Concento di voci', piece.title_en = 'Concento di voci',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 10153 AND piece.composer_id = 91
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'Sirmio. Tria Catulli Carmina', part.name_en = 'Concento di voci: I. Sirmio. Tria Catulli Carmina',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 10153 AND p.composer_id = 91 AND part.part_key = 'musicbrainz:7c942b78-a75d-4e07-821f-ed070de791fa' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:7c942b78-a75d-4e07-821f-ed070de791fa', 1, 'I', 'Sirmio. Tria Catulli Carmina', 'Concento di voci: I. Sirmio. Tria Catulli Carmina', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 10153 AND p.composer_id = 91
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:7c942b78-a75d-4e07-821f-ed070de791fa'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'Laudes creaturarum', part.name_en = 'Concento di voci: II. Laudes creaturarum',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 10153 AND p.composer_id = 91 AND part.part_key = 'musicbrainz:1bf8dc94-017e-47ee-bc8d-3a1191e6e8ed' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:1bf8dc94-017e-47ee-bc8d-3a1191e6e8ed', 2, 'II', 'Laudes creaturarum', 'Concento di voci: II. Laudes creaturarum', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 10153 AND p.composer_id = 91
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:1bf8dc94-017e-47ee-bc8d-3a1191e6e8ed'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = 'Sunt lacrimae rerum', part.name_en = 'Concento di voci: III. Sunt lacrimae rerum',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 10153 AND p.composer_id = 91 AND part.part_key = 'musicbrainz:205e68a6-fb33-4d03-ac94-8be6bf09b679' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:205e68a6-fb33-4d03-ac94-8be6bf09b679', 3, 'III', 'Sunt lacrimae rerum', 'Concento di voci: III. Sunt lacrimae rerum', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 10153 AND p.composer_id = 91
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:205e68a6-fb33-4d03-ac94-8be6bf09b679'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:205e68a6-fb33-4d03-ac94-8be6bf09b679'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'Omnium deliciarum', part.name_en = 'Sunt lacrimae rerum: I. Omnium deliciarum',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 10153 AND p.composer_id = 91 AND part.part_key = 'musicbrainz:6dac7fda-75d3-47d0-8c02-7b2427a9a3c5' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:6dac7fda-75d3-47d0-8c02-7b2427a9a3c5', 1, NULL, 'Omnium deliciarum', 'Sunt lacrimae rerum: I. Omnium deliciarum', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:205e68a6-fb33-4d03-ac94-8be6bf09b679'
WHERE p.id = 10153 AND p.composer_id = 91
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:6dac7fda-75d3-47d0-8c02-7b2427a9a3c5'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:205e68a6-fb33-4d03-ac94-8be6bf09b679'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'Omnia tempus habent', part.name_en = 'Sunt lacrimae rerum: II. Omnia tempus habent',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 10153 AND p.composer_id = 91 AND part.part_key = 'musicbrainz:2bac02cd-d59c-48a4-8339-0eaf356dc7ea' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:2bac02cd-d59c-48a4-8339-0eaf356dc7ea', 2, NULL, 'Omnia tempus habent', 'Sunt lacrimae rerum: II. Omnia tempus habent', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:205e68a6-fb33-4d03-ac94-8be6bf09b679'
WHERE p.id = 10153 AND p.composer_id = 91
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:2bac02cd-d59c-48a4-8339-0eaf356dc7ea'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:205e68a6-fb33-4d03-ac94-8be6bf09b679'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = NULL,
    part.name_ko = 'Eripe nos', part.name_en = 'Sunt lacrimae rerum: III. Eripe nos',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 10153 AND p.composer_id = 91 AND part.part_key = 'musicbrainz:c7d6504f-c3de-497a-8194-a6ac66cd0263' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:c7d6504f-c3de-497a-8194-a6ac66cd0263', 3, NULL, 'Eripe nos', 'Sunt lacrimae rerum: III. Eripe nos', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:205e68a6-fb33-4d03-ac94-8be6bf09b679'
WHERE p.id = 10153 AND p.composer_id = 91
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:c7d6504f-c3de-497a-8194-a6ac66cd0263'
);


-- None 오페라 <Der Mond>

UPDATE pieces piece
SET piece.title = '오페라 <Der Mond>', piece.title_en = 'Der Mond',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 8393 AND piece.composer_id = 91
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = '"Und wann ich hamwärts geh" (Schultheiß, Bauernchor)', part.name_en = 'Der Mond: "Und wann ich hamwärts geh" (Schultheiß, Bauernchor)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 8393 AND p.composer_id = 91 AND part.part_key = 'musicbrainz:067e1ed3-746a-4ce5-b7cf-2306088fa6a0' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:067e1ed3-746a-4ce5-b7cf-2306088fa6a0', 1, NULL, '"Und wann ich hamwärts geh" (Schultheiß, Bauernchor)', 'Der Mond: "Und wann ich hamwärts geh" (Schultheiß, Bauernchor)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 8393 AND p.composer_id = 91
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:067e1ed3-746a-4ce5-b7cf-2306088fa6a0'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = '"Der Mond ist fort" (Chor, Kinderchor)', part.name_en = 'Der Mond: "Der Mond ist fort" (Chor, Kinderchor)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 8393 AND p.composer_id = 91 AND part.part_key = 'musicbrainz:06ddd5bc-81fd-4348-9b61-435a364bfbea' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:06ddd5bc-81fd-4348-9b61-435a364bfbea', 2, NULL, '"Der Mond ist fort" (Chor, Kinderchor)', 'Der Mond: "Der Mond ist fort" (Chor, Kinderchor)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 8393 AND p.composer_id = 91
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:06ddd5bc-81fd-4348-9b61-435a364bfbea'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = NULL,
    part.name_ko = '"So brachte Petrus die Toten zur Ruh" (Erzähler)', part.name_en = 'Der Mond: "So brachte Petrus die Toten zur Ruh" (Erzähler)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 8393 AND p.composer_id = 91 AND part.part_key = 'musicbrainz:0d2b6ad7-1bd0-44a0-a9e5-47f19ea016ef' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:0d2b6ad7-1bd0-44a0-a9e5-47f19ea016ef', 3, NULL, '"So brachte Petrus die Toten zur Ruh" (Erzähler)', 'Der Mond: "So brachte Petrus die Toten zur Ruh" (Erzähler)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 8393 AND p.composer_id = 91
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:0d2b6ad7-1bd0-44a0-a9e5-47f19ea016ef'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = NULL,
    part.name_ko = '"Lieg'' ich hier an dieser Schwelle" (Erster Bursche, Chor, Wirt)', part.name_en = 'Der Mond: "Lieg'' ich hier an dieser Schwelle" (Erster Bursche, Chor, Wirt)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 8393 AND p.composer_id = 91 AND part.part_key = 'musicbrainz:1228d36c-d635-480d-b7cb-65b1523ee68d' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:1228d36c-d635-480d-b7cb-65b1523ee68d', 4, NULL, '"Lieg'' ich hier an dieser Schwelle" (Erster Bursche, Chor, Wirt)', 'Der Mond: "Lieg'' ich hier an dieser Schwelle" (Erster Bursche, Chor, Wirt)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 8393 AND p.composer_id = 91
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:1228d36c-d635-480d-b7cb-65b1523ee68d'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 5, part.movement_number = NULL,
    part.name_ko = '"Sitz ich da am hohen Himmel" (Petrus, Chor de Toten)', part.name_en = 'Der Mond: "Sitz ich da am hohen Himmel" (Petrus, Chor de Toten)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 8393 AND p.composer_id = 91 AND part.part_key = 'musicbrainz:272c4b9c-3d3f-4cce-a474-9867d7288d04' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:272c4b9c-3d3f-4cce-a474-9867d7288d04', 5, NULL, '"Sitz ich da am hohen Himmel" (Petrus, Chor de Toten)', 'Der Mond: "Sitz ich da am hohen Himmel" (Petrus, Chor de Toten)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 8393 AND p.composer_id = 91
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:272c4b9c-3d3f-4cce-a474-9867d7288d04'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 6, part.movement_number = NULL,
    part.name_ko = 'Tanz der Bauern in der Schenke', part.name_en = 'Der Mond: Tanz der Bauern in der Schenke',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 8393 AND p.composer_id = 91 AND part.part_key = 'musicbrainz:3473f113-3132-455f-898b-52eff7f801dc' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:3473f113-3132-455f-898b-52eff7f801dc', 6, NULL, 'Tanz der Bauern in der Schenke', 'Der Mond: Tanz der Bauern in der Schenke', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 8393 AND p.composer_id = 91
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:3473f113-3132-455f-898b-52eff7f801dc'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 7, part.movement_number = NULL,
    part.name_ko = '"Vorzeiten gab es ein Land" (Erzähler)', part.name_en = 'Der Mond: "Vorzeiten gab es ein Land" (Erzähler)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 8393 AND p.composer_id = 91 AND part.part_key = 'musicbrainz:3610ad6e-4870-4cbd-bd55-6882212b12b6' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:3610ad6e-4870-4cbd-bd55-6882212b12b6', 7, NULL, '"Vorzeiten gab es ein Land" (Erzähler)', 'Der Mond: "Vorzeiten gab es ein Land" (Erzähler)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 8393 AND p.composer_id = 91
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:3610ad6e-4870-4cbd-bd55-6882212b12b6'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 8, part.movement_number = NULL,
    part.name_ko = '"Und als der ''Erste'' gestorben war" (Erzähler)', part.name_en = 'Der Mond: "Und als der ''Erste'' gestorben war" (Erzähler)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 8393 AND p.composer_id = 91 AND part.part_key = 'musicbrainz:37e231b8-6d04-4654-8eb1-fe54c38626d1' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:37e231b8-6d04-4654-8eb1-fe54c38626d1', 8, NULL, '"Und als der ''Erste'' gestorben war" (Erzähler)', 'Der Mond: "Und als der ''Erste'' gestorben war" (Erzähler)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 8393 AND p.composer_id = 91
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:37e231b8-6d04-4654-8eb1-fe54c38626d1'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 9, part.movement_number = NULL,
    part.name_ko = '"Alle, die wir ringsum stehn" (Chor)', part.name_en = 'Der Mond: "Alle, die wir ringsum stehn" (Chor)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 8393 AND p.composer_id = 91 AND part.part_key = 'musicbrainz:3ac6fc72-86b1-4374-9a0e-859740d7bfb8' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:3ac6fc72-86b1-4374-9a0e-859740d7bfb8', 9, NULL, '"Alle, die wir ringsum stehn" (Chor)', 'Der Mond: "Alle, die wir ringsum stehn" (Chor)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 8393 AND p.composer_id = 91
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:3ac6fc72-86b1-4374-9a0e-859740d7bfb8'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 10, part.movement_number = NULL,
    part.name_ko = 'Zwischenspiel', part.name_en = 'Der Mond: Zwischenspiel',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 8393 AND p.composer_id = 91 AND part.part_key = 'musicbrainz:3bacb726-11e5-4193-945f-b9221cfe9e7a' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:3bacb726-11e5-4193-945f-b9221cfe9e7a', 10, NULL, 'Zwischenspiel', 'Der Mond: Zwischenspiel', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 8393 AND p.composer_id = 91
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:3bacb726-11e5-4193-945f-b9221cfe9e7a'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 11, part.movement_number = NULL,
    part.name_ko = 'Ah, da hängt ja der Mond!', part.name_en = 'Der Mond: Ah, da hängt ja der Mond!',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 8393 AND p.composer_id = 91 AND part.part_key = 'musicbrainz:41329e3a-ad10-4b88-a601-6c50f953da11' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:41329e3a-ad10-4b88-a601-6c50f953da11', 11, NULL, 'Ah, da hängt ja der Mond!', 'Der Mond: Ah, da hängt ja der Mond!', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 8393 AND p.composer_id = 91
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:41329e3a-ad10-4b88-a601-6c50f953da11'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 12, part.movement_number = NULL,
    part.name_ko = '"Wie kalt ist''s draußen in der Welt" (Petrus)', part.name_en = 'Der Mond: "Wie kalt ist''s draußen in der Welt" (Petrus)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 8393 AND p.composer_id = 91 AND part.part_key = 'musicbrainz:48baf895-96b9-45a4-a888-39006ea460c6' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:48baf895-96b9-45a4-a888-39006ea460c6', 12, NULL, '"Wie kalt ist''s draußen in der Welt" (Petrus)', 'Der Mond: "Wie kalt ist''s draußen in der Welt" (Petrus)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 8393 AND p.composer_id = 91
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:48baf895-96b9-45a4-a888-39006ea460c6'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 13, part.movement_number = NULL,
    part.name_ko = 'Magischer Zauber', part.name_en = 'Der Mond: Magischer Zauber',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 8393 AND p.composer_id = 91 AND part.part_key = 'musicbrainz:49a75a72-13f3-4192-a85c-322dc099e5d3' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:49a75a72-13f3-4192-a85c-322dc099e5d3', 13, NULL, 'Magischer Zauber', 'Der Mond: Magischer Zauber', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 8393 AND p.composer_id = 91
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:49a75a72-13f3-4192-a85c-322dc099e5d3'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 14, part.movement_number = NULL,
    part.name_ko = '"Seht den Mond" (Chor, Vier Burschen)', part.name_en = 'Der Mond: "Seht den Mond" (Chor, Vier Burschen)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 8393 AND p.composer_id = 91 AND part.part_key = 'musicbrainz:52905444-bc91-4e3b-b541-a1132dd2c4b6' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:52905444-bc91-4e3b-b541-a1132dd2c4b6', 14, NULL, '"Seht den Mond" (Chor, Vier Burschen)', 'Der Mond: "Seht den Mond" (Chor, Vier Burschen)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 8393 AND p.composer_id = 91
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:52905444-bc91-4e3b-b541-a1132dd2c4b6'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 15, part.movement_number = NULL,
    part.name_ko = '"Du spielst, als lägst du noch im Grab" (Kartenspieler, Würfler, Kegler, Säufer)', part.name_en = 'Der Mond: "Du spielst, als lägst du noch im Grab" (Kartenspieler, Würfler, Kegler, Säufer)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 8393 AND p.composer_id = 91 AND part.part_key = 'musicbrainz:5841ff7f-8aee-4209-a3bf-db61f7efb19f' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:5841ff7f-8aee-4209-a3bf-db61f7efb19f', 15, NULL, '"Du spielst, als lägst du noch im Grab" (Kartenspieler, Würfler, Kegler, Säufer)', 'Der Mond: "Du spielst, als lägst du noch im Grab" (Kartenspieler, Würfler, Kegler, Säufer)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 8393 AND p.composer_id = 91
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:5841ff7f-8aee-4209-a3bf-db61f7efb19f'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 16, part.movement_number = NULL,
    part.name_ko = '"Und sie brachten den Geraubten" (Erzähler)', part.name_en = 'Der Mond: "Und sie brachten den Geraubten" (Erzähler)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 8393 AND p.composer_id = 91 AND part.part_key = 'musicbrainz:5b9f13ff-9328-4b7d-8946-ce6fd9dc3311' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:5b9f13ff-9328-4b7d-8946-ce6fd9dc3311', 16, NULL, '"Und sie brachten den Geraubten" (Erzähler)', 'Der Mond: "Und sie brachten den Geraubten" (Erzähler)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 8393 AND p.composer_id = 91
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:5b9f13ff-9328-4b7d-8946-ce6fd9dc3311'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 17, part.movement_number = NULL,
    part.name_ko = '"Was ist das für ein Licht?" (Vier Burschen, Bauer)', part.name_en = 'Der Mond: "Was ist das für ein Licht?" (Vier Burschen, Bauer)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 8393 AND p.composer_id = 91 AND part.part_key = 'musicbrainz:612151af-d2fc-4b86-b52a-f7cc9dcb5082' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:612151af-d2fc-4b86-b52a-f7cc9dcb5082', 17, NULL, '"Was ist das für ein Licht?" (Vier Burschen, Bauer)', 'Der Mond: "Was ist das für ein Licht?" (Vier Burschen, Bauer)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 8393 AND p.composer_id = 91
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:612151af-d2fc-4b86-b52a-f7cc9dcb5082'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 18, part.movement_number = NULL,
    part.name_ko = 'Phantastische Nacht', part.name_en = 'Der Mond: Phantastische Nacht',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 8393 AND p.composer_id = 91 AND part.part_key = 'musicbrainz:67ae3f15-0db8-418b-964b-e46edf261fa8' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:67ae3f15-0db8-418b-964b-e46edf261fa8', 18, NULL, 'Phantastische Nacht', 'Der Mond: Phantastische Nacht', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 8393 AND p.composer_id = 91
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:67ae3f15-0db8-418b-964b-e46edf261fa8'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 19, part.movement_number = NULL,
    part.name_ko = 'Petrus / Ensemble', part.name_en = 'Der Mond: Petrus / Ensemble',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 8393 AND p.composer_id = 91 AND part.part_key = 'musicbrainz:74b6e1c4-8053-4df6-a874-c65591d4b85a' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:74b6e1c4-8053-4df6-a874-c65591d4b85a', 19, NULL, 'Petrus / Ensemble', 'Der Mond: Petrus / Ensemble', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 8393 AND p.composer_id = 91
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:74b6e1c4-8053-4df6-a874-c65591d4b85a'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 20, part.movement_number = NULL,
    part.name_ko = '"So hängt ihn auf" (Wirt)', part.name_en = 'Der Mond: "So hängt ihn auf" (Wirt)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 8393 AND p.composer_id = 91 AND part.part_key = 'musicbrainz:79409131-ea1c-4efc-bac9-fd5efaceecba' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:79409131-ea1c-4efc-bac9-fd5efaceecba', 20, NULL, '"So hängt ihn auf" (Wirt)', 'Der Mond: "So hängt ihn auf" (Wirt)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 8393 AND p.composer_id = 91
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:79409131-ea1c-4efc-bac9-fd5efaceecba'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 21, part.movement_number = NULL,
    part.name_ko = '"Die Vier versorgten den Mond mit Öl" (Erzähler)', part.name_en = 'Der Mond: "Die Vier versorgten den Mond mit Öl" (Erzähler)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 8393 AND p.composer_id = 91 AND part.part_key = 'musicbrainz:8202889c-875b-4781-90ce-6898597e5379' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:8202889c-875b-4781-90ce-6898597e5379', 21, NULL, '"Die Vier versorgten den Mond mit Öl" (Erzähler)', 'Der Mond: "Die Vier versorgten den Mond mit Öl" (Erzähler)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 8393 AND p.composer_id = 91
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:8202889c-875b-4781-90ce-6898597e5379'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 22, part.movement_number = NULL,
    part.name_ko = '"Wirt, Leute kommen!" (Bauer, Wirt, Bauern und Weiber, Vier Burschen)', part.name_en = 'Der Mond: "Wirt, Leute kommen!" (Bauer, Wirt, Bauern und Weiber, Vier Burschen)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 8393 AND p.composer_id = 91 AND part.part_key = 'musicbrainz:94ee476c-8c81-4918-ac3a-eb372b9ad02e' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:94ee476c-8c81-4918-ac3a-eb372b9ad02e', 22, NULL, '"Wirt, Leute kommen!" (Bauer, Wirt, Bauern und Weiber, Vier Burschen)', 'Der Mond: "Wirt, Leute kommen!" (Bauer, Wirt, Bauern und Weiber, Vier Burschen)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 8393 AND p.composer_id = 91
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:94ee476c-8c81-4918-ac3a-eb372b9ad02e'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 23, part.movement_number = NULL,
    part.name_ko = '"Und als der Mond dort leuchtete" (Erzähler, Chor, Vier Burschen)', part.name_en = 'Der Mond: "Und als der Mond dort leuchtete" (Erzähler, Chor, Vier Burschen)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 8393 AND p.composer_id = 91 AND part.part_key = 'musicbrainz:9bae2299-0d56-4303-958b-86d0d811b4df' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:9bae2299-0d56-4303-958b-86d0d811b4df', 23, NULL, '"Und als der Mond dort leuchtete" (Erzähler, Chor, Vier Burschen)', 'Der Mond: "Und als der Mond dort leuchtete" (Erzähler, Chor, Vier Burschen)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 8393 AND p.composer_id = 91
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:9bae2299-0d56-4303-958b-86d0d811b4df'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 24, part.movement_number = NULL,
    part.name_ko = 'Was ist denn das? Was ist das für ein Licht?', part.name_en = 'Der Mond: Was ist denn das? Was ist das für ein Licht?',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 8393 AND p.composer_id = 91 AND part.part_key = 'musicbrainz:aa0e7230-9cef-4233-a541-3cbe17b23c07' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:aa0e7230-9cef-4233-a541-3cbe17b23c07', 24, NULL, 'Was ist denn das? Was ist das für ein Licht?', 'Der Mond: Was ist denn das? Was ist das für ein Licht?', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 8393 AND p.composer_id = 91
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:aa0e7230-9cef-4233-a541-3cbe17b23c07'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 25, part.movement_number = NULL,
    part.name_ko = '"Was ist da los?" (Petrus, Chor, Vier Burschen)', part.name_en = 'Der Mond: "Was ist da los?" (Petrus, Chor, Vier Burschen)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 8393 AND p.composer_id = 91 AND part.part_key = 'musicbrainz:be9b96fa-aea5-4149-801e-660d4db68ca2' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:be9b96fa-aea5-4149-801e-660d4db68ca2', 25, NULL, '"Was ist da los?" (Petrus, Chor, Vier Burschen)', 'Der Mond: "Was ist da los?" (Petrus, Chor, Vier Burschen)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 8393 AND p.composer_id = 91
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:be9b96fa-aea5-4149-801e-660d4db68ca2'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 26, part.movement_number = NULL,
    part.name_ko = '"Floret silva undique" (Chor, Mädel, Vier Burschen)', part.name_en = 'Der Mond: "Floret silva undique" (Chor, Mädel, Vier Burschen)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 8393 AND p.composer_id = 91 AND part.part_key = 'musicbrainz:cf0b6cfa-53b4-4167-8c5c-e1535eb68279' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:cf0b6cfa-53b4-4167-8c5c-e1535eb68279', 26, NULL, '"Floret silva undique" (Chor, Mädel, Vier Burschen)', 'Der Mond: "Floret silva undique" (Chor, Mädel, Vier Burschen)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 8393 AND p.composer_id = 91
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:cf0b6cfa-53b4-4167-8c5c-e1535eb68279'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 27, part.movement_number = NULL,
    part.name_ko = '"Ach, da hängt ja der Mond!" (Kleines Kind, Chor)', part.name_en = 'Der Mond: "Ach, da hängt ja der Mond!" (Kleines Kind, Chor)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 8393 AND p.composer_id = 91 AND part.part_key = 'musicbrainz:d10313b4-ca39-4e22-ac0d-5d7d479c6c93' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:d10313b4-ca39-4e22-ac0d-5d7d479c6c93', 27, NULL, '"Ach, da hängt ja der Mond!" (Kleines Kind, Chor)', 'Der Mond: "Ach, da hängt ja der Mond!" (Kleines Kind, Chor)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 8393 AND p.composer_id = 91
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:d10313b4-ca39-4e22-ac0d-5d7d479c6c93'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 28, part.movement_number = NULL,
    part.name_ko = '"Wenn ihr nachts aus der Taberne" (Vier Burschen, Chor, Wirt)', part.name_en = 'Der Mond: "Wenn ihr nachts aus der Taberne" (Vier Burschen, Chor, Wirt)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 8393 AND p.composer_id = 91 AND part.part_key = 'musicbrainz:ec2cedef-80da-4a63-bc1d-e3618cfbb227' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:ec2cedef-80da-4a63-bc1d-e3618cfbb227', 28, NULL, '"Wenn ihr nachts aus der Taberne" (Vier Burschen, Chor, Wirt)', 'Der Mond: "Wenn ihr nachts aus der Taberne" (Vier Burschen, Chor, Wirt)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 8393 AND p.composer_id = 91
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:ec2cedef-80da-4a63-bc1d-e3618cfbb227'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 29, part.movement_number = NULL,
    part.name_ko = 'Hört, ihr Toten, lasst euch sagen', part.name_en = 'Der Mond: Hört, ihr Toten, lasst euch sagen',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 8393 AND p.composer_id = 91 AND part.part_key = 'musicbrainz:ecfa8329-ca8a-4983-aa91-f2cf99294fd8' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:ecfa8329-ca8a-4983-aa91-f2cf99294fd8', 29, NULL, 'Hört, ihr Toten, lasst euch sagen', 'Der Mond: Hört, ihr Toten, lasst euch sagen', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 8393 AND p.composer_id = 91
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:ecfa8329-ca8a-4983-aa91-f2cf99294fd8'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 30, part.movement_number = NULL,
    part.name_ko = 'Erzähler, Chor der Toten, vier Burschen', part.name_en = 'Der Mond: Erzähler, Chor der Toten, vier Burschen',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 8393 AND p.composer_id = 91 AND part.part_key = 'musicbrainz:f20d40ab-75bb-4b32-8304-3b24804190c3' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:f20d40ab-75bb-4b32-8304-3b24804190c3', 30, NULL, 'Erzähler, Chor der Toten, vier Burschen', 'Der Mond: Erzähler, Chor der Toten, vier Burschen', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 8393 AND p.composer_id = 91
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:f20d40ab-75bb-4b32-8304-3b24804190c3'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 31, part.movement_number = NULL,
    part.name_ko = 'Tanz der Toten', part.name_en = 'Der Mond: Tanz der Toten',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 8393 AND p.composer_id = 91 AND part.part_key = 'musicbrainz:f9f2e704-8b9a-43c2-8c7e-466856102a67' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:f9f2e704-8b9a-43c2-8c7e-466856102a67', 31, NULL, 'Tanz der Toten', 'Der Mond: Tanz der Toten', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 8393 AND p.composer_id = 91
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:f9f2e704-8b9a-43c2-8c7e-466856102a67'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 32, part.movement_number = NULL,
    part.name_ko = '"Der Wein ist gut" (Petrus, Chor, Vier Burschen)', part.name_en = 'Der Mond: "Der Wein ist gut" (Petrus, Chor, Vier Burschen)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 8393 AND p.composer_id = 91 AND part.part_key = 'musicbrainz:ff20c3a7-16d2-4610-a654-f1637eb2949c' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:ff20c3a7-16d2-4610-a654-f1637eb2949c', 32, NULL, '"Der Wein ist gut" (Petrus, Chor, Vier Burschen)', 'Der Mond: "Der Wein ist gut" (Petrus, Chor, Vier Burschen)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 8393 AND p.composer_id = 91
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:ff20c3a7-16d2-4610-a654-f1637eb2949c'
);


-- None 가곡 <Der gute Mensch>

UPDATE pieces piece
SET piece.title = '가곡 <Der gute Mensch>', piece.title_en = 'Der gute Mensch',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 10317 AND piece.composer_id = 91
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None 오페라 <Die Kluge>

UPDATE pieces piece
SET piece.title = '오페라 <Die Kluge>', piece.title_en = 'Die Kluge',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 8426 AND piece.composer_id = 91
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'Szene. "Was schreit der Mann? Ich will es wissen!" (König, Kerkermeister, Bauer)', part.name_en = 'Die Kluge: 1. Szene. "Was schreit der Mann? Ich will es wissen!" (König, Kerkermeister, Bauer)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 8426 AND p.composer_id = 91 AND part.part_key = 'musicbrainz:08b7c002-48f4-43cb-875b-ea850c39f0bd' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:08b7c002-48f4-43cb-875b-ea850c39f0bd', 1, NULL, 'Szene. "Was schreit der Mann? Ich will es wissen!" (König, Kerkermeister, Bauer)', 'Die Kluge: 1. Szene. "Was schreit der Mann? Ich will es wissen!" (König, Kerkermeister, Bauer)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 8426 AND p.composer_id = 91
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:08b7c002-48f4-43cb-875b-ea850c39f0bd'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'Szene. "Ein König kann sich auch mal irren" (Kluge, Eselmann)', part.name_en = 'Die Kluge: 6. Szene. "Ein König kann sich auch mal irren" (Kluge, Eselmann)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 8426 AND p.composer_id = 91 AND part.part_key = 'musicbrainz:0fcfba46-6a6f-4743-98f4-7b3dcc60219f' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:0fcfba46-6a6f-4743-98f4-7b3dcc60219f', 2, NULL, 'Szene. "Ein König kann sich auch mal irren" (Kluge, Eselmann)', 'Die Kluge: 6. Szene. "Ein König kann sich auch mal irren" (Kluge, Eselmann)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 8426 AND p.composer_id = 91
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:0fcfba46-6a6f-4743-98f4-7b3dcc60219f'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = NULL,
    part.name_ko = 'Szene. "Komm da heraus, der König läßt dich frei" (Kerkermeister, Eselmann)', part.name_en = 'Die Kluge: 11. Szene. "Komm da heraus, der König läßt dich frei" (Kerkermeister, Eselmann)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 8426 AND p.composer_id = 91 AND part.part_key = 'musicbrainz:244954e4-3cf3-4bfa-926e-0e4ce3da8354' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:244954e4-3cf3-4bfa-926e-0e4ce3da8354', 3, NULL, 'Szene. "Komm da heraus, der König läßt dich frei" (Kerkermeister, Eselmann)', 'Die Kluge: 11. Szene. "Komm da heraus, der König läßt dich frei" (Kerkermeister, Eselmann)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 8426 AND p.composer_id = 91
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:244954e4-3cf3-4bfa-926e-0e4ce3da8354'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = NULL,
    part.name_ko = 'Szene. Vorspiel', part.name_en = 'Die Kluge: 12. Szene. Vorspiel',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 8426 AND p.composer_id = 91 AND part.part_key = 'musicbrainz:330c42ad-b064-4f17-b9c7-ff45ec5555e6' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:330c42ad-b064-4f17-b9c7-ff45ec5555e6', 4, NULL, 'Szene. Vorspiel', 'Die Kluge: 12. Szene. Vorspiel', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 8426 AND p.composer_id = 91
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:330c42ad-b064-4f17-b9c7-ff45ec5555e6'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 5, part.movement_number = NULL,
    part.name_ko = 'Szene. "Schuh-schuhu, es fallen dem König die Augen zu" (Kluge)', part.name_en = 'Die Kluge: 9. Szene. "Schuh-schuhu, es fallen dem König die Augen zu" (Kluge)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 8426 AND p.composer_id = 91 AND part.part_key = 'musicbrainz:3ebc546d-8d42-4967-8926-549a225c4885' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:3ebc546d-8d42-4967-8926-549a225c4885', 5, NULL, 'Szene. "Schuh-schuhu, es fallen dem König die Augen zu" (Kluge)', 'Die Kluge: 9. Szene. "Schuh-schuhu, es fallen dem König die Augen zu" (Kluge)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 8426 AND p.composer_id = 91
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:3ebc546d-8d42-4967-8926-549a225c4885'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 6, part.movement_number = NULL,
    part.name_ko = 'Szene. "Spaß muß sein, sagte die Katze zum Vogel und fraß ihn" (Erster, Zweiter und Dritter Strolch)', part.name_en = 'Die Kluge: 2. Szene. "Spaß muß sein, sagte die Katze zum Vogel und fraß ihn" (Erster, Zweiter und Dritter Strolch)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 8426 AND p.composer_id = 91 AND part.part_key = 'musicbrainz:44bf4854-7d79-43d2-8cdf-e448cc3484c0' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:44bf4854-7d79-43d2-8cdf-e448cc3484c0', 6, NULL, 'Szene. "Spaß muß sein, sagte die Katze zum Vogel und fraß ihn" (Erster, Zweiter und Dritter Strolch)', 'Die Kluge: 2. Szene. "Spaß muß sein, sagte die Katze zum Vogel und fraß ihn" (Erster, Zweiter und Dritter Strolch)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 8426 AND p.composer_id = 91
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:44bf4854-7d79-43d2-8cdf-e448cc3484c0'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 7, part.movement_number = NULL,
    part.name_ko = 'Szene. "Der König hat nun wieder eine Frau" (Erster, Zweiter und Dritter Strolch, Mauleselmann, Eselmann)', part.name_en = 'Die Kluge: 4. Szene. "Der König hat nun wieder eine Frau" (Erster, Zweiter und Dritter Strolch, Mauleselmann, Eselmann)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 8426 AND p.composer_id = 91 AND part.part_key = 'musicbrainz:463aeea7-17a8-49e5-b6af-bb444d251092' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:463aeea7-17a8-49e5-b6af-bb444d251092', 7, NULL, 'Szene. "Der König hat nun wieder eine Frau" (Erster, Zweiter und Dritter Strolch, Mauleselmann, Eselmann)', 'Die Kluge: 4. Szene. "Der König hat nun wieder eine Frau" (Erster, Zweiter und Dritter Strolch, Mauleselmann, Eselmann)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 8426 AND p.composer_id = 91
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:463aeea7-17a8-49e5-b6af-bb444d251092'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 8, part.movement_number = NULL,
    part.name_ko = 'Szene. "Frag diesen Mann, was er da schafft" (König, Kerkermeister, Eselmann, Erster, Zweiter und Dritter Strolch)', part.name_en = 'Die Kluge: 8. Szene. "Frag diesen Mann, was er da schafft" (König, Kerkermeister, Eselmann, Erster, Zweiter und Dritter Strolch)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 8426 AND p.composer_id = 91 AND part.part_key = 'musicbrainz:4774acb1-4994-410e-a809-4bce78a7490c' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:4774acb1-4994-410e-a809-4bce78a7490c', 8, NULL, 'Szene. "Frag diesen Mann, was er da schafft" (König, Kerkermeister, Eselmann, Erster, Zweiter und Dritter Strolch)', 'Die Kluge: 8. Szene. "Frag diesen Mann, was er da schafft" (König, Kerkermeister, Eselmann, Erster, Zweiter und Dritter Strolch)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 8426 AND p.composer_id = 91
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:4774acb1-4994-410e-a809-4bce78a7490c'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 9, part.movement_number = NULL,
    part.name_ko = 'Szene. "Die Rede stammet nit von dir..." (König, Eselmann, Erster, Zweiter und Dritter Strolch)', part.name_en = 'Die Kluge: 8. Szene. "Die Rede stammet nit von dir..." (König, Eselmann, Erster, Zweiter und Dritter Strolch)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 8426 AND p.composer_id = 91 AND part.part_key = 'musicbrainz:52eb2095-76a1-4386-aaff-1bb72d308643' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:52eb2095-76a1-4386-aaff-1bb72d308643', 9, NULL, 'Szene. "Die Rede stammet nit von dir..." (König, Eselmann, Erster, Zweiter und Dritter Strolch)', 'Die Kluge: 8. Szene. "Die Rede stammet nit von dir..." (König, Eselmann, Erster, Zweiter und Dritter Strolch)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 8426 AND p.composer_id = 91
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:52eb2095-76a1-4386-aaff-1bb72d308643'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 10, part.movement_number = NULL,
    part.name_ko = 'Szene. "Nenn mir die Rätsel, König" (Kluge, König)', part.name_en = 'Die Kluge: 3. Szene. "Nenn mir die Rätsel, König" (Kluge, König)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 8426 AND p.composer_id = 91 AND part.part_key = 'musicbrainz:619174d2-be63-4df5-8b4b-b24a197b07df' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:619174d2-be63-4df5-8b4b-b24a197b07df', 10, NULL, 'Szene. "Nenn mir die Rätsel, König" (Kluge, König)', 'Die Kluge: 3. Szene. "Nenn mir die Rätsel, König" (Kluge, König)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 8426 AND p.composer_id = 91
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:619174d2-be63-4df5-8b4b-b24a197b07df'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 11, part.movement_number = NULL,
    part.name_ko = 'Szene. "Weh mir, wie konnt mir das geschehn?" (Eselmann)', part.name_en = 'Die Kluge: 6. Szene. "Weh mir, wie konnt mir das geschehn?" (Eselmann)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 8426 AND p.composer_id = 91 AND part.part_key = 'musicbrainz:6bcb6a2a-82c5-4ed0-b4d4-ad72830b13b4' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:6bcb6a2a-82c5-4ed0-b4d4-ad72830b13b4', 11, NULL, 'Szene. "Weh mir, wie konnt mir das geschehn?" (Eselmann)', 'Die Kluge: 6. Szene. "Weh mir, wie konnt mir das geschehn?" (Eselmann)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 8426 AND p.composer_id = 91
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:6bcb6a2a-82c5-4ed0-b4d4-ad72830b13b4'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 12, part.movement_number = NULL,
    part.name_ko = 'Szene. "Was ist, wo bin ich" (König, Kluge, Bauer)', part.name_en = 'Die Kluge: 12. Szene. "Was ist, wo bin ich" (König, Kluge, Bauer)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 8426 AND p.composer_id = 91 AND part.part_key = 'musicbrainz:6e788b7f-0074-4c45-b8e2-02b5210fdcb4' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:6e788b7f-0074-4c45-b8e2-02b5210fdcb4', 12, NULL, 'Szene. "Was ist, wo bin ich" (König, Kluge, Bauer)', 'Die Kluge: 12. Szene. "Was ist, wo bin ich" (König, Kluge, Bauer)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 8426 AND p.composer_id = 91
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:6e788b7f-0074-4c45-b8e2-02b5210fdcb4'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 13, part.movement_number = NULL,
    part.name_ko = 'Szene. "Du also, du bist die Kluge" (König)', part.name_en = 'Die Kluge: 3. Szene. "Du also, du bist die Kluge" (König)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 8426 AND p.composer_id = 91 AND part.part_key = 'musicbrainz:70570f65-8776-4f88-b2de-7f8ec5d6e679' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:70570f65-8776-4f88-b2de-7f8ec5d6e679', 13, NULL, 'Szene. "Du also, du bist die Kluge" (König)', 'Die Kluge: 3. Szene. "Du also, du bist die Kluge" (König)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 8426 AND p.composer_id = 91
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:70570f65-8776-4f88-b2de-7f8ec5d6e679'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 14, part.movement_number = NULL,
    part.name_ko = 'Szene. "Als die Treue ward geborn" (Erster, Zweiter und Dritter Strolch)', part.name_en = 'Die Kluge: 7. Szene. "Als die Treue ward geborn" (Erster, Zweiter und Dritter Strolch)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 8426 AND p.composer_id = 91 AND part.part_key = 'musicbrainz:93332d55-e632-4590-88aa-3cc208d497f1' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:93332d55-e632-4590-88aa-3cc208d497f1', 14, NULL, 'Szene. "Als die Treue ward geborn" (Erster, Zweiter und Dritter Strolch)', 'Die Kluge: 7. Szene. "Als die Treue ward geborn" (Erster, Zweiter und Dritter Strolch)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 8426 AND p.composer_id = 91
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:93332d55-e632-4590-88aa-3cc208d497f1'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 15, part.movement_number = NULL,
    part.name_ko = 'Szene. "Laß mich die Tafel dir bereiten" (Kluge)', part.name_en = 'Die Kluge: 9. Szene. "Laß mich die Tafel dir bereiten" (Kluge)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 8426 AND p.composer_id = 91 AND part.part_key = 'musicbrainz:a1af8454-56c6-4c1c-b2ec-35fa09aebbeb' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:a1af8454-56c6-4c1c-b2ec-35fa09aebbeb', 15, NULL, 'Szene. "Laß mich die Tafel dir bereiten" (Kluge)', 'Die Kluge: 9. Szene. "Laß mich die Tafel dir bereiten" (Kluge)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 8426 AND p.composer_id = 91
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:a1af8454-56c6-4c1c-b2ec-35fa09aebbeb'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 16, part.movement_number = NULL,
    part.name_ko = 'Szene. "Heda!" (Erster, Zweiter und Dritter Strolch, Kerkermeister)', part.name_en = 'Die Kluge: 7. Szene. "Heda!" (Erster, Zweiter und Dritter Strolch, Kerkermeister)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 8426 AND p.composer_id = 91 AND part.part_key = 'musicbrainz:a205b627-f131-478f-9859-4c0663a00afa' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:a205b627-f131-478f-9859-4c0663a00afa', 16, NULL, 'Szene. "Heda!" (Erster, Zweiter und Dritter Strolch, Kerkermeister)', 'Die Kluge: 7. Szene. "Heda!" (Erster, Zweiter und Dritter Strolch, Kerkermeister)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 8426 AND p.composer_id = 91
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:a205b627-f131-478f-9859-4c0663a00afa'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 17, part.movement_number = NULL,
    part.name_ko = 'Szene. "Hab ich euch endlich" (Erster, Zweiter und Dritter Strolch)', part.name_en = 'Die Kluge: 10. Szene. "Hab ich euch endlich" (Erster, Zweiter und Dritter Strolch)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 8426 AND p.composer_id = 91 AND part.part_key = 'musicbrainz:ed1f3d91-ab11-4b29-8442-4bdcc451905d' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:ed1f3d91-ab11-4b29-8442-4bdcc451905d', 17, NULL, 'Szene. "Hab ich euch endlich" (Erster, Zweiter und Dritter Strolch)', 'Die Kluge: 10. Szene. "Hab ich euch endlich" (Erster, Zweiter und Dritter Strolch)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 8426 AND p.composer_id = 91
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:ed1f3d91-ab11-4b29-8442-4bdcc451905d'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 18, part.movement_number = NULL,
    part.name_ko = 'Szene. "So also, so war''s gemeint!" (König)', part.name_en = 'Die Kluge: 9. Szene. "So also, so war''s gemeint!" (König)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 8426 AND p.composer_id = 91 AND part.part_key = 'musicbrainz:f119d955-50d6-4249-a0b1-c81d92de896e' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:f119d955-50d6-4249-a0b1-c81d92de896e', 18, NULL, 'Szene. "So also, so war''s gemeint!" (König)', 'Die Kluge: 9. Szene. "So also, so war''s gemeint!" (König)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 8426 AND p.composer_id = 91
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:f119d955-50d6-4249-a0b1-c81d92de896e'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 19, part.movement_number = NULL,
    part.name_ko = 'Szene. "Alles ging die Kreuz und Quer" (Mauleselmann, Erster, Zweiter und Dritter Strolch, König, Kerkermeister)', part.name_en = 'Die Kluge: 5. Szene. "Alles ging die Kreuz und Quer" (Mauleselmann, Erster, Zweiter und Dritter Strolch, König, Kerkermeister)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 8426 AND p.composer_id = 91 AND part.part_key = 'musicbrainz:f4f006f6-e5d0-444a-bad7-5fd7a8ac31c5' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:f4f006f6-e5d0-444a-bad7-5fd7a8ac31c5', 19, NULL, 'Szene. "Alles ging die Kreuz und Quer" (Mauleselmann, Erster, Zweiter und Dritter Strolch, König, Kerkermeister)', 'Die Kluge: 5. Szene. "Alles ging die Kreuz und Quer" (Mauleselmann, Erster, Zweiter und Dritter Strolch, König, Kerkermeister)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 8426 AND p.composer_id = 91
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:f4f006f6-e5d0-444a-bad7-5fd7a8ac31c5'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 20, part.movement_number = NULL,
    part.name_ko = 'Szene. "Einer soll reden, aber kurz und klar" (König, Eselmann, Mauleselmann, Erster, Zweiter und Dritter Strolch, Kerkermeister)', part.name_en = 'Die Kluge: 5. Szene. "Einer soll reden, aber kurz und klar" (König, Eselmann, Mauleselmann, Erster, Zweiter und Dritter Strolch, Kerkermeister)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 8426 AND p.composer_id = 91 AND part.part_key = 'musicbrainz:fa64e6a4-8473-43ea-a5b5-2354e6c75a67' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:fa64e6a4-8473-43ea-a5b5-2354e6c75a67', 20, NULL, 'Szene. "Einer soll reden, aber kurz und klar" (König, Eselmann, Mauleselmann, Erster, Zweiter und Dritter Strolch, Kerkermeister)', 'Die Kluge: 5. Szene. "Einer soll reden, aber kurz und klar" (König, Eselmann, Mauleselmann, Erster, Zweiter und Dritter Strolch, Kerkermeister)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 8426 AND p.composer_id = 91
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:fa64e6a4-8473-43ea-a5b5-2354e6c75a67'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 21, part.movement_number = NULL,
    part.name_ko = 'Szene. "Oh hätt'' ich meiner Tochter nur geglaubt!" (Bauer)', part.name_en = 'Die Kluge: 1. Szene. "Oh hätt'' ich meiner Tochter nur geglaubt!" (Bauer)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 8426 AND p.composer_id = 91 AND part.part_key = 'musicbrainz:fde56258-7924-4722-8413-48636a0e8e4e' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:fde56258-7924-4722-8413-48636a0e8e4e', 21, NULL, 'Szene. "Oh hätt'' ich meiner Tochter nur geglaubt!" (Bauer)', 'Die Kluge: 1. Szene. "Oh hätt'' ich meiner Tochter nur geglaubt!" (Bauer)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 8426 AND p.composer_id = 91
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:fde56258-7924-4722-8413-48636a0e8e4e'
);


-- None Dithyrambi

UPDATE pieces piece
SET piece.title = 'Dithyrambi', piece.title_en = 'Dithyrambi',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 8304 AND piece.composer_id = 91
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'Nanie', part.name_en = 'Dithyrambi: Nanie',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 8304 AND p.composer_id = 91 AND part.part_key = 'musicbrainz:09bcafe4-8b14-4fa6-914f-da84d1ee277a' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:09bcafe4-8b14-4fa6-914f-da84d1ee277a', 1, NULL, 'Nanie', 'Dithyrambi: Nanie', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 8304 AND p.composer_id = 91
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:09bcafe4-8b14-4fa6-914f-da84d1ee277a'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'Die Sänger der Vorwelt', part.name_en = 'Dithyrambi: Die Sänger der Vorwelt',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 8304 AND p.composer_id = 91 AND part.part_key = 'musicbrainz:55481caf-2538-4001-997f-5954ce4670d1' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:55481caf-2538-4001-997f-5954ce4670d1', 2, NULL, 'Die Sänger der Vorwelt', 'Dithyrambi: Die Sänger der Vorwelt', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 8304 AND p.composer_id = 91
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:55481caf-2538-4001-997f-5954ce4670d1'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = NULL,
    part.name_ko = 'Dithyrambe / Beifall', part.name_en = 'Dithyrambi: Dithyrambe / Beifall',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 8304 AND p.composer_id = 91 AND part.part_key = 'musicbrainz:ab369cc0-7520-4331-a125-10defccb7300' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:ab369cc0-7520-4331-a125-10defccb7300', 3, NULL, 'Dithyrambe / Beifall', 'Dithyrambi: Dithyrambe / Beifall', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 8304 AND p.composer_id = 91
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:ab369cc0-7520-4331-a125-10defccb7300'
);


-- None Fröhlicher Ostersang

UPDATE pieces piece
SET piece.title = 'Fröhlicher Ostersang', piece.title_en = 'Fröhlicher Ostersang',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 7957 AND piece.composer_id = 91
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None 가곡 <Herr, ich liebte>

UPDATE pieces piece
SET piece.title = '가곡 <Herr, ich liebte>', piece.title_en = 'Herr, ich liebte',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 8652 AND piece.composer_id = 91
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None 오페라 <Ludus de nato Infante mirificus>

UPDATE pieces piece
SET piece.title = '오페라 <Ludus de nato Infante mirificus>', piece.title_en = 'Ludus de nato Infante mirificus',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 8196 AND piece.composer_id = 91
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None 가곡 <Mein herz ist wie ein see so weit>

UPDATE pieces piece
SET piece.title = '가곡 <Mein herz ist wie ein see so weit>', piece.title_en = 'Mein herz ist wie ein see so weit',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 9142 AND piece.composer_id = 91
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Trionfi

UPDATE pieces piece
SET piece.title = 'Trionfi', piece.title_en = 'Trionfi',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 9406 AND piece.composer_id = 91
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'Trionfo di Afrodite', part.name_en = 'Trionfo di Afrodite',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 9406 AND p.composer_id = 91 AND part.part_key = 'musicbrainz:8409f466-94e2-428c-9be5-3ffca3963789' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:8409f466-94e2-428c-9be5-3ffca3963789', 1, NULL, 'Trionfo di Afrodite', 'Trionfo di Afrodite', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 9406 AND p.composer_id = 91
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:8409f466-94e2-428c-9be5-3ffca3963789'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:8409f466-94e2-428c-9be5-3ffca3963789'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'Canto amebeo di vergini e giovani a Vespero in attesa della sposa e dello sposo', part.name_en = 'Trionfo di Afrodite: 1. Canto amebeo di vergini e giovani a Vespero in attesa della sposa e dello sposo',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 9406 AND p.composer_id = 91 AND part.part_key = 'musicbrainz:fb41a464-acc4-489a-9f22-2043444256d0' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:fb41a464-acc4-489a-9f22-2043444256d0', 1, NULL, 'Canto amebeo di vergini e giovani a Vespero in attesa della sposa e dello sposo', 'Trionfo di Afrodite: 1. Canto amebeo di vergini e giovani a Vespero in attesa della sposa e dello sposo', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:8409f466-94e2-428c-9be5-3ffca3963789'
WHERE p.id = 9406 AND p.composer_id = 91
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:fb41a464-acc4-489a-9f22-2043444256d0'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:8409f466-94e2-428c-9be5-3ffca3963789'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'Corteo nuziale ed arrivo della sposa e dello sposo', part.name_en = 'Trionfo di Afrodite: 2. Corteo nuziale ed arrivo della sposa e dello sposo',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 9406 AND p.composer_id = 91 AND part.part_key = 'musicbrainz:76e19823-3477-4474-81da-21ee881b42ff' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:76e19823-3477-4474-81da-21ee881b42ff', 2, NULL, 'Corteo nuziale ed arrivo della sposa e dello sposo', 'Trionfo di Afrodite: 2. Corteo nuziale ed arrivo della sposa e dello sposo', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:8409f466-94e2-428c-9be5-3ffca3963789'
WHERE p.id = 9406 AND p.composer_id = 91
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:76e19823-3477-4474-81da-21ee881b42ff'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:8409f466-94e2-428c-9be5-3ffca3963789'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = NULL,
    part.name_ko = 'Sposa e sposo', part.name_en = 'Trionfo di Afrodite: 3. Sposa e sposo',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 9406 AND p.composer_id = 91 AND part.part_key = 'musicbrainz:552ab9e8-0b89-4d58-bdc1-cc48af6cdaea' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:552ab9e8-0b89-4d58-bdc1-cc48af6cdaea', 3, NULL, 'Sposa e sposo', 'Trionfo di Afrodite: 3. Sposa e sposo', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:8409f466-94e2-428c-9be5-3ffca3963789'
WHERE p.id = 9406 AND p.composer_id = 91
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:552ab9e8-0b89-4d58-bdc1-cc48af6cdaea'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:8409f466-94e2-428c-9be5-3ffca3963789'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = NULL,
    part.name_ko = 'Invocazione dell’ Imeneo', part.name_en = 'Trionfo di Afrodite: 4. Invocazione dell’ Imeneo',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 9406 AND p.composer_id = 91 AND part.part_key = 'musicbrainz:20923c69-08ee-4a7e-b2bd-a7e8c1b8b50c' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:20923c69-08ee-4a7e-b2bd-a7e8c1b8b50c', 4, NULL, 'Invocazione dell’ Imeneo', 'Trionfo di Afrodite: 4. Invocazione dell’ Imeneo', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:8409f466-94e2-428c-9be5-3ffca3963789'
WHERE p.id = 9406 AND p.composer_id = 91
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:20923c69-08ee-4a7e-b2bd-a7e8c1b8b50c'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:8409f466-94e2-428c-9be5-3ffca3963789'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 5, part.movement_number = NULL,
    part.name_ko = 'Ludi e canti nuziale davanti al talamo', part.name_en = 'Trionfo di Afrodite: 5. Ludi e canti nuziale davanti al talamo',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 9406 AND p.composer_id = 91 AND part.part_key = 'musicbrainz:b6d01048-f434-4e77-baf3-0ffd6236411c' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:b6d01048-f434-4e77-baf3-0ffd6236411c', 5, NULL, 'Ludi e canti nuziale davanti al talamo', 'Trionfo di Afrodite: 5. Ludi e canti nuziale davanti al talamo', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:8409f466-94e2-428c-9be5-3ffca3963789'
WHERE p.id = 9406 AND p.composer_id = 91
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:b6d01048-f434-4e77-baf3-0ffd6236411c'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:8409f466-94e2-428c-9be5-3ffca3963789'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 6, part.movement_number = NULL,
    part.name_ko = 'Canto di novelli sposi dal talamo', part.name_en = 'Trionfo di Afrodite: 6. Canto di novelli sposi dal talamo',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 9406 AND p.composer_id = 91 AND part.part_key = 'musicbrainz:85acb34b-beb4-4300-919b-19fd31d0dbbd' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:85acb34b-beb4-4300-919b-19fd31d0dbbd', 6, NULL, 'Canto di novelli sposi dal talamo', 'Trionfo di Afrodite: 6. Canto di novelli sposi dal talamo', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:8409f466-94e2-428c-9be5-3ffca3963789'
WHERE p.id = 9406 AND p.composer_id = 91
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:85acb34b-beb4-4300-919b-19fd31d0dbbd'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:8409f466-94e2-428c-9be5-3ffca3963789'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 7, part.movement_number = NULL,
    part.name_ko = 'Apparizione di Afrodite', part.name_en = 'Trionfo di Afrodite: 7. Apparizione di Afrodite',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 9406 AND p.composer_id = 91 AND part.part_key = 'musicbrainz:0045dd8b-ea58-4329-b8f6-f697a4a454cf' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:0045dd8b-ea58-4329-b8f6-f697a4a454cf', 7, NULL, 'Apparizione di Afrodite', 'Trionfo di Afrodite: 7. Apparizione di Afrodite', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:8409f466-94e2-428c-9be5-3ffca3963789'
WHERE p.id = 9406 AND p.composer_id = 91
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:0045dd8b-ea58-4329-b8f6-f697a4a454cf'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'Catulli Carmina', part.name_en = 'Catulli Carmina',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 9406 AND p.composer_id = 91 AND part.part_key = 'musicbrainz:b53b9090-fe40-4e72-a782-87aa7bf204c7' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:b53b9090-fe40-4e72-a782-87aa7bf204c7', 2, NULL, 'Catulli Carmina', 'Catulli Carmina', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 9406 AND p.composer_id = 91
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:b53b9090-fe40-4e72-a782-87aa7bf204c7'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:b53b9090-fe40-4e72-a782-87aa7bf204c7'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'Eis aiona!', part.name_en = 'Catulli Carmina - Chorus: Eis aiona!',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 9406 AND p.composer_id = 91 AND part.part_key = 'musicbrainz:55890efb-3f3b-4d7b-a286-48ac3e34355e' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:55890efb-3f3b-4d7b-a286-48ac3e34355e', 1, NULL, 'Eis aiona!', 'Catulli Carmina - Chorus: Eis aiona!', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:b53b9090-fe40-4e72-a782-87aa7bf204c7'
WHERE p.id = 9406 AND p.composer_id = 91
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:55890efb-3f3b-4d7b-a286-48ac3e34355e'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:b53b9090-fe40-4e72-a782-87aa7bf204c7'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'Actus I', part.name_en = 'Catulli Carmina: Actus I',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 9406 AND p.composer_id = 91 AND part.part_key = 'musicbrainz:1ea896c2-fb68-4069-a701-770f6a781938' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:1ea896c2-fb68-4069-a701-770f6a781938', 2, NULL, 'Actus I', 'Catulli Carmina: Actus I', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:b53b9090-fe40-4e72-a782-87aa7bf204c7'
WHERE p.id = 9406 AND p.composer_id = 91
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:1ea896c2-fb68-4069-a701-770f6a781938'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:b53b9090-fe40-4e72-a782-87aa7bf204c7'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = NULL,
    part.name_ko = 'Actus II', part.name_en = 'Catulli Carmina: Actus II',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 9406 AND p.composer_id = 91 AND part.part_key = 'musicbrainz:bf6feef7-837f-4f8d-98e0-61b4ae839f38' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:bf6feef7-837f-4f8d-98e0-61b4ae839f38', 3, NULL, 'Actus II', 'Catulli Carmina: Actus II', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:b53b9090-fe40-4e72-a782-87aa7bf204c7'
WHERE p.id = 9406 AND p.composer_id = 91
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:bf6feef7-837f-4f8d-98e0-61b4ae839f38'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:b53b9090-fe40-4e72-a782-87aa7bf204c7'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = NULL,
    part.name_ko = 'Actus III', part.name_en = 'Catulli Carmina: Actus III',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 9406 AND p.composer_id = 91 AND part.part_key = 'musicbrainz:d59cca1c-f55d-4404-9e82-d31f55a8c786' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:d59cca1c-f55d-4404-9e82-d31f55a8c786', 4, NULL, 'Actus III', 'Catulli Carmina: Actus III', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:b53b9090-fe40-4e72-a782-87aa7bf204c7'
WHERE p.id = 9406 AND p.composer_id = 91
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:d59cca1c-f55d-4404-9e82-d31f55a8c786'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:b53b9090-fe40-4e72-a782-87aa7bf204c7'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 5, part.movement_number = NULL,
    part.name_ko = 'Catulli Carmina - Exodium', part.name_en = 'Catulli Carmina - Exodium',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 9406 AND p.composer_id = 91 AND part.part_key = 'musicbrainz:4c99e7c0-4c10-4443-8d99-9c5d72ffec3b' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:4c99e7c0-4c10-4443-8d99-9c5d72ffec3b', 5, NULL, 'Catulli Carmina - Exodium', 'Catulli Carmina - Exodium', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:b53b9090-fe40-4e72-a782-87aa7bf204c7'
WHERE p.id = 9406 AND p.composer_id = 91
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:4c99e7c0-4c10-4443-8d99-9c5d72ffec3b'
);


-- None 가곡 <Zwiegespräch>

UPDATE pieces piece
SET piece.title = '가곡 <Zwiegespräch>', piece.title_en = 'Zwiegespräch',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 7896 AND piece.composer_id = 91
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None 오페라 <De temporum fine comoedia>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '오페라 <De temporum fine comoedia>', 'De temporum fine comoedia', 'album', NULL, NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 91
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '오페라 <De temporum fine comoedia>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'eaea5f63-b422-4e32-83ad-d95c5048d249'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'eaea5f63-b422-4e32-83ad-d95c5048d249'
FROM pieces p
WHERE p.composer_id = 91 AND p.title = '오페라 <De temporum fine comoedia>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'eaea5f63-b422-4e32-83ad-d95c5048d249'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:17fa307e-c495-4f9d-9aab-461bdbd6b6be', 1, 'III', '"Dies Illa". "Kyrie" / "Serva nos, salva nos, eripe nos!"', 'De temporum fine comoedia: III. "Dies Illa". "Kyrie" / "Serva nos, salva nos, eripe nos!"', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 91 AND p.title = '오페라 <De temporum fine comoedia>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:17fa307e-c495-4f9d-9aab-461bdbd6b6be'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:453fb704-6959-4185-8427-03ea428a5562', 2, 'I', 'Die Sibyllen. "Vae! Ibunt impii in gehennam ignis eterni"', 'De temporum fine comoedia: I. Die Sibyllen. "Vae! Ibunt impii in gehennam ignis eterni"', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 91 AND p.title = '오페라 <De temporum fine comoedia>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:453fb704-6959-4185-8427-03ea428a5562'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:4744a189-a00c-4ee8-99f2-067232ea1750', 3, 'III', '"Dies Illa". "Pater peccavi"', 'De temporum fine comoedia: III. "Dies Illa". "Pater peccavi"', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 91 AND p.title = '오페라 <De temporum fine comoedia>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:4744a189-a00c-4ee8-99f2-067232ea1750'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:5fd7624e-e90e-43ff-b001-768b81da7a70', 4, 'II', 'Die Anachoreten. "Wann endet die Zeit?"', 'De temporum fine comoedia: II. Die Anachoreten. "Wann endet die Zeit?"', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 91 AND p.title = '오페라 <De temporum fine comoedia>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:5fd7624e-e90e-43ff-b001-768b81da7a70'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:6cb8c934-8150-4cdd-91fb-d3ae34ed8477', 5, 'I', 'Die Sibyllen. "Opse theü g''aléüsi myloi"', 'De temporum fine comoedia: I. Die Sibyllen. "Opse theü g''aléüsi myloi"', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 91 AND p.title = '오페라 <De temporum fine comoedia>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:6cb8c934-8150-4cdd-91fb-d3ae34ed8477'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:6d3d6627-716d-4d09-b59c-b4cbd47d6b98', 6, 'II', 'Die Anachoreten. "Upote, maepote, maepu, maedépote... ignis eterni immensa tormenta"', 'De temporum fine comoedia: II. Die Anachoreten. "Upote, maepote, maepu, maedépote... ignis eterni immensa tormenta"', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 91 AND p.title = '오페라 <De temporum fine comoedia>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:6d3d6627-716d-4d09-b59c-b4cbd47d6b98'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:70161e11-7dde-4064-b4c2-f47c8e99e90a', 7, 'III', '"Dies Illa". Con sublima spiritualità', 'De temporum fine comoedia: III. "Dies Illa". Con sublima spiritualità', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 91 AND p.title = '오페라 <De temporum fine comoedia>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:70161e11-7dde-4064-b4c2-f47c8e99e90a'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:8f8c8ad7-7254-49f0-9d77-5e37a3bbe16e', 8, 'III', '"Dies Illa". "Angor, timor, horror, terror ac pavor invadit omnes"', 'De temporum fine comoedia: III. "Dies Illa". "Angor, timor, horror, terror ac pavor invadit omnes"', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 91 AND p.title = '오페라 <De temporum fine comoedia>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:8f8c8ad7-7254-49f0-9d77-5e37a3bbe16e'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:96d70bfb-8c82-4190-9291-949db1df2c7a', 9, 'II', 'Die Anachoreten. "Gott, schenk uns Wahrsagung, Weissagung, Hellsicht im Traum. Gott, schenk uns den Traum"', 'De temporum fine comoedia: II. Die Anachoreten. "Gott, schenk uns Wahrsagung, Weissagung, Hellsicht im Traum. Gott, schenk uns den Traum"', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 91 AND p.title = '오페라 <De temporum fine comoedia>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:96d70bfb-8c82-4190-9291-949db1df2c7a'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:994e82e9-3a06-458e-a6c1-64d5dcf02690', 10, 'III', '"Dies Illa". "Vae, Portae Inferi oculus aspicit nos tenebrarius tenebris"', 'De temporum fine comoedia: III. "Dies Illa". "Vae, Portae Inferi oculus aspicit nos tenebrarius tenebris"', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 91 AND p.title = '오페라 <De temporum fine comoedia>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:994e82e9-3a06-458e-a6c1-64d5dcf02690'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:99b38eb7-09cf-4eb9-b4c6-99a48b634801', 11, 'III', '"Dies Illa". "Omne genus daemoniorum caecorum, claudorum sive confusorum, attendite iussum meorum et vocationem verborum"', 'De temporum fine comoedia: III. "Dies Illa". "Omne genus daemoniorum caecorum, claudorum sive confusorum, attendite iussum meorum et vocationem verborum"', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 91 AND p.title = '오페라 <De temporum fine comoedia>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:99b38eb7-09cf-4eb9-b4c6-99a48b634801'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:b5142012-1f84-4f73-a917-e03415772729', 12, 'I', 'Die Sibyllen. "Choneusó gar hapanta kai eis katharón dialéxo"', 'De temporum fine comoedia: I. Die Sibyllen. "Choneusó gar hapanta kai eis katharón dialéxo"', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 91 AND p.title = '오페라 <De temporum fine comoedia>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:b5142012-1f84-4f73-a917-e03415772729'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:bda1ef52-2209-4ced-bc2a-561e4b31e5b9', 13, 'II', 'Die Anachoreten. "Unos solus Deus ab aeterno in aeternum"', 'De temporum fine comoedia: II. Die Anachoreten. "Unos solus Deus ab aeterno in aeternum"', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 91 AND p.title = '오페라 <De temporum fine comoedia>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:bda1ef52-2209-4ced-bc2a-561e4b31e5b9'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:c0f801b3-592f-41a4-8c02-1d0ca7d6788b', 14, 'I', 'Die Sibyllen. "Heis theós estin anarchos, hypermegéthaes, agénaetos"', 'De temporum fine comoedia: I. Die Sibyllen. "Heis theós estin anarchos, hypermegéthaes, agénaetos"', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 91 AND p.title = '오페라 <De temporum fine comoedia>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:c0f801b3-592f-41a4-8c02-1d0ca7d6788b'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:c1488abf-7785-4838-bc95-5504cd34c974', 15, 'II', 'Die Anachoreten. "Mundus terrenus volvitur"', 'De temporum fine comoedia: II. Die Anachoreten. "Mundus terrenus volvitur"', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 91 AND p.title = '오페라 <De temporum fine comoedia>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:c1488abf-7785-4838-bc95-5504cd34c974'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:e4cfe0e7-4de4-43bb-b860-b83cfa1f7c9d', 16, 'I', 'Die Sibyllen. "Pasin homü nyx estin isae tois plüton echusin kai ptochois"', 'De temporum fine comoedia: I. Die Sibyllen. "Pasin homü nyx estin isae tois plüton echusin kai ptochois"', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 91 AND p.title = '오페라 <De temporum fine comoedia>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:e4cfe0e7-4de4-43bb-b860-b83cfa1f7c9d'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:f2acfdb0-8198-4747-b57e-8dc675aa149d', 17, 'II', 'Die Anachoreten. "Nicht Satanas... nicht Lucifer... damnatus nunquam condemnatus in aeternam"', 'De temporum fine comoedia: II. Die Anachoreten. "Nicht Satanas... nicht Lucifer... damnatus nunquam condemnatus in aeternam"', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 91 AND p.title = '오페라 <De temporum fine comoedia>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:f2acfdb0-8198-4747-b57e-8dc675aa149d'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:f9962161-a69e-4c5e-8ad6-84ae4c0175d2', 18, 'III', '"Dies Illa". "Wo irren wir hin, verlosen, verlassen"', 'De temporum fine comoedia: III. "Dies Illa". "Wo irren wir hin, verlosen, verlassen"', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 91 AND p.title = '오페라 <De temporum fine comoedia>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:f9962161-a69e-4c5e-8ad6-84ae4c0175d2'
);


-- None Oedipus der Tyrann: Act I "Gleich wissens wirs"

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, 'Oedipus der Tyrann: Act I "Gleich wissens wirs"', 'Oedipus der Tyrann: Act I "Gleich wissens wirs"', 'album', NULL, NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 91
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = 'Oedipus der Tyrann: Act I "Gleich wissens wirs"'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '261707c6-4fea-4d26-83eb-92be7f50d5f8'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '261707c6-4fea-4d26-83eb-92be7f50d5f8'
FROM pieces p
WHERE p.composer_id = 91 AND p.title = 'Oedipus der Tyrann: Act I "Gleich wissens wirs"' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '261707c6-4fea-4d26-83eb-92be7f50d5f8'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:d0d71059-3ee8-4514-9b53-77b1115042eb', 1, NULL, 'Act III "Warum habt ihr ratlosen Zungenkrieg"', 'Act III "Warum habt ihr ratlosen Zungenkrieg"', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 91 AND p.title = 'Oedipus der Tyrann: Act I "Gleich wissens wirs"' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:d0d71059-3ee8-4514-9b53-77b1115042eb'
);


-- 카탈로그에 대응이 없는 seed 작품 16개를 목록에서 숨긴다(지우지 않음).
UPDATE pieces piece
SET piece.hidden_reason = 'catalog_unmatched'
WHERE piece.composer_id = 91 AND piece.origin = 'seed' AND piece.hidden_reason IS NULL
  AND piece.id IN (
    7865, 7923, 8397, 8511, 9138, 9157, 9338, 9405, 9939, 10019, 10041, 10191, 10461, 10924, 11088, 11237
  )
  AND NOT EXISTS (SELECT 1 FROM performance_sectors sector WHERE sector.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM piece_parts linking WHERE linking.linked_piece_id = piece.id);
