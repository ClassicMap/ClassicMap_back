-- 베베른 작품을 MusicBrainz 작품 구조로 다시 짠다(4차 자동). 작품 46개(묶음 1, 다악장 31, 낱곡 14),
-- 새 작품 4개, part 115개, 그 아래 0개.
-- seed 75개 중 42개를 작품·part 에 잇고, 3개를 숨기고, 30개는 그대로 둔다.
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

-- None 2개의 첼로와 피아노를 위한 소품

UPDATE pieces piece
SET piece.title = '2개의 첼로와 피아노를 위한 소품', piece.title_en = '2 Pieces for Cello and Piano',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 10405 AND piece.composer_id = 97
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'Langsam', part.name_en = '2 Pieces for Cello and Piano: I. Langsam',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 10405 AND p.composer_id = 97 AND part.part_key = 'musicbrainz:42ffd24e-e8de-47ce-8e60-301a6738ca21' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:42ffd24e-e8de-47ce-8e60-301a6738ca21', 1, 'I', 'Langsam', '2 Pieces for Cello and Piano: I. Langsam', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 10405 AND p.composer_id = 97
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:42ffd24e-e8de-47ce-8e60-301a6738ca21'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'Langsam', part.name_en = '2 Pieces for Cello and Piano: II. Langsam',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 10405 AND p.composer_id = 97 AND part.part_key = 'musicbrainz:ec6ee9fc-476f-4632-a6b5-bb802b6cc22c' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:ec6ee9fc-476f-4632-a6b5-bb802b6cc22c', 2, 'II', 'Langsam', '2 Pieces for Cello and Piano: II. Langsam', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 10405 AND p.composer_id = 97
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:ec6ee9fc-476f-4632-a6b5-bb802b6cc22c'
);


-- Op. 19 2개의 가곡

UPDATE pieces piece
SET piece.title = '2개의 가곡', piece.title_en = '2 Songs, op. 19',
    piece.type = 'album', piece.opus_number = 'Op. 19',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 7836 AND piece.composer_id = 97
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = '"Weiß wie Lilien": Lebhaft, leicht und frei', part.name_en = '2 Songs, op. 19: I. "Weiß wie Lilien": Lebhaft, leicht und frei',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 7836 AND p.composer_id = 97 AND part.part_key = 'musicbrainz:684261a6-1344-40c3-9859-839b935d356e' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:684261a6-1344-40c3-9859-839b935d356e', 1, 'I', '"Weiß wie Lilien": Lebhaft, leicht und frei', '2 Songs, op. 19: I. "Weiß wie Lilien": Lebhaft, leicht und frei', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 7836 AND p.composer_id = 97
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:684261a6-1344-40c3-9859-839b935d356e'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = '"Ziehn die Schafe": Sehr gemächlich', part.name_en = '2 Songs, op. 19: II. "Ziehn die Schafe": Sehr gemächlich',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 7836 AND p.composer_id = 97 AND part.part_key = 'musicbrainz:0b2bac79-65a6-438a-9011-14d201635cfd' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:0b2bac79-65a6-438a-9011-14d201635cfd', 2, 'II', '"Ziehn die Schafe": Sehr gemächlich', '2 Songs, op. 19: II. "Ziehn die Schafe": Sehr gemächlich', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 7836 AND p.composer_id = 97
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:0b2bac79-65a6-438a-9011-14d201635cfd'
);


-- Op. 8 2개의 가곡 Op. 8

UPDATE pieces piece
SET piece.title = '2개의 가곡 Op. 8', piece.title_en = '2 Songs, op. 8',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = 'Op.', piece.catalogue_number = '8',
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 10807 AND piece.composer_id = 97
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = '"Du, der ich''s nicht sage" (Langsam)', part.name_en = '2 Songs, op. 8: I. "Du, der ich''s nicht sage" (Langsam)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 10807 AND p.composer_id = 97 AND part.part_key = 'musicbrainz:1f33f321-4a6f-4fa5-bec1-d344a288de19' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:1f33f321-4a6f-4fa5-bec1-d344a288de19', 1, 'I', '"Du, der ich''s nicht sage" (Langsam)', '2 Songs, op. 8: I. "Du, der ich''s nicht sage" (Langsam)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 10807 AND p.composer_id = 97
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:1f33f321-4a6f-4fa5-bec1-d344a288de19'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = '"Du machst mich allein" (Sehr langsam)', part.name_en = '2 Songs, op. 8: II. "Du machst mich allein" (Sehr langsam)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 10807 AND p.composer_id = 97 AND part.part_key = 'musicbrainz:0496510b-9d3d-4f6b-a19f-da5921ae1b28' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:0496510b-9d3d-4f6b-a19f-da5921ae1b28', 2, 'II', '"Du machst mich allein" (Sehr langsam)', '2 Songs, op. 8: II. "Du machst mich allein" (Sehr langsam)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 10807 AND p.composer_id = 97
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:0496510b-9d3d-4f6b-a19f-da5921ae1b28'
);


-- None 3 Poems

UPDATE pieces piece
SET piece.title = '3 Poems', piece.title_en = '3 Poems',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 10305 AND piece.composer_id = 97
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'Vorfrühling', part.name_en = '3 Poems: I. Vorfrühling',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 10305 AND p.composer_id = 97 AND part.part_key = 'musicbrainz:cd7bc063-c0c8-4ebd-869a-b2a1f404333c' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:cd7bc063-c0c8-4ebd-869a-b2a1f404333c', 1, 'I', 'Vorfrühling', '3 Poems: I. Vorfrühling', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 10305 AND p.composer_id = 97
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:cd7bc063-c0c8-4ebd-869a-b2a1f404333c'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'Nachtgebet der Braut', part.name_en = '3 Poems: II. Nachtgebet der Braut',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 10305 AND p.composer_id = 97 AND part.part_key = 'musicbrainz:05f2b81f-d63f-4d26-b70a-f4e0f33357b6' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:05f2b81f-d63f-4d26-b70a-f4e0f33357b6', 2, 'II', 'Nachtgebet der Braut', '3 Poems: II. Nachtgebet der Braut', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 10305 AND p.composer_id = 97
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:05f2b81f-d63f-4d26-b70a-f4e0f33357b6'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = 'Fromm', part.name_en = '3 Poems: III. Fromm',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 10305 AND p.composer_id = 97 AND part.part_key = 'musicbrainz:8e48d066-5faf-4230-ab5f-3b57a31f1d9e' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:8e48d066-5faf-4230-ab5f-3b57a31f1d9e', 3, 'III', 'Fromm', '3 Poems: III. Fromm', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 10305 AND p.composer_id = 97
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:8e48d066-5faf-4230-ab5f-3b57a31f1d9e'
);


-- Op. 23 3 Songs from "Viae inviae" by Hildegard Jone

UPDATE pieces piece
SET piece.title = '3 Songs from "Viae inviae" by Hildegard Jone', piece.title_en = '3 Songs from "Viae inviae" by Hildegard Jone, op. 23',
    piece.type = 'album', piece.opus_number = 'Op. 23',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 8191 AND piece.composer_id = 97
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = '"Das dunkle Herz, das in sich lauscht"', part.name_en = '3 Songs from "Viae inviae" by Hildegard Jone, op. 23: I. "Das dunkle Herz, das in sich lauscht"',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 8191 AND p.composer_id = 97 AND part.part_key = 'musicbrainz:fc33b96b-a703-44bf-997c-e044d1c51bdc' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:fc33b96b-a703-44bf-997c-e044d1c51bdc', 1, 'I', '"Das dunkle Herz, das in sich lauscht"', '3 Songs from "Viae inviae" by Hildegard Jone, op. 23: I. "Das dunkle Herz, das in sich lauscht"', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 8191 AND p.composer_id = 97
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:fc33b96b-a703-44bf-997c-e044d1c51bdc'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = '"Es stürzt aus Höhen Frische"', part.name_en = '3 Songs from "Viae inviae" by Hildegard Jone, op. 23: II. "Es stürzt aus Höhen Frische"',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 8191 AND p.composer_id = 97 AND part.part_key = 'musicbrainz:a96d3ac5-1c89-49b4-90d5-4da0ecb9920e' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:a96d3ac5-1c89-49b4-90d5-4da0ecb9920e', 2, 'II', '"Es stürzt aus Höhen Frische"', '3 Songs from "Viae inviae" by Hildegard Jone, op. 23: II. "Es stürzt aus Höhen Frische"', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 8191 AND p.composer_id = 97
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:a96d3ac5-1c89-49b4-90d5-4da0ecb9920e'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = '"Herr Jesus mein"', part.name_en = '3 Songs from "Viae inviae" by Hildegard Jone, op. 23: III. "Herr Jesus mein"',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 8191 AND p.composer_id = 97 AND part.part_key = 'musicbrainz:4005a145-cd2f-4060-b112-eb892c46596c' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:4005a145-cd2f-4060-b112-eb892c46596c', 3, 'III', '"Herr Jesus mein"', '3 Songs from "Viae inviae" by Hildegard Jone, op. 23: III. "Herr Jesus mein"', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 8191 AND p.composer_id = 97
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:4005a145-cd2f-4060-b112-eb892c46596c'
);


-- Op. 25 3 Songs on Poems by Hildgard Jone

UPDATE pieces piece
SET piece.title = '3 Songs on Poems by Hildgard Jone', piece.title_en = '3 Songs on Poems by Hildgard Jone, op. 25',
    piece.type = 'album', piece.opus_number = 'Op. 25',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 10324 AND piece.composer_id = 97
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = '"Wie bin ich froh"', part.name_en = '3 Songs on Poems by Hildgard Jone, op. 25: I. "Wie bin ich froh"',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 10324 AND p.composer_id = 97 AND part.part_key = 'musicbrainz:a1e8a1ac-c4d7-4604-a74e-d0a4b69c59a0' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:a1e8a1ac-c4d7-4604-a74e-d0a4b69c59a0', 1, 'I', '"Wie bin ich froh"', '3 Songs on Poems by Hildgard Jone, op. 25: I. "Wie bin ich froh"', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 10324 AND p.composer_id = 97
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:a1e8a1ac-c4d7-4604-a74e-d0a4b69c59a0'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = '"Des Herzens Purpurvogel fliegt durch Nacht"', part.name_en = '3 Songs on Poems by Hildgard Jone, op. 25: II. "Des Herzens Purpurvogel fliegt durch Nacht"',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 10324 AND p.composer_id = 97 AND part.part_key = 'musicbrainz:83c5af50-d7d8-455b-812f-d4888d9767b9' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:83c5af50-d7d8-455b-812f-d4888d9767b9', 2, 'II', '"Des Herzens Purpurvogel fliegt durch Nacht"', '3 Songs on Poems by Hildgard Jone, op. 25: II. "Des Herzens Purpurvogel fliegt durch Nacht"', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 10324 AND p.composer_id = 97
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:83c5af50-d7d8-455b-812f-d4888d9767b9'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = '"Sterne, Ihr silbernen Bienen der Nacht"', part.name_en = '3 Songs on Poems by Hildgard Jone, op. 25: III. "Sterne, Ihr silbernen Bienen der Nacht"',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 10324 AND p.composer_id = 97 AND part.part_key = 'musicbrainz:472142a2-f19f-411b-baf0-373904d97684' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:472142a2-f19f-411b-baf0-373904d97684', 3, 'III', '"Sterne, Ihr silbernen Bienen der Nacht"', '3 Songs on Poems by Hildgard Jone, op. 25: III. "Sterne, Ihr silbernen Bienen der Nacht"', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 10324 AND p.composer_id = 97
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:472142a2-f19f-411b-baf0-373904d97684'
);


-- Op. 18 3개의 가곡

UPDATE pieces piece
SET piece.title = '3개의 가곡', piece.title_en = '3 Songs, op. 18',
    piece.type = 'album', piece.opus_number = 'Op. 18',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 10646 AND piece.composer_id = 97
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = '"Schatzerl klein": Sehr ruhig', part.name_en = '3 Songs, op. 18: I. "Schatzerl klein": Sehr ruhig',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 10646 AND p.composer_id = 97 AND part.part_key = 'musicbrainz:0b0211d3-835c-4895-af38-66231340ee97' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:0b0211d3-835c-4895-af38-66231340ee97', 1, 'I', '"Schatzerl klein": Sehr ruhig', '3 Songs, op. 18: I. "Schatzerl klein": Sehr ruhig', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 10646 AND p.composer_id = 97
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:0b0211d3-835c-4895-af38-66231340ee97'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'Erlösung "Mein Kind, sieh an": Bewegt', part.name_en = '3 Songs, op. 18: II. Erlösung "Mein Kind, sieh an": Bewegt',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 10646 AND p.composer_id = 97 AND part.part_key = 'musicbrainz:471a87c5-45ca-4ca1-8d0c-8a43b56da001' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:471a87c5-45ca-4ca1-8d0c-8a43b56da001', 2, 'II', 'Erlösung "Mein Kind, sieh an": Bewegt', '3 Songs, op. 18: II. Erlösung "Mein Kind, sieh an": Bewegt', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 10646 AND p.composer_id = 97
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:471a87c5-45ca-4ca1-8d0c-8a43b56da001'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = '"Ave, Regina coelorum": Langsam', part.name_en = '3 Songs, op. 18: III. "Ave, Regina coelorum": Langsam',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 10646 AND p.composer_id = 97 AND part.part_key = 'musicbrainz:3156f66e-4877-4a40-b8dd-f170335e36a5' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:3156f66e-4877-4a40-b8dd-f170335e36a5', 3, 'III', '"Ave, Regina coelorum": Langsam', '3 Songs, op. 18: III. "Ave, Regina coelorum": Langsam', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 10646 AND p.composer_id = 97
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:3156f66e-4877-4a40-b8dd-f170335e36a5'
);


-- Op. 17 3 Traditional Rhymes

UPDATE pieces piece
SET piece.title = '3 Traditional Rhymes', piece.title_en = '3 Traditional Rhymes, op. 17',
    piece.type = 'album', piece.opus_number = 'Op. 17',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 8127 AND piece.composer_id = 97
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = '"Armer Sünder, du": Gemächlich', part.name_en = '3 Traditional Rhymes, op. 17: I. "Armer Sünder, du": Gemächlich',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 8127 AND p.composer_id = 97 AND part.part_key = 'musicbrainz:bf09a6b2-7c03-4a52-9635-5183cd954f6a' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:bf09a6b2-7c03-4a52-9635-5183cd954f6a', 1, 'I', '"Armer Sünder, du": Gemächlich', '3 Traditional Rhymes, op. 17: I. "Armer Sünder, du": Gemächlich', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 8127 AND p.composer_id = 97
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:bf09a6b2-7c03-4a52-9635-5183cd954f6a'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = '"Liebste Jungfrau, wir sind dein": Fließend', part.name_en = '3 Traditional Rhymes, op. 17: II. "Liebste Jungfrau, wir sind dein": Fließend',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 8127 AND p.composer_id = 97 AND part.part_key = 'musicbrainz:ab4446c4-2543-4b14-8fb2-98ce637e9bf0' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:ab4446c4-2543-4b14-8fb2-98ce637e9bf0', 2, 'II', '"Liebste Jungfrau, wir sind dein": Fließend', '3 Traditional Rhymes, op. 17: II. "Liebste Jungfrau, wir sind dein": Fließend', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 8127 AND p.composer_id = 97
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:ab4446c4-2543-4b14-8fb2-98ce637e9bf0'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = '"Heiland, unsre Missetaten": Langsam', part.name_en = '3 Traditional Rhymes, op. 17: III. "Heiland, unsre Missetaten": Langsam',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 8127 AND p.composer_id = 97 AND part.part_key = 'musicbrainz:20f45cad-cf92-4f11-8b34-50ff5c20031f' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:20f45cad-cf92-4f11-8b34-50ff5c20031f', 3, 'III', '"Heiland, unsre Missetaten": Langsam', '3 Traditional Rhymes, op. 17: III. "Heiland, unsre Missetaten": Langsam', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 8127 AND p.composer_id = 97
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:20f45cad-cf92-4f11-8b34-50ff5c20031f'
);


-- Op. 12 4개의 가곡

UPDATE pieces piece
SET piece.title = '4개의 가곡', piece.title_en = '4 Songs, op. 12',
    piece.type = 'album', piece.opus_number = 'Op. 12',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 8472 AND piece.composer_id = 97
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = '"Der Tag ist vergangen"', part.name_en = '4 Songs, op. 12: I. "Der Tag ist vergangen"',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 8472 AND p.composer_id = 97 AND part.part_key = 'musicbrainz:0020f274-042c-44da-8539-e9fd66fd0ab2' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:0020f274-042c-44da-8539-e9fd66fd0ab2', 1, 'I', '"Der Tag ist vergangen"', '4 Songs, op. 12: I. "Der Tag ist vergangen"', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 8472 AND p.composer_id = 97
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:0020f274-042c-44da-8539-e9fd66fd0ab2'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'Die geheimnisvolle Flöte', part.name_en = '4 Songs, op. 12: II. Die geheimnisvolle Flöte',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 8472 AND p.composer_id = 97 AND part.part_key = 'musicbrainz:c17672ac-21a6-4d9a-8d07-31131d976464' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:c17672ac-21a6-4d9a-8d07-31131d976464', 2, 'II', 'Die geheimnisvolle Flöte', '4 Songs, op. 12: II. Die geheimnisvolle Flöte', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 8472 AND p.composer_id = 97
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:c17672ac-21a6-4d9a-8d07-31131d976464'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = '"Schien mir''s, als ich sah die Sonne"', part.name_en = '4 Songs, op. 12: III. "Schien mir''s, als ich sah die Sonne"',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 8472 AND p.composer_id = 97 AND part.part_key = 'musicbrainz:09de981b-ff25-49d0-a75e-059cfde47aef' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:09de981b-ff25-49d0-a75e-059cfde47aef', 3, 'III', '"Schien mir''s, als ich sah die Sonne"', '4 Songs, op. 12: III. "Schien mir''s, als ich sah die Sonne"', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 8472 AND p.composer_id = 97
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:09de981b-ff25-49d0-a75e-059cfde47aef'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = 'IV',
    part.name_ko = 'Gleich und gleich', part.name_en = '4 Songs, op. 12: IV. Gleich und gleich',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 8472 AND p.composer_id = 97 AND part.part_key = 'musicbrainz:9c0f8218-6280-4bca-929b-fac2fd66c690' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:9c0f8218-6280-4bca-929b-fac2fd66c690', 4, 'IV', 'Gleich und gleich', '4 Songs, op. 12: IV. Gleich und gleich', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 8472 AND p.composer_id = 97
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:9c0f8218-6280-4bca-929b-fac2fd66c690'
);


-- Op. 13 4개의 가곡 Op. 13

UPDATE pieces piece
SET piece.title = '4개의 가곡 Op. 13', piece.title_en = '4 Songs, op. 13',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = 'Op.', piece.catalogue_number = '13',
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 10636 AND piece.composer_id = 97
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'Wiese im Park "Wie wird mir zeitlos": Sehr ruhig', part.name_en = '4 Songs, op. 13: I. Wiese im Park "Wie wird mir zeitlos": Sehr ruhig',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 10636 AND p.composer_id = 97 AND part.part_key = 'musicbrainz:6e868728-86b3-4cd3-acf9-5e59f899019f' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:6e868728-86b3-4cd3-acf9-5e59f899019f', 1, 'I', 'Wiese im Park "Wie wird mir zeitlos": Sehr ruhig', '4 Songs, op. 13: I. Wiese im Park "Wie wird mir zeitlos": Sehr ruhig', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 10636 AND p.composer_id = 97
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:6e868728-86b3-4cd3-acf9-5e59f899019f'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'Die Einsame "An dunkelblauem Himmel": Bewegt', part.name_en = '4 Songs, op. 13: II. Die Einsame "An dunkelblauem Himmel": Bewegt',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 10636 AND p.composer_id = 97 AND part.part_key = 'musicbrainz:263e541b-c583-47c0-8eb2-0ff741b20241' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:263e541b-c583-47c0-8eb2-0ff741b20241', 2, 'II', 'Die Einsame "An dunkelblauem Himmel": Bewegt', '4 Songs, op. 13: II. Die Einsame "An dunkelblauem Himmel": Bewegt', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 10636 AND p.composer_id = 97
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:263e541b-c583-47c0-8eb2-0ff741b20241'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = 'In der Fremde "In fremden Lande lag ich": Fließend', part.name_en = '4 Songs, op. 13: III. In der Fremde "In fremden Lande lag ich": Fließend',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 10636 AND p.composer_id = 97 AND part.part_key = 'musicbrainz:4c6fd6c1-0a2d-4ea3-9e4d-04149ce164c8' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:4c6fd6c1-0a2d-4ea3-9e4d-04149ce164c8', 3, 'III', 'In der Fremde "In fremden Lande lag ich": Fließend', '4 Songs, op. 13: III. In der Fremde "In fremden Lande lag ich": Fließend', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 10636 AND p.composer_id = 97
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:4c6fd6c1-0a2d-4ea3-9e4d-04149ce164c8'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = 'IV',
    part.name_ko = 'Ein Winterabend "Wenn der Schnee ans Fenster fällt": Sehr ruhig', part.name_en = '4 Songs, op. 13: IV. Ein Winterabend "Wenn der Schnee ans Fenster fällt": Sehr ruhig',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 10636 AND p.composer_id = 97 AND part.part_key = 'musicbrainz:84bc782f-e60f-44b0-9d37-6800bbb1a6b7' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:84bc782f-e60f-44b0-9d37-6800bbb1a6b7', 4, 'IV', 'Ein Winterabend "Wenn der Schnee ans Fenster fällt": Sehr ruhig', '4 Songs, op. 13: IV. Ein Winterabend "Wenn der Schnee ans Fenster fällt": Sehr ruhig', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 10636 AND p.composer_id = 97
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:84bc782f-e60f-44b0-9d37-6800bbb1a6b7'
);


-- Op. 16 5 Canons

UPDATE pieces piece
SET piece.title = '5 Canons', piece.title_en = '5 Canons, op. 16',
    piece.type = 'album', piece.opus_number = 'Op. 16',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 9321 AND piece.composer_id = 97
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = '"Christus factus est": Rasch', part.name_en = '5 Canons, op. 16: I. "Christus factus est": Rasch',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 9321 AND p.composer_id = 97 AND part.part_key = 'musicbrainz:e065b047-30fe-4fa2-8136-4badaa8d1b78' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:e065b047-30fe-4fa2-8136-4badaa8d1b78', 1, 'I', '"Christus factus est": Rasch', '5 Canons, op. 16: I. "Christus factus est": Rasch', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 9321 AND p.composer_id = 97
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:e065b047-30fe-4fa2-8136-4badaa8d1b78'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = '“Dormi Jesu, mater ridet”: Ruhig', part.name_en = '5 Canons, op. 16: II. “Dormi Jesu, mater ridet”: Ruhig',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 9321 AND p.composer_id = 97 AND part.part_key = 'musicbrainz:a7154c47-e45d-4cfb-ba5d-1259546ed450' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:a7154c47-e45d-4cfb-ba5d-1259546ed450', 2, 'II', '“Dormi Jesu, mater ridet”: Ruhig', '5 Canons, op. 16: II. “Dormi Jesu, mater ridet”: Ruhig', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 9321 AND p.composer_id = 97
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:a7154c47-e45d-4cfb-ba5d-1259546ed450'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = '"Crux fidelis": Langsam', part.name_en = '5 Canons, op. 16: III. "Crux fidelis": Langsam',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 9321 AND p.composer_id = 97 AND part.part_key = 'musicbrainz:ae44ff16-8643-4de8-9bf8-d8640c0fa251' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:ae44ff16-8643-4de8-9bf8-d8640c0fa251', 3, 'III', '"Crux fidelis": Langsam', '5 Canons, op. 16: III. "Crux fidelis": Langsam', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 9321 AND p.composer_id = 97
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:ae44ff16-8643-4de8-9bf8-d8640c0fa251'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = 'IV',
    part.name_ko = '"Asperges me, Domine": Sehr lebhaft', part.name_en = '5 Canons, op. 16: IV. "Asperges me, Domine": Sehr lebhaft',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 9321 AND p.composer_id = 97 AND part.part_key = 'musicbrainz:1244d105-0690-4670-991e-75795878fa95' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:1244d105-0690-4670-991e-75795878fa95', 4, 'IV', '"Asperges me, Domine": Sehr lebhaft', '5 Canons, op. 16: IV. "Asperges me, Domine": Sehr lebhaft', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 9321 AND p.composer_id = 97
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:1244d105-0690-4670-991e-75795878fa95'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 5, part.movement_number = 'V',
    part.name_ko = '"Crucem tuam adoramus, Domine"', part.name_en = '5 Canons, op. 16: V. "Crucem tuam adoramus, Domine"',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 9321 AND p.composer_id = 97 AND part.part_key = 'musicbrainz:11bb1848-5533-4ddc-bec8-d8456d18637a' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:11bb1848-5533-4ddc-bec8-d8456d18637a', 5, 'V', '"Crucem tuam adoramus, Domine"', '5 Canons, op. 16: V. "Crucem tuam adoramus, Domine"', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 9321 AND p.composer_id = 97
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:11bb1848-5533-4ddc-bec8-d8456d18637a'
);


-- Op. 10 5개의 관현악 소품

UPDATE pieces piece
SET piece.title = '5개의 관현악 소품', piece.title_en = '5 Pieces for Orchestra, op. 10',
    piece.type = 'album', piece.opus_number = 'Op. 10',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 7481 AND piece.composer_id = 97
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'Sehr ruhig und zart', part.name_en = '5 Pieces for Orchestra, op. 10: I. Sehr ruhig und zart',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 7481 AND p.composer_id = 97 AND part.part_key = 'musicbrainz:ce90c679-64bf-45cb-8c29-e599a90f89e5' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:ce90c679-64bf-45cb-8c29-e599a90f89e5', 1, 'I', 'Sehr ruhig und zart', '5 Pieces for Orchestra, op. 10: I. Sehr ruhig und zart', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 7481 AND p.composer_id = 97
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:ce90c679-64bf-45cb-8c29-e599a90f89e5'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'Lebhaft und zart bewegt', part.name_en = '5 Pieces for Orchestra, op. 10: II. Lebhaft und zart bewegt',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 7481 AND p.composer_id = 97 AND part.part_key = 'musicbrainz:b1f413ff-4f72-4a15-ae92-f5d5c4784e59' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:b1f413ff-4f72-4a15-ae92-f5d5c4784e59', 2, 'II', 'Lebhaft und zart bewegt', '5 Pieces for Orchestra, op. 10: II. Lebhaft und zart bewegt', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 7481 AND p.composer_id = 97
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:b1f413ff-4f72-4a15-ae92-f5d5c4784e59'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = 'Sehr langsam und äußerst ruhig', part.name_en = '5 Pieces for Orchestra, op. 10: III. Sehr langsam und äußerst ruhig',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 7481 AND p.composer_id = 97 AND part.part_key = 'musicbrainz:08241aad-b49d-4051-90b8-5b1281776c4f' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:08241aad-b49d-4051-90b8-5b1281776c4f', 3, 'III', 'Sehr langsam und äußerst ruhig', '5 Pieces for Orchestra, op. 10: III. Sehr langsam und äußerst ruhig', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 7481 AND p.composer_id = 97
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:08241aad-b49d-4051-90b8-5b1281776c4f'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = 'IV',
    part.name_ko = 'Fliessend, äußerst zart', part.name_en = '5 Pieces for Orchestra, op. 10: IV. Fliessend, äußerst zart',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 7481 AND p.composer_id = 97 AND part.part_key = 'musicbrainz:e417f0da-7d10-47f2-828b-fe7d57778ebb' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:e417f0da-7d10-47f2-828b-fe7d57778ebb', 4, 'IV', 'Fliessend, äußerst zart', '5 Pieces for Orchestra, op. 10: IV. Fliessend, äußerst zart', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 7481 AND p.composer_id = 97
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:e417f0da-7d10-47f2-828b-fe7d57778ebb'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 5, part.movement_number = 'V',
    part.name_ko = 'Sehr fließend', part.name_en = '5 Pieces for Orchestra, op. 10: V. Sehr fließend',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 7481 AND p.composer_id = 97 AND part.part_key = 'musicbrainz:debcd21b-d0e3-4c69-b11e-2d704d603c4f' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:debcd21b-d0e3-4c69-b11e-2d704d603c4f', 5, 'V', 'Sehr fließend', '5 Pieces for Orchestra, op. 10: V. Sehr fließend', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 7481 AND p.composer_id = 97
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:debcd21b-d0e3-4c69-b11e-2d704d603c4f'
);


-- Op. 15 5 Sacred Songs

UPDATE pieces piece
SET piece.title = '5 Sacred Songs', piece.title_en = '5 Sacred Songs, op. 15',
    piece.type = 'album', piece.opus_number = 'Op. 15',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 7786 AND piece.composer_id = 97
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = '"Das Kreuz, das mußt'' er tragen": Getragen', part.name_en = '5 Sacred Songs, op. 15: I. "Das Kreuz, das mußt'' er tragen": Getragen',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 7786 AND p.composer_id = 97 AND part.part_key = 'musicbrainz:3ea7d8fb-3d68-4a9f-b012-cb232334a8de' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:3ea7d8fb-3d68-4a9f-b012-cb232334a8de', 1, 'I', '"Das Kreuz, das mußt'' er tragen": Getragen', '5 Sacred Songs, op. 15: I. "Das Kreuz, das mußt'' er tragen": Getragen', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 7786 AND p.composer_id = 97
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:3ea7d8fb-3d68-4a9f-b012-cb232334a8de'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'Morgenlied: "Steht auf, ihr lieben Kinderlein": Zart bewegt', part.name_en = '5 Sacred Songs, op. 15: II. Morgenlied: "Steht auf, ihr lieben Kinderlein": Zart bewegt',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 7786 AND p.composer_id = 97 AND part.part_key = 'musicbrainz:0b4488e8-8d77-412e-9cfb-19aa135b3500' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:0b4488e8-8d77-412e-9cfb-19aa135b3500', 2, 'II', 'Morgenlied: "Steht auf, ihr lieben Kinderlein": Zart bewegt', '5 Sacred Songs, op. 15: II. Morgenlied: "Steht auf, ihr lieben Kinderlein": Zart bewegt', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 7786 AND p.composer_id = 97
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:0b4488e8-8d77-412e-9cfb-19aa135b3500'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = '"In Gottes Namen aufstehn": Gemächlich', part.name_en = '5 Sacred Songs, op. 15: III. "In Gottes Namen aufstehn": Gemächlich',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 7786 AND p.composer_id = 97 AND part.part_key = 'musicbrainz:70228458-c25a-4907-9a9b-8749210745d0' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:70228458-c25a-4907-9a9b-8749210745d0', 3, 'III', '"In Gottes Namen aufstehn": Gemächlich', '5 Sacred Songs, op. 15: III. "In Gottes Namen aufstehn": Gemächlich', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 7786 AND p.composer_id = 97
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:70228458-c25a-4907-9a9b-8749210745d0'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = 'IV',
    part.name_ko = '"Mein Weg geht jetzt vorüber": Sehr ruhig', part.name_en = '5 Sacred Songs, op. 15: IV. "Mein Weg geht jetzt vorüber": Sehr ruhig',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 7786 AND p.composer_id = 97 AND part.part_key = 'musicbrainz:04f72e21-0b4f-45eb-8856-70a733f0a602' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:04f72e21-0b4f-45eb-8856-70a733f0a602', 4, 'IV', '"Mein Weg geht jetzt vorüber": Sehr ruhig', '5 Sacred Songs, op. 15: IV. "Mein Weg geht jetzt vorüber": Sehr ruhig', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 7786 AND p.composer_id = 97
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:04f72e21-0b4f-45eb-8856-70a733f0a602'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 5, part.movement_number = 'V',
    part.name_ko = '"Fahr hin, o Seel'', zu deinem Gott": Doppelcanon in motu cantrario, fließend', part.name_en = '5 Sacred Songs, op. 15: V. "Fahr hin, o Seel'', zu deinem Gott": Doppelcanon in motu cantrario, fließend',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 7786 AND p.composer_id = 97 AND part.part_key = 'musicbrainz:49797b74-6472-47bf-ab17-cf0957cd68d3' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:49797b74-6472-47bf-ab17-cf0957cd68d3', 5, 'V', '"Fahr hin, o Seel'', zu deinem Gott": Doppelcanon in motu cantrario, fließend', '5 Sacred Songs, op. 15: V. "Fahr hin, o Seel'', zu deinem Gott": Doppelcanon in motu cantrario, fließend', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 7786 AND p.composer_id = 97
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:49797b74-6472-47bf-ab17-cf0957cd68d3'
);


-- Op. 3 5 Songs from "Der siebente Ring" by Stefan George

UPDATE pieces piece
SET piece.title = '5 Songs from "Der siebente Ring" by Stefan George', piece.title_en = '5 Songs from "Der siebente Ring" by Stefan George, op. 3',
    piece.type = 'album', piece.opus_number = 'Op. 3',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 7525 AND piece.composer_id = 97
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = '"Dies ist ein Lied"', part.name_en = '5 Songs from "Der siebente Ring" by Stefan George, op. 3: I. "Dies ist ein Lied"',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 7525 AND p.composer_id = 97 AND part.part_key = 'musicbrainz:e76ceb2f-0c9a-4d51-b6b9-6dbcd77a92a3' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:e76ceb2f-0c9a-4d51-b6b9-6dbcd77a92a3', 1, 'I', '"Dies ist ein Lied"', '5 Songs from "Der siebente Ring" by Stefan George, op. 3: I. "Dies ist ein Lied"', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 7525 AND p.composer_id = 97
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:e76ceb2f-0c9a-4d51-b6b9-6dbcd77a92a3'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = '"Im windes-weben"', part.name_en = '5 Songs from "Der siebente Ring" by Stefan George, op. 3: II. "Im windes-weben"',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 7525 AND p.composer_id = 97 AND part.part_key = 'musicbrainz:bc28e656-15d4-411a-8506-adbc009ff02b' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:bc28e656-15d4-411a-8506-adbc009ff02b', 2, 'II', '"Im windes-weben"', '5 Songs from "Der siebente Ring" by Stefan George, op. 3: II. "Im windes-weben"', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 7525 AND p.composer_id = 97
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:bc28e656-15d4-411a-8506-adbc009ff02b'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = '"An baches Ranft"', part.name_en = '5 Songs from "Der siebente Ring" by Stefan George, op. 3: III. "An baches Ranft"',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 7525 AND p.composer_id = 97 AND part.part_key = 'musicbrainz:bd22be84-034e-498b-85a9-078d45aeaf65' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:bd22be84-034e-498b-85a9-078d45aeaf65', 3, 'III', '"An baches Ranft"', '5 Songs from "Der siebente Ring" by Stefan George, op. 3: III. "An baches Ranft"', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 7525 AND p.composer_id = 97
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:bd22be84-034e-498b-85a9-078d45aeaf65'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = 'IV',
    part.name_ko = '"Im morgen-taun"', part.name_en = '5 Songs from "Der siebente Ring" by Stefan George, op. 3: IV. "Im morgen-taun"',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 7525 AND p.composer_id = 97 AND part.part_key = 'musicbrainz:b531ff3b-dbbb-4b5d-8493-d5e81b0cfde4' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:b531ff3b-dbbb-4b5d-8493-d5e81b0cfde4', 4, 'IV', '"Im morgen-taun"', '5 Songs from "Der siebente Ring" by Stefan George, op. 3: IV. "Im morgen-taun"', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 7525 AND p.composer_id = 97
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:b531ff3b-dbbb-4b5d-8493-d5e81b0cfde4'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 5, part.movement_number = 'V',
    part.name_ko = '"Kahl reckt der Baum"', part.name_en = '5 Songs from "Der siebente Ring" by Stefan George, op. 3: V. "Kahl reckt der Baum"',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 7525 AND p.composer_id = 97 AND part.part_key = 'musicbrainz:96ee8a90-fe94-4d46-af8a-55fe160bcaf8' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:96ee8a90-fe94-4d46-af8a-55fe160bcaf8', 5, 'V', '"Kahl reckt der Baum"', '5 Songs from "Der siebente Ring" by Stefan George, op. 3: V. "Kahl reckt der Baum"', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 7525 AND p.composer_id = 97
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:96ee8a90-fe94-4d46-af8a-55fe160bcaf8'
);


-- Op. 4 5 Songs on Poems by Stefan George

UPDATE pieces piece
SET piece.title = '5 Songs on Poems by Stefan George', piece.title_en = '5 Songs on Poems by Stefan George, op. 4',
    piece.type = 'album', piece.opus_number = 'Op. 4',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 8507 AND piece.composer_id = 97
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'Eingang', part.name_en = '5 Songs on Poems by Stefan George, op. 4: I. Eingang',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 8507 AND p.composer_id = 97 AND part.part_key = 'musicbrainz:53a0b72e-e3b8-4904-b99a-6a31d3a43b4a' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:53a0b72e-e3b8-4904-b99a-6a31d3a43b4a', 1, 'I', 'Eingang', '5 Songs on Poems by Stefan George, op. 4: I. Eingang', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 8507 AND p.composer_id = 97
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:53a0b72e-e3b8-4904-b99a-6a31d3a43b4a'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = '"Noch zwingt mich Treue über dir zu wachen"', part.name_en = '5 Songs on Poems by Stefan George, op. 4: II. "Noch zwingt mich Treue über dir zu wachen"',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 8507 AND p.composer_id = 97 AND part.part_key = 'musicbrainz:91189543-26ad-4554-a609-fab292ed32bd' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:91189543-26ad-4554-a609-fab292ed32bd', 2, 'II', '"Noch zwingt mich Treue über dir zu wachen"', '5 Songs on Poems by Stefan George, op. 4: II. "Noch zwingt mich Treue über dir zu wachen"', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 8507 AND p.composer_id = 97
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:91189543-26ad-4554-a609-fab292ed32bd'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = '"Ja heil und dank dir"', part.name_en = '5 Songs on Poems by Stefan George, op. 4: III. "Ja heil und dank dir"',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 8507 AND p.composer_id = 97 AND part.part_key = 'musicbrainz:d8c9c0c5-009a-45a7-8554-77bf93c5cd99' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:d8c9c0c5-009a-45a7-8554-77bf93c5cd99', 3, 'III', '"Ja heil und dank dir"', '5 Songs on Poems by Stefan George, op. 4: III. "Ja heil und dank dir"', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 8507 AND p.composer_id = 97
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:d8c9c0c5-009a-45a7-8554-77bf93c5cd99'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = 'IV',
    part.name_ko = '"So ich traurig bin"', part.name_en = '5 Songs on Poems by Stefan George, op. 4: IV. "So ich traurig bin"',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 8507 AND p.composer_id = 97 AND part.part_key = 'musicbrainz:86d39b18-316f-4c80-a9ab-f080108173b6' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:86d39b18-316f-4c80-a9ab-f080108173b6', 4, 'IV', '"So ich traurig bin"', '5 Songs on Poems by Stefan George, op. 4: IV. "So ich traurig bin"', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 8507 AND p.composer_id = 97
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:86d39b18-316f-4c80-a9ab-f080108173b6'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 5, part.movement_number = 'V',
    part.name_ko = '"Ihr tratet zu dem Herde"', part.name_en = '5 Songs on Poems by Stefan George, op. 4: V. "Ihr tratet zu dem Herde"',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 8507 AND p.composer_id = 97 AND part.part_key = 'musicbrainz:98be8e3d-22d9-4b02-a726-6bae2a4d55b5' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:98be8e3d-22d9-4b02-a726-6bae2a4d55b5', 5, 'V', '"Ihr tratet zu dem Herde"', '5 Songs on Poems by Stefan George, op. 4: V. "Ihr tratet zu dem Herde"', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 8507 AND p.composer_id = 97
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:98be8e3d-22d9-4b02-a726-6bae2a4d55b5'
);


-- Op. 14 6개의 가곡

UPDATE pieces piece
SET piece.title = '6개의 가곡', piece.title_en = '6 Songs, op. 14',
    piece.type = 'album', piece.opus_number = 'Op. 14',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 9223 AND piece.composer_id = 97
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'Die Sonne "Täglich kommt die gelbe Sonne": Ruhig fließend', part.name_en = '6 Songs, op. 14: I. Die Sonne "Täglich kommt die gelbe Sonne": Ruhig fließend',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 9223 AND p.composer_id = 97 AND part.part_key = 'musicbrainz:c10ade80-310d-431c-b489-4992df3e5183' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:c10ade80-310d-431c-b489-4992df3e5183', 1, 'I', 'Die Sonne "Täglich kommt die gelbe Sonne": Ruhig fließend', '6 Songs, op. 14: I. Die Sonne "Täglich kommt die gelbe Sonne": Ruhig fließend', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 9223 AND p.composer_id = 97
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:c10ade80-310d-431c-b489-4992df3e5183'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'Abendland I "Mond, als träte ein Totes": Sehr lebhaft', part.name_en = '6 Songs, op. 14: II. Abendland I "Mond, als träte ein Totes": Sehr lebhaft',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 9223 AND p.composer_id = 97 AND part.part_key = 'musicbrainz:b49e0231-155f-4bdb-9f14-7a5877d2b546' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:b49e0231-155f-4bdb-9f14-7a5877d2b546', 2, 'II', 'Abendland I "Mond, als träte ein Totes": Sehr lebhaft', '6 Songs, op. 14: II. Abendland I "Mond, als träte ein Totes": Sehr lebhaft', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 9223 AND p.composer_id = 97
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:b49e0231-155f-4bdb-9f14-7a5877d2b546'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = 'Abendland II "So leise sind die grünen Wälder": Langsam', part.name_en = '6 Songs, op. 14: III. Abendland II "So leise sind die grünen Wälder": Langsam',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 9223 AND p.composer_id = 97 AND part.part_key = 'musicbrainz:218a02ec-9885-4382-a821-97750c44b07b' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:218a02ec-9885-4382-a821-97750c44b07b', 3, 'III', 'Abendland II "So leise sind die grünen Wälder": Langsam', '6 Songs, op. 14: III. Abendland II "So leise sind die grünen Wälder": Langsam', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 9223 AND p.composer_id = 97
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:218a02ec-9885-4382-a821-97750c44b07b'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = 'IV',
    part.name_ko = 'Abendland III "Ihr großen Städte steinern aufgebaut": Langsam', part.name_en = '6 Songs, op. 14: IV. Abendland III "Ihr großen Städte steinern aufgebaut": Langsam',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 9223 AND p.composer_id = 97 AND part.part_key = 'musicbrainz:d93d6547-7a8e-4a4f-a13c-833a7833a9b6' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:d93d6547-7a8e-4a4f-a13c-833a7833a9b6', 4, 'IV', 'Abendland III "Ihr großen Städte steinern aufgebaut": Langsam', '6 Songs, op. 14: IV. Abendland III "Ihr großen Städte steinern aufgebaut": Langsam', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 9223 AND p.composer_id = 97
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:d93d6547-7a8e-4a4f-a13c-833a7833a9b6'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 5, part.movement_number = 'V',
    part.name_ko = 'Nachts "Die Bläue meiner Augen": Sehr lebhaft', part.name_en = '6 Songs, op. 14: V. Nachts "Die Bläue meiner Augen": Sehr lebhaft',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 9223 AND p.composer_id = 97 AND part.part_key = 'musicbrainz:faf022bd-add9-4e4a-b944-93734ffdc857' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:faf022bd-add9-4e4a-b944-93734ffdc857', 5, 'V', 'Nachts "Die Bläue meiner Augen": Sehr lebhaft', '6 Songs, op. 14: V. Nachts "Die Bläue meiner Augen": Sehr lebhaft', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 9223 AND p.composer_id = 97
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:faf022bd-add9-4e4a-b944-93734ffdc857'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 6, part.movement_number = 'VI',
    part.name_ko = 'Gesang einer gefangenen Amsel "Dunkler Odem im grünen Gezweig": Sehr fließende Achtel', part.name_en = '6 Songs, op. 14: VI. Gesang einer gefangenen Amsel "Dunkler Odem im grünen Gezweig": Sehr fließende Achtel',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 9223 AND p.composer_id = 97 AND part.part_key = 'musicbrainz:7698069e-40af-4fdf-9397-67af9988f215' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:7698069e-40af-4fdf-9397-67af9988f215', 6, 'VI', 'Gesang einer gefangenen Amsel "Dunkler Odem im grünen Gezweig": Sehr fließende Achtel', '6 Songs, op. 14: VI. Gesang einer gefangenen Amsel "Dunkler Odem im grünen Gezweig": Sehr fließende Achtel', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 9223 AND p.composer_id = 97
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:7698069e-40af-4fdf-9397-67af9988f215'
);


-- None Camptown Races in Memoriam A. S.

UPDATE pieces piece
SET piece.title = 'Camptown Races in Memoriam A. S.', piece.title_en = 'Camptown Races in Memoriam A. S.',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 8968 AND piece.composer_id = 97
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- Op. 29 칸타타 1번

UPDATE pieces piece
SET piece.title = '칸타타 1번', piece.title_en = 'Cantata no. 1, op. 29',
    piece.type = 'album', piece.opus_number = 'Op. 29',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 9826 AND piece.composer_id = 97
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = '"Zündender Lichtblitz des Lebens": Getragen - lebhaft', part.name_en = 'Cantata no. 1, op. 29: I. "Zündender Lichtblitz des Lebens": Getragen - lebhaft',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 9826 AND p.composer_id = 97 AND part.part_key = 'musicbrainz:2ac7b945-144a-4feb-9969-ac36e51e61a0' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:2ac7b945-144a-4feb-9969-ac36e51e61a0', 1, 'I', '"Zündender Lichtblitz des Lebens": Getragen - lebhaft', 'Cantata no. 1, op. 29: I. "Zündender Lichtblitz des Lebens": Getragen - lebhaft', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 9826 AND p.composer_id = 97
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:2ac7b945-144a-4feb-9969-ac36e51e61a0'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = '"Kleiner Flügel Ahornsamen": Leicht bewegt', part.name_en = 'Cantata no. 1, op. 29: II. "Kleiner Flügel Ahornsamen": Leicht bewegt',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 9826 AND p.composer_id = 97 AND part.part_key = 'musicbrainz:88f1a739-91cd-4313-ba33-d7b884cad8b6' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:88f1a739-91cd-4313-ba33-d7b884cad8b6', 2, 'II', '"Kleiner Flügel Ahornsamen": Leicht bewegt', 'Cantata no. 1, op. 29: II. "Kleiner Flügel Ahornsamen": Leicht bewegt', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 9826 AND p.composer_id = 97
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:88f1a739-91cd-4313-ba33-d7b884cad8b6'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = '"Tönen die seligen Saiten": Ruhig', part.name_en = 'Cantata no. 1, op. 29: III. "Tönen die seligen Saiten": Ruhig',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 9826 AND p.composer_id = 97 AND part.part_key = 'musicbrainz:54a44239-2f52-47d4-b689-5ce7463c867e' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:54a44239-2f52-47d4-b689-5ce7463c867e', 3, 'III', '"Tönen die seligen Saiten": Ruhig', 'Cantata no. 1, op. 29: III. "Tönen die seligen Saiten": Ruhig', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 9826 AND p.composer_id = 97
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:54a44239-2f52-47d4-b689-5ce7463c867e'
);


-- Op. 31 칸타타 2번

UPDATE pieces piece
SET piece.title = '칸타타 2번', piece.title_en = 'Cantata no. 2, op. 31',
    piece.type = 'album', piece.opus_number = 'Op. 31',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 10382 AND piece.composer_id = 97
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = '"Schweigt auch die Welt": Sehr lebhaft - ruhig', part.name_en = 'Cantata no. 2, op. 31: I. "Schweigt auch die Welt": Sehr lebhaft - ruhig',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 10382 AND p.composer_id = 97 AND part.part_key = 'musicbrainz:ce9b1cb9-687c-47c1-9389-d6b5bd5649ff' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:ce9b1cb9-687c-47c1-9389-d6b5bd5649ff', 1, 'I', '"Schweigt auch die Welt": Sehr lebhaft - ruhig', 'Cantata no. 2, op. 31: I. "Schweigt auch die Welt": Sehr lebhaft - ruhig', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 10382 AND p.composer_id = 97
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:ce9b1cb9-687c-47c1-9389-d6b5bd5649ff'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = '"Sehr tief verhalten innerst Leben": Sehr verhalten', part.name_en = 'Cantata no. 2, op. 31: II. "Sehr tief verhalten innerst Leben": Sehr verhalten',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 10382 AND p.composer_id = 97 AND part.part_key = 'musicbrainz:19703573-7883-44e8-bbda-bde95a21c034' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:19703573-7883-44e8-bbda-bde95a21c034', 2, 'II', '"Sehr tief verhalten innerst Leben": Sehr verhalten', 'Cantata no. 2, op. 31: II. "Sehr tief verhalten innerst Leben": Sehr verhalten', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 10382 AND p.composer_id = 97
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:19703573-7883-44e8-bbda-bde95a21c034'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = '"Schöpfen aus Brunnen des Himmels": Sehr bewegt', part.name_en = 'Cantata no. 2, op. 31: III. "Schöpfen aus Brunnen des Himmels": Sehr bewegt',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 10382 AND p.composer_id = 97 AND part.part_key = 'musicbrainz:be4142d4-3524-4438-8fea-3c42a33e272d' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:be4142d4-3524-4438-8fea-3c42a33e272d', 3, 'III', '"Schöpfen aus Brunnen des Himmels": Sehr bewegt', 'Cantata no. 2, op. 31: III. "Schöpfen aus Brunnen des Himmels": Sehr bewegt', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 10382 AND p.composer_id = 97
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:be4142d4-3524-4438-8fea-3c42a33e272d'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = 'IV',
    part.name_ko = '"Leichteste Bürde der Bäume": Sehr lebhaft', part.name_en = 'Cantata no. 2, op. 31: IV. "Leichteste Bürde der Bäume": Sehr lebhaft',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 10382 AND p.composer_id = 97 AND part.part_key = 'musicbrainz:ab1b9e3a-255b-4795-87b8-d89d0c57e432' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:ab1b9e3a-255b-4795-87b8-d89d0c57e432', 4, 'IV', '"Leichteste Bürde der Bäume": Sehr lebhaft', 'Cantata no. 2, op. 31: IV. "Leichteste Bürde der Bäume": Sehr lebhaft', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 10382 AND p.composer_id = 97
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:ab1b9e3a-255b-4795-87b8-d89d0c57e432'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 5, part.movement_number = 'V',
    part.name_ko = '"Feindselig ist das Wort": Sehr mäßig', part.name_en = 'Cantata no. 2, op. 31: V. "Feindselig ist das Wort": Sehr mäßig',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 10382 AND p.composer_id = 97 AND part.part_key = 'musicbrainz:e93269cc-84bd-4133-922b-391ba0a9b501' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:e93269cc-84bd-4133-922b-391ba0a9b501', 5, 'V', '"Feindselig ist das Wort": Sehr mäßig', 'Cantata no. 2, op. 31: V. "Feindselig ist das Wort": Sehr mäßig', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 10382 AND p.composer_id = 97
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:e93269cc-84bd-4133-922b-391ba0a9b501'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 6, part.movement_number = 'VI',
    part.name_ko = '"Gelockert aus dem Schoße": Sehr fließend', part.name_en = 'Cantata no. 2, op. 31: VI. "Gelockert aus dem Schoße": Sehr fließend',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 10382 AND p.composer_id = 97 AND part.part_key = 'musicbrainz:bf8bf39f-fdfb-4915-808c-85b48ff4b6d9' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:bf8bf39f-fdfb-4915-808c-85b48ff4b6d9', 6, 'VI', '"Gelockert aus dem Schoße": Sehr fließend', 'Cantata no. 2, op. 31: VI. "Gelockert aus dem Schoße": Sehr fließend', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 10382 AND p.composer_id = 97
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:bf8bf39f-fdfb-4915-808c-85b48ff4b6d9'
);


-- Op. 24 협주곡

UPDATE pieces piece
SET piece.title = '협주곡', piece.title_en = 'Concerto, op. 24',
    piece.type = 'album', piece.opus_number = 'Op. 24',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 8723 AND piece.composer_id = 97
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'Etwas lebhaft', part.name_en = 'Concerto, op. 24: I. Etwas lebhaft',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 8723 AND p.composer_id = 97 AND part.part_key = 'musicbrainz:da43372f-3ab5-4ee4-a755-3c9670512e76' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:da43372f-3ab5-4ee4-a755-3c9670512e76', 1, 'I', 'Etwas lebhaft', 'Concerto, op. 24: I. Etwas lebhaft', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 8723 AND p.composer_id = 97
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:da43372f-3ab5-4ee4-a755-3c9670512e76'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'Sehr langsam', part.name_en = 'Concerto, op. 24: II. Sehr langsam',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 8723 AND p.composer_id = 97 AND part.part_key = 'musicbrainz:94cc9395-5a37-4cd2-bae3-97cbfd1fef1d' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:94cc9395-5a37-4cd2-bae3-97cbfd1fef1d', 2, 'II', 'Sehr langsam', 'Concerto, op. 24: II. Sehr langsam', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 8723 AND p.composer_id = 97
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:94cc9395-5a37-4cd2-bae3-97cbfd1fef1d'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = 'Sehr rasch', part.name_en = 'Concerto, op. 24: III. Sehr rasch',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 8723 AND p.composer_id = 97 AND part.part_key = 'musicbrainz:e9f62f93-18f2-453c-a728-ccbf33c70467' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:e9f62f93-18f2-453c-a728-ccbf33c70467', 3, 'III', 'Sehr rasch', 'Concerto, op. 24: III. Sehr rasch', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 8723 AND p.composer_id = 97
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:e9f62f93-18f2-453c-a728-ccbf33c70467'
);


-- Op. 5 Five Movements for String Quartet

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'Heftig bewegt', part.name_en = 'Five Movements for String Quartet, op. 5: I. Heftig bewegt',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 368 AND p.composer_id = 97 AND part.part_key = 'musicbrainz:3a41e341-8ede-461b-aeab-94ea3d0d660a' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:3a41e341-8ede-461b-aeab-94ea3d0d660a', 1, 'I', 'Heftig bewegt', 'Five Movements for String Quartet, op. 5: I. Heftig bewegt', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 368 AND p.composer_id = 97
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:3a41e341-8ede-461b-aeab-94ea3d0d660a'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'Sehr langsam', part.name_en = 'Five Movements for String Quartet, op. 5: II. Sehr langsam',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 368 AND p.composer_id = 97 AND part.part_key = 'musicbrainz:807b4697-076b-4569-afae-c3f22f246c15' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:807b4697-076b-4569-afae-c3f22f246c15', 2, 'II', 'Sehr langsam', 'Five Movements for String Quartet, op. 5: II. Sehr langsam', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 368 AND p.composer_id = 97
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:807b4697-076b-4569-afae-c3f22f246c15'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = 'Sehr bewegt', part.name_en = 'Five Movements for String Quartet, op. 5: III. Sehr bewegt',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 368 AND p.composer_id = 97 AND part.part_key = 'musicbrainz:8e05b5cb-7f99-437e-9fcb-92492c2df4fd' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:8e05b5cb-7f99-437e-9fcb-92492c2df4fd', 3, 'III', 'Sehr bewegt', 'Five Movements for String Quartet, op. 5: III. Sehr bewegt', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 368 AND p.composer_id = 97
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:8e05b5cb-7f99-437e-9fcb-92492c2df4fd'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = 'IV',
    part.name_ko = 'Sehr langsam', part.name_en = 'Five Movements for String Quartet, op. 5: IV. Sehr langsam',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 368 AND p.composer_id = 97 AND part.part_key = 'musicbrainz:dd1cac0d-ad6d-49c5-b558-34370bfa2aa1' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:dd1cac0d-ad6d-49c5-b558-34370bfa2aa1', 4, 'IV', 'Sehr langsam', 'Five Movements for String Quartet, op. 5: IV. Sehr langsam', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 368 AND p.composer_id = 97
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:dd1cac0d-ad6d-49c5-b558-34370bfa2aa1'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 5, part.movement_number = 'V',
    part.name_ko = 'In zarter Bewegung', part.name_en = 'Five Movements for String Quartet, op. 5: V. In zarter Bewegung',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 368 AND p.composer_id = 97 AND part.part_key = 'musicbrainz:4d5a3240-5dae-4aed-b818-fac7fcdda31f' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:4d5a3240-5dae-4aed-b818-fac7fcdda31f', 5, 'V', 'In zarter Bewegung', 'Five Movements for String Quartet, op. 5: V. In zarter Bewegung', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 368 AND p.composer_id = 97
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:4d5a3240-5dae-4aed-b818-fac7fcdda31f'
);


-- Op. 7 4개의 바이올린과 피아노를 위한 소품

UPDATE pieces piece
SET piece.title = '4개의 바이올린과 피아노를 위한 소품', piece.title_en = 'Four Pieces for Violin and Piano, op. 7',
    piece.type = 'album', piece.opus_number = 'Op. 7',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 7496 AND piece.composer_id = 97
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'Sehr langsam', part.name_en = 'Four Pieces for Violin and Piano, op. 7: I. Sehr langsam',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 7496 AND p.composer_id = 97 AND part.part_key = 'musicbrainz:3851d71c-3bce-3c7a-838d-d0959be633ad' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:3851d71c-3bce-3c7a-838d-d0959be633ad', 1, 'I', 'Sehr langsam', 'Four Pieces for Violin and Piano, op. 7: I. Sehr langsam', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 7496 AND p.composer_id = 97
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:3851d71c-3bce-3c7a-838d-d0959be633ad'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'Rasch', part.name_en = 'Four Pieces for Violin and Piano, op. 7: II. Rasch',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 7496 AND p.composer_id = 97 AND part.part_key = 'musicbrainz:f9bc7bc1-6d09-3c58-935f-079d3d76c6b5' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:f9bc7bc1-6d09-3c58-935f-079d3d76c6b5', 2, 'II', 'Rasch', 'Four Pieces for Violin and Piano, op. 7: II. Rasch', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 7496 AND p.composer_id = 97
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:f9bc7bc1-6d09-3c58-935f-079d3d76c6b5'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = 'Sehr langsam', part.name_en = 'Four Pieces for Violin and Piano, op. 7: III. Sehr langsam',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 7496 AND p.composer_id = 97 AND part.part_key = 'musicbrainz:fbfb3d69-768f-3989-8a68-20e87adb7eb7' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:fbfb3d69-768f-3989-8a68-20e87adb7eb7', 3, 'III', 'Sehr langsam', 'Four Pieces for Violin and Piano, op. 7: III. Sehr langsam', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 7496 AND p.composer_id = 97
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:fbfb3d69-768f-3989-8a68-20e87adb7eb7'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = 'IV',
    part.name_ko = 'Bewegt', part.name_en = 'Four Pieces for Violin and Piano, op. 7: IV. Bewegt',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 7496 AND p.composer_id = 97 AND part.part_key = 'musicbrainz:98cd9def-9db8-3ef9-b3df-9815adc8b2f3' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:98cd9def-9db8-3ef9-b3df-9815adc8b2f3', 4, 'IV', 'Bewegt', 'Four Pieces for Violin and Piano, op. 7: IV. Bewegt', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 7496 AND p.composer_id = 97
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:98cd9def-9db8-3ef9-b3df-9815adc8b2f3'
);


-- None Im Sommerwind, Idyll for large orchestra

UPDATE pieces piece
SET piece.title = 'Im Sommerwind, Idyll for large orchestra', piece.title_en = 'Im Sommerwind, Idyll for large orchestra',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 10009 AND piece.composer_id = 97
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Kinderstück

UPDATE pieces piece
SET piece.title = 'Kinderstück', piece.title_en = 'Kinderstück',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 10073 AND piece.composer_id = 97
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Klavierstück, op. posth.

UPDATE pieces piece
SET piece.title = 'Klavierstück, op. posth.', piece.title_en = 'Klavierstück, op. posth.',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 8163 AND piece.composer_id = 97
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- Op. 1 Passacaglia for Orchestra

UPDATE pieces piece
SET piece.title = 'Passacaglia for Orchestra', piece.title_en = 'Passacaglia for Orchestra, op. 1',
    piece.type = 'song', piece.opus_number = 'Op. 1',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 9979 AND piece.composer_id = 97
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- Op. 22 바이올린 4중주

UPDATE pieces piece
SET piece.title = '바이올린 4중주', piece.title_en = 'Quartet for violin, clarinet, tenor saxophone and piano, op. 22',
    piece.type = 'album', piece.opus_number = 'Op. 22',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 8162 AND piece.composer_id = 97
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'Sehr mäßig', part.name_en = 'Quartet for violin, clarinet, tenor saxophone and piano, op. 22: I. Sehr mäßig',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 8162 AND p.composer_id = 97 AND part.part_key = 'musicbrainz:3b0dd0ed-e5d2-4451-9dfb-ee598f8529b4' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:3b0dd0ed-e5d2-4451-9dfb-ee598f8529b4', 1, 'I', 'Sehr mäßig', 'Quartet for violin, clarinet, tenor saxophone and piano, op. 22: I. Sehr mäßig', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 8162 AND p.composer_id = 97
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:3b0dd0ed-e5d2-4451-9dfb-ee598f8529b4'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'Sehr schwungvoll', part.name_en = 'Quartet for violin, clarinet, tenor saxophone and piano, op. 22: II. Sehr schwungvoll',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 8162 AND p.composer_id = 97 AND part.part_key = 'musicbrainz:1074a0b4-a6fb-47e4-aa0c-3b475d7d4758' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:1074a0b4-a6fb-47e4-aa0c-3b475d7d4758', 2, 'II', 'Sehr schwungvoll', 'Quartet for violin, clarinet, tenor saxophone and piano, op. 22: II. Sehr schwungvoll', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 8162 AND p.composer_id = 97
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:1074a0b4-a6fb-47e4-aa0c-3b475d7d4758'
);


-- None Rondo for String Quartet, op. post.

UPDATE pieces piece
SET piece.title = 'Rondo for String Quartet, op. post.', piece.title_en = 'Rondo for String Quartet, op. post.',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 8750 AND piece.composer_id = 97
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Satz für Klavier

UPDATE pieces piece
SET piece.title = 'Satz für Klavier', piece.title_en = 'Satz für Klavier',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 10743 AND piece.composer_id = 97
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- Op. 9 6개의 바가텔

UPDATE pieces piece
SET piece.title = '6개의 바가텔', piece.title_en = 'Six Bagatelles for String Quartet, op. 9',
    piece.type = 'album', piece.opus_number = 'Op. 9',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 8822 AND piece.composer_id = 97
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'Mäßig', part.name_en = 'Six Bagatelles for String Quartet, op. 9: I. Mäßig',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 8822 AND p.composer_id = 97 AND part.part_key = 'musicbrainz:50a64db0-c829-41b7-8172-dc1879ff7323' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:50a64db0-c829-41b7-8172-dc1879ff7323', 1, 'I', 'Mäßig', 'Six Bagatelles for String Quartet, op. 9: I. Mäßig', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 8822 AND p.composer_id = 97
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:50a64db0-c829-41b7-8172-dc1879ff7323'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'Leicht bewegt', part.name_en = 'Six Bagatelles for String Quartet, op. 9: II. Leicht bewegt',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 8822 AND p.composer_id = 97 AND part.part_key = 'musicbrainz:7510c3b3-157a-48c6-a785-7a61e7a1e464' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:7510c3b3-157a-48c6-a785-7a61e7a1e464', 2, 'II', 'Leicht bewegt', 'Six Bagatelles for String Quartet, op. 9: II. Leicht bewegt', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 8822 AND p.composer_id = 97
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:7510c3b3-157a-48c6-a785-7a61e7a1e464'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = 'Ziemlich fließend', part.name_en = 'Six Bagatelles for String Quartet, op. 9: III. Ziemlich fließend',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 8822 AND p.composer_id = 97 AND part.part_key = 'musicbrainz:fc82d6a0-5504-40f4-92e1-6f5eeff96332' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:fc82d6a0-5504-40f4-92e1-6f5eeff96332', 3, 'III', 'Ziemlich fließend', 'Six Bagatelles for String Quartet, op. 9: III. Ziemlich fließend', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 8822 AND p.composer_id = 97
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:fc82d6a0-5504-40f4-92e1-6f5eeff96332'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = 'IV',
    part.name_ko = 'Sehr langsam', part.name_en = 'Six Bagatelles for String Quartet, op. 9: IV. Sehr langsam',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 8822 AND p.composer_id = 97 AND part.part_key = 'musicbrainz:0e0e4423-e215-4196-95d0-aa6e6989198b' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:0e0e4423-e215-4196-95d0-aa6e6989198b', 4, 'IV', 'Sehr langsam', 'Six Bagatelles for String Quartet, op. 9: IV. Sehr langsam', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 8822 AND p.composer_id = 97
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:0e0e4423-e215-4196-95d0-aa6e6989198b'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 5, part.movement_number = 'V',
    part.name_ko = 'Äußerst langsam', part.name_en = 'Six Bagatelles for String Quartet, op. 9: V. Äußerst langsam',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 8822 AND p.composer_id = 97 AND part.part_key = 'musicbrainz:38465e3a-0915-49c5-9f69-9863841a8518' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:38465e3a-0915-49c5-9f69-9863841a8518', 5, 'V', 'Äußerst langsam', 'Six Bagatelles for String Quartet, op. 9: V. Äußerst langsam', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 8822 AND p.composer_id = 97
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:38465e3a-0915-49c5-9f69-9863841a8518'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 6, part.movement_number = 'VI',
    part.name_ko = 'Fließend', part.name_en = 'Six Bagatelles for String Quartet, op. 9: VI. Fließend',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 8822 AND p.composer_id = 97 AND part.part_key = 'musicbrainz:c9fcab6b-7116-4fa8-8ec4-64e270a0e5e8' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:c9fcab6b-7116-4fa8-8ec4-64e270a0e5e8', 6, 'VI', 'Fließend', 'Six Bagatelles for String Quartet, op. 9: VI. Fließend', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 8822 AND p.composer_id = 97
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:c9fcab6b-7116-4fa8-8ec4-64e270a0e5e8'
);


-- Op. 6 6개의 관현악 소품

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'Etwas bewegte Achtel', part.name_en = 'Six Pieces for Orchestra, op. 6: I. Etwas bewegte Achtel',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 369 AND p.composer_id = 97 AND part.part_key = 'musicbrainz:de6ed076-3a65-4028-889b-524d339403d8' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:de6ed076-3a65-4028-889b-524d339403d8', 1, 'I', 'Etwas bewegte Achtel', 'Six Pieces for Orchestra, op. 6: I. Etwas bewegte Achtel', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 369 AND p.composer_id = 97
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:de6ed076-3a65-4028-889b-524d339403d8'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'Bewegt', part.name_en = 'Six Pieces for Orchestra, op. 6: II. Bewegt',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 369 AND p.composer_id = 97 AND part.part_key = 'musicbrainz:1b517028-2bc5-4bb7-b5e0-d90c17ea7469' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:1b517028-2bc5-4bb7-b5e0-d90c17ea7469', 2, 'II', 'Bewegt', 'Six Pieces for Orchestra, op. 6: II. Bewegt', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 369 AND p.composer_id = 97
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:1b517028-2bc5-4bb7-b5e0-d90c17ea7469'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = 'Zart bewegt', part.name_en = 'Six Pieces for Orchestra, op. 6: III. Zart bewegt',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 369 AND p.composer_id = 97 AND part.part_key = 'musicbrainz:0ec43801-b204-4955-8feb-c359baabd942' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:0ec43801-b204-4955-8feb-c359baabd942', 3, 'III', 'Zart bewegt', 'Six Pieces for Orchestra, op. 6: III. Zart bewegt', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 369 AND p.composer_id = 97
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:0ec43801-b204-4955-8feb-c359baabd942'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = 'IV',
    part.name_ko = 'Langsam', part.name_en = 'Six Pieces for Orchestra, op. 6: IV. Langsam',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 369 AND p.composer_id = 97 AND part.part_key = 'musicbrainz:7e09df29-50c9-4480-a484-1ce3a8dcbcf2' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:7e09df29-50c9-4480-a484-1ce3a8dcbcf2', 4, 'IV', 'Langsam', 'Six Pieces for Orchestra, op. 6: IV. Langsam', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 369 AND p.composer_id = 97
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:7e09df29-50c9-4480-a484-1ce3a8dcbcf2'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 5, part.movement_number = 'V',
    part.name_ko = 'Sehr langsam', part.name_en = 'Six Pieces for Orchestra, op. 6: V. Sehr langsam',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 369 AND p.composer_id = 97 AND part.part_key = 'musicbrainz:5b456e4c-73cf-4436-8bf0-6ca32f1b4c4b' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:5b456e4c-73cf-4436-8bf0-6ca32f1b4c4b', 5, 'V', 'Sehr langsam', 'Six Pieces for Orchestra, op. 6: V. Sehr langsam', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 369 AND p.composer_id = 97
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:5b456e4c-73cf-4436-8bf0-6ca32f1b4c4b'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 6, part.movement_number = 'VI',
    part.name_ko = 'Zart bewegt', part.name_en = 'Six Pieces for Orchestra, op. 6: VI. Zart bewegt',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 369 AND p.composer_id = 97 AND part.part_key = 'musicbrainz:d6689feb-9f27-4455-891f-a953592d9940' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:d6689feb-9f27-4455-891f-a953592d9940', 6, 'VI', 'Zart bewegt', 'Six Pieces for Orchestra, op. 6: VI. Zart bewegt', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 369 AND p.composer_id = 97
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:d6689feb-9f27-4455-891f-a953592d9940'
);


-- None Slow Movement for String Quartet, op. post.

UPDATE pieces piece
SET piece.title = 'Slow Movement for String Quartet, op. post.', piece.title_en = 'Slow Movement for String Quartet, op. post.',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 8439 AND piece.composer_id = 97
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None 첼로와 피아노를 위한 소나타

UPDATE pieces piece
SET piece.title = '첼로와 피아노를 위한 소나타', piece.title_en = 'Sonata for Cello and Piano, op. post.',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 10137 AND piece.composer_id = 97
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Sonatensatz (Rondo) für Klavier

UPDATE pieces piece
SET piece.title = 'Sonatensatz (Rondo) für Klavier', piece.title_en = 'Sonatensatz (Rondo) für Klavier',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 11148 AND piece.composer_id = 97
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- Op. 28 현악 4중주

UPDATE pieces piece
SET piece.title = '현악 4중주', piece.title_en = 'String Quartet, op. 28',
    piece.type = 'album', piece.opus_number = 'Op. 28',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 10245 AND piece.composer_id = 97
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'Mäßig', part.name_en = 'String Quartet, op. 28: I. Mäßig',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 10245 AND p.composer_id = 97 AND part.part_key = 'musicbrainz:9c4aa98f-e7e9-4631-97de-39bc1040f3b9' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:9c4aa98f-e7e9-4631-97de-39bc1040f3b9', 1, 'I', 'Mäßig', 'String Quartet, op. 28: I. Mäßig', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 10245 AND p.composer_id = 97
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:9c4aa98f-e7e9-4631-97de-39bc1040f3b9'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'Gemächlich - Bewegt', part.name_en = 'String Quartet, op. 28: II. Gemächlich - Bewegt',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 10245 AND p.composer_id = 97 AND part.part_key = 'musicbrainz:33030521-3590-4e7b-b4e8-3a5927ad92ea' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:33030521-3590-4e7b-b4e8-3a5927ad92ea', 2, 'II', 'Gemächlich - Bewegt', 'String Quartet, op. 28: II. Gemächlich - Bewegt', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 10245 AND p.composer_id = 97
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:33030521-3590-4e7b-b4e8-3a5927ad92ea'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = 'Sehr fließend', part.name_en = 'String Quartet, op. 28: III. Sehr fließend',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 10245 AND p.composer_id = 97 AND part.part_key = 'musicbrainz:4f89c74e-77b4-40ce-96d4-cb84aff75b85' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:4f89c74e-77b4-40ce-96d4-cb84aff75b85', 3, 'III', 'Sehr fließend', 'String Quartet, op. 28: III. Sehr fließend', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 10245 AND p.composer_id = 97
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:4f89c74e-77b4-40ce-96d4-cb84aff75b85'
);


-- None String Quartet, op. post.

UPDATE pieces piece
SET piece.title = 'String Quartet, op. post.', piece.title_en = 'String Quartet, op. post.',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 11119 AND piece.composer_id = 97
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- Op. 20 현악 3중주

UPDATE pieces piece
SET piece.title = '현악 3중주', piece.title_en = 'String Trio, op. 20',
    piece.type = 'album', piece.opus_number = 'Op. 20',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 9630 AND piece.composer_id = 97
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'Sehr langsam', part.name_en = 'String Trio, op. 20: I. Sehr langsam',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 9630 AND p.composer_id = 97 AND part.part_key = 'musicbrainz:c21ee494-546e-4ebf-8e8a-a4bd241a96be' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:c21ee494-546e-4ebf-8e8a-a4bd241a96be', 1, 'I', 'Sehr langsam', 'String Trio, op. 20: I. Sehr langsam', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 9630 AND p.composer_id = 97
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:c21ee494-546e-4ebf-8e8a-a4bd241a96be'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'Sehr getragen und ausdrucksvoll - Zart bewegt', part.name_en = 'String Trio, op. 20: II. Sehr getragen und ausdrucksvoll - Zart bewegt',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 9630 AND p.composer_id = 97 AND part.part_key = 'musicbrainz:6f36312e-a083-46fa-8d16-b61e387149c3' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:6f36312e-a083-46fa-8d16-b61e387149c3', 2, 'II', 'Sehr getragen und ausdrucksvoll - Zart bewegt', 'String Trio, op. 20: II. Sehr getragen und ausdrucksvoll - Zart bewegt', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 9630 AND p.composer_id = 97
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:6f36312e-a083-46fa-8d16-b61e387149c3'
);


-- Op. 21 교향곡

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'Ruhig schreitend', part.name_en = 'Symphony, op. 21: I. Ruhig schreitend',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 367 AND p.composer_id = 97 AND part.part_key = 'musicbrainz:c0a3ec6b-896f-4d4f-ae75-6da1cc5810d3' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:c0a3ec6b-896f-4d4f-ae75-6da1cc5810d3', 1, 'I', 'Ruhig schreitend', 'Symphony, op. 21: I. Ruhig schreitend', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 367 AND p.composer_id = 97
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:c0a3ec6b-896f-4d4f-ae75-6da1cc5810d3'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'Variationen', part.name_en = 'Symphony, op. 21: II. Variationen',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 367 AND p.composer_id = 97 AND part.part_key = 'musicbrainz:3066b86e-7862-4f6f-abec-8e8abc8cb09b' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:3066b86e-7862-4f6f-abec-8e8abc8cb09b', 2, 'II', 'Variationen', 'Symphony, op. 21: II. Variationen', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 367 AND p.composer_id = 97
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:3066b86e-7862-4f6f-abec-8e8abc8cb09b'
);


-- Op. 11 Three Little Pieces

UPDATE pieces piece
SET piece.title = 'Three Little Pieces', piece.title_en = 'Three Little Pieces, op. 11',
    piece.type = 'album', piece.opus_number = 'Op. 11',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 7563 AND piece.composer_id = 97
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'Moderate quavers', part.name_en = 'Three Little Pieces, op. 11: I. Moderate quavers',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 7563 AND p.composer_id = 97 AND part.part_key = 'musicbrainz:87c91608-0134-3095-bfd9-43a5d1bae6ae' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:87c91608-0134-3095-bfd9-43a5d1bae6ae', 1, 'I', 'Moderate quavers', 'Three Little Pieces, op. 11: I. Moderate quavers', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 7563 AND p.composer_id = 97
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:87c91608-0134-3095-bfd9-43a5d1bae6ae'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'Very fast', part.name_en = 'Three Little Pieces, op. 11: II. Very fast',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 7563 AND p.composer_id = 97 AND part.part_key = 'musicbrainz:411f83d2-6561-38a9-abad-d919c0972dba' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:411f83d2-6561-38a9-abad-d919c0972dba', 2, 'II', 'Very fast', 'Three Little Pieces, op. 11: II. Very fast', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 7563 AND p.composer_id = 97
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:411f83d2-6561-38a9-abad-d919c0972dba'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = 'Extremely peaceful', part.name_en = 'Three Little Pieces, op. 11: III. Extremely peaceful',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 7563 AND p.composer_id = 97 AND part.part_key = 'musicbrainz:16c66585-3703-36a1-aa85-1ed5a50352b0' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:16c66585-3703-36a1-aa85-1ed5a50352b0', 3, 'III', 'Extremely peaceful', 'Three Little Pieces, op. 11: III. Extremely peaceful', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 7563 AND p.composer_id = 97
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:16c66585-3703-36a1-aa85-1ed5a50352b0'
);


-- None 3개의 소품

UPDATE pieces piece
SET piece.title = '3개의 소품', piece.title_en = 'Three Pieces for String Quartet',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 7523 AND piece.composer_id = 97
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'Bewegt', part.name_en = 'Three Pieces for String Quartet: I. Bewegt',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 7523 AND p.composer_id = 97 AND part.part_key = 'musicbrainz:e0f61e63-4a6e-43f0-aa11-e6fa794558c5' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:e0f61e63-4a6e-43f0-aa11-e6fa794558c5', 1, 'I', 'Bewegt', 'Three Pieces for String Quartet: I. Bewegt', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 7523 AND p.composer_id = 97
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:e0f61e63-4a6e-43f0-aa11-e6fa794558c5'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'Langsam', part.name_en = 'Three Pieces for String Quartet: II. Langsam',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 7523 AND p.composer_id = 97 AND part.part_key = 'musicbrainz:0b02ff47-66b5-48b0-aea9-283ec8c10fe2' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:0b02ff47-66b5-48b0-aea9-283ec8c10fe2', 2, 'II', 'Langsam', 'Three Pieces for String Quartet: II. Langsam', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 7523 AND p.composer_id = 97
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:0b02ff47-66b5-48b0-aea9-283ec8c10fe2'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = 'Nicht zu langsam', part.name_en = 'Three Pieces for String Quartet: III. Nicht zu langsam',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 7523 AND p.composer_id = 97 AND part.part_key = 'musicbrainz:7fdc9a1c-b21a-4a8c-88ff-e727cd6e33c4' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:7fdc9a1c-b21a-4a8c-88ff-e727cd6e33c4', 3, 'III', 'Nicht zu langsam', 'Three Pieces for String Quartet: III. Nicht zu langsam', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 7523 AND p.composer_id = 97
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:7fdc9a1c-b21a-4a8c-88ff-e727cd6e33c4'
);


-- Op. 30 관현악 변주곡

UPDATE pieces piece
SET piece.title = '관현악 변주곡', piece.title_en = 'Variations for Orchestra, op. 30',
    piece.type = 'song', piece.opus_number = 'Op. 30',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 9412 AND piece.composer_id = 97
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- Op. 27 피아노 변주곡

UPDATE pieces piece
SET piece.title = '피아노 변주곡', piece.title_en = 'Variations for Piano, op. 27',
    piece.type = 'album', piece.opus_number = 'Op. 27',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 8266 AND piece.composer_id = 97
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'II',
    part.name_ko = 'Sehr schnell', part.name_en = 'Variationen, op. 27: II. Sehr schnell',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 8266 AND p.composer_id = 97 AND part.part_key = 'musicbrainz:a5664f96-1b1f-4d64-a584-0320823e5245' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:a5664f96-1b1f-4d64-a584-0320823e5245', 1, 'II', 'Sehr schnell', 'Variationen, op. 27: II. Sehr schnell', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 8266 AND p.composer_id = 97
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:a5664f96-1b1f-4d64-a584-0320823e5245'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'III',
    part.name_ko = 'Ruhig fließend', part.name_en = 'Variationen, op. 27: III. Ruhig fließend',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 8266 AND p.composer_id = 97 AND part.part_key = 'musicbrainz:ac61f088-2ce6-42d8-b453-ff7a9559db0b' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:ac61f088-2ce6-42d8-b453-ff7a9559db0b', 2, 'III', 'Ruhig fließend', 'Variationen, op. 27: III. Ruhig fließend', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 8266 AND p.composer_id = 97
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:ac61f088-2ce6-42d8-b453-ff7a9559db0b'
);


-- None 3 Orchestral Songs

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '3 Orchestral Songs', '3 Orchestral Songs', 'album', NULL, NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 97
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '3 Orchestral Songs'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '56c74673-8866-4bc6-9920-16d394833e46'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '56c74673-8866-4bc6-9920-16d394833e46'
FROM pieces p
WHERE p.composer_id = 97 AND p.title = '3 Orchestral Songs' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '56c74673-8866-4bc6-9920-16d394833e46'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 8747 AND linked.composer_id = 97), 'musicbrainz:4933d0de-c3c8-479b-bd6a-5aa8cf8ca313', 1, 'III', '"O sanftes Glühn der Berge"', '3 Orchestral Songs: III. "O sanftes Glühn der Berge"', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 97 AND p.title = '3 Orchestral Songs' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:4933d0de-c3c8-479b-bd6a-5aa8cf8ca313'
);

UPDATE pieces piece
SET piece.title = '3 Orchestral Songs 중 ""O sanftes Glühn der Berge""', piece.title_en = '3 Orchestral Songs: 3 Orchestral Songs: III. "O sanftes Glühn der Berge"', piece.editor_locked = 1
WHERE piece.id = 8747 AND piece.composer_id = 97
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 9479 AND linked.composer_id = 97), 'musicbrainz:7b975d0f-087e-43ce-a522-1c8a797b17b6', 2, 'I', '"Leise Düfte"', '3 Orchestral Songs: I. "Leise Düfte"', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 97 AND p.title = '3 Orchestral Songs' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:7b975d0f-087e-43ce-a522-1c8a797b17b6'
);

UPDATE pieces piece
SET piece.title = '3 Orchestral Songs 중 ""Leise Düfte""', piece.title_en = '3 Orchestral Songs: 3 Orchestral Songs: I. "Leise Düfte"', piece.editor_locked = 1
WHERE piece.id = 9479 AND piece.composer_id = 97
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 9790 AND linked.composer_id = 97), 'musicbrainz:92553d5b-434f-4722-8b78-8f044f7a94c0', 3, 'II', 'Kunfttag III "Nun wird es wieder Lenz"', '3 Orchestral Songs: II. Kunfttag III "Nun wird es wieder Lenz"', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 97 AND p.title = '3 Orchestral Songs' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:92553d5b-434f-4722-8b78-8f044f7a94c0'
);

UPDATE pieces piece
SET piece.title = '3 Orchestral Songs 중 "Kunfttag III "Nun wird es wieder Lenz""', piece.title_en = '3 Orchestral Songs: 3 Orchestral Songs: II. Kunfttag III "Nun wird es wieder Lenz"', piece.editor_locked = 1
WHERE piece.id = 9790 AND piece.composer_id = 97
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- Op. 2 Entflieht auf leichten Kähnen

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, 'Entflieht auf leichten Kähnen', 'Entflieht auf leichten Kähnen, op. 2', 'song', 'Op. 2', NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 97
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = 'Entflieht auf leichten Kähnen'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '3a1b4285-965d-44d2-8aec-d20b2b2835ed'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '3a1b4285-965d-44d2-8aec-d20b2b2835ed'
FROM pieces p
WHERE p.composer_id = 97 AND p.title = 'Entflieht auf leichten Kähnen' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '3a1b4285-965d-44d2-8aec-d20b2b2835ed'
);


-- None Langsamer Satz

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, 'Langsamer Satz', 'Langsamer Satz', 'song', NULL, NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 97
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = 'Langsamer Satz'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '83b8751f-9e2e-4788-bad9-fa21b843a914'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '83b8751f-9e2e-4788-bad9-fa21b843a914'
FROM pieces p
WHERE p.composer_id = 97 AND p.title = 'Langsamer Satz' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '83b8751f-9e2e-4788-bad9-fa21b843a914'
);


-- None 2개의 소품

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '2개의 소품', 'Two Pieces', 'album', NULL, NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 97
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '2개의 소품'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'cd912528-387d-4ce6-87ca-8e2f3f33e7d2'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'cd912528-387d-4ce6-87ca-8e2f3f33e7d2'
FROM pieces p
WHERE p.composer_id = 97 AND p.title = '2개의 소품' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'cd912528-387d-4ce6-87ca-8e2f3f33e7d2'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:7c40202d-401b-4dcd-8e2c-3a02c593f144', 1, NULL, 'Langsam', 'Two Pieces:II. Langsam', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 97 AND p.title = '2개의 소품' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:7c40202d-401b-4dcd-8e2c-3a02c593f144'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:c132a15c-5d02-439f-93dc-2190b020b098', 2, NULL, 'Langsam', 'Two Pieces:I. Langsam', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 97 AND p.title = '2개의 소품' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:c132a15c-5d02-439f-93dc-2190b020b098'
);


-- 카탈로그에 대응이 없는 seed 작품 3개를 목록에서 숨긴다(지우지 않음).
UPDATE pieces piece
SET piece.hidden_reason = 'catalog_unmatched'
WHERE piece.composer_id = 97 AND piece.origin = 'seed' AND piece.hidden_reason IS NULL
  AND piece.id IN (
    8486, 9640, 9661
  )
  AND NOT EXISTS (SELECT 1 FROM performance_sectors sector WHERE sector.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM piece_parts linking WHERE linking.linked_piece_id = piece.id);
