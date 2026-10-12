-- 호아킨 로드리고 작품을 MusicBrainz 작품 구조로 다시 짠다(4차 자동). 작품 98개(묶음 24, 다악장 31, 낱곡 43),
-- 새 작품 14개, part 199개, 그 아래 8개.
-- seed 95개 중 84개를 작품·part 에 잇고, 11개를 숨기고, 0개는 그대로 둔다.
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

-- None A la busca del más allá

UPDATE pieces piece
SET piece.title = 'A la busca del más allá', piece.title_en = 'A la busca del más allá',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 16636 AND piece.composer_id = 341
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None A l’ombre de Torre Bermeja

UPDATE pieces piece
SET piece.title = 'A l’ombre de Torre Bermeja', piece.title_en = 'A l’ombre de Torre Bermeja',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 16895 AND piece.composer_id = 341
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Adagio para instrumentos de viento

UPDATE pieces piece
SET piece.title = 'Adagio para instrumentos de viento', piece.title_en = 'Adagio para instrumentos de viento',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 17740 AND piece.composer_id = 341
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Air de ballet sur le nom d’une jeune fille

UPDATE pieces piece
SET piece.title = 'Air de ballet sur le nom d’une jeune fille', piece.title_en = 'Air de ballet sur le nom d’une jeune fille',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 16484 AND piece.composer_id = 341
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Aranjuez, ma pensée

UPDATE pieces piece
SET piece.title = 'Aranjuez, ma pensée', piece.title_en = 'Aranjuez, ma pensée',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 19456 AND piece.composer_id = 341
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Atardecer

UPDATE pieces piece
SET piece.title = 'Atardecer', piece.title_en = 'Atardecer',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 16022 AND piece.composer_id = 341
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Ausencias de Dulcinea

UPDATE pieces piece
SET piece.title = 'Ausencias de Dulcinea', piece.title_en = 'Ausencias de Dulcinea',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 16796 AND piece.composer_id = 341
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Bagatela

UPDATE pieces piece
SET piece.title = 'Bagatela', piece.title_en = 'Bagatela',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 16375 AND piece.composer_id = 341
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None 가곡 <Canción del cucú>

UPDATE pieces piece
SET piece.title = '가곡 <Canción del cucú>', piece.title_en = 'Canción del cucú',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 16195 AND piece.composer_id = 341
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None 가곡 <Canción del grumete>

UPDATE pieces piece
SET piece.title = '가곡 <Canción del grumete>', piece.title_en = 'Canción del grumete',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 19965 AND piece.composer_id = 341
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Canción y danza

UPDATE pieces piece
SET piece.title = 'Canción y danza', piece.title_en = 'Canción y danza',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 19191 AND piece.composer_id = 341
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Cantos de amor y de guerra

UPDATE pieces piece
SET piece.title = 'Cantos de amor y de guerra', piece.title_en = 'Cantos de amor y de guerra',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 17326 AND piece.composer_id = 341
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'Paseábase el rey moro', part.name_en = 'Cantos de amor y de guerra, nº 1: Paseábase el rey moro',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 17326 AND p.composer_id = 341 AND part.part_key = 'musicbrainz:139fee6d-fbe9-48f1-b2db-a314b70cc4a6' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:139fee6d-fbe9-48f1-b2db-a314b70cc4a6', 1, NULL, 'Paseábase el rey moro', 'Cantos de amor y de guerra, nº 1: Paseábase el rey moro', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 17326 AND p.composer_id = 341
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:139fee6d-fbe9-48f1-b2db-a314b70cc4a6'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = '¡A las armas, moriscotes!', part.name_en = 'Cantos de amor y de guerra, nº 2: ¡A las armas, moriscotes!',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 17326 AND p.composer_id = 341 AND part.part_key = 'musicbrainz:08f5562f-099d-4a81-8195-346af1dca3d0' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:08f5562f-099d-4a81-8195-346af1dca3d0', 2, NULL, '¡A las armas, moriscotes!', 'Cantos de amor y de guerra, nº 2: ¡A las armas, moriscotes!', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 17326 AND p.composer_id = 341
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:08f5562f-099d-4a81-8195-346af1dca3d0'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = NULL,
    part.name_ko = '¡Ay!, luna que reluces', part.name_en = 'Cantos de amor y de guerra, nº 3: ¡Ay!, luna que reluces',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 17326 AND p.composer_id = 341 AND part.part_key = 'musicbrainz:55413528-0471-41dc-b861-05e9b88c1132' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:55413528-0471-41dc-b861-05e9b88c1132', 3, NULL, '¡Ay!, luna que reluces', 'Cantos de amor y de guerra, nº 3: ¡Ay!, luna que reluces', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 17326 AND p.composer_id = 341
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:55413528-0471-41dc-b861-05e9b88c1132'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = NULL,
    part.name_ko = 'Sobre Baza estaba el rey', part.name_en = 'Cantos de amor y de guerra, nº 4: Sobre Baza estaba el rey',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 17326 AND p.composer_id = 341 AND part.part_key = 'musicbrainz:2f1f0985-f909-4647-90bc-6e4742eb5215' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:2f1f0985-f909-4647-90bc-6e4742eb5215', 4, NULL, 'Sobre Baza estaba el rey', 'Cantos de amor y de guerra, nº 4: Sobre Baza estaba el rey', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 17326 AND p.composer_id = 341
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:2f1f0985-f909-4647-90bc-6e4742eb5215'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 5, part.movement_number = NULL,
    part.name_ko = 'Pastorcico, tú que has vuelto', part.name_en = 'Cantos de amor y de guerra, nº 5: Pastorcico, tú que has vuelto',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 17326 AND p.composer_id = 341 AND part.part_key = 'musicbrainz:4e578fc4-762f-4d32-bcb1-d4bbadbd698c' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:4e578fc4-762f-4d32-bcb1-d4bbadbd698c', 5, NULL, 'Pastorcico, tú que has vuelto', 'Cantos de amor y de guerra, nº 5: Pastorcico, tú que has vuelto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 17326 AND p.composer_id = 341
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:4e578fc4-762f-4d32-bcb1-d4bbadbd698c'
);


-- None Capriccio (Ofrenda a Sarasate)

UPDATE pieces piece
SET piece.title = 'Capriccio (Ofrenda a Sarasate)', piece.title_en = 'Capriccio (Ofrenda a Sarasate)',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 18944 AND piece.composer_id = 341
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Cinco piezas infantiles

UPDATE pieces piece
SET piece.title = 'Cinco piezas infantiles', piece.title_en = 'Cinco piezas infantiles',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 19720 AND piece.composer_id = 341
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'Son chicos que pasan', part.name_en = 'Cinco piezas infantiles, nº 1: Son chicos que pasan',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 19720 AND p.composer_id = 341 AND part.part_key = 'musicbrainz:f56d3bc2-1f22-4ea3-8bb7-d83c6d2f75e4' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:f56d3bc2-1f22-4ea3-8bb7-d83c6d2f75e4', 1, NULL, 'Son chicos que pasan', 'Cinco piezas infantiles, nº 1: Son chicos que pasan', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 19720 AND p.composer_id = 341
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:f56d3bc2-1f22-4ea3-8bb7-d83c6d2f75e4'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'Después de un cuento', part.name_en = 'Cinco piezas infantiles, nº 2: Después de un cuento',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 19720 AND p.composer_id = 341 AND part.part_key = 'musicbrainz:bdba09d7-52df-4778-8f47-061d77e0f6f3' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:bdba09d7-52df-4778-8f47-061d77e0f6f3', 2, NULL, 'Después de un cuento', 'Cinco piezas infantiles, nº 2: Después de un cuento', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 19720 AND p.composer_id = 341
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:bdba09d7-52df-4778-8f47-061d77e0f6f3'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = NULL,
    part.name_ko = 'Mazurka', part.name_en = 'Cinco piezas infantiles, nº 3: Mazurka',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 19720 AND p.composer_id = 341 AND part.part_key = 'musicbrainz:e7ec4a3c-bdaa-43cb-bb51-c8998cf84f93' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:e7ec4a3c-bdaa-43cb-bb51-c8998cf84f93', 3, NULL, 'Mazurka', 'Cinco piezas infantiles, nº 3: Mazurka', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 19720 AND p.composer_id = 341
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:e7ec4a3c-bdaa-43cb-bb51-c8998cf84f93'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = NULL,
    part.name_ko = 'Plegaria', part.name_en = 'Cinco piezas infantiles, nº 4: Plegaria',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 19720 AND p.composer_id = 341 AND part.part_key = 'musicbrainz:c13af592-21c8-4383-b7a3-d70d0e6dbd4c' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:c13af592-21c8-4383-b7a3-d70d0e6dbd4c', 4, NULL, 'Plegaria', 'Cinco piezas infantiles, nº 4: Plegaria', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 19720 AND p.composer_id = 341
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:c13af592-21c8-4383-b7a3-d70d0e6dbd4c'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 5, part.movement_number = NULL,
    part.name_ko = 'Gritería final', part.name_en = 'Cinco piezas infantiles, nº 5: Gritería final',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 19720 AND p.composer_id = 341 AND part.part_key = 'musicbrainz:83deb682-ba7e-4a7b-8933-aff594fb805e' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:83deb682-ba7e-4a7b-8933-aff594fb805e', 5, NULL, 'Gritería final', 'Cinco piezas infantiles, nº 5: Gritería final', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 19720 AND p.composer_id = 341
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:83deb682-ba7e-4a7b-8933-aff594fb805e'
);


-- None Concerto in modo galante

UPDATE pieces piece
SET piece.title = 'Concerto in modo galante', piece.title_en = 'Concerto in modo galante',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 16961 AND piece.composer_id = 341
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'Allegretto grazioso', part.name_en = 'Concerto in modo galante: I. Allegretto grazioso',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 16961 AND p.composer_id = 341 AND part.part_key = 'musicbrainz:d44f7ba2-33ee-4936-87c1-081c4b67ed18' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:d44f7ba2-33ee-4936-87c1-081c4b67ed18', 1, 'I', 'Allegretto grazioso', 'Concerto in modo galante: I. Allegretto grazioso', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 16961 AND p.composer_id = 341
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:d44f7ba2-33ee-4936-87c1-081c4b67ed18'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'Adagietto', part.name_en = 'Concerto in modo galante: II. Adagietto',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 16961 AND p.composer_id = 341 AND part.part_key = 'musicbrainz:f072d16b-69a8-4a4f-926d-e5af452bc150' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:f072d16b-69a8-4a4f-926d-e5af452bc150', 2, 'II', 'Adagietto', 'Concerto in modo galante: II. Adagietto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 16961 AND p.composer_id = 341
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:f072d16b-69a8-4a4f-926d-e5af452bc150'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = 'Rondo giocoso', part.name_en = 'Concerto in modo galante: III. Rondo giocoso',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 16961 AND p.composer_id = 341 AND part.part_key = 'musicbrainz:d9caf61a-72d0-4207-a19f-75b3c7d0ec59' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:d9caf61a-72d0-4207-a19f-75b3c7d0ec59', 3, 'III', 'Rondo giocoso', 'Concerto in modo galante: III. Rondo giocoso', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 16961 AND p.composer_id = 341
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:d9caf61a-72d0-4207-a19f-75b3c7d0ec59'
);


-- None Concierto andaluz

UPDATE pieces piece
SET piece.title = 'Concierto andaluz', piece.title_en = 'Concierto andaluz',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 17110 AND piece.composer_id = 341
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'Tempo de bolero', part.name_en = 'Concierto andaluz: I. Tempo de bolero',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 17110 AND p.composer_id = 341 AND part.part_key = 'musicbrainz:ad27c3b5-ed8a-4dcf-9313-4439467126c6' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:ad27c3b5-ed8a-4dcf-9313-4439467126c6', 1, 'I', 'Tempo de bolero', 'Concierto andaluz: I. Tempo de bolero', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 17110 AND p.composer_id = 341
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:ad27c3b5-ed8a-4dcf-9313-4439467126c6'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'Adagio', part.name_en = 'Concierto andaluz: II. Adagio',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 17110 AND p.composer_id = 341 AND part.part_key = 'musicbrainz:5b8ee604-c242-4bed-8699-2b9c842c3eb7' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:5b8ee604-c242-4bed-8699-2b9c842c3eb7', 2, 'II', 'Adagio', 'Concierto andaluz: II. Adagio', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 17110 AND p.composer_id = 341
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:5b8ee604-c242-4bed-8699-2b9c842c3eb7'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = 'Allegretto', part.name_en = 'Concierto andaluz: III. Allegretto',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 17110 AND p.composer_id = 341 AND part.part_key = 'musicbrainz:ada824a3-5a1e-4ed9-98c0-629639882e4b' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:ada824a3-5a1e-4ed9-98c0-629639882e4b', 3, 'III', 'Allegretto', 'Concierto andaluz: III. Allegretto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 17110 AND p.composer_id = 341
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:ada824a3-5a1e-4ed9-98c0-629639882e4b'
);


-- None Concierto como un divertimento

UPDATE pieces piece
SET piece.title = 'Concierto como un divertimento', piece.title_en = 'Concierto como un divertimento',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 17596 AND piece.composer_id = 341
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'Allegretto', part.name_en = 'Concierto como un divertimento: I. Allegretto',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 17596 AND p.composer_id = 341 AND part.part_key = 'musicbrainz:7a8a7851-dea4-4d9a-bf78-ce10408dcdba' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:7a8a7851-dea4-4d9a-bf78-ce10408dcdba', 1, 'I', 'Allegretto', 'Concierto como un divertimento: I. Allegretto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 17596 AND p.composer_id = 341
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:7a8a7851-dea4-4d9a-bf78-ce10408dcdba'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'Adagio nostálgico', part.name_en = 'Concierto como un divertimento: II. Adagio nostálgico',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 17596 AND p.composer_id = 341 AND part.part_key = 'musicbrainz:6dcb4131-9ed5-4811-b5bc-cbcf6b1d02a3' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:6dcb4131-9ed5-4811-b5bc-cbcf6b1d02a3', 2, 'II', 'Adagio nostálgico', 'Concierto como un divertimento: II. Adagio nostálgico', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 17596 AND p.composer_id = 341
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:6dcb4131-9ed5-4811-b5bc-cbcf6b1d02a3'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = 'Allegro scherzando', part.name_en = 'Concierto como un divertimento: III. Allegro scherzando',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 17596 AND p.composer_id = 341 AND part.part_key = 'musicbrainz:9ebd4cf3-698a-46cf-95d0-5df7a15bf21c' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:9ebd4cf3-698a-46cf-95d0-5df7a15bf21c', 3, 'III', 'Allegro scherzando', 'Concierto como un divertimento: III. Allegro scherzando', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 17596 AND p.composer_id = 341
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:9ebd4cf3-698a-46cf-95d0-5df7a15bf21c'
);


-- None Concierto de Aranjuez

UPDATE pieces piece
SET piece.title = 'Concierto de Aranjuez', piece.title_en = 'Concierto de Aranjuez',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 26015 AND piece.composer_id = 341
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'Allegro con spirito', part.name_en = 'Concierto de Aranjuez: I. Allegro con spirito',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 26015 AND p.composer_id = 341 AND part.part_key = 'musicbrainz:0317d22b-f260-373c-9128-2302eb61e1ef' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:0317d22b-f260-373c-9128-2302eb61e1ef', 1, 'I', 'Allegro con spirito', 'Concierto de Aranjuez: I. Allegro con spirito', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 26015 AND p.composer_id = 341
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:0317d22b-f260-373c-9128-2302eb61e1ef'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'Adagio', part.name_en = 'Concierto de Aranjuez: II. Adagio',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 26015 AND p.composer_id = 341 AND part.part_key = 'musicbrainz:df754996-c4f2-36a5-8323-7d5036a3f70a' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:df754996-c4f2-36a5-8323-7d5036a3f70a', 2, 'II', 'Adagio', 'Concierto de Aranjuez: II. Adagio', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 26015 AND p.composer_id = 341
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:df754996-c4f2-36a5-8323-7d5036a3f70a'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = 'Allegro gentile', part.name_en = 'Concierto de Aranjuez: III. Allegro gentile',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 26015 AND p.composer_id = 341 AND part.part_key = 'musicbrainz:f9cd7cd8-3464-3dfa-a606-0254f2934dd8' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:f9cd7cd8-3464-3dfa-a606-0254f2934dd8', 3, 'III', 'Allegro gentile', 'Concierto de Aranjuez: III. Allegro gentile', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 26015 AND p.composer_id = 341
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:f9cd7cd8-3464-3dfa-a606-0254f2934dd8'
);


-- None Concierto de estío

UPDATE pieces piece
SET piece.title = 'Concierto de estío', piece.title_en = 'Concierto de estío',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 19363 AND piece.composer_id = 341
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'Preludio. Allegro molto leggiero', part.name_en = 'Concierto de estío: I. Preludio. Allegro molto leggiero',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 19363 AND p.composer_id = 341 AND part.part_key = 'musicbrainz:29ece2b4-e53e-4fb5-b7dd-94b37781d1ac' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:29ece2b4-e53e-4fb5-b7dd-94b37781d1ac', 1, 'I', 'Preludio. Allegro molto leggiero', 'Concierto de estío: I. Preludio. Allegro molto leggiero', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 19363 AND p.composer_id = 341
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:29ece2b4-e53e-4fb5-b7dd-94b37781d1ac'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'Siciliana. Andantino', part.name_en = 'Concierto de estío: II. Siciliana. Andantino',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 19363 AND p.composer_id = 341 AND part.part_key = 'musicbrainz:bfbd2f98-7b8f-450c-829c-29119974b7a7' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:bfbd2f98-7b8f-450c-829c-29119974b7a7', 2, 'II', 'Siciliana. Andantino', 'Concierto de estío: II. Siciliana. Andantino', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 19363 AND p.composer_id = 341
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:bfbd2f98-7b8f-450c-829c-29119974b7a7'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = 'Rondino. Allegro ma non troppo', part.name_en = 'Concierto de estío: III. Rondino. Allegro ma non troppo',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 19363 AND p.composer_id = 341 AND part.part_key = 'musicbrainz:69eb4459-45b1-4271-99d5-9585d7d71250' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:69eb4459-45b1-4271-99d5-9585d7d71250', 3, 'III', 'Rondino. Allegro ma non troppo', 'Concierto de estío: III. Rondino. Allegro ma non troppo', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 19363 AND p.composer_id = 341
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:69eb4459-45b1-4271-99d5-9585d7d71250'
);


-- None Concierto heroico

UPDATE pieces piece
SET piece.title = 'Concierto heroico', piece.title_en = 'Concierto heroico',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 18631 AND piece.composer_id = 341
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'Allegro con brio', part.name_en = 'Concierto heroico: I. Allegro con brio',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 18631 AND p.composer_id = 341 AND part.part_key = 'musicbrainz:2336654e-2669-468b-a9d4-370c4ca444ea' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:2336654e-2669-468b-a9d4-370c4ca444ea', 1, 'I', 'Allegro con brio', 'Concierto heroico: I. Allegro con brio', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 18631 AND p.composer_id = 341
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:2336654e-2669-468b-a9d4-370c4ca444ea'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'Scherzo (Allegro molto ritmico)', part.name_en = 'Concierto heroico: II. Scherzo (Allegro molto ritmico)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 18631 AND p.composer_id = 341 AND part.part_key = 'musicbrainz:b66e972f-88b8-4ce0-aeb7-7d4371a83eca' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:b66e972f-88b8-4ce0-aeb7-7d4371a83eca', 2, 'II', 'Scherzo (Allegro molto ritmico)', 'Concierto heroico: II. Scherzo (Allegro molto ritmico)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 18631 AND p.composer_id = 341
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:b66e972f-88b8-4ce0-aeb7-7d4371a83eca'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = 'Largo', part.name_en = 'Concierto heroico: III. Largo',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 18631 AND p.composer_id = 341 AND part.part_key = 'musicbrainz:3087400e-28c8-473c-ae02-05a1e1a7a477' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:3087400e-28c8-473c-ae02-05a1e1a7a477', 3, 'III', 'Largo', 'Concierto heroico: III. Largo', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 18631 AND p.composer_id = 341
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:3087400e-28c8-473c-ae02-05a1e1a7a477'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = 'IV',
    part.name_ko = 'Allegro maestoso', part.name_en = 'Concierto heroico: IV. Allegro maestoso',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 18631 AND p.composer_id = 341 AND part.part_key = 'musicbrainz:bda6691d-883a-485e-9278-385a016f76ce' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:bda6691d-883a-485e-9278-385a016f76ce', 4, 'IV', 'Allegro maestoso', 'Concierto heroico: IV. Allegro maestoso', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 18631 AND p.composer_id = 341
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:bda6691d-883a-485e-9278-385a016f76ce'
);


-- None Concierto madrigal

UPDATE pieces piece
SET piece.title = 'Concierto madrigal', piece.title_en = 'Concierto madrigal',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 17955 AND piece.composer_id = 341
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'Fanfarre (Allegro marziale)', part.name_en = 'Concierto madrigal: I. Fanfarre (Allegro marziale)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 17955 AND p.composer_id = 341 AND part.part_key = 'musicbrainz:db885cb9-a57e-45fb-ad09-da6369e6dd41' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:db885cb9-a57e-45fb-ad09-da6369e6dd41', 1, 'I', 'Fanfarre (Allegro marziale)', 'Concierto madrigal: I. Fanfarre (Allegro marziale)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 17955 AND p.composer_id = 341
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:db885cb9-a57e-45fb-ad09-da6369e6dd41'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'Madrigal (Andante nostalgico)', part.name_en = 'Concierto madrigal: II. Madrigal (Andante nostalgico)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 17955 AND p.composer_id = 341 AND part.part_key = 'musicbrainz:16bdf8b8-4a28-4a25-a421-36f18c734bf9' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:16bdf8b8-4a28-4a25-a421-36f18c734bf9', 2, 'II', 'Madrigal (Andante nostalgico)', 'Concierto madrigal: II. Madrigal (Andante nostalgico)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 17955 AND p.composer_id = 341
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:16bdf8b8-4a28-4a25-a421-36f18c734bf9'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = 'Entrada (Allegro vivace)', part.name_en = 'Concierto madrigal: III. Entrada (Allegro vivace)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 17955 AND p.composer_id = 341 AND part.part_key = 'musicbrainz:ddd7d71a-e7a2-4097-8885-e3c54e37f318' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:ddd7d71a-e7a2-4097-8885-e3c54e37f318', 3, 'III', 'Entrada (Allegro vivace)', 'Concierto madrigal: III. Entrada (Allegro vivace)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 17955 AND p.composer_id = 341
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:ddd7d71a-e7a2-4097-8885-e3c54e37f318'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = 'IV',
    part.name_ko = '"Pastorcico tú que vienes, pastorcico tú que vas" (Allegro vivace)', part.name_en = 'Concierto madrigal: IV. "Pastorcico tú que vienes, pastorcico tú que vas" (Allegro vivace)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 17955 AND p.composer_id = 341 AND part.part_key = 'musicbrainz:74bd16e4-055c-4aeb-8206-d744c5d0932a' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:74bd16e4-055c-4aeb-8206-d744c5d0932a', 4, 'IV', '"Pastorcico tú que vienes, pastorcico tú que vas" (Allegro vivace)', 'Concierto madrigal: IV. "Pastorcico tú que vienes, pastorcico tú que vas" (Allegro vivace)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 17955 AND p.composer_id = 341
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:74bd16e4-055c-4aeb-8206-d744c5d0932a'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 5, part.movement_number = 'V',
    part.name_ko = 'Girardilla (Presto)', part.name_en = 'Concierto madrigal: V. Girardilla (Presto)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 17955 AND p.composer_id = 341 AND part.part_key = 'musicbrainz:01454cd8-d75b-40ef-b438-f68bbbde5b99' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:01454cd8-d75b-40ef-b438-f68bbbde5b99', 5, 'V', 'Girardilla (Presto)', 'Concierto madrigal: V. Girardilla (Presto)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 17955 AND p.composer_id = 341
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:01454cd8-d75b-40ef-b438-f68bbbde5b99'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 6, part.movement_number = 'VI',
    part.name_ko = 'Pastoral (Allegro)', part.name_en = 'Concierto madrigal: VI. Pastoral (Allegro)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 17955 AND p.composer_id = 341 AND part.part_key = 'musicbrainz:bd14a89f-c59c-4847-8654-e8088b5497c2' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:bd14a89f-c59c-4847-8654-e8088b5497c2', 6, 'VI', 'Pastoral (Allegro)', 'Concierto madrigal: VI. Pastoral (Allegro)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 17955 AND p.composer_id = 341
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:bd14a89f-c59c-4847-8654-e8088b5497c2'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 7, part.movement_number = 'VII',
    part.name_ko = 'Fandango (Molto ritmico)', part.name_en = 'Concierto madrigal: VII. Fandango (Molto ritmico)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 17955 AND p.composer_id = 341 AND part.part_key = 'musicbrainz:1bac4052-8904-4ddc-8b90-eb4e73aff4ab' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:1bac4052-8904-4ddc-8b90-eb4e73aff4ab', 7, 'VII', 'Fandango (Molto ritmico)', 'Concierto madrigal: VII. Fandango (Molto ritmico)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 17955 AND p.composer_id = 341
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:1bac4052-8904-4ddc-8b90-eb4e73aff4ab'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 8, part.movement_number = 'VIII',
    part.name_ko = 'Arieta (Andante nostalgico)', part.name_en = 'Concierto madrigal: VIII. Arieta (Andante nostalgico)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 17955 AND p.composer_id = 341 AND part.part_key = 'musicbrainz:23442d2a-aa2d-4613-b5a9-ad21998ea8db' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:23442d2a-aa2d-4613-b5a9-ad21998ea8db', 8, 'VIII', 'Arieta (Andante nostalgico)', 'Concierto madrigal: VIII. Arieta (Andante nostalgico)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 17955 AND p.composer_id = 341
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:23442d2a-aa2d-4613-b5a9-ad21998ea8db'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 9, part.movement_number = 'IX',
    part.name_ko = 'Zapateado (Allegro vivace)', part.name_en = 'Concierto madrigal: IX. Zapateado (Allegro vivace)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 17955 AND p.composer_id = 341 AND part.part_key = 'musicbrainz:29dcb2c4-88a1-4179-a037-54a24342f3d0' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:29dcb2c4-88a1-4179-a037-54a24342f3d0', 9, 'IX', 'Zapateado (Allegro vivace)', 'Concierto madrigal: IX. Zapateado (Allegro vivace)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 17955 AND p.composer_id = 341
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:29dcb2c4-88a1-4179-a037-54a24342f3d0'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 10, part.movement_number = 'X',
    part.name_ko = 'Caccia a la española (Allegro vivace - Andante nostalgico)', part.name_en = 'Concierto madrigal: X. Caccia a la española (Allegro vivace - Andante nostalgico)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 17955 AND p.composer_id = 341 AND part.part_key = 'musicbrainz:d3bde5e2-e9b7-4fb4-8419-69f8bbb0b0a9' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:d3bde5e2-e9b7-4fb4-8419-69f8bbb0b0a9', 10, 'X', 'Caccia a la española (Allegro vivace - Andante nostalgico)', 'Concierto madrigal: X. Caccia a la española (Allegro vivace - Andante nostalgico)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 17955 AND p.composer_id = 341
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:d3bde5e2-e9b7-4fb4-8419-69f8bbb0b0a9'
);


-- None Concierto para una fiesta

UPDATE pieces piece
SET piece.title = 'Concierto para una fiesta', piece.title_en = 'Concierto para una fiesta',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 16755 AND piece.composer_id = 341
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'Allegro deciso', part.name_en = 'Concierto para una fiesta: I. Allegro deciso',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 16755 AND p.composer_id = 341 AND part.part_key = 'musicbrainz:3b5fea7b-304e-33f8-8937-4a1bcd85b6a2' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:3b5fea7b-304e-33f8-8937-4a1bcd85b6a2', 1, 'I', 'Allegro deciso', 'Concierto para una fiesta: I. Allegro deciso', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 16755 AND p.composer_id = 341
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:3b5fea7b-304e-33f8-8937-4a1bcd85b6a2'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'Andante calmo', part.name_en = 'Concierto para una fiesta: II. Andante calmo',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 16755 AND p.composer_id = 341 AND part.part_key = 'musicbrainz:cdc962f7-6b73-39ba-a825-b5cc71637bb9' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:cdc962f7-6b73-39ba-a825-b5cc71637bb9', 2, 'II', 'Andante calmo', 'Concierto para una fiesta: II. Andante calmo', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 16755 AND p.composer_id = 341
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:cdc962f7-6b73-39ba-a825-b5cc71637bb9'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = 'Allegro moderato', part.name_en = 'Concierto para una fiesta: III. Allegro moderato',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 16755 AND p.composer_id = 341 AND part.part_key = 'musicbrainz:893f2363-8697-39ff-aa62-797e60e4508a' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:893f2363-8697-39ff-aa62-797e60e4508a', 3, 'III', 'Allegro moderato', 'Concierto para una fiesta: III. Allegro moderato', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 16755 AND p.composer_id = 341
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:893f2363-8697-39ff-aa62-797e60e4508a'
);


-- None Concierto pastoral

UPDATE pieces piece
SET piece.title = 'Concierto pastoral', piece.title_en = 'Concierto pastoral',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 16978 AND piece.composer_id = 341
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'Allegro', part.name_en = 'Concierto pastoral: I. Allegro',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 16978 AND p.composer_id = 341 AND part.part_key = 'musicbrainz:1fe1f437-935e-3ab2-8d59-b300a79190f8' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:1fe1f437-935e-3ab2-8d59-b300a79190f8', 1, 'I', 'Allegro', 'Concierto pastoral: I. Allegro', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 16978 AND p.composer_id = 341
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:1fe1f437-935e-3ab2-8d59-b300a79190f8'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'Adagio', part.name_en = 'Concierto pastoral: II. Adagio',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 16978 AND p.composer_id = 341 AND part.part_key = 'musicbrainz:bf0a07e8-0216-34c6-b19b-1bacb7a29b7b' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:bf0a07e8-0216-34c6-b19b-1bacb7a29b7b', 2, 'II', 'Adagio', 'Concierto pastoral: II. Adagio', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 16978 AND p.composer_id = 341
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:bf0a07e8-0216-34c6-b19b-1bacb7a29b7b'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = 'Rondo. Allegro', part.name_en = 'Concierto pastoral: III. Rondo. Allegro',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 16978 AND p.composer_id = 341 AND part.part_key = 'musicbrainz:30b1221d-cd11-3698-9c2c-865d010acfc6' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:30b1221d-cd11-3698-9c2c-865d010acfc6', 3, 'III', 'Rondo. Allegro', 'Concierto pastoral: III. Rondo. Allegro', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 16978 AND p.composer_id = 341
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:30b1221d-cd11-3698-9c2c-865d010acfc6'
);


-- None Concierto serenata

UPDATE pieces piece
SET piece.title = 'Concierto serenata', piece.title_en = 'Concierto serenata',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 16256 AND piece.composer_id = 341
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'Estudiantina (allegro)', part.name_en = 'Concierto serenata: I. Estudiantina (allegro)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 16256 AND p.composer_id = 341 AND part.part_key = 'musicbrainz:11c0a048-20b7-449d-9e62-79b1ef70cc31' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:11c0a048-20b7-449d-9e62-79b1ef70cc31', 1, 'I', 'Estudiantina (allegro)', 'Concierto serenata: I. Estudiantina (allegro)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 16256 AND p.composer_id = 341
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:11c0a048-20b7-449d-9e62-79b1ef70cc31'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'Intermezzo (molto tranquillo)', part.name_en = 'Concierto serenata: II. Intermezzo (molto tranquillo)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 16256 AND p.composer_id = 341 AND part.part_key = 'musicbrainz:b8ce8857-581b-4004-9d3f-304c611b3c76' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:b8ce8857-581b-4004-9d3f-304c611b3c76', 2, 'II', 'Intermezzo (molto tranquillo)', 'Concierto serenata: II. Intermezzo (molto tranquillo)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 16256 AND p.composer_id = 341
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:b8ce8857-581b-4004-9d3f-304c611b3c76'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = 'Sarao (allegro deciso)', part.name_en = 'Concierto serenata: III. Sarao (allegro deciso)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 16256 AND p.composer_id = 341 AND part.part_key = 'musicbrainz:a8dac83e-630c-4808-8d99-278f372dfeb1' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:a8dac83e-630c-4808-8d99-278f372dfeb1', 3, 'III', 'Sarao (allegro deciso)', 'Concierto serenata: III. Sarao (allegro deciso)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 16256 AND p.composer_id = 341
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:a8dac83e-630c-4808-8d99-278f372dfeb1'
);


-- None Coplas del pastor enamorado

UPDATE pieces piece
SET piece.title = 'Coplas del pastor enamorado', piece.title_en = 'Coplas del pastor enamorado',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 17062 AND piece.composer_id = 341
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Cuatro canciones sefardíes

UPDATE pieces piece
SET piece.title = 'Cuatro canciones sefardíes', piece.title_en = 'Cuatro canciones sefardíes',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 19780 AND piece.composer_id = 341
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'N.º 1. Respóndenos', part.name_en = 'Cuatro canciones sefardíes: N.º 1. Respóndenos',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 19780 AND p.composer_id = 341 AND part.part_key = 'musicbrainz:38660efa-6d65-4971-aec2-37970f672554' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:38660efa-6d65-4971-aec2-37970f672554', 1, NULL, 'N.º 1. Respóndenos', 'Cuatro canciones sefardíes: N.º 1. Respóndenos', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 19780 AND p.composer_id = 341
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:38660efa-6d65-4971-aec2-37970f672554'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'N.º 2. Una pastora yo amí', part.name_en = 'Cuatro canciones sefardíes: N.º 2. Una pastora yo amí',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 19780 AND p.composer_id = 341 AND part.part_key = 'musicbrainz:9f9feee1-3313-4d42-bf6e-c35ccee790f3' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:9f9feee1-3313-4d42-bf6e-c35ccee790f3', 2, NULL, 'N.º 2. Una pastora yo amí', 'Cuatro canciones sefardíes: N.º 2. Una pastora yo amí', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 19780 AND p.composer_id = 341
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:9f9feee1-3313-4d42-bf6e-c35ccee790f3'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = NULL,
    part.name_ko = 'N.º 4. "Morena" me llaman', part.name_en = 'Cuatro canciones sefardíes: N.º 4. "Morena" me llaman',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 19780 AND p.composer_id = 341 AND part.part_key = 'musicbrainz:74e07591-00e4-48ac-8097-aeaf6ae10214' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:74e07591-00e4-48ac-8097-aeaf6ae10214', 3, NULL, 'N.º 4. "Morena" me llaman', 'Cuatro canciones sefardíes: N.º 4. "Morena" me llaman', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 19780 AND p.composer_id = 341
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:74e07591-00e4-48ac-8097-aeaf6ae10214'
);


-- None Cuatro estampas andaluzas

UPDATE pieces piece
SET piece.title = 'Cuatro estampas andaluzas', piece.title_en = 'Cuatro estampas andaluzas',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 17369 AND piece.composer_id = 341
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'El vendedor de chanquetes', part.name_en = 'Cuatro estampas andaluzas, nº 1: El vendedor de chanquetes',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 17369 AND p.composer_id = 341 AND part.part_key = 'musicbrainz:1efafd34-202a-4275-9537-2f7101a2d0dc' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:1efafd34-202a-4275-9537-2f7101a2d0dc', 1, NULL, 'El vendedor de chanquetes', 'Cuatro estampas andaluzas, nº 1: El vendedor de chanquetes', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 17369 AND p.composer_id = 341
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:1efafd34-202a-4275-9537-2f7101a2d0dc'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'Crepúsculo sobre el Guadalquivir', part.name_en = 'Cuatro estampas andaluzas, nº 2: Crepúsculo sobre el Guadalquivir',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 17369 AND p.composer_id = 341 AND part.part_key = 'musicbrainz:bcb5b54c-e4ba-4c06-81ec-e88e7438f6ac' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:bcb5b54c-e4ba-4c06-81ec-e88e7438f6ac', 2, NULL, 'Crepúsculo sobre el Guadalquivir', 'Cuatro estampas andaluzas, nº 2: Crepúsculo sobre el Guadalquivir', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 17369 AND p.composer_id = 341
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:bcb5b54c-e4ba-4c06-81ec-e88e7438f6ac'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = NULL,
    part.name_ko = 'Seguidillas del diablo', part.name_en = 'Cuatro estampas andaluzas, nº 3: Seguidillas del diablo',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 17369 AND p.composer_id = 341 AND part.part_key = 'musicbrainz:c6bb21fe-d041-4bf2-869a-69f840417b41' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:c6bb21fe-d041-4bf2-869a-69f840417b41', 3, NULL, 'Seguidillas del diablo', 'Cuatro estampas andaluzas, nº 3: Seguidillas del diablo', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 17369 AND p.composer_id = 341
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:c6bb21fe-d041-4bf2-869a-69f840417b41'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = NULL,
    part.name_ko = 'Barquitos de Cádiz', part.name_en = 'Cuatro estampas andaluzas, nº 4: Barquitos de Cádiz',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 17369 AND p.composer_id = 341 AND part.part_key = 'musicbrainz:9772531f-2486-4070-9c45-b9b81f8212dc' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:9772531f-2486-4070-9c45-b9b81f8212dc', 4, NULL, 'Barquitos de Cádiz', 'Cuatro estampas andaluzas, nº 4: Barquitos de Cádiz', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 17369 AND p.composer_id = 341
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:9772531f-2486-4070-9c45-b9b81f8212dc'
);


-- None Cuatro madrigales amatorios

UPDATE pieces piece
SET piece.title = 'Cuatro madrigales amatorios', piece.title_en = 'Cuatro madrigales amatorios',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 17421 AND piece.composer_id = 341
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = '¿Con qué la lavaré?', part.name_en = 'Cuatro madrigales amatorios, nº 1: ¿Con qué la lavaré?',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 17421 AND p.composer_id = 341 AND part.part_key = 'musicbrainz:e60cc136-8912-4471-82eb-6a59651d1fad' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:e60cc136-8912-4471-82eb-6a59651d1fad', 1, NULL, '¿Con qué la lavaré?', 'Cuatro madrigales amatorios, nº 1: ¿Con qué la lavaré?', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 17421 AND p.composer_id = 341
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:e60cc136-8912-4471-82eb-6a59651d1fad'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'Vos me matásteis', part.name_en = 'Cuatro madrigales amatorios, nº 2: Vos me matásteis',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 17421 AND p.composer_id = 341 AND part.part_key = 'musicbrainz:99392607-c399-4f96-b96f-e1d0c12ab528' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:99392607-c399-4f96-b96f-e1d0c12ab528', 2, NULL, 'Vos me matásteis', 'Cuatro madrigales amatorios, nº 2: Vos me matásteis', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 17421 AND p.composer_id = 341
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:99392607-c399-4f96-b96f-e1d0c12ab528'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = NULL,
    part.name_ko = '¿De dónde venís, amore?', part.name_en = 'Cuatro madrigales amatorios, nº 3: ¿De dónde venís, amore?',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 17421 AND p.composer_id = 341 AND part.part_key = 'musicbrainz:ff95658f-f8e4-4e42-a10f-f56d8edb731e' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:ff95658f-f8e4-4e42-a10f-f56d8edb731e', 3, NULL, '¿De dónde venís, amore?', 'Cuatro madrigales amatorios, nº 3: ¿De dónde venís, amore?', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 17421 AND p.composer_id = 341
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:ff95658f-f8e4-4e42-a10f-f56d8edb731e'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = NULL,
    part.name_ko = 'De los álamos vengo, madre', part.name_en = 'Cuatro madrigales amatorios, nº 4: De los álamos vengo, madre',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 17421 AND p.composer_id = 341 AND part.part_key = 'musicbrainz:28ed9c6a-5028-44f0-bf21-3fa6951863fd' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:28ed9c6a-5028-44f0-bf21-3fa6951863fd', 4, NULL, 'De los álamos vengo, madre', 'Cuatro madrigales amatorios, nº 4: De los álamos vengo, madre', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 17421 AND p.composer_id = 341
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:28ed9c6a-5028-44f0-bf21-3fa6951863fd'
);


-- None Cántico de San Francisco de Asís

UPDATE pieces piece
SET piece.title = 'Cántico de San Francisco de Asís', piece.title_en = 'Cántico de San Francisco de Asís',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 16647 AND piece.composer_id = 341
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Danza de la amapola

UPDATE pieces piece
SET piece.title = 'Danza de la amapola', piece.title_en = 'Danza de la amapola',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 17023 AND piece.composer_id = 341
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Deux berceuses

UPDATE pieces piece
SET piece.title = 'Deux berceuses', piece.title_en = 'Deux berceuses',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 17815 AND piece.composer_id = 341
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'Berceuse de printemps', part.name_en = 'Deux berceuses: I. Berceuse de printemps',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 17815 AND p.composer_id = 341 AND part.part_key = 'musicbrainz:18d71c25-059d-4a6e-bd0f-fc4dfa28b585' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:18d71c25-059d-4a6e-bd0f-fc4dfa28b585', 1, 'I', 'Berceuse de printemps', 'Deux berceuses: I. Berceuse de printemps', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 17815 AND p.composer_id = 341
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:18d71c25-059d-4a6e-bd0f-fc4dfa28b585'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'Berceuse d''automne', part.name_en = 'Deux berceuses: II. Berceuse d''automne',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 17815 AND p.composer_id = 341 AND part.part_key = 'musicbrainz:660df687-776c-4942-9495-b8af68568dbf' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:660df687-776c-4942-9495-b8af68568dbf', 2, 'II', 'Berceuse d''automne', 'Deux berceuses: II. Berceuse d''automne', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 17815 AND p.composer_id = 341
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:660df687-776c-4942-9495-b8af68568dbf'
);


-- None Dos danzas españolas

UPDATE pieces piece
SET piece.title = 'Dos danzas españolas', piece.title_en = 'Dos danzas españolas',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 19398 AND piece.composer_id = 341
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'Allegro moderato', part.name_en = 'Dos danzas españolas, nº 1: Allegro moderato',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 19398 AND p.composer_id = 341 AND part.part_key = 'musicbrainz:eac6803f-bf03-4659-9e5d-2008fd82f75f' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:eac6803f-bf03-4659-9e5d-2008fd82f75f', 1, NULL, 'Allegro moderato', 'Dos danzas españolas, nº 1: Allegro moderato', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 19398 AND p.composer_id = 341
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:eac6803f-bf03-4659-9e5d-2008fd82f75f'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'Allegro moderato', part.name_en = 'Dos danzas españolas, nº 2: Allegro moderato',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 19398 AND p.composer_id = 341 AND part.part_key = 'musicbrainz:002af183-49d6-4e65-90a3-f311c3991dfa' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:002af183-49d6-4e65-90a3-f311c3991dfa', 2, NULL, 'Allegro moderato', 'Dos danzas españolas, nº 2: Allegro moderato', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 19398 AND p.composer_id = 341
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:002af183-49d6-4e65-90a3-f311c3991dfa'
);


-- None Dos esbozos

UPDATE pieces piece
SET piece.title = 'Dos esbozos', piece.title_en = 'Dos esbozos',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 19909 AND piece.composer_id = 341
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'La enamorada junto al pequeño surtidor: Andantino', part.name_en = 'Dos esbozos: I. La enamorada junto al pequeño surtidor: Andantino',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 19909 AND p.composer_id = 341 AND part.part_key = 'musicbrainz:dbc10d91-2903-4645-9e7d-59b99a86987a' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:dbc10d91-2903-4645-9e7d-59b99a86987a', 1, 'I', 'La enamorada junto al pequeño surtidor: Andantino', 'Dos esbozos: I. La enamorada junto al pequeño surtidor: Andantino', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 19909 AND p.composer_id = 341
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:dbc10d91-2903-4645-9e7d-59b99a86987a'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'Pequeña ronda: Allegro', part.name_en = 'Dos esbozos: II. Pequeña ronda: Allegro',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 19909 AND p.composer_id = 341 AND part.part_key = 'musicbrainz:9272ef4d-b766-4a79-8ec0-713202cc4076' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:9272ef4d-b766-4a79-8ec0-713202cc4076', 2, 'II', 'Pequeña ronda: Allegro', 'Dos esbozos: II. Pequeña ronda: Allegro', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 19909 AND p.composer_id = 341
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:9272ef4d-b766-4a79-8ec0-713202cc4076'
);


-- None Dos miniaturas andaluzas

UPDATE pieces piece
SET piece.title = 'Dos miniaturas andaluzas', piece.title_en = 'Dos miniaturas andaluzas',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 16447 AND piece.composer_id = 341
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'Preludio. Lento e cantabile', part.name_en = 'Dos miniaturas andaluzas: I. Preludio. Lento e cantabile',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 16447 AND p.composer_id = 341 AND part.part_key = 'musicbrainz:4062345a-aeff-451e-b148-7c5e4b1ec422' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:4062345a-aeff-451e-b148-7c5e4b1ec422', 1, 'I', 'Preludio. Lento e cantabile', 'Dos miniaturas andaluzas: I. Preludio. Lento e cantabile', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 16447 AND p.composer_id = 341
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:4062345a-aeff-451e-b148-7c5e4b1ec422'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'Danza. Allegretto, quasi allegro', part.name_en = 'Dos miniaturas andaluzas: II. Danza. Allegretto, quasi allegro',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 16447 AND p.composer_id = 341 AND part.part_key = 'musicbrainz:fc268d64-8cf8-49bd-b596-b80d14258795' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:fc268d64-8cf8-49bd-b596-b80d14258795', 2, 'II', 'Danza. Allegretto, quasi allegro', 'Dos miniaturas andaluzas: II. Danza. Allegretto, quasi allegro', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 16447 AND p.composer_id = 341
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:fc268d64-8cf8-49bd-b596-b80d14258795'
);


-- None Dos pequeñas fantasías

UPDATE pieces piece
SET piece.title = 'Dos pequeñas fantasías', piece.title_en = 'Dos pequeñas fantasías',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 18688 AND piece.composer_id = 341
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = '¡Qué buen caminito!', part.name_en = 'Dos pequeñas fantasías: No. 1. ¡Qué buen caminito!',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 18688 AND p.composer_id = 341 AND part.part_key = 'musicbrainz:b656c7d5-c6c5-4d7f-b143-9ea7469799ad' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:b656c7d5-c6c5-4d7f-b143-9ea7469799ad', 1, NULL, '¡Qué buen caminito!', 'Dos pequeñas fantasías: No. 1. ¡Qué buen caminito!', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 18688 AND p.composer_id = 341
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:b656c7d5-c6c5-4d7f-b143-9ea7469799ad'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'Ecos de Sefarad', part.name_en = 'Dos pequeñas fantasías: No. 2. Ecos de Sefarad',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 18688 AND p.composer_id = 341 AND part.part_key = 'musicbrainz:cec6e074-edad-43ac-9800-73c76b3d1628' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:cec6e074-edad-43ac-9800-73c76b3d1628', 2, NULL, 'Ecos de Sefarad', 'Dos pequeñas fantasías: No. 2. Ecos de Sefarad', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 18688 AND p.composer_id = 341
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:cec6e074-edad-43ac-9800-73c76b3d1628'
);


-- None Dos poemas de Juan Ramón Jiménez

UPDATE pieces piece
SET piece.title = 'Dos poemas de Juan Ramón Jiménez', piece.title_en = 'Dos poemas de Juan Ramón Jiménez',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 16601 AND piece.composer_id = 341
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'N.º 1. Verde, verderol', part.name_en = 'Dos poemas de Juan Ramón Jiménez: N.º 1. Verde, verderol',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 16601 AND p.composer_id = 341 AND part.part_key = 'musicbrainz:acc7de54-8e2f-42d1-bac3-d238b912af88' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:acc7de54-8e2f-42d1-bac3-d238b912af88', 1, NULL, 'N.º 1. Verde, verderol', 'Dos poemas de Juan Ramón Jiménez: N.º 1. Verde, verderol', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 16601 AND p.composer_id = 341
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:acc7de54-8e2f-42d1-bac3-d238b912af88'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'N.º 2. Pájaro del agua', part.name_en = 'Dos poemas de Juan Ramón Jiménez: N.º 2. Pájaro del agua',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 16601 AND p.composer_id = 341 AND part.part_key = 'musicbrainz:6c10e3a9-bcbc-401d-8997-6f0d63935b6f' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:6c10e3a9-bcbc-401d-8997-6f0d63935b6f', 2, NULL, 'N.º 2. Pájaro del agua', 'Dos poemas de Juan Ramón Jiménez: N.º 2. Pájaro del agua', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 16601 AND p.composer_id = 341
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:6c10e3a9-bcbc-401d-8997-6f0d63935b6f'
);


-- None Dos preludios

UPDATE pieces piece
SET piece.title = 'Dos preludios', piece.title_en = 'Dos preludios',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 19257 AND piece.composer_id = 341
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'Adagio', part.name_en = 'Dos preludios: I. Adagio',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 19257 AND p.composer_id = 341 AND part.part_key = 'musicbrainz:d1afd6f4-37aa-43e0-b0af-1884c093f07c' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:d1afd6f4-37aa-43e0-b0af-1884c093f07c', 1, 'I', 'Adagio', 'Dos preludios: I. Adagio', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 19257 AND p.composer_id = 341
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:d1afd6f4-37aa-43e0-b0af-1884c093f07c'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'Allegro', part.name_en = 'Dos preludios: II. Allegro',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 19257 AND p.composer_id = 341 AND part.part_key = 'musicbrainz:e1882da2-8feb-4b73-84b8-52d04df5e0bf' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:e1882da2-8feb-4b73-84b8-52d04df5e0bf', 2, 'II', 'Allegro', 'Dos preludios: II. Allegro', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 19257 AND p.composer_id = 341
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:e1882da2-8feb-4b73-84b8-52d04df5e0bf'
);


-- None Ecos de Sefarad

UPDATE pieces piece
SET piece.title = 'Ecos de Sefarad', piece.title_en = 'Ecos de Sefarad',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 19480 AND piece.composer_id = 341
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Elogio de la guitarra

UPDATE pieces piece
SET piece.title = 'Elogio de la guitarra', piece.title_en = 'Elogio de la guitarra',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 15798 AND piece.composer_id = 341
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'Allegro', part.name_en = 'Elogio de la guitarra: I. Allegro',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 15798 AND p.composer_id = 341 AND part.part_key = 'musicbrainz:19ab1497-9325-37c0-9a61-ea1800da4cdb' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:19ab1497-9325-37c0-9a61-ea1800da4cdb', 1, 'I', 'Allegro', 'Elogio de la guitarra: I. Allegro', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 15798 AND p.composer_id = 341
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:19ab1497-9325-37c0-9a61-ea1800da4cdb'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'Andantino', part.name_en = 'Elogio de la guitarra: II. Andantino',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 15798 AND p.composer_id = 341 AND part.part_key = 'musicbrainz:848aeb65-9121-3ed7-91c3-511f7a642af8' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:848aeb65-9121-3ed7-91c3-511f7a642af8', 2, 'II', 'Andantino', 'Elogio de la guitarra: II. Andantino', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 15798 AND p.composer_id = 341
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:848aeb65-9121-3ed7-91c3-511f7a642af8'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = 'Allegro', part.name_en = 'Elogio de la guitarra: III. Allegro',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 15798 AND p.composer_id = 341 AND part.part_key = 'musicbrainz:edd06881-4df7-3d12-8ac0-9b40b89c926c' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:edd06881-4df7-3d12-8ac0-9b40b89c926c', 3, 'III', 'Allegro', 'Elogio de la guitarra: III. Allegro', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 15798 AND p.composer_id = 341
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:edd06881-4df7-3d12-8ac0-9b40b89c926c'
);


-- None 가곡 <Fino cristal>

UPDATE pieces piece
SET piece.title = '가곡 <Fino cristal>', piece.title_en = 'Fino cristal',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 16069 AND piece.composer_id = 341
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Gran marcha de los subsecretarios

UPDATE pieces piece
SET piece.title = 'Gran marcha de los subsecretarios', piece.title_en = 'Gran marcha de los subsecretarios',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 18478 AND piece.composer_id = 341
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Himnos de los neófitos de Qumran

UPDATE pieces piece
SET piece.title = 'Himnos de los neófitos de Qumran', piece.title_en = 'Himnos de los neófitos de Qumran',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 18441 AND piece.composer_id = 341
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'Rezaré día y noche en todos los instantes', part.name_en = 'Himnos de los neófitos de Qumran: I. Rezaré día y noche en todos los instantes',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 18441 AND p.composer_id = 341 AND part.part_key = 'musicbrainz:9b39181f-6770-4d34-8d04-30589e4fc40f' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:9b39181f-6770-4d34-8d04-30589e4fc40f', 1, 'I', 'Rezaré día y noche en todos los instantes', 'Himnos de los neófitos de Qumran: I. Rezaré día y noche en todos los instantes', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 18441 AND p.composer_id = 341
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:9b39181f-6770-4d34-8d04-30589e4fc40f'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'Y caminaré sobre las llanuras sin límites', part.name_en = 'Himnos de los neófitos de Qumran: II. Y caminaré sobre las llanuras sin límites',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 18441 AND p.composer_id = 341 AND part.part_key = 'musicbrainz:3464a2c3-8ea8-427c-b4e2-a02547c943d9' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:3464a2c3-8ea8-427c-b4e2-a02547c943d9', 2, 'II', 'Y caminaré sobre las llanuras sin límites', 'Himnos de los neófitos de Qumran: II. Y caminaré sobre las llanuras sin límites', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 18441 AND p.composer_id = 341
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:3464a2c3-8ea8-427c-b4e2-a02547c943d9'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = 'Te doy las gracias, O Señor', part.name_en = 'Himnos de los neófitos de Qumran: III. Te doy las gracias, O Señor',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 18441 AND p.composer_id = 341 AND part.part_key = 'musicbrainz:f0d8ba22-bd59-4320-9525-6e93213d586c' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:f0d8ba22-bd59-4320-9525-6e93213d586c', 3, 'III', 'Te doy las gracias, O Señor', 'Himnos de los neófitos de Qumran: III. Te doy las gracias, O Señor', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 18441 AND p.composer_id = 341
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:f0d8ba22-bd59-4320-9525-6e93213d586c'
);


-- None Homenaje a la Tempranica

UPDATE pieces piece
SET piece.title = 'Homenaje a la Tempranica', piece.title_en = 'Homenaje a la Tempranica',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 17384 AND piece.composer_id = 341
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Hommage à Paul Dukas

UPDATE pieces piece
SET piece.title = 'Hommage à Paul Dukas', piece.title_en = 'Hommage à Paul Dukas',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 18678 AND piece.composer_id = 341
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Líricas castellanas

UPDATE pieces piece
SET piece.title = 'Líricas castellanas', piece.title_en = 'Líricas castellanas',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 18880 AND piece.composer_id = 341
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'San Juan y Pascua', part.name_en = 'Líricas castellanas: I. San Juan y Pascua',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 18880 AND p.composer_id = 341 AND part.part_key = 'musicbrainz:5649ae23-2f11-4cab-b08b-885c7fe24cf5' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:5649ae23-2f11-4cab-b08b-885c7fe24cf5', 1, 'I', 'San Juan y Pascua', 'Líricas castellanas: I. San Juan y Pascua', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 18880 AND p.composer_id = 341
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:5649ae23-2f11-4cab-b08b-885c7fe24cf5'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'Despedida y soledad', part.name_en = 'Líricas castellanas: II. Despedida y soledad',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 18880 AND p.composer_id = 341 AND part.part_key = 'musicbrainz:8804d124-c231-4950-9007-0b43babe4210' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:8804d124-c231-4950-9007-0b43babe4210', 2, 'II', 'Despedida y soledad', 'Líricas castellanas: II. Despedida y soledad', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 18880 AND p.composer_id = 341
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:8804d124-c231-4950-9007-0b43babe4210'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = 'Espera del amado', part.name_en = 'Líricas castellanas: III. Espera del amado',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 18880 AND p.composer_id = 341 AND part.part_key = 'musicbrainz:cbed05a4-00c7-4008-8bf3-0e8c9484a0ce' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:cbed05a4-00c7-4008-8bf3-0e8c9484a0ce', 3, 'III', 'Espera del amado', 'Líricas castellanas: III. Espera del amado', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 18880 AND p.composer_id = 341
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:cbed05a4-00c7-4008-8bf3-0e8c9484a0ce'
);


-- None Música para un códice salmantino

UPDATE pieces piece
SET piece.title = 'Música para un códice salmantino', piece.title_en = 'Música para un códice salmantino',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 18153 AND piece.composer_id = 341
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Música para un jardín

UPDATE pieces piece
SET piece.title = 'Música para un jardín', piece.title_en = 'Música para un jardín',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 17516 AND piece.composer_id = 341
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'Preludio', part.name_en = 'Música para un jardín: I. Preludio',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 17516 AND p.composer_id = 341 AND part.part_key = 'musicbrainz:f009ec03-f66e-4b0f-aefc-babda089a28c' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:f009ec03-f66e-4b0f-aefc-babda089a28c', 1, 'I', 'Preludio', 'Música para un jardín: I. Preludio', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 17516 AND p.composer_id = 341
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:f009ec03-f66e-4b0f-aefc-babda089a28c'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'Berceuse de otoño', part.name_en = 'Música para un jardín: II. Berceuse de otoño',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 17516 AND p.composer_id = 341 AND part.part_key = 'musicbrainz:a34581ff-cf52-4aec-8676-ffaccc127fdf' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:a34581ff-cf52-4aec-8676-ffaccc127fdf', 2, 'II', 'Berceuse de otoño', 'Música para un jardín: II. Berceuse de otoño', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 17516 AND p.composer_id = 341
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:a34581ff-cf52-4aec-8676-ffaccc127fdf'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = 'Berceuse de invierno', part.name_en = 'Música para un jardín: III. Berceuse de invierno',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 17516 AND p.composer_id = 341 AND part.part_key = 'musicbrainz:67fa340e-ce80-4047-a25f-007930d61e76' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:67fa340e-ce80-4047-a25f-007930d61e76', 3, 'III', 'Berceuse de invierno', 'Música para un jardín: III. Berceuse de invierno', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 17516 AND p.composer_id = 341
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:67fa340e-ce80-4047-a25f-007930d61e76'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = 'IV',
    part.name_ko = 'Introducción a la berceuse de primavera', part.name_en = 'Música para un jardín: IV. Introducción a la berceuse de primavera',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 17516 AND p.composer_id = 341 AND part.part_key = 'musicbrainz:5a309db5-2ae2-4ae4-9e67-a128e9c53b5f' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:5a309db5-2ae2-4ae4-9e67-a128e9c53b5f', 4, 'IV', 'Introducción a la berceuse de primavera', 'Música para un jardín: IV. Introducción a la berceuse de primavera', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 17516 AND p.composer_id = 341
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:5a309db5-2ae2-4ae4-9e67-a128e9c53b5f'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 5, part.movement_number = 'V',
    part.name_ko = 'Berceuse de primavera', part.name_en = 'Música para un jardín: V. Berceuse de primavera',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 17516 AND p.composer_id = 341 AND part.part_key = 'musicbrainz:df26fadd-70cf-4421-88a0-401fddce5a76' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:df26fadd-70cf-4421-88a0-401fddce5a76', 5, 'V', 'Berceuse de primavera', 'Música para un jardín: V. Berceuse de primavera', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 17516 AND p.composer_id = 341
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:df26fadd-70cf-4421-88a0-401fddce5a76'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 6, part.movement_number = 'VI',
    part.name_ko = 'Berceuse de verano', part.name_en = 'Música para un jardín: VI. Berceuse de verano',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 17516 AND p.composer_id = 341 AND part.part_key = 'musicbrainz:b4c65bba-0cbc-4d4e-bfd3-67730d48f59a' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:b4c65bba-0cbc-4d4e-bfd3-67730d48f59a', 6, 'VI', 'Berceuse de verano', 'Música para un jardín: VI. Berceuse de verano', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 17516 AND p.composer_id = 341
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:b4c65bba-0cbc-4d4e-bfd3-67730d48f59a'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 7, part.movement_number = 'VII',
    part.name_ko = 'Postludio', part.name_en = 'Música para un jardín: VII. Postludio',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 17516 AND p.composer_id = 341 AND part.part_key = 'musicbrainz:339386a9-0489-4a93-a01b-4aebc1570043' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:339386a9-0489-4a93-a01b-4aebc1570043', 7, 'VII', 'Postludio', 'Música para un jardín: VII. Postludio', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 17516 AND p.composer_id = 341
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:339386a9-0489-4a93-a01b-4aebc1570043'
);


-- None Palillos y panderetas

UPDATE pieces piece
SET piece.title = 'Palillos y panderetas', piece.title_en = 'Palillos y panderetas',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 18957 AND piece.composer_id = 341
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'Prado del Manzanares', part.name_en = 'Palillos y panderetas: I. Prado del Manzanares',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 18957 AND p.composer_id = 341 AND part.part_key = 'musicbrainz:a0bcab0e-07f3-47f4-94b9-9dd3c9f16388' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:a0bcab0e-07f3-47f4-94b9-9dd3c9f16388', 1, 'I', 'Prado del Manzanares', 'Palillos y panderetas: I. Prado del Manzanares', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 18957 AND p.composer_id = 341
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:a0bcab0e-07f3-47f4-94b9-9dd3c9f16388'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'Pastoral', part.name_en = 'Palillos y panderetas: II. Pastoral',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 18957 AND p.composer_id = 341 AND part.part_key = 'musicbrainz:9529fd76-083b-4260-a96a-2e3a0a91ec1d' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:9529fd76-083b-4260-a96a-2e3a0a91ec1d', 2, 'II', 'Pastoral', 'Palillos y panderetas: II. Pastoral', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 18957 AND p.composer_id = 341
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:9529fd76-083b-4260-a96a-2e3a0a91ec1d'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = 'Alegre mañana', part.name_en = 'Palillos y panderetas: III. Alegre mañana',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 18957 AND p.composer_id = 341 AND part.part_key = 'musicbrainz:c98cb007-2304-47a7-b1ee-810aa0fdf7f3' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:c98cb007-2304-47a7-b1ee-810aa0fdf7f3', 3, 'III', 'Alegre mañana', 'Palillos y panderetas: III. Alegre mañana', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 18957 AND p.composer_id = 341
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:c98cb007-2304-47a7-b1ee-810aa0fdf7f3'
);


-- None Pequeña fantasía

UPDATE pieces piece
SET piece.title = 'Pequeña fantasía', piece.title_en = 'Pequeña fantasía',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 16963 AND piece.composer_id = 341
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Por los campos de España

UPDATE pieces piece
SET piece.title = 'Por los campos de España', piece.title_en = 'Por los campos de España',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 19114 AND piece.composer_id = 341
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'En los trigales', part.name_en = 'Por los campos de España, nº 1: En los trigales',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 19114 AND p.composer_id = 341 AND part.part_key = 'musicbrainz:c71f78b1-5870-3913-a33f-de0facae240b' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:c71f78b1-5870-3913-a33f-de0facae240b', 1, NULL, 'En los trigales', 'Por los campos de España, nº 1: En los trigales', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 19114 AND p.composer_id = 341
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:c71f78b1-5870-3913-a33f-de0facae240b'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'Junto al Generalife', part.name_en = 'Por los campos de España, nº 2: Junto al Generalife',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 19114 AND p.composer_id = 341 AND part.part_key = 'musicbrainz:7aa724ff-6caf-34d6-84b3-d225708849f9' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:7aa724ff-6caf-34d6-84b3-d225708849f9', 2, NULL, 'Junto al Generalife', 'Por los campos de España, nº 2: Junto al Generalife', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 19114 AND p.composer_id = 341
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:7aa724ff-6caf-34d6-84b3-d225708849f9'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = NULL,
    part.name_ko = 'Bajando de la meseta', part.name_en = 'Por los campos de España, nº 3: Bajando de la meseta',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 19114 AND p.composer_id = 341 AND part.part_key = 'musicbrainz:1eb5e819-60dd-307c-819e-89700a24ee27' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:1eb5e819-60dd-307c-819e-89700a24ee27', 3, NULL, 'Bajando de la meseta', 'Por los campos de España, nº 3: Bajando de la meseta', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 19114 AND p.composer_id = 341
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:1eb5e819-60dd-307c-819e-89700a24ee27'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = NULL,
    part.name_ko = 'En tierras de Jerez', part.name_en = 'Por los campos de España, nº 4: En tierras de Jerez',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 19114 AND p.composer_id = 341 AND part.part_key = 'musicbrainz:79da3350-06f3-4caf-8d46-ce137eb9553c' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:79da3350-06f3-4caf-8d46-ce137eb9553c', 4, NULL, 'En tierras de Jerez', 'Por los campos de España, nº 4: En tierras de Jerez', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 19114 AND p.composer_id = 341
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:79da3350-06f3-4caf-8d46-ce137eb9553c'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 5, part.movement_number = NULL,
    part.name_ko = 'Entre olivares', part.name_en = 'Por los campos de España, nº 5: Entre olivares',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 19114 AND p.composer_id = 341 AND part.part_key = 'musicbrainz:43bb9ae6-9721-47cc-a7e9-d33bd911221a' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:43bb9ae6-9721-47cc-a7e9-d33bd911221a', 5, NULL, 'Entre olivares', 'Por los campos de España, nº 5: Entre olivares', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 19114 AND p.composer_id = 341
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:43bb9ae6-9721-47cc-a7e9-d33bd911221a'
);


-- None Preludio al gallo mañanero

UPDATE pieces piece
SET piece.title = 'Preludio al gallo mañanero', piece.title_en = 'Preludio al gallo mañanero',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 19511 AND piece.composer_id = 341
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Preludio de añoranza

UPDATE pieces piece
SET piece.title = 'Preludio de añoranza', piece.title_en = 'Preludio de añoranza',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 19099 AND piece.composer_id = 341
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Preludio para un poema a la Alhambra

UPDATE pieces piece
SET piece.title = 'Preludio para un poema a la Alhambra', piece.title_en = 'Preludio para un poema a la Alhambra',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 16364 AND piece.composer_id = 341
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Preludio y ritornello

UPDATE pieces piece
SET piece.title = 'Preludio y ritornello', piece.title_en = 'Preludio y ritornello',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 18635 AND piece.composer_id = 341
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'Preludio', part.name_en = 'Preludio y ritornello: Preludio',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 18635 AND p.composer_id = 341 AND part.part_key = 'musicbrainz:de04c921-9011-46d6-a8cc-6252a76bcb3c' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:de04c921-9011-46d6-a8cc-6252a76bcb3c', 1, NULL, 'Preludio', 'Preludio y ritornello: Preludio', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 18635 AND p.composer_id = 341
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:de04c921-9011-46d6-a8cc-6252a76bcb3c'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'Ritornello', part.name_en = 'Preludio y ritornello: Ritornello',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 18635 AND p.composer_id = 341 AND part.part_key = 'musicbrainz:fc5da84f-e77e-4ac9-83a5-73155d47bbc0' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:fc5da84f-e77e-4ac9-83a5-73155d47bbc0', 2, NULL, 'Ritornello', 'Preludio y ritornello: Ritornello', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 18635 AND p.composer_id = 341
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:fc5da84f-e77e-4ac9-83a5-73155d47bbc0'
);


-- None Pájaros de primavera

UPDATE pieces piece
SET piece.title = 'Pájaros de primavera', piece.title_en = 'Pájaros de primavera',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 15828 AND piece.composer_id = 341
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Quatre cançons en llengua catalana

UPDATE pieces piece
SET piece.title = 'Quatre cançons en llengua catalana', piece.title_en = 'Quatre cançons en llengua catalana',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 18139 AND piece.composer_id = 341
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'Núm. 1. Cançó del teuladí', part.name_en = 'Quatre cançons en llengua catalana: Núm. 1. Cançó del teuladí',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 18139 AND p.composer_id = 341 AND part.part_key = 'musicbrainz:adb7582f-1fac-4ee7-a867-d5e97ebb12ed' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:adb7582f-1fac-4ee7-a867-d5e97ebb12ed', 1, NULL, 'Núm. 1. Cançó del teuladí', 'Quatre cançons en llengua catalana: Núm. 1. Cançó del teuladí', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 18139 AND p.composer_id = 341
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:adb7582f-1fac-4ee7-a867-d5e97ebb12ed'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'Núm. 2. Canticel', part.name_en = 'Quatre cançons en llengua catalana: Núm. 2. Canticel',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 18139 AND p.composer_id = 341 AND part.part_key = 'musicbrainz:4e8346ad-b990-485a-926a-e682f35b2424' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:4e8346ad-b990-485a-926a-e682f35b2424', 2, NULL, 'Núm. 2. Canticel', 'Quatre cançons en llengua catalana: Núm. 2. Canticel', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 18139 AND p.composer_id = 341
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:4e8346ad-b990-485a-926a-e682f35b2424'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = NULL,
    part.name_ko = 'Núm. 3. L''inquietut primaveral de la donçella', part.name_en = 'Quatre cançons en llengua catalana: Núm. 3. L''inquietut primaveral de la donçella',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 18139 AND p.composer_id = 341 AND part.part_key = 'musicbrainz:2c8feec6-ec3c-4dbf-85a5-a3c400d5f23f' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:2c8feec6-ec3c-4dbf-85a5-a3c400d5f23f', 3, NULL, 'Núm. 3. L''inquietut primaveral de la donçella', 'Quatre cançons en llengua catalana: Núm. 3. L''inquietut primaveral de la donçella', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 18139 AND p.composer_id = 341
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:2c8feec6-ec3c-4dbf-85a5-a3c400d5f23f'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = NULL,
    part.name_ko = 'Núm. 4. Brollador gentil', part.name_en = 'Quatre cançons en llengua catalana: Núm. 4. Brollador gentil',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 18139 AND p.composer_id = 341 AND part.part_key = 'musicbrainz:038aa416-3e8a-4be6-84d1-e82b1212afd4' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:038aa416-3e8a-4be6-84d1-e82b1212afd4', 4, NULL, 'Núm. 4. Brollador gentil', 'Quatre cançons en llengua catalana: Núm. 4. Brollador gentil', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 18139 AND p.composer_id = 341
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:038aa416-3e8a-4be6-84d1-e82b1212afd4'
);


-- None Retablo de Navidad

UPDATE pieces piece
SET piece.title = 'Retablo de Navidad', piece.title_en = 'Retablo de Navidad',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 17376 AND piece.composer_id = 341
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'Villancicos', part.name_en = 'Retablo de Navidad: Villancicos',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 17376 AND p.composer_id = 341 AND part.part_key = 'musicbrainz:322c8c9e-dbaf-4cc4-bc75-1cd1e7981c7d' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:322c8c9e-dbaf-4cc4-bc75-1cd1e7981c7d', 1, NULL, 'Villancicos', 'Retablo de Navidad: Villancicos', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 17376 AND p.composer_id = 341
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:322c8c9e-dbaf-4cc4-bc75-1cd1e7981c7d'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:322c8c9e-dbaf-4cc4-bc75-1cd1e7981c7d'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'Pastorcito santo', part.name_en = 'Retablo de Navidad: Villancicos, nº 1: Pastorcito santo',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 17376 AND p.composer_id = 341 AND part.part_key = 'musicbrainz:955114a4-9ed8-482c-880b-48369b9f54e6' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:955114a4-9ed8-482c-880b-48369b9f54e6', 1, NULL, 'Pastorcito santo', 'Retablo de Navidad: Villancicos, nº 1: Pastorcito santo', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:322c8c9e-dbaf-4cc4-bc75-1cd1e7981c7d'
WHERE p.id = 17376 AND p.composer_id = 341
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:955114a4-9ed8-482c-880b-48369b9f54e6'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:322c8c9e-dbaf-4cc4-bc75-1cd1e7981c7d'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'Coplillas de Belén', part.name_en = 'Retablo de Navidad: Villancicos, nº 2: Coplillas de Belén',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 17376 AND p.composer_id = 341 AND part.part_key = 'musicbrainz:14f2800d-829d-4137-9ee3-7504b66f4761' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:14f2800d-829d-4137-9ee3-7504b66f4761', 2, NULL, 'Coplillas de Belén', 'Retablo de Navidad: Villancicos, nº 2: Coplillas de Belén', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:322c8c9e-dbaf-4cc4-bc75-1cd1e7981c7d'
WHERE p.id = 17376 AND p.composer_id = 341
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:14f2800d-829d-4137-9ee3-7504b66f4761'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:322c8c9e-dbaf-4cc4-bc75-1cd1e7981c7d'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = NULL,
    part.name_ko = 'Aire y donaire', part.name_en = 'Retablo de Navidad: Villancicos, nº 3: Aire y donaire',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 17376 AND p.composer_id = 341 AND part.part_key = 'musicbrainz:07838e44-8a44-4d46-ac61-a0824cd2e139' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:07838e44-8a44-4d46-ac61-a0824cd2e139', 3, NULL, 'Aire y donaire', 'Retablo de Navidad: Villancicos, nº 3: Aire y donaire', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:322c8c9e-dbaf-4cc4-bc75-1cd1e7981c7d'
WHERE p.id = 17376 AND p.composer_id = 341
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:07838e44-8a44-4d46-ac61-a0824cd2e139'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'Canciones de Navidad', part.name_en = 'Retablo de Navidad: Canciones de Navidad',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 17376 AND p.composer_id = 341 AND part.part_key = 'musicbrainz:74e618a7-98d4-4c3a-b4bf-1465d26a168e' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:74e618a7-98d4-4c3a-b4bf-1465d26a168e', 2, NULL, 'Canciones de Navidad', 'Retablo de Navidad: Canciones de Navidad', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 17376 AND p.composer_id = 341
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:74e618a7-98d4-4c3a-b4bf-1465d26a168e'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:74e618a7-98d4-4c3a-b4bf-1465d26a168e'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'Cantan por Belén pastores', part.name_en = 'Retablo de Navidad: Canciones de Navidad, nº 1: Cantan por Belén pastores',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 17376 AND p.composer_id = 341 AND part.part_key = 'musicbrainz:ae1babb4-c1e2-491e-9d01-9f22a46ebaec' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:ae1babb4-c1e2-491e-9d01-9f22a46ebaec', 1, NULL, 'Cantan por Belén pastores', 'Retablo de Navidad: Canciones de Navidad, nº 1: Cantan por Belén pastores', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:74e618a7-98d4-4c3a-b4bf-1465d26a168e'
WHERE p.id = 17376 AND p.composer_id = 341
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:ae1babb4-c1e2-491e-9d01-9f22a46ebaec'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:74e618a7-98d4-4c3a-b4bf-1465d26a168e'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'Duérmete, niño', part.name_en = 'Retablo de Navidad: Canciones de Navidad, nº 2: Duérmete, niño',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 17376 AND p.composer_id = 341 AND part.part_key = 'musicbrainz:134ce2a9-a2f8-495b-b477-15d6eec15e8c' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:134ce2a9-a2f8-495b-b477-15d6eec15e8c', 2, NULL, 'Duérmete, niño', 'Retablo de Navidad: Canciones de Navidad, nº 2: Duérmete, niño', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:74e618a7-98d4-4c3a-b4bf-1465d26a168e'
WHERE p.id = 17376 AND p.composer_id = 341
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:134ce2a9-a2f8-495b-b477-15d6eec15e8c'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:74e618a7-98d4-4c3a-b4bf-1465d26a168e'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = NULL,
    part.name_ko = 'A la clavelina', part.name_en = 'Retablo de Navidad: Canciones de Navidad, nº 3: A la clavelina',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 17376 AND p.composer_id = 341 AND part.part_key = 'musicbrainz:6d64fc6d-8343-4370-b143-b4e005475402' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:6d64fc6d-8343-4370-b143-b4e005475402', 3, NULL, 'A la clavelina', 'Retablo de Navidad: Canciones de Navidad, nº 3: A la clavelina', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:74e618a7-98d4-4c3a-b4bf-1465d26a168e'
WHERE p.id = 17376 AND p.composer_id = 341
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:6d64fc6d-8343-4370-b143-b4e005475402'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:74e618a7-98d4-4c3a-b4bf-1465d26a168e'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = NULL,
    part.name_ko = 'A la chiribirivuela', part.name_en = 'Retablo de Navidad: Canciones de Navidad, nº 4: A la chiribirivuela',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 17376 AND p.composer_id = 341 AND part.part_key = 'musicbrainz:7b576127-bc19-4568-9d54-8de6b400107e' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:7b576127-bc19-4568-9d54-8de6b400107e', 4, NULL, 'A la chiribirivuela', 'Retablo de Navidad: Canciones de Navidad, nº 4: A la chiribirivuela', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:74e618a7-98d4-4c3a-b4bf-1465d26a168e'
WHERE p.id = 17376 AND p.composer_id = 341
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:7b576127-bc19-4568-9d54-8de6b400107e'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:74e618a7-98d4-4c3a-b4bf-1465d26a168e'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 5, part.movement_number = NULL,
    part.name_ko = 'La espera', part.name_en = 'Retablo de Navidad: Canciones de Navidad, nº 5: La espera',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 17376 AND p.composer_id = 341 AND part.part_key = 'musicbrainz:de059b95-025a-4674-9535-ccdc0b787f2f' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:de059b95-025a-4674-9535-ccdc0b787f2f', 5, NULL, 'La espera', 'Retablo de Navidad: Canciones de Navidad, nº 5: La espera', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:74e618a7-98d4-4c3a-b4bf-1465d26a168e'
WHERE p.id = 17376 AND p.composer_id = 341
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:de059b95-025a-4674-9535-ccdc0b787f2f'
);


-- None Romance de Durandarte

UPDATE pieces piece
SET piece.title = 'Romance de Durandarte', piece.title_en = 'Romance de Durandarte',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 16722 AND piece.composer_id = 341
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Romance del Comendador de Ocaña

UPDATE pieces piece
SET piece.title = 'Romance del Comendador de Ocaña', piece.title_en = 'Romance del Comendador de Ocaña',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 19340 AND piece.composer_id = 341
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Rosaliana

UPDATE pieces piece
SET piece.title = 'Rosaliana', piece.title_en = 'Rosaliana',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 18416 AND piece.composer_id = 341
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'Cantart''ei, Galicia', part.name_en = 'Rosaliana, nº 1: Cantart''ei, Galicia',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 18416 AND p.composer_id = 341 AND part.part_key = 'musicbrainz:27f930f8-4af6-485d-81cb-861bbcdbe3ec' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:27f930f8-4af6-485d-81cb-861bbcdbe3ec', 1, NULL, 'Cantart''ei, Galicia', 'Rosaliana, nº 1: Cantart''ei, Galicia', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 18416 AND p.composer_id = 341
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:27f930f8-4af6-485d-81cb-861bbcdbe3ec'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = '¿Por qué?', part.name_en = 'Rosaliana, nº 2: ¿Por qué?',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 18416 AND p.composer_id = 341 AND part.part_key = 'musicbrainz:ae6fd99c-6f4b-45aa-9e39-0ac0bc18d0cb' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:ae6fd99c-6f4b-45aa-9e39-0ac0bc18d0cb', 2, NULL, '¿Por qué?', 'Rosaliana, nº 2: ¿Por qué?', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 18416 AND p.composer_id = 341
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:ae6fd99c-6f4b-45aa-9e39-0ac0bc18d0cb'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = NULL,
    part.name_ko = 'Adiós ríos, adiós fontes', part.name_en = 'Rosaliana, nº 3: Adiós ríos, adiós fontes',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 18416 AND p.composer_id = 341 AND part.part_key = 'musicbrainz:bf1a1425-c685-4924-b780-bd5615f351aa' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:bf1a1425-c685-4924-b780-bd5615f351aa', 3, NULL, 'Adiós ríos, adiós fontes', 'Rosaliana, nº 3: Adiós ríos, adiós fontes', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 18416 AND p.composer_id = 341
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:bf1a1425-c685-4924-b780-bd5615f351aa'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = NULL,
    part.name_ko = '¡Vamos bebendo!', part.name_en = 'Rosaliana, nº 4: ¡Vamos bebendo!',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 18416 AND p.composer_id = 341 AND part.part_key = 'musicbrainz:dad8a0b8-4676-45cb-88f2-ec3d050c0476' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:dad8a0b8-4676-45cb-88f2-ec3d050c0476', 4, NULL, '¡Vamos bebendo!', 'Rosaliana, nº 4: ¡Vamos bebendo!', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 18416 AND p.composer_id = 341
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:dad8a0b8-4676-45cb-88f2-ec3d050c0476'
);


-- None Rumaniana

UPDATE pieces piece
SET piece.title = 'Rumaniana', piece.title_en = 'Rumaniana',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 16879 AND piece.composer_id = 341
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Seis arias de "El hijo fingido"

UPDATE pieces piece
SET piece.title = 'Seis arias de "El hijo fingido"', piece.title_en = 'Seis arias de "El hijo fingido"',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 19177 AND piece.composer_id = 341
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'Coplillas del alférez', part.name_en = 'Seis arias de "El hijo fingido", nº 1: Coplillas del alférez',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 19177 AND p.composer_id = 341 AND part.part_key = 'musicbrainz:317febc9-7bf9-4bad-b136-72ed966704aa' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:317febc9-7bf9-4bad-b136-72ed966704aa', 1, NULL, 'Coplillas del alférez', 'Seis arias de "El hijo fingido", nº 1: Coplillas del alférez', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 19177 AND p.composer_id = 341
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:317febc9-7bf9-4bad-b136-72ed966704aa'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'Canción de Bárbara', part.name_en = 'Seis arias de "El hijo fingido", nº 2: Canción de Bárbara',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 19177 AND p.composer_id = 341 AND part.part_key = 'musicbrainz:d372fee3-f2f4-4964-9ae3-938935600caf' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:d372fee3-f2f4-4964-9ae3-938935600caf', 2, NULL, 'Canción de Bárbara', 'Seis arias de "El hijo fingido", nº 2: Canción de Bárbara', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 19177 AND p.composer_id = 341
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:d372fee3-f2f4-4964-9ae3-938935600caf'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = NULL,
    part.name_ko = 'Cavaletta de Leonardo', part.name_en = 'Seis arias de "El hijo fingido", nº 3: Cavaletta de Leonardo',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 19177 AND p.composer_id = 341 AND part.part_key = 'musicbrainz:575a6532-d702-4a62-92c3-851bae4e2c93' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:575a6532-d702-4a62-92c3-851bae4e2c93', 3, NULL, 'Cavaletta de Leonardo', 'Seis arias de "El hijo fingido", nº 3: Cavaletta de Leonardo', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 19177 AND p.composer_id = 341
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:575a6532-d702-4a62-92c3-851bae4e2c93'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = NULL,
    part.name_ko = 'Romanza de Ángela', part.name_en = 'Seis arias de "El hijo fingido", nº 4: Romanza de Ángela',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 19177 AND p.composer_id = 341 AND part.part_key = 'musicbrainz:5469e3b1-486a-4be4-9cc5-a34db4febd62' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:5469e3b1-486a-4be4-9cc5-a34db4febd62', 4, NULL, 'Romanza de Ángela', 'Seis arias de "El hijo fingido", nº 4: Romanza de Ángela', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 19177 AND p.composer_id = 341
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:5469e3b1-486a-4be4-9cc5-a34db4febd62'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 5, part.movement_number = NULL,
    part.name_ko = 'Canción de Ángela', part.name_en = 'Seis arias de "El hijo fingido", nº 5: Canción de Ángela',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 19177 AND p.composer_id = 341 AND part.part_key = 'musicbrainz:be6313d5-42c2-4c72-a114-500144bc0cc9' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:be6313d5-42c2-4c72-a114-500144bc0cc9', 5, NULL, 'Canción de Ángela', 'Seis arias de "El hijo fingido", nº 5: Canción de Ángela', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 19177 AND p.composer_id = 341
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:be6313d5-42c2-4c72-a114-500144bc0cc9'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 6, part.movement_number = NULL,
    part.name_ko = 'Romanza de Ángela', part.name_en = 'Seis arias de "El hijo fingido", nº 6: Romanza de Ángela',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 19177 AND p.composer_id = 341 AND part.part_key = 'musicbrainz:ebdb3d85-aa2a-498a-bddf-d20ec892a39f' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:ebdb3d85-aa2a-498a-bddf-d20ec892a39f', 6, NULL, 'Romanza de Ángela', 'Seis arias de "El hijo fingido", nº 6: Romanza de Ángela', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 19177 AND p.composer_id = 341
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:ebdb3d85-aa2a-498a-bddf-d20ec892a39f'
);


-- None Serenata al alba del día

UPDATE pieces piece
SET piece.title = 'Serenata al alba del día', piece.title_en = 'Serenata al alba del día',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 16933 AND piece.composer_id = 341
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'Andante moderato', part.name_en = 'Serenata al alba del día: I. Andante moderato',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 16933 AND p.composer_id = 341 AND part.part_key = 'musicbrainz:5025fafa-1de5-499a-8c68-f9d1496f1a57' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:5025fafa-1de5-499a-8c68-f9d1496f1a57', 1, 'I', 'Andante moderato', 'Serenata al alba del día: I. Andante moderato', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 16933 AND p.composer_id = 341
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:5025fafa-1de5-499a-8c68-f9d1496f1a57'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'Allegro', part.name_en = 'Serenata al alba del día: II. Allegro',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 16933 AND p.composer_id = 341 AND part.part_key = 'musicbrainz:80ce32a9-01ec-472e-9a9e-011fa9de9311' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:80ce32a9-01ec-472e-9a9e-011fa9de9311', 2, 'II', 'Allegro', 'Serenata al alba del día: II. Allegro', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 16933 AND p.composer_id = 341
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:80ce32a9-01ec-472e-9a9e-011fa9de9311'
);


-- None Serenata española

UPDATE pieces piece
SET piece.title = 'Serenata española', piece.title_en = 'Serenata española',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 19533 AND piece.composer_id = 341
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Set cançons valencianes

UPDATE pieces piece
SET piece.title = 'Set cançons valencianes', piece.title_en = 'Set cançons valencianes',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 17117 AND piece.composer_id = 341
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'Allegretto', part.name_en = 'Set cançons valencianes: No. 1. Allegretto',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 17117 AND p.composer_id = 341 AND part.part_key = 'musicbrainz:656f2d4e-bb2a-4a9a-a81b-ae607ef9d2da' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:656f2d4e-bb2a-4a9a-a81b-ae607ef9d2da', 1, NULL, 'Allegretto', 'Set cançons valencianes: No. 1. Allegretto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 17117 AND p.composer_id = 341
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:656f2d4e-bb2a-4a9a-a81b-ae607ef9d2da'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'Andante moderato', part.name_en = 'Set cançons valencianes: No. 2. Andante moderato',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 17117 AND p.composer_id = 341 AND part.part_key = 'musicbrainz:3d05691d-ce32-4b18-a9e3-824ae680fc01' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:3d05691d-ce32-4b18-a9e3-824ae680fc01', 2, NULL, 'Andante moderato', 'Set cançons valencianes: No. 2. Andante moderato', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 17117 AND p.composer_id = 341
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:3d05691d-ce32-4b18-a9e3-824ae680fc01'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = NULL,
    part.name_ko = 'Allegro', part.name_en = 'Set cançons valencianes: No. 3. Allegro',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 17117 AND p.composer_id = 341 AND part.part_key = 'musicbrainz:f8eb356d-a521-4b91-8abc-373375855998' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:f8eb356d-a521-4b91-8abc-373375855998', 3, NULL, 'Allegro', 'Set cançons valencianes: No. 3. Allegro', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 17117 AND p.composer_id = 341
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:f8eb356d-a521-4b91-8abc-373375855998'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = NULL,
    part.name_ko = 'Andante moderato e molto cantabile', part.name_en = 'Set cançons valencianes: No. 4. Andante moderato e molto cantabile',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 17117 AND p.composer_id = 341 AND part.part_key = 'musicbrainz:64dc0749-e0dc-413a-af4d-4c50d1777105' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:64dc0749-e0dc-413a-af4d-4c50d1777105', 4, NULL, 'Andante moderato e molto cantabile', 'Set cançons valencianes: No. 4. Andante moderato e molto cantabile', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 17117 AND p.composer_id = 341
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:64dc0749-e0dc-413a-af4d-4c50d1777105'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 5, part.movement_number = NULL,
    part.name_ko = 'Andantino', part.name_en = 'Set cançons valencianes: No. 5. Andantino',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 17117 AND p.composer_id = 341 AND part.part_key = 'musicbrainz:23f036cc-6b37-4802-9424-ee16978f19ac' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:23f036cc-6b37-4802-9424-ee16978f19ac', 5, NULL, 'Andantino', 'Set cançons valencianes: No. 5. Andantino', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 17117 AND p.composer_id = 341
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:23f036cc-6b37-4802-9424-ee16978f19ac'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 6, part.movement_number = NULL,
    part.name_ko = 'Andante religioso', part.name_en = 'Set cançons valencianes: No. 6. Andante religioso',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 17117 AND p.composer_id = 341 AND part.part_key = 'musicbrainz:ca966ac4-00c4-4d06-86e6-59f186816514' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:ca966ac4-00c4-4d06-86e6-59f186816514', 6, NULL, 'Andante religioso', 'Set cançons valencianes: No. 6. Andante religioso', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 17117 AND p.composer_id = 341
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:ca966ac4-00c4-4d06-86e6-59f186816514'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 7, part.movement_number = NULL,
    part.name_ko = 'Tempo di bolero (Moderato)', part.name_en = 'Set cançons valencianes: No. 7. Tempo di bolero (Moderato)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 17117 AND p.composer_id = 341 AND part.part_key = 'musicbrainz:8e5f2ef8-21ae-4410-a3f6-f1965d23d9f4' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:8e5f2ef8-21ae-4410-a3f6-f1965d23d9f4', 7, NULL, 'Tempo di bolero (Moderato)', 'Set cançons valencianes: No. 7. Tempo di bolero (Moderato)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 17117 AND p.composer_id = 341
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:8e5f2ef8-21ae-4410-a3f6-f1965d23d9f4'
);


-- None Soleriana

UPDATE pieces piece
SET piece.title = 'Soleriana', piece.title_en = 'Soleriana',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 17944 AND piece.composer_id = 341
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'Entrada', part.name_en = 'Soleriana: I. Entrada',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 17944 AND p.composer_id = 341 AND part.part_key = 'musicbrainz:4b29cc8d-5595-45ea-95b4-170839a134b8' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:4b29cc8d-5595-45ea-95b4-170839a134b8', 1, 'I', 'Entrada', 'Soleriana: I. Entrada', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 17944 AND p.composer_id = 341
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:4b29cc8d-5595-45ea-95b4-170839a134b8'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'Fandango', part.name_en = 'Soleriana: II. Fandango',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 17944 AND p.composer_id = 341 AND part.part_key = 'musicbrainz:4e7c78d3-3a8c-4d43-9092-3d84316f1cb9' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:4e7c78d3-3a8c-4d43-9092-3d84316f1cb9', 2, 'II', 'Fandango', 'Soleriana: II. Fandango', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 17944 AND p.composer_id = 341
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:4e7c78d3-3a8c-4d43-9092-3d84316f1cb9'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = 'Tourbillon', part.name_en = 'Soleriana: III. Tourbillon',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 17944 AND p.composer_id = 341 AND part.part_key = 'musicbrainz:3370ec89-0542-4f1d-9dae-fa53ed6f68e4' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:3370ec89-0542-4f1d-9dae-fa53ed6f68e4', 3, 'III', 'Tourbillon', 'Soleriana: III. Tourbillon', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 17944 AND p.composer_id = 341
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:3370ec89-0542-4f1d-9dae-fa53ed6f68e4'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = 'IV',
    part.name_ko = 'Pastoral', part.name_en = 'Soleriana: IV. Pastoral',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 17944 AND p.composer_id = 341 AND part.part_key = 'musicbrainz:3e205d41-f2e0-49f7-ba0a-b3a9699a852c' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:3e205d41-f2e0-49f7-ba0a-b3a9699a852c', 4, 'IV', 'Pastoral', 'Soleriana: IV. Pastoral', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 17944 AND p.composer_id = 341
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:3e205d41-f2e0-49f7-ba0a-b3a9699a852c'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 5, part.movement_number = 'V',
    part.name_ko = 'Passepied', part.name_en = 'Soleriana: V. Passepied',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 17944 AND p.composer_id = 341 AND part.part_key = 'musicbrainz:9add199f-95c8-47bf-b072-54e8f13f5038' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:9add199f-95c8-47bf-b072-54e8f13f5038', 5, 'V', 'Passepied', 'Soleriana: V. Passepied', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 17944 AND p.composer_id = 341
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:9add199f-95c8-47bf-b072-54e8f13f5038'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 6, part.movement_number = 'VI',
    part.name_ko = 'Fandango a lo alto', part.name_en = 'Soleriana: VI. Fandango a lo alto',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 17944 AND p.composer_id = 341 AND part.part_key = 'musicbrainz:97c97b5d-eed6-498f-a300-0eaa59cb9f71' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:97c97b5d-eed6-498f-a300-0eaa59cb9f71', 6, 'VI', 'Fandango a lo alto', 'Soleriana: VI. Fandango a lo alto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 17944 AND p.composer_id = 341
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:97c97b5d-eed6-498f-a300-0eaa59cb9f71'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 7, part.movement_number = 'VII',
    part.name_ko = 'Contradanza', part.name_en = 'Soleriana: VII. Contradanza',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 17944 AND p.composer_id = 341 AND part.part_key = 'musicbrainz:c58650aa-bd72-4cb6-908f-fda3cb593ca0' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:c58650aa-bd72-4cb6-908f-fda3cb593ca0', 7, 'VII', 'Contradanza', 'Soleriana: VII. Contradanza', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 17944 AND p.composer_id = 341
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:c58650aa-bd72-4cb6-908f-fda3cb593ca0'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 8, part.movement_number = 'VIII',
    part.name_ko = 'Boleras', part.name_en = 'Soleriana: VIII. Boleras',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 17944 AND p.composer_id = 341 AND part.part_key = 'musicbrainz:64f0a2d4-30fa-498b-a450-1da23589fb46' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:64f0a2d4-30fa-498b-a450-1da23589fb46', 8, 'VIII', 'Boleras', 'Soleriana: VIII. Boleras', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 17944 AND p.composer_id = 341
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:64f0a2d4-30fa-498b-a450-1da23589fb46'
);


-- None Sonata a la española

UPDATE pieces piece
SET piece.title = 'Sonata a la española', piece.title_en = 'Sonata a la española',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 17541 AND piece.composer_id = 341
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'Allegro assai', part.name_en = 'Sonata a la española: I. Allegro assai',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 17541 AND p.composer_id = 341 AND part.part_key = 'musicbrainz:0d74153f-736b-4e69-8c2c-75869fa5f93c' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:0d74153f-736b-4e69-8c2c-75869fa5f93c', 1, 'I', 'Allegro assai', 'Sonata a la española: I. Allegro assai', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 17541 AND p.composer_id = 341
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:0d74153f-736b-4e69-8c2c-75869fa5f93c'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'Adagio', part.name_en = 'Sonata a la española: II. Adagio',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 17541 AND p.composer_id = 341 AND part.part_key = 'musicbrainz:3ef49707-a206-414a-a499-9fe6ad6685b6' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:3ef49707-a206-414a-a499-9fe6ad6685b6', 2, 'II', 'Adagio', 'Sonata a la española: II. Adagio', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 17541 AND p.composer_id = 341
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:3ef49707-a206-414a-a499-9fe6ad6685b6'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = 'Allegro moderato (tempo de bolero)', part.name_en = 'Sonata a la española: III. Allegro moderato (tempo de bolero)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 17541 AND p.composer_id = 341 AND part.part_key = 'musicbrainz:878e4786-7d14-4676-b224-4528feea805b' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:878e4786-7d14-4676-b224-4528feea805b', 3, 'III', 'Allegro moderato (tempo de bolero)', 'Sonata a la española: III. Allegro moderato (tempo de bolero)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 17541 AND p.composer_id = 341
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:878e4786-7d14-4676-b224-4528feea805b'
);


-- None Sonata giocosa

UPDATE pieces piece
SET piece.title = 'Sonata giocosa', piece.title_en = 'Sonata giocosa',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 18739 AND piece.composer_id = 341
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'Allegro moderato', part.name_en = 'Sonata giocosa: I. Allegro moderato',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 18739 AND p.composer_id = 341 AND part.part_key = 'musicbrainz:044c8eb0-f9a2-324f-a0a4-02e205e1a6ee' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:044c8eb0-f9a2-324f-a0a4-02e205e1a6ee', 1, 'I', 'Allegro moderato', 'Sonata giocosa: I. Allegro moderato', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 18739 AND p.composer_id = 341
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:044c8eb0-f9a2-324f-a0a4-02e205e1a6ee'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'Andante moderato', part.name_en = 'Sonata giocosa: II. Andante moderato',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 18739 AND p.composer_id = 341 AND part.part_key = 'musicbrainz:7d479ffa-5b74-3299-b557-0bd89c1a51c5' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:7d479ffa-5b74-3299-b557-0bd89c1a51c5', 2, 'II', 'Andante moderato', 'Sonata giocosa: II. Andante moderato', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 18739 AND p.composer_id = 341
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:7d479ffa-5b74-3299-b557-0bd89c1a51c5'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = 'Allegro', part.name_en = 'Sonata giocosa: III. Allegro',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 18739 AND p.composer_id = 341 AND part.part_key = 'musicbrainz:292478c8-0741-3197-85e8-2ff445be5ea6' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:292478c8-0741-3197-85e8-2ff445be5ea6', 3, 'III', 'Allegro', 'Sonata giocosa: III. Allegro', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 18739 AND p.composer_id = 341
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:292478c8-0741-3197-85e8-2ff445be5ea6'
);


-- None Sonata pimpante

UPDATE pieces piece
SET piece.title = 'Sonata pimpante', piece.title_en = 'Sonata pimpante',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 17446 AND piece.composer_id = 341
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'Allegro', part.name_en = 'Sonata pimpante: I. Allegro',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 17446 AND p.composer_id = 341 AND part.part_key = 'musicbrainz:86a5148b-6e3e-45c8-bb49-cda90aa412a6' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:86a5148b-6e3e-45c8-bb49-cda90aa412a6', 1, 'I', 'Allegro', 'Sonata pimpante: I. Allegro', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 17446 AND p.composer_id = 341
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:86a5148b-6e3e-45c8-bb49-cda90aa412a6'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'Adagio - Allegro vivace - Adagio', part.name_en = 'Sonata pimpante: II. Adagio - Allegro vivace - Adagio',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 17446 AND p.composer_id = 341 AND part.part_key = 'musicbrainz:c6331941-4fa2-4eb7-84d3-e878c471e507' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:c6331941-4fa2-4eb7-84d3-e878c471e507', 2, 'II', 'Adagio - Allegro vivace - Adagio', 'Sonata pimpante: II. Adagio - Allegro vivace - Adagio', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 17446 AND p.composer_id = 341
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:c6331941-4fa2-4eb7-84d3-e878c471e507'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = 'Allegro molto', part.name_en = 'Sonata pimpante: III. Allegro molto',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 17446 AND p.composer_id = 341 AND part.part_key = 'musicbrainz:ec443654-c655-4984-abb0-778385ca2daa' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:ec443654-c655-4984-abb0-778385ca2daa', 3, 'III', 'Allegro molto', 'Sonata pimpante: III. Allegro molto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 17446 AND p.composer_id = 341
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:ec443654-c655-4984-abb0-778385ca2daa'
);


-- None Sonatas de Castilla

UPDATE pieces piece
SET piece.title = 'Sonatas de Castilla', piece.title_en = 'Sonatas de Castilla',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 18750 AND piece.composer_id = 341
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'Toccata a modo de pregón', part.name_en = 'Sonatas de Castilla: I. Toccata a modo de pregón',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 18750 AND p.composer_id = 341 AND part.part_key = 'musicbrainz:9f10968a-28da-4c3a-b97b-c7eb85b4581b' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:9f10968a-28da-4c3a-b97b-c7eb85b4581b', 1, 'I', 'Toccata a modo de pregón', 'Sonatas de Castilla: I. Toccata a modo de pregón', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 18750 AND p.composer_id = 341
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:9f10968a-28da-4c3a-b97b-c7eb85b4581b'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'Sonata', part.name_en = 'Sonatas de Castilla: II. Sonata',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 18750 AND p.composer_id = 341 AND part.part_key = 'musicbrainz:530b039f-1e41-4145-9b8e-730b51ecf260' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:530b039f-1e41-4145-9b8e-730b51ecf260', 2, 'II', 'Sonata', 'Sonatas de Castilla: II. Sonata', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 18750 AND p.composer_id = 341
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:530b039f-1e41-4145-9b8e-730b51ecf260'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = 'Sonata en fa sostenido menor', part.name_en = 'Sonatas de Castilla: III. Sonata en fa sostenido menor',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 18750 AND p.composer_id = 341 AND part.part_key = 'musicbrainz:ce204954-1721-42b1-8a36-3c84477e5f4f' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:ce204954-1721-42b1-8a36-3c84477e5f4f', 3, 'III', 'Sonata en fa sostenido menor', 'Sonatas de Castilla: III. Sonata en fa sostenido menor', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 18750 AND p.composer_id = 341
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:ce204954-1721-42b1-8a36-3c84477e5f4f'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = 'IV',
    part.name_ko = 'Sonata en re', part.name_en = 'Sonatas de Castilla: IV. Sonata en re',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 18750 AND p.composer_id = 341 AND part.part_key = 'musicbrainz:0034a76e-d49f-4576-9b0a-ba596f6a1a88' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:0034a76e-d49f-4576-9b0a-ba596f6a1a88', 4, 'IV', 'Sonata en re', 'Sonatas de Castilla: IV. Sonata en re', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 18750 AND p.composer_id = 341
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:0034a76e-d49f-4576-9b0a-ba596f6a1a88'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 5, part.movement_number = 'V',
    part.name_ko = 'Sonata como un tiento', part.name_en = 'Sonatas de Castilla: V. Sonata como un tiento',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 18750 AND p.composer_id = 341 AND part.part_key = 'musicbrainz:2c6a0e8c-32dc-4af1-a3f1-5e4547ae36de' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:2c6a0e8c-32dc-4af1-a3f1-5e4547ae36de', 5, 'V', 'Sonata como un tiento', 'Sonatas de Castilla: V. Sonata como un tiento', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 18750 AND p.composer_id = 341
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:2c6a0e8c-32dc-4af1-a3f1-5e4547ae36de'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 6, part.movement_number = 'VI',
    part.name_ko = 'Sonata en la', part.name_en = 'Sonatas de Castilla: VI. Sonata en la',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 18750 AND p.composer_id = 341 AND part.part_key = 'musicbrainz:e85176ee-fdf8-47b7-aab5-b4a9c17a0ccf' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:e85176ee-fdf8-47b7-aab5-b4a9c17a0ccf', 6, 'VI', 'Sonata en la', 'Sonatas de Castilla: VI. Sonata en la', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 18750 AND p.composer_id = 341
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:e85176ee-fdf8-47b7-aab5-b4a9c17a0ccf'
);


-- None Sonatina para dos muñecas

UPDATE pieces piece
SET piece.title = 'Sonatina para dos muñecas', piece.title_en = 'Sonatina para dos muñecas',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 19943 AND piece.composer_id = 341
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'Empieza el día', part.name_en = 'Sonatina para dos muñecas: I. Empieza el día',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 19943 AND p.composer_id = 341 AND part.part_key = 'musicbrainz:e06282f6-38bd-4ff6-8e94-fa315c6e1d37' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:e06282f6-38bd-4ff6-8e94-fa315c6e1d37', 1, 'I', 'Empieza el día', 'Sonatina para dos muñecas: I. Empieza el día', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 19943 AND p.composer_id = 341
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:e06282f6-38bd-4ff6-8e94-fa315c6e1d37'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'Alegres peripecias', part.name_en = 'Sonatina para dos muñecas: II. Alegres peripecias',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 19943 AND p.composer_id = 341 AND part.part_key = 'musicbrainz:f1835693-956b-4c32-abf3-c81f55c1bcef' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:f1835693-956b-4c32-abf3-c81f55c1bcef', 2, 'II', 'Alegres peripecias', 'Sonatina para dos muñecas: II. Alegres peripecias', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 19943 AND p.composer_id = 341
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:f1835693-956b-4c32-abf3-c81f55c1bcef'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = 'Recogimiento', part.name_en = 'Sonatina para dos muñecas: III. Recogimiento',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 19943 AND p.composer_id = 341 AND part.part_key = 'musicbrainz:60004ae1-743e-4445-a6bf-514dbda1c5b5' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:60004ae1-743e-4445-a6bf-514dbda1c5b5', 3, 'III', 'Recogimiento', 'Sonatina para dos muñecas: III. Recogimiento', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 19943 AND p.composer_id = 341
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:60004ae1-743e-4445-a6bf-514dbda1c5b5'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = 'IV',
    part.name_ko = 'Vuelta del cole', part.name_en = 'Sonatina para dos muñecas: IV. Vuelta del cole',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 19943 AND p.composer_id = 341 AND part.part_key = 'musicbrainz:418a2dd6-0b8a-483a-acc0-b55d479c19f3' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:418a2dd6-0b8a-483a-acc0-b55d479c19f3', 4, 'IV', 'Vuelta del cole', 'Sonatina para dos muñecas: IV. Vuelta del cole', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 19943 AND p.composer_id = 341
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:418a2dd6-0b8a-483a-acc0-b55d479c19f3'
);


-- None Sones en la Giralda

UPDATE pieces piece
SET piece.title = 'Sones en la Giralda', piece.title_en = 'Sones en la Giralda',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 15794 AND piece.composer_id = 341
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Suite para piano

UPDATE pieces piece
SET piece.title = 'Suite para piano', piece.title_en = 'Suite para piano',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 18908 AND piece.composer_id = 341
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'Preludio', part.name_en = 'Suite para piano: I. Preludio',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 18908 AND p.composer_id = 341 AND part.part_key = 'musicbrainz:e72a53fb-6053-4bf5-aaed-80125e8ebaef' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:e72a53fb-6053-4bf5-aaed-80125e8ebaef', 1, 'I', 'Preludio', 'Suite para piano: I. Preludio', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 18908 AND p.composer_id = 341
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:e72a53fb-6053-4bf5-aaed-80125e8ebaef'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'Siciliana', part.name_en = 'Suite para piano: II. Siciliana',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 18908 AND p.composer_id = 341 AND part.part_key = 'musicbrainz:872447eb-9a22-40ae-85ac-c5681a1c0a73' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:872447eb-9a22-40ae-85ac-c5681a1c0a73', 2, 'II', 'Siciliana', 'Suite para piano: II. Siciliana', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 18908 AND p.composer_id = 341
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:872447eb-9a22-40ae-85ac-c5681a1c0a73'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = 'Bourrée', part.name_en = 'Suite para piano: III. Bourrée',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 18908 AND p.composer_id = 341 AND part.part_key = 'musicbrainz:2cd38643-7d31-4df6-a82f-d9e555e797a6' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:2cd38643-7d31-4df6-a82f-d9e555e797a6', 3, 'III', 'Bourrée', 'Suite para piano: III. Bourrée', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 18908 AND p.composer_id = 341
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:2cd38643-7d31-4df6-a82f-d9e555e797a6'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = 'IV',
    part.name_ko = 'Minué', part.name_en = 'Suite para piano: IV. Minué',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 18908 AND p.composer_id = 341 AND part.part_key = 'musicbrainz:b32b9d01-b44d-4221-a4a9-dcea92c32e84' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:b32b9d01-b44d-4221-a4a9-dcea92c32e84', 4, 'IV', 'Minué', 'Suite para piano: IV. Minué', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 18908 AND p.composer_id = 341
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:b32b9d01-b44d-4221-a4a9-dcea92c32e84'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 5, part.movement_number = 'V',
    part.name_ko = 'Rigodón', part.name_en = 'Suite para piano: V. Rigodón',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 18908 AND p.composer_id = 341 AND part.part_key = 'musicbrainz:0216ab40-8b22-4406-994a-e14803968ac6' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:0216ab40-8b22-4406-994a-e14803968ac6', 5, 'V', 'Rigodón', 'Suite para piano: V. Rigodón', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 18908 AND p.composer_id = 341
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:0216ab40-8b22-4406-994a-e14803968ac6'
);


-- None Tiento antiguo

UPDATE pieces piece
SET piece.title = 'Tiento antiguo', piece.title_en = 'Tiento antiguo',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 16358 AND piece.composer_id = 341
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Tres canciones españolas

UPDATE pieces piece
SET piece.title = 'Tres canciones españolas', piece.title_en = 'Tres canciones españolas',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 16690 AND piece.composer_id = 341
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'En Jerez de la Frontera', part.name_en = 'Tres canciones españolas, nº 1: En Jerez de la Frontera',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 16690 AND p.composer_id = 341 AND part.part_key = 'musicbrainz:f5b994e6-6437-4060-b065-5dfe3d736e00' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:f5b994e6-6437-4060-b065-5dfe3d736e00', 1, NULL, 'En Jerez de la Frontera', 'Tres canciones españolas, nº 1: En Jerez de la Frontera', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 16690 AND p.composer_id = 341
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:f5b994e6-6437-4060-b065-5dfe3d736e00'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'Adela', part.name_en = 'Tres canciones españolas, nº 2: Adela',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 16690 AND p.composer_id = 341 AND part.part_key = 'musicbrainz:8c04e70e-eb48-40cd-b9cc-519b863f9c80' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:8c04e70e-eb48-40cd-b9cc-519b863f9c80', 2, NULL, 'Adela', 'Tres canciones españolas, nº 2: Adela', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 16690 AND p.composer_id = 341
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:8c04e70e-eb48-40cd-b9cc-519b863f9c80'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = NULL,
    part.name_ko = 'De ronda', part.name_en = 'Tres canciones españolas, nº 3: De ronda',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 16690 AND p.composer_id = 341 AND part.part_key = 'musicbrainz:4a37e9a7-17d7-4211-87b7-3233b8a8734b' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:4a37e9a7-17d7-4211-87b7-3233b8a8734b', 3, NULL, 'De ronda', 'Tres canciones españolas, nº 3: De ronda', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 16690 AND p.composer_id = 341
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:4a37e9a7-17d7-4211-87b7-3233b8a8734b'
);


-- None Tres danzas de España

UPDATE pieces piece
SET piece.title = 'Tres danzas de España', piece.title_en = 'Tres danzas de España',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 19666 AND piece.composer_id = 341
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'Rústica', part.name_en = 'Tres danzas de España, nº 1: Rústica',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 19666 AND p.composer_id = 341 AND part.part_key = 'musicbrainz:81824ab2-d85e-4571-bbd4-d8bc9c2619be' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:81824ab2-d85e-4571-bbd4-d8bc9c2619be', 1, NULL, 'Rústica', 'Tres danzas de España, nº 1: Rústica', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 19666 AND p.composer_id = 341
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:81824ab2-d85e-4571-bbd4-d8bc9c2619be'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'Danza de las tres doncellas', part.name_en = 'Tres danzas de España, nº 2: Danza de las tres doncellas',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 19666 AND p.composer_id = 341 AND part.part_key = 'musicbrainz:a3cc2d94-0bc5-4c1b-8a59-4b4972f0b80e' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:a3cc2d94-0bc5-4c1b-8a59-4b4972f0b80e', 2, NULL, 'Danza de las tres doncellas', 'Tres danzas de España, nº 2: Danza de las tres doncellas', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 19666 AND p.composer_id = 341
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:a3cc2d94-0bc5-4c1b-8a59-4b4972f0b80e'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = NULL,
    part.name_ko = 'Serrana', part.name_en = 'Tres danzas de España, nº 3: Serrana',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 19666 AND p.composer_id = 341 AND part.part_key = 'musicbrainz:1472751b-4676-4853-ab1b-f09fde84f8a5' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:1472751b-4676-4853-ab1b-f09fde84f8a5', 3, NULL, 'Serrana', 'Tres danzas de España, nº 3: Serrana', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 19666 AND p.composer_id = 341
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:1472751b-4676-4853-ab1b-f09fde84f8a5'
);


-- None Tres evocaciones

UPDATE pieces piece
SET piece.title = 'Tres evocaciones', piece.title_en = 'Tres evocaciones',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 19058 AND piece.composer_id = 341
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'Tarde en el parque', part.name_en = 'Tres evocaciones, nº 1: Tarde en el parque',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 19058 AND p.composer_id = 341 AND part.part_key = 'musicbrainz:4aa8b027-8258-40c4-a5ac-696384161e8e' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:4aa8b027-8258-40c4-a5ac-696384161e8e', 1, NULL, 'Tarde en el parque', 'Tres evocaciones, nº 1: Tarde en el parque', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 19058 AND p.composer_id = 341
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:4aa8b027-8258-40c4-a5ac-696384161e8e'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'Noche junto al Guadalquivir', part.name_en = 'Tres evocaciones, nº 2: Noche junto al Guadalquivir',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 19058 AND p.composer_id = 341 AND part.part_key = 'musicbrainz:f40346fc-5a14-43a9-979d-a5dd5dd15310' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:f40346fc-5a14-43a9-979d-a5dd5dd15310', 2, NULL, 'Noche junto al Guadalquivir', 'Tres evocaciones, nº 2: Noche junto al Guadalquivir', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 19058 AND p.composer_id = 341
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:f40346fc-5a14-43a9-979d-a5dd5dd15310'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = NULL,
    part.name_ko = 'Mañana en Triana', part.name_en = 'Tres evocaciones, nº 3: Mañana en Triana',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 19058 AND p.composer_id = 341 AND part.part_key = 'musicbrainz:62ff954a-5480-4d81-9ada-5baa31a8c492' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:62ff954a-5480-4d81-9ada-5baa31a8c492', 3, NULL, 'Mañana en Triana', 'Tres evocaciones, nº 3: Mañana en Triana', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 19058 AND p.composer_id = 341
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:62ff954a-5480-4d81-9ada-5baa31a8c492'
);


-- None Tres pequeñas piezas

UPDATE pieces piece
SET piece.title = 'Tres pequeñas piezas', piece.title_en = 'Tres pequeñas piezas',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 17756 AND piece.composer_id = 341
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'Ya se van los pastores', part.name_en = 'Tres pequeñas piezas, nº 1: Ya se van los pastores',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 17756 AND p.composer_id = 341 AND part.part_key = 'musicbrainz:205c5d73-d82a-3a03-9bb4-e293271c8fb2' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:205c5d73-d82a-3a03-9bb4-e293271c8fb2', 1, NULL, 'Ya se van los pastores', 'Tres pequeñas piezas, nº 1: Ya se van los pastores', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 17756 AND p.composer_id = 341
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:205c5d73-d82a-3a03-9bb4-e293271c8fb2'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'Por caminos de Santiago', part.name_en = 'Tres pequeñas piezas, nº 2: Por caminos de Santiago',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 17756 AND p.composer_id = 341 AND part.part_key = 'musicbrainz:66409770-c4bf-3ef4-a2d5-cf6ef2e32cb7' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:66409770-c4bf-3ef4-a2d5-cf6ef2e32cb7', 2, NULL, 'Por caminos de Santiago', 'Tres pequeñas piezas, nº 2: Por caminos de Santiago', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 17756 AND p.composer_id = 341
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:66409770-c4bf-3ef4-a2d5-cf6ef2e32cb7'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = NULL,
    part.name_ko = 'Pequeña sevillana', part.name_en = 'Tres pequeñas piezas, nº 3: Pequeña sevillana',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 17756 AND p.composer_id = 341 AND part.part_key = 'musicbrainz:1d9783c0-993f-361a-8ac5-144b0c12b131' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:1d9783c0-993f-361a-8ac5-144b0c12b131', 3, NULL, 'Pequeña sevillana', 'Tres pequeñas piezas, nº 3: Pequeña sevillana', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 17756 AND p.composer_id = 341
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:1d9783c0-993f-361a-8ac5-144b0c12b131'
);


-- None Tres piezas españolas

UPDATE pieces piece
SET piece.title = 'Tres piezas españolas', piece.title_en = 'Tres piezas españolas',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 18772 AND piece.composer_id = 341
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'Fandango', part.name_en = 'Tres piezas españolas, nº 1: Fandango',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 18772 AND p.composer_id = 341 AND part.part_key = 'musicbrainz:845adaaa-b44d-3347-a146-08414c56dedd' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:845adaaa-b44d-3347-a146-08414c56dedd', 1, NULL, 'Fandango', 'Tres piezas españolas, nº 1: Fandango', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 18772 AND p.composer_id = 341
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:845adaaa-b44d-3347-a146-08414c56dedd'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'Passacaglia', part.name_en = 'Tres piezas españolas, nº 2: Passacaglia',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 18772 AND p.composer_id = 341 AND part.part_key = 'musicbrainz:e4156a75-67f7-366d-9a69-cd555d2a98a4' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:e4156a75-67f7-366d-9a69-cd555d2a98a4', 2, NULL, 'Passacaglia', 'Tres piezas españolas, nº 2: Passacaglia', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 18772 AND p.composer_id = 341
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:e4156a75-67f7-366d-9a69-cd555d2a98a4'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = NULL,
    part.name_ko = 'Zapateado', part.name_en = 'Tres piezas españolas, nº 3: Zapateado',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 18772 AND p.composer_id = 341 AND part.part_key = 'musicbrainz:87b8f650-ad3b-3f30-a409-71050a851a04' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:87b8f650-ad3b-3f30-a409-71050a851a04', 3, NULL, 'Zapateado', 'Tres piezas españolas, nº 3: Zapateado', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 18772 AND p.composer_id = 341
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:87b8f650-ad3b-3f30-a409-71050a851a04'
);


-- None Tres viejos aires de danza

UPDATE pieces piece
SET piece.title = 'Tres viejos aires de danza', piece.title_en = 'Tres viejos aires de danza',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 16639 AND piece.composer_id = 341
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'Pastoral', part.name_en = 'Tres viejos aires de danza, nº 1: Pastoral',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 16639 AND p.composer_id = 341 AND part.part_key = 'musicbrainz:13a8a6f7-428b-4e12-9278-3a75c9ea9eb4' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:13a8a6f7-428b-4e12-9278-3a75c9ea9eb4', 1, NULL, 'Pastoral', 'Tres viejos aires de danza, nº 1: Pastoral', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 16639 AND p.composer_id = 341
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:13a8a6f7-428b-4e12-9278-3a75c9ea9eb4'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'Minué', part.name_en = 'Tres viejos aires de danza, nº 2: Minué',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 16639 AND p.composer_id = 341 AND part.part_key = 'musicbrainz:b45ff338-84a3-4986-83e4-f975a884157f' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:b45ff338-84a3-4986-83e4-f975a884157f', 2, NULL, 'Minué', 'Tres viejos aires de danza, nº 2: Minué', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 16639 AND p.composer_id = 341
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:b45ff338-84a3-4986-83e4-f975a884157f'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = NULL,
    part.name_ko = 'Giga', part.name_en = 'Tres viejos aires de danza, nº 3: Giga',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 16639 AND p.composer_id = 341 AND part.part_key = 'musicbrainz:20b2c0b6-a3bc-4b18-83ec-3f138536bd96' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:20b2c0b6-a3bc-4b18-83ec-3f138536bd96', 3, NULL, 'Giga', 'Tres viejos aires de danza, nº 3: Giga', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 16639 AND p.composer_id = 341
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:20b2c0b6-a3bc-4b18-83ec-3f138536bd96'
);


-- None Tríptic de Mossèn Cinto

UPDATE pieces piece
SET piece.title = 'Tríptic de Mossèn Cinto', piece.title_en = 'Tríptic de Mossèn Cinto',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 18933 AND piece.composer_id = 341
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'L''harpa sagrada', part.name_en = 'Tríptic de Mossèn Cinto: I. L''harpa sagrada',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 18933 AND p.composer_id = 341 AND part.part_key = 'musicbrainz:3bf56519-ea31-4ca6-8865-a80dd19434be' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:3bf56519-ea31-4ca6-8865-a80dd19434be', 1, 'I', 'L''harpa sagrada', 'Tríptic de Mossèn Cinto: I. L''harpa sagrada', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 18933 AND p.composer_id = 341
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:3bf56519-ea31-4ca6-8865-a80dd19434be'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'Lo violí de Sant Francesc', part.name_en = 'Tríptic de Mossèn Cinto: II. Lo violí de Sant Francesc',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 18933 AND p.composer_id = 341 AND part.part_key = 'musicbrainz:8d773ed9-1f8f-4ac4-8630-cf95570889fe' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:8d773ed9-1f8f-4ac4-8630-cf95570889fe', 2, 'II', 'Lo violí de Sant Francesc', 'Tríptic de Mossèn Cinto: II. Lo violí de Sant Francesc', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 18933 AND p.composer_id = 341
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:8d773ed9-1f8f-4ac4-8630-cf95570889fe'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = 'Sant Francesc i la cigala', part.name_en = 'Tríptic de Mossèn Cinto: III. Sant Francesc i la cigala',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 18933 AND p.composer_id = 341 AND part.part_key = 'musicbrainz:173789a1-5ebd-4c34-bc45-3e8c5d0b21d7' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:173789a1-5ebd-4c34-bc45-3e8c5d0b21d7', 3, 'III', 'Sant Francesc i la cigala', 'Tríptic de Mossèn Cinto: III. Sant Francesc i la cigala', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 18933 AND p.composer_id = 341
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:173789a1-5ebd-4c34-bc45-3e8c5d0b21d7'
);


-- None Un tiempo fue Itálica famosa

UPDATE pieces piece
SET piece.title = 'Un tiempo fue Itálica famosa', piece.title_en = 'Un tiempo fue Itálica famosa',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 19640 AND piece.composer_id = 341
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Zarabanda lejana

UPDATE pieces piece
SET piece.title = 'Zarabanda lejana', piece.title_en = 'Zarabanda lejana',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 26016 AND piece.composer_id = 341
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Zarabanda lejana y Villancico

UPDATE pieces piece
SET piece.title = 'Zarabanda lejana y Villancico', piece.title_en = 'Zarabanda lejana y Villancico',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 17213 AND piece.composer_id = 341
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'Zarabanda lejana', part.name_en = 'Zarabanda lejana',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 17213 AND p.composer_id = 341 AND part.part_key = 'musicbrainz:fc0b1bd4-2fff-4c48-8625-18f40e3c473e' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:fc0b1bd4-2fff-4c48-8625-18f40e3c473e', 1, NULL, 'Zarabanda lejana', 'Zarabanda lejana', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 17213 AND p.composer_id = 341
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:fc0b1bd4-2fff-4c48-8625-18f40e3c473e'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'Villancico', part.name_en = 'Villancico',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 17213 AND p.composer_id = 341 AND part.part_key = 'musicbrainz:0f18ba76-f2ff-432e-939e-1e30c586a108' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:0f18ba76-f2ff-432e-939e-1e30c586a108', 2, NULL, 'Villancico', 'Villancico', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 17213 AND p.composer_id = 341
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:0f18ba76-f2ff-432e-939e-1e30c586a108'
);


-- None Aranjuez

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, 'Aranjuez', 'Aranjuez', 'song', NULL, NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 341
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = 'Aranjuez'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'a8dc773a-b37b-35e5-b989-c786affe9caf'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'a8dc773a-b37b-35e5-b989-c786affe9caf'
FROM pieces p
WHERE p.composer_id = 341 AND p.title = 'Aranjuez' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'a8dc773a-b37b-35e5-b989-c786affe9caf'
);


-- None Aria antigua

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, 'Aria antigua', 'Aria antigua', 'song', NULL, NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 341
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = 'Aria antigua'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '916f9f57-5d9f-4140-97da-7867bf2eedbd'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '916f9f57-5d9f-4140-97da-7867bf2eedbd'
FROM pieces p
WHERE p.composer_id = 341 AND p.title = 'Aria antigua' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '916f9f57-5d9f-4140-97da-7867bf2eedbd'
);


-- None Ave Maria

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, 'Ave Maria', 'Ave Maria', 'song', NULL, NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 341
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = 'Ave Maria'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '0692c77d-8ea4-4a84-b0a9-41c1349e92d6'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '0692c77d-8ea4-4a84-b0a9-41c1349e92d6'
FROM pieces p
WHERE p.composer_id = 341 AND p.title = 'Ave Maria' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '0692c77d-8ea4-4a84-b0a9-41c1349e92d6'
);


-- None Cançoneta

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, 'Cançoneta', 'Cançoneta', 'song', NULL, NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 341
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = 'Cançoneta'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'd01c1685-2b55-4a68-a7dc-3c893599780b'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'd01c1685-2b55-4a68-a7dc-3c893599780b'
FROM pieces p
WHERE p.composer_id = 341 AND p.title = 'Cançoneta' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'd01c1685-2b55-4a68-a7dc-3c893599780b'
);


-- None Cuatro piezas para piano

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, 'Cuatro piezas para piano', 'Cuatro piezas para piano', 'album', NULL, NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 341
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = 'Cuatro piezas para piano'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '3e891029-080e-4def-b608-6f19e81d6a22'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '3e891029-080e-4def-b608-6f19e81d6a22'
FROM pieces p
WHERE p.composer_id = 341 AND p.title = 'Cuatro piezas para piano' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '3e891029-080e-4def-b608-6f19e81d6a22'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:84cbeb0f-4145-445f-9d4b-f19b6f60d4ac', 1, NULL, 'Caleseras (Homenaje a Chueca)', 'Cuatro piezas para piano, nº 1: Caleseras (Homenaje a Chueca)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 341 AND p.title = 'Cuatro piezas para piano' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:84cbeb0f-4145-445f-9d4b-f19b6f60d4ac'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:8b1ccbee-890a-4281-848a-275a2d350303', 2, NULL, 'Fandango del ventorrillo', 'Cuatro piezas para piano, nº 2: Fandango del ventorrillo', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 341 AND p.title = 'Cuatro piezas para piano' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:8b1ccbee-890a-4281-848a-275a2d350303'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:778a13da-767d-4a1d-903f-4a3a58d8a19c', 3, NULL, 'Plegaria de la Infanta de Castilla', 'Cuatro piezas para piano, nº 3: Plegaria de la Infanta de Castilla', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 341 AND p.title = 'Cuatro piezas para piano' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:778a13da-767d-4a1d-903f-4a3a58d8a19c'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:5d937f45-8357-49b4-8dd6-18d6374d7360', 4, NULL, 'Danza valenciana', 'Cuatro piezas para piano, nº 4: Danza valenciana', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 341 AND p.title = 'Cuatro piezas para piano' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:5d937f45-8357-49b4-8dd6-18d6374d7360'
);


-- None El álbum de Cecilia

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, 'El álbum de Cecilia', 'El álbum de Cecilia', 'album', NULL, NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 341
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = 'El álbum de Cecilia'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'ef150847-af06-4a68-a0ae-bbe3f16ad797'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'ef150847-af06-4a68-a0ae-bbe3f16ad797'
FROM pieces p
WHERE p.composer_id = 341 AND p.title = 'El álbum de Cecilia' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'ef150847-af06-4a68-a0ae-bbe3f16ad797'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:b0125340-c271-4025-9266-40a4be7d13f4', 1, NULL, 'María de los Reyes (Sevillanas)', 'El álbum de Cecilia, nº 1: María de los Reyes (Sevillanas)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 341 AND p.title = 'El álbum de Cecilia' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:b0125340-c271-4025-9266-40a4be7d13f4'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:aec050c8-5006-43e1-818c-e315c1672d16', 2, NULL, 'A la jota (Jota de las palomas)', 'El álbum de Cecilia, nº 2: A la jota (Jota de las palomas)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 341 AND p.title = 'El álbum de Cecilia' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:aec050c8-5006-43e1-818c-e315c1672d16'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:86df4312-e0d3-4b15-8e56-96b3e2568974', 3, NULL, 'Canción del hada rubia', 'El álbum de Cecilia, nº 3: Canción del hada rubia', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 341 AND p.title = 'El álbum de Cecilia' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:86df4312-e0d3-4b15-8e56-96b3e2568974'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:e6c5e5f1-09f4-4535-8ac2-176e25af7ca1', 4, NULL, 'Canción del hada morena', 'El álbum de Cecilia, nº 4: Canción del hada morena', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 341 AND p.title = 'El álbum de Cecilia' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:e6c5e5f1-09f4-4535-8ac2-176e25af7ca1'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:46c35d27-f7d1-4892-8397-6df2d07e4480', 5, NULL, 'El negrito Pepo', 'El álbum de Cecilia, nº 5: El negrito Pepo', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 341 AND p.title = 'El álbum de Cecilia' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:46c35d27-f7d1-4892-8397-6df2d07e4480'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:f82e5b0b-cffc-4516-ad8e-fb0a96814652', 6, NULL, 'Borriquillos a Belén', 'El álbum de Cecilia, nº 6: Borriquillos a Belén', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 341 AND p.title = 'El álbum de Cecilia' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:f82e5b0b-cffc-4516-ad8e-fb0a96814652'
);


-- None Fantasía para un gentilhombre

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, 'Fantasía para un gentilhombre', 'Fantasía para un gentilhombre', 'album', NULL, NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 341
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = 'Fantasía para un gentilhombre'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'dcbd010a-dff4-45ef-9cdb-0e5675aec7b1'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'dcbd010a-dff4-45ef-9cdb-0e5675aec7b1'
FROM pieces p
WHERE p.composer_id = 341 AND p.title = 'Fantasía para un gentilhombre' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'dcbd010a-dff4-45ef-9cdb-0e5675aec7b1'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:b02a22a1-8bfb-3cba-b173-f07bb8f932d7', 1, 'I', 'Villano y ricercare', 'Fantasía para un gentilhombre: I. Villano y ricercare', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 341 AND p.title = 'Fantasía para un gentilhombre' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:b02a22a1-8bfb-3cba-b173-f07bb8f932d7'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:c9ac866f-e1dc-3d28-9bf5-9417cdac3093', 2, 'II', 'Españoleta y fanfare de la caballería de Nápoles', 'Fantasía para un gentilhombre: II. Españoleta y fanfare de la caballería de Nápoles', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 341 AND p.title = 'Fantasía para un gentilhombre' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:c9ac866f-e1dc-3d28-9bf5-9417cdac3093'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:5f32e564-ace3-372b-a5eb-e760676d9115', 3, 'III', 'Danza de las hachas', 'Fantasía para un gentilhombre: III. Danza de las hachas', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 341 AND p.title = 'Fantasía para un gentilhombre' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:5f32e564-ace3-372b-a5eb-e760676d9115'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:2895dbe4-bfb2-3a06-ad70-df776370e1cf', 4, 'IV', 'Canario', 'Fantasía para un gentilhombre: IV. Canario', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 341 AND p.title = 'Fantasía para un gentilhombre' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:2895dbe4-bfb2-3a06-ad70-df776370e1cf'
);


-- None Juglares

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, 'Juglares', 'Juglares', 'song', NULL, NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 341
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = 'Juglares'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '48f045a1-05bb-4d29-a0f8-a042704e16db'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '48f045a1-05bb-4d29-a0f8-a042704e16db'
FROM pieces p
WHERE p.composer_id = 341 AND p.title = 'Juglares' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '48f045a1-05bb-4d29-a0f8-a042704e16db'
);


-- None Pastoral

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, 'Pastoral', 'Pastoral', 'song', NULL, NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 341
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = 'Pastoral'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'c1ec1b1f-eb00-4ba8-90c8-0db9fb9447c8'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'c1ec1b1f-eb00-4ba8-90c8-0db9fb9447c8'
FROM pieces p
WHERE p.composer_id = 341 AND p.title = 'Pastoral' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'c1ec1b1f-eb00-4ba8-90c8-0db9fb9447c8'
);


-- None Per la flor del lliri blau

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, 'Per la flor del lliri blau', 'Per la flor del lliri blau', 'song', NULL, NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 341
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = 'Per la flor del lliri blau'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '25c95359-28d5-469d-ace4-613b2b630e30'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '25c95359-28d5-469d-ace4-613b2b630e30'
FROM pieces p
WHERE p.composer_id = 341 AND p.title = 'Per la flor del lliri blau' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '25c95359-28d5-469d-ace4-613b2b630e30'
);


-- None Sonada de adiós

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, 'Sonada de adiós', 'Sonada de adiós', 'song', NULL, NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 341
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = 'Sonada de adiós'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '16b57a4a-21d7-4ad2-8562-647c26ddd11e'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '16b57a4a-21d7-4ad2-8562-647c26ddd11e'
FROM pieces p
WHERE p.composer_id = 341 AND p.title = 'Sonada de adiós' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '16b57a4a-21d7-4ad2-8562-647c26ddd11e'
);


-- None 토카타

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '토카타', 'Toccata', 'song', NULL, NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 341
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '토카타'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '55c78eda-10d1-4c09-88ed-dd6f064013d1'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '55c78eda-10d1-4c09-88ed-dd6f064013d1'
FROM pieces p
WHERE p.composer_id = 341 AND p.title = '토카타' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '55c78eda-10d1-4c09-88ed-dd6f064013d1'
);


-- None Tonadilla

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, 'Tonadilla', 'Tonadilla', 'album', NULL, NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 341
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = 'Tonadilla'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '2de56298-76f8-4579-9750-ed3ac7efbb4f'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '2de56298-76f8-4579-9750-ed3ac7efbb4f'
FROM pieces p
WHERE p.composer_id = 341 AND p.title = 'Tonadilla' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '2de56298-76f8-4579-9750-ed3ac7efbb4f'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:cd1a6290-0acb-476b-ae2b-61c4f87bdff8', 1, 'I', 'Allegro ma non troppo', 'Tonadilla: I. Allegro ma non troppo', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 341 AND p.title = 'Tonadilla' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:cd1a6290-0acb-476b-ae2b-61c4f87bdff8'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:d339c4db-73c5-4265-bda3-980f111195a5', 2, 'II', 'Minueto pomposo', 'Tonadilla: II. Minueto pomposo', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 341 AND p.title = 'Tonadilla' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:d339c4db-73c5-4265-bda3-980f111195a5'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:3b62e6f2-5fa7-4f7b-9484-07896dc69ee2', 3, 'III', 'Allegro vivace', 'Tonadilla: III. Allegro vivace', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 341 AND p.title = 'Tonadilla' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:3b62e6f2-5fa7-4f7b-9484-07896dc69ee2'
);


-- None Tríptico

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, 'Tríptico', 'Tríptico', 'album', NULL, NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 341
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = 'Tríptico'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '212e0e95-b364-43cb-adbb-2f8d305dad3e'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '212e0e95-b364-43cb-adbb-2f8d305dad3e'
FROM pieces p
WHERE p.composer_id = 341 AND p.title = 'Tríptico' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '212e0e95-b364-43cb-adbb-2f8d305dad3e'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:4f943bc8-1a06-4c74-a1de-74c28e8c4e50', 1, 'I', 'Prélude', 'Tríptico: I. Prélude', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 341 AND p.title = 'Tríptico' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:4f943bc8-1a06-4c74-a1de-74c28e8c4e50'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:f8dceb56-6665-4ea7-90c8-2585e80614b5', 2, 'II', 'Nocturne', 'Tríptico: II. Nocturne', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 341 AND p.title = 'Tríptico' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:f8dceb56-6665-4ea7-90c8-2585e80614b5'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:f8987944-ac2b-4b9a-b438-5ff59f107325', 3, 'III', 'Scherzino', 'Tríptico: III. Scherzino', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 341 AND p.title = 'Tríptico' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:f8987944-ac2b-4b9a-b438-5ff59f107325'
);


-- 카탈로그에 대응이 없는 seed 작품 11개를 목록에서 숨긴다(지우지 않음).
UPDATE pieces piece
SET piece.hidden_reason = 'catalog_unmatched'
WHERE piece.composer_id = 341 AND piece.origin = 'seed' AND piece.hidden_reason IS NULL
  AND piece.id IN (
    15816, 15902, 15969, 16365, 17176, 17206, 19004, 19214, 19479, 19846, 19910
  )
  AND NOT EXISTS (SELECT 1 FROM performance_sectors sector WHERE sector.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM piece_parts linking WHERE linking.linked_piece_id = piece.id);
