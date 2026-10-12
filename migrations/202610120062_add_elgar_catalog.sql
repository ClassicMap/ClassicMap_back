-- 엘가 작품을 MusicBrainz 작품 구조로 다시 짠다(4차 자동). 작품 158개(묶음 31, 다악장 24, 낱곡 103),
-- 새 작품 28개, part 296개, 그 아래 8개.
-- seed 181개 중 129개를 작품·part 에 잇고, 40개를 숨기고, 12개는 그대로 둔다.
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

-- Op. 73 2개의 합창곡 Op. 73

UPDATE pieces piece
SET piece.title = '2개의 합창곡 Op. 73', piece.title_en = '2 Choral Songs, op. 73',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = 'Op.', piece.catalogue_number = '73',
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 2814 AND piece.composer_id = 64
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'Love''s Tempest, op. 73 no. 1', part.name_en = 'Love''s Tempest, op. 73 no. 1',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 2814 AND p.composer_id = 64 AND part.part_key = 'musicbrainz:5dfa9aa2-153d-4ba1-8585-6f63532f3fb9' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:5dfa9aa2-153d-4ba1-8585-6f63532f3fb9', 1, NULL, 'Love''s Tempest, op. 73 no. 1', 'Love''s Tempest, op. 73 no. 1', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 2814 AND p.composer_id = 64
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:5dfa9aa2-153d-4ba1-8585-6f63532f3fb9'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'Serenade, op. 73 no. 2', part.name_en = 'Serenade, op. 73 no. 2',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 2814 AND p.composer_id = 64 AND part.part_key = 'musicbrainz:256f7dd2-ea79-4f2a-98c6-36ac6d16af4d' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:256f7dd2-ea79-4f2a-98c6-36ac6d16af4d', 2, NULL, 'Serenade, op. 73 no. 2', 'Serenade, op. 73 no. 2', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 2814 AND p.composer_id = 64
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:256f7dd2-ea79-4f2a-98c6-36ac6d16af4d'
);


-- Op. 26 2개의 합창곡 Op. 26

UPDATE pieces piece
SET piece.title = '2개의 합창곡 Op. 26', piece.title_en = '2 Partsongs, op. 26',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = 'Op.', piece.catalogue_number = '26',
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 2285 AND piece.composer_id = 64
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'The Snow, op. 26 no. 1', part.name_en = 'The Snow, op. 26 no. 1',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 2285 AND p.composer_id = 64 AND part.part_key = 'musicbrainz:16ba780b-750b-4ce7-91dd-c881a57a9815' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:16ba780b-750b-4ce7-91dd-c881a57a9815', 1, NULL, 'The Snow, op. 26 no. 1', 'The Snow, op. 26 no. 1', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 2285 AND p.composer_id = 64
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:16ba780b-750b-4ce7-91dd-c881a57a9815'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'Fly, Singing Bird, Fly, op. 26 no. 2', part.name_en = 'Fly, Singing Bird, Fly, op. 26 no. 2',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 2285 AND p.composer_id = 64 AND part.part_key = 'musicbrainz:0940075d-6733-4448-a010-36cc245457dd' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:0940075d-6733-4448-a010-36cc245457dd', 2, NULL, 'Fly, Singing Bird, Fly, op. 26 no. 2', 'Fly, Singing Bird, Fly, op. 26 no. 2', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 2285 AND p.composer_id = 64
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:0940075d-6733-4448-a010-36cc245457dd'
);


-- Op. 60 2개의 가곡 Op. 60

UPDATE pieces piece
SET piece.title = '2개의 가곡 Op. 60', piece.title_en = '2 Songs, op. 60',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = 'Op.', piece.catalogue_number = '60',
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 2685 AND piece.composer_id = 64
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'The Torch, op. 60 no. 1', part.name_en = 'The Torch, op. 60 no. 1',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 2685 AND p.composer_id = 64 AND part.part_key = 'musicbrainz:76c8af98-bc67-4c75-a361-52149409c460' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:76c8af98-bc67-4c75-a361-52149409c460', 1, NULL, 'The Torch, op. 60 no. 1', 'The Torch, op. 60 no. 1', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 2685 AND p.composer_id = 64
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:76c8af98-bc67-4c75-a361-52149409c460'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'The River, op. 60 no. 2', part.name_en = 'The River, op. 60 no. 2',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 2685 AND p.composer_id = 64 AND part.part_key = 'musicbrainz:3b0c4af8-b906-4e95-90d6-4254e55b20e5' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:3b0c4af8-b906-4e95-90d6-4254e55b20e5', 2, NULL, 'The River, op. 60 no. 2', 'The River, op. 60 no. 2', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 2685 AND p.composer_id = 64
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:3b0c4af8-b906-4e95-90d6-4254e55b20e5'
);


-- Op. 13 2개의 소품 Op. 13

UPDATE pieces piece
SET piece.title = '2개의 소품 Op. 13', piece.title_en = '2 pieces, op. 13',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = 'Op.', piece.catalogue_number = '13',
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 2299 AND piece.composer_id = 64
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'Mot d''amour, op. 13 no. 1', part.name_en = 'Mot d''amour, op. 13 no. 1',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 2299 AND p.composer_id = 64 AND part.part_key = 'musicbrainz:2f801c98-625a-4c68-b987-1479c9348325' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:2f801c98-625a-4c68-b987-1479c9348325', 1, NULL, 'Mot d''amour, op. 13 no. 1', 'Mot d''amour, op. 13 no. 1', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 2299 AND p.composer_id = 64
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:2f801c98-625a-4c68-b987-1479c9348325'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'Bizarrerie, op. 13 no. 2', part.name_en = 'Bizarrerie, op. 13 no. 2',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 2299 AND p.composer_id = 64 AND part.part_key = 'musicbrainz:939a31df-0b87-4a78-9035-043dc16aacee' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:939a31df-0b87-4a78-9035-043dc16aacee', 2, NULL, 'Bizarrerie, op. 13 no. 2', 'Bizarrerie, op. 13 no. 2', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 2299 AND p.composer_id = 64
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:939a31df-0b87-4a78-9035-043dc16aacee'
);


-- Op. 2 3개의 모테트 Op. 2

UPDATE pieces piece
SET piece.title = '3개의 모테트 Op. 2', piece.title_en = '3 Motets, op. 2',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = 'Op.', piece.catalogue_number = '2',
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 1204 AND piece.composer_id = 64
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'Ave verum corpus, op. 2, no. 1', part.name_en = 'Ave verum corpus, op. 2, no. 1',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 1204 AND p.composer_id = 64 AND part.part_key = 'musicbrainz:c2cf75a6-7d5f-4de5-82e0-ebda850e8144' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:c2cf75a6-7d5f-4de5-82e0-ebda850e8144', 1, NULL, 'Ave verum corpus, op. 2, no. 1', 'Ave verum corpus, op. 2, no. 1', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 1204 AND p.composer_id = 64
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:c2cf75a6-7d5f-4de5-82e0-ebda850e8144'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'Ave Maria, op. 2 no. 2', part.name_en = 'Ave Maria, op. 2 no. 2',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 1204 AND p.composer_id = 64 AND part.part_key = 'musicbrainz:f9e5c5f8-511a-4235-b771-c4a576451e08' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:f9e5c5f8-511a-4235-b771-c4a576451e08', 2, NULL, 'Ave Maria, op. 2 no. 2', 'Ave Maria, op. 2 no. 2', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 1204 AND p.composer_id = 64
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:f9e5c5f8-511a-4235-b771-c4a576451e08'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = NULL,
    part.name_ko = 'Ave maris stella, op. 2 no. 3', part.name_en = 'Ave maris stella, op. 2 no. 3',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 1204 AND p.composer_id = 64 AND part.part_key = 'musicbrainz:aff9f2ed-cee4-495f-bb7a-65b20ef9e977' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:aff9f2ed-cee4-495f-bb7a-65b20ef9e977', 3, NULL, 'Ave maris stella, op. 2 no. 3', 'Ave maris stella, op. 2 no. 3', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 1204 AND p.composer_id = 64
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:aff9f2ed-cee4-495f-bb7a-65b20ef9e977'
);


-- Op. 4 3개의 바이올린과 피아노를 위한 소품 Op. 4

UPDATE pieces piece
SET piece.title = '3개의 바이올린과 피아노를 위한 소품 Op. 4', piece.title_en = '3 Pieces for Violin and Piano, op. 4',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = 'Op.', piece.catalogue_number = '4',
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 2644 AND piece.composer_id = 64
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'Idylle, op. 4 no. 1', part.name_en = 'Idylle, op. 4 no. 1',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 2644 AND p.composer_id = 64 AND part.part_key = 'musicbrainz:bb59d9fb-f4e9-4714-aa8e-064fc347eaab' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:bb59d9fb-f4e9-4714-aa8e-064fc347eaab', 1, NULL, 'Idylle, op. 4 no. 1', 'Idylle, op. 4 no. 1', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 2644 AND p.composer_id = 64
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:bb59d9fb-f4e9-4714-aa8e-064fc347eaab'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'Pastourelle, op. 4 no. 2', part.name_en = 'Pastourelle, op. 4 no. 2',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 2644 AND p.composer_id = 64 AND part.part_key = 'musicbrainz:26df3e01-206c-42a8-b0d1-8028b1273fbd' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:26df3e01-206c-42a8-b0d1-8028b1273fbd', 2, NULL, 'Pastourelle, op. 4 no. 2', 'Pastourelle, op. 4 no. 2', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 2644 AND p.composer_id = 64
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:26df3e01-206c-42a8-b0d1-8028b1273fbd'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = NULL,
    part.name_ko = 'Virelai, op. 4 no. 3', part.name_en = 'Virelai, op. 4 no. 3',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 2644 AND p.composer_id = 64 AND part.part_key = 'musicbrainz:62b9cec4-d16f-4bc4-8693-cedad91f6ec8' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:62b9cec4-d16f-4bc4-8693-cedad91f6ec8', 3, NULL, 'Virelai, op. 4 no. 3', 'Virelai, op. 4 no. 3', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 2644 AND p.composer_id = 64
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:62b9cec4-d16f-4bc4-8693-cedad91f6ec8'
);


-- Op. 16 3개의 가곡 Op. 16

UPDATE pieces piece
SET piece.title = '3개의 가곡 Op. 16', piece.title_en = '3 Songs, op. 16',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = 'Op.', piece.catalogue_number = '16',
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 2688 AND piece.composer_id = 64
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'Shepherd''s Song, op. 16 no. 1', part.name_en = 'Shepherd''s Song, op. 16 no. 1',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 2688 AND p.composer_id = 64 AND part.part_key = 'musicbrainz:48e39d1c-c5b0-4dbf-bdcf-75a2433f0137' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:48e39d1c-c5b0-4dbf-bdcf-75a2433f0137', 1, NULL, 'Shepherd''s Song, op. 16 no. 1', 'Shepherd''s Song, op. 16 no. 1', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 2688 AND p.composer_id = 64
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:48e39d1c-c5b0-4dbf-bdcf-75a2433f0137'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'Through the Long Days, op. 16 no. 2', part.name_en = 'Through the Long Days, op. 16 no. 2',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 2688 AND p.composer_id = 64 AND part.part_key = 'musicbrainz:50ca5474-be06-4350-a9e4-8446109b1b74' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:50ca5474-be06-4350-a9e4-8446109b1b74', 2, NULL, 'Through the Long Days, op. 16 no. 2', 'Through the Long Days, op. 16 no. 2', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 2688 AND p.composer_id = 64
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:50ca5474-be06-4350-a9e4-8446109b1b74'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = NULL,
    part.name_ko = 'Rondel, op. 16 no. 3', part.name_en = 'Rondel, op. 16 no. 3',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 2688 AND p.composer_id = 64 AND part.part_key = 'musicbrainz:c6badeef-413f-4703-8f93-e331420dc8e6' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:c6badeef-413f-4703-8f93-e331420dc8e6', 3, NULL, 'Rondel, op. 16 no. 3', 'Rondel, op. 16 no. 3', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 2688 AND p.composer_id = 64
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:c6badeef-413f-4703-8f93-e331420dc8e6'
);


-- None A Child asleep

UPDATE pieces piece
SET piece.title = 'A Child asleep', piece.title_en = 'A Child asleep',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 1049 AND piece.composer_id = 64
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- Op. 52 A Christmas Greeting

UPDATE pieces piece
SET piece.title = 'A Christmas Greeting', piece.title_en = 'A Christmas Greeting, op. 52',
    piece.type = 'song', piece.opus_number = 'Op. 52',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 791 AND piece.composer_id = 64
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None 가곡 <A Song of Autumn>

UPDATE pieces piece
SET piece.title = '가곡 <A Song of Autumn>', piece.title_en = 'A Song of Autumn',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 1412 AND piece.composer_id = 64
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- Op. 5 No. 1 A War Song

UPDATE pieces piece
SET piece.title = 'A War Song', piece.title_en = 'A War Song, op. 5 no. 1',
    piece.type = 'song', piece.opus_number = 'Op. 5 No. 1',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 1180 AND piece.composer_id = 64
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- Op. 31 No. 1 가곡 <After>

UPDATE pieces piece
SET piece.title = '가곡 <After>', piece.title_en = 'After, op. 31 no. 1',
    piece.type = 'song', piece.opus_number = 'Op. 31 No. 1',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 1861 AND piece.composer_id = 64
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- Op. 46 Allegro (Concert Solo) For Piano

UPDATE pieces piece
SET piece.title = 'Allegro (Concert Solo) For Piano', piece.title_en = 'Allegro (Concert Solo) For Piano, op. 46',
    piece.type = 'song', piece.opus_number = 'Op. 46',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 736 AND piece.composer_id = 64
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Always and Everywhere

UPDATE pieces piece
SET piece.title = 'Always and Everywhere', piece.title_en = 'Always and Everywhere',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 2002 AND piece.composer_id = 64
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Angelus

UPDATE pieces piece
SET piece.title = 'Angelus', piece.title_en = 'Angelus',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 2782 AND piece.composer_id = 64
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None 가곡 <Arabian Serenade>

UPDATE pieces piece
SET piece.title = '가곡 <Arabian Serenade>', piece.title_en = 'Arabian Serenade',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 1676 AND piece.composer_id = 64
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None As I laye a-thynkynge

UPDATE pieces piece
SET piece.title = 'As I laye a-thynkynge', piece.title_en = 'As I laye a-thynkynge',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 1981 AND piece.composer_id = 64
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Beau Brummel

UPDATE pieces piece
SET piece.title = 'Beau Brummel', piece.title_en = 'Beau Brummel',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 2590 AND piece.composer_id = 64
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'Minuet', part.name_en = 'Beau Brummel: Minuet',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 2590 AND p.composer_id = 64 AND part.part_key = 'musicbrainz:9f54f4f5-1bef-47c8-bd6e-ab1f655f1352' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:9f54f4f5-1bef-47c8-bd6e-ab1f655f1352', 1, NULL, 'Minuet', 'Beau Brummel: Minuet', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 2590 AND p.composer_id = 64
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:9f54f4f5-1bef-47c8-bd6e-ab1f655f1352'
);


-- None Big Steamers

UPDATE pieces piece
SET piece.title = 'Big Steamers', piece.title_en = 'Big Steamers',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 2535 AND piece.composer_id = 64
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- Op. 3 No. 1 Cantique

UPDATE pieces piece
SET piece.title = 'Cantique', piece.title_en = 'Cantique, op. 3 no. 1',
    piece.type = 'song', piece.opus_number = 'Op. 3 No. 1',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 1683 AND piece.composer_id = 64
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- Op. 35 칸타타 <Caractacus> Op. 35

UPDATE pieces piece
SET piece.title = '칸타타 <Caractacus> Op. 35', piece.title_en = 'Caractacus, op. 35',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = 'Op.', piece.catalogue_number = '35',
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 1431 AND piece.composer_id = 64
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'Scene I, British Camp on the Malvern Hills: “Watchmen, Alert!” (Chorus)', part.name_en = 'Caractacus, op. 35: Scene I, British Camp on the Malvern Hills: “Watchmen, Alert!” (Chorus)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 1431 AND p.composer_id = 64 AND part.part_key = 'musicbrainz:9d3242ff-6176-4557-b162-cfbb6de7bfb0' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:9d3242ff-6176-4557-b162-cfbb6de7bfb0', 1, NULL, 'Scene I, British Camp on the Malvern Hills: “Watchmen, Alert!” (Chorus)', 'Caractacus, op. 35: Scene I, British Camp on the Malvern Hills: “Watchmen, Alert!” (Chorus)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 1431 AND p.composer_id = 64
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:9d3242ff-6176-4557-b162-cfbb6de7bfb0'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'Scene I, British Camp on the Malvern Hills: “Watchmen, Alert! The King is Here” (Caractacus)', part.name_en = 'Caractacus, op. 35: Scene I, British Camp on the Malvern Hills: “Watchmen, Alert! The King is Here” (Caractacus)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 1431 AND p.composer_id = 64 AND part.part_key = 'musicbrainz:0cae0abe-83a1-4008-a898-821cd3d25ac6' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:0cae0abe-83a1-4008-a898-821cd3d25ac6', 2, NULL, 'Scene I, British Camp on the Malvern Hills: “Watchmen, Alert! The King is Here” (Caractacus)', 'Caractacus, op. 35: Scene I, British Camp on the Malvern Hills: “Watchmen, Alert! The King is Here” (Caractacus)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 1431 AND p.composer_id = 64
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:0cae0abe-83a1-4008-a898-821cd3d25ac6'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = NULL,
    part.name_ko = 'Scene I, British Camp on the Malvern Hills: “Father! Sire and King” (Eigen, Caractacus, Orbin)', part.name_en = 'Caractacus, op. 35: Scene I, British Camp on the Malvern Hills: “Father! Sire and King” (Eigen, Caractacus, Orbin)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 1431 AND p.composer_id = 64 AND part.part_key = 'musicbrainz:f3bb8db5-6c7d-4afe-994e-6263d2837007' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:f3bb8db5-6c7d-4afe-994e-6263d2837007', 3, NULL, 'Scene I, British Camp on the Malvern Hills: “Father! Sire and King” (Eigen, Caractacus, Orbin)', 'Caractacus, op. 35: Scene I, British Camp on the Malvern Hills: “Father! Sire and King” (Eigen, Caractacus, Orbin)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 1431 AND p.composer_id = 64
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:f3bb8db5-6c7d-4afe-994e-6263d2837007'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = NULL,
    part.name_ko = 'Scene I, British Camp on the Malvern Hills: “At Eve to the Greenwood” (Eigen)', part.name_en = 'Caractacus, op. 35: Scene I, British Camp on the Malvern Hills: “At Eve to the Greenwood” (Eigen)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 1431 AND p.composer_id = 64 AND part.part_key = 'musicbrainz:f5370294-e2cc-4b71-90cf-5744863fe24f' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:f5370294-e2cc-4b71-90cf-5744863fe24f', 4, NULL, 'Scene I, British Camp on the Malvern Hills: “At Eve to the Greenwood” (Eigen)', 'Caractacus, op. 35: Scene I, British Camp on the Malvern Hills: “At Eve to the Greenwood” (Eigen)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 1431 AND p.composer_id = 64
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:f5370294-e2cc-4b71-90cf-5744863fe24f'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 5, part.movement_number = NULL,
    part.name_ko = 'Scene I, British Camp on the Malvern Hills: “On the Ocean and the River” (Eigen, Orbin, Caractacus)', part.name_en = 'Caractacus, op. 35: Scene I, British Camp on the Malvern Hills: “On the Ocean and the River” (Eigen, Orbin, Caractacus)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 1431 AND p.composer_id = 64 AND part.part_key = 'musicbrainz:9ce7b814-07ac-48b3-b0f5-e59dc91e9521' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:9ce7b814-07ac-48b3-b0f5-e59dc91e9521', 5, NULL, 'Scene I, British Camp on the Malvern Hills: “On the Ocean and the River” (Eigen, Orbin, Caractacus)', 'Caractacus, op. 35: Scene I, British Camp on the Malvern Hills: “On the Ocean and the River” (Eigen, Orbin, Caractacus)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 1431 AND p.composer_id = 64
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:9ce7b814-07ac-48b3-b0f5-e59dc91e9521'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 6, part.movement_number = NULL,
    part.name_ko = 'Scene I, British Camp on the Malvern Hills: “Rest, Weary Monarch” (Chorus)', part.name_en = 'Caractacus, op. 35: Scene I, British Camp on the Malvern Hills: “Rest, Weary Monarch” (Chorus)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 1431 AND p.composer_id = 64 AND part.part_key = 'musicbrainz:b155ce4e-da08-404e-9751-676a6854fcec' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:b155ce4e-da08-404e-9751-676a6854fcec', 6, NULL, 'Scene I, British Camp on the Malvern Hills: “Rest, Weary Monarch” (Chorus)', 'Caractacus, op. 35: Scene I, British Camp on the Malvern Hills: “Rest, Weary Monarch” (Chorus)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 1431 AND p.composer_id = 64
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:b155ce4e-da08-404e-9751-676a6854fcec'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 7, part.movement_number = NULL,
    part.name_ko = 'Scene II, The Sacred Oak Grove by the Tomb of the Kings: Tread the Mystic Circle Round (Arch‐Druid, Chorus)', part.name_en = 'Caractacus, op. 35: Scene II, The Sacred Oak Grove by the Tomb of the Kings: Tread the Mystic Circle Round (Arch‐Druid, Chorus)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 1431 AND p.composer_id = 64 AND part.part_key = 'musicbrainz:a03312c5-8266-4c80-91b2-f2a6c3f6bb0e' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:a03312c5-8266-4c80-91b2-f2a6c3f6bb0e', 7, NULL, 'Scene II, The Sacred Oak Grove by the Tomb of the Kings: Tread the Mystic Circle Round (Arch‐Druid, Chorus)', 'Caractacus, op. 35: Scene II, The Sacred Oak Grove by the Tomb of the Kings: Tread the Mystic Circle Round (Arch‐Druid, Chorus)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 1431 AND p.composer_id = 64
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:a03312c5-8266-4c80-91b2-f2a6c3f6bb0e'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 8, part.movement_number = NULL,
    part.name_ko = 'Scene II, The Sacred Oak Grove by the Tomb of the Kings: Lord of Dread, and Lord of Pow’r (Chorus)', part.name_en = 'Caractacus, op. 35: Scene II, The Sacred Oak Grove by the Tomb of the Kings: Lord of Dread, and Lord of Pow’r (Chorus)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 1431 AND p.composer_id = 64 AND part.part_key = 'musicbrainz:3dcf6c1a-86af-48c4-bbe7-35382dc83afc' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:3dcf6c1a-86af-48c4-bbe7-35382dc83afc', 8, NULL, 'Scene II, The Sacred Oak Grove by the Tomb of the Kings: Lord of Dread, and Lord of Pow’r (Chorus)', 'Caractacus, op. 35: Scene II, The Sacred Oak Grove by the Tomb of the Kings: Lord of Dread, and Lord of Pow’r (Chorus)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 1431 AND p.composer_id = 64
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:3dcf6c1a-86af-48c4-bbe7-35382dc83afc'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 9, part.movement_number = NULL,
    part.name_ko = 'Scene II, The Sacred Oak Grove by the Tomb of the Kings: “Bard, What Read Ye?” (Arch‐Druid, Orbin, Caractacus)', part.name_en = 'Caractacus, op. 35: Scene II, The Sacred Oak Grove by the Tomb of the Kings: “Bard, What Read Ye?” (Arch‐Druid, Orbin, Caractacus)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 1431 AND p.composer_id = 64 AND part.part_key = 'musicbrainz:cc7d1ac9-bf47-40db-9aff-e02dc9a1e672' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:cc7d1ac9-bf47-40db-9aff-e02dc9a1e672', 9, NULL, 'Scene II, The Sacred Oak Grove by the Tomb of the Kings: “Bard, What Read Ye?” (Arch‐Druid, Orbin, Caractacus)', 'Caractacus, op. 35: Scene II, The Sacred Oak Grove by the Tomb of the Kings: “Bard, What Read Ye?” (Arch‐Druid, Orbin, Caractacus)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 1431 AND p.composer_id = 64
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:cc7d1ac9-bf47-40db-9aff-e02dc9a1e672'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 10, part.movement_number = NULL,
    part.name_ko = 'Scene II, The Sacred Oak Grove by the Tomb of the Kings: “Leap to Light” (Caractacus, Chorus)', part.name_en = 'Caractacus, op. 35: Scene II, The Sacred Oak Grove by the Tomb of the Kings: “Leap to Light” (Caractacus, Chorus)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 1431 AND p.composer_id = 64 AND part.part_key = 'musicbrainz:385325cb-649a-4448-a9ca-7737022c0430' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:385325cb-649a-4448-a9ca-7737022c0430', 10, NULL, 'Scene II, The Sacred Oak Grove by the Tomb of the Kings: “Leap to Light” (Caractacus, Chorus)', 'Caractacus, op. 35: Scene II, The Sacred Oak Grove by the Tomb of the Kings: “Leap to Light” (Caractacus, Chorus)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 1431 AND p.composer_id = 64
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:385325cb-649a-4448-a9ca-7737022c0430'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 11, part.movement_number = NULL,
    part.name_ko = 'Scene II, The Sacred Oak Grove by the Tomb of the Kings: “Hence – Ere the Druid’s Wrath is Woke” (Chorus)', part.name_en = 'Caractacus, op. 35: Scene II, The Sacred Oak Grove by the Tomb of the Kings: “Hence – Ere the Druid’s Wrath is Woke” (Chorus)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 1431 AND p.composer_id = 64 AND part.part_key = 'musicbrainz:4d74fbee-d696-4e12-a387-796554aaa849' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:4d74fbee-d696-4e12-a387-796554aaa849', 11, NULL, 'Scene II, The Sacred Oak Grove by the Tomb of the Kings: “Hence – Ere the Druid’s Wrath is Woke” (Chorus)', 'Caractacus, op. 35: Scene II, The Sacred Oak Grove by the Tomb of the Kings: “Hence – Ere the Druid’s Wrath is Woke” (Chorus)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 1431 AND p.composer_id = 64
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:4d74fbee-d696-4e12-a387-796554aaa849'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 12, part.movement_number = NULL,
    part.name_ko = 'Scene III, The Forest Near the Severn: Introduction', part.name_en = 'Caractacus, op. 35: Scene III, The Forest Near the Severn: Introduction',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 1431 AND p.composer_id = 64 AND part.part_key = 'musicbrainz:5959918e-7fa7-438d-a6c0-6cca20ae0351' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:5959918e-7fa7-438d-a6c0-6cca20ae0351', 12, NULL, 'Scene III, The Forest Near the Severn: Introduction', 'Caractacus, op. 35: Scene III, The Forest Near the Severn: Introduction', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 1431 AND p.composer_id = 64
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:5959918e-7fa7-438d-a6c0-6cca20ae0351'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 13, part.movement_number = NULL,
    part.name_ko = 'Scene III, The Forest Near the Severn: “Come! Beneath Our Woodland Bowers” (Chorus)', part.name_en = 'Caractacus, op. 35: Scene III, The Forest Near the Severn: “Come! Beneath Our Woodland Bowers” (Chorus)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 1431 AND p.composer_id = 64 AND part.part_key = 'musicbrainz:884ff9f5-4bb3-49de-9cce-dd66619c4efe' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:884ff9f5-4bb3-49de-9cce-dd66619c4efe', 13, NULL, 'Scene III, The Forest Near the Severn: “Come! Beneath Our Woodland Bowers” (Chorus)', 'Caractacus, op. 35: Scene III, The Forest Near the Severn: “Come! Beneath Our Woodland Bowers” (Chorus)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 1431 AND p.composer_id = 64
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:884ff9f5-4bb3-49de-9cce-dd66619c4efe'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 14, part.movement_number = NULL,
    part.name_ko = 'Scene III, The Forest Near the Severn: “O’er‐arch’d by Leaves” (Eigen)', part.name_en = 'Caractacus, op. 35: Scene III, The Forest Near the Severn: “O’er‐arch’d by Leaves” (Eigen)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 1431 AND p.composer_id = 64 AND part.part_key = 'musicbrainz:bf0a0c3d-ce08-4699-af7b-1504142d373e' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:bf0a0c3d-ce08-4699-af7b-1504142d373e', 14, NULL, 'Scene III, The Forest Near the Severn: “O’er‐arch’d by Leaves” (Eigen)', 'Caractacus, op. 35: Scene III, The Forest Near the Severn: “O’er‐arch’d by Leaves” (Eigen)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 1431 AND p.composer_id = 64
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:bf0a0c3d-ce08-4699-af7b-1504142d373e'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 15, part.movement_number = NULL,
    part.name_ko = 'Scene III, The Forest Near the Severn: “Last Night Beneath the Sacred Oak” (Orbin)', part.name_en = 'Caractacus, op. 35: Scene III, The Forest Near the Severn: “Last Night Beneath the Sacred Oak” (Orbin)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 1431 AND p.composer_id = 64 AND part.part_key = 'musicbrainz:5d118a4a-f6a2-4f92-bd1d-930744c3ac10' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:5d118a4a-f6a2-4f92-bd1d-930744c3ac10', 15, NULL, 'Scene III, The Forest Near the Severn: “Last Night Beneath the Sacred Oak” (Orbin)', 'Caractacus, op. 35: Scene III, The Forest Near the Severn: “Last Night Beneath the Sacred Oak” (Orbin)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 1431 AND p.composer_id = 64
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:5d118a4a-f6a2-4f92-bd1d-930744c3ac10'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 16, part.movement_number = NULL,
    part.name_ko = 'Scene III, The Forest Near the Severn: “Come! Beneath Our Woodland Bow’rs – They Gather the Wreaths” (Chorus, Orbin, Eigen)', part.name_en = 'Caractacus, op. 35: Scene III, The Forest Near the Severn: “Come! Beneath Our Woodland Bow’rs – They Gather the Wreaths” (Chorus, Orbin, Eigen)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 1431 AND p.composer_id = 64 AND part.part_key = 'musicbrainz:0825934f-7ec5-4da4-9187-825b5ff0c531' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:0825934f-7ec5-4da4-9187-825b5ff0c531', 16, NULL, 'Scene III, The Forest Near the Severn: “Come! Beneath Our Woodland Bow’rs – They Gather the Wreaths” (Chorus, Orbin, Eigen)', 'Caractacus, op. 35: Scene III, The Forest Near the Severn: “Come! Beneath Our Woodland Bow’rs – They Gather the Wreaths” (Chorus, Orbin, Eigen)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 1431 AND p.composer_id = 64
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:0825934f-7ec5-4da4-9187-825b5ff0c531'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 17, part.movement_number = NULL,
    part.name_ko = 'Scene IV, The Malven Hills: “Wild Rumours Shake Our Calm Retreat” (Chorus of Maidens)', part.name_en = 'Caractacus, op. 35: Scene IV, The Malven Hills: “Wild Rumours Shake Our Calm Retreat” (Chorus of Maidens)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 1431 AND p.composer_id = 64 AND part.part_key = 'musicbrainz:bc6e7531-e5d8-431b-9aed-d43373a185c8' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:bc6e7531-e5d8-431b-9aed-d43373a185c8', 17, NULL, 'Scene IV, The Malven Hills: “Wild Rumours Shake Our Calm Retreat” (Chorus of Maidens)', 'Caractacus, op. 35: Scene IV, The Malven Hills: “Wild Rumours Shake Our Calm Retreat” (Chorus of Maidens)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 1431 AND p.composer_id = 64
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:bc6e7531-e5d8-431b-9aed-d43373a185c8'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 18, part.movement_number = NULL,
    part.name_ko = 'Scene IV, The Malven Hills: “When the Glow of the Evening” (Eigen)', part.name_en = 'Caractacus, op. 35: Scene IV, The Malven Hills: “When the Glow of the Evening” (Eigen)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 1431 AND p.composer_id = 64 AND part.part_key = 'musicbrainz:aff5f401-617a-422a-8fe4-b78389001fd1' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:aff5f401-617a-422a-8fe4-b78389001fd1', 18, NULL, 'Scene IV, The Malven Hills: “When the Glow of the Evening” (Eigen)', 'Caractacus, op. 35: Scene IV, The Malven Hills: “When the Glow of the Evening” (Eigen)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 1431 AND p.composer_id = 64
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:aff5f401-617a-422a-8fe4-b78389001fd1'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 19, part.movement_number = NULL,
    part.name_ko = 'Scene IV, The Malven Hills: “We Were Gather’d by the River” (Chorus of Soldiers)', part.name_en = 'Caractacus, op. 35: Scene IV, The Malven Hills: “We Were Gather’d by the River” (Chorus of Soldiers)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 1431 AND p.composer_id = 64 AND part.part_key = 'musicbrainz:cfba5afa-8beb-4488-95a3-16579e0a355d' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:cfba5afa-8beb-4488-95a3-16579e0a355d', 19, NULL, 'Scene IV, The Malven Hills: “We Were Gather’d by the River” (Chorus of Soldiers)', 'Caractacus, op. 35: Scene IV, The Malven Hills: “We Were Gather’d by the River” (Chorus of Soldiers)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 1431 AND p.composer_id = 64
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:cfba5afa-8beb-4488-95a3-16579e0a355d'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 20, part.movement_number = NULL,
    part.name_ko = 'Scene IV, The Malven Hills: “O My Warriors” (Caractacus, Chorus)', part.name_en = 'Caractacus, op. 35: Scene IV, The Malven Hills: “O My Warriors” (Caractacus, Chorus)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 1431 AND p.composer_id = 64 AND part.part_key = 'musicbrainz:930d0681-dd4d-492d-a0da-b5ad8d4a67c0' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:930d0681-dd4d-492d-a0da-b5ad8d4a67c0', 20, NULL, 'Scene IV, The Malven Hills: “O My Warriors” (Caractacus, Chorus)', 'Caractacus, op. 35: Scene IV, The Malven Hills: “O My Warriors” (Caractacus, Chorus)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 1431 AND p.composer_id = 64
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:930d0681-dd4d-492d-a0da-b5ad8d4a67c0'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 21, part.movement_number = NULL,
    part.name_ko = 'Scene V, The Severn: “Captive Britons, See Them!” (A Bard, Chorus)', part.name_en = 'Caractacus, op. 35: Scene V, The Severn: “Captive Britons, See Them!” (A Bard, Chorus)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 1431 AND p.composer_id = 64 AND part.part_key = 'musicbrainz:d359afc2-6421-4aaf-bf64-996464019043' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:d359afc2-6421-4aaf-bf64-996464019043', 21, NULL, 'Scene V, The Severn: “Captive Britons, See Them!” (A Bard, Chorus)', 'Caractacus, op. 35: Scene V, The Severn: “Captive Britons, See Them!” (A Bard, Chorus)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 1431 AND p.composer_id = 64
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:d359afc2-6421-4aaf-bf64-996464019043'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 22, part.movement_number = NULL,
    part.name_ko = 'Scene VI, Rome: “The March Triumphal Thunders” (Orchestra and Chorus)', part.name_en = 'Caractacus, op. 35: Scene VI, Rome: “The March Triumphal Thunders” (Orchestra and Chorus)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 1431 AND p.composer_id = 64 AND part.part_key = 'musicbrainz:2b9f5418-2843-406a-a8d3-a8cfff3463fa' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:2b9f5418-2843-406a-a8d3-a8cfff3463fa', 22, NULL, 'Scene VI, Rome: “The March Triumphal Thunders” (Orchestra and Chorus)', 'Caractacus, op. 35: Scene VI, Rome: “The March Triumphal Thunders” (Orchestra and Chorus)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 1431 AND p.composer_id = 64
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:2b9f5418-2843-406a-a8d3-a8cfff3463fa'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 23, part.movement_number = NULL,
    part.name_ko = 'Scene VI, Rome: “Unbind His Hands” (Claudius)', part.name_en = 'Caractacus, op. 35: Scene VI, Rome: “Unbind His Hands” (Claudius)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 1431 AND p.composer_id = 64 AND part.part_key = 'musicbrainz:289ed05a-7e8e-4614-9b26-d1b1efc10e08' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:289ed05a-7e8e-4614-9b26-d1b1efc10e08', 23, NULL, 'Scene VI, Rome: “Unbind His Hands” (Claudius)', 'Caractacus, op. 35: Scene VI, Rome: “Unbind His Hands” (Claudius)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 1431 AND p.composer_id = 64
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:289ed05a-7e8e-4614-9b26-d1b1efc10e08'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 24, part.movement_number = NULL,
    part.name_ko = 'Scene VI, Rome: “Heap Torment Upon Torment” (Caractacus)', part.name_en = 'Caractacus, op. 35: Scene VI, Rome: “Heap Torment Upon Torment” (Caractacus)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 1431 AND p.composer_id = 64 AND part.part_key = 'musicbrainz:ef12961e-20b7-497b-8590-8a915d2e813f' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:ef12961e-20b7-497b-8590-8a915d2e813f', 24, NULL, 'Scene VI, Rome: “Heap Torment Upon Torment” (Caractacus)', 'Caractacus, op. 35: Scene VI, Rome: “Heap Torment Upon Torment” (Caractacus)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 1431 AND p.composer_id = 64
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:ef12961e-20b7-497b-8590-8a915d2e813f'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 25, part.movement_number = NULL,
    part.name_ko = 'Scene VI, Rome: “Slay, Slay the Briton!” (Chorus, Claudius)', part.name_en = 'Caractacus, op. 35: Scene VI, Rome: “Slay, Slay the Briton!” (Chorus, Claudius)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 1431 AND p.composer_id = 64 AND part.part_key = 'musicbrainz:3fad744a-a940-46d4-815c-a421205dbf15' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:3fad744a-a940-46d4-815c-a421205dbf15', 25, NULL, 'Scene VI, Rome: “Slay, Slay the Briton!” (Chorus, Claudius)', 'Caractacus, op. 35: Scene VI, Rome: “Slay, Slay the Briton!” (Chorus, Claudius)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 1431 AND p.composer_id = 64
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:3fad744a-a940-46d4-815c-a421205dbf15'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 26, part.movement_number = NULL,
    part.name_ko = 'Scene VI, Rome: “I Plead Not for Myself” (Caractacus)', part.name_en = 'Caractacus, op. 35: Scene VI, Rome: “I Plead Not for Myself” (Caractacus)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 1431 AND p.composer_id = 64 AND part.part_key = 'musicbrainz:8fcef1cf-e2b2-4516-ab8d-6386d128b39f' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:8fcef1cf-e2b2-4516-ab8d-6386d128b39f', 26, NULL, 'Scene VI, Rome: “I Plead Not for Myself” (Caractacus)', 'Caractacus, op. 35: Scene VI, Rome: “I Plead Not for Myself” (Caractacus)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 1431 AND p.composer_id = 64
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:8fcef1cf-e2b2-4516-ab8d-6386d128b39f'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 27, part.movement_number = NULL,
    part.name_ko = 'Scene VI, Rome: “Grace From the Roman!” (Eigen, Orbin, Caractacus, Claudius)', part.name_en = 'Caractacus, op. 35: Scene VI, Rome: “Grace From the Roman!” (Eigen, Orbin, Caractacus, Claudius)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 1431 AND p.composer_id = 64 AND part.part_key = 'musicbrainz:515e9bb3-c152-43e2-b99b-bc58bc0b9582' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:515e9bb3-c152-43e2-b99b-bc58bc0b9582', 27, NULL, 'Scene VI, Rome: “Grace From the Roman!” (Eigen, Orbin, Caractacus, Claudius)', 'Caractacus, op. 35: Scene VI, Rome: “Grace From the Roman!” (Eigen, Orbin, Caractacus, Claudius)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 1431 AND p.composer_id = 64
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:515e9bb3-c152-43e2-b99b-bc58bc0b9582'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 28, part.movement_number = NULL,
    part.name_ko = 'Scene VI, Rome: “The Clang of Arms is Over” (Chorus)', part.name_en = 'Caractacus, op. 35: Scene VI, Rome: “The Clang of Arms is Over” (Chorus)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 1431 AND p.composer_id = 64 AND part.part_key = 'musicbrainz:acd5b003-854b-4d23-90c4-7ad97684023e' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:acd5b003-854b-4d23-90c4-7ad97684023e', 28, NULL, 'Scene VI, Rome: “The Clang of Arms is Over” (Chorus)', 'Caractacus, op. 35: Scene VI, Rome: “The Clang of Arms is Over” (Chorus)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 1431 AND p.composer_id = 64
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:acd5b003-854b-4d23-90c4-7ad97684023e'
);


-- Op. 75 Carillon

UPDATE pieces piece
SET piece.title = 'Carillon', piece.title_en = 'Carillon, op. 75',
    piece.type = 'song', piece.opus_number = 'Op. 75',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 729 AND piece.composer_id = 64
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- Op. 85 첼로 협주곡 E단조

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'Adagio – Moderato', part.name_en = 'Cello Concerto in E minor, op. 85: I. Adagio – Moderato',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 266 AND p.composer_id = 64 AND part.part_key = 'musicbrainz:bcfe6060-b77b-354e-9cc3-543fe9d8d2b2' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:bcfe6060-b77b-354e-9cc3-543fe9d8d2b2', 1, 'I', 'Adagio – Moderato', 'Cello Concerto in E minor, op. 85: I. Adagio – Moderato', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 266 AND p.composer_id = 64
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:bcfe6060-b77b-354e-9cc3-543fe9d8d2b2'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'Lento – Allegro molto', part.name_en = 'Cello Concerto in E minor, op. 85: II. Lento – Allegro molto',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 266 AND p.composer_id = 64 AND part.part_key = 'musicbrainz:ea20fb3b-82f8-3ccf-a5a7-cac471068f42' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:ea20fb3b-82f8-3ccf-a5a7-cac471068f42', 2, 'II', 'Lento – Allegro molto', 'Cello Concerto in E minor, op. 85: II. Lento – Allegro molto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 266 AND p.composer_id = 64
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:ea20fb3b-82f8-3ccf-a5a7-cac471068f42'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = 'Adagio', part.name_en = 'Cello Concerto in E minor, op. 85: III. Adagio',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 266 AND p.composer_id = 64 AND part.part_key = 'musicbrainz:6f410283-2fa3-35e3-bd03-ffcb4a7954a7' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:6f410283-2fa3-35e3-bd03-ffcb4a7954a7', 3, 'III', 'Adagio', 'Cello Concerto in E minor, op. 85: III. Adagio', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 266 AND p.composer_id = 64
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:6f410283-2fa3-35e3-bd03-ffcb4a7954a7'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = 'IV',
    part.name_ko = 'Allegro – Moderato – Allegro ma non troppo', part.name_en = 'Cello Concerto in E minor, op. 85: IV. Allegro – Moderato – Allegro ma non troppo',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 266 AND p.composer_id = 64 AND part.part_key = 'musicbrainz:0cf4497d-ce0a-3fe8-b120-81b6111a3236' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:0cf4497d-ce0a-3fe8-b120-81b6111a3236', 4, 'IV', 'Allegro – Moderato – Allegro ma non troppo', 'Cello Concerto in E minor, op. 85: IV. Allegro – Moderato – Allegro ma non troppo', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 266 AND p.composer_id = 64
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:0cf4497d-ce0a-3fe8-b120-81b6111a3236'
);


-- Op. 15 Chanson de nuit and Chanson de matin Op. 15

UPDATE pieces piece
SET piece.title = 'Chanson de nuit and Chanson de matin Op. 15', piece.title_en = 'Chanson de nuit and Chanson de matin, op. 15',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = 'Op.', piece.catalogue_number = '15',
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 922 AND piece.composer_id = 64
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'Chanson de nuit, op. 15 no. 1', part.name_en = 'Chanson de nuit, op. 15 no. 1',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 922 AND p.composer_id = 64 AND part.part_key = 'musicbrainz:1ac28578-14c1-4d9f-b0c6-3cb4c5f8f8b0' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:1ac28578-14c1-4d9f-b0c6-3cb4c5f8f8b0', 1, NULL, 'Chanson de nuit, op. 15 no. 1', 'Chanson de nuit, op. 15 no. 1', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 922 AND p.composer_id = 64
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:1ac28578-14c1-4d9f-b0c6-3cb4c5f8f8b0'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'Chanson de matin, op. 15 no. 2', part.name_en = 'Chanson de matin, op. 15 no. 2',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 922 AND p.composer_id = 64 AND part.part_key = 'musicbrainz:b0d1793e-5afc-413f-ae23-8247b32e19e4' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:b0d1793e-5afc-413f-ae23-8247b32e19e4', 2, NULL, 'Chanson de matin, op. 15 no. 2', 'Chanson de matin, op. 15 no. 2', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 922 AND p.composer_id = 64
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:b0d1793e-5afc-413f-ae23-8247b32e19e4'
);


-- None Chantant

UPDATE pieces piece
SET piece.title = 'Chantant', piece.title_en = 'Chantant',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 2215 AND piece.composer_id = 64
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- Op. 40 Cockaigne (In London Town)

UPDATE pieces piece
SET piece.title = 'Cockaigne (In London Town)', piece.title_en = 'Cockaigne (In London Town), op. 40',
    piece.type = 'song', piece.opus_number = 'Op. 40',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 500 AND piece.composer_id = 64
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Come, Gentle Night

UPDATE pieces piece
SET piece.title = 'Come, Gentle Night', piece.title_en = 'Come, Gentle Night',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 2125 AND piece.composer_id = 64
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- Op. 44 Coronation Ode Op. 44

UPDATE pieces piece
SET piece.title = 'Coronation Ode Op. 44', piece.title_en = 'Coronation Ode, op. 44',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = 'Op.', piece.catalogue_number = '44',
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 789 AND piece.composer_id = 64
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'Crown the King', part.name_en = 'Coronation Ode, op. 44: I. Crown the King',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 789 AND p.composer_id = 64 AND part.part_key = 'musicbrainz:53986713-9ed8-434d-ac82-5b9c3d18ee04' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:53986713-9ed8-434d-ac82-5b9c3d18ee04', 1, NULL, 'Crown the King', 'Coronation Ode, op. 44: I. Crown the King', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 789 AND p.composer_id = 64
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:53986713-9ed8-434d-ac82-5b9c3d18ee04'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'IIa. The Queen', part.name_en = 'Coronation Ode, op. 44: IIa. The Queen',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 789 AND p.composer_id = 64 AND part.part_key = 'musicbrainz:c1759e40-df2c-4634-b966-4d22f845062c' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:c1759e40-df2c-4634-b966-4d22f845062c', 2, NULL, 'IIa. The Queen', 'Coronation Ode, op. 44: IIa. The Queen', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 789 AND p.composer_id = 64
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:c1759e40-df2c-4634-b966-4d22f845062c'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = NULL,
    part.name_ko = 'IIb. Daughter of Ancient Kings', part.name_en = 'Coronation Ode, op. 44: IIb. Daughter of Ancient Kings',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 789 AND p.composer_id = 64 AND part.part_key = 'musicbrainz:f44d2370-5f22-4f42-ba2b-d20136dad4b8' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:f44d2370-5f22-4f42-ba2b-d20136dad4b8', 3, NULL, 'IIb. Daughter of Ancient Kings', 'Coronation Ode, op. 44: IIb. Daughter of Ancient Kings', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 789 AND p.composer_id = 64
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:f44d2370-5f22-4f42-ba2b-d20136dad4b8'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = NULL,
    part.name_ko = 'Britain, Ask of Thyself', part.name_en = 'Coronation Ode, op. 44: III. Britain, Ask of Thyself',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 789 AND p.composer_id = 64 AND part.part_key = 'musicbrainz:4e000e8a-1d91-4c67-af06-3792f0f4d2ba' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:4e000e8a-1d91-4c67-af06-3792f0f4d2ba', 4, NULL, 'Britain, Ask of Thyself', 'Coronation Ode, op. 44: III. Britain, Ask of Thyself', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 789 AND p.composer_id = 64
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:4e000e8a-1d91-4c67-af06-3792f0f4d2ba'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 5, part.movement_number = NULL,
    part.name_ko = 'Hark, Upon the Hallowed Air... Only Let the Heart Be Pure', part.name_en = 'Coronation Ode, op. 44: IV. Hark, Upon the Hallowed Air... Only Let the Heart Be Pure',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 789 AND p.composer_id = 64 AND part.part_key = 'musicbrainz:446684b9-0109-4a74-a01d-4b2e45ef6f4c' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:446684b9-0109-4a74-a01d-4b2e45ef6f4c', 5, NULL, 'Hark, Upon the Hallowed Air... Only Let the Heart Be Pure', 'Coronation Ode, op. 44: IV. Hark, Upon the Hallowed Air... Only Let the Heart Be Pure', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 789 AND p.composer_id = 64
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:446684b9-0109-4a74-a01d-4b2e45ef6f4c'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 6, part.movement_number = NULL,
    part.name_ko = 'Peace, Gentle Peace', part.name_en = 'Coronation Ode, op. 44: V. Peace, Gentle Peace',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 789 AND p.composer_id = 64 AND part.part_key = 'musicbrainz:bd2c08f3-c535-4587-8a78-0e3705e30d2a' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:bd2c08f3-c535-4587-8a78-0e3705e30d2a', 6, NULL, 'Peace, Gentle Peace', 'Coronation Ode, op. 44: V. Peace, Gentle Peace', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 789 AND p.composer_id = 64
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:bd2c08f3-c535-4587-8a78-0e3705e30d2a'
);


-- None Credo on Themes from Beethoven Symphonies 5, 7, and 9

UPDATE pieces piece
SET piece.title = 'Credo on Themes from Beethoven Symphonies 5, 7, and 9', piece.title_en = 'Credo on Themes from Beethoven Symphonies 5, 7, and 9',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 2625 AND piece.composer_id = 64
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- Op. 72 Death on the Hills

UPDATE pieces piece
SET piece.title = 'Death on the Hills', piece.title_en = 'Death on the Hills, op. 72',
    piece.type = 'song', piece.opus_number = 'Op. 72',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 2011 AND piece.composer_id = 64
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Dry Those Fair, Those Crystal Eyes

UPDATE pieces piece
SET piece.title = 'Dry Those Fair, Those Crystal Eyes', piece.title_en = 'Dry Those Fair, Those Crystal Eyes',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 2572 AND piece.composer_id = 64
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- Op. 58 엘레지

UPDATE pieces piece
SET piece.catalogue_system = 'Op.', piece.catalogue_number = '58'
WHERE piece.id = 493 AND piece.composer_id = 64
  AND piece.catalogue_number IS NULL AND piece.opus_number IS NULL;


-- None Evening Scene

UPDATE pieces piece
SET piece.title = 'Evening Scene', piece.title_en = 'Evening Scene',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 2897 AND piece.composer_id = 64
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- Op. 68 Falstaff

UPDATE pieces piece
SET piece.title = 'Falstaff', piece.title_en = 'Falstaff, op. 68',
    piece.type = 'album', piece.opus_number = 'Op. 68',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 1876 AND piece.composer_id = 64
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'Falstaff and Prince Henry', part.name_en = 'Falstaff, op. 68: I. Falstaff and Prince Henry',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 1876 AND p.composer_id = 64 AND part.part_key = 'musicbrainz:ffa1cbf4-d15f-4176-8e5c-aacf00560039' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:ffa1cbf4-d15f-4176-8e5c-aacf00560039', 1, 'I', 'Falstaff and Prince Henry', 'Falstaff, op. 68: I. Falstaff and Prince Henry', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 1876 AND p.composer_id = 64
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:ffa1cbf4-d15f-4176-8e5c-aacf00560039'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'Eastcheap – Gadshill – The Boar''s Head. Revelry and sleep – Dream Interlude (Poco allegretto)', part.name_en = 'Falstaff, op. 68: II. Eastcheap – Gadshill – The Boar''s Head. Revelry and sleep – Dream Interlude (Poco allegretto)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 1876 AND p.composer_id = 64 AND part.part_key = 'musicbrainz:da51eaf0-16da-4bf1-a421-36af456d1cbb' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:da51eaf0-16da-4bf1-a421-36af456d1cbb', 2, 'II', 'Eastcheap – Gadshill – The Boar''s Head. Revelry and sleep – Dream Interlude (Poco allegretto)', 'Falstaff, op. 68: II. Eastcheap – Gadshill – The Boar''s Head. Revelry and sleep – Dream Interlude (Poco allegretto)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 1876 AND p.composer_id = 64
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:da51eaf0-16da-4bf1-a421-36af456d1cbb'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = 'Falstaff''s March – The Return Through Gloucestershire – Interlude: Gloucestershire. Shallow''s Orchard (Allegretto) – The New King – The Hurried Ride to London', part.name_en = 'Falstaff, op. 68: III. Falstaff''s March – The Return Through Gloucestershire – Interlude: Gloucestershire. Shallow''s Orchard (Allegretto) – The New King – The Hurried Ride to London',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 1876 AND p.composer_id = 64 AND part.part_key = 'musicbrainz:90e66db2-091d-412e-90d5-2eccb14ca3a3' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:90e66db2-091d-412e-90d5-2eccb14ca3a3', 3, 'III', 'Falstaff''s March – The Return Through Gloucestershire – Interlude: Gloucestershire. Shallow''s Orchard (Allegretto) – The New King – The Hurried Ride to London', 'Falstaff, op. 68: III. Falstaff''s March – The Return Through Gloucestershire – Interlude: Gloucestershire. Shallow''s Orchard (Allegretto) – The New King – The Hurried Ride to London', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 1876 AND p.composer_id = 64
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:90e66db2-091d-412e-90d5-2eccb14ca3a3'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = 'IV',
    part.name_ko = 'King Henry V''s Progress – The Repudiation of Falstaff, and His Death', part.name_en = 'Falstaff, op. 68: IV. King Henry V''s Progress – The Repudiation of Falstaff, and His Death',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 1876 AND p.composer_id = 64 AND part.part_key = 'musicbrainz:75ffbf5e-ef61-4bd9-a5aa-f3e73c71ad52' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:75ffbf5e-ef61-4bd9-a5aa-f3e73c71ad52', 4, 'IV', 'King Henry V''s Progress – The Repudiation of Falstaff, and His Death', 'Falstaff, op. 68: IV. King Henry V''s Progress – The Repudiation of Falstaff, and His Death', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 1876 AND p.composer_id = 64
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:75ffbf5e-ef61-4bd9-a5aa-f3e73c71ad52'
);


-- None Fear not, o land

UPDATE pieces piece
SET piece.title = 'Fear not, o land', piece.title_en = 'Fear not, o land',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 1666 AND piece.composer_id = 64
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- Op. 45 Five Part-songs from The Greek Anthology Op. 45

UPDATE pieces piece
SET piece.title = 'Five Part-songs from The Greek Anthology Op. 45', piece.title_en = 'Five Part-songs from The Greek Anthology, op. 45',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = 'Op.', piece.catalogue_number = '45',
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 2787 AND piece.composer_id = 64
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'Yea, Cast me from Heights of the Mountains , op. 45 no. 1', part.name_en = 'Yea, Cast me from Heights of the Mountains , op. 45 no. 1',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 2787 AND p.composer_id = 64 AND part.part_key = 'musicbrainz:cc056d7b-02d2-44d8-859b-2e018d90e824' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:cc056d7b-02d2-44d8-859b-2e018d90e824', 1, NULL, 'Yea, Cast me from Heights of the Mountains , op. 45 no. 1', 'Yea, Cast me from Heights of the Mountains , op. 45 no. 1', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 2787 AND p.composer_id = 64
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:cc056d7b-02d2-44d8-859b-2e018d90e824'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'Whether I Find Thee, op. 45 no. 2', part.name_en = 'Whether I Find Thee, op. 45 no. 2',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 2787 AND p.composer_id = 64 AND part.part_key = 'musicbrainz:ae5bc605-bdd5-4f65-9f9a-361fd6323b2c' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:ae5bc605-bdd5-4f65-9f9a-361fd6323b2c', 2, NULL, 'Whether I Find Thee, op. 45 no. 2', 'Whether I Find Thee, op. 45 no. 2', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 2787 AND p.composer_id = 64
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:ae5bc605-bdd5-4f65-9f9a-361fd6323b2c'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = NULL,
    part.name_ko = 'After many a Dusty Mile, op. 45 no. 3', part.name_en = 'After many a Dusty Mile, op. 45 no. 3',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 2787 AND p.composer_id = 64 AND part.part_key = 'musicbrainz:e97dbab3-50d9-43fb-b35e-f9acdfc4302a' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:e97dbab3-50d9-43fb-b35e-f9acdfc4302a', 3, NULL, 'After many a Dusty Mile, op. 45 no. 3', 'After many a Dusty Mile, op. 45 no. 3', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 2787 AND p.composer_id = 64
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:e97dbab3-50d9-43fb-b35e-f9acdfc4302a'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = NULL,
    part.name_ko = 'It''s oh! to be a Wild Wind, op. 45 no. 4', part.name_en = 'It''s oh! to be a Wild Wind, op. 45 no. 4',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 2787 AND p.composer_id = 64 AND part.part_key = 'musicbrainz:a12ce671-4810-410b-88e4-3ef0b9ebbb4a' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:a12ce671-4810-410b-88e4-3ef0b9ebbb4a', 4, NULL, 'It''s oh! to be a Wild Wind, op. 45 no. 4', 'It''s oh! to be a Wild Wind, op. 45 no. 4', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 2787 AND p.composer_id = 64
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:a12ce671-4810-410b-88e4-3ef0b9ebbb4a'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 5, part.movement_number = NULL,
    part.name_ko = 'Feasting I Watch, op. 45 no. 5', part.name_en = 'Feasting I Watch, op. 45 no. 5',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 2787 AND p.composer_id = 64 AND part.part_key = 'musicbrainz:56d04e09-0e86-47f6-ac9d-3f81ec041a5d' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:56d04e09-0e86-47f6-ac9d-3f81ec041a5d', 5, NULL, 'Feasting I Watch, op. 45 no. 5', 'Feasting I Watch, op. 45 no. 5', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 2787 AND p.composer_id = 64
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:56d04e09-0e86-47f6-ac9d-3f81ec041a5d'
);


-- None Five Piano Improvisations

UPDATE pieces piece
SET piece.title = 'Five Piano Improvisations', piece.title_en = 'Five Piano Improvisations',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 1668 AND piece.composer_id = 64
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'No. 1', part.name_en = 'Five Piano Improvisations: No. 1',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 1668 AND p.composer_id = 64 AND part.part_key = 'musicbrainz:22dcef44-d2a4-42a2-9028-28378148c016' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:22dcef44-d2a4-42a2-9028-28378148c016', 1, NULL, 'No. 1', 'Five Piano Improvisations: No. 1', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 1668 AND p.composer_id = 64
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:22dcef44-d2a4-42a2-9028-28378148c016'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'No. 2', part.name_en = 'Five Piano Improvisations: No. 2',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 1668 AND p.composer_id = 64 AND part.part_key = 'musicbrainz:501e5e3f-52c8-4e67-a735-c6206314b06d' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:501e5e3f-52c8-4e67-a735-c6206314b06d', 2, NULL, 'No. 2', 'Five Piano Improvisations: No. 2', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 1668 AND p.composer_id = 64
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:501e5e3f-52c8-4e67-a735-c6206314b06d'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = NULL,
    part.name_ko = 'No. 3', part.name_en = 'Five Piano Improvisations: No. 3',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 1668 AND p.composer_id = 64 AND part.part_key = 'musicbrainz:6975baa2-3d19-4439-a0f4-88b2da031efd' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:6975baa2-3d19-4439-a0f4-88b2da031efd', 3, NULL, 'No. 3', 'Five Piano Improvisations: No. 3', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 1668 AND p.composer_id = 64
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:6975baa2-3d19-4439-a0f4-88b2da031efd'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = NULL,
    part.name_ko = 'No. 4', part.name_en = 'Five Piano Improvisations: No. 4',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 1668 AND p.composer_id = 64 AND part.part_key = 'musicbrainz:f8717d01-b8de-4b90-9f28-53c4cffde1ad' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:f8717d01-b8de-4b90-9f28-53c4cffde1ad', 4, NULL, 'No. 4', 'Five Piano Improvisations: No. 4', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 1668 AND p.composer_id = 64
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:f8717d01-b8de-4b90-9f28-53c4cffde1ad'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 5, part.movement_number = NULL,
    part.name_ko = 'No. 5', part.name_en = 'Five Piano Improvisations: No. 5',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 1668 AND p.composer_id = 64 AND part.part_key = 'musicbrainz:b69a934b-6a87-4e6f-9cef-0104c32b48e8' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:b69a934b-6a87-4e6f-9cef-0104c32b48e8', 5, NULL, 'No. 5', 'Five Piano Improvisations: No. 5', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 1668 AND p.composer_id = 64
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:b69a934b-6a87-4e6f-9cef-0104c32b48e8'
);


-- Op. 53 4개의 합창곡 Op. 53

UPDATE pieces piece
SET piece.title = '4개의 합창곡 Op. 53', piece.title_en = 'Four Part-Songs, op. 53',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = 'Op.', piece.catalogue_number = '53',
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 1304 AND piece.composer_id = 64
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'There Is Sweet Music, op. 53 no. 1', part.name_en = 'There Is Sweet Music, op. 53 no. 1',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 1304 AND p.composer_id = 64 AND part.part_key = 'musicbrainz:05c23728-7905-4987-90ac-ca34dc50c2ff' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:05c23728-7905-4987-90ac-ca34dc50c2ff', 1, NULL, 'There Is Sweet Music, op. 53 no. 1', 'There Is Sweet Music, op. 53 no. 1', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 1304 AND p.composer_id = 64
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:05c23728-7905-4987-90ac-ca34dc50c2ff'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'Deep in My Soul, op. 53 no. 2', part.name_en = 'Deep in My Soul, op. 53 no. 2',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 1304 AND p.composer_id = 64 AND part.part_key = 'musicbrainz:de9e5963-627e-32f1-894b-dfa45713508f' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:de9e5963-627e-32f1-894b-dfa45713508f', 2, NULL, 'Deep in My Soul, op. 53 no. 2', 'Deep in My Soul, op. 53 no. 2', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 1304 AND p.composer_id = 64
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:de9e5963-627e-32f1-894b-dfa45713508f'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = NULL,
    part.name_ko = 'O Wild West Wind!, op. 53 no. 3', part.name_en = 'O Wild West Wind!, op. 53 no. 3',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 1304 AND p.composer_id = 64 AND part.part_key = 'musicbrainz:5b0b481f-cc9c-4797-b4be-67c7669e9653' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:5b0b481f-cc9c-4797-b4be-67c7669e9653', 3, NULL, 'O Wild West Wind!, op. 53 no. 3', 'O Wild West Wind!, op. 53 no. 3', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 1304 AND p.composer_id = 64
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:5b0b481f-cc9c-4797-b4be-67c7669e9653'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = NULL,
    part.name_ko = 'Owls (An Epitaph), op. 53 no. 4', part.name_en = 'Owls (An Epitaph), op. 53 no. 4',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 1304 AND p.composer_id = 64 AND part.part_key = 'musicbrainz:82e83b43-436b-4724-b7bd-87047d25496a' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:82e83b43-436b-4724-b7bd-87047d25496a', 4, NULL, 'Owls (An Epitaph), op. 53 no. 4', 'Owls (An Epitaph), op. 53 no. 4', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 1304 AND p.composer_id = 64
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:82e83b43-436b-4724-b7bd-87047d25496a'
);


-- Op. 19 Froissart Overture

UPDATE pieces piece
SET piece.title = 'Froissart Overture', piece.title_en = 'Froissart Overture, op. 19',
    piece.type = 'song', piece.opus_number = 'Op. 19',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 733 AND piece.composer_id = 64
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- Op. 27 연가곡집 <From the Bavarian Highlands>

UPDATE pieces piece
SET piece.title = '연가곡집 <From the Bavarian Highlands>', piece.title_en = 'From the Bavarian Highlands, op. 27',
    piece.type = 'album', piece.opus_number = 'Op. 27',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 786 AND piece.composer_id = 64
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'The Dance (Sonnenbichl)', part.name_en = 'From the Bavarian Highlands, op. 27: I. The Dance (Sonnenbichl)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 786 AND p.composer_id = 64 AND part.part_key = 'musicbrainz:119f78ad-2e82-4354-916e-2c938e58fbd2' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:119f78ad-2e82-4354-916e-2c938e58fbd2', 1, 'I', 'The Dance (Sonnenbichl)', 'From the Bavarian Highlands, op. 27: I. The Dance (Sonnenbichl)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 786 AND p.composer_id = 64
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:119f78ad-2e82-4354-916e-2c938e58fbd2'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'False Love (Wamberg)', part.name_en = 'From the Bavarian Highlands, op. 27: II. False Love (Wamberg)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 786 AND p.composer_id = 64 AND part.part_key = 'musicbrainz:3a14f7c6-ca26-486f-8ee9-8f9c7cc2af68' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:3a14f7c6-ca26-486f-8ee9-8f9c7cc2af68', 2, 'II', 'False Love (Wamberg)', 'From the Bavarian Highlands, op. 27: II. False Love (Wamberg)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 786 AND p.composer_id = 64
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:3a14f7c6-ca26-486f-8ee9-8f9c7cc2af68'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = 'Lullaby (In Hammersbach)', part.name_en = 'From the Bavarian Highlands, op. 27: III. Lullaby (In Hammersbach)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 786 AND p.composer_id = 64 AND part.part_key = 'musicbrainz:e528c832-01ef-48a3-bd9d-11f36b29a7e9' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:e528c832-01ef-48a3-bd9d-11f36b29a7e9', 3, 'III', 'Lullaby (In Hammersbach)', 'From the Bavarian Highlands, op. 27: III. Lullaby (In Hammersbach)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 786 AND p.composer_id = 64
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:e528c832-01ef-48a3-bd9d-11f36b29a7e9'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = 'IV',
    part.name_ko = 'Aspiration (Bei Sankt Anton)', part.name_en = 'From the Bavarian Highlands, op. 27: IV. Aspiration (Bei Sankt Anton)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 786 AND p.composer_id = 64 AND part.part_key = 'musicbrainz:488bf72e-c5ff-40c1-baa8-8087ca3d9e9b' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:488bf72e-c5ff-40c1-baa8-8087ca3d9e9b', 4, 'IV', 'Aspiration (Bei Sankt Anton)', 'From the Bavarian Highlands, op. 27: IV. Aspiration (Bei Sankt Anton)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 786 AND p.composer_id = 64
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:488bf72e-c5ff-40c1-baa8-8087ca3d9e9b'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 5, part.movement_number = 'V',
    part.name_ko = 'On the Alm (Hoch Alp)', part.name_en = 'From the Bavarian Highlands, op. 27: V. On the Alm (Hoch Alp)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 786 AND p.composer_id = 64 AND part.part_key = 'musicbrainz:96a99f6f-3214-41af-b3e1-715ea17902d7' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:96a99f6f-3214-41af-b3e1-715ea17902d7', 5, 'V', 'On the Alm (Hoch Alp)', 'From the Bavarian Highlands, op. 27: V. On the Alm (Hoch Alp)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 786 AND p.composer_id = 64
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:96a99f6f-3214-41af-b3e1-715ea17902d7'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 6, part.movement_number = 'VI',
    part.name_ko = 'The Marksmen (Bei Murnau)', part.name_en = 'From the Bavarian Highlands, op. 27: VI. The Marksmen (Bei Murnau)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 786 AND p.composer_id = 64 AND part.part_key = 'musicbrainz:c1845cb7-308f-4d41-b027-d0c05ece60ba' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:c1845cb7-308f-4d41-b027-d0c05ece60ba', 6, 'VI', 'The Marksmen (Bei Murnau)', 'From the Bavarian Highlands, op. 27: VI. The Marksmen (Bei Murnau)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 786 AND p.composer_id = 64
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:c1845cb7-308f-4d41-b027-d0c05ece60ba'
);


-- None 푸가 G

UPDATE pieces piece
SET piece.title = '푸가 G', piece.title_en = 'Fugue in G',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 1497 AND piece.composer_id = 64
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None 가보트

UPDATE pieces piece
SET piece.title = '가보트', piece.title_en = 'Gavotte',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 2160 AND piece.composer_id = 64
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- Op. 74 Give Unto the Lord

UPDATE pieces piece
SET piece.title = 'Give Unto the Lord', piece.title_en = 'Give Unto the Lord, op. 74',
    piece.type = 'song', piece.opus_number = 'Op. 74',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 560 AND piece.composer_id = 64
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- Op. 57 Go, Song of Mine

UPDATE pieces piece
SET piece.title = 'Go, Song of Mine', piece.title_en = 'Go, Song of Mine, op. 57',
    piece.type = 'song', piece.opus_number = 'Op. 57',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 1838 AND piece.composer_id = 64
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- Op. 42 부수음악 <Grania and Diarmid>

UPDATE pieces piece
SET piece.title = '부수음악 <Grania and Diarmid>', piece.title_en = 'Grania and Diarmid, op. 42',
    piece.type = 'album', piece.opus_number = 'Op. 42',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 2722 AND piece.composer_id = 64
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'Incidental Music', part.name_en = 'Grania and Diarmid, op. 42: I. Incidental Music',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 2722 AND p.composer_id = 64 AND part.part_key = 'musicbrainz:77ba566b-6b62-4268-b9b0-f6732e6ce841' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:77ba566b-6b62-4268-b9b0-f6732e6ce841', 1, 'I', 'Incidental Music', 'Grania and Diarmid, op. 42: I. Incidental Music', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 2722 AND p.composer_id = 64
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:77ba566b-6b62-4268-b9b0-f6732e6ce841'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'Funeral March', part.name_en = 'Grania and Diarmid, op. 42: II. Funeral March',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 2722 AND p.composer_id = 64 AND part.part_key = 'musicbrainz:6a290f96-ebe4-445e-ac85-65449cc82aae' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:6a290f96-ebe4-445e-ac85-65449cc82aae', 2, 'II', 'Funeral March', 'Grania and Diarmid, op. 42: II. Funeral March', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 2722 AND p.composer_id = 64
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:6a290f96-ebe4-445e-ac85-65449cc82aae'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = '“There Are Seven That Pull the Thread”', part.name_en = 'Grania and Diarmid, op. 42: III. “There Are Seven That Pull the Thread”',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 2722 AND p.composer_id = 64 AND part.part_key = 'musicbrainz:ae815fdb-b03a-4871-9ae8-d943aa1268b2' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:ae815fdb-b03a-4871-9ae8-d943aa1268b2', 3, 'III', '“There Are Seven That Pull the Thread”', 'Grania and Diarmid, op. 42: III. “There Are Seven That Pull the Thread”', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 2722 AND p.composer_id = 64
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:ae815fdb-b03a-4871-9ae8-d943aa1268b2'
);


-- None 가곡 <How Calmly the Evening>

UPDATE pieces piece
SET piece.title = '가곡 <How Calmly the Evening>', piece.title_en = 'How Calmly the Evening',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 2485 AND piece.composer_id = 64
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Humoreske

UPDATE pieces piece
SET piece.title = 'Humoreske', piece.title_en = 'Humoreske',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 1641 AND piece.composer_id = 64
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None I sing the birth

UPDATE pieces piece
SET piece.title = 'I sing the birth', piece.title_en = 'I sing the birth',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 1389 AND piece.composer_id = 64
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None 즉흥곡

UPDATE pieces piece
SET piece.title = '즉흥곡', piece.title_en = 'Impromptu',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 2462 AND piece.composer_id = 64
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None In Smyrna

UPDATE pieces piece
SET piece.title = 'In Smyrna', piece.title_en = 'In Smyrna',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 2460 AND piece.composer_id = 64
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- Op. 50 In the South (Alassio)

UPDATE pieces piece
SET piece.title = 'In the South (Alassio)', piece.title_en = 'In the South (Alassio), op. 50',
    piece.type = 'song', piece.opus_number = 'Op. 50',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 2809 AND piece.composer_id = 64
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- Op. 47 Introduction and Allegro for Strings Op. 47

UPDATE pieces piece
SET piece.title = 'Introduction and Allegro for Strings Op. 47', piece.title_en = 'Introduction and Allegro for Strings, op. 47',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = 'Op.', piece.catalogue_number = '47',
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 677 AND piece.composer_id = 64
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'Allegro', part.name_en = 'Introduction and Allegro for Strings and Orchestra, op. 47: Allegro',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 677 AND p.composer_id = 64 AND part.part_key = 'musicbrainz:2254fc69-0efd-4574-9476-595752c553ad' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:2254fc69-0efd-4574-9476-595752c553ad', 1, NULL, 'Allegro', 'Introduction and Allegro for Strings and Orchestra, op. 47: Allegro', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 677 AND p.composer_id = 64
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:2254fc69-0efd-4574-9476-595752c553ad'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'Introduction', part.name_en = 'Introduction and Allegro for Strings and Orchestra, op. 47: Introduction',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 677 AND p.composer_id = 64 AND part.part_key = 'musicbrainz:3e721c39-9d40-4560-a4a8-1998c5f29955' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:3e721c39-9d40-4560-a4a8-1998c5f29955', 2, NULL, 'Introduction', 'Introduction and Allegro for Strings and Orchestra, op. 47: Introduction', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 677 AND p.composer_id = 64
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:3e721c39-9d40-4560-a4a8-1998c5f29955'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = NULL,
    part.name_ko = 'Allegro -', part.name_en = 'Introduction and Allegro for Strings, op. 47: II. Allegro -',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 677 AND p.composer_id = 64 AND part.part_key = 'musicbrainz:5df85048-04dc-4cb0-bedd-ab7a10cb38b6' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:5df85048-04dc-4cb0-bedd-ab7a10cb38b6', 3, NULL, 'Allegro -', 'Introduction and Allegro for Strings, op. 47: II. Allegro -', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 677 AND p.composer_id = 64
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:5df85048-04dc-4cb0-bedd-ab7a10cb38b6'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = NULL,
    part.name_ko = 'Moderato -', part.name_en = 'Introduction and Allegro for Strings, op. 47: I. Moderato -',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 677 AND p.composer_id = 64 AND part.part_key = 'musicbrainz:66bd74fc-b87f-4c91-b49c-41d23d3f87cc' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:66bd74fc-b87f-4c91-b49c-41d23d3f87cc', 4, NULL, 'Moderato -', 'Introduction and Allegro for Strings, op. 47: I. Moderato -', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 677 AND p.composer_id = 64
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:66bd74fc-b87f-4c91-b49c-41d23d3f87cc'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 5, part.movement_number = NULL,
    part.name_ko = 'Fugue: Allegro', part.name_en = 'Introduction and Allegro for Strings, op. 47: III. Fugue: Allegro',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 677 AND p.composer_id = 64 AND part.part_key = 'musicbrainz:8b055dea-f480-48e7-9640-d1580c93fbfb' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:8b055dea-f480-48e7-9640-d1580c93fbfb', 5, NULL, 'Fugue: Allegro', 'Introduction and Allegro for Strings, op. 47: III. Fugue: Allegro', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 677 AND p.composer_id = 64
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:8b055dea-f480-48e7-9640-d1580c93fbfb'
);


-- None Introduction to Anonymous Anthem

UPDATE pieces piece
SET piece.title = 'Introduction to Anonymous Anthem', piece.title_en = 'Introduction to Anonymous Anthem',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 1444 AND piece.composer_id = 64
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None 가곡 <Is She Not Passing Fair?>

UPDATE pieces piece
SET piece.title = '가곡 <Is She Not Passing Fair?>', piece.title_en = 'Is She Not Passing Fair?',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 2951 AND piece.composer_id = 64
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None It isnae me

UPDATE pieces piece
SET piece.title = 'It isnae me', piece.title_en = 'It isnae me',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 2622 AND piece.composer_id = 64
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Kyrie in A

UPDATE pieces piece
SET piece.title = 'Kyrie in A', piece.title_en = 'Kyrie in A',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 1783 AND piece.composer_id = 64
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Laura Valse

UPDATE pieces piece
SET piece.title = 'Laura Valse', piece.title_en = 'Laura Valse',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 850 AND piece.composer_id = 64
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- Op. 79 Le drapeau belge

UPDATE pieces piece
SET piece.title = 'Le drapeau belge', piece.title_en = 'Le drapeau belge, op. 79',
    piece.type = 'song', piece.opus_number = 'Op. 79',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 902 AND piece.composer_id = 64
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None 가곡 <Like to the Damask Rose>

UPDATE pieces piece
SET piece.title = '가곡 <Like to the Damask Rose>', piece.title_en = 'Like to the Damask Rose',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 941 AND piece.composer_id = 64
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Lo! Christ the Lord is born

UPDATE pieces piece
SET piece.title = 'Lo! Christ the Lord is born', piece.title_en = 'Lo! Christ the Lord is born',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 872 AND piece.composer_id = 64
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None 행진곡 D장조

UPDATE pieces piece
SET piece.title = '행진곡 D장조', piece.title_en = 'March in D major',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 2444 AND piece.composer_id = 64
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Mina

UPDATE pieces piece
SET piece.title = 'Mina', piece.title_en = 'Mina',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 1133 AND piece.composer_id = 64
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- Op. 21 미뉴에트 A단조

UPDATE pieces piece
SET piece.title = '미뉴에트 A단조', piece.title_en = 'Minuet, op. 21',
    piece.type = 'song', piece.opus_number = 'Op. 21',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 1002 AND piece.composer_id = 64
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Nursery Suite

UPDATE pieces piece
SET piece.title = 'Nursery Suite', piece.title_en = 'Nursery Suite',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 2059 AND piece.composer_id = 64
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'Aubade', part.name_en = 'Nursery Suite: I. Aubade',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 2059 AND p.composer_id = 64 AND part.part_key = 'musicbrainz:08ae465a-b45f-4f3a-8bb4-672895b33ea7' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:08ae465a-b45f-4f3a-8bb4-672895b33ea7', 1, 'I', 'Aubade', 'Nursery Suite: I. Aubade', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 2059 AND p.composer_id = 64
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:08ae465a-b45f-4f3a-8bb4-672895b33ea7'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'The Serious Doll', part.name_en = 'Nursery Suite: II. The Serious Doll',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 2059 AND p.composer_id = 64 AND part.part_key = 'musicbrainz:c99ef18e-d4f5-4d50-b61f-139898548763' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:c99ef18e-d4f5-4d50-b61f-139898548763', 2, 'II', 'The Serious Doll', 'Nursery Suite: II. The Serious Doll', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 2059 AND p.composer_id = 64
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:c99ef18e-d4f5-4d50-b61f-139898548763'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = 'Busy-Ness', part.name_en = 'Nursery Suite: III. Busy-Ness',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 2059 AND p.composer_id = 64 AND part.part_key = 'musicbrainz:e5a16c7c-7b39-4b4a-a52a-6dbba4dc3a8b' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:e5a16c7c-7b39-4b4a-a52a-6dbba4dc3a8b', 3, 'III', 'Busy-Ness', 'Nursery Suite: III. Busy-Ness', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 2059 AND p.composer_id = 64
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:e5a16c7c-7b39-4b4a-a52a-6dbba4dc3a8b'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = 'IV',
    part.name_ko = 'The Sad Doll', part.name_en = 'Nursery Suite: IV. The Sad Doll',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 2059 AND p.composer_id = 64 AND part.part_key = 'musicbrainz:d5315e49-e9f5-4537-966f-37a8cc8a01af' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:d5315e49-e9f5-4537-966f-37a8cc8a01af', 4, 'IV', 'The Sad Doll', 'Nursery Suite: IV. The Sad Doll', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 2059 AND p.composer_id = 64
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:d5315e49-e9f5-4537-966f-37a8cc8a01af'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 5, part.movement_number = 'V',
    part.name_ko = 'The Wagon (Passes)', part.name_en = 'Nursery Suite: V. The Wagon (Passes)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 2059 AND p.composer_id = 64 AND part.part_key = 'musicbrainz:7caabb73-bf01-4cf4-bef0-f6597ade9862' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:7caabb73-bf01-4cf4-bef0-f6597ade9862', 5, 'V', 'The Wagon (Passes)', 'Nursery Suite: V. The Wagon (Passes)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 2059 AND p.composer_id = 64
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:7caabb73-bf01-4cf4-bef0-f6597ade9862'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 6, part.movement_number = 'VI',
    part.name_ko = 'The Merry Doll', part.name_en = 'Nursery Suite: VI. The Merry Doll',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 2059 AND p.composer_id = 64 AND part.part_key = 'musicbrainz:6d7b6189-ef28-4db7-b746-f448a4a8c6ec' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:6d7b6189-ef28-4db7-b746-f448a4a8c6ec', 6, 'VI', 'The Merry Doll', 'Nursery Suite: VI. The Merry Doll', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 2059 AND p.composer_id = 64
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:6d7b6189-ef28-4db7-b746-f448a4a8c6ec'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 7, part.movement_number = 'VII',
    part.name_ko = 'Dreaming', part.name_en = 'Nursery Suite: VII. Dreaming',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 2059 AND p.composer_id = 64 AND part.part_key = 'musicbrainz:297e3b97-10a1-4621-ac71-6bff97cd1490' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:297e3b97-10a1-4621-ac71-6bff97cd1490', 7, 'VII', 'Dreaming', 'Nursery Suite: VII. Dreaming', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 2059 AND p.composer_id = 64
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:297e3b97-10a1-4621-ac71-6bff97cd1490'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 8, part.movement_number = 'VIII',
    part.name_ko = 'Envoy (Coda)', part.name_en = 'Nursery Suite: VIII. Envoy (Coda)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 2059 AND p.composer_id = 64 AND part.part_key = 'musicbrainz:d28d4c72-cece-416d-9e7c-6b87bb0f54d8' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:d28d4c72-cece-416d-9e7c-6b87bb0f54d8', 8, 'VIII', 'Envoy (Coda)', 'Nursery Suite: VIII. Envoy (Coda)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 2059 AND p.composer_id = 64
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:d28d4c72-cece-416d-9e7c-6b87bb0f54d8'
);


-- Op. 18 No. 1 가곡 <O Happy Eyes>

UPDATE pieces piece
SET piece.title = '가곡 <O Happy Eyes>', piece.title_en = 'O Happy Eyes, op. 18 no. 1',
    piece.type = 'song', piece.opus_number = 'Op. 18 No. 1',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 792 AND piece.composer_id = 64
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- Op. 64 O hearken thou

UPDATE pieces piece
SET piece.title = 'O hearken thou', piece.title_en = 'O hearken thou, op. 64',
    piece.type = 'song', piece.opus_number = 'Op. 64',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 2067 AND piece.composer_id = 64
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None 가곡 <O mightiest of the mighty>

UPDATE pieces piece
SET piece.title = '가곡 <O mightiest of the mighty>', piece.title_en = 'O mightiest of the mighty',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 1241 AND piece.composer_id = 64
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- Op. 11 Offertoire

UPDATE pieces piece
SET piece.title = 'Offertoire', piece.title_en = 'Offertoire, op. 11',
    piece.type = 'song', piece.opus_number = 'Op. 11',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 600 AND piece.composer_id = 64
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Pageant of Empire

UPDATE pieces piece
SET piece.title = 'Pageant of Empire', piece.title_en = 'Pageant of Empire',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 2601 AND piece.composer_id = 64
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'Shakespeare''s Kingdom', part.name_en = 'Pageant of Empire, No. 1: Shakespeare''s Kingdom',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 2601 AND p.composer_id = 64 AND part.part_key = 'musicbrainz:da97e429-971c-4723-833d-cbde735338c8' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:da97e429-971c-4723-833d-cbde735338c8', 1, NULL, 'Shakespeare''s Kingdom', 'Pageant of Empire, No. 1: Shakespeare''s Kingdom', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 2601 AND p.composer_id = 64
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:da97e429-971c-4723-833d-cbde735338c8'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'The Islands: A Song of New Zealand', part.name_en = 'Pageant of Empire, No. 2: The Islands: A Song of New Zealand',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 2601 AND p.composer_id = 64 AND part.part_key = 'musicbrainz:ad8b133e-e2d5-4c0d-b513-e179113e22d0' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:ad8b133e-e2d5-4c0d-b513-e179113e22d0', 2, NULL, 'The Islands: A Song of New Zealand', 'Pageant of Empire, No. 2: The Islands: A Song of New Zealand', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 2601 AND p.composer_id = 64
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:ad8b133e-e2d5-4c0d-b513-e179113e22d0'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = NULL,
    part.name_ko = 'The Blue Mountains: A Song of Australia', part.name_en = 'Pageant of Empire, No. 3: The Blue Mountains: A Song of Australia',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 2601 AND p.composer_id = 64 AND part.part_key = 'musicbrainz:f918e53d-d913-43c4-b67a-41e9f032d04d' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:f918e53d-d913-43c4-b67a-41e9f032d04d', 3, NULL, 'The Blue Mountains: A Song of Australia', 'Pageant of Empire, No. 3: The Blue Mountains: A Song of Australia', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 2601 AND p.composer_id = 64
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:f918e53d-d913-43c4-b67a-41e9f032d04d'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = NULL,
    part.name_ko = 'The Heart of Canada', part.name_en = 'Pageant of Empire, No. 4: The Heart of Canada',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 2601 AND p.composer_id = 64 AND part.part_key = 'musicbrainz:824d5bbb-bc5b-4b82-afc6-82d61180e6e8' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:824d5bbb-bc5b-4b82-afc6-82d61180e6e8', 4, NULL, 'The Heart of Canada', 'Pageant of Empire, No. 4: The Heart of Canada', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 2601 AND p.composer_id = 64
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:824d5bbb-bc5b-4b82-afc6-82d61180e6e8'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 5, part.movement_number = NULL,
    part.name_ko = 'Sailing Westward', part.name_en = 'Pageant of Empire, No. 5: Sailing Westward',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 2601 AND p.composer_id = 64 AND part.part_key = 'musicbrainz:a90a544e-2b8a-4893-a36e-b9cdc4a72f7f' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:a90a544e-2b8a-4893-a36e-b9cdc4a72f7f', 5, NULL, 'Sailing Westward', 'Pageant of Empire, No. 5: Sailing Westward', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 2601 AND p.composer_id = 64
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:a90a544e-2b8a-4893-a36e-b9cdc4a72f7f'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 6, part.movement_number = NULL,
    part.name_ko = 'Merchant Adventurers', part.name_en = 'Pageant of Empire, No. 6: Merchant Adventurers',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 2601 AND p.composer_id = 64 AND part.part_key = 'musicbrainz:a7133724-5733-430b-a121-938c24eb93e6' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:a7133724-5733-430b-a121-938c24eb93e6', 6, NULL, 'Merchant Adventurers', 'Pageant of Empire, No. 6: Merchant Adventurers', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 2601 AND p.composer_id = 64
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:a7133724-5733-430b-a121-938c24eb93e6'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 7, part.movement_number = NULL,
    part.name_ko = 'The Immortal Legions', part.name_en = 'Pageant of Empire, No. 7: The Immortal Legions',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 2601 AND p.composer_id = 64 AND part.part_key = 'musicbrainz:04541bac-c223-4267-a650-2efed4dc3562' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:04541bac-c223-4267-a650-2efed4dc3562', 7, NULL, 'The Immortal Legions', 'Pageant of Empire, No. 7: The Immortal Legions', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 2601 AND p.composer_id = 64
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:04541bac-c223-4267-a650-2efed4dc3562'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 8, part.movement_number = NULL,
    part.name_ko = 'A Song of Union', part.name_en = 'Pageant of Empire, No. 8: A Song of Union',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 2601 AND p.composer_id = 64 AND part.part_key = 'musicbrainz:252f96d1-6637-4ec4-acb8-f10c13999ca4' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:252f96d1-6637-4ec4-acb8-f10c13999ca4', 8, NULL, 'A Song of Union', 'Pageant of Empire, No. 8: A Song of Union', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 2601 AND p.composer_id = 64
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:252f96d1-6637-4ec4-acb8-f10c13999ca4'
);


-- Op. 48 가곡 <Pleading>

UPDATE pieces piece
SET piece.title = '가곡 <Pleading>', piece.title_en = 'Pleading, op. 48',
    piece.type = 'song', piece.opus_number = 'Op. 48',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 2057 AND piece.composer_id = 64
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- Op. 76 Polonia

UPDATE pieces piece
SET piece.title = 'Polonia', piece.title_en = 'Polonia, op. 76',
    piece.type = 'song', piece.opus_number = 'Op. 76',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 734 AND piece.composer_id = 64
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- Op. 39 Pomp and Circumstance Military Marches Op. 39

UPDATE pieces piece
SET piece.title = 'Pomp and Circumstance Military Marches Op. 39', piece.title_en = 'Pomp and Circumstance Military Marches, op. 39',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = 'Op.', piece.catalogue_number = '39',
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 669 AND piece.composer_id = 64
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'D장조', part.name_en = 'Pomp and Circumstance Military Marches, op. 39: March no. 1 in D major',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 669 AND p.composer_id = 64 AND part.part_key = 'musicbrainz:b1b15406-c585-3d3c-8ccc-0850d450f5c7' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:b1b15406-c585-3d3c-8ccc-0850d450f5c7', 1, NULL, 'D장조', 'Pomp and Circumstance Military Marches, op. 39: March no. 1 in D major', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 669 AND p.composer_id = 64
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:b1b15406-c585-3d3c-8ccc-0850d450f5c7'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'A단조', part.name_en = 'Pomp and Circumstance Military Marches, op. 39: March no. 2 in A minor',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 669 AND p.composer_id = 64 AND part.part_key = 'musicbrainz:4854a9e3-c2a5-3e59-a50f-50b03b88d053' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:4854a9e3-c2a5-3e59-a50f-50b03b88d053', 2, NULL, 'A단조', 'Pomp and Circumstance Military Marches, op. 39: March no. 2 in A minor', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 669 AND p.composer_id = 64
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:4854a9e3-c2a5-3e59-a50f-50b03b88d053'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = NULL,
    part.name_ko = 'C단조', part.name_en = 'Pomp and Circumstance Military Marches, op. 39: March no. 3 in C minor',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 669 AND p.composer_id = 64 AND part.part_key = 'musicbrainz:eaa3724e-20c0-40c1-a6bb-bfbaa7de1a59' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:eaa3724e-20c0-40c1-a6bb-bfbaa7de1a59', 3, NULL, 'C단조', 'Pomp and Circumstance Military Marches, op. 39: March no. 3 in C minor', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 669 AND p.composer_id = 64
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:eaa3724e-20c0-40c1-a6bb-bfbaa7de1a59'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = NULL,
    part.name_ko = 'G장조', part.name_en = 'Pomp and Circumstance Military Marches, op. 39: March no. 4 in G major',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 669 AND p.composer_id = 64 AND part.part_key = 'musicbrainz:10721511-5b25-3303-a5a0-dc351fb3c18e' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:10721511-5b25-3303-a5a0-dc351fb3c18e', 4, NULL, 'G장조', 'Pomp and Circumstance Military Marches, op. 39: March no. 4 in G major', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 669 AND p.composer_id = 64
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:10721511-5b25-3303-a5a0-dc351fb3c18e'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 5, part.movement_number = NULL,
    part.name_ko = 'C장조', part.name_en = 'Pomp and Circumstance Military Marches, op. 39: March no. 5 in C major',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 669 AND p.composer_id = 64 AND part.part_key = 'musicbrainz:26721114-a7e0-384a-bca9-bb23aea5c32a' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:26721114-a7e0-384a-bca9-bb23aea5c32a', 5, NULL, 'C장조', 'Pomp and Circumstance Military Marches, op. 39: March no. 5 in C major', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 669 AND p.composer_id = 64
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:26721114-a7e0-384a-bca9-bb23aea5c32a'
);


-- Op. 67 Psalm 48 “Great is the Lord”

UPDATE pieces piece
SET piece.title = 'Psalm 48 “Great is the Lord”', piece.title_en = 'Psalm 48 “Great is the Lord”, op. 67',
    piece.type = 'song', piece.opus_number = 'Op. 67',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 557 AND piece.composer_id = 64
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None 가곡 <Queen Mary's Song>

UPDATE pieces piece
SET piece.title = '가곡 <Queen Mary''s Song>', piece.title_en = 'Queen Mary''s Song',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 1949 AND piece.composer_id = 64
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Reminiscences

UPDATE pieces piece
SET piece.title = 'Reminiscences', piece.title_en = 'Reminiscences',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 1393 AND piece.composer_id = 64
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- Op. 12 가곡 <Salut d’amour>

UPDATE pieces piece
SET piece.title = '가곡 <Salut d’amour>', piece.title_en = 'Salut d’amour (opus 12)',
    piece.type = 'song', piece.opus_number = 'Op. 12',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 1964 AND piece.composer_id = 64
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- Op. 30 칸타타 <Scenes from the Saga of King Olaf> Op. 30

UPDATE pieces piece
SET piece.title = '칸타타 <Scenes from the Saga of King Olaf> Op. 30', piece.title_en = 'Scenes from the Saga of King Olaf, op. 30',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = 'Op.', piece.catalogue_number = '30',
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 865 AND piece.composer_id = 64
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'Introduction. "There is a wondrous book"', part.name_en = 'Scenes from the Saga of King Olaf, op. 30: Introduction. "There is a wondrous book"',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 865 AND p.composer_id = 64 AND part.part_key = 'musicbrainz:9714b0ce-1eef-4115-952d-daa12d58df51' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:9714b0ce-1eef-4115-952d-daa12d58df51', 1, NULL, 'Introduction. "There is a wondrous book"', 'Scenes from the Saga of King Olaf, op. 30: Introduction. "There is a wondrous book"', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 865 AND p.composer_id = 64
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:9714b0ce-1eef-4115-952d-daa12d58df51'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'Introduction. Recitative "Summon now the God of Thunder"', part.name_en = 'Scenes from the Saga of King Olaf, op. 30: No. 1. Introduction. Recitative "Summon now the God of Thunder"',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 865 AND p.composer_id = 64 AND part.part_key = 'musicbrainz:e946e448-bcd2-42da-b2d9-a34b29ac1df4' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:e946e448-bcd2-42da-b2d9-a34b29ac1df4', 2, NULL, 'Introduction. Recitative "Summon now the God of Thunder"', 'Scenes from the Saga of King Olaf, op. 30: No. 1. Introduction. Recitative "Summon now the God of Thunder"', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 865 AND p.composer_id = 64
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:e946e448-bcd2-42da-b2d9-a34b29ac1df4'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = NULL,
    part.name_ko = 'The Challenge of Thor. Chorus "I am the God Thor"', part.name_en = 'Scenes from the Saga of King Olaf, op. 30: No. 2. The Challenge of Thor. Chorus "I am the God Thor"',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 865 AND p.composer_id = 64 AND part.part_key = 'musicbrainz:a4caf2b7-6ee7-4e8d-a3b5-d09ac0c8b164' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:a4caf2b7-6ee7-4e8d-a3b5-d09ac0c8b164', 3, NULL, 'The Challenge of Thor. Chorus "I am the God Thor"', 'Scenes from the Saga of King Olaf, op. 30: No. 2. The Challenge of Thor. Chorus "I am the God Thor"', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 865 AND p.composer_id = 64
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:a4caf2b7-6ee7-4e8d-a3b5-d09ac0c8b164'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = NULL,
    part.name_ko = 'King Olaf''s Return. Solo "And King Olaf heard the cry"', part.name_en = 'Scenes from the Saga of King Olaf, op. 30: No. 3. King Olaf''s Return. Solo "And King Olaf heard the cry"',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 865 AND p.composer_id = 64 AND part.part_key = 'musicbrainz:3221a7e6-cdff-4b77-89eb-df53733baeb1' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:3221a7e6-cdff-4b77-89eb-df53733baeb1', 4, NULL, 'King Olaf''s Return. Solo "And King Olaf heard the cry"', 'Scenes from the Saga of King Olaf, op. 30: No. 3. King Olaf''s Return. Solo "And King Olaf heard the cry"', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 865 AND p.composer_id = 64
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:3221a7e6-cdff-4b77-89eb-df53733baeb1'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 5, part.movement_number = NULL,
    part.name_ko = 'King Olaf''s Return. Recitative "Tell how Olaf bore the Cross"', part.name_en = 'Scenes from the Saga of King Olaf, op. 30: No. 4. King Olaf''s Return. Recitative "Tell how Olaf bore the Cross"',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 865 AND p.composer_id = 64 AND part.part_key = 'musicbrainz:efa169a1-f849-443e-b32c-525b3d247856' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:efa169a1-f849-443e-b32c-525b3d247856', 5, NULL, 'King Olaf''s Return. Recitative "Tell how Olaf bore the Cross"', 'Scenes from the Saga of King Olaf, op. 30: No. 4. King Olaf''s Return. Recitative "Tell how Olaf bore the Cross"', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 865 AND p.composer_id = 64
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:efa169a1-f849-443e-b32c-525b3d247856'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 6, part.movement_number = NULL,
    part.name_ko = 'Conversation. Scene. Chorus "King Olaf''s prows at Nidaros"', part.name_en = 'Scenes from the Saga of King Olaf, op. 30: No. 5. Conversation. Scene. Chorus "King Olaf''s prows at Nidaros"',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 865 AND p.composer_id = 64 AND part.part_key = 'musicbrainz:7d03d681-2df1-41c2-93b7-d0cbeaa2364b' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:7d03d681-2df1-41c2-93b7-d0cbeaa2364b', 6, NULL, 'Conversation. Scene. Chorus "King Olaf''s prows at Nidaros"', 'Scenes from the Saga of King Olaf, op. 30: No. 5. Conversation. Scene. Chorus "King Olaf''s prows at Nidaros"', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 865 AND p.composer_id = 64
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:7d03d681-2df1-41c2-93b7-d0cbeaa2364b'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 7, part.movement_number = NULL,
    part.name_ko = 'The Conversion. Recitative "Now the child of Ironbeard dead"', part.name_en = 'Scenes from the Saga of King Olaf, op. 30: No. 6. The Conversion. Recitative "Now the child of Ironbeard dead"',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 865 AND p.composer_id = 64 AND part.part_key = 'musicbrainz:7f4ad08a-3570-4a43-9f49-0191a40fb0c2' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:7f4ad08a-3570-4a43-9f49-0191a40fb0c2', 7, NULL, 'The Conversion. Recitative "Now the child of Ironbeard dead"', 'Scenes from the Saga of King Olaf, op. 30: No. 6. The Conversion. Recitative "Now the child of Ironbeard dead"', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 865 AND p.composer_id = 64
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:7f4ad08a-3570-4a43-9f49-0191a40fb0c2'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 8, part.movement_number = NULL,
    part.name_ko = 'Gudrun. Scene. Soprano "On King Olaf''s bridal night"', part.name_en = 'Scenes from the Saga of King Olaf, op. 30: No. 7. Gudrun. Scene. Soprano "On King Olaf''s bridal night"',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 865 AND p.composer_id = 64 AND part.part_key = 'musicbrainz:c4ab23bb-6ff5-4d57-9380-8260b09fb9d8' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:c4ab23bb-6ff5-4d57-9380-8260b09fb9d8', 8, NULL, 'Gudrun. Scene. Soprano "On King Olaf''s bridal night"', 'Scenes from the Saga of King Olaf, op. 30: No. 7. Gudrun. Scene. Soprano "On King Olaf''s bridal night"', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 865 AND p.composer_id = 64
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:c4ab23bb-6ff5-4d57-9380-8260b09fb9d8'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 9, part.movement_number = NULL,
    part.name_ko = 'Gudrun. Recitative "How the Wraith of Odin old"', part.name_en = 'Scenes from the Saga of King Olaf, op. 30: No. 8. Gudrun. Recitative "How the Wraith of Odin old"',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 865 AND p.composer_id = 64 AND part.part_key = 'musicbrainz:ca41db73-29dd-43f7-9346-b25eae9cac3f' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:ca41db73-29dd-43f7-9346-b25eae9cac3f', 9, NULL, 'Gudrun. Recitative "How the Wraith of Odin old"', 'Scenes from the Saga of King Olaf, op. 30: No. 8. Gudrun. Recitative "How the Wraith of Odin old"', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 865 AND p.composer_id = 64
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:ca41db73-29dd-43f7-9346-b25eae9cac3f'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 10, part.movement_number = NULL,
    part.name_ko = 'The Wraith of Odin. Chorus "The guests were loud, the ale was strong"', part.name_en = 'Scenes from the Saga of King Olaf, op. 30: No. 9. The Wraith of Odin. Chorus "The guests were loud, the ale was strong"',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 865 AND p.composer_id = 64 AND part.part_key = 'musicbrainz:8611cc7b-483a-477f-92b4-8d0a576ad5ea' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:8611cc7b-483a-477f-92b4-8d0a576ad5ea', 10, NULL, 'The Wraith of Odin. Chorus "The guests were loud, the ale was strong"', 'Scenes from the Saga of King Olaf, op. 30: No. 9. The Wraith of Odin. Chorus "The guests were loud, the ale was strong"', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 865 AND p.composer_id = 64
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:8611cc7b-483a-477f-92b4-8d0a576ad5ea'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 11, part.movement_number = NULL,
    part.name_ko = 'The Wraith of Odin. Recitative "Sisters, sing ye now the song"', part.name_en = 'Scenes from the Saga of King Olaf, op. 30: No. 10. The Wraith of Odin. Recitative "Sisters, sing ye now the song"',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 865 AND p.composer_id = 64 AND part.part_key = 'musicbrainz:6369f0ed-550e-42dd-baf0-56d221ae6679' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:6369f0ed-550e-42dd-baf0-56d221ae6679', 11, NULL, 'The Wraith of Odin. Recitative "Sisters, sing ye now the song"', 'Scenes from the Saga of King Olaf, op. 30: No. 10. The Wraith of Odin. Recitative "Sisters, sing ye now the song"', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 865 AND p.composer_id = 64
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:6369f0ed-550e-42dd-baf0-56d221ae6679'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 12, part.movement_number = NULL,
    part.name_ko = 'Sigrid. Scene. Chorus "Sigrid sits in her high abode"', part.name_en = 'Scenes from the Saga of King Olaf, op. 30: No. 11. Sigrid. Scene. Chorus "Sigrid sits in her high abode"',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 865 AND p.composer_id = 64 AND part.part_key = 'musicbrainz:f4242133-1cfa-4e8a-835e-ad801ebfb5dc' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:f4242133-1cfa-4e8a-835e-ad801ebfb5dc', 12, NULL, 'Sigrid. Scene. Chorus "Sigrid sits in her high abode"', 'Scenes from the Saga of King Olaf, op. 30: No. 11. Sigrid. Scene. Chorus "Sigrid sits in her high abode"', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 865 AND p.composer_id = 64
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:f4242133-1cfa-4e8a-835e-ad801ebfb5dc'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 13, part.movement_number = NULL,
    part.name_ko = 'Recitative "Hark! She flies from Wendland forth"', part.name_en = 'Scenes from the Saga of King Olaf, op. 30: No. 12. Recitative "Hark! She flies from Wendland forth"',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 865 AND p.composer_id = 64 AND part.part_key = 'musicbrainz:4c27841e-2096-4603-b1c6-ff3f6dda4bb0' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:4c27841e-2096-4603-b1c6-ff3f6dda4bb0', 13, NULL, 'Recitative "Hark! She flies from Wendland forth"', 'Scenes from the Saga of King Olaf, op. 30: No. 12. Recitative "Hark! She flies from Wendland forth"', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 865 AND p.composer_id = 64
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:4c27841e-2096-4603-b1c6-ff3f6dda4bb0'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 14, part.movement_number = NULL,
    part.name_ko = 'Thyri. Chorus "A little bird in the air"', part.name_en = 'Scenes from the Saga of King Olaf, op. 30: No. 13. Thyri. Chorus "A little bird in the air"',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 865 AND p.composer_id = 64 AND part.part_key = 'musicbrainz:976d21da-5d5c-446a-90ec-0ca0f4bef7b9' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:976d21da-5d5c-446a-90ec-0ca0f4bef7b9', 14, NULL, 'Thyri. Chorus "A little bird in the air"', 'Scenes from the Saga of King Olaf, op. 30: No. 13. Thyri. Chorus "A little bird in the air"', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 865 AND p.composer_id = 64
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:976d21da-5d5c-446a-90ec-0ca0f4bef7b9'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 15, part.movement_number = NULL,
    part.name_ko = 'Thyri. Duet "The gray land breaks to lively green"', part.name_en = 'Scenes from the Saga of King Olaf, op. 30: No. 14. Thyri. Duet "The gray land breaks to lively green"',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 865 AND p.composer_id = 64 AND part.part_key = 'musicbrainz:05add57b-b585-468c-b5aa-5828a560e7da' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:05add57b-b585-468c-b5aa-5828a560e7da', 15, NULL, 'Thyri. Duet "The gray land breaks to lively green"', 'Scenes from the Saga of King Olaf, op. 30: No. 14. Thyri. Duet "The gray land breaks to lively green"', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 865 AND p.composer_id = 64
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:05add57b-b585-468c-b5aa-5828a560e7da'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 16, part.movement_number = NULL,
    part.name_ko = 'Thyri. Choral Recitative “After Queen Gunhild’s death”', part.name_en = 'Scenes from the Saga of King Olaf, op. 30: No. 15. Thyri. Choral Recitative “After Queen Gunhild’s death”',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 865 AND p.composer_id = 64 AND part.part_key = 'musicbrainz:7e6f87f9-ee29-4610-9cb1-376f4fd27306' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:7e6f87f9-ee29-4610-9cb1-376f4fd27306', 16, NULL, 'Thyri. Choral Recitative “After Queen Gunhild’s death”', 'Scenes from the Saga of King Olaf, op. 30: No. 15. Thyri. Choral Recitative “After Queen Gunhild’s death”', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 865 AND p.composer_id = 64
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:7e6f87f9-ee29-4610-9cb1-376f4fd27306'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 17, part.movement_number = NULL,
    part.name_ko = 'The Death of Olaf. Chorus “King Olaf’s dragons take the sea”', part.name_en = 'Scenes from the Saga of King Olaf, op. 30: No. 16. The Death of Olaf. Chorus “King Olaf’s dragons take the sea”',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 865 AND p.composer_id = 64 AND part.part_key = 'musicbrainz:0e6e4ec6-734e-4cf6-8070-08c69aa75415' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:0e6e4ec6-734e-4cf6-8070-08c69aa75415', 17, NULL, 'The Death of Olaf. Chorus “King Olaf’s dragons take the sea”', 'Scenes from the Saga of King Olaf, op. 30: No. 16. The Death of Olaf. Chorus “King Olaf’s dragons take the sea”', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 865 AND p.composer_id = 64
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:0e6e4ec6-734e-4cf6-8070-08c69aa75415'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 18, part.movement_number = NULL,
    part.name_ko = 'Epilogue. Soli and Chorus. Recitative “In the convent of Drontheim”', part.name_en = 'Scenes from the Saga of King Olaf, op. 30: Epilogue. Soli and Chorus. Recitative “In the convent of Drontheim”',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 865 AND p.composer_id = 64 AND part.part_key = 'musicbrainz:ab1bdf98-8f8f-41ae-b64a-952321813edc' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:ab1bdf98-8f8f-41ae-b64a-952321813edc', 18, NULL, 'Epilogue. Soli and Chorus. Recitative “In the convent of Drontheim”', 'Scenes from the Saga of King Olaf, op. 30: Epilogue. Soli and Chorus. Recitative “In the convent of Drontheim”', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 865 AND p.composer_id = 64
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:ab1bdf98-8f8f-41ae-b64a-952321813edc'
);


-- Op. 37 연가곡집 <Sea Pictures>

UPDATE pieces piece
SET piece.title = '연가곡집 <Sea Pictures>', piece.title_en = 'Sea Pictures, op. 37',
    piece.type = 'album', piece.opus_number = 'Op. 37',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 846 AND piece.composer_id = 64
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'Sea Slumber Song', part.name_en = 'Sea Pictures, op. 37: I. Sea Slumber Song',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 846 AND p.composer_id = 64 AND part.part_key = 'musicbrainz:3a9b2f9a-d5af-3b6a-9218-c06c68fe3b5a' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:3a9b2f9a-d5af-3b6a-9218-c06c68fe3b5a', 1, 'I', 'Sea Slumber Song', 'Sea Pictures, op. 37: I. Sea Slumber Song', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 846 AND p.composer_id = 64
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:3a9b2f9a-d5af-3b6a-9218-c06c68fe3b5a'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'In Haven (Capri)', part.name_en = 'Sea Pictures, op. 37: II. In Haven (Capri)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 846 AND p.composer_id = 64 AND part.part_key = 'musicbrainz:bd872673-697b-3283-a3a4-5b7767b056c8' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:bd872673-697b-3283-a3a4-5b7767b056c8', 2, 'II', 'In Haven (Capri)', 'Sea Pictures, op. 37: II. In Haven (Capri)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 846 AND p.composer_id = 64
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:bd872673-697b-3283-a3a4-5b7767b056c8'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = 'Sabbath Morning at Sea', part.name_en = 'Sea Pictures, op. 37: III. Sabbath Morning at Sea',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 846 AND p.composer_id = 64 AND part.part_key = 'musicbrainz:eb42c12e-a5b2-3855-aa79-a397f6550389' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:eb42c12e-a5b2-3855-aa79-a397f6550389', 3, 'III', 'Sabbath Morning at Sea', 'Sea Pictures, op. 37: III. Sabbath Morning at Sea', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 846 AND p.composer_id = 64
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:eb42c12e-a5b2-3855-aa79-a397f6550389'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = 'IV',
    part.name_ko = 'Where Corals Lie', part.name_en = 'Sea Pictures, op. 37: IV. Where Corals Lie',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 846 AND p.composer_id = 64 AND part.part_key = 'musicbrainz:39b74d42-3062-323d-ab42-33ec968f112e' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:39b74d42-3062-323d-ab42-33ec968f112e', 4, 'IV', 'Where Corals Lie', 'Sea Pictures, op. 37: IV. Where Corals Lie', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 846 AND p.composer_id = 64
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:39b74d42-3062-323d-ab42-33ec968f112e'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 5, part.movement_number = 'V',
    part.name_ko = 'The Swimmer', part.name_en = 'Sea Pictures, op. 37: V. The Swimmer',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 846 AND p.composer_id = 64 AND part.part_key = 'musicbrainz:874f56bb-b1f1-3969-95df-333fa6ac374f' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:874f56bb-b1f1-3969-95df-333fa6ac374f', 5, 'V', 'The Swimmer', 'Sea Pictures, op. 37: V. The Swimmer', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 846 AND p.composer_id = 64
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:874f56bb-b1f1-3969-95df-333fa6ac374f'
);


-- Op. 7 Sevillaña (Scène Espagnole)

UPDATE pieces piece
SET piece.title = 'Sevillaña (Scène Espagnole)', piece.title_en = 'Sevillaña (Scène Espagnole), op. 7',
    piece.type = 'song', piece.opus_number = 'Op. 7',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 1321 AND piece.composer_id = 64
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Skizze

UPDATE pieces piece
SET piece.title = 'Skizze', piece.title_en = 'Skizze',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 2940 AND piece.composer_id = 64
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None 칸타타 <Smoking Cantata>

UPDATE pieces piece
SET piece.title = '칸타타 <Smoking Cantata>', piece.title_en = 'Smoking Cantata',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 1583 AND piece.composer_id = 64
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- Op. 82 바이올린과 피아노를 위한 소나타 E단조

UPDATE pieces piece
SET piece.title = '바이올린과 피아노를 위한 소나타 E단조', piece.title_en = 'Sonata for Violin and Piano in E minor, op. 82',
    piece.type = 'album', piece.opus_number = 'Op. 82',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 521 AND piece.composer_id = 64
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'Allegro', part.name_en = 'Sonata for Violin and Piano in E minor, op. 82: I. Allegro',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 521 AND p.composer_id = 64 AND part.part_key = 'musicbrainz:af0964b6-8da0-4ba2-929c-b8d4108076a8' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:af0964b6-8da0-4ba2-929c-b8d4108076a8', 1, 'I', 'Allegro', 'Sonata for Violin and Piano in E minor, op. 82: I. Allegro', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 521 AND p.composer_id = 64
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:af0964b6-8da0-4ba2-929c-b8d4108076a8'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'Romance: Andante', part.name_en = 'Sonata for Violin and Piano in E minor, op. 82: II. Romance: Andante',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 521 AND p.composer_id = 64 AND part.part_key = 'musicbrainz:33df057a-42ee-49d2-8d55-e65781055411' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:33df057a-42ee-49d2-8d55-e65781055411', 2, 'II', 'Romance: Andante', 'Sonata for Violin and Piano in E minor, op. 82: II. Romance: Andante', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 521 AND p.composer_id = 64
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:33df057a-42ee-49d2-8d55-e65781055411'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = 'Allegro non troppo', part.name_en = 'Sonata for Violin and Piano in E minor, op. 82: III. Allegro non troppo',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 521 AND p.composer_id = 64 AND part.part_key = 'musicbrainz:d3ee1fd8-573b-4ebf-aff7-bc49adc805dd' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:d3ee1fd8-573b-4ebf-aff7-bc49adc805dd', 3, 'III', 'Allegro non troppo', 'Sonata for Violin and Piano in E minor, op. 82: III. Allegro non troppo', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 521 AND p.composer_id = 64
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:d3ee1fd8-573b-4ebf-aff7-bc49adc805dd'
);


-- None 소나티네 G장조

UPDATE pieces piece
SET piece.title = '소나티네 G장조', piece.title_en = 'Sonatina in G major',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 2544 AND piece.composer_id = 64
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'Andantino', part.name_en = 'Sonatina in G major: I. Andantino',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 2544 AND p.composer_id = 64 AND part.part_key = 'musicbrainz:8bf22fb7-2ebc-4afd-b6eb-91b11bdec5f6' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:8bf22fb7-2ebc-4afd-b6eb-91b11bdec5f6', 1, 'I', 'Andantino', 'Sonatina in G major: I. Andantino', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 2544 AND p.composer_id = 64
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:8bf22fb7-2ebc-4afd-b6eb-91b11bdec5f6'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'Allegro', part.name_en = 'Sonatina in G major: II. Allegro',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 2544 AND p.composer_id = 64 AND part.part_key = 'musicbrainz:ee7a32eb-2e4f-48eb-8c7e-bccc448b589d' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:ee7a32eb-2e4f-48eb-8c7e-bccc448b589d', 2, 'II', 'Allegro', 'Sonatina in G major: II. Allegro', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 2544 AND p.composer_id = 64
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:ee7a32eb-2e4f-48eb-8c7e-bccc448b589d'
);


-- Op. 31 No. 2 가곡 <Song of Flight>

UPDATE pieces piece
SET piece.title = '가곡 <Song of Flight>', piece.title_en = 'Song of Flight, op. 31 no. 2',
    piece.type = 'song', piece.opus_number = 'Op. 31 No. 2',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 2012 AND piece.composer_id = 64
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- Op. 59 가곡 Op. 59

UPDATE pieces piece
SET piece.title = '가곡 Op. 59', piece.title_en = 'Songs, op. 59',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = 'Op.', piece.catalogue_number = '59',
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 1584 AND piece.composer_id = 64
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'Oh, Soft Was the Song, op. 59 no. 3', part.name_en = 'Oh, Soft Was the Song, op. 59 no. 3',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 1584 AND p.composer_id = 64 AND part.part_key = 'musicbrainz:cbc44b91-399a-4768-8074-d6274bf6ee20' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:cbc44b91-399a-4768-8074-d6274bf6ee20', 1, NULL, 'Oh, Soft Was the Song, op. 59 no. 3', 'Oh, Soft Was the Song, op. 59 no. 3', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 1584 AND p.composer_id = 64
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:cbc44b91-399a-4768-8074-d6274bf6ee20'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'Was It Some Golden Star?, op. 59 no. 5', part.name_en = 'Was It Some Golden Star?, op. 59 no. 5',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 1584 AND p.composer_id = 64 AND part.part_key = 'musicbrainz:dcb924aa-d766-44fe-9786-6c4fd38020a0' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:dcb924aa-d766-44fe-9786-6c4fd38020a0', 2, NULL, 'Was It Some Golden Star?, op. 59 no. 5', 'Was It Some Golden Star?, op. 59 no. 5', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 1584 AND p.composer_id = 64
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:dcb924aa-d766-44fe-9786-6c4fd38020a0'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = NULL,
    part.name_ko = 'Twilight, op. 59 no. 6', part.name_en = 'Twilight, op. 59 no. 6',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 1584 AND p.composer_id = 64 AND part.part_key = 'musicbrainz:7445c83f-ff90-4bb4-95af-6bdabb910df3' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:7445c83f-ff90-4bb4-95af-6bdabb910df3', 3, NULL, 'Twilight, op. 59 no. 6', 'Twilight, op. 59 no. 6', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 1584 AND p.composer_id = 64
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:7445c83f-ff90-4bb4-95af-6bdabb910df3'
);


-- Op. 23 Spanish Serenade

UPDATE pieces piece
SET piece.title = 'Spanish Serenade', piece.title_en = 'Spanish Serenade, op. 23',
    piece.type = 'song', piece.opus_number = 'Op. 23',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 1881 AND piece.composer_id = 64
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Speak, my Heart!

UPDATE pieces piece
SET piece.title = 'Speak, my Heart!', piece.title_en = 'Speak, my Heart!',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 1618 AND piece.composer_id = 64
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- Op. 83 현악 4중주 E단조

UPDATE pieces piece
SET piece.title = '현악 4중주 E단조', piece.title_en = 'String Quartet in E minor, op. 83',
    piece.type = 'album', piece.opus_number = 'Op. 83',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 741 AND piece.composer_id = 64
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'Allegro moderato', part.name_en = 'String Quartet in E minor, op. 83: I. Allegro moderato',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 741 AND p.composer_id = 64 AND part.part_key = 'musicbrainz:164c4462-a18b-36a8-9da4-4c8f882f4cb6' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:164c4462-a18b-36a8-9da4-4c8f882f4cb6', 1, 'I', 'Allegro moderato', 'String Quartet in E minor, op. 83: I. Allegro moderato', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 741 AND p.composer_id = 64
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:164c4462-a18b-36a8-9da4-4c8f882f4cb6'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'Piacevole (poco andante)', part.name_en = 'String Quartet in E minor, op. 83: II. Piacevole (poco andante)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 741 AND p.composer_id = 64 AND part.part_key = 'musicbrainz:0ef41818-bd24-371a-8425-61ab697e6032' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:0ef41818-bd24-371a-8425-61ab697e6032', 2, 'II', 'Piacevole (poco andante)', 'String Quartet in E minor, op. 83: II. Piacevole (poco andante)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 741 AND p.composer_id = 64
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:0ef41818-bd24-371a-8425-61ab697e6032'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = 'Allegro molto', part.name_en = 'String Quartet in E minor, op. 83: III. Allegro molto',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 741 AND p.composer_id = 64 AND part.part_key = 'musicbrainz:7f4ad32f-d8a0-3d7a-83dd-510519dc7207' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:7f4ad32f-d8a0-3d7a-83dd-510519dc7207', 3, 'III', 'Allegro molto', 'String Quartet in E minor, op. 83: III. Allegro molto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 741 AND p.composer_id = 64
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:7f4ad32f-d8a0-3d7a-83dd-510519dc7207'
);


-- Op. 11 Sursum corda

UPDATE pieces piece
SET piece.title = 'Sursum corda', piece.title_en = 'Sursum corda, op. 11',
    piece.type = 'song', piece.opus_number = 'Op. 11',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 2242 AND piece.composer_id = 64
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- Op. 55 교향곡 1번 A♭장조

UPDATE pieces piece
SET piece.title = '교향곡 1번 A♭장조', piece.title_en = 'Symphony no. 1 in A-flat major, op. 55',
    piece.type = 'album', piece.opus_number = 'Op. 55',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 732 AND piece.composer_id = 64
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'Andante. Nobilmente e semplice', part.name_en = 'Symphony no. 1 in A-flat major, op. 55: I. Andante. Nobilmente e semplice',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 732 AND p.composer_id = 64 AND part.part_key = 'musicbrainz:2aebd0cc-2717-36af-ac00-c0244ab56269' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:2aebd0cc-2717-36af-ac00-c0244ab56269', 1, 'I', 'Andante. Nobilmente e semplice', 'Symphony no. 1 in A-flat major, op. 55: I. Andante. Nobilmente e semplice', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 732 AND p.composer_id = 64
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:2aebd0cc-2717-36af-ac00-c0244ab56269'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'Allegro molto', part.name_en = 'Symphony no. 1 in A-flat major, op. 55: II. Allegro molto',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 732 AND p.composer_id = 64 AND part.part_key = 'musicbrainz:1d329eff-f6bc-3a05-9457-2a20d6fb60b3' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:1d329eff-f6bc-3a05-9457-2a20d6fb60b3', 2, 'II', 'Allegro molto', 'Symphony no. 1 in A-flat major, op. 55: II. Allegro molto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 732 AND p.composer_id = 64
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:1d329eff-f6bc-3a05-9457-2a20d6fb60b3'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = 'Adagio', part.name_en = 'Symphony no. 1 in A-flat major, op. 55: III. Adagio',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 732 AND p.composer_id = 64 AND part.part_key = 'musicbrainz:92cc3836-3a17-35cf-922a-2f4d238b266d' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:92cc3836-3a17-35cf-922a-2f4d238b266d', 3, 'III', 'Adagio', 'Symphony no. 1 in A-flat major, op. 55: III. Adagio', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 732 AND p.composer_id = 64
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:92cc3836-3a17-35cf-922a-2f4d238b266d'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = 'IV',
    part.name_ko = 'Lento - Allegro', part.name_en = 'Symphony no. 1 in A-flat major, op. 55: IV. Lento - Allegro',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 732 AND p.composer_id = 64 AND part.part_key = 'musicbrainz:d7cd5d99-74a7-3685-a4bb-cbdf3e3a6d9e' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:d7cd5d99-74a7-3685-a4bb-cbdf3e3a6d9e', 4, 'IV', 'Lento - Allegro', 'Symphony no. 1 in A-flat major, op. 55: IV. Lento - Allegro', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 732 AND p.composer_id = 64
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:d7cd5d99-74a7-3685-a4bb-cbdf3e3a6d9e'
);


-- Op. 63 교향곡 2번 E♭장조

UPDATE pieces piece
SET piece.title = '교향곡 2번 E♭장조', piece.title_en = 'Symphony no. 2 in E-flat major, op. 63',
    piece.type = 'album', piece.opus_number = 'Op. 63',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 740 AND piece.composer_id = 64
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'Allegro vivace e nobilmente', part.name_en = 'Symphony no. 2 in E-flat major, op. 63: I. Allegro vivace e nobilmente',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 740 AND p.composer_id = 64 AND part.part_key = 'musicbrainz:b09bf94d-b9e1-3c06-af27-f6e4e07178d2' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:b09bf94d-b9e1-3c06-af27-f6e4e07178d2', 1, 'I', 'Allegro vivace e nobilmente', 'Symphony no. 2 in E-flat major, op. 63: I. Allegro vivace e nobilmente', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 740 AND p.composer_id = 64
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:b09bf94d-b9e1-3c06-af27-f6e4e07178d2'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'Larghetto', part.name_en = 'Symphony no. 2 in E-flat major, op. 63: II. Larghetto',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 740 AND p.composer_id = 64 AND part.part_key = 'musicbrainz:19efc7a6-1cfb-3c3b-aa32-57fbc593beef' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:19efc7a6-1cfb-3c3b-aa32-57fbc593beef', 2, 'II', 'Larghetto', 'Symphony no. 2 in E-flat major, op. 63: II. Larghetto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 740 AND p.composer_id = 64
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:19efc7a6-1cfb-3c3b-aa32-57fbc593beef'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = 'Rondo: Presto', part.name_en = 'Symphony no. 2 in E-flat major, op. 63: III. Rondo: Presto',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 740 AND p.composer_id = 64 AND part.part_key = 'musicbrainz:d5daea97-8aae-37d3-9226-f389cc38e755' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:d5daea97-8aae-37d3-9226-f389cc38e755', 3, 'III', 'Rondo: Presto', 'Symphony no. 2 in E-flat major, op. 63: III. Rondo: Presto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 740 AND p.composer_id = 64
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:d5daea97-8aae-37d3-9226-f389cc38e755'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = 'IV',
    part.name_ko = 'Moderato e maestoso', part.name_en = 'Symphony no. 2 in E-flat major, op. 63: IV. Moderato e maestoso',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 740 AND p.composer_id = 64 AND part.part_key = 'musicbrainz:eb405d55-9a2e-3a7f-b0c4-6fca911e568a' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:eb405d55-9a2e-3a7f-b0c4-6fca911e568a', 4, 'IV', 'Moderato e maestoso', 'Symphony no. 2 in E-flat major, op. 63: IV. Moderato e maestoso', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 740 AND p.composer_id = 64
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:eb405d55-9a2e-3a7f-b0c4-6fca911e568a'
);


-- None Sérénade lyrique

UPDATE pieces piece
SET piece.title = 'Sérénade lyrique', piece.title_en = 'Sérénade lyrique',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 960 AND piece.composer_id = 64
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- Op. 49 오라토리오 <The Apostles> Op. 49

UPDATE pieces piece
SET piece.title = '오라토리오 <The Apostles> Op. 49', piece.title_en = 'The Apostles, op. 49',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = 'Op.', piece.catalogue_number = '49',
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 731 AND piece.composer_id = 64
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'Prologue', part.name_en = 'The Apostles, op. 49: Prologue',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 731 AND p.composer_id = 64 AND part.part_key = 'musicbrainz:ffecd302-b526-4f34-9ccb-a7daa5ddc0fd' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:ffecd302-b526-4f34-9ccb-a7daa5ddc0fd', 1, NULL, 'Prologue', 'The Apostles, op. 49: Prologue', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 731 AND p.composer_id = 64
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:ffecd302-b526-4f34-9ccb-a7daa5ddc0fd'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'Part I', part.name_en = 'The Apostles, op. 49: Part I',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 731 AND p.composer_id = 64 AND part.part_key = 'musicbrainz:a9f32e9f-487a-45ca-8c0b-500fb586b952' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:a9f32e9f-487a-45ca-8c0b-500fb586b952', 2, NULL, 'Part I', 'The Apostles, op. 49: Part I', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 731 AND p.composer_id = 64
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:a9f32e9f-487a-45ca-8c0b-500fb586b952'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:a9f32e9f-487a-45ca-8c0b-500fb586b952'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'The Calling of the Apostles', part.name_en = 'The Apostles, op. 49: Part I: I. The Calling of the Apostles',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 731 AND p.composer_id = 64 AND part.part_key = 'musicbrainz:5bcfb697-0df9-4e75-b459-089153855c99' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:5bcfb697-0df9-4e75-b459-089153855c99', 1, NULL, 'The Calling of the Apostles', 'The Apostles, op. 49: Part I: I. The Calling of the Apostles', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:a9f32e9f-487a-45ca-8c0b-500fb586b952'
WHERE p.id = 731 AND p.composer_id = 64
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:5bcfb697-0df9-4e75-b459-089153855c99'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:a9f32e9f-487a-45ca-8c0b-500fb586b952'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'By the Wayside', part.name_en = 'The Apostles, op. 49: Part I: II. By the Wayside',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 731 AND p.composer_id = 64 AND part.part_key = 'musicbrainz:b515ff9b-e3f6-4d25-95d8-77ab46aa8cff' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:b515ff9b-e3f6-4d25-95d8-77ab46aa8cff', 2, NULL, 'By the Wayside', 'The Apostles, op. 49: Part I: II. By the Wayside', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:a9f32e9f-487a-45ca-8c0b-500fb586b952'
WHERE p.id = 731 AND p.composer_id = 64
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:b515ff9b-e3f6-4d25-95d8-77ab46aa8cff'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:a9f32e9f-487a-45ca-8c0b-500fb586b952'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = NULL,
    part.name_ko = 'By the Sea of Galilee', part.name_en = 'The Apostles, op. 49: Part I: III. By the Sea of Galilee',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 731 AND p.composer_id = 64 AND part.part_key = 'musicbrainz:4d91d2e3-92b9-4394-89c6-758b6c508816' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:4d91d2e3-92b9-4394-89c6-758b6c508816', 3, NULL, 'By the Sea of Galilee', 'The Apostles, op. 49: Part I: III. By the Sea of Galilee', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:a9f32e9f-487a-45ca-8c0b-500fb586b952'
WHERE p.id = 731 AND p.composer_id = 64
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:4d91d2e3-92b9-4394-89c6-758b6c508816'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = NULL,
    part.name_ko = 'Part II', part.name_en = 'The Apostles, op. 49: Part II',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 731 AND p.composer_id = 64 AND part.part_key = 'musicbrainz:83a4ddf1-215a-4cc2-a30f-1add46483658' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:83a4ddf1-215a-4cc2-a30f-1add46483658', 3, NULL, 'Part II', 'The Apostles, op. 49: Part II', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 731 AND p.composer_id = 64
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:83a4ddf1-215a-4cc2-a30f-1add46483658'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:83a4ddf1-215a-4cc2-a30f-1add46483658'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'Introduction', part.name_en = 'The Apostles, op. 49: Part II: Introduction',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 731 AND p.composer_id = 64 AND part.part_key = 'musicbrainz:713704e7-9dac-4946-bb8c-b43336e4e2d2' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:713704e7-9dac-4946-bb8c-b43336e4e2d2', 1, NULL, 'Introduction', 'The Apostles, op. 49: Part II: Introduction', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:83a4ddf1-215a-4cc2-a30f-1add46483658'
WHERE p.id = 731 AND p.composer_id = 64
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:713704e7-9dac-4946-bb8c-b43336e4e2d2'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:83a4ddf1-215a-4cc2-a30f-1add46483658'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'The Betrayal', part.name_en = 'The Apostles, op. 49: Part II: IV. The Betrayal',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 731 AND p.composer_id = 64 AND part.part_key = 'musicbrainz:f0ae9748-1e6a-447a-bc4a-202473fb24fb' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:f0ae9748-1e6a-447a-bc4a-202473fb24fb', 2, NULL, 'The Betrayal', 'The Apostles, op. 49: Part II: IV. The Betrayal', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:83a4ddf1-215a-4cc2-a30f-1add46483658'
WHERE p.id = 731 AND p.composer_id = 64
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:f0ae9748-1e6a-447a-bc4a-202473fb24fb'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:83a4ddf1-215a-4cc2-a30f-1add46483658'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = NULL,
    part.name_ko = 'Golgotha', part.name_en = 'The Apostles, op. 49: Part II: V. Golgotha',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 731 AND p.composer_id = 64 AND part.part_key = 'musicbrainz:309461de-29a0-4640-a0a2-89b94c7e55e4' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:309461de-29a0-4640-a0a2-89b94c7e55e4', 3, NULL, 'Golgotha', 'The Apostles, op. 49: Part II: V. Golgotha', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:83a4ddf1-215a-4cc2-a30f-1add46483658'
WHERE p.id = 731 AND p.composer_id = 64
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:309461de-29a0-4640-a0a2-89b94c7e55e4'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:83a4ddf1-215a-4cc2-a30f-1add46483658'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = NULL,
    part.name_ko = 'At the Sepulchre', part.name_en = 'The Apostles, op. 49: Part II: VI. At the Sepulchre',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 731 AND p.composer_id = 64 AND part.part_key = 'musicbrainz:d3c89dc4-b6f2-4404-b1c9-1d3baa2c17c7' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:d3c89dc4-b6f2-4404-b1c9-1d3baa2c17c7', 4, NULL, 'At the Sepulchre', 'The Apostles, op. 49: Part II: VI. At the Sepulchre', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:83a4ddf1-215a-4cc2-a30f-1add46483658'
WHERE p.id = 731 AND p.composer_id = 64
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:d3c89dc4-b6f2-4404-b1c9-1d3baa2c17c7'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:83a4ddf1-215a-4cc2-a30f-1add46483658'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 5, part.movement_number = NULL,
    part.name_ko = 'The Ascension', part.name_en = 'The Apostles, op. 49: Part II: VII. The Ascension',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 731 AND p.composer_id = 64 AND part.part_key = 'musicbrainz:a823b7af-abbe-4f36-b6f1-2f5f89c1b7ed' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:a823b7af-abbe-4f36-b6f1-2f5f89c1b7ed', 5, NULL, 'The Ascension', 'The Apostles, op. 49: Part II: VII. The Ascension', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:83a4ddf1-215a-4cc2-a30f-1add46483658'
WHERE p.id = 731 AND p.composer_id = 64
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:a823b7af-abbe-4f36-b6f1-2f5f89c1b7ed'
);


-- Op. 33 The Banner of St. George Op. 33

UPDATE pieces piece
SET piece.title = 'The Banner of St. George Op. 33', piece.title_en = 'The Banner of St. George, op. 33',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = 'Op.', piece.catalogue_number = '33',
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 1745 AND piece.composer_id = 64
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'Scene I', part.name_en = 'The Banner of St. George, op. 33: Scene I',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 1745 AND p.composer_id = 64 AND part.part_key = 'musicbrainz:b7e7ef44-e220-4967-a8ad-e8bc46b15938' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:b7e7ef44-e220-4967-a8ad-e8bc46b15938', 1, NULL, 'Scene I', 'The Banner of St. George, op. 33: Scene I', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 1745 AND p.composer_id = 64
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:b7e7ef44-e220-4967-a8ad-e8bc46b15938'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'Scene II', part.name_en = 'The Banner of St. George, op. 33: Scene II',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 1745 AND p.composer_id = 64 AND part.part_key = 'musicbrainz:be5cbd62-568e-493c-a497-8345179411f9' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:be5cbd62-568e-493c-a497-8345179411f9', 2, NULL, 'Scene II', 'The Banner of St. George, op. 33: Scene II', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 1745 AND p.composer_id = 64
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:be5cbd62-568e-493c-a497-8345179411f9'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = NULL,
    part.name_ko = 'Epilogue', part.name_en = 'The Banner of St. George, op. 33: Epilogue',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 1745 AND p.composer_id = 64 AND part.part_key = 'musicbrainz:035274fc-fb3c-47f6-9659-0a02ad62cea7' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:035274fc-fb3c-47f6-9659-0a02ad62cea7', 3, NULL, 'Epilogue', 'The Banner of St. George, op. 33: Epilogue', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 1745 AND p.composer_id = 64
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:035274fc-fb3c-47f6-9659-0a02ad62cea7'
);


-- Op. 25 칸타타 <The Black Knight> Op. 25

UPDATE pieces piece
SET piece.title = '칸타타 <The Black Knight> Op. 25', piece.title_en = 'The Black Knight, op. 25',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = 'Op.', piece.catalogue_number = '25',
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 858 AND piece.composer_id = 64
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'Scene I "The Tournament"', part.name_en = 'The Black Knight, op. 25: Scene I "The Tournament"',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 858 AND p.composer_id = 64 AND part.part_key = 'musicbrainz:f3898014-bd9a-4fe2-a85f-2846bc57dbf6' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:f3898014-bd9a-4fe2-a85f-2846bc57dbf6', 1, NULL, 'Scene I "The Tournament"', 'The Black Knight, op. 25: Scene I "The Tournament"', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 858 AND p.composer_id = 64
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:f3898014-bd9a-4fe2-a85f-2846bc57dbf6'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'Scene II "The Entry of the Black Knight"', part.name_en = 'The Black Knight, op. 25: Scene II "The Entry of the Black Knight"',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 858 AND p.composer_id = 64 AND part.part_key = 'musicbrainz:89ddac4c-2a7b-4f21-82c9-df6675be8f5d' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:89ddac4c-2a7b-4f21-82c9-df6675be8f5d', 2, NULL, 'Scene II "The Entry of the Black Knight"', 'The Black Knight, op. 25: Scene II "The Entry of the Black Knight"', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 858 AND p.composer_id = 64
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:89ddac4c-2a7b-4f21-82c9-df6675be8f5d'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = NULL,
    part.name_ko = 'Scene III "The Dance"', part.name_en = 'The Black Knight, op. 25: Scene III "The Dance"',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 858 AND p.composer_id = 64 AND part.part_key = 'musicbrainz:032139f2-6b01-4118-b425-c808fde3fb3c' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:032139f2-6b01-4118-b425-c808fde3fb3c', 3, NULL, 'Scene III "The Dance"', 'The Black Knight, op. 25: Scene III "The Dance"', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 858 AND p.composer_id = 64
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:032139f2-6b01-4118-b425-c808fde3fb3c'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = NULL,
    part.name_ko = 'Scene IV "The Banquet"', part.name_en = 'The Black Knight, op. 25: Scene IV "The Banquet"',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 858 AND p.composer_id = 64 AND part.part_key = 'musicbrainz:5abe0c10-8e13-4f94-8451-7bfd64439de2' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:5abe0c10-8e13-4f94-8451-7bfd64439de2', 4, NULL, 'Scene IV "The Banquet"', 'The Black Knight, op. 25: Scene IV "The Banquet"', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 858 AND p.composer_id = 64
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:5abe0c10-8e13-4f94-8451-7bfd64439de2'
);


-- Op. 78 가곡 <The Blue-Eyes Fairy>

UPDATE pieces piece
SET piece.title = '가곡 <The Blue-Eyes Fairy>', piece.title_en = 'The Blue-Eyes Fairy, op. 78',
    piece.type = 'song', piece.opus_number = 'Op. 78',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 2201 AND piece.composer_id = 64
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None The Chariots of the Lord

UPDATE pieces piece
SET piece.title = 'The Chariots of the Lord', piece.title_en = 'The Chariots of the Lord',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 1543 AND piece.composer_id = 64
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- Op. 38 오라토리오 <The Dream of Gerontius> Op. 38

UPDATE pieces piece
SET piece.title = '오라토리오 <The Dream of Gerontius> Op. 38', piece.title_en = 'The Dream of Gerontius, op. 38',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = 'Op.', piece.catalogue_number = '38',
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 2369 AND piece.composer_id = 64
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'Part I, I. Prelude', part.name_en = 'The Dream of Gerontius, op. 38: Part I, I. Prelude',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 2369 AND p.composer_id = 64 AND part.part_key = 'musicbrainz:e6b63288-7bb9-4a6d-8a06-7d2e4264c678' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:e6b63288-7bb9-4a6d-8a06-7d2e4264c678', 1, NULL, 'Part I, I. Prelude', 'The Dream of Gerontius, op. 38: Part I, I. Prelude', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 2369 AND p.composer_id = 64
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:e6b63288-7bb9-4a6d-8a06-7d2e4264c678'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'Part I, II. Jesu, Maria – I am near to death', part.name_en = 'The Dream of Gerontius, op. 38: Part I, II. Jesu, Maria – I am near to death',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 2369 AND p.composer_id = 64 AND part.part_key = 'musicbrainz:e9919853-ca70-4958-bfb4-94b5234941ee' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:e9919853-ca70-4958-bfb4-94b5234941ee', 2, NULL, 'Part I, II. Jesu, Maria – I am near to death', 'The Dream of Gerontius, op. 38: Part I, II. Jesu, Maria – I am near to death', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 2369 AND p.composer_id = 64
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:e9919853-ca70-4958-bfb4-94b5234941ee'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = NULL,
    part.name_ko = 'Part I, III. Rouse thee, my fainting soul', part.name_en = 'The Dream of Gerontius, op. 38: Part I, III. Rouse thee, my fainting soul',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 2369 AND p.composer_id = 64 AND part.part_key = 'musicbrainz:6808161b-b9ab-4223-a019-047f7f843454' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:6808161b-b9ab-4223-a019-047f7f843454', 3, NULL, 'Part I, III. Rouse thee, my fainting soul', 'The Dream of Gerontius, op. 38: Part I, III. Rouse thee, my fainting soul', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 2369 AND p.composer_id = 64
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:6808161b-b9ab-4223-a019-047f7f843454'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = NULL,
    part.name_ko = 'Part I, IV. Sanctus fortis, sanctus Deus', part.name_en = 'The Dream of Gerontius, op. 38: Part I, IV. Sanctus fortis, sanctus Deus',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 2369 AND p.composer_id = 64 AND part.part_key = 'musicbrainz:fdcce82b-412e-4d63-ab03-a006a9410e84' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:fdcce82b-412e-4d63-ab03-a006a9410e84', 4, NULL, 'Part I, IV. Sanctus fortis, sanctus Deus', 'The Dream of Gerontius, op. 38: Part I, IV. Sanctus fortis, sanctus Deus', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 2369 AND p.composer_id = 64
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:fdcce82b-412e-4d63-ab03-a006a9410e84'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 5, part.movement_number = NULL,
    part.name_ko = 'Part I, V. Proficiscere, anima Christiana', part.name_en = 'The Dream of Gerontius, op. 38: Part I, V. Proficiscere, anima Christiana',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 2369 AND p.composer_id = 64 AND part.part_key = 'musicbrainz:010a0c1c-7e99-47b8-96c1-b7d754daec5a' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:010a0c1c-7e99-47b8-96c1-b7d754daec5a', 5, NULL, 'Part I, V. Proficiscere, anima Christiana', 'The Dream of Gerontius, op. 38: Part I, V. Proficiscere, anima Christiana', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 2369 AND p.composer_id = 64
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:010a0c1c-7e99-47b8-96c1-b7d754daec5a'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 6, part.movement_number = NULL,
    part.name_ko = 'Part II, I. I went to sleep', part.name_en = 'The Dream of Gerontius, op. 38: Part II, I. I went to sleep',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 2369 AND p.composer_id = 64 AND part.part_key = 'musicbrainz:62a761d2-e8dc-4861-8d60-801eda5f79d0' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:62a761d2-e8dc-4861-8d60-801eda5f79d0', 6, NULL, 'Part II, I. I went to sleep', 'The Dream of Gerontius, op. 38: Part II, I. I went to sleep', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 2369 AND p.composer_id = 64
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:62a761d2-e8dc-4861-8d60-801eda5f79d0'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 7, part.movement_number = NULL,
    part.name_ko = 'Part II, II. It is a member of that family', part.name_en = 'The Dream of Gerontius, op. 38: Part II, II. It is a member of that family',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 2369 AND p.composer_id = 64 AND part.part_key = 'musicbrainz:a50db9d4-38e5-4f85-b0e6-1daab0fa0787' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:a50db9d4-38e5-4f85-b0e6-1daab0fa0787', 7, NULL, 'Part II, II. It is a member of that family', 'The Dream of Gerontius, op. 38: Part II, II. It is a member of that family', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 2369 AND p.composer_id = 64
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:a50db9d4-38e5-4f85-b0e6-1daab0fa0787'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 8, part.movement_number = NULL,
    part.name_ko = 'Part II, III. But hark! upon my sense comes a fierce hubbub', part.name_en = 'The Dream of Gerontius, op. 38: Part II, III. But hark! upon my sense comes a fierce hubbub',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 2369 AND p.composer_id = 64 AND part.part_key = 'musicbrainz:1a388eb9-cf9f-4012-bd1e-3b13f2d079b1' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:1a388eb9-cf9f-4012-bd1e-3b13f2d079b1', 8, NULL, 'Part II, III. But hark! upon my sense comes a fierce hubbub', 'The Dream of Gerontius, op. 38: Part II, III. But hark! upon my sense comes a fierce hubbub', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 2369 AND p.composer_id = 64
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:1a388eb9-cf9f-4012-bd1e-3b13f2d079b1'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 9, part.movement_number = NULL,
    part.name_ko = 'Part II, IV. I see not those false spirits', part.name_en = 'The Dream of Gerontius, op. 38: Part II, IV. I see not those false spirits',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 2369 AND p.composer_id = 64 AND part.part_key = 'musicbrainz:c4287251-08b2-43e3-8bef-6a804b14d8f4' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:c4287251-08b2-43e3-8bef-6a804b14d8f4', 9, NULL, 'Part II, IV. I see not those false spirits', 'The Dream of Gerontius, op. 38: Part II, IV. I see not those false spirits', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 2369 AND p.composer_id = 64
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:c4287251-08b2-43e3-8bef-6a804b14d8f4'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 10, part.movement_number = NULL,
    part.name_ko = 'Part II, V. But hark! a grand mysterious harmony', part.name_en = 'The Dream of Gerontius, op. 38: Part II, V. But hark! a grand mysterious harmony',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 2369 AND p.composer_id = 64 AND part.part_key = 'musicbrainz:0af329a3-d0c7-4b3a-b2e9-ec9d4a16606e' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:0af329a3-d0c7-4b3a-b2e9-ec9d4a16606e', 10, NULL, 'Part II, V. But hark! a grand mysterious harmony', 'The Dream of Gerontius, op. 38: Part II, V. But hark! a grand mysterious harmony', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 2369 AND p.composer_id = 64
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:0af329a3-d0c7-4b3a-b2e9-ec9d4a16606e'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 11, part.movement_number = NULL,
    part.name_ko = 'Part II, VI. Thy judgment now is near', part.name_en = 'The Dream of Gerontius, op. 38: Part II, VI. Thy judgment now is near',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 2369 AND p.composer_id = 64 AND part.part_key = 'musicbrainz:89cd482d-ecc2-4dce-87bb-b149ca2b183d' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:89cd482d-ecc2-4dce-87bb-b149ca2b183d', 11, NULL, 'Part II, VI. Thy judgment now is near', 'The Dream of Gerontius, op. 38: Part II, VI. Thy judgment now is near', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 2369 AND p.composer_id = 64
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:89cd482d-ecc2-4dce-87bb-b149ca2b183d'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 12, part.movement_number = NULL,
    part.name_ko = 'Part II, VII. I go before my judge', part.name_en = 'The Dream of Gerontius, op. 38: Part II, VII. I go before my judge',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 2369 AND p.composer_id = 64 AND part.part_key = 'musicbrainz:8215f649-48a6-47ae-8c07-96dd450a3cb6' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:8215f649-48a6-47ae-8c07-96dd450a3cb6', 12, NULL, 'Part II, VII. I go before my judge', 'The Dream of Gerontius, op. 38: Part II, VII. I go before my judge', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 2369 AND p.composer_id = 64
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:8215f649-48a6-47ae-8c07-96dd450a3cb6'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 13, part.movement_number = NULL,
    part.name_ko = 'Part II, VIII. Softly and gently, dearly-ransomed soul', part.name_en = 'The Dream of Gerontius, op. 38: Part II, VIII. Softly and gently, dearly-ransomed soul',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 2369 AND p.composer_id = 64 AND part.part_key = 'musicbrainz:8f42608b-8b85-4910-a0fe-ed5eb0b890fa' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:8f42608b-8b85-4910-a0fe-ed5eb0b890fa', 13, NULL, 'Part II, VIII. Softly and gently, dearly-ransomed soul', 'The Dream of Gerontius, op. 38: Part II, VIII. Softly and gently, dearly-ransomed soul', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 2369 AND p.composer_id = 64
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:8f42608b-8b85-4910-a0fe-ed5eb0b890fa'
);


-- None The Fringes of the Fleet

UPDATE pieces piece
SET piece.title = 'The Fringes of the Fleet', piece.title_en = 'The Fringes of the Fleet',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 1174 AND piece.composer_id = 64
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'The Lowestoft Boat', part.name_en = 'The Fringes of the Fleet: I. The Lowestoft Boat',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 1174 AND p.composer_id = 64 AND part.part_key = 'musicbrainz:ad544bcd-45cf-4761-bb2c-02dfc24f7e4c' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:ad544bcd-45cf-4761-bb2c-02dfc24f7e4c', 1, 'I', 'The Lowestoft Boat', 'The Fringes of the Fleet: I. The Lowestoft Boat', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 1174 AND p.composer_id = 64
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:ad544bcd-45cf-4761-bb2c-02dfc24f7e4c'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'Fate''s Discourtesy', part.name_en = 'The Fringes of the Fleet: II. Fate''s Discourtesy',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 1174 AND p.composer_id = 64 AND part.part_key = 'musicbrainz:a48a3798-3014-497f-9aaf-39e51f042600' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:a48a3798-3014-497f-9aaf-39e51f042600', 2, 'II', 'Fate''s Discourtesy', 'The Fringes of the Fleet: II. Fate''s Discourtesy', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 1174 AND p.composer_id = 64
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:a48a3798-3014-497f-9aaf-39e51f042600'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = 'Submarines', part.name_en = 'The Fringes of the Fleet: III. Submarines',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 1174 AND p.composer_id = 64 AND part.part_key = 'musicbrainz:d04f8ce7-b978-4a07-85c3-93df60c10dd2' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:d04f8ce7-b978-4a07-85c3-93df60c10dd2', 3, 'III', 'Submarines', 'The Fringes of the Fleet: III. Submarines', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 1174 AND p.composer_id = 64
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:d04f8ce7-b978-4a07-85c3-93df60c10dd2'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = 'IV',
    part.name_ko = 'The Sweepers', part.name_en = 'The Fringes of the Fleet: IV. The Sweepers',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 1174 AND p.composer_id = 64 AND part.part_key = 'musicbrainz:3ed1f9d7-bb34-4a50-9bd6-c89978bb74b4' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:3ed1f9d7-bb34-4a50-9bd6-c89978bb74b4', 4, 'IV', 'The Sweepers', 'The Fringes of the Fleet: IV. The Sweepers', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 1174 AND p.composer_id = 64
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:3ed1f9d7-bb34-4a50-9bd6-c89978bb74b4'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 5, part.movement_number = 'V',
    part.name_ko = 'Inside the Bar', part.name_en = 'The Fringes of the Fleet: V. Inside the Bar',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 1174 AND p.composer_id = 64 AND part.part_key = 'musicbrainz:4cebe252-d1f7-4e6e-9085-2a794b87be0f' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:4cebe252-d1f7-4e6e-9085-2a794b87be0f', 5, 'V', 'Inside the Bar', 'The Fringes of the Fleet: V. Inside the Bar', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 1174 AND p.composer_id = 64
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:4cebe252-d1f7-4e6e-9085-2a794b87be0f'
);


-- Op. 51 오라토리오 <The Kingdom> Op. 51

UPDATE pieces piece
SET piece.title = '오라토리오 <The Kingdom> Op. 51', piece.title_en = 'The Kingdom, op. 51',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = 'Op.', piece.catalogue_number = '51',
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 829 AND piece.composer_id = 64
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'Prelude', part.name_en = 'The Kingdom, op. 51: Prelude',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 829 AND p.composer_id = 64 AND part.part_key = 'musicbrainz:87a85dbf-edb4-4544-bbf4-34ff4c1a17f1' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:87a85dbf-edb4-4544-bbf4-34ff4c1a17f1', 1, NULL, 'Prelude', 'The Kingdom, op. 51: Prelude', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 829 AND p.composer_id = 64
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:87a85dbf-edb4-4544-bbf4-34ff4c1a17f1'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'In the Upper Room', part.name_en = 'The Kingdom, op. 51: I. In the Upper Room',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 829 AND p.composer_id = 64 AND part.part_key = 'musicbrainz:8296d210-5518-4051-a4ff-1c14b4e2732c' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:8296d210-5518-4051-a4ff-1c14b4e2732c', 2, NULL, 'In the Upper Room', 'The Kingdom, op. 51: I. In the Upper Room', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 829 AND p.composer_id = 64
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:8296d210-5518-4051-a4ff-1c14b4e2732c'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = NULL,
    part.name_ko = 'At the Beautiful Gate', part.name_en = 'The Kingdom, op. 51: II. At the Beautiful Gate',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 829 AND p.composer_id = 64 AND part.part_key = 'musicbrainz:d02d1d3c-00e9-412a-8702-ac16c6c8e097' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:d02d1d3c-00e9-412a-8702-ac16c6c8e097', 3, NULL, 'At the Beautiful Gate', 'The Kingdom, op. 51: II. At the Beautiful Gate', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 829 AND p.composer_id = 64
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:d02d1d3c-00e9-412a-8702-ac16c6c8e097'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = NULL,
    part.name_ko = 'Pentecost', part.name_en = 'The Kingdom, op. 51: III. Pentecost',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 829 AND p.composer_id = 64 AND part.part_key = 'musicbrainz:2913b7e2-a0ab-4f23-a2d2-c3f1bb57802f' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:2913b7e2-a0ab-4f23-a2d2-c3f1bb57802f', 4, NULL, 'Pentecost', 'The Kingdom, op. 51: III. Pentecost', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 829 AND p.composer_id = 64
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:2913b7e2-a0ab-4f23-a2d2-c3f1bb57802f'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 5, part.movement_number = NULL,
    part.name_ko = 'The Sign of Healing', part.name_en = 'The Kingdom, op. 51: IV. The Sign of Healing',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 829 AND p.composer_id = 64 AND part.part_key = 'musicbrainz:2fe1e896-53a8-460d-8c8c-308ee1f7efce' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:2fe1e896-53a8-460d-8c8c-308ee1f7efce', 5, NULL, 'The Sign of Healing', 'The Kingdom, op. 51: IV. The Sign of Healing', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 829 AND p.composer_id = 64
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:2fe1e896-53a8-460d-8c8c-308ee1f7efce'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 6, part.movement_number = NULL,
    part.name_ko = 'The Upper Room', part.name_en = 'The Kingdom, op. 51: V. The Upper Room',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 829 AND p.composer_id = 64 AND part.part_key = 'musicbrainz:c5a0b720-50da-4353-a69a-cde88df1d1b6' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:c5a0b720-50da-4353-a69a-cde88df1d1b6', 6, NULL, 'The Upper Room', 'The Kingdom, op. 51: V. The Upper Room', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 829 AND p.composer_id = 64
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:c5a0b720-50da-4353-a69a-cde88df1d1b6'
);


-- None 가곡 <The King’s Way>

UPDATE pieces piece
SET piece.title = '가곡 <The King’s Way>', piece.title_en = 'The King’s Way',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 1420 AND piece.composer_id = 64
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None 가곡 <The Language of Flowers>

UPDATE pieces piece
SET piece.title = '가곡 <The Language of Flowers>', piece.title_en = 'The Language of Flowers',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 2258 AND piece.composer_id = 64
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- Op. 29 오라토리오 <The Light of Life> Op. 29

UPDATE pieces piece
SET piece.title = '오라토리오 <The Light of Life> Op. 29', piece.title_en = 'The Light of Life, op. 29',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = 'Op.', piece.catalogue_number = '29',
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 1524 AND piece.composer_id = 64
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'Meditation', part.name_en = 'The Light of Life, op. 29 no. 1: Meditation',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 1524 AND p.composer_id = 64 AND part.part_key = 'musicbrainz:2d3a3921-8d49-4768-b733-95054e9c2131' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:2d3a3921-8d49-4768-b733-95054e9c2131', 1, NULL, 'Meditation', 'The Light of Life, op. 29 no. 1: Meditation', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 1524 AND p.composer_id = 64
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:2d3a3921-8d49-4768-b733-95054e9c2131'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'Seek Him that maketh the seven stars', part.name_en = 'The Light of Life, op. 29 no. 2: Seek Him that maketh the seven stars',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 1524 AND p.composer_id = 64 AND part.part_key = 'musicbrainz:fd6e8f3e-e50e-4ee0-9fe8-80b7d94e7eeb' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:fd6e8f3e-e50e-4ee0-9fe8-80b7d94e7eeb', 2, NULL, 'Seek Him that maketh the seven stars', 'The Light of Life, op. 29 no. 2: Seek Him that maketh the seven stars', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 1524 AND p.composer_id = 64
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:fd6e8f3e-e50e-4ee0-9fe8-80b7d94e7eeb'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = NULL,
    part.name_ko = 'As Jesus passed by', part.name_en = 'The Light of Life, op. 29 no. 3: As Jesus passed by',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 1524 AND p.composer_id = 64 AND part.part_key = 'musicbrainz:067241ec-45dc-494c-9b67-65466538e4d1' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:067241ec-45dc-494c-9b67-65466538e4d1', 3, NULL, 'As Jesus passed by', 'The Light of Life, op. 29 no. 3: As Jesus passed by', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 1524 AND p.composer_id = 64
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:067241ec-45dc-494c-9b67-65466538e4d1'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = NULL,
    part.name_ko = 'Be not extreme, O Lord', part.name_en = 'The Light of Life, op. 29 no. 4: Be not extreme, O Lord',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 1524 AND p.composer_id = 64 AND part.part_key = 'musicbrainz:ecb23f0e-9563-4577-9072-3daacbab9034' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:ecb23f0e-9563-4577-9072-3daacbab9034', 4, NULL, 'Be not extreme, O Lord', 'The Light of Life, op. 29 no. 4: Be not extreme, O Lord', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 1524 AND p.composer_id = 64
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:ecb23f0e-9563-4577-9072-3daacbab9034'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 5, part.movement_number = NULL,
    part.name_ko = 'Neither hath this man sinned', part.name_en = 'The Light of Life, op. 29 no. 5: Neither hath this man sinned',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 1524 AND p.composer_id = 64 AND part.part_key = 'musicbrainz:10ee474d-30d6-4980-bca6-0ebdee1bdc38' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:10ee474d-30d6-4980-bca6-0ebdee1bdc38', 5, NULL, 'Neither hath this man sinned', 'The Light of Life, op. 29 no. 5: Neither hath this man sinned', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 1524 AND p.composer_id = 64
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:10ee474d-30d6-4980-bca6-0ebdee1bdc38'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 6, part.movement_number = NULL,
    part.name_ko = 'Light out of the darkness', part.name_en = 'The Light of Life, op. 29 no. 6: Light out of the darkness',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 1524 AND p.composer_id = 64 AND part.part_key = 'musicbrainz:fe697515-0925-487a-9dbe-49639afbedd5' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:fe697515-0925-487a-9dbe-49639afbedd5', 6, NULL, 'Light out of the darkness', 'The Light of Life, op. 29 no. 6: Light out of the darkness', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 1524 AND p.composer_id = 64
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:fe697515-0925-487a-9dbe-49639afbedd5'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 7, part.movement_number = NULL,
    part.name_ko = 'And when He had thus spoken', part.name_en = 'The Light of Life, op. 29 no. 7: And when He had thus spoken',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 1524 AND p.composer_id = 64 AND part.part_key = 'musicbrainz:54767388-f4f7-4811-a3a3-91159fd9956a' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:54767388-f4f7-4811-a3a3-91159fd9956a', 7, NULL, 'And when He had thus spoken', 'The Light of Life, op. 29 no. 7: And when He had thus spoken', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 1524 AND p.composer_id = 64
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:54767388-f4f7-4811-a3a3-91159fd9956a'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 8, part.movement_number = NULL,
    part.name_ko = 'Doubt not thy Father''s care', part.name_en = 'The Light of Life, op. 29 no. 8: Doubt not thy Father''s care',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 1524 AND p.composer_id = 64 AND part.part_key = 'musicbrainz:c7ae6786-7da0-456a-a2e0-4e2352d5fb74' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:c7ae6786-7da0-456a-a2e0-4e2352d5fb74', 8, NULL, 'Doubt not thy Father''s care', 'The Light of Life, op. 29 no. 8: Doubt not thy Father''s care', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 1524 AND p.composer_id = 64
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:c7ae6786-7da0-456a-a2e0-4e2352d5fb74'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 9, part.movement_number = NULL,
    part.name_ko = 'He went his therefore', part.name_en = 'The Light of Life, op. 29 no. 9: He went his therefore',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 1524 AND p.composer_id = 64 AND part.part_key = 'musicbrainz:c03f27aa-691f-4bba-ae7f-3ecbaf9a9d63' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:c03f27aa-691f-4bba-ae7f-3ecbaf9a9d63', 9, NULL, 'He went his therefore', 'The Light of Life, op. 29 no. 9: He went his therefore', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 1524 AND p.composer_id = 64
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:c03f27aa-691f-4bba-ae7f-3ecbaf9a9d63'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 10, part.movement_number = NULL,
    part.name_ko = 'As a spirit didst Thou pass before mine eyes', part.name_en = 'The Light of Life, op. 29 no. 10: As a spirit didst Thou pass before mine eyes',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 1524 AND p.composer_id = 64 AND part.part_key = 'musicbrainz:c99a60e8-57b2-4037-8d92-452aa7bf2dc1' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:c99a60e8-57b2-4037-8d92-452aa7bf2dc1', 10, NULL, 'As a spirit didst Thou pass before mine eyes', 'The Light of Life, op. 29 no. 10: As a spirit didst Thou pass before mine eyes', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 1524 AND p.composer_id = 64
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:c99a60e8-57b2-4037-8d92-452aa7bf2dc1'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 11, part.movement_number = NULL,
    part.name_ko = 'They brought him to the Pharisees', part.name_en = 'The Light of Life, op. 29 no. 11: They brought him to the Pharisees',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 1524 AND p.composer_id = 64 AND part.part_key = 'musicbrainz:a8d48e26-d28d-4b0a-ac1a-e9f804629af6' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:a8d48e26-d28d-4b0a-ac1a-e9f804629af6', 11, NULL, 'They brought him to the Pharisees', 'The Light of Life, op. 29 no. 11: They brought him to the Pharisees', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 1524 AND p.composer_id = 64
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:a8d48e26-d28d-4b0a-ac1a-e9f804629af6'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 12, part.movement_number = NULL,
    part.name_ko = 'Thou only hast the words of life', part.name_en = 'The Light of Life, op. 29 no. 12: Thou only hast the words of life',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 1524 AND p.composer_id = 64 AND part.part_key = 'musicbrainz:1b0adfb0-156d-4e00-b2e0-05f1bbd44f8b' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:1b0adfb0-156d-4e00-b2e0-05f1bbd44f8b', 12, NULL, 'Thou only hast the words of life', 'The Light of Life, op. 29 no. 12: Thou only hast the words of life', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 1524 AND p.composer_id = 64
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:1b0adfb0-156d-4e00-b2e0-05f1bbd44f8b'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 13, part.movement_number = NULL,
    part.name_ko = 'But the Jews did not believe', part.name_en = 'The Light of Life, op. 29 no. 13: But the Jews did not believe',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 1524 AND p.composer_id = 64 AND part.part_key = 'musicbrainz:c3436a50-61f9-4f17-a13d-10f16255e6ae' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:c3436a50-61f9-4f17-a13d-10f16255e6ae', 13, NULL, 'But the Jews did not believe', 'The Light of Life, op. 29 no. 13: But the Jews did not believe', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 1524 AND p.composer_id = 64
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:c3436a50-61f9-4f17-a13d-10f16255e6ae'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 14, part.movement_number = NULL,
    part.name_ko = 'Woe to the shepherds of the flock', part.name_en = 'The Light of Life, op. 29 no. 14: Woe to the shepherds of the flock',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 1524 AND p.composer_id = 64 AND part.part_key = 'musicbrainz:953a60b7-ac31-4443-a4ad-b4bf68049e12' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:953a60b7-ac31-4443-a4ad-b4bf68049e12', 14, NULL, 'Woe to the shepherds of the flock', 'The Light of Life, op. 29 no. 14: Woe to the shepherds of the flock', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 1524 AND p.composer_id = 64
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:953a60b7-ac31-4443-a4ad-b4bf68049e12'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 15, part.movement_number = NULL,
    part.name_ko = 'Jesus heard that they had cast him out', part.name_en = 'The Light of Life, op. 29 no. 15a: Jesus heard that they had cast him out',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 1524 AND p.composer_id = 64 AND part.part_key = 'musicbrainz:9a0e4b08-eb73-4c1d-9744-6c1f54008c5c' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:9a0e4b08-eb73-4c1d-9744-6c1f54008c5c', 15, NULL, 'Jesus heard that they had cast him out', 'The Light of Life, op. 29 no. 15a: Jesus heard that they had cast him out', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 1524 AND p.composer_id = 64
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:9a0e4b08-eb73-4c1d-9744-6c1f54008c5c'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 16, part.movement_number = NULL,
    part.name_ko = 'I am the Good Shepard', part.name_en = 'The Light of Life, op. 29 no. 15b: I am the Good Shepard',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 1524 AND p.composer_id = 64 AND part.part_key = 'musicbrainz:179f7d25-429a-4814-8a56-47717da7beda' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:179f7d25-429a-4814-8a56-47717da7beda', 16, NULL, 'I am the Good Shepard', 'The Light of Life, op. 29 no. 15b: I am the Good Shepard', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 1524 AND p.composer_id = 64
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:179f7d25-429a-4814-8a56-47717da7beda'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 17, part.movement_number = NULL,
    part.name_ko = 'Light of the World, we know Thy praise', part.name_en = 'The Light of Life, op. 29 no. 16: Light of the World, we know Thy praise',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 1524 AND p.composer_id = 64 AND part.part_key = 'musicbrainz:8ad69a26-4d07-428d-bcfa-c16097eb77e8' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:8ad69a26-4d07-428d-bcfa-c16097eb77e8', 17, NULL, 'Light of the World, we know Thy praise', 'The Light of Life, op. 29 no. 16: Light of the World, we know Thy praise', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 1524 AND p.composer_id = 64
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:8ad69a26-4d07-428d-bcfa-c16097eb77e8'
);


-- None 가곡 <The Muleteer’s Serenade>

UPDATE pieces piece
SET piece.title = '가곡 <The Muleteer’s Serenade>', piece.title_en = 'The Muleteer’s Serenade',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 2541 AND piece.composer_id = 64
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- Op. 69 The Music Makers

UPDATE pieces piece
SET piece.title = 'The Music Makers', piece.title_en = 'The Music Makers, op. 69',
    piece.type = 'album', piece.opus_number = 'Op. 69',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 1822 AND piece.composer_id = 64
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'Moderato e nobilmente', part.name_en = 'The Music Makers, op. 69: Moderato e nobilmente',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 1822 AND p.composer_id = 64 AND part.part_key = 'musicbrainz:08639620-e4b4-4c29-8aba-9da3342e8925' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:08639620-e4b4-4c29-8aba-9da3342e8925', 1, NULL, 'Moderato e nobilmente', 'The Music Makers, op. 69: Moderato e nobilmente', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 1822 AND p.composer_id = 64
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:08639620-e4b4-4c29-8aba-9da3342e8925'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'Larghetto. "We are the music makers"', part.name_en = 'The Music Makers, op. 69: Larghetto. "We are the music makers"',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 1822 AND p.composer_id = 64 AND part.part_key = 'musicbrainz:6b6691d1-fb87-418f-859d-729a48e95131' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:6b6691d1-fb87-418f-859d-729a48e95131', 2, NULL, 'Larghetto. "We are the music makers"', 'The Music Makers, op. 69: Larghetto. "We are the music makers"', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 1822 AND p.composer_id = 64
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:6b6691d1-fb87-418f-859d-729a48e95131'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = NULL,
    part.name_ko = 'Allegro. "With wonderful deathless ditties"', part.name_en = 'The Music Makers, op. 69: Allegro. "With wonderful deathless ditties"',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 1822 AND p.composer_id = 64 AND part.part_key = 'musicbrainz:c038cbb5-f7b0-4c97-90ef-d72f00898fce' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:c038cbb5-f7b0-4c97-90ef-d72f00898fce', 3, NULL, 'Allegro. "With wonderful deathless ditties"', 'The Music Makers, op. 69: Allegro. "With wonderful deathless ditties"', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 1822 AND p.composer_id = 64
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:c038cbb5-f7b0-4c97-90ef-d72f00898fce'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = NULL,
    part.name_ko = 'Allegretto. "We, in the ages lying"', part.name_en = 'The Music Makers, op. 69: Allegretto. "We, in the ages lying"',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 1822 AND p.composer_id = 64 AND part.part_key = 'musicbrainz:9f53c945-2afb-4e12-b0a7-209925e6817a' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:9f53c945-2afb-4e12-b0a7-209925e6817a', 4, NULL, 'Allegretto. "We, in the ages lying"', 'The Music Makers, op. 69: Allegretto. "We, in the ages lying"', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 1822 AND p.composer_id = 64
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:9f53c945-2afb-4e12-b0a7-209925e6817a'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 5, part.movement_number = NULL,
    part.name_ko = 'Molto tranquillo. "A breath of our inspiration"', part.name_en = 'The Music Makers, op. 69: Molto tranquillo. "A breath of our inspiration"',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 1822 AND p.composer_id = 64 AND part.part_key = 'musicbrainz:4e8b5d22-b681-4459-ba92-da4d2e006639' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:4e8b5d22-b681-4459-ba92-da4d2e006639', 5, NULL, 'Molto tranquillo. "A breath of our inspiration"', 'The Music Makers, op. 69: Molto tranquillo. "A breath of our inspiration"', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 1822 AND p.composer_id = 64
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:4e8b5d22-b681-4459-ba92-da4d2e006639'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 6, part.movement_number = NULL,
    part.name_ko = 'Contralto solo, lento, quasi recitativo. "They had no vision amazing"', part.name_en = 'The Music Makers, op. 69: Contralto solo, lento, quasi recitativo. "They had no vision amazing"',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 1822 AND p.composer_id = 64 AND part.part_key = 'musicbrainz:4e55d346-4dd6-464f-8fea-7280a6636608' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:4e55d346-4dd6-464f-8fea-7280a6636608', 6, NULL, 'Contralto solo, lento, quasi recitativo. "They had no vision amazing"', 'The Music Makers, op. 69: Contralto solo, lento, quasi recitativo. "They had no vision amazing"', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 1822 AND p.composer_id = 64
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:4e55d346-4dd6-464f-8fea-7280a6636608'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 7, part.movement_number = NULL,
    part.name_ko = 'Allegro molto. "And therefor today is thrilling"', part.name_en = 'The Music Makers, op. 69: Allegro molto. "And therefor today is thrilling"',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 1822 AND p.composer_id = 64 AND part.part_key = 'musicbrainz:a8e3e457-022e-4c56-b67b-ce8edeead3d1' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:a8e3e457-022e-4c56-b67b-ce8edeead3d1', 7, NULL, 'Allegro molto. "And therefor today is thrilling"', 'The Music Makers, op. 69: Allegro molto. "And therefor today is thrilling"', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 1822 AND p.composer_id = 64
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:a8e3e457-022e-4c56-b67b-ce8edeead3d1'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 8, part.movement_number = NULL,
    part.name_ko = 'Andantino. "But we, with our dreaming and singing"', part.name_en = 'The Music Makers, op. 69: Andantino. "But we, with our dreaming and singing"',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 1822 AND p.composer_id = 64 AND part.part_key = 'musicbrainz:3a50db48-4a29-4d37-b9c8-abcdfd27beb0' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:3a50db48-4a29-4d37-b9c8-abcdfd27beb0', 8, NULL, 'Andantino. "But we, with our dreaming and singing"', 'The Music Makers, op. 69: Andantino. "But we, with our dreaming and singing"', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 1822 AND p.composer_id = 64
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:3a50db48-4a29-4d37-b9c8-abcdfd27beb0'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 9, part.movement_number = NULL,
    part.name_ko = 'Come prima. "For we are afar with the dawning"', part.name_en = 'The Music Makers, op. 69: Come prima. "For we are afar with the dawning"',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 1822 AND p.composer_id = 64 AND part.part_key = 'musicbrainz:7d879c22-82d0-432b-b99d-820d1fdef2a7' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:7d879c22-82d0-432b-b99d-820d1fdef2a7', 9, NULL, 'Come prima. "For we are afar with the dawning"', 'The Music Makers, op. 69: Come prima. "For we are afar with the dawning"', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 1822 AND p.composer_id = 64
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:7d879c22-82d0-432b-b99d-820d1fdef2a7'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 10, part.movement_number = NULL,
    part.name_ko = 'Allegro. "Great hail! we cry to the comers"', part.name_en = 'The Music Makers, op. 69: Allegro. "Great hail! we cry to the comers"',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 1822 AND p.composer_id = 64 AND part.part_key = 'musicbrainz:55fe9fe1-4dca-4592-a3cd-d82804e2dd12' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:55fe9fe1-4dca-4592-a3cd-d82804e2dd12', 10, NULL, 'Allegro. "Great hail! we cry to the comers"', 'The Music Makers, op. 69: Allegro. "Great hail! we cry to the comers"', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 1822 AND p.composer_id = 64
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:55fe9fe1-4dca-4592-a3cd-d82804e2dd12'
);


-- None 가곡 <The Poet's Life>

UPDATE pieces piece
SET piece.title = '가곡 <The Poet''s Life>', piece.title_en = 'The Poet''s Life',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 1599 AND piece.composer_id = 64
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- Op. 54 The Reveille

UPDATE pieces piece
SET piece.title = 'The Reveille', piece.title_en = 'The Reveille, op. 54',
    piece.type = 'song', piece.opus_number = 'Op. 54',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 2708 AND piece.composer_id = 64
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- Op. 81 발레 <The Sanguine Fan>

UPDATE pieces piece
SET piece.title = '발레 <The Sanguine Fan>', piece.title_en = 'The Sanguine Fan, op. 81',
    piece.type = 'song', piece.opus_number = 'Op. 81',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 735 AND piece.composer_id = 64
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None The Self-Banished

UPDATE pieces piece
SET piece.title = 'The Self-Banished', piece.title_en = 'The Self-Banished',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 2191 AND piece.composer_id = 64
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- Op. 87 The Severn Suite

UPDATE pieces piece
SET piece.title = 'The Severn Suite', piece.title_en = 'The Severn Suite, op. 87',
    piece.type = 'album', piece.opus_number = 'Op. 87',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 730 AND piece.composer_id = 64
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'Introduction (Worcester Castle)', part.name_en = 'The Severn Suite, op. 87: I. Introduction (Worcester Castle)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 730 AND p.composer_id = 64 AND part.part_key = 'musicbrainz:1ea50c8c-886f-427c-92dd-da9907e6dca3' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:1ea50c8c-886f-427c-92dd-da9907e6dca3', 1, 'I', 'Introduction (Worcester Castle)', 'The Severn Suite, op. 87: I. Introduction (Worcester Castle)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 730 AND p.composer_id = 64
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:1ea50c8c-886f-427c-92dd-da9907e6dca3'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'Toccata (Tournament)', part.name_en = 'The Severn Suite, op. 87: II. Toccata (Tournament)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 730 AND p.composer_id = 64 AND part.part_key = 'musicbrainz:334a10de-7182-433a-b691-0bd3cdb69f5d' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:334a10de-7182-433a-b691-0bd3cdb69f5d', 2, 'II', 'Toccata (Tournament)', 'The Severn Suite, op. 87: II. Toccata (Tournament)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 730 AND p.composer_id = 64
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:334a10de-7182-433a-b691-0bd3cdb69f5d'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = 'Fugue (The Cathedral)', part.name_en = 'The Severn Suite, op. 87: III. Fugue (The Cathedral)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 730 AND p.composer_id = 64 AND part.part_key = 'musicbrainz:894f31c7-0efd-4d4c-86e0-c7f3d2301830' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:894f31c7-0efd-4d4c-86e0-c7f3d2301830', 3, 'III', 'Fugue (The Cathedral)', 'The Severn Suite, op. 87: III. Fugue (The Cathedral)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 730 AND p.composer_id = 64
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:894f31c7-0efd-4d4c-86e0-c7f3d2301830'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = 'IV',
    part.name_ko = 'Minuet (Commandery)', part.name_en = 'The Severn Suite, op. 87: IV. Minuet (Commandery)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 730 AND p.composer_id = 64 AND part.part_key = 'musicbrainz:35963faa-a146-404a-93b6-2eb40ada5f3e' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:35963faa-a146-404a-93b6-2eb40ada5f3e', 4, 'IV', 'Minuet (Commandery)', 'The Severn Suite, op. 87: IV. Minuet (Commandery)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 730 AND p.composer_id = 64
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:35963faa-a146-404a-93b6-2eb40ada5f3e'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 5, part.movement_number = 'V',
    part.name_ko = 'Coda', part.name_en = 'The Severn Suite, op. 87: V. Coda',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 730 AND p.composer_id = 64 AND part.part_key = 'musicbrainz:057c6ce6-31b5-4666-9e64-2be840447515' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:057c6ce6-31b5-4666-9e64-2be840447515', 5, 'V', 'Coda', 'The Severn Suite, op. 87: V. Coda', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 730 AND p.composer_id = 64
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:057c6ce6-31b5-4666-9e64-2be840447515'
);


-- Op. 80 칸타타 <The Spirit of England>

UPDATE pieces piece
SET piece.title = '칸타타 <The Spirit of England>', piece.title_en = 'The Spirit of England, op. 80',
    piece.type = 'album', piece.opus_number = 'Op. 80',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 2993 AND piece.composer_id = 64
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'The Fourth of August', part.name_en = 'The Spirit of England, op. 80: I. The Fourth of August',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 2993 AND p.composer_id = 64 AND part.part_key = 'musicbrainz:a7caa8df-2cfa-459a-892f-4ae3c9cf1eac' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:a7caa8df-2cfa-459a-892f-4ae3c9cf1eac', 1, 'I', 'The Fourth of August', 'The Spirit of England, op. 80: I. The Fourth of August', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 2993 AND p.composer_id = 64
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:a7caa8df-2cfa-459a-892f-4ae3c9cf1eac'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'To Women', part.name_en = 'The Spirit of England, op. 80: II. To Women',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 2993 AND p.composer_id = 64 AND part.part_key = 'musicbrainz:8cbf0247-73bf-4adf-84c4-4f57aec7be5b' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:8cbf0247-73bf-4adf-84c4-4f57aec7be5b', 2, 'II', 'To Women', 'The Spirit of England, op. 80: II. To Women', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 2993 AND p.composer_id = 64
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:8cbf0247-73bf-4adf-84c4-4f57aec7be5b'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = 'For the Fallen', part.name_en = 'The Spirit of England, op. 80: III. For the Fallen',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 2993 AND p.composer_id = 64 AND part.part_key = 'musicbrainz:9108d0d0-602b-42a9-9dda-e1b7c83fd080' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:9108d0d0-602b-42a9-9dda-e1b7c83fd080', 3, 'III', 'For the Fallen', 'The Spirit of England, op. 80: III. For the Fallen', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 2993 AND p.composer_id = 64
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:9108d0d0-602b-42a9-9dda-e1b7c83fd080'
);


-- None The Starlight Express

UPDATE pieces piece
SET piece.title = 'The Starlight Express', piece.title_en = 'The Starlight Express',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 2364 AND piece.composer_id = 64
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'op. 78: O children, open your arms to me', part.name_en = 'The Starlight Express, op. 78: O children, open your arms to me',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 2364 AND p.composer_id = 64 AND part.part_key = 'musicbrainz:71c28b5c-8a0a-4c06-818b-90580fb38c93' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:71c28b5c-8a0a-4c06-818b-90580fb38c93', 1, NULL, 'op. 78: O children, open your arms to me', 'The Starlight Express, op. 78: O children, open your arms to me', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 2364 AND p.composer_id = 64
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:71c28b5c-8a0a-4c06-818b-90580fb38c93'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'op. 78: There''s a fairy that hides', part.name_en = 'The Starlight Express, op. 78: There''s a fairy that hides',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 2364 AND p.composer_id = 64 AND part.part_key = 'musicbrainz:42958e96-1f25-4b06-8836-564bede181f3' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:42958e96-1f25-4b06-8836-564bede181f3', 2, NULL, 'op. 78: There''s a fairy that hides', 'The Starlight Express, op. 78: There''s a fairy that hides', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 2364 AND p.composer_id = 64
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:42958e96-1f25-4b06-8836-564bede181f3'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = NULL,
    part.name_ko = 'op. 78: I''m everywhere', part.name_en = 'The Starlight Express, op. 78: I''m everywhere',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 2364 AND p.composer_id = 64 AND part.part_key = 'musicbrainz:b410d9de-7bd3-4a12-a0a0-2cc6b447952c' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:b410d9de-7bd3-4a12-a0a0-2cc6b447952c', 3, NULL, 'op. 78: I''m everywhere', 'The Starlight Express, op. 78: I''m everywhere', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 2364 AND p.composer_id = 64
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:b410d9de-7bd3-4a12-a0a0-2cc6b447952c'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = NULL,
    part.name_ko = 'op. 78: Wake up, you little night winds', part.name_en = 'The Starlight Express, op. 78: Wake up, you little night winds',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 2364 AND p.composer_id = 64 AND part.part_key = 'musicbrainz:bec882d7-4c3b-4c45-b4ec-6714a10ddeac' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:bec882d7-4c3b-4c45-b4ec-6714a10ddeac', 4, NULL, 'op. 78: Wake up, you little night winds', 'The Starlight Express, op. 78: Wake up, you little night winds', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 2364 AND p.composer_id = 64
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:bec882d7-4c3b-4c45-b4ec-6714a10ddeac'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 5, part.movement_number = NULL,
    part.name_ko = 'op. 78: O stars, shine brightly!', part.name_en = 'The Starlight Express, op. 78: O stars, shine brightly!',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 2364 AND p.composer_id = 64 AND part.part_key = 'musicbrainz:d304d82b-5acc-437d-9ee8-80e393ab32f6' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:d304d82b-5acc-437d-9ee8-80e393ab32f6', 5, NULL, 'op. 78: O stars, shine brightly!', 'The Starlight Express, op. 78: O stars, shine brightly!', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 2364 AND p.composer_id = 64
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:d304d82b-5acc-437d-9ee8-80e393ab32f6'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 6, part.movement_number = NULL,
    part.name_ko = 'op. 78: We shall meet the morning spiders', part.name_en = 'The Starlight Express, op. 78: We shall meet the morning spiders',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 2364 AND p.composer_id = 64 AND part.part_key = 'musicbrainz:b678ef11-9de8-4d24-a40e-c9ba24951f19' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:b678ef11-9de8-4d24-a40e-c9ba24951f19', 6, NULL, 'op. 78: We shall meet the morning spiders', 'The Starlight Express, op. 78: We shall meet the morning spiders', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 2364 AND p.composer_id = 64
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:b678ef11-9de8-4d24-a40e-c9ba24951f19'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 7, part.movement_number = NULL,
    part.name_ko = 'op. 78: My old tunes are rather broken', part.name_en = 'The Starlight Express, op. 78: My old tunes are rather broken',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 2364 AND p.composer_id = 64 AND part.part_key = 'musicbrainz:0048dcd7-df67-4b24-899b-69f5a0b59a55' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:0048dcd7-df67-4b24-899b-69f5a0b59a55', 7, NULL, 'op. 78: My old tunes are rather broken', 'The Starlight Express, op. 78: My old tunes are rather broken', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 2364 AND p.composer_id = 64
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:0048dcd7-df67-4b24-899b-69f5a0b59a55'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 8, part.movement_number = NULL,
    part.name_ko = 'op. 78: O, think beauty', part.name_en = 'The Starlight Express, op. 78: O, think beauty',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 2364 AND p.composer_id = 64 AND part.part_key = 'musicbrainz:c9a1198c-82d1-4585-99e8-7cad7980535c' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:c9a1198c-82d1-4585-99e8-7cad7980535c', 8, NULL, 'op. 78: O, think beauty', 'The Starlight Express, op. 78: O, think beauty', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 2364 AND p.composer_id = 64
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:c9a1198c-82d1-4585-99e8-7cad7980535c'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 9, part.movement_number = NULL,
    part.name_ko = 'op. 78: Dustman, laughter, tramp and busy sweep', part.name_en = 'The Starlight Express, op. 78: Dustman, laughter, tramp and busy sweep',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 2364 AND p.composer_id = 64 AND part.part_key = 'musicbrainz:2ab42b58-81e8-4b8b-b9b5-2f4fb654f005' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:2ab42b58-81e8-4b8b-b9b5-2f4fb654f005', 9, NULL, 'op. 78: Dustman, laughter, tramp and busy sweep', 'The Starlight Express, op. 78: Dustman, laughter, tramp and busy sweep', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 2364 AND p.composer_id = 64
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:2ab42b58-81e8-4b8b-b9b5-2f4fb654f005'
);


-- Op. 1a The Wand of Youth Suite no. 1

UPDATE pieces piece
SET piece.title = 'The Wand of Youth Suite no. 1', piece.title_en = 'The Wand of Youth Suite no. 1, op. 1a',
    piece.type = 'album', piece.opus_number = 'Op. 1a',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 2190 AND piece.composer_id = 64
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'Overture', part.name_en = 'The Wand of Youth Suite no. 1, op. 1a: I. Overture',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 2190 AND p.composer_id = 64 AND part.part_key = 'musicbrainz:55319be2-cc29-46e4-a854-32b80970a1d8' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:55319be2-cc29-46e4-a854-32b80970a1d8', 1, 'I', 'Overture', 'The Wand of Youth Suite no. 1, op. 1a: I. Overture', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 2190 AND p.composer_id = 64
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:55319be2-cc29-46e4-a854-32b80970a1d8'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'Serenade', part.name_en = 'The Wand of Youth Suite no. 1, op. 1a: II. Serenade',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 2190 AND p.composer_id = 64 AND part.part_key = 'musicbrainz:d79823b2-d58e-4af2-845b-fcf26bc99321' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:d79823b2-d58e-4af2-845b-fcf26bc99321', 2, 'II', 'Serenade', 'The Wand of Youth Suite no. 1, op. 1a: II. Serenade', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 2190 AND p.composer_id = 64
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:d79823b2-d58e-4af2-845b-fcf26bc99321'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = 'Minuet (Old Style)', part.name_en = 'The Wand of Youth Suite no. 1, op. 1a: III. Minuet (Old Style)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 2190 AND p.composer_id = 64 AND part.part_key = 'musicbrainz:da5a82c0-cd7d-4356-afe1-50c4c82bdfcc' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:da5a82c0-cd7d-4356-afe1-50c4c82bdfcc', 3, 'III', 'Minuet (Old Style)', 'The Wand of Youth Suite no. 1, op. 1a: III. Minuet (Old Style)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 2190 AND p.composer_id = 64
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:da5a82c0-cd7d-4356-afe1-50c4c82bdfcc'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = 'IV',
    part.name_ko = 'Sun Dance', part.name_en = 'The Wand of Youth Suite no. 1, op. 1a: IV. Sun Dance',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 2190 AND p.composer_id = 64 AND part.part_key = 'musicbrainz:9d3d11df-de76-4460-bf1b-9eab89ca76c7' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:9d3d11df-de76-4460-bf1b-9eab89ca76c7', 4, 'IV', 'Sun Dance', 'The Wand of Youth Suite no. 1, op. 1a: IV. Sun Dance', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 2190 AND p.composer_id = 64
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:9d3d11df-de76-4460-bf1b-9eab89ca76c7'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 5, part.movement_number = 'V',
    part.name_ko = 'Fairy Pipers', part.name_en = 'The Wand of Youth Suite no. 1, op. 1a: V. Fairy Pipers',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 2190 AND p.composer_id = 64 AND part.part_key = 'musicbrainz:a679c0b0-17b7-4d38-9a79-87a5ef2e99a3' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:a679c0b0-17b7-4d38-9a79-87a5ef2e99a3', 5, 'V', 'Fairy Pipers', 'The Wand of Youth Suite no. 1, op. 1a: V. Fairy Pipers', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 2190 AND p.composer_id = 64
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:a679c0b0-17b7-4d38-9a79-87a5ef2e99a3'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 6, part.movement_number = 'VI',
    part.name_ko = 'Slumber Scene', part.name_en = 'The Wand of Youth Suite no. 1, op. 1a: VI. Slumber Scene',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 2190 AND p.composer_id = 64 AND part.part_key = 'musicbrainz:7e04e7cc-eff7-4257-bd2a-93ad867506f4' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:7e04e7cc-eff7-4257-bd2a-93ad867506f4', 6, 'VI', 'Slumber Scene', 'The Wand of Youth Suite no. 1, op. 1a: VI. Slumber Scene', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 2190 AND p.composer_id = 64
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:7e04e7cc-eff7-4257-bd2a-93ad867506f4'
);


-- Op. 1b The Wand of Youth Suite no. 2

UPDATE pieces piece
SET piece.title = 'The Wand of Youth Suite no. 2', piece.title_en = 'The Wand of Youth Suite no. 2, op. 1b',
    piece.type = 'album', piece.opus_number = 'Op. 1b',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 738 AND piece.composer_id = 64
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'March', part.name_en = 'The Wand of Youth Suite no. 2, op. 1b: I. March',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 738 AND p.composer_id = 64 AND part.part_key = 'musicbrainz:2ceda432-8625-4f06-aafb-2ec3cecdaa0c' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:2ceda432-8625-4f06-aafb-2ec3cecdaa0c', 1, 'I', 'March', 'The Wand of Youth Suite no. 2, op. 1b: I. March', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 738 AND p.composer_id = 64
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:2ceda432-8625-4f06-aafb-2ec3cecdaa0c'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'The Little Bells (Scherzino)', part.name_en = 'The Wand of Youth Suite no. 2, op. 1b: II. The Little Bells (Scherzino)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 738 AND p.composer_id = 64 AND part.part_key = 'musicbrainz:734e0986-4608-4f14-9acc-4be8d473f75c' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:734e0986-4608-4f14-9acc-4be8d473f75c', 2, 'II', 'The Little Bells (Scherzino)', 'The Wand of Youth Suite no. 2, op. 1b: II. The Little Bells (Scherzino)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 738 AND p.composer_id = 64
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:734e0986-4608-4f14-9acc-4be8d473f75c'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = 'Moths and Butterflies (Dance)', part.name_en = 'The Wand of Youth Suite no. 2, op. 1b: III. Moths and Butterflies (Dance)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 738 AND p.composer_id = 64 AND part.part_key = 'musicbrainz:83ddcae7-1c89-4e87-850f-5e6c4d748d5a' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:83ddcae7-1c89-4e87-850f-5e6c4d748d5a', 3, 'III', 'Moths and Butterflies (Dance)', 'The Wand of Youth Suite no. 2, op. 1b: III. Moths and Butterflies (Dance)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 738 AND p.composer_id = 64
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:83ddcae7-1c89-4e87-850f-5e6c4d748d5a'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = 'IV',
    part.name_ko = 'Fountain Dance', part.name_en = 'The Wand of Youth Suite no. 2, op. 1b: IV. Fountain Dance',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 738 AND p.composer_id = 64 AND part.part_key = 'musicbrainz:bfb59aa3-ad59-4e09-b944-19862c8c2200' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:bfb59aa3-ad59-4e09-b944-19862c8c2200', 4, 'IV', 'Fountain Dance', 'The Wand of Youth Suite no. 2, op. 1b: IV. Fountain Dance', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 738 AND p.composer_id = 64
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:bfb59aa3-ad59-4e09-b944-19862c8c2200'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 5, part.movement_number = 'V',
    part.name_ko = 'The Tame Bear', part.name_en = 'The Wand of Youth Suite no. 2, op. 1b: V. The Tame Bear',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 738 AND p.composer_id = 64 AND part.part_key = 'musicbrainz:b7ed57fd-7821-4a55-93fc-08391b43a8fa' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:b7ed57fd-7821-4a55-93fc-08391b43a8fa', 5, 'V', 'The Tame Bear', 'The Wand of Youth Suite no. 2, op. 1b: V. The Tame Bear', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 738 AND p.composer_id = 64
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:b7ed57fd-7821-4a55-93fc-08391b43a8fa'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 6, part.movement_number = 'VI',
    part.name_ko = 'The Wild Bears', part.name_en = 'The Wand of Youth Suite no. 2, op. 1b: VI. The Wild Bears',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 738 AND p.composer_id = 64 AND part.part_key = 'musicbrainz:31474adb-8746-4f2f-9287-34bf7aa54e6a' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:31474adb-8746-4f2f-9287-34bf7aa54e6a', 6, 'VI', 'The Wild Bears', 'The Wand of Youth Suite no. 2, op. 1b: VI. The Wild Bears', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 738 AND p.composer_id = 64
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:31474adb-8746-4f2f-9287-34bf7aa54e6a'
);


-- None 가곡 <The Wanderer>

UPDATE pieces piece
SET piece.title = '가곡 <The Wanderer>', piece.title_en = 'The Wanderer',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 1593 AND piece.composer_id = 64
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None They are at rest

UPDATE pieces piece
SET piece.title = 'They are at rest', piece.title_en = 'They are at rest',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 893 AND piece.composer_id = 64
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- Op. 27a Three Bavarian Dances

UPDATE pieces piece
SET piece.title = 'Three Bavarian Dances', piece.title_en = 'Three Bavarian Dances, op. 27a',
    piece.type = 'song', piece.opus_number = 'Op. 27a',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 739 AND piece.composer_id = 64
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- Op. 10 Three Characteristic Pieces Op. 10

UPDATE pieces piece
SET piece.title = 'Three Characteristic Pieces Op. 10', piece.title_en = 'Three Characteristic Pieces, op. 10',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = 'Op.', piece.catalogue_number = '10',
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 1446 AND piece.composer_id = 64
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'Mazurka', part.name_en = 'Three Characteristic Pieces, op. 10: No. 1. Mazurka',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 1446 AND p.composer_id = 64 AND part.part_key = 'musicbrainz:a294cb6b-75f6-4a5b-bc94-9b9fe66bf4df' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:a294cb6b-75f6-4a5b-bc94-9b9fe66bf4df', 1, NULL, 'Mazurka', 'Three Characteristic Pieces, op. 10: No. 1. Mazurka', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 1446 AND p.composer_id = 64
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:a294cb6b-75f6-4a5b-bc94-9b9fe66bf4df'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'Sérénade mauresque', part.name_en = 'Three Characteristic Pieces, op. 10: No. 2. Sérénade mauresque',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 1446 AND p.composer_id = 64 AND part.part_key = 'musicbrainz:a2aba384-49b2-45b8-9343-1abd645a191e' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:a2aba384-49b2-45b8-9343-1abd645a191e', 2, NULL, 'Sérénade mauresque', 'Three Characteristic Pieces, op. 10: No. 2. Sérénade mauresque', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 1446 AND p.composer_id = 64
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:a2aba384-49b2-45b8-9343-1abd645a191e'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = NULL,
    part.name_ko = 'Contrasts: The Gavotte', part.name_en = 'Three Characteristic Pieces, op. 10: No. 3. Contrasts: The Gavotte',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 1446 AND p.composer_id = 64 AND part.part_key = 'musicbrainz:36742d95-b830-463e-8398-8fb373252612' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:36742d95-b830-463e-8398-8fb373252612', 3, NULL, 'Contrasts: The Gavotte', 'Three Characteristic Pieces, op. 10: No. 3. Contrasts: The Gavotte', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 1446 AND p.composer_id = 64
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:36742d95-b830-463e-8398-8fb373252612'
);


-- Op. 18 3개의 합창곡 Op. 18

UPDATE pieces piece
SET piece.title = '3개의 합창곡 Op. 18', piece.title_en = 'Three Part-Songs, op. 18',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = 'Op.', piece.catalogue_number = '18',
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 1836 AND piece.composer_id = 64
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'Love, op. 18 no. 2', part.name_en = 'Love, op. 18 no. 2',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 1836 AND p.composer_id = 64 AND part.part_key = 'musicbrainz:ee59bf6f-d1db-4daa-8824-0296a2a4df4f' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:ee59bf6f-d1db-4daa-8824-0296a2a4df4f', 1, NULL, 'Love, op. 18 no. 2', 'Love, op. 18 no. 2', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 1836 AND p.composer_id = 64
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:ee59bf6f-d1db-4daa-8824-0296a2a4df4f'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'My Love dwelt in a Northern Land, op. 18 no. 3', part.name_en = 'My Love dwelt in a Northern Land, op. 18 no. 3',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 1836 AND p.composer_id = 64 AND part.part_key = 'musicbrainz:bf9e4f4b-1efc-4f2a-9bc5-56dd1c3d02cc' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:bf9e4f4b-1efc-4f2a-9bc5-56dd1c3d02cc', 2, NULL, 'My Love dwelt in a Northern Land, op. 18 no. 3', 'My Love dwelt in a Northern Land, op. 18 no. 3', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 1836 AND p.composer_id = 64
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:bf9e4f4b-1efc-4f2a-9bc5-56dd1c3d02cc'
);


-- None To Her Beneath Whose Steadfast Star

UPDATE pieces piece
SET piece.title = 'To Her Beneath Whose Steadfast Star', piece.title_en = 'To Her Beneath Whose Steadfast Star',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 2752 AND piece.composer_id = 64
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- Op. 71 2개의 합창곡 Op. 71

UPDATE pieces piece
SET piece.title = '2개의 합창곡 Op. 71', piece.title_en = 'Two Choral Songs, op. 71',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = 'Op.', piece.catalogue_number = '71',
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 2328 AND piece.composer_id = 64
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'The Shower, op. 71 no. 1', part.name_en = 'The Shower, op. 71 no. 1',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 2328 AND p.composer_id = 64 AND part.part_key = 'musicbrainz:3ed4d12b-c474-45ae-abbc-8fa54f87ec13' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:3ed4d12b-c474-45ae-abbc-8fa54f87ec13', 1, NULL, 'The Shower, op. 71 no. 1', 'The Shower, op. 71 no. 1', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 2328 AND p.composer_id = 64
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:3ed4d12b-c474-45ae-abbc-8fa54f87ec13'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'The Fountain, op. 71 no. 2', part.name_en = 'The Fountain, op. 71 no. 2',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 2328 AND p.composer_id = 64 AND part.part_key = 'musicbrainz:4aa0a6ec-0329-4fd2-aaf4-256853abd468' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:4aa0a6ec-0329-4fd2-aaf4-256853abd468', 2, NULL, 'The Fountain, op. 71 no. 2', 'The Fountain, op. 71 no. 2', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 2328 AND p.composer_id = 64
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:4aa0a6ec-0329-4fd2-aaf4-256853abd468'
);


-- Op. 41 2개의 가곡 Op. 41

UPDATE pieces piece
SET piece.title = '2개의 가곡 Op. 41', piece.title_en = 'Two Songs, op. 41',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = 'Op.', piece.catalogue_number = '41',
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 2457 AND piece.composer_id = 64
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'In the Dawn, op. 41 no. 1', part.name_en = 'In the Dawn, op. 41 no. 1',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 2457 AND p.composer_id = 64 AND part.part_key = 'musicbrainz:51432155-16a0-4120-b621-d3cc822a1f15' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:51432155-16a0-4120-b621-d3cc822a1f15', 1, NULL, 'In the Dawn, op. 41 no. 1', 'In the Dawn, op. 41 no. 1', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 2457 AND p.composer_id = 64
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:51432155-16a0-4120-b621-d3cc822a1f15'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'Speak, Music, op. 41 no. 2', part.name_en = 'Speak, Music, op. 41 no. 2',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 2457 AND p.composer_id = 64 AND part.part_key = 'musicbrainz:6d473292-71ef-4a8e-914d-8150944000b7' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:6d473292-71ef-4a8e-914d-8150944000b7', 2, NULL, 'Speak, Music, op. 41 no. 2', 'Speak, Music, op. 41 no. 2', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 2457 AND p.composer_id = 64
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:6d473292-71ef-4a8e-914d-8150944000b7'
);


-- Op. 77 Une voix dans le désert

UPDATE pieces piece
SET piece.title = 'Une voix dans le désert', piece.title_en = 'Une voix dans le désert, op. 77',
    piece.type = 'song', piece.opus_number = 'Op. 77',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 1544 AND piece.composer_id = 64
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- Op. 36 Variations on an Original Theme (‘Enigma’)

UPDATE pieces piece
SET piece.title = 'Variations on an Original Theme (‘Enigma’)', piece.title_en = 'Variations on an Original Theme (‘Enigma’), op. 36',
    piece.type = 'album', piece.opus_number = 'Op. 36',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 550 AND piece.composer_id = 64
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'Theme (Andante)', part.name_en = 'Variations on an Original Theme (‘Enigma’), op. 36: Theme (Andante)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 550 AND p.composer_id = 64 AND part.part_key = 'musicbrainz:dd357747-f86f-39b8-bc00-1eac4510db5b' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:dd357747-f86f-39b8-bc00-1eac4510db5b', 1, NULL, 'Theme (Andante)', 'Variations on an Original Theme (‘Enigma’), op. 36: Theme (Andante)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 550 AND p.composer_id = 64
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:dd357747-f86f-39b8-bc00-1eac4510db5b'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'I',
    part.name_ko = 'C.A.E. (L’istesso tempo)', part.name_en = 'Variations on an Original Theme (‘Enigma’), op. 36: I. C.A.E. (L’istesso tempo)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 550 AND p.composer_id = 64 AND part.part_key = 'musicbrainz:addfc0cf-bab2-343b-92bd-1f46ee6dad4a' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:addfc0cf-bab2-343b-92bd-1f46ee6dad4a', 2, 'I', 'C.A.E. (L’istesso tempo)', 'Variations on an Original Theme (‘Enigma’), op. 36: I. C.A.E. (L’istesso tempo)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 550 AND p.composer_id = 64
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:addfc0cf-bab2-343b-92bd-1f46ee6dad4a'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'II',
    part.name_ko = 'H.D.S-P. (Allegro)', part.name_en = 'Variations on an Original Theme (‘Enigma’), op. 36: II. H.D.S-P. (Allegro)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 550 AND p.composer_id = 64 AND part.part_key = 'musicbrainz:9c4e6da6-f8ef-344f-b4c1-0ba7a9c591ec' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:9c4e6da6-f8ef-344f-b4c1-0ba7a9c591ec', 3, 'II', 'H.D.S-P. (Allegro)', 'Variations on an Original Theme (‘Enigma’), op. 36: II. H.D.S-P. (Allegro)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 550 AND p.composer_id = 64
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:9c4e6da6-f8ef-344f-b4c1-0ba7a9c591ec'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = 'III',
    part.name_ko = 'R.B.T. (Allegretto)', part.name_en = 'Variations on an Original Theme (‘Enigma’), op. 36: III. R.B.T. (Allegretto)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 550 AND p.composer_id = 64 AND part.part_key = 'musicbrainz:1f18faae-743a-3dc5-a129-1fbf1dc41c6c' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:1f18faae-743a-3dc5-a129-1fbf1dc41c6c', 4, 'III', 'R.B.T. (Allegretto)', 'Variations on an Original Theme (‘Enigma’), op. 36: III. R.B.T. (Allegretto)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 550 AND p.composer_id = 64
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:1f18faae-743a-3dc5-a129-1fbf1dc41c6c'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 5, part.movement_number = 'IV',
    part.name_ko = 'W.M.B. (Allegro di molto)', part.name_en = 'Variations on an Original Theme (‘Enigma’), op. 36: IV. W.M.B. (Allegro di molto)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 550 AND p.composer_id = 64 AND part.part_key = 'musicbrainz:00168714-605c-3f76-b2e7-a6e4c42958b8' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:00168714-605c-3f76-b2e7-a6e4c42958b8', 5, 'IV', 'W.M.B. (Allegro di molto)', 'Variations on an Original Theme (‘Enigma’), op. 36: IV. W.M.B. (Allegro di molto)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 550 AND p.composer_id = 64
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:00168714-605c-3f76-b2e7-a6e4c42958b8'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 6, part.movement_number = 'V',
    part.name_ko = 'R.P.A. (Moderato)', part.name_en = 'Variations on an Original Theme (‘Enigma’), op. 36: V. R.P.A. (Moderato)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 550 AND p.composer_id = 64 AND part.part_key = 'musicbrainz:d55ece99-74c7-304c-a220-cda1cc1c0c56' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:d55ece99-74c7-304c-a220-cda1cc1c0c56', 6, 'V', 'R.P.A. (Moderato)', 'Variations on an Original Theme (‘Enigma’), op. 36: V. R.P.A. (Moderato)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 550 AND p.composer_id = 64
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:d55ece99-74c7-304c-a220-cda1cc1c0c56'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 7, part.movement_number = 'VI',
    part.name_ko = 'Ysobel (Andantino)', part.name_en = 'Variations on an Original Theme (‘Enigma’), op. 36: VI. Ysobel (Andantino)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 550 AND p.composer_id = 64 AND part.part_key = 'musicbrainz:89e6b2d1-1597-3bd3-b699-d21e25fda7d6' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:89e6b2d1-1597-3bd3-b699-d21e25fda7d6', 7, 'VI', 'Ysobel (Andantino)', 'Variations on an Original Theme (‘Enigma’), op. 36: VI. Ysobel (Andantino)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 550 AND p.composer_id = 64
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:89e6b2d1-1597-3bd3-b699-d21e25fda7d6'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 8, part.movement_number = 'VII',
    part.name_ko = 'Troyte (Presto)', part.name_en = 'Variations on an Original Theme (‘Enigma’), op. 36: VII. Troyte (Presto)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 550 AND p.composer_id = 64 AND part.part_key = 'musicbrainz:0f4d7f1c-ac08-3d05-970d-f52b4b2947f0' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:0f4d7f1c-ac08-3d05-970d-f52b4b2947f0', 8, 'VII', 'Troyte (Presto)', 'Variations on an Original Theme (‘Enigma’), op. 36: VII. Troyte (Presto)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 550 AND p.composer_id = 64
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:0f4d7f1c-ac08-3d05-970d-f52b4b2947f0'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 9, part.movement_number = 'VIII',
    part.name_ko = 'W.N. (Allegretto)', part.name_en = 'Variations on an Original Theme (‘Enigma’), op. 36: VIII. W.N. (Allegretto)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 550 AND p.composer_id = 64 AND part.part_key = 'musicbrainz:9e126c45-40a3-387f-acbc-4b52e426fad6' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:9e126c45-40a3-387f-acbc-4b52e426fad6', 9, 'VIII', 'W.N. (Allegretto)', 'Variations on an Original Theme (‘Enigma’), op. 36: VIII. W.N. (Allegretto)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 550 AND p.composer_id = 64
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:9e126c45-40a3-387f-acbc-4b52e426fad6'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 10, part.movement_number = 'IX',
    part.name_ko = 'Nimrod (Adagio)', part.name_en = 'Variations on an Original Theme (‘Enigma’), op. 36: IX. Nimrod (Adagio)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 550 AND p.composer_id = 64 AND part.part_key = 'musicbrainz:6ec60369-cdc4-3554-827b-fef2101d94f7' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:6ec60369-cdc4-3554-827b-fef2101d94f7', 10, 'IX', 'Nimrod (Adagio)', 'Variations on an Original Theme (‘Enigma’), op. 36: IX. Nimrod (Adagio)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 550 AND p.composer_id = 64
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:6ec60369-cdc4-3554-827b-fef2101d94f7'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 11, part.movement_number = 'X',
    part.name_ko = 'Intermezzo: Dorabella (Allegretto)', part.name_en = 'Variations on an Original Theme (‘Enigma’), op. 36: X. Intermezzo: Dorabella (Allegretto)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 550 AND p.composer_id = 64 AND part.part_key = 'musicbrainz:810576ed-278d-3fc7-8b56-5fe9f2f8ad99' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:810576ed-278d-3fc7-8b56-5fe9f2f8ad99', 11, 'X', 'Intermezzo: Dorabella (Allegretto)', 'Variations on an Original Theme (‘Enigma’), op. 36: X. Intermezzo: Dorabella (Allegretto)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 550 AND p.composer_id = 64
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:810576ed-278d-3fc7-8b56-5fe9f2f8ad99'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 12, part.movement_number = 'XI',
    part.name_ko = 'G.R.S. (Allegro di molto)', part.name_en = 'Variations on an Original Theme (‘Enigma’), op. 36: XI. G.R.S. (Allegro di molto)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 550 AND p.composer_id = 64 AND part.part_key = 'musicbrainz:4a9f578a-f325-364a-88d7-6f779f48604f' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:4a9f578a-f325-364a-88d7-6f779f48604f', 12, 'XI', 'G.R.S. (Allegro di molto)', 'Variations on an Original Theme (‘Enigma’), op. 36: XI. G.R.S. (Allegro di molto)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 550 AND p.composer_id = 64
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:4a9f578a-f325-364a-88d7-6f779f48604f'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 13, part.movement_number = 'XII',
    part.name_ko = 'B.G.N. (Andante)', part.name_en = 'Variations on an Original Theme (‘Enigma’), op. 36: XII. B.G.N. (Andante)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 550 AND p.composer_id = 64 AND part.part_key = 'musicbrainz:5d130dca-7c4f-397f-b57a-22077abc1057' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:5d130dca-7c4f-397f-b57a-22077abc1057', 13, 'XII', 'B.G.N. (Andante)', 'Variations on an Original Theme (‘Enigma’), op. 36: XII. B.G.N. (Andante)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 550 AND p.composer_id = 64
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:5d130dca-7c4f-397f-b57a-22077abc1057'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 14, part.movement_number = 'XIII',
    part.name_ko = 'Romanza (Moderato)', part.name_en = 'Variations on an Original Theme (‘Enigma’), op. 36: XIII. Romanza (Moderato)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 550 AND p.composer_id = 64 AND part.part_key = 'musicbrainz:943602a3-9908-3788-bd8a-eb892d7b56e4' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:943602a3-9908-3788-bd8a-eb892d7b56e4', 14, 'XIII', 'Romanza (Moderato)', 'Variations on an Original Theme (‘Enigma’), op. 36: XIII. Romanza (Moderato)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 550 AND p.composer_id = 64
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:943602a3-9908-3788-bd8a-eb892d7b56e4'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 15, part.movement_number = 'XIV',
    part.name_ko = 'Finale: E.D.U. (Allegro)', part.name_en = 'Variations on an Original Theme (‘Enigma’), op. 36: XIV. Finale: E.D.U. (Allegro)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 550 AND p.composer_id = 64 AND part.part_key = 'musicbrainz:158c2361-9911-3636-9f39-0b8d41da09db' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:158c2361-9911-3636-9f39-0b8d41da09db', 15, 'XIV', 'Finale: E.D.U. (Allegro)', 'Variations on an Original Theme (‘Enigma’), op. 36: XIV. Finale: E.D.U. (Allegro)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 550 AND p.composer_id = 64
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:158c2361-9911-3636-9f39-0b8d41da09db'
);


-- Op. 22 Very Easy Melodious Exercises in the First Position for Violin With Pianoforte Accompaniment Op. 22

UPDATE pieces piece
SET piece.title = 'Very Easy Melodious Exercises in the First Position for Violin With Pianoforte Accompaniment Op. 22', piece.title_en = 'Very Easy Melodious Exercises in the First Position for Violin With Pianoforte Accompaniment, op. 22',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = 'Op.', piece.catalogue_number = '22',
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 1634 AND piece.composer_id = 64
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'Andante', part.name_en = 'Very Easy Melodious Exercises in the First Position for Violin With Pianoforte Accompaniment, op. 22 no. 1: Andante',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 1634 AND p.composer_id = 64 AND part.part_key = 'musicbrainz:243b45f8-25a5-4633-b849-3a525cc7d8d2' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:243b45f8-25a5-4633-b849-3a525cc7d8d2', 1, NULL, 'Andante', 'Very Easy Melodious Exercises in the First Position for Violin With Pianoforte Accompaniment, op. 22 no. 1: Andante', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 1634 AND p.composer_id = 64
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:243b45f8-25a5-4633-b849-3a525cc7d8d2'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'Allegretto', part.name_en = 'Very Easy Melodious Exercises in the First Position for Violin With Pianoforte Accompaniment, op. 22 no. 2: Allegretto',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 1634 AND p.composer_id = 64 AND part.part_key = 'musicbrainz:c6246435-a601-4726-b427-430b148167a9' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:c6246435-a601-4726-b427-430b148167a9', 2, NULL, 'Allegretto', 'Very Easy Melodious Exercises in the First Position for Violin With Pianoforte Accompaniment, op. 22 no. 2: Allegretto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 1634 AND p.composer_id = 64
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:c6246435-a601-4726-b427-430b148167a9'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = NULL,
    part.name_ko = 'Andante', part.name_en = 'Very Easy Melodious Exercises in the First Position for Violin With Pianoforte Accompaniment, op. 22 no. 3: Andante',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 1634 AND p.composer_id = 64 AND part.part_key = 'musicbrainz:7f9664fa-e83b-46ec-b781-5827f05c6b60' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:7f9664fa-e83b-46ec-b781-5827f05c6b60', 3, NULL, 'Andante', 'Very Easy Melodious Exercises in the First Position for Violin With Pianoforte Accompaniment, op. 22 no. 3: Andante', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 1634 AND p.composer_id = 64
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:7f9664fa-e83b-46ec-b781-5827f05c6b60'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = NULL,
    part.name_ko = 'Andantino', part.name_en = 'Very Easy Melodious Exercises in the First Position for Violin With Pianoforte Accompaniment, op. 22 no. 4: Andantino',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 1634 AND p.composer_id = 64 AND part.part_key = 'musicbrainz:5d6568b4-2789-4166-9756-167feec8d87b' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:5d6568b4-2789-4166-9756-167feec8d87b', 4, NULL, 'Andantino', 'Very Easy Melodious Exercises in the First Position for Violin With Pianoforte Accompaniment, op. 22 no. 4: Andantino', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 1634 AND p.composer_id = 64
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:5d6568b4-2789-4166-9756-167feec8d87b'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 5, part.movement_number = NULL,
    part.name_ko = 'Allegretto', part.name_en = 'Very Easy Melodious Exercises in the First Position for Violin With Pianoforte Accompaniment, op. 22 no. 5: Allegretto',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 1634 AND p.composer_id = 64 AND part.part_key = 'musicbrainz:68e4f615-c5ad-4371-ba56-cf3fa1763897' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:68e4f615-c5ad-4371-ba56-cf3fa1763897', 5, NULL, 'Allegretto', 'Very Easy Melodious Exercises in the First Position for Violin With Pianoforte Accompaniment, op. 22 no. 5: Allegretto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 1634 AND p.composer_id = 64
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:68e4f615-c5ad-4371-ba56-cf3fa1763897'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 6, part.movement_number = NULL,
    part.name_ko = 'Allegro', part.name_en = 'Very Easy Melodious Exercises in the First Position for Violin With Pianoforte Accompaniment, op. 22 no. 6: Allegro',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 1634 AND p.composer_id = 64 AND part.part_key = 'musicbrainz:cb1e1b5a-0687-48da-8a0f-63327bd71c6d' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:cb1e1b5a-0687-48da-8a0f-63327bd71c6d', 6, NULL, 'Allegro', 'Very Easy Melodious Exercises in the First Position for Violin With Pianoforte Accompaniment, op. 22 no. 6: Allegro', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 1634 AND p.composer_id = 64
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:cb1e1b5a-0687-48da-8a0f-63327bd71c6d'
);


-- Op. 14 Vesper Voluntaries

UPDATE pieces piece
SET piece.title = 'Vesper Voluntaries', piece.title_en = 'Vesper Voluntaries, op. 14',
    piece.type = 'album', piece.opus_number = 'Op. 14',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 1612 AND piece.composer_id = 64
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'Introduction and Andante', part.name_en = 'Vesper Voluntaries, op. 14: I. Introduction and Andante',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 1612 AND p.composer_id = 64 AND part.part_key = 'musicbrainz:67507979-76d9-40a7-b07a-167cca8e8ca9' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:67507979-76d9-40a7-b07a-167cca8e8ca9', 1, 'I', 'Introduction and Andante', 'Vesper Voluntaries, op. 14: I. Introduction and Andante', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 1612 AND p.composer_id = 64
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:67507979-76d9-40a7-b07a-167cca8e8ca9'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'Allegro', part.name_en = 'Vesper Voluntaries, op. 14: II. Allegro',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 1612 AND p.composer_id = 64 AND part.part_key = 'musicbrainz:e9b37dfb-49c5-4677-b8d9-49c2cb43afb0' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:e9b37dfb-49c5-4677-b8d9-49c2cb43afb0', 2, 'II', 'Allegro', 'Vesper Voluntaries, op. 14: II. Allegro', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 1612 AND p.composer_id = 64
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:e9b37dfb-49c5-4677-b8d9-49c2cb43afb0'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = 'Andantino', part.name_en = 'Vesper Voluntaries, op. 14: III. Andantino',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 1612 AND p.composer_id = 64 AND part.part_key = 'musicbrainz:506a9e2a-5aac-4c3a-8987-31a5f531bdbf' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:506a9e2a-5aac-4c3a-8987-31a5f531bdbf', 3, 'III', 'Andantino', 'Vesper Voluntaries, op. 14: III. Andantino', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 1612 AND p.composer_id = 64
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:506a9e2a-5aac-4c3a-8987-31a5f531bdbf'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = 'IV',
    part.name_ko = 'Allegretto piacevole (Intermezzo)', part.name_en = 'Vesper Voluntaries, op. 14: IV. Allegretto piacevole (Intermezzo)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 1612 AND p.composer_id = 64 AND part.part_key = 'musicbrainz:f9360c60-75b8-4bff-8da9-f60f53bee601' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:f9360c60-75b8-4bff-8da9-f60f53bee601', 4, 'IV', 'Allegretto piacevole (Intermezzo)', 'Vesper Voluntaries, op. 14: IV. Allegretto piacevole (Intermezzo)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 1612 AND p.composer_id = 64
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:f9360c60-75b8-4bff-8da9-f60f53bee601'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 5, part.movement_number = 'V',
    part.name_ko = 'Poco lento', part.name_en = 'Vesper Voluntaries, op. 14: V. Poco lento',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 1612 AND p.composer_id = 64 AND part.part_key = 'musicbrainz:e0c31f22-8f11-4d70-b4db-db5f60cad6a9' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:e0c31f22-8f11-4d70-b4db-db5f60cad6a9', 5, 'V', 'Poco lento', 'Vesper Voluntaries, op. 14: V. Poco lento', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 1612 AND p.composer_id = 64
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:e0c31f22-8f11-4d70-b4db-db5f60cad6a9'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 6, part.movement_number = 'VI',
    part.name_ko = 'Moderato', part.name_en = 'Vesper Voluntaries, op. 14: VI. Moderato',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 1612 AND p.composer_id = 64 AND part.part_key = 'musicbrainz:f6712ac4-b881-4319-83d8-aaf17434d83f' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:f6712ac4-b881-4319-83d8-aaf17434d83f', 6, 'VI', 'Moderato', 'Vesper Voluntaries, op. 14: VI. Moderato', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 1612 AND p.composer_id = 64
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:f6712ac4-b881-4319-83d8-aaf17434d83f'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 7, part.movement_number = 'VII',
    part.name_ko = 'Allegretto pensoso', part.name_en = 'Vesper Voluntaries, op. 14: VII. Allegretto pensoso',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 1612 AND p.composer_id = 64 AND part.part_key = 'musicbrainz:c589b45b-218f-4d1a-9644-f4b5cf697c3a' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:c589b45b-218f-4d1a-9644-f4b5cf697c3a', 7, 'VII', 'Allegretto pensoso', 'Vesper Voluntaries, op. 14: VII. Allegretto pensoso', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 1612 AND p.composer_id = 64
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:c589b45b-218f-4d1a-9644-f4b5cf697c3a'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 8, part.movement_number = 'VIII',
    part.name_ko = 'Poco allegro and Coda', part.name_en = 'Vesper Voluntaries, op. 14: VIII. Poco allegro and Coda',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 1612 AND p.composer_id = 64 AND part.part_key = 'musicbrainz:d3b34e7d-d647-48a7-bbab-f756d26afa6c' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:d3b34e7d-d647-48a7-bbab-f756d26afa6c', 8, 'VIII', 'Poco allegro and Coda', 'Vesper Voluntaries, op. 14: VIII. Poco allegro and Coda', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 1612 AND p.composer_id = 64
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:d3b34e7d-d647-48a7-bbab-f756d26afa6c'
);


-- Op. 61 바이올린 협주곡 B단조

UPDATE pieces piece
SET piece.title = '바이올린 협주곡 B단조', piece.title_en = 'Violin Concerto in B minor, op. 61',
    piece.type = 'album', piece.opus_number = 'Op. 61',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 2536 AND piece.composer_id = 64
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'Allegro', part.name_en = 'Violin Concerto in B minor, op. 61: I. Allegro',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 2536 AND p.composer_id = 64 AND part.part_key = 'musicbrainz:8dc4d3d2-7490-394e-b742-9004c0c247cf' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:8dc4d3d2-7490-394e-b742-9004c0c247cf', 1, 'I', 'Allegro', 'Violin Concerto in B minor, op. 61: I. Allegro', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 2536 AND p.composer_id = 64
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:8dc4d3d2-7490-394e-b742-9004c0c247cf'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'Andante', part.name_en = 'Violin Concerto in B minor, op. 61: II. Andante',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 2536 AND p.composer_id = 64 AND part.part_key = 'musicbrainz:0b14c9ba-fa66-329a-a417-6f2bc393ade4' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:0b14c9ba-fa66-329a-a417-6f2bc393ade4', 2, 'II', 'Andante', 'Violin Concerto in B minor, op. 61: II. Andante', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 2536 AND p.composer_id = 64
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:0b14c9ba-fa66-329a-a417-6f2bc393ade4'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = 'Allegro molto — Cadenza (Accompagnata: Lento) - Allegro Molto', part.name_en = 'Violin Concerto in B minor, op. 61: III. Allegro molto — Cadenza (Accompagnata: Lento) - Allegro Molto',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 2536 AND p.composer_id = 64 AND part.part_key = 'musicbrainz:47b2357a-1ef5-3cb7-bd76-0654e6ac33cf' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:47b2357a-1ef5-3cb7-bd76-0654e6ac33cf', 3, 'III', 'Allegro molto — Cadenza (Accompagnata: Lento) - Allegro Molto', 'Violin Concerto in B minor, op. 61: III. Allegro molto — Cadenza (Accompagnata: Lento) - Allegro Molto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 2536 AND p.composer_id = 64
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:47b2357a-1ef5-3cb7-bd76-0654e6ac33cf'
);


-- None We will remember them

UPDATE pieces piece
SET piece.title = 'We will remember them', piece.title_en = 'We will remember them',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 1014 AND piece.composer_id = 64
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None 가곡 <Weary Wind of the West>

UPDATE pieces piece
SET piece.title = '가곡 <Weary Wind of the West>', piece.title_en = 'Weary Wind of the West',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 1635 AND piece.composer_id = 64
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- Op. 24 Études caractéristiques

UPDATE pieces piece
SET piece.title = 'Études caractéristiques', piece.title_en = 'Études caractéristiques, op. 24',
    piece.type = 'song', piece.opus_number = 'Op. 24',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 2929 AND piece.composer_id = 64
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Adieu

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, 'Adieu', 'Adieu', 'song', NULL, NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 64
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = 'Adieu'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'a66d8080-5cb6-4dba-8cd8-0249c826f066'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'a66d8080-5cb6-4dba-8cd8-0249c826f066'
FROM pieces p
WHERE p.composer_id = 64 AND p.title = 'Adieu' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'a66d8080-5cb6-4dba-8cd8-0249c826f066'
);


-- None Ave maris stella

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, 'Ave maris stella', 'Ave maris stella', 'song', NULL, NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 64
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = 'Ave maris stella'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'd74f6326-c15f-4ab7-90c9-19f91341ed5f'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'd74f6326-c15f-4ab7-90c9-19f91341ed5f'
FROM pieces p
WHERE p.composer_id = 64 AND p.title = 'Ave maris stella' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'd74f6326-c15f-4ab7-90c9-19f91341ed5f'
);


-- None Carissima

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, 'Carissima', 'Carissima', 'song', NULL, NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 64
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = 'Carissima'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'a5c78b93-a252-4518-b293-8c38e8a822f1'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'a5c78b93-a252-4518-b293-8c38e8a822f1'
FROM pieces p
WHERE p.composer_id = 64 AND p.title = 'Carissima' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'a5c78b93-a252-4518-b293-8c38e8a822f1'
);


-- Op. 65 Coronation March

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, 'Coronation March', 'Coronation March, op. 65', 'song', 'Op. 65', NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 64
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = 'Coronation March'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'bdd1bc67-6f5e-4bd6-aa11-85c56509424b'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'bdd1bc67-6f5e-4bd6-aa11-85c56509424b'
FROM pieces p
WHERE p.composer_id = 64 AND p.title = 'Coronation March' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'bdd1bc67-6f5e-4bd6-aa11-85c56509424b'
);


-- Op. 43 Dream Children

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, 'Dream Children', 'Dream Children, op. 43', 'album', 'Op. 43', NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 64
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = 'Dream Children'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '3f5a89a5-9f0a-4469-be12-32b3c6c000df'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '3f5a89a5-9f0a-4469-be12-32b3c6c000df'
FROM pieces p
WHERE p.composer_id = 64 AND p.title = 'Dream Children' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '3f5a89a5-9f0a-4469-be12-32b3c6c000df'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:1ff917f4-f3fa-4fde-a0f3-6489f29d6524', 1, 'I', 'Andante', 'Dream Children, op. 43: I. Andante', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 64 AND p.title = 'Dream Children' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:1ff917f4-f3fa-4fde-a0f3-6489f29d6524'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:d5789fd2-ce7f-43b6-ae7f-0de92513eda3', 2, 'II', 'Allegretto piacevole', 'Dream Children, op. 43: II. Allegretto piacevole', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 64 AND p.title = 'Dream Children' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:d5789fd2-ce7f-43b6-ae7f-0de92513eda3'
);


-- None Ecce sacerdos magnus

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, 'Ecce sacerdos magnus', 'Ecce sacerdos magnus', 'song', NULL, NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 64
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = 'Ecce sacerdos magnus'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '49cf4ffd-0ddb-4901-b01c-1455b4329ad2'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '49cf4ffd-0ddb-4901-b01c-1455b4329ad2'
FROM pieces p
WHERE p.composer_id = 64 AND p.title = 'Ecce sacerdos magnus' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '49cf4ffd-0ddb-4901-b01c-1455b4329ad2'
);


-- None Empire March

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, 'Empire March', 'Empire March', 'song', NULL, NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 64
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = 'Empire March'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '603c69c8-b446-4df7-ba6f-91f4ad133f63'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '603c69c8-b446-4df7-ba6f-91f4ad133f63'
FROM pieces p
WHERE p.composer_id = 64 AND p.title = 'Empire March' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '603c69c8-b446-4df7-ba6f-91f4ad133f63'
);


-- None 푸가 D단조

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '푸가 D단조', 'Fugue in D minor', 'song', NULL, NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 64
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '푸가 D단조'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '158ebf4e-f110-40b7-a577-fbf4136d16ce'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '158ebf4e-f110-40b7-a577-fbf4136d16ce'
FROM pieces p
WHERE p.composer_id = 64 AND p.title = '푸가 D단조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '158ebf4e-f110-40b7-a577-fbf4136d16ce'
);


-- Op. 32 Imperial March

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, 'Imperial March', 'Imperial March, op. 32', 'song', 'Op. 32', NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 64
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = 'Imperial March'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '0da1d8c8-4ae6-3761-8bce-78f22b27e71a'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '0da1d8c8-4ae6-3761-8bce-78f22b27e71a'
FROM pieces p
WHERE p.composer_id = 64 AND p.title = 'Imperial March' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '0da1d8c8-4ae6-3761-8bce-78f22b27e71a'
);


-- Op. 17 La Capricieuse

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, 'La Capricieuse', 'La Capricieuse, op. 17', 'song', 'Op. 17', NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 64
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = 'La Capricieuse'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '3e4dae0d-a278-4787-860b-0ef8d10fd758'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '3e4dae0d-a278-4787-860b-0ef8d10fd758'
FROM pieces p
WHERE p.composer_id = 64 AND p.title = 'La Capricieuse' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '3e4dae0d-a278-4787-860b-0ef8d10fd758'
);


-- Op. 18 No. 2 가곡 <Love>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '가곡 <Love>', 'Love, op. 18 no. 2', 'song', 'Op. 18 No. 2', NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 64
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '가곡 <Love>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '620563cf-9744-427c-8716-e43508c75de6'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '620563cf-9744-427c-8716-e43508c75de6'
FROM pieces p
WHERE p.composer_id = 64 AND p.title = '가곡 <Love>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '620563cf-9744-427c-8716-e43508c75de6'
);


-- None May Song

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, 'May Song', 'May Song', 'song', NULL, NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 64
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = 'May Song'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '297a9743-4ffa-40fb-bbc2-d61ed4121b5e'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '297a9743-4ffa-40fb-bbc2-d61ed4121b5e'
FROM pieces p
WHERE p.composer_id = 64 AND p.title = 'May Song' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '297a9743-4ffa-40fb-bbc2-d61ed4121b5e'
);


-- Op. 13 No. 1 Mot d'amour

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, 'Mot d''amour', 'Mot d''amour, op. 13 no. 1', 'song', 'Op. 13 No. 1', NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 64
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = 'Mot d''amour'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '21110446-8e8d-4566-aa6c-aa4f6b51e2ba'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '21110446-8e8d-4566-aa6c-aa4f6b51e2ba'
FROM pieces p
WHERE p.composer_id = 64 AND p.title = 'Mot d''amour' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '21110446-8e8d-4566-aa6c-aa4f6b51e2ba'
);


-- None O Salutaris hostia

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, 'O Salutaris hostia', 'O Salutaris hostia', 'song', NULL, NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 64
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = 'O Salutaris hostia'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '6e6faa11-1e18-4e64-9cbe-7359f05aabc4'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '6e6faa11-1e18-4e64-9cbe-7359f05aabc4'
FROM pieces p
WHERE p.composer_id = 64 AND p.title = 'O Salutaris hostia' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '6e6faa11-1e18-4e64-9cbe-7359f05aabc4'
);


-- Op. 28 오르간 소나타 G장조

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '오르간 소나타 G장조', 'Organ Sonata in G major, op. 28', 'album', 'Op. 28', NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 64
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '오르간 소나타 G장조'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '63d3591d-5e58-4143-8111-3852b420ec72'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '63d3591d-5e58-4143-8111-3852b420ec72'
FROM pieces p
WHERE p.composer_id = 64 AND p.title = '오르간 소나타 G장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '63d3591d-5e58-4143-8111-3852b420ec72'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:7aa0db3a-d8cb-38d2-8033-5d0087dd4db3', 1, 'I', 'Allegro maestoso', 'Organ Sonata in G major, op. 28: I. Allegro maestoso', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 64 AND p.title = '오르간 소나타 G장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:7aa0db3a-d8cb-38d2-8033-5d0087dd4db3'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:fbcf7644-4fee-3164-bf22-1c9d326668a0', 2, 'II', 'Allegretto', 'Organ Sonata in G major, op. 28: II. Allegretto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 64 AND p.title = '오르간 소나타 G장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:fbcf7644-4fee-3164-bf22-1c9d326668a0'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:848327cf-7ab6-337a-9bca-943d4dfb7e2f', 3, 'III', 'Andante espressivo', 'Organ Sonata in G major, op. 28: III. Andante espressivo', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 64 AND p.title = '오르간 소나타 G장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:848327cf-7ab6-337a-9bca-943d4dfb7e2f'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:d7119c91-2944-333d-943b-a68209279555', 4, 'IV', 'Presto', 'Organ Sonata in G major, op. 28: IV. Presto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 64 AND p.title = '오르간 소나타 G장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:d7119c91-2944-333d-943b-a68209279555'
);


-- Op. 84 피아노 5중주 A단조

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '피아노 5중주 A단조', 'Piano Quintet in A minor, op. 84', 'album', 'Op. 84', NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 64
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '피아노 5중주 A단조'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '26ef058f-eaa5-4f7a-af37-1d600bae66fd'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '26ef058f-eaa5-4f7a-af37-1d600bae66fd'
FROM pieces p
WHERE p.composer_id = 64 AND p.title = '피아노 5중주 A단조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '26ef058f-eaa5-4f7a-af37-1d600bae66fd'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:1f7d3dab-1471-374e-a158-51ea9c3bf411', 1, 'I', 'Moderato', 'Piano Quintet in A minor, op. 84: I. Moderato', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 64 AND p.title = '피아노 5중주 A단조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:1f7d3dab-1471-374e-a158-51ea9c3bf411'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:1ebc9448-9633-38f9-a761-f6925c4d25d6', 2, 'II', 'Adagio', 'Piano Quintet in A minor, op. 84: II. Adagio', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 64 AND p.title = '피아노 5중주 A단조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:1ebc9448-9633-38f9-a761-f6925c4d25d6'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:cacd27bb-f4be-3878-91cc-61caa8499efc', 3, 'III', 'Andante – Allegro', 'Piano Quintet in A minor, op. 84: III. Andante – Allegro', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 64 AND p.title = '피아노 5중주 A단조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:cacd27bb-f4be-3878-91cc-61caa8499efc'
);


-- Op. 1 로망스 G장조

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '로망스 G장조', 'Romance, op. 1', 'song', 'Op. 1', NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 64
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '로망스 G장조'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '1923f977-a380-4464-8c34-f48c6d95f2be'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '1923f977-a380-4464-8c34-f48c6d95f2be'
FROM pieces p
WHERE p.composer_id = 64 AND p.title = '로망스 G장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '1923f977-a380-4464-8c34-f48c6d95f2be'
);


-- Op. 62 로망스

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '로망스', 'Romance, op. 62', 'song', 'Op. 62', NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 64
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '로망스'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '1b863c23-0c72-4b6e-badf-c76a2435b335'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '1b863c23-0c72-4b6e-badf-c76a2435b335'
FROM pieces p
WHERE p.composer_id = 64 AND p.title = '로망스' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '1b863c23-0c72-4b6e-badf-c76a2435b335'
);


-- None Rosemary (“That’s for Remembrance”)

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, 'Rosemary (“That’s for Remembrance”)', 'Rosemary (“That’s for Remembrance”)', 'song', NULL, NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 64
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = 'Rosemary (“That’s for Remembrance”)'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '524e28e1-178f-436c-96bf-b02fe64b28eb'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '524e28e1-178f-436c-96bf-b02fe64b28eb'
FROM pieces p
WHERE p.composer_id = 64 AND p.title = 'Rosemary (“That’s for Remembrance”)' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '524e28e1-178f-436c-96bf-b02fe64b28eb'
);


-- Op. 12 Salut d’amour

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, 'Salut d’amour', 'Salut d’amour, op. 12', 'song', 'Op. 12', NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 64
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = 'Salut d’amour'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'e49c8de1-bbd9-446e-ac59-c1966792c1e3'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'e49c8de1-bbd9-446e-ac59-c1966792c1e3'
FROM pieces p
WHERE p.composer_id = 64 AND p.title = 'Salut d’amour' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'e49c8de1-bbd9-446e-ac59-c1966792c1e3'
);


-- None 세레나데

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '세레나데', 'Serenade', 'song', NULL, NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 64
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '세레나데'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'f8ff1403-2b22-4815-bcb1-777eb1045a67'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'f8ff1403-2b22-4815-bcb1-777eb1045a67'
FROM pieces p
WHERE p.composer_id = 64 AND p.title = '세레나데' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'f8ff1403-2b22-4815-bcb1-777eb1045a67'
);


-- Op. 20 현악 세레나데 E단조

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '현악 세레나데 E단조', 'Serenade for Strings in E minor, op. 20', 'album', 'Op. 20', NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 64
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '현악 세레나데 E단조'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'af19cd3d-d69d-46bd-80e4-a298f1a7c09e'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'af19cd3d-d69d-46bd-80e4-a298f1a7c09e'
FROM pieces p
WHERE p.composer_id = 64 AND p.title = '현악 세레나데 E단조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'af19cd3d-d69d-46bd-80e4-a298f1a7c09e'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:969bcbec-c041-3eda-8fea-cec6d47850ed', 1, 'I', 'Allegro piacevole', 'Serenade for Strings in E minor, op. 20: I. Allegro piacevole', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 64 AND p.title = '현악 세레나데 E단조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:969bcbec-c041-3eda-8fea-cec6d47850ed'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:c8baf54c-92cf-369b-9c90-2d41c3c1e95d', 2, 'II', 'Larghetto', 'Serenade for Strings in E minor, op. 20: II. Larghetto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 64 AND p.title = '현악 세레나데 E단조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:c8baf54c-92cf-369b-9c90-2d41c3c1e95d'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:097a008e-4ddc-39ab-8c35-0f906d7d028d', 3, 'III', 'Allegretto', 'Serenade for Strings in E minor, op. 20: III. Allegretto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 64 AND p.title = '현악 세레나데 E단조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:097a008e-4ddc-39ab-8c35-0f906d7d028d'
);


-- None Soliloquy

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, 'Soliloquy', 'Soliloquy', 'song', NULL, NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 64
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = 'Soliloquy'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '105dd7d0-cad5-4102-b241-31be48371a64'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '105dd7d0-cad5-4102-b241-31be48371a64'
FROM pieces p
WHERE p.composer_id = 64 AND p.title = 'Soliloquy' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '105dd7d0-cad5-4102-b241-31be48371a64'
);


-- Op. 70 Sospiri

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, 'Sospiri', 'Sospiri, op. 70', 'song', 'Op. 70', NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 64
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = 'Sospiri'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '074617b5-5e0b-41f9-9a3c-3afccac1fa3e'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '074617b5-5e0b-41f9-9a3c-3afccac1fa3e'
FROM pieces p
WHERE p.composer_id = 64 AND p.title = 'Sospiri' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '074617b5-5e0b-41f9-9a3c-3afccac1fa3e'
);


-- Op. 34 Te Deum and Benedictus

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, 'Te Deum and Benedictus', 'Te Deum and Benedictus, op. 34', 'song', 'Op. 34', NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 64
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = 'Te Deum and Benedictus'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '13feae4b-9b1e-4b19-9dce-4697b2b613c8'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '13feae4b-9b1e-4b19-9dce-4697b2b613c8'
FROM pieces p
WHERE p.composer_id = 64 AND p.title = 'Te Deum and Benedictus' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '13feae4b-9b1e-4b19-9dce-4697b2b613c8'
);


-- None 가곡 <The Pipes of Pan>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '가곡 <The Pipes of Pan>', 'The Pipes of Pan', 'song', NULL, NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 64
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '가곡 <The Pipes of Pan>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '9ba1ad8e-49fb-4cc6-99ff-678cdb1cd097'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '9ba1ad8e-49fb-4cc6-99ff-678cdb1cd097'
FROM pieces p
WHERE p.composer_id = 64 AND p.title = '가곡 <The Pipes of Pan>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '9ba1ad8e-49fb-4cc6-99ff-678cdb1cd097'
);


-- None The Prince of Sleep

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, 'The Prince of Sleep', 'The Prince of Sleep', 'song', NULL, NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 64
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = 'The Prince of Sleep'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '602e89c4-ae87-44d7-9ae2-6cd8962b15f0'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '602e89c4-ae87-44d7-9ae2-6cd8962b15f0'
FROM pieces p
WHERE p.composer_id = 64 AND p.title = 'The Prince of Sleep' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '602e89c4-ae87-44d7-9ae2-6cd8962b15f0'
);


-- None 가곡 <The Wind at Dawn>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '가곡 <The Wind at Dawn>', 'The Wind at Dawn', 'song', NULL, NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 64
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '가곡 <The Wind at Dawn>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '86d8a0a6-5534-48e7-8426-8f49ebcebdda'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '86d8a0a6-5534-48e7-8426-8f49ebcebdda'
FROM pieces p
WHERE p.composer_id = 64 AND p.title = '가곡 <The Wind at Dawn>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '86d8a0a6-5534-48e7-8426-8f49ebcebdda'
);


-- 카탈로그에 대응이 없는 seed 작품 40개를 목록에서 숨긴다(지우지 않음).
UPDATE pieces piece
SET piece.hidden_reason = 'catalog_unmatched'
WHERE piece.composer_id = 64 AND piece.origin = 'seed' AND piece.hidden_reason IS NULL
  AND piece.id IN (
    499, 649, 750, 823, 824, 826, 889, 1016, 1093, 1203, 1239, 1247, 1264, 1314, 1454, 1517, 1523, 1631, 1667, 1735,
    1801, 1871, 1908, 2045, 2085, 2088, 2167, 2173, 2207, 2422, 2498, 2515, 2576, 2621, 2640, 2673, 2840, 2873, 2960, 2962
  )
  AND NOT EXISTS (SELECT 1 FROM performance_sectors sector WHERE sector.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM piece_parts linking WHERE linking.linked_piece_id = piece.id);
