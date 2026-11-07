-- Antonio de Cabezahueca 작품을 MusicBrainz 작품 구조로 다시 짠다(5차 자동). 작품 43개(묶음 2, 다악장 0, 낱곡 41),
-- 새 작품 1개, part 52개, 그 아래 0개.
-- seed 55개 중 42개를 작품·part 에 잇고, 3개를 숨기고, 10개는 그대로 둔다.
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

-- None Ancol que col partire

UPDATE pieces piece
SET piece.title = 'Ancol que col partire', piece.title_en = 'Ancol que col partire',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 19850 AND piece.composer_id = 298
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Au joli bois

UPDATE pieces piece
SET piece.title = 'Au joli bois', piece.title_en = 'Au joli bois',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 16905 AND piece.composer_id = 298
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Benedictus (Intabulation of Josquin de Prez)

UPDATE pieces piece
SET piece.title = 'Benedictus (Intabulation of Josquin de Prez)', piece.title_en = 'Benedictus (Intabulation of Josquin de Prez)',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 18793 AND piece.composer_id = 298
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Canción glosada “Triste départ”

UPDATE pieces piece
SET piece.title = 'Canción glosada “Triste départ”', piece.title_en = 'Canción glosada “Triste départ”',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 17617 AND piece.composer_id = 298
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None D'où vient cela

UPDATE pieces piece
SET piece.title = 'D''où vient cela', piece.title_en = 'D''où vient cela',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 19122 AND piece.composer_id = 298
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Dic nobis, Maria

UPDATE pieces piece
SET piece.title = 'Dic nobis, Maria', piece.title_en = 'Dic nobis, Maria',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 18854 AND piece.composer_id = 298
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Diferencias sobre "Belle qui tiens ma vie"

UPDATE pieces piece
SET piece.title = 'Diferencias sobre "Belle qui tiens ma vie"', piece.title_en = 'Diferencias sobre "Belle qui tiens ma vie"',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 18406 AND piece.composer_id = 298
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Diferencias sobre El Canto del Caballero

UPDATE pieces piece
SET piece.title = 'Diferencias sobre El Canto del Caballero', piece.title_en = 'Diferencias sobre El Canto del Caballero',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 15757 AND piece.composer_id = 298
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Diferencias sobre, "Guadarme las vacas"

UPDATE pieces piece
SET piece.title = 'Diferencias sobre, "Guadarme las vacas"', piece.title_en = 'Diferencias sobre, "Guadarme las vacas"',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 16987 AND piece.composer_id = 298
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Du vien sela

UPDATE pieces piece
SET piece.title = 'Du vien sela', piece.title_en = 'Du vien sela',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 16860 AND piece.composer_id = 298
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Duuiensela

UPDATE pieces piece
SET piece.title = 'Duuiensela', piece.title_en = 'Duuiensela',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 19081 AND piece.composer_id = 298
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Fabordon y Glosas del octavo tono

UPDATE pieces piece
SET piece.title = 'Fabordon y Glosas del octavo tono', piece.title_en = 'Fabordon y Glosas del octavo tono',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 19046 AND piece.composer_id = 298
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Fabordon y glosas del Primer Tono Ilano

UPDATE pieces piece
SET piece.title = 'Fabordon y glosas del Primer Tono Ilano', piece.title_en = 'Fabordon y glosas del Primer Tono Ilano',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 16595 AND piece.composer_id = 298
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Fabordones del premier tono Ilano

UPDATE pieces piece
SET piece.title = 'Fabordones del premier tono Ilano', piece.title_en = 'Fabordones del premier tono Ilano',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 19305 AND piece.composer_id = 298
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Fabordón y glosas del sexto tono

UPDATE pieces piece
SET piece.title = 'Fabordón y glosas del sexto tono', piece.title_en = 'Fabordón y glosas del sexto tono',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 16156 AND piece.composer_id = 298
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Fantasia I

UPDATE pieces piece
SET piece.title = 'Fantasia I', piece.title_en = 'Fantasia I',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 16304 AND piece.composer_id = 298
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Himno XVI

UPDATE pieces piece
SET piece.title = 'Himno XVI', piece.title_en = 'Himno XVI',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 19602 AND piece.composer_id = 298
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Himno “Christe Redemptor omnium”

UPDATE pieces piece
SET piece.title = 'Himno “Christe Redemptor omnium”', piece.title_en = 'Himno “Christe Redemptor omnium”',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 16876 AND piece.composer_id = 298
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Hosanna (Intabulation of Josquin de Prez)

UPDATE pieces piece
SET piece.title = 'Hosanna (Intabulation of Josquin de Prez)', piece.title_en = 'Hosanna (Intabulation of Josquin de Prez)',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 16118 AND piece.composer_id = 298
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Je prens en gre, Cancion glosada

UPDATE pieces piece
SET piece.title = 'Je prens en gre, Cancion glosada', piece.title_en = 'Je prens en gre, Cancion glosada',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 19653 AND piece.composer_id = 298
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Obras de musica para tecla, arpa y vihuela

UPDATE pieces piece
SET piece.title = 'Obras de musica para tecla, arpa y vihuela', piece.title_en = 'Obras de musica para tecla, arpa y vihuela',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 18749 AND piece.composer_id = 298
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'Tres duos para principiantes para mostrar a llevar el compas', part.name_en = 'Obras de música: Tres duos para principiantes para mostrar a llevar el compas',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 18749 AND p.composer_id = 298 AND part.part_key = 'musicbrainz:caedb600-cc04-40ce-99e4-a2867fcc373e' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:caedb600-cc04-40ce-99e4-a2867fcc373e', 1, NULL, 'Tres duos para principiantes para mostrar a llevar el compas', 'Obras de música: Tres duos para principiantes para mostrar a llevar el compas', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 18749 AND p.composer_id = 298
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:caedb600-cc04-40ce-99e4-a2867fcc373e'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'Dos Ave maris stellas. Lleva el canto Ilano el contrabajo', part.name_en = 'Obras de música: Dos Ave maris stellas. Lleva el canto Ilano el contrabajo',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 18749 AND p.composer_id = 298 AND part.part_key = 'musicbrainz:71c0bc94-7dac-4957-bf5e-41ff3d1149ee' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:71c0bc94-7dac-4957-bf5e-41ff3d1149ee', 2, NULL, 'Dos Ave maris stellas. Lleva el canto Ilano el contrabajo', 'Obras de música: Dos Ave maris stellas. Lleva el canto Ilano el contrabajo', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 18749 AND p.composer_id = 298
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:71c0bc94-7dac-4957-bf5e-41ff3d1149ee'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = NULL,
    part.name_ko = 'Te lucis ante terminum. Lleva el canto Ilano el tenor', part.name_en = 'Obras de música: Te lucis ante terminum. Lleva el canto Ilano el tenor',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 18749 AND p.composer_id = 298 AND part.part_key = 'musicbrainz:35e3fd04-8653-40fc-a149-83955b456336' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:35e3fd04-8653-40fc-a149-83955b456336', 3, NULL, 'Te lucis ante terminum. Lleva el canto Ilano el tenor', 'Obras de música: Te lucis ante terminum. Lleva el canto Ilano el tenor', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 18749 AND p.composer_id = 298
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:35e3fd04-8653-40fc-a149-83955b456336'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = NULL,
    part.name_ko = 'Versos de Magnificat: Siete versos del primer tono', part.name_en = 'Obras de música: Versos de Magnificat: Siete versos del primer tono',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 18749 AND p.composer_id = 298 AND part.part_key = 'musicbrainz:9e1ce25e-d1ce-4700-9be1-e92499df0328' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:9e1ce25e-d1ce-4700-9be1-e92499df0328', 4, NULL, 'Versos de Magnificat: Siete versos del primer tono', 'Obras de música: Versos de Magnificat: Siete versos del primer tono', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 18749 AND p.composer_id = 298
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:9e1ce25e-d1ce-4700-9be1-e92499df0328'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 5, part.movement_number = NULL,
    part.name_ko = 'Versos de Magnificat: Seys versos del segundo tono', part.name_en = 'Obras de música: Versos de Magnificat: Seys versos del segundo tono',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 18749 AND p.composer_id = 298 AND part.part_key = 'musicbrainz:da42bdde-5fb3-4768-a518-99c228f5de40' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:da42bdde-5fb3-4768-a518-99c228f5de40', 5, NULL, 'Versos de Magnificat: Seys versos del segundo tono', 'Obras de música: Versos de Magnificat: Seys versos del segundo tono', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 18749 AND p.composer_id = 298
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:da42bdde-5fb3-4768-a518-99c228f5de40'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 6, part.movement_number = NULL,
    part.name_ko = 'Versos de Magnificat: Otros seys versos del tercer tono', part.name_en = 'Obras de música: Versos de Magnificat: Otros seys versos del tercer tono',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 18749 AND p.composer_id = 298 AND part.part_key = 'musicbrainz:01e7a69f-d11a-4a84-92d8-46d56d93033a' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:01e7a69f-d11a-4a84-92d8-46d56d93033a', 6, NULL, 'Versos de Magnificat: Otros seys versos del tercer tono', 'Obras de música: Versos de Magnificat: Otros seys versos del tercer tono', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 18749 AND p.composer_id = 298
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:01e7a69f-d11a-4a84-92d8-46d56d93033a'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 7, part.movement_number = NULL,
    part.name_ko = 'Versos de Magnificat: Siete versos del quarto tono', part.name_en = 'Obras de música: Versos de Magnificat: Siete versos del quarto tono',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 18749 AND p.composer_id = 298 AND part.part_key = 'musicbrainz:a97eb028-df1f-4721-9a77-e08921b0ae0f' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:a97eb028-df1f-4721-9a77-e08921b0ae0f', 7, NULL, 'Versos de Magnificat: Siete versos del quarto tono', 'Obras de música: Versos de Magnificat: Siete versos del quarto tono', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 18749 AND p.composer_id = 298
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:a97eb028-df1f-4721-9a77-e08921b0ae0f'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 8, part.movement_number = NULL,
    part.name_ko = 'Versos de Magnificat: Seys versos del quinto tono', part.name_en = 'Obras de música: Versos de Magnificat: Seys versos del quinto tono',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 18749 AND p.composer_id = 298 AND part.part_key = 'musicbrainz:7c394e75-ede3-40bd-b025-d017f23dc554' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:7c394e75-ede3-40bd-b025-d017f23dc554', 8, NULL, 'Versos de Magnificat: Seys versos del quinto tono', 'Obras de música: Versos de Magnificat: Seys versos del quinto tono', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 18749 AND p.composer_id = 298
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:7c394e75-ede3-40bd-b025-d017f23dc554'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 9, part.movement_number = NULL,
    part.name_ko = 'Versos de Magnificat: Siete versos del sexto tono', part.name_en = 'Obras de música: Versos de Magnificat: Siete versos del sexto tono',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 18749 AND p.composer_id = 298 AND part.part_key = 'musicbrainz:926b3434-7907-4b00-a98f-3250b0514e5e' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:926b3434-7907-4b00-a98f-3250b0514e5e', 9, NULL, 'Versos de Magnificat: Siete versos del sexto tono', 'Obras de música: Versos de Magnificat: Siete versos del sexto tono', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 18749 AND p.composer_id = 298
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:926b3434-7907-4b00-a98f-3250b0514e5e'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 10, part.movement_number = NULL,
    part.name_ko = 'Versos de Magnificat: Siete versos del septimo tono', part.name_en = 'Obras de música: Versos de Magnificat: Siete versos del septimo tono',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 18749 AND p.composer_id = 298 AND part.part_key = 'musicbrainz:038b1624-4b03-41da-8c20-1cdda528a5fe' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:038b1624-4b03-41da-8c20-1cdda528a5fe', 10, NULL, 'Versos de Magnificat: Siete versos del septimo tono', 'Obras de música: Versos de Magnificat: Siete versos del septimo tono', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 18749 AND p.composer_id = 298
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:038b1624-4b03-41da-8c20-1cdda528a5fe'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 11, part.movement_number = NULL,
    part.name_ko = 'Versos de Magnificat: Siete versos del octavo tono', part.name_en = 'Obras de música: Versos de Magnificat: Siete versos del octavo tono',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 18749 AND p.composer_id = 298 AND part.part_key = 'musicbrainz:a895de3d-ab01-4db2-aa95-4161a89a6169' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:a895de3d-ab01-4db2-aa95-4161a89a6169', 11, NULL, 'Versos de Magnificat: Siete versos del octavo tono', 'Obras de música: Versos de Magnificat: Siete versos del octavo tono', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 18749 AND p.composer_id = 298
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:a895de3d-ab01-4db2-aa95-4161a89a6169'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 12, part.movement_number = NULL,
    part.name_ko = 'Tiento del segundo tono [I]', part.name_en = 'Obras de música: Tiento del segundo tono [I]',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 18749 AND p.composer_id = 298 AND part.part_key = 'musicbrainz:4f7e2a3c-9eaa-4990-b5b9-bef850b4cde8' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:4f7e2a3c-9eaa-4990-b5b9-bef850b4cde8', 12, NULL, 'Tiento del segundo tono [I]', 'Obras de música: Tiento del segundo tono [I]', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 18749 AND p.composer_id = 298
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:4f7e2a3c-9eaa-4990-b5b9-bef850b4cde8'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 13, part.movement_number = NULL,
    part.name_ko = 'Tiento del quarto tono [I]', part.name_en = 'Obras de música: Tiento del quarto tono [I]',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 18749 AND p.composer_id = 298 AND part.part_key = 'musicbrainz:eddd358a-8835-4630-ad8c-943648a3ab2d' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:eddd358a-8835-4630-ad8c-943648a3ab2d', 13, NULL, 'Tiento del quarto tono [I]', 'Obras de música: Tiento del quarto tono [I]', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 18749 AND p.composer_id = 298
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:eddd358a-8835-4630-ad8c-943648a3ab2d'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 14, part.movement_number = NULL,
    part.name_ko = 'Tiento del primer tono [I]', part.name_en = 'Obras de música: Tiento del primer tono [I]',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 18749 AND p.composer_id = 298 AND part.part_key = 'musicbrainz:460b99ed-5cad-4931-a336-48c25bbe1d2c' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:460b99ed-5cad-4931-a336-48c25bbe1d2c', 14, NULL, 'Tiento del primer tono [I]', 'Obras de música: Tiento del primer tono [I]', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 18749 AND p.composer_id = 298
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:460b99ed-5cad-4931-a336-48c25bbe1d2c'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 15, part.movement_number = NULL,
    part.name_ko = 'Tiento sobre Qui la dira', part.name_en = 'Obras de música: Tiento sobre Qui la dira',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 18749 AND p.composer_id = 298 AND part.part_key = 'musicbrainz:74905005-95a4-4d75-aaeb-a57c312247e4' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:74905005-95a4-4d75-aaeb-a57c312247e4', 15, NULL, 'Tiento sobre Qui la dira', 'Obras de música: Tiento sobre Qui la dira', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 18749 AND p.composer_id = 298
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:74905005-95a4-4d75-aaeb-a57c312247e4'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 16, part.movement_number = NULL,
    part.name_ko = 'Tiento del segundo tono [II]', part.name_en = 'Obras de música: Tiento del segundo tono [II]',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 18749 AND p.composer_id = 298 AND part.part_key = 'musicbrainz:5ce61ae7-ee43-455d-b150-5ff5a9f69068' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:5ce61ae7-ee43-455d-b150-5ff5a9f69068', 16, NULL, 'Tiento del segundo tono [II]', 'Obras de música: Tiento del segundo tono [II]', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 18749 AND p.composer_id = 298
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:5ce61ae7-ee43-455d-b150-5ff5a9f69068'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 17, part.movement_number = NULL,
    part.name_ko = 'Tiento del tercer tono', part.name_en = 'Obras de música: Tiento del tercer tono',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 18749 AND p.composer_id = 298 AND part.part_key = 'musicbrainz:f89f2d65-dab6-4396-8e8f-90c08b9f3415' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:f89f2d65-dab6-4396-8e8f-90c08b9f3415', 17, NULL, 'Tiento del tercer tono', 'Obras de música: Tiento del tercer tono', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 18749 AND p.composer_id = 298
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:f89f2d65-dab6-4396-8e8f-90c08b9f3415'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 18, part.movement_number = NULL,
    part.name_ko = 'Tiento del quarto tono [II]', part.name_en = 'Obras de música: Tiento del quarto tono [II]',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 18749 AND p.composer_id = 298 AND part.part_key = 'musicbrainz:b801ba9d-f0e2-46c6-b317-43c922156af8' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:b801ba9d-f0e2-46c6-b317-43c922156af8', 18, NULL, 'Tiento del quarto tono [II]', 'Obras de música: Tiento del quarto tono [II]', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 18749 AND p.composer_id = 298
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:b801ba9d-f0e2-46c6-b317-43c922156af8'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 19, part.movement_number = NULL,
    part.name_ko = 'Tiento del octavo tono', part.name_en = 'Obras de música: Tiento del octavo tono',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 18749 AND p.composer_id = 298 AND part.part_key = 'musicbrainz:24bc50a1-06b6-489e-b33a-a7dbb53ddb2d' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:24bc50a1-06b6-489e-b33a-a7dbb53ddb2d', 19, NULL, 'Tiento del octavo tono', 'Obras de música: Tiento del octavo tono', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 18749 AND p.composer_id = 298
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:24bc50a1-06b6-489e-b33a-a7dbb53ddb2d'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 20, part.movement_number = NULL,
    part.name_ko = 'Tiento del quinto tono', part.name_en = 'Obras de música: Tiento del quinto tono',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 18749 AND p.composer_id = 298 AND part.part_key = 'musicbrainz:13d44bfe-fb7c-4349-b0bf-cdd348bf83fe' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:13d44bfe-fb7c-4349-b0bf-cdd348bf83fe', 20, NULL, 'Tiento del quinto tono', 'Obras de música: Tiento del quinto tono', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 18749 AND p.composer_id = 298
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:13d44bfe-fb7c-4349-b0bf-cdd348bf83fe'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 21, part.movement_number = NULL,
    part.name_ko = 'Tiento del primer tono [II]', part.name_en = 'Obras de música: Tiento del primer tono [II]',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 18749 AND p.composer_id = 298 AND part.part_key = 'musicbrainz:bdb62783-fa97-4b29-b04d-b2c12d85fb50' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:bdb62783-fa97-4b29-b04d-b2c12d85fb50', 21, NULL, 'Tiento del primer tono [II]', 'Obras de música: Tiento del primer tono [II]', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 18749 AND p.composer_id = 298
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:bdb62783-fa97-4b29-b04d-b2c12d85fb50'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 22, part.movement_number = NULL,
    part.name_ko = 'Tiento del sexto tono', part.name_en = 'Obras de música: Tiento del sexto tono',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 18749 AND p.composer_id = 298 AND part.part_key = 'musicbrainz:d78db62c-f682-41ae-9617-7b51182f77f1' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:d78db62c-f682-41ae-9617-7b51182f77f1', 22, NULL, 'Tiento del sexto tono', 'Obras de música: Tiento del sexto tono', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 18749 AND p.composer_id = 298
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:d78db62c-f682-41ae-9617-7b51182f77f1'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 23, part.movement_number = NULL,
    part.name_ko = 'Tiento sobre Cum Sancto Spiritu', part.name_en = 'Obras de música: Tiento sobre Cum Sancto Spiritu',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 18749 AND p.composer_id = 298 AND part.part_key = 'musicbrainz:db7a6caf-8fe3-44af-9744-b31aa9598440' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:db7a6caf-8fe3-44af-9744-b31aa9598440', 23, NULL, 'Tiento sobre Cum Sancto Spiritu', 'Obras de música: Tiento sobre Cum Sancto Spiritu', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 18749 AND p.composer_id = 298
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:db7a6caf-8fe3-44af-9744-b31aa9598440'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 24, part.movement_number = NULL,
    part.name_ko = 'Stabat Mater con segunda parte (Jusquin)', part.name_en = 'Obras de música: Stabat Mater con segunda parte (Jusquin)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 18749 AND p.composer_id = 298 AND part.part_key = 'musicbrainz:be734c46-9807-4faa-bd99-54052c0bd7f0' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:be734c46-9807-4faa-bd99-54052c0bd7f0', 24, NULL, 'Stabat Mater con segunda parte (Jusquin)', 'Obras de música: Stabat Mater con segunda parte (Jusquin)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 18749 AND p.composer_id = 298
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:be734c46-9807-4faa-bd99-54052c0bd7f0'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 25, part.movement_number = NULL,
    part.name_ko = 'Sana me Domine (Clemens non Papa)', part.name_en = 'Obras de música: Sana me Domine (Clemens non Papa)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 18749 AND p.composer_id = 298 AND part.part_key = 'musicbrainz:b9a835e0-afb9-4614-8dad-fe8d46a1b001' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:b9a835e0-afb9-4614-8dad-fe8d46a1b001', 25, NULL, 'Sana me Domine (Clemens non Papa)', 'Obras de música: Sana me Domine (Clemens non Papa)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 18749 AND p.composer_id = 298
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:b9a835e0-afb9-4614-8dad-fe8d46a1b001'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 26, part.movement_number = NULL,
    part.name_ko = 'In te Domine speravi con segunda parte', part.name_en = 'Obras de música: In te Domine speravi con segunda parte',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 18749 AND p.composer_id = 298 AND part.part_key = 'musicbrainz:a6b3f3be-3aeb-4544-b67a-c4104232f8d5' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:a6b3f3be-3aeb-4544-b67a-c4104232f8d5', 26, NULL, 'In te Domine speravi con segunda parte', 'Obras de música: In te Domine speravi con segunda parte', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 18749 AND p.composer_id = 298
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:a6b3f3be-3aeb-4544-b67a-c4104232f8d5'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 27, part.movement_number = NULL,
    part.name_ko = 'Tercera parte de Virgo salutifera', part.name_en = 'Obras de música: Tercera parte de Virgo salutifera',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 18749 AND p.composer_id = 298 AND part.part_key = 'musicbrainz:2ea181d3-6eb5-460d-9008-1b02f1f01e11' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:2ea181d3-6eb5-460d-9008-1b02f1f01e11', 27, NULL, 'Tercera parte de Virgo salutifera', 'Obras de música: Tercera parte de Virgo salutifera', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 18749 AND p.composer_id = 298
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:2ea181d3-6eb5-460d-9008-1b02f1f01e11'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 28, part.movement_number = NULL,
    part.name_ko = 'Hierusalem luge (Ricaforte)', part.name_en = 'Obras de música: Hierusalem luge (Ricaforte)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 18749 AND p.composer_id = 298 AND part.part_key = 'musicbrainz:cad98773-b37b-42de-b132-146eb8122155' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:cad98773-b37b-42de-b132-146eb8122155', 28, NULL, 'Hierusalem luge (Ricaforte)', 'Obras de música: Hierusalem luge (Ricaforte)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 18749 AND p.composer_id = 298
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:cad98773-b37b-42de-b132-146eb8122155'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 29, part.movement_number = NULL,
    part.name_ko = 'Stabat Mater con diferente glosa', part.name_en = 'Obras de música: Stabat Mater con diferente glosa',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 18749 AND p.composer_id = 298 AND part.part_key = 'musicbrainz:668211b1-6bc4-411a-a5a5-5c3e147e3e4d' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:668211b1-6bc4-411a-a5a5-5c3e147e3e4d', 29, NULL, 'Stabat Mater con diferente glosa', 'Obras de música: Stabat Mater con diferente glosa', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 18749 AND p.composer_id = 298
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:668211b1-6bc4-411a-a5a5-5c3e147e3e4d'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 30, part.movement_number = NULL,
    part.name_ko = 'Inviolata (Jusquin)', part.name_en = 'Obras de música: Inviolata (Jusquin)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 18749 AND p.composer_id = 298 AND part.part_key = 'musicbrainz:64ae128b-63fe-434c-a177-4f11d326349e' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:64ae128b-63fe-434c-a177-4f11d326349e', 30, NULL, 'Inviolata (Jusquin)', 'Obras de música: Inviolata (Jusquin)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 18749 AND p.composer_id = 298
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:64ae128b-63fe-434c-a177-4f11d326349e'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 31, part.movement_number = NULL,
    part.name_ko = 'Qui la dira (Adrian Villart)', part.name_en = 'Obras de música: Qui la dira (Adrian Villart)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 18749 AND p.composer_id = 298 AND part.part_key = 'musicbrainz:03398311-ef95-47a8-96bc-efde11f2772b' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:03398311-ef95-47a8-96bc-efde11f2772b', 31, NULL, 'Qui la dira (Adrian Villart)', 'Obras de música: Qui la dira (Adrian Villart)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 18749 AND p.composer_id = 298
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:03398311-ef95-47a8-96bc-efde11f2772b'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 32, part.movement_number = NULL,
    part.name_ko = 'Quien llamo al partir partir', part.name_en = 'Obras de música: Quien llamo al partir partir',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 18749 AND p.composer_id = 298 AND part.part_key = 'musicbrainz:ad4f7edf-4a4f-4e12-88fe-38fdeae937b1' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:ad4f7edf-4a4f-4e12-88fe-38fdeae937b1', 32, NULL, 'Quien llamo al partir partir', 'Obras de música: Quien llamo al partir partir', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 18749 AND p.composer_id = 298
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:ad4f7edf-4a4f-4e12-88fe-38fdeae937b1'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 33, part.movement_number = NULL,
    part.name_ko = 'Benedicta es Regina caelorum (Jusquin)', part.name_en = 'Obras de música: Benedicta es Regina caelorum (Jusquin)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 18749 AND p.composer_id = 298 AND part.part_key = 'musicbrainz:f22d45f6-05e1-4740-986d-c27929bf895f' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:f22d45f6-05e1-4740-986d-c27929bf895f', 33, NULL, 'Benedicta es Regina caelorum (Jusquin)', 'Obras de música: Benedicta es Regina caelorum (Jusquin)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 18749 AND p.composer_id = 298
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:f22d45f6-05e1-4740-986d-c27929bf895f'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 34, part.movement_number = NULL,
    part.name_ko = 'Benedicta es caelorum regina, con segunda y tercera parte (Jusquin)', part.name_en = 'Obras de música: Benedicta es caelorum regina, con segunda y tercera parte (Jusquin)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 18749 AND p.composer_id = 298 AND part.part_key = 'musicbrainz:e3056d86-69d8-4273-9076-440db82941d6' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:e3056d86-69d8-4273-9076-440db82941d6', 34, NULL, 'Benedicta es caelorum regina, con segunda y tercera parte (Jusquin)', 'Obras de música: Benedicta es caelorum regina, con segunda y tercera parte (Jusquin)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 18749 AND p.composer_id = 298
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:e3056d86-69d8-4273-9076-440db82941d6'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 35, part.movement_number = NULL,
    part.name_ko = 'Sancta Maria (Verdelot)', part.name_en = 'Obras de música: Sancta Maria (Verdelot)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 18749 AND p.composer_id = 298 AND part.part_key = 'musicbrainz:58d12b3f-3f08-4232-94dc-04f7f623ec03' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:58d12b3f-3f08-4232-94dc-04f7f623ec03', 35, NULL, 'Sancta Maria (Verdelot)', 'Obras de música: Sancta Maria (Verdelot)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 18749 AND p.composer_id = 298
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:58d12b3f-3f08-4232-94dc-04f7f623ec03'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 36, part.movement_number = NULL,
    part.name_ko = 'Ave Maria (Jusquin)', part.name_en = 'Obras de música: Ave Maria (Jusquin)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 18749 AND p.composer_id = 298 AND part.part_key = 'musicbrainz:758d8616-4010-466d-a9e8-6a7c0fd1391e' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:758d8616-4010-466d-a9e8-6a7c0fd1391e', 36, NULL, 'Ave Maria (Jusquin)', 'Obras de música: Ave Maria (Jusquin)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 18749 AND p.composer_id = 298
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:758d8616-4010-466d-a9e8-6a7c0fd1391e'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 37, part.movement_number = NULL,
    part.name_ko = 'Ultimi miei suspiri (Verdelot)', part.name_en = 'Obras de música: Ultimi miei suspiri (Verdelot)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 18749 AND p.composer_id = 298 AND part.part_key = 'musicbrainz:516c404e-6c1f-430f-9f17-b85e7b9efbcb' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:516c404e-6c1f-430f-9f17-b85e7b9efbcb', 37, NULL, 'Ultimi miei suspiri (Verdelot)', 'Obras de música: Ultimi miei suspiri (Verdelot)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 18749 AND p.composer_id = 298
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:516c404e-6c1f-430f-9f17-b85e7b9efbcb'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 38, part.movement_number = NULL,
    part.name_ko = 'Ardenti miei suspiri (Verdelot)', part.name_en = 'Obras de música: Ardenti miei suspiri (Verdelot)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 18749 AND p.composer_id = 298 AND part.part_key = 'musicbrainz:8c76ed2c-2ba7-4bfb-99c3-dcc8a4eea85a' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:8c76ed2c-2ba7-4bfb-99c3-dcc8a4eea85a', 38, NULL, 'Ardenti miei suspiri (Verdelot)', 'Obras de música: Ardenti miei suspiri (Verdelot)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 18749 AND p.composer_id = 298
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:8c76ed2c-2ba7-4bfb-99c3-dcc8a4eea85a'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 39, part.movement_number = NULL,
    part.name_ko = 'Diferencias sobre las Vacas [I]', part.name_en = 'Obras de música: Diferencias sobre las Vacas [I]',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 18749 AND p.composer_id = 298 AND part.part_key = 'musicbrainz:38610c72-c026-4b4e-83c5-9a08e331d748' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:38610c72-c026-4b4e-83c5-9a08e331d748', 39, NULL, 'Diferencias sobre las Vacas [I]', 'Obras de música: Diferencias sobre las Vacas [I]', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 18749 AND p.composer_id = 298
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:38610c72-c026-4b4e-83c5-9a08e331d748'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 40, part.movement_number = NULL,
    part.name_ko = 'Pavana italiana', part.name_en = 'Obras de música: Pavana italiana',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 18749 AND p.composer_id = 298 AND part.part_key = 'musicbrainz:c3a269c9-0fa0-45cb-9d85-c935c82ca876' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:c3a269c9-0fa0-45cb-9d85-c935c82ca876', 40, NULL, 'Pavana italiana', 'Obras de música: Pavana italiana', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 18749 AND p.composer_id = 298
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:c3a269c9-0fa0-45cb-9d85-c935c82ca876'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 41, part.movement_number = NULL,
    part.name_ko = 'Diferencias sobre la gallarda milanesa', part.name_en = 'Obras de música: Diferencias sobre la gallarda milanesa',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 18749 AND p.composer_id = 298 AND part.part_key = 'musicbrainz:e3cd6542-c166-4d92-b7c5-527d407c0606' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:e3cd6542-c166-4d92-b7c5-527d407c0606', 41, NULL, 'Diferencias sobre la gallarda milanesa', 'Obras de música: Diferencias sobre la gallarda milanesa', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 18749 AND p.composer_id = 298
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:e3cd6542-c166-4d92-b7c5-527d407c0606'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 42, part.movement_number = NULL,
    part.name_ko = 'Diferencias sobre la Pavana italiana', part.name_en = 'Obras de música: Diferencias sobre la Pavana italiana',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 18749 AND p.composer_id = 298 AND part.part_key = 'musicbrainz:62a4afff-ad22-4a2d-bdd6-a6dc61d52cb9' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:62a4afff-ad22-4a2d-bdd6-a6dc61d52cb9', 42, NULL, 'Diferencias sobre la Pavana italiana', 'Obras de música: Diferencias sobre la Pavana italiana', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 18749 AND p.composer_id = 298
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:62a4afff-ad22-4a2d-bdd6-a6dc61d52cb9'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 43, part.movement_number = NULL,
    part.name_ko = 'Diferencias sobre las Vacas [II]', part.name_en = 'Obras de música: Diferencias sobre las Vacas [II]',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 18749 AND p.composer_id = 298 AND part.part_key = 'musicbrainz:85065fbd-88b8-435a-8b8b-8f3e572bc604' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:85065fbd-88b8-435a-8b8b-8f3e572bc604', 43, NULL, 'Diferencias sobre las Vacas [II]', 'Obras de música: Diferencias sobre las Vacas [II]', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 18749 AND p.composer_id = 298
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:85065fbd-88b8-435a-8b8b-8f3e572bc604'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 44, part.movement_number = NULL,
    part.name_ko = 'Otras diferencias de Vacas', part.name_en = 'Obras de música: Otras diferencias de Vacas',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 18749 AND p.composer_id = 298 AND part.part_key = 'musicbrainz:d0d91f39-9a30-4c21-b04b-b054f54d67b4' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:d0d91f39-9a30-4c21-b04b-b054f54d67b4', 44, NULL, 'Otras diferencias de Vacas', 'Obras de música: Otras diferencias de Vacas', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 18749 AND p.composer_id = 298
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:d0d91f39-9a30-4c21-b04b-b054f54d67b4'
);


-- None Pange lingua (glosado)

UPDATE pieces piece
SET piece.title = 'Pange lingua (glosado)', piece.title_en = 'Pange lingua (glosado)',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 18761 AND piece.composer_id = 298
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Pavana Italiana

UPDATE pieces piece
SET piece.title = 'Pavana Italiana', piece.title_en = 'Pavana Italiana',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 16824 AND piece.composer_id = 298
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Pavana con su glosa

UPDATE pieces piece
SET piece.title = 'Pavana con su glosa', piece.title_en = 'Pavana con su glosa',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 16164 AND piece.composer_id = 298
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Prenez pitie, Cancion glosada

UPDATE pieces piece
SET piece.title = 'Prenez pitie, Cancion glosada', piece.title_en = 'Prenez pitie, Cancion glosada',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 17582 AND piece.composer_id = 298
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Quien llamó al partir partir

UPDATE pieces piece
SET piece.title = 'Quien llamó al partir partir', piece.title_en = 'Quien llamó al partir partir',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 17533 AND piece.composer_id = 298
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None 로망스 "Para quien crie yo cabellos"

UPDATE pieces piece
SET piece.title = '로망스 "Para quien crie yo cabellos"', piece.title_en = 'Romance "Para quien crie yo cabellos"',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 18875 AND piece.composer_id = 298
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Rugier, glosado de Antonio

UPDATE pieces piece
SET piece.title = 'Rugier, glosado de Antonio', piece.title_en = 'Rugier, glosado de Antonio',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 17456 AND piece.composer_id = 298
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Salmodia para el Magnificat

UPDATE pieces piece
SET piece.title = 'Salmodia para el Magnificat', piece.title_en = 'Salmodia para el Magnificat',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 17862 AND piece.composer_id = 298
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Salmodia para principantes

UPDATE pieces piece
SET piece.title = 'Salmodia para principantes', piece.title_en = 'Salmodia para principantes',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 20067 AND piece.composer_id = 298
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'Versos del septimo tono', part.name_en = 'Salmodia para principantes: Versos del septimo tono',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 20067 AND p.composer_id = 298 AND part.part_key = 'musicbrainz:05214de0-68d3-4476-adc3-9bc953be9f50' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:05214de0-68d3-4476-adc3-9bc953be9f50', 1, NULL, 'Versos del septimo tono', 'Salmodia para principantes: Versos del septimo tono', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 20067 AND p.composer_id = 298
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:05214de0-68d3-4476-adc3-9bc953be9f50'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'Versos del primer tono', part.name_en = 'Salmodia para principantes: Versos del primer tono',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 20067 AND p.composer_id = 298 AND part.part_key = 'musicbrainz:49317a2c-ddec-48e0-8f3b-c5c7496395c1' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:49317a2c-ddec-48e0-8f3b-c5c7496395c1', 2, NULL, 'Versos del primer tono', 'Salmodia para principantes: Versos del primer tono', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 20067 AND p.composer_id = 298
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:49317a2c-ddec-48e0-8f3b-c5c7496395c1'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = NULL,
    part.name_ko = 'Versos del quinto tono', part.name_en = 'Salmodia para principantes: Versos del quinto tono',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 20067 AND p.composer_id = 298 AND part.part_key = 'musicbrainz:4b3cb0b3-6230-4daa-b4dc-045c9dd67e9d' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:4b3cb0b3-6230-4daa-b4dc-045c9dd67e9d', 3, NULL, 'Versos del quinto tono', 'Salmodia para principantes: Versos del quinto tono', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 20067 AND p.composer_id = 298
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:4b3cb0b3-6230-4daa-b4dc-045c9dd67e9d'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = NULL,
    part.name_ko = 'Versos del octavo tono', part.name_en = 'Salmodia para principantes: Versos del octavo tono',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 20067 AND p.composer_id = 298 AND part.part_key = 'musicbrainz:7973d67e-3128-4674-845f-550a4ae5a537' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:7973d67e-3128-4674-845f-550a4ae5a537', 4, NULL, 'Versos del octavo tono', 'Salmodia para principantes: Versos del octavo tono', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 20067 AND p.composer_id = 298
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:7973d67e-3128-4674-845f-550a4ae5a537'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 5, part.movement_number = NULL,
    part.name_ko = 'Versos del sexto tono', part.name_en = 'Salmodia para principantes: Versos del sexto tono',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 20067 AND p.composer_id = 298 AND part.part_key = 'musicbrainz:7c18618c-95f3-4d80-90c2-b3f7e390f2c1' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:7c18618c-95f3-4d80-90c2-b3f7e390f2c1', 5, NULL, 'Versos del sexto tono', 'Salmodia para principantes: Versos del sexto tono', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 20067 AND p.composer_id = 298
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:7c18618c-95f3-4d80-90c2-b3f7e390f2c1'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 6, part.movement_number = NULL,
    part.name_ko = 'Versos del segundo tono', part.name_en = 'Salmodia para principantes: Versos del segundo tono',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 20067 AND p.composer_id = 298 AND part.part_key = 'musicbrainz:9737c5b4-811f-4940-8d07-8af365849a8e' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:9737c5b4-811f-4940-8d07-8af365849a8e', 6, NULL, 'Versos del segundo tono', 'Salmodia para principantes: Versos del segundo tono', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 20067 AND p.composer_id = 298
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:9737c5b4-811f-4940-8d07-8af365849a8e'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 7, part.movement_number = NULL,
    part.name_ko = 'Versos del tercer tono', part.name_en = 'Salmodia para principantes: Versos del tercer tono',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 20067 AND p.composer_id = 298 AND part.part_key = 'musicbrainz:c51a16de-deba-4c0c-9df1-2000717ff5f8' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:c51a16de-deba-4c0c-9df1-2000717ff5f8', 7, NULL, 'Versos del tercer tono', 'Salmodia para principantes: Versos del tercer tono', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 20067 AND p.composer_id = 298
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:c51a16de-deba-4c0c-9df1-2000717ff5f8'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 8, part.movement_number = NULL,
    part.name_ko = 'Versos del quarto tono', part.name_en = 'Salmodia para principantes: Versos del quarto tono',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 20067 AND p.composer_id = 298 AND part.part_key = 'musicbrainz:e1253910-9f6b-4fbf-b50f-cab728019642' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:e1253910-9f6b-4fbf-b50f-cab728019642', 8, NULL, 'Versos del quarto tono', 'Salmodia para principantes: Versos del quarto tono', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 20067 AND p.composer_id = 298
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:e1253910-9f6b-4fbf-b50f-cab728019642'
);


-- None Susana

UPDATE pieces piece
SET piece.title = 'Susana', piece.title_en = 'Susana',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 16188 AND piece.composer_id = 298
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Tiento Cuarto tono

UPDATE pieces piece
SET piece.title = 'Tiento Cuarto tono', piece.title_en = 'Tiento Cuarto tono',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 16166 AND piece.composer_id = 298
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Tiento I

UPDATE pieces piece
SET piece.title = 'Tiento I', piece.title_en = 'Tiento I',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 17683 AND piece.composer_id = 298
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Tiento Primo tono

UPDATE pieces piece
SET piece.title = 'Tiento Primo tono', piece.title_en = 'Tiento Primo tono',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 19691 AND piece.composer_id = 298
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Tiento XVIII

UPDATE pieces piece
SET piece.title = 'Tiento XVIII', piece.title_en = 'Tiento XVIII',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 19560 AND piece.composer_id = 298
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None 가곡 <Tiento del octavo tono>

UPDATE pieces piece
SET piece.title = '가곡 <Tiento del octavo tono>', piece.title_en = 'Tiento del octavo tono',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 18975 AND piece.composer_id = 298
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Tiento del primer tono

UPDATE pieces piece
SET piece.title = 'Tiento del primer tono', piece.title_en = 'Tiento del primer tono',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 18167 AND piece.composer_id = 298
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None 가곡 <Tiento del quarto tono (extract)>

UPDATE pieces piece
SET piece.title = '가곡 <Tiento del quarto tono (extract)>', piece.title_en = 'Tiento del quarto tono (extract)',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 19998 AND piece.composer_id = 298
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Tiento del quarto tono sobre Maheur me bat

UPDATE pieces piece
SET piece.title = 'Tiento del quarto tono sobre Maheur me bat', piece.title_en = 'Tiento del quarto tono sobre Maheur me bat',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 18596 AND piece.composer_id = 298
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None 가곡 <Tiento del quinto tono>

UPDATE pieces piece
SET piece.title = '가곡 <Tiento del quinto tono>', piece.title_en = 'Tiento del quinto tono',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 19549 AND piece.composer_id = 298
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Tiento para arpa. Fabordón, glosado en el tiple, tono I

UPDATE pieces piece
SET piece.title = 'Tiento para arpa. Fabordón, glosado en el tiple, tono I', piece.title_en = 'Tiento para arpa. Fabordón, glosado en el tiple, tono I',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 18362 AND piece.composer_id = 298
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Tres "Sobre el canto Ilano de la alta"

UPDATE pieces piece
SET piece.title = 'Tres "Sobre el canto Ilano de la alta"', piece.title_en = 'Tres "Sobre el canto Ilano de la alta"',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 15834 AND piece.composer_id = 298
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Ave maris stella

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, 'Ave maris stella', 'Ave maris stella', 'song', NULL, NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 298
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = 'Ave maris stella'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '8f5614a1-460a-477c-83ec-9b55e2d0ea7f'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '8f5614a1-460a-477c-83ec-9b55e2d0ea7f'
FROM pieces p
WHERE p.composer_id = 298 AND p.title = 'Ave maris stella' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '8f5614a1-460a-477c-83ec-9b55e2d0ea7f'
);


-- 카탈로그에 대응이 없는 seed 작품 3개를 목록에서 숨긴다(지우지 않음).
UPDATE pieces piece
SET piece.hidden_reason = 'catalog_unmatched'
WHERE piece.composer_id = 298 AND piece.origin = 'seed' AND piece.hidden_reason IS NULL
  AND piece.id IN (
    16671, 17570, 18516
  )
  AND NOT EXISTS (SELECT 1 FROM performance_sectors sector WHERE sector.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM piece_parts linking WHERE linking.linked_piece_id = piece.id);
