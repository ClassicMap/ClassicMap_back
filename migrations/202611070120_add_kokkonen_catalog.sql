-- Joonas Kokkonen 작품을 MusicBrainz 작품 구조로 다시 짠다(5차 자동). 작품 39개(묶음 5, 다악장 20, 낱곡 14),
-- 새 작품 9개, part 98개, 그 아래 0개.
-- seed 33개 중 30개를 작품·part 에 잇고, 3개를 숨기고, 0개는 그대로 둔다.
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

-- None ...durch einen Spiegel

UPDATE pieces piece
SET piece.title = '...durch einen Spiegel', piece.title_en = '...durch einen Spiegel',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 24655 AND piece.composer_id = 418
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None 영화음악 <Amy>

UPDATE pieces piece
SET piece.title = '영화음악 <Amy>', piece.title_en = 'Amy',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 24177 AND piece.composer_id = 418
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None 콘체르티노

UPDATE pieces piece
SET piece.title = '콘체르티노', piece.title_en = 'Concertino',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 24830 AND piece.composer_id = 418
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Crescat in G

UPDATE pieces piece
SET piece.title = 'Crescat in G', piece.title_en = 'Crescat in G',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 24704 AND piece.composer_id = 418
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Duo

UPDATE pieces piece
SET piece.title = 'Duo', piece.title_en = 'Duo',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 24436 AND piece.composer_id = 418
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'Allegro moderato', part.name_en = 'Duo: I. Allegro moderato',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 24436 AND p.composer_id = 418 AND part.part_key = 'musicbrainz:d33fbdaf-dfa3-4c60-a3d0-d620e2c8d909' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:d33fbdaf-dfa3-4c60-a3d0-d620e2c8d909', 1, 'I', 'Allegro moderato', 'Duo: I. Allegro moderato', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 24436 AND p.composer_id = 418
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:d33fbdaf-dfa3-4c60-a3d0-d620e2c8d909'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'Intermezzo: Allegro grazioso', part.name_en = 'Duo: II. Intermezzo: Allegro grazioso',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 24436 AND p.composer_id = 418 AND part.part_key = 'musicbrainz:2528f544-055f-4548-a435-dabae539d2ff' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:2528f544-055f-4548-a435-dabae539d2ff', 2, 'II', 'Intermezzo: Allegro grazioso', 'Duo: II. Intermezzo: Allegro grazioso', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 24436 AND p.composer_id = 418
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:2528f544-055f-4548-a435-dabae539d2ff'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = 'Un poco adagio', part.name_en = 'Duo: III. Un poco adagio',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 24436 AND p.composer_id = 418 AND part.part_key = 'musicbrainz:8858cfb5-d9c8-4dcd-95d9-58e075aabfa8' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:8858cfb5-d9c8-4dcd-95d9-58e075aabfa8', 3, 'III', 'Un poco adagio', 'Duo: III. Un poco adagio', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 24436 AND p.composer_id = 418
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:8858cfb5-d9c8-4dcd-95d9-58e075aabfa8'
);


-- None 칸타타 <Erekhtheion>

UPDATE pieces piece
SET piece.title = '칸타타 <Erekhtheion>', piece.title_en = 'Erekhtheion',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 25050 AND piece.composer_id = 418
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'Erekhtheion', part.name_en = 'Erekhtheion: I. Erekhtheion',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 25050 AND p.composer_id = 418 AND part.part_key = 'musicbrainz:a90d1316-55b9-43b9-8b64-8c0fa860e9f8' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:a90d1316-55b9-43b9-8b64-8c0fa860e9f8', 1, 'I', 'Erekhtheion', 'Erekhtheion: I. Erekhtheion', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 25050 AND p.composer_id = 418
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:a90d1316-55b9-43b9-8b64-8c0fa860e9f8'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'Hahmo', part.name_en = 'Erekhtheion: II. Hahmo',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 25050 AND p.composer_id = 418 AND part.part_key = 'musicbrainz:93c40710-85d7-45e3-91b3-fb5ff60b59c6' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:93c40710-85d7-45e3-91b3-fb5ff60b59c6', 2, 'II', 'Hahmo', 'Erekhtheion: II. Hahmo', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 25050 AND p.composer_id = 418
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:93c40710-85d7-45e3-91b3-fb5ff60b59c6'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = 'Aikamiesten tansis', part.name_en = 'Erekhtheion: III. Aikamiesten tansis',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 25050 AND p.composer_id = 418 AND part.part_key = 'musicbrainz:15fed32e-945e-4966-add8-25f67e73bdc9' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:15fed32e-945e-4966-add8-25f67e73bdc9', 3, 'III', 'Aikamiesten tansis', 'Erekhtheion: III. Aikamiesten tansis', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 25050 AND p.composer_id = 418
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:15fed32e-945e-4966-add8-25f67e73bdc9'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = 'IV',
    part.name_ko = 'Tämä maa', part.name_en = 'Erekhtheion: IV. Tämä maa',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 25050 AND p.composer_id = 418 AND part.part_key = 'musicbrainz:8aef6e1d-716b-4bdb-9285-8e70189d9279' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:8aef6e1d-716b-4bdb-9285-8e70189d9279', 4, 'IV', 'Tämä maa', 'Erekhtheion: IV. Tämä maa', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 25050 AND p.composer_id = 418
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:8aef6e1d-716b-4bdb-9285-8e70189d9279'
);


-- None 연습곡

UPDATE pieces piece
SET piece.title = '연습곡', piece.title_en = 'Etude',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 25816 AND piece.composer_id = 418
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Häämarssi

UPDATE pieces piece
SET piece.title = 'Häämarssi', piece.title_en = 'Häämarssi',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 23672 AND piece.composer_id = 418
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None 칸타타 <Ikivihreä>

UPDATE pieces piece
SET piece.title = '칸타타 <Ikivihreä>', piece.title_en = 'Ikivihreä',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 23896 AND piece.composer_id = 418
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'Pellon ikävä', part.name_en = 'Ikivihreä: I. Pellon ikävä',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 23896 AND p.composer_id = 418 AND part.part_key = 'musicbrainz:5a8b3590-c3d6-4f4b-8814-9cfe3f70f896' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:5a8b3590-c3d6-4f4b-8814-9cfe3f70f896', 1, 'I', 'Pellon ikävä', 'Ikivihreä: I. Pellon ikävä', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 23896 AND p.composer_id = 418
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:5a8b3590-c3d6-4f4b-8814-9cfe3f70f896'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'Järvi heijastaa', part.name_en = 'Ikivihreä: II. Järvi heijastaa',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 23896 AND p.composer_id = 418 AND part.part_key = 'musicbrainz:571a59e1-7459-498e-b80c-dab3aed7fedc' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:571a59e1-7459-498e-b80c-dab3aed7fedc', 2, 'II', 'Järvi heijastaa', 'Ikivihreä: II. Järvi heijastaa', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 23896 AND p.composer_id = 418
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:571a59e1-7459-498e-b80c-dab3aed7fedc'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = 'Ikivihreä', part.name_en = 'Ikivihreä: III. Ikivihreä',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 23896 AND p.composer_id = 418 AND part.part_key = 'musicbrainz:c06c8cef-f0b8-4168-9889-8b98abf39e61' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:c06c8cef-f0b8-4168-9889-8b98abf39e61', 3, 'III', 'Ikivihreä', 'Ikivihreä: III. Ikivihreä', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 23896 AND p.composer_id = 418
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:c06c8cef-f0b8-4168-9889-8b98abf39e61'
);


-- None Il paesaggio

UPDATE pieces piece
SET piece.title = 'Il paesaggio', piece.title_en = 'Il paesaggio',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 23384 AND piece.composer_id = 418
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None 연가곡집 <Illat>

UPDATE pieces piece
SET piece.title = '연가곡집 <Illat>', piece.title_en = 'Illat',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 25165 AND piece.composer_id = 418
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'Hiljainen, surullinen ilta', part.name_en = 'Illat: No. 1. Hiljainen, surullinen ilta',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 25165 AND p.composer_id = 418 AND part.part_key = 'musicbrainz:63f25cb7-e327-42d8-8b07-03e13b9ce6a0' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:63f25cb7-e327-42d8-8b07-03e13b9ce6a0', 1, NULL, 'Hiljainen, surullinen ilta', 'Illat: No. 1. Hiljainen, surullinen ilta', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 25165 AND p.composer_id = 418
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:63f25cb7-e327-42d8-8b07-03e13b9ce6a0'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'Ihana, surullinen ilta', part.name_en = 'Illat: No. 2. Ihana, surullinen ilta',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 25165 AND p.composer_id = 418 AND part.part_key = 'musicbrainz:4d319080-9a58-433b-87c4-7b647b5156c2' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:4d319080-9a58-433b-87c4-7b647b5156c2', 2, NULL, 'Ihana, surullinen ilta', 'Illat: No. 2. Ihana, surullinen ilta', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 25165 AND p.composer_id = 418
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:4d319080-9a58-433b-87c4-7b647b5156c2'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = NULL,
    part.name_ko = 'Kevätilta', part.name_en = 'Illat: No. 3. Kevätilta',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 25165 AND p.composer_id = 418 AND part.part_key = 'musicbrainz:9057d622-fa23-409e-ae64-99c37f813080' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:9057d622-fa23-409e-ae64-99c37f813080', 3, NULL, 'Kevätilta', 'Illat: No. 3. Kevätilta', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 25165 AND p.composer_id = 418
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:9057d622-fa23-409e-ae64-99c37f813080'
);


-- None 즉흥곡

UPDATE pieces piece
SET piece.title = '즉흥곡', piece.title_en = 'Impromptu',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 25917 AND piece.composer_id = 418
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Inauguratio

UPDATE pieces piece
SET piece.title = 'Inauguratio', piece.title_en = 'Inauguratio',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 23473 AND piece.composer_id = 418
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Iuxta crucem

UPDATE pieces piece
SET piece.title = 'Iuxta crucem', piece.title_en = 'Iuxta crucem',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 23764 AND piece.composer_id = 418
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Joululauluja lapsille

UPDATE pieces piece
SET piece.title = 'Joululauluja lapsille', piece.title_en = 'Joululauluja lapsille',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 26004 AND piece.composer_id = 418
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'Jouluna', part.name_en = 'Jouluna',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 26004 AND p.composer_id = 418 AND part.part_key = 'musicbrainz:75eff6ac-42a9-4451-88d0-6ab2036e1c02' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:75eff6ac-42a9-4451-88d0-6ab2036e1c02', 1, NULL, 'Jouluna', 'Jouluna', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 26004 AND p.composer_id = 418
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:75eff6ac-42a9-4451-88d0-6ab2036e1c02'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'Aattoiltana', part.name_en = 'Aattoiltana',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 26004 AND p.composer_id = 418 AND part.part_key = 'musicbrainz:3dc4e24c-c374-4820-b543-3baf2c65822d' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:3dc4e24c-c374-4820-b543-3baf2c65822d', 2, NULL, 'Aattoiltana', 'Aattoiltana', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 26004 AND p.composer_id = 418
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:3dc4e24c-c374-4820-b543-3baf2c65822d'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = NULL,
    part.name_ko = 'Metsän joulu', part.name_en = 'Metsän joulu',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 26004 AND p.composer_id = 418 AND part.part_key = 'musicbrainz:2bf74b35-fe82-40ea-b563-6ec02c1ff9fc' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:2bf74b35-fe82-40ea-b563-6ec02c1ff9fc', 3, NULL, 'Metsän joulu', 'Metsän joulu', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 26004 AND p.composer_id = 418
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:2bf74b35-fe82-40ea-b563-6ec02c1ff9fc'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = NULL,
    part.name_ko = 'Legenda', part.name_en = 'Legenda',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 26004 AND p.composer_id = 418 AND part.part_key = 'musicbrainz:eb4b53a2-bc06-4218-8597-7d43b13bc157' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:eb4b53a2-bc06-4218-8597-7d43b13bc157', 4, NULL, 'Legenda', 'Legenda', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 26004 AND p.composer_id = 418
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:eb4b53a2-bc06-4218-8597-7d43b13bc157'
);


-- None Järvenpään kirkon kellosävelmät

UPDATE pieces piece
SET piece.title = 'Järvenpään kirkon kellosävelmät', piece.title_en = 'Järvenpään kirkon kellosävelmät',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 25602 AND piece.composer_id = 418
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'Ehtookellot', part.name_en = 'Järvenpään kirkon kellosävelmät: No. 1. Ehtookellot',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 25602 AND p.composer_id = 418 AND part.part_key = 'musicbrainz:a9e37ee0-3842-44c5-b8f4-6197e87739ab' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:a9e37ee0-3842-44c5-b8f4-6197e87739ab', 1, NULL, 'Ehtookellot', 'Järvenpään kirkon kellosävelmät: No. 1. Ehtookellot', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 25602 AND p.composer_id = 418
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:a9e37ee0-3842-44c5-b8f4-6197e87739ab'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'Huomenkellot', part.name_en = 'Järvenpään kirkon kellosävelmät: No. 2. Huomenkellot',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 25602 AND p.composer_id = 418 AND part.part_key = 'musicbrainz:93eaa40a-3ab3-4efa-b668-288fa16994ed' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:93eaa40a-3ab3-4efa-b668-288fa16994ed', 2, NULL, 'Huomenkellot', 'Järvenpään kirkon kellosävelmät: No. 2. Huomenkellot', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 25602 AND p.composer_id = 418
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:93eaa40a-3ab3-4efa-b668-288fa16994ed'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = NULL,
    part.name_ko = 'Papinkellot', part.name_en = 'Järvenpään kirkon kellosävelmät: No. 3. Papinkellot',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 25602 AND p.composer_id = 418 AND part.part_key = 'musicbrainz:513c0511-4f63-406c-afe0-f278a8e4de23' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:513c0511-4f63-406c-afe0-f278a8e4de23', 3, NULL, 'Papinkellot', 'Järvenpään kirkon kellosävelmät: No. 3. Papinkellot', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 25602 AND p.composer_id = 418
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:513c0511-4f63-406c-afe0-f278a8e4de23'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = NULL,
    part.name_ko = 'Kokoonsoitto', part.name_en = 'Järvenpään kirkon kellosävelmät: No. 4. Kokoonsoitto',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 25602 AND p.composer_id = 418 AND part.part_key = 'musicbrainz:ec8b4fbc-7689-4295-8dc9-39812e3e5a7f' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:ec8b4fbc-7689-4295-8dc9-39812e3e5a7f', 4, NULL, 'Kokoonsoitto', 'Järvenpään kirkon kellosävelmät: No. 4. Kokoonsoitto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 25602 AND p.composer_id = 418
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:ec8b4fbc-7689-4295-8dc9-39812e3e5a7f'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 5, part.movement_number = NULL,
    part.name_ko = 'Juhlasoitto', part.name_en = 'Järvenpään kirkon kellosävelmät: No. 5. Juhlasoitto',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 25602 AND p.composer_id = 418 AND part.part_key = 'musicbrainz:96d34801-6d3e-4d80-a950-2538c67ca06c' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:96d34801-6d3e-4d80-a950-2538c67ca06c', 5, NULL, 'Juhlasoitto', 'Järvenpään kirkon kellosävelmät: No. 5. Juhlasoitto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 25602 AND p.composer_id = 418
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:96d34801-6d3e-4d80-a950-2538c67ca06c'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 6, part.movement_number = NULL,
    part.name_ko = 'Sanomakellot', part.name_en = 'Järvenpään kirkon kellosävelmät: No. 6. Sanomakellot',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 25602 AND p.composer_id = 418 AND part.part_key = 'musicbrainz:2a0964bf-a83b-4e5f-9770-d82487758c72' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:2a0964bf-a83b-4e5f-9770-d82487758c72', 6, NULL, 'Sanomakellot', 'Järvenpään kirkon kellosävelmät: No. 6. Sanomakellot', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 25602 AND p.composer_id = 418
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:2a0964bf-a83b-4e5f-9770-d82487758c72'
);


-- None Laudatio Domini

UPDATE pieces piece
SET piece.title = 'Laudatio Domini', piece.title_en = 'Laudatio Domini',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 23960 AND piece.composer_id = 418
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'Laudate Dominum', part.name_en = 'Laudatio Domini: I. Laudate Dominum',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 23960 AND p.composer_id = 418 AND part.part_key = 'musicbrainz:1d516326-2867-4b10-9ef3-86e689b8d524' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:1d516326-2867-4b10-9ef3-86e689b8d524', 1, 'I', 'Laudate Dominum', 'Laudatio Domini: I. Laudate Dominum', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 23960 AND p.composer_id = 418
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:1d516326-2867-4b10-9ef3-86e689b8d524'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'Vox Domini', part.name_en = 'Laudatio Domini: II. Vox Domini',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 23960 AND p.composer_id = 418 AND part.part_key = 'musicbrainz:70b9b70e-ccbd-4723-882d-9b9b07f2e3b1' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:70b9b70e-ccbd-4723-882d-9b9b07f2e3b1', 2, 'II', 'Vox Domini', 'Laudatio Domini: II. Vox Domini', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 23960 AND p.composer_id = 418
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:70b9b70e-ccbd-4723-882d-9b9b07f2e3b1'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = 'Qui emittis fontes', part.name_en = 'Laudatio Domini: III. Qui emittis fontes',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 23960 AND p.composer_id = 418 AND part.part_key = 'musicbrainz:7ee8d2cc-2f91-4741-bb13-b4625b3e20cd' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:7ee8d2cc-2f91-4741-bb13-b4625b3e20cd', 3, 'III', 'Qui emittis fontes', 'Laudatio Domini: III. Qui emittis fontes', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 23960 AND p.composer_id = 418
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:7ee8d2cc-2f91-4741-bb13-b4625b3e20cd'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = 'IV',
    part.name_ko = 'Reverti Jubes', part.name_en = 'Laudatio Domini: IV. Reverti Jubes',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 23960 AND p.composer_id = 418 AND part.part_key = 'musicbrainz:074436f7-241e-426e-95fa-4f3d41c09cc3' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:074436f7-241e-426e-95fa-4f3d41c09cc3', 4, 'IV', 'Reverti Jubes', 'Laudatio Domini: IV. Reverti Jubes', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 23960 AND p.composer_id = 418
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:074436f7-241e-426e-95fa-4f3d41c09cc3'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 5, part.movement_number = 'V',
    part.name_ko = 'Alleluia', part.name_en = 'Laudatio Domini: V. Alleluia',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 23960 AND p.composer_id = 418 AND part.part_key = 'musicbrainz:c240a2d7-7da0-4bc9-8367-b1e8ec856e5c' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:c240a2d7-7da0-4bc9-8367-b1e8ec856e5c', 5, 'V', 'Alleluia', 'Laudatio Domini: V. Alleluia', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 23960 AND p.composer_id = 418
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:c240a2d7-7da0-4bc9-8367-b1e8ec856e5c'
);


-- None Lux aeterna

UPDATE pieces piece
SET piece.title = 'Lux aeterna', piece.title_en = 'Lux aeterna',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 25997 AND piece.composer_id = 418
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Musiikkia jousiorkesterille

UPDATE pieces piece
SET piece.title = 'Musiikkia jousiorkesterille', piece.title_en = 'Musiikkia jousiorkesterille',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 23062 AND piece.composer_id = 418
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'Moderato – Più lento – Tempo I', part.name_en = 'Musiikkia jousiorkesterille: I. Moderato – Più lento – Tempo I',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 23062 AND p.composer_id = 418 AND part.part_key = 'musicbrainz:6290e750-111f-4027-90c3-cee7d8686735' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:6290e750-111f-4027-90c3-cee7d8686735', 1, 'I', 'Moderato – Più lento – Tempo I', 'Musiikkia jousiorkesterille: I. Moderato – Più lento – Tempo I', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 23062 AND p.composer_id = 418
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:6290e750-111f-4027-90c3-cee7d8686735'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'Allegro molto – Poco più lento – Tempo I', part.name_en = 'Musiikkia jousiorkesterille: II. Allegro molto – Poco più lento – Tempo I',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 23062 AND p.composer_id = 418 AND part.part_key = 'musicbrainz:4934989b-1e3d-458b-89a8-3271632eb326' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:4934989b-1e3d-458b-89a8-3271632eb326', 2, 'II', 'Allegro molto – Poco più lento – Tempo I', 'Musiikkia jousiorkesterille: II. Allegro molto – Poco più lento – Tempo I', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 23062 AND p.composer_id = 418
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:4934989b-1e3d-458b-89a8-3271632eb326'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = 'Adagio religioso', part.name_en = 'Musiikkia jousiorkesterille: III. Adagio religioso',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 23062 AND p.composer_id = 418 AND part.part_key = 'musicbrainz:f66abb9b-de6d-48cb-8dee-66f6ab4e2cac' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:f66abb9b-de6d-48cb-8dee-66f6ab4e2cac', 3, 'III', 'Adagio religioso', 'Musiikkia jousiorkesterille: III. Adagio religioso', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 23062 AND p.composer_id = 418
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:f66abb9b-de6d-48cb-8dee-66f6ab4e2cac'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = 'IV',
    part.name_ko = 'Allegro', part.name_en = 'Musiikkia jousiorkesterille: IV. Allegro',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 23062 AND p.composer_id = 418 AND part.part_key = 'musicbrainz:77fe61c8-8861-41fd-8b28-314f72829a37' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:77fe61c8-8861-41fd-8b28-314f72829a37', 4, 'IV', 'Allegro', 'Musiikkia jousiorkesterille: IV. Allegro', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 23062 AND p.composer_id = 418
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:77fe61c8-8861-41fd-8b28-314f72829a37'
);


-- None Opus sonorum

UPDATE pieces piece
SET piece.title = 'Opus sonorum', piece.title_en = 'Opus sonorum',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 23868 AND piece.composer_id = 418
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'Moderato', part.name_en = 'Opus sonorum: I. Moderato',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 23868 AND p.composer_id = 418 AND part.part_key = 'musicbrainz:bbfd9bd3-2b1d-32b8-9ddf-28fda5a2b0ed' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:bbfd9bd3-2b1d-32b8-9ddf-28fda5a2b0ed', 1, 'I', 'Moderato', 'Opus sonorum: I. Moderato', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 23868 AND p.composer_id = 418
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:bbfd9bd3-2b1d-32b8-9ddf-28fda5a2b0ed'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'Adagio non troppo', part.name_en = 'Opus sonorum: II. Adagio non troppo',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 23868 AND p.composer_id = 418 AND part.part_key = 'musicbrainz:9d3098a2-dba7-3b0f-8c39-95754fa50f8b' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:9d3098a2-dba7-3b0f-8c39-95754fa50f8b', 2, 'II', 'Adagio non troppo', 'Opus sonorum: II. Adagio non troppo', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 23868 AND p.composer_id = 418
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:9d3098a2-dba7-3b0f-8c39-95754fa50f8b'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = 'Allegro non troppo', part.name_en = 'Opus sonorum: III. Allegro non troppo',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 23868 AND p.composer_id = 418 AND part.part_key = 'musicbrainz:7489410a-52c2-3728-b1d8-ff89def03b84' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:7489410a-52c2-3728-b1d8-ff89def03b84', 3, 'III', 'Allegro non troppo', 'Opus sonorum: III. Allegro non troppo', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 23868 AND p.composer_id = 418
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:7489410a-52c2-3728-b1d8-ff89def03b84'
);


-- None 피아노 5중주

UPDATE pieces piece
SET piece.title = '피아노 5중주', piece.title_en = 'Piano Quintet',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 24199 AND piece.composer_id = 418
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'Moderato', part.name_en = 'Piano Quintet: 1. Moderato',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 24199 AND p.composer_id = 418 AND part.part_key = 'musicbrainz:7e8d37bb-9c52-4c67-a958-e2da5806307c' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:7e8d37bb-9c52-4c67-a958-e2da5806307c', 1, NULL, 'Moderato', 'Piano Quintet: 1. Moderato', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 24199 AND p.composer_id = 418
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:7e8d37bb-9c52-4c67-a958-e2da5806307c'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'Allegro', part.name_en = 'Piano Quintet: 2. Allegro',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 24199 AND p.composer_id = 418 AND part.part_key = 'musicbrainz:619fe315-c0fc-4255-bbbb-f3cc2fe23265' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:619fe315-c0fc-4255-bbbb-f3cc2fe23265', 2, NULL, 'Allegro', 'Piano Quintet: 2. Allegro', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 24199 AND p.composer_id = 418
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:619fe315-c0fc-4255-bbbb-f3cc2fe23265'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = NULL,
    part.name_ko = 'Adagio non troppo', part.name_en = 'Piano Quintet: 3. Adagio non troppo',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 24199 AND p.composer_id = 418 AND part.part_key = 'musicbrainz:84a6ec79-dc5a-43ea-a3d6-a29cf8d12f74' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:84a6ec79-dc5a-43ea-a3d6-a29cf8d12f74', 3, NULL, 'Adagio non troppo', 'Piano Quintet: 3. Adagio non troppo', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 24199 AND p.composer_id = 418
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:84a6ec79-dc5a-43ea-a3d6-a29cf8d12f74'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = NULL,
    part.name_ko = 'Allegro moderato', part.name_en = 'Piano Quintet: 4. Allegro moderato',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 24199 AND p.composer_id = 418 AND part.part_key = 'musicbrainz:1fbeacf2-f1ae-4380-827e-4411e3a10c8e' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:1fbeacf2-f1ae-4380-827e-4411e3a10c8e', 4, NULL, 'Allegro moderato', 'Piano Quintet: 4. Allegro moderato', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 24199 AND p.composer_id = 418
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:1fbeacf2-f1ae-4380-827e-4411e3a10c8e'
);


-- None Pielavesi

UPDATE pieces piece
SET piece.title = 'Pielavesi', piece.title_en = 'Pielavesi',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 24578 AND piece.composer_id = 418
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'Preludietto (Molto moderato)', part.name_en = 'Pielavesi: I. Preludietto (Molto moderato)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 24578 AND p.composer_id = 418 AND part.part_key = 'musicbrainz:83b9a2ae-0ffd-4add-ac9b-831c46ef0315' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:83b9a2ae-0ffd-4add-ac9b-831c46ef0315', 1, 'I', 'Preludietto (Molto moderato)', 'Pielavesi: I. Preludietto (Molto moderato)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 24578 AND p.composer_id = 418
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:83b9a2ae-0ffd-4add-ac9b-831c46ef0315'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'Nocturne (Un poco sostenuto e dolcissimo)', part.name_en = 'Pielavesi: II. Nocturne (Un poco sostenuto e dolcissimo)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 24578 AND p.composer_id = 418 AND part.part_key = 'musicbrainz:85ed6a3a-adf3-4c87-864b-4a17fca4af08' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:85ed6a3a-adf3-4c87-864b-4a17fca4af08', 2, 'II', 'Nocturne (Un poco sostenuto e dolcissimo)', 'Pielavesi: II. Nocturne (Un poco sostenuto e dolcissimo)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 24578 AND p.composer_id = 418
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:85ed6a3a-adf3-4c87-864b-4a17fca4af08'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = 'Sade (Veloce e espressivo)', part.name_en = 'Pielavesi: III. Sade (Veloce e espressivo)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 24578 AND p.composer_id = 418 AND part.part_key = 'musicbrainz:515ab69e-2b31-4c98-bc88-f991456804f0' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:515ab69e-2b31-4c98-bc88-f991456804f0', 3, 'III', 'Sade (Veloce e espressivo)', 'Pielavesi: III. Sade (Veloce e espressivo)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 24578 AND p.composer_id = 418
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:515ab69e-2b31-4c98-bc88-f991456804f0'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = 'IV',
    part.name_ko = 'Iltapilviä (Andantino semplice)', part.name_en = 'Pielavesi: IV. Iltapilviä (Andantino semplice)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 24578 AND p.composer_id = 418 AND part.part_key = 'musicbrainz:8fa045b6-0e24-4aad-bf2e-d29ecf603bd2' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:8fa045b6-0e24-4aad-bf2e-d29ecf603bd2', 4, 'IV', 'Iltapilviä (Andantino semplice)', 'Pielavesi: IV. Iltapilviä (Andantino semplice)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 24578 AND p.composer_id = 418
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:8fa045b6-0e24-4aad-bf2e-d29ecf603bd2'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 5, part.movement_number = 'V',
    part.name_ko = 'Aamutuuli (Vivacissimo)', part.name_en = 'Pielavesi: V. Aamutuuli (Vivacissimo)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 24578 AND p.composer_id = 418 AND part.part_key = 'musicbrainz:64966608-31cc-4eca-bc05-e60d4a11348c' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:64966608-31cc-4eca-bc05-e60d4a11348c', 5, 'V', 'Aamutuuli (Vivacissimo)', 'Pielavesi: V. Aamutuuli (Vivacissimo)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 24578 AND p.composer_id = 418
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:64966608-31cc-4eca-bc05-e60d4a11348c'
);


-- None Sinfonia da camera

UPDATE pieces piece
SET piece.title = 'Sinfonia da camera', piece.title_en = 'Sinfonia da camera',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 23451 AND piece.composer_id = 418
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'Moderato', part.name_en = 'Sinfonia da camera: I. Moderato',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 23451 AND p.composer_id = 418 AND part.part_key = 'musicbrainz:71f75a2d-1b7a-3b74-b834-afed05c8abed' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:71f75a2d-1b7a-3b74-b834-afed05c8abed', 1, 'I', 'Moderato', 'Sinfonia da camera: I. Moderato', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 23451 AND p.composer_id = 418
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:71f75a2d-1b7a-3b74-b834-afed05c8abed'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'Allegro non troppo', part.name_en = 'Sinfonia da camera: II. Allegro non troppo',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 23451 AND p.composer_id = 418 AND part.part_key = 'musicbrainz:fcf7ca9e-0195-3928-a189-c8bad62eaeda' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:fcf7ca9e-0195-3928-a189-c8bad62eaeda', 2, 'II', 'Allegro non troppo', 'Sinfonia da camera: II. Allegro non troppo', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 23451 AND p.composer_id = 418
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:fcf7ca9e-0195-3928-a189-c8bad62eaeda'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = 'Molto vivace', part.name_en = 'Sinfonia da camera: III. Molto vivace',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 23451 AND p.composer_id = 418 AND part.part_key = 'musicbrainz:5603190f-216b-3a8a-8208-0616eec07499' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:5603190f-216b-3a8a-8208-0616eec07499', 3, 'III', 'Molto vivace', 'Sinfonia da camera: III. Molto vivace', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 23451 AND p.composer_id = 418
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:5603190f-216b-3a8a-8208-0616eec07499'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = 'IV',
    part.name_ko = 'Andante', part.name_en = 'Sinfonia da camera: IV. Andante',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 23451 AND p.composer_id = 418 AND part.part_key = 'musicbrainz:6ee9ae00-873c-3cf1-a665-287660ca322b' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:6ee9ae00-873c-3cf1-a665-287660ca322b', 4, 'IV', 'Andante', 'Sinfonia da camera: IV. Andante', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 23451 AND p.composer_id = 418
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:6ee9ae00-873c-3cf1-a665-287660ca322b'
);


-- None Sinfonisia luonnoksia

UPDATE pieces piece
SET piece.title = 'Sinfonisia luonnoksia', piece.title_en = 'Sinfonisia luonnoksia',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 23898 AND piece.composer_id = 418
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'Lamento. Andante', part.name_en = 'Sinfonisia luonnoksia: I. Lamento. Andante',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 23898 AND p.composer_id = 418 AND part.part_key = 'musicbrainz:e61833df-e324-497e-88e5-2d1df6aaf603' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:e61833df-e324-497e-88e5-2d1df6aaf603', 1, 'I', 'Lamento. Andante', 'Sinfonisia luonnoksia: I. Lamento. Andante', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 23898 AND p.composer_id = 418
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:e61833df-e324-497e-88e5-2d1df6aaf603'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'Pezzo giacoso. Allegro', part.name_en = 'Sinfonisia luonnoksia: II. Pezzo giacoso. Allegro',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 23898 AND p.composer_id = 418 AND part.part_key = 'musicbrainz:a02bd9d4-30bf-457d-9cc3-69ae165415db' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:a02bd9d4-30bf-457d-9cc3-69ae165415db', 2, 'II', 'Pezzo giacoso. Allegro', 'Sinfonisia luonnoksia: II. Pezzo giacoso. Allegro', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 23898 AND p.composer_id = 418
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:a02bd9d4-30bf-457d-9cc3-69ae165415db'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = 'Religioso. Andante', part.name_en = 'Sinfonisia luonnoksia: III. Religioso. Andante',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 23898 AND p.composer_id = 418 AND part.part_key = 'musicbrainz:2d73ebc6-6a2a-4ab8-a520-51317c7cd467' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:2d73ebc6-6a2a-4ab8-a520-51317c7cd467', 3, 'III', 'Religioso. Andante', 'Sinfonisia luonnoksia: III. Religioso. Andante', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 23898 AND p.composer_id = 418
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:2d73ebc6-6a2a-4ab8-a520-51317c7cd467'
);


-- None Sormin soitti Väinämöinen

UPDATE pieces piece
SET piece.title = 'Sormin soitti Väinämöinen', piece.title_en = 'Sormin soitti Väinämöinen',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 24558 AND piece.composer_id = 418
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None 현악 4중주 1번 "Quartetto"

UPDATE pieces piece
SET piece.title = '현악 4중주 1번 "Quartetto"', piece.title_en = 'String Quartet no. 1 "Quartetto"',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 23357 AND piece.composer_id = 418
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'Allegro', part.name_en = 'String Quartet no. 1 "Quartetto": I. Allegro',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 23357 AND p.composer_id = 418 AND part.part_key = 'musicbrainz:407f2cd7-2679-4c3e-8bce-c84caac7d33e' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:407f2cd7-2679-4c3e-8bce-c84caac7d33e', 1, 'I', 'Allegro', 'String Quartet no. 1 "Quartetto": I. Allegro', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 23357 AND p.composer_id = 418
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:407f2cd7-2679-4c3e-8bce-c84caac7d33e'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'Andante molto tranquillo', part.name_en = 'String Quartet no. 1 "Quartetto": II. Andante molto tranquillo',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 23357 AND p.composer_id = 418 AND part.part_key = 'musicbrainz:12cb2881-e59e-410c-9941-f785c2470ef5' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:12cb2881-e59e-410c-9941-f785c2470ef5', 2, 'II', 'Andante molto tranquillo', 'String Quartet no. 1 "Quartetto": II. Andante molto tranquillo', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 23357 AND p.composer_id = 418
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:12cb2881-e59e-410c-9941-f785c2470ef5'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = 'Allegro non troppo', part.name_en = 'String Quartet no. 1 "Quartetto": III. Allegro non troppo',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 23357 AND p.composer_id = 418 AND part.part_key = 'musicbrainz:84bdb3c2-780d-4f38-8cb7-fe00a8255498' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:84bdb3c2-780d-4f38-8cb7-fe00a8255498', 3, 'III', 'Allegro non troppo', 'String Quartet no. 1 "Quartetto": III. Allegro non troppo', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 23357 AND p.composer_id = 418
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:84bdb3c2-780d-4f38-8cb7-fe00a8255498'
);


-- None Surusoitto

UPDATE pieces piece
SET piece.title = 'Surusoitto', piece.title_en = 'Surusoitto',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 25022 AND piece.composer_id = 418
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None 교향곡 2번

UPDATE pieces piece
SET piece.title = '교향곡 2번', piece.title_en = 'Symphony no. 2',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 24626 AND piece.composer_id = 418
  AND piece.origin = 'seed' AND piece.editor_locked = 0;
INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '95ba668d-e786-4992-a5a2-58f877564409'
FROM pieces p
WHERE p.id = 24626 AND p.composer_id = 418
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '95ba668d-e786-4992-a5a2-58f877564409'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'Adagio non troppo', part.name_en = 'Symphony no. 2: I. Adagio non troppo',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 24626 AND p.composer_id = 418 AND part.part_key = 'musicbrainz:aaea27cd-f2e0-3da3-96a9-dc7883a4fa4f' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:aaea27cd-f2e0-3da3-96a9-dc7883a4fa4f', 1, 'I', 'Adagio non troppo', 'Symphony no. 2: I. Adagio non troppo', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 24626 AND p.composer_id = 418
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:aaea27cd-f2e0-3da3-96a9-dc7883a4fa4f'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'Allegro', part.name_en = 'Symphony no. 2: II. Allegro',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 24626 AND p.composer_id = 418 AND part.part_key = 'musicbrainz:b6ddf3f0-7af6-357b-949f-6ead98cb703e' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:b6ddf3f0-7af6-357b-949f-6ead98cb703e', 2, 'II', 'Allegro', 'Symphony no. 2: II. Allegro', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 24626 AND p.composer_id = 418
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:b6ddf3f0-7af6-357b-949f-6ead98cb703e'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = 'Andante', part.name_en = 'Symphony no. 2: III. Andante',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 24626 AND p.composer_id = 418 AND part.part_key = 'musicbrainz:5a340c7d-3875-3da1-a9bf-abc7a8ab49a3' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:5a340c7d-3875-3da1-a9bf-abc7a8ab49a3', 3, 'III', 'Andante', 'Symphony no. 2: III. Andante', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 24626 AND p.composer_id = 418
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:5a340c7d-3875-3da1-a9bf-abc7a8ab49a3'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = 'IV',
    part.name_ko = 'Allegro vivace', part.name_en = 'Symphony no. 2: IV. Allegro vivace',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 24626 AND p.composer_id = 418 AND part.part_key = 'musicbrainz:85918179-01ed-3966-b60b-94e4e16a2ac6' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:85918179-01ed-3966-b60b-94e4e16a2ac6', 4, 'IV', 'Allegro vivace', 'Symphony no. 2: IV. Allegro vivace', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 24626 AND p.composer_id = 418
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:85918179-01ed-3966-b60b-94e4e16a2ac6'
);


-- None 연가곡집 <The Hades of the Birds>

UPDATE pieces piece
SET piece.title = '연가곡집 <The Hades of the Birds>', piece.title_en = 'The Hades of the Birds',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 24513 AND piece.composer_id = 418
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'Täydellisyyden maassa (In the World of Perfection)', part.name_en = 'The Hades of the Birds: I. Täydellisyyden maassa (In the World of Perfection)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 24513 AND p.composer_id = 418 AND part.part_key = 'musicbrainz:183d2a08-61c1-457e-9e2d-af2dee06baf2' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:183d2a08-61c1-457e-9e2d-af2dee06baf2', 1, 'I', 'Täydellisyyden maassa (In the World of Perfection)', 'The Hades of the Birds: I. Täydellisyyden maassa (In the World of Perfection)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 24513 AND p.composer_id = 418
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:183d2a08-61c1-457e-9e2d-af2dee06baf2'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'Lintujen tuonela (The Hades of the Birds)', part.name_en = 'The Hades of the Birds: II. Lintujen tuonela (The Hades of the Birds)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 24513 AND p.composer_id = 418 AND part.part_key = 'musicbrainz:9965db24-dcb3-4c3b-8ac7-032372f184b6' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:9965db24-dcb3-4c3b-8ac7-032372f184b6', 2, 'II', 'Lintujen tuonela (The Hades of the Birds)', 'The Hades of the Birds: II. Lintujen tuonela (The Hades of the Birds)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 24513 AND p.composer_id = 418
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:9965db24-dcb3-4c3b-8ac7-032372f184b6'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = 'Sade (The Rain)', part.name_en = 'The Hades of the Birds: III. Sade (The Rain)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 24513 AND p.composer_id = 418 AND part.part_key = 'musicbrainz:1ea78c98-3501-4a58-bb4c-315bfa412916' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:1ea78c98-3501-4a58-bb4c-315bfa412916', 3, 'III', 'Sade (The Rain)', 'The Hades of the Birds: III. Sade (The Rain)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 24513 AND p.composer_id = 418
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:1ea78c98-3501-4a58-bb4c-315bfa412916'
);


-- None Trio for Violin, Cello and Piano

UPDATE pieces piece
SET piece.title = 'Trio for Violin, Cello and Piano', piece.title_en = 'Trio for Violin, Cello and Piano',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 24029 AND piece.composer_id = 418
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'Un poco adagio - Allegro moderato ma energico', part.name_en = 'Trio for Violin, Cello and Piano: I. Un poco adagio - Allegro moderato ma energico',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 24029 AND p.composer_id = 418 AND part.part_key = 'musicbrainz:71ae183d-44b4-47b4-ad14-608cb2149df2' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:71ae183d-44b4-47b4-ad14-608cb2149df2', 1, 'I', 'Un poco adagio - Allegro moderato ma energico', 'Trio for Violin, Cello and Piano: I. Un poco adagio - Allegro moderato ma energico', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 24029 AND p.composer_id = 418
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:71ae183d-44b4-47b4-ad14-608cb2149df2'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'Andante tranquillo e semplice', part.name_en = 'Trio for Violin, Cello and Piano: II. Andante tranquillo e semplice',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 24029 AND p.composer_id = 418 AND part.part_key = 'musicbrainz:1250805f-616c-4f33-8067-05f61aa2e656' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:1250805f-616c-4f33-8067-05f61aa2e656', 2, 'II', 'Andante tranquillo e semplice', 'Trio for Violin, Cello and Piano: II. Andante tranquillo e semplice', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 24029 AND p.composer_id = 418
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:1250805f-616c-4f33-8067-05f61aa2e656'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = 'Allegro molto e giocoso', part.name_en = 'Trio for Violin, Cello and Piano: III. Allegro molto e giocoso',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 24029 AND p.composer_id = 418 AND part.part_key = 'musicbrainz:4042bda3-bc2e-4ef4-93c7-8e98d4f7f660' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:4042bda3-bc2e-4ef4-93c7-8e98d4f7f660', 3, 'III', 'Allegro molto e giocoso', 'Trio for Violin, Cello and Piano: III. Allegro molto e giocoso', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 24029 AND p.composer_id = 418
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:4042bda3-bc2e-4ef4-93c7-8e98d4f7f660'
);


-- None 첼로 협주곡

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '첼로 협주곡', 'Cello Concerto', 'album', NULL, NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 418
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '첼로 협주곡'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '02dd648f-15aa-4bfe-b31b-602eb7d36522'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '02dd648f-15aa-4bfe-b31b-602eb7d36522'
FROM pieces p
WHERE p.composer_id = 418 AND p.title = '첼로 협주곡' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '02dd648f-15aa-4bfe-b31b-602eb7d36522'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:7010bfff-71ce-3654-a206-d7371c6b968b', 1, 'I', 'Moderato mosso - Allegro', 'Cello Concerto: I. Moderato mosso - Allegro', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 418 AND p.title = '첼로 협주곡' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:7010bfff-71ce-3654-a206-d7371c6b968b'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:34a5cb20-6a7e-3361-a0ff-5222ae83845a', 2, 'II', 'Allegretto', 'Cello Concerto: II. Allegretto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 418 AND p.title = '첼로 협주곡' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:34a5cb20-6a7e-3361-a0ff-5222ae83845a'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:792aa1ae-1c5c-3653-a969-a7d70bb47cca', 3, 'III', 'Adagio', 'Cello Concerto: III. Adagio', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 418 AND p.title = '첼로 협주곡' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:792aa1ae-1c5c-3653-a969-a7d70bb47cca'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:d8d134f2-09bc-37fe-95ff-6784f8f36f42', 4, 'IV', 'Cadenza (Adagio)', 'Cello Concerto: IV. Cadenza (Adagio)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 418 AND p.title = '첼로 협주곡' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:d8d134f2-09bc-37fe-95ff-6784f8f36f42'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:953cca43-9077-3988-b97a-cd00b68807b5', 5, 'V', 'Allegro vivace', 'Cello Concerto: V. Allegro vivace', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 418 AND p.title = '첼로 협주곡' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:953cca43-9077-3988-b97a-cd00b68807b5'
);


-- None Hääsoitto

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, 'Hääsoitto', 'Hääsoitto', 'song', NULL, NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 418
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = 'Hääsoitto'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '4b3a8968-d27a-4149-a03f-8dbbe453a219'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '4b3a8968-d27a-4149-a03f-8dbbe453a219'
FROM pieces p
WHERE p.composer_id = 418 AND p.title = 'Hääsoitto' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '4b3a8968-d27a-4149-a03f-8dbbe453a219'
);


-- None Requiem in memoriam Maija Kokkonen

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, 'Requiem in memoriam Maija Kokkonen', 'Requiem in memoriam Maija Kokkonen', 'album', NULL, NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 418
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = 'Requiem in memoriam Maija Kokkonen'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'fd343064-d454-4a88-89a5-0a0bf0561de2'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'fd343064-d454-4a88-89a5-0a0bf0561de2'
FROM pieces p
WHERE p.composer_id = 418 AND p.title = 'Requiem in memoriam Maija Kokkonen' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'fd343064-d454-4a88-89a5-0a0bf0561de2'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:82999010-6a26-3749-aebd-96c4b849fe6f', 1, 'I', 'Requiem æternam. Andante', 'Requiem: I. Requiem æternam. Andante', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 418 AND p.title = 'Requiem in memoriam Maija Kokkonen' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:82999010-6a26-3749-aebd-96c4b849fe6f'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:df0e544f-a1af-37ba-8c90-124d1294f415', 2, 'II', 'Kyrie eleison. Allegro', 'Requiem: II. Kyrie eleison. Allegro', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 418 AND p.title = 'Requiem in memoriam Maija Kokkonen' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:df0e544f-a1af-37ba-8c90-124d1294f415'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:8a372824-7c37-359f-99b1-e3c89dc8b43f', 3, 'III', 'Tractus. Andante', 'Requiem: III. Tractus. Andante', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 418 AND p.title = 'Requiem in memoriam Maija Kokkonen' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:8a372824-7c37-359f-99b1-e3c89dc8b43f'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:9df3040d-7f71-33f3-8223-31032c713aef', 4, 'IV', 'Domine Jesu Christe. Moderato', 'Requiem: IV. Domine Jesu Christe. Moderato', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 418 AND p.title = 'Requiem in memoriam Maija Kokkonen' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:9df3040d-7f71-33f3-8223-31032c713aef'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:3b13bcab-65c4-3911-918f-db9f6c4200b2', 5, 'V', 'Hostias et preces. Allegretto', 'Requiem: V. Hostias et preces. Allegretto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 418 AND p.title = 'Requiem in memoriam Maija Kokkonen' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:3b13bcab-65c4-3911-918f-db9f6c4200b2'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:86ba10ba-982f-3092-907e-3d04b2b51671', 6, 'VI', 'Sanctus & Benedictus. Allegro moderato', 'Requiem: VI. Sanctus & Benedictus. Allegro moderato', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 418 AND p.title = 'Requiem in memoriam Maija Kokkonen' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:86ba10ba-982f-3092-907e-3d04b2b51671'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:cdbc4fc9-05c6-3d8b-9750-5050d55c936f', 7, 'VII', 'Agnus Dei. Moderato', 'Requiem: VII. Agnus Dei. Moderato', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 418 AND p.title = 'Requiem in memoriam Maija Kokkonen' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:cdbc4fc9-05c6-3d8b-9750-5050d55c936f'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:340065e1-4772-3c2e-967e-1137bfc10002', 8, 'VIII', 'In Paradisum. Andante', 'Requiem: VIII. In Paradisum. Andante', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 418 AND p.title = 'Requiem in memoriam Maija Kokkonen' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:340065e1-4772-3c2e-967e-1137bfc10002'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:bc189c00-c4ac-399a-8a19-a0dba87a026e', 9, 'IX', 'Lux æterna. Adagio', 'Requiem: IX. Lux æterna. Adagio', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 418 AND p.title = 'Requiem in memoriam Maija Kokkonen' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:bc189c00-c4ac-399a-8a19-a0dba87a026e'
);


-- None 현악 4중주 3번

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '현악 4중주 3번', 'String Quartet no. 3', 'album', NULL, NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 418
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '현악 4중주 3번'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '56c71741-448c-4740-9822-a93f09fdc259'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '56c71741-448c-4740-9822-a93f09fdc259'
FROM pieces p
WHERE p.composer_id = 418 AND p.title = '현악 4중주 3번' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '56c71741-448c-4740-9822-a93f09fdc259'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:48aa54e5-df63-4eb5-a364-f48ab952391a', 1, 'I', 'Allegretto', 'String Quartet no. 3: I. Allegretto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 418 AND p.title = '현악 4중주 3번' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:48aa54e5-df63-4eb5-a364-f48ab952391a'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:a46f5847-cff6-4d88-97b8-9a6644daff22', 2, 'II', 'Allegro', 'String Quartet no. 3: II. Allegro', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 418 AND p.title = '현악 4중주 3번' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:a46f5847-cff6-4d88-97b8-9a6644daff22'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:18692de1-e7e7-42c5-ae58-ccd7807b1422', 3, 'III', 'Adagio', 'String Quartet no. 3: III. Adagio', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 418 AND p.title = '현악 4중주 3번' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:18692de1-e7e7-42c5-ae58-ccd7807b1422'
);


-- None 교향곡 1번

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '교향곡 1번', 'Symphony no. 1', 'album', NULL, NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 418
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '교향곡 1번'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'cb642808-69e5-4534-af29-932fb66ac01b'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'cb642808-69e5-4534-af29-932fb66ac01b'
FROM pieces p
WHERE p.composer_id = 418 AND p.title = '교향곡 1번' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'cb642808-69e5-4534-af29-932fb66ac01b'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:bc205e18-14ec-30d9-b6b6-621c1fd293ac', 1, 'I', 'Moderato', 'Symphony no. 1: I. Moderato', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 418 AND p.title = '교향곡 1번' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:bc205e18-14ec-30d9-b6b6-621c1fd293ac'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:4dbb723c-ed2e-3c53-ad57-1fff6103d997', 2, 'II', 'Allegretto', 'Symphony no. 1: II. Allegretto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 418 AND p.title = '교향곡 1번' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:4dbb723c-ed2e-3c53-ad57-1fff6103d997'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:e6519670-db92-3d4e-97ff-2f09d5a1f412', 3, 'III', 'Allegro', 'Symphony no. 1: III. Allegro', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 418 AND p.title = '교향곡 1번' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:e6519670-db92-3d4e-97ff-2f09d5a1f412'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:e48a2fe5-9b20-328f-a3de-420486c4a579', 4, 'IV', 'Adagio', 'Symphony no. 1: IV. Adagio', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 418 AND p.title = '교향곡 1번' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:e48a2fe5-9b20-328f-a3de-420486c4a579'
);


-- None 교향곡 3번

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '교향곡 3번', 'Symphony no. 3', 'album', NULL, NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 418
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '교향곡 3번'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '88bcbb99-2e2e-4f18-ac92-ccc5b1b6c3b6'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '88bcbb99-2e2e-4f18-ac92-ccc5b1b6c3b6'
FROM pieces p
WHERE p.composer_id = 418 AND p.title = '교향곡 3번' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '88bcbb99-2e2e-4f18-ac92-ccc5b1b6c3b6'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:7a9718e1-b117-30ab-a270-a722d8c3aef5', 1, 'I', 'Andante sostenuto', 'Symphony no. 3: I. Andante sostenuto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 418 AND p.title = '교향곡 3번' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:7a9718e1-b117-30ab-a270-a722d8c3aef5'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:97d683ca-392f-3426-921c-b154e0f7f03f', 2, 'II', 'Allegro', 'Symphony no. 3: II. Allegro', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 418 AND p.title = '교향곡 3번' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:97d683ca-392f-3426-921c-b154e0f7f03f'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:4a2d07d2-4147-3ddc-9613-ad1f540c8e03', 3, 'III', 'Allegretto moderato', 'Symphony no. 3: III. Allegretto moderato', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 418 AND p.title = '교향곡 3번' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:4a2d07d2-4147-3ddc-9613-ad1f540c8e03'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:d6ee2724-008c-380e-a296-5cf4e2d9fe80', 4, 'IV', 'Adagio', 'Symphony no. 3: IV. Adagio', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 418 AND p.title = '교향곡 3번' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:d6ee2724-008c-380e-a296-5cf4e2d9fe80'
);


-- None 교향곡 4번

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '교향곡 4번', 'Symphony no. 4', 'album', NULL, NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 418
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '교향곡 4번'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'c63beb22-0411-4af8-beeb-69e26f8509a7'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'c63beb22-0411-4af8-beeb-69e26f8509a7'
FROM pieces p
WHERE p.composer_id = 418 AND p.title = '교향곡 4번' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'c63beb22-0411-4af8-beeb-69e26f8509a7'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:b168f5a0-9df8-336d-a6c0-fc0ec405cfb4', 1, 'I', 'Moderato', 'Symphony no. 4: I. Moderato', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 418 AND p.title = '교향곡 4번' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:b168f5a0-9df8-336d-a6c0-fc0ec405cfb4'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:86b510ff-fb2b-37a4-b32b-38073423afd1', 2, 'II', 'Allegro', 'Symphony no. 4: II. Allegro', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 418 AND p.title = '교향곡 4번' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:86b510ff-fb2b-37a4-b32b-38073423afd1'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:1f6bea15-208b-34f9-b419-ed06fc54999f', 3, 'III', 'Adagio', 'Symphony no. 4: III. Adagio', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 418 AND p.title = '교향곡 4번' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:1f6bea15-208b-34f9-b419-ed06fc54999f'
);


-- None 오페라 <Viimeiset kiusaukset>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '오페라 <Viimeiset kiusaukset>', 'Viimeiset kiusaukset', 'album', NULL, NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 418
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '오페라 <Viimeiset kiusaukset>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '750cea98-21e4-407b-8d0a-78ff7b13e159'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '750cea98-21e4-407b-8d0a-78ff7b13e159'
FROM pieces p
WHERE p.composer_id = 418 AND p.title = '오페라 <Viimeiset kiusaukset>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '750cea98-21e4-407b-8d0a-78ff7b13e159'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:789e3488-b3c9-40ca-b948-4c36c873effc', 1, NULL, 'Minun on vielä ennen kuolemaani', 'Viimeiset kiusaukset: Minun on vielä ennen kuolemaani', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 418 AND p.title = '오페라 <Viimeiset kiusaukset>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:789e3488-b3c9-40ca-b948-4c36c873effc'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:fa8c8a84-bbda-466c-b9f3-5401a6779411', 2, NULL, 'En saa ovea auki', 'Viimeiset kiusaukset: En saa ovea auki', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 418 AND p.title = '오페라 <Viimeiset kiusaukset>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:fa8c8a84-bbda-466c-b9f3-5401a6779411'
);


-- None 목관 5중주

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '목관 5중주', 'Wind Quintet', 'album', NULL, NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 418
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '목관 5중주'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '75efa5c9-2212-48e0-b7bf-1f09d29732f3'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '75efa5c9-2212-48e0-b7bf-1f09d29732f3'
FROM pieces p
WHERE p.composer_id = 418 AND p.title = '목관 5중주' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '75efa5c9-2212-48e0-b7bf-1f09d29732f3'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:cd5df3da-6426-418d-9bb1-d28996547d9b', 1, 'I', 'Andante', 'Wind Quintet: I. Andante', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 418 AND p.title = '목관 5중주' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:cd5df3da-6426-418d-9bb1-d28996547d9b'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:66674df8-f7de-46fb-81b8-fb2c2b719327', 2, 'II', 'Allegro vivace', 'Wind Quintet: II. Allegro vivace', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 418 AND p.title = '목관 5중주' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:66674df8-f7de-46fb-81b8-fb2c2b719327'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:b0c1cd7c-81bb-4661-8c03-ac6a48fe0186', 3, 'III', 'Moderato, quasi allegretto', 'Wind Quintet: III. Moderato, quasi allegretto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 418 AND p.title = '목관 5중주' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:b0c1cd7c-81bb-4661-8c03-ac6a48fe0186'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:3950cdc0-4815-4fc9-ab9f-fa72da059d26', 4, 'IV', 'Allegro', 'Wind Quintet: IV. Allegro', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 418 AND p.title = '목관 5중주' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:3950cdc0-4815-4fc9-ab9f-fa72da059d26'
);


-- 카탈로그에 대응이 없는 seed 작품 3개를 목록에서 숨긴다(지우지 않음).
UPDATE pieces piece
SET piece.hidden_reason = 'catalog_unmatched'
WHERE piece.composer_id = 418 AND piece.origin = 'seed' AND piece.hidden_reason IS NULL
  AND piece.id IN (
    25065, 25605, 26021
  )
  AND NOT EXISTS (SELECT 1 FROM performance_sectors sector WHERE sector.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM piece_parts linking WHERE linking.linked_piece_id = piece.id);
