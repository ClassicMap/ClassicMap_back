-- 메시앙 작품을 MusicBrainz 작품 구조로 다시 짠다(4차 자동). 작품 71개(묶음 9, 다악장 20, 낱곡 42),
-- 새 작품 5개, part 224개, 그 아래 1개.
-- seed 73개 중 66개를 작품·part 에 잇고, 4개를 숨기고, 3개는 그대로 둔다.
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

-- None Adagio

UPDATE pieces piece
SET piece.title = 'Adagio', piece.title_en = 'Adagio',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 2178 AND piece.composer_id = 95
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Apparition de l’Église Éternelle

UPDATE pieces piece
SET piece.title = 'Apparition de l’Église Éternelle', piece.title_en = 'Apparition de l’Église Éternelle',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 775 AND piece.composer_id = 95
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Cantéyodjayâ

UPDATE pieces piece
SET piece.title = 'Cantéyodjayâ', piece.title_en = 'Cantéyodjayâ',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 639 AND piece.composer_id = 95
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Catalogue d’oiseaux, I/42

UPDATE pieces piece
SET piece.title = 'Catalogue d’oiseaux, I/42', piece.title_en = 'Catalogue d’oiseaux, I/42',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 683 AND piece.composer_id = 95
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'Le Chocard des Alpes', part.name_en = 'Catalogue d’oiseaux, Book I, I/42: I. Le Chocard des Alpes',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 683 AND p.composer_id = 95 AND part.part_key = 'musicbrainz:0db60ba2-16d5-3c20-b158-6bd6a3a1655d' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:0db60ba2-16d5-3c20-b158-6bd6a3a1655d', 1, 'I', 'Le Chocard des Alpes', 'Catalogue d’oiseaux, Book I, I/42: I. Le Chocard des Alpes', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 683 AND p.composer_id = 95
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:0db60ba2-16d5-3c20-b158-6bd6a3a1655d'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'Le Loriot', part.name_en = 'Catalogue d’oiseaux, Book I, I/42: II. Le Loriot',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 683 AND p.composer_id = 95 AND part.part_key = 'musicbrainz:88255507-71d5-3f42-bb4c-b844d6da7971' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:88255507-71d5-3f42-bb4c-b844d6da7971', 2, 'II', 'Le Loriot', 'Catalogue d’oiseaux, Book I, I/42: II. Le Loriot', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 683 AND p.composer_id = 95
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:88255507-71d5-3f42-bb4c-b844d6da7971'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = 'Le Merle bleu', part.name_en = 'Catalogue d’oiseaux, Book I, I/42: III. Le Merle bleu',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 683 AND p.composer_id = 95 AND part.part_key = 'musicbrainz:17780ebb-5e03-3777-88e9-e4e41fcc8275' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:17780ebb-5e03-3777-88e9-e4e41fcc8275', 3, 'III', 'Le Merle bleu', 'Catalogue d’oiseaux, Book I, I/42: III. Le Merle bleu', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 683 AND p.composer_id = 95
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:17780ebb-5e03-3777-88e9-e4e41fcc8275'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = 'IV',
    part.name_ko = 'Le Traquet stapazin', part.name_en = 'Catalogue d’oiseaux, Book II, I/42: IV. Le Traquet stapazin',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 683 AND p.composer_id = 95 AND part.part_key = 'musicbrainz:4739da92-a94e-3a57-aeda-4d9f485c93aa' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:4739da92-a94e-3a57-aeda-4d9f485c93aa', 4, 'IV', 'Le Traquet stapazin', 'Catalogue d’oiseaux, Book II, I/42: IV. Le Traquet stapazin', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 683 AND p.composer_id = 95
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:4739da92-a94e-3a57-aeda-4d9f485c93aa'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 5, part.movement_number = 'V',
    part.name_ko = 'La Chouette hulotte', part.name_en = 'Catalogue d’oiseaux, Book III, I/42: V. La Chouette hulotte',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 683 AND p.composer_id = 95 AND part.part_key = 'musicbrainz:98b6e4e4-4b7d-33b0-baad-04096a729df4' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:98b6e4e4-4b7d-33b0-baad-04096a729df4', 5, 'V', 'La Chouette hulotte', 'Catalogue d’oiseaux, Book III, I/42: V. La Chouette hulotte', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 683 AND p.composer_id = 95
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:98b6e4e4-4b7d-33b0-baad-04096a729df4'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 6, part.movement_number = 'VI',
    part.name_ko = 'L’Alouette-lulu', part.name_en = 'Catalogue d’oiseaux, Book III, I/42: VI. L’Alouette-lulu',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 683 AND p.composer_id = 95 AND part.part_key = 'musicbrainz:466a65de-7b96-3db1-b22b-cf32bff0743b' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:466a65de-7b96-3db1-b22b-cf32bff0743b', 6, 'VI', 'L’Alouette-lulu', 'Catalogue d’oiseaux, Book III, I/42: VI. L’Alouette-lulu', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 683 AND p.composer_id = 95
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:466a65de-7b96-3db1-b22b-cf32bff0743b'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 7, part.movement_number = 'VII',
    part.name_ko = 'Le Rousserolle effarvatte', part.name_en = 'Catalogue d’oiseaux, Book IV, I/42: VII. Le Rousserolle effarvatte',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 683 AND p.composer_id = 95 AND part.part_key = 'musicbrainz:e62911a6-8a1c-3b04-8b2d-fa82c2b67a35' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:e62911a6-8a1c-3b04-8b2d-fa82c2b67a35', 7, 'VII', 'Le Rousserolle effarvatte', 'Catalogue d’oiseaux, Book IV, I/42: VII. Le Rousserolle effarvatte', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 683 AND p.composer_id = 95
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:e62911a6-8a1c-3b04-8b2d-fa82c2b67a35'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 8, part.movement_number = 'VIII',
    part.name_ko = 'L’Alouette calandrelle', part.name_en = 'Catalogue d’oiseaux, Book V, I/42: VIII. L’Alouette calandrelle',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 683 AND p.composer_id = 95 AND part.part_key = 'musicbrainz:41807b4e-921e-328f-8254-04a96c37b8d0' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:41807b4e-921e-328f-8254-04a96c37b8d0', 8, 'VIII', 'L’Alouette calandrelle', 'Catalogue d’oiseaux, Book V, I/42: VIII. L’Alouette calandrelle', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 683 AND p.composer_id = 95
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:41807b4e-921e-328f-8254-04a96c37b8d0'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 9, part.movement_number = 'IX',
    part.name_ko = 'La Bouscarle', part.name_en = 'Catalogue d’oiseaux, Book V, I/42: IX. La Bouscarle',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 683 AND p.composer_id = 95 AND part.part_key = 'musicbrainz:e2adc11a-3911-30a1-9564-d3cb93db42e9' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:e2adc11a-3911-30a1-9564-d3cb93db42e9', 9, 'IX', 'La Bouscarle', 'Catalogue d’oiseaux, Book V, I/42: IX. La Bouscarle', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 683 AND p.composer_id = 95
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:e2adc11a-3911-30a1-9564-d3cb93db42e9'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 10, part.movement_number = 'X',
    part.name_ko = 'Le Merle de roche', part.name_en = 'Catalogue d’oiseaux, Book VI, I/42: X. Le Merle de roche',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 683 AND p.composer_id = 95 AND part.part_key = 'musicbrainz:2d0aaee8-f650-3cea-915a-8397de79197f' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:2d0aaee8-f650-3cea-915a-8397de79197f', 10, 'X', 'Le Merle de roche', 'Catalogue d’oiseaux, Book VI, I/42: X. Le Merle de roche', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 683 AND p.composer_id = 95
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:2d0aaee8-f650-3cea-915a-8397de79197f'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 11, part.movement_number = 'XI',
    part.name_ko = 'La Buse variable', part.name_en = 'Catalogue d’oiseaux, Book VII, I/42: XI. La Buse variable',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 683 AND p.composer_id = 95 AND part.part_key = 'musicbrainz:ec59d8cd-0ed6-38fd-8624-362b35d07cef' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:ec59d8cd-0ed6-38fd-8624-362b35d07cef', 11, 'XI', 'La Buse variable', 'Catalogue d’oiseaux, Book VII, I/42: XI. La Buse variable', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 683 AND p.composer_id = 95
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:ec59d8cd-0ed6-38fd-8624-362b35d07cef'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 12, part.movement_number = 'XII',
    part.name_ko = 'La Traquet rieur', part.name_en = 'Catalogue d’oiseaux, Book VII, I/42: XII. La Traquet rieur',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 683 AND p.composer_id = 95 AND part.part_key = 'musicbrainz:45ed01fa-66dd-315d-89ab-b14c0b27eeb6' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:45ed01fa-66dd-315d-89ab-b14c0b27eeb6', 12, 'XII', 'La Traquet rieur', 'Catalogue d’oiseaux, Book VII, I/42: XII. La Traquet rieur', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 683 AND p.composer_id = 95
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:45ed01fa-66dd-315d-89ab-b14c0b27eeb6'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 13, part.movement_number = 'XIII',
    part.name_ko = 'Le Courlis cendré', part.name_en = 'Catalogue d’oiseaux, Book VII, I/42: XIII. Le Courlis cendré',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 683 AND p.composer_id = 95 AND part.part_key = 'musicbrainz:31125a48-ee75-31a1-b328-d080fcb2dc1d' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:31125a48-ee75-31a1-b328-d080fcb2dc1d', 13, 'XIII', 'Le Courlis cendré', 'Catalogue d’oiseaux, Book VII, I/42: XIII. Le Courlis cendré', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 683 AND p.composer_id = 95
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:31125a48-ee75-31a1-b328-d080fcb2dc1d'
);


-- None Chant dans le style de Mozart

UPDATE pieces piece
SET piece.title = 'Chant dans le style de Mozart', piece.title_en = 'Chant dans le style de Mozart',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 719 AND piece.composer_id = 95
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Chant des déportés

UPDATE pieces piece
SET piece.title = 'Chant des déportés', piece.title_en = 'Chant des déportés',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 717 AND piece.composer_id = 95
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None 연가곡집 <Chants de Terre et de Ciel, I/19>

UPDATE pieces piece
SET piece.title = '연가곡집 <Chants de Terre et de Ciel, I/19>', piece.title_en = 'Chants de Terre et de Ciel, I/19',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 684 AND piece.composer_id = 95
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'Bail avec Mi (Pour ma femme)', part.name_en = 'Chants de Terre et de Ciel: I. Bail avec Mi (Pour ma femme)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 684 AND p.composer_id = 95 AND part.part_key = 'musicbrainz:503ba4e8-b7f6-41e4-92c0-0495bebcf796' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:503ba4e8-b7f6-41e4-92c0-0495bebcf796', 1, 'I', 'Bail avec Mi (Pour ma femme)', 'Chants de Terre et de Ciel: I. Bail avec Mi (Pour ma femme)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 684 AND p.composer_id = 95
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:503ba4e8-b7f6-41e4-92c0-0495bebcf796'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'Antienne du silence (Pour le jour des anges gardiens)', part.name_en = 'Chants de Terre et de Ciel: II. Antienne du silence (Pour le jour des anges gardiens)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 684 AND p.composer_id = 95 AND part.part_key = 'musicbrainz:2f5719e3-45f8-4294-bd0e-d5ccc820b2d4' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:2f5719e3-45f8-4294-bd0e-d5ccc820b2d4', 2, 'II', 'Antienne du silence (Pour le jour des anges gardiens)', 'Chants de Terre et de Ciel: II. Antienne du silence (Pour le jour des anges gardiens)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 684 AND p.composer_id = 95
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:2f5719e3-45f8-4294-bd0e-d5ccc820b2d4'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = 'Danse du Bébé-pilule (Pour mon petit Pascal)', part.name_en = 'Chants de Terre et de Ciel: III. Danse du Bébé-pilule (Pour mon petit Pascal)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 684 AND p.composer_id = 95 AND part.part_key = 'musicbrainz:d3a50117-8b7e-4b26-8330-6451b85ee72b' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:d3a50117-8b7e-4b26-8330-6451b85ee72b', 3, 'III', 'Danse du Bébé-pilule (Pour mon petit Pascal)', 'Chants de Terre et de Ciel: III. Danse du Bébé-pilule (Pour mon petit Pascal)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 684 AND p.composer_id = 95
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:d3a50117-8b7e-4b26-8330-6451b85ee72b'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = 'IV',
    part.name_ko = 'Arc-en-ciel d''innocence (Pour mon petit Pascal)', part.name_en = 'Chants de Terre et de Ciel: IV. Arc-en-ciel d''innocence (Pour mon petit Pascal)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 684 AND p.composer_id = 95 AND part.part_key = 'musicbrainz:377cf0fb-d79c-47fc-9267-a7baa8c4e78d' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:377cf0fb-d79c-47fc-9267-a7baa8c4e78d', 4, 'IV', 'Arc-en-ciel d''innocence (Pour mon petit Pascal)', 'Chants de Terre et de Ciel: IV. Arc-en-ciel d''innocence (Pour mon petit Pascal)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 684 AND p.composer_id = 95
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:377cf0fb-d79c-47fc-9267-a7baa8c4e78d'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 5, part.movement_number = 'V',
    part.name_ko = 'Minuit pile et face (Pour la mort)', part.name_en = 'Chants de Terre et de Ciel: V. Minuit pile et face (Pour la mort)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 684 AND p.composer_id = 95 AND part.part_key = 'musicbrainz:9e2d8a25-e88e-4561-82b3-ca1b61f956ec' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:9e2d8a25-e88e-4561-82b3-ca1b61f956ec', 5, 'V', 'Minuit pile et face (Pour la mort)', 'Chants de Terre et de Ciel: V. Minuit pile et face (Pour la mort)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 684 AND p.composer_id = 95
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:9e2d8a25-e88e-4561-82b3-ca1b61f956ec'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 6, part.movement_number = 'VI',
    part.name_ko = 'Résurrection (Pour le jour de Pâques)', part.name_en = 'Chants de Terre et de Ciel: VI. Résurrection (Pour le jour de Pâques)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 684 AND p.composer_id = 95 AND part.part_key = 'musicbrainz:57603e7a-341f-4dff-8384-928164812abf' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:57603e7a-341f-4dff-8384-928164812abf', 6, 'VI', 'Résurrection (Pour le jour de Pâques)', 'Chants de Terre et de Ciel: VI. Résurrection (Pour le jour de Pâques)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 684 AND p.composer_id = 95
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:57603e7a-341f-4dff-8384-928164812abf'
);


-- None Chronochromie, I/43

UPDATE pieces piece
SET piece.title = 'Chronochromie, I/43', piece.title_en = 'Chronochromie, I/43',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 776 AND piece.composer_id = 95
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'Introduction', part.name_en = 'Chronochromie, I/43: Introduction',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 776 AND p.composer_id = 95 AND part.part_key = 'musicbrainz:e88e7d00-8486-4686-b3e3-52c6cbef6fe8' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:e88e7d00-8486-4686-b3e3-52c6cbef6fe8', 1, NULL, 'Introduction', 'Chronochromie, I/43: Introduction', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 776 AND p.composer_id = 95
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:e88e7d00-8486-4686-b3e3-52c6cbef6fe8'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'Strophe I', part.name_en = 'Chronochromie, I/43: Strophe I',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 776 AND p.composer_id = 95 AND part.part_key = 'musicbrainz:5d628a6f-7702-405a-b9e3-779eb0cab868' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:5d628a6f-7702-405a-b9e3-779eb0cab868', 2, NULL, 'Strophe I', 'Chronochromie, I/43: Strophe I', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 776 AND p.composer_id = 95
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:5d628a6f-7702-405a-b9e3-779eb0cab868'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = NULL,
    part.name_ko = 'Antistrophe I', part.name_en = 'Chronochromie, I/43: Antistrophe I',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 776 AND p.composer_id = 95 AND part.part_key = 'musicbrainz:408d6bd3-a023-4f57-9150-972208dfdce5' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:408d6bd3-a023-4f57-9150-972208dfdce5', 3, NULL, 'Antistrophe I', 'Chronochromie, I/43: Antistrophe I', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 776 AND p.composer_id = 95
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:408d6bd3-a023-4f57-9150-972208dfdce5'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = NULL,
    part.name_ko = 'Strophe II', part.name_en = 'Chronochromie, I/43: Strophe II',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 776 AND p.composer_id = 95 AND part.part_key = 'musicbrainz:9e50ebaa-90f9-439d-801b-98a4be195506' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:9e50ebaa-90f9-439d-801b-98a4be195506', 4, NULL, 'Strophe II', 'Chronochromie, I/43: Strophe II', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 776 AND p.composer_id = 95
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:9e50ebaa-90f9-439d-801b-98a4be195506'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 5, part.movement_number = NULL,
    part.name_ko = 'Antistrophe II', part.name_en = 'Chronochromie, I/43: Antistrophe II',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 776 AND p.composer_id = 95 AND part.part_key = 'musicbrainz:74991584-22be-4be8-ba91-67d5972a413a' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:74991584-22be-4be8-ba91-67d5972a413a', 5, NULL, 'Antistrophe II', 'Chronochromie, I/43: Antistrophe II', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 776 AND p.composer_id = 95
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:74991584-22be-4be8-ba91-67d5972a413a'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 6, part.movement_number = NULL,
    part.name_ko = 'Epode', part.name_en = 'Chronochromie, I/43: Epode',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 776 AND p.composer_id = 95 AND part.part_key = 'musicbrainz:fa3c42df-d905-4eb7-9bb1-952b5596de76' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:fa3c42df-d905-4eb7-9bb1-952b5596de76', 6, NULL, 'Epode', 'Chronochromie, I/43: Epode', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 776 AND p.composer_id = 95
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:fa3c42df-d905-4eb7-9bb1-952b5596de76'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 7, part.movement_number = NULL,
    part.name_ko = 'Coda', part.name_en = 'Chronochromie, I/43: Coda',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 776 AND p.composer_id = 95 AND part.part_key = 'musicbrainz:acb5ec4e-d37c-4c60-b48b-79dd7f03a88e' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:acb5ec4e-d37c-4c60-b48b-79dd7f03a88e', 7, NULL, 'Coda', 'Chronochromie, I/43: Coda', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 776 AND p.composer_id = 95
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:acb5ec4e-d37c-4c60-b48b-79dd7f03a88e'
);


-- None Cinq rechants

UPDATE pieces piece
SET piece.title = 'Cinq rechants', piece.title_en = 'Cinq rechants',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 685 AND piece.composer_id = 95
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'Hayo kapritama la li la li la li la ssaréno', part.name_en = 'Cinq rechants: I. Hayo kapritama la li la li la li la ssaréno',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 685 AND p.composer_id = 95 AND part.part_key = 'musicbrainz:83e7163b-118b-4415-8f8c-2878fad11234' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:83e7163b-118b-4415-8f8c-2878fad11234', 1, 'I', 'Hayo kapritama la li la li la li la ssaréno', 'Cinq rechants: I. Hayo kapritama la li la li la li la ssaréno', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 685 AND p.composer_id = 95
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:83e7163b-118b-4415-8f8c-2878fad11234'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'Ma première fois terre terre l''éventail déployé', part.name_en = 'Cinq rechants: II. Ma première fois terre terre l''éventail déployé',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 685 AND p.composer_id = 95 AND part.part_key = 'musicbrainz:a7118313-d6db-46b5-bde3-a6911e4b471b' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:a7118313-d6db-46b5-bde3-a6911e4b471b', 2, 'II', 'Ma première fois terre terre l''éventail déployé', 'Cinq rechants: II. Ma première fois terre terre l''éventail déployé', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 685 AND p.composer_id = 95
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:a7118313-d6db-46b5-bde3-a6911e4b471b'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = 'Ma robe d''amour mon amour ma prison d''amour', part.name_en = 'Cinq rechants: III. Ma robe d''amour mon amour ma prison d''amour',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 685 AND p.composer_id = 95 AND part.part_key = 'musicbrainz:d7cf3732-d58a-424b-810a-630ba7a6c94e' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:d7cf3732-d58a-424b-810a-630ba7a6c94e', 3, 'III', 'Ma robe d''amour mon amour ma prison d''amour', 'Cinq rechants: III. Ma robe d''amour mon amour ma prison d''amour', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 685 AND p.composer_id = 95
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:d7cf3732-d58a-424b-810a-630ba7a6c94e'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = 'IV',
    part.name_ko = 'Niokhamâ palalan(e)sou-kî mon bouquet tout défait rayonne', part.name_en = 'Cinq rechants: IV. Niokhamâ palalan(e)sou-kî mon bouquet tout défait rayonne',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 685 AND p.composer_id = 95 AND part.part_key = 'musicbrainz:ca9f1582-97e3-401c-a243-28c46c13c674' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:ca9f1582-97e3-401c-a243-28c46c13c674', 4, 'IV', 'Niokhamâ palalan(e)sou-kî mon bouquet tout défait rayonne', 'Cinq rechants: IV. Niokhamâ palalan(e)sou-kî mon bouquet tout défait rayonne', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 685 AND p.composer_id = 95
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:ca9f1582-97e3-401c-a243-28c46c13c674'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 5, part.movement_number = 'V',
    part.name_ko = 'Mayoma kalimolimo mayoma kalimolimo', part.name_en = 'Cinq rechants: V. Mayoma kalimolimo mayoma kalimolimo',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 685 AND p.composer_id = 95 AND part.part_key = 'musicbrainz:6f2db58b-4d9b-4257-9bd4-9a0afa1999fb' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:6f2db58b-4d9b-4257-9bd4-9a0afa1999fb', 5, 'V', 'Mayoma kalimolimo mayoma kalimolimo', 'Cinq rechants: V. Mayoma kalimolimo mayoma kalimolimo', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 685 AND p.composer_id = 95
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:6f2db58b-4d9b-4257-9bd4-9a0afa1999fb'
);


-- None Couleurs de la cité céleste, I/46

UPDATE pieces piece
SET piece.title = 'Couleurs de la cité céleste, I/46', piece.title_en = 'Couleurs de la cité céleste, I/46',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 635 AND piece.composer_id = 95
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Des canyons aux étoiles..., I/51

UPDATE pieces piece
SET piece.title = 'Des canyons aux étoiles..., I/51', piece.title_en = 'Des canyons aux étoiles..., I/51',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 707 AND piece.composer_id = 95
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'Le désert', part.name_en = 'Des canyons aux étoiles..., I/51: I. Le désert',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 707 AND p.composer_id = 95 AND part.part_key = 'musicbrainz:52150e99-65b7-44b7-b05b-2b31e5d24c1c' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:52150e99-65b7-44b7-b05b-2b31e5d24c1c', 1, 'I', 'Le désert', 'Des canyons aux étoiles..., I/51: I. Le désert', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 707 AND p.composer_id = 95
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:52150e99-65b7-44b7-b05b-2b31e5d24c1c'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'Les orioles', part.name_en = 'Des canyons aux étoiles..., I/51: II. Les orioles',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 707 AND p.composer_id = 95 AND part.part_key = 'musicbrainz:1d35ef20-1959-4998-9e60-7a43dab10921' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:1d35ef20-1959-4998-9e60-7a43dab10921', 2, 'II', 'Les orioles', 'Des canyons aux étoiles..., I/51: II. Les orioles', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 707 AND p.composer_id = 95
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:1d35ef20-1959-4998-9e60-7a43dab10921'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = 'Ce qui est écrit sur les étoiles', part.name_en = 'Des canyons aux étoiles..., I/51: III. Ce qui est écrit sur les étoiles',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 707 AND p.composer_id = 95 AND part.part_key = 'musicbrainz:d8360df4-4f35-4a42-a3fc-41e6e899a0f2' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:d8360df4-4f35-4a42-a3fc-41e6e899a0f2', 3, 'III', 'Ce qui est écrit sur les étoiles', 'Des canyons aux étoiles..., I/51: III. Ce qui est écrit sur les étoiles', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 707 AND p.composer_id = 95
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:d8360df4-4f35-4a42-a3fc-41e6e899a0f2'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = 'IV',
    part.name_ko = 'Le cossyphe d’Heuglin', part.name_en = 'Des canyons aux étoiles..., I/51: IV. Le cossyphe d’Heuglin',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 707 AND p.composer_id = 95 AND part.part_key = 'musicbrainz:76a2942b-1eb9-41ab-bc1d-7eeac48435cb' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:76a2942b-1eb9-41ab-bc1d-7eeac48435cb', 4, 'IV', 'Le cossyphe d’Heuglin', 'Des canyons aux étoiles..., I/51: IV. Le cossyphe d’Heuglin', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 707 AND p.composer_id = 95
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:76a2942b-1eb9-41ab-bc1d-7eeac48435cb'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 5, part.movement_number = 'V',
    part.name_ko = 'Cedar Breaks et le don de crainte', part.name_en = 'Des canyons aux étoiles..., I/51: V. Cedar Breaks et le don de crainte',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 707 AND p.composer_id = 95 AND part.part_key = 'musicbrainz:27133a93-aca4-4909-8ccf-26f0e23646d8' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:27133a93-aca4-4909-8ccf-26f0e23646d8', 5, 'V', 'Cedar Breaks et le don de crainte', 'Des canyons aux étoiles..., I/51: V. Cedar Breaks et le don de crainte', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 707 AND p.composer_id = 95
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:27133a93-aca4-4909-8ccf-26f0e23646d8'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 6, part.movement_number = 'VI',
    part.name_ko = 'Appel interstellaire', part.name_en = 'Des canyons aux étoiles..., I/51: VI. Appel interstellaire',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 707 AND p.composer_id = 95 AND part.part_key = 'musicbrainz:d64c0b6f-fa0f-4fe9-90b9-8d5e1422cb84' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:d64c0b6f-fa0f-4fe9-90b9-8d5e1422cb84', 6, 'VI', 'Appel interstellaire', 'Des canyons aux étoiles..., I/51: VI. Appel interstellaire', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 707 AND p.composer_id = 95
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:d64c0b6f-fa0f-4fe9-90b9-8d5e1422cb84'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 7, part.movement_number = 'VII',
    part.name_ko = 'Bryce Canyon et les rochers rouge-orange', part.name_en = 'Des canyons aux étoiles..., I/51: VII. Bryce Canyon et les rochers rouge-orange',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 707 AND p.composer_id = 95 AND part.part_key = 'musicbrainz:baaddde5-2b9b-4353-b80d-d9b79f5fd8b2' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:baaddde5-2b9b-4353-b80d-d9b79f5fd8b2', 7, 'VII', 'Bryce Canyon et les rochers rouge-orange', 'Des canyons aux étoiles..., I/51: VII. Bryce Canyon et les rochers rouge-orange', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 707 AND p.composer_id = 95
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:baaddde5-2b9b-4353-b80d-d9b79f5fd8b2'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 8, part.movement_number = 'VIII',
    part.name_ko = 'Les ressucités et le chant de l’étoile Aldebaran', part.name_en = 'Des canyons aux étoiles..., I/51: VIII. Les ressucités et le chant de l’étoile Aldebaran',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 707 AND p.composer_id = 95 AND part.part_key = 'musicbrainz:83a9f769-f1eb-49cc-aacb-84cf2033ef01' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:83a9f769-f1eb-49cc-aacb-84cf2033ef01', 8, 'VIII', 'Les ressucités et le chant de l’étoile Aldebaran', 'Des canyons aux étoiles..., I/51: VIII. Les ressucités et le chant de l’étoile Aldebaran', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 707 AND p.composer_id = 95
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:83a9f769-f1eb-49cc-aacb-84cf2033ef01'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 9, part.movement_number = 'IX',
    part.name_ko = 'Le moqueur polyglotte', part.name_en = 'Des canyons aux étoiles..., I/51: IX. Le moqueur polyglotte',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 707 AND p.composer_id = 95 AND part.part_key = 'musicbrainz:7e0e86cd-b753-4071-abdd-816cb2f3ed5a' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:7e0e86cd-b753-4071-abdd-816cb2f3ed5a', 9, 'IX', 'Le moqueur polyglotte', 'Des canyons aux étoiles..., I/51: IX. Le moqueur polyglotte', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 707 AND p.composer_id = 95
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:7e0e86cd-b753-4071-abdd-816cb2f3ed5a'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 10, part.movement_number = 'X',
    part.name_ko = 'La grive des bois', part.name_en = 'Des canyons aux étoiles..., I/51: X. La grive des bois',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 707 AND p.composer_id = 95 AND part.part_key = 'musicbrainz:3303253d-fe15-4dc9-b0e6-821e513e6172' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:3303253d-fe15-4dc9-b0e6-821e513e6172', 10, 'X', 'La grive des bois', 'Des canyons aux étoiles..., I/51: X. La grive des bois', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 707 AND p.composer_id = 95
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:3303253d-fe15-4dc9-b0e6-821e513e6172'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 11, part.movement_number = 'XI',
    part.name_ko = 'Des canyons aux étoiles: Omao, leiothrix, elepaio, shama', part.name_en = 'Des canyons aux étoiles..., I/51: XI. Des canyons aux étoiles: Omao, leiothrix, elepaio, shama',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 707 AND p.composer_id = 95 AND part.part_key = 'musicbrainz:b55bda2c-934b-4311-be33-f81f24ab8d53' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:b55bda2c-934b-4311-be33-f81f24ab8d53', 11, 'XI', 'Des canyons aux étoiles: Omao, leiothrix, elepaio, shama', 'Des canyons aux étoiles..., I/51: XI. Des canyons aux étoiles: Omao, leiothrix, elepaio, shama', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 707 AND p.composer_id = 95
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:b55bda2c-934b-4311-be33-f81f24ab8d53'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 12, part.movement_number = 'XII',
    part.name_ko = 'Des canyons aux étoiles: Zion Park et la cité céleste', part.name_en = 'Des canyons aux étoiles..., I/51: XII. Des canyons aux étoiles: Zion Park et la cité céleste',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 707 AND p.composer_id = 95 AND part.part_key = 'musicbrainz:4cf910bc-96fa-4bf9-a7c7-74233b941dcf' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:4cf910bc-96fa-4bf9-a7c7-74233b941dcf', 12, 'XII', 'Des canyons aux étoiles: Zion Park et la cité céleste', 'Des canyons aux étoiles..., I/51: XII. Des canyons aux étoiles: Zion Park et la cité céleste', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 707 AND p.composer_id = 95
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:4cf910bc-96fa-4bf9-a7c7-74233b941dcf'
);


-- None 가곡 <Deux ballades de Villon>

UPDATE pieces piece
SET piece.title = '가곡 <Deux ballades de Villon>', piece.title_en = 'Deux ballades de Villon',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 2192 AND piece.composer_id = 95
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'Épître à ses amis', part.name_en = 'Deux ballades de Villon: I. Épître à ses amis',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 2192 AND p.composer_id = 95 AND part.part_key = 'musicbrainz:91e70b47-26b6-4f77-8e6a-73aeef8519ce' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:91e70b47-26b6-4f77-8e6a-73aeef8519ce', 1, 'I', 'Épître à ses amis', 'Deux ballades de Villon: I. Épître à ses amis', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 2192 AND p.composer_id = 95
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:91e70b47-26b6-4f77-8e6a-73aeef8519ce'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'Ballade des pendus', part.name_en = 'Deux ballades de Villon: II. Ballade des pendus',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 2192 AND p.composer_id = 95 AND part.part_key = 'musicbrainz:7ff74476-780c-44fc-9ee4-0d0e9fa41484' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:7ff74476-780c-44fc-9ee4-0d0e9fa41484', 2, 'II', 'Ballade des pendus', 'Deux ballades de Villon: II. Ballade des pendus', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 2192 AND p.composer_id = 95
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:7ff74476-780c-44fc-9ee4-0d0e9fa41484'
);


-- None Diptyque

UPDATE pieces piece
SET piece.title = 'Diptyque', piece.title_en = 'Diptyque',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 687 AND piece.composer_id = 95
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Esquisse modale

UPDATE pieces piece
SET piece.title = 'Esquisse modale', piece.title_en = 'Esquisse modale',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 2588 AND piece.composer_id = 95
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Et exspecto resurrectionem mortuorum, I/47

UPDATE pieces piece
SET piece.title = 'Et exspecto resurrectionem mortuorum, I/47', piece.title_en = 'Et exspecto resurrectionem mortuorum, I/47',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 688 AND piece.composer_id = 95
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'Des profondeurs de l''abîme, je cris vers toi, Seigneur: Seigneur, écoute ma voix !', part.name_en = 'Et exspecto resurrectionem mortuorum, I/47: I. Des profondeurs de l''abîme, je cris vers toi, Seigneur: Seigneur, écoute ma voix !',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 688 AND p.composer_id = 95 AND part.part_key = 'musicbrainz:2bfcd764-1fb8-4030-83a9-832d552d069e' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:2bfcd764-1fb8-4030-83a9-832d552d069e', 1, 'I', 'Des profondeurs de l''abîme, je cris vers toi, Seigneur: Seigneur, écoute ma voix !', 'Et exspecto resurrectionem mortuorum, I/47: I. Des profondeurs de l''abîme, je cris vers toi, Seigneur: Seigneur, écoute ma voix !', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 688 AND p.composer_id = 95
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:2bfcd764-1fb8-4030-83a9-832d552d069e'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'Le Christ, ressucité des morts, ne meurt plus; la mort n’a plus su lui d’empire', part.name_en = 'Et exspecto resurrectionem mortuorum, I/47: II. Le Christ, ressucité des morts, ne meurt plus; la mort n’a plus su lui d’empire',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 688 AND p.composer_id = 95 AND part.part_key = 'musicbrainz:53c6669e-aaf7-4295-8be8-3f85c8e2e9c8' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:53c6669e-aaf7-4295-8be8-3f85c8e2e9c8', 2, 'II', 'Le Christ, ressucité des morts, ne meurt plus; la mort n’a plus su lui d’empire', 'Et exspecto resurrectionem mortuorum, I/47: II. Le Christ, ressucité des morts, ne meurt plus; la mort n’a plus su lui d’empire', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 688 AND p.composer_id = 95
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:53c6669e-aaf7-4295-8be8-3f85c8e2e9c8'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = 'L’heure vient où les morts entendront la voix du fils de Dieu', part.name_en = 'Et exspecto resurrectionem mortuorum, I/47: III. L’heure vient où les morts entendront la voix du fils de Dieu',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 688 AND p.composer_id = 95 AND part.part_key = 'musicbrainz:5faa85c4-f770-45ab-88f2-13447e701a61' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:5faa85c4-f770-45ab-88f2-13447e701a61', 3, 'III', 'L’heure vient où les morts entendront la voix du fils de Dieu', 'Et exspecto resurrectionem mortuorum, I/47: III. L’heure vient où les morts entendront la voix du fils de Dieu', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 688 AND p.composer_id = 95
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:5faa85c4-f770-45ab-88f2-13447e701a61'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = 'IV',
    part.name_ko = 'Ils ressusciteront, glorieux, avec un nom noveau - dans le concert joyeux des étoiles et les acclamations des fils du ciel', part.name_en = 'Et exspecto resurrectionem mortuorum, I/47: IV. Ils ressusciteront, glorieux, avec un nom noveau - dans le concert joyeux des étoiles et les acclamations des fils du ciel',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 688 AND p.composer_id = 95 AND part.part_key = 'musicbrainz:8e9c077f-f7e2-45a0-a3c3-94f45c83b62d' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:8e9c077f-f7e2-45a0-a3c3-94f45c83b62d', 4, 'IV', 'Ils ressusciteront, glorieux, avec un nom noveau - dans le concert joyeux des étoiles et les acclamations des fils du ciel', 'Et exspecto resurrectionem mortuorum, I/47: IV. Ils ressusciteront, glorieux, avec un nom noveau - dans le concert joyeux des étoiles et les acclamations des fils du ciel', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 688 AND p.composer_id = 95
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:8e9c077f-f7e2-45a0-a3c3-94f45c83b62d'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 5, part.movement_number = 'V',
    part.name_ko = 'Et j’entendis la voix d’une foule immense', part.name_en = 'Et exspecto resurrectionem mortuorum, I/47: V. Et j’entendis la voix d’une foule immense',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 688 AND p.composer_id = 95 AND part.part_key = 'musicbrainz:7169aa05-47f3-41c5-9b79-f2b6e4352e00' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:7169aa05-47f3-41c5-9b79-f2b6e4352e00', 5, 'V', 'Et j’entendis la voix d’une foule immense', 'Et exspecto resurrectionem mortuorum, I/47: V. Et j’entendis la voix d’une foule immense', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 688 AND p.composer_id = 95
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:7169aa05-47f3-41c5-9b79-f2b6e4352e00'
);


-- None Fantaisie burlesque, I/11

UPDATE pieces piece
SET piece.title = 'Fantaisie burlesque, I/11', piece.title_en = 'Fantaisie burlesque, I/11',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 690 AND piece.composer_id = 95
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Fantaisie pour violon et piano

UPDATE pieces piece
SET piece.title = 'Fantaisie pour violon et piano', piece.title_en = 'Fantaisie pour violon et piano',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 728 AND piece.composer_id = 95
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Fugue (sur un sujet de Henri Rabaud)

UPDATE pieces piece
SET piece.title = 'Fugue (sur un sujet de Henri Rabaud)', piece.title_en = 'Fugue (sur un sujet de Henri Rabaud)',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 2655 AND piece.composer_id = 95
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Fugue en ré mineur

UPDATE pieces piece
SET piece.title = 'Fugue en ré mineur', piece.title_en = 'Fugue en ré mineur',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 2250 AND piece.composer_id = 95
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Fête des belles eaux

UPDATE pieces piece
SET piece.title = 'Fête des belles eaux', piece.title_en = 'Fête des belles eaux',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 723 AND piece.composer_id = 95
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'Premières fusées', part.name_en = 'Fête des belles eaux: I. Premières fusées',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 723 AND p.composer_id = 95 AND part.part_key = 'musicbrainz:a932f907-ae97-4a4d-8f27-033faeb51380' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:a932f907-ae97-4a4d-8f27-033faeb51380', 1, 'I', 'Premières fusées', 'Fête des belles eaux: I. Premières fusées', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 723 AND p.composer_id = 95
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:a932f907-ae97-4a4d-8f27-033faeb51380'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'L''eau', part.name_en = 'Fête des belles eaux: II. L''eau',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 723 AND p.composer_id = 95 AND part.part_key = 'musicbrainz:281fb1f5-6e22-496b-8874-46b0baca84b7' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:281fb1f5-6e22-496b-8874-46b0baca84b7', 2, 'II', 'L''eau', 'Fête des belles eaux: II. L''eau', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 723 AND p.composer_id = 95
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:281fb1f5-6e22-496b-8874-46b0baca84b7'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = 'Les fusées', part.name_en = 'Fête des belles eaux: III. Les fusées',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 723 AND p.composer_id = 95 AND part.part_key = 'musicbrainz:ae60f5c5-29ff-4e9b-b6b9-a314efbc6ba9' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:ae60f5c5-29ff-4e9b-b6b9-a314efbc6ba9', 3, 'III', 'Les fusées', 'Fête des belles eaux: III. Les fusées', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 723 AND p.composer_id = 95
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:ae60f5c5-29ff-4e9b-b6b9-a314efbc6ba9'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = 'IV',
    part.name_ko = 'L''eau', part.name_en = 'Fête des belles eaux: IV. L''eau',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 723 AND p.composer_id = 95 AND part.part_key = 'musicbrainz:85418f49-8e0d-4e5e-b31b-bc9a976e9139' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:85418f49-8e0d-4e5e-b31b-bc9a976e9139', 4, 'IV', 'L''eau', 'Fête des belles eaux: IV. L''eau', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 723 AND p.composer_id = 95
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:85418f49-8e0d-4e5e-b31b-bc9a976e9139'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 5, part.movement_number = 'V',
    part.name_ko = 'Les fusées', part.name_en = 'Fête des belles eaux: V. Les fusées',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 723 AND p.composer_id = 95 AND part.part_key = 'musicbrainz:989bcef5-3795-4b6d-8c0b-ef68559f250e' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:989bcef5-3795-4b6d-8c0b-ef68559f250e', 5, 'V', 'Les fusées', 'Fête des belles eaux: V. Les fusées', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 723 AND p.composer_id = 95
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:989bcef5-3795-4b6d-8c0b-ef68559f250e'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 6, part.movement_number = 'VI',
    part.name_ko = 'L''eau', part.name_en = 'Fête des belles eaux: VI. L''eau',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 723 AND p.composer_id = 95 AND part.part_key = 'musicbrainz:967d202c-f9b8-4e0d-8f36-56f7decf3f23' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:967d202c-f9b8-4e0d-8f36-56f7decf3f23', 6, 'VI', 'L''eau', 'Fête des belles eaux: VI. L''eau', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 723 AND p.composer_id = 95
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:967d202c-f9b8-4e0d-8f36-56f7decf3f23'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 7, part.movement_number = 'VII',
    part.name_ko = 'Superposition de l''eau et des fusées', part.name_en = 'Fête des belles eaux: VII. Superposition de l''eau et des fusées',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 723 AND p.composer_id = 95 AND part.part_key = 'musicbrainz:379f9c39-9c21-4ce5-acd4-2939fc06433e' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:379f9c39-9c21-4ce5-acd4-2939fc06433e', 7, 'VII', 'Superposition de l''eau et des fusées', 'Fête des belles eaux: VII. Superposition de l''eau et des fusées', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 723 AND p.composer_id = 95
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:379f9c39-9c21-4ce5-acd4-2939fc06433e'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 8, part.movement_number = 'VIII',
    part.name_ko = 'Feu d''artifice final', part.name_en = 'Fête des belles eaux: VIII. Feu d''artifice final',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 723 AND p.composer_id = 95 AND part.part_key = 'musicbrainz:6dde9b87-8a78-448e-97eb-379e8324272d' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:6dde9b87-8a78-448e-97eb-379e8324272d', 8, 'VIII', 'Feu d''artifice final', 'Fête des belles eaux: VIII. Feu d''artifice final', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 723 AND p.composer_id = 95
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:6dde9b87-8a78-448e-97eb-379e8324272d'
);


-- None 연가곡집 <Harawi, I/28>

UPDATE pieces piece
SET piece.title = '연가곡집 <Harawi, I/28>', piece.title_en = 'Harawi, I/28',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 691 AND piece.composer_id = 95
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'La Ville qui dormait', part.name_en = 'Harawi: I. La Ville qui dormait',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 691 AND p.composer_id = 95 AND part.part_key = 'musicbrainz:f7076893-43b3-4cb4-b533-e1fe693ca817' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:f7076893-43b3-4cb4-b533-e1fe693ca817', 1, 'I', 'La Ville qui dormait', 'Harawi: I. La Ville qui dormait', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 691 AND p.composer_id = 95
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:f7076893-43b3-4cb4-b533-e1fe693ca817'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'Bonjour toi, Colombe verte', part.name_en = 'Harawi: II. Bonjour toi, Colombe verte',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 691 AND p.composer_id = 95 AND part.part_key = 'musicbrainz:e4159b79-d7c3-4195-805b-77f8e9b20aec' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:e4159b79-d7c3-4195-805b-77f8e9b20aec', 2, 'II', 'Bonjour toi, Colombe verte', 'Harawi: II. Bonjour toi, Colombe verte', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 691 AND p.composer_id = 95
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:e4159b79-d7c3-4195-805b-77f8e9b20aec'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = 'Montagnes', part.name_en = 'Harawi: III. Montagnes',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 691 AND p.composer_id = 95 AND part.part_key = 'musicbrainz:860e362e-3c8b-4f7a-b867-8487ea796224' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:860e362e-3c8b-4f7a-b867-8487ea796224', 3, 'III', 'Montagnes', 'Harawi: III. Montagnes', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 691 AND p.composer_id = 95
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:860e362e-3c8b-4f7a-b867-8487ea796224'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = 'IV',
    part.name_ko = 'Doundou tchil', part.name_en = 'Harawi: IV. Doundou tchil',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 691 AND p.composer_id = 95 AND part.part_key = 'musicbrainz:b449f2a0-5239-4a16-851e-7037524ece7a' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:b449f2a0-5239-4a16-851e-7037524ece7a', 4, 'IV', 'Doundou tchil', 'Harawi: IV. Doundou tchil', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 691 AND p.composer_id = 95
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:b449f2a0-5239-4a16-851e-7037524ece7a'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 5, part.movement_number = 'V',
    part.name_ko = 'L''amour de Piroutcha', part.name_en = 'Harawi: V. L''amour de Piroutcha',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 691 AND p.composer_id = 95 AND part.part_key = 'musicbrainz:2aa157b6-1de0-4c22-8589-67708cc2a294' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:2aa157b6-1de0-4c22-8589-67708cc2a294', 5, 'V', 'L''amour de Piroutcha', 'Harawi: V. L''amour de Piroutcha', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 691 AND p.composer_id = 95
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:2aa157b6-1de0-4c22-8589-67708cc2a294'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 6, part.movement_number = 'VI',
    part.name_ko = 'Répétition planétaire', part.name_en = 'Harawi: VI. Répétition planétaire',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 691 AND p.composer_id = 95 AND part.part_key = 'musicbrainz:84871b5d-71f8-4085-a755-7751d7397ede' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:84871b5d-71f8-4085-a755-7751d7397ede', 6, 'VI', 'Répétition planétaire', 'Harawi: VI. Répétition planétaire', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 691 AND p.composer_id = 95
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:84871b5d-71f8-4085-a755-7751d7397ede'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 7, part.movement_number = 'VII',
    part.name_ko = 'Adieu', part.name_en = 'Harawi: VII. Adieu',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 691 AND p.composer_id = 95 AND part.part_key = 'musicbrainz:beaa7476-249c-482f-bb86-d587e0e6e23f' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:beaa7476-249c-482f-bb86-d587e0e6e23f', 7, 'VII', 'Adieu', 'Harawi: VII. Adieu', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 691 AND p.composer_id = 95
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:beaa7476-249c-482f-bb86-d587e0e6e23f'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 8, part.movement_number = 'VIII',
    part.name_ko = 'Syllabes', part.name_en = 'Harawi: VIII. Syllabes',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 691 AND p.composer_id = 95 AND part.part_key = 'musicbrainz:80b757af-daed-4f26-8405-51b7a7425e0e' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:80b757af-daed-4f26-8405-51b7a7425e0e', 8, 'VIII', 'Syllabes', 'Harawi: VIII. Syllabes', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 691 AND p.composer_id = 95
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:80b757af-daed-4f26-8405-51b7a7425e0e'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 9, part.movement_number = 'IX',
    part.name_ko = 'L''escalier redit, gestes du soleil', part.name_en = 'Harawi: IX. L''escalier redit, gestes du soleil',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 691 AND p.composer_id = 95 AND part.part_key = 'musicbrainz:26869507-03b4-4fe5-8098-f8c5cdfa1001' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:26869507-03b4-4fe5-8098-f8c5cdfa1001', 9, 'IX', 'L''escalier redit, gestes du soleil', 'Harawi: IX. L''escalier redit, gestes du soleil', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 691 AND p.composer_id = 95
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:26869507-03b4-4fe5-8098-f8c5cdfa1001'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 10, part.movement_number = 'X',
    part.name_ko = 'Amour oiseau d''étoile', part.name_en = 'Harawi: X. Amour oiseau d''étoile',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 691 AND p.composer_id = 95 AND part.part_key = 'musicbrainz:39a6a42d-1d44-40dd-be33-fab8a81c404b' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:39a6a42d-1d44-40dd-be33-fab8a81c404b', 10, 'X', 'Amour oiseau d''étoile', 'Harawi: X. Amour oiseau d''étoile', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 691 AND p.composer_id = 95
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:39a6a42d-1d44-40dd-be33-fab8a81c404b'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 11, part.movement_number = 'XI',
    part.name_ko = 'Katchikatchi les étoiles', part.name_en = 'Harawi: XI. Katchikatchi les étoiles',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 691 AND p.composer_id = 95 AND part.part_key = 'musicbrainz:eb8fe513-b6dd-4c27-bbcc-abd8197ff9dc' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:eb8fe513-b6dd-4c27-bbcc-abd8197ff9dc', 11, 'XI', 'Katchikatchi les étoiles', 'Harawi: XI. Katchikatchi les étoiles', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 691 AND p.composer_id = 95
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:eb8fe513-b6dd-4c27-bbcc-abd8197ff9dc'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 12, part.movement_number = 'XII',
    part.name_ko = 'Dans le noir', part.name_en = 'Harawi: XII. Dans le noir',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 691 AND p.composer_id = 95 AND part.part_key = 'musicbrainz:98639afb-4147-4724-aee1-5745d87f3d94' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:98639afb-4147-4724-aee1-5745d87f3d94', 12, 'XII', 'Dans le noir', 'Harawi: XII. Dans le noir', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 691 AND p.composer_id = 95
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:98639afb-4147-4724-aee1-5745d87f3d94'
);


-- None Huit préludes

UPDATE pieces piece
SET piece.title = 'Huit préludes', piece.title_en = 'Huit préludes',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 700 AND piece.composer_id = 95
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'La colombe', part.name_en = 'Préludes: No. 1. La colombe',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 700 AND p.composer_id = 95 AND part.part_key = 'musicbrainz:d2c2dc5c-7cfb-3b93-87cb-8ed0a2dbf8e3' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:d2c2dc5c-7cfb-3b93-87cb-8ed0a2dbf8e3', 1, NULL, 'La colombe', 'Préludes: No. 1. La colombe', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 700 AND p.composer_id = 95
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:d2c2dc5c-7cfb-3b93-87cb-8ed0a2dbf8e3'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'Chant d''extase dans une paysage triste', part.name_en = 'Préludes: No. 2. Chant d''extase dans une paysage triste',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 700 AND p.composer_id = 95 AND part.part_key = 'musicbrainz:8e09501c-99ce-3414-ad31-146ccc0a3fc8' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:8e09501c-99ce-3414-ad31-146ccc0a3fc8', 2, NULL, 'Chant d''extase dans une paysage triste', 'Préludes: No. 2. Chant d''extase dans une paysage triste', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 700 AND p.composer_id = 95
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:8e09501c-99ce-3414-ad31-146ccc0a3fc8'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = NULL,
    part.name_ko = 'Le nombre léger', part.name_en = 'Préludes: No. 3. Le nombre léger',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 700 AND p.composer_id = 95 AND part.part_key = 'musicbrainz:41a4f1df-3f28-31c7-8430-33a78a1a049e' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:41a4f1df-3f28-31c7-8430-33a78a1a049e', 3, NULL, 'Le nombre léger', 'Préludes: No. 3. Le nombre léger', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 700 AND p.composer_id = 95
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:41a4f1df-3f28-31c7-8430-33a78a1a049e'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = NULL,
    part.name_ko = 'Instants défunts', part.name_en = 'Préludes: No. 4. Instants défunts',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 700 AND p.composer_id = 95 AND part.part_key = 'musicbrainz:735dd091-1700-3474-8092-4998d6d54afd' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:735dd091-1700-3474-8092-4998d6d54afd', 4, NULL, 'Instants défunts', 'Préludes: No. 4. Instants défunts', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 700 AND p.composer_id = 95
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:735dd091-1700-3474-8092-4998d6d54afd'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 5, part.movement_number = NULL,
    part.name_ko = 'Les sons impalpables du rêve', part.name_en = 'Préludes: No. 5. Les sons impalpables du rêve',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 700 AND p.composer_id = 95 AND part.part_key = 'musicbrainz:cca09123-6331-3b94-bcad-e7670a9dbbe2' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:cca09123-6331-3b94-bcad-e7670a9dbbe2', 5, NULL, 'Les sons impalpables du rêve', 'Préludes: No. 5. Les sons impalpables du rêve', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 700 AND p.composer_id = 95
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:cca09123-6331-3b94-bcad-e7670a9dbbe2'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 6, part.movement_number = NULL,
    part.name_ko = 'Cloches d''angoisse et larmes d''adieu', part.name_en = 'Préludes: No. 6. Cloches d''angoisse et larmes d''adieu',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 700 AND p.composer_id = 95 AND part.part_key = 'musicbrainz:d803329d-b667-36b5-b5f3-2e30ec6ab757' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:d803329d-b667-36b5-b5f3-2e30ec6ab757', 6, NULL, 'Cloches d''angoisse et larmes d''adieu', 'Préludes: No. 6. Cloches d''angoisse et larmes d''adieu', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 700 AND p.composer_id = 95
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:d803329d-b667-36b5-b5f3-2e30ec6ab757'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 7, part.movement_number = NULL,
    part.name_ko = 'Plainte calme', part.name_en = 'Préludes: No. 7. Plainte calme',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 700 AND p.composer_id = 95 AND part.part_key = 'musicbrainz:6599115f-5693-3cdb-9ab9-8b1626e7e824' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:6599115f-5693-3cdb-9ab9-8b1626e7e824', 7, NULL, 'Plainte calme', 'Préludes: No. 7. Plainte calme', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 700 AND p.composer_id = 95
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:6599115f-5693-3cdb-9ab9-8b1626e7e824'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 8, part.movement_number = NULL,
    part.name_ko = 'Un reflet dans le vent', part.name_en = 'Préludes: No. 8. Un reflet dans le vent',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 700 AND p.composer_id = 95 AND part.part_key = 'musicbrainz:6ef9ca06-b485-3332-9adb-6eb53741019e' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:6ef9ca06-b485-3332-9adb-6eb53741019e', 8, NULL, 'Un reflet dans le vent', 'Préludes: No. 8. Un reflet dans le vent', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 700 AND p.composer_id = 95
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:6ef9ca06-b485-3332-9adb-6eb53741019e'
);


-- None La Dame de Shalott

UPDATE pieces piece
SET piece.title = 'La Dame de Shalott', piece.title_en = 'La Dame de Shalott',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 1827 AND piece.composer_id = 95
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None La Fauvette des jardins, I/50

UPDATE pieces piece
SET piece.title = 'La Fauvette des jardins, I/50', piece.title_en = 'La Fauvette des jardins, I/50',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 580 AND piece.composer_id = 95
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None La Fauvette passerinette

UPDATE pieces piece
SET piece.title = 'La Fauvette passerinette', piece.title_en = 'La Fauvette passerinette',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 778 AND piece.composer_id = 95
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None La Mort du nombre, I/6

UPDATE pieces piece
SET piece.title = 'La Mort du nombre, I/6', piece.title_en = 'La Mort du nombre, I/6',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 696 AND piece.composer_id = 95
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None La Nativité du Seigneur

UPDATE pieces piece
SET piece.title = 'La Nativité du Seigneur', piece.title_en = 'La Nativité du Seigneur',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 697 AND piece.composer_id = 95
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'La vierge et l’enfant', part.name_en = 'La Nativité du Seigneur: I. La vierge et l’enfant',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 697 AND p.composer_id = 95 AND part.part_key = 'musicbrainz:2246a3aa-4147-4a53-9e79-a300210612b0' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:2246a3aa-4147-4a53-9e79-a300210612b0', 1, 'I', 'La vierge et l’enfant', 'La Nativité du Seigneur: I. La vierge et l’enfant', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 697 AND p.composer_id = 95
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:2246a3aa-4147-4a53-9e79-a300210612b0'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'Les bergers', part.name_en = 'La Nativité du Seigneur: II. Les bergers',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 697 AND p.composer_id = 95 AND part.part_key = 'musicbrainz:956c0787-4efa-4f10-a604-da0117875b88' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:956c0787-4efa-4f10-a604-da0117875b88', 2, 'II', 'Les bergers', 'La Nativité du Seigneur: II. Les bergers', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 697 AND p.composer_id = 95
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:956c0787-4efa-4f10-a604-da0117875b88'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = 'Desseins éternels', part.name_en = 'La Nativité du Seigneur: III. Desseins éternels',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 697 AND p.composer_id = 95 AND part.part_key = 'musicbrainz:70571911-a243-4384-8b17-02ca66cb0a6a' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:70571911-a243-4384-8b17-02ca66cb0a6a', 3, 'III', 'Desseins éternels', 'La Nativité du Seigneur: III. Desseins éternels', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 697 AND p.composer_id = 95
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:70571911-a243-4384-8b17-02ca66cb0a6a'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = 'IV',
    part.name_ko = 'Le verbe', part.name_en = 'La Nativité du Seigneur: IV. Le verbe',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 697 AND p.composer_id = 95 AND part.part_key = 'musicbrainz:2cc26284-9a19-4b2d-b22b-a2c2864083c8' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:2cc26284-9a19-4b2d-b22b-a2c2864083c8', 4, 'IV', 'Le verbe', 'La Nativité du Seigneur: IV. Le verbe', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 697 AND p.composer_id = 95
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:2cc26284-9a19-4b2d-b22b-a2c2864083c8'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 5, part.movement_number = 'V',
    part.name_ko = 'Les enfants de Dieu', part.name_en = 'La Nativité du Seigneur: V. Les enfants de Dieu',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 697 AND p.composer_id = 95 AND part.part_key = 'musicbrainz:ba67e89a-e101-4b3b-9f9f-21efe8211f13' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:ba67e89a-e101-4b3b-9f9f-21efe8211f13', 5, 'V', 'Les enfants de Dieu', 'La Nativité du Seigneur: V. Les enfants de Dieu', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 697 AND p.composer_id = 95
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:ba67e89a-e101-4b3b-9f9f-21efe8211f13'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 6, part.movement_number = 'VI',
    part.name_ko = 'Les anges', part.name_en = 'La Nativité du Seigneur: VI. Les anges',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 697 AND p.composer_id = 95 AND part.part_key = 'musicbrainz:7d2fa249-d934-44ff-808e-778d41274dd2' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:7d2fa249-d934-44ff-808e-778d41274dd2', 6, 'VI', 'Les anges', 'La Nativité du Seigneur: VI. Les anges', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 697 AND p.composer_id = 95
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:7d2fa249-d934-44ff-808e-778d41274dd2'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 7, part.movement_number = 'VII',
    part.name_ko = 'Jésus accepte la souffrance', part.name_en = 'La Nativité du Seigneur: VII. Jésus accepte la souffrance',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 697 AND p.composer_id = 95 AND part.part_key = 'musicbrainz:e543c706-1a03-4675-8623-8738010188ae' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:e543c706-1a03-4675-8623-8738010188ae', 7, 'VII', 'Jésus accepte la souffrance', 'La Nativité du Seigneur: VII. Jésus accepte la souffrance', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 697 AND p.composer_id = 95
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:e543c706-1a03-4675-8623-8738010188ae'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 8, part.movement_number = 'VIII',
    part.name_ko = 'Les mages', part.name_en = 'La Nativité du Seigneur: VIII. Les mages',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 697 AND p.composer_id = 95 AND part.part_key = 'musicbrainz:3b8f8df1-a6f0-46d9-9560-ed5c853f778e' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:3b8f8df1-a6f0-46d9-9560-ed5c853f778e', 8, 'VIII', 'Les mages', 'La Nativité du Seigneur: VIII. Les mages', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 697 AND p.composer_id = 95
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:3b8f8df1-a6f0-46d9-9560-ed5c853f778e'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 9, part.movement_number = 'IX',
    part.name_ko = 'Dieu parmi nous', part.name_en = 'La Nativité du Seigneur: IX. Dieu parmi nous',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 697 AND p.composer_id = 95 AND part.part_key = 'musicbrainz:cdf8ab90-6683-43fa-bf1c-311961ad9570' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:cdf8ab90-6683-43fa-bf1c-311961ad9570', 9, 'IX', 'Dieu parmi nous', 'La Nativité du Seigneur: IX. Dieu parmi nous', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 697 AND p.composer_id = 95
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:cdf8ab90-6683-43fa-bf1c-311961ad9570'
);


-- None La Transfiguration de Notre Seigneur Jésus-Christ, I/48

UPDATE pieces piece
SET piece.title = 'La Transfiguration de Notre Seigneur Jésus-Christ, I/48', piece.title_en = 'La Transfiguration de Notre Seigneur Jésus-Christ, I/48',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 726 AND piece.composer_id = 95
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'Part I. I. Gospel Narrative', part.name_en = 'La Transfiguration de Notre Seigneur Jésus-Christ, I/48: Part I. I. Gospel Narrative',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 726 AND p.composer_id = 95 AND part.part_key = 'musicbrainz:b26d2a00-e362-4801-be76-57718caf5195' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:b26d2a00-e362-4801-be76-57718caf5195', 1, NULL, 'Part I. I. Gospel Narrative', 'La Transfiguration de Notre Seigneur Jésus-Christ, I/48: Part I. I. Gospel Narrative', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 726 AND p.composer_id = 95
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:b26d2a00-e362-4801-be76-57718caf5195'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'Part I. II. Configuratum corpori claritatis suae', part.name_en = 'La Transfiguration de Notre Seigneur Jésus-Christ, I/48: Part I. II. Configuratum corpori claritatis suae',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 726 AND p.composer_id = 95 AND part.part_key = 'musicbrainz:e7133576-b4fc-40b8-8a0c-55383d6068f1' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:e7133576-b4fc-40b8-8a0c-55383d6068f1', 2, NULL, 'Part I. II. Configuratum corpori claritatis suae', 'La Transfiguration de Notre Seigneur Jésus-Christ, I/48: Part I. II. Configuratum corpori claritatis suae', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 726 AND p.composer_id = 95
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:e7133576-b4fc-40b8-8a0c-55383d6068f1'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = NULL,
    part.name_ko = 'Part I. III. Christus Jesus, splendor Patris', part.name_en = 'La Transfiguration de Notre Seigneur Jésus-Christ, I/48: Part I. III. Christus Jesus, splendor Patris',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 726 AND p.composer_id = 95 AND part.part_key = 'musicbrainz:79920b2a-c98a-41be-bc2b-eb1b9511a3d3' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:79920b2a-c98a-41be-bc2b-eb1b9511a3d3', 3, NULL, 'Part I. III. Christus Jesus, splendor Patris', 'La Transfiguration de Notre Seigneur Jésus-Christ, I/48: Part I. III. Christus Jesus, splendor Patris', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 726 AND p.composer_id = 95
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:79920b2a-c98a-41be-bc2b-eb1b9511a3d3'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = NULL,
    part.name_ko = 'Part I. IV. Gospel Narrative', part.name_en = 'La Transfiguration de Notre Seigneur Jésus-Christ, I/48: Part I. IV. Gospel Narrative',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 726 AND p.composer_id = 95 AND part.part_key = 'musicbrainz:b5cd1f94-bc5d-4981-aaa2-4f9e4d3d1d20' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:b5cd1f94-bc5d-4981-aaa2-4f9e4d3d1d20', 4, NULL, 'Part I. IV. Gospel Narrative', 'La Transfiguration de Notre Seigneur Jésus-Christ, I/48: Part I. IV. Gospel Narrative', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 726 AND p.composer_id = 95
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:b5cd1f94-bc5d-4981-aaa2-4f9e4d3d1d20'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 5, part.movement_number = NULL,
    part.name_ko = 'Part I. V. Quam dilecta tabernacula tua', part.name_en = 'La Transfiguration de Notre Seigneur Jésus-Christ, I/48: Part I. V. Quam dilecta tabernacula tua',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 726 AND p.composer_id = 95 AND part.part_key = 'musicbrainz:7dad8b71-a28f-443f-a24f-650948a4b538' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:7dad8b71-a28f-443f-a24f-650948a4b538', 5, NULL, 'Part I. V. Quam dilecta tabernacula tua', 'La Transfiguration de Notre Seigneur Jésus-Christ, I/48: Part I. V. Quam dilecta tabernacula tua', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 726 AND p.composer_id = 95
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:7dad8b71-a28f-443f-a24f-650948a4b538'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 6, part.movement_number = NULL,
    part.name_ko = 'Part I. VI. Candor est lucis aeterna', part.name_en = 'La Transfiguration de Notre Seigneur Jésus-Christ, I/48: Part I. VI. Candor est lucis aeterna',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 726 AND p.composer_id = 95 AND part.part_key = 'musicbrainz:f608d9ba-5217-43a3-baf3-9864a31e702c' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:f608d9ba-5217-43a3-baf3-9864a31e702c', 6, NULL, 'Part I. VI. Candor est lucis aeterna', 'La Transfiguration de Notre Seigneur Jésus-Christ, I/48: Part I. VI. Candor est lucis aeterna', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 726 AND p.composer_id = 95
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:f608d9ba-5217-43a3-baf3-9864a31e702c'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 7, part.movement_number = NULL,
    part.name_ko = 'Part I. VIII. Chorale of the Holy Mountain', part.name_en = 'La Transfiguration de Notre Seigneur Jésus-Christ, I/48: Part I. VIII. Chorale of the Holy Mountain',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 726 AND p.composer_id = 95 AND part.part_key = 'musicbrainz:d1a02468-c1c6-44be-8563-aeb565fc6056' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:d1a02468-c1c6-44be-8563-aeb565fc6056', 7, NULL, 'Part I. VIII. Chorale of the Holy Mountain', 'La Transfiguration de Notre Seigneur Jésus-Christ, I/48: Part I. VIII. Chorale of the Holy Mountain', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 726 AND p.composer_id = 95
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:d1a02468-c1c6-44be-8563-aeb565fc6056'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 8, part.movement_number = NULL,
    part.name_ko = 'Part II. VIII. Gospel Narrative', part.name_en = 'La Transfiguration de Notre Seigneur Jésus-Christ, I/48: Part II. VIII. Gospel Narrative',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 726 AND p.composer_id = 95 AND part.part_key = 'musicbrainz:54346e0f-965f-455e-9eb9-65298b9474a4' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:54346e0f-965f-455e-9eb9-65298b9474a4', 8, NULL, 'Part II. VIII. Gospel Narrative', 'La Transfiguration de Notre Seigneur Jésus-Christ, I/48: Part II. VIII. Gospel Narrative', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 726 AND p.composer_id = 95
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:54346e0f-965f-455e-9eb9-65298b9474a4'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 9, part.movement_number = NULL,
    part.name_ko = 'Part II. IX. Perfecte conscius illius perfectae generationis', part.name_en = 'La Transfiguration de Notre Seigneur Jésus-Christ, I/48: Part II. IX. Perfecte conscius illius perfectae generationis',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 726 AND p.composer_id = 95 AND part.part_key = 'musicbrainz:fb59a79c-3b2b-40a1-9a3e-26fb3a44feb0' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:fb59a79c-3b2b-40a1-9a3e-26fb3a44feb0', 9, NULL, 'Part II. IX. Perfecte conscius illius perfectae generationis', 'La Transfiguration de Notre Seigneur Jésus-Christ, I/48: Part II. IX. Perfecte conscius illius perfectae generationis', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 726 AND p.composer_id = 95
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:fb59a79c-3b2b-40a1-9a3e-26fb3a44feb0'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 10, part.movement_number = NULL,
    part.name_ko = 'Part II. X. Adoptionem filiorum perfectam', part.name_en = 'La Transfiguration de Notre Seigneur Jésus-Christ, I/48: Part II. X. Adoptionem filiorum perfectam',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 726 AND p.composer_id = 95 AND part.part_key = 'musicbrainz:32b88c6b-6318-4d90-b8c2-a792297c9742' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:32b88c6b-6318-4d90-b8c2-a792297c9742', 10, NULL, 'Part II. X. Adoptionem filiorum perfectam', 'La Transfiguration de Notre Seigneur Jésus-Christ, I/48: Part II. X. Adoptionem filiorum perfectam', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 726 AND p.composer_id = 95
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:32b88c6b-6318-4d90-b8c2-a792297c9742'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 11, part.movement_number = NULL,
    part.name_ko = 'Part II. XI. Gospel Narrative', part.name_en = 'La Transfiguration de Notre Seigneur Jésus-Christ, I/48: Part II. XI. Gospel Narrative',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 726 AND p.composer_id = 95 AND part.part_key = 'musicbrainz:efa67311-a30c-4f12-9990-1bd6c59ff439' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:efa67311-a30c-4f12-9990-1bd6c59ff439', 11, NULL, 'Part II. XI. Gospel Narrative', 'La Transfiguration de Notre Seigneur Jésus-Christ, I/48: Part II. XI. Gospel Narrative', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 726 AND p.composer_id = 95
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:efa67311-a30c-4f12-9990-1bd6c59ff439'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 12, part.movement_number = NULL,
    part.name_ko = 'Part II. XII. Terribilis est locus iste', part.name_en = 'La Transfiguration de Notre Seigneur Jésus-Christ, I/48: Part II. XII. Terribilis est locus iste',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 726 AND p.composer_id = 95 AND part.part_key = 'musicbrainz:4b7d1b24-687a-4f2c-874b-70d33f447b4e' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:4b7d1b24-687a-4f2c-874b-70d33f447b4e', 12, NULL, 'Part II. XII. Terribilis est locus iste', 'La Transfiguration de Notre Seigneur Jésus-Christ, I/48: Part II. XII. Terribilis est locus iste', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 726 AND p.composer_id = 95
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:4b7d1b24-687a-4f2c-874b-70d33f447b4e'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 13, part.movement_number = NULL,
    part.name_ko = 'Part II. XIII. Tota Trinitas apparuit', part.name_en = 'La Transfiguration de Notre Seigneur Jésus-Christ, I/48: Part II. XIII. Tota Trinitas apparuit',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 726 AND p.composer_id = 95 AND part.part_key = 'musicbrainz:dc69e686-7449-4e82-875e-3e4cb62b46df' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:dc69e686-7449-4e82-875e-3e4cb62b46df', 13, NULL, 'Part II. XIII. Tota Trinitas apparuit', 'La Transfiguration de Notre Seigneur Jésus-Christ, I/48: Part II. XIII. Tota Trinitas apparuit', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 726 AND p.composer_id = 95
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:dc69e686-7449-4e82-875e-3e4cb62b46df'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 14, part.movement_number = NULL,
    part.name_ko = 'Part II. XIV. Chorale of the Glorious Light', part.name_en = 'La Transfiguration de Notre Seigneur Jésus-Christ, I/48: Part II. XIV. Chorale of the Glorious Light',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 726 AND p.composer_id = 95 AND part.part_key = 'musicbrainz:8a139ac3-f2fa-48e4-80f1-38a49f3dde6d' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:8a139ac3-f2fa-48e4-80f1-38a49f3dde6d', 14, NULL, 'Part II. XIV. Chorale of the Glorious Light', 'La Transfiguration de Notre Seigneur Jésus-Christ, I/48: Part II. XIV. Chorale of the Glorious Light', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 726 AND p.composer_id = 95
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:8a139ac3-f2fa-48e4-80f1-38a49f3dde6d'
);


-- None La Tristesse d'un grand ciel blanc

UPDATE pieces piece
SET piece.title = 'La Tristesse d''un grand ciel blanc', piece.title_en = 'La Tristesse d''un grand ciel blanc',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 2326 AND piece.composer_id = 95
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None La Ville d’en haut, I/56

UPDATE pieces piece
SET piece.title = 'La Ville d’en haut, I/56', piece.title_en = 'La Ville d’en haut, I/56',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 714 AND piece.composer_id = 95
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Le Banquet céleste

UPDATE pieces piece
SET piece.title = 'Le Banquet céleste', piece.title_en = 'Le Banquet céleste',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 682 AND piece.composer_id = 95
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Le Merle noir

UPDATE pieces piece
SET piece.title = 'Le Merle noir', piece.title_en = 'Le Merle noir',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 694 AND piece.composer_id = 95
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Le tombeau resplendissant

UPDATE pieces piece
SET piece.title = 'Le tombeau resplendissant', piece.title_en = 'Le tombeau resplendissant',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 710 AND piece.composer_id = 95
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Les Corps glorieux

UPDATE pieces piece
SET piece.title = 'Les Corps glorieux', piece.title_en = 'Les Corps glorieux',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 686 AND piece.composer_id = 95
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'Subtilité des Corps glorieux', part.name_en = 'Les Corps glorieux: I. Subtilité des Corps glorieux',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 686 AND p.composer_id = 95 AND part.part_key = 'musicbrainz:c8fceff7-cfff-419a-954e-084aa5fdba9a' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:c8fceff7-cfff-419a-954e-084aa5fdba9a', 1, 'I', 'Subtilité des Corps glorieux', 'Les Corps glorieux: I. Subtilité des Corps glorieux', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 686 AND p.composer_id = 95
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:c8fceff7-cfff-419a-954e-084aa5fdba9a'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'Les Eaux de la Grâce', part.name_en = 'Les Corps glorieux: II. Les Eaux de la Grâce',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 686 AND p.composer_id = 95 AND part.part_key = 'musicbrainz:a0a1c0c3-85d6-4889-888c-a00c427128ec' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:a0a1c0c3-85d6-4889-888c-a00c427128ec', 2, 'II', 'Les Eaux de la Grâce', 'Les Corps glorieux: II. Les Eaux de la Grâce', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 686 AND p.composer_id = 95
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:a0a1c0c3-85d6-4889-888c-a00c427128ec'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = 'L’Ange aux parfums', part.name_en = 'Les Corps glorieux: III. L’Ange aux parfums',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 686 AND p.composer_id = 95 AND part.part_key = 'musicbrainz:a587f036-5882-43c1-8878-441aeab4ea1c' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:a587f036-5882-43c1-8878-441aeab4ea1c', 3, 'III', 'L’Ange aux parfums', 'Les Corps glorieux: III. L’Ange aux parfums', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 686 AND p.composer_id = 95
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:a587f036-5882-43c1-8878-441aeab4ea1c'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = 'IV',
    part.name_ko = 'Combat de la mort et de la vie', part.name_en = 'Les Corps glorieux: IV. Combat de la mort et de la vie',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 686 AND p.composer_id = 95 AND part.part_key = 'musicbrainz:84764482-b4f3-40d6-9a68-6e8dbee647b5' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:84764482-b4f3-40d6-9a68-6e8dbee647b5', 4, 'IV', 'Combat de la mort et de la vie', 'Les Corps glorieux: IV. Combat de la mort et de la vie', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 686 AND p.composer_id = 95
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:84764482-b4f3-40d6-9a68-6e8dbee647b5'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 5, part.movement_number = 'V',
    part.name_ko = 'Force et Agilité des Corps glorieux', part.name_en = 'Les Corps glorieux: V. Force et Agilité des Corps glorieux',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 686 AND p.composer_id = 95 AND part.part_key = 'musicbrainz:67b6efa6-c5d3-4fd7-a1be-55e4a94ae4be' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:67b6efa6-c5d3-4fd7-a1be-55e4a94ae4be', 5, 'V', 'Force et Agilité des Corps glorieux', 'Les Corps glorieux: V. Force et Agilité des Corps glorieux', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 686 AND p.composer_id = 95
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:67b6efa6-c5d3-4fd7-a1be-55e4a94ae4be'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 6, part.movement_number = 'VI',
    part.name_ko = 'Joie et clarté des Corps glorieux', part.name_en = 'Les Corps glorieux: VI. Joie et clarté des Corps glorieux',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 686 AND p.composer_id = 95 AND part.part_key = 'musicbrainz:9b77abf9-e888-4476-97be-10ccddb53d3b' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:9b77abf9-e888-4476-97be-10ccddb53d3b', 6, 'VI', 'Joie et clarté des Corps glorieux', 'Les Corps glorieux: VI. Joie et clarté des Corps glorieux', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 686 AND p.composer_id = 95
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:9b77abf9-e888-4476-97be-10ccddb53d3b'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 7, part.movement_number = 'VII',
    part.name_ko = 'Le Mystère de la Sainte-Trinité', part.name_en = 'Les Corps glorieux: VII. Le Mystère de la Sainte-Trinité',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 686 AND p.composer_id = 95 AND part.part_key = 'musicbrainz:1a0c49d7-49ef-47c3-8f0d-184e0a900347' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:1a0c49d7-49ef-47c3-8f0d-184e0a900347', 7, 'VII', 'Le Mystère de la Sainte-Trinité', 'Les Corps glorieux: VII. Le Mystère de la Sainte-Trinité', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 686 AND p.composer_id = 95
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:1a0c49d7-49ef-47c3-8f0d-184e0a900347'
);


-- None Les Offrandes oubliées, I/5

UPDATE pieces piece
SET piece.title = 'Les Offrandes oubliées, I/5', piece.title_en = 'Les Offrandes oubliées, I/5',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 698 AND piece.composer_id = 95
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'La Croix', part.name_en = 'Les Offrandes oubliées, I/5: I. La Croix',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 698 AND p.composer_id = 95 AND part.part_key = 'musicbrainz:51924d72-ec00-4174-b73d-537273749dcf' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:51924d72-ec00-4174-b73d-537273749dcf', 1, 'I', 'La Croix', 'Les Offrandes oubliées, I/5: I. La Croix', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 698 AND p.composer_id = 95
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:51924d72-ec00-4174-b73d-537273749dcf'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'Le Péché', part.name_en = 'Les Offrandes oubliées, I/5: II. Le Péché',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 698 AND p.composer_id = 95 AND part.part_key = 'musicbrainz:6b43efe0-d011-468e-a307-e25aecd4709f' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:6b43efe0-d011-468e-a307-e25aecd4709f', 2, 'II', 'Le Péché', 'Les Offrandes oubliées, I/5: II. Le Péché', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 698 AND p.composer_id = 95
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:6b43efe0-d011-468e-a307-e25aecd4709f'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = 'L''Eucharistie', part.name_en = 'Les Offrandes oubliées, I/5: III. L''Eucharistie',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 698 AND p.composer_id = 95 AND part.part_key = 'musicbrainz:eceb5ccc-487a-4818-b297-5d1696300ae4' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:eceb5ccc-487a-4818-b297-5d1696300ae4', 3, 'III', 'L''Eucharistie', 'Les Offrandes oubliées, I/5: III. L''Eucharistie', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 698 AND p.composer_id = 95
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:eceb5ccc-487a-4818-b297-5d1696300ae4'
);


-- None Livre du Saint Sacrement

UPDATE pieces piece
SET piece.title = 'Livre du Saint Sacrement', piece.title_en = 'Livre du Saint Sacrement',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 711 AND piece.composer_id = 95
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'Adoro te', part.name_en = 'Livre du Saint Sacrement: Adoro te',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 711 AND p.composer_id = 95 AND part.part_key = 'musicbrainz:b1b994d5-d3ae-455d-9183-47b6639b68f9' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:b1b994d5-d3ae-455d-9183-47b6639b68f9', 1, NULL, 'Adoro te', 'Livre du Saint Sacrement: Adoro te', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 711 AND p.composer_id = 95
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:b1b994d5-d3ae-455d-9183-47b6639b68f9'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'Le Source de vie', part.name_en = 'Livre du Saint Sacrement: Le Source de vie',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 711 AND p.composer_id = 95 AND part.part_key = 'musicbrainz:c65219c7-67eb-4351-94f0-130954141d6a' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:c65219c7-67eb-4351-94f0-130954141d6a', 2, NULL, 'Le Source de vie', 'Livre du Saint Sacrement: Le Source de vie', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 711 AND p.composer_id = 95
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:c65219c7-67eb-4351-94f0-130954141d6a'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = NULL,
    part.name_ko = 'Le Dieu caché', part.name_en = 'Livre du Saint Sacrement: Le Dieu caché',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 711 AND p.composer_id = 95 AND part.part_key = 'musicbrainz:99c02cbf-ad3d-45ab-8fff-1bac34f9c169' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:99c02cbf-ad3d-45ab-8fff-1bac34f9c169', 3, NULL, 'Le Dieu caché', 'Livre du Saint Sacrement: Le Dieu caché', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 711 AND p.composer_id = 95
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:99c02cbf-ad3d-45ab-8fff-1bac34f9c169'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = NULL,
    part.name_ko = 'Acte de foi', part.name_en = 'Livre du Saint Sacrement: Acte de foi',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 711 AND p.composer_id = 95 AND part.part_key = 'musicbrainz:f64a8de1-476f-4b8a-b5fa-dc9cdfa24bc9' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:f64a8de1-476f-4b8a-b5fa-dc9cdfa24bc9', 4, NULL, 'Acte de foi', 'Livre du Saint Sacrement: Acte de foi', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 711 AND p.composer_id = 95
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:f64a8de1-476f-4b8a-b5fa-dc9cdfa24bc9'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 5, part.movement_number = NULL,
    part.name_ko = 'Puer natus est nobis', part.name_en = 'Livre du Saint Sacrement: Puer natus est nobis',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 711 AND p.composer_id = 95 AND part.part_key = 'musicbrainz:4390a363-0d1f-40ee-a4a8-008a13c00da9' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:4390a363-0d1f-40ee-a4a8-008a13c00da9', 5, NULL, 'Puer natus est nobis', 'Livre du Saint Sacrement: Puer natus est nobis', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 711 AND p.composer_id = 95
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:4390a363-0d1f-40ee-a4a8-008a13c00da9'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 6, part.movement_number = NULL,
    part.name_ko = 'La Manne et le Pain de vie', part.name_en = 'Livre du Saint Sacrement: La Manne et le Pain de vie',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 711 AND p.composer_id = 95 AND part.part_key = 'musicbrainz:1f577cae-2031-45ae-b741-d80055407320' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:1f577cae-2031-45ae-b741-d80055407320', 6, NULL, 'La Manne et le Pain de vie', 'Livre du Saint Sacrement: La Manne et le Pain de vie', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 711 AND p.composer_id = 95
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:1f577cae-2031-45ae-b741-d80055407320'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 7, part.movement_number = NULL,
    part.name_ko = 'Les Ressuscités et la Lumière de vie', part.name_en = 'Livre du Saint Sacrement: Les Ressuscités et la Lumière de vie',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 711 AND p.composer_id = 95 AND part.part_key = 'musicbrainz:daa5f5f5-ef74-47d5-acf4-9ff5e65daf0f' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:daa5f5f5-ef74-47d5-acf4-9ff5e65daf0f', 7, NULL, 'Les Ressuscités et la Lumière de vie', 'Livre du Saint Sacrement: Les Ressuscités et la Lumière de vie', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 711 AND p.composer_id = 95
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:daa5f5f5-ef74-47d5-acf4-9ff5e65daf0f'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 8, part.movement_number = NULL,
    part.name_ko = 'Institution de l’eucharistie', part.name_en = 'Livre du Saint Sacrement: Institution de l’eucharistie',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 711 AND p.composer_id = 95 AND part.part_key = 'musicbrainz:16982789-38bc-43cd-be9e-4356cf7afda2' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:16982789-38bc-43cd-be9e-4356cf7afda2', 8, NULL, 'Institution de l’eucharistie', 'Livre du Saint Sacrement: Institution de l’eucharistie', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 711 AND p.composer_id = 95
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:16982789-38bc-43cd-be9e-4356cf7afda2'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 9, part.movement_number = NULL,
    part.name_ko = 'Les Ténèbres', part.name_en = 'Livre du Saint Sacrement: Les Ténèbres',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 711 AND p.composer_id = 95 AND part.part_key = 'musicbrainz:c8cd3575-d026-4468-80a6-95b69af599e1' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:c8cd3575-d026-4468-80a6-95b69af599e1', 9, NULL, 'Les Ténèbres', 'Livre du Saint Sacrement: Les Ténèbres', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 711 AND p.composer_id = 95
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:c8cd3575-d026-4468-80a6-95b69af599e1'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 10, part.movement_number = NULL,
    part.name_ko = 'La Résurrection du Christ', part.name_en = 'Livre du Saint Sacrement: La Résurrection du Christ',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 711 AND p.composer_id = 95 AND part.part_key = 'musicbrainz:d8993772-9f10-41e4-947a-9dc8b8abeb10' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:d8993772-9f10-41e4-947a-9dc8b8abeb10', 10, NULL, 'La Résurrection du Christ', 'Livre du Saint Sacrement: La Résurrection du Christ', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 711 AND p.composer_id = 95
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:d8993772-9f10-41e4-947a-9dc8b8abeb10'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 11, part.movement_number = NULL,
    part.name_ko = 'L’Apparition du Christ ressuscité à Marie-Madeleine', part.name_en = 'Livre du Saint Sacrement: L’Apparition du Christ ressuscité à Marie-Madeleine',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 711 AND p.composer_id = 95 AND part.part_key = 'musicbrainz:33bec241-fb8a-4b75-a2bd-91ecd04523b9' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:33bec241-fb8a-4b75-a2bd-91ecd04523b9', 11, NULL, 'L’Apparition du Christ ressuscité à Marie-Madeleine', 'Livre du Saint Sacrement: L’Apparition du Christ ressuscité à Marie-Madeleine', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 711 AND p.composer_id = 95
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:33bec241-fb8a-4b75-a2bd-91ecd04523b9'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 12, part.movement_number = NULL,
    part.name_ko = 'La Transsubstantiation', part.name_en = 'Livre du Saint Sacrement: La Transsubstantiation',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 711 AND p.composer_id = 95 AND part.part_key = 'musicbrainz:5c8306f5-e6d4-469a-ba74-1c54f23552a7' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:5c8306f5-e6d4-469a-ba74-1c54f23552a7', 12, NULL, 'La Transsubstantiation', 'Livre du Saint Sacrement: La Transsubstantiation', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 711 AND p.composer_id = 95
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:5c8306f5-e6d4-469a-ba74-1c54f23552a7'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 13, part.movement_number = NULL,
    part.name_ko = 'Les deux murailles d’eau', part.name_en = 'Livre du Saint Sacrement: Les deux murailles d’eau',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 711 AND p.composer_id = 95 AND part.part_key = 'musicbrainz:0526e92d-3e70-4cfe-b54b-3911ad09314d' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:0526e92d-3e70-4cfe-b54b-3911ad09314d', 13, NULL, 'Les deux murailles d’eau', 'Livre du Saint Sacrement: Les deux murailles d’eau', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 711 AND p.composer_id = 95
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:0526e92d-3e70-4cfe-b54b-3911ad09314d'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 14, part.movement_number = NULL,
    part.name_ko = 'Prière avant la communion', part.name_en = 'Livre du Saint Sacrement: Prière avant la communion',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 711 AND p.composer_id = 95 AND part.part_key = 'musicbrainz:e22ea9ff-66f7-4694-b9de-040aaa8a1711' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:e22ea9ff-66f7-4694-b9de-040aaa8a1711', 14, NULL, 'Prière avant la communion', 'Livre du Saint Sacrement: Prière avant la communion', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 711 AND p.composer_id = 95
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:e22ea9ff-66f7-4694-b9de-040aaa8a1711'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 15, part.movement_number = NULL,
    part.name_ko = 'La Joie de la grâce', part.name_en = 'Livre du Saint Sacrement: La Joie de la grâce',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 711 AND p.composer_id = 95 AND part.part_key = 'musicbrainz:dee641d4-1e60-4467-831a-7e9d61498fb4' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:dee641d4-1e60-4467-831a-7e9d61498fb4', 15, NULL, 'La Joie de la grâce', 'Livre du Saint Sacrement: La Joie de la grâce', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 711 AND p.composer_id = 95
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:dee641d4-1e60-4467-831a-7e9d61498fb4'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 16, part.movement_number = NULL,
    part.name_ko = 'Prière après la communion', part.name_en = 'Livre du Saint Sacrement: Prière après la communion',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 711 AND p.composer_id = 95 AND part.part_key = 'musicbrainz:56b42355-307e-45ad-8bcf-589e18c60aca' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:56b42355-307e-45ad-8bcf-589e18c60aca', 16, NULL, 'Prière après la communion', 'Livre du Saint Sacrement: Prière après la communion', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 711 AND p.composer_id = 95
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:56b42355-307e-45ad-8bcf-589e18c60aca'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 17, part.movement_number = NULL,
    part.name_ko = 'La Présence multipliée', part.name_en = 'Livre du Saint Sacrement: La Présence multipliée',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 711 AND p.composer_id = 95 AND part.part_key = 'musicbrainz:421e7a7d-03e0-4a0e-badc-bfd78be0b73b' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:421e7a7d-03e0-4a0e-badc-bfd78be0b73b', 17, NULL, 'La Présence multipliée', 'Livre du Saint Sacrement: La Présence multipliée', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 711 AND p.composer_id = 95
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:421e7a7d-03e0-4a0e-badc-bfd78be0b73b'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 18, part.movement_number = NULL,
    part.name_ko = 'Offrande et alleluia final', part.name_en = 'Livre du Saint Sacrement: Offrande et alleluia final',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 711 AND p.composer_id = 95 AND part.part_key = 'musicbrainz:f14b71d4-b11a-4e92-8cc1-f2de8b4b6ff3' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:f14b71d4-b11a-4e92-8cc1-f2de8b4b6ff3', 18, NULL, 'Offrande et alleluia final', 'Livre du Saint Sacrement: Offrande et alleluia final', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 711 AND p.composer_id = 95
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:f14b71d4-b11a-4e92-8cc1-f2de8b4b6ff3'
);


-- None Livre d’orgue

UPDATE pieces piece
SET piece.title = 'Livre d’orgue', piece.title_en = 'Livre d’orgue',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 692 AND piece.composer_id = 95
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'Reprises par interversion', part.name_en = 'Livre d’orgue: I. Reprises par interversion',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 692 AND p.composer_id = 95 AND part.part_key = 'musicbrainz:d9bf32e9-cb96-4778-a475-485b3a62c6bb' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:d9bf32e9-cb96-4778-a475-485b3a62c6bb', 1, 'I', 'Reprises par interversion', 'Livre d’orgue: I. Reprises par interversion', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 692 AND p.composer_id = 95
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:d9bf32e9-cb96-4778-a475-485b3a62c6bb'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'Première pièce en trio', part.name_en = 'Livre d’orgue: II. Première pièce en trio',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 692 AND p.composer_id = 95 AND part.part_key = 'musicbrainz:97b9251d-8f3c-466f-81cb-79682125a967' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:97b9251d-8f3c-466f-81cb-79682125a967', 2, 'II', 'Première pièce en trio', 'Livre d’orgue: II. Première pièce en trio', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 692 AND p.composer_id = 95
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:97b9251d-8f3c-466f-81cb-79682125a967'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = 'Les Mains de l’abîme', part.name_en = 'Livre d’orgue: III. Les Mains de l’abîme',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 692 AND p.composer_id = 95 AND part.part_key = 'musicbrainz:10dd204f-4845-4f52-9b88-dac73ade4699' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:10dd204f-4845-4f52-9b88-dac73ade4699', 3, 'III', 'Les Mains de l’abîme', 'Livre d’orgue: III. Les Mains de l’abîme', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 692 AND p.composer_id = 95
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:10dd204f-4845-4f52-9b88-dac73ade4699'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = 'IV',
    part.name_ko = 'Chants d’oiseaux', part.name_en = 'Livre d’orgue: IV. Chants d’oiseaux',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 692 AND p.composer_id = 95 AND part.part_key = 'musicbrainz:dcb1277c-123e-4b43-9fd5-656d4e72ea9b' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:dcb1277c-123e-4b43-9fd5-656d4e72ea9b', 4, 'IV', 'Chants d’oiseaux', 'Livre d’orgue: IV. Chants d’oiseaux', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 692 AND p.composer_id = 95
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:dcb1277c-123e-4b43-9fd5-656d4e72ea9b'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 5, part.movement_number = 'V',
    part.name_ko = 'Deuxième pièce en trio', part.name_en = 'Livre d’orgue: V. Deuxième pièce en trio',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 692 AND p.composer_id = 95 AND part.part_key = 'musicbrainz:bab370b2-93e3-4230-9091-e25a40ada5fe' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:bab370b2-93e3-4230-9091-e25a40ada5fe', 5, 'V', 'Deuxième pièce en trio', 'Livre d’orgue: V. Deuxième pièce en trio', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 692 AND p.composer_id = 95
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:bab370b2-93e3-4230-9091-e25a40ada5fe'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 6, part.movement_number = 'VI',
    part.name_ko = 'Les Yeux dans les roues', part.name_en = 'Livre d’orgue: VI. Les Yeux dans les roues',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 692 AND p.composer_id = 95 AND part.part_key = 'musicbrainz:6b78a049-0d4e-4df5-a1e1-b82bbd875786' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:6b78a049-0d4e-4df5-a1e1-b82bbd875786', 6, 'VI', 'Les Yeux dans les roues', 'Livre d’orgue: VI. Les Yeux dans les roues', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 692 AND p.composer_id = 95
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:6b78a049-0d4e-4df5-a1e1-b82bbd875786'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 7, part.movement_number = 'VII',
    part.name_ko = 'Soixante-quatre durées', part.name_en = 'Livre d’orgue: VII. Soixante-quatre durées',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 692 AND p.composer_id = 95 AND part.part_key = 'musicbrainz:867bd8b1-cafb-4db1-9e36-ea2fb60ef8c9' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:867bd8b1-cafb-4db1-9e36-ea2fb60ef8c9', 7, 'VII', 'Soixante-quatre durées', 'Livre d’orgue: VII. Soixante-quatre durées', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 692 AND p.composer_id = 95
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:867bd8b1-cafb-4db1-9e36-ea2fb60ef8c9'
);


-- None Messe de la Pentecôte

UPDATE pieces piece
SET piece.title = 'Messe de la Pentecôte', piece.title_en = 'Messe de la Pentecôte',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 695 AND piece.composer_id = 95
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'Entrée', part.name_en = 'Messe de la Pentecôte: I. Entrée',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 695 AND p.composer_id = 95 AND part.part_key = 'musicbrainz:a32f17e0-5776-48b1-81ae-ce9bb629defc' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:a32f17e0-5776-48b1-81ae-ce9bb629defc', 1, 'I', 'Entrée', 'Messe de la Pentecôte: I. Entrée', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 695 AND p.composer_id = 95
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:a32f17e0-5776-48b1-81ae-ce9bb629defc'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'Offertoire', part.name_en = 'Messe de la Pentecôte: II. Offertoire',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 695 AND p.composer_id = 95 AND part.part_key = 'musicbrainz:5c195f0d-e3b2-4188-942e-a46a127a7b72' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:5c195f0d-e3b2-4188-942e-a46a127a7b72', 2, 'II', 'Offertoire', 'Messe de la Pentecôte: II. Offertoire', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 695 AND p.composer_id = 95
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:5c195f0d-e3b2-4188-942e-a46a127a7b72'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = 'Consécration', part.name_en = 'Messe de la Pentecôte: III. Consécration',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 695 AND p.composer_id = 95 AND part.part_key = 'musicbrainz:a3818563-6249-44a4-8cc6-f47b6cde5336' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:a3818563-6249-44a4-8cc6-f47b6cde5336', 3, 'III', 'Consécration', 'Messe de la Pentecôte: III. Consécration', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 695 AND p.composer_id = 95
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:a3818563-6249-44a4-8cc6-f47b6cde5336'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = 'IV',
    part.name_ko = 'Communion', part.name_en = 'Messe de la Pentecôte: IV. Communion',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 695 AND p.composer_id = 95 AND part.part_key = 'musicbrainz:c49544c3-b10a-4b7a-84ad-1c5645ad16d9' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:c49544c3-b10a-4b7a-84ad-1c5645ad16d9', 4, 'IV', 'Communion', 'Messe de la Pentecôte: IV. Communion', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 695 AND p.composer_id = 95
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:c49544c3-b10a-4b7a-84ad-1c5645ad16d9'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 5, part.movement_number = 'V',
    part.name_ko = 'Sortie', part.name_en = 'Messe de la Pentecôte: V. Sortie',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 695 AND p.composer_id = 95 AND part.part_key = 'musicbrainz:a239e8c3-72a3-46d4-b558-0253d2808d5b' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:a239e8c3-72a3-46d4-b558-0253d2808d5b', 5, 'V', 'Sortie', 'Messe de la Pentecôte: V. Sortie', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 695 AND p.composer_id = 95
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:a239e8c3-72a3-46d4-b558-0253d2808d5b'
);


-- None Monodie, I/45a

UPDATE pieces piece
SET piece.title = 'Monodie, I/45a', piece.title_en = 'Monodie, I/45a',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 718 AND piece.composer_id = 95
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Morceau de lecture à vue

UPDATE pieces piece
SET piece.title = 'Morceau de lecture à vue', piece.title_en = 'Morceau de lecture à vue',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 2758 AND piece.composer_id = 95
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Méditations sur le Mystère de la Sainte Trinité

UPDATE pieces piece
SET piece.title = 'Méditations sur le Mystère de la Sainte Trinité', piece.title_en = 'Méditations sur le Mystère de la Sainte Trinité',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 693 AND piece.composer_id = 95
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'I', part.name_en = 'Méditations sur le Mystère de la Sainte Trinité: I.',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 693 AND p.composer_id = 95 AND part.part_key = 'musicbrainz:1f696f25-4a93-4505-b657-1e4e29810fe1' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:1f696f25-4a93-4505-b657-1e4e29810fe1', 1, NULL, 'I', 'Méditations sur le Mystère de la Sainte Trinité: I.', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 693 AND p.composer_id = 95
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:1f696f25-4a93-4505-b657-1e4e29810fe1'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'II', part.name_en = 'Méditations sur le Mystère de la Sainte Trinité: II.',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 693 AND p.composer_id = 95 AND part.part_key = 'musicbrainz:c3bca52a-ba7d-4dbc-8e18-6f9bf25b3818' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:c3bca52a-ba7d-4dbc-8e18-6f9bf25b3818', 2, NULL, 'II', 'Méditations sur le Mystère de la Sainte Trinité: II.', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 693 AND p.composer_id = 95
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:c3bca52a-ba7d-4dbc-8e18-6f9bf25b3818'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = NULL,
    part.name_ko = 'III', part.name_en = 'Méditations sur le Mystère de la Sainte Trinité: III.',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 693 AND p.composer_id = 95 AND part.part_key = 'musicbrainz:0e1906d2-a6c7-4674-9970-caf7d818e72b' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:0e1906d2-a6c7-4674-9970-caf7d818e72b', 3, NULL, 'III', 'Méditations sur le Mystère de la Sainte Trinité: III.', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 693 AND p.composer_id = 95
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:0e1906d2-a6c7-4674-9970-caf7d818e72b'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = NULL,
    part.name_ko = 'IV', part.name_en = 'Méditations sur le Mystère de la Sainte Trinité: IV.',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 693 AND p.composer_id = 95 AND part.part_key = 'musicbrainz:2bbd8c89-9449-4662-b0a6-93a681618653' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:2bbd8c89-9449-4662-b0a6-93a681618653', 4, NULL, 'IV', 'Méditations sur le Mystère de la Sainte Trinité: IV.', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 693 AND p.composer_id = 95
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:2bbd8c89-9449-4662-b0a6-93a681618653'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 5, part.movement_number = NULL,
    part.name_ko = 'V', part.name_en = 'Méditations sur le Mystère de la Sainte Trinité: V.',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 693 AND p.composer_id = 95 AND part.part_key = 'musicbrainz:93a8f412-2a8d-4a1a-8d6e-c32cd28e8e96' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:93a8f412-2a8d-4a1a-8d6e-c32cd28e8e96', 5, NULL, 'V', 'Méditations sur le Mystère de la Sainte Trinité: V.', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 693 AND p.composer_id = 95
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:93a8f412-2a8d-4a1a-8d6e-c32cd28e8e96'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 6, part.movement_number = NULL,
    part.name_ko = 'VI', part.name_en = 'Méditations sur le Mystère de la Sainte Trinité: VI.',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 693 AND p.composer_id = 95 AND part.part_key = 'musicbrainz:10bc3f5d-53e0-4cde-a335-bae0295e80a4' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:10bc3f5d-53e0-4cde-a335-bae0295e80a4', 6, NULL, 'VI', 'Méditations sur le Mystère de la Sainte Trinité: VI.', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 693 AND p.composer_id = 95
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:10bc3f5d-53e0-4cde-a335-bae0295e80a4'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 7, part.movement_number = NULL,
    part.name_ko = 'VII', part.name_en = 'Méditations sur le Mystère de la Sainte Trinité: VII.',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 693 AND p.composer_id = 95 AND part.part_key = 'musicbrainz:90ca0177-55ed-4409-8c37-b645311d1899' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:90ca0177-55ed-4409-8c37-b645311d1899', 7, NULL, 'VII', 'Méditations sur le Mystère de la Sainte Trinité: VII.', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 693 AND p.composer_id = 95
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:90ca0177-55ed-4409-8c37-b645311d1899'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 8, part.movement_number = NULL,
    part.name_ko = 'VIII', part.name_en = 'Méditations sur le Mystère de la Sainte Trinité: VIII.',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 693 AND p.composer_id = 95 AND part.part_key = 'musicbrainz:02819ae9-e824-4e0a-8f75-6a993384d47e' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:02819ae9-e824-4e0a-8f75-6a993384d47e', 8, NULL, 'VIII', 'Méditations sur le Mystère de la Sainte Trinité: VIII.', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 693 AND p.composer_id = 95
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:02819ae9-e824-4e0a-8f75-6a993384d47e'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 9, part.movement_number = NULL,
    part.name_ko = 'IX', part.name_en = 'Méditations sur le Mystère de la Sainte Trinité: IX.',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 693 AND p.composer_id = 95 AND part.part_key = 'musicbrainz:95826a2e-76cf-4c6a-8a64-a59faf8e2766' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:95826a2e-76cf-4c6a-8a64-a59faf8e2766', 9, NULL, 'IX', 'Méditations sur le Mystère de la Sainte Trinité: IX.', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 693 AND p.composer_id = 95
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:95826a2e-76cf-4c6a-8a64-a59faf8e2766'
);


-- None Offrande au Saint-Sacrement

UPDATE pieces piece
SET piece.title = 'Offrande au Saint-Sacrement', piece.title_en = 'Offrande au Saint-Sacrement',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 720 AND piece.composer_id = 95
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Oiseaux exotiques, I/41

UPDATE pieces piece
SET piece.title = 'Oiseaux exotiques, I/41', piece.title_en = 'Oiseaux exotiques, I/41',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 820 AND piece.composer_id = 95
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Oraison

UPDATE pieces piece
SET piece.title = 'Oraison', piece.title_en = 'Oraison',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 1937 AND piece.composer_id = 95
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Petites esquisses d'oiseaux, I/54

UPDATE pieces piece
SET piece.title = 'Petites esquisses d''oiseaux, I/54', piece.title_en = 'Petites esquisses d''oiseaux, I/54',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 712 AND piece.composer_id = 95
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'Le rouge-gorge', part.name_en = 'Petites esquisses d''oiseaux, I/54: I. Le rouge-gorge',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 712 AND p.composer_id = 95 AND part.part_key = 'musicbrainz:42c9b6ec-16d9-3644-bf4f-c4b1ae08a4b6' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:42c9b6ec-16d9-3644-bf4f-c4b1ae08a4b6', 1, 'I', 'Le rouge-gorge', 'Petites esquisses d''oiseaux, I/54: I. Le rouge-gorge', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 712 AND p.composer_id = 95
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:42c9b6ec-16d9-3644-bf4f-c4b1ae08a4b6'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'Le merle-noir', part.name_en = 'Petites esquisses d''oiseaux, I/54: II. Le merle-noir',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 712 AND p.composer_id = 95 AND part.part_key = 'musicbrainz:e790f3bd-2647-3dd2-9705-ffea9cd2a700' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:e790f3bd-2647-3dd2-9705-ffea9cd2a700', 2, 'II', 'Le merle-noir', 'Petites esquisses d''oiseaux, I/54: II. Le merle-noir', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 712 AND p.composer_id = 95
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:e790f3bd-2647-3dd2-9705-ffea9cd2a700'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = 'Le rouge-gorge', part.name_en = 'Petites esquisses d''oiseaux, I/54: III. Le rouge-gorge',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 712 AND p.composer_id = 95 AND part.part_key = 'musicbrainz:89de3d3c-d061-363a-b441-50815e407a27' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:89de3d3c-d061-363a-b441-50815e407a27', 3, 'III', 'Le rouge-gorge', 'Petites esquisses d''oiseaux, I/54: III. Le rouge-gorge', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 712 AND p.composer_id = 95
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:89de3d3c-d061-363a-b441-50815e407a27'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = 'IV',
    part.name_ko = 'La grive-musicienne', part.name_en = 'Petites esquisses d''oiseaux, I/54: IV. La grive-musicienne',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 712 AND p.composer_id = 95 AND part.part_key = 'musicbrainz:25b705da-34e1-34db-ac2a-4069dea45181' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:25b705da-34e1-34db-ac2a-4069dea45181', 4, 'IV', 'La grive-musicienne', 'Petites esquisses d''oiseaux, I/54: IV. La grive-musicienne', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 712 AND p.composer_id = 95
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:25b705da-34e1-34db-ac2a-4069dea45181'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 5, part.movement_number = 'V',
    part.name_ko = 'Le rouge-gorge', part.name_en = 'Petites esquisses d''oiseaux, I/54: V. Le rouge-gorge',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 712 AND p.composer_id = 95 AND part.part_key = 'musicbrainz:a644dd7a-b114-3682-90fe-d07a3f7d1261' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:a644dd7a-b114-3682-90fe-d07a3f7d1261', 5, 'V', 'Le rouge-gorge', 'Petites esquisses d''oiseaux, I/54: V. Le rouge-gorge', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 712 AND p.composer_id = 95
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:a644dd7a-b114-3682-90fe-d07a3f7d1261'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 6, part.movement_number = 'VI',
    part.name_ko = 'L''alouette des champs', part.name_en = 'Petites esquisses d''oiseaux, I/54: VI. L''alouette des champs',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 712 AND p.composer_id = 95 AND part.part_key = 'musicbrainz:87308d89-0de8-3f49-8fd6-bd6b22d81f4e' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:87308d89-0de8-3f49-8fd6-bd6b22d81f4e', 6, 'VI', 'L''alouette des champs', 'Petites esquisses d''oiseaux, I/54: VI. L''alouette des champs', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 712 AND p.composer_id = 95
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:87308d89-0de8-3f49-8fd6-bd6b22d81f4e'
);


-- None Pièce pour le tombeau de Paul Dukas, I/16

UPDATE pieces piece
SET piece.title = 'Pièce pour le tombeau de Paul Dukas, I/16', piece.title_en = 'Pièce pour le tombeau de Paul Dukas, I/16',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 2795 AND piece.composer_id = 95
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Pièce pour orgue sur un thème de Laparra

UPDATE pieces piece
SET piece.title = 'Pièce pour orgue sur un thème de Laparra', piece.title_en = 'Pièce pour orgue sur un thème de Laparra',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 2366 AND piece.composer_id = 95
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Pièce pour piano et quatuor à cordes

UPDATE pieces piece
SET piece.title = 'Pièce pour piano et quatuor à cordes', piece.title_en = 'Pièce pour piano et quatuor à cordes',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 1577 AND piece.composer_id = 95
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Prelude pour piano

UPDATE pieces piece
SET piece.title = 'Prelude pour piano', piece.title_en = 'Prelude pour piano',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 1051 AND piece.composer_id = 95
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Prélude pour orgue

UPDATE pieces piece
SET piece.title = 'Prélude pour orgue', piece.title_en = 'Prélude pour orgue',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 1357 AND piece.composer_id = 95
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Quatre Études de rythme

UPDATE pieces piece
SET piece.title = 'Quatre Études de rythme', piece.title_en = 'Quatre Études de rythme',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 1015 AND piece.composer_id = 95
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'Île de feu 1', part.name_en = 'Quatre Études de rythme: No. 1. Île de feu 1',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 1015 AND p.composer_id = 95 AND part.part_key = 'musicbrainz:c8a632b6-52b4-48ba-ade0-413d275fbe33' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:c8a632b6-52b4-48ba-ade0-413d275fbe33', 1, NULL, 'Île de feu 1', 'Quatre Études de rythme: No. 1. Île de feu 1', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 1015 AND p.composer_id = 95
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:c8a632b6-52b4-48ba-ade0-413d275fbe33'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'Mode de valeurs et d''intensités', part.name_en = 'Quatre Études de rythme: No. 2. Mode de valeurs et d''intensités',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 1015 AND p.composer_id = 95 AND part.part_key = 'musicbrainz:bff8fe12-0577-38c3-b494-d3da10cb4766' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:bff8fe12-0577-38c3-b494-d3da10cb4766', 2, NULL, 'Mode de valeurs et d''intensités', 'Quatre Études de rythme: No. 2. Mode de valeurs et d''intensités', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 1015 AND p.composer_id = 95
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:bff8fe12-0577-38c3-b494-d3da10cb4766'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = NULL,
    part.name_ko = 'Neumes rhythmiques', part.name_en = 'Quatre Études de rythme: No. 3. Neumes rhythmiques',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 1015 AND p.composer_id = 95 AND part.part_key = 'musicbrainz:8733fef4-55cc-3b86-9665-aea814948200' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:8733fef4-55cc-3b86-9665-aea814948200', 3, NULL, 'Neumes rhythmiques', 'Quatre Études de rythme: No. 3. Neumes rhythmiques', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 1015 AND p.composer_id = 95
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:8733fef4-55cc-3b86-9665-aea814948200'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = NULL,
    part.name_ko = 'Île de feu 2', part.name_en = 'Quatre Études de rythme: No. 4. Île de feu 2',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 1015 AND p.composer_id = 95 AND part.part_key = 'musicbrainz:5a26c66f-a0f8-4aac-8cf3-80534bfae866' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:5a26c66f-a0f8-4aac-8cf3-80534bfae866', 4, NULL, 'Île de feu 2', 'Quatre Études de rythme: No. 4. Île de feu 2', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 1015 AND p.composer_id = 95
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:5a26c66f-a0f8-4aac-8cf3-80534bfae866'
);


-- None Réveil des oiseaux

UPDATE pieces piece
SET piece.title = 'Réveil des oiseaux', piece.title_en = 'Réveil des oiseaux',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 501 AND piece.composer_id = 95
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None 오페라 <Saint François d'Assise>

UPDATE pieces piece
SET piece.title = '오페라 <Saint François d''Assise>', piece.title_en = 'Saint François d''Assise',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 2141 AND piece.composer_id = 95
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'Acte I', part.name_en = 'Saint François d''Assise: Acte I',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 2141 AND p.composer_id = 95 AND part.part_key = 'musicbrainz:08981042-7761-413a-b416-20f1eafb0f33' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:08981042-7761-413a-b416-20f1eafb0f33', 1, NULL, 'Acte I', 'Saint François d''Assise: Acte I', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 2141 AND p.composer_id = 95
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:08981042-7761-413a-b416-20f1eafb0f33'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'Acte II', part.name_en = 'Saint François d''Assise: Acte II',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 2141 AND p.composer_id = 95 AND part.part_key = 'musicbrainz:50d0a477-e7c3-4367-a981-eb4db44fc0b7' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:50d0a477-e7c3-4367-a981-eb4db44fc0b7', 2, NULL, 'Acte II', 'Saint François d''Assise: Acte II', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 2141 AND p.composer_id = 95
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:50d0a477-e7c3-4367-a981-eb4db44fc0b7'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:50d0a477-e7c3-4367-a981-eb4db44fc0b7'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'Tableau 6. Le Prêche aux Oiseaux', part.name_en = 'Saint François d''Assise: Acte II: Tableau 6. Le Prêche aux Oiseaux',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 2141 AND p.composer_id = 95 AND part.part_key = 'musicbrainz:2e017f6b-c418-4645-ac05-9af9b77ae9c8' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:2e017f6b-c418-4645-ac05-9af9b77ae9c8', 1, NULL, 'Tableau 6. Le Prêche aux Oiseaux', 'Saint François d''Assise: Acte II: Tableau 6. Le Prêche aux Oiseaux', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:50d0a477-e7c3-4367-a981-eb4db44fc0b7'
WHERE p.id = 2141 AND p.composer_id = 95
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:2e017f6b-c418-4645-ac05-9af9b77ae9c8'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = NULL,
    part.name_ko = 'Acte III', part.name_en = 'Saint François d''Assise: Acte III',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 2141 AND p.composer_id = 95 AND part.part_key = 'musicbrainz:ae3d01f7-782d-4604-9dc7-38856e51c5c5' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:ae3d01f7-782d-4604-9dc7-38856e51c5c5', 3, NULL, 'Acte III', 'Saint François d''Assise: Acte III', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 2141 AND p.composer_id = 95
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:ae3d01f7-782d-4604-9dc7-38856e51c5c5'
);


-- None Sept haïkaï

UPDATE pieces piece
SET piece.title = 'Sept haïkaï', piece.title_en = 'Sept haïkaï',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 1482 AND piece.composer_id = 95
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'Introduction', part.name_en = 'Sept haïkaï: I. Introduction',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 1482 AND p.composer_id = 95 AND part.part_key = 'musicbrainz:550045cd-3073-420b-9381-c9c378267e38' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:550045cd-3073-420b-9381-c9c378267e38', 1, 'I', 'Introduction', 'Sept haïkaï: I. Introduction', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 1482 AND p.composer_id = 95
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:550045cd-3073-420b-9381-c9c378267e38'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'Le Parc de Nara et les lanternes de pierre', part.name_en = 'Sept haïkaï: II. Le Parc de Nara et les lanternes de pierre',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 1482 AND p.composer_id = 95 AND part.part_key = 'musicbrainz:5dfc72ff-5782-479c-a056-1c2c00cbaaef' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:5dfc72ff-5782-479c-a056-1c2c00cbaaef', 2, 'II', 'Le Parc de Nara et les lanternes de pierre', 'Sept haïkaï: II. Le Parc de Nara et les lanternes de pierre', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 1482 AND p.composer_id = 95
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:5dfc72ff-5782-479c-a056-1c2c00cbaaef'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = 'Yamanaka - Cadenza', part.name_en = 'Sept haïkaï: III. Yamanaka - Cadenza',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 1482 AND p.composer_id = 95 AND part.part_key = 'musicbrainz:1a049881-2d1c-4476-9f95-fac0c0747a33' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:1a049881-2d1c-4476-9f95-fac0c0747a33', 3, 'III', 'Yamanaka - Cadenza', 'Sept haïkaï: III. Yamanaka - Cadenza', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 1482 AND p.composer_id = 95
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:1a049881-2d1c-4476-9f95-fac0c0747a33'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = 'IV',
    part.name_ko = 'Gagaku', part.name_en = 'Sept haïkaï: IV. Gagaku',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 1482 AND p.composer_id = 95 AND part.part_key = 'musicbrainz:47f1afc5-f803-4015-a22d-c5c0895df21f' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:47f1afc5-f803-4015-a22d-c5c0895df21f', 4, 'IV', 'Gagaku', 'Sept haïkaï: IV. Gagaku', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 1482 AND p.composer_id = 95
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:47f1afc5-f803-4015-a22d-c5c0895df21f'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 5, part.movement_number = 'V',
    part.name_ko = 'Miyajima et le torii dans la mer', part.name_en = 'Sept haïkaï: V. Miyajima et le torii dans la mer',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 1482 AND p.composer_id = 95 AND part.part_key = 'musicbrainz:7d59fcbb-e49f-4cbf-9eaf-6c89ec738aeb' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:7d59fcbb-e49f-4cbf-9eaf-6c89ec738aeb', 5, 'V', 'Miyajima et le torii dans la mer', 'Sept haïkaï: V. Miyajima et le torii dans la mer', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 1482 AND p.composer_id = 95
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:7d59fcbb-e49f-4cbf-9eaf-6c89ec738aeb'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 6, part.movement_number = 'VI',
    part.name_ko = 'Les Oiseaux de Karuizawa', part.name_en = 'Sept haïkaï: VI. Les Oiseaux de Karuizawa',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 1482 AND p.composer_id = 95 AND part.part_key = 'musicbrainz:a74377f6-4c7d-4411-b3e0-74fb7e75e0bb' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:a74377f6-4c7d-4411-b3e0-74fb7e75e0bb', 6, 'VI', 'Les Oiseaux de Karuizawa', 'Sept haïkaï: VI. Les Oiseaux de Karuizawa', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 1482 AND p.composer_id = 95
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:a74377f6-4c7d-4411-b3e0-74fb7e75e0bb'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 7, part.movement_number = 'VII',
    part.name_ko = 'Coda', part.name_en = 'Sept haïkaï: VII. Coda',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 1482 AND p.composer_id = 95 AND part.part_key = 'musicbrainz:277f86c5-a1d7-4fc0-bd2d-0ca79ec4c0c2' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:277f86c5-a1d7-4fc0-bd2d-0ca79ec4c0c2', 7, 'VII', 'Coda', 'Sept haïkaï: VII. Coda', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 1482 AND p.composer_id = 95
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:277f86c5-a1d7-4fc0-bd2d-0ca79ec4c0c2'
);


-- None Thème et variations

UPDATE pieces piece
SET piece.title = 'Thème et variations', piece.title_en = 'Thème et variations',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 703 AND piece.composer_id = 95
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'Thème. Modéré', part.name_en = 'Thème et variations: Thème. Modéré',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 703 AND p.composer_id = 95 AND part.part_key = 'musicbrainz:b6f59f36-5afa-3000-8924-8decb0e611da' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:b6f59f36-5afa-3000-8924-8decb0e611da', 1, NULL, 'Thème. Modéré', 'Thème et variations: Thème. Modéré', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 703 AND p.composer_id = 95
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:b6f59f36-5afa-3000-8924-8decb0e611da'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'Première variation. Modéré', part.name_en = 'Thème et variations: Première variation. Modéré',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 703 AND p.composer_id = 95 AND part.part_key = 'musicbrainz:d2a00166-b700-33ed-ac9e-e414757c4cd1' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:d2a00166-b700-33ed-ac9e-e414757c4cd1', 2, NULL, 'Première variation. Modéré', 'Thème et variations: Première variation. Modéré', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 703 AND p.composer_id = 95
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:d2a00166-b700-33ed-ac9e-e414757c4cd1'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = NULL,
    part.name_ko = 'Deuxième variation. Un peu moins modéré', part.name_en = 'Thème et variations: Deuxième variation. Un peu moins modéré',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 703 AND p.composer_id = 95 AND part.part_key = 'musicbrainz:51d1faec-1e0a-3bdd-be38-7cf30f079089' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:51d1faec-1e0a-3bdd-be38-7cf30f079089', 3, NULL, 'Deuxième variation. Un peu moins modéré', 'Thème et variations: Deuxième variation. Un peu moins modéré', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 703 AND p.composer_id = 95
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:51d1faec-1e0a-3bdd-be38-7cf30f079089'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = NULL,
    part.name_ko = 'Troisième variation. Modéré, avec éclat', part.name_en = 'Thème et variations: Troisième variation. Modéré, avec éclat',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 703 AND p.composer_id = 95 AND part.part_key = 'musicbrainz:2a78695b-419d-3427-a31f-71c157a9a44f' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:2a78695b-419d-3427-a31f-71c157a9a44f', 4, NULL, 'Troisième variation. Modéré, avec éclat', 'Thème et variations: Troisième variation. Modéré, avec éclat', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 703 AND p.composer_id = 95
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:2a78695b-419d-3427-a31f-71c157a9a44f'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 5, part.movement_number = NULL,
    part.name_ko = 'Quatrième variation. Vif et passionné', part.name_en = 'Thème et variations: Quatrième variation. Vif et passionné',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 703 AND p.composer_id = 95 AND part.part_key = 'musicbrainz:e806fff2-ee1e-39c7-b796-332a21c5928a' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:e806fff2-ee1e-39c7-b796-332a21c5928a', 5, NULL, 'Quatrième variation. Vif et passionné', 'Thème et variations: Quatrième variation. Vif et passionné', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 703 AND p.composer_id = 95
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:e806fff2-ee1e-39c7-b796-332a21c5928a'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 6, part.movement_number = NULL,
    part.name_ko = 'Cinquième variation. Très modéré', part.name_en = 'Thème et variations: Cinquième variation. Très modéré',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 703 AND p.composer_id = 95 AND part.part_key = 'musicbrainz:b4727ddc-c150-3ea0-bb91-e86879eb4bfe' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:b4727ddc-c150-3ea0-bb91-e86879eb4bfe', 6, NULL, 'Cinquième variation. Très modéré', 'Thème et variations: Cinquième variation. Très modéré', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 703 AND p.composer_id = 95
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:b4727ddc-c150-3ea0-bb91-e86879eb4bfe'
);


-- None Transportes de joie

UPDATE pieces piece
SET piece.title = 'Transportes de joie', piece.title_en = 'Transportes de joie',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 1183 AND piece.composer_id = 95
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Trois mélodies

UPDATE pieces piece
SET piece.title = 'Trois mélodies', piece.title_en = 'Trois mélodies',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 2273 AND piece.composer_id = 95
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'Pourquoi', part.name_en = 'Trois mélodies: I. Pourquoi',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 2273 AND p.composer_id = 95 AND part.part_key = 'musicbrainz:166d5e8d-5473-4061-83e5-2a6da2159e33' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:166d5e8d-5473-4061-83e5-2a6da2159e33', 1, 'I', 'Pourquoi', 'Trois mélodies: I. Pourquoi', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 2273 AND p.composer_id = 95
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:166d5e8d-5473-4061-83e5-2a6da2159e33'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'Le sourire', part.name_en = 'Trois mélodies: II. Le sourire',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 2273 AND p.composer_id = 95 AND part.part_key = 'musicbrainz:92bb6ecc-b43e-40e5-9e36-31a55c22854e' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:92bb6ecc-b43e-40e5-9e36-31a55c22854e', 2, 'II', 'Le sourire', 'Trois mélodies: II. Le sourire', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 2273 AND p.composer_id = 95
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:92bb6ecc-b43e-40e5-9e36-31a55c22854e'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = 'La Fiancée perdue', part.name_en = 'Trois mélodies: III. La Fiancée perdue',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 2273 AND p.composer_id = 95 AND part.part_key = 'musicbrainz:56a1090b-044a-4b7d-a927-57b8eee916f7' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:56a1090b-044a-4b7d-a927-57b8eee916f7', 3, 'III', 'La Fiancée perdue', 'Trois mélodies: III. La Fiancée perdue', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 2273 AND p.composer_id = 95
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:56a1090b-044a-4b7d-a927-57b8eee916f7'
);


-- None Trois petites liturgies de la présence divine

UPDATE pieces piece
SET piece.title = 'Trois petites liturgies de la présence divine', piece.title_en = 'Trois petites liturgies de la présence divine',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 704 AND piece.composer_id = 95
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'Antienne de la conversation intérieure', part.name_en = 'Trois petites liturgies de la présence divine: No. 1. Antienne de la conversation intérieure',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 704 AND p.composer_id = 95 AND part.part_key = 'musicbrainz:cc181336-d457-42b6-9d0b-15b8763f677c' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:cc181336-d457-42b6-9d0b-15b8763f677c', 1, NULL, 'Antienne de la conversation intérieure', 'Trois petites liturgies de la présence divine: No. 1. Antienne de la conversation intérieure', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 704 AND p.composer_id = 95
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:cc181336-d457-42b6-9d0b-15b8763f677c'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'Séquence du verbe, cantique divin', part.name_en = 'Trois petites liturgies de la présence divine: No. 2. Séquence du verbe, cantique divin',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 704 AND p.composer_id = 95 AND part.part_key = 'musicbrainz:84731e0b-39cc-4937-b693-532c91c47833' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:84731e0b-39cc-4937-b693-532c91c47833', 2, NULL, 'Séquence du verbe, cantique divin', 'Trois petites liturgies de la présence divine: No. 2. Séquence du verbe, cantique divin', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 704 AND p.composer_id = 95
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:84731e0b-39cc-4937-b693-532c91c47833'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = NULL,
    part.name_ko = 'Psalmodie de l’ubiquité par amour', part.name_en = 'Trois petites liturgies de la présence divine: No. 3. Psalmodie de l’ubiquité par amour',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 704 AND p.composer_id = 95 AND part.part_key = 'musicbrainz:470c08f3-bdab-4a2a-a70c-e83a2ed0e557' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:470c08f3-bdab-4a2a-a70c-e83a2ed0e557', 3, NULL, 'Psalmodie de l’ubiquité par amour', 'Trois petites liturgies de la présence divine: No. 3. Psalmodie de l’ubiquité par amour', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 704 AND p.composer_id = 95
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:470c08f3-bdab-4a2a-a70c-e83a2ed0e557'
);


-- None Un Vitrail et des oiseaux

UPDATE pieces piece
SET piece.title = 'Un Vitrail et des oiseaux', piece.title_en = 'Un Vitrail et des oiseaux',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 2227 AND piece.composer_id = 95
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Un sourire

UPDATE pieces piece
SET piece.title = 'Un sourire', piece.title_en = 'Un sourire',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 1971 AND piece.composer_id = 95
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Verset pour la Fête de la Dédicace

UPDATE pieces piece
SET piece.title = 'Verset pour la Fête de la Dédicace', piece.title_en = 'Verset pour la Fête de la Dédicace',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 1416 AND piece.composer_id = 95
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Vingt regards sur l’enfant Jésus

UPDATE pieces piece
SET piece.title = 'Vingt regards sur l’enfant Jésus', piece.title_en = 'Vingt regards sur l’enfant Jésus',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 656 AND piece.composer_id = 95
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'Regard du Père', part.name_en = 'Vingt regards sur l’enfant Jésus: I. Regard du Père',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 656 AND p.composer_id = 95 AND part.part_key = 'musicbrainz:0c554be6-347e-3bf8-8ae6-aeac239142b1' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:0c554be6-347e-3bf8-8ae6-aeac239142b1', 1, 'I', 'Regard du Père', 'Vingt regards sur l’enfant Jésus: I. Regard du Père', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 656 AND p.composer_id = 95
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:0c554be6-347e-3bf8-8ae6-aeac239142b1'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'Regard de l’étoile', part.name_en = 'Vingt regards sur l’enfant Jésus: II. Regard de l’étoile',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 656 AND p.composer_id = 95 AND part.part_key = 'musicbrainz:1bb305ea-5317-3f1c-bb92-8729ab0530d0' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:1bb305ea-5317-3f1c-bb92-8729ab0530d0', 2, 'II', 'Regard de l’étoile', 'Vingt regards sur l’enfant Jésus: II. Regard de l’étoile', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 656 AND p.composer_id = 95
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:1bb305ea-5317-3f1c-bb92-8729ab0530d0'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = 'L’échange', part.name_en = 'Vingt regards sur l’enfant Jésus: III. L’échange',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 656 AND p.composer_id = 95 AND part.part_key = 'musicbrainz:da7e29ee-306f-3b42-9ebf-7f7c2e344e32' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:da7e29ee-306f-3b42-9ebf-7f7c2e344e32', 3, 'III', 'L’échange', 'Vingt regards sur l’enfant Jésus: III. L’échange', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 656 AND p.composer_id = 95
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:da7e29ee-306f-3b42-9ebf-7f7c2e344e32'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = 'IV',
    part.name_ko = 'Regard de la Vierge', part.name_en = 'Vingt regards sur l’enfant Jésus: IV. Regard de la Vierge',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 656 AND p.composer_id = 95 AND part.part_key = 'musicbrainz:b2fb9be7-fbd3-3f22-b3c8-c61adfc4bdd5' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:b2fb9be7-fbd3-3f22-b3c8-c61adfc4bdd5', 4, 'IV', 'Regard de la Vierge', 'Vingt regards sur l’enfant Jésus: IV. Regard de la Vierge', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 656 AND p.composer_id = 95
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:b2fb9be7-fbd3-3f22-b3c8-c61adfc4bdd5'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 5, part.movement_number = 'V',
    part.name_ko = 'Regard du Fils sur le Fils', part.name_en = 'Vingt regards sur l’enfant Jésus: V. Regard du Fils sur le Fils',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 656 AND p.composer_id = 95 AND part.part_key = 'musicbrainz:4e1354e0-ca46-3baf-ba08-4bc0c96e9474' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:4e1354e0-ca46-3baf-ba08-4bc0c96e9474', 5, 'V', 'Regard du Fils sur le Fils', 'Vingt regards sur l’enfant Jésus: V. Regard du Fils sur le Fils', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 656 AND p.composer_id = 95
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:4e1354e0-ca46-3baf-ba08-4bc0c96e9474'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 6, part.movement_number = 'VI',
    part.name_ko = 'Par lui tout a été fait', part.name_en = 'Vingt regards sur l’enfant Jésus: VI. Par lui tout a été fait',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 656 AND p.composer_id = 95 AND part.part_key = 'musicbrainz:5dc27b46-d32c-3c02-8543-807ca4dc08e1' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:5dc27b46-d32c-3c02-8543-807ca4dc08e1', 6, 'VI', 'Par lui tout a été fait', 'Vingt regards sur l’enfant Jésus: VI. Par lui tout a été fait', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 656 AND p.composer_id = 95
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:5dc27b46-d32c-3c02-8543-807ca4dc08e1'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 7, part.movement_number = 'VII',
    part.name_ko = 'Regard de la Croix', part.name_en = 'Vingt regards sur l’enfant Jésus: VII. Regard de la Croix',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 656 AND p.composer_id = 95 AND part.part_key = 'musicbrainz:a9609545-1d42-3735-9a19-b1ff736e67c8' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:a9609545-1d42-3735-9a19-b1ff736e67c8', 7, 'VII', 'Regard de la Croix', 'Vingt regards sur l’enfant Jésus: VII. Regard de la Croix', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 656 AND p.composer_id = 95
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:a9609545-1d42-3735-9a19-b1ff736e67c8'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 8, part.movement_number = 'VIII',
    part.name_ko = 'Regard des hauteurs', part.name_en = 'Vingt regards sur l’enfant Jésus: VIII. Regard des hauteurs',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 656 AND p.composer_id = 95 AND part.part_key = 'musicbrainz:cf85fdf0-5327-3c08-aff0-ef10722d8e8e' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:cf85fdf0-5327-3c08-aff0-ef10722d8e8e', 8, 'VIII', 'Regard des hauteurs', 'Vingt regards sur l’enfant Jésus: VIII. Regard des hauteurs', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 656 AND p.composer_id = 95
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:cf85fdf0-5327-3c08-aff0-ef10722d8e8e'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 9, part.movement_number = 'IX',
    part.name_ko = 'Regard du temps', part.name_en = 'Vingt regards sur l’enfant Jésus: IX. Regard du temps',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 656 AND p.composer_id = 95 AND part.part_key = 'musicbrainz:e05add62-4051-3d13-8fff-a4ce49b48209' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:e05add62-4051-3d13-8fff-a4ce49b48209', 9, 'IX', 'Regard du temps', 'Vingt regards sur l’enfant Jésus: IX. Regard du temps', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 656 AND p.composer_id = 95
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:e05add62-4051-3d13-8fff-a4ce49b48209'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 10, part.movement_number = 'X',
    part.name_ko = 'Regard de l’Esprit de joie', part.name_en = 'Vingt regards sur l’enfant Jésus: X. Regard de l’Esprit de joie',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 656 AND p.composer_id = 95 AND part.part_key = 'musicbrainz:dd93dda7-7d53-3cf8-a76e-db134a7ee76d' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:dd93dda7-7d53-3cf8-a76e-db134a7ee76d', 10, 'X', 'Regard de l’Esprit de joie', 'Vingt regards sur l’enfant Jésus: X. Regard de l’Esprit de joie', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 656 AND p.composer_id = 95
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:dd93dda7-7d53-3cf8-a76e-db134a7ee76d'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 11, part.movement_number = 'XI',
    part.name_ko = 'Première communion de la Vierge', part.name_en = 'Vingt regards sur l’enfant Jésus: XI. Première communion de la Vierge',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 656 AND p.composer_id = 95 AND part.part_key = 'musicbrainz:b80f6c4e-de54-3e0f-be98-dc1ff59ed373' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:b80f6c4e-de54-3e0f-be98-dc1ff59ed373', 11, 'XI', 'Première communion de la Vierge', 'Vingt regards sur l’enfant Jésus: XI. Première communion de la Vierge', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 656 AND p.composer_id = 95
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:b80f6c4e-de54-3e0f-be98-dc1ff59ed373'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 12, part.movement_number = 'XII',
    part.name_ko = 'La parole toute-puissante', part.name_en = 'Vingt regards sur l’enfant Jésus: XII. La parole toute-puissante',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 656 AND p.composer_id = 95 AND part.part_key = 'musicbrainz:bed9fa1c-433d-30da-81b8-0fadc42fd580' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:bed9fa1c-433d-30da-81b8-0fadc42fd580', 12, 'XII', 'La parole toute-puissante', 'Vingt regards sur l’enfant Jésus: XII. La parole toute-puissante', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 656 AND p.composer_id = 95
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:bed9fa1c-433d-30da-81b8-0fadc42fd580'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 13, part.movement_number = 'XIII',
    part.name_ko = 'Noël', part.name_en = 'Vingt regards sur l’enfant Jésus: XIII. Noël',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 656 AND p.composer_id = 95 AND part.part_key = 'musicbrainz:15313327-3253-3c81-b2fc-4175339e43a4' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:15313327-3253-3c81-b2fc-4175339e43a4', 13, 'XIII', 'Noël', 'Vingt regards sur l’enfant Jésus: XIII. Noël', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 656 AND p.composer_id = 95
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:15313327-3253-3c81-b2fc-4175339e43a4'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 14, part.movement_number = 'XIV',
    part.name_ko = 'Regard des Anges', part.name_en = 'Vingt regards sur l’enfant Jésus: XIV. Regard des Anges',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 656 AND p.composer_id = 95 AND part.part_key = 'musicbrainz:6b4921e5-4c3e-3488-9f1b-c01b9a0b7205' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:6b4921e5-4c3e-3488-9f1b-c01b9a0b7205', 14, 'XIV', 'Regard des Anges', 'Vingt regards sur l’enfant Jésus: XIV. Regard des Anges', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 656 AND p.composer_id = 95
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:6b4921e5-4c3e-3488-9f1b-c01b9a0b7205'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 15, part.movement_number = 'XV',
    part.name_ko = 'Le baiser de l’enfant Jésus', part.name_en = 'Vingt regards sur l’enfant Jésus: XV. Le baiser de l’enfant Jésus',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 656 AND p.composer_id = 95 AND part.part_key = 'musicbrainz:0912bca8-28c9-358b-a16d-ff674a00d9f2' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:0912bca8-28c9-358b-a16d-ff674a00d9f2', 15, 'XV', 'Le baiser de l’enfant Jésus', 'Vingt regards sur l’enfant Jésus: XV. Le baiser de l’enfant Jésus', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 656 AND p.composer_id = 95
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:0912bca8-28c9-358b-a16d-ff674a00d9f2'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 16, part.movement_number = 'XVI',
    part.name_ko = 'Regard des prophètes, des bergers et des mages', part.name_en = 'Vingt regards sur l’enfant Jésus: XVI. Regard des prophètes, des bergers et des mages',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 656 AND p.composer_id = 95 AND part.part_key = 'musicbrainz:19c912ce-a286-3701-89ef-45da731822c8' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:19c912ce-a286-3701-89ef-45da731822c8', 16, 'XVI', 'Regard des prophètes, des bergers et des mages', 'Vingt regards sur l’enfant Jésus: XVI. Regard des prophètes, des bergers et des mages', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 656 AND p.composer_id = 95
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:19c912ce-a286-3701-89ef-45da731822c8'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 17, part.movement_number = 'XVII',
    part.name_ko = 'Regard du silence', part.name_en = 'Vingt regards sur l’enfant Jésus: XVII. Regard du silence',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 656 AND p.composer_id = 95 AND part.part_key = 'musicbrainz:f706acc5-c0c3-3d56-b955-6c2cf59afb5a' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:f706acc5-c0c3-3d56-b955-6c2cf59afb5a', 17, 'XVII', 'Regard du silence', 'Vingt regards sur l’enfant Jésus: XVII. Regard du silence', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 656 AND p.composer_id = 95
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:f706acc5-c0c3-3d56-b955-6c2cf59afb5a'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 18, part.movement_number = 'XVIII',
    part.name_ko = 'Regard de l’onction terrible', part.name_en = 'Vingt regards sur l’enfant Jésus: XVIII. Regard de l’onction terrible',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 656 AND p.composer_id = 95 AND part.part_key = 'musicbrainz:77bc93dc-f861-32ea-9adc-3ebe1e942712' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:77bc93dc-f861-32ea-9adc-3ebe1e942712', 18, 'XVIII', 'Regard de l’onction terrible', 'Vingt regards sur l’enfant Jésus: XVIII. Regard de l’onction terrible', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 656 AND p.composer_id = 95
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:77bc93dc-f861-32ea-9adc-3ebe1e942712'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 19, part.movement_number = 'XIX',
    part.name_ko = 'Je dors, mais mon cœur veille', part.name_en = 'Vingt regards sur l’enfant Jésus: XIX. Je dors, mais mon cœur veille',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 656 AND p.composer_id = 95 AND part.part_key = 'musicbrainz:196fb21e-690a-34d5-ac08-b21b173c5e40' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:196fb21e-690a-34d5-ac08-b21b173c5e40', 19, 'XIX', 'Je dors, mais mon cœur veille', 'Vingt regards sur l’enfant Jésus: XIX. Je dors, mais mon cœur veille', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 656 AND p.composer_id = 95
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:196fb21e-690a-34d5-ac08-b21b173c5e40'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 20, part.movement_number = 'XX',
    part.name_ko = 'Regard de l’Église d’amour', part.name_en = 'Vingt regards sur l’enfant Jésus: XX. Regard de l’Église d’amour',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 656 AND p.composer_id = 95 AND part.part_key = 'musicbrainz:3c7b391d-63f7-38e4-bb8a-c9a94c89a050' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:3c7b391d-63f7-38e4-bb8a-c9a94c89a050', 20, 'XX', 'Regard de l’Église d’amour', 'Vingt regards sur l’enfant Jésus: XX. Regard de l’Église d’amour', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 656 AND p.composer_id = 95
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:3c7b391d-63f7-38e4-bb8a-c9a94c89a050'
);


-- None Visions de l’Amen, I/25

UPDATE pieces piece
SET piece.title = 'Visions de l’Amen, I/25', piece.title_en = 'Visions de l’Amen, I/25',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 706 AND piece.composer_id = 95
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'Amen de la création', part.name_en = 'Visions de l’Amen, I/25: I. Amen de la création',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 706 AND p.composer_id = 95 AND part.part_key = 'musicbrainz:53148acd-83b4-443b-941a-fddab4d08430' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:53148acd-83b4-443b-941a-fddab4d08430', 1, 'I', 'Amen de la création', 'Visions de l’Amen, I/25: I. Amen de la création', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 706 AND p.composer_id = 95
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:53148acd-83b4-443b-941a-fddab4d08430'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'Amen des étoiles, de la planète à l’anneau', part.name_en = 'Visions de l’Amen, I/25: II. Amen des étoiles, de la planète à l’anneau',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 706 AND p.composer_id = 95 AND part.part_key = 'musicbrainz:d0cb56b1-ba7d-457e-869c-76b6cb353fa3' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:d0cb56b1-ba7d-457e-869c-76b6cb353fa3', 2, 'II', 'Amen des étoiles, de la planète à l’anneau', 'Visions de l’Amen, I/25: II. Amen des étoiles, de la planète à l’anneau', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 706 AND p.composer_id = 95
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:d0cb56b1-ba7d-457e-869c-76b6cb353fa3'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = 'Amen de l’agonie de Jésus', part.name_en = 'Visions de l’Amen, I/25: III. Amen de l’agonie de Jésus',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 706 AND p.composer_id = 95 AND part.part_key = 'musicbrainz:ebc8c257-f77c-452c-bc8c-e33a1da9dc8b' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:ebc8c257-f77c-452c-bc8c-e33a1da9dc8b', 3, 'III', 'Amen de l’agonie de Jésus', 'Visions de l’Amen, I/25: III. Amen de l’agonie de Jésus', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 706 AND p.composer_id = 95
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:ebc8c257-f77c-452c-bc8c-e33a1da9dc8b'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = 'IV',
    part.name_ko = 'Amen du désir', part.name_en = 'Visions de l’Amen, I/25: IV. Amen du désir',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 706 AND p.composer_id = 95 AND part.part_key = 'musicbrainz:cd9b6138-adda-4a74-b55a-11094c56868b' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:cd9b6138-adda-4a74-b55a-11094c56868b', 4, 'IV', 'Amen du désir', 'Visions de l’Amen, I/25: IV. Amen du désir', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 706 AND p.composer_id = 95
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:cd9b6138-adda-4a74-b55a-11094c56868b'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 5, part.movement_number = 'V',
    part.name_ko = 'Amen des anges, des saints, du chant des oiseaux', part.name_en = 'Visions de l’Amen, I/25: V. Amen des anges, des saints, du chant des oiseaux',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 706 AND p.composer_id = 95 AND part.part_key = 'musicbrainz:0ca22332-5cc2-4cb7-a2ff-49def18c8be7' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:0ca22332-5cc2-4cb7-a2ff-49def18c8be7', 5, 'V', 'Amen des anges, des saints, du chant des oiseaux', 'Visions de l’Amen, I/25: V. Amen des anges, des saints, du chant des oiseaux', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 706 AND p.composer_id = 95
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:0ca22332-5cc2-4cb7-a2ff-49def18c8be7'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 6, part.movement_number = 'VI',
    part.name_ko = 'Amen du jugement', part.name_en = 'Visions de l’Amen, I/25: VI. Amen du jugement',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 706 AND p.composer_id = 95 AND part.part_key = 'musicbrainz:793b4aa4-5515-49f1-9217-e9ab29b05bde' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:793b4aa4-5515-49f1-9217-e9ab29b05bde', 6, 'VI', 'Amen du jugement', 'Visions de l’Amen, I/25: VI. Amen du jugement', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 706 AND p.composer_id = 95
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:793b4aa4-5515-49f1-9217-e9ab29b05bde'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 7, part.movement_number = 'VII',
    part.name_ko = 'Amen de la consommation', part.name_en = 'Visions de l’Amen, I/25: VII. Amen de la consommation',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 706 AND p.composer_id = 95 AND part.part_key = 'musicbrainz:3bcfcb2e-0c63-4a2b-bac4-e7a30a0d8627' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:3bcfcb2e-0c63-4a2b-bac4-e7a30a0d8627', 7, 'VII', 'Amen de la consommation', 'Visions de l’Amen, I/25: VII. Amen de la consommation', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 706 AND p.composer_id = 95
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:3bcfcb2e-0c63-4a2b-bac4-e7a30a0d8627'
);


-- None Éclairs sur l’Au-delà

UPDATE pieces piece
SET piece.title = 'Éclairs sur l’Au-delà', piece.title_en = 'Éclairs sur l’Au-delà',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 716 AND piece.composer_id = 95
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'Apparition du Christ glorieux', part.name_en = 'Éclairs sur l’Au-delà: I. Apparition du Christ glorieux',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 716 AND p.composer_id = 95 AND part.part_key = 'musicbrainz:809c9486-623a-3627-9231-e5fb392ae38c' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:809c9486-623a-3627-9231-e5fb392ae38c', 1, 'I', 'Apparition du Christ glorieux', 'Éclairs sur l’Au-delà: I. Apparition du Christ glorieux', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 716 AND p.composer_id = 95
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:809c9486-623a-3627-9231-e5fb392ae38c'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'La Constellation du Sagittaire', part.name_en = 'Éclairs sur l’Au-delà: II. La Constellation du Sagittaire',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 716 AND p.composer_id = 95 AND part.part_key = 'musicbrainz:e2e51328-f408-3c71-b19a-004ae885aa63' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:e2e51328-f408-3c71-b19a-004ae885aa63', 2, 'II', 'La Constellation du Sagittaire', 'Éclairs sur l’Au-delà: II. La Constellation du Sagittaire', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 716 AND p.composer_id = 95
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:e2e51328-f408-3c71-b19a-004ae885aa63'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = 'L’Oiseau-lyre et la Ville-fiancée', part.name_en = 'Éclairs sur l’Au-delà: III. L’Oiseau-lyre et la Ville-fiancée',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 716 AND p.composer_id = 95 AND part.part_key = 'musicbrainz:208cd02f-6df7-3751-ac52-4ddcc408f921' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:208cd02f-6df7-3751-ac52-4ddcc408f921', 3, 'III', 'L’Oiseau-lyre et la Ville-fiancée', 'Éclairs sur l’Au-delà: III. L’Oiseau-lyre et la Ville-fiancée', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 716 AND p.composer_id = 95
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:208cd02f-6df7-3751-ac52-4ddcc408f921'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = 'IV',
    part.name_ko = 'Les Élus marqués du sceau', part.name_en = 'Éclairs sur l’Au-delà: IV. Les Élus marqués du sceau',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 716 AND p.composer_id = 95 AND part.part_key = 'musicbrainz:b2569c00-dcb7-38e3-8e64-dda7530eaae2' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:b2569c00-dcb7-38e3-8e64-dda7530eaae2', 4, 'IV', 'Les Élus marqués du sceau', 'Éclairs sur l’Au-delà: IV. Les Élus marqués du sceau', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 716 AND p.composer_id = 95
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:b2569c00-dcb7-38e3-8e64-dda7530eaae2'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 5, part.movement_number = 'V',
    part.name_ko = 'Demeurer dans l’Amour', part.name_en = 'Éclairs sur l’Au-delà: V. Demeurer dans l’Amour',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 716 AND p.composer_id = 95 AND part.part_key = 'musicbrainz:5c6a98c2-ac4c-3f1c-bb74-05a771c72834' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:5c6a98c2-ac4c-3f1c-bb74-05a771c72834', 5, 'V', 'Demeurer dans l’Amour', 'Éclairs sur l’Au-delà: V. Demeurer dans l’Amour', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 716 AND p.composer_id = 95
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:5c6a98c2-ac4c-3f1c-bb74-05a771c72834'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 6, part.movement_number = 'VI',
    part.name_ko = 'Les Sept Anges aux sept trompettes', part.name_en = 'Éclairs sur l’Au-delà: VI. Les Sept Anges aux sept trompettes',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 716 AND p.composer_id = 95 AND part.part_key = 'musicbrainz:593b8106-6777-3e3e-b03b-3f9dd115d586' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:593b8106-6777-3e3e-b03b-3f9dd115d586', 6, 'VI', 'Les Sept Anges aux sept trompettes', 'Éclairs sur l’Au-delà: VI. Les Sept Anges aux sept trompettes', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 716 AND p.composer_id = 95
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:593b8106-6777-3e3e-b03b-3f9dd115d586'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 7, part.movement_number = 'VII',
    part.name_ko = 'Et Dieu essuiera toute larme de leurs yeux', part.name_en = 'Éclairs sur l’Au-delà: VII. Et Dieu essuiera toute larme de leurs yeux',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 716 AND p.composer_id = 95 AND part.part_key = 'musicbrainz:6c26093b-a162-3470-a063-fde711e89727' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:6c26093b-a162-3470-a063-fde711e89727', 7, 'VII', 'Et Dieu essuiera toute larme de leurs yeux', 'Éclairs sur l’Au-delà: VII. Et Dieu essuiera toute larme de leurs yeux', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 716 AND p.composer_id = 95
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:6c26093b-a162-3470-a063-fde711e89727'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 8, part.movement_number = 'VIII',
    part.name_ko = 'Les Étoiles et la Gloire', part.name_en = 'Éclairs sur l’Au-delà: VIII. Les Étoiles et la Gloire',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 716 AND p.composer_id = 95 AND part.part_key = 'musicbrainz:164e10fc-b82f-359c-b3ea-ec78a4550107' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:164e10fc-b82f-359c-b3ea-ec78a4550107', 8, 'VIII', 'Les Étoiles et la Gloire', 'Éclairs sur l’Au-delà: VIII. Les Étoiles et la Gloire', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 716 AND p.composer_id = 95
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:164e10fc-b82f-359c-b3ea-ec78a4550107'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 9, part.movement_number = 'IX',
    part.name_ko = 'Plusieurs Oiseaux des arbres de Vie', part.name_en = 'Éclairs sur l’Au-delà: IX. Plusieurs Oiseaux des arbres de Vie',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 716 AND p.composer_id = 95 AND part.part_key = 'musicbrainz:5e4f6dcf-54e5-3b69-93f5-dad82894fe8c' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:5e4f6dcf-54e5-3b69-93f5-dad82894fe8c', 9, 'IX', 'Plusieurs Oiseaux des arbres de Vie', 'Éclairs sur l’Au-delà: IX. Plusieurs Oiseaux des arbres de Vie', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 716 AND p.composer_id = 95
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:5e4f6dcf-54e5-3b69-93f5-dad82894fe8c'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 10, part.movement_number = 'X',
    part.name_ko = 'Le Chemin de l’Invisible', part.name_en = 'Éclairs sur l’Au-delà: X. Le Chemin de l’Invisible',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 716 AND p.composer_id = 95 AND part.part_key = 'musicbrainz:f5099044-b8ee-3537-b5d1-9441a09c2df3' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:f5099044-b8ee-3537-b5d1-9441a09c2df3', 10, 'X', 'Le Chemin de l’Invisible', 'Éclairs sur l’Au-delà: X. Le Chemin de l’Invisible', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 716 AND p.composer_id = 95
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:f5099044-b8ee-3537-b5d1-9441a09c2df3'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 11, part.movement_number = 'XI',
    part.name_ko = 'Le Christ, lumière du Paradis', part.name_en = 'Éclairs sur l’Au-delà: XI. Le Christ, lumière du Paradis',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 716 AND p.composer_id = 95 AND part.part_key = 'musicbrainz:56eec66c-bb12-3a8b-af63-06e4d93dc225' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:56eec66c-bb12-3a8b-af63-06e4d93dc225', 11, 'XI', 'Le Christ, lumière du Paradis', 'Éclairs sur l’Au-delà: XI. Le Christ, lumière du Paradis', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 716 AND p.composer_id = 95
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:56eec66c-bb12-3a8b-af63-06e4d93dc225'
);


-- None Andantino

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, 'Andantino', 'Andantino', 'song', NULL, NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 95
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = 'Andantino'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '011edc88-2953-451f-871c-611a84a15f2e'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '011edc88-2953-451f-871c-611a84a15f2e'
FROM pieces p
WHERE p.composer_id = 95 AND p.title = 'Andantino' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '011edc88-2953-451f-871c-611a84a15f2e'
);


-- None L’Ascension

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, 'L’Ascension', 'L’Ascension', 'album', NULL, NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 95
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = 'L’Ascension'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'c8cac38b-6f20-4b4a-90a3-1f363ae25832'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'c8cac38b-6f20-4b4a-90a3-1f363ae25832'
FROM pieces p
WHERE p.composer_id = 95 AND p.title = 'L’Ascension' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'c8cac38b-6f20-4b4a-90a3-1f363ae25832'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:2ff1fb2d-8721-4b9b-a999-318e3bd0bdda', 1, 'I', 'Majesté du Christ demandant sa gloire à son Père. Très lent et majestueux', 'L’Ascension: I. Majesté du Christ demandant sa gloire à son Père. Très lent et majestueux', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 95 AND p.title = 'L’Ascension' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:2ff1fb2d-8721-4b9b-a999-318e3bd0bdda'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:b93f915e-bb30-4b65-bf46-a3fd1202409d', 2, 'II', 'Alléluias sereins d’une âme qui désire le ciel. Bien modéré, clair', 'L’Ascension: II. Alléluias sereins d’une âme qui désire le ciel. Bien modéré, clair', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 95 AND p.title = 'L’Ascension' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:b93f915e-bb30-4b65-bf46-a3fd1202409d'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:714874dc-5bee-40d7-b574-9e9804a7317a', 3, 'III', 'Alléluia sur la trompette, alléluia sur la cymbale. Vif et joyeux', 'L’Ascension: III. Alléluia sur la trompette, alléluia sur la cymbale. Vif et joyeux', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 95 AND p.title = 'L’Ascension' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:714874dc-5bee-40d7-b574-9e9804a7317a'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:b6684bdb-2053-4726-adef-7e6580fb838a', 4, 'IV', 'Prière du Christ montant vers son Père. Extrêmement lent, ému et solennel', 'L’Ascension: IV. Prière du Christ montant vers son Père. Extrêmement lent, ému et solennel', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 95 AND p.title = 'L’Ascension' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:b6684bdb-2053-4726-adef-7e6580fb838a'
);


-- None O sacrum convivium, I/18

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, 'O sacrum convivium, I/18', 'O sacrum convivium, I/18', 'song', NULL, NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 95
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = 'O sacrum convivium, I/18'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '224fafb0-2db3-44f1-94e7-9f5e5875df98'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '224fafb0-2db3-44f1-94e7-9f5e5875df98'
FROM pieces p
WHERE p.composer_id = 95 AND p.title = 'O sacrum convivium, I/18' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '224fafb0-2db3-44f1-94e7-9f5e5875df98'
);


-- None Vocalise

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, 'Vocalise', 'Vocalise', 'song', NULL, NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 95
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = 'Vocalise'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'fc9e5e18-d7cd-4778-b558-2534954fa482'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'fc9e5e18-d7cd-4778-b558-2534954fa482'
FROM pieces p
WHERE p.composer_id = 95 AND p.title = 'Vocalise' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'fc9e5e18-d7cd-4778-b558-2534954fa482'
);


-- None Vocalise-étude

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, 'Vocalise-étude', 'Vocalise-étude', 'song', NULL, NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 95
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = 'Vocalise-étude'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'a4a67369-620f-4699-8538-a74b1079575d'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'a4a67369-620f-4699-8538-a74b1079575d'
FROM pieces p
WHERE p.composer_id = 95 AND p.title = 'Vocalise-étude' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'a4a67369-620f-4699-8538-a74b1079575d'
);


-- 카탈로그에 대응이 없는 seed 작품 4개를 목록에서 숨긴다(지우지 않음).
UPDATE pieces piece
SET piece.hidden_reason = 'catalog_unmatched'
WHERE piece.composer_id = 95 AND piece.origin = 'seed' AND piece.hidden_reason IS NULL
  AND piece.id IN (
    630, 699, 1428, 2911
  )
  AND NOT EXISTS (SELECT 1 FROM performance_sectors sector WHERE sector.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM piece_parts linking WHERE linking.linked_piece_id = piece.id);
