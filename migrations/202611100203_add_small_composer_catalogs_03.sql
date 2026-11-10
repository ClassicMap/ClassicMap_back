-- 작곡가 20명의 작품을 MusicBrainz 작품 구조로 다시 짠다(6차 자동, 3/9).
-- 작품 108개(새 9개), seed 108개 중 잇기 99·숨김 7·그대로 2.
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

-- ===== J. A. C. Redford (composer_id 203) =====
-- 작품을 MusicBrainz 작품 구조로 다시 짠다(6차 자동). 작품 0개(묶음 0, 다악장 0, 낱곡 0),
-- 새 작품 0개, part 0개, 그 아래 0개.
-- seed 4개 중 0개를 작품·part 에 잇고, 4개를 숨기고, 0개는 그대로 둔다.

-- 카탈로그에 대응이 없는 seed 작품 4개를 목록에서 숨긴다(지우지 않음).
UPDATE pieces piece
SET piece.hidden_reason = 'catalog_unmatched'
WHERE piece.composer_id = 203 AND piece.origin = 'seed' AND piece.hidden_reason IS NULL
  AND piece.id IN (
    16038, 17733, 18752, 19264
  )
  AND NOT EXISTS (SELECT 1 FROM performance_sectors sector WHERE sector.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM piece_parts linking WHERE linking.linked_piece_id = piece.id);

-- ===== Lodewijk Mortelmans (composer_id 205) =====
-- 작품을 MusicBrainz 작품 구조로 다시 짠다(6차 자동). 작품 16개(묶음 4, 다악장 1, 낱곡 11),
-- 새 작품 1개, part 18개, 그 아래 0개.
-- seed 15개 중 15개를 작품·part 에 잇고, 0개를 숨기고, 0개는 그대로 둔다.

-- None 오페라 <De kinderen der zee>

UPDATE pieces piece
SET piece.title = '오페라 <De kinderen der zee>', piece.title_en = 'De kinderen der zee',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 18801 AND piece.composer_id = 205
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'Dageraad en zonsopging', part.name_en = 'De kinderen der zee: Dageraad en zonsopging',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 18801 AND p.composer_id = 205 AND part.part_key = 'musicbrainz:326f9853-7c6a-4335-92d2-e9b781fc8c8c' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:326f9853-7c6a-4335-92d2-e9b781fc8c8c', 1, NULL, 'Dageraad en zonsopging', 'De kinderen der zee: Dageraad en zonsopging', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 18801 AND p.composer_id = 205
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:326f9853-7c6a-4335-92d2-e9b781fc8c8c'
);


-- None Geef mij eens dien dag

UPDATE pieces piece
SET piece.title = 'Geef mij eens dien dag', piece.title_en = 'Geef mij eens dien dag',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 17454 AND piece.composer_id = 205
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Helios

UPDATE pieces piece
SET piece.title = 'Helios', piece.title_en = 'Helios',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 19953 AND piece.composer_id = 205
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Het wielewaalt en leeuwerkt

UPDATE pieces piece
SET piece.title = 'Het wielewaalt en leeuwerkt', piece.title_en = 'Het wielewaalt en leeuwerkt',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 18941 AND piece.composer_id = 205
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Homerische symfonie

UPDATE pieces piece
SET piece.title = 'Homerische symfonie', piece.title_en = 'Homerische symfonie',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 18724 AND piece.composer_id = 205
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'Van de helden', part.name_en = 'Homerische symfonie: I. Van de helden',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 18724 AND p.composer_id = 205 AND part.part_key = 'musicbrainz:725e7cdf-13e1-47e8-a3c2-132465f76a89' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:725e7cdf-13e1-47e8-a3c2-132465f76a89', 1, 'I', 'Van de helden', 'Homerische symfonie: I. Van de helden', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 18724 AND p.composer_id = 205
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:725e7cdf-13e1-47e8-a3c2-132465f76a89'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'Herinneringen aan Patroklos dood', part.name_en = 'Homerische symfonie: II. Herinneringen aan Patroklos dood',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 18724 AND p.composer_id = 205 AND part.part_key = 'musicbrainz:ad3cc197-b62b-4345-9949-5b4f32e0b594' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:ad3cc197-b62b-4345-9949-5b4f32e0b594', 2, 'II', 'Herinneringen aan Patroklos dood', 'Homerische symfonie: II. Herinneringen aan Patroklos dood', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 18724 AND p.composer_id = 205
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:ad3cc197-b62b-4345-9949-5b4f32e0b594'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = 'Sirenengespeel en gezang', part.name_en = 'Homerische symfonie: III. Sirenengespeel en gezang',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 18724 AND p.composer_id = 205 AND part.part_key = 'musicbrainz:3f9e78fe-2d03-4233-8d78-bb18bcf21e43' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:3f9e78fe-2d03-4233-8d78-bb18bcf21e43', 3, 'III', 'Sirenengespeel en gezang', 'Homerische symfonie: III. Sirenengespeel en gezang', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 18724 AND p.composer_id = 205
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:3f9e78fe-2d03-4233-8d78-bb18bcf21e43'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = 'IV',
    part.name_ko = 'De genius van Hellas', part.name_en = 'Homerische symfonie: IV. De genius van Hellas',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 18724 AND p.composer_id = 205 AND part.part_key = 'musicbrainz:a1ee418e-2d14-4c3a-a67a-5aeaa1191a83' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:a1ee418e-2d14-4c3a-a67a-5aeaa1191a83', 4, 'IV', 'De genius van Hellas', 'Homerische symfonie: IV. De genius van Hellas', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 18724 AND p.composer_id = 205
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:a1ee418e-2d14-4c3a-a67a-5aeaa1191a83'
);


-- None Jesu, wijs en wondermachtig

UPDATE pieces piece
SET piece.title = 'Jesu, wijs en wondermachtig', piece.title_en = 'Jesu, wijs en wondermachtig',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 19721 AND piece.composer_id = 205
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Lente-idylle

UPDATE pieces piece
SET piece.title = 'Lente-idylle', piece.title_en = 'Lente-idylle',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 15722 AND piece.composer_id = 205
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Lied van Mignon

UPDATE pieces piece
SET piece.title = 'Lied van Mignon', piece.title_en = 'Lied van Mignon',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 19369 AND piece.composer_id = 205
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Miniaturen, deel 1

UPDATE pieces piece
SET piece.title = 'Miniaturen, deel 1', piece.title_en = 'Miniaturen, deel 1',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 19856 AND piece.composer_id = 205
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'Eenvoud', part.name_en = 'Miniaturen, deel 1: No. 5. Eenvoud',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 19856 AND p.composer_id = 205 AND part.part_key = 'musicbrainz:06fac5fe-8bea-4c0a-94f8-53ddd6b909a9' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:06fac5fe-8bea-4c0a-94f8-53ddd6b909a9', 1, NULL, 'Eenvoud', 'Miniaturen, deel 1: No. 5. Eenvoud', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 19856 AND p.composer_id = 205
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:06fac5fe-8bea-4c0a-94f8-53ddd6b909a9'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'Moeders slaapliedeken', part.name_en = 'Miniaturen, deel 1: No. 2. Moeders slaapliedeken',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 19856 AND p.composer_id = 205 AND part.part_key = 'musicbrainz:709e5aea-566e-4849-9a59-13794d0cdfc9' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:709e5aea-566e-4849-9a59-13794d0cdfc9', 2, NULL, 'Moeders slaapliedeken', 'Miniaturen, deel 1: No. 2. Moeders slaapliedeken', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 19856 AND p.composer_id = 205
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:709e5aea-566e-4849-9a59-13794d0cdfc9'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = NULL,
    part.name_ko = 'De liereman', part.name_en = 'Miniaturen, deel 1: No. 7. De liereman',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 19856 AND p.composer_id = 205 AND part.part_key = 'musicbrainz:c8e74b37-3981-4d57-8040-0dc03135fae6' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:c8e74b37-3981-4d57-8040-0dc03135fae6', 3, NULL, 'De liereman', 'Miniaturen, deel 1: No. 7. De liereman', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 19856 AND p.composer_id = 205
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:c8e74b37-3981-4d57-8040-0dc03135fae6'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = NULL,
    part.name_ko = 'Lyrisch ogenblik', part.name_en = 'Miniaturen, deel 1: No. 3. Lyrisch ogenblik',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 19856 AND p.composer_id = 205 AND part.part_key = 'musicbrainz:cdadec4f-224f-4023-bec3-2267371fb2ce' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:cdadec4f-224f-4023-bec3-2267371fb2ce', 4, NULL, 'Lyrisch ogenblik', 'Miniaturen, deel 1: No. 3. Lyrisch ogenblik', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 19856 AND p.composer_id = 205
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:cdadec4f-224f-4023-bec3-2267371fb2ce'
);


-- None Miniaturen, deel 2

UPDATE pieces piece
SET piece.title = 'Miniaturen, deel 2', piece.title_en = 'Miniaturen, deel 2',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 19722 AND piece.composer_id = 205
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'Kinderhartje', part.name_en = 'Miniaturen, deel 2: No. 4. Kinderhartje',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 19722 AND p.composer_id = 205 AND part.part_key = 'musicbrainz:146919c5-de94-423b-9181-61be04fb7c37' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:146919c5-de94-423b-9181-61be04fb7c37', 1, NULL, 'Kinderhartje', 'Miniaturen, deel 2: No. 4. Kinderhartje', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 19722 AND p.composer_id = 205
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:146919c5-de94-423b-9181-61be04fb7c37'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'Kristintje danst', part.name_en = 'Miniaturen, deel 2: No. 8. Kristintje danst',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 19722 AND p.composer_id = 205 AND part.part_key = 'musicbrainz:329288db-3327-429e-8872-755c47fa8394' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:329288db-3327-429e-8872-755c47fa8394', 2, NULL, 'Kristintje danst', 'Miniaturen, deel 2: No. 8. Kristintje danst', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 19722 AND p.composer_id = 205
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:329288db-3327-429e-8872-755c47fa8394'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = NULL,
    part.name_ko = 'Eenvouding liedje', part.name_en = 'Miniaturen, deel 2: No. 7. Eenvouding liedje',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 19722 AND p.composer_id = 205 AND part.part_key = 'musicbrainz:ae301b9c-434f-4b4d-ab2f-bad4c6a78c04' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:ae301b9c-434f-4b4d-ab2f-bad4c6a78c04', 3, NULL, 'Eenvouding liedje', 'Miniaturen, deel 2: No. 7. Eenvouding liedje', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 19722 AND p.composer_id = 205
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:ae301b9c-434f-4b4d-ab2f-bad4c6a78c04'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = NULL,
    part.name_ko = 'Nederig bloempje', part.name_en = 'Miniaturen, deel 2: No. 1. Nederig bloempje',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 19722 AND p.composer_id = 205 AND part.part_key = 'musicbrainz:f806b705-c42f-458c-a7f1-2e86ba115a90' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:f806b705-c42f-458c-a7f1-2e86ba115a90', 4, NULL, 'Nederig bloempje', 'Miniaturen, deel 2: No. 1. Nederig bloempje', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 19722 AND p.composer_id = 205
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:f806b705-c42f-458c-a7f1-2e86ba115a90'
);


-- None Miniaturen, deel 3

UPDATE pieces piece
SET piece.title = 'Miniaturen, deel 3', piece.title_en = 'Miniaturen, deel 3',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 16868 AND piece.composer_id = 205
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'Innerlijke vreugde', part.name_en = 'Miniaturen, deel 3: No. 2. Innerlijke vreugde',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 16868 AND p.composer_id = 205 AND part.part_key = 'musicbrainz:3a7e5988-66fa-4d1d-ad36-263b5bb09c31' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:3a7e5988-66fa-4d1d-ad36-263b5bb09c31', 1, NULL, 'Innerlijke vreugde', 'Miniaturen, deel 3: No. 2. Innerlijke vreugde', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 16868 AND p.composer_id = 205
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:3a7e5988-66fa-4d1d-ad36-263b5bb09c31'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'Interludium', part.name_en = 'Miniaturen, deel 3: No. 11. Interludium',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 16868 AND p.composer_id = 205 AND part.part_key = 'musicbrainz:53205031-c75f-4bc4-83d9-c92edc0b6b69' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:53205031-c75f-4bc4-83d9-c92edc0b6b69', 2, NULL, 'Interludium', 'Miniaturen, deel 3: No. 11. Interludium', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 16868 AND p.composer_id = 205
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:53205031-c75f-4bc4-83d9-c92edc0b6b69'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = NULL,
    part.name_ko = 'Stemmingsstukje (la groot)', part.name_en = 'Miniaturen, deel 3: No. 6. Stemmingsstukje (la groot)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 16868 AND p.composer_id = 205 AND part.part_key = 'musicbrainz:6fb19c2d-6dd9-404f-8013-df8312e07b1e' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:6fb19c2d-6dd9-404f-8013-df8312e07b1e', 3, NULL, 'Stemmingsstukje (la groot)', 'Miniaturen, deel 3: No. 6. Stemmingsstukje (la groot)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 16868 AND p.composer_id = 205
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:6fb19c2d-6dd9-404f-8013-df8312e07b1e'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = NULL,
    part.name_ko = 'Stemmingsstukje (la klein)', part.name_en = 'Miniaturen, deel 3: No. 5. Stemmingsstukje (la klein)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 16868 AND p.composer_id = 205 AND part.part_key = 'musicbrainz:a627221f-714e-41b6-994b-e0a66c416f52' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:a627221f-714e-41b6-994b-e0a66c416f52', 4, NULL, 'Stemmingsstukje (la klein)', 'Miniaturen, deel 3: No. 5. Stemmingsstukje (la klein)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 16868 AND p.composer_id = 205
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:a627221f-714e-41b6-994b-e0a66c416f52'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 5, part.movement_number = NULL,
    part.name_ko = 'Lenteopwelling', part.name_en = 'Miniaturen, deel 3: No. 7. Lenteopwelling',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 16868 AND p.composer_id = 205 AND part.part_key = 'musicbrainz:ce70f989-e5db-4c9f-b142-266e4c4f5890' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:ce70f989-e5db-4c9f-b142-266e4c4f5890', 5, NULL, 'Lenteopwelling', 'Miniaturen, deel 3: No. 7. Lenteopwelling', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 16868 AND p.composer_id = 205
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:ce70f989-e5db-4c9f-b142-266e4c4f5890'
);


-- None Miniaturen, deel 3: Stemmingsstukje

UPDATE pieces piece
SET piece.title = 'Miniaturen, deel 3: Stemmingsstukje', piece.title_en = 'Miniaturen, deel 3: Stemmingsstukje',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 16110 AND piece.composer_id = 205
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Minuet varié

UPDATE pieces piece
SET piece.title = 'Minuet varié', piece.title_en = 'Minuet varié',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 18515 AND piece.composer_id = 205
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Morgenstemming

UPDATE pieces piece
SET piece.title = 'Morgenstemming', piece.title_en = 'Morgenstemming',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 15783 AND piece.composer_id = 205
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Mythe der lente

UPDATE pieces piece
SET piece.title = 'Mythe der lente', piece.title_en = 'Mythe der lente',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 15845 AND piece.composer_id = 205
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None In memoriam

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, 'In memoriam', 'In memoriam', 'song', NULL, NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 205
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = 'In memoriam'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '86ab8cf7-4bb0-47b6-85dd-c13cc38bcad0'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '86ab8cf7-4bb0-47b6-85dd-c13cc38bcad0'
FROM pieces p
WHERE p.composer_id = 205 AND p.title = 'In memoriam' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '86ab8cf7-4bb0-47b6-85dd-c13cc38bcad0'
);

-- 숨길 seed 작품 없음

-- ===== Marcial del Adalid y Gurréa (composer_id 208) =====
-- 작품을 MusicBrainz 작품 구조로 다시 짠다(6차 자동). 작품 3개(묶음 1, 다악장 0, 낱곡 2),
-- 새 작품 0개, part 6개, 그 아래 0개.
-- seed 3개 중 3개를 작품·part 에 잇고, 0개를 숨기고, 0개는 그대로 둔다.

-- Op. 9 El lamento

UPDATE pieces piece
SET piece.title = 'El lamento', piece.title_en = 'El lamento, op. 9',
    piece.type = 'song', piece.opus_number = 'Op. 9',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 19897 AND piece.composer_id = 208
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- Op. 10 El último adiós

UPDATE pieces piece
SET piece.title = 'El último adiós', piece.title_en = 'El último adiós, op. 10',
    piece.type = 'song', piece.opus_number = 'Op. 10',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 17498 AND piece.composer_id = 208
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Petits riens (6 valses à la tudesque)

UPDATE pieces piece
SET piece.title = 'Petits riens (6 valses à la tudesque)', piece.title_en = 'Petits riens (6 valses à la tudesque)',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 18684 AND piece.composer_id = 208
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'I', part.name_en = 'Petits riens (6 valses à la tudesque): I',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 18684 AND p.composer_id = 208 AND part.part_key = 'musicbrainz:5b86169b-0909-4260-bcac-29ba8f9203f7' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:5b86169b-0909-4260-bcac-29ba8f9203f7', 1, NULL, 'I', 'Petits riens (6 valses à la tudesque): I', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 18684 AND p.composer_id = 208
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:5b86169b-0909-4260-bcac-29ba8f9203f7'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'II', part.name_en = 'Petits riens (6 valses à la tudesque): II',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 18684 AND p.composer_id = 208 AND part.part_key = 'musicbrainz:2a115efa-78b4-4546-88be-ac8ca55f8473' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:2a115efa-78b4-4546-88be-ac8ca55f8473', 2, NULL, 'II', 'Petits riens (6 valses à la tudesque): II', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 18684 AND p.composer_id = 208
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:2a115efa-78b4-4546-88be-ac8ca55f8473'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = NULL,
    part.name_ko = 'III', part.name_en = 'Petits riens (6 valses à la tudesque): III',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 18684 AND p.composer_id = 208 AND part.part_key = 'musicbrainz:91fbfc35-b372-4aee-93e2-1c95388723df' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:91fbfc35-b372-4aee-93e2-1c95388723df', 3, NULL, 'III', 'Petits riens (6 valses à la tudesque): III', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 18684 AND p.composer_id = 208
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:91fbfc35-b372-4aee-93e2-1c95388723df'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = NULL,
    part.name_ko = 'IV', part.name_en = 'Petits riens (6 valses à la tudesque): IV',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 18684 AND p.composer_id = 208 AND part.part_key = 'musicbrainz:873b5d2d-3e90-49f9-b204-ebcea843a81b' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:873b5d2d-3e90-49f9-b204-ebcea843a81b', 4, NULL, 'IV', 'Petits riens (6 valses à la tudesque): IV', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 18684 AND p.composer_id = 208
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:873b5d2d-3e90-49f9-b204-ebcea843a81b'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 5, part.movement_number = NULL,
    part.name_ko = 'V', part.name_en = 'Petits riens (6 valses à la tudesque): V',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 18684 AND p.composer_id = 208 AND part.part_key = 'musicbrainz:62433cf3-b3db-49f5-9e70-72818989a794' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:62433cf3-b3db-49f5-9e70-72818989a794', 5, NULL, 'V', 'Petits riens (6 valses à la tudesque): V', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 18684 AND p.composer_id = 208
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:62433cf3-b3db-49f5-9e70-72818989a794'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 6, part.movement_number = NULL,
    part.name_ko = 'VI', part.name_en = 'Petits riens (6 valses à la tudesque): VI',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 18684 AND p.composer_id = 208 AND part.part_key = 'musicbrainz:a7ae582f-4133-4016-9481-ec3f77b151b2' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:a7ae582f-4133-4016-9481-ec3f77b151b2', 6, NULL, 'VI', 'Petits riens (6 valses à la tudesque): VI', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 18684 AND p.composer_id = 208
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:a7ae582f-4133-4016-9481-ec3f77b151b2'
);

-- 숨길 seed 작품 없음

-- ===== Henry Février (composer_id 210) =====
-- 작품을 MusicBrainz 작품 구조로 다시 짠다(6차 자동). 작품 4개(묶음 1, 다악장 0, 낱곡 3),
-- 새 작품 0개, part 1개, 그 아래 0개.
-- seed 4개 중 4개를 작품·part 에 잇고, 0개를 숨기고, 0개는 그대로 둔다.

-- None 오페라 <Gismonda>

UPDATE pieces piece
SET piece.title = '오페라 <Gismonda>', piece.title_en = 'Gismonda',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 17459 AND piece.composer_id = 210
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'Acte II. « Dit‐elle vrai ? » … « Dans la paix de ce cloître »', part.name_en = 'Gismonda : Acte II. « Dit‐elle vrai ? » … « Dans la paix de ce cloître »',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 17459 AND p.composer_id = 210 AND part.part_key = 'musicbrainz:c58c4790-b0d1-4079-8599-0dbb9a2e1e77' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:c58c4790-b0d1-4079-8599-0dbb9a2e1e77', 1, NULL, 'Acte II. « Dit‐elle vrai ? » … « Dans la paix de ce cloître »', 'Gismonda : Acte II. « Dit‐elle vrai ? » … « Dans la paix de ce cloître »', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 17459 AND p.composer_id = 210
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:c58c4790-b0d1-4079-8599-0dbb9a2e1e77'
);


-- None 가곡 <L'Oiseau>

UPDATE pieces piece
SET piece.title = '가곡 <L''Oiseau>', piece.title_en = 'L''Oiseau',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 18160 AND piece.composer_id = 210
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None 가곡 <La Dernière Chanson>

UPDATE pieces piece
SET piece.title = '가곡 <La Dernière Chanson>', piece.title_en = 'La Dernière Chanson',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 18424 AND piece.composer_id = 210
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None 오페라 <Monna Vanna>

UPDATE pieces piece
SET piece.title = '오페라 <Monna Vanna>', piece.title_en = 'Monna Vanna',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 17796 AND piece.composer_id = 210
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

-- 숨길 seed 작품 없음

-- ===== Micha Hamel (composer_id 211) =====
-- 작품을 MusicBrainz 작품 구조로 다시 짠다(6차 자동). 작품 2개(묶음 0, 다악장 0, 낱곡 2),
-- 새 작품 0개, part 0개, 그 아래 0개.
-- seed 2개 중 2개를 작품·part 에 잇고, 0개를 숨기고, 0개는 그대로 둔다.

-- None Femke d’r Solo

UPDATE pieces piece
SET piece.title = 'Femke d’r Solo', piece.title_en = 'Femke d’r Solo',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 17727 AND piece.composer_id = 211
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None There Was Nothing Nobody Could Say

UPDATE pieces piece
SET piece.title = 'There Was Nothing Nobody Could Say', piece.title_en = 'There Was Nothing Nobody Could Say',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 16208 AND piece.composer_id = 211
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

-- 숨길 seed 작품 없음

-- ===== Jerzy Fitelberg (composer_id 214) =====
-- 작품을 MusicBrainz 작품 구조로 다시 짠다(6차 자동). 작품 6개(묶음 0, 다악장 4, 낱곡 2),
-- 새 작품 2개, part 14개, 그 아래 0개.
-- seed 4개 중 4개를 작품·part 에 잇고, 0개를 숨기고, 0개는 그대로 둔다.

-- None 첼로 소나타

UPDATE pieces piece
SET piece.title = '첼로 소나타', piece.title_en = 'Cello Sonata',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 16341 AND piece.composer_id = 214
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'III',
    part.name_ko = 'Andante', part.name_en = 'Cello Sonata: III. Andante',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 16341 AND p.composer_id = 214 AND part.part_key = 'musicbrainz:d8276b49-c6d9-409a-acbe-705193d626d2' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:d8276b49-c6d9-409a-acbe-705193d626d2', 1, 'III', 'Andante', 'Cello Sonata: III. Andante', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 16341 AND p.composer_id = 214
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:d8276b49-c6d9-409a-acbe-705193d626d2'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'IV',
    part.name_ko = 'Tempo giusto', part.name_en = 'Cello Sonata: IV. Tempo giusto',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 16341 AND p.composer_id = 214 AND part.part_key = 'musicbrainz:9ba2365a-755f-41f3-a4c0-6f782c115843' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:9ba2365a-755f-41f3-a4c0-6f782c115843', 2, 'IV', 'Tempo giusto', 'Cello Sonata: IV. Tempo giusto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 16341 AND p.composer_id = 214
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:9ba2365a-755f-41f3-a4c0-6f782c115843'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'II',
    part.name_ko = 'Moderato', part.name_en = 'Cello Sonata: II. Moderato',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 16341 AND p.composer_id = 214 AND part.part_key = 'musicbrainz:46737f0b-ce63-4af0-96c1-e8c795c0629f' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:46737f0b-ce63-4af0-96c1-e8c795c0629f', 3, 'II', 'Moderato', 'Cello Sonata: II. Moderato', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 16341 AND p.composer_id = 214
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:46737f0b-ce63-4af0-96c1-e8c795c0629f'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = 'I',
    part.name_ko = 'Maestoso', part.name_en = 'Cello Sonata: I. Maestoso',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 16341 AND p.composer_id = 214 AND part.part_key = 'musicbrainz:7535e05d-acab-4707-ad9a-f1d58d02752f' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:7535e05d-acab-4707-ad9a-f1d58d02752f', 4, 'I', 'Maestoso', 'Cello Sonata: I. Maestoso', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 16341 AND p.composer_id = 214
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:7535e05d-acab-4707-ad9a-f1d58d02752f'
);


-- Op. 9 Nachtmusik

UPDATE pieces piece
SET piece.title = 'Nachtmusik', piece.title_en = 'Nachtmusik, op. 9',
    piece.type = 'song', piece.opus_number = 'Op. 9',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 17766 AND piece.composer_id = 214
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None 비올라와 피아노를 위한 세레나데

UPDATE pieces piece
SET piece.title = '비올라와 피아노를 위한 세레나데', piece.title_en = 'Serenade for Viola and Piano',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 17450 AND piece.composer_id = 214
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Sonatine for Two Violins

UPDATE pieces piece
SET piece.title = 'Sonatine for Two Violins', piece.title_en = 'Sonatine for Two Violins',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 16050 AND piece.composer_id = 214
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'Allegro moderato', part.name_en = 'Sonatine for Two Violins: I. Allegro moderato',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 16050 AND p.composer_id = 214 AND part.part_key = 'musicbrainz:57bac4bd-adca-40eb-b361-040eaa3b46ec' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:57bac4bd-adca-40eb-b361-040eaa3b46ec', 1, 'I', 'Allegro moderato', 'Sonatine for Two Violins: I. Allegro moderato', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 16050 AND p.composer_id = 214
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:57bac4bd-adca-40eb-b361-040eaa3b46ec'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'Tema con variazioni', part.name_en = 'Sonatine for Two Violins: II. Tema con variazioni',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 16050 AND p.composer_id = 214 AND part.part_key = 'musicbrainz:461e9a9c-2e4a-4e6e-a2a0-ebae1f131ae6' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:461e9a9c-2e4a-4e6e-a2a0-ebae1f131ae6', 2, 'II', 'Tema con variazioni', 'Sonatine for Two Violins: II. Tema con variazioni', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 16050 AND p.composer_id = 214
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:461e9a9c-2e4a-4e6e-a2a0-ebae1f131ae6'
);


-- None 현악 4중주 1번

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '현악 4중주 1번', 'String Quartet no. 1', 'album', NULL, NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 214
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '현악 4중주 1번'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '81bf86fd-a47e-4b5c-be10-1b197310d57b'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '81bf86fd-a47e-4b5c-be10-1b197310d57b'
FROM pieces p
WHERE p.composer_id = 214 AND p.title = '현악 4중주 1번' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '81bf86fd-a47e-4b5c-be10-1b197310d57b'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:e57728d9-b653-479b-9d06-e127b9497497', 1, 'I', 'Presto - Meno mosso - Tempo I', 'String Quartet no. 1: I. Presto - Meno mosso - Tempo I', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 214 AND p.title = '현악 4중주 1번' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:e57728d9-b653-479b-9d06-e127b9497497'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:4e44e997-bc3c-4e78-b334-556b07797e39', 2, 'II', 'Andante', 'String Quartet no. 1: II. Andante', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 214 AND p.title = '현악 4중주 1번' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:4e44e997-bc3c-4e78-b334-556b07797e39'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:dcf5b677-89ee-4260-9d2c-f4ff544ea1d0', 3, 'III', 'Allegro', 'String Quartet no. 1: III. Allegro', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 214 AND p.title = '현악 4중주 1번' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:dcf5b677-89ee-4260-9d2c-f4ff544ea1d0'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:51668e68-3b36-4fb3-a8f0-253c56a28ea4', 4, 'IV', 'Molto allegro', 'String Quartet no. 1: IV. Molto allegro', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 214 AND p.title = '현악 4중주 1번' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:51668e68-3b36-4fb3-a8f0-253c56a28ea4'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:5d035bd3-b790-4932-b83f-ba7afc60d75c', 5, 'V', 'Presto - Meno mosso - Tempo I', 'String Quartet no. 1: V. Presto - Meno mosso - Tempo I', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 214 AND p.title = '현악 4중주 1번' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:5d035bd3-b790-4932-b83f-ba7afc60d75c'
);


-- None 현악 4중주 2번

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '현악 4중주 2번', 'String Quartet no. 2', 'album', NULL, NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 214
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '현악 4중주 2번'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '496309b3-31bd-4d3d-896c-0c61078164c0'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '496309b3-31bd-4d3d-896c-0c61078164c0'
FROM pieces p
WHERE p.composer_id = 214 AND p.title = '현악 4중주 2번' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '496309b3-31bd-4d3d-896c-0c61078164c0'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:0bcf0e5d-1cb5-4952-9aad-9346ee584775', 1, NULL, 'Presto -', 'String Quartet no. 2: Presto -', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 214 AND p.title = '현악 4중주 2번' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:0bcf0e5d-1cb5-4952-9aad-9346ee584775'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:3bf7f893-36aa-45de-8fd2-58838fc5c7a5', 2, NULL, 'Andante -', 'String Quartet no. 2: Andante -', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 214 AND p.title = '현악 4중주 2번' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:3bf7f893-36aa-45de-8fd2-58838fc5c7a5'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:20937e43-e7d8-41ac-8466-f45eb8bb21cc', 3, NULL, 'Presto', 'String Quartet no. 2: Presto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 214 AND p.title = '현악 4중주 2번' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:20937e43-e7d8-41ac-8466-f45eb8bb21cc'
);

-- 숨길 seed 작품 없음

-- ===== 프랑코 페레라 (composer_id 216) =====
-- 작품을 MusicBrainz 작품 구조로 다시 짠다(6차 자동). 작품 4개(묶음 0, 다악장 0, 낱곡 4),
-- 새 작품 1개, part 0개, 그 아래 0개.
-- seed 3개 중 3개를 작품·part 에 잇고, 0개를 숨기고, 0개는 그대로 둔다.

-- None Burlesca

UPDATE pieces piece
SET piece.title = 'Burlesca', piece.title_en = 'Burlesca',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 20075 AND piece.composer_id = 216
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Fantasia Tragica

UPDATE pieces piece
SET piece.title = 'Fantasia Tragica', piece.title_en = 'Fantasia Tragica',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 18693 AND piece.composer_id = 216
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Notte di Tempesta

UPDATE pieces piece
SET piece.title = 'Notte di Tempesta', piece.title_en = 'Notte di Tempesta',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 19652 AND piece.composer_id = 216
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None 전주곡

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '전주곡', 'Preludio', 'song', NULL, NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 216
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '전주곡'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '156b2d08-34ed-42e5-b9a9-ab9183a96f51'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '156b2d08-34ed-42e5-b9a9-ab9183a96f51'
FROM pieces p
WHERE p.composer_id = 216 AND p.title = '전주곡' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '156b2d08-34ed-42e5-b9a9-ab9183a96f51'
);

-- 숨길 seed 작품 없음

-- ===== Heikki Suolahti (composer_id 217) =====
-- 작품을 MusicBrainz 작품 구조로 다시 짠다(6차 자동). 작품 1개(묶음 0, 다악장 1, 낱곡 0),
-- 새 작품 0개, part 4개, 그 아래 0개.
-- seed 1개 중 1개를 작품·part 에 잇고, 0개를 숨기고, 0개는 그대로 둔다.

-- None Sinfonia piccola

UPDATE pieces piece
SET piece.title = 'Sinfonia piccola', piece.title_en = 'Sinfonia piccola',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 17109 AND piece.composer_id = 217
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'Andante, ma non troppo', part.name_en = 'Sinfonia piccola: I. Andante, ma non troppo',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 17109 AND p.composer_id = 217 AND part.part_key = 'musicbrainz:979d99fc-4613-42a6-a3b0-eb5358928e64' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:979d99fc-4613-42a6-a3b0-eb5358928e64', 1, 'I', 'Andante, ma non troppo', 'Sinfonia piccola: I. Andante, ma non troppo', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 17109 AND p.composer_id = 217
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:979d99fc-4613-42a6-a3b0-eb5358928e64'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'Adagio', part.name_en = 'Sinfonia piccola: II. Adagio',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 17109 AND p.composer_id = 217 AND part.part_key = 'musicbrainz:af65e23a-b4bf-4c63-84a6-a24e4662d6a4' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:af65e23a-b4bf-4c63-84a6-a24e4662d6a4', 2, 'II', 'Adagio', 'Sinfonia piccola: II. Adagio', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 17109 AND p.composer_id = 217
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:af65e23a-b4bf-4c63-84a6-a24e4662d6a4'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = 'Scherzo', part.name_en = 'Sinfonia piccola: III. Scherzo',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 17109 AND p.composer_id = 217 AND part.part_key = 'musicbrainz:afcfb806-ecc3-48da-9cea-cc8e50e7265a' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:afcfb806-ecc3-48da-9cea-cc8e50e7265a', 3, 'III', 'Scherzo', 'Sinfonia piccola: III. Scherzo', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 17109 AND p.composer_id = 217
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:afcfb806-ecc3-48da-9cea-cc8e50e7265a'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = 'IV',
    part.name_ko = 'Finale', part.name_en = 'Sinfonia piccola: IV. Finale',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 17109 AND p.composer_id = 217 AND part.part_key = 'musicbrainz:bf85276d-4f8e-4f72-9f16-ea176b7b4559' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:bf85276d-4f8e-4f72-9f16-ea176b7b4559', 4, 'IV', 'Finale', 'Sinfonia piccola: IV. Finale', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 17109 AND p.composer_id = 217
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:bf85276d-4f8e-4f72-9f16-ea176b7b4559'
);

-- 숨길 seed 작품 없음

-- ===== 빅토르 코센코 (composer_id 221) =====
-- 작품을 MusicBrainz 작품 구조로 다시 짠다(6차 자동). 작품 9개(묶음 6, 다악장 2, 낱곡 1),
-- 새 작품 0개, part 20개, 그 아래 0개.
-- seed 9개 중 9개를 작품·part 에 잇고, 0개를 숨기고, 0개는 그대로 둔다.

-- Op. 8 11개의 연습곡 Op. 8

UPDATE pieces piece
SET piece.title = '11개의 연습곡 Op. 8', piece.title_en = '11 Etudes, op. 8',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = 'Op.', piece.catalogue_number = '8',
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 18482 AND piece.composer_id = 221
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'B♭단조', part.name_en = '11 Etudes, op. 8: No. 2 in B-flat minor',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 18482 AND p.composer_id = 221 AND part.part_key = 'musicbrainz:082571b6-db90-4b0e-8f71-3e34a58150c6' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:082571b6-db90-4b0e-8f71-3e34a58150c6', 1, NULL, 'B♭단조', '11 Etudes, op. 8: No. 2 in B-flat minor', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 18482 AND p.composer_id = 221
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:082571b6-db90-4b0e-8f71-3e34a58150c6'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'F♯장조', part.name_en = '11 Etudes, op. 8: No. 8 in F-sharp major',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 18482 AND p.composer_id = 221 AND part.part_key = 'musicbrainz:1b73b642-7157-4391-b3e5-189b0d1e0aa7' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:1b73b642-7157-4391-b3e5-189b0d1e0aa7', 2, NULL, 'F♯장조', '11 Etudes, op. 8: No. 8 in F-sharp major', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 18482 AND p.composer_id = 221
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:1b73b642-7157-4391-b3e5-189b0d1e0aa7'
);


-- Op. 12 2 Poèmes-Legends Op. 12

UPDATE pieces piece
SET piece.title = '2 Poèmes-Legends Op. 12', piece.title_en = '2 Poèmes-Legends, op. 12',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = 'Op.', piece.catalogue_number = '12',
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 18073 AND piece.composer_id = 221
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'in E minor. Con afflizione', part.name_en = '2 Poèmes-Legends, op. 12: No. 1 in E minor. Con afflizione',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 18073 AND p.composer_id = 221 AND part.part_key = 'musicbrainz:434aadc5-c3c3-40cc-98aa-3be51236d32a' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:434aadc5-c3c3-40cc-98aa-3be51236d32a', 1, NULL, 'in E minor. Con afflizione', '2 Poèmes-Legends, op. 12: No. 1 in E minor. Con afflizione', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 18073 AND p.composer_id = 221
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:434aadc5-c3c3-40cc-98aa-3be51236d32a'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'in E-flat minor. Drammatico', part.name_en = '2 Poèmes-Legends, op. 12: No. 2 in E-flat minor. Drammatico',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 18073 AND p.composer_id = 221 AND part.part_key = 'musicbrainz:bcbd9c43-7df1-416f-9a11-99c3848f6acd' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:bcbd9c43-7df1-416f-9a11-99c3848f6acd', 2, NULL, 'in E-flat minor. Drammatico', '2 Poèmes-Legends, op. 12: No. 2 in E-flat minor. Drammatico', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 18073 AND p.composer_id = 221
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:bcbd9c43-7df1-416f-9a11-99c3848f6acd'
);


-- Op. 3 3개의 마주르카 Op. 3

UPDATE pieces piece
SET piece.title = '3개의 마주르카 Op. 3', piece.title_en = '3 Mazurkas, op. 3',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = 'Op.', piece.catalogue_number = '3',
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 18171 AND piece.composer_id = 221
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'in F-sharp minor. Moderato', part.name_en = '3 Mazurkas, op. 3: No. 1 in F-sharp minor. Moderato',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 18171 AND p.composer_id = 221 AND part.part_key = 'musicbrainz:647cd83b-70a0-4945-9bdc-ec8c1cfdd158' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:647cd83b-70a0-4945-9bdc-ec8c1cfdd158', 1, NULL, 'in F-sharp minor. Moderato', '3 Mazurkas, op. 3: No. 1 in F-sharp minor. Moderato', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 18171 AND p.composer_id = 221
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:647cd83b-70a0-4945-9bdc-ec8c1cfdd158'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'in D-flat major. Quasi allegretto', part.name_en = '3 Mazurkas, op. 3: No. 2 in D-flat major. Quasi allegretto',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 18171 AND p.composer_id = 221 AND part.part_key = 'musicbrainz:74a54806-18ab-4468-aaa2-b09c275a69ac' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:74a54806-18ab-4468-aaa2-b09c275a69ac', 2, NULL, 'in D-flat major. Quasi allegretto', '3 Mazurkas, op. 3: No. 2 in D-flat major. Quasi allegretto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 18171 AND p.composer_id = 221
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:74a54806-18ab-4468-aaa2-b09c275a69ac'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = NULL,
    part.name_ko = 'in C-sharp minor. Lento ma non troppo', part.name_en = '3 Mazurkas, op. 3: No. 3 in C-sharp minor. Lento ma non troppo',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 18171 AND p.composer_id = 221 AND part.part_key = 'musicbrainz:d24ccce3-4ebb-4a27-8731-c5f4ee1e696f' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:d24ccce3-4ebb-4a27-8731-c5f4ee1e696f', 3, NULL, 'in C-sharp minor. Lento ma non troppo', '3 Mazurkas, op. 3: No. 3 in C-sharp minor. Lento ma non troppo', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 18171 AND p.composer_id = 221
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:d24ccce3-4ebb-4a27-8731-c5f4ee1e696f'
);


-- Op. 4 Nocturne-Fantaisie

UPDATE pieces piece
SET piece.title = 'Nocturne-Fantaisie', piece.title_en = 'Nocturne-Fantaisie, op. 4',
    piece.type = 'song', piece.opus_number = 'Op. 4',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 20026 AND piece.composer_id = 221
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- Op. 14 피아노 소나타 2번 C♯단조

UPDATE pieces piece
SET piece.title = '피아노 소나타 2번 C♯단조', piece.title_en = 'Piano Sonata no. 2 in C-sharp minor, op. 14',
    piece.type = 'album', piece.opus_number = 'Op. 14',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 18552 AND piece.composer_id = 221
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'Andante con moto', part.name_en = 'Piano Sonata no. 2 in C-sharp minor, op. 14: I. Andante con moto',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 18552 AND p.composer_id = 221 AND part.part_key = 'musicbrainz:06084a74-1ae1-4cc3-a363-0026606024ef' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:06084a74-1ae1-4cc3-a363-0026606024ef', 1, 'I', 'Andante con moto', 'Piano Sonata no. 2 in C-sharp minor, op. 14: I. Andante con moto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 18552 AND p.composer_id = 221
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:06084a74-1ae1-4cc3-a363-0026606024ef'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'Moderato assai espressivo', part.name_en = 'Piano Sonata no. 2 in C-sharp minor, op. 14: II. Moderato assai espressivo',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 18552 AND p.composer_id = 221 AND part.part_key = 'musicbrainz:5dc76274-c666-4bb7-9292-f17e61068381' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:5dc76274-c666-4bb7-9292-f17e61068381', 2, 'II', 'Moderato assai espressivo', 'Piano Sonata no. 2 in C-sharp minor, op. 14: II. Moderato assai espressivo', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 18552 AND p.composer_id = 221
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:5dc76274-c666-4bb7-9292-f17e61068381'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = 'Allegro vivo', part.name_en = 'Piano Sonata no. 2 in C-sharp minor, op. 14: III. Allegro vivo',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 18552 AND p.composer_id = 221 AND part.part_key = 'musicbrainz:aa89c548-ced0-429a-a34e-24da6ad6774f' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:aa89c548-ced0-429a-a34e-24da6ad6774f', 3, 'III', 'Allegro vivo', 'Piano Sonata no. 2 in C-sharp minor, op. 14: III. Allegro vivo', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 18552 AND p.composer_id = 221
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:aa89c548-ced0-429a-a34e-24da6ad6774f'
);


-- Op. 11 Poeme-Fantaisies Op. 11

UPDATE pieces piece
SET piece.title = 'Poeme-Fantaisies Op. 11', piece.title_en = 'Poeme-Fantaisies, op. 11',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = 'Op.', piece.catalogue_number = '11',
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 18570 AND piece.composer_id = 221
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'in C-sharp minor "Desire"', part.name_en = 'Poeme-Fantaisies, op. 11: No. 1 in C-sharp minor "Desire"',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 18570 AND p.composer_id = 221 AND part.part_key = 'musicbrainz:d7bcde78-3b93-413a-9cfb-f8d93d35eecd' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:d7bcde78-3b93-413a-9cfb-f8d93d35eecd', 1, NULL, 'in C-sharp minor "Desire"', 'Poeme-Fantaisies, op. 11: No. 1 in C-sharp minor "Desire"', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 18570 AND p.composer_id = 221
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:d7bcde78-3b93-413a-9cfb-f8d93d35eecd'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'No. 2', part.name_en = 'Poeme-Fantaisies, op. 11: No. 2',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 18570 AND p.composer_id = 221 AND part.part_key = 'musicbrainz:f8a4edf9-c4da-491a-8987-b878327258d0' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:f8a4edf9-c4da-491a-8987-b878327258d0', 2, NULL, 'No. 2', 'Poeme-Fantaisies, op. 11: No. 2', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 18570 AND p.composer_id = 221
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:f8a4edf9-c4da-491a-8987-b878327258d0'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = NULL,
    part.name_ko = 'in C-sharp minor "Tragic"', part.name_en = 'Poeme-Fantaisies, op. 11: No. 3 in C-sharp minor "Tragic"',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 18570 AND p.composer_id = 221 AND part.part_key = 'musicbrainz:4e4bf771-c7a8-4b89-8e80-c60d2816e00d' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:4e4bf771-c7a8-4b89-8e80-c60d2816e00d', 3, NULL, 'in C-sharp minor "Tragic"', 'Poeme-Fantaisies, op. 11: No. 3 in C-sharp minor "Tragic"', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 18570 AND p.composer_id = 221
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:4e4bf771-c7a8-4b89-8e80-c60d2816e00d'
);


-- Op. 9 3개의 소품 Op. 9

UPDATE pieces piece
SET piece.title = '3개의 소품 Op. 9', piece.title_en = 'Three Pieces, op. 9',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = 'Op.', piece.catalogue_number = '9',
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 18116 AND piece.composer_id = 221
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'Consolation', part.name_en = 'Three Pieces, op. 9: No. 1. Consolation',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 18116 AND p.composer_id = 221 AND part.part_key = 'musicbrainz:d093ca2e-46f1-4785-9115-38ad9e1d4cf8' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:d093ca2e-46f1-4785-9115-38ad9e1d4cf8', 1, NULL, 'Consolation', 'Three Pieces, op. 9: No. 1. Consolation', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 18116 AND p.composer_id = 221
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:d093ca2e-46f1-4785-9115-38ad9e1d4cf8'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'Mazurka', part.name_en = 'Three Pieces, op. 9: No. 2. Mazurka',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 18116 AND p.composer_id = 221 AND part.part_key = 'musicbrainz:79e39e58-e9cc-4321-8b0d-8013e5840664' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:79e39e58-e9cc-4321-8b0d-8013e5840664', 2, NULL, 'Mazurka', 'Three Pieces, op. 9: No. 2. Mazurka', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 18116 AND p.composer_id = 221
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:79e39e58-e9cc-4321-8b0d-8013e5840664'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = NULL,
    part.name_ko = 'Nocturne', part.name_en = 'Three Pieces, op. 9: No. 3. Nocturne',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 18116 AND p.composer_id = 221 AND part.part_key = 'musicbrainz:64cefa33-a3e9-4fa0-a088-bac88913464a' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:64cefa33-a3e9-4fa0-a088-bac88913464a', 3, NULL, 'Nocturne', 'Three Pieces, op. 9: No. 3. Nocturne', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 18116 AND p.composer_id = 221
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:64cefa33-a3e9-4fa0-a088-bac88913464a'
);


-- Op. 7 12개의 로망스 Op. 7

UPDATE pieces piece
SET piece.title = '12개의 로망스 Op. 7', piece.title_en = 'Twelve Romances, op. 7',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = 'Op.', piece.catalogue_number = '7',
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 19971 AND piece.composer_id = 221
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'Вони стояли мовчки, op. 7 no. 2', part.name_en = 'Вони стояли мовчки, op. 7 no. 2',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 19971 AND p.composer_id = 221 AND part.part_key = 'musicbrainz:50ec317c-826d-4042-9be5-ebff78e01883' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:50ec317c-826d-4042-9be5-ebff78e01883', 1, NULL, 'Вони стояли мовчки, op. 7 no. 2', 'Вони стояли мовчки, op. 7 no. 2', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 19971 AND p.composer_id = 221
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:50ec317c-826d-4042-9be5-ebff78e01883'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'Сумний я, op. 7 no. 10', part.name_en = 'Сумний я, op. 7 no. 10',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 19971 AND p.composer_id = 221 AND part.part_key = 'musicbrainz:dd7a7c45-f45b-4a0b-b864-51db73dec26b' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:dd7a7c45-f45b-4a0b-b864-51db73dec26b', 2, NULL, 'Сумний я, op. 7 no. 10', 'Сумний я, op. 7 no. 10', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 19971 AND p.composer_id = 221
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:dd7a7c45-f45b-4a0b-b864-51db73dec26b'
);


-- Op. 18 바이올린 소나타 A단조

UPDATE pieces piece
SET piece.title = '바이올린 소나타 A단조', piece.title_en = 'Violin Sonata in A minor, op. 18',
    piece.type = 'album', piece.opus_number = 'Op. 18',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 18122 AND piece.composer_id = 221
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'Allegro', part.name_en = 'Violin Sonata in A minor, op. 18: I. Allegro',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 18122 AND p.composer_id = 221 AND part.part_key = 'musicbrainz:655a966d-ba1b-4a8d-8b35-a3d80ee0695c' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:655a966d-ba1b-4a8d-8b35-a3d80ee0695c', 1, 'I', 'Allegro', 'Violin Sonata in A minor, op. 18: I. Allegro', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 18122 AND p.composer_id = 221
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:655a966d-ba1b-4a8d-8b35-a3d80ee0695c'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'Andantino semplice', part.name_en = 'Violin Sonata in A minor, op. 18: II. Andantino semplice',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 18122 AND p.composer_id = 221 AND part.part_key = 'musicbrainz:05907a6e-43a7-47ed-b8ff-2a6a25bef407' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:05907a6e-43a7-47ed-b8ff-2a6a25bef407', 2, 'II', 'Andantino semplice', 'Violin Sonata in A minor, op. 18: II. Andantino semplice', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 18122 AND p.composer_id = 221
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:05907a6e-43a7-47ed-b8ff-2a6a25bef407'
);

-- 숨길 seed 작품 없음

-- ===== Ernest Pingoud (composer_id 223) =====
-- 작품을 MusicBrainz 작품 구조로 다시 짠다(6차 자동). 작품 6개(묶음 0, 다악장 0, 낱곡 6),
-- 새 작품 0개, part 0개, 그 아래 0개.
-- seed 6개 중 6개를 작품·part 에 잇고, 0개를 숨기고, 0개는 그대로 둔다.

-- Op. 15 Chantecler

UPDATE pieces piece
SET piece.title = 'Chantecler', piece.title_en = 'Chantecler, op. 15',
    piece.type = 'song', piece.opus_number = 'Op. 15',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 15854 AND piece.composer_id = 223
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- Op. 14 Flambeaux éteints

UPDATE pieces piece
SET piece.title = 'Flambeaux éteints', piece.title_en = 'Flambeaux éteints, op. 14',
    piece.type = 'song', piece.opus_number = 'Op. 14',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 16648 AND piece.composer_id = 223
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Le Chant de l'espace

UPDATE pieces piece
SET piece.title = 'Le Chant de l''espace', piece.title_en = 'Le Chant de l''espace',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 19629 AND piece.composer_id = 223
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Le Fétich, op. 7 (Diableries galantes)

UPDATE pieces piece
SET piece.title = 'Le Fétich, op. 7 (Diableries galantes)', piece.title_en = 'Le Fétich, op. 7 (Diableries galantes)',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 17355 AND piece.composer_id = 223
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- Op. 21 Le Prophète

UPDATE pieces piece
SET piece.title = 'Le Prophète', piece.title_en = 'Le Prophète, op. 21',
    piece.type = 'song', piece.opus_number = 'Op. 21',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 16472 AND piece.composer_id = 223
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Tango oriental

UPDATE pieces piece
SET piece.title = 'Tango oriental', piece.title_en = 'Tango oriental',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 18451 AND piece.composer_id = 223
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

-- 숨길 seed 작품 없음

-- ===== 반브리 (composer_id 227) =====
-- 작품을 MusicBrainz 작품 구조로 다시 짠다(6차 자동). 작품 3개(묶음 0, 다악장 0, 낱곡 3),
-- 새 작품 0개, part 0개, 그 아래 0개.
-- seed 3개 중 3개를 작품·part 에 잇고, 0개를 숨기고, 0개는 그대로 둔다.

-- None Allegro voor vier strijkkwartetten

UPDATE pieces piece
SET piece.title = 'Allegro voor vier strijkkwartetten', piece.title_en = 'Allegro voor vier strijkkwartetten',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 15799 AND piece.composer_id = 227
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Concert Overture in B minor

UPDATE pieces piece
SET piece.title = 'Concert Overture in B minor', piece.title_en = 'Concert Overture in B minor',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 17857 AND piece.composer_id = 227
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Overture ‘Le Bandit’

UPDATE pieces piece
SET piece.title = 'Overture ‘Le Bandit’', piece.title_en = 'Overture ‘Le Bandit’',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 16437 AND piece.composer_id = 227
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

-- 숨길 seed 작품 없음

-- ===== Cemal Reşit Rey (composer_id 230) =====
-- 작품을 MusicBrainz 작품 구조로 다시 짠다(6차 자동). 작품 3개(묶음 1, 다악장 0, 낱곡 2),
-- 새 작품 0개, part 2개, 그 아래 0개.
-- seed 3개 중 3개를 작품·part 에 잇고, 0개를 숨기고, 0개는 그대로 둔다.

-- None 10. Yıl Marşı

UPDATE pieces piece
SET piece.title = '10. Yıl Marşı', piece.title_en = '10. Yıl Marşı',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 18401 AND piece.composer_id = 230
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Andante and Allegro for Violin and Strings

UPDATE pieces piece
SET piece.title = 'Andante and Allegro for Violin and Strings', piece.title_en = 'Andante and Allegro for Violin and Strings',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 18081 AND piece.composer_id = 230
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'Andante', part.name_en = 'Andante and Allegro for Violin and Strings: Andante',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 18081 AND p.composer_id = 230 AND part.part_key = 'musicbrainz:edd09065-b816-48a4-85de-f5f77b383284' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:edd09065-b816-48a4-85de-f5f77b383284', 1, NULL, 'Andante', 'Andante and Allegro for Violin and Strings: Andante', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 18081 AND p.composer_id = 230
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:edd09065-b816-48a4-85de-f5f77b383284'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'Allegro. Vivo', part.name_en = 'Andante and Allegro for Violin and Strings: Allegro. Vivo',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 18081 AND p.composer_id = 230 AND part.part_key = 'musicbrainz:699c83f9-6d42-469e-b3ce-c52dcb7fa782' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:699c83f9-6d42-469e-b3ce-c52dcb7fa782', 2, NULL, 'Allegro. Vivo', 'Andante and Allegro for Violin and Strings: Allegro. Vivo', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 18081 AND p.composer_id = 230
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:699c83f9-6d42-469e-b3ce-c52dcb7fa782'
);


-- None 연가곡집 <On Halk Türküsü>

UPDATE pieces piece
SET piece.title = '연가곡집 <On Halk Türküsü>', piece.title_en = 'On Halk Türküsü',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 19543 AND piece.composer_id = 230
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

-- 숨길 seed 작품 없음

-- ===== Brice Pauset (composer_id 231) =====
-- 작품을 MusicBrainz 작품 구조로 다시 짠다(6차 자동). 작품 6개(묶음 0, 다악장 0, 낱곡 6),
-- 새 작품 0개, part 0개, 그 아래 0개.
-- seed 7개 중 6개를 작품·part 에 잇고, 0개를 숨기고, 1개는 그대로 둔다.

-- None Entrée

UPDATE pieces piece
SET piece.title = 'Entrée', piece.title_en = 'Entrée',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 18114 AND piece.composer_id = 231
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Eurydice

UPDATE pieces piece
SET piece.title = 'Eurydice', piece.title_en = 'Eurydice',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 18592 AND piece.composer_id = 231
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None In nomine II - In modo algoritmico

UPDATE pieces piece
SET piece.title = 'In nomine II - In modo algoritmico', piece.title_en = 'In nomine II - In modo algoritmico',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 18958 AND piece.composer_id = 231
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None In stilo fantastico

UPDATE pieces piece
SET piece.title = 'In stilo fantastico', piece.title_en = 'In stilo fantastico',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 16295 AND piece.composer_id = 231
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Perspectivae Sintagma I (canons)

UPDATE pieces piece
SET piece.title = 'Perspectivae Sintagma I (canons)', piece.title_en = 'Perspectivae Sintagma I (canons)',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 19267 AND piece.composer_id = 231
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Symphonie V "Die Tänzerin"

UPDATE pieces piece
SET piece.title = 'Symphonie V "Die Tänzerin"', piece.title_en = 'Symphonie V "Die Tänzerin"',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 17371 AND piece.composer_id = 231
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

-- 숨길 seed 작품 없음

-- ===== Ulvi Cemal Erkin (composer_id 232) =====
-- 작품을 MusicBrainz 작품 구조로 다시 짠다(6차 자동). 작품 14개(묶음 0, 다악장 9, 낱곡 5),
-- 새 작품 4개, part 43개, 그 아래 0개.
-- seed 11개 중 10개를 작품·part 에 잇고, 0개를 숨기고, 1개는 그대로 둔다.

-- None 6 Prelüd

UPDATE pieces piece
SET piece.title = '6 Prelüd', piece.title_en = '6 Prelüd',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 18806 AND piece.composer_id = 232
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'Lento, misterioso', part.name_en = '6 Prelüd: I. Lento, misterioso',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 18806 AND p.composer_id = 232 AND part.part_key = 'musicbrainz:04417546-ce12-4a5f-92ed-91082bc1596c' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:04417546-ce12-4a5f-92ed-91082bc1596c', 1, 'I', 'Lento, misterioso', '6 Prelüd: I. Lento, misterioso', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 18806 AND p.composer_id = 232
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:04417546-ce12-4a5f-92ed-91082bc1596c'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'Allegro', part.name_en = '6 Prelüd: II. Allegro',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 18806 AND p.composer_id = 232 AND part.part_key = 'musicbrainz:73e8bdae-a535-4602-b67f-bfc7c195ce4c' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:73e8bdae-a535-4602-b67f-bfc7c195ce4c', 2, 'II', 'Allegro', '6 Prelüd: II. Allegro', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 18806 AND p.composer_id = 232
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:73e8bdae-a535-4602-b67f-bfc7c195ce4c'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = 'Larghetto', part.name_en = '6 Prelüd: III. Larghetto',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 18806 AND p.composer_id = 232 AND part.part_key = 'musicbrainz:df17c2d9-8365-47ac-9dd3-427ffe33335e' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:df17c2d9-8365-47ac-9dd3-427ffe33335e', 3, 'III', 'Larghetto', '6 Prelüd: III. Larghetto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 18806 AND p.composer_id = 232
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:df17c2d9-8365-47ac-9dd3-427ffe33335e'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = 'IV',
    part.name_ko = 'Allegro moderato', part.name_en = '6 Prelüd: IV. Allegro moderato',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 18806 AND p.composer_id = 232 AND part.part_key = 'musicbrainz:ffd79ceb-8460-4da2-8872-3589744f0b0e' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:ffd79ceb-8460-4da2-8872-3589744f0b0e', 4, 'IV', 'Allegro moderato', '6 Prelüd: IV. Allegro moderato', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 18806 AND p.composer_id = 232
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:ffd79ceb-8460-4da2-8872-3589744f0b0e'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 5, part.movement_number = 'V',
    part.name_ko = 'Allegro', part.name_en = '6 Prelüd: V. Allegro',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 18806 AND p.composer_id = 232 AND part.part_key = 'musicbrainz:3e072737-6f88-432f-a0b5-294dab3e236a' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:3e072737-6f88-432f-a0b5-294dab3e236a', 5, 'V', 'Allegro', '6 Prelüd: V. Allegro', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 18806 AND p.composer_id = 232
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:3e072737-6f88-432f-a0b5-294dab3e236a'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 6, part.movement_number = 'VI',
    part.name_ko = 'Allegro vivo', part.name_en = '6 Prelüd: VI. Allegro vivo',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 18806 AND p.composer_id = 232 AND part.part_key = 'musicbrainz:580906b9-58cb-48cd-98f2-390fdc2e220d' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:580906b9-58cb-48cd-98f2-390fdc2e220d', 6, 'VI', 'Allegro vivo', '6 Prelüd: VI. Allegro vivo', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 18806 AND p.composer_id = 232
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:580906b9-58cb-48cd-98f2-390fdc2e220d'
);


-- None Beş damla

UPDATE pieces piece
SET piece.title = 'Beş damla', piece.title_en = 'Beş damla',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 18528 AND piece.composer_id = 232
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'Çok canlı', part.name_en = 'Beş damla: I. Çok canlı',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 18528 AND p.composer_id = 232 AND part.part_key = 'musicbrainz:29b57b5b-c301-40bf-95c6-fdd9df87f6d5' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:29b57b5b-c301-40bf-95c6-fdd9df87f6d5', 1, 'I', 'Çok canlı', 'Beş damla: I. Çok canlı', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 18528 AND p.composer_id = 232
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:29b57b5b-c301-40bf-95c6-fdd9df87f6d5'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'Ağır', part.name_en = 'Beş damla: II. Ağır',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 18528 AND p.composer_id = 232 AND part.part_key = 'musicbrainz:e8523a4c-777a-476b-af5a-21e1c31e6e69' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:e8523a4c-777a-476b-af5a-21e1c31e6e69', 2, 'II', 'Ağır', 'Beş damla: II. Ağır', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 18528 AND p.composer_id = 232
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:e8523a4c-777a-476b-af5a-21e1c31e6e69'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = 'Sakin', part.name_en = 'Beş damla: III. Sakin',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 18528 AND p.composer_id = 232 AND part.part_key = 'musicbrainz:ac3fe52c-eeac-4867-a911-da029e074c57' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:ac3fe52c-eeac-4867-a911-da029e074c57', 3, 'III', 'Sakin', 'Beş damla: III. Sakin', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 18528 AND p.composer_id = 232
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:ac3fe52c-eeac-4867-a911-da029e074c57'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = 'IV',
    part.name_ko = 'Çok canlı', part.name_en = 'Beş damla: IV. Çok canlı',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 18528 AND p.composer_id = 232 AND part.part_key = 'musicbrainz:e051515c-670a-4b35-9332-c40ba084517f' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:e051515c-670a-4b35-9332-c40ba084517f', 4, 'IV', 'Çok canlı', 'Beş damla: IV. Çok canlı', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 18528 AND p.composer_id = 232
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:e051515c-670a-4b35-9332-c40ba084517f'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 5, part.movement_number = 'V',
    part.name_ko = 'Sakin', part.name_en = 'Beş damla: V. Sakin',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 18528 AND p.composer_id = 232 AND part.part_key = 'musicbrainz:e3c24457-f124-4af8-88c4-f9b710b67116' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:e3c24457-f124-4af8-88c4-f9b710b67116', 5, 'V', 'Sakin', 'Beş damla: V. Sakin', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 18528 AND p.composer_id = 232
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:e3c24457-f124-4af8-88c4-f9b710b67116'
);


-- None Duyuşlar

UPDATE pieces piece
SET piece.title = 'Duyuşlar', piece.title_en = 'Duyuşlar',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 16097 AND piece.composer_id = 232
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'Oyun (Allegro vivo)', part.name_en = 'Duyuşlar: I. Oyun (Allegro vivo)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 16097 AND p.composer_id = 232 AND part.part_key = 'musicbrainz:aa752ba9-099f-4a1d-aef8-a130e25ff5db' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:aa752ba9-099f-4a1d-aef8-a130e25ff5db', 1, 'I', 'Oyun (Allegro vivo)', 'Duyuşlar: I. Oyun (Allegro vivo)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 16097 AND p.composer_id = 232
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:aa752ba9-099f-4a1d-aef8-a130e25ff5db'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'Küçük Çoban (Andante)', part.name_en = 'Duyuşlar: II. Küçük Çoban (Andante)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 16097 AND p.composer_id = 232 AND part.part_key = 'musicbrainz:9f6612cf-8418-4221-a79a-dc6381c190d1' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:9f6612cf-8418-4221-a79a-dc6381c190d1', 2, 'II', 'Küçük Çoban (Andante)', 'Duyuşlar: II. Küçük Çoban (Andante)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 16097 AND p.composer_id = 232
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:9f6612cf-8418-4221-a79a-dc6381c190d1'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = 'Dere (Allegro vivo)', part.name_en = 'Duyuşlar: III. Dere (Allegro vivo)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 16097 AND p.composer_id = 232 AND part.part_key = 'musicbrainz:d14e42ad-5190-45ac-862f-70f5fd2acd20' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:d14e42ad-5190-45ac-862f-70f5fd2acd20', 3, 'III', 'Dere (Allegro vivo)', 'Duyuşlar: III. Dere (Allegro vivo)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 16097 AND p.composer_id = 232
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:d14e42ad-5190-45ac-862f-70f5fd2acd20'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = 'IV',
    part.name_ko = 'Kağnı (Allegro vivo)', part.name_en = 'Duyuşlar: IV. Kağnı (Allegro vivo)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 16097 AND p.composer_id = 232 AND part.part_key = 'musicbrainz:61a3227e-0291-4a56-b5e7-4aaf43686e4d' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:61a3227e-0291-4a56-b5e7-4aaf43686e4d', 4, 'IV', 'Kağnı (Allegro vivo)', 'Duyuşlar: IV. Kağnı (Allegro vivo)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 16097 AND p.composer_id = 232
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:61a3227e-0291-4a56-b5e7-4aaf43686e4d'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 5, part.movement_number = 'V',
    part.name_ko = 'Oyun (Allegro vivo)', part.name_en = 'Duyuşlar: V. Oyun (Allegro vivo)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 16097 AND p.composer_id = 232 AND part.part_key = 'musicbrainz:33ab94dd-06c9-4d38-a2fb-668f4aec177d' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:33ab94dd-06c9-4d38-a2fb-668f4aec177d', 5, 'V', 'Oyun (Allegro vivo)', 'Duyuşlar: V. Oyun (Allegro vivo)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 16097 AND p.composer_id = 232
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:33ab94dd-06c9-4d38-a2fb-668f4aec177d'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 6, part.movement_number = 'VI',
    part.name_ko = 'Marş (Tempo di marcia)', part.name_en = 'Duyuşlar: VI. Marş (Tempo di marcia)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 16097 AND p.composer_id = 232 AND part.part_key = 'musicbrainz:5a23efad-6ee2-4769-8328-ba4b7196fbb3' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:5a23efad-6ee2-4769-8328-ba4b7196fbb3', 6, 'VI', 'Marş (Tempo di marcia)', 'Duyuşlar: VI. Marş (Tempo di marcia)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 16097 AND p.composer_id = 232
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:5a23efad-6ee2-4769-8328-ba4b7196fbb3'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 7, part.movement_number = 'VII',
    part.name_ko = 'Şaka (Vivace)', part.name_en = 'Duyuşlar: VII. Şaka (Vivace)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 16097 AND p.composer_id = 232 AND part.part_key = 'musicbrainz:109eeed2-cdcf-48d7-b405-767737adade2' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:109eeed2-cdcf-48d7-b405-767737adade2', 7, 'VII', 'Şaka (Vivace)', 'Duyuşlar: VII. Şaka (Vivace)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 16097 AND p.composer_id = 232
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:109eeed2-cdcf-48d7-b405-767737adade2'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 8, part.movement_number = 'VIII',
    part.name_ko = 'Uçuşlar (Agitato)', part.name_en = 'Duyuşlar: VIII. Uçuşlar (Agitato)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 16097 AND p.composer_id = 232 AND part.part_key = 'musicbrainz:50801ad2-d8e3-4811-aa9f-5b8c1d8de04d' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:50801ad2-d8e3-4811-aa9f-5b8c1d8de04d', 8, 'VIII', 'Uçuşlar (Agitato)', 'Duyuşlar: VIII. Uçuşlar (Agitato)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 16097 AND p.composer_id = 232
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:50801ad2-d8e3-4811-aa9f-5b8c1d8de04d'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 9, part.movement_number = 'IX',
    part.name_ko = 'Oyun (Allegro)', part.name_en = 'Duyuşlar: IX. Oyun (Allegro)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 16097 AND p.composer_id = 232 AND part.part_key = 'musicbrainz:520476eb-637b-45a4-b046-5a20a4fb64fe' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:520476eb-637b-45a4-b046-5a20a4fb64fe', 9, 'IX', 'Oyun (Allegro)', 'Duyuşlar: IX. Oyun (Allegro)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 16097 AND p.composer_id = 232
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:520476eb-637b-45a4-b046-5a20a4fb64fe'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 10, part.movement_number = 'X',
    part.name_ko = 'Ağlama yar ağlama (Lento)', part.name_en = 'Duyuşlar: X. Ağlama yar ağlama (Lento)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 16097 AND p.composer_id = 232 AND part.part_key = 'musicbrainz:2c4706dc-2ade-4c20-81e0-62ead355b051' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:2c4706dc-2ade-4c20-81e0-62ead355b051', 10, 'X', 'Ağlama yar ağlama (Lento)', 'Duyuşlar: X. Ağlama yar ağlama (Lento)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 16097 AND p.composer_id = 232
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:2c4706dc-2ade-4c20-81e0-62ead355b051'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 11, part.movement_number = 'XI',
    part.name_ko = 'Zeybek Havası (Allegro moderato)', part.name_en = 'Duyuşlar: XI. Zeybek Havası (Allegro moderato)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 16097 AND p.composer_id = 232 AND part.part_key = 'musicbrainz:82c5db47-f728-45a3-b893-709de757378e' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:82c5db47-f728-45a3-b893-709de757378e', 11, 'XI', 'Zeybek Havası (Allegro moderato)', 'Duyuşlar: XI. Zeybek Havası (Allegro moderato)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 16097 AND p.composer_id = 232
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:82c5db47-f728-45a3-b893-709de757378e'
);


-- None Improvisation for Violin and Piano

UPDATE pieces piece
SET piece.title = 'Improvisation for Violin and Piano', piece.title_en = 'Improvisation for Violin and Piano',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 16422 AND piece.composer_id = 232
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Köçekçe

UPDATE pieces piece
SET piece.title = 'Köçekçe', piece.title_en = 'Köçekçe',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 16252 AND piece.composer_id = 232
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Ninni

UPDATE pieces piece
SET piece.title = 'Ninni', piece.title_en = 'Ninni',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 19123 AND piece.composer_id = 232
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Sinfonietta for Strings

UPDATE pieces piece
SET piece.title = 'Sinfonietta for Strings', piece.title_en = 'Sinfonietta for Strings',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 18521 AND piece.composer_id = 232
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'Allegro', part.name_en = 'Sinfonietta for Strings: I. Allegro',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 18521 AND p.composer_id = 232 AND part.part_key = 'musicbrainz:9feaa7ec-536f-4dac-9033-8cc86e957584' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:9feaa7ec-536f-4dac-9033-8cc86e957584', 1, 'I', 'Allegro', 'Sinfonietta for Strings: I. Allegro', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 18521 AND p.composer_id = 232
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:9feaa7ec-536f-4dac-9033-8cc86e957584'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'Adagio', part.name_en = 'Sinfonietta for Strings: II. Adagio',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 18521 AND p.composer_id = 232 AND part.part_key = 'musicbrainz:acd47646-6a59-4a4d-981b-8791d6f28538' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:acd47646-6a59-4a4d-981b-8791d6f28538', 2, 'II', 'Adagio', 'Sinfonietta for Strings: II. Adagio', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 18521 AND p.composer_id = 232
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:acd47646-6a59-4a4d-981b-8791d6f28538'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = 'Allegro', part.name_en = 'Sinfonietta for Strings: III. Allegro',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 18521 AND p.composer_id = 232 AND part.part_key = 'musicbrainz:6c1d9404-c7db-4f9a-abe7-d45d596f7bfb' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:6c1d9404-c7db-4f9a-abe7-d45d596f7bfb', 3, 'III', 'Allegro', 'Sinfonietta for Strings: III. Allegro', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 18521 AND p.composer_id = 232
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:6c1d9404-c7db-4f9a-abe7-d45d596f7bfb'
);


-- None 현악 4중주

UPDATE pieces piece
SET piece.title = '현악 4중주', piece.title_en = 'String Quartet',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 16964 AND piece.composer_id = 232
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'Allegro ma non troppo', part.name_en = 'String Quartet: I. Allegro ma non troppo',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 16964 AND p.composer_id = 232 AND part.part_key = 'musicbrainz:a650a312-d898-405a-920f-4672450ddd1c' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:a650a312-d898-405a-920f-4672450ddd1c', 1, 'I', 'Allegro ma non troppo', 'String Quartet: I. Allegro ma non troppo', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 16964 AND p.composer_id = 232
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:a650a312-d898-405a-920f-4672450ddd1c'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'Allegro scherzando - Sostenuto', part.name_en = 'String Quartet: II. Allegro scherzando - Sostenuto',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 16964 AND p.composer_id = 232 AND part.part_key = 'musicbrainz:8decf2ae-4499-44f4-b810-3824aa7544d7' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:8decf2ae-4499-44f4-b810-3824aa7544d7', 2, 'II', 'Allegro scherzando - Sostenuto', 'String Quartet: II. Allegro scherzando - Sostenuto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 16964 AND p.composer_id = 232
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:8decf2ae-4499-44f4-b810-3824aa7544d7'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = 'Andante', part.name_en = 'String Quartet: III. Andante',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 16964 AND p.composer_id = 232 AND part.part_key = 'musicbrainz:94e97f59-18a5-4766-99a6-efc6165a9156' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:94e97f59-18a5-4766-99a6-efc6165a9156', 3, 'III', 'Andante', 'String Quartet: III. Andante', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 16964 AND p.composer_id = 232
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:94e97f59-18a5-4766-99a6-efc6165a9156'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = 'IV',
    part.name_ko = 'Quasi improvisazione', part.name_en = 'String Quartet: IV. Quasi improvisazione',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 16964 AND p.composer_id = 232 AND part.part_key = 'musicbrainz:d721cfd2-b6b2-4a9b-b437-1d4a672d2ee4' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:d721cfd2-b6b2-4a9b-b437-1d4a672d2ee4', 4, 'IV', 'Quasi improvisazione', 'String Quartet: IV. Quasi improvisazione', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 16964 AND p.composer_id = 232
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:d721cfd2-b6b2-4a9b-b437-1d4a672d2ee4'
);


-- None Zeybek türküsü

UPDATE pieces piece
SET piece.title = 'Zeybek türküsü', piece.title_en = 'Zeybek türküsü',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 16870 AND piece.composer_id = 232
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Çamdan Sakız Akıyor

UPDATE pieces piece
SET piece.title = 'Çamdan Sakız Akıyor', piece.title_en = 'Çamdan Sakız Akıyor',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 19272 AND piece.composer_id = 232
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None 피아노 5중주

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '피아노 5중주', 'Piano Quintet', 'album', NULL, NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 232
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '피아노 5중주'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '4fa87dfa-0c63-4653-ba15-b5298341ffa9'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '4fa87dfa-0c63-4653-ba15-b5298341ffa9'
FROM pieces p
WHERE p.composer_id = 232 AND p.title = '피아노 5중주' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '4fa87dfa-0c63-4653-ba15-b5298341ffa9'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:4d0a714d-2420-4902-9cf3-f99f8e16af49', 1, 'I', 'Moderato', 'Piano Quintet: I. Moderato', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 232 AND p.title = '피아노 5중주' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:4d0a714d-2420-4902-9cf3-f99f8e16af49'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:ba437a3e-8b67-4518-b18f-4c7d916aa6f5', 2, 'II', 'Adagio Mesto', 'Piano Quintet: II. Adagio Mesto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 232 AND p.title = '피아노 5중주' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:ba437a3e-8b67-4518-b18f-4c7d916aa6f5'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:333866df-f949-4776-be26-550c57f78b98', 3, 'III', 'Ritmico e energico', 'Piano Quintet: III. Ritmico e energico', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 232 AND p.title = '피아노 5중주' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:333866df-f949-4776-be26-550c57f78b98'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:2799586a-d9ac-45de-86b3-f841c87c0410', 4, 'IV', 'Allegro vivo', 'Piano Quintet: IV. Allegro vivo', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 232 AND p.title = '피아노 5중주' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:2799586a-d9ac-45de-86b3-f841c87c0410'
);


-- None 교향곡 1번

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '교향곡 1번', 'Symphony no. 1', 'album', NULL, NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 232
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '교향곡 1번'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'fb39b9bb-8499-4bce-9e53-f6f0d33c5bd0'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'fb39b9bb-8499-4bce-9e53-f6f0d33c5bd0'
FROM pieces p
WHERE p.composer_id = 232 AND p.title = '교향곡 1번' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'fb39b9bb-8499-4bce-9e53-f6f0d33c5bd0'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:f06f82d7-9f1d-4941-9f06-4171859660bb', 1, 'I', 'Allegro aperto', 'Symphony no. 1: I. Allegro aperto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 232 AND p.title = '교향곡 1번' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:f06f82d7-9f1d-4941-9f06-4171859660bb'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:a362f9e3-f8da-4776-afcd-0116171c5ecf', 2, 'II', 'Adagio', 'Symphony no. 1: II. Adagio', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 232 AND p.title = '교향곡 1번' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:a362f9e3-f8da-4776-afcd-0116171c5ecf'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:0ea8a572-4ed0-497e-9a64-fe75894caaa2', 3, 'III', 'Allegro scherzando', 'Symphony no. 1: III. Allegro scherzando', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 232 AND p.title = '교향곡 1번' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:0ea8a572-4ed0-497e-9a64-fe75894caaa2'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:b1e2f689-8e2e-46f1-88ed-8178a14a1e87', 4, 'IV', 'Moderato · Allegro non troppo', 'Symphony no. 1: IV. Moderato · Allegro non troppo', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 232 AND p.title = '교향곡 1번' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:b1e2f689-8e2e-46f1-88ed-8178a14a1e87'
);


-- None 교향곡 2번

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '교향곡 2번', 'Symphony no. 2', 'album', NULL, NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 232
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '교향곡 2번'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'c72fc048-8f1c-4849-b7c6-91896eec0b0c'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'c72fc048-8f1c-4849-b7c6-91896eec0b0c'
FROM pieces p
WHERE p.composer_id = 232 AND p.title = '교향곡 2번' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'c72fc048-8f1c-4849-b7c6-91896eec0b0c'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:8940f4ab-3dd8-4c2c-8d82-450dcf861c5a', 1, 'I', 'Allegro non troppo', 'Symphony no. 2: I. Allegro non troppo', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 232 AND p.title = '교향곡 2번' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:8940f4ab-3dd8-4c2c-8d82-450dcf861c5a'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:7b687163-7bea-4aa8-acf1-3026dec133f5', 2, 'II', 'Adagio', 'Symphony no. 2: II. Adagio', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 232 AND p.title = '교향곡 2번' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:7b687163-7bea-4aa8-acf1-3026dec133f5'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:ee5891fb-5b73-49b6-96a9-0747ee71d47d', 3, 'III', 'Allegro - Alla Köçekçe', 'Symphony no. 2: III. Allegro - Alla Köçekçe', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 232 AND p.title = '교향곡 2번' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:ee5891fb-5b73-49b6-96a9-0747ee71d47d'
);


-- None 바이올린 협주곡

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '바이올린 협주곡', 'Violin Concerto', 'album', NULL, NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 232
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '바이올린 협주곡'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'ff9cbe8d-b74b-40a4-a0bd-4f4f6c53d962'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'ff9cbe8d-b74b-40a4-a0bd-4f4f6c53d962'
FROM pieces p
WHERE p.composer_id = 232 AND p.title = '바이올린 협주곡' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'ff9cbe8d-b74b-40a4-a0bd-4f4f6c53d962'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:79034c02-99ce-4e46-bc76-ad58c69955f8', 1, 'I', 'Allegro giusto', 'Violin Concerto: I. Allegro giusto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 232 AND p.title = '바이올린 협주곡' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:79034c02-99ce-4e46-bc76-ad58c69955f8'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:78448a9a-bb17-4930-a45a-fc7453d659cc', 2, 'II', 'Adagio', 'Violin Concerto: II. Adagio', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 232 AND p.title = '바이올린 협주곡' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:78448a9a-bb17-4930-a45a-fc7453d659cc'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:8ae7b82e-bc05-4ec5-8b05-0f2106107e05', 3, 'III', 'Allegro con fuoco', 'Violin Concerto: III. Allegro con fuoco', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 232 AND p.title = '바이올린 협주곡' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:8ae7b82e-bc05-4ec5-8b05-0f2106107e05'
);

-- 숨길 seed 작품 없음

-- ===== Ludwig Daser (composer_id 234) =====
-- 작품을 MusicBrainz 작품 구조로 다시 짠다(6차 자동). 작품 9개(묶음 0, 다악장 0, 낱곡 9),
-- 새 작품 0개, part 0개, 그 아래 0개.
-- seed 9개 중 9개를 작품·part 에 잇고, 0개를 숨기고, 0개는 그대로 둔다.

-- None Missa Fors Seulement à 4v. Agnus Dei

UPDATE pieces piece
SET piece.title = 'Missa Fors Seulement à 4v. Agnus Dei', piece.title_en = 'Missa Fors Seulement à 4v. Agnus Dei',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 18700 AND piece.composer_id = 234
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Missa Fors Seulement à 4v. Gloria

UPDATE pieces piece
SET piece.title = 'Missa Fors Seulement à 4v. Gloria', piece.title_en = 'Missa Fors Seulement à 4v. Gloria',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 17690 AND piece.composer_id = 234
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Missa Fors Seulement à 4v. Kyrie

UPDATE pieces piece
SET piece.title = 'Missa Fors Seulement à 4v. Kyrie', piece.title_en = 'Missa Fors Seulement à 4v. Kyrie',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 16630 AND piece.composer_id = 234
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Missa Fors Seulement à 4v. Sanctus

UPDATE pieces piece
SET piece.title = 'Missa Fors Seulement à 4v. Sanctus', piece.title_en = 'Missa Fors Seulement à 4v. Sanctus',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 17204 AND piece.composer_id = 234
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Missa Preter Rerum Seriem à 6v. Agnus Dei

UPDATE pieces piece
SET piece.title = 'Missa Preter Rerum Seriem à 6v. Agnus Dei', piece.title_en = 'Missa Preter Rerum Seriem à 6v. Agnus Dei',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 17640 AND piece.composer_id = 234
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Missa Preter Rerum Seriem à 6v. Credo

UPDATE pieces piece
SET piece.title = 'Missa Preter Rerum Seriem à 6v. Credo', piece.title_en = 'Missa Preter Rerum Seriem à 6v. Credo',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 18645 AND piece.composer_id = 234
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Missa Preter Rerum Seriem à 6v. Gloria

UPDATE pieces piece
SET piece.title = 'Missa Preter Rerum Seriem à 6v. Gloria', piece.title_en = 'Missa Preter Rerum Seriem à 6v. Gloria',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 18312 AND piece.composer_id = 234
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Missa Preter Rerum Seriem à 6v. Kyrie

UPDATE pieces piece
SET piece.title = 'Missa Preter Rerum Seriem à 6v. Kyrie', piece.title_en = 'Missa Preter Rerum Seriem à 6v. Kyrie',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 17744 AND piece.composer_id = 234
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Missa Preter Rerum Seriem à 6v. Sanctis

UPDATE pieces piece
SET piece.title = 'Missa Preter Rerum Seriem à 6v. Sanctis', piece.title_en = 'Missa Preter Rerum Seriem à 6v. Sanctis',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 16776 AND piece.composer_id = 234
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

-- 숨길 seed 작품 없음

-- ===== Charles-Hubert Gervais (composer_id 236) =====
-- 작품을 MusicBrainz 작품 구조로 다시 짠다(6차 자동). 작품 5개(묶음 0, 다악장 4, 낱곡 1),
-- 새 작품 0개, part 132개, 그 아래 0개.
-- seed 5개 중 5개를 작품·part 에 잇고, 0개를 숨기고, 0개는 그대로 둔다.

-- None 오페라 <Hypermnestre>

UPDATE pieces piece
SET piece.title = '오페라 <Hypermnestre>', piece.title_en = 'Hypermnestre',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 19226 AND piece.composer_id = 236
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'Acte II: V. Airs di tambourin pour les Matelots argiens', part.name_en = 'Hypermnestre: Acte II: V. Airs di tambourin pour les Matelots argiens',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 19226 AND p.composer_id = 236 AND part.part_key = 'musicbrainz:08356531-5525-406f-ba2c-50d920e32db7' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:08356531-5525-406f-ba2c-50d920e32db7', 1, NULL, 'Acte II: V. Airs di tambourin pour les Matelots argiens', 'Hypermnestre: Acte II: V. Airs di tambourin pour les Matelots argiens', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 19226 AND p.composer_id = 236
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:08356531-5525-406f-ba2c-50d920e32db7'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'Acte III: I. Ritournelle', part.name_en = 'Hypermnestre: Acte III: I. Ritournelle',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 19226 AND p.composer_id = 236 AND part.part_key = 'musicbrainz:09a4d702-958b-484e-9c77-a1e34c4d23d9' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:09a4d702-958b-484e-9c77-a1e34c4d23d9', 2, NULL, 'Acte III: I. Ritournelle', 'Hypermnestre: Acte III: I. Ritournelle', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 19226 AND p.composer_id = 236
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:09a4d702-958b-484e-9c77-a1e34c4d23d9'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = NULL,
    part.name_ko = 'Acte V (première version, 1716): X. Peuples, écoutez-moi', part.name_en = 'Hypermnestre: Acte V (première version, 1716): X. Peuples, écoutez-moi ...',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 19226 AND p.composer_id = 236 AND part.part_key = 'musicbrainz:0ad86b1a-87b0-470f-9088-9d417a86b5c1' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:0ad86b1a-87b0-470f-9088-9d417a86b5c1', 3, NULL, 'Acte V (première version, 1716): X. Peuples, écoutez-moi', 'Hypermnestre: Acte V (première version, 1716): X. Peuples, écoutez-moi ...', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 19226 AND p.composer_id = 236
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:0ad86b1a-87b0-470f-9088-9d417a86b5c1'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = NULL,
    part.name_ko = 'Acte V: III. Allez, Prince, sortez à la faveur des ombres', part.name_en = 'Hypermnestre: Acte V: III. Allez, Prince, sortez à la faveur des ombres ...',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 19226 AND p.composer_id = 236 AND part.part_key = 'musicbrainz:0c1b740e-b911-47d8-9d4d-31fec9793945' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:0c1b740e-b911-47d8-9d4d-31fec9793945', 4, NULL, 'Acte V: III. Allez, Prince, sortez à la faveur des ombres', 'Hypermnestre: Acte V: III. Allez, Prince, sortez à la faveur des ombres ...', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 19226 AND p.composer_id = 236
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:0c1b740e-b911-47d8-9d4d-31fec9793945'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 5, part.movement_number = NULL,
    part.name_ko = 'Acte V (première version, 1716): VI. De ce combat fatal, grands Dieux!', part.name_en = 'Hypermnestre: Acte V (première version, 1716): VI. De ce combat fatal, grands Dieux! ...',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 19226 AND p.composer_id = 236 AND part.part_key = 'musicbrainz:0c29bed1-b643-4dce-9336-0f861ee28e3d' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:0c29bed1-b643-4dce-9336-0f861ee28e3d', 5, NULL, 'Acte V (première version, 1716): VI. De ce combat fatal, grands Dieux!', 'Hypermnestre: Acte V (première version, 1716): VI. De ce combat fatal, grands Dieux! ...', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 19226 AND p.composer_id = 236
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:0c29bed1-b643-4dce-9336-0f861ee28e3d'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 6, part.movement_number = NULL,
    part.name_ko = 'Acte V (première version, 1716): VIII. Non, perfide, c''est toi dont le coupable amour', part.name_en = 'Hypermnestre: Acte V (première version, 1716): VIII. Non, perfide, c''est toi dont le coupable amour ...',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 19226 AND p.composer_id = 236 AND part.part_key = 'musicbrainz:0d382c9b-2210-475e-be47-c9ebd8107cd4' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:0d382c9b-2210-475e-be47-c9ebd8107cd4', 6, NULL, 'Acte V (première version, 1716): VIII. Non, perfide, c''est toi dont le coupable amour', 'Hypermnestre: Acte V (première version, 1716): VIII. Non, perfide, c''est toi dont le coupable amour ...', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 19226 AND p.composer_id = 236
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:0d382c9b-2210-475e-be47-c9ebd8107cd4'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 7, part.movement_number = NULL,
    part.name_ko = 'Acte II: XIII. Je vous revois, Princesse, ah! que mon sort est doux!', part.name_en = 'Hypermnestre: Acte II: XIII. Je vous revois, Princesse, ah! que mon sort est doux! ...',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 19226 AND p.composer_id = 236 AND part.part_key = 'musicbrainz:10094a96-d36f-4a6a-83f1-6b2cdc31535f' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:10094a96-d36f-4a6a-83f1-6b2cdc31535f', 7, NULL, 'Acte II: XIII. Je vous revois, Princesse, ah! que mon sort est doux!', 'Hypermnestre: Acte II: XIII. Je vous revois, Princesse, ah! que mon sort est doux! ...', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 19226 AND p.composer_id = 236
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:10094a96-d36f-4a6a-83f1-6b2cdc31535f'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 8, part.movement_number = NULL,
    part.name_ko = 'Acte II: VI. Que ne vous dois-je point?', part.name_en = 'Hypermnestre: Acte II: VI. Que ne vous dois-je point? ...',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 19226 AND p.composer_id = 236 AND part.part_key = 'musicbrainz:10635f9c-f124-4fc1-b73d-630ebe82c515' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:10635f9c-f124-4fc1-b73d-630ebe82c515', 8, NULL, 'Acte II: VI. Que ne vous dois-je point?', 'Hypermnestre: Acte II: VI. Que ne vous dois-je point? ...', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 19226 AND p.composer_id = 236
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:10635f9c-f124-4fc1-b73d-630ebe82c515'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 9, part.movement_number = NULL,
    part.name_ko = 'Acte I: VII. Chantons de ce héros la valeur et la gloire', part.name_en = 'Hypermnestre: Acte I: VII. Chantons de ce héros la valeur et la gloire ...',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 19226 AND p.composer_id = 236 AND part.part_key = 'musicbrainz:109e8871-c6ef-45ee-8a8d-ec89430b673b' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:109e8871-c6ef-45ee-8a8d-ec89430b673b', 9, NULL, 'Acte I: VII. Chantons de ce héros la valeur et la gloire', 'Hypermnestre: Acte I: VII. Chantons de ce héros la valeur et la gloire ...', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 19226 AND p.composer_id = 236
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:109e8871-c6ef-45ee-8a8d-ec89430b673b'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 10, part.movement_number = NULL,
    part.name_ko = 'Acte V: II. Arrêtez! ... Dans quel sang allez-vous plonger?', part.name_en = 'Hypermnestre: Acte V: II. Arrêtez! ... Dans quel sang allez-vous plonger? ...',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 19226 AND p.composer_id = 236 AND part.part_key = 'musicbrainz:10a6e7f6-dd11-4485-be8e-5d929a2164eb' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:10a6e7f6-dd11-4485-be8e-5d929a2164eb', 10, NULL, 'Acte V: II. Arrêtez! ... Dans quel sang allez-vous plonger?', 'Hypermnestre: Acte V: II. Arrêtez! ... Dans quel sang allez-vous plonger? ...', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 19226 AND p.composer_id = 236
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:10a6e7f6-dd11-4485-be8e-5d929a2164eb'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 11, part.movement_number = NULL,
    part.name_ko = 'Prologue: XVI. Gigue pour les Peuples', part.name_en = 'Hypermnestre: Prologue: XVI. Gigue pour les Peuples',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 19226 AND p.composer_id = 236 AND part.part_key = 'musicbrainz:13df3e53-f903-48f4-baac-fb900c532b71' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:13df3e53-f903-48f4-baac-fb900c532b71', 11, NULL, 'Prologue: XVI. Gigue pour les Peuples', 'Hypermnestre: Prologue: XVI. Gigue pour les Peuples', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 19226 AND p.composer_id = 236
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:13df3e53-f903-48f4-baac-fb900c532b71'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 12, part.movement_number = NULL,
    part.name_ko = 'Acte IV: IX. Dieux vengeurs, de quels chants ont retenti les airs?', part.name_en = 'Hypermnestre: Acte IV: IX. Dieux vengeurs, de quels chants ont retenti les airs? ...',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 19226 AND p.composer_id = 236 AND part.part_key = 'musicbrainz:13ec184b-a407-4afb-80c3-216b513e6211' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:13ec184b-a407-4afb-80c3-216b513e6211', 12, NULL, 'Acte IV: IX. Dieux vengeurs, de quels chants ont retenti les airs?', 'Hypermnestre: Acte IV: IX. Dieux vengeurs, de quels chants ont retenti les airs? ...', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 19226 AND p.composer_id = 236
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:13ec184b-a407-4afb-80c3-216b513e6211'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 13, part.movement_number = NULL,
    part.name_ko = 'Acte I: VIII. Air pour les Peuples argiens', part.name_en = 'Hypermnestre: Acte I: VIII. Air pour les Peuples argiens',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 19226 AND p.composer_id = 236 AND part.part_key = 'musicbrainz:14c4afba-37a1-45a7-a954-9aeafca5c792' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:14c4afba-37a1-45a7-a954-9aeafca5c792', 13, NULL, 'Acte I: VIII. Air pour les Peuples argiens', 'Hypermnestre: Acte I: VIII. Air pour les Peuples argiens', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 19226 AND p.composer_id = 236
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:14c4afba-37a1-45a7-a954-9aeafca5c792'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 14, part.movement_number = NULL,
    part.name_ko = 'Acte II: XII. Venez, jeune Héros', part.name_en = 'Hypermnestre: Acte II: XII. Venez, jeune Héros ...',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 19226 AND p.composer_id = 236 AND part.part_key = 'musicbrainz:1afb514b-c902-4812-8c0e-99bf74b4ae81' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:1afb514b-c902-4812-8c0e-99bf74b4ae81', 14, NULL, 'Acte II: XII. Venez, jeune Héros', 'Hypermnestre: Acte II: XII. Venez, jeune Héros ...', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 19226 AND p.composer_id = 236
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:1afb514b-c902-4812-8c0e-99bf74b4ae81'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 15, part.movement_number = NULL,
    part.name_ko = 'Acte III: XX. Hymen sacré, c''est toi seul qui j''atteste!', part.name_en = 'Hypermnestre: Acte III: XX. Hymen sacré, c''est toi seul qui j''atteste! ...',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 19226 AND p.composer_id = 236 AND part.part_key = 'musicbrainz:1c0c0e12-5256-48b2-8e01-352707db4c1d' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:1c0c0e12-5256-48b2-8e01-352707db4c1d', 15, NULL, 'Acte III: XX. Hymen sacré, c''est toi seul qui j''atteste!', 'Hypermnestre: Acte III: XX. Hymen sacré, c''est toi seul qui j''atteste! ...', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 19226 AND p.composer_id = 236
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:1c0c0e12-5256-48b2-8e01-352707db4c1d'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 16, part.movement_number = NULL,
    part.name_ko = 'Acte III: IX. Tendres époux, recevez notre hommage', part.name_en = 'Hypermnestre: Acte III: IX. Tendres époux, recevez notre hommage ...',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 19226 AND p.composer_id = 236 AND part.part_key = 'musicbrainz:1fa3f6c3-665c-40b6-82a4-f61690a31f97' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:1fa3f6c3-665c-40b6-82a4-f61690a31f97', 16, NULL, 'Acte III: IX. Tendres époux, recevez notre hommage', 'Hypermnestre: Acte III: IX. Tendres époux, recevez notre hommage ...', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 19226 AND p.composer_id = 236
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:1fa3f6c3-665c-40b6-82a4-f61690a31f97'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 17, part.movement_number = NULL,
    part.name_ko = 'Prologue: VII. Prélude pour le Nil', part.name_en = 'Hypermnestre: Prologue: VII. Prélude pour le Nil',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 19226 AND p.composer_id = 236 AND part.part_key = 'musicbrainz:22d5a0db-ed57-4414-9d96-4782f8089412' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:22d5a0db-ed57-4414-9d96-4782f8089412', 17, NULL, 'Prologue: VII. Prélude pour le Nil', 'Hypermnestre: Prologue: VII. Prélude pour le Nil', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 19226 AND p.composer_id = 236
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:22d5a0db-ed57-4414-9d96-4782f8089412'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 18, part.movement_number = NULL,
    part.name_ko = 'Prologue: XI. Revenais, Bergères craintives', part.name_en = 'Hypermnestre: Prologue: XI. Revenais, Bergères craintives',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 19226 AND p.composer_id = 236 AND part.part_key = 'musicbrainz:230b9ba9-bda6-435d-80a6-64ff295278ac' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:230b9ba9-bda6-435d-80a6-64ff295278ac', 18, NULL, 'Prologue: XI. Revenais, Bergères craintives', 'Hypermnestre: Prologue: XI. Revenais, Bergères craintives', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 19226 AND p.composer_id = 236
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:230b9ba9-bda6-435d-80a6-64ff295278ac'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 19, part.movement_number = NULL,
    part.name_ko = 'Acte III: XI. Faites régner, belle Princesse', part.name_en = 'Hypermnestre: Acte III: XI. Faites régner, belle Princesse ...',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 19226 AND p.composer_id = 236 AND part.part_key = 'musicbrainz:24d7f2a8-bfa4-4ff3-89b3-a658d4db6c51' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:24d7f2a8-bfa4-4ff3-89b3-a658d4db6c51', 19, NULL, 'Acte III: XI. Faites régner, belle Princesse', 'Hypermnestre: Acte III: XI. Faites régner, belle Princesse ...', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 19226 AND p.composer_id = 236
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:24d7f2a8-bfa4-4ff3-89b3-a658d4db6c51'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 20, part.movement_number = NULL,
    part.name_ko = 'Acte IV: X. Ô Nuit! à quels forfaits vas-tu prêter tes ombres?', part.name_en = 'Hypermnestre: Acte IV: X. Ô Nuit! à quels forfaits vas-tu prêter tes ombres? ...',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 19226 AND p.composer_id = 236 AND part.part_key = 'musicbrainz:27040e9b-628d-4344-ade6-a57e45a4920e' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:27040e9b-628d-4344-ade6-a57e45a4920e', 20, NULL, 'Acte IV: X. Ô Nuit! à quels forfaits vas-tu prêter tes ombres?', 'Hypermnestre: Acte IV: X. Ô Nuit! à quels forfaits vas-tu prêter tes ombres? ...', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 19226 AND p.composer_id = 236
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:27040e9b-628d-4344-ade6-a57e45a4920e'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 21, part.movement_number = NULL,
    part.name_ko = 'Acte III: XV. Que le pais a d''attraits!', part.name_en = 'Hypermnestre: Acte III: XV. Que le pais a d''attraits! ...',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 19226 AND p.composer_id = 236 AND part.part_key = 'musicbrainz:29bd1e88-1ea2-4868-bd6f-4a397155c34b' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:29bd1e88-1ea2-4868-bd6f-4a397155c34b', 21, NULL, 'Acte III: XV. Que le pais a d''attraits!', 'Hypermnestre: Acte III: XV. Que le pais a d''attraits! ...', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 19226 AND p.composer_id = 236
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:29bd1e88-1ea2-4868-bd6f-4a397155c34b'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 22, part.movement_number = NULL,
    part.name_ko = 'Acte V (première version, 1716): III. Cruels, où courez-vous?', part.name_en = 'Hypermnestre: Acte V (première version, 1716): III. Cruels, où courez-vous? ...',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 19226 AND p.composer_id = 236 AND part.part_key = 'musicbrainz:29d08242-4079-411c-8a65-80551e687cde' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:29d08242-4079-411c-8a65-80551e687cde', 22, NULL, 'Acte V (première version, 1716): III. Cruels, où courez-vous?', 'Hypermnestre: Acte V (première version, 1716): III. Cruels, où courez-vous? ...', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 19226 AND p.composer_id = 236
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:29d08242-4079-411c-8a65-80551e687cde'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 23, part.movement_number = NULL,
    part.name_ko = 'Acte III: XII. Air pour les Peuples', part.name_en = 'Hypermnestre: Acte III: XII. Air pour les Peuples',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 19226 AND p.composer_id = 236 AND part.part_key = 'musicbrainz:2d40e975-ad1e-428d-b8ce-e361e4fea567' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:2d40e975-ad1e-428d-b8ce-e361e4fea567', 23, NULL, 'Acte III: XII. Air pour les Peuples', 'Hypermnestre: Acte III: XII. Air pour les Peuples', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 19226 AND p.composer_id = 236
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:2d40e975-ad1e-428d-b8ce-e361e4fea567'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 24, part.movement_number = NULL,
    part.name_ko = 'Acte III: XXI. Eh bien! de ce poignard armez donc votre main', part.name_en = 'Hypermnestre: Acte III: XXI. Eh bien! de ce poignard armez donc votre main ...',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 19226 AND p.composer_id = 236 AND part.part_key = 'musicbrainz:2edc5194-b64f-466c-8f8c-19ae35b9f47e' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:2edc5194-b64f-466c-8f8c-19ae35b9f47e', 24, NULL, 'Acte III: XXI. Eh bien! de ce poignard armez donc votre main', 'Hypermnestre: Acte III: XXI. Eh bien! de ce poignard armez donc votre main ...', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 19226 AND p.composer_id = 236
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:2edc5194-b64f-466c-8f8c-19ae35b9f47e'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 25, part.movement_number = NULL,
    part.name_ko = 'Acte I: IV. C''est trop vous retracer une image si noire', part.name_en = 'Hypermnestre: Acte I: IV. C''est trop vous retracer une image si noire ...',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 19226 AND p.composer_id = 236 AND part.part_key = 'musicbrainz:33930723-327a-4f3c-b2e7-def906280634' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:33930723-327a-4f3c-b2e7-def906280634', 25, NULL, 'Acte I: IV. C''est trop vous retracer une image si noire', 'Hypermnestre: Acte I: IV. C''est trop vous retracer une image si noire ...', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 19226 AND p.composer_id = 236
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:33930723-327a-4f3c-b2e7-def906280634'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 26, part.movement_number = NULL,
    part.name_ko = 'Acte I: I. Enfin, voici le jour où l''hymen de vos filles', part.name_en = 'Hypermnestre: Acte I: I. Enfin, voici le jour où l''hymen de vos filles',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 19226 AND p.composer_id = 236 AND part.part_key = 'musicbrainz:349e1bb3-e075-4142-9781-269587b59a63' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:349e1bb3-e075-4142-9781-269587b59a63', 26, NULL, 'Acte I: I. Enfin, voici le jour où l''hymen de vos filles', 'Hypermnestre: Acte I: I. Enfin, voici le jour où l''hymen de vos filles', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 19226 AND p.composer_id = 236
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:349e1bb3-e075-4142-9781-269587b59a63'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 27, part.movement_number = NULL,
    part.name_ko = 'Acte III: III. Prélude', part.name_en = 'Hypermnestre: Acte III: III. Prélude',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 19226 AND p.composer_id = 236 AND part.part_key = 'musicbrainz:37fb7493-952a-47ab-9341-148001276fa3' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:37fb7493-952a-47ab-9341-148001276fa3', 27, NULL, 'Acte III: III. Prélude', 'Hypermnestre: Acte III: III. Prélude', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 19226 AND p.composer_id = 236
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:37fb7493-952a-47ab-9341-148001276fa3'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 28, part.movement_number = NULL,
    part.name_ko = 'Acte I: III. Je l''ai vu cette nuit, il sortait d''un nuage', part.name_en = 'Hypermnestre: Acte I: III. Je l''ai vu cette nuit, il sortait d''un nuage ...',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 19226 AND p.composer_id = 236 AND part.part_key = 'musicbrainz:39feec2b-a854-4db9-a41e-c73ce6f4c8d0' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:39feec2b-a854-4db9-a41e-c73ce6f4c8d0', 28, NULL, 'Acte I: III. Je l''ai vu cette nuit, il sortait d''un nuage', 'Hypermnestre: Acte I: III. Je l''ai vu cette nuit, il sortait d''un nuage ...', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 19226 AND p.composer_id = 236
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:39feec2b-a854-4db9-a41e-c73ce6f4c8d0'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 29, part.movement_number = NULL,
    part.name_ko = 'Acte V: VII. Non, n''accuse que toi de mon funeste sort', part.name_en = 'Hypermnestre: Acte V: VII. Non, n''accuse que toi de mon funeste sort ...',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 19226 AND p.composer_id = 236 AND part.part_key = 'musicbrainz:3a76dac0-e6a8-441b-aa0f-e7fdd4550aae' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:3a76dac0-e6a8-441b-aa0f-e7fdd4550aae', 29, NULL, 'Acte V: VII. Non, n''accuse que toi de mon funeste sort', 'Hypermnestre: Acte V: VII. Non, n''accuse que toi de mon funeste sort ...', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 19226 AND p.composer_id = 236
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:3a76dac0-e6a8-441b-aa0f-e7fdd4550aae'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 30, part.movement_number = NULL,
    part.name_ko = 'Acte II: III. Mais un calme soudain vient aplanir les flots', part.name_en = 'Hypermnestre: Acte II: III. Mais un calme soudain vient aplanir les flots ...',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 19226 AND p.composer_id = 236 AND part.part_key = 'musicbrainz:3c583fba-a228-4071-8ad5-aa0b07087258' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:3c583fba-a228-4071-8ad5-aa0b07087258', 30, NULL, 'Acte II: III. Mais un calme soudain vient aplanir les flots', 'Hypermnestre: Acte II: III. Mais un calme soudain vient aplanir les flots ...', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 19226 AND p.composer_id = 236
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:3c583fba-a228-4071-8ad5-aa0b07087258'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 31, part.movement_number = NULL,
    part.name_ko = 'Prologue: V. Parmi les beautés immortelles', part.name_en = 'Hypermnestre: Prologue: V. Parmi les beautés immortelles ...',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 19226 AND p.composer_id = 236 AND part.part_key = 'musicbrainz:46df3c35-4ead-4cda-b845-23906b4d92ad' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:46df3c35-4ead-4cda-b845-23906b4d92ad', 31, NULL, 'Prologue: V. Parmi les beautés immortelles', 'Hypermnestre: Prologue: V. Parmi les beautés immortelles ...', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 19226 AND p.composer_id = 236
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:46df3c35-4ead-4cda-b845-23906b4d92ad'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 32, part.movement_number = NULL,
    part.name_ko = 'Acte II: I. En vain, contre tous les mortels', part.name_en = 'Hypermnestre: Acte II: I. En vain, contre tous les mortels ...',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 19226 AND p.composer_id = 236 AND part.part_key = 'musicbrainz:47f15fba-c690-492b-965a-da3f19f4e996' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:47f15fba-c690-492b-965a-da3f19f4e996', 32, NULL, 'Acte II: I. En vain, contre tous les mortels', 'Hypermnestre: Acte II: I. En vain, contre tous les mortels ...', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 19226 AND p.composer_id = 236
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:47f15fba-c690-492b-965a-da3f19f4e996'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 33, part.movement_number = NULL,
    part.name_ko = 'Acte IV: XIV. Arrêtez! Ciel! qu''allez-vous faire?', part.name_en = 'Hypermnestre: Acte IV: XIV. Arrêtez! Ciel! qu''allez-vous faire? ...',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 19226 AND p.composer_id = 236 AND part.part_key = 'musicbrainz:528bb1a0-e985-4020-ad28-e5b461e54570' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:528bb1a0-e985-4020-ad28-e5b461e54570', 33, NULL, 'Acte IV: XIV. Arrêtez! Ciel! qu''allez-vous faire?', 'Hypermnestre: Acte IV: XIV. Arrêtez! Ciel! qu''allez-vous faire? ...', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 19226 AND p.composer_id = 236
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:528bb1a0-e985-4020-ad28-e5b461e54570'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 34, part.movement_number = NULL,
    part.name_ko = 'Prologue: I. Ouverture', part.name_en = 'Hypermnestre: Prologue: I. Ouverture',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 19226 AND p.composer_id = 236 AND part.part_key = 'musicbrainz:546d2d3e-bf0a-4a17-ad84-3b9c1543115e' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:546d2d3e-bf0a-4a17-ad84-3b9c1543115e', 34, NULL, 'Prologue: I. Ouverture', 'Hypermnestre: Prologue: I. Ouverture', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 19226 AND p.composer_id = 236
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:546d2d3e-bf0a-4a17-ad84-3b9c1543115e'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 35, part.movement_number = NULL,
    part.name_ko = 'Acte IV: I. Les mutins sont domptés, que rien ne vous arrête', part.name_en = 'Hypermnestre: Acte IV: I. Les mutins sont domptés, que rien ne vous arrête ...',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 19226 AND p.composer_id = 236 AND part.part_key = 'musicbrainz:58112c32-c673-41cd-860a-4240658c5138' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:58112c32-c673-41cd-860a-4240658c5138', 35, NULL, 'Acte IV: I. Les mutins sont domptés, que rien ne vous arrête', 'Hypermnestre: Acte IV: I. Les mutins sont domptés, que rien ne vous arrête ...', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 19226 AND p.composer_id = 236
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:58112c32-c673-41cd-860a-4240658c5138'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 36, part.movement_number = NULL,
    part.name_ko = 'Acte III: XIII. Les chaînes les plus belles', part.name_en = 'Hypermnestre: Acte III: XIII. Les chaînes les plus belles ...',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 19226 AND p.composer_id = 236 AND part.part_key = 'musicbrainz:58dbe7cf-3c3d-4ef3-9f74-553f6db94fdd' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:58dbe7cf-3c3d-4ef3-9f74-553f6db94fdd', 36, NULL, 'Acte III: XIII. Les chaînes les plus belles', 'Hypermnestre: Acte III: XIII. Les chaînes les plus belles ...', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 19226 AND p.composer_id = 236
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:58dbe7cf-3c3d-4ef3-9f74-553f6db94fdd'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 37, part.movement_number = NULL,
    part.name_ko = 'Acte II: XV. Seigneur, auprès du roi le devoir nous appelle', part.name_en = 'Hypermnestre: Acte II: XV. Seigneur, auprès du roi le devoir nous appelle ...',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 19226 AND p.composer_id = 236 AND part.part_key = 'musicbrainz:5f58a5fd-7f1a-45db-b432-4eea27d82105' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:5f58a5fd-7f1a-45db-b432-4eea27d82105', 37, NULL, 'Acte II: XV. Seigneur, auprès du roi le devoir nous appelle', 'Hypermnestre: Acte II: XV. Seigneur, auprès du roi le devoir nous appelle ...', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 19226 AND p.composer_id = 236
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:5f58a5fd-7f1a-45db-b432-4eea27d82105'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 38, part.movement_number = NULL,
    part.name_ko = 'Entracte I', part.name_en = 'Hypermnestre: Entracte I',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 19226 AND p.composer_id = 236 AND part.part_key = 'musicbrainz:60d63130-37a9-4c73-882a-b233c40bf103' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:60d63130-37a9-4c73-882a-b233c40bf103', 38, NULL, 'Entracte I', 'Hypermnestre: Entracte I', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 19226 AND p.composer_id = 236
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:60d63130-37a9-4c73-882a-b233c40bf103'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 39, part.movement_number = NULL,
    part.name_ko = 'Acte V: VI. Qu''on épargne le sang, il souillerait ma gloire', part.name_en = 'Hypermnestre: Acte V: VI. Qu''on épargne le sang, il souillerait ma gloire ...',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 19226 AND p.composer_id = 236 AND part.part_key = 'musicbrainz:653439e6-d007-443a-a309-43eafd42699c' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:653439e6-d007-443a-a309-43eafd42699c', 39, NULL, 'Acte V: VI. Qu''on épargne le sang, il souillerait ma gloire', 'Hypermnestre: Acte V: VI. Qu''on épargne le sang, il souillerait ma gloire ...', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 19226 AND p.composer_id = 236
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:653439e6-d007-443a-a309-43eafd42699c'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 40, part.movement_number = NULL,
    part.name_ko = 'Acte I: XIII. Ne crois pas expierta sacrilège audace', part.name_en = 'Hypermnestre: Acte I: XIII. Ne crois pas expierta sacrilège audace ...',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 19226 AND p.composer_id = 236 AND part.part_key = 'musicbrainz:6785936e-2cb2-4909-865e-9d1cfe781cb3' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:6785936e-2cb2-4909-865e-9d1cfe781cb3', 40, NULL, 'Acte I: XIII. Ne crois pas expierta sacrilège audace', 'Hypermnestre: Acte I: XIII. Ne crois pas expierta sacrilège audace ...', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 19226 AND p.composer_id = 236
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:6785936e-2cb2-4909-865e-9d1cfe781cb3'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 41, part.movement_number = NULL,
    part.name_ko = 'Acte III: II. Venez former les nœuds où votre cœur aspire', part.name_en = 'Hypermnestre: Acte III: II. Venez former les nœuds où votre cœur aspire ...',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 19226 AND p.composer_id = 236 AND part.part_key = 'musicbrainz:6a2a74ef-391a-4f1f-b784-f17d7b231cf9' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:6a2a74ef-391a-4f1f-b784-f17d7b231cf9', 41, NULL, 'Acte III: II. Venez former les nœuds où votre cœur aspire', 'Hypermnestre: Acte III: II. Venez former les nœuds où votre cœur aspire ...', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 19226 AND p.composer_id = 236
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:6a2a74ef-391a-4f1f-b784-f17d7b231cf9'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 42, part.movement_number = NULL,
    part.name_ko = 'Acte V (première version, 1716): XI. Peuples, par votre obéissance', part.name_en = 'Hypermnestre: Acte V (première version, 1716): XI. Peuples, par votre obéissance ...',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 19226 AND p.composer_id = 236 AND part.part_key = 'musicbrainz:6d81b491-ff7f-479b-8744-c25aa71b9454' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:6d81b491-ff7f-479b-8744-c25aa71b9454', 42, NULL, 'Acte V (première version, 1716): XI. Peuples, par votre obéissance', 'Hypermnestre: Acte V (première version, 1716): XI. Peuples, par votre obéissance ...', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 19226 AND p.composer_id = 236
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:6d81b491-ff7f-479b-8744-c25aa71b9454'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 43, part.movement_number = NULL,
    part.name_ko = 'Acte V: I. Redoutables vengeurs des crimes de la terre', part.name_en = 'Hypermnestre: Acte V: I. Redoutables vengeurs des crimes de la terre ...',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 19226 AND p.composer_id = 236 AND part.part_key = 'musicbrainz:6e7843f1-1e48-4797-ad94-345e7ac6cb2b' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:6e7843f1-1e48-4797-ad94-345e7ac6cb2b', 43, NULL, 'Acte V: I. Redoutables vengeurs des crimes de la terre', 'Hypermnestre: Acte V: I. Redoutables vengeurs des crimes de la terre ...', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 19226 AND p.composer_id = 236
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:6e7843f1-1e48-4797-ad94-345e7ac6cb2b'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 44, part.movement_number = NULL,
    part.name_ko = 'Prologue: XVIII. Chantons les douceurs de la paix', part.name_en = 'Hypermnestre: Prologue: XVIII. Chantons les douceurs de la paix ...',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 19226 AND p.composer_id = 236 AND part.part_key = 'musicbrainz:6ee880db-6c69-4867-9750-1e389139c3b3' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:6ee880db-6c69-4867-9750-1e389139c3b3', 44, NULL, 'Prologue: XVIII. Chantons les douceurs de la paix', 'Hypermnestre: Prologue: XVIII. Chantons les douceurs de la paix ...', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 19226 AND p.composer_id = 236
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:6ee880db-6c69-4867-9750-1e389139c3b3'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 45, part.movement_number = NULL,
    part.name_ko = 'Acte II: II. Seigneur, à vos soupirs, je viens mêler mes pleurs', part.name_en = 'Hypermnestre: Acte II: II. Seigneur, à vos soupirs, je viens mêler mes pleurs ...',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 19226 AND p.composer_id = 236 AND part.part_key = 'musicbrainz:6fc870a1-8e54-4aee-add0-9e05367eb739' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:6fc870a1-8e54-4aee-add0-9e05367eb739', 45, NULL, 'Acte II: II. Seigneur, à vos soupirs, je viens mêler mes pleurs', 'Hypermnestre: Acte II: II. Seigneur, à vos soupirs, je viens mêler mes pleurs ...', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 19226 AND p.composer_id = 236
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:6fc870a1-8e54-4aee-add0-9e05367eb739'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 46, part.movement_number = NULL,
    part.name_ko = 'Acte III: XVI. Deuxième Menuet pour les Peuples (reprise)', part.name_en = 'Hypermnestre: Acte III: XVI. Deuxième Menuet pour les Peuples (reprise)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 19226 AND p.composer_id = 236 AND part.part_key = 'musicbrainz:754148cc-b1ec-489e-805e-82cc3672b04f' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:754148cc-b1ec-489e-805e-82cc3672b04f', 46, NULL, 'Acte III: XVI. Deuxième Menuet pour les Peuples (reprise)', 'Hypermnestre: Acte III: XVI. Deuxième Menuet pour les Peuples (reprise)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 19226 AND p.composer_id = 236
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:754148cc-b1ec-489e-805e-82cc3672b04f'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 47, part.movement_number = NULL,
    part.name_ko = 'Acte IV: III. Ô nuit, votre ombre est préférable', part.name_en = 'Hypermnestre: Acte IV: III. Ô nuit, votre ombre est préférable ...',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 19226 AND p.composer_id = 236 AND part.part_key = 'musicbrainz:7687a169-1058-44b2-81d6-5a99b6533f04' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:7687a169-1058-44b2-81d6-5a99b6533f04', 47, NULL, 'Acte IV: III. Ô nuit, votre ombre est préférable', 'Hypermnestre: Acte IV: III. Ô nuit, votre ombre est préférable ...', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 19226 AND p.composer_id = 236
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:7687a169-1058-44b2-81d6-5a99b6533f04'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 48, part.movement_number = NULL,
    part.name_ko = 'Prologue: XIV. Peuples, avec plaisir je reçois votre hommage', part.name_en = 'Hypermnestre: Prologue: XIV. Peuples, avec plaisir je reçois votre hommage ...',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 19226 AND p.composer_id = 236 AND part.part_key = 'musicbrainz:77d6fbb9-0ca4-4740-a27d-ba03c591336d' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:77d6fbb9-0ca4-4740-a27d-ba03c591336d', 48, NULL, 'Prologue: XIV. Peuples, avec plaisir je reçois votre hommage', 'Hypermnestre: Prologue: XIV. Peuples, avec plaisir je reçois votre hommage ...', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 19226 AND p.composer_id = 236
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:77d6fbb9-0ca4-4740-a27d-ba03c591336d'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 49, part.movement_number = NULL,
    part.name_ko = 'Acte IV: VII. Jeunes époux, votre bonheur s''avance', part.name_en = 'Hypermnestre: Acte IV: VII. Jeunes époux, votre bonheur s''avance ...',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 19226 AND p.composer_id = 236 AND part.part_key = 'musicbrainz:78fc7fdc-c919-46db-8505-01b4ae0a7f7c' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:78fc7fdc-c919-46db-8505-01b4ae0a7f7c', 49, NULL, 'Acte IV: VII. Jeunes époux, votre bonheur s''avance', 'Hypermnestre: Acte IV: VII. Jeunes époux, votre bonheur s''avance ...', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 19226 AND p.composer_id = 236
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:78fc7fdc-c919-46db-8505-01b4ae0a7f7c'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 50, part.movement_number = NULL,
    part.name_ko = 'Acte V: IV. Qu''entends-je? Il fuit? Qu''on marche sur ses pas', part.name_en = 'Hypermnestre: Acte V: IV. Qu''entends-je? Il fuit? Qu''on marche sur ses pas ...',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 19226 AND p.composer_id = 236 AND part.part_key = 'musicbrainz:7a52be9c-4693-4620-a115-c97247e03010' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:7a52be9c-4693-4620-a115-c97247e03010', 50, NULL, 'Acte V: IV. Qu''entends-je? Il fuit? Qu''on marche sur ses pas', 'Hypermnestre: Acte V: IV. Qu''entends-je? Il fuit? Qu''on marche sur ses pas ...', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 19226 AND p.composer_id = 236
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:7a52be9c-4693-4620-a115-c97247e03010'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 51, part.movement_number = NULL,
    part.name_ko = 'Acte III: XIX. Princesse, vous voyez le nœud qui vous engage', part.name_en = 'Hypermnestre: Acte III: XIX. Princesse, vous voyez le nœud qui vous engage ...',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 19226 AND p.composer_id = 236 AND part.part_key = 'musicbrainz:7c6978f1-b14a-431b-b84d-88cc38b63270' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:7c6978f1-b14a-431b-b84d-88cc38b63270', 51, NULL, 'Acte III: XIX. Princesse, vous voyez le nœud qui vous engage', 'Hypermnestre: Acte III: XIX. Princesse, vous voyez le nœud qui vous engage ...', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 19226 AND p.composer_id = 236
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:7c6978f1-b14a-431b-b84d-88cc38b63270'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 52, part.movement_number = NULL,
    part.name_ko = 'Prologue: XV. Chantez; que de milieu des airs', part.name_en = 'Hypermnestre: Prologue: XV. Chantez; que de milieu des airs ...',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 19226 AND p.composer_id = 236 AND part.part_key = 'musicbrainz:7f66109a-6caa-4197-ba62-f872ea1e27bd' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:7f66109a-6caa-4197-ba62-f872ea1e27bd', 52, NULL, 'Prologue: XV. Chantez; que de milieu des airs', 'Hypermnestre: Prologue: XV. Chantez; que de milieu des airs ...', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 19226 AND p.composer_id = 236
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:7f66109a-6caa-4197-ba62-f872ea1e27bd'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 53, part.movement_number = NULL,
    part.name_ko = 'Acte III: VI. Ô vous, Divinité suprême', part.name_en = 'Hypermnestre: Acte III: VI. Ô vous, Divinité suprême ...',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 19226 AND p.composer_id = 236 AND part.part_key = 'musicbrainz:82556e4f-d855-4099-b677-2c0efde56d99' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:82556e4f-d855-4099-b677-2c0efde56d99', 53, NULL, 'Acte III: VI. Ô vous, Divinité suprême', 'Hypermnestre: Acte III: VI. Ô vous, Divinité suprême ...', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 19226 AND p.composer_id = 236
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:82556e4f-d855-4099-b677-2c0efde56d99'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 54, part.movement_number = NULL,
    part.name_ko = 'Acte II: IV. Venez, jeune Héros', part.name_en = 'Hypermnestre: Acte II: IV. Venez, jeune Héros ...',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 19226 AND p.composer_id = 236 AND part.part_key = 'musicbrainz:83379774-99a8-4aec-85a2-1501002a2db8' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:83379774-99a8-4aec-85a2-1501002a2db8', 54, NULL, 'Acte II: IV. Venez, jeune Héros', 'Hypermnestre: Acte II: IV. Venez, jeune Héros ...', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 19226 AND p.composer_id = 236
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:83379774-99a8-4aec-85a2-1501002a2db8'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 55, part.movement_number = NULL,
    part.name_ko = 'Acte I: VI. Ombre d''un prince infortuné', part.name_en = 'Hypermnestre: Acte I: VI. Ombre d''un prince infortuné ...',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 19226 AND p.composer_id = 236 AND part.part_key = 'musicbrainz:83432634-ef4e-49ee-be24-59df990bbf20' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:83432634-ef4e-49ee-be24-59df990bbf20', 55, NULL, 'Acte I: VI. Ombre d''un prince infortuné', 'Hypermnestre: Acte I: VI. Ombre d''un prince infortuné ...', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 19226 AND p.composer_id = 236
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:83432634-ef4e-49ee-be24-59df990bbf20'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 56, part.movement_number = NULL,
    part.name_ko = 'Prologue: IX. Gavotte pour les Naïades', part.name_en = 'Hypermnestre: Prologue: IX. Gavotte pour les Naïades',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 19226 AND p.composer_id = 236 AND part.part_key = 'musicbrainz:85c7cd1e-c6c9-4c70-b2bb-caab1a976260' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:85c7cd1e-c6c9-4c70-b2bb-caab1a976260', 56, NULL, 'Prologue: IX. Gavotte pour les Naïades', 'Hypermnestre: Prologue: IX. Gavotte pour les Naïades', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 19226 AND p.composer_id = 236
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:85c7cd1e-c6c9-4c70-b2bb-caab1a976260'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 57, part.movement_number = NULL,
    part.name_ko = 'Acte I: IX. Sarabande pour les Peuples argiens', part.name_en = 'Hypermnestre: Acte I: IX. Sarabande pour les Peuples argiens',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 19226 AND p.composer_id = 236 AND part.part_key = 'musicbrainz:87b7b8f4-2df1-49b9-85d2-4301a53ee44b' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:87b7b8f4-2df1-49b9-85d2-4301a53ee44b', 57, NULL, 'Acte I: IX. Sarabande pour les Peuples argiens', 'Hypermnestre: Acte I: IX. Sarabande pour les Peuples argiens', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 19226 AND p.composer_id = 236
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:87b7b8f4-2df1-49b9-85d2-4301a53ee44b'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 58, part.movement_number = NULL,
    part.name_ko = 'Prologue: XII. Menuet pour les Naïades (reprise)', part.name_en = 'Hypermnestre: Prologue: XII. Menuet pour les Naïades (reprise)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 19226 AND p.composer_id = 236 AND part.part_key = 'musicbrainz:889685cf-159d-4c1d-a35f-2ee1cb717a45' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:889685cf-159d-4c1d-a35f-2ee1cb717a45', 58, NULL, 'Prologue: XII. Menuet pour les Naïades (reprise)', 'Hypermnestre: Prologue: XII. Menuet pour les Naïades (reprise)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 19226 AND p.composer_id = 236
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:889685cf-159d-4c1d-a35f-2ee1cb717a45'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 59, part.movement_number = NULL,
    part.name_ko = 'Acte V (première version, 1716): IV. Mais, quel nouvel effroi?', part.name_en = 'Hypermnestre: Acte V (première version, 1716): IV. Mais, quel nouvel effroi? ...',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 19226 AND p.composer_id = 236 AND part.part_key = 'musicbrainz:8e66771c-f3ce-4999-b543-f176d6da9a34' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:8e66771c-f3ce-4999-b543-f176d6da9a34', 59, NULL, 'Acte V (première version, 1716): IV. Mais, quel nouvel effroi?', 'Hypermnestre: Acte V (première version, 1716): IV. Mais, quel nouvel effroi? ...', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 19226 AND p.composer_id = 236
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:8e66771c-f3ce-4999-b543-f176d6da9a34'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 60, part.movement_number = NULL,
    part.name_ko = 'Acte II: X. Premier et Deuxième Passepieds pour les Matelots argiens', part.name_en = 'Hypermnestre: Acte II: X. Premier et Deuxième Passepieds pour les Matelots argiens',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 19226 AND p.composer_id = 236 AND part.part_key = 'musicbrainz:8e8de5cb-3509-4165-9fa6-f0761b54d32b' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:8e8de5cb-3509-4165-9fa6-f0761b54d32b', 60, NULL, 'Acte II: X. Premier et Deuxième Passepieds pour les Matelots argiens', 'Hypermnestre: Acte II: X. Premier et Deuxième Passepieds pour les Matelots argiens', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 19226 AND p.composer_id = 236
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:8e8de5cb-3509-4165-9fa6-f0761b54d32b'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 61, part.movement_number = NULL,
    part.name_ko = 'Entracte II', part.name_en = 'Hypermnestre: Entracte II',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 19226 AND p.composer_id = 236 AND part.part_key = 'musicbrainz:95b7ff3e-00b2-47b1-9470-fdb62b966e96' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:95b7ff3e-00b2-47b1-9470-fdb62b966e96', 61, NULL, 'Entracte II', 'Hypermnestre: Entracte II', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 19226 AND p.composer_id = 236
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:95b7ff3e-00b2-47b1-9470-fdb62b966e96'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 62, part.movement_number = NULL,
    part.name_ko = 'Acte III: XVII. À l''Amour, en ce jour', part.name_en = 'Hypermnestre: Acte III: XVII. À l''Amour, en ce jour ...',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 19226 AND p.composer_id = 236 AND part.part_key = 'musicbrainz:971c2ebf-efaa-4922-a2d3-c740126ff4c0' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:971c2ebf-efaa-4922-a2d3-c740126ff4c0', 62, NULL, 'Acte III: XVII. À l''Amour, en ce jour', 'Hypermnestre: Acte III: XVII. À l''Amour, en ce jour ...', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 19226 AND p.composer_id = 236
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:971c2ebf-efaa-4922-a2d3-c740126ff4c0'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 63, part.movement_number = NULL,
    part.name_ko = 'Acte I: V. Marche pour les Peuples argiens', part.name_en = 'Hypermnestre: Acte I: V. Marche pour les Peuples argiens',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 19226 AND p.composer_id = 236 AND part.part_key = 'musicbrainz:97e6069b-178d-4e91-ab3c-94639b1ea44c' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:97e6069b-178d-4e91-ab3c-94639b1ea44c', 63, NULL, 'Acte I: V. Marche pour les Peuples argiens', 'Hypermnestre: Acte I: V. Marche pour les Peuples argiens', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 19226 AND p.composer_id = 236
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:97e6069b-178d-4e91-ab3c-94639b1ea44c'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 64, part.movement_number = NULL,
    part.name_ko = 'Acte III: XVIII. Seigneur, prévenez les mutins', part.name_en = 'Hypermnestre: Acte III: XVIII. Seigneur, prévenez les mutins ...',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 19226 AND p.composer_id = 236 AND part.part_key = 'musicbrainz:9b980149-0f16-43ed-883c-16d8aa99e162' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:9b980149-0f16-43ed-883c-16d8aa99e162', 64, NULL, 'Acte III: XVIII. Seigneur, prévenez les mutins', 'Hypermnestre: Acte III: XVIII. Seigneur, prévenez les mutins ...', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 19226 AND p.composer_id = 236
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:9b980149-0f16-43ed-883c-16d8aa99e162'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 65, part.movement_number = NULL,
    part.name_ko = 'Acte V (première version, 1716): IX. Grands Dieux, quelle fureur l''anime!', part.name_en = 'Hypermnestre: Acte V (première version, 1716): IX. Grands Dieux, quelle fureur l''anime! ...',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 19226 AND p.composer_id = 236 AND part.part_key = 'musicbrainz:9cbe883d-5476-4bbb-9436-efe402213454' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:9cbe883d-5476-4bbb-9436-efe402213454', 65, NULL, 'Acte V (première version, 1716): IX. Grands Dieux, quelle fureur l''anime!', 'Hypermnestre: Acte V (première version, 1716): IX. Grands Dieux, quelle fureur l''anime! ...', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 19226 AND p.composer_id = 236
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:9cbe883d-5476-4bbb-9436-efe402213454'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 66, part.movement_number = NULL,
    part.name_ko = 'Acte IV: XIII. Fer fatal, seul recours de mon cœur abattu', part.name_en = 'Hypermnestre: Acte IV: XIII. Fer fatal, seul recours de mon cœur abattu ...',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 19226 AND p.composer_id = 236 AND part.part_key = 'musicbrainz:9e56a554-5556-46ce-b4f8-6dfc655c1685' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:9e56a554-5556-46ce-b4f8-6dfc655c1685', 66, NULL, 'Acte IV: XIII. Fer fatal, seul recours de mon cœur abattu', 'Hypermnestre: Acte IV: XIII. Fer fatal, seul recours de mon cœur abattu ...', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 19226 AND p.composer_id = 236
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:9e56a554-5556-46ce-b4f8-6dfc655c1685'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 67, part.movement_number = NULL,
    part.name_ko = 'Acte V: V. Songeons, songeons', part.name_en = 'Hypermnestre: Acte V: V. Songeons, songeons ...',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 19226 AND p.composer_id = 236 AND part.part_key = 'musicbrainz:9ed10e99-9074-412a-aff7-a7c9062f0fa4' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:9ed10e99-9074-412a-aff7-a7c9062f0fa4', 67, NULL, 'Acte V: V. Songeons, songeons', 'Hypermnestre: Acte V: V. Songeons, songeons ...', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 19226 AND p.composer_id = 236
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:9ed10e99-9074-412a-aff7-a7c9062f0fa4'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 68, part.movement_number = NULL,
    part.name_ko = 'Acte IV: XII. Où trouver Hypermnestre?', part.name_en = 'Hypermnestre: Acte IV: XII. Où trouver Hypermnestre? ...',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 19226 AND p.composer_id = 236 AND part.part_key = 'musicbrainz:9f44e994-cfd5-444d-9536-29cd43fb2afa' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:9f44e994-cfd5-444d-9536-29cd43fb2afa', 68, NULL, 'Acte IV: XII. Où trouver Hypermnestre?', 'Hypermnestre: Acte IV: XII. Où trouver Hypermnestre? ...', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 19226 AND p.composer_id = 236
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:9f44e994-cfd5-444d-9536-29cd43fb2afa'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 69, part.movement_number = NULL,
    part.name_ko = 'Prologue: VI. La paix que nous goutons est un de vos bienfaits', part.name_en = 'Hypermnestre: Prologue: VI. La paix que nous goutons est un de vos bienfaits ...',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 19226 AND p.composer_id = 236 AND part.part_key = 'musicbrainz:a16a733b-eb43-4647-b46a-9e3fceb62543' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:a16a733b-eb43-4647-b46a-9e3fceb62543', 69, NULL, 'Prologue: VI. La paix que nous goutons est un de vos bienfaits', 'Hypermnestre: Prologue: VI. La paix que nous goutons est un de vos bienfaits ...', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 19226 AND p.composer_id = 236
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:a16a733b-eb43-4647-b46a-9e3fceb62543'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 70, part.movement_number = NULL,
    part.name_ko = 'Acte V (première version, 1716): VII. Les chemins sont ouverts, partons', part.name_en = 'Hypermnestre: Acte V (première version, 1716): VII. Les chemins sont ouverts, partons ...',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 19226 AND p.composer_id = 236 AND part.part_key = 'musicbrainz:a4a6d6c4-c5c9-4d25-b89c-6ba2b3288c3a' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:a4a6d6c4-c5c9-4d25-b89c-6ba2b3288c3a', 70, NULL, 'Acte V (première version, 1716): VII. Les chemins sont ouverts, partons', 'Hypermnestre: Acte V (première version, 1716): VII. Les chemins sont ouverts, partons ...', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 19226 AND p.composer_id = 236
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:a4a6d6c4-c5c9-4d25-b89c-6ba2b3288c3a'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 71, part.movement_number = NULL,
    part.name_ko = 'Acte V (première version, 1716): V. Combat des Argiens et des Égyptiens', part.name_en = 'Hypermnestre: Acte V (première version, 1716): V. Combat des Argiens et des Égyptiens',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 19226 AND p.composer_id = 236 AND part.part_key = 'musicbrainz:ad31e53e-5e4e-43bb-b74f-2af1b186f7b8' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:ad31e53e-5e4e-43bb-b74f-2af1b186f7b8', 71, NULL, 'Acte V (première version, 1716): V. Combat des Argiens et des Égyptiens', 'Hypermnestre: Acte V (première version, 1716): V. Combat des Argiens et des Égyptiens', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 19226 AND p.composer_id = 236
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:ad31e53e-5e4e-43bb-b74f-2af1b186f7b8'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 72, part.movement_number = NULL,
    part.name_ko = 'Acte IV: II. Marche pour l''entrée des Jeunes Gens', part.name_en = 'Hypermnestre: Acte IV: II. Marche pour l''entrée des Jeunes Gens',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 19226 AND p.composer_id = 236 AND part.part_key = 'musicbrainz:af9695a2-9abf-40b4-a803-2285fc2a153a' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:af9695a2-9abf-40b4-a803-2285fc2a153a', 72, NULL, 'Acte IV: II. Marche pour l''entrée des Jeunes Gens', 'Hypermnestre: Acte IV: II. Marche pour l''entrée des Jeunes Gens', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 19226 AND p.composer_id = 236
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:af9695a2-9abf-40b4-a803-2285fc2a153a'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 73, part.movement_number = NULL,
    part.name_ko = 'Acte III: VIII. Aux habitants d''Argos, aux bergers d''alentour', part.name_en = 'Hypermnestre: Acte III: VIII. Aux habitants d''Argos, aux bergers d''alentour ...',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 19226 AND p.composer_id = 236 AND part.part_key = 'musicbrainz:b01febd6-81f5-479e-aa61-ca75ef7d78b3' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:b01febd6-81f5-479e-aa61-ca75ef7d78b3', 73, NULL, 'Acte III: VIII. Aux habitants d''Argos, aux bergers d''alentour', 'Hypermnestre: Acte III: VIII. Aux habitants d''Argos, aux bergers d''alentour ...', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 19226 AND p.composer_id = 236
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:b01febd6-81f5-479e-aa61-ca75ef7d78b3'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 74, part.movement_number = NULL,
    part.name_ko = 'Prologue: XIX. Ouverture (reprise)', part.name_en = 'Hypermnestre: Prologue: XIX. Ouverture (reprise)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 19226 AND p.composer_id = 236 AND part.part_key = 'musicbrainz:b11ea75a-df5e-468d-9742-47e13c2ba9b5' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:b11ea75a-df5e-468d-9742-47e13c2ba9b5', 74, NULL, 'Prologue: XIX. Ouverture (reprise)', 'Hypermnestre: Prologue: XIX. Ouverture (reprise)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 19226 AND p.composer_id = 236
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:b11ea75a-df5e-468d-9742-47e13c2ba9b5'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 75, part.movement_number = NULL,
    part.name_ko = 'Prologue: VIII. Attendez tout de ma puissance', part.name_en = 'Hypermnestre: Prologue: VIII. Attendez tout de ma puissance',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 19226 AND p.composer_id = 236 AND part.part_key = 'musicbrainz:b3ae74e8-0033-426e-bb34-127ab911e91f' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:b3ae74e8-0033-426e-bb34-127ab911e91f', 75, NULL, 'Prologue: VIII. Attendez tout de ma puissance', 'Hypermnestre: Prologue: VIII. Attendez tout de ma puissance', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 19226 AND p.composer_id = 236
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:b3ae74e8-0033-426e-bb34-127ab911e91f'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 76, part.movement_number = NULL,
    part.name_ko = 'Acte III: XXII. En vain l''Amour retient tes coups', part.name_en = 'Hypermnestre: Acte III: XXII. En vain l''Amour retient tes coups ...',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 19226 AND p.composer_id = 236 AND part.part_key = 'musicbrainz:b4498a66-7ccb-4455-9f5a-b3ddd167fe12' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:b4498a66-7ccb-4455-9f5a-b3ddd167fe12', 76, NULL, 'Acte III: XXII. En vain l''Amour retient tes coups', 'Hypermnestre: Acte III: XXII. En vain l''Amour retient tes coups ...', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 19226 AND p.composer_id = 236
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:b4498a66-7ccb-4455-9f5a-b3ddd167fe12'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 77, part.movement_number = NULL,
    part.name_ko = 'Acte II: VIII. Doux objet du plus tendre amour', part.name_en = 'Hypermnestre: Acte II: VIII. Doux objet du plus tendre amour ...',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 19226 AND p.composer_id = 236 AND part.part_key = 'musicbrainz:b7c02681-4fac-4c75-9693-f99dc554cd46' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:b7c02681-4fac-4c75-9693-f99dc554cd46', 77, NULL, 'Acte II: VIII. Doux objet du plus tendre amour', 'Hypermnestre: Acte II: VIII. Doux objet du plus tendre amour ...', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 19226 AND p.composer_id = 236
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:b7c02681-4fac-4c75-9693-f99dc554cd46'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 78, part.movement_number = NULL,
    part.name_ko = 'Acte III: XIV. Première et Deuxième Menuet pour les Peuples', part.name_en = 'Hypermnestre: Acte III: XIV. Première et Deuxième Menuet pour les Peuples',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 19226 AND p.composer_id = 236 AND part.part_key = 'musicbrainz:b95cb884-f910-4865-b9a7-9026ef57c9f3' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:b95cb884-f910-4865-b9a7-9026ef57c9f3', 78, NULL, 'Acte III: XIV. Première et Deuxième Menuet pour les Peuples', 'Hypermnestre: Acte III: XIV. Première et Deuxième Menuet pour les Peuples', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 19226 AND p.composer_id = 236
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:b95cb884-f910-4865-b9a7-9026ef57c9f3'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 79, part.movement_number = NULL,
    part.name_ko = 'Acte IV: VI. Suite de la Passacaille', part.name_en = 'Hypermnestre: Acte IV: VI. Suite de la Passacaille',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 19226 AND p.composer_id = 236 AND part.part_key = 'musicbrainz:b9742339-4270-4d8f-97c3-5725c5aaf19d' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:b9742339-4270-4d8f-97c3-5725c5aaf19d', 79, NULL, 'Acte IV: VI. Suite de la Passacaille', 'Hypermnestre: Acte IV: VI. Suite de la Passacaille', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 19226 AND p.composer_id = 236
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:b9742339-4270-4d8f-97c3-5725c5aaf19d'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 80, part.movement_number = NULL,
    part.name_ko = 'Acte IV: V. Dieu d''Hymen! Dieu des amants!', part.name_en = 'Hypermnestre: Acte IV: V. Dieu d''Hymen! Dieu des amants! ...',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 19226 AND p.composer_id = 236 AND part.part_key = 'musicbrainz:bbcd49ed-ab17-4655-b211-f1797fe2499f' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:bbcd49ed-ab17-4655-b211-f1797fe2499f', 80, NULL, 'Acte IV: V. Dieu d''Hymen! Dieu des amants!', 'Hypermnestre: Acte IV: V. Dieu d''Hymen! Dieu des amants! ...', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 19226 AND p.composer_id = 236
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:bbcd49ed-ab17-4655-b211-f1797fe2499f'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 81, part.movement_number = NULL,
    part.name_ko = 'Acte II: XVI. Aux autels de l''Hymen, Amour, viens nous conduire', part.name_en = 'Hypermnestre: Acte II: XVI. Aux autels de l''Hymen, Amour, viens nous conduire ...',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 19226 AND p.composer_id = 236 AND part.part_key = 'musicbrainz:beb4428b-2365-44c0-9150-bbec654904c3' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:beb4428b-2365-44c0-9150-bbec654904c3', 81, NULL, 'Acte II: XVI. Aux autels de l''Hymen, Amour, viens nous conduire', 'Hypermnestre: Acte II: XVI. Aux autels de l''Hymen, Amour, viens nous conduire ...', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 19226 AND p.composer_id = 236
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:beb4428b-2365-44c0-9150-bbec654904c3'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 82, part.movement_number = NULL,
    part.name_ko = 'Prologue: II. Puissance Isis, du céleste séjour', part.name_en = 'Hypermnestre: Prologue: II. Puissance Isis, du céleste séjour ...',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 19226 AND p.composer_id = 236 AND part.part_key = 'musicbrainz:c5636a59-2d11-4c85-9c6e-ea1f4a06c6dc' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:c5636a59-2d11-4c85-9c6e-ea1f4a06c6dc', 82, NULL, 'Prologue: II. Puissance Isis, du céleste séjour', 'Hypermnestre: Prologue: II. Puissance Isis, du céleste séjour ...', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 19226 AND p.composer_id = 236
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:c5636a59-2d11-4c85-9c6e-ea1f4a06c6dc'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 83, part.movement_number = NULL,
    part.name_ko = 'Acte II: XI. Hâte-toi de quitter les cieux', part.name_en = 'Hypermnestre: Acte II: XI. Hâte-toi de quitter les cieux ...',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 19226 AND p.composer_id = 236 AND part.part_key = 'musicbrainz:c9108d80-ffee-4e2d-8323-8e536e10c076' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:c9108d80-ffee-4e2d-8323-8e536e10c076', 83, NULL, 'Acte II: XI. Hâte-toi de quitter les cieux', 'Hypermnestre: Acte II: XI. Hâte-toi de quitter les cieux ...', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 19226 AND p.composer_id = 236
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:c9108d80-ffee-4e2d-8323-8e536e10c076'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 84, part.movement_number = NULL,
    part.name_ko = 'Acte IV: VIII. Brillez, flambeau d''hymen', part.name_en = 'Hypermnestre: Acte IV: VIII. Brillez, flambeau d''hymen ...',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 19226 AND p.composer_id = 236 AND part.part_key = 'musicbrainz:cc8163ce-2055-49dc-b553-ff3db07e9ad4' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:cc8163ce-2055-49dc-b553-ff3db07e9ad4', 84, NULL, 'Acte IV: VIII. Brillez, flambeau d''hymen', 'Hypermnestre: Acte IV: VIII. Brillez, flambeau d''hymen ...', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 19226 AND p.composer_id = 236
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:cc8163ce-2055-49dc-b553-ff3db07e9ad4'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 85, part.movement_number = NULL,
    part.name_ko = 'Acte I: XII. Tout fuit ... Le tombeau s''ouvre', part.name_en = 'Hypermnestre: Acte I: XII. Tout fuit ... Le tombeau s''ouvre ...',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 19226 AND p.composer_id = 236 AND part.part_key = 'musicbrainz:cdc65aae-b4a2-4ce2-a494-0bc2de7b1c9e' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:cdc65aae-b4a2-4ce2-a494-0bc2de7b1c9e', 85, NULL, 'Acte I: XII. Tout fuit ... Le tombeau s''ouvre', 'Hypermnestre: Acte I: XII. Tout fuit ... Le tombeau s''ouvre ...', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 19226 AND p.composer_id = 236
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:cdc65aae-b4a2-4ce2-a494-0bc2de7b1c9e'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 86, part.movement_number = NULL,
    part.name_ko = 'Acte I: II. Ah! Seigneur, au pied de ce tombeau', part.name_en = 'Hypermnestre: Acte I: II. Ah! Seigneur, au pied de ce tombeau ...',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 19226 AND p.composer_id = 236 AND part.part_key = 'musicbrainz:cec7a331-b6b6-435d-b480-1a7837545259' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:cec7a331-b6b6-435d-b480-1a7837545259', 86, NULL, 'Acte I: II. Ah! Seigneur, au pied de ce tombeau', 'Hypermnestre: Acte I: II. Ah! Seigneur, au pied de ce tombeau ...', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 19226 AND p.composer_id = 236
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:cec7a331-b6b6-435d-b480-1a7837545259'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 87, part.movement_number = NULL,
    part.name_ko = 'Acte V (première version, 1716): I. Quelle horreur! quel carnage! où porter mes regards?', part.name_en = 'Hypermnestre: Acte V (première version, 1716): I. Quelle horreur! quel carnage! où porter mes regards? ...',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 19226 AND p.composer_id = 236 AND part.part_key = 'musicbrainz:d14ca39f-f32f-4cc2-9c2c-101dc20e4cca' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:d14ca39f-f32f-4cc2-9c2c-101dc20e4cca', 87, NULL, 'Acte V (première version, 1716): I. Quelle horreur! quel carnage! où porter mes regards?', 'Hypermnestre: Acte V (première version, 1716): I. Quelle horreur! quel carnage! où porter mes regards? ...', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 19226 AND p.composer_id = 236
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:d14ca39f-f32f-4cc2-9c2c-101dc20e4cca'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 88, part.movement_number = NULL,
    part.name_ko = 'Prologue: IV. Air pour les Peuples', part.name_en = 'Hypermnestre: Prologue: IV. Air pour les Peuples',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 19226 AND p.composer_id = 236 AND part.part_key = 'musicbrainz:d3592ad3-3e45-4dba-a61c-4f4d9b694910' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:d3592ad3-3e45-4dba-a61c-4f4d9b694910', 88, NULL, 'Prologue: IV. Air pour les Peuples', 'Hypermnestre: Prologue: IV. Air pour les Peuples', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 19226 AND p.composer_id = 236
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:d3592ad3-3e45-4dba-a61c-4f4d9b694910'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 89, part.movement_number = NULL,
    part.name_ko = 'Acte II: IX. Air pour les Matelots argiens (reprise)', part.name_en = 'Hypermnestre: Acte II: IX. Air pour les Matelots argiens (reprise)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 19226 AND p.composer_id = 236 AND part.part_key = 'musicbrainz:d6f67f0a-f6dc-4cd0-a3fe-1c42a90e44d4' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:d6f67f0a-f6dc-4cd0-a3fe-1c42a90e44d4', 89, NULL, 'Acte II: IX. Air pour les Matelots argiens (reprise)', 'Hypermnestre: Acte II: IX. Air pour les Matelots argiens (reprise)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 19226 AND p.composer_id = 236
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:d6f67f0a-f6dc-4cd0-a3fe-1c42a90e44d4'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 90, part.movement_number = NULL,
    part.name_ko = 'Prologue: III. Gavotte en Rondeau pour les Peuples', part.name_en = 'Hypermnestre: Prologue: III. Gavotte en Rondeau pour les Peuples',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 19226 AND p.composer_id = 236 AND part.part_key = 'musicbrainz:d75df4bb-4b18-40d0-93e3-257ef5f0c3f6' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:d75df4bb-4b18-40d0-93e3-257ef5f0c3f6', 90, NULL, 'Prologue: III. Gavotte en Rondeau pour les Peuples', 'Hypermnestre: Prologue: III. Gavotte en Rondeau pour les Peuples', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 19226 AND p.composer_id = 236
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:d75df4bb-4b18-40d0-93e3-257ef5f0c3f6'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 91, part.movement_number = NULL,
    part.name_ko = 'Acte II: VII. Air pour les Matelots argiens', part.name_en = 'Hypermnestre: Acte II: VII. Air pour les Matelots argiens',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 19226 AND p.composer_id = 236 AND part.part_key = 'musicbrainz:d7693a44-d07f-450e-b6bc-e7b3bc7c2006' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:d7693a44-d07f-450e-b6bc-e7b3bc7c2006', 91, NULL, 'Acte II: VII. Air pour les Matelots argiens', 'Hypermnestre: Acte II: VII. Air pour les Matelots argiens', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 19226 AND p.composer_id = 236
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:d7693a44-d07f-450e-b6bc-e7b3bc7c2006'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 92, part.movement_number = NULL,
    part.name_ko = 'Prologue: X. Menuet pour les Naïades', part.name_en = 'Hypermnestre: Prologue: X. Menuet pour les Naïades',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 19226 AND p.composer_id = 236 AND part.part_key = 'musicbrainz:d7a9fc9c-a223-4656-bef1-b92d233cc18c' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:d7a9fc9c-a223-4656-bef1-b92d233cc18c', 92, NULL, 'Prologue: X. Menuet pour les Naïades', 'Hypermnestre: Prologue: X. Menuet pour les Naïades', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 19226 AND p.composer_id = 236
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:d7a9fc9c-a223-4656-bef1-b92d233cc18c'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 93, part.movement_number = NULL,
    part.name_ko = 'Acte I: XI. Quelle pouvoir contre nous rassemble', part.name_en = 'Hypermnestre: Acte I: XI. Quelle pouvoir contre nous rassemble ...',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 19226 AND p.composer_id = 236 AND part.part_key = 'musicbrainz:d80b5fb1-f4e1-4aff-89e8-59d417430a0c' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:d80b5fb1-f4e1-4aff-89e8-59d417430a0c', 93, NULL, 'Acte I: XI. Quelle pouvoir contre nous rassemble', 'Hypermnestre: Acte I: XI. Quelle pouvoir contre nous rassemble ...', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 19226 AND p.composer_id = 236
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:d80b5fb1-f4e1-4aff-89e8-59d417430a0c'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 94, part.movement_number = NULL,
    part.name_ko = 'Acte V (première version, 1716): XII. Soumettons-nous à sa puissance', part.name_en = 'Hypermnestre: Acte V (première version, 1716): XII. Soumettons-nous à sa puissance ...',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 19226 AND p.composer_id = 236 AND part.part_key = 'musicbrainz:dc462a13-8172-4077-bc7a-5e10e81084eb' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:dc462a13-8172-4077-bc7a-5e10e81084eb', 94, NULL, 'Acte V (première version, 1716): XII. Soumettons-nous à sa puissance', 'Hypermnestre: Acte V (première version, 1716): XII. Soumettons-nous à sa puissance ...', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 19226 AND p.composer_id = 236
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:dc462a13-8172-4077-bc7a-5e10e81084eb'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 95, part.movement_number = NULL,
    part.name_ko = 'Prologue: XIII. Mais, quelle lumière?', part.name_en = 'Hypermnestre: Prologue: XIII. Mais, quelle lumière? ...',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 19226 AND p.composer_id = 236 AND part.part_key = 'musicbrainz:e3f94121-93da-4d5d-8a50-f94b5afb57cf' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:e3f94121-93da-4d5d-8a50-f94b5afb57cf', 95, NULL, 'Prologue: XIII. Mais, quelle lumière?', 'Hypermnestre: Prologue: XIII. Mais, quelle lumière? ...', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 19226 AND p.composer_id = 236
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:e3f94121-93da-4d5d-8a50-f94b5afb57cf'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 96, part.movement_number = NULL,
    part.name_ko = 'Acte IV: IV. Passacaille pour des Jeunes Gens', part.name_en = 'Hypermnestre: Acte IV: IV. Passacaille pour des Jeunes Gens',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 19226 AND p.composer_id = 236 AND part.part_key = 'musicbrainz:e43cc729-34de-4f29-901a-e3a440322974' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:e43cc729-34de-4f29-901a-e3a440322974', 96, NULL, 'Acte IV: IV. Passacaille pour des Jeunes Gens', 'Hypermnestre: Acte IV: IV. Passacaille pour des Jeunes Gens', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 19226 AND p.composer_id = 236
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:e43cc729-34de-4f29-901a-e3a440322974'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 97, part.movement_number = NULL,
    part.name_ko = 'Acte III: VII. Dieu d''Hymen, enchaîne nos cœurs!', part.name_en = 'Hypermnestre: Acte III: VII. Dieu d''Hymen, enchaîne nos cœurs! ...',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 19226 AND p.composer_id = 236 AND part.part_key = 'musicbrainz:ed438742-c3aa-41d5-984d-e96c53517da9' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:ed438742-c3aa-41d5-984d-e96c53517da9', 97, NULL, 'Acte III: VII. Dieu d''Hymen, enchaîne nos cœurs!', 'Hypermnestre: Acte III: VII. Dieu d''Hymen, enchaîne nos cœurs! ...', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 19226 AND p.composer_id = 236
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:ed438742-c3aa-41d5-984d-e96c53517da9'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 98, part.movement_number = NULL,
    part.name_ko = 'Acte V (première version, 1716): II. Vengeons-nous, vengeons-nous', part.name_en = 'Hypermnestre: Acte V (première version, 1716): II. Vengeons-nous, vengeons-nous ...',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 19226 AND p.composer_id = 236 AND part.part_key = 'musicbrainz:edb4fadc-34d3-420b-a534-8aab68cec2dc' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:edb4fadc-34d3-420b-a534-8aab68cec2dc', 98, NULL, 'Acte V (première version, 1716): II. Vengeons-nous, vengeons-nous', 'Hypermnestre: Acte V (première version, 1716): II. Vengeons-nous, vengeons-nous ...', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 19226 AND p.composer_id = 236
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:edb4fadc-34d3-420b-a534-8aab68cec2dc'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 99, part.movement_number = NULL,
    part.name_ko = 'Acte III: X. Première et Deuxième Gavotte pour les Peuples', part.name_en = 'Hypermnestre: Acte III: X. Première et Deuxième Gavotte pour les Peuples',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 19226 AND p.composer_id = 236 AND part.part_key = 'musicbrainz:f039b2f5-266f-41bd-a38d-62dd6307b449' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:f039b2f5-266f-41bd-a38d-62dd6307b449', 99, NULL, 'Acte III: X. Première et Deuxième Gavotte pour les Peuples', 'Hypermnestre: Acte III: X. Première et Deuxième Gavotte pour les Peuples', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 19226 AND p.composer_id = 236
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:f039b2f5-266f-41bd-a38d-62dd6307b449'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 100, part.movement_number = NULL,
    part.name_ko = 'Acte III: IV. Ô vous, Divinité suprême', part.name_en = 'Hypermnestre: Acte III: IV. Ô vous, Divinité suprême ...',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 19226 AND p.composer_id = 236 AND part.part_key = 'musicbrainz:f2d16b79-5033-4cab-a521-86790b2759cb' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:f2d16b79-5033-4cab-a521-86790b2759cb', 100, NULL, 'Acte III: IV. Ô vous, Divinité suprême', 'Hypermnestre: Acte III: IV. Ô vous, Divinité suprême ...', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 19226 AND p.composer_id = 236
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:f2d16b79-5033-4cab-a521-86790b2759cb'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 101, part.movement_number = NULL,
    part.name_ko = 'Prologue: XVII. Vous, que le bruit affreux des armes', part.name_en = 'Hypermnestre: Prologue: XVII. Vous, que le bruit affreux des armes ...',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 19226 AND p.composer_id = 236 AND part.part_key = 'musicbrainz:f2d8e28b-c461-4461-8a4b-321085c6f3cc' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:f2d8e28b-c461-4461-8a4b-321085c6f3cc', 101, NULL, 'Prologue: XVII. Vous, que le bruit affreux des armes', 'Hypermnestre: Prologue: XVII. Vous, que le bruit affreux des armes ...', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 19226 AND p.composer_id = 236
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:f2d8e28b-c461-4461-8a4b-321085c6f3cc'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 102, part.movement_number = NULL,
    part.name_ko = 'Acte I: XIV. Quel oracle fatal! Quelle horreur! Je frissonne!', part.name_en = 'Hypermnestre: Acte I: XIV. Quel oracle fatal! Quelle horreur! Je frissonne! ...',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 19226 AND p.composer_id = 236 AND part.part_key = 'musicbrainz:f39dcd69-0062-43d7-96a2-8c899a59681d' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:f39dcd69-0062-43d7-96a2-8c899a59681d', 102, NULL, 'Acte I: XIV. Quel oracle fatal! Quelle horreur! Je frissonne!', 'Hypermnestre: Acte I: XIV. Quel oracle fatal! Quelle horreur! Je frissonne! ...', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 19226 AND p.composer_id = 236
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:f39dcd69-0062-43d7-96a2-8c899a59681d'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 103, part.movement_number = NULL,
    part.name_ko = 'Acte II: XIV. Ô sort heureux! aimable jour!', part.name_en = 'Hypermnestre: Acte II: XIV. Ô sort heureux! aimable jour! ...',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 19226 AND p.composer_id = 236 AND part.part_key = 'musicbrainz:f3a75e77-1dc0-44a6-b34e-deb9cef0c38c' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:f3a75e77-1dc0-44a6-b34e-deb9cef0c38c', 103, NULL, 'Acte II: XIV. Ô sort heureux! aimable jour!', 'Hypermnestre: Acte II: XIV. Ô sort heureux! aimable jour! ...', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 19226 AND p.composer_id = 236
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:f3a75e77-1dc0-44a6-b34e-deb9cef0c38c'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 104, part.movement_number = NULL,
    part.name_ko = 'Acte III: V. Au nom de nos plus tendres feux', part.name_en = 'Hypermnestre: Acte III: V. Au nom de nos plus tendres feux ...',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 19226 AND p.composer_id = 236 AND part.part_key = 'musicbrainz:f87c695a-d29d-452a-b488-19c7b3cb2468' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:f87c695a-d29d-452a-b488-19c7b3cb2468', 104, NULL, 'Acte III: V. Au nom de nos plus tendres feux', 'Hypermnestre: Acte III: V. Au nom de nos plus tendres feux ...', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 19226 AND p.composer_id = 236
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:f87c695a-d29d-452a-b488-19c7b3cb2468'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 105, part.movement_number = NULL,
    part.name_ko = 'Acte I: X. Air de trompettes pour les Peuples argiens', part.name_en = 'Hypermnestre: Acte I: X. Air de trompettes pour les Peuples argiens',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 19226 AND p.composer_id = 236 AND part.part_key = 'musicbrainz:fc3c1db8-0824-4c53-b80c-c0d7a2f0e7f1' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:fc3c1db8-0824-4c53-b80c-c0d7a2f0e7f1', 105, NULL, 'Acte I: X. Air de trompettes pour les Peuples argiens', 'Hypermnestre: Acte I: X. Air de trompettes pour les Peuples argiens', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 19226 AND p.composer_id = 236
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:fc3c1db8-0824-4c53-b80c-c0d7a2f0e7f1'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 106, part.movement_number = NULL,
    part.name_ko = 'Acte IV: XV. Mais, quel prodige', part.name_en = 'Hypermnestre: Acte IV: XV. Mais, quel prodige ...',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 19226 AND p.composer_id = 236 AND part.part_key = 'musicbrainz:fd521085-cc52-41fe-81e6-568fcff321b0' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:fd521085-cc52-41fe-81e6-568fcff321b0', 106, NULL, 'Acte IV: XV. Mais, quel prodige', 'Hypermnestre: Acte IV: XV. Mais, quel prodige ...', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 19226 AND p.composer_id = 236
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:fd521085-cc52-41fe-81e6-568fcff321b0'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 107, part.movement_number = NULL,
    part.name_ko = 'Acte IV: XI. Ah! tout mon cœur frémit ... C''est lui ... c''est mon époux', part.name_en = 'Hypermnestre: Acte IV: XI. Ah! tout mon cœur frémit ... C''est lui ... c''est mon époux ...',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 19226 AND p.composer_id = 236 AND part.part_key = 'musicbrainz:ffe20207-a879-418c-a579-b7f7916e03d3' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:ffe20207-a879-418c-a579-b7f7916e03d3', 107, NULL, 'Acte IV: XI. Ah! tout mon cœur frémit ... C''est lui ... c''est mon époux', 'Hypermnestre: Acte IV: XI. Ah! tout mon cœur frémit ... C''est lui ... c''est mon époux ...', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 19226 AND p.composer_id = 236
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:ffe20207-a879-418c-a579-b7f7916e03d3'
);


-- None 모테트 <Jubilate Deo omnis terra>

UPDATE pieces piece
SET piece.title = '모테트 <Jubilate Deo omnis terra>', piece.title_en = 'Jubilate Deo omnis terra',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 16751 AND piece.composer_id = 236
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'Jubilate Deo', part.name_en = 'Jubilate Deo: I. Jubilate Deo',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 16751 AND p.composer_id = 236 AND part.part_key = 'musicbrainz:14768b09-042b-4711-815e-5bf421469c64' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:14768b09-042b-4711-815e-5bf421469c64', 1, 'I', 'Jubilate Deo', 'Jubilate Deo: I. Jubilate Deo', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 16751 AND p.composer_id = 236
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:14768b09-042b-4711-815e-5bf421469c64'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'III',
    part.name_ko = 'Populus ejus', part.name_en = 'Jubilate Deo: III. Populus ejus',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 16751 AND p.composer_id = 236 AND part.part_key = 'musicbrainz:73d78714-1203-4cae-b6cd-cc656b4fbad5' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:73d78714-1203-4cae-b6cd-cc656b4fbad5', 2, 'III', 'Populus ejus', 'Jubilate Deo: III. Populus ejus', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 16751 AND p.composer_id = 236
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:73d78714-1203-4cae-b6cd-cc656b4fbad5'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'IV',
    part.name_ko = 'Laudate nomen ejus', part.name_en = 'Jubilate Deo: IV. Laudate nomen ejus',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 16751 AND p.composer_id = 236 AND part.part_key = 'musicbrainz:9f200514-2593-4bdc-8fc7-4a0ec762d379' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:9f200514-2593-4bdc-8fc7-4a0ec762d379', 3, 'IV', 'Laudate nomen ejus', 'Jubilate Deo: IV. Laudate nomen ejus', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 16751 AND p.composer_id = 236
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:9f200514-2593-4bdc-8fc7-4a0ec762d379'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = 'II',
    part.name_ko = 'Scitote quoniam Dominus ipse est Deus', part.name_en = 'Jubilate Deo: II. Scitote quoniam Dominus ipse est Deus',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 16751 AND p.composer_id = 236 AND part.part_key = 'musicbrainz:9f7205cf-c8b0-42a2-bc23-bb936a5640ab' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:9f7205cf-c8b0-42a2-bc23-bb936a5640ab', 4, 'II', 'Scitote quoniam Dominus ipse est Deus', 'Jubilate Deo: II. Scitote quoniam Dominus ipse est Deus', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 16751 AND p.composer_id = 236
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:9f7205cf-c8b0-42a2-bc23-bb936a5640ab'
);


-- None 모테트 <Miserere>

UPDATE pieces piece
SET piece.title = '모테트 <Miserere>', piece.title_en = 'Miserere',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 17861 AND piece.composer_id = 236
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'VI',
    part.name_ko = 'Averte faciem tuam', part.name_en = 'Miserere: VI. Averte faciem tuam',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 17861 AND p.composer_id = 236 AND part.part_key = 'musicbrainz:23fc9d0b-f35c-4c64-b0bc-ea3610490581' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:23fc9d0b-f35c-4c64-b0bc-ea3610490581', 1, 'VI', 'Averte faciem tuam', 'Miserere: VI. Averte faciem tuam', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 17861 AND p.composer_id = 236
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:23fc9d0b-f35c-4c64-b0bc-ea3610490581'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'IX',
    part.name_ko = 'Domine labia mea', part.name_en = 'Miserere: IX. Domine labia mea',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 17861 AND p.composer_id = 236 AND part.part_key = 'musicbrainz:4e762b32-0157-4297-879a-4022a023661a' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:4e762b32-0157-4297-879a-4022a023661a', 2, 'IX', 'Domine labia mea', 'Miserere: IX. Domine labia mea', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 17861 AND p.composer_id = 236
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:4e762b32-0157-4297-879a-4022a023661a'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = 'Ecce enim in iniquitatibus conceptus sum', part.name_en = 'Miserere: III. Ecce enim in iniquitatibus conceptus sum',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 17861 AND p.composer_id = 236 AND part.part_key = 'musicbrainz:624140b0-dfe2-4d91-a8ad-dda53273517f' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:624140b0-dfe2-4d91-a8ad-dda53273517f', 3, 'III', 'Ecce enim in iniquitatibus conceptus sum', 'Miserere: III. Ecce enim in iniquitatibus conceptus sum', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 17861 AND p.composer_id = 236
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:624140b0-dfe2-4d91-a8ad-dda53273517f'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = 'VIII',
    part.name_ko = 'Libera me', part.name_en = 'Miserere: VIII. Libera me',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 17861 AND p.composer_id = 236 AND part.part_key = 'musicbrainz:6b163fbd-f8aa-4a89-ab05-44fd58f8dfe2' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:6b163fbd-f8aa-4a89-ab05-44fd58f8dfe2', 4, 'VIII', 'Libera me', 'Miserere: VIII. Libera me', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 17861 AND p.composer_id = 236
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:6b163fbd-f8aa-4a89-ab05-44fd58f8dfe2'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 5, part.movement_number = 'II',
    part.name_ko = 'Tibi soli peccavi', part.name_en = 'Miserere: II. Tibi soli peccavi',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 17861 AND p.composer_id = 236 AND part.part_key = 'musicbrainz:9205c8b8-ba3c-47b0-ac2b-0d4d60bcdad9' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:9205c8b8-ba3c-47b0-ac2b-0d4d60bcdad9', 5, 'II', 'Tibi soli peccavi', 'Miserere: II. Tibi soli peccavi', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 17861 AND p.composer_id = 236
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:9205c8b8-ba3c-47b0-ac2b-0d4d60bcdad9'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 6, part.movement_number = 'X',
    part.name_ko = 'Quoniam si voluisses sacrificium', part.name_en = 'Miserere: X. Quoniam si voluisses sacrificium',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 17861 AND p.composer_id = 236 AND part.part_key = 'musicbrainz:9ab8a435-70a5-4b1b-a3ca-4cd7b352012e' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:9ab8a435-70a5-4b1b-a3ca-4cd7b352012e', 6, 'X', 'Quoniam si voluisses sacrificium', 'Miserere: X. Quoniam si voluisses sacrificium', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 17861 AND p.composer_id = 236
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:9ab8a435-70a5-4b1b-a3ca-4cd7b352012e'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 7, part.movement_number = 'VII',
    part.name_ko = 'Docebo iniquos vias tuas', part.name_en = 'Miserere: VII. Docebo iniquos vias tuas',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 17861 AND p.composer_id = 236 AND part.part_key = 'musicbrainz:b6f7809f-9ddc-42c0-b1d5-3017232c2c29' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:b6f7809f-9ddc-42c0-b1d5-3017232c2c29', 7, 'VII', 'Docebo iniquos vias tuas', 'Miserere: VII. Docebo iniquos vias tuas', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 17861 AND p.composer_id = 236
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:b6f7809f-9ddc-42c0-b1d5-3017232c2c29'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 8, part.movement_number = 'IV',
    part.name_ko = 'Asperges me Domine', part.name_en = 'Miserere: IV. Asperges me Domine',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 17861 AND p.composer_id = 236 AND part.part_key = 'musicbrainz:bfbdbfcd-bb72-4baa-a5bc-ec1f219199f4' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:bfbdbfcd-bb72-4baa-a5bc-ec1f219199f4', 8, 'IV', 'Asperges me Domine', 'Miserere: IV. Asperges me Domine', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 17861 AND p.composer_id = 236
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:bfbdbfcd-bb72-4baa-a5bc-ec1f219199f4'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 9, part.movement_number = 'XI',
    part.name_ko = 'Sacrificium Deo spiritus contribulatus', part.name_en = 'Miserere: XI. Sacrificium Deo spiritus contribulatus',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 17861 AND p.composer_id = 236 AND part.part_key = 'musicbrainz:daa1d00d-8bb6-4651-a286-c922d6c008dc' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:daa1d00d-8bb6-4651-a286-c922d6c008dc', 9, 'XI', 'Sacrificium Deo spiritus contribulatus', 'Miserere: XI. Sacrificium Deo spiritus contribulatus', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 17861 AND p.composer_id = 236
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:daa1d00d-8bb6-4651-a286-c922d6c008dc'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 10, part.movement_number = 'XII',
    part.name_ko = 'Ut aedificentur muri Jerusalem', part.name_en = 'Miserere: XII. Ut aedificentur muri Jerusalem',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 17861 AND p.composer_id = 236 AND part.part_key = 'musicbrainz:de3fa17b-84f6-497c-aab9-26b84a0160f4' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:de3fa17b-84f6-497c-aab9-26b84a0160f4', 10, 'XII', 'Ut aedificentur muri Jerusalem', 'Miserere: XII. Ut aedificentur muri Jerusalem', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 17861 AND p.composer_id = 236
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:de3fa17b-84f6-497c-aab9-26b84a0160f4'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 11, part.movement_number = 'V',
    part.name_ko = 'Auditui meo', part.name_en = 'Miserere: V. Auditui meo',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 17861 AND p.composer_id = 236 AND part.part_key = 'musicbrainz:e13e9726-9392-4c20-931f-5a5132b3ad22' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:e13e9726-9392-4c20-931f-5a5132b3ad22', 11, 'V', 'Auditui meo', 'Miserere: V. Auditui meo', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 17861 AND p.composer_id = 236
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:e13e9726-9392-4c20-931f-5a5132b3ad22'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 12, part.movement_number = 'I',
    part.name_ko = 'Miserere', part.name_en = 'Miserere: I. Miserere',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 17861 AND p.composer_id = 236 AND part.part_key = 'musicbrainz:f02abb05-d2bc-4207-bf05-bb0f478bad89' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:f02abb05-d2bc-4207-bf05-bb0f478bad89', 12, 'I', 'Miserere', 'Miserere: I. Miserere', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 17861 AND p.composer_id = 236
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:f02abb05-d2bc-4207-bf05-bb0f478bad89'
);


-- None 오페라 <Méduse>

UPDATE pieces piece
SET piece.title = '오페라 <Méduse>', piece.title_en = 'Méduse',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 16976 AND piece.composer_id = 236
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None 모테트 <Super flumina Babilonis>

UPDATE pieces piece
SET piece.title = '모테트 <Super flumina Babilonis>', piece.title_en = 'Super flumina Babilonis',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 15841 AND piece.composer_id = 236
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'VII',
    part.name_ko = 'Exinanite usque ad fondamentum in ea', part.name_en = 'Super flumina Babilonis: VII. Exinanite usque ad fondamentum in ea',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 15841 AND p.composer_id = 236 AND part.part_key = 'musicbrainz:2acf0b10-eb2c-4b54-aa95-b6e5ab7a00d2' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:2acf0b10-eb2c-4b54-aa95-b6e5ab7a00d2', 1, 'VII', 'Exinanite usque ad fondamentum in ea', 'Super flumina Babilonis: VII. Exinanite usque ad fondamentum in ea', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 15841 AND p.composer_id = 236
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:2acf0b10-eb2c-4b54-aa95-b6e5ab7a00d2'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'VI',
    part.name_ko = 'Memor esto Domine', part.name_en = 'Super flumina Babilonis: VI. Memor esto Domine',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 15841 AND p.composer_id = 236 AND part.part_key = 'musicbrainz:4ee14171-c79e-4947-ab1a-7c612069b852' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:4ee14171-c79e-4947-ab1a-7c612069b852', 2, 'VI', 'Memor esto Domine', 'Super flumina Babilonis: VI. Memor esto Domine', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 15841 AND p.composer_id = 236
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:4ee14171-c79e-4947-ab1a-7c612069b852'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'VIII',
    part.name_ko = 'Filia Babilonis misera', part.name_en = 'Super flumina Babilonis: VIII. Filia Babilonis misera',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 15841 AND p.composer_id = 236 AND part.part_key = 'musicbrainz:901c3f77-b650-4f02-a4a3-4707e2018737' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:901c3f77-b650-4f02-a4a3-4707e2018737', 3, 'VIII', 'Filia Babilonis misera', 'Super flumina Babilonis: VIII. Filia Babilonis misera', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 15841 AND p.composer_id = 236
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:901c3f77-b650-4f02-a4a3-4707e2018737'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = 'II',
    part.name_ko = 'In salicibus in medio ejus', part.name_en = 'Super flumina Babilonis: II. In salicibus in medio ejus',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 15841 AND p.composer_id = 236 AND part.part_key = 'musicbrainz:9440e57c-be8a-4134-83b1-804cec90e632' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:9440e57c-be8a-4134-83b1-804cec90e632', 4, 'II', 'In salicibus in medio ejus', 'Super flumina Babilonis: II. In salicibus in medio ejus', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 15841 AND p.composer_id = 236
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:9440e57c-be8a-4134-83b1-804cec90e632'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 5, part.movement_number = 'IV',
    part.name_ko = 'Et qui abduxerunt nos', part.name_en = 'Super flumina Babilonis: IV. Et qui abduxerunt nos',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 15841 AND p.composer_id = 236 AND part.part_key = 'musicbrainz:94f1ae62-e9fc-4424-886d-ea7b305b0054' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:94f1ae62-e9fc-4424-886d-ea7b305b0054', 5, 'IV', 'Et qui abduxerunt nos', 'Super flumina Babilonis: IV. Et qui abduxerunt nos', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 15841 AND p.composer_id = 236
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:94f1ae62-e9fc-4424-886d-ea7b305b0054'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 6, part.movement_number = 'V',
    part.name_ko = 'Si oblitus fuero tui Jerusalem', part.name_en = 'Super flumina Babilonis: V. Si oblitus fuero tui Jerusalem',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 15841 AND p.composer_id = 236 AND part.part_key = 'musicbrainz:af260196-9005-4140-9043-83af6794b985' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:af260196-9005-4140-9043-83af6794b985', 6, 'V', 'Si oblitus fuero tui Jerusalem', 'Super flumina Babilonis: V. Si oblitus fuero tui Jerusalem', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 15841 AND p.composer_id = 236
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:af260196-9005-4140-9043-83af6794b985'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 7, part.movement_number = 'III',
    part.name_ko = 'Quia illic interrogaverunt nos', part.name_en = 'Super flumina Babilonis: III. Quia illic interrogaverunt nos',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 15841 AND p.composer_id = 236 AND part.part_key = 'musicbrainz:cea7c3b9-c99c-49a8-8d1c-eb517e426caa' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:cea7c3b9-c99c-49a8-8d1c-eb517e426caa', 7, 'III', 'Quia illic interrogaverunt nos', 'Super flumina Babilonis: III. Quia illic interrogaverunt nos', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 15841 AND p.composer_id = 236
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:cea7c3b9-c99c-49a8-8d1c-eb517e426caa'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 8, part.movement_number = 'I',
    part.name_ko = 'Super flumina Babilonis', part.name_en = 'Super flumina Babilonis: I. Super flumina Babilonis',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 15841 AND p.composer_id = 236 AND part.part_key = 'musicbrainz:f03e7d87-693f-4e85-85c1-d3111833cf72' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:f03e7d87-693f-4e85-85c1-d3111833cf72', 8, 'I', 'Super flumina Babilonis', 'Super flumina Babilonis: I. Super flumina Babilonis', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 15841 AND p.composer_id = 236
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:f03e7d87-693f-4e85-85c1-d3111833cf72'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 9, part.movement_number = 'IX',
    part.name_ko = 'Beatus qui tenebit et allidet', part.name_en = 'Super flumina Babilonis: IX. Beatus qui tenebit et allidet',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 15841 AND p.composer_id = 236 AND part.part_key = 'musicbrainz:f60edafb-a19e-4459-8b8f-a1b847ea302b' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:f60edafb-a19e-4459-8b8f-a1b847ea302b', 9, 'IX', 'Beatus qui tenebit et allidet', 'Super flumina Babilonis: IX. Beatus qui tenebit et allidet', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 15841 AND p.composer_id = 236
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:f60edafb-a19e-4459-8b8f-a1b847ea302b'
);

-- 숨길 seed 작품 없음

-- ===== Leon Stein (composer_id 237) =====
-- 작품을 MusicBrainz 작품 구조로 다시 짠다(6차 자동). 작품 3개(묶음 1, 다악장 1, 낱곡 1),
-- 새 작품 0개, part 6개, 그 아래 0개.
-- seed 3개 중 3개를 작품·part 에 잇고, 0개를 숨기고, 0개는 그대로 둔다.

-- None Introduction and Rondo for Flute and Percussion

UPDATE pieces piece
SET piece.title = 'Introduction and Rondo for Flute and Percussion', piece.title_en = 'Introduction and Rondo for Flute and Percussion',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 20054 AND piece.composer_id = 237
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Three Hassidic Dances

UPDATE pieces piece
SET piece.title = 'Three Hassidic Dances', piece.title_en = 'Three Hassidic Dances',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 20064 AND piece.composer_id = 237
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'Dance of the Joyous. Allegro', part.name_en = 'Three Hassidic Dances: No. 1. Dance of the Joyous. Allegro',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 20064 AND p.composer_id = 237 AND part.part_key = 'musicbrainz:04f90a99-d69a-425e-ad15-bfd054ca2566' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:04f90a99-d69a-425e-ad15-bfd054ca2566', 1, NULL, 'Dance of the Joyous. Allegro', 'Three Hassidic Dances: No. 1. Dance of the Joyous. Allegro', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 20064 AND p.composer_id = 237
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:04f90a99-d69a-425e-ad15-bfd054ca2566'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'Dance of the Enraptured. Adagio - Andantino', part.name_en = 'Three Hassidic Dances: No. 2. Dance of the Enraptured. Adagio - Andantino',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 20064 AND p.composer_id = 237 AND part.part_key = 'musicbrainz:97540a51-9007-47af-894d-67ec3ddcfe9a' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:97540a51-9007-47af-894d-67ec3ddcfe9a', 2, NULL, 'Dance of the Enraptured. Adagio - Andantino', 'Three Hassidic Dances: No. 2. Dance of the Enraptured. Adagio - Andantino', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 20064 AND p.composer_id = 237
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:97540a51-9007-47af-894d-67ec3ddcfe9a'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = NULL,
    part.name_ko = 'Dance of the Exultant. Moderato - Allegro', part.name_en = 'Three Hassidic Dances: No. 3. Dance of the Exultant. Moderato - Allegro',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 20064 AND p.composer_id = 237 AND part.part_key = 'musicbrainz:b8b2a910-508e-43d8-a630-2c0791cd51cc' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:b8b2a910-508e-43d8-a630-2c0791cd51cc', 3, NULL, 'Dance of the Exultant. Moderato - Allegro', 'Three Hassidic Dances: No. 3. Dance of the Exultant. Moderato - Allegro', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 20064 AND p.composer_id = 237
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:b8b2a910-508e-43d8-a630-2c0791cd51cc'
);


-- None Trio Concertante for Alto Saxophone, Violin and Piano

UPDATE pieces piece
SET piece.title = 'Trio Concertante for Alto Saxophone, Violin and Piano', piece.title_en = 'Trio Concertante for Alto Saxophone, Violin and Piano',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 18977 AND piece.composer_id = 237
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'Spiritoso. Allegro con brio', part.name_en = 'Trio Concertante for Alto Saxophone, Violin and Piano: I. Spiritoso. Allegro con brio',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 18977 AND p.composer_id = 237 AND part.part_key = 'musicbrainz:ab3bc665-adca-485a-8396-21d95ca17ce7' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:ab3bc665-adca-485a-8396-21d95ca17ce7', 1, 'I', 'Spiritoso. Allegro con brio', 'Trio Concertante for Alto Saxophone, Violin and Piano: I. Spiritoso. Allegro con brio', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 18977 AND p.composer_id = 237
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:ab3bc665-adca-485a-8396-21d95ca17ce7'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'Siciliano: Andante moderato', part.name_en = 'Trio Concertante for Alto Saxophone, Violin and Piano: II. Siciliano: Andante moderato',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 18977 AND p.composer_id = 237 AND part.part_key = 'musicbrainz:f069d450-3b65-4f4e-9586-bf2fef91e88f' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:f069d450-3b65-4f4e-9586-bf2fef91e88f', 2, 'II', 'Siciliano: Andante moderato', 'Trio Concertante for Alto Saxophone, Violin and Piano: II. Siciliano: Andante moderato', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 18977 AND p.composer_id = 237
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:f069d450-3b65-4f4e-9586-bf2fef91e88f'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = 'Scherzoso. Allegro vivace', part.name_en = 'Trio Concertante for Alto Saxophone, Violin and Piano: III. Scherzoso. Allegro vivace',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 18977 AND p.composer_id = 237 AND part.part_key = 'musicbrainz:5d458e13-63aa-4661-a607-bd94cd117ee6' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:5d458e13-63aa-4661-a607-bd94cd117ee6', 3, 'III', 'Scherzoso. Allegro vivace', 'Trio Concertante for Alto Saxophone, Violin and Piano: III. Scherzoso. Allegro vivace', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 18977 AND p.composer_id = 237
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:5d458e13-63aa-4661-a607-bd94cd117ee6'
);

-- 숨길 seed 작품 없음

-- ===== Gustave Charpentier (composer_id 238) =====
-- 작품을 MusicBrainz 작품 구조로 다시 짠다(6차 자동). 작품 3개(묶음 2, 다악장 0, 낱곡 1),
-- 새 작품 0개, part 5개, 그 아래 17개.
-- seed 3개 중 3개를 작품·part 에 잇고, 0개를 숨기고, 0개는 그대로 둔다.

-- None Impressions d'Italie

UPDATE pieces piece
SET piece.title = 'Impressions d''Italie', piece.title_en = 'Impressions d''Italie',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 16414 AND piece.composer_id = 238
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None La vie du poete

UPDATE pieces piece
SET piece.title = 'La vie du poete', piece.title_en = 'La vie du poete',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 17930 AND piece.composer_id = 238
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'Act I:"Enthusiasm": Douce Lumiere', part.name_en = 'La vie du poete, Act I:"Enthusiasm": Douce Lumiere',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 17930 AND p.composer_id = 238 AND part.part_key = 'musicbrainz:a7700e48-5c86-42ce-abf5-bbc32c6fa03c' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:a7700e48-5c86-42ce-abf5-bbc32c6fa03c', 1, NULL, 'Act I:"Enthusiasm": Douce Lumiere', 'La vie du poete, Act I:"Enthusiasm": Douce Lumiere', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 17930 AND p.composer_id = 238
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:a7700e48-5c86-42ce-abf5-bbc32c6fa03c'
);


-- None 오페라 <Louise>

UPDATE pieces piece
SET piece.title = '오페라 <Louise>', piece.title_en = 'Louise',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 19318 AND piece.composer_id = 238
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'Acte I', part.name_en = 'Louise: Acte I',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 19318 AND p.composer_id = 238 AND part.part_key = 'musicbrainz:bf02c339-5fa8-44bc-bc1b-3025dce463f7' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:bf02c339-5fa8-44bc-bc1b-3025dce463f7', 1, NULL, 'Acte I', 'Louise: Acte I', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 19318 AND p.composer_id = 238
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:bf02c339-5fa8-44bc-bc1b-3025dce463f7'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:bf02c339-5fa8-44bc-bc1b-3025dce463f7'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'Scène I', part.name_en = 'Louise: Acte I, Scène I.',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 19318 AND p.composer_id = 238 AND part.part_key = 'musicbrainz:1c6fbda0-efc7-4273-b4ce-00a8c54c1227' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:1c6fbda0-efc7-4273-b4ce-00a8c54c1227', 1, NULL, 'Scène I', 'Louise: Acte I, Scène I.', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:bf02c339-5fa8-44bc-bc1b-3025dce463f7'
WHERE p.id = 19318 AND p.composer_id = 238
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:1c6fbda0-efc7-4273-b4ce-00a8c54c1227'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:bf02c339-5fa8-44bc-bc1b-3025dce463f7'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'Acte I. Prelude', part.name_en = 'Louise: Acte I. Prelude',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 19318 AND p.composer_id = 238 AND part.part_key = 'musicbrainz:2eb1c876-6400-4a0f-96ea-e9f3e1fe9ca9' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:2eb1c876-6400-4a0f-96ea-e9f3e1fe9ca9', 2, NULL, 'Acte I. Prelude', 'Louise: Acte I. Prelude', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:bf02c339-5fa8-44bc-bc1b-3025dce463f7'
WHERE p.id = 19318 AND p.composer_id = 238
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:2eb1c876-6400-4a0f-96ea-e9f3e1fe9ca9'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:bf02c339-5fa8-44bc-bc1b-3025dce463f7'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = NULL,
    part.name_ko = 'Scène II', part.name_en = 'Louise: Acte I, Scène II.',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 19318 AND p.composer_id = 238 AND part.part_key = 'musicbrainz:56b4093e-7ec4-4908-9bd4-be6043db3a0d' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:56b4093e-7ec4-4908-9bd4-be6043db3a0d', 3, NULL, 'Scène II', 'Louise: Acte I, Scène II.', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:bf02c339-5fa8-44bc-bc1b-3025dce463f7'
WHERE p.id = 19318 AND p.composer_id = 238
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:56b4093e-7ec4-4908-9bd4-be6043db3a0d'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:bf02c339-5fa8-44bc-bc1b-3025dce463f7'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = NULL,
    part.name_ko = 'Scène III. “C’était mon adorée !” (La Mère, Louise)', part.name_en = 'Louise: Acte I, Scène III. “C’était mon adorée !” (La Mère, Louise)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 19318 AND p.composer_id = 238 AND part.part_key = 'musicbrainz:94773708-39ff-4c52-a579-7d1786b69ea4' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:94773708-39ff-4c52-a579-7d1786b69ea4', 4, NULL, 'Scène III. “C’était mon adorée !” (La Mère, Louise)', 'Louise: Acte I, Scène III. “C’était mon adorée !” (La Mère, Louise)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:bf02c339-5fa8-44bc-bc1b-3025dce463f7'
WHERE p.id = 19318 AND p.composer_id = 238
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:94773708-39ff-4c52-a579-7d1786b69ea4'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:bf02c339-5fa8-44bc-bc1b-3025dce463f7'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 5, part.movement_number = NULL,
    part.name_ko = 'Scène IV', part.name_en = 'Louise: Acte I, Scène IV.',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 19318 AND p.composer_id = 238 AND part.part_key = 'musicbrainz:da870af8-97c0-4bca-ab1f-ff7f6c72c2b7' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:da870af8-97c0-4bca-ab1f-ff7f6c72c2b7', 5, NULL, 'Scène IV', 'Louise: Acte I, Scène IV.', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:bf02c339-5fa8-44bc-bc1b-3025dce463f7'
WHERE p.id = 19318 AND p.composer_id = 238
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:da870af8-97c0-4bca-ab1f-ff7f6c72c2b7'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'Acte II', part.name_en = 'Louise: Acte II',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 19318 AND p.composer_id = 238 AND part.part_key = 'musicbrainz:6ab7f406-ab87-401c-8f73-44c2c9d64f12' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:6ab7f406-ab87-401c-8f73-44c2c9d64f12', 2, NULL, 'Acte II', 'Louise: Acte II', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 19318 AND p.composer_id = 238
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:6ab7f406-ab87-401c-8f73-44c2c9d64f12'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:6ab7f406-ab87-401c-8f73-44c2c9d64f12'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'Acte II. Prelude', part.name_en = 'Louise: Acte II. Prelude',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 19318 AND p.composer_id = 238 AND part.part_key = 'musicbrainz:78f37c61-04d0-4dd7-a509-c4c7a68d13bb' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:78f37c61-04d0-4dd7-a509-c4c7a68d13bb', 1, NULL, 'Acte II. Prelude', 'Louise: Acte II. Prelude', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:6ab7f406-ab87-401c-8f73-44c2c9d64f12'
WHERE p.id = 19318 AND p.composer_id = 238
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:78f37c61-04d0-4dd7-a509-c4c7a68d13bb'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:6ab7f406-ab87-401c-8f73-44c2c9d64f12'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'Tableau I', part.name_en = 'Louise: Acte II, Tableau I.',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 19318 AND p.composer_id = 238 AND part.part_key = 'musicbrainz:9328484c-adbc-40e8-9e91-01d08557a9e9' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:9328484c-adbc-40e8-9e91-01d08557a9e9', 2, NULL, 'Tableau I', 'Louise: Acte II, Tableau I.', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:6ab7f406-ab87-401c-8f73-44c2c9d64f12'
WHERE p.id = 19318 AND p.composer_id = 238
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:9328484c-adbc-40e8-9e91-01d08557a9e9'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:6ab7f406-ab87-401c-8f73-44c2c9d64f12'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = NULL,
    part.name_ko = 'Tableau II', part.name_en = 'Louise: Acte II, Tableau II.',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 19318 AND p.composer_id = 238 AND part.part_key = 'musicbrainz:aa5c5f0d-42d5-4839-86b6-31601a91d353' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:aa5c5f0d-42d5-4839-86b6-31601a91d353', 3, NULL, 'Tableau II', 'Louise: Acte II, Tableau II.', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:6ab7f406-ab87-401c-8f73-44c2c9d64f12'
WHERE p.id = 19318 AND p.composer_id = 238
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:aa5c5f0d-42d5-4839-86b6-31601a91d353'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = NULL,
    part.name_ko = 'Acte III', part.name_en = 'Louise: Acte III',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 19318 AND p.composer_id = 238 AND part.part_key = 'musicbrainz:14df0a5c-9090-4034-84ec-ef221d4d794f' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:14df0a5c-9090-4034-84ec-ef221d4d794f', 3, NULL, 'Acte III', 'Louise: Acte III', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 19318 AND p.composer_id = 238
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:14df0a5c-9090-4034-84ec-ef221d4d794f'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:14df0a5c-9090-4034-84ec-ef221d4d794f'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'Acte III. Prelude (“Vers la cité lointaine”)', part.name_en = 'Louise: Acte III. Prelude (“Vers la cité lointaine”)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 19318 AND p.composer_id = 238 AND part.part_key = 'musicbrainz:7c1e4ecb-b2e6-4225-baf0-cc3a18e55921' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:7c1e4ecb-b2e6-4225-baf0-cc3a18e55921', 1, NULL, 'Acte III. Prelude (“Vers la cité lointaine”)', 'Louise: Acte III. Prelude (“Vers la cité lointaine”)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:14df0a5c-9090-4034-84ec-ef221d4d794f'
WHERE p.id = 19318 AND p.composer_id = 238
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:7c1e4ecb-b2e6-4225-baf0-cc3a18e55921'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:14df0a5c-9090-4034-84ec-ef221d4d794f'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'Scène I', part.name_en = 'Louise: Acte III, Scène I.',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 19318 AND p.composer_id = 238 AND part.part_key = 'musicbrainz:a4402560-1523-486c-b4d3-fddc7758441e' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:a4402560-1523-486c-b4d3-fddc7758441e', 2, NULL, 'Scène I', 'Louise: Acte III, Scène I.', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:14df0a5c-9090-4034-84ec-ef221d4d794f'
WHERE p.id = 19318 AND p.composer_id = 238
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:a4402560-1523-486c-b4d3-fddc7758441e'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:14df0a5c-9090-4034-84ec-ef221d4d794f'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = NULL,
    part.name_ko = 'Scène II. “Regalez-vous, mesdames, voilà le plaisir” (Chœur)', part.name_en = 'Louise: Acte III, Scène II. “Regalez-vous, mesdames, voilà le plaisir” (Chœur)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 19318 AND p.composer_id = 238 AND part.part_key = 'musicbrainz:4729cbab-f95b-483a-9af4-3a8e53242915' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:4729cbab-f95b-483a-9af4-3a8e53242915', 3, NULL, 'Scène II. “Regalez-vous, mesdames, voilà le plaisir” (Chœur)', 'Louise: Acte III, Scène II. “Regalez-vous, mesdames, voilà le plaisir” (Chœur)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:14df0a5c-9090-4034-84ec-ef221d4d794f'
WHERE p.id = 19318 AND p.composer_id = 238
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:4729cbab-f95b-483a-9af4-3a8e53242915'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:14df0a5c-9090-4034-84ec-ef221d4d794f'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = NULL,
    part.name_ko = 'Scène IV. “Je ne viens pas en ennemie” (La Mère)', part.name_en = 'Louise: Acte III, Scène IV. “Je ne viens pas en ennemie” (La Mère)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 19318 AND p.composer_id = 238 AND part.part_key = 'musicbrainz:5abf28ed-e87a-431a-a740-6872fc609b9f' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:5abf28ed-e87a-431a-a740-6872fc609b9f', 4, NULL, 'Scène IV. “Je ne viens pas en ennemie” (La Mère)', 'Louise: Acte III, Scène IV. “Je ne viens pas en ennemie” (La Mère)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:14df0a5c-9090-4034-84ec-ef221d4d794f'
WHERE p.id = 19318 AND p.composer_id = 238
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:5abf28ed-e87a-431a-a740-6872fc609b9f'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:14df0a5c-9090-4034-84ec-ef221d4d794f'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 5, part.movement_number = NULL,
    part.name_ko = 'Scène III. “Par mercure aux pieds légers”…“Oh ! Jolie ! Cette danseuse” (Le Pape des Fous)', part.name_en = 'Louise: Acte III, Scène III. “Par mercure aux pieds légers”…“Oh ! Jolie ! Cette danseuse” (Le Pape des Fous)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 19318 AND p.composer_id = 238 AND part.part_key = 'musicbrainz:cbc2325f-d04e-49d4-b368-ad02f2952d5b' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:cbc2325f-d04e-49d4-b368-ad02f2952d5b', 5, NULL, 'Scène III. “Par mercure aux pieds légers”…“Oh ! Jolie ! Cette danseuse” (Le Pape des Fous)', 'Louise: Acte III, Scène III. “Par mercure aux pieds légers”…“Oh ! Jolie ! Cette danseuse” (Le Pape des Fous)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:14df0a5c-9090-4034-84ec-ef221d4d794f'
WHERE p.id = 19318 AND p.composer_id = 238
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:cbc2325f-d04e-49d4-b368-ad02f2952d5b'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = NULL,
    part.name_ko = 'Acte IV', part.name_en = 'Louise: Acte IV',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 19318 AND p.composer_id = 238 AND part.part_key = 'musicbrainz:76a7bcce-2e5a-4855-8a25-a4f64c804219' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:76a7bcce-2e5a-4855-8a25-a4f64c804219', 4, NULL, 'Acte IV', 'Louise: Acte IV', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 19318 AND p.composer_id = 238
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:76a7bcce-2e5a-4855-8a25-a4f64c804219'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:76a7bcce-2e5a-4855-8a25-a4f64c804219'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'Acte IV. Prelude', part.name_en = 'Louise: Acte IV. Prelude',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 19318 AND p.composer_id = 238 AND part.part_key = 'musicbrainz:7d1ab13b-c4ea-4b55-9ec5-6398b5b6734c' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:7d1ab13b-c4ea-4b55-9ec5-6398b5b6734c', 1, NULL, 'Acte IV. Prelude', 'Louise: Acte IV. Prelude', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:76a7bcce-2e5a-4855-8a25-a4f64c804219'
WHERE p.id = 19318 AND p.composer_id = 238
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:7d1ab13b-c4ea-4b55-9ec5-6398b5b6734c'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:76a7bcce-2e5a-4855-8a25-a4f64c804219'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'Scène I', part.name_en = 'Louise: Acte IV, Scène I.',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 19318 AND p.composer_id = 238 AND part.part_key = 'musicbrainz:615375b9-a908-436d-82e1-3431774c8718' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:615375b9-a908-436d-82e1-3431774c8718', 2, NULL, 'Scène I', 'Louise: Acte IV, Scène I.', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:76a7bcce-2e5a-4855-8a25-a4f64c804219'
WHERE p.id = 19318 AND p.composer_id = 238
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:615375b9-a908-436d-82e1-3431774c8718'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:76a7bcce-2e5a-4855-8a25-a4f64c804219'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = NULL,
    part.name_ko = 'Scène II', part.name_en = 'Louise: Acte IV, Scène II.',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 19318 AND p.composer_id = 238 AND part.part_key = 'musicbrainz:0227b887-539e-4dd2-88c2-d056d97c4b7e' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:0227b887-539e-4dd2-88c2-d056d97c4b7e', 3, NULL, 'Scène II', 'Louise: Acte IV, Scène II.', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:76a7bcce-2e5a-4855-8a25-a4f64c804219'
WHERE p.id = 19318 AND p.composer_id = 238
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:0227b887-539e-4dd2-88c2-d056d97c4b7e'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:76a7bcce-2e5a-4855-8a25-a4f64c804219'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = NULL,
    part.name_ko = 'Scène III. “Louise ! … Louise ! - O Paris !” (Le Père)', part.name_en = 'Louise: Acte IV, Scène III. “Louise ! … Louise ! - O Paris !” (Le Père)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 19318 AND p.composer_id = 238 AND part.part_key = 'musicbrainz:1eba9e51-a197-4062-a1b3-52a9496a3f1e' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:1eba9e51-a197-4062-a1b3-52a9496a3f1e', 4, NULL, 'Scène III. “Louise ! … Louise ! - O Paris !” (Le Père)', 'Louise: Acte IV, Scène III. “Louise ! … Louise ! - O Paris !” (Le Père)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:76a7bcce-2e5a-4855-8a25-a4f64c804219'
WHERE p.id = 19318 AND p.composer_id = 238
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:1eba9e51-a197-4062-a1b3-52a9496a3f1e'
);

-- 숨길 seed 작품 없음

-- ===== Klimenty Korchmaryov (composer_id 240) =====
-- 작품을 MusicBrainz 작품 구조로 다시 짠다(6차 자동). 작품 1개(묶음 0, 다악장 0, 낱곡 1),
-- 새 작품 0개, part 0개, 그 아래 0개.
-- seed 1개 중 1개를 작품·part 에 잇고, 0개를 숨기고, 0개는 그대로 둔다.

-- None American

UPDATE pieces piece
SET piece.title = 'American', piece.title_en = 'American',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 19281 AND piece.composer_id = 240
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

-- 숨길 seed 작품 없음

-- ===== Richard Meale (composer_id 242) =====
-- 작품을 MusicBrainz 작품 구조로 다시 짠다(6차 자동). 작품 10개(묶음 0, 다악장 2, 낱곡 8),
-- 새 작품 1개, part 10개, 그 아래 0개.
-- seed 12개 중 9개를 작품·part 에 잇고, 3개를 숨기고, 0개는 그대로 둔다.

-- None Clouds Now and Then

UPDATE pieces piece
SET piece.title = 'Clouds Now and Then', piece.title_en = 'Clouds Now and Then',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 18540 AND piece.composer_id = 242
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Coruscations

UPDATE pieces piece
SET piece.title = 'Coruscations', piece.title_en = 'Coruscations',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 17403 AND piece.composer_id = 242
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Homage to Garcia Lorca

UPDATE pieces piece
SET piece.title = 'Homage to Garcia Lorca', piece.title_en = 'Homage to Garcia Lorca',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 19247 AND piece.composer_id = 242
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Incredible floridas

UPDATE pieces piece
SET piece.title = 'Incredible floridas', piece.title_en = 'Incredible floridas',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 16267 AND piece.composer_id = 242
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'voyelles', part.name_en = 'Incredible floridas: I. voyelles',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 16267 AND p.composer_id = 242 AND part.part_key = 'musicbrainz:da673a52-fae4-497f-a2fd-a6d9af6af3e7' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:da673a52-fae4-497f-a2fd-a6d9af6af3e7', 1, 'I', 'voyelles', 'Incredible floridas: I. voyelles', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 16267 AND p.composer_id = 242
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:da673a52-fae4-497f-a2fd-a6d9af6af3e7'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'fetes de la faim', part.name_en = 'Incredible floridas: II. fetes de la faim',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 16267 AND p.composer_id = 242 AND part.part_key = 'musicbrainz:75ed5138-2370-4cf4-9c7a-6b20ce0be750' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:75ed5138-2370-4cf4-9c7a-6b20ce0be750', 2, 'II', 'fetes de la faim', 'Incredible floridas: II. fetes de la faim', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 16267 AND p.composer_id = 242
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:75ed5138-2370-4cf4-9c7a-6b20ce0be750'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = 'Le Bateau Ivre', part.name_en = 'Incredible floridas: III. Le Bateau Ivre',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 16267 AND p.composer_id = 242 AND part.part_key = 'musicbrainz:83332f5a-11b1-4401-8379-4f10382bf824' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:83332f5a-11b1-4401-8379-4f10382bf824', 3, 'III', 'Le Bateau Ivre', 'Incredible floridas: III. Le Bateau Ivre', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 16267 AND p.composer_id = 242
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:83332f5a-11b1-4401-8379-4f10382bf824'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = 'IV',
    part.name_ko = 'phrases – veillées – génie', part.name_en = 'Incredible floridas: IV. phrases – veillées – génie',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 16267 AND p.composer_id = 242 AND part.part_key = 'musicbrainz:dc3e3907-ad42-4fa7-b519-4453242d9c33' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:dc3e3907-ad42-4fa7-b519-4453242d9c33', 4, 'IV', 'phrases – veillées – génie', 'Incredible floridas: IV. phrases – veillées – génie', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 16267 AND p.composer_id = 242
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:dc3e3907-ad42-4fa7-b519-4453242d9c33'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 5, part.movement_number = 'V',
    part.name_ko = 'une saison en enfer', part.name_en = 'Incredible floridas: V. une saison en enfer',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 16267 AND p.composer_id = 242 AND part.part_key = 'musicbrainz:62dc9969-82ca-4dbe-8925-763c1810f09f' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:62dc9969-82ca-4dbe-8925-763c1810f09f', 5, 'V', 'une saison en enfer', 'Incredible floridas: V. une saison en enfer', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 16267 AND p.composer_id = 242
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:62dc9969-82ca-4dbe-8925-763c1810f09f'
);


-- None Lumen

UPDATE pieces piece
SET piece.title = 'Lumen', piece.title_en = 'Lumen',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 17245 AND piece.composer_id = 242
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None 오페라 <Mer de glace>

UPDATE pieces piece
SET piece.title = '오페라 <Mer de glace>', piece.title_en = 'Mer de glace',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 19872 AND piece.composer_id = 242
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None 변주곡

UPDATE pieces piece
SET piece.title = '변주곡', piece.title_en = 'Variations',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 16183 AND piece.composer_id = 242
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Very High Kings

UPDATE pieces piece
SET piece.title = 'Very High Kings', piece.title_en = 'Very High Kings',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 17802 AND piece.composer_id = 242
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None 오페라 <Voss>

UPDATE pieces piece
SET piece.title = '오페라 <Voss>', piece.title_en = 'Voss',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 16962 AND piece.composer_id = 242
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None 현악 4중주 2번

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '현악 4중주 2번', 'String Quartet no. 2', 'album', NULL, NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 242
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '현악 4중주 2번'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'aa27d2de-90be-45d8-96cc-b5244a5ddb14'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'aa27d2de-90be-45d8-96cc-b5244a5ddb14'
FROM pieces p
WHERE p.composer_id = 242 AND p.title = '현악 4중주 2번' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'aa27d2de-90be-45d8-96cc-b5244a5ddb14'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:dceeb33d-f1fe-479c-8f8f-2ef60ae4bf73', 1, 'I', 'Tempo comodo', 'String Quartet no. 2: I. Tempo comodo', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 242 AND p.title = '현악 4중주 2번' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:dceeb33d-f1fe-479c-8f8f-2ef60ae4bf73'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:63a12cc3-1d1f-4379-9175-2150d1597017', 2, 'II', 'Scherzo quasi una tocatta', 'String Quartet no. 2: II. Scherzo quasi una tocatta', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 242 AND p.title = '현악 4중주 2번' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:63a12cc3-1d1f-4379-9175-2150d1597017'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:8725d988-171d-4193-9e84-27286f5cccf5', 3, 'III', 'Cantilena triste', 'String Quartet no. 2: III. Cantilena triste', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 242 AND p.title = '현악 4중주 2번' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:8725d988-171d-4193-9e84-27286f5cccf5'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:bc6e066b-ae88-4343-896d-d37f101edb40', 4, 'IV', 'Ruvido', 'String Quartet no. 2: IV. Ruvido', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 242 AND p.title = '현악 4중주 2번' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:bc6e066b-ae88-4343-896d-d37f101edb40'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:ccae851f-4ec4-4bbc-b329-74908883eb02', 5, 'V', 'Cantilena pacifica', 'String Quartet no. 2: V. Cantilena pacifica', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 242 AND p.title = '현악 4중주 2번' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:ccae851f-4ec4-4bbc-b329-74908883eb02'
);

-- 카탈로그에 대응이 없는 seed 작품 3개를 목록에서 숨긴다(지우지 않음).
UPDATE pieces piece
SET piece.hidden_reason = 'catalog_unmatched'
WHERE piece.composer_id = 242 AND piece.origin = 'seed' AND piece.hidden_reason IS NULL
  AND piece.id IN (
    17077, 17416, 18194
  )
  AND NOT EXISTS (SELECT 1 FROM performance_sectors sector WHERE sector.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM piece_parts linking WHERE linking.linked_piece_id = piece.id);
