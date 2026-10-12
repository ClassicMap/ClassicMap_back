-- 본 윌리엄스 작품을 MusicBrainz 작품 구조로 다시 짠다(4차 자동). 작품 213개(묶음 39, 다악장 48, 낱곡 126),
-- 새 작품 27개, part 501개, 그 아래 77개.
-- seed 233개 중 185개를 작품·part 에 잇고, 42개를 숨기고, 6개는 그대로 둔다.
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

-- None 2 Organ Preludes

UPDATE pieces piece
SET piece.title = '2 Organ Preludes', piece.title_en = '2 Organ Preludes',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 7490 AND piece.composer_id = 69
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'Romanza, The White Rock. Andante sostenuto', part.name_en = '2 Organ Preludes: No. 1. Romanza, The White Rock. Andante sostenuto',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 7490 AND p.composer_id = 69 AND part.part_key = 'musicbrainz:959ea99f-3e52-4a1d-b321-aca0041aba67' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:959ea99f-3e52-4a1d-b321-aca0041aba67', 1, NULL, 'Romanza, The White Rock. Andante sostenuto', '2 Organ Preludes: No. 1. Romanza, The White Rock. Andante sostenuto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 7490 AND p.composer_id = 69
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:959ea99f-3e52-4a1d-b321-aca0041aba67'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'Toccata, St. David''s Day. Allegro', part.name_en = '2 Organ Preludes: No. 2. Toccata, St. David''s Day. Allegro',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 7490 AND p.composer_id = 69 AND part.part_key = 'musicbrainz:73988542-465a-4974-8688-2db5fa47defe' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:73988542-465a-4974-8688-2db5fa47defe', 2, NULL, 'Toccata, St. David''s Day. Allegro', '2 Organ Preludes: No. 2. Toccata, St. David''s Day. Allegro', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 7490 AND p.composer_id = 69
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:73988542-465a-4974-8688-2db5fa47defe'
);


-- None 2 Poems by Seumas O'Sullivan

UPDATE pieces piece
SET piece.title = '2 Poems by Seumas O''Sullivan', piece.title_en = '2 Poems by Seumas O''Sullivan',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 8135 AND piece.composer_id = 69
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'The Twilight People', part.name_en = '2 Poems by Seumas O''Sullivan: No. 1. The Twilight People',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 8135 AND p.composer_id = 69 AND part.part_key = 'musicbrainz:1cc4ccb8-2bf4-4167-aec7-986ba3244867' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:1cc4ccb8-2bf4-4167-aec7-986ba3244867', 1, NULL, 'The Twilight People', '2 Poems by Seumas O''Sullivan: No. 1. The Twilight People', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 8135 AND p.composer_id = 69
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:1cc4ccb8-2bf4-4167-aec7-986ba3244867'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'A Piper', part.name_en = '2 Poems by Seumas O''Sullivan: No. 2. A Piper',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 8135 AND p.composer_id = 69 AND part.part_key = 'musicbrainz:f7f2ba0f-84fd-4d7e-bfe4-f53a19097303' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:f7f2ba0f-84fd-4d7e-bfe4-f53a19097303', 2, NULL, 'A Piper', '2 Poems by Seumas O''Sullivan: No. 2. A Piper', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 8135 AND p.composer_id = 69
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:f7f2ba0f-84fd-4d7e-bfe4-f53a19097303'
);


-- None 3개의 녹턴

UPDATE pieces piece
SET piece.title = '3개의 녹턴', piece.title_en = '3 Nocturnes',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 11234 AND piece.composer_id = 69
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'By the Bivouac''s Fitful Flame', part.name_en = '3 Nocturnes: No. 2, By the Bivouac''s Fitful Flame',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11234 AND p.composer_id = 69 AND part.part_key = 'musicbrainz:1a3b696e-1385-43dc-8f3b-48ead2cc8d47' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:1a3b696e-1385-43dc-8f3b-48ead2cc8d47', 1, NULL, 'By the Bivouac''s Fitful Flame', '3 Nocturnes: No. 2, By the Bivouac''s Fitful Flame', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 11234 AND p.composer_id = 69
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:1a3b696e-1385-43dc-8f3b-48ead2cc8d47'
);


-- None 3 Poems by Walt Whitman

UPDATE pieces piece
SET piece.title = '3 Poems by Walt Whitman', piece.title_en = '3 Poems by Walt Whitman',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 7812 AND piece.composer_id = 69
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'Nocturne', part.name_en = '3 Poems by Walt Whitman: No. 1. Nocturne',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 7812 AND p.composer_id = 69 AND part.part_key = 'musicbrainz:91cb7896-d91a-461b-9729-7840944222f9' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:91cb7896-d91a-461b-9729-7840944222f9', 1, NULL, 'Nocturne', '3 Poems by Walt Whitman: No. 1. Nocturne', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 7812 AND p.composer_id = 69
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:91cb7896-d91a-461b-9729-7840944222f9'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'A clear midnight', part.name_en = '3 Poems by Walt Whitman: No. 2. A clear midnight',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 7812 AND p.composer_id = 69 AND part.part_key = 'musicbrainz:e5469ec8-548b-43dc-a052-8fbf5d8c4745' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:e5469ec8-548b-43dc-a052-8fbf5d8c4745', 2, NULL, 'A clear midnight', '3 Poems by Walt Whitman: No. 2. A clear midnight', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 7812 AND p.composer_id = 69
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:e5469ec8-548b-43dc-a052-8fbf5d8c4745'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = NULL,
    part.name_ko = 'Joy, shipmate, joy!', part.name_en = '3 Poems by Walt Whitman: No. 3. Joy, shipmate, joy!',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 7812 AND p.composer_id = 69 AND part.part_key = 'musicbrainz:a1990d3a-f78b-4948-ab3b-bfc322d7c8a0' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:a1990d3a-f78b-4948-ab3b-bfc322d7c8a0', 3, NULL, 'Joy, shipmate, joy!', '3 Poems by Walt Whitman: No. 3. Joy, shipmate, joy!', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 7812 AND p.composer_id = 69
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:a1990d3a-f78b-4948-ab3b-bfc322d7c8a0'
);


-- None 3 Songs from Shakespeare

UPDATE pieces piece
SET piece.title = '3 Songs from Shakespeare', piece.title_en = '3 Songs from Shakespeare',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 8256 AND piece.composer_id = 69
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'Take, O take', part.name_en = '3 Songs from Shakespeare: No. 1. Take, O take',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 8256 AND p.composer_id = 69 AND part.part_key = 'musicbrainz:6efc48ed-e813-48c9-84ac-d1cf0d9b4cbd' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:6efc48ed-e813-48c9-84ac-d1cf0d9b4cbd', 1, NULL, 'Take, O take', '3 Songs from Shakespeare: No. 1. Take, O take', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 8256 AND p.composer_id = 69
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:6efc48ed-e813-48c9-84ac-d1cf0d9b4cbd'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'When Icicles Hang by the Wall', part.name_en = '3 Songs from Shakespeare: No. 2. When Icicles Hang by the Wall',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 8256 AND p.composer_id = 69 AND part.part_key = 'musicbrainz:682fdeb9-4ae5-44ef-95c2-20f30de3e680' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:682fdeb9-4ae5-44ef-95c2-20f30de3e680', 2, NULL, 'When Icicles Hang by the Wall', '3 Songs from Shakespeare: No. 2. When Icicles Hang by the Wall', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 8256 AND p.composer_id = 69
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:682fdeb9-4ae5-44ef-95c2-20f30de3e680'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = NULL,
    part.name_ko = 'Orpheus With His Lute', part.name_en = '3 Songs from Shakespeare: No. 3. Orpheus With His Lute',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 8256 AND p.composer_id = 69 AND part.part_key = 'musicbrainz:5054ca20-9a58-4e4a-8623-0a16c171e4b4' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:5054ca20-9a58-4e4a-8623-0a16c171e4b4', 3, NULL, 'Orpheus With His Lute', '3 Songs from Shakespeare: No. 3. Orpheus With His Lute', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 8256 AND p.composer_id = 69
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:5054ca20-9a58-4e4a-8623-0a16c171e4b4'
);


-- None 4 Poems by Fredegond Shove

UPDATE pieces piece
SET piece.title = '4 Poems by Fredegond Shove', piece.title_en = '4 Poems by Fredegond Shove',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 7577 AND piece.composer_id = 69
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'Motion and Stillness', part.name_en = '4 Poems by Fredegond Shove: No. 1. Motion and Stillness',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 7577 AND p.composer_id = 69 AND part.part_key = 'musicbrainz:d4f0faf9-3775-4fd5-8f31-c19f2edcee83' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:d4f0faf9-3775-4fd5-8f31-c19f2edcee83', 1, NULL, 'Motion and Stillness', '4 Poems by Fredegond Shove: No. 1. Motion and Stillness', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 7577 AND p.composer_id = 69
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:d4f0faf9-3775-4fd5-8f31-c19f2edcee83'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'Four Nights', part.name_en = '4 Poems by Fredegond Shove: No. 2. Four Nights',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 7577 AND p.composer_id = 69 AND part.part_key = 'musicbrainz:0a592117-d110-4175-8671-6e44fd43ed18' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:0a592117-d110-4175-8671-6e44fd43ed18', 2, NULL, 'Four Nights', '4 Poems by Fredegond Shove: No. 2. Four Nights', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 7577 AND p.composer_id = 69
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:0a592117-d110-4175-8671-6e44fd43ed18'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = NULL,
    part.name_ko = 'The New Ghost', part.name_en = '4 Poems by Fredegond Shove: No. 3. The New Ghost',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 7577 AND p.composer_id = 69 AND part.part_key = 'musicbrainz:34d92112-da21-4b57-91fe-c87ffa02722c' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:34d92112-da21-4b57-91fe-c87ffa02722c', 3, NULL, 'The New Ghost', '4 Poems by Fredegond Shove: No. 3. The New Ghost', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 7577 AND p.composer_id = 69
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:34d92112-da21-4b57-91fe-c87ffa02722c'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = NULL,
    part.name_ko = 'The Water Mill', part.name_en = '4 Poems by Fredegond Shove: No. 4. The Water Mill',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 7577 AND p.composer_id = 69 AND part.part_key = 'musicbrainz:b5963baa-bc21-4685-9acf-2c0c6df67f1b' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:b5963baa-bc21-4685-9acf-2c0c6df67f1b', 4, NULL, 'The Water Mill', '4 Poems by Fredegond Shove: No. 4. The Water Mill', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 7577 AND p.composer_id = 69
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:b5963baa-bc21-4685-9acf-2c0c6df67f1b'
);


-- None 6 Choral Songs to Be Sung in Time of War

UPDATE pieces piece
SET piece.title = '6 Choral Songs to Be Sung in Time of War', piece.title_en = '6 Choral Songs to Be Sung in Time of War',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 7724 AND piece.composer_id = 69
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'A Song of Courage', part.name_en = 'Choral Song to be Sung in Time of War No. 1: A Song of Courage',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 7724 AND p.composer_id = 69 AND part.part_key = 'musicbrainz:8bb984bb-59f2-3177-9066-71908d12bb2e' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:8bb984bb-59f2-3177-9066-71908d12bb2e', 1, NULL, 'A Song of Courage', 'Choral Song to be Sung in Time of War No. 1: A Song of Courage', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 7724 AND p.composer_id = 69
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:8bb984bb-59f2-3177-9066-71908d12bb2e'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'A Song of Liberty', part.name_en = 'Choral Song to be Sung in Time of War No. 2: A Song of Liberty',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 7724 AND p.composer_id = 69 AND part.part_key = 'musicbrainz:46bacc23-b2b6-3e44-83af-6c320e432662' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:46bacc23-b2b6-3e44-83af-6c320e432662', 2, NULL, 'A Song of Liberty', 'Choral Song to be Sung in Time of War No. 2: A Song of Liberty', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 7724 AND p.composer_id = 69
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:46bacc23-b2b6-3e44-83af-6c320e432662'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = NULL,
    part.name_ko = 'A Song of Healing', part.name_en = 'Choral Song to be Sung in Time of War No. 3: A Song of Healing',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 7724 AND p.composer_id = 69 AND part.part_key = 'musicbrainz:81b1ea58-7a59-3069-866d-a7a013e24c00' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:81b1ea58-7a59-3069-866d-a7a013e24c00', 3, NULL, 'A Song of Healing', 'Choral Song to be Sung in Time of War No. 3: A Song of Healing', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 7724 AND p.composer_id = 69
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:81b1ea58-7a59-3069-866d-a7a013e24c00'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = NULL,
    part.name_ko = 'A Song of Victory', part.name_en = 'Choral Song to be Sung in Time of War No. 4: A Song of Victory',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 7724 AND p.composer_id = 69 AND part.part_key = 'musicbrainz:3f6c9317-595b-38cc-8630-5b5519e86c4e' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:3f6c9317-595b-38cc-8630-5b5519e86c4e', 4, NULL, 'A Song of Victory', 'Choral Song to be Sung in Time of War No. 4: A Song of Victory', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 7724 AND p.composer_id = 69
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:3f6c9317-595b-38cc-8630-5b5519e86c4e'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 5, part.movement_number = NULL,
    part.name_ko = 'A Song of Pity, Peace and Love', part.name_en = 'Choral Song to be Sung in Time of War No. 5: A Song of Pity, Peace and Love',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 7724 AND p.composer_id = 69 AND part.part_key = 'musicbrainz:73f186d5-1056-3e02-a9ef-31199318b024' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:73f186d5-1056-3e02-a9ef-31199318b024', 5, NULL, 'A Song of Pity, Peace and Love', 'Choral Song to be Sung in Time of War No. 5: A Song of Pity, Peace and Love', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 7724 AND p.composer_id = 69
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:73f186d5-1056-3e02-a9ef-31199318b024'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 6, part.movement_number = NULL,
    part.name_ko = 'A Song of the New Age', part.name_en = 'Choral Song to be Sung in Time of War No. 6: A Song of the New Age',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 7724 AND p.composer_id = 69 AND part.part_key = 'musicbrainz:d7cdf4d7-ed3c-3633-9dfb-427e6e1eb144' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:d7cdf4d7-ed3c-3633-9dfb-427e6e1eb144', 6, NULL, 'A Song of the New Age', 'Choral Song to be Sung in Time of War No. 6: A Song of the New Age', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 7724 AND p.composer_id = 69
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:d7cdf4d7-ed3c-3633-9dfb-427e6e1eb144'
);


-- None 가곡 <A Call to the Free Nations>

UPDATE pieces piece
SET piece.title = '가곡 <A Call to the Free Nations>', piece.title_en = 'A Call to the Free Nations',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 11018 AND piece.composer_id = 69
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None A Cambridge Mass

UPDATE pieces piece
SET piece.title = 'A Cambridge Mass', piece.title_en = 'A Cambridge Mass',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 8217 AND piece.composer_id = 69
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None A Cambridge Mass: Credo

UPDATE pieces piece
SET piece.title = 'A Cambridge Mass: Credo', piece.title_en = 'A Cambridge Mass: Credo',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 8641 AND piece.composer_id = 69
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None A Cambridge Mass: Finale

UPDATE pieces piece
SET piece.title = 'A Cambridge Mass: Finale', piece.title_en = 'A Cambridge Mass: Finale',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 10483 AND piece.composer_id = 69
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None A Cambridge Mass: Offertorium

UPDATE pieces piece
SET piece.title = 'A Cambridge Mass: Offertorium', piece.title_en = 'A Cambridge Mass: Offertorium',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 10066 AND piece.composer_id = 69
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None 가곡 <A Choral Flourish>

UPDATE pieces piece
SET piece.title = '가곡 <A Choral Flourish>', piece.title_en = 'A Choral Flourish',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 7698 AND piece.composer_id = 69
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None A Cradle Song

UPDATE pieces piece
SET piece.title = 'A Cradle Song', piece.title_en = 'A Cradle Song',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 8265 AND piece.composer_id = 69
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None A Farmer’s Son So Sweet

UPDATE pieces piece
SET piece.title = 'A Farmer’s Son So Sweet', piece.title_en = 'A Farmer’s Son So Sweet',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 7664 AND piece.composer_id = 69
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None 가곡 <A Hymn of Freedom>

UPDATE pieces piece
SET piece.title = '가곡 <A Hymn of Freedom>', piece.title_en = 'A Hymn of Freedom',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 8565 AND piece.composer_id = 69
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None A Little Piano Book

UPDATE pieces piece
SET piece.title = 'A Little Piano Book', piece.title_en = 'A Little Piano Book',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 10745 AND piece.composer_id = 69
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'Canon', part.name_en = 'A Little Piano Book: Canon',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 10745 AND p.composer_id = 69 AND part.part_key = 'musicbrainz:36a6f67d-8891-4e85-8323-770d27cb161f' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:36a6f67d-8891-4e85-8323-770d27cb161f', 1, NULL, 'Canon', 'A Little Piano Book: Canon', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 10745 AND p.composer_id = 69
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:36a6f67d-8891-4e85-8323-770d27cb161f'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'Two-Part Invention in E-Flat', part.name_en = 'A Little Piano Book: Two-Part Invention in E-Flat',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 10745 AND p.composer_id = 69 AND part.part_key = 'musicbrainz:49052c06-2cd1-464e-b382-770c55c4944b' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:49052c06-2cd1-464e-b382-770c55c4944b', 2, NULL, 'Two-Part Invention in E-Flat', 'A Little Piano Book: Two-Part Invention in E-Flat', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 10745 AND p.composer_id = 69
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:49052c06-2cd1-464e-b382-770c55c4944b'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = NULL,
    part.name_ko = 'Two-Part Invention in F', part.name_en = 'A Little Piano Book: Two-Part Invention in F',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 10745 AND p.composer_id = 69 AND part.part_key = 'musicbrainz:6b6cb964-a98a-446a-a079-b77f34069935' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:6b6cb964-a98a-446a-a079-b77f34069935', 3, NULL, 'Two-Part Invention in F', 'A Little Piano Book: Two-Part Invention in F', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 10745 AND p.composer_id = 69
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:6b6cb964-a98a-446a-a079-b77f34069935'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = NULL,
    part.name_ko = 'Valse Lente', part.name_en = 'A Little Piano Book: Valse Lente',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 10745 AND p.composer_id = 69 AND part.part_key = 'musicbrainz:c828397b-742c-4568-8dee-f832145bdc5e' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:c828397b-742c-4568-8dee-f832145bdc5e', 4, NULL, 'Valse Lente', 'A Little Piano Book: Valse Lente', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 10745 AND p.composer_id = 69
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:c828397b-742c-4568-8dee-f832145bdc5e'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 5, part.movement_number = NULL,
    part.name_ko = 'Nocturne', part.name_en = 'A Little Piano Book: Nocturne',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 10745 AND p.composer_id = 69 AND part.part_key = 'musicbrainz:d1fc98e8-7233-499b-a2c1-5204d7c9e846' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:d1fc98e8-7233-499b-a2c1-5204d7c9e846', 5, NULL, 'Nocturne', 'A Little Piano Book: Nocturne', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 10745 AND p.composer_id = 69
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:d1fc98e8-7233-499b-a2c1-5204d7c9e846'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 6, part.movement_number = NULL,
    part.name_ko = 'Two-Part Invention in G', part.name_en = 'A Little Piano Book: Two-Part Invention in G',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 10745 AND p.composer_id = 69 AND part.part_key = 'musicbrainz:f6848181-f298-42a1-900a-37019490f609' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:f6848181-f298-42a1-900a-37019490f609', 6, NULL, 'Two-Part Invention in G', 'A Little Piano Book: Two-Part Invention in G', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 10745 AND p.composer_id = 69
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:f6848181-f298-42a1-900a-37019490f609'
);


-- None A London Symphony in G major (Symphony no. 2)

UPDATE pieces piece
SET piece.title = 'A London Symphony in G major (Symphony no. 2)', piece.title_en = 'A London Symphony in G major (Symphony no. 2)',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 7942 AND piece.composer_id = 69
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'Lento – Allegro risoluto', part.name_en = 'A London Symphony in G major (Symphony no. 2): I. Lento – Allegro risoluto',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 7942 AND p.composer_id = 69 AND part.part_key = 'musicbrainz:a61daad0-b99f-416c-b764-88fcf8afd264' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:a61daad0-b99f-416c-b764-88fcf8afd264', 1, 'I', 'Lento – Allegro risoluto', 'A London Symphony in G major (Symphony no. 2): I. Lento – Allegro risoluto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 7942 AND p.composer_id = 69
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:a61daad0-b99f-416c-b764-88fcf8afd264'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'Lento', part.name_en = 'A London Symphony in G major (Symphony no. 2): II. Lento',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 7942 AND p.composer_id = 69 AND part.part_key = 'musicbrainz:b3afb2fa-e957-4671-afca-cc13fa2f0e03' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:b3afb2fa-e957-4671-afca-cc13fa2f0e03', 2, 'II', 'Lento', 'A London Symphony in G major (Symphony no. 2): II. Lento', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 7942 AND p.composer_id = 69
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:b3afb2fa-e957-4671-afca-cc13fa2f0e03'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = 'Scherzo (Nocturne): Allegro vivace – Andantino', part.name_en = 'A London Symphony in G major (Symphony no. 2): III. Scherzo (Nocturne): Allegro vivace – Andantino',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 7942 AND p.composer_id = 69 AND part.part_key = 'musicbrainz:d9cc4daf-3bf5-4d08-9eb4-d9f8e91e7f6b' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:d9cc4daf-3bf5-4d08-9eb4-d9f8e91e7f6b', 3, 'III', 'Scherzo (Nocturne): Allegro vivace – Andantino', 'A London Symphony in G major (Symphony no. 2): III. Scherzo (Nocturne): Allegro vivace – Andantino', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 7942 AND p.composer_id = 69
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:d9cc4daf-3bf5-4d08-9eb4-d9f8e91e7f6b'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = 'IV',
    part.name_ko = 'Andante con moto – Maestoso alla marcia (quasi lento) – Allegro – Andantino ma sostenuto – Tempo primo – Allegro – Lento – Epilogue: Andante sostenuto – Lento', part.name_en = 'A London Symphony in G major (Symphony no. 2): IV. Andante con moto – Maestoso alla marcia (quasi lento) – Allegro – Andantino ma sostenuto – Tempo primo – Allegro – Lento – Epilogue: Andante sostenuto – Lento',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 7942 AND p.composer_id = 69 AND part.part_key = 'musicbrainz:88de269d-b23f-4de2-a750-2bc5f42c40b6' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:88de269d-b23f-4de2-a750-2bc5f42c40b6', 4, 'IV', 'Andante con moto – Maestoso alla marcia (quasi lento) – Allegro – Andantino ma sostenuto – Tempo primo – Allegro – Lento – Epilogue: Andante sostenuto – Lento', 'A London Symphony in G major (Symphony no. 2): IV. Andante con moto – Maestoso alla marcia (quasi lento) – Allegro – Andantino ma sostenuto – Tempo primo – Allegro – Lento – Epilogue: Andante sostenuto – Lento', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 7942 AND p.composer_id = 69
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:88de269d-b23f-4de2-a750-2bc5f42c40b6'
);


-- None A vision of aeroplanes

UPDATE pieces piece
SET piece.title = 'A vision of aeroplanes', piece.title_en = 'A vision of aeroplanes',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 7666 AND piece.composer_id = 69
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None 가곡 <Alister McAlpine's Lament>

UPDATE pieces piece
SET piece.title = '가곡 <Alister McAlpine''s Lament>', piece.title_en = 'Alister McAlpine''s Lament',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 8701 AND piece.composer_id = 69
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None 연가곡집 <Along the Field>

UPDATE pieces piece
SET piece.title = '연가곡집 <Along the Field>', piece.title_en = 'Along the Field',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 8118 AND piece.composer_id = 69
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'We''ll to the Woods No More', part.name_en = 'Along the Field: No. 1. We''ll to the Woods No More',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 8118 AND p.composer_id = 69 AND part.part_key = 'musicbrainz:5229d4da-6b36-402d-99b4-150fabf49eb2' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:5229d4da-6b36-402d-99b4-150fabf49eb2', 1, NULL, 'We''ll to the Woods No More', 'Along the Field: No. 1. We''ll to the Woods No More', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 8118 AND p.composer_id = 69
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:5229d4da-6b36-402d-99b4-150fabf49eb2'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'Along the Field as We Came By', part.name_en = 'Along the Field: No. 2. Along the Field as We Came By',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 8118 AND p.composer_id = 69 AND part.part_key = 'musicbrainz:0add3bdc-44e9-436b-9450-c5c244eb13ff' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:0add3bdc-44e9-436b-9450-c5c244eb13ff', 2, NULL, 'Along the Field as We Came By', 'Along the Field: No. 2. Along the Field as We Came By', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 8118 AND p.composer_id = 69
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:0add3bdc-44e9-436b-9450-c5c244eb13ff'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = NULL,
    part.name_ko = 'The Half-Moon Westers Low', part.name_en = 'Along the Field: No. 3. The Half-Moon Westers Low',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 8118 AND p.composer_id = 69 AND part.part_key = 'musicbrainz:307d8bed-f425-48a8-bbe3-7760296f8abe' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:307d8bed-f425-48a8-bbe3-7760296f8abe', 3, NULL, 'The Half-Moon Westers Low', 'Along the Field: No. 3. The Half-Moon Westers Low', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 8118 AND p.composer_id = 69
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:307d8bed-f425-48a8-bbe3-7760296f8abe'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = NULL,
    part.name_ko = 'The Soldier (destroyed before publication)', part.name_en = 'Along the Field: No. 4. The Soldier (destroyed before publication)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 8118 AND p.composer_id = 69 AND part.part_key = 'musicbrainz:698cb293-1528-46df-a4ac-0fe64e4a375f' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:698cb293-1528-46df-a4ac-0fe64e4a375f', 4, NULL, 'The Soldier (destroyed before publication)', 'Along the Field: No. 4. The Soldier (destroyed before publication)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 8118 AND p.composer_id = 69
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:698cb293-1528-46df-a4ac-0fe64e4a375f'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 5, part.movement_number = NULL,
    part.name_ko = 'Goodbye', part.name_en = 'Along the Field: No. 5. Goodbye',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 8118 AND p.composer_id = 69 AND part.part_key = 'musicbrainz:9610d001-1161-4d4d-8994-d90f70c278ec' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:9610d001-1161-4d4d-8994-d90f70c278ec', 5, NULL, 'Goodbye', 'Along the Field: No. 5. Goodbye', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 8118 AND p.composer_id = 69
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:9610d001-1161-4d4d-8994-d90f70c278ec'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 6, part.movement_number = NULL,
    part.name_ko = 'In the Morning, in the Morning', part.name_en = 'Along the Field: No. 6. In the Morning, in the Morning',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 8118 AND p.composer_id = 69 AND part.part_key = 'musicbrainz:b6821214-4d8f-45c6-a7f6-2189a1ffd1fb' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:b6821214-4d8f-45c6-a7f6-2189a1ffd1fb', 6, NULL, 'In the Morning, in the Morning', 'Along the Field: No. 6. In the Morning, in the Morning', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 8118 AND p.composer_id = 69
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:b6821214-4d8f-45c6-a7f6-2189a1ffd1fb'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 7, part.movement_number = NULL,
    part.name_ko = 'The Sigh That Heaves the Grasses', part.name_en = 'Along the Field: No. 7. The Sigh That Heaves the Grasses',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 8118 AND p.composer_id = 69 AND part.part_key = 'musicbrainz:26c31ff1-feaa-4094-9619-c2f560e5438d' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:26c31ff1-feaa-4094-9619-c2f560e5438d', 7, NULL, 'The Sigh That Heaves the Grasses', 'Along the Field: No. 7. The Sigh That Heaves the Grasses', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 8118 AND p.composer_id = 69
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:26c31ff1-feaa-4094-9619-c2f560e5438d'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 8, part.movement_number = NULL,
    part.name_ko = 'Fancy''s Knell', part.name_en = 'Along the Field: No. 8. Fancy''s Knell',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 8118 AND p.composer_id = 69 AND part.part_key = 'musicbrainz:460a0fa0-bcb2-4d9f-bd5e-ca29a12dd496' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:460a0fa0-bcb2-4d9f-bd5e-ca29a12dd496', 8, NULL, 'Fancy''s Knell', 'Along the Field: No. 8. Fancy''s Knell', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 8118 AND p.composer_id = 69
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:460a0fa0-bcb2-4d9f-bd5e-ca29a12dd496'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 9, part.movement_number = NULL,
    part.name_ko = 'With Rue My Heart Is Laden', part.name_en = 'Along the Field: No. 9. With Rue My Heart Is Laden',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 8118 AND p.composer_id = 69 AND part.part_key = 'musicbrainz:cb3dfc59-1354-4778-8753-e085e99a2f56' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:cb3dfc59-1354-4778-8753-e085e99a2f56', 9, NULL, 'With Rue My Heart Is Laden', 'Along the Field: No. 9. With Rue My Heart Is Laden', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 8118 AND p.composer_id = 69
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:cb3dfc59-1354-4778-8753-e085e99a2f56'
);


-- None An Oxford Elegy

UPDATE pieces piece
SET piece.title = 'An Oxford Elegy', piece.title_en = 'An Oxford Elegy',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 9110 AND piece.composer_id = 69
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'Lento', part.name_en = 'An Oxford Elegy: I. Lento',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 9110 AND p.composer_id = 69 AND part.part_key = 'musicbrainz:4ea56049-d482-3cd0-83a2-deb11537ba3f' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:4ea56049-d482-3cd0-83a2-deb11537ba3f', 1, 'I', 'Lento', 'An Oxford Elegy: I. Lento', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 9110 AND p.composer_id = 69
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:4ea56049-d482-3cd0-83a2-deb11537ba3f'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = '"Go, for they call you, Shepherd"', part.name_en = 'An Oxford Elegy: II. "Go, for they call you, Shepherd"',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 9110 AND p.composer_id = 69 AND part.part_key = 'musicbrainz:6e31b92b-8613-3aa4-b8b1-1b1ae2c1efca' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:6e31b92b-8613-3aa4-b8b1-1b1ae2c1efca', 2, 'II', '"Go, for they call you, Shepherd"', 'An Oxford Elegy: II. "Go, for they call you, Shepherd"', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 9110 AND p.composer_id = 69
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:6e31b92b-8613-3aa4-b8b1-1b1ae2c1efca'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = '"Here will I sit and wait"', part.name_en = 'An Oxford Elegy: III. "Here will I sit and wait"',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 9110 AND p.composer_id = 69 AND part.part_key = 'musicbrainz:474c0f2c-5760-39e6-b113-bb55637cba21' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:474c0f2c-5760-39e6-b113-bb55637cba21', 3, 'III', '"Here will I sit and wait"', 'An Oxford Elegy: III. "Here will I sit and wait"', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 9110 AND p.composer_id = 69
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:474c0f2c-5760-39e6-b113-bb55637cba21'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = 'IV',
    part.name_ko = '"Screen''d is this nook"', part.name_en = 'An Oxford Elegy: IV. "Screen''d is this nook"',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 9110 AND p.composer_id = 69 AND part.part_key = 'musicbrainz:d7665e85-8c14-38d0-9fe4-70a877bada64' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:d7665e85-8c14-38d0-9fe4-70a877bada64', 4, 'IV', '"Screen''d is this nook"', 'An Oxford Elegy: IV. "Screen''d is this nook"', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 9110 AND p.composer_id = 69
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:d7665e85-8c14-38d0-9fe4-70a877bada64'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 5, part.movement_number = 'V',
    part.name_ko = '"That sweet city"', part.name_en = 'An Oxford Elegy: V. "That sweet city"',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 9110 AND p.composer_id = 69 AND part.part_key = 'musicbrainz:e188cc81-ebeb-3cc2-a054-55606e7769c6' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:e188cc81-ebeb-3cc2-a054-55606e7769c6', 5, 'V', '"That sweet city"', 'An Oxford Elegy: V. "That sweet city"', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 9110 AND p.composer_id = 69
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:e188cc81-ebeb-3cc2-a054-55606e7769c6'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 6, part.movement_number = 'VI',
    part.name_ko = '"Come, let me read"', part.name_en = 'An Oxford Elegy: VI. "Come, let me read"',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 9110 AND p.composer_id = 69 AND part.part_key = 'musicbrainz:cfd58e1e-63a3-3c3c-b6b8-afffcaff861a' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:cfd58e1e-63a3-3c3c-b6b8-afffcaff861a', 6, 'VI', '"Come, let me read"', 'An Oxford Elegy: VI. "Come, let me read"', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 9110 AND p.composer_id = 69
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:cfd58e1e-63a3-3c3c-b6b8-afffcaff861a'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 7, part.movement_number = 'VII',
    part.name_ko = '"Or in my boat I lie"', part.name_en = 'An Oxford Elegy: VII. "Or in my boat I lie"',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 9110 AND p.composer_id = 69 AND part.part_key = 'musicbrainz:8f2d8f7a-7964-31d4-814e-aaa78a7d545e' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:8f2d8f7a-7964-31d4-814e-aaa78a7d545e', 7, 'VII', '"Or in my boat I lie"', 'An Oxford Elegy: VII. "Or in my boat I lie"', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 9110 AND p.composer_id = 69
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:8f2d8f7a-7964-31d4-814e-aaa78a7d545e'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 8, part.movement_number = 'VIII',
    part.name_ko = '"And once, in winter"', part.name_en = 'An Oxford Elegy: VIII. "And once, in winter"',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 9110 AND p.composer_id = 69 AND part.part_key = 'musicbrainz:e34615a6-7a8b-371c-ac15-006b15e80d55' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:e34615a6-7a8b-371c-ac15-006b15e80d55', 8, 'VIII', '"And once, in winter"', 'An Oxford Elegy: VIII. "And once, in winter"', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 9110 AND p.composer_id = 69
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:e34615a6-7a8b-371c-ac15-006b15e80d55'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 9, part.movement_number = 'IX',
    part.name_ko = '"But what - I dream!"', part.name_en = 'An Oxford Elegy: IX. "But what - I dream!"',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 9110 AND p.composer_id = 69 AND part.part_key = 'musicbrainz:42fedc78-47b4-38a0-b956-21bc3ed6c2a6' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:42fedc78-47b4-38a0-b956-21bc3ed6c2a6', 9, 'IX', '"But what - I dream!"', 'An Oxford Elegy: IX. "But what - I dream!"', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 9110 AND p.composer_id = 69
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:42fedc78-47b4-38a0-b956-21bc3ed6c2a6'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 10, part.movement_number = 'X',
    part.name_ko = '"No, no, thou has not felt"', part.name_en = 'An Oxford Elegy: X. "No, no, thou has not felt"',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 9110 AND p.composer_id = 69 AND part.part_key = 'musicbrainz:63c4035a-4042-37f8-ab98-7140bd957540' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:63c4035a-4042-37f8-ab98-7140bd957540', 10, 'X', '"No, no, thou has not felt"', 'An Oxford Elegy: X. "No, no, thou has not felt"', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 9110 AND p.composer_id = 69
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:63c4035a-4042-37f8-ab98-7140bd957540'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 11, part.movement_number = 'XI',
    part.name_ko = '"Runs it not here"', part.name_en = 'An Oxford Elegy: XI. "Runs it not here"',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 9110 AND p.composer_id = 69 AND part.part_key = 'musicbrainz:ffb037cf-66b3-38f9-b2ad-a7355318e14e' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:ffb037cf-66b3-38f9-b2ad-a7355318e14e', 11, 'XI', '"Runs it not here"', 'An Oxford Elegy: XI. "Runs it not here"', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 9110 AND p.composer_id = 69
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:ffb037cf-66b3-38f9-b2ad-a7355318e14e'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 12, part.movement_number = 'XII',
    part.name_ko = '"Needs must I, with heavy heart"', part.name_en = 'An Oxford Elegy: XII. "Needs must I, with heavy heart"',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 9110 AND p.composer_id = 69 AND part.part_key = 'musicbrainz:2ccbfab2-a07f-3c9d-b339-11273732b52b' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:2ccbfab2-a07f-3c9d-b339-11273732b52b', 12, 'XII', '"Needs must I, with heavy heart"', 'An Oxford Elegy: XII. "Needs must I, with heavy heart"', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 9110 AND p.composer_id = 69
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:2ccbfab2-a07f-3c9d-b339-11273732b52b'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 13, part.movement_number = 'XIII',
    part.name_ko = '"Soon will the high Midsummer pomps"', part.name_en = 'An Oxford Elegy: XIII. "Soon will the high Midsummer pomps"',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 9110 AND p.composer_id = 69 AND part.part_key = 'musicbrainz:9dc53435-e203-3abd-a0ea-5f4b92a10890' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:9dc53435-e203-3abd-a0ea-5f4b92a10890', 13, 'XIII', '"Soon will the high Midsummer pomps"', 'An Oxford Elegy: XIII. "Soon will the high Midsummer pomps"', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 9110 AND p.composer_id = 69
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:9dc53435-e203-3abd-a0ea-5f4b92a10890'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 14, part.movement_number = 'XIV',
    part.name_ko = '"He hearkens not!"', part.name_en = 'An Oxford Elegy: XIV. "He hearkens not!"',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 9110 AND p.composer_id = 69 AND part.part_key = 'musicbrainz:9e2f1632-8c42-353c-b0c3-12365333ed1d' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:9e2f1632-8c42-353c-b0c3-12365333ed1d', 14, 'XIV', '"He hearkens not!"', 'An Oxford Elegy: XIV. "He hearkens not!"', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 9110 AND p.composer_id = 69
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:9e2f1632-8c42-353c-b0c3-12365333ed1d'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 15, part.movement_number = 'XV',
    part.name_ko = '"Never more"', part.name_en = 'An Oxford Elegy: XV. "Never more"',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 9110 AND p.composer_id = 69 AND part.part_key = 'musicbrainz:09c166b8-c44e-3abb-b073-d0b006e183d4' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:09c166b8-c44e-3abb-b073-d0b006e183d4', 15, 'XV', '"Never more"', 'An Oxford Elegy: XV. "Never more"', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 9110 AND p.composer_id = 69
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:09c166b8-c44e-3abb-b073-d0b006e183d4'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 16, part.movement_number = 'XVI',
    part.name_ko = '"Yes, thou art gone!"', part.name_en = 'An Oxford Elegy: XVI. "Yes, thou art gone!"',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 9110 AND p.composer_id = 69 AND part.part_key = 'musicbrainz:ed238ec7-5a34-3113-a67d-d307e08ca5ab' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:ed238ec7-5a34-3113-a67d-d307e08ca5ab', 16, 'XVI', '"Yes, thou art gone!"', 'An Oxford Elegy: XVI. "Yes, thou art gone!"', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 9110 AND p.composer_id = 69
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:ed238ec7-5a34-3113-a67d-d307e08ca5ab'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 17, part.movement_number = 'XVII',
    part.name_ko = '"Despair will I not"', part.name_en = 'An Oxford Elegy: XVII. "Despair will I not"',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 9110 AND p.composer_id = 69 AND part.part_key = 'musicbrainz:375b9858-b918-3d0b-8138-8c94165baf4c' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:375b9858-b918-3d0b-8138-8c94165baf4c', 17, 'XVII', '"Despair will I not"', 'An Oxford Elegy: XVII. "Despair will I not"', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 9110 AND p.composer_id = 69
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:375b9858-b918-3d0b-8138-8c94165baf4c'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 18, part.movement_number = 'XVIII',
    part.name_ko = '"Why faintest thou?"', part.name_en = 'An Oxford Elegy: XVIII. "Why faintest thou?"',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 9110 AND p.composer_id = 69 AND part.part_key = 'musicbrainz:42e3b1cd-852b-3b4f-933c-62fd9106f50e' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:42e3b1cd-852b-3b4f-933c-62fd9106f50e', 18, 'XVIII', '"Why faintest thou?"', 'An Oxford Elegy: XVIII. "Why faintest thou?"', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 9110 AND p.composer_id = 69
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:42e3b1cd-852b-3b4f-933c-62fd9106f50e'
);


-- None Aristophanic Suite “The Wasps”

UPDATE pieces piece
SET piece.title = 'Aristophanic Suite “The Wasps”', piece.title_en = 'Aristophanic Suite “The Wasps”',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 7585 AND piece.composer_id = 69
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'Overture', part.name_en = 'Aristophanic Suite “The Wasps”: I. Overture',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 7585 AND p.composer_id = 69 AND part.part_key = 'musicbrainz:087a5523-94f9-3cc0-9c91-1a6e17b3aed0' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:087a5523-94f9-3cc0-9c91-1a6e17b3aed0', 1, 'I', 'Overture', 'Aristophanic Suite “The Wasps”: I. Overture', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 7585 AND p.composer_id = 69
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:087a5523-94f9-3cc0-9c91-1a6e17b3aed0'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'Entr’acte', part.name_en = 'Aristophanic Suite “The Wasps”: II. Entr’acte',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 7585 AND p.composer_id = 69 AND part.part_key = 'musicbrainz:d4e28de2-b31b-3a1a-8d52-6bf8d4b4a161' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:d4e28de2-b31b-3a1a-8d52-6bf8d4b4a161', 2, 'II', 'Entr’acte', 'Aristophanic Suite “The Wasps”: II. Entr’acte', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 7585 AND p.composer_id = 69
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:d4e28de2-b31b-3a1a-8d52-6bf8d4b4a161'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = 'March Past of the Kitchen Utensils', part.name_en = 'Aristophanic Suite “The Wasps”: III. March Past of the Kitchen Utensils',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 7585 AND p.composer_id = 69 AND part.part_key = 'musicbrainz:d1fef43d-a0ab-3911-8f9c-17a9cb4b5fa6' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:d1fef43d-a0ab-3911-8f9c-17a9cb4b5fa6', 3, 'III', 'March Past of the Kitchen Utensils', 'Aristophanic Suite “The Wasps”: III. March Past of the Kitchen Utensils', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 7585 AND p.composer_id = 69
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:d1fef43d-a0ab-3911-8f9c-17a9cb4b5fa6'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = 'IV',
    part.name_ko = 'Entr’acte', part.name_en = 'Aristophanic Suite “The Wasps”: IV. Entr’acte',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 7585 AND p.composer_id = 69 AND part.part_key = 'musicbrainz:bdb2a3cf-9136-3cda-9f19-f929d5bac5ec' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:bdb2a3cf-9136-3cda-9f19-f929d5bac5ec', 4, 'IV', 'Entr’acte', 'Aristophanic Suite “The Wasps”: IV. Entr’acte', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 7585 AND p.composer_id = 69
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:bdb2a3cf-9136-3cda-9f19-f929d5bac5ec'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 5, part.movement_number = 'V',
    part.name_ko = 'Ballet and Final Tableau', part.name_en = 'Aristophanic Suite “The Wasps”: V. Ballet and Final Tableau',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 7585 AND p.composer_id = 69 AND part.part_key = 'musicbrainz:70501d81-739e-304c-9e70-8d6f9293b57f' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:70501d81-739e-304c-9e70-8d6f9293b57f', 5, 'V', 'Ballet and Final Tableau', 'Aristophanic Suite “The Wasps”: V. Ballet and Final Tableau', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 7585 AND p.composer_id = 69
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:70501d81-739e-304c-9e70-8d6f9293b57f'
);


-- None 가곡 <As the Disciples, When Thy Son Had Left Them>

UPDATE pieces piece
SET piece.title = '가곡 <As the Disciples, When Thy Son Had Left Them>', piece.title_en = 'As the Disciples, When Thy Son Had Left Them',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 8504 AND piece.composer_id = 69
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Benedicite

UPDATE pieces piece
SET piece.title = 'Benedicite', piece.title_en = 'Benedicite',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 9269 AND piece.composer_id = 69
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None 영화음악 <Bitter Springs>

UPDATE pieces piece
SET piece.title = '영화음악 <Bitter Springs>', piece.title_en = 'Bitter Springs',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 10949 AND piece.composer_id = 69
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'Main Titles', part.name_en = 'Bitter Springs: I. Main Titles',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 10949 AND p.composer_id = 69 AND part.part_key = 'musicbrainz:85c43e93-3142-445d-a8ac-8f4d404f8afb' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:85c43e93-3142-445d-a8ac-8f4d404f8afb', 1, 'I', 'Main Titles', 'Bitter Springs: I. Main Titles', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 10949 AND p.composer_id = 69
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:85c43e93-3142-445d-a8ac-8f4d404f8afb'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'Opening Music', part.name_en = 'Bitter Springs: II. Opening Music',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 10949 AND p.composer_id = 69 AND part.part_key = 'musicbrainz:1439e826-2577-4b56-82c8-20de406a773a' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:1439e826-2577-4b56-82c8-20de406a773a', 2, 'II', 'Opening Music', 'Bitter Springs: II. Opening Music', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 10949 AND p.composer_id = 69
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:1439e826-2577-4b56-82c8-20de406a773a'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = 'Rocks', part.name_en = 'Bitter Springs: III. Rocks',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 10949 AND p.composer_id = 69 AND part.part_key = 'musicbrainz:5fb657d2-4129-4fd3-934d-640e34ac35e6' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:5fb657d2-4129-4fd3-934d-640e34ac35e6', 3, 'III', 'Rocks', 'Bitter Springs: III. Rocks', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 10949 AND p.composer_id = 69
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:5fb657d2-4129-4fd3-934d-640e34ac35e6'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = 'IV',
    part.name_ko = 'First Desert', part.name_en = 'Bitter Springs: IV. First Desert',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 10949 AND p.composer_id = 69 AND part.part_key = 'musicbrainz:fb3be3ec-44b9-4593-bea1-e2c5591d04ef' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:fb3be3ec-44b9-4593-bea1-e2c5591d04ef', 4, 'IV', 'First Desert', 'Bitter Springs: IV. First Desert', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 10949 AND p.composer_id = 69
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:fb3be3ec-44b9-4593-bea1-e2c5591d04ef'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 5, part.movement_number = 'V',
    part.name_ko = 'Waterhole', part.name_en = 'Bitter Springs: V. Waterhole',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 10949 AND p.composer_id = 69 AND part.part_key = 'musicbrainz:4618d6b9-6d17-4989-93b8-78a6180501a8' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:4618d6b9-6d17-4989-93b8-78a6180501a8', 5, 'V', 'Waterhole', 'Bitter Springs: V. Waterhole', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 10949 AND p.composer_id = 69
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:4618d6b9-6d17-4989-93b8-78a6180501a8'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 6, part.movement_number = 'VI',
    part.name_ko = 'End of the Trek', part.name_en = 'Bitter Springs: VI. End of the Trek',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 10949 AND p.composer_id = 69 AND part.part_key = 'musicbrainz:e225c5d0-89a3-4932-892f-148d23fb44b5' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:e225c5d0-89a3-4932-892f-148d23fb44b5', 6, 'VI', 'End of the Trek', 'Bitter Springs: VI. End of the Trek', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 10949 AND p.composer_id = 69
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:e225c5d0-89a3-4932-892f-148d23fb44b5'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 7, part.movement_number = 'VII',
    part.name_ko = 'Axes', part.name_en = 'Bitter Springs: VII. Axes',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 10949 AND p.composer_id = 69 AND part.part_key = 'musicbrainz:79199c6a-71ba-4f56-b067-1123e17a6fd4' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:79199c6a-71ba-4f56-b067-1123e17a6fd4', 7, 'VII', 'Axes', 'Bitter Springs: VII. Axes', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 10949 AND p.composer_id = 69
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:79199c6a-71ba-4f56-b067-1123e17a6fd4'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 8, part.movement_number = 'VIII',
    part.name_ko = 'Kangaroos', part.name_en = 'Bitter Springs: VIII. Kangaroos',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 10949 AND p.composer_id = 69 AND part.part_key = 'musicbrainz:a8f9bdf8-650f-4223-b914-e38f63ec516a' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:a8f9bdf8-650f-4223-b914-e38f63ec516a', 8, 'VIII', 'Kangaroos', 'Bitter Springs: VIII. Kangaroos', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 10949 AND p.composer_id = 69
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:a8f9bdf8-650f-4223-b914-e38f63ec516a'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 9, part.movement_number = 'IX',
    part.name_ko = 'Boomerang', part.name_en = 'Bitter Springs: IX. Boomerang',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 10949 AND p.composer_id = 69 AND part.part_key = 'musicbrainz:11107d14-3fa2-4536-9543-3e1b1139523e' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:11107d14-3fa2-4536-9543-3e1b1139523e', 9, 'IX', 'Boomerang', 'Bitter Springs: IX. Boomerang', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 10949 AND p.composer_id = 69
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:11107d14-3fa2-4536-9543-3e1b1139523e'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 10, part.movement_number = 'X',
    part.name_ko = 'Housewarming', part.name_en = 'Bitter Springs: X. Housewarming',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 10949 AND p.composer_id = 69 AND part.part_key = 'musicbrainz:e088cc55-b732-48fb-982f-7deb103ba23f' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:e088cc55-b732-48fb-982f-7deb103ba23f', 10, 'X', 'Housewarming', 'Bitter Springs: X. Housewarming', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 10949 AND p.composer_id = 69
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:e088cc55-b732-48fb-982f-7deb103ba23f'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 11, part.movement_number = 'XI',
    part.name_ko = 'Hunters', part.name_en = 'Bitter Springs: XI. Hunters',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 10949 AND p.composer_id = 69 AND part.part_key = 'musicbrainz:e82a9d01-ac6b-4c4e-9645-f1f9c400bd33' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:e82a9d01-ac6b-4c4e-9645-f1f9c400bd33', 11, 'XI', 'Hunters', 'Bitter Springs: XI. Hunters', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 10949 AND p.composer_id = 69
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:e82a9d01-ac6b-4c4e-9645-f1f9c400bd33'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 12, part.movement_number = 'XII',
    part.name_ko = 'Fire', part.name_en = 'Bitter Springs: XII. Fire',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 10949 AND p.composer_id = 69 AND part.part_key = 'musicbrainz:7f736663-9700-4b6b-9ab9-49441b412633' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:7f736663-9700-4b6b-9ab9-49441b412633', 12, 'XII', 'Fire', 'Bitter Springs: XII. Fire', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 10949 AND p.composer_id = 69
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:7f736663-9700-4b6b-9ab9-49441b412633'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 13, part.movement_number = 'XIII',
    part.name_ko = 'Abos Retreat', part.name_en = 'Bitter Springs: XIII. Abos Retreat',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 10949 AND p.composer_id = 69 AND part.part_key = 'musicbrainz:ebff5065-6fda-4e90-a8e0-765488e7550c' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:ebff5065-6fda-4e90-a8e0-765488e7550c', 13, 'XIII', 'Abos Retreat', 'Bitter Springs: XIII. Abos Retreat', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 10949 AND p.composer_id = 69
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:ebff5065-6fda-4e90-a8e0-765488e7550c'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 14, part.movement_number = 'XIV',
    part.name_ko = 'Warragani Boy', part.name_en = 'Bitter Springs: XIV. Warragani Boy',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 10949 AND p.composer_id = 69 AND part.part_key = 'musicbrainz:c49ff38e-ae3d-4159-850b-7908a5728465' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:c49ff38e-ae3d-4159-850b-7908a5728465', 14, 'XIV', 'Warragani Boy', 'Bitter Springs: XIV. Warragani Boy', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 10949 AND p.composer_id = 69
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:c49ff38e-ae3d-4159-850b-7908a5728465'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 15, part.movement_number = 'XV',
    part.name_ko = 'Ma and Abos', part.name_en = 'Bitter Springs: XV. Ma and Abos',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 10949 AND p.composer_id = 69 AND part.part_key = 'musicbrainz:4a70ce49-dd16-4127-b3d0-6906b4f49f5d' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:4a70ce49-dd16-4127-b3d0-6906b4f49f5d', 15, 'XV', 'Ma and Abos', 'Bitter Springs: XV. Ma and Abos', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 10949 AND p.composer_id = 69
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:4a70ce49-dd16-4127-b3d0-6906b4f49f5d'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 16, part.movement_number = 'XVI',
    part.name_ko = 'Round Up', part.name_en = 'Bitter Springs: XVI. Round Up',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 10949 AND p.composer_id = 69 AND part.part_key = 'musicbrainz:45b712a8-f143-4de7-94ef-77eb910002cc' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:45b712a8-f143-4de7-94ef-77eb910002cc', 16, 'XVI', 'Round Up', 'Bitter Springs: XVI. Round Up', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 10949 AND p.composer_id = 69
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:45b712a8-f143-4de7-94ef-77eb910002cc'
);


-- None 가곡 <Blake’s Cradle Song>

UPDATE pieces piece
SET piece.title = '가곡 <Blake’s Cradle Song>', piece.title_en = 'Blake’s Cradle Song',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 10939 AND piece.composer_id = 69
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Bucolic Suite

UPDATE pieces piece
SET piece.title = 'Bucolic Suite', piece.title_en = 'Bucolic Suite',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 10352 AND piece.composer_id = 69
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'III',
    part.name_ko = 'Intermezzo (Allegretto)', part.name_en = 'Bucolic Suite: III. Intermezzo (Allegretto)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 10352 AND p.composer_id = 69 AND part.part_key = 'musicbrainz:023db25c-3896-42af-8158-70341fc17354' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:023db25c-3896-42af-8158-70341fc17354', 1, 'III', 'Intermezzo (Allegretto)', 'Bucolic Suite: III. Intermezzo (Allegretto)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 10352 AND p.composer_id = 69
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:023db25c-3896-42af-8158-70341fc17354'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'I',
    part.name_ko = 'Allegro', part.name_en = 'Bucolic Suite: I. Allegro',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 10352 AND p.composer_id = 69 AND part.part_key = 'musicbrainz:2c647b48-f373-4263-88d8-6b570bd5ae54' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:2c647b48-f373-4263-88d8-6b570bd5ae54', 2, 'I', 'Allegro', 'Bucolic Suite: I. Allegro', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 10352 AND p.composer_id = 69
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:2c647b48-f373-4263-88d8-6b570bd5ae54'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'IV',
    part.name_ko = 'Finale (Allegro)', part.name_en = 'Bucolic Suite: IV. Finale (Allegro)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 10352 AND p.composer_id = 69 AND part.part_key = 'musicbrainz:65e8b820-201b-4f5f-bc24-235e82f68bd6' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:65e8b820-201b-4f5f-bc24-235e82f68bd6', 3, 'IV', 'Finale (Allegro)', 'Bucolic Suite: IV. Finale (Allegro)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 10352 AND p.composer_id = 69
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:65e8b820-201b-4f5f-bc24-235e82f68bd6'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = 'II',
    part.name_ko = 'Andante', part.name_en = 'Bucolic Suite: II. Andante',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 10352 AND p.composer_id = 69 AND part.part_key = 'musicbrainz:bc1b4c35-7278-4be7-b77d-2545b10540b1' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:bc1b4c35-7278-4be7-b77d-2545b10540b1', 4, 'II', 'Andante', 'Bucolic Suite: II. Andante', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 10352 AND p.composer_id = 69
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:bc1b4c35-7278-4be7-b77d-2545b10540b1'
);


-- None Buonaparty

UPDATE pieces piece
SET piece.title = 'Buonaparty', piece.title_en = 'Buonaparty',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 9161 AND piece.composer_id = 69
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Burley Heath

UPDATE pieces piece
SET piece.title = 'Burley Heath', piece.title_en = 'Burley Heath',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 9013 AND piece.composer_id = 69
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None 가곡 <Ca’ the Yowes>

UPDATE pieces piece
SET piece.title = '가곡 <Ca’ the Yowes>', piece.title_en = 'Ca’ the Yowes',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 9958 AND piece.composer_id = 69
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Charterhouse Suite

UPDATE pieces piece
SET piece.title = 'Charterhouse Suite', piece.title_en = 'Charterhouse Suite',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 10821 AND piece.composer_id = 69
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'Prelude', part.name_en = 'Charterhouse Suite: I. Prelude',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 10821 AND p.composer_id = 69 AND part.part_key = 'musicbrainz:9c7fa381-9431-4f3a-b208-5800979c8803' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:9c7fa381-9431-4f3a-b208-5800979c8803', 1, 'I', 'Prelude', 'Charterhouse Suite: I. Prelude', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 10821 AND p.composer_id = 69
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:9c7fa381-9431-4f3a-b208-5800979c8803'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'Slow Dance', part.name_en = 'Charterhouse Suite: II. Slow Dance',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 10821 AND p.composer_id = 69 AND part.part_key = 'musicbrainz:a44bef2d-47b8-4582-92c7-afb5213b77fa' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:a44bef2d-47b8-4582-92c7-afb5213b77fa', 2, 'II', 'Slow Dance', 'Charterhouse Suite: II. Slow Dance', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 10821 AND p.composer_id = 69
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:a44bef2d-47b8-4582-92c7-afb5213b77fa'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = 'Quick Dance', part.name_en = 'Charterhouse Suite: III. Quick Dance',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 10821 AND p.composer_id = 69 AND part.part_key = 'musicbrainz:f4a863e0-8380-4ab2-8dad-2b1c147f0f62' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:f4a863e0-8380-4ab2-8dad-2b1c147f0f62', 3, 'III', 'Quick Dance', 'Charterhouse Suite: III. Quick Dance', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 10821 AND p.composer_id = 69
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:f4a863e0-8380-4ab2-8dad-2b1c147f0f62'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = 'IV',
    part.name_ko = 'Slow Air', part.name_en = 'Charterhouse Suite: IV. Slow Air',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 10821 AND p.composer_id = 69 AND part.part_key = 'musicbrainz:475d8a31-cf11-4911-9930-4963dcfd2a0e' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:475d8a31-cf11-4911-9930-4963dcfd2a0e', 4, 'IV', 'Slow Air', 'Charterhouse Suite: IV. Slow Air', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 10821 AND p.composer_id = 69
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:475d8a31-cf11-4911-9930-4963dcfd2a0e'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 5, part.movement_number = 'V',
    part.name_ko = 'Rondo', part.name_en = 'Charterhouse Suite: V. Rondo',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 10821 AND p.composer_id = 69 AND part.part_key = 'musicbrainz:ea1ff4bb-bfc8-428f-807f-c452545844d3' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:ea1ff4bb-bfc8-428f-807f-c452545844d3', 5, 'V', 'Rondo', 'Charterhouse Suite: V. Rondo', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 10821 AND p.composer_id = 69
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:ea1ff4bb-bfc8-428f-807f-c452545844d3'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 6, part.movement_number = 'VI',
    part.name_ko = 'Pezzo Ostinato', part.name_en = 'Charterhouse Suite: VI. Pezzo Ostinato',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 10821 AND p.composer_id = 69 AND part.part_key = 'musicbrainz:b837a45e-a03f-4b21-874d-f340beec805c' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:b837a45e-a03f-4b21-874d-f340beec805c', 6, 'VI', 'Pezzo Ostinato', 'Charterhouse Suite: VI. Pezzo Ostinato', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 10821 AND p.composer_id = 69
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:b837a45e-a03f-4b21-874d-f340beec805c'
);


-- None Christmas Overture

UPDATE pieces piece
SET piece.title = 'Christmas Overture', piece.title_en = 'Christmas Overture',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 9985 AND piece.composer_id = 69
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None 가곡 <Claribel>

UPDATE pieces piece
SET piece.title = '가곡 <Claribel>', piece.title_en = 'Claribel',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 7742 AND piece.composer_id = 69
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Come Away Death

UPDATE pieces piece
SET piece.title = 'Come Away Death', piece.title_en = 'Come Away Death',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 11095 AND piece.composer_id = 69
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Come down, O love divine

UPDATE pieces piece
SET piece.title = 'Come down, O love divine', piece.title_en = 'Come down, O love divine',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 9096 AND piece.composer_id = 69
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Communion Service in G Minor

UPDATE pieces piece
SET piece.title = 'Communion Service in G Minor', piece.title_en = 'Communion Service in G Minor',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 8978 AND piece.composer_id = 69
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'VI',
    part.name_ko = 'Agnus Dei', part.name_en = 'Communion Service in G Minor: VI. Agnus Dei',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 8978 AND p.composer_id = 69 AND part.part_key = 'musicbrainz:29d6c107-0528-44a5-96ea-4704b51dea90' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:29d6c107-0528-44a5-96ea-4704b51dea90', 1, 'VI', 'Agnus Dei', 'Communion Service in G Minor: VI. Agnus Dei', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 8978 AND p.composer_id = 69
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:29d6c107-0528-44a5-96ea-4704b51dea90'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'I',
    part.name_ko = 'Responses to Commandments', part.name_en = 'Communion Service in G Minor: I. Responses to Commandments',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 8978 AND p.composer_id = 69 AND part.part_key = 'musicbrainz:38b0510c-050c-4815-8ed6-68ee95f4baf2' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:38b0510c-050c-4815-8ed6-68ee95f4baf2', 2, 'I', 'Responses to Commandments', 'Communion Service in G Minor: I. Responses to Commandments', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 8978 AND p.composer_id = 69
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:38b0510c-050c-4815-8ed6-68ee95f4baf2'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = 'Creed', part.name_en = 'Communion Service in G Minor: III. Creed',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 8978 AND p.composer_id = 69 AND part.part_key = 'musicbrainz:3e825c74-edf8-4a02-a620-368e0bb9096d' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:3e825c74-edf8-4a02-a620-368e0bb9096d', 3, 'III', 'Creed', 'Communion Service in G Minor: III. Creed', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 8978 AND p.composer_id = 69
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:3e825c74-edf8-4a02-a620-368e0bb9096d'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = 'VII',
    part.name_ko = 'Gloria in Excelsis', part.name_en = 'Communion Service in G Minor: VII. Gloria in Excelsis',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 8978 AND p.composer_id = 69 AND part.part_key = 'musicbrainz:820286c6-2fe7-4cc0-9a06-3076ddbc88a4' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:820286c6-2fe7-4cc0-9a06-3076ddbc88a4', 4, 'VII', 'Gloria in Excelsis', 'Communion Service in G Minor: VII. Gloria in Excelsis', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 8978 AND p.composer_id = 69
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:820286c6-2fe7-4cc0-9a06-3076ddbc88a4'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 5, part.movement_number = 'V',
    part.name_ko = 'Benedictus', part.name_en = 'Communion Service in G Minor: V. Benedictus',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 8978 AND p.composer_id = 69 AND part.part_key = 'musicbrainz:90b7a96f-21ea-42d2-96cf-c9b5c1202fa3' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:90b7a96f-21ea-42d2-96cf-c9b5c1202fa3', 5, 'V', 'Benedictus', 'Communion Service in G Minor: V. Benedictus', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 8978 AND p.composer_id = 69
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:90b7a96f-21ea-42d2-96cf-c9b5c1202fa3'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 6, part.movement_number = 'II',
    part.name_ko = 'Kyrie', part.name_en = 'Communion Service in G Minor: II. Kyrie',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 8978 AND p.composer_id = 69 AND part.part_key = 'musicbrainz:92d3985e-1724-411d-8440-10b5786fca0e' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:92d3985e-1724-411d-8440-10b5786fca0e', 6, 'II', 'Kyrie', 'Communion Service in G Minor: II. Kyrie', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 8978 AND p.composer_id = 69
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:92d3985e-1724-411d-8440-10b5786fca0e'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 7, part.movement_number = 'IV',
    part.name_ko = 'Sanctus', part.name_en = 'Communion Service in G Minor: IV. Sanctus',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 8978 AND p.composer_id = 69 AND part.part_key = 'musicbrainz:aad7a152-191d-4d49-85e5-95b16d9cce3c' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:aad7a152-191d-4d49-85e5-95b16d9cce3c', 7, 'IV', 'Sanctus', 'Communion Service in G Minor: IV. Sanctus', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 8978 AND p.composer_id = 69
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:aad7a152-191d-4d49-85e5-95b16d9cce3c'
);


-- None 합주 협주곡

UPDATE pieces piece
SET piece.title = '합주 협주곡', piece.title_en = 'Concerto Grosso',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 10022 AND piece.composer_id = 69
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'Intrada', part.name_en = 'Concerto Grosso: I. Intrada',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 10022 AND p.composer_id = 69 AND part.part_key = 'musicbrainz:3e51bb82-a572-356b-abe7-e2cde4c06512' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:3e51bb82-a572-356b-abe7-e2cde4c06512', 1, 'I', 'Intrada', 'Concerto Grosso: I. Intrada', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 10022 AND p.composer_id = 69
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:3e51bb82-a572-356b-abe7-e2cde4c06512'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'Burlesca ostinata', part.name_en = 'Concerto Grosso: II. Burlesca ostinata',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 10022 AND p.composer_id = 69 AND part.part_key = 'musicbrainz:ecac2e50-5c95-3b35-b9c1-19d87309e33b' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:ecac2e50-5c95-3b35-b9c1-19d87309e33b', 2, 'II', 'Burlesca ostinata', 'Concerto Grosso: II. Burlesca ostinata', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 10022 AND p.composer_id = 69
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:ecac2e50-5c95-3b35-b9c1-19d87309e33b'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = 'Sarabande', part.name_en = 'Concerto Grosso: III. Sarabande',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 10022 AND p.composer_id = 69 AND part.part_key = 'musicbrainz:eed86337-92bd-3710-8cc5-c3f43056eab6' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:eed86337-92bd-3710-8cc5-c3f43056eab6', 3, 'III', 'Sarabande', 'Concerto Grosso: III. Sarabande', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 10022 AND p.composer_id = 69
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:eed86337-92bd-3710-8cc5-c3f43056eab6'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = 'IV',
    part.name_ko = 'Scherzo', part.name_en = 'Concerto Grosso: IV. Scherzo',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 10022 AND p.composer_id = 69 AND part.part_key = 'musicbrainz:89c8bec4-f364-3fe2-a9bb-7ef6a105441a' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:89c8bec4-f364-3fe2-a9bb-7ef6a105441a', 4, 'IV', 'Scherzo', 'Concerto Grosso: IV. Scherzo', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 10022 AND p.composer_id = 69
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:89c8bec4-f364-3fe2-a9bb-7ef6a105441a'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 5, part.movement_number = 'V',
    part.name_ko = 'March and Reprise', part.name_en = 'Concerto Grosso: V. March and Reprise',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 10022 AND p.composer_id = 69 AND part.part_key = 'musicbrainz:3346d083-b10e-382c-8ce7-2eb82fe62f03' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:3346d083-b10e-382c-8ce7-2eb82fe62f03', 5, 'V', 'March and Reprise', 'Concerto Grosso: V. March and Reprise', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 10022 AND p.composer_id = 69
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:3346d083-b10e-382c-8ce7-2eb82fe62f03'
);


-- None 바이올린 협주곡

UPDATE pieces piece
SET piece.title = '바이올린 협주곡', piece.title_en = 'Concerto for Violin and String Orchestra',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 8914 AND piece.composer_id = 69
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'II',
    part.name_ko = 'Adagio - Tranquillo', part.name_en = 'Concerto for Violin and String Orchestra: II. Adagio - Tranquillo',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 8914 AND p.composer_id = 69 AND part.part_key = 'musicbrainz:6bd2831b-68e5-4bb3-b236-e85fe8b5aa06' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:6bd2831b-68e5-4bb3-b236-e85fe8b5aa06', 1, 'II', 'Adagio - Tranquillo', 'Concerto for Violin and String Orchestra: II. Adagio - Tranquillo', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 8914 AND p.composer_id = 69
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:6bd2831b-68e5-4bb3-b236-e85fe8b5aa06'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'I',
    part.name_ko = 'Allegro pesante', part.name_en = 'Concerto for Violin and String Orchestra: I. Allegro pesante',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 8914 AND p.composer_id = 69 AND part.part_key = 'musicbrainz:707b348d-eb11-4af4-880b-96ff7b170e09' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:707b348d-eb11-4af4-880b-96ff7b170e09', 2, 'I', 'Allegro pesante', 'Concerto for Violin and String Orchestra: I. Allegro pesante', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 8914 AND p.composer_id = 69
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:707b348d-eb11-4af4-880b-96ff7b170e09'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = 'Presto', part.name_en = 'Concerto for Violin and String Orchestra: III. Presto',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 8914 AND p.composer_id = 69 AND part.part_key = 'musicbrainz:fe19a720-7bd9-4386-9caa-ff8571a161e6' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:fe19a720-7bd9-4386-9caa-ff8571a161e6', 3, 'III', 'Presto', 'Concerto for Violin and String Orchestra: III. Presto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 8914 AND p.composer_id = 69
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:fe19a720-7bd9-4386-9caa-ff8571a161e6'
);


-- None 협주곡 A단조

UPDATE pieces piece
SET piece.title = '협주곡 A단조', piece.title_en = 'Concerto in A minor for Oboe and Strings',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 8031 AND piece.composer_id = 69
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'Rondo Pastorale. Allegro moderato', part.name_en = 'Concerto in A minor for Oboe and Strings: I. Rondo Pastorale. Allegro moderato',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 8031 AND p.composer_id = 69 AND part.part_key = 'musicbrainz:397d2b55-77ca-3f8a-9f8a-a600fa5f860c' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:397d2b55-77ca-3f8a-9f8a-a600fa5f860c', 1, 'I', 'Rondo Pastorale. Allegro moderato', 'Concerto in A minor for Oboe and Strings: I. Rondo Pastorale. Allegro moderato', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 8031 AND p.composer_id = 69
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:397d2b55-77ca-3f8a-9f8a-a600fa5f860c'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'Minuet and Musette. Allegro moderato', part.name_en = 'Concerto in A minor for Oboe and Strings: II. Minuet and Musette. Allegro moderato',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 8031 AND p.composer_id = 69 AND part.part_key = 'musicbrainz:eada7d60-0663-357a-9b69-16fe8387aea6' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:eada7d60-0663-357a-9b69-16fe8387aea6', 2, 'II', 'Minuet and Musette. Allegro moderato', 'Concerto in A minor for Oboe and Strings: II. Minuet and Musette. Allegro moderato', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 8031 AND p.composer_id = 69
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:eada7d60-0663-357a-9b69-16fe8387aea6'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = 'Finale (Scherzo). Presto - Doppio più lento - Lento - Presto', part.name_en = 'Concerto in A minor for Oboe and Strings: III. Finale (Scherzo). Presto - Doppio più lento - Lento - Presto',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 8031 AND p.composer_id = 69 AND part.part_key = 'musicbrainz:98c616b3-fba2-3aaa-9ec6-c98f7e079447' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:98c616b3-fba2-3aaa-9ec6-c98f7e079447', 3, 'III', 'Finale (Scherzo). Presto - Doppio più lento - Lento - Presto', 'Concerto in A minor for Oboe and Strings: III. Finale (Scherzo). Presto - Doppio più lento - Lento - Presto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 8031 AND p.composer_id = 69
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:98c616b3-fba2-3aaa-9ec6-c98f7e079447'
);


-- None Darest thou now, O soul

UPDATE pieces piece
SET piece.title = 'Darest thou now, O soul', piece.title_en = 'Darest thou now, O soul',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 8128 AND piece.composer_id = 69
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None 가곡 <Dirge for Fidele>

UPDATE pieces piece
SET piece.title = '가곡 <Dirge for Fidele>', piece.title_en = 'Dirge for Fidele',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 8007 AND piece.composer_id = 69
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None 칸타타 <Dona nobis pacem>

UPDATE pieces piece
SET piece.title = '칸타타 <Dona nobis pacem>', piece.title_en = 'Dona nobis pacem',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 7529 AND piece.composer_id = 69
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'Agnus Dei', part.name_en = 'Dona nobis pacem: I. Agnus Dei',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 7529 AND p.composer_id = 69 AND part.part_key = 'musicbrainz:78bf6277-9788-429f-a2a8-ae51407c8eda' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:78bf6277-9788-429f-a2a8-ae51407c8eda', 1, 'I', 'Agnus Dei', 'Dona nobis pacem: I. Agnus Dei', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 7529 AND p.composer_id = 69
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:78bf6277-9788-429f-a2a8-ae51407c8eda'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = '"Beat! beat! drums!" (Allegro moderato)', part.name_en = 'Dona nobis pacem: II. "Beat! beat! drums!" (Allegro moderato)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 7529 AND p.composer_id = 69 AND part.part_key = 'musicbrainz:6e34c239-f99e-3048-be95-92fe18b490cf' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:6e34c239-f99e-3048-be95-92fe18b490cf', 2, 'II', '"Beat! beat! drums!" (Allegro moderato)', 'Dona nobis pacem: II. "Beat! beat! drums!" (Allegro moderato)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 7529 AND p.composer_id = 69
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:6e34c239-f99e-3048-be95-92fe18b490cf'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = 'Reconciliation (Andantino)', part.name_en = 'Dona nobis pacem: III. Reconciliation (Andantino)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 7529 AND p.composer_id = 69 AND part.part_key = 'musicbrainz:c5c95379-b450-335e-8703-b0a0ef472f8e' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:c5c95379-b450-335e-8703-b0a0ef472f8e', 3, 'III', 'Reconciliation (Andantino)', 'Dona nobis pacem: III. Reconciliation (Andantino)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 7529 AND p.composer_id = 69
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:c5c95379-b450-335e-8703-b0a0ef472f8e'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = 'IV',
    part.name_ko = 'Dirge for Two Veterans (Moderato alla marcia)', part.name_en = 'Dona nobis pacem: IV. Dirge for Two Veterans (Moderato alla marcia)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 7529 AND p.composer_id = 69 AND part.part_key = 'musicbrainz:ff6fee3d-c7e1-3e94-8d54-8a48583df931' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:ff6fee3d-c7e1-3e94-8d54-8a48583df931', 4, 'IV', 'Dirge for Two Veterans (Moderato alla marcia)', 'Dona nobis pacem: IV. Dirge for Two Veterans (Moderato alla marcia)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 7529 AND p.composer_id = 69
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:ff6fee3d-c7e1-3e94-8d54-8a48583df931'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 5, part.movement_number = 'V',
    part.name_ko = '"The Angel of Death has been abroad" (L''istesso tempo)', part.name_en = 'Dona nobis pacem: V. "The Angel of Death has been abroad" (L''istesso tempo)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 7529 AND p.composer_id = 69 AND part.part_key = 'musicbrainz:1d70f0fc-cde5-3cc0-8b4a-18fe3ecfdc24' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:1d70f0fc-cde5-3cc0-8b4a-18fe3ecfdc24', 5, 'V', '"The Angel of Death has been abroad" (L''istesso tempo)', 'Dona nobis pacem: V. "The Angel of Death has been abroad" (L''istesso tempo)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 7529 AND p.composer_id = 69
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:1d70f0fc-cde5-3cc0-8b4a-18fe3ecfdc24'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 6, part.movement_number = 'VI',
    part.name_ko = 'O man greatly beloved', part.name_en = 'Dona nobis pacem: VI. O man greatly beloved',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 7529 AND p.composer_id = 69 AND part.part_key = 'musicbrainz:560af30e-3e75-4e5b-ae86-836c5a6db5bc' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:560af30e-3e75-4e5b-ae86-836c5a6db5bc', 6, 'VI', 'O man greatly beloved', 'Dona nobis pacem: VI. O man greatly beloved', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 7529 AND p.composer_id = 69
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:560af30e-3e75-4e5b-ae86-836c5a6db5bc'
);


-- None 가곡 <Dreamland>

UPDATE pieces piece
SET piece.title = '가곡 <Dreamland>', piece.title_en = 'Dreamland',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 9135 AND piece.composer_id = 69
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None 가곡 <Echo's Lament for Narcissus (Slow, Slow, Fresh Fount)>

UPDATE pieces piece
SET piece.title = '가곡 <Echo''s Lament for Narcissus (Slow, Slow, Fresh Fount)>', piece.title_en = 'Echo''s Lament for Narcissus (Slow, Slow, Fresh Fount)',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 11108 AND piece.composer_id = 69
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None 부수음악 <Electra>

UPDATE pieces piece
SET piece.title = '부수음악 <Electra>', piece.title_en = 'Electra',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 8779 AND piece.composer_id = 69
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None England, My England

UPDATE pieces piece
SET piece.title = 'England, My England', piece.title_en = 'England, My England',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 11120 AND piece.composer_id = 69
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Fain Would I Change That Note

UPDATE pieces piece
SET piece.title = 'Fain Would I Change That Note', piece.title_en = 'Fain Would I Change That Note',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 10781 AND piece.composer_id = 69
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None 피아노 환상곡

UPDATE pieces piece
SET piece.title = '피아노 환상곡', piece.title_en = 'Fantasia for Piano and Orchestra',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 9180 AND piece.composer_id = 69
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Fantasia on Christmas Carols

UPDATE pieces piece
SET piece.title = 'Fantasia on Christmas Carols', piece.title_en = 'Fantasia on Christmas Carols',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 7722 AND piece.composer_id = 69
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'The Truth Sent From Above', part.name_en = 'The Truth Sent From Above',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 7722 AND p.composer_id = 69 AND part.part_key = 'musicbrainz:77441799-eb64-4ff9-a37f-063f40ca2bcf' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:77441799-eb64-4ff9-a37f-063f40ca2bcf', 1, NULL, 'The Truth Sent From Above', 'The Truth Sent From Above', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 7722 AND p.composer_id = 69
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:77441799-eb64-4ff9-a37f-063f40ca2bcf'
);


-- None Fantasia on Sussex Folk Tunes

UPDATE pieces piece
SET piece.title = 'Fantasia on Sussex Folk Tunes', piece.title_en = 'Fantasia on Sussex Folk Tunes',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 9768 AND piece.composer_id = 69
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Fantasia on the Old 104th Psalm Tune

UPDATE pieces piece
SET piece.title = 'Fantasia on the Old 104th Psalm Tune', piece.title_en = 'Fantasia on the Old 104th Psalm Tune',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 9132 AND piece.composer_id = 69
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Festival Te Deum in F major

UPDATE pieces piece
SET piece.title = 'Festival Te Deum in F major', piece.title_en = 'Festival Te Deum in F major',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 7876 AND piece.composer_id = 69
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None 연가곡집 <Five Mystical Songs>

UPDATE pieces piece
SET piece.title = '연가곡집 <Five Mystical Songs>', piece.title_en = 'Five Mystical Songs',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 8738 AND piece.composer_id = 69
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'Easter', part.name_en = 'Five Mystical Songs: No. 1. Easter',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 8738 AND p.composer_id = 69 AND part.part_key = 'musicbrainz:d7eade6c-eda2-44a8-9529-1e80a9e7915a' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:d7eade6c-eda2-44a8-9529-1e80a9e7915a', 1, NULL, 'Easter', 'Five Mystical Songs: No. 1. Easter', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 8738 AND p.composer_id = 69
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:d7eade6c-eda2-44a8-9529-1e80a9e7915a'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'Love Bade Me Welcome', part.name_en = 'Five Mystical Songs: No. 3. Love Bade Me Welcome',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 8738 AND p.composer_id = 69 AND part.part_key = 'musicbrainz:b94ea011-55d9-4c93-93d9-1a5dcb2821fc' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:b94ea011-55d9-4c93-93d9-1a5dcb2821fc', 2, NULL, 'Love Bade Me Welcome', 'Five Mystical Songs: No. 3. Love Bade Me Welcome', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 8738 AND p.composer_id = 69
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:b94ea011-55d9-4c93-93d9-1a5dcb2821fc'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = NULL,
    part.name_ko = 'The Call', part.name_en = 'Five Mystical Songs: No. 4. The Call',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 8738 AND p.composer_id = 69 AND part.part_key = 'musicbrainz:fb0ba744-6032-4683-b891-b987f19d3b73' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:fb0ba744-6032-4683-b891-b987f19d3b73', 3, NULL, 'The Call', 'Five Mystical Songs: No. 4. The Call', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 8738 AND p.composer_id = 69
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:fb0ba744-6032-4683-b891-b987f19d3b73'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = NULL,
    part.name_ko = 'Antiphon', part.name_en = 'Five Mystical Songs: No. 5. Antiphon',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 8738 AND p.composer_id = 69 AND part.part_key = 'musicbrainz:4e8f4bc3-523e-4af9-ae44-c02bc83885ae' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:4e8f4bc3-523e-4af9-ae44-c02bc83885ae', 4, NULL, 'Antiphon', 'Five Mystical Songs: No. 5. Antiphon', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 8738 AND p.composer_id = 69
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:4e8f4bc3-523e-4af9-ae44-c02bc83885ae'
);


-- None Five Tudor Portraits

UPDATE pieces piece
SET piece.title = 'Five Tudor Portraits', piece.title_en = 'Five Tudor Portraits',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 8709 AND piece.composer_id = 69
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'Ballad "The Tunning of Elinor Rumming"', part.name_en = 'Five Tudors Portraits: I. Ballad "The Tunning of Elinor Rumming"',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 8709 AND p.composer_id = 69 AND part.part_key = 'musicbrainz:106a0457-a35c-47b8-931d-ec194c5148ee' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:106a0457-a35c-47b8-931d-ec194c5148ee', 1, 'I', 'Ballad "The Tunning of Elinor Rumming"', 'Five Tudors Portraits: I. Ballad "The Tunning of Elinor Rumming"', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 8709 AND p.composer_id = 69
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:106a0457-a35c-47b8-931d-ec194c5148ee'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'Intermezzo "My Pretty Bess"', part.name_en = 'Five Tudors Portraits: II. Intermezzo "My Pretty Bess"',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 8709 AND p.composer_id = 69 AND part.part_key = 'musicbrainz:e2bd8460-8b50-4acb-9ad6-8f0182ae7eb5' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:e2bd8460-8b50-4acb-9ad6-8f0182ae7eb5', 2, 'II', 'Intermezzo "My Pretty Bess"', 'Five Tudors Portraits: II. Intermezzo "My Pretty Bess"', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 8709 AND p.composer_id = 69
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:e2bd8460-8b50-4acb-9ad6-8f0182ae7eb5'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = 'Burlesca "Epitaph on John Jayberd of Diss"', part.name_en = 'Five Tudors Portraits: III. Burlesca "Epitaph on John Jayberd of Diss"',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 8709 AND p.composer_id = 69 AND part.part_key = 'musicbrainz:43505d5d-7358-48c2-b6d7-745d424e8dd5' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:43505d5d-7358-48c2-b6d7-745d424e8dd5', 3, 'III', 'Burlesca "Epitaph on John Jayberd of Diss"', 'Five Tudors Portraits: III. Burlesca "Epitaph on John Jayberd of Diss"', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 8709 AND p.composer_id = 69
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:43505d5d-7358-48c2-b6d7-745d424e8dd5'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = 'IV',
    part.name_ko = 'Romanza "Jane Scoop (Her Lament for Philip Sparrow)"', part.name_en = 'Five Tudors Portraits: IV. Romanza "Jane Scoop (Her Lament for Philip Sparrow)"',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 8709 AND p.composer_id = 69 AND part.part_key = 'musicbrainz:c816cac2-a8f5-4a7c-91d0-910a6def3938' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:c816cac2-a8f5-4a7c-91d0-910a6def3938', 4, 'IV', 'Romanza "Jane Scoop (Her Lament for Philip Sparrow)"', 'Five Tudors Portraits: IV. Romanza "Jane Scoop (Her Lament for Philip Sparrow)"', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 8709 AND p.composer_id = 69
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:c816cac2-a8f5-4a7c-91d0-910a6def3938'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 5, part.movement_number = 'V',
    part.name_ko = 'Scherzo "Jolly Rutterkin"', part.name_en = 'Five Tudors Portraits: V. Scherzo "Jolly Rutterkin"',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 8709 AND p.composer_id = 69 AND part.part_key = 'musicbrainz:d1b519c8-ba0f-4a5e-b51e-fe6ae48a1707' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:d1b519c8-ba0f-4a5e-b51e-fe6ae48a1707', 5, 'V', 'Scherzo "Jolly Rutterkin"', 'Five Tudors Portraits: V. Scherzo "Jolly Rutterkin"', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 8709 AND p.composer_id = 69
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:d1b519c8-ba0f-4a5e-b51e-fe6ae48a1707'
);


-- None Flos campi

UPDATE pieces piece
SET piece.title = 'Flos campi', piece.title_en = 'Flos campi',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 8619 AND piece.composer_id = 69
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'Sicut lilium inter spinas (Lento)', part.name_en = 'Flos campi: I. Sicut lilium inter spinas (Lento)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 8619 AND p.composer_id = 69 AND part.part_key = 'musicbrainz:873e7e86-d8c9-3695-b0ef-c3c004c19115' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:873e7e86-d8c9-3695-b0ef-c3c004c19115', 1, 'I', 'Sicut lilium inter spinas (Lento)', 'Flos campi: I. Sicut lilium inter spinas (Lento)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 8619 AND p.composer_id = 69
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:873e7e86-d8c9-3695-b0ef-c3c004c19115'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'Jam enim hiems transiit (Andante con moto)', part.name_en = 'Flos campi: II. Jam enim hiems transiit (Andante con moto)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 8619 AND p.composer_id = 69 AND part.part_key = 'musicbrainz:16a065a4-ac9b-331a-9ea8-6fa59e6b77b6' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:16a065a4-ac9b-331a-9ea8-6fa59e6b77b6', 2, 'II', 'Jam enim hiems transiit (Andante con moto)', 'Flos campi: II. Jam enim hiems transiit (Andante con moto)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 8619 AND p.composer_id = 69
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:16a065a4-ac9b-331a-9ea8-6fa59e6b77b6'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = 'Quaesivi quem diligit anima mea (Lento - Allegro moderato)', part.name_en = 'Flos campi: III. Quaesivi quem diligit anima mea (Lento - Allegro moderato)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 8619 AND p.composer_id = 69 AND part.part_key = 'musicbrainz:5ac601ab-0bf7-319a-b2e2-7922abb6a7f3' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:5ac601ab-0bf7-319a-b2e2-7922abb6a7f3', 3, 'III', 'Quaesivi quem diligit anima mea (Lento - Allegro moderato)', 'Flos campi: III. Quaesivi quem diligit anima mea (Lento - Allegro moderato)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 8619 AND p.composer_id = 69
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:5ac601ab-0bf7-319a-b2e2-7922abb6a7f3'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = 'IV',
    part.name_ko = 'En lectulum Salomonis (Moderato alla marcia)', part.name_en = 'Flos campi: IV. En lectulum Salomonis (Moderato alla marcia)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 8619 AND p.composer_id = 69 AND part.part_key = 'musicbrainz:388d608a-7e9d-3bf1-aafb-db94e6129439' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:388d608a-7e9d-3bf1-aafb-db94e6129439', 4, 'IV', 'En lectulum Salomonis (Moderato alla marcia)', 'Flos campi: IV. En lectulum Salomonis (Moderato alla marcia)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 8619 AND p.composer_id = 69
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:388d608a-7e9d-3bf1-aafb-db94e6129439'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 5, part.movement_number = 'V',
    part.name_ko = 'Revertere, revertere Sulamitis! (Andante quasi lento)', part.name_en = 'Flos campi: V. Revertere, revertere Sulamitis! (Andante quasi lento)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 8619 AND p.composer_id = 69 AND part.part_key = 'musicbrainz:be86692b-2e2d-315d-b6c0-db7b653aa95e' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:be86692b-2e2d-315d-b6c0-db7b653aa95e', 5, 'V', 'Revertere, revertere Sulamitis! (Andante quasi lento)', 'Flos campi: V. Revertere, revertere Sulamitis! (Andante quasi lento)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 8619 AND p.composer_id = 69
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:be86692b-2e2d-315d-b6c0-db7b653aa95e'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 6, part.movement_number = 'VI',
    part.name_ko = 'Pone me ut signaculum (Moderato tranquillo)', part.name_en = 'Flos campi: VI. Pone me ut signaculum (Moderato tranquillo)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 8619 AND p.composer_id = 69 AND part.part_key = 'musicbrainz:e607bba8-e969-3b4c-b7b7-5e5d9b80e5b3' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:e607bba8-e969-3b4c-b7b7-5e5d9b80e5b3', 6, 'VI', 'Pone me ut signaculum (Moderato tranquillo)', 'Flos campi: VI. Pone me ut signaculum (Moderato tranquillo)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 8619 AND p.composer_id = 69
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:e607bba8-e969-3b4c-b7b7-5e5d9b80e5b3'
);


-- None Flourish for Wind Band

UPDATE pieces piece
SET piece.title = 'Flourish for Wind Band', piece.title_en = 'Flourish for Wind Band',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 10901 AND piece.composer_id = 69
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Folk Song Suite

UPDATE pieces piece
SET piece.title = 'Folk Song Suite', piece.title_en = 'Folk Song Suite',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 10919 AND piece.composer_id = 69
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Folk Songs of England, Book 5 "From Sussex"

UPDATE pieces piece
SET piece.title = 'Folk Songs of England, Book 5 "From Sussex"', piece.title_en = 'Folk Songs of England, Book 5 "From Sussex"',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 7882 AND piece.composer_id = 69
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'The Seeds of Love', part.name_en = 'The Seeds of Love',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 7882 AND p.composer_id = 69 AND part.part_key = 'musicbrainz:414bee7f-57e2-318a-9ada-3f59dff50616' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:414bee7f-57e2-318a-9ada-3f59dff50616', 1, NULL, 'The Seeds of Love', 'The Seeds of Love', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 7882 AND p.composer_id = 69
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:414bee7f-57e2-318a-9ada-3f59dff50616'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'Farewell, Lads', part.name_en = 'Folk Songs of England, Book 5 "From Sussex": No. 8, Farewell, Lads',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 7882 AND p.composer_id = 69 AND part.part_key = 'musicbrainz:7dcea74e-bbea-4c9b-aafe-1eca6d4582f4' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:7dcea74e-bbea-4c9b-aafe-1eca6d4582f4', 2, NULL, 'Farewell, Lads', 'Folk Songs of England, Book 5 "From Sussex": No. 8, Farewell, Lads', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 7882 AND p.composer_id = 69
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:7dcea74e-bbea-4c9b-aafe-1eca6d4582f4'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = NULL,
    part.name_ko = 'The Maid of Islington', part.name_en = 'Folk Songs of England, Book 5 "From Sussex": No. 12, The Maid of Islington',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 7882 AND p.composer_id = 69 AND part.part_key = 'musicbrainz:863ab660-5366-4336-a171-4a0d688723e9' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:863ab660-5366-4336-a171-4a0d688723e9', 3, NULL, 'The Maid of Islington', 'Folk Songs of England, Book 5 "From Sussex": No. 12, The Maid of Islington', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 7882 AND p.composer_id = 69
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:863ab660-5366-4336-a171-4a0d688723e9'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = NULL,
    part.name_ko = 'Come, All You Worthy Christians', part.name_en = 'Folk Songs of England, Book 5 "From Sussex": No. 9, Come, All You Worthy Christians',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 7882 AND p.composer_id = 69 AND part.part_key = 'musicbrainz:ac1b4550-14ee-4348-b424-3d9a3eea4012' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:ac1b4550-14ee-4348-b424-3d9a3eea4012', 4, NULL, 'Come, All You Worthy Christians', 'Folk Songs of England, Book 5 "From Sussex": No. 9, Come, All You Worthy Christians', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 7882 AND p.composer_id = 69
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:ac1b4550-14ee-4348-b424-3d9a3eea4012'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 5, part.movement_number = NULL,
    part.name_ko = 'Here’s Adieu to all Judges and Juries', part.name_en = 'Folk Songs of England, Book 5 "From Sussex": No. 13, Here’s Adieu to all Judges and Juries',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 7882 AND p.composer_id = 69 AND part.part_key = 'musicbrainz:b8e1d525-07a8-465e-b0a6-2606a36e49ad' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:b8e1d525-07a8-465e-b0a6-2606a36e49ad', 5, NULL, 'Here’s Adieu to all Judges and Juries', 'Folk Songs of England, Book 5 "From Sussex": No. 13, Here’s Adieu to all Judges and Juries', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 7882 AND p.composer_id = 69
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:b8e1d525-07a8-465e-b0a6-2606a36e49ad'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 6, part.movement_number = NULL,
    part.name_ko = 'The Turkish Lady', part.name_en = 'Folk Songs of England, Book 5 "From Sussex": No. 10, The Turkish Lady',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 7882 AND p.composer_id = 69 AND part.part_key = 'musicbrainz:c8a362c4-60dc-410b-ac11-eb468bd64f57' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:c8a362c4-60dc-410b-ac11-eb468bd64f57', 6, NULL, 'The Turkish Lady', 'Folk Songs of England, Book 5 "From Sussex": No. 10, The Turkish Lady', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 7882 AND p.composer_id = 69
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:c8a362c4-60dc-410b-ac11-eb468bd64f57'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 7, part.movement_number = NULL,
    part.name_ko = 'Captain Grant', part.name_en = 'Folk Songs of England, Book 5 "From Sussex": No. 7, Captain Grant',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 7882 AND p.composer_id = 69 AND part.part_key = 'musicbrainz:d1b2f6ad-284b-41c6-9ff8-754c5eb49a39' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:d1b2f6ad-284b-41c6-9ff8-754c5eb49a39', 7, NULL, 'Captain Grant', 'Folk Songs of England, Book 5 "From Sussex": No. 7, Captain Grant', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 7882 AND p.composer_id = 69
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:d1b2f6ad-284b-41c6-9ff8-754c5eb49a39'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 8, part.movement_number = NULL,
    part.name_ko = 'The Thresherman and the Squire', part.name_en = 'Folk Songs of England, Book 5 "From Sussex": No. 3, The Thresherman and the Squire',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 7882 AND p.composer_id = 69 AND part.part_key = 'musicbrainz:e7ac96d1-48e8-4bc1-a6cb-55ad73f1d22a' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:e7ac96d1-48e8-4bc1-a6cb-55ad73f1d22a', 8, NULL, 'The Thresherman and the Squire', 'Folk Songs of England, Book 5 "From Sussex": No. 3, The Thresherman and the Squire', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 7882 AND p.composer_id = 69
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:e7ac96d1-48e8-4bc1-a6cb-55ad73f1d22a'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 9, part.movement_number = NULL,
    part.name_ko = 'O Who Is That That Raps at My Window?', part.name_en = 'Folk Songs of England, Book 5 "From Sussex": No. 5, O Who Is That That Raps at My Window?',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 7882 AND p.composer_id = 69 AND part.part_key = 'musicbrainz:efa3eb76-dae9-4bcb-87ed-5fd3add32477' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:efa3eb76-dae9-4bcb-87ed-5fd3add32477', 9, NULL, 'O Who Is That That Raps at My Window?', 'Folk Songs of England, Book 5 "From Sussex": No. 5, O Who Is That That Raps at My Window?', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 7882 AND p.composer_id = 69
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:efa3eb76-dae9-4bcb-87ed-5fd3add32477'
);


-- None For All the Saints

UPDATE pieces piece
SET piece.title = 'For All the Saints', piece.title_en = 'For All the Saints',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 9367 AND piece.composer_id = 69
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None 4개의 찬가

UPDATE pieces piece
SET piece.title = '4개의 찬가', piece.title_en = 'Four Hymns',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 9361 AND piece.composer_id = 69
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'Lord, Come Away', part.name_en = 'Lord, Come Away',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 9361 AND p.composer_id = 69 AND part.part_key = 'musicbrainz:56e696e7-d10f-4568-9331-a5e61835b7bd' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:56e696e7-d10f-4568-9331-a5e61835b7bd', 1, NULL, 'Lord, Come Away', 'Lord, Come Away', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 9361 AND p.composer_id = 69
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:56e696e7-d10f-4568-9331-a5e61835b7bd'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'Who is this fair one?', part.name_en = 'Who is this fair one?',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 9361 AND p.composer_id = 69 AND part.part_key = 'musicbrainz:8f55d780-311c-4c4b-ab19-9bee77de4c0a' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:8f55d780-311c-4c4b-ab19-9bee77de4c0a', 2, NULL, 'Who is this fair one?', 'Who is this fair one?', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 9361 AND p.composer_id = 69
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:8f55d780-311c-4c4b-ab19-9bee77de4c0a'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = NULL,
    part.name_ko = 'Come Love, Come Lord', part.name_en = 'Come Love, Come Lord',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 9361 AND p.composer_id = 69 AND part.part_key = 'musicbrainz:6f055a1f-3cb7-4455-8c17-8c00600e3cb7' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:6f055a1f-3cb7-4455-8c17-8c00600e3cb7', 3, NULL, 'Come Love, Come Lord', 'Come Love, Come Lord', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 9361 AND p.composer_id = 69
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:6f055a1f-3cb7-4455-8c17-8c00600e3cb7'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = NULL,
    part.name_ko = 'Evening Hymn', part.name_en = 'Evening Hymn',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 9361 AND p.composer_id = 69 AND part.part_key = 'musicbrainz:e6456342-ca61-4fae-81ef-2c420cee3ea7' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:e6456342-ca61-4fae-81ef-2c420cee3ea7', 4, NULL, 'Evening Hymn', 'Evening Hymn', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 9361 AND p.composer_id = 69
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:e6456342-ca61-4fae-81ef-2c420cee3ea7'
);


-- None God Bless the Master of This House

UPDATE pieces piece
SET piece.title = 'God Bless the Master of This House', piece.title_en = 'God Bless the Master of This House',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 9551 AND piece.composer_id = 69
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None 가곡 <Hands, Eyes and Heart>

UPDATE pieces piece
SET piece.title = '가곡 <Hands, Eyes and Heart>', piece.title_en = 'Hands, Eyes and Heart',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 9830 AND piece.composer_id = 69
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Harnham Down

UPDATE pieces piece
SET piece.title = 'Harnham Down', piece.title_en = 'Harnham Down',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 9831 AND piece.composer_id = 69
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None He Who Would Valiant Be

UPDATE pieces piece
SET piece.title = 'He Who Would Valiant Be', piece.title_en = 'He Who Would Valiant Be',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 10376 AND piece.composer_id = 69
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None 가곡 <Heart's Music>

UPDATE pieces piece
SET piece.title = '가곡 <Heart''s Music>', piece.title_en = 'Heart''s Music',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 8336 AND piece.composer_id = 69
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Henry V

UPDATE pieces piece
SET piece.title = 'Henry V', piece.title_en = 'Henry V',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 10957 AND piece.composer_id = 69
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None 칸타타 <Hodie>

UPDATE pieces piece
SET piece.title = '칸타타 <Hodie>', piece.title_en = 'Hodie',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 8871 AND piece.composer_id = 69
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'Prologue: Nowell! Nowell!', part.name_en = 'Hodie: I. Prologue: Nowell! Nowell!',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 8871 AND p.composer_id = 69 AND part.part_key = 'musicbrainz:e134af5b-3a0a-4ae2-8251-e3d0d4005c2f' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:e134af5b-3a0a-4ae2-8251-e3d0d4005c2f', 1, 'I', 'Prologue: Nowell! Nowell!', 'Hodie: I. Prologue: Nowell! Nowell!', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 8871 AND p.composer_id = 69
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:e134af5b-3a0a-4ae2-8251-e3d0d4005c2f'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'Narration: Now the Birth of Jesus Christ', part.name_en = 'Hodie: II. Narration: Now the Birth of Jesus Christ',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 8871 AND p.composer_id = 69 AND part.part_key = 'musicbrainz:334dc832-1396-43be-b9d6-da9476dc9d35' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:334dc832-1396-43be-b9d6-da9476dc9d35', 2, 'II', 'Narration: Now the Birth of Jesus Christ', 'Hodie: II. Narration: Now the Birth of Jesus Christ', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 8871 AND p.composer_id = 69
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:334dc832-1396-43be-b9d6-da9476dc9d35'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = 'Song: It Was the Winter Wild', part.name_en = 'Hodie: III. Song: It Was the Winter Wild',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 8871 AND p.composer_id = 69 AND part.part_key = 'musicbrainz:54e97dd1-0e08-4c5c-876e-b6e8870f1a0a' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:54e97dd1-0e08-4c5c-876e-b6e8870f1a0a', 3, 'III', 'Song: It Was the Winter Wild', 'Hodie: III. Song: It Was the Winter Wild', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 8871 AND p.composer_id = 69
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:54e97dd1-0e08-4c5c-876e-b6e8870f1a0a'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = 'IV',
    part.name_ko = 'Narration: And It Came to Pass in Those Days', part.name_en = 'Hodie: IV. Narration: And It Came to Pass in Those Days',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 8871 AND p.composer_id = 69 AND part.part_key = 'musicbrainz:932d3ee3-9125-4301-b154-e07ace871572' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:932d3ee3-9125-4301-b154-e07ace871572', 4, 'IV', 'Narration: And It Came to Pass in Those Days', 'Hodie: IV. Narration: And It Came to Pass in Those Days', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 8871 AND p.composer_id = 69
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:932d3ee3-9125-4301-b154-e07ace871572'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 5, part.movement_number = 'V',
    part.name_ko = 'Choral: The Blessed Son of God', part.name_en = 'Hodie: V. Choral: The Blessed Son of God',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 8871 AND p.composer_id = 69 AND part.part_key = 'musicbrainz:fbb23b27-0f72-48d4-9a70-d3cdcfa8bc04' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:fbb23b27-0f72-48d4-9a70-d3cdcfa8bc04', 5, 'V', 'Choral: The Blessed Son of God', 'Hodie: V. Choral: The Blessed Son of God', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 8871 AND p.composer_id = 69
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:fbb23b27-0f72-48d4-9a70-d3cdcfa8bc04'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 6, part.movement_number = 'VI',
    part.name_ko = 'Narration: And There Were in the Same Country', part.name_en = 'Hodie: VI. Narration: And There Were in the Same Country',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 8871 AND p.composer_id = 69 AND part.part_key = 'musicbrainz:e7a73288-90e1-4d54-a20a-3010ac3173af' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:e7a73288-90e1-4d54-a20a-3010ac3173af', 6, 'VI', 'Narration: And There Were in the Same Country', 'Hodie: VI. Narration: And There Were in the Same Country', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 8871 AND p.composer_id = 69
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:e7a73288-90e1-4d54-a20a-3010ac3173af'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 7, part.movement_number = 'VII',
    part.name_ko = 'Song: The Oxen (Christmas Eve, and Twelve of the Clock)', part.name_en = 'Hodie: VII. Song: The Oxen (Christmas Eve, and Twelve of the Clock)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 8871 AND p.composer_id = 69 AND part.part_key = 'musicbrainz:0883ebe6-6530-48e6-b85b-9e524f310c01' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:0883ebe6-6530-48e6-b85b-9e524f310c01', 7, 'VII', 'Song: The Oxen (Christmas Eve, and Twelve of the Clock)', 'Hodie: VII. Song: The Oxen (Christmas Eve, and Twelve of the Clock)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 8871 AND p.composer_id = 69
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:0883ebe6-6530-48e6-b85b-9e524f310c01'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 8, part.movement_number = 'VIII',
    part.name_ko = 'Narration: And the Shepherds Returned', part.name_en = 'Hodie: VIII. Narration: And the Shepherds Returned',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 8871 AND p.composer_id = 69 AND part.part_key = 'musicbrainz:0ea2ac06-0b9b-48d8-9442-0271c3c95089' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:0ea2ac06-0b9b-48d8-9442-0271c3c95089', 8, 'VIII', 'Narration: And the Shepherds Returned', 'Hodie: VIII. Narration: And the Shepherds Returned', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 8871 AND p.composer_id = 69
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:0ea2ac06-0b9b-48d8-9442-0271c3c95089'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 9, part.movement_number = 'IX',
    part.name_ko = 'Pastoral: The Shepherds Sing', part.name_en = 'Hodie: IX. Pastoral: The Shepherds Sing',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 8871 AND p.composer_id = 69 AND part.part_key = 'musicbrainz:48c82792-d0f2-45f2-904e-939d2772fcd3' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:48c82792-d0f2-45f2-904e-939d2772fcd3', 9, 'IX', 'Pastoral: The Shepherds Sing', 'Hodie: IX. Pastoral: The Shepherds Sing', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 8871 AND p.composer_id = 69
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:48c82792-d0f2-45f2-904e-939d2772fcd3'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 10, part.movement_number = 'X',
    part.name_ko = 'Narration: But Mary Kept All These Things', part.name_en = 'Hodie: X. Narration: But Mary Kept All These Things',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 8871 AND p.composer_id = 69 AND part.part_key = 'musicbrainz:2106af7a-1c2a-4f9b-8bb5-db39bf618b97' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:2106af7a-1c2a-4f9b-8bb5-db39bf618b97', 10, 'X', 'Narration: But Mary Kept All These Things', 'Hodie: X. Narration: But Mary Kept All These Things', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 8871 AND p.composer_id = 69
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:2106af7a-1c2a-4f9b-8bb5-db39bf618b97'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 11, part.movement_number = 'XI',
    part.name_ko = 'Lullaby: Sweet Was the Song the Virgin Sang', part.name_en = 'Hodie: XI. Lullaby: Sweet Was the Song the Virgin Sang',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 8871 AND p.composer_id = 69 AND part.part_key = 'musicbrainz:795871a6-9912-45e8-becd-402bb8d09a2d' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:795871a6-9912-45e8-becd-402bb8d09a2d', 11, 'XI', 'Lullaby: Sweet Was the Song the Virgin Sang', 'Hodie: XI. Lullaby: Sweet Was the Song the Virgin Sang', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 8871 AND p.composer_id = 69
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:795871a6-9912-45e8-becd-402bb8d09a2d'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 12, part.movement_number = 'XII',
    part.name_ko = 'Hymn: Bright Portals of the Sky', part.name_en = 'Hodie: XII. Hymn: Bright Portals of the Sky',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 8871 AND p.composer_id = 69 AND part.part_key = 'musicbrainz:6327a001-9ed6-403b-9911-3f1089feda43' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:6327a001-9ed6-403b-9911-3f1089feda43', 12, 'XII', 'Hymn: Bright Portals of the Sky', 'Hodie: XII. Hymn: Bright Portals of the Sky', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 8871 AND p.composer_id = 69
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:6327a001-9ed6-403b-9911-3f1089feda43'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 13, part.movement_number = 'XIII',
    part.name_ko = 'Narration: Now When Jesus Was Born', part.name_en = 'Hodie: XIII. Narration: Now When Jesus Was Born',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 8871 AND p.composer_id = 69 AND part.part_key = 'musicbrainz:ff54d0df-fde3-4c35-8e74-c63017d3cbaa' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:ff54d0df-fde3-4c35-8e74-c63017d3cbaa', 13, 'XIII', 'Narration: Now When Jesus Was Born', 'Hodie: XIII. Narration: Now When Jesus Was Born', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 8871 AND p.composer_id = 69
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:ff54d0df-fde3-4c35-8e74-c63017d3cbaa'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 14, part.movement_number = 'XIV',
    part.name_ko = 'The March of the Three Kings: From Kingdoms of Wisdom', part.name_en = 'Hodie: XIV. The March of the Three Kings: From Kingdoms of Wisdom',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 8871 AND p.composer_id = 69 AND part.part_key = 'musicbrainz:f02865c7-6c32-466c-8ec9-4389f65ae4c3' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:f02865c7-6c32-466c-8ec9-4389f65ae4c3', 14, 'XIV', 'The March of the Three Kings: From Kingdoms of Wisdom', 'Hodie: XIV. The March of the Three Kings: From Kingdoms of Wisdom', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 8871 AND p.composer_id = 69
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:f02865c7-6c32-466c-8ec9-4389f65ae4c3'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 15, part.movement_number = 'XV',
    part.name_ko = 'Choral: No Sad Thought His Soul Affright', part.name_en = 'Hodie: XV. Choral: No Sad Thought His Soul Affright',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 8871 AND p.composer_id = 69 AND part.part_key = 'musicbrainz:c7ca869d-6642-4592-afc2-c9452a0946ed' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:c7ca869d-6642-4592-afc2-c9452a0946ed', 15, 'XV', 'Choral: No Sad Thought His Soul Affright', 'Hodie: XV. Choral: No Sad Thought His Soul Affright', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 8871 AND p.composer_id = 69
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:c7ca869d-6642-4592-afc2-c9452a0946ed'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 16, part.movement_number = 'XVI',
    part.name_ko = 'Epilogue: In the Beginning Was the Word', part.name_en = 'Hodie: XVI. Epilogue: In the Beginning Was the Word',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 8871 AND p.composer_id = 69 AND part.part_key = 'musicbrainz:1edfc4bc-f8c5-40cc-bb34-e0a3b9588016' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:1edfc4bc-f8c5-40cc-bb34-e0a3b9588016', 16, 'XVI', 'Epilogue: In the Beginning Was the Word', 'Hodie: XVI. Epilogue: In the Beginning Was the Word', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 8871 AND p.composer_id = 69
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:1edfc4bc-f8c5-40cc-bb34-e0a3b9588016'
);


-- None Household Music

UPDATE pieces piece
SET piece.title = 'Household Music', piece.title_en = 'Household Music',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 8825 AND piece.composer_id = 69
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'Crug-Y-Bar. Fantasia', part.name_en = 'Household Music: I. Crug-Y-Bar. Fantasia',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 8825 AND p.composer_id = 69 AND part.part_key = 'musicbrainz:13298edf-91e5-4f26-a0ea-1e473314477f' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:13298edf-91e5-4f26-a0ea-1e473314477f', 1, 'I', 'Crug-Y-Bar. Fantasia', 'Household Music: I. Crug-Y-Bar. Fantasia', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 8825 AND p.composer_id = 69
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:13298edf-91e5-4f26-a0ea-1e473314477f'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'St. Denio. Scherzo', part.name_en = 'Household Music: II. St. Denio. Scherzo',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 8825 AND p.composer_id = 69 AND part.part_key = 'musicbrainz:cb40a034-eb29-4776-9e8e-6012301305b0' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:cb40a034-eb29-4776-9e8e-6012301305b0', 2, 'II', 'St. Denio. Scherzo', 'Household Music: II. St. Denio. Scherzo', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 8825 AND p.composer_id = 69
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:cb40a034-eb29-4776-9e8e-6012301305b0'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = 'Aberystwyth. Variations', part.name_en = 'Household Music: III. Aberystwyth. Variations',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 8825 AND p.composer_id = 69 AND part.part_key = 'musicbrainz:72e6c165-7473-4f99-a5e8-b341d98cdf9d' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:72e6c165-7473-4f99-a5e8-b341d98cdf9d', 3, 'III', 'Aberystwyth. Variations', 'Household Music: III. Aberystwyth. Variations', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 8825 AND p.composer_id = 69
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:72e6c165-7473-4f99-a5e8-b341d98cdf9d'
);


-- None 오페라 <Hugh the Drover>

UPDATE pieces piece
SET piece.title = '오페라 <Hugh the Drover>', piece.title_en = 'Hugh the Drover',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 9156 AND piece.composer_id = 69
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'Act II', part.name_en = 'Hugh the Drover: Act II.',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 9156 AND p.composer_id = 69 AND part.part_key = 'musicbrainz:1f9769b1-a06a-4e44-932d-2991aba043d5' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:1f9769b1-a06a-4e44-932d-2991aba043d5', 1, NULL, 'Act II', 'Hugh the Drover: Act II.', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 9156 AND p.composer_id = 69
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:1f9769b1-a06a-4e44-932d-2991aba043d5'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:1f9769b1-a06a-4e44-932d-2991aba043d5'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'Act II, I. Past four o''clock', part.name_en = 'Hugh the Drover: Act II, I. Past four o''clock',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 9156 AND p.composer_id = 69 AND part.part_key = 'musicbrainz:d562485e-f0fa-4b34-92f7-0e390592e897' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:d562485e-f0fa-4b34-92f7-0e390592e897', 1, NULL, 'Act II, I. Past four o''clock', 'Hugh the Drover: Act II, I. Past four o''clock', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:1f9769b1-a06a-4e44-932d-2991aba043d5'
WHERE p.id = 9156 AND p.composer_id = 69
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:d562485e-f0fa-4b34-92f7-0e390592e897'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:1f9769b1-a06a-4e44-932d-2991aba043d5'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'Act II, II. Gaily I go to die', part.name_en = 'Hugh the Drover: Act II, II. Gaily I go to die',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 9156 AND p.composer_id = 69 AND part.part_key = 'musicbrainz:d970700d-793c-405d-a78b-eb4af6b7422a' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:d970700d-793c-405d-a78b-eb4af6b7422a', 2, NULL, 'Act II, II. Gaily I go to die', 'Hugh the Drover: Act II, II. Gaily I go to die', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:1f9769b1-a06a-4e44-932d-2991aba043d5'
WHERE p.id = 9156 AND p.composer_id = 69
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:d970700d-793c-405d-a78b-eb4af6b7422a'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:1f9769b1-a06a-4e44-932d-2991aba043d5'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = NULL,
    part.name_ko = 'Act II, III. Hugh!...Mary!', part.name_en = 'Hugh the Drover: Act II, III. Hugh!...Mary!',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 9156 AND p.composer_id = 69 AND part.part_key = 'musicbrainz:6c99cf2c-1466-4e46-872f-7ae595a8ac17' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:6c99cf2c-1466-4e46-872f-7ae595a8ac17', 3, NULL, 'Act II, III. Hugh!...Mary!', 'Hugh the Drover: Act II, III. Hugh!...Mary!', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:1f9769b1-a06a-4e44-932d-2991aba043d5'
WHERE p.id = 9156 AND p.composer_id = 69
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:6c99cf2c-1466-4e46-872f-7ae595a8ac17'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:1f9769b1-a06a-4e44-932d-2991aba043d5'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = NULL,
    part.name_ko = 'Act II, IV. Sweet little home', part.name_en = 'Hugh the Drover: Act II, IV. Sweet little home',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 9156 AND p.composer_id = 69 AND part.part_key = 'musicbrainz:9acfd741-ffe3-424b-b8b1-727ab2cc49a1' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:9acfd741-ffe3-424b-b8b1-727ab2cc49a1', 4, NULL, 'Act II, IV. Sweet little home', 'Hugh the Drover: Act II, IV. Sweet little home', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:1f9769b1-a06a-4e44-932d-2991aba043d5'
WHERE p.id = 9156 AND p.composer_id = 69
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:9acfd741-ffe3-424b-b8b1-727ab2cc49a1'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:1f9769b1-a06a-4e44-932d-2991aba043d5'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 5, part.movement_number = NULL,
    part.name_ko = 'Act II, V. Where''s she gone to?', part.name_en = 'Hugh the Drover: Act II, V. Where''s she gone to?',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 9156 AND p.composer_id = 69 AND part.part_key = 'musicbrainz:0bdf5073-9243-4dea-acde-e64cf1753422' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:0bdf5073-9243-4dea-acde-e64cf1753422', 5, NULL, 'Act II, V. Where''s she gone to?', 'Hugh the Drover: Act II, V. Where''s she gone to?', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:1f9769b1-a06a-4e44-932d-2991aba043d5'
WHERE p.id = 9156 AND p.composer_id = 69
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:0bdf5073-9243-4dea-acde-e64cf1753422'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:1f9769b1-a06a-4e44-932d-2991aba043d5'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 6, part.movement_number = NULL,
    part.name_ko = 'Act II, VI. Here, queen uncrowned', part.name_en = 'Hugh the Drover: Act II, VI. Here, queen uncrowned',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 9156 AND p.composer_id = 69 AND part.part_key = 'musicbrainz:0d7cb2c2-41a7-4710-8b3e-ea44caca19b0' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:0d7cb2c2-41a7-4710-8b3e-ea44caca19b0', 6, NULL, 'Act II, VI. Here, queen uncrowned', 'Hugh the Drover: Act II, VI. Here, queen uncrowned', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:1f9769b1-a06a-4e44-932d-2991aba043d5'
WHERE p.id = 9156 AND p.composer_id = 69
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:0d7cb2c2-41a7-4710-8b3e-ea44caca19b0'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:1f9769b1-a06a-4e44-932d-2991aba043d5'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 7, part.movement_number = NULL,
    part.name_ko = 'Act II, VII. A trollop from the stocks', part.name_en = 'Hugh the Drover: Act II, VII. A trollop from the stocks',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 9156 AND p.composer_id = 69 AND part.part_key = 'musicbrainz:86bd4391-3105-4cf9-920c-8e8a1d6302b2' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:86bd4391-3105-4cf9-920c-8e8a1d6302b2', 7, NULL, 'Act II, VII. A trollop from the stocks', 'Hugh the Drover: Act II, VII. A trollop from the stocks', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:1f9769b1-a06a-4e44-932d-2991aba043d5'
WHERE p.id = 9156 AND p.composer_id = 69
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:86bd4391-3105-4cf9-920c-8e8a1d6302b2'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:1f9769b1-a06a-4e44-932d-2991aba043d5'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 8, part.movement_number = NULL,
    part.name_ko = 'Act II, VIII. Dropped from the ranks on a winter''s night', part.name_en = 'Hugh the Drover: Act II, VIII. Dropped from the ranks on a winter''s night',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 9156 AND p.composer_id = 69 AND part.part_key = 'musicbrainz:1af93ce5-ca0a-4432-abaa-1a01ac5f848b' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:1af93ce5-ca0a-4432-abaa-1a01ac5f848b', 8, NULL, 'Act II, VIII. Dropped from the ranks on a winter''s night', 'Hugh the Drover: Act II, VIII. Dropped from the ranks on a winter''s night', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:1f9769b1-a06a-4e44-932d-2991aba043d5'
WHERE p.id = 9156 AND p.composer_id = 69
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:1af93ce5-ca0a-4432-abaa-1a01ac5f848b'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:1f9769b1-a06a-4e44-932d-2991aba043d5'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 9, part.movement_number = NULL,
    part.name_ko = 'Act II, IX. March away, John!', part.name_en = 'Hugh the Drover: Act II, IX. March away, John!',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 9156 AND p.composer_id = 69 AND part.part_key = 'musicbrainz:bacac182-c50d-4c7a-b1ea-a112b7a0f311' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:bacac182-c50d-4c7a-b1ea-a112b7a0f311', 9, NULL, 'Act II, IX. March away, John!', 'Hugh the Drover: Act II, IX. March away, John!', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:1f9769b1-a06a-4e44-932d-2991aba043d5'
WHERE p.id = 9156 AND p.composer_id = 69
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:bacac182-c50d-4c7a-b1ea-a112b7a0f311'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:1f9769b1-a06a-4e44-932d-2991aba043d5'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 10, part.movement_number = NULL,
    part.name_ko = 'Act II, X. O foolish girl, O radiant soul!', part.name_en = 'Hugh the Drover: Act II, X. O foolish girl, O radiant soul!',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 9156 AND p.composer_id = 69 AND part.part_key = 'musicbrainz:faf58ad2-c1d3-4a8d-800c-14a992539a68' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:faf58ad2-c1d3-4a8d-800c-14a992539a68', 10, NULL, 'Act II, X. O foolish girl, O radiant soul!', 'Hugh the Drover: Act II, X. O foolish girl, O radiant soul!', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:1f9769b1-a06a-4e44-932d-2991aba043d5'
WHERE p.id = 9156 AND p.composer_id = 69
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:faf58ad2-c1d3-4a8d-800c-14a992539a68'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:1f9769b1-a06a-4e44-932d-2991aba043d5'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 11, part.movement_number = NULL,
    part.name_ko = 'Act II, XI. Oh! the sky shall be our roof', part.name_en = 'Hugh the Drover: Act II, XI. Oh! the sky shall be our roof',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 9156 AND p.composer_id = 69 AND part.part_key = 'musicbrainz:e78f7764-a92a-405c-a748-9b8581dca8b2' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:e78f7764-a92a-405c-a748-9b8581dca8b2', 11, NULL, 'Act II, XI. Oh! the sky shall be our roof', 'Hugh the Drover: Act II, XI. Oh! the sky shall be our roof', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:1f9769b1-a06a-4e44-932d-2991aba043d5'
WHERE p.id = 9156 AND p.composer_id = 69
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:e78f7764-a92a-405c-a748-9b8581dca8b2'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'Act I', part.name_en = 'Hugh the Drover: Act I.',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 9156 AND p.composer_id = 69 AND part.part_key = 'musicbrainz:61be66d8-7f22-4974-bd20-378de1828997' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:61be66d8-7f22-4974-bd20-378de1828997', 2, NULL, 'Act I', 'Hugh the Drover: Act I.', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 9156 AND p.composer_id = 69
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:61be66d8-7f22-4974-bd20-378de1828997'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:61be66d8-7f22-4974-bd20-378de1828997'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'Act I, I. Buy, buy, buy', part.name_en = 'Hugh the Drover: Act I, I. Buy, buy, buy',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 9156 AND p.composer_id = 69 AND part.part_key = 'musicbrainz:5f0b7572-1ee0-4050-a480-a10e107b343c' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:5f0b7572-1ee0-4050-a480-a10e107b343c', 1, NULL, 'Act I, I. Buy, buy, buy', 'Hugh the Drover: Act I, I. Buy, buy, buy', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:61be66d8-7f22-4974-bd20-378de1828997'
WHERE p.id = 9156 AND p.composer_id = 69
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:5f0b7572-1ee0-4050-a480-a10e107b343c'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:61be66d8-7f22-4974-bd20-378de1828997'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'Act I, II. Cold blows the wind on Cotsall', part.name_en = 'Hugh the Drover: Act I, II. Cold blows the wind on Cotsall',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 9156 AND p.composer_id = 69 AND part.part_key = 'musicbrainz:3755366a-c22f-4e5b-af2b-7ffcc1510226' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:3755366a-c22f-4e5b-af2b-7ffcc1510226', 2, NULL, 'Act I, II. Cold blows the wind on Cotsall', 'Hugh the Drover: Act I, II. Cold blows the wind on Cotsall', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:61be66d8-7f22-4974-bd20-378de1828997'
WHERE p.id = 9156 AND p.composer_id = 69
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:3755366a-c22f-4e5b-af2b-7ffcc1510226'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:61be66d8-7f22-4974-bd20-378de1828997'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = NULL,
    part.name_ko = 'Act I, III. As I was a-walking', part.name_en = 'Hugh the Drover: Act I, III. As I was a-walking',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 9156 AND p.composer_id = 69 AND part.part_key = 'musicbrainz:8bd2c031-5a1b-400c-9d42-06678c79a0b1' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:8bd2c031-5a1b-400c-9d42-06678c79a0b1', 3, NULL, 'Act I, III. As I was a-walking', 'Hugh the Drover: Act I, III. As I was a-walking', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:61be66d8-7f22-4974-bd20-378de1828997'
WHERE p.id = 9156 AND p.composer_id = 69
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:8bd2c031-5a1b-400c-9d42-06678c79a0b1'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:61be66d8-7f22-4974-bd20-378de1828997'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = NULL,
    part.name_ko = 'Act I, IV. Show me a richer man', part.name_en = 'Hugh the Drover: Act I, IV. Show me a richer man',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 9156 AND p.composer_id = 69 AND part.part_key = 'musicbrainz:d5fa0ecc-6671-47d1-9076-8d1f848e5f4f' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:d5fa0ecc-6671-47d1-9076-8d1f848e5f4f', 4, NULL, 'Act I, IV. Show me a richer man', 'Hugh the Drover: Act I, IV. Show me a richer man', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:61be66d8-7f22-4974-bd20-378de1828997'
WHERE p.id = 9156 AND p.composer_id = 69
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:d5fa0ecc-6671-47d1-9076-8d1f848e5f4f'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:61be66d8-7f22-4974-bd20-378de1828997'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 5, part.movement_number = NULL,
    part.name_ko = 'Act I, V. Here come the Morris men', part.name_en = 'Hugh the Drover: Act I, V. Here come the Morris men',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 9156 AND p.composer_id = 69 AND part.part_key = 'musicbrainz:9aaa3025-87f5-4d33-91bc-8eb4d06a23c4' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:9aaa3025-87f5-4d33-91bc-8eb4d06a23c4', 5, NULL, 'Act I, V. Here come the Morris men', 'Hugh the Drover: Act I, V. Here come the Morris men', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:61be66d8-7f22-4974-bd20-378de1828997'
WHERE p.id = 9156 AND p.composer_id = 69
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:9aaa3025-87f5-4d33-91bc-8eb4d06a23c4'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:61be66d8-7f22-4974-bd20-378de1828997'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 6, part.movement_number = NULL,
    part.name_ko = 'Act I, VI. Life must be full of care', part.name_en = 'Hugh the Drover: Act I, VI. Life must be full of care',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 9156 AND p.composer_id = 69 AND part.part_key = 'musicbrainz:721948aa-2335-4374-a08f-0bf7810dbb3f' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:721948aa-2335-4374-a08f-0bf7810dbb3f', 6, NULL, 'Act I, VI. Life must be full of care', 'Hugh the Drover: Act I, VI. Life must be full of care', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:61be66d8-7f22-4974-bd20-378de1828997'
WHERE p.id = 9156 AND p.composer_id = 69
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:721948aa-2335-4374-a08f-0bf7810dbb3f'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:61be66d8-7f22-4974-bd20-378de1828997'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 7, part.movement_number = NULL,
    part.name_ko = 'Act I, VII. Sweet little linnet that longs to be free', part.name_en = 'Hugh the Drover: Act I, VII. Sweet little linnet that longs to be free',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 9156 AND p.composer_id = 69 AND part.part_key = 'musicbrainz:bd2449db-6f1f-4afe-b13d-95d1ff36ac77' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:bd2449db-6f1f-4afe-b13d-95d1ff36ac77', 7, NULL, 'Act I, VII. Sweet little linnet that longs to be free', 'Hugh the Drover: Act I, VII. Sweet little linnet that longs to be free', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:61be66d8-7f22-4974-bd20-378de1828997'
WHERE p.id = 9156 AND p.composer_id = 69
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:bd2449db-6f1f-4afe-b13d-95d1ff36ac77'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:61be66d8-7f22-4974-bd20-378de1828997'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 8, part.movement_number = NULL,
    part.name_ko = 'Act I, VIII. “Horse-hoofs thunder down the valley”', part.name_en = 'Hugh the Drover: Act I, VIII. “Horse-hoofs thunder down the valley”',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 9156 AND p.composer_id = 69 AND part.part_key = 'musicbrainz:f1c62724-056d-4cd2-8406-23546ec91f77' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:f1c62724-056d-4cd2-8406-23546ec91f77', 8, NULL, 'Act I, VIII. “Horse-hoofs thunder down the valley”', 'Hugh the Drover: Act I, VIII. “Horse-hoofs thunder down the valley”', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:61be66d8-7f22-4974-bd20-378de1828997'
WHERE p.id = 9156 AND p.composer_id = 69
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:f1c62724-056d-4cd2-8406-23546ec91f77'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:61be66d8-7f22-4974-bd20-378de1828997'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 9, part.movement_number = NULL,
    part.name_ko = 'Act I, IX. In the night-time I have seen you riding', part.name_en = 'Hugh the Drover: Act I, IX. In the night-time I have seen you riding',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 9156 AND p.composer_id = 69 AND part.part_key = 'musicbrainz:717c894c-88c7-425d-a5ae-e2e669a88755' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:717c894c-88c7-425d-a5ae-e2e669a88755', 9, NULL, 'Act I, IX. In the night-time I have seen you riding', 'Hugh the Drover: Act I, IX. In the night-time I have seen you riding', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:61be66d8-7f22-4974-bd20-378de1828997'
WHERE p.id = 9156 AND p.composer_id = 69
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:717c894c-88c7-425d-a5ae-e2e669a88755'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:61be66d8-7f22-4974-bd20-378de1828997'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 10, part.movement_number = NULL,
    part.name_ko = 'Act I, X. Mary! Mary!', part.name_en = 'Hugh the Drover: Act I, X. Mary! Mary!',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 9156 AND p.composer_id = 69 AND part.part_key = 'musicbrainz:ee020a46-499b-4925-922d-9c989e06e005' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:ee020a46-499b-4925-922d-9c989e06e005', 10, NULL, 'Act I, X. Mary! Mary!', 'Hugh the Drover: Act I, X. Mary! Mary!', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:61be66d8-7f22-4974-bd20-378de1828997'
WHERE p.id = 9156 AND p.composer_id = 69
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:ee020a46-499b-4925-922d-9c989e06e005'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:61be66d8-7f22-4974-bd20-378de1828997'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 11, part.movement_number = NULL,
    part.name_ko = 'Act I, XI. Oh! The devil and Bonyparty', part.name_en = 'Hugh the Drover: Act I, XI. Oh! The devil and Bonyparty',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 9156 AND p.composer_id = 69 AND part.part_key = 'musicbrainz:19ec115b-f0e7-4d32-b13b-216eb413e996' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:19ec115b-f0e7-4d32-b13b-216eb413e996', 11, NULL, 'Act I, XI. Oh! The devil and Bonyparty', 'Hugh the Drover: Act I, XI. Oh! The devil and Bonyparty', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:61be66d8-7f22-4974-bd20-378de1828997'
WHERE p.id = 9156 AND p.composer_id = 69
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:19ec115b-f0e7-4d32-b13b-216eb413e996'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:61be66d8-7f22-4974-bd20-378de1828997'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 12, part.movement_number = NULL,
    part.name_ko = 'Act I, XII. Yes, I!', part.name_en = 'Hugh the Drover: Act I, XII. Yes, I!',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 9156 AND p.composer_id = 69 AND part.part_key = 'musicbrainz:c30bd744-8e0f-43fe-aa36-ab66b5d90529' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:c30bd744-8e0f-43fe-aa36-ab66b5d90529', 12, NULL, 'Act I, XII. Yes, I!', 'Hugh the Drover: Act I, XII. Yes, I!', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:61be66d8-7f22-4974-bd20-378de1828997'
WHERE p.id = 9156 AND p.composer_id = 69
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:c30bd744-8e0f-43fe-aa36-ab66b5d90529'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:61be66d8-7f22-4974-bd20-378de1828997'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 13, part.movement_number = NULL,
    part.name_ko = 'Act I, XIII. Are you ready? Go!', part.name_en = 'Hugh the Drover: Act I, XIII. Are you ready? Go!',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 9156 AND p.composer_id = 69 AND part.part_key = 'musicbrainz:b01ac2d5-2e15-48e5-b144-42e7730da1ca' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:b01ac2d5-2e15-48e5-b144-42e7730da1ca', 13, NULL, 'Act I, XIII. Are you ready? Go!', 'Hugh the Drover: Act I, XIII. Are you ready? Go!', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:61be66d8-7f22-4974-bd20-378de1828997'
WHERE p.id = 9156 AND p.composer_id = 69
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:b01ac2d5-2e15-48e5-b144-42e7730da1ca'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:61be66d8-7f22-4974-bd20-378de1828997'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 14, part.movement_number = NULL,
    part.name_ko = 'Act I, XIV. The drover''s won!', part.name_en = 'Hugh the Drover: Act I, XIV. The drover''s won!',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 9156 AND p.composer_id = 69 AND part.part_key = 'musicbrainz:19e16f02-6fcc-4454-978d-c836c4ee7add' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:19e16f02-6fcc-4454-978d-c836c4ee7add', 14, NULL, 'Act I, XIV. The drover''s won!', 'Hugh the Drover: Act I, XIV. The drover''s won!', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:61be66d8-7f22-4974-bd20-378de1828997'
WHERE p.id = 9156 AND p.composer_id = 69
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:19e16f02-6fcc-4454-978d-c836c4ee7add'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:61be66d8-7f22-4974-bd20-378de1828997'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 15, part.movement_number = NULL,
    part.name_ko = 'Act I, XV. I tell you there''s a price on this man''s head', part.name_en = 'Hugh the Drover: Act I, XV. I tell you there''s a price on this man''s head',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 9156 AND p.composer_id = 69 AND part.part_key = 'musicbrainz:417322d9-5d6c-4cd0-bd4c-767e95602a9d' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:417322d9-5d6c-4cd0-bd4c-767e95602a9d', 15, NULL, 'Act I, XV. I tell you there''s a price on this man''s head', 'Hugh the Drover: Act I, XV. I tell you there''s a price on this man''s head', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:61be66d8-7f22-4974-bd20-378de1828997'
WHERE p.id = 9156 AND p.composer_id = 69
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:417322d9-5d6c-4cd0-bd4c-767e95602a9d'
);


-- None Hymn for St. Margaret of Scotland

UPDATE pieces piece
SET piece.title = 'Hymn for St. Margaret of Scotland', piece.title_en = 'Hymn for St. Margaret of Scotland',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 8023 AND piece.composer_id = 69
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None 가곡 <If I Were a Queen>

UPDATE pieces piece
SET piece.title = '가곡 <If I Were a Queen>', piece.title_en = 'If I Were a Queen',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 7726 AND piece.composer_id = 69
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None In Windsor Forest

UPDATE pieces piece
SET piece.title = 'In Windsor Forest', piece.title_en = 'In Windsor Forest',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 9146 AND piece.composer_id = 69
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'The Conspiracy', part.name_en = 'In Windsor Forest: I. The Conspiracy',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 9146 AND p.composer_id = 69 AND part.part_key = 'musicbrainz:6e8b49db-63d5-4107-a765-c1958008ed69' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:6e8b49db-63d5-4107-a765-c1958008ed69', 1, 'I', 'The Conspiracy', 'In Windsor Forest: I. The Conspiracy', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 9146 AND p.composer_id = 69
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:6e8b49db-63d5-4107-a765-c1958008ed69'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'Drinking Song', part.name_en = 'In Windsor Forest: II. Drinking Song',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 9146 AND p.composer_id = 69 AND part.part_key = 'musicbrainz:1b3c87cb-4252-4313-9961-07842b6b0a4b' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:1b3c87cb-4252-4313-9961-07842b6b0a4b', 2, 'II', 'Drinking Song', 'In Windsor Forest: II. Drinking Song', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 9146 AND p.composer_id = 69
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:1b3c87cb-4252-4313-9961-07842b6b0a4b'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = 'Falstaff and the Fairies', part.name_en = 'In Windsor Forest: III. Falstaff and the Fairies',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 9146 AND p.composer_id = 69 AND part.part_key = 'musicbrainz:8aec2553-0ed0-4393-a02b-ca78cefd0750' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:8aec2553-0ed0-4393-a02b-ca78cefd0750', 3, 'III', 'Falstaff and the Fairies', 'In Windsor Forest: III. Falstaff and the Fairies', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 9146 AND p.composer_id = 69
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:8aec2553-0ed0-4393-a02b-ca78cefd0750'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = 'IV',
    part.name_ko = 'Wedding Chorus', part.name_en = 'In Windsor Forest: IV. Wedding Chorus',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 9146 AND p.composer_id = 69 AND part.part_key = 'musicbrainz:75ddfab0-c191-47aa-b36c-2a374efe8ee0' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:75ddfab0-c191-47aa-b36c-2a374efe8ee0', 4, 'IV', 'Wedding Chorus', 'In Windsor Forest: IV. Wedding Chorus', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 9146 AND p.composer_id = 69
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:75ddfab0-c191-47aa-b36c-2a374efe8ee0'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 5, part.movement_number = 'V',
    part.name_ko = 'Epilogue', part.name_en = 'In Windsor Forest: V. Epilogue',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 9146 AND p.composer_id = 69 AND part.part_key = 'musicbrainz:af9fe9d3-37b1-4310-8ce4-7cca7b496a90' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:af9fe9d3-37b1-4310-8ce4-7cca7b496a90', 5, 'V', 'Epilogue', 'In Windsor Forest: V. Epilogue', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 9146 AND p.composer_id = 69
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:af9fe9d3-37b1-4310-8ce4-7cca7b496a90'
);


-- None In the Fen Country

UPDATE pieces piece
SET piece.title = 'In the Fen Country', piece.title_en = 'In the Fen Country',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 11248 AND piece.composer_id = 69
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None 가곡 <In the Spring>

UPDATE pieces piece
SET piece.title = '가곡 <In the Spring>', piece.title_en = 'In the Spring',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 10138 AND piece.composer_id = 69
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None 부수음악 <Incidental Music to The Mayor of Casterbridge>

UPDATE pieces piece
SET piece.title = '부수음악 <Incidental Music to The Mayor of Casterbridge>', piece.title_en = 'Incidental Music to The Mayor of Casterbridge',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 11188 AND piece.composer_id = 69
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Introduction and Fugue

UPDATE pieces piece
SET piece.title = 'Introduction and Fugue', piece.title_en = 'Introduction and Fugue',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 9544 AND piece.composer_id = 69
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None 부수음악 <Iphigenia in Tauris>

UPDATE pieces piece
SET piece.title = '부수음악 <Iphigenia in Tauris>', piece.title_en = 'Iphigenia in Tauris',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 10910 AND piece.composer_id = 69
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None 발레 <Job, a Masque for Dancing>

UPDATE pieces piece
SET piece.title = '발레 <Job, a Masque for Dancing>', piece.title_en = 'Job, a Masque for Dancing',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 9352 AND piece.composer_id = 69
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'Scene 1: Introduction', part.name_en = 'Job, A Masque for Dancing, ballet: Scene 1: Introduction',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 9352 AND p.composer_id = 69 AND part.part_key = 'musicbrainz:360ddfc6-f9b4-31d1-870e-da785b27065a' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:360ddfc6-f9b4-31d1-870e-da785b27065a', 1, NULL, 'Scene 1: Introduction', 'Job, A Masque for Dancing, ballet: Scene 1: Introduction', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 9352 AND p.composer_id = 69
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:360ddfc6-f9b4-31d1-870e-da785b27065a'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'Scene 1: Saraband of the Sons of God', part.name_en = 'Job, A Masque for Dancing, ballet: Scene 1: Saraband of the Sons of God',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 9352 AND p.composer_id = 69 AND part.part_key = 'musicbrainz:132209fc-5ff4-34b7-9355-a53029f49202' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:132209fc-5ff4-34b7-9355-a53029f49202', 2, NULL, 'Scene 1: Saraband of the Sons of God', 'Job, A Masque for Dancing, ballet: Scene 1: Saraband of the Sons of God', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 9352 AND p.composer_id = 69
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:132209fc-5ff4-34b7-9355-a53029f49202'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = NULL,
    part.name_ko = 'Scene 2: Satan''s Dance of Triumph', part.name_en = 'Job, A Masque for Dancing, ballet: Scene 2: Satan''s Dance of Triumph',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 9352 AND p.composer_id = 69 AND part.part_key = 'musicbrainz:7b46a9a5-5fae-3182-8404-f4d9345cb918' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:7b46a9a5-5fae-3182-8404-f4d9345cb918', 3, NULL, 'Scene 2: Satan''s Dance of Triumph', 'Job, A Masque for Dancing, ballet: Scene 2: Satan''s Dance of Triumph', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 9352 AND p.composer_id = 69
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:7b46a9a5-5fae-3182-8404-f4d9345cb918'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = NULL,
    part.name_ko = 'Scene 3: Minuet of the Sons of Job and Their Wives', part.name_en = 'Job, A Masque for Dancing, ballet: Scene 3: Minuet of the Sons of Job and Their Wives',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 9352 AND p.composer_id = 69 AND part.part_key = 'musicbrainz:1ebfd90d-95b7-37dc-a5e0-7674dbcbe5ce' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:1ebfd90d-95b7-37dc-a5e0-7674dbcbe5ce', 4, NULL, 'Scene 3: Minuet of the Sons of Job and Their Wives', 'Job, A Masque for Dancing, ballet: Scene 3: Minuet of the Sons of Job and Their Wives', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 9352 AND p.composer_id = 69
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:1ebfd90d-95b7-37dc-a5e0-7674dbcbe5ce'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 5, part.movement_number = NULL,
    part.name_ko = 'Scene 4: Job''s Dream', part.name_en = 'Job, A Masque for Dancing, ballet: Scene 4: Job''s Dream',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 9352 AND p.composer_id = 69 AND part.part_key = 'musicbrainz:654213d0-aaab-38a6-87e4-f9602c3522d3' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:654213d0-aaab-38a6-87e4-f9602c3522d3', 5, NULL, 'Scene 4: Job''s Dream', 'Job, A Masque for Dancing, ballet: Scene 4: Job''s Dream', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 9352 AND p.composer_id = 69
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:654213d0-aaab-38a6-87e4-f9602c3522d3'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 6, part.movement_number = NULL,
    part.name_ko = 'Scene 5: Dance of the Three Messengers', part.name_en = 'Job, A Masque for Dancing, ballet: Scene 5: Dance of the Three Messengers',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 9352 AND p.composer_id = 69 AND part.part_key = 'musicbrainz:f1677a7b-c0fe-3521-b511-916d3a078303' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:f1677a7b-c0fe-3521-b511-916d3a078303', 6, NULL, 'Scene 5: Dance of the Three Messengers', 'Job, A Masque for Dancing, ballet: Scene 5: Dance of the Three Messengers', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 9352 AND p.composer_id = 69
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:f1677a7b-c0fe-3521-b511-916d3a078303'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 7, part.movement_number = NULL,
    part.name_ko = 'Scene 6: Dance of Job''s Comforters', part.name_en = 'Job, A Masque for Dancing, ballet: Scene 6: Dance of Job''s Comforters',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 9352 AND p.composer_id = 69 AND part.part_key = 'musicbrainz:6b65dc9e-3387-3274-959f-cadc5ae82d8d' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:6b65dc9e-3387-3274-959f-cadc5ae82d8d', 7, NULL, 'Scene 6: Dance of Job''s Comforters', 'Job, A Masque for Dancing, ballet: Scene 6: Dance of Job''s Comforters', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 9352 AND p.composer_id = 69
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:6b65dc9e-3387-3274-959f-cadc5ae82d8d'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 8, part.movement_number = NULL,
    part.name_ko = 'Scene 7: Elihu''s Dance of Youth and Beauty', part.name_en = 'Job, A Masque for Dancing, ballet: Scene 7: Elihu''s Dance of Youth and Beauty',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 9352 AND p.composer_id = 69 AND part.part_key = 'musicbrainz:813f41e8-58fd-3136-97aa-254ce54ecd97' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:813f41e8-58fd-3136-97aa-254ce54ecd97', 8, NULL, 'Scene 7: Elihu''s Dance of Youth and Beauty', 'Job, A Masque for Dancing, ballet: Scene 7: Elihu''s Dance of Youth and Beauty', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 9352 AND p.composer_id = 69
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:813f41e8-58fd-3136-97aa-254ce54ecd97'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 9, part.movement_number = NULL,
    part.name_ko = 'Scene 7: Pavane of the Sons of the Morning', part.name_en = 'Job, A Masque for Dancing, ballet: Scene 7: Pavane of the Sons of the Morning',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 9352 AND p.composer_id = 69 AND part.part_key = 'musicbrainz:76bfde9a-4021-348c-8e77-1f4bfcf018c1' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:76bfde9a-4021-348c-8e77-1f4bfcf018c1', 9, NULL, 'Scene 7: Pavane of the Sons of the Morning', 'Job, A Masque for Dancing, ballet: Scene 7: Pavane of the Sons of the Morning', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 9352 AND p.composer_id = 69
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:76bfde9a-4021-348c-8e77-1f4bfcf018c1'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 10, part.movement_number = NULL,
    part.name_ko = 'Scene 8: Galliard of the Sons of the Morning', part.name_en = 'Job, A Masque for Dancing, ballet: Scene 8: Galliard of the Sons of the Morning',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 9352 AND p.composer_id = 69 AND part.part_key = 'musicbrainz:2b298ca6-d509-3121-917a-12cda73c14cf' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:2b298ca6-d509-3121-917a-12cda73c14cf', 10, NULL, 'Scene 8: Galliard of the Sons of the Morning', 'Job, A Masque for Dancing, ballet: Scene 8: Galliard of the Sons of the Morning', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 9352 AND p.composer_id = 69
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:2b298ca6-d509-3121-917a-12cda73c14cf'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 11, part.movement_number = NULL,
    part.name_ko = 'Scene 8: Altar Dance', part.name_en = 'Job, A Masque for Dancing, ballet: Scene 8: Altar Dance',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 9352 AND p.composer_id = 69 AND part.part_key = 'musicbrainz:ce4b79bd-a537-3da1-865d-07cea384ec1c' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:ce4b79bd-a537-3da1-865d-07cea384ec1c', 11, NULL, 'Scene 8: Altar Dance', 'Job, A Masque for Dancing, ballet: Scene 8: Altar Dance', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 9352 AND p.composer_id = 69
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:ce4b79bd-a537-3da1-865d-07cea384ec1c'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 12, part.movement_number = NULL,
    part.name_ko = 'Scene 9: Epilogue', part.name_en = 'Job, A Masque for Dancing, ballet: Scene 9: Epilogue',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 9352 AND p.composer_id = 69 AND part.part_key = 'musicbrainz:8bec7d05-00a6-34bd-a709-8bacb8c17cfc' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:8bec7d05-00a6-34bd-a709-8bacb8c17cfc', 12, NULL, 'Scene 9: Epilogue', 'Job, A Masque for Dancing, ballet: Scene 9: Epilogue', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 9352 AND p.composer_id = 69
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:8bec7d05-00a6-34bd-a709-8bacb8c17cfc'
);


-- None Joy, shipmate, joy!

UPDATE pieces piece
SET piece.title = 'Joy, shipmate, joy!', piece.title_en = 'Joy, shipmate, joy!',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 10917 AND piece.composer_id = 69
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None 가곡 <Land of Our Birth>

UPDATE pieces piece
SET piece.title = '가곡 <Land of Our Birth>', piece.title_en = 'Land of Our Birth',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 7982 AND piece.composer_id = 69
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Let All the World in Every Corner Sing

UPDATE pieces piece
SET piece.title = 'Let All the World in Every Corner Sing', piece.title_en = 'Let All the World in Every Corner Sing',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 10219 AND piece.composer_id = 69
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Let Us Now Praise Famous Men

UPDATE pieces piece
SET piece.title = 'Let Us Now Praise Famous Men', piece.title_en = 'Let Us Now Praise Famous Men',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 9105 AND piece.composer_id = 69
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None 모테트 <Lord, thou hast been our refuge>

UPDATE pieces piece
SET piece.title = '모테트 <Lord, thou hast been our refuge>', piece.title_en = 'Lord, thou hast been our refuge',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 10765 AND piece.composer_id = 69
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Love Is a Sickness

UPDATE pieces piece
SET piece.title = 'Love Is a Sickness', piece.title_en = 'Love Is a Sickness',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 8616 AND piece.composer_id = 69
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None 마니피카트

UPDATE pieces piece
SET piece.title = '마니피카트', piece.title_en = 'Magnificat',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 9835 AND piece.composer_id = 69
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None 미사 G단조

UPDATE pieces piece
SET piece.title = '미사 G단조', piece.title_en = 'Mass in G minor',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 10588 AND piece.composer_id = 69
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'Kyrie', part.name_en = 'Mass in G minor: I. Kyrie',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 10588 AND p.composer_id = 69 AND part.part_key = 'musicbrainz:34ef77e0-fc81-3ec8-97f7-2256e3bddfee' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:34ef77e0-fc81-3ec8-97f7-2256e3bddfee', 1, 'I', 'Kyrie', 'Mass in G minor: I. Kyrie', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 10588 AND p.composer_id = 69
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:34ef77e0-fc81-3ec8-97f7-2256e3bddfee'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'Gloria', part.name_en = 'Mass in G minor: II. Gloria',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 10588 AND p.composer_id = 69 AND part.part_key = 'musicbrainz:f6770041-87cf-3530-881d-81e3b817bbab' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:f6770041-87cf-3530-881d-81e3b817bbab', 2, 'II', 'Gloria', 'Mass in G minor: II. Gloria', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 10588 AND p.composer_id = 69
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:f6770041-87cf-3530-881d-81e3b817bbab'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = 'Credo', part.name_en = 'Mass in G minor: III. Credo',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 10588 AND p.composer_id = 69 AND part.part_key = 'musicbrainz:ce6be312-9b15-3e7d-8d51-63acb6a72137' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:ce6be312-9b15-3e7d-8d51-63acb6a72137', 3, 'III', 'Credo', 'Mass in G minor: III. Credo', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 10588 AND p.composer_id = 69
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:ce6be312-9b15-3e7d-8d51-63acb6a72137'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = 'IV',
    part.name_ko = 'Sanctus - Osanna I - Benedictus - Osanna II', part.name_en = 'Mass in G minor: IV. Sanctus - Osanna I - Benedictus - Osanna II',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 10588 AND p.composer_id = 69 AND part.part_key = 'musicbrainz:4a7fd2ac-93fe-3993-a9fe-914d28876ba2' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:4a7fd2ac-93fe-3993-a9fe-914d28876ba2', 4, 'IV', 'Sanctus - Osanna I - Benedictus - Osanna II', 'Mass in G minor: IV. Sanctus - Osanna I - Benedictus - Osanna II', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 10588 AND p.composer_id = 69
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:4a7fd2ac-93fe-3993-a9fe-914d28876ba2'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 5, part.movement_number = 'V',
    part.name_ko = 'Agnus Dei', part.name_en = 'Mass in G minor: V. Agnus Dei',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 10588 AND p.composer_id = 69 AND part.part_key = 'musicbrainz:fd5137e9-c2e4-34b6-888c-2134de676f24' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:fd5137e9-c2e4-34b6-888c-2134de676f24', 5, 'V', 'Agnus Dei', 'Mass in G minor: V. Agnus Dei', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 10588 AND p.composer_id = 69
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:fd5137e9-c2e4-34b6-888c-2134de676f24'
);


-- None 가곡 <Merciless Beauty>

UPDATE pieces piece
SET piece.title = '가곡 <Merciless Beauty>', piece.title_en = 'Merciless Beauty',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 8730 AND piece.composer_id = 69
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'Your eyën two', part.name_en = 'Merciless Beauty: I. Your eyën two',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 8730 AND p.composer_id = 69 AND part.part_key = 'musicbrainz:5a49173e-59ad-48b2-b903-9f9850f1f6e4' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:5a49173e-59ad-48b2-b903-9f9850f1f6e4', 1, 'I', 'Your eyën two', 'Merciless Beauty: I. Your eyën two', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 8730 AND p.composer_id = 69
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:5a49173e-59ad-48b2-b903-9f9850f1f6e4'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'So hath your beauty', part.name_en = 'Merciless Beauty: II. So hath your beauty',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 8730 AND p.composer_id = 69 AND part.part_key = 'musicbrainz:30a00977-8548-4fc1-bcbd-c839cecd177d' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:30a00977-8548-4fc1-bcbd-c839cecd177d', 2, 'II', 'So hath your beauty', 'Merciless Beauty: II. So hath your beauty', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 8730 AND p.composer_id = 69
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:30a00977-8548-4fc1-bcbd-c839cecd177d'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = 'Since I from Love', part.name_en = 'Merciless Beauty: III. Since I from Love',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 8730 AND p.composer_id = 69 AND part.part_key = 'musicbrainz:9a30951e-c284-4035-a25b-d769e6b6cb0e' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:9a30951e-c284-4035-a25b-d769e6b6cb0e', 3, 'III', 'Since I from Love', 'Merciless Beauty: III. Since I from Love', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 8730 AND p.composer_id = 69
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:9a30951e-c284-4035-a25b-d769e6b6cb0e'
);


-- None Music for an EFDS Masque

UPDATE pieces piece
SET piece.title = 'Music for an EFDS Masque', piece.title_en = 'Music for an EFDS Masque',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 10058 AND piece.composer_id = 69
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'A Folk Dance Medley', part.name_en = 'A Folk Dance Medley',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 10058 AND p.composer_id = 69 AND part.part_key = 'musicbrainz:f9957bac-f0f1-4540-a954-063fce6e90b4' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:f9957bac-f0f1-4540-a954-063fce6e90b4', 1, NULL, 'A Folk Dance Medley', 'A Folk Dance Medley', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 10058 AND p.composer_id = 69
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:f9957bac-f0f1-4540-a954-063fce6e90b4'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'Little March Suite', part.name_en = 'Little March Suite',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 10058 AND p.composer_id = 69 AND part.part_key = 'musicbrainz:39084b93-50b0-4176-9425-936fe6bfdecf' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:39084b93-50b0-4176-9425-936fe6bfdecf', 2, NULL, 'Little March Suite', 'Little March Suite', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 10058 AND p.composer_id = 69
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:39084b93-50b0-4176-9425-936fe6bfdecf'
);


-- None 가곡 <My Soul, Praise the Lord>

UPDATE pieces piece
SET piece.title = '가곡 <My Soul, Praise the Lord>', piece.title_en = 'My Soul, Praise the Lord',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 8330 AND piece.composer_id = 69
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Norfolk Rhapsody no. 1

UPDATE pieces piece
SET piece.title = 'Norfolk Rhapsody no. 1', piece.title_en = 'Norfolk Rhapsody no. 1',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 7545 AND piece.composer_id = 69
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Norfolk Rhapsody no. 3

UPDATE pieces piece
SET piece.title = 'Norfolk Rhapsody no. 3', piece.title_en = 'Norfolk Rhapsody no. 3',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 7845 AND piece.composer_id = 69
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None 가곡 <Nothing Is Here for Tears>

UPDATE pieces piece
SET piece.title = '가곡 <Nothing Is Here for Tears>', piece.title_en = 'Nothing Is Here for Tears',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 7686 AND piece.composer_id = 69
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None O How Amiable

UPDATE pieces piece
SET piece.title = 'O How Amiable', piece.title_en = 'O How Amiable',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 7765 AND piece.composer_id = 69
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None 가곡 <O Praise the Lord of Heaven>

UPDATE pieces piece
SET piece.title = '가곡 <O Praise the Lord of Heaven>', piece.title_en = 'O Praise the Lord of Heaven',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 9811 AND piece.composer_id = 69
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None O taste and see

UPDATE pieces piece
SET piece.title = 'O taste and see', piece.title_en = 'O taste and see',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 8424 AND piece.composer_id = 69
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None O vos omnes

UPDATE pieces piece
SET piece.title = 'O vos omnes', piece.title_en = 'O vos omnes',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 10192 AND piece.composer_id = 69
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None 발레 <Old King Cole>

UPDATE pieces piece
SET piece.title = '발레 <Old King Cole>', piece.title_en = 'Old King Cole',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 10603 AND piece.composer_id = 69
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None 발레 <On Christmas Night>

UPDATE pieces piece
SET piece.title = '발레 <On Christmas Night>', piece.title_en = 'On Christmas Night',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 8375 AND piece.composer_id = 69
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'Prelude. God Rest You Merry - allegro agitato', part.name_en = 'On Christmas Night: Prelude. God Rest You Merry - allegro agitato',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 8375 AND p.composer_id = 69 AND part.part_key = 'musicbrainz:5923cda0-c7fa-4853-9c2d-31eead3283e1' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:5923cda0-c7fa-4853-9c2d-31eead3283e1', 1, NULL, 'Prelude. God Rest You Merry - allegro agitato', 'On Christmas Night: Prelude. God Rest You Merry - allegro agitato', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 8375 AND p.composer_id = 69
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:5923cda0-c7fa-4853-9c2d-31eead3283e1'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'Marley''s Ghost. Allegro moderato e pesante', part.name_en = 'On Christmas Night: Marley''s Ghost. Allegro moderato e pesante',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 8375 AND p.composer_id = 69 AND part.part_key = 'musicbrainz:3f52be73-657e-49f1-8e37-fe40914912b5' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:3f52be73-657e-49f1-8e37-fe40914912b5', 2, NULL, 'Marley''s Ghost. Allegro moderato e pesante', 'On Christmas Night: Marley''s Ghost. Allegro moderato e pesante', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 8375 AND p.composer_id = 69
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:3f52be73-657e-49f1-8e37-fe40914912b5'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = NULL,
    part.name_ko = 'The Spirit of Christmas - Lento', part.name_en = 'On Christmas Night: The Spirit of Christmas - Lento',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 8375 AND p.composer_id = 69 AND part.part_key = 'musicbrainz:f38b3a0b-eafe-4823-ac4d-61068b5721f6' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:f38b3a0b-eafe-4823-ac4d-61068b5721f6', 3, NULL, 'The Spirit of Christmas - Lento', 'On Christmas Night: The Spirit of Christmas - Lento', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 8375 AND p.composer_id = 69
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:f38b3a0b-eafe-4823-ac4d-61068b5721f6'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = NULL,
    part.name_ko = 'Fezziwig''s Christmas Party. Molto moderato', part.name_en = 'On Christmas Night: Fezziwig''s Christmas Party. Molto moderato',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 8375 AND p.composer_id = 69 AND part.part_key = 'musicbrainz:c6e22398-b8ce-46e3-9038-6d6ca1017b29' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:c6e22398-b8ce-46e3-9038-6d6ca1017b29', 4, NULL, 'Fezziwig''s Christmas Party. Molto moderato', 'On Christmas Night: Fezziwig''s Christmas Party. Molto moderato', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 8375 AND p.composer_id = 69
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:c6e22398-b8ce-46e3-9038-6d6ca1017b29'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 5, part.movement_number = NULL,
    part.name_ko = 'Scene 2, Fezziwig''s Parlour - Allegro', part.name_en = 'On Christmas Night: Scene 2, Fezziwig''s Parlour - Allegro',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 8375 AND p.composer_id = 69 AND part.part_key = 'musicbrainz:dffb92d5-5167-4275-8873-70e2e3748be5' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:dffb92d5-5167-4275-8873-70e2e3748be5', 5, NULL, 'Scene 2, Fezziwig''s Parlour - Allegro', 'On Christmas Night: Scene 2, Fezziwig''s Parlour - Allegro', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 8375 AND p.composer_id = 69
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:dffb92d5-5167-4275-8873-70e2e3748be5'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 6, part.movement_number = NULL,
    part.name_ko = 'Morris jig. Allegro molto', part.name_en = 'On Christmas Night: Morris jig. Allegro molto',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 8375 AND p.composer_id = 69 AND part.part_key = 'musicbrainz:93a285fd-0190-43ec-ae7c-c706c46b936a' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:93a285fd-0190-43ec-ae7c-c706c46b936a', 6, NULL, 'Morris jig. Allegro molto', 'On Christmas Night: Morris jig. Allegro molto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 8375 AND p.composer_id = 69
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:93a285fd-0190-43ec-ae7c-c706c46b936a'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 7, part.movement_number = NULL,
    part.name_ko = 'The Triumph. Allegro moderato', part.name_en = 'On Christmas Night: The Triumph. Allegro moderato',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 8375 AND p.composer_id = 69 AND part.part_key = 'musicbrainz:154961d2-32b7-4861-ae8f-d3d7d5e8c03b' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:154961d2-32b7-4861-ae8f-d3d7d5e8c03b', 7, NULL, 'The Triumph. Allegro moderato', 'On Christmas Night: The Triumph. Allegro moderato', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 8375 AND p.composer_id = 69
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:154961d2-32b7-4861-ae8f-d3d7d5e8c03b'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 8, part.movement_number = NULL,
    part.name_ko = 'Roger de Coverley', part.name_en = 'On Christmas Night: Roger de Coverley',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 8375 AND p.composer_id = 69 AND part.part_key = 'musicbrainz:ff12e54d-b0ea-40ed-9c21-510a5a406160' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:ff12e54d-b0ea-40ed-9c21-510a5a406160', 8, NULL, 'Roger de Coverley', 'On Christmas Night: Roger de Coverley', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 8375 AND p.composer_id = 69
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:ff12e54d-b0ea-40ed-9c21-510a5a406160'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 9, part.movement_number = NULL,
    part.name_ko = 'Midnight. Lento', part.name_en = 'On Christmas Night: Midnight. Lento',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 8375 AND p.composer_id = 69 AND part.part_key = 'musicbrainz:90547656-b740-4fb3-87fc-2bd7726c2504' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:90547656-b740-4fb3-87fc-2bd7726c2504', 9, NULL, 'Midnight. Lento', 'On Christmas Night: Midnight. Lento', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 8375 AND p.composer_id = 69
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:90547656-b740-4fb3-87fc-2bd7726c2504'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 10, part.movement_number = NULL,
    part.name_ko = 'A Procession. Lento', part.name_en = 'On Christmas Night: A Procession. Lento',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 8375 AND p.composer_id = 69 AND part.part_key = 'musicbrainz:717294de-5fa4-4d03-b439-da38953b0565' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:717294de-5fa4-4d03-b439-da38953b0565', 10, NULL, 'A Procession. Lento', 'On Christmas Night: A Procession. Lento', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 8375 AND p.composer_id = 69
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:717294de-5fa4-4d03-b439-da38953b0565'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 11, part.movement_number = NULL,
    part.name_ko = 'Victorian Drawing Room. Andante sustenuto', part.name_en = 'On Christmas Night: Victorian Drawing Room. Andante sustenuto',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 8375 AND p.composer_id = 69 AND part.part_key = 'musicbrainz:d6661231-8d93-4430-9386-889c187f0ea3' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:d6661231-8d93-4430-9386-889c187f0ea3', 11, NULL, 'Victorian Drawing Room. Andante sustenuto', 'On Christmas Night: Victorian Drawing Room. Andante sustenuto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 8375 AND p.composer_id = 69
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:d6661231-8d93-4430-9386-889c187f0ea3'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 12, part.movement_number = NULL,
    part.name_ko = 'Bob Cratchit''s Christmas Party', part.name_en = 'On Christmas Night: Bob Cratchit''s Christmas Party',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 8375 AND p.composer_id = 69 AND part.part_key = 'musicbrainz:bc072e53-17cf-45fc-b773-e225d4931d9a' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:bc072e53-17cf-45fc-b773-e225d4931d9a', 12, NULL, 'Bob Cratchit''s Christmas Party', 'On Christmas Night: Bob Cratchit''s Christmas Party', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 8375 AND p.composer_id = 69
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:bc072e53-17cf-45fc-b773-e225d4931d9a'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 13, part.movement_number = NULL,
    part.name_ko = 'Bob Catchit''s Toast. Lento', part.name_en = 'On Christmas Night: Bob Catchit''s Toast. Lento',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 8375 AND p.composer_id = 69 AND part.part_key = 'musicbrainz:5455b11c-f850-4372-811f-50efd7a7801c' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:5455b11c-f850-4372-811f-50efd7a7801c', 13, NULL, 'Bob Catchit''s Toast. Lento', 'On Christmas Night: Bob Catchit''s Toast. Lento', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 8375 AND p.composer_id = 69
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:5455b11c-f850-4372-811f-50efd7a7801c'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 14, part.movement_number = NULL,
    part.name_ko = 'Black Nag. Allegro', part.name_en = 'On Christmas Night: Black Nag. Allegro',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 8375 AND p.composer_id = 69 AND part.part_key = 'musicbrainz:e407ddd8-71f4-444f-bfe4-46d556fa50cd' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:e407ddd8-71f4-444f-bfe4-46d556fa50cd', 14, NULL, 'Black Nag. Allegro', 'On Christmas Night: Black Nag. Allegro', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 8375 AND p.composer_id = 69
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:e407ddd8-71f4-444f-bfe4-46d556fa50cd'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 15, part.movement_number = NULL,
    part.name_ko = 'Procession of the Nativity', part.name_en = 'On Christmas Night: Procession of the Nativity',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 8375 AND p.composer_id = 69 AND part.part_key = 'musicbrainz:ee03acac-4c46-4231-a235-9a5dd73ca5fc' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:ee03acac-4c46-4231-a235-9a5dd73ca5fc', 15, NULL, 'Procession of the Nativity', 'On Christmas Night: Procession of the Nativity', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 8375 AND p.composer_id = 69
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:ee03acac-4c46-4231-a235-9a5dd73ca5fc'
);


-- None 가곡 <Orpheus With His Lute>

UPDATE pieces piece
SET piece.title = '가곡 <Orpheus With His Lute>', piece.title_en = 'Orpheus With His Lute',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 7692 AND piece.composer_id = 69
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None 서곡 "Henry the Fifth"

UPDATE pieces piece
SET piece.title = '서곡 "Henry the Fifth"', piece.title_en = 'Overture for Brass Band "Henry the Fifth"',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 9194 AND piece.composer_id = 69
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Partita for Double String Orchestra

UPDATE pieces piece
SET piece.title = 'Partita for Double String Orchestra', piece.title_en = 'Partita for Double String Orchestra',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 8809 AND piece.composer_id = 69
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'Prelude (Andante tranquillo)', part.name_en = 'Partita for Double String Orchestra: I. Prelude (Andante tranquillo)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 8809 AND p.composer_id = 69 AND part.part_key = 'musicbrainz:57beb6aa-7d40-3e08-b78c-bbfaf94cf216' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:57beb6aa-7d40-3e08-b78c-bbfaf94cf216', 1, 'I', 'Prelude (Andante tranquillo)', 'Partita for Double String Orchestra: I. Prelude (Andante tranquillo)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 8809 AND p.composer_id = 69
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:57beb6aa-7d40-3e08-b78c-bbfaf94cf216'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'Scherzo ostinato (Presto)', part.name_en = 'Partita for Double String Orchestra: II. Scherzo ostinato (Presto)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 8809 AND p.composer_id = 69 AND part.part_key = 'musicbrainz:57afdb0a-e4ff-3c62-b43c-a22a384ecfa6' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:57afdb0a-e4ff-3c62-b43c-a22a384ecfa6', 2, 'II', 'Scherzo ostinato (Presto)', 'Partita for Double String Orchestra: II. Scherzo ostinato (Presto)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 8809 AND p.composer_id = 69
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:57afdb0a-e4ff-3c62-b43c-a22a384ecfa6'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = 'Intermezzo (Homage to Henry Hall)', part.name_en = 'Partita for Double String Orchestra: III. Intermezzo (Homage to Henry Hall)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 8809 AND p.composer_id = 69 AND part.part_key = 'musicbrainz:91070971-1be3-3c7e-8366-d9532525679d' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:91070971-1be3-3c7e-8366-d9532525679d', 3, 'III', 'Intermezzo (Homage to Henry Hall)', 'Partita for Double String Orchestra: III. Intermezzo (Homage to Henry Hall)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 8809 AND p.composer_id = 69
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:91070971-1be3-3c7e-8366-d9532525679d'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = 'IV',
    part.name_ko = 'Fantasia (Allegro)', part.name_en = 'Partita for Double String Orchestra: IV. Fantasia (Allegro)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 8809 AND p.composer_id = 69 AND part.part_key = 'musicbrainz:af15c644-3101-3e0c-8c08-2872952b3ca8' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:af15c644-3101-3e0c-8c08-2872952b3ca8', 4, 'IV', 'Fantasia (Allegro)', 'Partita for Double String Orchestra: IV. Fantasia (Allegro)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 8809 AND p.composer_id = 69
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:af15c644-3101-3e0c-8c08-2872952b3ca8'
);


-- None 가곡 <Peace, Come Away>

UPDATE pieces piece
SET piece.title = '가곡 <Peace, Come Away>', piece.title_en = 'Peace, Come Away',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 9890 AND piece.composer_id = 69
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Phantasy Quintet

UPDATE pieces piece
SET piece.title = 'Phantasy Quintet', piece.title_en = 'Phantasy Quintet',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 11265 AND piece.composer_id = 69
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'Prelude: Lento ma non troppo', part.name_en = 'Phantasy Quintet: I. Prelude: Lento ma non troppo',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11265 AND p.composer_id = 69 AND part.part_key = 'musicbrainz:00888cd2-0796-3802-b71d-8e3e525a8004' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:00888cd2-0796-3802-b71d-8e3e525a8004', 1, 'I', 'Prelude: Lento ma non troppo', 'Phantasy Quintet: I. Prelude: Lento ma non troppo', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 11265 AND p.composer_id = 69
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:00888cd2-0796-3802-b71d-8e3e525a8004'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'Scherzo: Prestissimo', part.name_en = 'Phantasy Quintet: II. Scherzo: Prestissimo',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11265 AND p.composer_id = 69 AND part.part_key = 'musicbrainz:c13ff892-628f-3441-b2c9-a7dcd6a792f8' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:c13ff892-628f-3441-b2c9-a7dcd6a792f8', 2, 'II', 'Scherzo: Prestissimo', 'Phantasy Quintet: II. Scherzo: Prestissimo', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 11265 AND p.composer_id = 69
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:c13ff892-628f-3441-b2c9-a7dcd6a792f8'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = 'Alla sarabanda: Lento', part.name_en = 'Phantasy Quintet: III. Alla sarabanda: Lento',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11265 AND p.composer_id = 69 AND part.part_key = 'musicbrainz:71690668-d256-3477-870d-7f576c2ef34a' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:71690668-d256-3477-870d-7f576c2ef34a', 3, 'III', 'Alla sarabanda: Lento', 'Phantasy Quintet: III. Alla sarabanda: Lento', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 11265 AND p.composer_id = 69
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:71690668-d256-3477-870d-7f576c2ef34a'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = 'IV',
    part.name_ko = 'Burlesca: Allegro moderato', part.name_en = 'Phantasy Quintet: IV. Burlesca: Allegro moderato',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11265 AND p.composer_id = 69 AND part.part_key = 'musicbrainz:7cf026f4-2ace-3a69-a68b-6c5fad0ad8dd' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:7cf026f4-2ace-3a69-a68b-6c5fad0ad8dd', 4, 'IV', 'Burlesca: Allegro moderato', 'Phantasy Quintet: IV. Burlesca: Allegro moderato', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 11265 AND p.composer_id = 69
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:7cf026f4-2ace-3a69-a68b-6c5fad0ad8dd'
);


-- None 피아노 5중주 C단조

UPDATE pieces piece
SET piece.title = '피아노 5중주 C단조', piece.title_en = 'Piano Quintet in C minor',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 10213 AND piece.composer_id = 69
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'Allegro con fuoco', part.name_en = 'Piano Quintet in C minor: I. Allegro con fuoco',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 10213 AND p.composer_id = 69 AND part.part_key = 'musicbrainz:8dd237e4-fc6a-48df-8c37-aac27e3eff3d' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:8dd237e4-fc6a-48df-8c37-aac27e3eff3d', 1, 'I', 'Allegro con fuoco', 'Piano Quintet in C minor: I. Allegro con fuoco', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 10213 AND p.composer_id = 69
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:8dd237e4-fc6a-48df-8c37-aac27e3eff3d'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'Andante', part.name_en = 'Piano Quintet in C minor: II. Andante',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 10213 AND p.composer_id = 69 AND part.part_key = 'musicbrainz:6a8637eb-1eda-427c-9190-80a7e4a105f1' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:6a8637eb-1eda-427c-9190-80a7e4a105f1', 2, 'II', 'Andante', 'Piano Quintet in C minor: II. Andante', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 10213 AND p.composer_id = 69
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:6a8637eb-1eda-427c-9190-80a7e4a105f1'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = 'Fantasia (quasi variazioni). Moderato', part.name_en = 'Piano Quintet in C minor: III. Fantasia (quasi variazioni). Moderato',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 10213 AND p.composer_id = 69 AND part.part_key = 'musicbrainz:3fa8d85f-caed-47a4-94be-0d3ec9de0f7d' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:3fa8d85f-caed-47a4-94be-0d3ec9de0f7d', 3, 'III', 'Fantasia (quasi variazioni). Moderato', 'Piano Quintet in C minor: III. Fantasia (quasi variazioni). Moderato', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 10213 AND p.composer_id = 69
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:3fa8d85f-caed-47a4-94be-0d3ec9de0f7d'
);


-- None 모테트 <Prayer to the Father of Heaven>

UPDATE pieces piece
SET piece.title = '모테트 <Prayer to the Father of Heaven>', piece.title_en = 'Prayer to the Father of Heaven',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 9059 AND piece.composer_id = 69
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None 5중주 D장조

UPDATE pieces piece
SET piece.title = '5중주 D장조', piece.title_en = 'Quintet in D major',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 7504 AND piece.composer_id = 69
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'Allegro moderato', part.name_en = 'Quintet in D major: I. Allegro moderato',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 7504 AND p.composer_id = 69 AND part.part_key = 'musicbrainz:47bbb4c8-b083-4d3d-8508-cc22e9e59de1' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:47bbb4c8-b083-4d3d-8508-cc22e9e59de1', 1, 'I', 'Allegro moderato', 'Quintet in D major: I. Allegro moderato', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 7504 AND p.composer_id = 69
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:47bbb4c8-b083-4d3d-8508-cc22e9e59de1'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'Intermezzo: Allegretto', part.name_en = 'Quintet in D major: II. Intermezzo: Allegretto',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 7504 AND p.composer_id = 69 AND part.part_key = 'musicbrainz:81281c50-301e-4d9b-9969-27f976417bc6' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:81281c50-301e-4d9b-9969-27f976417bc6', 2, 'II', 'Intermezzo: Allegretto', 'Quintet in D major: II. Intermezzo: Allegretto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 7504 AND p.composer_id = 69
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:81281c50-301e-4d9b-9969-27f976417bc6'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = 'Andantino', part.name_en = 'Quintet in D major: III. Andantino',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 7504 AND p.composer_id = 69 AND part.part_key = 'musicbrainz:f30ddf8c-84d9-4d02-b24d-5ef1942a7a84' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:f30ddf8c-84d9-4d02-b24d-5ef1942a7a84', 3, 'III', 'Andantino', 'Quintet in D major: III. Andantino', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 7504 AND p.composer_id = 69
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:f30ddf8c-84d9-4d02-b24d-5ef1942a7a84'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = 'IV',
    part.name_ko = 'Finale: Allegro molto', part.name_en = 'Quintet in D major: IV. Finale: Allegro molto',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 7504 AND p.composer_id = 69 AND part.part_key = 'musicbrainz:cc5a8421-10c6-486c-a5e3-ca256eed6864' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:cc5a8421-10c6-486c-a5e3-ca256eed6864', 4, 'IV', 'Finale: Allegro molto', 'Quintet in D major: IV. Finale: Allegro molto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 7504 AND p.composer_id = 69
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:cc5a8421-10c6-486c-a5e3-ca256eed6864'
);


-- None Rest

UPDATE pieces piece
SET piece.title = 'Rest', piece.title_en = 'Rest',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 7748 AND piece.composer_id = 69
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None 부수음악 <Richard II>

UPDATE pieces piece
SET piece.title = '부수음악 <Richard II>', piece.title_en = 'Richard II',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 11243 AND piece.composer_id = 69
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None 마드리갈 <Ring Out Your Bells>

UPDATE pieces piece
SET piece.title = '마드리갈 <Ring Out Your Bells>', piece.title_en = 'Ring Out Your Bells',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 8255 AND piece.composer_id = 69
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None 비올라와 피아노를 위한 로망스

UPDATE pieces piece
SET piece.title = '비올라와 피아노를 위한 로망스', piece.title_en = 'Romance for Viola and Piano',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 8685 AND piece.composer_id = 69
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None 오라토리오 <Sancta Civitas>

UPDATE pieces piece
SET piece.title = '오라토리오 <Sancta Civitas>', piece.title_en = 'Sancta Civitas',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 8909 AND piece.composer_id = 69
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'I was in the spirit (Lento)', part.name_en = 'Sancta Civitas: I was in the spirit (Lento)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 8909 AND p.composer_id = 69 AND part.part_key = 'musicbrainz:9cd7e58f-83da-4326-9ec3-caa63777d794' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:9cd7e58f-83da-4326-9ec3-caa63777d794', 1, NULL, 'I was in the spirit (Lento)', 'Sancta Civitas: I was in the spirit (Lento)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 8909 AND p.composer_id = 69
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:9cd7e58f-83da-4326-9ec3-caa63777d794'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'And I saw Heaven opened (Allegro)', part.name_en = 'Sancta Civitas: And I saw Heaven opened (Allegro)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 8909 AND p.composer_id = 69 AND part.part_key = 'musicbrainz:636d0b55-367d-4397-978a-9ee031bc6262' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:636d0b55-367d-4397-978a-9ee031bc6262', 2, NULL, 'And I saw Heaven opened (Allegro)', 'Sancta Civitas: And I saw Heaven opened (Allegro)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 8909 AND p.composer_id = 69
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:636d0b55-367d-4397-978a-9ee031bc6262'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = NULL,
    part.name_ko = 'And I saw an angel standing in the sun (Meno mosso)', part.name_en = 'Sancta Civitas: And I saw an angel standing in the sun (Meno mosso)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 8909 AND p.composer_id = 69 AND part.part_key = 'musicbrainz:90ab6f72-8756-47df-b828-83ee1fc0d0ec' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:90ab6f72-8756-47df-b828-83ee1fc0d0ec', 3, NULL, 'And I saw an angel standing in the sun (Meno mosso)', 'Sancta Civitas: And I saw an angel standing in the sun (Meno mosso)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 8909 AND p.composer_id = 69
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:90ab6f72-8756-47df-b828-83ee1fc0d0ec'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = NULL,
    part.name_ko = 'Babylon the great is fallen (Lento)', part.name_en = 'Sancta Civitas: Babylon the great is fallen (Lento)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 8909 AND p.composer_id = 69 AND part.part_key = 'musicbrainz:bac4495e-c792-46e7-b61a-349014f29734' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:bac4495e-c792-46e7-b61a-349014f29734', 4, NULL, 'Babylon the great is fallen (Lento)', 'Sancta Civitas: Babylon the great is fallen (Lento)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 8909 AND p.composer_id = 69
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:bac4495e-c792-46e7-b61a-349014f29734'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 5, part.movement_number = NULL,
    part.name_ko = 'Rejoice over her O Heavens (Allegro moderato)', part.name_en = 'Sancta Civitas: Rejoice over her O Heavens (Allegro moderato)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 8909 AND p.composer_id = 69 AND part.part_key = 'musicbrainz:4dbb9a10-cfc9-4cbb-875e-7d3c7a4d1c94' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:4dbb9a10-cfc9-4cbb-875e-7d3c7a4d1c94', 5, NULL, 'Rejoice over her O Heavens (Allegro moderato)', 'Sancta Civitas: Rejoice over her O Heavens (Allegro moderato)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 8909 AND p.composer_id = 69
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:4dbb9a10-cfc9-4cbb-875e-7d3c7a4d1c94'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 6, part.movement_number = NULL,
    part.name_ko = 'And I saw a new heaven (Adagio)', part.name_en = 'Sancta Civitas: And I saw a new heaven (Adagio)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 8909 AND p.composer_id = 69 AND part.part_key = 'musicbrainz:8d079182-f6e8-43e9-a460-d71473df5b4c' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:8d079182-f6e8-43e9-a460-d71473df5b4c', 6, NULL, 'And I saw a new heaven (Adagio)', 'Sancta Civitas: And I saw a new heaven (Adagio)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 8909 AND p.composer_id = 69
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:8d079182-f6e8-43e9-a460-d71473df5b4c'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 7, part.movement_number = NULL,
    part.name_ko = 'Therefore are they before the throne of God (Poco meno largo)', part.name_en = 'Sancta Civitas: Therefore are they before the throne of God (Poco meno largo)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 8909 AND p.composer_id = 69 AND part.part_key = 'musicbrainz:9bf57589-1ee0-4755-ab5d-c8023b517d2e' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:9bf57589-1ee0-4755-ab5d-c8023b517d2e', 7, NULL, 'Therefore are they before the throne of God (Poco meno largo)', 'Sancta Civitas: Therefore are they before the throne of God (Poco meno largo)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 8909 AND p.composer_id = 69
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:9bf57589-1ee0-4755-ab5d-c8023b517d2e'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 8, part.movement_number = NULL,
    part.name_ko = 'And I saw a pure river', part.name_en = 'Sancta Civitas: And I saw a pure river',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 8909 AND p.composer_id = 69 AND part.part_key = 'musicbrainz:de3bdcf0-236a-49f6-adfc-8152e3caa3dd' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:de3bdcf0-236a-49f6-adfc-8152e3caa3dd', 8, NULL, 'And I saw a pure river', 'Sancta Civitas: And I saw a pure river', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 8909 AND p.composer_id = 69
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:de3bdcf0-236a-49f6-adfc-8152e3caa3dd'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 9, part.movement_number = NULL,
    part.name_ko = 'Holy, Holy, Holy (Andante sostenuto)', part.name_en = 'Sancta Civitas: Holy, Holy, Holy (Andante sostenuto)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 8909 AND p.composer_id = 69 AND part.part_key = 'musicbrainz:93ace797-c3ec-4771-b132-36378002ce52' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:93ace797-c3ec-4771-b132-36378002ce52', 9, NULL, 'Holy, Holy, Holy (Andante sostenuto)', 'Sancta Civitas: Holy, Holy, Holy (Andante sostenuto)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 8909 AND p.composer_id = 69
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:93ace797-c3ec-4771-b132-36378002ce52'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 10, part.movement_number = NULL,
    part.name_ko = 'Heaven and earth are full of Thy glory (Poco animato)', part.name_en = 'Sancta Civitas: Heaven and earth are full of Thy glory (Poco animato)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 8909 AND p.composer_id = 69 AND part.part_key = 'musicbrainz:bb096cc4-8b6c-47e8-ac7b-9a6d0a3cc108' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:bb096cc4-8b6c-47e8-ac7b-9a6d0a3cc108', 10, NULL, 'Heaven and earth are full of Thy glory (Poco animato)', 'Sancta Civitas: Heaven and earth are full of Thy glory (Poco animato)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 8909 AND p.composer_id = 69
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:bb096cc4-8b6c-47e8-ac7b-9a6d0a3cc108'
);


-- None Saraband “Helen”

UPDATE pieces piece
SET piece.title = 'Saraband “Helen”', piece.title_en = 'Saraband “Helen”',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 8337 AND piece.composer_id = 69
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Saviour, again to Thy dear name we raise

UPDATE pieces piece
SET piece.title = 'Saviour, again to Thy dear name we raise', piece.title_en = 'Saviour, again to Thy dear name we raise',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 10060 AND piece.composer_id = 69
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None 부수음악 <Scenes Adapted from Bunyan’s Pilgrim’s Progress>

UPDATE pieces piece
SET piece.title = '부수음악 <Scenes Adapted from Bunyan’s Pilgrim’s Progress>', piece.title_en = 'Scenes Adapted from Bunyan’s Pilgrim’s Progress',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 9012 AND piece.composer_id = 69
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'Prelude', part.name_en = 'Scenes Adapted from Bunyan’s Pilgrim’s Progress: Prelude',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 9012 AND p.composer_id = 69 AND part.part_key = 'musicbrainz:8a0f30f0-8f32-44e4-9422-93463b47eb1b' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:8a0f30f0-8f32-44e4-9422-93463b47eb1b', 1, NULL, 'Prelude', 'Scenes Adapted from Bunyan’s Pilgrim’s Progress: Prelude', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 9012 AND p.composer_id = 69
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:8a0f30f0-8f32-44e4-9422-93463b47eb1b'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'Dances: Sellinger’s Round & The Lost Lady', part.name_en = 'Scenes Adapted from Bunyan’s Pilgrim’s Progress: Dances: Sellinger’s Round & The Lost Lady',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 9012 AND p.composer_id = 69 AND part.part_key = 'musicbrainz:45373d8c-da0d-42c4-b81e-55be5b2d63fb' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:45373d8c-da0d-42c4-b81e-55be5b2d63fb', 2, NULL, 'Dances: Sellinger’s Round & The Lost Lady', 'Scenes Adapted from Bunyan’s Pilgrim’s Progress: Dances: Sellinger’s Round & The Lost Lady', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 9012 AND p.composer_id = 69
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:45373d8c-da0d-42c4-b81e-55be5b2d63fb'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = NULL,
    part.name_ko = 'Flower‐Girl’s Song', part.name_en = 'Scenes Adapted from Bunyan’s Pilgrim’s Progress: Flower‐Girl’s Song',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 9012 AND p.composer_id = 69 AND part.part_key = 'musicbrainz:4bbeb801-ec55-46fa-a732-6b50fc3bedb5' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:4bbeb801-ec55-46fa-a732-6b50fc3bedb5', 3, NULL, 'Flower‐Girl’s Song', 'Scenes Adapted from Bunyan’s Pilgrim’s Progress: Flower‐Girl’s Song', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 9012 AND p.composer_id = 69
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:4bbeb801-ec55-46fa-a732-6b50fc3bedb5'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = NULL,
    part.name_ko = 'The Arming of Christian', part.name_en = 'Scenes Adapted from Bunyan’s Pilgrim’s Progress: The Arming of Christian',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 9012 AND p.composer_id = 69 AND part.part_key = 'musicbrainz:c844cf22-3c88-4783-84ba-faa5f9a618eb' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:c844cf22-3c88-4783-84ba-faa5f9a618eb', 4, NULL, 'The Arming of Christian', 'Scenes Adapted from Bunyan’s Pilgrim’s Progress: The Arming of Christian', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 9012 AND p.composer_id = 69
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:c844cf22-3c88-4783-84ba-faa5f9a618eb'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 5, part.movement_number = NULL,
    part.name_ko = 'Apollyon: Start of Scene', part.name_en = 'Scenes Adapted from Bunyan’s Pilgrim’s Progress: Apollyon: Start of Scene',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 9012 AND p.composer_id = 69 AND part.part_key = 'musicbrainz:6444f316-c729-40dc-8a98-291492fd0998' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:6444f316-c729-40dc-8a98-291492fd0998', 5, NULL, 'Apollyon: Start of Scene', 'Scenes Adapted from Bunyan’s Pilgrim’s Progress: Apollyon: Start of Scene', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 9012 AND p.composer_id = 69
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:6444f316-c729-40dc-8a98-291492fd0998'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 6, part.movement_number = NULL,
    part.name_ko = 'Apollyon: The Fight', part.name_en = 'Scenes Adapted from Bunyan’s Pilgrim’s Progress: Apollyon: The Fight',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 9012 AND p.composer_id = 69 AND part.part_key = 'musicbrainz:6360e0cb-1938-475a-aba4-a74271b60e5b' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:6360e0cb-1938-475a-aba4-a74271b60e5b', 6, NULL, 'Apollyon: The Fight', 'Scenes Adapted from Bunyan’s Pilgrim’s Progress: Apollyon: The Fight', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 9012 AND p.composer_id = 69
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:6360e0cb-1938-475a-aba4-a74271b60e5b'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 7, part.movement_number = NULL,
    part.name_ko = 'The Angel’s Song', part.name_en = 'Scenes Adapted from Bunyan’s Pilgrim’s Progress: The Angel’s Song',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 9012 AND p.composer_id = 69 AND part.part_key = 'musicbrainz:e6632104-bd46-4860-a330-4b5ea958b32e' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:e6632104-bd46-4860-a330-4b5ea958b32e', 7, NULL, 'The Angel’s Song', 'Scenes Adapted from Bunyan’s Pilgrim’s Progress: The Angel’s Song', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 9012 AND p.composer_id = 69
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:e6632104-bd46-4860-a330-4b5ea958b32e'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 8, part.movement_number = NULL,
    part.name_ko = 'Down Among the Dead Men', part.name_en = 'Scenes Adapted from Bunyan’s Pilgrim’s Progress: Down Among the Dead Men',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 9012 AND p.composer_id = 69 AND part.part_key = 'musicbrainz:9c8ce9da-f531-49b9-b53d-e58c01c2face' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:9c8ce9da-f531-49b9-b53d-e58c01c2face', 8, NULL, 'Down Among the Dead Men', 'Scenes Adapted from Bunyan’s Pilgrim’s Progress: Down Among the Dead Men', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 9012 AND p.composer_id = 69
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:9c8ce9da-f531-49b9-b53d-e58c01c2face'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 9, part.movement_number = NULL,
    part.name_ko = 'Vanity Fair: End of Scene', part.name_en = 'Scenes Adapted from Bunyan’s Pilgrim’s Progress: Vanity Fair: End of Scene',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 9012 AND p.composer_id = 69 AND part.part_key = 'musicbrainz:2fb33a79-4a91-4a1e-bdb7-a5e015e0445a' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:2fb33a79-4a91-4a1e-bdb7-a5e015e0445a', 9, NULL, 'Vanity Fair: End of Scene', 'Scenes Adapted from Bunyan’s Pilgrim’s Progress: Vanity Fair: End of Scene', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 9012 AND p.composer_id = 69
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:2fb33a79-4a91-4a1e-bdb7-a5e015e0445a'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 10, part.movement_number = NULL,
    part.name_ko = 'The Death of Faithful', part.name_en = 'Scenes Adapted from Bunyan’s Pilgrim’s Progress: The Death of Faithful',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 9012 AND p.composer_id = 69 AND part.part_key = 'musicbrainz:3402fbcf-d24d-4e25-9415-6db7154637d4' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:3402fbcf-d24d-4e25-9415-6db7154637d4', 10, NULL, 'The Death of Faithful', 'Scenes Adapted from Bunyan’s Pilgrim’s Progress: The Death of Faithful', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 9012 AND p.composer_id = 69
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:3402fbcf-d24d-4e25-9415-6db7154637d4'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 11, part.movement_number = NULL,
    part.name_ko = 'Shepherd’s Song', part.name_en = 'Scenes Adapted from Bunyan’s Pilgrim’s Progress: Shepherd’s Song',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 9012 AND p.composer_id = 69 AND part.part_key = 'musicbrainz:ad5e641b-f9a7-4e1e-905c-e881b2688c95' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:ad5e641b-f9a7-4e1e-905c-e881b2688c95', 11, NULL, 'Shepherd’s Song', 'Scenes Adapted from Bunyan’s Pilgrim’s Progress: Shepherd’s Song', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 9012 AND p.composer_id = 69
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:ad5e641b-f9a7-4e1e-905c-e881b2688c95'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 12, part.movement_number = NULL,
    part.name_ko = 'Final Scene', part.name_en = 'Scenes Adapted from Bunyan’s Pilgrim’s Progress: Final Scene',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 9012 AND p.composer_id = 69 AND part.part_key = 'musicbrainz:e6b81543-a2dd-4eae-b8e6-8028fa58a3c3' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:e6b81543-a2dd-4eae-b8e6-8028fa58a3c3', 12, NULL, 'Final Scene', 'Scenes Adapted from Bunyan’s Pilgrim’s Progress: Final Scene', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 9012 AND p.composer_id = 69
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:e6b81543-a2dd-4eae-b8e6-8028fa58a3c3'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 13, part.movement_number = NULL,
    part.name_ko = 'Epilogue', part.name_en = 'Scenes Adapted from Bunyan’s Pilgrim’s Progress: Epilogue',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 9012 AND p.composer_id = 69 AND part.part_key = 'musicbrainz:f83de4a4-1b34-4d25-9c2b-9305aaf0ed00' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:f83de4a4-1b34-4d25-9c2b-9305aaf0ed00', 13, NULL, 'Epilogue', 'Scenes Adapted from Bunyan’s Pilgrim’s Progress: Epilogue', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 9012 AND p.composer_id = 69
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:f83de4a4-1b34-4d25-9c2b-9305aaf0ed00'
);


-- None 영화음악 <Scott of the Antarctic>

UPDATE pieces piece
SET piece.title = '영화음악 <Scott of the Antarctic>', piece.title_en = 'Scott of the Antarctic',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 10686 AND piece.composer_id = 69
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'Pony March', part.name_en = 'Pony March',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 10686 AND p.composer_id = 69 AND part.part_key = 'musicbrainz:008a6b3b-e12e-4dbb-a4a6-28362b2b4b49' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:008a6b3b-e12e-4dbb-a4a6-28362b2b4b49', 1, NULL, 'Pony March', 'Pony March', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 10686 AND p.composer_id = 69
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:008a6b3b-e12e-4dbb-a4a6-28362b2b4b49'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'Climbing the Glacier', part.name_en = 'Climbing the Glacier',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 10686 AND p.composer_id = 69 AND part.part_key = 'musicbrainz:0c8d8637-6f13-4e62-aff0-943b51166e00' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:0c8d8637-6f13-4e62-aff0-943b51166e00', 2, NULL, 'Climbing the Glacier', 'Climbing the Glacier', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 10686 AND p.composer_id = 69
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:0c8d8637-6f13-4e62-aff0-943b51166e00'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = NULL,
    part.name_ko = 'Pony March and Aphelion', part.name_en = 'Pony March and Aphelion',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 10686 AND p.composer_id = 69 AND part.part_key = 'musicbrainz:10836cea-1b39-4753-a5d8-b5bef8fc112c' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:10836cea-1b39-4753-a5d8-b5bef8fc112c', 3, NULL, 'Pony March and Aphelion', 'Pony March and Aphelion', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 10686 AND p.composer_id = 69
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:10836cea-1b39-4753-a5d8-b5bef8fc112c'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = NULL,
    part.name_ko = 'Penguin Dance', part.name_en = 'Penguin Dance',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 10686 AND p.composer_id = 69 AND part.part_key = 'musicbrainz:18c21424-22a4-40fe-82ed-1cd7654e398c' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:18c21424-22a4-40fe-82ed-1cd7654e398c', 4, NULL, 'Penguin Dance', 'Penguin Dance', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 10686 AND p.composer_id = 69
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:18c21424-22a4-40fe-82ed-1cd7654e398c'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 5, part.movement_number = NULL,
    part.name_ko = 'Kathleen 3', part.name_en = 'Kathleen 3',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 10686 AND p.composer_id = 69 AND part.part_key = 'musicbrainz:1dde4a4c-566a-4de2-8c88-d814ee129d57' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:1dde4a4c-566a-4de2-8c88-d814ee129d57', 5, NULL, 'Kathleen 3', 'Kathleen 3', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 10686 AND p.composer_id = 69
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:1dde4a4c-566a-4de2-8c88-d814ee129d57'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 6, part.movement_number = NULL,
    part.name_ko = 'Main Title (Heroism)', part.name_en = 'Main Title (Heroism)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 10686 AND p.composer_id = 69 AND part.part_key = 'musicbrainz:24b0c5e8-ba2d-4b8d-a9a2-ba519325fc9b' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:24b0c5e8-ba2d-4b8d-a9a2-ba519325fc9b', 6, NULL, 'Main Title (Heroism)', 'Main Title (Heroism)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 10686 AND p.composer_id = 69
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:24b0c5e8-ba2d-4b8d-a9a2-ba519325fc9b'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 7, part.movement_number = NULL,
    part.name_ko = 'Ice Floes', part.name_en = 'Ice Floes',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 10686 AND p.composer_id = 69 AND part.part_key = 'musicbrainz:2bbb3140-a07f-403e-bded-1d43b6e82244' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:2bbb3140-a07f-403e-bded-1d43b6e82244', 7, NULL, 'Ice Floes', 'Ice Floes', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 10686 AND p.composer_id = 69
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:2bbb3140-a07f-403e-bded-1d43b6e82244'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 8, part.movement_number = NULL,
    part.name_ko = 'Queen''s Birthday March', part.name_en = 'Queen''s Birthday March',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 10686 AND p.composer_id = 69 AND part.part_key = 'musicbrainz:2e35055f-111d-4451-8899-9e971affed5f' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:2e35055f-111d-4451-8899-9e971affed5f', 8, NULL, 'Queen''s Birthday March', 'Queen''s Birthday March', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 10686 AND p.composer_id = 69
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:2e35055f-111d-4451-8899-9e971affed5f'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 9, part.movement_number = NULL,
    part.name_ko = 'End Titles', part.name_en = 'End Titles',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 10686 AND p.composer_id = 69 AND part.part_key = 'musicbrainz:41ba9a35-e7c8-4962-9f57-b4dc6a3a65c7' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:41ba9a35-e7c8-4962-9f57-b4dc6a3a65c7', 9, NULL, 'End Titles', 'End Titles', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 10686 AND p.composer_id = 69
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:41ba9a35-e7c8-4962-9f57-b4dc6a3a65c7'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 10, part.movement_number = NULL,
    part.name_ko = 'Base Camp', part.name_en = 'Base Camp',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 10686 AND p.composer_id = 69 AND part.part_key = 'musicbrainz:42159a96-a8eb-400b-8220-dcc545237719' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:42159a96-a8eb-400b-8220-dcc545237719', 10, NULL, 'Base Camp', 'Base Camp', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 10686 AND p.composer_id = 69
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:42159a96-a8eb-400b-8220-dcc545237719'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 11, part.movement_number = NULL,
    part.name_ko = 'Ship''s Departure from Cardiff', part.name_en = 'Ship''s Departure from Cardiff',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 10686 AND p.composer_id = 69 AND part.part_key = 'musicbrainz:470d0a61-34e4-4f15-b072-c537af18aa28' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:470d0a61-34e4-4f15-b072-c537af18aa28', 11, NULL, 'Ship''s Departure from Cardiff', 'Ship''s Departure from Cardiff', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 10686 AND p.composer_id = 69
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:470d0a61-34e4-4f15-b072-c537af18aa28'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 12, part.movement_number = NULL,
    part.name_ko = 'Oriana (Wilson''s Wife)', part.name_en = 'Oriana (Wilson''s Wife)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 10686 AND p.composer_id = 69 AND part.part_key = 'musicbrainz:4e485921-a631-49b5-96f7-1fc5fa59c9c6' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:4e485921-a631-49b5-96f7-1fc5fa59c9c6', 12, NULL, 'Oriana (Wilson''s Wife)', 'Oriana (Wilson''s Wife)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 10686 AND p.composer_id = 69
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:4e485921-a631-49b5-96f7-1fc5fa59c9c6'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 13, part.movement_number = NULL,
    part.name_ko = 'The Return', part.name_en = 'The Return',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 10686 AND p.composer_id = 69 AND part.part_key = 'musicbrainz:5029420b-4d6d-4e04-a589-891c15a91661' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:5029420b-4d6d-4e04-a589-891c15a91661', 13, NULL, 'The Return', 'The Return', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 10686 AND p.composer_id = 69
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:5029420b-4d6d-4e04-a589-891c15a91661'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 14, part.movement_number = NULL,
    part.name_ko = 'Penguins', part.name_en = 'Penguins',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 10686 AND p.composer_id = 69 AND part.part_key = 'musicbrainz:50486442-b4a6-457a-9244-5bddfee68202' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:50486442-b4a6-457a-9244-5bddfee68202', 14, NULL, 'Penguins', 'Penguins', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 10686 AND p.composer_id = 69
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:50486442-b4a6-457a-9244-5bddfee68202'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 15, part.movement_number = NULL,
    part.name_ko = 'Ice Floes', part.name_en = 'Ice Floes',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 10686 AND p.composer_id = 69 AND part.part_key = 'musicbrainz:50c48832-1834-4d4f-8df9-578865944e98' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:50c48832-1834-4d4f-8df9-578865944e98', 15, NULL, 'Ice Floes', 'Ice Floes', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 10686 AND p.composer_id = 69
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:50c48832-1834-4d4f-8df9-578865944e98'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 16, part.movement_number = NULL,
    part.name_ko = 'Aurora 1', part.name_en = 'Aurora 1',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 10686 AND p.composer_id = 69 AND part.part_key = 'musicbrainz:55a57a13-0fb7-477c-a320-5b4ff3a39cc1' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:55a57a13-0fb7-477c-a320-5b4ff3a39cc1', 16, NULL, 'Aurora 1', 'Aurora 1', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 10686 AND p.composer_id = 69
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:55a57a13-0fb7-477c-a320-5b4ff3a39cc1'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 17, part.movement_number = NULL,
    part.name_ko = 'Polar Party Departs 2', part.name_en = 'Polar Party Departs 2',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 10686 AND p.composer_id = 69 AND part.part_key = 'musicbrainz:563087f0-c698-4d5e-b521-bf2370ecd340' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:563087f0-c698-4d5e-b521-bf2370ecd340', 17, NULL, 'Polar Party Departs 2', 'Polar Party Departs 2', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 10686 AND p.composer_id = 69
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:563087f0-c698-4d5e-b521-bf2370ecd340'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 18, part.movement_number = NULL,
    part.name_ko = 'Pony March (Baltic Fleet)', part.name_en = 'Pony March (Baltic Fleet)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 10686 AND p.composer_id = 69 AND part.part_key = 'musicbrainz:569970a9-1e2c-4dfe-85ec-ce33a4c629b1' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:569970a9-1e2c-4dfe-85ec-ce33a4c629b1', 18, NULL, 'Pony March (Baltic Fleet)', 'Pony March (Baltic Fleet)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 10686 AND p.composer_id = 69
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:569970a9-1e2c-4dfe-85ec-ce33a4c629b1'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 19, part.movement_number = NULL,
    part.name_ko = 'Aurora', part.name_en = 'Aurora',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 10686 AND p.composer_id = 69 AND part.part_key = 'musicbrainz:6c3ff67d-8878-4336-82fb-d566517f752b' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:6c3ff67d-8878-4336-82fb-d566517f752b', 19, NULL, 'Aurora', 'Aurora', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 10686 AND p.composer_id = 69
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:6c3ff67d-8878-4336-82fb-d566517f752b'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 20, part.movement_number = NULL,
    part.name_ko = 'Blizzard', part.name_en = 'Blizzard',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 10686 AND p.composer_id = 69 AND part.part_key = 'musicbrainz:70d2d7bf-d779-4844-8892-9d2776ac8545' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:70d2d7bf-d779-4844-8892-9d2776ac8545', 20, NULL, 'Blizzard', 'Blizzard', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 10686 AND p.composer_id = 69
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:70d2d7bf-d779-4844-8892-9d2776ac8545'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 21, part.movement_number = NULL,
    part.name_ko = 'Only Eleven Miles', part.name_en = 'Only Eleven Miles',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 10686 AND p.composer_id = 69 AND part.part_key = 'musicbrainz:7780aed7-9bc0-4a9c-8f7d-15a33fd4a479' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:7780aed7-9bc0-4a9c-8f7d-15a33fd4a479', 21, NULL, 'Only Eleven Miles', 'Only Eleven Miles', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 10686 AND p.composer_id = 69
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:7780aed7-9bc0-4a9c-8f7d-15a33fd4a479'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 22, part.movement_number = NULL,
    part.name_ko = 'The Discovery of the Tent and Bodies', part.name_en = 'The Discovery of the Tent and Bodies',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 10686 AND p.composer_id = 69 AND part.part_key = 'musicbrainz:7a657718-68b6-477a-9488-3e9a2807462d' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:7a657718-68b6-477a-9488-3e9a2807462d', 22, NULL, 'The Discovery of the Tent and Bodies', 'The Discovery of the Tent and Bodies', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 10686 AND p.composer_id = 69
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:7a657718-68b6-477a-9488-3e9a2807462d'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 23, part.movement_number = NULL,
    part.name_ko = 'Pony March 2', part.name_en = 'Pony March 2',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 10686 AND p.composer_id = 69 AND part.part_key = 'musicbrainz:80bf9f1d-8708-46aa-9908-1533108e751f' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:80bf9f1d-8708-46aa-9908-1533108e751f', 23, NULL, 'Pony March 2', 'Pony March 2', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 10686 AND p.composer_id = 69
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:80bf9f1d-8708-46aa-9908-1533108e751f'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 24, part.movement_number = NULL,
    part.name_ko = 'Distant Glacier', part.name_en = 'Distant Glacier',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 10686 AND p.composer_id = 69 AND part.part_key = 'musicbrainz:89cd949b-6630-41f8-b443-2ec22e4c0364' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:89cd949b-6630-41f8-b443-2ec22e4c0364', 24, NULL, 'Distant Glacier', 'Distant Glacier', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 10686 AND p.composer_id = 69
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:89cd949b-6630-41f8-b443-2ec22e4c0364'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 25, part.movement_number = NULL,
    part.name_ko = 'Descending the Glacier', part.name_en = 'Descending the Glacier',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 10686 AND p.composer_id = 69 AND part.part_key = 'musicbrainz:9104d1a6-772b-426b-9da0-224cfed869dc' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:9104d1a6-772b-426b-9da0-224cfed869dc', 25, NULL, 'Descending the Glacier', 'Descending the Glacier', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 10686 AND p.composer_id = 69
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:9104d1a6-772b-426b-9da0-224cfed869dc'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 26, part.movement_number = NULL,
    part.name_ko = 'Scott and Oates in the Rain', part.name_en = 'Scott and Oates in the Rain',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 10686 AND p.composer_id = 69 AND part.part_key = 'musicbrainz:94816e9d-77a6-4c0f-8eaa-6359384116b9' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:94816e9d-77a6-4c0f-8eaa-6359384116b9', 26, NULL, 'Scott and Oates in the Rain', 'Scott and Oates in the Rain', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 10686 AND p.composer_id = 69
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:94816e9d-77a6-4c0f-8eaa-6359384116b9'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 27, part.movement_number = NULL,
    part.name_ko = 'Oriana''s First Meeting With Scott', part.name_en = 'Oriana''s First Meeting With Scott',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 10686 AND p.composer_id = 69 AND part.part_key = 'musicbrainz:952cb532-14cc-4129-81ac-09fe5ff4666e' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:952cb532-14cc-4129-81ac-09fe5ff4666e', 27, NULL, 'Oriana''s First Meeting With Scott', 'Oriana''s First Meeting With Scott', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 10686 AND p.composer_id = 69
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:952cb532-14cc-4129-81ac-09fe5ff4666e'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 28, part.movement_number = NULL,
    part.name_ko = 'Black Flag', part.name_en = 'Black Flag',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 10686 AND p.composer_id = 69 AND part.part_key = 'musicbrainz:989b256e-39d0-44a6-8372-ba482c436a4f' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:989b256e-39d0-44a6-8372-ba482c436a4f', 28, NULL, 'Black Flag', 'Black Flag', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 10686 AND p.composer_id = 69
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:989b256e-39d0-44a6-8372-ba482c436a4f'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 29, part.movement_number = NULL,
    part.name_ko = 'The Return', part.name_en = 'The Return',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 10686 AND p.composer_id = 69 AND part.part_key = 'musicbrainz:98b8ce52-29c6-4960-83bb-c80f191e80e1' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:98b8ce52-29c6-4960-83bb-c80f191e80e1', 29, NULL, 'The Return', 'The Return', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 10686 AND p.composer_id = 69
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:98b8ce52-29c6-4960-83bb-c80f191e80e1'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 30, part.movement_number = NULL,
    part.name_ko = 'The Deaths of Evans and Oates', part.name_en = 'The Deaths of Evans and Oates',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 10686 AND p.composer_id = 69 AND part.part_key = 'musicbrainz:9acf01b2-5c42-4b54-b6ab-d570a386533c' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:9acf01b2-5c42-4b54-b6ab-d570a386533c', 30, NULL, 'The Deaths of Evans and Oates', 'The Deaths of Evans and Oates', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 10686 AND p.composer_id = 69
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:9acf01b2-5c42-4b54-b6ab-d570a386533c'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 31, part.movement_number = NULL,
    part.name_ko = 'Aurora 2', part.name_en = 'Aurora 2',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 10686 AND p.composer_id = 69 AND part.part_key = 'musicbrainz:a7b13664-4c1a-4f3c-b07b-4c3fb4a095be' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:a7b13664-4c1a-4f3c-b07b-4c3fb4a095be', 31, NULL, 'Aurora 2', 'Aurora 2', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 10686 AND p.composer_id = 69
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:a7b13664-4c1a-4f3c-b07b-4c3fb4a095be'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 32, part.movement_number = NULL,
    part.name_ko = 'Kathleen Scott and Her Husband', part.name_en = 'Kathleen Scott and Her Husband',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 10686 AND p.composer_id = 69 AND part.part_key = 'musicbrainz:b5b8ac2f-2805-49cc-8eb3-f2ea6670e4ea' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:b5b8ac2f-2805-49cc-8eb3-f2ea6670e4ea', 32, NULL, 'Kathleen Scott and Her Husband', 'Kathleen Scott and Her Husband', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 10686 AND p.composer_id = 69
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:b5b8ac2f-2805-49cc-8eb3-f2ea6670e4ea'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 33, part.movement_number = NULL,
    part.name_ko = 'Polar Party Departs 1', part.name_en = 'Polar Party Departs 1',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 10686 AND p.composer_id = 69 AND part.part_key = 'musicbrainz:b635ddc2-77a7-4648-b4b1-5aaaaa00cb16' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:b635ddc2-77a7-4648-b4b1-5aaaaa00cb16', 33, NULL, 'Polar Party Departs 1', 'Polar Party Departs 1', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 10686 AND p.composer_id = 69
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:b635ddc2-77a7-4648-b4b1-5aaaaa00cb16'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 34, part.movement_number = NULL,
    part.name_ko = 'Snow Plain', part.name_en = 'Snow Plain',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 10686 AND p.composer_id = 69 AND part.part_key = 'musicbrainz:b63b3c76-7000-49d4-a8d8-cf49b43a9e12' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:b63b3c76-7000-49d4-a8d8-cf49b43a9e12', 34, NULL, 'Snow Plain', 'Snow Plain', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 10686 AND p.composer_id = 69
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:b63b3c76-7000-49d4-a8d8-cf49b43a9e12'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 35, part.movement_number = NULL,
    part.name_ko = 'Amundsen', part.name_en = 'Amundsen',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 10686 AND p.composer_id = 69 AND part.part_key = 'musicbrainz:b86a181e-99b1-42b6-ac42-5e92ddccac44' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:b86a181e-99b1-42b6-ac42-5e92ddccac44', 35, NULL, 'Amundsen', 'Amundsen', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 10686 AND p.composer_id = 69
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:b86a181e-99b1-42b6-ac42-5e92ddccac44'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 36, part.movement_number = NULL,
    part.name_ko = 'Departure From Ross Island', part.name_en = 'Departure From Ross Island',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 10686 AND p.composer_id = 69 AND part.part_key = 'musicbrainz:c8eebc4c-bc91-49e0-bd27-9c140caf1740' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:c8eebc4c-bc91-49e0-bd27-9c140caf1740', 36, NULL, 'Departure From Ross Island', 'Departure From Ross Island', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 10686 AND p.composer_id = 69
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:c8eebc4c-bc91-49e0-bd27-9c140caf1740'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 37, part.movement_number = NULL,
    part.name_ko = 'Main Titles', part.name_en = 'Main Titles',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 10686 AND p.composer_id = 69 AND part.part_key = 'musicbrainz:cd37b700-633d-4763-9979-0327f2666097' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:cd37b700-633d-4763-9979-0327f2666097', 37, NULL, 'Main Titles', 'Main Titles', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 10686 AND p.composer_id = 69
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:cd37b700-633d-4763-9979-0327f2666097'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 38, part.movement_number = NULL,
    part.name_ko = 'Scott on the Glacier', part.name_en = 'Scott on the Glacier',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 10686 AND p.composer_id = 69 AND part.part_key = 'musicbrainz:db2a91cc-e667-45a7-8ae6-3a2933d816a1' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:db2a91cc-e667-45a7-8ae6-3a2933d816a1', 38, NULL, 'Scott on the Glacier', 'Scott on the Glacier', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 10686 AND p.composer_id = 69
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:db2a91cc-e667-45a7-8ae6-3a2933d816a1'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 39, part.movement_number = NULL,
    part.name_ko = 'Prologue', part.name_en = 'Prologue',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 10686 AND p.composer_id = 69 AND part.part_key = 'musicbrainz:db5b7418-d176-4b3f-a126-df59f9e04776' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:db5b7418-d176-4b3f-a126-df59f9e04776', 39, NULL, 'Prologue', 'Prologue', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 10686 AND p.composer_id = 69
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:db5b7418-d176-4b3f-a126-df59f9e04776'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 40, part.movement_number = NULL,
    part.name_ko = 'Iceberg', part.name_en = 'Iceberg',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 10686 AND p.composer_id = 69 AND part.part_key = 'musicbrainz:dde26b98-ebb2-4429-8315-b8f4de7e28ce' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:dde26b98-ebb2-4429-8315-b8f4de7e28ce', 40, NULL, 'Iceberg', 'Iceberg', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 10686 AND p.composer_id = 69
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:dde26b98-ebb2-4429-8315-b8f4de7e28ce'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 41, part.movement_number = NULL,
    part.name_ko = 'Blizzard', part.name_en = 'Blizzard',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 10686 AND p.composer_id = 69 AND part.part_key = 'musicbrainz:ef84c59b-b772-47c8-88bb-b8e397419e46' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:ef84c59b-b772-47c8-88bb-b8e397419e46', 41, NULL, 'Blizzard', 'Blizzard', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 10686 AND p.composer_id = 69
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:ef84c59b-b772-47c8-88bb-b8e397419e46'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 42, part.movement_number = NULL,
    part.name_ko = 'March', part.name_en = 'No. 101 March',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 10686 AND p.composer_id = 69 AND part.part_key = 'musicbrainz:f2bbe7aa-4e3a-4ba2-bfb8-4cf05cb81f67' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:f2bbe7aa-4e3a-4ba2-bfb8-4cf05cb81f67', 42, NULL, 'March', 'No. 101 March', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 10686 AND p.composer_id = 69
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:f2bbe7aa-4e3a-4ba2-bfb8-4cf05cb81f67'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 43, part.movement_number = NULL,
    part.name_ko = 'Office', part.name_en = 'Office',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 10686 AND p.composer_id = 69 AND part.part_key = 'musicbrainz:f2edf42d-b070-458c-bb27-03b0bf939ce9' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:f2edf42d-b070-458c-bb27-03b0bf939ce9', 43, NULL, 'Office', 'Office', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 10686 AND p.composer_id = 69
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:f2edf42d-b070-458c-bb27-03b0bf939ce9'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 44, part.movement_number = NULL,
    part.name_ko = 'Nansen', part.name_en = 'Nansen',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 10686 AND p.composer_id = 69 AND part.part_key = 'musicbrainz:f442315d-6305-4b38-970b-0556a9ebbbac' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:f442315d-6305-4b38-970b-0556a9ebbbac', 44, NULL, 'Nansen', 'Nansen', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 10686 AND p.composer_id = 69
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:f442315d-6305-4b38-970b-0556a9ebbbac'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 45, part.movement_number = NULL,
    part.name_ko = 'Final Music', part.name_en = 'Final Music',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 10686 AND p.composer_id = 69 AND part.part_key = 'musicbrainz:fedd5ee0-1754-4618-bb13-53393524fb64' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:fedd5ee0-1754-4618-bb13-53393524fb64', 45, NULL, 'Final Music', 'Final Music', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 10686 AND p.composer_id = 69
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:fedd5ee0-1754-4618-bb13-53393524fb64'
);


-- None Sea Songs from the Motherland Song Book, Vol. IV

UPDATE pieces piece
SET piece.title = 'Sea Songs from the Motherland Song Book, Vol. IV', piece.title_en = 'Sea Songs from the Motherland Song Book, Vol. IV',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 9143 AND piece.composer_id = 69
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None 세레나데 A단조

UPDATE pieces piece
SET piece.title = '세레나데 A단조', piece.title_en = 'Serenade in A minor',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 11181 AND piece.composer_id = 69
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'Prelude', part.name_en = 'Serenade in A minor: I. Prelude',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11181 AND p.composer_id = 69 AND part.part_key = 'musicbrainz:36caef96-1569-4062-bd97-ffa2d31db901' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:36caef96-1569-4062-bd97-ffa2d31db901', 1, 'I', 'Prelude', 'Serenade in A minor: I. Prelude', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 11181 AND p.composer_id = 69
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:36caef96-1569-4062-bd97-ffa2d31db901'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'Scherzo', part.name_en = 'Serenade in A minor: II. Scherzo',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11181 AND p.composer_id = 69 AND part.part_key = 'musicbrainz:8fbd205b-a31a-4761-a522-82d5fb1d17ad' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:8fbd205b-a31a-4761-a522-82d5fb1d17ad', 2, 'II', 'Scherzo', 'Serenade in A minor: II. Scherzo', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 11181 AND p.composer_id = 69
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:8fbd205b-a31a-4761-a522-82d5fb1d17ad'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = 'Intermezzo & Trio', part.name_en = 'Serenade in A minor: III. Intermezzo & Trio',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11181 AND p.composer_id = 69 AND part.part_key = 'musicbrainz:8296ec8c-3a4d-4583-b157-0822452618f8' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:8296ec8c-3a4d-4583-b157-0822452618f8', 3, 'III', 'Intermezzo & Trio', 'Serenade in A minor: III. Intermezzo & Trio', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 11181 AND p.composer_id = 69
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:8296ec8c-3a4d-4583-b157-0822452618f8'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = 'IV',
    part.name_ko = 'Romance', part.name_en = 'Serenade in A minor: IV. Romance',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11181 AND p.composer_id = 69 AND part.part_key = 'musicbrainz:ee7ed9f9-57bb-4ce7-a789-5672835d39ef' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:ee7ed9f9-57bb-4ce7-a789-5672835d39ef', 4, 'IV', 'Romance', 'Serenade in A minor: IV. Romance', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 11181 AND p.composer_id = 69
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:ee7ed9f9-57bb-4ce7-a789-5672835d39ef'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 5, part.movement_number = 'V',
    part.name_ko = 'Finale', part.name_en = 'Serenade in A minor: V. Finale',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11181 AND p.composer_id = 69 AND part.part_key = 'musicbrainz:8b6a5d43-bbd8-4f14-99b0-5258da109bce' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:8b6a5d43-bbd8-4f14-99b0-5258da109bce', 5, 'V', 'Finale', 'Serenade in A minor: V. Finale', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 11181 AND p.composer_id = 69
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:8b6a5d43-bbd8-4f14-99b0-5258da109bce'
);


-- None Silence and Music

UPDATE pieces piece
SET piece.title = 'Silence and Music', piece.title_en = 'Silence and Music',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 11111 AND piece.composer_id = 69
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None 가곡 <Six English Folk Songs>

UPDATE pieces piece
SET piece.title = '가곡 <Six English Folk Songs>', piece.title_en = 'Six English Folk Songs',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 7480 AND piece.composer_id = 69
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'Robin Hood and the Pedlar', part.name_en = 'Robin Hood and the Pedlar',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 7480 AND p.composer_id = 69 AND part.part_key = 'musicbrainz:018fea19-65b2-499a-9ec4-ca07e4e24ab3' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:018fea19-65b2-499a-9ec4-ca07e4e24ab3', 1, NULL, 'Robin Hood and the Pedlar', 'Robin Hood and the Pedlar', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 7480 AND p.composer_id = 69
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:018fea19-65b2-499a-9ec4-ca07e4e24ab3'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'The Ploughman', part.name_en = 'The Ploughman',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 7480 AND p.composer_id = 69 AND part.part_key = 'musicbrainz:28529096-90a1-4169-ab76-3cce1bd5c7af' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:28529096-90a1-4169-ab76-3cce1bd5c7af', 2, NULL, 'The Ploughman', 'The Ploughman', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 7480 AND p.composer_id = 69
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:28529096-90a1-4169-ab76-3cce1bd5c7af'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = NULL,
    part.name_ko = 'The Brewer', part.name_en = 'The Brewer',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 7480 AND p.composer_id = 69 AND part.part_key = 'musicbrainz:60957df3-124c-41cb-9c5b-0ffe06835a31' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:60957df3-124c-41cb-9c5b-0ffe06835a31', 3, NULL, 'The Brewer', 'The Brewer', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 7480 AND p.composer_id = 69
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:60957df3-124c-41cb-9c5b-0ffe06835a31'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = NULL,
    part.name_ko = 'King William', part.name_en = 'King William',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 7480 AND p.composer_id = 69 AND part.part_key = 'musicbrainz:a2a370f7-fe6a-4e1e-b8ca-cd10f8b3f1ad' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:a2a370f7-fe6a-4e1e-b8ca-cd10f8b3f1ad', 4, NULL, 'King William', 'King William', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 7480 AND p.composer_id = 69
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:a2a370f7-fe6a-4e1e-b8ca-cd10f8b3f1ad'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 5, part.movement_number = NULL,
    part.name_ko = 'One man, two men (a.k.a. The Harvest folk song)', part.name_en = 'One man, two men (a.k.a. The Harvest folk song)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 7480 AND p.composer_id = 69 AND part.part_key = 'musicbrainz:fc28c146-007b-41df-8d16-9b54ce722be3' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:fc28c146-007b-41df-8d16-9b54ce722be3', 5, NULL, 'One man, two men (a.k.a. The Harvest folk song)', 'One man, two men (a.k.a. The Harvest folk song)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 7480 AND p.composer_id = 69
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:fc28c146-007b-41df-8d16-9b54ce722be3'
);


-- None Snow in the Street

UPDATE pieces piece
SET piece.title = 'Snow in the Street', piece.title_en = 'Snow in the Street',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 11216 AND piece.composer_id = 69
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None 현악 4중주 1번 G단조

UPDATE pieces piece
SET piece.title = '현악 4중주 1번 G단조', piece.title_en = 'String Quartet no. 1 in G minor',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 8046 AND piece.composer_id = 69
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'Allegro moderato', part.name_en = 'String Quartet no. 1 in G minor: I. Allegro moderato',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 8046 AND p.composer_id = 69 AND part.part_key = 'musicbrainz:419b0e77-d18b-3716-b016-810ccb4a288c' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:419b0e77-d18b-3716-b016-810ccb4a288c', 1, 'I', 'Allegro moderato', 'String Quartet no. 1 in G minor: I. Allegro moderato', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 8046 AND p.composer_id = 69
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:419b0e77-d18b-3716-b016-810ccb4a288c'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'Minuet and Trio: Tempo di minuetto', part.name_en = 'String Quartet no. 1 in G minor: II. Minuet and Trio: Tempo di minuetto',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 8046 AND p.composer_id = 69 AND part.part_key = 'musicbrainz:8775b089-0799-36b2-b1ce-0430397cfecd' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:8775b089-0799-36b2-b1ce-0430397cfecd', 2, 'II', 'Minuet and Trio: Tempo di minuetto', 'String Quartet no. 1 in G minor: II. Minuet and Trio: Tempo di minuetto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 8046 AND p.composer_id = 69
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:8775b089-0799-36b2-b1ce-0430397cfecd'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = 'Romance: Andante sostenuto', part.name_en = 'String Quartet no. 1 in G minor: III. Romance: Andante sostenuto',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 8046 AND p.composer_id = 69 AND part.part_key = 'musicbrainz:1e45c818-0d20-3d57-a875-76f0538c2b55' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:1e45c818-0d20-3d57-a875-76f0538c2b55', 3, 'III', 'Romance: Andante sostenuto', 'String Quartet no. 1 in G minor: III. Romance: Andante sostenuto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 8046 AND p.composer_id = 69
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:1e45c818-0d20-3d57-a875-76f0538c2b55'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = 'IV',
    part.name_ko = 'Finale: Rondo Capriccioso - Allegro molto', part.name_en = 'String Quartet no. 1 in G minor: IV. Finale: Rondo Capriccioso - Allegro molto',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 8046 AND p.composer_id = 69 AND part.part_key = 'musicbrainz:307a4b36-9899-32fe-b103-f4d4057472a0' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:307a4b36-9899-32fe-b103-f4d4057472a0', 4, 'IV', 'Finale: Rondo Capriccioso - Allegro molto', 'String Quartet no. 1 in G minor: IV. Finale: Rondo Capriccioso - Allegro molto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 8046 AND p.composer_id = 69
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:307a4b36-9899-32fe-b103-f4d4057472a0'
);


-- None 현악 4중주 2번 A단조

UPDATE pieces piece
SET piece.title = '현악 4중주 2번 A단조', piece.title_en = 'String Quartet no. 2 in A minor',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 7627 AND piece.composer_id = 69
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'Prelude: Allegro appassionato', part.name_en = 'String Quartet no. 2 in A minor: I. Prelude: Allegro appassionato',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 7627 AND p.composer_id = 69 AND part.part_key = 'musicbrainz:3a33e237-e6b1-3a80-aa02-081d3cd3f182' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:3a33e237-e6b1-3a80-aa02-081d3cd3f182', 1, 'I', 'Prelude: Allegro appassionato', 'String Quartet no. 2 in A minor: I. Prelude: Allegro appassionato', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 7627 AND p.composer_id = 69
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:3a33e237-e6b1-3a80-aa02-081d3cd3f182'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'Romance: Largo', part.name_en = 'String Quartet no. 2 in A minor: II. Romance: Largo',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 7627 AND p.composer_id = 69 AND part.part_key = 'musicbrainz:34a961bb-6ced-3682-9a55-73fea6bd12c6' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:34a961bb-6ced-3682-9a55-73fea6bd12c6', 2, 'II', 'Romance: Largo', 'String Quartet no. 2 in A minor: II. Romance: Largo', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 7627 AND p.composer_id = 69
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:34a961bb-6ced-3682-9a55-73fea6bd12c6'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = 'Scherzo: Allegro', part.name_en = 'String Quartet no. 2 in A minor: III. Scherzo: Allegro',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 7627 AND p.composer_id = 69 AND part.part_key = 'musicbrainz:d8b119e3-3d55-3e84-847a-1c1a115da95f' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:d8b119e3-3d55-3e84-847a-1c1a115da95f', 3, 'III', 'Scherzo: Allegro', 'String Quartet no. 2 in A minor: III. Scherzo: Allegro', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 7627 AND p.composer_id = 69
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:d8b119e3-3d55-3e84-847a-1c1a115da95f'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = 'IV',
    part.name_ko = 'Epilogue: Andante sostenuto', part.name_en = 'String Quartet no. 2 in A minor: IV. Epilogue: Andante sostenuto',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 7627 AND p.composer_id = 69 AND part.part_key = 'musicbrainz:82514909-0abd-382a-b716-a5dd7004de4c' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:82514909-0abd-382a-b716-a5dd7004de4c', 4, 'IV', 'Epilogue: Andante sostenuto', 'String Quartet no. 2 in A minor: IV. Epilogue: Andante sostenuto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 7627 AND p.composer_id = 69
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:82514909-0abd-382a-b716-a5dd7004de4c'
);


-- None Suite de Ballet

UPDATE pieces piece
SET piece.title = 'Suite de Ballet', piece.title_en = 'Suite de Ballet',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 11184 AND piece.composer_id = 69
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'III',
    part.name_ko = 'Gavotte', part.name_en = 'Suite de ballet: III. Gavotte',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11184 AND p.composer_id = 69 AND part.part_key = 'musicbrainz:41b10be3-5690-465b-99b2-d428d6331cc4' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:41b10be3-5690-465b-99b2-d428d6331cc4', 1, 'III', 'Gavotte', 'Suite de ballet: III. Gavotte', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 11184 AND p.composer_id = 69
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:41b10be3-5690-465b-99b2-d428d6331cc4'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'IV',
    part.name_ko = 'Passepied', part.name_en = 'Suite de ballet: IV. Passepied',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11184 AND p.composer_id = 69 AND part.part_key = 'musicbrainz:46b636e3-9911-433e-8695-e1838260f2c7' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:46b636e3-9911-433e-8695-e1838260f2c7', 2, 'IV', 'Passepied', 'Suite de ballet: IV. Passepied', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 11184 AND p.composer_id = 69
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:46b636e3-9911-433e-8695-e1838260f2c7'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'I',
    part.name_ko = 'Improvisation', part.name_en = 'Suite de ballet: I. Improvisation',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11184 AND p.composer_id = 69 AND part.part_key = 'musicbrainz:6c17b01d-5c37-4c65-9be0-36bde27e5d8d' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:6c17b01d-5c37-4c65-9be0-36bde27e5d8d', 3, 'I', 'Improvisation', 'Suite de ballet: I. Improvisation', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 11184 AND p.composer_id = 69
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:6c17b01d-5c37-4c65-9be0-36bde27e5d8d'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = 'II',
    part.name_ko = 'Humoresque', part.name_en = 'Suite de ballet: II. Humoresque',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11184 AND p.composer_id = 69 AND part.part_key = 'musicbrainz:7618822a-3362-4f48-88a1-a141197ddd0f' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:7618822a-3362-4f48-88a1-a141197ddd0f', 4, 'II', 'Humoresque', 'Suite de ballet: II. Humoresque', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 11184 AND p.composer_id = 69
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:7618822a-3362-4f48-88a1-a141197ddd0f'
);


-- None 비올라 모음곡

UPDATE pieces piece
SET piece.title = '비올라 모음곡', piece.title_en = 'Suite for Viola and Orchestra',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 10015 AND piece.composer_id = 69
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'Group 1: I. Prelude', part.name_en = 'Suite for Viola and Orchestra: Group 1: I. Prelude',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 10015 AND p.composer_id = 69 AND part.part_key = 'musicbrainz:ecab0d62-041a-42be-921b-ae9c2ae18ccb' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:ecab0d62-041a-42be-921b-ae9c2ae18ccb', 1, NULL, 'Group 1: I. Prelude', 'Suite for Viola and Orchestra: Group 1: I. Prelude', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 10015 AND p.composer_id = 69
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:ecab0d62-041a-42be-921b-ae9c2ae18ccb'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'Group 1: II. Carol', part.name_en = 'Suite for Viola and Orchestra: Group 1: II. Carol',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 10015 AND p.composer_id = 69 AND part.part_key = 'musicbrainz:921a7f9c-b3eb-4853-8f9b-3a927868b5c9' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:921a7f9c-b3eb-4853-8f9b-3a927868b5c9', 2, NULL, 'Group 1: II. Carol', 'Suite for Viola and Orchestra: Group 1: II. Carol', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 10015 AND p.composer_id = 69
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:921a7f9c-b3eb-4853-8f9b-3a927868b5c9'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = NULL,
    part.name_ko = 'Group 1: III. Christmas Dance', part.name_en = 'Suite for Viola and Orchestra: Group 1: III. Christmas Dance',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 10015 AND p.composer_id = 69 AND part.part_key = 'musicbrainz:b6cfe63a-ef42-4a17-b1a9-ea1a9c3d4871' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:b6cfe63a-ef42-4a17-b1a9-ea1a9c3d4871', 3, NULL, 'Group 1: III. Christmas Dance', 'Suite for Viola and Orchestra: Group 1: III. Christmas Dance', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 10015 AND p.composer_id = 69
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:b6cfe63a-ef42-4a17-b1a9-ea1a9c3d4871'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = NULL,
    part.name_ko = 'Group 2: IV. Ballad', part.name_en = 'Suite for Viola and Orchestra: Group 2: IV. Ballad',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 10015 AND p.composer_id = 69 AND part.part_key = 'musicbrainz:74cfd0bd-ea2b-42cf-b3a4-64bca63f67a9' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:74cfd0bd-ea2b-42cf-b3a4-64bca63f67a9', 4, NULL, 'Group 2: IV. Ballad', 'Suite for Viola and Orchestra: Group 2: IV. Ballad', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 10015 AND p.composer_id = 69
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:74cfd0bd-ea2b-42cf-b3a4-64bca63f67a9'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 5, part.movement_number = NULL,
    part.name_ko = 'Group 2: V. Moto Perpetuo', part.name_en = 'Suite for Viola and Orchestra: Group 2: V. Moto Perpetuo',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 10015 AND p.composer_id = 69 AND part.part_key = 'musicbrainz:217d6d6e-3863-42bc-8cf7-c0db8a210f52' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:217d6d6e-3863-42bc-8cf7-c0db8a210f52', 5, NULL, 'Group 2: V. Moto Perpetuo', 'Suite for Viola and Orchestra: Group 2: V. Moto Perpetuo', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 10015 AND p.composer_id = 69
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:217d6d6e-3863-42bc-8cf7-c0db8a210f52'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 6, part.movement_number = NULL,
    part.name_ko = 'Group 3: VI. Musette', part.name_en = 'Suite for Viola and Orchestra: Group 3: VI. Musette',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 10015 AND p.composer_id = 69 AND part.part_key = 'musicbrainz:5a8978fc-0769-46fb-9d56-e407b2bfa8ea' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:5a8978fc-0769-46fb-9d56-e407b2bfa8ea', 6, NULL, 'Group 3: VI. Musette', 'Suite for Viola and Orchestra: Group 3: VI. Musette', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 10015 AND p.composer_id = 69
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:5a8978fc-0769-46fb-9d56-e407b2bfa8ea'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 7, part.movement_number = NULL,
    part.name_ko = 'Group 3: VII. Polka', part.name_en = 'Suite for Viola and Orchestra: Group 3: VII. Polka',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 10015 AND p.composer_id = 69 AND part.part_key = 'musicbrainz:19e84f59-c137-405c-a9fa-642c7ba8c75e' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:19e84f59-c137-405c-a9fa-642c7ba8c75e', 7, NULL, 'Group 3: VII. Polka', 'Suite for Viola and Orchestra: Group 3: VII. Polka', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 10015 AND p.composer_id = 69
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:19e84f59-c137-405c-a9fa-642c7ba8c75e'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 8, part.movement_number = NULL,
    part.name_ko = 'Group 3: VIII. Galop', part.name_en = 'Suite for Viola and Orchestra: Group 3: VIII. Galop',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 10015 AND p.composer_id = 69 AND part.part_key = 'musicbrainz:37fdda8d-aff8-48e8-ba31-2641e7714ca2' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:37fdda8d-aff8-48e8-ba31-2641e7714ca2', 8, NULL, 'Group 3: VIII. Galop', 'Suite for Viola and Orchestra: Group 3: VIII. Galop', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 10015 AND p.composer_id = 69
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:37fdda8d-aff8-48e8-ba31-2641e7714ca2'
);


-- None Suite of Six Short Pieces for Piano

UPDATE pieces piece
SET piece.title = 'Suite of Six Short Pieces for Piano', piece.title_en = 'Suite of Six Short Pieces for Piano',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 8842 AND piece.composer_id = 69
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'Prelude', part.name_en = 'Suite of Six Short Pieces for Piano: No. 1. Prelude',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 8842 AND p.composer_id = 69 AND part.part_key = 'musicbrainz:33e94573-e7cb-4de8-87b1-2457ead19881' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:33e94573-e7cb-4de8-87b1-2457ead19881', 1, NULL, 'Prelude', 'Suite of Six Short Pieces for Piano: No. 1. Prelude', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 8842 AND p.composer_id = 69
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:33e94573-e7cb-4de8-87b1-2457ead19881'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'Slow dance', part.name_en = 'Suite of Six Short Pieces for Piano: No. 2. Slow dance',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 8842 AND p.composer_id = 69 AND part.part_key = 'musicbrainz:272df33b-c02d-40db-ac6a-112a04e96f5a' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:272df33b-c02d-40db-ac6a-112a04e96f5a', 2, NULL, 'Slow dance', 'Suite of Six Short Pieces for Piano: No. 2. Slow dance', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 8842 AND p.composer_id = 69
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:272df33b-c02d-40db-ac6a-112a04e96f5a'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = NULL,
    part.name_ko = 'Quick dance', part.name_en = 'Suite of Six Short Pieces for Piano: No. 3. Quick dance',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 8842 AND p.composer_id = 69 AND part.part_key = 'musicbrainz:f87f6ab7-b33c-46e6-9ee0-3e4312dcc841' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:f87f6ab7-b33c-46e6-9ee0-3e4312dcc841', 3, NULL, 'Quick dance', 'Suite of Six Short Pieces for Piano: No. 3. Quick dance', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 8842 AND p.composer_id = 69
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:f87f6ab7-b33c-46e6-9ee0-3e4312dcc841'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = NULL,
    part.name_ko = 'Slow air', part.name_en = 'Suite of Six Short Pieces for Piano: No. 4. Slow air',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 8842 AND p.composer_id = 69 AND part.part_key = 'musicbrainz:cf6a3e29-17a9-4253-83af-e43091272cf5' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:cf6a3e29-17a9-4253-83af-e43091272cf5', 4, NULL, 'Slow air', 'Suite of Six Short Pieces for Piano: No. 4. Slow air', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 8842 AND p.composer_id = 69
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:cf6a3e29-17a9-4253-83af-e43091272cf5'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 5, part.movement_number = NULL,
    part.name_ko = 'Rondo', part.name_en = 'Suite of Six Short Pieces for Piano: No. 5. Rondo',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 8842 AND p.composer_id = 69 AND part.part_key = 'musicbrainz:0673382b-d574-469e-928a-ffa8ef003a39' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:0673382b-d574-469e-928a-ffa8ef003a39', 5, NULL, 'Rondo', 'Suite of Six Short Pieces for Piano: No. 5. Rondo', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 8842 AND p.composer_id = 69
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:0673382b-d574-469e-928a-ffa8ef003a39'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 6, part.movement_number = NULL,
    part.name_ko = 'Pezzo ostinato', part.name_en = 'Suite of Six Short Pieces for Piano: No. 6. Pezzo ostinato',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 8842 AND p.composer_id = 69 AND part.part_key = 'musicbrainz:dc7e19c8-6430-46a9-a69d-5d50ead4b172' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:dc7e19c8-6430-46a9-a69d-5d50ead4b172', 6, NULL, 'Pezzo ostinato', 'Suite of Six Short Pieces for Piano: No. 6. Pezzo ostinato', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 8842 AND p.composer_id = 69
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:dc7e19c8-6430-46a9-a69d-5d50ead4b172'
);


-- None 교향곡 1번 "A Sea Symphony"

UPDATE pieces piece
SET piece.title = '교향곡 1번 "A Sea Symphony"', piece.title_en = 'Symphony no. 1 "A Sea Symphony"',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 10103 AND piece.composer_id = 69
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'A Song for All Seas, All Ships', part.name_en = 'Symphony no. 1 "A Sea Symphony": I. A Song for All Seas, All Ships',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 10103 AND p.composer_id = 69 AND part.part_key = 'musicbrainz:f7113d71-5cea-3fbd-b755-2e52e280c724' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:f7113d71-5cea-3fbd-b755-2e52e280c724', 1, 'I', 'A Song for All Seas, All Ships', 'Symphony no. 1 "A Sea Symphony": I. A Song for All Seas, All Ships', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 10103 AND p.composer_id = 69
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:f7113d71-5cea-3fbd-b755-2e52e280c724'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:f7113d71-5cea-3fbd-b755-2e52e280c724'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'Ia. A Song for All Seas, All Ships: Behold, the sea itself', part.name_en = 'Symphony no. 1, "A Sea Symphony": Ia. A Song for All Seas, All Ships: Behold, the sea itself',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 10103 AND p.composer_id = 69 AND part.part_key = 'musicbrainz:1fae3d07-e144-3fe4-9de8-84dbfd0ff6d6' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:1fae3d07-e144-3fe4-9de8-84dbfd0ff6d6', 1, NULL, 'Ia. A Song for All Seas, All Ships: Behold, the sea itself', 'Symphony no. 1, "A Sea Symphony": Ia. A Song for All Seas, All Ships: Behold, the sea itself', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:f7113d71-5cea-3fbd-b755-2e52e280c724'
WHERE p.id = 10103 AND p.composer_id = 69
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:1fae3d07-e144-3fe4-9de8-84dbfd0ff6d6'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:f7113d71-5cea-3fbd-b755-2e52e280c724'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'Ib. A Song for All Seas, All Ships: Today a rude brief recitative', part.name_en = 'Symphony no. 1, "A Sea Symphony": Ib. A Song for All Seas, All Ships: Today a rude brief recitative',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 10103 AND p.composer_id = 69 AND part.part_key = 'musicbrainz:fafc3db1-9002-34ff-930b-293dec015842' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:fafc3db1-9002-34ff-930b-293dec015842', 2, NULL, 'Ib. A Song for All Seas, All Ships: Today a rude brief recitative', 'Symphony no. 1, "A Sea Symphony": Ib. A Song for All Seas, All Ships: Today a rude brief recitative', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:f7113d71-5cea-3fbd-b755-2e52e280c724'
WHERE p.id = 10103 AND p.composer_id = 69
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:fafc3db1-9002-34ff-930b-293dec015842'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:f7113d71-5cea-3fbd-b755-2e52e280c724'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = NULL,
    part.name_ko = 'Ic. A Song for All Seas, All Ships: Flaunt out, O sea, your separate flags of nations!', part.name_en = 'Symphony no. 1, "A Sea Symphony": Ic. A Song for All Seas, All Ships: Flaunt out, O sea, your separate flags of nations!',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 10103 AND p.composer_id = 69 AND part.part_key = 'musicbrainz:7f67ede7-decf-34ae-85da-fb71aa665ea3' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:7f67ede7-decf-34ae-85da-fb71aa665ea3', 3, NULL, 'Ic. A Song for All Seas, All Ships: Flaunt out, O sea, your separate flags of nations!', 'Symphony no. 1, "A Sea Symphony": Ic. A Song for All Seas, All Ships: Flaunt out, O sea, your separate flags of nations!', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:f7113d71-5cea-3fbd-b755-2e52e280c724'
WHERE p.id = 10103 AND p.composer_id = 69
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:7f67ede7-decf-34ae-85da-fb71aa665ea3'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:f7113d71-5cea-3fbd-b755-2e52e280c724'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = NULL,
    part.name_ko = 'Id. A Song for All Seas, All Ships: Token of all brave captains', part.name_en = 'Symphony no. 1, "A Sea Symphony": Id. A Song for All Seas, All Ships: Token of all brave captains',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 10103 AND p.composer_id = 69 AND part.part_key = 'musicbrainz:8393ef4d-f31f-3256-b816-c366c24eb6dd' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:8393ef4d-f31f-3256-b816-c366c24eb6dd', 4, NULL, 'Id. A Song for All Seas, All Ships: Token of all brave captains', 'Symphony no. 1, "A Sea Symphony": Id. A Song for All Seas, All Ships: Token of all brave captains', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:f7113d71-5cea-3fbd-b755-2e52e280c724'
WHERE p.id = 10103 AND p.composer_id = 69
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:8393ef4d-f31f-3256-b816-c366c24eb6dd'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:f7113d71-5cea-3fbd-b755-2e52e280c724'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 5, part.movement_number = NULL,
    part.name_ko = 'Ie. A Song for All Seas, All Ships: A pennant universal', part.name_en = 'Symphony no. 1, "A Sea Symphony": Ie. A Song for All Seas, All Ships: A pennant universal',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 10103 AND p.composer_id = 69 AND part.part_key = 'musicbrainz:65f784c3-6a00-35bf-86a8-d43760545637' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:65f784c3-6a00-35bf-86a8-d43760545637', 5, NULL, 'Ie. A Song for All Seas, All Ships: A pennant universal', 'Symphony no. 1, "A Sea Symphony": Ie. A Song for All Seas, All Ships: A pennant universal', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:f7113d71-5cea-3fbd-b755-2e52e280c724'
WHERE p.id = 10103 AND p.composer_id = 69
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:65f784c3-6a00-35bf-86a8-d43760545637'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'On the Beach at Night, Alone', part.name_en = 'Symphony no. 1 "A Sea Symphony": II. On the Beach at Night, Alone',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 10103 AND p.composer_id = 69 AND part.part_key = 'musicbrainz:003917f6-7145-397a-ab2a-b59211cd9dce' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:003917f6-7145-397a-ab2a-b59211cd9dce', 2, 'II', 'On the Beach at Night, Alone', 'Symphony no. 1 "A Sea Symphony": II. On the Beach at Night, Alone', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 10103 AND p.composer_id = 69
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:003917f6-7145-397a-ab2a-b59211cd9dce'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:003917f6-7145-397a-ab2a-b59211cd9dce'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'IIa. On the Beach at Night, Alone: On the beach at night, alone', part.name_en = 'Symphony no. 1, "A Sea Symphony": IIa. On the Beach at Night, Alone: On the beach at night, alone',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 10103 AND p.composer_id = 69 AND part.part_key = 'musicbrainz:87fb58fd-a7fa-394a-a137-10405d91efce' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:87fb58fd-a7fa-394a-a137-10405d91efce', 1, NULL, 'IIa. On the Beach at Night, Alone: On the beach at night, alone', 'Symphony no. 1, "A Sea Symphony": IIa. On the Beach at Night, Alone: On the beach at night, alone', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:003917f6-7145-397a-ab2a-b59211cd9dce'
WHERE p.id = 10103 AND p.composer_id = 69
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:87fb58fd-a7fa-394a-a137-10405d91efce'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:003917f6-7145-397a-ab2a-b59211cd9dce'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'IIb. On the Beach at Night, Alone: A vast similitude interlocks all', part.name_en = 'Symphony no. 1, "A Sea Symphony": IIb. On the Beach at Night, Alone: A vast similitude interlocks all',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 10103 AND p.composer_id = 69 AND part.part_key = 'musicbrainz:181ba7bd-ee61-31cd-bea0-305a1c2b8d54' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:181ba7bd-ee61-31cd-bea0-305a1c2b8d54', 2, NULL, 'IIb. On the Beach at Night, Alone: A vast similitude interlocks all', 'Symphony no. 1, "A Sea Symphony": IIb. On the Beach at Night, Alone: A vast similitude interlocks all', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:003917f6-7145-397a-ab2a-b59211cd9dce'
WHERE p.id = 10103 AND p.composer_id = 69
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:181ba7bd-ee61-31cd-bea0-305a1c2b8d54'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = 'Scherzo. The Waves', part.name_en = 'Symphony no. 1, "A Sea Symphony": III. Scherzo. The Waves',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 10103 AND p.composer_id = 69 AND part.part_key = 'musicbrainz:deb4b1aa-4ca9-3a4c-afbf-8be4e8e97cd3' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:deb4b1aa-4ca9-3a4c-afbf-8be4e8e97cd3', 3, 'III', 'Scherzo. The Waves', 'Symphony no. 1, "A Sea Symphony": III. Scherzo. The Waves', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 10103 AND p.composer_id = 69
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:deb4b1aa-4ca9-3a4c-afbf-8be4e8e97cd3'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = 'IV',
    part.name_ko = 'The Explorers', part.name_en = 'Symphony no. 1, "A Sea Symphony": IV. The Explorers',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 10103 AND p.composer_id = 69 AND part.part_key = 'musicbrainz:9c4d45f0-95c0-34b8-9f3d-6f49ba6942ab' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:9c4d45f0-95c0-34b8-9f3d-6f49ba6942ab', 4, 'IV', 'The Explorers', 'Symphony no. 1, "A Sea Symphony": IV. The Explorers', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 10103 AND p.composer_id = 69
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:9c4d45f0-95c0-34b8-9f3d-6f49ba6942ab'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:9c4d45f0-95c0-34b8-9f3d-6f49ba6942ab'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'IVa. The Explorers: O vast Rondure, swimming in space', part.name_en = 'Symphony no. 1, "A Sea Symphony": IVa. The Explorers: O vast Rondure, swimming in space',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 10103 AND p.composer_id = 69 AND part.part_key = 'musicbrainz:7fab5a48-c7f8-3fc9-92e1-ea09eda966ad' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:7fab5a48-c7f8-3fc9-92e1-ea09eda966ad', 1, NULL, 'IVa. The Explorers: O vast Rondure, swimming in space', 'Symphony no. 1, "A Sea Symphony": IVa. The Explorers: O vast Rondure, swimming in space', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:9c4d45f0-95c0-34b8-9f3d-6f49ba6942ab'
WHERE p.id = 10103 AND p.composer_id = 69
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:7fab5a48-c7f8-3fc9-92e1-ea09eda966ad'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:9c4d45f0-95c0-34b8-9f3d-6f49ba6942ab'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'IVb. The Explorers: Down from the gardens of Asia descending', part.name_en = 'Symphony no. 1, "A Sea Symphony": IVb. The Explorers: Down from the gardens of Asia descending',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 10103 AND p.composer_id = 69 AND part.part_key = 'musicbrainz:0d954269-5b08-31a5-baec-addb7f6b15ac' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:0d954269-5b08-31a5-baec-addb7f6b15ac', 2, NULL, 'IVb. The Explorers: Down from the gardens of Asia descending', 'Symphony no. 1, "A Sea Symphony": IVb. The Explorers: Down from the gardens of Asia descending', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:9c4d45f0-95c0-34b8-9f3d-6f49ba6942ab'
WHERE p.id = 10103 AND p.composer_id = 69
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:0d954269-5b08-31a5-baec-addb7f6b15ac'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:9c4d45f0-95c0-34b8-9f3d-6f49ba6942ab'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = NULL,
    part.name_ko = 'IVc. The Explorers: O we can wait no longer', part.name_en = 'Symphony no. 1, "A Sea Symphony": IVc. The Explorers: O we can wait no longer',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 10103 AND p.composer_id = 69 AND part.part_key = 'musicbrainz:36a85e55-2113-3948-a62e-deee984d54ef' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:36a85e55-2113-3948-a62e-deee984d54ef', 3, NULL, 'IVc. The Explorers: O we can wait no longer', 'Symphony no. 1, "A Sea Symphony": IVc. The Explorers: O we can wait no longer', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:9c4d45f0-95c0-34b8-9f3d-6f49ba6942ab'
WHERE p.id = 10103 AND p.composer_id = 69
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:36a85e55-2113-3948-a62e-deee984d54ef'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:9c4d45f0-95c0-34b8-9f3d-6f49ba6942ab'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = NULL,
    part.name_ko = 'IVd. The Explorers: O thou transcendent', part.name_en = 'Symphony no. 1, "A Sea Symphony": IVd. The Explorers: O thou transcendent',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 10103 AND p.composer_id = 69 AND part.part_key = 'musicbrainz:36404239-e14b-3713-9dea-0bfee73f6a28' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:36404239-e14b-3713-9dea-0bfee73f6a28', 4, NULL, 'IVd. The Explorers: O thou transcendent', 'Symphony no. 1, "A Sea Symphony": IVd. The Explorers: O thou transcendent', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:9c4d45f0-95c0-34b8-9f3d-6f49ba6942ab'
WHERE p.id = 10103 AND p.composer_id = 69
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:36404239-e14b-3713-9dea-0bfee73f6a28'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:9c4d45f0-95c0-34b8-9f3d-6f49ba6942ab'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 5, part.movement_number = NULL,
    part.name_ko = 'IVe. The Explorers: Greater than stars or suns', part.name_en = 'Symphony no. 1, "A Sea Symphony": IVe. The Explorers: Greater than stars or suns',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 10103 AND p.composer_id = 69 AND part.part_key = 'musicbrainz:bb3c99ec-262e-3457-bcd4-5da64bf37a53' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:bb3c99ec-262e-3457-bcd4-5da64bf37a53', 5, NULL, 'IVe. The Explorers: Greater than stars or suns', 'Symphony no. 1, "A Sea Symphony": IVe. The Explorers: Greater than stars or suns', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:9c4d45f0-95c0-34b8-9f3d-6f49ba6942ab'
WHERE p.id = 10103 AND p.composer_id = 69
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:bb3c99ec-262e-3457-bcd4-5da64bf37a53'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:9c4d45f0-95c0-34b8-9f3d-6f49ba6942ab'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 6, part.movement_number = NULL,
    part.name_ko = 'IVf. The Explorers: Sail forth, steer for the deep waters only', part.name_en = 'Symphony no. 1, "A Sea Symphony": IVf. The Explorers: Sail forth, steer for the deep waters only',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 10103 AND p.composer_id = 69 AND part.part_key = 'musicbrainz:d578035c-67ae-3ac9-b045-93ff8ec36b00' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:d578035c-67ae-3ac9-b045-93ff8ec36b00', 6, NULL, 'IVf. The Explorers: Sail forth, steer for the deep waters only', 'Symphony no. 1, "A Sea Symphony": IVf. The Explorers: Sail forth, steer for the deep waters only', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:9c4d45f0-95c0-34b8-9f3d-6f49ba6942ab'
WHERE p.id = 10103 AND p.composer_id = 69
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:d578035c-67ae-3ac9-b045-93ff8ec36b00'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:9c4d45f0-95c0-34b8-9f3d-6f49ba6942ab'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 7, part.movement_number = NULL,
    part.name_ko = 'IVg. The Explorers: O my brave Soul!', part.name_en = 'Symphony no. 1, "A Sea Symphony": IVg. The Explorers: O my brave Soul!',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 10103 AND p.composer_id = 69 AND part.part_key = 'musicbrainz:86aa0059-1849-3a79-ac34-18de50f4ef7d' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:86aa0059-1849-3a79-ac34-18de50f4ef7d', 7, NULL, 'IVg. The Explorers: O my brave Soul!', 'Symphony no. 1, "A Sea Symphony": IVg. The Explorers: O my brave Soul!', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:9c4d45f0-95c0-34b8-9f3d-6f49ba6942ab'
WHERE p.id = 10103 AND p.composer_id = 69
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:86aa0059-1849-3a79-ac34-18de50f4ef7d'
);


-- None 교향곡 2번 G장조 "A London Symphony"

UPDATE pieces piece
SET piece.title = '교향곡 2번 G장조 "A London Symphony"', piece.title_en = 'Symphony no. 2 in G major “A London Symphony”',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 7587 AND piece.composer_id = 69
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'Lento - Allegro risoluto', part.name_en = 'Symphony no. 2 in G major “A London Symphony”: I. Lento - Allegro risoluto',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 7587 AND p.composer_id = 69 AND part.part_key = 'musicbrainz:c0849e98-af60-3f55-b8fb-4448cf8c0121' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:c0849e98-af60-3f55-b8fb-4448cf8c0121', 1, 'I', 'Lento - Allegro risoluto', 'Symphony no. 2 in G major “A London Symphony”: I. Lento - Allegro risoluto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 7587 AND p.composer_id = 69
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:c0849e98-af60-3f55-b8fb-4448cf8c0121'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'Lento', part.name_en = 'Symphony no. 2 in G major “A London Symphony”: II. Lento',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 7587 AND p.composer_id = 69 AND part.part_key = 'musicbrainz:8a1d95aa-12f4-332e-8121-cc8052d2211d' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:8a1d95aa-12f4-332e-8121-cc8052d2211d', 2, 'II', 'Lento', 'Symphony no. 2 in G major “A London Symphony”: II. Lento', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 7587 AND p.composer_id = 69
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:8a1d95aa-12f4-332e-8121-cc8052d2211d'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = 'Scherzo (Nocturne); Allegro vivace', part.name_en = 'Symphony no. 2 in G major “A London Symphony”: III. Scherzo (Nocturne); Allegro vivace',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 7587 AND p.composer_id = 69 AND part.part_key = 'musicbrainz:e206634e-885c-3e08-adf2-953f700074d1' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:e206634e-885c-3e08-adf2-953f700074d1', 3, 'III', 'Scherzo (Nocturne); Allegro vivace', 'Symphony no. 2 in G major “A London Symphony”: III. Scherzo (Nocturne); Allegro vivace', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 7587 AND p.composer_id = 69
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:e206634e-885c-3e08-adf2-953f700074d1'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = 'IV',
    part.name_ko = 'Andante con moto - Maestoso alla marcia - Allegro - Lento - Epilogue', part.name_en = 'Symphony no. 2 in G major “A London Symphony”: IV. Andante con moto - Maestoso alla marcia - Allegro - Lento - Epilogue',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 7587 AND p.composer_id = 69 AND part.part_key = 'musicbrainz:15e9658f-fc05-3c05-ad2b-f395f919360a' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:15e9658f-fc05-3c05-ad2b-f395f919360a', 4, 'IV', 'Andante con moto - Maestoso alla marcia - Allegro - Lento - Epilogue', 'Symphony no. 2 in G major “A London Symphony”: IV. Andante con moto - Maestoso alla marcia - Allegro - Lento - Epilogue', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 7587 AND p.composer_id = 69
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:15e9658f-fc05-3c05-ad2b-f395f919360a'
);


-- None 교향곡 3번 "A Pastoral Symphony"

UPDATE pieces piece
SET piece.title = '교향곡 3번 "A Pastoral Symphony"', piece.title_en = 'Symphony no. 3 “A Pastoral Symphony”',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 10634 AND piece.composer_id = 69
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'Molto moderato', part.name_en = 'Symphony no. 3, “A Pastoral Symphony”: I. Molto moderato',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 10634 AND p.composer_id = 69 AND part.part_key = 'musicbrainz:4618bac0-9a63-34e8-87d7-032661ef8604' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:4618bac0-9a63-34e8-87d7-032661ef8604', 1, 'I', 'Molto moderato', 'Symphony no. 3, “A Pastoral Symphony”: I. Molto moderato', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 10634 AND p.composer_id = 69
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:4618bac0-9a63-34e8-87d7-032661ef8604'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'Lento moderato', part.name_en = 'Symphony no. 3, “A Pastoral Symphony”: II. Lento moderato',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 10634 AND p.composer_id = 69 AND part.part_key = 'musicbrainz:8beae9be-8fff-33ee-970e-8af4541f57ab' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:8beae9be-8fff-33ee-970e-8af4541f57ab', 2, 'II', 'Lento moderato', 'Symphony no. 3, “A Pastoral Symphony”: II. Lento moderato', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 10634 AND p.composer_id = 69
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:8beae9be-8fff-33ee-970e-8af4541f57ab'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = 'Moderato pesante - Presto', part.name_en = 'Symphony no. 3, “A Pastoral Symphony”: III. Moderato pesante - Presto',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 10634 AND p.composer_id = 69 AND part.part_key = 'musicbrainz:e30472c3-95ab-35cb-b0df-ad0182d11212' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:e30472c3-95ab-35cb-b0df-ad0182d11212', 3, 'III', 'Moderato pesante - Presto', 'Symphony no. 3, “A Pastoral Symphony”: III. Moderato pesante - Presto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 10634 AND p.composer_id = 69
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:e30472c3-95ab-35cb-b0df-ad0182d11212'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = 'IV',
    part.name_ko = 'Lento - Moderato maestoso', part.name_en = 'Symphony no. 3, “A Pastoral Symphony”: IV. Lento - Moderato maestoso',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 10634 AND p.composer_id = 69 AND part.part_key = 'musicbrainz:677faf40-d29d-3819-85e6-fa384669b75e' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:677faf40-d29d-3819-85e6-fa384669b75e', 4, 'IV', 'Lento - Moderato maestoso', 'Symphony no. 3, “A Pastoral Symphony”: IV. Lento - Moderato maestoso', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 10634 AND p.composer_id = 69
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:677faf40-d29d-3819-85e6-fa384669b75e'
);


-- None 교향곡 4번 F단조

UPDATE pieces piece
SET piece.title = '교향곡 4번 F단조', piece.title_en = 'Symphony no. 4 in F minor',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 10464 AND piece.composer_id = 69
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'Allegro', part.name_en = 'Symphony no. 4 in F minor: I. Allegro',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 10464 AND p.composer_id = 69 AND part.part_key = 'musicbrainz:8e7f7f78-74d6-36d3-9db2-00c7d83c4f11' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:8e7f7f78-74d6-36d3-9db2-00c7d83c4f11', 1, 'I', 'Allegro', 'Symphony no. 4 in F minor: I. Allegro', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 10464 AND p.composer_id = 69
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:8e7f7f78-74d6-36d3-9db2-00c7d83c4f11'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'Andante moderato', part.name_en = 'Symphony no. 4 in F minor: II. Andante moderato',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 10464 AND p.composer_id = 69 AND part.part_key = 'musicbrainz:c2986ad9-093c-3ba8-ae76-b3314d2d4225' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:c2986ad9-093c-3ba8-ae76-b3314d2d4225', 2, 'II', 'Andante moderato', 'Symphony no. 4 in F minor: II. Andante moderato', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 10464 AND p.composer_id = 69
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:c2986ad9-093c-3ba8-ae76-b3314d2d4225'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = 'Scherzo: Allegro molto', part.name_en = 'Symphony no. 4 in F minor: III. Scherzo: Allegro molto',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 10464 AND p.composer_id = 69 AND part.part_key = 'musicbrainz:10d2656f-32c6-3689-9aea-c2c1b4d20df6' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:10d2656f-32c6-3689-9aea-c2c1b4d20df6', 3, 'III', 'Scherzo: Allegro molto', 'Symphony no. 4 in F minor: III. Scherzo: Allegro molto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 10464 AND p.composer_id = 69
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:10d2656f-32c6-3689-9aea-c2c1b4d20df6'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = 'IV',
    part.name_ko = 'Finale (Allegro molto) con epilogo fugato (Con anima)', part.name_en = 'Symphony no. 4 in F minor: IV. Finale (Allegro molto) con epilogo fugato (Con anima)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 10464 AND p.composer_id = 69 AND part.part_key = 'musicbrainz:fedf62c4-4bcf-3b4e-a778-efcb8880a724' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:fedf62c4-4bcf-3b4e-a778-efcb8880a724', 4, 'IV', 'Finale (Allegro molto) con epilogo fugato (Con anima)', 'Symphony no. 4 in F minor: IV. Finale (Allegro molto) con epilogo fugato (Con anima)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 10464 AND p.composer_id = 69
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:fedf62c4-4bcf-3b4e-a778-efcb8880a724'
);


-- None 교향곡 5번 D장조

UPDATE pieces piece
SET piece.title = '교향곡 5번 D장조', piece.title_en = 'Symphony no. 5 in D major',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 7936 AND piece.composer_id = 69
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'Preludio (Moderato)', part.name_en = 'Symphony no. 5 in D major: I. Preludio (Moderato)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 7936 AND p.composer_id = 69 AND part.part_key = 'musicbrainz:691c50a8-4ef4-38c7-94a5-8af0eeec37b1' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:691c50a8-4ef4-38c7-94a5-8af0eeec37b1', 1, 'I', 'Preludio (Moderato)', 'Symphony no. 5 in D major: I. Preludio (Moderato)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 7936 AND p.composer_id = 69
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:691c50a8-4ef4-38c7-94a5-8af0eeec37b1'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'Scherzo (Presto misterioso)', part.name_en = 'Symphony no. 5 in D major: II. Scherzo (Presto misterioso)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 7936 AND p.composer_id = 69 AND part.part_key = 'musicbrainz:e37f23a6-4e5d-3bf6-9175-7d85c40b02ab' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:e37f23a6-4e5d-3bf6-9175-7d85c40b02ab', 2, 'II', 'Scherzo (Presto misterioso)', 'Symphony no. 5 in D major: II. Scherzo (Presto misterioso)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 7936 AND p.composer_id = 69
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:e37f23a6-4e5d-3bf6-9175-7d85c40b02ab'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = 'Romanza (Lento)', part.name_en = 'Symphony no. 5 in D major: III. Romanza (Lento)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 7936 AND p.composer_id = 69 AND part.part_key = 'musicbrainz:cf916937-1c8a-3e27-a0e9-cf2b7d001e2f' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:cf916937-1c8a-3e27-a0e9-cf2b7d001e2f', 3, 'III', 'Romanza (Lento)', 'Symphony no. 5 in D major: III. Romanza (Lento)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 7936 AND p.composer_id = 69
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:cf916937-1c8a-3e27-a0e9-cf2b7d001e2f'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = 'IV',
    part.name_ko = 'Passacaglia (Moderato)', part.name_en = 'Symphony no. 5 in D major: IV. Passacaglia (Moderato)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 7936 AND p.composer_id = 69 AND part.part_key = 'musicbrainz:a349cd96-5d40-38c9-a367-82e2b116bb06' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:a349cd96-5d40-38c9-a367-82e2b116bb06', 4, 'IV', 'Passacaglia (Moderato)', 'Symphony no. 5 in D major: IV. Passacaglia (Moderato)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 7936 AND p.composer_id = 69
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:a349cd96-5d40-38c9-a367-82e2b116bb06'
);


-- None 교향곡 6번 E단조

UPDATE pieces piece
SET piece.title = '교향곡 6번 E단조', piece.title_en = 'Symphony no. 6 in E minor',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 8086 AND piece.composer_id = 69
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'Allegro', part.name_en = 'Symphony no. 6 in E minor: I. Allegro',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 8086 AND p.composer_id = 69 AND part.part_key = 'musicbrainz:182b7032-4ef5-3cc0-9588-5d6aca38a666' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:182b7032-4ef5-3cc0-9588-5d6aca38a666', 1, 'I', 'Allegro', 'Symphony no. 6 in E minor: I. Allegro', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 8086 AND p.composer_id = 69
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:182b7032-4ef5-3cc0-9588-5d6aca38a666'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'Moderato', part.name_en = 'Symphony no. 6 in E minor: II. Moderato',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 8086 AND p.composer_id = 69 AND part.part_key = 'musicbrainz:b39e87af-472c-3d77-9b8e-c09552573f8d' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:b39e87af-472c-3d77-9b8e-c09552573f8d', 2, 'II', 'Moderato', 'Symphony no. 6 in E minor: II. Moderato', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 8086 AND p.composer_id = 69
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:b39e87af-472c-3d77-9b8e-c09552573f8d'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = 'Scherzo (Allegro vivace)', part.name_en = 'Symphony no. 6 in E minor: III. Scherzo (Allegro vivace)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 8086 AND p.composer_id = 69 AND part.part_key = 'musicbrainz:51c53801-aba4-3278-a37a-afb135499a11' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:51c53801-aba4-3278-a37a-afb135499a11', 3, 'III', 'Scherzo (Allegro vivace)', 'Symphony no. 6 in E minor: III. Scherzo (Allegro vivace)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 8086 AND p.composer_id = 69
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:51c53801-aba4-3278-a37a-afb135499a11'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = 'IV',
    part.name_ko = 'Epilogue (Moderato)', part.name_en = 'Symphony no. 6 in E minor: IV. Epilogue (Moderato)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 8086 AND p.composer_id = 69 AND part.part_key = 'musicbrainz:24366873-e4fb-324b-9f8d-5009b0a9932b' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:24366873-e4fb-324b-9f8d-5009b0a9932b', 4, 'IV', 'Epilogue (Moderato)', 'Symphony no. 6 in E minor: IV. Epilogue (Moderato)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 8086 AND p.composer_id = 69
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:24366873-e4fb-324b-9f8d-5009b0a9932b'
);


-- None 교향곡 8번 D단조

UPDATE pieces piece
SET piece.title = '교향곡 8번 D단조', piece.title_en = 'Symphony no. 8 in D minor',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 8771 AND piece.composer_id = 69
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'Fantasia (Variazioni senza tema)', part.name_en = 'Symphony no. 8 in D minor: I. Fantasia (Variazioni senza tema)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 8771 AND p.composer_id = 69 AND part.part_key = 'musicbrainz:0c435a97-90fd-39f9-874d-cdac27f93169' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:0c435a97-90fd-39f9-874d-cdac27f93169', 1, 'I', 'Fantasia (Variazioni senza tema)', 'Symphony no. 8 in D minor: I. Fantasia (Variazioni senza tema)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 8771 AND p.composer_id = 69
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:0c435a97-90fd-39f9-874d-cdac27f93169'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'Scherzo alla marcia (per stromenti a fiato): Allegro alla marcia', part.name_en = 'Symphony no. 8 in D minor: II. Scherzo alla marcia (per stromenti a fiato): Allegro alla marcia',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 8771 AND p.composer_id = 69 AND part.part_key = 'musicbrainz:28c6d564-efa3-373a-85c0-0c43857f1499' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:28c6d564-efa3-373a-85c0-0c43857f1499', 2, 'II', 'Scherzo alla marcia (per stromenti a fiato): Allegro alla marcia', 'Symphony no. 8 in D minor: II. Scherzo alla marcia (per stromenti a fiato): Allegro alla marcia', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 8771 AND p.composer_id = 69
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:28c6d564-efa3-373a-85c0-0c43857f1499'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = 'Cavatina (per stromenti ad arco) - Lento espressivo', part.name_en = 'Symphony no. 8 in D minor: III. Cavatina (per stromenti ad arco) - Lento espressivo',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 8771 AND p.composer_id = 69 AND part.part_key = 'musicbrainz:d5f35a73-c95b-37ad-85e1-2dbf4f36b225' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:d5f35a73-c95b-37ad-85e1-2dbf4f36b225', 3, 'III', 'Cavatina (per stromenti ad arco) - Lento espressivo', 'Symphony no. 8 in D minor: III. Cavatina (per stromenti ad arco) - Lento espressivo', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 8771 AND p.composer_id = 69
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:d5f35a73-c95b-37ad-85e1-2dbf4f36b225'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = 'IV',
    part.name_ko = 'Toccata - Moderato maestoso', part.name_en = 'Symphony no. 8 in D minor: IV. Toccata - Moderato maestoso',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 8771 AND p.composer_id = 69 AND part.part_key = 'musicbrainz:9ceb6537-485e-3875-9745-3e69f339ccb1' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:9ceb6537-485e-3875-9745-3e69f339ccb1', 4, 'IV', 'Toccata - Moderato maestoso', 'Symphony no. 8 in D minor: IV. Toccata - Moderato maestoso', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 8771 AND p.composer_id = 69
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:9ceb6537-485e-3875-9745-3e69f339ccb1'
);


-- None 교향곡 9번 E단조

UPDATE pieces piece
SET piece.title = '교향곡 9번 E단조', piece.title_en = 'Symphony no. 9 in E minor',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 10330 AND piece.composer_id = 69
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'Moderato maestoso', part.name_en = 'Symphony no. 9 in E minor: I. Moderato maestoso',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 10330 AND p.composer_id = 69 AND part.part_key = 'musicbrainz:834ca574-b0ea-34ab-baa1-b66bed67db9d' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:834ca574-b0ea-34ab-baa1-b66bed67db9d', 1, 'I', 'Moderato maestoso', 'Symphony no. 9 in E minor: I. Moderato maestoso', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 10330 AND p.composer_id = 69
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:834ca574-b0ea-34ab-baa1-b66bed67db9d'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'Andante sostenuto', part.name_en = 'Symphony no. 9 in E minor: II. Andante sostenuto',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 10330 AND p.composer_id = 69 AND part.part_key = 'musicbrainz:10aa970d-1c76-391d-85b9-1b0232a97c48' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:10aa970d-1c76-391d-85b9-1b0232a97c48', 2, 'II', 'Andante sostenuto', 'Symphony no. 9 in E minor: II. Andante sostenuto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 10330 AND p.composer_id = 69
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:10aa970d-1c76-391d-85b9-1b0232a97c48'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = 'Scherzo. Allegro pesante', part.name_en = 'Symphony no. 9 in E minor: III. Scherzo. Allegro pesante',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 10330 AND p.composer_id = 69 AND part.part_key = 'musicbrainz:ce36b717-5890-3be8-896e-2810f3f53987' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:ce36b717-5890-3be8-896e-2810f3f53987', 3, 'III', 'Scherzo. Allegro pesante', 'Symphony no. 9 in E minor: III. Scherzo. Allegro pesante', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 10330 AND p.composer_id = 69
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:ce36b717-5890-3be8-896e-2810f3f53987'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = 'IV',
    part.name_ko = 'Andante tranquillo', part.name_en = 'Symphony no. 9 in E minor: IV. Andante tranquillo',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 10330 AND p.composer_id = 69 AND part.part_key = 'musicbrainz:2532e1ad-0349-3284-8ee6-04e3156fc0ef' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:2532e1ad-0349-3284-8ee6-04e3156fc0ef', 4, 'IV', 'Andante tranquillo', 'Symphony no. 9 in E minor: IV. Andante tranquillo', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 10330 AND p.composer_id = 69
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:2532e1ad-0349-3284-8ee6-04e3156fc0ef'
);


-- None 테 데움 G장조

UPDATE pieces piece
SET piece.title = '테 데움 G장조', piece.title_en = 'Te Deum in G major',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 9901 AND piece.composer_id = 69
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None 영화음악 <The 49th Parallel>

UPDATE pieces piece
SET piece.title = '영화음악 <The 49th Parallel>', piece.title_en = 'The 49th Parallel',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 7841 AND piece.composer_id = 69
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'Valse: Winnipeg', part.name_en = 'The 49th Parallel: Valse: Winnipeg',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 7841 AND p.composer_id = 69 AND part.part_key = 'musicbrainz:0e772c3e-d694-4563-9d74-ab22108d5248' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:0e772c3e-d694-4563-9d74-ab22108d5248', 1, NULL, 'Valse: Winnipeg', 'The 49th Parallel: Valse: Winnipeg', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 7841 AND p.composer_id = 69
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:0e772c3e-d694-4563-9d74-ab22108d5248'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'Hudson’s Bay Company trading post', part.name_en = 'The 49th Parallel: Hudson’s Bay Company trading post',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 7841 AND p.composer_id = 69 AND part.part_key = 'musicbrainz:169d16f4-a1d2-4afb-a6dd-21a4b40750ef' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:169d16f4-a1d2-4afb-a6dd-21a4b40750ef', 2, NULL, 'Hudson’s Bay Company trading post', 'The 49th Parallel: Hudson’s Bay Company trading post', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 7841 AND p.composer_id = 69
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:169d16f4-a1d2-4afb-a6dd-21a4b40750ef'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = NULL,
    part.name_ko = 'panorama', part.name_en = 'The 49th Parallel: panorama',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 7841 AND p.composer_id = 69 AND part.part_key = 'musicbrainz:17880ad7-54d1-4fb3-9f98-12e649a4fcde' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:17880ad7-54d1-4fb3-9f98-12e649a4fcde', 3, NULL, 'panorama', 'The 49th Parallel: panorama', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 7841 AND p.composer_id = 69
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:17880ad7-54d1-4fb3-9f98-12e649a4fcde'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = NULL,
    part.name_ko = 'Prelude', part.name_en = 'The 49th Parallel: Prelude',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 7841 AND p.composer_id = 69 AND part.part_key = 'musicbrainz:202f90cf-f5c0-434a-bfae-a28282c18dda' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:202f90cf-f5c0-434a-bfae-a28282c18dda', 4, NULL, 'Prelude', 'The 49th Parallel: Prelude', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 7841 AND p.composer_id = 69
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:202f90cf-f5c0-434a-bfae-a28282c18dda'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 5, part.movement_number = NULL,
    part.name_ko = 'The Hutterite settlement [original version]', part.name_en = 'The 49th Parallel: The Hutterite settlement [original version]',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 7841 AND p.composer_id = 69 AND part.part_key = 'musicbrainz:3210f829-9a1d-43a3-bd4f-c8183b2f6533' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:3210f829-9a1d-43a3-bd4f-c8183b2f6533', 5, NULL, 'The Hutterite settlement [original version]', 'The 49th Parallel: The Hutterite settlement [original version]', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 7841 AND p.composer_id = 69
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:3210f829-9a1d-43a3-bd4f-c8183b2f6533'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 6, part.movement_number = NULL,
    part.name_ko = 'The Nazis steal the floatplane', part.name_en = 'The 49th Parallel: The Nazis steal the floatplane',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 7841 AND p.composer_id = 69 AND part.part_key = 'musicbrainz:463e9a4a-1ab6-4eaa-a800-0e16ff8be9ed' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:463e9a4a-1ab6-4eaa-a800-0e16ff8be9ed', 6, NULL, 'The Nazis steal the floatplane', 'The 49th Parallel: The Nazis steal the floatplane', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 7841 AND p.composer_id = 69
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:463e9a4a-1ab6-4eaa-a800-0e16ff8be9ed'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 7, part.movement_number = NULL,
    part.name_ko = 'Anna’s Volkslied', part.name_en = 'The 49th Parallel: Anna’s Volkslied',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 7841 AND p.composer_id = 69 AND part.part_key = 'musicbrainz:4723dca8-293e-4bf0-8f26-8ea030753976' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:4723dca8-293e-4bf0-8f26-8ea030753976', 7, NULL, 'Anna’s Volkslied', 'The 49th Parallel: Anna’s Volkslied', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 7841 AND p.composer_id = 69
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:4723dca8-293e-4bf0-8f26-8ea030753976'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 8, part.movement_number = NULL,
    part.name_ko = 'The railway bridge and Niagara Falls', part.name_en = 'The 49th Parallel: The railway bridge and Niagara Falls',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 7841 AND p.composer_id = 69 AND part.part_key = 'musicbrainz:5477bb77-1ab8-4f71-a601-eb57bab2efd3' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:5477bb77-1ab8-4f71-a601-eb57bab2efd3', 8, NULL, 'The railway bridge and Niagara Falls', 'The 49th Parallel: The railway bridge and Niagara Falls', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 7841 AND p.composer_id = 69
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:5477bb77-1ab8-4f71-a601-eb57bab2efd3'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 9, part.movement_number = NULL,
    part.name_ko = 'The Hutterite settlement [revised version]', part.name_en = 'The 49th Parallel: The Hutterite settlement [revised version]',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 7841 AND p.composer_id = 69 AND part.part_key = 'musicbrainz:5951d13f-3fe7-402a-8d0d-cf52624ffae5' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:5951d13f-3fe7-402a-8d0d-cf52624ffae5', 9, NULL, 'The Hutterite settlement [revised version]', 'The 49th Parallel: The Hutterite settlement [revised version]', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 7841 AND p.composer_id = 69
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:5951d13f-3fe7-402a-8d0d-cf52624ffae5'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 10, part.movement_number = NULL,
    part.name_ko = 'Dance music: In the restaurant', part.name_en = 'The 49th Parallel: Dance music: In the restaurant',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 7841 AND p.composer_id = 69 AND part.part_key = 'musicbrainz:6b6244f5-cf30-4f11-8346-052a3dac1787' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:6b6244f5-cf30-4f11-8346-052a3dac1787', 10, NULL, 'Dance music: In the restaurant', 'The 49th Parallel: Dance music: In the restaurant', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 7841 AND p.composer_id = 69
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:6b6244f5-cf30-4f11-8346-052a3dac1787'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 11, part.movement_number = NULL,
    part.name_ko = 'Banff: “Indian Days”', part.name_en = 'The 49th Parallel: Banff: “Indian Days”',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 7841 AND p.composer_id = 69 AND part.part_key = 'musicbrainz:7ad196b2-e522-4f32-bbf1-afb8a4d80fb8' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:7ad196b2-e522-4f32-bbf1-afb8a4d80fb8', 11, NULL, 'Banff: “Indian Days”', 'The 49th Parallel: Banff: “Indian Days”', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 7841 AND p.composer_id = 69
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:7ad196b2-e522-4f32-bbf1-afb8a4d80fb8'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 12, part.movement_number = NULL,
    part.name_ko = 'Death of Kuhnecke', part.name_en = 'The 49th Parallel: Death of Kuhnecke',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 7841 AND p.composer_id = 69 AND part.part_key = 'musicbrainz:7c5c3e9b-ac46-4e98-a8c3-985ad67f4be7' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:7c5c3e9b-ac46-4e98-a8c3-985ad67f4be7', 12, NULL, 'Death of Kuhnecke', 'The 49th Parallel: Death of Kuhnecke', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 7841 AND p.composer_id = 69
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:7c5c3e9b-ac46-4e98-a8c3-985ad67f4be7'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 13, part.movement_number = NULL,
    part.name_ko = 'The control room sends an alert', part.name_en = 'The 49th Parallel: The control room sends an alert',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 7841 AND p.composer_id = 69 AND part.part_key = 'musicbrainz:8002ac6d-ea1b-45f7-8453-935223eae246' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:8002ac6d-ea1b-45f7-8453-935223eae246', 13, NULL, 'The control room sends an alert', 'The 49th Parallel: The control room sends an alert', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 7841 AND p.composer_id = 69
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:8002ac6d-ea1b-45f7-8453-935223eae246'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 14, part.movement_number = NULL,
    part.name_ko = 'The Nazis journey to Winnipeg', part.name_en = 'The 49th Parallel: The Nazis journey to Winnipeg',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 7841 AND p.composer_id = 69 AND part.part_key = 'musicbrainz:99326f3f-bf92-4171-b13c-69466be2c422' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:99326f3f-bf92-4171-b13c-69466be2c422', 14, NULL, 'The Nazis journey to Winnipeg', 'The 49th Parallel: The Nazis journey to Winnipeg', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 7841 AND p.composer_id = 69
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:99326f3f-bf92-4171-b13c-69466be2c422'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 15, part.movement_number = NULL,
    part.name_ko = 'The Nazis march onward', part.name_en = 'The 49th Parallel: The Nazis march onward',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 7841 AND p.composer_id = 69 AND part.part_key = 'musicbrainz:a1005fe5-6d53-4d56-bca0-3492f4d6aba9' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:a1005fe5-6d53-4d56-bca0-3492f4d6aba9', 15, NULL, 'The Nazis march onward', 'The 49th Parallel: The Nazis march onward', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 7841 AND p.composer_id = 69
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:a1005fe5-6d53-4d56-bca0-3492f4d6aba9'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 16, part.movement_number = NULL,
    part.name_ko = 'Journey through the mountains', part.name_en = 'The 49th Parallel: Journey through the mountains',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 7841 AND p.composer_id = 69 AND part.part_key = 'musicbrainz:a1519eb7-5d88-45c8-9db8-6a8d6c4a2f96' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:a1519eb7-5d88-45c8-9db8-6a8d6c4a2f96', 16, NULL, 'Journey through the mountains', 'The 49th Parallel: Journey through the mountains', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 7841 AND p.composer_id = 69
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:a1519eb7-5d88-45c8-9db8-6a8d6c4a2f96'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 17, part.movement_number = NULL,
    part.name_ko = 'The Nazis with the British writer', part.name_en = 'The 49th Parallel: The Nazis with the British writer',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 7841 AND p.composer_id = 69 AND part.part_key = 'musicbrainz:bf3ead0d-5972-490c-b2e6-2ad1a693c7a2' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:bf3ead0d-5972-490c-b2e6-2ad1a693c7a2', 17, NULL, 'The Nazis with the British writer', 'The 49th Parallel: The Nazis with the British writer', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 7841 AND p.composer_id = 69
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:bf3ead0d-5972-490c-b2e6-2ad1a693c7a2'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 18, part.movement_number = NULL,
    part.name_ko = 'The U-boat in Hudson Bay', part.name_en = 'The 49th Parallel: The U-boat in Hudson Bay',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 7841 AND p.composer_id = 69 AND part.part_key = 'musicbrainz:c4abd547-01d4-415e-b295-a8cb2021bf9e' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:c4abd547-01d4-415e-b295-a8cb2021bf9e', 18, NULL, 'The U-boat in Hudson Bay', 'The 49th Parallel: The U-boat in Hudson Bay', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 7841 AND p.composer_id = 69
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:c4abd547-01d4-415e-b295-a8cb2021bf9e'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 19, part.movement_number = NULL,
    part.name_ko = 'Vogel’s decision to stay', part.name_en = 'The 49th Parallel: Vogel’s decision to stay',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 7841 AND p.composer_id = 69 AND part.part_key = 'musicbrainz:c68fb36d-48dd-4d30-9055-708d2ed112d4' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:c68fb36d-48dd-4d30-9055-708d2ed112d4', 19, NULL, 'Vogel’s decision to stay', 'The 49th Parallel: Vogel’s decision to stay', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 7841 AND p.composer_id = 69
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:c68fb36d-48dd-4d30-9055-708d2ed112d4'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 20, part.movement_number = NULL,
    part.name_ko = 'The Nazis loot the trading post', part.name_en = 'The 49th Parallel: The Nazis loot the trading post',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 7841 AND p.composer_id = 69 AND part.part_key = 'musicbrainz:c888b1a0-5fa7-4291-b5da-54d956dbf6e8' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:c888b1a0-5fa7-4291-b5da-54d956dbf6e8', 20, NULL, 'The Nazis loot the trading post', 'The 49th Parallel: The Nazis loot the trading post', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 7841 AND p.composer_id = 69
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:c888b1a0-5fa7-4291-b5da-54d956dbf6e8'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 21, part.movement_number = NULL,
    part.name_ko = 'Aircraft searching for the U-boat', part.name_en = 'The 49th Parallel: Aircraft searching for the U-boat',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 7841 AND p.composer_id = 69 AND part.part_key = 'musicbrainz:d49e3541-b76d-485d-9a77-c6e2e6cbf3f8' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:d49e3541-b76d-485d-9a77-c6e2e6cbf3f8', 21, NULL, 'Aircraft searching for the U-boat', 'The 49th Parallel: Aircraft searching for the U-boat', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 7841 AND p.composer_id = 69
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:d49e3541-b76d-485d-9a77-c6e2e6cbf3f8'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 22, part.movement_number = NULL,
    part.name_ko = 'End titles', part.name_en = 'The 49th Parallel: End titles',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 7841 AND p.composer_id = 69 AND part.part_key = 'musicbrainz:ebf9b729-8eee-449d-bad9-f2db13396159' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:ebf9b729-8eee-449d-bad9-f2db13396159', 22, NULL, 'End titles', 'The 49th Parallel: End titles', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 7841 AND p.composer_id = 69
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:ebf9b729-8eee-449d-bad9-f2db13396159'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 23, part.movement_number = NULL,
    part.name_ko = 'The Hutterite settlement: Haymaking', part.name_en = 'The 49th Parallel: The Hutterite settlement: Haymaking',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 7841 AND p.composer_id = 69 AND part.part_key = 'musicbrainz:fe6a5181-bb44-4b45-a297-b117d587cbae' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:fe6a5181-bb44-4b45-a297-b117d587cbae', 23, NULL, 'The Hutterite settlement: Haymaking', 'The 49th Parallel: The Hutterite settlement: Haymaking', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 7841 AND p.composer_id = 69
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:fe6a5181-bb44-4b45-a297-b117d587cbae'
);


-- None 가곡 <The Airmen's Hymn>

UPDATE pieces piece
SET piece.title = '가곡 <The Airmen''s Hymn>', piece.title_en = 'The Airmen''s Hymn',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 9207 AND piece.composer_id = 69
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None 부수음악 <The Bacchae>

UPDATE pieces piece
SET piece.title = '부수음악 <The Bacchae>', piece.title_en = 'The Bacchae',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 9191 AND piece.composer_id = 69
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None 가곡 <The Blessed Son Of God>

UPDATE pieces piece
SET piece.title = '가곡 <The Blessed Son Of God>', piece.title_en = 'The Blessed Son Of God',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 10003 AND piece.composer_id = 69
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None The Blue Bird

UPDATE pieces piece
SET piece.title = 'The Blue Bird', piece.title_en = 'The Blue Bird',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 8649 AND piece.composer_id = 69
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'Introduction & First Dance (Moderato)', part.name_en = 'Introduction & First Dance (Moderato)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 8649 AND p.composer_id = 69 AND part.part_key = 'musicbrainz:2cc11b2e-3c84-478e-a08b-3760cfefbdb4' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:2cc11b2e-3c84-478e-a08b-3760cfefbdb4', 1, NULL, 'Introduction & First Dance (Moderato)', 'Introduction & First Dance (Moderato)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 8649 AND p.composer_id = 69
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:2cc11b2e-3c84-478e-a08b-3760cfefbdb4'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'The Clock Strikes (Più mosso)', part.name_en = 'The Clock Strikes (Più mosso)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 8649 AND p.composer_id = 69 AND part.part_key = 'musicbrainz:cfecf6c0-a7f6-4a9c-9c8f-04e2bf8d1ed8' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:cfecf6c0-a7f6-4a9c-9c8f-04e2bf8d1ed8', 2, NULL, 'The Clock Strikes (Più mosso)', 'The Clock Strikes (Più mosso)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 8649 AND p.composer_id = 69
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:cfecf6c0-a7f6-4a9c-9c8f-04e2bf8d1ed8'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = NULL,
    part.name_ko = 'The Dance of the Hours (Andante piacevole)', part.name_en = 'The Dance of the Hours (Andante piacevole)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 8649 AND p.composer_id = 69 AND part.part_key = 'musicbrainz:0a67bce1-1ec2-4029-9de7-b66d775428ed' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:0a67bce1-1ec2-4029-9de7-b66d775428ed', 3, NULL, 'The Dance of the Hours (Andante piacevole)', 'The Dance of the Hours (Andante piacevole)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 8649 AND p.composer_id = 69
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:0a67bce1-1ec2-4029-9de7-b66d775428ed'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = NULL,
    part.name_ko = 'The Dance of the Loaves (Allegro giocoso)', part.name_en = 'The Dance of the Loaves (Allegro giocoso)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 8649 AND p.composer_id = 69 AND part.part_key = 'musicbrainz:23ceb334-be30-4e63-a02f-39f4edddc2f9' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:23ceb334-be30-4e63-a02f-39f4edddc2f9', 4, NULL, 'The Dance of the Loaves (Allegro giocoso)', 'The Dance of the Loaves (Allegro giocoso)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 8649 AND p.composer_id = 69
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:23ceb334-be30-4e63-a02f-39f4edddc2f9'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 5, part.movement_number = NULL,
    part.name_ko = 'The Dance of the Fire (Allegro ma non troppo)', part.name_en = 'The Dance of the Fire (Allegro ma non troppo)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 8649 AND p.composer_id = 69 AND part.part_key = 'musicbrainz:bd635b12-e44e-4d15-9399-3cc759e2906f' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:bd635b12-e44e-4d15-9399-3cc759e2906f', 5, NULL, 'The Dance of the Fire (Allegro ma non troppo)', 'The Dance of the Fire (Allegro ma non troppo)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 8649 AND p.composer_id = 69
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:bd635b12-e44e-4d15-9399-3cc759e2906f'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 6, part.movement_number = NULL,
    part.name_ko = 'The Dance of the Water (Molto moderato)', part.name_en = 'The Dance of the Water (Molto moderato)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 8649 AND p.composer_id = 69 AND part.part_key = 'musicbrainz:ba00e820-3823-4bc0-889f-7d1cbba8b91e' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:ba00e820-3823-4bc0-889f-7d1cbba8b91e', 6, NULL, 'The Dance of the Water (Molto moderato)', 'The Dance of the Water (Molto moderato)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 8649 AND p.composer_id = 69
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:ba00e820-3823-4bc0-889f-7d1cbba8b91e'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 7, part.movement_number = NULL,
    part.name_ko = 'The Fight between Fire and Water (Allegro con brio)', part.name_en = 'The Fight between Fire and Water (Allegro con brio)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 8649 AND p.composer_id = 69 AND part.part_key = 'musicbrainz:c49ca878-93b1-4c29-a0ec-ce448dffdfb7' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:c49ca878-93b1-4c29-a0ec-ce448dffdfb7', 7, NULL, 'The Fight between Fire and Water (Allegro con brio)', 'The Fight between Fire and Water (Allegro con brio)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 8649 AND p.composer_id = 69
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:c49ca878-93b1-4c29-a0ec-ce448dffdfb7'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 8, part.movement_number = NULL,
    part.name_ko = 'General Dance (Allegro con brio)', part.name_en = 'General Dance (Allegro con brio)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 8649 AND p.composer_id = 69 AND part.part_key = 'musicbrainz:6b87e969-8a85-4161-be55-28dd7ff1b575' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:6b87e969-8a85-4161-be55-28dd7ff1b575', 8, NULL, 'General Dance (Allegro con brio)', 'General Dance (Allegro con brio)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 8649 AND p.composer_id = 69
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:6b87e969-8a85-4161-be55-28dd7ff1b575'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 9, part.movement_number = NULL,
    part.name_ko = 'Finale (Molto adagio)', part.name_en = 'Finale (Molto adagio)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 8649 AND p.composer_id = 69 AND part.part_key = 'musicbrainz:5b24f85d-fbb4-4dea-bbf0-5ed2edbea3a4' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:5b24f85d-fbb4-4dea-bbf0-5ed2edbea3a4', 9, NULL, 'Finale (Molto adagio)', 'Finale (Molto adagio)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 8649 AND p.composer_id = 69
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:5b24f85d-fbb4-4dea-bbf0-5ed2edbea3a4'
);


-- None The Bridal Day

UPDATE pieces piece
SET piece.title = 'The Bridal Day', piece.title_en = 'The Bridal Day',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 8278 AND piece.composer_id = 69
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'Scene I (Andante con moto - Allegretto)', part.name_en = 'The Bridal Day: Scene I (Andante con moto - Allegretto)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 8278 AND p.composer_id = 69 AND part.part_key = 'musicbrainz:df6e8c4b-4e08-45f2-9966-ff2548aaf899' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:df6e8c4b-4e08-45f2-9966-ff2548aaf899', 1, NULL, 'Scene I (Andante con moto - Allegretto)', 'The Bridal Day: Scene I (Andante con moto - Allegretto)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 8278 AND p.composer_id = 69
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:df6e8c4b-4e08-45f2-9966-ff2548aaf899'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'Scene II (Allegretto - Largamente)', part.name_en = 'The Bridal Day: Scene II (Allegretto - Largamente)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 8278 AND p.composer_id = 69 AND part.part_key = 'musicbrainz:a2b68294-a823-4f02-8d0f-2d671864714d' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:a2b68294-a823-4f02-8d0f-2d671864714d', 2, NULL, 'Scene II (Allegretto - Largamente)', 'The Bridal Day: Scene II (Allegretto - Largamente)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 8278 AND p.composer_id = 69
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:a2b68294-a823-4f02-8d0f-2d671864714d'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = NULL,
    part.name_ko = 'Scene III (Allegro moderato - Andante maestoso - Allegro vivace)', part.name_en = 'The Bridal Day: Scene III (Allegro moderato - Andante maestoso - Allegro vivace)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 8278 AND p.composer_id = 69 AND part.part_key = 'musicbrainz:d363a56d-5611-4cf1-8d85-41f636f015d2' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:d363a56d-5611-4cf1-8d85-41f636f015d2', 3, NULL, 'Scene III (Allegro moderato - Andante maestoso - Allegro vivace)', 'The Bridal Day: Scene III (Allegro moderato - Andante maestoso - Allegro vivace)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 8278 AND p.composer_id = 69
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:d363a56d-5611-4cf1-8d85-41f636f015d2'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = NULL,
    part.name_ko = 'Scene IV (Moderato - Allegro - Lento)', part.name_en = 'The Bridal Day: Scene IV (Moderato - Allegro - Lento)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 8278 AND p.composer_id = 69 AND part.part_key = 'musicbrainz:5dd2472c-b7d2-4e5c-ab48-89f8ac4c45d3' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:5dd2472c-b7d2-4e5c-ab48-89f8ac4c45d3', 4, NULL, 'Scene IV (Moderato - Allegro - Lento)', 'The Bridal Day: Scene IV (Moderato - Allegro - Lento)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 8278 AND p.composer_id = 69
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:5dd2472c-b7d2-4e5c-ab48-89f8ac4c45d3'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 5, part.movement_number = NULL,
    part.name_ko = 'Scene V (Allegro - Lento - Andante con moto)', part.name_en = 'The Bridal Day: Scene V (Allegro - Lento - Andante con moto)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 8278 AND p.composer_id = 69 AND part.part_key = 'musicbrainz:c3508781-d110-4310-9fa3-8017c6a41f55' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:c3508781-d110-4310-9fa3-8017c6a41f55', 5, NULL, 'Scene V (Allegro - Lento - Andante con moto)', 'The Bridal Day: Scene V (Allegro - Lento - Andante con moto)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 8278 AND p.composer_id = 69
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:c3508781-d110-4310-9fa3-8017c6a41f55'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 6, part.movement_number = NULL,
    part.name_ko = 'Scene VI (Andante sostenuto)', part.name_en = 'The Bridal Day: Scene VI (Andante sostenuto)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 8278 AND p.composer_id = 69 AND part.part_key = 'musicbrainz:685d9380-4b2c-43f6-ad39-9bf621f06149' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:685d9380-4b2c-43f6-ad39-9bf621f06149', 6, NULL, 'Scene VI (Andante sostenuto)', 'The Bridal Day: Scene VI (Andante sostenuto)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 8278 AND p.composer_id = 69
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:685d9380-4b2c-43f6-ad39-9bf621f06149'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 7, part.movement_number = NULL,
    part.name_ko = 'Scene VII (Andante sostenuto)', part.name_en = 'The Bridal Day: Scene VII (Andante sostenuto)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 8278 AND p.composer_id = 69 AND part.part_key = 'musicbrainz:21dc4e1b-f99c-4c04-8e70-9ed8a254a858' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:21dc4e1b-f99c-4c04-8e70-9ed8a254a858', 7, NULL, 'Scene VII (Andante sostenuto)', 'The Bridal Day: Scene VII (Andante sostenuto)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 8278 AND p.composer_id = 69
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:21dc4e1b-f99c-4c04-8e70-9ed8a254a858'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 8, part.movement_number = NULL,
    part.name_ko = 'Scene VIII (Allegretto)', part.name_en = 'The Bridal Day: Scene VIII (Allegretto)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 8278 AND p.composer_id = 69 AND part.part_key = 'musicbrainz:cb29439a-c10f-469f-b65b-e63b1ce9d990' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:cb29439a-c10f-469f-b65b-e63b1ce9d990', 8, NULL, 'Scene VIII (Allegretto)', 'The Bridal Day: Scene VIII (Allegretto)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 8278 AND p.composer_id = 69
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:cb29439a-c10f-469f-b65b-e63b1ce9d990'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 9, part.movement_number = NULL,
    part.name_ko = 'Scene IX (Lento)', part.name_en = 'The Bridal Day: Scene IX (Lento)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 8278 AND p.composer_id = 69 AND part.part_key = 'musicbrainz:43ff6e88-d6ea-49e8-b274-35d5a786a285' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:43ff6e88-d6ea-49e8-b274-35d5a786a285', 9, NULL, 'Scene IX (Lento)', 'The Bridal Day: Scene IX (Lento)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 8278 AND p.composer_id = 69
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:43ff6e88-d6ea-49e8-b274-35d5a786a285'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 10, part.movement_number = NULL,
    part.name_ko = 'Scene X (Molto adagio)', part.name_en = 'The Bridal Day: Scene X (Molto adagio)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 8278 AND p.composer_id = 69 AND part.part_key = 'musicbrainz:ad80fc0a-2255-41c4-b599-509609591a09' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:ad80fc0a-2255-41c4-b599-509609591a09', 10, NULL, 'Scene X (Molto adagio)', 'The Bridal Day: Scene X (Molto adagio)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 8278 AND p.composer_id = 69
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:ad80fc0a-2255-41c4-b599-509609591a09'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 11, part.movement_number = NULL,
    part.name_ko = 'Scene XI (Andante maestoso)', part.name_en = 'The Bridal Day: Scene XI (Andante maestoso)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 8278 AND p.composer_id = 69 AND part.part_key = 'musicbrainz:2616843a-b22d-4b40-85c4-6467c1cbf256' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:2616843a-b22d-4b40-85c4-6467c1cbf256', 11, NULL, 'Scene XI (Andante maestoso)', 'The Bridal Day: Scene XI (Andante maestoso)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 8278 AND p.composer_id = 69
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:2616843a-b22d-4b40-85c4-6467c1cbf256'
);


-- None 부수음악 <The Death of Tintagiles>

UPDATE pieces piece
SET piece.title = '부수음악 <The Death of Tintagiles>', piece.title_en = 'The Death of Tintagiles',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 11090 AND piece.composer_id = 69
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'Prelude. Largo - Andantino - Adagio', part.name_en = 'The Death of Tintagiles: Prelude. Largo - Andantino - Adagio',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11090 AND p.composer_id = 69 AND part.part_key = 'musicbrainz:50d1dadd-af9c-43dc-b36e-4e0f6a40f98d' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:50d1dadd-af9c-43dc-b36e-4e0f6a40f98d', 1, NULL, 'Prelude. Largo - Andantino - Adagio', 'The Death of Tintagiles: Prelude. Largo - Andantino - Adagio', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 11090 AND p.composer_id = 69
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:50d1dadd-af9c-43dc-b36e-4e0f6a40f98d'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'Lento', part.name_en = 'The Death of Tintagiles: I. Lento',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11090 AND p.composer_id = 69 AND part.part_key = 'musicbrainz:85691a1f-538a-4796-9b40-2399032be6e8' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:85691a1f-538a-4796-9b40-2399032be6e8', 2, NULL, 'Lento', 'The Death of Tintagiles: I. Lento', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 11090 AND p.composer_id = 69
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:85691a1f-538a-4796-9b40-2399032be6e8'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = NULL,
    part.name_ko = 'Allegro', part.name_en = 'The Death of Tintagiles: II. Allegro',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11090 AND p.composer_id = 69 AND part.part_key = 'musicbrainz:64b16cf4-5357-42a9-a42a-f7c6fc935bbd' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:64b16cf4-5357-42a9-a42a-f7c6fc935bbd', 3, NULL, 'Allegro', 'The Death of Tintagiles: II. Allegro', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 11090 AND p.composer_id = 69
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:64b16cf4-5357-42a9-a42a-f7c6fc935bbd'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = NULL,
    part.name_ko = 'Lento - Andante tranquillo - Lento', part.name_en = 'The Death of Tintagiles: III. Lento - Andante tranquillo - Lento',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11090 AND p.composer_id = 69 AND part.part_key = 'musicbrainz:b8d3cd4c-644d-46c0-ae0f-80ef610de6c6' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:b8d3cd4c-644d-46c0-ae0f-80ef610de6c6', 4, NULL, 'Lento - Andante tranquillo - Lento', 'The Death of Tintagiles: III. Lento - Andante tranquillo - Lento', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 11090 AND p.composer_id = 69
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:b8d3cd4c-644d-46c0-ae0f-80ef610de6c6'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 5, part.movement_number = NULL,
    part.name_ko = 'Moderato', part.name_en = 'The Death of Tintagiles: IV. Moderato',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11090 AND p.composer_id = 69 AND part.part_key = 'musicbrainz:733b342f-3312-46a5-9883-b8da4563592f' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:733b342f-3312-46a5-9883-b8da4563592f', 5, NULL, 'Moderato', 'The Death of Tintagiles: IV. Moderato', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 11090 AND p.composer_id = 69
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:733b342f-3312-46a5-9883-b8da4563592f'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 6, part.movement_number = NULL,
    part.name_ko = 'IV 1/2. Allegro', part.name_en = 'The Death of Tintagiles: IV 1/2. Allegro',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11090 AND p.composer_id = 69 AND part.part_key = 'musicbrainz:573e2d5c-27f9-4630-8115-db961e79a745' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:573e2d5c-27f9-4630-8115-db961e79a745', 6, NULL, 'IV 1/2. Allegro', 'The Death of Tintagiles: IV 1/2. Allegro', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 11090 AND p.composer_id = 69
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:573e2d5c-27f9-4630-8115-db961e79a745'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 7, part.movement_number = NULL,
    part.name_ko = 'Lento', part.name_en = 'The Death of Tintagiles: V. Lento',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11090 AND p.composer_id = 69 AND part.part_key = 'musicbrainz:6ae61c6f-803b-432c-8fb6-a08af5e09a9c' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:6ae61c6f-803b-432c-8fb6-a08af5e09a9c', 7, NULL, 'Lento', 'The Death of Tintagiles: V. Lento', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 11090 AND p.composer_id = 69
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:6ae61c6f-803b-432c-8fb6-a08af5e09a9c'
);


-- None 영화음악 <The Dim Little Island>

UPDATE pieces piece
SET piece.title = '영화음악 <The Dim Little Island>', piece.title_en = 'The Dim Little Island',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 8998 AND piece.composer_id = 69
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None 영화음악 <The Flemish Farm>

UPDATE pieces piece
SET piece.title = '영화음악 <The Flemish Farm>', piece.title_en = 'The Flemish Farm',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 8425 AND piece.composer_id = 69
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None The Future

UPDATE pieces piece
SET piece.title = 'The Future', piece.title_en = 'The Future',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 8020 AND piece.composer_id = 69
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None The Garden of Proserpine

UPDATE pieces piece
SET piece.title = 'The Garden of Proserpine', piece.title_en = 'The Garden of Proserpine',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 8193 AND piece.composer_id = 69
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None The Golden Carol

UPDATE pieces piece
SET piece.title = 'The Golden Carol', piece.title_en = 'The Golden Carol',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 9678 AND piece.composer_id = 69
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None The Heroic Elegy and Triumphal Epilogue

UPDATE pieces piece
SET piece.title = 'The Heroic Elegy and Triumphal Epilogue', piece.title_en = 'The Heroic Elegy and Triumphal Epilogue',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 9372 AND piece.composer_id = 69
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None 연가곡집 <The House of Life>

UPDATE pieces piece
SET piece.title = '연가곡집 <The House of Life>', piece.title_en = 'The House of Life',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 9634 AND piece.composer_id = 69
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'Love-Sight', part.name_en = 'The House of Life, No. 1: Love-Sight',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 9634 AND p.composer_id = 69 AND part.part_key = 'musicbrainz:f2a2d03b-5499-3350-b8da-e9f3bf2db7d6' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:f2a2d03b-5499-3350-b8da-e9f3bf2db7d6', 1, NULL, 'Love-Sight', 'The House of Life, No. 1: Love-Sight', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 9634 AND p.composer_id = 69
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:f2a2d03b-5499-3350-b8da-e9f3bf2db7d6'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'Silent Noon', part.name_en = 'The House of Life, No. 2: Silent Noon',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 9634 AND p.composer_id = 69 AND part.part_key = 'musicbrainz:049bb315-6d89-3ed1-8eea-2186316deb96' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:049bb315-6d89-3ed1-8eea-2186316deb96', 2, NULL, 'Silent Noon', 'The House of Life, No. 2: Silent Noon', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 9634 AND p.composer_id = 69
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:049bb315-6d89-3ed1-8eea-2186316deb96'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = NULL,
    part.name_ko = 'Love''s Minstrels', part.name_en = 'The House of Life, No. 3: Love''s Minstrels',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 9634 AND p.composer_id = 69 AND part.part_key = 'musicbrainz:bb557a6b-803e-39b4-941c-17eedda4cc89' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:bb557a6b-803e-39b4-941c-17eedda4cc89', 3, NULL, 'Love''s Minstrels', 'The House of Life, No. 3: Love''s Minstrels', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 9634 AND p.composer_id = 69
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:bb557a6b-803e-39b4-941c-17eedda4cc89'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = NULL,
    part.name_ko = 'Heart''s Haven', part.name_en = 'The House of Life, No. 4: Heart''s Haven',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 9634 AND p.composer_id = 69 AND part.part_key = 'musicbrainz:1ad6be6e-0077-3321-9af0-2dd309ca9905' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:1ad6be6e-0077-3321-9af0-2dd309ca9905', 4, NULL, 'Heart''s Haven', 'The House of Life, No. 4: Heart''s Haven', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 9634 AND p.composer_id = 69
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:1ad6be6e-0077-3321-9af0-2dd309ca9905'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 5, part.movement_number = NULL,
    part.name_ko = 'Death in Love', part.name_en = 'The House of Life, No. 5: Death in Love',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 9634 AND p.composer_id = 69 AND part.part_key = 'musicbrainz:8ec31e3a-3e22-3938-a280-0ca7a66157fe' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:8ec31e3a-3e22-3938-a280-0ca7a66157fe', 5, NULL, 'Death in Love', 'The House of Life, No. 5: Death in Love', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 9634 AND p.composer_id = 69
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:8ec31e3a-3e22-3938-a280-0ca7a66157fe'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 6, part.movement_number = NULL,
    part.name_ko = 'Love''s Last Gift', part.name_en = 'The House of Life, No. 6: Love''s Last Gift',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 9634 AND p.composer_id = 69 AND part.part_key = 'musicbrainz:0d646c91-268e-318e-ac0b-0f408eb31d08' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:0d646c91-268e-318e-ac0b-0f408eb31d08', 6, NULL, 'Love''s Last Gift', 'The House of Life, No. 6: Love''s Last Gift', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 9634 AND p.composer_id = 69
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:0d646c91-268e-318e-ac0b-0f408eb31d08'
);


-- None The Lake in the Mountains

UPDATE pieces piece
SET piece.title = 'The Lake in the Mountains', piece.title_en = 'The Lake in the Mountains',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 10981 AND piece.composer_id = 69
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None 영화음악 <The Loves of Joanna Godden>

UPDATE pieces piece
SET piece.title = '영화음악 <The Loves of Joanna Godden>', piece.title_en = 'The Loves of Joanna Godden',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 7694 AND piece.composer_id = 69
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None The Pilgrim Pavement

UPDATE pieces piece
SET piece.title = 'The Pilgrim Pavement', piece.title_en = 'The Pilgrim Pavement',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 11266 AND piece.composer_id = 69
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None The Pilgrim’s Progress - A Bunyan Sequence

UPDATE pieces piece
SET piece.title = 'The Pilgrim’s Progress - A Bunyan Sequence', piece.title_en = 'The Pilgrim’s Progress - A Bunyan Sequence',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 10454 AND piece.composer_id = 69
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None 오페라 <The Poisoned Kiss>

UPDATE pieces piece
SET piece.title = '오페라 <The Poisoned Kiss>', piece.title_en = 'The Poisoned Kiss',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 10347 AND piece.composer_id = 69
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'Overture', part.name_en = 'The Poisoned Kiss: Overture',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 10347 AND p.composer_id = 69 AND part.part_key = 'musicbrainz:e5cf12e9-fce0-4e8a-a10f-25eb93af433f' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:e5cf12e9-fce0-4e8a-a10f-25eb93af433f', 1, NULL, 'Overture', 'The Poisoned Kiss: Overture', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 10347 AND p.composer_id = 69
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:e5cf12e9-fce0-4e8a-a10f-25eb93af433f'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'Act I', part.name_en = 'The Poisoned Kiss: Act I',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 10347 AND p.composer_id = 69 AND part.part_key = 'musicbrainz:d92bea9b-f2e5-4b5c-a14b-71c22771b662' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:d92bea9b-f2e5-4b5c-a14b-71c22771b662', 2, NULL, 'Act I', 'The Poisoned Kiss: Act I', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 10347 AND p.composer_id = 69
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:d92bea9b-f2e5-4b5c-a14b-71c22771b662'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:d92bea9b-f2e5-4b5c-a14b-71c22771b662'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'Act I. No. 3. Scena. Gallanthus: "What"s that?"', part.name_en = 'The Poisoned Kiss: Act I. No. 3. Scena. Gallanthus: "What"s that?"',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 10347 AND p.composer_id = 69 AND part.part_key = 'musicbrainz:040a261c-35dc-4750-93eb-48ca42d659a6' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:040a261c-35dc-4750-93eb-48ca42d659a6', 1, NULL, 'Act I. No. 3. Scena. Gallanthus: "What"s that?"', 'The Poisoned Kiss: Act I. No. 3. Scena. Gallanthus: "What"s that?"', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:d92bea9b-f2e5-4b5c-a14b-71c22771b662'
WHERE p.id = 10347 AND p.composer_id = 69
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:040a261c-35dc-4750-93eb-48ca42d659a6'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:d92bea9b-f2e5-4b5c-a14b-71c22771b662'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'Act I. No. 6. Ensemble. Hob, Lob and Gob: "Here we come..."', part.name_en = 'The Poisoned Kiss: Act I. No. 6. Ensemble. Hob, Lob and Gob: "Here we come..."',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 10347 AND p.composer_id = 69 AND part.part_key = 'musicbrainz:1183c380-c34a-417c-b6cb-8b12c8bdd34f' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:1183c380-c34a-417c-b6cb-8b12c8bdd34f', 2, NULL, 'Act I. No. 6. Ensemble. Hob, Lob and Gob: "Here we come..."', 'The Poisoned Kiss: Act I. No. 6. Ensemble. Hob, Lob and Gob: "Here we come..."', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:d92bea9b-f2e5-4b5c-a14b-71c22771b662'
WHERE p.id = 10347 AND p.composer_id = 69
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:1183c380-c34a-417c-b6cb-8b12c8bdd34f'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:d92bea9b-f2e5-4b5c-a14b-71c22771b662'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = NULL,
    part.name_ko = 'Act I. No. 2. Opening Chorus: "Secret are the sounds..."', part.name_en = 'The Poisoned Kiss: Act I. No. 2. Opening Chorus: "Secret are the sounds..."',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 10347 AND p.composer_id = 69 AND part.part_key = 'musicbrainz:1464bc58-4143-4aa4-956a-b1771c2d02b4' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:1464bc58-4143-4aa4-956a-b1771c2d02b4', 3, NULL, 'Act I. No. 2. Opening Chorus: "Secret are the sounds..."', 'The Poisoned Kiss: Act I. No. 2. Opening Chorus: "Secret are the sounds..."', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:d92bea9b-f2e5-4b5c-a14b-71c22771b662'
WHERE p.id = 10347 AND p.composer_id = 69
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:1464bc58-4143-4aa4-956a-b1771c2d02b4'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:d92bea9b-f2e5-4b5c-a14b-71c22771b662'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = NULL,
    part.name_ko = 'Act I. No. 11. Ensemble. Dispacus: "Who''s in my forest?" - "North wind, south wind" - Tormentilla: "Angelica?" - Amaryllus and Gallanthus: "O come to our arms"', part.name_en = 'The Poisoned Kiss: Act I. No. 11. Ensemble. Dispacus: "Who''s in my forest?" - "North wind, south wind" - Tormentilla: "Angelica?" - Amaryllus and Gallanthus: "O come to our arms"',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 10347 AND p.composer_id = 69 AND part.part_key = 'musicbrainz:24ee8cbe-b8d5-4c5c-a022-cc50b4b5fc0a' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:24ee8cbe-b8d5-4c5c-a022-cc50b4b5fc0a', 4, NULL, 'Act I. No. 11. Ensemble. Dispacus: "Who''s in my forest?" - "North wind, south wind" - Tormentilla: "Angelica?" - Amaryllus and Gallanthus: "O come to our arms"', 'The Poisoned Kiss: Act I. No. 11. Ensemble. Dispacus: "Who''s in my forest?" - "North wind, south wind" - Tormentilla: "Angelica?" - Amaryllus and Gallanthus: "O come to our arms"', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:d92bea9b-f2e5-4b5c-a14b-71c22771b662'
WHERE p.id = 10347 AND p.composer_id = 69
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:24ee8cbe-b8d5-4c5c-a022-cc50b4b5fc0a'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:d92bea9b-f2e5-4b5c-a14b-71c22771b662'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 5, part.movement_number = NULL,
    part.name_ko = 'Act I. No. 7. Duet and Chorus. Dipsacus: "I"m a sorcerer bold"', part.name_en = 'The Poisoned Kiss: Act I. No. 7. Duet and Chorus. Dipsacus: "I"m a sorcerer bold"',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 10347 AND p.composer_id = 69 AND part.part_key = 'musicbrainz:54c9bee1-746b-4d7a-b54a-fc1ccd1ed752' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:54c9bee1-746b-4d7a-b54a-fc1ccd1ed752', 5, NULL, 'Act I. No. 7. Duet and Chorus. Dipsacus: "I"m a sorcerer bold"', 'The Poisoned Kiss: Act I. No. 7. Duet and Chorus. Dipsacus: "I"m a sorcerer bold"', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:d92bea9b-f2e5-4b5c-a14b-71c22771b662'
WHERE p.id = 10347 AND p.composer_id = 69
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:54c9bee1-746b-4d7a-b54a-fc1ccd1ed752'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:d92bea9b-f2e5-4b5c-a14b-71c22771b662'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 6, part.movement_number = NULL,
    part.name_ko = 'Act I. No. 10. Duet. Amaryllus: "I know we see..." - "Blue larkspur in a garden"', part.name_en = 'The Poisoned Kiss: Act I. No. 10. Duet. Amaryllus: "I know we see..." - "Blue larkspur in a garden"',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 10347 AND p.composer_id = 69 AND part.part_key = 'musicbrainz:6d5b0447-c2ff-4739-bc25-1a8c6699836e' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:6d5b0447-c2ff-4739-bc25-1a8c6699836e', 6, NULL, 'Act I. No. 10. Duet. Amaryllus: "I know we see..." - "Blue larkspur in a garden"', 'The Poisoned Kiss: Act I. No. 10. Duet. Amaryllus: "I know we see..." - "Blue larkspur in a garden"', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:d92bea9b-f2e5-4b5c-a14b-71c22771b662'
WHERE p.id = 10347 AND p.composer_id = 69
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:6d5b0447-c2ff-4739-bc25-1a8c6699836e'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:d92bea9b-f2e5-4b5c-a14b-71c22771b662'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 7, part.movement_number = NULL,
    part.name_ko = 'Act I. No. 12. Song. Tormentilla: "O who would be..."', part.name_en = 'The Poisoned Kiss: Act I. No. 12. Song. Tormentilla: "O who would be..."',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 10347 AND p.composer_id = 69 AND part.part_key = 'musicbrainz:74660e69-fd3a-4e37-a471-dad98aba0345' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:74660e69-fd3a-4e37-a471-dad98aba0345', 7, NULL, 'Act I. No. 12. Song. Tormentilla: "O who would be..."', 'The Poisoned Kiss: Act I. No. 12. Song. Tormentilla: "O who would be..."', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:d92bea9b-f2e5-4b5c-a14b-71c22771b662'
WHERE p.id = 10347 AND p.composer_id = 69
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:74660e69-fd3a-4e37-a471-dad98aba0345'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:d92bea9b-f2e5-4b5c-a14b-71c22771b662'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 8, part.movement_number = NULL,
    part.name_ko = 'Act I. No. 9. Ensemble. Tormentilla: "Hush, lovely cobra" - Amaryllus: "Desist, lest you die!"', part.name_en = 'The Poisoned Kiss: Act I. No. 9. Ensemble. Tormentilla: "Hush, lovely cobra" - Amaryllus: "Desist, lest you die!"',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 10347 AND p.composer_id = 69 AND part.part_key = 'musicbrainz:8b4b231d-e9dd-476a-bb6f-0f1c01c1bb05' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:8b4b231d-e9dd-476a-bb6f-0f1c01c1bb05', 8, NULL, 'Act I. No. 9. Ensemble. Tormentilla: "Hush, lovely cobra" - Amaryllus: "Desist, lest you die!"', 'The Poisoned Kiss: Act I. No. 9. Ensemble. Tormentilla: "Hush, lovely cobra" - Amaryllus: "Desist, lest you die!"', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:d92bea9b-f2e5-4b5c-a14b-71c22771b662'
WHERE p.id = 10347 AND p.composer_id = 69
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:8b4b231d-e9dd-476a-bb6f-0f1c01c1bb05'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:d92bea9b-f2e5-4b5c-a14b-71c22771b662'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 9, part.movement_number = NULL,
    part.name_ko = 'Act I. No. 8. Duet. Amaryllus: "It"s true I"m inclined..."', part.name_en = 'The Poisoned Kiss: Act I. No. 8. Duet. Amaryllus: "It"s true I"m inclined..."',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 10347 AND p.composer_id = 69 AND part.part_key = 'musicbrainz:a8749a86-e558-42d8-ae53-abe19607a37f' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:a8749a86-e558-42d8-ae53-abe19607a37f', 9, NULL, 'Act I. No. 8. Duet. Amaryllus: "It"s true I"m inclined..."', 'The Poisoned Kiss: Act I. No. 8. Duet. Amaryllus: "It"s true I"m inclined..."', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:d92bea9b-f2e5-4b5c-a14b-71c22771b662'
WHERE p.id = 10347 AND p.composer_id = 69
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:a8749a86-e558-42d8-ae53-abe19607a37f'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:d92bea9b-f2e5-4b5c-a14b-71c22771b662'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 10, part.movement_number = NULL,
    part.name_ko = 'Act I. No. 4. Scena. Angelica: "Day is dawning"', part.name_en = 'The Poisoned Kiss: Act I. No. 4. Scena. Angelica: "Day is dawning"',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 10347 AND p.composer_id = 69 AND part.part_key = 'musicbrainz:bff27a9d-5d9d-491e-9a66-94c24cce712c' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:bff27a9d-5d9d-491e-9a66-94c24cce712c', 10, NULL, 'Act I. No. 4. Scena. Angelica: "Day is dawning"', 'The Poisoned Kiss: Act I. No. 4. Scena. Angelica: "Day is dawning"', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:d92bea9b-f2e5-4b5c-a14b-71c22771b662'
WHERE p.id = 10347 AND p.composer_id = 69
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:bff27a9d-5d9d-491e-9a66-94c24cce712c'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:d92bea9b-f2e5-4b5c-a14b-71c22771b662'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 11, part.movement_number = NULL,
    part.name_ko = 'Act I. No. 5. Duet. Gallaanthus: "It"s really time..."', part.name_en = 'The Poisoned Kiss: Act I. No. 5. Duet. Gallaanthus: "It"s really time..."',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 10347 AND p.composer_id = 69 AND part.part_key = 'musicbrainz:efd19ca2-73b6-4d7b-b465-4950171dd57d' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:efd19ca2-73b6-4d7b-b465-4950171dd57d', 11, NULL, 'Act I. No. 5. Duet. Gallaanthus: "It"s really time..."', 'The Poisoned Kiss: Act I. No. 5. Duet. Gallaanthus: "It"s really time..."', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:d92bea9b-f2e5-4b5c-a14b-71c22771b662'
WHERE p.id = 10347 AND p.composer_id = 69
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:efd19ca2-73b6-4d7b-b465-4950171dd57d'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:d92bea9b-f2e5-4b5c-a14b-71c22771b662'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 12, part.movement_number = NULL,
    part.name_ko = 'Act I. No. 13. Finale. Dipsacus: "All is ready!"', part.name_en = 'The Poisoned Kiss: Act I. No. 13. Finale. Dipsacus: "All is ready!"',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 10347 AND p.composer_id = 69 AND part.part_key = 'musicbrainz:f40b4bbe-35c3-486b-8ddb-ffeebbb3a24a' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:f40b4bbe-35c3-486b-8ddb-ffeebbb3a24a', 12, NULL, 'Act I. No. 13. Finale. Dipsacus: "All is ready!"', 'The Poisoned Kiss: Act I. No. 13. Finale. Dipsacus: "All is ready!"', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:d92bea9b-f2e5-4b5c-a14b-71c22771b662'
WHERE p.id = 10347 AND p.composer_id = 69
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:f40b4bbe-35c3-486b-8ddb-ffeebbb3a24a'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = NULL,
    part.name_ko = 'Act II', part.name_en = 'The Poisoned Kiss: Act II',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 10347 AND p.composer_id = 69 AND part.part_key = 'musicbrainz:7b97a880-fc47-4617-b356-b0b51846dcc2' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:7b97a880-fc47-4617-b356-b0b51846dcc2', 3, NULL, 'Act II', 'The Poisoned Kiss: Act II', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 10347 AND p.composer_id = 69
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:7b97a880-fc47-4617-b356-b0b51846dcc2'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:7b97a880-fc47-4617-b356-b0b51846dcc2'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'Act II. No. 14. Introduction', part.name_en = 'The Poisoned Kiss: Act II. No. 14. Introduction',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 10347 AND p.composer_id = 69 AND part.part_key = 'musicbrainz:03fb7536-cd42-49cd-9f7e-0823efe92b71' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:03fb7536-cd42-49cd-9f7e-0823efe92b71', 1, NULL, 'Act II. No. 14. Introduction', 'The Poisoned Kiss: Act II. No. 14. Introduction', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:7b97a880-fc47-4617-b356-b0b51846dcc2'
WHERE p.id = 10347 AND p.composer_id = 69
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:03fb7536-cd42-49cd-9f7e-0823efe92b71'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:7b97a880-fc47-4617-b356-b0b51846dcc2'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'Act II. No. 23. Serenade. Amaryllus: "Dear love, behold..."', part.name_en = 'The Poisoned Kiss: Act II. No. 23. Serenade. Amaryllus: "Dear love, behold..."',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 10347 AND p.composer_id = 69 AND part.part_key = 'musicbrainz:04c44750-7d96-4826-b8ac-76272b087786' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:04c44750-7d96-4826-b8ac-76272b087786', 2, NULL, 'Act II. No. 23. Serenade. Amaryllus: "Dear love, behold..."', 'The Poisoned Kiss: Act II. No. 23. Serenade. Amaryllus: "Dear love, behold..."', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:7b97a880-fc47-4617-b356-b0b51846dcc2'
WHERE p.id = 10347 AND p.composer_id = 69
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:04c44750-7d96-4826-b8ac-76272b087786'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:7b97a880-fc47-4617-b356-b0b51846dcc2'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = NULL,
    part.name_ko = 'Act II. No. 20. Chorus: "Tormentilla! Tormentilla!"', part.name_en = 'The Poisoned Kiss: Act II. No. 20. Chorus: "Tormentilla! Tormentilla!"',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 10347 AND p.composer_id = 69 AND part.part_key = 'musicbrainz:0a5c4999-4e0d-46c7-9d02-5344595bfd15' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:0a5c4999-4e0d-46c7-9d02-5344595bfd15', 3, NULL, 'Act II. No. 20. Chorus: "Tormentilla! Tormentilla!"', 'The Poisoned Kiss: Act II. No. 20. Chorus: "Tormentilla! Tormentilla!"', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:7b97a880-fc47-4617-b356-b0b51846dcc2'
WHERE p.id = 10347 AND p.composer_id = 69
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:0a5c4999-4e0d-46c7-9d02-5344595bfd15'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:7b97a880-fc47-4617-b356-b0b51846dcc2'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = NULL,
    part.name_ko = 'Act II. No. 26. Finale. Tormentilla: "Too dark for me..."', part.name_en = 'The Poisoned Kiss: Act II. No. 26. Finale. Tormentilla: "Too dark for me..."',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 10347 AND p.composer_id = 69 AND part.part_key = 'musicbrainz:1ee1864c-8f12-48a9-9819-dec28dd8d06e' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:1ee1864c-8f12-48a9-9819-dec28dd8d06e', 4, NULL, 'Act II. No. 26. Finale. Tormentilla: "Too dark for me..."', 'The Poisoned Kiss: Act II. No. 26. Finale. Tormentilla: "Too dark for me..."', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:7b97a880-fc47-4617-b356-b0b51846dcc2'
WHERE p.id = 10347 AND p.composer_id = 69
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:1ee1864c-8f12-48a9-9819-dec28dd8d06e'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:7b97a880-fc47-4617-b356-b0b51846dcc2'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 5, part.movement_number = NULL,
    part.name_ko = 'Act II. No. 22. Ensemble. Amaryllus: "Twas here it bade..."', part.name_en = 'The Poisoned Kiss: Act II. No. 22. Ensemble. Amaryllus: "Twas here it bade..."',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 10347 AND p.composer_id = 69 AND part.part_key = 'musicbrainz:3c24c1b0-7098-41ea-ac08-bc258bbdbbc1' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:3c24c1b0-7098-41ea-ac08-bc258bbdbbc1', 5, NULL, 'Act II. No. 22. Ensemble. Amaryllus: "Twas here it bade..."', 'The Poisoned Kiss: Act II. No. 22. Ensemble. Amaryllus: "Twas here it bade..."', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:7b97a880-fc47-4617-b356-b0b51846dcc2'
WHERE p.id = 10347 AND p.composer_id = 69
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:3c24c1b0-7098-41ea-ac08-bc258bbdbbc1'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:7b97a880-fc47-4617-b356-b0b51846dcc2'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 6, part.movement_number = NULL,
    part.name_ko = 'Act II. No. 19. Trio. Third Medium: "If you want to escape"', part.name_en = 'The Poisoned Kiss: Act II. No. 19. Trio. Third Medium: "If you want to escape"',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 10347 AND p.composer_id = 69 AND part.part_key = 'musicbrainz:74531199-a27a-4efe-9c1b-5f973ec30177' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:74531199-a27a-4efe-9c1b-5f973ec30177', 6, NULL, 'Act II. No. 19. Trio. Third Medium: "If you want to escape"', 'The Poisoned Kiss: Act II. No. 19. Trio. Third Medium: "If you want to escape"', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:7b97a880-fc47-4617-b356-b0b51846dcc2'
WHERE p.id = 10347 AND p.composer_id = 69
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:74531199-a27a-4efe-9c1b-5f973ec30177'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:7b97a880-fc47-4617-b356-b0b51846dcc2'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 7, part.movement_number = NULL,
    part.name_ko = 'Act II. No. 17. Trio. Lob: "Ho there!"', part.name_en = 'The Poisoned Kiss: Act II. No. 17. Trio. Lob: "Ho there!"',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 10347 AND p.composer_id = 69 AND part.part_key = 'musicbrainz:89ee58b7-72bb-4803-8ebe-9ee9b11ca938' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:89ee58b7-72bb-4803-8ebe-9ee9b11ca938', 7, NULL, 'Act II. No. 17. Trio. Lob: "Ho there!"', 'The Poisoned Kiss: Act II. No. 17. Trio. Lob: "Ho there!"', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:7b97a880-fc47-4617-b356-b0b51846dcc2'
WHERE p.id = 10347 AND p.composer_id = 69
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:89ee58b7-72bb-4803-8ebe-9ee9b11ca938'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:7b97a880-fc47-4617-b356-b0b51846dcc2'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 8, part.movement_number = NULL,
    part.name_ko = 'Act II. No. 16. Song and Chorus. Angelica and flower girls: "By all the powers..."', part.name_en = 'The Poisoned Kiss: Act II. No. 16. Song and Chorus. Angelica and flower girls: "By all the powers..."',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 10347 AND p.composer_id = 69 AND part.part_key = 'musicbrainz:8c4a36b6-998d-4887-ba23-6176ecb6c0ca' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:8c4a36b6-998d-4887-ba23-6176ecb6c0ca', 8, NULL, 'Act II. No. 16. Song and Chorus. Angelica and flower girls: "By all the powers..."', 'The Poisoned Kiss: Act II. No. 16. Song and Chorus. Angelica and flower girls: "By all the powers..."', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:7b97a880-fc47-4617-b356-b0b51846dcc2'
WHERE p.id = 10347 AND p.composer_id = 69
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:8c4a36b6-998d-4887-ba23-6176ecb6c0ca'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:7b97a880-fc47-4617-b356-b0b51846dcc2'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 9, part.movement_number = NULL,
    part.name_ko = 'Act II. No. 21. Song and Duet. Tormentilla: "There was..."', part.name_en = 'The Poisoned Kiss: Act II. No. 21. Song and Duet. Tormentilla: "There was..."',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 10347 AND p.composer_id = 69 AND part.part_key = 'musicbrainz:a0aefc11-5aa7-438a-9ab2-1c0df0eea109' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:a0aefc11-5aa7-438a-9ab2-1c0df0eea109', 9, NULL, 'Act II. No. 21. Song and Duet. Tormentilla: "There was..."', 'The Poisoned Kiss: Act II. No. 21. Song and Duet. Tormentilla: "There was..."', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:7b97a880-fc47-4617-b356-b0b51846dcc2'
WHERE p.id = 10347 AND p.composer_id = 69
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:a0aefc11-5aa7-438a-9ab2-1c0df0eea109'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:7b97a880-fc47-4617-b356-b0b51846dcc2'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 10, part.movement_number = NULL,
    part.name_ko = 'Act II. No. 15. Chorus: "Here we come"', part.name_en = 'The Poisoned Kiss: Act II. No. 15. Chorus: "Here we come"',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 10347 AND p.composer_id = 69 AND part.part_key = 'musicbrainz:aa0b17b8-404f-4180-8864-5684c1e16b33' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:aa0b17b8-404f-4180-8864-5684c1e16b33', 10, NULL, 'Act II. No. 15. Chorus: "Here we come"', 'The Poisoned Kiss: Act II. No. 15. Chorus: "Here we come"', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:7b97a880-fc47-4617-b356-b0b51846dcc2'
WHERE p.id = 10347 AND p.composer_id = 69
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:aa0b17b8-404f-4180-8864-5684c1e16b33'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:7b97a880-fc47-4617-b356-b0b51846dcc2'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 11, part.movement_number = NULL,
    part.name_ko = 'Act II. No. 18. Duet. Angelica: "It does not appear..."', part.name_en = 'The Poisoned Kiss: Act II. No. 18. Duet. Angelica: "It does not appear..."',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 10347 AND p.composer_id = 69 AND part.part_key = 'musicbrainz:b9ebac50-ab39-40e9-9329-e61e7528b991' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:b9ebac50-ab39-40e9-9329-e61e7528b991', 11, NULL, 'Act II. No. 18. Duet. Angelica: "It does not appear..."', 'The Poisoned Kiss: Act II. No. 18. Duet. Angelica: "It does not appear..."', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:7b97a880-fc47-4617-b356-b0b51846dcc2'
WHERE p.id = 10347 AND p.composer_id = 69
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:b9ebac50-ab39-40e9-9329-e61e7528b991'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:7b97a880-fc47-4617-b356-b0b51846dcc2'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 12, part.movement_number = NULL,
    part.name_ko = 'Act II. No. 24. Duet. Tormentilla: "Sleeping or waking" - "You must not kiss me"', part.name_en = 'The Poisoned Kiss: Act II. No. 24. Duet. Tormentilla: "Sleeping or waking" - "You must not kiss me"',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 10347 AND p.composer_id = 69 AND part.part_key = 'musicbrainz:cf7363be-3bc3-443a-ab5c-2312d405fd4c' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:cf7363be-3bc3-443a-ab5c-2312d405fd4c', 12, NULL, 'Act II. No. 24. Duet. Tormentilla: "Sleeping or waking" - "You must not kiss me"', 'The Poisoned Kiss: Act II. No. 24. Duet. Tormentilla: "Sleeping or waking" - "You must not kiss me"', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:7b97a880-fc47-4617-b356-b0b51846dcc2'
WHERE p.id = 10347 AND p.composer_id = 69
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:cf7363be-3bc3-443a-ab5c-2312d405fd4c'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = NULL,
    part.name_ko = 'Act III', part.name_en = 'The Poisoned Kiss: Act III',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 10347 AND p.composer_id = 69 AND part.part_key = 'musicbrainz:8c14a06d-b149-4275-a853-f4cf7ea208e5' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:8c14a06d-b149-4275-a853-f4cf7ea208e5', 4, NULL, 'Act III', 'The Poisoned Kiss: Act III', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 10347 AND p.composer_id = 69
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:8c14a06d-b149-4275-a853-f4cf7ea208e5'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:8c14a06d-b149-4275-a853-f4cf7ea208e5'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'Act III. No. 38. Duet. Gallanthus: "It"s the proper thing to do"', part.name_en = 'The Poisoned Kiss: Act III. No. 38. Duet. Gallanthus: "It"s the proper thing to do"',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 10347 AND p.composer_id = 69 AND part.part_key = 'musicbrainz:1175edea-cd31-4fea-8a04-11b710ee1e59' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:1175edea-cd31-4fea-8a04-11b710ee1e59', 1, NULL, 'Act III. No. 38. Duet. Gallanthus: "It"s the proper thing to do"', 'The Poisoned Kiss: Act III. No. 38. Duet. Gallanthus: "It"s the proper thing to do"', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:8c14a06d-b149-4275-a853-f4cf7ea208e5'
WHERE p.id = 10347 AND p.composer_id = 69
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:1175edea-cd31-4fea-8a04-11b710ee1e59'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:8c14a06d-b149-4275-a853-f4cf7ea208e5'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'Act III. No. 36. Quartet. All: "Love in a hut..."', part.name_en = 'The Poisoned Kiss: Act III. No. 36. Quartet. All: "Love in a hut..."',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 10347 AND p.composer_id = 69 AND part.part_key = 'musicbrainz:143a2f20-086a-4305-b7b0-1935466a92a9' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:143a2f20-086a-4305-b7b0-1935466a92a9', 2, NULL, 'Act III. No. 36. Quartet. All: "Love in a hut..."', 'The Poisoned Kiss: Act III. No. 36. Quartet. All: "Love in a hut..."', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:8c14a06d-b149-4275-a853-f4cf7ea208e5'
WHERE p.id = 10347 AND p.composer_id = 69
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:143a2f20-086a-4305-b7b0-1935466a92a9'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:8c14a06d-b149-4275-a853-f4cf7ea208e5'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = NULL,
    part.name_ko = 'Act III. No. 37. Sextet. First Medium: "Horrid monster!"', part.name_en = 'The Poisoned Kiss: Act III. No. 37. Sextet. First Medium: "Horrid monster!"',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 10347 AND p.composer_id = 69 AND part.part_key = 'musicbrainz:242cfc7e-5156-4001-a600-ce2992cbe49a' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:242cfc7e-5156-4001-a600-ce2992cbe49a', 3, NULL, 'Act III. No. 37. Sextet. First Medium: "Horrid monster!"', 'The Poisoned Kiss: Act III. No. 37. Sextet. First Medium: "Horrid monster!"', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:8c14a06d-b149-4275-a853-f4cf7ea208e5'
WHERE p.id = 10347 AND p.composer_id = 69
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:242cfc7e-5156-4001-a600-ce2992cbe49a'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:8c14a06d-b149-4275-a853-f4cf7ea208e5'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = NULL,
    part.name_ko = 'Act III. No. 31.Ensemble. Empress: "You can leave us"', part.name_en = 'The Poisoned Kiss: Act III. No. 31.Ensemble. Empress: "You can leave us"',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 10347 AND p.composer_id = 69 AND part.part_key = 'musicbrainz:36cdfe7c-ea5b-4f2b-ba9e-a2a5d6ccdb0d' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:36cdfe7c-ea5b-4f2b-ba9e-a2a5d6ccdb0d', 4, NULL, 'Act III. No. 31.Ensemble. Empress: "You can leave us"', 'The Poisoned Kiss: Act III. No. 31.Ensemble. Empress: "You can leave us"', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:8c14a06d-b149-4275-a853-f4cf7ea208e5'
WHERE p.id = 10347 AND p.composer_id = 69
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:36cdfe7c-ea5b-4f2b-ba9e-a2a5d6ccdb0d'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:8c14a06d-b149-4275-a853-f4cf7ea208e5'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 5, part.movement_number = NULL,
    part.name_ko = 'Act III. No. 33. Invocation. Empress: "Imps and Demons"', part.name_en = 'The Poisoned Kiss: Act III. No. 33. Invocation. Empress: "Imps and Demons"',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 10347 AND p.composer_id = 69 AND part.part_key = 'musicbrainz:3dc7f318-593b-44cb-a7ba-01e7a87b702e' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:3dc7f318-593b-44cb-a7ba-01e7a87b702e', 5, NULL, 'Act III. No. 33. Invocation. Empress: "Imps and Demons"', 'The Poisoned Kiss: Act III. No. 33. Invocation. Empress: "Imps and Demons"', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:8c14a06d-b149-4275-a853-f4cf7ea208e5'
WHERE p.id = 10347 AND p.composer_id = 69
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:3dc7f318-593b-44cb-a7ba-01e7a87b702e'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:8c14a06d-b149-4275-a853-f4cf7ea208e5'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 6, part.movement_number = NULL,
    part.name_ko = 'Act III. No. 30. Ballad. Empress: "When I was young..."', part.name_en = 'The Poisoned Kiss: Act III. No. 30. Ballad. Empress: "When I was young..."',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 10347 AND p.composer_id = 69 AND part.part_key = 'musicbrainz:543d6d80-73a4-4ec1-9b71-94ed183ff32a' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:543d6d80-73a4-4ec1-9b71-94ed183ff32a', 6, NULL, 'Act III. No. 30. Ballad. Empress: "When I was young..."', 'The Poisoned Kiss: Act III. No. 30. Ballad. Empress: "When I was young..."', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:8c14a06d-b149-4275-a853-f4cf7ea208e5'
WHERE p.id = 10347 AND p.composer_id = 69
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:543d6d80-73a4-4ec1-9b71-94ed183ff32a'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:8c14a06d-b149-4275-a853-f4cf7ea208e5'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 7, part.movement_number = NULL,
    part.name_ko = 'Act III. No. 27. Introduction', part.name_en = 'The Poisoned Kiss: Act III. No. 27. Introduction',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 10347 AND p.composer_id = 69 AND part.part_key = 'musicbrainz:6cf1333e-754c-4436-8e70-3a18def87a52' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:6cf1333e-754c-4436-8e70-3a18def87a52', 7, NULL, 'Act III. No. 27. Introduction', 'The Poisoned Kiss: Act III. No. 27. Introduction', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:8c14a06d-b149-4275-a853-f4cf7ea208e5'
WHERE p.id = 10347 AND p.composer_id = 69
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:6cf1333e-754c-4436-8e70-3a18def87a52'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:8c14a06d-b149-4275-a853-f4cf7ea208e5'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 8, part.movement_number = NULL,
    part.name_ko = 'Act III. No. 29. Ensemble. Empress: "Monstrous vision!"', part.name_en = 'The Poisoned Kiss: Act III. No. 29. Ensemble. Empress: "Monstrous vision!"',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 10347 AND p.composer_id = 69 AND part.part_key = 'musicbrainz:78858617-e019-4ed8-a1dd-b342dade3641' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:78858617-e019-4ed8-a1dd-b342dade3641', 8, NULL, 'Act III. No. 29. Ensemble. Empress: "Monstrous vision!"', 'The Poisoned Kiss: Act III. No. 29. Ensemble. Empress: "Monstrous vision!"', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:8c14a06d-b149-4275-a853-f4cf7ea208e5'
WHERE p.id = 10347 AND p.composer_id = 69
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:78858617-e019-4ed8-a1dd-b342dade3641'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:8c14a06d-b149-4275-a853-f4cf7ea208e5'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 9, part.movement_number = NULL,
    part.name_ko = 'Act III. No. 34. Ensemble. Empress: "Come, O gentle powers"', part.name_en = 'The Poisoned Kiss: Act III. No. 34. Ensemble. Empress: "Come, O gentle powers"',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 10347 AND p.composer_id = 69 AND part.part_key = 'musicbrainz:87ae325c-9b84-4a3b-accd-7ca5bb04d8dc' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:87ae325c-9b84-4a3b-accd-7ca5bb04d8dc', 9, NULL, 'Act III. No. 34. Ensemble. Empress: "Come, O gentle powers"', 'The Poisoned Kiss: Act III. No. 34. Ensemble. Empress: "Come, O gentle powers"', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:8c14a06d-b149-4275-a853-f4cf7ea208e5'
WHERE p.id = 10347 AND p.composer_id = 69
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:87ae325c-9b84-4a3b-accd-7ca5bb04d8dc'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:8c14a06d-b149-4275-a853-f4cf7ea208e5'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 10, part.movement_number = NULL,
    part.name_ko = 'Act III. No. 28. Trio. Mediums: "Behold our mystic..."', part.name_en = 'The Poisoned Kiss: Act III. No. 28. Trio. Mediums: "Behold our mystic..."',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 10347 AND p.composer_id = 69 AND part.part_key = 'musicbrainz:97a77019-db5e-4af9-9b9f-5b190b2290af' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:97a77019-db5e-4af9-9b9f-5b190b2290af', 10, NULL, 'Act III. No. 28. Trio. Mediums: "Behold our mystic..."', 'The Poisoned Kiss: Act III. No. 28. Trio. Mediums: "Behold our mystic..."', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:8c14a06d-b149-4275-a853-f4cf7ea208e5'
WHERE p.id = 10347 AND p.composer_id = 69
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:97a77019-db5e-4af9-9b9f-5b190b2290af'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:8c14a06d-b149-4275-a853-f4cf7ea208e5'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 11, part.movement_number = NULL,
    part.name_ko = 'Act III. No. 32. Duet. Tormentilla: "Is my love alive?" - Empress: "Love breaks all rules..."', part.name_en = 'The Poisoned Kiss: Act III. No. 32. Duet. Tormentilla: "Is my love alive?" - Empress: "Love breaks all rules..."',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 10347 AND p.composer_id = 69 AND part.part_key = 'musicbrainz:b4e447af-3dcb-4337-a14c-3005827ac51a' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:b4e447af-3dcb-4337-a14c-3005827ac51a', 11, NULL, 'Act III. No. 32. Duet. Tormentilla: "Is my love alive?" - Empress: "Love breaks all rules..."', 'The Poisoned Kiss: Act III. No. 32. Duet. Tormentilla: "Is my love alive?" - Empress: "Love breaks all rules..."', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:8c14a06d-b149-4275-a853-f4cf7ea208e5'
WHERE p.id = 10347 AND p.composer_id = 69
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:b4e447af-3dcb-4337-a14c-3005827ac51a'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:8c14a06d-b149-4275-a853-f4cf7ea208e5'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 12, part.movement_number = NULL,
    part.name_ko = 'Act III. No. 39. Finale. Chorus: "Love has conquered!"', part.name_en = 'The Poisoned Kiss: Act III. No. 39. Finale. Chorus: "Love has conquered!"',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 10347 AND p.composer_id = 69 AND part.part_key = 'musicbrainz:e6778069-9d24-4aa2-b7d8-bcde8726a2d6' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:e6778069-9d24-4aa2-b7d8-bcde8726a2d6', 12, NULL, 'Act III. No. 39. Finale. Chorus: "Love has conquered!"', 'The Poisoned Kiss: Act III. No. 39. Finale. Chorus: "Love has conquered!"', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:8c14a06d-b149-4275-a853-f4cf7ea208e5'
WHERE p.id = 10347 AND p.composer_id = 69
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:e6778069-9d24-4aa2-b7d8-bcde8726a2d6'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:8c14a06d-b149-4275-a853-f4cf7ea208e5'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 13, part.movement_number = NULL,
    part.name_ko = 'Act III. No. 35. Duet. Empress: "Can you, can you remember"', part.name_en = 'The Poisoned Kiss: Act III. No. 35. Duet. Empress: "Can you, can you remember"',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 10347 AND p.composer_id = 69 AND part.part_key = 'musicbrainz:fefd59f9-9b88-4fec-9a8e-45a986c1d782' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:fefd59f9-9b88-4fec-9a8e-45a986c1d782', 13, NULL, 'Act III. No. 35. Duet. Empress: "Can you, can you remember"', 'The Poisoned Kiss: Act III. No. 35. Duet. Empress: "Can you, can you remember"', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:8c14a06d-b149-4275-a853-f4cf7ea208e5'
WHERE p.id = 10347 AND p.composer_id = 69
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:fefd59f9-9b88-4fec-9a8e-45a986c1d782'
);


-- None The Shepherds of the Delectable Mountains

UPDATE pieces piece
SET piece.title = 'The Shepherds of the Delectable Mountains', piece.title_en = 'The Shepherds of the Delectable Mountains',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 8305 AND piece.composer_id = 69
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None 가곡 <The Sky Above the Roof>

UPDATE pieces piece
SET piece.title = '가곡 <The Sky Above the Roof>', piece.title_en = 'The Sky Above the Roof',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 10371 AND piece.composer_id = 69
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None The Solent

UPDATE pieces piece
SET piece.title = 'The Solent', piece.title_en = 'The Solent',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 7716 AND piece.composer_id = 69
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None 칸타타 <The Sons of Light>

UPDATE pieces piece
SET piece.title = '칸타타 <The Sons of Light>', piece.title_en = 'The Sons of Light',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 7667 AND piece.composer_id = 69
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'Darkness and Light', part.name_en = 'The Sons of Light: I. Darkness and Light',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 7667 AND p.composer_id = 69 AND part.part_key = 'musicbrainz:c7e1dcaf-8d84-31ec-a09b-8ad61361325c' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:c7e1dcaf-8d84-31ec-a09b-8ad61361325c', 1, 'I', 'Darkness and Light', 'The Sons of Light: I. Darkness and Light', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 7667 AND p.composer_id = 69
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:c7e1dcaf-8d84-31ec-a09b-8ad61361325c'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'The Song of the Zodiac', part.name_en = 'The Sons of Light: II. The Song of the Zodiac',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 7667 AND p.composer_id = 69 AND part.part_key = 'musicbrainz:5161d06a-90b9-377a-8c24-3e4ae809805e' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:5161d06a-90b9-377a-8c24-3e4ae809805e', 2, 'II', 'The Song of the Zodiac', 'The Sons of Light: II. The Song of the Zodiac', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 7667 AND p.composer_id = 69
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:5161d06a-90b9-377a-8c24-3e4ae809805e'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = 'The Messengers of Speech', part.name_en = 'The Sons of Light: III. The Messengers of Speech',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 7667 AND p.composer_id = 69 AND part.part_key = 'musicbrainz:7d238101-848d-38c8-beb2-bbad2e6cf58c' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:7d238101-848d-38c8-beb2-bbad2e6cf58c', 3, 'III', 'The Messengers of Speech', 'The Sons of Light: III. The Messengers of Speech', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 7667 AND p.composer_id = 69
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:7d238101-848d-38c8-beb2-bbad2e6cf58c'
);


-- None The Souls of the Righteous

UPDATE pieces piece
SET piece.title = 'The Souls of the Righteous', piece.title_en = 'The Souls of the Righteous',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 7705 AND piece.composer_id = 69
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None 가곡 <The Splendour Falls>

UPDATE pieces piece
SET piece.title = '가곡 <The Splendour Falls>', piece.title_en = 'The Splendour Falls',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 9944 AND piece.composer_id = 69
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None The Steersman

UPDATE pieces piece
SET piece.title = 'The Steersman', piece.title_en = 'The Steersman',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 8721 AND piece.composer_id = 69
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None The Twenty Third Psalm

UPDATE pieces piece
SET piece.title = 'The Twenty Third Psalm', piece.title_en = 'The Twenty Third Psalm',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 7493 AND piece.composer_id = 69
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None The Voice out of the Whirlwind

UPDATE pieces piece
SET piece.title = 'The Voice out of the Whirlwind', piece.title_en = 'The Voice out of the Whirlwind',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 7665 AND piece.composer_id = 69
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None 가곡 <The Winter Is Gone>

UPDATE pieces piece
SET piece.title = '가곡 <The Winter Is Gone>', piece.title_en = 'The Winter Is Gone',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 7668 AND piece.composer_id = 69
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None The Winter’s Willow

UPDATE pieces piece
SET piece.title = 'The Winter’s Willow', piece.title_en = 'The Winter’s Willow',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 7704 AND piece.composer_id = 69
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None 가곡 <Think of Me>

UPDATE pieces piece
SET piece.title = '가곡 <Think of Me>', piece.title_en = 'Think of Me',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 11097 AND piece.composer_id = 69
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Three Choral Hymns

UPDATE pieces piece
SET piece.title = 'Three Choral Hymns', piece.title_en = 'Three Choral Hymns',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 7671 AND piece.composer_id = 69
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'Easter Hymn', part.name_en = 'Three Choral Hymns: No. 1. Easter Hymn',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 7671 AND p.composer_id = 69 AND part.part_key = 'musicbrainz:33bd0115-343f-4a12-9a75-1a7eed9dfe3e' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:33bd0115-343f-4a12-9a75-1a7eed9dfe3e', 1, NULL, 'Easter Hymn', 'Three Choral Hymns: No. 1. Easter Hymn', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 7671 AND p.composer_id = 69
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:33bd0115-343f-4a12-9a75-1a7eed9dfe3e'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'Christmas Hymn', part.name_en = 'Three Choral Hymns: No. 2. Christmas Hymn',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 7671 AND p.composer_id = 69 AND part.part_key = 'musicbrainz:bf295676-c0d8-4675-84d6-435fc02497d3' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:bf295676-c0d8-4675-84d6-435fc02497d3', 2, NULL, 'Christmas Hymn', 'Three Choral Hymns: No. 2. Christmas Hymn', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 7671 AND p.composer_id = 69
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:bf295676-c0d8-4675-84d6-435fc02497d3'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = NULL,
    part.name_ko = 'Whitsunday Hymn', part.name_en = 'Three Choral Hymns: No. 3. Whitsunday Hymn',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 7671 AND p.composer_id = 69 AND part.part_key = 'musicbrainz:1b921c8c-4808-49e7-8989-1f49235c870e' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:1b921c8c-4808-49e7-8989-1f49235c870e', 3, NULL, 'Whitsunday Hymn', 'Three Choral Hymns: No. 3. Whitsunday Hymn', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 7671 AND p.composer_id = 69
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:1b921c8c-4808-49e7-8989-1f49235c870e'
);


-- None Three Elizabethan Songs

UPDATE pieces piece
SET piece.title = 'Three Elizabethan Songs', piece.title_en = 'Three Elizabethan Songs',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 7696 AND piece.composer_id = 69
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'Sweet Day', part.name_en = 'Three Elizabethan Songs: Sweet Day',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 7696 AND p.composer_id = 69 AND part.part_key = 'musicbrainz:b29a4dd3-682a-4dcb-adb4-afcfa05d7e20' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:b29a4dd3-682a-4dcb-adb4-afcfa05d7e20', 1, NULL, 'Sweet Day', 'Three Elizabethan Songs: Sweet Day', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 7696 AND p.composer_id = 69
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:b29a4dd3-682a-4dcb-adb4-afcfa05d7e20'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'The Willow Song', part.name_en = 'Three Elizabethan Songs: The Willow Song',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 7696 AND p.composer_id = 69 AND part.part_key = 'musicbrainz:c6893f8f-5d92-4571-93e3-dfaa9baf786f' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:c6893f8f-5d92-4571-93e3-dfaa9baf786f', 2, NULL, 'The Willow Song', 'Three Elizabethan Songs: The Willow Song', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 7696 AND p.composer_id = 69
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:c6893f8f-5d92-4571-93e3-dfaa9baf786f'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = NULL,
    part.name_ko = 'O Mistress Mine', part.name_en = 'Three Elizabethan Songs: O Mistress Mine',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 7696 AND p.composer_id = 69 AND part.part_key = 'musicbrainz:eb4dffa1-4a24-4f6e-95d5-d9d803e7b268' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:eb4dffa1-4a24-4f6e-95d5-d9d803e7b268', 3, NULL, 'O Mistress Mine', 'Three Elizabethan Songs: O Mistress Mine', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 7696 AND p.composer_id = 69
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:eb4dffa1-4a24-4f6e-95d5-d9d803e7b268'
);


-- None 연가곡집 <Three Gaelic Songs>

UPDATE pieces piece
SET piece.title = '연가곡집 <Three Gaelic Songs>', piece.title_en = 'Three Gaelic Songs',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 7979 AND piece.composer_id = 69
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'Dawn on the Hills', part.name_en = 'Three Gaelic Songs: Dawn on the Hills',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 7979 AND p.composer_id = 69 AND part.part_key = 'musicbrainz:cc81b96a-3bb4-4868-bbaa-7546807bcd24' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:cc81b96a-3bb4-4868-bbaa-7546807bcd24', 1, NULL, 'Dawn on the Hills', 'Three Gaelic Songs: Dawn on the Hills', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 7979 AND p.composer_id = 69
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:cc81b96a-3bb4-4868-bbaa-7546807bcd24'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'Come Let Us Gather Cockles', part.name_en = 'Three Gaelic Songs: Come Let Us Gather Cockles',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 7979 AND p.composer_id = 69 AND part.part_key = 'musicbrainz:cc5e03e5-d4d0-4146-8459-c5652e106e04' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:cc5e03e5-d4d0-4146-8459-c5652e106e04', 2, NULL, 'Come Let Us Gather Cockles', 'Three Gaelic Songs: Come Let Us Gather Cockles', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 7979 AND p.composer_id = 69
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:cc5e03e5-d4d0-4146-8459-c5652e106e04'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = NULL,
    part.name_ko = 'Wake and Rise', part.name_en = 'Three Gaelic Songs: Wake and Rise',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 7979 AND p.composer_id = 69 AND part.part_key = 'musicbrainz:30733f9a-dba8-4661-943d-aa72ccc40ea1' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:30733f9a-dba8-4661-943d-aa72ccc40ea1', 3, NULL, 'Wake and Rise', 'Three Gaelic Songs: Wake and Rise', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 7979 AND p.composer_id = 69
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:30733f9a-dba8-4661-943d-aa72ccc40ea1'
);


-- None Three Preludes Founded on Welsh Hymn Tunes for the Organ

UPDATE pieces piece
SET piece.title = 'Three Preludes Founded on Welsh Hymn Tunes for the Organ', piece.title_en = 'Three Preludes Founded on Welsh Hymn Tunes for the Organ',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 7701 AND piece.composer_id = 69
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'Organ Prelude on Bryn Calfaria', part.name_en = 'Organ Prelude on Bryn Calfaria',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 7701 AND p.composer_id = 69 AND part.part_key = 'musicbrainz:155fd4fb-b495-4a9e-a539-677fa5e484bb' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:155fd4fb-b495-4a9e-a539-677fa5e484bb', 1, NULL, 'Organ Prelude on Bryn Calfaria', 'Organ Prelude on Bryn Calfaria', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 7701 AND p.composer_id = 69
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:155fd4fb-b495-4a9e-a539-677fa5e484bb'
);


-- None Three Shakespeare Songs

UPDATE pieces piece
SET piece.title = 'Three Shakespeare Songs', piece.title_en = 'Three Shakespeare Songs',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 7709 AND piece.composer_id = 69
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'Full fathom five', part.name_en = 'Three Shakespeare Songs: Full fathom five',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 7709 AND p.composer_id = 69 AND part.part_key = 'musicbrainz:95611df9-6f90-4206-8830-e0dc190ec999' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:95611df9-6f90-4206-8830-e0dc190ec999', 1, NULL, 'Full fathom five', 'Three Shakespeare Songs: Full fathom five', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 7709 AND p.composer_id = 69
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:95611df9-6f90-4206-8830-e0dc190ec999'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'The cloud-capp’d towers', part.name_en = 'Three Shakespeare Songs: The cloud-capp’d towers',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 7709 AND p.composer_id = 69 AND part.part_key = 'musicbrainz:709175e7-6687-4f16-a40d-0080ebe3b38a' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:709175e7-6687-4f16-a40d-0080ebe3b38a', 2, NULL, 'The cloud-capp’d towers', 'Three Shakespeare Songs: The cloud-capp’d towers', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 7709 AND p.composer_id = 69
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:709175e7-6687-4f16-a40d-0080ebe3b38a'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = NULL,
    part.name_ko = 'Over hill, over dale', part.name_en = 'Three Shakespeare Songs: Over hill, over dale',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 7709 AND p.composer_id = 69 AND part.part_key = 'musicbrainz:52ec3fed-a056-4798-86d1-d45e93f7716b' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:52ec3fed-a056-4798-86d1-d45e93f7716b', 3, NULL, 'Over hill, over dale', 'Three Shakespeare Songs: Over hill, over dale', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 7709 AND p.composer_id = 69
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:52ec3fed-a056-4798-86d1-d45e93f7716b'
);


-- None 연가곡집 <Three Vocal Valses from The Songs of the Wrens>

UPDATE pieces piece
SET piece.title = '연가곡집 <Three Vocal Valses from The Songs of the Wrens>', piece.title_en = 'Three Vocal Valses from The Songs of the Wrens',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 10200 AND piece.composer_id = 69
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'Spring', part.name_en = 'Three Vocal Valses from The Songs of the Wrens: Spring',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 10200 AND p.composer_id = 69 AND part.part_key = 'musicbrainz:342f68a6-3b09-401d-b8ef-be5212d14a82' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:342f68a6-3b09-401d-b8ef-be5212d14a82', 1, NULL, 'Spring', 'Three Vocal Valses from The Songs of the Wrens: Spring', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 10200 AND p.composer_id = 69
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:342f68a6-3b09-401d-b8ef-be5212d14a82'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'Winter', part.name_en = 'Three Vocal Valses from The Songs of the Wrens: Winter',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 10200 AND p.composer_id = 69 AND part.part_key = 'musicbrainz:390f619c-8b9d-44ef-8922-24f43044aea4' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:390f619c-8b9d-44ef-8922-24f43044aea4', 2, NULL, 'Winter', 'Three Vocal Valses from The Songs of the Wrens: Winter', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 10200 AND p.composer_id = 69
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:390f619c-8b9d-44ef-8922-24f43044aea4'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = NULL,
    part.name_ko = 'Vine, Vine, Eglantine', part.name_en = 'Three Vocal Valses from The Songs of the Wrens: Vine, Vine, Eglantine',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 10200 AND p.composer_id = 69 AND part.part_key = 'musicbrainz:969ddb2c-4aaf-4729-87a0-8126204893de' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:969ddb2c-4aaf-4729-87a0-8126204893de', 3, NULL, 'Vine, Vine, Eglantine', 'Three Vocal Valses from The Songs of the Wrens: Vine, Vine, Eglantine', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 10200 AND p.composer_id = 69
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:969ddb2c-4aaf-4729-87a0-8126204893de'
);


-- None Three Vocalises for Soprano and Clarinet

UPDATE pieces piece
SET piece.title = 'Three Vocalises for Soprano and Clarinet', piece.title_en = 'Three Vocalises for Soprano and Clarinet',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 7674 AND piece.composer_id = 69
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'Prelude', part.name_en = 'Three Vocalises for Soprano and Clarinet: I. Prelude',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 7674 AND p.composer_id = 69 AND part.part_key = 'musicbrainz:77b75128-9947-4d6a-8678-468c7931b181' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:77b75128-9947-4d6a-8678-468c7931b181', 1, 'I', 'Prelude', 'Three Vocalises for Soprano and Clarinet: I. Prelude', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 7674 AND p.composer_id = 69
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:77b75128-9947-4d6a-8678-468c7931b181'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'Scherzo', part.name_en = 'Three Vocalises for Soprano and Clarinet: II. Scherzo',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 7674 AND p.composer_id = 69 AND part.part_key = 'musicbrainz:85a8d359-c33b-47a7-9323-ca044cdc5a01' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:85a8d359-c33b-47a7-9323-ca044cdc5a01', 2, 'II', 'Scherzo', 'Three Vocalises for Soprano and Clarinet: II. Scherzo', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 7674 AND p.composer_id = 69
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:85a8d359-c33b-47a7-9323-ca044cdc5a01'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = 'Quasi menuetto', part.name_en = 'Three Vocalises for Soprano and Clarinet: III. Quasi menuetto',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 7674 AND p.composer_id = 69 AND part.part_key = 'musicbrainz:3930c99c-010d-4a44-9e52-f1f57c2cd812' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:3930c99c-010d-4a44-9e52-f1f57c2cd812', 3, 'III', 'Quasi menuetto', 'Three Vocalises for Soprano and Clarinet: III. Quasi menuetto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 7674 AND p.composer_id = 69
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:3930c99c-010d-4a44-9e52-f1f57c2cd812'
);


-- None 가곡 <To Sleep! To Sleep!>

UPDATE pieces piece
SET piece.title = '가곡 <To Sleep! To Sleep!>', piece.title_en = 'To Sleep! To Sleep!',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 11047 AND piece.composer_id = 69
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Toccata marziale

UPDATE pieces piece
SET piece.title = 'Toccata marziale', piece.title_en = 'Toccata marziale',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 7663 AND piece.composer_id = 69
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None 가곡 <Toward the Unknown Region>

UPDATE pieces piece
SET piece.title = '가곡 <Toward the Unknown Region>', piece.title_en = 'Toward the Unknown Region',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 7691 AND piece.composer_id = 69
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Tuba Concerto

UPDATE pieces piece
SET piece.title = 'Tuba Concerto', piece.title_en = 'Tuba Concerto',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 7700 AND piece.composer_id = 69
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'Prelude: Allegro moderato', part.name_en = 'Tuba Concerto: I. Prelude: Allegro moderato',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 7700 AND p.composer_id = 69 AND part.part_key = 'musicbrainz:2c6e0439-d75f-35bf-8b06-a86549c3dcee' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:2c6e0439-d75f-35bf-8b06-a86549c3dcee', 1, 'I', 'Prelude: Allegro moderato', 'Tuba Concerto: I. Prelude: Allegro moderato', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 7700 AND p.composer_id = 69
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:2c6e0439-d75f-35bf-8b06-a86549c3dcee'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'Romanza: Andante sostenuto', part.name_en = 'Tuba Concerto: II. Romanza: Andante sostenuto',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 7700 AND p.composer_id = 69 AND part.part_key = 'musicbrainz:c68e496d-a53a-355d-9425-884c3d0eb117' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:c68e496d-a53a-355d-9425-884c3d0eb117', 2, 'II', 'Romanza: Andante sostenuto', 'Tuba Concerto: II. Romanza: Andante sostenuto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 7700 AND p.composer_id = 69
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:c68e496d-a53a-355d-9425-884c3d0eb117'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = 'Finale - Rondo alla tedesca: Allegro', part.name_en = 'Tuba Concerto: III. Finale - Rondo alla tedesca: Allegro',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 7700 AND p.composer_id = 69 AND part.part_key = 'musicbrainz:77e554c6-b409-3963-8fa4-2778b830952c' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:77e554c6-b409-3963-8fa4-2778b830952c', 3, 'III', 'Finale - Rondo alla tedesca: Allegro', 'Tuba Concerto: III. Finale - Rondo alla tedesca: Allegro', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 7700 AND p.composer_id = 69
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:77e554c6-b409-3963-8fa4-2778b830952c'
);


-- None Two Carols

UPDATE pieces piece
SET piece.title = 'Two Carols', piece.title_en = 'Two Carols',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 8567 AND piece.composer_id = 69
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'Come Love We God', part.name_en = 'Two Carols: Come Love We God',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 8567 AND p.composer_id = 69 AND part.part_key = 'musicbrainz:9363054b-e9c6-472d-9e85-a50c2da5ba47' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:9363054b-e9c6-472d-9e85-a50c2da5ba47', 1, NULL, 'Come Love We God', 'Two Carols: Come Love We God', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 8567 AND p.composer_id = 69
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:9363054b-e9c6-472d-9e85-a50c2da5ba47'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'There is a Flower', part.name_en = 'Two Carols: There is a Flower',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 8567 AND p.composer_id = 69 AND part.part_key = 'musicbrainz:fbefa6e7-513b-4367-b606-9eddbc7597c3' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:fbefa6e7-513b-4367-b606-9eddbc7597c3', 2, NULL, 'There is a Flower', 'Two Carols: There is a Flower', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 8567 AND p.composer_id = 69
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:fbefa6e7-513b-4367-b606-9eddbc7597c3'
);


-- None Two Hymn Tune Preludes

UPDATE pieces piece
SET piece.title = 'Two Hymn Tune Preludes', piece.title_en = 'Two Hymn Tune Preludes',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 9658 AND piece.composer_id = 69
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'Eventide', part.name_en = 'Two Hymn-Tune Preludes: 1. Eventide',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 9658 AND p.composer_id = 69 AND part.part_key = 'musicbrainz:accee1f5-a084-34cc-a9ab-ee3100e1536a' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:accee1f5-a084-34cc-a9ab-ee3100e1536a', 1, NULL, 'Eventide', 'Two Hymn-Tune Preludes: 1. Eventide', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 9658 AND p.composer_id = 69
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:accee1f5-a084-34cc-a9ab-ee3100e1536a'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'Dominus Regit Me', part.name_en = 'Two Hymn-Tune Preludes: 2. Dominus Regit Me',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 9658 AND p.composer_id = 69 AND part.part_key = 'musicbrainz:8f875ad8-62bb-3177-a1d3-fec14454e5a7' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:8f875ad8-62bb-3177-a1d3-fec14454e5a7', 2, NULL, 'Dominus Regit Me', 'Two Hymn-Tune Preludes: 2. Dominus Regit Me', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 9658 AND p.composer_id = 69
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:8f875ad8-62bb-3177-a1d3-fec14454e5a7'
);


-- None Two Movements from England’s Pleasant Land

UPDATE pieces piece
SET piece.title = 'Two Movements from England’s Pleasant Land', piece.title_en = 'Two Movements from England’s Pleasant Land',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 8180 AND piece.composer_id = 69
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'Exit of the Ghosts', part.name_en = 'Two Movements from England’s Pleasant Land: I. Exit of the Ghosts',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 8180 AND p.composer_id = 69 AND part.part_key = 'musicbrainz:0758d1e2-24f9-4e2a-b0ac-92c890324071' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:0758d1e2-24f9-4e2a-b0ac-92c890324071', 1, 'I', 'Exit of the Ghosts', 'Two Movements from England’s Pleasant Land: I. Exit of the Ghosts', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 8180 AND p.composer_id = 69
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:0758d1e2-24f9-4e2a-b0ac-92c890324071'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'Funeral March for the Old Order', part.name_en = 'Two Movements from England’s Pleasant Land: II. Funeral March for the Old Order',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 8180 AND p.composer_id = 69 AND part.part_key = 'musicbrainz:bfc88025-de09-437c-8292-751e2fc7a922' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:bfc88025-de09-437c-8292-751e2fc7a922', 2, 'II', 'Funeral March for the Old Order', 'Two Movements from England’s Pleasant Land: II. Funeral March for the Old Order', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 8180 AND p.composer_id = 69
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:bfc88025-de09-437c-8292-751e2fc7a922'
);


-- None 모테트 <Valiant-for-truth>

UPDATE pieces piece
SET piece.title = '모테트 <Valiant-for-truth>', piece.title_en = 'Valiant-for-truth',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 7582 AND piece.composer_id = 69
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Variations for Brass Band

UPDATE pieces piece
SET piece.title = 'Variations for Brass Band', piece.title_en = 'Variations for Brass Band',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 9145 AND piece.composer_id = 69
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None 바이올린 소나타 A단조

UPDATE pieces piece
SET piece.title = '바이올린 소나타 A단조', piece.title_en = 'Violin Sonata in A minor',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 7673 AND piece.composer_id = 69
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'Fantasia (Allegro giusto)', part.name_en = 'Violin Sonata in A minor: I. Fantasia (Allegro giusto)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 7673 AND p.composer_id = 69 AND part.part_key = 'musicbrainz:fa0a6fec-ae98-4c0f-a54c-5ef4ef113863' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:fa0a6fec-ae98-4c0f-a54c-5ef4ef113863', 1, 'I', 'Fantasia (Allegro giusto)', 'Violin Sonata in A minor: I. Fantasia (Allegro giusto)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 7673 AND p.composer_id = 69
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:fa0a6fec-ae98-4c0f-a54c-5ef4ef113863'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'Scherzo (Allegro furioso ma non troppo)', part.name_en = 'Violin Sonata in A minor: II. Scherzo (Allegro furioso ma non troppo)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 7673 AND p.composer_id = 69 AND part.part_key = 'musicbrainz:9b03714c-3ddc-485b-80b4-3402852d8015' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:9b03714c-3ddc-485b-80b4-3402852d8015', 2, 'II', 'Scherzo (Allegro furioso ma non troppo)', 'Violin Sonata in A minor: II. Scherzo (Allegro furioso ma non troppo)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 7673 AND p.composer_id = 69
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:9b03714c-3ddc-485b-80b4-3402852d8015'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = 'Tema con variazoni: Tema (Andante)', part.name_en = 'Violin Sonata in A minor: III. Tema con variazoni: Tema (Andante)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 7673 AND p.composer_id = 69 AND part.part_key = 'musicbrainz:d2bb280a-196d-4f9e-9cb6-ab4d8a4fd4cd' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:d2bb280a-196d-4f9e-9cb6-ab4d8a4fd4cd', 3, 'III', 'Tema con variazoni: Tema (Andante)', 'Violin Sonata in A minor: III. Tema con variazoni: Tema (Andante)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 7673 AND p.composer_id = 69
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:d2bb280a-196d-4f9e-9cb6-ab4d8a4fd4cd'
);


-- None Willow-Wood

UPDATE pieces piece
SET piece.title = 'Willow-Wood', piece.title_en = 'Willow-Wood',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 7702 AND piece.composer_id = 69
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None 가곡 <Wither’s Rocking Hymn>

UPDATE pieces piece
SET piece.title = '가곡 <Wither’s Rocking Hymn>', piece.title_en = 'Wither’s Rocking Hymn',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 9357 AND piece.composer_id = 69
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None A Song of Thanksgiving

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, 'A Song of Thanksgiving', 'A Song of Thanksgiving', 'song', NULL, NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 69
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = 'A Song of Thanksgiving'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '0dafc48a-757b-37e5-92c8-154e6b378c9c'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '0dafc48a-757b-37e5-92c8-154e6b378c9c'
FROM pieces p
WHERE p.composer_id = 69 AND p.title = 'A Song of Thanksgiving' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '0dafc48a-757b-37e5-92c8-154e6b378c9c'
);


-- None 가곡 <Adieu>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '가곡 <Adieu>', 'Adieu', 'song', NULL, NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 69
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '가곡 <Adieu>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'ba53e919-0046-47e2-b28e-d32f2785431b'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'ba53e919-0046-47e2-b28e-d32f2785431b'
FROM pieces p
WHERE p.composer_id = 69 AND p.title = '가곡 <Adieu>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'ba53e919-0046-47e2-b28e-d32f2785431b'
);


-- None Concerto Accademico

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, 'Concerto Accademico', 'Concerto Accademico', 'album', NULL, NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 69
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = 'Concerto Accademico'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'fe6dab42-26bb-371a-b768-efe77a590aa3'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'fe6dab42-26bb-371a-b768-efe77a590aa3'
FROM pieces p
WHERE p.composer_id = 69 AND p.title = 'Concerto Accademico' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'fe6dab42-26bb-371a-b768-efe77a590aa3'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:6e5f637e-d6d4-4436-9848-523cd6487ca8', 1, 'I', 'Allegro pesante', 'Concerto Accademico: I. Allegro pesante', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 69 AND p.title = 'Concerto Accademico' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:6e5f637e-d6d4-4436-9848-523cd6487ca8'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:6c0af471-70f9-498b-831f-baaba0107f42', 2, 'II', 'Adagio - Tranquillo', 'Concerto Accademico: II. Adagio - Tranquillo', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 69 AND p.title = 'Concerto Accademico' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:6c0af471-70f9-498b-831f-baaba0107f42'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:776099b0-af21-40d2-b1fc-d613b0e5fa33', 3, 'III', 'Presto', 'Concerto Accademico: III. Presto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 69 AND p.title = 'Concerto Accademico' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:776099b0-af21-40d2-b1fc-d613b0e5fa33'
);


-- None English Folk Song Suite

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, 'English Folk Song Suite', 'English Folk Song Suite', 'album', NULL, NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 69
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = 'English Folk Song Suite'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '8ee22f94-eb17-36d5-b38d-ab14157f1385'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '8ee22f94-eb17-36d5-b38d-ab14157f1385'
FROM pieces p
WHERE p.composer_id = 69 AND p.title = 'English Folk Song Suite' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '8ee22f94-eb17-36d5-b38d-ab14157f1385'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:5075a6a9-b009-47e4-a044-e9b27a252773', 1, 'I', 'March “Seventeen Come Sunday”', 'English Folk Song Suite: I. March “Seventeen Come Sunday”', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 69 AND p.title = 'English Folk Song Suite' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:5075a6a9-b009-47e4-a044-e9b27a252773'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:2604e4e0-dd67-4430-9b09-0240d77a26cc', 2, 'II', 'Intermezzo “My Bonny Boy”', 'English Folk Song Suite: II. Intermezzo “My Bonny Boy”', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 69 AND p.title = 'English Folk Song Suite' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:2604e4e0-dd67-4430-9b09-0240d77a26cc'
);


-- None Flourish for Glorious John

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, 'Flourish for Glorious John', 'Flourish for Glorious John', 'song', NULL, NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 69
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = 'Flourish for Glorious John'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '1c4ecb3c-0e83-4010-80de-149d7fbd5c11'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '1c4ecb3c-0e83-4010-80de-149d7fbd5c11'
FROM pieces p
WHERE p.composer_id = 69 AND p.title = 'Flourish for Glorious John' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '1c4ecb3c-0e83-4010-80de-149d7fbd5c11'
);


-- None Flourish on the "Morris Call"

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, 'Flourish on the "Morris Call"', 'Flourish on the "Morris Call"', 'song', NULL, NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 69
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = 'Flourish on the "Morris Call"'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '8c6702f7-3998-4619-8af2-af35b1025e25'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '8c6702f7-3998-4619-8af2-af35b1025e25'
FROM pieces p
WHERE p.composer_id = 69 AND p.title = 'Flourish on the "Morris Call"' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '8c6702f7-3998-4619-8af2-af35b1025e25'
);


-- None Folk Songs of the Four Seasons: Autumn

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, 'Folk Songs of the Four Seasons: Autumn', 'Folk Songs of the Four Seasons: Autumn', 'album', NULL, NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 69
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = 'Folk Songs of the Four Seasons: Autumn'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '7d389f1f-c4a2-4abb-9ed2-ef960458488e'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '7d389f1f-c4a2-4abb-9ed2-ef960458488e'
FROM pieces p
WHERE p.composer_id = 69 AND p.title = 'Folk Songs of the Four Seasons: Autumn' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '7d389f1f-c4a2-4abb-9ed2-ef960458488e'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:1dc44653-c8ca-4fb6-893e-76bc40160b70', 1, NULL, 'John Barleycorn', 'John Barleycorn', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 69 AND p.title = 'Folk Songs of the Four Seasons: Autumn' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:1dc44653-c8ca-4fb6-893e-76bc40160b70'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:a22a1b14-d9fb-4a14-b95c-0e25392fa960', 2, NULL, 'The Unquiet Grave', 'The Unquiet Grave', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 69 AND p.title = 'Folk Songs of the Four Seasons: Autumn' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:a22a1b14-d9fb-4a14-b95c-0e25392fa960'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:ae52624a-caae-4230-8b00-3e16b855d370', 3, NULL, 'An Acre of Land', 'An Acre of Land', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 69 AND p.title = 'Folk Songs of the Four Seasons: Autumn' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:ae52624a-caae-4230-8b00-3e16b855d370'
);


-- None Folk Songs of the Four Seasons: Summer

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, 'Folk Songs of the Four Seasons: Summer', 'Folk Songs of the Four Seasons: Summer', 'album', NULL, NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 69
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = 'Folk Songs of the Four Seasons: Summer'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '711c7907-6bcb-4e3c-a64d-8c34df1ebf23'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '711c7907-6bcb-4e3c-a64d-8c34df1ebf23'
FROM pieces p
WHERE p.composer_id = 69 AND p.title = 'Folk Songs of the Four Seasons: Summer' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '711c7907-6bcb-4e3c-a64d-8c34df1ebf23'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:5361727a-753a-4978-932d-8f91f75e1f82', 1, NULL, 'The Green Meadow', 'The Green Meadow', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 69 AND p.title = 'Folk Songs of the Four Seasons: Summer' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:5361727a-753a-4978-932d-8f91f75e1f82'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:756c49d9-20ab-4aff-b813-cbd05ca84fac', 2, NULL, 'Summer is a-coming in / The Cuckoo', 'Summer is a-coming in / The Cuckoo', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 69 AND p.title = 'Folk Songs of the Four Seasons: Summer' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:756c49d9-20ab-4aff-b813-cbd05ca84fac'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:f2424bcd-a945-4c1b-830b-cc3f71ce68e1', 3, NULL, 'The Sheep Shearing', 'The Sheep Shearing', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 69 AND p.title = 'Folk Songs of the Four Seasons: Summer' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:f2424bcd-a945-4c1b-830b-cc3f71ce68e1'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:fd4919a6-2042-4a41-b49b-7b4c9026db58', 4, NULL, 'The Sprig of Thyme', 'The Sprig of Thyme', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 69 AND p.title = 'Folk Songs of the Four Seasons: Summer' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:fd4919a6-2042-4a41-b49b-7b4c9026db58'
);


-- None Four Last Songs

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, 'Four Last Songs', 'Four Last Songs', 'album', NULL, NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 69
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = 'Four Last Songs'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '90fce7be-ebb5-4ede-b4de-831ed0bf967e'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '90fce7be-ebb5-4ede-b4de-831ed0bf967e'
FROM pieces p
WHERE p.composer_id = 69 AND p.title = 'Four Last Songs' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '90fce7be-ebb5-4ede-b4de-831ed0bf967e'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:54bd83f6-58f6-493e-966c-6dc9a489bc38', 1, NULL, 'Procris. Andante sostenuto', 'Four Last Songs: 1. Procris. Andante sostenuto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 69 AND p.title = 'Four Last Songs' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:54bd83f6-58f6-493e-966c-6dc9a489bc38'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:5a97d85b-1b6b-4229-ba54-6b55c7d9cfa1', 2, NULL, 'Tired. Andante sostenuto - Pochissimo animando - Tempo I', 'Four Last Songs: 2. Tired. Andante sostenuto - Pochissimo animando - Tempo I', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 69 AND p.title = 'Four Last Songs' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:5a97d85b-1b6b-4229-ba54-6b55c7d9cfa1'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:0179f4d1-55c5-46e0-ba4c-ddf8f315b863', 3, NULL, 'Hand, Eyes, and Heart. Andante tranquillo', 'Four Last Songs: 3. Hand, Eyes, and Heart. Andante tranquillo', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 69 AND p.title = 'Four Last Songs' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:0179f4d1-55c5-46e0-ba4c-ddf8f315b863'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:b9674b2d-c94c-42ea-b6ef-d008374ad88c', 4, NULL, 'Menelaus. Andante moderato', 'Four Last Songs: 4. Menelaus. Andante moderato', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 69 AND p.title = 'Four Last Songs' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:b9674b2d-c94c-42ea-b6ef-d008374ad88c'
);


-- None 가곡 <How Can the Tree but Wither?>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '가곡 <How Can the Tree but Wither?>', 'How Can the Tree but Wither?', 'song', NULL, NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 69
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '가곡 <How Can the Tree but Wither?>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'debf754d-67fa-467a-813d-4719f64272cb'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'debf754d-67fa-467a-813d-4719f64272cb'
FROM pieces p
WHERE p.composer_id = 69 AND p.title = '가곡 <How Can the Tree but Wither?>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'debf754d-67fa-467a-813d-4719f64272cb'
);


-- None Hymn-tune Prelude on Song 13 by Orlando Gibbons

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, 'Hymn-tune Prelude on Song 13 by Orlando Gibbons', 'Hymn-tune Prelude on Song 13 by Orlando Gibbons', 'song', NULL, NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 69
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = 'Hymn-tune Prelude on Song 13 by Orlando Gibbons'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '1addbc3c-d9c5-4ea6-b761-e6a44b5e2037'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '1addbc3c-d9c5-4ea6-b761-e6a44b5e2037'
FROM pieces p
WHERE p.composer_id = 69 AND p.title = 'Hymn-tune Prelude on Song 13 by Orlando Gibbons' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '1addbc3c-d9c5-4ea6-b761-e6a44b5e2037'
);


-- None 가곡 <Linden Lea>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '가곡 <Linden Lea>', 'Linden Lea', 'song', NULL, NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 69
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '가곡 <Linden Lea>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '4cad53d6-4218-3a00-876a-6b71bf846557'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '4cad53d6-4218-3a00-876a-6b71bf846557'
FROM pieces p
WHERE p.composer_id = 69 AND p.title = '가곡 <Linden Lea>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '4cad53d6-4218-3a00-876a-6b71bf846557'
);


-- None 가곡 <May Song>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '가곡 <May Song>', 'May Song', 'song', NULL, NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 69
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '가곡 <May Song>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '65269e79-89ea-41e7-bca2-ad986a7f4e5c'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '65269e79-89ea-41e7-bca2-ad986a7f4e5c'
FROM pieces p
WHERE p.composer_id = 69 AND p.title = '가곡 <May Song>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '65269e79-89ea-41e7-bca2-ad986a7f4e5c'
);


-- None 녹턴

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '녹턴', 'Nocturne', 'song', NULL, NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 69
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '녹턴'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '1b417e82-78ff-4c6e-8b4d-e9704c778b77'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '1b417e82-78ff-4c6e-8b4d-e9704c778b77'
FROM pieces p
WHERE p.composer_id = 69 AND p.title = '녹턴' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '1b417e82-78ff-4c6e-8b4d-e9704c778b77'
);


-- None O clap your hands

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, 'O clap your hands', 'O clap your hands', 'song', NULL, NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 69
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = 'O clap your hands'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'c3e70476-a7d1-428d-a666-3ff9506561ac'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'c3e70476-a7d1-428d-a666-3ff9506561ac'
FROM pieces p
WHERE p.composer_id = 69 AND p.title = 'O clap your hands' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'c3e70476-a7d1-428d-a666-3ff9506561ac'
);


-- None 연가곡집 <On Wenlock Edge>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '연가곡집 <On Wenlock Edge>', 'On Wenlock Edge', 'album', NULL, NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 69
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '연가곡집 <On Wenlock Edge>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'b8e292ba-3389-443a-bdec-c4bff8c74d16'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'b8e292ba-3389-443a-bdec-c4bff8c74d16'
FROM pieces p
WHERE p.composer_id = 69 AND p.title = '연가곡집 <On Wenlock Edge>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'b8e292ba-3389-443a-bdec-c4bff8c74d16'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:7492d82f-5259-363f-ae71-066e54e4f2c9', 1, 'I', 'On Wenlock Edge', 'On Wenlock Edge: I. On Wenlock Edge', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 69 AND p.title = '연가곡집 <On Wenlock Edge>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:7492d82f-5259-363f-ae71-066e54e4f2c9'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:53f0cb3a-7a2f-3b80-9a7b-f0bf864e4f7b', 2, 'II', 'From far, from eve and morning', 'On Wenlock Edge: II. From far, from eve and morning', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 69 AND p.title = '연가곡집 <On Wenlock Edge>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:53f0cb3a-7a2f-3b80-9a7b-f0bf864e4f7b'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:5be766c4-360d-3834-91e3-ccc7a04b7dc4', 3, 'III', 'Is my team ploughing', 'On Wenlock Edge: III. Is my team ploughing', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 69 AND p.title = '연가곡집 <On Wenlock Edge>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:5be766c4-360d-3834-91e3-ccc7a04b7dc4'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:697a8b4c-00c4-3dae-ba96-adef834686d2', 4, 'IV', 'Oh, when I was in love with you', 'On Wenlock Edge: IV. Oh, when I was in love with you', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 69 AND p.title = '연가곡집 <On Wenlock Edge>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:697a8b4c-00c4-3dae-ba96-adef834686d2'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:4f0fa35d-1298-3ee0-954c-1abf1cd1cc8a', 5, 'V', 'Bredon Hill', 'On Wenlock Edge: V. Bredon Hill', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 69 AND p.title = '연가곡집 <On Wenlock Edge>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:4f0fa35d-1298-3ee0-954c-1abf1cd1cc8a'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:9c8b69e7-1e4e-3eb3-803c-ae7bcadf8dab', 6, 'VI', 'Clun', 'On Wenlock Edge: VI. Clun', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 69 AND p.title = '연가곡집 <On Wenlock Edge>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:9c8b69e7-1e4e-3eb3-803c-ae7bcadf8dab'
);


-- None 피아노 협주곡 C장조

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '피아노 협주곡 C장조', 'Piano Concerto in C major', 'album', NULL, NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 69
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '피아노 협주곡 C장조'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'bf1748cd-0188-4fcf-8412-f8d9c7745c87'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'bf1748cd-0188-4fcf-8412-f8d9c7745c87'
FROM pieces p
WHERE p.composer_id = 69 AND p.title = '피아노 협주곡 C장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'bf1748cd-0188-4fcf-8412-f8d9c7745c87'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:938868a2-1894-45d4-9ec5-b36aefe3f07a', 1, 'I', 'Toccata', 'Piano Concerto in C major: I. Toccata', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 69 AND p.title = '피아노 협주곡 C장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:938868a2-1894-45d4-9ec5-b36aefe3f07a'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:5d9e9886-2415-4ab9-940e-338405d9eca5', 2, 'II', 'Romanza', 'Piano Concerto in C major: II. Romanza', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 69 AND p.title = '피아노 협주곡 C장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:5d9e9886-2415-4ab9-940e-338405d9eca5'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:4c2ef540-d899-4082-9503-73480eb878e3', 3, 'III', 'Fuga chromatica con Finale alla Tedesca', 'Piano Concerto in C major: III. Fuga chromatica con Finale alla Tedesca', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 69 AND p.title = '피아노 협주곡 C장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:4c2ef540-d899-4082-9503-73480eb878e3'
);


-- None 전주곡과 푸가 C단조

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '전주곡과 푸가 C단조', 'Prelude and Fugue in C minor', 'album', NULL, NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 69
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '전주곡과 푸가 C단조'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '176d235b-6d4f-478f-950f-6ecb5f369240'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '176d235b-6d4f-478f-950f-6ecb5f369240'
FROM pieces p
WHERE p.composer_id = 69 AND p.title = '전주곡과 푸가 C단조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '176d235b-6d4f-478f-950f-6ecb5f369240'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:72281fac-242d-4200-a74a-56fbc61c02b9', 1, 'I', 'Prelude', 'Prelude and Fugue in C minor: I. Prelude', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 69 AND p.title = '전주곡과 푸가 C단조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:72281fac-242d-4200-a74a-56fbc61c02b9'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:2f4794ff-3484-45d6-aa42-df4fc09bec37', 2, 'II', 'Fugue', 'Prelude and Fugue in C minor: II. Fugue', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 69 AND p.title = '전주곡과 푸가 C단조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:2f4794ff-3484-45d6-aa42-df4fc09bec37'
);


-- None Romance for Harmonica

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, 'Romance for Harmonica', 'Romance for Harmonica', 'song', NULL, NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 69
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = 'Romance for Harmonica'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '10c6c615-5740-39f8-8a99-5fcca6e012d8'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '10c6c615-5740-39f8-8a99-5fcca6e012d8'
FROM pieces p
WHERE p.composer_id = 69 AND p.title = 'Romance for Harmonica' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '10c6c615-5740-39f8-8a99-5fcca6e012d8'
);


-- None Sea Songs

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, 'Sea Songs', 'Sea Songs', 'song', NULL, NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 69
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = 'Sea Songs'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'b54c5f32-98cf-41ec-8497-f3388941ab63'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'b54c5f32-98cf-41ec-8497-f3388941ab63'
FROM pieces p
WHERE p.composer_id = 69 AND p.title = 'Sea Songs' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'b54c5f32-98cf-41ec-8497-f3388941ab63'
);


-- None Serenade to Music

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, 'Serenade to Music', 'Serenade to Music', 'album', NULL, NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 69
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = 'Serenade to Music'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '30a50d73-cb60-39ab-806a-98c8a800cf10'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '30a50d73-cb60-39ab-806a-98c8a800cf10'
FROM pieces p
WHERE p.composer_id = 69 AND p.title = 'Serenade to Music' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '30a50d73-cb60-39ab-806a-98c8a800cf10'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:db10602d-4e49-3b87-acb1-8c6071c64214', 1, NULL, 'Andantino', 'Serenade to Music: Andantino', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 69 AND p.title = 'Serenade to Music' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:db10602d-4e49-3b87-acb1-8c6071c64214'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:80be5498-679e-369f-bafa-781069c8e502', 2, NULL, '“How Sweet the Moonlight”', 'Serenade to Music: “How Sweet the Moonlight”', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 69 AND p.title = 'Serenade to Music' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:80be5498-679e-369f-bafa-781069c8e502'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:93f1bede-670a-3390-a810-15a7b66c38e1', 3, NULL, '“Look How the Floor of Heaven…”', 'Serenade to Music: “Look How the Floor of Heaven…”', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 69 AND p.title = 'Serenade to Music' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:93f1bede-670a-3390-a810-15a7b66c38e1'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:603087e7-effa-3449-8b36-540c7ed48bdb', 4, NULL, '“Come, Ho! and Wake Diana With a Hymn”', 'Serenade to Music: “Come, Ho! and Wake Diana With a Hymn”', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 69 AND p.title = 'Serenade to Music' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:603087e7-effa-3449-8b36-540c7ed48bdb'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:484d47f0-eb38-3a42-9c06-b6033b7bf5f2', 5, NULL, '“I Am Never Merry When I Hear Sweet Music”', 'Serenade to Music: “I Am Never Merry When I Hear Sweet Music”', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 69 AND p.title = 'Serenade to Music' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:484d47f0-eb38-3a42-9c06-b6033b7bf5f2'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:7a47d040-fe36-3ec5-9160-f7fb89062a82', 6, NULL, '“Music! Hark!”', 'Serenade to Music: “Music! Hark!”', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 69 AND p.title = 'Serenade to Music' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:7a47d040-fe36-3ec5-9160-f7fb89062a82'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:3b58911c-05d8-3fb2-8c1b-98d3f61f702c', 7, NULL, '“How Many Things by Season…”', 'Serenade to Music: “How Many Things by Season…”', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 69 AND p.title = 'Serenade to Music' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:3b58911c-05d8-3fb2-8c1b-98d3f61f702c'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:6264621c-c2e9-3eea-8cd3-9bbf9eaeafc6', 8, NULL, '“Soft Stillness and the night”', 'Serenade to Music: “Soft Stillness and the night”', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 69 AND p.title = 'Serenade to Music' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:6264621c-c2e9-3eea-8cd3-9bbf9eaeafc6'
);


-- None Six Studies in English Folk-song

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, 'Six Studies in English Folk-song', 'Six Studies in English Folk-song', 'album', NULL, NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 69
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = 'Six Studies in English Folk-song'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '44e2866c-cadc-477c-a6b0-8fb409e842b1'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '44e2866c-cadc-477c-a6b0-8fb409e842b1'
FROM pieces p
WHERE p.composer_id = 69 AND p.title = 'Six Studies in English Folk-song' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '44e2866c-cadc-477c-a6b0-8fb409e842b1'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:2ca15f30-594d-4967-a315-a27bc7964ffa', 1, 'I', 'Lovely on the Water. Adagio', 'Six Studies in English Folk-song: I. Lovely on the Water. Adagio', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 69 AND p.title = 'Six Studies in English Folk-song' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:2ca15f30-594d-4967-a315-a27bc7964ffa'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:cf60fd51-d12d-4c86-8a28-8d3bcc6c664b', 2, 'II', 'Spurn Point. Andante sostenuto', 'Six Studies in English Folk-song: II. Spurn Point. Andante sostenuto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 69 AND p.title = 'Six Studies in English Folk-song' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:cf60fd51-d12d-4c86-8a28-8d3bcc6c664b'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:b049c3ec-39fb-44d3-928d-b2f0b9ba7e23', 3, 'III', 'Van Dieman''s Land. Larghetto', 'Six Studies in English Folk-song: III. Van Dieman''s Land. Larghetto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 69 AND p.title = 'Six Studies in English Folk-song' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:b049c3ec-39fb-44d3-928d-b2f0b9ba7e23'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:8ce62a67-754e-4424-bf15-0ae80fc1c799', 4, 'IV', 'She borrowed some of her mother''s gold. Lento', 'Six Studies in English Folk-song: IV. She borrowed some of her mother''s gold. Lento', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 69 AND p.title = 'Six Studies in English Folk-song' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:8ce62a67-754e-4424-bf15-0ae80fc1c799'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:47d32e57-6fc5-4ffe-a05a-eef079d06477', 5, 'V', 'The Lady and the Dragon. Andante tranquillo', 'Six Studies in English Folk-song: V. The Lady and the Dragon. Andante tranquillo', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 69 AND p.title = 'Six Studies in English Folk-song' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:47d32e57-6fc5-4ffe-a05a-eef079d06477'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:2a599ef6-a9de-4804-af42-3e3798649d42', 6, 'VI', 'As I walked over London Bridge. Allegro vivace', 'Six Studies in English Folk-song: VI. As I walked over London Bridge. Allegro vivace', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 69 AND p.title = 'Six Studies in English Folk-song' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:2a599ef6-a9de-4804-af42-3e3798649d42'
);


-- None 연가곡집 <Songs of Travel>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '연가곡집 <Songs of Travel>', 'Songs of Travel', 'song', NULL, NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 69
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '연가곡집 <Songs of Travel>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '2e6c7e9b-46c4-4a40-998c-13d98bc543ef'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '2e6c7e9b-46c4-4a40-998c-13d98bc543ef'
FROM pieces p
WHERE p.composer_id = 69 AND p.title = '연가곡집 <Songs of Travel>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '2e6c7e9b-46c4-4a40-998c-13d98bc543ef'
);


-- None 가곡 <Sound Sleep>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '가곡 <Sound Sleep>', 'Sound Sleep', 'song', NULL, NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 69
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '가곡 <Sound Sleep>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '1800cc0b-34d8-4445-9516-7b515ee9d217'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '1800cc0b-34d8-4445-9516-7b515ee9d217'
FROM pieces p
WHERE p.composer_id = 69 AND p.title = '가곡 <Sound Sleep>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '1800cc0b-34d8-4445-9516-7b515ee9d217'
);


-- None Ten Blake Songs

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, 'Ten Blake Songs', 'Ten Blake Songs', 'album', NULL, NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 69
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = 'Ten Blake Songs'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '7d97a9bc-259d-42cf-9e52-5536a644a51d'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '7d97a9bc-259d-42cf-9e52-5536a644a51d'
FROM pieces p
WHERE p.composer_id = 69 AND p.title = 'Ten Blake Songs' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '7d97a9bc-259d-42cf-9e52-5536a644a51d'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:72839e3b-8a79-48e3-bfd8-0ef05ed96c16', 1, 'I', 'Infant Joy', 'Ten Blake Songs: I. Infant Joy', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 69 AND p.title = 'Ten Blake Songs' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:72839e3b-8a79-48e3-bfd8-0ef05ed96c16'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:a54ddff8-d67e-4f4d-a49a-58efe513790e', 2, 'II', 'A Poison Tree', 'Ten Blake Songs: II. A Poison Tree', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 69 AND p.title = 'Ten Blake Songs' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:a54ddff8-d67e-4f4d-a49a-58efe513790e'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:99a90701-8761-43bf-bb99-086e2fdbdfab', 3, 'III', 'The Piper', 'Ten Blake Songs: III. The Piper', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 69 AND p.title = 'Ten Blake Songs' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:99a90701-8761-43bf-bb99-086e2fdbdfab'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:3993e33d-1b10-41e6-b794-9b08c01d1d6c', 4, 'IV', 'London', 'Ten Blake Songs: IV. London', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 69 AND p.title = 'Ten Blake Songs' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:3993e33d-1b10-41e6-b794-9b08c01d1d6c'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:0a6fc5d6-b627-4ee4-bef9-a07782b2328f', 5, 'V', 'The Lamb', 'Ten Blake Songs: V. The Lamb', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 69 AND p.title = 'Ten Blake Songs' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:0a6fc5d6-b627-4ee4-bef9-a07782b2328f'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:6abc129a-3838-401c-9c8d-f51d06437a72', 6, 'VI', 'The Shepherd', 'Ten Blake Songs: VI. The Shepherd', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 69 AND p.title = 'Ten Blake Songs' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:6abc129a-3838-401c-9c8d-f51d06437a72'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:13d9f3b6-f045-46c3-876c-16134b8e5c26', 7, 'VII', 'Ah, Sun-flower', 'Ten Blake Songs: VII. Ah, Sun-flower', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 69 AND p.title = 'Ten Blake Songs' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:13d9f3b6-f045-46c3-876c-16134b8e5c26'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:22e8b3e7-b581-4c18-8ca8-768968f8ab7d', 8, 'VIII', 'Cruelty has a human heart', 'Ten Blake Songs: VIII. Cruelty has a human heart', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 69 AND p.title = 'Ten Blake Songs' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:22e8b3e7-b581-4c18-8ca8-768968f8ab7d'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:2f26700f-5d68-4ee1-b1b8-578378197eec', 9, 'IX', 'The Divine Image', 'Ten Blake Songs: IX. The Divine Image', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 69 AND p.title = 'Ten Blake Songs' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:2f26700f-5d68-4ee1-b1b8-578378197eec'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:91305aad-0fcd-4575-a7b7-6be6993d0fd4', 10, 'X', 'Eternity', 'Ten Blake Songs: X. Eternity', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 69 AND p.title = 'Ten Blake Songs' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:91305aad-0fcd-4575-a7b7-6be6993d0fd4'
);


-- None 영화음악 <The England of Elizabeth>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '영화음악 <The England of Elizabeth>', 'The England of Elizabeth', 'song', NULL, NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 69
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '영화음악 <The England of Elizabeth>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '911d200a-24d9-420d-bf64-2cb2fe0c5404'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '911d200a-24d9-420d-bf64-2cb2fe0c5404'
FROM pieces p
WHERE p.composer_id = 69 AND p.title = '영화음악 <The England of Elizabeth>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '911d200a-24d9-420d-bf64-2cb2fe0c5404'
);


-- None The Running Set

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, 'The Running Set', 'The Running Set', 'song', NULL, NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 69
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = 'The Running Set'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '6f66163b-232c-4f16-b7f2-0d361ab59b31'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '6f66163b-232c-4f16-b7f2-0d361ab59b31'
FROM pieces p
WHERE p.composer_id = 69 AND p.title = 'The Running Set' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '6f66163b-232c-4f16-b7f2-0d361ab59b31'
);


-- 카탈로그에 대응이 없는 seed 작품 42개를 목록에서 숨긴다(지우지 않음).
UPDATE pieces piece
SET piece.hidden_reason = 'catalog_unmatched'
WHERE piece.composer_id = 69 AND piece.origin = 'seed' AND piece.hidden_reason IS NULL
  AND piece.id IN (
    471, 2350, 7584, 7660, 7661, 7669, 7741, 7842, 7900, 7990, 8181, 8190, 8220, 8463, 8476, 8497, 8513, 8601, 8611, 8667,
    8696, 9085, 9333, 9453, 9482, 9528, 9548, 9677, 9691, 9749, 9780, 10069, 10123, 10173, 10250, 10657, 10668, 10760, 10824, 10898,
    11082, 11257
  )
  AND NOT EXISTS (SELECT 1 FROM performance_sectors sector WHERE sector.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM piece_parts linking WHERE linking.linked_piece_id = piece.id);
