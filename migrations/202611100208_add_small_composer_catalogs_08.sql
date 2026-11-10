-- 작곡가 20명의 작품을 MusicBrainz 작품 구조로 다시 짠다(6차 자동, 8/9).
-- 작품 90개(새 4개), seed 94개 중 잇기 86·숨김 6·그대로 2.
--
-- 6차는 4차 규칙(사람·에이전트 판단 없음)을 그대로 썼다. 규칙은
-- seed_pipeline/curation/catalog-wave4-2026-10-12/auto/auto_catalog.py, 작곡가별 자료는
-- seed_pipeline/curation/catalog-wave6-2026-11-10/<작곡가>/(catalog.json·seed_map.json).
--   작품: MusicBrainz 에서 이 작곡가가 composer 인 work 중 다른 work 의 part 가 아니고
--     편곡·다른 판·발췌·단편·리믹스 표시가 없는 것. part 는 MB parts 순서대로 두 겹까지.
--   제목: 「Symphony no. 5 in C minor」 꼴은 「교향곡 5번 C단조」로 옮기고,
--     못 읽으면 원제를 둔다(MB 갈래가 가곡·오페라 등이면 「가곡 <원제>」).
--   seed 작품: MBID 가 작품이면 그 자리(제목을 위 꼴로 고치고 잠금), part 면 part 로 잇고,
--     편곡·다른 판·중복·리믹스면 hidden_reason='catalog_unmatched' 로 숨긴다(지우지 않음).
--     판단이 서지 않는 seed 는 손대지 않고 보이게 둔다. 숨길 seed 가 카탈로그 제목을
--     쥐고 있으면 그 seed 제목 뒤에 까닭을 붙여 자리를 비운다(숨긴 작품이라 안 보임).
--   manual 작품: 제목·설명·링크는 바꾸지 않는다. MBID 가 엉뚱한 work 를 가리키면
--     (제목이 전혀 다름) 잇지 않고, MBID 가 없으면 영어 제목이 같은 작품에 잇는다
--     (식별자는 더하지 않음).
--   비교 구간이 있거나 part 가 가리키는 작품은 숨기지 않는다. 두 번 돌려도 같다.

-- ===== Mieko Shiomi (composer_id 428) =====
-- 작품을 MusicBrainz 작품 구조로 다시 짠다(6차 자동). 작품 3개(묶음 1, 다악장 0, 낱곡 2),
-- 새 작품 0개, part 80개, 그 아래 0개.
-- seed 3개 중 3개를 작품·part 에 잇고, 0개를 숨기고, 0개는 그대로 둔다.

-- None A Celestial Tune by 108 Glass Marbles

UPDATE pieces piece
SET piece.title = 'A Celestial Tune by 108 Glass Marbles', piece.title_en = 'A Celestial Tune by 108 Glass Marbles',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 25571 AND piece.composer_id = 428
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Boundary Music

UPDATE pieces piece
SET piece.title = 'Boundary Music', piece.title_en = 'Boundary Music',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 24554 AND piece.composer_id = 428
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Fluxus Suite

UPDATE pieces piece
SET piece.title = 'Fluxus Suite', piece.title_en = 'Fluxus Suite',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 24261 AND piece.composer_id = 428
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'Ludwig Gosewitz', part.name_en = 'Fluxus Suite: Ludwig Gosewitz',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 24261 AND p.composer_id = 428 AND part.part_key = 'musicbrainz:06aed801-0f6b-4538-8df4-9d648c1f8c7b' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:06aed801-0f6b-4538-8df4-9d648c1f8c7b', 1, NULL, 'Ludwig Gosewitz', 'Fluxus Suite: Ludwig Gosewitz', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 24261 AND p.composer_id = 428
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:06aed801-0f6b-4538-8df4-9d648c1f8c7b'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'Pauline Oliveros', part.name_en = 'Fluxus Suite: Pauline Oliveros',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 24261 AND p.composer_id = 428 AND part.part_key = 'musicbrainz:09bce5b3-2406-4f34-84dd-6f9573a1f6d9' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:09bce5b3-2406-4f34-84dd-6f9573a1f6d9', 2, NULL, 'Pauline Oliveros', 'Fluxus Suite: Pauline Oliveros', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 24261 AND p.composer_id = 428
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:09bce5b3-2406-4f34-84dd-6f9573a1f6d9'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = NULL,
    part.name_ko = 'Mieko Shiomi', part.name_en = 'Fluxus Suite: Mieko Shiomi',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 24261 AND p.composer_id = 428 AND part.part_key = 'musicbrainz:18874eb7-5736-46e8-8975-540ceffe56a2' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:18874eb7-5736-46e8-8975-540ceffe56a2', 3, NULL, 'Mieko Shiomi', 'Fluxus Suite: Mieko Shiomi', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 24261 AND p.composer_id = 428
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:18874eb7-5736-46e8-8975-540ceffe56a2'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = NULL,
    part.name_ko = 'Tomas Schmit', part.name_en = 'Fluxus Suite: Tomas Schmit',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 24261 AND p.composer_id = 428 AND part.part_key = 'musicbrainz:19f0e1c7-2f18-438b-87fb-698cbfb21219' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:19f0e1c7-2f18-438b-87fb-698cbfb21219', 4, NULL, 'Tomas Schmit', 'Fluxus Suite: Tomas Schmit', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 24261 AND p.composer_id = 428
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:19f0e1c7-2f18-438b-87fb-698cbfb21219'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 5, part.movement_number = NULL,
    part.name_ko = 'Giuseppe Chiari', part.name_en = 'Fluxus Suite: Giuseppe Chiari',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 24261 AND p.composer_id = 428 AND part.part_key = 'musicbrainz:1f1bd3bc-7884-439a-8857-7a219e4642a6' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:1f1bd3bc-7884-439a-8857-7a219e4642a6', 5, NULL, 'Giuseppe Chiari', 'Fluxus Suite: Giuseppe Chiari', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 24261 AND p.composer_id = 428
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:1f1bd3bc-7884-439a-8857-7a219e4642a6'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 6, part.movement_number = NULL,
    part.name_ko = 'Armin Hundertmark', part.name_en = 'Fluxus Suite: Armin Hundertmark',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 24261 AND p.composer_id = 428 AND part.part_key = 'musicbrainz:277e81c6-0b49-4736-869f-0153efb0c782' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:277e81c6-0b49-4736-869f-0153efb0c782', 6, NULL, 'Armin Hundertmark', 'Fluxus Suite: Armin Hundertmark', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 24261 AND p.composer_id = 428
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:277e81c6-0b49-4736-869f-0153efb0c782'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 7, part.movement_number = NULL,
    part.name_ko = 'Robert Watts', part.name_en = 'Fluxus Suite: Robert Watts',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 24261 AND p.composer_id = 428 AND part.part_key = 'musicbrainz:2aaf9438-e88d-4df5-98e0-f4a4ec572af2' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:2aaf9438-e88d-4df5-98e0-f4a4ec572af2', 7, NULL, 'Robert Watts', 'Fluxus Suite: Robert Watts', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 24261 AND p.composer_id = 428
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:2aaf9438-e88d-4df5-98e0-f4a4ec572af2'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 8, part.movement_number = NULL,
    part.name_ko = 'Gilbert Silverman', part.name_en = 'Fluxus Suite: Gilbert Silverman',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 24261 AND p.composer_id = 428 AND part.part_key = 'musicbrainz:2d4dbe42-88d1-4d65-865d-c69b803973d2' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:2d4dbe42-88d1-4d65-865d-c69b803973d2', 8, NULL, 'Gilbert Silverman', 'Fluxus Suite: Gilbert Silverman', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 24261 AND p.composer_id = 428
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:2d4dbe42-88d1-4d65-865d-c69b803973d2'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 9, part.movement_number = NULL,
    part.name_ko = 'Hermann Nitsch', part.name_en = 'Fluxus Suite: Hermann Nitsch',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 24261 AND p.composer_id = 428 AND part.part_key = 'musicbrainz:337dbc8e-8dc7-4b7f-944c-4d221f7d56b2' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:337dbc8e-8dc7-4b7f-944c-4d221f7d56b2', 9, NULL, 'Hermann Nitsch', 'Fluxus Suite: Hermann Nitsch', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 24261 AND p.composer_id = 428
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:337dbc8e-8dc7-4b7f-944c-4d221f7d56b2'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 10, part.movement_number = NULL,
    part.name_ko = 'Harry Ruhé', part.name_en = 'Fluxus Suite: Harry Ruhé',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 24261 AND p.composer_id = 428 AND part.part_key = 'musicbrainz:352157ba-407f-47fa-b0dd-317bac7e1108' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:352157ba-407f-47fa-b0dd-317bac7e1108', 10, NULL, 'Harry Ruhé', 'Fluxus Suite: Harry Ruhé', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 24261 AND p.composer_id = 428
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:352157ba-407f-47fa-b0dd-317bac7e1108'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 11, part.movement_number = NULL,
    part.name_ko = 'Serge Oldenbourg', part.name_en = 'Fluxus Suite: Serge Oldenbourg',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 24261 AND p.composer_id = 428 AND part.part_key = 'musicbrainz:397d9bd9-d523-4938-a442-d256459efc26' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:397d9bd9-d523-4938-a442-d256459efc26', 11, NULL, 'Serge Oldenbourg', 'Fluxus Suite: Serge Oldenbourg', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 24261 AND p.composer_id = 428
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:397d9bd9-d523-4938-a442-d256459efc26'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 12, part.movement_number = NULL,
    part.name_ko = 'Shigeko Kubota', part.name_en = 'Fluxus Suite: Shigeko Kubota',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 24261 AND p.composer_id = 428 AND part.part_key = 'musicbrainz:3b6f2ac7-4414-43c3-8fd1-dea7376adeb4' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:3b6f2ac7-4414-43c3-8fd1-dea7376adeb4', 12, NULL, 'Shigeko Kubota', 'Fluxus Suite: Shigeko Kubota', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 24261 AND p.composer_id = 428
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:3b6f2ac7-4414-43c3-8fd1-dea7376adeb4'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 13, part.movement_number = NULL,
    part.name_ko = 'Dietrich Albrecht', part.name_en = 'Fluxus Suite: Dietrich Albrecht',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 24261 AND p.composer_id = 428 AND part.part_key = 'musicbrainz:3c043eb0-51c6-4163-a25a-eea63f940723' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:3c043eb0-51c6-4163-a25a-eea63f940723', 13, NULL, 'Dietrich Albrecht', 'Fluxus Suite: Dietrich Albrecht', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 24261 AND p.composer_id = 428
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:3c043eb0-51c6-4163-a25a-eea63f940723'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 14, part.movement_number = NULL,
    part.name_ko = 'Jackson Mac Low', part.name_en = 'Fluxus Suite: Jackson Mac Low',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 24261 AND p.composer_id = 428 AND part.part_key = 'musicbrainz:3fea42fd-fe1d-4b0f-85bf-eef947e4a788' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:3fea42fd-fe1d-4b0f-85bf-eef947e4a788', 14, NULL, 'Jackson Mac Low', 'Fluxus Suite: Jackson Mac Low', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 24261 AND p.composer_id = 428
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:3fea42fd-fe1d-4b0f-85bf-eef947e4a788'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 15, part.movement_number = NULL,
    part.name_ko = 'Juan Hidalgo', part.name_en = 'Fluxus Suite: Juan Hidalgo',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 24261 AND p.composer_id = 428 AND part.part_key = 'musicbrainz:42b0488b-bbdb-41bb-a864-41f6df2344ac' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:42b0488b-bbdb-41bb-a864-41f6df2344ac', 15, NULL, 'Juan Hidalgo', 'Fluxus Suite: Juan Hidalgo', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 24261 AND p.composer_id = 428
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:42b0488b-bbdb-41bb-a864-41f6df2344ac'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 16, part.movement_number = NULL,
    part.name_ko = 'Daniel Spoerri', part.name_en = 'Fluxus Suite: Daniel Spoerri',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 24261 AND p.composer_id = 428 AND part.part_key = 'musicbrainz:470d2260-a0f5-4962-84cf-744143245d05' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:470d2260-a0f5-4962-84cf-744143245d05', 16, NULL, 'Daniel Spoerri', 'Fluxus Suite: Daniel Spoerri', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 24261 AND p.composer_id = 428
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:470d2260-a0f5-4962-84cf-744143245d05'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 17, part.movement_number = NULL,
    part.name_ko = 'Henry Flynt', part.name_en = 'Fluxus Suite: Henry Flynt',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 24261 AND p.composer_id = 428 AND part.part_key = 'musicbrainz:49445619-6d11-4422-a844-88518b7bc1c5' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:49445619-6d11-4422-a844-88518b7bc1c5', 17, NULL, 'Henry Flynt', 'Fluxus Suite: Henry Flynt', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 24261 AND p.composer_id = 428
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:49445619-6d11-4422-a844-88518b7bc1c5'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 18, part.movement_number = NULL,
    part.name_ko = 'Stanley Brouwn', part.name_en = 'Fluxus Suite: Stanley Brouwn',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 24261 AND p.composer_id = 428 AND part.part_key = 'musicbrainz:4a10edc4-952e-4db9-a85d-f8334d75f946' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:4a10edc4-952e-4db9-a85d-f8334d75f946', 18, NULL, 'Stanley Brouwn', 'Fluxus Suite: Stanley Brouwn', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 24261 AND p.composer_id = 428
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:4a10edc4-952e-4db9-a85d-f8334d75f946'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 19, part.movement_number = NULL,
    part.name_ko = 'John Cage', part.name_en = 'Fluxus Suite: John Cage',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 24261 AND p.composer_id = 428 AND part.part_key = 'musicbrainz:52c30738-d696-4227-acd6-7fccc0ba31f8' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:52c30738-d696-4227-acd6-7fccc0ba31f8', 19, NULL, 'John Cage', 'Fluxus Suite: John Cage', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 24261 AND p.composer_id = 428
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:52c30738-d696-4227-acd6-7fccc0ba31f8'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 20, part.movement_number = NULL,
    part.name_ko = 'Luigi Bonotto', part.name_en = 'Fluxus Suite: Luigi Bonotto',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 24261 AND p.composer_id = 428 AND part.part_key = 'musicbrainz:5454e0cc-c6d5-40c4-9895-1560dc7e5295' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:5454e0cc-c6d5-40c4-9895-1560dc7e5295', 20, NULL, 'Luigi Bonotto', 'Fluxus Suite: Luigi Bonotto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 24261 AND p.composer_id = 428
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:5454e0cc-c6d5-40c4-9895-1560dc7e5295'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 21, part.movement_number = NULL,
    part.name_ko = 'Yasunao Tone', part.name_en = 'Fluxus Suite: Yasunao Tone',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 24261 AND p.composer_id = 428 AND part.part_key = 'musicbrainz:5a306d2c-4514-4485-92ab-11a16d209b0e' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:5a306d2c-4514-4485-92ab-11a16d209b0e', 21, NULL, 'Yasunao Tone', 'Fluxus Suite: Yasunao Tone', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 24261 AND p.composer_id = 428
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:5a306d2c-4514-4485-92ab-11a16d209b0e'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 22, part.movement_number = NULL,
    part.name_ko = 'Emmett Williams', part.name_en = 'Fluxus Suite: Emmett Williams',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 24261 AND p.composer_id = 428 AND part.part_key = 'musicbrainz:5ac89cb5-3d6b-4f50-97bd-8a7d27c28eaf' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:5ac89cb5-3d6b-4f50-97bd-8a7d27c28eaf', 22, NULL, 'Emmett Williams', 'Fluxus Suite: Emmett Williams', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 24261 AND p.composer_id = 428
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:5ac89cb5-3d6b-4f50-97bd-8a7d27c28eaf'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 23, part.movement_number = NULL,
    part.name_ko = 'Dick Higgins', part.name_en = 'Fluxus Suite: Dick Higgins',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 24261 AND p.composer_id = 428 AND part.part_key = 'musicbrainz:60d067cb-0a95-4597-8a30-a6b423e65e60' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:60d067cb-0a95-4597-8a30-a6b423e65e60', 23, NULL, 'Dick Higgins', 'Fluxus Suite: Dick Higgins', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 24261 AND p.composer_id = 428
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:60d067cb-0a95-4597-8a30-a6b423e65e60'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 24, part.movement_number = NULL,
    part.name_ko = 'Gianni Sassi', part.name_en = 'Fluxus Suite: Gianni Sassi',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 24261 AND p.composer_id = 428 AND part.part_key = 'musicbrainz:6300ae18-1960-4171-92ff-667f30c03f2e' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:6300ae18-1960-4171-92ff-667f30c03f2e', 24, NULL, 'Gianni Sassi', 'Fluxus Suite: Gianni Sassi', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 24261 AND p.composer_id = 428
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:6300ae18-1960-4171-92ff-667f30c03f2e'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 25, part.movement_number = NULL,
    part.name_ko = 'Davi Det Hompson', part.name_en = 'Fluxus Suite: Davi Det Hompson',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 24261 AND p.composer_id = 428 AND part.part_key = 'musicbrainz:64f3542e-7f4f-4d15-8a41-238985fdb4d0' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:64f3542e-7f4f-4d15-8a41-238985fdb4d0', 25, NULL, 'Davi Det Hompson', 'Fluxus Suite: Davi Det Hompson', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 24261 AND p.composer_id = 428
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:64f3542e-7f4f-4d15-8a41-238985fdb4d0'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 26, part.movement_number = NULL,
    part.name_ko = 'Yoshimasa Wada', part.name_en = 'Fluxus Suite: Yoshimasa Wada',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 24261 AND p.composer_id = 428 AND part.part_key = 'musicbrainz:666947ee-2644-4e4e-9f9f-08ff33d73784' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:666947ee-2644-4e4e-9f9f-08ff33d73784', 26, NULL, 'Yoshimasa Wada', 'Fluxus Suite: Yoshimasa Wada', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 24261 AND p.composer_id = 428
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:666947ee-2644-4e4e-9f9f-08ff33d73784'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 27, part.movement_number = NULL,
    part.name_ko = 'Gianni-Emilio Simonetti', part.name_en = 'Fluxus Suite: Gianni-Emilio Simonetti',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 24261 AND p.composer_id = 428 AND part.part_key = 'musicbrainz:6855ba2f-ae5a-4835-849d-4dd52a9dd4be' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:6855ba2f-ae5a-4835-849d-4dd52a9dd4be', 27, NULL, 'Gianni-Emilio Simonetti', 'Fluxus Suite: Gianni-Emilio Simonetti', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 24261 AND p.composer_id = 428
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:6855ba2f-ae5a-4835-849d-4dd52a9dd4be'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 28, part.movement_number = NULL,
    part.name_ko = 'Geoffrey Hendricks', part.name_en = 'Fluxus Suite: Geoffrey Hendricks',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 24261 AND p.composer_id = 428 AND part.part_key = 'musicbrainz:6a3cb9b9-49b1-4e8e-9abb-1bb7e644b24b' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:6a3cb9b9-49b1-4e8e-9abb-1bb7e644b24b', 28, NULL, 'Geoffrey Hendricks', 'Fluxus Suite: Geoffrey Hendricks', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 24261 AND p.composer_id = 428
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:6a3cb9b9-49b1-4e8e-9abb-1bb7e644b24b'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 29, part.movement_number = NULL,
    part.name_ko = 'Joseph Beuys', part.name_en = 'Fluxus Suite: Joseph Beuys',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 24261 AND p.composer_id = 428 AND part.part_key = 'musicbrainz:6f5cc1dc-80a1-40a7-aa5a-969347d2b941' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:6f5cc1dc-80a1-40a7-aa5a-969347d2b941', 29, NULL, 'Joseph Beuys', 'Fluxus Suite: Joseph Beuys', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 24261 AND p.composer_id = 428
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:6f5cc1dc-80a1-40a7-aa5a-969347d2b941'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 30, part.movement_number = NULL,
    part.name_ko = 'George Maciunas (A) (B)', part.name_en = 'Fluxus Suite: George Maciunas (A) (B)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 24261 AND p.composer_id = 428 AND part.part_key = 'musicbrainz:710ed1c4-f16c-4105-bc30-9cf94b88ba81' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:710ed1c4-f16c-4105-bc30-9cf94b88ba81', 30, NULL, 'George Maciunas (A) (B)', 'Fluxus Suite: George Maciunas (A) (B)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 24261 AND p.composer_id = 428
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:710ed1c4-f16c-4105-bc30-9cf94b88ba81'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 31, part.movement_number = NULL,
    part.name_ko = 'Marian Zazeela', part.name_en = 'Fluxus Suite: Marian Zazeela',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 24261 AND p.composer_id = 428 AND part.part_key = 'musicbrainz:737f5587-5b02-47bf-816a-eb9b6ddb036c' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:737f5587-5b02-47bf-816a-eb9b6ddb036c', 31, NULL, 'Marian Zazeela', 'Fluxus Suite: Marian Zazeela', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 24261 AND p.composer_id = 428
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:737f5587-5b02-47bf-816a-eb9b6ddb036c'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 32, part.movement_number = NULL,
    part.name_ko = 'Philip Corner', part.name_en = 'Fluxus Suite: Philip Corner',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 24261 AND p.composer_id = 428 AND part.part_key = 'musicbrainz:74778ec2-9a7b-456c-a567-ebb09be4f8dd' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:74778ec2-9a7b-456c-a567-ebb09be4f8dd', 32, NULL, 'Philip Corner', 'Fluxus Suite: Philip Corner', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 24261 AND p.composer_id = 428
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:74778ec2-9a7b-456c-a567-ebb09be4f8dd'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 33, part.movement_number = NULL,
    part.name_ko = 'Alice Hutchins', part.name_en = 'Fluxus Suite: Alice Hutchins',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 24261 AND p.composer_id = 428 AND part.part_key = 'musicbrainz:7c276230-94bf-4fa8-a808-3ea20005c1c0' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:7c276230-94bf-4fa8-a808-3ea20005c1c0', 33, NULL, 'Alice Hutchins', 'Fluxus Suite: Alice Hutchins', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 24261 AND p.composer_id = 428
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:7c276230-94bf-4fa8-a808-3ea20005c1c0'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 34, part.movement_number = NULL,
    part.name_ko = 'Walter Marchetti', part.name_en = 'Fluxus Suite: Walter Marchetti',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 24261 AND p.composer_id = 428 AND part.part_key = 'musicbrainz:7d546ff3-aae5-4c4a-9bdd-2ef79b743c90' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:7d546ff3-aae5-4c4a-9bdd-2ef79b743c90', 34, NULL, 'Walter Marchetti', 'Fluxus Suite: Walter Marchetti', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 24261 AND p.composer_id = 428
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:7d546ff3-aae5-4c4a-9bdd-2ef79b743c90'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 35, part.movement_number = NULL,
    part.name_ko = 'Henri Chopin', part.name_en = 'Fluxus Suite: Henri Chopin',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 24261 AND p.composer_id = 428 AND part.part_key = 'musicbrainz:7fe5d3bc-9a1d-487f-a933-8660275ef230' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:7fe5d3bc-9a1d-487f-a933-8660275ef230', 35, NULL, 'Henri Chopin', 'Fluxus Suite: Henri Chopin', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 24261 AND p.composer_id = 428
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:7fe5d3bc-9a1d-487f-a933-8660275ef230'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 36, part.movement_number = NULL,
    part.name_ko = 'Willem de Ridder', part.name_en = 'Fluxus Suite: Willem de Ridder',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 24261 AND p.composer_id = 428 AND part.part_key = 'musicbrainz:81e71cce-b6a7-42cc-ad0a-557f02b43792' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:81e71cce-b6a7-42cc-ad0a-557f02b43792', 36, NULL, 'Willem de Ridder', 'Fluxus Suite: Willem de Ridder', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 24261 AND p.composer_id = 428
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:81e71cce-b6a7-42cc-ad0a-557f02b43792'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 37, part.movement_number = NULL,
    part.name_ko = 'Vytautas Landsbergis', part.name_en = 'Fluxus Suite: Vytautas Landsbergis',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 24261 AND p.composer_id = 428 AND part.part_key = 'musicbrainz:834ddee5-4be7-4058-85dd-ec27799c1f02' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:834ddee5-4be7-4058-85dd-ec27799c1f02', 37, NULL, 'Vytautas Landsbergis', 'Fluxus Suite: Vytautas Landsbergis', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 24261 AND p.composer_id = 428
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:834ddee5-4be7-4058-85dd-ec27799c1f02'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 38, part.movement_number = NULL,
    part.name_ko = 'Charlotte Moorman', part.name_en = 'Fluxus Suite: Charlotte Moorman',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 24261 AND p.composer_id = 428 AND part.part_key = 'musicbrainz:85ca5245-4cf5-4bd7-8e62-46ca92947427' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:85ca5245-4cf5-4bd7-8e62-46ca92947427', 38, NULL, 'Charlotte Moorman', 'Fluxus Suite: Charlotte Moorman', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 24261 AND p.composer_id = 428
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:85ca5245-4cf5-4bd7-8e62-46ca92947427'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 39, part.movement_number = NULL,
    part.name_ko = 'Robert Filliou', part.name_en = 'Fluxus Suite: Robert Filliou',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 24261 AND p.composer_id = 428 AND part.part_key = 'musicbrainz:892980a7-cc2b-4754-a56c-e8ede1df7f87' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:892980a7-cc2b-4754-a56c-e8ede1df7f87', 39, NULL, 'Robert Filliou', 'Fluxus Suite: Robert Filliou', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 24261 AND p.composer_id = 428
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:892980a7-cc2b-4754-a56c-e8ede1df7f87'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 40, part.movement_number = NULL,
    part.name_ko = 'George Brecht', part.name_en = 'Fluxus Suite: George Brecht',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 24261 AND p.composer_id = 428 AND part.part_key = 'musicbrainz:8c90e852-3dad-4559-8164-32256eb3bd2a' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:8c90e852-3dad-4559-8164-32256eb3bd2a', 40, NULL, 'George Brecht', 'Fluxus Suite: George Brecht', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 24261 AND p.composer_id = 428
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:8c90e852-3dad-4559-8164-32256eb3bd2a'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 41, part.movement_number = NULL,
    part.name_ko = 'Jacques Donguy', part.name_en = 'Fluxus Suite: Jacques Donguy',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 24261 AND p.composer_id = 428 AND part.part_key = 'musicbrainz:8efe0da1-a4a9-4067-a444-2780c7880af3' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:8efe0da1-a4a9-4067-a444-2780c7880af3', 41, NULL, 'Jacques Donguy', 'Fluxus Suite: Jacques Donguy', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 24261 AND p.composer_id = 428
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:8efe0da1-a4a9-4067-a444-2780c7880af3'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 42, part.movement_number = NULL,
    part.name_ko = 'René Block', part.name_en = 'Fluxus Suite: René Block',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 24261 AND p.composer_id = 428 AND part.part_key = 'musicbrainz:90c896a5-a682-4271-b6aa-7f91f768b5bc' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:90c896a5-a682-4271-b6aa-7f91f768b5bc', 42, NULL, 'René Block', 'Fluxus Suite: René Block', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 24261 AND p.composer_id = 428
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:90c896a5-a682-4271-b6aa-7f91f768b5bc'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 43, part.movement_number = NULL,
    part.name_ko = 'Bengt af Klintberg', part.name_en = 'Fluxus Suite: Bengt af Klintberg',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 24261 AND p.composer_id = 428 AND part.part_key = 'musicbrainz:9294b4a6-9b0f-466b-bdff-34284793f7c6' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:9294b4a6-9b0f-466b-bdff-34284793f7c6', 43, NULL, 'Bengt af Klintberg', 'Fluxus Suite: Bengt af Klintberg', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 24261 AND p.composer_id = 428
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:9294b4a6-9b0f-466b-bdff-34284793f7c6'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 44, part.movement_number = NULL,
    part.name_ko = 'Jonas Mekas', part.name_en = 'Fluxus Suite: Jonas Mekas',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 24261 AND p.composer_id = 428 AND part.part_key = 'musicbrainz:937258aa-a446-4c96-93a0-623bcea9edb0' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:937258aa-a446-4c96-93a0-623bcea9edb0', 44, NULL, 'Jonas Mekas', 'Fluxus Suite: Jonas Mekas', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 24261 AND p.composer_id = 428
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:937258aa-a446-4c96-93a0-623bcea9edb0'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 45, part.movement_number = NULL,
    part.name_ko = 'Ben Patterson', part.name_en = 'Fluxus Suite: Ben Patterson',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 24261 AND p.composer_id = 428 AND part.part_key = 'musicbrainz:947c6cb5-e9e9-4a96-97aa-a23e3427ee80' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:947c6cb5-e9e9-4a96-97aa-a23e3427ee80', 45, NULL, 'Ben Patterson', 'Fluxus Suite: Ben Patterson', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 24261 AND p.composer_id = 428
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:947c6cb5-e9e9-4a96-97aa-a23e3427ee80'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 46, part.movement_number = NULL,
    part.name_ko = 'Milan Knizak', part.name_en = 'Fluxus Suite: Milan Knizak',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 24261 AND p.composer_id = 428 AND part.part_key = 'musicbrainz:94ffc680-4923-415f-ae5c-2219164a21e9' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:94ffc680-4923-415f-ae5c-2219164a21e9', 46, NULL, 'Milan Knizak', 'Fluxus Suite: Milan Knizak', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 24261 AND p.composer_id = 428
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:94ffc680-4923-415f-ae5c-2219164a21e9'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 47, part.movement_number = NULL,
    part.name_ko = 'Allen Ginsberg', part.name_en = 'Fluxus Suite: Allen Ginsberg',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 24261 AND p.composer_id = 428 AND part.part_key = 'musicbrainz:9601b5ea-9d5c-412f-8c08-c14a14724b95' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:9601b5ea-9d5c-412f-8c08-c14a14724b95', 47, NULL, 'Allen Ginsberg', 'Fluxus Suite: Allen Ginsberg', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 24261 AND p.composer_id = 428
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:9601b5ea-9d5c-412f-8c08-c14a14724b95'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 48, part.movement_number = NULL,
    part.name_ko = 'Takako Saito', part.name_en = 'Fluxus Suite: Takako Saito',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 24261 AND p.composer_id = 428 AND part.part_key = 'musicbrainz:9a991035-c13e-41c7-88e9-baf7b768d367' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:9a991035-c13e-41c7-88e9-baf7b768d367', 48, NULL, 'Takako Saito', 'Fluxus Suite: Takako Saito', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 24261 AND p.composer_id = 428
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:9a991035-c13e-41c7-88e9-baf7b768d367'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 49, part.movement_number = NULL,
    part.name_ko = 'Ben Vautier', part.name_en = 'Fluxus Suite: Ben Vautier',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 24261 AND p.composer_id = 428 AND part.part_key = 'musicbrainz:9b0ef7fd-7957-4c06-ac1f-4a2b64fd01b5' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:9b0ef7fd-7957-4c06-ac1f-4a2b64fd01b5', 49, NULL, 'Ben Vautier', 'Fluxus Suite: Ben Vautier', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 24261 AND p.composer_id = 428
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:9b0ef7fd-7957-4c06-ac1f-4a2b64fd01b5'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 50, part.movement_number = NULL,
    part.name_ko = 'Carolee Schneemann', part.name_en = 'Fluxus Suite: Carolee Schneemann',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 24261 AND p.composer_id = 428 AND part.part_key = 'musicbrainz:9b2e8c4c-618d-4ddf-a716-00d32f45772f' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:9b2e8c4c-618d-4ddf-a716-00d32f45772f', 50, NULL, 'Carolee Schneemann', 'Fluxus Suite: Carolee Schneemann', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 24261 AND p.composer_id = 428
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:9b2e8c4c-618d-4ddf-a716-00d32f45772f'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 51, part.movement_number = NULL,
    part.name_ko = 'Jon Hendricks', part.name_en = 'Fluxus Suite: Jon Hendricks',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 24261 AND p.composer_id = 428 AND part.part_key = 'musicbrainz:9d797acd-e9ba-4e0b-a6fd-d4416426f149' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:9d797acd-e9ba-4e0b-a6fd-d4416426f149', 51, NULL, 'Jon Hendricks', 'Fluxus Suite: Jon Hendricks', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 24261 AND p.composer_id = 428
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:9d797acd-e9ba-4e0b-a6fd-d4416426f149'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 52, part.movement_number = NULL,
    part.name_ko = 'Arthur Koepcke', part.name_en = 'Fluxus Suite: Arthur Koepcke',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 24261 AND p.composer_id = 428 AND part.part_key = 'musicbrainz:9eae5778-c184-4a49-9d3b-eff031805e36' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:9eae5778-c184-4a49-9d3b-eff031805e36', 52, NULL, 'Arthur Koepcke', 'Fluxus Suite: Arthur Koepcke', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 24261 AND p.composer_id = 428
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:9eae5778-c184-4a49-9d3b-eff031805e36'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 53, part.movement_number = NULL,
    part.name_ko = 'Gerhard Rühm', part.name_en = 'Fluxus Suite: Gerhard Rühm',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 24261 AND p.composer_id = 428 AND part.part_key = 'musicbrainz:9f3e1c43-80dc-4bde-aa12-551d93ea95ad' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:9f3e1c43-80dc-4bde-aa12-551d93ea95ad', 53, NULL, 'Gerhard Rühm', 'Fluxus Suite: Gerhard Rühm', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 24261 AND p.composer_id = 428
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:9f3e1c43-80dc-4bde-aa12-551d93ea95ad'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 54, part.movement_number = NULL,
    part.name_ko = 'Yoko Ono (Silence)', part.name_en = 'Fluxus Suite: Yoko Ono (Silence)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 24261 AND p.composer_id = 428 AND part.part_key = 'musicbrainz:a11a8f5b-30b9-4ac0-a9de-e856ae37fbca' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:a11a8f5b-30b9-4ac0-a9de-e856ae37fbca', 54, NULL, 'Yoko Ono (Silence)', 'Fluxus Suite: Yoko Ono (Silence)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 24261 AND p.composer_id = 428
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:a11a8f5b-30b9-4ac0-a9de-e856ae37fbca'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 55, part.movement_number = NULL,
    part.name_ko = 'Jean Dupuy', part.name_en = 'Fluxus Suite: Jean Dupuy',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 24261 AND p.composer_id = 428 AND part.part_key = 'musicbrainz:ac185772-e6c7-4a40-a7ef-baf67f44f75f' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:ac185772-e6c7-4a40-a7ef-baf67f44f75f', 55, NULL, 'Jean Dupuy', 'Fluxus Suite: Jean Dupuy', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 24261 AND p.composer_id = 428
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:ac185772-e6c7-4a40-a7ef-baf67f44f75f'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 56, part.movement_number = NULL,
    part.name_ko = 'Barbara Moore', part.name_en = 'Fluxus Suite: Barbara Moore',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 24261 AND p.composer_id = 428 AND part.part_key = 'musicbrainz:b7c9f222-8807-47de-a929-c5bc95b96480' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:b7c9f222-8807-47de-a929-c5bc95b96480', 56, NULL, 'Barbara Moore', 'Fluxus Suite: Barbara Moore', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 24261 AND p.composer_id = 428
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:b7c9f222-8807-47de-a929-c5bc95b96480'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 57, part.movement_number = NULL,
    part.name_ko = 'Wolf Vostell', part.name_en = 'Fluxus Suite: Wolf Vostell',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 24261 AND p.composer_id = 428 AND part.part_key = 'musicbrainz:b8d8dabe-8d66-4d6c-a243-84dc0dca2839' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:b8d8dabe-8d66-4d6c-a243-84dc0dca2839', 57, NULL, 'Wolf Vostell', 'Fluxus Suite: Wolf Vostell', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 24261 AND p.composer_id = 428
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:b8d8dabe-8d66-4d6c-a243-84dc0dca2839'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 58, part.movement_number = NULL,
    part.name_ko = 'Alison Knowles', part.name_en = 'Fluxus Suite: Alison Knowles',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 24261 AND p.composer_id = 428 AND part.part_key = 'musicbrainz:b98e6275-b133-4fc9-8499-83267e5bc3f8' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:b98e6275-b133-4fc9-8499-83267e5bc3f8', 58, NULL, 'Alison Knowles', 'Fluxus Suite: Alison Knowles', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 24261 AND p.composer_id = 428
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:b98e6275-b133-4fc9-8499-83267e5bc3f8'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 59, part.movement_number = NULL,
    part.name_ko = 'Al Hansen', part.name_en = 'Fluxus Suite: Al Hansen',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 24261 AND p.composer_id = 428 AND part.part_key = 'musicbrainz:bc59aba7-1f63-4d26-9a49-c77a7acf22ee' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:bc59aba7-1f63-4d26-9a49-c77a7acf22ee', 59, NULL, 'Al Hansen', 'Fluxus Suite: Al Hansen', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 24261 AND p.composer_id = 428
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:bc59aba7-1f63-4d26-9a49-c77a7acf22ee'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 60, part.movement_number = NULL,
    part.name_ko = 'La Monte Young', part.name_en = 'Fluxus Suite: La Monte Young',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 24261 AND p.composer_id = 428 AND part.part_key = 'musicbrainz:c22850c0-39ff-493d-b596-12a95c5bde6b' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:c22850c0-39ff-493d-b596-12a95c5bde6b', 60, NULL, 'La Monte Young', 'Fluxus Suite: La Monte Young', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 24261 AND p.composer_id = 428
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:c22850c0-39ff-493d-b596-12a95c5bde6b'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 61, part.movement_number = NULL,
    part.name_ko = 'Henning Christiansen', part.name_en = 'Fluxus Suite: Henning Christiansen',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 24261 AND p.composer_id = 428 AND part.part_key = 'musicbrainz:c2d52909-0302-4ba1-bd81-db14a26a5630' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:c2d52909-0302-4ba1-bd81-db14a26a5630', 61, NULL, 'Henning Christiansen', 'Fluxus Suite: Henning Christiansen', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 24261 AND p.composer_id = 428
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:c2d52909-0302-4ba1-bd81-db14a26a5630'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 62, part.movement_number = NULL,
    part.name_ko = 'Esther Ferrer', part.name_en = 'Fluxus Suite: Esther Ferrer',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 24261 AND p.composer_id = 428 AND part.part_key = 'musicbrainz:c334e3f4-2207-461b-907a-47a657af85f8' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:c334e3f4-2207-461b-907a-47a657af85f8', 62, NULL, 'Esther Ferrer', 'Fluxus Suite: Esther Ferrer', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 24261 AND p.composer_id = 428
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:c334e3f4-2207-461b-907a-47a657af85f8'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 63, part.movement_number = NULL,
    part.name_ko = 'Jean Jacques Lebel', part.name_en = 'Fluxus Suite: Jean Jacques Lebel',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 24261 AND p.composer_id = 428 AND part.part_key = 'musicbrainz:c6cda82f-982d-4ee0-a55b-92ed2e607b08' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:c6cda82f-982d-4ee0-a55b-92ed2e607b08', 63, NULL, 'Jean Jacques Lebel', 'Fluxus Suite: Jean Jacques Lebel', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 24261 AND p.composer_id = 428
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:c6cda82f-982d-4ee0-a55b-92ed2e607b08'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 64, part.movement_number = NULL,
    part.name_ko = 'Endre Tót', part.name_en = 'Fluxus Suite: Endre Tót',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 24261 AND p.composer_id = 428 AND part.part_key = 'musicbrainz:ca0b1f90-a71f-4de7-9353-1691b5552728' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:ca0b1f90-a71f-4de7-9353-1691b5552728', 64, NULL, 'Endre Tót', 'Fluxus Suite: Endre Tót', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 24261 AND p.composer_id = 428
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:ca0b1f90-a71f-4de7-9353-1691b5552728'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 65, part.movement_number = NULL,
    part.name_ko = 'Ken Friedman', part.name_en = 'Fluxus Suite: Ken Friedman',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 24261 AND p.composer_id = 428 AND part.part_key = 'musicbrainz:cb9a0acb-fd9e-4730-b3ba-4b4fa9fa8811' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:cb9a0acb-fd9e-4730-b3ba-4b4fa9fa8811', 65, NULL, 'Ken Friedman', 'Fluxus Suite: Ken Friedman', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 24261 AND p.composer_id = 428
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:cb9a0acb-fd9e-4730-b3ba-4b4fa9fa8811'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 66, part.movement_number = NULL,
    part.name_ko = 'Hanns Sohm', part.name_en = 'Fluxus Suite: Hanns Sohm',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 24261 AND p.composer_id = 428 AND part.part_key = 'musicbrainz:ce12354a-09fd-49cc-bce0-0d6b16f67e12' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:ce12354a-09fd-49cc-bce0-0d6b16f67e12', 66, NULL, 'Hanns Sohm', 'Fluxus Suite: Hanns Sohm', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 24261 AND p.composer_id = 428
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:ce12354a-09fd-49cc-bce0-0d6b16f67e12'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 67, part.movement_number = NULL,
    part.name_ko = 'Joe Jones', part.name_en = 'Fluxus Suite: Joe Jones',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 24261 AND p.composer_id = 428 AND part.part_key = 'musicbrainz:d5680dbf-4ffc-46c9-acd3-224ef3e0088c' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:d5680dbf-4ffc-46c9-acd3-224ef3e0088c', 67, NULL, 'Joe Jones', 'Fluxus Suite: Joe Jones', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 24261 AND p.composer_id = 428
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:d5680dbf-4ffc-46c9-acd3-224ef3e0088c'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 68, part.movement_number = NULL,
    part.name_ko = 'Takehisa Kosugi', part.name_en = 'Fluxus Suite: Takehisa Kosugi',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 24261 AND p.composer_id = 428 AND part.part_key = 'musicbrainz:d8de6f10-aaf1-484e-bf21-9290e0f47a16' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:d8de6f10-aaf1-484e-bf21-9290e0f47a16', 68, NULL, 'Takehisa Kosugi', 'Fluxus Suite: Takehisa Kosugi', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 24261 AND p.composer_id = 428
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:d8de6f10-aaf1-484e-bf21-9290e0f47a16'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 69, part.movement_number = NULL,
    part.name_ko = 'Christo', part.name_en = 'Fluxus Suite: Christo',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 24261 AND p.composer_id = 428 AND part.part_key = 'musicbrainz:d9326ff3-b09a-4397-914e-024736d7886c' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:d9326ff3-b09a-4397-914e-024736d7886c', 69, NULL, 'Christo', 'Fluxus Suite: Christo', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 24261 AND p.composer_id = 428
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:d9326ff3-b09a-4397-914e-024736d7886c'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 70, part.movement_number = NULL,
    part.name_ko = 'Jean Brown', part.name_en = 'Fluxus Suite: Jean Brown',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 24261 AND p.composer_id = 428 AND part.part_key = 'musicbrainz:daae62ff-a622-455a-8688-131be52571ce' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:daae62ff-a622-455a-8688-131be52571ce', 70, NULL, 'Jean Brown', 'Fluxus Suite: Jean Brown', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 24261 AND p.composer_id = 428
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:daae62ff-a622-455a-8688-131be52571ce'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 71, part.movement_number = NULL,
    part.name_ko = 'Francesco Conz', part.name_en = 'Fluxus Suite: Francesco Conz',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 24261 AND p.composer_id = 428 AND part.part_key = 'musicbrainz:dce723ee-961a-41a1-b759-3cc437a63d8c' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:dce723ee-961a-41a1-b759-3cc437a63d8c', 71, NULL, 'Francesco Conz', 'Fluxus Suite: Francesco Conz', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 24261 AND p.composer_id = 428
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:dce723ee-961a-41a1-b759-3cc437a63d8c'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 72, part.movement_number = NULL,
    part.name_ko = 'Eric Andersen', part.name_en = 'Fluxus Suite: Eric Andersen',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 24261 AND p.composer_id = 428 AND part.part_key = 'musicbrainz:ddf13fd4-c9df-4768-ac50-5bab8dafcc48' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:ddf13fd4-c9df-4768-ac50-5bab8dafcc48', 72, NULL, 'Eric Andersen', 'Fluxus Suite: Eric Andersen', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 24261 AND p.composer_id = 428
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:ddf13fd4-c9df-4768-ac50-5bab8dafcc48'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 73, part.movement_number = NULL,
    part.name_ko = 'Gino Di Maggio', part.name_en = 'Fluxus Suite: Gino Di Maggio',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 24261 AND p.composer_id = 428 AND part.part_key = 'musicbrainz:e3769caf-589e-4909-8d33-853788f46efc' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:e3769caf-589e-4909-8d33-853788f46efc', 73, NULL, 'Gino Di Maggio', 'Fluxus Suite: Gino Di Maggio', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 24261 AND p.composer_id = 428
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:e3769caf-589e-4909-8d33-853788f46efc'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 74, part.movement_number = NULL,
    part.name_ko = 'Dieter Roth', part.name_en = 'Fluxus Suite: Dieter Roth',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 24261 AND p.composer_id = 428 AND part.part_key = 'musicbrainz:e3b1e2a5-f9bc-4c55-a416-4af96a781b85' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:e3b1e2a5-f9bc-4c55-a416-4af96a781b85', 74, NULL, 'Dieter Roth', 'Fluxus Suite: Dieter Roth', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 24261 AND p.composer_id = 428
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:e3b1e2a5-f9bc-4c55-a416-4af96a781b85'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 75, part.movement_number = NULL,
    part.name_ko = 'Nam June Paik', part.name_en = 'Fluxus Suite: Nam June Paik',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 24261 AND p.composer_id = 428 AND part.part_key = 'musicbrainz:ec8cb96b-2e38-4ee8-b80d-403c9169cacd' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:ec8cb96b-2e38-4ee8-b80d-403c9169cacd', 75, NULL, 'Nam June Paik', 'Fluxus Suite: Nam June Paik', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 24261 AND p.composer_id = 428
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:ec8cb96b-2e38-4ee8-b80d-403c9169cacd'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 76, part.movement_number = NULL,
    part.name_ko = 'Larry Miller', part.name_en = 'Fluxus Suite: Larry Miller',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 24261 AND p.composer_id = 428 AND part.part_key = 'musicbrainz:f3b56e49-e54d-4ae0-9378-2f60e6198c48' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:f3b56e49-e54d-4ae0-9378-2f60e6198c48', 76, NULL, 'Larry Miller', 'Fluxus Suite: Larry Miller', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 24261 AND p.composer_id = 428
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:f3b56e49-e54d-4ae0-9378-2f60e6198c48'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 77, part.movement_number = NULL,
    part.name_ko = 'Peter Moore', part.name_en = 'Fluxus Suite: Peter Moore',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 24261 AND p.composer_id = 428 AND part.part_key = 'musicbrainz:fa8712c5-8de6-4244-b500-7a7fababec9f' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:fa8712c5-8de6-4244-b500-7a7fababec9f', 77, NULL, 'Peter Moore', 'Fluxus Suite: Peter Moore', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 24261 AND p.composer_id = 428
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:fa8712c5-8de6-4244-b500-7a7fababec9f'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 78, part.movement_number = NULL,
    part.name_ko = 'Michael Berger', part.name_en = 'Fluxus Suite: Michael Berger',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 24261 AND p.composer_id = 428 AND part.part_key = 'musicbrainz:fad44297-0673-4c92-b5d0-3378297c1221' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:fad44297-0673-4c92-b5d0-3378297c1221', 78, NULL, 'Michael Berger', 'Fluxus Suite: Michael Berger', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 24261 AND p.composer_id = 428
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:fad44297-0673-4c92-b5d0-3378297c1221'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 79, part.movement_number = NULL,
    part.name_ko = 'Allan Kaprow', part.name_en = 'Fluxus Suite: Allan Kaprow',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 24261 AND p.composer_id = 428 AND part.part_key = 'musicbrainz:fbc1160e-4a5a-4fbd-a54f-49878fde6fba' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:fbc1160e-4a5a-4fbd-a54f-49878fde6fba', 79, NULL, 'Allan Kaprow', 'Fluxus Suite: Allan Kaprow', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 24261 AND p.composer_id = 428
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:fbc1160e-4a5a-4fbd-a54f-49878fde6fba'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 80, part.movement_number = NULL,
    part.name_ko = 'Ay-O', part.name_en = 'Fluxus Suite: Ay-O',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 24261 AND p.composer_id = 428 AND part.part_key = 'musicbrainz:fbdfdd76-e9ff-4994-9d97-7d4a6c8ff908' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:fbdfdd76-e9ff-4994-9d97-7d4a6c8ff908', 80, NULL, 'Ay-O', 'Fluxus Suite: Ay-O', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 24261 AND p.composer_id = 428
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:fbdfdd76-e9ff-4994-9d97-7d4a6c8ff908'
);

-- 숨길 seed 작품 없음

-- ===== Michael Waller (composer_id 429) =====
-- 작품을 MusicBrainz 작품 구조로 다시 짠다(6차 자동). 작품 11개(묶음 2, 다악장 1, 낱곡 8),
-- 새 작품 1개, part 10개, 그 아래 0개.
-- seed 10개 중 10개를 작품·part 에 잇고, 0개를 숨기고, 0개는 그대로 둔다.

-- None Bounding

UPDATE pieces piece
SET piece.title = 'Bounding', piece.title_en = 'Bounding',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 24729 AND piece.composer_id = 429
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None 디베르티멘토

UPDATE pieces piece
SET piece.title = '디베르티멘토', piece.title_en = 'Divertimento',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 23781 AND piece.composer_id = 429
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None For Papa

UPDATE pieces piece
SET piece.title = 'For Papa', piece.title_en = 'For Papa',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 23968 AND piece.composer_id = 429
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None For Pauline

UPDATE pieces piece
SET piece.title = 'For Pauline', piece.title_en = 'For Pauline',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 25284 AND piece.composer_id = 429
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Jennifer

UPDATE pieces piece
SET piece.title = 'Jennifer', piece.title_en = 'Jennifer',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 23422 AND piece.composer_id = 429
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None 녹턴

UPDATE pieces piece
SET piece.title = '녹턴', piece.title_en = 'Nocturnes',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 23800 AND piece.composer_id = 429
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'No. 1', part.name_en = 'Nocturnes: No. 1',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 23800 AND p.composer_id = 429 AND part.part_key = 'musicbrainz:9b057fd2-2052-499e-9e63-cd4b5b2feed2' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:9b057fd2-2052-499e-9e63-cd4b5b2feed2', 1, NULL, 'No. 1', 'Nocturnes: No. 1', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 23800 AND p.composer_id = 429
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:9b057fd2-2052-499e-9e63-cd4b5b2feed2'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'No. 4', part.name_en = 'Nocturnes: No. 4',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 23800 AND p.composer_id = 429 AND part.part_key = 'musicbrainz:a555ce6e-1487-4438-af81-03c05c02d41c' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:a555ce6e-1487-4438-af81-03c05c02d41c', 2, NULL, 'No. 4', 'Nocturnes: No. 4', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 23800 AND p.composer_id = 429
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:a555ce6e-1487-4438-af81-03c05c02d41c'
);


-- None Return From L.A.

UPDATE pieces piece
SET piece.title = 'Return From L.A.', piece.title_en = 'Return From L.A.',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 24782 AND piece.composer_id = 429
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'I', part.name_en = 'Return From L.A.: I',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 24782 AND p.composer_id = 429 AND part.part_key = 'musicbrainz:26af6521-2050-47c3-a093-00725c89ebf8' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:26af6521-2050-47c3-a093-00725c89ebf8', 1, NULL, 'I', 'Return From L.A.: I', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 24782 AND p.composer_id = 429
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:26af6521-2050-47c3-a093-00725c89ebf8'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'II', part.name_en = 'Return From L.A.: II',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 24782 AND p.composer_id = 429 AND part.part_key = 'musicbrainz:0d6bda47-590a-4a5e-9459-648f906c766e' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:0d6bda47-590a-4a5e-9459-648f906c766e', 2, NULL, 'II', 'Return From L.A.: II', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 24782 AND p.composer_id = 429
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:0d6bda47-590a-4a5e-9459-648f906c766e'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = NULL,
    part.name_ko = 'III', part.name_en = 'Return From L.A.: III',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 24782 AND p.composer_id = 429 AND part.part_key = 'musicbrainz:514b74b4-2f2c-4245-8dad-c57e9e3fcb94' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:514b74b4-2f2c-4245-8dad-c57e9e3fcb94', 3, NULL, 'III', 'Return From L.A.: III', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 24782 AND p.composer_id = 429
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:514b74b4-2f2c-4245-8dad-c57e9e3fcb94'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = NULL,
    part.name_ko = 'IV', part.name_en = 'Return From L.A.: IV',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 24782 AND p.composer_id = 429 AND part.part_key = 'musicbrainz:49414d47-fd24-44ff-8629-b460b5fa5ab4' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:49414d47-fd24-44ff-8629-b460b5fa5ab4', 4, NULL, 'IV', 'Return From L.A.: IV', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 24782 AND p.composer_id = 429
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:49414d47-fd24-44ff-8629-b460b5fa5ab4'
);


-- None Roman

UPDATE pieces piece
SET piece.title = 'Roman', piece.title_en = 'Roman',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 24707 AND piece.composer_id = 429
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Stolen Moments

UPDATE pieces piece
SET piece.title = 'Stolen Moments', piece.title_en = 'Stolen Moments',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 25014 AND piece.composer_id = 429
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Vibrafono Studio

UPDATE pieces piece
SET piece.title = 'Vibrafono Studio', piece.title_en = 'Vibrafono Studio',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 24157 AND piece.composer_id = 429
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Love

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, 'Love', 'Love', 'album', NULL, NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 429
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = 'Love'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '5e17532f-5b4c-4f21-9886-c7df3a1eb040'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '5e17532f-5b4c-4f21-9886-c7df3a1eb040'
FROM pieces p
WHERE p.composer_id = 429 AND p.title = 'Love' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '5e17532f-5b4c-4f21-9886-c7df3a1eb040'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:d080f381-01f3-42ed-a95f-8507347b6a2e', 1, 'I', 'Valentine', 'Love: I. Valentine', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 429 AND p.title = 'Love' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:d080f381-01f3-42ed-a95f-8507347b6a2e'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:d182f9f6-6778-4b28-a126-9b83477369cc', 2, 'II', 'Baby’s Return', 'Love: II. Baby’s Return', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 429 AND p.title = 'Love' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:d182f9f6-6778-4b28-a126-9b83477369cc'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:4a26bda1-60e7-4242-87eb-1ba8dae2aafb', 3, 'III', 'Images', 'Love: III. Images', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 429 AND p.title = 'Love' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:4a26bda1-60e7-4242-87eb-1ba8dae2aafb'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:bb175adb-fc90-49b8-a543-411379a360d3', 4, 'IV', 'Sizing', 'Love: IV. Sizing', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 429 AND p.title = 'Love' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:bb175adb-fc90-49b8-a543-411379a360d3'
);

-- 숨길 seed 작품 없음

-- ===== 베른하르드 크루셀 (composer_id 434) =====
-- 작품을 MusicBrainz 작품 구조로 다시 짠다(6차 자동). 작품 16개(묶음 1, 다악장 10, 낱곡 5),
-- 새 작품 0개, part 37개, 그 아래 0개.
-- seed 17개 중 16개를 작품·part 에 잇고, 0개를 숨기고, 1개는 그대로 둔다.

-- None Bassoon Concertino

UPDATE pieces piece
SET piece.title = 'Bassoon Concertino', piece.title_en = 'Bassoon Concertino',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 24351 AND piece.composer_id = 434
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'Allegro brillante - Poco adagio -', part.name_en = 'Bassoon Concertino: I. Allegro brillante - Poco adagio -',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 24351 AND p.composer_id = 434 AND part.part_key = 'musicbrainz:8ba613c7-f41f-4b15-a263-aa95445e5dea' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:8ba613c7-f41f-4b15-a263-aa95445e5dea', 1, 'I', 'Allegro brillante - Poco adagio -', 'Bassoon Concertino: I. Allegro brillante - Poco adagio -', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 24351 AND p.composer_id = 434
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:8ba613c7-f41f-4b15-a263-aa95445e5dea'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'Allegro moderato [Theme and Variations] -', part.name_en = 'Bassoon Concertino: II. Allegro moderato [Theme and Variations] -',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 24351 AND p.composer_id = 434 AND part.part_key = 'musicbrainz:05db8267-4f1f-429c-9aa6-7b93192ca812' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:05db8267-4f1f-429c-9aa6-7b93192ca812', 2, 'II', 'Allegro moderato [Theme and Variations] -', 'Bassoon Concertino: II. Allegro moderato [Theme and Variations] -', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 24351 AND p.composer_id = 434
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:05db8267-4f1f-429c-9aa6-7b93192ca812'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = 'Polacca', part.name_en = 'Bassoon Concertino: III. Polacca',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 24351 AND p.composer_id = 434 AND part.part_key = 'musicbrainz:e51051f0-840b-4eb3-b776-fd2ca4eea79c' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:e51051f0-840b-4eb3-b776-fd2ca4eea79c', 3, 'III', 'Polacca', 'Bassoon Concertino: III. Polacca', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 24351 AND p.composer_id = 434
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:e51051f0-840b-4eb3-b776-fd2ca4eea79c'
);


-- Op. 1 클라리넷 협주곡 1번 E♭장조

UPDATE pieces piece
SET piece.title = '클라리넷 협주곡 1번 E♭장조', piece.title_en = 'Clarinet Concerto no. 1 in E-flat major, op. 1',
    piece.type = 'album', piece.opus_number = 'Op. 1',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 25012 AND piece.composer_id = 434
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'Allegro', part.name_en = 'Clarinet Concerto no. 1 in E-flat major, op. 1: I. Allegro',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 25012 AND p.composer_id = 434 AND part.part_key = 'musicbrainz:f56a3374-b995-4e57-81a2-329aeb5111c4' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:f56a3374-b995-4e57-81a2-329aeb5111c4', 1, 'I', 'Allegro', 'Clarinet Concerto no. 1 in E-flat major, op. 1: I. Allegro', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 25012 AND p.composer_id = 434
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:f56a3374-b995-4e57-81a2-329aeb5111c4'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'Adagio', part.name_en = 'Clarinet Concerto no. 1 in E-flat major, op. 1: II. Adagio',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 25012 AND p.composer_id = 434 AND part.part_key = 'musicbrainz:e5b71b13-8443-43ba-a611-d830ade22fdb' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:e5b71b13-8443-43ba-a611-d830ade22fdb', 2, 'II', 'Adagio', 'Clarinet Concerto no. 1 in E-flat major, op. 1: II. Adagio', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 25012 AND p.composer_id = 434
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:e5b71b13-8443-43ba-a611-d830ade22fdb'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = 'Rondo (Allegretto)', part.name_en = 'Clarinet Concerto no. 1 in E-flat major, op. 1: III. Rondo (Allegretto)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 25012 AND p.composer_id = 434 AND part.part_key = 'musicbrainz:ee9a406d-2c90-462a-b237-b9898263dda6' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:ee9a406d-2c90-462a-b237-b9898263dda6', 3, 'III', 'Rondo (Allegretto)', 'Clarinet Concerto no. 1 in E-flat major, op. 1: III. Rondo (Allegretto)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 25012 AND p.composer_id = 434
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:ee9a406d-2c90-462a-b237-b9898263dda6'
);


-- Op. 11 클라리넷 협주곡 3번 B♭장조

UPDATE pieces piece
SET piece.title = '클라리넷 협주곡 3번 B♭장조', piece.title_en = 'Clarinet Concerto no. 3 in B-flat major, op. 11',
    piece.type = 'album', piece.opus_number = 'Op. 11',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 24720 AND piece.composer_id = 434
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'Allegro risoluto', part.name_en = 'Clarinet Concerto no. 3 in B-flat major, op. 11: I. Allegro risoluto',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 24720 AND p.composer_id = 434 AND part.part_key = 'musicbrainz:8236a7d2-4545-45ea-82e5-eca0d8787111' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:8236a7d2-4545-45ea-82e5-eca0d8787111', 1, 'I', 'Allegro risoluto', 'Clarinet Concerto no. 3 in B-flat major, op. 11: I. Allegro risoluto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 24720 AND p.composer_id = 434
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:8236a7d2-4545-45ea-82e5-eca0d8787111'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'Andante moderato', part.name_en = 'Clarinet Concerto no. 3 in B-flat major, op. 11: II. Andante moderato',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 24720 AND p.composer_id = 434 AND part.part_key = 'musicbrainz:13ca71fc-5f8c-4f87-b33f-3a1495a78975' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:13ca71fc-5f8c-4f87-b33f-3a1495a78975', 2, 'II', 'Andante moderato', 'Clarinet Concerto no. 3 in B-flat major, op. 11: II. Andante moderato', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 24720 AND p.composer_id = 434
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:13ca71fc-5f8c-4f87-b33f-3a1495a78975'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = 'Alla polacca', part.name_en = 'Clarinet Concerto no. 3 in B-flat major, op. 11: III. Alla polacca',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 24720 AND p.composer_id = 434 AND part.part_key = 'musicbrainz:ce236ec7-a572-40b7-a03a-88f7c99c36d7' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:ce236ec7-a572-40b7-a03a-88f7c99c36d7', 3, 'III', 'Alla polacca', 'Clarinet Concerto no. 3 in B-flat major, op. 11: III. Alla polacca', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 24720 AND p.composer_id = 434
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:ce236ec7-a572-40b7-a03a-88f7c99c36d7'
);


-- Op. 4 클라리넷 4중주 C단조

UPDATE pieces piece
SET piece.title = '클라리넷 4중주 C단조', piece.title_en = 'Clarinet Quartet in C minor, op. 4',
    piece.type = 'album', piece.opus_number = 'Op. 4',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 24227 AND piece.composer_id = 434
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'Allegro molto agitato', part.name_en = 'Clarinet Quartet in C minor, op. 4: I. Allegro molto agitato',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 24227 AND p.composer_id = 434 AND part.part_key = 'musicbrainz:5ef8edfe-0d4e-4fa2-94fa-6e18914559ef' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:5ef8edfe-0d4e-4fa2-94fa-6e18914559ef', 1, 'I', 'Allegro molto agitato', 'Clarinet Quartet in C minor, op. 4: I. Allegro molto agitato', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 24227 AND p.composer_id = 434
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:5ef8edfe-0d4e-4fa2-94fa-6e18914559ef'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'Menuetto', part.name_en = 'Clarinet Quartet in C minor, op. 4: II. Menuetto',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 24227 AND p.composer_id = 434 AND part.part_key = 'musicbrainz:63075876-81c2-4022-a1b5-799b06aaa1b1' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:63075876-81c2-4022-a1b5-799b06aaa1b1', 2, 'II', 'Menuetto', 'Clarinet Quartet in C minor, op. 4: II. Menuetto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 24227 AND p.composer_id = 434
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:63075876-81c2-4022-a1b5-799b06aaa1b1'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = 'Pastorale, un poco allegretto', part.name_en = 'Clarinet Quartet in C minor, op. 4: III. Pastorale, un poco allegretto',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 24227 AND p.composer_id = 434 AND part.part_key = 'musicbrainz:cb336123-b261-4a1b-9d60-45f835cc81a8' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:cb336123-b261-4a1b-9d60-45f835cc81a8', 3, 'III', 'Pastorale, un poco allegretto', 'Clarinet Quartet in C minor, op. 4: III. Pastorale, un poco allegretto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 24227 AND p.composer_id = 434
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:cb336123-b261-4a1b-9d60-45f835cc81a8'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = 'IV',
    part.name_ko = 'Rondo. Allegro', part.name_en = 'Clarinet Quartet in C minor, op. 4: IV. Rondo. Allegro',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 24227 AND p.composer_id = 434 AND part.part_key = 'musicbrainz:fc79aba5-08e5-4972-9347-d421f7ac7c97' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:fc79aba5-08e5-4972-9347-d421f7ac7c97', 4, 'IV', 'Rondo. Allegro', 'Clarinet Quartet in C minor, op. 4: IV. Rondo. Allegro', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 24227 AND p.composer_id = 434
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:fc79aba5-08e5-4972-9347-d421f7ac7c97'
);


-- Op. 7 클라리넷 4중주 D장조

UPDATE pieces piece
SET piece.title = '클라리넷 4중주 D장조', piece.title_en = 'Clarinet Quartet in D major, op. 7',
    piece.type = 'album', piece.opus_number = 'Op. 7',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 24181 AND piece.composer_id = 434
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'Allegro non tanto', part.name_en = 'Clarinet Quartet in D major, op. 7: I. Allegro non tanto',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 24181 AND p.composer_id = 434 AND part.part_key = 'musicbrainz:50b6f27c-dba7-472a-8098-b7b1bb387dfd' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:50b6f27c-dba7-472a-8098-b7b1bb387dfd', 1, 'I', 'Allegro non tanto', 'Clarinet Quartet in D major, op. 7: I. Allegro non tanto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 24181 AND p.composer_id = 434
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:50b6f27c-dba7-472a-8098-b7b1bb387dfd'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'Un poco largo', part.name_en = 'Clarinet Quartet in D major, op. 7: II. Un poco largo',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 24181 AND p.composer_id = 434 AND part.part_key = 'musicbrainz:d90773d3-00b8-43bc-9ea4-daffc419417f' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:d90773d3-00b8-43bc-9ea4-daffc419417f', 2, 'II', 'Un poco largo', 'Clarinet Quartet in D major, op. 7: II. Un poco largo', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 24181 AND p.composer_id = 434
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:d90773d3-00b8-43bc-9ea4-daffc419417f'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = 'Menuetto. Allegro & Trio', part.name_en = 'Clarinet Quartet in D major, op. 7: III. Menuetto. Allegro & Trio',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 24181 AND p.composer_id = 434 AND part.part_key = 'musicbrainz:7fd82a8f-8eaa-402a-8052-9a225556c901' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:7fd82a8f-8eaa-402a-8052-9a225556c901', 3, 'III', 'Menuetto. Allegro & Trio', 'Clarinet Quartet in D major, op. 7: III. Menuetto. Allegro & Trio', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 24181 AND p.composer_id = 434
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:7fd82a8f-8eaa-402a-8052-9a225556c901'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = 'IV',
    part.name_ko = 'Finale. Allegro', part.name_en = 'Clarinet Quartet in D major, op. 7: IV. Finale. Allegro',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 24181 AND p.composer_id = 434 AND part.part_key = 'musicbrainz:35c8f261-f8bb-47cf-86b2-c31faf0eaae9' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:35c8f261-f8bb-47cf-86b2-c31faf0eaae9', 4, 'IV', 'Finale. Allegro', 'Clarinet Quartet in D major, op. 7: IV. Finale. Allegro', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 24181 AND p.composer_id = 434
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:35c8f261-f8bb-47cf-86b2-c31faf0eaae9'
);


-- Op. 2 클라리넷 4중주 E♭장조

UPDATE pieces piece
SET piece.title = '클라리넷 4중주 E♭장조', piece.title_en = 'Clarinet Quartet in E-flat major, op. 2',
    piece.type = 'album', piece.opus_number = 'Op. 2',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 25363 AND piece.composer_id = 434
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'Poco adagio - Allegro', part.name_en = 'Clarinet Quartet in E-flat major, op. 2: I. Poco adagio - Allegro',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 25363 AND p.composer_id = 434 AND part.part_key = 'musicbrainz:5c78b3de-2b58-4a1a-a066-93d5ea2115da' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:5c78b3de-2b58-4a1a-a066-93d5ea2115da', 1, 'I', 'Poco adagio - Allegro', 'Clarinet Quartet in E-flat major, op. 2: I. Poco adagio - Allegro', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 25363 AND p.composer_id = 434
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:5c78b3de-2b58-4a1a-a066-93d5ea2115da'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'Romanze cantabile', part.name_en = 'Clarinet Quartet in E-flat major, op. 2: II. Romanze cantabile',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 25363 AND p.composer_id = 434 AND part.part_key = 'musicbrainz:ed158a9c-83e1-4546-b270-990d1d5fdc24' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:ed158a9c-83e1-4546-b270-990d1d5fdc24', 2, 'II', 'Romanze cantabile', 'Clarinet Quartet in E-flat major, op. 2: II. Romanze cantabile', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 25363 AND p.composer_id = 434
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:ed158a9c-83e1-4546-b270-990d1d5fdc24'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = 'Menuetto', part.name_en = 'Clarinet Quartet in E-flat major, op. 2: III. Menuetto',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 25363 AND p.composer_id = 434 AND part.part_key = 'musicbrainz:40fe998e-7d40-41c5-a19f-b15f76046ddc' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:40fe998e-7d40-41c5-a19f-b15f76046ddc', 3, 'III', 'Menuetto', 'Clarinet Quartet in E-flat major, op. 2: III. Menuetto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 25363 AND p.composer_id = 434
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:40fe998e-7d40-41c5-a19f-b15f76046ddc'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = 'IV',
    part.name_ko = 'Rondo: Allegro vivace', part.name_en = 'Clarinet Quartet in E-flat major, op. 2: IV. Rondo: Allegro vivace',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 25363 AND p.composer_id = 434 AND part.part_key = 'musicbrainz:5412ad06-567a-456f-9225-ad18ce511f81' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:5412ad06-567a-456f-9225-ad18ce511f81', 4, 'IV', 'Rondo: Allegro vivace', 'Clarinet Quartet in E-flat major, op. 2: IV. Rondo: Allegro vivace', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 25363 AND p.composer_id = 434
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:5412ad06-567a-456f-9225-ad18ce511f81'
);


-- None 클라리넷 협주곡 2번 F단조 "Grand"

UPDATE pieces piece
SET piece.title = '클라리넷 협주곡 2번 F단조 "Grand"', piece.title_en = 'Concerto for Clarinet and Orchestra no. 2 in F minor, op. 5 "Grand"',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 25925 AND piece.composer_id = 434
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'Allegro', part.name_en = 'Concerto for Clarinet and Orchestra no. 2 in F minor, op. 5 "Grand": I. Allegro',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 25925 AND p.composer_id = 434 AND part.part_key = 'musicbrainz:e424f336-8110-46be-972b-c255b8224059' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:e424f336-8110-46be-972b-c255b8224059', 1, 'I', 'Allegro', 'Concerto for Clarinet and Orchestra no. 2 in F minor, op. 5 "Grand": I. Allegro', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 25925 AND p.composer_id = 434
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:e424f336-8110-46be-972b-c255b8224059'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'Andante pastorale', part.name_en = 'Concerto for Clarinet and Orchestra no. 2 in F minor, op. 5 "Grand": II. Andante pastorale',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 25925 AND p.composer_id = 434 AND part.part_key = 'musicbrainz:221aedd2-4634-4f29-8cb1-db43c02f2a02' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:221aedd2-4634-4f29-8cb1-db43c02f2a02', 2, 'II', 'Andante pastorale', 'Concerto for Clarinet and Orchestra no. 2 in F minor, op. 5 "Grand": II. Andante pastorale', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 25925 AND p.composer_id = 434
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:221aedd2-4634-4f29-8cb1-db43c02f2a02'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = 'Rondo', part.name_en = 'Concerto for Clarinet and Orchestra no. 2 in F minor, op. 5 "Grand": III. Rondo',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 25925 AND p.composer_id = 434 AND part.part_key = 'musicbrainz:2e8e1343-59c3-4384-bb96-22bd32303bef' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:2e8e1343-59c3-4384-bb96-22bd32303bef', 3, 'III', 'Rondo', 'Concerto for Clarinet and Orchestra no. 2 in F minor, op. 5 "Grand": III. Rondo', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 25925 AND p.composer_id = 434
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:2e8e1343-59c3-4384-bb96-22bd32303bef'
);


-- None Coronation March

UPDATE pieces piece
SET piece.title = 'Coronation March', piece.title_en = 'Coronation March',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 24715 AND piece.composer_id = 434
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None 오페라 <Den lilla slafvinnan>

UPDATE pieces piece
SET piece.title = '오페라 <Den lilla slafvinnan>', piece.title_en = 'Den lilla slafvinnan',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 23068 AND piece.composer_id = 434
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'Uvertyr', part.name_en = 'Den lilla slafvinnan: Uvertyr',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 23068 AND p.composer_id = 434 AND part.part_key = 'musicbrainz:e43c3d21-a5b5-467d-9ded-afe2b550ff6f' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:e43c3d21-a5b5-467d-9ded-afe2b550ff6f', 1, NULL, 'Uvertyr', 'Den lilla slafvinnan: Uvertyr', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 23068 AND p.composer_id = 434
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:e43c3d21-a5b5-467d-9ded-afe2b550ff6f'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'Akt I', part.name_en = 'Den lilla slafvinnan: Akt I',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 23068 AND p.composer_id = 434 AND part.part_key = 'musicbrainz:bbcefdeb-28f8-46eb-93c8-7b860267d2e2' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:bbcefdeb-28f8-46eb-93c8-7b860267d2e2', 2, NULL, 'Akt I', 'Den lilla slafvinnan: Akt I', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 23068 AND p.composer_id = 434
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:bbcefdeb-28f8-46eb-93c8-7b860267d2e2'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = NULL,
    part.name_ko = 'Akt II', part.name_en = 'Den lilla slafvinnan: Akt II',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 23068 AND p.composer_id = 434 AND part.part_key = 'musicbrainz:a1d14f09-89f6-43d9-84b5-a43510beb48b' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:a1d14f09-89f6-43d9-84b5-a43510beb48b', 3, NULL, 'Akt II', 'Den lilla slafvinnan: Akt II', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 23068 AND p.composer_id = 434
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:a1d14f09-89f6-43d9-84b5-a43510beb48b'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = NULL,
    part.name_ko = 'Akt III', part.name_en = 'Den lilla slafvinnan: Akt III',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 23068 AND p.composer_id = 434 AND part.part_key = 'musicbrainz:22bf3add-e252-4bf5-8002-8330de9d4686' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:22bf3add-e252-4bf5-8002-8330de9d4686', 4, NULL, 'Akt III', 'Den lilla slafvinnan: Akt III', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 23068 AND p.composer_id = 434
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:22bf3add-e252-4bf5-8002-8330de9d4686'
);


-- Op. 9 디베르티멘토 C장조

UPDATE pieces piece
SET piece.title = '디베르티멘토 C장조', piece.title_en = 'Divertimento in C major, op. 9',
    piece.type = 'album', piece.opus_number = 'Op. 9',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 25532 AND piece.composer_id = 434
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'Allegro', part.name_en = 'Divertimento in C major, op. 9: I. Allegro',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 25532 AND p.composer_id = 434 AND part.part_key = 'musicbrainz:8c9cf31e-8cec-4ebc-b3b7-008b4496c5ef' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:8c9cf31e-8cec-4ebc-b3b7-008b4496c5ef', 1, 'I', 'Allegro', 'Divertimento in C major, op. 9: I. Allegro', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 25532 AND p.composer_id = 434
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:8c9cf31e-8cec-4ebc-b3b7-008b4496c5ef'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'Andante poco adagio', part.name_en = 'Divertimento in C major, op. 9: II. Andante poco adagio',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 25532 AND p.composer_id = 434 AND part.part_key = 'musicbrainz:8fc76630-1ed5-41a3-8f6e-2d1d1be324a8' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:8fc76630-1ed5-41a3-8f6e-2d1d1be324a8', 2, 'II', 'Andante poco adagio', 'Divertimento in C major, op. 9: II. Andante poco adagio', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 25532 AND p.composer_id = 434
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:8fc76630-1ed5-41a3-8f6e-2d1d1be324a8'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = 'Allegro', part.name_en = 'Divertimento in C major, op. 9: III. Allegro',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 25532 AND p.composer_id = 434 AND part.part_key = 'musicbrainz:72825870-fe9c-4153-957e-3ee908e76e68' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:72825870-fe9c-4153-957e-3ee908e76e68', 3, 'III', 'Allegro', 'Divertimento in C major, op. 9: III. Allegro', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 25532 AND p.composer_id = 434
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:72825870-fe9c-4153-957e-3ee908e76e68'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = 'IV',
    part.name_ko = 'Allegro vivace', part.name_en = 'Divertimento in C major, op. 9: IV. Allegro vivace',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 25532 AND p.composer_id = 434 AND part.part_key = 'musicbrainz:7e05053f-3fbe-4ca9-8168-5cc51b71457e' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:7e05053f-3fbe-4ca9-8168-5cc51b71457e', 4, 'IV', 'Allegro vivace', 'Divertimento in C major, op. 9: IV. Allegro vivace', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 25532 AND p.composer_id = 434
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:7e05053f-3fbe-4ca9-8168-5cc51b71457e'
);


-- Op. 6/2 Duo für zwei Klarinetten Nr. 2 C-dur

UPDATE pieces piece
SET piece.title = 'Duo für zwei Klarinetten Nr. 2 C-dur', piece.title_en = 'Duo für zwei Klarinetten Nr. 2 C-dur, op. 6/2',
    piece.type = 'album', piece.opus_number = 'Op. 6/2',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 23445 AND piece.composer_id = 434
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'Allegro', part.name_en = 'Duo für zwei Klarinetten Nr. 2 C-dur, op. 6/2: I. Allegro',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 23445 AND p.composer_id = 434 AND part.part_key = 'musicbrainz:e2ddba13-5b37-402c-a659-e24032cfe44e' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:e2ddba13-5b37-402c-a659-e24032cfe44e', 1, 'I', 'Allegro', 'Duo für zwei Klarinetten Nr. 2 C-dur, op. 6/2: I. Allegro', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 23445 AND p.composer_id = 434
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:e2ddba13-5b37-402c-a659-e24032cfe44e'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'Andante con Moto - Allegro Vivace', part.name_en = 'Duo für zwei Klarinetten Nr. 2 C-dur, op. 6/2: II. Andante con Moto - Allegro Vivace',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 23445 AND p.composer_id = 434 AND part.part_key = 'musicbrainz:74ccf0bf-320e-4b46-883a-22ffc2642ed5' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:74ccf0bf-320e-4b46-883a-22ffc2642ed5', 2, 'II', 'Andante con Moto - Allegro Vivace', 'Duo für zwei Klarinetten Nr. 2 C-dur, op. 6/2: II. Andante con Moto - Allegro Vivace', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 23445 AND p.composer_id = 434
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:74ccf0bf-320e-4b46-883a-22ffc2642ed5'
);


-- None Introduction et air suédois varié, op. 12 (pour clarinette et orchestre d´harmonie)

UPDATE pieces piece
SET piece.title = 'Introduction et air suédois varié, op. 12 (pour clarinette et orchestre d´harmonie)', piece.title_en = 'Introduction et air suédois varié, op. 12 (pour clarinette et orchestre d´harmonie)',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 23074 AND piece.composer_id = 434
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None 행진곡 9번

UPDATE pieces piece
SET piece.title = '행진곡 9번', piece.title_en = 'March no. 9 (Kenthorn)',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 25516 AND piece.composer_id = 434
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Potpourri (Concert Trio)

UPDATE pieces piece
SET piece.title = 'Potpourri (Concert Trio)', piece.title_en = 'Potpourri (Concert Trio)',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 25534 AND piece.composer_id = 434
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Rondo for Two Clarinets and Piano

UPDATE pieces piece
SET piece.title = 'Rondo for Two Clarinets and Piano', piece.title_en = 'Rondo for Two Clarinets and Piano',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 23208 AND piece.composer_id = 434
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- Op. 3 협주 교향곡 B♭장조

UPDATE pieces piece
SET piece.title = '협주 교향곡 B♭장조', piece.title_en = 'Sinfonia Concertante in B-flat major, op. 3',
    piece.type = 'album', piece.opus_number = 'Op. 3',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 23690 AND piece.composer_id = 434
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'Allegro', part.name_en = 'Sinfonia Concertante in B-flat major, op. 3: I. Allegro',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 23690 AND p.composer_id = 434 AND part.part_key = 'musicbrainz:57e9ba5a-fe5a-4dd2-af44-9983d6e5fc17' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:57e9ba5a-fe5a-4dd2-af44-9983d6e5fc17', 1, 'I', 'Allegro', 'Sinfonia Concertante in B-flat major, op. 3: I. Allegro', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 23690 AND p.composer_id = 434
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:57e9ba5a-fe5a-4dd2-af44-9983d6e5fc17'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'Andante sostenuto', part.name_en = 'Sinfonia Concertante in B-flat major, op. 3: II. Andante sostenuto',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 23690 AND p.composer_id = 434 AND part.part_key = 'musicbrainz:ba0880a3-d225-4544-82d8-e3ad515eea79' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:ba0880a3-d225-4544-82d8-e3ad515eea79', 2, 'II', 'Andante sostenuto', 'Sinfonia Concertante in B-flat major, op. 3: II. Andante sostenuto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 23690 AND p.composer_id = 434
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:ba0880a3-d225-4544-82d8-e3ad515eea79'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = 'Allegro ma non troppo', part.name_en = 'Sinfonia Concertante in B-flat major, op. 3: III. Allegro ma non troppo',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 23690 AND p.composer_id = 434 AND part.part_key = 'musicbrainz:bdb77d29-e8d9-4f58-ba4b-1881f394b289' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:bdb77d29-e8d9-4f58-ba4b-1881f394b289', 3, 'III', 'Allegro ma non troppo', 'Sinfonia Concertante in B-flat major, op. 3: III. Allegro ma non troppo', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 23690 AND p.composer_id = 434
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:bdb77d29-e8d9-4f58-ba4b-1881f394b289'
);

-- 숨길 seed 작품 없음

-- ===== Erling Brene (composer_id 435) =====
-- 작품을 MusicBrainz 작품 구조로 다시 짠다(6차 자동). 작품 1개(묶음 0, 다악장 1, 낱곡 0),
-- 새 작품 0개, part 3개, 그 아래 0개.
-- seed 1개 중 1개를 작품·part 에 잇고, 0개를 숨기고, 0개는 그대로 둔다.

-- Op. 20 Concerto senza solennità

UPDATE pieces piece
SET piece.title = 'Concerto senza solennità', piece.title_en = 'Concerto senza solennità, op. 20',
    piece.type = 'album', piece.opus_number = 'Op. 20',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 23865 AND piece.composer_id = 435
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'Allegro vivo', part.name_en = 'Concerto senza solennità, op. 20: I. Allegro vivo',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 23865 AND p.composer_id = 435 AND part.part_key = 'musicbrainz:9759b109-1a51-4af1-9aba-362e1c5c4e9b' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:9759b109-1a51-4af1-9aba-362e1c5c4e9b', 1, 'I', 'Allegro vivo', 'Concerto senza solennità, op. 20: I. Allegro vivo', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 23865 AND p.composer_id = 435
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:9759b109-1a51-4af1-9aba-362e1c5c4e9b'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'Andante', part.name_en = 'Concerto senza solennità, op. 20: II. Andante',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 23865 AND p.composer_id = 435 AND part.part_key = 'musicbrainz:465b5e20-0c8e-4958-b7bf-74de8b0a747e' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:465b5e20-0c8e-4958-b7bf-74de8b0a747e', 2, 'II', 'Andante', 'Concerto senza solennità, op. 20: II. Andante', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 23865 AND p.composer_id = 435
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:465b5e20-0c8e-4958-b7bf-74de8b0a747e'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = 'Frettoloso', part.name_en = 'Concerto senza solennità, op. 20: III. Frettoloso',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 23865 AND p.composer_id = 435 AND part.part_key = 'musicbrainz:3f161b66-ad8e-4a0e-9241-bc82c0fd1774' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:3f161b66-ad8e-4a0e-9241-bc82c0fd1774', 3, 'III', 'Frettoloso', 'Concerto senza solennità, op. 20: III. Frettoloso', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 23865 AND p.composer_id = 435
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:3f161b66-ad8e-4a0e-9241-bc82c0fd1774'
);

-- 숨길 seed 작품 없음

-- ===== Pierre Gaviniès (composer_id 439) =====
-- 작품을 MusicBrainz 작품 구조로 다시 짠다(6차 자동). 작품 1개(묶음 0, 다악장 1, 낱곡 0),
-- 새 작품 0개, part 3개, 그 아래 0개.
-- seed 1개 중 1개를 작품·part 에 잇고, 0개를 숨기고, 0개는 그대로 둔다.

-- None Sonata I "Le Tombeau"

UPDATE pieces piece
SET piece.title = 'Sonata I "Le Tombeau"', piece.title_en = 'Sonata I "Le Tombeau"',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 25987 AND piece.composer_id = 439
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'Adagio', part.name_en = 'Sonata I "Le Tombeau": I. Adagio',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 25987 AND p.composer_id = 439 AND part.part_key = 'musicbrainz:99395aa2-160c-4f68-83af-f47e5dc3eb9c' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:99395aa2-160c-4f68-83af-f47e5dc3eb9c', 1, 'I', 'Adagio', 'Sonata I "Le Tombeau": I. Adagio', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 25987 AND p.composer_id = 439
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:99395aa2-160c-4f68-83af-f47e5dc3eb9c'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'Allegro ma affetuoso', part.name_en = 'Sonata I "Le Tombeau": II. Allegro ma affetuoso',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 25987 AND p.composer_id = 439 AND part.part_key = 'musicbrainz:9f36a8ad-05f6-411e-8b6a-41fe9ec81afa' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:9f36a8ad-05f6-411e-8b6a-41fe9ec81afa', 2, 'II', 'Allegro ma affetuoso', 'Sonata I "Le Tombeau": II. Allegro ma affetuoso', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 25987 AND p.composer_id = 439
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:9f36a8ad-05f6-411e-8b6a-41fe9ec81afa'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = 'Allegro con fuoco, ma non troppo presto', part.name_en = 'Sonata I "Le Tombeau": III. Allegro con fuoco, ma non troppo presto',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 25987 AND p.composer_id = 439 AND part.part_key = 'musicbrainz:04c0d34e-aeeb-427e-ac56-e035e960645b' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:04c0d34e-aeeb-427e-ac56-e035e960645b', 3, 'III', 'Allegro con fuoco, ma non troppo presto', 'Sonata I "Le Tombeau": III. Allegro con fuoco, ma non troppo presto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 25987 AND p.composer_id = 439
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:04c0d34e-aeeb-427e-ac56-e035e960645b'
);

-- 숨길 seed 작품 없음

-- ===== Joaquín Valverde Sanjuán (composer_id 440) =====
-- 작품을 MusicBrainz 작품 구조로 다시 짠다(6차 자동). 작품 2개(묶음 0, 다악장 0, 낱곡 2),
-- 새 작품 1개, part 0개, 그 아래 0개.
-- seed 1개 중 1개를 작품·part 에 잇고, 0개를 숨기고, 0개는 그대로 둔다.

-- None Gente menuda

UPDATE pieces piece
SET piece.title = 'Gente menuda', piece.title_en = 'Gente menuda',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 24550 AND piece.composer_id = 440
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None 가곡 <Clavelitos>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '가곡 <Clavelitos>', 'Clavelitos', 'song', NULL, NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 440
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '가곡 <Clavelitos>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '2b3bd99f-c813-3c62-acc5-7b0ffb40b76d'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '2b3bd99f-c813-3c62-acc5-7b0ffb40b76d'
FROM pieces p
WHERE p.composer_id = 440 AND p.title = '가곡 <Clavelitos>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '2b3bd99f-c813-3c62-acc5-7b0ffb40b76d'
);

-- 숨길 seed 작품 없음

-- ===== Friedrich Wilhelm Marpurg (composer_id 442) =====
-- 작품을 MusicBrainz 작품 구조로 다시 짠다(6차 자동). 작품 2개(묶음 2, 다악장 0, 낱곡 0),
-- 새 작품 1개, part 7개, 그 아래 19개.
-- seed 3개 중 1개를 작품·part 에 잇고, 1개를 숨기고, 1개는 그대로 둔다.

-- None Les Principes du clavecin

UPDATE pieces piece
SET piece.title = 'Les Principes du clavecin', piece.title_en = 'Les Principes du clavecin',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 24433 AND piece.composer_id = 442
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'Allegro en sol majeur', part.name_en = 'Les Principes du clavecin: Allegro en sol majeur',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 24433 AND p.composer_id = 442 AND part.part_key = 'musicbrainz:1dc5052e-35c0-462b-bb48-68fe6a97c4ec' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:1dc5052e-35c0-462b-bb48-68fe6a97c4ec', 1, NULL, 'Allegro en sol majeur', 'Les Principes du clavecin: Allegro en sol majeur', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 24433 AND p.composer_id = 442
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:1dc5052e-35c0-462b-bb48-68fe6a97c4ec'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'Allegro en la majeur', part.name_en = 'Les Principes du clavecin: Allegro en la majeur',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 24433 AND p.composer_id = 442 AND part.part_key = 'musicbrainz:b44f7017-a7df-4d76-b896-69adfc9c9dd7' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:b44f7017-a7df-4d76-b896-69adfc9c9dd7', 2, NULL, 'Allegro en la majeur', 'Les Principes du clavecin: Allegro en la majeur', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 24433 AND p.composer_id = 442
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:b44f7017-a7df-4d76-b896-69adfc9c9dd7'
);


-- None Pièces de clavecin

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, 'Pièces de clavecin', 'Pièces de clavecin', 'album', NULL, NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 442
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = 'Pièces de clavecin'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '526dd1cf-056b-4349-94b4-f3e48fc6adba'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '526dd1cf-056b-4349-94b4-f3e48fc6adba'
FROM pieces p
WHERE p.composer_id = 442 AND p.title = 'Pièces de clavecin' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '526dd1cf-056b-4349-94b4-f3e48fc6adba'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:8c09dd22-40d1-465d-b4d8-b2b814a2403a', 1, NULL, 'Première Suite', 'Première Suite', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 442 AND p.title = 'Pièces de clavecin' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:8c09dd22-40d1-465d-b4d8-b2b814a2403a'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:e4a9b6ba-17d7-494a-bae4-3d6014fb2a52', 1, NULL, 'Les Avanturiers', 'Première Suite: I. Les Avanturiers', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:8c09dd22-40d1-465d-b4d8-b2b814a2403a'
WHERE p.composer_id = 442 AND p.title = 'Pièces de clavecin' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:e4a9b6ba-17d7-494a-bae4-3d6014fb2a52'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:70391529-8ade-4934-afce-c7c2c74c5bc8', 2, NULL, 'Le Petit Badinage', 'Première Suite: II. Le Petit Badinage', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:8c09dd22-40d1-465d-b4d8-b2b814a2403a'
WHERE p.composer_id = 442 AND p.title = 'Pièces de clavecin' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:70391529-8ade-4934-afce-c7c2c74c5bc8'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:ecbe8b91-0b04-42d0-8604-38694f686255', 3, NULL, 'Menuet (et Altro)', 'Première Suite: III. Menuet (et Altro)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:8c09dd22-40d1-465d-b4d8-b2b814a2403a'
WHERE p.composer_id = 442 AND p.title = 'Pièces de clavecin' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:ecbe8b91-0b04-42d0-8604-38694f686255'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:b1f1ded7-4339-4ef3-9549-93c43d8c6013', 2, NULL, 'Deuxième Suite', 'Deuxième Suite', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 442 AND p.title = 'Pièces de clavecin' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:b1f1ded7-4339-4ef3-9549-93c43d8c6013'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:2e25cbaf-d9d5-4b2d-9a22-8fbbf10d9162', 1, NULL, 'Le Songe des Muses', 'Deuxième Suite: I. Le Songe des Muses', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:b1f1ded7-4339-4ef3-9549-93c43d8c6013'
WHERE p.composer_id = 442 AND p.title = 'Pièces de clavecin' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:2e25cbaf-d9d5-4b2d-9a22-8fbbf10d9162'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:0739d91a-b8db-4c80-95f0-db74e5a9b173', 2, NULL, 'La Voltigeuse', 'Deuxième Suite: II. La Voltigeuse', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:b1f1ded7-4339-4ef3-9549-93c43d8c6013'
WHERE p.composer_id = 442 AND p.title = 'Pièces de clavecin' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:0739d91a-b8db-4c80-95f0-db74e5a9b173'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:bc5b4dfe-b2af-43fe-a97d-1e96b0a78e52', 3, NULL, 'Troisième Suite', 'Troisième Suite', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 442 AND p.title = 'Pièces de clavecin' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:bc5b4dfe-b2af-43fe-a97d-1e96b0a78e52'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:0b82695d-36d8-493d-aa06-2ef2020ef56b', 1, NULL, 'Tambourins I, II et III', 'Troisième Suite: I. Tambourins I, II et III', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:bc5b4dfe-b2af-43fe-a97d-1e96b0a78e52'
WHERE p.composer_id = 442 AND p.title = 'Pièces de clavecin' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:0b82695d-36d8-493d-aa06-2ef2020ef56b'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:8f56328b-5dd3-4e79-993b-80c3157b7f7d', 2, NULL, 'Le Coucou', 'Troisième Suite: II. Le Coucou', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:bc5b4dfe-b2af-43fe-a97d-1e96b0a78e52'
WHERE p.composer_id = 442 AND p.title = 'Pièces de clavecin' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:8f56328b-5dd3-4e79-993b-80c3157b7f7d'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:f01d813d-8864-47d3-b167-82f1e44273b7', 3, NULL, 'La Plaintive Philis', 'Troisième Suite: III. La Plaintive Philis', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:bc5b4dfe-b2af-43fe-a97d-1e96b0a78e52'
WHERE p.composer_id = 442 AND p.title = 'Pièces de clavecin' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:f01d813d-8864-47d3-b167-82f1e44273b7'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:adfdc6d0-5a3e-4d79-9dba-3769271fbc53', 4, NULL, 'Quatrième Suite', 'Quatrième Suite', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 442 AND p.title = 'Pièces de clavecin' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:adfdc6d0-5a3e-4d79-9dba-3769271fbc53'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:ad3c3b55-6b23-492c-bbdb-c4fc17a048bc', 1, NULL, 'Première Gavotte et Double', 'Quatrième Suite: I. Première Gavotte et Double', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:adfdc6d0-5a3e-4d79-9dba-3769271fbc53'
WHERE p.composer_id = 442 AND p.title = 'Pièces de clavecin' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:ad3c3b55-6b23-492c-bbdb-c4fc17a048bc'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:bf52fb75-f53d-4e1e-b49d-53ca33a9f721', 2, NULL, 'Seconde Gavotte et Double', 'Quatrième Suite: II. Seconde Gavotte et Double', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:adfdc6d0-5a3e-4d79-9dba-3769271fbc53'
WHERE p.composer_id = 442 AND p.title = 'Pièces de clavecin' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:bf52fb75-f53d-4e1e-b49d-53ca33a9f721'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:48ff95d6-f311-4f0d-b783-4a53b337df2c', 3, NULL, 'Les Petits Trots', 'Quatrième Suite: III. Les Petits Trots', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:adfdc6d0-5a3e-4d79-9dba-3769271fbc53'
WHERE p.composer_id = 442 AND p.title = 'Pièces de clavecin' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:48ff95d6-f311-4f0d-b783-4a53b337df2c'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:2141cdc1-1af5-4796-ac70-a3d294a66eb0', 4, NULL, 'Les Remouleurs I et II', 'Quatrième Suite: IV. Les Remouleurs I et II', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:adfdc6d0-5a3e-4d79-9dba-3769271fbc53'
WHERE p.composer_id = 442 AND p.title = 'Pièces de clavecin' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:2141cdc1-1af5-4796-ac70-a3d294a66eb0'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:f07e2897-bc8f-4e4f-8e93-c6e399a39d95', 5, NULL, 'La Frivole', 'Quatrième Suite: V. La Frivole', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:adfdc6d0-5a3e-4d79-9dba-3769271fbc53'
WHERE p.composer_id = 442 AND p.title = 'Pièces de clavecin' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:f07e2897-bc8f-4e4f-8e93-c6e399a39d95'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:e7a04ebe-5522-4d46-8f46-08638e5525a8', 5, NULL, 'Cinquième Suite', 'Cinquième Suite', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 442 AND p.title = 'Pièces de clavecin' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:e7a04ebe-5522-4d46-8f46-08638e5525a8'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:b151e1d6-3b51-4462-831a-cdbcb21fb87e', 1, NULL, 'La Nymphe Marine', 'Cinquième Suite: I. La Nymphe Marine', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:e7a04ebe-5522-4d46-8f46-08638e5525a8'
WHERE p.composer_id = 442 AND p.title = 'Pièces de clavecin' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:b151e1d6-3b51-4462-831a-cdbcb21fb87e'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:137e401e-cc16-4de7-86d5-c42556b723e6', 2, NULL, 'Feste provençale / Tambourins I et II / Musettes I et II', 'Cinquième Suite: II. Feste provençale / Tambourins I et II / Musettes I et II', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:e7a04ebe-5522-4d46-8f46-08638e5525a8'
WHERE p.composer_id = 442 AND p.title = 'Pièces de clavecin' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:137e401e-cc16-4de7-86d5-c42556b723e6'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:0ff5f52b-d2ef-4c98-a21f-fbdfb0091b1d', 3, NULL, 'Le Diable à quatre', 'Cinquième Suite: III. Le Diable à quatre', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:e7a04ebe-5522-4d46-8f46-08638e5525a8'
WHERE p.composer_id = 442 AND p.title = 'Pièces de clavecin' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:0ff5f52b-d2ef-4c98-a21f-fbdfb0091b1d'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:47a4203f-df27-4dcc-af4e-1ff24592cdec', 4, NULL, 'Menuet I et Double', 'Cinquième Suite: IV. Menuet I et Double', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:e7a04ebe-5522-4d46-8f46-08638e5525a8'
WHERE p.composer_id = 442 AND p.title = 'Pièces de clavecin' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:47a4203f-df27-4dcc-af4e-1ff24592cdec'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:e255be42-6310-47a8-96c5-173a88aea35d', 5, NULL, 'Menuet II et Double', 'Cinquième Suite: V. Menuet II et Double', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:e7a04ebe-5522-4d46-8f46-08638e5525a8'
WHERE p.composer_id = 442 AND p.title = 'Pièces de clavecin' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:e255be42-6310-47a8-96c5-173a88aea35d'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:51b55dfe-8c9a-4121-8fad-7300b8814612', 6, NULL, 'Les Drÿades', 'Cinquième Suite: VI. Les Drÿades', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:e7a04ebe-5522-4d46-8f46-08638e5525a8'
WHERE p.composer_id = 442 AND p.title = 'Pièces de clavecin' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:51b55dfe-8c9a-4121-8fad-7300b8814612'
);

-- 카탈로그에 대응이 없는 seed 작품 1개를 목록에서 숨긴다(지우지 않음).
UPDATE pieces piece
SET piece.hidden_reason = 'catalog_unmatched'
WHERE piece.composer_id = 442 AND piece.origin = 'seed' AND piece.hidden_reason IS NULL
  AND piece.id IN (
    23225
  )
  AND NOT EXISTS (SELECT 1 FROM performance_sectors sector WHERE sector.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM piece_parts linking WHERE linking.linked_piece_id = piece.id);

-- ===== Joseph Touchemoulin (composer_id 444) =====
-- 작품을 MusicBrainz 작품 구조로 다시 짠다(6차 자동). 작품 1개(묶음 0, 다악장 0, 낱곡 1),
-- 새 작품 0개, part 0개, 그 아래 0개.
-- seed 1개 중 1개를 작품·part 에 잇고, 0개를 숨기고, 0개는 그대로 둔다.

-- None 신포니아 B♭장조

UPDATE pieces piece
SET piece.title = '신포니아 B♭장조', piece.title_en = 'Sinfonia in B-flat major',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 24511 AND piece.composer_id = 444
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

-- 숨길 seed 작품 없음

-- ===== 나리타 다메조 (composer_id 446) =====
-- 작품을 MusicBrainz 작품 구조로 다시 짠다(6차 자동). 작품 0개(묶음 0, 다악장 0, 낱곡 0),
-- 새 작품 0개, part 0개, 그 아래 0개.
-- seed 4개 중 0개를 작품·part 에 잇고, 4개를 숨기고, 0개는 그대로 둔다.

-- 카탈로그에 대응이 없는 seed 작품 4개를 목록에서 숨긴다(지우지 않음).
UPDATE pieces piece
SET piece.hidden_reason = 'catalog_unmatched'
WHERE piece.composer_id = 446 AND piece.origin = 'seed' AND piece.hidden_reason IS NULL
  AND piece.id IN (
    23073, 23075, 23597, 25395
  )
  AND NOT EXISTS (SELECT 1 FROM performance_sectors sector WHERE sector.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM piece_parts linking WHERE linking.linked_piece_id = piece.id);

-- ===== Arthur Bruhns (composer_id 447) =====
-- 작품을 MusicBrainz 작품 구조로 다시 짠다(6차 자동). 작품 2개(묶음 0, 다악장 0, 낱곡 2),
-- 새 작품 0개, part 0개, 그 아래 0개.
-- seed 2개 중 2개를 작품·part 에 잇고, 0개를 숨기고, 0개는 그대로 둔다.

-- None 가곡 <S' ist Mai!>

UPDATE pieces piece
SET piece.title = '가곡 <S'' ist Mai!>', piece.title_en = 'S'' ist Mai!',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 25542 AND piece.composer_id = 447
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None 가곡 <Tis May!>

UPDATE pieces piece
SET piece.title = '가곡 <Tis May!>', piece.title_en = 'Tis May!',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 24980 AND piece.composer_id = 447
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

-- 숨길 seed 작품 없음

-- ===== 지크문트 폰 하우제거 (composer_id 448) =====
-- 작품을 MusicBrainz 작품 구조로 다시 짠다(6차 자동). 작품 6개(묶음 0, 다악장 2, 낱곡 4),
-- 새 작품 0개, part 6개, 그 아래 0개.
-- seed 6개 중 6개를 작품·part 에 잇고, 0개를 숨기고, 0개는 그대로 둔다.

-- None Aufklänge

UPDATE pieces piece
SET piece.title = 'Aufklänge', piece.title_en = 'Aufklänge',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 25048 AND piece.composer_id = 448
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Barbarossa

UPDATE pieces piece
SET piece.title = 'Barbarossa', piece.title_en = 'Barbarossa',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 23219 AND piece.composer_id = 448
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'Die Not des Volkes', part.name_en = 'Barbarossa: I. Die Not des Volkes',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 23219 AND p.composer_id = 448 AND part.part_key = 'musicbrainz:35181db1-afe6-4111-ab17-2419f75b48fd' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:35181db1-afe6-4111-ab17-2419f75b48fd', 1, 'I', 'Die Not des Volkes', 'Barbarossa: I. Die Not des Volkes', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 23219 AND p.composer_id = 448
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:35181db1-afe6-4111-ab17-2419f75b48fd'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'Der Zauberberg', part.name_en = 'Barbarossa: II. Der Zauberberg',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 23219 AND p.composer_id = 448 AND part.part_key = 'musicbrainz:70b5edeb-877a-4650-be2d-2105eefca384' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:70b5edeb-877a-4650-be2d-2105eefca384', 2, 'II', 'Der Zauberberg', 'Barbarossa: II. Der Zauberberg', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 23219 AND p.composer_id = 448
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:70b5edeb-877a-4650-be2d-2105eefca384'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = 'Erwachen', part.name_en = 'Barbarossa: III. Erwachen',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 23219 AND p.composer_id = 448 AND part.part_key = 'musicbrainz:57e56334-2280-4613-8c38-5a5e03850266' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:57e56334-2280-4613-8c38-5a5e03850266', 3, 'III', 'Erwachen', 'Barbarossa: III. Erwachen', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 23219 AND p.composer_id = 448
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:57e56334-2280-4613-8c38-5a5e03850266'
);


-- None Dionysische Phantasie

UPDATE pieces piece
SET piece.title = 'Dionysische Phantasie', piece.title_en = 'Dionysische Phantasie',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 24806 AND piece.composer_id = 448
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Drei Hymnen an die Nacht

UPDATE pieces piece
SET piece.title = 'Drei Hymnen an die Nacht', piece.title_en = 'Drei Hymnen an die Nacht',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 25167 AND piece.composer_id = 448
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'Stiller der Nacht', part.name_en = 'Drei Hymen an die Nacht: I. Stiller der Nacht',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 25167 AND p.composer_id = 448 AND part.part_key = 'musicbrainz:052779ce-c6b9-4e63-a80c-c27d13c022e5' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:052779ce-c6b9-4e63-a80c-c27d13c022e5', 1, 'I', 'Stiller der Nacht', 'Drei Hymen an die Nacht: I. Stiller der Nacht', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 25167 AND p.composer_id = 448
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:052779ce-c6b9-4e63-a80c-c27d13c022e5'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'Unruhe der Nacht', part.name_en = 'Drei Hymen an die Nacht: II. Unruhe der Nacht',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 25167 AND p.composer_id = 448 AND part.part_key = 'musicbrainz:1f741400-e703-47f7-8190-c9e36105a7a5' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:1f741400-e703-47f7-8190-c9e36105a7a5', 2, 'II', 'Unruhe der Nacht', 'Drei Hymen an die Nacht: II. Unruhe der Nacht', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 25167 AND p.composer_id = 448
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:1f741400-e703-47f7-8190-c9e36105a7a5'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = 'Unter Sternen', part.name_en = 'Drei Hymen an die Nacht: III. Unter Sternen',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 25167 AND p.composer_id = 448 AND part.part_key = 'musicbrainz:3302b931-8d24-4595-b525-0f76403d4d53' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:3302b931-8d24-4595-b525-0f76403d4d53', 3, 'III', 'Unter Sternen', 'Drei Hymen an die Nacht: III. Unter Sternen', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 25167 AND p.composer_id = 448
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:3302b931-8d24-4595-b525-0f76403d4d53'
);


-- None Natursymphonie

UPDATE pieces piece
SET piece.title = 'Natursymphonie', piece.title_en = 'Natursymphonie',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 23408 AND piece.composer_id = 448
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Wieland der Schmied

UPDATE pieces piece
SET piece.title = 'Wieland der Schmied', piece.title_en = 'Wieland der Schmied',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 23407 AND piece.composer_id = 448
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

-- 숨길 seed 작품 없음

-- ===== Miguel Llobet (composer_id 449) =====
-- 작품을 MusicBrainz 작품 구조로 다시 짠다(6차 자동). 작품 14개(묶음 0, 다악장 0, 낱곡 14),
-- 새 작품 1개, part 0개, 그 아래 0개.
-- seed 13개 중 13개를 작품·part 에 잇고, 0개를 숨기고, 0개는 그대로 둔다.

-- None El mestre

UPDATE pieces piece
SET piece.title = 'El mestre', piece.title_en = 'El mestre',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 24197 AND piece.composer_id = 449
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None L'hereu Riera

UPDATE pieces piece
SET piece.title = 'L''hereu Riera', piece.title_en = 'L''hereu Riera',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 24625 AND piece.composer_id = 449
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None La filadora

UPDATE pieces piece
SET piece.title = 'La filadora', piece.title_en = 'La filadora',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 24609 AND piece.composer_id = 449
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None La filla del marxant

UPDATE pieces piece
SET piece.title = 'La filla del marxant', piece.title_en = 'La filla del marxant',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 23845 AND piece.composer_id = 449
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None La pastoreta

UPDATE pieces piece
SET piece.title = 'La pastoreta', piece.title_en = 'La pastoreta',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 25341 AND piece.composer_id = 449
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None La preço de Lleida

UPDATE pieces piece
SET piece.title = 'La preço de Lleida', piece.title_en = 'La preço de Lleida',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 24947 AND piece.composer_id = 449
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Leonesa

UPDATE pieces piece
SET piece.title = 'Leonesa', piece.title_en = 'Leonesa',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 23295 AND piece.composer_id = 449
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Lo rossinyol

UPDATE pieces piece
SET piece.title = 'Lo rossinyol', piece.title_en = 'Lo rossinyol',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 24684 AND piece.composer_id = 449
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None 마주르카

UPDATE pieces piece
SET piece.title = '마주르카', piece.title_en = 'Mazurka',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 25557 AND piece.composer_id = 449
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Plany

UPDATE pieces piece
SET piece.title = 'Plany', piece.title_en = 'Plany',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 25296 AND piece.composer_id = 449
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Romanza

UPDATE pieces piece
SET piece.title = 'Romanza', piece.title_en = 'Romanza',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 23201 AND piece.composer_id = 449
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Scherzo-vals for guitar

UPDATE pieces piece
SET piece.title = 'Scherzo-vals for guitar', piece.title_en = 'Scherzo-vals for guitar',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 23700 AND piece.composer_id = 449
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- Op. 15 Variaciones sobre un tema de Fernando Sor

UPDATE pieces piece
SET piece.title = 'Variaciones sobre un tema de Fernando Sor', piece.title_en = 'Variaciones sobre un tema de Fernando Sor, op. 15',
    piece.type = 'song', piece.opus_number = 'Op. 15',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 23420 AND piece.composer_id = 449
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Clavelitos

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, 'Clavelitos', 'Clavelitos', 'song', NULL, NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 449
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = 'Clavelitos'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '2ca11c9f-fc3c-4a8e-aaa9-3c9d3584a605'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '2ca11c9f-fc3c-4a8e-aaa9-3c9d3584a605'
FROM pieces p
WHERE p.composer_id = 449 AND p.title = 'Clavelitos' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '2ca11c9f-fc3c-4a8e-aaa9-3c9d3584a605'
);

-- 숨길 seed 작품 없음

-- ===== David del Puerto (composer_id 454) =====
-- 작품을 MusicBrainz 작품 구조로 다시 짠다(6차 자동). 작품 2개(묶음 0, 다악장 2, 낱곡 0),
-- 새 작품 0개, part 5개, 그 아래 0개.
-- seed 2개 중 2개를 작품·part 에 잇고, 0개를 숨기고, 0개는 그대로 둔다.

-- None Fantasía y rondó

UPDATE pieces piece
SET piece.title = 'Fantasía y rondó', piece.title_en = 'Fantasía y rondó',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 24466 AND piece.composer_id = 454
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'Fantasía', part.name_en = 'Fantasía y rondó: I. Fantasía',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 24466 AND p.composer_id = 454 AND part.part_key = 'musicbrainz:aa33286b-3c10-4e81-af43-12cecda7628e' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:aa33286b-3c10-4e81-af43-12cecda7628e', 1, 'I', 'Fantasía', 'Fantasía y rondó: I. Fantasía', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 24466 AND p.composer_id = 454
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:aa33286b-3c10-4e81-af43-12cecda7628e'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'Rondó', part.name_en = 'Fantasía y rondó: II. Rondó',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 24466 AND p.composer_id = 454 AND part.part_key = 'musicbrainz:31a1e950-083a-423c-895c-916d9a5c030b' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:31a1e950-083a-423c-895c-916d9a5c030b', 2, 'II', 'Rondó', 'Fantasía y rondó: II. Rondó', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 24466 AND p.composer_id = 454
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:31a1e950-083a-423c-895c-916d9a5c030b'
);


-- None Viento de primavera

UPDATE pieces piece
SET piece.title = 'Viento de primavera', piece.title_en = 'Viento de primavera',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 24359 AND piece.composer_id = 454
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'Entre la brisa', part.name_en = 'Viento de primavera: I. Entre la brisa',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 24359 AND p.composer_id = 454 AND part.part_key = 'musicbrainz:b489ec08-c1e7-42db-a1fc-26143a840fe7' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:b489ec08-c1e7-42db-a1fc-26143a840fe7', 1, 'I', 'Entre la brisa', 'Viento de primavera: I. Entre la brisa', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 24359 AND p.composer_id = 454
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:b489ec08-c1e7-42db-a1fc-26143a840fe7'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'Luz de tarde', part.name_en = 'Viento de primavera: II. Luz de tarde',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 24359 AND p.composer_id = 454 AND part.part_key = 'musicbrainz:c195d7c8-9e6b-4b29-96c4-c004ff0dece8' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:c195d7c8-9e6b-4b29-96c4-c004ff0dece8', 2, 'II', 'Luz de tarde', 'Viento de primavera: II. Luz de tarde', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 24359 AND p.composer_id = 454
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:c195d7c8-9e6b-4b29-96c4-c004ff0dece8'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = 'Danza', part.name_en = 'Viento de primavera: III. Danza',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 24359 AND p.composer_id = 454 AND part.part_key = 'musicbrainz:c2088189-6d1c-4c9d-b499-fe880bff413f' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:c2088189-6d1c-4c9d-b499-fe880bff413f', 3, 'III', 'Danza', 'Viento de primavera: III. Danza', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 24359 AND p.composer_id = 454
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:c2088189-6d1c-4c9d-b499-fe880bff413f'
);

-- 숨길 seed 작품 없음

-- ===== 필리파 스카일러 (composer_id 456) =====
-- 작품을 MusicBrainz 작품 구조로 다시 짠다(6차 자동). 작품 13개(묶음 0, 다악장 2, 낱곡 11),
-- 새 작품 0개, part 7개, 그 아래 0개.
-- seed 13개 중 13개를 작품·part 에 잇고, 0개를 숨기고, 0개는 그대로 둔다.

-- None African Rhapsody

UPDATE pieces piece
SET piece.title = 'African Rhapsody', piece.title_en = 'African Rhapsody',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 23351 AND piece.composer_id = 456
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None African Suite

UPDATE pieces piece
SET piece.title = 'African Suite', piece.title_en = 'African Suite',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 24870 AND piece.composer_id = 456
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'Sanga', part.name_en = 'African Suite: I. Sanga',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 24870 AND p.composer_id = 456 AND part.part_key = 'musicbrainz:e23035a6-cbc4-4d7f-a95b-31cdbe24fbf8' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:e23035a6-cbc4-4d7f-a95b-31cdbe24fbf8', 1, 'I', 'Sanga', 'African Suite: I. Sanga', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 24870 AND p.composer_id = 456
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:e23035a6-cbc4-4d7f-a95b-31cdbe24fbf8'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'Tweyanze', part.name_en = 'African Suite: II. Tweyanze',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 24870 AND p.composer_id = 456 AND part.part_key = 'musicbrainz:0f817aa8-adf3-4edc-ac7b-d84e15766cbb' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:0f817aa8-adf3-4edc-ac7b-d84e15766cbb', 2, 'II', 'Tweyanze', 'African Suite: II. Tweyanze', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 24870 AND p.composer_id = 456
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:0f817aa8-adf3-4edc-ac7b-d84e15766cbb'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = 'Fumitta embogo', part.name_en = 'African Suite: III. Fumitta embogo',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 24870 AND p.composer_id = 456 AND part.part_key = 'musicbrainz:e3e89773-85a8-49b5-8ffb-ece6dd3de3a6' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:e3e89773-85a8-49b5-8ffb-ece6dd3de3a6', 3, 'III', 'Fumitta embogo', 'African Suite: III. Fumitta embogo', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 24870 AND p.composer_id = 456
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:e3e89773-85a8-49b5-8ffb-ece6dd3de3a6'
);


-- None Carnival in Languedoc

UPDATE pieces piece
SET piece.title = 'Carnival in Languedoc', piece.title_en = 'Carnival in Languedoc',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 23809 AND piece.composer_id = 456
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Damballa

UPDATE pieces piece
SET piece.title = 'Damballa', piece.title_en = 'Damballa',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 24921 AND piece.composer_id = 456
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Khanghai

UPDATE pieces piece
SET piece.title = 'Khanghai', piece.title_en = 'Khanghai',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 24451 AND piece.composer_id = 456
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Patagonian Triste

UPDATE pieces piece
SET piece.title = 'Patagonian Triste', piece.title_en = 'Patagonian Triste',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 23990 AND piece.composer_id = 456
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None The King of France

UPDATE pieces piece
SET piece.title = 'The King of France', piece.title_en = 'The King of France',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 25311 AND piece.composer_id = 456
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None The Poet’s Love

UPDATE pieces piece
SET piece.title = 'The Poet’s Love', piece.title_en = 'The Poet’s Love',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 25624 AND piece.composer_id = 456
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Uganda Martyrs

UPDATE pieces piece
SET piece.title = 'Uganda Martyrs', piece.title_en = 'Uganda Martyrs',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 24443 AND piece.composer_id = 456
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Untitled

UPDATE pieces piece
SET piece.title = 'Untitled', piece.title_en = 'Untitled',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 25034 AND piece.composer_id = 456
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Voodoo Festival

UPDATE pieces piece
SET piece.title = 'Voodoo Festival', piece.title_en = 'Voodoo Festival',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 25649 AND piece.composer_id = 456
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Wanchai Road

UPDATE pieces piece
SET piece.title = 'Wanchai Road', piece.title_en = 'Wanchai Road',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 24160 AND piece.composer_id = 456
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None White Nile Suite

UPDATE pieces piece
SET piece.title = 'White Nile Suite', piece.title_en = 'White Nile Suite',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 23765 AND piece.composer_id = 456
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'Legend of the Mahdi', part.name_en = 'White Nile Suite: I. Legend of the Mahdi',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 23765 AND p.composer_id = 456 AND part.part_key = 'musicbrainz:6fc2d667-a391-43a8-8891-afa20e6224ea' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:6fc2d667-a391-43a8-8891-afa20e6224ea', 1, 'I', 'Legend of the Mahdi', 'White Nile Suite: I. Legend of the Mahdi', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 23765 AND p.composer_id = 456
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:6fc2d667-a391-43a8-8891-afa20e6224ea'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'Alexandria', part.name_en = 'White Nile Suite: II. Alexandria',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 23765 AND p.composer_id = 456 AND part.part_key = 'musicbrainz:6271d722-3ad4-4c7a-9d60-0b4e557c5a81' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:6271d722-3ad4-4c7a-9d60-0b4e557c5a81', 2, 'II', 'Alexandria', 'White Nile Suite: II. Alexandria', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 23765 AND p.composer_id = 456
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:6271d722-3ad4-4c7a-9d60-0b4e557c5a81'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = 'Port Said', part.name_en = 'White Nile Suite: III. Port Said',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 23765 AND p.composer_id = 456 AND part.part_key = 'musicbrainz:064bb5ca-17ff-4b21-a7dd-994b1fcf8b00' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:064bb5ca-17ff-4b21-a7dd-994b1fcf8b00', 3, 'III', 'Port Said', 'White Nile Suite: III. Port Said', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 23765 AND p.composer_id = 456
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:064bb5ca-17ff-4b21-a7dd-994b1fcf8b00'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = 'IV',
    part.name_ko = 'Fall of Babylon', part.name_en = 'White Nile Suite: IV. Fall of Babylon',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 23765 AND p.composer_id = 456 AND part.part_key = 'musicbrainz:06b8e53a-ace0-4b47-8428-b7d82c4525af' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:06b8e53a-ace0-4b47-8428-b7d82c4525af', 4, 'IV', 'Fall of Babylon', 'White Nile Suite: IV. Fall of Babylon', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 23765 AND p.composer_id = 456
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:06b8e53a-ace0-4b47-8428-b7d82c4525af'
);

-- 숨길 seed 작품 없음

-- ===== Jaume Pahissa (composer_id 459) =====
-- 작품을 MusicBrainz 작품 구조로 다시 짠다(6차 자동). 작품 1개(묶음 0, 다악장 1, 낱곡 0),
-- 새 작품 0개, part 3개, 그 아래 0개.
-- seed 1개 중 1개를 작품·part 에 잇고, 0개를 숨기고, 0개는 그대로 둔다.

-- None Tres temas de recuerdos

UPDATE pieces piece
SET piece.title = 'Tres temas de recuerdos', piece.title_en = 'Tres temas de recuerdos',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 24627 AND piece.composer_id = 459
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'Preludio (Por el viejo camino). Moderato', part.name_en = 'Tres temas de recuerdos: I. Preludio (Por el viejo camino). Moderato',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 24627 AND p.composer_id = 459 AND part.part_key = 'musicbrainz:225cea92-6165-4bb8-abc9-c79f490642c1' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:225cea92-6165-4bb8-abc9-c79f490642c1', 1, 'I', 'Preludio (Por el viejo camino). Moderato', 'Tres temas de recuerdos: I. Preludio (Por el viejo camino). Moderato', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 24627 AND p.composer_id = 459
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:225cea92-6165-4bb8-abc9-c79f490642c1'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'Diálogo. Andante mosso', part.name_en = 'Tres temas de recuerdos: II. Diálogo. Andante mosso',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 24627 AND p.composer_id = 459 AND part.part_key = 'musicbrainz:6ac0ebed-eee8-4bb4-920e-e88127f94dde' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:6ac0ebed-eee8-4bb4-920e-e88127f94dde', 2, 'II', 'Diálogo. Andante mosso', 'Tres temas de recuerdos: II. Diálogo. Andante mosso', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 24627 AND p.composer_id = 459
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:6ac0ebed-eee8-4bb4-920e-e88127f94dde'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = 'Danza lejana. Allegro', part.name_en = 'Tres temas de recuerdos: III. Danza lejana. Allegro',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 24627 AND p.composer_id = 459 AND part.part_key = 'musicbrainz:6b8171db-589b-4b5f-a030-1e5234bbb25a' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:6b8171db-589b-4b5f-a030-1e5234bbb25a', 3, 'III', 'Danza lejana. Allegro', 'Tres temas de recuerdos: III. Danza lejana. Allegro', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 24627 AND p.composer_id = 459
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:6b8171db-589b-4b5f-a030-1e5234bbb25a'
);

-- 숨길 seed 작품 없음

-- ===== Erwin Dressel (composer_id 461) =====
-- 작품을 MusicBrainz 작품 구조로 다시 짠다(6차 자동). 작품 1개(묶음 0, 다악장 0, 낱곡 1),
-- 새 작품 0개, part 0개, 그 아래 0개.
-- seed 1개 중 1개를 작품·part 에 잇고, 0개를 숨기고, 0개는 그대로 둔다.

-- None 오페라 <Armer Columbus>

UPDATE pieces piece
SET piece.title = '오페라 <Armer Columbus>', piece.title_en = 'Armer Columbus',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 23098 AND piece.composer_id = 461
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

-- 숨길 seed 작품 없음

-- ===== Kirke Mechem (composer_id 463) =====
-- 작품을 MusicBrainz 작품 구조로 다시 짠다(6차 자동). 작품 3개(묶음 0, 다악장 1, 낱곡 2),
-- 새 작품 0개, part 3개, 그 아래 0개.
-- seed 3개 중 3개를 작품·part 에 잇고, 0개를 숨기고, 0개는 그대로 둔다.

-- None Island in Space

UPDATE pieces piece
SET piece.title = 'Island in Space', piece.title_en = 'Island in Space',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 25326 AND piece.composer_id = 463
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None The Jayhawk

UPDATE pieces piece
SET piece.title = 'The Jayhawk', piece.title_en = 'The Jayhawk',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 24360 AND piece.composer_id = 463
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Winging Wildly

UPDATE pieces piece
SET piece.title = 'Winging Wildly', piece.title_en = 'Winging Wildly',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 23291 AND piece.composer_id = 463
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'Birds at Dusk', part.name_en = 'Winging Wildly: I. Birds at Dusk',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 23291 AND p.composer_id = 463 AND part.part_key = 'musicbrainz:3d5a44f6-30e3-49e8-8988-84e35b7a01f5' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:3d5a44f6-30e3-49e8-8988-84e35b7a01f5', 1, 'I', 'Birds at Dusk', 'Winging Wildly: I. Birds at Dusk', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 23291 AND p.composer_id = 463
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:3d5a44f6-30e3-49e8-8988-84e35b7a01f5'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'The Caged Bird', part.name_en = 'Winging Wildly: II. The Caged Bird',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 23291 AND p.composer_id = 463 AND part.part_key = 'musicbrainz:915ee2dc-fd83-4d28-9ff0-2769c00b023d' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:915ee2dc-fd83-4d28-9ff0-2769c00b023d', 2, 'II', 'The Caged Bird', 'Winging Wildly: II. The Caged Bird', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 23291 AND p.composer_id = 463
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:915ee2dc-fd83-4d28-9ff0-2769c00b023d'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = 'Everyone Sang', part.name_en = 'Winging Wildly: III. Everyone Sang',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 23291 AND p.composer_id = 463 AND part.part_key = 'musicbrainz:aecb5f1b-7bc7-4d11-81ea-7d1f66421e6d' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:aecb5f1b-7bc7-4d11-81ea-7d1f66421e6d', 3, 'III', 'Everyone Sang', 'Winging Wildly: III. Everyone Sang', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 23291 AND p.composer_id = 463
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:aecb5f1b-7bc7-4d11-81ea-7d1f66421e6d'
);

-- 숨길 seed 작품 없음

-- ===== Heinz Tiessen (composer_id 464) =====
-- 작품을 MusicBrainz 작품 구조로 다시 짠다(6차 자동). 작품 5개(묶음 1, 다악장 2, 낱곡 2),
-- 새 작품 0개, part 8개, 그 아래 0개.
-- seed 5개 중 5개를 작품·part 에 잇고, 0개를 숨기고, 0개는 그대로 둔다.

-- Op. 31 3개의 피아노 소품 Op. 31

UPDATE pieces piece
SET piece.title = '3개의 피아노 소품 Op. 31', piece.title_en = '3 Pieces for Piano, op. 31',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = 'Op.', piece.catalogue_number = '31',
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 24340 AND piece.composer_id = 464
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'Blackbird, op. 31 no. 2', part.name_en = 'Blackbird, op. 31 no. 2',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 24340 AND p.composer_id = 464 AND part.part_key = 'musicbrainz:19a66bf7-55cf-4dda-bbac-53bb4b5acb07' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:19a66bf7-55cf-4dda-bbac-53bb4b5acb07', 1, NULL, 'Blackbird, op. 31 no. 2', 'Blackbird, op. 31 no. 2', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 24340 AND p.composer_id = 464
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:19a66bf7-55cf-4dda-bbac-53bb4b5acb07'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'A Sparrow in Eduard Erdmann''s Hand, op. 31 no. 3', part.name_en = 'A Sparrow in Eduard Erdmann''s Hand, op. 31 no. 3',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 24340 AND p.composer_id = 464 AND part.part_key = 'musicbrainz:26aa8411-230b-4d5a-b54c-56163ba8bf92' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:26aa8411-230b-4d5a-b54c-56163ba8bf92', 2, NULL, 'A Sparrow in Eduard Erdmann''s Hand, op. 31 no. 3', 'A Sparrow in Eduard Erdmann''s Hand, op. 31 no. 3', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 24340 AND p.composer_id = 464
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:26aa8411-230b-4d5a-b54c-56163ba8bf92'
);


-- Op. 35 Duo-Sonata

UPDATE pieces piece
SET piece.title = 'Duo-Sonata', piece.title_en = 'Duo-Sonata, op. 35',
    piece.type = 'album', piece.opus_number = 'Op. 35',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 25857 AND piece.composer_id = 464
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'Präludium. Allegro ma non troppo', part.name_en = 'Duo-Sonata, op. 35: I. Präludium. Allegro ma non troppo',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 25857 AND p.composer_id = 464 AND part.part_key = 'musicbrainz:ba4621d8-3379-4fda-a66e-8e2c662a14b3' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:ba4621d8-3379-4fda-a66e-8e2c662a14b3', 1, 'I', 'Präludium. Allegro ma non troppo', 'Duo-Sonata, op. 35: I. Präludium. Allegro ma non troppo', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 25857 AND p.composer_id = 464
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:ba4621d8-3379-4fda-a66e-8e2c662a14b3'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'Andante quasi adagio', part.name_en = 'Duo-Sonata, op. 35: II. Andante quasi adagio',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 25857 AND p.composer_id = 464 AND part.part_key = 'musicbrainz:a72dd96d-28dc-409a-8da2-3ae5c91a0bf3' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:a72dd96d-28dc-409a-8da2-3ae5c91a0bf3', 2, 'II', 'Andante quasi adagio', 'Duo-Sonata, op. 35: II. Andante quasi adagio', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 25857 AND p.composer_id = 464
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:a72dd96d-28dc-409a-8da2-3ae5c91a0bf3'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = 'Finale. Allegro molto vivace', part.name_en = 'Duo-Sonata, op. 35: III. Finale. Allegro molto vivace',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 25857 AND p.composer_id = 464 AND part.part_key = 'musicbrainz:b850e700-513b-4c1d-933a-724b784fffaa' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:b850e700-513b-4c1d-933a-724b784fffaa', 3, 'III', 'Finale. Allegro molto vivace', 'Duo-Sonata, op. 35: III. Finale. Allegro molto vivace', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 25857 AND p.composer_id = 464
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:b850e700-513b-4c1d-933a-724b784fffaa'
);


-- Op. 30 Hamlet-Suite

UPDATE pieces piece
SET piece.title = 'Hamlet-Suite', piece.title_en = 'Hamlet-Suite, op. 30',
    piece.type = 'album', piece.opus_number = 'Op. 30',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 24561 AND piece.composer_id = 464
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'Vorspiel', part.name_en = 'Hamlet-Suite, op. 30: I. Vorspiel',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 24561 AND p.composer_id = 464 AND part.part_key = 'musicbrainz:d9337a95-590c-4839-8c57-e1a6e9e531fe' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:d9337a95-590c-4839-8c57-e1a6e9e531fe', 1, 'I', 'Vorspiel', 'Hamlet-Suite, op. 30: I. Vorspiel', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 24561 AND p.composer_id = 464
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:d9337a95-590c-4839-8c57-e1a6e9e531fe'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'Ophelias Tod', part.name_en = 'Hamlet-Suite, op. 30: II. Ophelias Tod',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 24561 AND p.composer_id = 464 AND part.part_key = 'musicbrainz:411b1616-07db-4b84-be7c-f4b4a967fe18' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:411b1616-07db-4b84-be7c-f4b4a967fe18', 2, 'II', 'Ophelias Tod', 'Hamlet-Suite, op. 30: II. Ophelias Tod', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 24561 AND p.composer_id = 464
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:411b1616-07db-4b84-be7c-f4b4a967fe18'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = 'Totenmarsch', part.name_en = 'Hamlet-Suite, op. 30: III. Totenmarsch',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 24561 AND p.composer_id = 464 AND part.part_key = 'musicbrainz:99120a3e-becd-4d97-90f1-a141554400d6' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:99120a3e-becd-4d97-90f1-a141554400d6', 3, 'III', 'Totenmarsch', 'Hamlet-Suite, op. 30: III. Totenmarsch', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 24561 AND p.composer_id = 464
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:99120a3e-becd-4d97-90f1-a141554400d6'
);


-- None 교향곡 2번 "Stirb und Werde"

UPDATE pieces piece
SET piece.title = '교향곡 2번 "Stirb und Werde"', piece.title_en = 'Symphony no. 2, op. 17 "Stirb und Werde"',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 25578 AND piece.composer_id = 464
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- Op. 33 Vorspiel zu einem Revolutionsdrama

UPDATE pieces piece
SET piece.title = 'Vorspiel zu einem Revolutionsdrama', piece.title_en = 'Vorspiel zu einem Revolutionsdrama, op. 33',
    piece.type = 'song', piece.opus_number = 'Op. 33',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 25201 AND piece.composer_id = 464
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

-- 숨길 seed 작품 없음

-- ===== Philipp Maintz (composer_id 465) =====
-- 작품을 MusicBrainz 작품 구조로 다시 짠다(6차 자동). 작품 1개(묶음 0, 다악장 0, 낱곡 1),
-- 새 작품 0개, part 0개, 그 아래 0개.
-- seed 1개 중 1개를 작품·part 에 잇고, 0개를 숨기고, 0개는 그대로 둔다.

-- None Choralvorspiel LI

UPDATE pieces piece
SET piece.title = 'Choralvorspiel LI', piece.title_en = 'Choralvorspiel LI',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 23339 AND piece.composer_id = 465
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

-- 숨길 seed 작품 없음

-- ===== Georg Schumann (composer_id 469) =====
-- 작품을 MusicBrainz 작품 구조로 다시 짠다(6차 자동). 작품 5개(묶음 0, 다악장 0, 낱곡 5),
-- 새 작품 0개, part 0개, 그 아래 0개.
-- seed 6개 중 5개를 작품·part 에 잇고, 1개를 숨기고, 0개는 그대로 둔다.

-- Op. 3 오라토리오 <Amor und Psyche>

UPDATE pieces piece
SET piece.title = '오라토리오 <Amor und Psyche>', piece.title_en = 'Amor und Psyche, op. 3',
    piece.type = 'song', piece.opus_number = 'Op. 3',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 23387 AND piece.composer_id = 469
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None How Great Are Thy Wonders

UPDATE pieces piece
SET piece.title = 'How Great Are Thy Wonders', piece.title_en = 'How Great Are Thy Wonders',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 25440 AND piece.composer_id = 469
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- Op. 28 Liebesfrühling

UPDATE pieces piece
SET piece.title = 'Liebesfrühling', piece.title_en = 'Liebesfrühling, op. 28',
    piece.type = 'song', piece.opus_number = 'Op. 28',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 25494 AND piece.composer_id = 469
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- Op. 24 Symphonische Variationen über den Choral „Wer nur den lieben Gott läßt walten“

UPDATE pieces piece
SET piece.title = 'Symphonische Variationen über den Choral „Wer nur den lieben Gott läßt walten“', piece.title_en = 'Symphonische Variationen über den Choral „Wer nur den lieben Gott läßt walten“, op. 24',
    piece.type = 'song', piece.opus_number = 'Op. 24',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 25698 AND piece.composer_id = 469
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- Op. 31 No. 1 Und ob ich schon wanderte im finstren Tal

UPDATE pieces piece
SET piece.title = 'Und ob ich schon wanderte im finstren Tal', piece.title_en = 'Und ob ich schon wanderte im finstren Tal, op. 31 no. 1',
    piece.type = 'song', piece.opus_number = 'Op. 31 No. 1',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 24758 AND piece.composer_id = 469
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

-- 카탈로그에 대응이 없는 seed 작품 1개를 목록에서 숨긴다(지우지 않음).
UPDATE pieces piece
SET piece.hidden_reason = 'catalog_unmatched'
WHERE piece.composer_id = 469 AND piece.origin = 'seed' AND piece.hidden_reason IS NULL
  AND piece.id IN (
    25689
  )
  AND NOT EXISTS (SELECT 1 FROM performance_sectors sector WHERE sector.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM piece_parts linking WHERE linking.linked_piece_id = piece.id);
