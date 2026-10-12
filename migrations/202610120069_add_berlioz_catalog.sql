-- 베를리오즈 작품을 MusicBrainz 작품 구조로 다시 짠다(4차 자동). 작품 81개(묶음 13, 다악장 7, 낱곡 61),
-- 새 작품 2개, part 120개, 그 아래 109개.
-- seed 143개 중 78개를 작품·part 에 잇고, 42개를 숨기고, 23개는 그대로 둔다.
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

-- 숨길 seed 가 쥔 카탈로그 제목을 비운다
UPDATE pieces piece
SET piece.title = 'Le Temple universel (편곡 2349)'
WHERE piece.id = 2349 AND piece.composer_id = 37 AND piece.title = 'Le Temple universel'
  AND piece.origin = 'seed' AND piece.editor_locked = 0
  AND NOT EXISTS (SELECT 1 FROM performance_sectors sector WHERE sector.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM piece_parts linking WHERE linking.linked_piece_id = piece.id);


-- None 가곡 <Amitié reprends ton empire>

UPDATE pieces piece
SET piece.title = '가곡 <Amitié reprends ton empire>', piece.title_en = 'Amitié reprends ton empire',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 1882 AND piece.composer_id = 37
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- H. 78A Aubade

UPDATE pieces piece
SET piece.title = 'Aubade', piece.title_en = 'Aubade, H. 78A',
    piece.type = 'song', piece.opus_number = 'H. 78A',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 907 AND piece.composer_id = 37
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- H. 78B Aubade H. 78B

UPDATE pieces piece
SET piece.title = 'Aubade H. 78B', piece.title_en = 'Aubade, H. 78B',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = 'H.', piece.catalogue_number = '78B',
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 1736 AND piece.composer_id = 37
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None 가곡 <Canon libre à la quinte>

UPDATE pieces piece
SET piece.title = '가곡 <Canon libre à la quinte>', piece.title_en = 'Canon libre à la quinte',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 1360 AND piece.composer_id = 37
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None 가곡 <Chansonette de M. Léon de Wailly>

UPDATE pieces piece
SET piece.title = '가곡 <Chansonette de M. Léon de Wailly>', piece.title_en = 'Chansonette de M. Léon de Wailly',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 1294 AND piece.composer_id = 37
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Chant du neuf Thermidor

UPDATE pieces piece
SET piece.title = 'Chant du neuf Thermidor', piece.title_en = 'Chant du neuf Thermidor',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 2196 AND piece.composer_id = 37
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- Op. 19 Feuillets d’album Op. 19

UPDATE pieces piece
SET piece.title = 'Feuillets d’album Op. 19', piece.title_en = 'Feuillets d’album, op. 19',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = 'Op.', piece.catalogue_number = '19',
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 2174 AND piece.composer_id = 37
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'Zaïde, op. 19 no. 1', part.name_en = 'Zaïde, op. 19 no. 1',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 2174 AND p.composer_id = 37 AND part.part_key = 'musicbrainz:d224d003-fef6-4cca-90f5-f1521e1334c7' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:d224d003-fef6-4cca-90f5-f1521e1334c7', 1, NULL, 'Zaïde, op. 19 no. 1', 'Zaïde, op. 19 no. 1', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 2174 AND p.composer_id = 37
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:d224d003-fef6-4cca-90f5-f1521e1334c7'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'Les champs, op. 19 no. 2, H. 67A', part.name_en = 'Les champs, op. 19 no. 2, H. 67A',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 2174 AND p.composer_id = 37 AND part.part_key = 'musicbrainz:8c5689f5-92f7-42ab-b3a9-9ed24ac19324' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:8c5689f5-92f7-42ab-b3a9-9ed24ac19324', 2, NULL, 'Les champs, op. 19 no. 2, H. 67A', 'Les champs, op. 19 no. 2, H. 67A', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 2174 AND p.composer_id = 37
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:8c5689f5-92f7-42ab-b3a9-9ed24ac19324'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = NULL,
    part.name_ko = 'Chant des chemins de fer, op. 19 no. 3', part.name_en = 'Chant des chemins de fer, op. 19 no. 3',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 2174 AND p.composer_id = 37 AND part.part_key = 'musicbrainz:55aff54b-8a63-4871-ab2f-30341b86d16f' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:55aff54b-8a63-4871-ab2f-30341b86d16f', 3, NULL, 'Chant des chemins de fer, op. 19 no. 3', 'Chant des chemins de fer, op. 19 no. 3', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 2174 AND p.composer_id = 37
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:55aff54b-8a63-4871-ab2f-30341b86d16f'
);


-- Op. 13 가곡 <Fleurs des landes> Op. 13

UPDATE pieces piece
SET piece.title = '가곡 <Fleurs des landes> Op. 13', piece.title_en = 'Fleurs des landes, op. 13, H. 124',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = 'Op.', piece.catalogue_number = '13',
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 1233 AND piece.composer_id = 37
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'Le matin, op. 13 no. 1, H. 125', part.name_en = 'Le matin, op. 13 no. 1, H. 125',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 1233 AND p.composer_id = 37 AND part.part_key = 'musicbrainz:05ddd9ed-2e96-4542-b8ef-591cd9a559c2' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:05ddd9ed-2e96-4542-b8ef-591cd9a559c2', 1, NULL, 'Le matin, op. 13 no. 1, H. 125', 'Le matin, op. 13 no. 1, H. 125', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 1233 AND p.composer_id = 37
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:05ddd9ed-2e96-4542-b8ef-591cd9a559c2'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'Petit oiseau, op. 13 no. 2, H. 126', part.name_en = 'Petit oiseau, op. 13 no. 2, H. 126',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 1233 AND p.composer_id = 37 AND part.part_key = 'musicbrainz:74ce49c4-0e52-4b7e-9ab4-3ab4576487da' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:74ce49c4-0e52-4b7e-9ab4-3ab4576487da', 2, NULL, 'Petit oiseau, op. 13 no. 2, H. 126', 'Petit oiseau, op. 13 no. 2, H. 126', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 1233 AND p.composer_id = 37
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:74ce49c4-0e52-4b7e-9ab4-3ab4576487da'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = NULL,
    part.name_ko = 'Le Trébuchet, op. 13 no. 3, H. 113', part.name_en = 'Le Trébuchet, op. 13 no. 3, H. 113',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 1233 AND p.composer_id = 37 AND part.part_key = 'musicbrainz:8a0a784b-58ba-480b-9fc7-67d4db02cc6d' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:8a0a784b-58ba-480b-9fc7-67d4db02cc6d', 3, NULL, 'Le Trébuchet, op. 13 no. 3, H. 113', 'Le Trébuchet, op. 13 no. 3, H. 113', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 1233 AND p.composer_id = 37
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:8a0a784b-58ba-480b-9fc7-67d4db02cc6d'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = NULL,
    part.name_ko = 'Le jeune pâtre breton, op. 13 no. 4, H. 65A', part.name_en = 'Le jeune pâtre breton, op. 13 no. 4, H. 65A',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 1233 AND p.composer_id = 37 AND part.part_key = 'musicbrainz:a0f758a1-03a7-4739-bcca-937b85a03513' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:a0f758a1-03a7-4739-bcca-937b85a03513', 4, NULL, 'Le jeune pâtre breton, op. 13 no. 4, H. 65A', 'Le jeune pâtre breton, op. 13 no. 4, H. 65A', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 1233 AND p.composer_id = 37
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:a0f758a1-03a7-4739-bcca-937b85a03513'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 5, part.movement_number = NULL,
    part.name_ko = 'Le chant des bretons, op. 13 no. 5, H. 71A', part.name_en = 'Le chant des bretons, op. 13 no. 5, H. 71A',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 1233 AND p.composer_id = 37 AND part.part_key = 'musicbrainz:de2a00eb-2d47-4677-bcab-330517398301' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:de2a00eb-2d47-4677-bcab-330517398301', 5, NULL, 'Le chant des bretons, op. 13 no. 5, H. 71A', 'Le chant des bretons, op. 13 no. 5, H. 71A', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 1233 AND p.composer_id = 37
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:de2a00eb-2d47-4677-bcab-330517398301'
);


-- H. 5 Fleuve du tage

UPDATE pieces piece
SET piece.title = 'Fleuve du tage', piece.title_en = 'Fleuve du tage, H. 5',
    piece.type = 'song', piece.opus_number = 'H. 5',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 2150 AND piece.composer_id = 37
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- H. 35 Fugue à 3 sujets

UPDATE pieces piece
SET piece.title = 'Fugue à 3 sujets', piece.title_en = 'Fugue à 3 sujets, H. 35',
    piece.type = 'song', piece.opus_number = 'H. 35',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 2681 AND piece.composer_id = 37
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- H. 22 푸가

UPDATE pieces piece
SET piece.title = '푸가', piece.title_en = 'Fugue, H. 22',
    piece.type = 'song', piece.opus_number = 'H. 22',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 2997 AND piece.composer_id = 37
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- Op. 1 Grande Ouverture de Waverly

UPDATE pieces piece
SET piece.title = 'Grande Ouverture de Waverly', piece.title_en = 'Grande Ouverture de Waverly, op. 1, H. 26',
    piece.type = 'song', piece.opus_number = 'Op. 1',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 512 AND piece.composer_id = 37
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- Op. 4 Grande Ouverture du « Roi Lear »

UPDATE pieces piece
SET piece.title = 'Grande Ouverture du « Roi Lear »', piece.title_en = 'Grande Ouverture du « Roi Lear » op. 4, H. 53',
    piece.type = 'song', piece.opus_number = 'Op. 4',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 538 AND piece.composer_id = 37
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- Op. 15 Grande symphonie funèbre et triomphale

UPDATE pieces piece
SET piece.title = 'Grande symphonie funèbre et triomphale', piece.title_en = 'Grande symphonie funèbre et triomphale, op. 15',
    piece.type = 'album', piece.opus_number = 'Op. 15',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 540 AND piece.composer_id = 37
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'Marche funèbre', part.name_en = 'Grande symphonie funèbre et triomphale, op. 15: I. Marche funèbre',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 540 AND p.composer_id = 37 AND part.part_key = 'musicbrainz:f05af699-5d69-47f4-a2d0-d918d05bd67d' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:f05af699-5d69-47f4-a2d0-d918d05bd67d', 1, 'I', 'Marche funèbre', 'Grande symphonie funèbre et triomphale, op. 15: I. Marche funèbre', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 540 AND p.composer_id = 37
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:f05af699-5d69-47f4-a2d0-d918d05bd67d'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'Oraison funèbre', part.name_en = 'Grande symphonie funèbre et triomphale, op. 15: II. Oraison funèbre',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 540 AND p.composer_id = 37 AND part.part_key = 'musicbrainz:f333ff6b-f5b6-4fb8-84ae-a256da8766fc' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:f333ff6b-f5b6-4fb8-84ae-a256da8766fc', 2, 'II', 'Oraison funèbre', 'Grande symphonie funèbre et triomphale, op. 15: II. Oraison funèbre', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 540 AND p.composer_id = 37
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:f333ff6b-f5b6-4fb8-84ae-a256da8766fc'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = 'Apothéose', part.name_en = 'Grande symphonie funèbre et triomphale, op. 15: III. Apothéose',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 540 AND p.composer_id = 37 AND part.part_key = 'musicbrainz:e973fb7e-8e68-4eec-a3c6-8aa0e6bc2788' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:e973fb7e-8e68-4eec-a3c6-8aa0e6bc2788', 3, 'III', 'Apothéose', 'Grande symphonie funèbre et triomphale, op. 15: III. Apothéose', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 540 AND p.composer_id = 37
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:e973fb7e-8e68-4eec-a3c6-8aa0e6bc2788'
);


-- Op. 16 Harold en Italie

UPDATE pieces piece
SET piece.title = 'Harold en Italie', piece.title_en = 'Harold en Italie, op. 16',
    piece.type = 'album', piece.opus_number = 'Op. 16',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 661 AND piece.composer_id = 37
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'Harold aux Montagnes. Scènes de mélancolie, de bonheur et de joie. Adagio — Allegro', part.name_en = 'Harold en Italie, op. 16: I. Harold aux Montagnes. Scènes de mélancolie, de bonheur et de joie. Adagio — Allegro',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 661 AND p.composer_id = 37 AND part.part_key = 'musicbrainz:ed31a76e-6b51-3939-9c32-72c0004f5206' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:ed31a76e-6b51-3939-9c32-72c0004f5206', 1, 'I', 'Harold aux Montagnes. Scènes de mélancolie, de bonheur et de joie. Adagio — Allegro', 'Harold en Italie, op. 16: I. Harold aux Montagnes. Scènes de mélancolie, de bonheur et de joie. Adagio — Allegro', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 661 AND p.composer_id = 37
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:ed31a76e-6b51-3939-9c32-72c0004f5206'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'Marche des pélerins chantant la prière du soir. Allegretto', part.name_en = 'Harold en Italie, op. 16: II. Marche des pélerins chantant la prière du soir. Allegretto',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 661 AND p.composer_id = 37 AND part.part_key = 'musicbrainz:8c450a21-a52f-3056-af4d-c0a6b4b4ea6b' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:8c450a21-a52f-3056-af4d-c0a6b4b4ea6b', 2, 'II', 'Marche des pélerins chantant la prière du soir. Allegretto', 'Harold en Italie, op. 16: II. Marche des pélerins chantant la prière du soir. Allegretto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 661 AND p.composer_id = 37
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:8c450a21-a52f-3056-af4d-c0a6b4b4ea6b'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = 'Sérénade d’un montagnard des Abruzzes à sa maîtresse. Allegro assai — Allegretto', part.name_en = 'Harold en Italie, op. 16: III. Sérénade d’un montagnard des Abruzzes à sa maîtresse. Allegro assai — Allegretto',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 661 AND p.composer_id = 37 AND part.part_key = 'musicbrainz:5883cade-2530-35e8-bc30-67f124d6afb4' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:5883cade-2530-35e8-bc30-67f124d6afb4', 3, 'III', 'Sérénade d’un montagnard des Abruzzes à sa maîtresse. Allegro assai — Allegretto', 'Harold en Italie, op. 16: III. Sérénade d’un montagnard des Abruzzes à sa maîtresse. Allegro assai — Allegretto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 661 AND p.composer_id = 37
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:5883cade-2530-35e8-bc30-67f124d6afb4'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = 'IV',
    part.name_ko = 'Orgie de brigands. Souvenirs des scènes précédentes. Allegro frenetico — Adagio — Allegro', part.name_en = 'Harold en Italie, op. 16: IV. Orgie de brigands. Souvenirs des scènes précédentes. Allegro frenetico — Adagio — Allegro',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 661 AND p.composer_id = 37 AND part.part_key = 'musicbrainz:a0db0701-2685-34c6-b505-0aa251a6557c' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:a0db0701-2685-34c6-b505-0aa251a6557c', 4, 'IV', 'Orgie de brigands. Souvenirs des scènes précédentes. Allegro frenetico — Adagio — Allegro', 'Harold en Italie, op. 16: IV. Orgie de brigands. Souvenirs des scènes précédentes. Allegro frenetico — Adagio — Allegro', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 661 AND p.composer_id = 37
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:a0db0701-2685-34c6-b505-0aa251a6557c'
);


-- H. 29 칸타타 <Herminie> H. 29

UPDATE pieces piece
SET piece.title = '칸타타 <Herminie> H. 29', piece.title_en = 'Herminie, H. 29',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = 'H.', piece.catalogue_number = '29',
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 1380 AND piece.composer_id = 37
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'Récitative "Quel trouble te poursuit, malheureuse". Moderato', part.name_en = 'Herminie, H. 29: Récitative "Quel trouble te poursuit, malheureuse". Moderato',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 1380 AND p.composer_id = 37 AND part.part_key = 'musicbrainz:421870b4-663d-47e2-a565-4d31a65b3e1e' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:421870b4-663d-47e2-a565-4d31a65b3e1e', 1, NULL, 'Récitative "Quel trouble te poursuit, malheureuse". Moderato', 'Herminie, H. 29: Récitative "Quel trouble te poursuit, malheureuse". Moderato', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 1380 AND p.composer_id = 37
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:421870b4-663d-47e2-a565-4d31a65b3e1e'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'Arie "Ah! Si de la tendresse où mon cœur". Adagio non troppo', part.name_en = 'Herminie, H. 29: Nº1. Arie "Ah! Si de la tendresse où mon cœur". Adagio non troppo',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 1380 AND p.composer_id = 37 AND part.part_key = 'musicbrainz:c3e4fba2-2500-4160-be00-3b0d89766c0b' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:c3e4fba2-2500-4160-be00-3b0d89766c0b', 2, NULL, 'Arie "Ah! Si de la tendresse où mon cœur". Adagio non troppo', 'Herminie, H. 29: Nº1. Arie "Ah! Si de la tendresse où mon cœur". Adagio non troppo', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 1380 AND p.composer_id = 37
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:c3e4fba2-2500-4160-be00-3b0d89766c0b'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = NULL,
    part.name_ko = 'Recit. "Que dis-je? òu s’égarent mes vœux?"', part.name_en = 'Herminie, H. 29: Recit. "Que dis-je? òu s’égarent mes vœux?"',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 1380 AND p.composer_id = 37 AND part.part_key = 'musicbrainz:a5c7b55b-f7c9-4828-b8d6-d49f328b4441' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:a5c7b55b-f7c9-4828-b8d6-d49f328b4441', 3, NULL, 'Recit. "Que dis-je? òu s’égarent mes vœux?"', 'Herminie, H. 29: Recit. "Que dis-je? òu s’égarent mes vœux?"', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 1380 AND p.composer_id = 37
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:a5c7b55b-f7c9-4828-b8d6-d49f328b4441'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = NULL,
    part.name_ko = 'Arie "Arrête! Cher Tancrède". Allegro assai agitato', part.name_en = 'Herminie, H. 29: Nº2. Arie "Arrête! Cher Tancrède". Allegro assai agitato',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 1380 AND p.composer_id = 37 AND part.part_key = 'musicbrainz:2a10cc03-aac5-4074-82dc-e446abba7645' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:2a10cc03-aac5-4074-82dc-e446abba7645', 4, NULL, 'Arie "Arrête! Cher Tancrède". Allegro assai agitato', 'Herminie, H. 29: Nº2. Arie "Arrête! Cher Tancrède". Allegro assai agitato', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 1380 AND p.composer_id = 37
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:2a10cc03-aac5-4074-82dc-e446abba7645'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 5, part.movement_number = NULL,
    part.name_ko = 'Recit. "Que Clorinde est heureuse"', part.name_en = 'Herminie, H. 29: Recit. "Que Clorinde est heureuse"',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 1380 AND p.composer_id = 37 AND part.part_key = 'musicbrainz:12958173-86f8-4668-9164-cae3f558d93c' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:12958173-86f8-4668-9164-cae3f558d93c', 5, NULL, 'Recit. "Que Clorinde est heureuse"', 'Herminie, H. 29: Recit. "Que Clorinde est heureuse"', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 1380 AND p.composer_id = 37
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:12958173-86f8-4668-9164-cae3f558d93c'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 6, part.movement_number = NULL,
    part.name_ko = 'Arie "Venez, venez, terribles armes!". Allegro impetuoso vivace', part.name_en = 'Herminie, H. 29: Nº3. Arie "Venez, venez, terribles armes!". Allegro impetuoso vivace',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 1380 AND p.composer_id = 37 AND part.part_key = 'musicbrainz:bf0c67b7-deac-471b-8a13-1c888de7ce53' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:bf0c67b7-deac-471b-8a13-1c888de7ce53', 6, NULL, 'Arie "Venez, venez, terribles armes!". Allegro impetuoso vivace', 'Herminie, H. 29: Nº3. Arie "Venez, venez, terribles armes!". Allegro impetuoso vivace', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 1380 AND p.composer_id = 37
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:bf0c67b7-deac-471b-8a13-1c888de7ce53'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 7, part.movement_number = NULL,
    part.name_ko = 'Prière. "Dieu des chrétiens, toi que j’ignore". Largo – Tempo I', part.name_en = 'Herminie, H. 29: Prière. "Dieu des chrétiens, toi que j’ignore". Largo – Tempo I',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 1380 AND p.composer_id = 37 AND part.part_key = 'musicbrainz:dab2051d-23ca-4d1f-9c93-7556ba88f495' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:dab2051d-23ca-4d1f-9c93-7556ba88f495', 7, NULL, 'Prière. "Dieu des chrétiens, toi que j’ignore". Largo – Tempo I', 'Herminie, H. 29: Prière. "Dieu des chrétiens, toi que j’ignore". Largo – Tempo I', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 1380 AND p.composer_id = 37
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:dab2051d-23ca-4d1f-9c93-7556ba88f495'
);


-- None Huit scènes de Faust

UPDATE pieces piece
SET piece.title = 'Huit scènes de Faust', piece.title_en = 'Huit scènes de Faust',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 836 AND piece.composer_id = 37
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'Chant de la fête de Pâques', part.name_en = 'Huit scènes de Faust: No. 1. Chant de la fête de Pâques',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 836 AND p.composer_id = 37 AND part.part_key = 'musicbrainz:6304b81b-6760-455d-9a13-6f2ccabcc10b' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:6304b81b-6760-455d-9a13-6f2ccabcc10b', 1, NULL, 'Chant de la fête de Pâques', 'Huit scènes de Faust: No. 1. Chant de la fête de Pâques', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 836 AND p.composer_id = 37
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:6304b81b-6760-455d-9a13-6f2ccabcc10b'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'Paysans sous les tilleuls, dans et chant', part.name_en = 'Huit scènes de Faust: No. 2. Paysans sous les tilleuls, dans et chant',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 836 AND p.composer_id = 37 AND part.part_key = 'musicbrainz:d8f0b8bf-597b-461f-92d6-85b16abaab2c' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:d8f0b8bf-597b-461f-92d6-85b16abaab2c', 2, NULL, 'Paysans sous les tilleuls, dans et chant', 'Huit scènes de Faust: No. 2. Paysans sous les tilleuls, dans et chant', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 836 AND p.composer_id = 37
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:d8f0b8bf-597b-461f-92d6-85b16abaab2c'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = NULL,
    part.name_ko = 'Concert de Sylphes', part.name_en = 'Huit scènes de Faust: No. 3. Concert de Sylphes',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 836 AND p.composer_id = 37 AND part.part_key = 'musicbrainz:89fb2a4a-8d6c-473e-a57d-18de2dcc4f3b' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:89fb2a4a-8d6c-473e-a57d-18de2dcc4f3b', 3, NULL, 'Concert de Sylphes', 'Huit scènes de Faust: No. 3. Concert de Sylphes', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 836 AND p.composer_id = 37
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:89fb2a4a-8d6c-473e-a57d-18de2dcc4f3b'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = NULL,
    part.name_ko = 'Écot de joyeux compagnons, histoire d’un rat', part.name_en = 'Huit scènes de Faust: No. 4. Écot de joyeux compagnons, histoire d’un rat',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 836 AND p.composer_id = 37 AND part.part_key = 'musicbrainz:4277777b-1b6a-4518-8e7f-5b328edd6db1' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:4277777b-1b6a-4518-8e7f-5b328edd6db1', 4, NULL, 'Écot de joyeux compagnons, histoire d’un rat', 'Huit scènes de Faust: No. 4. Écot de joyeux compagnons, histoire d’un rat', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 836 AND p.composer_id = 37
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:4277777b-1b6a-4518-8e7f-5b328edd6db1'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 5, part.movement_number = NULL,
    part.name_ko = 'Chanson de Méphistophélès, histoire d’une puce', part.name_en = 'Huit scènes de Faust: No. 5. Chanson de Méphistophélès, histoire d’une puce',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 836 AND p.composer_id = 37 AND part.part_key = 'musicbrainz:c059eb73-755d-49d8-bda3-9b792a27ba54' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:c059eb73-755d-49d8-bda3-9b792a27ba54', 5, NULL, 'Chanson de Méphistophélès, histoire d’une puce', 'Huit scènes de Faust: No. 5. Chanson de Méphistophélès, histoire d’une puce', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 836 AND p.composer_id = 37
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:c059eb73-755d-49d8-bda3-9b792a27ba54'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 6, part.movement_number = NULL,
    part.name_ko = 'Romance de Marguerite, chœur des soldats', part.name_en = 'Huit scènes de Faust: No. 7. Romance de Marguerite, chœur des soldats',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 836 AND p.composer_id = 37 AND part.part_key = 'musicbrainz:b77cb1c0-b88d-48c8-9efd-33683c309427' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:b77cb1c0-b88d-48c8-9efd-33683c309427', 6, NULL, 'Romance de Marguerite, chœur des soldats', 'Huit scènes de Faust: No. 7. Romance de Marguerite, chœur des soldats', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 836 AND p.composer_id = 37
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:b77cb1c0-b88d-48c8-9efd-33683c309427'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 7, part.movement_number = NULL,
    part.name_ko = 'Sérénade de Méphistophélès "Maintenant que le ciel brille" / "Devant la maison"', part.name_en = 'Huit scènes de Faust: No. 8. Sérénade de Méphistophélès "Maintenant que le ciel brille" / "Devant la maison"',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 836 AND p.composer_id = 37 AND part.part_key = 'musicbrainz:249a3888-541a-349b-9e57-ebf7507fb0ac' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:249a3888-541a-349b-9e57-ebf7507fb0ac', 7, NULL, 'Sérénade de Méphistophélès "Maintenant que le ciel brille" / "Devant la maison"', 'Huit scènes de Faust: No. 8. Sérénade de Méphistophélès "Maintenant que le ciel brille" / "Devant la maison"', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 836 AND p.composer_id = 37
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:249a3888-541a-349b-9e57-ebf7507fb0ac'
);


-- H. 100 Hymne pour l'élévation

UPDATE pieces piece
SET piece.title = 'Hymne pour l''élévation', piece.title_en = 'Hymne pour l''élévation, H. 100',
    piece.type = 'song', piece.opus_number = 'H. 100',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 2906 AND piece.composer_id = 37
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Hymne pour la consécration du nouveau tabernacle

UPDATE pieces piece
SET piece.title = 'Hymne pour la consécration du nouveau tabernacle', piece.title_en = 'Hymne pour la consécration du nouveau tabernacle',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 2599 AND piece.composer_id = 37
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- H. 97 Hymne à la France

UPDATE pieces piece
SET piece.title = 'Hymne à la France', piece.title_en = 'Hymne à la France, H. 97',
    piece.type = 'song', piece.opus_number = 'H. 97',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 2348 AND piece.composer_id = 37
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- H. 54 Intrata di Rob-Roy MacGregor

UPDATE pieces piece
SET piece.title = 'Intrata di Rob-Roy MacGregor', piece.title_en = 'Intrata di Rob-Roy MacGregor, H. 54',
    piece.type = 'song', piece.opus_number = 'H. 54',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 1814 AND piece.composer_id = 37
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None 가곡 <Je crois en vous>

UPDATE pieces piece
SET piece.title = '가곡 <Je crois en vous>', piece.title_en = 'Je crois en vous',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 1413 AND piece.composer_id = 37
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- H. 6 Je vais donc quitter pour jamais

UPDATE pieces piece
SET piece.title = 'Je vais donc quitter pour jamais', piece.title_en = 'Je vais donc quitter pour jamais, H. 6',
    piece.type = 'song', piece.opus_number = 'H. 6',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 2101 AND piece.composer_id = 37
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None 오라토리오 <L'Enfance du Christ>

UPDATE pieces piece
SET piece.title = '오라토리오 <L''Enfance du Christ>', piece.title_en = 'L''Enfance du Christ',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 2770 AND piece.composer_id = 37
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'Première partie « Le Songe d’Hérode »', part.name_en = 'L''Enfance du Christ : Première partie « Le Songe d’Hérode »',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 2770 AND p.composer_id = 37 AND part.part_key = 'musicbrainz:4998d9f4-c1f2-4a3f-a060-4857b543a581' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:4998d9f4-c1f2-4a3f-a060-4857b543a581', 1, NULL, 'Première partie « Le Songe d’Hérode »', 'L''Enfance du Christ : Première partie « Le Songe d’Hérode »', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 2770 AND p.composer_id = 37
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:4998d9f4-c1f2-4a3f-a060-4857b543a581'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:4998d9f4-c1f2-4a3f-a060-4857b543a581'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'Première partie, prologue « Dans la crèche, en ce temps » (Le Récitant)', part.name_en = 'L''Enfance du Christ : Première partie, prologue « Dans la crèche, en ce temps » (Le Récitant)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 2770 AND p.composer_id = 37 AND part.part_key = 'musicbrainz:d45ed166-a96a-451b-8f6d-4938a3bccda0' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:d45ed166-a96a-451b-8f6d-4938a3bccda0', 1, NULL, 'Première partie, prologue « Dans la crèche, en ce temps » (Le Récitant)', 'L''Enfance du Christ : Première partie, prologue « Dans la crèche, en ce temps » (Le Récitant)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:4998d9f4-c1f2-4a3f-a060-4857b543a581'
WHERE p.id = 2770 AND p.composer_id = 37
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:d45ed166-a96a-451b-8f6d-4938a3bccda0'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:4998d9f4-c1f2-4a3f-a060-4857b543a581'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'Première partie, scène 1. Marche nocturne « Qui vient ? » (Un centurion, Polydorus)', part.name_en = 'L''Enfance du Christ : Première partie, scène 1. Marche nocturne « Qui vient ? » (Un centurion, Polydorus)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 2770 AND p.composer_id = 37 AND part.part_key = 'musicbrainz:872c7b56-4f6b-4913-a739-43ded204bdd0' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:872c7b56-4f6b-4913-a739-43ded204bdd0', 2, NULL, 'Première partie, scène 1. Marche nocturne « Qui vient ? » (Un centurion, Polydorus)', 'L''Enfance du Christ : Première partie, scène 1. Marche nocturne « Qui vient ? » (Un centurion, Polydorus)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:4998d9f4-c1f2-4a3f-a060-4857b543a581'
WHERE p.id = 2770 AND p.composer_id = 37
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:872c7b56-4f6b-4913-a739-43ded204bdd0'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:4998d9f4-c1f2-4a3f-a060-4857b543a581'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = NULL,
    part.name_ko = 'Première partie, scène 2. Air d’Hérode « Toujours ce rêve ! encore cet enfant » (Hérode)', part.name_en = 'L’Enfance du Christ : Première partie, scène 2. Air d’Hérode « Toujours ce rêve ! encore cet enfant » (Hérode)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 2770 AND p.composer_id = 37 AND part.part_key = 'musicbrainz:c4cee86e-52fb-40f1-a1d6-37cb89664067' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:c4cee86e-52fb-40f1-a1d6-37cb89664067', 3, NULL, 'Première partie, scène 2. Air d’Hérode « Toujours ce rêve ! encore cet enfant » (Hérode)', 'L’Enfance du Christ : Première partie, scène 2. Air d’Hérode « Toujours ce rêve ! encore cet enfant » (Hérode)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:4998d9f4-c1f2-4a3f-a060-4857b543a581'
WHERE p.id = 2770 AND p.composer_id = 37
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:c4cee86e-52fb-40f1-a1d6-37cb89664067'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:4998d9f4-c1f2-4a3f-a060-4857b543a581'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = NULL,
    part.name_ko = 'Première partie, scène 3. Récit « Seigneur ! » (Polydorus, Hérode)', part.name_en = 'L’Enfance du Christ : Première partie, scène 3. Récit « Seigneur ! » (Polydorus, Hérode)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 2770 AND p.composer_id = 37 AND part.part_key = 'musicbrainz:04a8477a-9c29-4b7d-9c7a-211aa7418ccf' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:04a8477a-9c29-4b7d-9c7a-211aa7418ccf', 4, NULL, 'Première partie, scène 3. Récit « Seigneur ! » (Polydorus, Hérode)', 'L’Enfance du Christ : Première partie, scène 3. Récit « Seigneur ! » (Polydorus, Hérode)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:4998d9f4-c1f2-4a3f-a060-4857b543a581'
WHERE p.id = 2770 AND p.composer_id = 37
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:04a8477a-9c29-4b7d-9c7a-211aa7418ccf'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:4998d9f4-c1f2-4a3f-a060-4857b543a581'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 5, part.movement_number = NULL,
    part.name_ko = 'Première partie, scène 4. Hérode et les devins « Les sages de Judée » (Les Devins, Hérode)', part.name_en = 'L’Enfance du Christ : Première partie, scène 4. Hérode et les devins « Les sages de Judée » (Les Devins, Hérode)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 2770 AND p.composer_id = 37 AND part.part_key = 'musicbrainz:fe64459c-6fec-46c8-a8dd-03d540e1e635' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:fe64459c-6fec-46c8-a8dd-03d540e1e635', 5, NULL, 'Première partie, scène 4. Hérode et les devins « Les sages de Judée » (Les Devins, Hérode)', 'L’Enfance du Christ : Première partie, scène 4. Hérode et les devins « Les sages de Judée » (Les Devins, Hérode)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:4998d9f4-c1f2-4a3f-a060-4857b543a581'
WHERE p.id = 2770 AND p.composer_id = 37
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:fe64459c-6fec-46c8-a8dd-03d540e1e635'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:4998d9f4-c1f2-4a3f-a060-4857b543a581'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 6, part.movement_number = NULL,
    part.name_ko = 'Première partie, scène 5. L’Étable de Bethléem « Ô mon cher fils » (La Vierge Marie, Joseph)', part.name_en = 'L''Enfance du Christ : Première partie, scène 5. L’Étable de Bethléem « Ô mon cher fils » (La Vierge Marie, Joseph)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 2770 AND p.composer_id = 37 AND part.part_key = 'musicbrainz:d93e7d3a-56b5-4559-a145-968257d65c0f' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:d93e7d3a-56b5-4559-a145-968257d65c0f', 6, NULL, 'Première partie, scène 5. L’Étable de Bethléem « Ô mon cher fils » (La Vierge Marie, Joseph)', 'L''Enfance du Christ : Première partie, scène 5. L’Étable de Bethléem « Ô mon cher fils » (La Vierge Marie, Joseph)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:4998d9f4-c1f2-4a3f-a060-4857b543a581'
WHERE p.id = 2770 AND p.composer_id = 37
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:d93e7d3a-56b5-4559-a145-968257d65c0f'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:4998d9f4-c1f2-4a3f-a060-4857b543a581'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 7, part.movement_number = NULL,
    part.name_ko = 'Première partie, scène 6. Chœur d''anges « Joseph ! Marie ! Écoutez‐nous » (Chœur d’anges, La Vierge Marie, Joseph)', part.name_en = 'L''Enfance du Christ : Première partie, scène 6. Chœur d''anges « Joseph ! Marie ! Écoutez‐nous » (Chœur d’anges, La Vierge Marie, Joseph)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 2770 AND p.composer_id = 37 AND part.part_key = 'musicbrainz:6ad41cbc-71fc-4f9e-b16f-b5e13c2d20b5' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:6ad41cbc-71fc-4f9e-b16f-b5e13c2d20b5', 7, NULL, 'Première partie, scène 6. Chœur d''anges « Joseph ! Marie ! Écoutez‐nous » (Chœur d’anges, La Vierge Marie, Joseph)', 'L''Enfance du Christ : Première partie, scène 6. Chœur d''anges « Joseph ! Marie ! Écoutez‐nous » (Chœur d’anges, La Vierge Marie, Joseph)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:4998d9f4-c1f2-4a3f-a060-4857b543a581'
WHERE p.id = 2770 AND p.composer_id = 37
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:6ad41cbc-71fc-4f9e-b16f-b5e13c2d20b5'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'Deuxième partie « La Fuite en Égypte »', part.name_en = 'L''Enfance du Christ : Deuxième partie « La Fuite en Égypte »',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 2770 AND p.composer_id = 37 AND part.part_key = 'musicbrainz:94640641-dd2f-4b62-889a-0ee213a234c4' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:94640641-dd2f-4b62-889a-0ee213a234c4', 2, NULL, 'Deuxième partie « La Fuite en Égypte »', 'L''Enfance du Christ : Deuxième partie « La Fuite en Égypte »', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 2770 AND p.composer_id = 37
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:94640641-dd2f-4b62-889a-0ee213a234c4'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:94640641-dd2f-4b62-889a-0ee213a234c4'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'Deuxième partie no. 7. Ouverture', part.name_en = 'L''Enfance du Christ, op. 25 : Deuxième partie no. 7. Ouverture',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 2770 AND p.composer_id = 37 AND part.part_key = 'musicbrainz:08e8a3cb-e24b-4d07-a6a3-a3287694d38e' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:08e8a3cb-e24b-4d07-a6a3-a3287694d38e', 1, NULL, 'Deuxième partie no. 7. Ouverture', 'L''Enfance du Christ, op. 25 : Deuxième partie no. 7. Ouverture', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:94640641-dd2f-4b62-889a-0ee213a234c4'
WHERE p.id = 2770 AND p.composer_id = 37
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:08e8a3cb-e24b-4d07-a6a3-a3287694d38e'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:94640641-dd2f-4b62-889a-0ee213a234c4'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'Deuxième partie no. 8. Adieu des bergers à la sainte famille « Il s''en va loin de la terre » (Les bergers)', part.name_en = 'L''Enfance du Christ, op. 25 : Deuxième partie no. 8. Adieu des bergers à la sainte famille « Il s''en va loin de la terre » (Les bergers)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 2770 AND p.composer_id = 37 AND part.part_key = 'musicbrainz:70f91bf7-623e-3ead-ac3f-50eea25f3750' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:70f91bf7-623e-3ead-ac3f-50eea25f3750', 2, NULL, 'Deuxième partie no. 8. Adieu des bergers à la sainte famille « Il s''en va loin de la terre » (Les bergers)', 'L''Enfance du Christ, op. 25 : Deuxième partie no. 8. Adieu des bergers à la sainte famille « Il s''en va loin de la terre » (Les bergers)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:94640641-dd2f-4b62-889a-0ee213a234c4'
WHERE p.id = 2770 AND p.composer_id = 37
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:70f91bf7-623e-3ead-ac3f-50eea25f3750'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:94640641-dd2f-4b62-889a-0ee213a234c4'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = NULL,
    part.name_ko = 'Deuxième partie no. 9. Le Repos de la Sainte Famille « Les pèlerins étant venus » (Le Récitant, Chœur d’anges)', part.name_en = 'L''Enfance du Christ, op. 25 : Deuxième partie no. 9. Le Repos de la Sainte Famille « Les pèlerins étant venus » (Le Récitant, Chœur d’anges)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 2770 AND p.composer_id = 37 AND part.part_key = 'musicbrainz:f879e0e4-a864-343c-95ee-b0960fac858b' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:f879e0e4-a864-343c-95ee-b0960fac858b', 3, NULL, 'Deuxième partie no. 9. Le Repos de la Sainte Famille « Les pèlerins étant venus » (Le Récitant, Chœur d’anges)', 'L''Enfance du Christ, op. 25 : Deuxième partie no. 9. Le Repos de la Sainte Famille « Les pèlerins étant venus » (Le Récitant, Chœur d’anges)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:94640641-dd2f-4b62-889a-0ee213a234c4'
WHERE p.id = 2770 AND p.composer_id = 37
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:f879e0e4-a864-343c-95ee-b0960fac858b'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = NULL,
    part.name_ko = 'Troisième partie « L’Arrivée à Saïs »', part.name_en = 'L’Enfance du Christ : Troisième partie « L’Arrivée à Saïs »',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 2770 AND p.composer_id = 37 AND part.part_key = 'musicbrainz:ec8b21c9-7c85-4c5e-8276-39213b729614' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:ec8b21c9-7c85-4c5e-8276-39213b729614', 3, NULL, 'Troisième partie « L’Arrivée à Saïs »', 'L’Enfance du Christ : Troisième partie « L’Arrivée à Saïs »', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 2770 AND p.composer_id = 37
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:ec8b21c9-7c85-4c5e-8276-39213b729614'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:ec8b21c9-7c85-4c5e-8276-39213b729614'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'Troisième partie no. 10. « Depuis trois jours, malgré l’ardeur du vent » (Le Récitant)', part.name_en = 'L’Enfance du Christ : Troisième partie no. 10. « Depuis trois jours, malgré l’ardeur du vent » (Le Récitant)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 2770 AND p.composer_id = 37 AND part.part_key = 'musicbrainz:8348b3c7-aad8-4998-9254-9a9475857061' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:8348b3c7-aad8-4998-9254-9a9475857061', 1, NULL, 'Troisième partie no. 10. « Depuis trois jours, malgré l’ardeur du vent » (Le Récitant)', 'L’Enfance du Christ : Troisième partie no. 10. « Depuis trois jours, malgré l’ardeur du vent » (Le Récitant)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:ec8b21c9-7c85-4c5e-8276-39213b729614'
WHERE p.id = 2770 AND p.composer_id = 37
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:8348b3c7-aad8-4998-9254-9a9475857061'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:ec8b21c9-7c85-4c5e-8276-39213b729614'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'Troisième partie no. 11. « Dans cette ville immense » (La Vierge Marie, Joseph, Chœur)', part.name_en = 'L''Enfance du Christ : Troisième partie no. 11. « Dans cette ville immense » (La Vierge Marie, Joseph, Chœur)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 2770 AND p.composer_id = 37 AND part.part_key = 'musicbrainz:13dec8d6-3a18-4bcb-94f4-f189a661e507' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:13dec8d6-3a18-4bcb-94f4-f189a661e507', 2, NULL, 'Troisième partie no. 11. « Dans cette ville immense » (La Vierge Marie, Joseph, Chœur)', 'L''Enfance du Christ : Troisième partie no. 11. « Dans cette ville immense » (La Vierge Marie, Joseph, Chœur)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:ec8b21c9-7c85-4c5e-8276-39213b729614'
WHERE p.id = 2770 AND p.composer_id = 37
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:13dec8d6-3a18-4bcb-94f4-f189a661e507'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:ec8b21c9-7c85-4c5e-8276-39213b729614'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = NULL,
    part.name_ko = 'Troisième partie no. 12. L''intérieur de la maison des Ismaélites « Entrez, entrez, pauvres Hébreux » (Le père de famille, Joseph, Chœur)', part.name_en = 'L''Enfance du Christ : Troisième partie no. 12. L''intérieur de la maison des Ismaélites « Entrez, entrez, pauvres Hébreux » (Le père de famille, Joseph, Chœur)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 2770 AND p.composer_id = 37 AND part.part_key = 'musicbrainz:c2d11ea9-b7ac-4e79-9a40-ac37d1df828d' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:c2d11ea9-b7ac-4e79-9a40-ac37d1df828d', 3, NULL, 'Troisième partie no. 12. L''intérieur de la maison des Ismaélites « Entrez, entrez, pauvres Hébreux » (Le père de famille, Joseph, Chœur)', 'L''Enfance du Christ : Troisième partie no. 12. L''intérieur de la maison des Ismaélites « Entrez, entrez, pauvres Hébreux » (Le père de famille, Joseph, Chœur)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:ec8b21c9-7c85-4c5e-8276-39213b729614'
WHERE p.id = 2770 AND p.composer_id = 37
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:c2d11ea9-b7ac-4e79-9a40-ac37d1df828d'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:ec8b21c9-7c85-4c5e-8276-39213b729614'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = NULL,
    part.name_ko = 'Troisième partie. Trio pour deux flûtes et harpe exécuté par les jeunes Ismaélites', part.name_en = 'L’Enfance du Christ : Troisième partie. Trio pour deux flûtes et harpe exécuté par les jeunes Ismaélites',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 2770 AND p.composer_id = 37 AND part.part_key = 'musicbrainz:330aae7c-07da-43c4-99b4-c0c649901fac' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:330aae7c-07da-43c4-99b4-c0c649901fac', 4, NULL, 'Troisième partie. Trio pour deux flûtes et harpe exécuté par les jeunes Ismaélites', 'L’Enfance du Christ : Troisième partie. Trio pour deux flûtes et harpe exécuté par les jeunes Ismaélites', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:ec8b21c9-7c85-4c5e-8276-39213b729614'
WHERE p.id = 2770 AND p.composer_id = 37
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:330aae7c-07da-43c4-99b4-c0c649901fac'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:ec8b21c9-7c85-4c5e-8276-39213b729614'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 5, part.movement_number = NULL,
    part.name_ko = 'Troisième partie no. 14 « Vous pleurez, jeune mère » (Le Père de famille, La Vierge Marie, Joseph, Chœur)', part.name_en = 'L''Enfance du Christ : Troisième partie no. 14 « Vous pleurez, jeune mère » (Le Père de famille, La Vierge Marie, Joseph, Chœur)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 2770 AND p.composer_id = 37 AND part.part_key = 'musicbrainz:cff6b294-519c-40b6-96fc-be58ec93c3c3' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:cff6b294-519c-40b6-96fc-be58ec93c3c3', 5, NULL, 'Troisième partie no. 14 « Vous pleurez, jeune mère » (Le Père de famille, La Vierge Marie, Joseph, Chœur)', 'L''Enfance du Christ : Troisième partie no. 14 « Vous pleurez, jeune mère » (Le Père de famille, La Vierge Marie, Joseph, Chœur)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:ec8b21c9-7c85-4c5e-8276-39213b729614'
WHERE p.id = 2770 AND p.composer_id = 37
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:cff6b294-519c-40b6-96fc-be58ec93c3c3'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:ec8b21c9-7c85-4c5e-8276-39213b729614'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 6, part.movement_number = NULL,
    part.name_ko = 'Troisième partie no. 15. Épilogue «Ô mon âme, pour toi que reste-t-il à faire » (Le Récitant, Chœur)', part.name_en = 'L''Enfance du Christ : Troisième partie no. 15. Épilogue «Ô mon âme, pour toi que reste-t-il à faire » (Le Récitant, Chœur)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 2770 AND p.composer_id = 37 AND part.part_key = 'musicbrainz:1d84c7d1-d378-4715-8f4c-c7242da5a45f' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:1d84c7d1-d378-4715-8f4c-c7242da5a45f', 6, NULL, 'Troisième partie no. 15. Épilogue «Ô mon âme, pour toi que reste-t-il à faire » (Le Récitant, Chœur)', 'L''Enfance du Christ : Troisième partie no. 15. Épilogue «Ô mon âme, pour toi que reste-t-il à faire » (Le Récitant, Chœur)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:ec8b21c9-7c85-4c5e-8276-39213b729614'
WHERE p.id = 2770 AND p.composer_id = 37
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:1d84c7d1-d378-4715-8f4c-c7242da5a45f'
);


-- Op. 26 칸타타 <L'Impériale>

UPDATE pieces piece
SET piece.title = '칸타타 <L''Impériale>', piece.title_en = 'L''Impériale, op. 26, H. 129',
    piece.type = 'song', piece.opus_number = 'Op. 26',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 1991 AND piece.composer_id = 37
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- H. 60A La Captive orientale

UPDATE pieces piece
SET piece.title = 'La Captive orientale', piece.title_en = 'La Captive orientale, H. 60A',
    piece.type = 'song', piece.opus_number = 'H. 60A',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 2846 AND piece.composer_id = 37
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- H. 60B La Captive orientale H. 60B

UPDATE pieces piece
SET piece.title = 'La Captive orientale H. 60B', piece.title_en = 'La Captive orientale, H. 60B',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = 'H.', piece.catalogue_number = '60B',
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 2827 AND piece.composer_id = 37
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- H. 60D La Captive orientale H. 60D

UPDATE pieces piece
SET piece.title = 'La Captive orientale H. 60D', piece.title_en = 'La Captive orientale, H. 60D',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = 'H.', piece.catalogue_number = '60D',
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 2969 AND piece.composer_id = 37
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- H. 60E La Captive orientale H. 60E

UPDATE pieces piece
SET piece.title = 'La Captive orientale H. 60E', piece.title_en = 'La Captive orientale, H. 60E',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = 'H.', piece.catalogue_number = '60E',
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 1573 AND piece.composer_id = 37
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- H. 60F La Captive orientale H. 60F

UPDATE pieces piece
SET piece.title = 'La Captive orientale H. 60F', piece.title_en = 'La Captive orientale, H. 60F',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = 'H.', piece.catalogue_number = '60F',
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 2904 AND piece.composer_id = 37
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- Op. 12 가곡 <La Captive. Orientale for mezzo‐soprano and orchestra>

UPDATE pieces piece
SET piece.title = '가곡 <La Captive. Orientale for mezzo‐soprano and orchestra>', piece.title_en = 'La Captive. Orientale for mezzo‐soprano and orchestra, op. 12',
    piece.type = 'song', piece.opus_number = 'Op. 12',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 1858 AND piece.composer_id = 37
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None 오페라 <La Damnation De Faust - Hungarian March>

UPDATE pieces piece
SET piece.title = '오페라 <La Damnation De Faust - Hungarian March>', piece.title_en = 'La Damnation De Faust - Hungarian March',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 1600 AND piece.composer_id = 37
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None 칸타타 <La Mort de Cléopâtre, scène lyrique>

UPDATE pieces piece
SET piece.title = '칸타타 <La Mort de Cléopâtre, scène lyrique>', piece.title_en = 'La Mort de Cléopâtre, scène lyrique',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 562 AND piece.composer_id = 37
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'Allegro vivace con impeto – Récit « C’en est donc fait ! »', part.name_en = 'La Mort de Cléopâtre : I. Allegro vivace con impeto – Récit « C’en est donc fait ! »',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 562 AND p.composer_id = 37 AND part.part_key = 'musicbrainz:82bff0a1-983b-3f83-942d-dd8b2a37dbc1' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:82bff0a1-983b-3f83-942d-dd8b2a37dbc1', 1, 'I', 'Allegro vivace con impeto – Récit « C’en est donc fait ! »', 'La Mort de Cléopâtre : I. Allegro vivace con impeto – Récit « C’en est donc fait ! »', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 562 AND p.composer_id = 37
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:82bff0a1-983b-3f83-942d-dd8b2a37dbc1'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'Lento cantabile « Ah ! qu’ils sont loin ces jours, tourment de ma mémoire »', part.name_en = 'La Mort de Cléopâtre : II. Lento cantabile « Ah ! qu’ils sont loin ces jours, tourment de ma mémoire »',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 562 AND p.composer_id = 37 AND part.part_key = 'musicbrainz:ed494819-e14c-465c-86d4-057e70a27cb1' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:ed494819-e14c-465c-86d4-057e70a27cb1', 2, 'II', 'Lento cantabile « Ah ! qu’ils sont loin ces jours, tourment de ma mémoire »', 'La Mort de Cléopâtre : II. Lento cantabile « Ah ! qu’ils sont loin ces jours, tourment de ma mémoire »', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 562 AND p.composer_id = 37
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:ed494819-e14c-465c-86d4-057e70a27cb1'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = 'Méditation. Largo misterioso « Grands Pharaons, nobles Lagides »', part.name_en = 'La Mort de Cléopâtre : III. Méditation. Largo misterioso « Grands Pharaons, nobles Lagides »',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 562 AND p.composer_id = 37 AND part.part_key = 'musicbrainz:eac81326-5042-32b2-9ba0-823bba444404' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:eac81326-5042-32b2-9ba0-823bba444404', 3, 'III', 'Méditation. Largo misterioso « Grands Pharaons, nobles Lagides »', 'La Mort de Cléopâtre : III. Méditation. Largo misterioso « Grands Pharaons, nobles Lagides »', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 562 AND p.composer_id = 37
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:eac81326-5042-32b2-9ba0-823bba444404'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = 'IV',
    part.name_ko = 'Allegro assai agitato « Non !… non, de vos demeures funèbres »', part.name_en = 'La Mort de Cléopâtre : IV. Allegro assai agitato « Non !… non, de vos demeures funèbres »',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 562 AND p.composer_id = 37 AND part.part_key = 'musicbrainz:c26afde0-8125-4ce3-8ef1-6ef37758fd39' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:c26afde0-8125-4ce3-8ef1-6ef37758fd39', 4, 'IV', 'Allegro assai agitato « Non !… non, de vos demeures funèbres »', 'La Mort de Cléopâtre : IV. Allegro assai agitato « Non !… non, de vos demeures funèbres »', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 562 AND p.composer_id = 37
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:c26afde0-8125-4ce3-8ef1-6ef37758fd39'
);


-- H. 50 칸타타 <La Mort de Sardanapale>

UPDATE pieces piece
SET piece.title = '칸타타 <La Mort de Sardanapale>', piece.title_en = 'La Mort de Sardanapale, H. 50',
    piece.type = 'song', piece.opus_number = 'H. 50',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 1487 AND piece.composer_id = 37
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None 칸타타 <La Mort d’Orphée>

UPDATE pieces piece
SET piece.title = '칸타타 <La Mort d’Orphée>', piece.title_en = 'La Mort d’Orphée',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 616 AND piece.composer_id = 37
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- H. 91 오페라 <La Nonne sanglante>

UPDATE pieces piece
SET piece.title = '오페라 <La Nonne sanglante>', piece.title_en = 'La Nonne sanglante, H. 91',
    piece.type = 'song', piece.opus_number = 'H. 91',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 1124 AND piece.composer_id = 37
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None 칸타타 <La Révolution grecque (scène héroïque)>

UPDATE pieces piece
SET piece.title = '칸타타 <La Révolution grecque (scène héroïque)>', piece.title_en = 'La Révolution grecque (scène héroïque)',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 2407 AND piece.composer_id = 37
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- H. 117 La menace des Francs

UPDATE pieces piece
SET piece.title = 'La menace des Francs', piece.title_en = 'La menace des Francs, H. 117',
    piece.type = 'song', piece.opus_number = 'H. 117',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 1395 AND piece.composer_id = 37
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None 가곡 <La mort d’Ophélie>

UPDATE pieces piece
SET piece.title = '가곡 <La mort d’Ophélie>', piece.title_en = 'La mort d’Ophélie',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 2967 AND piece.composer_id = 37
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- H. 21A 칸타타 <La révolution grecque (Scène héroïque)> H. 21A

UPDATE pieces piece
SET piece.title = '칸타타 <La révolution grecque (Scène héroïque)> H. 21A', piece.title_en = 'La révolution grecque (Scène héroïque), H. 21A',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = 'H.', piece.catalogue_number = '21A',
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 953 AND piece.composer_id = 37
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'Introduction. Récitatif et Air “Lève-toi, fils de Sparte !”', part.name_en = 'La révolution grecque (Scène héroïque), H. 21A: I. Introduction. Récitatif et Air “Lève-toi, fils de Sparte !”',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 953 AND p.composer_id = 37 AND part.part_key = 'musicbrainz:db395e5b-01ce-493a-b040-f8cb5484c21b' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:db395e5b-01ce-493a-b040-f8cb5484c21b', 1, 'I', 'Introduction. Récitatif et Air “Lève-toi, fils de Sparte !”', 'La révolution grecque (Scène héroïque), H. 21A: I. Introduction. Récitatif et Air “Lève-toi, fils de Sparte !”', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 953 AND p.composer_id = 37
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:db395e5b-01ce-493a-b040-f8cb5484c21b'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'Chœur des guerriers “Mais la voix du Dieu des armées”', part.name_en = 'La révolution grecque (Scène héroïque), H. 21A: II. Chœur des guerriers “Mais la voix du Dieu des armées”',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 953 AND p.composer_id = 37 AND part.part_key = 'musicbrainz:ec07e672-683c-4e14-abe7-cf890d8cb93a' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:ec07e672-683c-4e14-abe7-cf890d8cb93a', 2, 'II', 'Chœur des guerriers “Mais la voix du Dieu des armées”', 'La révolution grecque (Scène héroïque), H. 21A: II. Chœur des guerriers “Mais la voix du Dieu des armées”', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 953 AND p.composer_id = 37
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:ec07e672-683c-4e14-abe7-cf890d8cb93a'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = 'Prière “Astre terrible et saint, guide les pas du brave”', part.name_en = 'La révolution grecque (Scène héroïque), H. 21A: III. Prière “Astre terrible et saint, guide les pas du brave”',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 953 AND p.composer_id = 37 AND part.part_key = 'musicbrainz:731f334d-fab6-432a-9adc-c385c3c78c82' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:731f334d-fab6-432a-9adc-c385c3c78c82', 3, 'III', 'Prière “Astre terrible et saint, guide les pas du brave”', 'La révolution grecque (Scène héroïque), H. 21A: III. Prière “Astre terrible et saint, guide les pas du brave”', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 953 AND p.composer_id = 37
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:731f334d-fab6-432a-9adc-c385c3c78c82'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = 'IV',
    part.name_ko = 'Final “Des sommets de l''Olympe”', part.name_en = 'La révolution grecque (Scène héroïque), H. 21A: IV. Final “Des sommets de l''Olympe”',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 953 AND p.composer_id = 37 AND part.part_key = 'musicbrainz:bb862a88-b3ee-444e-a03d-4052eca4924e' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:bb862a88-b3ee-444e-a03d-4052eca4924e', 4, 'IV', 'Final “Des sommets de l''Olympe”', 'La révolution grecque (Scène héroïque), H. 21A: IV. Final “Des sommets de l''Olympe”', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 953 AND p.composer_id = 37
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:bb862a88-b3ee-444e-a03d-4052eca4924e'
);


-- H. 21B 칸타타 <La révolution grecque (Scène héroïque)> H. 21B

UPDATE pieces piece
SET piece.title = '칸타타 <La révolution grecque (Scène héroïque)> H. 21B', piece.title_en = 'La révolution grecque (Scène héroïque), H. 21B',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = 'H.', piece.catalogue_number = '21B',
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 1809 AND piece.composer_id = 37
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- Op. 2 Le Ballet des ombres

UPDATE pieces piece
SET piece.title = 'Le Ballet des ombres', piece.title_en = 'Le Ballet des ombres, op. 2',
    piece.type = 'song', piece.opus_number = 'Op. 2',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 1891 AND piece.composer_id = 37
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- Op. 6 칸타타 <Le Cinq mai>

UPDATE pieces piece
SET piece.title = '칸타타 <Le Cinq mai>', piece.title_en = 'Le Cinq mai, op. 6',
    piece.type = 'song', piece.opus_number = 'Op. 6',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 1792 AND piece.composer_id = 37
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None 가곡 <Le Dépit de la bergère>

UPDATE pieces piece
SET piece.title = '가곡 <Le Dépit de la bergère>', piece.title_en = 'Le Dépit de la bergère',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 2731 AND piece.composer_id = 37
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None 가곡 <Le Maure jaloux>

UPDATE pieces piece
SET piece.title = '가곡 <Le Maure jaloux>', piece.title_en = 'Le Maure jaloux',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 1501 AND piece.composer_id = 37
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None 가곡 <Le Montagnard exilé>

UPDATE pieces piece
SET piece.title = '가곡 <Le Montagnard exilé>', piece.title_en = 'Le Montagnard exilé',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 1408 AND piece.composer_id = 37
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- H. 137A Le Temple universel

UPDATE pieces piece
SET piece.title = 'Le Temple universel', piece.title_en = 'Le Temple universel, H. 137A',
    piece.type = 'song', piece.opus_number = 'H. 137A',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 2669 AND piece.composer_id = 37
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- H. 137B Le Temple universel H. 137B

UPDATE pieces piece
SET piece.title = 'Le Temple universel H. 137B', piece.title_en = 'Le Temple universel, H. 137B',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = 'H.', piece.catalogue_number = '137B',
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 2172 AND piece.composer_id = 37
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- Op. 19 No. 6 가곡 <Le chasseur danois>

UPDATE pieces piece
SET piece.title = '가곡 <Le chasseur danois>', piece.title_en = 'Le chasseur danois, op. 19 no. 6, H. 104A',
    piece.type = 'song', piece.opus_number = 'Op. 19 No. 6',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 517 AND piece.composer_id = 37
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- H 65 가곡 <Le jeune Pâtre breton>

UPDATE pieces piece
SET piece.title = '가곡 <Le jeune Pâtre breton>', piece.title_en = 'Le jeune Pâtre breton, H 65',
    piece.type = 'song', piece.opus_number = 'H 65',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 2543 AND piece.composer_id = 37
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None 가곡 <Le roi de Thulé>

UPDATE pieces piece
SET piece.title = '가곡 <Le roi de Thulé>', piece.title_en = 'Le roi de Thulé',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 2780 AND piece.composer_id = 37
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- H 23 오페라 <Les Francs-Juges> H 23

UPDATE pieces piece
SET piece.title = '오페라 <Les Francs-Juges> H 23', piece.title_en = 'Les Francs-Juges, H 23',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = 'H', piece.catalogue_number = '23',
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 2082 AND piece.composer_id = 37
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'Grande Ouverture des Francs-Juges, for orchestra, op. 3', part.name_en = 'Grande Ouverture des Francs-Juges, for orchestra, op. 3',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 2082 AND p.composer_id = 37 AND part.part_key = 'musicbrainz:4b8b840f-1e34-4af0-8a34-c405841a7d06' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:4b8b840f-1e34-4af0-8a34-c405841a7d06', 1, NULL, 'Grande Ouverture des Francs-Juges, for orchestra, op. 3', 'Grande Ouverture des Francs-Juges, for orchestra, op. 3', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 2082 AND p.composer_id = 37
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:4b8b840f-1e34-4af0-8a34-c405841a7d06'
);


-- Op. 7 연가곡집 <Les Nuits d’été> Op. 7

UPDATE pieces piece
SET piece.title = '연가곡집 <Les Nuits d’été> Op. 7', piece.title_en = 'Les Nuits d’été, H. 81, op. 7',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = 'Op.', piece.catalogue_number = '7',
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 1224 AND piece.composer_id = 37
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'Villanelle', part.name_en = 'Les Nuits d’été, H. 81, op. 7: Nº 1. Villanelle',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 1224 AND p.composer_id = 37 AND part.part_key = 'musicbrainz:88243074-d3a9-43df-af36-e68156df7c25' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:88243074-d3a9-43df-af36-e68156df7c25', 1, NULL, 'Villanelle', 'Les Nuits d’été, H. 81, op. 7: Nº 1. Villanelle', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 1224 AND p.composer_id = 37
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:88243074-d3a9-43df-af36-e68156df7c25'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'Le Spectre de la rose', part.name_en = 'Les Nuits d’été, H. 81, op. 7: Nº 2. Le Spectre de la rose',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 1224 AND p.composer_id = 37 AND part.part_key = 'musicbrainz:981cfdf2-d238-4a9e-a67b-835e60d2877f' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:981cfdf2-d238-4a9e-a67b-835e60d2877f', 2, NULL, 'Le Spectre de la rose', 'Les Nuits d’été, H. 81, op. 7: Nº 2. Le Spectre de la rose', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 1224 AND p.composer_id = 37
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:981cfdf2-d238-4a9e-a67b-835e60d2877f'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = NULL,
    part.name_ko = 'Sur les lagunes', part.name_en = 'Les Nuits d’été, H. 81, op. 7: Nº 3. Sur les lagunes',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 1224 AND p.composer_id = 37 AND part.part_key = 'musicbrainz:e4b84c71-7d2b-419d-8689-fbc6bfee4c3c' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:e4b84c71-7d2b-419d-8689-fbc6bfee4c3c', 3, NULL, 'Sur les lagunes', 'Les Nuits d’été, H. 81, op. 7: Nº 3. Sur les lagunes', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 1224 AND p.composer_id = 37
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:e4b84c71-7d2b-419d-8689-fbc6bfee4c3c'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = NULL,
    part.name_ko = 'Absence', part.name_en = 'Les Nuits d’été, H. 81, op. 7: Nº 4. Absence',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 1224 AND p.composer_id = 37 AND part.part_key = 'musicbrainz:2f3d7378-d5e9-4cac-bed7-e9b42facde6e' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:2f3d7378-d5e9-4cac-bed7-e9b42facde6e', 4, NULL, 'Absence', 'Les Nuits d’été, H. 81, op. 7: Nº 4. Absence', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 1224 AND p.composer_id = 37
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:2f3d7378-d5e9-4cac-bed7-e9b42facde6e'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 5, part.movement_number = NULL,
    part.name_ko = 'Au cimetière', part.name_en = 'Les Nuits d’été, H. 81, op. 7: Nº 5. Au cimetière',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 1224 AND p.composer_id = 37 AND part.part_key = 'musicbrainz:6e7261f3-421f-472b-b3df-e358e0348961' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:6e7261f3-421f-472b-b3df-e358e0348961', 5, NULL, 'Au cimetière', 'Les Nuits d’été, H. 81, op. 7: Nº 5. Au cimetière', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 1224 AND p.composer_id = 37
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:6e7261f3-421f-472b-b3df-e358e0348961'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 6, part.movement_number = NULL,
    part.name_ko = 'L’Île inconnue', part.name_en = 'Les Nuits d’été, H. 81, op. 7: Nº 6. L’Île inconnue',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 1224 AND p.composer_id = 37 AND part.part_key = 'musicbrainz:b420dc60-90fd-4298-aa7f-17c0efc1fcdb' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:b420dc60-90fd-4298-aa7f-17c0efc1fcdb', 6, NULL, 'L’Île inconnue', 'Les Nuits d’été, H. 81, op. 7: Nº 6. L’Île inconnue', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 1224 AND p.composer_id = 37
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:b420dc60-90fd-4298-aa7f-17c0efc1fcdb'
);


-- None 오페라 <Les Troyens>

UPDATE pieces piece
SET piece.title = '오페라 <Les Troyens>', piece.title_en = 'Les Troyens',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 607 AND piece.composer_id = 37
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'Acte I', part.name_en = 'Les Troyens : Acte I',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 607 AND p.composer_id = 37 AND part.part_key = 'musicbrainz:c04d778b-d0d9-462a-b445-f1d7107be75d' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:c04d778b-d0d9-462a-b445-f1d7107be75d', 1, NULL, 'Acte I', 'Les Troyens : Acte I', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 607 AND p.composer_id = 37
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:c04d778b-d0d9-462a-b445-f1d7107be75d'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:c04d778b-d0d9-462a-b445-f1d7107be75d'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'Chœur de la populace troyenne « Ha ! ha ! Après dix ans passés dans nos murailles » (Un soldat, chœur)', part.name_en = 'Les Troyens : Acte I, no. 1. Chœur de la populace troyenne « Ha ! ha ! Après dix ans passés dans nos murailles » (Un soldat, chœur)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 607 AND p.composer_id = 37 AND part.part_key = 'musicbrainz:e49e2e61-c974-4002-8095-66fcc61754a8' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:e49e2e61-c974-4002-8095-66fcc61754a8', 1, NULL, 'Chœur de la populace troyenne « Ha ! ha ! Après dix ans passés dans nos murailles » (Un soldat, chœur)', 'Les Troyens : Acte I, no. 1. Chœur de la populace troyenne « Ha ! ha ! Après dix ans passés dans nos murailles » (Un soldat, chœur)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:c04d778b-d0d9-462a-b445-f1d7107be75d'
WHERE p.id = 607 AND p.composer_id = 37
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:e49e2e61-c974-4002-8095-66fcc61754a8'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:c04d778b-d0d9-462a-b445-f1d7107be75d'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'Récitatif et air « Les Grecs ont disparu » … « Malheureux roi ! » (Cassandre)', part.name_en = 'Les Troyens : Acte I, no. 2. Récitatif et air « Les Grecs ont disparu » … « Malheureux roi ! » (Cassandre)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 607 AND p.composer_id = 37 AND part.part_key = 'musicbrainz:aab5bcec-d92f-4709-b665-5e66a09fe2d6' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:aab5bcec-d92f-4709-b665-5e66a09fe2d6', 2, NULL, 'Récitatif et air « Les Grecs ont disparu » … « Malheureux roi ! » (Cassandre)', 'Les Troyens : Acte I, no. 2. Récitatif et air « Les Grecs ont disparu » … « Malheureux roi ! » (Cassandre)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:c04d778b-d0d9-462a-b445-f1d7107be75d'
WHERE p.id = 607 AND p.composer_id = 37
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:aab5bcec-d92f-4709-b665-5e66a09fe2d6'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:c04d778b-d0d9-462a-b445-f1d7107be75d'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = NULL,
    part.name_ko = 'Duo: Duo « C’est lui ! » … « Quitte‐nous dès ce soir » (Cassandre, Chorèbe)', part.name_en = 'Les Troyens : Acte I, no. 3. Duo: Duo « C’est lui ! » … « Quitte‐nous dès ce soir » (Cassandre, Chorèbe)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 607 AND p.composer_id = 37 AND part.part_key = 'musicbrainz:fffd718a-3515-46c0-a2f9-1e5086182024' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:fffd718a-3515-46c0-a2f9-1e5086182024', 3, NULL, 'Duo: Duo « C’est lui ! » … « Quitte‐nous dès ce soir » (Cassandre, Chorèbe)', 'Les Troyens : Acte I, no. 3. Duo: Duo « C’est lui ! » … « Quitte‐nous dès ce soir » (Cassandre, Chorèbe)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:c04d778b-d0d9-462a-b445-f1d7107be75d'
WHERE p.id = 607 AND p.composer_id = 37
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:fffd718a-3515-46c0-a2f9-1e5086182024'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:c04d778b-d0d9-462a-b445-f1d7107be75d'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = NULL,
    part.name_ko = 'Marche et hymne « Dieux protecteurs de la ville éternelle » (Chœur)', part.name_en = 'Les Troyens : Acte I, no. 4. Marche et hymne « Dieux protecteurs de la ville éternelle » (Chœur)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 607 AND p.composer_id = 37 AND part.part_key = 'musicbrainz:116c6035-cc49-40b6-bf5b-aee2d8910c89' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:116c6035-cc49-40b6-bf5b-aee2d8910c89', 4, NULL, 'Marche et hymne « Dieux protecteurs de la ville éternelle » (Chœur)', 'Les Troyens : Acte I, no. 4. Marche et hymne « Dieux protecteurs de la ville éternelle » (Chœur)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:c04d778b-d0d9-462a-b445-f1d7107be75d'
WHERE p.id = 607 AND p.composer_id = 37
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:116c6035-cc49-40b6-bf5b-aee2d8910c89'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:c04d778b-d0d9-462a-b445-f1d7107be75d'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 5, part.movement_number = NULL,
    part.name_ko = 'Combat de ceste – Pas de lutteurs', part.name_en = 'Les Troyens : Acte I, no. 5. Combat de ceste – Pas de lutteurs',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 607 AND p.composer_id = 37 AND part.part_key = 'musicbrainz:a2732fcf-e210-48ec-a023-3af47fa0b557' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:a2732fcf-e210-48ec-a023-3af47fa0b557', 5, NULL, 'Combat de ceste – Pas de lutteurs', 'Les Troyens : Acte I, no. 5. Combat de ceste – Pas de lutteurs', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:c04d778b-d0d9-462a-b445-f1d7107be75d'
WHERE p.id = 607 AND p.composer_id = 37
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:a2732fcf-e210-48ec-a023-3af47fa0b557'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:c04d778b-d0d9-462a-b445-f1d7107be75d'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 6, part.movement_number = NULL,
    part.name_ko = 'Pantomime « Andromaque et son fils ! » (Cassandre, Chœur)', part.name_en = 'Les Troyens : Acte I, no. 6. Pantomime « Andromaque et son fils ! » (Cassandre, Chœur)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 607 AND p.composer_id = 37 AND part.part_key = 'musicbrainz:71ff7b00-3448-46fb-9c16-f1199a36628d' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:71ff7b00-3448-46fb-9c16-f1199a36628d', 6, NULL, 'Pantomime « Andromaque et son fils ! » (Cassandre, Chœur)', 'Les Troyens : Acte I, no. 6. Pantomime « Andromaque et son fils ! » (Cassandre, Chœur)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:c04d778b-d0d9-462a-b445-f1d7107be75d'
WHERE p.id = 607 AND p.composer_id = 37
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:71ff7b00-3448-46fb-9c16-f1199a36628d'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:c04d778b-d0d9-462a-b445-f1d7107be75d'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 7, part.movement_number = NULL,
    part.name_ko = 'Récit « Du peuple et des soldats » (Énée)', part.name_en = 'Les Troyens : Acte I, no. 7. Récit « Du peuple et des soldats » (Énée)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 607 AND p.composer_id = 37 AND part.part_key = 'musicbrainz:b4b99533-3573-4ef5-aa47-b92f229049d6' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:b4b99533-3573-4ef5-aa47-b92f229049d6', 7, NULL, 'Récit « Du peuple et des soldats » (Énée)', 'Les Troyens : Acte I, no. 7. Récit « Du peuple et des soldats » (Énée)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:c04d778b-d0d9-462a-b445-f1d7107be75d'
WHERE p.id = 607 AND p.composer_id = 37
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:b4b99533-3573-4ef5-aa47-b92f229049d6'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:c04d778b-d0d9-462a-b445-f1d7107be75d'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 8, part.movement_number = NULL,
    part.name_ko = 'Ottetto et double chœur « Châtiment effroyable ! » (Ascagne, Cassandre, Hécube, Énée, Hélénus, Chorèbe, Panthée)', part.name_en = 'Les Troyens : Acte I, no. 8. Ottetto et double chœur « Châtiment effroyable ! » (Ascagne, Cassandre, Hécube, Énée, Hélénus, Chorèbe, Panthée)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 607 AND p.composer_id = 37 AND part.part_key = 'musicbrainz:e364352c-1b97-47c2-b69a-0a2313747f5d' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:e364352c-1b97-47c2-b69a-0a2313747f5d', 8, NULL, 'Ottetto et double chœur « Châtiment effroyable ! » (Ascagne, Cassandre, Hécube, Énée, Hélénus, Chorèbe, Panthée)', 'Les Troyens : Acte I, no. 8. Ottetto et double chœur « Châtiment effroyable ! » (Ascagne, Cassandre, Hécube, Énée, Hélénus, Chorèbe, Panthée)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:c04d778b-d0d9-462a-b445-f1d7107be75d'
WHERE p.id = 607 AND p.composer_id = 37
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:e364352c-1b97-47c2-b69a-0a2313747f5d'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:c04d778b-d0d9-462a-b445-f1d7107be75d'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 9, part.movement_number = NULL,
    part.name_ko = 'Récitatif et chœur « Que la déesse nous protége » … « À cet objet sacré » (Enée, Priam, Cassandre, Hécube, Panthée, Chorèbe, Hélénius)', part.name_en = 'Les Troyens : Acte I, no. 9. Récitatif et chœur « Que la déesse nous protége » … « À cet objet sacré » (Enée, Priam, Cassandre, Hécube, Panthée, Chorèbe, Hélénius)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 607 AND p.composer_id = 37 AND part.part_key = 'musicbrainz:adccb625-ec73-4d4b-bb62-4ff4c737ec54' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:adccb625-ec73-4d4b-bb62-4ff4c737ec54', 9, NULL, 'Récitatif et chœur « Que la déesse nous protége » … « À cet objet sacré » (Enée, Priam, Cassandre, Hécube, Panthée, Chorèbe, Hélénius)', 'Les Troyens : Acte I, no. 9. Récitatif et chœur « Que la déesse nous protége » … « À cet objet sacré » (Enée, Priam, Cassandre, Hécube, Panthée, Chorèbe, Hélénius)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:c04d778b-d0d9-462a-b445-f1d7107be75d'
WHERE p.id = 607 AND p.composer_id = 37
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:adccb625-ec73-4d4b-bb62-4ff4c737ec54'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:c04d778b-d0d9-462a-b445-f1d7107be75d'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 10, part.movement_number = NULL,
    part.name_ko = 'Air « Non, je ne verrai pas la déplorable fête » (Cassandre)', part.name_en = 'Les Troyens : Acte I, no. 10. Air « Non, je ne verrai pas la déplorable fête » (Cassandre)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 607 AND p.composer_id = 37 AND part.part_key = 'musicbrainz:4bdf41a4-bc3f-4b33-8426-9d913b33ff5d' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:4bdf41a4-bc3f-4b33-8426-9d913b33ff5d', 10, NULL, 'Air « Non, je ne verrai pas la déplorable fête » (Cassandre)', 'Les Troyens : Acte I, no. 10. Air « Non, je ne verrai pas la déplorable fête » (Cassandre)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:c04d778b-d0d9-462a-b445-f1d7107be75d'
WHERE p.id = 607 AND p.composer_id = 37
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:4bdf41a4-bc3f-4b33-8426-9d913b33ff5d'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:c04d778b-d0d9-462a-b445-f1d7107be75d'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 11, part.movement_number = NULL,
    part.name_ko = 'Final: Marche troyenne « Du roi des Dieux, ô fille aimée » (Cassandre, Chœur)', part.name_en = 'Les Troyens : Acte I, no. 11. Final: Marche troyenne « Du roi des Dieux, ô fille aimée » (Cassandre, Chœur)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 607 AND p.composer_id = 37 AND part.part_key = 'musicbrainz:63705d40-6148-4dc4-88f6-cc592e26dcc7' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:63705d40-6148-4dc4-88f6-cc592e26dcc7', 11, NULL, 'Final: Marche troyenne « Du roi des Dieux, ô fille aimée » (Cassandre, Chœur)', 'Les Troyens : Acte I, no. 11. Final: Marche troyenne « Du roi des Dieux, ô fille aimée » (Cassandre, Chœur)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:c04d778b-d0d9-462a-b445-f1d7107be75d'
WHERE p.id = 607 AND p.composer_id = 37
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:63705d40-6148-4dc4-88f6-cc592e26dcc7'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'Acte II', part.name_en = 'Les Troyens : Acte II',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 607 AND p.composer_id = 37 AND part.part_key = 'musicbrainz:98649e4c-a8e6-4ab3-a158-d97359301f8f' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:98649e4c-a8e6-4ab3-a158-d97359301f8f', 2, NULL, 'Acte II', 'Les Troyens : Acte II', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 607 AND p.composer_id = 37
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:98649e4c-a8e6-4ab3-a158-d97359301f8f'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:98649e4c-a8e6-4ab3-a158-d97359301f8f'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'Introduction, scène et récitatif « O lumière de Troie ! » … « Ah ! fuis, fils de Vénus » (Enée, l’ombre d’Hector)', part.name_en = 'Les Troyens : Acte II, no. 12. Introduction, scène et récitatif « O lumière de Troie ! » … « Ah ! fuis, fils de Vénus » (Enée, l’ombre d’Hector)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 607 AND p.composer_id = 37 AND part.part_key = 'musicbrainz:4fa64987-448b-436f-8d55-6eaf979e4a4b' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:4fa64987-448b-436f-8d55-6eaf979e4a4b', 1, NULL, 'Introduction, scène et récitatif « O lumière de Troie ! » … « Ah ! fuis, fils de Vénus » (Enée, l’ombre d’Hector)', 'Les Troyens : Acte II, no. 12. Introduction, scène et récitatif « O lumière de Troie ! » … « Ah ! fuis, fils de Vénus » (Enée, l’ombre d’Hector)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:98649e4c-a8e6-4ab3-a158-d97359301f8f'
WHERE p.id = 607 AND p.composer_id = 37
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:4fa64987-448b-436f-8d55-6eaf979e4a4b'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:98649e4c-a8e6-4ab3-a158-d97359301f8f'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'Récitatif et chœur: « Quelle espérance » … « Le salut des vaincus » (Enée, Panthée, Ascagne, Chorèbe, Chœur)', part.name_en = 'Les Troyens : Acte II, no. 13. Récitatif et chœur: « Quelle espérance » … « Le salut des vaincus » (Enée, Panthée, Ascagne, Chorèbe, Chœur)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 607 AND p.composer_id = 37 AND part.part_key = 'musicbrainz:88aab2dc-3f83-4bd7-8261-88def78423a2' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:88aab2dc-3f83-4bd7-8261-88def78423a2', 2, NULL, 'Récitatif et chœur: « Quelle espérance » … « Le salut des vaincus » (Enée, Panthée, Ascagne, Chorèbe, Chœur)', 'Les Troyens : Acte II, no. 13. Récitatif et chœur: « Quelle espérance » … « Le salut des vaincus » (Enée, Panthée, Ascagne, Chorèbe, Chœur)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:98649e4c-a8e6-4ab3-a158-d97359301f8f'
WHERE p.id = 607 AND p.composer_id = 37
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:88aab2dc-3f83-4bd7-8261-88def78423a2'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:98649e4c-a8e6-4ab3-a158-d97359301f8f'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = NULL,
    part.name_ko = 'Chœur – Prière « Ha ! Puissante Cybèle »', part.name_en = 'Les Troyens : Acte II, no. 14. Chœur – Prière « Ha ! Puissante Cybèle »',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 607 AND p.composer_id = 37 AND part.part_key = 'musicbrainz:9b637f55-01bc-4001-a033-ff6779d92f34' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:9b637f55-01bc-4001-a033-ff6779d92f34', 3, NULL, 'Chœur – Prière « Ha ! Puissante Cybèle »', 'Les Troyens : Acte II, no. 14. Chœur – Prière « Ha ! Puissante Cybèle »', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:98649e4c-a8e6-4ab3-a158-d97359301f8f'
WHERE p.id = 607 AND p.composer_id = 37
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:9b637f55-01bc-4001-a033-ff6779d92f34'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:98649e4c-a8e6-4ab3-a158-d97359301f8f'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = NULL,
    part.name_ko = 'Récitatif et chœur « Tous ne périront pas » (Cassandre) … « O digne sœur d’Hector » (Chœur)', part.name_en = 'Les Troyens : Acte II, no. 15. Récitatif et chœur « Tous ne périront pas » (Cassandre) … « O digne sœur d’Hector » (Chœur)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 607 AND p.composer_id = 37 AND part.part_key = 'musicbrainz:54dbdacd-c212-48ba-b570-528562ce862d' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:54dbdacd-c212-48ba-b570-528562ce862d', 4, NULL, 'Récitatif et chœur « Tous ne périront pas » (Cassandre) … « O digne sœur d’Hector » (Chœur)', 'Les Troyens : Acte II, no. 15. Récitatif et chœur « Tous ne périront pas » (Cassandre) … « O digne sœur d’Hector » (Chœur)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:98649e4c-a8e6-4ab3-a158-d97359301f8f'
WHERE p.id = 607 AND p.composer_id = 37
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:54dbdacd-c212-48ba-b570-528562ce862d'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:98649e4c-a8e6-4ab3-a158-d97359301f8f'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 5, part.movement_number = NULL,
    part.name_ko = 'Final « Complices de sa gloire » … « Le trésor ! le trésor ! » (Cassandre, Chœur, un chef grec)', part.name_en = 'Les Troyens : Acte II, no. 16. Final « Complices de sa gloire » … « Le trésor ! le trésor ! » (Cassandre, Chœur, un chef grec)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 607 AND p.composer_id = 37 AND part.part_key = 'musicbrainz:46638202-b5f4-4234-aee3-87ad1518e0c1' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:46638202-b5f4-4234-aee3-87ad1518e0c1', 5, NULL, 'Final « Complices de sa gloire » … « Le trésor ! le trésor ! » (Cassandre, Chœur, un chef grec)', 'Les Troyens : Acte II, no. 16. Final « Complices de sa gloire » … « Le trésor ! le trésor ! » (Cassandre, Chœur, un chef grec)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:98649e4c-a8e6-4ab3-a158-d97359301f8f'
WHERE p.id = 607 AND p.composer_id = 37
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:46638202-b5f4-4234-aee3-87ad1518e0c1'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = NULL,
    part.name_ko = 'Acte III', part.name_en = 'Les Troyens : Acte III',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 607 AND p.composer_id = 37 AND part.part_key = 'musicbrainz:91af6b81-83d3-4a1f-aab9-c223a5b568fe' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:91af6b81-83d3-4a1f-aab9-c223a5b568fe', 3, NULL, 'Acte III', 'Les Troyens : Acte III', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 607 AND p.composer_id = 37
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:91af6b81-83d3-4a1f-aab9-c223a5b568fe'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:91af6b81-83d3-4a1f-aab9-c223a5b568fe'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'Introduction et chœur « De Carthage les cieux » (Chœur)', part.name_en = 'Les Troyens : Acte III, no. 17. Introduction et chœur « De Carthage les cieux » (Chœur)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 607 AND p.composer_id = 37 AND part.part_key = 'musicbrainz:79a73eff-4b0d-4285-aa6c-599d50356a0c' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:79a73eff-4b0d-4285-aa6c-599d50356a0c', 1, NULL, 'Introduction et chœur « De Carthage les cieux » (Chœur)', 'Les Troyens : Acte III, no. 17. Introduction et chœur « De Carthage les cieux » (Chœur)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:91af6b81-83d3-4a1f-aab9-c223a5b568fe'
WHERE p.id = 607 AND p.composer_id = 37
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:79a73eff-4b0d-4285-aa6c-599d50356a0c'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:91af6b81-83d3-4a1f-aab9-c223a5b568fe'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'Chant national « Gloire à Didon, notre reine chérie ! » (Chœur)', part.name_en = 'Les Troyens : Acte III, no. 18. Chant national « Gloire à Didon, notre reine chérie ! » (Chœur)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 607 AND p.composer_id = 37 AND part.part_key = 'musicbrainz:b6b621bd-85f2-481e-9b54-6721475fac17' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:b6b621bd-85f2-481e-9b54-6721475fac17', 2, NULL, 'Chant national « Gloire à Didon, notre reine chérie ! » (Chœur)', 'Les Troyens : Acte III, no. 18. Chant national « Gloire à Didon, notre reine chérie ! » (Chœur)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:91af6b81-83d3-4a1f-aab9-c223a5b568fe'
WHERE p.id = 607 AND p.composer_id = 37
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:b6b621bd-85f2-481e-9b54-6721475fac17'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:91af6b81-83d3-4a1f-aab9-c223a5b568fe'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = NULL,
    part.name_ko = 'Récitatif et air: « Nous avons vu finir » … « Chers Tyriens » (Didon, Chœur)', part.name_en = 'Les Troyens : Acte III, no. 19. Récitatif et air: « Nous avons vu finir » … « Chers Tyriens » (Didon, Chœur)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 607 AND p.composer_id = 37 AND part.part_key = 'musicbrainz:2d4eb146-812a-458c-ac04-309238d99c42' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:2d4eb146-812a-458c-ac04-309238d99c42', 3, NULL, 'Récitatif et air: « Nous avons vu finir » … « Chers Tyriens » (Didon, Chœur)', 'Les Troyens : Acte III, no. 19. Récitatif et air: « Nous avons vu finir » … « Chers Tyriens » (Didon, Chœur)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:91af6b81-83d3-4a1f-aab9-c223a5b568fe'
WHERE p.id = 607 AND p.composer_id = 37
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:2d4eb146-812a-458c-ac04-309238d99c42'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:91af6b81-83d3-4a1f-aab9-c223a5b568fe'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = NULL,
    part.name_ko = 'Entrée des constructeurs', part.name_en = 'Les Troyens : Acte III, no. 20. Entrée des constructeurs',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 607 AND p.composer_id = 37 AND part.part_key = 'musicbrainz:e79560ac-5b4b-4dea-a295-4a329732ac96' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:e79560ac-5b4b-4dea-a295-4a329732ac96', 4, NULL, 'Entrée des constructeurs', 'Les Troyens : Acte III, no. 20. Entrée des constructeurs', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:91af6b81-83d3-4a1f-aab9-c223a5b568fe'
WHERE p.id = 607 AND p.composer_id = 37
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:e79560ac-5b4b-4dea-a295-4a329732ac96'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:91af6b81-83d3-4a1f-aab9-c223a5b568fe'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 5, part.movement_number = NULL,
    part.name_ko = 'Entrée des matelots', part.name_en = 'Les Troyens : Acte III, no. 21. Entrée des matelots',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 607 AND p.composer_id = 37 AND part.part_key = 'musicbrainz:47026af8-933a-4244-b76e-314f09410495' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:47026af8-933a-4244-b76e-314f09410495', 5, NULL, 'Entrée des matelots', 'Les Troyens : Acte III, no. 21. Entrée des matelots', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:91af6b81-83d3-4a1f-aab9-c223a5b568fe'
WHERE p.id = 607 AND p.composer_id = 37
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:47026af8-933a-4244-b76e-314f09410495'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:91af6b81-83d3-4a1f-aab9-c223a5b568fe'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 6, part.movement_number = NULL,
    part.name_ko = 'Entrée des laboureurs', part.name_en = 'Les Troyens : Acte III, no. 22. Entrée des laboureurs',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 607 AND p.composer_id = 37 AND part.part_key = 'musicbrainz:3750b78d-63d2-4bd5-a907-62e8b641e330' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:3750b78d-63d2-4bd5-a907-62e8b641e330', 6, NULL, 'Entrée des laboureurs', 'Les Troyens : Acte III, no. 22. Entrée des laboureurs', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:91af6b81-83d3-4a1f-aab9-c223a5b568fe'
WHERE p.id = 607 AND p.composer_id = 37
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:3750b78d-63d2-4bd5-a907-62e8b641e330'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:91af6b81-83d3-4a1f-aab9-c223a5b568fe'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 7, part.movement_number = NULL,
    part.name_ko = 'Récitatif et chœur « Peuple ! Tous les honneurs » … « Gloire à Didon » (Didon, Chœur)', part.name_en = 'Les Troyens : Acte III, no. 23. Récitatif et chœur « Peuple ! Tous les honneurs » … « Gloire à Didon » (Didon, Chœur)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 607 AND p.composer_id = 37 AND part.part_key = 'musicbrainz:61b4da05-7e68-4616-9532-9582c80e6d11' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:61b4da05-7e68-4616-9532-9582c80e6d11', 7, NULL, 'Récitatif et chœur « Peuple ! Tous les honneurs » … « Gloire à Didon » (Didon, Chœur)', 'Les Troyens : Acte III, no. 23. Récitatif et chœur « Peuple ! Tous les honneurs » … « Gloire à Didon » (Didon, Chœur)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:91af6b81-83d3-4a1f-aab9-c223a5b568fe'
WHERE p.id = 607 AND p.composer_id = 37
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:61b4da05-7e68-4616-9532-9582c80e6d11'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:91af6b81-83d3-4a1f-aab9-c223a5b568fe'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 8, part.movement_number = NULL,
    part.name_ko = 'Récitatif et duo « Les chants joyeux » … « Sa voix fait naître dans mon sein » (Didon, Anna)', part.name_en = 'Les Troyens : Acte III, no. 24. Récitatif et duo « Les chants joyeux » … « Sa voix fait naître dans mon sein » (Didon, Anna)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 607 AND p.composer_id = 37 AND part.part_key = 'musicbrainz:49fc3dbe-d2e0-41d9-9fb6-d22f21ecf49e' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:49fc3dbe-d2e0-41d9-9fb6-d22f21ecf49e', 8, NULL, 'Récitatif et duo « Les chants joyeux » … « Sa voix fait naître dans mon sein » (Didon, Anna)', 'Les Troyens : Acte III, no. 24. Récitatif et duo « Les chants joyeux » … « Sa voix fait naître dans mon sein » (Didon, Anna)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:91af6b81-83d3-4a1f-aab9-c223a5b568fe'
WHERE p.id = 607 AND p.composer_id = 37
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:49fc3dbe-d2e0-41d9-9fb6-d22f21ecf49e'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:91af6b81-83d3-4a1f-aab9-c223a5b568fe'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 9, part.movement_number = NULL,
    part.name_ko = 'Récitatif et air « Echappés à grand peine » … « Errante sur les mers » (Iopas, Didon)', part.name_en = 'Les Troyens : Acte III, no. 25. Récitatif et air « Echappés à grand peine » … « Errante sur les mers » (Iopas, Didon)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 607 AND p.composer_id = 37 AND part.part_key = 'musicbrainz:3f2b102d-3eb6-44e4-b379-93f5e7c684e9' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:3f2b102d-3eb6-44e4-b379-93f5e7c684e9', 9, NULL, 'Récitatif et air « Echappés à grand peine » … « Errante sur les mers » (Iopas, Didon)', 'Les Troyens : Acte III, no. 25. Récitatif et air « Echappés à grand peine » … « Errante sur les mers » (Iopas, Didon)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:91af6b81-83d3-4a1f-aab9-c223a5b568fe'
WHERE p.id = 607 AND p.composer_id = 37
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:3f2b102d-3eb6-44e4-b379-93f5e7c684e9'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:91af6b81-83d3-4a1f-aab9-c223a5b568fe'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 10, part.movement_number = NULL,
    part.name_ko = 'Marche troyenne dans le mode triste … « J’éprouve une soudaine et vive impatience » (Didon)', part.name_en = 'Les Troyens : Acte III, no. 26. Marche troyenne dans le mode triste … « J’éprouve une soudaine et vive impatience » (Didon)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 607 AND p.composer_id = 37 AND part.part_key = 'musicbrainz:c720b31a-ff46-4a5c-a8bf-d400dd3ef6cd' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:c720b31a-ff46-4a5c-a8bf-d400dd3ef6cd', 10, NULL, 'Marche troyenne dans le mode triste … « J’éprouve une soudaine et vive impatience » (Didon)', 'Les Troyens : Acte III, no. 26. Marche troyenne dans le mode triste … « J’éprouve une soudaine et vive impatience » (Didon)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:91af6b81-83d3-4a1f-aab9-c223a5b568fe'
WHERE p.id = 607 AND p.composer_id = 37
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:c720b31a-ff46-4a5c-a8bf-d400dd3ef6cd'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:91af6b81-83d3-4a1f-aab9-c223a5b568fe'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 11, part.movement_number = NULL,
    part.name_ko = 'Récitatif « Auguste reine, un peuple errant et malheureux » (Ascagne, Didon, Panthée)', part.name_en = 'Les Troyens : Acte III, no. 27. Récitatif « Auguste reine, un peuple errant et malheureux » (Ascagne, Didon, Panthée)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 607 AND p.composer_id = 37 AND part.part_key = 'musicbrainz:7d439893-e84f-4240-8955-8a311c618de6' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:7d439893-e84f-4240-8955-8a311c618de6', 11, NULL, 'Récitatif « Auguste reine, un peuple errant et malheureux » (Ascagne, Didon, Panthée)', 'Les Troyens : Acte III, no. 27. Récitatif « Auguste reine, un peuple errant et malheureux » (Ascagne, Didon, Panthée)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:91af6b81-83d3-4a1f-aab9-c223a5b568fe'
WHERE p.id = 607 AND p.composer_id = 37
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:7d439893-e84f-4240-8955-8a311c618de6'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:91af6b81-83d3-4a1f-aab9-c223a5b568fe'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 12, part.movement_number = NULL,
    part.name_ko = 'Finale « J’ose à peine annoncer la terrible nouvelle ! » (Narbal, Didon, Chorus) / « Reine ! Je suis Énée ! » (Énée, tous) / « Annonce à nos Troyens l’entreprise nouvelle » (Énée, Didon) / « Des armes ! des armes ! » (tous)', part.name_en = 'Les Troyens : Acte III, no. 28. Finale « J’ose à peine annoncer la terrible nouvelle ! » (Narbal, Didon, Chorus) / « Reine ! Je suis Énée ! » (Énée, tous) / « Annonce à nos Troyens l’entreprise nouvelle » (Énée, Didon) / « Des armes ! des armes ! » (tous)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 607 AND p.composer_id = 37 AND part.part_key = 'musicbrainz:f37abd0c-eafb-4ae5-ba60-20e83243f0e4' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:f37abd0c-eafb-4ae5-ba60-20e83243f0e4', 12, NULL, 'Finale « J’ose à peine annoncer la terrible nouvelle ! » (Narbal, Didon, Chorus) / « Reine ! Je suis Énée ! » (Énée, tous) / « Annonce à nos Troyens l’entreprise nouvelle » (Énée, Didon) / « Des armes ! des armes ! » (tous)', 'Les Troyens : Acte III, no. 28. Finale « J’ose à peine annoncer la terrible nouvelle ! » (Narbal, Didon, Chorus) / « Reine ! Je suis Énée ! » (Énée, tous) / « Annonce à nos Troyens l’entreprise nouvelle » (Énée, Didon) / « Des armes ! des armes ! » (tous)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:91af6b81-83d3-4a1f-aab9-c223a5b568fe'
WHERE p.id = 607 AND p.composer_id = 37
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:f37abd0c-eafb-4ae5-ba60-20e83243f0e4'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = NULL,
    part.name_ko = 'Acte IV', part.name_en = 'Les Troyens : Acte IV',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 607 AND p.composer_id = 37 AND part.part_key = 'musicbrainz:de5e941e-6464-49b9-a9f1-156f8ec19444' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:de5e941e-6464-49b9-a9f1-156f8ec19444', 4, NULL, 'Acte IV', 'Les Troyens : Acte IV', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 607 AND p.composer_id = 37
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:de5e941e-6464-49b9-a9f1-156f8ec19444'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:de5e941e-6464-49b9-a9f1-156f8ec19444'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'Chasse royale et orage – Pantomime (Chœur)', part.name_en = 'Les Troyens : Acte IV, no. 29. Chasse royale et orage – Pantomime (Chœur)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 607 AND p.composer_id = 37 AND part.part_key = 'musicbrainz:445560ea-1b44-46da-bb93-b053d20f2032' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:445560ea-1b44-46da-bb93-b053d20f2032', 1, NULL, 'Chasse royale et orage – Pantomime (Chœur)', 'Les Troyens : Acte IV, no. 29. Chasse royale et orage – Pantomime (Chœur)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:de5e941e-6464-49b9-a9f1-156f8ec19444'
WHERE p.id = 607 AND p.composer_id = 37
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:445560ea-1b44-46da-bb93-b053d20f2032'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:de5e941e-6464-49b9-a9f1-156f8ec19444'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'Récitatif « Dites, Narbal, qui cause vos alarmes ? » (Anna, Narbal)', part.name_en = 'Les Troyens : Acte IV, no. 30. Récitatif « Dites, Narbal, qui cause vos alarmes ? » (Anna, Narbal)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 607 AND p.composer_id = 37 AND part.part_key = 'musicbrainz:d8c5db09-c9f3-4e99-afca-eab802157923' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:d8c5db09-c9f3-4e99-afca-eab802157923', 2, NULL, 'Récitatif « Dites, Narbal, qui cause vos alarmes ? » (Anna, Narbal)', 'Les Troyens : Acte IV, no. 30. Récitatif « Dites, Narbal, qui cause vos alarmes ? » (Anna, Narbal)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:de5e941e-6464-49b9-a9f1-156f8ec19444'
WHERE p.id = 607 AND p.composer_id = 37
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:d8c5db09-c9f3-4e99-afca-eab802157923'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:de5e941e-6464-49b9-a9f1-156f8ec19444'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = NULL,
    part.name_ko = 'Air, cavatine et duo « De quels revers menaces‐tu Carthage » … « Vaine terreur » (Narbal, Anna)', part.name_en = 'Les Troyens : Acte IV, no. 31. Air, cavatine et duo « De quels revers menaces‐tu Carthage » … « Vaine terreur » (Narbal, Anna)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 607 AND p.composer_id = 37 AND part.part_key = 'musicbrainz:98bca196-0742-43e9-8aaa-3b9028117135' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:98bca196-0742-43e9-8aaa-3b9028117135', 3, NULL, 'Air, cavatine et duo « De quels revers menaces‐tu Carthage » … « Vaine terreur » (Narbal, Anna)', 'Les Troyens : Acte IV, no. 31. Air, cavatine et duo « De quels revers menaces‐tu Carthage » … « Vaine terreur » (Narbal, Anna)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:de5e941e-6464-49b9-a9f1-156f8ec19444'
WHERE p.id = 607 AND p.composer_id = 37
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:98bca196-0742-43e9-8aaa-3b9028117135'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:de5e941e-6464-49b9-a9f1-156f8ec19444'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = NULL,
    part.name_ko = 'Marche pour l''entrée de la reine', part.name_en = 'Les Troyens : Acte IV, no. 32. Marche pour l''entrée de la reine',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 607 AND p.composer_id = 37 AND part.part_key = 'musicbrainz:684434bc-c64b-39df-89bd-6da3c3321037' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:684434bc-c64b-39df-89bd-6da3c3321037', 4, NULL, 'Marche pour l''entrée de la reine', 'Les Troyens : Acte IV, no. 32. Marche pour l''entrée de la reine', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:de5e941e-6464-49b9-a9f1-156f8ec19444'
WHERE p.id = 607 AND p.composer_id = 37
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:684434bc-c64b-39df-89bd-6da3c3321037'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:de5e941e-6464-49b9-a9f1-156f8ec19444'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 5, part.movement_number = NULL,
    part.name_ko = 'Ballet a) Pas des almées', part.name_en = 'Les Troyens : Acte IV, no. 33. Ballet a) Pas des almées',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 607 AND p.composer_id = 37 AND part.part_key = 'musicbrainz:4e272233-560f-39da-8dc1-985a7c63e817' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:4e272233-560f-39da-8dc1-985a7c63e817', 5, NULL, 'Ballet a) Pas des almées', 'Les Troyens : Acte IV, no. 33. Ballet a) Pas des almées', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:de5e941e-6464-49b9-a9f1-156f8ec19444'
WHERE p.id = 607 AND p.composer_id = 37
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:4e272233-560f-39da-8dc1-985a7c63e817'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:de5e941e-6464-49b9-a9f1-156f8ec19444'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 6, part.movement_number = NULL,
    part.name_ko = 'Ballet b) Danse des esclaves', part.name_en = 'Les Troyens : Acte IV, no. 33. Ballet b) Danse des esclaves',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 607 AND p.composer_id = 37 AND part.part_key = 'musicbrainz:09b763f4-a7da-3afb-99d4-1bd348fc6642' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:09b763f4-a7da-3afb-99d4-1bd348fc6642', 6, NULL, 'Ballet b) Danse des esclaves', 'Les Troyens : Acte IV, no. 33. Ballet b) Danse des esclaves', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:de5e941e-6464-49b9-a9f1-156f8ec19444'
WHERE p.id = 607 AND p.composer_id = 37
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:09b763f4-a7da-3afb-99d4-1bd348fc6642'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:de5e941e-6464-49b9-a9f1-156f8ec19444'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 7, part.movement_number = NULL,
    part.name_ko = 'Ballet. c) Pas d''esclaves nubiennes', part.name_en = 'Les Troyens : Acte IV, no. 33 Ballet. c) Pas d''esclaves nubiennes',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 607 AND p.composer_id = 37 AND part.part_key = 'musicbrainz:c98595f1-6bde-3aef-b031-089cbc4c7898' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:c98595f1-6bde-3aef-b031-089cbc4c7898', 7, NULL, 'Ballet. c) Pas d''esclaves nubiennes', 'Les Troyens : Acte IV, no. 33 Ballet. c) Pas d''esclaves nubiennes', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:de5e941e-6464-49b9-a9f1-156f8ec19444'
WHERE p.id = 607 AND p.composer_id = 37
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:c98595f1-6bde-3aef-b031-089cbc4c7898'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:de5e941e-6464-49b9-a9f1-156f8ec19444'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 8, part.movement_number = NULL,
    part.name_ko = 'Scène et chant d’Iopas « Assez, ma sœur » (Didon, Iopas) … « Ô blonde Cérès » (Iopas)', part.name_en = 'Les Troyens : Acte IV, no. 34. Scène et chant d’Iopas « Assez, ma sœur » (Didon, Iopas) … « Ô blonde Cérès » (Iopas)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 607 AND p.composer_id = 37 AND part.part_key = 'musicbrainz:6441c238-ed37-4eb1-bfd1-7077a718d5d3' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:6441c238-ed37-4eb1-bfd1-7077a718d5d3', 8, NULL, 'Scène et chant d’Iopas « Assez, ma sœur » (Didon, Iopas) … « Ô blonde Cérès » (Iopas)', 'Les Troyens : Acte IV, no. 34. Scène et chant d’Iopas « Assez, ma sœur » (Didon, Iopas) … « Ô blonde Cérès » (Iopas)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:de5e941e-6464-49b9-a9f1-156f8ec19444'
WHERE p.id = 607 AND p.composer_id = 37
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:6441c238-ed37-4eb1-bfd1-7077a718d5d3'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:de5e941e-6464-49b9-a9f1-156f8ec19444'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 9, part.movement_number = NULL,
    part.name_ko = 'Récitatif et quintette « Pardonne, Iopas » (Didon, Enée) … "Ô pudeur !" (Didon, Anna, Énée, Iopas, Narbal)', part.name_en = 'Les Troyens : Acte IV, no. 35. Récitatif et quintette « Pardonne, Iopas » (Didon, Enée) … "Ô pudeur !" (Didon, Anna, Énée, Iopas, Narbal)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 607 AND p.composer_id = 37 AND part.part_key = 'musicbrainz:9d5f2b1c-fc73-47eb-883e-5455332455cf' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:9d5f2b1c-fc73-47eb-883e-5455332455cf', 9, NULL, 'Récitatif et quintette « Pardonne, Iopas » (Didon, Enée) … "Ô pudeur !" (Didon, Anna, Énée, Iopas, Narbal)', 'Les Troyens : Acte IV, no. 35. Récitatif et quintette « Pardonne, Iopas » (Didon, Enée) … "Ô pudeur !" (Didon, Anna, Énée, Iopas, Narbal)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:de5e941e-6464-49b9-a9f1-156f8ec19444'
WHERE p.id = 607 AND p.composer_id = 37
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:9d5f2b1c-fc73-47eb-883e-5455332455cf'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:de5e941e-6464-49b9-a9f1-156f8ec19444'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 10, part.movement_number = NULL,
    part.name_ko = 'Récitatif et septuor « Mais bannissons ces tristes souvenirs » (Énée) …« Tout n''est que paix » (Didon, Énée, Ascagne, Anna, Iopas, Narbal, Panthée, Chœur)', part.name_en = 'Les Troyens : Acte IV, no. 36. Récitatif et septuor « Mais bannissons ces tristes souvenirs » (Énée) …« Tout n''est que paix » (Didon, Énée, Ascagne, Anna, Iopas, Narbal, Panthée, Chœur)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 607 AND p.composer_id = 37 AND part.part_key = 'musicbrainz:58ae9449-f4a9-43ad-9eb6-7fbb156cc604' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:58ae9449-f4a9-43ad-9eb6-7fbb156cc604', 10, NULL, 'Récitatif et septuor « Mais bannissons ces tristes souvenirs » (Énée) …« Tout n''est que paix » (Didon, Énée, Ascagne, Anna, Iopas, Narbal, Panthée, Chœur)', 'Les Troyens : Acte IV, no. 36. Récitatif et septuor « Mais bannissons ces tristes souvenirs » (Énée) …« Tout n''est que paix » (Didon, Énée, Ascagne, Anna, Iopas, Narbal, Panthée, Chœur)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:de5e941e-6464-49b9-a9f1-156f8ec19444'
WHERE p.id = 607 AND p.composer_id = 37
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:58ae9449-f4a9-43ad-9eb6-7fbb156cc604'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:de5e941e-6464-49b9-a9f1-156f8ec19444'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 11, part.movement_number = NULL,
    part.name_ko = 'Duo « Nuit d’ivresse et d’extase infinie ! » (Didon, Énée, Mercure)', part.name_en = 'Les Troyens : Acte IV, no. 37. Duo « Nuit d’ivresse et d’extase infinie ! » (Didon, Énée, Mercure)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 607 AND p.composer_id = 37 AND part.part_key = 'musicbrainz:f61d71f7-7a35-4ebd-897c-a84b12e106eb' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:f61d71f7-7a35-4ebd-897c-a84b12e106eb', 11, NULL, 'Duo « Nuit d’ivresse et d’extase infinie ! » (Didon, Énée, Mercure)', 'Les Troyens : Acte IV, no. 37. Duo « Nuit d’ivresse et d’extase infinie ! » (Didon, Énée, Mercure)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:de5e941e-6464-49b9-a9f1-156f8ec19444'
WHERE p.id = 607 AND p.composer_id = 37
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:f61d71f7-7a35-4ebd-897c-a84b12e106eb'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 5, part.movement_number = NULL,
    part.name_ko = 'Acte V', part.name_en = 'Les Troyens : Acte V',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 607 AND p.composer_id = 37 AND part.part_key = 'musicbrainz:23442a76-42dc-4f8f-beb1-884663e7c684' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:23442a76-42dc-4f8f-beb1-884663e7c684', 5, NULL, 'Acte V', 'Les Troyens : Acte V', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 607 AND p.composer_id = 37
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:23442a76-42dc-4f8f-beb1-884663e7c684'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:23442a76-42dc-4f8f-beb1-884663e7c684'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'Chanson d''Hylas « Vallon sonore » (Hylas, Sentinelles)', part.name_en = 'Les Troyens : Acte V, no. 38. Chanson d''Hylas « Vallon sonore » (Hylas, Sentinelles)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 607 AND p.composer_id = 37 AND part.part_key = 'musicbrainz:4b2ff617-adc2-42fd-9e9f-73c722ce5b38' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:4b2ff617-adc2-42fd-9e9f-73c722ce5b38', 1, NULL, 'Chanson d''Hylas « Vallon sonore » (Hylas, Sentinelles)', 'Les Troyens : Acte V, no. 38. Chanson d''Hylas « Vallon sonore » (Hylas, Sentinelles)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:23442a76-42dc-4f8f-beb1-884663e7c684'
WHERE p.id = 607 AND p.composer_id = 37
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:4b2ff617-adc2-42fd-9e9f-73c722ce5b38'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:23442a76-42dc-4f8f-beb1-884663e7c684'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'Récitatif et chœur « Préparez tout » … « Chaque jour voit grandir la colère » (Panthée, chefs troyens, 1re et 2e sentinelle)', part.name_en = 'Les Troyens : Acte V, no. 39. Récitatif et chœur « Préparez tout » … « Chaque jour voit grandir la colère » (Panthée, chefs troyens, 1re et 2e sentinelle)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 607 AND p.composer_id = 37 AND part.part_key = 'musicbrainz:f9c2eee3-519d-4d2e-b411-2b0269bda7a8' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:f9c2eee3-519d-4d2e-b411-2b0269bda7a8', 2, NULL, 'Récitatif et chœur « Préparez tout » … « Chaque jour voit grandir la colère » (Panthée, chefs troyens, 1re et 2e sentinelle)', 'Les Troyens : Acte V, no. 39. Récitatif et chœur « Préparez tout » … « Chaque jour voit grandir la colère » (Panthée, chefs troyens, 1re et 2e sentinelle)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:23442a76-42dc-4f8f-beb1-884663e7c684'
WHERE p.id = 607 AND p.composer_id = 37
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:f9c2eee3-519d-4d2e-b411-2b0269bda7a8'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:23442a76-42dc-4f8f-beb1-884663e7c684'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = NULL,
    part.name_ko = 'Duo « Par Bacchus ! ils sont fous » (Sentinelles)', part.name_en = 'Les Troyens : Acte V, no. 40. Duo « Par Bacchus ! ils sont fous » (Sentinelles)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 607 AND p.composer_id = 37 AND part.part_key = 'musicbrainz:21c4e021-e828-4608-b03e-451242ca7e42' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:21c4e021-e828-4608-b03e-451242ca7e42', 3, NULL, 'Duo « Par Bacchus ! ils sont fous » (Sentinelles)', 'Les Troyens : Acte V, no. 40. Duo « Par Bacchus ! ils sont fous » (Sentinelles)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:23442a76-42dc-4f8f-beb1-884663e7c684'
WHERE p.id = 607 AND p.composer_id = 37
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:21c4e021-e828-4608-b03e-451242ca7e42'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:23442a76-42dc-4f8f-beb1-884663e7c684'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = NULL,
    part.name_ko = 'Récitatif mesuré et air « Inutiles regrets » … « Ah ! quand viendra » (Enée)', part.name_en = 'Les Troyens : Acte V, no. 41. Récitatif mesuré et air « Inutiles regrets » … « Ah ! quand viendra » (Enée)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 607 AND p.composer_id = 37 AND part.part_key = 'musicbrainz:af224679-338c-4ebc-956a-cb8c0302a9b0' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:af224679-338c-4ebc-956a-cb8c0302a9b0', 4, NULL, 'Récitatif mesuré et air « Inutiles regrets » … « Ah ! quand viendra » (Enée)', 'Les Troyens : Acte V, no. 41. Récitatif mesuré et air « Inutiles regrets » … « Ah ! quand viendra » (Enée)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:23442a76-42dc-4f8f-beb1-884663e7c684'
WHERE p.id = 607 AND p.composer_id = 37
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:af224679-338c-4ebc-956a-cb8c0302a9b0'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:23442a76-42dc-4f8f-beb1-884663e7c684'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 5, part.movement_number = NULL,
    part.name_ko = 'Scène « Énée ! » … « Encor ces voix ! » (Énée, l’ombre de Chorèbe, d’Hector, de Priam et de Cassandre, Chœur de Troyens)', part.name_en = 'Les Troyens : Acte V, no. 42. Scène « Énée ! » … « Encor ces voix ! » (Énée, l’ombre de Chorèbe, d’Hector, de Priam et de Cassandre, Chœur de Troyens)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 607 AND p.composer_id = 37 AND part.part_key = 'musicbrainz:4ae9079f-a422-4f8d-ac6b-37daa70b296c' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:4ae9079f-a422-4f8d-ac6b-37daa70b296c', 5, NULL, 'Scène « Énée ! » … « Encor ces voix ! » (Énée, l’ombre de Chorèbe, d’Hector, de Priam et de Cassandre, Chœur de Troyens)', 'Les Troyens : Acte V, no. 42. Scène « Énée ! » … « Encor ces voix ! » (Énée, l’ombre de Chorèbe, d’Hector, de Priam et de Cassandre, Chœur de Troyens)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:23442a76-42dc-4f8f-beb1-884663e7c684'
WHERE p.id = 607 AND p.composer_id = 37
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:4ae9079f-a422-4f8d-ac6b-37daa70b296c'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:23442a76-42dc-4f8f-beb1-884663e7c684'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 6, part.movement_number = NULL,
    part.name_ko = 'Scène et choeur « Debout, troyens, éveillez‐vous, alerte ! » (Énée, Chœur)', part.name_en = 'Les Troyens : Acte V, no. 43. Scène et choeur « Debout, troyens, éveillez‐vous, alerte ! » (Énée, Chœur)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 607 AND p.composer_id = 37 AND part.part_key = 'musicbrainz:35c8671d-4e71-4d88-a7a0-030a6adb6313' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:35c8671d-4e71-4d88-a7a0-030a6adb6313', 6, NULL, 'Scène et choeur « Debout, troyens, éveillez‐vous, alerte ! » (Énée, Chœur)', 'Les Troyens : Acte V, no. 43. Scène et choeur « Debout, troyens, éveillez‐vous, alerte ! » (Énée, Chœur)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:23442a76-42dc-4f8f-beb1-884663e7c684'
WHERE p.id = 607 AND p.composer_id = 37
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:35c8671d-4e71-4d88-a7a0-030a6adb6313'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:23442a76-42dc-4f8f-beb1-884663e7c684'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 7, part.movement_number = NULL,
    part.name_ko = 'Duo et chœur « Errante sur tes pas » (Didon, Énée) … « Italie ! » (Énée, chœur)', part.name_en = 'Les Troyens : Acte V, no. 44. Duo et chœur « Errante sur tes pas » (Didon, Énée) … « Italie ! » (Énée, chœur)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 607 AND p.composer_id = 37 AND part.part_key = 'musicbrainz:4ff197d8-5ecc-4cc1-946a-7a3559803e45' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:4ff197d8-5ecc-4cc1-946a-7a3559803e45', 7, NULL, 'Duo et chœur « Errante sur tes pas » (Didon, Énée) … « Italie ! » (Énée, chœur)', 'Les Troyens : Acte V, no. 44. Duo et chœur « Errante sur tes pas » (Didon, Énée) … « Italie ! » (Énée, chœur)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:23442a76-42dc-4f8f-beb1-884663e7c684'
WHERE p.id = 607 AND p.composer_id = 37
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:4ff197d8-5ecc-4cc1-946a-7a3559803e45'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:23442a76-42dc-4f8f-beb1-884663e7c684'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 8, part.movement_number = NULL,
    part.name_ko = 'Scène « Va, sœur, l’implorer » (Didon, Anna)', part.name_en = 'Les Troyens : Acte V, no. 45. Scène « Va, sœur, l’implorer » (Didon, Anna)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 607 AND p.composer_id = 37 AND part.part_key = 'musicbrainz:e10aff74-b892-403e-bcd3-d79e002fd4cd' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:e10aff74-b892-403e-bcd3-d79e002fd4cd', 8, NULL, 'Scène « Va, sœur, l’implorer » (Didon, Anna)', 'Les Troyens : Acte V, no. 45. Scène « Va, sœur, l’implorer » (Didon, Anna)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:23442a76-42dc-4f8f-beb1-884663e7c684'
WHERE p.id = 607 AND p.composer_id = 37
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:e10aff74-b892-403e-bcd3-d79e002fd4cd'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:23442a76-42dc-4f8f-beb1-884663e7c684'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 9, part.movement_number = NULL,
    part.name_ko = 'Scène et chœur « En mer, voyez ! Six vaisseaux ! » … « Dieux immortels ! » (Chœur, Iopas, Didon, Narbal, Anna)', part.name_en = 'Les Troyens : Acte V, no. 46. Scène et chœur « En mer, voyez ! Six vaisseaux ! » … « Dieux immortels ! » (Chœur, Iopas, Didon, Narbal, Anna)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 607 AND p.composer_id = 37 AND part.part_key = 'musicbrainz:29e122b9-7de7-4b2b-8941-ee01bfa11321' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:29e122b9-7de7-4b2b-8941-ee01bfa11321', 9, NULL, 'Scène et chœur « En mer, voyez ! Six vaisseaux ! » … « Dieux immortels ! » (Chœur, Iopas, Didon, Narbal, Anna)', 'Les Troyens : Acte V, no. 46. Scène et chœur « En mer, voyez ! Six vaisseaux ! » … « Dieux immortels ! » (Chœur, Iopas, Didon, Narbal, Anna)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:23442a76-42dc-4f8f-beb1-884663e7c684'
WHERE p.id = 607 AND p.composer_id = 37
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:29e122b9-7de7-4b2b-8941-ee01bfa11321'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:23442a76-42dc-4f8f-beb1-884663e7c684'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 10, part.movement_number = NULL,
    part.name_ko = 'Monologue « Ah ! Ah ! Je vais mourir » (Didon)', part.name_en = 'Les Troyens : Acte V, no. 47. Monologue « Ah ! Ah ! Je vais mourir » (Didon)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 607 AND p.composer_id = 37 AND part.part_key = 'musicbrainz:9a739643-33d5-47f0-994c-e3e2948d4de3' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:9a739643-33d5-47f0-994c-e3e2948d4de3', 10, NULL, 'Monologue « Ah ! Ah ! Je vais mourir » (Didon)', 'Les Troyens : Acte V, no. 47. Monologue « Ah ! Ah ! Je vais mourir » (Didon)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:23442a76-42dc-4f8f-beb1-884663e7c684'
WHERE p.id = 607 AND p.composer_id = 37
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:9a739643-33d5-47f0-994c-e3e2948d4de3'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:23442a76-42dc-4f8f-beb1-884663e7c684'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 11, part.movement_number = NULL,
    part.name_ko = 'Cérémonie funèbre « Dieux de l’oubli, dieux du Ténare » … « S’il faut enfin qu’Énée » (Chœur de prêtres de Pluton, Anna, Narbal)', part.name_en = 'Les Troyens : Acte V, no. 49. Cérémonie funèbre « Dieux de l’oubli, dieux du Ténare » … « S’il faut enfin qu’Énée » (Chœur de prêtres de Pluton, Anna, Narbal)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 607 AND p.composer_id = 37 AND part.part_key = 'musicbrainz:9ab1c58f-b4c1-401e-a379-de4e163833da' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:9ab1c58f-b4c1-401e-a379-de4e163833da', 11, NULL, 'Cérémonie funèbre « Dieux de l’oubli, dieux du Ténare » … « S’il faut enfin qu’Énée » (Chœur de prêtres de Pluton, Anna, Narbal)', 'Les Troyens : Acte V, no. 49. Cérémonie funèbre « Dieux de l’oubli, dieux du Ténare » … « S’il faut enfin qu’Énée » (Chœur de prêtres de Pluton, Anna, Narbal)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:23442a76-42dc-4f8f-beb1-884663e7c684'
WHERE p.id = 607 AND p.composer_id = 37
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:9ab1c58f-b4c1-401e-a379-de4e163833da'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:23442a76-42dc-4f8f-beb1-884663e7c684'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 12, part.movement_number = NULL,
    part.name_ko = 'Scène « Pluton semble m’être propice » (Didon, Chœur, Anna, Narbal)', part.name_en = 'Les Troyens : Acte V, no. 50. Scène « Pluton semble m’être propice » (Didon, Chœur, Anna, Narbal)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 607 AND p.composer_id = 37 AND part.part_key = 'musicbrainz:6cc64335-fdca-4c23-8644-dcd69192a885' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:6cc64335-fdca-4c23-8644-dcd69192a885', 12, NULL, 'Scène « Pluton semble m’être propice » (Didon, Chœur, Anna, Narbal)', 'Les Troyens : Acte V, no. 50. Scène « Pluton semble m’être propice » (Didon, Chœur, Anna, Narbal)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:23442a76-42dc-4f8f-beb1-884663e7c684'
WHERE p.id = 607 AND p.composer_id = 37
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:6cc64335-fdca-4c23-8644-dcd69192a885'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:23442a76-42dc-4f8f-beb1-884663e7c684'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 13, part.movement_number = NULL,
    part.name_ko = 'Chœur « Ah ! au secours ! La reine est frappée »', part.name_en = 'Les Troyens : Acte V, no. 51. Chœur « Ah ! au secours ! La reine est frappée »',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 607 AND p.composer_id = 37 AND part.part_key = 'musicbrainz:c703dd0d-5311-467e-9e9e-3339c6f3d64b' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:c703dd0d-5311-467e-9e9e-3339c6f3d64b', 13, NULL, 'Chœur « Ah ! au secours ! La reine est frappée »', 'Les Troyens : Acte V, no. 51. Chœur « Ah ! au secours ! La reine est frappée »', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:23442a76-42dc-4f8f-beb1-884663e7c684'
WHERE p.id = 607 AND p.composer_id = 37
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:c703dd0d-5311-467e-9e9e-3339c6f3d64b'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:23442a76-42dc-4f8f-beb1-884663e7c684'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 14, part.movement_number = NULL,
    part.name_ko = 'Imprécation « Rome… Rome… immortelle ! » (Chœur)', part.name_en = 'Les Troyens : Acte V, no. 52. Imprécation « Rome… Rome… immortelle ! » (Chœur)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 607 AND p.composer_id = 37 AND part.part_key = 'musicbrainz:b02430e5-9af9-4887-b9be-1528d6e46cd8' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:b02430e5-9af9-4887-b9be-1528d6e46cd8', 14, NULL, 'Imprécation « Rome… Rome… immortelle ! » (Chœur)', 'Les Troyens : Acte V, no. 52. Imprécation « Rome… Rome… immortelle ! » (Chœur)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:23442a76-42dc-4f8f-beb1-884663e7c684'
WHERE p.id = 607 AND p.composer_id = 37
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:b02430e5-9af9-4887-b9be-1528d6e46cd8'
);


-- None Les Troyens: Acte I, scène 3. "Du peuple et des soldats"

UPDATE pieces piece
SET piece.title = 'Les Troyens: Acte I, scène 3. "Du peuple et des soldats"', piece.title_en = 'Les Troyens: Acte I, scène 3. "Du peuple et des soldats"',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 2211 AND piece.composer_id = 37
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Les Troyens: Acte IV, scène 2. "Ah! quand viendra l'insant …"

UPDATE pieces piece
SET piece.title = 'Les Troyens: Acte IV, scène 2. "Ah! quand viendra l''insant …"', piece.title_en = 'Les Troyens: Acte IV, scène 2. "Ah! quand viendra l''insant …"',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 2533 AND piece.composer_id = 37
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Les Troyens: Acte V, scène 1. "En un dernier naufrage"

UPDATE pieces piece
SET piece.title = 'Les Troyens: Acte V, scène 1. "En un dernier naufrage"', piece.title_en = 'Les Troyens: Acte V, scène 1. "En un dernier naufrage"',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 2704 AND piece.composer_id = 37
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- Op. 14b Lélio, ou Le Retour à la vie Op. 14b

UPDATE pieces piece
SET piece.title = 'Lélio, ou Le Retour à la vie Op. 14b', piece.title_en = 'Lélio, ou Le Retour à la vie, op. 14b',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = 'Op.', piece.catalogue_number = '14b',
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 647 AND piece.composer_id = 37
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'Ia. Narration : « Dieu ! Je vis encore » (Lélio)', part.name_en = 'Lélio, ou Le Retour à la vie, op. 14b: Ia. Narration : « Dieu ! Je vis encore » (Lélio)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 647 AND p.composer_id = 37 AND part.part_key = 'musicbrainz:cfa1b528-fcd8-4d1b-8084-c599fdda0e1e' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:cfa1b528-fcd8-4d1b-8084-c599fdda0e1e', 1, NULL, 'Ia. Narration : « Dieu ! Je vis encore » (Lélio)', 'Lélio, ou Le Retour à la vie, op. 14b: Ia. Narration : « Dieu ! Je vis encore » (Lélio)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 647 AND p.composer_id = 37
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:cfa1b528-fcd8-4d1b-8084-c599fdda0e1e'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'Le Pêcheur « L''onde frémit, l''onde s''agite » (Horatio)', part.name_en = 'Lélio, ou Le Retour à la vie, op. 14b: I. Le Pêcheur « L''onde frémit, l''onde s''agite » (Horatio)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 647 AND p.composer_id = 37 AND part.part_key = 'musicbrainz:d871b9f3-cc4c-44f6-b8f7-2698f9eaf991' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:d871b9f3-cc4c-44f6-b8f7-2698f9eaf991', 2, NULL, 'Le Pêcheur « L''onde frémit, l''onde s''agite » (Horatio)', 'Lélio, ou Le Retour à la vie, op. 14b: I. Le Pêcheur « L''onde frémit, l''onde s''agite » (Horatio)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 647 AND p.composer_id = 37
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:d871b9f3-cc4c-44f6-b8f7-2698f9eaf991'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = NULL,
    part.name_ko = 'IIa. Narration « Étrange persistance » (Lélio)', part.name_en = 'Lélio, ou Le Retour à la vie, op. 14b: IIa. Narration « Étrange persistance » (Lélio)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 647 AND p.composer_id = 37 AND part.part_key = 'musicbrainz:1501803f-6f2f-47df-a12f-b35acd36a023' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:1501803f-6f2f-47df-a12f-b35acd36a023', 3, NULL, 'IIa. Narration « Étrange persistance » (Lélio)', 'Lélio, ou Le Retour à la vie, op. 14b: IIa. Narration « Étrange persistance » (Lélio)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 647 AND p.composer_id = 37
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:1501803f-6f2f-47df-a12f-b35acd36a023'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = NULL,
    part.name_ko = 'Chœur d''ombres « Froid de la mort » (Chœur)', part.name_en = 'Lélio, ou Le Retour à la vie, op. 14b: II. Chœur d''ombres « Froid de la mort » (Chœur)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 647 AND p.composer_id = 37 AND part.part_key = 'musicbrainz:53d8a5fe-bcb5-442d-9034-7a4be61a7cbc' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:53d8a5fe-bcb5-442d-9034-7a4be61a7cbc', 4, NULL, 'Chœur d''ombres « Froid de la mort » (Chœur)', 'Lélio, ou Le Retour à la vie, op. 14b: II. Chœur d''ombres « Froid de la mort » (Chœur)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 647 AND p.composer_id = 37
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:53d8a5fe-bcb5-442d-9034-7a4be61a7cbc'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 5, part.movement_number = NULL,
    part.name_ko = 'IIIa. Narration « Ô Shakespeare » (Lélio)', part.name_en = 'Lélio, ou Le Retour à la vie, op. 14b: IIIa. Narration « Ô Shakespeare » (Lélio)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 647 AND p.composer_id = 37 AND part.part_key = 'musicbrainz:19ba67ee-6b94-43a1-b077-23d985b03fc4' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:19ba67ee-6b94-43a1-b077-23d985b03fc4', 5, NULL, 'IIIa. Narration « Ô Shakespeare » (Lélio)', 'Lélio, ou Le Retour à la vie, op. 14b: IIIa. Narration « Ô Shakespeare » (Lélio)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 647 AND p.composer_id = 37
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:19ba67ee-6b94-43a1-b077-23d985b03fc4'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 6, part.movement_number = NULL,
    part.name_ko = 'Chanson de brigands « J’aurais cent ans » (Le Capitaine, Chœur)', part.name_en = 'Lélio, ou Le Retour à la vie, op. 14b: III. Chanson de brigands « J’aurais cent ans » (Le Capitaine, Chœur)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 647 AND p.composer_id = 37 AND part.part_key = 'musicbrainz:9b95e08f-cc7f-4ed3-bd5e-9543940bd107' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:9b95e08f-cc7f-4ed3-bd5e-9543940bd107', 6, NULL, 'Chanson de brigands « J’aurais cent ans » (Le Capitaine, Chœur)', 'Lélio, ou Le Retour à la vie, op. 14b: III. Chanson de brigands « J’aurais cent ans » (Le Capitaine, Chœur)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 647 AND p.composer_id = 37
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:9b95e08f-cc7f-4ed3-bd5e-9543940bd107'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 7, part.movement_number = NULL,
    part.name_ko = 'IVa. Narration « Comme mon esprit flotte incertain ! » (Lélio)', part.name_en = 'Lélio, ou Le Retour à la vie, op. 14b: IVa. Narration « Comme mon esprit flotte incertain ! » (Lélio)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 647 AND p.composer_id = 37 AND part.part_key = 'musicbrainz:1ecae80b-4b39-4ae7-bea0-e91dac957d65' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:1ecae80b-4b39-4ae7-bea0-e91dac957d65', 7, NULL, 'IVa. Narration « Comme mon esprit flotte incertain ! » (Lélio)', 'Lélio, ou Le Retour à la vie, op. 14b: IVa. Narration « Comme mon esprit flotte incertain ! » (Lélio)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 647 AND p.composer_id = 37
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:1ecae80b-4b39-4ae7-bea0-e91dac957d65'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 8, part.movement_number = NULL,
    part.name_ko = 'Chant de bonheur « Ô mon bonheur » (La voix imaginaire de Lélio)', part.name_en = 'Lélio, ou Le Retour à la vie, op. 14b: IV. Chant de bonheur « Ô mon bonheur » (La voix imaginaire de Lélio)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 647 AND p.composer_id = 37 AND part.part_key = 'musicbrainz:d7b84572-f577-474f-abed-ebdb1c5b7604' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:d7b84572-f577-474f-abed-ebdb1c5b7604', 8, NULL, 'Chant de bonheur « Ô mon bonheur » (La voix imaginaire de Lélio)', 'Lélio, ou Le Retour à la vie, op. 14b: IV. Chant de bonheur « Ô mon bonheur » (La voix imaginaire de Lélio)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 647 AND p.composer_id = 37
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:d7b84572-f577-474f-abed-ebdb1c5b7604'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 9, part.movement_number = NULL,
    part.name_ko = 'Va. Narration « Oh ! que ne puis‐je la trouver » (Lélio)', part.name_en = 'Lélio, ou Le Retour à la vie, op. 14b: Va. Narration « Oh ! que ne puis‐je la trouver » (Lélio)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 647 AND p.composer_id = 37 AND part.part_key = 'musicbrainz:a47b56a2-405c-42a5-b266-3c5dafbbd59a' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:a47b56a2-405c-42a5-b266-3c5dafbbd59a', 9, NULL, 'Va. Narration « Oh ! que ne puis‐je la trouver » (Lélio)', 'Lélio, ou Le Retour à la vie, op. 14b: Va. Narration « Oh ! que ne puis‐je la trouver » (Lélio)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 647 AND p.composer_id = 37
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:a47b56a2-405c-42a5-b266-3c5dafbbd59a'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 10, part.movement_number = NULL,
    part.name_ko = 'La Harpe éolienne – Souvenirs', part.name_en = 'Lélio, ou Le Retour à la vie, op. 14b: V. La Harpe éolienne – Souvenirs',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 647 AND p.composer_id = 37 AND part.part_key = 'musicbrainz:bfc41ef2-a781-44c3-b492-b6bf0efa9714' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:bfc41ef2-a781-44c3-b492-b6bf0efa9714', 10, NULL, 'La Harpe éolienne – Souvenirs', 'Lélio, ou Le Retour à la vie, op. 14b: V. La Harpe éolienne – Souvenirs', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 647 AND p.composer_id = 37
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:bfc41ef2-a781-44c3-b492-b6bf0efa9714'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 11, part.movement_number = NULL,
    part.name_ko = 'VIa. Narration « Mais pourquoi m’abandonner » (Lélio)', part.name_en = 'Lélio, ou Le Retour à la vie, op. 14b: VIa. Narration « Mais pourquoi m’abandonner » (Lélio)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 647 AND p.composer_id = 37 AND part.part_key = 'musicbrainz:0b02bca9-3d7e-4eab-8ffe-77abeefa6122' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:0b02bca9-3d7e-4eab-8ffe-77abeefa6122', 11, NULL, 'VIa. Narration « Mais pourquoi m’abandonner » (Lélio)', 'Lélio, ou Le Retour à la vie, op. 14b: VIa. Narration « Mais pourquoi m’abandonner » (Lélio)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 647 AND p.composer_id = 37
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:0b02bca9-3d7e-4eab-8ffe-77abeefa6122'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 12, part.movement_number = NULL,
    part.name_ko = 'Fantaisie sur La Tempête de Shakespeare « Miranda ! » (Chœur)', part.name_en = 'Lélio, ou Le Retour à la vie, op. 14b: VI. Fantaisie sur La Tempête de Shakespeare « Miranda ! » (Chœur)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 647 AND p.composer_id = 37 AND part.part_key = 'musicbrainz:a1fa8c05-78a6-4a94-8573-675c7eb0ef06' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:a1fa8c05-78a6-4a94-8573-675c7eb0ef06', 12, NULL, 'Fantaisie sur La Tempête de Shakespeare « Miranda ! » (Chœur)', 'Lélio, ou Le Retour à la vie, op. 14b: VI. Fantaisie sur La Tempête de Shakespeare « Miranda ! » (Chœur)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 647 AND p.composer_id = 37
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:a1fa8c05-78a6-4a94-8573-675c7eb0ef06'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 13, part.movement_number = NULL,
    part.name_ko = 'Coda « Assez pour aujourd’hui ! » (Lélio)', part.name_en = 'Lélio, ou Le Retour à la vie, op. 14b: VII. Coda « Assez pour aujourd’hui ! » (Lélio)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 647 AND p.composer_id = 37 AND part.part_key = 'musicbrainz:4838f75b-9546-4569-a809-9b00282e10ef' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:4838f75b-9546-4569-a809-9b00282e10ef', 13, NULL, 'Coda « Assez pour aujourd’hui ! » (Lélio)', 'Lélio, ou Le Retour à la vie, op. 14b: VII. Coda « Assez pour aujourd’hui ! » (Lélio)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 647 AND p.composer_id = 37
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:4838f75b-9546-4569-a809-9b00282e10ef'
);


-- None Messe solennelle

UPDATE pieces piece
SET piece.title = 'Messe solennelle', piece.title_en = 'Messe solennelle',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 1315 AND piece.composer_id = 37
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'Introduction', part.name_en = 'Messe solennelle: I. Introduction',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 1315 AND p.composer_id = 37 AND part.part_key = 'musicbrainz:c093b9a1-1c05-3402-8c0a-e724544a4ea6' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:c093b9a1-1c05-3402-8c0a-e724544a4ea6', 1, 'I', 'Introduction', 'Messe solennelle: I. Introduction', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 1315 AND p.composer_id = 37
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:c093b9a1-1c05-3402-8c0a-e724544a4ea6'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'Kyrie', part.name_en = 'Messe solennelle: II. Kyrie',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 1315 AND p.composer_id = 37 AND part.part_key = 'musicbrainz:fce955d4-7d22-3929-8ccd-b312f2d2c23e' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:fce955d4-7d22-3929-8ccd-b312f2d2c23e', 2, 'II', 'Kyrie', 'Messe solennelle: II. Kyrie', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 1315 AND p.composer_id = 37
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:fce955d4-7d22-3929-8ccd-b312f2d2c23e'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = 'Gloria', part.name_en = 'Messe solennelle: III. Gloria',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 1315 AND p.composer_id = 37 AND part.part_key = 'musicbrainz:eac962dc-6d73-35a2-b0ae-959e110894c1' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:eac962dc-6d73-35a2-b0ae-959e110894c1', 3, 'III', 'Gloria', 'Messe solennelle: III. Gloria', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 1315 AND p.composer_id = 37
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:eac962dc-6d73-35a2-b0ae-959e110894c1'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = 'IV',
    part.name_ko = 'Gratias', part.name_en = 'Messe solennelle: IV. Gratias',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 1315 AND p.composer_id = 37 AND part.part_key = 'musicbrainz:d218969e-d0be-339d-87ec-4583295234a1' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:d218969e-d0be-339d-87ec-4583295234a1', 4, 'IV', 'Gratias', 'Messe solennelle: IV. Gratias', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 1315 AND p.composer_id = 37
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:d218969e-d0be-339d-87ec-4583295234a1'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 5, part.movement_number = 'V',
    part.name_ko = 'Quoniam', part.name_en = 'Messe solennelle: V. Quoniam',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 1315 AND p.composer_id = 37 AND part.part_key = 'musicbrainz:81c83712-860c-3e7b-9b98-4c718d7559f0' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:81c83712-860c-3e7b-9b98-4c718d7559f0', 5, 'V', 'Quoniam', 'Messe solennelle: V. Quoniam', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 1315 AND p.composer_id = 37
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:81c83712-860c-3e7b-9b98-4c718d7559f0'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 6, part.movement_number = 'VI',
    part.name_ko = 'Credo', part.name_en = 'Messe solennelle: VI. Credo',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 1315 AND p.composer_id = 37 AND part.part_key = 'musicbrainz:0554ad19-9adc-3e0f-8fd6-f46942106efe' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:0554ad19-9adc-3e0f-8fd6-f46942106efe', 6, 'VI', 'Credo', 'Messe solennelle: VI. Credo', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 1315 AND p.composer_id = 37
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:0554ad19-9adc-3e0f-8fd6-f46942106efe'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 7, part.movement_number = 'VII',
    part.name_ko = 'Incarnatus', part.name_en = 'Messe solennelle: VII. Incarnatus',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 1315 AND p.composer_id = 37 AND part.part_key = 'musicbrainz:2c80d832-b584-3e75-8822-13c7e17332c1' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:2c80d832-b584-3e75-8822-13c7e17332c1', 7, 'VII', 'Incarnatus', 'Messe solennelle: VII. Incarnatus', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 1315 AND p.composer_id = 37
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:2c80d832-b584-3e75-8822-13c7e17332c1'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 8, part.movement_number = 'VIII',
    part.name_ko = 'Crucifixus', part.name_en = 'Messe solennelle: VIII. Crucifixus',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 1315 AND p.composer_id = 37 AND part.part_key = 'musicbrainz:9121a3ef-c73b-3c96-92f9-e3768687a34c' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:9121a3ef-c73b-3c96-92f9-e3768687a34c', 8, 'VIII', 'Crucifixus', 'Messe solennelle: VIII. Crucifixus', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 1315 AND p.composer_id = 37
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:9121a3ef-c73b-3c96-92f9-e3768687a34c'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 9, part.movement_number = 'IX',
    part.name_ko = 'Resurrexit (original version)', part.name_en = 'Messe solennelle: IX. Resurrexit (original version)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 1315 AND p.composer_id = 37 AND part.part_key = 'musicbrainz:1e759975-609b-346c-8e3d-c64155c72636' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:1e759975-609b-346c-8e3d-c64155c72636', 9, 'IX', 'Resurrexit (original version)', 'Messe solennelle: IX. Resurrexit (original version)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 1315 AND p.composer_id = 37
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:1e759975-609b-346c-8e3d-c64155c72636'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 10, part.movement_number = 'X',
    part.name_ko = 'Motet pour l''offertoire', part.name_en = 'Messe solennelle: X. Motet pour l''offertoire',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 1315 AND p.composer_id = 37 AND part.part_key = 'musicbrainz:16eeae09-d546-3322-9c55-b374f6eaf4a5' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:16eeae09-d546-3322-9c55-b374f6eaf4a5', 10, 'X', 'Motet pour l''offertoire', 'Messe solennelle: X. Motet pour l''offertoire', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 1315 AND p.composer_id = 37
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:16eeae09-d546-3322-9c55-b374f6eaf4a5'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 11, part.movement_number = 'XI',
    part.name_ko = 'Sanctus', part.name_en = 'Messe solennelle: XI. Sanctus',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 1315 AND p.composer_id = 37 AND part.part_key = 'musicbrainz:dd00c68b-9e45-329e-92b4-be47a46ba40c' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:dd00c68b-9e45-329e-92b4-be47a46ba40c', 11, 'XI', 'Sanctus', 'Messe solennelle: XI. Sanctus', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 1315 AND p.composer_id = 37
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:dd00c68b-9e45-329e-92b4-be47a46ba40c'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 12, part.movement_number = 'XII',
    part.name_ko = 'O salutaris', part.name_en = 'Messe solennelle: XII. O salutaris',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 1315 AND p.composer_id = 37 AND part.part_key = 'musicbrainz:f51a5fdd-0add-3379-8974-0f073d9d46c8' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:f51a5fdd-0add-3379-8974-0f073d9d46c8', 12, 'XII', 'O salutaris', 'Messe solennelle: XII. O salutaris', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 1315 AND p.composer_id = 37
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:f51a5fdd-0add-3379-8974-0f073d9d46c8'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 13, part.movement_number = 'XIII',
    part.name_ko = 'Agnus Dei', part.name_en = 'Messe solennelle: XIII. Agnus Dei',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 1315 AND p.composer_id = 37 AND part.part_key = 'musicbrainz:95367a6e-0b62-3826-8f41-67ece3f19331' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:95367a6e-0b62-3826-8f41-67ece3f19331', 13, 'XIII', 'Agnus Dei', 'Messe solennelle: XIII. Agnus Dei', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 1315 AND p.composer_id = 37
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:95367a6e-0b62-3826-8f41-67ece3f19331'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 14, part.movement_number = 'XIV',
    part.name_ko = 'Domine, salvum', part.name_en = 'Messe solennelle: XIV. Domine, salvum',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 1315 AND p.composer_id = 37 AND part.part_key = 'musicbrainz:cb5171b8-422d-3609-8c27-4e030440eaf8' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:cb5171b8-422d-3609-8c27-4e030440eaf8', 14, 'XIV', 'Domine, salvum', 'Messe solennelle: XIV. Domine, salvum', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 1315 AND p.composer_id = 37
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:cb5171b8-422d-3609-8c27-4e030440eaf8'
);


-- Op. 2b 가곡 <Neuf Mélodies Irlandaises> Op. 2b

UPDATE pieces piece
SET piece.title = '가곡 <Neuf Mélodies Irlandaises> Op. 2b', piece.title_en = 'Neuf Mélodies Irlandaises, op. 2b, H. 38',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = 'Op.', piece.catalogue_number = '2b',
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 1362 AND piece.composer_id = 37
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'Le coucher du soleil, op. 2b no. 1, H. 39', part.name_en = 'Le coucher du soleil, op. 2b no. 1, H. 39',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 1362 AND p.composer_id = 37 AND part.part_key = 'musicbrainz:60ed7a4d-794a-44e9-b986-028ac39d151c' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:60ed7a4d-794a-44e9-b986-028ac39d151c', 1, NULL, 'Le coucher du soleil, op. 2b no. 1, H. 39', 'Le coucher du soleil, op. 2b no. 1, H. 39', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 1362 AND p.composer_id = 37
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:60ed7a4d-794a-44e9-b986-028ac39d151c'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'Hélène, op. 2b no. 2, H. 40A', part.name_en = 'Hélène, op. 2b no. 2, H. 40A',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 1362 AND p.composer_id = 37 AND part.part_key = 'musicbrainz:90b4c1ea-f000-4df0-881b-2e51e50eb04c' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:90b4c1ea-f000-4df0-881b-2e51e50eb04c', 2, NULL, 'Hélène, op. 2b no. 2, H. 40A', 'Hélène, op. 2b no. 2, H. 40A', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 1362 AND p.composer_id = 37
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:90b4c1ea-f000-4df0-881b-2e51e50eb04c'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = NULL,
    part.name_ko = 'Chant guerrier, op. 2b no. 3, H. 41', part.name_en = 'Chant guerrier, op. 2b no. 3, H. 41',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 1362 AND p.composer_id = 37 AND part.part_key = 'musicbrainz:af6ae664-cbca-4f78-87ab-20d1a54778ad' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:af6ae664-cbca-4f78-87ab-20d1a54778ad', 3, NULL, 'Chant guerrier, op. 2b no. 3, H. 41', 'Chant guerrier, op. 2b no. 3, H. 41', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 1362 AND p.composer_id = 37
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:af6ae664-cbca-4f78-87ab-20d1a54778ad'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = NULL,
    part.name_ko = 'La belle voyageuse, op. 2b no. 4, H. 42A', part.name_en = 'La belle voyageuse, op. 2b no. 4, H. 42A',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 1362 AND p.composer_id = 37 AND part.part_key = 'musicbrainz:5ffa75d9-a3ff-482c-a856-5585dc73d305' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:5ffa75d9-a3ff-482c-a856-5585dc73d305', 4, NULL, 'La belle voyageuse, op. 2b no. 4, H. 42A', 'La belle voyageuse, op. 2b no. 4, H. 42A', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 1362 AND p.composer_id = 37
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:5ffa75d9-a3ff-482c-a856-5585dc73d305'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 5, part.movement_number = NULL,
    part.name_ko = 'Chanson à boire, op. 2b no. 5, H. 43', part.name_en = 'Chanson à boire, op. 2b no. 5, H. 43',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 1362 AND p.composer_id = 37 AND part.part_key = 'musicbrainz:c564a253-d593-46e8-bf6a-4963d5b6763e' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:c564a253-d593-46e8-bf6a-4963d5b6763e', 5, NULL, 'Chanson à boire, op. 2b no. 5, H. 43', 'Chanson à boire, op. 2b no. 5, H. 43', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 1362 AND p.composer_id = 37
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:c564a253-d593-46e8-bf6a-4963d5b6763e'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 6, part.movement_number = NULL,
    part.name_ko = 'Chant sacré, op. 2b no. 6, H. 44A', part.name_en = 'Chant sacré, op. 2b no. 6, H. 44A',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 1362 AND p.composer_id = 37 AND part.part_key = 'musicbrainz:fa606ed7-8a32-4a0b-83b2-1a013f15a8f4' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:fa606ed7-8a32-4a0b-83b2-1a013f15a8f4', 6, NULL, 'Chant sacré, op. 2b no. 6, H. 44A', 'Chant sacré, op. 2b no. 6, H. 44A', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 1362 AND p.composer_id = 37
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:fa606ed7-8a32-4a0b-83b2-1a013f15a8f4'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 7, part.movement_number = NULL,
    part.name_ko = 'L’Origine de la harpe, op. 2b no. 7, H. 45', part.name_en = 'L’Origine de la harpe, op. 2b no. 7, H. 45',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 1362 AND p.composer_id = 37 AND part.part_key = 'musicbrainz:5ac7d312-e4e4-462c-b463-d5edf7b3c226' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:5ac7d312-e4e4-462c-b463-d5edf7b3c226', 7, NULL, 'L’Origine de la harpe, op. 2b no. 7, H. 45', 'L’Origine de la harpe, op. 2b no. 7, H. 45', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 1362 AND p.composer_id = 37
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:5ac7d312-e4e4-462c-b463-d5edf7b3c226'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 8, part.movement_number = NULL,
    part.name_ko = 'Adieu Bessy, op. 2b no. 8, H. 46A', part.name_en = 'Adieu Bessy, op. 2b no. 8, H. 46A',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 1362 AND p.composer_id = 37 AND part.part_key = 'musicbrainz:6d758526-ec8e-406e-8569-eb72199b0178' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:6d758526-ec8e-406e-8569-eb72199b0178', 8, NULL, 'Adieu Bessy, op. 2b no. 8, H. 46A', 'Adieu Bessy, op. 2b no. 8, H. 46A', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 1362 AND p.composer_id = 37
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:6d758526-ec8e-406e-8569-eb72199b0178'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 9, part.movement_number = NULL,
    part.name_ko = 'Elégie en prose, op. 2b no. 9, H. 47', part.name_en = 'Elégie en prose, op. 2b no. 9, H. 47',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 1362 AND p.composer_id = 37 AND part.part_key = 'musicbrainz:08d92f8b-57ce-47e3-aabe-e938877d524e' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:08d92f8b-57ce-47e3-aabe-e938877d524e', 9, NULL, 'Elégie en prose, op. 2b no. 9, H. 47', 'Elégie en prose, op. 2b no. 9, H. 47', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 1362 AND p.composer_id = 37
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:08d92f8b-57ce-47e3-aabe-e938877d524e'
);


-- None 가곡 <Nocturne à deux voix>

UPDATE pieces piece
SET piece.title = '가곡 <Nocturne à deux voix>', piece.title_en = 'Nocturne à deux voix',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 2324 AND piece.composer_id = 37
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None 서곡 "Rob Roy"

UPDATE pieces piece
SET piece.title = '서곡 "Rob Roy"', piece.title_en = 'Ouverture "Rob Roy"',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 2046 AND piece.composer_id = 37
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None 가곡 <Pleure pauvre Colette>

UPDATE pieces piece
SET piece.title = '가곡 <Pleure pauvre Colette>', piece.title_en = 'Pleure pauvre Colette',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 2056 AND piece.composer_id = 37
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None 가곡 <Prière du matin>

UPDATE pieces piece
SET piece.title = '가곡 <Prière du matin>', piece.title_en = 'Prière du matin',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 2953 AND piece.composer_id = 37
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Prélude à Les Troyens à Carthage

UPDATE pieces piece
SET piece.title = 'Prélude à Les Troyens à Carthage', piece.title_en = 'Prélude à Les Troyens à Carthage',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 2718 AND piece.composer_id = 37
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- H. 59 Quartetto e coro dei maggi

UPDATE pieces piece
SET piece.title = 'Quartetto e coro dei maggi', piece.title_en = 'Quartetto e coro dei maggi, H. 59',
    piece.type = 'song', piece.opus_number = 'H. 59',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 989 AND piece.composer_id = 37
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None 레퀴엠 "Grande Messe des Morts"

UPDATE pieces piece
SET piece.title = '레퀴엠 "Grande Messe des Morts"', piece.title_en = 'Requiem, op. 5 « Grande Messe des Morts »',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 2941 AND piece.composer_id = 37
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'Requiem et Kyrie', part.name_en = 'Requiem, op. 5: I. Requiem et Kyrie',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 2941 AND p.composer_id = 37 AND part.part_key = 'musicbrainz:8df91405-36f1-3f16-b8a5-7cf7e9f90ca6' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:8df91405-36f1-3f16-b8a5-7cf7e9f90ca6', 1, 'I', 'Requiem et Kyrie', 'Requiem, op. 5: I. Requiem et Kyrie', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 2941 AND p.composer_id = 37
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:8df91405-36f1-3f16-b8a5-7cf7e9f90ca6'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'Dies irae et Tuba mirum', part.name_en = 'Requiem, op. 5: II. Dies irae et Tuba mirum',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 2941 AND p.composer_id = 37 AND part.part_key = 'musicbrainz:cca13cb6-fe40-3360-8d74-a69891251f1a' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:cca13cb6-fe40-3360-8d74-a69891251f1a', 2, 'II', 'Dies irae et Tuba mirum', 'Requiem, op. 5: II. Dies irae et Tuba mirum', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 2941 AND p.composer_id = 37
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:cca13cb6-fe40-3360-8d74-a69891251f1a'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = 'Quid sum miser', part.name_en = 'Requiem, op. 5: III. Quid sum miser',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 2941 AND p.composer_id = 37 AND part.part_key = 'musicbrainz:662c409c-27c9-3f38-9fb8-94ab2a2dd6c8' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:662c409c-27c9-3f38-9fb8-94ab2a2dd6c8', 3, 'III', 'Quid sum miser', 'Requiem, op. 5: III. Quid sum miser', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 2941 AND p.composer_id = 37
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:662c409c-27c9-3f38-9fb8-94ab2a2dd6c8'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = 'IV',
    part.name_ko = 'Rex tremendae', part.name_en = 'Requiem, op. 5: IV. Rex tremendae',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 2941 AND p.composer_id = 37 AND part.part_key = 'musicbrainz:559348ba-93f0-303f-a618-aab83e675036' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:559348ba-93f0-303f-a618-aab83e675036', 4, 'IV', 'Rex tremendae', 'Requiem, op. 5: IV. Rex tremendae', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 2941 AND p.composer_id = 37
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:559348ba-93f0-303f-a618-aab83e675036'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 5, part.movement_number = 'V',
    part.name_ko = 'Quaerens me', part.name_en = 'Requiem, op. 5: V. Quaerens me',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 2941 AND p.composer_id = 37 AND part.part_key = 'musicbrainz:6f0db7c9-776e-3404-9bc4-dd35db3edea9' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:6f0db7c9-776e-3404-9bc4-dd35db3edea9', 5, 'V', 'Quaerens me', 'Requiem, op. 5: V. Quaerens me', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 2941 AND p.composer_id = 37
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:6f0db7c9-776e-3404-9bc4-dd35db3edea9'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 6, part.movement_number = 'VI',
    part.name_ko = 'Lacrymosa', part.name_en = 'Requiem, op. 5: VI. Lacrymosa',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 2941 AND p.composer_id = 37 AND part.part_key = 'musicbrainz:35e828cb-49f5-3187-a010-9802c4697501' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:35e828cb-49f5-3187-a010-9802c4697501', 6, 'VI', 'Lacrymosa', 'Requiem, op. 5: VI. Lacrymosa', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 2941 AND p.composer_id = 37
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:35e828cb-49f5-3187-a010-9802c4697501'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 7, part.movement_number = 'VII',
    part.name_ko = 'Offertorium', part.name_en = 'Requiem, op. 5: VII. Offertorium',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 2941 AND p.composer_id = 37 AND part.part_key = 'musicbrainz:33c89576-5a89-35b3-a554-edd6a0ef24ac' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:33c89576-5a89-35b3-a554-edd6a0ef24ac', 7, 'VII', 'Offertorium', 'Requiem, op. 5: VII. Offertorium', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 2941 AND p.composer_id = 37
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:33c89576-5a89-35b3-a554-edd6a0ef24ac'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 8, part.movement_number = 'VIII',
    part.name_ko = 'Hostias', part.name_en = 'Requiem, op. 5: VIII. Hostias',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 2941 AND p.composer_id = 37 AND part.part_key = 'musicbrainz:1571ed67-8f5a-39ae-9bff-5ca9892a9c36' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:1571ed67-8f5a-39ae-9bff-5ca9892a9c36', 8, 'VIII', 'Hostias', 'Requiem, op. 5: VIII. Hostias', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 2941 AND p.composer_id = 37
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:1571ed67-8f5a-39ae-9bff-5ca9892a9c36'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 9, part.movement_number = 'IX',
    part.name_ko = 'Sanctus', part.name_en = 'Requiem, op. 5: IX. Sanctus',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 2941 AND p.composer_id = 37 AND part.part_key = 'musicbrainz:eae9f6a9-e1da-38a7-a480-238df1f30596' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:eae9f6a9-e1da-38a7-a480-238df1f30596', 9, 'IX', 'Sanctus', 'Requiem, op. 5: IX. Sanctus', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 2941 AND p.composer_id = 37
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:eae9f6a9-e1da-38a7-a480-238df1f30596'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 10, part.movement_number = 'X',
    part.name_ko = 'Agnus Dei', part.name_en = 'Requiem, op. 5: X. Agnus Dei',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 2941 AND p.composer_id = 37 AND part.part_key = 'musicbrainz:6a6218d7-e0e0-3cb4-bdc5-b53016f7adde' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:6a6218d7-e0e0-3cb4-bdc5-b53016f7adde', 10, 'X', 'Agnus Dei', 'Requiem, op. 5: X. Agnus Dei', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 2941 AND p.composer_id = 37
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:6a6218d7-e0e0-3cb4-bdc5-b53016f7adde'
);


-- Op. 17 Roméo et Juliette, symphonie dramatique pour alto, ténor, basse, chœur et orchestre Op. 17

UPDATE pieces piece
SET piece.title = 'Roméo et Juliette, symphonie dramatique pour alto, ténor, basse, chœur et orchestre Op. 17', piece.title_en = 'Roméo et Juliette, symphonie dramatique pour alto, ténor, basse, chœur et orchestre, op. 17, H. 79',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = 'Op.', piece.catalogue_number = '17',
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 674 AND piece.composer_id = 37
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'Première partie: Nº 1. Introduction : Combats - Tumulte - Intervention du Prince', part.name_en = 'Roméo et Juliette, op. 17 : Première partie: Nº 1. Introduction : Combats - Tumulte - Intervention du Prince',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 674 AND p.composer_id = 37 AND part.part_key = 'musicbrainz:c442b4e1-b564-3c76-bdae-a88157538461' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:c442b4e1-b564-3c76-bdae-a88157538461', 1, NULL, 'Première partie: Nº 1. Introduction : Combats - Tumulte - Intervention du Prince', 'Roméo et Juliette, op. 17 : Première partie: Nº 1. Introduction : Combats - Tumulte - Intervention du Prince', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 674 AND p.composer_id = 37
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:c442b4e1-b564-3c76-bdae-a88157538461'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'Première partie: Nº 1. Prologue : Récitatif Chorale « D’anciennes haines endormies » / Strophes « Premiers transports que nul n’oublie ! » / Récitatif et Scherzetto « Bientôt de Roméo »', part.name_en = 'Roméo et Juliette, op. 17 : Première partie: Nº 1. Prologue : Récitatif Chorale « D’anciennes haines endormies » / Strophes « Premiers transports que nul n’oublie ! » / Récitatif et Scherzetto « Bientôt de Roméo »',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 674 AND p.composer_id = 37 AND part.part_key = 'musicbrainz:d9715121-ce5a-4c89-bf04-1d0bd9c3f8d0' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:d9715121-ce5a-4c89-bf04-1d0bd9c3f8d0', 2, NULL, 'Première partie: Nº 1. Prologue : Récitatif Chorale « D’anciennes haines endormies » / Strophes « Premiers transports que nul n’oublie ! » / Récitatif et Scherzetto « Bientôt de Roméo »', 'Roméo et Juliette, op. 17 : Première partie: Nº 1. Prologue : Récitatif Chorale « D’anciennes haines endormies » / Strophes « Premiers transports que nul n’oublie ! » / Récitatif et Scherzetto « Bientôt de Roméo »', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 674 AND p.composer_id = 37
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:d9715121-ce5a-4c89-bf04-1d0bd9c3f8d0'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = NULL,
    part.name_ko = 'Deuxième partie: Nº 2. Roméo seul - Tristesse - Bruit lointain de bal et de concert - Grande Fête chez Capulet', part.name_en = 'Roméo et Juliette, op. 17 : Deuxième partie: Nº 2. Roméo seul - Tristesse - Bruit lointain de bal et de concert - Grande Fête chez Capulet',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 674 AND p.composer_id = 37 AND part.part_key = 'musicbrainz:c8c03d4c-61b6-37d4-aef0-58b5524d6cf0' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:c8c03d4c-61b6-37d4-aef0-58b5524d6cf0', 3, NULL, 'Deuxième partie: Nº 2. Roméo seul - Tristesse - Bruit lointain de bal et de concert - Grande Fête chez Capulet', 'Roméo et Juliette, op. 17 : Deuxième partie: Nº 2. Roméo seul - Tristesse - Bruit lointain de bal et de concert - Grande Fête chez Capulet', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 674 AND p.composer_id = 37
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:c8c03d4c-61b6-37d4-aef0-58b5524d6cf0'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = NULL,
    part.name_ko = 'Deuxième partie: Nº 3. Scène d''amour: Nuit sereine - Le Jardin de Capulet, silencieux et désert « Ohé ! Capulets, bonsoir ! » - Les jeunes Capulets sortant de la fête, passent en chantant des réminiscences de la musique du bal', part.name_en = 'Roméo et Juliette, op. 17 : Deuxième partie: Nº 3. Scène d''amour: Nuit sereine - Le Jardin de Capulet, silencieux et désert « Ohé ! Capulets, bonsoir ! » - Les jeunes Capulets sortant de la fête, passent en chantant des réminiscences de la musique du bal',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 674 AND p.composer_id = 37 AND part.part_key = 'musicbrainz:856148cf-6918-3b88-bb20-b2bc70553aa7' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:856148cf-6918-3b88-bb20-b2bc70553aa7', 4, NULL, 'Deuxième partie: Nº 3. Scène d''amour: Nuit sereine - Le Jardin de Capulet, silencieux et désert « Ohé ! Capulets, bonsoir ! » - Les jeunes Capulets sortant de la fête, passent en chantant des réminiscences de la musique du bal', 'Roméo et Juliette, op. 17 : Deuxième partie: Nº 3. Scène d''amour: Nuit sereine - Le Jardin de Capulet, silencieux et désert « Ohé ! Capulets, bonsoir ! » - Les jeunes Capulets sortant de la fête, passent en chantant des réminiscences de la musique du bal', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 674 AND p.composer_id = 37
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:856148cf-6918-3b88-bb20-b2bc70553aa7'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 5, part.movement_number = NULL,
    part.name_ko = 'Deuxième partie: Nº 4. Scherzo: La Reine Mab, ou la Fée des Songes', part.name_en = 'Roméo et Juliette, op. 17 : Deuxième partie: Nº 4. Scherzo: La Reine Mab, ou la Fée des Songes',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 674 AND p.composer_id = 37 AND part.part_key = 'musicbrainz:a4b292f6-6ba2-3fa9-adf0-b87572c87967' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:a4b292f6-6ba2-3fa9-adf0-b87572c87967', 5, NULL, 'Deuxième partie: Nº 4. Scherzo: La Reine Mab, ou la Fée des Songes', 'Roméo et Juliette, op. 17 : Deuxième partie: Nº 4. Scherzo: La Reine Mab, ou la Fée des Songes', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 674 AND p.composer_id = 37
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:a4b292f6-6ba2-3fa9-adf0-b87572c87967'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 6, part.movement_number = NULL,
    part.name_ko = 'Troisième partie : Nº 5. Convoi funèbre de Juliette « Jetez des fleurs pour la vierge expirée ! »', part.name_en = 'Roméo et Juliette, op. 17 : Troisième partie : Nº 5. Convoi funèbre de Juliette « Jetez des fleurs pour la vierge expirée ! »',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 674 AND p.composer_id = 37 AND part.part_key = 'musicbrainz:3e46799c-51e1-398a-8696-998c08724b2c' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:3e46799c-51e1-398a-8696-998c08724b2c', 6, NULL, 'Troisième partie : Nº 5. Convoi funèbre de Juliette « Jetez des fleurs pour la vierge expirée ! »', 'Roméo et Juliette, op. 17 : Troisième partie : Nº 5. Convoi funèbre de Juliette « Jetez des fleurs pour la vierge expirée ! »', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 674 AND p.composer_id = 37
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:3e46799c-51e1-398a-8696-998c08724b2c'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 7, part.movement_number = NULL,
    part.name_ko = 'Troisième partie : Nº 6. Roméo au tombeau des Capulets – Invocation – Réveil de Juliette – Joie délirante, désespoir – Dernières angoisses et mort des deux amants', part.name_en = 'Roméo et Juliette, op. 17 : Troisième partie : Nº 6. Roméo au tombeau des Capulets – Invocation – Réveil de Juliette – Joie délirante, désespoir – Dernières angoisses et mort des deux amants',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 674 AND p.composer_id = 37 AND part.part_key = 'musicbrainz:d1b67abb-a60f-337b-9522-c3c8140ae9b6' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:d1b67abb-a60f-337b-9522-c3c8140ae9b6', 7, NULL, 'Troisième partie : Nº 6. Roméo au tombeau des Capulets – Invocation – Réveil de Juliette – Joie délirante, désespoir – Dernières angoisses et mort des deux amants', 'Roméo et Juliette, op. 17 : Troisième partie : Nº 6. Roméo au tombeau des Capulets – Invocation – Réveil de Juliette – Joie délirante, désespoir – Dernières angoisses et mort des deux amants', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 674 AND p.composer_id = 37
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:d1b67abb-a60f-337b-9522-c3c8140ae9b6'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 8, part.movement_number = NULL,
    part.name_ko = 'Troisième partie : Nº 7. Final : La foule accourt au cimetière - Rixe des Capulets et des Montagus « Quoi ! Roméo de retour » - Récitatif du Père Laurence « Je vais dévoiler le mystère »', part.name_en = 'Roméo et Juliette, op. 17 : Troisième partie : Nº 7. Final : La foule accourt au cimetière - Rixe des Capulets et des Montagus « Quoi ! Roméo de retour » - Récitatif du Père Laurence « Je vais dévoiler le mystère »',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 674 AND p.composer_id = 37 AND part.part_key = 'musicbrainz:f9130bc6-22d5-3b58-b31e-aad6d15cc5f1' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:f9130bc6-22d5-3b58-b31e-aad6d15cc5f1', 8, NULL, 'Troisième partie : Nº 7. Final : La foule accourt au cimetière - Rixe des Capulets et des Montagus « Quoi ! Roméo de retour » - Récitatif du Père Laurence « Je vais dévoiler le mystère »', 'Roméo et Juliette, op. 17 : Troisième partie : Nº 7. Final : La foule accourt au cimetière - Rixe des Capulets et des Montagus « Quoi ! Roméo de retour » - Récitatif du Père Laurence « Je vais dévoiler le mystère »', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 674 AND p.composer_id = 37
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:f9130bc6-22d5-3b58-b31e-aad6d15cc5f1'
);


-- Op. 8 Rêverie et caprice

UPDATE pieces piece
SET piece.title = 'Rêverie et caprice', piece.title_en = 'Rêverie et caprice, op. 8, H. 88',
    piece.type = 'song', piece.opus_number = 'Op. 8',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 651 AND piece.composer_id = 37
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- Op. 11 Sara la baigneuse

UPDATE pieces piece
SET piece.title = 'Sara la baigneuse', piece.title_en = 'Sara la baigneuse, op. 11',
    piece.type = 'song', piece.opus_number = 'Op. 11',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 2974 AND piece.composer_id = 37
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- Op. 11 Sara la baigneuse Op. 11

UPDATE pieces piece
SET piece.title = 'Sara la baigneuse Op. 11', piece.title_en = 'Sara la baigneuse, op. 11, H. 69C',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = 'Op.', piece.catalogue_number = '11',
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 914 AND piece.composer_id = 37
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- H 98 Sérénade agreste à la madone sur la thème des pifferari romains

UPDATE pieces piece
SET piece.title = 'Sérénade agreste à la madone sur la thème des pifferari romains', piece.title_en = 'Sérénade agreste à la madone sur la thème des pifferari romains, H 98',
    piece.type = 'song', piece.opus_number = 'H 98',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 2132 AND piece.composer_id = 37
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- H. 142 Tantum Ergo

UPDATE pieces piece
SET piece.title = 'Tantum Ergo', piece.title_en = 'Tantum Ergo, H. 142',
    piece.type = 'song', piece.opus_number = 'H. 142',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 2116 AND piece.composer_id = 37
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- Op. 22 테 데움 Op. 22

UPDATE pieces piece
SET piece.title = '테 데움 Op. 22', piece.title_en = 'Te Deum, op. 22',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = 'Op.', piece.catalogue_number = '22',
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 1391 AND piece.composer_id = 37
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'Te deum', part.name_en = 'Te Deum, op. 22: I. Te deum',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 1391 AND p.composer_id = 37 AND part.part_key = 'musicbrainz:9baa3e81-d8e9-4ee5-8981-c46a7b676827' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:9baa3e81-d8e9-4ee5-8981-c46a7b676827', 1, NULL, 'Te deum', 'Te Deum, op. 22: I. Te deum', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 1391 AND p.composer_id = 37
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:9baa3e81-d8e9-4ee5-8981-c46a7b676827'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'Tibi omnes', part.name_en = 'Te Deum, op. 22: II. Tibi omnes',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 1391 AND p.composer_id = 37 AND part.part_key = 'musicbrainz:02534fca-330e-4694-846c-5ee3a6014c8f' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:02534fca-330e-4694-846c-5ee3a6014c8f', 2, NULL, 'Tibi omnes', 'Te Deum, op. 22: II. Tibi omnes', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 1391 AND p.composer_id = 37
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:02534fca-330e-4694-846c-5ee3a6014c8f'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = NULL,
    part.name_ko = 'Prelude', part.name_en = 'Te Deum, op. 22: Prelude',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 1391 AND p.composer_id = 37 AND part.part_key = 'musicbrainz:58e834dc-9504-40c0-85e2-0a7ef0e5987c' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:58e834dc-9504-40c0-85e2-0a7ef0e5987c', 3, NULL, 'Prelude', 'Te Deum, op. 22: Prelude', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 1391 AND p.composer_id = 37
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:58e834dc-9504-40c0-85e2-0a7ef0e5987c'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = NULL,
    part.name_ko = 'Dignare, domine', part.name_en = 'Te Deum, op. 22: III. Dignare, domine',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 1391 AND p.composer_id = 37 AND part.part_key = 'musicbrainz:4cf7adb4-43d6-43bd-9614-379ee3f26bd4' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:4cf7adb4-43d6-43bd-9614-379ee3f26bd4', 4, NULL, 'Dignare, domine', 'Te Deum, op. 22: III. Dignare, domine', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 1391 AND p.composer_id = 37
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:4cf7adb4-43d6-43bd-9614-379ee3f26bd4'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 5, part.movement_number = NULL,
    part.name_ko = 'Christe, rex gloriae', part.name_en = 'Te Deum, op. 22: IV. Christe, rex gloriae',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 1391 AND p.composer_id = 37 AND part.part_key = 'musicbrainz:841e590b-d161-4bc9-b8b3-73b1cf63f497' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:841e590b-d161-4bc9-b8b3-73b1cf63f497', 5, NULL, 'Christe, rex gloriae', 'Te Deum, op. 22: IV. Christe, rex gloriae', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 1391 AND p.composer_id = 37
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:841e590b-d161-4bc9-b8b3-73b1cf63f497'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 6, part.movement_number = NULL,
    part.name_ko = 'Te ergo quaesumus', part.name_en = 'Te Deum, op. 22: V. Te ergo quaesumus',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 1391 AND p.composer_id = 37 AND part.part_key = 'musicbrainz:d203b0af-d582-4fcc-b57f-faa6f76c4a71' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:d203b0af-d582-4fcc-b57f-faa6f76c4a71', 6, NULL, 'Te ergo quaesumus', 'Te Deum, op. 22: V. Te ergo quaesumus', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 1391 AND p.composer_id = 37
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:d203b0af-d582-4fcc-b57f-faa6f76c4a71'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 7, part.movement_number = NULL,
    part.name_ko = 'Judex crederis', part.name_en = 'Te Deum, op. 22: VI. Judex crederis',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 1391 AND p.composer_id = 37 AND part.part_key = 'musicbrainz:28ad75c8-2414-401d-9e9a-be9c8063b63e' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:28ad75c8-2414-401d-9e9a-be9c8063b63e', 7, NULL, 'Judex crederis', 'Te Deum, op. 22: VI. Judex crederis', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 1391 AND p.composer_id = 37
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:28ad75c8-2414-401d-9e9a-be9c8063b63e'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 8, part.movement_number = NULL,
    part.name_ko = 'Appendix: Marche pour la presentation des drapeaux', part.name_en = 'Te Deum, op. 22: Appendix: Marche pour la presentation des drapeaux',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 1391 AND p.composer_id = 37 AND part.part_key = 'musicbrainz:b9875ab1-45da-4fbb-926e-7db79f603187' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:b9875ab1-45da-4fbb-926e-7db79f603187', 8, NULL, 'Appendix: Marche pour la presentation des drapeaux', 'Te Deum, op. 22: Appendix: Marche pour la presentation des drapeaux', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 1391 AND p.composer_id = 37
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:b9875ab1-45da-4fbb-926e-7db79f603187'
);


-- H. 99 토카타

UPDATE pieces piece
SET piece.title = '토카타', piece.title_en = 'Toccata, H. 99',
    piece.type = 'song', piece.opus_number = 'H. 99',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 1793 AND piece.composer_id = 37
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- H. 16 Toi qui l'aimas, verse des pleurs

UPDATE pieces piece
SET piece.title = 'Toi qui l''aimas, verse des pleurs', piece.title_en = 'Toi qui l''aimas, verse des pleurs, H. 16',
    piece.type = 'song', piece.opus_number = 'H. 16',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 1045 AND piece.composer_id = 37
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- Op. 18 Tristia

UPDATE pieces piece
SET piece.title = 'Tristia', piece.title_en = 'Tristia, op. 18',
    piece.type = 'album', piece.opus_number = 'Op. 18',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 1370 AND piece.composer_id = 37
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'Méditation religieuse « Ce monde entier »', part.name_en = 'Tristia, op. 18 : I. Méditation religieuse « Ce monde entier »',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 1370 AND p.composer_id = 37 AND part.part_key = 'musicbrainz:b3560f86-debc-38fc-89dc-50b48d6fc6e2' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:b3560f86-debc-38fc-89dc-50b48d6fc6e2', 1, 'I', 'Méditation religieuse « Ce monde entier »', 'Tristia, op. 18 : I. Méditation religieuse « Ce monde entier »', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 1370 AND p.composer_id = 37
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:b3560f86-debc-38fc-89dc-50b48d6fc6e2'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'La Mort d’Ophélie. Ballade « Auprès d’un torrent »', part.name_en = 'Tristia, op. 18 : II. La Mort d’Ophélie. Ballade « Auprès d’un torrent »',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 1370 AND p.composer_id = 37 AND part.part_key = 'musicbrainz:f584a065-ef97-3a6c-a2c2-1560ba51afa6' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:f584a065-ef97-3a6c-a2c2-1560ba51afa6', 2, 'II', 'La Mort d’Ophélie. Ballade « Auprès d’un torrent »', 'Tristia, op. 18 : II. La Mort d’Ophélie. Ballade « Auprès d’un torrent »', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 1370 AND p.composer_id = 37
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:f584a065-ef97-3a6c-a2c2-1560ba51afa6'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = 'Marche funèbre pour la dernière scène d''Hamlet', part.name_en = 'Tristia, op. 18: III. Marche funèbre pour la dernière scène d''Hamlet',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 1370 AND p.composer_id = 37 AND part.part_key = 'musicbrainz:40a03804-8d2f-30ec-9190-8aaa969c6ac2' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:40a03804-8d2f-30ec-9190-8aaa969c6ac2', 3, 'III', 'Marche funèbre pour la dernière scène d''Hamlet', 'Tristia, op. 18: III. Marche funèbre pour la dernière scène d''Hamlet', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 1370 AND p.composer_id = 37
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:40a03804-8d2f-30ec-9190-8aaa969c6ac2'
);


-- H. 141 Veni Creator

UPDATE pieces piece
SET piece.title = 'Veni Creator', piece.title_en = 'Veni Creator, H. 141',
    piece.type = 'song', piece.opus_number = 'H. 141',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 2703 AND piece.composer_id = 37
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- Op. 23 오페라 <Benvenuto Cellini> Op. 23

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '오페라 <Benvenuto Cellini> Op. 23', 'Benvenuto Cellini, op. 23', 'album', NULL, 'Op.', '23', NULL, 'manual', 1
FROM composers c
WHERE c.id = 37
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '오페라 <Benvenuto Cellini> Op. 23'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '88f4758e-450c-4d64-b0eb-f2bb0b4d134e'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '88f4758e-450c-4d64-b0eb-f2bb0b4d134e'
FROM pieces p
WHERE p.composer_id = 37 AND p.title = '오페라 <Benvenuto Cellini> Op. 23' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '88f4758e-450c-4d64-b0eb-f2bb0b4d134e'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:4b3722fa-7d6e-4aed-a90f-781cdd2d399a', 1, NULL, 'Overture', 'Benvenuto Cellini, op. 23 : Overture', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 37 AND p.title = '오페라 <Benvenuto Cellini> Op. 23' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:4b3722fa-7d6e-4aed-a90f-781cdd2d399a'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:066c6ce2-ecc1-4e29-8dd3-4d2d1a8e7923', 2, NULL, 'Acte I', 'Benvenuto Cellini, op. 23 : Acte I', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 37 AND p.title = '오페라 <Benvenuto Cellini> Op. 23' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:066c6ce2-ecc1-4e29-8dd3-4d2d1a8e7923'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:0dfed57f-bfff-4a65-bdf4-2624d4b5fa96', 1, NULL, 'Acte I. Premier tableau : No. 1. Introduction « Teresa ! Mais où peut-elle être ? » (Balducci)', 'Benvenuto Cellini : Acte I. Premier tableau : No. 1. Introduction « Teresa ! Mais où peut-elle être ? » (Balducci)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:066c6ce2-ecc1-4e29-8dd3-4d2d1a8e7923'
WHERE p.composer_id = 37 AND p.title = '오페라 <Benvenuto Cellini> Op. 23' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:0dfed57f-bfff-4a65-bdf4-2624d4b5fa96'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:0a5c93f5-2bee-4f7c-86d4-067799901246', 2, NULL, 'Acte I. Premier tableau : No. 2. Chœur des masques « Enfin il est sorti » (Teresa, Balducci, Cellini, Francesco, Bernardino et Masques)', 'Benvenuto Cellini : Acte I. Premier tableau : No. 2. Chœur des masques « Enfin il est sorti » (Teresa, Balducci, Cellini, Francesco, Bernardino et Masques)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:066c6ce2-ecc1-4e29-8dd3-4d2d1a8e7923'
WHERE p.composer_id = 37 AND p.title = '오페라 <Benvenuto Cellini> Op. 23' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:0a5c93f5-2bee-4f7c-86d4-067799901246'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:9657dc48-558a-4972-a336-24a686acac05', 3, NULL, 'Acte I. Premier tableau : No. 3a. Récit et romance « Les belles fleurs ! » (Teresa)', 'Benvenuto Cellini : Acte I. Premier tableau : No. 3a. Récit et romance « Les belles fleurs ! » (Teresa)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:066c6ce2-ecc1-4e29-8dd3-4d2d1a8e7923'
WHERE p.composer_id = 37 AND p.title = '오페라 <Benvenuto Cellini> Op. 23' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:9657dc48-558a-4972-a336-24a686acac05'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:ab917677-f29e-4472-bfaa-f307c63fbfb4', 4, NULL, 'Acte I. Premier tableau : No. 3b. Récit et air « Quand j’aurai votre âge » (Teresa)', 'Benvenuto Cellini : Acte I. Premier tableau : No. 3b. Récit et air « Quand j’aurai votre âge » (Teresa)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:066c6ce2-ecc1-4e29-8dd3-4d2d1a8e7923'
WHERE p.composer_id = 37 AND p.title = '오페라 <Benvenuto Cellini> Op. 23' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:ab917677-f29e-4472-bfaa-f307c63fbfb4'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:16fb2886-4817-49d3-a127-76d86527d36a', 5, NULL, 'Acte I. Premier tableau : No. 4. Trio « Cellini ! » (Teresa, Cellini, Fieramosca)', 'Benvenuto Cellini : Acte I. Premier tableau : No. 4. Trio « Cellini ! » (Teresa, Cellini, Fieramosca)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:066c6ce2-ecc1-4e29-8dd3-4d2d1a8e7923'
WHERE p.composer_id = 37 AND p.title = '오페라 <Benvenuto Cellini> Op. 23' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:16fb2886-4817-49d3-a127-76d86527d36a'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:3f7cc4d0-7d20-4185-a924-96c72f0001af', 6, NULL, 'Acte I. Premier tableau : « Ah ! mourir, chère belle » (Teresa, Cellini, Fieramosca)', 'Benvenuto Cellini : Acte I. Premier tableau : « Ah ! mourir, chère belle » (Teresa, Cellini, Fieramosca)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:066c6ce2-ecc1-4e29-8dd3-4d2d1a8e7923'
WHERE p.composer_id = 37 AND p.title = '오페라 <Benvenuto Cellini> Op. 23' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:3f7cc4d0-7d20-4185-a924-96c72f0001af'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:cd137350-df75-4c11-9d1e-d11cd8516d69', 7, NULL, 'Acte I. Premier tableau : No. 5. Récitatif « Ciel ! Nous sommes perdus » (Teresa, Cellini, Fieramosca, Balducci)', 'Benvenuto Cellini : Acte I. Premier tableau : No. 5. Récitatif « Ciel ! Nous sommes perdus » (Teresa, Cellini, Fieramosca, Balducci)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:066c6ce2-ecc1-4e29-8dd3-4d2d1a8e7923'
WHERE p.composer_id = 37 AND p.title = '오페라 <Benvenuto Cellini> Op. 23' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:cd137350-df75-4c11-9d1e-d11cd8516d69'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:9cbb37f6-c9d4-4b29-81a0-d14952ddb7a2', 8, NULL, 'Acte I. Premier tableau : No. 6. Final « À nous, voisines et servantes ! » (Teresa, Balducci, Fieramosca)', 'Benvenuto Cellini : Acte I. Premier tableau : No. 6. Final « À nous, voisines et servantes ! » (Teresa, Balducci, Fieramosca)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:066c6ce2-ecc1-4e29-8dd3-4d2d1a8e7923'
WHERE p.composer_id = 37 AND p.title = '오페라 <Benvenuto Cellini> Op. 23' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:9cbb37f6-c9d4-4b29-81a0-d14952ddb7a2'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:37692b50-6752-4e1f-bbf2-64afee7f7feb', 9, NULL, 'Acte I. Premier tableau : « Ah, maître drôle ! » (Chœur, Teresa, Balducci, Fieramosca)', 'Benvenuto Cellini : Acte I. Premier tableau : « Ah, maître drôle ! » (Chœur, Teresa, Balducci, Fieramosca)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:066c6ce2-ecc1-4e29-8dd3-4d2d1a8e7923'
WHERE p.composer_id = 37 AND p.title = '오페라 <Benvenuto Cellini> Op. 23' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:37692b50-6752-4e1f-bbf2-64afee7f7feb'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:a0940a87-06ed-42aa-b163-4744ecabf66b', 10, NULL, 'Acte I. Deuxième tableau : No. 7. « Une heure encore » … « La gloire était ma seule idole » (Cellini)', 'Benvenuto Cellini : Acte I. Deuxième tableau : No. 7. « Une heure encore » … « La gloire était ma seule idole » (Cellini)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:066c6ce2-ecc1-4e29-8dd3-4d2d1a8e7923'
WHERE p.composer_id = 37 AND p.title = '오페라 <Benvenuto Cellini> Op. 23' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:a0940a87-06ed-42aa-b163-4744ecabf66b'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:28398f2b-0f0e-413f-90c1-8de46af7f686', 11, NULL, 'Acte I. Deuxième tableau : No. 8. Scène et chœur « À boire, à boire ! » / « Si la terre aux beaux jours se couronne » (Chœur, Cellini, Francesco, Bernardino)', 'Benvenuto Cellini : Acte I. Deuxième tableau : No. 8. Scène et chœur « À boire, à boire ! » / « Si la terre aux beaux jours se couronne » (Chœur, Cellini, Francesco, Bernardino)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:066c6ce2-ecc1-4e29-8dd3-4d2d1a8e7923'
WHERE p.composer_id = 37 AND p.title = '오페라 <Benvenuto Cellini> Op. 23' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:28398f2b-0f0e-413f-90c1-8de46af7f686'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:7fa562ed-88db-4c13-9d1c-0e50f7e0b592', 12, NULL, 'Acte I. Deuxième tableau : « Amis, avant qu’on recommence » / « Que voulez‐vous ? La cave est vide » / « Ascanio ! Vraiment ! Le voilà ! » (Chœur, Francesco, Bernardino, Cabaretier, Ascanio)', 'Benvenuto Cellini : Acte I. Deuxième tableau : « Amis, avant qu’on recommence » / « Que voulez‐vous ? La cave est vide » / « Ascanio ! Vraiment ! Le voilà ! » (Chœur, Francesco, Bernardino, Cabaretier, Ascanio)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:066c6ce2-ecc1-4e29-8dd3-4d2d1a8e7923'
WHERE p.composer_id = 37 AND p.title = '오페라 <Benvenuto Cellini> Op. 23' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:7fa562ed-88db-4c13-9d1c-0e50f7e0b592'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:4ef583a9-e81e-4fcd-ab7b-523e3dba6d8d', 13, NULL, 'Acte I. Deuxième tableau : Air « Cette somme t’est due » (Ascanio, Cellini, Chœur)', 'Benvenuto Cellini : Acte I. Deuxième tableau : Air « Cette somme t’est due » (Ascanio, Cellini, Chœur)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:066c6ce2-ecc1-4e29-8dd3-4d2d1a8e7923'
WHERE p.composer_id = 37 AND p.title = '오페라 <Benvenuto Cellini> Op. 23' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:4ef583a9-e81e-4fcd-ab7b-523e3dba6d8d'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:4657b292-dce8-449d-93ba-b80f467ad0b2', 14, NULL, 'Acte I. Deuxième tableau : « Oui, oui cette somme était due » (Chœur, Cellini, Francesco, Bernardino, Ascanio, Cabaretier)', 'Benvenuto Cellini : Acte I. Deuxième tableau : « Oui, oui cette somme était due » (Chœur, Cellini, Francesco, Bernardino, Ascanio, Cabaretier)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:066c6ce2-ecc1-4e29-8dd3-4d2d1a8e7923'
WHERE p.composer_id = 37 AND p.title = '오페라 <Benvenuto Cellini> Op. 23' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:4657b292-dce8-449d-93ba-b80f467ad0b2'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:a4539568-6425-4543-a8a1-7d68ab7d98cd', 15, NULL, 'Acte I. Deuxième tableau : No. 9. Récitatif « C’est trop fort ! » (Fieramosca, Pompeo)', 'Benvenuto Cellini : Acte I. Deuxième tableau : No. 9. Récitatif « C’est trop fort ! » (Fieramosca, Pompeo)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:066c6ce2-ecc1-4e29-8dd3-4d2d1a8e7923'
WHERE p.composer_id = 37 AND p.title = '오페라 <Benvenuto Cellini> Op. 23' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:a4539568-6425-4543-a8a1-7d68ab7d98cd'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:e5ab68a8-b727-4573-b86a-83080985a95b', 16, NULL, 'Acte I. Deuxième tableau : No. 10. Air « Ah ! Qui pourrait me résister ? » / No. 11. Récitatif « Viens, le temps passe » (Fieramosca)', 'Benvenuto Cellini : Acte I. Deuxième tableau : No. 10. Air « Ah ! Qui pourrait me résister ? » / No. 11. Récitatif « Viens, le temps passe » (Fieramosca)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:066c6ce2-ecc1-4e29-8dd3-4d2d1a8e7923'
WHERE p.composer_id = 37 AND p.title = '오페라 <Benvenuto Cellini> Op. 23' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:e5ab68a8-b727-4573-b86a-83080985a95b'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:4ae006d2-3a51-49ab-b342-9caed19a7d84', 17, NULL, 'Acte I. Deuxième tableau : Finale. Le Carnaval', 'Benvenuto Cellini : Acte I. Deuxième tableau : Finale. Le Carnaval', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:066c6ce2-ecc1-4e29-8dd3-4d2d1a8e7923'
WHERE p.composer_id = 37 AND p.title = '오페라 <Benvenuto Cellini> Op. 23' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:4ae006d2-3a51-49ab-b342-9caed19a7d84'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:adadcc1e-4d5e-4b38-9ca2-5a76aa423e81', 18, NULL, 'Acte I. Deuxième tableau : No. 12. Final « Vous voyez, j’espère » (Balducci, Teresa, Cellini, Ascanio, Chœur)', 'Benvenuto Cellini : Acte I. Deuxième tableau : No. 12. Final « Vous voyez, j’espère » (Balducci, Teresa, Cellini, Ascanio, Chœur)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:066c6ce2-ecc1-4e29-8dd3-4d2d1a8e7923'
WHERE p.composer_id = 37 AND p.title = '오페라 <Benvenuto Cellini> Op. 23' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:adadcc1e-4d5e-4b38-9ca2-5a76aa423e81'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:ba7f7328-fb30-454d-85dd-b4ec4c5dd931', 19, NULL, 'Acte I. Deuxième tableau : « Venez, venez, peuple de Rome » (Balducci, Fieramosca, Teresa, Cellini, Ascanio, Chœur)', 'Benvenuto Cellini : Acte I. Deuxième tableau : « Venez, venez, peuple de Rome » (Balducci, Fieramosca, Teresa, Cellini, Ascanio, Chœur)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:066c6ce2-ecc1-4e29-8dd3-4d2d1a8e7923'
WHERE p.composer_id = 37 AND p.title = '오페라 <Benvenuto Cellini> Op. 23' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:ba7f7328-fb30-454d-85dd-b4ec4c5dd931'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:b1a878a4-96f5-4360-9bb1-b536c0d115c0', 20, NULL, 'Acte I. Deuxième tableau : Entrée d’Arléquin (Chœur)', 'Benvenuto Cellini : Acte I. Deuxième tableau : Entrée d’Arléquin (Chœur)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:066c6ce2-ecc1-4e29-8dd3-4d2d1a8e7923'
WHERE p.composer_id = 37 AND p.title = '오페라 <Benvenuto Cellini> Op. 23' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:b1a878a4-96f5-4360-9bb1-b536c0d115c0'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:7cde9c6d-4510-4454-a654-ebfa76140c1f', 21, NULL, 'Acte I. Deuxième tableau : Ariette de Pasquarello', 'Benvenuto Cellini : Acte I. Deuxième tableau : Ariette de Pasquarello', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:066c6ce2-ecc1-4e29-8dd3-4d2d1a8e7923'
WHERE p.composer_id = 37 AND p.title = '오페라 <Benvenuto Cellini> Op. 23' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:7cde9c6d-4510-4454-a654-ebfa76140c1f'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:bd97889e-6d8d-4cf6-a55b-8041bb6bd65f', 22, NULL, 'Acte I. Deuxième tableau : Cavatine de Pierrot « Il plaît fort » (Balducci, Chœur)', 'Benvenuto Cellini : Acte I. Deuxième tableau : Cavatine de Pierrot « Il plaît fort » (Balducci, Chœur)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:066c6ce2-ecc1-4e29-8dd3-4d2d1a8e7923'
WHERE p.composer_id = 37 AND p.title = '오페라 <Benvenuto Cellini> Op. 23' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:bd97889e-6d8d-4cf6-a55b-8041bb6bd65f'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:0b567fb6-1f98-459d-a833-7de9e2b85362', 23, NULL, 'Acte I. Deuxième tableau : « Soyez surpris » … « Viens pas à pas » … « Assassiner un capucin » (Teresa, Cellini, Francesco, Pompeo, Bernardino, Balducci, Ascanio, Fieramosca, Chœur)', 'Benvenuto Cellini : Acte I. Deuxième tableau : « Soyez surpris » … « Viens pas à pas » … « Assassiner un capucin » (Teresa, Cellini, Francesco, Pompeo, Bernardino, Balducci, Ascanio, Fieramosca, Chœur)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:066c6ce2-ecc1-4e29-8dd3-4d2d1a8e7923'
WHERE p.composer_id = 37 AND p.title = '오페라 <Benvenuto Cellini> Op. 23' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:0b567fb6-1f98-459d-a833-7de9e2b85362'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:6db3fd08-03e2-4d5b-a801-7cfaa866add0', 24, NULL, 'Acte I. Deuxième tableau : « Ah ! Cher canon du fort » (Teresa, Cellini, Francesco, Pompeo, Bernardino, Balducci, Ascanio, Fieramosca, Chœur)', 'Benvenuto Cellini : Acte I. Deuxième tableau : « Ah ! Cher canon du fort » (Teresa, Cellini, Francesco, Pompeo, Bernardino, Balducci, Ascanio, Fieramosca, Chœur)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:066c6ce2-ecc1-4e29-8dd3-4d2d1a8e7923'
WHERE p.composer_id = 37 AND p.title = '오페라 <Benvenuto Cellini> Op. 23' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:6db3fd08-03e2-4d5b-a801-7cfaa866add0'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:7e76693f-ce9c-4373-bbca-131f6263a8f9', 3, NULL, 'Acte II', 'Benvenuto Cellini, op. 23 : Acte II', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 37 AND p.title = '오페라 <Benvenuto Cellini> Op. 23' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:7e76693f-ce9c-4373-bbca-131f6263a8f9'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:9fda6b61-b235-49eb-ba9a-9d436956d7f3', 1, NULL, 'Acte II. Troisième tableau : No. 13. Entr’acte', 'Benvenuto Cellini : Acte II. Troisième tableau : No. 13. Entr’acte', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:7e76693f-ce9c-4373-bbca-131f6263a8f9'
WHERE p.composer_id = 37 AND p.title = '오페라 <Benvenuto Cellini> Op. 23' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:9fda6b61-b235-49eb-ba9a-9d436956d7f3'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:4a5bd348-59d5-4515-966e-b9c2bd4d2ae0', 2, NULL, 'Acte II. Troisième tableau : No. 14. « Ah ! qu’est il devenu » … « Rosa purpurea » (Teresa, Ascanio, Cellini, Chœur)', 'Benvenuto Cellini : Acte II. Troisième tableau : No. 14. « Ah ! qu’est il devenu » … « Rosa purpurea » (Teresa, Ascanio, Cellini, Chœur)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:7e76693f-ce9c-4373-bbca-131f6263a8f9'
WHERE p.composer_id = 37 AND p.title = '오페라 <Benvenuto Cellini> Op. 23' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:4a5bd348-59d5-4515-966e-b9c2bd4d2ae0'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:53376c73-607b-4603-85b8-52b8f40edc2c', 3, NULL, 'Acte II. Troisième tableau : No. 15. Récit « Ma dague en main, protégé par la nuit » / No. 16. Duo « Ah ! le ciel, cher époux » (Cellini, Teresa, Ascanio)', 'Benvenuto Cellini : Acte II. Troisième tableau : No. 15. Récit « Ma dague en main, protégé par la nuit » / No. 16. Duo « Ah ! le ciel, cher époux » (Cellini, Teresa, Ascanio)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:7e76693f-ce9c-4373-bbca-131f6263a8f9'
WHERE p.composer_id = 37 AND p.title = '오페라 <Benvenuto Cellini> Op. 23' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:53376c73-607b-4603-85b8-52b8f40edc2c'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:f92ac0b5-aa08-4b30-ab05-5273c9cd0a40', 4, NULL, 'Acte II. Troisième tableau : No. 17. Récit « Ah ! maître !… mon cher maître ! » / No. 18. Quintette « Ah ! je te trouve enfin » (Balducci, Teresa, Cellini, Ascanio, Fieramosca)', 'Benvenuto Cellini : Acte II. Troisième tableau : No. 17. Récit « Ah ! maître !… mon cher maître ! » / No. 18. Quintette « Ah ! je te trouve enfin » (Balducci, Teresa, Cellini, Ascanio, Fieramosca)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:7e76693f-ce9c-4373-bbca-131f6263a8f9'
WHERE p.composer_id = 37 AND p.title = '오페라 <Benvenuto Cellini> Op. 23' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:f92ac0b5-aa08-4b30-ab05-5273c9cd0a40'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:935c4846-cb35-4eb6-b01f-4586b3f0eb5d', 5, NULL, 'Acte II. Troisième tableau : No. 19. Sextuor « Le Pape ici ! de la prudence » (Le Pape, Cellini, Teresa, Ascanio, Fieramosca, Balducci)', 'Benvenuto Cellini : Acte II. Troisième tableau : No. 19. Sextuor « Le Pape ici ! de la prudence » (Le Pape, Cellini, Teresa, Ascanio, Fieramosca, Balducci)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:7e76693f-ce9c-4373-bbca-131f6263a8f9'
WHERE p.composer_id = 37 AND p.title = '오페라 <Benvenuto Cellini> Op. 23' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:935c4846-cb35-4eb6-b01f-4586b3f0eb5d'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:47d89534-c795-4380-a2eb-d363eb63f5f6', 6, NULL, 'Acte II. Troisième tableau : No. 20. Final « Ah ! maintenant de sa folle impudence » (Le Pape, Cellini, Teresa, Ascanio, Fieramosca, Balducci, Chœur)', 'Benvenuto Cellini : Acte II. Troisième tableau : No. 20. Final « Ah ! maintenant de sa folle impudence » (Le Pape, Cellini, Teresa, Ascanio, Fieramosca, Balducci, Chœur)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:7e76693f-ce9c-4373-bbca-131f6263a8f9'
WHERE p.composer_id = 37 AND p.title = '오페라 <Benvenuto Cellini> Op. 23' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:47d89534-c795-4380-a2eb-d363eb63f5f6'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:8fe106a0-e00a-4c2c-a803-5e2e1f4e8e57', 7, NULL, 'Acte II. Quatrième tableau : No. 21. Prélude', 'Benvenuto Cellini : Acte II. Quatrième tableau : No. 21. Prélude', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:7e76693f-ce9c-4373-bbca-131f6263a8f9'
WHERE p.composer_id = 37 AND p.title = '오페라 <Benvenuto Cellini> Op. 23' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:8fe106a0-e00a-4c2c-a803-5e2e1f4e8e57'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:397a9edf-a394-49d7-a866-09e98d2da7db', 8, NULL, 'Acte II. Quatrième tableau : No. 22. Air « Tra la la la. Mais, qu’ai‐je donc ? » (Ascanio)', 'Benvenuto Cellini : Acte II. Quatrième tableau : No. 22. Air « Tra la la la. Mais, qu’ai‐je donc ? » (Ascanio)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:7e76693f-ce9c-4373-bbca-131f6263a8f9'
WHERE p.composer_id = 37 AND p.title = '오페라 <Benvenuto Cellini> Op. 23' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:397a9edf-a394-49d7-a866-09e98d2da7db'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:bc7dcb2e-109e-45a9-902e-d1ae4b1b7aff', 9, NULL, 'Acte II. Quatrième tableau : No. 23. Récit et air « Seul pour lutter » … « Sur les monts les plus sauvages » (Cellini)', 'Benvenuto Cellini : Acte II. Quatrième tableau : No. 23. Récit et air « Seul pour lutter » … « Sur les monts les plus sauvages » (Cellini)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:7e76693f-ce9c-4373-bbca-131f6263a8f9'
WHERE p.composer_id = 37 AND p.title = '오페라 <Benvenuto Cellini> Op. 23' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:bc7dcb2e-109e-45a9-902e-d1ae4b1b7aff'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:0e3b0151-77a7-4e86-9f66-0e4b811e3aed', 10, NULL, 'Acte II. Quatrième tableau : No. 24. Chœur « Bienheureux les matelots » (Cellini, Ascanio, Chœur)', 'Benvenuto Cellini : Acte II. Quatrième tableau : No. 24. Chœur « Bienheureux les matelots » (Cellini, Ascanio, Chœur)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:7e76693f-ce9c-4373-bbca-131f6263a8f9'
WHERE p.composer_id = 37 AND p.title = '오페라 <Benvenuto Cellini> Op. 23' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:0e3b0151-77a7-4e86-9f66-0e4b811e3aed'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:9e124fd8-474b-4746-baf8-105fa66d26fe', 11, NULL, 'Acte II. Quatrième tableau : No. 25. Scène « Vite, au travail, sans plus attendre! » / « Fieramosca ! » (Cellini, Ascanio, Fieramosca, Teresa, Chœur)', 'Benvenuto Cellini : Acte II. Quatrième tableau : No. 25. Scène « Vite, au travail, sans plus attendre! » / « Fieramosca ! » (Cellini, Ascanio, Fieramosca, Teresa, Chœur)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:7e76693f-ce9c-4373-bbca-131f6263a8f9'
WHERE p.composer_id = 37 AND p.title = '오페라 <Benvenuto Cellini> Op. 23' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:9e124fd8-474b-4746-baf8-105fa66d26fe'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:18118aec-8102-4430-a854-2dbc563ebcf5', 12, NULL, 'Acte II. Quatrième tableau : No. 26. Chœur « Peuple ouvrier » (Teresa, Francesco, Bernardino, Chœur)', 'Benvenuto Cellini : Acte II. Quatrième tableau : No. 26. Chœur « Peuple ouvrier » (Teresa, Francesco, Bernardino, Chœur)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:7e76693f-ce9c-4373-bbca-131f6263a8f9'
WHERE p.composer_id = 37 AND p.title = '오페라 <Benvenuto Cellini> Op. 23' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:18118aec-8102-4430-a854-2dbc563ebcf5'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:aa493770-a6c1-43b9-b500-9e75eb704176', 13, NULL, 'Acte II. Quatrième tableau : No. 27. Scène et chœur « Ciel, c''est Fieramosca ! Ah ! ciel ! il est mort ! » (Teresa, Fieramosca, Bernardino, Cellini, Chœur)', 'Benvenuto Cellini : Acte II. Quatrième tableau : No. 27. Scène et chœur « Ciel, c''est Fieramosca ! Ah ! ciel ! il est mort ! » (Teresa, Fieramosca, Bernardino, Cellini, Chœur)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:7e76693f-ce9c-4373-bbca-131f6263a8f9'
WHERE p.composer_id = 37 AND p.title = '오페라 <Benvenuto Cellini> Op. 23' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:aa493770-a6c1-43b9-b500-9e75eb704176'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:54c266b5-45c1-40d4-a4cc-e09274109d90', 14, NULL, 'Acte II. Quatrième tableau : No. 28. Chœur « Couvrez-moi ce drôle » … « À l’atelier ! » / No. 29. Récitatif « Ah ! le calme renaît » (Fieramosca, Ascanio, Francesco, Bernardino, Teresa, Cellini, Chœur)', 'Benvenuto Cellini : Acte II. Quatrième tableau : No. 28. Chœur « Couvrez-moi ce drôle » … « À l’atelier ! » / No. 29. Récitatif « Ah ! le calme renaît » (Fieramosca, Ascanio, Francesco, Bernardino, Teresa, Cellini, Chœur)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:7e76693f-ce9c-4373-bbca-131f6263a8f9'
WHERE p.composer_id = 37 AND p.title = '오페라 <Benvenuto Cellini> Op. 23' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:54c266b5-45c1-40d4-a4cc-e09274109d90'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:ab99baa9-941b-495c-8c6b-b78395429f41', 15, NULL, 'Acte II. Quatrième tableau : No. 30. Scène « Teresa ! Teresa ici ! » (Balducci, Le Pape, Cellini, Fieramosca, Teresa, Ascanio, Francesco, Bernardino)', 'Benvenuto Cellini : Acte II. Quatrième tableau : No. 30. Scène « Teresa ! Teresa ici ! » (Balducci, Le Pape, Cellini, Fieramosca, Teresa, Ascanio, Francesco, Bernardino)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:7e76693f-ce9c-4373-bbca-131f6263a8f9'
WHERE p.composer_id = 37 AND p.title = '오페라 <Benvenuto Cellini> Op. 23' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:ab99baa9-941b-495c-8c6b-b78395429f41'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:d4802e4e-3359-498a-923f-7c7f383e37e8', 16, NULL, 'Acte II. Quatrième tableau : No. 31. Final « Du métal ! Il nous faut du métal ! » (Francesco, Cellini, Balducci, Fieramosca, Le Pape, Bernardino, Teresa, Ascanio, Chœur)', 'Benvenuto Cellini : Acte II. Quatrième tableau : No. 31. Final « Du métal ! Il nous faut du métal ! » (Francesco, Cellini, Balducci, Fieramosca, Le Pape, Bernardino, Teresa, Ascanio, Chœur)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:7e76693f-ce9c-4373-bbca-131f6263a8f9'
WHERE p.composer_id = 37 AND p.title = '오페라 <Benvenuto Cellini> Op. 23' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:d4802e4e-3359-498a-923f-7c7f383e37e8'
);


-- None 가곡 <La Belle Isabeau>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '가곡 <La Belle Isabeau>', 'La Belle Isabeau', 'song', NULL, NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 37
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '가곡 <La Belle Isabeau>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '456eaeaa-4dc0-44a6-a03e-f3b39014ceca'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '456eaeaa-4dc0-44a6-a03e-f3b39014ceca'
FROM pieces p
WHERE p.composer_id = 37 AND p.title = '가곡 <La Belle Isabeau>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '456eaeaa-4dc0-44a6-a03e-f3b39014ceca'
);


-- 카탈로그에 대응이 없는 seed 작품 42개를 목록에서 숨긴다(지우지 않음).
UPDATE pieces piece
SET piece.hidden_reason = 'catalog_unmatched'
WHERE piece.composer_id = 37 AND piece.origin = 'seed' AND piece.hidden_reason IS NULL
  AND piece.id IN (
    475, 533, 553, 609, 837, 841, 935, 1061, 1171, 1212, 1221, 1259, 1275, 1309, 1346, 1425, 1460, 1462, 1554, 1596,
    1677, 1709, 1830, 1932, 1954, 2066, 2109, 2256, 2295, 2329, 2349, 2356, 2449, 2470, 2563, 2612, 2624, 2690, 2693, 2958,
    3007, 3010
  )
  AND NOT EXISTS (SELECT 1 FROM performance_sectors sector WHERE sector.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM piece_parts linking WHERE linking.linked_piece_id = piece.id);
