-- Bruno Mantovani 작품을 MusicBrainz 작품 구조로 다시 짠다(5차 자동). 작품 22개(묶음 0, 다악장 1, 낱곡 21),
-- 새 작품 0개, part 9개, 그 아래 0개.
-- seed 22개 중 22개를 작품·part 에 잇고, 0개를 숨기고, 0개는 그대로 둔다.
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

-- None All'ungarese

UPDATE pieces piece
SET piece.title = 'All''ungarese', piece.title_en = 'All''ungarese',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 24851 AND piece.composer_id = 345
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None 칸타타 4번 "Komm, Jesu, komm"

UPDATE pieces piece
SET piece.title = '칸타타 4번 "Komm, Jesu, komm"', piece.title_en = 'Cantate no. 4 “Komm, Jesu, komm”',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 23467 AND piece.composer_id = 345
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Cinq Poèmes de János Pilinszky

UPDATE pieces piece
SET piece.title = 'Cinq Poèmes de János Pilinszky', piece.title_en = 'Cinq Poèmes de János Pilinszky',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 24743 AND piece.composer_id = 345
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Cinq pièces pour Paul Klee

UPDATE pieces piece
SET piece.title = 'Cinq pièces pour Paul Klee', piece.title_en = 'Cinq pièces pour Paul Klee',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 25850 AND piece.composer_id = 345
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Concerto pour deux pianos

UPDATE pieces piece
SET piece.title = 'Concerto pour deux pianos', piece.title_en = 'Concerto pour deux pianos',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 23519 AND piece.composer_id = 345
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Concerto pour violoncelle et orchestre

UPDATE pieces piece
SET piece.title = 'Concerto pour violoncelle et orchestre', piece.title_en = 'Concerto pour violoncelle et orchestre',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 23888 AND piece.composer_id = 345
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None D'un jardin féérique

UPDATE pieces piece
SET piece.title = 'D''un jardin féérique', piece.title_en = 'D''un jardin féérique',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 25809 AND piece.composer_id = 345
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None D'une seule voix

UPDATE pieces piece
SET piece.title = 'D''une seule voix', piece.title_en = 'D''une seule voix',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 25097 AND piece.composer_id = 345
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Eclair de Lune

UPDATE pieces piece
SET piece.title = 'Eclair de Lune', piece.title_en = 'Eclair de Lune',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 25707 AND piece.composer_id = 345
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Huit moments musicaux

UPDATE pieces piece
SET piece.title = 'Huit moments musicaux', piece.title_en = 'Huit moments musicaux',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 25182 AND piece.composer_id = 345
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Jeux d'eau

UPDATE pieces piece
SET piece.title = 'Jeux d''eau', piece.title_en = 'Jeux d''eau',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 25763 AND piece.composer_id = 345
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Le Sette Chiese

UPDATE pieces piece
SET piece.title = 'Le Sette Chiese', piece.title_en = 'Le Sette Chiese',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 23954 AND piece.composer_id = 345
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'La chapelle du bandeau', part.name_en = 'Le Sette Chiese: La chapelle du bandeau',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 23954 AND p.composer_id = 345 AND part.part_key = 'musicbrainz:2fb2993f-26a8-4135-8bf4-60facb364180' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:2fb2993f-26a8-4135-8bf4-60facb364180', 1, NULL, 'La chapelle du bandeau', 'Le Sette Chiese: La chapelle du bandeau', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 23954 AND p.composer_id = 345
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:2fb2993f-26a8-4135-8bf4-60facb364180'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'L’église du martyrium', part.name_en = 'Le Sette Chiese: L’église du martyrium',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 23954 AND p.composer_id = 345 AND part.part_key = 'musicbrainz:336b0028-6611-47a8-bcaa-6823aafdd7f0' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:336b0028-6611-47a8-bcaa-6823aafdd7f0', 2, NULL, 'L’église du martyrium', 'Le Sette Chiese: L’église du martyrium', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 23954 AND p.composer_id = 345
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:336b0028-6611-47a8-bcaa-6823aafdd7f0'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = NULL,
    part.name_ko = 'Basilique des saints Vital et Agricola', part.name_en = 'Le Sette Chiese: Basilique des saints Vital et Agricola',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 23954 AND p.composer_id = 345 AND part.part_key = 'musicbrainz:3400a696-8bf8-48d4-9884-6eadc44025cf' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:3400a696-8bf8-48d4-9884-6eadc44025cf', 3, NULL, 'Basilique des saints Vital et Agricola', 'Le Sette Chiese: Basilique des saints Vital et Agricola', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 23954 AND p.composer_id = 345
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:3400a696-8bf8-48d4-9884-6eadc44025cf'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = NULL,
    part.name_ko = 'La piazza Santo Stefano', part.name_en = 'Le Sette Chiese: La piazza Santo Stefano',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 23954 AND p.composer_id = 345 AND part.part_key = 'musicbrainz:6a2808f5-62a1-4a0a-82bc-ad1643b8806a' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:6a2808f5-62a1-4a0a-82bc-ad1643b8806a', 4, NULL, 'La piazza Santo Stefano', 'Le Sette Chiese: La piazza Santo Stefano', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 23954 AND p.composer_id = 345
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:6a2808f5-62a1-4a0a-82bc-ad1643b8806a'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 5, part.movement_number = NULL,
    part.name_ko = 'La crypte', part.name_en = 'Le Sette Chiese: La crypte',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 23954 AND p.composer_id = 345 AND part.part_key = 'musicbrainz:96d56387-28e1-4b7b-b8fe-b6efdc235f5b' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:96d56387-28e1-4b7b-b8fe-b6efdc235f5b', 5, NULL, 'La crypte', 'Le Sette Chiese: La crypte', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 23954 AND p.composer_id = 345
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:96d56387-28e1-4b7b-b8fe-b6efdc235f5b'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 6, part.movement_number = NULL,
    part.name_ko = 'Le cloître', part.name_en = 'Le Sette Chiese: Le cloître',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 23954 AND p.composer_id = 345 AND part.part_key = 'musicbrainz:99b13f9f-96cc-47be-810f-a9ac66d03689' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:99b13f9f-96cc-47be-810f-a9ac66d03689', 6, NULL, 'Le cloître', 'Le Sette Chiese: Le cloître', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 23954 AND p.composer_id = 345
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:99b13f9f-96cc-47be-810f-a9ac66d03689'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 7, part.movement_number = NULL,
    part.name_ko = 'La cour de Pilate', part.name_en = 'Le Sette Chiese: La cour de Pilate',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 23954 AND p.composer_id = 345 AND part.part_key = 'musicbrainz:a4c343d8-3384-44d3-9a72-7b01830058a9' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:a4c343d8-3384-44d3-9a72-7b01830058a9', 7, NULL, 'La cour de Pilate', 'Le Sette Chiese: La cour de Pilate', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 23954 AND p.composer_id = 345
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:a4c343d8-3384-44d3-9a72-7b01830058a9'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 8, part.movement_number = NULL,
    part.name_ko = 'L’église de Saint-Jean Baptiste', part.name_en = 'Le Sette Chiese: L’église de Saint-Jean Baptiste',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 23954 AND p.composer_id = 345 AND part.part_key = 'musicbrainz:aadb7fed-4369-4f77-b696-fc0a063e9d70' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:aadb7fed-4369-4f77-b696-fc0a063e9d70', 8, NULL, 'L’église de Saint-Jean Baptiste', 'Le Sette Chiese: L’église de Saint-Jean Baptiste', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 23954 AND p.composer_id = 345
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:aadb7fed-4369-4f77-b696-fc0a063e9d70'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 9, part.movement_number = NULL,
    part.name_ko = 'La basilique du sépulcre', part.name_en = 'Le Sette Chiese: La basilique du sépulcre',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 23954 AND p.composer_id = 345 AND part.part_key = 'musicbrainz:bf281bed-a847-4bbf-a6f5-700dbbbc95a0' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:bf281bed-a847-4bbf-a6f5-700dbbbc95a0', 9, NULL, 'La basilique du sépulcre', 'Le Sette Chiese: La basilique du sépulcre', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 23954 AND p.composer_id = 345
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:bf281bed-a847-4bbf-a6f5-700dbbbc95a0'
);


-- None Mit Ausdruck

UPDATE pieces piece
SET piece.title = 'Mit Ausdruck', piece.title_en = 'Mit Ausdruck',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 23518 AND piece.composer_id = 345
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Moi, jeu…

UPDATE pieces piece
SET piece.title = 'Moi, jeu…', piece.title_en = 'Moi, jeu…',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 25956 AND piece.composer_id = 345
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Monde évanoui (Fragments pour Babylone)

UPDATE pieces piece
SET piece.title = 'Monde évanoui (Fragments pour Babylone)', piece.title_en = 'Monde évanoui (Fragments pour Babylone)',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 24027 AND piece.composer_id = 345
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Quatuor à cordes no. 5

UPDATE pieces piece
SET piece.title = 'Quatuor à cordes no. 5', piece.title_en = 'Quatuor à cordes no. 5',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 25066 AND piece.composer_id = 345
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Streets

UPDATE pieces piece
SET piece.title = 'Streets', piece.title_en = 'Streets',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 25287 AND piece.composer_id = 345
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None 현악 4중주 6번 "Beethoveniana"

UPDATE pieces piece
SET piece.title = '현악 4중주 6번 "Beethoveniana"', piece.title_en = 'String Quartet no. 6 “Beethoveniana”',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 25019 AND piece.composer_id = 345
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Suonare

UPDATE pieces piece
SET piece.title = 'Suonare', piece.title_en = 'Suonare',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 23443 AND piece.composer_id = 345
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Tocar

UPDATE pieces piece
SET piece.title = 'Tocar', piece.title_en = 'Tocar',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 24140 AND piece.composer_id = 345
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Un mois d'octobre

UPDATE pieces piece
SET piece.title = 'Un mois d''octobre', piece.title_en = 'Un mois d''octobre',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 23588 AND piece.composer_id = 345
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Vier geistliche Gedichte

UPDATE pieces piece
SET piece.title = 'Vier geistliche Gedichte', piece.title_en = 'Vier geistliche Gedichte',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 23942 AND piece.composer_id = 345
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- 숨길 seed 작품 없음
