-- Michael Berkeley 작품을 MusicBrainz 작품 구조로 다시 짠다(5차 자동). 작품 33개(묶음 2, 다악장 5, 낱곡 26),
-- 새 작품 5개, part 39개, 그 아래 0개.
-- seed 28개 중 28개를 작품·part 에 잇고, 0개를 숨기고, 0개는 그대로 둔다.
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

-- None Abstract Mirror

UPDATE pieces piece
SET piece.title = 'Abstract Mirror', piece.title_en = 'Abstract Mirror',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 18159 AND piece.composer_id = 343
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Build this House

UPDATE pieces piece
SET piece.title = 'Build this House', piece.title_en = 'Build this House',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 16354 AND piece.composer_id = 343
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Catch Me If You Can

UPDATE pieces piece
SET piece.title = 'Catch Me If You Can', piece.title_en = 'Catch Me If You Can',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 16624 AND piece.composer_id = 343
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None 호른 협주곡

UPDATE pieces piece
SET piece.title = '호른 협주곡', piece.title_en = 'Concerto for Horn and String Orchestra',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 15898 AND piece.composer_id = 343
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'Free and dreamy, as though improvised - Malizioso. Allegro - Andante - Adagio, misterioso - Tempo I - Moderato - Andante - Tempo I', part.name_en = 'Concerto for Horn and String Orchestra: I. Free and dreamy, as though improvised - Malizioso. Allegro - Andante - Adagio, misterioso - Tempo I - Moderato - Andante - Tempo I',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 15898 AND p.composer_id = 343 AND part.part_key = 'musicbrainz:c7ae793c-496c-496f-8528-d65b6e02cc0c' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:c7ae793c-496c-496f-8528-d65b6e02cc0c', 1, 'I', 'Free and dreamy, as though improvised - Malizioso. Allegro - Andante - Adagio, misterioso - Tempo I - Moderato - Andante - Tempo I', 'Concerto for Horn and String Orchestra: I. Free and dreamy, as though improvised - Malizioso. Allegro - Andante - Adagio, misterioso - Tempo I - Moderato - Andante - Tempo I', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 15898 AND p.composer_id = 343
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:c7ae793c-496c-496f-8528-d65b6e02cc0c'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'Con malincolia, adagio - Slightly slower - Moderato - Allegro - Maestoso - Adagio, with lots of space', part.name_en = 'Concerto for Horn and String Orchestra: II. Con malincolia, adagio - Slightly slower - Moderato - Allegro - Maestoso - Adagio, with lots of space',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 15898 AND p.composer_id = 343 AND part.part_key = 'musicbrainz:a506b0c6-3edd-4e81-b4a6-35882f0f671f' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:a506b0c6-3edd-4e81-b4a6-35882f0f671f', 2, 'II', 'Con malincolia, adagio - Slightly slower - Moderato - Allegro - Maestoso - Adagio, with lots of space', 'Concerto for Horn and String Orchestra: II. Con malincolia, adagio - Slightly slower - Moderato - Allegro - Maestoso - Adagio, with lots of space', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 15898 AND p.composer_id = 343
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:a506b0c6-3edd-4e81-b4a6-35882f0f671f'
);


-- None 오르간 협주곡

UPDATE pieces piece
SET piece.title = '오르간 협주곡', piece.title_en = 'Concerto for Organ',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 18304 AND piece.composer_id = 343
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Coronach

UPDATE pieces piece
SET piece.title = 'Coronach', piece.title_en = 'Coronach',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 19443 AND piece.composer_id = 343
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None 오페라 <For You>

UPDATE pieces piece
SET piece.title = '오페라 <For You>', piece.title_en = 'For You',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 19888 AND piece.composer_id = 343
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'Scene 1: The Rehearsal Room', part.name_en = 'Act 1: Scene 1: The Rehearsal Room',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 19888 AND p.composer_id = 343 AND part.part_key = 'musicbrainz:fb432e33-c896-4132-8d40-6391fb5cabbe' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:fb432e33-c896-4132-8d40-6391fb5cabbe', 1, NULL, 'Scene 1: The Rehearsal Room', 'Act 1: Scene 1: The Rehearsal Room', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 19888 AND p.composer_id = 343
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:fb432e33-c896-4132-8d40-6391fb5cabbe'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'Scene 2: The Frieths'' London House', part.name_en = 'Act 1: Scene 2: The Frieths'' London House',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 19888 AND p.composer_id = 343 AND part.part_key = 'musicbrainz:dfb6e20a-94f4-46a4-94eb-49a6c72bef10' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:dfb6e20a-94f4-46a4-94eb-49a6c72bef10', 2, NULL, 'Scene 2: The Frieths'' London House', 'Act 1: Scene 2: The Frieths'' London House', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 19888 AND p.composer_id = 343
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:dfb6e20a-94f4-46a4-94eb-49a6c72bef10'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = NULL,
    part.name_ko = 'Scene 3: The Frieths'' London House', part.name_en = 'Act 1: Scene 3: The Frieths'' London House',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 19888 AND p.composer_id = 343 AND part.part_key = 'musicbrainz:19d19efa-b7f5-41e9-9642-2d56fa8b407c' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:19d19efa-b7f5-41e9-9642-2d56fa8b407c', 3, NULL, 'Scene 3: The Frieths'' London House', 'Act 1: Scene 3: The Frieths'' London House', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 19888 AND p.composer_id = 343
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:19d19efa-b7f5-41e9-9642-2d56fa8b407c'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = NULL,
    part.name_ko = 'Scene 4: The Frieths'' London House', part.name_en = 'Act 1: Scene 4: The Frieths'' London House',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 19888 AND p.composer_id = 343 AND part.part_key = 'musicbrainz:5ba94fce-f568-4fca-81c8-f75a0540bae4' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:5ba94fce-f568-4fca-81c8-f75a0540bae4', 4, NULL, 'Scene 4: The Frieths'' London House', 'Act 1: Scene 4: The Frieths'' London House', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 19888 AND p.composer_id = 343
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:5ba94fce-f568-4fca-81c8-f75a0540bae4'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 5, part.movement_number = NULL,
    part.name_ko = 'Scene 5: Charles''s Study', part.name_en = 'Act 1: Scene 5: Charles''s Study',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 19888 AND p.composer_id = 343 AND part.part_key = 'musicbrainz:696943be-d829-401b-b371-2b2131008bd0' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:696943be-d829-401b-b371-2b2131008bd0', 5, NULL, 'Scene 5: Charles''s Study', 'Act 1: Scene 5: Charles''s Study', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 19888 AND p.composer_id = 343
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:696943be-d829-401b-b371-2b2131008bd0'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 6, part.movement_number = NULL,
    part.name_ko = 'Scene 6: Charles''s Study', part.name_en = 'Act 1: Scene 6: Charles''s Study',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 19888 AND p.composer_id = 343 AND part.part_key = 'musicbrainz:948514bc-ec7d-4af8-a492-0ab0108c4b78' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:948514bc-ec7d-4af8-a492-0ab0108c4b78', 6, NULL, 'Scene 6: Charles''s Study', 'Act 1: Scene 6: Charles''s Study', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 19888 AND p.composer_id = 343
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:948514bc-ec7d-4af8-a492-0ab0108c4b78'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 7, part.movement_number = NULL,
    part.name_ko = 'Scene 1: The Hospital', part.name_en = 'Act 2: Scene 1: The Hospital',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 19888 AND p.composer_id = 343 AND part.part_key = 'musicbrainz:243d0fbf-c334-4ec5-b3f7-902e74a0225d' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:243d0fbf-c334-4ec5-b3f7-902e74a0225d', 7, NULL, 'Scene 1: The Hospital', 'Act 2: Scene 1: The Hospital', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 19888 AND p.composer_id = 343
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:243d0fbf-c334-4ec5-b3f7-902e74a0225d'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 8, part.movement_number = NULL,
    part.name_ko = 'Scene 2: Charles''s Study', part.name_en = 'Act 2: Scene 2: Charles''s Study',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 19888 AND p.composer_id = 343 AND part.part_key = 'musicbrainz:f3774b80-49f7-4d65-8f5d-7f7beff1b2d9' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:f3774b80-49f7-4d65-8f5d-7f7beff1b2d9', 8, NULL, 'Scene 2: Charles''s Study', 'Act 2: Scene 2: Charles''s Study', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 19888 AND p.composer_id = 343
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:f3774b80-49f7-4d65-8f5d-7f7beff1b2d9'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 9, part.movement_number = NULL,
    part.name_ko = 'Scene 3: The Hospital', part.name_en = 'Act 2: Scene 3: The Hospital',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 19888 AND p.composer_id = 343 AND part.part_key = 'musicbrainz:d4501fe9-7719-4505-aefc-8335eba9d87e' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:d4501fe9-7719-4505-aefc-8335eba9d87e', 9, NULL, 'Scene 3: The Hospital', 'Act 2: Scene 3: The Hospital', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 19888 AND p.composer_id = 343
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:d4501fe9-7719-4505-aefc-8335eba9d87e'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 10, part.movement_number = NULL,
    part.name_ko = 'Scene 4: The Rehearsal Room', part.name_en = 'Act 2: Scene 4: The Rehearsal Room',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 19888 AND p.composer_id = 343 AND part.part_key = 'musicbrainz:9cf23ae4-85b8-45b8-a561-21cc74ff179e' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:9cf23ae4-85b8-45b8-a561-21cc74ff179e', 10, NULL, 'Scene 4: The Rehearsal Room', 'Act 2: Scene 4: The Rehearsal Room', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 19888 AND p.composer_id = 343
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:9cf23ae4-85b8-45b8-a561-21cc74ff179e'
);


-- None Haiku 1 "Birds"

UPDATE pieces piece
SET piece.title = 'Haiku 1 "Birds"', piece.title_en = 'Haiku 1 "Birds"',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 19309 AND piece.composer_id = 343
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'Blackbird in birdbath', part.name_en = 'Haiku 1 "Birds": I. Blackbird in birdbath',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 19309 AND p.composer_id = 343 AND part.part_key = 'musicbrainz:ce7f1bf9-0cfc-4e1f-bd90-f854730988a8' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:ce7f1bf9-0cfc-4e1f-bd90-f854730988a8', 1, 'I', 'Blackbird in birdbath', 'Haiku 1 "Birds": I. Blackbird in birdbath', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 19309 AND p.composer_id = 343
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:ce7f1bf9-0cfc-4e1f-bd90-f854730988a8'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'Red Kite', part.name_en = 'Haiku 1 "Birds": II. Red Kite',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 19309 AND p.composer_id = 343 AND part.part_key = 'musicbrainz:b123de11-e38e-481b-9cbc-b720866b5902' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:b123de11-e38e-481b-9cbc-b720866b5902', 2, 'II', 'Red Kite', 'Haiku 1 "Birds": II. Red Kite', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 19309 AND p.composer_id = 343
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:b123de11-e38e-481b-9cbc-b720866b5902'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = 'Starlings', part.name_en = 'Haiku 1 "Birds": III. Starlings',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 19309 AND p.composer_id = 343 AND part.part_key = 'musicbrainz:a123018e-b8e0-4962-b0f3-0f7cba750123' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:a123018e-b8e0-4962-b0f3-0f7cba750123', 3, 'III', 'Starlings', 'Haiku 1 "Birds": III. Starlings', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 19309 AND p.composer_id = 343
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:a123018e-b8e0-4962-b0f3-0f7cba750123'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = 'IV',
    part.name_ko = 'French Partridge', part.name_en = 'Haiku 1 "Birds": IV. French Partridge',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 19309 AND p.composer_id = 343 AND part.part_key = 'musicbrainz:5aec7326-6b09-46cb-96b0-f53170a51b18' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:5aec7326-6b09-46cb-96b0-f53170a51b18', 4, 'IV', 'French Partridge', 'Haiku 1 "Birds": IV. French Partridge', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 19309 AND p.composer_id = 343
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:5aec7326-6b09-46cb-96b0-f53170a51b18'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 5, part.movement_number = 'V',
    part.name_ko = 'Goldfinches', part.name_en = 'Haiku 1 "Birds": V. Goldfinches',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 19309 AND p.composer_id = 343 AND part.part_key = 'musicbrainz:3a427bf7-2035-4b31-aa39-2fe3aa80d949' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:3a427bf7-2035-4b31-aa39-2fe3aa80d949', 5, 'V', 'Goldfinches', 'Haiku 1 "Birds": V. Goldfinches', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 19309 AND p.composer_id = 343
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:3a427bf7-2035-4b31-aa39-2fe3aa80d949'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 6, part.movement_number = 'VI',
    part.name_ko = 'Blue Tits', part.name_en = 'Haiku 1 "Birds": VI. Blue Tits',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 19309 AND p.composer_id = 343 AND part.part_key = 'musicbrainz:6dcd899e-529c-4652-81b1-a6761a917c28' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:6dcd899e-529c-4652-81b1-a6761a917c28', 6, 'VI', 'Blue Tits', 'Haiku 1 "Birds": VI. Blue Tits', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 19309 AND p.composer_id = 343
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:6dcd899e-529c-4652-81b1-a6761a917c28'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 7, part.movement_number = 'VII',
    part.name_ko = 'Crows, Rooks and Ravens', part.name_en = 'Haiku 1 "Birds": VII. Crows, Rooks and Ravens',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 19309 AND p.composer_id = 343 AND part.part_key = 'musicbrainz:123c639e-1c88-4575-8ddc-a975184cf013' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:123c639e-1c88-4575-8ddc-a975184cf013', 7, 'VII', 'Crows, Rooks and Ravens', 'Haiku 1 "Birds": VII. Crows, Rooks and Ravens', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 19309 AND p.composer_id = 343
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:123c639e-1c88-4575-8ddc-a975184cf013'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 8, part.movement_number = 'VIII',
    part.name_ko = 'Barn Owl', part.name_en = 'Haiku 1 "Birds": VIII. Barn Owl',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 19309 AND p.composer_id = 343 AND part.part_key = 'musicbrainz:adbf128d-3bbb-4bdb-97a3-04b902bfebdb' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:adbf128d-3bbb-4bdb-97a3-04b902bfebdb', 8, 'VIII', 'Barn Owl', 'Haiku 1 "Birds": VIII. Barn Owl', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 19309 AND p.composer_id = 343
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:adbf128d-3bbb-4bdb-97a3-04b902bfebdb'
);


-- None Haiku 2 "Insects"

UPDATE pieces piece
SET piece.title = 'Haiku 2 "Insects"', piece.title_en = 'Haiku 2 "Insects"',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 16142 AND piece.composer_id = 343
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'The Fly', part.name_en = 'Haiku 2 "Insects": I. The Fly',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 16142 AND p.composer_id = 343 AND part.part_key = 'musicbrainz:962953b6-985a-42a1-bdb9-c4e2c420f32c' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:962953b6-985a-42a1-bdb9-c4e2c420f32c', 1, 'I', 'The Fly', 'Haiku 2 "Insects": I. The Fly', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 16142 AND p.composer_id = 343
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:962953b6-985a-42a1-bdb9-c4e2c420f32c'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'The Moth', part.name_en = 'Haiku 2 "Insects": II. The Moth',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 16142 AND p.composer_id = 343 AND part.part_key = 'musicbrainz:a56f9483-be56-46c7-a993-94e43e933833' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:a56f9483-be56-46c7-a993-94e43e933833', 2, 'II', 'The Moth', 'Haiku 2 "Insects": II. The Moth', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 16142 AND p.composer_id = 343
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:a56f9483-be56-46c7-a993-94e43e933833'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = 'The Bee', part.name_en = 'Haiku 2 "Insects": III. The Bee',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 16142 AND p.composer_id = 343 AND part.part_key = 'musicbrainz:88901d70-7e98-4c6e-81c2-4a5cd9f36204' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:88901d70-7e98-4c6e-81c2-4a5cd9f36204', 3, 'III', 'The Bee', 'Haiku 2 "Insects": III. The Bee', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 16142 AND p.composer_id = 343
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:88901d70-7e98-4c6e-81c2-4a5cd9f36204'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = 'IV',
    part.name_ko = 'The Spider', part.name_en = 'Haiku 2 "Insects": IV. The Spider',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 16142 AND p.composer_id = 343 AND part.part_key = 'musicbrainz:e5f1caaa-fa45-4fbc-a727-595c473a2217' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:e5f1caaa-fa45-4fbc-a727-595c473a2217', 4, 'IV', 'The Spider', 'Haiku 2 "Insects": IV. The Spider', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 16142 AND p.composer_id = 343
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:e5f1caaa-fa45-4fbc-a727-595c473a2217'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 5, part.movement_number = 'V',
    part.name_ko = 'The Ladybird', part.name_en = 'Haiku 2 "Insects": V. The Ladybird',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 16142 AND p.composer_id = 343 AND part.part_key = 'musicbrainz:6a060635-bd33-4c89-b042-5e3692aad09b' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:6a060635-bd33-4c89-b042-5e3692aad09b', 5, 'V', 'The Ladybird', 'Haiku 2 "Insects": V. The Ladybird', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 16142 AND p.composer_id = 343
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:6a060635-bd33-4c89-b042-5e3692aad09b'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 6, part.movement_number = 'VI',
    part.name_ko = 'The Maybug', part.name_en = 'Haiku 2 "Insects": VI. The Maybug',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 16142 AND p.composer_id = 343 AND part.part_key = 'musicbrainz:7be701b3-72b2-4090-8684-f2a667cad760' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:7be701b3-72b2-4090-8684-f2a667cad760', 6, 'VI', 'The Maybug', 'Haiku 2 "Insects": VI. The Maybug', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 16142 AND p.composer_id = 343
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:7be701b3-72b2-4090-8684-f2a667cad760'
);


-- None 오페라 <Jane Eyre>

UPDATE pieces piece
SET piece.title = '오페라 <Jane Eyre>', piece.title_en = 'Jane Eyre',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 18048 AND piece.composer_id = 343
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'Act I', part.name_en = 'Jane Eyre: Act I',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 18048 AND p.composer_id = 343 AND part.part_key = 'musicbrainz:1d9e10ce-fd49-4560-ba2a-7f5f921bcc0d' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:1d9e10ce-fd49-4560-ba2a-7f5f921bcc0d', 1, NULL, 'Act I', 'Jane Eyre: Act I', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 18048 AND p.composer_id = 343
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:1d9e10ce-fd49-4560-ba2a-7f5f921bcc0d'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'Act II', part.name_en = 'Jane Eyre: Act II',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 18048 AND p.composer_id = 343 AND part.part_key = 'musicbrainz:68838860-a1ba-42e7-84ea-2f14dd52f181' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:68838860-a1ba-42e7-84ea-2f14dd52f181', 2, NULL, 'Act II', 'Jane Eyre: Act II', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 18048 AND p.composer_id = 343
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:68838860-a1ba-42e7-84ea-2f14dd52f181'
);


-- None Keening

UPDATE pieces piece
SET piece.title = 'Keening', piece.title_en = 'Keening',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 15897 AND piece.composer_id = 343
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Listen, Listen, O My Child

UPDATE pieces piece
SET piece.title = 'Listen, Listen, O My Child', piece.title_en = 'Listen, Listen, O My Child',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 17913 AND piece.composer_id = 343
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Magnetic Field

UPDATE pieces piece
SET piece.title = 'Magnetic Field', piece.title_en = 'Magnetic Field',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 18652 AND piece.composer_id = 343
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Music From Chaucer

UPDATE pieces piece
SET piece.title = 'Music From Chaucer', piece.title_en = 'Music From Chaucer',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 16934 AND piece.composer_id = 343
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'Triton’s Trumpets', part.name_en = 'Music From Chaucer: Triton’s Trumpets',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 16934 AND p.composer_id = 343 AND part.part_key = 'musicbrainz:932aefd2-7126-4b50-beb5-72f70b5d0b8b' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:932aefd2-7126-4b50-beb5-72f70b5d0b8b', 1, NULL, 'Triton’s Trumpets', 'Music From Chaucer: Triton’s Trumpets', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 16934 AND p.composer_id = 343
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:932aefd2-7126-4b50-beb5-72f70b5d0b8b'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'The Grieving Queen', part.name_en = 'Music From Chaucer: The Grieving Queen',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 16934 AND p.composer_id = 343 AND part.part_key = 'musicbrainz:e0e24f75-a8cd-45aa-a3ca-83c384022c4f' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:e0e24f75-a8cd-45aa-a3ca-83c384022c4f', 2, NULL, 'The Grieving Queen', 'Music From Chaucer: The Grieving Queen', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 16934 AND p.composer_id = 343
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:e0e24f75-a8cd-45aa-a3ca-83c384022c4f'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = NULL,
    part.name_ko = 'A Fanfare for the Huntsmen', part.name_en = 'Music From Chaucer: A Fanfare for the Huntsmen',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 16934 AND p.composer_id = 343 AND part.part_key = 'musicbrainz:727e7b42-962a-4a8b-ad76-8146e13f5018' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:727e7b42-962a-4a8b-ad76-8146e13f5018', 3, NULL, 'A Fanfare for the Huntsmen', 'Music From Chaucer: A Fanfare for the Huntsmen', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 16934 AND p.composer_id = 343
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:727e7b42-962a-4a8b-ad76-8146e13f5018'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = NULL,
    part.name_ko = 'The Sorrowful Knight', part.name_en = 'Music From Chaucer: The Sorrowful Knight',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 16934 AND p.composer_id = 343 AND part.part_key = 'musicbrainz:cfbdfd67-0e41-437d-90ac-59f56d155474' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:cfbdfd67-0e41-437d-90ac-59f56d155474', 4, NULL, 'The Sorrowful Knight', 'Music From Chaucer: The Sorrowful Knight', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 16934 AND p.composer_id = 343
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:cfbdfd67-0e41-437d-90ac-59f56d155474'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 5, part.movement_number = NULL,
    part.name_ko = 'The Wakeful Poet', part.name_en = 'Music From Chaucer: The Wakeful Poet',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 16934 AND p.composer_id = 343 AND part.part_key = 'musicbrainz:02adea3f-ac0a-4f18-a06f-751d6e8baea9' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:02adea3f-ac0a-4f18-a06f-751d6e8baea9', 5, NULL, 'The Wakeful Poet', 'Music From Chaucer: The Wakeful Poet', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 16934 AND p.composer_id = 343
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:02adea3f-ac0a-4f18-a06f-751d6e8baea9'
);


-- None Notes on the Loss of a Friend

UPDATE pieces piece
SET piece.title = 'Notes on the Loss of a Friend', piece.title_en = 'Notes on the Loss of a Friend',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 16434 AND piece.composer_id = 343
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Released by Love

UPDATE pieces piece
SET piece.title = 'Released by Love', piece.title_en = 'Released by Love',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 17399 AND piece.composer_id = 343
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Secret Garden

UPDATE pieces piece
SET piece.title = 'Secret Garden', piece.title_en = 'Secret Garden',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 18824 AND piece.composer_id = 343
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None 연가곡집 <Songs of Awakening Love>

UPDATE pieces piece
SET piece.title = '연가곡집 <Songs of Awakening Love>', piece.title_en = 'Songs of Awakening Love',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 18465 AND piece.composer_id = 343
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None 연가곡집 <Speaking Silence>

UPDATE pieces piece
SET piece.title = '연가곡집 <Speaking Silence>', piece.title_en = 'Speaking Silence',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 18737 AND piece.composer_id = 343
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'Blow, Northern Wynd', part.name_en = 'Speaking Silence: I. Blow, Northern Wynd',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 18737 AND p.composer_id = 343 AND part.part_key = 'musicbrainz:b66bee24-8225-4081-ab02-0f4b34c807d3' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:b66bee24-8225-4081-ab02-0f4b34c807d3', 1, 'I', 'Blow, Northern Wynd', 'Speaking Silence: I. Blow, Northern Wynd', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 18737 AND p.composer_id = 343
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:b66bee24-8225-4081-ab02-0f4b34c807d3'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'Echo', part.name_en = 'Speaking Silence: II. Echo',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 18737 AND p.composer_id = 343 AND part.part_key = 'musicbrainz:50fcc937-6e5a-48fc-b4d8-a4c64b5d54c3' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:50fcc937-6e5a-48fc-b4d8-a4c64b5d54c3', 2, 'II', 'Echo', 'Speaking Silence: II. Echo', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 18737 AND p.composer_id = 343
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:50fcc937-6e5a-48fc-b4d8-a4c64b5d54c3'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = 'And is it Night?', part.name_en = 'Speaking Silence: III. And is it Night?',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 18737 AND p.composer_id = 343 AND part.part_key = 'musicbrainz:c71bceab-1332-406c-ba39-ecb50f539bde' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:c71bceab-1332-406c-ba39-ecb50f539bde', 3, 'III', 'And is it Night?', 'Speaking Silence: III. And is it Night?', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 18737 AND p.composer_id = 343
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:c71bceab-1332-406c-ba39-ecb50f539bde'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = 'IV',
    part.name_ko = 'The Ragged Wood', part.name_en = 'Speaking Silence: IV. The Ragged Wood',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 18737 AND p.composer_id = 343 AND part.part_key = 'musicbrainz:a64b9fd3-20a2-4378-aa85-d23605b77a4f' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:a64b9fd3-20a2-4378-aa85-d23605b77a4f', 4, 'IV', 'The Ragged Wood', 'Speaking Silence: IV. The Ragged Wood', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 18737 AND p.composer_id = 343
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:a64b9fd3-20a2-4378-aa85-d23605b77a4f'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 5, part.movement_number = 'V',
    part.name_ko = 'Père du Doux Repos', part.name_en = 'Speaking Silence: V. Père du Doux Repos',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 18737 AND p.composer_id = 343 AND part.part_key = 'musicbrainz:709ec37f-35a4-4a36-a29f-b5c296d9c3cf' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:709ec37f-35a4-4a36-a29f-b5c296d9c3cf', 5, 'V', 'Père du Doux Repos', 'Speaking Silence: V. Père du Doux Repos', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 18737 AND p.composer_id = 343
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:709ec37f-35a4-4a36-a29f-b5c296d9c3cf'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 6, part.movement_number = 'VI',
    part.name_ko = 'Blow, Northern Wynd', part.name_en = 'Speaking Silence: VI. Blow, Northern Wynd',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 18737 AND p.composer_id = 343 AND part.part_key = 'musicbrainz:188a66ce-9a88-4a72-b21f-e70ae4b5dfc7' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:188a66ce-9a88-4a72-b21f-e70ae4b5dfc7', 6, 'VI', 'Blow, Northern Wynd', 'Speaking Silence: VI. Blow, Northern Wynd', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 18737 AND p.composer_id = 343
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:188a66ce-9a88-4a72-b21f-e70ae4b5dfc7'
);


-- None Super Flumina Babylonis

UPDATE pieces piece
SET piece.title = 'Super Flumina Babylonis', piece.title_en = 'Super Flumina Babylonis',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 18925 AND piece.composer_id = 343
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None The Garden of Earthly Delights

UPDATE pieces piece
SET piece.title = 'The Garden of Earthly Delights', piece.title_en = 'The Garden of Earthly Delights',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 18891 AND piece.composer_id = 343
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None The Magnolia Tree

UPDATE pieces piece
SET piece.title = 'The Magnolia Tree', piece.title_en = 'The Magnolia Tree',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 19392 AND piece.composer_id = 343
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None The Tale of Andrew

UPDATE pieces piece
SET piece.title = 'The Tale of Andrew', piece.title_en = 'The Tale of Andrew',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 16733 AND piece.composer_id = 343
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None This Endernight

UPDATE pieces piece
SET piece.title = 'This Endernight', piece.title_en = 'This Endernight',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 17468 AND piece.composer_id = 343
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Touch Light

UPDATE pieces piece
SET piece.title = 'Touch Light', piece.title_en = 'Touch Light',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 19982 AND piece.composer_id = 343
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Veilleuse

UPDATE pieces piece
SET piece.title = 'Veilleuse', piece.title_en = 'Veilleuse',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 18223 AND piece.composer_id = 343
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Wild Bells

UPDATE pieces piece
SET piece.title = 'Wild Bells', piece.title_en = 'Wild Bells',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 18331 AND piece.composer_id = 343
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None 가곡 <Zero Hour>

UPDATE pieces piece
SET piece.title = '가곡 <Zero Hour>', piece.title_en = 'Zero Hour',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 18134 AND piece.composer_id = 343
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None 관현악 협주곡

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '관현악 협주곡', 'Concerto for Orchestra', 'song', NULL, NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 343
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '관현악 협주곡'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '76003b54-ee67-4102-99da-838e463ce459'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '76003b54-ee67-4102-99da-838e463ce459'
FROM pieces p
WHERE p.composer_id = 343 AND p.title = '관현악 협주곡' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '76003b54-ee67-4102-99da-838e463ce459'
);


-- None Cradle Song

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, 'Cradle Song', 'Cradle Song', 'song', NULL, NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 343
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = 'Cradle Song'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '7676c3de-53db-4bc3-8091-dfbde09aca01'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '7676c3de-53db-4bc3-8091-dfbde09aca01'
FROM pieces p
WHERE p.composer_id = 343 AND p.title = 'Cradle Song' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '7676c3de-53db-4bc3-8091-dfbde09aca01'
);


-- None Farewell

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, 'Farewell', 'Farewell', 'song', NULL, NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 343
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = 'Farewell'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '05cd9b23-bbae-451b-8507-3ca8d2780dd7'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '05cd9b23-bbae-451b-8507-3ca8d2780dd7'
FROM pieces p
WHERE p.composer_id = 343 AND p.title = 'Farewell' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '05cd9b23-bbae-451b-8507-3ca8d2780dd7'
);


-- None Slow Dawn

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, 'Slow Dawn', 'Slow Dawn', 'song', NULL, NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 343
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = 'Slow Dawn'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '5fd5e42e-9827-4117-8f91-9abfa0ae429f'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '5fd5e42e-9827-4117-8f91-9abfa0ae429f'
FROM pieces p
WHERE p.composer_id = 343 AND p.title = 'Slow Dawn' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '5fd5e42e-9827-4117-8f91-9abfa0ae429f'
);


-- None 바이올린 협주곡

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '바이올린 협주곡', 'Violin Concerto', 'song', NULL, NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 343
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '바이올린 협주곡'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '31238e8c-da73-4f87-a71f-569b9ae3566f'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '31238e8c-da73-4f87-a71f-569b9ae3566f'
FROM pieces p
WHERE p.composer_id = 343 AND p.title = '바이올린 협주곡' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '31238e8c-da73-4f87-a71f-569b9ae3566f'
);


-- 숨길 seed 작품 없음
