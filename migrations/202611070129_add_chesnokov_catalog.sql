-- Pavel Chesnokov 작품을 MusicBrainz 작품 구조로 다시 짠다(5차 자동). 작품 26개(묶음 5, 다악장 0, 낱곡 21),
-- 새 작품 2개, part 28개, 그 아래 0개.
-- seed 26개 중 24개를 작품·part 에 잇고, 1개를 숨기고, 1개는 그대로 둔다.
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

-- Op. 38 No. 1 "Gospodi, spasi" i Trisvyatoye

UPDATE pieces piece
SET piece.title = '"Gospodi, spasi" i Trisvyatoye', piece.title_en = '"Gospodi, spasi" i Trisvyatoye, op. 38 no. 1',
    piece.type = 'song', piece.opus_number = 'Op. 38 No. 1',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 23083 AND piece.composer_id = 389
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- Op. 44 All-night Vigil Op. 44

UPDATE pieces piece
SET piece.title = 'All-night Vigil Op. 44', piece.title_en = 'All-night Vigil, op. 44',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = 'Op.', piece.catalogue_number = '44',
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 24814 AND piece.composer_id = 389
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'Nine otpushchayeshi', part.name_en = 'All-night Vigil, op. 44: Nine otpushchayeshi',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 24814 AND p.composer_id = 389 AND part.part_key = 'musicbrainz:4ea4e24d-2291-4cd2-99c6-a8272e3c41cb' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:4ea4e24d-2291-4cd2-99c6-a8272e3c41cb', 1, NULL, 'Nine otpushchayeshi', 'All-night Vigil, op. 44: Nine otpushchayeshi', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 24814 AND p.composer_id = 389
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:4ea4e24d-2291-4cd2-99c6-a8272e3c41cb'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'Tropari voskresni “Angelskiy sobor”', part.name_en = 'All-night Vigil, op. 44: Tropari voskresni “Angelskiy sobor”',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 24814 AND p.composer_id = 389 AND part.part_key = 'musicbrainz:6c2cd4b2-afa5-43a3-ae99-7072f348d104' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:6c2cd4b2-afa5-43a3-ae99-7072f348d104', 2, NULL, 'Tropari voskresni “Angelskiy sobor”', 'All-night Vigil, op. 44: Tropari voskresni “Angelskiy sobor”', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 24814 AND p.composer_id = 389
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:6c2cd4b2-afa5-43a3-ae99-7072f348d104'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = NULL,
    part.name_ko = 'Bless the Lord, O My Soul', part.name_en = 'Bless the Lord, O My Soul',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 24814 AND p.composer_id = 389 AND part.part_key = 'musicbrainz:a76bc4da-7330-47e2-834b-931843b02e42' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:a76bc4da-7330-47e2-834b-931843b02e42', 3, NULL, 'Bless the Lord, O My Soul', 'Bless the Lord, O My Soul', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 24814 AND p.composer_id = 389
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:a76bc4da-7330-47e2-834b-931843b02e42'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = NULL,
    part.name_ko = 'Hvalite imia Ghospodne', part.name_en = 'All-night Vigil, op. 44: Hvalite imia Ghospodne',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 24814 AND p.composer_id = 389 AND part.part_key = 'musicbrainz:b168a19f-8549-4c53-9867-83220b1ca8b7' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:b168a19f-8549-4c53-9867-83220b1ca8b7', 4, NULL, 'Hvalite imia Ghospodne', 'All-night Vigil, op. 44: Hvalite imia Ghospodne', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 24814 AND p.composer_id = 389
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:b168a19f-8549-4c53-9867-83220b1ca8b7'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 5, part.movement_number = NULL,
    part.name_ko = 'Ot yunosti moyeya', part.name_en = 'All-night Vigil, op. 44: Ot yunosti moyeya',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 24814 AND p.composer_id = 389 AND part.part_key = 'musicbrainz:c455f42c-8bec-495a-93f6-5e31ed40bd32' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:c455f42c-8bec-495a-93f6-5e31ed40bd32', 5, NULL, 'Ot yunosti moyeya', 'All-night Vigil, op. 44: Ot yunosti moyeya', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 24814 AND p.composer_id = 389
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:c455f42c-8bec-495a-93f6-5e31ed40bd32'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 6, part.movement_number = NULL,
    part.name_ko = 'Vzbrannoy voyevode', part.name_en = 'All-night Vigil, op. 44: Vzbrannoy voyevode',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 24814 AND p.composer_id = 389 AND part.part_key = 'musicbrainz:ceae0aeb-4ca3-447e-a381-cbf0e7b3d588' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:ceae0aeb-4ca3-447e-a381-cbf0e7b3d588', 6, NULL, 'Vzbrannoy voyevode', 'All-night Vigil, op. 44: Vzbrannoy voyevode', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 24814 AND p.composer_id = 389
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:ceae0aeb-4ca3-447e-a381-cbf0e7b3d588'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 7, part.movement_number = NULL,
    part.name_ko = 'Voskreseniye Hristovo videvshe', part.name_en = 'All-night Vigil, op. 44: Voskreseniye Hristovo videvshe',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 24814 AND p.composer_id = 389 AND part.part_key = 'musicbrainz:cf627fa2-c71a-444b-a499-579dc3fb26e2' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:cf627fa2-c71a-444b-a499-579dc3fb26e2', 7, NULL, 'Voskreseniye Hristovo videvshe', 'All-night Vigil, op. 44: Voskreseniye Hristovo videvshe', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 24814 AND p.composer_id = 389
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:cf627fa2-c71a-444b-a499-579dc3fb26e2'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 8, part.movement_number = NULL,
    part.name_ko = 'Slavosloviye velikoye', part.name_en = 'All-night Vigil, op. 44: Slavosloviye velikoye',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 24814 AND p.composer_id = 389 AND part.part_key = 'musicbrainz:d2bf155c-e339-4c3b-922a-1c84a0c579e1' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:d2bf155c-e339-4c3b-922a-1c84a0c579e1', 8, NULL, 'Slavosloviye velikoye', 'All-night Vigil, op. 44: Slavosloviye velikoye', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 24814 AND p.composer_id = 389
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:d2bf155c-e339-4c3b-922a-1c84a0c579e1'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 9, part.movement_number = NULL,
    part.name_ko = 'Svete tihiy', part.name_en = 'All-night Vigil, op. 44: Svete tihiy',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 24814 AND p.composer_id = 389 AND part.part_key = 'musicbrainz:ed5cf54a-e9f7-47d6-a73d-5b919fb2d9de' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:ed5cf54a-e9f7-47d6-a73d-5b919fb2d9de', 9, NULL, 'Svete tihiy', 'All-night Vigil, op. 44: Svete tihiy', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 24814 AND p.composer_id = 389
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:ed5cf54a-e9f7-47d6-a73d-5b919fb2d9de'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 10, part.movement_number = NULL,
    part.name_ko = 'Blessed is the Man, op. 44 no. 2', part.name_en = 'Blessed is the Man, op. 44 no. 2',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 24814 AND p.composer_id = 389 AND part.part_key = 'musicbrainz:ee6ea982-3772-415a-a112-6b46a61d4651' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:ee6ea982-3772-415a-a112-6b46a61d4651', 10, NULL, 'Blessed is the Man, op. 44 no. 2', 'Blessed is the Man, op. 44 no. 2', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 24814 AND p.composer_id = 389
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:ee6ea982-3772-415a-a112-6b46a61d4651'
);


-- Op. 22 No. 18 Angel vopiyashe

UPDATE pieces piece
SET piece.title = 'Angel vopiyashe', piece.title_en = 'Angel vopiyashe, op. 22 no. 18',
    piece.type = 'song', piece.opus_number = 'Op. 22 No. 18',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 23254 AND piece.composer_id = 389
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Cherubic Hymn

UPDATE pieces piece
SET piece.title = 'Cherubic Hymn', piece.title_en = 'Cherubic Hymn',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 24585 AND piece.composer_id = 389
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- Op. 7 No. 1 Cherubic Hymn Op. 7 No. 1

UPDATE pieces piece
SET piece.title = 'Cherubic Hymn Op. 7 No. 1', piece.title_en = 'Cherubic Hymn, op. 7, no. 1',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = 'Op.', piece.catalogue_number = '7 No. 1',
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 25109 AND piece.composer_id = 389
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- Op. 8 No. 2 Come, Let Us Worship

UPDATE pieces piece
SET piece.title = 'Come, Let Us Worship', piece.title_en = 'Come, Let Us Worship, op. 8, no. 2',
    piece.type = 'song', piece.opus_number = 'Op. 8 No. 2',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 23402 AND piece.composer_id = 389
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Da ispravitsa molitva noja

UPDATE pieces piece
SET piece.title = 'Da ispravitsa molitva noja', piece.title_en = 'Da ispravitsa molitva noja',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 25151 AND piece.composer_id = 389
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- Op. 48 No. 1 From My Youth

UPDATE pieces piece
SET piece.title = 'From My Youth', piece.title_en = 'From My Youth, op. 48 no. 1',
    piece.type = 'song', piece.opus_number = 'Op. 48 No. 1',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 25485 AND piece.composer_id = 389
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None In That We Have Beheld the Resurrection of Christ (Kiev Chant)

UPDATE pieces piece
SET piece.title = 'In That We Have Beheld the Resurrection of Christ (Kiev Chant)', piece.title_en = 'In That We Have Beheld the Resurrection of Christ (Kiev Chant)',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 24536 AND piece.composer_id = 389
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Matija bozija

UPDATE pieces piece
SET piece.title = 'Matija bozija', piece.title_en = 'Matija bozija',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 24354 AND piece.composer_id = 389
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None O Lord God

UPDATE pieces piece
SET piece.title = 'O Lord God', piece.title_en = 'O Lord God',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 24154 AND piece.composer_id = 389
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- Op. 15 No. 11 O Tebe raduyetsia

UPDATE pieces piece
SET piece.title = 'O Tebe raduyetsia', piece.title_en = 'O Tebe raduyetsia, op. 15 no. 11',
    piece.type = 'song', piece.opus_number = 'Op. 15 No. 11',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 24164 AND piece.composer_id = 389
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Praise ye the name of the Lord

UPDATE pieces piece
SET piece.title = 'Praise ye the name of the Lord', piece.title_en = 'Praise ye the name of the Lord',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 24125 AND piece.composer_id = 389
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- Op. 40 Six Choruses for Mixed Voices Op. 40

UPDATE pieces piece
SET piece.title = 'Six Choruses for Mixed Voices Op. 40', piece.title_en = 'Six Choruses for Mixed Voices, op. 40',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = 'Op.', piece.catalogue_number = '40',
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 24009 AND piece.composer_id = 389
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'Величит душа Моя, op. 40 no. 1', part.name_en = 'Величит душа Моя, op. 40 no. 1',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 24009 AND p.composer_id = 389 AND part.part_key = 'musicbrainz:35e6194e-ff98-4dcb-846b-2ef8c1875eb0' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:35e6194e-ff98-4dcb-846b-2ef8c1875eb0', 1, NULL, 'Величит душа Моя, op. 40 no. 1', 'Величит душа Моя, op. 40 no. 1', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 24009 AND p.composer_id = 389
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:35e6194e-ff98-4dcb-846b-2ef8c1875eb0'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'Совет превечный, op. 40 no. 2', part.name_en = 'Совет превечный, op. 40 no. 2',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 24009 AND p.composer_id = 389 AND part.part_key = 'musicbrainz:01daa925-6410-4b89-83b3-0bfc61befd1c' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:01daa925-6410-4b89-83b3-0bfc61befd1c', 2, NULL, 'Совет превечный, op. 40 no. 2', 'Совет превечный, op. 40 no. 2', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 24009 AND p.composer_id = 389
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:01daa925-6410-4b89-83b3-0bfc61befd1c'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = NULL,
    part.name_ko = 'Разбойника благоразумнаго, op. 40 no. 3', part.name_en = 'Разбойника благоразумнаго, op. 40 no. 3',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 24009 AND p.composer_id = 389 AND part.part_key = 'musicbrainz:b2ec34f7-6217-4dd1-80a9-f700036a369a' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:b2ec34f7-6217-4dd1-80a9-f700036a369a', 3, NULL, 'Разбойника благоразумнаго, op. 40 no. 3', 'Разбойника благоразумнаго, op. 40 no. 3', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 24009 AND p.composer_id = 389
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:b2ec34f7-6217-4dd1-80a9-f700036a369a'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = NULL,
    part.name_ko = 'Ныне отпущаеши, op. 40 no. 4', part.name_en = 'Ныне отпущаеши, op. 40 no. 4',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 24009 AND p.composer_id = 389 AND part.part_key = 'musicbrainz:e5c89a77-bf87-40d0-87bd-4cb5f0145937' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:e5c89a77-bf87-40d0-87bd-4cb5f0145937', 4, NULL, 'Ныне отпущаеши, op. 40 no. 4', 'Ныне отпущаеши, op. 40 no. 4', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 24009 AND p.composer_id = 389
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:e5c89a77-bf87-40d0-87bd-4cb5f0145937'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 5, part.movement_number = NULL,
    part.name_ko = 'Не отвержи мене во время старости, op. 40 no. 5', part.name_en = 'Не отвержи мене во время старости, op. 40 no. 5',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 24009 AND p.composer_id = 389 AND part.part_key = 'musicbrainz:a464a1bc-9805-443f-924e-3e3fcbb35f0b' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:a464a1bc-9805-443f-924e-3e3fcbb35f0b', 5, NULL, 'Не отвержи мене во время старости, op. 40 no. 5', 'Не отвержи мене во время старости, op. 40 no. 5', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 24009 AND p.composer_id = 389
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:a464a1bc-9805-443f-924e-3e3fcbb35f0b'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 6, part.movement_number = NULL,
    part.name_ko = 'С нами Бог, op. 40 no. 6', part.name_en = 'С нами Бог, op. 40 no. 6',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 24009 AND p.composer_id = 389 AND part.part_key = 'musicbrainz:4a8c1da2-956b-3b10-b040-a8bd2027cde8' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:4a8c1da2-956b-3b10-b040-a8bd2027cde8', 6, NULL, 'С нами Бог, op. 40 no. 6', 'С нами Бог, op. 40 no. 6', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 24009 AND p.composer_id = 389
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:4a8c1da2-956b-3b10-b040-a8bd2027cde8'
);


-- None 가곡 <Svete tihiy>

UPDATE pieces piece
SET piece.title = '가곡 <Svete tihiy>', piece.title_en = 'Svete tihiy',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 23095 AND piece.composer_id = 389
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None 가곡 <Tebe poem "We praise thee">

UPDATE pieces piece
SET piece.title = '가곡 <Tebe poem "We praise thee">', piece.title_en = 'Tebe poem "We praise thee"',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 23119 AND piece.composer_id = 389
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None The Assembly of the Angels (Znamenny Chant)

UPDATE pieces piece
SET piece.title = 'The Assembly of the Angels (Znamenny Chant)', piece.title_en = 'The Assembly of the Angels (Znamenny Chant)',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 24752 AND piece.composer_id = 389
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- Op. 43 To the Most Holy Sovereign Lady Op. 43

UPDATE pieces piece
SET piece.title = 'To the Most Holy Sovereign Lady Op. 43', piece.title_en = 'To the Most Holy Sovereign Lady, op. 43',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = 'Op.', piece.catalogue_number = '43',
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 25001 AND piece.composer_id = 389
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'Let Us Pray to the Most Holy Theotokos', part.name_en = 'To the Most Holy Sovereign Lady, op. 43: No. 1. Let Us Pray to the Most Holy Theotokos',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 25001 AND p.composer_id = 389 AND part.part_key = 'musicbrainz:223b38be-1c4b-4b6b-9ea9-142f4aef37e8' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:223b38be-1c4b-4b6b-9ea9-142f4aef37e8', 1, NULL, 'Let Us Pray to the Most Holy Theotokos', 'To the Most Holy Sovereign Lady, op. 43: No. 1. Let Us Pray to the Most Holy Theotokos', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 25001 AND p.composer_id = 389
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:223b38be-1c4b-4b6b-9ea9-142f4aef37e8'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'Заступнице Усердная', part.name_en = 'To the Most Holy Sovereign Lady, op. 43: No. 6. Заступнице Усердная',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 25001 AND p.composer_id = 389 AND part.part_key = 'musicbrainz:328c706a-3cf3-4774-966e-b58fd868d2b6' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:328c706a-3cf3-4774-966e-b58fd868d2b6', 2, NULL, 'Заступнице Усердная', 'To the Most Holy Sovereign Lady, op. 43: No. 6. Заступнице Усердная', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 25001 AND p.composer_id = 389
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:328c706a-3cf3-4774-966e-b58fd868d2b6'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = NULL,
    part.name_ko = 'O Theotokos, We Shall Never Cease Proclaiming', part.name_en = 'To the Most Holy Sovereign Lady, op. 43: No. 4. O Theotokos, We Shall Never Cease Proclaiming',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 25001 AND p.composer_id = 389 AND part.part_key = 'musicbrainz:590a2c83-037d-4d9f-b988-3a35fe1fe2ab' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:590a2c83-037d-4d9f-b988-3a35fe1fe2ab', 3, NULL, 'O Theotokos, We Shall Never Cease Proclaiming', 'To the Most Holy Sovereign Lady, op. 43: No. 4. O Theotokos, We Shall Never Cease Proclaiming', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 25001 AND p.composer_id = 389
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:590a2c83-037d-4d9f-b988-3a35fe1fe2ab'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = NULL,
    part.name_ko = 'Beneath Thy Compassion', part.name_en = 'To the Most Holy Sovereign Lady, op. 43: No. 5. Beneath Thy Compassion',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 25001 AND p.composer_id = 389 AND part.part_key = 'musicbrainz:9a19ac30-363f-485c-b483-6708ef88e548' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:9a19ac30-363f-485c-b483-6708ef88e548', 4, NULL, 'Beneath Thy Compassion', 'To the Most Holy Sovereign Lady, op. 43: No. 5. Beneath Thy Compassion', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 25001 AND p.composer_id = 389
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:9a19ac30-363f-485c-b483-6708ef88e548'
);


-- Op. 16 Veriu

UPDATE pieces piece
SET piece.title = 'Veriu', piece.title_en = 'Veriu, op. 16',
    piece.type = 'song', piece.opus_number = 'Op. 16',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 23494 AND piece.composer_id = 389
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None 가곡 <We Hymn Thee>

UPDATE pieces piece
SET piece.title = '가곡 <We Hymn Thee>', piece.title_en = 'We Hymn Thee',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 24116 AND piece.composer_id = 389
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- Op. 45 Во дни брани Op. 45

UPDATE pieces piece
SET piece.title = 'Во дни брани Op. 45', piece.title_en = 'Во дни брани, op. 45',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = 'Op.', piece.catalogue_number = '45',
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 23097 AND piece.composer_id = 389
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'На одре болезни', part.name_en = 'Во дни брани, op. 45: No. 1. На одре болезни',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 23097 AND p.composer_id = 389 AND part.part_key = 'musicbrainz:98b1000f-7bf8-46cf-a476-5a41f825af5b' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:98b1000f-7bf8-46cf-a476-5a41f825af5b', 1, NULL, 'На одре болезни', 'Во дни брани, op. 45: No. 1. На одре болезни', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 23097 AND p.composer_id = 389
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:98b1000f-7bf8-46cf-a476-5a41f825af5b'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'О, пресладкий и всещедрый Иисусе', part.name_en = 'Во дни брани, op. 45: No. 2. О, пресладкий и всещедрый Иисусе',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 23097 AND p.composer_id = 389 AND part.part_key = 'musicbrainz:17d57de7-90f8-4c8c-b326-a342041f4f10' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:17d57de7-90f8-4c8c-b326-a342041f4f10', 2, NULL, 'О, пресладкий и всещедрый Иисусе', 'Во дни брани, op. 45: No. 2. О, пресладкий и всещедрый Иисусе', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 23097 AND p.composer_id = 389
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:17d57de7-90f8-4c8c-b326-a342041f4f10'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = NULL,
    part.name_ko = 'Тебе, необоримую стену', part.name_en = 'Во дни брани, op. 45: No. 3. Тебе, необоримую стену',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 23097 AND p.composer_id = 389 AND part.part_key = 'musicbrainz:cdf3ff47-5f1c-487d-9687-2ea6c08073a9' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:cdf3ff47-5f1c-487d-9687-2ea6c08073a9', 3, NULL, 'Тебе, необоримую стену', 'Во дни брани, op. 45: No. 3. Тебе, необоримую стену', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 23097 AND p.composer_id = 389
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:cdf3ff47-5f1c-487d-9687-2ea6c08073a9'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = NULL,
    part.name_ko = 'Скоро предвари', part.name_en = 'Во дни брани, op. 45: No. 4. Скоро предвари',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 23097 AND p.composer_id = 389 AND part.part_key = 'musicbrainz:5c85f31b-d497-4a72-b1e6-349f6c2f0813' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:5c85f31b-d497-4a72-b1e6-349f6c2f0813', 4, NULL, 'Скоро предвари', 'Во дни брани, op. 45: No. 4. Скоро предвари', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 23097 AND p.composer_id = 389
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:5c85f31b-d497-4a72-b1e6-349f6c2f0813'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 5, part.movement_number = NULL,
    part.name_ko = 'Мати Божия', part.name_en = 'Во дни брани, op. 45: No. 5. Мати Божия',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 23097 AND p.composer_id = 389 AND part.part_key = 'musicbrainz:7c78bd6f-bbf6-4ee3-9b2c-87591de56fd6' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:7c78bd6f-bbf6-4ee3-9b2c-87591de56fd6', 5, NULL, 'Мати Божия', 'Во дни брани, op. 45: No. 5. Мати Божия', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 23097 AND p.composer_id = 389
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:7c78bd6f-bbf6-4ee3-9b2c-87591de56fd6'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 6, part.movement_number = NULL,
    part.name_ko = 'Тя едину', part.name_en = 'Во дни брани, op. 45: No. 6. Тя едину',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 23097 AND p.composer_id = 389 AND part.part_key = 'musicbrainz:956c9a96-9c0b-49d5-9244-ccfd99f5da56' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:956c9a96-9c0b-49d5-9244-ccfd99f5da56', 6, NULL, 'Тя едину', 'Во дни брани, op. 45: No. 6. Тя едину', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 23097 AND p.composer_id = 389
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:956c9a96-9c0b-49d5-9244-ccfd99f5da56'
);


-- None Воскресни, Боже, ор. 48 №2

UPDATE pieces piece
SET piece.title = 'Воскресни, Боже, ор. 48 №2', piece.title_en = 'Воскресни, Боже, ор. 48 №2',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 23089 AND piece.composer_id = 389
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- Op. 42 Литургия св. Иоанна Златоуста Op. 42

UPDATE pieces piece
SET piece.title = 'Литургия св. Иоанна Златоуста Op. 42', piece.title_en = 'Литургия св. Иоанна Златоуста, op. 42',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = 'Op.', piece.catalogue_number = '42',
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 23101 AND piece.composer_id = 389
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'Единородный Сыне. Малая ектения. Придите, поклонимся', part.name_en = 'Литургия св. Иоанна Златоуста, op. 42: 2. Единородный Сыне. Малая ектения. Придите, поклонимся',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 23101 AND p.composer_id = 389 AND part.part_key = 'musicbrainz:fb5da7f3-bc3a-4059-bc95-aaab0d5d857d' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:fb5da7f3-bc3a-4059-bc95-aaab0d5d857d', 1, NULL, 'Единородный Сыне. Малая ектения. Придите, поклонимся', 'Литургия св. Иоанна Златоуста, op. 42: 2. Единородный Сыне. Малая ектения. Придите, поклонимся', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 23101 AND p.composer_id = 389
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:fb5da7f3-bc3a-4059-bc95-aaab0d5d857d'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'Хвалите Господа с небес', part.name_en = 'Литургия св. Иоанна Златоуста, op. 42: 9. Хвалите Господа с небес',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 23101 AND p.composer_id = 389 AND part.part_key = 'musicbrainz:bbd7b814-ce95-4303-85e3-f4f5ec12ef37' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:bbd7b814-ce95-4303-85e3-f4f5ec12ef37', 2, NULL, 'Хвалите Господа с небес', 'Литургия св. Иоанна Златоуста, op. 42: 9. Хвалите Господа с небес', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 23101 AND p.composer_id = 389
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:bbd7b814-ce95-4303-85e3-f4f5ec12ef37'
);


-- None Отче Наш

UPDATE pieces piece
SET piece.title = 'Отче Наш', piece.title_en = 'Отче Наш',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 23928 AND piece.composer_id = 389
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- Op. 25 No. 10 Дух твой благий

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, 'Дух твой благий', 'Дух твой благий, op. 25 no. 10', 'song', 'Op. 25 No. 10', NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 389
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = 'Дух твой благий'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '6bb9e472-fbba-45d0-a6d8-8ab1ffdd6b65'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '6bb9e472-fbba-45d0-a6d8-8ab1ffdd6b65'
FROM pieces p
WHERE p.composer_id = 389 AND p.title = 'Дух твой благий' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '6bb9e472-fbba-45d0-a6d8-8ab1ffdd6b65'
);


-- Op. 25 No. 5 Спасение соделал

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, 'Спасение соделал', 'Спасение соделал, op. 25 no. 5', 'song', 'Op. 25 No. 5', NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 389
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = 'Спасение соделал'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '104404e3-5ed6-464d-ac16-aadfb4ad5b17'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '104404e3-5ed6-464d-ac16-aadfb4ad5b17'
FROM pieces p
WHERE p.composer_id = 389 AND p.title = 'Спасение соделал' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '104404e3-5ed6-464d-ac16-aadfb4ad5b17'
);


-- 카탈로그에 대응이 없는 seed 작품 1개를 목록에서 숨긴다(지우지 않음).
UPDATE pieces piece
SET piece.hidden_reason = 'catalog_unmatched'
WHERE piece.composer_id = 389 AND piece.origin = 'seed' AND piece.hidden_reason IS NULL
  AND piece.id IN (
    24228
  )
  AND NOT EXISTS (SELECT 1 FROM performance_sectors sector WHERE sector.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM piece_parts linking WHERE linking.linked_piece_id = piece.id);
