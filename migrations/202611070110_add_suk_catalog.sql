-- 요제프 수크 작품을 MusicBrainz 작품 구조로 다시 짠다(5차 자동). 작품 42개(묶음 5, 다악장 18, 낱곡 19),
-- 새 작품 1개, part 106개, 그 아래 0개.
-- seed 43개 중 41개를 작품·part 에 잇고, 1개를 숨기고, 1개는 그대로 둔다.
--
-- 5차는 4차 규칙(사람·에이전트 판단 없음)을 그대로 썼다. 규칙은
-- seed_pipeline/curation/catalog-wave4-2026-10-12/auto/auto_catalog.py, 작곡가별 자료는
-- seed_pipeline/curation/catalog-wave5-2026-11-07/<작곡가>/(catalog.json·seed_map.json).
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

-- Op. 15 10개의 가곡 Op. 15

UPDATE pieces piece
SET piece.title = '10개의 가곡 Op. 15', piece.title_en = '10 Songs for Female voices and Piano Four Hands, op. 15',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = 'Op.', piece.catalogue_number = '15',
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 16948 AND piece.composer_id = 207
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'Žal', part.name_en = '10 Songs for Female voices and Piano Four Hands, op. 15: 1. Žal',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 16948 AND p.composer_id = 207 AND part.part_key = 'musicbrainz:64dc5ec3-a39d-425a-94cf-9a6f9720c16a' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:64dc5ec3-a39d-425a-94cf-9a6f9720c16a', 1, NULL, 'Žal', '10 Songs for Female voices and Piano Four Hands, op. 15: 1. Žal', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 16948 AND p.composer_id = 207
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:64dc5ec3-a39d-425a-94cf-9a6f9720c16a'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'Tužba', part.name_en = '10 Songs for Female voices and Piano Four Hands, op. 15: 2. Tužba',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 16948 AND p.composer_id = 207 AND part.part_key = 'musicbrainz:c110a100-9b3b-4eaa-9a82-b87e60054ca0' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:c110a100-9b3b-4eaa-9a82-b87e60054ca0', 2, NULL, 'Tužba', '10 Songs for Female voices and Piano Four Hands, op. 15: 2. Tužba', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 16948 AND p.composer_id = 207
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:c110a100-9b3b-4eaa-9a82-b87e60054ca0'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = NULL,
    part.name_ko = 'Společný hrob', part.name_en = '10 Songs for Female voices and Piano Four Hands, op. 15: 3. Společný hrob',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 16948 AND p.composer_id = 207 AND part.part_key = 'musicbrainz:69811f2b-593a-4d54-bc32-0bc2f287041e' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:69811f2b-593a-4d54-bc32-0bc2f287041e', 3, NULL, 'Společný hrob', '10 Songs for Female voices and Piano Four Hands, op. 15: 3. Společný hrob', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 16948 AND p.composer_id = 207
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:69811f2b-593a-4d54-bc32-0bc2f287041e'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = NULL,
    part.name_ko = 'Pastýři na jaro', part.name_en = '10 Songs for Female voices and Piano Four Hands, op. 15: 4. Pastýři na jaro',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 16948 AND p.composer_id = 207 AND part.part_key = 'musicbrainz:13d679ca-2f84-428e-8dfc-9a2118fd6edb' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:13d679ca-2f84-428e-8dfc-9a2118fd6edb', 4, NULL, 'Pastýři na jaro', '10 Songs for Female voices and Piano Four Hands, op. 15: 4. Pastýři na jaro', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 16948 AND p.composer_id = 207
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:13d679ca-2f84-428e-8dfc-9a2118fd6edb'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 5, part.movement_number = NULL,
    part.name_ko = 'Divná voda', part.name_en = '10 Songs for Female voices and Piano Four Hands, op. 15: 5. Divná voda',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 16948 AND p.composer_id = 207 AND part.part_key = 'musicbrainz:cbbc1cca-f75f-4760-a2de-9432d6d0a02d' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:cbbc1cca-f75f-4760-a2de-9432d6d0a02d', 5, NULL, 'Divná voda', '10 Songs for Female voices and Piano Four Hands, op. 15: 5. Divná voda', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 16948 AND p.composer_id = 207
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:cbbc1cca-f75f-4760-a2de-9432d6d0a02d'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 6, part.movement_number = NULL,
    part.name_ko = 'Víly', part.name_en = '10 Songs for Female voices and Piano Four Hands, op. 15: 6. Víly',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 16948 AND p.composer_id = 207 AND part.part_key = 'musicbrainz:74730fc5-51fb-471d-b8b5-bc5b7ca82423' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:74730fc5-51fb-471d-b8b5-bc5b7ca82423', 6, NULL, 'Víly', '10 Songs for Female voices and Piano Four Hands, op. 15: 6. Víly', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 16948 AND p.composer_id = 207
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:74730fc5-51fb-471d-b8b5-bc5b7ca82423'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 7, part.movement_number = NULL,
    part.name_ko = 'Pastýř a pastýřka', part.name_en = '10 Songs for Female voices and Piano Four Hands, op. 15: 7. Pastýř a pastýřka',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 16948 AND p.composer_id = 207 AND part.part_key = 'musicbrainz:d194bdca-ba5d-48d3-8857-2cea2cde6a07' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:d194bdca-ba5d-48d3-8857-2cea2cde6a07', 7, NULL, 'Pastýř a pastýřka', '10 Songs for Female voices and Piano Four Hands, op. 15: 7. Pastýř a pastýřka', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 16948 AND p.composer_id = 207
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:d194bdca-ba5d-48d3-8857-2cea2cde6a07'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 8, part.movement_number = NULL,
    part.name_ko = 'Zpomínky', part.name_en = '10 Songs for Female voices and Piano Four Hands, op. 15: 8. Zpomínky',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 16948 AND p.composer_id = 207 AND part.part_key = 'musicbrainz:bb6569e1-d7dc-4562-b32c-55a314c715cd' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:bb6569e1-d7dc-4562-b32c-55a314c715cd', 8, NULL, 'Zpomínky', '10 Songs for Female voices and Piano Four Hands, op. 15: 8. Zpomínky', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 16948 AND p.composer_id = 207
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:bb6569e1-d7dc-4562-b32c-55a314c715cd'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 9, part.movement_number = NULL,
    part.name_ko = 'Choutka po vdaní', part.name_en = '10 Songs for Female voices and Piano Four Hands, op. 15: 9. Choutka po vdaní',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 16948 AND p.composer_id = 207 AND part.part_key = 'musicbrainz:f285718c-64ab-45ef-84c6-c3f843b4e7bd' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:f285718c-64ab-45ef-84c6-c3f843b4e7bd', 9, NULL, 'Choutka po vdaní', '10 Songs for Female voices and Piano Four Hands, op. 15: 9. Choutka po vdaní', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 16948 AND p.composer_id = 207
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:f285718c-64ab-45ef-84c6-c3f843b4e7bd'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 10, part.movement_number = NULL,
    part.name_ko = 'Kéž by věděli', part.name_en = '10 Songs for Female voices and Piano Four Hands, op. 15: 10. Kéž by věděli',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 16948 AND p.composer_id = 207 AND part.part_key = 'musicbrainz:111c45de-729e-4506-8be8-6b907e878495' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:111c45de-729e-4506-8be8-6b907e878495', 10, NULL, 'Kéž by věděli', '10 Songs for Female voices and Piano Four Hands, op. 15: 10. Kéž by věděli', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 16948 AND p.composer_id = 207
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:111c45de-729e-4506-8be8-6b907e878495'
);


-- Op. 3 2 Skladby Op. 3

UPDATE pieces piece
SET piece.title = '2 Skladby Op. 3', piece.title_en = '2 Skladby, op. 3',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = 'Op.', piece.catalogue_number = '3',
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 16682 AND piece.composer_id = 207
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'Serenade for Cello and Piano in A major, op. 3, No. 2', part.name_en = 'Serenade for Cello and Piano in A major, op. 3, No. 2',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 16682 AND p.composer_id = 207 AND part.part_key = 'musicbrainz:c27d5ccb-9a2f-44fa-aecb-276d5ed33083' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:c27d5ccb-9a2f-44fa-aecb-276d5ed33083', 1, NULL, 'Serenade for Cello and Piano in A major, op. 3, No. 2', 'Serenade for Cello and Piano in A major, op. 3, No. 2', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 16682 AND p.composer_id = 207
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:c27d5ccb-9a2f-44fa-aecb-276d5ed33083'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'Ballad for Cello and Piano in D minor, op. 3, No. 1', part.name_en = 'Ballad for Cello and Piano in D minor, op. 3, No. 1',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 16682 AND p.composer_id = 207 AND part.part_key = 'musicbrainz:e538cbf1-2e2f-4990-aae7-d142f072aeb0' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:e538cbf1-2e2f-4990-aae7-d142f072aeb0', 2, NULL, 'Ballad for Cello and Piano in D minor, op. 3, No. 1', 'Ballad for Cello and Piano in D minor, op. 3, No. 1', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 16682 AND p.composer_id = 207
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:e538cbf1-2e2f-4990-aae7-d142f072aeb0'
);


-- None 바가텔 "With Nosegay in Hand"

UPDATE pieces piece
SET piece.title = '바가텔 "With Nosegay in Hand"', piece.title_en = 'Bagatelle for Flute, Violin and Piano “With Nosegay in Hand”',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 17134 AND piece.composer_id = 207
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Ballad for String Quartet in D minor

UPDATE pieces piece
SET piece.title = 'Ballad for String Quartet in D minor', piece.title_en = 'Ballad for String Quartet in D minor',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 19034 AND piece.composer_id = 207
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Ballad for Violin and Piano in D minor

UPDATE pieces piece
SET piece.title = 'Ballad for Violin and Piano in D minor', piece.title_en = 'Ballad for Violin and Piano in D minor',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 19028 AND piece.composer_id = 207
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- Op. 3 Ballade and Serenade Op. 3

UPDATE pieces piece
SET piece.title = 'Ballade and Serenade Op. 3', piece.title_en = 'Ballade and Serenade, op. 3',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = 'Op.', piece.catalogue_number = '3',
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 18402 AND piece.composer_id = 207
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'D단조', part.name_en = 'Ballade and Serenade, op. 3: 1. Ballade in D minor',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 18402 AND p.composer_id = 207 AND part.part_key = 'musicbrainz:32ac0f0c-2d55-4dd0-9d3c-93201fe0e673' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:32ac0f0c-2d55-4dd0-9d3c-93201fe0e673', 1, NULL, 'D단조', 'Ballade and Serenade, op. 3: 1. Ballade in D minor', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 18402 AND p.composer_id = 207
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:32ac0f0c-2d55-4dd0-9d3c-93201fe0e673'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'A장조', part.name_en = 'Ballade and Serenade, op. 3: 2. Serenade in A major',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 18402 AND p.composer_id = 207 AND part.part_key = 'musicbrainz:6510d104-eb3e-4830-a275-39f7db502f00' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:6510d104-eb3e-4830-a275-39f7db502f00', 2, NULL, 'A장조', 'Ballade and Serenade, op. 3: 2. Serenade in A major', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 18402 AND p.composer_id = 207
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:6510d104-eb3e-4830-a275-39f7db502f00'
);


-- Op. 37 Epilogue

UPDATE pieces piece
SET piece.title = 'Epilogue', piece.title_en = 'Epilogue, op. 37',
    piece.type = 'album', piece.opus_number = 'Op. 37',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 16512 AND piece.composer_id = 207
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'IV',
    part.name_ko = 'Tajemný úzas a neklid (Adagio maestoso e mesto)', part.name_en = 'Epilog, op. 37: IV. Tajemný úzas a neklid (Adagio maestoso e mesto)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 16512 AND p.composer_id = 207 AND part.part_key = 'musicbrainz:3d47f98a-8b4c-4e1e-a6f5-ae5295ebdc61' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:3d47f98a-8b4c-4e1e-a6f5-ae5295ebdc61', 1, 'IV', 'Tajemný úzas a neklid (Adagio maestoso e mesto)', 'Epilog, op. 37: IV. Tajemný úzas a neklid (Adagio maestoso e mesto)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 16512 AND p.composer_id = 207
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:3d47f98a-8b4c-4e1e-a6f5-ae5295ebdc61'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'V',
    part.name_ko = 'Poutník - tesitel (Adagio molto tranquillo)', part.name_en = 'Epilog, op. 37: V. Poutník - tesitel (Adagio molto tranquillo)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 16512 AND p.composer_id = 207 AND part.part_key = 'musicbrainz:a11537fc-0a50-4867-baa9-4fbd6e9c98ee' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:a11537fc-0a50-4867-baa9-4fbd6e9c98ee', 2, 'V', 'Poutník - tesitel (Adagio molto tranquillo)', 'Epilog, op. 37: V. Poutník - tesitel (Adagio molto tranquillo)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 16512 AND p.composer_id = 207
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:a11537fc-0a50-4867-baa9-4fbd6e9c98ee'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = 'Od vecnosti do vecnosti (Allegro appassionato)', part.name_en = 'Epilog, op. 37: III. Od vecnosti do vecnosti (Allegro appassionato)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 16512 AND p.composer_id = 207 AND part.part_key = 'musicbrainz:cf7c28cc-cc4d-4dda-aae8-cd32b1b37e06' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:cf7c28cc-cc4d-4dda-aae8-cd32b1b37e06', 3, 'III', 'Od vecnosti do vecnosti (Allegro appassionato)', 'Epilog, op. 37: III. Od vecnosti do vecnosti (Allegro appassionato)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 16512 AND p.composer_id = 207
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:cf7c28cc-cc4d-4dda-aae8-cd32b1b37e06'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = 'II',
    part.name_ko = 'Písen matek (Andante semplice)', part.name_en = 'Epilog, op. 37: II. Písen matek (Andante semplice)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 16512 AND p.composer_id = 207 AND part.part_key = 'musicbrainz:e2445035-c0f8-409f-99e9-02fdedffd766' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:e2445035-c0f8-409f-99e9-02fdedffd766', 4, 'II', 'Písen matek (Andante semplice)', 'Epilog, op. 37: II. Písen matek (Andante semplice)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 16512 AND p.composer_id = 207
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:e2445035-c0f8-409f-99e9-02fdedffd766'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 5, part.movement_number = 'I',
    part.name_ko = 'Kroky (Adagio)', part.name_en = 'Epilog, op. 37: I. Kroky (Adagio)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 16512 AND p.composer_id = 207 AND part.part_key = 'musicbrainz:f1fee670-dc9d-4c12-91c1-9a44522c30c3' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:f1fee670-dc9d-4c12-91c1-9a44522c30c3', 5, 'I', 'Kroky (Adagio)', 'Epilog, op. 37: I. Kroky (Adagio)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 16512 AND p.composer_id = 207
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:f1fee670-dc9d-4c12-91c1-9a44522c30c3'
);


-- Op. 25 Fantastickè scherzo

UPDATE pieces piece
SET piece.title = 'Fantastickè scherzo', piece.title_en = 'Fantastickè scherzo, op. 25',
    piece.type = 'song', piece.opus_number = 'Op. 25',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 16229 AND piece.composer_id = 207
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- Op. 24 환상곡 G단조

UPDATE pieces piece
SET piece.title = '환상곡 G단조', piece.title_en = 'Fantasy in G minor for Violin & Orchestra, op. 24',
    piece.type = 'song', piece.opus_number = 'Op. 24',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 16198 AND piece.composer_id = 207
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- Op. 17 4개의 바이올린과 피아노를 위한 소품 Op. 17

UPDATE pieces piece
SET piece.title = '4개의 바이올린과 피아노를 위한 소품 Op. 17', piece.title_en = 'Four Pieces for Violin and Piano, op. 17',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = 'Op.', piece.catalogue_number = '17',
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 19271 AND piece.composer_id = 207
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'Quasi ballata', part.name_en = 'Four Pieces for Violin and Piano, op. 17: No. 1. Quasi ballata',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 19271 AND p.composer_id = 207 AND part.part_key = 'musicbrainz:4626f2ee-8679-49e3-a0a0-5e71b5f0d8c6' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:4626f2ee-8679-49e3-a0a0-5e71b5f0d8c6', 1, NULL, 'Quasi ballata', 'Four Pieces for Violin and Piano, op. 17: No. 1. Quasi ballata', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 19271 AND p.composer_id = 207
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:4626f2ee-8679-49e3-a0a0-5e71b5f0d8c6'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'Appassionato', part.name_en = 'Four Pieces for Violin and Piano, op. 17: No. 2. Appassionato',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 19271 AND p.composer_id = 207 AND part.part_key = 'musicbrainz:44fb0007-1663-4e38-a017-a4d356edeb2d' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:44fb0007-1663-4e38-a017-a4d356edeb2d', 2, NULL, 'Appassionato', 'Four Pieces for Violin and Piano, op. 17: No. 2. Appassionato', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 19271 AND p.composer_id = 207
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:44fb0007-1663-4e38-a017-a4d356edeb2d'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = NULL,
    part.name_ko = 'Un poco triste', part.name_en = 'Four Pieces for Violin and Piano, op. 17: No. 3. Un poco triste',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 19271 AND p.composer_id = 207 AND part.part_key = 'musicbrainz:8e82db16-e515-47b4-9e3a-82bfabf61e85' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:8e82db16-e515-47b4-9e3a-82bfabf61e85', 3, NULL, 'Un poco triste', 'Four Pieces for Violin and Piano, op. 17: No. 3. Un poco triste', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 19271 AND p.composer_id = 207
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:8e82db16-e515-47b4-9e3a-82bfabf61e85'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = NULL,
    part.name_ko = 'Burleska', part.name_en = 'Four Pieces for Violin and Piano, op. 17: No. 4. Burleska',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 19271 AND p.composer_id = 207 AND part.part_key = 'musicbrainz:c4324dd3-4f90-4435-839b-3036b3907e2e' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:c4324dd3-4f90-4435-839b-3036b3907e2e', 4, NULL, 'Burleska', 'Four Pieces for Violin and Piano, op. 17: No. 4. Burleska', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 19271 AND p.composer_id = 207
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:c4324dd3-4f90-4435-839b-3036b3907e2e'
);


-- None Humoreske in C major

UPDATE pieces piece
SET piece.title = 'Humoreske in C major', piece.title_en = 'Humoreske in C major',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 17780 AND piece.composer_id = 207
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- Op. 22a Jaro

UPDATE pieces piece
SET piece.title = 'Jaro', piece.title_en = 'Jaro, op. 22a',
    piece.type = 'album', piece.opus_number = 'Op. 22a',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 17328 AND piece.composer_id = 207
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'Jaro. Allegro con brio', part.name_en = 'Jaro, op. 22a: I. Jaro. Allegro con brio',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 17328 AND p.composer_id = 207 AND part.part_key = 'musicbrainz:abe9c668-8042-4745-987e-541140f3467d' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:abe9c668-8042-4745-987e-541140f3467d', 1, 'I', 'Jaro. Allegro con brio', 'Jaro, op. 22a: I. Jaro. Allegro con brio', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 17328 AND p.composer_id = 207
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:abe9c668-8042-4745-987e-541140f3467d'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'Vanek. Andante, quasi allegretto', part.name_en = 'Jaro, op. 22a: II. Vanek. Andante, quasi allegretto',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 17328 AND p.composer_id = 207 AND part.part_key = 'musicbrainz:95926e4e-7e4d-4df6-96e6-ed3e38bfdc96' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:95926e4e-7e4d-4df6-96e6-ed3e38bfdc96', 2, 'II', 'Vanek. Andante, quasi allegretto', 'Jaro, op. 22a: II. Vanek. Andante, quasi allegretto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 17328 AND p.composer_id = 207
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:95926e4e-7e4d-4df6-96e6-ed3e38bfdc96'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = 'V očekávání. Andante con moto ed espressivo', part.name_en = 'Jaro, op. 22a: III. V očekávání. Andante con moto ed espressivo',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 17328 AND p.composer_id = 207 AND part.part_key = 'musicbrainz:b166d2c1-bd74-4884-954a-1adafc1c4607' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:b166d2c1-bd74-4884-954a-1adafc1c4607', 3, 'III', 'V očekávání. Andante con moto ed espressivo', 'Jaro, op. 22a: III. V očekávání. Andante con moto ed espressivo', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 17328 AND p.composer_id = 207
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:b166d2c1-bd74-4884-954a-1adafc1c4607'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = 'IV',
    part.name_ko = 'Andante', part.name_en = 'Jaro, op. 22a: IV. Andante',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 17328 AND p.composer_id = 207 AND part.part_key = 'musicbrainz:9a11ab73-5ded-4921-9472-2dba1dd40d1f' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:9a11ab73-5ded-4921-9472-2dba1dd40d1f', 4, 'IV', 'Andante', 'Jaro, op. 22a: IV. Andante', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 17328 AND p.composer_id = 207
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:9a11ab73-5ded-4921-9472-2dba1dd40d1f'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 5, part.movement_number = 'V',
    part.name_ko = 'V roztoužení. Allegro non troppo', part.name_en = 'Jaro, op. 22a: V. V roztoužení. Allegro non troppo',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 17328 AND p.composer_id = 207 AND part.part_key = 'musicbrainz:134d7923-519f-4627-8a1b-4540e325ebdf' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:134d7923-519f-4627-8a1b-4540e325ebdf', 5, 'V', 'V roztoužení. Allegro non troppo', 'Jaro, op. 22a: V. V roztoužení. Allegro non troppo', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 17328 AND p.composer_id = 207
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:134d7923-519f-4627-8a1b-4540e325ebdf'
);


-- Op. 7 Klavírní skladby

UPDATE pieces piece
SET piece.title = 'Klavírní skladby', piece.title_en = 'Klavírní skladby, op. 7',
    piece.type = 'album', piece.opus_number = 'Op. 7',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 16285 AND piece.composer_id = 207
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'Píseň lásky. Adagio non troppo lento', part.name_en = 'Klavírní skladby, op. 7: I. Píseň lásky. Adagio non troppo lento',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 16285 AND p.composer_id = 207 AND part.part_key = 'musicbrainz:a3975ae8-5dc3-484d-99a6-f4a7fca4b4ed' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:a3975ae8-5dc3-484d-99a6-f4a7fca4b4ed', 1, 'I', 'Píseň lásky. Adagio non troppo lento', 'Klavírní skladby, op. 7: I. Píseň lásky. Adagio non troppo lento', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 16285 AND p.composer_id = 207
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:a3975ae8-5dc3-484d-99a6-f4a7fca4b4ed'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'Humoreska. Allegretto grazioso', part.name_en = 'Klavírní skladby, op. 7: II. Humoreska. Allegretto grazioso',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 16285 AND p.composer_id = 207 AND part.part_key = 'musicbrainz:981a4769-d367-4bad-8c89-da717a0fbe80' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:981a4769-d367-4bad-8c89-da717a0fbe80', 2, 'II', 'Humoreska. Allegretto grazioso', 'Klavírní skladby, op. 7: II. Humoreska. Allegretto grazioso', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 16285 AND p.composer_id = 207
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:981a4769-d367-4bad-8c89-da717a0fbe80'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = 'Vzpomínky', part.name_en = 'Klavírní skladby, op. 7: III. Vzpomínky',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 16285 AND p.composer_id = 207 AND part.part_key = 'musicbrainz:48e8805c-dfb7-45de-81f0-adcf672fe7bf' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:48e8805c-dfb7-45de-81f0-adcf672fe7bf', 3, 'III', 'Vzpomínky', 'Klavírní skladby, op. 7: III. Vzpomínky', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 16285 AND p.composer_id = 207
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:48e8805c-dfb7-45de-81f0-adcf672fe7bf'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = 'IV',
    part.name_ko = 'Idylky: No. 1. Moderato - No. 2. Tempo comodo', part.name_en = 'Klavírní skladby, op. 7: IV. Idylky: No. 1. Moderato - No. 2. Tempo comodo',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 16285 AND p.composer_id = 207 AND part.part_key = 'musicbrainz:927623f4-ab22-49b9-9e19-efdcbc2e800a' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:927623f4-ab22-49b9-9e19-efdcbc2e800a', 4, 'IV', 'Idylky: No. 1. Moderato - No. 2. Tempo comodo', 'Klavírní skladby, op. 7: IV. Idylky: No. 1. Moderato - No. 2. Tempo comodo', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 16285 AND p.composer_id = 207
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:927623f4-ab22-49b9-9e19-efdcbc2e800a'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 5, part.movement_number = 'V',
    part.name_ko = 'Dumka. Andante - Allegro ma non troppo - Andante', part.name_en = 'Klavírní skladby, op. 7: V. Dumka. Andante - Allegro ma non troppo - Andante',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 16285 AND p.composer_id = 207 AND part.part_key = 'musicbrainz:aa0db4cb-cf76-41a3-8ff6-a222cdfa9ac5' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:aa0db4cb-cf76-41a3-8ff6-a222cdfa9ac5', 5, 'V', 'Dumka. Andante - Allegro ma non troppo - Andante', 'Klavírní skladby, op. 7: V. Dumka. Andante - Allegro ma non troppo - Andante', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 16285 AND p.composer_id = 207
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:aa0db4cb-cf76-41a3-8ff6-a222cdfa9ac5'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 6, part.movement_number = 'VI',
    part.name_ko = 'Capriccio', part.name_en = 'Klavírní skladby, op. 7: VI. Capriccio',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 16285 AND p.composer_id = 207 AND part.part_key = 'musicbrainz:aedc9c3a-a297-4752-99fa-896e781d0155' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:aedc9c3a-a297-4752-99fa-896e781d0155', 6, 'VI', 'Capriccio', 'Klavírní skladby, op. 7: VI. Capriccio', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 16285 AND p.composer_id = 207
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:aedc9c3a-a297-4752-99fa-896e781d0155'
);


-- Op. 35b Legenda o mrtvých vítězích

UPDATE pieces piece
SET piece.title = 'Legenda o mrtvých vítězích', piece.title_en = 'Legenda o mrtvých vítězích, op. 35b',
    piece.type = 'song', piece.opus_number = 'Op. 35b',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 15769 AND piece.composer_id = 207
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- Op. 22b Letní dojmy

UPDATE pieces piece
SET piece.title = 'Letní dojmy', piece.title_en = 'Letní dojmy, op. 22b',
    piece.type = 'album', piece.opus_number = 'Op. 22b',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 19403 AND piece.composer_id = 207
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'V poledne. Moderato', part.name_en = 'Letní dojmy, op. 22b: I. V poledne. Moderato',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 19403 AND p.composer_id = 207 AND part.part_key = 'musicbrainz:1cfe8fa6-e66f-4d05-b7b5-27eb86ca6af7' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:1cfe8fa6-e66f-4d05-b7b5-27eb86ca6af7', 1, 'I', 'V poledne. Moderato', 'Letní dojmy, op. 22b: I. V poledne. Moderato', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 19403 AND p.composer_id = 207
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:1cfe8fa6-e66f-4d05-b7b5-27eb86ca6af7'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'Hra dětí. Allegretto', part.name_en = 'Letní dojmy, op. 22b: II. Hra dětí. Allegretto',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 19403 AND p.composer_id = 207 AND part.part_key = 'musicbrainz:a954a767-2d77-4880-8b34-8f23716bafc0' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:a954a767-2d77-4880-8b34-8f23716bafc0', 2, 'II', 'Hra dětí. Allegretto', 'Letní dojmy, op. 22b: II. Hra dětí. Allegretto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 19403 AND p.composer_id = 207
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:a954a767-2d77-4880-8b34-8f23716bafc0'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = 'Večerní nálada. Andante espressivo', part.name_en = 'Letní dojmy, op. 22b: III. Večerní nálada. Andante espressivo',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 19403 AND p.composer_id = 207 AND part.part_key = 'musicbrainz:a20c582e-e906-4764-9149-5f7a1e32b3f5' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:a20c582e-e906-4764-9149-5f7a1e32b3f5', 3, 'III', 'Večerní nálada. Andante espressivo', 'Letní dojmy, op. 22b: III. Večerní nálada. Andante espressivo', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 19403 AND p.composer_id = 207
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:a20c582e-e906-4764-9149-5f7a1e32b3f5'
);


-- Op. 35a Meditation on the Old Czech Chorale “St. Wenceslas”

UPDATE pieces piece
SET piece.title = 'Meditation on the Old Czech Chorale “St. Wenceslas”', piece.title_en = 'Meditation on the Old Czech Chorale “St. Wenceslas”, op. 35a',
    piece.type = 'song', piece.opus_number = 'Op. 35a',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 19931 AND piece.composer_id = 207
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Melody for 2 Violins

UPDATE pieces piece
SET piece.title = 'Melody for 2 Violins', piece.title_en = 'Melody for 2 Violins',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 16728 AND piece.composer_id = 207
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Minuet for Violin and Piano

UPDATE pieces piece
SET piece.title = 'Minuet for Violin and Piano', piece.title_en = 'Minuet for Violin and Piano',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 17619 AND piece.composer_id = 207
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None 가곡 <Noc byla krásná>

UPDATE pieces piece
SET piece.title = '가곡 <Noc byla krásná>', piece.title_en = 'Noc byla krásná',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 15755 AND piece.composer_id = 207
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- Op. 10 Nálady

UPDATE pieces piece
SET piece.title = 'Nálady', piece.title_en = 'Nálady, op. 10',
    piece.type = 'album', piece.opus_number = 'Op. 10',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 17950 AND piece.composer_id = 207
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'Legenda. Andante espressivo', part.name_en = 'Nálady, op. 10: I. Legenda. Andante espressivo',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 17950 AND p.composer_id = 207 AND part.part_key = 'musicbrainz:8e4107e5-f42b-4a13-b989-696b7c7c0581' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:8e4107e5-f42b-4a13-b989-696b7c7c0581', 1, 'I', 'Legenda. Andante espressivo', 'Nálady, op. 10: I. Legenda. Andante espressivo', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 17950 AND p.composer_id = 207
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:8e4107e5-f42b-4a13-b989-696b7c7c0581'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'Capriccio. Allegro ma non troppo', part.name_en = 'Nálady, op. 10: II. Capriccio. Allegro ma non troppo',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 17950 AND p.composer_id = 207 AND part.part_key = 'musicbrainz:c3673f3e-e8f4-430a-b4c3-357bd842616c' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:c3673f3e-e8f4-430a-b4c3-357bd842616c', 2, 'II', 'Capriccio. Allegro ma non troppo', 'Nálady, op. 10: II. Capriccio. Allegro ma non troppo', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 17950 AND p.composer_id = 207
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:c3673f3e-e8f4-430a-b4c3-357bd842616c'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = 'Romance. Andante con moto', part.name_en = 'Nálady, op. 10: III. Romance. Andante con moto',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 17950 AND p.composer_id = 207 AND part.part_key = 'musicbrainz:8983efdb-d134-4d18-8246-13b627ada456' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:8983efdb-d134-4d18-8246-13b627ada456', 3, 'III', 'Romance. Andante con moto', 'Nálady, op. 10: III. Romance. Andante con moto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 17950 AND p.composer_id = 207
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:8983efdb-d134-4d18-8246-13b627ada456'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = 'IV',
    part.name_ko = 'Bagatela. Moderato', part.name_en = 'Nálady, op. 10: IV. Bagatela. Moderato',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 17950 AND p.composer_id = 207 AND part.part_key = 'musicbrainz:508e1244-88e4-434e-9948-518c38db0ff6' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:508e1244-88e4-434e-9948-518c38db0ff6', 4, 'IV', 'Bagatela. Moderato', 'Nálady, op. 10: IV. Bagatela. Moderato', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 17950 AND p.composer_id = 207
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:508e1244-88e4-434e-9948-518c38db0ff6'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 5, part.movement_number = 'V',
    part.name_ko = 'Jarní idyla. Vivace', part.name_en = 'Nálady, op. 10: V. Jarní idyla. Vivace',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 17950 AND p.composer_id = 207 AND part.part_key = 'musicbrainz:cf720c20-747f-4c64-8856-8e230be594f9' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:cf720c20-747f-4c64-8856-8e230be594f9', 5, 'V', 'Jarní idyla. Vivace', 'Nálady, op. 10: V. Jarní idyla. Vivace', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 17950 AND p.composer_id = 207
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:cf720c20-747f-4c64-8856-8e230be594f9'
);


-- Op. 28 O Matince

UPDATE pieces piece
SET piece.title = 'O Matince', piece.title_en = 'O Matince, op. 28',
    piece.type = 'album', piece.opus_number = 'Op. 28',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 15812 AND piece.composer_id = 207
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'Když byla matinka ještě děvčátkem. Allegretto molto moderato', part.name_en = 'O Matince, op. 28: I. Když byla matinka ještě děvčátkem. Allegretto molto moderato',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 15812 AND p.composer_id = 207 AND part.part_key = 'musicbrainz:97072a27-0962-42b3-bf56-76f7d7eb2b41' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:97072a27-0962-42b3-bf56-76f7d7eb2b41', 1, 'I', 'Když byla matinka ještě děvčátkem. Allegretto molto moderato', 'O Matince, op. 28: I. Když byla matinka ještě děvčátkem. Allegretto molto moderato', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 15812 AND p.composer_id = 207
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:97072a27-0962-42b3-bf56-76f7d7eb2b41'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'Kdysi z jara. Adagio - Allegro non troppo - Adagio', part.name_en = 'O Matince, op. 28: II. Kdysi z jara. Adagio - Allegro non troppo - Adagio',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 15812 AND p.composer_id = 207 AND part.part_key = 'musicbrainz:b314a7ab-0876-4bb9-89b9-9dd5607f67fb' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:b314a7ab-0876-4bb9-89b9-9dd5607f67fb', 2, 'II', 'Kdysi z jara. Adagio - Allegro non troppo - Adagio', 'O Matince, op. 28: II. Kdysi z jara. Adagio - Allegro non troppo - Adagio', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 15812 AND p.composer_id = 207
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:b314a7ab-0876-4bb9-89b9-9dd5607f67fb'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = 'Jak zpívala matinka za noci chorému děcku. Andante', part.name_en = 'O Matince, op. 28: III. Jak zpívala matinka za noci chorému děcku. Andante',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 15812 AND p.composer_id = 207 AND part.part_key = 'musicbrainz:045f4d87-55de-4ba3-bb00-81f52d1fa600' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:045f4d87-55de-4ba3-bb00-81f52d1fa600', 3, 'III', 'Jak zpívala matinka za noci chorému děcku. Andante', 'O Matince, op. 28: III. Jak zpívala matinka za noci chorému děcku. Andante', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 15812 AND p.composer_id = 207
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:045f4d87-55de-4ba3-bb00-81f52d1fa600'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = 'IV',
    part.name_ko = 'O matinčině srdci. Andante sostenuto', part.name_en = 'O Matince, op. 28: IV. O matinčině srdci. Andante sostenuto',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 15812 AND p.composer_id = 207 AND part.part_key = 'musicbrainz:6e66362e-476d-40de-af37-7f170c88bedd' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:6e66362e-476d-40de-af37-7f170c88bedd', 4, 'IV', 'O matinčině srdci. Andante sostenuto', 'O Matince, op. 28: IV. O matinčině srdci. Andante sostenuto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 15812 AND p.composer_id = 207
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:6e66362e-476d-40de-af37-7f170c88bedd'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 5, part.movement_number = 'V',
    part.name_ko = 'Vzpomínání. Andante', part.name_en = 'O Matince, op. 28: V. Vzpomínání. Andante',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 15812 AND p.composer_id = 207 AND part.part_key = 'musicbrainz:8ccc5b24-fbd8-4778-b9c0-e1c5f361ffb3' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:8ccc5b24-fbd8-4778-b9c0-e1c5f361ffb3', 5, 'V', 'Vzpomínání. Andante', 'O Matince, op. 28: V. Vzpomínání. Andante', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 15812 AND p.composer_id = 207
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:8ccc5b24-fbd8-4778-b9c0-e1c5f361ffb3'
);


-- Op. 1 피아노 4중주 A단조

UPDATE pieces piece
SET piece.title = '피아노 4중주 A단조', piece.title_en = 'Piano Quartet in A minor, op. 1',
    piece.type = 'album', piece.opus_number = 'Op. 1',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 16001 AND piece.composer_id = 207
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'Allegro appassionato', part.name_en = 'Piano Quartet in A minor, op. 1: I. Allegro appassionato',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 16001 AND p.composer_id = 207 AND part.part_key = 'musicbrainz:cc9ba85a-1ed9-4eae-8cf3-ce3bcdf95373' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:cc9ba85a-1ed9-4eae-8cf3-ce3bcdf95373', 1, 'I', 'Allegro appassionato', 'Piano Quartet in A minor, op. 1: I. Allegro appassionato', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 16001 AND p.composer_id = 207
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:cc9ba85a-1ed9-4eae-8cf3-ce3bcdf95373'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'Adagio', part.name_en = 'Piano Quartet in A minor, op. 1: II. Adagio',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 16001 AND p.composer_id = 207 AND part.part_key = 'musicbrainz:a3a6c700-205f-4952-9577-3cb958bd5fa2' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:a3a6c700-205f-4952-9577-3cb958bd5fa2', 2, 'II', 'Adagio', 'Piano Quartet in A minor, op. 1: II. Adagio', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 16001 AND p.composer_id = 207
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:a3a6c700-205f-4952-9577-3cb958bd5fa2'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = 'Allegro con fuoco', part.name_en = 'Piano Quartet in A minor, op. 1: III. Allegro con fuoco',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 16001 AND p.composer_id = 207 AND part.part_key = 'musicbrainz:a6e16fea-22ae-424a-b3ef-80448768a56b' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:a6e16fea-22ae-424a-b3ef-80448768a56b', 3, 'III', 'Allegro con fuoco', 'Piano Quartet in A minor, op. 1: III. Allegro con fuoco', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 16001 AND p.composer_id = 207
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:a6e16fea-22ae-424a-b3ef-80448768a56b'
);


-- Op. 8 피아노 5중주 G단조

UPDATE pieces piece
SET piece.title = '피아노 5중주 G단조', piece.title_en = 'Piano Quintet in G minor, op. 8',
    piece.type = 'album', piece.opus_number = 'Op. 8',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 16527 AND piece.composer_id = 207
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'Allegro energico', part.name_en = 'Piano Quintet in G minor, op. 8: I. Allegro energico',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 16527 AND p.composer_id = 207 AND part.part_key = 'musicbrainz:b63edda6-bb13-4479-a3c8-8796edc44887' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:b63edda6-bb13-4479-a3c8-8796edc44887', 1, 'I', 'Allegro energico', 'Piano Quintet in G minor, op. 8: I. Allegro energico', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 16527 AND p.composer_id = 207
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:b63edda6-bb13-4479-a3c8-8796edc44887'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'Adagio: Religioso', part.name_en = 'Piano Quintet in G minor, op. 8: II. Adagio: Religioso',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 16527 AND p.composer_id = 207 AND part.part_key = 'musicbrainz:52670383-2299-4317-8c62-e4161037ca3b' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:52670383-2299-4317-8c62-e4161037ca3b', 2, 'II', 'Adagio: Religioso', 'Piano Quintet in G minor, op. 8: II. Adagio: Religioso', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 16527 AND p.composer_id = 207
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:52670383-2299-4317-8c62-e4161037ca3b'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = 'Scherzo: Presto', part.name_en = 'Piano Quintet in G minor, op. 8: III. Scherzo: Presto',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 16527 AND p.composer_id = 207 AND part.part_key = 'musicbrainz:2f6f1647-91a1-4b4e-bc1f-f395145d6f41' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:2f6f1647-91a1-4b4e-bc1f-f395145d6f41', 3, 'III', 'Scherzo: Presto', 'Piano Quintet in G minor, op. 8: III. Scherzo: Presto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 16527 AND p.composer_id = 207
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:2f6f1647-91a1-4b4e-bc1f-f395145d6f41'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = 'IV',
    part.name_ko = 'Allegro fuoco', part.name_en = 'Piano Quintet in G minor, op. 8: IV. Allegro fuoco',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 16527 AND p.composer_id = 207 AND part.part_key = 'musicbrainz:f21e1636-b15a-4f0d-b023-0f091f2db352' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:f21e1636-b15a-4f0d-b023-0f091f2db352', 4, 'IV', 'Allegro fuoco', 'Piano Quintet in G minor, op. 8: IV. Allegro fuoco', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 16527 AND p.composer_id = 207
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:f21e1636-b15a-4f0d-b023-0f091f2db352'
);


-- Op. 2 피아노 3중주 C단조

UPDATE pieces piece
SET piece.title = '피아노 3중주 C단조', piece.title_en = 'Piano Trio in C minor, op. 2',
    piece.type = 'album', piece.opus_number = 'Op. 2',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 18832 AND piece.composer_id = 207
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'Allegro', part.name_en = 'Piano Trio in C minor, op. 2: I. Allegro',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 18832 AND p.composer_id = 207 AND part.part_key = 'musicbrainz:57714ebe-0fd0-48c4-9e67-dbb3cc40a105' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:57714ebe-0fd0-48c4-9e67-dbb3cc40a105', 1, 'I', 'Allegro', 'Piano Trio in C minor, op. 2: I. Allegro', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 18832 AND p.composer_id = 207
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:57714ebe-0fd0-48c4-9e67-dbb3cc40a105'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'Andante', part.name_en = 'Piano Trio in C minor, op. 2: II. Andante',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 18832 AND p.composer_id = 207 AND part.part_key = 'musicbrainz:f48e791b-d948-4ddb-9da2-cdc26bdbfb31' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:f48e791b-d948-4ddb-9da2-cdc26bdbfb31', 2, 'II', 'Andante', 'Piano Trio in C minor, op. 2: II. Andante', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 18832 AND p.composer_id = 207
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:f48e791b-d948-4ddb-9da2-cdc26bdbfb31'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = 'Vivace', part.name_en = 'Piano Trio in C minor, op. 2: III. Vivace',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 18832 AND p.composer_id = 207 AND part.part_key = 'musicbrainz:8a048029-cd17-44fd-8b6b-a6eb10215fda' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:8a048029-cd17-44fd-8b6b-a6eb10215fda', 3, 'III', 'Vivace', 'Piano Trio in C minor, op. 2: III. Vivace', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 18832 AND p.composer_id = 207
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:8a048029-cd17-44fd-8b6b-a6eb10215fda'
);


-- Op. 29 Pohádka léta

UPDATE pieces piece
SET piece.title = 'Pohádka léta', piece.title_en = 'Pohádka léta, op. 29',
    piece.type = 'album', piece.opus_number = 'Op. 29',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 15721 AND piece.composer_id = 207
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'Hlasy života a útěchy', part.name_en = 'Pohádka léta, op. 29: I. Hlasy života a útěchy',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 15721 AND p.composer_id = 207 AND part.part_key = 'musicbrainz:6c3be77d-ea5f-4bf0-8684-98023a3e048d' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:6c3be77d-ea5f-4bf0-8684-98023a3e048d', 1, 'I', 'Hlasy života a útěchy', 'Pohádka léta, op. 29: I. Hlasy života a útěchy', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 15721 AND p.composer_id = 207
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:6c3be77d-ea5f-4bf0-8684-98023a3e048d'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'V poledne', part.name_en = 'Pohádka léta, op. 29: II. V poledne',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 15721 AND p.composer_id = 207 AND part.part_key = 'musicbrainz:7e81e932-06c4-466f-afa8-67b0a64700bc' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:7e81e932-06c4-466f-afa8-67b0a64700bc', 2, 'II', 'V poledne', 'Pohádka léta, op. 29: II. V poledne', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 15721 AND p.composer_id = 207
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:7e81e932-06c4-466f-afa8-67b0a64700bc'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = 'Intermezzo. Slepí hudci', part.name_en = 'Pohádka léta, op. 29: III. Intermezzo. Slepí hudci',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 15721 AND p.composer_id = 207 AND part.part_key = 'musicbrainz:5b655bda-fdd3-4b60-943b-3650aa4c2de6' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:5b655bda-fdd3-4b60-943b-3650aa4c2de6', 3, 'III', 'Intermezzo. Slepí hudci', 'Pohádka léta, op. 29: III. Intermezzo. Slepí hudci', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 15721 AND p.composer_id = 207
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:5b655bda-fdd3-4b60-943b-3650aa4c2de6'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = 'IV',
    part.name_ko = 'V moci přeludů', part.name_en = 'Pohádka léta, op. 29: IV. V moci přeludů',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 15721 AND p.composer_id = 207 AND part.part_key = 'musicbrainz:50f76932-a992-4067-80dc-2eca8100e0a2' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:50f76932-a992-4067-80dc-2eca8100e0a2', 4, 'IV', 'V moci přeludů', 'Pohádka léta, op. 29: IV. V moci přeludů', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 15721 AND p.composer_id = 207
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:50f76932-a992-4067-80dc-2eca8100e0a2'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 5, part.movement_number = 'V',
    part.name_ko = 'Noc', part.name_en = 'Pohádka léta, op. 29: V. Noc',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 15721 AND p.composer_id = 207 AND part.part_key = 'musicbrainz:d3790a0a-8f54-4620-862c-82e480abac59' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:d3790a0a-8f54-4620-862c-82e480abac59', 5, 'V', 'Noc', 'Pohádka léta, op. 29: V. Noc', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 15721 AND p.composer_id = 207
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:d3790a0a-8f54-4620-862c-82e480abac59'
);


-- Op. 9 Pohádka zimního večera

UPDATE pieces piece
SET piece.title = 'Pohádka zimního večera', piece.title_en = 'Pohádka zimního večera, op. 9',
    piece.type = 'song', piece.opus_number = 'Op. 9',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 15750 AND piece.composer_id = 207
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- Op. 16 Pohádka

UPDATE pieces piece
SET piece.title = 'Pohádka', piece.title_en = 'Pohádka, op. 16',
    piece.type = 'album', piece.opus_number = 'Op. 16',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 15852 AND piece.composer_id = 207
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'O věrném milování Radúze a Mahuleny a jejich strastech', part.name_en = 'Pohádka, op. 16: I. O věrném milování Radúze a Mahuleny a jejich strastech',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 15852 AND p.composer_id = 207 AND part.part_key = 'musicbrainz:4de2bd7e-ea5f-3ab3-bde6-bf37311d571f' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:4de2bd7e-ea5f-3ab3-bde6-bf37311d571f', 1, 'I', 'O věrném milování Radúze a Mahuleny a jejich strastech', 'Pohádka, op. 16: I. O věrném milování Radúze a Mahuleny a jejich strastech', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 15852 AND p.composer_id = 207
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:4de2bd7e-ea5f-3ab3-bde6-bf37311d571f'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'Intermezzo: Hra na labutě a pávy', part.name_en = 'Pohádka, op. 16: II. Intermezzo: Hra na labutě a pávy',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 15852 AND p.composer_id = 207 AND part.part_key = 'musicbrainz:be46a48c-6989-33c7-9d32-b6cc8e8d9225' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:be46a48c-6989-33c7-9d32-b6cc8e8d9225', 2, 'II', 'Intermezzo: Hra na labutě a pávy', 'Pohádka, op. 16: II. Intermezzo: Hra na labutě a pávy', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 15852 AND p.composer_id = 207
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:be46a48c-6989-33c7-9d32-b6cc8e8d9225'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = 'Intermezzo: Smuteční hudba', part.name_en = 'Pohádka, op. 16: III. Intermezzo: Smuteční hudba',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 15852 AND p.composer_id = 207 AND part.part_key = 'musicbrainz:815ec946-a1a7-3b76-8f49-1f1fad00a942' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:815ec946-a1a7-3b76-8f49-1f1fad00a942', 3, 'III', 'Intermezzo: Smuteční hudba', 'Pohádka, op. 16: III. Intermezzo: Smuteční hudba', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 15852 AND p.composer_id = 207
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:815ec946-a1a7-3b76-8f49-1f1fad00a942'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = 'IV',
    part.name_ko = 'Runy kletba a jak byla láskou zrušena', part.name_en = 'Pohádka, op. 16: IV. Runy kletba a jak byla láskou zrušena',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 15852 AND p.composer_id = 207 AND part.part_key = 'musicbrainz:04ded3eb-517e-39f6-a50a-4cd939b89977' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:04ded3eb-517e-39f6-a50a-4cd939b89977', 4, 'IV', 'Runy kletba a jak byla láskou zrušena', 'Pohádka, op. 16: IV. Runy kletba a jak byla láskou zrušena', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 15852 AND p.composer_id = 207
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:04ded3eb-517e-39f6-a50a-4cd939b89977'
);


-- Op. 26 Praga

UPDATE pieces piece
SET piece.title = 'Praga', piece.title_en = 'Praga, op. 26',
    piece.type = 'song', piece.opus_number = 'Op. 26',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 18469 AND piece.composer_id = 207
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Quartet Movement in B-flat major

UPDATE pieces piece
SET piece.title = 'Quartet Movement in B-flat major', piece.title_en = 'Quartet Movement in B-flat major',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 19853 AND piece.composer_id = 207
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Ripening, op. 34, JSkat 70

UPDATE pieces piece
SET piece.title = 'Ripening, op. 34, JSkat 70', piece.title_en = 'Ripening, op. 34, JSkat 70',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 16410 AND piece.composer_id = 207
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- Op. 6 현악 세레나데

UPDATE pieces piece
SET piece.title = '현악 세레나데', piece.title_en = 'Serenade for Strings, op. 6',
    piece.type = 'album', piece.opus_number = 'Op. 6',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 16633 AND piece.composer_id = 207
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'Andante con moto', part.name_en = 'Serenade for Strings, op. 6: I. Andante con moto',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 16633 AND p.composer_id = 207 AND part.part_key = 'musicbrainz:17f1d43c-7b0d-3a6b-b728-0fb7ac7eeff1' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:17f1d43c-7b0d-3a6b-b728-0fb7ac7eeff1', 1, 'I', 'Andante con moto', 'Serenade for Strings, op. 6: I. Andante con moto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 16633 AND p.composer_id = 207
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:17f1d43c-7b0d-3a6b-b728-0fb7ac7eeff1'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'Allegro, ma non troppo e grazioso', part.name_en = 'Serenade for Strings, op. 6: II. Allegro, ma non troppo e grazioso',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 16633 AND p.composer_id = 207 AND part.part_key = 'musicbrainz:9b7cd123-0335-3125-aca8-c491994f7e3b' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:9b7cd123-0335-3125-aca8-c491994f7e3b', 2, 'II', 'Allegro, ma non troppo e grazioso', 'Serenade for Strings, op. 6: II. Allegro, ma non troppo e grazioso', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 16633 AND p.composer_id = 207
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:9b7cd123-0335-3125-aca8-c491994f7e3b'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = 'Adagio - Più andante - Tempo I', part.name_en = 'Serenade for Strings, op. 6: III. Adagio - Più andante - Tempo I',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 16633 AND p.composer_id = 207 AND part.part_key = 'musicbrainz:3d2f36b5-cc96-3e7a-b7cb-b17a479bb7cc' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:3d2f36b5-cc96-3e7a-b7cb-b17a479bb7cc', 3, 'III', 'Adagio - Più andante - Tempo I', 'Serenade for Strings, op. 6: III. Adagio - Più andante - Tempo I', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 16633 AND p.composer_id = 207
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:3d2f36b5-cc96-3e7a-b7cb-b17a479bb7cc'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = 'IV',
    part.name_ko = 'Allegro giocoso, ma non troppo presto - Vivace', part.name_en = 'Serenade for Strings, op. 6: IV. Allegro giocoso, ma non troppo presto - Vivace',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 16633 AND p.composer_id = 207 AND part.part_key = 'musicbrainz:aad1ae08-b6fb-30be-8989-68a10e181d0c' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:aad1ae08-b6fb-30be-8989-68a10e181d0c', 4, 'IV', 'Allegro giocoso, ma non troppo presto - Vivace', 'Serenade for Strings, op. 6: IV. Allegro giocoso, ma non troppo presto - Vivace', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 16633 AND p.composer_id = 207
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:aad1ae08-b6fb-30be-8989-68a10e181d0c'
);


-- None Sousedská for 5 Violins, Double Bass, Cymbals, Triangle, Side and Bass Drum

UPDATE pieces piece
SET piece.title = 'Sousedská for 5 Violins, Double Bass, Cymbals, Triangle, Side and Bass Drum', piece.title_en = 'Sousedská for 5 Violins, Double Bass, Cymbals, Triangle, Side and Bass Drum',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 16136 AND piece.composer_id = 207
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- Op. 11 현악 4중주 1번 B♭장조

UPDATE pieces piece
SET piece.title = '현악 4중주 1번 B♭장조', piece.title_en = 'String Quartet no. 1 in B-flat major, op. 11',
    piece.type = 'album', piece.opus_number = 'Op. 11',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 17917 AND piece.composer_id = 207
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'Allegro moderato', part.name_en = 'String Quartet, op. 11 in B-flat major: I. Allegro moderato',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 17917 AND p.composer_id = 207 AND part.part_key = 'musicbrainz:217c3d60-6d22-4aad-8a4b-9de6e28d87f2' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:217c3d60-6d22-4aad-8a4b-9de6e28d87f2', 1, 'I', 'Allegro moderato', 'String Quartet, op. 11 in B-flat major: I. Allegro moderato', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 17917 AND p.composer_id = 207
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:217c3d60-6d22-4aad-8a4b-9de6e28d87f2'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'III',
    part.name_ko = 'Adagio ma non troppo', part.name_en = 'String Quartet, op. 11 in B-flat major: III. Adagio ma non troppo',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 17917 AND p.composer_id = 207 AND part.part_key = 'musicbrainz:28e0c873-17ac-40ea-87cc-fae305c91fa3' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:28e0c873-17ac-40ea-87cc-fae305c91fa3', 2, 'III', 'Adagio ma non troppo', 'String Quartet, op. 11 in B-flat major: III. Adagio ma non troppo', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 17917 AND p.composer_id = 207
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:28e0c873-17ac-40ea-87cc-fae305c91fa3'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'IV',
    part.name_ko = 'Allegro giocoso', part.name_en = 'String Quartet, op. 11 in B-flat major: IV. Allegro giocoso',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 17917 AND p.composer_id = 207 AND part.part_key = 'musicbrainz:2f384224-a30e-4007-b7a2-f4a0d96c35c1' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:2f384224-a30e-4007-b7a2-f4a0d96c35c1', 3, 'IV', 'Allegro giocoso', 'String Quartet, op. 11 in B-flat major: IV. Allegro giocoso', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 17917 AND p.composer_id = 207
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:2f384224-a30e-4007-b7a2-f4a0d96c35c1'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = 'II',
    part.name_ko = 'Tempo di marcia', part.name_en = 'String Quartet, op. 11 in B-flat major: II. Tempo di marcia',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 17917 AND p.composer_id = 207 AND part.part_key = 'musicbrainz:b7343ff0-2309-4271-889d-285d7af90244' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:b7343ff0-2309-4271-889d-285d7af90244', 4, 'II', 'Tempo di marcia', 'String Quartet, op. 11 in B-flat major: II. Tempo di marcia', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 17917 AND p.composer_id = 207
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:b7343ff0-2309-4271-889d-285d7af90244'
);


-- Op. 31 현악 4중주 2번

UPDATE pieces piece
SET piece.title = '현악 4중주 2번', piece.title_en = 'String Quartet no. 2, op. 31',
    piece.type = 'album', piece.opus_number = 'Op. 31',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 17175 AND piece.composer_id = 207
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'Adagio ma non troppo', part.name_en = 'String Quartet, op. 31: I. Adagio ma non troppo',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 17175 AND p.composer_id = 207 AND part.part_key = 'musicbrainz:83c3fb53-31d0-44ab-9b7f-da091d32eff5' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:83c3fb53-31d0-44ab-9b7f-da091d32eff5', 1, 'I', 'Adagio ma non troppo', 'String Quartet, op. 31: I. Adagio ma non troppo', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 17175 AND p.composer_id = 207
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:83c3fb53-31d0-44ab-9b7f-da091d32eff5'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'Adagio mesto, molto espressivo', part.name_en = 'String Quartet, op. 31: II. Adagio mesto, molto espressivo',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 17175 AND p.composer_id = 207 AND part.part_key = 'musicbrainz:8d12ddb1-b39e-449c-a60e-8528e24027e0' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:8d12ddb1-b39e-449c-a60e-8528e24027e0', 2, 'II', 'Adagio mesto, molto espressivo', 'String Quartet, op. 31: II. Adagio mesto, molto espressivo', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 17175 AND p.composer_id = 207
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:8d12ddb1-b39e-449c-a60e-8528e24027e0'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'IV',
    part.name_ko = 'Allegretto', part.name_en = 'String Quartet, op. 31: IV. Allegretto',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 17175 AND p.composer_id = 207 AND part.part_key = 'musicbrainz:a0ad1709-b7f3-4738-82c3-262c6a574384' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:a0ad1709-b7f3-4738-82c3-262c6a574384', 3, 'IV', 'Allegretto', 'String Quartet, op. 31: IV. Allegretto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 17175 AND p.composer_id = 207
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:a0ad1709-b7f3-4738-82c3-262c6a574384'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = 'III',
    part.name_ko = 'Adagio mesto', part.name_en = 'String Quartet, op. 31: III. Adagio mesto',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 17175 AND p.composer_id = 207 AND part.part_key = 'musicbrainz:fe307a88-040b-41fd-b77e-f944db1c9355' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:fe307a88-040b-41fd-b77e-f944db1c9355', 4, 'III', 'Adagio mesto', 'String Quartet, op. 31: III. Adagio mesto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 17175 AND p.composer_id = 207
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:fe307a88-040b-41fd-b77e-f944db1c9355'
);


-- None 교향곡 1번

UPDATE pieces piece
SET piece.title = '교향곡 1번', piece.title_en = 'Symphony no. 1, op. 14, JSkat 40',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 18253 AND piece.composer_id = 207
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'Allegro, ma non troppo – Allegro – Energico e con fuoco – Tempo I – Allegro – Molto tranquillo, quasi Andante – Allegro – Energico e con fuoco – Maestoso – Allegro con brio', part.name_en = 'Symphony no. 1, op. 14, JSkat 40: I. Allegro, ma non troppo – Allegro – Energico e con fuoco – Tempo I – Allegro – Molto tranquillo, quasi Andante – Allegro – Energico e con fuoco – Maestoso – Allegro con brio',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 18253 AND p.composer_id = 207 AND part.part_key = 'musicbrainz:f6eef1ff-5a17-40a9-971a-35f4fff26912' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:f6eef1ff-5a17-40a9-971a-35f4fff26912', 1, 'I', 'Allegro, ma non troppo – Allegro – Energico e con fuoco – Tempo I – Allegro – Molto tranquillo, quasi Andante – Allegro – Energico e con fuoco – Maestoso – Allegro con brio', 'Symphony no. 1, op. 14, JSkat 40: I. Allegro, ma non troppo – Allegro – Energico e con fuoco – Tempo I – Allegro – Molto tranquillo, quasi Andante – Allegro – Energico e con fuoco – Maestoso – Allegro con brio', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 18253 AND p.composer_id = 207
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:f6eef1ff-5a17-40a9-971a-35f4fff26912'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'Adagio – Pochettino più mosso – Molto appassionato – Tempo I', part.name_en = 'Symphony no. 1, op. 14, JSkat 40: II. Adagio – Pochettino più mosso – Molto appassionato – Tempo I',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 18253 AND p.composer_id = 207 AND part.part_key = 'musicbrainz:ad959957-28e2-43aa-872c-ccf98a8c036d' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:ad959957-28e2-43aa-872c-ccf98a8c036d', 2, 'II', 'Adagio – Pochettino più mosso – Molto appassionato – Tempo I', 'Symphony no. 1, op. 14, JSkat 40: II. Adagio – Pochettino più mosso – Molto appassionato – Tempo I', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 18253 AND p.composer_id = 207
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:ad959957-28e2-43aa-872c-ccf98a8c036d'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = 'Allegro vivace – Poco meno mosso – Tempo I', part.name_en = 'Symphony no. 1, op. 14, JSkat 40: III. Allegro vivace – Poco meno mosso – Tempo I',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 18253 AND p.composer_id = 207 AND part.part_key = 'musicbrainz:0ee82019-47ca-46ec-a078-ea89632f7ce9' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:0ee82019-47ca-46ec-a078-ea89632f7ce9', 3, 'III', 'Allegro vivace – Poco meno mosso – Tempo I', 'Symphony no. 1, op. 14, JSkat 40: III. Allegro vivace – Poco meno mosso – Tempo I', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 18253 AND p.composer_id = 207
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:0ee82019-47ca-46ec-a078-ea89632f7ce9'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = 'IV',
    part.name_ko = 'Allegro – Allegro con brio – Meno mosso e molto largamente – Poco più mosso. Allegro non tanto – A tempo (Allegro con brio) – Pesante – Grandioso – Maestoso – Meno mosso e molto largamente – Allegro non tanto – Allegro con brio – Grandioso e maestoso', part.name_en = 'Symphony no. 1, op. 14, JSkat 40: IV. Allegro – Allegro con brio – Meno mosso e molto largamente – Poco più mosso. Allegro non tanto – A tempo (Allegro con brio) – Pesante – Grandioso – Maestoso – Meno mosso e molto largamente – Allegro non tanto – Allegro con brio – Grandioso e maestoso',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 18253 AND p.composer_id = 207 AND part.part_key = 'musicbrainz:bd94b93d-4987-448c-bdb5-43700199fd53' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:bd94b93d-4987-448c-bdb5-43700199fd53', 4, 'IV', 'Allegro – Allegro con brio – Meno mosso e molto largamente – Poco più mosso. Allegro non tanto – A tempo (Allegro con brio) – Pesante – Grandioso – Maestoso – Meno mosso e molto largamente – Allegro non tanto – Allegro con brio – Grandioso e maestoso', 'Symphony no. 1, op. 14, JSkat 40: IV. Allegro – Allegro con brio – Meno mosso e molto largamente – Poco più mosso. Allegro non tanto – A tempo (Allegro con brio) – Pesante – Grandioso – Maestoso – Meno mosso e molto largamente – Allegro non tanto – Allegro con brio – Grandioso e maestoso', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 18253 AND p.composer_id = 207
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:bd94b93d-4987-448c-bdb5-43700199fd53'
);


-- None 교향곡 2번 "Asrael" C단조

UPDATE pieces piece
SET piece.title = '교향곡 2번 "Asrael" C단조', piece.title_en = 'Symphony no. 2, op. 27 "Asrael"',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 17768 AND piece.composer_id = 207
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'Andante sostenuto - Andante con moto e resoluto - Più pesante e maestoso', part.name_en = 'Symphony no. 2, op. 27 "Asrael": I. Andante sostenuto - Andante con moto e resoluto - Più pesante e maestoso',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 17768 AND p.composer_id = 207 AND part.part_key = 'musicbrainz:245fc947-d2c9-34c7-94b8-0785baca8b4d' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:245fc947-d2c9-34c7-94b8-0785baca8b4d', 1, 'I', 'Andante sostenuto - Andante con moto e resoluto - Più pesante e maestoso', 'Symphony no. 2, op. 27 "Asrael": I. Andante sostenuto - Andante con moto e resoluto - Più pesante e maestoso', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 17768 AND p.composer_id = 207
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:245fc947-d2c9-34c7-94b8-0785baca8b4d'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'Andante', part.name_en = 'Symphony no. 2, op. 27 "Asrael": II. Andante',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 17768 AND p.composer_id = 207 AND part.part_key = 'musicbrainz:c02935c0-9e9e-3957-ab54-652448f0eed4' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:c02935c0-9e9e-3957-ab54-652448f0eed4', 2, 'II', 'Andante', 'Symphony no. 2, op. 27 "Asrael": II. Andante', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 17768 AND p.composer_id = 207
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:c02935c0-9e9e-3957-ab54-652448f0eed4'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = 'Vivace - Andante sostenuto - Appassionato - Maestoso', part.name_en = 'Symphony no. 2, op. 27 "Asrael": III. Vivace - Andante sostenuto - Appassionato - Maestoso',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 17768 AND p.composer_id = 207 AND part.part_key = 'musicbrainz:af4e33e7-6c54-38ce-a52c-10b6c6775ad5' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:af4e33e7-6c54-38ce-a52c-10b6c6775ad5', 3, 'III', 'Vivace - Andante sostenuto - Appassionato - Maestoso', 'Symphony no. 2, op. 27 "Asrael": III. Vivace - Andante sostenuto - Appassionato - Maestoso', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 17768 AND p.composer_id = 207
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:af4e33e7-6c54-38ce-a52c-10b6c6775ad5'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = 'IV',
    part.name_ko = 'Adagio', part.name_en = 'Symphony no. 2, op. 27 "Asrael": IV. Adagio',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 17768 AND p.composer_id = 207 AND part.part_key = 'musicbrainz:c28813ed-f36d-3615-b857-9fb46428d062' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:c28813ed-f36d-3615-b857-9fb46428d062', 4, 'IV', 'Adagio', 'Symphony no. 2, op. 27 "Asrael": IV. Adagio', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 17768 AND p.composer_id = 207
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:c28813ed-f36d-3615-b857-9fb46428d062'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 5, part.movement_number = 'V',
    part.name_ko = 'Adagio e maestoso - Allegro appassionato - Adagio e maestoso - Andante maestoso - Adagio e mesto', part.name_en = 'Symphony no. 2, op. 27 "Asrael": V. Adagio e maestoso - Allegro appassionato - Adagio e maestoso - Andante maestoso - Adagio e mesto',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 17768 AND p.composer_id = 207 AND part.part_key = 'musicbrainz:e2949131-e4c4-3d4c-b0f9-7ab1037f066d' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:e2949131-e4c4-3d4c-b0f9-7ab1037f066d', 5, 'V', 'Adagio e maestoso - Allegro appassionato - Adagio e maestoso - Andante maestoso - Adagio e mesto', 'Symphony no. 2, op. 27 "Asrael": V. Adagio e maestoso - Allegro appassionato - Adagio e maestoso - Andante maestoso - Adagio e mesto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 17768 AND p.composer_id = 207
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:e2949131-e4c4-3d4c-b0f9-7ab1037f066d'
);


-- None Tempo di minuetto for String Quartet

UPDATE pieces piece
SET piece.title = 'Tempo di minuetto for String Quartet', piece.title_en = 'Tempo di minuetto for String Quartet',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 15732 AND piece.composer_id = 207
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- Op. 19 Tři zpěvy pro smíšený sbor Op. 19

UPDATE pieces piece
SET piece.title = 'Tři zpěvy pro smíšený sbor Op. 19', piece.title_en = 'Tři zpěvy pro smíšený sbor, op. 19',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = 'Op.', piece.catalogue_number = '19',
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 17361 AND piece.composer_id = 207
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'Zavedený ovčák, op. 19 no. 1', part.name_en = 'Zavedený ovčák, op. 19 no. 1',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 17361 AND p.composer_id = 207 AND part.part_key = 'musicbrainz:48aa641f-2205-43e0-9e52-9bd469eaee64' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:48aa641f-2205-43e0-9e52-9bd469eaee64', 1, NULL, 'Zavedený ovčák, op. 19 no. 1', 'Zavedený ovčák, op. 19 no. 1', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 17361 AND p.composer_id = 207
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:48aa641f-2205-43e0-9e52-9bd469eaee64'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'Mať moja, op. 19 no. 2', part.name_en = 'Mať moja, op. 19 no. 2',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 17361 AND p.composer_id = 207 AND part.part_key = 'musicbrainz:34ea3e0d-6c0e-4523-9a00-a0255e058d51' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:34ea3e0d-6c0e-4523-9a00-a0255e058d51', 2, NULL, 'Mať moja, op. 19 no. 2', 'Mať moja, op. 19 no. 2', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 17361 AND p.composer_id = 207
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:34ea3e0d-6c0e-4523-9a00-a0255e058d51'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = NULL,
    part.name_ko = 'Stasa čarodějnice, op. 19 no. 3', part.name_en = 'Stasa čarodějnice, op. 19 no. 3',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 17361 AND p.composer_id = 207 AND part.part_key = 'musicbrainz:41a9eeb7-35ab-414f-808f-eb48fa91e658' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:41a9eeb7-35ab-414f-808f-eb48fa91e658', 3, NULL, 'Stasa čarodějnice, op. 19 no. 3', 'Stasa čarodějnice, op. 19 no. 3', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 17361 AND p.composer_id = 207
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:41a9eeb7-35ab-414f-808f-eb48fa91e658'
);


-- Op. 33 Ukolébavky

UPDATE pieces piece
SET piece.title = 'Ukolébavky', piece.title_en = 'Ukolébavky, op. 33',
    piece.type = 'album', piece.opus_number = 'Op. 33',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 16350 AND piece.composer_id = 207
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'Nad spícími děcky. Andante sostenuto', part.name_en = 'Ukolébavky, op. 33: I. Nad spícími děcky. Andante sostenuto',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 16350 AND p.composer_id = 207 AND part.part_key = 'musicbrainz:2e9d65df-e3ba-494a-ac10-6941a43190de' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:2e9d65df-e3ba-494a-ac10-6941a43190de', 1, 'I', 'Nad spícími děcky. Andante sostenuto', 'Ukolébavky, op. 33: I. Nad spícími děcky. Andante sostenuto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 16350 AND p.composer_id = 207
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:2e9d65df-e3ba-494a-ac10-6941a43190de'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'Popěvek. Andante', part.name_en = 'Ukolébavky, op. 33: II. Popěvek. Andante',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 16350 AND p.composer_id = 207 AND part.part_key = 'musicbrainz:d1727520-dd3a-41b4-9579-7f6ed9ca0f6f' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:d1727520-dd3a-41b4-9579-7f6ed9ca0f6f', 2, 'II', 'Popěvek. Andante', 'Ukolébavky, op. 33: II. Popěvek. Andante', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 16350 AND p.composer_id = 207
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:d1727520-dd3a-41b4-9579-7f6ed9ca0f6f'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = 'Sentimentální sebeparodie na pouliční písničku. Andante quasi adagio', part.name_en = 'Ukolébavky, op. 33: III. Sentimentální sebeparodie na pouliční písničku. Andante quasi adagio',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 16350 AND p.composer_id = 207 AND part.part_key = 'musicbrainz:3d2dee74-4bbc-4e87-be6c-482f98c28bae' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:3d2dee74-4bbc-4e87-be6c-482f98c28bae', 3, 'III', 'Sentimentální sebeparodie na pouliční písničku. Andante quasi adagio', 'Ukolébavky, op. 33: III. Sentimentální sebeparodie na pouliční písničku. Andante quasi adagio', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 16350 AND p.composer_id = 207
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:3d2dee74-4bbc-4e87-be6c-482f98c28bae'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = 'IV',
    part.name_ko = 'K uzdravení. Andante moderato', part.name_en = 'Ukolébavky, op. 33: IV. K uzdravení. Andante moderato',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 16350 AND p.composer_id = 207 AND part.part_key = 'musicbrainz:bea135a1-871d-4434-8b94-8167d47c059c' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:bea135a1-871d-4434-8b94-8167d47c059c', 4, 'IV', 'K uzdravení. Andante moderato', 'Ukolébavky, op. 33: IV. K uzdravení. Andante moderato', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 16350 AND p.composer_id = 207
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:bea135a1-871d-4434-8b94-8167d47c059c'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 5, part.movement_number = 'V',
    part.name_ko = 'Vánoční sen dítěte. Moderato con moto', part.name_en = 'Ukolébavky, op. 33: V. Vánoční sen dítěte. Moderato con moto',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 16350 AND p.composer_id = 207 AND part.part_key = 'musicbrainz:95804a92-d211-4004-9df2-29d86b5c4553' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:95804a92-d211-4004-9df2-29d86b5c4553', 5, 'V', 'Vánoční sen dítěte. Moderato con moto', 'Ukolébavky, op. 33: V. Vánoční sen dítěte. Moderato con moto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 16350 AND p.composer_id = 207
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:95804a92-d211-4004-9df2-29d86b5c4553'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 6, part.movement_number = 'VI',
    part.name_ko = 'Smrti, přijď jen tiše. Andante con moto', part.name_en = 'Ukolébavky, op. 33: VI. Smrti, přijď jen tiše. Andante con moto',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 16350 AND p.composer_id = 207 AND part.part_key = 'musicbrainz:4e63cb4e-5330-492f-9c35-3c71f8175c50' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:4e63cb4e-5330-492f-9c35-3c71f8175c50', 6, 'VI', 'Smrti, přijď jen tiše. Andante con moto', 'Ukolébavky, op. 33: VI. Smrti, přijď jen tiše. Andante con moto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 16350 AND p.composer_id = 207
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:4e63cb4e-5330-492f-9c35-3c71f8175c50'
);


-- Op. 35c V nový život

UPDATE pieces piece
SET piece.title = 'V nový život', piece.title_en = 'V nový život, op. 35c',
    piece.type = 'song', piece.opus_number = 'Op. 35c',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 15777 AND piece.composer_id = 207
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- Op. 30 Životem a snem

UPDATE pieces piece
SET piece.title = 'Životem a snem', piece.title_en = 'Životem a snem, op. 30',
    piece.type = 'album', piece.opus_number = 'Op. 30',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 17555 AND piece.composer_id = 207
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'S humorem a ironií, místy rozdurděně. Alegretto moderato', part.name_en = 'Životem a snem, op. 30: I. S humorem a ironií, místy rozdurděně. Alegretto moderato',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 17555 AND p.composer_id = 207 AND part.part_key = 'musicbrainz:1991eeb4-be53-42fd-aff6-52c920facdd8' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:1991eeb4-be53-42fd-aff6-52c920facdd8', 1, 'I', 'S humorem a ironií, místy rozdurděně. Alegretto moderato', 'Životem a snem, op. 30: I. S humorem a ironií, místy rozdurděně. Alegretto moderato', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 17555 AND p.composer_id = 207
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:1991eeb4-be53-42fd-aff6-52c920facdd8'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'Neklidně a nesměle, bez silnějšího výrazu. Allegro vivo', part.name_en = 'Životem a snem, op. 30: II. Neklidně a nesměle, bez silnějšího výrazu. Allegro vivo',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 17555 AND p.composer_id = 207 AND part.part_key = 'musicbrainz:75fb3f7d-f507-45ea-a79a-dffb2bddf4cd' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:75fb3f7d-f507-45ea-a79a-dffb2bddf4cd', 2, 'II', 'Neklidně a nesměle, bez silnějšího výrazu. Allegro vivo', 'Životem a snem, op. 30: II. Neklidně a nesměle, bez silnějšího výrazu. Allegro vivo', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 17555 AND p.composer_id = 207
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:75fb3f7d-f507-45ea-a79a-dffb2bddf4cd'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = 'Tajemně a velmi vzrušeně. Andante sostenuto', part.name_en = 'Životem a snem, op. 30: III. Tajemně a velmi vzrušeně. Andante sostenuto',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 17555 AND p.composer_id = 207 AND part.part_key = 'musicbrainz:866dfb58-9e22-4477-a563-64552c058d0f' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:866dfb58-9e22-4477-a563-64552c058d0f', 3, 'III', 'Tajemně a velmi vzrušeně. Andante sostenuto', 'Životem a snem, op. 30: III. Tajemně a velmi vzrušeně. Andante sostenuto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 17555 AND p.composer_id = 207
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:866dfb58-9e22-4477-a563-64552c058d0f'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = 'IV',
    part.name_ko = 'Zamyšleně, později stále výbojněji. Poco allegretto', part.name_en = 'Životem a snem, op. 30: IV. Zamyšleně, později stále výbojněji. Poco allegretto',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 17555 AND p.composer_id = 207 AND part.part_key = 'musicbrainz:e8e9cc70-146b-42da-b6ab-f43f4d859599' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:e8e9cc70-146b-42da-b6ab-f43f4d859599', 4, 'IV', 'Zamyšleně, později stále výbojněji. Poco allegretto', 'Životem a snem, op. 30: IV. Zamyšleně, později stále výbojněji. Poco allegretto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 17555 AND p.composer_id = 207
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:e8e9cc70-146b-42da-b6ab-f43f4d859599'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 5, part.movement_number = 'V',
    part.name_ko = 'K uzdravení mého syna. Klidně, s hlubokým citem. Adagio', part.name_en = 'Životem a snem, op. 30: V. K uzdravení mého syna. Klidně, s hlubokým citem. Adagio',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 17555 AND p.composer_id = 207 AND part.part_key = 'musicbrainz:cf1177d1-84de-4eb6-b3fc-34ddbb916443' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:cf1177d1-84de-4eb6-b3fc-34ddbb916443', 5, 'V', 'K uzdravení mého syna. Klidně, s hlubokým citem. Adagio', 'Životem a snem, op. 30: V. K uzdravení mého syna. Klidně, s hlubokým citem. Adagio', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 17555 AND p.composer_id = 207
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:cf1177d1-84de-4eb6-b3fc-34ddbb916443'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 6, part.movement_number = 'VI',
    part.name_ko = 'S výrazem tiché, bezstarostné veselosti. Moderato quasi allegretto', part.name_en = 'Životem a snem, op. 30: VI. S výrazem tiché, bezstarostné veselosti. Moderato quasi allegretto',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 17555 AND p.composer_id = 207 AND part.part_key = 'musicbrainz:a89f4475-a66b-4791-acd9-b42cd45c25c9' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:a89f4475-a66b-4791-acd9-b42cd45c25c9', 6, 'VI', 'S výrazem tiché, bezstarostné veselosti. Moderato quasi allegretto', 'Životem a snem, op. 30: VI. S výrazem tiché, bezstarostné veselosti. Moderato quasi allegretto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 17555 AND p.composer_id = 207
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:a89f4475-a66b-4791-acd9-b42cd45c25c9'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 7, part.movement_number = 'VII',
    part.name_ko = 'Jednoduše - později s výrazem drtivé moci. Adagio non tanto', part.name_en = 'Životem a snem, op. 30: VII. Jednoduše - později s výrazem drtivé moci. Adagio non tanto',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 17555 AND p.composer_id = 207 AND part.part_key = 'musicbrainz:603f06bd-8043-445f-ae49-75aaaab6977c' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:603f06bd-8043-445f-ae49-75aaaab6977c', 7, 'VII', 'Jednoduše - později s výrazem drtivé moci. Adagio non tanto', 'Životem a snem, op. 30: VII. Jednoduše - později s výrazem drtivé moci. Adagio non tanto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 17555 AND p.composer_id = 207
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:603f06bd-8043-445f-ae49-75aaaab6977c'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 8, part.movement_number = 'VIII',
    part.name_ko = 'Jemně, švitorně. Vivace', part.name_en = 'Životem a snem, op. 30: VIII. Jemně, švitorně. Vivace',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 17555 AND p.composer_id = 207 AND part.part_key = 'musicbrainz:e66f39a4-4789-4c9e-b936-0f78b1be5d0f' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:e66f39a4-4789-4c9e-b936-0f78b1be5d0f', 8, 'VIII', 'Jemně, švitorně. Vivace', 'Životem a snem, op. 30: VIII. Jemně, švitorně. Vivace', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 17555 AND p.composer_id = 207
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:e66f39a4-4789-4c9e-b936-0f78b1be5d0f'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 9, part.movement_number = 'IX',
    part.name_ko = 'Šepotavě a tajemně. Poco andante', part.name_en = 'Životem a snem, op. 30: IX. Šepotavě a tajemně. Poco andante',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 17555 AND p.composer_id = 207 AND part.part_key = 'musicbrainz:0da14741-61c4-4d39-bb0d-97df51ed658b' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:0da14741-61c4-4d39-bb0d-97df51ed658b', 9, 'IX', 'Šepotavě a tajemně. Poco andante', 'Životem a snem, op. 30: IX. Šepotavě a tajemně. Poco andante', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 17555 AND p.composer_id = 207
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:0da14741-61c4-4d39-bb0d-97df51ed658b'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 10, part.movement_number = 'X',
    part.name_ko = 'Zapomenutým rovům v koutku hřbitova křečovického. Snivě. Adagio', part.name_en = 'Životem a snem, op. 30: X. Zapomenutým rovům v koutku hřbitova křečovického. Snivě. Adagio',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 17555 AND p.composer_id = 207 AND part.part_key = 'musicbrainz:f300c8f4-094c-4a06-a552-fdfb52dd6b2b' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:f300c8f4-094c-4a06-a552-fdfb52dd6b2b', 10, 'X', 'Zapomenutým rovům v koutku hřbitova křečovického. Snivě. Adagio', 'Životem a snem, op. 30: X. Zapomenutým rovům v koutku hřbitova křečovického. Snivě. Adagio', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 17555 AND p.composer_id = 207
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:f300c8f4-094c-4a06-a552-fdfb52dd6b2b'
);


-- Op. 23 Elegie (pod dojmem Zeyerova Vyšehradu)

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, 'Elegie (pod dojmem Zeyerova Vyšehradu)', 'Elegie (pod dojmem Zeyerova Vyšehradu), op. 23', 'song', 'Op. 23', NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 207
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = 'Elegie (pod dojmem Zeyerova Vyšehradu)'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '80d3ff04-9d1e-4c6c-b02d-097e5ceac74c'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '80d3ff04-9d1e-4c6c-b02d-097e5ceac74c'
FROM pieces p
WHERE p.composer_id = 207 AND p.title = 'Elegie (pod dojmem Zeyerova Vyšehradu)' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '80d3ff04-9d1e-4c6c-b02d-097e5ceac74c'
);


-- 카탈로그에 대응이 없는 seed 작품 1개를 목록에서 숨긴다(지우지 않음).
UPDATE pieces piece
SET piece.hidden_reason = 'catalog_unmatched'
WHERE piece.composer_id = 207 AND piece.origin = 'seed' AND piece.hidden_reason IS NULL
  AND piece.id IN (
    15780
  )
  AND NOT EXISTS (SELECT 1 FROM performance_sectors sector WHERE sector.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM piece_parts linking WHERE linking.linked_piece_id = piece.id);
