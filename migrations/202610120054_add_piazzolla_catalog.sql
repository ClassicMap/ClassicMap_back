-- 피아졸라 작품을 MusicBrainz 작품 구조로 다시 짠다(4차 자동). 작품 260개(묶음 6, 다악장 23, 낱곡 231),
-- 새 작품 29개, part 109개, 그 아래 0개.
-- seed 252개 중 227개를 작품·part 에 잇고, 24개를 숨기고, 1개는 그대로 둔다.
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
SET piece.title = 'Tangata (Silfo y Ondina) (중복 2459)'
WHERE piece.id = 2459 AND piece.composer_id = 99 AND piece.title = 'Tangata (Silfo y Ondina)'
  AND piece.origin = 'seed' AND piece.editor_locked = 0
  AND NOT EXISTS (SELECT 1 FROM performance_sectors sector WHERE sector.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM piece_parts linking WHERE linking.linked_piece_id = piece.id);


-- None 2개의 탱고

UPDATE pieces piece
SET piece.title = '2개의 탱고', piece.title_en = '2 Tangos for String Orchestra',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 2365 AND piece.composer_id = 99
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'II',
    part.name_ko = 'Canyengue', part.name_en = '2 Tangos for String Orchestra: II. Canyengue',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 2365 AND p.composer_id = 99 AND part.part_key = 'musicbrainz:901f83aa-9d73-418d-8f42-2b61b0f3b720' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:901f83aa-9d73-418d-8f42-2b61b0f3b720', 1, 'II', 'Canyengue', '2 Tangos for String Orchestra: II. Canyengue', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 2365 AND p.composer_id = 99
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:901f83aa-9d73-418d-8f42-2b61b0f3b720'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'I',
    part.name_ko = 'Coral', part.name_en = '2 Tangos for String Orchestra: I. Coral',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 2365 AND p.composer_id = 99 AND part.part_key = 'musicbrainz:da8de0eb-2906-4135-940d-364121ce9de7' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:da8de0eb-2906-4135-940d-364121ce9de7', 2, 'I', 'Coral', '2 Tangos for String Orchestra: I. Coral', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 2365 AND p.composer_id = 99
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:da8de0eb-2906-4135-940d-364121ce9de7'
);


-- None 가곡 <20 Years After>

UPDATE pieces piece
SET piece.title = '가곡 <20 Years After>', piece.title_en = '20 Years After',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 1829 AND piece.composer_id = 99
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None 가곡 <20 Years Ago>

UPDATE pieces piece
SET piece.title = '가곡 <20 Years Ago>', piece.title_en = '20 Years Ago',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 2103 AND piece.composer_id = 99
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None 3개의 전주곡

UPDATE pieces piece
SET piece.title = '3개의 전주곡', piece.title_en = '3 Préludes pour piano',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 1008 AND piece.composer_id = 99
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'III',
    part.name_ko = 'Sunny’s Game (valse prélude)', part.name_en = '3 Préludes pour piano: III. Sunny’s Game (valse prélude)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 1008 AND p.composer_id = 99 AND part.part_key = 'musicbrainz:16c2d1cb-e2cc-428e-b62c-634060990b0e' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:16c2d1cb-e2cc-428e-b62c-634060990b0e', 1, 'III', 'Sunny’s Game (valse prélude)', '3 Préludes pour piano: III. Sunny’s Game (valse prélude)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 1008 AND p.composer_id = 99
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:16c2d1cb-e2cc-428e-b62c-634060990b0e'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'Flora’s Game (milonga prélude)', part.name_en = '3 Préludes pour piano: II. Flora’s Game (milonga prélude)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 1008 AND p.composer_id = 99 AND part.part_key = 'musicbrainz:4ec66987-0aea-48c9-816b-c384bcd3a430' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:4ec66987-0aea-48c9-816b-c384bcd3a430', 2, 'II', 'Flora’s Game (milonga prélude)', '3 Préludes pour piano: II. Flora’s Game (milonga prélude)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 1008 AND p.composer_id = 99
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:4ec66987-0aea-48c9-816b-c384bcd3a430'
);


-- None 가곡 <A Don Nicanor Paredes>

UPDATE pieces piece
SET piece.title = '가곡 <A Don Nicanor Paredes>', piece.title_en = 'A Don Nicanor Paredes',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 2402 AND piece.composer_id = 99
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None 가곡 <Alguien le dice al tango>

UPDATE pieces piece
SET piece.title = '가곡 <Alguien le dice al tango>', piece.title_en = 'Alguien le dice al tango',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 1751 AND piece.composer_id = 99
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Alienacion

UPDATE pieces piece
SET piece.title = 'Alienacion', piece.title_en = 'Alienacion',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 2510 AND piece.composer_id = 99
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None 가곡 <Amelitango>

UPDATE pieces piece
SET piece.title = '가곡 <Amelitango>', piece.title_en = 'Amelitango',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 2679 AND piece.composer_id = 99
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None As Ilhas

UPDATE pieces piece
SET piece.title = 'As Ilhas', piece.title_en = 'As Ilhas',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 2181 AND piece.composer_id = 99
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None 가곡 <Ausencias>

UPDATE pieces piece
SET piece.title = '가곡 <Ausencias>', piece.title_en = 'Ausencias',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 2117 AND piece.composer_id = 99
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Awake

UPDATE pieces piece
SET piece.title = 'Awake', piece.title_en = 'Awake',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 2880 AND piece.composer_id = 99
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None 가곡 <Bailongo>

UPDATE pieces piece
SET piece.title = '가곡 <Bailongo>', piece.title_en = 'Bailongo',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 1153 AND piece.composer_id = 99
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Baires '72

UPDATE pieces piece
SET piece.title = 'Baires ''72', piece.title_en = 'Baires ''72',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 2922 AND piece.composer_id = 99
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Baires Promenade (Wing)

UPDATE pieces piece
SET piece.title = 'Baires Promenade (Wing)', piece.title_en = 'Baires Promenade (Wing)',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 1995 AND piece.composer_id = 99
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None 가곡 <Balada para mi muerte>

UPDATE pieces piece
SET piece.title = '가곡 <Balada para mi muerte>', piece.title_en = 'Balada para mi muerte',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 751 AND piece.composer_id = 99
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Bandó

UPDATE pieces piece
SET piece.title = 'Bandó', piece.title_en = 'Bandó',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 797 AND piece.composer_id = 99
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None 가곡 <Biyuya>

UPDATE pieces piece
SET piece.title = '가곡 <Biyuya>', piece.title_en = 'Biyuya',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 1467 AND piece.composer_id = 99
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None 가곡 <Buenos Aires hora cero>

UPDATE pieces piece
SET piece.title = '가곡 <Buenos Aires hora cero>', piece.title_en = 'Buenos Aires hora cero',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 637 AND piece.composer_id = 99
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None 가곡 <Butcher‘s Death>

UPDATE pieces piece
SET piece.title = '가곡 <Butcher‘s Death>', piece.title_en = 'Butcher‘s Death',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 992 AND piece.composer_id = 99
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Calambre

UPDATE pieces piece
SET piece.title = 'Calambre', piece.title_en = 'Calambre',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 2557 AND piece.composer_id = 99
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None 가곡 <Caliente>

UPDATE pieces piece
SET piece.title = '가곡 <Caliente>', piece.title_en = 'Caliente',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 2645 AND piece.composer_id = 99
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Camorra I

UPDATE pieces piece
SET piece.title = 'Camorra I', piece.title_en = 'Camorra I',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 1283 AND piece.composer_id = 99
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None 가곡 <Camorra II>

UPDATE pieces piece
SET piece.title = '가곡 <Camorra II>', piece.title_en = 'Camorra II',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 544 AND piece.composer_id = 99
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Camorra III

UPDATE pieces piece
SET piece.title = 'Camorra III', piece.title_en = 'Camorra III',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 2153 AND piece.composer_id = 99
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Canción de las Venusinas

UPDATE pieces piece
SET piece.title = 'Canción de las Venusinas', piece.title_en = 'Canción de las Venusinas',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 1404 AND piece.composer_id = 99
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Canto y fuga

UPDATE pieces piece
SET piece.title = 'Canto y fuga', piece.title_en = 'Canto y fuga',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 1685 AND piece.composer_id = 99
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Cavalcata

UPDATE pieces piece
SET piece.title = 'Cavalcata', piece.title_en = 'Cavalcata',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 2570 AND piece.composer_id = 99
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Celos

UPDATE pieces piece
SET piece.title = 'Celos', piece.title_en = 'Celos',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 1688 AND piece.composer_id = 99
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Chador (Gambeta)

UPDATE pieces piece
SET piece.title = 'Chador (Gambeta)', piece.title_en = 'Chador (Gambeta)',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 2648 AND piece.composer_id = 99
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Chant et Fugue

UPDATE pieces piece
SET piece.title = 'Chant et Fugue', piece.title_en = 'Chant et Fugue',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 1784 AND piece.composer_id = 99
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None 가곡 <Chinchin>

UPDATE pieces piece
SET piece.title = '가곡 <Chinchin>', piece.title_en = 'Chinchin',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 808 AND piece.composer_id = 99
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Cinco piezas

UPDATE pieces piece
SET piece.title = 'Cinco piezas', piece.title_en = 'Cinco piezas',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 2310 AND piece.composer_id = 99
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'Campero', part.name_en = 'Cinco piezas: I. Campero',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 2310 AND p.composer_id = 99 AND part.part_key = 'musicbrainz:e68b9e9a-cc02-4e73-8a83-26cd83899cc7' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:e68b9e9a-cc02-4e73-8a83-26cd83899cc7', 1, 'I', 'Campero', 'Cinco piezas: I. Campero', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 2310 AND p.composer_id = 99
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:e68b9e9a-cc02-4e73-8a83-26cd83899cc7'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'Romántico', part.name_en = 'Cinco piezas: II. Romántico',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 2310 AND p.composer_id = 99 AND part.part_key = 'musicbrainz:4158a59c-7101-49a5-acae-f67071150f36' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:4158a59c-7101-49a5-acae-f67071150f36', 2, 'II', 'Romántico', 'Cinco piezas: II. Romántico', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 2310 AND p.composer_id = 99
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:4158a59c-7101-49a5-acae-f67071150f36'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = 'Acentuado', part.name_en = 'Cinco piezas: III. Acentuado',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 2310 AND p.composer_id = 99 AND part.part_key = 'musicbrainz:33dd0b70-badb-47b9-8d54-07884e24ba71' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:33dd0b70-badb-47b9-8d54-07884e24ba71', 3, 'III', 'Acentuado', 'Cinco piezas: III. Acentuado', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 2310 AND p.composer_id = 99
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:33dd0b70-badb-47b9-8d54-07884e24ba71'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = 'IV',
    part.name_ko = 'Tristón', part.name_en = 'Cinco piezas: IV. Tristón',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 2310 AND p.composer_id = 99 AND part.part_key = 'musicbrainz:2e2915e4-e927-4058-9f43-4ed3ee12a268' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:2e2915e4-e927-4058-9f43-4ed3ee12a268', 4, 'IV', 'Tristón', 'Cinco piezas: IV. Tristón', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 2310 AND p.composer_id = 99
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:2e2915e4-e927-4058-9f43-4ed3ee12a268'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 5, part.movement_number = 'V',
    part.name_ko = 'Compadre', part.name_en = 'Cinco piezas: V. Compadre',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 2310 AND p.composer_id = 99 AND part.part_key = 'musicbrainz:f37e26b4-415e-435e-b0cf-aca42823862f' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:f37e26b4-415e-435e-b0cf-aca42823862f', 5, 'V', 'Compadre', 'Cinco piezas: V. Compadre', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 2310 AND p.composer_id = 99
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:f37e26b4-415e-435e-b0cf-aca42823862f'
);


-- None Cité Tango

UPDATE pieces piece
SET piece.title = 'Cité Tango', piece.title_en = 'Cité Tango',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 1649 AND piece.composer_id = 99
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None 가곡 <Close Your Eyes and Listen>

UPDATE pieces piece
SET piece.title = '가곡 <Close Your Eyes and Listen>', piece.title_en = 'Close Your Eyes and Listen',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 615 AND piece.composer_id = 99
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Concierto de nácar

UPDATE pieces piece
SET piece.title = 'Concierto de nácar', piece.title_en = 'Concierto de nácar',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 581 AND piece.composer_id = 99
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'Presto', part.name_en = 'Concierto de nácar: I. Presto',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 581 AND p.composer_id = 99 AND part.part_key = 'musicbrainz:144805b5-bfac-42c7-b1a0-bdfef70da98a' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:144805b5-bfac-42c7-b1a0-bdfef70da98a', 1, 'I', 'Presto', 'Concierto de nácar: I. Presto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 581 AND p.composer_id = 99
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:144805b5-bfac-42c7-b1a0-bdfef70da98a'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'Lento melancolico', part.name_en = 'Concierto de nácar: II. Lento melancolico',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 581 AND p.composer_id = 99 AND part.part_key = 'musicbrainz:155a9bbd-0eaa-47d0-8581-e09073b7efa2' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:155a9bbd-0eaa-47d0-8581-e09073b7efa2', 2, 'II', 'Lento melancolico', 'Concierto de nácar: II. Lento melancolico', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 581 AND p.composer_id = 99
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:155a9bbd-0eaa-47d0-8581-e09073b7efa2'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = 'Allegro marcato', part.name_en = 'Concierto de nácar: III. Allegro marcato',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 581 AND p.composer_id = 99 AND part.part_key = 'musicbrainz:601c1ae8-ef1f-43c0-93d8-f134932ff70b' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:601c1ae8-ef1f-43c0-93d8-f134932ff70b', 3, 'III', 'Allegro marcato', 'Concierto de nácar: III. Allegro marcato', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 581 AND p.composer_id = 99
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:601c1ae8-ef1f-43c0-93d8-f134932ff70b'
);


-- None Concierto para bandoneón y orquesta

UPDATE pieces piece
SET piece.title = 'Concierto para bandoneón y orquesta', piece.title_en = 'Concierto para bandoneón y orquesta',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 634 AND piece.composer_id = 99
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'Allegro marcato', part.name_en = 'Concierto para bandoneón y orquesta: I. Allegro marcato',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 634 AND p.composer_id = 99 AND part.part_key = 'musicbrainz:bca60edc-b363-34d3-b68f-b6c59918d341' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:bca60edc-b363-34d3-b68f-b6c59918d341', 1, 'I', 'Allegro marcato', 'Concierto para bandoneón y orquesta: I. Allegro marcato', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 634 AND p.composer_id = 99
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:bca60edc-b363-34d3-b68f-b6c59918d341'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'Moderato', part.name_en = 'Concierto para bandoneón y orquesta: II. Moderato',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 634 AND p.composer_id = 99 AND part.part_key = 'musicbrainz:21c5fc48-0122-3598-bad0-93b1c03e0780' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:21c5fc48-0122-3598-bad0-93b1c03e0780', 2, 'II', 'Moderato', 'Concierto para bandoneón y orquesta: II. Moderato', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 634 AND p.composer_id = 99
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:21c5fc48-0122-3598-bad0-93b1c03e0780'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = 'Presto', part.name_en = 'Concierto para bandoneón y orquesta: III. Presto',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 634 AND p.composer_id = 99 AND part.part_key = 'musicbrainz:dc59b532-c087-3c73-9498-44fa8006e3f7' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:dc59b532-c087-3c73-9498-44fa8006e3f7', 3, 'III', 'Presto', 'Concierto para bandoneón y orquesta: III. Presto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 634 AND p.composer_id = 99
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:dc59b532-c087-3c73-9498-44fa8006e3f7'
);


-- None 가곡 <Concierto para quinteto>

UPDATE pieces piece
SET piece.title = '가곡 <Concierto para quinteto>', piece.title_en = 'Concierto para quinteto',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 1466 AND piece.composer_id = 99
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None 가곡 <Contrabajísimo>

UPDATE pieces piece
SET piece.title = '가곡 <Contrabajísimo>', piece.title_en = 'Contrabajísimo',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 815 AND piece.composer_id = 99
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Contrastes

UPDATE pieces piece
SET piece.title = 'Contrastes', piece.title_en = 'Contrastes',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 798 AND piece.composer_id = 99
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Coral

UPDATE pieces piece
SET piece.title = 'Coral', piece.title_en = 'Coral',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 1201 AND piece.composer_id = 99
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Coups de cœur

UPDATE pieces piece
SET piece.title = 'Coups de cœur', piece.title_en = 'Coups de cœur',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 2237 AND piece.composer_id = 99
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None 가곡 <Decarísimo>

UPDATE pieces piece
SET piece.title = '가곡 <Decarísimo>', piece.title_en = 'Decarísimo',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 2973 AND piece.composer_id = 99
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None 가곡 <Der alte Pierre>

UPDATE pieces piece
SET piece.title = '가곡 <Der alte Pierre>', piece.title_en = 'Der alte Pierre',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 1869 AND piece.composer_id = 99
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Desperado

UPDATE pieces piece
SET piece.title = 'Desperado', piece.title_en = 'Desperado',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 1519 AND piece.composer_id = 99
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None 가곡 <Deus Xangô>

UPDATE pieces piece
SET piece.title = '가곡 <Deus Xangô>', piece.title_en = 'Deus Xangô',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 1850 AND piece.composer_id = 99
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Divagación

UPDATE pieces piece
SET piece.title = 'Divagación', piece.title_en = 'Divagación',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 1115 AND piece.composer_id = 99
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Divertimento 9

UPDATE pieces piece
SET piece.title = 'Divertimento 9', piece.title_en = 'Divertimento 9',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 2086 AND piece.composer_id = 99
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Doble concierto para bandoneón y guitarra "Hommage à Liège"

UPDATE pieces piece
SET piece.title = 'Doble concierto para bandoneón y guitarra "Hommage à Liège"', piece.title_en = 'Doble concierto para bandoneón y guitarra "Hommage à Liège"',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 1526 AND piece.composer_id = 99
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'Introducción', part.name_en = 'Doble concierto para bandoneón y guitarra "Hommage à Liège": I. Introducción',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 1526 AND p.composer_id = 99 AND part.part_key = 'musicbrainz:d04f26c9-d3c0-48b1-b75e-6e144d16880c' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:d04f26c9-d3c0-48b1-b75e-6e144d16880c', 1, 'I', 'Introducción', 'Doble concierto para bandoneón y guitarra "Hommage à Liège": I. Introducción', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 1526 AND p.composer_id = 99
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:d04f26c9-d3c0-48b1-b75e-6e144d16880c'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'Milonga', part.name_en = 'Doble concierto para bandoneón y guitarra "Hommage à Liège": II. Milonga',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 1526 AND p.composer_id = 99 AND part.part_key = 'musicbrainz:4be0fbcf-c428-4b30-aaf1-a975cda19f29' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:4be0fbcf-c428-4b30-aaf1-a975cda19f29', 2, 'II', 'Milonga', 'Doble concierto para bandoneón y guitarra "Hommage à Liège": II. Milonga', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 1526 AND p.composer_id = 99
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:4be0fbcf-c428-4b30-aaf1-a975cda19f29'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = 'Tango', part.name_en = 'Doble concierto para bandoneón y guitarra "Hommage à Liège": III. Tango',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 1526 AND p.composer_id = 99 AND part.part_key = 'musicbrainz:69215364-ff81-4e74-8ceb-014b0db43477' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:69215364-ff81-4e74-8ceb-014b0db43477', 3, 'III', 'Tango', 'Doble concierto para bandoneón y guitarra "Hommage à Liège": III. Tango', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 1526 AND p.composer_id = 99
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:69215364-ff81-4e74-8ceb-014b0db43477'
);


-- None Dos piezas breves para viola y piano

UPDATE pieces piece
SET piece.title = 'Dos piezas breves para viola y piano', piece.title_en = 'Dos piezas breves para viola y piano',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 828 AND piece.composer_id = 99
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'La noche', part.name_en = 'Dos piezas breves para viola y piano: I. La noche',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 828 AND p.composer_id = 99 AND part.part_key = 'musicbrainz:68f1fee2-fe53-4b91-a830-51afb84e7c63' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:68f1fee2-fe53-4b91-a830-51afb84e7c63', 1, 'I', 'La noche', 'Dos piezas breves para viola y piano: I. La noche', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 828 AND p.composer_id = 99
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:68f1fee2-fe53-4b91-a830-51afb84e7c63'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'Tanguano', part.name_en = 'Dos piezas breves para viola y piano: II. Tanguano',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 828 AND p.composer_id = 99 AND part.part_key = 'musicbrainz:ec483fa8-01b9-46ee-a8f7-63e465461fd0' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:ec483fa8-01b9-46ee-a8f7-63e465461fd0', 2, 'II', 'Tanguano', 'Dos piezas breves para viola y piano: II. Tanguano', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 828 AND p.composer_id = 99
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:ec483fa8-01b9-46ee-a8f7-63e465461fd0'
);


-- None 가곡 <Dúo de amor>

UPDATE pieces piece
SET piece.title = '가곡 <Dúo de amor>', piece.title_en = 'Dúo de amor',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 1591 AND piece.composer_id = 99
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Eduardo y Juliana

UPDATE pieces piece
SET piece.title = 'Eduardo y Juliana', piece.title_en = 'Eduardo y Juliana',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 2815 AND piece.composer_id = 99
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None El Infierno Tan Temido

UPDATE pieces piece
SET piece.title = 'El Infierno Tan Temido', piece.title_en = 'El Infierno Tan Temido',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 1297 AND piece.composer_id = 99
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None El gordo triste

UPDATE pieces piece
SET piece.title = 'El gordo triste', piece.title_en = 'El gordo triste',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 2259 AND piece.composer_id = 99
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None El hombre de la esquina rosada

UPDATE pieces piece
SET piece.title = 'El hombre de la esquina rosada', piece.title_en = 'El hombre de la esquina rosada',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 1280 AND piece.composer_id = 99
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'VI',
    part.name_ko = 'Muerte de Real / VII. Epílogo', part.name_en = 'El hombre de la esquina rosada: VI. Muerte de Real / VII. Epílogo',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 1280 AND p.composer_id = 99 AND part.part_key = 'musicbrainz:28d37377-6503-4daa-9233-d5f6ced54add' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:28d37377-6503-4daa-9233-d5f6ced54add', 1, 'VI', 'Muerte de Real / VII. Epílogo', 'El hombre de la esquina rosada: VI. Muerte de Real / VII. Epílogo', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 1280 AND p.composer_id = 99
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:28d37377-6503-4daa-9233-d5f6ced54add'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'III',
    part.name_ko = 'Aparición de Real', part.name_en = 'El hombre de la esquina rosada: III. Aparición de Real',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 1280 AND p.composer_id = 99 AND part.part_key = 'musicbrainz:58f7c7a5-8ca6-41a2-89b9-780d8b407a04' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:58f7c7a5-8ca6-41a2-89b9-780d8b407a04', 2, 'III', 'Aparición de Real', 'El hombre de la esquina rosada: III. Aparición de Real', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 1280 AND p.composer_id = 99
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:58f7c7a5-8ca6-41a2-89b9-780d8b407a04'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'V',
    part.name_ko = 'Bailongo', part.name_en = 'El hombre de la esquina rosada: V. Bailongo',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 1280 AND p.composer_id = 99 AND part.part_key = 'musicbrainz:75a9ef40-b945-44af-9575-144b228b9cc7' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:75a9ef40-b945-44af-9575-144b228b9cc7', 3, 'V', 'Bailongo', 'El hombre de la esquina rosada: V. Bailongo', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 1280 AND p.composer_id = 99
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:75a9ef40-b945-44af-9575-144b228b9cc7'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = 'IV',
    part.name_ko = 'Milonga nocturna', part.name_en = 'El hombre de la esquina rosada: IV. Milonga nocturna',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 1280 AND p.composer_id = 99 AND part.part_key = 'musicbrainz:7e67f4bb-739c-4d3c-be93-219cfd473ff9' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:7e67f4bb-739c-4d3c-be93-219cfd473ff9', 4, 'IV', 'Milonga nocturna', 'El hombre de la esquina rosada: IV. Milonga nocturna', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 1280 AND p.composer_id = 99
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:7e67f4bb-739c-4d3c-be93-219cfd473ff9'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 5, part.movement_number = 'II',
    part.name_ko = 'Rosendo y La Lujanera', part.name_en = 'El hombre de la esquina rosada: II. Rosendo y La Lujanera',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 1280 AND p.composer_id = 99 AND part.part_key = 'musicbrainz:9e5b575b-c1f4-4d29-8b1e-3a47b72be848' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:9e5b575b-c1f4-4d29-8b1e-3a47b72be848', 5, 'II', 'Rosendo y La Lujanera', 'El hombre de la esquina rosada: II. Rosendo y La Lujanera', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 1280 AND p.composer_id = 99
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:9e5b575b-c1f4-4d29-8b1e-3a47b72be848'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 6, part.movement_number = 'I',
    part.name_ko = 'Aparición de Rosendo', part.name_en = 'El hombre de la esquina rosada: I. Aparición de Rosendo',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 1280 AND p.composer_id = 99 AND part.part_key = 'musicbrainz:fd1e7476-2c14-407a-a6dd-00387c9f9ccf' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:fd1e7476-2c14-407a-a6dd-00387c9f9ccf', 6, 'I', 'Aparición de Rosendo', 'El hombre de la esquina rosada: I. Aparición de Rosendo', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 1280 AND p.composer_id = 99
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:fd1e7476-2c14-407a-a6dd-00387c9f9ccf'
);


-- None El mundo de los dos

UPDATE pieces piece
SET piece.title = 'El mundo de los dos', piece.title_en = 'El mundo de los dos',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 1724 AND piece.composer_id = 99
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None El penúltimo

UPDATE pieces piece
SET piece.title = 'El penúltimo', piece.title_en = 'El penúltimo',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 2925 AND piece.composer_id = 99
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None El tango

UPDATE pieces piece
SET piece.title = 'El tango', piece.title_en = 'El tango',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 2491 AND piece.composer_id = 99
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None 가곡 <El títere>

UPDATE pieces piece
SET piece.title = '가곡 <El títere>', piece.title_en = 'El títere',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 1273 AND piece.composer_id = 99
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Elegante Canyenguito

UPDATE pieces piece
SET piece.title = 'Elegante Canyenguito', piece.title_en = 'Elegante Canyenguito',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 1522 AND piece.composer_id = 99
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None En 3x4

UPDATE pieces piece
SET piece.title = 'En 3x4', piece.title_en = 'En 3x4',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 1839 AND piece.composer_id = 99
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Enrico IV

UPDATE pieces piece
SET piece.title = 'Enrico IV', piece.title_en = 'Enrico IV',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 2643 AND piece.composer_id = 99
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Final

UPDATE pieces piece
SET piece.title = 'Final', piece.title_en = 'Final',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 1633 AND piece.composer_id = 99
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None 가곡 <Finale (Tango apasionado)>

UPDATE pieces piece
SET piece.title = '가곡 <Finale (Tango apasionado)>', piece.title_en = 'Finale (Tango apasionado)',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 2816 AND piece.composer_id = 99
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Five Tango Sensations, for Bandoneón and String Quartet

UPDATE pieces piece
SET piece.title = 'Five Tango Sensations, for Bandoneón and String Quartet', piece.title_en = 'Five Tango Sensations, for Bandoneón and String Quartet',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 2280 AND piece.composer_id = 99
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'Asleep', part.name_en = 'Five Tango Sensations, for Bandoneón and String Quartet: I. Asleep',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 2280 AND p.composer_id = 99 AND part.part_key = 'musicbrainz:12b59b32-881b-4ec1-8e6c-aaba4c0a4a05' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:12b59b32-881b-4ec1-8e6c-aaba4c0a4a05', 1, 'I', 'Asleep', 'Five Tango Sensations, for Bandoneón and String Quartet: I. Asleep', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 2280 AND p.composer_id = 99
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:12b59b32-881b-4ec1-8e6c-aaba4c0a4a05'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'Loving', part.name_en = 'Five Tango Sensations, for Bandoneón and String Quartet: II. Loving',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 2280 AND p.composer_id = 99 AND part.part_key = 'musicbrainz:6b7f0e15-b79d-430d-bc2e-439cc0efae66' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:6b7f0e15-b79d-430d-bc2e-439cc0efae66', 2, 'II', 'Loving', 'Five Tango Sensations, for Bandoneón and String Quartet: II. Loving', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 2280 AND p.composer_id = 99
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:6b7f0e15-b79d-430d-bc2e-439cc0efae66'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = 'Anxiety', part.name_en = 'Five Tango Sensations, for Bandoneón and String Quartet: III. Anxiety',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 2280 AND p.composer_id = 99 AND part.part_key = 'musicbrainz:aecd5574-b89b-4996-a685-cdeb31944362' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:aecd5574-b89b-4996-a685-cdeb31944362', 3, 'III', 'Anxiety', 'Five Tango Sensations, for Bandoneón and String Quartet: III. Anxiety', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 2280 AND p.composer_id = 99
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:aecd5574-b89b-4996-a685-cdeb31944362'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = 'IV',
    part.name_ko = 'Despertar', part.name_en = 'Five Tango Sensations, for Bandoneón and String Quartet: IV. Despertar',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 2280 AND p.composer_id = 99 AND part.part_key = 'musicbrainz:57dace1b-c49a-4a1d-907d-96c278babb52' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:57dace1b-c49a-4a1d-907d-96c278babb52', 4, 'IV', 'Despertar', 'Five Tango Sensations, for Bandoneón and String Quartet: IV. Despertar', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 2280 AND p.composer_id = 99
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:57dace1b-c49a-4a1d-907d-96c278babb52'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 5, part.movement_number = 'V',
    part.name_ko = 'Fear', part.name_en = 'Five Tango Sensations, for Bandoneón and String Quartet: V. Fear',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 2280 AND p.composer_id = 99 AND part.part_key = 'musicbrainz:c20602b0-5042-4c58-b069-1c70d5ba52ea' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:c20602b0-5042-4c58-b069-1c70d5ba52ea', 5, 'V', 'Fear', 'Five Tango Sensations, for Bandoneón and String Quartet: V. Fear', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 2280 AND p.composer_id = 99
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:c20602b0-5042-4c58-b069-1c70d5ba52ea'
);


-- None Fleurs fanées

UPDATE pieces piece
SET piece.title = 'Fleurs fanées', piece.title_en = 'Fleurs fanées',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 1851 AND piece.composer_id = 99
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Fotografia

UPDATE pieces piece
SET piece.title = 'Fotografia', piece.title_en = 'Fotografia',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 2308 AND piece.composer_id = 99
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Four for Tango

UPDATE pieces piece
SET piece.title = 'Four for Tango', piece.title_en = 'Four for Tango',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 1942 AND piece.composer_id = 99
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Fracanapa

UPDATE pieces piece
SET piece.title = 'Fracanapa', piece.title_en = 'Fracanapa',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 1767 AND piece.composer_id = 99
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None 가곡 <Fuga 9>

UPDATE pieces piece
SET piece.title = '가곡 <Fuga 9>', piece.title_en = 'Fuga 9',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 638 AND piece.composer_id = 99
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Goooal ! (Golazo)

UPDATE pieces piece
SET piece.title = 'Goooal ! (Golazo)', piece.title_en = 'Goooal ! (Golazo)',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 2728 AND piece.composer_id = 99
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Gracia Alegre

UPDATE pieces piece
SET piece.title = 'Gracia Alegre', piece.title_en = 'Gracia Alegre',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 2518 AND piece.composer_id = 99
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Gracia Amor

UPDATE pieces piece
SET piece.title = 'Gracia Amor', piece.title_en = 'Gracia Amor',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 1000 AND piece.composer_id = 99
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Homenaje a Córdoba

UPDATE pieces piece
SET piece.title = 'Homenaje a Córdoba', piece.title_en = 'Homenaje a Córdoba',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 2373 AND piece.composer_id = 99
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None 가곡 <Homenaje a Lieja>

UPDATE pieces piece
SET piece.title = '가곡 <Homenaje a Lieja>', piece.title_en = 'Homenaje a Lieja',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 1245 AND piece.composer_id = 99
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'Introduction', part.name_en = 'Homenaje a Lieja: I. Introduction',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 1245 AND p.composer_id = 99 AND part.part_key = 'musicbrainz:04ab254c-ccb3-4e6d-a5d9-925deb60824f' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:04ab254c-ccb3-4e6d-a5d9-925deb60824f', 1, 'I', 'Introduction', 'Homenaje a Lieja: I. Introduction', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 1245 AND p.composer_id = 99
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:04ab254c-ccb3-4e6d-a5d9-925deb60824f'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'Milonga', part.name_en = 'Homenaje a Lieja: II. Milonga',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 1245 AND p.composer_id = 99 AND part.part_key = 'musicbrainz:6924c9c3-ec44-41e7-a9dc-9857e47e54b7' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:6924c9c3-ec44-41e7-a9dc-9857e47e54b7', 2, 'II', 'Milonga', 'Homenaje a Lieja: II. Milonga', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 1245 AND p.composer_id = 99
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:6924c9c3-ec44-41e7-a9dc-9857e47e54b7'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = 'Tango', part.name_en = 'Homenaje a Lieja: III. Tango',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 1245 AND p.composer_id = 99 AND part.part_key = 'musicbrainz:3fd64912-1b9d-4256-90ca-0bca8e2caf2c' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:3fd64912-1b9d-4256-90ca-0bca8e2caf2c', 3, 'III', 'Tango', 'Homenaje a Lieja: III. Tango', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 1245 AND p.composer_id = 99
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:3fd64912-1b9d-4256-90ca-0bca8e2caf2c'
);


-- None 가곡 <Idioot>

UPDATE pieces piece
SET piece.title = '가곡 <Idioot>', piece.title_en = 'Idioot',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 2965 AND piece.composer_id = 99
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Imperial

UPDATE pieces piece
SET piece.title = 'Imperial', piece.title_en = 'Imperial',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 799 AND piece.composer_id = 99
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None 가곡 <Imágenes 676>

UPDATE pieces piece
SET piece.title = '가곡 <Imágenes 676>', piece.title_en = 'Imágenes 676',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 2918 AND piece.composer_id = 99
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Introducción al ángel

UPDATE pieces piece
SET piece.title = 'Introducción al ángel', piece.title_en = 'Introducción al ángel',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 805 AND piece.composer_id = 99
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Introduzione

UPDATE pieces piece
SET piece.title = 'Introduzione', piece.title_en = 'Introduzione',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 2942 AND piece.composer_id = 99
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Iracundo

UPDATE pieces piece
SET piece.title = 'Iracundo', piece.title_en = 'Iracundo',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 1479 AND piece.composer_id = 99
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Isa Rizzo

UPDATE pieces piece
SET piece.title = 'Isa Rizzo', piece.title_en = 'Isa Rizzo',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 1145 AND piece.composer_id = 99
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None J'attends

UPDATE pieces piece
SET piece.title = 'J''attends', piece.title_en = 'J''attends',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 1702 AND piece.composer_id = 99
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None 가곡 <Jacinto Chiclana>

UPDATE pieces piece
SET piece.title = '가곡 <Jacinto Chiclana>', piece.title_en = 'Jacinto Chiclana',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 586 AND piece.composer_id = 99
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Jeanne y Paul

UPDATE pieces piece
SET piece.title = 'Jeanne y Paul', piece.title_en = 'Jeanne y Paul',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 2231 AND piece.composer_id = 99
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Jorge adiós

UPDATE pieces piece
SET piece.title = 'Jorge adiós', piece.title_en = 'Jorge adiós',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 947 AND piece.composer_id = 99
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None 가곡 <J’oublie>

UPDATE pieces piece
SET piece.title = '가곡 <J’oublie>', piece.title_en = 'J’oublie',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 1473 AND piece.composer_id = 99
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None 가곡 <Kicho>

UPDATE pieces piece
SET piece.title = '가곡 <Kicho>', piece.title_en = 'Kicho',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 807 AND piece.composer_id = 99
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None 가곡 <Knife Fight>

UPDATE pieces piece
SET piece.title = '가곡 <Knife Fight>', piece.title_en = 'Knife Fight',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 2568 AND piece.composer_id = 99
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None La Camorra

UPDATE pieces piece
SET piece.title = 'La Camorra', piece.title_en = 'La Camorra',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 1084 AND piece.composer_id = 99
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None La Felure

UPDATE pieces piece
SET piece.title = 'La Felure', piece.title_en = 'La Felure',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 1271 AND piece.composer_id = 99
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None 가곡 <La bicicleta blanca>

UPDATE pieces piece
SET piece.title = '가곡 <La bicicleta blanca>', piece.title_en = 'La bicicleta blanca',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 2370 AND piece.composer_id = 99
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None La evasión

UPDATE pieces piece
SET piece.title = 'La evasión', piece.title_en = 'La evasión',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 2525 AND piece.composer_id = 99
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None 가곡 <Lames>

UPDATE pieces piece
SET piece.title = '가곡 <Lames>', piece.title_en = 'Lames',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 709 AND piece.composer_id = 99
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Largo Tangabile

UPDATE pieces piece
SET piece.title = 'Largo Tangabile', piece.title_en = 'Largo Tangabile',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 1598 AND piece.composer_id = 99
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Las cuatro estaciones porteñas

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'Otoño porteño', part.name_en = 'Otoño porteño',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 377 AND p.composer_id = 99 AND part.part_key = 'musicbrainz:9c17a447-194f-35bf-a34b-52eefdfc72b2' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:9c17a447-194f-35bf-a34b-52eefdfc72b2', 1, NULL, 'Otoño porteño', 'Otoño porteño', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 377 AND p.composer_id = 99
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:9c17a447-194f-35bf-a34b-52eefdfc72b2'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'Invierno porteño', part.name_en = 'Invierno porteño',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 377 AND p.composer_id = 99 AND part.part_key = 'musicbrainz:3a238c37-dc1b-3a66-aaf4-22e74ac69d7f' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:3a238c37-dc1b-3a66-aaf4-22e74ac69d7f', 2, NULL, 'Invierno porteño', 'Invierno porteño', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 377 AND p.composer_id = 99
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:3a238c37-dc1b-3a66-aaf4-22e74ac69d7f'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = NULL,
    part.name_ko = 'Primavera porteña', part.name_en = 'Primavera porteña',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 377 AND p.composer_id = 99 AND part.part_key = 'musicbrainz:f4f27d7a-893c-3c5c-bfe8-cdca1025f2fa' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:f4f27d7a-893c-3c5c-bfe8-cdca1025f2fa', 3, NULL, 'Primavera porteña', 'Primavera porteña', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 377 AND p.composer_id = 99
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:f4f27d7a-893c-3c5c-bfe8-cdca1025f2fa'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = NULL,
    part.name_ko = 'Verano porteño', part.name_en = 'Verano porteño',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 377 AND p.composer_id = 99 AND part.part_key = 'musicbrainz:77eb79b1-ac8c-36b4-be06-432fb797c6ce' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:77eb79b1-ac8c-36b4-be06-432fb797c6ce', 4, NULL, 'Verano porteño', 'Verano porteño', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 377 AND p.composer_id = 99
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:77eb79b1-ac8c-36b4-be06-432fb797c6ce'
);


-- None 가곡 <Laura's Dream>

UPDATE pieces piece
SET piece.title = '가곡 <Laura''s Dream>', piece.title_en = 'Laura''s Dream',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 1074 AND piece.composer_id = 99
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Le Haut Mur

UPDATE pieces piece
SET piece.title = 'Le Haut Mur', piece.title_en = 'Le Haut Mur',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 1849 AND piece.composer_id = 99
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None 가곡 <Leijia’s Game>

UPDATE pieces piece
SET piece.title = '가곡 <Leijia’s Game>', piece.title_en = 'Leijia’s Game',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 1176 AND piece.composer_id = 99
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None 가곡 <Leonora's Love Theme>

UPDATE pieces piece
SET piece.title = '가곡 <Leonora''s Love Theme>', piece.title_en = 'Leonora''s Love Theme',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 1968 AND piece.composer_id = 99
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None 가곡 <Leonora’s Song>

UPDATE pieces piece
SET piece.title = '가곡 <Leonora’s Song>', piece.title_en = 'Leonora’s Song',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 1952 AND piece.composer_id = 99
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Les Draps blancs

UPDATE pieces piece
SET piece.title = 'Les Draps blancs', piece.title_en = 'Les Draps blancs',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 1493 AND piece.composer_id = 99
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Lo que vendrá

UPDATE pieces piece
SET piece.title = 'Lo que vendrá', piece.title_en = 'Lo que vendrá',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 1317 AND piece.composer_id = 99
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Look Out

UPDATE pieces piece
SET piece.title = 'Look Out', piece.title_en = 'Look Out',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 2247 AND piece.composer_id = 99
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Los Paraguas de Buenos Aires

UPDATE pieces piece
SET piece.title = 'Los Paraguas de Buenos Aires', piece.title_en = 'Los Paraguas de Buenos Aires',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 2281 AND piece.composer_id = 99
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None 가곡 <Los sueños>

UPDATE pieces piece
SET piece.title = '가곡 <Los sueños>', piece.title_en = 'Los sueños',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 2040 AND piece.composer_id = 99
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Loving

UPDATE pieces piece
SET piece.title = 'Loving', piece.title_en = 'Loving',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 2265 AND piece.composer_id = 99
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Luna

UPDATE pieces piece
SET piece.title = 'Luna', piece.title_en = 'Luna',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 890 AND piece.composer_id = 99
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None 가곡 <Lunfardo>

UPDATE pieces piece
SET piece.title = '가곡 <Lunfardo>', piece.title_en = 'Lunfardo',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 727 AND piece.composer_id = 99
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Luz y sombra

UPDATE pieces piece
SET piece.title = 'Luz y sombra', piece.title_en = 'Luz y sombra',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 800 AND piece.composer_id = 99
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None L’Évasion

UPDATE pieces piece
SET piece.title = 'L’Évasion', piece.title_en = 'L’Évasion',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 2850 AND piece.composer_id = 99
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Mandat d'amener

UPDATE pieces piece
SET piece.title = 'Mandat d''amener', piece.title_en = 'Mandat d''amener',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 1441 AND piece.composer_id = 99
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Marejadilla

UPDATE pieces piece
SET piece.title = 'Marejadilla', piece.title_en = 'Marejadilla',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 1359 AND piece.composer_id = 99
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None 가곡 <Marrón y azul>

UPDATE pieces piece
SET piece.title = '가곡 <Marrón y azul>', piece.title_en = 'Marrón y azul',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 801 AND piece.composer_id = 99
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None 오페라 <María de Buenos Aires>

UPDATE pieces piece
SET piece.title = '오페라 <María de Buenos Aires>', piece.title_en = 'María de Buenos Aires',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 606 AND piece.composer_id = 99
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'Balada para un loco', part.name_en = 'María de Buenos Aires: Balada para un loco',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 606 AND p.composer_id = 99 AND part.part_key = 'musicbrainz:111b3d40-173d-4597-b355-bb2389712215' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:111b3d40-173d-4597-b355-bb2389712215', 1, NULL, 'Balada para un loco', 'María de Buenos Aires: Balada para un loco', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 606 AND p.composer_id = 99
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:111b3d40-173d-4597-b355-bb2389712215'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'Yo soy María', part.name_en = 'María de Buenos Aires: Yo soy María',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 606 AND p.composer_id = 99 AND part.part_key = 'musicbrainz:54f10827-7ff6-46d0-a813-62de1d3f758e' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:54f10827-7ff6-46d0-a813-62de1d3f758e', 2, NULL, 'Yo soy María', 'María de Buenos Aires: Yo soy María', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 606 AND p.composer_id = 99
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:54f10827-7ff6-46d0-a813-62de1d3f758e'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = NULL,
    part.name_ko = 'Milonga carrieguera por María la niña', part.name_en = 'María de Buenos Aires: Milonga carrieguera por María la niña',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 606 AND p.composer_id = 99 AND part.part_key = 'musicbrainz:0e54507c-02d5-4538-afff-d161ffd87a70' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:0e54507c-02d5-4538-afff-d161ffd87a70', 3, NULL, 'Milonga carrieguera por María la niña', 'María de Buenos Aires: Milonga carrieguera por María la niña', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 606 AND p.composer_id = 99
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:0e54507c-02d5-4538-afff-d161ffd87a70'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = NULL,
    part.name_ko = 'Poema valseado', part.name_en = 'María de Buenos Aires: Poema valseado',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 606 AND p.composer_id = 99 AND part.part_key = 'musicbrainz:14985893-b4f6-39aa-b9fb-3043b8f07b78' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:14985893-b4f6-39aa-b9fb-3043b8f07b78', 4, NULL, 'Poema valseado', 'María de Buenos Aires: Poema valseado', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 606 AND p.composer_id = 99
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:14985893-b4f6-39aa-b9fb-3043b8f07b78'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 5, part.movement_number = NULL,
    part.name_ko = 'Tocata rea', part.name_en = 'María de Buenos Aires: Tocata rea',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 606 AND p.composer_id = 99 AND part.part_key = 'musicbrainz:ca3678df-97db-4dc1-bb66-3bcb0d6e14b8' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:ca3678df-97db-4dc1-bb66-3bcb0d6e14b8', 5, NULL, 'Tocata rea', 'María de Buenos Aires: Tocata rea', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 606 AND p.composer_id = 99
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:ca3678df-97db-4dc1-bb66-3bcb0d6e14b8'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 6, part.movement_number = NULL,
    part.name_ko = 'Contramilonga a la funerala por la primera muerte de María', part.name_en = 'María de Buenos Aires: Contramilonga a la funerala por la primera muerte de María',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 606 AND p.composer_id = 99 AND part.part_key = 'musicbrainz:8a5aa366-7b0e-4304-ad53-5b51c2324568' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:8a5aa366-7b0e-4304-ad53-5b51c2324568', 6, NULL, 'Contramilonga a la funerala por la primera muerte de María', 'María de Buenos Aires: Contramilonga a la funerala por la primera muerte de María', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 606 AND p.composer_id = 99
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:8a5aa366-7b0e-4304-ad53-5b51c2324568'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 7, part.movement_number = NULL,
    part.name_ko = 'Tangata del Alba', part.name_en = 'María de Buenos Aires: Tangata del Alba',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 606 AND p.composer_id = 99 AND part.part_key = 'musicbrainz:7e583e74-59ab-4449-a19e-5e247d96ee16' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:7e583e74-59ab-4449-a19e-5e247d96ee16', 7, NULL, 'Tangata del Alba', 'María de Buenos Aires: Tangata del Alba', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 606 AND p.composer_id = 99
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:7e583e74-59ab-4449-a19e-5e247d96ee16'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 8, part.movement_number = NULL,
    part.name_ko = 'Allegro tangabile', part.name_en = 'María de Buenos Aires: Allegro tangabile',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 606 AND p.composer_id = 99 AND part.part_key = 'musicbrainz:6c6fa0ef-581c-4dcf-b395-9873ef07170d' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:6c6fa0ef-581c-4dcf-b395-9873ef07170d', 8, NULL, 'Allegro tangabile', 'María de Buenos Aires: Allegro tangabile', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 606 AND p.composer_id = 99
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:6c6fa0ef-581c-4dcf-b395-9873ef07170d'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 9, part.movement_number = NULL,
    part.name_ko = 'Milonga de la Anunciación', part.name_en = 'María de Buenos Aires: Milonga de la Anunciación',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 606 AND p.composer_id = 99 AND part.part_key = 'musicbrainz:20036dab-9faf-4d83-9f08-d4d05a5a42c7' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:20036dab-9faf-4d83-9f08-d4d05a5a42c7', 9, NULL, 'Milonga de la Anunciación', 'María de Buenos Aires: Milonga de la Anunciación', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 606 AND p.composer_id = 99
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:20036dab-9faf-4d83-9f08-d4d05a5a42c7'
);


-- None 가곡 <María y las aves>

UPDATE pieces piece
SET piece.title = '가곡 <María y las aves>', piece.title_en = 'María y las aves',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 2800 AND piece.composer_id = 99
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Masque noir

UPDATE pieces piece
SET piece.title = 'Masque noir', piece.title_en = 'Masque noir',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 1986 AND piece.composer_id = 99
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Meditango

UPDATE pieces piece
SET piece.title = 'Meditango', piece.title_en = 'Meditango',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 1559 AND piece.composer_id = 99
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Melancolico Buenos Aires

UPDATE pieces piece
SET piece.title = 'Melancolico Buenos Aires', piece.title_en = 'Melancolico Buenos Aires',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 2029 AND piece.composer_id = 99
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Melodía en la menor (Canto de octubre)

UPDATE pieces piece
SET piece.title = 'Melodía en la menor (Canto de octubre)', piece.title_en = 'Melodía en la menor (Canto de octubre)',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 2486 AND piece.composer_id = 99
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None 가곡 <Michelangelo ’70>

UPDATE pieces piece
SET piece.title = '가곡 <Michelangelo ’70>', piece.title_en = 'Michelangelo ’70',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 2423 AND piece.composer_id = 99
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None 밀롱가

UPDATE pieces piece
SET piece.title = '밀롱가', piece.title_en = 'Milonga',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 1557 AND piece.composer_id = 99
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Milonga del trovador

UPDATE pieces piece
SET piece.title = 'Milonga del trovador', piece.title_en = 'Milonga del trovador',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 2657 AND piece.composer_id = 99
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Milonga en re

UPDATE pieces piece
SET piece.title = 'Milonga en re', piece.title_en = 'Milonga en re',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 1776 AND piece.composer_id = 99
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Milonga loca

UPDATE pieces piece
SET piece.title = 'Milonga loca', piece.title_en = 'Milonga loca',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 1844 AND piece.composer_id = 99
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Milonga para tres

UPDATE pieces piece
SET piece.title = 'Milonga para tres', piece.title_en = 'Milonga para tres',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 574 AND piece.composer_id = 99
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None 가곡 <Milonga picaresque>

UPDATE pieces piece
SET piece.title = '가곡 <Milonga picaresque>', piece.title_en = 'Milonga picaresque',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 1580 AND piece.composer_id = 99
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Milonga strip (Corner)

UPDATE pieces piece
SET piece.title = 'Milonga strip (Corner)', piece.title_en = 'Milonga strip (Corner)',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 2938 AND piece.composer_id = 99
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Moderato Tangabile

UPDATE pieces piece
SET piece.title = 'Moderato Tangabile', piece.title_en = 'Moderato Tangabile',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 2785 AND piece.composer_id = 99
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None 가곡 <Moi, je suis tango>

UPDATE pieces piece
SET piece.title = '가곡 <Moi, je suis tango>', piece.title_en = 'Moi, je suis tango',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 806 AND piece.composer_id = 99
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None 가곡 <Movimiento continuo>

UPDATE pieces piece
SET piece.title = '가곡 <Movimiento continuo>', piece.title_en = 'Movimiento continuo',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 2239 AND piece.composer_id = 99
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Mufa sesenta y dos

UPDATE pieces piece
SET piece.title = 'Mufa sesenta y dos', piece.title_en = 'Mufa sesenta y dos',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 868 AND piece.composer_id = 99
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Murmullo sensual

UPDATE pieces piece
SET piece.title = 'Murmullo sensual', piece.title_en = 'Murmullo sensual',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 1065 AND piece.composer_id = 99
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Novitango

UPDATE pieces piece
SET piece.title = 'Novitango', piece.title_en = 'Novitango',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 1994 AND piece.composer_id = 99
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None 가곡 <Nuestro tiempo>

UPDATE pieces piece
SET piece.title = '가곡 <Nuestro tiempo>', piece.title_en = 'Nuestro tiempo',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 1229 AND piece.composer_id = 99
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Nuevo mondo

UPDATE pieces piece
SET piece.title = 'Nuevo mondo', piece.title_en = 'Nuevo mondo',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 1608 AND piece.composer_id = 99
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None 가곡 <Nuevo tango>

UPDATE pieces piece
SET piece.title = '가곡 <Nuevo tango>', piece.title_en = 'Nuevo tango',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 950 AND piece.composer_id = 99
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None 가곡 <Oda intima a Buenos Aires>

UPDATE pieces piece
SET piece.title = '가곡 <Oda intima a Buenos Aires>', piece.title_en = 'Oda intima a Buenos Aires',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 2393 AND piece.composer_id = 99
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Oda para un hippie

UPDATE pieces piece
SET piece.title = 'Oda para un hippie', piece.title_en = 'Oda para un hippie',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 1999 AND piece.composer_id = 99
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Olhos de Ressaca

UPDATE pieces piece
SET piece.title = 'Olhos de Ressaca', piece.title_en = 'Olhos de Ressaca',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 1700 AND piece.composer_id = 99
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Onda 9

UPDATE pieces piece
SET piece.title = 'Onda 9', piece.title_en = 'Onda 9',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 617 AND piece.composer_id = 99
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Orchestre Du Theatre

UPDATE pieces piece
SET piece.title = 'Orchestre Du Theatre', piece.title_en = 'Orchestre Du Theatre',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 1301 AND piece.composer_id = 99
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Palabras

UPDATE pieces piece
SET piece.title = 'Palabras', piece.title_en = 'Palabras',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 1481 AND piece.composer_id = 99
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Panic (Marcacion)

UPDATE pieces piece
SET piece.title = 'Panic (Marcacion)', piece.title_en = 'Panic (Marcacion)',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 2885 AND piece.composer_id = 99
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Pedro y Pedro

UPDATE pieces piece
SET piece.title = 'Pedro y Pedro', piece.title_en = 'Pedro y Pedro',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 2597 AND piece.composer_id = 99
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Persecuta

UPDATE pieces piece
SET piece.title = 'Persecuta', piece.title_en = 'Persecuta',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 2503 AND piece.composer_id = 99
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Pia-Sol-La-Sol

UPDATE pieces piece
SET piece.title = 'Pia-Sol-La-Sol', piece.title_en = 'Pia-Sol-La-Sol',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 1350 AND piece.composer_id = 99
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None 가곡 <Por millones de niños>

UPDATE pieces piece
SET piece.title = '가곡 <Por millones de niños>', piece.title_en = 'Por millones de niños',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 913 AND piece.composer_id = 99
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None 가곡 <Prelude to the Cyclical Night, Part One>

UPDATE pieces piece
SET piece.title = '가곡 <Prelude to the Cyclical Night, Part One>', piece.title_en = 'Prelude to the Cyclical Night, Part One',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 1352 AND piece.composer_id = 99
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None 가곡 <Prelude to the Cyclical Night, Part Two>

UPDATE pieces piece
SET piece.title = '가곡 <Prelude to the Cyclical Night, Part Two>', piece.title_en = 'Prelude to the Cyclical Night, Part Two',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 1020 AND piece.composer_id = 99
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Preludio 1953

UPDATE pieces piece
SET piece.title = 'Preludio 1953', piece.title_en = 'Preludio 1953',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 2236 AND piece.composer_id = 99
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Preludio 9

UPDATE pieces piece
SET piece.title = 'Preludio 9', piece.title_en = 'Preludio 9',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 1947 AND piece.composer_id = 99
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None 전주곡 1번

UPDATE pieces piece
SET piece.title = '전주곡 1번', piece.title_en = 'Preludio no. 1 for Violin and Piano',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 931 AND piece.composer_id = 99
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Preludio y Fuga

UPDATE pieces piece
SET piece.title = 'Preludio y Fuga', piece.title_en = 'Preludio y Fuga',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 1879 AND piece.composer_id = 99
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Prepárense

UPDATE pieces piece
SET piece.title = 'Prepárense', piece.title_en = 'Prepárense',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 802 AND piece.composer_id = 99
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Presagio

UPDATE pieces piece
SET piece.title = 'Presagio', piece.title_en = 'Presagio',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 1091 AND piece.composer_id = 99
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None 가곡 <Prologue (Tango apasionado)>

UPDATE pieces piece
SET piece.title = '가곡 <Prologue (Tango apasionado)>', piece.title_en = 'Prologue (Tango apasionado)',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 1126 AND piece.composer_id = 99
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Pulsacion No. 2

UPDATE pieces piece
SET piece.title = 'Pulsacion No. 2', piece.title_en = 'Pulsacion No. 2',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 1451 AND piece.composer_id = 99
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Qui crie ?

UPDATE pieces piece
SET piece.title = 'Qui crie ?', piece.title_en = 'Qui crie ?',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 1806 AND piece.composer_id = 99
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Raviens vers moi

UPDATE pieces piece
SET piece.title = 'Raviens vers moi', piece.title_en = 'Raviens vers moi',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 2755 AND piece.composer_id = 99
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None 가곡 <Realidad>

UPDATE pieces piece
SET piece.title = '가곡 <Realidad>', piece.title_en = 'Realidad',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 643 AND piece.composer_id = 99
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Recordando

UPDATE pieces piece
SET piece.title = 'Recordando', piece.title_en = 'Recordando',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 1512 AND piece.composer_id = 99
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Remembrance

UPDATE pieces piece
SET piece.title = 'Remembrance', piece.title_en = 'Remembrance',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 2739 AND piece.composer_id = 99
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None 가곡 <Reminiscence>

UPDATE pieces piece
SET piece.title = '가곡 <Reminiscence>', piece.title_en = 'Reminiscence',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 2243 AND piece.composer_id = 99
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None 가곡 <Revirado>

UPDATE pieces piece
SET piece.title = '가곡 <Revirado>', piece.title_en = 'Revirado',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 1726 AND piece.composer_id = 99
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Revolucionario

UPDATE pieces piece
SET piece.title = 'Revolucionario', piece.title_en = 'Revolucionario',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 2948 AND piece.composer_id = 99
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Romance del diablo

UPDATE pieces piece
SET piece.title = 'Romance del diablo', piece.title_en = 'Romance del diablo',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 1202 AND piece.composer_id = 99
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None 가곡 <Romanza del duende>

UPDATE pieces piece
SET piece.title = '가곡 <Romanza del duende>', piece.title_en = 'Romanza del duende',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 2394 AND piece.composer_id = 99
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None 가곡 <Rosa río>

UPDATE pieces piece
SET piece.title = '가곡 <Rosa río>', piece.title_en = 'Rosa río',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 2188 AND piece.composer_id = 99
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Río Sena

UPDATE pieces piece
SET piece.title = 'Río Sena', piece.title_en = 'Río Sena',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 803 AND piece.composer_id = 99
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Se armó

UPDATE pieces piece
SET piece.title = 'Se armó', piece.title_en = 'Se armó',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 2517 AND piece.composer_id = 99
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None 가곡 <Se fue sin decirme adios>

UPDATE pieces piece
SET piece.title = '가곡 <Se fue sin decirme adios>', piece.title_en = 'Se fue sin decirme adios',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 1410 AND piece.composer_id = 99
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None 가곡 <Siempre se vuelve a Buenos Aires>

UPDATE pieces piece
SET piece.title = '가곡 <Siempre se vuelve a Buenos Aires>', piece.title_en = 'Siempre se vuelve a Buenos Aires',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 811 AND piece.composer_id = 99
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- Op. 15 Sinfonia Buenos Aires

UPDATE pieces piece
SET piece.title = 'Sinfonia Buenos Aires', piece.title_en = 'Sinfonia Buenos Aires, op. 15',
    piece.type = 'album', piece.opus_number = 'Op. 15',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 2946 AND piece.composer_id = 99
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'Moderato - Allegretto', part.name_en = 'Sinfonia Buenos Aires, op. 15: I. Moderato - Allegretto',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 2946 AND p.composer_id = 99 AND part.part_key = 'musicbrainz:d4ee3d72-2c23-437b-bc6e-d2ec748f4666' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:d4ee3d72-2c23-437b-bc6e-d2ec748f4666', 1, 'I', 'Moderato - Allegretto', 'Sinfonia Buenos Aires, op. 15: I. Moderato - Allegretto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 2946 AND p.composer_id = 99
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:d4ee3d72-2c23-437b-bc6e-d2ec748f4666'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'Lento, con anima', part.name_en = 'Sinfonia Buenos Aires, op. 15: II. Lento, con anima',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 2946 AND p.composer_id = 99 AND part.part_key = 'musicbrainz:f7a9b754-17bb-410a-9ee5-2f09909535c3' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:f7a9b754-17bb-410a-9ee5-2f09909535c3', 2, 'II', 'Lento, con anima', 'Sinfonia Buenos Aires, op. 15: II. Lento, con anima', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 2946 AND p.composer_id = 99
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:f7a9b754-17bb-410a-9ee5-2f09909535c3'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = 'Presto marcato', part.name_en = 'Sinfonia Buenos Aires, op. 15: III. Presto marcato',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 2946 AND p.composer_id = 99 AND part.part_key = 'musicbrainz:e716be08-d7f0-4144-843c-1186cfedc185' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:e716be08-d7f0-4144-843c-1186cfedc185', 3, 'III', 'Presto marcato', 'Sinfonia Buenos Aires, op. 15: III. Presto marcato', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 2946 AND p.composer_id = 99
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:e716be08-d7f0-4144-843c-1186cfedc185'
);


-- None 신포니에타

UPDATE pieces piece
SET piece.title = '신포니에타', piece.title_en = 'Sinfonietta',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 1611 AND piece.composer_id = 99
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'Dramatico. Allegro marcato, in poco pesante', part.name_en = 'Sinfonietta: I. Dramatico. Allegro marcato, in poco pesante',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 1611 AND p.composer_id = 99 AND part.part_key = 'musicbrainz:7490c815-78ef-44d4-89f2-23389acd06db' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:7490c815-78ef-44d4-89f2-23389acd06db', 1, 'I', 'Dramatico. Allegro marcato, in poco pesante', 'Sinfonietta: I. Dramatico. Allegro marcato, in poco pesante', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 1611 AND p.composer_id = 99
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:7490c815-78ef-44d4-89f2-23389acd06db'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'Sobrio. Andantino - Poco più mosso - Tempo I', part.name_en = 'Sinfonietta: II. Sobrio. Andantino - Poco più mosso - Tempo I',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 1611 AND p.composer_id = 99 AND part.part_key = 'musicbrainz:5e98e696-6e0b-4caf-866e-e4c20d9cd709' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:5e98e696-6e0b-4caf-866e-e4c20d9cd709', 2, 'II', 'Sobrio. Andantino - Poco più mosso - Tempo I', 'Sinfonietta: II. Sobrio. Andantino - Poco più mosso - Tempo I', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 1611 AND p.composer_id = 99
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:5e98e696-6e0b-4caf-866e-e4c20d9cd709'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = 'Jubiloso. Vivace', part.name_en = 'Sinfonietta: III. Jubiloso. Vivace',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 1611 AND p.composer_id = 99 AND part.part_key = 'musicbrainz:87d45328-b128-4d65-bbfb-0e829a78560e' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:87d45328-b128-4d65-bbfb-0e829a78560e', 3, 'III', 'Jubiloso. Vivace', 'Sinfonietta: III. Jubiloso. Vivace', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 1611 AND p.composer_id = 99
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:87d45328-b128-4d65-bbfb-0e829a78560e'
);


-- None 가곡 <Soledad>

UPDATE pieces piece
SET piece.title = '가곡 <Soledad>', piece.title_en = 'Soledad',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 653 AND piece.composer_id = 99
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Solo

UPDATE pieces piece
SET piece.title = 'Solo', piece.title_en = 'Solo',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 2323 AND piece.composer_id = 99
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- Op. 7 소나타 1번

UPDATE pieces piece
SET piece.title = '소나타 1번', piece.title_en = 'Sonata no. 1, op. 7',
    piece.type = 'album', piece.opus_number = 'Op. 7',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 1803 AND piece.composer_id = 99
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'Presto', part.name_en = 'Sonata no. 1, op. 7: I. Presto',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 1803 AND p.composer_id = 99 AND part.part_key = 'musicbrainz:581df3d4-f752-4bdd-a34c-38b29c175947' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:581df3d4-f752-4bdd-a34c-38b29c175947', 1, 'I', 'Presto', 'Sonata no. 1, op. 7: I. Presto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 1803 AND p.composer_id = 99
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:581df3d4-f752-4bdd-a34c-38b29c175947'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'Coral con variaciones', part.name_en = 'Sonata no. 1, op. 7: II. Coral con variaciones',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 1803 AND p.composer_id = 99 AND part.part_key = 'musicbrainz:0387c1c9-e163-4a87-8541-001da944e81c' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:0387c1c9-e163-4a87-8541-001da944e81c', 2, 'II', 'Coral con variaciones', 'Sonata no. 1, op. 7: II. Coral con variaciones', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 1803 AND p.composer_id = 99
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:0387c1c9-e163-4a87-8541-001da944e81c'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = 'Rondo', part.name_en = 'Sonata no. 1, op. 7: III. Rondo',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 1803 AND p.composer_id = 99 AND part.part_key = 'musicbrainz:c0a15937-7d30-45a7-b754-87a6b1423e01' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:c0a15937-7d30-45a7-b754-87a6b1423e01', 3, 'III', 'Rondo', 'Sonata no. 1, op. 7: III. Rondo', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 1803 AND p.composer_id = 99
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:c0a15937-7d30-45a7-b754-87a6b1423e01'
);


-- None 가곡 <Street Tango>

UPDATE pieces piece
SET piece.title = '가곡 <Street Tango>', piece.title_en = 'Street Tango',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 1474 AND piece.composer_id = 99
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Suite Punta del Este

UPDATE pieces piece
SET piece.title = 'Suite Punta del Este', piece.title_en = 'Suite Punta del Este',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 1609 AND piece.composer_id = 99
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'III',
    part.name_ko = 'Fuga. Allegro vivace', part.name_en = 'Suite Punta del Este: III. Fuga. Allegro vivace',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 1609 AND p.composer_id = 99 AND part.part_key = 'musicbrainz:38e89b72-a8eb-425f-b7c1-1918eb70a184' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:38e89b72-a8eb-425f-b7c1-1918eb70a184', 1, 'III', 'Fuga. Allegro vivace', 'Suite Punta del Este: III. Fuga. Allegro vivace', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 1609 AND p.composer_id = 99
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:38e89b72-a8eb-425f-b7c1-1918eb70a184'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'I',
    part.name_ko = 'Introducción. Allegro pesante', part.name_en = 'Suite Punta del Este: I. Introducción. Allegro pesante',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 1609 AND p.composer_id = 99 AND part.part_key = 'musicbrainz:9e341f47-b6fb-445e-9a75-cb8efda2eab7' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:9e341f47-b6fb-445e-9a75-cb8efda2eab7', 2, 'I', 'Introducción. Allegro pesante', 'Suite Punta del Este: I. Introducción. Allegro pesante', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 1609 AND p.composer_id = 99
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:9e341f47-b6fb-445e-9a75-cb8efda2eab7'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'II',
    part.name_ko = 'Coral. Adagio', part.name_en = 'Suite Punta del Este: II. Coral. Adagio',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 1609 AND p.composer_id = 99 AND part.part_key = 'musicbrainz:a821d762-38b4-43c2-bd00-8454e04414de' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:a821d762-38b4-43c2-bd00-8454e04414de', 3, 'II', 'Coral. Adagio', 'Suite Punta del Este: II. Coral. Adagio', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 1609 AND p.composer_id = 99
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:a821d762-38b4-43c2-bd00-8454e04414de'
);


-- None Suite Troileana

UPDATE pieces piece
SET piece.title = 'Suite Troileana', piece.title_en = 'Suite Troileana',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 2252 AND piece.composer_id = 99
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'Bandoneón', part.name_en = 'Suite Troileana: Bandoneón',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 2252 AND p.composer_id = 99 AND part.part_key = 'musicbrainz:04a735a1-c064-433c-94ec-a0506683a935' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:04a735a1-c064-433c-94ec-a0506683a935', 1, NULL, 'Bandoneón', 'Suite Troileana: Bandoneón', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 2252 AND p.composer_id = 99
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:04a735a1-c064-433c-94ec-a0506683a935'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'Zita', part.name_en = 'Suite Troileana: Zita',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 2252 AND p.composer_id = 99 AND part.part_key = 'musicbrainz:53c90618-1c2e-48e5-9c50-ba28d7977a44' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:53c90618-1c2e-48e5-9c50-ba28d7977a44', 2, NULL, 'Zita', 'Suite Troileana: Zita', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 2252 AND p.composer_id = 99
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:53c90618-1c2e-48e5-9c50-ba28d7977a44'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = NULL,
    part.name_ko = 'Whisky', part.name_en = 'Suite Troileana: Whisky',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 2252 AND p.composer_id = 99 AND part.part_key = 'musicbrainz:414edf5b-04d7-41b0-8464-85dd90496416' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:414edf5b-04d7-41b0-8464-85dd90496416', 3, NULL, 'Whisky', 'Suite Troileana: Whisky', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 2252 AND p.composer_id = 99
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:414edf5b-04d7-41b0-8464-85dd90496416'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = NULL,
    part.name_ko = 'Escolaso', part.name_en = 'Suite Troileana: Escolaso',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 2252 AND p.composer_id = 99 AND part.part_key = 'musicbrainz:b8227999-ff8c-478d-bd8f-ce9e2362d291' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:b8227999-ff8c-478d-bd8f-ce9e2362d291', 4, NULL, 'Escolaso', 'Suite Troileana: Escolaso', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 2252 AND p.composer_id = 99
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:b8227999-ff8c-478d-bd8f-ce9e2362d291'
);


-- None Suite lumière

UPDATE pieces piece
SET piece.title = 'Suite lumière', piece.title_en = 'Suite lumière',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 1054 AND piece.composer_id = 99
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'Solitude', part.name_en = 'Suite lumière: 1. Solitude',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 1054 AND p.composer_id = 99 AND part.part_key = 'musicbrainz:5eff5702-7375-4986-9ada-3a4b36d7a08d' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:5eff5702-7375-4986-9ada-3a4b36d7a08d', 1, NULL, 'Solitude', 'Suite lumière: 1. Solitude', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 1054 AND p.composer_id = 99
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:5eff5702-7375-4986-9ada-3a4b36d7a08d'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'L’Amour', part.name_en = 'Suite lumière: 3. L’Amour',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 1054 AND p.composer_id = 99 AND part.part_key = 'musicbrainz:8efefb77-42d9-470a-aa3a-210abd9a0d0c' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:8efefb77-42d9-470a-aa3a-210abd9a0d0c', 2, NULL, 'L’Amour', 'Suite lumière: 3. L’Amour', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 1054 AND p.composer_id = 99
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:8efefb77-42d9-470a-aa3a-210abd9a0d0c'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = NULL,
    part.name_ko = 'L’Évasion', part.name_en = 'Suite lumière: 4. L’Évasion',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 1054 AND p.composer_id = 99 AND part.part_key = 'musicbrainz:d2cf8ed7-bc77-4953-9680-4fa69020ae2a' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:d2cf8ed7-bc77-4953-9680-4fa69020ae2a', 3, NULL, 'L’Évasion', 'Suite lumière: 4. L’Évasion', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 1054 AND p.composer_id = 99
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:d2cf8ed7-bc77-4953-9680-4fa69020ae2a'
);


-- None 모음곡 2번

UPDATE pieces piece
SET piece.title = '모음곡 2번', piece.title_en = 'Suite no. 2',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 1696 AND piece.composer_id = 99
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'Nocturno', part.name_en = 'Suite no. 2: I. Nocturno',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 1696 AND p.composer_id = 99 AND part.part_key = 'musicbrainz:5acc1c17-f48e-4ed6-b445-a0f0f55b3cf9' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:5acc1c17-f48e-4ed6-b445-a0f0f55b3cf9', 1, 'I', 'Nocturno', 'Suite no. 2: I. Nocturno', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 1696 AND p.composer_id = 99
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:5acc1c17-f48e-4ed6-b445-a0f0f55b3cf9'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'Miniatura', part.name_en = 'Suite no. 2: II. Miniatura',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 1696 AND p.composer_id = 99 AND part.part_key = 'musicbrainz:4e90486d-6d8f-4105-a9b6-dcb16f03500d' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:4e90486d-6d8f-4105-a9b6-dcb16f03500d', 2, 'II', 'Miniatura', 'Suite no. 2: II. Miniatura', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 1696 AND p.composer_id = 99
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:4e90486d-6d8f-4105-a9b6-dcb16f03500d'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = 'Vals', part.name_en = 'Suite no. 2: III. Vals',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 1696 AND p.composer_id = 99 AND part.part_key = 'musicbrainz:e4cea8a8-3196-4991-99c6-1c8bac6e00e1' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:e4cea8a8-3196-4991-99c6-1c8bac6e00e1', 3, 'III', 'Vals', 'Suite no. 2: III. Vals', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 1696 AND p.composer_id = 99
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:e4cea8a8-3196-4991-99c6-1c8bac6e00e1'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = 'IV',
    part.name_ko = 'Danza criolla', part.name_en = 'Suite no. 2: IV. Danza criolla',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 1696 AND p.composer_id = 99 AND part.part_key = 'musicbrainz:93bcfed0-b154-455b-be00-e2e8f3ee0c0e' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:93bcfed0-b154-455b-be00-e2e8f3ee0c0e', 4, 'IV', 'Danza criolla', 'Suite no. 2: IV. Danza criolla', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 1696 AND p.composer_id = 99
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:93bcfed0-b154-455b-be00-e2e8f3ee0c0e'
);


-- Op. 2 모음곡

UPDATE pieces piece
SET piece.title = '모음곡', piece.title_en = 'Suite, op. 2',
    piece.type = 'album', piece.opus_number = 'Op. 2',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 1722 AND piece.composer_id = 99
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'Preludio', part.name_en = 'Suite, op. 2: I. Preludio',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 1722 AND p.composer_id = 99 AND part.part_key = 'musicbrainz:a3d9be21-e8da-4bf6-a21c-f45e5452d223' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:a3d9be21-e8da-4bf6-a21c-f45e5452d223', 1, 'I', 'Preludio', 'Suite, op. 2: I. Preludio', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 1722 AND p.composer_id = 99
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:a3d9be21-e8da-4bf6-a21c-f45e5452d223'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'Siciliana', part.name_en = 'Suite, op. 2: II. Siciliana',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 1722 AND p.composer_id = 99 AND part.part_key = 'musicbrainz:6c611c5c-4e3a-4f54-967a-b1d0bb6ae24c' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:6c611c5c-4e3a-4f54-967a-b1d0bb6ae24c', 2, 'II', 'Siciliana', 'Suite, op. 2: II. Siciliana', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 1722 AND p.composer_id = 99
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:6c611c5c-4e3a-4f54-967a-b1d0bb6ae24c'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = 'Toccata', part.name_en = 'Suite, op. 2: III. Toccata',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 1722 AND p.composer_id = 99 AND part.part_key = 'musicbrainz:89681ca4-53ac-4c95-bba4-e47b3e32b202' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:89681ca4-53ac-4c95-bba4-e47b3e32b202', 3, 'III', 'Toccata', 'Suite, op. 2: III. Toccata', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 1722 AND p.composer_id = 99
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:89681ca4-53ac-4c95-bba4-e47b3e32b202'
);


-- None 가곡 <Summit>

UPDATE pieces piece
SET piece.title = '가곡 <Summit>', piece.title_en = 'Summit',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 1080 AND piece.composer_id = 99
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Tangata (Silfo y Ondina)

UPDATE pieces piece
SET piece.title = 'Tangata (Silfo y Ondina)', piece.title_en = 'Tangata (Silfo y Ondina)',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 851 AND piece.composer_id = 99
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'Fugata', part.name_en = 'Tangata (Silfo y Ondina): Fugata',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 851 AND p.composer_id = 99 AND part.part_key = 'musicbrainz:cb7464b4-96ca-40d0-b4ba-04d111721a0a' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:cb7464b4-96ca-40d0-b4ba-04d111721a0a', 1, NULL, 'Fugata', 'Tangata (Silfo y Ondina): Fugata', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 851 AND p.composer_id = 99
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:cb7464b4-96ca-40d0-b4ba-04d111721a0a'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'Soledad', part.name_en = 'Tangata (Silfo y Ondina): Soledad',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 851 AND p.composer_id = 99 AND part.part_key = 'musicbrainz:19e7b544-4b32-3543-bc9b-76d4ee33e03e' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:19e7b544-4b32-3543-bc9b-76d4ee33e03e', 2, NULL, 'Soledad', 'Tangata (Silfo y Ondina): Soledad', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 851 AND p.composer_id = 99
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:19e7b544-4b32-3543-bc9b-76d4ee33e03e'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = NULL,
    part.name_ko = 'Final', part.name_en = 'Tangata (Silfo y Ondina): Final',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 851 AND p.composer_id = 99 AND part.part_key = 'musicbrainz:5f4ba895-10e3-4bec-87b9-6610044cb222' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:5f4ba895-10e3-4bec-87b9-6610044cb222', 3, NULL, 'Final', 'Tangata (Silfo y Ondina): Final', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 851 AND p.composer_id = 99
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:5f4ba895-10e3-4bec-87b9-6610044cb222'
);


-- None Tangazo

UPDATE pieces piece
SET piece.title = 'Tangazo', piece.title_en = 'Tangazo',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 2126 AND piece.composer_id = 99
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Tango Fever (Penalty)

UPDATE pieces piece
SET piece.title = 'Tango Fever (Penalty)', piece.title_en = 'Tango Fever (Penalty)',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 1658 AND piece.composer_id = 99
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Tango Suite

UPDATE pieces piece
SET piece.title = 'Tango Suite', piece.title_en = 'Tango Suite',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 2065 AND piece.composer_id = 99
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'Allegro', part.name_en = 'Tango Suite: I. Allegro',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 2065 AND p.composer_id = 99 AND part.part_key = 'musicbrainz:b29e66d3-7a67-391b-bccd-7b28740cc574' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:b29e66d3-7a67-391b-bccd-7b28740cc574', 1, 'I', 'Allegro', 'Tango Suite: I. Allegro', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 2065 AND p.composer_id = 99
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:b29e66d3-7a67-391b-bccd-7b28740cc574'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'Andante', part.name_en = 'Tango Suite: II. Andante',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 2065 AND p.composer_id = 99 AND part.part_key = 'musicbrainz:1d492bf9-c9ac-3144-b450-2ecd6a8dd80f' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:1d492bf9-c9ac-3144-b450-2ecd6a8dd80f', 2, 'II', 'Andante', 'Tango Suite: II. Andante', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 2065 AND p.composer_id = 99
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:1d492bf9-c9ac-3144-b450-2ecd6a8dd80f'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = 'Allegro', part.name_en = 'Tango Suite: III. Allegro',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 2065 AND p.composer_id = 99 AND part.part_key = 'musicbrainz:7dcafc89-b650-3f4c-81bf-8ffcabec257e' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:7dcafc89-b650-3f4c-81bf-8ffcabec257e', 3, 'III', 'Allegro', 'Tango Suite: III. Allegro', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 2065 AND p.composer_id = 99
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:7dcafc89-b650-3f4c-81bf-8ffcabec257e'
);


-- None Tango blues (Campeon)

UPDATE pieces piece
SET piece.title = 'Tango blues (Campeon)', piece.title_en = 'Tango blues (Campeon)',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 2372 AND piece.composer_id = 99
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None 가곡 <Tango del Diablo>

UPDATE pieces piece
SET piece.title = '가곡 <Tango del Diablo>', piece.title_en = 'Tango del Diablo',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 1034 AND piece.composer_id = 99
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Tango del ángel

UPDATE pieces piece
SET piece.title = 'Tango del ángel', piece.title_en = 'Tango del ángel',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 2288 AND piece.composer_id = 99
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None 탱고 1번

UPDATE pieces piece
SET piece.title = '탱고 1번', piece.title_en = 'Tango no. 1 para orquesta de cuerda',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 1616 AND piece.composer_id = 99
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None 탱고 2번

UPDATE pieces piece
SET piece.title = '탱고 2번', piece.title_en = 'Tango no. 2 para orquesta de cuerda',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 1733 AND piece.composer_id = 99
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Tango para una ciudad, Parte 1

UPDATE pieces piece
SET piece.title = 'Tango para una ciudad, Parte 1', piece.title_en = 'Tango para una ciudad, Parte 1',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 568 AND piece.composer_id = 99
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Tango para una ciudad, Parte 2

UPDATE pieces piece
SET piece.title = 'Tango para una ciudad, Parte 2', piece.title_en = 'Tango para una ciudad, Parte 2',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 526 AND piece.composer_id = 99
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Tango seis

UPDATE pieces piece
SET piece.title = 'Tango seis', piece.title_en = 'Tango seis',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 2747 AND piece.composer_id = 99
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None 가곡 <Tanguedia I>

UPDATE pieces piece
SET piece.title = '가곡 <Tanguedia I>', piece.title_en = 'Tanguedia I',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 2619 AND piece.composer_id = 99
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None 가곡 <Tanguedia II>

UPDATE pieces piece
SET piece.title = '가곡 <Tanguedia II>', piece.title_en = 'Tanguedia II',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 2923 AND piece.composer_id = 99
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None 가곡 <Tanguedia Ⅲ>

UPDATE pieces piece
SET piece.title = '가곡 <Tanguedia Ⅲ>', piece.title_en = 'Tanguedia Ⅲ',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 2038 AND piece.composer_id = 99
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Tangueria 1

UPDATE pieces piece
SET piece.title = 'Tangueria 1', piece.title_en = 'Tangueria 1',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 2068 AND piece.composer_id = 99
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Tardecita pampeana

UPDATE pieces piece
SET piece.title = 'Tardecita pampeana', piece.title_en = 'Tardecita pampeana',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 2855 AND piece.composer_id = 99
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Tema di Grazia

UPDATE pieces piece
SET piece.title = 'Tema di Grazia', piece.title_en = 'Tema di Grazia',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 2105 AND piece.composer_id = 99
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Thriller (Mundial 78)

UPDATE pieces piece
SET piece.title = 'Thriller (Mundial 78)', piece.title_en = 'Thriller (Mundial 78)',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 1923 AND piece.composer_id = 99
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Tout va bien

UPDATE pieces piece
SET piece.title = 'Tout va bien', piece.title_en = 'Tout va bien',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 2696 AND piece.composer_id = 99
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Tres minutos con la realidad

UPDATE pieces piece
SET piece.title = 'Tres minutos con la realidad', piece.title_en = 'Tres minutos con la realidad',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 1361 AND piece.composer_id = 99
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Tres movimientos tanguísticos porteños

UPDATE pieces piece
SET piece.title = 'Tres movimientos tanguísticos porteños', piece.title_en = 'Tres movimientos tanguísticos porteños',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 2164 AND piece.composer_id = 99
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'Allegro', part.name_en = 'Tres movimientos tanguísticos porteños: I. Allegro',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 2164 AND p.composer_id = 99 AND part.part_key = 'musicbrainz:a6e0a531-d269-42f4-b217-08a4dd9d360b' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:a6e0a531-d269-42f4-b217-08a4dd9d360b', 1, 'I', 'Allegro', 'Tres movimientos tanguísticos porteños: I. Allegro', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 2164 AND p.composer_id = 99
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:a6e0a531-d269-42f4-b217-08a4dd9d360b'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'Moderato', part.name_en = 'Tres movimientos tanguísticos porteños: II. Moderato',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 2164 AND p.composer_id = 99 AND part.part_key = 'musicbrainz:7e6aaf21-47c6-4941-ac2b-70f17112d2b1' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:7e6aaf21-47c6-4941-ac2b-70f17112d2b1', 2, 'II', 'Moderato', 'Tres movimientos tanguísticos porteños: II. Moderato', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 2164 AND p.composer_id = 99
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:7e6aaf21-47c6-4941-ac2b-70f17112d2b1'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = 'Vivace', part.name_en = 'Tres movimientos tanguísticos porteños: III. Vivace',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 2164 AND p.composer_id = 99 AND part.part_key = 'musicbrainz:092730dd-aa93-4d64-9a92-4497b83ca8ff' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:092730dd-aa93-4d64-9a92-4497b83ca8ff', 3, 'III', 'Vivace', 'Tres movimientos tanguísticos porteños: III. Vivace', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 2164 AND p.composer_id = 99
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:092730dd-aa93-4d64-9a92-4497b83ca8ff'
);


-- None Tres piezas breves

UPDATE pieces piece
SET piece.title = 'Tres piezas breves', piece.title_en = 'Tres piezas breves',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 2547 AND piece.composer_id = 99
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'Pastoral', part.name_en = 'Tres piezas breves: I. Pastoral',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 2547 AND p.composer_id = 99 AND part.part_key = 'musicbrainz:3bc8c3d6-2047-4e8f-a8e9-bcadce8107c9' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:3bc8c3d6-2047-4e8f-a8e9-bcadce8107c9', 1, 'I', 'Pastoral', 'Tres piezas breves: I. Pastoral', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 2547 AND p.composer_id = 99
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:3bc8c3d6-2047-4e8f-a8e9-bcadce8107c9'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'Serenade', part.name_en = 'Tres piezas breves: II. Serenade',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 2547 AND p.composer_id = 99 AND part.part_key = 'musicbrainz:4df8a009-cebc-44ae-8d31-8657ed007040' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:4df8a009-cebc-44ae-8d31-8657ed007040', 2, 'II', 'Serenade', 'Tres piezas breves: II. Serenade', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 2547 AND p.composer_id = 99
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:4df8a009-cebc-44ae-8d31-8657ed007040'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = 'Siciliana', part.name_en = 'Tres piezas breves: III. Siciliana',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 2547 AND p.composer_id = 99 AND part.part_key = 'musicbrainz:3a3a852d-039e-42e1-bdbe-3c09196f8af8' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:3a3a852d-039e-42e1-bdbe-3c09196f8af8', 3, 'III', 'Siciliana', 'Tres piezas breves: III. Siciliana', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 2547 AND p.composer_id = 99
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:3a3a852d-039e-42e1-bdbe-3c09196f8af8'
);


-- None Tres tangos

UPDATE pieces piece
SET piece.title = 'Tres tangos', piece.title_en = 'Tres tangos',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 1266 AND piece.composer_id = 99
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'Tango I. Allegro tranquillo', part.name_en = 'Tres tangos: Tango I. Allegro tranquillo',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 1266 AND p.composer_id = 99 AND part.part_key = 'musicbrainz:3edf8501-fe16-4788-bbf1-3f500dc26c2a' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:3edf8501-fe16-4788-bbf1-3f500dc26c2a', 1, NULL, 'Tango I. Allegro tranquillo', 'Tres tangos: Tango I. Allegro tranquillo', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 1266 AND p.composer_id = 99
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:3edf8501-fe16-4788-bbf1-3f500dc26c2a'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'Tango II. Moderato mistico', part.name_en = 'Tres tangos: Tango II. Moderato mistico',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 1266 AND p.composer_id = 99 AND part.part_key = 'musicbrainz:3ad621f0-068b-4cf8-b32b-45a31e918ebf' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:3ad621f0-068b-4cf8-b32b-45a31e918ebf', 2, NULL, 'Tango II. Moderato mistico', 'Tres tangos: Tango II. Moderato mistico', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 1266 AND p.composer_id = 99
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:3ad621f0-068b-4cf8-b32b-45a31e918ebf'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = NULL,
    part.name_ko = 'Tango III. Allegretto molto marcato', part.name_en = 'Tres tangos: Tango III. Allegretto molto marcato',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 1266 AND p.composer_id = 99 AND part.part_key = 'musicbrainz:f80c8bc3-fe53-42d5-b89e-f97d26eaa19b' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:f80c8bc3-fe53-42d5-b89e-f97d26eaa19b', 3, NULL, 'Tango III. Allegretto molto marcato', 'Tres tangos: Tango III. Allegretto molto marcato', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 1266 AND p.composer_id = 99
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:f80c8bc3-fe53-42d5-b89e-f97d26eaa19b'
);


-- None Tristango

UPDATE pieces piece
SET piece.title = 'Tristango', piece.title_en = 'Tristango',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 2342 AND piece.composer_id = 99
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None 가곡 <Tristeza, separación>

UPDATE pieces piece
SET piece.title = '가곡 <Tristeza, separación>', piece.title_en = 'Tristeza, separación',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 1353 AND piece.composer_id = 99
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None 가곡 <Tristezas de un doble A>

UPDATE pieces piece
SET piece.title = '가곡 <Tristezas de un doble A>', piece.title_en = 'Tristezas de un doble A',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 809 AND piece.composer_id = 99
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Triunfal

UPDATE pieces piece
SET piece.title = 'Triunfal', piece.title_en = 'Triunfal',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 2988 AND piece.composer_id = 99
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Tzigane tango

UPDATE pieces piece
SET piece.title = 'Tzigane tango', piece.title_en = 'Tzigane tango',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 804 AND piece.composer_id = 99
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Un día de paz

UPDATE pieces piece
SET piece.title = 'Un día de paz', piece.title_en = 'Un día de paz',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 2419 AND piece.composer_id = 99
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Undertango

UPDATE pieces piece
SET piece.title = 'Undertango', piece.title_en = 'Undertango',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 1620 AND piece.composer_id = 99
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Uomo del Sud

UPDATE pieces piece
SET piece.title = 'Uomo del Sud', piece.title_en = 'Uomo del Sud',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 1323 AND piece.composer_id = 99
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Vardarito

UPDATE pieces piece
SET piece.title = 'Vardarito', piece.title_en = 'Vardarito',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 1356 AND piece.composer_id = 99
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Viaje de bodas

UPDATE pieces piece
SET piece.title = 'Viaje de bodas', piece.title_en = 'Viaje de bodas',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 1079 AND piece.composer_id = 99
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Vibraphonissimo

UPDATE pieces piece
SET piece.title = 'Vibraphonissimo', piece.title_en = 'Vibraphonissimo',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 972 AND piece.composer_id = 99
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Villeguita

UPDATE pieces piece
SET piece.title = 'Villeguita', piece.title_en = 'Villeguita',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 2296 AND piece.composer_id = 99
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None 가곡 <Vuelvo al sur>

UPDATE pieces piece
SET piece.title = '가곡 <Vuelvo al sur>', piece.title_en = 'Vuelvo al sur',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 715 AND piece.composer_id = 99
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Weidmann

UPDATE pieces piece
SET piece.title = 'Weidmann', piece.title_en = 'Weidmann',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 2652 AND piece.composer_id = 99
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Windy

UPDATE pieces piece
SET piece.title = 'Windy', piece.title_en = 'Windy',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 1549 AND piece.composer_id = 99
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None 가곡 <Zum>

UPDATE pieces piece
SET piece.title = '가곡 <Zum>', piece.title_en = 'Zum',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 2797 AND piece.composer_id = 99
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None 가곡 <Éxtasis>

UPDATE pieces piece
SET piece.title = '가곡 <Éxtasis>', piece.title_en = 'Éxtasis',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 2051 AND piece.composer_id = 99
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None 영화음악 <5º año nacional>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '영화음악 <5º año nacional>', '5º año nacional', 'album', NULL, NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 99
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '영화음악 <5º año nacional>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '8ab04d25-5e6b-41b3-8773-1a2ca9ecc239'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '8ab04d25-5e6b-41b3-8773-1a2ca9ecc239'
FROM pieces p
WHERE p.composer_id = 99 AND p.title = '영화음악 <5º año nacional>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '8ab04d25-5e6b-41b3-8773-1a2ca9ecc239'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:0741bcc2-afac-4290-9e23-e3cdbe0e7245', 1, NULL, 'El boletín', 'El boletín', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 99 AND p.title = '영화음악 <5º año nacional>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:0741bcc2-afac-4290-9e23-e3cdbe0e7245'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:2c9fa927-08a6-4ec5-80c8-cbfc0558a24c', 2, NULL, 'El goy', 'El goy', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 99 AND p.title = '영화음악 <5º año nacional>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:2c9fa927-08a6-4ec5-80c8-cbfc0558a24c'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:361de3e5-1002-4269-9991-99346cc00430', 3, NULL, '5º año nacional', '5º año nacional', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 99 AND p.title = '영화음악 <5º año nacional>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:361de3e5-1002-4269-9991-99346cc00430'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:4d54a45d-0936-4d83-b1e3-989a0c82ba53', 4, NULL, 'Aplazado', 'Aplazado', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 99 AND p.title = '영화음악 <5º año nacional>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:4d54a45d-0936-4d83-b1e3-989a0c82ba53'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:ad987f08-0cef-489e-88b6-b8b39346fd4b', 5, NULL, 'Fin de curso', 'Fin de curso', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 99 AND p.title = '영화음악 <5º año nacional>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:ad987f08-0cef-489e-88b6-b8b39346fd4b'
);


-- None Ave Maria

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, 'Ave Maria', 'Ave Maria', 'song', NULL, NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 99
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = 'Ave Maria'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '87757ae8-9f2f-4621-b082-87f3896aefbb'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '87757ae8-9f2f-4621-b082-87f3896aefbb'
FROM pieces p
WHERE p.composer_id = 99 AND p.title = 'Ave Maria' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '87757ae8-9f2f-4621-b082-87f3896aefbb'
);


-- None 가곡 <Buenos Aires>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '가곡 <Buenos Aires>', 'Buenos Aires', 'song', NULL, NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 99
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '가곡 <Buenos Aires>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '58da69dd-281b-432f-a3dc-ef7490bcadbe'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '58da69dd-281b-432f-a3dc-ef7490bcadbe'
FROM pieces p
WHERE p.composer_id = 99 AND p.title = '가곡 <Buenos Aires>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '58da69dd-281b-432f-a3dc-ef7490bcadbe'
);


-- None Chau París

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, 'Chau París', 'Chau París', 'song', NULL, NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 99
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = 'Chau París'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '68369477-5a0c-4597-a336-9eca0f9eafdc'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '68369477-5a0c-4597-a336-9eca0f9eafdc'
FROM pieces p
WHERE p.composer_id = 99 AND p.title = 'Chau París' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '68369477-5a0c-4597-a336-9eca0f9eafdc'
);


-- None 가곡 <El viaje>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '가곡 <El viaje>', 'El viaje', 'song', NULL, NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 99
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '가곡 <El viaje>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '61d5cd46-d1db-449c-8a36-8a4c43249ab3'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '61d5cd46-d1db-449c-8a36-8a4c43249ab3'
FROM pieces p
WHERE p.composer_id = 99 AND p.title = '가곡 <El viaje>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '61d5cd46-d1db-449c-8a36-8a4c43249ab3'
);


-- None 가곡 <Escualo>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '가곡 <Escualo>', 'Escualo', 'song', NULL, NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 99
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '가곡 <Escualo>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '24560487-2231-35cf-80ec-9f587c322fb8'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '24560487-2231-35cf-80ec-9f587c322fb8'
FROM pieces p
WHERE p.composer_id = 99 AND p.title = '가곡 <Escualo>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '24560487-2231-35cf-80ec-9f587c322fb8'
);


-- None Guardia nueva

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, 'Guardia nueva', 'Guardia nueva', 'song', NULL, NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 99
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = 'Guardia nueva'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'e5535d43-8358-46c8-864a-48cd412473ff'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'e5535d43-8358-46c8-864a-48cd412473ff'
FROM pieces p
WHERE p.composer_id = 99 AND p.title = 'Guardia nueva' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'e5535d43-8358-46c8-864a-48cd412473ff'
);


-- None Histoire du tango

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, 'Histoire du tango', 'Histoire du tango', 'album', NULL, NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 99
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = 'Histoire du tango'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '7b46292d-635a-402b-8bde-a8e183c497c6'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '7b46292d-635a-402b-8bde-a8e183c497c6'
FROM pieces p
WHERE p.composer_id = 99 AND p.title = 'Histoire du tango' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '7b46292d-635a-402b-8bde-a8e183c497c6'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:5913c4f1-aea1-35f3-96ba-8548f664bb9f', 1, 'I', 'Bordel 1900', 'Histoire du tango: I. Bordel 1900', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 99 AND p.title = 'Histoire du tango' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:5913c4f1-aea1-35f3-96ba-8548f664bb9f'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:8175c3c7-a70b-34c3-9f11-edbae7dc3a61', 2, 'II', 'Café 1930', 'Histoire du tango: II. Café 1930', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 99 AND p.title = 'Histoire du tango' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:8175c3c7-a70b-34c3-9f11-edbae7dc3a61'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:41e9a172-bdba-3b66-88b9-fc551f8bf0c1', 3, 'III', 'Night‐club 1960', 'Histoire du tango: III. Night‐club 1960', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 99 AND p.title = 'Histoire du tango' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:41e9a172-bdba-3b66-88b9-fc551f8bf0c1'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:8c81af80-2eb3-3cfa-9f6c-5cf73cdb2a21', 4, 'IV', 'Concert d’aujourd’hui', 'Histoire du tango: IV. Concert d’aujourd’hui', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 99 AND p.title = 'Histoire du tango' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:8c81af80-2eb3-3cfa-9f6c-5cf73cdb2a21'
);


-- None La misma pena

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, 'La misma pena', 'La misma pena', 'song', NULL, NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 99
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = 'La misma pena'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'd40214e2-6481-4127-b465-1789ddd9e935'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'd40214e2-6481-4127-b465-1789ddd9e935'
FROM pieces p
WHERE p.composer_id = 99 AND p.title = 'La misma pena' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'd40214e2-6481-4127-b465-1789ddd9e935'
);


-- None La muerte del ángel

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, 'La muerte del ángel', 'La muerte del ángel', 'song', NULL, NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 99
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = 'La muerte del ángel'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '48898169-cbb3-45b0-a46e-32546e00da68'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '48898169-cbb3-45b0-a46e-32546e00da68'
FROM pieces p
WHERE p.composer_id = 99 AND p.title = 'La muerte del ángel' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '48898169-cbb3-45b0-a46e-32546e00da68'
);


-- None La mufa

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, 'La mufa', 'La mufa', 'song', NULL, NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 99
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = 'La mufa'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '9b57c224-db81-4da5-9a1c-4dfc68af8356'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '9b57c224-db81-4da5-9a1c-4dfc68af8356'
FROM pieces p
WHERE p.composer_id = 99 AND p.title = 'La mufa' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '9b57c224-db81-4da5-9a1c-4dfc68af8356'
);


-- None 가곡 <La última grela>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '가곡 <La última grela>', 'La última grela', 'song', NULL, NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 99
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '가곡 <La última grela>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'a77df9bf-d5ef-4f40-aebb-fbc4d15d56cc'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'a77df9bf-d5ef-4f40-aebb-fbc4d15d56cc'
FROM pieces p
WHERE p.composer_id = 99 AND p.title = '가곡 <La última grela>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'a77df9bf-d5ef-4f40-aebb-fbc4d15d56cc'
);


-- None Le Grand Tango

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, 'Le Grand Tango', 'Le Grand Tango', 'song', NULL, NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 99
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = 'Le Grand Tango'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '978322e3-fe31-323b-b5db-d205cdc47316'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '978322e3-fe31-323b-b5db-d205cdc47316'
FROM pieces p
WHERE p.composer_id = 99 AND p.title = 'Le Grand Tango' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '978322e3-fe31-323b-b5db-d205cdc47316'
);


-- None 가곡 <Los pájaros perdidos>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '가곡 <Los pájaros perdidos>', 'Los pájaros perdidos', 'song', NULL, NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 99
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '가곡 <Los pájaros perdidos>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '67c5a9ba-d925-4d80-87a2-027df03d718c'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '67c5a9ba-d925-4d80-87a2-027df03d718c'
FROM pieces p
WHERE p.composer_id = 99 AND p.title = '가곡 <Los pájaros perdidos>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '67c5a9ba-d925-4d80-87a2-027df03d718c'
);


-- None Milonga del ángel

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, 'Milonga del ángel', 'Milonga del ángel', 'song', NULL, NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 99
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = 'Milonga del ángel'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'c51a45b9-f199-3ecb-aa79-dc8ea826ba7d'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'c51a45b9-f199-3ecb-aa79-dc8ea826ba7d'
FROM pieces p
WHERE p.composer_id = 99 AND p.title = 'Milonga del ángel' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'c51a45b9-f199-3ecb-aa79-dc8ea826ba7d'
);


-- None Milonga sin palabras

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, 'Milonga sin palabras', 'Milonga sin palabras', 'song', NULL, NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 99
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = 'Milonga sin palabras'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '9d8c227a-42f9-4ff8-b388-19b09ffb148b'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '9d8c227a-42f9-4ff8-b388-19b09ffb148b'
FROM pieces p
WHERE p.composer_id = 99 AND p.title = 'Milonga sin palabras' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '9d8c227a-42f9-4ff8-b388-19b09ffb148b'
);


-- None Muerte

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, 'Muerte', 'Muerte', 'song', NULL, NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 99
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = 'Muerte'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '7cad3230-3713-4372-9f75-c4100b5714fa'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '7cad3230-3713-4372-9f75-c4100b5714fa'
FROM pieces p
WHERE p.composer_id = 99 AND p.title = 'Muerte' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '7cad3230-3713-4372-9f75-c4100b5714fa'
);


-- None Picasso

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, 'Picasso', 'Picasso', 'song', NULL, NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 99
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = 'Picasso'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '609383fa-c19e-4db0-a010-bc236560f426'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '609383fa-c19e-4db0-a010-bc236560f426'
FROM pieces p
WHERE p.composer_id = 99 AND p.title = 'Picasso' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '609383fa-c19e-4db0-a010-bc236560f426'
);


-- None 가곡 <Pigmalión>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '가곡 <Pigmalión>', 'Pigmalión', 'song', NULL, NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 99
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '가곡 <Pigmalión>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '15bf7afe-5597-4a33-a72d-baa876e37024'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '15bf7afe-5597-4a33-a72d-baa876e37024'
FROM pieces p
WHERE p.composer_id = 99 AND p.title = '가곡 <Pigmalión>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '15bf7afe-5597-4a33-a72d-baa876e37024'
);


-- None Regreso al amor

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, 'Regreso al amor', 'Regreso al amor', 'song', NULL, NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 99
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = 'Regreso al amor'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'cfb63822-66c9-3452-b000-279bb7c1ef3e'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'cfb63822-66c9-3452-b000-279bb7c1ef3e'
FROM pieces p
WHERE p.composer_id = 99 AND p.title = 'Regreso al amor' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'cfb63822-66c9-3452-b000-279bb7c1ef3e'
);


-- None Retrato de Alfredo Gobbi

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, 'Retrato de Alfredo Gobbi', 'Retrato de Alfredo Gobbi', 'song', NULL, NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 99
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = 'Retrato de Alfredo Gobbi'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '9bd1f34f-59d9-43e8-aed2-68bc4dea3c12'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '9bd1f34f-59d9-43e8-aed2-68bc4dea3c12'
FROM pieces p
WHERE p.composer_id = 99 AND p.title = 'Retrato de Alfredo Gobbi' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '9bd1f34f-59d9-43e8-aed2-68bc4dea3c12'
);


-- None Sens unique

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, 'Sens unique', 'Sens unique', 'song', NULL, NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 99
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = 'Sens unique'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '5f8ba74e-a6f2-4ce8-b74f-cd71cced9249'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '5f8ba74e-a6f2-4ce8-b74f-cd71cced9249'
FROM pieces p
WHERE p.composer_id = 99 AND p.title = 'Sens unique' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '5f8ba74e-a6f2-4ce8-b74f-cd71cced9249'
);


-- None 탱고

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '탱고', 'Tango', 'song', NULL, NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 99
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '탱고'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '381ebe4e-f48e-469c-8330-070aced2a121'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '381ebe4e-f48e-469c-8330-070aced2a121'
FROM pieces p
WHERE p.composer_id = 99 AND p.title = '탱고' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '381ebe4e-f48e-469c-8330-070aced2a121'
);


-- None Tango ballet

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, 'Tango ballet', 'Tango ballet', 'album', NULL, NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 99
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = 'Tango ballet'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'f6ed5151-f058-47b2-9315-07660334ebca'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'f6ed5151-f058-47b2-9315-07660334ebca'
FROM pieces p
WHERE p.composer_id = 99 AND p.title = 'Tango ballet' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'f6ed5151-f058-47b2-9315-07660334ebca'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:e8652581-99e8-461f-a2ae-a6bfb1b7f76f', 1, 'I', 'Títulos', 'Tango ballet: I. Títulos', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 99 AND p.title = 'Tango ballet' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:e8652581-99e8-461f-a2ae-a6bfb1b7f76f'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:22955084-107b-4167-9fde-1cea3e6e98a2', 2, 'II', 'La calle', 'Tango ballet: II. La calle', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 99 AND p.title = 'Tango ballet' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:22955084-107b-4167-9fde-1cea3e6e98a2'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:5fb353d1-674a-406d-a64a-d638e3e9d9ce', 3, 'III', 'Encuentro–Olvido', 'Tango ballet: III. Encuentro–Olvido', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 99 AND p.title = 'Tango ballet' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:5fb353d1-674a-406d-a64a-d638e3e9d9ce'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:e73c8a7e-a27c-4a0f-929e-a9f8cf46ec2e', 4, 'IV', 'Cabaret', 'Tango ballet: IV. Cabaret', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 99 AND p.title = 'Tango ballet' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:e73c8a7e-a27c-4a0f-929e-a9f8cf46ec2e'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:f24db07a-ca13-47d2-8c87-296495af83c8', 5, 'V', 'Soledad', 'Tango ballet: V. Soledad', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 99 AND p.title = 'Tango ballet' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:f24db07a-ca13-47d2-8c87-296495af83c8'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:2eb0b7e9-1bb9-4441-8466-e7b5443bebb0', 6, 'VI', 'La calle', 'Tango ballet: VI. La calle', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 99 AND p.title = 'Tango ballet' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:2eb0b7e9-1bb9-4441-8466-e7b5443bebb0'
);


-- None Tango Études

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, 'Tango Études', 'Tango Études', 'album', NULL, NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 99
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = 'Tango Études'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'e00a19bb-e880-4a71-b2ed-b3d2c2bfb3ac'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'e00a19bb-e880-4a71-b2ed-b3d2c2bfb3ac'
FROM pieces p
WHERE p.composer_id = 99 AND p.title = 'Tango Études' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'e00a19bb-e880-4a71-b2ed-b3d2c2bfb3ac'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:3a6c8a26-97c2-4141-b0c0-2c8c94b57562', 1, NULL, 'Étude no. 1', 'Tango Études: Étude no. 1', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 99 AND p.title = 'Tango Études' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:3a6c8a26-97c2-4141-b0c0-2c8c94b57562'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:3c4be873-4b46-49d6-87c0-b84bea392944', 2, NULL, 'Étude no. 2', 'Tango Études: Étude no. 2', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 99 AND p.title = 'Tango Études' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:3c4be873-4b46-49d6-87c0-b84bea392944'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:b5e0f00a-42f7-419f-9289-2b340e3622df', 3, NULL, 'Étude no. 3', 'Tango Études: Étude no. 3', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 99 AND p.title = 'Tango Études' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:b5e0f00a-42f7-419f-9289-2b340e3622df'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:1f890bf1-fc3e-4873-b07c-ed5b12610b72', 4, NULL, 'Étude no. 4', 'Tango Études: Étude no. 4', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 99 AND p.title = 'Tango Études' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:1f890bf1-fc3e-4873-b07c-ed5b12610b72'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:98fe3d3c-fb70-4b01-8d2c-bffb8610993c', 5, NULL, 'Étude no. 5', 'Tango Études: Étude no. 5', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 99 AND p.title = 'Tango Études' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:98fe3d3c-fb70-4b01-8d2c-bffb8610993c'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:ca7150a9-a2a9-4f10-8cee-e176d71f2d8f', 6, NULL, 'Étude no. 6', 'Tango Études: Étude no. 6', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 99 AND p.title = 'Tango Études' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:ca7150a9-a2a9-4f10-8cee-e176d71f2d8f'
);


-- None 가곡 <Tanti anni prima>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '가곡 <Tanti anni prima>', 'Tanti anni prima', 'song', NULL, NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 99
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '가곡 <Tanti anni prima>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'f5288e77-48a3-39e0-b72e-ece1d0c834ae'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'f5288e77-48a3-39e0-b72e-ece1d0c834ae'
FROM pieces p
WHERE p.composer_id = 99 AND p.title = '가곡 <Tanti anni prima>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'f5288e77-48a3-39e0-b72e-ece1d0c834ae'
);


-- None Vayamos al diablo

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, 'Vayamos al diablo', 'Vayamos al diablo', 'song', NULL, NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 99
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = 'Vayamos al diablo'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'dc58c9bf-5ae8-3593-b249-62c25e44068b'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'dc58c9bf-5ae8-3593-b249-62c25e44068b'
FROM pieces p
WHERE p.composer_id = 99 AND p.title = 'Vayamos al diablo' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'dc58c9bf-5ae8-3593-b249-62c25e44068b'
);


-- None Violentango

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, 'Violentango', 'Violentango', 'song', NULL, NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 99
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = 'Violentango'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '8fbcf4d4-fcb4-42ac-8745-83f953cec9e9'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '8fbcf4d4-fcb4-42ac-8745-83f953cec9e9'
FROM pieces p
WHERE p.composer_id = 99 AND p.title = 'Violentango' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '8fbcf4d4-fcb4-42ac-8745-83f953cec9e9'
);


-- None 가곡 <Years of Solitude>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '가곡 <Years of Solitude>', 'Years of Solitude', 'song', NULL, NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 99
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '가곡 <Years of Solitude>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '5ea29080-5c93-471d-8bba-14e300a54d7e'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '5ea29080-5c93-471d-8bba-14e300a54d7e'
FROM pieces p
WHERE p.composer_id = 99 AND p.title = '가곡 <Years of Solitude>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '5ea29080-5c93-471d-8bba-14e300a54d7e'
);


-- 카탈로그에 대응이 없는 seed 작품 24개를 목록에서 숨긴다(지우지 않음).
UPDATE pieces piece
SET piece.hidden_reason = 'catalog_unmatched'
WHERE piece.composer_id = 99 AND piece.origin = 'seed' AND piece.hidden_reason IS NULL
  AND piece.id IN (
    772, 834, 904, 965, 1240, 1442, 1662, 1818, 1821, 1834, 1899, 2025, 2069, 2102, 2375, 2459, 2482, 2504, 2534, 2537,
    2598, 2706, 2924, 3017
  )
  AND NOT EXISTS (SELECT 1 FROM performance_sectors sector WHERE sector.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM piece_parts linking WHERE linking.linked_piece_id = piece.id);
