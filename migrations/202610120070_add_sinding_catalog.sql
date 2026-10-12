-- 크리스티안 신딩 작품을 MusicBrainz 작품 구조로 다시 짠다(4차 자동). 작품 132개(묶음 4, 다악장 12, 낱곡 116),
-- 새 작품 5개, part 61개, 그 아래 0개.
-- seed 141개 중 127개를 작품·part 에 잇고, 7개를 숨기고, 7개는 그대로 둔다.
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

-- Op. 89 3 Stücke Op. 89

UPDATE pieces piece
SET piece.title = '3 Stücke Op. 89', piece.title_en = '3 Stücke, op. 89',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = 'Op.', piece.catalogue_number = '89',
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 16516 AND piece.composer_id = 283
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'Ständchen, op. 89 no. 1', part.name_en = 'Ständchen, op. 89 no. 1',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 16516 AND p.composer_id = 283 AND part.part_key = 'musicbrainz:ca3eabb9-2e7b-4d4b-a464-f4ae1ce7b45c' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:ca3eabb9-2e7b-4d4b-a464-f4ae1ce7b45c', 1, NULL, 'Ständchen, op. 89 no. 1', 'Ständchen, op. 89 no. 1', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 16516 AND p.composer_id = 283
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:ca3eabb9-2e7b-4d4b-a464-f4ae1ce7b45c'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'Alte Weise, op. 89 no. 2', part.name_en = 'Alte Weise, op. 89 no. 2',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 16516 AND p.composer_id = 283 AND part.part_key = 'musicbrainz:1b70a635-6245-4096-ab60-a82694334835' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:1b70a635-6245-4096-ab60-a82694334835', 2, NULL, 'Alte Weise, op. 89 no. 2', 'Alte Weise, op. 89 no. 2', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 16516 AND p.composer_id = 283
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:1b70a635-6245-4096-ab60-a82694334835'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = NULL,
    part.name_ko = 'Abendlied, op. 89 no. 3', part.name_en = 'Abendlied, op. 89 no. 3',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 16516 AND p.composer_id = 283 AND part.part_key = 'musicbrainz:6668b111-7d6b-459a-910e-fca35756cf7b' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:6668b111-7d6b-459a-910e-fca35756cf7b', 3, NULL, 'Abendlied, op. 89 no. 3', 'Abendlied, op. 89 no. 3', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 16516 AND p.composer_id = 283
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:6668b111-7d6b-459a-910e-fca35756cf7b'
);


-- Op. 33 6 Characterstucke Op. 33

UPDATE pieces piece
SET piece.title = '6 Characterstucke Op. 33', piece.title_en = '6 Characterstucke, op. 33',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = 'Op.', piece.catalogue_number = '33',
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 18477 AND piece.composer_id = 283
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'Serenade', part.name_en = '6 Characterstucke, op. 33: No. 4. Serenade',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 18477 AND p.composer_id = 283 AND part.part_key = 'musicbrainz:c9820012-4784-478c-8d21-f6f9cdabbb12' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:c9820012-4784-478c-8d21-f6f9cdabbb12', 1, NULL, 'Serenade', '6 Characterstucke, op. 33: No. 4. Serenade', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 18477 AND p.composer_id = 283
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:c9820012-4784-478c-8d21-f6f9cdabbb12'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'Danse orientale', part.name_en = '6 Charakterstücke, Op. 33: No. 5. Danse orientale',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 18477 AND p.composer_id = 283 AND part.part_key = 'musicbrainz:d7744cc2-7e0b-4165-97dc-5630a7d96557' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:d7744cc2-7e0b-4165-97dc-5630a7d96557', 2, NULL, 'Danse orientale', '6 Charakterstücke, Op. 33: No. 5. Danse orientale', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 18477 AND p.composer_id = 283
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:d7744cc2-7e0b-4165-97dc-5630a7d96557'
);


-- Op. 32 6 Stücke Op. 32

UPDATE pieces piece
SET piece.title = '6 Stücke Op. 32', piece.title_en = '6 Stücke, op. 32',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = 'Op.', piece.catalogue_number = '32',
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 17393 AND piece.composer_id = 283
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'Marche grotesque', part.name_en = '6 Stücke, op. 32: Nr. 1. Marche grotesque',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 17393 AND p.composer_id = 283 AND part.part_key = 'musicbrainz:e15d5a31-adcc-4cb6-a6ee-89ac6d27ea1a' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:e15d5a31-adcc-4cb6-a6ee-89ac6d27ea1a', 1, NULL, 'Marche grotesque', '6 Stücke, op. 32: Nr. 1. Marche grotesque', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 17393 AND p.composer_id = 283
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:e15d5a31-adcc-4cb6-a6ee-89ac6d27ea1a'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'Melodie', part.name_en = '6 Stücke, op. 32: Nr. 2. Melodie',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 17393 AND p.composer_id = 283 AND part.part_key = 'musicbrainz:0cf32c53-783f-4e48-a7ad-12fbc060a9b2' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:0cf32c53-783f-4e48-a7ad-12fbc060a9b2', 2, NULL, 'Melodie', '6 Stücke, op. 32: Nr. 2. Melodie', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 17393 AND p.composer_id = 283
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:0cf32c53-783f-4e48-a7ad-12fbc060a9b2'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = NULL,
    part.name_ko = 'Frühlingsrauschen', part.name_en = '6 Stücke, op. 32: Nr. 3. Frühlingsrauschen',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 17393 AND p.composer_id = 283 AND part.part_key = 'musicbrainz:2f8462af-1868-4bf7-9d39-954175627a02' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:2f8462af-1868-4bf7-9d39-954175627a02', 3, NULL, 'Frühlingsrauschen', '6 Stücke, op. 32: Nr. 3. Frühlingsrauschen', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 17393 AND p.composer_id = 283
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:2f8462af-1868-4bf7-9d39-954175627a02'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = NULL,
    part.name_ko = 'Im Volkston', part.name_en = '6 Stücke, op. 32: Nr. 4. Im Volkston',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 17393 AND p.composer_id = 283 AND part.part_key = 'musicbrainz:4756f873-1a3c-48ae-98c3-53f376e604fd' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:4756f873-1a3c-48ae-98c3-53f376e604fd', 4, NULL, 'Im Volkston', '6 Stücke, op. 32: Nr. 4. Im Volkston', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 17393 AND p.composer_id = 283
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:4756f873-1a3c-48ae-98c3-53f376e604fd'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 5, part.movement_number = NULL,
    part.name_ko = 'Rondoletto giocoso', part.name_en = '6 Stücke, op. 32: Nr. 5. Rondoletto giocoso',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 17393 AND p.composer_id = 283 AND part.part_key = 'musicbrainz:f7bea85d-9c9b-4374-b84e-5254d759f55d' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:f7bea85d-9c9b-4374-b84e-5254d759f55d', 5, NULL, 'Rondoletto giocoso', '6 Stücke, op. 32: Nr. 5. Rondoletto giocoso', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 17393 AND p.composer_id = 283
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:f7bea85d-9c9b-4374-b84e-5254d759f55d'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 6, part.movement_number = NULL,
    part.name_ko = 'Gobelin', part.name_en = '6 Stücke, op. 32: Nr. 6. Gobelin',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 17393 AND p.composer_id = 283 AND part.part_key = 'musicbrainz:8f95c04b-a01d-4106-ba7f-164d84ee2f60' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:8f95c04b-a01d-4106-ba7f-164d84ee2f60', 6, NULL, 'Gobelin', '6 Stücke, op. 32: Nr. 6. Gobelin', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 17393 AND p.composer_id = 283
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:8f95c04b-a01d-4106-ba7f-164d84ee2f60'
);


-- None 가곡 <Aa me hev sulla ihop so lengje / How long we've carried on with our song>

UPDATE pieces piece
SET piece.title = '가곡 <Aa me hev sulla ihop so lengje / How long we''ve carried on with our song>', piece.title_en = 'Aa me hev sulla ihop so lengje / How long we''ve carried on with our song',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 16645 AND piece.composer_id = 283
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- Op. 120a Abendstimmung

UPDATE pieces piece
SET piece.title = 'Abendstimmung', piece.title_en = 'Abendstimmung, Op. 120a',
    piece.type = 'song', piece.opus_number = 'Op. 120a',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 16123 AND piece.composer_id = 283
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- Op. 120 Abendstimmung Op. 120

UPDATE pieces piece
SET piece.title = 'Abendstimmung Op. 120', piece.title_en = 'Abendstimmung, op. 120',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = 'Op.', piece.catalogue_number = '120',
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 17238 AND piece.composer_id = 283
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- Op. 4.3 가곡 <Ad kendte Veje / Upon familiar paths>

UPDATE pieces piece
SET piece.title = '가곡 <Ad kendte Veje / Upon familiar paths>', piece.title_en = 'Ad kendte Veje / Upon familiar paths, op. 4.3',
    piece.type = 'song', piece.opus_number = 'Op. 4.3',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 16774 AND piece.composer_id = 283
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- Op. 81 No. 1 Air

UPDATE pieces piece
SET piece.title = 'Air', piece.title_en = 'Air, Op. 81, No. 1',
    piece.type = 'song', piece.opus_number = 'Op. 81 No. 1',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 17566 AND piece.composer_id = 283
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- Op. 81 No. 2 Albumblatt

UPDATE pieces piece
SET piece.title = 'Albumblatt', piece.title_en = 'Albumblatt, Op. 81, No. 2',
    piece.type = 'song', piece.opus_number = 'Op. 81 No. 2',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 17113 AND piece.composer_id = 283
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- Op. 106 No. 3 Andante Religioso

UPDATE pieces piece
SET piece.title = 'Andante Religioso', piece.title_en = 'Andante Religioso, Op. 106, No. 3',
    piece.type = 'song', piece.opus_number = 'Op. 106 No. 3',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 17961 AND piece.composer_id = 283
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- Op. 77.2 가곡 <Aud der Wiese (Sergel)>

UPDATE pieces piece
SET piece.title = '가곡 <Aud der Wiese (Sergel)>', piece.title_en = 'Aud der Wiese (Sergel) Op.77.2',
    piece.type = 'song', piece.opus_number = 'Op. 77.2',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 17809 AND piece.composer_id = 283
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- Op. 57.14 가곡 <Aus der Ferne in der Nacht (Bierbaum)>

UPDATE pieces piece
SET piece.title = '가곡 <Aus der Ferne in der Nacht (Bierbaum)>', piece.title_en = 'Aus der Ferne in der Nacht (Bierbaum) Op.57.14',
    piece.type = 'song', piece.opus_number = 'Op. 57.14',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 16574 AND piece.composer_id = 283
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- Op. 61 No. 3 발라드

UPDATE pieces piece
SET piece.title = '발라드', piece.title_en = 'Ballade, Op. 61, No. 3',
    piece.type = 'song', piece.opus_number = 'Op. 61 No. 3',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 16310 AND piece.composer_id = 283
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- Op. 128.4 가곡 <Barcarole (Øverland)>

UPDATE pieces piece
SET piece.title = '가곡 <Barcarole (Øverland)>', piece.title_en = 'Barcarole (Øverland) Op.128.4',
    piece.type = 'song', piece.opus_number = 'Op. 128.4',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 17343 AND piece.composer_id = 283
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- Op. 106 No. 2 자장가

UPDATE pieces piece
SET piece.title = '자장가', piece.title_en = 'Berceuse, Op. 106, No. 2',
    piece.type = 'song', piece.opus_number = 'Op. 106 No. 2',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 15996 AND piece.composer_id = 283
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- Op. 78 Cantus Doloris

UPDATE pieces piece
SET piece.title = 'Cantus Doloris', piece.title_en = 'Cantus Doloris, Op. 78',
    piece.type = 'song', piece.opus_number = 'Op. 78',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 18249 AND piece.composer_id = 283
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None 가곡 <D'er 'kje Draumar som leikar / Dreams don't revel>

UPDATE pieces piece
SET piece.title = '가곡 <D''er ''kje Draumar som leikar / Dreams don''t revel>', piece.title_en = 'D''er ''kje Draumar som leikar / Dreams don''t revel',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 17164 AND piece.composer_id = 283
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- Op. 37.5 가곡 <D'er vondt aa vera hugen sjuk (Mortensson)>

UPDATE pieces piece
SET piece.title = '가곡 <D''er vondt aa vera hugen sjuk (Mortensson)>', piece.title_en = 'D''er vondt aa vera hugen sjuk (Mortensson) Op.37.5',
    piece.type = 'song', piece.opus_number = 'Op. 37.5',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 17504 AND piece.composer_id = 283
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- Op. 55.6 가곡 <De gjeng tebakar (Telnes)>

UPDATE pieces piece
SET piece.title = '가곡 <De gjeng tebakar (Telnes)>', piece.title_en = 'De gjeng tebakar (Telnes) Op.55.6',
    piece.type = 'song', piece.opus_number = 'Op. 55.6',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 18533 AND piece.composer_id = 283
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None 가곡 <De hellige tre Kongsers Reise (Heine, Wergeland)>

UPDATE pieces piece
SET piece.title = '가곡 <De hellige tre Kongsers Reise (Heine, Wergeland)>', piece.title_en = 'De hellige tre Kongsers Reise (Heine, Wergeland)',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 18629 AND piece.composer_id = 283
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None 가곡 <Dei seier, naar Tia skrie / 'Tis said that time in passing>

UPDATE pieces piece
SET piece.title = '가곡 <Dei seier, naar Tia skrie / ''Tis said that time in passing>', piece.title_en = 'Dei seier, naar Tia skrie / ''Tis said that time in passing',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 19599 AND piece.composer_id = 283
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- Op. 50 No. 5 가곡 <Den Jomfru gik i Valmu-Vang>

UPDATE pieces piece
SET piece.title = '가곡 <Den Jomfru gik i Valmu-Vang>', piece.title_en = 'Den Jomfru gik i Valmu-Vang, op. 50 no. 5',
    piece.type = 'song', piece.opus_number = 'Op. 50 No. 5',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 17329 AND piece.composer_id = 283
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None 가곡 <Den Jomfru gik i Valmu-vang / A maiden walked in the poppy field, op. 50.5 (Ewald)>

UPDATE pieces piece
SET piece.title = '가곡 <Den Jomfru gik i Valmu-vang / A maiden walked in the poppy field, op. 50.5 (Ewald)>', piece.title_en = 'Den Jomfru gik i Valmu-vang / A maiden walked in the poppy field, op. 50.5 (Ewald)',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 18800 AND piece.composer_id = 283
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None 가곡 <Der skreg en fugl / A bird's cry rang, op. 18.5 (Vilhelm Krag)>

UPDATE pieces piece
SET piece.title = '가곡 <Der skreg en fugl / A bird''s cry rang, op. 18.5 (Vilhelm Krag)>', piece.title_en = 'Der skreg en fugl / A bird''s cry rang, op. 18.5 (Vilhelm Krag)',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 17610 AND piece.composer_id = 283
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- Op. 18 No. 5 가곡 <Der skreg en fugl>

UPDATE pieces piece
SET piece.title = '가곡 <Der skreg en fugl>', piece.title_en = 'Der skreg en fugl, op. 18 no. 5',
    piece.type = 'song', piece.opus_number = 'Op. 18 No. 5',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 18191 AND piece.composer_id = 283
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None 가곡 <Der var Roser i Dale / There were roses in the dales, op. 39.3 (Winther)>

UPDATE pieces piece
SET piece.title = '가곡 <Der var Roser i Dale / There were roses in the dales, op. 39.3 (Winther)>', piece.title_en = 'Der var Roser i Dale / There were roses in the dales, op. 39.3 (Winther)',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 17219 AND piece.composer_id = 283
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- Op. 57.13 가곡 <Des Narren Regenlied (Bierbaum)>

UPDATE pieces piece
SET piece.title = '가곡 <Des Narren Regenlied (Bierbaum)>', piece.title_en = 'Des Narren Regenlied (Bierbaum) Op.57.13',
    piece.type = 'song', piece.opus_number = 'Op. 57.13',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 16346 AND piece.composer_id = 283
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None 가곡 <Det bødes der for / Through long, long years, op. 17.3 (. P. Jacobsen)>

UPDATE pieces piece
SET piece.title = '가곡 <Det bødes der for / Through long, long years, op. 17.3 (. P. Jacobsen)>', piece.title_en = 'Det bødes der for / Through long, long years, op. 17.3 (. P. Jacobsen)',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 18172 AND piece.composer_id = 283
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None 가곡 <Det er Sommerkvæld som da / It is summer evening as before, op. 36.7 (Nils Collett Vogt)>

UPDATE pieces piece
SET piece.title = '가곡 <Det er Sommerkvæld som da / It is summer evening as before, op. 36.7 (Nils Collett Vogt)>', piece.title_en = 'Det er Sommerkvæld som da / It is summer evening as before, op. 36.7 (Nils Collett Vogt)',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 18463 AND piece.composer_id = 283
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None 가곡 <Det gule Haaret / Her golden hair>

UPDATE pieces piece
SET piece.title = '가곡 <Det gule Haaret / Her golden hair>', piece.title_en = 'Det gule Haaret / Her golden hair',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 16175 AND piece.composer_id = 283
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None 가곡 <Du Mor, som einsam heime gjeng / Oh mother, all alone at home r 36. D'er 'kje Draumar som leikar / Dreams don't revel>

UPDATE pieces piece
SET piece.title = '가곡 <Du Mor, som einsam heime gjeng / Oh mother, all alone at home r 36. D''er ''kje Draumar som leikar / Dreams don''t revel>', piece.title_en = 'Du Mor, som einsam heime gjeng / Oh mother, all alone at home r 36. D''er ''kje Draumar som leikar / Dreams don''t revel',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 18423 AND piece.composer_id = 283
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- Op. 55.3 가곡 <Du skog, som bøygjer deg imot (Vinje)>

UPDATE pieces piece
SET piece.title = '가곡 <Du skog, som bøygjer deg imot (Vinje)>', piece.title_en = 'Du skog, som bøygjer deg imot (Vinje) Op.55.3',
    piece.type = 'song', piece.opus_number = 'Op. 55.3',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 16060 AND piece.composer_id = 283
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None 가곡 <Eg tarv ikkje Ljose aa kvejkje / I need not kindle the light>

UPDATE pieces piece
SET piece.title = '가곡 <Eg tarv ikkje Ljose aa kvejkje / I need not kindle the light>', piece.title_en = 'Eg tarv ikkje Ljose aa kvejkje / I need not kindle the light',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 19824 AND piece.composer_id = 283
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None 가곡 <Eg tykkjer det er reint langsamt / So dreary all around me seems>

UPDATE pieces piece
SET piece.title = '가곡 <Eg tykkjer det er reint langsamt / So dreary all around me seems>', piece.title_en = 'Eg tykkjer det er reint langsamt / So dreary all around me seems',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 19941 AND piece.composer_id = 283
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None 가곡 <Eg veit meg aldri / I just do not know>

UPDATE pieces piece
SET piece.title = '가곡 <Eg veit meg aldri / I just do not know>', piece.title_en = 'Eg veit meg aldri / I just do not know',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 19746 AND piece.composer_id = 283
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None 가곡 <Eg vil deg 'kje elske / I don't want to love you>

UPDATE pieces piece
SET piece.title = '가곡 <Eg vil deg ''kje elske / I don''t want to love you>', piece.title_en = 'Eg vil deg ''kje elske / I don''t want to love you',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 18271 AND piece.composer_id = 283
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None 가곡 <Ei Rjupa ifraa Vidda / A grouse from moorlands high>

UPDATE pieces piece
SET piece.title = '가곡 <Ei Rjupa ifraa Vidda / A grouse from moorlands high>', piece.title_en = 'Ei Rjupa ifraa Vidda / A grouse from moorlands high',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 16167 AND piece.composer_id = 283
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- Op. 68.2 가곡 <Ein Vaartanke (Utbø)>

UPDATE pieces piece
SET piece.title = '가곡 <Ein Vaartanke (Utbø)>', piece.title_en = 'Ein Vaartanke (Utbø) Op.68.2',
    piece.type = 'song', piece.opus_number = 'Op. 68.2',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 16037 AND piece.composer_id = 283
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- Op. 106 No. 1 엘레지 B♭장조

UPDATE pieces piece
SET piece.title = '엘레지 B♭장조', piece.title_en = 'Elegy In B Flat Major, Op. 106, No. 1',
    piece.type = 'song', piece.opus_number = 'Op. 106 No. 1',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 18360 AND piece.composer_id = 283
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- Op. 61 No. 2 엘레지 D단조

UPDATE pieces piece
SET piece.title = '엘레지 D단조', piece.title_en = 'Elegy In D Minor, Op. 61, No. 2',
    piece.type = 'song', piece.opus_number = 'Op. 61 No. 2',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 16446 AND piece.composer_id = 283
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None 가곡 <End er jeg stemt / Still I'm inspired, w/o. op. (from Russian, T. Lange)>

UPDATE pieces piece
SET piece.title = '가곡 <End er jeg stemt / Still I''m inspired, w/o. op. (from Russian, T. Lange)>', piece.title_en = 'End er jeg stemt / Still I''m inspired, w/o. op. (from Russian, T. Lange)',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 17220 AND piece.composer_id = 283
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None 가곡 <Es sitzen drei Weiber zu weben / Three women sit and weave, op. 26.8 (Fitger)>

UPDATE pieces piece
SET piece.title = '가곡 <Es sitzen drei Weiber zu weben / Three women sit and weave, op. 26.8 (Fitger)>', piece.title_en = 'Es sitzen drei Weiber zu weben / Three women sit and weave, op. 26.8 (Fitger)',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 16629 AND piece.composer_id = 283
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None 가곡 <Es war im sonnigen Monat März / In the sunny month of March, op. 26.7 (Fitger)>

UPDATE pieces piece
SET piece.title = '가곡 <Es war im sonnigen Monat März / In the sunny month of March, op. 26.7 (Fitger)>', piece.title_en = 'Es war im sonnigen Monat März / In the sunny month of March, op. 26.7 (Fitger)',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 17820 AND piece.composer_id = 283
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- Op. 128.2 가곡 <Et seil glir bort i kveldens blå (Øverland)>

UPDATE pieces piece
SET piece.title = '가곡 <Et seil glir bort i kveldens blå (Øverland)>', piece.title_en = 'Et seil glir bort i kveldens blå (Øverland) Op.128.2',
    piece.type = 'song', piece.opus_number = 'Op. 128.2',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 19540 AND piece.composer_id = 283
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- Op. 90.4 가곡 <Fattigmandstrøst (Wildenvey)>

UPDATE pieces piece
SET piece.title = '가곡 <Fattigmandstrøst (Wildenvey)>', piece.title_en = 'Fattigmandstrøst (Wildenvey) Op.90.4',
    piece.type = 'song', piece.opus_number = 'Op. 90.4',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 19997 AND piece.composer_id = 283
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- Op. 94 Fatum - Piano Variations

UPDATE pieces piece
SET piece.title = 'Fatum - Piano Variations', piece.title_en = 'Fatum - Piano Variations, Op.94',
    piece.type = 'song', piece.opus_number = 'Op. 94',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 19378 AND piece.composer_id = 283
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- Op. 32 No. 3 Frühlingsrauschen for solo piano

UPDATE pieces piece
SET piece.title = 'Frühlingsrauschen for solo piano', piece.title_en = 'Frühlingsrauschen for solo piano, op. 32, nr. 3',
    piece.type = 'song', piece.opus_number = 'Op. 32 No. 3',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 17986 AND piece.composer_id = 283
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- Op. 130.3 가곡 <Graagjæs (Grieg)>

UPDATE pieces piece
SET piece.title = '가곡 <Graagjæs (Grieg)>', piece.title_en = 'Graagjæs (Grieg) Op.130.3',
    piece.type = 'song', piece.opus_number = 'Op. 130.3',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 17946 AND piece.composer_id = 283
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- Op. 38.4 가곡 <Haust (Sivle)>

UPDATE pieces piece
SET piece.title = '가곡 <Haust (Sivle)>', piece.title_en = 'Haust (Sivle) Op.38.4',
    piece.type = 'song', piece.opus_number = 'Op. 38.4',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 18617 AND piece.composer_id = 283
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- Op. 69.3 가곡 <Hugen leikar (Mortensson)>

UPDATE pieces piece
SET piece.title = '가곡 <Hugen leikar (Mortensson)>', piece.title_en = 'Hugen leikar (Mortensson) Op.69.3',
    piece.type = 'song', piece.opus_number = 'Op. 69.3',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 18756 AND piece.composer_id = 283
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None 가곡 <I Seraillets Have / In the Seraglio's garden, op. 17.4 (. P. Jacobsen)>

UPDATE pieces piece
SET piece.title = '가곡 <I Seraillets Have / In the Seraglio''s garden, op. 17.4 (. P. Jacobsen)>', piece.title_en = 'I Seraillets Have / In the Seraglio''s garden, op. 17.4 (. P. Jacobsen)',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 18165 AND piece.composer_id = 283
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None 가곡 <Ich liege dir zu Füssen / I lie at your feet, op. 26.4 (Fitger)>

UPDATE pieces piece
SET piece.title = '가곡 <Ich liege dir zu Füssen / I lie at your feet, op. 26.4 (Fitger)>', piece.title_en = 'Ich liege dir zu Füssen / I lie at your feet, op. 26.4 (Fitger)',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 17370 AND piece.composer_id = 283
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- Op. 77.2 가곡 <Im Walde liegt ein stiller See (Sergel)>

UPDATE pieces piece
SET piece.title = '가곡 <Im Walde liegt ein stiller See (Sergel)>', piece.title_en = 'Im Walde liegt ein stiller See (Sergel) Op.77.2',
    piece.type = 'song', piece.opus_number = 'Op. 77.2',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 16657 AND piece.composer_id = 283
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- Op. 77.2 가곡 <Immer wieder (Sergel)>

UPDATE pieces piece
SET piece.title = '가곡 <Immer wieder (Sergel)>', piece.title_en = 'Immer wieder (Sergel) Op.77.2',
    piece.type = 'song', piece.opus_number = 'Op. 77.2',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 19383 AND piece.composer_id = 283
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- Op. 109.3 가곡 <Jane Grey (Amman)>

UPDATE pieces piece
SET piece.title = '가곡 <Jane Grey (Amman)>', piece.title_en = 'Jane Grey (Amman) Op.109.3',
    piece.type = 'song', piece.opus_number = 'Op. 109.3',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 18328 AND piece.composer_id = 283
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- Op. 4.1 가곡 <Jeg bærer den Hat, som jeg vil / I'll wear any hat that I like>

UPDATE pieces piece
SET piece.title = '가곡 <Jeg bærer den Hat, som jeg vil / I''ll wear any hat that I like>', piece.title_en = 'Jeg bærer den Hat, som jeg vil / I''ll wear any hat that I like, op. 4.1',
    piece.type = 'song', piece.opus_number = 'Op. 4.1',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 19940 AND piece.composer_id = 283
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- Op. 19.4 가곡 <Jeg havde mig en Hjærtenskær / I had in sooth a sweetheart once>

UPDATE pieces piece
SET piece.title = '가곡 <Jeg havde mig en Hjærtenskær / I had in sooth a sweetheart once>', piece.title_en = 'Jeg havde mig en Hjærtenskær / I had in sooth a sweetheart once, op. 19.4',
    piece.type = 'song', piece.opus_number = 'Op. 19.4',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 17357 AND piece.composer_id = 283
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- Op. 109.2 가곡 <Kirschenballade (Weller)>

UPDATE pieces piece
SET piece.title = '가곡 <Kirschenballade (Weller)>', piece.title_en = 'Kirschenballade (Weller) Op.109.2',
    piece.type = 'song', piece.opus_number = 'Op. 109.2',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 19244 AND piece.composer_id = 283
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None 가곡 <Kokain>

UPDATE pieces piece
SET piece.title = '가곡 <Kokain>', piece.title_en = 'Kokain',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 17216 AND piece.composer_id = 283
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- Op. 55 No. 5 가곡 <Leit etter livet og liv det!>

UPDATE pieces piece
SET piece.title = '가곡 <Leit etter livet og liv det!>', piece.title_en = 'Leit etter livet og liv det!, op. 55 no. 5',
    piece.type = 'song', piece.opus_number = 'Op. 55 No. 5',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 18622 AND piece.composer_id = 283
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- Op. 57.10 가곡 <Letzer Wunsch (Bierbaum)>

UPDATE pieces piece
SET piece.title = '가곡 <Letzer Wunsch (Bierbaum)>', piece.title_en = 'Letzer Wunsch (Bierbaum) Op.57.10',
    piece.type = 'song', piece.opus_number = 'Op. 57.10',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 17019 AND piece.composer_id = 283
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- Op. 15 Lieder aus "Des Knaben Wunderhorn" Op. 15

UPDATE pieces piece
SET piece.title = 'Lieder aus "Des Knaben Wunderhorn" Op. 15', piece.title_en = 'Lieder aus "Des Knaben Wunderhorn", op. 15',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = 'Op.', piece.catalogue_number = '15',
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 17359 AND piece.composer_id = 283
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'Fuge, op. 15 no. 6', part.name_en = 'Fuge, op. 15 no. 6',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 17359 AND p.composer_id = 283 AND part.part_key = 'musicbrainz:2fc6c33d-4e07-495a-b407-2bbdce1f7e7a' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:2fc6c33d-4e07-495a-b407-2bbdce1f7e7a', 1, NULL, 'Fuge, op. 15 no. 6', 'Fuge, op. 15 no. 6', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 17359 AND p.composer_id = 283
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:2fc6c33d-4e07-495a-b407-2bbdce1f7e7a'
);


-- None Légende

UPDATE pieces piece
SET piece.title = 'Légende', piece.title_en = 'Légende',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 17805 AND piece.composer_id = 283
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- Op. 38.3 가곡 <Løv (Sivle)>

UPDATE pieces piece
SET piece.title = '가곡 <Løv (Sivle)>', piece.title_en = 'Løv (Sivle) Op.38.3',
    piece.type = 'song', piece.opus_number = 'Op. 38.3',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 17800 AND piece.composer_id = 283
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- Op. 22 No. 3 가곡 <Mainat>

UPDATE pieces piece
SET piece.title = '가곡 <Mainat>', piece.title_en = 'Mainat, op. 22 no. 3',
    piece.type = 'song', piece.opus_number = 'Op. 22 No. 3',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 18708 AND piece.composer_id = 283
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- Op. 64.7 가곡 <Meine Töne , still und heiter (Rückert)>

UPDATE pieces piece
SET piece.title = '가곡 <Meine Töne , still und heiter (Rückert)>', piece.title_en = 'Meine Töne , still und heiter (Rückert) Op.64.7',
    piece.type = 'song', piece.opus_number = 'Op. 64.7',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 18129 AND piece.composer_id = 283
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None 가곡 <Morten han var liten og fæit>

UPDATE pieces piece
SET piece.title = '가곡 <Morten han var liten og fæit>', piece.title_en = 'Morten han var liten og fæit',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 18511 AND piece.composer_id = 283
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None 가곡 <Naar Sola ski'ne / When the sun is ashine>

UPDATE pieces piece
SET piece.title = '가곡 <Naar Sola ski''ne / When the sun is ashine>', piece.title_en = 'Naar Sola ski''ne / When the sun is ashine',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 17332 AND piece.composer_id = 283
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- Op. 57.1 가곡 <Neemt, Frouwe, disen Kranz (Bierbaum)>

UPDATE pieces piece
SET piece.title = '가곡 <Neemt, Frouwe, disen Kranz (Bierbaum)>', piece.title_en = 'Neemt, Frouwe, disen Kranz (Bierbaum) Op.57.1',
    piece.type = 'song', piece.opus_number = 'Op. 57.1',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 19756 AND piece.composer_id = 283
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None 가곡 <No maa eg slutte aa vera gla / All joy I must abandon now>

UPDATE pieces piece
SET piece.title = '가곡 <No maa eg slutte aa vera gla / All joy I must abandon now>', piece.title_en = 'No maa eg slutte aa vera gla / All joy I must abandon now',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 18527 AND piece.composer_id = 283
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- Op. 13.1 가곡 <O Mo'r, vor gamle Mo'r! / O mother, dear old mother!>

UPDATE pieces piece
SET piece.title = '가곡 <O Mo''r, vor gamle Mo''r! / O mother, dear old mother!>', piece.title_en = 'O Mo''r, vor gamle Mo''r! / O mother, dear old mother!, op. 13.1',
    piece.type = 'song', piece.opus_number = 'Op. 13.1',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 16841 AND piece.composer_id = 283
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- Op. 104.4 가곡 <O verzweifle nicht am Glücke (Hamerling)>

UPDATE pieces piece
SET piece.title = '가곡 <O verzweifle nicht am Glücke (Hamerling)>', piece.title_en = 'O verzweifle nicht am Glücke (Hamerling) Op.104.4',
    piece.type = 'song', piece.opus_number = 'Op. 104.4',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 19831 AND piece.composer_id = 283
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- Op. 13.7 가곡 <Ofte Du sang for de Andre / Often you sang for others>

UPDATE pieces piece
SET piece.title = '가곡 <Ofte Du sang for de Andre / Often you sang for others>', piece.title_en = 'Ofte Du sang for de Andre / Often you sang for others, op. 13.7',
    piece.type = 'song', piece.opus_number = 'Op. 13.7',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 19032 AND piece.composer_id = 283
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None 가곡 <Og der gik Dage / And there were days, op. 36.3 (Nils Collett Vogt)>

UPDATE pieces piece
SET piece.title = '가곡 <Og der gik Dage / And there were days, op. 36.3 (Nils Collett Vogt)>', piece.title_en = 'Og der gik Dage / And there were days, op. 36.3 (Nils Collett Vogt)',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 17713 AND piece.composer_id = 283
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- Op. 8.2 가곡 <Paa Stranden skælver ej det mindste Blad / No single leaf's astir on the shore>

UPDATE pieces piece
SET piece.title = '가곡 <Paa Stranden skælver ej det mindste Blad / No single leaf''s astir on the shore>', piece.title_en = 'Paa Stranden skælver ej det mindste Blad / No single leaf''s astir on the shore, op. 8.2',
    piece.type = 'song', piece.opus_number = 'Op. 8.2',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 17563 AND piece.composer_id = 283
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None 가곡 <Paa andre Aare / 'Tis been more than a year>

UPDATE pieces piece
SET piece.title = '가곡 <Paa andre Aare / ''Tis been more than a year>', piece.title_en = 'Paa andre Aare / ''Tis been more than a year',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 19203 AND piece.composer_id = 283
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- Op. 6 피아노 협주곡 D♭장조

UPDATE pieces piece
SET piece.title = '피아노 협주곡 D♭장조', piece.title_en = 'Piano Concerto in D-flat major, op. 6',
    piece.type = 'album', piece.opus_number = 'Op. 6',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 16316 AND piece.composer_id = 283
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'Allegro non troppo', part.name_en = 'Piano Concerto in D-flat major, op. 6: I. Allegro non troppo',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 16316 AND p.composer_id = 283 AND part.part_key = 'musicbrainz:5cc9949e-6414-4533-89d9-6c866eed27e6' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:5cc9949e-6414-4533-89d9-6c866eed27e6', 1, 'I', 'Allegro non troppo', 'Piano Concerto in D-flat major, op. 6: I. Allegro non troppo', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 16316 AND p.composer_id = 283
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:5cc9949e-6414-4533-89d9-6c866eed27e6'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'Andante', part.name_en = 'Piano Concerto in D-flat major, op. 6: II. Andante',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 16316 AND p.composer_id = 283 AND part.part_key = 'musicbrainz:a3b056ea-ef0d-4f60-8dbc-fd3b6302b122' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:a3b056ea-ef0d-4f60-8dbc-fd3b6302b122', 2, 'II', 'Andante', 'Piano Concerto in D-flat major, op. 6: II. Andante', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 16316 AND p.composer_id = 283
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:a3b056ea-ef0d-4f60-8dbc-fd3b6302b122'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = 'Allegro non assai', part.name_en = 'Piano Concerto in D-flat major, op. 6: III. Allegro non assai',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 16316 AND p.composer_id = 283 AND part.part_key = 'musicbrainz:1badeb4b-571d-460f-bed5-fc222930b5a3' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:1badeb4b-571d-460f-bed5-fc222930b5a3', 3, 'III', 'Allegro non assai', 'Piano Concerto in D-flat major, op. 6: III. Allegro non assai', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 16316 AND p.composer_id = 283
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:1badeb4b-571d-460f-bed5-fc222930b5a3'
);


-- Op. 5 피아노 5중주 E단조

UPDATE pieces piece
SET piece.title = '피아노 5중주 E단조', piece.title_en = 'Piano Quintet in E minor, op. 5',
    piece.type = 'album', piece.opus_number = 'Op. 5',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 16380 AND piece.composer_id = 283
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'Allegro ma non troppo', part.name_en = 'Piano Quintet in E minor, op. 5: I. Allegro ma non troppo',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 16380 AND p.composer_id = 283 AND part.part_key = 'musicbrainz:48866a73-b1b0-4583-a405-35406fd05783' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:48866a73-b1b0-4583-a405-35406fd05783', 1, 'I', 'Allegro ma non troppo', 'Piano Quintet in E minor, op. 5: I. Allegro ma non troppo', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 16380 AND p.composer_id = 283
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:48866a73-b1b0-4583-a405-35406fd05783'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'Andante', part.name_en = 'Piano Quintet in E minor, op. 5: II. Andante',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 16380 AND p.composer_id = 283 AND part.part_key = 'musicbrainz:6d3da9f7-c74c-4bee-b6aa-5b8f01f80aa9' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:6d3da9f7-c74c-4bee-b6aa-5b8f01f80aa9', 2, 'II', 'Andante', 'Piano Quintet in E minor, op. 5: II. Andante', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 16380 AND p.composer_id = 283
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:6d3da9f7-c74c-4bee-b6aa-5b8f01f80aa9'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = 'Vivace', part.name_en = 'Piano Quintet in E minor, op. 5: III. Vivace',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 16380 AND p.composer_id = 283 AND part.part_key = 'musicbrainz:a2c6c0c2-08c0-4a17-83f3-bca5006dbe8b' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:a2c6c0c2-08c0-4a17-83f3-bca5006dbe8b', 3, 'III', 'Vivace', 'Piano Quintet in E minor, op. 5: III. Vivace', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 16380 AND p.composer_id = 283
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:a2c6c0c2-08c0-4a17-83f3-bca5006dbe8b'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = 'IV',
    part.name_ko = 'Finale. Allegro vivace', part.name_en = 'Piano Quintet in E minor, op. 5: IV. Finale. Allegro vivace',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 16380 AND p.composer_id = 283 AND part.part_key = 'musicbrainz:a6a59f93-8d20-4813-8f7e-f027f2482846' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:a6a59f93-8d20-4813-8f7e-f027f2482846', 4, 'IV', 'Finale. Allegro vivace', 'Piano Quintet in E minor, op. 5: IV. Finale. Allegro vivace', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 16380 AND p.composer_id = 283
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:a6a59f93-8d20-4813-8f7e-f027f2482846'
);


-- Op. 64a 피아노 3중주 2번

UPDATE pieces piece
SET piece.title = '피아노 3중주 2번', piece.title_en = 'Piano Trio no. 2, op. 64a',
    piece.type = 'album', piece.opus_number = 'Op. 64a',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 17198 AND piece.composer_id = 283
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'Allegro con brio', part.name_en = 'Piano Trio no. 2, op. 64a: I. Allegro con brio',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 17198 AND p.composer_id = 283 AND part.part_key = 'musicbrainz:4a764554-354b-45ba-9450-293011a25312' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:4a764554-354b-45ba-9450-293011a25312', 1, 'I', 'Allegro con brio', 'Piano Trio no. 2, op. 64a: I. Allegro con brio', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 17198 AND p.composer_id = 283
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:4a764554-354b-45ba-9450-293011a25312'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'Andante', part.name_en = 'Piano Trio no. 2, op. 64a: II. Andante',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 17198 AND p.composer_id = 283 AND part.part_key = 'musicbrainz:bc0cfe7b-7a88-4f6b-a0f1-1a1b4c1c0645' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:bc0cfe7b-7a88-4f6b-a0f1-1a1b4c1c0645', 2, 'II', 'Andante', 'Piano Trio no. 2, op. 64a: II. Andante', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 17198 AND p.composer_id = 283
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:bc0cfe7b-7a88-4f6b-a0f1-1a1b4c1c0645'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = 'Non troppo allegro', part.name_en = 'Piano Trio no. 2, op. 64a: III. Non troppo allegro',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 17198 AND p.composer_id = 283 AND part.part_key = 'musicbrainz:7e267142-a728-4f48-9295-771c5f7aa514' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:7e267142-a728-4f48-9295-771c5f7aa514', 3, 'III', 'Non troppo allegro', 'Piano Trio no. 2, op. 64a: III. Non troppo allegro', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 17198 AND p.composer_id = 283
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:7e267142-a728-4f48-9295-771c5f7aa514'
);


-- Op. 90.3 가곡 <Pinselilje (Wildenvey)>

UPDATE pieces piece
SET piece.title = '가곡 <Pinselilje (Wildenvey)>', piece.title_en = 'Pinselilje (Wildenvey) Op.90.3',
    piece.type = 'song', piece.opus_number = 'Op. 90.3',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 16602 AND piece.composer_id = 283
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Presto per violoncello e pianoforte

UPDATE pieces piece
SET piece.title = 'Presto per violoncello e pianoforte', piece.title_en = 'Presto per violoncello e pianoforte',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 17180 AND piece.composer_id = 283
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- Op. 43 No. 3 전주곡

UPDATE pieces piece
SET piece.title = '전주곡', piece.title_en = 'Prélude, Op. 43, No. 3',
    piece.type = 'song', piece.opus_number = 'Op. 43 No. 3',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 19001 AND piece.composer_id = 283
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- Op. 19.2 가곡 <Rav / Amber>

UPDATE pieces piece
SET piece.title = '가곡 <Rav / Amber>', piece.title_en = 'Rav / Amber, op. 19.2',
    piece.type = 'song', piece.opus_number = 'Op. 19.2',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 19626 AND piece.composer_id = 283
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None 가곡 <Ravnen han flyver om Aftnen / The raven flies by night, op. 39.1 (trad.)>

UPDATE pieces piece
SET piece.title = '가곡 <Ravnen han flyver om Aftnen / The raven flies by night, op. 39.1 (trad.)>', piece.title_en = 'Ravnen han flyver om Aftnen / The raven flies by night, op. 39.1 (trad.)',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 17121 AND piece.composer_id = 283
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- Op. 57.2 가곡 <Ritter raet dem Knappen dies (Bierbaum)>

UPDATE pieces piece
SET piece.title = '가곡 <Ritter raet dem Knappen dies (Bierbaum)>', piece.title_en = 'Ritter raet dem Knappen dies (Bierbaum) Op.57.2',
    piece.type = 'song', piece.opus_number = 'Op. 57.2',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 18640 AND piece.composer_id = 283
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- Op. 79 No. 2 로망스 D장조

UPDATE pieces piece
SET piece.title = '로망스 D장조', piece.title_en = 'Romance In D Major, Op. 79, No. 2',
    piece.type = 'song', piece.opus_number = 'Op. 79 No. 2',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 19610 AND piece.composer_id = 283
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- Op. 30 로망스 E단조

UPDATE pieces piece
SET piece.title = '로망스 E단조', piece.title_en = 'Romance In E Minor, Op. 30',
    piece.type = 'song', piece.opus_number = 'Op. 30',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 19104 AND piece.composer_id = 283
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- Op. 30 로망스 E단조 Op. 30

UPDATE pieces piece
SET piece.title = '로망스 E단조 Op. 30', piece.title_en = 'Romance, op. 30',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = 'Op.', piece.catalogue_number = '30',
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 19530 AND piece.composer_id = 283
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- Op. 9 로망스

UPDATE pieces piece
SET piece.title = '로망스', piece.title_en = 'Romance, op. 9',
    piece.type = 'song', piece.opus_number = 'Op. 9',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 19950 AND piece.composer_id = 283
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- Op. 4.4 가곡 <Sakuntala / Sakuntala>

UPDATE pieces piece
SET piece.title = '가곡 <Sakuntala / Sakuntala>', piece.title_en = 'Sakuntala / Sakuntala, op. 4.4',
    piece.type = 'song', piece.opus_number = 'Op. 4.4',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 18512 AND piece.composer_id = 283
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- Op. 57.9 가곡 <Schlagende Herzen (Bierbaum)>

UPDATE pieces piece
SET piece.title = '가곡 <Schlagende Herzen (Bierbaum)>', piece.title_en = 'Schlagende Herzen (Bierbaum) Op.57.9',
    piece.type = 'song', piece.opus_number = 'Op. 57.9',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 16032 AND piece.composer_id = 283
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- Op. 92 세레나데 2번 A장조

UPDATE pieces piece
SET piece.title = '세레나데 2번 A장조', piece.title_en = 'Serenade for Two Violins and Piano no. 2 in A major, op. 92',
    piece.type = 'album', piece.opus_number = 'Op. 92',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 17495 AND piece.composer_id = 283
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'IV',
    part.name_ko = 'Adagio', part.name_en = 'Serenade for Two Violins and Piano no. 2 in A major op. 92: IV. Adagio',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 17495 AND p.composer_id = 283 AND part.part_key = 'musicbrainz:b2e1abad-4dcd-4389-890e-aca5c58e404c' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:b2e1abad-4dcd-4389-890e-aca5c58e404c', 1, 'IV', 'Adagio', 'Serenade for Two Violins and Piano no. 2 in A major op. 92: IV. Adagio', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 17495 AND p.composer_id = 283
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:b2e1abad-4dcd-4389-890e-aca5c58e404c'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'I',
    part.name_ko = 'Allegro non troppo', part.name_en = 'Serenade for Two Violins and Piano no. 2 in A major, op. 92: I. Allegro non troppo',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 17495 AND p.composer_id = 283 AND part.part_key = 'musicbrainz:007f3399-ee0c-49eb-9bb2-99e2d06b28e6' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:007f3399-ee0c-49eb-9bb2-99e2d06b28e6', 2, 'I', 'Allegro non troppo', 'Serenade for Two Violins and Piano no. 2 in A major, op. 92: I. Allegro non troppo', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 17495 AND p.composer_id = 283
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:007f3399-ee0c-49eb-9bb2-99e2d06b28e6'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'II',
    part.name_ko = 'Andante sostenuto', part.name_en = 'Serenade for Two Violins and Piano no. 2 in A major, op. 92: II. Andante sostenuto',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 17495 AND p.composer_id = 283 AND part.part_key = 'musicbrainz:d8ca9a05-9a27-4e4d-aff0-c7c96795d210' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:d8ca9a05-9a27-4e4d-aff0-c7c96795d210', 3, 'II', 'Andante sostenuto', 'Serenade for Two Violins and Piano no. 2 in A major, op. 92: II. Andante sostenuto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 17495 AND p.composer_id = 283
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:d8ca9a05-9a27-4e4d-aff0-c7c96795d210'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = 'III',
    part.name_ko = 'Allegretto', part.name_en = 'Serenade for Two Violins and Piano no. 2 in A major, op. 92: III. Allegretto',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 17495 AND p.composer_id = 283 AND part.part_key = 'musicbrainz:2cc99721-09d1-499e-a7aa-a30ec4d4b00a' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:2cc99721-09d1-499e-a7aa-a30ec4d4b00a', 4, 'III', 'Allegretto', 'Serenade for Two Violins and Piano no. 2 in A major, op. 92: III. Allegretto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 17495 AND p.composer_id = 283
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:2cc99721-09d1-499e-a7aa-a30ec4d4b00a'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 5, part.movement_number = 'V',
    part.name_ko = 'Deciso ma non troppo allegro', part.name_en = 'Serenade for Two Violins and Piano no. 2 in A major, op. 92: V. Deciso ma non troppo allegro',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 17495 AND p.composer_id = 283 AND part.part_key = 'musicbrainz:99226d32-a796-429f-849e-646479d1222b' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:99226d32-a796-429f-849e-646479d1222b', 5, 'V', 'Deciso ma non troppo allegro', 'Serenade for Two Violins and Piano no. 2 in A major, op. 92: V. Deciso ma non troppo allegro', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 17495 AND p.composer_id = 283
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:99226d32-a796-429f-849e-646479d1222b'
);


-- None 가곡 <Siehst du den Stern / Dost thou see the star, op. 11.2 (Keller)>

UPDATE pieces piece
SET piece.title = '가곡 <Siehst du den Stern / Dost thou see the star, op. 11.2 (Keller)>', piece.title_en = 'Siehst du den Stern / Dost thou see the star, op. 11.2 (Keller)',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 17010 AND piece.composer_id = 283
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None 가곡 <Signe heiter Gjenta mi / Signe is my sweetheart's name>

UPDATE pieces piece
SET piece.title = '가곡 <Signe heiter Gjenta mi / Signe is my sweetheart''s name>', piece.title_en = 'Signe heiter Gjenta mi / Signe is my sweetheart''s name',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 17325 AND piece.composer_id = 283
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- Op. 77.2 가곡 <So gehen die Tage zu Ende (Sergel)>

UPDATE pieces piece
SET piece.title = '가곡 <So gehen die Tage zu Ende (Sergel)>', piece.title_en = 'So gehen die Tage zu Ende (Sergel) Op.77.2',
    piece.type = 'song', piece.opus_number = 'Op. 77.2',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 17527 AND piece.composer_id = 283
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- Op. 69.4 가곡 <So kom du daa atter (Sivle)>

UPDATE pieces piece
SET piece.title = '가곡 <So kom du daa atter (Sivle)>', piece.title_en = 'So kom du daa atter (Sivle) Op.69.4',
    piece.type = 'song', piece.opus_number = 'Op. 69.4',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 16913 AND piece.composer_id = 283
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- Op. 91 피아노 소나타 B단조

UPDATE pieces piece
SET piece.title = '피아노 소나타 B단조', piece.title_en = 'Sonata for Piano in B minor, op. 91',
    piece.type = 'album', piece.opus_number = 'Op. 91',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 17159 AND piece.composer_id = 283
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'Allegro non Troppo', part.name_en = 'Sonata for Piano in B minor, op. 91: I. Allegro non Troppo',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 17159 AND p.composer_id = 283 AND part.part_key = 'musicbrainz:d3d98e76-f9d6-449b-b576-131476b67399' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:d3d98e76-f9d6-449b-b576-131476b67399', 1, 'I', 'Allegro non Troppo', 'Sonata for Piano in B minor, op. 91: I. Allegro non Troppo', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 17159 AND p.composer_id = 283
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:d3d98e76-f9d6-449b-b576-131476b67399'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'Andante', part.name_en = 'Sonata for Piano in B minor, op. 91: II. Andante',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 17159 AND p.composer_id = 283 AND part.part_key = 'musicbrainz:b0f3735b-c8d7-4628-ab71-5590667d213b' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:b0f3735b-c8d7-4628-ab71-5590667d213b', 2, 'II', 'Andante', 'Sonata for Piano in B minor, op. 91: II. Andante', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 17159 AND p.composer_id = 283
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:b0f3735b-c8d7-4628-ab71-5590667d213b'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = 'Vivace', part.name_en = 'Sonata for Piano in B minor, op. 91: III. Vivace',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 17159 AND p.composer_id = 283 AND part.part_key = 'musicbrainz:707876fd-5529-49a6-afa3-fe1878ed996b' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:707876fd-5529-49a6-afa3-fe1878ed996b', 3, 'III', 'Vivace', 'Sonata for Piano in B minor, op. 91: III. Vivace', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 17159 AND p.composer_id = 283
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:707876fd-5529-49a6-afa3-fe1878ed996b'
);


-- None 가곡 <Songs from 'Des Knaben Wunderhorn', Op. 15 - Die Bettelfrau singt>

UPDATE pieces piece
SET piece.title = '가곡 <Songs from ''Des Knaben Wunderhorn'', Op. 15 - Die Bettelfrau singt>', piece.title_en = 'Songs from ''Des Knaben Wunderhorn'', Op. 15 - Die Bettelfrau singt',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 16274 AND piece.composer_id = 283
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None 가곡 <Songs from 'Des Knaben Wunderhorn', Op. 15 - Es Starben zwei Schwestern>

UPDATE pieces piece
SET piece.title = '가곡 <Songs from ''Des Knaben Wunderhorn'', Op. 15 - Es Starben zwei Schwestern>', piece.title_en = 'Songs from ''Des Knaben Wunderhorn'', Op. 15 - Es Starben zwei Schwestern',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 17537 AND piece.composer_id = 283
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None 가곡 <Songs from 'Des Knaben Wunderhorn', Op. 15 - Fuge>

UPDATE pieces piece
SET piece.title = '가곡 <Songs from ''Des Knaben Wunderhorn'', Op. 15 - Fuge>', piece.title_en = 'Songs from ''Des Knaben Wunderhorn'', Op. 15 - Fuge',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 17212 AND piece.composer_id = 283
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None 가곡 <Songs from 'Des Knaben Wunderhorn', Op. 15 - Maria Gnademutter>

UPDATE pieces piece
SET piece.title = '가곡 <Songs from ''Des Knaben Wunderhorn'', Op. 15 - Maria Gnademutter>', piece.title_en = 'Songs from ''Des Knaben Wunderhorn'', Op. 15 - Maria Gnademutter',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 18877 AND piece.composer_id = 283
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None 가곡 <Songs from 'Des Knaben Wunderhorn', Op. 15 - Rosmarin>

UPDATE pieces piece
SET piece.title = '가곡 <Songs from ''Des Knaben Wunderhorn'', Op. 15 - Rosmarin>', piece.title_en = 'Songs from ''Des Knaben Wunderhorn'', Op. 15 - Rosmarin',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 17189 AND piece.composer_id = 283
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None 가곡 <Songs from 'Des Knaben Wunderhorn', Op. 15 - Wiegenlied>

UPDATE pieces piece
SET piece.title = '가곡 <Songs from ''Des Knaben Wunderhorn'', Op. 15 - Wiegenlied>', piece.title_en = 'Songs from ''Des Knaben Wunderhorn'', Op. 15 - Wiegenlied',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 17759 AND piece.composer_id = 283
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- Op. 95.1 가곡 <Sorte Ravner (Schou)>

UPDATE pieces piece
SET piece.title = '가곡 <Sorte Ravner (Schou)>', piece.title_en = 'Sorte Ravner (Schou) Op.95.1',
    piece.type = 'song', piece.opus_number = 'Op. 95.1',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 19650 AND piece.composer_id = 283
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- Op. 77.2 가곡 <Spruch (Sergel)>

UPDATE pieces piece
SET piece.title = '가곡 <Spruch (Sergel)>', piece.title_en = 'Spruch (Sergel) Op.77.2',
    piece.type = 'song', piece.opus_number = 'Op. 77.2',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 19147 AND piece.composer_id = 283
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- Op. 13.2 가곡 <Støvskyer stiger for hvert et Skridt / With every step the dust clouds rise>

UPDATE pieces piece
SET piece.title = '가곡 <Støvskyer stiger for hvert et Skridt / With every step the dust clouds rise>', piece.title_en = 'Støvskyer stiger for hvert et Skridt / With every step the dust clouds rise, op. 13.2',
    piece.type = 'song', piece.opus_number = 'Op. 13.2',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 17730 AND piece.composer_id = 283
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None 바이올린과 피아노를 위한 모음곡 A단조 "Suite im alten Stil"

UPDATE pieces piece
SET piece.title = '바이올린과 피아노를 위한 모음곡 A단조 "Suite im alten Stil"', piece.title_en = 'Suite for Violin and Piano in A minor, op. 10 "Suite im alten Stil"',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 18391 AND piece.composer_id = 283
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'Presto', part.name_en = 'Suite for Violin and Piano in A minor, op. 10 "Suite im alten Stil": I. Presto',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 18391 AND p.composer_id = 283 AND part.part_key = 'musicbrainz:19f6a487-4d4c-46cb-849c-277ae97d251d' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:19f6a487-4d4c-46cb-849c-277ae97d251d', 1, 'I', 'Presto', 'Suite for Violin and Piano in A minor, op. 10 "Suite im alten Stil": I. Presto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 18391 AND p.composer_id = 283
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:19f6a487-4d4c-46cb-849c-277ae97d251d'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'Adagio', part.name_en = 'Suite for Violin and Piano in A minor, op. 10 "Suite im alten Stil": II. Adagio',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 18391 AND p.composer_id = 283 AND part.part_key = 'musicbrainz:712d4c52-44c9-4e22-9b9a-2d62fe59ae9e' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:712d4c52-44c9-4e22-9b9a-2d62fe59ae9e', 2, 'II', 'Adagio', 'Suite for Violin and Piano in A minor, op. 10 "Suite im alten Stil": II. Adagio', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 18391 AND p.composer_id = 283
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:712d4c52-44c9-4e22-9b9a-2d62fe59ae9e'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = 'Tempo giusto', part.name_en = 'Suite for Violin and Piano in A minor, op. 10 "Suite im alten Stil": III. Tempo giusto',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 18391 AND p.composer_id = 283 AND part.part_key = 'musicbrainz:e3d47c39-c1da-40a6-967f-71e7ba5669de' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:e3d47c39-c1da-40a6-967f-71e7ba5669de', 3, 'III', 'Tempo giusto', 'Suite for Violin and Piano in A minor, op. 10 "Suite im alten Stil": III. Tempo giusto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 18391 AND p.composer_id = 283
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:e3d47c39-c1da-40a6-967f-71e7ba5669de'
);


-- Op. 123 Suite für Violine Solo

UPDATE pieces piece
SET piece.title = 'Suite für Violine Solo', piece.title_en = 'Suite für Violine Solo, op. 123',
    piece.type = 'album', piece.opus_number = 'Op. 123',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 17851 AND piece.composer_id = 283
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'Introduction - Allegro risoluto', part.name_en = 'Suite für Violine Solo, op. 123: I. Introduction - Allegro risoluto',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 17851 AND p.composer_id = 283 AND part.part_key = 'musicbrainz:2ab59e40-83c3-475d-88d5-b729564566ee' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:2ab59e40-83c3-475d-88d5-b729564566ee', 1, 'I', 'Introduction - Allegro risoluto', 'Suite für Violine Solo, op. 123: I. Introduction - Allegro risoluto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 17851 AND p.composer_id = 283
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:2ab59e40-83c3-475d-88d5-b729564566ee'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'Sarabande - Adagio', part.name_en = 'Suite für Violine Solo, op. 123: II. Sarabande - Adagio',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 17851 AND p.composer_id = 283 AND part.part_key = 'musicbrainz:be584945-95b3-4020-8e53-1ec9e482af65' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:be584945-95b3-4020-8e53-1ec9e482af65', 2, 'II', 'Sarabande - Adagio', 'Suite für Violine Solo, op. 123: II. Sarabande - Adagio', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 17851 AND p.composer_id = 283
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:be584945-95b3-4020-8e53-1ec9e482af65'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = 'Bourrée - Moderato', part.name_en = 'Suite für Violine Solo, op. 123: III. Bourrée - Moderato',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 17851 AND p.composer_id = 283 AND part.part_key = 'musicbrainz:b260ea6c-0a8c-4108-965e-aa7bd4a13bee' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:b260ea6c-0a8c-4108-965e-aa7bd4a13bee', 3, 'III', 'Bourrée - Moderato', 'Suite für Violine Solo, op. 123: III. Bourrée - Moderato', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 17851 AND p.composer_id = 283
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:b260ea6c-0a8c-4108-965e-aa7bd4a13bee'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = 'IV',
    part.name_ko = 'Chaconne - Andante - Più mosso - Non troppo allegro - Con brio - Moderato - Meno mosso – Andante', part.name_en = 'Suite für Violine Solo, op. 123: IV. Chaconne - Andante - Più mosso - Non troppo allegro - Con brio - Moderato - Meno mosso – Andante',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 17851 AND p.composer_id = 283 AND part.part_key = 'musicbrainz:187e8abb-3ea3-4cd3-998f-f6221d206b8c' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:187e8abb-3ea3-4cd3-998f-f6221d206b8c', 4, 'IV', 'Chaconne - Andante - Più mosso - Non troppo allegro - Con brio - Moderato - Meno mosso – Andante', 'Suite für Violine Solo, op. 123: IV. Chaconne - Andante - Più mosso - Non troppo allegro - Con brio - Moderato - Meno mosso – Andante', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 17851 AND p.composer_id = 283
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:187e8abb-3ea3-4cd3-998f-f6221d206b8c'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 5, part.movement_number = 'V',
    part.name_ko = 'Gavotte', part.name_en = 'Suite für Violine Solo, op. 123: V. Gavotte',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 17851 AND p.composer_id = 283 AND part.part_key = 'musicbrainz:17be4618-45d3-4cb0-9e4a-2d32f5a27a73' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:17be4618-45d3-4cb0-9e4a-2d32f5a27a73', 5, 'V', 'Gavotte', 'Suite für Violine Solo, op. 123: V. Gavotte', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 17851 AND p.composer_id = 283
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:17be4618-45d3-4cb0-9e4a-2d32f5a27a73'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 6, part.movement_number = 'VI',
    part.name_ko = 'Minuetto I', part.name_en = 'Suite für Violine Solo, op. 123: VI. Minuetto I',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 17851 AND p.composer_id = 283 AND part.part_key = 'musicbrainz:841fe912-35c7-4592-b18b-9a669677142a' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:841fe912-35c7-4592-b18b-9a669677142a', 6, 'VI', 'Minuetto I', 'Suite für Violine Solo, op. 123: VI. Minuetto I', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 17851 AND p.composer_id = 283
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:841fe912-35c7-4592-b18b-9a669677142a'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 7, part.movement_number = 'VII',
    part.name_ko = 'Minuetto II', part.name_en = 'Suite für Violine Solo, op. 123: VII. Minuetto II',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 17851 AND p.composer_id = 283 AND part.part_key = 'musicbrainz:c7c7967a-8730-459e-8f0e-efb9123909c9' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:c7c7967a-8730-459e-8f0e-efb9123909c9', 7, 'VII', 'Minuetto II', 'Suite für Violine Solo, op. 123: VII. Minuetto II', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 17851 AND p.composer_id = 283
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:c7c7967a-8730-459e-8f0e-efb9123909c9'
);


-- Op. 55.1 가곡 <Sylvelin (Vislie)>

UPDATE pieces piece
SET piece.title = '가곡 <Sylvelin (Vislie)>', piece.title_en = 'Sylvelin (Vislie) Op.55.1',
    piece.type = 'song', piece.opus_number = 'Op. 55.1',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 19920 AND piece.composer_id = 283
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- Op. 55 No. 1 가곡 <Sylvelin>

UPDATE pieces piece
SET piece.title = '가곡 <Sylvelin>', piece.title_en = 'Sylvelin, op. 55 no. 1',
    piece.type = 'song', piece.opus_number = 'Op. 55 No. 1',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 19230 AND piece.composer_id = 283
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- Op. 21 교향곡 1번 D단조

UPDATE pieces piece
SET piece.title = '교향곡 1번 D단조', piece.title_en = 'Symphony no. 1 in D minor, op. 21',
    piece.type = 'album', piece.opus_number = 'Op. 21',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 16762 AND piece.composer_id = 283
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'Allegro Moderato', part.name_en = 'Symphony no.1 in D minor, op.21: I. Allegro Moderato',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 16762 AND p.composer_id = 283 AND part.part_key = 'musicbrainz:b5801613-146f-40f1-a492-603184c3b204' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:b5801613-146f-40f1-a492-603184c3b204', 1, 'I', 'Allegro Moderato', 'Symphony no.1 in D minor, op.21: I. Allegro Moderato', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 16762 AND p.composer_id = 283
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:b5801613-146f-40f1-a492-603184c3b204'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'Andante', part.name_en = 'Symphony no.1 in D minor, op.21: II. Andante',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 16762 AND p.composer_id = 283 AND part.part_key = 'musicbrainz:9c2ed086-b04c-42f5-b3c5-fd827cadf0ea' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:9c2ed086-b04c-42f5-b3c5-fd827cadf0ea', 2, 'II', 'Andante', 'Symphony no.1 in D minor, op.21: II. Andante', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 16762 AND p.composer_id = 283
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:9c2ed086-b04c-42f5-b3c5-fd827cadf0ea'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = 'Vivace', part.name_en = 'Symphony no.1 in D minor, op.21: III. Vivace',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 16762 AND p.composer_id = 283 AND part.part_key = 'musicbrainz:338a5f0d-12b8-46fe-a786-a9dcfe88dae8' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:338a5f0d-12b8-46fe-a786-a9dcfe88dae8', 3, 'III', 'Vivace', 'Symphony no.1 in D minor, op.21: III. Vivace', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 16762 AND p.composer_id = 283
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:338a5f0d-12b8-46fe-a786-a9dcfe88dae8'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = 'IV',
    part.name_ko = 'Allegro', part.name_en = 'Symphony no.1 in D minor, op.21: IV. Allegro',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 16762 AND p.composer_id = 283 AND part.part_key = 'musicbrainz:c713facf-d27e-4300-83df-ebda6d506488' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:c713facf-d27e-4300-83df-ebda6d506488', 4, 'IV', 'Allegro', 'Symphony no.1 in D minor, op.21: IV. Allegro', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 16762 AND p.composer_id = 283
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:c713facf-d27e-4300-83df-ebda6d506488'
);


-- Op. 83 교향곡 2번 D장조

UPDATE pieces piece
SET piece.title = '교향곡 2번 D장조', piece.title_en = 'Symphony no. 2 in D major, op. 83',
    piece.type = 'album', piece.opus_number = 'Op. 83',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 17478 AND piece.composer_id = 283
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'Allegro Moderato', part.name_en = 'Symphony no.2 in D major, op.83: I. Allegro Moderato',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 17478 AND p.composer_id = 283 AND part.part_key = 'musicbrainz:403dcaa0-9371-4f7c-bd33-0de1a65369f5' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:403dcaa0-9371-4f7c-bd33-0de1a65369f5', 1, 'I', 'Allegro Moderato', 'Symphony no.2 in D major, op.83: I. Allegro Moderato', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 17478 AND p.composer_id = 283
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:403dcaa0-9371-4f7c-bd33-0de1a65369f5'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'Andante', part.name_en = 'Symphony no.2 n D major, op.83: II. Andante',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 17478 AND p.composer_id = 283 AND part.part_key = 'musicbrainz:4c1d8b86-4b13-4fc4-a96a-02537e8a71af' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:4c1d8b86-4b13-4fc4-a96a-02537e8a71af', 2, 'II', 'Andante', 'Symphony no.2 n D major, op.83: II. Andante', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 17478 AND p.composer_id = 283
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:4c1d8b86-4b13-4fc4-a96a-02537e8a71af'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = 'Allegro', part.name_en = 'Symphony no.2 in D major, op.83: III. Allegro',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 17478 AND p.composer_id = 283 AND part.part_key = 'musicbrainz:75aad540-ba63-4643-81c8-95e4fe116abd' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:75aad540-ba63-4643-81c8-95e4fe116abd', 3, 'III', 'Allegro', 'Symphony no.2 in D major, op.83: III. Allegro', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 17478 AND p.composer_id = 283
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:75aad540-ba63-4643-81c8-95e4fe116abd'
);


-- Op. 121 교향곡 3번 F장조

UPDATE pieces piece
SET piece.title = '교향곡 3번 F장조', piece.title_en = 'Symphony no. 3 in F major, op. 121',
    piece.type = 'album', piece.opus_number = 'Op. 121',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 18003 AND piece.composer_id = 283
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'Con fuoco', part.name_en = 'Symphony no. 3 in F major, op. 121: I. Con fuoco',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 18003 AND p.composer_id = 283 AND part.part_key = 'musicbrainz:ae75dda1-382e-4974-a640-f36883f30b61' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:ae75dda1-382e-4974-a640-f36883f30b61', 1, 'I', 'Con fuoco', 'Symphony no. 3 in F major, op. 121: I. Con fuoco', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 18003 AND p.composer_id = 283
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:ae75dda1-382e-4974-a640-f36883f30b61'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'Andante', part.name_en = 'Symphony no. 3 in F major, op. 121: II. Andante',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 18003 AND p.composer_id = 283 AND part.part_key = 'musicbrainz:1a8151e5-5cd9-4a9e-b7fc-98eec59429f7' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:1a8151e5-5cd9-4a9e-b7fc-98eec59429f7', 2, 'II', 'Andante', 'Symphony no. 3 in F major, op. 121: II. Andante', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 18003 AND p.composer_id = 283
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:1a8151e5-5cd9-4a9e-b7fc-98eec59429f7'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = 'Allegro', part.name_en = 'Symphony no. 3 in F major, op. 121: III. Allegro',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 18003 AND p.composer_id = 283 AND part.part_key = 'musicbrainz:f3624049-ecc3-404a-8401-4fa9512873d3' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:f3624049-ecc3-404a-8401-4fa9512873d3', 3, 'III', 'Allegro', 'Symphony no. 3 in F major, op. 121: III. Allegro', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 18003 AND p.composer_id = 283
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:f3624049-ecc3-404a-8401-4fa9512873d3'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = 'IV',
    part.name_ko = 'Non troppo Allegro', part.name_en = 'Symphony no. 3 in F major, op. 121: IV. Non troppo Allegro',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 18003 AND p.composer_id = 283 AND part.part_key = 'musicbrainz:b853a7ab-3314-4968-bb4c-abf9dcebde75' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:b853a7ab-3314-4968-bb4c-abf9dcebde75', 4, 'IV', 'Non troppo Allegro', 'Symphony no. 3 in F major, op. 121: IV. Non troppo Allegro', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 18003 AND p.composer_id = 283
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:b853a7ab-3314-4968-bb4c-abf9dcebde75'
);


-- None 교향곡 4번 "Winter and Spring"

UPDATE pieces piece
SET piece.title = '교향곡 4번 "Winter and Spring"', piece.title_en = 'Symphony no. 4, op. 129 "Winter and Spring"',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 16817 AND piece.composer_id = 283
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'Maestoso', part.name_en = 'Symphony no. 4, op. 129 "Winter and Spring": I. Maestoso',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 16817 AND p.composer_id = 283 AND part.part_key = 'musicbrainz:d9764d54-a695-43ba-ad18-9149af57b78b' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:d9764d54-a695-43ba-ad18-9149af57b78b', 1, 'I', 'Maestoso', 'Symphony no. 4, op. 129 "Winter and Spring": I. Maestoso', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 16817 AND p.composer_id = 283
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:d9764d54-a695-43ba-ad18-9149af57b78b'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'Andante', part.name_en = 'Symphony no. 4, op. 129 "Winter and Spring": II. Andante',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 16817 AND p.composer_id = 283 AND part.part_key = 'musicbrainz:bff45463-cff3-4981-b3fb-0abe9aca8f04' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:bff45463-cff3-4981-b3fb-0abe9aca8f04', 2, 'II', 'Andante', 'Symphony no. 4, op. 129 "Winter and Spring": II. Andante', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 16817 AND p.composer_id = 283
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:bff45463-cff3-4981-b3fb-0abe9aca8f04'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = 'Moderato', part.name_en = 'Symphony no. 4, op. 129 "Winter and Spring": III. Moderato',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 16817 AND p.composer_id = 283 AND part.part_key = 'musicbrainz:114b9366-2e68-4942-b0be-a54f48fcf6b8' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:114b9366-2e68-4942-b0be-a54f48fcf6b8', 3, 'III', 'Moderato', 'Symphony no. 4, op. 129 "Winter and Spring": III. Moderato', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 16817 AND p.composer_id = 283
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:114b9366-2e68-4942-b0be-a54f48fcf6b8'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = 'IV',
    part.name_ko = 'Vivace', part.name_en = 'Symphony no. 4, op. 129 "Winter and Spring": IV. Vivace',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 16817 AND p.composer_id = 283 AND part.part_key = 'musicbrainz:cf90dad7-2dd3-460a-9270-24bf50e3039e' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:cf90dad7-2dd3-460a-9270-24bf50e3039e', 4, 'IV', 'Vivace', 'Symphony no. 4, op. 129 "Winter and Spring": IV. Vivace', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 16817 AND p.composer_id = 283
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:cf90dad7-2dd3-460a-9270-24bf50e3039e'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 5, part.movement_number = 'V',
    part.name_ko = 'Largamente', part.name_en = 'Symphony no. 4, op. 129 "Winter and Spring": V. Largamente',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 16817 AND p.composer_id = 283 AND part.part_key = 'musicbrainz:0f1ab5ee-f7ea-43c3-8c3c-88266d568734' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:0f1ab5ee-f7ea-43c3-8c3c-88266d568734', 5, 'V', 'Largamente', 'Symphony no. 4, op. 129 "Winter and Spring": V. Largamente', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 16817 AND p.composer_id = 283
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:0f1ab5ee-f7ea-43c3-8c3c-88266d568734'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 6, part.movement_number = 'VI',
    part.name_ko = 'Andante', part.name_en = 'Symphony no. 4, op. 129 "Winter and Spring": VI. Andante',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 16817 AND p.composer_id = 283 AND part.part_key = 'musicbrainz:b902fe37-c3da-4bf4-94e7-21a52c55e370' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:b902fe37-c3da-4bf4-94e7-21a52c55e370', 6, 'VI', 'Andante', 'Symphony no. 4, op. 129 "Winter and Spring": VI. Andante', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 16817 AND p.composer_id = 283
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:b902fe37-c3da-4bf4-94e7-21a52c55e370'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 7, part.movement_number = 'VII',
    part.name_ko = 'Non Troppo Allegro', part.name_en = 'Symphony no. 4, op. 129 "Winter and Spring": VII. Non Troppo Allegro',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 16817 AND p.composer_id = 283 AND part.part_key = 'musicbrainz:c83ba451-5040-45ba-9305-f17168627498' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:c83ba451-5040-45ba-9305-f17168627498', 7, 'VII', 'Non Troppo Allegro', 'Symphony no. 4, op. 129 "Winter and Spring": VII. Non Troppo Allegro', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 16817 AND p.composer_id = 283
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:c83ba451-5040-45ba-9305-f17168627498'
);


-- Op. 57.3 가곡 <Tanzlied (Bierbaum)>

UPDATE pieces piece
SET piece.title = '가곡 <Tanzlied (Bierbaum)>', piece.title_en = 'Tanzlied (Bierbaum) Op.57.3',
    piece.type = 'song', piece.opus_number = 'Op. 57.3',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 19733 AND piece.composer_id = 283
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None 가곡 <Totengräberlied / Grave-digger's song, op. 11.6 (Hölty)>

UPDATE pieces piece
SET piece.title = '가곡 <Totengräberlied / Grave-digger''s song, op. 11.6 (Hölty)>', piece.title_en = 'Totengräberlied / Grave-digger''s song, op. 11.6 (Hölty)',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 19173 AND piece.composer_id = 283
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- Op. 57.8 가곡 <Traum durch die Dämmerung (Bierbaum)>

UPDATE pieces piece
SET piece.title = '가곡 <Traum durch die Dämmerung (Bierbaum)>', piece.title_en = 'Traum durch die Dämmerung (Bierbaum) Op.57.8',
    piece.type = 'song', piece.opus_number = 'Op. 57.8',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 17992 AND piece.composer_id = 283
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- Op. 64.8 가곡 <Triolet (Rückert)>

UPDATE pieces piece
SET piece.title = '가곡 <Triolet (Rückert)>', piece.title_en = 'Triolet (Rückert) Op.64.8',
    piece.type = 'song', piece.opus_number = 'Op. 64.8',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 17260 AND piece.composer_id = 283
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- Op. 64.6 가곡 <Und wenn in ihrem Liebesglanz (Rückert)>

UPDATE pieces piece
SET piece.title = '가곡 <Und wenn in ihrem Liebesglanz (Rückert)>', piece.title_en = 'Und wenn in ihrem Liebesglanz (Rückert) Op.64.6',
    piece.type = 'song', piece.opus_number = 'Op. 64.6',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 18384 AND piece.composer_id = 283
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- Op. 69.1 가곡 <Velkomen atter hit (Aasen)>

UPDATE pieces piece
SET piece.title = '가곡 <Velkomen atter hit (Aasen)>', piece.title_en = 'Velkomen atter hit (Aasen) Op.69.1',
    piece.type = 'song', piece.opus_number = 'Op. 69.1',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 19270 AND piece.composer_id = 283
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- Op. 8.3 가곡 <Vi lo jo før saa længe / How much we always laughed>

UPDATE pieces piece
SET piece.title = '가곡 <Vi lo jo før saa længe / How much we always laughed>', piece.title_en = 'Vi lo jo før saa længe / How much we always laughed, op. 8.3',
    piece.type = 'song', piece.opus_number = 'Op. 8.3',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 17703 AND piece.composer_id = 283
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- Op. 38.1 가곡 <Vi vil os et land (Sivle)>

UPDATE pieces piece
SET piece.title = '가곡 <Vi vil os et land (Sivle)>', piece.title_en = 'Vi vil os et land (Sivle) Op.38.1',
    piece.type = 'song', piece.opus_number = 'Op. 38.1',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 16271 AND piece.composer_id = 283
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None 가곡 <Viel Träume / Many Dreams, op. 11.4 (Hamerling)>

UPDATE pieces piece
SET piece.title = '가곡 <Viel Träume / Many Dreams, op. 11.4 (Hamerling)>', piece.title_en = 'Viel Träume / Many Dreams, op. 11.4 (Hamerling)',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 19426 AND piece.composer_id = 283
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- Op. 45 바이올린 협주곡 1번 A장조

UPDATE pieces piece
SET piece.title = '바이올린 협주곡 1번 A장조', piece.title_en = 'Violin Concerto no. 1 in A major, op. 45',
    piece.type = 'album', piece.opus_number = 'Op. 45',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 17953 AND piece.composer_id = 283
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'Allegro Energico', part.name_en = 'Violin Concerto no. 1 in A major, op. 45: I. Allegro Energico',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 17953 AND p.composer_id = 283 AND part.part_key = 'musicbrainz:70f25e65-86fe-41f8-a91c-2cc98acab841' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:70f25e65-86fe-41f8-a91c-2cc98acab841', 1, 'I', 'Allegro Energico', 'Violin Concerto no. 1 in A major, op. 45: I. Allegro Energico', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 17953 AND p.composer_id = 283
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:70f25e65-86fe-41f8-a91c-2cc98acab841'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'Andante', part.name_en = 'Violin Concerto no. 1 in A major, op. 45: II. Andante',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 17953 AND p.composer_id = 283 AND part.part_key = 'musicbrainz:b3929632-9618-423f-a199-92603fcb655f' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:b3929632-9618-423f-a199-92603fcb655f', 2, 'II', 'Andante', 'Violin Concerto no. 1 in A major, op. 45: II. Andante', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 17953 AND p.composer_id = 283
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:b3929632-9618-423f-a199-92603fcb655f'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = 'Allegro giocoso', part.name_en = 'Violin Concerto no. 1 in A major, op. 45: III. Allegro giocoso',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 17953 AND p.composer_id = 283 AND part.part_key = 'musicbrainz:9ddd0770-1538-4fa7-9b6c-b9f82ae10fd1' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:9ddd0770-1538-4fa7-9b6c-b9f82ae10fd1', 3, 'III', 'Allegro giocoso', 'Violin Concerto no. 1 in A major, op. 45: III. Allegro giocoso', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 17953 AND p.composer_id = 283
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:9ddd0770-1538-4fa7-9b6c-b9f82ae10fd1'
);


-- Op. 130.5 가곡 <Vuggesang i Mørketiden (Grieg)>

UPDATE pieces piece
SET piece.title = '가곡 <Vuggesang i Mørketiden (Grieg)>', piece.title_en = 'Vuggesang i Mørketiden (Grieg) Op.130.5',
    piece.type = 'song', piece.opus_number = 'Op. 130.5',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 16363 AND piece.composer_id = 283
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- Op. 59 No. 4 왈츠 E단조

UPDATE pieces piece
SET piece.title = '왈츠 E단조', piece.title_en = 'Waltz In E Minor, Op. 59, No. 4',
    piece.type = 'song', piece.opus_number = 'Op. 59 No. 4',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 17522 AND piece.composer_id = 283
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None 가곡 <Wie glänzt der helle Mond / How bright the moon shines, op. 1.5 (Keller)>

UPDATE pieces piece
SET piece.title = '가곡 <Wie glänzt der helle Mond / How bright the moon shines, op. 1.5 (Keller)>', piece.title_en = 'Wie glänzt der helle Mond / How bright the moon shines, op. 1.5 (Keller)',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 19106 AND piece.composer_id = 283
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- Op. 100 로망스 D장조 Op. 100

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '로망스 D장조 Op. 100', 'Romance in D major, op. 100', 'song', NULL, 'Op.', '100', NULL, 'manual', 1
FROM composers c
WHERE c.id = 283
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '로망스 D장조 Op. 100'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '815b5ce8-4272-4005-a602-b235cd91a35e'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '815b5ce8-4272-4005-a602-b235cd91a35e'
FROM pieces p
WHERE p.composer_id = 283 AND p.title = '로망스 D장조 Op. 100' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '815b5ce8-4272-4005-a602-b235cd91a35e'
);


-- None Suite Im Alten Stil, Op. 10: I. Presto

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, 'Suite Im Alten Stil, Op. 10: I. Presto', 'Suite Im Alten Stil, Op. 10: I. Presto', 'song', NULL, NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 283
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = 'Suite Im Alten Stil, Op. 10: I. Presto'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '12a5b4db-f6c7-4c33-ba5e-30ca735a2116'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '12a5b4db-f6c7-4c33-ba5e-30ca735a2116'
FROM pieces p
WHERE p.composer_id = 283 AND p.title = 'Suite Im Alten Stil, Op. 10: I. Presto' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '12a5b4db-f6c7-4c33-ba5e-30ca735a2116'
);


-- None Suite Im Alten Stil, Op. 10: II. Adagio

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, 'Suite Im Alten Stil, Op. 10: II. Adagio', 'Suite Im Alten Stil, Op. 10: II. Adagio', 'song', NULL, NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 283
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = 'Suite Im Alten Stil, Op. 10: II. Adagio'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '68f427fa-928b-4101-b6dc-dd7cf691b53c'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '68f427fa-928b-4101-b6dc-dd7cf691b53c'
FROM pieces p
WHERE p.composer_id = 283 AND p.title = 'Suite Im Alten Stil, Op. 10: II. Adagio' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '68f427fa-928b-4101-b6dc-dd7cf691b53c'
);


-- None Suite Im Alten Stil, Op. 10: III. Tempo Giusto

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, 'Suite Im Alten Stil, Op. 10: III. Tempo Giusto', 'Suite Im Alten Stil, Op. 10: III. Tempo Giusto', 'song', NULL, NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 283
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = 'Suite Im Alten Stil, Op. 10: III. Tempo Giusto'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'acc73f5a-9474-4722-974c-f3c25a45571d'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'acc73f5a-9474-4722-974c-f3c25a45571d'
FROM pieces p
WHERE p.composer_id = 283 AND p.title = 'Suite Im Alten Stil, Op. 10: III. Tempo Giusto' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'acc73f5a-9474-4722-974c-f3c25a45571d'
);


-- Op. 59 No. 3 왈츠 G장조

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '왈츠 G장조', 'Waltz In G Major, Op. 59, No. 3', 'song', 'Op. 59 No. 3', NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 283
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '왈츠 G장조'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '126a932c-faca-4138-a63a-8b6e92d719b8'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '126a932c-faca-4138-a63a-8b6e92d719b8'
FROM pieces p
WHERE p.composer_id = 283 AND p.title = '왈츠 G장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '126a932c-faca-4138-a63a-8b6e92d719b8'
);


-- 카탈로그에 대응이 없는 seed 작품 7개를 목록에서 숨긴다(지우지 않음).
UPDATE pieces piece
SET piece.hidden_reason = 'catalog_unmatched'
WHERE piece.composer_id = 283 AND piece.origin = 'seed' AND piece.hidden_reason IS NULL
  AND piece.id IN (
    16083, 16223, 16520, 17546, 17824, 17852, 18787
  )
  AND NOT EXISTS (SELECT 1 FROM performance_sectors sector WHERE sector.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM piece_parts linking WHERE linking.linked_piece_id = piece.id);
