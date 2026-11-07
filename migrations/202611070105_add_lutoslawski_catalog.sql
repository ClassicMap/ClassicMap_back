-- 루토스와프스키 작품을 MusicBrainz 작품 구조로 다시 짠다(5차 자동). 작품 59개(묶음 10, 다악장 21, 낱곡 28),
-- 새 작품 8개, part 141개, 그 아래 0개.
-- seed 55개 중 49개를 작품·part 에 잇고, 6개를 숨기고, 0개는 그대로 둔다.
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

-- None 5 Folk Melodies

UPDATE pieces piece
SET piece.title = '5 Folk Melodies', piece.title_en = '5 Folk Melodies',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 2851 AND piece.composer_id = 110
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'Oh, My Jeannot', part.name_en = '5 Folk Melodies, No. 1: Oh, My Jeannot',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 2851 AND p.composer_id = 110 AND part.part_key = 'musicbrainz:c8d1528d-17c4-4a08-b2fb-b204e052dbc1' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:c8d1528d-17c4-4a08-b2fb-b204e052dbc1', 1, NULL, 'Oh, My Jeannot', '5 Folk Melodies, No. 1: Oh, My Jeannot', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 2851 AND p.composer_id = 110
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:c8d1528d-17c4-4a08-b2fb-b204e052dbc1'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'Hi! I''m from Cracow', part.name_en = '5 Folk Melodies, No. 2: Hi! I''m from Cracow',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 2851 AND p.composer_id = 110 AND part.part_key = 'musicbrainz:02170dbd-4aeb-42ca-8124-43183ddc3a5a' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:02170dbd-4aeb-42ca-8124-43183ddc3a5a', 2, NULL, 'Hi! I''m from Cracow', '5 Folk Melodies, No. 2: Hi! I''m from Cracow', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 2851 AND p.composer_id = 110
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:02170dbd-4aeb-42ca-8124-43183ddc3a5a'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = NULL,
    part.name_ko = 'The Grove', part.name_en = '5 Folk Melodies, No. 3: The Grove',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 2851 AND p.composer_id = 110 AND part.part_key = 'musicbrainz:d7c6062f-57ff-4e46-8490-1dc5b1cd1780' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:d7c6062f-57ff-4e46-8490-1dc5b1cd1780', 3, NULL, 'The Grove', '5 Folk Melodies, No. 3: The Grove', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 2851 AND p.composer_id = 110
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:d7c6062f-57ff-4e46-8490-1dc5b1cd1780'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = NULL,
    part.name_ko = 'The Gander', part.name_en = '5 Folk Melodies, No. 4: The Gander',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 2851 AND p.composer_id = 110 AND part.part_key = 'musicbrainz:ffbdb597-912c-4bdd-9c63-9dc29193be4d' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:ffbdb597-912c-4bdd-9c63-9dc29193be4d', 4, NULL, 'The Gander', '5 Folk Melodies, No. 4: The Gander', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 2851 AND p.composer_id = 110
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:ffbdb597-912c-4bdd-9c63-9dc29193be4d'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 5, part.movement_number = NULL,
    part.name_ko = 'The School Master', part.name_en = '5 Folk Melodies, No. 5: The School Master',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 2851 AND p.composer_id = 110 AND part.part_key = 'musicbrainz:70299e92-9125-4f08-8e4a-e98acd362391' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:70299e92-9125-4f08-8e4a-e98acd362391', 5, NULL, 'The School Master', '5 Folk Melodies, No. 5: The School Master', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 2851 AND p.composer_id = 110
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:70299e92-9125-4f08-8e4a-e98acd362391'
);


-- None Bucoliques

UPDATE pieces piece
SET piece.title = 'Bucoliques', piece.title_en = 'Bucoliques',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 2676 AND piece.composer_id = 110
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'Allegro vivace', part.name_en = 'Bucoliques: 1. Allegro vivace',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 2676 AND p.composer_id = 110 AND part.part_key = 'musicbrainz:ead95b8b-e2c5-443b-8639-603dd1e6b4be' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:ead95b8b-e2c5-443b-8639-603dd1e6b4be', 1, NULL, 'Allegro vivace', 'Bucoliques: 1. Allegro vivace', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 2676 AND p.composer_id = 110
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:ead95b8b-e2c5-443b-8639-603dd1e6b4be'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'Allegro sostenuto', part.name_en = 'Bucoliques: 2. Allegro sostenuto',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 2676 AND p.composer_id = 110 AND part.part_key = 'musicbrainz:fadc4ab4-ca15-4d3b-8ed6-ee0e856225a1' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:fadc4ab4-ca15-4d3b-8ed6-ee0e856225a1', 2, NULL, 'Allegro sostenuto', 'Bucoliques: 2. Allegro sostenuto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 2676 AND p.composer_id = 110
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:fadc4ab4-ca15-4d3b-8ed6-ee0e856225a1'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = NULL,
    part.name_ko = 'Allegro molto', part.name_en = 'Bucoliques: 3. Allegro molto',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 2676 AND p.composer_id = 110 AND part.part_key = 'musicbrainz:01df2a6f-6604-4e65-a1b7-040b9b5aabba' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:01df2a6f-6604-4e65-a1b7-040b9b5aabba', 3, NULL, 'Allegro molto', 'Bucoliques: 3. Allegro molto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 2676 AND p.composer_id = 110
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:01df2a6f-6604-4e65-a1b7-040b9b5aabba'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = NULL,
    part.name_ko = 'Andantino', part.name_en = 'Bucoliques: 4. Andantino',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 2676 AND p.composer_id = 110 AND part.part_key = 'musicbrainz:c55b9f77-907e-4c22-a075-5825e58c68a1' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:c55b9f77-907e-4c22-a075-5825e58c68a1', 4, NULL, 'Andantino', 'Bucoliques: 4. Andantino', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 2676 AND p.composer_id = 110
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:c55b9f77-907e-4c22-a075-5825e58c68a1'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 5, part.movement_number = NULL,
    part.name_ko = 'Allegro marciale', part.name_en = 'Bucoliques: 5. Allegro marciale',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 2676 AND p.composer_id = 110 AND part.part_key = 'musicbrainz:8cd75938-6e5f-4b43-bcc7-d62dc2c1b570' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:8cd75938-6e5f-4b43-bcc7-d62dc2c1b570', 5, NULL, 'Allegro marciale', 'Bucoliques: 5. Allegro marciale', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 2676 AND p.composer_id = 110
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:8cd75938-6e5f-4b43-bcc7-d62dc2c1b570'
);


-- None Chain 1

UPDATE pieces piece
SET piece.title = 'Chain 1', piece.title_en = 'Chain 1',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 1440 AND piece.composer_id = 110
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Chain 2, Dialogue for Violin and Orchestra

UPDATE pieces piece
SET piece.title = 'Chain 2, Dialogue for Violin and Orchestra', piece.title_en = 'Chain 2, Dialogue for Violin and Orchestra',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 2118 AND piece.composer_id = 110
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'Ad libitum', part.name_en = 'Chain 2, Dialogue for Violin and Orchestra: I. Ad libitum',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 2118 AND p.composer_id = 110 AND part.part_key = 'musicbrainz:f5310742-8714-3634-90e7-b8cb035c1e3f' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:f5310742-8714-3634-90e7-b8cb035c1e3f', 1, 'I', 'Ad libitum', 'Chain 2, Dialogue for Violin and Orchestra: I. Ad libitum', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 2118 AND p.composer_id = 110
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:f5310742-8714-3634-90e7-b8cb035c1e3f'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'A battuta', part.name_en = 'Chain 2, Dialogue for Violin and Orchestra: II. A battuta',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 2118 AND p.composer_id = 110 AND part.part_key = 'musicbrainz:4106ce1c-3397-3db1-94f4-5d82e7ff758d' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:4106ce1c-3397-3db1-94f4-5d82e7ff758d', 2, 'II', 'A battuta', 'Chain 2, Dialogue for Violin and Orchestra: II. A battuta', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 2118 AND p.composer_id = 110
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:4106ce1c-3397-3db1-94f4-5d82e7ff758d'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = 'Ad libitum', part.name_en = 'Chain 2, Dialogue for Violin and Orchestra: III. Ad libitum',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 2118 AND p.composer_id = 110 AND part.part_key = 'musicbrainz:61a36864-8c40-382a-ae3e-cb46515c0240' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:61a36864-8c40-382a-ae3e-cb46515c0240', 3, 'III', 'Ad libitum', 'Chain 2, Dialogue for Violin and Orchestra: III. Ad libitum', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 2118 AND p.composer_id = 110
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:61a36864-8c40-382a-ae3e-cb46515c0240'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = 'IV',
    part.name_ko = 'A battuta - Ad libitum - A battuta', part.name_en = 'Chain 2, Dialogue for Violin and Orchestra: IV. A battuta - Ad libitum - A battuta',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 2118 AND p.composer_id = 110 AND part.part_key = 'musicbrainz:2a05545f-e79e-3512-a23d-06c02cef3393' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:2a05545f-e79e-3512-a23d-06c02cef3393', 4, 'IV', 'A battuta - Ad libitum - A battuta', 'Chain 2, Dialogue for Violin and Orchestra: IV. A battuta - Ad libitum - A battuta', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 2118 AND p.composer_id = 110
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:2a05545f-e79e-3512-a23d-06c02cef3393'
);


-- None Chain 3

UPDATE pieces piece
SET piece.title = 'Chain 3', piece.title_en = 'Chain 3',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 1090 AND piece.composer_id = 110
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Chantefleurs et Chantefables for soprano and orchestre

UPDATE pieces piece
SET piece.title = 'Chantefleurs et Chantefables for soprano and orchestre', piece.title_en = 'Chantefleurs et Chantefables for soprano and orchestre',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 1307 AND piece.composer_id = 110
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'La belle-de-nuit', part.name_en = 'Chantefleurs et Chantefables for soprano and orchestre: I. La belle-de-nuit',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 1307 AND p.composer_id = 110 AND part.part_key = 'musicbrainz:b6103692-f06f-3747-998c-16caeff581ad' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:b6103692-f06f-3747-998c-16caeff581ad', 1, 'I', 'La belle-de-nuit', 'Chantefleurs et Chantefables for soprano and orchestre: I. La belle-de-nuit', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 1307 AND p.composer_id = 110
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:b6103692-f06f-3747-998c-16caeff581ad'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'La sauterelle', part.name_en = 'Chantefleurs et Chantefables for soprano and orchestre: II. La sauterelle',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 1307 AND p.composer_id = 110 AND part.part_key = 'musicbrainz:b58249b3-5109-3cdc-86c1-b9ec9f0ed80a' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:b58249b3-5109-3cdc-86c1-b9ec9f0ed80a', 2, 'II', 'La sauterelle', 'Chantefleurs et Chantefables for soprano and orchestre: II. La sauterelle', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 1307 AND p.composer_id = 110
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:b58249b3-5109-3cdc-86c1-b9ec9f0ed80a'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = 'La véronique', part.name_en = 'Chantefleurs et Chantefables for soprano and orchestre: III. La véronique',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 1307 AND p.composer_id = 110 AND part.part_key = 'musicbrainz:e3ce554d-e3db-330c-9df9-f30f9a1c6105' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:e3ce554d-e3db-330c-9df9-f30f9a1c6105', 3, 'III', 'La véronique', 'Chantefleurs et Chantefables for soprano and orchestre: III. La véronique', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 1307 AND p.composer_id = 110
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:e3ce554d-e3db-330c-9df9-f30f9a1c6105'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = 'IV',
    part.name_ko = 'L''églantine, l''aubépine et la glycine', part.name_en = 'Chantefleurs et Chantefables for soprano and orchestre: IV. L''églantine, l''aubépine et la glycine',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 1307 AND p.composer_id = 110 AND part.part_key = 'musicbrainz:bb9e356f-3f1a-35f4-9129-17a49a65033b' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:bb9e356f-3f1a-35f4-9129-17a49a65033b', 4, 'IV', 'L''églantine, l''aubépine et la glycine', 'Chantefleurs et Chantefables for soprano and orchestre: IV. L''églantine, l''aubépine et la glycine', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 1307 AND p.composer_id = 110
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:bb9e356f-3f1a-35f4-9129-17a49a65033b'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 5, part.movement_number = 'V',
    part.name_ko = 'La tortue', part.name_en = 'Chantefleurs et Chantefables for soprano and orchestre: V. La tortue',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 1307 AND p.composer_id = 110 AND part.part_key = 'musicbrainz:31dcb19a-19c6-30ee-a3b9-bad3f654616a' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:31dcb19a-19c6-30ee-a3b9-bad3f654616a', 5, 'V', 'La tortue', 'Chantefleurs et Chantefables for soprano and orchestre: V. La tortue', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 1307 AND p.composer_id = 110
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:31dcb19a-19c6-30ee-a3b9-bad3f654616a'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 6, part.movement_number = 'VI',
    part.name_ko = 'La rose', part.name_en = 'Chantefleurs et Chantefables for soprano and orchestre: VI. La rose',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 1307 AND p.composer_id = 110 AND part.part_key = 'musicbrainz:fd18ae1f-3663-333e-8479-18bf906731a5' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:fd18ae1f-3663-333e-8479-18bf906731a5', 6, 'VI', 'La rose', 'Chantefleurs et Chantefables for soprano and orchestre: VI. La rose', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 1307 AND p.composer_id = 110
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:fd18ae1f-3663-333e-8479-18bf906731a5'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 7, part.movement_number = 'VII',
    part.name_ko = 'L''alligator', part.name_en = 'Chantefleurs et Chantefables for soprano and orchestre: VII. L''alligator',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 1307 AND p.composer_id = 110 AND part.part_key = 'musicbrainz:c81a5792-1762-3ae8-bbf8-227d53b2c1a2' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:c81a5792-1762-3ae8-bbf8-227d53b2c1a2', 7, 'VII', 'L''alligator', 'Chantefleurs et Chantefables for soprano and orchestre: VII. L''alligator', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 1307 AND p.composer_id = 110
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:c81a5792-1762-3ae8-bbf8-227d53b2c1a2'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 8, part.movement_number = 'VIII',
    part.name_ko = 'L''angélique', part.name_en = 'Chantefleurs et Chantefables for soprano and orchestre: VIII. L''angélique',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 1307 AND p.composer_id = 110 AND part.part_key = 'musicbrainz:5097a4ec-4bdc-3afd-8c97-276864e8a077' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:5097a4ec-4bdc-3afd-8c97-276864e8a077', 8, 'VIII', 'L''angélique', 'Chantefleurs et Chantefables for soprano and orchestre: VIII. L''angélique', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 1307 AND p.composer_id = 110
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:5097a4ec-4bdc-3afd-8c97-276864e8a077'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 9, part.movement_number = 'IX',
    part.name_ko = 'Le papillon', part.name_en = 'Chantefleurs et Chantefables for soprano and orchestre: IX. Le papillon',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 1307 AND p.composer_id = 110 AND part.part_key = 'musicbrainz:6e4e58aa-1cf3-327b-bae7-11550145c6dc' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:6e4e58aa-1cf3-327b-bae7-11550145c6dc', 9, 'IX', 'Le papillon', 'Chantefleurs et Chantefables for soprano and orchestre: IX. Le papillon', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 1307 AND p.composer_id = 110
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:6e4e58aa-1cf3-327b-bae7-11550145c6dc'
);


-- None 첼로 협주곡

UPDATE pieces piece
SET piece.title = '첼로 협주곡', piece.title_en = 'Concerto for Cello and Orchestra',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 2836 AND piece.composer_id = 110
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'Introduction -', part.name_en = 'Concerto for Cello and Orchestra: I. Introduction -',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 2836 AND p.composer_id = 110 AND part.part_key = 'musicbrainz:a9b3e416-90b4-4bb7-bef8-1c4b012b073a' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:a9b3e416-90b4-4bb7-bef8-1c4b012b073a', 1, 'I', 'Introduction -', 'Concerto for Cello and Orchestra: I. Introduction -', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 2836 AND p.composer_id = 110
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:a9b3e416-90b4-4bb7-bef8-1c4b012b073a'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'Episodes -', part.name_en = 'Concerto for Cello and Orchestra: II. Episodes -',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 2836 AND p.composer_id = 110 AND part.part_key = 'musicbrainz:60c4bcf5-f43a-4309-a01c-6ff78dd9fc6b' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:60c4bcf5-f43a-4309-a01c-6ff78dd9fc6b', 2, 'II', 'Episodes -', 'Concerto for Cello and Orchestra: II. Episodes -', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 2836 AND p.composer_id = 110
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:60c4bcf5-f43a-4309-a01c-6ff78dd9fc6b'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = 'Cantilena -', part.name_en = 'Concerto for Cello and Orchestra: III. Cantilena -',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 2836 AND p.composer_id = 110 AND part.part_key = 'musicbrainz:1e80b411-f0c3-4529-adc0-fd0afefc88ee' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:1e80b411-f0c3-4529-adc0-fd0afefc88ee', 3, 'III', 'Cantilena -', 'Concerto for Cello and Orchestra: III. Cantilena -', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 2836 AND p.composer_id = 110
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:1e80b411-f0c3-4529-adc0-fd0afefc88ee'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = 'IV',
    part.name_ko = 'Finale', part.name_en = 'Concerto for Cello and Orchestra: IV. Finale',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 2836 AND p.composer_id = 110 AND part.part_key = 'musicbrainz:ca6a6715-bb11-4cc1-b610-5763a975f2b0' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:ca6a6715-bb11-4cc1-b610-5763a975f2b0', 4, 'IV', 'Finale', 'Concerto for Cello and Orchestra: IV. Finale', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 2836 AND p.composer_id = 110
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:ca6a6715-bb11-4cc1-b610-5763a975f2b0'
);


-- None 관현악 협주곡

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'Intrada. Allegro maestoso', part.name_en = 'Concerto for Orchestra: I. Intrada. Allegro maestoso',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 413 AND p.composer_id = 110 AND part.part_key = 'musicbrainz:833b7800-7027-3c35-8771-31f6310f94ef' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:833b7800-7027-3c35-8771-31f6310f94ef', 1, 'I', 'Intrada. Allegro maestoso', 'Concerto for Orchestra: I. Intrada. Allegro maestoso', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 413 AND p.composer_id = 110
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:833b7800-7027-3c35-8771-31f6310f94ef'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'Capriccio notturno e Arioso. Vivace', part.name_en = 'Concerto for Orchestra: II. Capriccio notturno e Arioso. Vivace',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 413 AND p.composer_id = 110 AND part.part_key = 'musicbrainz:9fff3e20-c3af-365f-978d-2e972c4f3223' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:9fff3e20-c3af-365f-978d-2e972c4f3223', 2, 'II', 'Capriccio notturno e Arioso. Vivace', 'Concerto for Orchestra: II. Capriccio notturno e Arioso. Vivace', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 413 AND p.composer_id = 110
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:9fff3e20-c3af-365f-978d-2e972c4f3223'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = 'Passacaglia, Toccata e Corale. Andante con moto - Allegro giusto', part.name_en = 'Concerto for Orchestra: III. Passacaglia, Toccata e Corale. Andante con moto - Allegro giusto',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 413 AND p.composer_id = 110 AND part.part_key = 'musicbrainz:f9a2a793-f26b-3330-a450-b327fec9a89a' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:f9a2a793-f26b-3330-a450-b327fec9a89a', 3, 'III', 'Passacaglia, Toccata e Corale. Andante con moto - Allegro giusto', 'Concerto for Orchestra: III. Passacaglia, Toccata e Corale. Andante con moto - Allegro giusto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 413 AND p.composer_id = 110
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:f9a2a793-f26b-3330-a450-b327fec9a89a'
);


-- None 피아노 협주곡

UPDATE pieces piece
SET piece.title = '피아노 협주곡', piece.title_en = 'Concerto for Piano and Orchestra',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 1637 AND piece.composer_id = 110
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = '110 - attacca', part.name_en = 'Concerto for Piano and Orchestra: I. 110 - attacca',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 1637 AND p.composer_id = 110 AND part.part_key = 'musicbrainz:69a3ace0-74d4-3e1a-9c67-6c9b94351006' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:69a3ace0-74d4-3e1a-9c67-6c9b94351006', 1, 'I', '110 - attacca', 'Concerto for Piano and Orchestra: I. 110 - attacca', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 1637 AND p.composer_id = 110
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:69a3ace0-74d4-3e1a-9c67-6c9b94351006'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'Presto - attacca', part.name_en = 'Concerto for Piano and Orchestra: II. Presto - attacca',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 1637 AND p.composer_id = 110 AND part.part_key = 'musicbrainz:72cba955-adb8-3c58-ba02-41b3df1822d5' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:72cba955-adb8-3c58-ba02-41b3df1822d5', 2, 'II', 'Presto - attacca', 'Concerto for Piano and Orchestra: II. Presto - attacca', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 1637 AND p.composer_id = 110
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:72cba955-adb8-3c58-ba02-41b3df1822d5'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = '85 - attacca', part.name_en = 'Concerto for Piano and Orchestra: III. 85 - attacca',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 1637 AND p.composer_id = 110 AND part.part_key = 'musicbrainz:44137039-3ec2-3afb-b894-62dc968b3715' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:44137039-3ec2-3afb-b894-62dc968b3715', 3, 'III', '85 - attacca', 'Concerto for Piano and Orchestra: III. 85 - attacca', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 1637 AND p.composer_id = 110
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:44137039-3ec2-3afb-b894-62dc968b3715'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = 'IV',
    part.name_ko = '84', part.name_en = 'Concerto for Piano and Orchestra: IV. 84',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 1637 AND p.composer_id = 110 AND part.part_key = 'musicbrainz:1c773eab-e1aa-3df2-aaf7-819eeb0749bb' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:1c773eab-e1aa-3df2-aaf7-819eeb0749bb', 4, 'IV', '84', 'Concerto for Piano and Orchestra: IV. 84', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 1637 AND p.composer_id = 110
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:1c773eab-e1aa-3df2-aaf7-819eeb0749bb'
);


-- None Cztery Melodie sląskie (Four Silesian Melodies)

UPDATE pieces piece
SET piece.title = 'Cztery Melodie sląskie (Four Silesian Melodies)', piece.title_en = 'Cztery Melodie sląskie (Four Silesian Melodies)',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 1490 AND piece.composer_id = 110
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'Zalotny (Flirting)', part.name_en = 'Four Silesian Melodies: I. Zalotny (Flirting)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 1490 AND p.composer_id = 110 AND part.part_key = 'musicbrainz:960ed56e-216b-4c80-9eac-d140f4007b64' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:960ed56e-216b-4c80-9eac-d140f4007b64', 1, 'I', 'Zalotny (Flirting)', 'Four Silesian Melodies: I. Zalotny (Flirting)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 1490 AND p.composer_id = 110
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:960ed56e-216b-4c80-9eac-d140f4007b64'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'IV',
    part.name_ko = 'Rektor (The Schoolmaster)', part.name_en = 'Four Silesian Melodies: IV. Rektor (The Schoolmaster)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 1490 AND p.composer_id = 110 AND part.part_key = 'musicbrainz:b977e49a-4b54-4a6d-ba53-8fe40df86d22' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:b977e49a-4b54-4a6d-ba53-8fe40df86d22', 2, 'IV', 'Rektor (The Schoolmaster)', 'Four Silesian Melodies: IV. Rektor (The Schoolmaster)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 1490 AND p.composer_id = 110
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:b977e49a-4b54-4a6d-ba53-8fe40df86d22'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'II',
    part.name_ko = 'Gaik (The Grove)', part.name_en = 'Four Silesian Melodies: II. Gaik (The Grove)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 1490 AND p.composer_id = 110 AND part.part_key = 'musicbrainz:dd616eb4-b221-4713-81a2-bce4d46b31e7' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:dd616eb4-b221-4713-81a2-bce4d46b31e7', 3, 'II', 'Gaik (The Grove)', 'Four Silesian Melodies: II. Gaik (The Grove)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 1490 AND p.composer_id = 110
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:dd616eb4-b221-4713-81a2-bce4d46b31e7'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = 'III',
    part.name_ko = 'Gaslor (A Gander)', part.name_en = 'Four Silesian Melodies: III. Gaslor (A Gander)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 1490 AND p.composer_id = 110 AND part.part_key = 'musicbrainz:f10e7a56-d128-4dbd-b2a6-cfdc0f9750a8' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:f10e7a56-d128-4dbd-b2a6-cfdc0f9750a8', 4, 'III', 'Gaslor (A Gander)', 'Four Silesian Melodies: III. Gaslor (A Gander)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 1490 AND p.composer_id = 110
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:f10e7a56-d128-4dbd-b2a6-cfdc0f9750a8'
);


-- None Dance Preludes

UPDATE pieces piece
SET piece.title = 'Dance Preludes', piece.title_en = 'Dance Preludes',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 906 AND piece.composer_id = 110
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'Allegro molto', part.name_en = 'Dance Preludes: No. 1. Allegro molto',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 906 AND p.composer_id = 110 AND part.part_key = 'musicbrainz:3a2913ed-382f-44de-a136-745d3e185b44' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:3a2913ed-382f-44de-a136-745d3e185b44', 1, NULL, 'Allegro molto', 'Dance Preludes: No. 1. Allegro molto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 906 AND p.composer_id = 110
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:3a2913ed-382f-44de-a136-745d3e185b44'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'Andantino', part.name_en = 'Dance Preludes: No. 2. Andantino',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 906 AND p.composer_id = 110 AND part.part_key = 'musicbrainz:bc67e519-b407-4e2e-ad4d-8741c4e1d86d' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:bc67e519-b407-4e2e-ad4d-8741c4e1d86d', 2, NULL, 'Andantino', 'Dance Preludes: No. 2. Andantino', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 906 AND p.composer_id = 110
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:bc67e519-b407-4e2e-ad4d-8741c4e1d86d'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = NULL,
    part.name_ko = 'Allegro giocoso', part.name_en = 'Dance Preludes: No. 3. Allegro giocoso',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 906 AND p.composer_id = 110 AND part.part_key = 'musicbrainz:4f04af2e-17f4-47d8-9f4c-d6ca6471892d' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:4f04af2e-17f4-47d8-9f4c-d6ca6471892d', 3, NULL, 'Allegro giocoso', 'Dance Preludes: No. 3. Allegro giocoso', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 906 AND p.composer_id = 110
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:4f04af2e-17f4-47d8-9f4c-d6ca6471892d'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = NULL,
    part.name_ko = 'Andante', part.name_en = 'Dance Preludes: No. 4. Andante',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 906 AND p.composer_id = 110 AND part.part_key = 'musicbrainz:b34813bf-dfaa-4932-8042-24e454a6069e' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:b34813bf-dfaa-4932-8042-24e454a6069e', 4, NULL, 'Andante', 'Dance Preludes: No. 4. Andante', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 906 AND p.composer_id = 110
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:b34813bf-dfaa-4932-8042-24e454a6069e'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 5, part.movement_number = NULL,
    part.name_ko = 'Allegro molto - Presto', part.name_en = 'Dance Preludes: No. 5. Allegro molto - Presto',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 906 AND p.composer_id = 110 AND part.part_key = 'musicbrainz:8af1f48c-ef46-4d7c-a9d2-340967a2e1a2' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:8af1f48c-ef46-4d7c-a9d2-340967a2e1a2', 5, NULL, 'Allegro molto - Presto', 'Dance Preludes: No. 5. Allegro molto - Presto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 906 AND p.composer_id = 110
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:8af1f48c-ef46-4d7c-a9d2-340967a2e1a2'
);


-- None Double Concerto for Oboe, Harp and Chamber Orchestra

UPDATE pieces piece
SET piece.title = 'Double Concerto for Oboe, Harp and Chamber Orchestra', piece.title_en = 'Double Concerto for Oboe, Harp and Chamber Orchestra',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 980 AND piece.composer_id = 110
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'Rapsodico', part.name_en = 'Double Concerto for Oboe, Harp and Chamber Orchestra: I. Rapsodico',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 980 AND p.composer_id = 110 AND part.part_key = 'musicbrainz:0d774ad8-bd3e-44d4-8943-e32a82e2a545' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:0d774ad8-bd3e-44d4-8943-e32a82e2a545', 1, 'I', 'Rapsodico', 'Double Concerto for Oboe, Harp and Chamber Orchestra: I. Rapsodico', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 980 AND p.composer_id = 110
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:0d774ad8-bd3e-44d4-8943-e32a82e2a545'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'Dolente', part.name_en = 'Double Concerto for Oboe, Harp and Chamber Orchestra: II. Dolente',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 980 AND p.composer_id = 110 AND part.part_key = 'musicbrainz:ba6c9f17-f3bd-4065-bf3e-9d43ddaf9449' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:ba6c9f17-f3bd-4065-bf3e-9d43ddaf9449', 2, 'II', 'Dolente', 'Double Concerto for Oboe, Harp and Chamber Orchestra: II. Dolente', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 980 AND p.composer_id = 110
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:ba6c9f17-f3bd-4065-bf3e-9d43ddaf9449'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = 'Marziale e grotesco', part.name_en = 'Double Concerto for Oboe, Harp and Chamber Orchestra: III. Marziale e grotesco',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 980 AND p.composer_id = 110 AND part.part_key = 'musicbrainz:680dd9fb-e881-40ef-9f8e-23d1d209b508' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:680dd9fb-e881-40ef-9f8e-23d1d209b508', 3, 'III', 'Marziale e grotesco', 'Double Concerto for Oboe, Harp and Chamber Orchestra: III. Marziale e grotesco', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 980 AND p.composer_id = 110
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:680dd9fb-e881-40ef-9f8e-23d1d209b508'
);


-- None Dziesięć polskich pieśni ludowych na tematy żołnierskie

UPDATE pieces piece
SET piece.title = 'Dziesięć polskich pieśni ludowych na tematy żołnierskie', piece.title_en = 'Dziesięć polskich pieśni ludowych na tematy żołnierskie',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 2775 AND piece.composer_id = 110
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'Pod Krakowem czarna rola', part.name_en = 'Dziesięć polskich pieśni ludowych na tematy żołnierskie: 1. Pod Krakowem czarna rola',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 2775 AND p.composer_id = 110 AND part.part_key = 'musicbrainz:5523bb33-db7e-462f-934e-7bdd769fe8a9' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:5523bb33-db7e-462f-934e-7bdd769fe8a9', 1, NULL, 'Pod Krakowem czarna rola', 'Dziesięć polskich pieśni ludowych na tematy żołnierskie: 1. Pod Krakowem czarna rola', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 2775 AND p.composer_id = 110
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:5523bb33-db7e-462f-934e-7bdd769fe8a9'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'Nie będę łez ronić', part.name_en = 'Dziesięć polskich pieśni ludowych na tematy żołnierskie: 2. Nie będę łez ronić',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 2775 AND p.composer_id = 110 AND part.part_key = 'musicbrainz:d09876af-661e-4b4c-839d-19628e0cc176' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:d09876af-661e-4b4c-839d-19628e0cc176', 2, NULL, 'Nie będę łez ronić', 'Dziesięć polskich pieśni ludowych na tematy żołnierskie: 2. Nie będę łez ronić', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 2775 AND p.composer_id = 110
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:d09876af-661e-4b4c-839d-19628e0cc176'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = NULL,
    part.name_ko = 'A w Warszawie', part.name_en = 'Dziesięć polskich pieśni ludowych na tematy żołnierskie: 3. A w Warszawie',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 2775 AND p.composer_id = 110 AND part.part_key = 'musicbrainz:0460f73b-a598-45da-9ffb-1e5b943ed11a' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:0460f73b-a598-45da-9ffb-1e5b943ed11a', 3, NULL, 'A w Warszawie', 'Dziesięć polskich pieśni ludowych na tematy żołnierskie: 3. A w Warszawie', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 2775 AND p.composer_id = 110
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:0460f73b-a598-45da-9ffb-1e5b943ed11a'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = NULL,
    part.name_ko = 'Zachodzi słoneczko', part.name_en = 'Dziesięć polskich pieśni ludowych na tematy żołnierskie: 4. Zachodzi słoneczko',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 2775 AND p.composer_id = 110 AND part.part_key = 'musicbrainz:7a808d2a-a019-4e97-9925-8ce060d8bb6d' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:7a808d2a-a019-4e97-9925-8ce060d8bb6d', 4, NULL, 'Zachodzi słoneczko', 'Dziesięć polskich pieśni ludowych na tematy żołnierskie: 4. Zachodzi słoneczko', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 2775 AND p.composer_id = 110
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:7a808d2a-a019-4e97-9925-8ce060d8bb6d'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 5, part.movement_number = NULL,
    part.name_ko = 'Oj, i w polu jezioro', part.name_en = 'Dziesięć polskich pieśni ludowych na tematy żołnierskie: 5. Oj, i w polu jezioro',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 2775 AND p.composer_id = 110 AND part.part_key = 'musicbrainz:f1df9f2d-b0ca-4ef8-940c-97cd17b96809' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:f1df9f2d-b0ca-4ef8-940c-97cd17b96809', 5, NULL, 'Oj, i w polu jezioro', 'Dziesięć polskich pieśni ludowych na tematy żołnierskie: 5. Oj, i w polu jezioro', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 2775 AND p.composer_id = 110
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:f1df9f2d-b0ca-4ef8-940c-97cd17b96809'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 6, part.movement_number = NULL,
    part.name_ko = 'Jam kalinkę łamała', part.name_en = 'Dziesięć polskich pieśni ludowych na tematy żołnierskie: 6. Jam kalinkę łamała',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 2775 AND p.composer_id = 110 AND part.part_key = 'musicbrainz:50f48dd4-c1aa-47f4-a861-4a94cef0453b' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:50f48dd4-c1aa-47f4-a861-4a94cef0453b', 6, NULL, 'Jam kalinkę łamała', 'Dziesięć polskich pieśni ludowych na tematy żołnierskie: 6. Jam kalinkę łamała', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 2775 AND p.composer_id = 110
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:50f48dd4-c1aa-47f4-a861-4a94cef0453b'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 7, part.movement_number = NULL,
    part.name_ko = 'Gdzie to jedziesz, Jasiu?', part.name_en = 'Dziesięć polskich pieśni ludowych na tematy żołnierskie: 7. Gdzie to jedziesz, Jasiu?',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 2775 AND p.composer_id = 110 AND part.part_key = 'musicbrainz:a732fadf-f77b-4a49-a2a8-e783f7dfaa6b' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:a732fadf-f77b-4a49-a2a8-e783f7dfaa6b', 7, NULL, 'Gdzie to jedziesz, Jasiu?', 'Dziesięć polskich pieśni ludowych na tematy żołnierskie: 7. Gdzie to jedziesz, Jasiu?', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 2775 AND p.composer_id = 110
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:a732fadf-f77b-4a49-a2a8-e783f7dfaa6b'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 8, part.movement_number = NULL,
    part.name_ko = 'A na onej górze', part.name_en = 'Dziesięć polskich pieśni ludowych na tematy żołnierskie: 8. A na onej górze',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 2775 AND p.composer_id = 110 AND part.part_key = 'musicbrainz:25ff0b50-7f1f-4847-ac19-1d707fb345bb' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:25ff0b50-7f1f-4847-ac19-1d707fb345bb', 8, NULL, 'A na onej górze', 'Dziesięć polskich pieśni ludowych na tematy żołnierskie: 8. A na onej górze', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 2775 AND p.composer_id = 110
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:25ff0b50-7f1f-4847-ac19-1d707fb345bb'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 9, part.movement_number = NULL,
    part.name_ko = 'Już to mija siódmy roczek', part.name_en = 'Dziesięć polskich pieśni ludowych na tematy żołnierskie: 9. Już to mija siódmy roczek',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 2775 AND p.composer_id = 110 AND part.part_key = 'musicbrainz:1c937c19-024d-4181-b806-5a52b43e08a9' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:1c937c19-024d-4181-b806-5a52b43e08a9', 9, NULL, 'Już to mija siódmy roczek', 'Dziesięć polskich pieśni ludowych na tematy żołnierskie: 9. Już to mija siódmy roczek', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 2775 AND p.composer_id = 110
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:1c937c19-024d-4181-b806-5a52b43e08a9'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 10, part.movement_number = NULL,
    part.name_ko = 'Małgorzatka', part.name_en = 'Dziesięć polskich pieśni ludowych na tematy żołnierskie: 10. Małgorzatka',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 2775 AND p.composer_id = 110 AND part.part_key = 'musicbrainz:d3cca992-f042-4ab1-aa59-0e8bb6b2260d' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:d3cca992-f042-4ab1-aa59-0e8bb6b2260d', 10, NULL, 'Małgorzatka', 'Dziesięć polskich pieśni ludowych na tematy żołnierskie: 10. Małgorzatka', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 2775 AND p.composer_id = 110
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:d3cca992-f042-4ab1-aa59-0e8bb6b2260d'
);


-- None Epitaph

UPDATE pieces piece
SET piece.title = 'Epitaph', piece.title_en = 'Epitaph',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 1270 AND piece.composer_id = 110
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Fanfare for CUBE

UPDATE pieces piece
SET piece.title = 'Fanfare for CUBE', piece.title_en = 'Fanfare for CUBE',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 962 AND piece.composer_id = 110
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Fanfare for Los Angeles Philharmonic

UPDATE pieces piece
SET piece.title = 'Fanfare for Los Angeles Philharmonic', piece.title_en = 'Fanfare for Los Angeles Philharmonic',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 1627 AND piece.composer_id = 110
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Fanfare for Louisville

UPDATE pieces piece
SET piece.title = 'Fanfare for Louisville', piece.title_en = 'Fanfare for Louisville',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 2187 AND piece.composer_id = 110
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Fanfare for the University of Lancaster

UPDATE pieces piece
SET piece.title = 'Fanfare for the University of Lancaster', piece.title_en = 'Fanfare for the University of Lancaster',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 1924 AND piece.composer_id = 110
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None 5개의 가곡

UPDATE pieces piece
SET piece.title = '5개의 가곡', piece.title_en = 'Five Songs for Soprano and Orchestra',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 2713 AND piece.composer_id = 110
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'Morze', part.name_en = 'Five Songs for Soprano and Orchestra: I. Morze',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 2713 AND p.composer_id = 110 AND part.part_key = 'musicbrainz:faf4f418-25d7-410c-88d5-33f5170387aa' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:faf4f418-25d7-410c-88d5-33f5170387aa', 1, 'I', 'Morze', 'Five Songs for Soprano and Orchestra: I. Morze', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 2713 AND p.composer_id = 110
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:faf4f418-25d7-410c-88d5-33f5170387aa'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'Wiatr', part.name_en = 'Five Songs for Soprano and Orchestra: II. Wiatr',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 2713 AND p.composer_id = 110 AND part.part_key = 'musicbrainz:83cbe3f1-c2bf-4af4-98fb-227405642bc3' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:83cbe3f1-c2bf-4af4-98fb-227405642bc3', 2, 'II', 'Wiatr', 'Five Songs for Soprano and Orchestra: II. Wiatr', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 2713 AND p.composer_id = 110
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:83cbe3f1-c2bf-4af4-98fb-227405642bc3'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = 'Zima', part.name_en = 'Five Songs for Soprano and Orchestra: III. Zima',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 2713 AND p.composer_id = 110 AND part.part_key = 'musicbrainz:9839ac84-28b5-4208-bb1a-50c66d058e71' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:9839ac84-28b5-4208-bb1a-50c66d058e71', 3, 'III', 'Zima', 'Five Songs for Soprano and Orchestra: III. Zima', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 2713 AND p.composer_id = 110
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:9839ac84-28b5-4208-bb1a-50c66d058e71'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = 'IV',
    part.name_ko = 'Rycerze', part.name_en = 'Five Songs for Soprano and Orchestra: IV. Rycerze',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 2713 AND p.composer_id = 110 AND part.part_key = 'musicbrainz:99b1b0ad-7f12-40c4-8a49-01fa4bec3149' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:99b1b0ad-7f12-40c4-8a49-01fa4bec3149', 4, 'IV', 'Rycerze', 'Five Songs for Soprano and Orchestra: IV. Rycerze', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 2713 AND p.composer_id = 110
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:99b1b0ad-7f12-40c4-8a49-01fa4bec3149'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 5, part.movement_number = 'V',
    part.name_ko = 'Dzwony', part.name_en = 'Five Songs for Soprano and Orchestra: V. Dzwony',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 2713 AND p.composer_id = 110 AND part.part_key = 'musicbrainz:cdf78041-af8d-489d-becc-dce2a3d538ae' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:cdf78041-af8d-489d-becc-dce2a3d538ae', 5, 'V', 'Dzwony', 'Five Songs for Soprano and Orchestra: V. Dzwony', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 2713 AND p.composer_id = 110
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:cdf78041-af8d-489d-becc-dce2a3d538ae'
);


-- None Interlude

UPDATE pieces piece
SET piece.title = 'Interlude', piece.title_en = 'Interlude',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 2171 AND piece.composer_id = 110
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Inwencja

UPDATE pieces piece
SET piece.title = 'Inwencja', piece.title_en = 'Inwencja',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 659 AND piece.composer_id = 110
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Lacrimosa

UPDATE pieces piece
SET piece.title = 'Lacrimosa', piece.title_en = 'Lacrimosa',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 1388 AND piece.composer_id = 110
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Les Espaces du sommeil

UPDATE pieces piece
SET piece.title = 'Les Espaces du sommeil', piece.title_en = 'Les Espaces du sommeil',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 522 AND piece.composer_id = 110
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Livre pour orchestre

UPDATE pieces piece
SET piece.title = 'Livre pour orchestre', piece.title_en = 'Livre pour orchestre',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 1112 AND piece.composer_id = 110
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Melodie Ludowe

UPDATE pieces piece
SET piece.title = 'Melodie Ludowe', piece.title_en = 'Melodie Ludowe',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 678 AND piece.composer_id = 110
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'Ach, mój Jasieńko', part.name_en = 'Melodie Ludowe: I. Ach, mój Jasieńko',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 678 AND p.composer_id = 110 AND part.part_key = 'musicbrainz:73d79084-b490-40aa-b7bc-ed76e1d1fd5a' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:73d79084-b490-40aa-b7bc-ed76e1d1fd5a', 1, 'I', 'Ach, mój Jasieńko', 'Melodie Ludowe: I. Ach, mój Jasieńko', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 678 AND p.composer_id = 110
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:73d79084-b490-40aa-b7bc-ed76e1d1fd5a'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'Hej, od Krakowa jadę', part.name_en = 'Melodie Ludowe: II. Hej, od Krakowa jadę',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 678 AND p.composer_id = 110 AND part.part_key = 'musicbrainz:b9887d76-f331-4265-8cf8-851c894f3c9a' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:b9887d76-f331-4265-8cf8-851c894f3c9a', 2, 'II', 'Hej, od Krakowa jadę', 'Melodie Ludowe: II. Hej, od Krakowa jadę', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 678 AND p.composer_id = 110
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:b9887d76-f331-4265-8cf8-851c894f3c9a'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = 'Jest drożyna, jest', part.name_en = 'Melodie Ludowe: III. Jest drożyna, jest',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 678 AND p.composer_id = 110 AND part.part_key = 'musicbrainz:2fd10042-d2c3-482c-b9a3-d4dc1a2bd85d' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:2fd10042-d2c3-482c-b9a3-d4dc1a2bd85d', 3, 'III', 'Jest drożyna, jest', 'Melodie Ludowe: III. Jest drożyna, jest', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 678 AND p.composer_id = 110
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:2fd10042-d2c3-482c-b9a3-d4dc1a2bd85d'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = 'IV',
    part.name_ko = 'Pastereczka', part.name_en = 'Melodie Ludowe: IV. Pastereczka',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 678 AND p.composer_id = 110 AND part.part_key = 'musicbrainz:724c680b-2408-4475-acd6-ed0e0a0a14a8' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:724c680b-2408-4475-acd6-ed0e0a0a14a8', 4, 'IV', 'Pastereczka', 'Melodie Ludowe: IV. Pastereczka', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 678 AND p.composer_id = 110
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:724c680b-2408-4475-acd6-ed0e0a0a14a8'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 5, part.movement_number = 'V',
    part.name_ko = 'Na jabłoni jabłko wisi', part.name_en = 'Melodie Ludowe: V. Na jabłoni jabłko wisi',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 678 AND p.composer_id = 110 AND part.part_key = 'musicbrainz:510c691a-a140-46b4-a118-ee2640524bcb' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:510c691a-a140-46b4-a118-ee2640524bcb', 5, 'V', 'Na jabłoni jabłko wisi', 'Melodie Ludowe: V. Na jabłoni jabłko wisi', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 678 AND p.composer_id = 110
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:510c691a-a140-46b4-a118-ee2640524bcb'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 6, part.movement_number = 'VI',
    part.name_ko = 'Od Sieradza płynie rzeka', part.name_en = 'Melodie Ludowe: VI. Od Sieradza płynie rzeka',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 678 AND p.composer_id = 110 AND part.part_key = 'musicbrainz:c21fdf31-7f93-4367-8413-f63d199f6abf' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:c21fdf31-7f93-4367-8413-f63d199f6abf', 6, 'VI', 'Od Sieradza płynie rzeka', 'Melodie Ludowe: VI. Od Sieradza płynie rzeka', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 678 AND p.composer_id = 110
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:c21fdf31-7f93-4367-8413-f63d199f6abf'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 7, part.movement_number = 'VII',
    part.name_ko = 'Panie Michale', part.name_en = 'Melodie Ludowe: VII. Panie Michale',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 678 AND p.composer_id = 110 AND part.part_key = 'musicbrainz:eb5bad4a-78bb-41e5-8595-d66848c617c0' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:eb5bad4a-78bb-41e5-8595-d66848c617c0', 7, 'VII', 'Panie Michale', 'Melodie Ludowe: VII. Panie Michale', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 678 AND p.composer_id = 110
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:eb5bad4a-78bb-41e5-8595-d66848c617c0'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 8, part.movement_number = 'VIII',
    part.name_ko = 'W polu lipeńka', part.name_en = 'Melodie Ludowe: VIII. W polu lipeńka',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 678 AND p.composer_id = 110 AND part.part_key = 'musicbrainz:0b300899-9ed0-4297-87b5-8e0e80e11e38' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:0b300899-9ed0-4297-87b5-8e0e80e11e38', 8, 'VIII', 'W polu lipeńka', 'Melodie Ludowe: VIII. W polu lipeńka', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 678 AND p.composer_id = 110
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:0b300899-9ed0-4297-87b5-8e0e80e11e38'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 9, part.movement_number = 'IX',
    part.name_ko = 'Zalotny', part.name_en = 'Melodie Ludowe: IX. Zalotny',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 678 AND p.composer_id = 110 AND part.part_key = 'musicbrainz:b8ef8fb8-57e7-4b4c-9b23-560b211e5cda' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:b8ef8fb8-57e7-4b4c-9b23-560b211e5cda', 9, 'IX', 'Zalotny', 'Melodie Ludowe: IX. Zalotny', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 678 AND p.composer_id = 110
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:b8ef8fb8-57e7-4b4c-9b23-560b211e5cda'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 10, part.movement_number = 'X',
    part.name_ko = 'Gaik', part.name_en = 'Melodie Ludowe: X. Gaik',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 678 AND p.composer_id = 110 AND part.part_key = 'musicbrainz:4e724815-16b9-4361-849f-a9e7e855f9e7' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:4e724815-16b9-4361-849f-a9e7e855f9e7', 10, 'X', 'Gaik', 'Melodie Ludowe: X. Gaik', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 678 AND p.composer_id = 110
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:4e724815-16b9-4361-849f-a9e7e855f9e7'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 11, part.movement_number = 'XI',
    part.name_ko = 'Gąsior', part.name_en = 'Melodie Ludowe: XI. Gąsior',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 678 AND p.composer_id = 110 AND part.part_key = 'musicbrainz:bfef9e9e-147c-443c-ba38-cc5fd28eb466' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:bfef9e9e-147c-443c-ba38-cc5fd28eb466', 11, 'XI', 'Gąsior', 'Melodie Ludowe: XI. Gąsior', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 678 AND p.composer_id = 110
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:bfef9e9e-147c-443c-ba38-cc5fd28eb466'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 12, part.movement_number = 'XII',
    part.name_ko = 'Rektor', part.name_en = 'Melodie Ludowe: XII. Rektor',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 678 AND p.composer_id = 110 AND part.part_key = 'musicbrainz:82dc1e84-a0bf-4a18-8680-e2848383f05c' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:82dc1e84-a0bf-4a18-8680-e2848383f05c', 12, 'XII', 'Rektor', 'Melodie Ludowe: XII. Rektor', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 678 AND p.composer_id = 110
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:82dc1e84-a0bf-4a18-8680-e2848383f05c'
);


-- None Mi-parti

UPDATE pieces piece
SET piece.title = 'Mi-parti', piece.title_en = 'Mi-parti',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 2456 AND piece.composer_id = 110
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Mini Overture

UPDATE pieces piece
SET piece.title = 'Mini Overture', piece.title_en = 'Mini Overture',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 2991 AND piece.composer_id = 110
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Musique funèbre

UPDATE pieces piece
SET piece.title = 'Musique funèbre', piece.title_en = 'Musique funèbre',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 594 AND piece.composer_id = 110
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'Prologue', part.name_en = 'Musique funèbre: I. Prologue',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 594 AND p.composer_id = 110 AND part.part_key = 'musicbrainz:01de3e58-92d9-477d-b4e8-42edd031a8c4' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:01de3e58-92d9-477d-b4e8-42edd031a8c4', 1, 'I', 'Prologue', 'Musique funèbre: I. Prologue', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 594 AND p.composer_id = 110
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:01de3e58-92d9-477d-b4e8-42edd031a8c4'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'Métamorphoses', part.name_en = 'Musique funèbre: II. Métamorphoses',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 594 AND p.composer_id = 110 AND part.part_key = 'musicbrainz:802c3c33-1daa-49e4-bc2a-9c766932d28e' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:802c3c33-1daa-49e4-bc2a-9c766932d28e', 2, 'II', 'Métamorphoses', 'Musique funèbre: II. Métamorphoses', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 594 AND p.composer_id = 110
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:802c3c33-1daa-49e4-bc2a-9c766932d28e'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = 'Apogée', part.name_en = 'Musique funèbre: III. Apogée',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 594 AND p.composer_id = 110 AND part.part_key = 'musicbrainz:f80b01ca-2e97-4b46-8710-ccafea01eb26' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:f80b01ca-2e97-4b46-8710-ccafea01eb26', 3, 'III', 'Apogée', 'Musique funèbre: III. Apogée', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 594 AND p.composer_id = 110
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:f80b01ca-2e97-4b46-8710-ccafea01eb26'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = 'IV',
    part.name_ko = 'Épilogue', part.name_en = 'Musique funèbre: IV. Épilogue',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 594 AND p.composer_id = 110 AND part.part_key = 'musicbrainz:2fdc8001-71dd-4f1a-adb1-329dc532e021' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:2fdc8001-71dd-4f1a-adb1-329dc532e021', 4, 'IV', 'Épilogue', 'Musique funèbre: IV. Épilogue', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 594 AND p.composer_id = 110
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:2fdc8001-71dd-4f1a-adb1-329dc532e021'
);


-- None Novelette pour orchestre

UPDATE pieces piece
SET piece.title = 'Novelette pour orchestre', piece.title_en = 'Novelette pour orchestre',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 2411 AND piece.composer_id = 110
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'Announcement', part.name_en = 'Novelette pour orchestre: I. Announcement',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 2411 AND p.composer_id = 110 AND part.part_key = 'musicbrainz:33de0165-b6fa-432b-8b88-3b643b9318bb' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:33de0165-b6fa-432b-8b88-3b643b9318bb', 1, 'I', 'Announcement', 'Novelette pour orchestre: I. Announcement', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 2411 AND p.composer_id = 110
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:33de0165-b6fa-432b-8b88-3b643b9318bb'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'First Event', part.name_en = 'Novelette pour orchestre: II. First Event',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 2411 AND p.composer_id = 110 AND part.part_key = 'musicbrainz:d7fe63a8-6f55-45af-a97c-3e06a3fee7f9' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:d7fe63a8-6f55-45af-a97c-3e06a3fee7f9', 2, 'II', 'First Event', 'Novelette pour orchestre: II. First Event', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 2411 AND p.composer_id = 110
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:d7fe63a8-6f55-45af-a97c-3e06a3fee7f9'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = 'Second Event', part.name_en = 'Novelette pour orchestre: III. Second Event',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 2411 AND p.composer_id = 110 AND part.part_key = 'musicbrainz:0de1c579-9f48-4a15-8ec5-17c9afccfc59' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:0de1c579-9f48-4a15-8ec5-17c9afccfc59', 3, 'III', 'Second Event', 'Novelette pour orchestre: III. Second Event', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 2411 AND p.composer_id = 110
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:0de1c579-9f48-4a15-8ec5-17c9afccfc59'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = 'IV',
    part.name_ko = 'Third Event', part.name_en = 'Novelette pour orchestre: IV. Third Event',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 2411 AND p.composer_id = 110 AND part.part_key = 'musicbrainz:9a9dd707-b83d-4d5f-80cc-e8bab9bee2b2' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:9a9dd707-b83d-4d5f-80cc-e8bab9bee2b2', 4, 'IV', 'Third Event', 'Novelette pour orchestre: IV. Third Event', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 2411 AND p.composer_id = 110
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:9a9dd707-b83d-4d5f-80cc-e8bab9bee2b2'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 5, part.movement_number = 'V',
    part.name_ko = 'Conclusion', part.name_en = 'Novelette pour orchestre: V. Conclusion',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 2411 AND p.composer_id = 110 AND part.part_key = 'musicbrainz:2152e001-af0c-4638-a81f-15ced5b698bd' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:2152e001-af0c-4638-a81f-15ced5b698bd', 5, 'V', 'Conclusion', 'Novelette pour orchestre: V. Conclusion', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 2411 AND p.composer_id = 110
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:2152e001-af0c-4638-a81f-15ced5b698bd'
);


-- None 가곡 <O Panu Tralalińskim>

UPDATE pieces piece
SET piece.title = '가곡 <O Panu Tralalińskim>', piece.title_en = 'O Panu Tralalińskim',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 668 AND piece.composer_id = 110
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Overture for Strings

UPDATE pieces piece
SET piece.title = 'Overture for Strings', piece.title_en = 'Overture for Strings',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 1572 AND piece.composer_id = 110
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Paroles tissées

UPDATE pieces piece
SET piece.title = 'Paroles tissées', piece.title_en = 'Paroles tissées',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 1742 AND piece.composer_id = 110
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = '''Un chat qui s''émerveille''', part.name_en = 'Paroles tissées: ''Un chat qui s''émerveille''',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 1742 AND p.composer_id = 110 AND part.part_key = 'musicbrainz:06d8e804-d980-44e2-876f-7694ce5e5b1f' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:06d8e804-d980-44e2-876f-7694ce5e5b1f', 1, NULL, '''Un chat qui s''émerveille''', 'Paroles tissées: ''Un chat qui s''émerveille''', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 1742 AND p.composer_id = 110
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:06d8e804-d980-44e2-876f-7694ce5e5b1f'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = '''Dormez cette pâleur nous est venue de loin''', part.name_en = 'Paroles tissées: ''Dormez cette pâleur nous est venue de loin''',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 1742 AND p.composer_id = 110 AND part.part_key = 'musicbrainz:361e2943-a8f0-4a93-b130-89a678d53c87' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:361e2943-a8f0-4a93-b130-89a678d53c87', 2, NULL, '''Dormez cette pâleur nous est venue de loin''', 'Paroles tissées: ''Dormez cette pâleur nous est venue de loin''', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 1742 AND p.composer_id = 110
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:361e2943-a8f0-4a93-b130-89a678d53c87'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = NULL,
    part.name_ko = '''Mille chevaux hors d''haleine''', part.name_en = 'Paroles tissées: ''Mille chevaux hors d''haleine''',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 1742 AND p.composer_id = 110 AND part.part_key = 'musicbrainz:897606fd-b8c0-47e6-8680-7d8c964132fb' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:897606fd-b8c0-47e6-8680-7d8c964132fb', 3, NULL, '''Mille chevaux hors d''haleine''', 'Paroles tissées: ''Mille chevaux hors d''haleine''', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 1742 AND p.composer_id = 110
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:897606fd-b8c0-47e6-8680-7d8c964132fb'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = NULL,
    part.name_ko = '''Quand le jour a rouvert les branches du jardin''', part.name_en = 'Paroles tissées: ''Quand le jour a rouvert les branches du jardin''',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 1742 AND p.composer_id = 110 AND part.part_key = 'musicbrainz:9fbf4fac-1b3a-4390-9a7f-cd6870b82f8f' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:9fbf4fac-1b3a-4390-9a7f-cd6870b82f8f', 4, NULL, '''Quand le jour a rouvert les branches du jardin''', 'Paroles tissées: ''Quand le jour a rouvert les branches du jardin''', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 1742 AND p.composer_id = 110
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:9fbf4fac-1b3a-4390-9a7f-cd6870b82f8f'
);


-- None Prelude for G.S.M.D.

UPDATE pieces piece
SET piece.title = 'Prelude for G.S.M.D.', piece.title_en = 'Prelude for G.S.M.D.',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 973 AND piece.composer_id = 110
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Preludes and Fugue for 13 Solo Strings

UPDATE pieces piece
SET piece.title = 'Preludes and Fugue for 13 Solo Strings', piece.title_en = 'Preludes and Fugue for 13 Solo Strings',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 1940 AND piece.composer_id = 110
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'Prelude 1', part.name_en = 'Preludes and Fugue for 13 Solo Strings: Prelude 1',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 1940 AND p.composer_id = 110 AND part.part_key = 'musicbrainz:c3d977ba-7f4e-3fbb-8864-6774ba67c490' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:c3d977ba-7f4e-3fbb-8864-6774ba67c490', 1, NULL, 'Prelude 1', 'Preludes and Fugue for 13 Solo Strings: Prelude 1', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 1940 AND p.composer_id = 110
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:c3d977ba-7f4e-3fbb-8864-6774ba67c490'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'Prelude 2', part.name_en = 'Preludes and Fugue for 13 Solo Strings: Prelude 2',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 1940 AND p.composer_id = 110 AND part.part_key = 'musicbrainz:1de650b4-57e8-41cf-9b33-4575be21da48' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:1de650b4-57e8-41cf-9b33-4575be21da48', 2, NULL, 'Prelude 2', 'Preludes and Fugue for 13 Solo Strings: Prelude 2', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 1940 AND p.composer_id = 110
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:1de650b4-57e8-41cf-9b33-4575be21da48'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = NULL,
    part.name_ko = 'Prelude 3', part.name_en = 'Preludes and Fugue for 13 Solo Strings: Prelude 3',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 1940 AND p.composer_id = 110 AND part.part_key = 'musicbrainz:a557d5c3-0b8a-4b04-8f32-05801975a494' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:a557d5c3-0b8a-4b04-8f32-05801975a494', 3, NULL, 'Prelude 3', 'Preludes and Fugue for 13 Solo Strings: Prelude 3', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 1940 AND p.composer_id = 110
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:a557d5c3-0b8a-4b04-8f32-05801975a494'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = NULL,
    part.name_ko = 'Prelude 4', part.name_en = 'Preludes and Fugue for 13 Solo Strings: Prelude 4',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 1940 AND p.composer_id = 110 AND part.part_key = 'musicbrainz:27902a4a-54e1-49fc-a75e-7f89a4911e7b' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:27902a4a-54e1-49fc-a75e-7f89a4911e7b', 4, NULL, 'Prelude 4', 'Preludes and Fugue for 13 Solo Strings: Prelude 4', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 1940 AND p.composer_id = 110
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:27902a4a-54e1-49fc-a75e-7f89a4911e7b'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 5, part.movement_number = NULL,
    part.name_ko = 'Prelude 5', part.name_en = 'Preludes and Fugue for 13 Solo Strings: Prelude 5',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 1940 AND p.composer_id = 110 AND part.part_key = 'musicbrainz:bbfbbbc2-685d-4240-9f94-d8af2dcd0567' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:bbfbbbc2-685d-4240-9f94-d8af2dcd0567', 5, NULL, 'Prelude 5', 'Preludes and Fugue for 13 Solo Strings: Prelude 5', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 1940 AND p.composer_id = 110
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:bbfbbbc2-685d-4240-9f94-d8af2dcd0567'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 6, part.movement_number = NULL,
    part.name_ko = 'Prelude 6', part.name_en = 'Preludes and Fugue for 13 Solo Strings: Prelude 6',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 1940 AND p.composer_id = 110 AND part.part_key = 'musicbrainz:0a56932b-81bc-46ac-bedc-33600087e296' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:0a56932b-81bc-46ac-bedc-33600087e296', 6, NULL, 'Prelude 6', 'Preludes and Fugue for 13 Solo Strings: Prelude 6', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 1940 AND p.composer_id = 110
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:0a56932b-81bc-46ac-bedc-33600087e296'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 7, part.movement_number = NULL,
    part.name_ko = 'Prelude 7', part.name_en = 'Preludes and Fugue for 13 Solo Strings: Prelude 7',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 1940 AND p.composer_id = 110 AND part.part_key = 'musicbrainz:2d17493a-0931-45a7-bafe-6dfda6971dd5' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:2d17493a-0931-45a7-bafe-6dfda6971dd5', 7, NULL, 'Prelude 7', 'Preludes and Fugue for 13 Solo Strings: Prelude 7', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 1940 AND p.composer_id = 110
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:2d17493a-0931-45a7-bafe-6dfda6971dd5'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 8, part.movement_number = NULL,
    part.name_ko = 'Fugue', part.name_en = 'Preludes and Fugue for 13 Solo Strings: Fugue',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 1940 AND p.composer_id = 110 AND part.part_key = 'musicbrainz:129e1fbf-f3ed-36ca-890e-3947b23d5ca8' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:129e1fbf-f3ed-36ca-890e-3947b23d5ca8', 8, NULL, 'Fugue', 'Preludes and Fugue for 13 Solo Strings: Fugue', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 1940 AND p.composer_id = 110
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:129e1fbf-f3ed-36ca-890e-3947b23d5ca8'
);


-- None Sacher Variation

UPDATE pieces piece
SET piece.title = 'Sacher Variation', piece.title_en = 'Sacher Variation',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 2986 AND piece.composer_id = 110
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Silesian Triptych

UPDATE pieces piece
SET piece.title = 'Silesian Triptych', piece.title_en = 'Silesian Triptych',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 1486 AND piece.composer_id = 110
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = '"Oj, mi się owiesek"', part.name_en = 'Silesian Triptych: I. "Oj, mi się owiesek"',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 1486 AND p.composer_id = 110 AND part.part_key = 'musicbrainz:942f1f83-ea08-3199-8b16-cbb159a02009' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:942f1f83-ea08-3199-8b16-cbb159a02009', 1, 'I', '"Oj, mi się owiesek"', 'Silesian Triptych: I. "Oj, mi się owiesek"', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 1486 AND p.composer_id = 110
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:942f1f83-ea08-3199-8b16-cbb159a02009'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = '"Ich, w tej studni"', part.name_en = 'Silesian Triptych: II. "Ich, w tej studni"',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 1486 AND p.composer_id = 110 AND part.part_key = 'musicbrainz:e39f0128-46ef-30b9-9994-fe612a602c96' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:e39f0128-46ef-30b9-9994-fe612a602c96', 2, 'II', '"Ich, w tej studni"', 'Silesian Triptych: II. "Ich, w tej studni"', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 1486 AND p.composer_id = 110
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:e39f0128-46ef-30b9-9994-fe612a602c96'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = '"Kukułeczka kuka"', part.name_en = 'Silesian Triptych: III. "Kukułeczka kuka"',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 1486 AND p.composer_id = 110 AND part.part_key = 'musicbrainz:2db20a55-c798-35d9-8cd0-641a2133afc2' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:2db20a55-c798-35d9-8cd0-641a2133afc2', 3, 'III', '"Kukułeczka kuka"', 'Silesian Triptych: III. "Kukułeczka kuka"', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 1486 AND p.composer_id = 110
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:2db20a55-c798-35d9-8cd0-641a2133afc2'
);


-- None 피아노 소나타

UPDATE pieces piece
SET piece.title = '피아노 소나타', piece.title_en = 'Sonata for Piano',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 1935 AND piece.composer_id = 110
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'Allegro', part.name_en = 'Sonata for Piano: I. Allegro',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 1935 AND p.composer_id = 110 AND part.part_key = 'musicbrainz:a4426069-91fd-4ce5-b236-77175ead768b' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:a4426069-91fd-4ce5-b236-77175ead768b', 1, 'I', 'Allegro', 'Sonata for Piano: I. Allegro', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 1935 AND p.composer_id = 110
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:a4426069-91fd-4ce5-b236-77175ead768b'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'Adagio ma non troppo', part.name_en = 'Sonata for Piano: II. Adagio ma non troppo',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 1935 AND p.composer_id = 110 AND part.part_key = 'musicbrainz:4d76a2c9-0b5d-4e94-bf4f-d9e669c75a7b' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:4d76a2c9-0b5d-4e94-bf4f-d9e669c75a7b', 2, 'II', 'Adagio ma non troppo', 'Sonata for Piano: II. Adagio ma non troppo', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 1935 AND p.composer_id = 110
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:4d76a2c9-0b5d-4e94-bf4f-d9e669c75a7b'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = 'Andante - Allegretto', part.name_en = 'Sonata for Piano: III. Andante - Allegretto',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 1935 AND p.composer_id = 110 AND part.part_key = 'musicbrainz:da32d535-9a34-492a-9ba1-91ac8b19fce8' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:da32d535-9a34-492a-9ba1-91ac8b19fce8', 3, 'III', 'Andante - Allegretto', 'Sonata for Piano: III. Andante - Allegretto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 1935 AND p.composer_id = 110
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:da32d535-9a34-492a-9ba1-91ac8b19fce8'
);


-- None 가곡 <Spóźniony słowik>

UPDATE pieces piece
SET piece.title = '가곡 <Spóźniony słowik>', piece.title_en = 'Spóźniony słowik',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 612 AND piece.composer_id = 110
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None 현악 4중주

UPDATE pieces piece
SET piece.title = '현악 4중주', piece.title_en = 'String Quartet',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 2778 AND piece.composer_id = 110
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'Introductory Movement', part.name_en = 'String Quartet: Introductory Movement',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 2778 AND p.composer_id = 110 AND part.part_key = 'musicbrainz:39016fa6-14d7-4b7b-9afb-1f66f05e196b' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:39016fa6-14d7-4b7b-9afb-1f66f05e196b', 1, NULL, 'Introductory Movement', 'String Quartet: Introductory Movement', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 2778 AND p.composer_id = 110
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:39016fa6-14d7-4b7b-9afb-1f66f05e196b'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'Main Movement', part.name_en = 'String Quartet: Main Movement',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 2778 AND p.composer_id = 110 AND part.part_key = 'musicbrainz:e6737612-1a0a-4514-87bc-63fbcc0c11a4' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:e6737612-1a0a-4514-87bc-63fbcc0c11a4', 2, NULL, 'Main Movement', 'String Quartet: Main Movement', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 2778 AND p.composer_id = 110
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:e6737612-1a0a-4514-87bc-63fbcc0c11a4'
);


-- None Subito

UPDATE pieces piece
SET piece.title = 'Subito', piece.title_en = 'Subito',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 2031 AND piece.composer_id = 110
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Symphonic Variations

UPDATE pieces piece
SET piece.title = 'Symphonic Variations', piece.title_en = 'Symphonic Variations',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 1796 AND piece.composer_id = 110
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None 교향곡 1번

UPDATE pieces piece
SET piece.title = '교향곡 1번', piece.title_en = 'Symphony no. 1',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 1199 AND piece.composer_id = 110
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'Allegro giusto', part.name_en = 'Symphony no. 1: I. Allegro giusto',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 1199 AND p.composer_id = 110 AND part.part_key = 'musicbrainz:16c50ede-636e-3f5f-bf82-ed664f3a5909' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:16c50ede-636e-3f5f-bf82-ed664f3a5909', 1, 'I', 'Allegro giusto', 'Symphony no. 1: I. Allegro giusto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 1199 AND p.composer_id = 110
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:16c50ede-636e-3f5f-bf82-ed664f3a5909'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'Poco adagio', part.name_en = 'Symphony no. 1: II. Poco adagio',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 1199 AND p.composer_id = 110 AND part.part_key = 'musicbrainz:90df167e-bf07-3b24-9fd7-d3929e33ef0c' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:90df167e-bf07-3b24-9fd7-d3929e33ef0c', 2, 'II', 'Poco adagio', 'Symphony no. 1: II. Poco adagio', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 1199 AND p.composer_id = 110
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:90df167e-bf07-3b24-9fd7-d3929e33ef0c'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = 'Allegretto misterioso', part.name_en = 'Symphony no. 1: III. Allegretto misterioso',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 1199 AND p.composer_id = 110 AND part.part_key = 'musicbrainz:576b039a-a61f-3bdd-8c8b-becd954d5e90' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:576b039a-a61f-3bdd-8c8b-becd954d5e90', 3, 'III', 'Allegretto misterioso', 'Symphony no. 1: III. Allegretto misterioso', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 1199 AND p.composer_id = 110
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:576b039a-a61f-3bdd-8c8b-becd954d5e90'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = 'IV',
    part.name_ko = 'Allegro vivace', part.name_en = 'Symphony no. 1: IV. Allegro vivace',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 1199 AND p.composer_id = 110 AND part.part_key = 'musicbrainz:90d9d603-1c98-3963-97ec-459b3e8bd87e' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:90d9d603-1c98-3963-97ec-459b3e8bd87e', 4, 'IV', 'Allegro vivace', 'Symphony no. 1: IV. Allegro vivace', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 1199 AND p.composer_id = 110
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:90d9d603-1c98-3963-97ec-459b3e8bd87e'
);


-- None 교향곡 3번

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'Vivo', part.name_en = 'Symphony no. 3: I. Vivo',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 415 AND p.composer_id = 110 AND part.part_key = 'musicbrainz:461bbb9d-12a9-4747-ac25-e0217ec26199' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:461bbb9d-12a9-4747-ac25-e0217ec26199', 1, 'I', 'Vivo', 'Symphony no. 3: I. Vivo', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 415 AND p.composer_id = 110
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:461bbb9d-12a9-4747-ac25-e0217ec26199'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'Poco meno mosso', part.name_en = 'Symphony no. 3: II. Poco meno mosso',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 415 AND p.composer_id = 110 AND part.part_key = 'musicbrainz:764eccb9-d24d-45de-a122-d3c45a3a1832' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:764eccb9-d24d-45de-a122-d3c45a3a1832', 2, 'II', 'Poco meno mosso', 'Symphony no. 3: II. Poco meno mosso', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 415 AND p.composer_id = 110
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:764eccb9-d24d-45de-a122-d3c45a3a1832'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = 'A tempo', part.name_en = 'Symphony no. 3: III. A tempo',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 415 AND p.composer_id = 110 AND part.part_key = 'musicbrainz:2bc99315-07c0-4299-9f63-8c8908b57eef' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:2bc99315-07c0-4299-9f63-8c8908b57eef', 3, 'III', 'A tempo', 'Symphony no. 3: III. A tempo', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 415 AND p.composer_id = 110
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:2bc99315-07c0-4299-9f63-8c8908b57eef'
);


-- None Szesc piosenek dziecinnych

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'Taniec', part.name_en = 'Szesc piosenek dziecinnych: 1. Taniec',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 481 AND p.composer_id = 110 AND part.part_key = 'musicbrainz:505f9074-a54c-4ad1-b011-679e56374648' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:505f9074-a54c-4ad1-b011-679e56374648', 1, NULL, 'Taniec', 'Szesc piosenek dziecinnych: 1. Taniec', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 481 AND p.composer_id = 110
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:505f9074-a54c-4ad1-b011-679e56374648'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'Rok i bieda', part.name_en = 'Szesc piosenek dziecinnych: 2. Rok i bieda',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 481 AND p.composer_id = 110 AND part.part_key = 'musicbrainz:8f22a0dd-48df-47d0-9259-e91868c69217' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:8f22a0dd-48df-47d0-9259-e91868c69217', 2, NULL, 'Rok i bieda', 'Szesc piosenek dziecinnych: 2. Rok i bieda', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 481 AND p.composer_id = 110
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:8f22a0dd-48df-47d0-9259-e91868c69217'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = NULL,
    part.name_ko = 'Kotek', part.name_en = 'Szesc piosenek dziecinnych: 3. Kotek',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 481 AND p.composer_id = 110 AND part.part_key = 'musicbrainz:cae8530b-9420-431c-9b15-5cf06e4cca92' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:cae8530b-9420-431c-9b15-5cf06e4cca92', 3, NULL, 'Kotek', 'Szesc piosenek dziecinnych: 3. Kotek', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 481 AND p.composer_id = 110
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:cae8530b-9420-431c-9b15-5cf06e4cca92'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = NULL,
    part.name_ko = 'Idzie Grześ', part.name_en = 'Szesc piosenek dziecinnych: 4. Idzie Grześ',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 481 AND p.composer_id = 110 AND part.part_key = 'musicbrainz:3639d33f-9351-432c-85c4-b688bb32008b' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:3639d33f-9351-432c-85c4-b688bb32008b', 4, NULL, 'Idzie Grześ', 'Szesc piosenek dziecinnych: 4. Idzie Grześ', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 481 AND p.composer_id = 110
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:3639d33f-9351-432c-85c4-b688bb32008b'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 5, part.movement_number = NULL,
    part.name_ko = 'Rzeczka', part.name_en = 'Szesc piosenek dziecinnych: 5. Rzeczka',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 481 AND p.composer_id = 110 AND part.part_key = 'musicbrainz:8ed7cc67-4469-4e3a-bf11-fb37bc779611' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:8ed7cc67-4469-4e3a-bf11-fb37bc779611', 5, NULL, 'Rzeczka', 'Szesc piosenek dziecinnych: 5. Rzeczka', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 481 AND p.composer_id = 110
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:8ed7cc67-4469-4e3a-bf11-fb37bc779611'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 6, part.movement_number = NULL,
    part.name_ko = 'Ptasie plotki', part.name_en = 'Szesc piosenek dziecinnych: 6. Ptasie plotki',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 481 AND p.composer_id = 110 AND part.part_key = 'musicbrainz:8f9f934d-7c02-45ac-834e-387406a2f075' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:8f9f934d-7c02-45ac-834e-387406a2f075', 6, NULL, 'Ptasie plotki', 'Szesc piosenek dziecinnych: 6. Ptasie plotki', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 481 AND p.composer_id = 110
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:8f9f934d-7c02-45ac-834e-387406a2f075'
);


-- None Three Fragments for Flute and Harp

UPDATE pieces piece
SET piece.title = 'Three Fragments for Flute and Harp', piece.title_en = 'Three Fragments for Flute and Harp',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 937 AND piece.composer_id = 110
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'Magie', part.name_en = 'Three Fragments for Flute and Harp: No. 1. Magie',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 937 AND p.composer_id = 110 AND part.part_key = 'musicbrainz:c70cd705-785a-453b-b844-ba24b73ff62c' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:c70cd705-785a-453b-b844-ba24b73ff62c', 1, NULL, 'Magie', 'Three Fragments for Flute and Harp: No. 1. Magie', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 937 AND p.composer_id = 110
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:c70cd705-785a-453b-b844-ba24b73ff62c'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'Ulysse en Itaque', part.name_en = 'Three Fragments for Flute and Harp: No. 2. Ulysse en Itaque',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 937 AND p.composer_id = 110 AND part.part_key = 'musicbrainz:015522c5-7491-4f8d-9f02-9b43b659c541' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:015522c5-7491-4f8d-9f02-9b43b659c541', 2, NULL, 'Ulysse en Itaque', 'Three Fragments for Flute and Harp: No. 2. Ulysse en Itaque', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 937 AND p.composer_id = 110
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:015522c5-7491-4f8d-9f02-9b43b659c541'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = NULL,
    part.name_ko = 'Presto', part.name_en = 'Three Fragments for Flute and Harp: No. 3. Presto',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 937 AND p.composer_id = 110 AND part.part_key = 'musicbrainz:59ce1715-a749-4dbf-b898-7a240609d8c6' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:59ce1715-a749-4dbf-b898-7a240609d8c6', 3, NULL, 'Presto', 'Three Fragments for Flute and Harp: No. 3. Presto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 937 AND p.composer_id = 110
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:59ce1715-a749-4dbf-b898-7a240609d8c6'
);


-- None Three Postludes

UPDATE pieces piece
SET piece.title = 'Three Postludes', piece.title_en = 'Three Postludes',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 1267 AND piece.composer_id = 110
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'Postlude no. 1', part.name_en = 'Three Postludes: Postlude no. 1',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 1267 AND p.composer_id = 110 AND part.part_key = 'musicbrainz:9343db37-1f24-35fa-9973-7a3f06fbd87d' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:9343db37-1f24-35fa-9973-7a3f06fbd87d', 1, NULL, 'Postlude no. 1', 'Three Postludes: Postlude no. 1', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 1267 AND p.composer_id = 110
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:9343db37-1f24-35fa-9973-7a3f06fbd87d'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'Postlude no. 2', part.name_en = 'Three Postludes: Postlude no. 2',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 1267 AND p.composer_id = 110 AND part.part_key = 'musicbrainz:114b7159-ef25-4730-a110-28cb6230b3ab' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:114b7159-ef25-4730-a110-28cb6230b3ab', 2, NULL, 'Postlude no. 2', 'Three Postludes: Postlude no. 2', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 1267 AND p.composer_id = 110
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:114b7159-ef25-4730-a110-28cb6230b3ab'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = NULL,
    part.name_ko = 'Postlude no. 3', part.name_en = 'Three Postludes: Postlude no. 3',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 1267 AND p.composer_id = 110 AND part.part_key = 'musicbrainz:74fd6a2b-8165-450b-a514-c97c45223288' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:74fd6a2b-8165-450b-a514-c97c45223288', 3, NULL, 'Postlude no. 3', 'Three Postludes: Postlude no. 3', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 1267 AND p.composer_id = 110
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:74fd6a2b-8165-450b-a514-c97c45223288'
);


-- None Trois poèmes d'Henri Michaux

UPDATE pieces piece
SET piece.title = 'Trois poèmes d''Henri Michaux', piece.title_en = 'Trois poèmes d''Henri Michaux',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 1695 AND piece.composer_id = 110
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'Pensées', part.name_en = 'Trois poèmes d''Henri Michaux: I. Pensées',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 1695 AND p.composer_id = 110 AND part.part_key = 'musicbrainz:34358e99-36ac-3aa7-9425-b34c38493028' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:34358e99-36ac-3aa7-9425-b34c38493028', 1, 'I', 'Pensées', 'Trois poèmes d''Henri Michaux: I. Pensées', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 1695 AND p.composer_id = 110
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:34358e99-36ac-3aa7-9425-b34c38493028'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'Le grand combat', part.name_en = 'Trois poèmes d''Henri Michaux: II. Le grand combat',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 1695 AND p.composer_id = 110 AND part.part_key = 'musicbrainz:dcaf2ae3-e3e3-323c-aada-03d6868d2fbb' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:dcaf2ae3-e3e3-323c-aada-03d6868d2fbb', 2, 'II', 'Le grand combat', 'Trois poèmes d''Henri Michaux: II. Le grand combat', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 1695 AND p.composer_id = 110
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:dcaf2ae3-e3e3-323c-aada-03d6868d2fbb'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = 'Repos dans le malheur', part.name_en = 'Trois poèmes d''Henri Michaux: III. Repos dans le malheur',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 1695 AND p.composer_id = 110 AND part.part_key = 'musicbrainz:f0a38de4-6e13-3732-980c-ca058dd3b94a' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:f0a38de4-6e13-3732-980c-ca058dd3b94a', 3, 'III', 'Repos dans le malheur', 'Trois poèmes d''Henri Michaux: III. Repos dans le malheur', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 1695 AND p.composer_id = 110
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:f0a38de4-6e13-3732-980c-ca058dd3b94a'
);


-- None Trzy utwory dla młodzieży

UPDATE pieces piece
SET piece.title = 'Trzy utwory dla młodzieży', piece.title_en = 'Trzy utwory dla młodzieży',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 525 AND piece.composer_id = 110
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'Czteropalcówka. Allegro', part.name_en = 'Trzy utwory dla młodzieży: 1. Czteropalcówka. Allegro',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 525 AND p.composer_id = 110 AND part.part_key = 'musicbrainz:f4910869-901d-464b-8702-89d1ec0c2bd7' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:f4910869-901d-464b-8702-89d1ec0c2bd7', 1, NULL, 'Czteropalcówka. Allegro', 'Trzy utwory dla młodzieży: 1. Czteropalcówka. Allegro', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 525 AND p.composer_id = 110
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:f4910869-901d-464b-8702-89d1ec0c2bd7'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'Melodia. Andante con moto', part.name_en = 'Trzy utwory dla młodzieży: 2. Melodia. Andante con moto',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 525 AND p.composer_id = 110 AND part.part_key = 'musicbrainz:349dc4ee-7a4a-4974-8a6a-10c8a6da4ff7' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:349dc4ee-7a4a-4974-8a6a-10c8a6da4ff7', 2, NULL, 'Melodia. Andante con moto', 'Trzy utwory dla młodzieży: 2. Melodia. Andante con moto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 525 AND p.composer_id = 110
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:349dc4ee-7a4a-4974-8a6a-10c8a6da4ff7'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = NULL,
    part.name_ko = 'Marsz. Allegro', part.name_en = 'Trzy utwory dla młodzieży: 3. Marsz. Allegro',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 525 AND p.composer_id = 110 AND part.part_key = 'musicbrainz:713b020f-3b28-43bc-a1a1-99b30e03b002' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:713b020f-3b28-43bc-a1a1-99b30e03b002', 3, NULL, 'Marsz. Allegro', 'Trzy utwory dla młodzieży: 3. Marsz. Allegro', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 525 AND p.composer_id = 110
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:713b020f-3b28-43bc-a1a1-99b30e03b002'
);


-- None Tune

UPDATE pieces piece
SET piece.title = 'Tune', piece.title_en = 'Tune',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 2783 AND piece.composer_id = 110
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None 2개의 연습곡

UPDATE pieces piece
SET piece.title = '2개의 연습곡', piece.title_en = 'Two Études',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 2684 AND piece.composer_id = 110
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'Étude no. 1', part.name_en = 'Étude no. 1',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 2684 AND p.composer_id = 110 AND part.part_key = 'musicbrainz:bb732088-3cf2-4100-a094-bdfa6ab9e1de' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:bb732088-3cf2-4100-a094-bdfa6ab9e1de', 1, NULL, 'Étude no. 1', 'Étude no. 1', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 2684 AND p.composer_id = 110
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:bb732088-3cf2-4100-a094-bdfa6ab9e1de'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'Étude no. 2', part.name_en = 'Étude no. 2',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 2684 AND p.composer_id = 110 AND part.part_key = 'musicbrainz:c08b6b16-855f-4301-8966-3cdc772c22c3' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:c08b6b16-855f-4301-8966-3cdc772c22c3', 2, NULL, 'Étude no. 2', 'Étude no. 2', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 2684 AND p.composer_id = 110
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:c08b6b16-855f-4301-8966-3cdc772c22c3'
);


-- None Śpijże, Śpij

UPDATE pieces piece
SET piece.title = 'Śpijże, Śpij', piece.title_en = 'Śpijże, Śpij',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 670 AND piece.composer_id = 110
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Grave

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, 'Grave', 'Grave', 'song', NULL, NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 110
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = 'Grave'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'da97ff97-0813-3a8e-928e-cda9d85959f8'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'da97ff97-0813-3a8e-928e-cda9d85959f8'
FROM pieces p
WHERE p.composer_id = 110 AND p.title = 'Grave' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'da97ff97-0813-3a8e-928e-cda9d85959f8'
);


-- None Mała suita

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, 'Mała suita', 'Mała suita', 'song', NULL, NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 110
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = 'Mała suita'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '06210ba7-6caf-495f-9b35-d162c3a185cf'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '06210ba7-6caf-495f-9b35-d162c3a185cf'
FROM pieces p
WHERE p.composer_id = 110 AND p.title = 'Mała suita' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '06210ba7-6caf-495f-9b35-d162c3a185cf'
);


-- None 파르티타

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '파르티타', 'Partita', 'album', NULL, NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 110
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '파르티타'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'acc727a4-6c31-4a33-9f9c-5e5f662ab4e3'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'acc727a4-6c31-4a33-9f9c-5e5f662ab4e3'
FROM pieces p
WHERE p.composer_id = 110 AND p.title = '파르티타' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'acc727a4-6c31-4a33-9f9c-5e5f662ab4e3'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:4b1cbdfe-0be5-4118-bc1b-2b1a06737d95', 1, 'I', 'Allegro giusto', 'Partita: I. Allegro giusto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 110 AND p.title = '파르티타' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:4b1cbdfe-0be5-4118-bc1b-2b1a06737d95'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:7adf8db4-b7c5-4bda-8d1a-23b5447cfba9', 2, 'II', 'Ad libitum', 'Partita: II. Ad libitum', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 110 AND p.title = '파르티타' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:7adf8db4-b7c5-4bda-8d1a-23b5447cfba9'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:5e4a8aca-f052-441c-963d-fe05295d4c30', 3, 'III', 'Largo', 'Partita: III. Largo', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 110 AND p.title = '파르티타' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:5e4a8aca-f052-441c-963d-fe05295d4c30'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:8f07f9ba-5bbc-47d6-b5f7-b9fa3d196c9c', 4, 'IV', 'Ad libitum', 'Partita: IV. Ad libitum', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 110 AND p.title = '파르티타' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:8f07f9ba-5bbc-47d6-b5f7-b9fa3d196c9c'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:10fc3412-681d-41e6-a55e-26ab00f56fc1', 5, 'V', 'Presto', 'Partita: V. Presto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 110 AND p.title = '파르티타' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:10fc3412-681d-41e6-a55e-26ab00f56fc1'
);


-- None Polish Christmas Carols

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, 'Polish Christmas Carols', 'Polish Christmas Carols', 'song', NULL, NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 110
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = 'Polish Christmas Carols'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'd7d9306d-1655-4b1e-8daf-2a03d0ace236'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'd7d9306d-1655-4b1e-8daf-2a03d0ace236'
FROM pieces p
WHERE p.composer_id = 110 AND p.title = 'Polish Christmas Carols' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'd7d9306d-1655-4b1e-8daf-2a03d0ace236'
);


-- None Preludia taneczne

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, 'Preludia taneczne', 'Preludia taneczne', 'album', NULL, NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 110
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = 'Preludia taneczne'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '00e7a159-80a9-4e8d-ba23-38b416e3a5c6'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '00e7a159-80a9-4e8d-ba23-38b416e3a5c6'
FROM pieces p
WHERE p.composer_id = 110 AND p.title = 'Preludia taneczne' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '00e7a159-80a9-4e8d-ba23-38b416e3a5c6'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:81c89052-fa41-40af-af1a-b9bc9817c953', 1, 'I', 'Allegro molto', 'Preludia taneczne: I. Allegro molto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 110 AND p.title = 'Preludia taneczne' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:81c89052-fa41-40af-af1a-b9bc9817c953'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:667fab8a-126b-4feb-b418-f7877b2b5b8e', 2, 'II', 'Andantino', 'Preludia taneczne: II. Andantino', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 110 AND p.title = 'Preludia taneczne' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:667fab8a-126b-4feb-b418-f7877b2b5b8e'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:2df2feb7-4566-4e2a-a6c4-c9cebe2da1e4', 3, 'III', 'Allegro giocoso', 'Preludia taneczne: III. Allegro giocoso', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 110 AND p.title = 'Preludia taneczne' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:2df2feb7-4566-4e2a-a6c4-c9cebe2da1e4'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:49f41fb7-2973-4aed-80be-867de2d282e9', 4, 'IV', 'Andante', 'Preludia taneczne: IV. Andante', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 110 AND p.title = 'Preludia taneczne' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:49f41fb7-2973-4aed-80be-867de2d282e9'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:077736fc-aed1-47fb-a13e-195faa1ebdfe', 5, 'V', 'Allegro molto', 'Preludia taneczne: V. Allegro molto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 110 AND p.title = 'Preludia taneczne' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:077736fc-aed1-47fb-a13e-195faa1ebdfe'
);


-- None Recitativo e arioso

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, 'Recitativo e arioso', 'Recitativo e arioso', 'song', NULL, NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 110
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = 'Recitativo e arioso'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'a2593347-2ec6-4464-88a4-566debefefe0'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'a2593347-2ec6-4464-88a4-566debefefe0'
FROM pieces p
WHERE p.composer_id = 110 AND p.title = 'Recitativo e arioso' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'a2593347-2ec6-4464-88a4-566debefefe0'
);


-- None 교향곡 2번

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '교향곡 2번', 'Symphony no. 2', 'album', NULL, NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 110
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '교향곡 2번'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '6f17ca2c-be4e-4ed8-9179-587e51b4b63b'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '6f17ca2c-be4e-4ed8-9179-587e51b4b63b'
FROM pieces p
WHERE p.composer_id = 110 AND p.title = '교향곡 2번' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '6f17ca2c-be4e-4ed8-9179-587e51b4b63b'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:7de73d19-c8fb-30e7-b656-bb4c081fa0f4', 1, 'I', 'Hésitant', 'Symphony no. 2: I. Hésitant', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 110 AND p.title = '교향곡 2번' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:7de73d19-c8fb-30e7-b656-bb4c081fa0f4'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:f839ac5c-2f2b-3aef-983d-4db4cfd03f1b', 2, 'II', 'Direct', 'Symphony no. 2: II. Direct', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 110 AND p.title = '교향곡 2번' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:f839ac5c-2f2b-3aef-983d-4db4cfd03f1b'
);


-- None 교향곡 4번

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '교향곡 4번', 'Symphony no. 4', 'song', NULL, NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 110
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '교향곡 4번'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '4ef6d273-4534-4b37-97f1-3e01d76b2fe5'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '4ef6d273-4534-4b37-97f1-3e01d76b2fe5'
FROM pieces p
WHERE p.composer_id = 110 AND p.title = '교향곡 4번' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '4ef6d273-4534-4b37-97f1-3e01d76b2fe5'
);


-- 카탈로그에 대응이 없는 seed 작품 6개를 목록에서 숨긴다(지우지 않음).
UPDATE pieces piece
SET piece.hidden_reason = 'catalog_unmatched'
WHERE piece.composer_id = 110 AND piece.origin = 'seed' AND piece.hidden_reason IS NULL
  AND piece.id IN (
    515, 916, 1750, 1959, 2293, 2340
  )
  AND NOT EXISTS (SELECT 1 FROM performance_sectors sector WHERE sector.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM piece_parts linking WHERE linking.linked_piece_id = piece.id);
