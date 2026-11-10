-- 작곡가 20명의 작품을 MusicBrainz 작품 구조로 다시 짠다(6차 자동, 4/9).
-- 작품 117개(새 11개), seed 142개 중 잇기 106·숨김 32·그대로 4.
--
-- 6차는 4차 규칙(사람·에이전트 판단 없음)을 그대로 썼다. 규칙은
-- seed_pipeline/curation/catalog-wave4-2026-10-12/auto/auto_catalog.py, 작곡가별 자료는
-- seed_pipeline/curation/catalog-wave6-2026-11-10/<작곡가>/(catalog.json·seed_map.json).
--   작품: MusicBrainz 에서 이 작곡가가 composer 인 work 중 다른 work 의 part 가 아니고
--     편곡·다른 판·발췌·단편·리믹스 표시가 없는 것. part 는 MB parts 순서대로 두 겹까지.
--   제목: 「Symphony no. 5 in C minor」 꼴은 「교향곡 5번 C단조」로 옮기고,
--     못 읽으면 원제를 둔다(MB 갈래가 가곡·오페라 등이면 「가곡 <원제>」).
--   seed 작품: MBID 가 작품이면 그 자리(제목을 위 꼴로 고치고 잠금), part 면 part 로 잇고,
--     편곡·다른 판·중복·리믹스면 hidden_reason='catalog_unmatched' 로 숨긴다(지우지 않음).
--     판단이 서지 않는 seed 는 손대지 않고 보이게 둔다. 숨길 seed 가 카탈로그 제목을
--     쥐고 있으면 그 seed 제목 뒤에 까닭을 붙여 자리를 비운다(숨긴 작품이라 안 보임).
--   manual 작품: 제목·설명·링크는 바꾸지 않는다. MBID 가 엉뚱한 work 를 가리키면
--     (제목이 전혀 다름) 잇지 않고, MBID 가 없으면 영어 제목이 같은 작품에 잇는다
--     (식별자는 더하지 않음).
--   비교 구간이 있거나 part 가 가리키는 작품은 숨기지 않는다. 두 번 돌려도 같다.

-- ===== Manuel Rosenthal (composer_id 243) =====
-- 작품을 MusicBrainz 작품 구조로 다시 짠다(6차 자동). 작품 9개(묶음 1, 다악장 0, 낱곡 8),
-- 새 작품 2개, part 4개, 그 아래 0개.
-- seed 8개 중 7개를 작품·part 에 잇고, 0개를 숨기고, 1개는 그대로 둔다.

-- None 연가곡집 <Chansons du Monsieur Bleu>

UPDATE pieces piece
SET piece.title = '연가곡집 <Chansons du Monsieur Bleu>', piece.title_en = 'Chansons du Monsieur Bleu',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 17808 AND piece.composer_id = 243
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None 가곡 <Fido, Fido>

UPDATE pieces piece
SET piece.title = '가곡 <Fido, Fido>', piece.title_en = 'Fido, Fido',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 18890 AND piece.composer_id = 243
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None 가곡 <L'éléphant du Jardin des Plantes>

UPDATE pieces piece
SET piece.title = '가곡 <L''éléphant du Jardin des Plantes>', piece.title_en = 'L''éléphant du Jardin des Plantes',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 16027 AND piece.composer_id = 243
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None 가곡 <La Souris d'Angleterre>

UPDATE pieces piece
SET piece.title = '가곡 <La Souris d''Angleterre>', piece.title_en = 'La Souris d''Angleterre',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 16300 AND piece.composer_id = 243
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None 가곡 <Le vieux chameau du zoo>

UPDATE pieces piece
SET piece.title = '가곡 <Le vieux chameau du zoo>', piece.title_en = 'Le vieux chameau du zoo',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 19168 AND piece.composer_id = 243
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Offenbachiana

UPDATE pieces piece
SET piece.title = 'Offenbachiana', piece.title_en = 'Offenbachiana',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 18245 AND piece.composer_id = 243
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'Ouverture – Barbe-Bleue', part.name_en = 'Offenbachiana : Ouverture – Barbe-Bleue',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 18245 AND p.composer_id = 243 AND part.part_key = 'musicbrainz:3c82ad56-d1a7-4f22-a598-dc8850cfb71f' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:3c82ad56-d1a7-4f22-a598-dc8850cfb71f', 1, NULL, 'Ouverture – Barbe-Bleue', 'Offenbachiana : Ouverture – Barbe-Bleue', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 18245 AND p.composer_id = 243
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:3c82ad56-d1a7-4f22-a598-dc8850cfb71f'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'Barbe-Bleue – La Fille du Tambour-Majeur', part.name_en = 'Offenbachiana : II. Barbe-Bleue – La Fille du Tambour-Majeur',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 18245 AND p.composer_id = 243 AND part.part_key = 'musicbrainz:d02c0478-0a86-42e1-ad7b-d406f846a3c1' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:d02c0478-0a86-42e1-ad7b-d406f846a3c1', 2, NULL, 'Barbe-Bleue – La Fille du Tambour-Majeur', 'Offenbachiana : II. Barbe-Bleue – La Fille du Tambour-Majeur', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 18245 AND p.composer_id = 243
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:d02c0478-0a86-42e1-ad7b-d406f846a3c1'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = NULL,
    part.name_ko = 'La Grande-Duchesse de Gerolstein', part.name_en = 'Offenbachiana : I. La Grande-Duchesse de Gerolstein',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 18245 AND p.composer_id = 243 AND part.part_key = 'musicbrainz:de73a3bb-338e-4417-a5d4-72adf004ceb8' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:de73a3bb-338e-4417-a5d4-72adf004ceb8', 3, NULL, 'La Grande-Duchesse de Gerolstein', 'Offenbachiana : I. La Grande-Duchesse de Gerolstein', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 18245 AND p.composer_id = 243
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:de73a3bb-338e-4417-a5d4-72adf004ceb8'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = NULL,
    part.name_ko = 'La Vie Parisienne – La Grande-Duchesse de Gerolstein – Barbe-Bleue', part.name_en = 'Offenbachiana : III. La Vie Parisienne – La Grande-Duchesse de Gerolstein – Barbe-Bleue',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 18245 AND p.composer_id = 243 AND part.part_key = 'musicbrainz:f0d34d30-4390-437b-bc36-a15106f4f38e' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:f0d34d30-4390-437b-bc36-a15106f4f38e', 4, NULL, 'La Vie Parisienne – La Grande-Duchesse de Gerolstein – Barbe-Bleue', 'Offenbachiana : III. La Vie Parisienne – La Grande-Duchesse de Gerolstein – Barbe-Bleue', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 18245 AND p.composer_id = 243
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:f0d34d30-4390-437b-bc36-a15106f4f38e'
);


-- None 가곡 <Pêcheur de lune>

UPDATE pieces piece
SET piece.title = '가곡 <Pêcheur de lune>', piece.title_en = 'Pêcheur de lune',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 16781 AND piece.composer_id = 243
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None 가곡 <Rêverie>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '가곡 <Rêverie>', 'Rêverie', 'song', NULL, NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 243
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '가곡 <Rêverie>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'efd72314-70df-42bd-b840-bd0681cf25ac'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'efd72314-70df-42bd-b840-bd0681cf25ac'
FROM pieces p
WHERE p.composer_id = 243 AND p.title = '가곡 <Rêverie>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'efd72314-70df-42bd-b840-bd0681cf25ac'
);


-- None 가곡 <Rêverie: Pour calmer ma détresse>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '가곡 <Rêverie: Pour calmer ma détresse>', 'Rêverie: Pour calmer ma détresse', 'song', NULL, NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 243
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '가곡 <Rêverie: Pour calmer ma détresse>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '58999613-4525-4955-9531-95ed83a4080b'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '58999613-4525-4955-9531-95ed83a4080b'
FROM pieces p
WHERE p.composer_id = 243 AND p.title = '가곡 <Rêverie: Pour calmer ma détresse>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '58999613-4525-4955-9531-95ed83a4080b'
);

-- 숨길 seed 작품 없음

-- ===== Vano Muradeli (composer_id 244) =====
-- 작품을 MusicBrainz 작품 구조로 다시 짠다(6차 자동). 작품 1개(묶음 0, 다악장 0, 낱곡 1),
-- 새 작품 0개, part 0개, 그 아래 0개.
-- seed 18개 중 1개를 작품·part 에 잇고, 17개를 숨기고, 0개는 그대로 둔다.

-- None 가곡 <Он и она>

UPDATE pieces piece
SET piece.title = '가곡 <Он и она>', piece.title_en = 'Он и она',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 16106 AND piece.composer_id = 244
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

-- 카탈로그에 대응이 없는 seed 작품 17개를 목록에서 숨긴다(지우지 않음).
UPDATE pieces piece
SET piece.hidden_reason = 'catalog_unmatched'
WHERE piece.composer_id = 244 AND piece.origin = 'seed' AND piece.hidden_reason IS NULL
  AND piece.id IN (
    15855, 16107, 16112, 16230, 16308, 16844, 16906, 17029, 17415, 17613, 17864, 18133, 18136, 18669, 19276, 19924, 20040
  )
  AND NOT EXISTS (SELECT 1 FROM performance_sectors sector WHERE sector.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM piece_parts linking WHERE linking.linked_piece_id = piece.id);

-- ===== 펠릭스 블루멘펠트 (composer_id 245) =====
-- 작품을 MusicBrainz 작품 구조로 다시 짠다(6차 자동). 작품 16개(묶음 6, 다악장 3, 낱곡 7),
-- 새 작품 0개, part 25개, 그 아래 0개.
-- seed 16개 중 16개를 작품·part 에 잇고, 0개를 숨기고, 0개는 그대로 둔다.

-- Op. 25 2 Etude-Fantasies for Piano Op. 25

UPDATE pieces piece
SET piece.title = '2 Etude-Fantasies for Piano Op. 25', piece.title_en = '2 Etude-Fantasies for Piano, op. 25',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = 'Op.', piece.catalogue_number = '25',
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 17735 AND piece.composer_id = 245
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'Etude-Fantaisie in G minor, op. 25 no. 1', part.name_en = 'Etude-Fantaisie in G minor, op. 25 no. 1',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 17735 AND p.composer_id = 245 AND part.part_key = 'musicbrainz:b3cba136-9f15-438d-935d-3f39141320ae' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:b3cba136-9f15-438d-935d-3f39141320ae', 1, NULL, 'Etude-Fantaisie in G minor, op. 25 no. 1', 'Etude-Fantaisie in G minor, op. 25 no. 1', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 17735 AND p.composer_id = 245
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:b3cba136-9f15-438d-935d-3f39141320ae'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'Etude-Fantasie in E-flat minor, op. 25 no. 2', part.name_en = 'Etude-Fantasie in E-flat minor, op. 25 no. 2',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 17735 AND p.composer_id = 245 AND part.part_key = 'musicbrainz:3ed858c2-8595-46e9-8b92-d6ea2e0b4c6b' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:3ed858c2-8595-46e9-8b92-d6ea2e0b4c6b', 2, NULL, 'Etude-Fantasie in E-flat minor, op. 25 no. 2', 'Etude-Fantasie in E-flat minor, op. 25 no. 2', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 17735 AND p.composer_id = 245
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:3ed858c2-8595-46e9-8b92-d6ea2e0b4c6b'
);


-- Op. 29 2개의 연습곡 Op. 29

UPDATE pieces piece
SET piece.title = '2개의 연습곡 Op. 29', piece.title_en = '2 Etudes for Piano, op. 29',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = 'Op.', piece.catalogue_number = '29',
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 18921 AND piece.composer_id = 245
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'D단조', part.name_en = 'Etude in D minor, op. 29 no. 1',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 18921 AND p.composer_id = 245 AND part.part_key = 'musicbrainz:ddaabe86-c6d3-49c7-8593-467c57cca24f' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:ddaabe86-c6d3-49c7-8593-467c57cca24f', 1, NULL, 'D단조', 'Etude in D minor, op. 29 no. 1', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 18921 AND p.composer_id = 245
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:ddaabe86-c6d3-49c7-8593-467c57cca24f'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'A장조', part.name_en = 'Etude in A major, op. 29 no. 2',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 18921 AND p.composer_id = 245 AND part.part_key = 'musicbrainz:24803f87-8a07-4ce7-8105-066283058137' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:24803f87-8a07-4ce7-8105-066283058137', 2, NULL, 'A장조', 'Etude in A major, op. 29 no. 2', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 18921 AND p.composer_id = 245
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:24803f87-8a07-4ce7-8105-066283058137'
);


-- Op. 3 3개의 연습곡 Op. 3

UPDATE pieces piece
SET piece.title = '3개의 연습곡 Op. 3', piece.title_en = '3 Etudes for Piano, op. 3',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = 'Op.', piece.catalogue_number = '3',
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 18480 AND piece.composer_id = 245
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'D♭장조', part.name_en = 'Etude in D-flat major, op. 3 no. 1',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 18480 AND p.composer_id = 245 AND part.part_key = 'musicbrainz:de89b558-6739-4569-a99b-0f0849fab512' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:de89b558-6739-4569-a99b-0f0849fab512', 1, NULL, 'D♭장조', 'Etude in D-flat major, op. 3 no. 1', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 18480 AND p.composer_id = 245
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:de89b558-6739-4569-a99b-0f0849fab512'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'E단조', part.name_en = 'Etude in E minor, op. 3 no. 2',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 18480 AND p.composer_id = 245 AND part.part_key = 'musicbrainz:a4a7623c-977f-460d-aa2f-ca32312cc7a5' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:a4a7623c-977f-460d-aa2f-ca32312cc7a5', 2, NULL, 'E단조', 'Etude in E minor, op. 3 no. 2', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 18480 AND p.composer_id = 245
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:a4a7623c-977f-460d-aa2f-ca32312cc7a5'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = NULL,
    part.name_ko = 'A단조', part.name_en = 'Etude in A minor, op. 3 no. 3',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 18480 AND p.composer_id = 245 AND part.part_key = 'musicbrainz:f6a353ab-7879-4691-a60b-5c3cdc6ffda8' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:f6a353ab-7879-4691-a60b-5c3cdc6ffda8', 3, NULL, 'A단조', 'Etude in A minor, op. 3 no. 3', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 18480 AND p.composer_id = 245
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:f6a353ab-7879-4691-a60b-5c3cdc6ffda8'
);


-- Op. 44 4개의 연습곡 Op. 44

UPDATE pieces piece
SET piece.title = '4개의 연습곡 Op. 44', piece.title_en = '4 Etudes for Piano, op. 44',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = 'Op.', piece.catalogue_number = '44',
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 19153 AND piece.composer_id = 245
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'G♭장조', part.name_en = 'Etude in G-flat major, op. 44 no. 1',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 19153 AND p.composer_id = 245 AND part.part_key = 'musicbrainz:ee1a6ab3-8b9c-4c46-a275-bb2771ae166f' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:ee1a6ab3-8b9c-4c46-a275-bb2771ae166f', 1, NULL, 'G♭장조', 'Etude in G-flat major, op. 44 no. 1', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 19153 AND p.composer_id = 245
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:ee1a6ab3-8b9c-4c46-a275-bb2771ae166f'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'D♭장조', part.name_en = 'Etude in D-flat major, op. 44 no. 2',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 19153 AND p.composer_id = 245 AND part.part_key = 'musicbrainz:18f14b09-4859-4b58-a47f-f6080dae7a8e' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:18f14b09-4859-4b58-a47f-f6080dae7a8e', 2, NULL, 'D♭장조', 'Etude in D-flat major, op. 44 no. 2', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 19153 AND p.composer_id = 245
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:18f14b09-4859-4b58-a47f-f6080dae7a8e'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = NULL,
    part.name_ko = 'E단조', part.name_en = 'Etude in E minor, op. 44 no. 3',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 19153 AND p.composer_id = 245 AND part.part_key = 'musicbrainz:a467c1a3-31e3-4a7f-b156-5159fb36f1a4' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:a467c1a3-31e3-4a7f-b156-5159fb36f1a4', 3, NULL, 'E단조', 'Etude in E minor, op. 44 no. 3', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 19153 AND p.composer_id = 245
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:a467c1a3-31e3-4a7f-b156-5159fb36f1a4'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = NULL,
    part.name_ko = 'A단조', part.name_en = 'Etude in A minor, op. 44 no. 4',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 19153 AND p.composer_id = 245 AND part.part_key = 'musicbrainz:24bd13c3-c659-427d-ba55-b93bf6ac76b6' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:24bd13c3-c659-427d-ba55-b93bf6ac76b6', 4, NULL, 'A단조', 'Etude in A minor, op. 44 no. 4', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 19153 AND p.composer_id = 245
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:24bd13c3-c659-427d-ba55-b93bf6ac76b6'
);


-- Op. 2 4 morceaux Op. 2

UPDATE pieces piece
SET piece.title = '4 morceaux Op. 2', piece.title_en = '4 morceaux, op. 2',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = 'Op.', piece.catalogue_number = '2',
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 16065 AND piece.composer_id = 245
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'A장조', part.name_en = 'Etude in A major, op. 2 no. 1',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 16065 AND p.composer_id = 245 AND part.part_key = 'musicbrainz:f52e9f16-1ee9-458d-b32b-77655ac59800' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:f52e9f16-1ee9-458d-b32b-77655ac59800', 1, NULL, 'A장조', 'Etude in A major, op. 2 no. 1', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 16065 AND p.composer_id = 245
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:f52e9f16-1ee9-458d-b32b-77655ac59800'
);


-- Op. 7 Allegro de concert in A major

UPDATE pieces piece
SET piece.title = 'Allegro de concert in A major', piece.title_en = 'Allegro de concert in A major, op. 7',
    piece.type = 'song', piece.opus_number = 'Op. 7',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 19873 AND piece.composer_id = 245
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- Op. 40 Cloches

UPDATE pieces piece
SET piece.title = 'Cloches', piece.title_en = 'Cloches, op. 40',
    piece.type = 'album', piece.opus_number = 'Op. 40',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 17999 AND piece.composer_id = 245
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'Cloches et clochettes', part.name_en = 'Cloches, op. 40: I. Cloches et clochettes',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 17999 AND p.composer_id = 245 AND part.part_key = 'musicbrainz:4f724613-9081-475d-bd07-b2d3b18f5ec1' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:4f724613-9081-475d-bd07-b2d3b18f5ec1', 1, 'I', 'Cloches et clochettes', 'Cloches, op. 40: I. Cloches et clochettes', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 17999 AND p.composer_id = 245
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:4f724613-9081-475d-bd07-b2d3b18f5ec1'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'Glas funèbre', part.name_en = 'Cloches, op. 40: II. Glas funèbre',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 17999 AND p.composer_id = 245 AND part.part_key = 'musicbrainz:ba5db48d-32dc-461b-a3f2-912b2d06a6e2' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:ba5db48d-32dc-461b-a3f2-912b2d06a6e2', 2, 'II', 'Glas funèbre', 'Cloches, op. 40: II. Glas funèbre', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 17999 AND p.composer_id = 245
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:ba5db48d-32dc-461b-a3f2-912b2d06a6e2'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = 'Cloches triomphales', part.name_en = 'Cloches, op. 40: III. Cloches triomphales',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 17999 AND p.composer_id = 245 AND part.part_key = 'musicbrainz:6cbc9027-86dd-475f-b4f4-4a97ae833825' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:6cbc9027-86dd-475f-b4f4-4a97ae833825', 3, 'III', 'Cloches triomphales', 'Cloches, op. 40: III. Cloches triomphales', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 17999 AND p.composer_id = 245
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:6cbc9027-86dd-475f-b4f4-4a97ae833825'
);


-- Op. 19 Deux morceaux pour violoncelle et piano Op. 19

UPDATE pieces piece
SET piece.title = 'Deux morceaux pour violoncelle et piano Op. 19', piece.title_en = 'Deux morceaux pour violoncelle et piano, op. 19',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = 'Op.', piece.catalogue_number = '19',
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 19041 AND piece.composer_id = 245
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'Élégie, op. 19 no. 1', part.name_en = 'Élégie, op. 19 no. 1',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 19041 AND p.composer_id = 245 AND part.part_key = 'musicbrainz:6d96899b-1e0a-402d-8b17-8fa649007553' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:6d96899b-1e0a-402d-8b17-8fa649007553', 1, NULL, 'Élégie, op. 19 no. 1', 'Élégie, op. 19 no. 1', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 19041 AND p.composer_id = 245
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:6d96899b-1e0a-402d-8b17-8fa649007553'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'Capriccioso, op. 19 no. 2', part.name_en = 'Capriccioso, op. 19 no. 2',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 19041 AND p.composer_id = 245 AND part.part_key = 'musicbrainz:7f9c27d1-4a8c-4899-8b69-1886efd5eb98' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:7f9c27d1-4a8c-4899-8b69-1886efd5eb98', 2, NULL, 'Capriccioso, op. 19 no. 2', 'Capriccioso, op. 19 no. 2', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 19041 AND p.composer_id = 245
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:7f9c27d1-4a8c-4899-8b69-1886efd5eb98'
);


-- Op. 24 Etude de concert in F-sharp minor

UPDATE pieces piece
SET piece.title = 'Etude de concert in F-sharp minor', piece.title_en = 'Etude de concert in F-sharp minor, op. 24',
    piece.type = 'song', piece.opus_number = 'Op. 24',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 16125 AND piece.composer_id = 245
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- Op. 36 연습곡 A♭장조

UPDATE pieces piece
SET piece.title = '연습곡 A♭장조', piece.title_en = 'Etude in A-flat major pour la main gauche seule, op. 36',
    piece.type = 'song', piece.opus_number = 'Op. 36',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 17342 AND piece.composer_id = 245
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- Op. 54 연습곡 F♯장조

UPDATE pieces piece
SET piece.title = '연습곡 F♯장조', piece.title_en = 'Etude in F-sharp major, op. 54',
    piece.type = 'song', piece.opus_number = 'Op. 54',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 18505 AND piece.composer_id = 245
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None 연습곡 "Sur Mer"

UPDATE pieces piece
SET piece.title = '연습곡 "Sur Mer"', piece.title_en = 'Etude, op. 14 "Sur Mer"',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 16012 AND piece.composer_id = 245
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- Op. 48 Etude-Fantasie in F minor

UPDATE pieces piece
SET piece.title = 'Etude-Fantasie in F minor', piece.title_en = 'Etude-Fantasie in F minor, op. 48',
    piece.type = 'song', piece.opus_number = 'Op. 48',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 16307 AND piece.composer_id = 245
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- Op. 31 Suite polonaise no. 2

UPDATE pieces piece
SET piece.title = 'Suite polonaise no. 2', piece.title_en = 'Suite polonaise no. 2, op. 31',
    piece.type = 'album', piece.opus_number = 'Op. 31',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 20045 AND piece.composer_id = 245
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'Krakowiak', part.name_en = 'Suite polonaise no. 2, op. 31: I. Krakowiak',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 20045 AND p.composer_id = 245 AND part.part_key = 'musicbrainz:7892b1fa-2499-4730-b67e-1ce3d57d20e0' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:7892b1fa-2499-4730-b67e-1ce3d57d20e0', 1, 'I', 'Krakowiak', 'Suite polonaise no. 2, op. 31: I. Krakowiak', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 20045 AND p.composer_id = 245
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:7892b1fa-2499-4730-b67e-1ce3d57d20e0'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'Kujawiak', part.name_en = 'Suite polonaise no. 2, op. 31: II. Kujawiak',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 20045 AND p.composer_id = 245 AND part.part_key = 'musicbrainz:b0353a9b-1baf-4d8a-a6e5-f7438cca9257' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:b0353a9b-1baf-4d8a-a6e5-f7438cca9257', 2, 'II', 'Kujawiak', 'Suite polonaise no. 2, op. 31: II. Kujawiak', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 20045 AND p.composer_id = 245
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:b0353a9b-1baf-4d8a-a6e5-f7438cca9257'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = 'Mazourka', part.name_en = 'Suite polonaise no. 2, op. 31: III. Mazourka',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 20045 AND p.composer_id = 245 AND part.part_key = 'musicbrainz:6932bfc2-5f69-4320-a855-ecd0dd8ccf86' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:6932bfc2-5f69-4320-a855-ecd0dd8ccf86', 3, 'III', 'Mazourka', 'Suite polonaise no. 2, op. 31: III. Mazourka', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 20045 AND p.composer_id = 245
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:6932bfc2-5f69-4320-a855-ecd0dd8ccf86'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = 'IV',
    part.name_ko = 'Polonaise', part.name_en = 'Suite polonaise no. 2, op. 31: IV. Polonaise',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 20045 AND p.composer_id = 245 AND part.part_key = 'musicbrainz:c89a7f08-4025-4ad4-ae3d-5f44c0a28ff0' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:c89a7f08-4025-4ad4-ae3d-5f44c0a28ff0', 4, 'IV', 'Polonaise', 'Suite polonaise no. 2, op. 31: IV. Polonaise', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 20045 AND p.composer_id = 245
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:c89a7f08-4025-4ad4-ae3d-5f44c0a28ff0'
);


-- None 교향곡 C단조 "To the Dear Beloved"

UPDATE pieces piece
SET piece.title = '교향곡 C단조 "To the Dear Beloved"', piece.title_en = 'Symphony in C minor, op. 39 "To the Dear Beloved"',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 16190 AND piece.composer_id = 245
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'Adagio', part.name_en = 'Symphony in C minor, op. 39 "To the Dear Beloved": I. Adagio',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 16190 AND p.composer_id = 245 AND part.part_key = 'musicbrainz:d8bbd286-1745-483d-be8c-0cdc6547a97a' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:d8bbd286-1745-483d-be8c-0cdc6547a97a', 1, 'I', 'Adagio', 'Symphony in C minor, op. 39 "To the Dear Beloved": I. Adagio', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 16190 AND p.composer_id = 245
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:d8bbd286-1745-483d-be8c-0cdc6547a97a'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'Larghetto', part.name_en = 'Symphony in C minor, op. 39 "To the Dear Beloved": II. Larghetto',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 16190 AND p.composer_id = 245 AND part.part_key = 'musicbrainz:f4dee57e-cc68-43aa-8539-f8b903b2f7bd' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:f4dee57e-cc68-43aa-8539-f8b903b2f7bd', 2, 'II', 'Larghetto', 'Symphony in C minor, op. 39 "To the Dear Beloved": II. Larghetto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 16190 AND p.composer_id = 245
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:f4dee57e-cc68-43aa-8539-f8b903b2f7bd'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = 'Allegro', part.name_en = 'Symphony in C minor, op. 39 "To the Dear Beloved": III. Allegro',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 16190 AND p.composer_id = 245 AND part.part_key = 'musicbrainz:a889678d-bb1f-481f-a774-d66ec63ee76b' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:a889678d-bb1f-481f-a774-d66ec63ee76b', 3, 'III', 'Allegro', 'Symphony in C minor, op. 39 "To the Dear Beloved": III. Allegro', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 16190 AND p.composer_id = 245
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:a889678d-bb1f-481f-a774-d66ec63ee76b'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = 'IV',
    part.name_ko = 'Epilogue', part.name_en = 'Symphony in C minor, op. 39 "To the Dear Beloved": IV. Epilogue',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 16190 AND p.composer_id = 245 AND part.part_key = 'musicbrainz:1400847c-c101-46d0-8e41-8ae2c5ef5c24' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:1400847c-c101-46d0-8e41-8ae2c5ef5c24', 4, 'IV', 'Epilogue', 'Symphony in C minor, op. 39 "To the Dear Beloved": IV. Epilogue', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 16190 AND p.composer_id = 245
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:1400847c-c101-46d0-8e41-8ae2c5ef5c24'
);


-- Op. 4 Valse-Etude in F major

UPDATE pieces piece
SET piece.title = 'Valse-Etude in F major', piece.title_en = 'Valse-Etude in F major, op. 4',
    piece.type = 'song', piece.opus_number = 'Op. 4',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 17867 AND piece.composer_id = 245
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

-- 숨길 seed 작품 없음

-- ===== Tyondai Braxton (composer_id 246) =====
-- 작품을 MusicBrainz 작품 구조로 다시 짠다(6차 자동). 작품 7개(묶음 1, 다악장 0, 낱곡 6),
-- 새 작품 1개, part 4개, 그 아래 0개.
-- seed 6개 중 6개를 작품·part 에 잇고, 0개를 숨기고, 0개는 그대로 둔다.

-- None ArpRec1

UPDATE pieces piece
SET piece.title = 'ArpRec1', piece.title_en = 'ArpRec1',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 20062 AND piece.composer_id = 246
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Casino Trem

UPDATE pieces piece
SET piece.title = 'Casino Trem', piece.title_en = 'Casino Trem',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 17818 AND piece.composer_id = 246
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Piiano

UPDATE pieces piece
SET piece.title = 'Piiano', piece.title_en = 'Piiano',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 17205 AND piece.composer_id = 246
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Platinum Rows

UPDATE pieces piece
SET piece.title = 'Platinum Rows', piece.title_en = 'Platinum Rows',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 19684 AND piece.composer_id = 246
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Sunny X

UPDATE pieces piece
SET piece.title = 'Sunny X', piece.title_en = 'Sunny X',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 17185 AND piece.composer_id = 246
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Uffe's Woodshop

UPDATE pieces piece
SET piece.title = 'Uffe''s Woodshop', piece.title_en = 'Uffe''s Woodshop',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 16951 AND piece.composer_id = 246
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Telekinesis

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, 'Telekinesis', 'Telekinesis', 'album', NULL, NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 246
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = 'Telekinesis'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '444e814a-c461-4483-8d0f-46023e22b44c'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '444e814a-c461-4483-8d0f-46023e22b44c'
FROM pieces p
WHERE p.composer_id = 246 AND p.title = 'Telekinesis' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '444e814a-c461-4483-8d0f-46023e22b44c'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:3a709a5a-9f8b-45bd-93aa-4a1e9c335545', 1, NULL, 'TK1_Overshare', 'TK1_Overshare', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 246 AND p.title = 'Telekinesis' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:3a709a5a-9f8b-45bd-93aa-4a1e9c335545'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:764a0717-6a1e-4fca-b868-f531fb35012e', 2, NULL, 'TK4_Overgrowth', 'TK4_Overgrowth', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 246 AND p.title = 'Telekinesis' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:764a0717-6a1e-4fca-b868-f531fb35012e'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:81ee0092-a8c1-4569-89f9-4b7c38fe8918', 3, NULL, 'TK2_Wavefolder', 'TK2_Wavefolder', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 246 AND p.title = 'Telekinesis' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:81ee0092-a8c1-4569-89f9-4b7c38fe8918'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:fd627073-fea3-45ef-af0e-8282976dcfb0', 4, NULL, 'TK3_FloatingLake', 'TK3_FloatingLake', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 246 AND p.title = 'Telekinesis' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:fd627073-fea3-45ef-af0e-8282976dcfb0'
);

-- 숨길 seed 작품 없음

-- ===== Paule Maurice (composer_id 247) =====
-- 작품을 MusicBrainz 작품 구조로 다시 짠다(6차 자동). 작품 1개(묶음 0, 다악장 1, 낱곡 0),
-- 새 작품 0개, part 5개, 그 아래 0개.
-- seed 1개 중 1개를 작품·part 에 잇고, 0개를 숨기고, 0개는 그대로 둔다.

-- None Tableaux de Provence

UPDATE pieces piece
SET piece.title = 'Tableaux de Provence', piece.title_en = 'Tableaux de Provence',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 17782 AND piece.composer_id = 247
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'Farandole des jeunes filles', part.name_en = 'Tableaux de Provence: I. Farandole des jeunes filles',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 17782 AND p.composer_id = 247 AND part.part_key = 'musicbrainz:b2ed7990-f49d-4e47-ab69-bd077edf6265' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:b2ed7990-f49d-4e47-ab69-bd077edf6265', 1, 'I', 'Farandole des jeunes filles', 'Tableaux de Provence: I. Farandole des jeunes filles', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 17782 AND p.composer_id = 247
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:b2ed7990-f49d-4e47-ab69-bd077edf6265'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'Chanson pour ma mie', part.name_en = 'Tableaux de Provence: II. Chanson pour ma mie',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 17782 AND p.composer_id = 247 AND part.part_key = 'musicbrainz:8d40fea0-5fc9-4707-93ad-cb17f742f546' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:8d40fea0-5fc9-4707-93ad-cb17f742f546', 2, 'II', 'Chanson pour ma mie', 'Tableaux de Provence: II. Chanson pour ma mie', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 17782 AND p.composer_id = 247
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:8d40fea0-5fc9-4707-93ad-cb17f742f546'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = 'La Bohémienne', part.name_en = 'Tableaux de Provence: III. La Bohémienne',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 17782 AND p.composer_id = 247 AND part.part_key = 'musicbrainz:3c3e7a92-be49-4458-b160-cc1fba900811' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:3c3e7a92-be49-4458-b160-cc1fba900811', 3, 'III', 'La Bohémienne', 'Tableaux de Provence: III. La Bohémienne', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 17782 AND p.composer_id = 247
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:3c3e7a92-be49-4458-b160-cc1fba900811'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = 'IV',
    part.name_ko = 'Des Alyscamps l''âme soupire', part.name_en = 'Tableaux de Provence: IV. Des Alyscamps l''âme soupire',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 17782 AND p.composer_id = 247 AND part.part_key = 'musicbrainz:153d68b2-8a17-49fe-ad28-c479e0b2ce57' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:153d68b2-8a17-49fe-ad28-c479e0b2ce57', 4, 'IV', 'Des Alyscamps l''âme soupire', 'Tableaux de Provence: IV. Des Alyscamps l''âme soupire', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 17782 AND p.composer_id = 247
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:153d68b2-8a17-49fe-ad28-c479e0b2ce57'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 5, part.movement_number = 'V',
    part.name_ko = 'Le Cabridan', part.name_en = 'Tableaux de Provence: V. Le Cabridan',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 17782 AND p.composer_id = 247 AND part.part_key = 'musicbrainz:12875413-7538-4f0c-92a5-bfebed43c01d' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:12875413-7538-4f0c-92a5-bfebed43c01d', 5, 'V', 'Le Cabridan', 'Tableaux de Provence: V. Le Cabridan', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 17782 AND p.composer_id = 247
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:12875413-7538-4f0c-92a5-bfebed43c01d'
);

-- 숨길 seed 작품 없음

-- ===== Denis Gougeon (composer_id 248) =====
-- 작품을 MusicBrainz 작품 구조로 다시 짠다(6차 자동). 작품 6개(묶음 0, 다악장 1, 낱곡 5),
-- 새 작품 0개, part 10개, 그 아래 0개.
-- seed 6개 중 6개를 작품·part 에 잇고, 0개를 숨기고, 0개는 그대로 둔다.

-- None Alto Neptune

UPDATE pieces piece
SET piece.title = 'Alto Neptune', piece.title_en = 'Alto Neptune',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 20085 AND piece.composer_id = 248
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Clere Vénus

UPDATE pieces piece
SET piece.title = 'Clere Vénus', piece.title_en = 'Clere Vénus',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 19737 AND piece.composer_id = 248
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Lamento - Scherzo

UPDATE pieces piece
SET piece.title = 'Lamento - Scherzo', piece.title_en = 'Lamento - Scherzo',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 16546 AND piece.composer_id = 248
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Mutation

UPDATE pieces piece
SET piece.title = 'Mutation', piece.title_en = 'Mutation',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 16214 AND piece.composer_id = 248
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Six thèmes-solaires

UPDATE pieces piece
SET piece.title = 'Six thèmes-solaires', piece.title_en = 'Six thèmes-solaires',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 17097 AND piece.composer_id = 248
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'Piano-soleil', part.name_en = 'Six thèmes-solaires: I. Piano-soleil',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 17097 AND p.composer_id = 248 AND part.part_key = 'musicbrainz:dd134f15-7d99-417a-927c-f9be65c6f282' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:dd134f15-7d99-417a-927c-f9be65c6f282', 1, 'I', 'Piano-soleil', 'Six thèmes-solaires: I. Piano-soleil', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 17097 AND p.composer_id = 248
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:dd134f15-7d99-417a-927c-f9be65c6f282'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'Saxophone-mercure', part.name_en = 'Six thèmes-solaires: II. Saxophone-mercure',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 17097 AND p.composer_id = 248 AND part.part_key = 'musicbrainz:55f3cff8-80ec-4f71-98b1-4808e3bf3040' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:55f3cff8-80ec-4f71-98b1-4808e3bf3040', 2, 'II', 'Saxophone-mercure', 'Six thèmes-solaires: II. Saxophone-mercure', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 17097 AND p.composer_id = 248
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:55f3cff8-80ec-4f71-98b1-4808e3bf3040'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = 'Voix-vénus', part.name_en = 'Six thèmes-solaires: III. Voix-vénus',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 17097 AND p.composer_id = 248 AND part.part_key = 'musicbrainz:4fc092b0-43e0-4248-88e8-c8666d6279cf' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:4fc092b0-43e0-4248-88e8-c8666d6279cf', 3, 'III', 'Voix-vénus', 'Six thèmes-solaires: III. Voix-vénus', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 17097 AND p.composer_id = 248
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:4fc092b0-43e0-4248-88e8-c8666d6279cf'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = 'IV',
    part.name_ko = 'Clarinette-terre', part.name_en = 'Six thèmes-solaires: IV. Clarinette-terre',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 17097 AND p.composer_id = 248 AND part.part_key = 'musicbrainz:2eac8d82-77ed-4a45-90be-3f858beaac2b' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:2eac8d82-77ed-4a45-90be-3f858beaac2b', 4, 'IV', 'Clarinette-terre', 'Six thèmes-solaires: IV. Clarinette-terre', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 17097 AND p.composer_id = 248
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:2eac8d82-77ed-4a45-90be-3f858beaac2b'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 5, part.movement_number = 'V',
    part.name_ko = 'Trompette-mars', part.name_en = 'Six thèmes-solaires: V. Trompette-mars',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 17097 AND p.composer_id = 248 AND part.part_key = 'musicbrainz:e2c39a51-3d1b-494a-8125-df1f9fed58d5' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:e2c39a51-3d1b-494a-8125-df1f9fed58d5', 5, 'V', 'Trompette-mars', 'Six thèmes-solaires: V. Trompette-mars', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 17097 AND p.composer_id = 248
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:e2c39a51-3d1b-494a-8125-df1f9fed58d5'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 6, part.movement_number = 'VI',
    part.name_ko = 'Cor-jupiter', part.name_en = 'Six thèmes-solaires: VI. Cor-jupiter',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 17097 AND p.composer_id = 248 AND part.part_key = 'musicbrainz:f5affea1-ecee-40cc-aa87-2af795fbcbe8' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:f5affea1-ecee-40cc-aa87-2af795fbcbe8', 6, 'VI', 'Cor-jupiter', 'Six thèmes-solaires: VI. Cor-jupiter', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 17097 AND p.composer_id = 248
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:f5affea1-ecee-40cc-aa87-2af795fbcbe8'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 7, part.movement_number = 'VII',
    part.name_ko = 'Flûte-saturne', part.name_en = 'Six thèmes-solaires: VII. Flûte-saturne',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 17097 AND p.composer_id = 248 AND part.part_key = 'musicbrainz:59babb94-d4f6-4eb2-ae02-d19bbb5568fe' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:59babb94-d4f6-4eb2-ae02-d19bbb5568fe', 7, 'VII', 'Flûte-saturne', 'Six thèmes-solaires: VII. Flûte-saturne', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 17097 AND p.composer_id = 248
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:59babb94-d4f6-4eb2-ae02-d19bbb5568fe'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 8, part.movement_number = 'VIII',
    part.name_ko = 'Violon-uranus', part.name_en = 'Six thèmes-solaires: VIII. Violon-uranus',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 17097 AND p.composer_id = 248 AND part.part_key = 'musicbrainz:ee454691-9dd7-4510-a004-5a0a4ffb66b7' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:ee454691-9dd7-4510-a004-5a0a4ffb66b7', 8, 'VIII', 'Violon-uranus', 'Six thèmes-solaires: VIII. Violon-uranus', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 17097 AND p.composer_id = 248
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:ee454691-9dd7-4510-a004-5a0a4ffb66b7'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 9, part.movement_number = 'IX',
    part.name_ko = 'Alto-neptune', part.name_en = 'Six thèmes-solaires: IX. Alto-neptune',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 17097 AND p.composer_id = 248 AND part.part_key = 'musicbrainz:4db68348-4c57-4da2-8792-c3df3adfa67d' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:4db68348-4c57-4da2-8792-c3df3adfa67d', 9, 'IX', 'Alto-neptune', 'Six thèmes-solaires: IX. Alto-neptune', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 17097 AND p.composer_id = 248
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:4db68348-4c57-4da2-8792-c3df3adfa67d'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 10, part.movement_number = 'X',
    part.name_ko = 'Violoncelle-pluton', part.name_en = 'Six thèmes-solaires: X. Violoncelle-pluton',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 17097 AND p.composer_id = 248 AND part.part_key = 'musicbrainz:3779aa6a-f508-488c-94ee-40488d2e24f6' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:3779aa6a-f508-488c-94ee-40488d2e24f6', 10, 'X', 'Violoncelle-pluton', 'Six thèmes-solaires: X. Violoncelle-pluton', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 17097 AND p.composer_id = 248
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:3779aa6a-f508-488c-94ee-40488d2e24f6'
);


-- None Une petite musique de nuit d'été

UPDATE pieces piece
SET piece.title = 'Une petite musique de nuit d''été', piece.title_en = 'Une petite musique de nuit d''été',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 16606 AND piece.composer_id = 248
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

-- 숨길 seed 작품 없음

-- ===== Jan Blockx (composer_id 249) =====
-- 작품을 MusicBrainz 작품 구조로 다시 짠다(6차 자동). 작품 4개(묶음 1, 다악장 0, 낱곡 3),
-- 새 작품 0개, part 5개, 그 아래 0개.
-- seed 5개 중 4개를 작품·part 에 잇고, 1개를 숨기고, 0개는 그대로 둔다.

-- None Ave verum

UPDATE pieces piece
SET piece.title = 'Ave verum', piece.title_en = 'Ave verum',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 16009 AND piece.composer_id = 249
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None 발레 <Milenka>

UPDATE pieces piece
SET piece.title = '발레 <Milenka>', piece.title_en = 'Milenka',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 19718 AND piece.composer_id = 249
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Triptyque symphonique

UPDATE pieces piece
SET piece.title = 'Triptyque symphonique', piece.title_en = 'Triptyque symphonique',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 15817 AND piece.composer_id = 249
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- Op. 26 Vlaamsche dansen Op. 26

UPDATE pieces piece
SET piece.title = 'Vlaamsche dansen Op. 26', piece.title_en = 'Vlaamsche dansen, op. 26',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = 'Op.', piece.catalogue_number = '26',
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 17788 AND piece.composer_id = 249
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'I', part.name_en = 'Vlaamsche dansen, op. 26: I.',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 17788 AND p.composer_id = 249 AND part.part_key = 'musicbrainz:db9948e2-0f6c-4227-a0ca-bef09c37100d' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:db9948e2-0f6c-4227-a0ca-bef09c37100d', 1, NULL, 'I', 'Vlaamsche dansen, op. 26: I.', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 17788 AND p.composer_id = 249
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:db9948e2-0f6c-4227-a0ca-bef09c37100d'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'II', part.name_en = 'Vlaamsche dansen, op. 26: II.',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 17788 AND p.composer_id = 249 AND part.part_key = 'musicbrainz:b8900465-5104-4953-942d-438f20879e3e' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:b8900465-5104-4953-942d-438f20879e3e', 2, NULL, 'II', 'Vlaamsche dansen, op. 26: II.', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 17788 AND p.composer_id = 249
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:b8900465-5104-4953-942d-438f20879e3e'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = NULL,
    part.name_ko = 'III', part.name_en = 'Vlaamsche dansen, op. 26: III.',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 17788 AND p.composer_id = 249 AND part.part_key = 'musicbrainz:e647306e-f4c0-4ff1-9c25-58f855055aa1' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:e647306e-f4c0-4ff1-9c25-58f855055aa1', 3, NULL, 'III', 'Vlaamsche dansen, op. 26: III.', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 17788 AND p.composer_id = 249
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:e647306e-f4c0-4ff1-9c25-58f855055aa1'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = NULL,
    part.name_ko = 'IV', part.name_en = 'Vlaamsche dansen, op. 26: IV.',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 17788 AND p.composer_id = 249 AND part.part_key = 'musicbrainz:ee2914d2-32d1-47f9-9d46-0aa9366d7299' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:ee2914d2-32d1-47f9-9d46-0aa9366d7299', 4, NULL, 'IV', 'Vlaamsche dansen, op. 26: IV.', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 17788 AND p.composer_id = 249
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:ee2914d2-32d1-47f9-9d46-0aa9366d7299'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 5, part.movement_number = NULL,
    part.name_ko = 'V', part.name_en = 'Vlaamsche dansen, op. 26: V.',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 17788 AND p.composer_id = 249 AND part.part_key = 'musicbrainz:a95bee30-40ad-409a-acf3-c5f91e5c4d9a' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:a95bee30-40ad-409a-acf3-c5f91e5c4d9a', 5, NULL, 'V', 'Vlaamsche dansen, op. 26: V.', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 17788 AND p.composer_id = 249
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:a95bee30-40ad-409a-acf3-c5f91e5c4d9a'
);

-- 카탈로그에 대응이 없는 seed 작품 1개를 목록에서 숨긴다(지우지 않음).
UPDATE pieces piece
SET piece.hidden_reason = 'catalog_unmatched'
WHERE piece.composer_id = 249 AND piece.origin = 'seed' AND piece.hidden_reason IS NULL
  AND piece.id IN (
    19567
  )
  AND NOT EXISTS (SELECT 1 FROM performance_sectors sector WHERE sector.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM piece_parts linking WHERE linking.linked_piece_id = piece.id);

-- ===== Albert Guinovart i Mingacho (composer_id 251) =====
-- 작품을 MusicBrainz 작품 구조로 다시 짠다(6차 자동). 작품 4개(묶음 2, 다악장 0, 낱곡 2),
-- 새 작품 0개, part 22개, 그 아래 0개.
-- seed 4개 중 4개를 작품·part 에 잇고, 0개를 숨기고, 0개는 그대로 둔다.

-- None 칸타타 <Arion i el dofí>

UPDATE pieces piece
SET piece.title = '칸타타 <Arion i el dofí>', piece.title_en = 'Arion i el dofí',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 17300 AND piece.composer_id = 251
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'Preludi', part.name_en = 'Arion i el dofí: Preludi',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 17300 AND p.composer_id = 251 AND part.part_key = 'musicbrainz:0ae0b8b5-15cf-48ef-b523-08afce8950b2' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:0ae0b8b5-15cf-48ef-b523-08afce8950b2', 1, NULL, 'Preludi', 'Arion i el dofí: Preludi', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 17300 AND p.composer_id = 251
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:0ae0b8b5-15cf-48ef-b523-08afce8950b2'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'Introducció', part.name_en = 'Arion i el dofí: Introducció',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 17300 AND p.composer_id = 251 AND part.part_key = 'musicbrainz:ed680328-3f3a-401e-a210-548185f7d452' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:ed680328-3f3a-401e-a210-548185f7d452', 2, NULL, 'Introducció', 'Arion i el dofí: Introducció', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 17300 AND p.composer_id = 251
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:ed680328-3f3a-401e-a210-548185f7d452'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = NULL,
    part.name_ko = 'Obertura', part.name_en = 'Arion i el dofí: Obertura',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 17300 AND p.composer_id = 251 AND part.part_key = 'musicbrainz:c196c8ab-3972-4443-8283-2907a3a30d27' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:c196c8ab-3972-4443-8283-2907a3a30d27', 3, NULL, 'Obertura', 'Arion i el dofí: Obertura', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 17300 AND p.composer_id = 251
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:c196c8ab-3972-4443-8283-2907a3a30d27'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = NULL,
    part.name_ko = 'El poeta Arion', part.name_en = 'Arion i el dofí: El poeta Arion',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 17300 AND p.composer_id = 251 AND part.part_key = 'musicbrainz:4e3540c9-2895-4846-ad21-2a1bceba8fa5' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:4e3540c9-2895-4846-ad21-2a1bceba8fa5', 4, NULL, 'El poeta Arion', 'Arion i el dofí: El poeta Arion', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 17300 AND p.composer_id = 251
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:4e3540c9-2895-4846-ad21-2a1bceba8fa5'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 5, part.movement_number = NULL,
    part.name_ko = 'Cançó d''Arion', part.name_en = 'Arion i el dofí: Cançó d''Arion',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 17300 AND p.composer_id = 251 AND part.part_key = 'musicbrainz:446cdd6f-04aa-4d71-b74b-a1c3be1118ec' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:446cdd6f-04aa-4d71-b74b-a1c3be1118ec', 5, NULL, 'Cançó d''Arion', 'Arion i el dofí: Cançó d''Arion', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 17300 AND p.composer_id = 251
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:446cdd6f-04aa-4d71-b74b-a1c3be1118ec'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 6, part.movement_number = NULL,
    part.name_ko = 'Arion a Corint', part.name_en = 'Arion i el dofí: Arion a Corint',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 17300 AND p.composer_id = 251 AND part.part_key = 'musicbrainz:6f39c60e-8711-4661-a54a-30216fc39f50' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:6f39c60e-8711-4661-a54a-30216fc39f50', 6, NULL, 'Arion a Corint', 'Arion i el dofí: Arion a Corint', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 17300 AND p.composer_id = 251
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:6f39c60e-8711-4661-a54a-30216fc39f50'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 7, part.movement_number = NULL,
    part.name_ko = 'Cançó del Rei Periandre', part.name_en = 'Arion i el dofí: Cançó del Rei Periandre',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 17300 AND p.composer_id = 251 AND part.part_key = 'musicbrainz:d8ecaae8-245b-4d14-ac53-fd577cd8991c' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:d8ecaae8-245b-4d14-ac53-fd577cd8991c', 7, NULL, 'Cançó del Rei Periandre', 'Arion i el dofí: Cançó del Rei Periandre', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 17300 AND p.composer_id = 251
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:d8ecaae8-245b-4d14-ac53-fd577cd8991c'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 8, part.movement_number = NULL,
    part.name_ko = 'El viatge a Sicília', part.name_en = 'Arion i el dofí: El viatge a Sicília',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 17300 AND p.composer_id = 251 AND part.part_key = 'musicbrainz:cf9dfcfb-24fb-435b-bf14-5c14ad8082cb' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:cf9dfcfb-24fb-435b-bf14-5c14ad8082cb', 8, NULL, 'El viatge a Sicília', 'Arion i el dofí: El viatge a Sicília', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 17300 AND p.composer_id = 251
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:cf9dfcfb-24fb-435b-bf14-5c14ad8082cb'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 9, part.movement_number = NULL,
    part.name_ko = 'Cançó de la fama d''Arion', part.name_en = 'Arion i el dofí: Cançó de la fama d''Arion',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 17300 AND p.composer_id = 251 AND part.part_key = 'musicbrainz:f55911e6-1461-4f99-bfa6-bc0364d1ab28' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:f55911e6-1461-4f99-bfa6-bc0364d1ab28', 9, NULL, 'Cançó de la fama d''Arion', 'Arion i el dofí: Cançó de la fama d''Arion', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 17300 AND p.composer_id = 251
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:f55911e6-1461-4f99-bfa6-bc0364d1ab28'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 10, part.movement_number = NULL,
    part.name_ko = 'El certamen poètic', part.name_en = 'Arion i el dofí: El certamen poètic',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 17300 AND p.composer_id = 251 AND part.part_key = 'musicbrainz:49a5616e-6c60-483d-ab21-a2d4f095108f' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:49a5616e-6c60-483d-ab21-a2d4f095108f', 10, NULL, 'El certamen poètic', 'Arion i el dofí: El certamen poètic', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 17300 AND p.composer_id = 251
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:49a5616e-6c60-483d-ab21-a2d4f095108f'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 11, part.movement_number = NULL,
    part.name_ko = 'Cançó dels mariners malvats', part.name_en = 'Arion i el dofí: Cançó dels mariners malvats',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 17300 AND p.composer_id = 251 AND part.part_key = 'musicbrainz:00dba3dc-17b5-4459-ac7c-33ffa1948367' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:00dba3dc-17b5-4459-ac7c-33ffa1948367', 11, NULL, 'Cançó dels mariners malvats', 'Arion i el dofí: Cançó dels mariners malvats', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 17300 AND p.composer_id = 251
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:00dba3dc-17b5-4459-ac7c-33ffa1948367'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 12, part.movement_number = NULL,
    part.name_ko = 'El darrer cant', part.name_en = 'Arion i el dofí: El darrer cant',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 17300 AND p.composer_id = 251 AND part.part_key = 'musicbrainz:5b934158-1283-4aeb-9388-82b482e24c26' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:5b934158-1283-4aeb-9388-82b482e24c26', 12, NULL, 'El darrer cant', 'Arion i el dofí: El darrer cant', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 17300 AND p.composer_id = 251
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:5b934158-1283-4aeb-9388-82b482e24c26'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 13, part.movement_number = NULL,
    part.name_ko = 'Lament final d''Arion', part.name_en = 'Arion i el dofí: Lament final d''Arion',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 17300 AND p.composer_id = 251 AND part.part_key = 'musicbrainz:b5fd109e-e831-469f-b2ce-b31d907941a0' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:b5fd109e-e831-469f-b2ce-b31d907941a0', 13, NULL, 'Lament final d''Arion', 'Arion i el dofí: Lament final d''Arion', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 17300 AND p.composer_id = 251
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:b5fd109e-e831-469f-b2ce-b31d907941a0'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 14, part.movement_number = NULL,
    part.name_ko = 'Els dofins i Arion', part.name_en = 'Arion i el dofí: Els dofins i Arion',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 17300 AND p.composer_id = 251 AND part.part_key = 'musicbrainz:4346a31a-4bfc-40b8-b1ba-bc916f8ea3dd' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:4346a31a-4bfc-40b8-b1ba-bc916f8ea3dd', 14, NULL, 'Els dofins i Arion', 'Arion i el dofí: Els dofins i Arion', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 17300 AND p.composer_id = 251
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:4346a31a-4bfc-40b8-b1ba-bc916f8ea3dd'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 15, part.movement_number = NULL,
    part.name_ko = 'Himne dels dofins', part.name_en = 'Arion i el dofí: Himne dels dofins',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 17300 AND p.composer_id = 251 AND part.part_key = 'musicbrainz:a6a104b5-7941-46fb-934b-3235d1e2fa92' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:a6a104b5-7941-46fb-934b-3235d1e2fa92', 15, NULL, 'Himne dels dofins', 'Arion i el dofí: Himne dels dofins', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 17300 AND p.composer_id = 251
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:a6a104b5-7941-46fb-934b-3235d1e2fa92'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 16, part.movement_number = NULL,
    part.name_ko = 'Retorn a Corint', part.name_en = 'Arion i el dofí: Retorn a Corint',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 17300 AND p.composer_id = 251 AND part.part_key = 'musicbrainz:1cdd5443-ba58-49d5-b483-0e70a6bc50b4' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:1cdd5443-ba58-49d5-b483-0e70a6bc50b4', 16, NULL, 'Retorn a Corint', 'Arion i el dofí: Retorn a Corint', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 17300 AND p.composer_id = 251
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:1cdd5443-ba58-49d5-b483-0e70a6bc50b4'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 17, part.movement_number = NULL,
    part.name_ko = 'Cançó final', part.name_en = 'Arion i el dofí: Cançó final',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 17300 AND p.composer_id = 251 AND part.part_key = 'musicbrainz:1edcf344-c6c3-49a8-9258-1590332053c2' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:1edcf344-c6c3-49a8-9258-1590332053c2', 17, NULL, 'Cançó final', 'Arion i el dofí: Cançó final', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 17300 AND p.composer_id = 251
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:1edcf344-c6c3-49a8-9258-1590332053c2'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 18, part.movement_number = NULL,
    part.name_ko = 'Aniversari', part.name_en = 'Arion i el dofí: Aniversari',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 17300 AND p.composer_id = 251 AND part.part_key = 'musicbrainz:f7f426c6-29b4-4d38-93cc-bf597d3dfa40' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:f7f426c6-29b4-4d38-93cc-bf597d3dfa40', 18, NULL, 'Aniversari', 'Arion i el dofí: Aniversari', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 17300 AND p.composer_id = 251
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:f7f426c6-29b4-4d38-93cc-bf597d3dfa40'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 19, part.movement_number = NULL,
    part.name_ko = 'Per molts anys, Cantània!', part.name_en = 'Arion i el dofí: Per molts anys, Cantània!',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 17300 AND p.composer_id = 251 AND part.part_key = 'musicbrainz:1e01c9d1-0cac-4c72-aa50-3305ce35b9ae' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:1e01c9d1-0cac-4c72-aa50-3305ce35b9ae', 19, NULL, 'Per molts anys, Cantània!', 'Arion i el dofí: Per molts anys, Cantània!', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 17300 AND p.composer_id = 251
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:1e01c9d1-0cac-4c72-aa50-3305ce35b9ae'
);


-- None Els somnis

UPDATE pieces piece
SET piece.title = 'Els somnis', piece.title_en = 'Els somnis',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 19870 AND piece.composer_id = 251
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'Somni no. 1', part.name_en = 'Els somnis: Somni no. 1',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 19870 AND p.composer_id = 251 AND part.part_key = 'musicbrainz:ab5e7f80-f3ed-436e-85de-d1ca5300f044' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:ab5e7f80-f3ed-436e-85de-d1ca5300f044', 1, NULL, 'Somni no. 1', 'Els somnis: Somni no. 1', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 19870 AND p.composer_id = 251
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:ab5e7f80-f3ed-436e-85de-d1ca5300f044'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'Somni no. 2', part.name_en = 'Els somnis: Somni no. 2',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 19870 AND p.composer_id = 251 AND part.part_key = 'musicbrainz:35c99100-1578-41b2-8573-366cde923622' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:35c99100-1578-41b2-8573-366cde923622', 2, NULL, 'Somni no. 2', 'Els somnis: Somni no. 2', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 19870 AND p.composer_id = 251
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:35c99100-1578-41b2-8573-366cde923622'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = NULL,
    part.name_ko = 'Somni no. 3', part.name_en = 'Els somnis: Somni no. 3',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 19870 AND p.composer_id = 251 AND part.part_key = 'musicbrainz:b799be7f-a7c3-4424-858d-70cba1997d00' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:b799be7f-a7c3-4424-858d-70cba1997d00', 3, NULL, 'Somni no. 3', 'Els somnis: Somni no. 3', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 19870 AND p.composer_id = 251
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:b799be7f-a7c3-4424-858d-70cba1997d00'
);


-- None 뮤지컬 <Mar i cel>

UPDATE pieces piece
SET piece.title = '뮤지컬 <Mar i cel>', piece.title_en = 'Mar i cel',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 18259 AND piece.composer_id = 251
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Nissaga de poder

UPDATE pieces piece
SET piece.title = 'Nissaga de poder', piece.title_en = 'Nissaga de poder',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 17834 AND piece.composer_id = 251
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

-- 숨길 seed 작품 없음

-- ===== Marcel Delannoy (composer_id 253) =====
-- 작품을 MusicBrainz 작품 구조로 다시 짠다(6차 자동). 작품 3개(묶음 1, 다악장 0, 낱곡 2),
-- 새 작품 0개, part 1개, 그 아래 0개.
-- seed 3개 중 3개를 작품·part 에 잇고, 0개를 숨기고, 0개는 그대로 둔다.

-- None Dîner sur l'eau

UPDATE pieces piece
SET piece.title = 'Dîner sur l''eau', piece.title_en = 'Dîner sur l''eau',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 16564 AND piece.composer_id = 253
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None 오페레타 <Philippine>

UPDATE pieces piece
SET piece.title = '오페레타 <Philippine>', piece.title_en = 'Philippine',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 18047 AND piece.composer_id = 253
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'Complainte de l’homme serpent « Ah ! Elle était du type femme »', part.name_en = 'Philippine : Complainte de l’homme serpent « Ah ! Elle était du type femme »',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 18047 AND p.composer_id = 253 AND part.part_key = 'musicbrainz:610571bd-8b49-4b0a-939c-04ba1cd6fb5d' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:610571bd-8b49-4b0a-939c-04ba1cd6fb5d', 1, NULL, 'Complainte de l’homme serpent « Ah ! Elle était du type femme »', 'Philippine : Complainte de l’homme serpent « Ah ! Elle était du type femme »', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 18047 AND p.composer_id = 253
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:610571bd-8b49-4b0a-939c-04ba1cd6fb5d'
);


-- None Sérénade concertante

UPDATE pieces piece
SET piece.title = 'Sérénade concertante', piece.title_en = 'Sérénade concertante',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 19469 AND piece.composer_id = 253
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

-- 숨길 seed 작품 없음

-- ===== Martin O'Donnell (composer_id 255) =====
-- 작품을 MusicBrainz 작품 구조로 다시 짠다(6차 자동). 작품 0개(묶음 0, 다악장 0, 낱곡 0),
-- 새 작품 0개, part 0개, 그 아래 0개.
-- seed 12개 중 0개를 작품·part 에 잇고, 12개를 숨기고, 0개는 그대로 둔다.

-- 카탈로그에 대응이 없는 seed 작품 12개를 목록에서 숨긴다(지우지 않음).
UPDATE pieces piece
SET piece.hidden_reason = 'catalog_unmatched'
WHERE piece.composer_id = 255 AND piece.origin = 'seed' AND piece.hidden_reason IS NULL
  AND piece.id IN (
    16004, 16954, 17063, 17374, 17614, 17629, 17844, 18261, 19304, 19362, 19424, 19593
  )
  AND NOT EXISTS (SELECT 1 FROM performance_sectors sector WHERE sector.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM piece_parts linking WHERE linking.linked_piece_id = piece.id);

-- ===== Ruth Watson Henderson (composer_id 256) =====
-- 작품을 MusicBrainz 작품 구조로 다시 짠다(6차 자동). 작품 18개(묶음 4, 다악장 1, 낱곡 13),
-- 새 작품 3개, part 25개, 그 아래 0개.
-- seed 17개 중 15개를 작품·part 에 잇고, 1개를 숨기고, 1개는 그대로 둔다.

-- None Chromatic Partita

UPDATE pieces piece
SET piece.title = 'Chromatic Partita', piece.title_en = 'Chromatic Partita',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 19144 AND piece.composer_id = 256
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'Chorale', part.name_en = 'Chromatic Partita: Chorale',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 19144 AND p.composer_id = 256 AND part.part_key = 'musicbrainz:575fd8ec-5103-4b3a-9c63-96ecf2ffe911' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:575fd8ec-5103-4b3a-9c63-96ecf2ffe911', 1, NULL, 'Chorale', 'Chromatic Partita: Chorale', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 19144 AND p.composer_id = 256
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:575fd8ec-5103-4b3a-9c63-96ecf2ffe911'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'Variation I', part.name_en = 'Chromatic Partita: Variation I',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 19144 AND p.composer_id = 256 AND part.part_key = 'musicbrainz:8c2e94be-f216-4f0b-bc13-bd810bbea463' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:8c2e94be-f216-4f0b-bc13-bd810bbea463', 2, NULL, 'Variation I', 'Chromatic Partita: Variation I', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 19144 AND p.composer_id = 256
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:8c2e94be-f216-4f0b-bc13-bd810bbea463'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = NULL,
    part.name_ko = 'Variation II', part.name_en = 'Chromatic Partita: Variation II',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 19144 AND p.composer_id = 256 AND part.part_key = 'musicbrainz:b8030744-e9b8-44a6-ae2d-fb2be6a19000' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:b8030744-e9b8-44a6-ae2d-fb2be6a19000', 3, NULL, 'Variation II', 'Chromatic Partita: Variation II', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 19144 AND p.composer_id = 256
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:b8030744-e9b8-44a6-ae2d-fb2be6a19000'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = NULL,
    part.name_ko = 'Variation III', part.name_en = 'Chromatic Partita: Variation III',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 19144 AND p.composer_id = 256 AND part.part_key = 'musicbrainz:f17efd43-2767-4e2b-b4bb-9154a49d6cbb' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:f17efd43-2767-4e2b-b4bb-9154a49d6cbb', 4, NULL, 'Variation III', 'Chromatic Partita: Variation III', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 19144 AND p.composer_id = 256
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:f17efd43-2767-4e2b-b4bb-9154a49d6cbb'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 5, part.movement_number = NULL,
    part.name_ko = 'Variation IV', part.name_en = 'Chromatic Partita: Variation IV',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 19144 AND p.composer_id = 256 AND part.part_key = 'musicbrainz:57af3bff-23db-476d-b8a9-158851c29f80' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:57af3bff-23db-476d-b8a9-158851c29f80', 5, NULL, 'Variation IV', 'Chromatic Partita: Variation IV', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 19144 AND p.composer_id = 256
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:57af3bff-23db-476d-b8a9-158851c29f80'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 6, part.movement_number = NULL,
    part.name_ko = 'Variation V', part.name_en = 'Chromatic Partita: Variation V',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 19144 AND p.composer_id = 256 AND part.part_key = 'musicbrainz:c2c12908-4ad7-44a5-815b-916ee1d68b7f' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:c2c12908-4ad7-44a5-815b-916ee1d68b7f', 6, NULL, 'Variation V', 'Chromatic Partita: Variation V', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 19144 AND p.composer_id = 256
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:c2c12908-4ad7-44a5-815b-916ee1d68b7f'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 7, part.movement_number = NULL,
    part.name_ko = 'Variation VI', part.name_en = 'Chromatic Partita: Variation VI',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 19144 AND p.composer_id = 256 AND part.part_key = 'musicbrainz:ae4a5fe9-deda-4e37-9ed9-8a7102bfbc49' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:ae4a5fe9-deda-4e37-9ed9-8a7102bfbc49', 7, NULL, 'Variation VI', 'Chromatic Partita: Variation VI', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 19144 AND p.composer_id = 256
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:ae4a5fe9-deda-4e37-9ed9-8a7102bfbc49'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 8, part.movement_number = NULL,
    part.name_ko = 'Variation VII', part.name_en = 'Chromatic Partita: Variation VII',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 19144 AND p.composer_id = 256 AND part.part_key = 'musicbrainz:834633e4-9a82-48fc-b22f-c95cb9d02363' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:834633e4-9a82-48fc-b22f-c95cb9d02363', 8, NULL, 'Variation VII', 'Chromatic Partita: Variation VII', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 19144 AND p.composer_id = 256
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:834633e4-9a82-48fc-b22f-c95cb9d02363'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 9, part.movement_number = NULL,
    part.name_ko = 'Variation VIII', part.name_en = 'Chromatic Partita: Variation VIII',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 19144 AND p.composer_id = 256 AND part.part_key = 'musicbrainz:69242b72-c1ee-4ca3-a31c-d9b769267496' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:69242b72-c1ee-4ca3-a31c-d9b769267496', 9, NULL, 'Variation VIII', 'Chromatic Partita: Variation VIII', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 19144 AND p.composer_id = 256
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:69242b72-c1ee-4ca3-a31c-d9b769267496'
);


-- None Come Holy Spirit

UPDATE pieces piece
SET piece.title = 'Come Holy Spirit', piece.title_en = 'Come Holy Spirit',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 17217 AND piece.composer_id = 256
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Come, Ye Makers of Song

UPDATE pieces piece
SET piece.title = 'Come, Ye Makers of Song', piece.title_en = 'Come, Ye Makers of Song',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 16721 AND piece.composer_id = 256
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Five Ontario Folk Songs

UPDATE pieces piece
SET piece.title = 'Five Ontario Folk Songs', piece.title_en = 'Five Ontario Folk Songs',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 17706 AND piece.composer_id = 256
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'Come All You Bold Canadians', part.name_en = 'Five Ontario Folk Songs: No. 1. Come All You Bold Canadians',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 17706 AND p.composer_id = 256 AND part.part_key = 'musicbrainz:691cf777-9e7f-47d2-9188-8259f770140c' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:691cf777-9e7f-47d2-9188-8259f770140c', 1, NULL, 'Come All You Bold Canadians', 'Five Ontario Folk Songs: No. 1. Come All You Bold Canadians', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 17706 AND p.composer_id = 256
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:691cf777-9e7f-47d2-9188-8259f770140c'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'The Maggie Hunter', part.name_en = 'Five Ontario Folk Songs: No. 2. The Maggie Hunter',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 17706 AND p.composer_id = 256 AND part.part_key = 'musicbrainz:68f352f2-bc48-4e64-b5b4-f3a5adf835e0' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:68f352f2-bc48-4e64-b5b4-f3a5adf835e0', 2, NULL, 'The Maggie Hunter', 'Five Ontario Folk Songs: No. 2. The Maggie Hunter', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 17706 AND p.composer_id = 256
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:68f352f2-bc48-4e64-b5b4-f3a5adf835e0'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = NULL,
    part.name_ko = 'The Banks of the Don', part.name_en = 'Five Ontario Folk Songs: No. 3. The Banks of the Don',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 17706 AND p.composer_id = 256 AND part.part_key = 'musicbrainz:c681f89b-ef5a-4f68-90cc-2a94b90dfa47' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:c681f89b-ef5a-4f68-90cc-2a94b90dfa47', 3, NULL, 'The Banks of the Don', 'Five Ontario Folk Songs: No. 3. The Banks of the Don', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 17706 AND p.composer_id = 256
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:c681f89b-ef5a-4f68-90cc-2a94b90dfa47'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = NULL,
    part.name_ko = 'A Scarborough Settlers'' Lament', part.name_en = 'Five Ontario Folk Songs: No. 4. A Scarborough Settlers'' Lament',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 17706 AND p.composer_id = 256 AND part.part_key = 'musicbrainz:1749d8b8-76c7-43fd-8c3c-ea0e777305c9' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:1749d8b8-76c7-43fd-8c3c-ea0e777305c9', 4, NULL, 'A Scarborough Settlers'' Lament', 'Five Ontario Folk Songs: No. 4. A Scarborough Settlers'' Lament', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 17706 AND p.composer_id = 256
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:1749d8b8-76c7-43fd-8c3c-ea0e777305c9'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 5, part.movement_number = NULL,
    part.name_ko = 'The Poor Little Girls of Ontario', part.name_en = 'Five Ontario Folk Songs: No. 5. The Poor Little Girls of Ontario',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 17706 AND p.composer_id = 256 AND part.part_key = 'musicbrainz:72b0a47a-6733-4d11-be4e-57e527147bef' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:72b0a47a-6733-4d11-be4e-57e527147bef', 5, NULL, 'The Poor Little Girls of Ontario', 'Five Ontario Folk Songs: No. 5. The Poor Little Girls of Ontario', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 17706 AND p.composer_id = 256
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:72b0a47a-6733-4d11-be4e-57e527147bef'
);


-- None Gloria

UPDATE pieces piece
SET piece.title = 'Gloria', piece.title_en = 'Gloria',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 18042 AND piece.composer_id = 256
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None In Memoriam Elmer Iseler

UPDATE pieces piece
SET piece.title = 'In Memoriam Elmer Iseler', piece.title_en = 'In Memoriam Elmer Iseler',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 18600 AND piece.composer_id = 256
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Lullaby for the Christ Child

UPDATE pieces piece
SET piece.title = 'Lullaby for the Christ Child', piece.title_en = 'Lullaby for the Christ Child',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 16789 AND piece.composer_id = 256
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Ocean Vista

UPDATE pieces piece
SET piece.title = 'Ocean Vista', piece.title_en = 'Ocean Vista',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 19280 AND piece.composer_id = 256
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Psalm 100

UPDATE pieces piece
SET piece.title = 'Psalm 100', piece.title_en = 'Psalm 100',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 18615 AND piece.composer_id = 256
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Shades of Love

UPDATE pieces piece
SET piece.title = 'Shades of Love', piece.title_en = 'Shades of Love',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 16632 AND piece.composer_id = 256
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'Awake, My Heart', part.name_en = 'Shades of Love: No. 1. Awake, My Heart',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 16632 AND p.composer_id = 256 AND part.part_key = 'musicbrainz:ee54edb4-b61f-4def-9a51-9c8ca75366e1' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:ee54edb4-b61f-4def-9a51-9c8ca75366e1', 1, NULL, 'Awake, My Heart', 'Shades of Love: No. 1. Awake, My Heart', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 16632 AND p.composer_id = 256
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:ee54edb4-b61f-4def-9a51-9c8ca75366e1'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'She Walks in Beauty', part.name_en = 'Shades of Love: No. 2. She Walks in Beauty',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 16632 AND p.composer_id = 256 AND part.part_key = 'musicbrainz:50b86b3f-da02-4abf-8922-30aeca7c2d4b' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:50b86b3f-da02-4abf-8922-30aeca7c2d4b', 2, NULL, 'She Walks in Beauty', 'Shades of Love: No. 2. She Walks in Beauty', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 16632 AND p.composer_id = 256
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:50b86b3f-da02-4abf-8922-30aeca7c2d4b'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = NULL,
    part.name_ko = 'When We Two Parted', part.name_en = 'Shades of Love: No. 3. When We Two Parted',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 16632 AND p.composer_id = 256 AND part.part_key = 'musicbrainz:c8bc0d13-960e-48d4-a1c1-924b78b6fd0f' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:c8bc0d13-960e-48d4-a1c1-924b78b6fd0f', 3, NULL, 'When We Two Parted', 'Shades of Love: No. 3. When We Two Parted', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 16632 AND p.composer_id = 256
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:c8bc0d13-960e-48d4-a1c1-924b78b6fd0f'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = NULL,
    part.name_ko = 'Remember', part.name_en = 'Shades of Love: No. 4. Remember',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 16632 AND p.composer_id = 256 AND part.part_key = 'musicbrainz:d0a3fe96-14a4-4ec4-819b-8b8eb4996229' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:d0a3fe96-14a4-4ec4-819b-8b8eb4996229', 4, NULL, 'Remember', 'Shades of Love: No. 4. Remember', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 16632 AND p.composer_id = 256
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:d0a3fe96-14a4-4ec4-819b-8b8eb4996229'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 5, part.movement_number = NULL,
    part.name_ko = 'Annabel Lee', part.name_en = 'Shades of Love: No. 5. Annabel Lee',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 16632 AND p.composer_id = 256 AND part.part_key = 'musicbrainz:b17717eb-79d3-4762-877e-f33011f7497d' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:b17717eb-79d3-4762-877e-f33011f7497d', 5, NULL, 'Annabel Lee', 'Shades of Love: No. 5. Annabel Lee', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 16632 AND p.composer_id = 256
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:b17717eb-79d3-4762-877e-f33011f7497d'
);


-- None Sing All Ye Joyful

UPDATE pieces piece
SET piece.title = 'Sing All Ye Joyful', piece.title_en = 'Sing All Ye Joyful',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 16466 AND piece.composer_id = 256
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Sing Ye Praises

UPDATE pieces piece
SET piece.title = 'Sing Ye Praises', piece.title_en = 'Sing Ye Praises',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 19346 AND piece.composer_id = 256
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None The River

UPDATE pieces piece
SET piece.title = 'The River', piece.title_en = 'The River',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 17280 AND piece.composer_id = 256
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None The Song My Paddle Sings

UPDATE pieces piece
SET piece.title = 'The Song My Paddle Sings', piece.title_en = 'The Song My Paddle Sings',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 16552 AND piece.composer_id = 256
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Two Love Songs

UPDATE pieces piece
SET piece.title = 'Two Love Songs', piece.title_en = 'Two Love Songs',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 16985 AND piece.composer_id = 256
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'The Passionate Shepherd to His Love', part.name_en = 'The Passionate Shepherd to His Love',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 16985 AND p.composer_id = 256 AND part.part_key = 'musicbrainz:a112cbc2-c467-40bb-b9c8-c2589d8e4aab' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:a112cbc2-c467-40bb-b9c8-c2589d8e4aab', 1, NULL, 'The Passionate Shepherd to His Love', 'The Passionate Shepherd to His Love', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 16985 AND p.composer_id = 256
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:a112cbc2-c467-40bb-b9c8-c2589d8e4aab'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'The Nymph''s Reply', part.name_en = 'The Nymph''s Reply',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 16985 AND p.composer_id = 256 AND part.part_key = 'musicbrainz:451ed94b-bd07-4f85-bea1-1c768bed54d9' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:451ed94b-bd07-4f85-bea1-1c768bed54d9', 2, NULL, 'The Nymph''s Reply', 'The Nymph''s Reply', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 16985 AND p.composer_id = 256
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:451ed94b-bd07-4f85-bea1-1c768bed54d9'
);


-- None Cantate Domino

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, 'Cantate Domino', 'Cantate Domino', 'song', NULL, NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 256
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = 'Cantate Domino'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '6f7945e8-9443-42e7-b63e-70e966c1d8a5'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '6f7945e8-9443-42e7-b63e-70e966c1d8a5'
FROM pieces p
WHERE p.composer_id = 256 AND p.title = 'Cantate Domino' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '6f7945e8-9443-42e7-b63e-70e966c1d8a5'
);


-- None 마니피카트

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '마니피카트', 'Magnificat', 'song', NULL, NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 256
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '마니피카트'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '2b239a49-8fce-4518-9fa3-9703b76e7456'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '2b239a49-8fce-4518-9fa3-9703b76e7456'
FROM pieces p
WHERE p.composer_id = 256 AND p.title = '마니피카트' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '2b239a49-8fce-4518-9fa3-9703b76e7456'
);


-- None Missa Brevis

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, 'Missa Brevis', 'Missa Brevis', 'album', NULL, NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 256
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = 'Missa Brevis'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '5f78d528-d3a4-4add-97fe-d754b82044da'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '5f78d528-d3a4-4add-97fe-d754b82044da'
FROM pieces p
WHERE p.composer_id = 256 AND p.title = 'Missa Brevis' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '5f78d528-d3a4-4add-97fe-d754b82044da'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:ce12f528-2f8a-4c00-a953-7ba620241e95', 1, 'I', 'Kyrie', 'Missa Brevis: I. Kyrie', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 256 AND p.title = 'Missa Brevis' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:ce12f528-2f8a-4c00-a953-7ba620241e95'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:5c65e026-c4ce-4e38-94c3-6a79ea7dee57', 2, 'II', 'Gloria', 'Missa Brevis: II. Gloria', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 256 AND p.title = 'Missa Brevis' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:5c65e026-c4ce-4e38-94c3-6a79ea7dee57'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:deabd230-3055-4a60-845c-84bb0cfd5d0f', 3, 'III', 'Sanctus - Hosanna - Benedictus', 'Missa Brevis: III. Sanctus - Hosanna - Benedictus', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 256 AND p.title = 'Missa Brevis' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:deabd230-3055-4a60-845c-84bb0cfd5d0f'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:95d29a55-8caf-48de-81b7-fea372d30f0e', 4, 'IV', 'Agnus Dei', 'Missa Brevis: IV. Agnus Dei', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 256 AND p.title = 'Missa Brevis' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:95d29a55-8caf-48de-81b7-fea372d30f0e'
);

-- 카탈로그에 대응이 없는 seed 작품 1개를 목록에서 숨긴다(지우지 않음).
UPDATE pieces piece
SET piece.hidden_reason = 'catalog_unmatched'
WHERE piece.composer_id = 256 AND piece.origin = 'seed' AND piece.hidden_reason IS NULL
  AND piece.id IN (
    19813
  )
  AND NOT EXISTS (SELECT 1 FROM performance_sectors sector WHERE sector.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM piece_parts linking WHERE linking.linked_piece_id = piece.id);

-- ===== John Alden Carpenter (composer_id 257) =====
-- 작품을 MusicBrainz 작품 구조로 다시 짠다(6차 자동). 작품 15개(묶음 2, 다악장 2, 낱곡 11),
-- 새 작품 4개, part 18개, 그 아래 0개.
-- seed 11개 중 11개를 작품·part 에 잇고, 0개를 숨기고, 0개는 그대로 둔다.

-- None Adventures in a Perambulator

UPDATE pieces piece
SET piece.title = 'Adventures in a Perambulator', piece.title_en = 'Adventures in a Perambulator',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 18157 AND piece.composer_id = 257
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'En Voiture!', part.name_en = 'Adventures in a Perambulator: I. En Voiture!',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 18157 AND p.composer_id = 257 AND part.part_key = 'musicbrainz:94bb73a3-52dc-4a98-bb78-519de97a6246' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:94bb73a3-52dc-4a98-bb78-519de97a6246', 1, 'I', 'En Voiture!', 'Adventures in a Perambulator: I. En Voiture!', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 18157 AND p.composer_id = 257
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:94bb73a3-52dc-4a98-bb78-519de97a6246'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'The Policeman', part.name_en = 'Adventures in a Perambulator: II. The Policeman',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 18157 AND p.composer_id = 257 AND part.part_key = 'musicbrainz:ca16e058-29e1-4f1d-b5e2-94bddaf2f333' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:ca16e058-29e1-4f1d-b5e2-94bddaf2f333', 2, 'II', 'The Policeman', 'Adventures in a Perambulator: II. The Policeman', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 18157 AND p.composer_id = 257
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:ca16e058-29e1-4f1d-b5e2-94bddaf2f333'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = 'The Hurdy-Gurdy', part.name_en = 'Adventures in a Perambulator: III. The Hurdy-Gurdy',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 18157 AND p.composer_id = 257 AND part.part_key = 'musicbrainz:86c31ffd-e4ec-4958-b1fa-46e72f51ab68' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:86c31ffd-e4ec-4958-b1fa-46e72f51ab68', 3, 'III', 'The Hurdy-Gurdy', 'Adventures in a Perambulator: III. The Hurdy-Gurdy', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 18157 AND p.composer_id = 257
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:86c31ffd-e4ec-4958-b1fa-46e72f51ab68'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = 'IV',
    part.name_ko = 'The Lake', part.name_en = 'Adventures in a Perambulator: IV. The Lake',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 18157 AND p.composer_id = 257 AND part.part_key = 'musicbrainz:13d2b099-ff18-405d-8318-69814c4ea3a4' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:13d2b099-ff18-405d-8318-69814c4ea3a4', 4, 'IV', 'The Lake', 'Adventures in a Perambulator: IV. The Lake', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 18157 AND p.composer_id = 257
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:13d2b099-ff18-405d-8318-69814c4ea3a4'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 5, part.movement_number = 'V',
    part.name_ko = 'Dogs', part.name_en = 'Adventures in a Perambulator: V. Dogs',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 18157 AND p.composer_id = 257 AND part.part_key = 'musicbrainz:631ee329-d3e5-493a-b591-738d622177e0' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:631ee329-d3e5-493a-b591-738d622177e0', 5, 'V', 'Dogs', 'Adventures in a Perambulator: V. Dogs', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 18157 AND p.composer_id = 257
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:631ee329-d3e5-493a-b591-738d622177e0'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 6, part.movement_number = 'VI',
    part.name_ko = 'Dreams', part.name_en = 'Adventures in a Perambulator: VI. Dreams',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 18157 AND p.composer_id = 257 AND part.part_key = 'musicbrainz:6ee22bff-d3cd-44f9-b454-7ff4d1f79777' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:6ee22bff-d3cd-44f9-b454-7ff4d1f79777', 6, 'VI', 'Dreams', 'Adventures in a Perambulator: VI. Dreams', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 18157 AND p.composer_id = 257
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:6ee22bff-d3cd-44f9-b454-7ff4d1f79777'
);


-- None Four Negro Songs

UPDATE pieces piece
SET piece.title = 'Four Negro Songs', piece.title_en = 'Four Negro Songs',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 16831 AND piece.composer_id = 257
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'The cryin'' blues', part.name_en = 'Four Negro Songs: No. 2. The cryin'' blues',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 16831 AND p.composer_id = 257 AND part.part_key = 'musicbrainz:fdc48224-8ad7-47eb-be99-fc8e16636b25' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:fdc48224-8ad7-47eb-be99-fc8e16636b25', 1, NULL, 'The cryin'' blues', 'Four Negro Songs: No. 2. The cryin'' blues', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 16831 AND p.composer_id = 257
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:fdc48224-8ad7-47eb-be99-fc8e16636b25'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'Jazz-Boys', part.name_en = 'Four Negro Songs: No. 3. Jazz-Boys',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 16831 AND p.composer_id = 257 AND part.part_key = 'musicbrainz:6ba71f6f-fbf9-4a7c-9c7c-31bdecdfe60f' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:6ba71f6f-fbf9-4a7c-9c7c-31bdecdfe60f', 2, NULL, 'Jazz-Boys', 'Four Negro Songs: No. 3. Jazz-Boys', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 16831 AND p.composer_id = 257
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:6ba71f6f-fbf9-4a7c-9c7c-31bdecdfe60f'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = NULL,
    part.name_ko = 'That soothin'' song', part.name_en = 'Four Negro Songs: No. 4. That soothin'' song',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 16831 AND p.composer_id = 257 AND part.part_key = 'musicbrainz:75a93dd6-c132-4dde-bd5f-f80d3e226678' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:75a93dd6-c132-4dde-bd5f-f80d3e226678', 3, NULL, 'That soothin'' song', 'Four Negro Songs: No. 4. That soothin'' song', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 16831 AND p.composer_id = 257
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:75a93dd6-c132-4dde-bd5f-f80d3e226678'
);


-- None 연가곡집 <Gitanjali>

UPDATE pieces piece
SET piece.title = '연가곡집 <Gitanjali>', piece.title_en = 'Gitanjali',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 17729 AND piece.composer_id = 257
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'When I Bring to You Colour’d Toys', part.name_en = 'Gitanjali: No. 1. When I Bring to You Colour’d Toys',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 17729 AND p.composer_id = 257 AND part.part_key = 'musicbrainz:aaec8e68-e47e-4437-a33c-9e95149b19c1' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:aaec8e68-e47e-4437-a33c-9e95149b19c1', 1, NULL, 'When I Bring to You Colour’d Toys', 'Gitanjali: No. 1. When I Bring to You Colour’d Toys', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 17729 AND p.composer_id = 257
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:aaec8e68-e47e-4437-a33c-9e95149b19c1'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'On the Day When Death Will Knock at Your Door', part.name_en = 'Gitanjali: No. 2. On the Day When Death Will Knock at Your Door',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 17729 AND p.composer_id = 257 AND part.part_key = 'musicbrainz:4b0415a9-df24-4223-bb64-ebda5f8393f7' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:4b0415a9-df24-4223-bb64-ebda5f8393f7', 2, NULL, 'On the Day When Death Will Knock at Your Door', 'Gitanjali: No. 2. On the Day When Death Will Knock at Your Door', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 17729 AND p.composer_id = 257
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:4b0415a9-df24-4223-bb64-ebda5f8393f7'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = NULL,
    part.name_ko = 'The Sleep that Flits on Baby''s Eyes', part.name_en = 'Gitanjali: No. 3. The Sleep that Flits on Baby''s Eyes',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 17729 AND p.composer_id = 257 AND part.part_key = 'musicbrainz:725e84a1-c7c6-4385-9f26-68952ba29ac4' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:725e84a1-c7c6-4385-9f26-68952ba29ac4', 3, NULL, 'The Sleep that Flits on Baby''s Eyes', 'Gitanjali: No. 3. The Sleep that Flits on Baby''s Eyes', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 17729 AND p.composer_id = 257
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:725e84a1-c7c6-4385-9f26-68952ba29ac4'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = NULL,
    part.name_ko = 'I Am Like a Remnant of a Cloud of Autumn', part.name_en = 'Gitanjali: No. 4.I Am Like a Remnant of a Cloud of Autumn',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 17729 AND p.composer_id = 257 AND part.part_key = 'musicbrainz:981ff8de-8d79-4ce5-b7c3-6d0af7eb54a7' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:981ff8de-8d79-4ce5-b7c3-6d0af7eb54a7', 4, NULL, 'I Am Like a Remnant of a Cloud of Autumn', 'Gitanjali: No. 4.I Am Like a Remnant of a Cloud of Autumn', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 17729 AND p.composer_id = 257
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:981ff8de-8d79-4ce5-b7c3-6d0af7eb54a7'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 5, part.movement_number = NULL,
    part.name_ko = 'On the Seashore of Endless Worlds', part.name_en = 'Gitanjali: No. 5. On the Seashore of Endless Worlds',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 17729 AND p.composer_id = 257 AND part.part_key = 'musicbrainz:32d1e5d7-663c-4ef5-aa8e-cb5908b0abef' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:32d1e5d7-663c-4ef5-aa8e-cb5908b0abef', 5, NULL, 'On the Seashore of Endless Worlds', 'Gitanjali: No. 5. On the Seashore of Endless Worlds', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 17729 AND p.composer_id = 257
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:32d1e5d7-663c-4ef5-aa8e-cb5908b0abef'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 6, part.movement_number = NULL,
    part.name_ko = 'My Light', part.name_en = 'Gitanjali: No. 6. My Light',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 17729 AND p.composer_id = 257 AND part.part_key = 'musicbrainz:a2e80c03-da76-42a7-ab58-e7da4f84af67' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:a2e80c03-da76-42a7-ab58-e7da4f84af67', 6, NULL, 'My Light', 'Gitanjali: No. 6. My Light', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 17729 AND p.composer_id = 257
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:a2e80c03-da76-42a7-ab58-e7da4f84af67'
);


-- None 발레 <Krazy Kat>

UPDATE pieces piece
SET piece.title = '발레 <Krazy Kat>', piece.title_en = 'Krazy Kat',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 19154 AND piece.composer_id = 257
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Looking Glass River

UPDATE pieces piece
SET piece.title = 'Looking Glass River', piece.title_en = 'Looking Glass River',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 17107 AND piece.composer_id = 257
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Sea Drift

UPDATE pieces piece
SET piece.title = 'Sea Drift', piece.title_en = 'Sea Drift',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 18456 AND piece.composer_id = 257
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Skyscrapers

UPDATE pieces piece
SET piece.title = 'Skyscrapers', piece.title_en = 'Skyscrapers',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 16823 AND piece.composer_id = 257
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None 가곡 <Slumber-Song>

UPDATE pieces piece
SET piece.title = '가곡 <Slumber-Song>', piece.title_en = 'Slumber-Song',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 18618 AND piece.composer_id = 257
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Song of Faith

UPDATE pieces piece
SET piece.title = 'Song of Faith', piece.title_en = 'Song of Faith',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 16903 AND piece.composer_id = 257
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None 가곡 <The Home Road>

UPDATE pieces piece
SET piece.title = '가곡 <The Home Road>', piece.title_en = 'The Home Road',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 18256 AND piece.composer_id = 257
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Two Night Songs

UPDATE pieces piece
SET piece.title = 'Two Night Songs', piece.title_en = 'Two Night Songs',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 18479 AND piece.composer_id = 257
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None 피아노 콘체르티노

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '피아노 콘체르티노', 'Concertino for Piano and Orchestra', 'song', NULL, NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 257
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '피아노 콘체르티노'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'c43c66ea-0548-44dd-b37a-795f543e50e8'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'c43c66ea-0548-44dd-b37a-795f543e50e8'
FROM pieces p
WHERE p.composer_id = 257 AND p.title = '피아노 콘체르티노' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'c43c66ea-0548-44dd-b37a-795f543e50e8'
);


-- None 세레나데

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '세레나데', 'Serenade', 'song', NULL, NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 257
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '세레나데'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'cd58c4a1-b7b7-4d1a-86be-db0b94c0d87f'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'cd58c4a1-b7b7-4d1a-86be-db0b94c0d87f'
FROM pieces p
WHERE p.composer_id = 257 AND p.title = '세레나데' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'cd58c4a1-b7b7-4d1a-86be-db0b94c0d87f'
);


-- None 교향곡 1번

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '교향곡 1번', 'Symphony no. 1', 'song', NULL, NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 257
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '교향곡 1번'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'd8b174e7-5e67-4df4-b26e-565af4ecf485'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'd8b174e7-5e67-4df4-b26e-565af4ecf485'
FROM pieces p
WHERE p.composer_id = 257 AND p.title = '교향곡 1번' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'd8b174e7-5e67-4df4-b26e-565af4ecf485'
);


-- None 교향곡 2번

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '교향곡 2번', 'Symphony no. 2', 'album', NULL, NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 257
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '교향곡 2번'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'e27c2942-1bfa-4789-bc1c-aa6ddaf8deb2'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'e27c2942-1bfa-4789-bc1c-aa6ddaf8deb2'
FROM pieces p
WHERE p.composer_id = 257 AND p.title = '교향곡 2번' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'e27c2942-1bfa-4789-bc1c-aa6ddaf8deb2'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:93dad904-60cd-4238-a65b-c4e3a6633a74', 1, 'I', 'Moderato', 'Symphony no. 2: I. Moderato', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 257 AND p.title = '교향곡 2번' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:93dad904-60cd-4238-a65b-c4e3a6633a74'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:5ffe9b2c-8e20-4409-901d-3393ebff1481', 2, 'II', 'Andante', 'Symphony no. 2: II. Andante', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 257 AND p.title = '교향곡 2번' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:5ffe9b2c-8e20-4409-901d-3393ebff1481'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:a8d2b12e-3456-44c7-9c02-8601cc4f8247', 3, 'III', 'Allegro', 'Symphony no. 2: III. Allegro', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 257 AND p.title = '교향곡 2번' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:a8d2b12e-3456-44c7-9c02-8601cc4f8247'
);

-- 숨길 seed 작품 없음

-- ===== Juan Crisóstomo de Arriaga (composer_id 259) =====
-- 작품을 MusicBrainz 작품 구조로 다시 짠다(6차 자동). 작품 13개(묶음 2, 다악장 4, 낱곡 7),
-- 새 작품 1개, part 23개, 그 아래 0개.
-- seed 12개 중 12개를 작품·part 에 잇고, 0개를 숨기고, 0개는 그대로 둔다.

-- None Agar dans le désert

UPDATE pieces piece
SET piece.title = 'Agar dans le désert', piece.title_en = 'Agar dans le désert',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 16829 AND piece.composer_id = 259
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Air de "Médée"

UPDATE pieces piece
SET piece.title = 'Air de "Médée"', piece.title_en = 'Air de "Médée"',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 19970 AND piece.composer_id = 259
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None 칸타타 <Herminie>

UPDATE pieces piece
SET piece.title = '칸타타 <Herminie>', piece.title_en = 'Herminie',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 19578 AND piece.composer_id = 259
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'Recitativo "Le jour frappe mes yeux"', part.name_en = 'Herminie: No. 1. Recitativo "Le jour frappe mes yeux"',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 19578 AND p.composer_id = 259 AND part.part_key = 'musicbrainz:82bdb280-a852-4ea3-a3b9-095e95b60395' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:82bdb280-a852-4ea3-a3b9-095e95b60395', 1, NULL, 'Recitativo "Le jour frappe mes yeux"', 'Herminie: No. 1. Recitativo "Le jour frappe mes yeux"', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 19578 AND p.composer_id = 259
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:82bdb280-a852-4ea3-a3b9-095e95b60395'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'Aria "Long temps, hélas !"', part.name_en = 'Herminie: No. 2. Aria "Long temps, hélas !"',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 19578 AND p.composer_id = 259 AND part.part_key = 'musicbrainz:f2ecc121-c400-4ab9-a00f-3c05fe9daffd' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:f2ecc121-c400-4ab9-a00f-3c05fe9daffd', 2, NULL, 'Aria "Long temps, hélas !"', 'Herminie: No. 2. Aria "Long temps, hélas !"', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 19578 AND p.composer_id = 259
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:f2ecc121-c400-4ab9-a00f-3c05fe9daffd'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = NULL,
    part.name_ko = 'Recitativo "Mais sur cette arène guerrière"', part.name_en = 'Herminie: No. 3. Recitativo "Mais sur cette arène guerrière"',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 19578 AND p.composer_id = 259 AND part.part_key = 'musicbrainz:dad0d246-a9d6-4772-aa06-406652ef1fd9' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:dad0d246-a9d6-4772-aa06-406652ef1fd9', 3, NULL, 'Recitativo "Mais sur cette arène guerrière"', 'Herminie: No. 3. Recitativo "Mais sur cette arène guerrière"', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 19578 AND p.composer_id = 259
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:dad0d246-a9d6-4772-aa06-406652ef1fd9'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = NULL,
    part.name_ko = 'Aria "Il n''est plus"', part.name_en = 'Herminie: No. 4. Aria "Il n''est plus"',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 19578 AND p.composer_id = 259 AND part.part_key = 'musicbrainz:7dc2aa92-ccff-44cd-9b06-d496f9d0b982' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:7dc2aa92-ccff-44cd-9b06-d496f9d0b982', 4, NULL, 'Aria "Il n''est plus"', 'Herminie: No. 4. Aria "Il n''est plus"', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 19578 AND p.composer_id = 259
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:7dc2aa92-ccff-44cd-9b06-d496f9d0b982'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 5, part.movement_number = NULL,
    part.name_ko = 'Recitativo "Se peut-il ?"', part.name_en = 'Herminie: No. 5. Recitativo "Se peut-il ?"',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 19578 AND p.composer_id = 259 AND part.part_key = 'musicbrainz:e45b9b67-07e2-4832-8dda-015d3bcaf200' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:e45b9b67-07e2-4832-8dda-015d3bcaf200', 5, NULL, 'Recitativo "Se peut-il ?"', 'Herminie: No. 5. Recitativo "Se peut-il ?"', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 19578 AND p.composer_id = 259
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:e45b9b67-07e2-4832-8dda-015d3bcaf200'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 6, part.movement_number = NULL,
    part.name_ko = 'Aria "Tancrède me devra le jour"', part.name_en = 'Herminie: No. 6. Aria "Tancrède me devra le jour"',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 19578 AND p.composer_id = 259 AND part.part_key = 'musicbrainz:3ede0284-b327-443a-9ed9-1fd3fe0d78a2' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:3ede0284-b327-443a-9ed9-1fd3fe0d78a2', 6, NULL, 'Aria "Tancrède me devra le jour"', 'Herminie: No. 6. Aria "Tancrède me devra le jour"', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 19578 AND p.composer_id = 259
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:3ede0284-b327-443a-9ed9-1fd3fe0d78a2'
);


-- None 오페라 <Los esclavos felices>

UPDATE pieces piece
SET piece.title = '오페라 <Los esclavos felices>', piece.title_en = 'Los esclavos felices',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 18961 AND piece.composer_id = 259
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'Overture', part.name_en = 'Los esclavos felices: Overture',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 18961 AND p.composer_id = 259 AND part.part_key = 'musicbrainz:0343a51d-6df9-4bb0-8e58-6a36db0a3fca' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:0343a51d-6df9-4bb0-8e58-6a36db0a3fca', 1, NULL, 'Overture', 'Los esclavos felices: Overture', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 18961 AND p.composer_id = 259
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:0343a51d-6df9-4bb0-8e58-6a36db0a3fca'
);


-- None Marcha militar

UPDATE pieces piece
SET piece.title = 'Marcha militar', piece.title_en = 'Marcha militar',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 18274 AND piece.composer_id = 259
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- Op. 20 Obertura en re mayor

UPDATE pieces piece
SET piece.title = 'Obertura en re mayor', piece.title_en = 'Obertura en re mayor, op. 20',
    piece.type = 'song', piece.opus_number = 'Op. 20',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 15789 AND piece.composer_id = 259
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- Op. 1 서곡 "Nonetto"

UPDATE pieces piece
SET piece.title = '서곡 "Nonetto"', piece.title_en = 'Ouverture "Nonetto", op. 1',
    piece.type = 'song', piece.opus_number = 'Op. 1',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 16284 AND piece.composer_id = 259
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None 현악 4중주 1번 D단조

UPDATE pieces piece
SET piece.title = '현악 4중주 1번 D단조', piece.title_en = 'String Quartet no. 1 in D minor',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 19279 AND piece.composer_id = 259
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'Allegro', part.name_en = 'String Quartet no. 1 in D minor: I. Allegro',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 19279 AND p.composer_id = 259 AND part.part_key = 'musicbrainz:0f370e03-044c-4e40-870f-db5c71a685f8' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:0f370e03-044c-4e40-870f-db5c71a685f8', 1, 'I', 'Allegro', 'String Quartet no. 1 in D minor: I. Allegro', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 19279 AND p.composer_id = 259
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:0f370e03-044c-4e40-870f-db5c71a685f8'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'Adagio con espressione', part.name_en = 'String Quartet no. 1 in D minor: II. Adagio con espressione',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 19279 AND p.composer_id = 259 AND part.part_key = 'musicbrainz:0b5c3b90-df1e-4fae-aecf-9797b480024d' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:0b5c3b90-df1e-4fae-aecf-9797b480024d', 2, 'II', 'Adagio con espressione', 'String Quartet no. 1 in D minor: II. Adagio con espressione', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 19279 AND p.composer_id = 259
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:0b5c3b90-df1e-4fae-aecf-9797b480024d'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = 'Menuetto - Allegro - Trío più moderato', part.name_en = 'String Quartet no. 1 in D minor: III. Menuetto - Allegro - Trío più moderato',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 19279 AND p.composer_id = 259 AND part.part_key = 'musicbrainz:8e271882-8ff7-4a16-93b8-72705cc62770' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:8e271882-8ff7-4a16-93b8-72705cc62770', 3, 'III', 'Menuetto - Allegro - Trío più moderato', 'String Quartet no. 1 in D minor: III. Menuetto - Allegro - Trío più moderato', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 19279 AND p.composer_id = 259
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:8e271882-8ff7-4a16-93b8-72705cc62770'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = 'IV',
    part.name_ko = 'Adagio - Allegretto', part.name_en = 'String Quartet no. 1 in D minor: IV. Adagio - Allegretto',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 19279 AND p.composer_id = 259 AND part.part_key = 'musicbrainz:0ab872aa-2b82-4b75-8328-5ab76c501190' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:0ab872aa-2b82-4b75-8328-5ab76c501190', 4, 'IV', 'Adagio - Allegretto', 'String Quartet no. 1 in D minor: IV. Adagio - Allegretto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 19279 AND p.composer_id = 259
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:0ab872aa-2b82-4b75-8328-5ab76c501190'
);


-- None 현악 4중주 2번 A장조

UPDATE pieces piece
SET piece.title = '현악 4중주 2번 A장조', piece.title_en = 'String Quartet no. 2 in A major',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 17139 AND piece.composer_id = 259
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'Allegro con brio', part.name_en = 'String Quartet no. 2 in A major: I. Allegro con brio',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 17139 AND p.composer_id = 259 AND part.part_key = 'musicbrainz:9e0c4e30-f152-4ea5-af5e-48e5602bcb41' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:9e0c4e30-f152-4ea5-af5e-48e5602bcb41', 1, 'I', 'Allegro con brio', 'String Quartet no. 2 in A major: I. Allegro con brio', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 17139 AND p.composer_id = 259
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:9e0c4e30-f152-4ea5-af5e-48e5602bcb41'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'Andante con variaciones', part.name_en = 'String Quartet no. 2 in A major: II. Andante con variaciones',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 17139 AND p.composer_id = 259 AND part.part_key = 'musicbrainz:4013e61f-9dda-457f-8282-f62b3f8c3a67' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:4013e61f-9dda-457f-8282-f62b3f8c3a67', 2, 'II', 'Andante con variaciones', 'String Quartet no. 2 in A major: II. Andante con variaciones', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 17139 AND p.composer_id = 259
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:4013e61f-9dda-457f-8282-f62b3f8c3a67'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = 'Menuetto - Scherzo - Trio', part.name_en = 'String Quartet no. 2 in A major: III. Menuetto - Scherzo - Trio',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 17139 AND p.composer_id = 259 AND part.part_key = 'musicbrainz:68e928a5-404e-4b20-b054-38956e8bdf13' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:68e928a5-404e-4b20-b054-38956e8bdf13', 3, 'III', 'Menuetto - Scherzo - Trio', 'String Quartet no. 2 in A major: III. Menuetto - Scherzo - Trio', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 17139 AND p.composer_id = 259
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:68e928a5-404e-4b20-b054-38956e8bdf13'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = 'IV',
    part.name_ko = 'Andante ma non troppo - Allegro', part.name_en = 'String Quartet no. 2 in A major: IV. Andante ma non troppo - Allegro',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 17139 AND p.composer_id = 259 AND part.part_key = 'musicbrainz:438ea73e-bfda-48fc-abed-f9b5e0787c9a' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:438ea73e-bfda-48fc-abed-f9b5e0787c9a', 4, 'IV', 'Andante ma non troppo - Allegro', 'String Quartet no. 2 in A major: IV. Andante ma non troppo - Allegro', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 17139 AND p.composer_id = 259
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:438ea73e-bfda-48fc-abed-f9b5e0787c9a'
);


-- None 현악 4중주 3번 E♭장조

UPDATE pieces piece
SET piece.title = '현악 4중주 3번 E♭장조', piece.title_en = 'String Quartet no. 3 in E-flat major',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 18382 AND piece.composer_id = 259
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'Allegro', part.name_en = 'String Quartet no. 3 in E-flat major: I. Allegro',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 18382 AND p.composer_id = 259 AND part.part_key = 'musicbrainz:ea3697fb-c91c-4177-9fe6-3ae53dd85b27' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:ea3697fb-c91c-4177-9fe6-3ae53dd85b27', 1, 'I', 'Allegro', 'String Quartet no. 3 in E-flat major: I. Allegro', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 18382 AND p.composer_id = 259
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:ea3697fb-c91c-4177-9fe6-3ae53dd85b27'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'Pastorale - Andantino', part.name_en = 'String Quartet no. 3 in E-flat major: II. Pastorale - Andantino',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 18382 AND p.composer_id = 259 AND part.part_key = 'musicbrainz:066e03d4-44c7-424a-b1c1-1feb66dafe10' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:066e03d4-44c7-424a-b1c1-1feb66dafe10', 2, 'II', 'Pastorale - Andantino', 'String Quartet no. 3 in E-flat major: II. Pastorale - Andantino', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 18382 AND p.composer_id = 259
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:066e03d4-44c7-424a-b1c1-1feb66dafe10'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = 'Menuetto - Allegro - Trío plus lent', part.name_en = 'String Quartet no. 3 in E-flat major: III. Menuetto - Allegro - Trío plus lent',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 18382 AND p.composer_id = 259 AND part.part_key = 'musicbrainz:912a937a-7ddc-4d53-a7fe-93b7a2ac3eda' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:912a937a-7ddc-4d53-a7fe-93b7a2ac3eda', 3, 'III', 'Menuetto - Allegro - Trío plus lent', 'String Quartet no. 3 in E-flat major: III. Menuetto - Allegro - Trío plus lent', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 18382 AND p.composer_id = 259
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:912a937a-7ddc-4d53-a7fe-93b7a2ac3eda'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = 'IV',
    part.name_ko = 'Presto agitato', part.name_en = 'String Quartet no. 3 in E-flat major: IV. Presto agitato',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 18382 AND p.composer_id = 259 AND part.part_key = 'musicbrainz:24da548c-4f2a-4c0b-946a-cae01507ef03' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:24da548c-4f2a-4c0b-946a-cae01507ef03', 4, 'IV', 'Presto agitato', 'String Quartet no. 3 in E-flat major: IV. Presto agitato', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 18382 AND p.composer_id = 259
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:24da548c-4f2a-4c0b-946a-cae01507ef03'
);


-- None Symphonie à grand orchestre en Ré

UPDATE pieces piece
SET piece.title = 'Symphonie à grand orchestre en Ré', piece.title_en = 'Symphonie à grand orchestre en Ré',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 15740 AND piece.composer_id = 259
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'Adagio - Allegro vivace - Presto', part.name_en = 'Symphonie à grand orchestre en Ré: I. Adagio - Allegro vivace - Presto',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 15740 AND p.composer_id = 259 AND part.part_key = 'musicbrainz:04476dcd-e7c9-473c-b901-6340430308e8' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:04476dcd-e7c9-473c-b901-6340430308e8', 1, 'I', 'Adagio - Allegro vivace - Presto', 'Symphonie à grand orchestre en Ré: I. Adagio - Allegro vivace - Presto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 15740 AND p.composer_id = 259
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:04476dcd-e7c9-473c-b901-6340430308e8'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'Andante', part.name_en = 'Symphonie à grand orchestre en Ré: II. Andante',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 15740 AND p.composer_id = 259 AND part.part_key = 'musicbrainz:f12b620f-f444-4c99-ace8-9c25820a888f' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:f12b620f-f444-4c99-ace8-9c25820a888f', 2, 'II', 'Andante', 'Symphonie à grand orchestre en Ré: II. Andante', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 15740 AND p.composer_id = 259
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:f12b620f-f444-4c99-ace8-9c25820a888f'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = 'Minuetto. Allegro - Trio', part.name_en = 'Symphonie à grand orchestre en Ré: III. Minuetto. Allegro - Trio',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 15740 AND p.composer_id = 259 AND part.part_key = 'musicbrainz:945059f1-3959-4ae3-85c4-df875fe587ff' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:945059f1-3959-4ae3-85c4-df875fe587ff', 3, 'III', 'Minuetto. Allegro - Trio', 'Symphonie à grand orchestre en Ré: III. Minuetto. Allegro - Trio', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 15740 AND p.composer_id = 259
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:945059f1-3959-4ae3-85c4-df875fe587ff'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = 'IV',
    part.name_ko = 'Allegro con moto', part.name_en = 'Symphonie à grand orchestre en Ré: IV. Allegro con moto',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 15740 AND p.composer_id = 259 AND part.part_key = 'musicbrainz:b7a4e298-2636-4ab3-bcc1-828f8cb8aad1' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:b7a4e298-2636-4ab3-bcc1-828f8cb8aad1', 4, 'IV', 'Allegro con moto', 'Symphonie à grand orchestre en Ré: IV. Allegro con moto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 15740 AND p.composer_id = 259
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:b7a4e298-2636-4ab3-bcc1-828f8cb8aad1'
);


-- Op. 17 Tema variado en cuarteto

UPDATE pieces piece
SET piece.title = 'Tema variado en cuarteto', piece.title_en = 'Tema variado en cuarteto, op. 17',
    piece.type = 'song', piece.opus_number = 'Op. 17',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 16568 AND piece.composer_id = 259
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None O salutaris hostia

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, 'O salutaris hostia', 'O salutaris hostia', 'song', NULL, NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 259
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = 'O salutaris hostia'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'fa78f7fd-848b-474e-8ac5-9b566898e1cf'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'fa78f7fd-848b-474e-8ac5-9b566898e1cf'
FROM pieces p
WHERE p.composer_id = 259 AND p.title = 'O salutaris hostia' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'fa78f7fd-848b-474e-8ac5-9b566898e1cf'
);

-- 숨길 seed 작품 없음

-- ===== 핏 스베르츠 (composer_id 261) =====
-- 작품을 MusicBrainz 작품 구조로 다시 짠다(6차 자동). 작품 4개(묶음 0, 다악장 0, 낱곡 4),
-- 새 작품 0개, part 0개, 그 아래 0개.
-- seed 4개 중 4개를 작품·part 에 잇고, 0개를 숨기고, 0개는 그대로 둔다.

-- None Chain

UPDATE pieces piece
SET piece.title = 'Chain', piece.title_en = 'Chain',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 18931 AND piece.composer_id = 261
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Martenizza

UPDATE pieces piece
SET piece.title = 'Martenizza', piece.title_en = 'Martenizza',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 17860 AND piece.composer_id = 261
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Motion

UPDATE pieces piece
SET piece.title = 'Motion', piece.title_en = 'Motion',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 26019 AND piece.composer_id = 261
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Rotations for piano and orchestra

UPDATE pieces piece
SET piece.title = 'Rotations for piano and orchestra', piece.title_en = 'Rotations for piano and orchestra',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 19118 AND piece.composer_id = 261
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

-- 숨길 seed 작품 없음

-- ===== Juventino Rosas (composer_id 264) =====
-- 작품을 MusicBrainz 작품 구조로 다시 짠다(6차 자동). 작품 4개(묶음 0, 다악장 0, 낱곡 4),
-- 새 작품 0개, part 0개, 그 아래 0개.
-- seed 4개 중 4개를 작품·part 에 잇고, 0개를 숨기고, 0개는 그대로 둔다.

-- None Carmen

UPDATE pieces piece
SET piece.title = 'Carmen', piece.title_en = 'Carmen',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 16543 AND piece.composer_id = 264
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Ensueño seductor

UPDATE pieces piece
SET piece.title = 'Ensueño seductor', piece.title_en = 'Ensueño seductor',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 19174 AND piece.composer_id = 264
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Over the Waves Carousel

UPDATE pieces piece
SET piece.title = 'Over the Waves Carousel', piece.title_en = 'Over the Waves Carousel',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 16522 AND piece.composer_id = 264
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Sobre las olas

UPDATE pieces piece
SET piece.title = 'Sobre las olas', piece.title_en = 'Sobre las olas',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 15726 AND piece.composer_id = 264
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

-- 숨길 seed 작품 없음

-- ===== Issac Strauss (composer_id 266) =====
-- 작품을 MusicBrainz 작품 구조로 다시 짠다(6차 자동). 작품 1개(묶음 0, 다악장 0, 낱곡 1),
-- 새 작품 0개, part 0개, 그 아래 0개.
-- seed 2개 중 1개를 작품·part 에 잇고, 1개를 숨기고, 0개는 그대로 둔다.

-- None Hébé-Polka

UPDATE pieces piece
SET piece.title = 'Hébé-Polka', piece.title_en = 'Hébé-Polka',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 19241 AND piece.composer_id = 266
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

-- 카탈로그에 대응이 없는 seed 작품 1개를 목록에서 숨긴다(지우지 않음).
UPDATE pieces piece
SET piece.hidden_reason = 'catalog_unmatched'
WHERE piece.composer_id = 266 AND piece.origin = 'seed' AND piece.hidden_reason IS NULL
  AND piece.id IN (
    17452
  )
  AND NOT EXISTS (SELECT 1 FROM performance_sectors sector WHERE sector.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM piece_parts linking WHERE linking.linked_piece_id = piece.id);

-- ===== Alice Shields (composer_id 269) =====
-- 작품을 MusicBrainz 작품 구조로 다시 짠다(6차 자동). 작품 3개(묶음 0, 다악장 0, 낱곡 3),
-- 새 작품 0개, part 0개, 그 아래 0개.
-- seed 4개 중 3개를 작품·part 에 잇고, 0개를 숨기고, 1개는 그대로 둔다.

-- None Dance Piece No. 3

UPDATE pieces piece
SET piece.title = 'Dance Piece No. 3', piece.title_en = 'Dance Piece No. 3',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 19287 AND piece.composer_id = 269
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Study for Voice and Tape

UPDATE pieces piece
SET piece.title = 'Study for Voice and Tape', piece.title_en = 'Study for Voice and Tape',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 18459 AND piece.composer_id = 269
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None The Transformation of Ani

UPDATE pieces piece
SET piece.title = 'The Transformation of Ani', piece.title_en = 'The Transformation of Ani',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 17137 AND piece.composer_id = 269
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

-- 숨길 seed 작품 없음

-- ===== Ernesto Elorduy (composer_id 279) =====
-- 작품을 MusicBrainz 작품 구조로 다시 짠다(6차 자동). 작품 1개(묶음 1, 다악장 0, 낱곡 0),
-- 새 작품 0개, part 3개, 그 아래 0개.
-- seed 1개 중 1개를 작품·part 에 잇고, 0개를 숨기고, 0개는 그대로 둔다.

-- None Tres danzas tropicales

UPDATE pieces piece
SET piece.title = 'Tres danzas tropicales', piece.title_en = 'Tres danzas tropicales',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 16720 AND piece.composer_id = 279
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'N.º 1', part.name_en = 'Tres danzas tropicales: N.º 1',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 16720 AND p.composer_id = 279 AND part.part_key = 'musicbrainz:0081d377-4eb5-4835-ae05-bcbe474e4cd8' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:0081d377-4eb5-4835-ae05-bcbe474e4cd8', 1, NULL, 'N.º 1', 'Tres danzas tropicales: N.º 1', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 16720 AND p.composer_id = 279
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:0081d377-4eb5-4835-ae05-bcbe474e4cd8'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'N.º 2', part.name_en = 'Tres danzas tropicales: N.º 2',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 16720 AND p.composer_id = 279 AND part.part_key = 'musicbrainz:4eabff2f-7865-498d-8dc8-d971e9af0099' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:4eabff2f-7865-498d-8dc8-d971e9af0099', 2, NULL, 'N.º 2', 'Tres danzas tropicales: N.º 2', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 16720 AND p.composer_id = 279
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:4eabff2f-7865-498d-8dc8-d971e9af0099'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = NULL,
    part.name_ko = 'N.º 3', part.name_en = 'Tres danzas tropicales: N.º 3',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 16720 AND p.composer_id = 279 AND part.part_key = 'musicbrainz:63976722-f465-4554-a2f8-d78174d9fc33' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:63976722-f465-4554-a2f8-d78174d9fc33', 3, NULL, 'N.º 3', 'Tres danzas tropicales: N.º 3', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 16720 AND p.composer_id = 279
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:63976722-f465-4554-a2f8-d78174d9fc33'
);

-- 숨길 seed 작품 없음

-- ===== Heinrich Esser (composer_id 284) =====
-- 작품을 MusicBrainz 작품 구조로 다시 짠다(6차 자동). 작품 1개(묶음 0, 다악장 0, 낱곡 1),
-- 새 작품 0개, part 0개, 그 아래 0개.
-- seed 1개 중 1개를 작품·part 에 잇고, 0개를 숨기고, 0개는 그대로 둔다.

-- None Frühling, komm wieder

UPDATE pieces piece
SET piece.title = 'Frühling, komm wieder', piece.title_en = 'Frühling, komm wieder',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 17116 AND piece.composer_id = 284
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

-- 숨길 seed 작품 없음

-- ===== Dan Welcher (composer_id 288) =====
-- 작품을 MusicBrainz 작품 구조로 다시 짠다(6차 자동). 작품 6개(묶음 0, 다악장 4, 낱곡 2),
-- 새 작품 0개, part 12개, 그 아래 0개.
-- seed 7개 중 6개를 작품·part 에 잇고, 0개를 숨기고, 1개는 그대로 둔다.

-- None 클라리넷 협주곡

UPDATE pieces piece
SET piece.title = '클라리넷 협주곡', piece.title_en = 'Concerto for Clarinet and Orchestra',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 17040 AND piece.composer_id = 288
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'Very Fast - Slowly - Dancing', part.name_en = 'Concerto for Clarinet and Orchestra: I. Very Fast - Slowly - Dancing',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 17040 AND p.composer_id = 288 AND part.part_key = 'musicbrainz:d6cf4b95-fb46-451e-bab5-5ead1f91ea33' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:d6cf4b95-fb46-451e-bab5-5ead1f91ea33', 1, 'I', 'Very Fast - Slowly - Dancing', 'Concerto for Clarinet and Orchestra: I. Very Fast - Slowly - Dancing', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 17040 AND p.composer_id = 288
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:d6cf4b95-fb46-451e-bab5-5ead1f91ea33'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'Blues and Toccata (on the name "Benny Goodman")', part.name_en = 'Concerto for Clarinet and Orchestra: II. Blues and Toccata (on the name "Benny Goodman")',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 17040 AND p.composer_id = 288 AND part.part_key = 'musicbrainz:5552cea7-24a4-480f-89fa-6364d2ae92ad' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:5552cea7-24a4-480f-89fa-6364d2ae92ad', 2, 'II', 'Blues and Toccata (on the name "Benny Goodman")', 'Concerto for Clarinet and Orchestra: II. Blues and Toccata (on the name "Benny Goodman")', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 17040 AND p.composer_id = 288
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:5552cea7-24a4-480f-89fa-6364d2ae92ad'
);


-- None Prairie Light (Three Texas Watercolors of Georgia O'Keefe)

UPDATE pieces piece
SET piece.title = 'Prairie Light (Three Texas Watercolors of Georgia O''Keefe)', piece.title_en = 'Prairie Light (Three Texas Watercolors of Georgia O''Keefe)',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 18731 AND piece.composer_id = 288
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'Light Coming on the Plains', part.name_en = 'Prairie Light (Three Texas Watercolors of Georgia O''Keefe): I. Light Coming on the Plains',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 18731 AND p.composer_id = 288 AND part.part_key = 'musicbrainz:a84087de-05d3-425f-bf83-3200dad7a307' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:a84087de-05d3-425f-bf83-3200dad7a307', 1, 'I', 'Light Coming on the Plains', 'Prairie Light (Three Texas Watercolors of Georgia O''Keefe): I. Light Coming on the Plains', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 18731 AND p.composer_id = 288
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:a84087de-05d3-425f-bf83-3200dad7a307'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'Canyon with Crows', part.name_en = 'Prairie Light (Three Texas Watercolors of Georgia O''Keefe): II. Canyon with Crows',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 18731 AND p.composer_id = 288 AND part.part_key = 'musicbrainz:ea5b04bc-a6a0-4a36-9545-73b67db2a22b' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:ea5b04bc-a6a0-4a36-9545-73b67db2a22b', 2, 'II', 'Canyon with Crows', 'Prairie Light (Three Texas Watercolors of Georgia O''Keefe): II. Canyon with Crows', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 18731 AND p.composer_id = 288
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:ea5b04bc-a6a0-4a36-9545-73b67db2a22b'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = 'Starlight Night', part.name_en = 'Prairie Light (Three Texas Watercolors of Georgia O''Keefe): III. Starlight Night',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 18731 AND p.composer_id = 288 AND part.part_key = 'musicbrainz:2c9efb51-8f60-4990-8007-507c373ee1d2' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:2c9efb51-8f60-4990-8007-507c373ee1d2', 3, 'III', 'Starlight Night', 'Prairie Light (Three Texas Watercolors of Georgia O''Keefe): III. Starlight Night', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 18731 AND p.composer_id = 288
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:2c9efb51-8f60-4990-8007-507c373ee1d2'
);


-- None Songs Without Words

UPDATE pieces piece
SET piece.title = 'Songs Without Words', piece.title_en = 'Songs Without Words',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 18214 AND piece.composer_id = 288
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'Manic', part.name_en = 'Songs Without Words: I. Manic',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 18214 AND p.composer_id = 288 AND part.part_key = 'musicbrainz:7e938ab8-5162-4855-87ba-21def2108306' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:7e938ab8-5162-4855-87ba-21def2108306', 1, 'I', 'Manic', 'Songs Without Words: I. Manic', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 18214 AND p.composer_id = 288
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:7e938ab8-5162-4855-87ba-21def2108306'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'Reflective', part.name_en = 'Songs Without Words: II. Reflective',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 18214 AND p.composer_id = 288 AND part.part_key = 'musicbrainz:e3922c12-9f89-45fc-b06f-5b57be4ed4e4' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:e3922c12-9f89-45fc-b06f-5b57be4ed4e4', 2, 'II', 'Reflective', 'Songs Without Words: II. Reflective', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 18214 AND p.composer_id = 288
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:e3922c12-9f89-45fc-b06f-5b57be4ed4e4'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = 'Giddy', part.name_en = 'Songs Without Words: III. Giddy',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 18214 AND p.composer_id = 288 AND part.part_key = 'musicbrainz:2c2a55a0-5599-4f21-951f-aa3884e36c79' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:2c2a55a0-5599-4f21-951f-aa3884e36c79', 3, 'III', 'Giddy', 'Songs Without Words: III. Giddy', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 18214 AND p.composer_id = 288
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:2c2a55a0-5599-4f21-951f-aa3884e36c79'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = 'IV',
    part.name_ko = 'Stunned', part.name_en = 'Songs Without Words: IV. Stunned',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 18214 AND p.composer_id = 288 AND part.part_key = 'musicbrainz:9a598805-72de-49d9-a1c7-756d24441f6e' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:9a598805-72de-49d9-a1c7-756d24441f6e', 4, 'IV', 'Stunned', 'Songs Without Words: IV. Stunned', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 18214 AND p.composer_id = 288
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:9a598805-72de-49d9-a1c7-756d24441f6e'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 5, part.movement_number = 'V',
    part.name_ko = 'Confident', part.name_en = 'Songs Without Words: V. Confident',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 18214 AND p.composer_id = 288 AND part.part_key = 'musicbrainz:23bb4ad8-d554-475a-8c2a-c3588a7997a1' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:23bb4ad8-d554-475a-8c2a-c3588a7997a1', 5, 'V', 'Confident', 'Songs Without Words: V. Confident', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 18214 AND p.composer_id = 288
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:23bb4ad8-d554-475a-8c2a-c3588a7997a1'
);


-- None Spumante

UPDATE pieces piece
SET piece.title = 'Spumante', piece.title_en = 'Spumante',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 16785 AND piece.composer_id = 288
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None 교향곡 3번 "Shaker Life"

UPDATE pieces piece
SET piece.title = '교향곡 3번 "Shaker Life"', piece.title_en = 'Symphony no. 3 "Shaker Life"',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 19974 AND piece.composer_id = 288
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'Laboring Songs', part.name_en = 'Symphony no. 3 "Shaker Life": I. Laboring Songs',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 19974 AND p.composer_id = 288 AND part.part_key = 'musicbrainz:cbfdcd23-72a0-4b3f-abb0-7239f46581ab' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:cbfdcd23-72a0-4b3f-abb0-7239f46581ab', 1, 'I', 'Laboring Songs', 'Symphony no. 3 "Shaker Life": I. Laboring Songs', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 19974 AND p.composer_id = 288
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:cbfdcd23-72a0-4b3f-abb0-7239f46581ab'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'Circular Marches', part.name_en = 'Symphony no. 3 "Shaker Life": II. Circular Marches',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 19974 AND p.composer_id = 288 AND part.part_key = 'musicbrainz:a5268ea8-5165-457f-bdfc-a5653155bdeb' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:a5268ea8-5165-457f-bdfc-a5653155bdeb', 2, 'II', 'Circular Marches', 'Symphony no. 3 "Shaker Life": II. Circular Marches', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 19974 AND p.composer_id = 288
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:a5268ea8-5165-457f-bdfc-a5653155bdeb'
);


-- None Zion

UPDATE pieces piece
SET piece.title = 'Zion', piece.title_en = 'Zion',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 17202 AND piece.composer_id = 288
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

-- 숨길 seed 작품 없음
