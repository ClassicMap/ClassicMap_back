-- 베리오 작품을 MusicBrainz 작품 구조로 다시 짠다(4차 자동). 작품 92개(묶음 6, 다악장 10, 낱곡 76),
-- 새 작품 5개, part 153개, 그 아래 0개.
-- seed 102개 중 85개를 작품·part 에 잇고, 17개를 숨기고, 0개는 그대로 둔다.
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

-- None Allelujah I

UPDATE pieces piece
SET piece.title = 'Allelujah I', piece.title_en = 'Allelujah I',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 7706 AND piece.composer_id = 109
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Altra voce

UPDATE pieces piece
SET piece.title = 'Altra voce', piece.title_en = 'Altra voce',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 9897 AND piece.composer_id = 109
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Call

UPDATE pieces piece
SET piece.title = 'Call', piece.title_en = 'Call',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 7609 AND piece.composer_id = 109
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Chamber Music

UPDATE pieces piece
SET piece.title = 'Chamber Music', piece.title_en = 'Chamber Music',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 7687 AND piece.composer_id = 109
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'Strings in the Earth', part.name_en = 'Chamber Music: I. Strings in the Earth',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 7687 AND p.composer_id = 109 AND part.part_key = 'musicbrainz:7fd02bef-eb5f-4e53-bd27-ea98f5813916' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:7fd02bef-eb5f-4e53-bd27-ea98f5813916', 1, 'I', 'Strings in the Earth', 'Chamber Music: I. Strings in the Earth', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 7687 AND p.composer_id = 109
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:7fd02bef-eb5f-4e53-bd27-ea98f5813916'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'All Day', part.name_en = 'Chamber Music: II. All Day',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 7687 AND p.composer_id = 109 AND part.part_key = 'musicbrainz:7c41f24c-1439-49e5-800a-13cd5b5c5d0d' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:7c41f24c-1439-49e5-800a-13cd5b5c5d0d', 2, 'II', 'All Day', 'Chamber Music: II. All Day', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 7687 AND p.composer_id = 109
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:7c41f24c-1439-49e5-800a-13cd5b5c5d0d'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = 'Winds of May', part.name_en = 'Chamber Music: III. Winds of May',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 7687 AND p.composer_id = 109 AND part.part_key = 'musicbrainz:c89929e9-bf83-4908-be52-36a144a2bbe0' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:c89929e9-bf83-4908-be52-36a144a2bbe0', 3, 'III', 'Winds of May', 'Chamber Music: III. Winds of May', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 7687 AND p.composer_id = 109
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:c89929e9-bf83-4908-be52-36a144a2bbe0'
);


-- None Chanson pour Pierre Boulez

UPDATE pieces piece
SET piece.title = 'Chanson pour Pierre Boulez', piece.title_en = 'Chanson pour Pierre Boulez',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 8711 AND piece.composer_id = 109
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Chants parallèles

UPDATE pieces piece
SET piece.title = 'Chants parallèles', piece.title_en = 'Chants parallèles',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 7880 AND piece.composer_id = 109
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Chemins II

UPDATE pieces piece
SET piece.title = 'Chemins II', piece.title_en = 'Chemins II',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 7689 AND piece.composer_id = 109
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Chemins IIb

UPDATE pieces piece
SET piece.title = 'Chemins IIb', piece.title_en = 'Chemins IIb',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 8656 AND piece.composer_id = 109
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Chemins IIc

UPDATE pieces piece
SET piece.title = 'Chemins IIc', piece.title_en = 'Chemins IIc',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 10706 AND piece.composer_id = 109
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Chemins IV

UPDATE pieces piece
SET piece.title = 'Chemins IV', piece.title_en = 'Chemins IV',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 10363 AND piece.composer_id = 109
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Circles

UPDATE pieces piece
SET piece.title = 'Circles', piece.title_en = 'Circles',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 7679 AND piece.composer_id = 109
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'Stinging', part.name_en = 'Circles: I. Stinging',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 7679 AND p.composer_id = 109 AND part.part_key = 'musicbrainz:46339e48-6c9f-47fa-98e4-d9af0dd53487' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:46339e48-6c9f-47fa-98e4-d9af0dd53487', 1, 'I', 'Stinging', 'Circles: I. Stinging', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 7679 AND p.composer_id = 109
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:46339e48-6c9f-47fa-98e4-d9af0dd53487'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'Riverly Is a Flower', part.name_en = 'Circles: II. Riverly Is a Flower',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 7679 AND p.composer_id = 109 AND part.part_key = 'musicbrainz:7ce90bd9-c997-4fc5-8795-6dbd4ebdde1b' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:7ce90bd9-c997-4fc5-8795-6dbd4ebdde1b', 2, 'II', 'Riverly Is a Flower', 'Circles: II. Riverly Is a Flower', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 7679 AND p.composer_id = 109
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:7ce90bd9-c997-4fc5-8795-6dbd4ebdde1b'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = 'N(o)w', part.name_en = 'Circles: III. N(o)w',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 7679 AND p.composer_id = 109 AND part.part_key = 'musicbrainz:074fd2f3-aec4-45a0-926a-0c58bbafbb9f' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:074fd2f3-aec4-45a0-926a-0c58bbafbb9f', 3, 'III', 'N(o)w', 'Circles: III. N(o)w', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 7679 AND p.composer_id = 109
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:074fd2f3-aec4-45a0-926a-0c58bbafbb9f'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = 'IV',
    part.name_ko = 'Riverly Is a Flower', part.name_en = 'Circles: IV. Riverly Is a Flower',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 7679 AND p.composer_id = 109 AND part.part_key = 'musicbrainz:223f32a9-47bf-48b1-829a-8a93a4b074c9' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:223f32a9-47bf-48b1-829a-8a93a4b074c9', 4, 'IV', 'Riverly Is a Flower', 'Circles: IV. Riverly Is a Flower', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 7679 AND p.composer_id = 109
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:223f32a9-47bf-48b1-829a-8a93a4b074c9'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 5, part.movement_number = 'V',
    part.name_ko = 'Stinging', part.name_en = 'Circles: V. Stinging',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 7679 AND p.composer_id = 109 AND part.part_key = 'musicbrainz:3b3c0f41-c1bd-4ad8-bacd-a7dcc7e85526' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:3b3c0f41-c1bd-4ad8-bacd-a7dcc7e85526', 5, 'V', 'Stinging', 'Circles: V. Stinging', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 7679 AND p.composer_id = 109
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:3b3c0f41-c1bd-4ad8-bacd-a7dcc7e85526'
);


-- None Comma

UPDATE pieces piece
SET piece.title = 'Comma', piece.title_en = 'Comma',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 9706 AND piece.composer_id = 109
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None 콘체르티노

UPDATE pieces piece
SET piece.title = '콘체르티노', piece.title_en = 'Concertino',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 10197 AND piece.composer_id = 109
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Concerto II "Echoing Curves"

UPDATE pieces piece
SET piece.title = 'Concerto II "Echoing Curves"', piece.title_en = 'Concerto II "Echoing Curves"',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 8264 AND piece.composer_id = 109
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Concerto for Two Pianos and Orchestra

UPDATE pieces piece
SET piece.title = 'Concerto for Two Pianos and Orchestra', piece.title_en = 'Concerto for Two Pianos and Orchestra',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 10937 AND piece.composer_id = 109
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Continuo

UPDATE pieces piece
SET piece.title = 'Continuo', piece.title_en = 'Continuo',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 9628 AND piece.composer_id = 109
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Coro

UPDATE pieces piece
SET piece.title = 'Coro', piece.title_en = 'Coro',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 10528 AND piece.composer_id = 109
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'Today Is Mine. Wake Up, Woman, Rise Up, Woman', part.name_en = 'Coro: No. 1. Today Is Mine. Wake Up, Woman, Rise Up, Woman',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 10528 AND p.composer_id = 109 AND part.part_key = 'musicbrainz:bd3102c1-a54e-4206-a0de-2cccac2620c9' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:bd3102c1-a54e-4206-a0de-2cccac2620c9', 1, NULL, 'Today Is Mine. Wake Up, Woman, Rise Up, Woman', 'Coro: No. 1. Today Is Mine. Wake Up, Woman, Rise Up, Woman', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 10528 AND p.composer_id = 109
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:bd3102c1-a54e-4206-a0de-2cccac2620c9'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'Venid a ver', part.name_en = 'Coro: No. 2. Venid a ver',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 10528 AND p.composer_id = 109 AND part.part_key = 'musicbrainz:b46f6ddd-c433-4524-9a7e-8bd1da6bd193' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:b46f6ddd-c433-4524-9a7e-8bd1da6bd193', 2, NULL, 'Venid a ver', 'Coro: No. 2. Venid a ver', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 10528 AND p.composer_id = 109
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:b46f6ddd-c433-4524-9a7e-8bd1da6bd193'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = NULL,
    part.name_ko = 'Your Eyes Are Red', part.name_en = 'Coro: No. 3. Your Eyes Are Red',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 10528 AND p.composer_id = 109 AND part.part_key = 'musicbrainz:9b71daf7-51e2-406e-8d2d-c80ffbe8747b' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:9b71daf7-51e2-406e-8d2d-c80ffbe8747b', 3, NULL, 'Your Eyes Are Red', 'Coro: No. 3. Your Eyes Are Red', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 10528 AND p.composer_id = 109
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:9b71daf7-51e2-406e-8d2d-c80ffbe8747b'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = NULL,
    part.name_ko = 'Venid a ver', part.name_en = 'Coro: No. 4. Venid a ver',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 10528 AND p.composer_id = 109 AND part.part_key = 'musicbrainz:854b17c7-64f8-4937-9486-177dabd97f73' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:854b17c7-64f8-4937-9486-177dabd97f73', 4, NULL, 'Venid a ver', 'Coro: No. 4. Venid a ver', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 10528 AND p.composer_id = 109
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:854b17c7-64f8-4937-9486-177dabd97f73'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 5, part.movement_number = NULL,
    part.name_ko = 'Your Eyes Are Red', part.name_en = 'Coro: No. 5. Your Eyes Are Red',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 10528 AND p.composer_id = 109 AND part.part_key = 'musicbrainz:04ca3598-8507-4366-ae5e-f19cb610af2f' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:04ca3598-8507-4366-ae5e-f19cb610af2f', 5, NULL, 'Your Eyes Are Red', 'Coro: No. 5. Your Eyes Are Red', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 10528 AND p.composer_id = 109
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:04ca3598-8507-4366-ae5e-f19cb610af2f'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 6, part.movement_number = NULL,
    part.name_ko = 'Venid a ver la sangre por las calles', part.name_en = 'Coro: No. 6. Venid a ver la sangre por las calles',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 10528 AND p.composer_id = 109 AND part.part_key = 'musicbrainz:cbfb8327-6257-4904-b851-d7238ad8fce1' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:cbfb8327-6257-4904-b851-d7238ad8fce1', 6, NULL, 'Venid a ver la sangre por las calles', 'Coro: No. 6. Venid a ver la sangre por las calles', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 10528 AND p.composer_id = 109
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:cbfb8327-6257-4904-b851-d7238ad8fce1'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 7, part.movement_number = NULL,
    part.name_ko = 'Wake Up, Woman, Rise Up, Woman', part.name_en = 'Coro: No. 7. Wake Up, Woman, Rise Up, Woman',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 10528 AND p.composer_id = 109 AND part.part_key = 'musicbrainz:9e358885-7714-42b2-a36c-ef84b4747bc5' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:9e358885-7714-42b2-a36c-ef84b4747bc5', 7, NULL, 'Wake Up, Woman, Rise Up, Woman', 'Coro: No. 7. Wake Up, Woman, Rise Up, Woman', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 10528 AND p.composer_id = 109
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:9e358885-7714-42b2-a36c-ef84b4747bc5'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 8, part.movement_number = NULL,
    part.name_ko = 'Venid a ver la sangre por las calles', part.name_en = 'Coro: No. 8. Venid a ver la sangre por las calles',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 10528 AND p.composer_id = 109 AND part.part_key = 'musicbrainz:c3f629fe-4fcd-459a-b302-2994910129f8' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:c3f629fe-4fcd-459a-b302-2994910129f8', 8, NULL, 'Venid a ver la sangre por las calles', 'Coro: No. 8. Venid a ver la sangre por las calles', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 10528 AND p.composer_id = 109
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:c3f629fe-4fcd-459a-b302-2994910129f8'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 9, part.movement_number = NULL,
    part.name_ko = 'I Have Made a Song', part.name_en = 'Coro: No. 9. I Have Made a Song',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 10528 AND p.composer_id = 109 AND part.part_key = 'musicbrainz:59db0057-a581-45a7-94a2-42e6f14d33bf' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:59db0057-a581-45a7-94a2-42e6f14d33bf', 9, NULL, 'I Have Made a Song', 'Coro: No. 9. I Have Made a Song', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 10528 AND p.composer_id = 109
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:59db0057-a581-45a7-94a2-42e6f14d33bf'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 10, part.movement_number = NULL,
    part.name_ko = 'Venid a ver la sangre por las calles', part.name_en = 'Coro: No. 10. Venid a ver la sangre por las calles',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 10528 AND p.composer_id = 109 AND part.part_key = 'musicbrainz:66065708-dd3c-44ee-bc56-dde99c78cea9' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:66065708-dd3c-44ee-bc56-dde99c78cea9', 10, NULL, 'Venid a ver la sangre por las calles', 'Coro: No. 10. Venid a ver la sangre por las calles', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 10528 AND p.composer_id = 109
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:66065708-dd3c-44ee-bc56-dde99c78cea9'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 11, part.movement_number = NULL,
    part.name_ko = 'I Have Made a Song', part.name_en = 'Coro: No. 11. I Have Made a Song',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 10528 AND p.composer_id = 109 AND part.part_key = 'musicbrainz:c7e976d8-d67b-477e-9f51-055520fa82bb' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:c7e976d8-d67b-477e-9f51-055520fa82bb', 11, NULL, 'I Have Made a Song', 'Coro: No. 11. I Have Made a Song', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 10528 AND p.composer_id = 109
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:c7e976d8-d67b-477e-9f51-055520fa82bb'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 12, part.movement_number = NULL,
    part.name_ko = 'Venid a ver la sangre', part.name_en = 'Coro: No. 12. Venid a ver la sangre',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 10528 AND p.composer_id = 109 AND part.part_key = 'musicbrainz:ffab8993-93c6-4828-908f-266089d6d47f' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:ffab8993-93c6-4828-908f-266089d6d47f', 12, NULL, 'Venid a ver la sangre', 'Coro: No. 12. Venid a ver la sangre', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 10528 AND p.composer_id = 109
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:ffab8993-93c6-4828-908f-266089d6d47f'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 13, part.movement_number = NULL,
    part.name_ko = 'Wake Up, Woman, Rise Up, Woman', part.name_en = 'Coro: No. 13. Wake Up, Woman, Rise Up, Woman',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 10528 AND p.composer_id = 109 AND part.part_key = 'musicbrainz:f5afc2f4-4549-4ba4-a08c-dc3fde08a21e' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:f5afc2f4-4549-4ba4-a08c-dc3fde08a21e', 13, NULL, 'Wake Up, Woman, Rise Up, Woman', 'Coro: No. 13. Wake Up, Woman, Rise Up, Woman', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 10528 AND p.composer_id = 109
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:f5afc2f4-4549-4ba4-a08c-dc3fde08a21e'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 14, part.movement_number = NULL,
    part.name_ko = 'Venid a ver la sangre', part.name_en = 'Coro: No. 14. Venid a ver la sangre',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 10528 AND p.composer_id = 109 AND part.part_key = 'musicbrainz:1436d19f-e79b-463e-8349-b25c52d2c9f5' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:1436d19f-e79b-463e-8349-b25c52d2c9f5', 14, NULL, 'Venid a ver la sangre', 'Coro: No. 14. Venid a ver la sangre', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 10528 AND p.composer_id = 109
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:1436d19f-e79b-463e-8349-b25c52d2c9f5'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 15, part.movement_number = NULL,
    part.name_ko = 'Komm in meine Nähe', part.name_en = 'Coro: No. 15. Komm in meine Nähe',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 10528 AND p.composer_id = 109 AND part.part_key = 'musicbrainz:ed0d034b-a578-46e6-8da3-3200f1df1f7d' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:ed0d034b-a578-46e6-8da3-3200f1df1f7d', 15, NULL, 'Komm in meine Nähe', 'Coro: No. 15. Komm in meine Nähe', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 10528 AND p.composer_id = 109
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:ed0d034b-a578-46e6-8da3-3200f1df1f7d'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 16, part.movement_number = NULL,
    part.name_ko = 'Today Is Mine', part.name_en = 'Coro: No. 16. Today Is Mine',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 10528 AND p.composer_id = 109 AND part.part_key = 'musicbrainz:5c6f74ec-4298-4c06-8fde-707ccb6b268c' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:5c6f74ec-4298-4c06-8fde-707ccb6b268c', 16, NULL, 'Today Is Mine', 'Coro: No. 16. Today Is Mine', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 10528 AND p.composer_id = 109
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:5c6f74ec-4298-4c06-8fde-707ccb6b268c'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 17, part.movement_number = NULL,
    part.name_ko = 'Pousse l''herbe et fleurit la fleur', part.name_en = 'Coro: No. 17. Pousse l''herbe et fleurit la fleur',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 10528 AND p.composer_id = 109 AND part.part_key = 'musicbrainz:25fe7485-7b32-404e-81df-a7ad8ef18e5a' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:25fe7485-7b32-404e-81df-a7ad8ef18e5a', 17, NULL, 'Pousse l''herbe et fleurit la fleur', 'Coro: No. 17. Pousse l''herbe et fleurit la fleur', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 10528 AND p.composer_id = 109
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:25fe7485-7b32-404e-81df-a7ad8ef18e5a'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 18, part.movement_number = NULL,
    part.name_ko = 'Go, My Strong Charm. Venid a ver', part.name_en = 'Coro: No. 18. Go, My Strong Charm. Venid a ver',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 10528 AND p.composer_id = 109 AND part.part_key = 'musicbrainz:618aa9f9-55cd-4fb1-8249-17400257a83f' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:618aa9f9-55cd-4fb1-8249-17400257a83f', 18, NULL, 'Go, My Strong Charm. Venid a ver', 'Coro: No. 18. Go, My Strong Charm. Venid a ver', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 10528 AND p.composer_id = 109
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:618aa9f9-55cd-4fb1-8249-17400257a83f'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 19, part.movement_number = NULL,
    part.name_ko = 'It Is So Nice', part.name_en = 'Coro: No. 19. It Is So Nice',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 10528 AND p.composer_id = 109 AND part.part_key = 'musicbrainz:2e9609ae-01b4-4b00-a45d-611f56b5e988' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:2e9609ae-01b4-4b00-a45d-611f56b5e988', 19, NULL, 'It Is So Nice', 'Coro: No. 19. It Is So Nice', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 10528 AND p.composer_id = 109
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:2e9609ae-01b4-4b00-a45d-611f56b5e988'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 20, part.movement_number = NULL,
    part.name_ko = 'Your Eyes Are Red. El día pálido se asoma', part.name_en = 'Coro: No. 20. Your Eyes Are Red. El día pálido se asoma',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 10528 AND p.composer_id = 109 AND part.part_key = 'musicbrainz:1fb3b98e-6fa0-479f-95e8-e2bd4f3598f2' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:1fb3b98e-6fa0-479f-95e8-e2bd4f3598f2', 20, NULL, 'Your Eyes Are Red. El día pálido se asoma', 'Coro: No. 20. Your Eyes Are Red. El día pálido se asoma', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 10528 AND p.composer_id = 109
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:1fb3b98e-6fa0-479f-95e8-e2bd4f3598f2'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 21, part.movement_number = NULL,
    part.name_ko = 'Mirad mi casa muerta', part.name_en = 'Coro: No. 21. Mirad mi casa muerta',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 10528 AND p.composer_id = 109 AND part.part_key = 'musicbrainz:5bf9752d-56c3-4ff6-9274-67e4520ce01c' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:5bf9752d-56c3-4ff6-9274-67e4520ce01c', 21, NULL, 'Mirad mi casa muerta', 'Coro: No. 21. Mirad mi casa muerta', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 10528 AND p.composer_id = 109
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:5bf9752d-56c3-4ff6-9274-67e4520ce01c'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 22, part.movement_number = NULL,
    part.name_ko = 'Je m''en vais où ma pensée s''en va', part.name_en = 'Coro: No. 22. Je m''en vais où ma pensée s''en va',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 10528 AND p.composer_id = 109 AND part.part_key = 'musicbrainz:950e1a59-e471-493e-9bed-6100e8fe222e' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:950e1a59-e471-493e-9bed-6100e8fe222e', 22, NULL, 'Je m''en vais où ma pensée s''en va', 'Coro: No. 22. Je m''en vais où ma pensée s''en va', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 10528 AND p.composer_id = 109
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:950e1a59-e471-493e-9bed-6100e8fe222e'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 23, part.movement_number = NULL,
    part.name_ko = 'Pousse l''herbe et fleurit la fleur', part.name_en = 'Coro: No. 23. Pousse l''herbe et fleurit la fleur',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 10528 AND p.composer_id = 109 AND part.part_key = 'musicbrainz:c453543b-6f54-4903-8a31-12b7f6be0bd8' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:c453543b-6f54-4903-8a31-12b7f6be0bd8', 23, NULL, 'Pousse l''herbe et fleurit la fleur', 'Coro: No. 23. Pousse l''herbe et fleurit la fleur', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 10528 AND p.composer_id = 109
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:c453543b-6f54-4903-8a31-12b7f6be0bd8'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 24, part.movement_number = NULL,
    part.name_ko = 'Oh issa. Ich sehe Tautropfen. Your Eyes Are Red', part.name_en = 'Coro: No. 24. Oh issa. Ich sehe Tautropfen. Your Eyes Are Red',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 10528 AND p.composer_id = 109 AND part.part_key = 'musicbrainz:e70e7473-e05d-417a-bb3d-1503188e8148' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:e70e7473-e05d-417a-bb3d-1503188e8148', 24, NULL, 'Oh issa. Ich sehe Tautropfen. Your Eyes Are Red', 'Coro: No. 24. Oh issa. Ich sehe Tautropfen. Your Eyes Are Red', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 10528 AND p.composer_id = 109
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:e70e7473-e05d-417a-bb3d-1503188e8148'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 25, part.movement_number = NULL,
    part.name_ko = 'Oh issa lo in alto. Komm in meine Nähe', part.name_en = 'Coro: No. 25. Oh issa lo in alto. Komm in meine Nähe',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 10528 AND p.composer_id = 109 AND part.part_key = 'musicbrainz:b4c3bf43-4e31-4350-bf97-890f5c97bdc5' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:b4c3bf43-4e31-4350-bf97-890f5c97bdc5', 25, NULL, 'Oh issa lo in alto. Komm in meine Nähe', 'Coro: No. 25. Oh issa lo in alto. Komm in meine Nähe', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 10528 AND p.composer_id = 109
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:b4c3bf43-4e31-4350-bf97-890f5c97bdc5'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 26, part.movement_number = NULL,
    part.name_ko = 'Come Ascend the Ladder', part.name_en = 'Coro: No. 26. Come Ascend the Ladder',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 10528 AND p.composer_id = 109 AND part.part_key = 'musicbrainz:e90cfdc3-c508-4126-8c71-a39c6588b13d' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:e90cfdc3-c508-4126-8c71-a39c6588b13d', 26, NULL, 'Come Ascend the Ladder', 'Coro: No. 26. Come Ascend the Ladder', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 10528 AND p.composer_id = 109
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:e90cfdc3-c508-4126-8c71-a39c6588b13d'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 27, part.movement_number = NULL,
    part.name_ko = 'When We Came to This World', part.name_en = 'Coro: No. 27. When We Came to This World',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 10528 AND p.composer_id = 109 AND part.part_key = 'musicbrainz:1279ef8c-d3f3-4d66-87f1-30c6738d2eb4' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:1279ef8c-d3f3-4d66-87f1-30c6738d2eb4', 27, NULL, 'When We Came to This World', 'Coro: No. 27. When We Came to This World', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 10528 AND p.composer_id = 109
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:1279ef8c-d3f3-4d66-87f1-30c6738d2eb4'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 28, part.movement_number = NULL,
    part.name_ko = 'El día oscila rodeado', part.name_en = 'Coro: No. 28. El día oscila rodeado',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 10528 AND p.composer_id = 109 AND part.part_key = 'musicbrainz:f8255b0d-d90b-4d1f-95f1-bdf113a3b3f1' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:f8255b0d-d90b-4d1f-95f1-bdf113a3b3f1', 28, NULL, 'El día oscila rodeado', 'Coro: No. 28. El día oscila rodeado', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 10528 AND p.composer_id = 109
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:f8255b0d-d90b-4d1f-95f1-bdf113a3b3f1'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 29, part.movement_number = NULL,
    part.name_ko = 'Hinach yafà raayatí', part.name_en = 'Coro: No. 29. Hinach yafà raayatí',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 10528 AND p.composer_id = 109 AND part.part_key = 'musicbrainz:08afc709-2d65-4db0-8435-75b70cad241c' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:08afc709-2d65-4db0-8435-75b70cad241c', 29, NULL, 'Hinach yafà raayatí', 'Coro: No. 29. Hinach yafà raayatí', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 10528 AND p.composer_id = 109
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:08afc709-2d65-4db0-8435-75b70cad241c'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 30, part.movement_number = NULL,
    part.name_ko = 'El día pálido se asoma', part.name_en = 'Coro: No. 30. El día pálido se asoma',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 10528 AND p.composer_id = 109 AND part.part_key = 'musicbrainz:57572a11-7174-4a9d-9028-8d0d54912625' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:57572a11-7174-4a9d-9028-8d0d54912625', 30, NULL, 'El día pálido se asoma', 'Coro: No. 30. El día pálido se asoma', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 10528 AND p.composer_id = 109
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:57572a11-7174-4a9d-9028-8d0d54912625'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 31, part.movement_number = NULL,
    part.name_ko = 'Spin, Colours, Spin. El día pálido se asoma', part.name_en = 'Coro: No. 31. Spin, Colours, Spin. El día pálido se asoma',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 10528 AND p.composer_id = 109 AND part.part_key = 'musicbrainz:8341c482-14ab-4f1a-91ea-9813211307d6' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:8341c482-14ab-4f1a-91ea-9813211307d6', 31, NULL, 'Spin, Colours, Spin. El día pálido se asoma', 'Coro: No. 31. Spin, Colours, Spin. El día pálido se asoma', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 10528 AND p.composer_id = 109
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:8341c482-14ab-4f1a-91ea-9813211307d6'
);


-- None 오페라 <Diario immaginario>

UPDATE pieces piece
SET piece.title = '오페라 <Diario immaginario>', piece.title_en = 'Diario immaginario',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 10023 AND piece.composer_id = 109
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Différences

UPDATE pieces piece
SET piece.title = 'Différences', piece.title_en = 'Différences',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 10402 AND piece.composer_id = 109
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Due pezzi

UPDATE pieces piece
SET piece.title = 'Due pezzi', piece.title_en = 'Due pezzi',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 8198 AND piece.composer_id = 109
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'Calmo', part.name_en = 'Due pezzi: I. Calmo',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 8198 AND p.composer_id = 109 AND part.part_key = 'musicbrainz:704776e7-185d-4b9e-889a-0028040a3482' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:704776e7-185d-4b9e-889a-0028040a3482', 1, 'I', 'Calmo', 'Due pezzi: I. Calmo', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 8198 AND p.composer_id = 109
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:704776e7-185d-4b9e-889a-0028040a3482'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'Quasi allegro, alla marcia', part.name_en = 'Due pezzi: II. Quasi allegro, alla marcia',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 8198 AND p.composer_id = 109 AND part.part_key = 'musicbrainz:5d066001-77ca-4d9c-ad3f-90b5c522c90f' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:5d066001-77ca-4d9c-ad3f-90b5c522c90f', 2, 'II', 'Quasi allegro, alla marcia', 'Due pezzi: II. Quasi allegro, alla marcia', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 8198 AND p.composer_id = 109
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:5d066001-77ca-4d9c-ad3f-90b5c522c90f'
);


-- None Duetti per due violini

UPDATE pieces piece
SET piece.title = 'Duetti per due violini', piece.title_en = 'Duetti per due violini',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 9868 AND piece.composer_id = 109
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'Béla (Bartók)', part.name_en = 'Duetti per due violini: No. 1. Béla (Bartók)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 9868 AND p.composer_id = 109 AND part.part_key = 'musicbrainz:47fd7838-c759-4a8b-b4c5-a0a20c406ec6' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:47fd7838-c759-4a8b-b4c5-a0a20c406ec6', 1, NULL, 'Béla (Bartók)', 'Duetti per due violini: No. 1. Béla (Bartók)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 9868 AND p.composer_id = 109
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:47fd7838-c759-4a8b-b4c5-a0a20c406ec6'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'Shlomit (Almog)', part.name_en = 'Duetti per due violini: No. 2. Shlomit (Almog)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 9868 AND p.composer_id = 109 AND part.part_key = 'musicbrainz:4bdc2419-4088-4a9e-abf0-876a7942621e' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:4bdc2419-4088-4a9e-abf0-876a7942621e', 2, NULL, 'Shlomit (Almog)', 'Duetti per due violini: No. 2. Shlomit (Almog)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 9868 AND p.composer_id = 109
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:4bdc2419-4088-4a9e-abf0-876a7942621e'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = NULL,
    part.name_ko = 'Yossi (Peeker)', part.name_en = 'Duetti per due violini: No. 3. Yossi (Peeker)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 9868 AND p.composer_id = 109 AND part.part_key = 'musicbrainz:f34f54f7-d59e-42e2-9451-89556bd5738d' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:f34f54f7-d59e-42e2-9451-89556bd5738d', 3, NULL, 'Yossi (Peeker)', 'Duetti per due violini: No. 3. Yossi (Peeker)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 9868 AND p.composer_id = 109
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:f34f54f7-d59e-42e2-9451-89556bd5738d'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = NULL,
    part.name_ko = 'Rodion (Shehedrin)', part.name_en = 'Duetti per due violini: No. 4. Rodion (Shehedrin)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 9868 AND p.composer_id = 109 AND part.part_key = 'musicbrainz:8d5d9ae5-def2-4684-ba1d-09602cddf9f7' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:8d5d9ae5-def2-4684-ba1d-09602cddf9f7', 4, NULL, 'Rodion (Shehedrin)', 'Duetti per due violini: No. 4. Rodion (Shehedrin)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 9868 AND p.composer_id = 109
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:8d5d9ae5-def2-4684-ba1d-09602cddf9f7'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 5, part.movement_number = NULL,
    part.name_ko = 'Maja (Pliseekaja)', part.name_en = 'Duetti per due violini: No. 5. Maja (Pliseekaja)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 9868 AND p.composer_id = 109 AND part.part_key = 'musicbrainz:871dfe1b-7443-47c9-bd27-7015aae293fa' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:871dfe1b-7443-47c9-bd27-7015aae293fa', 5, NULL, 'Maja (Pliseekaja)', 'Duetti per due violini: No. 5. Maja (Pliseekaja)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 9868 AND p.composer_id = 109
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:871dfe1b-7443-47c9-bd27-7015aae293fa'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 6, part.movement_number = NULL,
    part.name_ko = 'Bruno (Maderna)', part.name_en = 'Duetti per due violini: No. 6. Bruno (Maderna)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 9868 AND p.composer_id = 109 AND part.part_key = 'musicbrainz:d82763e2-c85d-4416-a594-0f6a907c9345' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:d82763e2-c85d-4416-a594-0f6a907c9345', 6, NULL, 'Bruno (Maderna)', 'Duetti per due violini: No. 6. Bruno (Maderna)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 9868 AND p.composer_id = 109
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:d82763e2-c85d-4416-a594-0f6a907c9345'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 7, part.movement_number = NULL,
    part.name_ko = 'Camilla (Adami)', part.name_en = 'Duetti per due violini: No. 7. Camilla (Adami)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 9868 AND p.composer_id = 109 AND part.part_key = 'musicbrainz:2e02db08-8600-4a2e-a18d-cf4fe4ca7343' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:2e02db08-8600-4a2e-a18d-cf4fe4ca7343', 7, NULL, 'Camilla (Adami)', 'Duetti per due violini: No. 7. Camilla (Adami)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 9868 AND p.composer_id = 109
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:2e02db08-8600-4a2e-a18d-cf4fe4ca7343'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 8, part.movement_number = NULL,
    part.name_ko = 'Peppino (di Giugno)', part.name_en = 'Duetti per due violini: No. 8. Peppino (di Giugno)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 9868 AND p.composer_id = 109 AND part.part_key = 'musicbrainz:815d86f4-ebe2-4036-ae1c-a76d0a2d9fce' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:815d86f4-ebe2-4036-ae1c-a76d0a2d9fce', 8, NULL, 'Peppino (di Giugno)', 'Duetti per due violini: No. 8. Peppino (di Giugno)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 9868 AND p.composer_id = 109
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:815d86f4-ebe2-4036-ae1c-a76d0a2d9fce'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 9, part.movement_number = NULL,
    part.name_ko = 'Marccello (Panni)', part.name_en = 'Duetti per due violini: No. 9. Marccello (Panni)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 9868 AND p.composer_id = 109 AND part.part_key = 'musicbrainz:af240b84-9bcb-4ea1-9b48-39ed51cc0b70' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:af240b84-9bcb-4ea1-9b48-39ed51cc0b70', 9, NULL, 'Marccello (Panni)', 'Duetti per due violini: No. 9. Marccello (Panni)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 9868 AND p.composer_id = 109
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:af240b84-9bcb-4ea1-9b48-39ed51cc0b70'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 10, part.movement_number = NULL,
    part.name_ko = 'Giorgio Federico (Ghedini)', part.name_en = 'Duetti per due violini: No. 10. Giorgio Federico (Ghedini)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 9868 AND p.composer_id = 109 AND part.part_key = 'musicbrainz:3d9210d9-6a03-4bad-89a0-8d20598e5b11' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:3d9210d9-6a03-4bad-89a0-8d20598e5b11', 10, NULL, 'Giorgio Federico (Ghedini)', 'Duetti per due violini: No. 10. Giorgio Federico (Ghedini)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 9868 AND p.composer_id = 109
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:3d9210d9-6a03-4bad-89a0-8d20598e5b11'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 11, part.movement_number = NULL,
    part.name_ko = 'Valerio (Adami)', part.name_en = 'Duetti per due violini: No. 11. Valerio (Adami)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 9868 AND p.composer_id = 109 AND part.part_key = 'musicbrainz:cba093e4-f8c9-4a80-960d-4cb2a74792ea' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:cba093e4-f8c9-4a80-960d-4cb2a74792ea', 11, NULL, 'Valerio (Adami)', 'Duetti per due violini: No. 11. Valerio (Adami)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 9868 AND p.composer_id = 109
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:cba093e4-f8c9-4a80-960d-4cb2a74792ea'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 12, part.movement_number = NULL,
    part.name_ko = 'Daniela (Rabinovitch)', part.name_en = 'Duetti per due violini: No. 12. Daniela (Rabinovitch)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 9868 AND p.composer_id = 109 AND part.part_key = 'musicbrainz:983d4da4-81ab-4642-8d4e-4e4429e3b8ee' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:983d4da4-81ab-4642-8d4e-4e4429e3b8ee', 12, NULL, 'Daniela (Rabinovitch)', 'Duetti per due violini: No. 12. Daniela (Rabinovitch)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 9868 AND p.composer_id = 109
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:983d4da4-81ab-4642-8d4e-4e4429e3b8ee'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 13, part.movement_number = NULL,
    part.name_ko = 'Jeanne (Panni)', part.name_en = 'Duetti per due violini: No. 13. Jeanne (Panni)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 9868 AND p.composer_id = 109 AND part.part_key = 'musicbrainz:86c3300b-e5cc-428a-87f7-a497e86500f9' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:86c3300b-e5cc-428a-87f7-a497e86500f9', 13, NULL, 'Jeanne (Panni)', 'Duetti per due violini: No. 13. Jeanne (Panni)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 9868 AND p.composer_id = 109
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:86c3300b-e5cc-428a-87f7-a497e86500f9'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 14, part.movement_number = NULL,
    part.name_ko = 'Pierre (Boulez)', part.name_en = 'Duetti per due violini: No. 14. Pierre (Boulez)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 9868 AND p.composer_id = 109 AND part.part_key = 'musicbrainz:a69908fd-c5a7-4888-97a5-c12f049ee49d' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:a69908fd-c5a7-4888-97a5-c12f049ee49d', 14, NULL, 'Pierre (Boulez)', 'Duetti per due violini: No. 14. Pierre (Boulez)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 9868 AND p.composer_id = 109
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:a69908fd-c5a7-4888-97a5-c12f049ee49d'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 15, part.movement_number = NULL,
    part.name_ko = 'Tatjana (Globokar)', part.name_en = 'Duetti per due violini: No. 15. Tatjana (Globokar)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 9868 AND p.composer_id = 109 AND part.part_key = 'musicbrainz:7a3f0224-0ca3-4e2f-8561-6008c9ab6de7' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:7a3f0224-0ca3-4e2f-8561-6008c9ab6de7', 15, NULL, 'Tatjana (Globokar)', 'Duetti per due violini: No. 15. Tatjana (Globokar)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 9868 AND p.composer_id = 109
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:7a3f0224-0ca3-4e2f-8561-6008c9ab6de7'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 16, part.movement_number = NULL,
    part.name_ko = 'Rivi (Peeker)', part.name_en = 'Duetti per due violini: No. 16. Rivi (Peeker)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 9868 AND p.composer_id = 109 AND part.part_key = 'musicbrainz:3c9012c2-2f7e-4373-bcf8-60a03d2b5685' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:3c9012c2-2f7e-4373-bcf8-60a03d2b5685', 16, NULL, 'Rivi (Peeker)', 'Duetti per due violini: No. 16. Rivi (Peeker)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 9868 AND p.composer_id = 109
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:3c9012c2-2f7e-4373-bcf8-60a03d2b5685'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 17, part.movement_number = NULL,
    part.name_ko = 'Leonardo (Pinzauti)', part.name_en = 'Duetti per due violini: No. 17. Leonardo (Pinzauti)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 9868 AND p.composer_id = 109 AND part.part_key = 'musicbrainz:85fca308-2969-45d6-acbd-b3ba5c7a8615' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:85fca308-2969-45d6-acbd-b3ba5c7a8615', 17, NULL, 'Leonardo (Pinzauti)', 'Duetti per due violini: No. 17. Leonardo (Pinzauti)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 9868 AND p.composer_id = 109
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:85fca308-2969-45d6-acbd-b3ba5c7a8615'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 18, part.movement_number = NULL,
    part.name_ko = 'Piero (Farulli)', part.name_en = 'Duetti per due violini: No. 18. Piero (Farulli)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 9868 AND p.composer_id = 109 AND part.part_key = 'musicbrainz:107dc666-b22a-459c-b572-f8d408d8388d' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:107dc666-b22a-459c-b572-f8d408d8388d', 18, NULL, 'Piero (Farulli)', 'Duetti per due violini: No. 18. Piero (Farulli)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 9868 AND p.composer_id = 109
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:107dc666-b22a-459c-b572-f8d408d8388d'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 19, part.movement_number = NULL,
    part.name_ko = 'Annie (Neuburger)', part.name_en = 'Duetti per due violini: No. 19. Annie (Neuburger)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 9868 AND p.composer_id = 109 AND part.part_key = 'musicbrainz:938ca1d7-54b9-4fff-98ad-241cc5c3a73f' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:938ca1d7-54b9-4fff-98ad-241cc5c3a73f', 19, NULL, 'Annie (Neuburger)', 'Duetti per due violini: No. 19. Annie (Neuburger)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 9868 AND p.composer_id = 109
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:938ca1d7-54b9-4fff-98ad-241cc5c3a73f'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 20, part.movement_number = NULL,
    part.name_ko = 'Edoardo (Sanguineti)', part.name_en = 'Duetti per due violini: No. 20. Edoardo (Sanguineti)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 9868 AND p.composer_id = 109 AND part.part_key = 'musicbrainz:eb31acf4-bfeb-47cf-aedf-eff3e7d4eb68' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:eb31acf4-bfeb-47cf-aedf-eff3e7d4eb68', 20, NULL, 'Edoardo (Sanguineti)', 'Duetti per due violini: No. 20. Edoardo (Sanguineti)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 9868 AND p.composer_id = 109
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:eb31acf4-bfeb-47cf-aedf-eff3e7d4eb68'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 21, part.movement_number = NULL,
    part.name_ko = 'Fiamma (Nicolodi)', part.name_en = 'Duetti per due violini: No. 21. Fiamma (Nicolodi)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 9868 AND p.composer_id = 109 AND part.part_key = 'musicbrainz:d7b630d1-b182-4cdf-96e4-a1de2c2b4e3c' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:d7b630d1-b182-4cdf-96e4-a1de2c2b4e3c', 21, NULL, 'Fiamma (Nicolodi)', 'Duetti per due violini: No. 21. Fiamma (Nicolodi)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 9868 AND p.composer_id = 109
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:d7b630d1-b182-4cdf-96e4-a1de2c2b4e3c'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 22, part.movement_number = NULL,
    part.name_ko = 'Vinko (Globokar)', part.name_en = 'Duetti per due violini: No. 22. Vinko (Globokar)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 9868 AND p.composer_id = 109 AND part.part_key = 'musicbrainz:db64f948-0d92-4165-9168-47eca27bf9e2' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:db64f948-0d92-4165-9168-47eca27bf9e2', 22, NULL, 'Vinko (Globokar)', 'Duetti per due violini: No. 22. Vinko (Globokar)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 9868 AND p.composer_id = 109
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:db64f948-0d92-4165-9168-47eca27bf9e2'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 23, part.movement_number = NULL,
    part.name_ko = 'Franco (Gulli)', part.name_en = 'Duetti per due violini: No. 23. Franco (Gulli)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 9868 AND p.composer_id = 109 AND part.part_key = 'musicbrainz:2f729713-a641-47a5-be27-d827924183c6' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:2f729713-a641-47a5-be27-d827924183c6', 23, NULL, 'Franco (Gulli)', 'Duetti per due violini: No. 23. Franco (Gulli)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 9868 AND p.composer_id = 109
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:2f729713-a641-47a5-be27-d827924183c6'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 24, part.movement_number = NULL,
    part.name_ko = 'Aldo (Benniei)', part.name_en = 'Duetti per due violini: No. 24. Aldo (Benniei)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 9868 AND p.composer_id = 109 AND part.part_key = 'musicbrainz:410b8b07-17e8-4902-a95b-de624585e16b' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:410b8b07-17e8-4902-a95b-de624585e16b', 24, NULL, 'Aldo (Benniei)', 'Duetti per due violini: No. 24. Aldo (Benniei)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 9868 AND p.composer_id = 109
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:410b8b07-17e8-4902-a95b-de624585e16b'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 25, part.movement_number = NULL,
    part.name_ko = 'Carlo (Chiarappa)', part.name_en = 'Duetti per due violini: No. 25. Carlo (Chiarappa)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 9868 AND p.composer_id = 109 AND part.part_key = 'musicbrainz:da44ec19-795c-4de5-83e2-1cef77a6c02f' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:da44ec19-795c-4de5-83e2-1cef77a6c02f', 25, NULL, 'Carlo (Chiarappa)', 'Duetti per due violini: No. 25. Carlo (Chiarappa)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 9868 AND p.composer_id = 109
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:da44ec19-795c-4de5-83e2-1cef77a6c02f'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 26, part.movement_number = NULL,
    part.name_ko = 'Henri (Pousseur)', part.name_en = 'Duetti per due violini: No. 26. Henri (Pousseur)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 9868 AND p.composer_id = 109 AND part.part_key = 'musicbrainz:9996988d-c755-48f8-840d-f0301c968137' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:9996988d-c755-48f8-840d-f0301c968137', 26, NULL, 'Henri (Pousseur)', 'Duetti per due violini: No. 26. Henri (Pousseur)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 9868 AND p.composer_id = 109
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:9996988d-c755-48f8-840d-f0301c968137'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 27, part.movement_number = NULL,
    part.name_ko = 'Alfredo (Fiorenzani)', part.name_en = 'Duetti per due violini: No. 27. Alfredo (Fiorenzani)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 9868 AND p.composer_id = 109 AND part.part_key = 'musicbrainz:7b700c98-8431-485b-b363-d2f891860bc4' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:7b700c98-8431-485b-b363-d2f891860bc4', 27, NULL, 'Alfredo (Fiorenzani)', 'Duetti per due violini: No. 27. Alfredo (Fiorenzani)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 9868 AND p.composer_id = 109
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:7b700c98-8431-485b-b363-d2f891860bc4'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 28, part.movement_number = NULL,
    part.name_ko = 'Igor (Stravinsky)', part.name_en = 'Duetti per due violini: No. 28. Igor (Stravinsky)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 9868 AND p.composer_id = 109 AND part.part_key = 'musicbrainz:b6d47a58-d087-46ac-98e2-46fda53420ad' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:b6d47a58-d087-46ac-98e2-46fda53420ad', 28, NULL, 'Igor (Stravinsky)', 'Duetti per due violini: No. 28. Igor (Stravinsky)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 9868 AND p.composer_id = 109
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:b6d47a58-d087-46ac-98e2-46fda53420ad'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 29, part.movement_number = NULL,
    part.name_ko = 'Alfred (Schlee)', part.name_en = 'Duetti per due violini: No. 29. Alfred (Schlee)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 9868 AND p.composer_id = 109 AND part.part_key = 'musicbrainz:4eb81d89-66ff-4125-807d-109203cea14f' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:4eb81d89-66ff-4125-807d-109203cea14f', 29, NULL, 'Alfred (Schlee)', 'Duetti per due violini: No. 29. Alfred (Schlee)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 9868 AND p.composer_id = 109
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:4eb81d89-66ff-4125-807d-109203cea14f'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 30, part.movement_number = NULL,
    part.name_ko = 'Massimo (Mila)', part.name_en = 'Duetti per due violini: No. 30. Massimo (Mila)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 9868 AND p.composer_id = 109 AND part.part_key = 'musicbrainz:482dc455-cf3b-464c-bed2-bfa25a1392b2' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:482dc455-cf3b-464c-bed2-bfa25a1392b2', 30, NULL, 'Massimo (Mila)', 'Duetti per due violini: No. 30. Massimo (Mila)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 9868 AND p.composer_id = 109
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:482dc455-cf3b-464c-bed2-bfa25a1392b2'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 31, part.movement_number = NULL,
    part.name_ko = 'Mauricio (Kagel)', part.name_en = 'Duetti per due violini: No. 31. Mauricio (Kagel)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 9868 AND p.composer_id = 109 AND part.part_key = 'musicbrainz:7ee2be01-6faa-4b01-bc5c-e2335831b472' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:7ee2be01-6faa-4b01-bc5c-e2335831b472', 31, NULL, 'Mauricio (Kagel)', 'Duetti per due violini: No. 31. Mauricio (Kagel)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 9868 AND p.composer_id = 109
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:7ee2be01-6faa-4b01-bc5c-e2335831b472'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 32, part.movement_number = NULL,
    part.name_ko = 'Maurice (Fleuret)', part.name_en = 'Duetti per due violini: No. 32. Maurice (Fleuret)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 9868 AND p.composer_id = 109 AND part.part_key = 'musicbrainz:e802f227-4bec-4ffa-86b9-b37682117e17' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:e802f227-4bec-4ffa-86b9-b37682117e17', 32, NULL, 'Maurice (Fleuret)', 'Duetti per due violini: No. 32. Maurice (Fleuret)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 9868 AND p.composer_id = 109
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:e802f227-4bec-4ffa-86b9-b37682117e17'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 33, part.movement_number = NULL,
    part.name_ko = 'Lorin (Maazel)', part.name_en = 'Duetti per due violini: No. 33. Lorin (Maazel)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 9868 AND p.composer_id = 109 AND part.part_key = 'musicbrainz:2090c550-67fd-48d1-9cc6-62ff79b77526' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:2090c550-67fd-48d1-9cc6-62ff79b77526', 33, NULL, 'Lorin (Maazel)', 'Duetti per due violini: No. 33. Lorin (Maazel)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 9868 AND p.composer_id = 109
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:2090c550-67fd-48d1-9cc6-62ff79b77526'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 34, part.movement_number = NULL,
    part.name_ko = 'Lele (d''Amico)', part.name_en = 'Duetti per due violini: No. 34. Lele (d''Amico)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 9868 AND p.composer_id = 109 AND part.part_key = 'musicbrainz:48e76110-3eab-487b-9edf-6e82b96ae381' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:48e76110-3eab-487b-9edf-6e82b96ae381', 34, NULL, 'Lele (d''Amico)', 'Duetti per due violini: No. 34. Lele (d''Amico)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 9868 AND p.composer_id = 109
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:48e76110-3eab-487b-9edf-6e82b96ae381'
);


-- None E si fussi pisci

UPDATE pieces piece
SET piece.title = 'E si fussi pisci', piece.title_en = 'E si fussi pisci',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 8489 AND piece.composer_id = 109
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Eindrücke

UPDATE pieces piece
SET piece.title = 'Eindrücke', piece.title_en = 'Eindrücke',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 8826 AND piece.composer_id = 109
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Ekphrasis (Continuo II)

UPDATE pieces piece
SET piece.title = 'Ekphrasis (Continuo II)', piece.title_en = 'Ekphrasis (Continuo II)',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 10391 AND piece.composer_id = 109
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Epifanie

UPDATE pieces piece
SET piece.title = 'Epifanie', piece.title_en = 'Epifanie',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 8753 AND piece.composer_id = 109
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'Orchester', part.name_en = 'Epifanie: I. Orchester',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 8753 AND p.composer_id = 109 AND part.part_key = 'musicbrainz:22591070-8a18-4eef-a2ff-a0f0b471fbe8' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:22591070-8a18-4eef-a2ff-a0f0b471fbe8', 1, 'I', 'Orchester', 'Epifanie: I. Orchester', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 8753 AND p.composer_id = 109
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:22591070-8a18-4eef-a2ff-a0f0b471fbe8'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'Je regardais les trois arbres', part.name_en = 'Epifanie: II. Je regardais les trois arbres',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 8753 AND p.composer_id = 109 AND part.part_key = 'musicbrainz:dc71f12f-a77a-47c1-9f46-2a40e38385ae' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:dc71f12f-a77a-47c1-9f46-2a40e38385ae', 2, 'II', 'Je regardais les trois arbres', 'Epifanie: II. Je regardais les trois arbres', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 8753 AND p.composer_id = 109
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:dc71f12f-a77a-47c1-9f46-2a40e38385ae'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = 'Orchester', part.name_en = 'Epifanie: III. Orchester',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 8753 AND p.composer_id = 109 AND part.part_key = 'musicbrainz:7bceb217-ecad-4a18-b16b-ee05c14836f2' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:7bceb217-ecad-4a18-b16b-ee05c14836f2', 3, 'III', 'Orchester', 'Epifanie: III. Orchester', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 8753 AND p.composer_id = 109
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:7bceb217-ecad-4a18-b16b-ee05c14836f2'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = 'IV',
    part.name_ko = 'Las siete cuerdas', part.name_en = 'Epifanie: IV. Las siete cuerdas',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 8753 AND p.composer_id = 109 AND part.part_key = 'musicbrainz:06d0abeb-5e58-4a0e-bb8e-28b90e663c88' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:06d0abeb-5e58-4a0e-bb8e-28b90e663c88', 4, 'IV', 'Las siete cuerdas', 'Epifanie: IV. Las siete cuerdas', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 8753 AND p.composer_id = 109
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:06d0abeb-5e58-4a0e-bb8e-28b90e663c88'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 5, part.movement_number = 'V',
    part.name_ko = 'Orchester', part.name_en = 'Epifanie: V. Orchester',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 8753 AND p.composer_id = 109 AND part.part_key = 'musicbrainz:f67b6a02-2218-4132-8bc7-238b8e85a303' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:f67b6a02-2218-4132-8bc7-238b8e85a303', 5, 'V', 'Orchester', 'Epifanie: V. Orchester', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 8753 AND p.composer_id = 109
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:f67b6a02-2218-4132-8bc7-238b8e85a303'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 6, part.movement_number = 'VI',
    part.name_ko = 'Orchester mit gesprochenen Einwürfen', part.name_en = 'Epifanie: VI. Orchester mit gesprochenen Einwürfen',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 8753 AND p.composer_id = 109 AND part.part_key = 'musicbrainz:aefeaa9c-dfec-4293-bc50-4e4cef1b4735' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:aefeaa9c-dfec-4293-bc50-4e4cef1b4735', 6, 'VI', 'Orchester mit gesprochenen Einwürfen', 'Epifanie: VI. Orchester mit gesprochenen Einwürfen', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 8753 AND p.composer_id = 109
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:aefeaa9c-dfec-4293-bc50-4e4cef1b4735'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 7, part.movement_number = 'VII',
    part.name_ko = 'A girl stood before him', part.name_en = 'Epifanie: VII. A girl stood before him',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 8753 AND p.composer_id = 109 AND part.part_key = 'musicbrainz:ce45c5b5-a716-4c5d-ab9c-37c15fe109c3' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:ce45c5b5-a716-4c5d-ab9c-37c15fe109c3', 7, 'VII', 'A girl stood before him', 'Epifanie: VII. A girl stood before him', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 8753 AND p.composer_id = 109
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:ce45c5b5-a716-4c5d-ab9c-37c15fe109c3'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 8, part.movement_number = 'VIII',
    part.name_ko = 'Orchester', part.name_en = 'Epifanie: VIII. Orchester',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 8753 AND p.composer_id = 109 AND part.part_key = 'musicbrainz:3b0932f0-56bb-4de5-a53e-2e19d00e1609' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:3b0932f0-56bb-4de5-a53e-2e19d00e1609', 8, 'VIII', 'Orchester', 'Epifanie: VIII. Orchester', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 8753 AND p.composer_id = 109
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:3b0932f0-56bb-4de5-a53e-2e19d00e1609'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 9, part.movement_number = 'IX',
    part.name_ko = 'Orchester', part.name_en = 'Epifanie: IX. Orchester',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 8753 AND p.composer_id = 109 AND part.part_key = 'musicbrainz:a240e24a-77f7-4760-81b9-36e81a4e919e' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:a240e24a-77f7-4760-81b9-36e81a4e919e', 9, 'IX', 'Orchester', 'Epifanie: IX. Orchester', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 8753 AND p.composer_id = 109
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:a240e24a-77f7-4760-81b9-36e81a4e919e'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 10, part.movement_number = 'X',
    part.name_ko = 'Cette expression de surprise', part.name_en = 'Epifanie: X. Cette expression de surprise',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 8753 AND p.composer_id = 109 AND part.part_key = 'musicbrainz:d8a8d516-ec97-446f-b9ff-afa805aa5c6b' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:d8a8d516-ec97-446f-b9ff-afa805aa5c6b', 10, 'X', 'Cette expression de surprise', 'Epifanie: X. Cette expression de surprise', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 8753 AND p.composer_id = 109
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:d8a8d516-ec97-446f-b9ff-afa805aa5c6b'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 11, part.movement_number = 'XI',
    part.name_ko = 'Was sind das für Zeiten ?', part.name_en = 'Epifanie: XI. Was sind das für Zeiten ?',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 8753 AND p.composer_id = 109 AND part.part_key = 'musicbrainz:27801ec4-4ff4-4b12-8c56-7e314ef6df9c' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:27801ec4-4ff4-4b12-8c56-7e314ef6df9c', 11, 'XI', 'Was sind das für Zeiten ?', 'Epifanie: XI. Was sind das für Zeiten ?', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 8753 AND p.composer_id = 109
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:27801ec4-4ff4-4b12-8c56-7e314ef6df9c'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 12, part.movement_number = 'XII',
    part.name_ko = 'Orchester', part.name_en = 'Epifanie: XII. Orchester',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 8753 AND p.composer_id = 109 AND part.part_key = 'musicbrainz:cf143bf9-75f1-4ebd-ac86-fa5f261de395' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:cf143bf9-75f1-4ebd-ac86-fa5f261de395', 12, 'XII', 'Orchester', 'Epifanie: XII. Orchester', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 8753 AND p.composer_id = 109
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:cf143bf9-75f1-4ebd-ac86-fa5f261de395'
);


-- None Fa - Si

UPDATE pieces piece
SET piece.title = 'Fa - Si', piece.title_en = 'Fa - Si',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 9860 AND piece.composer_id = 109
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None 연가곡집 <Folk Songs>

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'Black Is the Colour', part.name_en = 'Folk Songs: I. Black Is the Colour',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 412 AND p.composer_id = 109 AND part.part_key = 'musicbrainz:4188cf1c-8387-461b-a1c8-bebc1bbf201e' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:4188cf1c-8387-461b-a1c8-bebc1bbf201e', 1, 'I', 'Black Is the Colour', 'Folk Songs: I. Black Is the Colour', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 412 AND p.composer_id = 109
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:4188cf1c-8387-461b-a1c8-bebc1bbf201e'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'I Wonder as I Wander', part.name_en = 'Folk Songs: II. I Wonder as I Wander',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 412 AND p.composer_id = 109 AND part.part_key = 'musicbrainz:0ec98caa-072a-48f8-9ca9-5dc789669472' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:0ec98caa-072a-48f8-9ca9-5dc789669472', 2, 'II', 'I Wonder as I Wander', 'Folk Songs: II. I Wonder as I Wander', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 412 AND p.composer_id = 109
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:0ec98caa-072a-48f8-9ca9-5dc789669472'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = 'Loosin yelav', part.name_en = 'Folk Songs: III. Loosin yelav',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 412 AND p.composer_id = 109 AND part.part_key = 'musicbrainz:f4fa6ba8-613a-4816-a339-a499306578f0' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:f4fa6ba8-613a-4816-a339-a499306578f0', 3, 'III', 'Loosin yelav', 'Folk Songs: III. Loosin yelav', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 412 AND p.composer_id = 109
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:f4fa6ba8-613a-4816-a339-a499306578f0'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = 'IV',
    part.name_ko = 'Rossignolet du bois', part.name_en = 'Folk Songs: IV. Rossignolet du bois',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 412 AND p.composer_id = 109 AND part.part_key = 'musicbrainz:437e0117-7e7b-4bac-a0e6-26e54b228c77' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:437e0117-7e7b-4bac-a0e6-26e54b228c77', 4, 'IV', 'Rossignolet du bois', 'Folk Songs: IV. Rossignolet du bois', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 412 AND p.composer_id = 109
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:437e0117-7e7b-4bac-a0e6-26e54b228c77'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 5, part.movement_number = 'V',
    part.name_ko = 'A la femminisca', part.name_en = 'Folk Songs: V. A la femminisca',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 412 AND p.composer_id = 109 AND part.part_key = 'musicbrainz:875bf7ef-318b-42f0-974a-5b70cc962b08' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:875bf7ef-318b-42f0-974a-5b70cc962b08', 5, 'V', 'A la femminisca', 'Folk Songs: V. A la femminisca', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 412 AND p.composer_id = 109
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:875bf7ef-318b-42f0-974a-5b70cc962b08'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 6, part.movement_number = 'VIII',
    part.name_ko = 'Motettu di tristura', part.name_en = 'Folk Songs: VIII. Motettu di tristura',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 412 AND p.composer_id = 109 AND part.part_key = 'musicbrainz:562b175a-8b72-3763-9202-44bf25652c1f' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:562b175a-8b72-3763-9202-44bf25652c1f', 6, 'VIII', 'Motettu di tristura', 'Folk Songs: VIII. Motettu di tristura', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 412 AND p.composer_id = 109
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:562b175a-8b72-3763-9202-44bf25652c1f'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 7, part.movement_number = 'IX',
    part.name_ko = 'Malurous qu''o uno fenno', part.name_en = 'Folk Songs: IX. Malurous qu''o uno fenno',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 412 AND p.composer_id = 109 AND part.part_key = 'musicbrainz:d7a1951f-6d3d-4833-a847-ee59893b55f5' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:d7a1951f-6d3d-4833-a847-ee59893b55f5', 7, 'IX', 'Malurous qu''o uno fenno', 'Folk Songs: IX. Malurous qu''o uno fenno', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 412 AND p.composer_id = 109
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:d7a1951f-6d3d-4833-a847-ee59893b55f5'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 8, part.movement_number = 'X',
    part.name_ko = 'Lo Fïolairé', part.name_en = 'Folk Songs: X. Lo Fïolairé',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 412 AND p.composer_id = 109 AND part.part_key = 'musicbrainz:992992e9-c648-471e-a262-57db4f7f085d' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:992992e9-c648-471e-a262-57db4f7f085d', 8, 'X', 'Lo Fïolairé', 'Folk Songs: X. Lo Fïolairé', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 412 AND p.composer_id = 109
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:992992e9-c648-471e-a262-57db4f7f085d'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 9, part.movement_number = 'XI',
    part.name_ko = 'Aserbaijan Love Song', part.name_en = 'Folk Songs: XI. Aserbaijan Love Song',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 412 AND p.composer_id = 109 AND part.part_key = 'musicbrainz:202483b4-85d6-3624-8d11-10727eb40139' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:202483b4-85d6-3624-8d11-10727eb40139', 9, 'XI', 'Aserbaijan Love Song', 'Folk Songs: XI. Aserbaijan Love Song', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 412 AND p.composer_id = 109
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:202483b4-85d6-3624-8d11-10727eb40139'
);


-- None Formazioni

UPDATE pieces piece
SET piece.title = 'Formazioni', piece.title_en = 'Formazioni',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 8800 AND piece.composer_id = 109
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Gesti

UPDATE pieces piece
SET piece.title = 'Gesti', piece.title_en = 'Gesti',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 7688 AND piece.composer_id = 109
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Glosse

UPDATE pieces piece
SET piece.title = 'Glosse', piece.title_en = 'Glosse',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 10361 AND piece.composer_id = 109
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Good Night

UPDATE pieces piece
SET piece.title = 'Good Night', piece.title_en = 'Good Night',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 10537 AND piece.composer_id = 109
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Gute Nacht

UPDATE pieces piece
SET piece.title = 'Gute Nacht', piece.title_en = 'Gute Nacht',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 8229 AND piece.composer_id = 109
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Il ritorno degli snovidenia

UPDATE pieces piece
SET piece.title = 'Il ritorno degli snovidenia', piece.title_en = 'Il ritorno degli snovidenia',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 9484 AND piece.composer_id = 109
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Kol Od (Chemins VI)

UPDATE pieces piece
SET piece.title = 'Kol Od (Chemins VI)', piece.title_en = 'Kol Od (Chemins VI)',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 8494 AND piece.composer_id = 109
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Laborintus II

UPDATE pieces piece
SET piece.title = 'Laborintus II', piece.title_en = 'Laborintus II',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 10152 AND piece.composer_id = 109
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Les mots sont allés ...

UPDATE pieces piece
SET piece.title = 'Les mots sont allés ...', piece.title_en = 'Les mots sont allés ...',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 9147 AND piece.composer_id = 109
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None 가곡

UPDATE pieces piece
SET piece.title = '가곡', piece.title_en = 'Lied',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 7452 AND piece.composer_id = 109
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Linea

UPDATE pieces piece
SET piece.title = 'Linea', piece.title_en = 'Linea',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 10469 AND piece.composer_id = 109
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Momenti

UPDATE pieces piece
SET piece.title = 'Momenti', piece.title_en = 'Momenti',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 8367 AND piece.composer_id = 109
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Musica leggera

UPDATE pieces piece
SET piece.title = 'Musica leggera', piece.title_en = 'Musica leggera',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 9017 AND piece.composer_id = 109
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Naturale

UPDATE pieces piece
SET piece.title = 'Naturale', piece.title_en = 'Naturale',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 9639 AND piece.composer_id = 109
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Nones

UPDATE pieces piece
SET piece.title = 'Nones', piece.title_en = 'Nones',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 8223 AND piece.composer_id = 109
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Notturno (Quartetto III)

UPDATE pieces piece
SET piece.title = 'Notturno (Quartetto III)', piece.title_en = 'Notturno (Quartetto III)',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 8833 AND piece.composer_id = 109
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None O King

UPDATE pieces piece
SET piece.title = 'O King', piece.title_en = 'O King',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 8192 AND piece.composer_id = 109
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Opus no. Zoo

UPDATE pieces piece
SET piece.title = 'Opus no. Zoo', piece.title_en = 'Opus no. Zoo',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 7750 AND piece.composer_id = 109
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'Barn Dance', part.name_en = 'Opus no. Zoo: I. Barn Dance',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 7750 AND p.composer_id = 109 AND part.part_key = 'musicbrainz:54a283ff-1971-4d54-baac-0e0fcbc17f54' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:54a283ff-1971-4d54-baac-0e0fcbc17f54', 1, 'I', 'Barn Dance', 'Opus no. Zoo: I. Barn Dance', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 7750 AND p.composer_id = 109
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:54a283ff-1971-4d54-baac-0e0fcbc17f54'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'The Fawn', part.name_en = 'Opus no. Zoo: II. The Fawn',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 7750 AND p.composer_id = 109 AND part.part_key = 'musicbrainz:7979c1e2-c450-47f4-b6d5-259555fccc93' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:7979c1e2-c450-47f4-b6d5-259555fccc93', 2, 'II', 'The Fawn', 'Opus no. Zoo: II. The Fawn', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 7750 AND p.composer_id = 109
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:7979c1e2-c450-47f4-b6d5-259555fccc93'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = 'The Grey Mouse', part.name_en = 'Opus no. Zoo: III. The Grey Mouse',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 7750 AND p.composer_id = 109 AND part.part_key = 'musicbrainz:db1e6803-1bcf-40eb-a467-548af49df56b' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:db1e6803-1bcf-40eb-a467-548af49df56b', 3, 'III', 'The Grey Mouse', 'Opus no. Zoo: III. The Grey Mouse', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 7750 AND p.composer_id = 109
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:db1e6803-1bcf-40eb-a467-548af49df56b'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = 'IV',
    part.name_ko = 'Tom Cats', part.name_en = 'Opus no. Zoo: IV. Tom Cats',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 7750 AND p.composer_id = 109 AND part.part_key = 'musicbrainz:6547bb8b-ee93-4787-8da4-2bf6b7ef051c' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:6547bb8b-ee93-4787-8da4-2bf6b7ef051c', 4, 'IV', 'Tom Cats', 'Opus no. Zoo: IV. Tom Cats', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 7750 AND p.composer_id = 109
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:6547bb8b-ee93-4787-8da4-2bf6b7ef051c'
);


-- None Ora

UPDATE pieces piece
SET piece.title = 'Ora', piece.title_en = 'Ora',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 8056 AND piece.composer_id = 109
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Passaggio

UPDATE pieces piece
SET piece.title = 'Passaggio', piece.title_en = 'Passaggio',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 9429 AND piece.composer_id = 109
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'Stazione I', part.name_en = 'Passaggio: Stazione I',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 9429 AND p.composer_id = 109 AND part.part_key = 'musicbrainz:c16dd6cb-ba1f-4f6a-9f73-d44eaee6cfb0' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:c16dd6cb-ba1f-4f6a-9f73-d44eaee6cfb0', 1, NULL, 'Stazione I', 'Passaggio: Stazione I', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 9429 AND p.composer_id = 109
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:c16dd6cb-ba1f-4f6a-9f73-d44eaee6cfb0'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'Stazione II', part.name_en = 'Passaggio: Stazione II',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 9429 AND p.composer_id = 109 AND part.part_key = 'musicbrainz:52b462c3-78bb-4c4f-ad04-d4f36849cab5' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:52b462c3-78bb-4c4f-ad04-d4f36849cab5', 2, NULL, 'Stazione II', 'Passaggio: Stazione II', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 9429 AND p.composer_id = 109
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:52b462c3-78bb-4c4f-ad04-d4f36849cab5'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = NULL,
    part.name_ko = 'Stazione III', part.name_en = 'Passaggio: Stazione III',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 9429 AND p.composer_id = 109 AND part.part_key = 'musicbrainz:64d76015-bd03-4ffa-b16d-0cfdc8de95ec' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:64d76015-bd03-4ffa-b16d-0cfdc8de95ec', 3, NULL, 'Stazione III', 'Passaggio: Stazione III', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 9429 AND p.composer_id = 109
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:64d76015-bd03-4ffa-b16d-0cfdc8de95ec'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = NULL,
    part.name_ko = 'Stazione IV', part.name_en = 'Passaggio: Stazione IV',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 9429 AND p.composer_id = 109 AND part.part_key = 'musicbrainz:0cb1902c-504e-4f77-bcb8-b81c6aa4e300' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:0cb1902c-504e-4f77-bcb8-b81c6aa4e300', 4, NULL, 'Stazione IV', 'Passaggio: Stazione IV', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 9429 AND p.composer_id = 109
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:0cb1902c-504e-4f77-bcb8-b81c6aa4e300'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 5, part.movement_number = NULL,
    part.name_ko = 'Stazione V', part.name_en = 'Passaggio: Stazione V',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 9429 AND p.composer_id = 109 AND part.part_key = 'musicbrainz:4fe0abf4-f59c-4daf-afc7-42e96e420cfe' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:4fe0abf4-f59c-4daf-afc7-42e96e420cfe', 5, NULL, 'Stazione V', 'Passaggio: Stazione V', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 9429 AND p.composer_id = 109
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:4fe0abf4-f59c-4daf-afc7-42e96e420cfe'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 6, part.movement_number = NULL,
    part.name_ko = 'Stazione VI', part.name_en = 'Passaggio: Stazione VI',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 9429 AND p.composer_id = 109 AND part.part_key = 'musicbrainz:69b8580b-b25f-4086-9beb-1ea13d75c4c5' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:69b8580b-b25f-4086-9beb-1ea13d75c4c5', 6, NULL, 'Stazione VI', 'Passaggio: Stazione VI', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 9429 AND p.composer_id = 109
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:69b8580b-b25f-4086-9beb-1ea13d75c4c5'
);


-- None Perspectives

UPDATE pieces piece
SET piece.title = 'Perspectives', piece.title_en = 'Perspectives',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 10218 AND piece.composer_id = 109
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Points on the Curve to Find…

UPDATE pieces piece
SET piece.title = 'Points on the Curve to Find…', piece.title_en = 'Points on the Curve to Find…',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 10878 AND piece.composer_id = 109
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Psy

UPDATE pieces piece
SET piece.title = 'Psy', piece.title_en = 'Psy',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 9455 AND piece.composer_id = 109
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Quartetto per archi

UPDATE pieces piece
SET piece.title = 'Quartetto per archi', piece.title_en = 'Quartetto per archi',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 9707 AND piece.composer_id = 109
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Quattro canzoni popolari

UPDATE pieces piece
SET piece.title = 'Quattro canzoni popolari', piece.title_en = 'Quattro canzoni popolari',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 10956 AND piece.composer_id = 109
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'Dolce cominciamento', part.name_en = 'Quattro canzoni popolari: No. 1. Dolce cominciamento',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 10956 AND p.composer_id = 109 AND part.part_key = 'musicbrainz:478ef38a-cd13-41ae-ae1b-f19af32e6b1e' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:478ef38a-cd13-41ae-ae1b-f19af32e6b1e', 1, NULL, 'Dolce cominciamento', 'Quattro canzoni popolari: No. 1. Dolce cominciamento', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 10956 AND p.composer_id = 109
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:478ef38a-cd13-41ae-ae1b-f19af32e6b1e'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'La donna ideale', part.name_en = 'Quattro canzoni popolari: No. 2. La donna ideale',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 10956 AND p.composer_id = 109 AND part.part_key = 'musicbrainz:9702075e-2a0e-47ec-ae78-71f96e474793' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:9702075e-2a0e-47ec-ae78-71f96e474793', 2, NULL, 'La donna ideale', 'Quattro canzoni popolari: No. 2. La donna ideale', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 10956 AND p.composer_id = 109
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:9702075e-2a0e-47ec-ae78-71f96e474793'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = NULL,
    part.name_ko = 'Avendo gran disio', part.name_en = 'Quattro canzoni popolari: No. 3. Avendo gran disio',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 10956 AND p.composer_id = 109 AND part.part_key = 'musicbrainz:224f1210-cb70-49b7-8aaa-c8a4b4d0808e' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:224f1210-cb70-49b7-8aaa-c8a4b4d0808e', 3, NULL, 'Avendo gran disio', 'Quattro canzoni popolari: No. 3. Avendo gran disio', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 10956 AND p.composer_id = 109
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:224f1210-cb70-49b7-8aaa-c8a4b4d0808e'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = NULL,
    part.name_ko = 'Ballo', part.name_en = 'Quattro canzoni popolari: No. 4. Ballo',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 10956 AND p.composer_id = 109 AND part.part_key = 'musicbrainz:ddde4650-db4c-4ea5-975c-e6719df559d4' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:ddde4650-db4c-4ea5-975c-e6719df559d4', 4, NULL, 'Ballo', 'Quattro canzoni popolari: No. 4. Ballo', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 10956 AND p.composer_id = 109
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:ddde4650-db4c-4ea5-975c-e6719df559d4'
);


-- None Quatuor no. 1

UPDATE pieces piece
SET piece.title = 'Quatuor no. 1', piece.title_en = 'Quatuor no. 1',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 9770 AND piece.composer_id = 109
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Recital I (for Cathy)

UPDATE pieces piece
SET piece.title = 'Recital I (for Cathy)', piece.title_en = 'Recital I (for Cathy)',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 11038 AND piece.composer_id = 109
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'II',
    part.name_ko = 'Amor, dov''è la fé (Monteverdi)', part.name_en = 'Recital I for Cathy: II. Amor, dov''è la fé (Monteverdi)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11038 AND p.composer_id = 109 AND part.part_key = 'musicbrainz:015d6b5e-541e-4c02-9612-96c091e1389b' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:015d6b5e-541e-4c02-9612-96c091e1389b', 1, 'II', 'Amor, dov''è la fé (Monteverdi)', 'Recital I for Cathy: II. Amor, dov''è la fé (Monteverdi)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 11038 AND p.composer_id = 109
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:015d6b5e-541e-4c02-9612-96c091e1389b'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'III',
    part.name_ko = '"ah! he hadn''t been there before..."', part.name_en = 'Recital I for Cathy: III. "ah! he hadn''t been there before..."',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11038 AND p.composer_id = 109 AND part.part_key = 'musicbrainz:40d01fad-3785-4d03-a7c5-1e3078001f28' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:40d01fad-3785-4d03-a7c5-1e3078001f28', 2, 'III', '"ah! he hadn''t been there before..."', 'Recital I for Cathy: III. "ah! he hadn''t been there before..."', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 11038 AND p.composer_id = 109
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:40d01fad-3785-4d03-a7c5-1e3078001f28'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'VIII',
    part.name_ko = 'Calmo e lontano: "libera nos"', part.name_en = 'Recital I for Cathy: VIII. Calmo e lontano: "libera nos"',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11038 AND p.composer_id = 109 AND part.part_key = 'musicbrainz:52589a67-c350-4dae-9f10-d1965cd2149b' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:52589a67-c350-4dae-9f10-d1965cd2149b', 3, 'VIII', 'Calmo e lontano: "libera nos"', 'Recital I for Cathy: VIII. Calmo e lontano: "libera nos"', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 11038 AND p.composer_id = 109
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:52589a67-c350-4dae-9f10-d1965cd2149b'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = 'VI',
    part.name_ko = '"Who hasn''t taken a piece out of my life?"', part.name_en = 'Recital I for Cathy: VI. "Who hasn''t taken a piece out of my life?"',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11038 AND p.composer_id = 109 AND part.part_key = 'musicbrainz:760bc67c-3c68-4af7-88d3-6ab64444cd02' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:760bc67c-3c68-4af7-88d3-6ab64444cd02', 4, 'VI', '"Who hasn''t taken a piece out of my life?"', 'Recital I for Cathy: VI. "Who hasn''t taken a piece out of my life?"', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 11038 AND p.composer_id = 109
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:760bc67c-3c68-4af7-88d3-6ab64444cd02'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 5, part.movement_number = 'VII',
    part.name_ko = 'Musician Exchange: "these 5 men..."', part.name_en = 'Recital I for Cathy: VII. Musician Exchange: "these 5 men..."',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11038 AND p.composer_id = 109 AND part.part_key = 'musicbrainz:97075acd-fe77-421d-8dc4-b4930adcd5b7' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:97075acd-fe77-421d-8dc4-b4930adcd5b7', 5, 'VII', 'Musician Exchange: "these 5 men..."', 'Recital I for Cathy: VII. Musician Exchange: "these 5 men..."', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 11038 AND p.composer_id = 109
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:97075acd-fe77-421d-8dc4-b4930adcd5b7'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 6, part.movement_number = 'VIII',
    part.name_ko = 'Excerpts: Mahler, Delibes, Rossini, etc', part.name_en = 'Recital I for Cathy: VIII. Excerpts: Mahler, Delibes, Rossini, etc.',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11038 AND p.composer_id = 109 AND part.part_key = 'musicbrainz:d13c7221-d951-463c-8b45-6e25dc6d84ed' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:d13c7221-d951-463c-8b45-6e25dc6d84ed', 6, 'VIII', 'Excerpts: Mahler, Delibes, Rossini, etc', 'Recital I for Cathy: VIII. Excerpts: Mahler, Delibes, Rossini, etc.', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 11038 AND p.composer_id = 109
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:d13c7221-d951-463c-8b45-6e25dc6d84ed'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 7, part.movement_number = 'IV',
    part.name_ko = '"clarinet that''s the sound that''s been haunting me..."', part.name_en = 'Recital I for Cathy: IV. "clarinet that''s the sound that''s been haunting me..."',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11038 AND p.composer_id = 109 AND part.part_key = 'musicbrainz:f8902b40-753a-4615-84d4-8efe1bd37f15' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:f8902b40-753a-4615-84d4-8efe1bd37f15', 7, 'IV', '"clarinet that''s the sound that''s been haunting me..."', 'Recital I for Cathy: IV. "clarinet that''s the sound that''s been haunting me..."', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 11038 AND p.composer_id = 109
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:f8902b40-753a-4615-84d4-8efe1bd37f15'
);


-- None Requies

UPDATE pieces piece
SET piece.title = 'Requies', piece.title_en = 'Requies',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 9735 AND piece.composer_id = 109
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Récit (Chemins VII)

UPDATE pieces piece
SET piece.title = 'Récit (Chemins VII)', piece.title_en = 'Récit (Chemins VII)',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 9001 AND piece.composer_id = 109
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None SOLO

UPDATE pieces piece
SET piece.title = 'SOLO', piece.title_en = 'SOLO',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 8767 AND piece.composer_id = 109
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Sequenza I for Flute

UPDATE pieces piece
SET piece.title = 'Sequenza I for Flute', piece.title_en = 'Sequenza I for Flute',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 10615 AND piece.composer_id = 109
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Sequenza II for Harp

UPDATE pieces piece
SET piece.title = 'Sequenza II for Harp', piece.title_en = 'Sequenza II for Harp',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 9084 AND piece.composer_id = 109
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Sequenza III for Woman's Voice

UPDATE pieces piece
SET piece.title = 'Sequenza III for Woman''s Voice', piece.title_en = 'Sequenza III for Woman''s Voice',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 8525 AND piece.composer_id = 109
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Sequenza IV

UPDATE pieces piece
SET piece.title = 'Sequenza IV', piece.title_en = 'Sequenza IV',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 11052 AND piece.composer_id = 109
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Sequenza IX for Clarinet

UPDATE pieces piece
SET piece.title = 'Sequenza IX for Clarinet', piece.title_en = 'Sequenza IX for Clarinet',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 9404 AND piece.composer_id = 109
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Sequenza V for Trombone

UPDATE pieces piece
SET piece.title = 'Sequenza V for Trombone', piece.title_en = 'Sequenza V for Trombone',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 9766 AND piece.composer_id = 109
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Sequenza VI for Viola

UPDATE pieces piece
SET piece.title = 'Sequenza VI for Viola', piece.title_en = 'Sequenza VI for Viola',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 10761 AND piece.composer_id = 109
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Sequenza VII for Oboe

UPDATE pieces piece
SET piece.title = 'Sequenza VII for Oboe', piece.title_en = 'Sequenza VII for Oboe',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 9589 AND piece.composer_id = 109
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Sequenza VIII for Violin

UPDATE pieces piece
SET piece.title = 'Sequenza VIII for Violin', piece.title_en = 'Sequenza VIII for Violin',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 11268 AND piece.composer_id = 109
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Sequenza X for Trumpet in C and Piano Resonance

UPDATE pieces piece
SET piece.title = 'Sequenza X for Trumpet in C and Piano Resonance', piece.title_en = 'Sequenza X for Trumpet in C and Piano Resonance',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 9964 AND piece.composer_id = 109
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Sequenza XI for Guitar

UPDATE pieces piece
SET piece.title = 'Sequenza XI for Guitar', piece.title_en = 'Sequenza XI for Guitar',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 9783 AND piece.composer_id = 109
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Sequenza XII for Bassoon

UPDATE pieces piece
SET piece.title = 'Sequenza XII for Bassoon', piece.title_en = 'Sequenza XII for Bassoon',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 8688 AND piece.composer_id = 109
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Sequenza XIII for Accordion ‘Chanson’

UPDATE pieces piece
SET piece.title = 'Sequenza XIII for Accordion ‘Chanson’', piece.title_en = 'Sequenza XIII for Accordion ‘Chanson’',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 7690 AND piece.composer_id = 109
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Sequenza XIV for Cello

UPDATE pieces piece
SET piece.title = 'Sequenza XIV for Cello', piece.title_en = 'Sequenza XIV for Cello',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 7802 AND piece.composer_id = 109
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Serenata I

UPDATE pieces piece
SET piece.title = 'Serenata I', piece.title_en = 'Serenata I',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 8480 AND piece.composer_id = 109
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Shofar

UPDATE pieces piece
SET piece.title = 'Shofar', piece.title_en = 'Shofar',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 7991 AND piece.composer_id = 109
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Sincronie

UPDATE pieces piece
SET piece.title = 'Sincronie', piece.title_en = 'Sincronie',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 8407 AND piece.composer_id = 109
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None 신포니아

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'I', part.name_en = 'Sinfonia: I.',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 410 AND p.composer_id = 109 AND part.part_key = 'musicbrainz:622ce7d6-ff06-4ab6-b9f6-8eacdf162733' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:622ce7d6-ff06-4ab6-b9f6-8eacdf162733', 1, NULL, 'I', 'Sinfonia: I.', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 410 AND p.composer_id = 109
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:622ce7d6-ff06-4ab6-b9f6-8eacdf162733'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'O King', part.name_en = 'Sinfonia: II. O King',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 410 AND p.composer_id = 109 AND part.part_key = 'musicbrainz:92ae7a40-6e59-4962-ab69-c2210de88e13' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:92ae7a40-6e59-4962-ab69-c2210de88e13', 2, NULL, 'O King', 'Sinfonia: II. O King', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 410 AND p.composer_id = 109
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:92ae7a40-6e59-4962-ab69-c2210de88e13'
);


-- None Six Encores

UPDATE pieces piece
SET piece.title = 'Six Encores', piece.title_en = 'Six Encores',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 11178 AND piece.composer_id = 109
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'Brin', part.name_en = 'Six Encores: No. 1. Brin',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11178 AND p.composer_id = 109 AND part.part_key = 'musicbrainz:64984ad0-610b-4db8-a5cf-6c52dc0f375e' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:64984ad0-610b-4db8-a5cf-6c52dc0f375e', 1, NULL, 'Brin', 'Six Encores: No. 1. Brin', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 11178 AND p.composer_id = 109
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:64984ad0-610b-4db8-a5cf-6c52dc0f375e'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'Leaf', part.name_en = 'Six Encores: No. 2. Leaf',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11178 AND p.composer_id = 109 AND part.part_key = 'musicbrainz:8acf09dd-f223-45b1-a4c9-b860b0bb64d2' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:8acf09dd-f223-45b1-a4c9-b860b0bb64d2', 2, NULL, 'Leaf', 'Six Encores: No. 2. Leaf', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 11178 AND p.composer_id = 109
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:8acf09dd-f223-45b1-a4c9-b860b0bb64d2'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = NULL,
    part.name_ko = 'Wasserklavier', part.name_en = 'Six Encores: No. 3. Wasserklavier',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11178 AND p.composer_id = 109 AND part.part_key = 'musicbrainz:91995053-c961-4f63-b47a-9ef9655abf20' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:91995053-c961-4f63-b47a-9ef9655abf20', 3, NULL, 'Wasserklavier', 'Six Encores: No. 3. Wasserklavier', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 11178 AND p.composer_id = 109
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:91995053-c961-4f63-b47a-9ef9655abf20'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = NULL,
    part.name_ko = 'Erdenklavier', part.name_en = 'Six Encores: No. 4. Erdenklavier',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11178 AND p.composer_id = 109 AND part.part_key = 'musicbrainz:78e266e5-bfc6-4c63-8d6e-f83b595d3ae8' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:78e266e5-bfc6-4c63-8d6e-f83b595d3ae8', 4, NULL, 'Erdenklavier', 'Six Encores: No. 4. Erdenklavier', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 11178 AND p.composer_id = 109
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:78e266e5-bfc6-4c63-8d6e-f83b595d3ae8'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 5, part.movement_number = NULL,
    part.name_ko = 'Luftklavier', part.name_en = 'Six Encores: No. 5. Luftklavier',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11178 AND p.composer_id = 109 AND part.part_key = 'musicbrainz:52d55c4e-b645-475f-a0d9-2ea7c8b5064f' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:52d55c4e-b645-475f-a0d9-2ea7c8b5064f', 5, NULL, 'Luftklavier', 'Six Encores: No. 5. Luftklavier', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 11178 AND p.composer_id = 109
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:52d55c4e-b645-475f-a0d9-2ea7c8b5064f'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 6, part.movement_number = NULL,
    part.name_ko = 'Feuerklavier', part.name_en = 'Six Encores: No. 6. Feuerklavier',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11178 AND p.composer_id = 109 AND part.part_key = 'musicbrainz:f1ae8d9c-d9b0-4a99-bd19-3aa221966cee' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:f1ae8d9c-d9b0-4a99-bd19-3aa221966cee', 6, NULL, 'Feuerklavier', 'Six Encores: No. 6. Feuerklavier', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 11178 AND p.composer_id = 109
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:f1ae8d9c-d9b0-4a99-bd19-3aa221966cee'
);


-- None 피아노 소나타

UPDATE pieces piece
SET piece.title = '피아노 소나타', piece.title_en = 'Sonata for piano',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 9741 AND piece.composer_id = 109
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Stanze

UPDATE pieces piece
SET piece.title = 'Stanze', piece.title_en = 'Stanze',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 8715 AND piece.composer_id = 109
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'Tenebrae', part.name_en = 'Stanze: I. Tenebrae',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 8715 AND p.composer_id = 109 AND part.part_key = 'musicbrainz:8f9b9fa2-1d1a-45e4-872e-739487a682b8' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:8f9b9fa2-1d1a-45e4-872e-739487a682b8', 1, 'I', 'Tenebrae', 'Stanze: I. Tenebrae', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 8715 AND p.composer_id = 109
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:8f9b9fa2-1d1a-45e4-872e-739487a682b8'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'Congedo del viaggiatore cerimonioso', part.name_en = 'Stanze: II. Congedo del viaggiatore cerimonioso',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 8715 AND p.composer_id = 109 AND part.part_key = 'musicbrainz:9ea9cadd-265b-473c-a321-0e1f9fc2a6d0' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:9ea9cadd-265b-473c-a321-0e1f9fc2a6d0', 2, 'II', 'Congedo del viaggiatore cerimonioso', 'Stanze: II. Congedo del viaggiatore cerimonioso', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 8715 AND p.composer_id = 109
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:9ea9cadd-265b-473c-a321-0e1f9fc2a6d0'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = NULL,
    part.name_ko = 'III', part.name_en = 'Stanze: III',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 8715 AND p.composer_id = 109 AND part.part_key = 'musicbrainz:9cd2d48f-ca89-48d6-94d2-aac079f9979e' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:9cd2d48f-ca89-48d6-94d2-aac079f9979e', 3, NULL, 'III', 'Stanze: III', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 8715 AND p.composer_id = 109
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:9cd2d48f-ca89-48d6-94d2-aac079f9979e'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = NULL,
    part.name_ko = 'IV', part.name_en = 'Stanze: IV',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 8715 AND p.composer_id = 109 AND part.part_key = 'musicbrainz:fc234d6e-87c7-4ca3-a92b-3e39eeee591c' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:fc234d6e-87c7-4ca3-a92b-3e39eeee591c', 4, NULL, 'IV', 'Stanze: IV', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 8715 AND p.composer_id = 109
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:fc234d6e-87c7-4ca3-a92b-3e39eeee591c'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 5, part.movement_number = 'V',
    part.name_ko = 'Die Schlacht', part.name_en = 'Stanze: V. Die Schlacht',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 8715 AND p.composer_id = 109 AND part.part_key = 'musicbrainz:c73b547e-9267-434e-a240-7b2e74c02753' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:c73b547e-9267-434e-a240-7b2e74c02753', 5, 'V', 'Die Schlacht', 'Stanze: V. Die Schlacht', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 8715 AND p.composer_id = 109
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:c73b547e-9267-434e-a240-7b2e74c02753'
);


-- None 연습곡

UPDATE pieces piece
SET piece.title = '연습곡', piece.title_en = 'Study',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 9597 AND piece.composer_id = 109
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Thema (Omaggio a Joyce)

UPDATE pieces piece
SET piece.title = 'Thema (Omaggio a Joyce)', piece.title_en = 'Thema (Omaggio a Joyce)',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 10707 AND piece.composer_id = 109
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None There is no tune

UPDATE pieces piece
SET piece.title = 'There is no tune', piece.title_en = 'There is no tune',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 10675 AND piece.composer_id = 109
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Touch

UPDATE pieces piece
SET piece.title = 'Touch', piece.title_en = 'Touch',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 11100 AND piece.composer_id = 109
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Un ballo

UPDATE pieces piece
SET piece.title = 'Un ballo', piece.title_en = 'Un ballo',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 8960 AND piece.composer_id = 109
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None 오페라 <Un re in ascolto>

UPDATE pieces piece
SET piece.title = '오페라 <Un re in ascolto>', piece.title_en = 'Un re in ascolto',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 8563 AND piece.composer_id = 109
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'Teil I: II. Duetto I', part.name_en = 'Un Re in ascolto: Teil I: II. Duetto I',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 8563 AND p.composer_id = 109 AND part.part_key = 'musicbrainz:0311e4e3-da9a-4762-8da3-149fed5c020e' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:0311e4e3-da9a-4762-8da3-149fed5c020e', 1, NULL, 'Teil I: II. Duetto I', 'Un Re in ascolto: Teil I: II. Duetto I', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 8563 AND p.composer_id = 109
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:0311e4e3-da9a-4762-8da3-149fed5c020e'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'Teil II: II. Air', part.name_en = 'Un Re in ascolto: Teil II: II. Air',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 8563 AND p.composer_id = 109 AND part.part_key = 'musicbrainz:1ec589fa-4da4-464c-b8b9-1e21e4bad6c2' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:1ec589fa-4da4-464c-b8b9-1e21e4bad6c2', 2, NULL, 'Teil II: II. Air', 'Un Re in ascolto: Teil II: II. Air', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 8563 AND p.composer_id = 109
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:1ec589fa-4da4-464c-b8b9-1e21e4bad6c2'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = NULL,
    part.name_ko = 'Teil I: IX. Audizione II', part.name_en = 'Un Re in ascolto: Teil I: IX. Audizione II',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 8563 AND p.composer_id = 109 AND part.part_key = 'musicbrainz:1fe17de3-449a-4dad-9c91-c3b69c34cfe6' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:1fe17de3-449a-4dad-9c91-c3b69c34cfe6', 3, NULL, 'Teil I: IX. Audizione II', 'Un Re in ascolto: Teil I: IX. Audizione II', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 8563 AND p.composer_id = 109
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:1fe17de3-449a-4dad-9c91-c3b69c34cfe6'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = NULL,
    part.name_ko = 'Teil I: III. Concertato I', part.name_en = 'Un Re in ascolto: Teil I: III. Concertato I',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 8563 AND p.composer_id = 109 AND part.part_key = 'musicbrainz:404749fa-66be-4223-aedc-c5d13cb0c6cf' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:404749fa-66be-4223-aedc-c5d13cb0c6cf', 4, NULL, 'Teil I: III. Concertato I', 'Un Re in ascolto: Teil I: III. Concertato I', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 8563 AND p.composer_id = 109
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:404749fa-66be-4223-aedc-c5d13cb0c6cf'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 5, part.movement_number = NULL,
    part.name_ko = 'Teil II: VI. Concertato IV', part.name_en = 'Un Re in ascolto: Teil II: VI. Concertato IV',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 8563 AND p.composer_id = 109 AND part.part_key = 'musicbrainz:58b95efe-e696-438d-a11a-be4c37e514c1' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:58b95efe-e696-438d-a11a-be4c37e514c1', 5, NULL, 'Teil II: VI. Concertato IV', 'Un Re in ascolto: Teil II: VI. Concertato IV', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 8563 AND p.composer_id = 109
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:58b95efe-e696-438d-a11a-be4c37e514c1'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 6, part.movement_number = NULL,
    part.name_ko = 'Teil I: XI. Aria III', part.name_en = 'Un Re in ascolto: Teil I: XI. Aria III',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 8563 AND p.composer_id = 109 AND part.part_key = 'musicbrainz:5f7ae19c-2259-4679-9349-b81901dc95ca' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:5f7ae19c-2259-4679-9349-b81901dc95ca', 6, NULL, 'Teil I: XI. Aria III', 'Un Re in ascolto: Teil I: XI. Aria III', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 8563 AND p.composer_id = 109
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:5f7ae19c-2259-4679-9349-b81901dc95ca'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 7, part.movement_number = NULL,
    part.name_ko = 'Teil I: IV. Audizione I', part.name_en = 'Un Re in ascolto: Teil I: IV. Audizione I',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 8563 AND p.composer_id = 109 AND part.part_key = 'musicbrainz:896edb74-9e2b-4efe-ad95-1294cb208521' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:896edb74-9e2b-4efe-ad95-1294cb208521', 7, NULL, 'Teil I: IV. Audizione I', 'Un Re in ascolto: Teil I: IV. Audizione I', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 8563 AND p.composer_id = 109
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:896edb74-9e2b-4efe-ad95-1294cb208521'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 8, part.movement_number = NULL,
    part.name_ko = 'Teil II: V. Aria V', part.name_en = 'Un Re in ascolto: Teil II: V. Aria V',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 8563 AND p.composer_id = 109 AND part.part_key = 'musicbrainz:96b6e865-2215-4d6d-b1ef-380781b726d5' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:96b6e865-2215-4d6d-b1ef-380781b726d5', 8, NULL, 'Teil II: V. Aria V', 'Un Re in ascolto: Teil II: V. Aria V', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 8563 AND p.composer_id = 109
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:96b6e865-2215-4d6d-b1ef-380781b726d5'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 9, part.movement_number = NULL,
    part.name_ko = 'Teil I: VII. Serenata', part.name_en = 'Un Re in ascolto: Teil I: VII. Serenata',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 8563 AND p.composer_id = 109 AND part.part_key = 'musicbrainz:9f50c003-011f-48c0-b774-af7b7475761f' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:9f50c003-011f-48c0-b774-af7b7475761f', 9, NULL, 'Teil I: VII. Serenata', 'Un Re in ascolto: Teil I: VII. Serenata', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 8563 AND p.composer_id = 109
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:9f50c003-011f-48c0-b774-af7b7475761f'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 10, part.movement_number = NULL,
    part.name_ko = 'Teil II: VII. Aria VI', part.name_en = 'Un Re in ascolto: Teil II: VII. Aria VI',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 8563 AND p.composer_id = 109 AND part.part_key = 'musicbrainz:a828ae39-1426-43a8-84f7-c1271874975a' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:a828ae39-1426-43a8-84f7-c1271874975a', 10, NULL, 'Teil II: VII. Aria VI', 'Un Re in ascolto: Teil II: VII. Aria VI', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 8563 AND p.composer_id = 109
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:a828ae39-1426-43a8-84f7-c1271874975a'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 11, part.movement_number = NULL,
    part.name_ko = 'Teil I: V. Duetto II', part.name_en = 'Un Re in ascolto: Teil I: V. Duetto II',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 8563 AND p.composer_id = 109 AND part.part_key = 'musicbrainz:a890f8c9-afc8-4b2a-ad30-03f258685d7d' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:a890f8c9-afc8-4b2a-ad30-03f258685d7d', 11, NULL, 'Teil I: V. Duetto II', 'Un Re in ascolto: Teil I: V. Duetto II', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 8563 AND p.composer_id = 109
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:a890f8c9-afc8-4b2a-ad30-03f258685d7d'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 12, part.movement_number = NULL,
    part.name_ko = 'Teil I: I. Aria I', part.name_en = 'Un Re in ascolto: Teil I: I. Aria I',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 8563 AND p.composer_id = 109 AND part.part_key = 'musicbrainz:b7f1e827-9c82-43f8-9c93-aa19a5bbf0ab' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:b7f1e827-9c82-43f8-9c93-aa19a5bbf0ab', 12, NULL, 'Teil I: I. Aria I', 'Un Re in ascolto: Teil I: I. Aria I', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 8563 AND p.composer_id = 109
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:b7f1e827-9c82-43f8-9c93-aa19a5bbf0ab'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 13, part.movement_number = NULL,
    part.name_ko = 'Teil I: VIII. Aria II', part.name_en = 'Un Re in ascolto: Teil I: VIII. Aria II',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 8563 AND p.composer_id = 109 AND part.part_key = 'musicbrainz:b97aa60a-a5d8-4bae-b818-df31cf8fdbef' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:b97aa60a-a5d8-4bae-b818-df31cf8fdbef', 13, NULL, 'Teil I: VIII. Aria II', 'Un Re in ascolto: Teil I: VIII. Aria II', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 8563 AND p.composer_id = 109
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:b97aa60a-a5d8-4bae-b818-df31cf8fdbef'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 14, part.movement_number = NULL,
    part.name_ko = 'Teil II: IV. Aria IV', part.name_en = 'Un Re in ascolto: Teil II: IV. Aria IV',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 8563 AND p.composer_id = 109 AND part.part_key = 'musicbrainz:c3839065-22a2-4137-ad05-f5aeb4e9dedf' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:c3839065-22a2-4137-ad05-f5aeb4e9dedf', 14, NULL, 'Teil II: IV. Aria IV', 'Un Re in ascolto: Teil II: IV. Aria IV', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 8563 AND p.composer_id = 109
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:c3839065-22a2-4137-ad05-f5aeb4e9dedf'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 15, part.movement_number = NULL,
    part.name_ko = 'Teil I: X. Duetto III', part.name_en = 'Un Re in ascolto: Teil I: X. Duetto III',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 8563 AND p.composer_id = 109 AND part.part_key = 'musicbrainz:d79dfef4-fdcc-4973-8ec5-ed4f16fe1922' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:d79dfef4-fdcc-4973-8ec5-ed4f16fe1922', 15, NULL, 'Teil I: X. Duetto III', 'Un Re in ascolto: Teil I: X. Duetto III', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 8563 AND p.composer_id = 109
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:d79dfef4-fdcc-4973-8ec5-ed4f16fe1922'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 16, part.movement_number = NULL,
    part.name_ko = 'Teil II: I. Duetto IV', part.name_en = 'Un Re in ascolto: Teil II: I. Duetto IV',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 8563 AND p.composer_id = 109 AND part.part_key = 'musicbrainz:ea1823dd-fd0a-4841-9c38-b700df92a49b' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:ea1823dd-fd0a-4841-9c38-b700df92a49b', 16, NULL, 'Teil II: I. Duetto IV', 'Un Re in ascolto: Teil II: I. Duetto IV', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 8563 AND p.composer_id = 109
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:ea1823dd-fd0a-4841-9c38-b700df92a49b'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 17, part.movement_number = NULL,
    part.name_ko = 'Teil II: III. Audizione III', part.name_en = 'Un Re in ascolto: Teil II: III. Audizione III',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 8563 AND p.composer_id = 109 AND part.part_key = 'musicbrainz:f627dc7c-b1fc-4ac6-9d02-f26b4faf0b8b' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:f627dc7c-b1fc-4ac6-9d02-f26b4faf0b8b', 17, NULL, 'Teil II: III. Audizione III', 'Un Re in ascolto: Teil II: III. Audizione III', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 8563 AND p.composer_id = 109
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:f627dc7c-b1fc-4ac6-9d02-f26b4faf0b8b'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 18, part.movement_number = NULL,
    part.name_ko = 'Teil I: VI. Concertato II con figure', part.name_en = 'Un Re in ascolto: Teil I: VI. Concertato II con figure',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 8563 AND p.composer_id = 109 AND part.part_key = 'musicbrainz:fa519e6d-7df4-49f7-9cfb-21e816adaf34' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:fa519e6d-7df4-49f7-9cfb-21e816adaf34', 18, NULL, 'Teil I: VI. Concertato II con figure', 'Un Re in ascolto: Teil I: VI. Concertato II con figure', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 8563 AND p.composer_id = 109
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:fa519e6d-7df4-49f7-9cfb-21e816adaf34'
);


-- None Visage

UPDATE pieces piece
SET piece.title = 'Visage', piece.title_en = 'Visage',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 11122 AND piece.composer_id = 109
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Voci

UPDATE pieces piece
SET piece.title = 'Voci', piece.title_en = 'Voci',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 8459 AND piece.composer_id = 109
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Wasserklavier

UPDATE pieces piece
SET piece.title = 'Wasserklavier', piece.title_en = 'Wasserklavier',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 9300 AND piece.composer_id = 109
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None 칸초네타

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '칸초네타', 'Canzonetta', 'song', NULL, NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 109
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '칸초네타'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '76e6b41c-82b5-4c6e-954b-ceb3efe11940'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '76e6b41c-82b5-4c6e-954b-ceb3efe11940'
FROM pieces p
WHERE p.composer_id = 109 AND p.title = '칸초네타' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '76e6b41c-82b5-4c6e-954b-ceb3efe11940'
);


-- None Cries of London

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, 'Cries of London', 'Cries of London', 'song', NULL, NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 109
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = 'Cries of London'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '3064fab3-7acd-425a-9bfc-344688b1d9ca'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '3064fab3-7acd-425a-9bfc-344688b1d9ca'
FROM pieces p
WHERE p.composer_id = 109 AND p.title = 'Cries of London' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '3064fab3-7acd-425a-9bfc-344688b1d9ca'
);


-- None Memory

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, 'Memory', 'Memory', 'song', NULL, NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 109
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = 'Memory'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'f621aa05-f367-4d6f-bb9b-bcf0316c6d69'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'f621aa05-f367-4d6f-bb9b-bcf0316c6d69'
FROM pieces p
WHERE p.composer_id = 109 AND p.title = 'Memory' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'f621aa05-f367-4d6f-bb9b-bcf0316c6d69'
);


-- None Petite Suite

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, 'Petite Suite', 'Petite Suite', 'album', NULL, NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 109
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = 'Petite Suite'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '7624fcb8-6bd0-4cc7-8cd2-3ea10fc08261'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '7624fcb8-6bd0-4cc7-8cd2-3ea10fc08261'
FROM pieces p
WHERE p.composer_id = 109 AND p.title = 'Petite Suite' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '7624fcb8-6bd0-4cc7-8cd2-3ea10fc08261'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:e9ac61b6-8bfc-4a03-ac9e-dcebffb9e193', 1, 'I', 'Prelude', 'Petite Suite: I. Prelude', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 109 AND p.title = 'Petite Suite' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:e9ac61b6-8bfc-4a03-ac9e-dcebffb9e193'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:512f2e0c-411c-430f-b533-da03d49afeb9', 2, 'II', 'Petit Air I', 'Petite Suite: II. Petit Air I', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 109 AND p.title = 'Petite Suite' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:512f2e0c-411c-430f-b533-da03d49afeb9'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:5ba63d15-cd15-474d-b644-9dc35dd2cce6', 3, 'III', 'Gavotte', 'Petite Suite: III. Gavotte', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 109 AND p.title = 'Petite Suite' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:5ba63d15-cd15-474d-b644-9dc35dd2cce6'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:13cbbe0d-7bb6-44df-aa8f-13b59a701d39', 4, 'IV', 'Petit Air II', 'Petite Suite: IV. Petit Air II', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 109 AND p.title = 'Petite Suite' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:13cbbe0d-7bb6-44df-aa8f-13b59a701d39'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:68d28e0e-8598-41cc-b81a-a0f025e9fc8c', 5, 'V', 'Gigue', 'Petite Suite: V. Gigue', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 109 AND p.title = 'Petite Suite' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:68d28e0e-8598-41cc-b81a-a0f025e9fc8c'
);


-- None Rounds

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, 'Rounds', 'Rounds', 'song', NULL, NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 109
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = 'Rounds'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '5f63a28b-0e46-4985-8aa2-5b74be01db5f'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '5f63a28b-0e46-4985-8aa2-5b74be01db5f'
FROM pieces p
WHERE p.composer_id = 109 AND p.title = 'Rounds' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '5f63a28b-0e46-4985-8aa2-5b74be01db5f'
);


-- 카탈로그에 대응이 없는 seed 작품 17개를 목록에서 숨긴다(지우지 않음).
UPDATE pieces piece
SET piece.hidden_reason = 'catalog_unmatched'
WHERE piece.composer_id = 109 AND piece.origin = 'seed' AND piece.hidden_reason IS NULL
  AND piece.id IN (
    632, 7488, 7559, 7622, 7707, 8294, 8383, 9371, 9912, 10150, 10222, 10227, 10380, 10651, 10772, 11104, 11208
  )
  AND NOT EXISTS (SELECT 1 FROM performance_sectors sector WHERE sector.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM piece_parts linking WHERE linking.linked_piece_id = piece.id);
