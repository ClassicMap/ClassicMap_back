-- 브렛 딘 작품을 MusicBrainz 작품 구조로 다시 짠다(5차 자동). 작품 40개(묶음 5, 다악장 14, 낱곡 21),
-- 새 작품 3개, part 75개, 그 아래 0개.
-- seed 41개 중 37개를 작품·part 에 잇고, 4개를 숨기고, 0개는 그대로 둔다.
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

-- None 3 Memorials

UPDATE pieces piece
SET piece.title = '3 Memorials', piece.title_en = '3 Memorials',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 16649 AND piece.composer_id = 162
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'Dispersal', part.name_en = '3 Memorials: Dispersal',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 16649 AND p.composer_id = 162 AND part.part_key = 'musicbrainz:00fa864e-d0db-407b-bdef-ce7f62460a59' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:00fa864e-d0db-407b-bdef-ce7f62460a59', 1, NULL, 'Dispersal', '3 Memorials: Dispersal', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 16649 AND p.composer_id = 162
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:00fa864e-d0db-407b-bdef-ce7f62460a59'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'Komarov''s Fall', part.name_en = 'Komarov''s Fall',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 16649 AND p.composer_id = 162 AND part.part_key = 'musicbrainz:570250af-fed3-4b19-9b9a-5ad42fbbad0f' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:570250af-fed3-4b19-9b9a-5ad42fbbad0f', 2, NULL, 'Komarov''s Fall', 'Komarov''s Fall', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 16649 AND p.composer_id = 162
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:570250af-fed3-4b19-9b9a-5ad42fbbad0f'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = NULL,
    part.name_ko = 'Ceremonial', part.name_en = '3 Memorials: Ceremonial',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 16649 AND p.composer_id = 162 AND part.part_key = 'musicbrainz:c7d2edfb-041e-458f-a883-ca9b1433d887' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:c7d2edfb-041e-458f-a883-ca9b1433d887', 3, NULL, 'Ceremonial', '3 Memorials: Ceremonial', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 16649 AND p.composer_id = 162
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:c7d2edfb-041e-458f-a883-ca9b1433d887'
);


-- None Amphitheatre

UPDATE pieces piece
SET piece.title = 'Amphitheatre', piece.title_en = 'Amphitheatre',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 18026 AND piece.composer_id = 162
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Ariel's Music

UPDATE pieces piece
SET piece.title = 'Ariel''s Music', piece.title_en = 'Ariel''s Music',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 16570 AND piece.composer_id = 162
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'Elegy', part.name_en = 'Ariel''s Music: I. Elegy',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 16570 AND p.composer_id = 162 AND part.part_key = 'musicbrainz:748dfdf4-c0a3-4fa7-883e-dafc0d555809' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:748dfdf4-c0a3-4fa7-883e-dafc0d555809', 1, 'I', 'Elegy', 'Ariel''s Music: I. Elegy', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 16570 AND p.composer_id = 162
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:748dfdf4-c0a3-4fa7-883e-dafc0d555809'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'Circumstances', part.name_en = 'Ariel''s Music: II. Circumstances',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 16570 AND p.composer_id = 162 AND part.part_key = 'musicbrainz:7a9c97a8-b958-4447-98e4-0507e61f94bf' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:7a9c97a8-b958-4447-98e4-0507e61f94bf', 2, 'II', 'Circumstances', 'Ariel''s Music: II. Circumstances', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 16570 AND p.composer_id = 162
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:7a9c97a8-b958-4447-98e4-0507e61f94bf'
);


-- None 오페라 <Bliss>

UPDATE pieces piece
SET piece.title = '오페라 <Bliss>', piece.title_en = 'Bliss',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 19509 AND piece.composer_id = 162
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Carlo

UPDATE pieces piece
SET piece.title = 'Carlo', piece.title_en = 'Carlo',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 16171 AND piece.composer_id = 162
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Confessio

UPDATE pieces piece
SET piece.title = 'Confessio', piece.title_en = 'Confessio',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 19239 AND piece.composer_id = 162
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Dramatis personae

UPDATE pieces piece
SET piece.title = 'Dramatis personae', piece.title_en = 'Dramatis personae',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 16882 AND piece.composer_id = 162
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'Fall of a Superhero', part.name_en = 'Dramatis personae: I. Fall of a Superhero',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 16882 AND p.composer_id = 162 AND part.part_key = 'musicbrainz:54d758fd-9a1d-448c-9537-42c117bb18cf' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:54d758fd-9a1d-448c-9537-42c117bb18cf', 1, 'I', 'Fall of a Superhero', 'Dramatis personae: I. Fall of a Superhero', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 16882 AND p.composer_id = 162
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:54d758fd-9a1d-448c-9537-42c117bb18cf'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'Soliloquy', part.name_en = 'Dramatis personae: II. Soliloquy',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 16882 AND p.composer_id = 162 AND part.part_key = 'musicbrainz:b61fdc01-a83a-46f4-8fa3-9008e329728d' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:b61fdc01-a83a-46f4-8fa3-9008e329728d', 2, 'II', 'Soliloquy', 'Dramatis personae: II. Soliloquy', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 16882 AND p.composer_id = 162
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:b61fdc01-a83a-46f4-8fa3-9008e329728d'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = 'The Accidental Revolutionary', part.name_en = 'Dramatis personae: III. The Accidental Revolutionary',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 16882 AND p.composer_id = 162 AND part.part_key = 'musicbrainz:7dc53090-05cf-4be2-8453-94244cb089b4' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:7dc53090-05cf-4be2-8453-94244cb089b4', 3, 'III', 'The Accidental Revolutionary', 'Dramatis personae: III. The Accidental Revolutionary', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 16882 AND p.composer_id = 162
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:7dc53090-05cf-4be2-8453-94244cb089b4'
);


-- None Eclipse (String Quartet no. 1)

UPDATE pieces piece
SET piece.title = 'Eclipse (String Quartet no. 1)', piece.title_en = 'Eclipse (String Quartet no. 1)',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 16999 AND piece.composer_id = 162
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'Slow and spacious', part.name_en = 'Eclipse (String Quartet no. 1): I. Slow and spacious...',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 16999 AND p.composer_id = 162 AND part.part_key = 'musicbrainz:88b1e7e2-d5cf-4090-84dd-5d22f988c4ca' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:88b1e7e2-d5cf-4090-84dd-5d22f988c4ca', 1, 'I', 'Slow and spacious', 'Eclipse (String Quartet no. 1): I. Slow and spacious...', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 16999 AND p.composer_id = 162
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:88b1e7e2-d5cf-4090-84dd-5d22f988c4ca'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'Unlikely Flight', part.name_en = 'Eclipse (String Quartet no. 1): II. Unlikely Flight',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 16999 AND p.composer_id = 162 AND part.part_key = 'musicbrainz:c5679817-1c0c-42aa-8245-d7b51272194c' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:c5679817-1c0c-42aa-8245-d7b51272194c', 2, 'II', 'Unlikely Flight', 'Eclipse (String Quartet no. 1): II. Unlikely Flight', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 16999 AND p.composer_id = 162
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:c5679817-1c0c-42aa-8245-d7b51272194c'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = 'Epilogue', part.name_en = 'Eclipse (String Quartet no. 1): III. Epilogue',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 16999 AND p.composer_id = 162 AND part.part_key = 'musicbrainz:127a2bac-91fa-4a26-9da5-8dc529ee4d88' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:127a2bac-91fa-4a26-9da5-8dc529ee4d88', 3, 'III', 'Epilogue', 'Eclipse (String Quartet no. 1): III. Epilogue', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 16999 AND p.composer_id = 162
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:127a2bac-91fa-4a26-9da5-8dc529ee4d88'
);


-- None Electric Preludes

UPDATE pieces piece
SET piece.title = 'Electric Preludes', piece.title_en = 'Electric Preludes',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 16014 AND piece.composer_id = 162
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Engelsflügel

UPDATE pieces piece
SET piece.title = 'Engelsflügel', piece.title_en = 'Engelsflügel',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 19296 AND piece.composer_id = 162
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Epitaphs

UPDATE pieces piece
SET piece.title = 'Epitaphs', piece.title_en = 'Epitaphs',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 17578 AND piece.composer_id = 162
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = '"Only I will know" ...in memory of Dorothy Porter', part.name_en = 'Epitaphs: I. "Only I will know" ...in memory of Dorothy Porter',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 17578 AND p.composer_id = 162 AND part.part_key = 'musicbrainz:3d428d9f-d6e4-4e8b-8af5-dd6b960ce7c8' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:3d428d9f-d6e4-4e8b-8af5-dd6b960ce7c8', 1, 'I', '"Only I will know" ...in memory of Dorothy Porter', 'Epitaphs: I. "Only I will know" ...in memory of Dorothy Porter', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 17578 AND p.composer_id = 162
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:3d428d9f-d6e4-4e8b-8af5-dd6b960ce7c8'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = '"Walk a little way with me" ...in memory of Lyndal Holt', part.name_en = 'Epitaphs: II. "Walk a little way with me" ...in memory of Lyndal Holt',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 17578 AND p.composer_id = 162 AND part.part_key = 'musicbrainz:d514a30c-e085-4e05-9f7b-1c1488f122c8' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:d514a30c-e085-4e05-9f7b-1c1488f122c8', 2, 'II', '"Walk a little way with me" ...in memory of Lyndal Holt', 'Epitaphs: II. "Walk a little way with me" ...in memory of Lyndal Holt', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 17578 AND p.composer_id = 162
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:d514a30c-e085-4e05-9f7b-1c1488f122c8'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = '"Der Philosoph" ...in memory of Jan Diesselhorst', part.name_en = 'Epitaphs: III. "Der Philosoph" ...in memory of Jan Diesselhorst',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 17578 AND p.composer_id = 162 AND part.part_key = 'musicbrainz:ac714332-003b-45d3-93a2-8565aa935165' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:ac714332-003b-45d3-93a2-8565aa935165', 3, 'III', '"Der Philosoph" ...in memory of Jan Diesselhorst', 'Epitaphs: III. "Der Philosoph" ...in memory of Jan Diesselhorst', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 17578 AND p.composer_id = 162
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:ac714332-003b-45d3-93a2-8565aa935165'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = 'IV',
    part.name_ko = '"György meets the "Girl Photographer"" ...in memory of Betty Freeman; hommage à György Ligeti', part.name_en = 'Epitaphs: IV. "György meets the "Girl Photographer"" ...in memory of Betty Freeman; hommage à György Ligeti',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 17578 AND p.composer_id = 162 AND part.part_key = 'musicbrainz:2399575f-f074-413d-9cdd-49ad44374f59' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:2399575f-f074-413d-9cdd-49ad44374f59', 4, 'IV', '"György meets the "Girl Photographer"" ...in memory of Betty Freeman; hommage à György Ligeti', 'Epitaphs: IV. "György meets the "Girl Photographer"" ...in memory of Betty Freeman; hommage à György Ligeti', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 17578 AND p.composer_id = 162
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:2399575f-f074-413d-9cdd-49ad44374f59'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 5, part.movement_number = 'V',
    part.name_ko = '"Between the spaces in the sky" ...in memory of Richard Hickox', part.name_en = 'Epitaphs: V. "Between the spaces in the sky" ...in memory of Richard Hickox',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 17578 AND p.composer_id = 162 AND part.part_key = 'musicbrainz:d3c4aa0b-c517-424b-a2be-0589c48c7b26' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:d3c4aa0b-c517-424b-a2be-0589c48c7b26', 5, 'V', '"Between the spaces in the sky" ...in memory of Richard Hickox', 'Epitaphs: V. "Between the spaces in the sky" ...in memory of Richard Hickox', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 17578 AND p.composer_id = 162
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:d3c4aa0b-c517-424b-a2be-0589c48c7b26'
);


-- None From Melodious Lay (A Hamlet Diffraction)

UPDATE pieces piece
SET piece.title = 'From Melodious Lay (A Hamlet Diffraction)', piece.title_en = 'From Melodious Lay (A Hamlet Diffraction)',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 19494 AND piece.composer_id = 162
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None 가곡 <Gertrude Fragments>

UPDATE pieces piece
SET piece.title = '가곡 <Gertrude Fragments>', piece.title_en = 'Gertrude Fragments',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 16456 AND piece.composer_id = 162
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'V',
    part.name_ko = 'If words be made of breath', part.name_en = 'Gertrude Fragments: V. If words be made of breath',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 16456 AND p.composer_id = 162 AND part.part_key = 'musicbrainz:074879b1-c48d-4399-9996-c1e003a2236e' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:074879b1-c48d-4399-9996-c1e003a2236e', 1, 'V', 'If words be made of breath', 'Gertrude Fragments: V. If words be made of breath', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 16456 AND p.composer_id = 162
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:074879b1-c48d-4399-9996-c1e003a2236e'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'IV',
    part.name_ko = 'How is''t with you?', part.name_en = 'Gertrude Fragments: IV. How is''t with you?',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 16456 AND p.composer_id = 162 AND part.part_key = 'musicbrainz:3d3602f5-a36a-4d3c-a867-b775fb21700b' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:3d3602f5-a36a-4d3c-a867-b775fb21700b', 2, 'IV', 'How is''t with you?', 'Gertrude Fragments: IV. How is''t with you?', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 16456 AND p.composer_id = 162
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:3d3602f5-a36a-4d3c-a867-b775fb21700b'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = 'My too much changed son', part.name_en = 'Gertrude Fragments: III. My too much changed son',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 16456 AND p.composer_id = 162 AND part.part_key = 'musicbrainz:5c29c7ce-78f8-4d43-9d57-12c3ba32d2e0' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:5c29c7ce-78f8-4d43-9d57-12c3ba32d2e0', 3, 'III', 'My too much changed son', 'Gertrude Fragments: III. My too much changed son', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 16456 AND p.composer_id = 162
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:5c29c7ce-78f8-4d43-9d57-12c3ba32d2e0'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = 'II',
    part.name_ko = 'Wring from him the cause', part.name_en = 'Gertrude Fragments: II. Wring from him the cause',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 16456 AND p.composer_id = 162 AND part.part_key = 'musicbrainz:646301cd-4b8c-476a-8473-84b2c42b8fd5' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:646301cd-4b8c-476a-8473-84b2c42b8fd5', 4, 'II', 'Wring from him the cause', 'Gertrude Fragments: II. Wring from him the cause', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 16456 AND p.composer_id = 162
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:646301cd-4b8c-476a-8473-84b2c42b8fd5'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 5, part.movement_number = 'I',
    part.name_ko = 'Cast thy knighted colour off', part.name_en = 'Gertrude Fragments: I. Cast thy knighted colour off',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 16456 AND p.composer_id = 162 AND part.part_key = 'musicbrainz:e61e1d2b-43d3-4185-ab85-2116a2f7dc4c' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:e61e1d2b-43d3-4185-ab85-2116a2f7dc4c', 5, 'I', 'Cast thy knighted colour off', 'Gertrude Fragments: I. Cast thy knighted colour off', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 16456 AND p.composer_id = 162
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:e61e1d2b-43d3-4185-ab85-2116a2f7dc4c'
);


-- None Hamlet Diffraction

UPDATE pieces piece
SET piece.title = 'Hamlet Diffraction', piece.title_en = 'Hamlet Diffraction',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 17037 AND piece.composer_id = 162
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Hommage à Lutosławski

UPDATE pieces piece
SET piece.title = 'Hommage à Lutosławski', piece.title_en = 'Hommage à Lutosławski',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 16896 AND piece.composer_id = 162
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None In spe contra spem

UPDATE pieces piece
SET piece.title = 'In spe contra spem', piece.title_en = 'In spe contra spem',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 20018 AND piece.composer_id = 162
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'Part One: Were we but as two milkmaids', part.name_en = 'In spe contra spem, Part One: Were we but as two milkmaids',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 20018 AND p.composer_id = 162 AND part.part_key = 'musicbrainz:11951c00-cf1b-4ef9-8457-1e803650fb6e' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:11951c00-cf1b-4ef9-8457-1e803650fb6e', 1, NULL, 'Part One: Were we but as two milkmaids', 'In spe contra spem, Part One: Were we but as two milkmaids', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 20018 AND p.composer_id = 162
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:11951c00-cf1b-4ef9-8457-1e803650fb6e'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'Part One: We Princes are set on stages', part.name_en = 'In spe contra spem, Part One: We Princes are set on stages',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 20018 AND p.composer_id = 162 AND part.part_key = 'musicbrainz:1e49ba14-d5af-42c5-9a97-c8e2e973f377' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:1e49ba14-d5af-42c5-9a97-c8e2e973f377', 2, NULL, 'Part One: We Princes are set on stages', 'In spe contra spem, Part One: We Princes are set on stages', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 20018 AND p.composer_id = 162
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:1e49ba14-d5af-42c5-9a97-c8e2e973f377'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = NULL,
    part.name_ko = 'Part One: In spe contra spem', part.name_en = 'In spe contra spem, Part One: In spe contra spem',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 20018 AND p.composer_id = 162 AND part.part_key = 'musicbrainz:32b6202d-339e-4363-ada0-98e29255efd7' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:32b6202d-339e-4363-ada0-98e29255efd7', 3, NULL, 'Part One: In spe contra spem', 'In spe contra spem, Part One: In spe contra spem', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 20018 AND p.composer_id = 162
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:32b6202d-339e-4363-ada0-98e29255efd7'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = NULL,
    part.name_ko = 'Part Two: I am not so ignorant, gentlemen', part.name_en = 'In spe contra spem, Part Two: I am not so ignorant, gentlemen',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 20018 AND p.composer_id = 162 AND part.part_key = 'musicbrainz:4a26860c-f85b-4c5c-bc7c-3b543f4f739a' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:4a26860c-f85b-4c5c-bc7c-3b543f4f739a', 4, NULL, 'Part Two: I am not so ignorant, gentlemen', 'In spe contra spem, Part Two: I am not so ignorant, gentlemen', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 20018 AND p.composer_id = 162
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:4a26860c-f85b-4c5c-bc7c-3b543f4f739a'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 5, part.movement_number = NULL,
    part.name_ko = 'Part Two: Interlude', part.name_en = 'In spe contra spem, Part Two: Interlude',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 20018 AND p.composer_id = 162 AND part.part_key = 'musicbrainz:6cf557c8-a874-459c-831f-79076fdce533' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:6cf557c8-a874-459c-831f-79076fdce533', 5, NULL, 'Part Two: Interlude', 'In spe contra spem, Part Two: Interlude', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 20018 AND p.composer_id = 162
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:6cf557c8-a874-459c-831f-79076fdce533'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 6, part.movement_number = NULL,
    part.name_ko = 'Part One: La fin de mon long et ennuyeux pèlerinage', part.name_en = 'In spe contra spem, Part One: La fin de mon long et ennuyeux pèlerinage',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 20018 AND p.composer_id = 162 AND part.part_key = 'musicbrainz:bc3788c5-dbbc-4395-a770-6ffcbb95f198' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:bc3788c5-dbbc-4395-a770-6ffcbb95f198', 6, NULL, 'Part One: La fin de mon long et ennuyeux pèlerinage', 'In spe contra spem, Part One: La fin de mon long et ennuyeux pèlerinage', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 20018 AND p.composer_id = 162
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:bc3788c5-dbbc-4395-a770-6ffcbb95f198'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 7, part.movement_number = NULL,
    part.name_ko = 'Part One: Full grievous is the way', part.name_en = 'In spe contra spem, Part One: Full grievous is the way',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 20018 AND p.composer_id = 162 AND part.part_key = 'musicbrainz:c1e6a5a0-9fc5-4ce6-bde0-1a066b10ef77' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:c1e6a5a0-9fc5-4ce6-bde0-1a066b10ef77', 7, NULL, 'Part One: Full grievous is the way', 'In spe contra spem, Part One: Full grievous is the way', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 20018 AND p.composer_id = 162
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:c1e6a5a0-9fc5-4ce6-bde0-1a066b10ef77'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 8, part.movement_number = NULL,
    part.name_ko = 'Part Two: Yet I find no great cause', part.name_en = 'In spe contra spem, Part Two: Yet I find no great cause',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 20018 AND p.composer_id = 162 AND part.part_key = 'musicbrainz:d15a0c6f-9baa-440e-bbe3-2445c3c6ac02' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:d15a0c6f-9baa-440e-bbe3-2445c3c6ac02', 8, NULL, 'Part Two: Yet I find no great cause', 'In spe contra spem, Part Two: Yet I find no great cause', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 20018 AND p.composer_id = 162
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:d15a0c6f-9baa-440e-bbe3-2445c3c6ac02'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 9, part.movement_number = NULL,
    part.name_ko = 'Part Two: Accuse me not of presumption', part.name_en = 'In spe contra spem, Part Two: Accuse me not of presumption',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 20018 AND p.composer_id = 162 AND part.part_key = 'musicbrainz:f4034071-7938-4b1a-8a5d-eab058e0b1b5' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:f4034071-7938-4b1a-8a5d-eab058e0b1b5', 9, NULL, 'Part Two: Accuse me not of presumption', 'In spe contra spem, Part Two: Accuse me not of presumption', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 20018 AND p.composer_id = 162
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:f4034071-7938-4b1a-8a5d-eab058e0b1b5'
);


-- None Intimate Decisions

UPDATE pieces piece
SET piece.title = 'Intimate Decisions', piece.title_en = 'Intimate Decisions',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 19419 AND piece.composer_id = 162
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Notturno inquieto

UPDATE pieces piece
SET piece.title = 'Notturno inquieto', piece.title_en = 'Notturno inquieto',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 17991 AND piece.composer_id = 162
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None 발레 <One of a Kind>

UPDATE pieces piece
SET piece.title = '발레 <One of a Kind>', piece.title_en = 'One of a Kind',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 18990 AND piece.composer_id = 162
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'Act I', part.name_en = 'One of a Kind: Act I',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 18990 AND p.composer_id = 162 AND part.part_key = 'musicbrainz:585d1796-2841-4445-b615-191374c72049' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:585d1796-2841-4445-b615-191374c72049', 1, NULL, 'Act I', 'One of a Kind: Act I', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 18990 AND p.composer_id = 162
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:585d1796-2841-4445-b615-191374c72049'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'Act II', part.name_en = 'One of a Kind: Act II',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 18990 AND p.composer_id = 162 AND part.part_key = 'musicbrainz:950fd362-23f0-4ecd-ad1f-2023c5a23547' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:950fd362-23f0-4ecd-ad1f-2023c5a23547', 2, NULL, 'Act II', 'One of a Kind: Act II', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 18990 AND p.composer_id = 162
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:950fd362-23f0-4ecd-ad1f-2023c5a23547'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = NULL,
    part.name_ko = 'Act III', part.name_en = 'One of a Kind: Act III',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 18990 AND p.composer_id = 162 AND part.part_key = 'musicbrainz:47c9afd7-ef42-48e9-98e2-1fe6ce67c9e7' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:47c9afd7-ef42-48e9-98e2-1fe6ce67c9e7', 3, NULL, 'Act III', 'One of a Kind: Act III', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 18990 AND p.composer_id = 162
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:47c9afd7-ef42-48e9-98e2-1fe6ce67c9e7'
);


-- None Pastoral Symphony

UPDATE pieces piece
SET piece.title = 'Pastoral Symphony', piece.title_en = 'Pastoral Symphony',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 16974 AND piece.composer_id = 162
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None 피아노 협주곡 "Gneixendorf Music - A Winter"

UPDATE pieces piece
SET piece.title = '피아노 협주곡 "Gneixendorf Music - A Winter"', piece.title_en = 'Piano Concerto "Gneixendorf Music - A Winter''s Journey"',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 15826 AND piece.composer_id = 162
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'Ankunft', part.name_en = 'Gneixendorfer Musik Eine Winterreise: I. Ankunft',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 15826 AND p.composer_id = 162 AND part.part_key = 'musicbrainz:4a331349-2972-422b-b278-1b8c5428fb7f' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:4a331349-2972-422b-b278-1b8c5428fb7f', 1, 'I', 'Ankunft', 'Gneixendorfer Musik Eine Winterreise: I. Ankunft', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 15826 AND p.composer_id = 162
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:4a331349-2972-422b-b278-1b8c5428fb7f'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'Die Abreise', part.name_en = 'Gneixendorfer Musik Eine Winterreise: II. Die Abreise',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 15826 AND p.composer_id = 162 AND part.part_key = 'musicbrainz:580d6240-7ef2-45e3-a6cf-656695ccd028' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:580d6240-7ef2-45e3-a6cf-656695ccd028', 2, 'II', 'Die Abreise', 'Gneixendorfer Musik Eine Winterreise: II. Die Abreise', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 15826 AND p.composer_id = 162
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:580d6240-7ef2-45e3-a6cf-656695ccd028'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = 'Epilog', part.name_en = 'Gneixendorfer Musik Eine Winterreise: III. Epilog',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 15826 AND p.composer_id = 162 AND part.part_key = 'musicbrainz:14c5c9c3-e1e3-49c2-8a8c-c214e1a92492' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:14c5c9c3-e1e3-49c2-8a8c-c214e1a92492', 3, 'III', 'Epilog', 'Gneixendorfer Musik Eine Winterreise: III. Epilog', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 15826 AND p.composer_id = 162
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:14c5c9c3-e1e3-49c2-8a8c-c214e1a92492'
);


-- None Rooms of Elsinore

UPDATE pieces piece
SET piece.title = 'Rooms of Elsinore', piece.title_en = 'Rooms of Elsinore',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 18193 AND piece.composer_id = 162
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'VI',
    part.name_ko = 'The Queen''s Chamber', part.name_en = 'Rooms of Elsinore: VI. The Queen''s Chamber',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 18193 AND p.composer_id = 162 AND part.part_key = 'musicbrainz:03a6c0af-f128-43bc-a405-4fdff5a9f804' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:03a6c0af-f128-43bc-a405-4fdff5a9f804', 1, 'VI', 'The Queen''s Chamber', 'Rooms of Elsinore: VI. The Queen''s Chamber', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 18193 AND p.composer_id = 162
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:03a6c0af-f128-43bc-a405-4fdff5a9f804'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'VII',
    part.name_ko = 'The Trumpeter''s Tower', part.name_en = 'Rooms of Elsinore: VII. The Trumpeter''s Tower',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 18193 AND p.composer_id = 162 AND part.part_key = 'musicbrainz:1460ec5a-67c1-497e-b20b-ed44e1d26c3a' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:1460ec5a-67c1-497e-b20b-ed44e1d26c3a', 2, 'VII', 'The Trumpeter''s Tower', 'Rooms of Elsinore: VII. The Trumpeter''s Tower', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 18193 AND p.composer_id = 162
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:1460ec5a-67c1-497e-b20b-ed44e1d26c3a'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'V',
    part.name_ko = 'The Chapel', part.name_en = 'Rooms of Elsinore: V. The Chapel',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 18193 AND p.composer_id = 162 AND part.part_key = 'musicbrainz:ba83c20e-40bf-44b7-80f4-e10311db9f81' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:ba83c20e-40bf-44b7-80f4-e10311db9f81', 3, 'V', 'The Chapel', 'Rooms of Elsinore: V. The Chapel', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 18193 AND p.composer_id = 162
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:ba83c20e-40bf-44b7-80f4-e10311db9f81'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = 'III',
    part.name_ko = 'The Platform', part.name_en = 'Rooms of Elsinore: III. The Platform',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 18193 AND p.composer_id = 162 AND part.part_key = 'musicbrainz:bb56e32a-4f2d-4a6d-b489-26986ba91404' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:bb56e32a-4f2d-4a6d-b489-26986ba91404', 4, 'III', 'The Platform', 'Rooms of Elsinore: III. The Platform', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 18193 AND p.composer_id = 162
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:bb56e32a-4f2d-4a6d-b489-26986ba91404'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 5, part.movement_number = 'IV',
    part.name_ko = 'The King''s Chamber', part.name_en = 'Rooms of Elsinore: IV. The King''s Chamber',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 18193 AND p.composer_id = 162 AND part.part_key = 'musicbrainz:c47ceba8-19f2-482f-b292-bc0a51b464a9' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:c47ceba8-19f2-482f-b292-bc0a51b464a9', 5, 'IV', 'The King''s Chamber', 'Rooms of Elsinore: IV. The King''s Chamber', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 18193 AND p.composer_id = 162
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:c47ceba8-19f2-482f-b292-bc0a51b464a9'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 6, part.movement_number = 'I',
    part.name_ko = 'The Dark Gate', part.name_en = 'Rooms of Elsinore: I. The Dark Gate',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 18193 AND p.composer_id = 162 AND part.part_key = 'musicbrainz:e71964a1-5fff-46e4-ab19-026a24178247' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:e71964a1-5fff-46e4-ab19-026a24178247', 6, 'I', 'The Dark Gate', 'Rooms of Elsinore: I. The Dark Gate', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 18193 AND p.composer_id = 162
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:e71964a1-5fff-46e4-ab19-026a24178247'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 7, part.movement_number = 'II',
    part.name_ko = 'The Four Gate Courtyard', part.name_en = 'Rooms of Elsinore: II. The Four Gate Courtyard',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 18193 AND p.composer_id = 162 AND part.part_key = 'musicbrainz:ffc34b9d-c725-4de0-922a-953237760cd1' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:ffc34b9d-c725-4de0-922a-953237760cd1', 7, 'II', 'The Four Gate Courtyard', 'Rooms of Elsinore: II. The Four Gate Courtyard', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 18193 AND p.composer_id = 162
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:ffc34b9d-c725-4de0-922a-953237760cd1'
);


-- None 현악 4중주 2번 "And once I played Ophelia"

UPDATE pieces piece
SET piece.title = '현악 4중주 2번 "And once I played Ophelia"', piece.title_en = 'String Quartet no. 2 "And once I played Ophelia"',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 16288 AND piece.composer_id = 162
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'Fast, breathless', part.name_en = 'String Quartet no. 2 "And once I played Ophelia": I. Fast, breathless',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 16288 AND p.composer_id = 162 AND part.part_key = 'musicbrainz:120fdd71-fab7-496c-b801-99c204f03b94' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:120fdd71-fab7-496c-b801-99c204f03b94', 1, 'I', 'Fast, breathless', 'String Quartet no. 2 "And once I played Ophelia": I. Fast, breathless', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 16288 AND p.composer_id = 162
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:120fdd71-fab7-496c-b801-99c204f03b94'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'Hushed, distant', part.name_en = 'String Quartet no. 2 "And once I played Ophelia": II. Hushed, distant...',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 16288 AND p.composer_id = 162 AND part.part_key = 'musicbrainz:2ed70f85-84c1-4223-904c-4fef2a18cba1' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:2ed70f85-84c1-4223-904c-4fef2a18cba1', 2, 'II', 'Hushed, distant', 'String Quartet no. 2 "And once I played Ophelia": II. Hushed, distant...', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 16288 AND p.composer_id = 162
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:2ed70f85-84c1-4223-904c-4fef2a18cba1'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = 'Fast, agitated', part.name_en = 'String Quartet no. 2 "And once I played Ophelia": III. Fast, agitated...',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 16288 AND p.composer_id = 162 AND part.part_key = 'musicbrainz:e120269b-0757-4221-bd73-ce246d196320' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:e120269b-0757-4221-bd73-ce246d196320', 3, 'III', 'Fast, agitated', 'String Quartet no. 2 "And once I played Ophelia": III. Fast, agitated...', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 16288 AND p.composer_id = 162
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:e120269b-0757-4221-bd73-ce246d196320'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = 'IV',
    part.name_ko = 'Extremely still', part.name_en = 'String Quartet no. 2 "And once I played Ophelia": IV. Extremely still...',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 16288 AND p.composer_id = 162 AND part.part_key = 'musicbrainz:3d12db2b-04ce-4714-ad8b-c2c020407092' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:3d12db2b-04ce-4714-ad8b-c2c020407092', 4, 'IV', 'Extremely still', 'String Quartet no. 2 "And once I played Ophelia": IV. Extremely still...', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 16288 AND p.composer_id = 162
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:3d12db2b-04ce-4714-ad8b-c2c020407092'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 5, part.movement_number = 'V',
    part.name_ko = 'Slow, austere', part.name_en = 'String Quartet no. 2 "And once I played Ophelia": V. Slow, austere',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 16288 AND p.composer_id = 162 AND part.part_key = 'musicbrainz:1e62691c-fed7-4bba-a411-a2b7cfe386b4' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:1e62691c-fed7-4bba-a411-a2b7cfe386b4', 5, 'V', 'Slow, austere', 'String Quartet no. 2 "And once I played Ophelia": V. Slow, austere', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 16288 AND p.composer_id = 162
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:1e62691c-fed7-4bba-a411-a2b7cfe386b4'
);


-- None The Annunciation

UPDATE pieces piece
SET piece.title = 'The Annunciation', piece.title_en = 'The Annunciation',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 18041 AND piece.composer_id = 162
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None The Last Days of Socrates

UPDATE pieces piece
SET piece.title = 'The Last Days of Socrates', piece.title_en = 'The Last Days of Socrates',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 19317 AND piece.composer_id = 162
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None The Lost Art of Letter Writing

UPDATE pieces piece
SET piece.title = 'The Lost Art of Letter Writing', piece.title_en = 'The Lost Art of Letter Writing',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 17823 AND piece.composer_id = 162
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None The Players

UPDATE pieces piece
SET piece.title = 'The Players', piece.title_en = 'The Players',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 18938 AND piece.composer_id = 162
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'IV',
    part.name_ko = 'Pantomime', part.name_en = 'The Players: IV. Pantomime',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 18938 AND p.composer_id = 162 AND part.part_key = 'musicbrainz:1f415c93-fc04-4d43-9150-ead745bac179' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:1f415c93-fc04-4d43-9150-ead745bac179', 1, 'IV', 'Pantomime', 'The Players: IV. Pantomime', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 18938 AND p.composer_id = 162
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:1f415c93-fc04-4d43-9150-ead745bac179'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'III',
    part.name_ko = 'Fanfare. The players arrive', part.name_en = 'The Players: III. Fanfare. The players arrive',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 18938 AND p.composer_id = 162 AND part.part_key = 'musicbrainz:23ad5c3d-008f-4b08-9016-2cc698c4bac7' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:23ad5c3d-008f-4b08-9016-2cc698c4bac7', 2, 'III', 'Fanfare. The players arrive', 'The Players: III. Fanfare. The players arrive', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 18938 AND p.composer_id = 162
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:23ad5c3d-008f-4b08-9016-2cc698c4bac7'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'I',
    part.name_ko = 'Prelude', part.name_en = 'The Players: I. Prelude',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 18938 AND p.composer_id = 162 AND part.part_key = 'musicbrainz:332a68ac-b71a-4297-a573-c070435454dc' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:332a68ac-b71a-4297-a573-c070435454dc', 3, 'I', 'Prelude', 'The Players: I. Prelude', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 18938 AND p.composer_id = 162
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:332a68ac-b71a-4297-a573-c070435454dc'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = 'II',
    part.name_ko = 'Look, look! Look where my abridgement comes!', part.name_en = 'The Players: II. Look, look! Look where my abridgement comes!',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 18938 AND p.composer_id = 162 AND part.part_key = 'musicbrainz:d930e522-dbec-491b-830a-31acd2550f53' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:d930e522-dbec-491b-830a-31acd2550f53', 4, 'II', 'Look, look! Look where my abridgement comes!', 'The Players: II. Look, look! Look where my abridgement comes!', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 18938 AND p.composer_id = 162
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:d930e522-dbec-491b-830a-31acd2550f53'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 5, part.movement_number = 'V',
    part.name_ko = 'Postlude', part.name_en = 'The Players: V. Postlude',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 18938 AND p.composer_id = 162 AND part.part_key = 'musicbrainz:e78817b8-5b73-43f8-86aa-f45fb4ecef3b' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:e78817b8-5b73-43f8-86aa-f45fb4ecef3b', 5, 'V', 'Postlude', 'The Players: V. Postlude', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 18938 AND p.composer_id = 162
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:e78817b8-5b73-43f8-86aa-f45fb4ecef3b'
);


-- None The Siduri Dances

UPDATE pieces piece
SET piece.title = 'The Siduri Dances', piece.title_en = 'The Siduri Dances',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 18573 AND piece.composer_id = 162
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None The World’s Wife

UPDATE pieces piece
SET piece.title = 'The World’s Wife', piece.title_en = 'The World’s Wife',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 17366 AND piece.composer_id = 162
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Three Caprichos After Goya

UPDATE pieces piece
SET piece.title = 'Three Caprichos After Goya', piece.title_en = 'Three Caprichos After Goya',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 18289 AND piece.composer_id = 162
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = '¡Qué sacrificio!', part.name_en = 'Three Caprichos After Goya: I. ¡Qué sacrificio!',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 18289 AND p.composer_id = 162 AND part.part_key = 'musicbrainz:c8c580ff-9c1b-49b0-a474-285db3094b5c' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:c8c580ff-9c1b-49b0-a474-285db3094b5c', 1, 'I', '¡Qué sacrificio!', 'Three Caprichos After Goya: I. ¡Qué sacrificio!', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 18289 AND p.composer_id = 162
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:c8c580ff-9c1b-49b0-a474-285db3094b5c'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'Dios la perdone: Y era su madre', part.name_en = 'Three Caprichos After Goya: II. Dios la perdone: Y era su madre',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 18289 AND p.composer_id = 162 AND part.part_key = 'musicbrainz:d139ae5a-d9cc-4e30-a27d-713a75852fad' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:d139ae5a-d9cc-4e30-a27d-713a75852fad', 2, 'II', 'Dios la perdone: Y era su madre', 'Three Caprichos After Goya: II. Dios la perdone: Y era su madre', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 18289 AND p.composer_id = 162
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:d139ae5a-d9cc-4e30-a27d-713a75852fad'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = 'No te escaparás', part.name_en = 'Three Caprichos After Goya: III. No te escaparás',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 18289 AND p.composer_id = 162 AND part.part_key = 'musicbrainz:0b1fcb3f-c973-4d2a-a3ac-62dd75ea3660' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:0b1fcb3f-c973-4d2a-a3ac-62dd75ea3660', 3, 'III', 'No te escaparás', 'Three Caprichos After Goya: III. No te escaparás', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 18289 AND p.composer_id = 162
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:0b1fcb3f-c973-4d2a-a3ac-62dd75ea3660'
);


-- None To Look Yet Not Find

UPDATE pieces piece
SET piece.title = 'To Look Yet Not Find', piece.title_en = 'To Look Yet Not Find',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 16255 AND piece.composer_id = 162
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Twelve Angry Men

UPDATE pieces piece
SET piece.title = 'Twelve Angry Men', piece.title_en = 'Twelve Angry Men',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 18234 AND piece.composer_id = 162
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Vexations and Devotions

UPDATE pieces piece
SET piece.title = 'Vexations and Devotions', piece.title_en = 'Vexations and Devotions',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 18846 AND piece.composer_id = 162
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'Watching Others', part.name_en = 'Vexations and Devotions: I. Watching Others',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 18846 AND p.composer_id = 162 AND part.part_key = 'musicbrainz:3f063529-4e89-4142-8a6a-7d185a22026e' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:3f063529-4e89-4142-8a6a-7d185a22026e', 1, 'I', 'Watching Others', 'Vexations and Devotions: I. Watching Others', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 18846 AND p.composer_id = 162
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:3f063529-4e89-4142-8a6a-7d185a22026e'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'Bell and Anti-Bell', part.name_en = 'Vexations and Devotions: II. Bell and Anti-Bell',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 18846 AND p.composer_id = 162 AND part.part_key = 'musicbrainz:eb1e4568-d6ae-4191-a31c-35932f2dba4a' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:eb1e4568-d6ae-4191-a31c-35932f2dba4a', 2, 'II', 'Bell and Anti-Bell', 'Vexations and Devotions: II. Bell and Anti-Bell', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 18846 AND p.composer_id = 162
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:eb1e4568-d6ae-4191-a31c-35932f2dba4a'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = 'The Path to Your Doo', part.name_en = 'Vexations and Devotions: III. The Path to Your Doo',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 18846 AND p.composer_id = 162 AND part.part_key = 'musicbrainz:b1cb9674-2503-4295-bee2-d918b5c93f83' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:b1cb9674-2503-4295-bee2-d918b5c93f83', 3, 'III', 'The Path to Your Doo', 'Vexations and Devotions: III. The Path to Your Doo', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 18846 AND p.composer_id = 162
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:b1cb9674-2503-4295-bee2-d918b5c93f83'
);


-- None Voices of Angels

UPDATE pieces piece
SET piece.title = 'Voices of Angels', piece.title_en = 'Voices of Angels',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 19068 AND piece.composer_id = 162
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'Evocation', part.name_en = 'Voices of Angels: I. Evocation',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 19068 AND p.composer_id = 162 AND part.part_key = 'musicbrainz:7d707e7d-5904-4ed5-9249-50a43d9e45f2' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:7d707e7d-5904-4ed5-9249-50a43d9e45f2', 1, 'I', 'Evocation', 'Voices of Angels: I. Evocation', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 19068 AND p.composer_id = 162
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:7d707e7d-5904-4ed5-9249-50a43d9e45f2'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'Different Realms', part.name_en = 'Voices of Angels: II. Different Realms',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 19068 AND p.composer_id = 162 AND part.part_key = 'musicbrainz:5757de9c-2532-4906-82de-93f3871d3357' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:5757de9c-2532-4906-82de-93f3871d3357', 2, 'II', 'Different Realms', 'Voices of Angels: II. Different Realms', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 19068 AND p.composer_id = 162
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:5757de9c-2532-4906-82de-93f3871d3357'
);


-- None Water Music

UPDATE pieces piece
SET piece.title = 'Water Music', piece.title_en = 'Water Music',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 20098 AND piece.composer_id = 162
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'Bubbling', part.name_en = 'Water Music: 1. Bubbling',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 20098 AND p.composer_id = 162 AND part.part_key = 'musicbrainz:c1ddb0b2-036c-4bad-91f3-3062d089e477' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:c1ddb0b2-036c-4bad-91f3-3062d089e477', 1, NULL, 'Bubbling', 'Water Music: 1. Bubbling', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 20098 AND p.composer_id = 162
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:c1ddb0b2-036c-4bad-91f3-3062d089e477'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'Coursing', part.name_en = 'Water Music: 2. Coursing',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 20098 AND p.composer_id = 162 AND part.part_key = 'musicbrainz:f7f784ec-2721-4525-81d2-b936d208260f' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:f7f784ec-2721-4525-81d2-b936d208260f', 2, NULL, 'Coursing', 'Water Music: 2. Coursing', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 20098 AND p.composer_id = 162
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:f7f784ec-2721-4525-81d2-b936d208260f'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = NULL,
    part.name_ko = 'Parched Earth', part.name_en = 'Water Music: 3. Parched Earth',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 20098 AND p.composer_id = 162 AND part.part_key = 'musicbrainz:12af7cdb-b805-45bc-b002-3705b3111a57' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:12af7cdb-b805-45bc-b002-3705b3111a57', 3, NULL, 'Parched Earth', 'Water Music: 3. Parched Earth', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 20098 AND p.composer_id = 162
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:12af7cdb-b805-45bc-b002-3705b3111a57'
);


-- None Winter Songs

UPDATE pieces piece
SET piece.title = 'Winter Songs', piece.title_en = 'Winter Songs',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 16469 AND piece.composer_id = 162
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = '(Introduction) - (1. "e") - (2. "n")', part.name_en = 'Winter Songs: I. (Introduction) - (1. "e") - (2. "n")',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 16469 AND p.composer_id = 162 AND part.part_key = 'musicbrainz:35b5fb7f-a758-4acb-b760-6ae8dd5e6706' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:35b5fb7f-a758-4acb-b760-6ae8dd5e6706', 1, 'I', '(Introduction) - (1. "e") - (2. "n")', 'Winter Songs: I. (Introduction) - (1. "e") - (2. "n")', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 16469 AND p.composer_id = 162
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:35b5fb7f-a758-4acb-b760-6ae8dd5e6706'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = '(3. "if in beginning twilight winter will stand")', part.name_en = 'Winter Songs: II. (3. "if in beginning twilight winter will stand")',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 16469 AND p.composer_id = 162 AND part.part_key = 'musicbrainz:6aff64d9-4470-43f2-bf25-1a05db00e5b9' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:6aff64d9-4470-43f2-bf25-1a05db00e5b9', 2, 'II', '(3. "if in beginning twilight winter will stand")', 'Winter Songs: II. (3. "if in beginning twilight winter will stand")', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 16469 AND p.composer_id = 162
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:6aff64d9-4470-43f2-bf25-1a05db00e5b9'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = '(4. "Who are you little i") - (5. "n")', part.name_en = 'Winter Songs: III. (4. "Who are you little i") - (5. "n")',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 16469 AND p.composer_id = 162 AND part.part_key = 'musicbrainz:bed401de-b160-4c3c-b553-60764f0e7ff9' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:bed401de-b160-4c3c-b553-60764f0e7ff9', 3, 'III', '(4. "Who are you little i") - (5. "n")', 'Winter Songs: III. (4. "Who are you little i") - (5. "n")', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 16469 AND p.composer_id = 162
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:bed401de-b160-4c3c-b553-60764f0e7ff9'
);


-- None …the scene of the crime…

UPDATE pieces piece
SET piece.title = '…the scene of the crime…', piece.title_en = '…the scene of the crime…',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 17967 AND piece.composer_id = 162
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None 첼로 협주곡

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '첼로 협주곡', 'Cello Concerto', 'album', NULL, NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 162
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '첼로 협주곡'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '1cbc13ac-d785-4c59-97c6-625d606038c6'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '1cbc13ac-d785-4c59-97c6-625d606038c6'
FROM pieces p
WHERE p.composer_id = 162 AND p.title = '첼로 협주곡' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '1cbc13ac-d785-4c59-97c6-625d606038c6'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:59ba7ac0-1afb-42bd-bb27-58e961d7af95', 1, NULL, 'Slow, dreamy, unhurried', 'Cello Concerto: Slow, dreamy, unhurried', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 162 AND p.title = '첼로 협주곡' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:59ba7ac0-1afb-42bd-bb27-58e961d7af95'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:77cdd10a-f4e7-4626-a9b0-b92f8a975fa5', 2, NULL, 'Slow, spacious, and still', 'Cello Concerto: Slow, spacious, and still', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 162 AND p.title = '첼로 협주곡' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:77cdd10a-f4e7-4626-a9b0-b92f8a975fa5'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:ab00096b-fbba-4fb3-b7a9-4b0851890772', 3, NULL, 'Extremely intimate, yet flowing and playful', 'Cello Concerto: Extremely intimate, yet flowing and playful', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 162 AND p.title = '첼로 협주곡' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:ab00096b-fbba-4fb3-b7a9-4b0851890772'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:c22b379f-5a60-432a-a7fe-2dea1347de15', 4, NULL, 'Fast, rhythmic, relentless', 'Cello Concerto: Fast, rhythmic, relentless', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 162 AND p.title = '첼로 협주곡' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:c22b379f-5a60-432a-a7fe-2dea1347de15'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:eba6c838-93f7-4cf2-9307-008ba8bd8f6c', 5, NULL, 'Allegro agitato sempre', 'Cello Concerto: Allegro agitato sempre', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 162 AND p.title = '첼로 협주곡' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:eba6c838-93f7-4cf2-9307-008ba8bd8f6c'
);


-- None Testament

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, 'Testament', 'Testament', 'song', NULL, NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 162
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = 'Testament'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '06289c64-72ac-4d12-ae56-e0aa7664f268'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '06289c64-72ac-4d12-ae56-e0aa7664f268'
FROM pieces p
WHERE p.composer_id = 162 AND p.title = 'Testament' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '06289c64-72ac-4d12-ae56-e0aa7664f268'
);


-- None 비올라 협주곡

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '비올라 협주곡', 'Viola Concerto', 'album', NULL, NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 162
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '비올라 협주곡'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '78bd6544-c51b-4c20-b64c-14422c66b517'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '78bd6544-c51b-4c20-b64c-14422c66b517'
FROM pieces p
WHERE p.composer_id = 162 AND p.title = '비올라 협주곡' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '78bd6544-c51b-4c20-b64c-14422c66b517'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:b7443f6c-5ca9-4cd9-8e91-5be782e37c57', 1, 'I', 'Fragment', 'Viola Concerto: I. Fragment', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 162 AND p.title = '비올라 협주곡' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:b7443f6c-5ca9-4cd9-8e91-5be782e37c57'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:43bb0c34-063a-4c12-b72d-a5da18ad33ef', 2, 'II', 'Pursuit', 'Viola Concerto: II. Pursuit', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 162 AND p.title = '비올라 협주곡' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:43bb0c34-063a-4c12-b72d-a5da18ad33ef'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:e14b0175-3505-4cd0-b5fc-3f431d239cf6', 3, 'III', 'Veiled and Mysterious', 'Viola Concerto: III. Veiled and Mysterious', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 162 AND p.title = '비올라 협주곡' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:e14b0175-3505-4cd0-b5fc-3f431d239cf6'
);


-- 카탈로그에 대응이 없는 seed 작품 4개를 목록에서 숨긴다(지우지 않음).
UPDATE pieces piece
SET piece.hidden_reason = 'catalog_unmatched'
WHERE piece.composer_id = 162 AND piece.origin = 'seed' AND piece.hidden_reason IS NULL
  AND piece.id IN (
    17749, 19399, 19574, 20031
  )
  AND NOT EXISTS (SELECT 1 FROM performance_sectors sector WHERE sector.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM piece_parts linking WHERE linking.linked_piece_id = piece.id);
