-- 닐센 작품을 MusicBrainz 작품 구조로 다시 짠다(4차 자동). 작품 102개(묶음 21, 다악장 25, 낱곡 56),
-- 새 작품 5개, part 223개, 그 아래 35개.
-- seed 108개 중 97개를 작품·part 에 잇고, 10개를 숨기고, 1개는 그대로 둔다.
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

-- Op. 51 29 Little Preludes Op. 51

UPDATE pieces piece
SET piece.title = '29 Little Preludes Op. 51', piece.title_en = '29 Little Preludes, FS 136, op. 51',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = 'Op.', piece.catalogue_number = '51',
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 7498 AND piece.composer_id = 77
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'F장조', part.name_en = '29 Little Preludes, FS 136, op. 51: No. 1 in F major',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 7498 AND p.composer_id = 77 AND part.part_key = 'musicbrainz:831aba76-8d88-4d96-90c7-cf9cd508126e' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:831aba76-8d88-4d96-90c7-cf9cd508126e', 1, NULL, 'F장조', '29 Little Preludes, FS 136, op. 51: No. 1 in F major', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 7498 AND p.composer_id = 77
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:831aba76-8d88-4d96-90c7-cf9cd508126e'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'E단조', part.name_en = '29 Little Preludes, FS 136, op. 51: No. 2 in E minor',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 7498 AND p.composer_id = 77 AND part.part_key = 'musicbrainz:44f16b8e-b289-491c-9437-f4d0807b7999' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:44f16b8e-b289-491c-9437-f4d0807b7999', 2, NULL, 'E단조', '29 Little Preludes, FS 136, op. 51: No. 2 in E minor', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 7498 AND p.composer_id = 77
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:44f16b8e-b289-491c-9437-f4d0807b7999'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = NULL,
    part.name_ko = 'E장조', part.name_en = '29 Little Preludes, FS 136, op. 51: No. 3 in E major',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 7498 AND p.composer_id = 77 AND part.part_key = 'musicbrainz:e3144b44-4df2-40e2-8ed7-8960fced904f' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:e3144b44-4df2-40e2-8ed7-8960fced904f', 3, NULL, 'E장조', '29 Little Preludes, FS 136, op. 51: No. 3 in E major', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 7498 AND p.composer_id = 77
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:e3144b44-4df2-40e2-8ed7-8960fced904f'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = NULL,
    part.name_ko = 'D♭장조', part.name_en = '29 Little Preludes, FS 136, op. 51: No. 4 in D-flat major',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 7498 AND p.composer_id = 77 AND part.part_key = 'musicbrainz:a188d7b7-fff1-4146-82e0-0d850f3397dc' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:a188d7b7-fff1-4146-82e0-0d850f3397dc', 4, NULL, 'D♭장조', '29 Little Preludes, FS 136, op. 51: No. 4 in D-flat major', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 7498 AND p.composer_id = 77
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:a188d7b7-fff1-4146-82e0-0d850f3397dc'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 5, part.movement_number = NULL,
    part.name_ko = 'G단조', part.name_en = '29 Little Preludes, FS 136, op. 51: No. 5 in G minor',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 7498 AND p.composer_id = 77 AND part.part_key = 'musicbrainz:22db4f9b-5251-4738-90d4-77456abaf2fe' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:22db4f9b-5251-4738-90d4-77456abaf2fe', 5, NULL, 'G단조', '29 Little Preludes, FS 136, op. 51: No. 5 in G minor', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 7498 AND p.composer_id = 77
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:22db4f9b-5251-4738-90d4-77456abaf2fe'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 6, part.movement_number = NULL,
    part.name_ko = 'C장조', part.name_en = '29 Little Preludes, FS 136, op. 51: No. 6 in C major',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 7498 AND p.composer_id = 77 AND part.part_key = 'musicbrainz:59311241-5964-44b8-9c6a-01933e80fa0f' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:59311241-5964-44b8-9c6a-01933e80fa0f', 6, NULL, 'C장조', '29 Little Preludes, FS 136, op. 51: No. 6 in C major', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 7498 AND p.composer_id = 77
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:59311241-5964-44b8-9c6a-01933e80fa0f'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 7, part.movement_number = NULL,
    part.name_ko = 'F장조', part.name_en = '29 Little Preludes, FS 136, op. 51: No. 7 in F major',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 7498 AND p.composer_id = 77 AND part.part_key = 'musicbrainz:8bb519a7-6d2f-4577-9e8a-f05b8a2e7297' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:8bb519a7-6d2f-4577-9e8a-f05b8a2e7297', 7, NULL, 'F장조', '29 Little Preludes, FS 136, op. 51: No. 7 in F major', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 7498 AND p.composer_id = 77
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:8bb519a7-6d2f-4577-9e8a-f05b8a2e7297'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 8, part.movement_number = NULL,
    part.name_ko = 'E장조', part.name_en = '29 Little Preludes, FS 136, op. 51: No. 8 in E major',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 7498 AND p.composer_id = 77 AND part.part_key = 'musicbrainz:d7f77685-0fe9-46de-8c1c-10be89178cdb' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:d7f77685-0fe9-46de-8c1c-10be89178cdb', 8, NULL, 'E장조', '29 Little Preludes, FS 136, op. 51: No. 8 in E major', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 7498 AND p.composer_id = 77
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:d7f77685-0fe9-46de-8c1c-10be89178cdb'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 9, part.movement_number = NULL,
    part.name_ko = 'B♭장조', part.name_en = '29 Little Preludes, FS 136, op. 51: No. 9 in B-flat major',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 7498 AND p.composer_id = 77 AND part.part_key = 'musicbrainz:9061a3a2-03a6-4b5e-b883-ec79bf84cea9' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:9061a3a2-03a6-4b5e-b883-ec79bf84cea9', 9, NULL, 'B♭장조', '29 Little Preludes, FS 136, op. 51: No. 9 in B-flat major', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 7498 AND p.composer_id = 77
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:9061a3a2-03a6-4b5e-b883-ec79bf84cea9'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 10, part.movement_number = NULL,
    part.name_ko = 'G단조', part.name_en = '29 Little Preludes, FS 136, op. 51: No. 10 in G minor',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 7498 AND p.composer_id = 77 AND part.part_key = 'musicbrainz:7cfb9e7e-e5f9-4ff8-bb04-9263186afa9e' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:7cfb9e7e-e5f9-4ff8-bb04-9263186afa9e', 10, NULL, 'G단조', '29 Little Preludes, FS 136, op. 51: No. 10 in G minor', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 7498 AND p.composer_id = 77
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:7cfb9e7e-e5f9-4ff8-bb04-9263186afa9e'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 11, part.movement_number = NULL,
    part.name_ko = 'G장조', part.name_en = '29 Little Preludes, FS 136, op. 51: No. 11 in G major',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 7498 AND p.composer_id = 77 AND part.part_key = 'musicbrainz:6fe8ec5a-6b25-4e19-abdf-fd3bec10d092' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:6fe8ec5a-6b25-4e19-abdf-fd3bec10d092', 11, NULL, 'G장조', '29 Little Preludes, FS 136, op. 51: No. 11 in G major', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 7498 AND p.composer_id = 77
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:6fe8ec5a-6b25-4e19-abdf-fd3bec10d092'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 12, part.movement_number = NULL,
    part.name_ko = 'D단조', part.name_en = '29 Little Preludes, FS 136, op. 51: No. 12 in D minor',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 7498 AND p.composer_id = 77 AND part.part_key = 'musicbrainz:0c382be3-23e2-450a-8132-01bc6fab7c3a' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:0c382be3-23e2-450a-8132-01bc6fab7c3a', 12, NULL, 'D단조', '29 Little Preludes, FS 136, op. 51: No. 12 in D minor', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 7498 AND p.composer_id = 77
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:0c382be3-23e2-450a-8132-01bc6fab7c3a'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 13, part.movement_number = NULL,
    part.name_ko = 'G장조', part.name_en = '29 Little Preludes, FS 136, op. 51: No. 13 in G major',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 7498 AND p.composer_id = 77 AND part.part_key = 'musicbrainz:1c13224a-6941-485d-8e04-a8f093db0a69' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:1c13224a-6941-485d-8e04-a8f093db0a69', 13, NULL, 'G장조', '29 Little Preludes, FS 136, op. 51: No. 13 in G major', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 7498 AND p.composer_id = 77
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:1c13224a-6941-485d-8e04-a8f093db0a69'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 14, part.movement_number = NULL,
    part.name_ko = 'E♭장조', part.name_en = '29 Little Preludes, FS 136, op. 51: No. 14 in E-flat major',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 7498 AND p.composer_id = 77 AND part.part_key = 'musicbrainz:9b3f08a2-0717-4811-a717-4e19452cb7ad' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:9b3f08a2-0717-4811-a717-4e19452cb7ad', 14, NULL, 'E♭장조', '29 Little Preludes, FS 136, op. 51: No. 14 in E-flat major', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 7498 AND p.composer_id = 77
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:9b3f08a2-0717-4811-a717-4e19452cb7ad'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 15, part.movement_number = NULL,
    part.name_ko = 'A장조', part.name_en = '29 Little Preludes, FS 136, op. 51: No. 15 in A major',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 7498 AND p.composer_id = 77 AND part.part_key = 'musicbrainz:db9560a4-972b-45a6-b335-a5005675bdd1' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:db9560a4-972b-45a6-b335-a5005675bdd1', 15, NULL, 'A장조', '29 Little Preludes, FS 136, op. 51: No. 15 in A major', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 7498 AND p.composer_id = 77
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:db9560a4-972b-45a6-b335-a5005675bdd1'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 16, part.movement_number = NULL,
    part.name_ko = 'D장조', part.name_en = '29 Little Preludes, FS 136, op. 51: No. 16 in D major',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 7498 AND p.composer_id = 77 AND part.part_key = 'musicbrainz:28430e03-fcd1-4186-a08c-fd4e635e8249' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:28430e03-fcd1-4186-a08c-fd4e635e8249', 16, NULL, 'D장조', '29 Little Preludes, FS 136, op. 51: No. 16 in D major', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 7498 AND p.composer_id = 77
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:28430e03-fcd1-4186-a08c-fd4e635e8249'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 17, part.movement_number = NULL,
    part.name_ko = 'G장조', part.name_en = '29 Little Preludes, FS 136, op. 51: No. 17 in G major',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 7498 AND p.composer_id = 77 AND part.part_key = 'musicbrainz:3f965a4d-99d2-49fe-bc6b-ebe58a7f7433' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:3f965a4d-99d2-49fe-bc6b-ebe58a7f7433', 17, NULL, 'G장조', '29 Little Preludes, FS 136, op. 51: No. 17 in G major', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 7498 AND p.composer_id = 77
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:3f965a4d-99d2-49fe-bc6b-ebe58a7f7433'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 18, part.movement_number = NULL,
    part.name_ko = 'C장조', part.name_en = '29 Little Preludes, FS 136, op. 51: No. 18 in C major',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 7498 AND p.composer_id = 77 AND part.part_key = 'musicbrainz:d9d0381a-c784-4f1f-bc3b-07ad1663917e' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:d9d0381a-c784-4f1f-bc3b-07ad1663917e', 18, NULL, 'C장조', '29 Little Preludes, FS 136, op. 51: No. 18 in C major', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 7498 AND p.composer_id = 77
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:d9d0381a-c784-4f1f-bc3b-07ad1663917e'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 19, part.movement_number = NULL,
    part.name_ko = 'A단조', part.name_en = '29 Little Preludes, FS 136, op. 51: No. 19 in A minor',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 7498 AND p.composer_id = 77 AND part.part_key = 'musicbrainz:10414b90-379c-4988-a12e-5f6025e15559' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:10414b90-379c-4988-a12e-5f6025e15559', 19, NULL, 'A단조', '29 Little Preludes, FS 136, op. 51: No. 19 in A minor', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 7498 AND p.composer_id = 77
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:10414b90-379c-4988-a12e-5f6025e15559'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 20, part.movement_number = NULL,
    part.name_ko = 'D단조', part.name_en = '29 Little Preludes, FS 136, op. 51: No. 20 in D minor',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 7498 AND p.composer_id = 77 AND part.part_key = 'musicbrainz:2af7b752-3b7d-4b8a-946c-93d33b0dd57a' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:2af7b752-3b7d-4b8a-946c-93d33b0dd57a', 20, NULL, 'D단조', '29 Little Preludes, FS 136, op. 51: No. 20 in D minor', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 7498 AND p.composer_id = 77
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:2af7b752-3b7d-4b8a-946c-93d33b0dd57a'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 21, part.movement_number = NULL,
    part.name_ko = 'D단조', part.name_en = '29 Little Preludes, FS 136, op. 51: No. 21 in D minor',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 7498 AND p.composer_id = 77 AND part.part_key = 'musicbrainz:ce84ac64-0bec-4a84-9559-7c35b22ed859' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:ce84ac64-0bec-4a84-9559-7c35b22ed859', 21, NULL, 'D단조', '29 Little Preludes, FS 136, op. 51: No. 21 in D minor', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 7498 AND p.composer_id = 77
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:ce84ac64-0bec-4a84-9559-7c35b22ed859'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 22, part.movement_number = NULL,
    part.name_ko = 'E♭장조', part.name_en = '29 Little Preludes, FS 136, op. 51: No. 22 in E-flat major',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 7498 AND p.composer_id = 77 AND part.part_key = 'musicbrainz:3327705c-cca6-412f-9170-5dc1b76f79ab' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:3327705c-cca6-412f-9170-5dc1b76f79ab', 22, NULL, 'E♭장조', '29 Little Preludes, FS 136, op. 51: No. 22 in E-flat major', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 7498 AND p.composer_id = 77
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:3327705c-cca6-412f-9170-5dc1b76f79ab'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 23, part.movement_number = NULL,
    part.name_ko = 'E♭장조', part.name_en = '29 Little Preludes, FS 136, op. 51: No. 23 in E-flat major',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 7498 AND p.composer_id = 77 AND part.part_key = 'musicbrainz:5a88dfbc-cc7f-4070-ba26-97d455882864' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:5a88dfbc-cc7f-4070-ba26-97d455882864', 23, NULL, 'E♭장조', '29 Little Preludes, FS 136, op. 51: No. 23 in E-flat major', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 7498 AND p.composer_id = 77
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:5a88dfbc-cc7f-4070-ba26-97d455882864'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 24, part.movement_number = NULL,
    part.name_ko = 'E단조', part.name_en = '29 Little Preludes, FS 136, op. 51: No. 24 in E minor',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 7498 AND p.composer_id = 77 AND part.part_key = 'musicbrainz:622815ff-7039-46d7-8262-ac9c9d4df263' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:622815ff-7039-46d7-8262-ac9c9d4df263', 24, NULL, 'E단조', '29 Little Preludes, FS 136, op. 51: No. 24 in E minor', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 7498 AND p.composer_id = 77
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:622815ff-7039-46d7-8262-ac9c9d4df263'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 25, part.movement_number = NULL,
    part.name_ko = 'F♯단조', part.name_en = '29 Little Preludes, FS 136, op. 51: No. 25 in F-sharp minor',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 7498 AND p.composer_id = 77 AND part.part_key = 'musicbrainz:1ebc46ec-94f7-49ca-8bdb-e842201de413' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:1ebc46ec-94f7-49ca-8bdb-e842201de413', 25, NULL, 'F♯단조', '29 Little Preludes, FS 136, op. 51: No. 25 in F-sharp minor', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 7498 AND p.composer_id = 77
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:1ebc46ec-94f7-49ca-8bdb-e842201de413'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 26, part.movement_number = NULL,
    part.name_ko = 'E단조', part.name_en = '29 Little Preludes, FS 136, op. 51: No. 26 in E minor',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 7498 AND p.composer_id = 77 AND part.part_key = 'musicbrainz:2e403d16-8249-44f6-9de6-7178a308875b' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:2e403d16-8249-44f6-9de6-7178a308875b', 26, NULL, 'E단조', '29 Little Preludes, FS 136, op. 51: No. 26 in E minor', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 7498 AND p.composer_id = 77
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:2e403d16-8249-44f6-9de6-7178a308875b'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 27, part.movement_number = NULL,
    part.name_ko = 'F♯단조', part.name_en = '29 Little Preludes, FS 136, op. 51: No. 27 in F-sharp minor',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 7498 AND p.composer_id = 77 AND part.part_key = 'musicbrainz:479ccb24-f12c-4f38-a4d6-b59e80e70016' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:479ccb24-f12c-4f38-a4d6-b59e80e70016', 27, NULL, 'F♯단조', '29 Little Preludes, FS 136, op. 51: No. 27 in F-sharp minor', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 7498 AND p.composer_id = 77
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:479ccb24-f12c-4f38-a4d6-b59e80e70016'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 28, part.movement_number = NULL,
    part.name_ko = 'C장조', part.name_en = '29 Little Preludes, FS 136, op. 51: No. 28 in C major',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 7498 AND p.composer_id = 77 AND part.part_key = 'musicbrainz:1d3517e9-fe5f-4ab6-a341-4beb039df89b' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:1d3517e9-fe5f-4ab6-a341-4beb039df89b', 28, NULL, 'C장조', '29 Little Preludes, FS 136, op. 51: No. 28 in C major', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 7498 AND p.composer_id = 77
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:1d3517e9-fe5f-4ab6-a341-4beb039df89b'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 29, part.movement_number = NULL,
    part.name_ko = 'F장조', part.name_en = '29 Little Preludes, FS 136, op. 51: No. 29 in F major',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 7498 AND p.composer_id = 77 AND part.part_key = 'musicbrainz:17a10711-4ca8-4dd9-afa3-8469556de5fc' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:17a10711-4ca8-4dd9-afa3-8469556de5fc', 29, NULL, 'F장조', '29 Little Preludes, FS 136, op. 51: No. 29 in F major', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 7498 AND p.composer_id = 77
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:17a10711-4ca8-4dd9-afa3-8469556de5fc'
);


-- Op. 3 5 Klavierstücke Op. 3

UPDATE pieces piece
SET piece.title = '5 Klavierstücke Op. 3', piece.title_en = '5 Klavierstücke, op. 3',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = 'Op.', piece.catalogue_number = '3',
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 8032 AND piece.composer_id = 77
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'Folketone (im Volkston)', part.name_en = '5 Klavierstücke, op. 3: Folketone (im Volkston)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 8032 AND p.composer_id = 77 AND part.part_key = 'musicbrainz:863d8dfd-754b-4b20-8192-e49c38e8e154' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:863d8dfd-754b-4b20-8192-e49c38e8e154', 1, NULL, 'Folketone (im Volkston)', '5 Klavierstücke, op. 3: Folketone (im Volkston)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 8032 AND p.composer_id = 77
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:863d8dfd-754b-4b20-8192-e49c38e8e154'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'Humoreske', part.name_en = '5 Klavierstücke, op. 3: Humoreske',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 8032 AND p.composer_id = 77 AND part.part_key = 'musicbrainz:199608f5-0bf6-4f1c-8a1a-080eb6d259aa' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:199608f5-0bf6-4f1c-8a1a-080eb6d259aa', 2, NULL, 'Humoreske', '5 Klavierstücke, op. 3: Humoreske', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 8032 AND p.composer_id = 77
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:199608f5-0bf6-4f1c-8a1a-080eb6d259aa'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = NULL,
    part.name_ko = 'Arabeske', part.name_en = '5 Klavierstücke, op. 3: Arabeske',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 8032 AND p.composer_id = 77 AND part.part_key = 'musicbrainz:d2c1ca57-3d8f-4e9c-8c8a-ab7226a17dbf' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:d2c1ca57-3d8f-4e9c-8c8a-ab7226a17dbf', 3, NULL, 'Arabeske', '5 Klavierstücke, op. 3: Arabeske', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 8032 AND p.composer_id = 77
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:d2c1ca57-3d8f-4e9c-8c8a-ab7226a17dbf'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = NULL,
    part.name_ko = 'Mignon', part.name_en = '5 Klavierstücke, op. 3: Mignon',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 8032 AND p.composer_id = 77 AND part.part_key = 'musicbrainz:67baa22c-98ac-4a51-8303-d7de95c196d5' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:67baa22c-98ac-4a51-8303-d7de95c196d5', 4, NULL, 'Mignon', '5 Klavierstücke, op. 3: Mignon', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 8032 AND p.composer_id = 77
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:67baa22c-98ac-4a51-8303-d7de95c196d5'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 5, part.movement_number = NULL,
    part.name_ko = 'Alfedans (Elfentanz)', part.name_en = '5 Klavierstücke, op. 3: Alfedans (Elfentanz)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 8032 AND p.composer_id = 77 AND part.part_key = 'musicbrainz:8b668182-938b-44bc-9c0a-19a9f686640a' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:8b668182-938b-44bc-9c0a-19a9f686640a', 5, NULL, 'Alfedans (Elfentanz)', '5 Klavierstücke, op. 3: Alfedans (Elfentanz)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 8032 AND p.composer_id = 77
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:8b668182-938b-44bc-9c0a-19a9f686640a'
);


-- FS 48 가곡 <Aftenstemning>

UPDATE pieces piece
SET piece.title = '가곡 <Aftenstemning>', piece.title_en = 'Aftenstemning, FS 48',
    piece.type = 'song', piece.opus_number = 'FS 48',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 7465 AND piece.composer_id = 77
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- Op. 34 부수음악 <Aladdin> Op. 34

UPDATE pieces piece
SET piece.title = '부수음악 <Aladdin> Op. 34', piece.title_en = 'Aladdin, op. 34',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = 'Op.', piece.catalogue_number = '34',
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 8295 AND piece.composer_id = 77
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'Prologue', part.name_en = 'Aladdin, op. 34: Prologue',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 8295 AND p.composer_id = 77 AND part.part_key = 'musicbrainz:2a1bfc3c-8c65-470a-857a-54e5fdbf3e2e' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:2a1bfc3c-8c65-470a-857a-54e5fdbf3e2e', 1, NULL, 'Prologue', 'Aladdin, op. 34: Prologue', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 8295 AND p.composer_id = 77
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:2a1bfc3c-8c65-470a-857a-54e5fdbf3e2e'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'Act I', part.name_en = 'Aladdin, op. 34: Act I',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 8295 AND p.composer_id = 77 AND part.part_key = 'musicbrainz:97f6dcac-44f4-4654-97bd-3ce49c6def6b' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:97f6dcac-44f4-4654-97bd-3ce49c6def6b', 2, NULL, 'Act I', 'Aladdin, op. 34: Act I', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 8295 AND p.composer_id = 77
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:97f6dcac-44f4-4654-97bd-3ce49c6def6b'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = NULL,
    part.name_ko = 'Act II', part.name_en = 'Aladdin, op. 34: Act II',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 8295 AND p.composer_id = 77 AND part.part_key = 'musicbrainz:8e1b4c0e-d840-4fa6-b1bc-08986a7711cd' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:8e1b4c0e-d840-4fa6-b1bc-08986a7711cd', 3, NULL, 'Act II', 'Aladdin, op. 34: Act II', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 8295 AND p.composer_id = 77
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:8e1b4c0e-d840-4fa6-b1bc-08986a7711cd'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = NULL,
    part.name_ko = 'Act III', part.name_en = 'Aladdin, op. 34: Act III',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 8295 AND p.composer_id = 77 AND part.part_key = 'musicbrainz:f57fa601-2eb9-4ea3-9147-a96a3ce61172' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:f57fa601-2eb9-4ea3-9147-a96a3ce61172', 4, NULL, 'Act III', 'Aladdin, op. 34: Act III', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 8295 AND p.composer_id = 77
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:f57fa601-2eb9-4ea3-9147-a96a3ce61172'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 5, part.movement_number = NULL,
    part.name_ko = 'Act IV', part.name_en = 'Aladdin, op. 34: Act IV',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 8295 AND p.composer_id = 77 AND part.part_key = 'musicbrainz:898649ae-f72f-46ed-96a0-975726d9ff68' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:898649ae-f72f-46ed-96a0-975726d9ff68', 5, NULL, 'Act IV', 'Aladdin, op. 34: Act IV', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 8295 AND p.composer_id = 77
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:898649ae-f72f-46ed-96a0-975726d9ff68'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 6, part.movement_number = NULL,
    part.name_ko = 'Act V', part.name_en = 'Aladdin, op. 34: Act V',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 8295 AND p.composer_id = 77 AND part.part_key = 'musicbrainz:2982b6e3-158e-48b5-a5a3-236e5bfdf3d0' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:2982b6e3-158e-48b5-a5a3-236e5bfdf3d0', 6, NULL, 'Act V', 'Aladdin, op. 34: Act V', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 8295 AND p.composer_id = 77
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:2982b6e3-158e-48b5-a5a3-236e5bfdf3d0'
);


-- None Allegretto in C major

UPDATE pieces piece
SET piece.title = 'Allegretto in C major', piece.title_en = 'Allegretto in C major',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 9311 AND piece.composer_id = 77
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Amor og Digteren

UPDATE pieces piece
SET piece.title = 'Amor og Digteren', piece.title_en = 'Amor og Digteren',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 7494 AND piece.composer_id = 77
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'Overture', part.name_en = 'Amor og Digteren: Overture',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 7494 AND p.composer_id = 77 AND part.part_key = 'musicbrainz:2c536171-a0eb-4693-9d72-fad4b64b8d6a' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:2c536171-a0eb-4693-9d72-fad4b64b8d6a', 1, NULL, 'Overture', 'Amor og Digteren: Overture', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 7494 AND p.composer_id = 77
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:2c536171-a0eb-4693-9d72-fad4b64b8d6a'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'Andante', part.name_en = 'Amor og Digteren: No. 1. Andante',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 7494 AND p.composer_id = 77 AND part.part_key = 'musicbrainz:06c4f09a-f0d3-4dd8-a7b1-400062f52952' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:06c4f09a-f0d3-4dd8-a7b1-400062f52952', 2, NULL, 'Andante', 'Amor og Digteren: No. 1. Andante', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 7494 AND p.composer_id = 77
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:06c4f09a-f0d3-4dd8-a7b1-400062f52952'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = NULL,
    part.name_ko = 'Andantino', part.name_en = 'Amor og Digteren: No. 2. Andantino',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 7494 AND p.composer_id = 77 AND part.part_key = 'musicbrainz:ac9aa145-0138-49d9-b2ef-bdff76970aac' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:ac9aa145-0138-49d9-b2ef-bdff76970aac', 3, NULL, 'Andantino', 'Amor og Digteren: No. 2. Andantino', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 7494 AND p.composer_id = 77
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:ac9aa145-0138-49d9-b2ef-bdff76970aac'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = NULL,
    part.name_ko = 'Andantino', part.name_en = 'Amor og Digteren: No. 3. Andantino',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 7494 AND p.composer_id = 77 AND part.part_key = 'musicbrainz:20ad0b63-b59e-4ba9-817a-d7a3ca27617a' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:20ad0b63-b59e-4ba9-817a-d7a3ca27617a', 4, NULL, 'Andantino', 'Amor og Digteren: No. 3. Andantino', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 7494 AND p.composer_id = 77
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:20ad0b63-b59e-4ba9-817a-d7a3ca27617a'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 5, part.movement_number = NULL,
    part.name_ko = 'Andante quassi sostenuto', part.name_en = 'Amor og Digteren: No. 4. Andante quassi sostenuto',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 7494 AND p.composer_id = 77 AND part.part_key = 'musicbrainz:9a9647e3-354f-42a2-afbf-d65886503a37' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:9a9647e3-354f-42a2-afbf-d65886503a37', 5, NULL, 'Andante quassi sostenuto', 'Amor og Digteren: No. 4. Andante quassi sostenuto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 7494 AND p.composer_id = 77
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:9a9647e3-354f-42a2-afbf-d65886503a37'
);


-- CNW 31 Andante tranquillo e Scherzo

UPDATE pieces piece
SET piece.title = 'Andante tranquillo e Scherzo', piece.title_en = 'Andante tranquillo e Scherzo, CNW 31',
    piece.type = 'album', piece.opus_number = 'CNW 31',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 9375 AND piece.composer_id = 77
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'Andante tranquillo', part.name_en = 'Andante tranquillo e Scherzo, CNW 31: I. Andante tranquillo',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 9375 AND p.composer_id = 77 AND part.part_key = 'musicbrainz:c4f50174-ee6b-459a-a1b3-a303453c2190' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:c4f50174-ee6b-459a-a1b3-a303453c2190', 1, 'I', 'Andante tranquillo', 'Andante tranquillo e Scherzo, CNW 31: I. Andante tranquillo', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 9375 AND p.composer_id = 77
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:c4f50174-ee6b-459a-a1b3-a303453c2190'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'Scherzo', part.name_en = 'Andante tranquillo e Scherzo, CNW 31: II. Scherzo',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 9375 AND p.composer_id = 77 AND part.part_key = 'musicbrainz:3d5978e0-4edd-4c5a-a774-b227cf11ef8c' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:3d5978e0-4edd-4c5a-a774-b227cf11ef8c', 2, 'II', 'Scherzo', 'Andante tranquillo e Scherzo, CNW 31: II. Scherzo', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 9375 AND p.composer_id = 77
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:3d5978e0-4edd-4c5a-a774-b227cf11ef8c'
);


-- CNW 302 가곡 <Ariels Sang>

UPDATE pieces piece
SET piece.title = '가곡 <Ariels Sang>', piece.title_en = 'Ariels Sang, CNW 302',
    piece.type = 'song', piece.opus_number = 'CNW 302',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 9833 AND piece.composer_id = 77
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- CNW 254 Betragt mit svage spind

UPDATE pieces piece
SET piece.title = 'Betragt mit svage spind', piece.title_en = 'Betragt mit svage spind, CNW 254',
    piece.type = 'song', piece.opus_number = 'CNW 254',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 10209 AND piece.composer_id = 77
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Bidrag til “Tillæg til Folkehøjskolens Melodibog”

UPDATE pieces piece
SET piece.title = 'Bidrag til “Tillæg til Folkehøjskolens Melodibog”', piece.title_en = 'Bidrag til “Tillæg til Folkehøjskolens Melodibog”',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 11285 AND piece.composer_id = 77
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'Der er en gammel rønne, CNW 323', part.name_en = 'Der er en gammel rønne, CNW 323',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11285 AND p.composer_id = 77 AND part.part_key = 'musicbrainz:4b0813a1-3b45-404e-bcf7-f84bd07e53bc' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:4b0813a1-3b45-404e-bcf7-f84bd07e53bc', 1, NULL, 'Der er en gammel rønne, CNW 323', 'Der er en gammel rønne, CNW 323', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 11285 AND p.composer_id = 77
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:4b0813a1-3b45-404e-bcf7-f84bd07e53bc'
);


-- FS 130 Bøhmisk-dansk folketone, paraphrase for string orchestra

UPDATE pieces piece
SET piece.title = 'Bøhmisk-dansk folketone, paraphrase for string orchestra', piece.title_en = 'Bøhmisk-dansk folketone, paraphrase for string orchestra, FS 130',
    piece.type = 'song', piece.opus_number = 'FS 130',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 9942 AND piece.composer_id = 77
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- FS 132 Canto serioso für Horn und Klavier

UPDATE pieces piece
SET piece.title = 'Canto serioso für Horn und Klavier', piece.title_en = 'Canto serioso für Horn und Klavier, FS 132',
    piece.type = 'song', piece.opus_number = 'FS 132',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 9467 AND piece.composer_id = 77
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- Op. 32 Chaconne for klaver

UPDATE pieces piece
SET piece.title = 'Chaconne for klaver', piece.title_en = 'Chaconne for klaver, op. 32, FS 79',
    piece.type = 'song', piece.opus_number = 'Op. 32',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 11132 AND piece.composer_id = 77
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- Op. 58 Commotio

UPDATE pieces piece
SET piece.title = 'Commotio', piece.title_en = 'Commotio, op. 58, FS. 155',
    piece.type = 'song', piece.opus_number = 'Op. 58',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 8702 AND piece.composer_id = 77
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- Op. 33 바이올린 협주곡

UPDATE pieces piece
SET piece.title = '바이올린 협주곡', piece.title_en = 'Concerto for Violin and Orchestra, op. 33',
    piece.type = 'album', piece.opus_number = 'Op. 33',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 7580 AND piece.composer_id = 77
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'Praeludium (Largo) - Allegro cavalleresco', part.name_en = 'Concerto for Violin and Orchestra, op. 33: I. Praeludium (Largo) - Allegro cavalleresco',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 7580 AND p.composer_id = 77 AND part.part_key = 'musicbrainz:1de3aeab-8c8d-4695-8624-60e1172dc950' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:1de3aeab-8c8d-4695-8624-60e1172dc950', 1, 'I', 'Praeludium (Largo) - Allegro cavalleresco', 'Concerto for Violin and Orchestra, op. 33: I. Praeludium (Largo) - Allegro cavalleresco', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 7580 AND p.composer_id = 77
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:1de3aeab-8c8d-4695-8624-60e1172dc950'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'Poco adagio', part.name_en = 'Concerto for Violin and Orchestra, op. 33: II. Poco adagio',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 7580 AND p.composer_id = 77 AND part.part_key = 'musicbrainz:1a8a61b2-f828-44aa-b67a-db733e621772' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:1a8a61b2-f828-44aa-b67a-db733e621772', 2, 'II', 'Poco adagio', 'Concerto for Violin and Orchestra, op. 33: II. Poco adagio', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 7580 AND p.composer_id = 77
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:1a8a61b2-f828-44aa-b67a-db733e621772'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = 'Rondo: Allegretto scherzando', part.name_en = 'Concerto for Violin and Orchestra, op. 33: III. Rondo: Allegretto scherzando',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 7580 AND p.composer_id = 77 AND part.part_key = 'musicbrainz:a30a2304-6a4b-466c-b7dd-c4de66c3e1d0' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:a30a2304-6a4b-466c-b7dd-c4de66c3e1d0', 3, 'III', 'Rondo: Allegretto scherzando', 'Concerto for Violin and Orchestra, op. 33: III. Rondo: Allegretto scherzando', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 7580 AND p.composer_id = 77
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:a30a2304-6a4b-466c-b7dd-c4de66c3e1d0'
);


-- None 가곡 <Danmark, i tusind år>

UPDATE pieces piece
SET piece.title = '가곡 <Danmark, i tusind år>', piece.title_en = 'Danmark, i tusind år',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 8495 AND piece.composer_id = 77
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None 가곡 <De snekker mødtes i kvæld på hav>

UPDATE pieces piece
SET piece.title = '가곡 <De snekker mødtes i kvæld på hav>', piece.title_en = 'De snekker mødtes i kvæld på hav',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 8714 AND piece.composer_id = 77
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- CNW 271 가곡 <Den danske sang er en ung, blond pige>

UPDATE pieces piece
SET piece.title = '가곡 <Den danske sang er en ung, blond pige>', piece.title_en = 'Den danske sang er en ung, blond pige, CNW 271',
    piece.type = 'song', piece.opus_number = 'CNW 271',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 8275 AND piece.composer_id = 77
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- CNW 244 가곡 <Der sad en fisker så tankefuld>

UPDATE pieces piece
SET piece.title = '가곡 <Der sad en fisker så tankefuld>', piece.title_en = 'Der sad en fisker så tankefuld, CNW 244',
    piece.type = 'song', piece.opus_number = 'CNW 244',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 8962 AND piece.composer_id = 77
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- CNW 239 가곡 <Derfor kan vort øje glædes>

UPDATE pieces piece
SET piece.title = '가곡 <Derfor kan vort øje glædes>', piece.title_en = 'Derfor kan vort øje glædes, CNW 239',
    piece.type = 'song', piece.opus_number = 'CNW 239',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 7751 AND piece.composer_id = 77
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- FS 34 Drømmen om "Glade Jul" (Dream of a "Merry Christmas")

UPDATE pieces piece
SET piece.title = 'Drømmen om "Glade Jul" (Dream of a "Merry Christmas")', piece.title_en = 'Drømmen om "Glade Jul" (Dream of a "Merry Christmas"), FS 34',
    piece.type = 'song', piece.opus_number = 'FS 34',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 9777 AND piece.composer_id = 77
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- CNW 288 Du danske mand! af al din magt

UPDATE pieces piece
SET piece.title = 'Du danske mand! af al din magt', piece.title_en = 'Du danske mand! af al din magt, CNW 288',
    piece.type = 'song', piece.opus_number = 'CNW 288',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 8660 AND piece.composer_id = 77
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- FS 78 En Snes danske Viser FS 78

UPDATE pieces piece
SET piece.title = 'En Snes danske Viser FS 78', piece.title_en = 'En Snes danske Viser, FS 78',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = 'FS', piece.catalogue_number = '78',
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 9272 AND piece.composer_id = 77
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'Nu er dagen fuld af sang, CNW 213', part.name_en = 'Nu er dagen fuld af sang, CNW 213',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 9272 AND p.composer_id = 77 AND part.part_key = 'musicbrainz:372e74e3-c619-4512-9fc0-eb22460d92e1' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:372e74e3-c619-4512-9fc0-eb22460d92e1', 1, NULL, 'Nu er dagen fuld af sang, CNW 213', 'Nu er dagen fuld af sang, CNW 213', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 9272 AND p.composer_id = 77
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:372e74e3-c619-4512-9fc0-eb22460d92e1'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'Se dig ud en sommerdag, CNW 221', part.name_en = 'Se dig ud en sommerdag, CNW 221',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 9272 AND p.composer_id = 77 AND part.part_key = 'musicbrainz:7d4dff73-6246-4597-8387-13b1598a6769' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:7d4dff73-6246-4597-8387-13b1598a6769', 2, NULL, 'Se dig ud en sommerdag, CNW 221', 'Se dig ud en sommerdag, CNW 221', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 9272 AND p.composer_id = 77
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:7d4dff73-6246-4597-8387-13b1598a6769'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = NULL,
    part.name_ko = 'Hun mig har glemt! min Sorg hun ej see!, CNW 218', part.name_en = 'Hun mig har glemt! min Sorg hun ej see!, CNW 218',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 9272 AND p.composer_id = 77 AND part.part_key = 'musicbrainz:8de85f0a-efe0-4c88-84f5-ab2380b3bf91' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:8de85f0a-efe0-4c88-84f5-ab2380b3bf91', 3, NULL, 'Hun mig har glemt! min Sorg hun ej see!, CNW 218', 'Hun mig har glemt! min Sorg hun ej see!, CNW 218', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 9272 AND p.composer_id = 77
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:8de85f0a-efe0-4c88-84f5-ab2380b3bf91'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = NULL,
    part.name_ko = 'Tidt er jeg glad, og vil dog gerne græde, CNW 216', part.name_en = 'Tidt er jeg glad, og vil dog gerne græde, CNW 216',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 9272 AND p.composer_id = 77 AND part.part_key = 'musicbrainz:c34ac1ea-fd42-4cd7-8604-9e672bbe7cf4' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:c34ac1ea-fd42-4cd7-8604-9e672bbe7cf4', 4, NULL, 'Tidt er jeg glad, og vil dog gerne græde, CNW 216', 'Tidt er jeg glad, og vil dog gerne græde, CNW 216', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 9272 AND p.composer_id = 77
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:c34ac1ea-fd42-4cd7-8604-9e672bbe7cf4'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 5, part.movement_number = NULL,
    part.name_ko = 'Hvor sødt i Sommer-Aftenstunden, CNW 215', part.name_en = 'Hvor sødt i Sommer-Aftenstunden, CNW 215',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 9272 AND p.composer_id = 77 AND part.part_key = 'musicbrainz:ec0c55a5-17d7-467d-a9a4-2cd0760c8c59' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:ec0c55a5-17d7-467d-a9a4-2cd0760c8c59', 5, NULL, 'Hvor sødt i Sommer-Aftenstunden, CNW 215', 'Hvor sødt i Sommer-Aftenstunden, CNW 215', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 9272 AND p.composer_id = 77
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:ec0c55a5-17d7-467d-a9a4-2cd0760c8c59'
);


-- None Fantasistykke for klarinet og klaver

UPDATE pieces piece
SET piece.title = 'Fantasistykke for klarinet og klaver', piece.title_en = 'Fantasistykke for klarinet og klaver',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 7487 AND piece.composer_id = 77
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- CNW 84 Fest-præludium ved Aarhundredskiftet

UPDATE pieces piece
SET piece.title = 'Fest-præludium ved Aarhundredskiftet', piece.title_en = 'Fest-præludium ved Aarhundredskiftet, CNW 84',
    piece.type = 'song', piece.opus_number = 'CNW 84',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 10728 AND piece.composer_id = 77
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- FS 119 플루트 협주곡

UPDATE pieces piece
SET piece.title = '플루트 협주곡', piece.title_en = 'Flute Concerto, FS 119',
    piece.type = 'album', piece.opus_number = 'FS 119',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 10112 AND piece.composer_id = 77
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'Allegro moderato', part.name_en = 'Flute Concerto, FS 119: I. Allegro moderato',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 10112 AND p.composer_id = 77 AND part.part_key = 'musicbrainz:7303f7bb-dfec-4846-817d-fa97658db4f5' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:7303f7bb-dfec-4846-817d-fa97658db4f5', 1, 'I', 'Allegro moderato', 'Flute Concerto, FS 119: I. Allegro moderato', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 10112 AND p.composer_id = 77
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:7303f7bb-dfec-4846-817d-fa97658db4f5'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'Allegretto', part.name_en = 'Flute Concerto, FS 119: II. Allegretto',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 10112 AND p.composer_id = 77 AND part.part_key = 'musicbrainz:09284e73-cf84-4565-b1a6-a0a4598c0dce' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:09284e73-cf84-4565-b1a6-a0a4598c0dce', 2, 'II', 'Allegretto', 'Flute Concerto, FS 119: II. Allegretto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 10112 AND p.composer_id = 77
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:09284e73-cf84-4565-b1a6-a0a4598c0dce'
);


-- CNW 255 가곡 <Frihed er det bedste guld>

UPDATE pieces piece
SET piece.title = '가곡 <Frihed er det bedste guld>', piece.title_en = 'Frihed er det bedste guld, CNW 255',
    piece.type = 'song', piece.opus_number = 'CNW 255',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 8442 AND piece.composer_id = 77
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- CNW 375 Frydeligt med jubelkor

UPDATE pieces piece
SET piece.title = 'Frydeligt med jubelkor', piece.title_en = 'Frydeligt med jubelkor, CNW 375',
    piece.type = 'song', piece.opus_number = 'CNW 375',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 8054 AND piece.composer_id = 77
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- Op. 42 칸타타 <Fynsk foraar> Op. 42

UPDATE pieces piece
SET piece.title = '칸타타 <Fynsk foraar> Op. 42', piece.title_en = 'Fynsk foraar, op. 42',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = 'Op.', piece.catalogue_number = '42',
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 7437 AND piece.composer_id = 77
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = '“Som en græsgrøn plet”', part.name_en = 'Fynsk foraar, op. 42: “Som en græsgrøn plet”',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 7437 AND p.composer_id = 77 AND part.part_key = 'musicbrainz:fc9833af-46dd-4482-a91b-10d976ac596d' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:fc9833af-46dd-4482-a91b-10d976ac596d', 1, NULL, '“Som en græsgrøn plet”', 'Fynsk foraar, op. 42: “Som en græsgrøn plet”', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 7437 AND p.composer_id = 77
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:fc9833af-46dd-4482-a91b-10d976ac596d'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = '“Å se, nu kommer våren”', part.name_en = 'Fynsk foraar, op. 42: “Å se, nu kommer våren”',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 7437 AND p.composer_id = 77 AND part.part_key = 'musicbrainz:fb875905-fd6a-4da6-84be-006f07c4cb4e' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:fb875905-fd6a-4da6-84be-006f07c4cb4e', 2, NULL, '“Å se, nu kommer våren”', 'Fynsk foraar, op. 42: “Å se, nu kommer våren”', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 7437 AND p.composer_id = 77
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:fb875905-fd6a-4da6-84be-006f07c4cb4e'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = NULL,
    part.name_ko = '“Den milde dag er lys og lang”', part.name_en = 'Fynsk foraar, op. 42: “Den milde dag er lys og lang”',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 7437 AND p.composer_id = 77 AND part.part_key = 'musicbrainz:abde5541-0a13-470d-943c-ac3a0a57a9b6' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:abde5541-0a13-470d-943c-ac3a0a57a9b6', 3, NULL, '“Den milde dag er lys og lang”', 'Fynsk foraar, op. 42: “Den milde dag er lys og lang”', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 7437 AND p.composer_id = 77
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:abde5541-0a13-470d-943c-ac3a0a57a9b6'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = NULL,
    part.name_ko = 'De gamle ungkarle: “Der har vi den aldrende sol igen”', part.name_en = 'Fynsk foraar, op. 42: De gamle ungkarle: “Der har vi den aldrende sol igen”',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 7437 AND p.composer_id = 77 AND part.part_key = 'musicbrainz:67215de9-4e50-48fe-a1b6-9f1601299743' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:67215de9-4e50-48fe-a1b6-9f1601299743', 4, NULL, 'De gamle ungkarle: “Der har vi den aldrende sol igen”', 'Fynsk foraar, op. 42: De gamle ungkarle: “Der har vi den aldrende sol igen”', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 7437 AND p.composer_id = 77
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:67215de9-4e50-48fe-a1b6-9f1601299743'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 5, part.movement_number = NULL,
    part.name_ko = 'Den blinde spillemand: “Nu kysser solen mit ojelag” Andantino con moto', part.name_en = 'Fynsk foraar, op. 42: Den blinde spillemand: “Nu kysser solen mit ojelag” Andantino con moto',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 7437 AND p.composer_id = 77 AND part.part_key = 'musicbrainz:f4a678ba-6403-4d5a-a503-b800b5d6cd62' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:f4a678ba-6403-4d5a-a503-b800b5d6cd62', 5, NULL, 'Den blinde spillemand: “Nu kysser solen mit ojelag” Andantino con moto', 'Fynsk foraar, op. 42: Den blinde spillemand: “Nu kysser solen mit ojelag” Andantino con moto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 7437 AND p.composer_id = 77
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:f4a678ba-6403-4d5a-a503-b800b5d6cd62'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 6, part.movement_number = NULL,
    part.name_ko = 'Den blinde spillemand: “Nu vil vi ud og lege” Allegro', part.name_en = 'Fynsk foraar, op. 42: Den blinde spillemand: “Nu vil vi ud og lege” Allegro',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 7437 AND p.composer_id = 77 AND part.part_key = 'musicbrainz:43b7829b-249c-4dd1-b701-91e483805f07' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:43b7829b-249c-4dd1-b701-91e483805f07', 6, NULL, 'Den blinde spillemand: “Nu vil vi ud og lege” Allegro', 'Fynsk foraar, op. 42: Den blinde spillemand: “Nu vil vi ud og lege” Allegro', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 7437 AND p.composer_id = 77
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:43b7829b-249c-4dd1-b701-91e483805f07'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 7, part.movement_number = NULL,
    part.name_ko = 'De gamle: “Så sætter vi piben i ovnens krog”', part.name_en = 'Fynsk foraar, op. 42: De gamle: “Så sætter vi piben i ovnens krog”',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 7437 AND p.composer_id = 77 AND part.part_key = 'musicbrainz:b46f0e8f-0bbb-4c55-acfb-75f53d2f9056' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:b46f0e8f-0bbb-4c55-acfb-75f53d2f9056', 7, NULL, 'De gamle: “Så sætter vi piben i ovnens krog”', 'Fynsk foraar, op. 42: De gamle: “Så sætter vi piben i ovnens krog”', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 7437 AND p.composer_id = 77
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:b46f0e8f-0bbb-4c55-acfb-75f53d2f9056'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 8, part.movement_number = NULL,
    part.name_ko = 'Dansevisen: “Kom her, fiol og klarinet”', part.name_en = 'Fynsk foraar, op. 42: Dansevisen: “Kom her, fiol og klarinet”',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 7437 AND p.composer_id = 77 AND part.part_key = 'musicbrainz:5e821f02-c1af-4e37-a64d-2b3c5e115608' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:5e821f02-c1af-4e37-a64d-2b3c5e115608', 8, NULL, 'Dansevisen: “Kom her, fiol og klarinet”', 'Fynsk foraar, op. 42: Dansevisen: “Kom her, fiol og klarinet”', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 7437 AND p.composer_id = 77
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:5e821f02-c1af-4e37-a64d-2b3c5e115608'
);


-- CNW 146 Havet omkring Danmark

UPDATE pieces piece
SET piece.title = 'Havet omkring Danmark', piece.title_en = 'Havet omkring Danmark, CNW 146',
    piece.type = 'song', piece.opus_number = 'CNW 146',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 8973 AND piece.composer_id = 77
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- Op. 17 Helios Overture

UPDATE pieces piece
SET piece.title = 'Helios Overture', piece.title_en = 'Helios Overture, op. 17',
    piece.type = 'song', piece.opus_number = 'Op. 17',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 11044 AND piece.composer_id = 77
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- CNW 314 가곡 <Hjemlige Jul, straaler Du nu!>

UPDATE pieces piece
SET piece.title = '가곡 <Hjemlige Jul, straaler Du nu!>', piece.title_en = 'Hjemlige Jul, straaler Du nu!, CNW 314',
    piece.type = 'song', piece.opus_number = 'CNW 314',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 9828 AND piece.composer_id = 77
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- CNW 205 가곡 <Hjemvee>

UPDATE pieces piece
SET piece.title = '가곡 <Hjemvee>', piece.title_en = 'Hjemvee, CNW 205',
    piece.type = 'song', piece.opus_number = 'CNW 205',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 7521 AND piece.composer_id = 77
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- Op. 11 Humoreske-bagateller

UPDATE pieces piece
SET piece.title = 'Humoreske-bagateller', piece.title_en = 'Humoreske-bagateller, op. 11',
    piece.type = 'album', piece.opus_number = 'Op. 11',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 7885 AND piece.composer_id = 77
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'Goddag', part.name_en = 'Humoreske-bagateller, op. 11: I. Goddag',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 7885 AND p.composer_id = 77 AND part.part_key = 'musicbrainz:2b91e6a8-ce64-432b-9bd2-9132017ac1eb' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:2b91e6a8-ce64-432b-9bd2-9132017ac1eb', 1, 'I', 'Goddag', 'Humoreske-bagateller, op. 11: I. Goddag', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 7885 AND p.composer_id = 77
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:2b91e6a8-ce64-432b-9bd2-9132017ac1eb'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'Snurretoppen', part.name_en = 'Humoreske-bagateller, op. 11: II. Snurretoppen',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 7885 AND p.composer_id = 77 AND part.part_key = 'musicbrainz:d9a45607-80d3-423b-a0bb-14eed6b0dc78' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:d9a45607-80d3-423b-a0bb-14eed6b0dc78', 2, 'II', 'Snurretoppen', 'Humoreske-bagateller, op. 11: II. Snurretoppen', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 7885 AND p.composer_id = 77
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:d9a45607-80d3-423b-a0bb-14eed6b0dc78'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = 'En lille langsom vals', part.name_en = 'Humoreske-bagateller, op. 11: III. En lille langsom vals',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 7885 AND p.composer_id = 77 AND part.part_key = 'musicbrainz:82e7d6a4-af59-4b95-8d54-26c197b482d6' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:82e7d6a4-af59-4b95-8d54-26c197b482d6', 3, 'III', 'En lille langsom vals', 'Humoreske-bagateller, op. 11: III. En lille langsom vals', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 7885 AND p.composer_id = 77
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:82e7d6a4-af59-4b95-8d54-26c197b482d6'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = 'IV',
    part.name_ko = 'Prældemannen', part.name_en = 'Humoreske-bagateller, op. 11: IV. Prældemannen',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 7885 AND p.composer_id = 77 AND part.part_key = 'musicbrainz:87bb2272-84ac-4ea0-8021-4b32e7f411b3' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:87bb2272-84ac-4ea0-8021-4b32e7f411b3', 4, 'IV', 'Prældemannen', 'Humoreske-bagateller, op. 11: IV. Prældemannen', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 7885 AND p.composer_id = 77
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:87bb2272-84ac-4ea0-8021-4b32e7f411b3'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 5, part.movement_number = 'V',
    part.name_ko = 'Dukkemarch', part.name_en = 'Humoreske-bagateller, op. 11: V. Dukkemarch',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 7885 AND p.composer_id = 77 AND part.part_key = 'musicbrainz:9c26665d-d499-446a-9db6-bcc1b895263d' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:9c26665d-d499-446a-9db6-bcc1b895263d', 5, 'V', 'Dukkemarch', 'Humoreske-bagateller, op. 11: V. Dukkemarch', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 7885 AND p.composer_id = 77
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:9c26665d-d499-446a-9db6-bcc1b895263d'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 6, part.movement_number = 'VI',
    part.name_ko = 'Spilleværket', part.name_en = 'Humoreske-bagateller, op. 11: VI. Spilleværket',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 7885 AND p.composer_id = 77 AND part.part_key = 'musicbrainz:b5d42eb3-1ce7-4436-b65b-882706d9c5ef' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:b5d42eb3-1ce7-4436-b65b-882706d9c5ef', 6, 'VI', 'Spilleværket', 'Humoreske-bagateller, op. 11: VI. Spilleværket', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 7885 AND p.composer_id = 77
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:b5d42eb3-1ce7-4436-b65b-882706d9c5ef'
);


-- Op. 12 Hymnus amoris

UPDATE pieces piece
SET piece.title = 'Hymnus amoris', piece.title_en = 'Hymnus amoris, op. 12',
    piece.type = 'album', piece.opus_number = 'Op. 12',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 7838 AND piece.composer_id = 77
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'Barndom', part.name_en = 'Hymnus amoris, op. 12: I. Barndom',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 7838 AND p.composer_id = 77 AND part.part_key = 'musicbrainz:45c9f759-a06c-40ea-b290-4f4a1ac0b0d7' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:45c9f759-a06c-40ea-b290-4f4a1ac0b0d7', 1, 'I', 'Barndom', 'Hymnus amoris, op. 12: I. Barndom', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 7838 AND p.composer_id = 77
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:45c9f759-a06c-40ea-b290-4f4a1ac0b0d7'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'Ungdom', part.name_en = 'Hymnus amoris, op. 12: II. Ungdom',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 7838 AND p.composer_id = 77 AND part.part_key = 'musicbrainz:09f4a640-a89a-4591-9f25-50c87054eadf' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:09f4a640-a89a-4591-9f25-50c87054eadf', 2, 'II', 'Ungdom', 'Hymnus amoris, op. 12: II. Ungdom', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 7838 AND p.composer_id = 77
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:09f4a640-a89a-4591-9f25-50c87054eadf'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = 'Mandom', part.name_en = 'Hymnus amoris, op. 12: III. Mandom',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 7838 AND p.composer_id = 77 AND part.part_key = 'musicbrainz:1f591ab1-abe2-42b8-9a52-670654865985' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:1f591ab1-abe2-42b8-9a52-670654865985', 3, 'III', 'Mandom', 'Hymnus amoris, op. 12: III. Mandom', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 7838 AND p.composer_id = 77
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:1f591ab1-abe2-42b8-9a52-670654865985'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = 'IV',
    part.name_ko = 'Alderdom', part.name_en = 'Hymnus amoris, op. 12: IV. Alderdom',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 7838 AND p.composer_id = 77 AND part.part_key = 'musicbrainz:d611f3c6-cc85-454a-8556-05f20adb863f' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:d611f3c6-cc85-454a-8556-05f20adb863f', 4, 'IV', 'Alderdom', 'Hymnus amoris, op. 12: IV. Alderdom', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 7838 AND p.composer_id = 77
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:d611f3c6-cc85-454a-8556-05f20adb863f'
);


-- CNW 129 가곡 <I solen går jeg bag min plov>

UPDATE pieces piece
SET piece.title = '가곡 <I solen går jeg bag min plov>', piece.title_en = 'I solen går jeg bag min plov, CNW 129',
    piece.type = 'song', piece.opus_number = 'CNW 129',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 8603 AND piece.composer_id = 77
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- Op. 4 No. 4 가곡 <Irmelin Rose>

UPDATE pieces piece
SET piece.title = '가곡 <Irmelin Rose>', piece.title_en = 'Irmelin Rose op. 4 nr. 4',
    piece.type = 'song', piece.opus_number = 'Op. 4 No. 4',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 9206 AND piece.composer_id = 77
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None 가곡 <Jeg bærer med smil min byrde>

UPDATE pieces piece
SET piece.title = '가곡 <Jeg bærer med smil min byrde>', piece.title_en = 'Jeg bærer med smil min byrde',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 7747 AND piece.composer_id = 77
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None 가곡 <Jeg gik i marken og vogtede får>

UPDATE pieces piece
SET piece.title = '가곡 <Jeg gik i marken og vogtede får>', piece.title_en = 'Jeg gik i marken og vogtede får',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 10857 AND piece.composer_id = 77
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None 가곡 <Jeg lægger mig så trygt til ro>

UPDATE pieces piece
SET piece.title = '가곡 <Jeg lægger mig så trygt til ro>', piece.title_en = 'Jeg lægger mig så trygt til ro',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 10107 AND piece.composer_id = 77
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- FS 31 Kantate til Studentersamfundet

UPDATE pieces piece
SET piece.title = 'Kantate til Studentersamfundet', piece.title_en = 'Kantate til Studentersamfundet, FS 31',
    piece.type = 'song', piece.opus_number = 'FS 31',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 7518 AND piece.composer_id = 77
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- Op. 53 Klavermusik for små og store Op. 53

UPDATE pieces piece
SET piece.title = 'Klavermusik for små og store Op. 53', piece.title_en = 'Klavermusik for små og store, FS 148, op. 53',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = 'Op.', piece.catalogue_number = '53',
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 10687 AND piece.composer_id = 77
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'Allegretto', part.name_en = 'Klavermusik for små og store, FS 148, op. 53: No. 1. Allegretto',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 10687 AND p.composer_id = 77 AND part.part_key = 'musicbrainz:587d35bb-31ac-4b53-8e90-412f11e3c916' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:587d35bb-31ac-4b53-8e90-412f11e3c916', 1, NULL, 'Allegretto', 'Klavermusik for små og store, FS 148, op. 53: No. 1. Allegretto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 10687 AND p.composer_id = 77
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:587d35bb-31ac-4b53-8e90-412f11e3c916'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'Andantino quasi allegretto', part.name_en = 'Klavermusik for små og store, FS 148, op. 53: No. 2. Andantino quasi allegretto',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 10687 AND p.composer_id = 77 AND part.part_key = 'musicbrainz:a743f179-3c18-46b0-977d-fd5dd158ace3' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:a743f179-3c18-46b0-977d-fd5dd158ace3', 2, NULL, 'Andantino quasi allegretto', 'Klavermusik for små og store, FS 148, op. 53: No. 2. Andantino quasi allegretto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 10687 AND p.composer_id = 77
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:a743f179-3c18-46b0-977d-fd5dd158ace3'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = NULL,
    part.name_ko = 'Allegro scherzoso', part.name_en = 'Klavermusik for små og store, FS 148, op. 53: No. 3a. Allegro scherzoso',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 10687 AND p.composer_id = 77 AND part.part_key = 'musicbrainz:9f310d40-b5f3-4d56-9669-bacdc6b64292' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:9f310d40-b5f3-4d56-9669-bacdc6b64292', 3, NULL, 'Allegro scherzoso', 'Klavermusik for små og store, FS 148, op. 53: No. 3a. Allegro scherzoso', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 10687 AND p.composer_id = 77
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:9f310d40-b5f3-4d56-9669-bacdc6b64292'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = NULL,
    part.name_ko = 'Grazioso', part.name_en = 'Klavermusik for små og store, FS 148, op. 53: No. 3b. Grazioso',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 10687 AND p.composer_id = 77 AND part.part_key = 'musicbrainz:b96457e9-03b0-488e-8b9b-780afa0134a8' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:b96457e9-03b0-488e-8b9b-780afa0134a8', 4, NULL, 'Grazioso', 'Klavermusik for små og store, FS 148, op. 53: No. 3b. Grazioso', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 10687 AND p.composer_id = 77
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:b96457e9-03b0-488e-8b9b-780afa0134a8'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 5, part.movement_number = NULL,
    part.name_ko = 'Andantino', part.name_en = 'Klavermusik for små og store, FS 148, op. 53: No. 4. Andantino',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 10687 AND p.composer_id = 77 AND part.part_key = 'musicbrainz:91da6d16-4b11-4ff4-9c5f-52f6281a8fc8' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:91da6d16-4b11-4ff4-9c5f-52f6281a8fc8', 5, NULL, 'Andantino', 'Klavermusik for små og store, FS 148, op. 53: No. 4. Andantino', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 10687 AND p.composer_id = 77
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:91da6d16-4b11-4ff4-9c5f-52f6281a8fc8'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 6, part.movement_number = NULL,
    part.name_ko = 'Allegro giocoso', part.name_en = 'Klavermusik for små og store, FS 148, op. 53: No. 5. Allegro giocoso',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 10687 AND p.composer_id = 77 AND part.part_key = 'musicbrainz:4db0a45f-b3a1-4346-8c74-ffe86562150f' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:4db0a45f-b3a1-4346-8c74-ffe86562150f', 6, NULL, 'Allegro giocoso', 'Klavermusik for små og store, FS 148, op. 53: No. 5. Allegro giocoso', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 10687 AND p.composer_id = 77
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:4db0a45f-b3a1-4346-8c74-ffe86562150f'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 7, part.movement_number = NULL,
    part.name_ko = 'Poco lamentoso', part.name_en = 'Klavermusik for små og store, FS 148, op. 53: No. 6. Poco lamentoso',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 10687 AND p.composer_id = 77 AND part.part_key = 'musicbrainz:f010b925-b837-4cf2-a43d-13e3443af402' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:f010b925-b837-4cf2-a43d-13e3443af402', 7, NULL, 'Poco lamentoso', 'Klavermusik for små og store, FS 148, op. 53: No. 6. Poco lamentoso', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 10687 AND p.composer_id = 77
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:f010b925-b837-4cf2-a43d-13e3443af402'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 8, part.movement_number = NULL,
    part.name_ko = 'Marziale', part.name_en = 'Klavermusik for små og store, FS 148, op. 53: No. 7. Marziale',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 10687 AND p.composer_id = 77 AND part.part_key = 'musicbrainz:820a2279-897e-4a2c-99bc-d099ebe13b47' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:820a2279-897e-4a2c-99bc-d099ebe13b47', 8, NULL, 'Marziale', 'Klavermusik for små og store, FS 148, op. 53: No. 7. Marziale', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 10687 AND p.composer_id = 77
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:820a2279-897e-4a2c-99bc-d099ebe13b47'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 9, part.movement_number = NULL,
    part.name_ko = 'Cantabile', part.name_en = 'Klavermusik for små og store, FS 148, op. 53: No. 8. Cantabile',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 10687 AND p.composer_id = 77 AND part.part_key = 'musicbrainz:5280455a-6b40-40af-ab64-3e499cde5b8d' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:5280455a-6b40-40af-ab64-3e499cde5b8d', 9, NULL, 'Cantabile', 'Klavermusik for små og store, FS 148, op. 53: No. 8. Cantabile', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 10687 AND p.composer_id = 77
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:5280455a-6b40-40af-ab64-3e499cde5b8d'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 10, part.movement_number = NULL,
    part.name_ko = 'Allegretto civettuolo', part.name_en = 'Klavermusik for små og store, FS 148, op. 53: No. 9. Allegretto civettuolo',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 10687 AND p.composer_id = 77 AND part.part_key = 'musicbrainz:2ba135ce-aea8-4eca-b251-cab53931c3ad' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:2ba135ce-aea8-4eca-b251-cab53931c3ad', 10, NULL, 'Allegretto civettuolo', 'Klavermusik for små og store, FS 148, op. 53: No. 9. Allegretto civettuolo', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 10687 AND p.composer_id = 77
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:2ba135ce-aea8-4eca-b251-cab53931c3ad'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 11, part.movement_number = NULL,
    part.name_ko = 'Lugubre', part.name_en = 'Klavermusik for små og store, FS 148, op. 53: No. 10. Lugubre',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 10687 AND p.composer_id = 77 AND part.part_key = 'musicbrainz:367c5062-c55a-4a66-9553-4b3cac32261c' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:367c5062-c55a-4a66-9553-4b3cac32261c', 11, NULL, 'Lugubre', 'Klavermusik for små og store, FS 148, op. 53: No. 10. Lugubre', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 10687 AND p.composer_id = 77
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:367c5062-c55a-4a66-9553-4b3cac32261c'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 12, part.movement_number = NULL,
    part.name_ko = 'Andantino poco tiepido', part.name_en = 'Klavermusik for små og store, FS 148, op. 53: No. 11. Andantino poco tiepido',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 10687 AND p.composer_id = 77 AND part.part_key = 'musicbrainz:3d76e4eb-c893-41c9-a641-9c98c0e1e371' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:3d76e4eb-c893-41c9-a641-9c98c0e1e371', 12, NULL, 'Andantino poco tiepido', 'Klavermusik for små og store, FS 148, op. 53: No. 11. Andantino poco tiepido', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 10687 AND p.composer_id = 77
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:3d76e4eb-c893-41c9-a641-9c98c0e1e371'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 13, part.movement_number = NULL,
    part.name_ko = 'Adagio dramatico', part.name_en = 'Klavermusik for små og store, FS 148, op. 53: No. 12. Adagio dramatico',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 10687 AND p.composer_id = 77 AND part.part_key = 'musicbrainz:1646ccff-e6d6-4e35-8edf-8eb8e9736ad4' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:1646ccff-e6d6-4e35-8edf-8eb8e9736ad4', 13, NULL, 'Adagio dramatico', 'Klavermusik for små og store, FS 148, op. 53: No. 12. Adagio dramatico', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 10687 AND p.composer_id = 77
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:1646ccff-e6d6-4e35-8edf-8eb8e9736ad4'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 14, part.movement_number = NULL,
    part.name_ko = 'Andantino carino', part.name_en = 'Klavermusik for små og store, FS 148, op. 53: No. 13. Andantino carino',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 10687 AND p.composer_id = 77 AND part.part_key = 'musicbrainz:c8ab9dbf-88dd-4fcd-b7da-72c326af0926' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:c8ab9dbf-88dd-4fcd-b7da-72c326af0926', 14, NULL, 'Andantino carino', 'Klavermusik for små og store, FS 148, op. 53: No. 13. Andantino carino', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 10687 AND p.composer_id = 77
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:c8ab9dbf-88dd-4fcd-b7da-72c326af0926'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 15, part.movement_number = NULL,
    part.name_ko = 'Capriccioso', part.name_en = 'Klavermusik for små og store, FS 148, op. 53: No. 14. Capriccioso',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 10687 AND p.composer_id = 77 AND part.part_key = 'musicbrainz:b442ce40-9ee8-4268-83b3-eabd3d75fea1' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:b442ce40-9ee8-4268-83b3-eabd3d75fea1', 15, NULL, 'Capriccioso', 'Klavermusik for små og store, FS 148, op. 53: No. 14. Capriccioso', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 10687 AND p.composer_id = 77
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:b442ce40-9ee8-4268-83b3-eabd3d75fea1'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 16, part.movement_number = NULL,
    part.name_ko = 'Adagio espressivo', part.name_en = 'Klavermusik for små og store, FS 148, op. 53: No. 15. Adagio espressivo',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 10687 AND p.composer_id = 77 AND part.part_key = 'musicbrainz:296cd150-14d8-482d-aed8-88d00d7951be' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:296cd150-14d8-482d-aed8-88d00d7951be', 16, NULL, 'Adagio espressivo', 'Klavermusik for små og store, FS 148, op. 53: No. 15. Adagio espressivo', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 10687 AND p.composer_id = 77
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:296cd150-14d8-482d-aed8-88d00d7951be'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 17, part.movement_number = NULL,
    part.name_ko = 'Alla contadino', part.name_en = 'Klavermusik for små og store, FS 148, op. 53: No. 16. Alla contadino',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 10687 AND p.composer_id = 77 AND part.part_key = 'musicbrainz:7488eea3-33e9-4d81-a6bd-b55bef1e11ec' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:7488eea3-33e9-4d81-a6bd-b55bef1e11ec', 17, NULL, 'Alla contadino', 'Klavermusik for små og store, FS 148, op. 53: No. 16. Alla contadino', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 10687 AND p.composer_id = 77
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:7488eea3-33e9-4d81-a6bd-b55bef1e11ec'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 18, part.movement_number = NULL,
    part.name_ko = 'Largo con fantasia', part.name_en = 'Klavermusik for små og store, FS 148, op. 53: No. 17. Largo con fantasia',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 10687 AND p.composer_id = 77 AND part.part_key = 'musicbrainz:f8170d7d-ed7a-4a25-a80e-215c3463b5a2' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:f8170d7d-ed7a-4a25-a80e-215c3463b5a2', 18, NULL, 'Largo con fantasia', 'Klavermusik for små og store, FS 148, op. 53: No. 17. Largo con fantasia', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 10687 AND p.composer_id = 77
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:f8170d7d-ed7a-4a25-a80e-215c3463b5a2'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 19, part.movement_number = NULL,
    part.name_ko = 'Preludio', part.name_en = 'Klavermusik for små og store, FS 148, op. 53: No. 18. Preludio',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 10687 AND p.composer_id = 77 AND part.part_key = 'musicbrainz:e0e70066-9bc1-47c3-b1b7-65d29dee537f' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:e0e70066-9bc1-47c3-b1b7-65d29dee537f', 19, NULL, 'Preludio', 'Klavermusik for små og store, FS 148, op. 53: No. 18. Preludio', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 10687 AND p.composer_id = 77
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:e0e70066-9bc1-47c3-b1b7-65d29dee537f'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 20, part.movement_number = NULL,
    part.name_ko = '"Alla Bach"', part.name_en = 'Klavermusik for små og store, FS 148, op. 53: No. 19. "Alla Bach"',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 10687 AND p.composer_id = 77 AND part.part_key = 'musicbrainz:9b5536d1-286d-497a-b0ab-6dc2c2d143b4' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:9b5536d1-286d-497a-b0ab-6dc2c2d143b4', 20, NULL, '"Alla Bach"', 'Klavermusik for små og store, FS 148, op. 53: No. 19. "Alla Bach"', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 10687 AND p.composer_id = 77
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:9b5536d1-286d-497a-b0ab-6dc2c2d143b4'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 21, part.movement_number = NULL,
    part.name_ko = 'Adagio', part.name_en = 'Klavermusik for små og store, FS 148, op. 53: No. 20. Adagio',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 10687 AND p.composer_id = 77 AND part.part_key = 'musicbrainz:554e42bf-2d35-49a3-adfb-8438b99a549e' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:554e42bf-2d35-49a3-adfb-8438b99a549e', 21, NULL, 'Adagio', 'Klavermusik for små og store, FS 148, op. 53: No. 20. Adagio', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 10687 AND p.composer_id = 77
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:554e42bf-2d35-49a3-adfb-8438b99a549e'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 22, part.movement_number = NULL,
    part.name_ko = 'Marcia di goffo', part.name_en = 'Klavermusik for små og store, FS 148, op. 53: No. 21. Marcia di goffo',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 10687 AND p.composer_id = 77 AND part.part_key = 'musicbrainz:92350ea4-56cb-4de0-9985-fd1ff5a38fa1' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:92350ea4-56cb-4de0-9985-fd1ff5a38fa1', 22, NULL, 'Marcia di goffo', 'Klavermusik for små og store, FS 148, op. 53: No. 21. Marcia di goffo', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 10687 AND p.composer_id = 77
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:92350ea4-56cb-4de0-9985-fd1ff5a38fa1'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 23, part.movement_number = NULL,
    part.name_ko = 'Allegretto pastorale', part.name_en = 'Klavermusik for små og store, FS 148, op. 53: No. 22. Allegretto pastorale',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 10687 AND p.composer_id = 77 AND part.part_key = 'musicbrainz:4323f1d8-fa31-444f-95e4-65d2dd4c9659' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:4323f1d8-fa31-444f-95e4-65d2dd4c9659', 23, NULL, 'Allegretto pastorale', 'Klavermusik for små og store, FS 148, op. 53: No. 22. Allegretto pastorale', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 10687 AND p.composer_id = 77
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:4323f1d8-fa31-444f-95e4-65d2dd4c9659'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 24, part.movement_number = NULL,
    part.name_ko = 'Étude: Allegro', part.name_en = 'Klavermusik for små og store, FS 148, op. 53: No. 23. Étude: Allegro',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 10687 AND p.composer_id = 77 AND part.part_key = 'musicbrainz:9ba6b5d1-c146-44e7-acd1-97304d5d8062' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:9ba6b5d1-c146-44e7-acd1-97304d5d8062', 24, NULL, 'Étude: Allegro', 'Klavermusik for små og store, FS 148, op. 53: No. 23. Étude: Allegro', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 10687 AND p.composer_id = 77
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:9ba6b5d1-c146-44e7-acd1-97304d5d8062'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 25, part.movement_number = NULL,
    part.name_ko = 'Molto adagio - Allegretto commodo', part.name_en = 'Klavermusik for små og store, FS 148, op. 53: No. 24. Molto adagio - Allegretto commodo',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 10687 AND p.composer_id = 77 AND part.part_key = 'musicbrainz:f0c840ba-9357-4592-82a6-b91cfd27e156' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:f0c840ba-9357-4592-82a6-b91cfd27e156', 25, NULL, 'Molto adagio - Allegretto commodo', 'Klavermusik for små og store, FS 148, op. 53: No. 24. Molto adagio - Allegretto commodo', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 10687 AND p.composer_id = 77
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:f0c840ba-9357-4592-82a6-b91cfd27e156'
);


-- FS 159 Klaverstykke in C major

UPDATE pieces piece
SET piece.title = 'Klaverstykke in C major', piece.title_en = 'Klaverstykke in C major, FS 159',
    piece.type = 'song', piece.opus_number = 'FS 159',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 8104 AND piece.composer_id = 77
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- Op. 43 Kvintet for fløjte, obo, klarinet, horn og fagot

UPDATE pieces piece
SET piece.title = 'Kvintet for fløjte, obo, klarinet, horn og fagot', piece.title_en = 'Kvintet for fløjte, obo, klarinet, horn og fagot, op. 43',
    piece.type = 'album', piece.opus_number = 'Op. 43',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 7527 AND piece.composer_id = 77
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'Allegro ben moderato', part.name_en = 'Kvintet for fløjte, obo, klarinet, horn og fagot, op. 43: I. Allegro ben moderato',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 7527 AND p.composer_id = 77 AND part.part_key = 'musicbrainz:a08f4c22-f499-422e-8469-f402704adfc4' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:a08f4c22-f499-422e-8469-f402704adfc4', 1, 'I', 'Allegro ben moderato', 'Kvintet for fløjte, obo, klarinet, horn og fagot, op. 43: I. Allegro ben moderato', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 7527 AND p.composer_id = 77
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:a08f4c22-f499-422e-8469-f402704adfc4'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'Menuet', part.name_en = 'Kvintet for fløjte, obo, klarinet, horn og fagot, op. 43: II. Menuet',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 7527 AND p.composer_id = 77 AND part.part_key = 'musicbrainz:50dc5575-17c9-4dc2-9a18-045c763a167e' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:50dc5575-17c9-4dc2-9a18-045c763a167e', 2, 'II', 'Menuet', 'Kvintet for fløjte, obo, klarinet, horn og fagot, op. 43: II. Menuet', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 7527 AND p.composer_id = 77
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:50dc5575-17c9-4dc2-9a18-045c763a167e'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = 'Praeludium - Tema con variazioni - Andante festivo', part.name_en = 'Kvintet for fløjte, obo, klarinet, horn og fagot, op. 43: III. Praeludium - Tema con variazioni - Andante festivo',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 7527 AND p.composer_id = 77 AND part.part_key = 'musicbrainz:3d78eca2-0d70-4caa-8291-75d178cff64e' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:3d78eca2-0d70-4caa-8291-75d178cff64e', 3, 'III', 'Praeludium - Tema con variazioni - Andante festivo', 'Kvintet for fløjte, obo, klarinet, horn og fagot, op. 43: III. Praeludium - Tema con variazioni - Andante festivo', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 7527 AND p.composer_id = 77
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:3d78eca2-0d70-4caa-8291-75d178cff64e'
);


-- Op. 1 Lille suite for strygere

UPDATE pieces piece
SET piece.title = 'Lille suite for strygere', piece.title_en = 'Lille suite for strygere, op. 1',
    piece.type = 'album', piece.opus_number = 'Op. 1',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 7458 AND piece.composer_id = 77
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'Præludium', part.name_en = 'Lille suite for strygere, op. 1: I. Præludium',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 7458 AND p.composer_id = 77 AND part.part_key = 'musicbrainz:583ddb36-396c-3262-97a6-9315e9739fb1' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:583ddb36-396c-3262-97a6-9315e9739fb1', 1, 'I', 'Præludium', 'Lille suite for strygere, op. 1: I. Præludium', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 7458 AND p.composer_id = 77
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:583ddb36-396c-3262-97a6-9315e9739fb1'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'Intermezzo', part.name_en = 'Lille suite for strygere, op. 1: II. Intermezzo',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 7458 AND p.composer_id = 77 AND part.part_key = 'musicbrainz:1cb8a051-53d2-3247-a528-62e1f5232d2a' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:1cb8a051-53d2-3247-a528-62e1f5232d2a', 2, 'II', 'Intermezzo', 'Lille suite for strygere, op. 1: II. Intermezzo', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 7458 AND p.composer_id = 77
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:1cb8a051-53d2-3247-a528-62e1f5232d2a'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = 'Finale', part.name_en = 'Lille suite for strygere, op. 1: III. Finale',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 7458 AND p.composer_id = 77 AND part.part_key = 'musicbrainz:3191d718-5059-3165-8d0c-e4b6adbd8a3e' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:3191d718-5059-3165-8d0c-e4b6adbd8a3e', 3, 'III', 'Finale', 'Lille suite for strygere, op. 1: III. Finale', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 7458 AND p.composer_id = 77
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:3191d718-5059-3165-8d0c-e4b6adbd8a3e'
);


-- FS 39 오페라 <Maskarade> FS 39

UPDATE pieces piece
SET piece.title = '오페라 <Maskarade> FS 39', piece.title_en = 'Maskarade, FS 39',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = 'FS', piece.catalogue_number = '39',
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 8102 AND piece.composer_id = 77
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'Overture', part.name_en = 'Maskarade, FS 39: Overture',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 8102 AND p.composer_id = 77 AND part.part_key = 'musicbrainz:d76aa9ac-e6e4-49c0-a7f1-6e00bfc78e41' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:d76aa9ac-e6e4-49c0-a7f1-6e00bfc78e41', 1, NULL, 'Overture', 'Maskarade, FS 39: Overture', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 8102 AND p.composer_id = 77
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:d76aa9ac-e6e4-49c0-a7f1-6e00bfc78e41'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'Act I', part.name_en = 'Maskarade, FS 39: Act I',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 8102 AND p.composer_id = 77 AND part.part_key = 'musicbrainz:b1e8b999-5bc4-490e-b133-3af766c0b224' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:b1e8b999-5bc4-490e-b133-3af766c0b224', 2, NULL, 'Act I', 'Maskarade, FS 39: Act I', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 8102 AND p.composer_id = 77
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:b1e8b999-5bc4-490e-b133-3af766c0b224'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:b1e8b999-5bc4-490e-b133-3af766c0b224'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'Act I "Det Satans Spind!"', part.name_en = 'Maskarade, FS 39: Act I "Det Satans Spind!"',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 8102 AND p.composer_id = 77 AND part.part_key = 'musicbrainz:015b01b3-9c01-4a7f-b8fc-fc51b30dff41' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:015b01b3-9c01-4a7f-b8fc-fc51b30dff41', 1, NULL, 'Act I "Det Satans Spind!"', 'Maskarade, FS 39: Act I "Det Satans Spind!"', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:b1e8b999-5bc4-490e-b133-3af766c0b224'
WHERE p.id = 8102 AND p.composer_id = 77
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:015b01b3-9c01-4a7f-b8fc-fc51b30dff41'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:b1e8b999-5bc4-490e-b133-3af766c0b224'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'Act I "Hr. Leonard, Herrens tilkommende Svoger"', part.name_en = 'Maskarade, FS 39: Act I "Hr. Leonard, Herrens tilkommende Svoger"',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 8102 AND p.composer_id = 77 AND part.part_key = 'musicbrainz:67b1325c-1db6-4a82-82a3-633d94cec5b6' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:67b1325c-1db6-4a82-82a3-633d94cec5b6', 2, NULL, 'Act I "Hr. Leonard, Herrens tilkommende Svoger"', 'Maskarade, FS 39: Act I "Hr. Leonard, Herrens tilkommende Svoger"', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:b1e8b999-5bc4-490e-b133-3af766c0b224'
WHERE p.id = 8102 AND p.composer_id = 77
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:67b1325c-1db6-4a82-82a3-633d94cec5b6'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:b1e8b999-5bc4-490e-b133-3af766c0b224'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = NULL,
    part.name_ko = 'Act I "Er der nogen hjemme?"', part.name_en = 'Maskarade, FS 39: Act I "Er der nogen hjemme?"',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 8102 AND p.composer_id = 77 AND part.part_key = 'musicbrainz:9187c475-1ae7-481e-920e-6ed2f37f3346' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:9187c475-1ae7-481e-920e-6ed2f37f3346', 3, NULL, 'Act I "Er der nogen hjemme?"', 'Maskarade, FS 39: Act I "Er der nogen hjemme?"', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:b1e8b999-5bc4-490e-b133-3af766c0b224'
WHERE p.id = 8102 AND p.composer_id = 77
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:9187c475-1ae7-481e-920e-6ed2f37f3346'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:b1e8b999-5bc4-490e-b133-3af766c0b224'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = NULL,
    part.name_ko = 'Act I "Herre! I staar saa stum!"', part.name_en = 'Maskarade, FS 39: Act I "Herre! I staar saa stum!"',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 8102 AND p.composer_id = 77 AND part.part_key = 'musicbrainz:977fd53d-d322-49fa-89c6-bb5debccf662' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:977fd53d-d322-49fa-89c6-bb5debccf662', 4, NULL, 'Act I "Herre! I staar saa stum!"', 'Maskarade, FS 39: Act I "Herre! I staar saa stum!"', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:b1e8b999-5bc4-490e-b133-3af766c0b224'
WHERE p.id = 8102 AND p.composer_id = 77
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:977fd53d-d322-49fa-89c6-bb5debccf662'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:b1e8b999-5bc4-490e-b133-3af766c0b224'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 5, part.movement_number = NULL,
    part.name_ko = 'Act I "Her er jeg, Husbond!"', part.name_en = 'Maskarade, FS 39: Act I "Her er jeg, Husbond!"',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 8102 AND p.composer_id = 77 AND part.part_key = 'musicbrainz:b0797845-ab2e-4bda-ae42-14133bdb4297' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:b0797845-ab2e-4bda-ae42-14133bdb4297', 5, NULL, 'Act I "Her er jeg, Husbond!"', 'Maskarade, FS 39: Act I "Her er jeg, Husbond!"', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:b1e8b999-5bc4-490e-b133-3af766c0b224'
WHERE p.id = 8102 AND p.composer_id = 77
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:b0797845-ab2e-4bda-ae42-14133bdb4297'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:b1e8b999-5bc4-490e-b133-3af766c0b224'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 6, part.movement_number = NULL,
    part.name_ko = 'Act I "I dette Land hvor Solskin er saa kummerligt beskaaret"', part.name_en = 'Maskarade, FS 39: Act I "I dette Land hvor Solskin er saa kummerligt beskaaret"',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 8102 AND p.composer_id = 77 AND part.part_key = 'musicbrainz:c3f74b67-066c-4d65-9187-32b8b7d70625' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:c3f74b67-066c-4d65-9187-32b8b7d70625', 6, NULL, 'Act I "I dette Land hvor Solskin er saa kummerligt beskaaret"', 'Maskarade, FS 39: Act I "I dette Land hvor Solskin er saa kummerligt beskaaret"', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:b1e8b999-5bc4-490e-b133-3af766c0b224'
WHERE p.id = 8102 AND p.composer_id = 77
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:c3f74b67-066c-4d65-9187-32b8b7d70625'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:b1e8b999-5bc4-490e-b133-3af766c0b224'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 7, part.movement_number = NULL,
    part.name_ko = 'Act I "Kan I være rolige?"', part.name_en = 'Maskarade, FS 39: Act I "Kan I være rolige?"',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 8102 AND p.composer_id = 77 AND part.part_key = 'musicbrainz:d306b098-396b-4f10-8dd1-32b226448904' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:d306b098-396b-4f10-8dd1-32b226448904', 7, NULL, 'Act I "Kan I være rolige?"', 'Maskarade, FS 39: Act I "Kan I være rolige?"', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:b1e8b999-5bc4-490e-b133-3af766c0b224'
WHERE p.id = 8102 AND p.composer_id = 77
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:d306b098-396b-4f10-8dd1-32b226448904'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:b1e8b999-5bc4-490e-b133-3af766c0b224'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 8, part.movement_number = NULL,
    part.name_ko = 'Act I "Det skal aldrig ske!"', part.name_en = 'Maskarade, FS 39: Act I "Det skal aldrig ske!"',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 8102 AND p.composer_id = 77 AND part.part_key = 'musicbrainz:d94cdfab-a40f-4d7d-8b2d-73c626069cc1' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:d94cdfab-a40f-4d7d-8b2d-73c626069cc1', 8, NULL, 'Act I "Det skal aldrig ske!"', 'Maskarade, FS 39: Act I "Det skal aldrig ske!"', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:b1e8b999-5bc4-490e-b133-3af766c0b224'
WHERE p.id = 8102 AND p.composer_id = 77
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:d94cdfab-a40f-4d7d-8b2d-73c626069cc1'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:b1e8b999-5bc4-490e-b133-3af766c0b224'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 9, part.movement_number = NULL,
    part.name_ko = 'Act I "Først kommer fæl og fus"', part.name_en = 'Maskarade, FS 39: Act I "Først kommer fæl og fus"',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 8102 AND p.composer_id = 77 AND part.part_key = 'musicbrainz:ddb4ef30-911d-4197-809f-57ab00644cf8' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:ddb4ef30-911d-4197-809f-57ab00644cf8', 9, NULL, 'Act I "Først kommer fæl og fus"', 'Maskarade, FS 39: Act I "Først kommer fæl og fus"', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:b1e8b999-5bc4-490e-b133-3af766c0b224'
WHERE p.id = 8102 AND p.composer_id = 77
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:ddb4ef30-911d-4197-809f-57ab00644cf8'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:b1e8b999-5bc4-490e-b133-3af766c0b224'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 10, part.movement_number = NULL,
    part.name_ko = 'Act I "Aa ja, aa ja, ja, ja!"', part.name_en = 'Maskarade, FS 39: Act I "Aa ja, aa ja, ja, ja!"',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 8102 AND p.composer_id = 77 AND part.part_key = 'musicbrainz:e5720366-57f3-465b-86e3-c6885a53361c' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:e5720366-57f3-465b-86e3-c6885a53361c', 10, NULL, 'Act I "Aa ja, aa ja, ja, ja!"', 'Maskarade, FS 39: Act I "Aa ja, aa ja, ja, ja!"', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:b1e8b999-5bc4-490e-b133-3af766c0b224'
WHERE p.id = 8102 AND p.composer_id = 77
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:e5720366-57f3-465b-86e3-c6885a53361c'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = NULL,
    part.name_ko = 'Act II', part.name_en = 'Maskarade, FS 39: Act II',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 8102 AND p.composer_id = 77 AND part.part_key = 'musicbrainz:093e0ddb-d265-4a40-a028-0159e5798c49' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:093e0ddb-d265-4a40-a028-0159e5798c49', 3, NULL, 'Act II', 'Maskarade, FS 39: Act II', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 8102 AND p.composer_id = 77
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:093e0ddb-d265-4a40-a028-0159e5798c49'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:093e0ddb-d265-4a40-a028-0159e5798c49'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'Act II. Prelude', part.name_en = 'Maskarade, FS 39: Act II. Prelude',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 8102 AND p.composer_id = 77 AND part.part_key = 'musicbrainz:10947f65-8bb9-4ad6-b2dc-18b8e41758c1' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:10947f65-8bb9-4ad6-b2dc-18b8e41758c1', 1, NULL, 'Act II. Prelude', 'Maskarade, FS 39: Act II. Prelude', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:093e0ddb-d265-4a40-a028-0159e5798c49'
WHERE p.id = 8102 AND p.composer_id = 77
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:10947f65-8bb9-4ad6-b2dc-18b8e41758c1'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:093e0ddb-d265-4a40-a028-0159e5798c49'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'Act II "Luk op! Luk op!"', part.name_en = 'Maskarade, FS 39: Act II "Luk op! Luk op!"',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 8102 AND p.composer_id = 77 AND part.part_key = 'musicbrainz:2f7c151d-4b24-4f2f-bf8c-78e48216773a' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:2f7c151d-4b24-4f2f-bf8c-78e48216773a', 2, NULL, 'Act II "Luk op! Luk op!"', 'Maskarade, FS 39: Act II "Luk op! Luk op!"', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:093e0ddb-d265-4a40-a028-0159e5798c49'
WHERE p.id = 8102 AND p.composer_id = 77
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:2f7c151d-4b24-4f2f-bf8c-78e48216773a'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:093e0ddb-d265-4a40-a028-0159e5798c49'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = NULL,
    part.name_ko = 'Act II "Hov, Vægter! Klokken er slagen otte!"', part.name_en = 'Maskarade, FS 39: Act II "Hov, Vægter! Klokken er slagen otte!"',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 8102 AND p.composer_id = 77 AND part.part_key = 'musicbrainz:355ff357-3132-479b-9667-a13299ea47eb' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:355ff357-3132-479b-9667-a13299ea47eb', 3, NULL, 'Act II "Hov, Vægter! Klokken er slagen otte!"', 'Maskarade, FS 39: Act II "Hov, Vægter! Klokken er slagen otte!"', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:093e0ddb-d265-4a40-a028-0159e5798c49'
WHERE p.id = 8102 AND p.composer_id = 77
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:355ff357-3132-479b-9667-a13299ea47eb'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:093e0ddb-d265-4a40-a028-0159e5798c49'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = NULL,
    part.name_ko = 'Act II "Men Herre, se! Som Venus steg af havet"', part.name_en = 'Maskarade, FS 39: Act II "Men Herre, se! Som Venus steg af havet"',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 8102 AND p.composer_id = 77 AND part.part_key = 'musicbrainz:53aeef5d-6b4d-4552-b92e-c85ca88a1d87' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:53aeef5d-6b4d-4552-b92e-c85ca88a1d87', 4, NULL, 'Act II "Men Herre, se! Som Venus steg af havet"', 'Maskarade, FS 39: Act II "Men Herre, se! Som Venus steg af havet"', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:093e0ddb-d265-4a40-a028-0159e5798c49'
WHERE p.id = 8102 AND p.composer_id = 77
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:53aeef5d-6b4d-4552-b92e-c85ca88a1d87'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:093e0ddb-d265-4a40-a028-0159e5798c49'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 5, part.movement_number = NULL,
    part.name_ko = 'Act II "Hør et Ord, Kavaler!"', part.name_en = 'Maskarade, FS 39: Act II "Hør et Ord, Kavaler!"',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 8102 AND p.composer_id = 77 AND part.part_key = 'musicbrainz:543fb83f-cfec-4348-b4c9-1b0eac343249' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:543fb83f-cfec-4348-b4c9-1b0eac343249', 5, NULL, 'Act II "Hør et Ord, Kavaler!"', 'Maskarade, FS 39: Act II "Hør et Ord, Kavaler!"', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:093e0ddb-d265-4a40-a028-0159e5798c49'
WHERE p.id = 8102 AND p.composer_id = 77
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:543fb83f-cfec-4348-b4c9-1b0eac343249'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:093e0ddb-d265-4a40-a028-0159e5798c49'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 6, part.movement_number = NULL,
    part.name_ko = 'Act II "Porten er aaben, borte er Hoben"', part.name_en = 'Maskarade, FS 39: Act II "Porten er aaben, borte er Hoben"',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 8102 AND p.composer_id = 77 AND part.part_key = 'musicbrainz:7d87d394-cc34-4b1a-963f-33bbb34a2f1c' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:7d87d394-cc34-4b1a-963f-33bbb34a2f1c', 6, NULL, 'Act II "Porten er aaben, borte er Hoben"', 'Maskarade, FS 39: Act II "Porten er aaben, borte er Hoben"', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:093e0ddb-d265-4a40-a028-0159e5798c49'
WHERE p.id = 8102 AND p.composer_id = 77
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:7d87d394-cc34-4b1a-963f-33bbb34a2f1c'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:093e0ddb-d265-4a40-a028-0159e5798c49'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 7, part.movement_number = NULL,
    part.name_ko = 'Act II "Af Sted! Af Sted!"', part.name_en = 'Maskarade, FS 39: Act II "Af Sted! Af Sted!"',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 8102 AND p.composer_id = 77 AND part.part_key = 'musicbrainz:7e4c70ef-9711-49cb-9813-282bc92d86ec' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:7e4c70ef-9711-49cb-9813-282bc92d86ec', 7, NULL, 'Act II "Af Sted! Af Sted!"', 'Maskarade, FS 39: Act II "Af Sted! Af Sted!"', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:093e0ddb-d265-4a40-a028-0159e5798c49'
WHERE p.id = 8102 AND p.composer_id = 77
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:7e4c70ef-9711-49cb-9813-282bc92d86ec'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:093e0ddb-d265-4a40-a028-0159e5798c49'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 8, part.movement_number = NULL,
    part.name_ko = 'Act II "Ha-a-a! Ha-a-a! Ha!"', part.name_en = 'Maskarade, FS 39: Act II "Ha-a-a! Ha-a-a! Ha!"',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 8102 AND p.composer_id = 77 AND part.part_key = 'musicbrainz:9c09869b-19be-4593-bd61-f85829af9b07' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:9c09869b-19be-4593-bd61-f85829af9b07', 8, NULL, 'Act II "Ha-a-a! Ha-a-a! Ha!"', 'Maskarade, FS 39: Act II "Ha-a-a! Ha-a-a! Ha!"', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:093e0ddb-d265-4a40-a028-0159e5798c49'
WHERE p.id = 8102 AND p.composer_id = 77
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:9c09869b-19be-4593-bd61-f85829af9b07'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:093e0ddb-d265-4a40-a028-0159e5798c49'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 9, part.movement_number = NULL,
    part.name_ko = 'Act II "Mellem Kande, Krus og Potte"', part.name_en = 'Maskarade, FS 39: Act II "Mellem Kande, Krus og Potte"',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 8102 AND p.composer_id = 77 AND part.part_key = 'musicbrainz:bea3a7cd-d513-4147-9ebe-da8443707840' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:bea3a7cd-d513-4147-9ebe-da8443707840', 9, NULL, 'Act II "Mellem Kande, Krus og Potte"', 'Maskarade, FS 39: Act II "Mellem Kande, Krus og Potte"', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:093e0ddb-d265-4a40-a028-0159e5798c49'
WHERE p.id = 8102 AND p.composer_id = 77
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:bea3a7cd-d513-4147-9ebe-da8443707840'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:093e0ddb-d265-4a40-a028-0159e5798c49'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 10, part.movement_number = NULL,
    part.name_ko = 'Act II "Herre! Herre! Kom kun frem!"', part.name_en = 'Maskarade, FS 39: Act II "Herre! Herre! Kom kun frem!"',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 8102 AND p.composer_id = 77 AND part.part_key = 'musicbrainz:d4033298-f1f9-4299-8478-5df5b75e260c' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:d4033298-f1f9-4299-8478-5df5b75e260c', 10, NULL, 'Act II "Herre! Herre! Kom kun frem!"', 'Maskarade, FS 39: Act II "Herre! Herre! Kom kun frem!"', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:093e0ddb-d265-4a40-a028-0159e5798c49'
WHERE p.id = 8102 AND p.composer_id = 77
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:d4033298-f1f9-4299-8478-5df5b75e260c'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:093e0ddb-d265-4a40-a028-0159e5798c49'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 11, part.movement_number = NULL,
    part.name_ko = 'Act II "Se saa! Se saa! Nu er jeg ret bered"', part.name_en = 'Maskarade, FS 39: Act II "Se saa! Se saa! Nu er jeg ret bered"',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 8102 AND p.composer_id = 77 AND part.part_key = 'musicbrainz:d9160377-d054-4602-8d8e-3844c1b7f469' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:d9160377-d054-4602-8d8e-3844c1b7f469', 11, NULL, 'Act II "Se saa! Se saa! Nu er jeg ret bered"', 'Maskarade, FS 39: Act II "Se saa! Se saa! Nu er jeg ret bered"', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:093e0ddb-d265-4a40-a028-0159e5798c49'
WHERE p.id = 8102 AND p.composer_id = 77
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:d9160377-d054-4602-8d8e-3844c1b7f469'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = NULL,
    part.name_ko = 'Act III', part.name_en = 'Maskarade, FS 39: Act III',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 8102 AND p.composer_id = 77 AND part.part_key = 'musicbrainz:ab346730-eb18-4960-9510-2377bbd3145a' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:ab346730-eb18-4960-9510-2377bbd3145a', 4, NULL, 'Act III', 'Maskarade, FS 39: Act III', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 8102 AND p.composer_id = 77
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:ab346730-eb18-4960-9510-2377bbd3145a'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:ab346730-eb18-4960-9510-2377bbd3145a'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'Act III "Gjør Plads! Gjør Plads!"', part.name_en = 'Maskarade, FS 39: Act III "Gjør Plads! Gjør Plads!"',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 8102 AND p.composer_id = 77 AND part.part_key = 'musicbrainz:2b7f9fc1-99e0-45e8-8d10-bea296756883' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:2b7f9fc1-99e0-45e8-8d10-bea296756883', 1, NULL, 'Act III "Gjør Plads! Gjør Plads!"', 'Maskarade, FS 39: Act III "Gjør Plads! Gjør Plads!"', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:ab346730-eb18-4960-9510-2377bbd3145a'
WHERE p.id = 8102 AND p.composer_id = 77
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:2b7f9fc1-99e0-45e8-8d10-bea296756883'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:ab346730-eb18-4960-9510-2377bbd3145a'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'Act III "Tramtrara! Tramtrara!"', part.name_en = 'Maskarade, FS 39: Act III "Tramtrara! Tramtrara!"',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 8102 AND p.composer_id = 77 AND part.part_key = 'musicbrainz:2d83c976-665b-400e-8d35-29bc20893a40' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:2d83c976-665b-400e-8d35-29bc20893a40', 2, NULL, 'Act III "Tramtrara! Tramtrara!"', 'Maskarade, FS 39: Act III "Tramtrara! Tramtrara!"', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:ab346730-eb18-4960-9510-2377bbd3145a'
WHERE p.id = 8102 AND p.composer_id = 77
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:2d83c976-665b-400e-8d35-29bc20893a40'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:ab346730-eb18-4960-9510-2377bbd3145a'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = NULL,
    part.name_ko = 'Act III "Gaa af Vejen! Gaa af Vejen!"', part.name_en = 'Maskarade, FS 39: Act III "Gaa af Vejen! Gaa af Vejen!"',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 8102 AND p.composer_id = 77 AND part.part_key = 'musicbrainz:3aa1c5b4-2ab2-47ec-9a34-5e077bb9a8f9' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:3aa1c5b4-2ab2-47ec-9a34-5e077bb9a8f9', 3, NULL, 'Act III "Gaa af Vejen! Gaa af Vejen!"', 'Maskarade, FS 39: Act III "Gaa af Vejen! Gaa af Vejen!"', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:ab346730-eb18-4960-9510-2377bbd3145a'
WHERE p.id = 8102 AND p.composer_id = 77
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:3aa1c5b4-2ab2-47ec-9a34-5e077bb9a8f9'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:ab346730-eb18-4960-9510-2377bbd3145a'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = NULL,
    part.name_ko = 'Act III "Ulignelige Pige"', part.name_en = 'Maskarade, FS 39: Act III "Ulignelige Pige"',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 8102 AND p.composer_id = 77 AND part.part_key = 'musicbrainz:3e54c1b7-c20b-49d4-b1a4-0bb9ce00caaf' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:3e54c1b7-c20b-49d4-b1a4-0bb9ce00caaf', 4, NULL, 'Act III "Ulignelige Pige"', 'Maskarade, FS 39: Act III "Ulignelige Pige"', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:ab346730-eb18-4960-9510-2377bbd3145a'
WHERE p.id = 8102 AND p.composer_id = 77
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:3e54c1b7-c20b-49d4-b1a4-0bb9ce00caaf'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:ab346730-eb18-4960-9510-2377bbd3145a'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 5, part.movement_number = NULL,
    part.name_ko = 'Act III "Hvor Bacchus er, maa Mars og Venus være"', part.name_en = 'Maskarade, FS 39: Act III "Hvor Bacchus er, maa Mars og Venus være"',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 8102 AND p.composer_id = 77 AND part.part_key = 'musicbrainz:54987fa0-121c-4c34-94ec-87b9e3e95d4a' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:54987fa0-121c-4c34-94ec-87b9e3e95d4a', 5, NULL, 'Act III "Hvor Bacchus er, maa Mars og Venus være"', 'Maskarade, FS 39: Act III "Hvor Bacchus er, maa Mars og Venus være"', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:ab346730-eb18-4960-9510-2377bbd3145a'
WHERE p.id = 8102 AND p.composer_id = 77
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:54987fa0-121c-4c34-94ec-87b9e3e95d4a'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:ab346730-eb18-4960-9510-2377bbd3145a'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 6, part.movement_number = NULL,
    part.name_ko = 'Act III "O kom, min Ven!"', part.name_en = 'Maskarade, FS 39: Act III "O kom, min Ven!"',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 8102 AND p.composer_id = 77 AND part.part_key = 'musicbrainz:56d316d2-fb86-46c1-94df-cd80b9b2c156' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:56d316d2-fb86-46c1-94df-cd80b9b2c156', 6, NULL, 'Act III "O kom, min Ven!"', 'Maskarade, FS 39: Act III "O kom, min Ven!"', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:ab346730-eb18-4960-9510-2377bbd3145a'
WHERE p.id = 8102 AND p.composer_id = 77
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:56d316d2-fb86-46c1-94df-cd80b9b2c156'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:ab346730-eb18-4960-9510-2377bbd3145a'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 7, part.movement_number = NULL,
    part.name_ko = 'Act III Hanedans', part.name_en = 'Maskarade, FS 39: Act III Hanedans',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 8102 AND p.composer_id = 77 AND part.part_key = 'musicbrainz:5cd2e6b7-fc22-40a0-8f14-9cf7bc34d336' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:5cd2e6b7-fc22-40a0-8f14-9cf7bc34d336', 7, NULL, 'Act III Hanedans', 'Maskarade, FS 39: Act III Hanedans', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:ab346730-eb18-4960-9510-2377bbd3145a'
WHERE p.id = 8102 AND p.composer_id = 77
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:5cd2e6b7-fc22-40a0-8f14-9cf7bc34d336'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:ab346730-eb18-4960-9510-2377bbd3145a'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 8, part.movement_number = NULL,
    part.name_ko = 'Act III "Kehraus! Kehraus! Dans ud! Dans ud! Dans ud!"', part.name_en = 'Maskarade, FS 39: Act III "Kehraus! Kehraus! Dans ud! Dans ud! Dans ud!"',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 8102 AND p.composer_id = 77 AND part.part_key = 'musicbrainz:5e629751-d766-4433-99e4-832f8ee655c5' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:5e629751-d766-4433-99e4-832f8ee655c5', 8, NULL, 'Act III "Kehraus! Kehraus! Dans ud! Dans ud! Dans ud!"', 'Maskarade, FS 39: Act III "Kehraus! Kehraus! Dans ud! Dans ud! Dans ud!"', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:ab346730-eb18-4960-9510-2377bbd3145a'
WHERE p.id = 8102 AND p.composer_id = 77
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:5e629751-d766-4433-99e4-832f8ee655c5'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:ab346730-eb18-4960-9510-2377bbd3145a'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 9, part.movement_number = NULL,
    part.name_ko = 'Act III "Giv Lyd, Godtfolk, at vi kan høre Tonen!"', part.name_en = 'Maskarade, FS 39: Act III "Giv Lyd, Godtfolk, at vi kan høre Tonen!"',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 8102 AND p.composer_id = 77 AND part.part_key = 'musicbrainz:73ba8f69-5ae0-458a-8c87-02694923bc6d' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:73ba8f69-5ae0-458a-8c87-02694923bc6d', 9, NULL, 'Act III "Giv Lyd, Godtfolk, at vi kan høre Tonen!"', 'Maskarade, FS 39: Act III "Giv Lyd, Godtfolk, at vi kan høre Tonen!"', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:ab346730-eb18-4960-9510-2377bbd3145a'
WHERE p.id = 8102 AND p.composer_id = 77
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:73ba8f69-5ae0-458a-8c87-02694923bc6d'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:ab346730-eb18-4960-9510-2377bbd3145a'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 10, part.movement_number = NULL,
    part.name_ko = 'Act III "Min søde Balsambøsse!"', part.name_en = 'Maskarade, FS 39: Act III "Min søde Balsambøsse!"',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 8102 AND p.composer_id = 77 AND part.part_key = 'musicbrainz:85264d23-6c72-4380-a35b-cfd19fd89d72' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:85264d23-6c72-4380-a35b-cfd19fd89d72', 10, NULL, 'Act III "Min søde Balsambøsse!"', 'Maskarade, FS 39: Act III "Min søde Balsambøsse!"', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:ab346730-eb18-4960-9510-2377bbd3145a'
WHERE p.id = 8102 AND p.composer_id = 77
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:85264d23-6c72-4380-a35b-cfd19fd89d72'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:ab346730-eb18-4960-9510-2377bbd3145a'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 11, part.movement_number = NULL,
    part.name_ko = 'Act III "Du er min Ven. Kom lad os drikke Dus!"', part.name_en = 'Maskarade, FS 39: Act III "Du er min Ven. Kom lad os drikke Dus!"',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 8102 AND p.composer_id = 77 AND part.part_key = 'musicbrainz:c1ceb34b-7f8a-49e9-99a1-64559626db4a' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:c1ceb34b-7f8a-49e9-99a1-64559626db4a', 11, NULL, 'Act III "Du er min Ven. Kom lad os drikke Dus!"', 'Maskarade, FS 39: Act III "Du er min Ven. Kom lad os drikke Dus!"', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:ab346730-eb18-4960-9510-2377bbd3145a'
WHERE p.id = 8102 AND p.composer_id = 77
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:c1ceb34b-7f8a-49e9-99a1-64559626db4a'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:ab346730-eb18-4960-9510-2377bbd3145a'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 12, part.movement_number = NULL,
    part.name_ko = 'Act III "Ak, Hr. Magister!"', part.name_en = 'Maskarade, FS 39: Act III "Ak, Hr. Magister!"',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 8102 AND p.composer_id = 77 AND part.part_key = 'musicbrainz:c3ca4997-c9da-4c57-98ee-f665efa17805' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:c3ca4997-c9da-4c57-98ee-f665efa17805', 12, NULL, 'Act III "Ak, Hr. Magister!"', 'Maskarade, FS 39: Act III "Ak, Hr. Magister!"', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:ab346730-eb18-4960-9510-2377bbd3145a'
WHERE p.id = 8102 AND p.composer_id = 77
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:c3ca4997-c9da-4c57-98ee-f665efa17805'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:ab346730-eb18-4960-9510-2377bbd3145a'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 13, part.movement_number = NULL,
    part.name_ko = 'Act III "At slig er Ungersvend i sin Tale"', part.name_en = 'Maskarade, FS 39: Act III "At slig er Ungersvend i sin Tale"',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 8102 AND p.composer_id = 77 AND part.part_key = 'musicbrainz:c803df8b-e870-4e65-bd2c-5f79823af8aa' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:c803df8b-e870-4e65-bd2c-5f79823af8aa', 13, NULL, 'Act III "At slig er Ungersvend i sin Tale"', 'Maskarade, FS 39: Act III "At slig er Ungersvend i sin Tale"', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:ab346730-eb18-4960-9510-2377bbd3145a'
WHERE p.id = 8102 AND p.composer_id = 77
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:c803df8b-e870-4e65-bd2c-5f79823af8aa'
);


-- CNW 97 Melodi

UPDATE pieces piece
SET piece.title = 'Melodi', piece.title_en = 'Melodi, CNW 97',
    piece.type = 'song', piece.opus_number = 'CNW 97',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 7550 AND piece.composer_id = 77
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- Op. 41 부수음악 <Moderen> Op. 41

UPDATE pieces piece
SET piece.title = '부수음악 <Moderen> Op. 41', piece.title_en = 'Moderen, op. 41, FS 94',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = 'Op.', piece.catalogue_number = '41',
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 9649 AND piece.composer_id = 77
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'Tro og håb spiller', part.name_en = 'Moderen, op. 41, FS 94: Tro og håb spiller',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 9649 AND p.composer_id = 77 AND part.part_key = 'musicbrainz:0fec58bd-727d-40e9-aa44-324e4cefa686' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:0fec58bd-727d-40e9-aa44-324e4cefa686', 1, NULL, 'Tro og håb spiller', 'Moderen, op. 41, FS 94: Tro og håb spiller', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 9649 AND p.composer_id = 77
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:0fec58bd-727d-40e9-aa44-324e4cefa686'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'Børnene leger', part.name_en = 'Moderen, op. 41, FS 94: Børnene leger',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 9649 AND p.composer_id = 77 AND part.part_key = 'musicbrainz:1a475a69-e0b2-4965-a2e7-865980b3e8e0' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:1a475a69-e0b2-4965-a2e7-865980b3e8e0', 2, NULL, 'Børnene leger', 'Moderen, op. 41, FS 94: Børnene leger', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 9649 AND p.composer_id = 77
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:1a475a69-e0b2-4965-a2e7-865980b3e8e0'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = NULL,
    part.name_ko = 'Min Pige er saa lys som Rav', part.name_en = 'Moderen, op. 41, FS 94: Min Pige er saa lys som Rav',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 9649 AND p.composer_id = 77 AND part.part_key = 'musicbrainz:782a1738-08e2-4617-bb6f-65232399c410' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:782a1738-08e2-4617-bb6f-65232399c410', 3, NULL, 'Min Pige er saa lys som Rav', 'Moderen, op. 41, FS 94: Min Pige er saa lys som Rav', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 9649 AND p.composer_id = 77
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:782a1738-08e2-4617-bb6f-65232399c410'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = NULL,
    part.name_ko = 'Taagen Letter', part.name_en = 'Moderen, op. 41, FS 94: Taagen Letter',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 9649 AND p.composer_id = 77 AND part.part_key = 'musicbrainz:c16b7f35-c678-4756-beab-f66f2736d3b1' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:c16b7f35-c678-4756-beab-f66f2736d3b1', 4, NULL, 'Taagen Letter', 'Moderen, op. 41, FS 94: Taagen Letter', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 9649 AND p.composer_id = 77
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:c16b7f35-c678-4756-beab-f66f2736d3b1'
);


-- Op. 4 Musik til fem Digte af J.P. Jacobsen Op. 4

UPDATE pieces piece
SET piece.title = 'Musik til fem Digte af J.P. Jacobsen Op. 4', piece.title_en = 'Musik til fem Digte af J.P. Jacobsen, op. 4',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = 'Op.', piece.catalogue_number = '4',
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 10582 AND piece.composer_id = 77
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'Solnedgang, op. 4 no. 1, CNW 116', part.name_en = 'Solnedgang, op. 4 no. 1, CNW 116',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 10582 AND p.composer_id = 77 AND part.part_key = 'musicbrainz:1bc7be8a-4375-4b72-bc01-35d2b6609c86' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:1bc7be8a-4375-4b72-bc01-35d2b6609c86', 1, NULL, 'Solnedgang, op. 4 no. 1, CNW 116', 'Solnedgang, op. 4 no. 1, CNW 116', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 10582 AND p.composer_id = 77
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:1bc7be8a-4375-4b72-bc01-35d2b6609c86'
);


-- CNW 256 가곡 <Nu lyser løv i lunde>

UPDATE pieces piece
SET piece.title = '가곡 <Nu lyser løv i lunde>', piece.title_en = 'Nu lyser løv i lunde, CNW 256',
    piece.type = 'song', piece.opus_number = 'CNW 256',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 8133 AND piece.composer_id = 77
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- CNW 261 가곡 <Nu skal det åbenbares>

UPDATE pieces piece
SET piece.title = '가곡 <Nu skal det åbenbares>', piece.title_en = 'Nu skal det åbenbares, CNW 261',
    piece.type = 'song', piece.opus_number = 'CNW 261',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 10366 AND piece.composer_id = 77
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- Op. 49 Pan og Syrinx

UPDATE pieces piece
SET piece.title = 'Pan og Syrinx', piece.title_en = 'Pan og Syrinx, op. 49',
    piece.type = 'song', piece.opus_number = 'Op. 49',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 10174 AND piece.composer_id = 77
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- FS 63 Paraphrase on "Nærmere Gud til dig"

UPDATE pieces piece
SET piece.title = 'Paraphrase on "Nærmere Gud til dig"', piece.title_en = 'Paraphrase on "Nærmere Gud til dig", FS 63',
    piece.type = 'song', piece.opus_number = 'FS 63',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 10734 AND piece.composer_id = 77
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- FS 3i 피아노 3중주 G장조

UPDATE pieces piece
SET piece.title = '피아노 3중주 G장조', piece.title_en = 'Piano Trio in G major, FS 3i',
    piece.type = 'album', piece.opus_number = 'FS 3i',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 8468 AND piece.composer_id = 77
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'I', part.name_en = 'Piano Trio in G major, FS 3i: I.',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 8468 AND p.composer_id = 77 AND part.part_key = 'musicbrainz:01284b99-f744-46cf-93e6-c503e40ac012' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:01284b99-f744-46cf-93e6-c503e40ac012', 1, NULL, 'I', 'Piano Trio in G major, FS 3i: I.', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 8468 AND p.composer_id = 77
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:01284b99-f744-46cf-93e6-c503e40ac012'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'Andante', part.name_en = 'Piano Trio in G major, FS 3i: II. Andante',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 8468 AND p.composer_id = 77 AND part.part_key = 'musicbrainz:35cf3069-f9b4-4412-acc5-6d733f696ec1' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:35cf3069-f9b4-4412-acc5-6d733f696ec1', 2, 'II', 'Andante', 'Piano Trio in G major, FS 3i: II. Andante', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 8468 AND p.composer_id = 77
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:35cf3069-f9b4-4412-acc5-6d733f696ec1'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = 'Allegro grazioso', part.name_en = 'Piano Trio in G major, FS 3i: III. Allegro grazioso',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 8468 AND p.composer_id = 77 AND part.part_key = 'musicbrainz:600b2061-9a2a-43bc-959a-60c576710feb' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:600b2061-9a2a-43bc-959a-60c576710feb', 3, 'III', 'Allegro grazioso', 'Piano Trio in G major, FS 3i: III. Allegro grazioso', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 8468 AND p.composer_id = 77
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:600b2061-9a2a-43bc-959a-60c576710feb'
);


-- None Polka for Solo Violin

UPDATE pieces piece
SET piece.title = 'Polka for Solo Violin', piece.title_en = 'Polka for Solo Violin',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 11207 AND piece.composer_id = 77
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- Op. 48 Prelude & Theme With Variations for Solo Violin Op. 48

UPDATE pieces piece
SET piece.title = 'Prelude & Theme With Variations for Solo Violin Op. 48', piece.title_en = 'Prelude & Theme With Variations for Solo Violin, op. 48, FS 104',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = 'Op.', piece.catalogue_number = '48',
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 10613 AND piece.composer_id = 77
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'Prelude: Poco adagio e con fantasia', part.name_en = 'Prelude & Theme With Variations for Solo Violin, op. 48, FS 104: Prelude: Poco adagio e con fantasia',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 10613 AND p.composer_id = 77 AND part.part_key = 'musicbrainz:88e8e1bb-d17c-4ecf-97be-27713e16bcfc' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:88e8e1bb-d17c-4ecf-97be-27713e16bcfc', 1, NULL, 'Prelude: Poco adagio e con fantasia', 'Prelude & Theme With Variations for Solo Violin, op. 48, FS 104: Prelude: Poco adagio e con fantasia', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 10613 AND p.composer_id = 77
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:88e8e1bb-d17c-4ecf-97be-27713e16bcfc'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'Thema: Andante', part.name_en = 'Prelude & Theme With Variations for Solo Violin, op. 48, FS 104: Thema: Andante',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 10613 AND p.composer_id = 77 AND part.part_key = 'musicbrainz:c97ee364-bf1b-4e16-a6d5-f9768041b9cf' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:c97ee364-bf1b-4e16-a6d5-f9768041b9cf', 2, NULL, 'Thema: Andante', 'Prelude & Theme With Variations for Solo Violin, op. 48, FS 104: Thema: Andante', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 10613 AND p.composer_id = 77
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:c97ee364-bf1b-4e16-a6d5-f9768041b9cf'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = NULL,
    part.name_ko = 'Variation 1: Più mosso', part.name_en = 'Prelude & Theme With Variations for Solo Violin, op. 48, FS 104: Variation 1: Più mosso',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 10613 AND p.composer_id = 77 AND part.part_key = 'musicbrainz:0f991675-5eec-4147-a800-a8e738e037e3' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:0f991675-5eec-4147-a800-a8e738e037e3', 3, NULL, 'Variation 1: Più mosso', 'Prelude & Theme With Variations for Solo Violin, op. 48, FS 104: Variation 1: Più mosso', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 10613 AND p.composer_id = 77
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:0f991675-5eec-4147-a800-a8e738e037e3'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = NULL,
    part.name_ko = 'Variation 2: Andantino quasi allegretto', part.name_en = 'Prelude & Theme With Variations for Solo Violin, op. 48, FS 104: Variation 2: Andantino quasi allegretto',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 10613 AND p.composer_id = 77 AND part.part_key = 'musicbrainz:28679e10-08e1-4e43-af81-123f4f1237c8' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:28679e10-08e1-4e43-af81-123f4f1237c8', 4, NULL, 'Variation 2: Andantino quasi allegretto', 'Prelude & Theme With Variations for Solo Violin, op. 48, FS 104: Variation 2: Andantino quasi allegretto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 10613 AND p.composer_id = 77
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:28679e10-08e1-4e43-af81-123f4f1237c8'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 5, part.movement_number = NULL,
    part.name_ko = 'Variation 3: Andante espressivo', part.name_en = 'Prelude & Theme With Variations for Solo Violin, op. 48, FS 104: Variation 3: Andante espressivo',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 10613 AND p.composer_id = 77 AND part.part_key = 'musicbrainz:5ac62f0f-269c-478d-a324-f39e889383ba' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:5ac62f0f-269c-478d-a324-f39e889383ba', 5, NULL, 'Variation 3: Andante espressivo', 'Prelude & Theme With Variations for Solo Violin, op. 48, FS 104: Variation 3: Andante espressivo', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 10613 AND p.composer_id = 77
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:5ac62f0f-269c-478d-a324-f39e889383ba'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 6, part.movement_number = NULL,
    part.name_ko = 'Variation 4: Poco allegro, molto ritmico', part.name_en = 'Prelude & Theme With Variations for Solo Violin, op. 48, FS 104: Variation 4: Poco allegro, molto ritmico',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 10613 AND p.composer_id = 77 AND part.part_key = 'musicbrainz:bcb21d0a-2dae-431b-af76-41ad6e9384f8' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:bcb21d0a-2dae-431b-af76-41ad6e9384f8', 6, NULL, 'Variation 4: Poco allegro, molto ritmico', 'Prelude & Theme With Variations for Solo Violin, op. 48, FS 104: Variation 4: Poco allegro, molto ritmico', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 10613 AND p.composer_id = 77
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:bcb21d0a-2dae-431b-af76-41ad6e9384f8'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 7, part.movement_number = NULL,
    part.name_ko = 'Variation 5: Più mosso', part.name_en = 'Prelude & Theme With Variations for Solo Violin, op. 48, FS 104: Variation 5: Più mosso',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 10613 AND p.composer_id = 77 AND part.part_key = 'musicbrainz:e524f3cb-2adb-4bf3-9c66-f68945d0444a' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:e524f3cb-2adb-4bf3-9c66-f68945d0444a', 7, NULL, 'Variation 5: Più mosso', 'Prelude & Theme With Variations for Solo Violin, op. 48, FS 104: Variation 5: Più mosso', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 10613 AND p.composer_id = 77
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:e524f3cb-2adb-4bf3-9c66-f68945d0444a'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 8, part.movement_number = NULL,
    part.name_ko = 'Variation 6: Tempo giusto', part.name_en = 'Prelude & Theme With Variations for Solo Violin, op. 48, FS 104: Variation 6: Tempo giusto',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 10613 AND p.composer_id = 77 AND part.part_key = 'musicbrainz:b0e5574e-2f4e-409d-9917-8674128c7b85' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:b0e5574e-2f4e-409d-9917-8674128c7b85', 8, NULL, 'Variation 6: Tempo giusto', 'Prelude & Theme With Variations for Solo Violin, op. 48, FS 104: Variation 6: Tempo giusto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 10613 AND p.composer_id = 77
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:b0e5574e-2f4e-409d-9917-8674128c7b85'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 9, part.movement_number = NULL,
    part.name_ko = 'Variation 7: Presto', part.name_en = 'Prelude & Theme With Variations for Solo Violin, op. 48, FS 104: Variation 7: Presto',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 10613 AND p.composer_id = 77 AND part.part_key = 'musicbrainz:4fbaf93c-4e05-4cca-beae-59ad0a59dbcb' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:4fbaf93c-4e05-4cca-beae-59ad0a59dbcb', 9, NULL, 'Variation 7: Presto', 'Prelude & Theme With Variations for Solo Violin, op. 48, FS 104: Variation 7: Presto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 10613 AND p.composer_id = 77
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:4fbaf93c-4e05-4cca-beae-59ad0a59dbcb'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 10, part.movement_number = NULL,
    part.name_ko = 'Variation 8: Poco adagio', part.name_en = 'Prelude & Theme With Variations for Solo Violin, op. 48, FS 104: Variation 8: Poco adagio',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 10613 AND p.composer_id = 77 AND part.part_key = 'musicbrainz:08f20f36-8c8d-4462-91eb-57dc70b404e8' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:08f20f36-8c8d-4462-91eb-57dc70b404e8', 10, NULL, 'Variation 8: Poco adagio', 'Prelude & Theme With Variations for Solo Violin, op. 48, FS 104: Variation 8: Poco adagio', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 10613 AND p.composer_id = 77
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:08f20f36-8c8d-4462-91eb-57dc70b404e8'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 11, part.movement_number = NULL,
    part.name_ko = 'Tempo di tema', part.name_en = 'Prelude & Theme With Variations for Solo Violin, op. 48, FS 104: Tempo di tema',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 10613 AND p.composer_id = 77 AND part.part_key = 'musicbrainz:e81fe520-2f81-4d84-b12f-ba250e00dd60' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:e81fe520-2f81-4d84-b12f-ba250e00dd60', 11, NULL, 'Tempo di tema', 'Prelude & Theme With Variations for Solo Violin, op. 48, FS 104: Tempo di tema', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 10613 AND p.composer_id = 77
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:e81fe520-2f81-4d84-b12f-ba250e00dd60'
);


-- Op. 52 Preludio & Presto Op. 52

UPDATE pieces piece
SET piece.title = 'Preludio & Presto Op. 52', piece.title_en = 'Preludio & Presto, op. 52, FS 128',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = 'Op.', piece.catalogue_number = '52',
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 10945 AND piece.composer_id = 77
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'Preludio: Con fantasia', part.name_en = 'Preludio & Presto, op. 52, FS 128: Preludio: Con fantasia',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 10945 AND p.composer_id = 77 AND part.part_key = 'musicbrainz:5aacc678-4c32-40bc-b701-eb6c2b1c8aeb' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:5aacc678-4c32-40bc-b701-eb6c2b1c8aeb', 1, NULL, 'Preludio: Con fantasia', 'Preludio & Presto, op. 52, FS 128: Preludio: Con fantasia', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 10945 AND p.composer_id = 77
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:5aacc678-4c32-40bc-b701-eb6c2b1c8aeb'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'Presto', part.name_en = 'Preludio & Presto, op. 52, FS 128: Presto',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 10945 AND p.composer_id = 77 AND part.part_key = 'musicbrainz:9f7993c0-6057-431b-9c17-8ac467b0779f' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:9f7993c0-6057-431b-9c17-8ac467b0779f', 2, NULL, 'Presto', 'Preludio & Presto, op. 52, FS 128: Presto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 10945 AND p.composer_id = 77
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:9f7993c0-6057-431b-9c17-8ac467b0779f'
);


-- CNW 238 På det jævne, på det jævne!

UPDATE pieces piece
SET piece.title = 'På det jævne, på det jævne!', piece.title_en = 'På det jævne, på det jævne!, CNW 238',
    piece.type = 'song', piece.opus_number = 'CNW 238',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 10064 AND piece.composer_id = 77
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Påskeblomst! Hvad vil du her?

UPDATE pieces piece
SET piece.title = 'Påskeblomst! Hvad vil du her?', piece.title_en = 'Påskeblomst! Hvad vil du her?',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 8369 AND piece.composer_id = 77
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- CNW 61 바이올린과 피아노를 위한 로망스 D장조

UPDATE pieces piece
SET piece.title = '바이올린과 피아노를 위한 로망스 D장조', piece.title_en = 'Romance for Violin and Piano in D major, CNW 61',
    piece.type = 'song', piece.opus_number = 'CNW 61',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 8402 AND piece.composer_id = 77
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- Op. 39 Saga-Drøm

UPDATE pieces piece
SET piece.title = 'Saga-Drøm', piece.title_en = 'Saga-Drøm, op. 39',
    piece.type = 'song', piece.opus_number = 'Op. 39',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 7546 AND piece.composer_id = 77
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- FS 83 Salmer og aandelige Sange FS 83

UPDATE pieces piece
SET piece.title = 'Salmer og aandelige Sange FS 83', piece.title_en = 'Salmer og aandelige Sange, FS 83, CNW 153-201',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = 'FS', piece.catalogue_number = '83',
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 7441 AND piece.composer_id = 77
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'Frisk op! Endnu engang, CNW 168', part.name_en = 'Frisk op! Endnu engang, CNW 168',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 7441 AND p.composer_id = 77 AND part.part_key = 'musicbrainz:1324f22e-dad6-49ec-92c8-a7d28c5a9f19' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:1324f22e-dad6-49ec-92c8-a7d28c5a9f19', 1, NULL, 'Frisk op! Endnu engang, CNW 168', 'Frisk op! Endnu engang, CNW 168', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 7441 AND p.composer_id = 77
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:1324f22e-dad6-49ec-92c8-a7d28c5a9f19'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'Guds Engle i Flok, CNW 170', part.name_en = 'Guds Engle i Flok, CNW 170',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 7441 AND p.composer_id = 77 AND part.part_key = 'musicbrainz:45fa7e10-570a-46cf-ad57-8c4e09605d86' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:45fa7e10-570a-46cf-ad57-8c4e09605d86', 2, NULL, 'Guds Engle i Flok, CNW 170', 'Guds Engle i Flok, CNW 170', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 7441 AND p.composer_id = 77
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:45fa7e10-570a-46cf-ad57-8c4e09605d86'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = NULL,
    part.name_ko = 'Et helligt Liv, en salig Død, CNW 164', part.name_en = 'Et helligt Liv, en salig Død, CNW 164',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 7441 AND p.composer_id = 77 AND part.part_key = 'musicbrainz:51ca5644-0214-47fa-8116-68b6b915d0df' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:51ca5644-0214-47fa-8116-68b6b915d0df', 3, NULL, 'Et helligt Liv, en salig Død, CNW 164', 'Et helligt Liv, en salig Død, CNW 164', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 7441 AND p.composer_id = 77
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:51ca5644-0214-47fa-8116-68b6b915d0df'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = NULL,
    part.name_ko = 'Naar jeg betœnker Tid ig Stund, CNW 185', part.name_en = 'Naar jeg betœnker Tid ig Stund, CNW 185',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 7441 AND p.composer_id = 77 AND part.part_key = 'musicbrainz:6f74afa8-7472-4975-8c76-6fe7ca176460' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:6f74afa8-7472-4975-8c76-6fe7ca176460', 4, NULL, 'Naar jeg betœnker Tid ig Stund, CNW 185', 'Naar jeg betœnker Tid ig Stund, CNW 185', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 7441 AND p.composer_id = 77
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:6f74afa8-7472-4975-8c76-6fe7ca176460'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 5, part.movement_number = NULL,
    part.name_ko = 'Forunderligt at sige, CNW 165', part.name_en = 'Forunderligt at sige, CNW 165',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 7441 AND p.composer_id = 77 AND part.part_key = 'musicbrainz:a6b95053-3e46-4c81-9fd2-11e2287b1c25' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:a6b95053-3e46-4c81-9fd2-11e2287b1c25', 5, NULL, 'Forunderligt at sige, CNW 165', 'Forunderligt at sige, CNW 165', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 7441 AND p.composer_id = 77
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:a6b95053-3e46-4c81-9fd2-11e2287b1c25'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 6, part.movement_number = NULL,
    part.name_ko = 'Ak, min rose visner bort, CNW 153', part.name_en = 'Ak, min rose visner bort, CNW 153',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 7441 AND p.composer_id = 77 AND part.part_key = 'musicbrainz:e0904138-7bda-4bc4-bbd9-531efb9596ad' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:e0904138-7bda-4bc4-bbd9-531efb9596ad', 6, NULL, 'Ak, min rose visner bort, CNW 153', 'Ak, min rose visner bort, CNW 153', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 7441 AND p.composer_id = 77
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:e0904138-7bda-4bc4-bbd9-531efb9596ad'
);


-- Op. 10 Sange af Ludvig Holstein Op. 10

UPDATE pieces piece
SET piece.title = 'Sange af Ludvig Holstein Op. 10', piece.title_en = 'Sange af Ludvig Holstein, op. 10',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = 'Op.', piece.catalogue_number = '10',
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 8522 AND piece.composer_id = 77
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'Æbleblomst, op. 10 no. 1', part.name_en = 'Æbleblomst, op. 10 no. 1',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 8522 AND p.composer_id = 77 AND part.part_key = 'musicbrainz:18750f36-05ac-4216-8343-addcc8df058b' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:18750f36-05ac-4216-8343-addcc8df058b', 1, NULL, 'Æbleblomst, op. 10 no. 1', 'Æbleblomst, op. 10 no. 1', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 8522 AND p.composer_id = 77
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:18750f36-05ac-4216-8343-addcc8df058b'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'Sommersang, op. 10 no. 3', part.name_en = 'Sommersang, op. 10 no. 3',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 8522 AND p.composer_id = 77 AND part.part_key = 'musicbrainz:792daecd-341b-4cac-9568-ab55f4fb480d' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:792daecd-341b-4cac-9568-ab55f4fb480d', 2, NULL, 'Sommersang, op. 10 no. 3', 'Sommersang, op. 10 no. 3', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 8522 AND p.composer_id = 77
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:792daecd-341b-4cac-9568-ab55f4fb480d'
);


-- FS 25 오페라 <Saul og David> FS 25

UPDATE pieces piece
SET piece.title = '오페라 <Saul og David> FS 25', piece.title_en = 'Saul og David, FS 25',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = 'FS', piece.catalogue_number = '25',
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 7548 AND piece.composer_id = 77
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'Akt I', part.name_en = 'Saul og David, FS 25: Akt I',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 7548 AND p.composer_id = 77 AND part.part_key = 'musicbrainz:147a178c-547e-4e7c-a2ec-126bada129d4' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:147a178c-547e-4e7c-a2ec-126bada129d4', 1, NULL, 'Akt I', 'Saul og David, FS 25: Akt I', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 7548 AND p.composer_id = 77
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:147a178c-547e-4e7c-a2ec-126bada129d4'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'Akt II', part.name_en = 'Saul og David, FS 25: Akt II',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 7548 AND p.composer_id = 77 AND part.part_key = 'musicbrainz:21d31a23-0e16-4003-8d9d-05379685ba4b' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:21d31a23-0e16-4003-8d9d-05379685ba4b', 2, NULL, 'Akt II', 'Saul og David, FS 25: Akt II', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 7548 AND p.composer_id = 77
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:21d31a23-0e16-4003-8d9d-05379685ba4b'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:21d31a23-0e16-4003-8d9d-05379685ba4b'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'Akt II. Prelude', part.name_en = 'Saul og David, FS 25: Akt II. Prelude',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 7548 AND p.composer_id = 77 AND part.part_key = 'musicbrainz:fb1829af-5df8-46be-b5e0-54a0a7639b87' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:fb1829af-5df8-46be-b5e0-54a0a7639b87', 1, NULL, 'Akt II. Prelude', 'Saul og David, FS 25: Akt II. Prelude', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:21d31a23-0e16-4003-8d9d-05379685ba4b'
WHERE p.id = 7548 AND p.composer_id = 77
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:fb1829af-5df8-46be-b5e0-54a0a7639b87'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = NULL,
    part.name_ko = 'Akt III', part.name_en = 'Saul og David, FS 25: Akt III',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 7548 AND p.composer_id = 77 AND part.part_key = 'musicbrainz:ba5d70c1-9157-4ab2-abc5-5745471774c8' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:ba5d70c1-9157-4ab2-abc5-5745471774c8', 3, NULL, 'Akt III', 'Saul og David, FS 25: Akt III', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 7548 AND p.composer_id = 77
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:ba5d70c1-9157-4ab2-abc5-5745471774c8'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = NULL,
    part.name_ko = 'Akt IV', part.name_en = 'Saul og David, FS 25: Akt IV',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 7548 AND p.composer_id = 77 AND part.part_key = 'musicbrainz:65e14465-9722-4b2b-bc53-ca81ac3f9d42' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:65e14465-9722-4b2b-bc53-ca81ac3f9d42', 4, NULL, 'Akt IV', 'Saul og David, FS 25: Akt IV', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 7548 AND p.composer_id = 77
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:65e14465-9722-4b2b-bc53-ca81ac3f9d42'
);


-- None Serenata in vano

UPDATE pieces piece
SET piece.title = 'Serenata in vano', piece.title_en = 'Serenata in vano',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 9244 AND piece.composer_id = 77
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None 가곡 <Solen er så rød, mor>

UPDATE pieces piece
SET piece.title = '가곡 <Solen er så rød, mor>', piece.title_en = 'Solen er så rød, mor',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 9427 AND piece.composer_id = 77
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- CNW 237 Som en rejselysten flåde

UPDATE pieces piece
SET piece.title = 'Som en rejselysten flåde', piece.title_en = 'Som en rejselysten flåde, CNW 237',
    piece.type = 'song', piece.opus_number = 'CNW 237',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 10522 AND piece.composer_id = 77
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- Op. 13 현악 4중주 1번 G단조

UPDATE pieces piece
SET piece.title = '현악 4중주 1번 G단조', piece.title_en = 'String Quartet no. 1 in G minor, op. 13',
    piece.type = 'album', piece.opus_number = 'Op. 13',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 10364 AND piece.composer_id = 77
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'Allegro energico', part.name_en = 'String Quartet no. 1 in G minor, op. 13: I. Allegro energico',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 10364 AND p.composer_id = 77 AND part.part_key = 'musicbrainz:81263743-d01e-41d4-91b1-b35afc771e8b' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:81263743-d01e-41d4-91b1-b35afc771e8b', 1, 'I', 'Allegro energico', 'String Quartet no. 1 in G minor, op. 13: I. Allegro energico', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 10364 AND p.composer_id = 77
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:81263743-d01e-41d4-91b1-b35afc771e8b'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'Andante amoroso', part.name_en = 'String Quartet no. 1 in G minor, op. 13: II. Andante amoroso',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 10364 AND p.composer_id = 77 AND part.part_key = 'musicbrainz:4e47fba2-373d-4bb1-b08b-a089099bb783' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:4e47fba2-373d-4bb1-b08b-a089099bb783', 2, 'II', 'Andante amoroso', 'String Quartet no. 1 in G minor, op. 13: II. Andante amoroso', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 10364 AND p.composer_id = 77
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:4e47fba2-373d-4bb1-b08b-a089099bb783'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = 'Scherzo: Allegro molto', part.name_en = 'String Quartet no. 1 in G minor, op. 13: III. Scherzo: Allegro molto',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 10364 AND p.composer_id = 77 AND part.part_key = 'musicbrainz:bc29d463-46be-4f82-9f24-ac05260ee3a5' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:bc29d463-46be-4f82-9f24-ac05260ee3a5', 3, 'III', 'Scherzo: Allegro molto', 'String Quartet no. 1 in G minor, op. 13: III. Scherzo: Allegro molto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 10364 AND p.composer_id = 77
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:bc29d463-46be-4f82-9f24-ac05260ee3a5'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = 'IV',
    part.name_ko = 'Finale: Allegro (inquieto)', part.name_en = 'String Quartet no. 1 in G minor, op. 13: IV. Finale: Allegro (inquieto)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 10364 AND p.composer_id = 77 AND part.part_key = 'musicbrainz:cad4aa25-3410-4004-a160-5997b758a8e7' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:cad4aa25-3410-4004-a160-5997b758a8e7', 4, 'IV', 'Finale: Allegro (inquieto)', 'String Quartet no. 1 in G minor, op. 13: IV. Finale: Allegro (inquieto)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 10364 AND p.composer_id = 77
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:cad4aa25-3410-4004-a160-5997b758a8e7'
);


-- None 현악 4중주 2번 F단조

UPDATE pieces piece
SET piece.title = '현악 4중주 2번 F단조', piece.title_en = 'String Quartet no. 2 in F minor',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 10620 AND piece.composer_id = 77
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'Allegro non troppo ma energico', part.name_en = 'String Quartet in F minor, op. 5: I. Allegro non troppo ma energico',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 10620 AND p.composer_id = 77 AND part.part_key = 'musicbrainz:13cbd926-4bb7-3a0e-834d-1f278450d684' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:13cbd926-4bb7-3a0e-834d-1f278450d684', 1, 'I', 'Allegro non troppo ma energico', 'String Quartet in F minor, op. 5: I. Allegro non troppo ma energico', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 10620 AND p.composer_id = 77
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:13cbd926-4bb7-3a0e-834d-1f278450d684'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'Un poco adagio', part.name_en = 'String Quartet in F minor, op. 5: II. Un poco adagio',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 10620 AND p.composer_id = 77 AND part.part_key = 'musicbrainz:d09cfde0-3e4f-3d9b-9885-dac4854097e9' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:d09cfde0-3e4f-3d9b-9885-dac4854097e9', 2, 'II', 'Un poco adagio', 'String Quartet in F minor, op. 5: II. Un poco adagio', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 10620 AND p.composer_id = 77
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:d09cfde0-3e4f-3d9b-9885-dac4854097e9'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = 'Allegretto scherzando', part.name_en = 'String Quartet in F minor, op. 5: III. Allegretto scherzando',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 10620 AND p.composer_id = 77 AND part.part_key = 'musicbrainz:57254d24-7b80-35c1-a48b-828ed8a79017' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:57254d24-7b80-35c1-a48b-828ed8a79017', 3, 'III', 'Allegretto scherzando', 'String Quartet in F minor, op. 5: III. Allegretto scherzando', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 10620 AND p.composer_id = 77
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:57254d24-7b80-35c1-a48b-828ed8a79017'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = 'IV',
    part.name_ko = 'Allegro appassionato', part.name_en = 'String Quartet in F minor, op. 5: IV. Allegro appassionato',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 10620 AND p.composer_id = 77 AND part.part_key = 'musicbrainz:4771d955-c816-3a08-ab65-095d9a2916e0' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:4771d955-c816-3a08-ab65-095d9a2916e0', 4, 'IV', 'Allegro appassionato', 'String Quartet in F minor, op. 5: IV. Allegro appassionato', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 10620 AND p.composer_id = 77
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:4771d955-c816-3a08-ab65-095d9a2916e0'
);


-- Op. 14 현악 4중주 3번 E♭장조

UPDATE pieces piece
SET piece.title = '현악 4중주 3번 E♭장조', piece.title_en = 'String Quartet no. 3 in E-flat major, op. 14',
    piece.type = 'album', piece.opus_number = 'Op. 14',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 7992 AND piece.composer_id = 77
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'Allegro con brio', part.name_en = 'String Quartet in E-flat major, op. 14: I. Allegro con brio',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 7992 AND p.composer_id = 77 AND part.part_key = 'musicbrainz:b2baa643-9b33-361b-a035-cb9fd9bb2070' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:b2baa643-9b33-361b-a035-cb9fd9bb2070', 1, 'I', 'Allegro con brio', 'String Quartet in E-flat major, op. 14: I. Allegro con brio', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 7992 AND p.composer_id = 77
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:b2baa643-9b33-361b-a035-cb9fd9bb2070'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'Andante sostenuto', part.name_en = 'String Quartet in E-flat major, op. 14: II. Andante sostenuto',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 7992 AND p.composer_id = 77 AND part.part_key = 'musicbrainz:ee9e4bcc-d916-3dc7-80fa-6330f626ed8b' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:ee9e4bcc-d916-3dc7-80fa-6330f626ed8b', 2, 'II', 'Andante sostenuto', 'String Quartet in E-flat major, op. 14: II. Andante sostenuto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 7992 AND p.composer_id = 77
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:ee9e4bcc-d916-3dc7-80fa-6330f626ed8b'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = 'Allegretto pastorale - Presto - Allegretto pastorale', part.name_en = 'String Quartet in E-flat major, op. 14: III. Allegretto pastorale - Presto - Allegretto pastorale',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 7992 AND p.composer_id = 77 AND part.part_key = 'musicbrainz:cc544e49-d063-3001-b3ea-db35c042a9df' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:cc544e49-d063-3001-b3ea-db35c042a9df', 3, 'III', 'Allegretto pastorale - Presto - Allegretto pastorale', 'String Quartet in E-flat major, op. 14: III. Allegretto pastorale - Presto - Allegretto pastorale', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 7992 AND p.composer_id = 77
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:cc544e49-d063-3001-b3ea-db35c042a9df'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = 'IV',
    part.name_ko = 'Allegro coraggioso', part.name_en = 'String Quartet in E-flat major, op. 14: IV. Allegro coraggioso',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 7992 AND p.composer_id = 77 AND part.part_key = 'musicbrainz:92f7a03c-09ec-39c2-a0db-b66ecdea74cc' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:92f7a03c-09ec-39c2-a0db-b66ecdea74cc', 4, 'IV', 'Allegro coraggioso', 'String Quartet in E-flat major, op. 14: IV. Allegro coraggioso', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 7992 AND p.composer_id = 77
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:92f7a03c-09ec-39c2-a0db-b66ecdea74cc'
);


-- Op. 44 현악 4중주 4번 F장조

UPDATE pieces piece
SET piece.title = '현악 4중주 4번 F장조', piece.title_en = 'String Quartet no. 4 in F major, op. 44',
    piece.type = 'album', piece.opus_number = 'Op. 44',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 9512 AND piece.composer_id = 77
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'Allegro non tanto e comodo', part.name_en = 'String Quartet no. 4 in F major, op. 44: I. Allegro non tanto e comodo',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 9512 AND p.composer_id = 77 AND part.part_key = 'musicbrainz:fcd64069-a36c-4ea0-ba8e-6c8e7346582b' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:fcd64069-a36c-4ea0-ba8e-6c8e7346582b', 1, 'I', 'Allegro non tanto e comodo', 'String Quartet no. 4 in F major, op. 44: I. Allegro non tanto e comodo', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 9512 AND p.composer_id = 77
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:fcd64069-a36c-4ea0-ba8e-6c8e7346582b'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'Adagio con sentimento religioso', part.name_en = 'String Quartet no. 4 in F major, op. 44: II. Adagio con sentimento religioso',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 9512 AND p.composer_id = 77 AND part.part_key = 'musicbrainz:313faf41-d10b-4db0-86b7-9f4203da7081' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:313faf41-d10b-4db0-86b7-9f4203da7081', 2, 'II', 'Adagio con sentimento religioso', 'String Quartet no. 4 in F major, op. 44: II. Adagio con sentimento religioso', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 9512 AND p.composer_id = 77
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:313faf41-d10b-4db0-86b7-9f4203da7081'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = 'Allegretto moderato ed innocente', part.name_en = 'String Quartet no. 4 in F major, op. 44: III. Allegretto moderato ed innocente',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 9512 AND p.composer_id = 77 AND part.part_key = 'musicbrainz:803bbb01-6a24-4a38-bdea-ca1a538d13f0' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:803bbb01-6a24-4a38-bdea-ca1a538d13f0', 3, 'III', 'Allegretto moderato ed innocente', 'String Quartet no. 4 in F major, op. 44: III. Allegretto moderato ed innocente', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 9512 AND p.composer_id = 77
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:803bbb01-6a24-4a38-bdea-ca1a538d13f0'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = 'IV',
    part.name_ko = 'Finale: Molto adagio - Allegro non tanto, ma molto scherzoso', part.name_en = 'String Quartet no. 4 in F major, op. 44: IV. Finale: Molto adagio - Allegro non tanto, ma molto scherzoso',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 9512 AND p.composer_id = 77 AND part.part_key = 'musicbrainz:3502a322-8106-45f4-84b5-4a593cafa978' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:3502a322-8106-45f4-84b5-4a593cafa978', 4, 'IV', 'Finale: Molto adagio - Allegro non tanto, ma molto scherzoso', 'String Quartet no. 4 in F major, op. 44: IV. Finale: Molto adagio - Allegro non tanto, ma molto scherzoso', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 9512 AND p.composer_id = 77
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:3502a322-8106-45f4-84b5-4a593cafa978'
);


-- FS 5 현악 5중주 G장조

UPDATE pieces piece
SET piece.title = '현악 5중주 G장조', piece.title_en = 'String Quintet in G major, FS 5',
    piece.type = 'album', piece.opus_number = 'FS 5',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 9123 AND piece.composer_id = 77
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'Allegro pastorale', part.name_en = 'String Quintet in G major, FS 5: I. Allegro pastorale',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 9123 AND p.composer_id = 77 AND part.part_key = 'musicbrainz:4de6f98b-c0be-4231-8163-3fd937d47f3f' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:4de6f98b-c0be-4231-8163-3fd937d47f3f', 1, 'I', 'Allegro pastorale', 'String Quintet in G major, FS 5: I. Allegro pastorale', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 9123 AND p.composer_id = 77
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:4de6f98b-c0be-4231-8163-3fd937d47f3f'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'Adagio', part.name_en = 'String Quintet in G major, FS 5: II. Adagio',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 9123 AND p.composer_id = 77 AND part.part_key = 'musicbrainz:9f5acbcc-ee5b-47bc-97c8-359d0cfc65b3' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:9f5acbcc-ee5b-47bc-97c8-359d0cfc65b3', 2, 'II', 'Adagio', 'String Quintet in G major, FS 5: II. Adagio', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 9123 AND p.composer_id = 77
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:9f5acbcc-ee5b-47bc-97c8-359d0cfc65b3'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = 'Allegretto scherzando', part.name_en = 'String Quintet in G major, FS 5: III. Allegretto scherzando',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 9123 AND p.composer_id = 77 AND part.part_key = 'musicbrainz:0b967983-0055-4b64-8afa-b6d31befbeaa' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:0b967983-0055-4b64-8afa-b6d31befbeaa', 3, 'III', 'Allegretto scherzando', 'String Quintet in G major, FS 5: III. Allegretto scherzando', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 9123 AND p.composer_id = 77
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:0b967983-0055-4b64-8afa-b6d31befbeaa'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = 'IV',
    part.name_ko = 'Finale: Allegro molto', part.name_en = 'String Quintet in G major, FS 5: IV. Finale: Allegro molto',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 9123 AND p.composer_id = 77 AND part.part_key = 'musicbrainz:44be84f8-49ef-4378-aa33-5376f42dcc89' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:44be84f8-49ef-4378-aa33-5376f42dcc89', 4, 'IV', 'Finale: Allegro molto', 'String Quintet in G major, FS 5: IV. Finale: Allegro molto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 9123 AND p.composer_id = 77
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:44be84f8-49ef-4378-aa33-5376f42dcc89'
);


-- Op. 21 Strofiske sange Op. 21

UPDATE pieces piece
SET piece.title = 'Strofiske sange Op. 21', piece.title_en = 'Strofiske sange, op. 21',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = 'Op.', piece.catalogue_number = '21',
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 10725 AND piece.composer_id = 77
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'Skal blomsterne da visne, op. 21 no. 1', part.name_en = 'Skal blomsterne da visne, op. 21 no. 1',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 10725 AND p.composer_id = 77 AND part.part_key = 'musicbrainz:67449b1e-d9d4-4705-b8b7-df4215685c1d' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:67449b1e-d9d4-4705-b8b7-df4215685c1d', 1, NULL, 'Skal blomsterne da visne, op. 21 no. 1', 'Skal blomsterne da visne, op. 21 no. 1', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 10725 AND p.composer_id = 77
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:67449b1e-d9d4-4705-b8b7-df4215685c1d'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'Høgen, op. 21 no. 2', part.name_en = 'Høgen, op. 21 no. 2',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 10725 AND p.composer_id = 77 AND part.part_key = 'musicbrainz:d83a9b6f-e780-4b0e-9e10-07ec5c24ad18' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:d83a9b6f-e780-4b0e-9e10-07ec5c24ad18', 2, NULL, 'Høgen, op. 21 no. 2', 'Høgen, op. 21 no. 2', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 10725 AND p.composer_id = 77
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:d83a9b6f-e780-4b0e-9e10-07ec5c24ad18'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = NULL,
    part.name_ko = 'Jens Vejmand, op. 21 no. 3', part.name_en = 'Jens Vejmand, op. 21 no. 3',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 10725 AND p.composer_id = 77 AND part.part_key = 'musicbrainz:305cbae5-d180-4e31-afd6-dd4518e2e0ed' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:305cbae5-d180-4e31-afd6-dd4518e2e0ed', 3, NULL, 'Jens Vejmand, op. 21 no. 3', 'Jens Vejmand, op. 21 no. 3', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 10725 AND p.composer_id = 77
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:305cbae5-d180-4e31-afd6-dd4518e2e0ed'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = NULL,
    part.name_ko = 'Sænk kun dit hoved, du blomst, op. 21 no. 4', part.name_en = 'Sænk kun dit hoved, du blomst, op. 21 no. 4',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 10725 AND p.composer_id = 77 AND part.part_key = 'musicbrainz:24d4cff6-160c-4c5f-b956-1772640109cd' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:24d4cff6-160c-4c5f-b956-1772640109cd', 4, NULL, 'Sænk kun dit hoved, du blomst, op. 21 no. 4', 'Sænk kun dit hoved, du blomst, op. 21 no. 4', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 10725 AND p.composer_id = 77
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:24d4cff6-160c-4c5f-b956-1772640109cd'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 5, part.movement_number = NULL,
    part.name_ko = 'Den første Lærke, op. 21 no. 5', part.name_en = 'Den første Lærke, op. 21 no. 5',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 10725 AND p.composer_id = 77 AND part.part_key = 'musicbrainz:7025c48e-f236-4657-bc95-b8e03cd0c22c' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:7025c48e-f236-4657-bc95-b8e03cd0c22c', 5, NULL, 'Den første Lærke, op. 21 no. 5', 'Den første Lærke, op. 21 no. 5', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 10725 AND p.composer_id = 77
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:7025c48e-f236-4657-bc95-b8e03cd0c22c'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 6, part.movement_number = NULL,
    part.name_ko = 'Husvild, op. 21 no. 6', part.name_en = 'Husvild, op. 21 no. 6',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 10725 AND p.composer_id = 77 AND part.part_key = 'musicbrainz:6d83e523-b3ea-44ad-bf72-36b0e4cd3c25' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:6d83e523-b3ea-44ad-bf72-36b0e4cd3c25', 6, NULL, 'Husvild, op. 21 no. 6', 'Husvild, op. 21 no. 6', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 10725 AND p.composer_id = 77
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:6d83e523-b3ea-44ad-bf72-36b0e4cd3c25'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 7, part.movement_number = NULL,
    part.name_ko = 'Godnat, op. 21 no. 7', part.name_en = 'Godnat, op. 21 no. 7',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 10725 AND p.composer_id = 77 AND part.part_key = 'musicbrainz:e8ec89df-c675-4867-86fc-ab2d156dfefa' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:e8ec89df-c675-4867-86fc-ab2d156dfefa', 7, NULL, 'Godnat, op. 21 no. 7', 'Godnat, op. 21 no. 7', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 10725 AND p.composer_id = 77
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:e8ec89df-c675-4867-86fc-ab2d156dfefa'
);


-- Op. 45 모음곡 "Den Luciferiske"

UPDATE pieces piece
SET piece.title = '모음곡 "Den Luciferiske"', piece.title_en = 'Suite "Den Luciferiske", op. 45 (FS 91)',
    piece.type = 'album', piece.opus_number = 'Op. 45',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 10866 AND piece.composer_id = 77
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'Allegretto un pochettino', part.name_en = 'Suite "Den Luciferiske", op. 45 (FS 91): I. Allegretto un pochettino',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 10866 AND p.composer_id = 77 AND part.part_key = 'musicbrainz:50d9766d-f414-4055-9411-fb617590b460' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:50d9766d-f414-4055-9411-fb617590b460', 1, 'I', 'Allegretto un pochettino', 'Suite "Den Luciferiske", op. 45 (FS 91): I. Allegretto un pochettino', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 10866 AND p.composer_id = 77
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:50d9766d-f414-4055-9411-fb617590b460'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'Poco moderato', part.name_en = 'Suite "Den Luciferiske", op. 45 (FS 91): II. Poco moderato',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 10866 AND p.composer_id = 77 AND part.part_key = 'musicbrainz:1e498f62-e06e-483d-9911-b1217ec74680' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:1e498f62-e06e-483d-9911-b1217ec74680', 2, 'II', 'Poco moderato', 'Suite "Den Luciferiske", op. 45 (FS 91): II. Poco moderato', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 10866 AND p.composer_id = 77
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:1e498f62-e06e-483d-9911-b1217ec74680'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = 'Molto adagio e patètico', part.name_en = 'Suite "Den Luciferiske", op. 45 (FS 91): III. Molto adagio e patètico',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 10866 AND p.composer_id = 77 AND part.part_key = 'musicbrainz:b20c208d-e06f-47d1-8cc5-d7160e651d08' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:b20c208d-e06f-47d1-8cc5-d7160e651d08', 3, 'III', 'Molto adagio e patètico', 'Suite "Den Luciferiske", op. 45 (FS 91): III. Molto adagio e patètico', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 10866 AND p.composer_id = 77
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:b20c208d-e06f-47d1-8cc5-d7160e651d08'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = 'IV',
    part.name_ko = 'Allegretto innocente', part.name_en = 'Suite "Den Luciferiske", op. 45 (FS 91): IV. Allegretto innocente',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 10866 AND p.composer_id = 77 AND part.part_key = 'musicbrainz:607f7335-40f8-4b1e-8d99-40f02ae7e43f' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:607f7335-40f8-4b1e-8d99-40f02ae7e43f', 4, 'IV', 'Allegretto innocente', 'Suite "Den Luciferiske", op. 45 (FS 91): IV. Allegretto innocente', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 10866 AND p.composer_id = 77
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:607f7335-40f8-4b1e-8d99-40f02ae7e43f'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 5, part.movement_number = 'V',
    part.name_ko = 'Allegretto vivo', part.name_en = 'Suite "Den Luciferiske", op. 45 (FS 91): V. Allegretto vivo',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 10866 AND p.composer_id = 77 AND part.part_key = 'musicbrainz:12254f01-3e2e-4aff-ad25-ae3805475ade' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:12254f01-3e2e-4aff-ad25-ae3805475ade', 5, 'V', 'Allegretto vivo', 'Suite "Den Luciferiske", op. 45 (FS 91): V. Allegretto vivo', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 10866 AND p.composer_id = 77
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:12254f01-3e2e-4aff-ad25-ae3805475ade'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 6, part.movement_number = 'VI',
    part.name_ko = 'Allegro non troppo ma vigoroso', part.name_en = 'Suite "Den Luciferiske", op. 45 (FS 91): VI. Allegro non troppo ma vigoroso',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 10866 AND p.composer_id = 77 AND part.part_key = 'musicbrainz:450005f8-adf9-49db-b176-f2f6cee7aa29' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:450005f8-adf9-49db-b176-f2f6cee7aa29', 6, 'VI', 'Allegro non troppo ma vigoroso', 'Suite "Den Luciferiske", op. 45 (FS 91): VI. Allegro non troppo ma vigoroso', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 10866 AND p.composer_id = 77
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:450005f8-adf9-49db-b176-f2f6cee7aa29'
);


-- Op. 8 Symfonisk Suite

UPDATE pieces piece
SET piece.title = 'Symfonisk Suite', piece.title_en = 'Symfonisk Suite, FS 19, op. 8',
    piece.type = 'album', piece.opus_number = 'Op. 8',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 8948 AND piece.composer_id = 77
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'Intonation. Maestoso', part.name_en = 'Symfonisk Suite, FS 19, op. 8: I. Intonation. Maestoso',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 8948 AND p.composer_id = 77 AND part.part_key = 'musicbrainz:c06a63b5-8cbc-4635-a23f-79d54c896740' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:c06a63b5-8cbc-4635-a23f-79d54c896740', 1, 'I', 'Intonation. Maestoso', 'Symfonisk Suite, FS 19, op. 8: I. Intonation. Maestoso', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 8948 AND p.composer_id = 77
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:c06a63b5-8cbc-4635-a23f-79d54c896740'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'Quasi allegretto', part.name_en = 'Symfonisk Suite, FS 19, op. 8: II. Quasi allegretto',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 8948 AND p.composer_id = 77 AND part.part_key = 'musicbrainz:a5fc4cc1-669a-40da-806f-91807b437c08' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:a5fc4cc1-669a-40da-806f-91807b437c08', 2, 'II', 'Quasi allegretto', 'Symfonisk Suite, FS 19, op. 8: II. Quasi allegretto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 8948 AND p.composer_id = 77
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:a5fc4cc1-669a-40da-806f-91807b437c08'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = 'Andante', part.name_en = 'Symfonisk Suite, FS 19, op. 8: III. Andante',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 8948 AND p.composer_id = 77 AND part.part_key = 'musicbrainz:a762404f-05d1-45ee-9e67-0e58cbd72373' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:a762404f-05d1-45ee-9e67-0e58cbd72373', 3, 'III', 'Andante', 'Symfonisk Suite, FS 19, op. 8: III. Andante', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 8948 AND p.composer_id = 77
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:a762404f-05d1-45ee-9e67-0e58cbd72373'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = 'IV',
    part.name_ko = 'Finale. Allegro', part.name_en = 'Symfonisk Suite, FS 19, op. 8: IV. Finale. Allegro',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 8948 AND p.composer_id = 77 AND part.part_key = 'musicbrainz:0b10556e-2182-47b1-ad79-4550215431c8' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:0b10556e-2182-47b1-ad79-4550215431c8', 4, 'IV', 'Finale. Allegro', 'Symfonisk Suite, FS 19, op. 8: IV. Finale. Allegro', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 8948 AND p.composer_id = 77
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:0b10556e-2182-47b1-ad79-4550215431c8'
);


-- None Symfonisk rhapsodi

UPDATE pieces piece
SET piece.title = 'Symfonisk rhapsodi', piece.title_en = 'Symfonisk rhapsodi',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 7449 AND piece.composer_id = 77
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- Op. 7 교향곡 1번 G단조

UPDATE pieces piece
SET piece.title = '교향곡 1번 G단조', piece.title_en = 'Symphony no. 1, op. 7, FS 16',
    piece.type = 'album', piece.opus_number = 'Op. 7',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 10997 AND piece.composer_id = 77
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'Allegro orgoglioso', part.name_en = 'Symphony no. 1, op. 7, FS 16: I. Allegro orgoglioso',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 10997 AND p.composer_id = 77 AND part.part_key = 'musicbrainz:d6aecefd-b32e-30be-a48b-352931641585' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:d6aecefd-b32e-30be-a48b-352931641585', 1, 'I', 'Allegro orgoglioso', 'Symphony no. 1, op. 7, FS 16: I. Allegro orgoglioso', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 10997 AND p.composer_id = 77
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:d6aecefd-b32e-30be-a48b-352931641585'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'Andante', part.name_en = 'Symphony no. 1, op. 7, FS 16: II. Andante',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 10997 AND p.composer_id = 77 AND part.part_key = 'musicbrainz:6dbc06c7-82c6-3483-a9df-f71c5063ac5a' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:6dbc06c7-82c6-3483-a9df-f71c5063ac5a', 2, 'II', 'Andante', 'Symphony no. 1, op. 7, FS 16: II. Andante', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 10997 AND p.composer_id = 77
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:6dbc06c7-82c6-3483-a9df-f71c5063ac5a'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = 'Allegro comodo – Andante sostenuto – Tempo I', part.name_en = 'Symphony no. 1, op. 7, FS 16: III. Allegro comodo – Andante sostenuto – Tempo I',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 10997 AND p.composer_id = 77 AND part.part_key = 'musicbrainz:f7be7a74-583f-35fb-92db-46c45a9d84bd' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:f7be7a74-583f-35fb-92db-46c45a9d84bd', 3, 'III', 'Allegro comodo – Andante sostenuto – Tempo I', 'Symphony no. 1, op. 7, FS 16: III. Allegro comodo – Andante sostenuto – Tempo I', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 10997 AND p.composer_id = 77
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:f7be7a74-583f-35fb-92db-46c45a9d84bd'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = 'IV',
    part.name_ko = 'Finale: Allegro con fuoco', part.name_en = 'Symphony no. 1, op. 7, FS 16: IV. Finale: Allegro con fuoco',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 10997 AND p.composer_id = 77 AND part.part_key = 'musicbrainz:807d2ec3-ac11-3696-bb7a-52687ce42301' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:807d2ec3-ac11-3696-bb7a-52687ce42301', 4, 'IV', 'Finale: Allegro con fuoco', 'Symphony no. 1, op. 7, FS 16: IV. Finale: Allegro con fuoco', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 10997 AND p.composer_id = 77
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:807d2ec3-ac11-3696-bb7a-52687ce42301'
);


-- None 교향곡 2번 "The Four Temperaments"

UPDATE pieces piece
SET piece.title = '교향곡 2번 "The Four Temperaments"', piece.title_en = 'Symphony no. 2, op. 16, FS 29 “The Four Temperaments”',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 10884 AND piece.composer_id = 77
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'Allegro collerico (Choleric)', part.name_en = 'Symphony no. 2, op. 16, FS 29 “The Four Temperaments”: I. Allegro collerico (Choleric)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 10884 AND p.composer_id = 77 AND part.part_key = 'musicbrainz:b73df6c1-f03b-4b1d-842d-cfa3149219a7' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:b73df6c1-f03b-4b1d-842d-cfa3149219a7', 1, 'I', 'Allegro collerico (Choleric)', 'Symphony no. 2, op. 16, FS 29 “The Four Temperaments”: I. Allegro collerico (Choleric)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 10884 AND p.composer_id = 77
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:b73df6c1-f03b-4b1d-842d-cfa3149219a7'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'Allegro comodo e flemmatico (Phlegmatic)', part.name_en = 'Symphony no. 2, op. 16, FS 29 “The Four Temperaments”: II. Allegro comodo e flemmatico (Phlegmatic)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 10884 AND p.composer_id = 77 AND part.part_key = 'musicbrainz:38f6f799-02f2-4060-b06b-657398fe24be' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:38f6f799-02f2-4060-b06b-657398fe24be', 2, 'II', 'Allegro comodo e flemmatico (Phlegmatic)', 'Symphony no. 2, op. 16, FS 29 “The Four Temperaments”: II. Allegro comodo e flemmatico (Phlegmatic)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 10884 AND p.composer_id = 77
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:38f6f799-02f2-4060-b06b-657398fe24be'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = 'Andante malincolico (Melancholic)', part.name_en = 'Symphony no. 2, op. 16, FS 29 “The Four Temperaments”: III. Andante malincolico (Melancholic)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 10884 AND p.composer_id = 77 AND part.part_key = 'musicbrainz:801108bf-37e5-4ae4-a88f-702c83103d61' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:801108bf-37e5-4ae4-a88f-702c83103d61', 3, 'III', 'Andante malincolico (Melancholic)', 'Symphony no. 2, op. 16, FS 29 “The Four Temperaments”: III. Andante malincolico (Melancholic)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 10884 AND p.composer_id = 77
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:801108bf-37e5-4ae4-a88f-702c83103d61'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = 'IV',
    part.name_ko = 'Allegro sanguineo — Marziale (Sanguine)', part.name_en = 'Symphony no. 2, op. 16, FS 29 “The Four Temperaments”: IV. Allegro sanguineo — Marziale (Sanguine)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 10884 AND p.composer_id = 77 AND part.part_key = 'musicbrainz:e5bf6e33-2788-43ec-a550-072fe6dbe9e7' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:e5bf6e33-2788-43ec-a550-072fe6dbe9e7', 4, 'IV', 'Allegro sanguineo — Marziale (Sanguine)', 'Symphony no. 2, op. 16, FS 29 “The Four Temperaments”: IV. Allegro sanguineo — Marziale (Sanguine)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 10884 AND p.composer_id = 77
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:e5bf6e33-2788-43ec-a550-072fe6dbe9e7'
);


-- Op. 27 교향곡 3번 "Sinfonia Espansiva"

UPDATE pieces piece
SET piece.title = '교향곡 3번 "Sinfonia Espansiva"', piece.title_en = 'Symphony no. 3 "Sinfonia Espansiva", op. 27, FS 60',
    piece.type = 'album', piece.opus_number = 'Op. 27',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 9685 AND piece.composer_id = 77
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'Allegro espansivo', part.name_en = 'Symphony no. 3 "Sinfonia Espansiva", op. 27, FS 60: I. Allegro espansivo',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 9685 AND p.composer_id = 77 AND part.part_key = 'musicbrainz:c5edc506-545c-4ae6-a962-f2790964d554' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:c5edc506-545c-4ae6-a962-f2790964d554', 1, 'I', 'Allegro espansivo', 'Symphony no. 3 "Sinfonia Espansiva", op. 27, FS 60: I. Allegro espansivo', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 9685 AND p.composer_id = 77
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:c5edc506-545c-4ae6-a962-f2790964d554'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'Andante pastorale', part.name_en = 'Symphony no. 3 "Sinfonia Espansiva", op. 27, FS 60: II. Andante pastorale',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 9685 AND p.composer_id = 77 AND part.part_key = 'musicbrainz:fc01092c-6e31-4c83-97bd-b0ce43b70a76' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:fc01092c-6e31-4c83-97bd-b0ce43b70a76', 2, 'II', 'Andante pastorale', 'Symphony no. 3 "Sinfonia Espansiva", op. 27, FS 60: II. Andante pastorale', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 9685 AND p.composer_id = 77
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:fc01092c-6e31-4c83-97bd-b0ce43b70a76'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = 'Allegretto un poco', part.name_en = 'Symphony no. 3 "Sinfonia Espansiva", op. 27, FS 60: III. Allegretto un poco',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 9685 AND p.composer_id = 77 AND part.part_key = 'musicbrainz:678af26d-4e24-4b26-8895-f4ba6bc77fc6' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:678af26d-4e24-4b26-8895-f4ba6bc77fc6', 3, 'III', 'Allegretto un poco', 'Symphony no. 3 "Sinfonia Espansiva", op. 27, FS 60: III. Allegretto un poco', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 9685 AND p.composer_id = 77
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:678af26d-4e24-4b26-8895-f4ba6bc77fc6'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = 'IV',
    part.name_ko = 'Finale: Allegro', part.name_en = 'Symphony no. 3 "Sinfonia Espansiva", op. 27, FS 60: IV. Finale: Allegro',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 9685 AND p.composer_id = 77 AND part.part_key = 'musicbrainz:c1527a14-4668-487b-b8ec-5861fafeabf2' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:c1527a14-4668-487b-b8ec-5861fafeabf2', 4, 'IV', 'Finale: Allegro', 'Symphony no. 3 "Sinfonia Espansiva", op. 27, FS 60: IV. Finale: Allegro', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 9685 AND p.composer_id = 77
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:c1527a14-4668-487b-b8ec-5861fafeabf2'
);


-- None 교향곡 4번 "The Inextinguishable"

UPDATE pieces piece
SET piece.title = '교향곡 4번 "The Inextinguishable"', piece.title_en = 'Symphony no. 4, op. 29, FS 76 “The Inextinguishable”',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 10796 AND piece.composer_id = 77
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'Allegro', part.name_en = 'Symphony no. 4, op. 29, FS 76 “The Inextinguishable”: I. Allegro',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 10796 AND p.composer_id = 77 AND part.part_key = 'musicbrainz:ef9aca90-d2a2-4a78-b3dd-52534b84afe4' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:ef9aca90-d2a2-4a78-b3dd-52534b84afe4', 1, 'I', 'Allegro', 'Symphony no. 4, op. 29, FS 76 “The Inextinguishable”: I. Allegro', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 10796 AND p.composer_id = 77
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:ef9aca90-d2a2-4a78-b3dd-52534b84afe4'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'Poco allegretto', part.name_en = 'Symphony no. 4, op. 29, FS 76 “The Inextinguishable”: II. Poco allegretto',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 10796 AND p.composer_id = 77 AND part.part_key = 'musicbrainz:cf16c311-5da7-48aa-b01b-c3dd1b250d0f' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:cf16c311-5da7-48aa-b01b-c3dd1b250d0f', 2, 'II', 'Poco allegretto', 'Symphony no. 4, op. 29, FS 76 “The Inextinguishable”: II. Poco allegretto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 10796 AND p.composer_id = 77
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:cf16c311-5da7-48aa-b01b-c3dd1b250d0f'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = 'Poco adagio quasi andante', part.name_en = 'Symphony no. 4, op. 29, FS 76 “The Inextinguishable”: III. Poco adagio quasi andante',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 10796 AND p.composer_id = 77 AND part.part_key = 'musicbrainz:2feb38db-8f6b-4dfb-afe5-3e608be11f9e' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:2feb38db-8f6b-4dfb-afe5-3e608be11f9e', 3, 'III', 'Poco adagio quasi andante', 'Symphony no. 4, op. 29, FS 76 “The Inextinguishable”: III. Poco adagio quasi andante', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 10796 AND p.composer_id = 77
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:2feb38db-8f6b-4dfb-afe5-3e608be11f9e'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = 'IV',
    part.name_ko = 'Con anima – Allegro', part.name_en = 'Symphony no. 4, op. 29, FS 76 “The Inextinguishable”: IV. Con anima – Allegro',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 10796 AND p.composer_id = 77 AND part.part_key = 'musicbrainz:e1136d52-a43a-4f0e-afe0-8f5f49d45e57' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:e1136d52-a43a-4f0e-afe0-8f5f49d45e57', 4, 'IV', 'Con anima – Allegro', 'Symphony no. 4, op. 29, FS 76 “The Inextinguishable”: IV. Con anima – Allegro', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 10796 AND p.composer_id = 77
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:e1136d52-a43a-4f0e-afe0-8f5f49d45e57'
);


-- Op. 50 교향곡 5번

UPDATE pieces piece
SET piece.title = '교향곡 5번', piece.title_en = 'Symphony no. 5, op. 50',
    piece.type = 'album', piece.opus_number = 'Op. 50',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 9593 AND piece.composer_id = 77
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'Tempo giusto – Adagio non troppo', part.name_en = 'Symphony no. 5, op. 50: I. Tempo giusto – Adagio non troppo',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 9593 AND p.composer_id = 77 AND part.part_key = 'musicbrainz:2fb692ad-9b99-4772-abd8-d64adbb80ba8' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:2fb692ad-9b99-4772-abd8-d64adbb80ba8', 1, 'I', 'Tempo giusto – Adagio non troppo', 'Symphony no. 5, op. 50: I. Tempo giusto – Adagio non troppo', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 9593 AND p.composer_id = 77
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:2fb692ad-9b99-4772-abd8-d64adbb80ba8'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'Allegro – Presto – Andante un poco tranquillo – Allegro', part.name_en = 'Symphony no. 5, op. 50: II. Allegro – Presto – Andante un poco tranquillo – Allegro',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 9593 AND p.composer_id = 77 AND part.part_key = 'musicbrainz:b3d5938d-a41e-42b4-8a8c-1f2608a3077d' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:b3d5938d-a41e-42b4-8a8c-1f2608a3077d', 2, 'II', 'Allegro – Presto – Andante un poco tranquillo – Allegro', 'Symphony no. 5, op. 50: II. Allegro – Presto – Andante un poco tranquillo – Allegro', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 9593 AND p.composer_id = 77
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:b3d5938d-a41e-42b4-8a8c-1f2608a3077d'
);


-- None 교향곡 6번 "Sinfonia semplice"

UPDATE pieces piece
SET piece.title = '교향곡 6번 "Sinfonia semplice"', piece.title_en = 'Symphony no. 6, FS 116 "Sinfonia semplice"',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 10684 AND piece.composer_id = 77
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'Tempo giusto', part.name_en = 'Symphony no. 6, FS 116 "Sinfonia semplice": I. Tempo giusto',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 10684 AND p.composer_id = 77 AND part.part_key = 'musicbrainz:b15fe4c9-78f8-3ca5-90a3-a47e6d3a8f21' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:b15fe4c9-78f8-3ca5-90a3-a47e6d3a8f21', 1, 'I', 'Tempo giusto', 'Symphony no. 6, FS 116 "Sinfonia semplice": I. Tempo giusto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 10684 AND p.composer_id = 77
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:b15fe4c9-78f8-3ca5-90a3-a47e6d3a8f21'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'Humoresque: Allegretto', part.name_en = 'Symphony no. 6, FS 116 "Sinfonia semplice": II. Humoresque: Allegretto',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 10684 AND p.composer_id = 77 AND part.part_key = 'musicbrainz:41531e5a-e738-3bef-986b-ddb4be8f4097' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:41531e5a-e738-3bef-986b-ddb4be8f4097', 2, 'II', 'Humoresque: Allegretto', 'Symphony no. 6, FS 116 "Sinfonia semplice": II. Humoresque: Allegretto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 10684 AND p.composer_id = 77
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:41531e5a-e738-3bef-986b-ddb4be8f4097'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = 'Proposta seria: Adagio', part.name_en = 'Symphony no. 6, FS 116 "Sinfonia semplice": III. Proposta seria: Adagio',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 10684 AND p.composer_id = 77 AND part.part_key = 'musicbrainz:6cd65937-2820-34d1-bf43-7b1c977655b3' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:6cd65937-2820-34d1-bf43-7b1c977655b3', 3, 'III', 'Proposta seria: Adagio', 'Symphony no. 6, FS 116 "Sinfonia semplice": III. Proposta seria: Adagio', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 10684 AND p.composer_id = 77
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:6cd65937-2820-34d1-bf43-7b1c977655b3'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = 'IV',
    part.name_ko = 'Theme and Variations', part.name_en = 'Symphony no. 6, FS 116 "Sinfonia semplice": IV. Theme and Variations',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 10684 AND p.composer_id = 77 AND part.part_key = 'musicbrainz:034ef5fc-bc9b-32b4-85ce-712ee0759ed1' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:034ef5fc-bc9b-32b4-85ce-712ee0759ed1', 4, 'IV', 'Theme and Variations', 'Symphony no. 6, FS 116 "Sinfonia semplice": IV. Theme and Variations', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 10684 AND p.composer_id = 77
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:034ef5fc-bc9b-32b4-85ce-712ee0759ed1'
);


-- Op. 18 Søvnen

UPDATE pieces piece
SET piece.title = 'Søvnen', piece.title_en = 'Søvnen, op. 18',
    piece.type = 'album', piece.opus_number = 'Op. 18',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 9816 AND piece.composer_id = 77
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'Milde søvnen, du store Moder', part.name_en = 'Søvnen, op. 18: I. Milde søvnen, du store Moder',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 9816 AND p.composer_id = 77 AND part.part_key = 'musicbrainz:5a990ab8-5f96-42b5-96ec-5999d9a224f6' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:5a990ab8-5f96-42b5-96ec-5999d9a224f6', 1, 'I', 'Milde søvnen, du store Moder', 'Søvnen, op. 18: I. Milde søvnen, du store Moder', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 9816 AND p.composer_id = 77
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:5a990ab8-5f96-42b5-96ec-5999d9a224f6'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'En Kval - en Tunge... Ve mig - er jeg vaagen?', part.name_en = 'Søvnen, op. 18: II. En Kval - en Tunge... Ve mig - er jeg vaagen?',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 9816 AND p.composer_id = 77 AND part.part_key = 'musicbrainz:e738e631-a27b-45bc-ae23-17862c35a1fc' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:e738e631-a27b-45bc-ae23-17862c35a1fc', 2, 'II', 'En Kval - en Tunge... Ve mig - er jeg vaagen?', 'Søvnen, op. 18: II. En Kval - en Tunge... Ve mig - er jeg vaagen?', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 9816 AND p.composer_id = 77
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:e738e631-a27b-45bc-ae23-17862c35a1fc'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = 'Drømme svinder, syner falme', part.name_en = 'Søvnen, op. 18: III. Drømme svinder, syner falme',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 9816 AND p.composer_id = 77 AND part.part_key = 'musicbrainz:6c41eb8f-bee4-4081-a192-180dc3083d37' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:6c41eb8f-bee4-4081-a192-180dc3083d37', 3, 'III', 'Drømme svinder, syner falme', 'Søvnen, op. 18: III. Drømme svinder, syner falme', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 9816 AND p.composer_id = 77
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:6c41eb8f-bee4-4081-a192-180dc3083d37'
);


-- Op. 40 Tema med variationer

UPDATE pieces piece
SET piece.title = 'Tema med variationer', piece.title_en = 'Tema med variationer, FS 81, op. 40',
    piece.type = 'song', piece.opus_number = 'Op. 40',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 9739 AND piece.composer_id = 77
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- Op. 40 주제와 변주

UPDATE pieces piece
SET piece.title = '주제와 변주', piece.title_en = 'Theme and Variations, op. 40',
    piece.type = 'song', piece.opus_number = 'Op. 40',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 11086 AND piece.composer_id = 77
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- FS 137 To præludier FS 137

UPDATE pieces piece
SET piece.title = 'To præludier FS 137', piece.title_en = 'To præludier, FS 137, CNW 98',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = 'FS', piece.catalogue_number = '137',
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 7615 AND piece.composer_id = 77
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'No. 1', part.name_en = 'To præludier, FS 137, CNW 98: No. 1',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 7615 AND p.composer_id = 77 AND part.part_key = 'musicbrainz:b9cd5c13-2cf1-4830-8796-edf035d68f74' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:b9cd5c13-2cf1-4830-8796-edf035d68f74', 1, NULL, 'No. 1', 'To præludier, FS 137, CNW 98: No. 1', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 7615 AND p.composer_id = 77
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:b9cd5c13-2cf1-4830-8796-edf035d68f74'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'No. 2', part.name_en = 'To præludier, FS 137, CNW 98: No. 2',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 7615 AND p.composer_id = 77 AND part.part_key = 'musicbrainz:16a1578d-889c-4766-8c2c-dde78b8f03d0' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:16a1578d-889c-4766-8c2c-dde78b8f03d0', 2, NULL, 'No. 2', 'To præludier, FS 137, CNW 98: No. 2', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 7615 AND p.composer_id = 77
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:16a1578d-889c-4766-8c2c-dde78b8f03d0'
);


-- Op. 59 Tre Klaverstykker

UPDATE pieces piece
SET piece.title = 'Tre Klaverstykker', piece.title_en = 'Tre Klaverstykker, FS 131, op. 59',
    piece.type = 'album', piece.opus_number = 'Op. 59',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 10659 AND piece.composer_id = 77
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'Impromptu', part.name_en = 'Tre Klaverstykker, FS 131, op. 59: I. Impromptu',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 10659 AND p.composer_id = 77 AND part.part_key = 'musicbrainz:557f0e9f-ab4a-4db9-99c0-24195a810932' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:557f0e9f-ab4a-4db9-99c0-24195a810932', 1, 'I', 'Impromptu', 'Tre Klaverstykker, FS 131, op. 59: I. Impromptu', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 10659 AND p.composer_id = 77
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:557f0e9f-ab4a-4db9-99c0-24195a810932'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'Molto adagio', part.name_en = 'Tre Klaverstykker, FS 131, op. 59: II. Molto adagio',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 10659 AND p.composer_id = 77 AND part.part_key = 'musicbrainz:4f69e00e-3fe1-448d-adbf-053193d36444' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:4f69e00e-3fe1-448d-adbf-053193d36444', 2, 'II', 'Molto adagio', 'Tre Klaverstykker, FS 131, op. 59: II. Molto adagio', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 10659 AND p.composer_id = 77
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:4f69e00e-3fe1-448d-adbf-053193d36444'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = 'Allegro non troppo', part.name_en = 'Tre Klaverstykker, FS 131, op. 59: III. Allegro non troppo',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 10659 AND p.composer_id = 77 AND part.part_key = 'musicbrainz:5536488c-3d4e-4457-8897-8b1d69ba035b' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:5536488c-3d4e-4457-8897-8b1d69ba035b', 3, 'III', 'Allegro non troppo', 'Tre Klaverstykker, FS 131, op. 59: III. Allegro non troppo', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 10659 AND p.composer_id = 77
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:5536488c-3d4e-4457-8897-8b1d69ba035b'
);


-- Op. 55 Tre motetter Op. 55

UPDATE pieces piece
SET piece.title = 'Tre motetter Op. 55', piece.title_en = 'Tre motetter, op. 55',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = 'Op.', piece.catalogue_number = '55',
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 7920 AND piece.composer_id = 77
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'Afflictus sum, op. 55 no. 1', part.name_en = 'Afflictus sum, op. 55 no. 1',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 7920 AND p.composer_id = 77 AND part.part_key = 'musicbrainz:07281123-fd15-4669-acde-7e05573cebb8' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:07281123-fd15-4669-acde-7e05573cebb8', 1, NULL, 'Afflictus sum, op. 55 no. 1', 'Afflictus sum, op. 55 no. 1', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 7920 AND p.composer_id = 77
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:07281123-fd15-4669-acde-7e05573cebb8'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'Dominus regit me, op. 55 no. 2', part.name_en = 'Dominus regit me, op. 55 no. 2',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 7920 AND p.composer_id = 77 AND part.part_key = 'musicbrainz:8bb8b80d-d26d-4a3a-9a6b-63cee1b7f5db' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:8bb8b80d-d26d-4a3a-9a6b-63cee1b7f5db', 2, NULL, 'Dominus regit me, op. 55 no. 2', 'Dominus regit me, op. 55 no. 2', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 7920 AND p.composer_id = 77
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:8bb8b80d-d26d-4a3a-9a6b-63cee1b7f5db'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = NULL,
    part.name_ko = 'Benedictus Dominus, op. 55 no. 3', part.name_en = 'Benedictus Dominus, op. 55 no. 3',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 7920 AND p.composer_id = 77 AND part.part_key = 'musicbrainz:1ce272ea-2bec-4f58-a8b5-1e2ac1b8947e' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:1ce272ea-2bec-4f58-a8b5-1e2ac1b8947e', 3, NULL, 'Benedictus Dominus, op. 55 no. 3', 'Benedictus Dominus, op. 55 no. 3', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 7920 AND p.composer_id = 77
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:1ce272ea-2bec-4f58-a8b5-1e2ac1b8947e'
);


-- CNW 250 Tunge, mørke natteskyer

UPDATE pieces piece
SET piece.title = 'Tunge, mørke natteskyer', piece.title_en = 'Tunge, mørke natteskyer, CNW 250',
    piece.type = 'song', piece.opus_number = 'CNW 250',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 9005 AND piece.composer_id = 77
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- CNW 253 가곡 <Udrundne er de gamle dage>

UPDATE pieces piece
SET piece.title = '가곡 <Udrundne er de gamle dage>', piece.title_en = 'Udrundne er de gamle dage, CNW 253',
    piece.type = 'song', piece.opus_number = 'CNW 253',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 9700 AND piece.composer_id = 77
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- FS 58 Ved en ung kunstners baare

UPDATE pieces piece
SET piece.title = 'Ved en ung kunstners baare', piece.title_en = 'Ved en ung kunstners baare, FS 58',
    piece.type = 'song', piece.opus_number = 'FS 58',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 7549 AND piece.composer_id = 77
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- CNW 147 가곡 <Vi sletternes sønner har drømme i sind>

UPDATE pieces piece
SET piece.title = '가곡 <Vi sletternes sønner har drømme i sind>', piece.title_en = 'Vi sletternes sønner har drømme i sind, CNW 147',
    piece.type = 'song', piece.opus_number = 'CNW 147',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 10867 AND piece.composer_id = 77
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- Op. 9 바이올린 소나타 1번 A장조

UPDATE pieces piece
SET piece.title = '바이올린 소나타 1번 A장조', piece.title_en = 'Violin Sonata no. 1 in A major, op. 9',
    piece.type = 'album', piece.opus_number = 'Op. 9',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 8239 AND piece.composer_id = 77
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'Allegro glorioso', part.name_en = 'Violin Sonata no. 1 in A major, op. 9: I. Allegro glorioso',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 8239 AND p.composer_id = 77 AND part.part_key = 'musicbrainz:e48c9355-3323-4af8-9bfe-8eae9772ba18' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:e48c9355-3323-4af8-9bfe-8eae9772ba18', 1, 'I', 'Allegro glorioso', 'Violin Sonata no. 1 in A major, op. 9: I. Allegro glorioso', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 8239 AND p.composer_id = 77
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:e48c9355-3323-4af8-9bfe-8eae9772ba18'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'Andante', part.name_en = 'Violin Sonata no. 1 in A major, op. 9: II. Andante',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 8239 AND p.composer_id = 77 AND part.part_key = 'musicbrainz:95b0fc11-3207-49d4-a0c8-b98b31be3763' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:95b0fc11-3207-49d4-a0c8-b98b31be3763', 2, 'II', 'Andante', 'Violin Sonata no. 1 in A major, op. 9: II. Andante', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 8239 AND p.composer_id = 77
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:95b0fc11-3207-49d4-a0c8-b98b31be3763'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = 'Allegro piacevole è giovanile', part.name_en = 'Violin Sonata no. 1 in A major, op. 9: III. Allegro piacevole è giovanile',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 8239 AND p.composer_id = 77 AND part.part_key = 'musicbrainz:c49e84e2-764d-47db-a0c6-caf02cfd4bdf' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:c49e84e2-764d-47db-a0c6-caf02cfd4bdf', 3, 'III', 'Allegro piacevole è giovanile', 'Violin Sonata no. 1 in A major, op. 9: III. Allegro piacevole è giovanile', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 8239 AND p.composer_id = 77
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:c49e84e2-764d-47db-a0c6-caf02cfd4bdf'
);


-- Op. 35 바이올린 소나타 2번

UPDATE pieces piece
SET piece.title = '바이올린 소나타 2번', piece.title_en = 'Violin Sonata no. 2, op. 35',
    piece.type = 'album', piece.opus_number = 'Op. 35',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 8125 AND piece.composer_id = 77
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'Allegro', part.name_en = 'Violin Sonata no. 2, op. 35: I. Allegro',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 8125 AND p.composer_id = 77 AND part.part_key = 'musicbrainz:d795bdf8-5322-42e8-9971-5051876fc4ad' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:d795bdf8-5322-42e8-9971-5051876fc4ad', 1, 'I', 'Allegro', 'Violin Sonata no. 2, op. 35: I. Allegro', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 8125 AND p.composer_id = 77
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:d795bdf8-5322-42e8-9971-5051876fc4ad'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'Molto adagio', part.name_en = 'Violin Sonata no. 2, op. 35: II. Molto adagio',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 8125 AND p.composer_id = 77 AND part.part_key = 'musicbrainz:be728994-22b7-43ca-ae80-3e3f065eb438' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:be728994-22b7-43ca-ae80-3e3f065eb438', 2, 'II', 'Molto adagio', 'Violin Sonata no. 2, op. 35: II. Molto adagio', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 8125 AND p.composer_id = 77
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:be728994-22b7-43ca-ae80-3e3f065eb438'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = 'Allegro piacevole', part.name_en = 'Violin Sonata no. 2, op. 35: III. Allegro piacevole',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 8125 AND p.composer_id = 77 AND part.part_key = 'musicbrainz:16dcae4b-0526-4083-9fd2-eed0047af692' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:16dcae4b-0526-4083-9fd2-eed0047af692', 3, 'III', 'Allegro piacevole', 'Violin Sonata no. 2, op. 35: III. Allegro piacevole', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 8125 AND p.composer_id = 77
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:16dcae4b-0526-4083-9fd2-eed0047af692'
);


-- Op. 6 Viser og vers af J.P. Jacobsen Op. 6

UPDATE pieces piece
SET piece.title = 'Viser og vers af J.P. Jacobsen Op. 6', piece.title_en = 'Viser og vers af J.P. Jacobsen, op. 6',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = 'Op.', piece.catalogue_number = '6',
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 9151 AND piece.composer_id = 77
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'Genrebillede, op. 6 no. 1', part.name_en = 'Genrebillede, op. 6 no. 1',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 9151 AND p.composer_id = 77 AND part.part_key = 'musicbrainz:baa2df68-60a7-48e6-9bd5-5b34dee1b556' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:baa2df68-60a7-48e6-9bd5-5b34dee1b556', 1, NULL, 'Genrebillede, op. 6 no. 1', 'Genrebillede, op. 6 no. 1', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 9151 AND p.composer_id = 77
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:baa2df68-60a7-48e6-9bd5-5b34dee1b556'
);


-- CNW 317 Vocalise-Étude

UPDATE pieces piece
SET piece.title = 'Vocalise-Étude', piece.title_en = 'Vocalise-Étude, CNW 317',
    piece.type = 'song', piece.opus_number = 'CNW 317',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 7814 AND piece.composer_id = 77
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None 가곡 <Åh, hvor er jeg glad i dag>

UPDATE pieces piece
SET piece.title = '가곡 <Åh, hvor er jeg glad i dag>', piece.title_en = 'Åh, hvor er jeg glad i dag',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 8484 AND piece.composer_id = 77
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- FS 24 Festive Prelude to the New Century

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, 'Festive Prelude to the New Century', 'Festive Prelude to the New Century, FS 24', 'song', 'FS 24', NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 77
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = 'Festive Prelude to the New Century'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '5e3442d0-a628-47e8-8873-36ec64aef8d6'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '5e3442d0-a628-47e8-8873-36ec64aef8d6'
FROM pieces p
WHERE p.composer_id = 77 AND p.title = 'Festive Prelude to the New Century' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '5e3442d0-a628-47e8-8873-36ec64aef8d6'
);


-- CNW 262 가곡 <Jeg ved en lærkerede>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '가곡 <Jeg ved en lærkerede>', 'Jeg ved en lærkerede, CNW 262', 'song', 'CNW 262', NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 77
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '가곡 <Jeg ved en lærkerede>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'f484e0fb-2103-49a2-a03e-063eca67901f'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'f484e0fb-2103-49a2-a03e-063eca67901f'
FROM pieces p
WHERE p.composer_id = 77 AND p.title = '가곡 <Jeg ved en lærkerede>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'f484e0fb-2103-49a2-a03e-063eca67901f'
);


-- CNW 361 가곡 <Paaske-Liljen>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '가곡 <Paaske-Liljen>', 'Paaske-Liljen, CNW 361', 'song', 'CNW 361', NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 77
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '가곡 <Paaske-Liljen>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '5567392b-5f39-4bba-8615-16509a88624b'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '5567392b-5f39-4bba-8615-16509a88624b'
FROM pieces p
WHERE p.composer_id = 77 AND p.title = '가곡 <Paaske-Liljen>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '5567392b-5f39-4bba-8615-16509a88624b'
);


-- Op. 2 Romanze und Humoreske für Oboe und Klavier Op. 2

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, 'Romanze und Humoreske für Oboe und Klavier Op. 2', 'Romanze und Humoreske für Oboe und Klavier, op. 2', 'album', NULL, 'Op.', '2', NULL, 'manual', 1
FROM composers c
WHERE c.id = 77
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = 'Romanze und Humoreske für Oboe und Klavier Op. 2'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '3330bed8-6d43-4f51-85f3-3fd71e772a5b'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '3330bed8-6d43-4f51-85f3-3fd71e772a5b'
FROM pieces p
WHERE p.composer_id = 77 AND p.title = 'Romanze und Humoreske für Oboe und Klavier Op. 2' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '3330bed8-6d43-4f51-85f3-3fd71e772a5b'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:d4b13dc7-3ea9-4f0b-9b57-f79ff3d7c89f', 1, NULL, 'Humoreske. Allegretto scherzando', 'Romanze und Humoreske für Oboe und Klavier, op. 2: Humoreske. Allegretto scherzando', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 77 AND p.title = 'Romanze und Humoreske für Oboe und Klavier Op. 2' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:d4b13dc7-3ea9-4f0b-9b57-f79ff3d7c89f'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:da3b55b0-5716-4be3-a559-40a5e3adaae0', 2, NULL, 'Romanze. Andante con brio', 'Romanze und Humoreske für Oboe und Klavier, op. 2: Romanze. Andante con brio', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 77 AND p.title = 'Romanze und Humoreske für Oboe und Klavier Op. 2' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:da3b55b0-5716-4be3-a559-40a5e3adaae0'
);


-- None Underlige aftenlufte

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, 'Underlige aftenlufte', 'Underlige aftenlufte', 'song', NULL, NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 77
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = 'Underlige aftenlufte'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'd842f4bd-810f-4804-a885-3f2780aa39b0'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'd842f4bd-810f-4804-a885-3f2780aa39b0'
FROM pieces p
WHERE p.composer_id = 77 AND p.title = 'Underlige aftenlufte' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'd842f4bd-810f-4804-a885-3f2780aa39b0'
);


-- 카탈로그에 대응이 없는 seed 작품 10개를 목록에서 숨긴다(지우지 않음).
UPDATE pieces piece
SET piece.hidden_reason = 'catalog_unmatched'
WHERE piece.composer_id = 77 AND piece.origin = 'seed' AND piece.hidden_reason IS NULL
  AND piece.id IN (
    658, 7612, 7995, 8651, 8847, 8869, 9202, 10178, 10458, 11161
  )
  AND NOT EXISTS (SELECT 1 FROM performance_sectors sector WHERE sector.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM piece_parts linking WHERE linking.linked_piece_id = piece.id);
