-- 아당 작품을 MusicBrainz 작품 구조로 다시 짠다(5차 자동). 작품 19개(묶음 13, 다악장 0, 낱곡 6),
-- 새 작품 0개, part 34개, 그 아래 148개.
-- seed 28개 중 19개를 작품·part 에 잇고, 9개를 숨기고, 0개는 그대로 둔다.
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

-- None 가곡 <Comrades in Arms>

UPDATE pieces piece
SET piece.title = '가곡 <Comrades in Arms>', piece.title_en = 'Comrades in Arms',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 7934 AND piece.composer_id = 55
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None 가곡 <Comrades’ Song of Hope>

UPDATE pieces piece
SET piece.title = '가곡 <Comrades’ Song of Hope>', piece.title_en = 'Comrades’ Song of Hope',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 9883 AND piece.composer_id = 55
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None 오페라 <Danilowa>

UPDATE pieces piece
SET piece.title = '오페라 <Danilowa>', piece.title_en = 'Danilowa',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 9070 AND piece.composer_id = 55
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'Overture', part.name_en = 'Danilowa: Overture',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 9070 AND p.composer_id = 55 AND part.part_key = 'musicbrainz:299c2d59-6519-43c9-a66e-5d043e8b0af7' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:299c2d59-6519-43c9-a66e-5d043e8b0af7', 1, NULL, 'Overture', 'Danilowa: Overture', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 9070 AND p.composer_id = 55
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:299c2d59-6519-43c9-a66e-5d043e8b0af7'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'Acte I', part.name_en = 'Danilowa: Acte I',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 9070 AND p.composer_id = 55 AND part.part_key = 'musicbrainz:03a685a4-8226-4076-b8a6-8b2ee32e3ef3' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:03a685a4-8226-4076-b8a6-8b2ee32e3ef3', 2, NULL, 'Acte I', 'Danilowa: Acte I', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 9070 AND p.composer_id = 55
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:03a685a4-8226-4076-b8a6-8b2ee32e3ef3'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = NULL,
    part.name_ko = 'Acte II', part.name_en = 'Danilowa: Acte II',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 9070 AND p.composer_id = 55 AND part.part_key = 'musicbrainz:cab637ed-68d0-425e-8292-6909ab361eca' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:cab637ed-68d0-425e-8292-6909ab361eca', 3, NULL, 'Acte II', 'Danilowa: Acte II', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 9070 AND p.composer_id = 55
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:cab637ed-68d0-425e-8292-6909ab361eca'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = NULL,
    part.name_ko = 'Acte III', part.name_en = 'Danilowa: Acte III',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 9070 AND p.composer_id = 55 AND part.part_key = 'musicbrainz:e3f3359a-e776-49f0-bfe7-aee90820aaf6' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:e3f3359a-e776-49f0-bfe7-aee90820aaf6', 4, NULL, 'Acte III', 'Danilowa: Acte III', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 9070 AND p.composer_id = 55
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:e3f3359a-e776-49f0-bfe7-aee90820aaf6'
);


-- None 오페라 <Giralda ou La Nouvelle Psyché>

UPDATE pieces piece
SET piece.title = '오페라 <Giralda ou La Nouvelle Psyché>', piece.title_en = 'Giralda ou La Nouvelle Psyché',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 9818 AND piece.composer_id = 55
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None 발레 <Giselle, ou les Wilis>

UPDATE pieces piece
SET piece.title = '발레 <Giselle, ou les Wilis>', piece.title_en = 'Giselle, ou les Wilis',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 7530 AND piece.composer_id = 55
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'Act I', part.name_en = 'Giselle, ou les Wilis: Act I',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 7530 AND p.composer_id = 55 AND part.part_key = 'musicbrainz:0e10ba2d-6346-4e1b-88b2-f958b7149e68' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:0e10ba2d-6346-4e1b-88b2-f958b7149e68', 1, NULL, 'Act I', 'Giselle, ou les Wilis: Act I', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 7530 AND p.composer_id = 55
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:0e10ba2d-6346-4e1b-88b2-f958b7149e68'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:0e10ba2d-6346-4e1b-88b2-f958b7149e68'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'Act I. Introduction', part.name_en = 'Giselle: Act I. Introduction',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 7530 AND p.composer_id = 55 AND part.part_key = 'musicbrainz:38da45f4-bd5c-4758-abe5-c37bcef4cd08' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:38da45f4-bd5c-4758-abe5-c37bcef4cd08', 1, NULL, 'Act I. Introduction', 'Giselle: Act I. Introduction', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:0e10ba2d-6346-4e1b-88b2-f958b7149e68'
WHERE p.id = 7530 AND p.composer_id = 55
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:38da45f4-bd5c-4758-abe5-c37bcef4cd08'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:0e10ba2d-6346-4e1b-88b2-f958b7149e68'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'Act I. Entrée d’Hilarion', part.name_en = 'Giselle: Act I. Entrée d’Hilarion',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 7530 AND p.composer_id = 55 AND part.part_key = 'musicbrainz:3989e167-e665-417d-b269-b1f61048a213' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:3989e167-e665-417d-b269-b1f61048a213', 2, NULL, 'Act I. Entrée d’Hilarion', 'Giselle: Act I. Entrée d’Hilarion', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:0e10ba2d-6346-4e1b-88b2-f958b7149e68'
WHERE p.id = 7530 AND p.composer_id = 55
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:3989e167-e665-417d-b269-b1f61048a213'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:0e10ba2d-6346-4e1b-88b2-f958b7149e68'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = NULL,
    part.name_ko = 'Act I. Entrée de Giselle', part.name_en = 'Giselle: Act I. Entrée de Giselle',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 7530 AND p.composer_id = 55 AND part.part_key = 'musicbrainz:712a64c3-b493-4938-b813-0161eea2f5ef' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:712a64c3-b493-4938-b813-0161eea2f5ef', 3, NULL, 'Act I. Entrée de Giselle', 'Giselle: Act I. Entrée de Giselle', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:0e10ba2d-6346-4e1b-88b2-f958b7149e68'
WHERE p.id = 7530 AND p.composer_id = 55
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:712a64c3-b493-4938-b813-0161eea2f5ef'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:0e10ba2d-6346-4e1b-88b2-f958b7149e68'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = NULL,
    part.name_ko = 'Act I. Retour de la vendange', part.name_en = 'Giselle: Act I. Retour de la vendange',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 7530 AND p.composer_id = 55 AND part.part_key = 'musicbrainz:597eb18f-6644-4748-8861-5fba0a1839d8' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:597eb18f-6644-4748-8861-5fba0a1839d8', 4, NULL, 'Act I. Retour de la vendange', 'Giselle: Act I. Retour de la vendange', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:0e10ba2d-6346-4e1b-88b2-f958b7149e68'
WHERE p.id = 7530 AND p.composer_id = 55
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:597eb18f-6644-4748-8861-5fba0a1839d8'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:0e10ba2d-6346-4e1b-88b2-f958b7149e68'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 5, part.movement_number = NULL,
    part.name_ko = 'Act I. La chasse', part.name_en = 'Giselle: Act I. La chasse',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 7530 AND p.composer_id = 55 AND part.part_key = 'musicbrainz:35473f20-f553-48d7-a333-4bff2e4f2f03' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:35473f20-f553-48d7-a333-4bff2e4f2f03', 5, NULL, 'Act I. La chasse', 'Giselle: Act I. La chasse', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:0e10ba2d-6346-4e1b-88b2-f958b7149e68'
WHERE p.id = 7530 AND p.composer_id = 55
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:35473f20-f553-48d7-a333-4bff2e4f2f03'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:0e10ba2d-6346-4e1b-88b2-f958b7149e68'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 6, part.movement_number = NULL,
    part.name_ko = 'Act I. Scène de Hilarion', part.name_en = 'Giselle: Act I. Scène de Hilarion',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 7530 AND p.composer_id = 55 AND part.part_key = 'musicbrainz:87b75211-4cdb-422e-aff0-f94576b13dd5' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:87b75211-4cdb-422e-aff0-f94576b13dd5', 6, NULL, 'Act I. Scène de Hilarion', 'Giselle: Act I. Scène de Hilarion', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:0e10ba2d-6346-4e1b-88b2-f958b7149e68'
WHERE p.id = 7530 AND p.composer_id = 55
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:87b75211-4cdb-422e-aff0-f94576b13dd5'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:0e10ba2d-6346-4e1b-88b2-f958b7149e68'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 7, part.movement_number = NULL,
    part.name_ko = 'Act I. Marche des vignerons', part.name_en = 'Giselle: Act I. Marche des vignerons',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 7530 AND p.composer_id = 55 AND part.part_key = 'musicbrainz:7688df62-eaf7-4059-b14a-f18608f4a3ab' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:7688df62-eaf7-4059-b14a-f18608f4a3ab', 7, NULL, 'Act I. Marche des vignerons', 'Giselle: Act I. Marche des vignerons', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:0e10ba2d-6346-4e1b-88b2-f958b7149e68'
WHERE p.id = 7530 AND p.composer_id = 55
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:7688df62-eaf7-4059-b14a-f18608f4a3ab'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:0e10ba2d-6346-4e1b-88b2-f958b7149e68'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 8, part.movement_number = NULL,
    part.name_ko = 'Act I. Finale', part.name_en = 'Giselle: Act I. Finale',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 7530 AND p.composer_id = 55 AND part.part_key = 'musicbrainz:fa400d7c-c5f2-4234-bd9c-731985ffc359' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:fa400d7c-c5f2-4234-bd9c-731985ffc359', 8, NULL, 'Act I. Finale', 'Giselle: Act I. Finale', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:0e10ba2d-6346-4e1b-88b2-f958b7149e68'
WHERE p.id = 7530 AND p.composer_id = 55
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:fa400d7c-c5f2-4234-bd9c-731985ffc359'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:0e10ba2d-6346-4e1b-88b2-f958b7149e68'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 9, part.movement_number = NULL,
    part.name_ko = 'Act I. Pas de deux des jeunes paysans: f. Valse', part.name_en = 'Giselle: Act I. Pas de deux des jeunes paysans: f. Valse',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 7530 AND p.composer_id = 55 AND part.part_key = 'musicbrainz:00a31d32-ea67-4437-b36a-1fe563879b60' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:00a31d32-ea67-4437-b36a-1fe563879b60', 9, NULL, 'Act I. Pas de deux des jeunes paysans: f. Valse', 'Giselle: Act I. Pas de deux des jeunes paysans: f. Valse', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:0e10ba2d-6346-4e1b-88b2-f958b7149e68'
WHERE p.id = 7530 AND p.composer_id = 55
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:00a31d32-ea67-4437-b36a-1fe563879b60'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:0e10ba2d-6346-4e1b-88b2-f958b7149e68'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 10, part.movement_number = NULL,
    part.name_ko = 'Act I. Galop générale', part.name_en = 'Giselle: Act I. Galop générale',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 7530 AND p.composer_id = 55 AND part.part_key = 'musicbrainz:1f99bbe3-efb9-45e1-88a3-69ab49466d04' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:1f99bbe3-efb9-45e1-88a3-69ab49466d04', 10, NULL, 'Act I. Galop générale', 'Giselle: Act I. Galop générale', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:0e10ba2d-6346-4e1b-88b2-f958b7149e68'
WHERE p.id = 7530 AND p.composer_id = 55
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:1f99bbe3-efb9-45e1-88a3-69ab49466d04'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:0e10ba2d-6346-4e1b-88b2-f958b7149e68'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 11, part.movement_number = NULL,
    part.name_ko = 'Act I. Pas seul', part.name_en = 'Giselle: Act I. Pas seul',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 7530 AND p.composer_id = 55 AND part.part_key = 'musicbrainz:4162a143-ef03-44ae-b299-15826892bfad' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:4162a143-ef03-44ae-b299-15826892bfad', 11, NULL, 'Act I. Pas seul', 'Giselle: Act I. Pas seul', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:0e10ba2d-6346-4e1b-88b2-f958b7149e68'
WHERE p.id = 7530 AND p.composer_id = 55
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:4162a143-ef03-44ae-b299-15826892bfad'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:0e10ba2d-6346-4e1b-88b2-f958b7149e68'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 12, part.movement_number = NULL,
    part.name_ko = 'Act I. Pas de deux des jeunes paysans', part.name_en = 'Giselle: Act I. Pas de deux des jeunes paysans',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 7530 AND p.composer_id = 55 AND part.part_key = 'musicbrainz:4ae25533-eba2-4c31-811a-7024244225cd' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:4ae25533-eba2-4c31-811a-7024244225cd', 12, NULL, 'Act I. Pas de deux des jeunes paysans', 'Giselle: Act I. Pas de deux des jeunes paysans', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:0e10ba2d-6346-4e1b-88b2-f958b7149e68'
WHERE p.id = 7530 AND p.composer_id = 55
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:4ae25533-eba2-4c31-811a-7024244225cd'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:0e10ba2d-6346-4e1b-88b2-f958b7149e68'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 13, part.movement_number = NULL,
    part.name_ko = 'Act I. Entree de Loys', part.name_en = 'Giselle: Act I. Entree de Loys',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 7530 AND p.composer_id = 55 AND part.part_key = 'musicbrainz:8f3109bd-6354-472e-9e52-f53951a0f099' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:8f3109bd-6354-472e-9e52-f53951a0f099', 13, NULL, 'Act I. Entree de Loys', 'Giselle: Act I. Entree de Loys', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:0e10ba2d-6346-4e1b-88b2-f958b7149e68'
WHERE p.id = 7530 AND p.composer_id = 55
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:8f3109bd-6354-472e-9e52-f53951a0f099'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:0e10ba2d-6346-4e1b-88b2-f958b7149e68'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 14, part.movement_number = NULL,
    part.name_ko = 'Act I. Pas des vendanges', part.name_en = 'Giselle: Act I. Pas des vendanges',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 7530 AND p.composer_id = 55 AND part.part_key = 'musicbrainz:ce99d746-7914-45d5-aada-7b5f37e8c77f' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:ce99d746-7914-45d5-aada-7b5f37e8c77f', 14, NULL, 'Act I. Pas des vendanges', 'Giselle: Act I. Pas des vendanges', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:0e10ba2d-6346-4e1b-88b2-f958b7149e68'
WHERE p.id = 7530 AND p.composer_id = 55
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:ce99d746-7914-45d5-aada-7b5f37e8c77f'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:0e10ba2d-6346-4e1b-88b2-f958b7149e68'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 15, part.movement_number = NULL,
    part.name_ko = 'Act I. Pas de deux', part.name_en = 'Giselle: Act I. Pas de deux',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 7530 AND p.composer_id = 55 AND part.part_key = 'musicbrainz:dcf7e128-9f95-4731-bd80-3a73bd7a75ba' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:dcf7e128-9f95-4731-bd80-3a73bd7a75ba', 15, NULL, 'Act I. Pas de deux', 'Giselle: Act I. Pas de deux', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:0e10ba2d-6346-4e1b-88b2-f958b7149e68'
WHERE p.id = 7530 AND p.composer_id = 55
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:dcf7e128-9f95-4731-bd80-3a73bd7a75ba'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'Act II', part.name_en = 'Giselle, ou les Wilis: Act II',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 7530 AND p.composer_id = 55 AND part.part_key = 'musicbrainz:934788ae-a348-4241-9f8c-a3b938cafc03' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:934788ae-a348-4241-9f8c-a3b938cafc03', 2, NULL, 'Act II', 'Giselle, ou les Wilis: Act II', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 7530 AND p.composer_id = 55
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:934788ae-a348-4241-9f8c-a3b938cafc03'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:934788ae-a348-4241-9f8c-a3b938cafc03'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'Act II. Final', part.name_en = 'Giselle: Act II. Final',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 7530 AND p.composer_id = 55 AND part.part_key = 'musicbrainz:0806af8d-7da7-4b2f-9d87-4b75fbbb1ff0' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:0806af8d-7da7-4b2f-9d87-4b75fbbb1ff0', 1, NULL, 'Act II. Final', 'Giselle: Act II. Final', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:934788ae-a348-4241-9f8c-a3b938cafc03'
WHERE p.id = 7530 AND p.composer_id = 55
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:0806af8d-7da7-4b2f-9d87-4b75fbbb1ff0'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:934788ae-a348-4241-9f8c-a3b938cafc03'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'Apparitions de Myrthe et évocation magique', part.name_en = 'Giselle, Act II: Apparitions de Myrthe et évocation magique',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 7530 AND p.composer_id = 55 AND part.part_key = 'musicbrainz:1a0e0412-2e11-4269-ab4b-44b91454331a' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:1a0e0412-2e11-4269-ab4b-44b91454331a', 2, NULL, 'Apparitions de Myrthe et évocation magique', 'Giselle, Act II: Apparitions de Myrthe et évocation magique', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:934788ae-a348-4241-9f8c-a3b938cafc03'
WHERE p.id = 7530 AND p.composer_id = 55
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:1a0e0412-2e11-4269-ab4b-44b91454331a'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:934788ae-a348-4241-9f8c-a3b938cafc03'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = NULL,
    part.name_ko = 'Act II: Andantino non troppo', part.name_en = 'Giselle: Act II: Andantino non troppo',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 7530 AND p.composer_id = 55 AND part.part_key = 'musicbrainz:1c3ab83a-021f-3a76-bede-40f2910422d5' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:1c3ab83a-021f-3a76-bede-40f2910422d5', 3, NULL, 'Act II: Andantino non troppo', 'Giselle: Act II: Andantino non troppo', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:934788ae-a348-4241-9f8c-a3b938cafc03'
WHERE p.id = 7530 AND p.composer_id = 55
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:1c3ab83a-021f-3a76-bede-40f2910422d5'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:934788ae-a348-4241-9f8c-a3b938cafc03'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = NULL,
    part.name_ko = 'Introduction, halte des chausseurs et apparition des feux follets', part.name_en = 'Giselle, Act II: Introduction, halte des chausseurs et apparition des feux follets',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 7530 AND p.composer_id = 55 AND part.part_key = 'musicbrainz:3df841b8-4c70-4fd0-9105-8c225712cd0f' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:3df841b8-4c70-4fd0-9105-8c225712cd0f', 4, NULL, 'Introduction, halte des chausseurs et apparition des feux follets', 'Giselle, Act II: Introduction, halte des chausseurs et apparition des feux follets', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:934788ae-a348-4241-9f8c-a3b938cafc03'
WHERE p.id = 7530 AND p.composer_id = 55
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:3df841b8-4c70-4fd0-9105-8c225712cd0f'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:934788ae-a348-4241-9f8c-a3b938cafc03'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 5, part.movement_number = NULL,
    part.name_ko = 'Grand pas de deux: c. Andante', part.name_en = 'Giselle, Act II: Grand pas de deux: c. Andante',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 7530 AND p.composer_id = 55 AND part.part_key = 'musicbrainz:4ae14d27-a596-4915-8976-ec5b14279d93' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:4ae14d27-a596-4915-8976-ec5b14279d93', 5, NULL, 'Grand pas de deux: c. Andante', 'Giselle, Act II: Grand pas de deux: c. Andante', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:934788ae-a348-4241-9f8c-a3b938cafc03'
WHERE p.id = 7530 AND p.composer_id = 55
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:4ae14d27-a596-4915-8976-ec5b14279d93'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:934788ae-a348-4241-9f8c-a3b938cafc03'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 6, part.movement_number = NULL,
    part.name_ko = 'Lever du soleil et arrivée de la cour', part.name_en = 'Giselle, Act II: Lever du soleil et arrivée de la cour',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 7530 AND p.composer_id = 55 AND part.part_key = 'musicbrainz:5f9d5b10-61a1-417d-9fbb-0b1f8d435475' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:5f9d5b10-61a1-417d-9fbb-0b1f8d435475', 6, NULL, 'Lever du soleil et arrivée de la cour', 'Giselle, Act II: Lever du soleil et arrivée de la cour', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:934788ae-a348-4241-9f8c-a3b938cafc03'
WHERE p.id = 7530 AND p.composer_id = 55
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:5f9d5b10-61a1-417d-9fbb-0b1f8d435475'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:934788ae-a348-4241-9f8c-a3b938cafc03'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 7, part.movement_number = NULL,
    part.name_ko = 'Entrée des paysans', part.name_en = 'Giselle, Act II: Entrée des paysans',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 7530 AND p.composer_id = 55 AND part.part_key = 'musicbrainz:6266f55b-88af-400c-8411-9240d51d26a9' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:6266f55b-88af-400c-8411-9240d51d26a9', 7, NULL, 'Entrée des paysans', 'Giselle, Act II: Entrée des paysans', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:934788ae-a348-4241-9f8c-a3b938cafc03'
WHERE p.id = 7530 AND p.composer_id = 55
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:6266f55b-88af-400c-8411-9240d51d26a9'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:934788ae-a348-4241-9f8c-a3b938cafc03'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 8, part.movement_number = NULL,
    part.name_ko = 'Pas des premières Wilis', part.name_en = 'Giselle, Act II: Pas des premières Wilis',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 7530 AND p.composer_id = 55 AND part.part_key = 'musicbrainz:63f043b0-bf68-4f9b-bcf5-43bad6e96b79' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:63f043b0-bf68-4f9b-bcf5-43bad6e96b79', 8, NULL, 'Pas des premières Wilis', 'Giselle, Act II: Pas des premières Wilis', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:934788ae-a348-4241-9f8c-a3b938cafc03'
WHERE p.id = 7530 AND p.composer_id = 55
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:63f043b0-bf68-4f9b-bcf5-43bad6e96b79'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:934788ae-a348-4241-9f8c-a3b938cafc03'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 9, part.movement_number = NULL,
    part.name_ko = 'Act II: Andante', part.name_en = 'Giselle: Act II: Andante',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 7530 AND p.composer_id = 55 AND part.part_key = 'musicbrainz:72946acf-39ed-37a9-850f-39dc5e376f78' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:72946acf-39ed-37a9-850f-39dc5e376f78', 9, NULL, 'Act II: Andante', 'Giselle: Act II: Andante', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:934788ae-a348-4241-9f8c-a3b938cafc03'
WHERE p.id = 7530 AND p.composer_id = 55
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:72946acf-39ed-37a9-850f-39dc5e376f78'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:934788ae-a348-4241-9f8c-a3b938cafc03'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 10, part.movement_number = NULL,
    part.name_ko = 'Act II: Allegro non troppo', part.name_en = 'Giselle: Act II: Allegro non troppo',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 7530 AND p.composer_id = 55 AND part.part_key = 'musicbrainz:779df355-7be3-374d-a290-c3aa470de72f' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:779df355-7be3-374d-a290-c3aa470de72f', 10, NULL, 'Act II: Allegro non troppo', 'Giselle: Act II: Allegro non troppo', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:934788ae-a348-4241-9f8c-a3b938cafc03'
WHERE p.id = 7530 AND p.composer_id = 55
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:779df355-7be3-374d-a290-c3aa470de72f'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:934788ae-a348-4241-9f8c-a3b938cafc03'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 11, part.movement_number = NULL,
    part.name_ko = 'Act II. Scène des Wilis', part.name_en = 'Giselle: Act II. Scène des Wilis',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 7530 AND p.composer_id = 55 AND part.part_key = 'musicbrainz:7ab8ace4-c25d-4cd3-9bb3-888779de9a4c' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:7ab8ace4-c25d-4cd3-9bb3-888779de9a4c', 11, NULL, 'Act II. Scène des Wilis', 'Giselle: Act II. Scène des Wilis', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:934788ae-a348-4241-9f8c-a3b938cafc03'
WHERE p.id = 7530 AND p.composer_id = 55
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:7ab8ace4-c25d-4cd3-9bb3-888779de9a4c'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:934788ae-a348-4241-9f8c-a3b938cafc03'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 12, part.movement_number = NULL,
    part.name_ko = '2.02 La halte des chasseurs (Allegro)', part.name_en = 'Giselle: 2.02 La halte des chasseurs (Allegro)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 7530 AND p.composer_id = 55 AND part.part_key = 'musicbrainz:810a36b7-d54f-4a6f-bf1d-95e57162b8be' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:810a36b7-d54f-4a6f-bf1d-95e57162b8be', 12, NULL, '2.02 La halte des chasseurs (Allegro)', 'Giselle: 2.02 La halte des chasseurs (Allegro)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:934788ae-a348-4241-9f8c-a3b938cafc03'
WHERE p.id = 7530 AND p.composer_id = 55
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:810a36b7-d54f-4a6f-bf1d-95e57162b8be'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:934788ae-a348-4241-9f8c-a3b938cafc03'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 13, part.movement_number = NULL,
    part.name_ko = '2.04 Scène de Myrtha (Andante)', part.name_en = 'Giselle: 2.04 Scène de Myrtha (Andante)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 7530 AND p.composer_id = 55 AND part.part_key = 'musicbrainz:8a407b82-01a2-4d47-8e83-66c8b096e531' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:8a407b82-01a2-4d47-8e83-66c8b096e531', 13, NULL, '2.04 Scène de Myrtha (Andante)', 'Giselle: 2.04 Scène de Myrtha (Andante)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:934788ae-a348-4241-9f8c-a3b938cafc03'
WHERE p.id = 7530 AND p.composer_id = 55
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:8a407b82-01a2-4d47-8e83-66c8b096e531'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:934788ae-a348-4241-9f8c-a3b938cafc03'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 14, part.movement_number = NULL,
    part.name_ko = 'Act II. Entrée de Loys / Pas de deux', part.name_en = 'Giselle: Act II. Entrée de Loys / Pas de deux',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 7530 AND p.composer_id = 55 AND part.part_key = 'musicbrainz:8a9c4019-fe35-4282-8182-217b09a5447c' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:8a9c4019-fe35-4282-8182-217b09a5447c', 14, NULL, 'Act II. Entrée de Loys / Pas de deux', 'Giselle: Act II. Entrée de Loys / Pas de deux', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:934788ae-a348-4241-9f8c-a3b938cafc03'
WHERE p.id = 7530 AND p.composer_id = 55
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:8a9c4019-fe35-4282-8182-217b09a5447c'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:934788ae-a348-4241-9f8c-a3b938cafc03'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 15, part.movement_number = NULL,
    part.name_ko = 'Act II. Apparition et scène de Myrthe', part.name_en = 'Giselle: Act II. Apparition et scène de Myrthe',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 7530 AND p.composer_id = 55 AND part.part_key = 'musicbrainz:9092ce2a-16c5-4f6d-8e51-d65b82350869' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:9092ce2a-16c5-4f6d-8e51-d65b82350869', 15, NULL, 'Act II. Apparition et scène de Myrthe', 'Giselle: Act II. Apparition et scène de Myrthe', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:934788ae-a348-4241-9f8c-a3b938cafc03'
WHERE p.id = 7530 AND p.composer_id = 55
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:9092ce2a-16c5-4f6d-8e51-d65b82350869'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:934788ae-a348-4241-9f8c-a3b938cafc03'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 16, part.movement_number = NULL,
    part.name_ko = 'Grand pas de deux: d. Valse (interpolated)', part.name_en = 'Giselle, Act II: Grand pas de deux: d. Valse (interpolated)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 7530 AND p.composer_id = 55 AND part.part_key = 'musicbrainz:962cd377-b709-4feb-bcbc-bd037255e7a3' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:962cd377-b709-4feb-bcbc-bd037255e7a3', 16, NULL, 'Grand pas de deux: d. Valse (interpolated)', 'Giselle, Act II: Grand pas de deux: d. Valse (interpolated)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:934788ae-a348-4241-9f8c-a3b938cafc03'
WHERE p.id = 7530 AND p.composer_id = 55
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:962cd377-b709-4feb-bcbc-bd037255e7a3'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:934788ae-a348-4241-9f8c-a3b938cafc03'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 17, part.movement_number = NULL,
    part.name_ko = 'Act II: Intermezzo', part.name_en = 'Giselle: Act II: Intermezzo',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 7530 AND p.composer_id = 55 AND part.part_key = 'musicbrainz:9fc05c16-8091-39a2-a2f2-aa8d5ab326f6' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:9fc05c16-8091-39a2-a2f2-aa8d5ab326f6', 17, NULL, 'Act II: Intermezzo', 'Giselle: Act II: Intermezzo', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:934788ae-a348-4241-9f8c-a3b938cafc03'
WHERE p.id = 7530 AND p.composer_id = 55
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:9fc05c16-8091-39a2-a2f2-aa8d5ab326f6'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:934788ae-a348-4241-9f8c-a3b938cafc03'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 18, part.movement_number = NULL,
    part.name_ko = 'Act II: Transition', part.name_en = 'Giselle: Act II: Transition',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 7530 AND p.composer_id = 55 AND part.part_key = 'musicbrainz:b0bce388-e88f-33de-a241-3fc129742c11' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:b0bce388-e88f-33de-a241-3fc129742c11', 18, NULL, 'Act II: Transition', 'Giselle: Act II: Transition', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:934788ae-a348-4241-9f8c-a3b938cafc03'
WHERE p.id = 7530 AND p.composer_id = 55
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:b0bce388-e88f-33de-a241-3fc129742c11'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:934788ae-a348-4241-9f8c-a3b938cafc03'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 19, part.movement_number = NULL,
    part.name_ko = '2.03 Apparition de Myrtha (Andantino)', part.name_en = 'Giselle: 2.03 Apparition de Myrtha (Andantino)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 7530 AND p.composer_id = 55 AND part.part_key = 'musicbrainz:c780dd08-2eae-4abe-af49-30560ab9e965' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:c780dd08-2eae-4abe-af49-30560ab9e965', 19, NULL, '2.03 Apparition de Myrtha (Andantino)', 'Giselle: 2.03 Apparition de Myrtha (Andantino)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:934788ae-a348-4241-9f8c-a3b938cafc03'
WHERE p.id = 7530 AND p.composer_id = 55
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:c780dd08-2eae-4abe-af49-30560ab9e965'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:934788ae-a348-4241-9f8c-a3b938cafc03'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 20, part.movement_number = NULL,
    part.name_ko = 'Act II. Variation de Giselle', part.name_en = 'Giselle: Act II. Variation de Giselle',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 7530 AND p.composer_id = 55 AND part.part_key = 'musicbrainz:d649cc35-6a6c-4146-b99f-c9fcb87132f6' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:d649cc35-6a6c-4146-b99f-c9fcb87132f6', 20, NULL, 'Act II. Variation de Giselle', 'Giselle: Act II. Variation de Giselle', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:934788ae-a348-4241-9f8c-a3b938cafc03'
WHERE p.id = 7530 AND p.composer_id = 55
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:d649cc35-6a6c-4146-b99f-c9fcb87132f6'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:934788ae-a348-4241-9f8c-a3b938cafc03'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 21, part.movement_number = NULL,
    part.name_ko = 'Entrée d’Hilarion, scène et fugue des Wilis', part.name_en = 'Giselle, Act II: Entrée d’Hilarion, scène et fugue des Wilis',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 7530 AND p.composer_id = 55 AND part.part_key = 'musicbrainz:dcc48969-39f2-4f42-9d0b-8cc47f681053' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:dcc48969-39f2-4f42-9d0b-8cc47f681053', 21, NULL, 'Entrée d’Hilarion, scène et fugue des Wilis', 'Giselle, Act II: Entrée d’Hilarion, scène et fugue des Wilis', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:934788ae-a348-4241-9f8c-a3b938cafc03'
WHERE p.id = 7530 AND p.composer_id = 55
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:dcc48969-39f2-4f42-9d0b-8cc47f681053'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:934788ae-a348-4241-9f8c-a3b938cafc03'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 22, part.movement_number = NULL,
    part.name_ko = 'Entrée du Prince et apparition de Giselle', part.name_en = 'Giselle, Act II: Entrée du Prince et apparition de Giselle',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 7530 AND p.composer_id = 55 AND part.part_key = 'musicbrainz:ebaf143b-7269-4cc3-840e-63fed8b2381e' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:ebaf143b-7269-4cc3-840e-63fed8b2381e', 22, NULL, 'Entrée du Prince et apparition de Giselle', 'Giselle, Act II: Entrée du Prince et apparition de Giselle', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:934788ae-a348-4241-9f8c-a3b938cafc03'
WHERE p.id = 7530 AND p.composer_id = 55
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:ebaf143b-7269-4cc3-840e-63fed8b2381e'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:934788ae-a348-4241-9f8c-a3b938cafc03'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 23, part.movement_number = NULL,
    part.name_ko = 'Act II. Variation de Loys', part.name_en = 'Giselle: Act II. Variation de Loys',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 7530 AND p.composer_id = 55 AND part.part_key = 'musicbrainz:ed52e75c-548e-4d25-9d17-bd9a01d63954' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:ed52e75c-548e-4d25-9d17-bd9a01d63954', 23, NULL, 'Act II. Variation de Loys', 'Giselle: Act II. Variation de Loys', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:934788ae-a348-4241-9f8c-a3b938cafc03'
WHERE p.id = 7530 AND p.composer_id = 55
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:ed52e75c-548e-4d25-9d17-bd9a01d63954'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:934788ae-a348-4241-9f8c-a3b938cafc03'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 24, part.movement_number = NULL,
    part.name_ko = 'Grand pas de deux: a. Adage', part.name_en = 'Giselle, Act II: Grand pas de deux: a. Adage',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 7530 AND p.composer_id = 55 AND part.part_key = 'musicbrainz:eed68bf9-2add-43de-9c6f-2cd7cc7842e6' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:eed68bf9-2add-43de-9c6f-2cd7cc7842e6', 24, NULL, 'Grand pas de deux: a. Adage', 'Giselle, Act II: Grand pas de deux: a. Adage', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:934788ae-a348-4241-9f8c-a3b938cafc03'
WHERE p.id = 7530 AND p.composer_id = 55
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:eed68bf9-2add-43de-9c6f-2cd7cc7842e6'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:934788ae-a348-4241-9f8c-a3b938cafc03'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 25, part.movement_number = NULL,
    part.name_ko = 'Act II. Apparition de Giselle', part.name_en = 'Giselle: Act II. Apparition de Giselle',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 7530 AND p.composer_id = 55 AND part.part_key = 'musicbrainz:f0c1c265-e50e-42c1-88ae-81db82645b62' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:f0c1c265-e50e-42c1-88ae-81db82645b62', 25, NULL, 'Act II. Apparition de Giselle', 'Giselle: Act II. Apparition de Giselle', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:934788ae-a348-4241-9f8c-a3b938cafc03'
WHERE p.id = 7530 AND p.composer_id = 55
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:f0c1c265-e50e-42c1-88ae-81db82645b62'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:934788ae-a348-4241-9f8c-a3b938cafc03'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 26, part.movement_number = NULL,
    part.name_ko = 'Act II. Grand pas de deux', part.name_en = 'Giselle: Act II. Grand pas de deux',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 7530 AND p.composer_id = 55 AND part.part_key = 'musicbrainz:f77e3b00-670a-482f-8526-2226712404be' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:f77e3b00-670a-482f-8526-2226712404be', 26, NULL, 'Act II. Grand pas de deux', 'Giselle: Act II. Grand pas de deux', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:934788ae-a348-4241-9f8c-a3b938cafc03'
WHERE p.id = 7530 AND p.composer_id = 55
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:f77e3b00-670a-482f-8526-2226712404be'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:934788ae-a348-4241-9f8c-a3b938cafc03'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 27, part.movement_number = NULL,
    part.name_ko = 'Grand pas de deux: b. Andantino', part.name_en = 'Giselle, Act II: Grand pas de deux: b. Andantino',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 7530 AND p.composer_id = 55 AND part.part_key = 'musicbrainz:fe10e15e-7f1b-457f-8e48-5725c8d12037' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:fe10e15e-7f1b-457f-8e48-5725c8d12037', 27, NULL, 'Grand pas de deux: b. Andantino', 'Giselle, Act II: Grand pas de deux: b. Andantino', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:934788ae-a348-4241-9f8c-a3b938cafc03'
WHERE p.id = 7530 AND p.composer_id = 55
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:fe10e15e-7f1b-457f-8e48-5725c8d12037'
);


-- None 발레 <La Filleule des fées>

UPDATE pieces piece
SET piece.title = '발레 <La Filleule des fées>', piece.title_en = 'La Filleule des fées',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 9411 AND piece.composer_id = 55
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'Prologue', part.name_en = 'La Filleule des fées: Prologue',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 9411 AND p.composer_id = 55 AND part.part_key = 'musicbrainz:dd351093-0151-4d71-aa12-5e8dd4c7b27b' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:dd351093-0151-4d71-aa12-5e8dd4c7b27b', 1, NULL, 'Prologue', 'La Filleule des fées: Prologue', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 9411 AND p.composer_id = 55
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:dd351093-0151-4d71-aa12-5e8dd4c7b27b'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:dd351093-0151-4d71-aa12-5e8dd4c7b27b'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'Prologue (Guillaume''s Farm-House): No. 1', part.name_en = 'La Filleule des fées: Prologue (Guillaume''s Farm-House): No. 1',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 9411 AND p.composer_id = 55 AND part.part_key = 'musicbrainz:091a599d-408c-438a-89f6-fcc6c0235788' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:091a599d-408c-438a-89f6-fcc6c0235788', 1, NULL, 'Prologue (Guillaume''s Farm-House): No. 1', 'La Filleule des fées: Prologue (Guillaume''s Farm-House): No. 1', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:dd351093-0151-4d71-aa12-5e8dd4c7b27b'
WHERE p.id = 9411 AND p.composer_id = 55
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:091a599d-408c-438a-89f6-fcc6c0235788'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:dd351093-0151-4d71-aa12-5e8dd4c7b27b'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'Prologue (Guillaume''s Farm-House): No. 2', part.name_en = 'La Filleule des fées: Prologue (Guillaume''s Farm-House): No. 2',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 9411 AND p.composer_id = 55 AND part.part_key = 'musicbrainz:a6b46fcc-a7db-4574-a82b-0846c8842187' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:a6b46fcc-a7db-4574-a82b-0846c8842187', 2, NULL, 'Prologue (Guillaume''s Farm-House): No. 2', 'La Filleule des fées: Prologue (Guillaume''s Farm-House): No. 2', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:dd351093-0151-4d71-aa12-5e8dd4c7b27b'
WHERE p.id = 9411 AND p.composer_id = 55
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:a6b46fcc-a7db-4574-a82b-0846c8842187'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:dd351093-0151-4d71-aa12-5e8dd4c7b27b'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = NULL,
    part.name_ko = 'Prologue (Guillaume''s Farm-House): Nos. 3, 4 & 5', part.name_en = 'La Filleule des fées: Prologue (Guillaume''s Farm-House): Nos. 3, 4 & 5',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 9411 AND p.composer_id = 55 AND part.part_key = 'musicbrainz:d7f5a6cc-84c9-4f5a-9197-0bb97cbd597a' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:d7f5a6cc-84c9-4f5a-9197-0bb97cbd597a', 3, NULL, 'Prologue (Guillaume''s Farm-House): Nos. 3, 4 & 5', 'La Filleule des fées: Prologue (Guillaume''s Farm-House): Nos. 3, 4 & 5', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:dd351093-0151-4d71-aa12-5e8dd4c7b27b'
WHERE p.id = 9411 AND p.composer_id = 55
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:d7f5a6cc-84c9-4f5a-9197-0bb97cbd597a'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:dd351093-0151-4d71-aa12-5e8dd4c7b27b'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = NULL,
    part.name_ko = 'Prologue (Guillaume''s Farm-House): No. 6', part.name_en = 'La Filleule des fées: Prologue (Guillaume''s Farm-House): No. 6',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 9411 AND p.composer_id = 55 AND part.part_key = 'musicbrainz:f39567f2-6ecf-4c59-8f2c-62024c93a70d' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:f39567f2-6ecf-4c59-8f2c-62024c93a70d', 4, NULL, 'Prologue (Guillaume''s Farm-House): No. 6', 'La Filleule des fées: Prologue (Guillaume''s Farm-House): No. 6', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:dd351093-0151-4d71-aa12-5e8dd4c7b27b'
WHERE p.id = 9411 AND p.composer_id = 55
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:f39567f2-6ecf-4c59-8f2c-62024c93a70d'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:dd351093-0151-4d71-aa12-5e8dd4c7b27b'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 5, part.movement_number = NULL,
    part.name_ko = 'Prologue (Guillaume''s Farm-House): No. 7', part.name_en = 'La Filleule des fées: Prologue (Guillaume''s Farm-House): No. 7',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 9411 AND p.composer_id = 55 AND part.part_key = 'musicbrainz:55d90b8e-c0e7-4aee-a3bd-df707325d348' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:55d90b8e-c0e7-4aee-a3bd-df707325d348', 5, NULL, 'Prologue (Guillaume''s Farm-House): No. 7', 'La Filleule des fées: Prologue (Guillaume''s Farm-House): No. 7', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:dd351093-0151-4d71-aa12-5e8dd4c7b27b'
WHERE p.id = 9411 AND p.composer_id = 55
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:55d90b8e-c0e7-4aee-a3bd-df707325d348'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:dd351093-0151-4d71-aa12-5e8dd4c7b27b'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 6, part.movement_number = NULL,
    part.name_ko = 'Prologue (Guillaume''s Farm-House): No. 8', part.name_en = 'La Filleule des fées: Prologue (Guillaume''s Farm-House): No. 8',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 9411 AND p.composer_id = 55 AND part.part_key = 'musicbrainz:ff139d41-6fd0-47eb-9102-10a2ddc23ca5' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:ff139d41-6fd0-47eb-9102-10a2ddc23ca5', 6, NULL, 'Prologue (Guillaume''s Farm-House): No. 8', 'La Filleule des fées: Prologue (Guillaume''s Farm-House): No. 8', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:dd351093-0151-4d71-aa12-5e8dd4c7b27b'
WHERE p.id = 9411 AND p.composer_id = 55
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:ff139d41-6fd0-47eb-9102-10a2ddc23ca5'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:dd351093-0151-4d71-aa12-5e8dd4c7b27b'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 7, part.movement_number = NULL,
    part.name_ko = 'Prologue (Guillaume''s Farm-House): No. 9', part.name_en = 'La Filleule des fées: Prologue (Guillaume''s Farm-House): No. 9',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 9411 AND p.composer_id = 55 AND part.part_key = 'musicbrainz:3041f5d1-77fd-458d-84bc-1460d9037c9f' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:3041f5d1-77fd-458d-84bc-1460d9037c9f', 7, NULL, 'Prologue (Guillaume''s Farm-House): No. 9', 'La Filleule des fées: Prologue (Guillaume''s Farm-House): No. 9', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:dd351093-0151-4d71-aa12-5e8dd4c7b27b'
WHERE p.id = 9411 AND p.composer_id = 55
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:3041f5d1-77fd-458d-84bc-1460d9037c9f'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:dd351093-0151-4d71-aa12-5e8dd4c7b27b'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 8, part.movement_number = NULL,
    part.name_ko = 'Prologue (Guillaume''s Farm-House): No. 10', part.name_en = 'La Filleule des fées: Prologue (Guillaume''s Farm-House): No. 10',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 9411 AND p.composer_id = 55 AND part.part_key = 'musicbrainz:79e74f9c-4d17-4b70-a160-7218fbea13eb' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:79e74f9c-4d17-4b70-a160-7218fbea13eb', 8, NULL, 'Prologue (Guillaume''s Farm-House): No. 10', 'La Filleule des fées: Prologue (Guillaume''s Farm-House): No. 10', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:dd351093-0151-4d71-aa12-5e8dd4c7b27b'
WHERE p.id = 9411 AND p.composer_id = 55
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:79e74f9c-4d17-4b70-a160-7218fbea13eb'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'Act I', part.name_en = 'La Filleule des fées: Act I',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 9411 AND p.composer_id = 55 AND part.part_key = 'musicbrainz:09d3d855-104b-4d23-9733-cd19c88e22a3' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:09d3d855-104b-4d23-9733-cd19c88e22a3', 2, NULL, 'Act I', 'La Filleule des fées: Act I', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 9411 AND p.composer_id = 55
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:09d3d855-104b-4d23-9733-cd19c88e22a3'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:09d3d855-104b-4d23-9733-cd19c88e22a3'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'Tableau 1 (The Countryside): No. 1', part.name_en = 'La Filleule des fées: Act I, Tableau 1 (The Countryside): No. 1',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 9411 AND p.composer_id = 55 AND part.part_key = 'musicbrainz:f2acc123-43a2-4b02-bcc8-642ea3ffceed' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:f2acc123-43a2-4b02-bcc8-642ea3ffceed', 1, NULL, 'Tableau 1 (The Countryside): No. 1', 'La Filleule des fées: Act I, Tableau 1 (The Countryside): No. 1', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:09d3d855-104b-4d23-9733-cd19c88e22a3'
WHERE p.id = 9411 AND p.composer_id = 55
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:f2acc123-43a2-4b02-bcc8-642ea3ffceed'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:09d3d855-104b-4d23-9733-cd19c88e22a3'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'Tableau 1 (The Countryside): No. 2. Pas de cinq', part.name_en = 'La Filleule des fées: Act I, Tableau 1 (The Countryside): No. 2. Pas de cinq',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 9411 AND p.composer_id = 55 AND part.part_key = 'musicbrainz:7705c4c2-1ddb-4c30-8fae-f2d5af2ce8a7' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:7705c4c2-1ddb-4c30-8fae-f2d5af2ce8a7', 2, NULL, 'Tableau 1 (The Countryside): No. 2. Pas de cinq', 'La Filleule des fées: Act I, Tableau 1 (The Countryside): No. 2. Pas de cinq', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:09d3d855-104b-4d23-9733-cd19c88e22a3'
WHERE p.id = 9411 AND p.composer_id = 55
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:7705c4c2-1ddb-4c30-8fae-f2d5af2ce8a7'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:09d3d855-104b-4d23-9733-cd19c88e22a3'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = NULL,
    part.name_ko = 'Tableau 1 (The Countryside): No. 3', part.name_en = 'La Filleule des fées: Act I, Tableau 1 (The Countryside): No. 3',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 9411 AND p.composer_id = 55 AND part.part_key = 'musicbrainz:2cff62e2-9672-4a66-b932-b8e44c80e88b' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:2cff62e2-9672-4a66-b932-b8e44c80e88b', 3, NULL, 'Tableau 1 (The Countryside): No. 3', 'La Filleule des fées: Act I, Tableau 1 (The Countryside): No. 3', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:09d3d855-104b-4d23-9733-cd19c88e22a3'
WHERE p.id = 9411 AND p.composer_id = 55
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:2cff62e2-9672-4a66-b932-b8e44c80e88b'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:09d3d855-104b-4d23-9733-cd19c88e22a3'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = NULL,
    part.name_ko = 'Tableau 1 (The Countryside): No. 4', part.name_en = 'La Filleule des fées: Act I, Tableau 1 (The Countryside): No. 4',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 9411 AND p.composer_id = 55 AND part.part_key = 'musicbrainz:d3b8556a-8123-4e0d-9c7c-5a7ca1cc0620' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:d3b8556a-8123-4e0d-9c7c-5a7ca1cc0620', 4, NULL, 'Tableau 1 (The Countryside): No. 4', 'La Filleule des fées: Act I, Tableau 1 (The Countryside): No. 4', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:09d3d855-104b-4d23-9733-cd19c88e22a3'
WHERE p.id = 9411 AND p.composer_id = 55
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:d3b8556a-8123-4e0d-9c7c-5a7ca1cc0620'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:09d3d855-104b-4d23-9733-cd19c88e22a3'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 5, part.movement_number = NULL,
    part.name_ko = 'Tableau 1 (The Countryside): No. 5', part.name_en = 'La Filleule des fées: Act I, Tableau 1 (The Countryside): No. 5',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 9411 AND p.composer_id = 55 AND part.part_key = 'musicbrainz:ce1d87e2-6a6d-4ac4-acbb-e243af572fc9' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:ce1d87e2-6a6d-4ac4-acbb-e243af572fc9', 5, NULL, 'Tableau 1 (The Countryside): No. 5', 'La Filleule des fées: Act I, Tableau 1 (The Countryside): No. 5', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:09d3d855-104b-4d23-9733-cd19c88e22a3'
WHERE p.id = 9411 AND p.composer_id = 55
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:ce1d87e2-6a6d-4ac4-acbb-e243af572fc9'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:09d3d855-104b-4d23-9733-cd19c88e22a3'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 6, part.movement_number = NULL,
    part.name_ko = 'Tableau 1 (The Countryside): No. 6', part.name_en = 'La Filleule des fées: Act I, Tableau 1 (The Countryside): No. 6',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 9411 AND p.composer_id = 55 AND part.part_key = 'musicbrainz:13f28b01-9dab-4677-9ce8-91000e3ea6d3' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:13f28b01-9dab-4677-9ce8-91000e3ea6d3', 6, NULL, 'Tableau 1 (The Countryside): No. 6', 'La Filleule des fées: Act I, Tableau 1 (The Countryside): No. 6', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:09d3d855-104b-4d23-9733-cd19c88e22a3'
WHERE p.id = 9411 AND p.composer_id = 55
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:13f28b01-9dab-4677-9ce8-91000e3ea6d3'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:09d3d855-104b-4d23-9733-cd19c88e22a3'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 7, part.movement_number = NULL,
    part.name_ko = 'Tableau 1 (The Countryside): No. 7', part.name_en = 'La Filleule des fées: Act I, Tableau 1 (The Countryside): No. 7',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 9411 AND p.composer_id = 55 AND part.part_key = 'musicbrainz:59f68fc0-2157-4e4f-8800-553eb7480607' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:59f68fc0-2157-4e4f-8800-553eb7480607', 7, NULL, 'Tableau 1 (The Countryside): No. 7', 'La Filleule des fées: Act I, Tableau 1 (The Countryside): No. 7', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:09d3d855-104b-4d23-9733-cd19c88e22a3'
WHERE p.id = 9411 AND p.composer_id = 55
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:59f68fc0-2157-4e4f-8800-553eb7480607'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:09d3d855-104b-4d23-9733-cd19c88e22a3'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 8, part.movement_number = NULL,
    part.name_ko = 'Tableau 1 (The Countryside): No. 8', part.name_en = 'La Filleule des fées: Act I, Tableau 1 (The Countryside): No. 8',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 9411 AND p.composer_id = 55 AND part.part_key = 'musicbrainz:a115f499-0b1d-4f9a-a0bb-b0dd4c63a075' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:a115f499-0b1d-4f9a-a0bb-b0dd4c63a075', 8, NULL, 'Tableau 1 (The Countryside): No. 8', 'La Filleule des fées: Act I, Tableau 1 (The Countryside): No. 8', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:09d3d855-104b-4d23-9733-cd19c88e22a3'
WHERE p.id = 9411 AND p.composer_id = 55
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:a115f499-0b1d-4f9a-a0bb-b0dd4c63a075'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:09d3d855-104b-4d23-9733-cd19c88e22a3'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 9, part.movement_number = NULL,
    part.name_ko = 'Tableau 1 (The Countryside): No. 9. Divertissement', part.name_en = 'La Filleule des fées: Act I, Tableau 1 (The Countryside): No. 9. Divertissement',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 9411 AND p.composer_id = 55 AND part.part_key = 'musicbrainz:f5c7bae5-7898-41be-843a-0d2f1883188c' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:f5c7bae5-7898-41be-843a-0d2f1883188c', 9, NULL, 'Tableau 1 (The Countryside): No. 9. Divertissement', 'La Filleule des fées: Act I, Tableau 1 (The Countryside): No. 9. Divertissement', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:09d3d855-104b-4d23-9733-cd19c88e22a3'
WHERE p.id = 9411 AND p.composer_id = 55
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:f5c7bae5-7898-41be-843a-0d2f1883188c'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:09d3d855-104b-4d23-9733-cd19c88e22a3'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 10, part.movement_number = NULL,
    part.name_ko = 'Tableau 1 (The Countryside): No. 9a (No. 10). Pas de cinq', part.name_en = 'La Filleule des fées: Act I, Tableau 1 (The Countryside): No. 9a (No. 10). Pas de cinq',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 9411 AND p.composer_id = 55 AND part.part_key = 'musicbrainz:09f62828-f4f1-4b1d-b6b5-abdbab5e83f8' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:09f62828-f4f1-4b1d-b6b5-abdbab5e83f8', 10, NULL, 'Tableau 1 (The Countryside): No. 9a (No. 10). Pas de cinq', 'La Filleule des fées: Act I, Tableau 1 (The Countryside): No. 9a (No. 10). Pas de cinq', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:09d3d855-104b-4d23-9733-cd19c88e22a3'
WHERE p.id = 9411 AND p.composer_id = 55
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:09f62828-f4f1-4b1d-b6b5-abdbab5e83f8'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:09d3d855-104b-4d23-9733-cd19c88e22a3'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 11, part.movement_number = NULL,
    part.name_ko = 'Tableau 1 (The Countryside): No. 9b (No. 11)', part.name_en = 'La Filleule des fées: Act I, Tableau 1 (The Countryside): No. 9b (No. 11)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 9411 AND p.composer_id = 55 AND part.part_key = 'musicbrainz:4d5d0b75-9ce2-4b74-bcf5-37e350778f5c' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:4d5d0b75-9ce2-4b74-bcf5-37e350778f5c', 11, NULL, 'Tableau 1 (The Countryside): No. 9b (No. 11)', 'La Filleule des fées: Act I, Tableau 1 (The Countryside): No. 9b (No. 11)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:09d3d855-104b-4d23-9733-cd19c88e22a3'
WHERE p.id = 9411 AND p.composer_id = 55
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:4d5d0b75-9ce2-4b74-bcf5-37e350778f5c'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:09d3d855-104b-4d23-9733-cd19c88e22a3'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 12, part.movement_number = NULL,
    part.name_ko = 'Tableau 1 (The Countryside): No. 9c (No. 12). M. Petipa', part.name_en = 'La Filleule des fées: Act I, Tableau 1 (The Countryside): No. 9c (No. 12). M. Petipa',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 9411 AND p.composer_id = 55 AND part.part_key = 'musicbrainz:bdeb91e3-a3a5-4e2d-ba28-55862fc02f1f' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:bdeb91e3-a3a5-4e2d-ba28-55862fc02f1f', 12, NULL, 'Tableau 1 (The Countryside): No. 9c (No. 12). M. Petipa', 'La Filleule des fées: Act I, Tableau 1 (The Countryside): No. 9c (No. 12). M. Petipa', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:09d3d855-104b-4d23-9733-cd19c88e22a3'
WHERE p.id = 9411 AND p.composer_id = 55
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:bdeb91e3-a3a5-4e2d-ba28-55862fc02f1f'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:09d3d855-104b-4d23-9733-cd19c88e22a3'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 13, part.movement_number = NULL,
    part.name_ko = 'Tableau 1 (The Countryside): No. 9d (No. 13)', part.name_en = 'La Filleule des fées: Act I, Tableau 1 (The Countryside): No. 9d (No. 13)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 9411 AND p.composer_id = 55 AND part.part_key = 'musicbrainz:a7fcce20-eeb3-4666-846c-ecf9902d28c7' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:a7fcce20-eeb3-4666-846c-ecf9902d28c7', 13, NULL, 'Tableau 1 (The Countryside): No. 9d (No. 13)', 'La Filleule des fées: Act I, Tableau 1 (The Countryside): No. 9d (No. 13)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:09d3d855-104b-4d23-9733-cd19c88e22a3'
WHERE p.id = 9411 AND p.composer_id = 55
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:a7fcce20-eeb3-4666-846c-ecf9902d28c7'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:09d3d855-104b-4d23-9733-cd19c88e22a3'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 14, part.movement_number = NULL,
    part.name_ko = 'Tableau 1 (The Countryside): No. 10 (No. 14). Après le divertissement', part.name_en = 'La Filleule des fées: Act I, Tableau 1 (The Countryside): No. 10 (No. 14). Après le divertissement',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 9411 AND p.composer_id = 55 AND part.part_key = 'musicbrainz:f450dbfb-c5aa-4d92-afa7-41fdee6511fb' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:f450dbfb-c5aa-4d92-afa7-41fdee6511fb', 14, NULL, 'Tableau 1 (The Countryside): No. 10 (No. 14). Après le divertissement', 'La Filleule des fées: Act I, Tableau 1 (The Countryside): No. 10 (No. 14). Après le divertissement', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:09d3d855-104b-4d23-9733-cd19c88e22a3'
WHERE p.id = 9411 AND p.composer_id = 55
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:f450dbfb-c5aa-4d92-afa7-41fdee6511fb'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:09d3d855-104b-4d23-9733-cd19c88e22a3'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 15, part.movement_number = NULL,
    part.name_ko = 'Tableau 2 (Ysaure''s Chamber): No. 1. Marche lointaine (Nos. 1, 2 & 3)', part.name_en = 'La Filleule des fées: Act I, Tableau 2 (Ysaure''s Chamber): No. 1. Marche lointaine (Nos. 1, 2 & 3)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 9411 AND p.composer_id = 55 AND part.part_key = 'musicbrainz:f9bc0110-6374-49fe-8379-73635f657d11' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:f9bc0110-6374-49fe-8379-73635f657d11', 15, NULL, 'Tableau 2 (Ysaure''s Chamber): No. 1. Marche lointaine (Nos. 1, 2 & 3)', 'La Filleule des fées: Act I, Tableau 2 (Ysaure''s Chamber): No. 1. Marche lointaine (Nos. 1, 2 & 3)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:09d3d855-104b-4d23-9733-cd19c88e22a3'
WHERE p.id = 9411 AND p.composer_id = 55
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:f9bc0110-6374-49fe-8379-73635f657d11'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:09d3d855-104b-4d23-9733-cd19c88e22a3'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 16, part.movement_number = NULL,
    part.name_ko = 'Tableau 2 (Ysaure''s Chamber): No. 2 (No. 4)', part.name_en = 'La Filleule des fées: Act I, Tableau 2 (Ysaure''s Chamber): No. 2 (No. 4)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 9411 AND p.composer_id = 55 AND part.part_key = 'musicbrainz:0ef0b71c-e929-4ccb-9afd-b9a0019281d5' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:0ef0b71c-e929-4ccb-9afd-b9a0019281d5', 16, NULL, 'Tableau 2 (Ysaure''s Chamber): No. 2 (No. 4)', 'La Filleule des fées: Act I, Tableau 2 (Ysaure''s Chamber): No. 2 (No. 4)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:09d3d855-104b-4d23-9733-cd19c88e22a3'
WHERE p.id = 9411 AND p.composer_id = 55
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:0ef0b71c-e929-4ccb-9afd-b9a0019281d5'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:09d3d855-104b-4d23-9733-cd19c88e22a3'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 17, part.movement_number = NULL,
    part.name_ko = 'Tableau 2 (Ysaure''s Chamber): No. 3 (No. 5)', part.name_en = 'La Filleule des fées: Act I, Tableau 2 (Ysaure''s Chamber): No. 3 (No. 5)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 9411 AND p.composer_id = 55 AND part.part_key = 'musicbrainz:c76ca3a3-62b4-415c-ac2e-902f5ba601fd' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:c76ca3a3-62b4-415c-ac2e-902f5ba601fd', 17, NULL, 'Tableau 2 (Ysaure''s Chamber): No. 3 (No. 5)', 'La Filleule des fées: Act I, Tableau 2 (Ysaure''s Chamber): No. 3 (No. 5)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:09d3d855-104b-4d23-9733-cd19c88e22a3'
WHERE p.id = 9411 AND p.composer_id = 55
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:c76ca3a3-62b4-415c-ac2e-902f5ba601fd'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:09d3d855-104b-4d23-9733-cd19c88e22a3'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 18, part.movement_number = NULL,
    part.name_ko = 'Tableau 2 (Ysaure''s Chamber): No. 4 (No. 6)', part.name_en = 'La Filleule des fées: Act I, Tableau 2 (Ysaure''s Chamber): No. 4 (No. 6)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 9411 AND p.composer_id = 55 AND part.part_key = 'musicbrainz:824d0c22-4d92-4307-9621-3683bc00ffa8' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:824d0c22-4d92-4307-9621-3683bc00ffa8', 18, NULL, 'Tableau 2 (Ysaure''s Chamber): No. 4 (No. 6)', 'La Filleule des fées: Act I, Tableau 2 (Ysaure''s Chamber): No. 4 (No. 6)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:09d3d855-104b-4d23-9733-cd19c88e22a3'
WHERE p.id = 9411 AND p.composer_id = 55
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:824d0c22-4d92-4307-9621-3683bc00ffa8'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:09d3d855-104b-4d23-9733-cd19c88e22a3'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 19, part.movement_number = NULL,
    part.name_ko = 'Tableau 2 (Ysaure''s Chamber): No. 5 (No. 7)', part.name_en = 'La Filleule des fées: Act I, Tableau 2 (Ysaure''s Chamber): No. 5 (No. 7)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 9411 AND p.composer_id = 55 AND part.part_key = 'musicbrainz:30695ace-04d7-4845-85b2-30ade830b33f' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:30695ace-04d7-4845-85b2-30ade830b33f', 19, NULL, 'Tableau 2 (Ysaure''s Chamber): No. 5 (No. 7)', 'La Filleule des fées: Act I, Tableau 2 (Ysaure''s Chamber): No. 5 (No. 7)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:09d3d855-104b-4d23-9733-cd19c88e22a3'
WHERE p.id = 9411 AND p.composer_id = 55
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:30695ace-04d7-4845-85b2-30ade830b33f'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:09d3d855-104b-4d23-9733-cd19c88e22a3'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 20, part.movement_number = NULL,
    part.name_ko = 'Tableau 2 (Ysaure''s Chamber): Entr''acte', part.name_en = 'La Filleule des fées: Act I, Tableau 2 (Ysaure''s Chamber): Entr''acte',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 9411 AND p.composer_id = 55 AND part.part_key = 'musicbrainz:31f80161-ce91-4ad7-94a2-98ae89025a90' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:31f80161-ce91-4ad7-94a2-98ae89025a90', 20, NULL, 'Tableau 2 (Ysaure''s Chamber): Entr''acte', 'La Filleule des fées: Act I, Tableau 2 (Ysaure''s Chamber): Entr''acte', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:09d3d855-104b-4d23-9733-cd19c88e22a3'
WHERE p.id = 9411 AND p.composer_id = 55
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:31f80161-ce91-4ad7-94a2-98ae89025a90'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = NULL,
    part.name_ko = 'Act II', part.name_en = 'La Filleule des fées: Act II',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 9411 AND p.composer_id = 55 AND part.part_key = 'musicbrainz:caee0930-8da3-4715-8271-4ca79539d544' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:caee0930-8da3-4715-8271-4ca79539d544', 3, NULL, 'Act II', 'La Filleule des fées: Act II', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 9411 AND p.composer_id = 55
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:caee0930-8da3-4715-8271-4ca79539d544'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:caee0930-8da3-4715-8271-4ca79539d544'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'Tableau 1 (A Wooded Park): No. 1', part.name_en = 'La Filleule des fées: Act II, Tableau 1 (A Wooded Park): No. 1',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 9411 AND p.composer_id = 55 AND part.part_key = 'musicbrainz:bb3f6695-0256-499d-9973-02d90325d64c' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:bb3f6695-0256-499d-9973-02d90325d64c', 1, NULL, 'Tableau 1 (A Wooded Park): No. 1', 'La Filleule des fées: Act II, Tableau 1 (A Wooded Park): No. 1', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:caee0930-8da3-4715-8271-4ca79539d544'
WHERE p.id = 9411 AND p.composer_id = 55
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:bb3f6695-0256-499d-9973-02d90325d64c'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:caee0930-8da3-4715-8271-4ca79539d544'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'Tableau 1 (A Wooded Park): No. 2', part.name_en = 'La Filleule des fées: Act II, Tableau 1 (A Wooded Park): No. 2',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 9411 AND p.composer_id = 55 AND part.part_key = 'musicbrainz:2f749de2-672a-4215-952e-2ffb505304d3' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:2f749de2-672a-4215-952e-2ffb505304d3', 2, NULL, 'Tableau 1 (A Wooded Park): No. 2', 'La Filleule des fées: Act II, Tableau 1 (A Wooded Park): No. 2', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:caee0930-8da3-4715-8271-4ca79539d544'
WHERE p.id = 9411 AND p.composer_id = 55
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:2f749de2-672a-4215-952e-2ffb505304d3'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:caee0930-8da3-4715-8271-4ca79539d544'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = NULL,
    part.name_ko = 'Tableau 1 (A Wooded Park): No. 3', part.name_en = 'La Filleule des fées: Act II, Tableau 1 (A Wooded Park): No. 3',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 9411 AND p.composer_id = 55 AND part.part_key = 'musicbrainz:f096f367-4422-41b2-99f8-88f49cb45bce' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:f096f367-4422-41b2-99f8-88f49cb45bce', 3, NULL, 'Tableau 1 (A Wooded Park): No. 3', 'La Filleule des fées: Act II, Tableau 1 (A Wooded Park): No. 3', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:caee0930-8da3-4715-8271-4ca79539d544'
WHERE p.id = 9411 AND p.composer_id = 55
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:f096f367-4422-41b2-99f8-88f49cb45bce'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:caee0930-8da3-4715-8271-4ca79539d544'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = NULL,
    part.name_ko = 'Tableau 1 (A Wooded Park): No. 4', part.name_en = 'La Filleule des fées: Act II, Tableau 1 (A Wooded Park): No. 4',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 9411 AND p.composer_id = 55 AND part.part_key = 'musicbrainz:f0d3cec5-9a02-4fb2-9aed-6c1b7c5f547e' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:f0d3cec5-9a02-4fb2-9aed-6c1b7c5f547e', 4, NULL, 'Tableau 1 (A Wooded Park): No. 4', 'La Filleule des fées: Act II, Tableau 1 (A Wooded Park): No. 4', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:caee0930-8da3-4715-8271-4ca79539d544'
WHERE p.id = 9411 AND p.composer_id = 55
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:f0d3cec5-9a02-4fb2-9aed-6c1b7c5f547e'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:caee0930-8da3-4715-8271-4ca79539d544'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 5, part.movement_number = NULL,
    part.name_ko = 'Tableau 1 (A Wooded Park): No. 4a (No. 5)', part.name_en = 'La Filleule des fées: Act II, Tableau 1 (A Wooded Park): No. 4a (No. 5)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 9411 AND p.composer_id = 55 AND part.part_key = 'musicbrainz:fe239f0f-3e40-401d-a456-2cc1cd697013' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:fe239f0f-3e40-401d-a456-2cc1cd697013', 5, NULL, 'Tableau 1 (A Wooded Park): No. 4a (No. 5)', 'La Filleule des fées: Act II, Tableau 1 (A Wooded Park): No. 4a (No. 5)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:caee0930-8da3-4715-8271-4ca79539d544'
WHERE p.id = 9411 AND p.composer_id = 55
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:fe239f0f-3e40-401d-a456-2cc1cd697013'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:caee0930-8da3-4715-8271-4ca79539d544'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 6, part.movement_number = NULL,
    part.name_ko = 'Tableau 1 (A Wooded Park): No. 4b (No. 6). Mlle Emarot (The White Fairy)', part.name_en = 'La Filleule des fées: Act II, Tableau 1 (A Wooded Park): No. 4b (No. 6). Mlle Emarot (The White Fairy)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 9411 AND p.composer_id = 55 AND part.part_key = 'musicbrainz:4ab81663-7ca5-48a0-ae3e-048d2b0fc2ca' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:4ab81663-7ca5-48a0-ae3e-048d2b0fc2ca', 6, NULL, 'Tableau 1 (A Wooded Park): No. 4b (No. 6). Mlle Emarot (The White Fairy)', 'La Filleule des fées: Act II, Tableau 1 (A Wooded Park): No. 4b (No. 6). Mlle Emarot (The White Fairy)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:caee0930-8da3-4715-8271-4ca79539d544'
WHERE p.id = 9411 AND p.composer_id = 55
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:4ab81663-7ca5-48a0-ae3e-048d2b0fc2ca'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:caee0930-8da3-4715-8271-4ca79539d544'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 7, part.movement_number = NULL,
    part.name_ko = 'Tableau 1 (A Wooded Park): No. 4c (No. 7). Mme Taglioni (The Pink Fairy)', part.name_en = 'La Filleule des fées: Act II, Tableau 1 (A Wooded Park): No. 4c (No. 7). Mme Taglioni (The Pink Fairy)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 9411 AND p.composer_id = 55 AND part.part_key = 'musicbrainz:6c668f5f-a157-417f-b094-18f07a1d206e' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:6c668f5f-a157-417f-b094-18f07a1d206e', 7, NULL, 'Tableau 1 (A Wooded Park): No. 4c (No. 7). Mme Taglioni (The Pink Fairy)', 'La Filleule des fées: Act II, Tableau 1 (A Wooded Park): No. 4c (No. 7). Mme Taglioni (The Pink Fairy)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:caee0930-8da3-4715-8271-4ca79539d544'
WHERE p.id = 9411 AND p.composer_id = 55
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:6c668f5f-a157-417f-b094-18f07a1d206e'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:caee0930-8da3-4715-8271-4ca79539d544'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 8, part.movement_number = NULL,
    part.name_ko = 'Tableau 1 (A Wooded Park): No. 4d (No. 8). Mme Taglioni (Flute Variation)', part.name_en = 'La Filleule des fées: Act II, Tableau 1 (A Wooded Park): No. 4d (No. 8). Mme Taglioni (Flute Variation)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 9411 AND p.composer_id = 55 AND part.part_key = 'musicbrainz:4c90a275-58a9-4fa6-9d60-cfa0b71576b5' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:4c90a275-58a9-4fa6-9d60-cfa0b71576b5', 8, NULL, 'Tableau 1 (A Wooded Park): No. 4d (No. 8). Mme Taglioni (Flute Variation)', 'La Filleule des fées: Act II, Tableau 1 (A Wooded Park): No. 4d (No. 8). Mme Taglioni (Flute Variation)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:caee0930-8da3-4715-8271-4ca79539d544'
WHERE p.id = 9411 AND p.composer_id = 55
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:4c90a275-58a9-4fa6-9d60-cfa0b71576b5'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:caee0930-8da3-4715-8271-4ca79539d544'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 9, part.movement_number = NULL,
    part.name_ko = 'Tableau 1 (A Wooded Park): No. 4e (No. 9). Mlle Carlotta Grisi (Ysaure)', part.name_en = 'La Filleule des fées: Act II, Tableau 1 (A Wooded Park): No. 4e (No. 9). Mlle Carlotta Grisi (Ysaure)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 9411 AND p.composer_id = 55 AND part.part_key = 'musicbrainz:def88837-08db-4034-af08-318b05e68ab8' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:def88837-08db-4034-af08-318b05e68ab8', 9, NULL, 'Tableau 1 (A Wooded Park): No. 4e (No. 9). Mlle Carlotta Grisi (Ysaure)', 'La Filleule des fées: Act II, Tableau 1 (A Wooded Park): No. 4e (No. 9). Mlle Carlotta Grisi (Ysaure)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:caee0930-8da3-4715-8271-4ca79539d544'
WHERE p.id = 9411 AND p.composer_id = 55
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:def88837-08db-4034-af08-318b05e68ab8'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:caee0930-8da3-4715-8271-4ca79539d544'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 10, part.movement_number = NULL,
    part.name_ko = 'Tableau 1 (A Wooded Park): No. 5', part.name_en = 'La Filleule des fées: Act II, Tableau 1 (A Wooded Park): No. 5',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 9411 AND p.composer_id = 55 AND part.part_key = 'musicbrainz:7759e6dd-3080-442f-96bb-04b20693cdd6' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:7759e6dd-3080-442f-96bb-04b20693cdd6', 10, NULL, 'Tableau 1 (A Wooded Park): No. 5', 'La Filleule des fées: Act II, Tableau 1 (A Wooded Park): No. 5', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:caee0930-8da3-4715-8271-4ca79539d544'
WHERE p.id = 9411 AND p.composer_id = 55
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:7759e6dd-3080-442f-96bb-04b20693cdd6'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:caee0930-8da3-4715-8271-4ca79539d544'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 11, part.movement_number = NULL,
    part.name_ko = 'Tableau 2 (A Deep Cavern): No. 1. Mouvement de Valse', part.name_en = 'La Filleule des fées: Act II, Tableau 2 (A Deep Cavern): No. 1. Mouvement de Valse',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 9411 AND p.composer_id = 55 AND part.part_key = 'musicbrainz:05be961e-5f81-4191-b565-e8efeccc385e' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:05be961e-5f81-4191-b565-e8efeccc385e', 11, NULL, 'Tableau 2 (A Deep Cavern): No. 1. Mouvement de Valse', 'La Filleule des fées: Act II, Tableau 2 (A Deep Cavern): No. 1. Mouvement de Valse', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:caee0930-8da3-4715-8271-4ca79539d544'
WHERE p.id = 9411 AND p.composer_id = 55
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:05be961e-5f81-4191-b565-e8efeccc385e'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:caee0930-8da3-4715-8271-4ca79539d544'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 12, part.movement_number = NULL,
    part.name_ko = 'Tableau 2 (A Deep Cavern): No. 2', part.name_en = 'La Filleule des fées: Act II, Tableau 2 (A Deep Cavern): No. 2',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 9411 AND p.composer_id = 55 AND part.part_key = 'musicbrainz:8f54aa78-a727-411a-afdb-9b24f49e9326' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:8f54aa78-a727-411a-afdb-9b24f49e9326', 12, NULL, 'Tableau 2 (A Deep Cavern): No. 2', 'La Filleule des fées: Act II, Tableau 2 (A Deep Cavern): No. 2', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:caee0930-8da3-4715-8271-4ca79539d544'
WHERE p.id = 9411 AND p.composer_id = 55
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:8f54aa78-a727-411a-afdb-9b24f49e9326'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:caee0930-8da3-4715-8271-4ca79539d544'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 13, part.movement_number = NULL,
    part.name_ko = 'Tableau 2 (A Deep Cavern): No. 3', part.name_en = 'La Filleule des fées: Act II, Tableau 2 (A Deep Cavern): No. 3',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 9411 AND p.composer_id = 55 AND part.part_key = 'musicbrainz:7a4bbe08-18cd-4c00-9d64-07c32d80af36' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:7a4bbe08-18cd-4c00-9d64-07c32d80af36', 13, NULL, 'Tableau 2 (A Deep Cavern): No. 3', 'La Filleule des fées: Act II, Tableau 2 (A Deep Cavern): No. 3', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:caee0930-8da3-4715-8271-4ca79539d544'
WHERE p.id = 9411 AND p.composer_id = 55
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:7a4bbe08-18cd-4c00-9d64-07c32d80af36'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:caee0930-8da3-4715-8271-4ca79539d544'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 14, part.movement_number = NULL,
    part.name_ko = 'Tableaux 3 & 4 (The Fairies'' Judgement and Paradise): No. 4. Scène dernière et Divertissement final', part.name_en = 'La Filleule des fées: Act II, Tableaux 3 & 4 (The Fairies'' Judgement and Paradise): No. 4. Scène dernière et Divertissement final',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 9411 AND p.composer_id = 55 AND part.part_key = 'musicbrainz:55420b47-0030-44c3-b4bb-027fe249e3fd' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:55420b47-0030-44c3-b4bb-027fe249e3fd', 14, NULL, 'Tableaux 3 & 4 (The Fairies'' Judgement and Paradise): No. 4. Scène dernière et Divertissement final', 'La Filleule des fées: Act II, Tableaux 3 & 4 (The Fairies'' Judgement and Paradise): No. 4. Scène dernière et Divertissement final', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:caee0930-8da3-4715-8271-4ca79539d544'
WHERE p.id = 9411 AND p.composer_id = 55
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:55420b47-0030-44c3-b4bb-027fe249e3fd'
);


-- None 발레 <La Jolie Fille de Gand>

UPDATE pieces piece
SET piece.title = '발레 <La Jolie Fille de Gand>', piece.title_en = 'La Jolie Fille de Gand',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 11009 AND piece.composer_id = 55
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'Introduction', part.name_en = 'La Jolie Fille de Gand: Introduction',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11009 AND p.composer_id = 55 AND part.part_key = 'musicbrainz:3dd37326-95ce-4278-bc83-98cd5d95ea43' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:3dd37326-95ce-4278-bc83-98cd5d95ea43', 1, NULL, 'Introduction', 'La Jolie Fille de Gand: Introduction', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 11009 AND p.composer_id = 55
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:3dd37326-95ce-4278-bc83-98cd5d95ea43'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'Act I', part.name_en = 'La Jolie Fille de Gand: Act I',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11009 AND p.composer_id = 55 AND part.part_key = 'musicbrainz:d1f0dce3-746c-4b0d-9753-d4de8925a502' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:d1f0dce3-746c-4b0d-9753-d4de8925a502', 2, NULL, 'Act I', 'La Jolie Fille de Gand: Act I', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 11009 AND p.composer_id = 55
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:d1f0dce3-746c-4b0d-9753-d4de8925a502'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = NULL,
    part.name_ko = 'Act II', part.name_en = 'La Jolie Fille de Gand: Act II',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11009 AND p.composer_id = 55 AND part.part_key = 'musicbrainz:3602c3dd-8419-4940-82ce-83d320ae7a1e' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:3602c3dd-8419-4940-82ce-83d320ae7a1e', 3, NULL, 'Act II', 'La Jolie Fille de Gand: Act II', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 11009 AND p.composer_id = 55
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:3602c3dd-8419-4940-82ce-83d320ae7a1e'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = NULL,
    part.name_ko = 'Act III', part.name_en = 'La Jolie Fille de Gand: Act III',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11009 AND p.composer_id = 55 AND part.part_key = 'musicbrainz:44a063f9-5f98-4f0c-80dd-030e6a260552' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:44a063f9-5f98-4f0c-80dd-030e6a260552', 4, NULL, 'Act III', 'La Jolie Fille de Gand: Act III', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 11009 AND p.composer_id = 55
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:44a063f9-5f98-4f0c-80dd-030e6a260552'
);


-- None 오페라 <La Poupée de Nuremberg>

UPDATE pieces piece
SET piece.title = '오페라 <La Poupée de Nuremberg>', piece.title_en = 'La Poupée de Nuremberg',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 9239 AND piece.composer_id = 55
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'Overture', part.name_en = 'La Poupée de Nuremberg: Overture',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 9239 AND p.composer_id = 55 AND part.part_key = 'musicbrainz:b28e40f2-7eb5-4c3f-94f0-a415c1d7d681' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:b28e40f2-7eb5-4c3f-94f0-a415c1d7d681', 1, NULL, 'Overture', 'La Poupée de Nuremberg: Overture', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 9239 AND p.composer_id = 55
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:b28e40f2-7eb5-4c3f-94f0-a415c1d7d681'
);


-- None Le Bijou perdu

UPDATE pieces piece
SET piece.title = 'Le Bijou perdu', piece.title_en = 'Le Bijou perdu',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 10217 AND piece.composer_id = 55
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'Acte III. Air de Toinon « Pour rester en cette demeure »', part.name_en = 'Le Bijou perdu : Acte III. Air de Toinon « Pour rester en cette demeure »',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 10217 AND p.composer_id = 55 AND part.part_key = 'musicbrainz:ea5f6932-bff0-42a4-8969-9e779d71db9b' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:ea5f6932-bff0-42a4-8969-9e779d71db9b', 1, NULL, 'Acte III. Air de Toinon « Pour rester en cette demeure »', 'Le Bijou perdu : Acte III. Air de Toinon « Pour rester en cette demeure »', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 10217 AND p.composer_id = 55
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:ea5f6932-bff0-42a4-8969-9e779d71db9b'
);


-- None 오페라 <Le Châlet>

UPDATE pieces piece
SET piece.title = '오페라 <Le Châlet>', piece.title_en = 'Le Châlet',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 10076 AND piece.composer_id = 55
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = '« Arrêtons-nous ici … Vallons de l''Hélvétie ” (Max)', part.name_en = 'Le Châlet : « Arrêtons-nous ici … Vallons de l''Hélvétie ” (Max)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 10076 AND p.composer_id = 55 AND part.part_key = 'musicbrainz:4f9a9d35-de19-412a-a39f-8a8e48fb44ca' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:4f9a9d35-de19-412a-a39f-8a8e48fb44ca', 1, NULL, '« Arrêtons-nous ici … Vallons de l''Hélvétie ” (Max)', 'Le Châlet : « Arrêtons-nous ici … Vallons de l''Hélvétie ” (Max)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 10076 AND p.composer_id = 55
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:4f9a9d35-de19-412a-a39f-8a8e48fb44ca'
);


-- None Le Corsaire: Act III. Action

UPDATE pieces piece
SET piece.title = 'Le Corsaire: Act III. Action', piece.title_en = 'Le Corsaire: Act III. Action',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 8078 AND piece.composer_id = 55
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None 오페라 <Le Farfadet>

UPDATE pieces piece
SET piece.title = '오페라 <Le Farfadet>', piece.title_en = 'Le Farfadet',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 10049 AND piece.composer_id = 55
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = '« Personne, en bas dans le moulin » (Le Lutin)', part.name_en = 'Le Farfadet : « Personne, en bas dans le moulin » (Le Lutin)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 10049 AND p.composer_id = 55 AND part.part_key = 'musicbrainz:41f54b2e-916c-45fa-98d1-054f9e85f46b' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:41f54b2e-916c-45fa-98d1-054f9e85f46b', 1, NULL, '« Personne, en bas dans le moulin » (Le Lutin)', 'Le Farfadet : « Personne, en bas dans le moulin » (Le Lutin)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 10049 AND p.composer_id = 55
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:41f54b2e-916c-45fa-98d1-054f9e85f46b'
);


-- None Le Retour à la montagne

UPDATE pieces piece
SET piece.title = 'Le Retour à la montagne', piece.title_en = 'Le Retour à la montagne',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 10498 AND piece.composer_id = 55
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None 오페라 <Le Toréador>

UPDATE pieces piece
SET piece.title = '오페라 <Le Toréador>', piece.title_en = 'Le Toréador',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 7514 AND piece.composer_id = 55
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'Ouverture', part.name_en = 'Le Toréador: Ouverture',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 7514 AND p.composer_id = 55 AND part.part_key = 'musicbrainz:525aa06c-bdb5-422f-9d8a-2054b833b104' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:525aa06c-bdb5-422f-9d8a-2054b833b104', 1, NULL, 'Ouverture', 'Le Toréador: Ouverture', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 7514 AND p.composer_id = 55
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:525aa06c-bdb5-422f-9d8a-2054b833b104'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'Acte I', part.name_en = 'Le Toréador: Acte I',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 7514 AND p.composer_id = 55 AND part.part_key = 'musicbrainz:618f8a58-8325-44de-9ba2-dfa426670996' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:618f8a58-8325-44de-9ba2-dfa426670996', 2, NULL, 'Acte I', 'Le Toréador: Acte I', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 7514 AND p.composer_id = 55
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:618f8a58-8325-44de-9ba2-dfa426670996'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:618f8a58-8325-44de-9ba2-dfa426670996'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'Act I. "Je tremble et doute" (Coraline)', part.name_en = 'Le Toréador: Act I. "Je tremble et doute" (Coraline)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 7514 AND p.composer_id = 55 AND part.part_key = 'musicbrainz:0532373c-6c3d-46ad-89c3-bac1f3f07527' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:0532373c-6c3d-46ad-89c3-bac1f3f07527', 1, NULL, 'Act I. "Je tremble et doute" (Coraline)', 'Le Toréador: Act I. "Je tremble et doute" (Coraline)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:618f8a58-8325-44de-9ba2-dfa426670996'
WHERE p.id = 7514 AND p.composer_id = 55
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:0532373c-6c3d-46ad-89c3-bac1f3f07527'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:618f8a58-8325-44de-9ba2-dfa426670996'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'Act I. "Oui, la vie" (Belflor)', part.name_en = 'Le Toréador: Act I. "Oui, la vie" (Belflor)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 7514 AND p.composer_id = 55 AND part.part_key = 'musicbrainz:0aac010a-e028-4cac-8da4-7fa45f3409bc' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:0aac010a-e028-4cac-8da4-7fa45f3409bc', 2, NULL, 'Act I. "Oui, la vie" (Belflor)', 'Le Toréador: Act I. "Oui, la vie" (Belflor)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:618f8a58-8325-44de-9ba2-dfa426670996'
WHERE p.id = 7514 AND p.composer_id = 55
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:0aac010a-e028-4cac-8da4-7fa45f3409bc'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:618f8a58-8325-44de-9ba2-dfa426670996'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = NULL,
    part.name_ko = 'Act I. "Il part! Il est parti!" (Coraline)', part.name_en = 'Le Toréador: Act I. "Il part! Il est parti!" (Coraline)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 7514 AND p.composer_id = 55 AND part.part_key = 'musicbrainz:17e920f1-a0fe-4bf5-a426-55f21638fbc5' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:17e920f1-a0fe-4bf5-a426-55f21638fbc5', 3, NULL, 'Act I. "Il part! Il est parti!" (Coraline)', 'Le Toréador: Act I. "Il part! Il est parti!" (Coraline)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:618f8a58-8325-44de-9ba2-dfa426670996'
WHERE p.id = 7514 AND p.composer_id = 55
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:17e920f1-a0fe-4bf5-a426-55f21638fbc5'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:618f8a58-8325-44de-9ba2-dfa426670996'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = NULL,
    part.name_ko = 'Act I. "Ah! la flȗte!" (Coraline)', part.name_en = 'Le Toréador: Act I. "Ah! la flȗte!" (Coraline)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 7514 AND p.composer_id = 55 AND part.part_key = 'musicbrainz:209d06d7-23a0-4521-8d1c-530e9c37b1bf' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:209d06d7-23a0-4521-8d1c-530e9c37b1bf', 4, NULL, 'Act I. "Ah! la flȗte!" (Coraline)', 'Le Toréador: Act I. "Ah! la flȗte!" (Coraline)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:618f8a58-8325-44de-9ba2-dfa426670996'
WHERE p.id = 7514 AND p.composer_id = 55
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:209d06d7-23a0-4521-8d1c-530e9c37b1bf'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:618f8a58-8325-44de-9ba2-dfa426670996'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 5, part.movement_number = NULL,
    part.name_ko = 'Act I. "Vive la bouteille" (Belflor)', part.name_en = 'Le Toréador: Act I. "Vive la bouteille" (Belflor)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 7514 AND p.composer_id = 55 AND part.part_key = 'musicbrainz:22918dfd-2874-4e08-ac65-b5aa9346d350' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:22918dfd-2874-4e08-ac65-b5aa9346d350', 5, NULL, 'Act I. "Vive la bouteille" (Belflor)', 'Le Toréador: Act I. "Vive la bouteille" (Belflor)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:618f8a58-8325-44de-9ba2-dfa426670996'
WHERE p.id = 7514 AND p.composer_id = 55
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:22918dfd-2874-4e08-ac65-b5aa9346d350'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:618f8a58-8325-44de-9ba2-dfa426670996'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 6, part.movement_number = NULL,
    part.name_ko = 'Act I. "Tandis que tout sommeille" (Coraline)', part.name_en = 'Le Toréador: Act I. "Tandis que tout sommeille" (Coraline)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 7514 AND p.composer_id = 55 AND part.part_key = 'musicbrainz:2caf61fd-5bac-430e-a723-251a3e43015e' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:2caf61fd-5bac-430e-a723-251a3e43015e', 6, NULL, 'Act I. "Tandis que tout sommeille" (Coraline)', 'Le Toréador: Act I. "Tandis que tout sommeille" (Coraline)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:618f8a58-8325-44de-9ba2-dfa426670996'
WHERE p.id = 7514 AND p.composer_id = 55
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:2caf61fd-5bac-430e-a723-251a3e43015e'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:618f8a58-8325-44de-9ba2-dfa426670996'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 7, part.movement_number = NULL,
    part.name_ko = 'Act I. "Qu''est-ce là?" (Coraline)', part.name_en = 'Le Toréador: Act I. "Qu''est-ce là?" (Coraline)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 7514 AND p.composer_id = 55 AND part.part_key = 'musicbrainz:2cbf1270-b68e-4bb7-afaa-89b61775c1a7' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:2cbf1270-b68e-4bb7-afaa-89b61775c1a7', 7, NULL, 'Act I. "Qu''est-ce là?" (Coraline)', 'Le Toréador: Act I. "Qu''est-ce là?" (Coraline)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:618f8a58-8325-44de-9ba2-dfa426670996'
WHERE p.id = 7514 AND p.composer_id = 55
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:2cbf1270-b68e-4bb7-afaa-89b61775c1a7'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:618f8a58-8325-44de-9ba2-dfa426670996'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 8, part.movement_number = NULL,
    part.name_ko = 'Acte I. "Ah ! vous dirai-je, maman" (Coraline)', part.name_en = 'Le Toréador: Acte I. "Ah ! vous dirai-je, maman" (Coraline)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 7514 AND p.composer_id = 55 AND part.part_key = 'musicbrainz:31606e20-c17e-44b1-a6ce-a22fa6bcef81' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:31606e20-c17e-44b1-a6ce-a22fa6bcef81', 8, NULL, 'Acte I. "Ah ! vous dirai-je, maman" (Coraline)', 'Le Toréador: Acte I. "Ah ! vous dirai-je, maman" (Coraline)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:618f8a58-8325-44de-9ba2-dfa426670996'
WHERE p.id = 7514 AND p.composer_id = 55
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:31606e20-c17e-44b1-a6ce-a22fa6bcef81'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:618f8a58-8325-44de-9ba2-dfa426670996'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 9, part.movement_number = NULL,
    part.name_ko = 'Act I. "Donc, je lui disais" (Tracolin)', part.name_en = 'Le Toréador: Act I. "Donc, je lui disais" (Tracolin)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 7514 AND p.composer_id = 55 AND part.part_key = 'musicbrainz:3567e59c-d18f-477e-988b-17ea8efa4c57' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:3567e59c-d18f-477e-988b-17ea8efa4c57', 9, NULL, 'Act I. "Donc, je lui disais" (Tracolin)', 'Le Toréador: Act I. "Donc, je lui disais" (Tracolin)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:618f8a58-8325-44de-9ba2-dfa426670996'
WHERE p.id = 7514 AND p.composer_id = 55
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:3567e59c-d18f-477e-988b-17ea8efa4c57'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:618f8a58-8325-44de-9ba2-dfa426670996'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 10, part.movement_number = NULL,
    part.name_ko = 'Act I. "Vous connaissez de ces femmes" (Tracolin)', part.name_en = 'Le Toréador: Act I. "Vous connaissez de ces femmes" (Tracolin)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 7514 AND p.composer_id = 55 AND part.part_key = 'musicbrainz:478f2c27-9343-4c3f-a96e-f827f6925159' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:478f2c27-9343-4c3f-a96e-f827f6925159', 10, NULL, 'Act I. "Vous connaissez de ces femmes" (Tracolin)', 'Le Toréador: Act I. "Vous connaissez de ces femmes" (Tracolin)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:618f8a58-8325-44de-9ba2-dfa426670996'
WHERE p.id = 7514 AND p.composer_id = 55
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:478f2c27-9343-4c3f-a96e-f827f6925159'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:618f8a58-8325-44de-9ba2-dfa426670996'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 11, part.movement_number = NULL,
    part.name_ko = 'Act I. "Je réponds! "Jeune homme..."" (Coraline)', part.name_en = 'Le Toréador: Act I. "Je réponds! "Jeune homme..."" (Coraline)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 7514 AND p.composer_id = 55 AND part.part_key = 'musicbrainz:55bdeb29-7933-4396-a69c-0eef167f7036' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:55bdeb29-7933-4396-a69c-0eef167f7036', 11, NULL, 'Act I. "Je réponds! "Jeune homme..."" (Coraline)', 'Le Toréador: Act I. "Je réponds! "Jeune homme..."" (Coraline)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:618f8a58-8325-44de-9ba2-dfa426670996'
WHERE p.id = 7514 AND p.composer_id = 55
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:55bdeb29-7933-4396-a69c-0eef167f7036'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:618f8a58-8325-44de-9ba2-dfa426670996'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 12, part.movement_number = NULL,
    part.name_ko = 'Act I. "Une galante affaire m''amène ici" (Tracolin)', part.name_en = 'Le Toréador: Act I. "Une galante affaire m''amène ici" (Tracolin)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 7514 AND p.composer_id = 55 AND part.part_key = 'musicbrainz:56e1e4c0-c68f-41dc-b6e9-27c188cf5f6a' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:56e1e4c0-c68f-41dc-b6e9-27c188cf5f6a', 12, NULL, 'Act I. "Une galante affaire m''amène ici" (Tracolin)', 'Le Toréador: Act I. "Une galante affaire m''amène ici" (Tracolin)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:618f8a58-8325-44de-9ba2-dfa426670996'
WHERE p.id = 7514 AND p.composer_id = 55
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:56e1e4c0-c68f-41dc-b6e9-27c188cf5f6a'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:618f8a58-8325-44de-9ba2-dfa426670996'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 13, part.movement_number = NULL,
    part.name_ko = 'Act I. "Il se pourrait!" (Coraline)', part.name_en = 'Le Toréador: Act I. "Il se pourrait!" (Coraline)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 7514 AND p.composer_id = 55 AND part.part_key = 'musicbrainz:a90db4e9-2968-411b-8a07-b3bcd7274db5' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:a90db4e9-2968-411b-8a07-b3bcd7274db5', 13, NULL, 'Act I. "Il se pourrait!" (Coraline)', 'Le Toréador: Act I. "Il se pourrait!" (Coraline)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:618f8a58-8325-44de-9ba2-dfa426670996'
WHERE p.id = 7514 AND p.composer_id = 55
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:a90db4e9-2968-411b-8a07-b3bcd7274db5'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:618f8a58-8325-44de-9ba2-dfa426670996'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 14, part.movement_number = NULL,
    part.name_ko = 'Act I. "Elle est partie!" (Belflor)', part.name_en = 'Le Toréador: Act I. "Elle est partie!" (Belflor)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 7514 AND p.composer_id = 55 AND part.part_key = 'musicbrainz:d4d77d4d-efaf-4bb2-b5f0-3910ac6fb12d' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:d4d77d4d-efaf-4bb2-b5f0-3910ac6fb12d', 14, NULL, 'Act I. "Elle est partie!" (Belflor)', 'Le Toréador: Act I. "Elle est partie!" (Belflor)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:618f8a58-8325-44de-9ba2-dfa426670996'
WHERE p.id = 7514 AND p.composer_id = 55
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:d4d77d4d-efaf-4bb2-b5f0-3910ac6fb12d'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:618f8a58-8325-44de-9ba2-dfa426670996'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 15, part.movement_number = NULL,
    part.name_ko = 'Act I. "Ah! voici les accords de la flute fidele" (Coraline)', part.name_en = 'Le Toréador: Act I. "Ah! voici les accords de la flute fidele" (Coraline)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 7514 AND p.composer_id = 55 AND part.part_key = 'musicbrainz:e8e60680-caa7-4609-89b8-cfc50ae0d7fe' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:e8e60680-caa7-4609-89b8-cfc50ae0d7fe', 15, NULL, 'Act I. "Ah! voici les accords de la flute fidele" (Coraline)', 'Le Toréador: Act I. "Ah! voici les accords de la flute fidele" (Coraline)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:618f8a58-8325-44de-9ba2-dfa426670996'
WHERE p.id = 7514 AND p.composer_id = 55
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:e8e60680-caa7-4609-89b8-cfc50ae0d7fe'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:618f8a58-8325-44de-9ba2-dfa426670996'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 16, part.movement_number = NULL,
    part.name_ko = 'Act I. "Charmant, charmant!" (Belflor)', part.name_en = 'Le Toréador: Act I. "Charmant, charmant!" (Belflor)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 7514 AND p.composer_id = 55 AND part.part_key = 'musicbrainz:fc85c7e8-21d5-41c5-8f94-8140c4ea0791' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:fc85c7e8-21d5-41c5-8f94-8140c4ea0791', 16, NULL, 'Act I. "Charmant, charmant!" (Belflor)', 'Le Toréador: Act I. "Charmant, charmant!" (Belflor)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:618f8a58-8325-44de-9ba2-dfa426670996'
WHERE p.id = 7514 AND p.composer_id = 55
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:fc85c7e8-21d5-41c5-8f94-8140c4ea0791'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = NULL,
    part.name_ko = 'Entr''acte', part.name_en = 'Le Toréador: Entr''acte',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 7514 AND p.composer_id = 55 AND part.part_key = 'musicbrainz:0335dd87-ce0c-4854-aed4-98ce4691a56e' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:0335dd87-ce0c-4854-aed4-98ce4691a56e', 3, NULL, 'Entr''acte', 'Le Toréador: Entr''acte', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 7514 AND p.composer_id = 55
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:0335dd87-ce0c-4854-aed4-98ce4691a56e'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = NULL,
    part.name_ko = 'Acte II', part.name_en = 'Le Toréador: Acte II',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 7514 AND p.composer_id = 55 AND part.part_key = 'musicbrainz:48184ea2-b1df-4fbb-922b-b0fcd7388f59' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:48184ea2-b1df-4fbb-922b-b0fcd7388f59', 4, NULL, 'Acte II', 'Le Toréador: Acte II', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 7514 AND p.composer_id = 55
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:48184ea2-b1df-4fbb-922b-b0fcd7388f59'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:48184ea2-b1df-4fbb-922b-b0fcd7388f59'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'Act II. "Bonjour, c''est moi" (Tracolin)', part.name_en = 'Le Toréador: Act II. "Bonjour, c''est moi" (Tracolin)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 7514 AND p.composer_id = 55 AND part.part_key = 'musicbrainz:2a8b07a4-9238-4a38-b311-21dd5d973ef0' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:2a8b07a4-9238-4a38-b311-21dd5d973ef0', 1, NULL, 'Act II. "Bonjour, c''est moi" (Tracolin)', 'Le Toréador: Act II. "Bonjour, c''est moi" (Tracolin)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:48184ea2-b1df-4fbb-922b-b0fcd7388f59'
WHERE p.id = 7514 AND p.composer_id = 55
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:2a8b07a4-9238-4a38-b311-21dd5d973ef0'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:48184ea2-b1df-4fbb-922b-b0fcd7388f59'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'Act II. "Dans une symphonie" (Tracolin)', part.name_en = 'Le Toréador: Act II. "Dans une symphonie" (Tracolin)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 7514 AND p.composer_id = 55 AND part.part_key = 'musicbrainz:40a1f4e7-dd0d-473f-8ef6-36620606198b' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:40a1f4e7-dd0d-473f-8ef6-36620606198b', 2, NULL, 'Act II. "Dans une symphonie" (Tracolin)', 'Le Toréador: Act II. "Dans une symphonie" (Tracolin)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:48184ea2-b1df-4fbb-922b-b0fcd7388f59'
WHERE p.id = 7514 AND p.composer_id = 55
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:40a1f4e7-dd0d-473f-8ef6-36620606198b'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:48184ea2-b1df-4fbb-922b-b0fcd7388f59'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = NULL,
    part.name_ko = 'Act II. "Il vient à mon secours!" (Coraline)', part.name_en = 'Le Toréador: Act II. "Il vient à mon secours!" (Coraline)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 7514 AND p.composer_id = 55 AND part.part_key = 'musicbrainz:4150eda0-7a98-4848-9f8b-b9c12b503377' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:4150eda0-7a98-4848-9f8b-b9c12b503377', 3, NULL, 'Act II. "Il vient à mon secours!" (Coraline)', 'Le Toréador: Act II. "Il vient à mon secours!" (Coraline)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:48184ea2-b1df-4fbb-922b-b0fcd7388f59'
WHERE p.id = 7514 AND p.composer_id = 55
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:4150eda0-7a98-4848-9f8b-b9c12b503377'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:48184ea2-b1df-4fbb-922b-b0fcd7388f59'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = NULL,
    part.name_ko = 'Act II. "Vraiment! Je le sais bien" (Coraline)', part.name_en = 'Le Toréador: Act II. "Vraiment! Je le sais bien" (Coraline)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 7514 AND p.composer_id = 55 AND part.part_key = 'musicbrainz:58714761-b87f-4245-85a4-c0d0a4ad0f33' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:58714761-b87f-4245-85a4-c0d0a4ad0f33', 4, NULL, 'Act II. "Vraiment! Je le sais bien" (Coraline)', 'Le Toréador: Act II. "Vraiment! Je le sais bien" (Coraline)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:48184ea2-b1df-4fbb-922b-b0fcd7388f59'
WHERE p.id = 7514 AND p.composer_id = 55
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:58714761-b87f-4245-85a4-c0d0a4ad0f33'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:48184ea2-b1df-4fbb-922b-b0fcd7388f59'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 5, part.movement_number = NULL,
    part.name_ko = 'Act II. "Ah! tremblez" (Coraline)', part.name_en = 'Le Toréador: Act II. "Ah! tremblez" (Coraline)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 7514 AND p.composer_id = 55 AND part.part_key = 'musicbrainz:8c8ee7f2-61a1-435e-9f99-266cfe7aa48a' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:8c8ee7f2-61a1-435e-9f99-266cfe7aa48a', 5, NULL, 'Act II. "Ah! tremblez" (Coraline)', 'Le Toréador: Act II. "Ah! tremblez" (Coraline)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:48184ea2-b1df-4fbb-922b-b0fcd7388f59'
WHERE p.id = 7514 AND p.composer_id = 55
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:8c8ee7f2-61a1-435e-9f99-266cfe7aa48a'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:48184ea2-b1df-4fbb-922b-b0fcd7388f59'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 6, part.movement_number = NULL,
    part.name_ko = 'Act II. "Car la femme, sans cesse" (Coraline)', part.name_en = 'Le Toréador: Act II. "Car la femme, sans cesse" (Coraline)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 7514 AND p.composer_id = 55 AND part.part_key = 'musicbrainz:a75fa20e-8f57-4132-aad8-058eefab022a' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:a75fa20e-8f57-4132-aad8-058eefab022a', 6, NULL, 'Act II. "Car la femme, sans cesse" (Coraline)', 'Le Toréador: Act II. "Car la femme, sans cesse" (Coraline)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:48184ea2-b1df-4fbb-922b-b0fcd7388f59'
WHERE p.id = 7514 AND p.composer_id = 55
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:a75fa20e-8f57-4132-aad8-058eefab022a'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:48184ea2-b1df-4fbb-922b-b0fcd7388f59'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 7, part.movement_number = NULL,
    part.name_ko = 'Act II. "Vous ici!" (Coraline)', part.name_en = 'Le Toréador: Act II. "Vous ici!" (Coraline)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 7514 AND p.composer_id = 55 AND part.part_key = 'musicbrainz:b2c28b3e-9f02-4b39-8794-61e025fde528' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:b2c28b3e-9f02-4b39-8794-61e025fde528', 7, NULL, 'Act II. "Vous ici!" (Coraline)', 'Le Toréador: Act II. "Vous ici!" (Coraline)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:48184ea2-b1df-4fbb-922b-b0fcd7388f59'
WHERE p.id = 7514 AND p.composer_id = 55
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:b2c28b3e-9f02-4b39-8794-61e025fde528'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:48184ea2-b1df-4fbb-922b-b0fcd7388f59'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 8, part.movement_number = NULL,
    part.name_ko = 'Act II. "Avec son petit air" (Coraline)', part.name_en = 'Le Toréador: Act II. "Avec son petit air" (Coraline)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 7514 AND p.composer_id = 55 AND part.part_key = 'musicbrainz:c346a4a1-6a73-4fea-a2b0-606c1f89b98e' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:c346a4a1-6a73-4fea-a2b0-606c1f89b98e', 8, NULL, 'Act II. "Avec son petit air" (Coraline)', 'Le Toréador: Act II. "Avec son petit air" (Coraline)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:48184ea2-b1df-4fbb-922b-b0fcd7388f59'
WHERE p.id = 7514 AND p.composer_id = 55
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:c346a4a1-6a73-4fea-a2b0-606c1f89b98e'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:48184ea2-b1df-4fbb-922b-b0fcd7388f59'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 9, part.movement_number = NULL,
    part.name_ko = 'Act II. "Dans vos regards" (Tracolin)', part.name_en = 'Le Toréador: Act II. "Dans vos regards" (Tracolin)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 7514 AND p.composer_id = 55 AND part.part_key = 'musicbrainz:d743e5c5-d837-463d-a11e-d4040cb37cf1' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:d743e5c5-d837-463d-a11e-d4040cb37cf1', 9, NULL, 'Act II. "Dans vos regards" (Tracolin)', 'Le Toréador: Act II. "Dans vos regards" (Tracolin)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:48184ea2-b1df-4fbb-922b-b0fcd7388f59'
WHERE p.id = 7514 AND p.composer_id = 55
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:d743e5c5-d837-463d-a11e-d4040cb37cf1'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:48184ea2-b1df-4fbb-922b-b0fcd7388f59'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 10, part.movement_number = NULL,
    part.name_ko = 'Act II. "En vain je me creuse la tȇte" (Coraline)', part.name_en = 'Le Toréador: Act II. "En vain je me creuse la tȇte" (Coraline)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 7514 AND p.composer_id = 55 AND part.part_key = 'musicbrainz:fde7d18e-0b79-4ff0-a6db-257f5ab0baad' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:fde7d18e-0b79-4ff0-a6db-257f5ab0baad', 10, NULL, 'Act II. "En vain je me creuse la tȇte" (Coraline)', 'Le Toréador: Act II. "En vain je me creuse la tȇte" (Coraline)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:48184ea2-b1df-4fbb-922b-b0fcd7388f59'
WHERE p.id = 7514 AND p.composer_id = 55
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:fde7d18e-0b79-4ff0-a6db-257f5ab0baad'
);


-- None 오페라 <Le postillon de Lonjumeau>

UPDATE pieces piece
SET piece.title = '오페라 <Le postillon de Lonjumeau>', piece.title_en = 'Le postillon de Lonjumeau',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 7528 AND piece.composer_id = 55
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'Le Postillon de Lonjumeau. Ouverture', part.name_en = 'Le Postillon de Lonjumeau. Ouverture',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 7528 AND p.composer_id = 55 AND part.part_key = 'musicbrainz:e51b6f62-7378-4418-9978-fc64235e0a3d' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:e51b6f62-7378-4418-9978-fc64235e0a3d', 1, NULL, 'Le Postillon de Lonjumeau. Ouverture', 'Le Postillon de Lonjumeau. Ouverture', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 7528 AND p.composer_id = 55
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:e51b6f62-7378-4418-9978-fc64235e0a3d'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'Acte I', part.name_en = 'Le Postillon de Lonjumeau: Acte I',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 7528 AND p.composer_id = 55 AND part.part_key = 'musicbrainz:df72da08-775f-481b-aac2-c334a074f18c' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:df72da08-775f-481b-aac2-c334a074f18c', 2, NULL, 'Acte I', 'Le Postillon de Lonjumeau: Acte I', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 7528 AND p.composer_id = 55
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:df72da08-775f-481b-aac2-c334a074f18c'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:df72da08-775f-481b-aac2-c334a074f18c'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'Le Postillon de Lonjumeau, Acte I. "Eh bien! ma bonne Madeleine" (Chapelou, Madeleine)', part.name_en = 'Le Postillon de Lonjumeau, Acte I. "Eh bien! ma bonne Madeleine" (Chapelou, Madeleine)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 7528 AND p.composer_id = 55 AND part.part_key = 'musicbrainz:0e709aa2-04e9-4d68-a7de-7d99437a23e1' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:0e709aa2-04e9-4d68-a7de-7d99437a23e1', 1, NULL, 'Le Postillon de Lonjumeau, Acte I. "Eh bien! ma bonne Madeleine" (Chapelou, Madeleine)', 'Le Postillon de Lonjumeau, Acte I. "Eh bien! ma bonne Madeleine" (Chapelou, Madeleine)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:df72da08-775f-481b-aac2-c334a074f18c'
WHERE p.id = 7528 AND p.composer_id = 55
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:0e709aa2-04e9-4d68-a7de-7d99437a23e1'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:df72da08-775f-481b-aac2-c334a074f18c'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'Le Postillon de Lonjumeau, Acte I. "Le joli mariage!" (Le Chœur, Chapelou, Madeleine, Les Paysannes, Les Paysans)', part.name_en = 'Le Postillon de Lonjumeau, Acte I. "Le joli mariage!" (Le Chœur, Chapelou, Madeleine, Les Paysannes, Les Paysans)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 7528 AND p.composer_id = 55 AND part.part_key = 'musicbrainz:18cbb9a4-7195-4f32-808f-56f7899dbf35' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:18cbb9a4-7195-4f32-808f-56f7899dbf35', 2, NULL, 'Le Postillon de Lonjumeau, Acte I. "Le joli mariage!" (Le Chœur, Chapelou, Madeleine, Les Paysannes, Les Paysans)', 'Le Postillon de Lonjumeau, Acte I. "Le joli mariage!" (Le Chœur, Chapelou, Madeleine, Les Paysannes, Les Paysans)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:df72da08-775f-481b-aac2-c334a074f18c'
WHERE p.id = 7528 AND p.composer_id = 55
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:18cbb9a4-7195-4f32-808f-56f7899dbf35'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:df72da08-775f-481b-aac2-c334a074f18c'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = NULL,
    part.name_ko = 'Le Postillon de Lonjumeau, Acte I. "Quoi, tous les deux!" (Madeleine, Chapelou)', part.name_en = 'Le Postillon de Lonjumeau, Acte I. "Quoi, tous les deux!" (Madeleine, Chapelou)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 7528 AND p.composer_id = 55 AND part.part_key = 'musicbrainz:19ade3ee-59bc-4079-a74c-6f58eda18b98' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:19ade3ee-59bc-4079-a74c-6f58eda18b98', 3, NULL, 'Le Postillon de Lonjumeau, Acte I. "Quoi, tous les deux!" (Madeleine, Chapelou)', 'Le Postillon de Lonjumeau, Acte I. "Quoi, tous les deux!" (Madeleine, Chapelou)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:df72da08-775f-481b-aac2-c334a074f18c'
WHERE p.id = 7528 AND p.composer_id = 55
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:19ade3ee-59bc-4079-a74c-6f58eda18b98'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:df72da08-775f-481b-aac2-c334a074f18c'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = NULL,
    part.name_ko = 'Le Postillon de Lonjumeau, Acte I. "Très bien... il paraît que vous êtes pressés..." (Biju, Chapelou, Madeleine, Le Marquis)', part.name_en = 'Le Postillon de Lonjumeau, Acte I. "Très bien... il paraît que vous êtes pressés..." (Biju, Chapelou, Madeleine, Le Marquis)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 7528 AND p.composer_id = 55 AND part.part_key = 'musicbrainz:2ccfd332-a6c7-4ce9-b499-feb9b1a46b35' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:2ccfd332-a6c7-4ce9-b499-feb9b1a46b35', 4, NULL, 'Le Postillon de Lonjumeau, Acte I. "Très bien... il paraît que vous êtes pressés..." (Biju, Chapelou, Madeleine, Le Marquis)', 'Le Postillon de Lonjumeau, Acte I. "Très bien... il paraît que vous êtes pressés..." (Biju, Chapelou, Madeleine, Le Marquis)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:df72da08-775f-481b-aac2-c334a074f18c'
WHERE p.id = 7528 AND p.composer_id = 55
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:2ccfd332-a6c7-4ce9-b499-feb9b1a46b35'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:df72da08-775f-481b-aac2-c334a074f18c'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 5, part.movement_number = NULL,
    part.name_ko = 'Le Postillon de Lonjumeau, Acte I. "Jeunes époux, voici l''heure fortunéë (Le Chœur, chapelou, Les Paysans, Les Paysannes)', part.name_en = 'Le Postillon de Lonjumeau, Acte I. "Jeunes époux, voici l''heure fortunéë (Le Chœur, chapelou, Les Paysans, Les Paysannes)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 7528 AND p.composer_id = 55 AND part.part_key = 'musicbrainz:8c9cb91c-5164-41d2-9623-d7829ad1eb02' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:8c9cb91c-5164-41d2-9623-d7829ad1eb02', 5, NULL, 'Le Postillon de Lonjumeau, Acte I. "Jeunes époux, voici l''heure fortunéë (Le Chœur, chapelou, Les Paysans, Les Paysannes)', 'Le Postillon de Lonjumeau, Acte I. "Jeunes époux, voici l''heure fortunéë (Le Chœur, chapelou, Les Paysans, Les Paysannes)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:df72da08-775f-481b-aac2-c334a074f18c'
WHERE p.id = 7528 AND p.composer_id = 55
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:8c9cb91c-5164-41d2-9623-d7829ad1eb02'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:df72da08-775f-481b-aac2-c334a074f18c'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 6, part.movement_number = NULL,
    part.name_ko = 'Le Postillon de Lonjumeau, Acte I. "A mes désirs, il faut te rendre" (Le Marquis, Chapelou, Biju, Madeleine, Le Chœur, Tous)', part.name_en = 'Le Postillon de Lonjumeau, Acte I. "A mes désirs, il faut te rendre" (Le Marquis, Chapelou, Biju, Madeleine, Le Chœur, Tous)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 7528 AND p.composer_id = 55 AND part.part_key = 'musicbrainz:c6f1ba1f-ea42-4d1b-8d4c-bcc383f7ce11' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:c6f1ba1f-ea42-4d1b-8d4c-bcc383f7ce11', 6, NULL, 'Le Postillon de Lonjumeau, Acte I. "A mes désirs, il faut te rendre" (Le Marquis, Chapelou, Biju, Madeleine, Le Chœur, Tous)', 'Le Postillon de Lonjumeau, Acte I. "A mes désirs, il faut te rendre" (Le Marquis, Chapelou, Biju, Madeleine, Le Chœur, Tous)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:df72da08-775f-481b-aac2-c334a074f18c'
WHERE p.id = 7528 AND p.composer_id = 55
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:c6f1ba1f-ea42-4d1b-8d4c-bcc383f7ce11'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:df72da08-775f-481b-aac2-c334a074f18c'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 7, part.movement_number = NULL,
    part.name_ko = 'Le Postillon de Lonjumeau, Acte I. "Un mot, mon garçon..." (Le Marquis, Chapelou)', part.name_en = 'Le Postillon de Lonjumeau, Acte I. "Un mot, mon garçon..." (Le Marquis, Chapelou)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 7528 AND p.composer_id = 55 AND part.part_key = 'musicbrainz:d4e94a9e-0b9f-4191-9026-c1b2a159d537' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:d4e94a9e-0b9f-4191-9026-c1b2a159d537', 7, NULL, 'Le Postillon de Lonjumeau, Acte I. "Un mot, mon garçon..." (Le Marquis, Chapelou)', 'Le Postillon de Lonjumeau, Acte I. "Un mot, mon garçon..." (Le Marquis, Chapelou)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:df72da08-775f-481b-aac2-c334a074f18c'
WHERE p.id = 7528 AND p.composer_id = 55
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:d4e94a9e-0b9f-4191-9026-c1b2a159d537'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:df72da08-775f-481b-aac2-c334a074f18c'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 8, part.movement_number = NULL,
    part.name_ko = 'Acte I. « Mes amis, écoutez l''histoire » (Chapelou, Le Chœur, Le Marquis, Les Paysannes)', part.name_en = 'Le Postillon de Lonjumeau: Acte I. « Mes amis, écoutez l''histoire » (Chapelou, Le Chœur, Le Marquis, Les Paysannes)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 7528 AND p.composer_id = 55 AND part.part_key = 'musicbrainz:e24b3a76-f7d0-4137-84f2-a5de56729eb9' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:e24b3a76-f7d0-4137-84f2-a5de56729eb9', 8, NULL, 'Acte I. « Mes amis, écoutez l''histoire » (Chapelou, Le Chœur, Le Marquis, Les Paysannes)', 'Le Postillon de Lonjumeau: Acte I. « Mes amis, écoutez l''histoire » (Chapelou, Le Chœur, Le Marquis, Les Paysannes)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:df72da08-775f-481b-aac2-c334a074f18c'
WHERE p.id = 7528 AND p.composer_id = 55
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:e24b3a76-f7d0-4137-84f2-a5de56729eb9'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = NULL,
    part.name_ko = 'Le Postillon de Lonjumeau. Entracte', part.name_en = 'Le Postillon de Lonjumeau. Entracte',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 7528 AND p.composer_id = 55 AND part.part_key = 'musicbrainz:a3cfb726-3c90-42d9-86df-f1699b15f8ff' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:a3cfb726-3c90-42d9-86df-f1699b15f8ff', 3, NULL, 'Le Postillon de Lonjumeau. Entracte', 'Le Postillon de Lonjumeau. Entracte', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 7528 AND p.composer_id = 55
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:a3cfb726-3c90-42d9-86df-f1699b15f8ff'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = NULL,
    part.name_ko = 'Acte II', part.name_en = 'Le Postillon de Lonjumeau: Acte II',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 7528 AND p.composer_id = 55 AND part.part_key = 'musicbrainz:2ebef19f-7498-41a4-a160-a9832e2a6959' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:2ebef19f-7498-41a4-a160-a9832e2a6959', 4, NULL, 'Acte II', 'Le Postillon de Lonjumeau: Acte II', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 7528 AND p.composer_id = 55
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:2ebef19f-7498-41a4-a160-a9832e2a6959'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:2ebef19f-7498-41a4-a160-a9832e2a6959'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'Le Postillon de Lonjumeau, Acte II. "Assis au pied d''un hêtre" (Saint-Phar, Le Marquis, Tous, Alcindor)', part.name_en = 'Le Postillon de Lonjumeau, Acte II. "Assis au pied d''un hêtre" (Saint-Phar, Le Marquis, Tous, Alcindor)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 7528 AND p.composer_id = 55 AND part.part_key = 'musicbrainz:11931abb-2898-41b7-a6c3-aa62ea2de142' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:11931abb-2898-41b7-a6c3-aa62ea2de142', 1, NULL, 'Le Postillon de Lonjumeau, Acte II. "Assis au pied d''un hêtre" (Saint-Phar, Le Marquis, Tous, Alcindor)', 'Le Postillon de Lonjumeau, Acte II. "Assis au pied d''un hêtre" (Saint-Phar, Le Marquis, Tous, Alcindor)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:2ebef19f-7498-41a4-a160-a9832e2a6959'
WHERE p.id = 7528 AND p.composer_id = 55
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:11931abb-2898-41b7-a6c3-aa62ea2de142'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:2ebef19f-7498-41a4-a160-a9832e2a6959'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'Le Postillon de Lonjumeau, Acte II. "Oui, des choristes du théâtre" (Alcindor)', part.name_en = 'Le Postillon de Lonjumeau, Acte II. "Oui, des choristes du théâtre" (Alcindor)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 7528 AND p.composer_id = 55 AND part.part_key = 'musicbrainz:34a85408-6758-4c52-bc42-72d97eb088f3' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:34a85408-6758-4c52-bc42-72d97eb088f3', 2, NULL, 'Le Postillon de Lonjumeau, Acte II. "Oui, des choristes du théâtre" (Alcindor)', 'Le Postillon de Lonjumeau, Acte II. "Oui, des choristes du théâtre" (Alcindor)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:2ebef19f-7498-41a4-a160-a9832e2a6959'
WHERE p.id = 7528 AND p.composer_id = 55
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:34a85408-6758-4c52-bc42-72d97eb088f3'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:2ebef19f-7498-41a4-a160-a9832e2a6959'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = NULL,
    part.name_ko = 'Le Postillon de Lonjumeau, Acte II. "Assis au pied d''un hêtre" (Saint-Phar, Le Marquis, Alcindor)', part.name_en = 'Le Postillon de Lonjumeau, Acte II. "Assis au pied d''un hêtre" (Saint-Phar, Le Marquis, Alcindor)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 7528 AND p.composer_id = 55 AND part.part_key = 'musicbrainz:5624bdec-7a7d-4714-8924-bfc34393eea7' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:5624bdec-7a7d-4714-8924-bfc34393eea7', 3, NULL, 'Le Postillon de Lonjumeau, Acte II. "Assis au pied d''un hêtre" (Saint-Phar, Le Marquis, Alcindor)', 'Le Postillon de Lonjumeau, Acte II. "Assis au pied d''un hêtre" (Saint-Phar, Le Marquis, Alcindor)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:2ebef19f-7498-41a4-a160-a9832e2a6959'
WHERE p.id = 7528 AND p.composer_id = 55
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:5624bdec-7a7d-4714-8924-bfc34393eea7'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:2ebef19f-7498-41a4-a160-a9832e2a6959'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = NULL,
    part.name_ko = 'Le Postillon de Lonjumeau, Acte II. "Ah! quel tourment!" (Le Chœur des Comédiens, Saint-Phar, Alcindor, Le Marquis)', part.name_en = 'Le Postillon de Lonjumeau, Acte II. "Ah! quel tourment!" (Le Chœur des Comédiens, Saint-Phar, Alcindor, Le Marquis)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 7528 AND p.composer_id = 55 AND part.part_key = 'musicbrainz:58cbeeda-4a11-4f9a-a956-7463bd219b28' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:58cbeeda-4a11-4f9a-a956-7463bd219b28', 4, NULL, 'Le Postillon de Lonjumeau, Acte II. "Ah! quel tourment!" (Le Chœur des Comédiens, Saint-Phar, Alcindor, Le Marquis)', 'Le Postillon de Lonjumeau, Acte II. "Ah! quel tourment!" (Le Chœur des Comédiens, Saint-Phar, Alcindor, Le Marquis)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:2ebef19f-7498-41a4-a160-a9832e2a6959'
WHERE p.id = 7528 AND p.composer_id = 55
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:58cbeeda-4a11-4f9a-a956-7463bd219b28'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:2ebef19f-7498-41a4-a160-a9832e2a6959'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 5, part.movement_number = NULL,
    part.name_ko = 'Le Postillon de Lonjumeau, Acte II. "Elle est ici!" (Saint-Phar, Alcindor)', part.name_en = 'Le Postillon de Lonjumeau, Acte II. "Elle est ici!" (Saint-Phar, Alcindor)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 7528 AND p.composer_id = 55 AND part.part_key = 'musicbrainz:719320fd-b365-4c06-a6a2-d117f77fc3bc' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:719320fd-b365-4c06-a6a2-d117f77fc3bc', 5, NULL, 'Le Postillon de Lonjumeau, Acte II. "Elle est ici!" (Saint-Phar, Alcindor)', 'Le Postillon de Lonjumeau, Acte II. "Elle est ici!" (Saint-Phar, Alcindor)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:2ebef19f-7498-41a4-a160-a9832e2a6959'
WHERE p.id = 7528 AND p.composer_id = 55
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:719320fd-b365-4c06-a6a2-d117f77fc3bc'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:2ebef19f-7498-41a4-a160-a9832e2a6959'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 6, part.movement_number = NULL,
    part.name_ko = 'Le Postillon de Lonjumeau, Acte II. "Ah! quelle étonnante nouvelle!" (Le Chœur des hommes, Saint-Phar, Le Marquis, Le Chœur des femmes, Madame de Latour)', part.name_en = 'Le Postillon de Lonjumeau, Acte II. "Ah! quelle étonnante nouvelle!" (Le Chœur des hommes, Saint-Phar, Le Marquis, Le Chœur des femmes, Madame de Latour)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 7528 AND p.composer_id = 55 AND part.part_key = 'musicbrainz:85f909dd-e1c9-44b8-9595-ec6bc309f11a' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:85f909dd-e1c9-44b8-9595-ec6bc309f11a', 6, NULL, 'Le Postillon de Lonjumeau, Acte II. "Ah! quelle étonnante nouvelle!" (Le Chœur des hommes, Saint-Phar, Le Marquis, Le Chœur des femmes, Madame de Latour)', 'Le Postillon de Lonjumeau, Acte II. "Ah! quelle étonnante nouvelle!" (Le Chœur des hommes, Saint-Phar, Le Marquis, Le Chœur des femmes, Madame de Latour)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:2ebef19f-7498-41a4-a160-a9832e2a6959'
WHERE p.id = 7528 AND p.composer_id = 55
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:85f909dd-e1c9-44b8-9595-ec6bc309f11a'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:2ebef19f-7498-41a4-a160-a9832e2a6959'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 7, part.movement_number = NULL,
    part.name_ko = 'Le Postillon de Lonjumeau, Acte II. "Je vais donc le revoir" (Madame de Latour)', part.name_en = 'Le Postillon de Lonjumeau, Acte II. "Je vais donc le revoir" (Madame de Latour)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 7528 AND p.composer_id = 55 AND part.part_key = 'musicbrainz:93c2ad75-aa7c-41b9-af03-bfbe5cbb113c' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:93c2ad75-aa7c-41b9-af03-bfbe5cbb113c', 7, NULL, 'Le Postillon de Lonjumeau, Acte II. "Je vais donc le revoir" (Madame de Latour)', 'Le Postillon de Lonjumeau, Acte II. "Je vais donc le revoir" (Madame de Latour)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:2ebef19f-7498-41a4-a160-a9832e2a6959'
WHERE p.id = 7528 AND p.composer_id = 55
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:93c2ad75-aa7c-41b9-af03-bfbe5cbb113c'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:2ebef19f-7498-41a4-a160-a9832e2a6959'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 8, part.movement_number = NULL,
    part.name_ko = 'Le Postillon de Lonjumeau, Acte II. "Eh bien Rose?" (Madame de Latour, Rose, Le Marquis)', part.name_en = 'Le Postillon de Lonjumeau, Acte II. "Eh bien Rose?" (Madame de Latour, Rose, Le Marquis)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 7528 AND p.composer_id = 55 AND part.part_key = 'musicbrainz:b1d5c8be-b5d9-408e-b35e-55db5aa68dfc' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:b1d5c8be-b5d9-408e-b35e-55db5aa68dfc', 8, NULL, 'Le Postillon de Lonjumeau, Acte II. "Eh bien Rose?" (Madame de Latour, Rose, Le Marquis)', 'Le Postillon de Lonjumeau, Acte II. "Eh bien Rose?" (Madame de Latour, Rose, Le Marquis)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:2ebef19f-7498-41a4-a160-a9832e2a6959'
WHERE p.id = 7528 AND p.composer_id = 55
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:b1d5c8be-b5d9-408e-b35e-55db5aa68dfc'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:2ebef19f-7498-41a4-a160-a9832e2a6959'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 9, part.movement_number = NULL,
    part.name_ko = 'Le Postillon de Lonjumeau, Acte II. "On vient!... C''est Biju!..." (Madame de Latour, Saint-Phar, Alcindor, Le Marquis, Rose)', part.name_en = 'Le Postillon de Lonjumeau, Acte II. "On vient!... C''est Biju!..." (Madame de Latour, Saint-Phar, Alcindor, Le Marquis, Rose)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 7528 AND p.composer_id = 55 AND part.part_key = 'musicbrainz:c7f1fc4e-6a5c-403f-b725-1fe5d5cf7066' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:c7f1fc4e-6a5c-403f-b725-1fe5d5cf7066', 9, NULL, 'Le Postillon de Lonjumeau, Acte II. "On vient!... C''est Biju!..." (Madame de Latour, Saint-Phar, Alcindor, Le Marquis, Rose)', 'Le Postillon de Lonjumeau, Acte II. "On vient!... C''est Biju!..." (Madame de Latour, Saint-Phar, Alcindor, Le Marquis, Rose)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:2ebef19f-7498-41a4-a160-a9832e2a6959'
WHERE p.id = 7528 AND p.composer_id = 55
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:c7f1fc4e-6a5c-403f-b725-1fe5d5cf7066'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:2ebef19f-7498-41a4-a160-a9832e2a6959'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 10, part.movement_number = NULL,
    part.name_ko = 'Le Postillon de Lonjumeau, Acte II. "Grâce au hasard" (Saint-Phar, Madame de Latour, Ensemble)', part.name_en = 'Le Postillon de Lonjumeau, Acte II. "Grâce au hasard" (Saint-Phar, Madame de Latour, Ensemble)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 7528 AND p.composer_id = 55 AND part.part_key = 'musicbrainz:ebc50c13-d479-4ffa-8327-c36d0499e78e' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:ebc50c13-d479-4ffa-8327-c36d0499e78e', 10, NULL, 'Le Postillon de Lonjumeau, Acte II. "Grâce au hasard" (Saint-Phar, Madame de Latour, Ensemble)', 'Le Postillon de Lonjumeau, Acte II. "Grâce au hasard" (Saint-Phar, Madame de Latour, Ensemble)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:2ebef19f-7498-41a4-a160-a9832e2a6959'
WHERE p.id = 7528 AND p.composer_id = 55
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:ebc50c13-d479-4ffa-8327-c36d0499e78e'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:2ebef19f-7498-41a4-a160-a9832e2a6959'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 11, part.movement_number = NULL,
    part.name_ko = 'Le Postillon de Lonjumeau, Acte II. "Qui te dit que tu n''es pas la fine fleur des choristes?..." (Saint-Phar, Alcindor)', part.name_en = 'Le Postillon de Lonjumeau, Acte II. "Qui te dit que tu n''es pas la fine fleur des choristes?..." (Saint-Phar, Alcindor)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 7528 AND p.composer_id = 55 AND part.part_key = 'musicbrainz:f4767fc6-a4f1-4e51-97ee-223ae93dbdb6' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:f4767fc6-a4f1-4e51-97ee-223ae93dbdb6', 11, NULL, 'Le Postillon de Lonjumeau, Acte II. "Qui te dit que tu n''es pas la fine fleur des choristes?..." (Saint-Phar, Alcindor)', 'Le Postillon de Lonjumeau, Acte II. "Qui te dit que tu n''es pas la fine fleur des choristes?..." (Saint-Phar, Alcindor)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:2ebef19f-7498-41a4-a160-a9832e2a6959'
WHERE p.id = 7528 AND p.composer_id = 55
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:f4767fc6-a4f1-4e51-97ee-223ae93dbdb6'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 5, part.movement_number = NULL,
    part.name_ko = 'Le Postillon de Lonjumeau. Entracte', part.name_en = 'Le Postillon de Lonjumeau. Entracte',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 7528 AND p.composer_id = 55 AND part.part_key = 'musicbrainz:802a09f8-84ee-4798-9b25-16d09b3f9e99' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:802a09f8-84ee-4798-9b25-16d09b3f9e99', 5, NULL, 'Le Postillon de Lonjumeau. Entracte', 'Le Postillon de Lonjumeau. Entracte', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 7528 AND p.composer_id = 55
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:802a09f8-84ee-4798-9b25-16d09b3f9e99'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 6, part.movement_number = NULL,
    part.name_ko = 'Acte III', part.name_en = 'Le Postillon de Lonjumeau: Acte III',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 7528 AND p.composer_id = 55 AND part.part_key = 'musicbrainz:eeb15df8-ee5a-4d77-80a1-4df61293e03d' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:eeb15df8-ee5a-4d77-80a1-4df61293e03d', 6, NULL, 'Acte III', 'Le Postillon de Lonjumeau: Acte III', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 7528 AND p.composer_id = 55
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:eeb15df8-ee5a-4d77-80a1-4df61293e03d'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:eeb15df8-ee5a-4d77-80a1-4df61293e03d'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'Le Postillon de Lonjumeau, Acte III. "A ma douleur soyez sensible" (Madame de Latour, Saint-Phar, Le Chœur des soldats, Alcindor, Bourdon, Le Marquis, Tous)', part.name_en = 'Le Postillon de Lonjumeau, Acte III. "A ma douleur soyez sensible" (Madame de Latour, Saint-Phar, Le Chœur des soldats, Alcindor, Bourdon, Le Marquis, Tous)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 7528 AND p.composer_id = 55 AND part.part_key = 'musicbrainz:009f5575-a45a-4033-820e-ad026d2e950d' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:009f5575-a45a-4033-820e-ad026d2e950d', 1, NULL, 'Le Postillon de Lonjumeau, Acte III. "A ma douleur soyez sensible" (Madame de Latour, Saint-Phar, Le Chœur des soldats, Alcindor, Bourdon, Le Marquis, Tous)', 'Le Postillon de Lonjumeau, Acte III. "A ma douleur soyez sensible" (Madame de Latour, Saint-Phar, Le Chœur des soldats, Alcindor, Bourdon, Le Marquis, Tous)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:eeb15df8-ee5a-4d77-80a1-4df61293e03d'
WHERE p.id = 7528 AND p.composer_id = 55
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:009f5575-a45a-4033-820e-ad026d2e950d'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:eeb15df8-ee5a-4d77-80a1-4df61293e03d'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'Le Postillon de Lonjumeau, Acte III. "Enfin, nous voilà seuls!..." (Saint-Phar, Madame de Latour, Rose)', part.name_en = 'Le Postillon de Lonjumeau, Acte III. "Enfin, nous voilà seuls!..." (Saint-Phar, Madame de Latour, Rose)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 7528 AND p.composer_id = 55 AND part.part_key = 'musicbrainz:61f06a8c-b041-4421-9da2-2821cda5770f' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:61f06a8c-b041-4421-9da2-2821cda5770f', 2, NULL, 'Le Postillon de Lonjumeau, Acte III. "Enfin, nous voilà seuls!..." (Saint-Phar, Madame de Latour, Rose)', 'Le Postillon de Lonjumeau, Acte III. "Enfin, nous voilà seuls!..." (Saint-Phar, Madame de Latour, Rose)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:eeb15df8-ee5a-4d77-80a1-4df61293e03d'
WHERE p.id = 7528 AND p.composer_id = 55
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:61f06a8c-b041-4421-9da2-2821cda5770f'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:eeb15df8-ee5a-4d77-80a1-4df61293e03d'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = NULL,
    part.name_ko = 'Le Postillon de Lonjumeau, Acte III. "Pendu!..." (Alcindor, Bourdon, Saint-Phar)', part.name_en = 'Le Postillon de Lonjumeau, Acte III. "Pendu!..." (Alcindor, Bourdon, Saint-Phar)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 7528 AND p.composer_id = 55 AND part.part_key = 'musicbrainz:839e62cc-6823-4e7c-b882-09870b826a21' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:839e62cc-6823-4e7c-b882-09870b826a21', 3, NULL, 'Le Postillon de Lonjumeau, Acte III. "Pendu!..." (Alcindor, Bourdon, Saint-Phar)', 'Le Postillon de Lonjumeau, Acte III. "Pendu!..." (Alcindor, Bourdon, Saint-Phar)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:eeb15df8-ee5a-4d77-80a1-4df61293e03d'
WHERE p.id = 7528 AND p.composer_id = 55
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:839e62cc-6823-4e7c-b882-09870b826a21'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:eeb15df8-ee5a-4d77-80a1-4df61293e03d'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = NULL,
    part.name_ko = 'Le Postillon de Lonjumeau, Acte III. "A la noblesse, je m''allië (Saint-Phar)', part.name_en = 'Le Postillon de Lonjumeau, Acte III. "A la noblesse, je m''allië (Saint-Phar)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 7528 AND p.composer_id = 55 AND part.part_key = 'musicbrainz:b32179ef-bfbb-4927-879a-cf9688a972c8' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:b32179ef-bfbb-4927-879a-cf9688a972c8', 4, NULL, 'Le Postillon de Lonjumeau, Acte III. "A la noblesse, je m''allië (Saint-Phar)', 'Le Postillon de Lonjumeau, Acte III. "A la noblesse, je m''allië (Saint-Phar)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:eeb15df8-ee5a-4d77-80a1-4df61293e03d'
WHERE p.id = 7528 AND p.composer_id = 55
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:b32179ef-bfbb-4927-879a-cf9688a972c8'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:eeb15df8-ee5a-4d77-80a1-4df61293e03d'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 5, part.movement_number = NULL,
    part.name_ko = 'Le Postillon de Lonjumeau, Acte III. "Du vrai bonheur" (Chœur, Madame de Latour, Saint-Phar, Le Marquis, Ensemble)', part.name_en = 'Le Postillon de Lonjumeau, Acte III. "Du vrai bonheur" (Chœur, Madame de Latour, Saint-Phar, Le Marquis, Ensemble)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 7528 AND p.composer_id = 55 AND part.part_key = 'musicbrainz:c10a15c6-a8c1-40ad-a427-c00d17445e54' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:c10a15c6-a8c1-40ad-a427-c00d17445e54', 5, NULL, 'Le Postillon de Lonjumeau, Acte III. "Du vrai bonheur" (Chœur, Madame de Latour, Saint-Phar, Le Marquis, Ensemble)', 'Le Postillon de Lonjumeau, Acte III. "Du vrai bonheur" (Chœur, Madame de Latour, Saint-Phar, Le Marquis, Ensemble)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:eeb15df8-ee5a-4d77-80a1-4df61293e03d'
WHERE p.id = 7528 AND p.composer_id = 55
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:c10a15c6-a8c1-40ad-a427-c00d17445e54'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:eeb15df8-ee5a-4d77-80a1-4df61293e03d'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 6, part.movement_number = NULL,
    part.name_ko = 'Le Postillon de Lonjumeau, Acte III. "Tout a réussï (Saint-Phar)', part.name_en = 'Le Postillon de Lonjumeau, Acte III. "Tout a réussï (Saint-Phar)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 7528 AND p.composer_id = 55 AND part.part_key = 'musicbrainz:dad00430-3e88-47f5-a463-1ee0369e1848' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:dad00430-3e88-47f5-a463-1ee0369e1848', 6, NULL, 'Le Postillon de Lonjumeau, Acte III. "Tout a réussï (Saint-Phar)', 'Le Postillon de Lonjumeau, Acte III. "Tout a réussï (Saint-Phar)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:eeb15df8-ee5a-4d77-80a1-4df61293e03d'
WHERE p.id = 7528 AND p.composer_id = 55
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:dad00430-3e88-47f5-a463-1ee0369e1848'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:eeb15df8-ee5a-4d77-80a1-4df61293e03d'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 7, part.movement_number = NULL,
    part.name_ko = 'Le Postillon de Lonjumeau, Acte III. "Ils sont partis..." (Saint-Phar, Madeleine)', part.name_en = 'Le Postillon de Lonjumeau, Acte III. "Ils sont partis..." (Saint-Phar, Madeleine)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 7528 AND p.composer_id = 55 AND part.part_key = 'musicbrainz:fc2ab0bb-a86f-424c-b478-1b15591ce9a6' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:fc2ab0bb-a86f-424c-b478-1b15591ce9a6', 7, NULL, 'Le Postillon de Lonjumeau, Acte III. "Ils sont partis..." (Saint-Phar, Madeleine)', 'Le Postillon de Lonjumeau, Acte III. "Ils sont partis..." (Saint-Phar, Madeleine)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:eeb15df8-ee5a-4d77-80a1-4df61293e03d'
WHERE p.id = 7528 AND p.composer_id = 55
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:fc2ab0bb-a86f-424c-b478-1b15591ce9a6'
);


-- None 오페레타 <Les Pantins de Violette>

UPDATE pieces piece
SET piece.title = '오페레타 <Les Pantins de Violette>', piece.title_en = 'Les Pantins de Violette',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 8757 AND piece.composer_id = 55
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'La Chanson du canari', part.name_en = 'Les Pantins de Violette: La Chanson du canari',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 8757 AND p.composer_id = 55 AND part.part_key = 'musicbrainz:3e5bc67e-936c-4f81-95f1-8e00011b2344' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:3e5bc67e-936c-4f81-95f1-8e00011b2344', 1, NULL, 'La Chanson du canari', 'Les Pantins de Violette: La Chanson du canari', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 8757 AND p.composer_id = 55
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:3e5bc67e-936c-4f81-95f1-8e00011b2344'
);


-- None 가곡 <O Holy Night (Hear the Gospel Story)>

UPDATE pieces piece
SET piece.title = '가곡 <O Holy Night (Hear the Gospel Story)>', piece.title_en = 'O Holy Night (Hear the Gospel Story)',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 8331 AND piece.composer_id = 55
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None 발레 <Orfa>

UPDATE pieces piece
SET piece.title = '발레 <Orfa>', piece.title_en = 'Orfa',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 11279 AND piece.composer_id = 55
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'Act I', part.name_en = 'Orfa: Act I',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11279 AND p.composer_id = 55 AND part.part_key = 'musicbrainz:f605bd1c-0c70-4362-b15e-48693a39c11f' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:f605bd1c-0c70-4362-b15e-48693a39c11f', 1, NULL, 'Act I', 'Orfa: Act I', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 11279 AND p.composer_id = 55
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:f605bd1c-0c70-4362-b15e-48693a39c11f'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:f605bd1c-0c70-4362-b15e-48693a39c11f'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'Introduction “Le rendez-vous”', part.name_en = 'Orfa, Act I: No. 1. Introduction “Le rendez-vous”',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11279 AND p.composer_id = 55 AND part.part_key = 'musicbrainz:80e64a4d-09bc-49c2-8ba3-fc364096be33' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:80e64a4d-09bc-49c2-8ba3-fc364096be33', 1, NULL, 'Introduction “Le rendez-vous”', 'Orfa, Act I: No. 1. Introduction “Le rendez-vous”', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:f605bd1c-0c70-4362-b15e-48693a39c11f'
WHERE p.id = 11279 AND p.composer_id = 55
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:80e64a4d-09bc-49c2-8ba3-fc364096be33'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:f605bd1c-0c70-4362-b15e-48693a39c11f'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'Pas de trois “Les scandinaves”', part.name_en = 'Orfa, Act I: No. 2. Pas de trois “Les scandinaves”',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11279 AND p.composer_id = 55 AND part.part_key = 'musicbrainz:926ed54e-58a4-42c1-ac9e-2f4e97bbde01' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:926ed54e-58a4-42c1-ac9e-2f4e97bbde01', 2, NULL, 'Pas de trois “Les scandinaves”', 'Orfa, Act I: No. 2. Pas de trois “Les scandinaves”', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:f605bd1c-0c70-4362-b15e-48693a39c11f'
WHERE p.id = 11279 AND p.composer_id = 55
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:926ed54e-58a4-42c1-ac9e-2f4e97bbde01'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:f605bd1c-0c70-4362-b15e-48693a39c11f'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = NULL,
    part.name_ko = 'Pas de deux “Les fiancés”', part.name_en = 'Orfa, Act I: No. 3. Pas de deux “Les fiancés”',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11279 AND p.composer_id = 55 AND part.part_key = 'musicbrainz:85a06e76-4bbf-41fd-b948-4ca0e6254e1f' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:85a06e76-4bbf-41fd-b948-4ca0e6254e1f', 3, NULL, 'Pas de deux “Les fiancés”', 'Orfa, Act I: No. 3. Pas de deux “Les fiancés”', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:f605bd1c-0c70-4362-b15e-48693a39c11f'
WHERE p.id = 11279 AND p.composer_id = 55
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:85a06e76-4bbf-41fd-b948-4ca0e6254e1f'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:f605bd1c-0c70-4362-b15e-48693a39c11f'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = NULL,
    part.name_ko = 'Mazurka “Les traîneaux”', part.name_en = 'Orfa, Act I: No. 4. Mazurka “Les traîneaux”',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11279 AND p.composer_id = 55 AND part.part_key = 'musicbrainz:b12470c8-bd40-4f88-96ed-d10ed66b71a4' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:b12470c8-bd40-4f88-96ed-d10ed66b71a4', 4, NULL, 'Mazurka “Les traîneaux”', 'Orfa, Act I: No. 4. Mazurka “Les traîneaux”', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:f605bd1c-0c70-4362-b15e-48693a39c11f'
WHERE p.id = 11279 AND p.composer_id = 55
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:b12470c8-bd40-4f88-96ed-d10ed66b71a4'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:f605bd1c-0c70-4362-b15e-48693a39c11f'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 5, part.movement_number = NULL,
    part.name_ko = 'Après le divertissement', part.name_en = 'Orfa, Act I: No. 5. Après le divertissement',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11279 AND p.composer_id = 55 AND part.part_key = 'musicbrainz:a0c06a74-c8db-46f0-aa15-100436aa85c3' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:a0c06a74-c8db-46f0-aa15-100436aa85c3', 5, NULL, 'Après le divertissement', 'Orfa, Act I: No. 5. Après le divertissement', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:f605bd1c-0c70-4362-b15e-48693a39c11f'
WHERE p.id = 11279 AND p.composer_id = 55
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:a0c06a74-c8db-46f0-aa15-100436aa85c3'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'Act II', part.name_en = 'Orfa: Act II',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11279 AND p.composer_id = 55 AND part.part_key = 'musicbrainz:65f6ebd3-508e-4d62-a399-7c33993ebcf5' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:65f6ebd3-508e-4d62-a399-7c33993ebcf5', 2, NULL, 'Act II', 'Orfa: Act II', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 11279 AND p.composer_id = 55
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:65f6ebd3-508e-4d62-a399-7c33993ebcf5'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:65f6ebd3-508e-4d62-a399-7c33993ebcf5'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'Les Séductions', part.name_en = 'Orfa, Act II: No. 6. Les Séductions',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11279 AND p.composer_id = 55 AND part.part_key = 'musicbrainz:0dc7ae21-17b0-492f-9e4e-2dba889fd34c' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:0dc7ae21-17b0-492f-9e4e-2dba889fd34c', 1, NULL, 'Les Séductions', 'Orfa, Act II: No. 6. Les Séductions', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:65f6ebd3-508e-4d62-a399-7c33993ebcf5'
WHERE p.id = 11279 AND p.composer_id = 55
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:0dc7ae21-17b0-492f-9e4e-2dba889fd34c'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:65f6ebd3-508e-4d62-a399-7c33993ebcf5'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'Deuxième partie du deuxième acte', part.name_en = 'Orfa, Act II: No. 7. Deuxième partie du deuxième acte',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11279 AND p.composer_id = 55 AND part.part_key = 'musicbrainz:802aecde-7105-4234-be28-da666303c9d6' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:802aecde-7105-4234-be28-da666303c9d6', 2, NULL, 'Deuxième partie du deuxième acte', 'Orfa, Act II: No. 7. Deuxième partie du deuxième acte', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:65f6ebd3-508e-4d62-a399-7c33993ebcf5'
WHERE p.id = 11279 AND p.composer_id = 55
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:802aecde-7105-4234-be28-da666303c9d6'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:65f6ebd3-508e-4d62-a399-7c33993ebcf5'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = NULL,
    part.name_ko = 'Pas de deux et Apothéose', part.name_en = 'Orfa, Act II: No. 8. Pas de deux et Apothéose',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11279 AND p.composer_id = 55 AND part.part_key = 'musicbrainz:57537dbf-32d0-4249-a236-d7269c774c21' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:57537dbf-32d0-4249-a236-d7269c774c21', 3, NULL, 'Pas de deux et Apothéose', 'Orfa, Act II: No. 8. Pas de deux et Apothéose', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:65f6ebd3-508e-4d62-a399-7c33993ebcf5'
WHERE p.id = 11279 AND p.composer_id = 55
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:57537dbf-32d0-4249-a236-d7269c774c21'
);


-- None 오페라 <Si j'étais roi>

UPDATE pieces piece
SET piece.title = '오페라 <Si j''étais roi>', piece.title_en = 'Si j''étais roi',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 10506 AND piece.composer_id = 55
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'Ouverture', part.name_en = 'Si j''étais roi: Ouverture',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 10506 AND p.composer_id = 55 AND part.part_key = 'musicbrainz:563ae62f-5030-4270-9ea0-48959b773bee' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:563ae62f-5030-4270-9ea0-48959b773bee', 1, NULL, 'Ouverture', 'Si j''étais roi: Ouverture', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 10506 AND p.composer_id = 55
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:563ae62f-5030-4270-9ea0-48959b773bee'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'Acte I', part.name_en = 'Si j''étais roi: Acte I',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 10506 AND p.composer_id = 55 AND part.part_key = 'musicbrainz:062bcb6d-4ee2-47a7-bcce-f933e542e37a' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:062bcb6d-4ee2-47a7-bcce-f933e542e37a', 2, NULL, 'Acte I', 'Si j''étais roi: Acte I', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 10506 AND p.composer_id = 55
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:062bcb6d-4ee2-47a7-bcce-f933e542e37a'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:062bcb6d-4ee2-47a7-bcce-f933e542e37a'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'Acte I. « Un regard de ses yeux » (Zéphoris)', part.name_en = 'Si j''étais roi : Acte I. « Un regard de ses yeux » (Zéphoris)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 10506 AND p.composer_id = 55 AND part.part_key = 'musicbrainz:39667fbe-31b4-4311-a6e8-f3d817de0c21' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:39667fbe-31b4-4311-a6e8-f3d817de0c21', 1, NULL, 'Acte I. « Un regard de ses yeux » (Zéphoris)', 'Si j''étais roi : Acte I. « Un regard de ses yeux » (Zéphoris)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:062bcb6d-4ee2-47a7-bcce-f933e542e37a'
WHERE p.id = 10506 AND p.composer_id = 55
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:39667fbe-31b4-4311-a6e8-f3d817de0c21'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:062bcb6d-4ee2-47a7-bcce-f933e542e37a'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'Acte I. « J''ignore son nom » (Zéphoris)', part.name_en = 'Si j''étais roi : Acte I. « J''ignore son nom » (Zéphoris)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 10506 AND p.composer_id = 55 AND part.part_key = 'musicbrainz:b2f33e24-b9aa-428b-b84d-41efc19bec86' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:b2f33e24-b9aa-428b-b84d-41efc19bec86', 2, NULL, 'Acte I. « J''ignore son nom » (Zéphoris)', 'Si j''étais roi : Acte I. « J''ignore son nom » (Zéphoris)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:062bcb6d-4ee2-47a7-bcce-f933e542e37a'
WHERE p.id = 10506 AND p.composer_id = 55
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:b2f33e24-b9aa-428b-b84d-41efc19bec86'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:062bcb6d-4ee2-47a7-bcce-f933e542e37a'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = NULL,
    part.name_ko = 'Acte I. Romance "Elle est princesse !" (Zéphoris)', part.name_en = 'Si j''étais roi: Acte I. Romance "Elle est princesse !" (Zéphoris)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 10506 AND p.composer_id = 55 AND part.part_key = 'musicbrainz:c8a95cbe-8fe0-3405-bac2-6c45fdf17f74' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:c8a95cbe-8fe0-3405-bac2-6c45fdf17f74', 3, NULL, 'Acte I. Romance "Elle est princesse !" (Zéphoris)', 'Si j''étais roi: Acte I. Romance "Elle est princesse !" (Zéphoris)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:062bcb6d-4ee2-47a7-bcce-f933e542e37a'
WHERE p.id = 10506 AND p.composer_id = 55
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:c8a95cbe-8fe0-3405-bac2-6c45fdf17f74'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = NULL,
    part.name_ko = 'Acte II', part.name_en = 'Si j''étais roi: Acte II',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 10506 AND p.composer_id = 55 AND part.part_key = 'musicbrainz:c1f378b9-bad1-4889-9164-ddfdf9c4b8ec' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:c1f378b9-bad1-4889-9164-ddfdf9c4b8ec', 3, NULL, 'Acte II', 'Si j''étais roi: Acte II', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 10506 AND p.composer_id = 55
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:c1f378b9-bad1-4889-9164-ddfdf9c4b8ec'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:c1f378b9-bad1-4889-9164-ddfdf9c4b8ec'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'Acte II. Grand air "De vos nobles aïeux" (Néméa)', part.name_en = 'Si j''étais roi: Acte II. Grand air "De vos nobles aïeux" (Néméa)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 10506 AND p.composer_id = 55 AND part.part_key = 'musicbrainz:72e72f70-15d0-4627-9d25-28ae2cae2068' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:72e72f70-15d0-4627-9d25-28ae2cae2068', 1, NULL, 'Acte II. Grand air "De vos nobles aïeux" (Néméa)', 'Si j''étais roi: Acte II. Grand air "De vos nobles aïeux" (Néméa)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:c1f378b9-bad1-4889-9164-ddfdf9c4b8ec'
WHERE p.id = 10506 AND p.composer_id = 55
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:72e72f70-15d0-4627-9d25-28ae2cae2068'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = NULL,
    part.name_ko = 'Acte III', part.name_en = 'Si j''étais roi: Acte III',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 10506 AND p.composer_id = 55 AND part.part_key = 'musicbrainz:4a19b8bc-de8a-4e9a-a02a-d56e80c08d92' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:4a19b8bc-de8a-4e9a-a02a-d56e80c08d92', 4, NULL, 'Acte III', 'Si j''étais roi: Acte III', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 10506 AND p.composer_id = 55
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:4a19b8bc-de8a-4e9a-a02a-d56e80c08d92'
);


-- 카탈로그에 대응이 없는 seed 작품 9개를 목록에서 숨긴다(지우지 않음).
UPDATE pieces piece
SET piece.hidden_reason = 'catalog_unmatched'
WHERE piece.composer_id = 55 AND piece.origin = 'seed' AND piece.hidden_reason IS NULL
  AND piece.id IN (
    7442, 7632, 7685, 7913, 8070, 9150, 9273, 10024, 10737
  )
  AND NOT EXISTS (SELECT 1 FROM performance_sectors sector WHERE sector.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM piece_parts linking WHERE linking.linked_piece_id = piece.id);
