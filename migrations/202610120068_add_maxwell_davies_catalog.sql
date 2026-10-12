-- 피터 맥스웰 데이비스 작품을 MusicBrainz 작품 구조로 다시 짠다(4차 자동). 작품 133개(묶음 9, 다악장 31, 낱곡 93),
-- 새 작품 2개, part 187개, 그 아래 11개.
-- seed 149개 중 131개를 작품·part 에 잇고, 11개를 숨기고, 7개는 그대로 둔다.
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
SET piece.title = 'Farewell to Stromness (편곡 18237)'
WHERE piece.id = 18237 AND piece.composer_id = 301 AND piece.title = 'Farewell to Stromness'
  AND piece.origin = 'seed' AND piece.editor_locked = 0
  AND NOT EXISTS (SELECT 1 FROM performance_sectors sector WHERE sector.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM piece_parts linking WHERE linking.linked_piece_id = piece.id);


-- None A Birthday Card for Jennifer

UPDATE pieces piece
SET piece.title = 'A Birthday Card for Jennifer', piece.title_en = 'A Birthday Card for Jennifer',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 18665 AND piece.composer_id = 301
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None A Calendar of Kings

UPDATE pieces piece
SET piece.title = 'A Calendar of Kings', piece.title_en = 'A Calendar of Kings',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 17306 AND piece.composer_id = 301
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- Op. 165 A Hoy Calendar

UPDATE pieces piece
SET piece.title = 'A Hoy Calendar', piece.title_en = 'A Hoy Calendar, op. 165',
    piece.type = 'song', piece.opus_number = 'Op. 165',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 18404 AND piece.composer_id = 301
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- Op. 270 A Little Birthday Music

UPDATE pieces piece
SET piece.title = 'A Little Birthday Music', piece.title_en = 'A Little Birthday Music, op. 270',
    piece.type = 'song', piece.opus_number = 'Op. 270',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 16553 AND piece.composer_id = 301
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- Op. 75 A Mirror of Whitening Light

UPDATE pieces piece
SET piece.title = 'A Mirror of Whitening Light', piece.title_en = 'A Mirror of Whitening Light, op. 75',
    piece.type = 'song', piece.opus_number = 'Op. 75',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 18608 AND piece.composer_id = 301
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- Op. 318 A Postcard from Sanday

UPDATE pieces piece
SET piece.title = 'A Postcard from Sanday', piece.title_en = 'A Postcard from Sanday, op. 318',
    piece.type = 'song', piece.opus_number = 'Op. 318',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 17127 AND piece.composer_id = 301
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None A Reel of Seven Fishermen

UPDATE pieces piece
SET piece.title = 'A Reel of Seven Fishermen', piece.title_en = 'A Reel of Seven Fishermen',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 16280 AND piece.composer_id = 301
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- Op. 286 Almighty god, we beseech thee

UPDATE pieces piece
SET piece.title = 'Almighty god, we beseech thee', piece.title_en = 'Almighty god, we beseech thee, op. 286',
    piece.type = 'song', piece.opus_number = 'Op. 286',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 19990 AND piece.composer_id = 301
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- Op. 120a An Orkney Wedding, with Sunrise

UPDATE pieces piece
SET piece.title = 'An Orkney Wedding, with Sunrise', piece.title_en = 'An Orkney Wedding, with Sunrise, op. 120a',
    piece.type = 'song', piece.opus_number = 'Op. 120a',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 18776 AND piece.composer_id = 301
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- Op. 34 Antechrist

UPDATE pieces piece
SET piece.title = 'Antechrist', piece.title_en = 'Antechrist, op. 34',
    piece.type = 'song', piece.opus_number = 'Op. 34',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 17776 AND piece.composer_id = 301
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None 가곡 <Ave Maria-Hail, Blessed Flower>

UPDATE pieces piece
SET piece.title = '가곡 <Ave Maria-Hail, Blessed Flower>', piece.title_en = 'Ave Maria-Hail, Blessed Flower',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 19357 AND piece.composer_id = 301
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- Op. 76 가곡 <Ave Rex Angelorum>

UPDATE pieces piece
SET piece.title = '가곡 <Ave Rex Angelorum>', piece.title_en = 'Ave Rex Angelorum, op. 76',
    piece.type = 'song', piece.opus_number = 'Op. 76',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 19228 AND piece.composer_id = 301
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- Op. 82 Black Pentecost

UPDATE pieces piece
SET piece.title = 'Black Pentecost', piece.title_en = 'Black Pentecost, op. 82',
    piece.type = 'song', piece.opus_number = 'Op. 82',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 19837 AND piece.composer_id = 301
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- Op. 51 Blind Man's Buff

UPDATE pieces piece
SET piece.title = 'Blind Man''s Buff', piece.title_en = 'Blind Man''s Buff, op. 51',
    piece.type = 'song', piece.opus_number = 'Op. 51',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 16941 AND piece.composer_id = 301
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- Op. 144a 발레 <Caroline Mathilde>

UPDATE pieces piece
SET piece.title = '발레 <Caroline Mathilde>', piece.title_en = 'Caroline Mathilde, op. 144a',
    piece.type = 'song', piece.opus_number = 'Op. 144a',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 16379 AND piece.composer_id = 301
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- Op. 168 Carolísima

UPDATE pieces piece
SET piece.title = 'Carolísima', piece.title_en = 'Carolísima, op. 168',
    piece.type = 'song', piece.opus_number = 'Op. 168',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 19343 AND piece.composer_id = 301
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- Op. 164 Chat Moss

UPDATE pieces piece
SET piece.title = 'Chat Moss', piece.title_en = 'Chat Moss, op. 164',
    piece.type = 'song', piece.opus_number = 'Op. 164',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 19171 AND piece.composer_id = 301
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- Op. 326 Concert Overture "Ebb of Winter"

UPDATE pieces piece
SET piece.title = 'Concert Overture "Ebb of Winter"', piece.title_en = 'Concert Overture "Ebb of Winter", op. 326',
    piece.type = 'song', piece.opus_number = 'Op. 326',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 18268 AND piece.composer_id = 301
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- Op. 132 트럼펫 협주곡

UPDATE pieces piece
SET piece.title = '트럼펫 협주곡', piece.title_en = 'Concerto for Trumpet and Orchestra, op. 132',
    piece.type = 'album', piece.opus_number = 'Op. 132',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 19668 AND piece.composer_id = 301
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'Adagio - Allegro', part.name_en = 'Concerto for Trumpet and Orchestra, op. 132: I. Adagio - Allegro',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 19668 AND p.composer_id = 301 AND part.part_key = 'musicbrainz:d46a3270-3790-40c5-9f95-f56bd67532a9' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:d46a3270-3790-40c5-9f95-f56bd67532a9', 1, 'I', 'Adagio - Allegro', 'Concerto for Trumpet and Orchestra, op. 132: I. Adagio - Allegro', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 19668 AND p.composer_id = 301
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:d46a3270-3790-40c5-9f95-f56bd67532a9'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'Adagio molto', part.name_en = 'Concerto for Trumpet and Orchestra, op. 132: II. Adagio molto',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 19668 AND p.composer_id = 301 AND part.part_key = 'musicbrainz:1f9ce3ac-b9d3-400b-804d-ea8acbf719c6' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:1f9ce3ac-b9d3-400b-804d-ea8acbf719c6', 2, 'II', 'Adagio molto', 'Concerto for Trumpet and Orchestra, op. 132: II. Adagio molto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 19668 AND p.composer_id = 301
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:1f9ce3ac-b9d3-400b-804d-ea8acbf719c6'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = 'Presto', part.name_en = 'Concerto for Trumpet and Orchestra, op. 132: III. Presto',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 19668 AND p.composer_id = 301 AND part.part_key = 'musicbrainz:f3d77cd3-025e-435e-939a-def38e2d5cd6' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:f3d77cd3-025e-435e-939a-def38e2d5cd6', 3, 'III', 'Presto', 'Concerto for Trumpet and Orchestra, op. 132: III. Presto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 19668 AND p.composer_id = 301
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:f3d77cd3-025e-435e-939a-def38e2d5cd6'
);


-- Op. 123 바이올린 협주곡

UPDATE pieces piece
SET piece.title = '바이올린 협주곡', piece.title_en = 'Concerto for Violin and Orchestra, op. 123',
    piece.type = 'album', piece.opus_number = 'Op. 123',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 16377 AND piece.composer_id = 301
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'Allegro moderato', part.name_en = 'Concerto for Violin and Orchestra, op. 123: I. Allegro moderato',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 16377 AND p.composer_id = 301 AND part.part_key = 'musicbrainz:704a51fb-228e-449e-8bad-29f02af10797' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:704a51fb-228e-449e-8bad-29f02af10797', 1, 'I', 'Allegro moderato', 'Concerto for Violin and Orchestra, op. 123: I. Allegro moderato', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 16377 AND p.composer_id = 301
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:704a51fb-228e-449e-8bad-29f02af10797'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'Adagio', part.name_en = 'Concerto for Violin and Orchestra, op. 123: II. Adagio',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 16377 AND p.composer_id = 301 AND part.part_key = 'musicbrainz:1b89b5e6-8d14-48f5-a099-373cb2336329' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:1b89b5e6-8d14-48f5-a099-373cb2336329', 2, 'II', 'Adagio', 'Concerto for Violin and Orchestra, op. 123: II. Adagio', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 16377 AND p.composer_id = 301
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:1b89b5e6-8d14-48f5-a099-373cb2336329'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = 'Allegro non troppo', part.name_en = 'Concerto for Violin and Orchestra, op. 123: III. Allegro non troppo',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 16377 AND p.composer_id = 301 AND part.part_key = 'musicbrainz:3c5d31c0-4495-4af5-8108-8de575f7321c' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:3c5d31c0-4495-4af5-8108-8de575f7321c', 3, 'III', 'Allegro non troppo', 'Concerto for Violin and Orchestra, op. 123: III. Allegro non troppo', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 16377 AND p.composer_id = 301
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:3c5d31c0-4495-4af5-8108-8de575f7321c'
);


-- None Corpus Christi, with Cat and Mouse

UPDATE pieces piece
SET piece.title = 'Corpus Christi, with Cat and Mouse', piece.title_en = 'Corpus Christi, with Cat and Mouse',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 19551 AND piece.composer_id = 301
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- Op. 167 Cross Lane Fair Op. 167

UPDATE pieces piece
SET piece.title = 'Cross Lane Fair Op. 167', piece.title_en = 'Cross Lane Fair, op. 167',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = 'Op.', piece.catalogue_number = '167',
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 17754 AND piece.composer_id = 301
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'Introduction', part.name_en = 'Cross Lane Fair, op. 167: No. 1. Introduction',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 17754 AND p.composer_id = 301 AND part.part_key = 'musicbrainz:9f0ab085-da3b-42c3-94ae-0b0aa1f3f1c2' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:9f0ab085-da3b-42c3-94ae-0b0aa1f3f1c2', 1, NULL, 'Introduction', 'Cross Lane Fair, op. 167: No. 1. Introduction', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 17754 AND p.composer_id = 301
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:9f0ab085-da3b-42c3-94ae-0b0aa1f3f1c2'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'Fairground', part.name_en = 'Cross Lane Fair, op. 167: No. 2. Fairground',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 17754 AND p.composer_id = 301 AND part.part_key = 'musicbrainz:e6aa9e6d-6339-4cd9-9fd6-af02617e6325' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:e6aa9e6d-6339-4cd9-9fd6-af02617e6325', 2, NULL, 'Fairground', 'Cross Lane Fair, op. 167: No. 2. Fairground', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 17754 AND p.composer_id = 301
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:e6aa9e6d-6339-4cd9-9fd6-af02617e6325'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = NULL,
    part.name_ko = 'Ghost Train', part.name_en = 'Cross Lane Fair, op. 167: No. 3. Ghost Train',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 17754 AND p.composer_id = 301 AND part.part_key = 'musicbrainz:12ca7750-47bc-4139-8aa8-60fa6d60541c' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:12ca7750-47bc-4139-8aa8-60fa6d60541c', 3, NULL, 'Ghost Train', 'Cross Lane Fair, op. 167: No. 3. Ghost Train', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 17754 AND p.composer_id = 301
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:12ca7750-47bc-4139-8aa8-60fa6d60541c'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = NULL,
    part.name_ko = 'Transition', part.name_en = 'Cross Lane Fair, op. 167: No. 4. Transition',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 17754 AND p.composer_id = 301 AND part.part_key = 'musicbrainz:ee907ad7-29f4-4230-96c4-b84d162cce01' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:ee907ad7-29f4-4230-96c4-b84d162cce01', 4, NULL, 'Transition', 'Cross Lane Fair, op. 167: No. 4. Transition', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 17754 AND p.composer_id = 301
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:ee907ad7-29f4-4230-96c4-b84d162cce01'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 5, part.movement_number = NULL,
    part.name_ko = 'The Bearded Lady and the Five Legged Sheep', part.name_en = 'Cross Lane Fair, op. 167: No. 5. The Bearded Lady and the Five Legged Sheep',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 17754 AND p.composer_id = 301 AND part.part_key = 'musicbrainz:63755ffe-9b50-4174-af91-86f16de7920f' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:63755ffe-9b50-4174-af91-86f16de7920f', 5, NULL, 'The Bearded Lady and the Five Legged Sheep', 'Cross Lane Fair, op. 167: No. 5. The Bearded Lady and the Five Legged Sheep', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 17754 AND p.composer_id = 301
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:63755ffe-9b50-4174-af91-86f16de7920f'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 6, part.movement_number = NULL,
    part.name_ko = 'Transition', part.name_en = 'Cross Lane Fair, op. 167: No. 6. Transition',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 17754 AND p.composer_id = 301 AND part.part_key = 'musicbrainz:537180d2-5df0-4011-9704-a29bec8ba3ce' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:537180d2-5df0-4011-9704-a29bec8ba3ce', 6, NULL, 'Transition', 'Cross Lane Fair, op. 167: No. 6. Transition', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 17754 AND p.composer_id = 301
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:537180d2-5df0-4011-9704-a29bec8ba3ce'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 7, part.movement_number = NULL,
    part.name_ko = 'The Juggler', part.name_en = 'Cross Lane Fair, op. 167: No. 7. The Juggler',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 17754 AND p.composer_id = 301 AND part.part_key = 'musicbrainz:11ca0a91-1c6f-4e31-86b8-67879bfb81c2' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:11ca0a91-1c6f-4e31-86b8-67879bfb81c2', 7, NULL, 'The Juggler', 'Cross Lane Fair, op. 167: No. 7. The Juggler', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 17754 AND p.composer_id = 301
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:11ca0a91-1c6f-4e31-86b8-67879bfb81c2'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 8, part.movement_number = NULL,
    part.name_ko = 'Transition', part.name_en = 'Cross Lane Fair, op. 167: No. 8. Transition',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 17754 AND p.composer_id = 301 AND part.part_key = 'musicbrainz:6d47492a-e589-4645-b73a-233bf4c44653' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:6d47492a-e589-4645-b73a-233bf4c44653', 8, NULL, 'Transition', 'Cross Lane Fair, op. 167: No. 8. Transition', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 17754 AND p.composer_id = 301
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:6d47492a-e589-4645-b73a-233bf4c44653'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 9, part.movement_number = NULL,
    part.name_ko = 'The Roundabout', part.name_en = 'Cross Lane Fair, op. 167: No. 9. The Roundabout',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 17754 AND p.composer_id = 301 AND part.part_key = 'musicbrainz:0d6c816f-5c1a-4345-88f6-afb2f4121fb1' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:0d6c816f-5c1a-4345-88f6-afb2f4121fb1', 9, NULL, 'The Roundabout', 'Cross Lane Fair, op. 167: No. 9. The Roundabout', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 17754 AND p.composer_id = 301
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:0d6c816f-5c1a-4345-88f6-afb2f4121fb1'
);


-- Op. 59 Dark Angels

UPDATE pieces piece
SET piece.title = 'Dark Angels', piece.title_en = 'Dark Angels, op. 59',
    piece.type = 'album', piece.opus_number = 'Op. 59',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 19321 AND piece.composer_id = 301
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'The Drowning Brothers', part.name_en = 'Dark Angels, op. 59: I. The Drowning Brothers',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 19321 AND p.composer_id = 301 AND part.part_key = 'musicbrainz:1514f0db-430f-4640-92a3-5b13d6e40c7f' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:1514f0db-430f-4640-92a3-5b13d6e40c7f', 1, 'I', 'The Drowning Brothers', 'Dark Angels, op. 59: I. The Drowning Brothers', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 19321 AND p.composer_id = 301
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:1514f0db-430f-4640-92a3-5b13d6e40c7f'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'Dark Angels', part.name_en = 'Dark Angels, op. 59: II. Dark Angels',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 19321 AND p.composer_id = 301 AND part.part_key = 'musicbrainz:81274d84-c87c-4e28-8841-db5bad451c3d' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:81274d84-c87c-4e28-8841-db5bad451c3d', 2, 'II', 'Dark Angels', 'Dark Angels, op. 59: II. Dark Angels', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 19321 AND p.composer_id = 301
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:81274d84-c87c-4e28-8841-db5bad451c3d'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = 'Dead Fires', part.name_en = 'Dark Angels, op. 59: III. Dead Fires',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 19321 AND p.composer_id = 301 AND part.part_key = 'musicbrainz:13bd0f95-5198-4751-823e-3a36b8672480' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:13bd0f95-5198-4751-823e-3a36b8672480', 3, 'III', 'Dead Fires', 'Dark Angels, op. 59: III. Dead Fires', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 19321 AND p.composer_id = 301
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:13bd0f95-5198-4751-823e-3a36b8672480'
);


-- Op. 216 Dove, Star-Folded

UPDATE pieces piece
SET piece.title = 'Dove, Star-Folded', piece.title_en = 'Dove, Star-Folded, op. 216',
    piece.type = 'song', piece.opus_number = 'Op. 216',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 17011 AND piece.composer_id = 301
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- Op. 39 8개의 가곡

UPDATE pieces piece
SET piece.title = '8개의 가곡', piece.title_en = 'Eight Songs for a Mad King, op. 39',
    piece.type = 'album', piece.opus_number = 'Op. 39',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 17058 AND piece.composer_id = 301
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'Country Dance (Scotch Bonnett)', part.name_en = 'Eight Songs for a Mad King, op. 39: I. Country Dance (Scotch Bonnett)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 17058 AND p.composer_id = 301 AND part.part_key = 'musicbrainz:07721a93-7232-4faa-bcd1-331db3216dd5' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:07721a93-7232-4faa-bcd1-331db3216dd5', 1, 'I', 'Country Dance (Scotch Bonnett)', 'Eight Songs for a Mad King, op. 39: I. Country Dance (Scotch Bonnett)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 17058 AND p.composer_id = 301
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:07721a93-7232-4faa-bcd1-331db3216dd5'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'The Sentry (King Prussia''s Minuet)', part.name_en = 'Eight Songs for a Mad King, op. 39: II. The Sentry (King Prussia''s Minuet)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 17058 AND p.composer_id = 301 AND part.part_key = 'musicbrainz:5aa85685-051d-448e-afe4-2267d4bc5c63' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:5aa85685-051d-448e-afe4-2267d4bc5c63', 2, 'II', 'The Sentry (King Prussia''s Minuet)', 'Eight Songs for a Mad King, op. 39: II. The Sentry (King Prussia''s Minuet)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 17058 AND p.composer_id = 301
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:5aa85685-051d-448e-afe4-2267d4bc5c63'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = 'The Country Walk (La Promenade)', part.name_en = 'Eight Songs for a Mad King, op. 39: III. The Country Walk (La Promenade)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 17058 AND p.composer_id = 301 AND part.part_key = 'musicbrainz:b202a9d7-356c-43b2-b93a-b81e535dc57a' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:b202a9d7-356c-43b2-b93a-b81e535dc57a', 3, 'III', 'The Country Walk (La Promenade)', 'Eight Songs for a Mad King, op. 39: III. The Country Walk (La Promenade)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 17058 AND p.composer_id = 301
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:b202a9d7-356c-43b2-b93a-b81e535dc57a'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = 'IV',
    part.name_ko = 'The Lady-In-Waiting (Miss Musgrave''s Fancy)', part.name_en = 'Eight Songs for a Mad King, op. 39: IV. The Lady-In-Waiting (Miss Musgrave''s Fancy)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 17058 AND p.composer_id = 301 AND part.part_key = 'musicbrainz:ae539e1c-42aa-438a-aea8-e6203d382f17' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:ae539e1c-42aa-438a-aea8-e6203d382f17', 4, 'IV', 'The Lady-In-Waiting (Miss Musgrave''s Fancy)', 'Eight Songs for a Mad King, op. 39: IV. The Lady-In-Waiting (Miss Musgrave''s Fancy)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 17058 AND p.composer_id = 301
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:ae539e1c-42aa-438a-aea8-e6203d382f17'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 5, part.movement_number = 'V',
    part.name_ko = 'To Be Sung on the Water (The Waterman)', part.name_en = 'Eight Songs for a Mad King, op. 39: V. To Be Sung on the Water (The Waterman)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 17058 AND p.composer_id = 301 AND part.part_key = 'musicbrainz:f6dd6f15-9427-43c2-83e3-22a3f4cc4e3a' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:f6dd6f15-9427-43c2-83e3-22a3f4cc4e3a', 5, 'V', 'To Be Sung on the Water (The Waterman)', 'Eight Songs for a Mad King, op. 39: V. To Be Sung on the Water (The Waterman)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 17058 AND p.composer_id = 301
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:f6dd6f15-9427-43c2-83e3-22a3f4cc4e3a'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 6, part.movement_number = 'VI',
    part.name_ko = 'The Phantom Queen (He''s Ay A-Kissing Me)', part.name_en = 'Eight Songs for a Mad King, op. 39: VI. The Phantom Queen (He''s Ay A-Kissing Me)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 17058 AND p.composer_id = 301 AND part.part_key = 'musicbrainz:fc9e5487-c223-48c3-b395-17f9ec6d920c' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:fc9e5487-c223-48c3-b395-17f9ec6d920c', 6, 'VI', 'The Phantom Queen (He''s Ay A-Kissing Me)', 'Eight Songs for a Mad King, op. 39: VI. The Phantom Queen (He''s Ay A-Kissing Me)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 17058 AND p.composer_id = 301
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:fc9e5487-c223-48c3-b395-17f9ec6d920c'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 7, part.movement_number = 'VII',
    part.name_ko = 'The Counterfeit (Le Conterfaite)', part.name_en = 'Eight Songs for a Mad King, op. 39: VII. The Counterfeit (Le Conterfaite)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 17058 AND p.composer_id = 301 AND part.part_key = 'musicbrainz:316608d8-f6a4-4bc1-ba0b-0e6fd784c091' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:316608d8-f6a4-4bc1-ba0b-0e6fd784c091', 7, 'VII', 'The Counterfeit (Le Conterfaite)', 'Eight Songs for a Mad King, op. 39: VII. The Counterfeit (Le Conterfaite)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 17058 AND p.composer_id = 301
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:316608d8-f6a4-4bc1-ba0b-0e6fd784c091'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 8, part.movement_number = 'VIII',
    part.name_ko = 'The Review (A Spanish March)', part.name_en = 'Eight Songs for a Mad King, op. 39: VIII. The Review (A Spanish March)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 17058 AND p.composer_id = 301 AND part.part_key = 'musicbrainz:edfc301b-d867-4f16-b23d-550bc5592426' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:edfc301b-d867-4f16-b23d-550bc5592426', 8, 'VIII', 'The Review (A Spanish March)', 'Eight Songs for a Mad King, op. 39: VIII. The Review (A Spanish March)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 17058 AND p.composer_id = 301
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:edfc301b-d867-4f16-b23d-550bc5592426'
);


-- None Fanfare Salute to Dennis Brain

UPDATE pieces piece
SET piece.title = 'Fanfare Salute to Dennis Brain', piece.title_en = 'Fanfare Salute to Dennis Brain',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 19747 AND piece.composer_id = 301
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- Op. 89 No. 1 Farewell to Stromness

UPDATE pieces piece
SET piece.title = 'Farewell to Stromness', piece.title_en = 'Farewell to Stromness, op. 89 no. 1',
    piece.type = 'song', piece.opus_number = 'Op. 89 No. 1',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 26018 AND piece.composer_id = 301
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- Op. 19 First Fantasia on an In Nomine of John Taverner

UPDATE pieces piece
SET piece.title = 'First Fantasia on an In Nomine of John Taverner', piece.title_en = 'First Fantasia on an In Nomine of John Taverner, op. 19',
    piece.type = 'song', piece.opus_number = 'Op. 19',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 16493 AND piece.composer_id = 301
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- Op. 12 Five Klee Pictures

UPDATE pieces piece
SET piece.title = 'Five Klee Pictures', piece.title_en = 'Five Klee Pictures, op. 12',
    piece.type = 'album', piece.opus_number = 'Op. 12',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 16772 AND piece.composer_id = 301
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'A Crusader', part.name_en = 'Five Klee Pictures, op. 12: I. A Crusader',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 16772 AND p.composer_id = 301 AND part.part_key = 'musicbrainz:211e8dff-54b9-4cde-b6db-bdfbcac4225d' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:211e8dff-54b9-4cde-b6db-bdfbcac4225d', 1, 'I', 'A Crusader', 'Five Klee Pictures, op. 12: I. A Crusader', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 16772 AND p.composer_id = 301
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:211e8dff-54b9-4cde-b6db-bdfbcac4225d'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'Oriental Garden', part.name_en = 'Five Klee Pictures, op. 12: II. Oriental Garden',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 16772 AND p.composer_id = 301 AND part.part_key = 'musicbrainz:42b325f0-d95b-46a5-98cb-394a4dc876d6' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:42b325f0-d95b-46a5-98cb-394a4dc876d6', 2, 'II', 'Oriental Garden', 'Five Klee Pictures, op. 12: II. Oriental Garden', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 16772 AND p.composer_id = 301
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:42b325f0-d95b-46a5-98cb-394a4dc876d6'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = 'The Twittering Machine', part.name_en = 'Five Klee Pictures, op. 12: III. The Twittering Machine',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 16772 AND p.composer_id = 301 AND part.part_key = 'musicbrainz:353290ae-5def-4a19-b0ea-64e8b9dc0fc9' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:353290ae-5def-4a19-b0ea-64e8b9dc0fc9', 3, 'III', 'The Twittering Machine', 'Five Klee Pictures, op. 12: III. The Twittering Machine', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 16772 AND p.composer_id = 301
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:353290ae-5def-4a19-b0ea-64e8b9dc0fc9'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = 'IV',
    part.name_ko = 'Stained-Glass Saint', part.name_en = 'Five Klee Pictures, op. 12: IV. Stained-Glass Saint',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 16772 AND p.composer_id = 301 AND part.part_key = 'musicbrainz:48ceab98-0ddc-46f6-a92d-2506d2a943f7' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:48ceab98-0ddc-46f6-a92d-2506d2a943f7', 4, 'IV', 'Stained-Glass Saint', 'Five Klee Pictures, op. 12: IV. Stained-Glass Saint', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 16772 AND p.composer_id = 301
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:48ceab98-0ddc-46f6-a92d-2506d2a943f7'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 5, part.movement_number = 'V',
    part.name_ko = 'Ad Parnassum', part.name_en = 'Five Klee Pictures, op. 12: V. Ad Parnassum',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 16772 AND p.composer_id = 301 AND part.part_key = 'musicbrainz:c3854ad7-1bff-4387-b1da-80761928e7fe' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:c3854ad7-1bff-4387-b1da-80761928e7fe', 5, 'V', 'Ad Parnassum', 'Five Klee Pictures, op. 12: V. Ad Parnassum', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 16772 AND p.composer_id = 301
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:c3854ad7-1bff-4387-b1da-80761928e7fe'
);


-- Op. 2 5개의 소품

UPDATE pieces piece
SET piece.title = '5개의 소품', piece.title_en = 'Five Pieces, op. 2',
    piece.type = 'album', piece.opus_number = 'Op. 2',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 17562 AND piece.composer_id = 301
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'Andante', part.name_en = 'Five Pieces, op. 2: I. Andante',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 17562 AND p.composer_id = 301 AND part.part_key = 'musicbrainz:0706cef2-9cd6-414f-b6da-d80ffc069558' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:0706cef2-9cd6-414f-b6da-d80ffc069558', 1, 'I', 'Andante', 'Five Pieces, op. 2: I. Andante', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 17562 AND p.composer_id = 301
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:0706cef2-9cd6-414f-b6da-d80ffc069558'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'Allegro', part.name_en = 'Five Pieces, op. 2: II. Allegro',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 17562 AND p.composer_id = 301 AND part.part_key = 'musicbrainz:5d7e79d9-92e9-4a2a-a2f6-23dec53fb985' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:5d7e79d9-92e9-4a2a-a2f6-23dec53fb985', 2, 'II', 'Allegro', 'Five Pieces, op. 2: II. Allegro', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 17562 AND p.composer_id = 301
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:5d7e79d9-92e9-4a2a-a2f6-23dec53fb985'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = 'Andante', part.name_en = 'Five Pieces, op. 2: III. Andante',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 17562 AND p.composer_id = 301 AND part.part_key = 'musicbrainz:8f7864cc-b481-4307-9177-4497b7938ad0' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:8f7864cc-b481-4307-9177-4497b7938ad0', 3, 'III', 'Andante', 'Five Pieces, op. 2: III. Andante', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 17562 AND p.composer_id = 301
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:8f7864cc-b481-4307-9177-4497b7938ad0'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = 'IV',
    part.name_ko = 'Adagio non troppo', part.name_en = 'Five Pieces, op. 2: IV. Adagio non troppo',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 17562 AND p.composer_id = 301 AND part.part_key = 'musicbrainz:d239a6ad-e15b-4d14-80e3-894b5029a2d8' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:d239a6ad-e15b-4d14-80e3-894b5029a2d8', 4, 'IV', 'Adagio non troppo', 'Five Pieces, op. 2: IV. Adagio non troppo', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 17562 AND p.composer_id = 301
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:d239a6ad-e15b-4d14-80e3-894b5029a2d8'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 5, part.movement_number = 'V',
    part.name_ko = 'Allegretto', part.name_en = 'Five Pieces, op. 2: V. Allegretto',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 17562 AND p.composer_id = 301 AND part.part_key = 'musicbrainz:63d14a74-53b9-4443-ad72-f0ba12757df3' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:63d14a74-53b9-4443-ad72-f0ba12757df3', 5, 'V', 'Allegretto', 'Five Pieces, op. 2: V. Allegretto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 17562 AND p.composer_id = 301
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:63d14a74-53b9-4443-ad72-f0ba12757df3'
);


-- None 가곡 <Fleecy Care Carol>

UPDATE pieces piece
SET piece.title = '가곡 <Fleecy Care Carol>', piece.title_en = 'Fleecy Care Carol',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 19680 AND piece.composer_id = 301
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- Op. 47 From Stone to Thorn

UPDATE pieces piece
SET piece.title = 'From Stone to Thorn', piece.title_en = 'From Stone to Thorn, op. 47',
    piece.type = 'song', piece.opus_number = 'Op. 47',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 19019 AND piece.composer_id = 301
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None 가곡 <Gray’s Pier>

UPDATE pieces piece
SET piece.title = '가곡 <Gray’s Pier>', piece.title_en = 'Gray’s Pier',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 16152 AND piece.composer_id = 301
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- Op. 117 기타 소나타

UPDATE pieces piece
SET piece.title = '기타 소나타', piece.title_en = 'Guitar Sonata, op. 117',
    piece.type = 'album', piece.opus_number = 'Op. 117',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 17183 AND piece.composer_id = 301
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'Andante, recitando - Allegro moderato', part.name_en = 'Guitar Sonata, op. 117: I. Andante, recitando - Allegro moderato',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 17183 AND p.composer_id = 301 AND part.part_key = 'musicbrainz:f82d1be8-9e8b-425f-a041-f110bf9b4f55' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:f82d1be8-9e8b-425f-a041-f110bf9b4f55', 1, 'I', 'Andante, recitando - Allegro moderato', 'Guitar Sonata, op. 117: I. Andante, recitando - Allegro moderato', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 17183 AND p.composer_id = 301
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:f82d1be8-9e8b-425f-a041-f110bf9b4f55'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'Lento', part.name_en = 'Guitar Sonata, op. 117: II. Lento',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 17183 AND p.composer_id = 301 AND part.part_key = 'musicbrainz:b605f027-7add-42ac-b130-377548f46c4a' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:b605f027-7add-42ac-b130-377548f46c4a', 2, 'II', 'Lento', 'Guitar Sonata, op. 117: II. Lento', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 17183 AND p.composer_id = 301
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:b605f027-7add-42ac-b130-377548f46c4a'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = 'Allegro', part.name_en = 'Guitar Sonata, op. 117: III. Allegro',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 17183 AND p.composer_id = 301 AND part.part_key = 'musicbrainz:8f7045bd-1940-4811-b63b-055f383e3d09' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:8f7045bd-1940-4811-b63b-055f383e3d09', 3, 'III', 'Allegro', 'Guitar Sonata, op. 117: III. Allegro', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 17183 AND p.composer_id = 301
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:8f7045bd-1940-4811-b63b-055f383e3d09'
);


-- Op. 96 Hill Runes

UPDATE pieces piece
SET piece.title = 'Hill Runes', piece.title_en = 'Hill Runes, op. 96',
    piece.type = 'album', piece.opus_number = 'Op. 96',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 19229 AND piece.composer_id = 301
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'II',
    part.name_ko = 'Allegro (With Several Changes of Tempo)', part.name_en = 'Hill Runes: II. Allegro (With Several Changes of Tempo)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 19229 AND p.composer_id = 301 AND part.part_key = 'musicbrainz:2e3ecd97-80ed-4d19-8fc0-b2b7601dff5d' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:2e3ecd97-80ed-4d19-8fc0-b2b7601dff5d', 1, 'II', 'Allegro (With Several Changes of Tempo)', 'Hill Runes: II. Allegro (With Several Changes of Tempo)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 19229 AND p.composer_id = 301
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:2e3ecd97-80ed-4d19-8fc0-b2b7601dff5d'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'IV',
    part.name_ko = 'Adagio molto', part.name_en = 'Hill Runes: IV. Adagio molto',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 19229 AND p.composer_id = 301 AND part.part_key = 'musicbrainz:3d01c178-ad8e-43b9-aa4c-f97c55a10532' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:3d01c178-ad8e-43b9-aa4c-f97c55a10532', 2, 'IV', 'Adagio molto', 'Hill Runes: IV. Adagio molto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 19229 AND p.composer_id = 301
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:3d01c178-ad8e-43b9-aa4c-f97c55a10532'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = 'Vivace scherzando', part.name_en = 'Hill Runes: III. Vivace scherzando',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 19229 AND p.composer_id = 301 AND part.part_key = 'musicbrainz:66cadb5d-9f20-4e58-a140-e7b6ec9c59fd' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:66cadb5d-9f20-4e58-a140-e7b6ec9c59fd', 3, 'III', 'Vivace scherzando', 'Hill Runes: III. Vivace scherzando', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 19229 AND p.composer_id = 301
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:66cadb5d-9f20-4e58-a140-e7b6ec9c59fd'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = 'V',
    part.name_ko = 'Allegro (Dying Away into "Endless" Silence)', part.name_en = 'Hill Runes: V. Allegro (Dying Away into "Endless" Silence)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 19229 AND p.composer_id = 301 AND part.part_key = 'musicbrainz:bc0e6f53-c248-4bdc-b04e-9ce2483089b9' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:bc0e6f53-c248-4bdc-b04e-9ce2483089b9', 4, 'V', 'Allegro (Dying Away into "Endless" Silence)', 'Hill Runes: V. Allegro (Dying Away into "Endless" Silence)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 19229 AND p.composer_id = 301
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:bc0e6f53-c248-4bdc-b04e-9ce2483089b9'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 5, part.movement_number = 'I',
    part.name_ko = 'Adagio (Allegro moderato)', part.name_en = 'Hill Runes: I. Adagio (Allegro moderato)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 19229 AND p.composer_id = 301 AND part.part_key = 'musicbrainz:ebef215e-0688-4839-9e0e-b304b5163230' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:ebef215e-0688-4839-9e0e-b304b5163230', 5, 'I', 'Adagio (Allegro moderato)', 'Hill Runes: I. Adagio (Allegro moderato)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 19229 AND p.composer_id = 301
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:ebef215e-0688-4839-9e0e-b304b5163230'
);


-- Op. 125 연가곡집 <House of Winter>

UPDATE pieces piece
SET piece.title = '연가곡집 <House of Winter>', piece.title_en = 'House of Winter, op. 125',
    piece.type = 'song', piece.opus_number = 'Op. 125',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 17090 AND piece.composer_id = 301
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- Op. 53 Hymn to St. Magnus

UPDATE pieces piece
SET piece.title = 'Hymn to St. Magnus', piece.title_en = 'Hymn to St. Magnus, op. 53',
    piece.type = 'song', piece.opus_number = 'Op. 53',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 18069 AND piece.composer_id = 301
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Hymn to the Word of God

UPDATE pieces piece
SET piece.title = 'Hymn to the Word of God', piece.title_en = 'Hymn to the Word of God',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 18785 AND piece.composer_id = 301
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- Op. 35 Hymnos

UPDATE pieces piece
SET piece.title = 'Hymnos', piece.title_en = 'Hymnos, op. 35',
    piece.type = 'song', piece.opus_number = 'Op. 35',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 17305 AND piece.composer_id = 301
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- Op. 186 Il rozzo martello

UPDATE pieces piece
SET piece.title = 'Il rozzo martello', piece.title_en = 'Il rozzo martello, op. 186',
    piece.type = 'song', piece.opus_number = 'Op. 186',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 17354 AND piece.composer_id = 301
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- Op. 111 칸타타 <Into the Labyrinth>

UPDATE pieces piece
SET piece.title = '칸타타 <Into the Labyrinth>', piece.title_en = 'Into the Labyrinth, op. 111',
    piece.type = 'song', piece.opus_number = 'Op. 111',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 16260 AND piece.composer_id = 301
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- Op. 124 Jimmack the Postie

UPDATE pieces piece
SET piece.title = 'Jimmack the Postie', piece.title_en = 'Jimmack the Postie, op. 124',
    piece.type = 'song', piece.opus_number = 'Op. 124',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 17271 AND piece.composer_id = 301
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None 오라토리오 <Job: An Oratorio>

UPDATE pieces piece
SET piece.title = '오라토리오 <Job: An Oratorio>', piece.title_en = 'Job: An Oratorio',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 17871 AND piece.composer_id = 301
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'Prologue', part.name_en = 'Part One: Prologue',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 17871 AND p.composer_id = 301 AND part.part_key = 'musicbrainz:e636d91f-8d79-41eb-b946-8432e3111640' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:e636d91f-8d79-41eb-b946-8432e3111640', 1, NULL, 'Prologue', 'Part One: Prologue', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 17871 AND p.composer_id = 301
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:e636d91f-8d79-41eb-b946-8432e3111640'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:e636d91f-8d79-41eb-b946-8432e3111640'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = '''Every Year, Job''s Sons And Daughters Feasted Together'' [Chorus]', part.name_en = '''Every Year, Job''s Sons And Daughters Feasted Together'' [Chorus]',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 17871 AND p.composer_id = 301 AND part.part_key = 'musicbrainz:92971f89-ebf3-4e55-a61a-17001e4d1f5c' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:92971f89-ebf3-4e55-a61a-17001e4d1f5c', 1, NULL, '''Every Year, Job''s Sons And Daughters Feasted Together'' [Chorus]', '''Every Year, Job''s Sons And Daughters Feasted Together'' [Chorus]', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:e636d91f-8d79-41eb-b946-8432e3111640'
WHERE p.id = 17871 AND p.composer_id = 301
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:92971f89-ebf3-4e55-a61a-17001e4d1f5c'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:e636d91f-8d79-41eb-b946-8432e3111640'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = '''Naked I Came From My Mother''s Womb'' [Job]', part.name_en = '''Naked I Came From My Mother''s Womb'' [Job]',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 17871 AND p.composer_id = 301 AND part.part_key = 'musicbrainz:b5720a79-c62e-44ed-8b0f-b7f8619cb0b0' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:b5720a79-c62e-44ed-8b0f-b7f8619cb0b0', 2, NULL, '''Naked I Came From My Mother''s Womb'' [Job]', '''Naked I Came From My Mother''s Womb'' [Job]', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:e636d91f-8d79-41eb-b946-8432e3111640'
WHERE p.id = 17871 AND p.composer_id = 301
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:b5720a79-c62e-44ed-8b0f-b7f8619cb0b0'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:e636d91f-8d79-41eb-b946-8432e3111640'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = NULL,
    part.name_ko = '''God Damn The Day I Was Born'' [Job]', part.name_en = '''God Damn The Day I Was Born'' [Job]',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 17871 AND p.composer_id = 301 AND part.part_key = 'musicbrainz:00c04d6b-db52-472a-bb07-ae57c043dafa' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:00c04d6b-db52-472a-bb07-ae57c043dafa', 3, NULL, '''God Damn The Day I Was Born'' [Job]', '''God Damn The Day I Was Born'' [Job]', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:e636d91f-8d79-41eb-b946-8432e3111640'
WHERE p.id = 17871 AND p.composer_id = 301
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:00c04d6b-db52-472a-bb07-ae57c043dafa'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'Adagio Non Troppo', part.name_en = 'First Round: Adagio Non Troppo',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 17871 AND p.composer_id = 301 AND part.part_key = 'musicbrainz:cc13e842-0883-49ae-901a-8ac12b0d38ab' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:cc13e842-0883-49ae-901a-8ac12b0d38ab', 2, NULL, 'Adagio Non Troppo', 'First Round: Adagio Non Troppo', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 17871 AND p.composer_id = 301
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:cc13e842-0883-49ae-901a-8ac12b0d38ab'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:cc13e842-0883-49ae-901a-8ac12b0d38ab'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = '''Have You Lost All Faith In Your Piety'' [Friend]', part.name_en = '''Have You Lost All Faith In Your Piety'' [Friend]',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 17871 AND p.composer_id = 301 AND part.part_key = 'musicbrainz:ef9f80a3-e7c2-449b-8c70-c5ab172e0a70' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:ef9f80a3-e7c2-449b-8c70-c5ab172e0a70', 1, NULL, '''Have You Lost All Faith In Your Piety'' [Friend]', '''Have You Lost All Faith In Your Piety'' [Friend]', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:cc13e842-0883-49ae-901a-8ac12b0d38ab'
WHERE p.id = 17871 AND p.composer_id = 301
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:ef9f80a3-e7c2-449b-8c70-c5ab172e0a70'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = NULL,
    part.name_ko = 'Second Round', part.name_en = 'Part Two: Second Round',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 17871 AND p.composer_id = 301 AND part.part_key = 'musicbrainz:f58902c7-ea4c-4291-8db2-814568436736' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:f58902c7-ea4c-4291-8db2-814568436736', 3, NULL, 'Second Round', 'Part Two: Second Round', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 17871 AND p.composer_id = 301
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:f58902c7-ea4c-4291-8db2-814568436736'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:f58902c7-ea4c-4291-8db2-814568436736'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = '''Go Learn From The Wisdom Of The Ages'' [Friend]', part.name_en = '''Go Learn From The Wisdom Of The Ages'' [Friend]',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 17871 AND p.composer_id = 301 AND part.part_key = 'musicbrainz:3ac7747f-546b-46eb-a76f-49923862fb90' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:3ac7747f-546b-46eb-a76f-49923862fb90', 1, NULL, '''Go Learn From The Wisdom Of The Ages'' [Friend]', '''Go Learn From The Wisdom Of The Ages'' [Friend]', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:f58902c7-ea4c-4291-8db2-814568436736'
WHERE p.id = 17871 AND p.composer_id = 301
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:3ac7747f-546b-46eb-a76f-49923862fb90'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:f58902c7-ea4c-4291-8db2-814568436736'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = '''How Then Can I Refute Him'' [Job]', part.name_en = '''How Then Can I Refute Him'' [Job]',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 17871 AND p.composer_id = 301 AND part.part_key = 'musicbrainz:3340e2c9-2761-42d9-b213-22b953b6c574' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:3340e2c9-2761-42d9-b213-22b953b6c574', 2, NULL, '''How Then Can I Refute Him'' [Job]', '''How Then Can I Refute Him'' [Job]', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:f58902c7-ea4c-4291-8db2-814568436736'
WHERE p.id = 17871 AND p.composer_id = 301
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:3340e2c9-2761-42d9-b213-22b953b6c574'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:f58902c7-ea4c-4291-8db2-814568436736'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = NULL,
    part.name_ko = '''As I Walked To The Square Of The City'' [Job]', part.name_en = '''As I Walked To The Square Of The City'' [Job]',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 17871 AND p.composer_id = 301 AND part.part_key = 'musicbrainz:b62d7871-efe5-4205-944a-747915ccf812' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:b62d7871-efe5-4205-944a-747915ccf812', 3, NULL, '''As I Walked To The Square Of The City'' [Job]', '''As I Walked To The Square Of The City'' [Job]', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:f58902c7-ea4c-4291-8db2-814568436736'
WHERE p.id = 17871 AND p.composer_id = 301
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:b62d7871-efe5-4205-944a-747915ccf812'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:f58902c7-ea4c-4291-8db2-814568436736'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = NULL,
    part.name_ko = '''They Listened To Me In Silence'' [Job]', part.name_en = '''They Listened To Me In Silence'' [Job]',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 17871 AND p.composer_id = 301 AND part.part_key = 'musicbrainz:e4e64efd-f3ae-4293-8eba-3f6bb754163b' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:e4e64efd-f3ae-4293-8eba-3f6bb754163b', 4, NULL, '''They Listened To Me In Silence'' [Job]', '''They Listened To Me In Silence'' [Job]', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:f58902c7-ea4c-4291-8db2-814568436736'
WHERE p.id = 17871 AND p.composer_id = 301
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:e4e64efd-f3ae-4293-8eba-3f6bb754163b'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = NULL,
    part.name_ko = 'Third Round', part.name_en = 'Part Three: Third Round',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 17871 AND p.composer_id = 301 AND part.part_key = 'musicbrainz:4ce40edc-6eac-4e34-9639-045412fd8205' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:4ce40edc-6eac-4e34-9639-045412fd8205', 4, NULL, 'Third Round', 'Part Three: Third Round', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 17871 AND p.composer_id = 301
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:4ce40edc-6eac-4e34-9639-045412fd8205'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:4ce40edc-6eac-4e34-9639-045412fd8205'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = '''How Can A Man Be Pure'' [Friend]', part.name_en = '''How Can A Man Be Pure'' [Friend]',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 17871 AND p.composer_id = 301 AND part.part_key = 'musicbrainz:619b9fb9-8082-4e4a-9e13-07d73b76b63e' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:619b9fb9-8082-4e4a-9e13-07d73b76b63e', 1, NULL, '''How Can A Man Be Pure'' [Friend]', '''How Can A Man Be Pure'' [Friend]', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:4ce40edc-6eac-4e34-9639-045412fd8205'
WHERE p.id = 17871 AND p.composer_id = 301
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:619b9fb9-8082-4e4a-9e13-07d73b76b63e'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 5, part.movement_number = NULL,
    part.name_ko = 'Lento', part.name_en = 'The Unnamable: Lento',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 17871 AND p.composer_id = 301 AND part.part_key = 'musicbrainz:73cd2fd7-242e-4146-829f-c5460d75ca29' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:73cd2fd7-242e-4146-829f-c5460d75ca29', 5, NULL, 'Lento', 'The Unnamable: Lento', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 17871 AND p.composer_id = 301
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:73cd2fd7-242e-4146-829f-c5460d75ca29'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:73cd2fd7-242e-4146-829f-c5460d75ca29'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = '''Who Is This Whose Ignorant Words'' [Chorus]', part.name_en = '''Who Is This Whose Ignorant Words'' [Chorus]',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 17871 AND p.composer_id = 301 AND part.part_key = 'musicbrainz:a42a70f7-9836-4889-a70d-c018924003fb' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:a42a70f7-9836-4889-a70d-c018924003fb', 1, NULL, '''Who Is This Whose Ignorant Words'' [Chorus]', '''Who Is This Whose Ignorant Words'' [Chorus]', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:73cd2fd7-242e-4146-829f-c5460d75ca29'
WHERE p.id = 17871 AND p.composer_id = 301
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:a42a70f7-9836-4889-a70d-c018924003fb'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:73cd2fd7-242e-4146-829f-c5460d75ca29'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = '''I Know You Can Do All Things'' [Job]', part.name_en = '''I Know You Can Do All Things'' [Job]',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 17871 AND p.composer_id = 301 AND part.part_key = 'musicbrainz:3e541e13-abb8-4bea-9a98-69ad63c589c3' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:3e541e13-abb8-4bea-9a98-69ad63c589c3', 2, NULL, '''I Know You Can Do All Things'' [Job]', '''I Know You Can Do All Things'' [Job]', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:73cd2fd7-242e-4146-829f-c5460d75ca29'
WHERE p.id = 17871 AND p.composer_id = 301
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:3e541e13-abb8-4bea-9a98-69ad63c589c3'
);


-- Op. 256 No. 5 Kings and Shepherds

UPDATE pieces piece
SET piece.title = 'Kings and Shepherds', piece.title_en = 'Kings and Shepherds, op. 256 no. 5',
    piece.type = 'song', piece.opus_number = 'Op. 256 No. 5',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 19405 AND piece.composer_id = 301
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- Op. 293 Last Door of Light

UPDATE pieces piece
SET piece.title = 'Last Door of Light', piece.title_en = 'Last Door of Light, op. 293',
    piece.type = 'song', piece.opus_number = 'Op. 293',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 19789 AND piece.composer_id = 301
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- Op. 18 Leopardi Fragments

UPDATE pieces piece
SET piece.title = 'Leopardi Fragments', piece.title_en = 'Leopardi Fragments, op. 18',
    piece.type = 'song', piece.opus_number = 'Op. 18',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 19295 AND piece.composer_id = 301
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- Op. 223 Linguae ignis

UPDATE pieces piece
SET piece.title = 'Linguae ignis', piece.title_en = 'Linguae ignis, op. 223',
    piece.type = 'song', piece.opus_number = 'Op. 223',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 16394 AND piece.composer_id = 301
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- Op. 77 No. 1 Little Quartet no. 1

UPDATE pieces piece
SET piece.title = 'Little Quartet no. 1', piece.title_en = 'Little Quartet no. 1, op. 77 no. 1',
    piece.type = 'song', piece.opus_number = 'Op. 77 No. 1',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 16594 AND piece.composer_id = 301
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- Op. 77 No. 2 Little Quartet no. 2

UPDATE pieces piece
SET piece.title = 'Little Quartet no. 2', piece.title_en = 'Little Quartet no. 2, op. 77 no. 2',
    piece.type = 'song', piece.opus_number = 'Op. 77 No. 2',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 19048 AND piece.composer_id = 301
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Lullaby for Violin and Cello

UPDATE pieces piece
SET piece.title = 'Lullaby for Violin and Cello', piece.title_en = 'Lullaby for Violin and Cello',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 18374 AND piece.composer_id = 301
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- Op. 99 가곡 <Lullabye for Lucy>

UPDATE pieces piece
SET piece.title = '가곡 <Lullabye for Lucy>', piece.title_en = 'Lullabye for Lucy, op. 99',
    piece.type = 'song', piece.opus_number = 'Op. 99',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 18867 AND piece.composer_id = 301
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- Op. 226 미사

UPDATE pieces piece
SET piece.title = '미사', piece.title_en = 'Mass, op. 226',
    piece.type = 'album', piece.opus_number = 'Op. 226',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 19014 AND piece.composer_id = 301
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'Kyrie', part.name_en = 'Mass, op. 226: I. Kyrie',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 19014 AND p.composer_id = 301 AND part.part_key = 'musicbrainz:6e22d356-5501-4945-8f60-ab3718be34ef' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:6e22d356-5501-4945-8f60-ab3718be34ef', 1, 'I', 'Kyrie', 'Mass, op. 226: I. Kyrie', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 19014 AND p.composer_id = 301
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:6e22d356-5501-4945-8f60-ab3718be34ef'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'Gloria', part.name_en = 'Mass, op. 226: II. Gloria',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 19014 AND p.composer_id = 301 AND part.part_key = 'musicbrainz:13fd76bf-2974-4a37-ae32-f31ba7721f42' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:13fd76bf-2974-4a37-ae32-f31ba7721f42', 2, 'II', 'Gloria', 'Mass, op. 226: II. Gloria', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 19014 AND p.composer_id = 301
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:13fd76bf-2974-4a37-ae32-f31ba7721f42'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = 'Credo', part.name_en = 'Mass, op. 226: III. Credo',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 19014 AND p.composer_id = 301 AND part.part_key = 'musicbrainz:e9cf497e-b2a1-4523-b7a0-20fac8293c9b' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:e9cf497e-b2a1-4523-b7a0-20fac8293c9b', 3, 'III', 'Credo', 'Mass, op. 226: III. Credo', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 19014 AND p.composer_id = 301
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:e9cf497e-b2a1-4523-b7a0-20fac8293c9b'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = 'IV',
    part.name_ko = 'Sanctus & Benedictus', part.name_en = 'Mass, op. 226: IV. Sanctus & Benedictus',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 19014 AND p.composer_id = 301 AND part.part_key = 'musicbrainz:7fee15b1-5510-4992-884e-1076bfaae395' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:7fee15b1-5510-4992-884e-1076bfaae395', 4, 'IV', 'Sanctus & Benedictus', 'Mass, op. 226: IV. Sanctus & Benedictus', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 19014 AND p.composer_id = 301
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:7fee15b1-5510-4992-884e-1076bfaae395'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 5, part.movement_number = 'V',
    part.name_ko = 'Agnus Dei', part.name_en = 'Mass, op. 226: V. Agnus Dei',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 19014 AND p.composer_id = 301 AND part.part_key = 'musicbrainz:8f4e8de4-e604-4665-b83f-9f9e19bd036f' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:8f4e8de4-e604-4665-b83f-9f9e19bd036f', 5, 'V', 'Agnus Dei', 'Mass, op. 226: V. Agnus Dei', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 19014 AND p.composer_id = 301
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:8f4e8de4-e604-4665-b83f-9f9e19bd036f'
);


-- Op. 184 Mavis in Las Vegas

UPDATE pieces piece
SET piece.title = 'Mavis in Las Vegas', piece.title_en = 'Mavis in Las Vegas, op. 184',
    piece.type = 'song', piece.opus_number = 'Op. 184',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 17435 AND piece.composer_id = 301
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- Op. 191 Maxwell's Reel, With Northern Lights

UPDATE pieces piece
SET piece.title = 'Maxwell''s Reel, With Northern Lights', piece.title_en = 'Maxwell''s Reel, With Northern Lights, op. 191',
    piece.type = 'song', piece.opus_number = 'Op. 191',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 16090 AND piece.composer_id = 301
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- Op. 180a Midhouse Air

UPDATE pieces piece
SET piece.title = 'Midhouse Air', piece.title_en = 'Midhouse Air, op. 180a',
    piece.type = 'song', piece.opus_number = 'Op. 180a',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 19815 AND piece.composer_id = 301
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- Op. 60 Miss Donnithorne's Maggot

UPDATE pieces piece
SET piece.title = 'Miss Donnithorne''s Maggot', piece.title_en = 'Miss Donnithorne''s Maggot, op. 60',
    piece.type = 'song', piece.opus_number = 'Op. 60',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 17956 AND piece.composer_id = 301
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- Op. 233 Missa parvula

UPDATE pieces piece
SET piece.title = 'Missa parvula', piece.title_en = 'Missa parvula, op. 233',
    piece.type = 'album', piece.opus_number = 'Op. 233',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 19849 AND piece.composer_id = 301
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'Kyrie', part.name_en = 'Missa parvula, op. 233: I. Kyrie',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 19849 AND p.composer_id = 301 AND part.part_key = 'musicbrainz:b970f8f7-2c2b-4562-8312-41211c6f9be1' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:b970f8f7-2c2b-4562-8312-41211c6f9be1', 1, 'I', 'Kyrie', 'Missa parvula, op. 233: I. Kyrie', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 19849 AND p.composer_id = 301
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:b970f8f7-2c2b-4562-8312-41211c6f9be1'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'Gloria', part.name_en = 'Missa parvula, op. 233: II. Gloria',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 19849 AND p.composer_id = 301 AND part.part_key = 'musicbrainz:efa13f69-ee2a-43ba-85cc-881f02b3831c' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:efa13f69-ee2a-43ba-85cc-881f02b3831c', 2, 'II', 'Gloria', 'Missa parvula, op. 233: II. Gloria', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 19849 AND p.composer_id = 301
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:efa13f69-ee2a-43ba-85cc-881f02b3831c'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = 'Credo', part.name_en = 'Missa parvula, op. 233: III. Credo',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 19849 AND p.composer_id = 301 AND part.part_key = 'musicbrainz:1a180ea5-64b2-443c-b134-17cf36c71794' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:1a180ea5-64b2-443c-b134-17cf36c71794', 3, 'III', 'Credo', 'Missa parvula, op. 233: III. Credo', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 19849 AND p.composer_id = 301
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:1a180ea5-64b2-443c-b134-17cf36c71794'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = 'IV',
    part.name_ko = 'Sanctus & Benedictus', part.name_en = 'Missa parvula, op. 233: IV. Sanctus & Benedictus',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 19849 AND p.composer_id = 301 AND part.part_key = 'musicbrainz:0ee6849e-1241-4e63-b405-9cc7ab59a734' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:0ee6849e-1241-4e63-b405-9cc7ab59a734', 4, 'IV', 'Sanctus & Benedictus', 'Missa parvula, op. 233: IV. Sanctus & Benedictus', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 19849 AND p.composer_id = 301
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:0ee6849e-1241-4e63-b405-9cc7ab59a734'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 5, part.movement_number = 'V',
    part.name_ko = 'Agnus Dei', part.name_en = 'Missa parvula, op. 233: V. Agnus Dei',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 19849 AND p.composer_id = 301 AND part.part_key = 'musicbrainz:3ce7e96c-25eb-411e-af4e-72517ef61a0e' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:3ce7e96c-25eb-411e-af4e-72517ef61a0e', 5, 'V', 'Agnus Dei', 'Missa parvula, op. 233: V. Agnus Dei', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 19849 AND p.composer_id = 301
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:3ce7e96c-25eb-411e-af4e-72517ef61a0e'
);


-- Op. 36 Missa super "L'homme armé"

UPDATE pieces piece
SET piece.title = 'Missa super "L''homme armé"', piece.title_en = 'Missa super "L''homme armé", op. 36',
    piece.type = 'song', piece.opus_number = 'Op. 36',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 16916 AND piece.composer_id = 301
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- Op. 312 Musica Benevolens

UPDATE pieces piece
SET piece.title = 'Musica Benevolens', piece.title_en = 'Musica Benevolens, op. 312',
    piece.type = 'song', piece.opus_number = 'Op. 312',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 16138 AND piece.composer_id = 301
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- Op. 229 Naxos Quartet no. 1

UPDATE pieces piece
SET piece.title = 'Naxos Quartet no. 1', piece.title_en = 'Naxos Quartet no. 1, op. 229',
    piece.type = 'album', piece.opus_number = 'Op. 229',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 19874 AND piece.composer_id = 301
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'Adagio — Allegro', part.name_en = 'Naxos Quartet no. 1: I. Adagio — Allegro',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 19874 AND p.composer_id = 301 AND part.part_key = 'musicbrainz:3e58175f-d6e5-3669-a032-96fcad23375c' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:3e58175f-d6e5-3669-a032-96fcad23375c', 1, 'I', 'Adagio — Allegro', 'Naxos Quartet no. 1: I. Adagio — Allegro', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 19874 AND p.composer_id = 301
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:3e58175f-d6e5-3669-a032-96fcad23375c'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'Largo', part.name_en = 'Naxos Quartet no. 1: II. Largo',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 19874 AND p.composer_id = 301 AND part.part_key = 'musicbrainz:6c42bced-7f6f-3a6a-b7fa-8d6f15717faf' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:6c42bced-7f6f-3a6a-b7fa-8d6f15717faf', 2, 'II', 'Largo', 'Naxos Quartet no. 1: II. Largo', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 19874 AND p.composer_id = 301
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:6c42bced-7f6f-3a6a-b7fa-8d6f15717faf'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = 'Allegro molto', part.name_en = 'Naxos Quartet no. 1: III. Allegro molto',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 19874 AND p.composer_id = 301 AND part.part_key = 'musicbrainz:5c351db7-2f62-36c2-9855-be2f5a03d7c7' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:5c351db7-2f62-36c2-9855-be2f5a03d7c7', 3, 'III', 'Allegro molto', 'Naxos Quartet no. 1: III. Allegro molto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 19874 AND p.composer_id = 301
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:5c351db7-2f62-36c2-9855-be2f5a03d7c7'
);


-- Op. 234 Naxos Quartet no. 2

UPDATE pieces piece
SET piece.title = 'Naxos Quartet no. 2', piece.title_en = 'Naxos Quartet no. 2, op. 234',
    piece.type = 'album', piece.opus_number = 'Op. 234',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 18130 AND piece.composer_id = 301
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'Lento — Allegro', part.name_en = 'Naxos Quartet no. 2: I. Lento — Allegro',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 18130 AND p.composer_id = 301 AND part.part_key = 'musicbrainz:075573fb-a551-323e-9c31-88cb45955777' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:075573fb-a551-323e-9c31-88cb45955777', 1, 'I', 'Lento — Allegro', 'Naxos Quartet no. 2: I. Lento — Allegro', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 18130 AND p.composer_id = 301
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:075573fb-a551-323e-9c31-88cb45955777'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'Lento flessibile', part.name_en = 'Naxos Quartet no. 2: II. Lento flessibile',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 18130 AND p.composer_id = 301 AND part.part_key = 'musicbrainz:89fcdefb-2ecc-3e12-820b-5550c484b2e7' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:89fcdefb-2ecc-3e12-820b-5550c484b2e7', 2, 'II', 'Lento flessibile', 'Naxos Quartet no. 2: II. Lento flessibile', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 18130 AND p.composer_id = 301
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:89fcdefb-2ecc-3e12-820b-5550c484b2e7'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = 'Allegro', part.name_en = 'Naxos Quartet no. 2: III. Allegro',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 18130 AND p.composer_id = 301 AND part.part_key = 'musicbrainz:78b038fe-775b-3726-ae12-a7982bf1402e' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:78b038fe-775b-3726-ae12-a7982bf1402e', 3, 'III', 'Allegro', 'Naxos Quartet no. 2: III. Allegro', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 18130 AND p.composer_id = 301
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:78b038fe-775b-3726-ae12-a7982bf1402e'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = 'IV',
    part.name_ko = 'Lento flessibile', part.name_en = 'Naxos Quartet no. 2: IV. Lento flessibile',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 18130 AND p.composer_id = 301 AND part.part_key = 'musicbrainz:02782b96-6151-3c48-a0e1-f03ba739767c' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:02782b96-6151-3c48-a0e1-f03ba739767c', 4, 'IV', 'Lento flessibile', 'Naxos Quartet no. 2: IV. Lento flessibile', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 18130 AND p.composer_id = 301
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:02782b96-6151-3c48-a0e1-f03ba739767c'
);


-- None Naxos Quartet no. 3

UPDATE pieces piece
SET piece.title = 'Naxos Quartet no. 3', piece.title_en = 'Naxos Quartet no. 3',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 16408 AND piece.composer_id = 301
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'March', part.name_en = 'Naxos Quartet no. 3: I. March',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 16408 AND p.composer_id = 301 AND part.part_key = 'musicbrainz:cdf7e5fd-2a2d-4953-9246-4dbf55aa68bd' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:cdf7e5fd-2a2d-4953-9246-4dbf55aa68bd', 1, 'I', 'March', 'Naxos Quartet no. 3: I. March', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 16408 AND p.composer_id = 301
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:cdf7e5fd-2a2d-4953-9246-4dbf55aa68bd'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'In Nomine', part.name_en = 'Naxos Quartet no. 3: II. In Nomine',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 16408 AND p.composer_id = 301 AND part.part_key = 'musicbrainz:80f56746-b035-4dc7-9176-2ac60e95e2c9' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:80f56746-b035-4dc7-9176-2ac60e95e2c9', 2, 'II', 'In Nomine', 'Naxos Quartet no. 3: II. In Nomine', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 16408 AND p.composer_id = 301
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:80f56746-b035-4dc7-9176-2ac60e95e2c9'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = 'Four Inventions and a Hymn', part.name_en = 'Naxos Quartet no. 3: III. Four Inventions and a Hymn',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 16408 AND p.composer_id = 301 AND part.part_key = 'musicbrainz:4d826ddd-dbbd-460b-8e75-8abc962e6b70' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:4d826ddd-dbbd-460b-8e75-8abc962e6b70', 3, 'III', 'Four Inventions and a Hymn', 'Naxos Quartet no. 3: III. Four Inventions and a Hymn', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 16408 AND p.composer_id = 301
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:4d826ddd-dbbd-460b-8e75-8abc962e6b70'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = 'IV',
    part.name_ko = 'Fugue', part.name_en = 'Naxos Quartet no. 3: IV. Fugue',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 16408 AND p.composer_id = 301 AND part.part_key = 'musicbrainz:5ec527d2-5370-48a9-8b46-4e096f684752' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:5ec527d2-5370-48a9-8b46-4e096f684752', 4, 'IV', 'Fugue', 'Naxos Quartet no. 3: IV. Fugue', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 16408 AND p.composer_id = 301
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:5ec527d2-5370-48a9-8b46-4e096f684752'
);


-- None Naxos Quartet no. 4 “Children’s Games”

UPDATE pieces piece
SET piece.title = 'Naxos Quartet no. 4 “Children’s Games”', piece.title_en = 'Naxos Quartet no. 4 “Children’s Games”',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 18278 AND piece.composer_id = 301
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Naxos Quartet no. 5, op. 253 "Lighthouses of Orkney and Shetland"

UPDATE pieces piece
SET piece.title = 'Naxos Quartet no. 5, op. 253 "Lighthouses of Orkney and Shetland"', piece.title_en = 'Naxos Quartet no. 5, op. 253 "Lighthouses of Orkney and Shetland"',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 16615 AND piece.composer_id = 301
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'Largo', part.name_en = 'Naxos Quartet no. 5 "Lighthouses of Orkney and Shetland": I. Largo',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 16615 AND p.composer_id = 301 AND part.part_key = 'musicbrainz:5c7b3fee-d8af-462f-9492-07c73df57166' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:5c7b3fee-d8af-462f-9492-07c73df57166', 1, 'I', 'Largo', 'Naxos Quartet no. 5 "Lighthouses of Orkney and Shetland": I. Largo', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 16615 AND p.composer_id = 301
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:5c7b3fee-d8af-462f-9492-07c73df57166'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'Lento', part.name_en = 'Naxos Quartet no. 5 "Lighthouses of Orkney and Shetland": II. Lento',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 16615 AND p.composer_id = 301 AND part.part_key = 'musicbrainz:3a37bd13-8f64-4de4-aa35-44b61826399b' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:3a37bd13-8f64-4de4-aa35-44b61826399b', 2, 'II', 'Lento', 'Naxos Quartet no. 5 "Lighthouses of Orkney and Shetland": II. Lento', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 16615 AND p.composer_id = 301
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:3a37bd13-8f64-4de4-aa35-44b61826399b'
);


-- Op. 257 Naxos Quartet no. 6

UPDATE pieces piece
SET piece.title = 'Naxos Quartet no. 6', piece.title_en = 'Naxos Quartet no. 6, op. 257',
    piece.type = 'album', piece.opus_number = 'Op. 257',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 18396 AND piece.composer_id = 301
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'Allegro', part.name_en = 'Naxos Quartet no. 6: I. Allegro',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 18396 AND p.composer_id = 301 AND part.part_key = 'musicbrainz:1535d8cf-5d63-424f-8e19-191aa7b6c8de' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:1535d8cf-5d63-424f-8e19-191aa7b6c8de', 1, 'I', 'Allegro', 'Naxos Quartet no. 6: I. Allegro', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 18396 AND p.composer_id = 301
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:1535d8cf-5d63-424f-8e19-191aa7b6c8de'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'Allegro moderato. Dominica Tertia Adventus, Antiphona', part.name_en = 'Naxos Quartet no. 6: II. Allegro moderato. Dominica Tertia Adventus, Antiphona',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 18396 AND p.composer_id = 301 AND part.part_key = 'musicbrainz:19e31704-52ff-4f2c-b2e0-d17f9b03f92d' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:19e31704-52ff-4f2c-b2e0-d17f9b03f92d', 2, 'II', 'Allegro moderato. Dominica Tertia Adventus, Antiphona', 'Naxos Quartet no. 6: II. Allegro moderato. Dominica Tertia Adventus, Antiphona', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 18396 AND p.composer_id = 301
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:19e31704-52ff-4f2c-b2e0-d17f9b03f92d'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = 'Presto', part.name_en = 'Naxos Quartet no. 6: III. Presto',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 18396 AND p.composer_id = 301 AND part.part_key = 'musicbrainz:eeb58110-41f2-46e1-ba1d-07710a98e904' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:eeb58110-41f2-46e1-ba1d-07710a98e904', 3, 'III', 'Presto', 'Naxos Quartet no. 6: III. Presto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 18396 AND p.composer_id = 301
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:eeb58110-41f2-46e1-ba1d-07710a98e904'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = 'IV',
    part.name_ko = 'Adagio molto', part.name_en = 'Naxos Quartet no. 6: IV. Adagio molto',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 18396 AND p.composer_id = 301 AND part.part_key = 'musicbrainz:de5681a1-1bbc-4bc3-8954-a40c915d5029' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:de5681a1-1bbc-4bc3-8954-a40c915d5029', 4, 'IV', 'Adagio molto', 'Naxos Quartet no. 6: IV. Adagio molto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 18396 AND p.composer_id = 301
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:de5681a1-1bbc-4bc3-8954-a40c915d5029'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 5, part.movement_number = 'V',
    part.name_ko = 'Andante. In Die Nativitatis', part.name_en = 'Naxos Quartet no. 6: V. Andante. In Die Nativitatis',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 18396 AND p.composer_id = 301 AND part.part_key = 'musicbrainz:b3523e12-5625-4114-826d-1faa14dcf61b' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:b3523e12-5625-4114-826d-1faa14dcf61b', 5, 'V', 'Andante. In Die Nativitatis', 'Naxos Quartet no. 6: V. Andante. In Die Nativitatis', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 18396 AND p.composer_id = 301
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:b3523e12-5625-4114-826d-1faa14dcf61b'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 6, part.movement_number = 'VI',
    part.name_ko = 'Allegro', part.name_en = 'Naxos Quartet no. 6: VI. Allegro',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 18396 AND p.composer_id = 301 AND part.part_key = 'musicbrainz:3923e73b-b14e-4c66-9b88-99c756e510dd' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:3923e73b-b14e-4c66-9b88-99c756e510dd', 6, 'VI', 'Allegro', 'Naxos Quartet no. 6: VI. Allegro', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 18396 AND p.composer_id = 301
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:3923e73b-b14e-4c66-9b88-99c756e510dd'
);


-- None Naxos Quartet no. 7 "Metafore sul Borromini"

UPDATE pieces piece
SET piece.title = 'Naxos Quartet no. 7 "Metafore sul Borromini"', piece.title_en = 'Naxos Quartet no. 7 "Metafore sul Borromini"',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 17020 AND piece.composer_id = 301
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'Adagio molto: S. Carlo alle Quattro Fontane, I', part.name_en = 'Naxos Quartet no. 7 "Metafore sul Borromini": I. Adagio molto: S. Carlo alle Quattro Fontane, I',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 17020 AND p.composer_id = 301 AND part.part_key = 'musicbrainz:8fa23111-2028-4279-bbc9-78811e599695' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:8fa23111-2028-4279-bbc9-78811e599695', 1, 'I', 'Adagio molto: S. Carlo alle Quattro Fontane, I', 'Naxos Quartet no. 7 "Metafore sul Borromini": I. Adagio molto: S. Carlo alle Quattro Fontane, I', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 17020 AND p.composer_id = 301
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:8fa23111-2028-4279-bbc9-78811e599695'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'Adagio: S. Giovanni dei Fiorentini, Chiesa Inferiore', part.name_en = 'Naxos Quartet no. 7 "Metafore sul Borromini": II. Adagio: S. Giovanni dei Fiorentini, Chiesa Inferiore',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 17020 AND p.composer_id = 301 AND part.part_key = 'musicbrainz:f2a33977-8022-4532-a946-e88c66ab77ed' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:f2a33977-8022-4532-a946-e88c66ab77ed', 2, 'II', 'Adagio: S. Giovanni dei Fiorentini, Chiesa Inferiore', 'Naxos Quartet no. 7 "Metafore sul Borromini": II. Adagio: S. Giovanni dei Fiorentini, Chiesa Inferiore', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 17020 AND p.composer_id = 301
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:f2a33977-8022-4532-a946-e88c66ab77ed'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = 'Lento molto: S. Giovanni in Laterano', part.name_en = 'Naxos Quartet no. 7 "Metafore sul Borromini": III. Lento molto: S. Giovanni in Laterano',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 17020 AND p.composer_id = 301 AND part.part_key = 'musicbrainz:f262b5f1-7692-40b4-99c6-4c94e852c1a3' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:f262b5f1-7692-40b4-99c6-4c94e852c1a3', 3, 'III', 'Lento molto: S. Giovanni in Laterano', 'Naxos Quartet no. 7 "Metafore sul Borromini": III. Lento molto: S. Giovanni in Laterano', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 17020 AND p.composer_id = 301
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:f262b5f1-7692-40b4-99c6-4c94e852c1a3'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = 'IV',
    part.name_ko = 'Adagio - Oratorio dei Filippini', part.name_en = 'Naxos Quartet no. 7 "Metafore sul Borromini": IV. Adagio - Oratorio dei Filippini',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 17020 AND p.composer_id = 301 AND part.part_key = 'musicbrainz:5ebeef80-6b99-481e-ae7c-6c65319231c6' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:5ebeef80-6b99-481e-ae7c-6c65319231c6', 4, 'IV', 'Adagio - Oratorio dei Filippini', 'Naxos Quartet no. 7 "Metafore sul Borromini": IV. Adagio - Oratorio dei Filippini', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 17020 AND p.composer_id = 301
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:5ebeef80-6b99-481e-ae7c-6c65319231c6'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 5, part.movement_number = 'V',
    part.name_ko = 'Lento: S. Ivo alla Sapienza', part.name_en = 'Naxos Quartet no. 7 "Metafore sul Borromini": V. Lento: S. Ivo alla Sapienza',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 17020 AND p.composer_id = 301 AND part.part_key = 'musicbrainz:e94d5779-99cb-42e5-abb0-9c23e3322b30' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:e94d5779-99cb-42e5-abb0-9c23e3322b30', 5, 'V', 'Lento: S. Ivo alla Sapienza', 'Naxos Quartet no. 7 "Metafore sul Borromini": V. Lento: S. Ivo alla Sapienza', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 17020 AND p.composer_id = 301
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:e94d5779-99cb-42e5-abb0-9c23e3322b30'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 6, part.movement_number = 'VI',
    part.name_ko = 'Adagio: Scorsa Secolare - Palazzo Falconieri', part.name_en = 'Naxos Quartet no. 7 "Metafore sul Borromini": VI. Adagio: Scorsa Secolare - Palazzo Falconieri',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 17020 AND p.composer_id = 301 AND part.part_key = 'musicbrainz:2e1cebf0-73cb-43c3-9d4d-bdb151d9a159' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:2e1cebf0-73cb-43c3-9d4d-bdb151d9a159', 6, 'VI', 'Adagio: Scorsa Secolare - Palazzo Falconieri', 'Naxos Quartet no. 7 "Metafore sul Borromini": VI. Adagio: Scorsa Secolare - Palazzo Falconieri', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 17020 AND p.composer_id = 301
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:2e1cebf0-73cb-43c3-9d4d-bdb151d9a159'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 7, part.movement_number = 'VII',
    part.name_ko = 'Adagio: Postludio - S. Carlo alle Quattro Fontane, II', part.name_en = 'Naxos Quartet no. 7 "Metafore sul Borromini": VII. Adagio: Postludio - S. Carlo alle Quattro Fontane, II',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 17020 AND p.composer_id = 301 AND part.part_key = 'musicbrainz:ca7d9f8a-6539-42d9-baa2-72a7e23a29a2' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:ca7d9f8a-6539-42d9-baa2-72a7e23a29a2', 7, 'VII', 'Adagio: Postludio - S. Carlo alle Quattro Fontane, II', 'Naxos Quartet no. 7 "Metafore sul Borromini": VII. Adagio: Postludio - S. Carlo alle Quattro Fontane, II', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 17020 AND p.composer_id = 301
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:ca7d9f8a-6539-42d9-baa2-72a7e23a29a2'
);


-- None Naxos Quartet no. 8

UPDATE pieces piece
SET piece.title = 'Naxos Quartet no. 8', piece.title_en = 'Naxos Quartet no. 8',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 17594 AND piece.composer_id = 301
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- Op. 13a O Magnum Mysterium

UPDATE pieces piece
SET piece.title = 'O Magnum Mysterium', piece.title_en = 'O Magnum Mysterium, op. 13a',
    piece.type = 'album', piece.opus_number = 'Op. 13a',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 17923 AND piece.composer_id = 301
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'Carol "O Magnum Mysterium"', part.name_en = 'O Magnum Mysterium, op. 13a: I. Carol "O Magnum Mysterium"',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 17923 AND p.composer_id = 301 AND part.part_key = 'musicbrainz:216fa516-3f18-450d-984d-a428b3122c51' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:216fa516-3f18-450d-984d-a428b3122c51', 1, 'I', 'Carol "O Magnum Mysterium"', 'O Magnum Mysterium, op. 13a: I. Carol "O Magnum Mysterium"', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 17923 AND p.composer_id = 301
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:216fa516-3f18-450d-984d-a428b3122c51'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'Carol "Haylle, comly and clene"', part.name_en = 'O Magnum Mysterium, op. 13a: II. Carol "Haylle, comly and clene"',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 17923 AND p.composer_id = 301 AND part.part_key = 'musicbrainz:d26c83ae-2835-4ddb-8168-9562f873c655' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:d26c83ae-2835-4ddb-8168-9562f873c655', 2, 'II', 'Carol "Haylle, comly and clene"', 'O Magnum Mysterium, op. 13a: II. Carol "Haylle, comly and clene"', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 17923 AND p.composer_id = 301
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:d26c83ae-2835-4ddb-8168-9562f873c655'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = 'Sonata I "Puer Natus"', part.name_en = 'O Magnum Mysterium, op. 13a: III. Sonata I "Puer Natus"',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 17923 AND p.composer_id = 301 AND part.part_key = 'musicbrainz:c376f67d-11fa-41e1-bd3f-d17c8447025c' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:c376f67d-11fa-41e1-bd3f-d17c8447025c', 3, 'III', 'Sonata I "Puer Natus"', 'O Magnum Mysterium, op. 13a: III. Sonata I "Puer Natus"', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 17923 AND p.composer_id = 301
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:c376f67d-11fa-41e1-bd3f-d17c8447025c'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = 'IV',
    part.name_ko = 'Carol "O Magnum Mysterium"', part.name_en = 'O Magnum Mysterium, op. 13a: IV. Carol "O Magnum Mysterium"',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 17923 AND p.composer_id = 301 AND part.part_key = 'musicbrainz:5374c1c3-0c7d-4d7c-b157-ad2bc522c80f' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:5374c1c3-0c7d-4d7c-b157-ad2bc522c80f', 4, 'IV', 'Carol "O Magnum Mysterium"', 'O Magnum Mysterium, op. 13a: IV. Carol "O Magnum Mysterium"', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 17923 AND p.composer_id = 301
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:5374c1c3-0c7d-4d7c-b157-ad2bc522c80f'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 5, part.movement_number = 'V',
    part.name_ko = 'Carol "Alleluia, pro Virgine Maria"', part.name_en = 'O Magnum Mysterium, op. 13a: V. Carol "Alleluia, pro Virgine Maria"',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 17923 AND p.composer_id = 301 AND part.part_key = 'musicbrainz:dba29ba2-b21f-4f12-bb8d-c1db86633b9b' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:dba29ba2-b21f-4f12-bb8d-c1db86633b9b', 5, 'V', 'Carol "Alleluia, pro Virgine Maria"', 'O Magnum Mysterium, op. 13a: V. Carol "Alleluia, pro Virgine Maria"', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 17923 AND p.composer_id = 301
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:dba29ba2-b21f-4f12-bb8d-c1db86633b9b'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 6, part.movement_number = 'VI',
    part.name_ko = 'Sonata II "Lux Fulgebit"', part.name_en = 'O Magnum Mysterium, op. 13a: VI. Sonata II "Lux Fulgebit"',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 17923 AND p.composer_id = 301 AND part.part_key = 'musicbrainz:77d46294-e24c-466a-9338-b56cc5844ee8' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:77d46294-e24c-466a-9338-b56cc5844ee8', 6, 'VI', 'Sonata II "Lux Fulgebit"', 'O Magnum Mysterium, op. 13a: VI. Sonata II "Lux Fulgebit"', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 17923 AND p.composer_id = 301
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:77d46294-e24c-466a-9338-b56cc5844ee8'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 7, part.movement_number = 'VII',
    part.name_ko = 'Carol "The Fader of Heven"', part.name_en = 'O Magnum Mysterium, op. 13a: VII. Carol "The Fader of Heven"',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 17923 AND p.composer_id = 301 AND part.part_key = 'musicbrainz:ddcd3cf9-6657-4c44-8ffe-8e198ad68167' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:ddcd3cf9-6657-4c44-8ffe-8e198ad68167', 7, 'VII', 'Carol "The Fader of Heven"', 'O Magnum Mysterium, op. 13a: VII. Carol "The Fader of Heven"', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 17923 AND p.composer_id = 301
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:ddcd3cf9-6657-4c44-8ffe-8e198ad68167'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 8, part.movement_number = 'VIII',
    part.name_ko = 'Carol "O Magnum Mysterium"', part.name_en = 'O Magnum Mysterium, op. 13a: VIII. Carol "O Magnum Mysterium"',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 17923 AND p.composer_id = 301 AND part.part_key = 'musicbrainz:9df844dc-64a9-4007-aa58-5efcf7a35375' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:9df844dc-64a9-4007-aa58-5efcf7a35375', 8, 'VIII', 'Carol "O Magnum Mysterium"', 'O Magnum Mysterium, op. 13a: VIII. Carol "O Magnum Mysterium"', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 17923 AND p.composer_id = 301
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:9df844dc-64a9-4007-aa58-5efcf7a35375'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 9, part.movement_number = 'IX',
    part.name_ko = 'Organ Fantasia on "O Magnum Mysterium", op. 13b', part.name_en = 'O Magnum Mysterium, op. 13a: IX. Organ Fantasia on "O Magnum Mysterium", op. 13b',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 17923 AND p.composer_id = 301 AND part.part_key = 'musicbrainz:d0f6cc99-8479-4281-aaa9-5946214eef96' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:d0f6cc99-8479-4281-aaa9-5946214eef96', 9, 'IX', 'Organ Fantasia on "O Magnum Mysterium", op. 13b', 'O Magnum Mysterium, op. 13a: IX. Organ Fantasia on "O Magnum Mysterium", op. 13b', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 17923 AND p.composer_id = 301
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:d0f6cc99-8479-4281-aaa9-5946214eef96'
);


-- Op. 323 오보에 4중주

UPDATE pieces piece
SET piece.title = '오보에 4중주', piece.title_en = 'Oboe Quartet, op. 323',
    piece.type = 'song', piece.opus_number = 'Op. 323',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 17064 AND piece.composer_id = 301
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- Op. 147 Ojai Festival Overture

UPDATE pieces piece
SET piece.title = 'Ojai Festival Overture', piece.title_en = 'Ojai Festival Overture, op. 147',
    piece.type = 'song', piece.opus_number = 'Op. 147',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 18361 AND piece.composer_id = 301
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- Op. 118 One Star at Last

UPDATE pieces piece
SET piece.title = 'One Star at Last', piece.title_en = 'One Star at Last, op. 118',
    piece.type = 'song', piece.opus_number = 'Op. 118',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 17179 AND piece.composer_id = 301
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- Op. 185 Orkney Saga I

UPDATE pieces piece
SET piece.title = 'Orkney Saga I', piece.title_en = 'Orkney Saga I, op. 185',
    piece.type = 'song', piece.opus_number = 'Op. 185',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 18414 AND piece.composer_id = 301
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- Op. 93 피아노 소나타

UPDATE pieces piece
SET piece.title = '피아노 소나타', piece.title_en = 'Piano Sonata, op. 93',
    piece.type = 'album', piece.opus_number = 'Op. 93',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 16349 AND piece.composer_id = 301
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'Sostenuto - Allegro ma non troppo', part.name_en = 'Piano Sonata, op. 93: I. Sostenuto - Allegro ma non troppo',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 16349 AND p.composer_id = 301 AND part.part_key = 'musicbrainz:05e67579-c32d-4f28-b04a-7ff4abc86914' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:05e67579-c32d-4f28-b04a-7ff4abc86914', 1, 'I', 'Sostenuto - Allegro ma non troppo', 'Piano Sonata, op. 93: I. Sostenuto - Allegro ma non troppo', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 16349 AND p.composer_id = 301
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:05e67579-c32d-4f28-b04a-7ff4abc86914'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'Scherzo. Vivace', part.name_en = 'Piano Sonata, op. 93: II. Scherzo. Vivace',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 16349 AND p.composer_id = 301 AND part.part_key = 'musicbrainz:ef79dac3-3d95-4e15-b4b5-2bde8bccf498' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:ef79dac3-3d95-4e15-b4b5-2bde8bccf498', 2, 'II', 'Scherzo. Vivace', 'Piano Sonata, op. 93: II. Scherzo. Vivace', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 16349 AND p.composer_id = 301
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:ef79dac3-3d95-4e15-b4b5-2bde8bccf498'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = 'Larghetto', part.name_en = 'Piano Sonata, op. 93: III. Larghetto',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 16349 AND p.composer_id = 301 AND part.part_key = 'musicbrainz:1b5e01b6-7db7-437c-a02c-f7cc5f3701c4' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:1b5e01b6-7db7-437c-a02c-f7cc5f3701c4', 3, 'III', 'Larghetto', 'Piano Sonata, op. 93: III. Larghetto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 16349 AND p.composer_id = 301
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:1b5e01b6-7db7-437c-a02c-f7cc5f3701c4'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = 'IV',
    part.name_ko = 'Cantabile con moto', part.name_en = 'Piano Sonata, op. 93: IV. Cantabile con moto',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 16349 AND p.composer_id = 301 AND part.part_key = 'musicbrainz:34a0ae23-4493-44e3-9bee-e4c008193c69' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:34a0ae23-4493-44e3-9bee-e4c008193c69', 4, 'IV', 'Cantabile con moto', 'Piano Sonata, op. 93: IV. Cantabile con moto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 16349 AND p.composer_id = 301
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:34a0ae23-4493-44e3-9bee-e4c008193c69'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 5, part.movement_number = 'V',
    part.name_ko = 'Grave', part.name_en = 'Piano Sonata, op. 93: V. Grave',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 16349 AND p.composer_id = 301 AND part.part_key = 'musicbrainz:2d8cd1a5-f414-41c1-980c-3a177d846fc9' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:2d8cd1a5-f414-41c1-980c-3a177d846fc9', 5, 'V', 'Grave', 'Piano Sonata, op. 93: V. Grave', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 16349 AND p.composer_id = 301
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:2d8cd1a5-f414-41c1-980c-3a177d846fc9'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 6, part.movement_number = 'VI',
    part.name_ko = 'Scherzo. Allegro molto', part.name_en = 'Piano Sonata, op. 93: VI. Scherzo. Allegro molto',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 16349 AND p.composer_id = 301 AND part.part_key = 'musicbrainz:c5050727-6e17-432d-9237-cb3b778159d5' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:c5050727-6e17-432d-9237-cb3b778159d5', 6, 'VI', 'Scherzo. Allegro molto', 'Piano Sonata, op. 93: VI. Scherzo. Allegro molto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 16349 AND p.composer_id = 301
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:c5050727-6e17-432d-9237-cb3b778159d5'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 7, part.movement_number = 'VII',
    part.name_ko = 'Allegro preciso - Adagio', part.name_en = 'Piano Sonata, op. 93: VII. Allegro preciso - Adagio',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 16349 AND p.composer_id = 301 AND part.part_key = 'musicbrainz:26d36c25-eb47-4a2a-a62b-e5a11f044cb5' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:26d36c25-eb47-4a2a-a62b-e5a11f044cb5', 7, 'VII', 'Allegro preciso - Adagio', 'Piano Sonata, op. 93: VII. Allegro preciso - Adagio', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 16349 AND p.composer_id = 301
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:26d36c25-eb47-4a2a-a62b-e5a11f044cb5'
);


-- Op. 182 Piccolo Concerto

UPDATE pieces piece
SET piece.title = 'Piccolo Concerto', piece.title_en = 'Piccolo Concerto, op. 182',
    piece.type = 'album', piece.opus_number = 'Op. 182',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 18553 AND piece.composer_id = 301
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'Andante - Allegro moderato molto - Poco meno mosso - Andante', part.name_en = 'Piccolo Concerto, op. 182: I. Andante - Allegro moderato molto - Poco meno mosso - Andante',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 18553 AND p.composer_id = 301 AND part.part_key = 'musicbrainz:5ea84b13-8089-496c-8b85-90143e1e5c08' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:5ea84b13-8089-496c-8b85-90143e1e5c08', 1, 'I', 'Andante - Allegro moderato molto - Poco meno mosso - Andante', 'Piccolo Concerto, op. 182: I. Andante - Allegro moderato molto - Poco meno mosso - Andante', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 18553 AND p.composer_id = 301
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:5ea84b13-8089-496c-8b85-90143e1e5c08'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'Adagio', part.name_en = 'Piccolo Concerto, op. 182: II. Adagio',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 18553 AND p.composer_id = 301 AND part.part_key = 'musicbrainz:7d6315fd-fac5-4d08-92f5-30a4f1d7e4a6' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:7d6315fd-fac5-4d08-92f5-30a4f1d7e4a6', 2, 'II', 'Adagio', 'Piccolo Concerto, op. 182: II. Adagio', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 18553 AND p.composer_id = 301
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:7d6315fd-fac5-4d08-92f5-30a4f1d7e4a6'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = 'Lo stesso tempo - Allegro - Lento', part.name_en = 'Piccolo Concerto, op. 182: III. Lo stesso tempo - Allegro - Lento',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 18553 AND p.composer_id = 301 AND part.part_key = 'musicbrainz:9f37acdb-c0da-4f79-afdd-df0e750ed42c' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:9f37acdb-c0da-4f79-afdd-df0e750ed42c', 3, 'III', 'Lo stesso tempo - Allegro - Lento', 'Piccolo Concerto, op. 182: III. Lo stesso tempo - Allegro - Lento', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 18553 AND p.composer_id = 301
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:9f37acdb-c0da-4f79-afdd-df0e750ed42c'
);


-- None Quartet Movement

UPDATE pieces piece
SET piece.title = 'Quartet Movement', piece.title_en = 'Quartet Movement',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 18979 AND piece.composer_id = 301
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- Op. 177 Reliqui Domum Meum

UPDATE pieces piece
SET piece.title = 'Reliqui Domum Meum', piece.title_en = 'Reliqui Domum Meum, op. 177',
    piece.type = 'song', piece.opus_number = 'Op. 177',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 18204 AND piece.composer_id = 301
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None 오페라 <Resurrection>

UPDATE pieces piece
SET piece.title = '오페라 <Resurrection>', piece.title_en = 'Resurrection',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 17320 AND piece.composer_id = 301
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'Prologue', part.name_en = 'Resurrection: Prologue',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 17320 AND p.composer_id = 301 AND part.part_key = 'musicbrainz:25c8dbf4-fabc-4b75-b32a-0659020f5cd6' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:25c8dbf4-fabc-4b75-b32a-0659020f5cd6', 1, NULL, 'Prologue', 'Resurrection: Prologue', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 17320 AND p.composer_id = 301
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:25c8dbf4-fabc-4b75-b32a-0659020f5cd6'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'Act', part.name_en = 'Resurrection: Act',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 17320 AND p.composer_id = 301 AND part.part_key = 'musicbrainz:c7c21be9-4605-42ed-8908-d901a97dd131' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:c7c21be9-4605-42ed-8908-d901a97dd131', 2, NULL, 'Act', 'Resurrection: Act', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 17320 AND p.composer_id = 301
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:c7c21be9-4605-42ed-8908-d901a97dd131'
);


-- Op. 31 Revelation and Fall

UPDATE pieces piece
SET piece.title = 'Revelation and Fall', piece.title_en = 'Revelation and Fall, op. 31',
    piece.type = 'song', piece.opus_number = 'Op. 31',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 17505 AND piece.composer_id = 301
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- Op. 195 Roma amor

UPDATE pieces piece
SET piece.title = 'Roma amor', piece.title_en = 'Roma amor, op. 195',
    piece.type = 'song', piece.opus_number = 'Op. 195',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 19806 AND piece.composer_id = 301
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- Op. 74 Runes from a Holy Island

UPDATE pieces piece
SET piece.title = 'Runes from a Holy Island', piece.title_en = 'Runes from a Holy Island, op. 74',
    piece.type = 'song', piece.opus_number = 'Op. 74',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 17624 AND piece.composer_id = 301
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Sea Eagle

UPDATE pieces piece
SET piece.title = 'Sea Eagle', piece.title_en = 'Sea Eagle',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 17001 AND piece.composer_id = 301
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'Adagio', part.name_en = 'Sea Eagle: I. Adagio',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 17001 AND p.composer_id = 301 AND part.part_key = 'musicbrainz:617c2cda-5512-425f-b34b-a17812f4f292' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:617c2cda-5512-425f-b34b-a17812f4f292', 1, 'I', 'Adagio', 'Sea Eagle: I. Adagio', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 17001 AND p.composer_id = 301
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:617c2cda-5512-425f-b34b-a17812f4f292'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'Lento', part.name_en = 'Sea Eagle: II. Lento',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 17001 AND p.composer_id = 301 AND part.part_key = 'musicbrainz:9500b824-37cc-4ec6-b92c-0886ad3a0303' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:9500b824-37cc-4ec6-b92c-0886ad3a0303', 2, 'II', 'Lento', 'Sea Eagle: II. Lento', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 17001 AND p.composer_id = 301
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:9500b824-37cc-4ec6-b92c-0886ad3a0303'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = 'Presto molto', part.name_en = 'Sea Eagle: III. Presto molto',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 17001 AND p.composer_id = 301 AND part.part_key = 'musicbrainz:90eb8155-c7c7-4a06-b4c0-574d7b106dda' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:90eb8155-c7c7-4a06-b4c0-574d7b106dda', 3, 'III', 'Presto molto', 'Sea Eagle: III. Presto molto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 17001 AND p.composer_id = 301
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:90eb8155-c7c7-4a06-b4c0-574d7b106dda'
);


-- Op. 28 Seven In Nomine Op. 28

UPDATE pieces piece
SET piece.title = 'Seven In Nomine Op. 28', piece.title_en = 'Seven In Nomine, op. 28',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = 'Op.', piece.catalogue_number = '28',
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 19778 AND piece.composer_id = 301
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'In Nomine', part.name_en = 'Seven In Nomine, op. 28: No. 1. In Nomine',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 19778 AND p.composer_id = 301 AND part.part_key = 'musicbrainz:8b9e39b8-9230-46b7-899b-e38a92e75526' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:8b9e39b8-9230-46b7-899b-e38a92e75526', 1, NULL, 'In Nomine', 'Seven In Nomine, op. 28: No. 1. In Nomine', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 19778 AND p.composer_id = 301
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:8b9e39b8-9230-46b7-899b-e38a92e75526'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'In Nomine', part.name_en = 'Seven In Nomine, op. 28: No. 2. In Nomine',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 19778 AND p.composer_id = 301 AND part.part_key = 'musicbrainz:8a61e472-6a12-4374-b36d-f56c3f8cae03' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:8a61e472-6a12-4374-b36d-f56c3f8cae03', 2, NULL, 'In Nomine', 'Seven In Nomine, op. 28: No. 2. In Nomine', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 19778 AND p.composer_id = 301
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:8a61e472-6a12-4374-b36d-f56c3f8cae03'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = NULL,
    part.name_ko = 'In Nomine', part.name_en = 'Seven In Nomine, op. 28: No. 3. In Nomine',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 19778 AND p.composer_id = 301 AND part.part_key = 'musicbrainz:a2ba6bea-7c5a-4553-8e43-642eacfedb44' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:a2ba6bea-7c5a-4553-8e43-642eacfedb44', 3, NULL, 'In Nomine', 'Seven In Nomine, op. 28: No. 3. In Nomine', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 19778 AND p.composer_id = 301
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:a2ba6bea-7c5a-4553-8e43-642eacfedb44'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = NULL,
    part.name_ko = 'In Nomine', part.name_en = 'Seven In Nomine, op. 28: No. 4. In Nomine',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 19778 AND p.composer_id = 301 AND part.part_key = 'musicbrainz:1602e65b-b7b6-4262-a4cb-67c8faa78a67' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:1602e65b-b7b6-4262-a4cb-67c8faa78a67', 4, NULL, 'In Nomine', 'Seven In Nomine, op. 28: No. 4. In Nomine', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 19778 AND p.composer_id = 301
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:1602e65b-b7b6-4262-a4cb-67c8faa78a67'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 5, part.movement_number = NULL,
    part.name_ko = 'In Nomine', part.name_en = 'Seven In Nomine, op. 28: No. 5. In Nomine',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 19778 AND p.composer_id = 301 AND part.part_key = 'musicbrainz:b4981093-e14f-4fa4-ba23-6ec7058f4d1f' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:b4981093-e14f-4fa4-ba23-6ec7058f4d1f', 5, NULL, 'In Nomine', 'Seven In Nomine, op. 28: No. 5. In Nomine', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 19778 AND p.composer_id = 301
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:b4981093-e14f-4fa4-ba23-6ec7058f4d1f'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 6, part.movement_number = NULL,
    part.name_ko = 'Gloria Tibi Trinitas', part.name_en = 'Seven In Nomine, op. 28: No. 6. Gloria Tibi Trinitas',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 19778 AND p.composer_id = 301 AND part.part_key = 'musicbrainz:6bfd0fc4-98a3-42f7-8041-8aab32ebe5c9' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:6bfd0fc4-98a3-42f7-8041-8aab32ebe5c9', 6, NULL, 'Gloria Tibi Trinitas', 'Seven In Nomine, op. 28: No. 6. Gloria Tibi Trinitas', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 19778 AND p.composer_id = 301
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:6bfd0fc4-98a3-42f7-8041-8aab32ebe5c9'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 7, part.movement_number = NULL,
    part.name_ko = 'In Nomine', part.name_en = 'Seven In Nomine, op. 28: No. 7. In Nomine',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 19778 AND p.composer_id = 301 AND part.part_key = 'musicbrainz:262d8a74-2ad4-4374-bcf3-c32d333a1d54' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:262d8a74-2ad4-4374-bcf3-c32d333a1d54', 7, NULL, 'In Nomine', 'Seven In Nomine, op. 28: No. 7. In Nomine', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 19778 AND p.composer_id = 301
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:262d8a74-2ad4-4374-bcf3-c32d333a1d54'
);


-- Op. 101 연가곡집 <Seven Songs Home> Op. 101

UPDATE pieces piece
SET piece.title = '연가곡집 <Seven Songs Home> Op. 101', piece.title_en = 'Seven Songs Home, op. 101',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = 'Op.', piece.catalogue_number = '101',
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 17500 AND piece.composer_id = 301
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'Home-time at Last', part.name_en = 'Seven Songs Home, op. 101: No. 1 Home-time at Last',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 17500 AND p.composer_id = 301 AND part.part_key = 'musicbrainz:185b6275-a8ba-4044-84e3-b59cd6588ba5' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:185b6275-a8ba-4044-84e3-b59cd6588ba5', 1, NULL, 'Home-time at Last', 'Seven Songs Home, op. 101: No. 1 Home-time at Last', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 17500 AND p.composer_id = 301
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:185b6275-a8ba-4044-84e3-b59cd6588ba5'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'At the Shore', part.name_en = 'Seven Songs Home, op. 101: No. 2. At the Shore',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 17500 AND p.composer_id = 301 AND part.part_key = 'musicbrainz:364f5f9e-9136-4dda-98b6-9389625918ee' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:364f5f9e-9136-4dda-98b6-9389625918ee', 2, NULL, 'At the Shore', 'Seven Songs Home, op. 101: No. 2. At the Shore', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 17500 AND p.composer_id = 301
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:364f5f9e-9136-4dda-98b6-9389625918ee'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = NULL,
    part.name_ko = 'The Heather Track', part.name_en = 'Seven Songs Home, op. 101: No. 3. The Heather Track',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 17500 AND p.composer_id = 301 AND part.part_key = 'musicbrainz:f114da1f-ef2e-4523-9208-843701e42820' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:f114da1f-ef2e-4523-9208-843701e42820', 3, NULL, 'The Heather Track', 'Seven Songs Home, op. 101: No. 3. The Heather Track', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 17500 AND p.composer_id = 301
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:f114da1f-ef2e-4523-9208-843701e42820'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = NULL,
    part.name_ko = 'At the Lochan', part.name_en = 'Seven Songs Home, op. 101: No. 4. At the Lochan',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 17500 AND p.composer_id = 301 AND part.part_key = 'musicbrainz:363dde16-f46f-4787-9ed2-5a67410363f3' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:363dde16-f46f-4787-9ed2-5a67410363f3', 4, NULL, 'At the Lochan', 'Seven Songs Home, op. 101: No. 4. At the Lochan', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 17500 AND p.composer_id = 301
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:363dde16-f46f-4787-9ed2-5a67410363f3'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 5, part.movement_number = NULL,
    part.name_ko = 'Cold Tractor', part.name_en = 'Seven Songs Home, op. 101: No. 5. Cold Tractor',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 17500 AND p.composer_id = 301 AND part.part_key = 'musicbrainz:70a567d2-5eb6-4ce1-b749-a47b544f73a7' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:70a567d2-5eb6-4ce1-b749-a47b544f73a7', 5, NULL, 'Cold Tractor', 'Seven Songs Home, op. 101: No. 5. Cold Tractor', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 17500 AND p.composer_id = 301
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:70a567d2-5eb6-4ce1-b749-a47b544f73a7'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 6, part.movement_number = NULL,
    part.name_ko = 'Tractor Ride', part.name_en = 'Seven Songs Home, op. 101: No. 6. Tractor Ride',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 17500 AND p.composer_id = 301 AND part.part_key = 'musicbrainz:378266a9-a54d-414c-96b4-66e48afce9cf' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:378266a9-a54d-414c-96b4-66e48afce9cf', 6, NULL, 'Tractor Ride', 'Seven Songs Home, op. 101: No. 6. Tractor Ride', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 17500 AND p.composer_id = 301
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:378266a9-a54d-414c-96b4-66e48afce9cf'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 7, part.movement_number = NULL,
    part.name_ko = 'Home', part.name_en = 'Seven Songs Home, op. 101: No. 7. Home',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 17500 AND p.composer_id = 301 AND part.part_key = 'musicbrainz:5c61bb29-c833-4c5d-abd3-9a1224c352c2' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:5c61bb29-c833-4c5d-abd3-9a1224c352c2', 7, NULL, 'Home', 'Seven Songs Home, op. 101: No. 7. Home', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 17500 AND p.composer_id = 301
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:5c61bb29-c833-4c5d-abd3-9a1224c352c2'
);


-- Op. 106 협주 교향곡

UPDATE pieces piece
SET piece.title = '협주 교향곡', piece.title_en = 'Sinfonia concertante, op. 106',
    piece.type = 'song', piece.opus_number = 'Op. 106',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 17902 AND piece.composer_id = 301
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- Op. 20 신포니아

UPDATE pieces piece
SET piece.title = '신포니아', piece.title_en = 'Sinfonia, op. 20',
    piece.type = 'song', piece.opus_number = 'Op. 20',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 18730 AND piece.composer_id = 301
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- Op. 112 Sinfonietta Accademica

UPDATE pieces piece
SET piece.title = 'Sinfonietta Accademica', piece.title_en = 'Sinfonietta Accademica, op. 112',
    piece.type = 'song', piece.opus_number = 'Op. 112',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 18065 AND piece.composer_id = 301
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- Op. 239 Snow Cloud Over Lochan

UPDATE pieces piece
SET piece.title = 'Snow Cloud Over Lochan', piece.title_en = 'Snow Cloud Over Lochan, op. 239',
    piece.type = 'song', piece.opus_number = 'Op. 239',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 17879 AND piece.composer_id = 301
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- Op. 83 칸타타 <Solstice of Light> Op. 83

UPDATE pieces piece
SET piece.title = '칸타타 <Solstice of Light> Op. 83', piece.title_en = 'Solstice of Light, op. 83',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = 'Op.', piece.catalogue_number = '83',
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 18905 AND piece.composer_id = 301
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'Prayer for these Islands: New Troves', part.name_en = 'Solstice of Light: Prayer for these Islands: New Troves',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 18905 AND p.composer_id = 301 AND part.part_key = 'musicbrainz:04ffb6a7-750c-433b-b4fa-efa06fa4711d' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:04ffb6a7-750c-433b-b4fa-efa06fa4711d', 1, NULL, 'Prayer for these Islands: New Troves', 'Solstice of Light: Prayer for these Islands: New Troves', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 18905 AND p.composer_id = 301
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:04ffb6a7-750c-433b-b4fa-efa06fa4711d'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'The White Weave of Peace', part.name_en = 'Solstice of Light: The White Weave of Peace',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 18905 AND p.composer_id = 301 AND part.part_key = 'musicbrainz:090c115e-c055-4d5e-9bcd-150ff07eeb88' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:090c115e-c055-4d5e-9bcd-150ff07eeb88', 2, NULL, 'The White Weave of Peace', 'Solstice of Light: The White Weave of Peace', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 18905 AND p.composer_id = 301
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:090c115e-c055-4d5e-9bcd-150ff07eeb88'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = NULL,
    part.name_ko = 'Solstice of Light', part.name_en = 'Solstice of Light: Solstice of Light',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 18905 AND p.composer_id = 301 AND part.part_key = 'musicbrainz:150c2d3b-ed76-44e4-b8ed-00988a9e235f' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:150c2d3b-ed76-44e4-b8ed-00988a9e235f', 3, NULL, 'Solstice of Light', 'Solstice of Light: Solstice of Light', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 18905 AND p.composer_id = 301
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:150c2d3b-ed76-44e4-b8ed-00988a9e235f'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = NULL,
    part.name_ko = 'Norsemen', part.name_en = 'Solstice of Light: Norsemen',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 18905 AND p.composer_id = 301 AND part.part_key = 'musicbrainz:3520ce4a-ec9f-4258-b451-b3ed8cbbafa9' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:3520ce4a-ec9f-4258-b451-b3ed8cbbafa9', 4, NULL, 'Norsemen', 'Solstice of Light: Norsemen', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 18905 AND p.composer_id = 301
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:3520ce4a-ec9f-4258-b451-b3ed8cbbafa9'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 5, part.movement_number = NULL,
    part.name_ko = 'Invocation of the Dove', part.name_en = 'Solstice of Light: Invocation of the Dove',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 18905 AND p.composer_id = 301 AND part.part_key = 'musicbrainz:448433cb-1ddb-4768-8acb-4967924a78e3' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:448433cb-1ddb-4768-8acb-4967924a78e3', 5, NULL, 'Invocation of the Dove', 'Solstice of Light: Invocation of the Dove', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 18905 AND p.composer_id = 301
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:448433cb-1ddb-4768-8acb-4967924a78e3'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 6, part.movement_number = NULL,
    part.name_ko = 'The Mild Circle of the Sun', part.name_en = 'Solstice of Light: The Mild Circle of the Sun',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 18905 AND p.composer_id = 301 AND part.part_key = 'musicbrainz:7ea330a4-9924-4923-9fab-7312d5991fd0' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:7ea330a4-9924-4923-9fab-7312d5991fd0', 6, NULL, 'The Mild Circle of the Sun', 'Solstice of Light: The Mild Circle of the Sun', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 18905 AND p.composer_id = 301
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:7ea330a4-9924-4923-9fab-7312d5991fd0'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 7, part.movement_number = NULL,
    part.name_ko = 'New Hills and Lochs and Shores', part.name_en = 'Solstice of Light: New Hills and Lochs and Shores',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 18905 AND p.composer_id = 301 AND part.part_key = 'musicbrainz:89e320ac-5d05-418e-8580-590c3d8a4684' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:89e320ac-5d05-418e-8580-590c3d8a4684', 7, NULL, 'New Hills and Lochs and Shores', 'Solstice of Light: New Hills and Lochs and Shores', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 18905 AND p.composer_id = 301
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:89e320ac-5d05-418e-8580-590c3d8a4684'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 8, part.movement_number = NULL,
    part.name_ko = 'We Rowed Blindly North and North', part.name_en = 'Solstice of Light: We Rowed Blindly North and North',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 18905 AND p.composer_id = 301 AND part.part_key = 'musicbrainz:96c1b186-0741-424f-8bbb-a4ab51a9f566' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:96c1b186-0741-424f-8bbb-a4ab51a9f566', 8, NULL, 'We Rowed Blindly North and North', 'Solstice of Light: We Rowed Blindly North and North', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 18905 AND p.composer_id = 301
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:96c1b186-0741-424f-8bbb-a4ab51a9f566'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 9, part.movement_number = NULL,
    part.name_ko = 'Circles of Stone on the Blank Moor', part.name_en = 'Solstice of Light: Circles of Stone on the Blank Moor',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 18905 AND p.composer_id = 301 AND part.part_key = 'musicbrainz:a00758e1-602f-4780-980b-21cf8f04d9ab' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:a00758e1-602f-4780-980b-21cf8f04d9ab', 9, NULL, 'Circles of Stone on the Blank Moor', 'Solstice of Light: Circles of Stone on the Blank Moor', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 18905 AND p.composer_id = 301
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:a00758e1-602f-4780-980b-21cf8f04d9ab'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 10, part.movement_number = NULL,
    part.name_ko = 'The Hills, the Skies, the Sweet and the Salt Waters', part.name_en = 'Solstice of Light: The Hills, the Skies, the Sweet and the Salt Waters',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 18905 AND p.composer_id = 301 AND part.part_key = 'musicbrainz:ab6fd478-cbd2-4304-87f9-eb6beb7d4ed2' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:ab6fd478-cbd2-4304-87f9-eb6beb7d4ed2', 10, NULL, 'The Hills, the Skies, the Sweet and the Salt Waters', 'Solstice of Light: The Hills, the Skies, the Sweet and the Salt Waters', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 18905 AND p.composer_id = 301
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:ab6fd478-cbd2-4304-87f9-eb6beb7d4ed2'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 11, part.movement_number = NULL,
    part.name_ko = 'Green Whirls of Melted Ice', part.name_en = 'Solstice of Light: Green Whirls of Melted Ice',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 18905 AND p.composer_id = 301 AND part.part_key = 'musicbrainz:b505896b-896f-4492-99da-e5681fe83309' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:b505896b-896f-4492-99da-e5681fe83309', 11, NULL, 'Green Whirls of Melted Ice', 'Solstice of Light: Green Whirls of Melted Ice', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 18905 AND p.composer_id = 301
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:b505896b-896f-4492-99da-e5681fe83309'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 12, part.movement_number = NULL,
    part.name_ko = 'The Celtic Priests', part.name_en = 'Solstice of Light: The Celtic Priests',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 18905 AND p.composer_id = 301 AND part.part_key = 'musicbrainz:cff256ee-fbc6-4416-9555-7294d53737c8' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:cff256ee-fbc6-4416-9555-7294d53737c8', 12, NULL, 'The Celtic Priests', 'Solstice of Light: The Celtic Priests', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 18905 AND p.composer_id = 301
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:cff256ee-fbc6-4416-9555-7294d53737c8'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 13, part.movement_number = NULL,
    part.name_ko = 'Hawkship', part.name_en = 'Solstice of Light: Hawkship',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 18905 AND p.composer_id = 301 AND part.part_key = 'musicbrainz:df4363eb-e1a7-407a-9e5c-84859e8913ad' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:df4363eb-e1a7-407a-9e5c-84859e8913ad', 13, NULL, 'Hawkship', 'Solstice of Light: Hawkship', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 18905 AND p.composer_id = 301
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:df4363eb-e1a7-407a-9e5c-84859e8913ad'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 14, part.movement_number = NULL,
    part.name_ko = 'Earth Breakers, Hewers of Mighty Stone', part.name_en = 'Solstice of Light: Earth Breakers, Hewers of Mighty Stone',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 18905 AND p.composer_id = 301 AND part.part_key = 'musicbrainz:f2b757bc-1d02-4683-94a0-becb28493288' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:f2b757bc-1d02-4683-94a0-becb28493288', 14, NULL, 'Earth Breakers, Hewers of Mighty Stone', 'Solstice of Light: Earth Breakers, Hewers of Mighty Stone', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 18905 AND p.composer_id = 301
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:f2b757bc-1d02-4683-94a0-becb28493288'
);


-- Op. 1 트럼펫과 피아노를 위한 소나타

UPDATE pieces piece
SET piece.title = '트럼펫과 피아노를 위한 소나타', piece.title_en = 'Sonata for Trumpet and Piano, op. 1',
    piece.type = 'album', piece.opus_number = 'Op. 1',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 19655 AND piece.composer_id = 301
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'Allegro moderato', part.name_en = 'Sonata for Trumpet and Piano, op. 1: I. Allegro moderato',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 19655 AND p.composer_id = 301 AND part.part_key = 'musicbrainz:cc3bbabf-f2cc-4fba-b584-e1166a600ce3' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:cc3bbabf-f2cc-4fba-b584-e1166a600ce3', 1, 'I', 'Allegro moderato', 'Sonata for Trumpet and Piano, op. 1: I. Allegro moderato', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 19655 AND p.composer_id = 301
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:cc3bbabf-f2cc-4fba-b584-e1166a600ce3'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'Lento', part.name_en = 'Sonata for Trumpet and Piano, op. 1: II. Lento',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 19655 AND p.composer_id = 301 AND part.part_key = 'musicbrainz:8e65101d-0cdf-46fe-b173-15112ac31ffe' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:8e65101d-0cdf-46fe-b173-15112ac31ffe', 2, 'II', 'Lento', 'Sonata for Trumpet and Piano, op. 1: II. Lento', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 19655 AND p.composer_id = 301
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:8e65101d-0cdf-46fe-b173-15112ac31ffe'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = 'Allegro vivo', part.name_en = 'Sonata for Trumpet and Piano, op. 1: III. Allegro vivo',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 19655 AND p.composer_id = 301 AND part.part_key = 'musicbrainz:f4956992-a919-4c95-a348-34e0fcc1ef62' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:f4956992-a919-4c95-a348-34e0fcc1ef62', 3, 'III', 'Allegro vivo', 'Sonata for Trumpet and Piano, op. 1: III. Allegro vivo', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 19655 AND p.composer_id = 301
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:f4956992-a919-4c95-a348-34e0fcc1ef62'
);


-- Op. 289 바이올린과 피아노를 위한 소나타

UPDATE pieces piece
SET piece.title = '바이올린과 피아노를 위한 소나타', piece.title_en = 'Sonata for Violin and Piano, op. 289',
    piece.type = 'song', piece.opus_number = 'Op. 289',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 17694 AND piece.composer_id = 301
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- Op. 334 Sonatina for Violin Alone

UPDATE pieces piece
SET piece.title = 'Sonatina for Violin Alone', piece.title_en = 'Sonatina for Violin Alone, op. 334',
    piece.type = 'song', piece.opus_number = 'Op. 334',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 17648 AND piece.composer_id = 301
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- Op. 203 Spinning Jenny

UPDATE pieces piece
SET piece.title = 'Spinning Jenny', piece.title_en = 'Spinning Jenny, op. 203',
    piece.type = 'song', piece.opus_number = 'Op. 203',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 16612 AND piece.composer_id = 301
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- Op. 302 St. Francis of Assisi

UPDATE pieces piece
SET piece.title = 'St. Francis of Assisi', piece.title_en = 'St. Francis of Assisi, op. 302',
    piece.type = 'song', piece.opus_number = 'Op. 302',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 18607 AND piece.composer_id = 301
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- Op. 128 Strathclyde Concerto no. 1

UPDATE pieces piece
SET piece.title = 'Strathclyde Concerto no. 1', piece.title_en = 'Strathclyde Concerto no. 1, op. 128',
    piece.type = 'song', piece.opus_number = 'Op. 128',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 16355 AND piece.composer_id = 301
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- Op. 143 Strathclyde Concerto no. 4

UPDATE pieces piece
SET piece.title = 'Strathclyde Concerto no. 4', piece.title_en = 'Strathclyde Concerto no. 4, op. 143',
    piece.type = 'album', piece.opus_number = 'Op. 143',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 16947 AND piece.composer_id = 301
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'Introduction. Lento', part.name_en = 'Strathclyde Concerto no. 4, op. 143: I. Introduction. Lento',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 16947 AND p.composer_id = 301 AND part.part_key = 'musicbrainz:178ed1df-3c78-4cd8-81f2-b327bd47a39a' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:178ed1df-3c78-4cd8-81f2-b327bd47a39a', 1, 'I', 'Introduction. Lento', 'Strathclyde Concerto no. 4, op. 143: I. Introduction. Lento', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 16947 AND p.composer_id = 301
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:178ed1df-3c78-4cd8-81f2-b327bd47a39a'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'Allegro moderato', part.name_en = 'Strathclyde Concerto no. 4, op. 143: II. Allegro moderato',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 16947 AND p.composer_id = 301 AND part.part_key = 'musicbrainz:9c6d5ff9-ecef-469a-864b-a05de75d7112' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:9c6d5ff9-ecef-469a-864b-a05de75d7112', 2, 'II', 'Allegro moderato', 'Strathclyde Concerto no. 4, op. 143: II. Allegro moderato', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 16947 AND p.composer_id = 301
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:9c6d5ff9-ecef-469a-864b-a05de75d7112'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = 'Adagio', part.name_en = 'Strathclyde Concerto no. 4, op. 143: III. Adagio',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 16947 AND p.composer_id = 301 AND part.part_key = 'musicbrainz:296ae2e1-d95f-46a1-99e6-a9537946c262' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:296ae2e1-d95f-46a1-99e6-a9537946c262', 3, 'III', 'Adagio', 'Strathclyde Concerto no. 4, op. 143: III. Adagio', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 16947 AND p.composer_id = 301
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:296ae2e1-d95f-46a1-99e6-a9537946c262'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = 'IV',
    part.name_ko = 'Cadenza', part.name_en = 'Strathclyde Concerto no. 4, op. 143: IV. Cadenza',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 16947 AND p.composer_id = 301 AND part.part_key = 'musicbrainz:85b20a62-d78d-40c9-ba57-1fe89a4f99c1' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:85b20a62-d78d-40c9-ba57-1fe89a4f99c1', 4, 'IV', 'Cadenza', 'Strathclyde Concerto no. 4, op. 143: IV. Cadenza', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 16947 AND p.composer_id = 301
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:85b20a62-d78d-40c9-ba57-1fe89a4f99c1'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 5, part.movement_number = 'V',
    part.name_ko = 'Coda. Adagio', part.name_en = 'Strathclyde Concerto no. 4, op. 143: V. Coda. Adagio',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 16947 AND p.composer_id = 301 AND part.part_key = 'musicbrainz:c1b36f99-b6e3-44e2-b13a-eb803ca6cab0' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:c1b36f99-b6e3-44e2-b13a-eb803ca6cab0', 5, 'V', 'Coda. Adagio', 'Strathclyde Concerto no. 4, op. 143: V. Coda. Adagio', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 16947 AND p.composer_id = 301
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:c1b36f99-b6e3-44e2-b13a-eb803ca6cab0'
);


-- Op. 338 String Quartet Movement

UPDATE pieces piece
SET piece.title = 'String Quartet Movement', piece.title_en = 'String Quartet Movement, op. 338',
    piece.type = 'song', piece.opus_number = 'Op. 338',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 19015 AND piece.composer_id = 301
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- Op. 290 현악 3중주

UPDATE pieces piece
SET piece.title = '현악 3중주', piece.title_en = 'String Trio, op. 290',
    piece.type = 'song', piece.opus_number = 'Op. 290',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 16294 AND piece.composer_id = 301
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- Op. 50a Suite from The Boyfriend

UPDATE pieces piece
SET piece.title = 'Suite from The Boyfriend', piece.title_en = 'Suite from The Boyfriend, op. 50a',
    piece.type = 'album', piece.opus_number = 'Op. 50a',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 18181 AND piece.composer_id = 301
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'Honeymoon Fantasy', part.name_en = 'Suite from The Boyfriend, op. 50a: I. Honeymoon Fantasy',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 18181 AND p.composer_id = 301 AND part.part_key = 'musicbrainz:236f227e-9f48-48b5-9f77-8da7c4984366' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:236f227e-9f48-48b5-9f77-8da7c4984366', 1, 'I', 'Honeymoon Fantasy', 'Suite from The Boyfriend, op. 50a: I. Honeymoon Fantasy', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 18181 AND p.composer_id = 301
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:236f227e-9f48-48b5-9f77-8da7c4984366'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'Sur la plage', part.name_en = 'Suite from The Boyfriend, op. 50a: II. Sur la plage',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 18181 AND p.composer_id = 301 AND part.part_key = 'musicbrainz:807b7511-53b5-4ed6-a86d-046914cd5f53' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:807b7511-53b5-4ed6-a86d-046914cd5f53', 2, 'II', 'Sur la plage', 'Suite from The Boyfriend, op. 50a: II. Sur la plage', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 18181 AND p.composer_id = 301
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:807b7511-53b5-4ed6-a86d-046914cd5f53'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = 'A Room in Bloomsbury', part.name_en = 'Suite from The Boyfriend, op. 50a: III. A Room in Bloomsbury',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 18181 AND p.composer_id = 301 AND part.part_key = 'musicbrainz:bc77c60b-a54a-4cbc-8459-83b1c60c650c' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:bc77c60b-a54a-4cbc-8459-83b1c60c650c', 3, 'III', 'A Room in Bloomsbury', 'Suite from The Boyfriend, op. 50a: III. A Room in Bloomsbury', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 18181 AND p.composer_id = 301
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:bc77c60b-a54a-4cbc-8459-83b1c60c650c'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = 'IV',
    part.name_ko = 'I Could Be Happy', part.name_en = 'Suite from The Boyfriend, op. 50a: IV. I Could Be Happy',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 18181 AND p.composer_id = 301 AND part.part_key = 'musicbrainz:ee4b3113-dab1-4acd-a082-5d7fc02fe811' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:ee4b3113-dab1-4acd-a082-5d7fc02fe811', 4, 'IV', 'I Could Be Happy', 'Suite from The Boyfriend, op. 50a: IV. I Could Be Happy', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 18181 AND p.composer_id = 301
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:ee4b3113-dab1-4acd-a082-5d7fc02fe811'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 5, part.movement_number = 'V',
    part.name_ko = 'The "You-Dont-Want..."', part.name_en = 'Suite from The Boyfriend, op. 50a: V. The "You-Dont-Want..."',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 18181 AND p.composer_id = 301 AND part.part_key = 'musicbrainz:090604da-2a32-45dd-8edf-1073451b2a1f' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:090604da-2a32-45dd-8edf-1073451b2a1f', 5, 'V', 'The "You-Dont-Want..."', 'Suite from The Boyfriend, op. 50a: V. The "You-Dont-Want..."', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 18181 AND p.composer_id = 301
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:090604da-2a32-45dd-8edf-1073451b2a1f'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 6, part.movement_number = 'VI',
    part.name_ko = 'Poor Little Pierette', part.name_en = 'Suite from The Boyfriend, op. 50a: VI. Poor Little Pierette',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 18181 AND p.composer_id = 301 AND part.part_key = 'musicbrainz:a02f19f4-5dc4-494f-8511-b867fdfc6c5c' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:a02f19f4-5dc4-494f-8511-b867fdfc6c5c', 6, 'VI', 'Poor Little Pierette', 'Suite from The Boyfriend, op. 50a: VI. Poor Little Pierette', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 18181 AND p.composer_id = 301
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:a02f19f4-5dc4-494f-8511-b867fdfc6c5c'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 7, part.movement_number = 'VII',
    part.name_ko = 'Polly''s Dream', part.name_en = 'Suite from The Boyfriend, op. 50a: VII. Polly''s Dream',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 18181 AND p.composer_id = 301 AND part.part_key = 'musicbrainz:918c7af1-6213-4474-8f0b-11bf7e770bfb' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:918c7af1-6213-4474-8f0b-11bf7e770bfb', 7, 'VII', 'Polly''s Dream', 'Suite from The Boyfriend, op. 50a: VII. Polly''s Dream', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 18181 AND p.composer_id = 301
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:918c7af1-6213-4474-8f0b-11bf7e770bfb'
);


-- Op. 160 Sunday Morning

UPDATE pieces piece
SET piece.title = 'Sunday Morning', piece.title_en = 'Sunday Morning, op. 160',
    piece.type = 'song', piece.opus_number = 'Op. 160',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 19088 AND piece.composer_id = 301
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- Op. 71 교향곡 1번

UPDATE pieces piece
SET piece.title = '교향곡 1번', piece.title_en = 'Symphony no. 1, op. 71',
    piece.type = 'album', piece.opus_number = 'Op. 71',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 16802 AND piece.composer_id = 301
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'Presto', part.name_en = 'Symphony no. 1, op. 71: I. Presto',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 16802 AND p.composer_id = 301 AND part.part_key = 'musicbrainz:31e4556b-22f6-440c-85b4-de7346bfe9a4' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:31e4556b-22f6-440c-85b4-de7346bfe9a4', 1, 'I', 'Presto', 'Symphony no. 1, op. 71: I. Presto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 16802 AND p.composer_id = 301
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:31e4556b-22f6-440c-85b4-de7346bfe9a4'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'Lento - Allegro', part.name_en = 'Symphony no. 1, op. 71: II. Lento - Allegro',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 16802 AND p.composer_id = 301 AND part.part_key = 'musicbrainz:be541a35-4fb4-4bfd-af4e-180f00a647de' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:be541a35-4fb4-4bfd-af4e-180f00a647de', 2, 'II', 'Lento - Allegro', 'Symphony no. 1, op. 71: II. Lento - Allegro', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 16802 AND p.composer_id = 301
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:be541a35-4fb4-4bfd-af4e-180f00a647de'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = 'Adagio', part.name_en = 'Symphony no. 1, op. 71: III. Adagio',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 16802 AND p.composer_id = 301 AND part.part_key = 'musicbrainz:8b7906e1-d82e-449c-9e8e-d0c60a576265' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:8b7906e1-d82e-449c-9e8e-d0c60a576265', 3, 'III', 'Adagio', 'Symphony no. 1, op. 71: III. Adagio', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 16802 AND p.composer_id = 301
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:8b7906e1-d82e-449c-9e8e-d0c60a576265'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = 'IV',
    part.name_ko = 'Presto', part.name_en = 'Symphony no. 1, op. 71: IV. Presto',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 16802 AND p.composer_id = 301 AND part.part_key = 'musicbrainz:aeb64993-69cc-474b-92a3-423f948ea33c' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:aeb64993-69cc-474b-92a3-423f948ea33c', 4, 'IV', 'Presto', 'Symphony no. 1, op. 71: IV. Presto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 16802 AND p.composer_id = 301
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:aeb64993-69cc-474b-92a3-423f948ea33c'
);


-- None 교향곡 10번 "Alla ricerca di Borromini"

UPDATE pieces piece
SET piece.title = '교향곡 10번 "Alla ricerca di Borromini"', piece.title_en = 'Symphony no. 10, op. 327 "Alla ricerca di Borromini"',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 16784 AND piece.composer_id = 301
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'Adagio', part.name_en = 'Symphony no. 10, op. 327 "Alla ricerca di Borromini": I. Adagio',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 16784 AND p.composer_id = 301 AND part.part_key = 'musicbrainz:92cf01d0-6e0f-4c9d-916c-96d019dd1b60' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:92cf01d0-6e0f-4c9d-916c-96d019dd1b60', 1, 'I', 'Adagio', 'Symphony no. 10, op. 327 "Alla ricerca di Borromini": I. Adagio', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 16784 AND p.composer_id = 301
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:92cf01d0-6e0f-4c9d-916c-96d019dd1b60'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'Allegro', part.name_en = 'Symphony no. 10, op. 327 "Alla ricerca di Borromini": II. Allegro',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 16784 AND p.composer_id = 301 AND part.part_key = 'musicbrainz:8ccb873a-366a-4698-ab3d-0cbcf0549ab2' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:8ccb873a-366a-4698-ab3d-0cbcf0549ab2', 2, 'II', 'Allegro', 'Symphony no. 10, op. 327 "Alla ricerca di Borromini": II. Allegro', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 16784 AND p.composer_id = 301
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:8ccb873a-366a-4698-ab3d-0cbcf0549ab2'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = 'Presto', part.name_en = 'Symphony no. 10, op. 327 "Alla ricerca di Borromini": III. Presto',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 16784 AND p.composer_id = 301 AND part.part_key = 'musicbrainz:2ec5df0b-98f3-41b6-aa07-7ae9c3eb47fe' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:2ec5df0b-98f3-41b6-aa07-7ae9c3eb47fe', 3, 'III', 'Presto', 'Symphony no. 10, op. 327 "Alla ricerca di Borromini": III. Presto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 16784 AND p.composer_id = 301
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:2ec5df0b-98f3-41b6-aa07-7ae9c3eb47fe'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = 'IV',
    part.name_ko = 'Adagio', part.name_en = 'Symphony no. 10, op. 327 "Alla ricerca di Borromini": IV. Adagio',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 16784 AND p.composer_id = 301 AND part.part_key = 'musicbrainz:ddbf9d26-f751-4bed-b211-e59b16b9dc5b' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:ddbf9d26-f751-4bed-b211-e59b16b9dc5b', 4, 'IV', 'Adagio', 'Symphony no. 10, op. 327 "Alla ricerca di Borromini": IV. Adagio', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 16784 AND p.composer_id = 301
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:ddbf9d26-f751-4bed-b211-e59b16b9dc5b'
);


-- Op. 91 교향곡 2번

UPDATE pieces piece
SET piece.title = '교향곡 2번', piece.title_en = 'Symphony no. 2, op. 91',
    piece.type = 'album', piece.opus_number = 'Op. 91',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 17945 AND piece.composer_id = 301
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'Allegro molto - Allegro', part.name_en = 'Symphony no. 2, op. 91: I. Allegro molto - Allegro',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 17945 AND p.composer_id = 301 AND part.part_key = 'musicbrainz:26054528-42c7-4855-bb38-9b23e684edb7' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:26054528-42c7-4855-bb38-9b23e684edb7', 1, 'I', 'Allegro molto - Allegro', 'Symphony no. 2, op. 91: I. Allegro molto - Allegro', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 17945 AND p.composer_id = 301
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:26054528-42c7-4855-bb38-9b23e684edb7'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'Adagio', part.name_en = 'Symphony no. 2, op. 91: II. Adagio',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 17945 AND p.composer_id = 301 AND part.part_key = 'musicbrainz:09fd4067-8348-4115-bcb9-6f69487ad4c1' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:09fd4067-8348-4115-bcb9-6f69487ad4c1', 2, 'II', 'Adagio', 'Symphony no. 2, op. 91: II. Adagio', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 17945 AND p.composer_id = 301
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:09fd4067-8348-4115-bcb9-6f69487ad4c1'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = 'Allegro molto, leggiero', part.name_en = 'Symphony no. 2, op. 91: III. Allegro molto, leggiero',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 17945 AND p.composer_id = 301 AND part.part_key = 'musicbrainz:98603216-4200-4573-a602-1dd169883f8d' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:98603216-4200-4573-a602-1dd169883f8d', 3, 'III', 'Allegro molto, leggiero', 'Symphony no. 2, op. 91: III. Allegro molto, leggiero', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 17945 AND p.composer_id = 301
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:98603216-4200-4573-a602-1dd169883f8d'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = 'IV',
    part.name_ko = 'Adagio, flessible - Poco più mosso - Più mosso - Moderato - Allegro', part.name_en = 'Symphony no. 2, op. 91: IV. Adagio, flessible - Poco più mosso - Più mosso - Moderato - Allegro',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 17945 AND p.composer_id = 301 AND part.part_key = 'musicbrainz:0c3b3fcf-6182-4e5c-8e81-be795781c752' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:0c3b3fcf-6182-4e5c-8e81-be795781c752', 4, 'IV', 'Adagio, flessible - Poco più mosso - Più mosso - Moderato - Allegro', 'Symphony no. 2, op. 91: IV. Adagio, flessible - Poco più mosso - Più mosso - Moderato - Allegro', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 17945 AND p.composer_id = 301
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:0c3b3fcf-6182-4e5c-8e81-be795781c752'
);


-- Op. 119 교향곡 3번

UPDATE pieces piece
SET piece.title = '교향곡 3번', piece.title_en = 'Symphony no. 3, op. 119',
    piece.type = 'album', piece.opus_number = 'Op. 119',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 19031 AND piece.composer_id = 301
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'Lento', part.name_en = 'Symphony no. 3, op. 119: I. Lento',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 19031 AND p.composer_id = 301 AND part.part_key = 'musicbrainz:ad9f2843-be4b-4c14-9519-996d4ccd76db' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:ad9f2843-be4b-4c14-9519-996d4ccd76db', 1, 'I', 'Lento', 'Symphony no. 3, op. 119: I. Lento', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 19031 AND p.composer_id = 301
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:ad9f2843-be4b-4c14-9519-996d4ccd76db'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'Allegro', part.name_en = 'Symphony no. 3, op. 119: II. Allegro',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 19031 AND p.composer_id = 301 AND part.part_key = 'musicbrainz:d95e0567-4599-4977-8269-02abbfb2f43e' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:d95e0567-4599-4977-8269-02abbfb2f43e', 2, 'II', 'Allegro', 'Symphony no. 3, op. 119: II. Allegro', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 19031 AND p.composer_id = 301
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:d95e0567-4599-4977-8269-02abbfb2f43e'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = 'Allegro vivace: Scorrevole e bisbigliando', part.name_en = 'Symphony no. 3, op. 119: III. Allegro vivace: Scorrevole e bisbigliando',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 19031 AND p.composer_id = 301 AND part.part_key = 'musicbrainz:f76a2772-3f4f-4575-984e-130f27ac56d2' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:f76a2772-3f4f-4575-984e-130f27ac56d2', 3, 'III', 'Allegro vivace: Scorrevole e bisbigliando', 'Symphony no. 3, op. 119: III. Allegro vivace: Scorrevole e bisbigliando', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 19031 AND p.composer_id = 301
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:f76a2772-3f4f-4575-984e-130f27ac56d2'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = 'IV',
    part.name_ko = 'Lento - Adagio flessible', part.name_en = 'Symphony no. 3, op. 119: IV. Lento - Adagio flessible',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 19031 AND p.composer_id = 301 AND part.part_key = 'musicbrainz:7ed04044-66b8-4cfb-a0f0-796d206e207a' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:7ed04044-66b8-4cfb-a0f0-796d206e207a', 4, 'IV', 'Lento - Adagio flessible', 'Symphony no. 3, op. 119: IV. Lento - Adagio flessible', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 19031 AND p.composer_id = 301
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:7ed04044-66b8-4cfb-a0f0-796d206e207a'
);


-- Op. 136 교향곡 4번

UPDATE pieces piece
SET piece.title = '교향곡 4번', piece.title_en = 'Symphony no. 4, op. 136',
    piece.type = 'song', piece.opus_number = 'Op. 136',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 19557 AND piece.composer_id = 301
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- Op. 166 교향곡 5번

UPDATE pieces piece
SET piece.title = '교향곡 5번', piece.title_en = 'Symphony no. 5, op. 166',
    piece.type = 'song', piece.opus_number = 'Op. 166',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 19051 AND piece.composer_id = 301
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- Op. 176 교향곡 6번

UPDATE pieces piece
SET piece.title = '교향곡 6번', piece.title_en = 'Symphony no. 6, op. 176',
    piece.type = 'album', piece.opus_number = 'Op. 176',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 15892 AND piece.composer_id = 301
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'Adagio - Allegro', part.name_en = 'Symphony no. 6, op. 176: I. Adagio - Allegro',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 15892 AND p.composer_id = 301 AND part.part_key = 'musicbrainz:1ee44fd9-4f63-4b74-83b5-c1e4369d4026' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:1ee44fd9-4f63-4b74-83b5-c1e4369d4026', 1, 'I', 'Adagio - Allegro', 'Symphony no. 6, op. 176: I. Adagio - Allegro', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 15892 AND p.composer_id = 301
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:1ee44fd9-4f63-4b74-83b5-c1e4369d4026'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'Adagio non troppo - Allegro', part.name_en = 'Symphony no. 6, op. 176: II. Adagio non troppo - Allegro',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 15892 AND p.composer_id = 301 AND part.part_key = 'musicbrainz:963bb695-f74f-4e8c-ac1f-dcfd310f5ace' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:963bb695-f74f-4e8c-ac1f-dcfd310f5ace', 2, 'II', 'Adagio non troppo - Allegro', 'Symphony no. 6, op. 176: II. Adagio non troppo - Allegro', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 15892 AND p.composer_id = 301
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:963bb695-f74f-4e8c-ac1f-dcfd310f5ace'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = 'Adagio - più animato', part.name_en = 'Symphony no. 6, op. 176: III. Adagio - più animato',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 15892 AND p.composer_id = 301 AND part.part_key = 'musicbrainz:b03e996e-7fa1-420b-942b-1afd3530a741' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:b03e996e-7fa1-420b-942b-1afd3530a741', 3, 'III', 'Adagio - più animato', 'Symphony no. 6, op. 176: III. Adagio - più animato', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 15892 AND p.composer_id = 301
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:b03e996e-7fa1-420b-942b-1afd3530a741'
);


-- Op. 211 교향곡 7번

UPDATE pieces piece
SET piece.title = '교향곡 7번', piece.title_en = 'Symphony no. 7, op. 211',
    piece.type = 'song', piece.opus_number = 'Op. 211',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 20009 AND piece.composer_id = 301
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None 교향곡 8번 "Antarctic Symphony"

UPDATE pieces piece
SET piece.title = '교향곡 8번 "Antarctic Symphony"', piece.title_en = 'Symphony no. 8, op. 215 "Antarctic Symphony"',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 17709 AND piece.composer_id = 301
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- Op. 315 교향곡 9번

UPDATE pieces piece
SET piece.title = '교향곡 9번', piece.title_en = 'Symphony no. 9, op. 315',
    piece.type = 'song', piece.opus_number = 'Op. 315',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 18458 AND piece.composer_id = 301
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- Op. 45 오페라 <Taverner> Op. 45

UPDATE pieces piece
SET piece.title = '오페라 <Taverner> Op. 45', piece.title_en = 'Taverner, op. 45',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = 'Op.', piece.catalogue_number = '45',
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 16343 AND piece.composer_id = 301
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'Act I', part.name_en = 'Taverner, op. 45: Act I',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 16343 AND p.composer_id = 301 AND part.part_key = 'musicbrainz:dd4eea85-cf07-4dbb-8a3e-4aa23b7e9a65' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:dd4eea85-cf07-4dbb-8a3e-4aa23b7e9a65', 1, NULL, 'Act I', 'Taverner, op. 45: Act I', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 16343 AND p.composer_id = 301
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:dd4eea85-cf07-4dbb-8a3e-4aa23b7e9a65'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'Act II', part.name_en = 'Taverner, op. 45: Act II',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 16343 AND p.composer_id = 301 AND part.part_key = 'musicbrainz:8f217a5e-fe29-4101-a36d-b11089bc4c1f' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:8f217a5e-fe29-4101-a36d-b11089bc4c1f', 2, NULL, 'Act II', 'Taverner, op. 45: Act II', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 16343 AND p.composer_id = 301
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:8f217a5e-fe29-4101-a36d-b11089bc4c1f'
);


-- Op. 97 The Bairns of Brugh

UPDATE pieces piece
SET piece.title = 'The Bairns of Brugh', piece.title_en = 'The Bairns of Brugh, op. 97',
    piece.type = 'song', piece.opus_number = 'Op. 97',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 19483 AND piece.composer_id = 301
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- Op. 171 The Beltane Fire

UPDATE pieces piece
SET piece.title = 'The Beltane Fire', piece.title_en = 'The Beltane Fire, op. 171',
    piece.type = 'song', piece.opus_number = 'Op. 171',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 16833 AND piece.composer_id = 301
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- Op. 49a 영화음악 <The Devils>

UPDATE pieces piece
SET piece.title = '영화음악 <The Devils>', piece.title_en = 'The Devils, op. 49a',
    piece.type = 'song', piece.opus_number = 'Op. 49a',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 16819 AND piece.composer_id = 301
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- Op. 254 The Fall of the Leafe

UPDATE pieces piece
SET piece.title = 'The Fall of the Leafe', piece.title_en = 'The Fall of the Leafe, op. 254',
    piece.type = 'song', piece.opus_number = 'Op. 254',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 18279 AND piece.composer_id = 301
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None 연가곡집 <The Kestrel Road>

UPDATE pieces piece
SET piece.title = '연가곡집 <The Kestrel Road>', piece.title_en = 'The Kestrel Road',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 17716 AND piece.composer_id = 301
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'The Scarecrow in the Schoolmaster''s Oats', part.name_en = 'The Kestrel Road: I. The Scarecrow in the Schoolmaster''s Oats',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 17716 AND p.composer_id = 301 AND part.part_key = 'musicbrainz:a311cf57-4eca-45f8-a84a-4d09e9028fbf' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:a311cf57-4eca-45f8-a84a-4d09e9028fbf', 1, 'I', 'The Scarecrow in the Schoolmaster''s Oats', 'The Kestrel Road: I. The Scarecrow in the Schoolmaster''s Oats', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 17716 AND p.composer_id = 301
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:a311cf57-4eca-45f8-a84a-4d09e9028fbf'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'Roads', part.name_en = 'The Kestrel Road: II. Roads',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 17716 AND p.composer_id = 301 AND part.part_key = 'musicbrainz:abbece16-aba6-4326-afad-12e7506588be' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:abbece16-aba6-4326-afad-12e7506588be', 2, 'II', 'Roads', 'The Kestrel Road: II. Roads', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 17716 AND p.composer_id = 301
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:abbece16-aba6-4326-afad-12e7506588be'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = 'Ikey Crosses the Ward Hill to the Spanish Wreck', part.name_en = 'The Kestrel Road: III. Ikey Crosses the Ward Hill to the Spanish Wreck',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 17716 AND p.composer_id = 301 AND part.part_key = 'musicbrainz:a3647561-609e-415b-b086-f042c1e1274c' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:a3647561-609e-415b-b086-f042c1e1274c', 3, 'III', 'Ikey Crosses the Ward Hill to the Spanish Wreck', 'The Kestrel Road: III. Ikey Crosses the Ward Hill to the Spanish Wreck', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 17716 AND p.composer_id = 301
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:a3647561-609e-415b-b086-f042c1e1274c'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = 'IV',
    part.name_ko = 'Lighting Candles in Midwinter', part.name_en = 'The Kestrel Road: IV. Lighting Candles in Midwinter',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 17716 AND p.composer_id = 301 AND part.part_key = 'musicbrainz:cb5b00f1-f8d4-416c-8555-919e1be69da0' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:cb5b00f1-f8d4-416c-8555-919e1be69da0', 4, 'IV', 'Lighting Candles in Midwinter', 'The Kestrel Road: IV. Lighting Candles in Midwinter', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 17716 AND p.composer_id = 301
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:cb5b00f1-f8d4-416c-8555-919e1be69da0'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 5, part.movement_number = 'V',
    part.name_ko = 'The Laird', part.name_en = 'The Kestrel Road: V. The Laird',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 17716 AND p.composer_id = 301 AND part.part_key = 'musicbrainz:5d327248-cc08-4704-81cd-0f79727ec607' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:5d327248-cc08-4704-81cd-0f79727ec607', 5, 'V', 'The Laird', 'The Kestrel Road: V. The Laird', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 17716 AND p.composer_id = 301
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:5d327248-cc08-4704-81cd-0f79727ec607'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 6, part.movement_number = 'VI',
    part.name_ko = 'Windfall', part.name_en = 'The Kestrel Road: VI. Windfall',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 17716 AND p.composer_id = 301 AND part.part_key = 'musicbrainz:44d96863-0c6d-4067-b2dd-123bb0b9a123' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:44d96863-0c6d-4067-b2dd-123bb0b9a123', 6, 'VI', 'Windfall', 'The Kestrel Road: VI. Windfall', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 17716 AND p.composer_id = 301
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:44d96863-0c6d-4067-b2dd-123bb0b9a123'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 7, part.movement_number = 'VII',
    part.name_ko = 'Girl', part.name_en = 'The Kestrel Road: VII. Girl',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 17716 AND p.composer_id = 301 AND part.part_key = 'musicbrainz:a27b3fe3-e8bd-42f4-8611-0694fc1c0370' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:a27b3fe3-e8bd-42f4-8611-0694fc1c0370', 7, 'VII', 'Girl', 'The Kestrel Road: VII. Girl', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 17716 AND p.composer_id = 301
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:a27b3fe3-e8bd-42f4-8611-0694fc1c0370'
);


-- Op. 301 The Last Island

UPDATE pieces piece
SET piece.title = 'The Last Island', piece.title_en = 'The Last Island, op. 301',
    piece.type = 'song', piece.opus_number = 'Op. 301',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 18903 AND piece.composer_id = 301
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- Op. 86 오페라 <The Lighthouse>

UPDATE pieces piece
SET piece.title = '오페라 <The Lighthouse>', piece.title_en = 'The Lighthouse, op. 86',
    piece.type = 'song', piece.opus_number = 'Op. 86',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 16675 AND piece.composer_id = 301
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- Op. 72 오페라 <The Martyrdom of St. Magnus>

UPDATE pieces piece
SET piece.title = '오페라 <The Martyrdom of St. Magnus>', piece.title_en = 'The Martyrdom of St. Magnus, op. 72',
    piece.type = 'song', piece.opus_number = 'Op. 72',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 16503 AND piece.composer_id = 301
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- Op. 78a 오페라 <The Two Fiddlers>

UPDATE pieces piece
SET piece.title = '오페라 <The Two Fiddlers>', piece.title_en = 'The Two Fiddlers, op. 78a',
    piece.type = 'song', piece.opus_number = 'Op. 78a',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 17588 AND piece.composer_id = 301
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- Op. 61 Three Voluntaries Op. 61

UPDATE pieces piece
SET piece.title = 'Three Voluntaries Op. 61', piece.title_en = 'Three Voluntaries, op. 61',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = 'Op.', piece.catalogue_number = '61',
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 16611 AND piece.composer_id = 301
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'Psalm 124, op. 61 no. 1', part.name_en = 'Psalm 124, op. 61 no. 1',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 16611 AND p.composer_id = 301 AND part.part_key = 'musicbrainz:13230623-ea32-4630-836f-05821625acda' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:13230623-ea32-4630-836f-05821625acda', 1, NULL, 'Psalm 124, op. 61 no. 1', 'Psalm 124, op. 61 no. 1', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 16611 AND p.composer_id = 301
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:13230623-ea32-4630-836f-05821625acda'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'O God Abufe, op. 61 no. 2', part.name_en = 'O God Abufe, op. 61 no. 2',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 16611 AND p.composer_id = 301 AND part.part_key = 'musicbrainz:bb7f5a8a-40a7-40c0-a929-242eab22167b' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:bb7f5a8a-40a7-40c0-a929-242eab22167b', 2, NULL, 'O God Abufe, op. 61 no. 2', 'O God Abufe, op. 61 no. 2', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 16611 AND p.composer_id = 301
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:bb7f5a8a-40a7-40c0-a929-242eab22167b'
);


-- Op. 141 Threnody on a Plainsong for Michael Vyner

UPDATE pieces piece
SET piece.title = 'Threnody on a Plainsong for Michael Vyner', piece.title_en = 'Threnody on a Plainsong for Michael Vyner, op. 141',
    piece.type = 'song', piece.opus_number = 'Op. 141',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 16748 AND piece.composer_id = 301
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- Op. 181 Throstle's Nest Junction

UPDATE pieces piece
SET piece.title = 'Throstle''s Nest Junction', piece.title_en = 'Throstle''s Nest Junction, op. 181',
    piece.type = 'song', piece.opus_number = 'Op. 181',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 19537 AND piece.composer_id = 301
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- Op. 172 Time and the Raven

UPDATE pieces piece
SET piece.title = 'Time and the Raven', piece.title_en = 'Time and the Raven, op. 172',
    piece.type = 'song', piece.opus_number = 'Op. 172',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 16130 AND piece.composer_id = 301
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- Op. 235 Two Latin Motets Op. 235

UPDATE pieces piece
SET piece.title = 'Two Latin Motets Op. 235', piece.title_en = 'Two Latin Motets, op. 235',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = 'Op.', piece.catalogue_number = '235',
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 19366 AND piece.composer_id = 301
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'Dum complerentur, op. 235 no. 1', part.name_en = 'Dum complerentur, op. 235 no. 1',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 19366 AND p.composer_id = 301 AND part.part_key = 'musicbrainz:ede7060f-fd89-413a-ad0b-3240ef795049' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:ede7060f-fd89-413a-ad0b-3240ef795049', 1, NULL, 'Dum complerentur, op. 235 no. 1', 'Dum complerentur, op. 235 no. 1', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 19366 AND p.composer_id = 301
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:ede7060f-fd89-413a-ad0b-3240ef795049'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'Veni Sancte Spiritus, op. 235 no. 2', part.name_en = 'Veni Sancte Spiritus, op. 235 no. 2',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 19366 AND p.composer_id = 301 AND part.part_key = 'musicbrainz:9417a71a-2fef-4112-8bc7-55907d11cdc2' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:9417a71a-2fef-4112-8bc7-55907d11cdc2', 2, NULL, 'Veni Sancte Spiritus, op. 235 no. 2', 'Veni Sancte Spiritus, op. 235 no. 2', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 19366 AND p.composer_id = 301
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:9417a71a-2fef-4112-8bc7-55907d11cdc2'
);


-- Op. 307 2개의 녹턴 Op. 307

UPDATE pieces piece
SET piece.title = '2개의 녹턴 Op. 307', piece.title_en = 'Two Nocturnes, op. 307',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = 'Op.', piece.catalogue_number = '307',
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 17367 AND piece.composer_id = 301
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'No. 1', part.name_en = 'Two Nocturnes, op. 307: No. 1',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 17367 AND p.composer_id = 301 AND part.part_key = 'musicbrainz:761029fb-8c8a-4d31-b53f-ed78f38123a0' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:761029fb-8c8a-4d31-b53f-ed78f38123a0', 1, NULL, 'No. 1', 'Two Nocturnes, op. 307: No. 1', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 17367 AND p.composer_id = 301
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:761029fb-8c8a-4d31-b53f-ed78f38123a0'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'No. 2', part.name_en = 'Two Nocturnes, op. 307: No. 2',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 17367 AND p.composer_id = 301 AND part.part_key = 'musicbrainz:76736b80-d07d-4ede-b8e3-e3061a5c099e' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:76736b80-d07d-4ede-b8e3-e3061a5c099e', 2, NULL, 'No. 2', 'Two Nocturnes, op. 307: No. 2', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 17367 AND p.composer_id = 301
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:76736b80-d07d-4ede-b8e3-e3061a5c099e'
);


-- Op. 225 Veni Creator Spiritus

UPDATE pieces piece
SET piece.title = 'Veni Creator Spiritus', piece.title_en = 'Veni Creator Spiritus, op. 225',
    piece.type = 'song', piece.opus_number = 'Op. 225',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 17052 AND piece.composer_id = 301
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- Op. 56 Veni Sancte - Veni Creator Spiritus

UPDATE pieces piece
SET piece.title = 'Veni Sancte - Veni Creator Spiritus', piece.title_en = 'Veni Sancte - Veni Creator Spiritus, op. 56',
    piece.type = 'album', piece.opus_number = 'Op. 56',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 16724 AND piece.composer_id = 301
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'Transcription', part.name_en = 'Veni Sancte - Veni Creator Spiritus, op. 56: I. Transcription',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 16724 AND p.composer_id = 301 AND part.part_key = 'musicbrainz:8233818c-ce2c-4371-9b53-fe6fdba7d0f1' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:8233818c-ce2c-4371-9b53-fe6fdba7d0f1', 1, 'I', 'Transcription', 'Veni Sancte - Veni Creator Spiritus, op. 56: I. Transcription', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 16724 AND p.composer_id = 301
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:8233818c-ce2c-4371-9b53-fe6fdba7d0f1'
);


-- None 바이올린 협주곡 2번 "Fiddler on the Shore"

UPDATE pieces piece
SET piece.title = '바이올린 협주곡 2번 "Fiddler on the Shore"', piece.title_en = 'Violin Concerto no. 2, op. 299 "Fiddler on the Shore"',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 17554 AND piece.composer_id = 301
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- Op. 73a 연가곡집 <Westerlings>

UPDATE pieces piece
SET piece.title = '연가곡집 <Westerlings>', piece.title_en = 'Westerlings, op. 73a',
    piece.type = 'song', piece.opus_number = 'Op. 73a',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 20035 AND piece.composer_id = 301
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- Op. 38 모테트 <Worldes Blis>

UPDATE pieces piece
SET piece.title = '모테트 <Worldes Blis>', piece.title_en = 'Worldes Blis, op. 38',
    piece.type = 'song', piece.opus_number = 'Op. 38',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 16054 AND piece.composer_id = 301
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- Op. 89 No. 2 Yesnaby Ground

UPDATE pieces piece
SET piece.title = 'Yesnaby Ground', piece.title_en = 'Yesnaby Ground, op. 89 no. 2',
    piece.type = 'song', piece.opus_number = 'Op. 89 No. 2',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 17282 AND piece.composer_id = 301
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Canon ad honorem Igor Stravinsky

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, 'Canon ad honorem Igor Stravinsky', 'Canon ad honorem Igor Stravinsky', 'song', NULL, NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 301
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = 'Canon ad honorem Igor Stravinsky'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '98dfde71-ba9b-4dad-9bb8-bb48cf38f264'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '98dfde71-ba9b-4dad-9bb8-bb48cf38f264'
FROM pieces p
WHERE p.composer_id = 301 AND p.title = 'Canon ad honorem Igor Stravinsky' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '98dfde71-ba9b-4dad-9bb8-bb48cf38f264'
);


-- None Canon in Memoriam Igor Stravinsky

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, 'Canon in Memoriam Igor Stravinsky', 'Canon in Memoriam Igor Stravinsky', 'song', NULL, NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 301
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = 'Canon in Memoriam Igor Stravinsky'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'bbe8ac69-24a9-4112-b766-c6568557e71e'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'bbe8ac69-24a9-4112-b766-c6568557e71e'
FROM pieces p
WHERE p.composer_id = 301 AND p.title = 'Canon in Memoriam Igor Stravinsky' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'bbe8ac69-24a9-4112-b766-c6568557e71e'
);


-- 카탈로그에 대응이 없는 seed 작품 11개를 목록에서 숨긴다(지우지 않음).
UPDATE pieces piece
SET piece.hidden_reason = 'catalog_unmatched'
WHERE piece.composer_id = 301 AND piece.origin = 'seed' AND piece.hidden_reason IS NULL
  AND piece.id IN (
    16604, 16869, 17263, 17886, 17921, 18237, 18363, 18539, 18579, 19623, 19803
  )
  AND NOT EXISTS (SELECT 1 FROM performance_sectors sector WHERE sector.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM piece_parts linking WHERE linking.linked_piece_id = piece.id);
