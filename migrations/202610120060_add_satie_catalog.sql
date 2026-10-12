-- 사티 작품을 MusicBrainz 작품 구조로 다시 짠다(4차 자동). 작품 133개(묶음 29, 다악장 32, 낱곡 72),
-- 새 작품 29개, part 281개, 그 아래 9개.
-- seed 185개 중 103개를 작품·part 에 잇고, 80개를 숨기고, 2개는 그대로 둔다.
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
SET piece.title = 'Socrate (편곡 1831)'
WHERE piece.id = 1831 AND piece.composer_id = 100 AND piece.title = 'Socrate'
  AND piece.origin = 'seed' AND piece.editor_locked = 0
  AND NOT EXISTS (SELECT 1 FROM performance_sectors sector WHERE sector.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM piece_parts linking WHERE linking.linked_piece_id = piece.id);

UPDATE pieces piece
SET piece.title = 'Gymnopédies (편곡 7635)'
WHERE piece.id = 7635 AND piece.composer_id = 100 AND piece.title = 'Gymnopédies'
  AND piece.origin = 'seed' AND piece.editor_locked = 0
  AND NOT EXISTS (SELECT 1 FROM performance_sectors sector WHERE sector.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM piece_parts linking WHERE linking.linked_piece_id = piece.id);


-- None 12 petits chorals

UPDATE pieces piece
SET piece.title = '12 petits chorals', piece.title_en = '12 petits chorals',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 7448 AND piece.composer_id = 100
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'No. 1', part.name_en = '12 petits chorals: No. 1',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 7448 AND p.composer_id = 100 AND part.part_key = 'musicbrainz:56a6cbac-997b-45dc-8fa4-439860d04ceb' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:56a6cbac-997b-45dc-8fa4-439860d04ceb', 1, NULL, 'No. 1', '12 petits chorals: No. 1', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 7448 AND p.composer_id = 100
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:56a6cbac-997b-45dc-8fa4-439860d04ceb'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'No. 2', part.name_en = '12 petits chorals: No. 2',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 7448 AND p.composer_id = 100 AND part.part_key = 'musicbrainz:683132e1-ae2b-43a9-b6fa-4c1d83a1eed5' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:683132e1-ae2b-43a9-b6fa-4c1d83a1eed5', 2, NULL, 'No. 2', '12 petits chorals: No. 2', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 7448 AND p.composer_id = 100
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:683132e1-ae2b-43a9-b6fa-4c1d83a1eed5'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = NULL,
    part.name_ko = 'No. 3', part.name_en = '12 petits chorals: No. 3',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 7448 AND p.composer_id = 100 AND part.part_key = 'musicbrainz:52179dec-9844-423f-b665-8ee443193381' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:52179dec-9844-423f-b665-8ee443193381', 3, NULL, 'No. 3', '12 petits chorals: No. 3', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 7448 AND p.composer_id = 100
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:52179dec-9844-423f-b665-8ee443193381'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = NULL,
    part.name_ko = 'No. 4', part.name_en = '12 petits chorals: No. 4',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 7448 AND p.composer_id = 100 AND part.part_key = 'musicbrainz:093bf769-6853-493a-a8c1-3d24cd258018' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:093bf769-6853-493a-a8c1-3d24cd258018', 4, NULL, 'No. 4', '12 petits chorals: No. 4', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 7448 AND p.composer_id = 100
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:093bf769-6853-493a-a8c1-3d24cd258018'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 5, part.movement_number = NULL,
    part.name_ko = 'No. 5', part.name_en = '12 petits chorals: No. 5',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 7448 AND p.composer_id = 100 AND part.part_key = 'musicbrainz:324a304d-e978-45ed-9d5b-bdf8207d0ee2' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:324a304d-e978-45ed-9d5b-bdf8207d0ee2', 5, NULL, 'No. 5', '12 petits chorals: No. 5', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 7448 AND p.composer_id = 100
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:324a304d-e978-45ed-9d5b-bdf8207d0ee2'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 6, part.movement_number = NULL,
    part.name_ko = 'No. 6', part.name_en = '12 petits chorals: No. 6',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 7448 AND p.composer_id = 100 AND part.part_key = 'musicbrainz:ff16760f-28e3-44b4-9d2c-d45f39c41bc0' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:ff16760f-28e3-44b4-9d2c-d45f39c41bc0', 6, NULL, 'No. 6', '12 petits chorals: No. 6', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 7448 AND p.composer_id = 100
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:ff16760f-28e3-44b4-9d2c-d45f39c41bc0'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 7, part.movement_number = NULL,
    part.name_ko = 'No. 7', part.name_en = '12 petits chorals: No. 7',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 7448 AND p.composer_id = 100 AND part.part_key = 'musicbrainz:388f8094-b626-46ca-9689-cf359dd043da' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:388f8094-b626-46ca-9689-cf359dd043da', 7, NULL, 'No. 7', '12 petits chorals: No. 7', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 7448 AND p.composer_id = 100
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:388f8094-b626-46ca-9689-cf359dd043da'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 8, part.movement_number = NULL,
    part.name_ko = 'No. 8', part.name_en = '12 petits chorals: No. 8',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 7448 AND p.composer_id = 100 AND part.part_key = 'musicbrainz:c031966f-b096-494f-82fe-e076fa8599f5' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:c031966f-b096-494f-82fe-e076fa8599f5', 8, NULL, 'No. 8', '12 petits chorals: No. 8', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 7448 AND p.composer_id = 100
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:c031966f-b096-494f-82fe-e076fa8599f5'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 9, part.movement_number = NULL,
    part.name_ko = 'No. 9', part.name_en = '12 petits chorals: No. 9',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 7448 AND p.composer_id = 100 AND part.part_key = 'musicbrainz:a4f2e8a2-6e98-4f73-8070-26acabc548ae' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:a4f2e8a2-6e98-4f73-8070-26acabc548ae', 9, NULL, 'No. 9', '12 petits chorals: No. 9', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 7448 AND p.composer_id = 100
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:a4f2e8a2-6e98-4f73-8070-26acabc548ae'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 10, part.movement_number = NULL,
    part.name_ko = 'No. 10', part.name_en = '12 petits chorals: No. 10',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 7448 AND p.composer_id = 100 AND part.part_key = 'musicbrainz:9268a963-12b1-4301-9a6e-a3ae698eeead' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:9268a963-12b1-4301-9a6e-a3ae698eeead', 10, NULL, 'No. 10', '12 petits chorals: No. 10', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 7448 AND p.composer_id = 100
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:9268a963-12b1-4301-9a6e-a3ae698eeead'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 11, part.movement_number = NULL,
    part.name_ko = 'No. 11', part.name_en = '12 petits chorals: No. 11',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 7448 AND p.composer_id = 100 AND part.part_key = 'musicbrainz:db09d92a-4a5b-4b23-8224-a202613e08f4' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:db09d92a-4a5b-4b23-8224-a202613e08f4', 11, NULL, 'No. 11', '12 petits chorals: No. 11', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 7448 AND p.composer_id = 100
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:db09d92a-4a5b-4b23-8224-a202613e08f4'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 12, part.movement_number = NULL,
    part.name_ko = 'No. 12', part.name_en = '12 petits chorals: No. 12',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 7448 AND p.composer_id = 100 AND part.part_key = 'musicbrainz:eb775a8f-f48a-4a3e-bc46-2469637385f5' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:eb775a8f-f48a-4a3e-bc46-2469637385f5', 12, NULL, 'No. 12', '12 petits chorals: No. 12', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 7448 AND p.composer_id = 100
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:eb775a8f-f48a-4a3e-bc46-2469637385f5'
);


-- None 3 véritables préludes flasques

UPDATE pieces piece
SET piece.title = '3 véritables préludes flasques', piece.title_en = '3 véritables préludes flasques',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 9755 AND piece.composer_id = 100
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'Sévère réprimande', part.name_en = '3 véritables préludes flasques : No. 1. Sévère réprimande',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 9755 AND p.composer_id = 100 AND part.part_key = 'musicbrainz:177a4588-dbb5-31d4-9b0f-bd843cab24df' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:177a4588-dbb5-31d4-9b0f-bd843cab24df', 1, NULL, 'Sévère réprimande', '3 véritables préludes flasques : No. 1. Sévère réprimande', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 9755 AND p.composer_id = 100
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:177a4588-dbb5-31d4-9b0f-bd843cab24df'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'Seul à la maison', part.name_en = '3 véritables préludes flasques : No. 2. Seul à la maison',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 9755 AND p.composer_id = 100 AND part.part_key = 'musicbrainz:25270269-22ce-3fa2-b190-5d972efd6275' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:25270269-22ce-3fa2-b190-5d972efd6275', 2, NULL, 'Seul à la maison', '3 véritables préludes flasques : No. 2. Seul à la maison', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 9755 AND p.composer_id = 100
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:25270269-22ce-3fa2-b190-5d972efd6275'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = NULL,
    part.name_ko = 'On joue', part.name_en = '3 véritables préludes flasques : No. 3. On joue',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 9755 AND p.composer_id = 100 AND part.part_key = 'musicbrainz:e0273acd-e131-3987-bd92-80c50a3766ee' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:e0273acd-e131-3987-bd92-80c50a3766ee', 3, NULL, 'On joue', '3 véritables préludes flasques : No. 3. On joue', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 9755 AND p.composer_id = 100
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:e0273acd-e131-3987-bd92-80c50a3766ee'
);


-- None 6ème nocturne

UPDATE pieces piece
SET piece.title = '6ème nocturne', piece.title_en = '6ème nocturne',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 10038 AND piece.composer_id = 100
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Air du Grand Prieur

UPDATE pieces piece
SET piece.title = 'Air du Grand Prieur', piece.title_en = 'Air du Grand Prieur',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 8885 AND piece.composer_id = 100
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Allegro

UPDATE pieces piece
SET piece.title = 'Allegro', piece.title_en = 'Allegro',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 8099 AND piece.composer_id = 100
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None 가곡 <Allons-y, Chochotte>

UPDATE pieces piece
SET piece.title = '가곡 <Allons-y, Chochotte>', piece.title_en = 'Allons-y, Chochotte',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 7643 AND piece.composer_id = 100
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Aperçus désagréables

UPDATE pieces piece
SET piece.title = 'Aperçus désagréables', piece.title_en = 'Aperçus désagréables',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 8389 AND piece.composer_id = 100
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'Pastorale', part.name_en = 'Aperçus désagréables : I. Pastorale',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 8389 AND p.composer_id = 100 AND part.part_key = 'musicbrainz:f67b8e2e-44b9-35e4-8449-5e708f099f03' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:f67b8e2e-44b9-35e4-8449-5e708f099f03', 1, 'I', 'Pastorale', 'Aperçus désagréables : I. Pastorale', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 8389 AND p.composer_id = 100
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:f67b8e2e-44b9-35e4-8449-5e708f099f03'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'Choral', part.name_en = 'Aperçus désagréables : II. Choral',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 8389 AND p.composer_id = 100 AND part.part_key = 'musicbrainz:ca69f636-2050-3918-a127-c71b78cd1cce' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:ca69f636-2050-3918-a127-c71b78cd1cce', 2, 'II', 'Choral', 'Aperçus désagréables : II. Choral', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 8389 AND p.composer_id = 100
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:ca69f636-2050-3918-a127-c71b78cd1cce'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = 'Fugue', part.name_en = 'Aperçus désagréables : III. Fugue',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 8389 AND p.composer_id = 100 AND part.part_key = 'musicbrainz:72cd9543-55b1-391e-8d0a-1925db41eabc' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:72cd9543-55b1-391e-8d0a-1925db41eabc', 3, 'III', 'Fugue', 'Aperçus désagréables : III. Fugue', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 8389 AND p.composer_id = 100
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:72cd9543-55b1-391e-8d0a-1925db41eabc'
);


-- None Avant-dernières pensées

UPDATE pieces piece
SET piece.title = 'Avant-dernières pensées', piece.title_en = 'Avant-dernières pensées',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 9262 AND piece.composer_id = 100
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'Idylle (à Debussy)', part.name_en = 'Avant-dernières pensées : I. Idylle (à Debussy)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 9262 AND p.composer_id = 100 AND part.part_key = 'musicbrainz:a44e2474-97fc-36d6-a518-f85995997afb' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:a44e2474-97fc-36d6-a518-f85995997afb', 1, 'I', 'Idylle (à Debussy)', 'Avant-dernières pensées : I. Idylle (à Debussy)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 9262 AND p.composer_id = 100
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:a44e2474-97fc-36d6-a518-f85995997afb'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'Aubade (à Paul Dukas)', part.name_en = 'Avant-dernières pensées : II. Aubade (à Paul Dukas)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 9262 AND p.composer_id = 100 AND part.part_key = 'musicbrainz:96260a39-58f3-3ca3-93d8-ea80358c6679' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:96260a39-58f3-3ca3-93d8-ea80358c6679', 2, 'II', 'Aubade (à Paul Dukas)', 'Avant-dernières pensées : II. Aubade (à Paul Dukas)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 9262 AND p.composer_id = 100
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:96260a39-58f3-3ca3-93d8-ea80358c6679'
);


-- None 가곡 <Bonjour Biqui, Bonjour!>

UPDATE pieces piece
SET piece.title = '가곡 <Bonjour Biqui, Bonjour!>', piece.title_en = 'Bonjour Biqui, Bonjour!',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 11015 AND piece.composer_id = 100
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None 부레

UPDATE pieces piece
SET piece.title = '부레', piece.title_en = 'Bourrée',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 8209 AND piece.composer_id = 100
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Carnet d’esquisses et de croquis

UPDATE pieces piece
SET piece.title = 'Carnet d’esquisses et de croquis', piece.title_en = 'Carnet d’esquisses et de croquis',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 9409 AND piece.composer_id = 100
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'Arrière-propos', part.name_en = 'Carnet d’esquisses et de croquis : Arrière-propos',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 9409 AND p.composer_id = 100 AND part.part_key = 'musicbrainz:1312a4cf-1409-4c04-81d3-0ff18b070746' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:1312a4cf-1409-4c04-81d3-0ff18b070746', 1, NULL, 'Arrière-propos', 'Carnet d’esquisses et de croquis : Arrière-propos', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 9409 AND p.composer_id = 100
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:1312a4cf-1409-4c04-81d3-0ff18b070746'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'Harmonies', part.name_en = 'Carnet d’esquisses et de croquis : Harmonies',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 9409 AND p.composer_id = 100 AND part.part_key = 'musicbrainz:15a3f0ca-faf6-439b-9a99-87386815e89d' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:15a3f0ca-faf6-439b-9a99-87386815e89d', 2, NULL, 'Harmonies', 'Carnet d’esquisses et de croquis : Harmonies', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 9409 AND p.composer_id = 100
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:15a3f0ca-faf6-439b-9a99-87386815e89d'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = NULL,
    part.name_ko = 'Esquisses “Le grand singe”', part.name_en = 'Carnet d’esquisses et de croquis : Esquisses “Le grand singe”',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 9409 AND p.composer_id = 100 AND part.part_key = 'musicbrainz:3100e6f6-dca9-4d21-a60a-f9bb8da37ece' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:3100e6f6-dca9-4d21-a60a-f9bb8da37ece', 3, NULL, 'Esquisses “Le grand singe”', 'Carnet d’esquisses et de croquis : Esquisses “Le grand singe”', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 9409 AND p.composer_id = 100
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:3100e6f6-dca9-4d21-a60a-f9bb8da37ece'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = NULL,
    part.name_ko = 'Songerie vers ‘Jack’', part.name_en = 'Carnet d’esquisses et de croquis : Songerie vers ‘Jack’',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 9409 AND p.composer_id = 100 AND part.part_key = 'musicbrainz:4562684b-6267-4ec6-bfec-5e7ace8a5882' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:4562684b-6267-4ec6-bfec-5e7ace8a5882', 4, NULL, 'Songerie vers ‘Jack’', 'Carnet d’esquisses et de croquis : Songerie vers ‘Jack’', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 9409 AND p.composer_id = 100
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:4562684b-6267-4ec6-bfec-5e7ace8a5882'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 5, part.movement_number = NULL,
    part.name_ko = 'Choral', part.name_en = 'Carnet d’esquisses et de croquis : Choral',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 9409 AND p.composer_id = 100 AND part.part_key = 'musicbrainz:53337214-ccdd-4e18-9d61-e411571463d5' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:53337214-ccdd-4e18-9d61-e411571463d5', 5, NULL, 'Choral', 'Carnet d’esquisses et de croquis : Choral', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 9409 AND p.composer_id = 100
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:53337214-ccdd-4e18-9d61-e411571463d5'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 6, part.movement_number = NULL,
    part.name_ko = 'Petite Danse', part.name_en = 'Carnet d’esquisses et de croquis : Petite Danse',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 9409 AND p.composer_id = 100 AND part.part_key = 'musicbrainz:555f389b-f215-4e92-9521-181addea2a23' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:555f389b-f215-4e92-9521-181addea2a23', 6, NULL, 'Petite Danse', 'Carnet d’esquisses et de croquis : Petite Danse', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 9409 AND p.composer_id = 100
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:555f389b-f215-4e92-9521-181addea2a23'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 7, part.movement_number = NULL,
    part.name_ko = 'Esquisses & sketch montmartois', part.name_en = 'Carnet d’esquisses et de croquis : Esquisses & sketch montmartois',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 9409 AND p.composer_id = 100 AND part.part_key = 'musicbrainz:5badf93b-b227-452c-bcd4-05a1b7c2e33f' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:5badf93b-b227-452c-bcd4-05a1b7c2e33f', 7, NULL, 'Esquisses & sketch montmartois', 'Carnet d’esquisses et de croquis : Esquisses & sketch montmartois', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 9409 AND p.composer_id = 100
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:5badf93b-b227-452c-bcd4-05a1b7c2e33f'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:5badf93b-b227-452c-bcd4-05a1b7c2e33f'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'Esquisses & sketch montmartois no. 1. Petit prélude de la “mort de monsieur Mouche”', part.name_en = 'Carnet d’esquisses et de croquis : Esquisses & sketch montmartois no. 1. Petit prélude de la “mort de monsieur Mouche”',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 9409 AND p.composer_id = 100 AND part.part_key = 'musicbrainz:3d8ea1b1-3a56-43ed-9e6d-b54c0938f161' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:3d8ea1b1-3a56-43ed-9e6d-b54c0938f161', 1, NULL, 'Esquisses & sketch montmartois no. 1. Petit prélude de la “mort de monsieur Mouche”', 'Carnet d’esquisses et de croquis : Esquisses & sketch montmartois no. 1. Petit prélude de la “mort de monsieur Mouche”', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:5badf93b-b227-452c-bcd4-05a1b7c2e33f'
WHERE p.id = 9409 AND p.composer_id = 100
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:3d8ea1b1-3a56-43ed-9e6d-b54c0938f161'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:5badf93b-b227-452c-bcd4-05a1b7c2e33f'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'Esquisses & sketch montmartois no. 2. Gambades', part.name_en = 'Carnet d’esquisses et de croquis : Esquisses & sketch montmartois no. 2. Gambades',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 9409 AND p.composer_id = 100 AND part.part_key = 'musicbrainz:a7a844db-84da-4b85-b679-15e41497caef' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:a7a844db-84da-4b85-b679-15e41497caef', 2, NULL, 'Esquisses & sketch montmartois no. 2. Gambades', 'Carnet d’esquisses et de croquis : Esquisses & sketch montmartois no. 2. Gambades', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:5badf93b-b227-452c-bcd4-05a1b7c2e33f'
WHERE p.id = 9409 AND p.composer_id = 100
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:a7a844db-84da-4b85-b679-15e41497caef'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 8, part.movement_number = NULL,
    part.name_ko = 'Le Prisonnier maussade', part.name_en = 'Carnet d’esquisses et de croquis : Le Prisonnier maussade',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 9409 AND p.composer_id = 100 AND part.part_key = 'musicbrainz:a2ee3ef2-5d77-45d2-ad02-2fba2783cec2' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:a2ee3ef2-5d77-45d2-ad02-2fba2783cec2', 8, NULL, 'Le Prisonnier maussade', 'Carnet d’esquisses et de croquis : Le Prisonnier maussade', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 9409 AND p.composer_id = 100
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:a2ee3ef2-5d77-45d2-ad02-2fba2783cec2'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 9, part.movement_number = NULL,
    part.name_ko = 'Air', part.name_en = 'Carnet d’esquisses et de croquis : Air',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 9409 AND p.composer_id = 100 AND part.part_key = 'musicbrainz:d30566cc-eee0-49fc-8e05-d1bf0b293b15' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:d30566cc-eee0-49fc-8e05-d1bf0b293b15', 9, NULL, 'Air', 'Carnet d’esquisses et de croquis : Air', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 9409 AND p.composer_id = 100
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:d30566cc-eee0-49fc-8e05-d1bf0b293b15'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 10, part.movement_number = NULL,
    part.name_ko = 'Bribes', part.name_en = 'Carnet d’esquisses et de croquis : Bribes',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 9409 AND p.composer_id = 100 AND part.part_key = 'musicbrainz:ee2f63e1-3f07-4043-a24a-5dcd0a90bfef' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:ee2f63e1-3f07-4043-a24a-5dcd0a90bfef', 10, NULL, 'Bribes', 'Carnet d’esquisses et de croquis : Bribes', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 9409 AND p.composer_id = 100
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:ee2f63e1-3f07-4043-a24a-5dcd0a90bfef'
);


-- None Chanson médiévale

UPDATE pieces piece
SET piece.title = 'Chanson médiévale', piece.title_en = 'Chanson médiévale',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 9294 AND piece.composer_id = 100
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- Op. 52 가곡 <Chanson>

UPDATE pieces piece
SET piece.title = '가곡 <Chanson>', piece.title_en = 'Chanson, op. 52',
    piece.type = 'song', piece.opus_number = 'Op. 52',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 7645 AND piece.composer_id = 100
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Chapitres tournés en tous sens

UPDATE pieces piece
SET piece.title = 'Chapitres tournés en tous sens', piece.title_en = 'Chapitres tournés en tous sens',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 8543 AND piece.composer_id = 100
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'Celle qui parle trop', part.name_en = 'Chapitres tournés en tous sens : I. Celle qui parle trop',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 8543 AND p.composer_id = 100 AND part.part_key = 'musicbrainz:792d2716-92f0-3655-86b5-296e5b943aea' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:792d2716-92f0-3655-86b5-296e5b943aea', 1, 'I', 'Celle qui parle trop', 'Chapitres tournés en tous sens : I. Celle qui parle trop', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 8543 AND p.composer_id = 100
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:792d2716-92f0-3655-86b5-296e5b943aea'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'Le Porteur de grosses pierres', part.name_en = 'Chapitres tournés en tous sens : II. Le Porteur de grosses pierres',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 8543 AND p.composer_id = 100 AND part.part_key = 'musicbrainz:57dacffe-47e2-3ad2-83b5-c62010f48933' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:57dacffe-47e2-3ad2-83b5-c62010f48933', 2, 'II', 'Le Porteur de grosses pierres', 'Chapitres tournés en tous sens : II. Le Porteur de grosses pierres', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 8543 AND p.composer_id = 100
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:57dacffe-47e2-3ad2-83b5-c62010f48933'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = 'Regrets des enfermés', part.name_en = 'Chapitres tournés en tous sens : III. Regrets des enfermés',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 8543 AND p.composer_id = 100 AND part.part_key = 'musicbrainz:5f1d05cd-48d6-3c2d-9fc0-8391647556f5' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:5f1d05cd-48d6-3c2d-9fc0-8391647556f5', 3, 'III', 'Regrets des enfermés', 'Chapitres tournés en tous sens : III. Regrets des enfermés', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 8543 AND p.composer_id = 100
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:5f1d05cd-48d6-3c2d-9fc0-8391647556f5'
);


-- None Chez le docteur

UPDATE pieces piece
SET piece.title = 'Chez le docteur', piece.title_en = 'Chez le docteur',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 7621 AND piece.composer_id = 100
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Choses vues à droite et à gauche (sans lunettes)

UPDATE pieces piece
SET piece.title = 'Choses vues à droite et à gauche (sans lunettes)', piece.title_en = 'Choses vues à droite et à gauche (sans lunettes)',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 9255 AND piece.composer_id = 100
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'Choral hypocrite', part.name_en = 'Choses vues à droite et à gauche (sans lunettes): I. Choral hypocrite',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 9255 AND p.composer_id = 100 AND part.part_key = 'musicbrainz:ea055d16-3726-4803-9384-6c4da31d774c' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:ea055d16-3726-4803-9384-6c4da31d774c', 1, 'I', 'Choral hypocrite', 'Choses vues à droite et à gauche (sans lunettes): I. Choral hypocrite', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 9255 AND p.composer_id = 100
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:ea055d16-3726-4803-9384-6c4da31d774c'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'Fugue à tâtons', part.name_en = 'Choses vues à droite et à gauche (sans lunettes): II. Fugue à tâtons',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 9255 AND p.composer_id = 100 AND part.part_key = 'musicbrainz:2678cdde-3ae6-4cf2-9ec4-0d7caf6ff968' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:2678cdde-3ae6-4cf2-9ec4-0d7caf6ff968', 2, 'II', 'Fugue à tâtons', 'Choses vues à droite et à gauche (sans lunettes): II. Fugue à tâtons', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 9255 AND p.composer_id = 100
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:2678cdde-3ae6-4cf2-9ec4-0d7caf6ff968'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = 'Fantaisie musculaire', part.name_en = 'Choses vues à droite et à gauche (sans lunettes): III. Fantaisie musculaire',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 9255 AND p.composer_id = 100 AND part.part_key = 'musicbrainz:2426a82c-b24c-4903-a565-5cd9e63ab586' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:2426a82c-b24c-4903-a565-5cd9e63ab586', 3, 'III', 'Fantaisie musculaire', 'Choses vues à droite et à gauche (sans lunettes): III. Fantaisie musculaire', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 9255 AND p.composer_id = 100
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:2426a82c-b24c-4903-a565-5cd9e63ab586'
);


-- None Cinq Grimaces (pour “Le Songe d’une Nuit d’Été”)

UPDATE pieces piece
SET piece.title = 'Cinq Grimaces (pour “Le Songe d’une Nuit d’Été”)', piece.title_en = 'Cinq Grimaces (pour “Le Songe d’une Nuit d’Été”)',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 10576 AND piece.composer_id = 100
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'Préambule', part.name_en = 'Cinq Grimaces (pour “Le Songe d’une Nuit d’Été”) : I. Préambule',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 10576 AND p.composer_id = 100 AND part.part_key = 'musicbrainz:a4a5d296-fbc3-4e97-ac25-57ff87db4c8d' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:a4a5d296-fbc3-4e97-ac25-57ff87db4c8d', 1, 'I', 'Préambule', 'Cinq Grimaces (pour “Le Songe d’une Nuit d’Été”) : I. Préambule', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 10576 AND p.composer_id = 100
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:a4a5d296-fbc3-4e97-ac25-57ff87db4c8d'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'Coquecigrue', part.name_en = 'Cinq Grimaces (pour “Le Songe d’une Nuit d’Été”) : II. Coquecigrue',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 10576 AND p.composer_id = 100 AND part.part_key = 'musicbrainz:ee0d4ac7-fd6e-415e-b84c-adfc2f5d8900' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:ee0d4ac7-fd6e-415e-b84c-adfc2f5d8900', 2, 'II', 'Coquecigrue', 'Cinq Grimaces (pour “Le Songe d’une Nuit d’Été”) : II. Coquecigrue', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 10576 AND p.composer_id = 100
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:ee0d4ac7-fd6e-415e-b84c-adfc2f5d8900'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = 'Chasse', part.name_en = 'Cinq Grimaces (pour “Le Songe d’une Nuit d’Été”) : III. Chasse',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 10576 AND p.composer_id = 100 AND part.part_key = 'musicbrainz:bf02dd1f-118e-4de4-a0d6-f5f3cb03c4d1' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:bf02dd1f-118e-4de4-a0d6-f5f3cb03c4d1', 3, 'III', 'Chasse', 'Cinq Grimaces (pour “Le Songe d’une Nuit d’Été”) : III. Chasse', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 10576 AND p.composer_id = 100
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:bf02dd1f-118e-4de4-a0d6-f5f3cb03c4d1'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = 'IV',
    part.name_ko = 'Fanfaronnade', part.name_en = 'Cinq Grimaces (pour “Le Songe d’une Nuit d’Été”) : IV. Fanfaronnade',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 10576 AND p.composer_id = 100 AND part.part_key = 'musicbrainz:1330e80c-caf9-49b8-8287-252fae6debad' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:1330e80c-caf9-49b8-8287-252fae6debad', 4, 'IV', 'Fanfaronnade', 'Cinq Grimaces (pour “Le Songe d’une Nuit d’Été”) : IV. Fanfaronnade', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 10576 AND p.composer_id = 100
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:1330e80c-caf9-49b8-8287-252fae6debad'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 5, part.movement_number = 'V',
    part.name_ko = 'Retraite (pour sortir)', part.name_en = 'Cinq Grimaces (pour “Le Songe d’une Nuit d’Été”) : V. Retraite (pour sortir)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 10576 AND p.composer_id = 100 AND part.part_key = 'musicbrainz:026be6de-e405-4c82-be4c-8ed6d05d63e1' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:026be6de-e405-4c82-be4c-8ed6d05d63e1', 5, 'V', 'Retraite (pour sortir)', 'Cinq Grimaces (pour “Le Songe d’une Nuit d’Été”) : V. Retraite (pour sortir)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 10576 AND p.composer_id = 100
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:026be6de-e405-4c82-be4c-8ed6d05d63e1'
);


-- None Cinq Nocturnes

UPDATE pieces piece
SET piece.title = 'Cinq Nocturnes', piece.title_en = 'Cinq Nocturnes',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 10500 AND piece.composer_id = 100
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'Doux et calme', part.name_en = 'Cinq Nocturnes : No. 1. Doux et calme',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 10500 AND p.composer_id = 100 AND part.part_key = 'musicbrainz:1379f89c-31a2-3000-bf1c-ea1d43b259d9' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:1379f89c-31a2-3000-bf1c-ea1d43b259d9', 1, NULL, 'Doux et calme', 'Cinq Nocturnes : No. 1. Doux et calme', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 10500 AND p.composer_id = 100
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:1379f89c-31a2-3000-bf1c-ea1d43b259d9'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'Simplement', part.name_en = 'Cinq Nocturnes : No. 2. Simplement',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 10500 AND p.composer_id = 100 AND part.part_key = 'musicbrainz:3f5bac10-3131-31a1-a26b-4decee33bc40' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:3f5bac10-3131-31a1-a26b-4decee33bc40', 2, NULL, 'Simplement', 'Cinq Nocturnes : No. 2. Simplement', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 10500 AND p.composer_id = 100
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:3f5bac10-3131-31a1-a26b-4decee33bc40'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = NULL,
    part.name_ko = 'Un peu mouvementé', part.name_en = 'Cinq Nocturnes : No. 3. Un peu mouvementé',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 10500 AND p.composer_id = 100 AND part.part_key = 'musicbrainz:c376cb91-937e-3281-bc03-d721e40a8c33' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:c376cb91-937e-3281-bc03-d721e40a8c33', 3, NULL, 'Un peu mouvementé', 'Cinq Nocturnes : No. 3. Un peu mouvementé', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 10500 AND p.composer_id = 100
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:c376cb91-937e-3281-bc03-d721e40a8c33'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = NULL,
    part.name_ko = '♪ = 92', part.name_en = 'Cinq Nocturnes : No. 4. ♪ = 92',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 10500 AND p.composer_id = 100 AND part.part_key = 'musicbrainz:066e680b-1680-3d4b-88d2-8d9ac938d587' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:066e680b-1680-3d4b-88d2-8d9ac938d587', 4, NULL, '♪ = 92', 'Cinq Nocturnes : No. 4. ♪ = 92', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 10500 AND p.composer_id = 100
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:066e680b-1680-3d4b-88d2-8d9ac938d587'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 5, part.movement_number = NULL,
    part.name_ko = '♩𝅭 = 60', part.name_en = 'Cinq Nocturnes : No. 5. ♩𝅭 = 60',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 10500 AND p.composer_id = 100 AND part.part_key = 'musicbrainz:7316e992-1303-3f76-a2f2-21b9ce24e0aa' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:7316e992-1303-3f76-a2f2-21b9ce24e0aa', 5, NULL, '♩𝅭 = 60', 'Cinq Nocturnes : No. 5. ♩𝅭 = 60', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 10500 AND p.composer_id = 100
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:7316e992-1303-3f76-a2f2-21b9ce24e0aa'
);


-- None Croquis et agaceries d’un gros bonhomme en bois

UPDATE pieces piece
SET piece.title = 'Croquis et agaceries d’un gros bonhomme en bois', piece.title_en = 'Croquis et agaceries d’un gros bonhomme en bois',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 8623 AND piece.composer_id = 100
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'Tyrolienne turque', part.name_en = 'Croquis et agaceries d''un gros bonhomme en bois : I. Tyrolienne turque',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 8623 AND p.composer_id = 100 AND part.part_key = 'musicbrainz:25fbc112-aaeb-4cf3-9fb2-8eba178e6bd0' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:25fbc112-aaeb-4cf3-9fb2-8eba178e6bd0', 1, 'I', 'Tyrolienne turque', 'Croquis et agaceries d''un gros bonhomme en bois : I. Tyrolienne turque', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 8623 AND p.composer_id = 100
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:25fbc112-aaeb-4cf3-9fb2-8eba178e6bd0'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'Danse maigre (à la manière de ces messieurs)', part.name_en = 'Croquis et agaceries d''un gros bonhomme en bois : II. Danse maigre (à la manière de ces messieurs)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 8623 AND p.composer_id = 100 AND part.part_key = 'musicbrainz:cac80505-5d82-4031-98e1-da41ec4c5ef3' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:cac80505-5d82-4031-98e1-da41ec4c5ef3', 2, 'II', 'Danse maigre (à la manière de ces messieurs)', 'Croquis et agaceries d''un gros bonhomme en bois : II. Danse maigre (à la manière de ces messieurs)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 8623 AND p.composer_id = 100
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:cac80505-5d82-4031-98e1-da41ec4c5ef3'
);


-- None Danse de travers (Avant-première en forme d’air à faire fuir)

UPDATE pieces piece
SET piece.title = 'Danse de travers (Avant-première en forme d’air à faire fuir)', piece.title_en = 'Danse de travers (Avant-première en forme d’air à faire fuir)',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 9450 AND piece.composer_id = 100
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Danse de travers II

UPDATE pieces piece
SET piece.title = 'Danse de travers II', piece.title_en = 'Danse de travers II',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 9711 AND piece.composer_id = 100
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None 가곡 <Daphénéo>

UPDATE pieces piece
SET piece.title = '가곡 <Daphénéo>', piece.title_en = 'Daphénéo',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 7647 AND piece.composer_id = 100
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Descriptions automatiques

UPDATE pieces piece
SET piece.title = 'Descriptions automatiques', piece.title_en = 'Descriptions automatiques',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 10960 AND piece.composer_id = 100
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'Sur un vaisseau', part.name_en = 'Descriptions automatiques : I. Sur un vaisseau',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 10960 AND p.composer_id = 100 AND part.part_key = 'musicbrainz:a3c295af-afdc-427c-b40b-85aa2d1dff6a' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:a3c295af-afdc-427c-b40b-85aa2d1dff6a', 1, 'I', 'Sur un vaisseau', 'Descriptions automatiques : I. Sur un vaisseau', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 10960 AND p.composer_id = 100
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:a3c295af-afdc-427c-b40b-85aa2d1dff6a'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'Sur une lanterne', part.name_en = 'Descriptions automatiques : II. Sur une lanterne',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 10960 AND p.composer_id = 100 AND part.part_key = 'musicbrainz:fa774b3d-46b1-4fa0-8d29-19e30adcaf25' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:fa774b3d-46b1-4fa0-8d29-19e30adcaf25', 2, 'II', 'Sur une lanterne', 'Descriptions automatiques : II. Sur une lanterne', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 10960 AND p.composer_id = 100
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:fa774b3d-46b1-4fa0-8d29-19e30adcaf25'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = 'Sur un casque', part.name_en = 'Descriptions automatiques : III. Sur un casque',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 10960 AND p.composer_id = 100 AND part.part_key = 'musicbrainz:9418d319-659c-4125-a075-a27cf1716387' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:9418d319-659c-4125-a075-a27cf1716387', 3, 'III', 'Sur un casque', 'Descriptions automatiques : III. Sur un casque', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 10960 AND p.composer_id = 100
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:9418d319-659c-4125-a075-a27cf1716387'
);


-- None Deux rêveries nocturnes

UPDATE pieces piece
SET piece.title = 'Deux rêveries nocturnes', piece.title_en = 'Deux rêveries nocturnes',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 9709 AND piece.composer_id = 100
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'Pas vite', part.name_en = 'Deux Rêveries nocturnes : No. 1. Pas vite',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 9709 AND p.composer_id = 100 AND part.part_key = 'musicbrainz:1ff4087c-0421-3062-ab81-2f081294179e' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:1ff4087c-0421-3062-ab81-2f081294179e', 1, NULL, 'Pas vite', 'Deux Rêveries nocturnes : No. 1. Pas vite', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 9709 AND p.composer_id = 100
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:1ff4087c-0421-3062-ab81-2f081294179e'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'Très modérément', part.name_en = 'Deux Rêveries nocturnes : No. 2. Très modérément',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 9709 AND p.composer_id = 100 AND part.part_key = 'musicbrainz:cfd63167-8fbd-3250-ab29-0bbf0f3858e1' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:cfd63167-8fbd-3250-ab29-0bbf0f3858e1', 2, NULL, 'Très modérément', 'Deux Rêveries nocturnes : No. 2. Très modérément', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 9709 AND p.composer_id = 100
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:cfd63167-8fbd-3250-ab29-0bbf0f3858e1'
);


-- None Embarquement pour Cythère

UPDATE pieces piece
SET piece.title = 'Embarquement pour Cythère', piece.title_en = 'Embarquement pour Cythère',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 7757 AND piece.composer_id = 100
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Embryons desséchés

UPDATE pieces piece
SET piece.title = 'Embryons desséchés', piece.title_en = 'Embryons desséchés',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 10456 AND piece.composer_id = 100
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'd’Holothurie', part.name_en = 'Embryons desséchés : I. d’Holothurie',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 10456 AND p.composer_id = 100 AND part.part_key = 'musicbrainz:401af7f6-f65e-3c43-ad53-3496ce8394c6' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:401af7f6-f65e-3c43-ad53-3496ce8394c6', 1, 'I', 'd’Holothurie', 'Embryons desséchés : I. d’Holothurie', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 10456 AND p.composer_id = 100
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:401af7f6-f65e-3c43-ad53-3496ce8394c6'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'd’Edriopthalma', part.name_en = 'Embryons desséchés : II. d’Edriopthalma',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 10456 AND p.composer_id = 100 AND part.part_key = 'musicbrainz:b1f98c6f-6873-31e5-91bd-fde8428d30c2' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:b1f98c6f-6873-31e5-91bd-fde8428d30c2', 2, 'II', 'd’Edriopthalma', 'Embryons desséchés : II. d’Edriopthalma', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 10456 AND p.composer_id = 100
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:b1f98c6f-6873-31e5-91bd-fde8428d30c2'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = 'de Podophthalma', part.name_en = 'Embryons desséchés : III. de Podophthalma',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 10456 AND p.composer_id = 100 AND part.part_key = 'musicbrainz:e8057d24-6fe6-354e-902a-af521764b42b' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:e8057d24-6fe6-354e-902a-af521764b42b', 3, 'III', 'de Podophthalma', 'Embryons desséchés : III. de Podophthalma', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 10456 AND p.composer_id = 100
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:e8057d24-6fe6-354e-902a-af521764b42b'
);


-- None Enfantillages pittoresques

UPDATE pieces piece
SET piece.title = 'Enfantillages pittoresques', piece.title_en = 'Enfantillages pittoresques',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 8849 AND piece.composer_id = 100
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'Petit Prélude à la journée (modéré)', part.name_en = 'Enfantillages pittoresques : I. Petit Prélude à la journée (modéré)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 8849 AND p.composer_id = 100 AND part.part_key = 'musicbrainz:020c60b0-5de6-4c72-b0ca-1fedae1349c9' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:020c60b0-5de6-4c72-b0ca-1fedae1349c9', 1, 'I', 'Petit Prélude à la journée (modéré)', 'Enfantillages pittoresques : I. Petit Prélude à la journée (modéré)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 8849 AND p.composer_id = 100
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:020c60b0-5de6-4c72-b0ca-1fedae1349c9'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'Berceuse (lent)', part.name_en = 'Enfantillages pittoresques : II. Berceuse (lent)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 8849 AND p.composer_id = 100 AND part.part_key = 'musicbrainz:178595f2-7f07-4841-af02-1fb85b741efd' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:178595f2-7f07-4841-af02-1fb85b741efd', 2, 'II', 'Berceuse (lent)', 'Enfantillages pittoresques : II. Berceuse (lent)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 8849 AND p.composer_id = 100
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:178595f2-7f07-4841-af02-1fb85b741efd'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = 'Marche du grand escalier', part.name_en = 'Enfantillages pittoresques : III. Marche du grand escalier',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 8849 AND p.composer_id = 100 AND part.part_key = 'musicbrainz:0ea78179-3f59-4b91-9d11-e07e08314656' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:0ea78179-3f59-4b91-9d11-e07e08314656', 3, 'III', 'Marche du grand escalier', 'Enfantillages pittoresques : III. Marche du grand escalier', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 8849 AND p.composer_id = 100
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:0ea78179-3f59-4b91-9d11-e07e08314656'
);


-- None Esquisses bitonales

UPDATE pieces piece
SET piece.title = 'Esquisses bitonales', piece.title_en = 'Esquisses bitonales',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 9489 AND piece.composer_id = 100
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'Esquisse no. 3', part.name_en = 'Esquisses bitonales : Esquisse no. 3',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 9489 AND p.composer_id = 100 AND part.part_key = 'musicbrainz:00be36b0-576d-431a-b89a-3eb17a89df0f' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:00be36b0-576d-431a-b89a-3eb17a89df0f', 1, NULL, 'Esquisse no. 3', 'Esquisses bitonales : Esquisse no. 3', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 9489 AND p.composer_id = 100
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:00be36b0-576d-431a-b89a-3eb17a89df0f'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'Esquisse no. 2', part.name_en = 'Esquisses bitonales : Esquisse no. 2',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 9489 AND p.composer_id = 100 AND part.part_key = 'musicbrainz:41ca5b0e-0781-4d04-8cbd-8c65bba1205d' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:41ca5b0e-0781-4d04-8cbd-8c65bba1205d', 2, NULL, 'Esquisse no. 2', 'Esquisses bitonales : Esquisse no. 2', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 9489 AND p.composer_id = 100
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:41ca5b0e-0781-4d04-8cbd-8c65bba1205d'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = NULL,
    part.name_ko = 'Esquisse nos. 4 & 5', part.name_en = 'Esquisses bitonales : Esquisse nos. 4 & 5',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 9489 AND p.composer_id = 100 AND part.part_key = 'musicbrainz:8347b052-3c1e-4b39-8a51-0fb02deed9aa' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:8347b052-3c1e-4b39-8a51-0fb02deed9aa', 3, NULL, 'Esquisse nos. 4 & 5', 'Esquisses bitonales : Esquisse nos. 4 & 5', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 9489 AND p.composer_id = 100
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:8347b052-3c1e-4b39-8a51-0fb02deed9aa'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = NULL,
    part.name_ko = 'Esquisse no. 1', part.name_en = 'Esquisses bitonales : Esquisse no. 1',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 9489 AND p.composer_id = 100 AND part.part_key = 'musicbrainz:a4bc973a-f6c4-43f2-909a-913a2a7fe4dc' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:a4bc973a-f6c4-43f2-909a-913a2a7fe4dc', 4, NULL, 'Esquisse no. 1', 'Esquisses bitonales : Esquisse no. 1', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 9489 AND p.composer_id = 100
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:a4bc973a-f6c4-43f2-909a-913a2a7fe4dc'
);


-- None Fantaisie‐valse

UPDATE pieces piece
SET piece.title = 'Fantaisie‐valse', piece.title_en = 'Fantaisie‐valse',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 7639 AND piece.composer_id = 100
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Fugue-valse

UPDATE pieces piece
SET piece.title = 'Fugue-valse', piece.title_en = 'Fugue-valse',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 8966 AND piece.composer_id = 100
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Heures séculaires et Instantanées

UPDATE pieces piece
SET piece.title = 'Heures séculaires et Instantanées', piece.title_en = 'Heures séculaires et Instantanées',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 8000 AND piece.composer_id = 100
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'Obstacles venimeux', part.name_en = 'Heures séculaires et instantanées : No. 1. Obstacles venimeux',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 8000 AND p.composer_id = 100 AND part.part_key = 'musicbrainz:9da34a9c-69da-3fe3-84a7-8a5458f2b81e' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:9da34a9c-69da-3fe3-84a7-8a5458f2b81e', 1, NULL, 'Obstacles venimeux', 'Heures séculaires et instantanées : No. 1. Obstacles venimeux', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 8000 AND p.composer_id = 100
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:9da34a9c-69da-3fe3-84a7-8a5458f2b81e'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'Crépuscule matinal (de midi)', part.name_en = 'Heures séculaires et instantanées : No. 2. Crépuscule matinal (de midi)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 8000 AND p.composer_id = 100 AND part.part_key = 'musicbrainz:2a30e1ca-3244-3194-b492-06836ffd3b5d' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:2a30e1ca-3244-3194-b492-06836ffd3b5d', 2, NULL, 'Crépuscule matinal (de midi)', 'Heures séculaires et instantanées : No. 2. Crépuscule matinal (de midi)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 8000 AND p.composer_id = 100
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:2a30e1ca-3244-3194-b492-06836ffd3b5d'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = NULL,
    part.name_ko = 'Affolements grantiques', part.name_en = 'Heures séculaires et instantanées : No. 3. Affolements grantiques',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 8000 AND p.composer_id = 100 AND part.part_key = 'musicbrainz:943b31d1-e921-36b1-bbf1-2c890bbf4e34' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:943b31d1-e921-36b1-bbf1-2c890bbf4e34', 3, NULL, 'Affolements grantiques', 'Heures séculaires et instantanées : No. 3. Affolements grantiques', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 8000 AND p.composer_id = 100
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:943b31d1-e921-36b1-bbf1-2c890bbf4e34'
);


-- None Illusion

UPDATE pieces piece
SET piece.title = 'Illusion', piece.title_en = 'Illusion',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 11194 AND piece.composer_id = 100
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None 가곡 <Imperial-Oxford>

UPDATE pieces piece
SET piece.title = '가곡 <Imperial-Oxford>', piece.title_en = 'Imperial-Oxford',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 10181 AND piece.composer_id = 100
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None 가곡 <Improvisation>

UPDATE pieces piece
SET piece.title = '가곡 <Improvisation>', piece.title_en = 'Improvisation',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 8855 AND piece.composer_id = 100
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None 가곡 <J’avais un ami>

UPDATE pieces piece
SET piece.title = '가곡 <J’avais un ami>', piece.title_en = 'J’avais un ami',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 7780 AND piece.composer_id = 100
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None L'Enfance de Ko-quo (recommandations maternelles)

UPDATE pieces piece
SET piece.title = 'L''Enfance de Ko-quo (recommandations maternelles)', piece.title_en = 'L''Enfance de Ko-quo (recommandations maternelles)',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 10121 AND piece.composer_id = 100
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'Ne bois pas ton chocolat avec tes doigts', part.name_en = 'L''Enfance de Ko-quo (recommandations maternelles) : I. Ne bois pas ton chocolat avec tes doigts',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 10121 AND p.composer_id = 100 AND part.part_key = 'musicbrainz:698c9968-18f0-4850-9acd-c5c6931ca5c3' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:698c9968-18f0-4850-9acd-c5c6931ca5c3', 1, 'I', 'Ne bois pas ton chocolat avec tes doigts', 'L''Enfance de Ko-quo (recommandations maternelles) : I. Ne bois pas ton chocolat avec tes doigts', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 10121 AND p.composer_id = 100
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:698c9968-18f0-4850-9acd-c5c6931ca5c3'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'Ne souffle pas dans tes oreilles', part.name_en = 'L''Enfance de Ko-quo (recommandations maternelles) : II. Ne souffle pas dans tes oreilles',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 10121 AND p.composer_id = 100 AND part.part_key = 'musicbrainz:9bcb7221-fdba-47c5-96ee-f361cac17690' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:9bcb7221-fdba-47c5-96ee-f361cac17690', 2, 'II', 'Ne souffle pas dans tes oreilles', 'L''Enfance de Ko-quo (recommandations maternelles) : II. Ne souffle pas dans tes oreilles', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 10121 AND p.composer_id = 100
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:9bcb7221-fdba-47c5-96ee-f361cac17690'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = 'Ne mets pas ta tête sous ton bras', part.name_en = 'L''Enfance de Ko-quo (recommandations maternelles) : III. Ne mets pas ta tête sous ton bras',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 10121 AND p.composer_id = 100 AND part.part_key = 'musicbrainz:bd792445-6308-48c3-96b4-85a5d91b6b1d' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:bd792445-6308-48c3-96b4-85a5d91b6b1d', 3, 'III', 'Ne mets pas ta tête sous ton bras', 'L''Enfance de Ko-quo (recommandations maternelles) : III. Ne mets pas ta tête sous ton bras', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 10121 AND p.composer_id = 100
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:bd792445-6308-48c3-96b4-85a5d91b6b1d'
);


-- None 가곡 <L'Omnibus-automobile>

UPDATE pieces piece
SET piece.title = '가곡 <L''Omnibus-automobile>', piece.title_en = 'L''Omnibus-automobile',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 7641 AND piece.composer_id = 100
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None La Belle Excentrique (Fantasie sérieuse)

UPDATE pieces piece
SET piece.title = 'La Belle Excentrique (Fantasie sérieuse)', piece.title_en = 'La Belle Excentrique (Fantasie sérieuse)',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 8627 AND piece.composer_id = 100
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'Grande ritournelle. Pas trop vite', part.name_en = 'La Belle Excentrique (Fantasie sérieuse) : I. Grande ritournelle. Pas trop vite',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 8627 AND p.composer_id = 100 AND part.part_key = 'musicbrainz:732e9340-117f-32b2-a92a-9bc66e3473bb' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:732e9340-117f-32b2-a92a-9bc66e3473bb', 1, 'I', 'Grande ritournelle. Pas trop vite', 'La Belle Excentrique (Fantasie sérieuse) : I. Grande ritournelle. Pas trop vite', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 8627 AND p.composer_id = 100
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:732e9340-117f-32b2-a92a-9bc66e3473bb'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'Marche franco‐lunaire', part.name_en = 'La Belle Excentrique (Fantasie sérieuse): II. Marche franco‐lunaire',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 8627 AND p.composer_id = 100 AND part.part_key = 'musicbrainz:14a8ee2d-55d0-398e-8832-da3215119b2e' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:14a8ee2d-55d0-398e-8832-da3215119b2e', 2, 'II', 'Marche franco‐lunaire', 'La Belle Excentrique (Fantasie sérieuse): II. Marche franco‐lunaire', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 8627 AND p.composer_id = 100
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:14a8ee2d-55d0-398e-8832-da3215119b2e'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = 'Valse du “Mystérieux baiser dans l’œil”. Mouvement de valse', part.name_en = 'La Belle Excentrique (Fantasie sérieuse): III. Valse du “Mystérieux baiser dans l’œil”. Mouvement de valse',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 8627 AND p.composer_id = 100 AND part.part_key = 'musicbrainz:d5b3e5c0-7ae4-330a-8e11-59e0bcb75b8e' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:d5b3e5c0-7ae4-330a-8e11-59e0bcb75b8e', 3, 'III', 'Valse du “Mystérieux baiser dans l’œil”. Mouvement de valse', 'La Belle Excentrique (Fantasie sérieuse): III. Valse du “Mystérieux baiser dans l’œil”. Mouvement de valse', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 8627 AND p.composer_id = 100
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:d5b3e5c0-7ae4-330a-8e11-59e0bcb75b8e'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = 'IV',
    part.name_ko = 'Cancan grand-mondain. Galop', part.name_en = 'La Belle Excentrique (Fantasie sérieuse): IV. Cancan grand-mondain. Galop',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 8627 AND p.composer_id = 100 AND part.part_key = 'musicbrainz:3ac7c373-a008-3b68-8a2b-ba509ed12ebd' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:3ac7c373-a008-3b68-8a2b-ba509ed12ebd', 4, 'IV', 'Cancan grand-mondain. Galop', 'La Belle Excentrique (Fantasie sérieuse): IV. Cancan grand-mondain. Galop', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 8627 AND p.composer_id = 100
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:3ac7c373-a008-3b68-8a2b-ba509ed12ebd'
);


-- None 가곡 <La Chanson de Satie>

UPDATE pieces piece
SET piece.title = '가곡 <La Chanson de Satie>', piece.title_en = 'La Chanson de Satie',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 7655 AND piece.composer_id = 100
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None 가곡 <La Chemise>

UPDATE pieces piece
SET piece.title = '가곡 <La Chemise>', piece.title_en = 'La Chemise',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 9164 AND piece.composer_id = 100
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None La statue retrouvée (Divertissement pour trompette en ut et orgue)

UPDATE pieces piece
SET piece.title = 'La statue retrouvée (Divertissement pour trompette en ut et orgue)', piece.title_en = 'La statue retrouvée (Divertissement pour trompette en ut et orgue)',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 10887 AND piece.composer_id = 100
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None 부수음악 <Le Fils des étoiles>

UPDATE pieces piece
SET piece.title = '부수음악 <Le Fils des étoiles>', piece.title_en = 'Le Fils des étoiles',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 7998 AND piece.composer_id = 100
  AND piece.origin = 'seed' AND piece.editor_locked = 0;
INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '06438de8-7b69-4cd1-a565-87458f3e40ef'
FROM pieces p
WHERE p.id = 7998 AND p.composer_id = 100
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '06438de8-7b69-4cd1-a565-87458f3e40ef'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'Préludes - I. La Vocation (Modéré)', part.name_en = 'Le Fils des étoiles: Préludes - I. La Vocation (Modéré)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 7998 AND p.composer_id = 100 AND part.part_key = 'musicbrainz:d8b2ddaa-2f49-3d52-889e-e9a69d6e463d' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:d8b2ddaa-2f49-3d52-889e-e9a69d6e463d', 1, NULL, 'Préludes - I. La Vocation (Modéré)', 'Le Fils des étoiles: Préludes - I. La Vocation (Modéré)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 7998 AND p.composer_id = 100
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:d8b2ddaa-2f49-3d52-889e-e9a69d6e463d'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'Theme Decoratif: La Nuit Kaldee', part.name_en = 'Le Fils des étoiles: Theme Decoratif: La Nuit Kaldee',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 7998 AND p.composer_id = 100 AND part.part_key = 'musicbrainz:969344af-383d-46de-a805-1b29f69c6fcd' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:969344af-383d-46de-a805-1b29f69c6fcd', 2, NULL, 'Theme Decoratif: La Nuit Kaldee', 'Le Fils des étoiles: Theme Decoratif: La Nuit Kaldee', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 7998 AND p.composer_id = 100
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:969344af-383d-46de-a805-1b29f69c6fcd'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = NULL,
    part.name_ko = 'Préludes - II. L’Initiation (avec calme)', part.name_en = 'Le Fils des étoiles: Préludes - II. L’Initiation (avec calme)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 7998 AND p.composer_id = 100 AND part.part_key = 'musicbrainz:4d1f112c-1826-3872-a97e-447b47f665cd' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:4d1f112c-1826-3872-a97e-447b47f665cd', 3, NULL, 'Préludes - II. L’Initiation (avec calme)', 'Le Fils des étoiles: Préludes - II. L’Initiation (avec calme)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 7998 AND p.composer_id = 100
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:4d1f112c-1826-3872-a97e-447b47f665cd'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = NULL,
    part.name_ko = 'Theme Decoratif: La Salle Basse du Grand Temple', part.name_en = 'Le Fils des étoiles: Theme Decoratif: La Salle Basse du Grand Temple',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 7998 AND p.composer_id = 100 AND part.part_key = 'musicbrainz:9205d24d-ad14-4de9-a71d-346f2abe8107' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:9205d24d-ad14-4de9-a71d-346f2abe8107', 4, NULL, 'Theme Decoratif: La Salle Basse du Grand Temple', 'Le Fils des étoiles: Theme Decoratif: La Salle Basse du Grand Temple', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 7998 AND p.composer_id = 100
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:9205d24d-ad14-4de9-a71d-346f2abe8107'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 5, part.movement_number = NULL,
    part.name_ko = 'Préludes - III. L’Incantation (Très lent)', part.name_en = 'Le Fils des étoiles: Préludes - III. L’Incantation (Très lent)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 7998 AND p.composer_id = 100 AND part.part_key = 'musicbrainz:451576ce-c29a-30f3-baa0-7c99b47c15d4' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:451576ce-c29a-30f3-baa0-7c99b47c15d4', 5, NULL, 'Préludes - III. L’Incantation (Très lent)', 'Le Fils des étoiles: Préludes - III. L’Incantation (Très lent)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 7998 AND p.composer_id = 100
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:451576ce-c29a-30f3-baa0-7c99b47c15d4'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 6, part.movement_number = NULL,
    part.name_ko = 'Theme Decoratif: La Terrace du Palais du Patesi Goudea', part.name_en = 'Le Fils des étoiles: Theme Decoratif: La Terrace du Palais du Patesi Goudea',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 7998 AND p.composer_id = 100 AND part.part_key = 'musicbrainz:59aa99d0-c538-4aa9-a88d-8e6497d170d5' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:59aa99d0-c538-4aa9-a88d-8e6497d170d5', 6, NULL, 'Theme Decoratif: La Terrace du Palais du Patesi Goudea', 'Le Fils des étoiles: Theme Decoratif: La Terrace du Palais du Patesi Goudea', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 7998 AND p.composer_id = 100
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:59aa99d0-c538-4aa9-a88d-8e6497d170d5'
);


-- None Le Piccadilly

UPDATE pieces piece
SET piece.title = 'Le Piccadilly', piece.title_en = 'Le Piccadilly',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 7511 AND piece.composer_id = 100
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Le Poisson rêveur

UPDATE pieces piece
SET piece.title = 'Le Poisson rêveur', piece.title_en = 'Le Poisson rêveur',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 7561 AND piece.composer_id = 100
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None 가곡 <Le Veuf>

UPDATE pieces piece
SET piece.title = '가곡 <Le Veuf>', piece.title_en = 'Le Veuf',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 8877 AND piece.composer_id = 100
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Le Vizir autrichien

UPDATE pieces piece
SET piece.title = 'Le Vizir autrichien', piece.title_en = 'Le Vizir autrichien',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 10652 AND piece.composer_id = 100
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Leit-motiv du « Panthée »

UPDATE pieces piece
SET piece.title = 'Leit-motiv du « Panthée »', piece.title_en = 'Leit-motiv du « Panthée »',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 10089 AND piece.composer_id = 100
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Les Trois Valses distinguées du précieux dégoûté

UPDATE pieces piece
SET piece.title = 'Les Trois Valses distinguées du précieux dégoûté', piece.title_en = 'Les Trois Valses distinguées du précieux dégoûté',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 10980 AND piece.composer_id = 100
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'Sa taille', part.name_en = 'Les Trois Valses distinguées du précieux dégoûté : I. Sa taille',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 10980 AND p.composer_id = 100 AND part.part_key = 'musicbrainz:edb7657c-dc35-4ba3-a3d0-26f0613f60c1' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:edb7657c-dc35-4ba3-a3d0-26f0613f60c1', 1, 'I', 'Sa taille', 'Les Trois Valses distinguées du précieux dégoûté : I. Sa taille', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 10980 AND p.composer_id = 100
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:edb7657c-dc35-4ba3-a3d0-26f0613f60c1'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'Son binocle', part.name_en = 'Les Trois Valses distinguées du précieux dégoûté : II. Son binocle',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 10980 AND p.composer_id = 100 AND part.part_key = 'musicbrainz:26a36eee-f210-4476-8652-2e6617b4942d' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:26a36eee-f210-4476-8652-2e6617b4942d', 2, 'II', 'Son binocle', 'Les Trois Valses distinguées du précieux dégoûté : II. Son binocle', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 10980 AND p.composer_id = 100
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:26a36eee-f210-4476-8652-2e6617b4942d'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = 'Ses jambes', part.name_en = 'Les Trois Valses distinguées du précieux dégoûté : III. Ses jambes',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 10980 AND p.composer_id = 100 AND part.part_key = 'musicbrainz:141385d2-292e-4aa0-abc5-4381faf506f1' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:141385d2-292e-4aa0-abc5-4381faf506f1', 3, 'III', 'Ses jambes', 'Les Trois Valses distinguées du précieux dégoûté : III. Ses jambes', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 10980 AND p.composer_id = 100
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:141385d2-292e-4aa0-abc5-4381faf506f1'
);


-- None Les pantins dansent

UPDATE pieces piece
SET piece.title = 'Les pantins dansent', piece.title_en = 'Les pantins dansent',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 9499 AND piece.composer_id = 100
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Ludions

UPDATE pieces piece
SET piece.title = 'Ludions', piece.title_en = 'Ludions',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 7642 AND piece.composer_id = 100
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'Air du rat', part.name_en = 'Ludions: I. Air du rat',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 7642 AND p.composer_id = 100 AND part.part_key = 'musicbrainz:383712ea-fbd8-30f5-ad98-edf5627eb995' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:383712ea-fbd8-30f5-ad98-edf5627eb995', 1, 'I', 'Air du rat', 'Ludions: I. Air du rat', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 7642 AND p.composer_id = 100
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:383712ea-fbd8-30f5-ad98-edf5627eb995'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'Spleen', part.name_en = 'Ludions: II. Spleen',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 7642 AND p.composer_id = 100 AND part.part_key = 'musicbrainz:bb0c5718-d57e-3066-9d34-35aef0596eb5' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:bb0c5718-d57e-3066-9d34-35aef0596eb5', 2, 'II', 'Spleen', 'Ludions: II. Spleen', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 7642 AND p.composer_id = 100
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:bb0c5718-d57e-3066-9d34-35aef0596eb5'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = 'La Grenouille américaine', part.name_en = 'Ludions: III. La Grenouille américaine',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 7642 AND p.composer_id = 100 AND part.part_key = 'musicbrainz:44c98256-fd59-46a4-ac49-9d6cf771be43' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:44c98256-fd59-46a4-ac49-9d6cf771be43', 3, 'III', 'La Grenouille américaine', 'Ludions: III. La Grenouille américaine', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 7642 AND p.composer_id = 100
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:44c98256-fd59-46a4-ac49-9d6cf771be43'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = 'IV',
    part.name_ko = 'Air du poète', part.name_en = 'Ludions: IV. Air du poète',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 7642 AND p.composer_id = 100 AND part.part_key = 'musicbrainz:83d5ff34-a1cc-4574-aa6d-63546fa2412e' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:83d5ff34-a1cc-4574-aa6d-63546fa2412e', 4, 'IV', 'Air du poète', 'Ludions: IV. Air du poète', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 7642 AND p.composer_id = 100
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:83d5ff34-a1cc-4574-aa6d-63546fa2412e'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 5, part.movement_number = 'V',
    part.name_ko = 'Chanson du chat', part.name_en = 'Ludions: V. Chanson du chat',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 7642 AND p.composer_id = 100 AND part.part_key = 'musicbrainz:f95b04b9-7e44-41ce-b585-2bd8d0775e96' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:f95b04b9-7e44-41ce-b585-2bd8d0775e96', 5, 'V', 'Chanson du chat', 'Ludions: V. Chanson du chat', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 7642 AND p.composer_id = 100
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:f95b04b9-7e44-41ce-b585-2bd8d0775e96'
);


-- None Légende californienne

UPDATE pieces piece
SET piece.title = 'Légende californienne', piece.title_en = 'Légende californienne',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 9949 AND piece.composer_id = 100
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Menus Propos Enfantins

UPDATE pieces piece
SET piece.title = 'Menus Propos Enfantins', piece.title_en = 'Menus Propos Enfantins',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 10313 AND piece.composer_id = 100
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'Chant guerrier du roi des haricots (mouvement de marche)', part.name_en = 'Menus Propos Enfantins: I. Chant guerrier du roi des haricots (mouvement de marche)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 10313 AND p.composer_id = 100 AND part.part_key = 'musicbrainz:05ce4e29-5d6c-49e9-955b-f093c13dc659' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:05ce4e29-5d6c-49e9-955b-f093c13dc659', 1, 'I', 'Chant guerrier du roi des haricots (mouvement de marche)', 'Menus Propos Enfantins: I. Chant guerrier du roi des haricots (mouvement de marche)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 10313 AND p.composer_id = 100
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:05ce4e29-5d6c-49e9-955b-f093c13dc659'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'Ce que dit la petite princesse des tulipes (très lent)', part.name_en = 'Menus Propos Enfantins: II. Ce que dit la petite princesse des tulipes (très lent)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 10313 AND p.composer_id = 100 AND part.part_key = 'musicbrainz:3555923b-b895-4de4-abde-2c57801e8588' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:3555923b-b895-4de4-abde-2c57801e8588', 2, 'II', 'Ce que dit la petite princesse des tulipes (très lent)', 'Menus Propos Enfantins: II. Ce que dit la petite princesse des tulipes (très lent)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 10313 AND p.composer_id = 100
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:3555923b-b895-4de4-abde-2c57801e8588'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = 'Valse du chocolat aux amandes (valse)', part.name_en = 'Menus Propos Enfantins: III. Valse du chocolat aux amandes (valse)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 10313 AND p.composer_id = 100 AND part.part_key = 'musicbrainz:2f1b3caa-de9e-47bc-aa1c-3b46f349c0cd' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:2f1b3caa-de9e-47bc-aa1c-3b46f349c0cd', 3, 'III', 'Valse du chocolat aux amandes (valse)', 'Menus Propos Enfantins: III. Valse du chocolat aux amandes (valse)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 10313 AND p.composer_id = 100
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:2f1b3caa-de9e-47bc-aa1c-3b46f349c0cd'
);


-- None Messe des pauvres

UPDATE pieces piece
SET piece.title = 'Messe des pauvres', piece.title_en = 'Messe des pauvres',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 9697 AND piece.composer_id = 100
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'Dixit Domine', part.name_en = 'Messe des Pauvres: Dixit Domine',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 9697 AND p.composer_id = 100 AND part.part_key = 'musicbrainz:2c0dc2c4-d75b-35bc-97a1-ac789eeadc32' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:2c0dc2c4-d75b-35bc-97a1-ac789eeadc32', 1, NULL, 'Dixit Domine', 'Messe des Pauvres: Dixit Domine', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 9697 AND p.composer_id = 100
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:2c0dc2c4-d75b-35bc-97a1-ac789eeadc32'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'Kyrie', part.name_en = 'Messe des Pauvres: Kyrie',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 9697 AND p.composer_id = 100 AND part.part_key = 'musicbrainz:3e694990-ee75-322d-afca-7f40910d4913' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:3e694990-ee75-322d-afca-7f40910d4913', 2, NULL, 'Kyrie', 'Messe des Pauvres: Kyrie', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 9697 AND p.composer_id = 100
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:3e694990-ee75-322d-afca-7f40910d4913'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = NULL,
    part.name_ko = 'Prière pour le salut de mon âme', part.name_en = 'Messe des Pauvres: Prière pour le salut de mon âme',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 9697 AND p.composer_id = 100 AND part.part_key = 'musicbrainz:4671f1de-7fd6-37db-b36e-ed9657b53fa2' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:4671f1de-7fd6-37db-b36e-ed9657b53fa2', 3, NULL, 'Prière pour le salut de mon âme', 'Messe des Pauvres: Prière pour le salut de mon âme', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 9697 AND p.composer_id = 100
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:4671f1de-7fd6-37db-b36e-ed9657b53fa2'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = NULL,
    part.name_ko = 'Chant Ecclésiastique', part.name_en = 'Messe des Pauvres: Chant Ecclésiastique',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 9697 AND p.composer_id = 100 AND part.part_key = 'musicbrainz:68b5f097-a8f0-344a-af5d-823bcebdc046' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:68b5f097-a8f0-344a-af5d-823bcebdc046', 4, NULL, 'Chant Ecclésiastique', 'Messe des Pauvres: Chant Ecclésiastique', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 9697 AND p.composer_id = 100
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:68b5f097-a8f0-344a-af5d-823bcebdc046'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 5, part.movement_number = NULL,
    part.name_ko = 'Commune qui mundi nefas', part.name_en = 'Messe des pauvres: Commune qui mundi nefas',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 9697 AND p.composer_id = 100 AND part.part_key = 'musicbrainz:d926e217-7b24-4547-9287-cf7328d95860' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:d926e217-7b24-4547-9287-cf7328d95860', 5, NULL, 'Commune qui mundi nefas', 'Messe des pauvres: Commune qui mundi nefas', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 9697 AND p.composer_id = 100
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:d926e217-7b24-4547-9287-cf7328d95860'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 6, part.movement_number = NULL,
    part.name_ko = 'Prière pour les voyageurs et les marins en danger de mort, à la très bonne et très auguste Vierge Marie, mère de Jésus', part.name_en = 'Messe des Pauvres: Prière pour les voyageurs et les marins en danger de mort, à la très bonne et très auguste Vierge Marie, mère de Jésus',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 9697 AND p.composer_id = 100 AND part.part_key = 'musicbrainz:de9b6db7-4c9b-38a5-8c35-2784cc1597b4' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:de9b6db7-4c9b-38a5-8c35-2784cc1597b4', 6, NULL, 'Prière pour les voyageurs et les marins en danger de mort, à la très bonne et très auguste Vierge Marie, mère de Jésus', 'Messe des Pauvres: Prière pour les voyageurs et les marins en danger de mort, à la très bonne et très auguste Vierge Marie, mère de Jésus', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 9697 AND p.composer_id = 100
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:de9b6db7-4c9b-38a5-8c35-2784cc1597b4'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 7, part.movement_number = NULL,
    part.name_ko = 'Prière des Orgues', part.name_en = 'Messe des pauvres: Prière des Orgues',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 9697 AND p.composer_id = 100 AND part.part_key = 'musicbrainz:f26de36e-61be-4036-9d13-c7bc3c1722c8' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:f26de36e-61be-4036-9d13-c7bc3c1722c8', 7, NULL, 'Prière des Orgues', 'Messe des pauvres: Prière des Orgues', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 9697 AND p.composer_id = 100
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:f26de36e-61be-4036-9d13-c7bc3c1722c8'
);


-- None Modéré

UPDATE pieces piece
SET piece.title = 'Modéré', piece.title_en = 'Modéré',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 9953 AND piece.composer_id = 100
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Musique d’ameublement: Tenture de cabinet préfectoral

UPDATE pieces piece
SET piece.title = 'Musique d’ameublement: Tenture de cabinet préfectoral', piece.title_en = 'Musique d’ameublement: Tenture de cabinet préfectoral',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 8179 AND piece.composer_id = 100
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Musiques intimes et secrètes

UPDATE pieces piece
SET piece.title = 'Musiques intimes et secrètes', piece.title_en = 'Musiques intimes et secrètes',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 9071 AND piece.composer_id = 100
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'fâcheux exemple', part.name_en = 'Musiques intimes et secrètes : fâcheux exemple',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 9071 AND p.composer_id = 100 AND part.part_key = 'musicbrainz:227b1484-e66f-4d56-ac4b-87758c40fa2a' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:227b1484-e66f-4d56-ac4b-87758c40fa2a', 1, NULL, 'fâcheux exemple', 'Musiques intimes et secrètes : fâcheux exemple', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 9071 AND p.composer_id = 100
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:227b1484-e66f-4d56-ac4b-87758c40fa2a'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'nostalgie', part.name_en = 'Musiques intimes et secrètes : nostalgie',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 9071 AND p.composer_id = 100 AND part.part_key = 'musicbrainz:77d84cb4-da99-4b28-b71c-c207b5b1a189' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:77d84cb4-da99-4b28-b71c-c207b5b1a189', 2, NULL, 'nostalgie', 'Musiques intimes et secrètes : nostalgie', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 9071 AND p.composer_id = 100
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:77d84cb4-da99-4b28-b71c-c207b5b1a189'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = NULL,
    part.name_ko = 'froide songerie', part.name_en = 'Musiques intimes et secrètes : froide songerie',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 9071 AND p.composer_id = 100 AND part.part_key = 'musicbrainz:f1fdc459-d55f-4b0c-b2f7-b6fa72935326' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:f1fdc459-d55f-4b0c-b2f7-b6fa72935326', 3, NULL, 'froide songerie', 'Musiques intimes et secrètes : froide songerie', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 9071 AND p.composer_id = 100
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:f1fdc459-d55f-4b0c-b2f7-b6fa72935326'
);


-- None Nocturne en filigrane

UPDATE pieces piece
SET piece.title = 'Nocturne en filigrane', piece.title_en = 'Nocturne en filigrane',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 10704 AND piece.composer_id = 100
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Nostalgie

UPDATE pieces piece
SET piece.title = 'Nostalgie', piece.title_en = 'Nostalgie',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 9516 AND piece.composer_id = 100
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Nouvelles pièces froides

UPDATE pieces piece
SET piece.title = 'Nouvelles pièces froides', piece.title_en = 'Nouvelles pièces froides',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 10713 AND piece.composer_id = 100
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'Sur un mur', part.name_en = 'Nouvelles pièces froides : I. Sur un mur',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 10713 AND p.composer_id = 100 AND part.part_key = 'musicbrainz:13c729f0-2bfa-438a-9f9d-36764a94e34c' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:13c729f0-2bfa-438a-9f9d-36764a94e34c', 1, 'I', 'Sur un mur', 'Nouvelles pièces froides : I. Sur un mur', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 10713 AND p.composer_id = 100
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:13c729f0-2bfa-438a-9f9d-36764a94e34c'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'Sur un arbre', part.name_en = 'Nouvelles pièces froides : II. Sur un arbre',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 10713 AND p.composer_id = 100 AND part.part_key = 'musicbrainz:d2244aa0-050a-40a6-bb92-373821eb0224' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:d2244aa0-050a-40a6-bb92-373821eb0224', 2, 'II', 'Sur un arbre', 'Nouvelles pièces froides : II. Sur un arbre', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 10713 AND p.composer_id = 100
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:d2244aa0-050a-40a6-bb92-373821eb0224'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = 'Sur un pont', part.name_en = 'Nouvelles pièces froides : III. Sur un pont',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 10713 AND p.composer_id = 100 AND part.part_key = 'musicbrainz:045d72d2-783e-48f4-ba40-23ced0fa7e14' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:045d72d2-783e-48f4-ba40-23ced0fa7e14', 3, 'III', 'Sur un pont', 'Nouvelles pièces froides : III. Sur un pont', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 10713 AND p.composer_id = 100
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:045d72d2-783e-48f4-ba40-23ced0fa7e14'
);


-- None Pages mystiques

UPDATE pieces piece
SET piece.title = 'Pages mystiques', piece.title_en = 'Pages mystiques',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 10390 AND piece.composer_id = 100
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'Vexations', part.name_en = 'Vexations',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 10390 AND p.composer_id = 100 AND part.part_key = 'musicbrainz:2493bdd9-e59a-36f2-9e56-46cfb22f956e' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:2493bdd9-e59a-36f2-9e56-46cfb22f956e', 1, NULL, 'Vexations', 'Vexations', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 10390 AND p.composer_id = 100
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:2493bdd9-e59a-36f2-9e56-46cfb22f956e'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'Prière', part.name_en = 'Pages mystiques: Prière',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 10390 AND p.composer_id = 100 AND part.part_key = 'musicbrainz:ba27c5f1-763c-3008-b608-e0e0c4015d3a' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:ba27c5f1-763c-3008-b608-e0e0c4015d3a', 2, NULL, 'Prière', 'Pages mystiques: Prière', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 10390 AND p.composer_id = 100
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:ba27c5f1-763c-3008-b608-e0e0c4015d3a'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = NULL,
    part.name_ko = 'Harmonies 1, 2 & 3', part.name_en = 'Pages mystiques : Harmonies 1, 2 & 3',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 10390 AND p.composer_id = 100 AND part.part_key = 'musicbrainz:d48fb137-0449-3271-9aea-eac3ef861da4' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:d48fb137-0449-3271-9aea-eac3ef861da4', 3, NULL, 'Harmonies 1, 2 & 3', 'Pages mystiques : Harmonies 1, 2 & 3', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 10390 AND p.composer_id = 100
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:d48fb137-0449-3271-9aea-eac3ef861da4'
);


-- None Passacaille (pas trop vif)

UPDATE pieces piece
SET piece.title = 'Passacaille (pas trop vif)', piece.title_en = 'Passacaille (pas trop vif)',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 8404 AND piece.composer_id = 100
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Peccadilles importunes

UPDATE pieces piece
SET piece.title = 'Peccadilles importunes', piece.title_en = 'Peccadilles importunes',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 8945 AND piece.composer_id = 100
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'Être jaloux de son camarade qui a une grosse tête', part.name_en = 'Peccadilles importunes : I. Être jaloux de son camarade qui a une grosse tête',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 8945 AND p.composer_id = 100 AND part.part_key = 'musicbrainz:1e9c65c0-8682-4b56-9b39-ea698fa1bdee' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:1e9c65c0-8682-4b56-9b39-ea698fa1bdee', 1, 'I', 'Être jaloux de son camarade qui a une grosse tête', 'Peccadilles importunes : I. Être jaloux de son camarade qui a une grosse tête', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 8945 AND p.composer_id = 100
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:1e9c65c0-8682-4b56-9b39-ea698fa1bdee'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'Lui manger sa tartine', part.name_en = 'Peccadilles importunes : II. Lui manger sa tartine',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 8945 AND p.composer_id = 100 AND part.part_key = 'musicbrainz:e492bbb9-0b47-4296-ba0e-f73497a4cd3a' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:e492bbb9-0b47-4296-ba0e-f73497a4cd3a', 2, 'II', 'Lui manger sa tartine', 'Peccadilles importunes : II. Lui manger sa tartine', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 8945 AND p.composer_id = 100
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:e492bbb9-0b47-4296-ba0e-f73497a4cd3a'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = 'Profiter de ce qu''il a des cors aux pieds lui prendre son cerceau', part.name_en = 'Peccadilles importunes : III. Profiter de ce qu''il a des cors aux pieds lui prendre son cerceau',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 8945 AND p.composer_id = 100 AND part.part_key = 'musicbrainz:651ea598-fe81-400b-974a-53f2a2fe61a4' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:651ea598-fe81-400b-974a-53f2a2fe61a4', 3, 'III', 'Profiter de ce qu''il a des cors aux pieds lui prendre son cerceau', 'Peccadilles importunes : III. Profiter de ce qu''il a des cors aux pieds lui prendre son cerceau', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 8945 AND p.composer_id = 100
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:651ea598-fe81-400b-974a-53f2a2fe61a4'
);


-- None Petit recueil des fêtes

UPDATE pieces piece
SET piece.title = 'Petit recueil des fêtes', piece.title_en = 'Petit recueil des fêtes',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 8213 AND piece.composer_id = 100
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'Enfant-martyre', part.name_en = 'Petit recueil des fêtes: Enfant-martyre',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 8213 AND p.composer_id = 100 AND part.part_key = 'musicbrainz:3d710a28-6bb3-414d-804e-35ff80bf95a7' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:3d710a28-6bb3-414d-804e-35ff80bf95a7', 1, NULL, 'Enfant-martyre', 'Petit recueil des fêtes: Enfant-martyre', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 8213 AND p.composer_id = 100
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:3d710a28-6bb3-414d-804e-35ff80bf95a7'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'Sorcière', part.name_en = 'Petit recueil des fêtes: Sorcière',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 8213 AND p.composer_id = 100 AND part.part_key = 'musicbrainz:d793a37c-ebc3-49d8-8c20-7c4e23e6dc11' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:d793a37c-ebc3-49d8-8c20-7c4e23e6dc11', 2, NULL, 'Sorcière', 'Petit recueil des fêtes: Sorcière', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 8213 AND p.composer_id = 100
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:d793a37c-ebc3-49d8-8c20-7c4e23e6dc11'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = NULL,
    part.name_ko = 'Air fantôme', part.name_en = 'Petit recueil des fêtes: Air fantôme',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 8213 AND p.composer_id = 100 AND part.part_key = 'musicbrainz:e5aeca37-ec15-4447-ae16-a1fa376be4f5' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:e5aeca37-ec15-4447-ae16-a1fa376be4f5', 3, NULL, 'Air fantôme', 'Petit recueil des fêtes: Air fantôme', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 8213 AND p.composer_id = 100
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:e5aeca37-ec15-4447-ae16-a1fa376be4f5'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = NULL,
    part.name_ko = 'Le Picador est mort', part.name_en = 'Petit recueil des fêtes: Le Picador est mort',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 8213 AND p.composer_id = 100 AND part.part_key = 'musicbrainz:e878b753-8841-4d67-9bff-e3cddbef2270' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:e878b753-8841-4d67-9bff-e3cddbef2270', 4, NULL, 'Le Picador est mort', 'Petit recueil des fêtes: Le Picador est mort', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 8213 AND p.composer_id = 100
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:e878b753-8841-4d67-9bff-e3cddbef2270'
);


-- None Petite Sonate

UPDATE pieces piece
SET piece.title = 'Petite Sonate', piece.title_en = 'Petite Sonate',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 10034 AND piece.composer_id = 100
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Petite rêvasserie nocturne

UPDATE pieces piece
SET piece.title = 'Petite rêvasserie nocturne', piece.title_en = 'Petite rêvasserie nocturne',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 8340 AND piece.composer_id = 100
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Pièces Froides No. 3

UPDATE pieces piece
SET piece.title = 'Pièces Froides No. 3', piece.title_en = 'Pièces Froides No. 3',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 8411 AND piece.composer_id = 100
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Pièces froides

UPDATE pieces piece
SET piece.title = 'Pièces froides', piece.title_en = 'Pièces froides',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 7682 AND piece.composer_id = 100
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'Airs à faire fuir', part.name_en = 'Pièces froides : no. 1, Airs à faire fuir',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 7682 AND p.composer_id = 100 AND part.part_key = 'musicbrainz:ff8d52e0-060c-4f27-bbae-0dd1912f60e1' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:ff8d52e0-060c-4f27-bbae-0dd1912f60e1', 1, NULL, 'Airs à faire fuir', 'Pièces froides : no. 1, Airs à faire fuir', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 7682 AND p.composer_id = 100
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:ff8d52e0-060c-4f27-bbae-0dd1912f60e1'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:ff8d52e0-060c-4f27-bbae-0dd1912f60e1'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'Airs à faire fuir : I. D’une manière très particulière', part.name_en = 'Pièces froides : no. 1, Airs à faire fuir : I. D’une manière très particulière',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 7682 AND p.composer_id = 100 AND part.part_key = 'musicbrainz:6afa05d1-4e89-3693-add1-833061ce9e09' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:6afa05d1-4e89-3693-add1-833061ce9e09', 1, NULL, 'Airs à faire fuir : I. D’une manière très particulière', 'Pièces froides : no. 1, Airs à faire fuir : I. D’une manière très particulière', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:ff8d52e0-060c-4f27-bbae-0dd1912f60e1'
WHERE p.id = 7682 AND p.composer_id = 100
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:6afa05d1-4e89-3693-add1-833061ce9e09'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:ff8d52e0-060c-4f27-bbae-0dd1912f60e1'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'Airs à faire fuir : II. Modestemente', part.name_en = 'Pièces froides : no. 1, Airs à faire fuir : II. Modestemente',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 7682 AND p.composer_id = 100 AND part.part_key = 'musicbrainz:437320e0-c715-3bec-83c3-f0d1d6e33081' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:437320e0-c715-3bec-83c3-f0d1d6e33081', 2, NULL, 'Airs à faire fuir : II. Modestemente', 'Pièces froides : no. 1, Airs à faire fuir : II. Modestemente', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:ff8d52e0-060c-4f27-bbae-0dd1912f60e1'
WHERE p.id = 7682 AND p.composer_id = 100
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:437320e0-c715-3bec-83c3-f0d1d6e33081'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:ff8d52e0-060c-4f27-bbae-0dd1912f60e1'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = NULL,
    part.name_ko = 'Airs à faire fuir : III. S’inviter', part.name_en = 'Pièces froides : no. 1, Airs à faire fuir : III. S’inviter',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 7682 AND p.composer_id = 100 AND part.part_key = 'musicbrainz:fca9d5c5-bffb-3a7e-890a-aec129869792' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:fca9d5c5-bffb-3a7e-890a-aec129869792', 3, NULL, 'Airs à faire fuir : III. S’inviter', 'Pièces froides : no. 1, Airs à faire fuir : III. S’inviter', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:ff8d52e0-060c-4f27-bbae-0dd1912f60e1'
WHERE p.id = 7682 AND p.composer_id = 100
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:fca9d5c5-bffb-3a7e-890a-aec129869792'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'Danses de travers', part.name_en = 'Pièces froides: no. 2, Danses de travers',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 7682 AND p.composer_id = 100 AND part.part_key = 'musicbrainz:c033962b-79b0-4437-a9b8-79403a0bc6b4' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:c033962b-79b0-4437-a9b8-79403a0bc6b4', 2, NULL, 'Danses de travers', 'Pièces froides: no. 2, Danses de travers', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 7682 AND p.composer_id = 100
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:c033962b-79b0-4437-a9b8-79403a0bc6b4'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:c033962b-79b0-4437-a9b8-79403a0bc6b4'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'En y regardant à deux fois', part.name_en = 'Pièces froides: no. 2, Danses de travers: I. En y regardant à deux fois',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 7682 AND p.composer_id = 100 AND part.part_key = 'musicbrainz:4dff33c3-8f06-3e6a-bcd0-7f9d286a7cbc' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:4dff33c3-8f06-3e6a-bcd0-7f9d286a7cbc', 1, NULL, 'En y regardant à deux fois', 'Pièces froides: no. 2, Danses de travers: I. En y regardant à deux fois', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:c033962b-79b0-4437-a9b8-79403a0bc6b4'
WHERE p.id = 7682 AND p.composer_id = 100
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:4dff33c3-8f06-3e6a-bcd0-7f9d286a7cbc'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:c033962b-79b0-4437-a9b8-79403a0bc6b4'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'Passer', part.name_en = 'Pièces froides: no. 2, Danses de travers: II. Passer',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 7682 AND p.composer_id = 100 AND part.part_key = 'musicbrainz:3c08d649-6d7a-311b-889e-0c824df8eac6' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:3c08d649-6d7a-311b-889e-0c824df8eac6', 2, NULL, 'Passer', 'Pièces froides: no. 2, Danses de travers: II. Passer', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:c033962b-79b0-4437-a9b8-79403a0bc6b4'
WHERE p.id = 7682 AND p.composer_id = 100
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:3c08d649-6d7a-311b-889e-0c824df8eac6'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:c033962b-79b0-4437-a9b8-79403a0bc6b4'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = NULL,
    part.name_ko = 'Encore', part.name_en = 'Pièces froides: no. 2, Danses de travers: III. Encore',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 7682 AND p.composer_id = 100 AND part.part_key = 'musicbrainz:f38d06da-7d1b-3cd2-a0ff-fbc213aa0a70' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:f38d06da-7d1b-3cd2-a0ff-fbc213aa0a70', 3, NULL, 'Encore', 'Pièces froides: no. 2, Danses de travers: III. Encore', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:c033962b-79b0-4437-a9b8-79403a0bc6b4'
WHERE p.id = 7682 AND p.composer_id = 100
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:f38d06da-7d1b-3cd2-a0ff-fbc213aa0a70'
);


-- None Poudre d’or

UPDATE pieces piece
SET piece.title = 'Poudre d’or', piece.title_en = 'Poudre d’or',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 8419 AND piece.composer_id = 100
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Premier Menuet

UPDATE pieces piece
SET piece.title = 'Premier Menuet', piece.title_en = 'Premier Menuet',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 7623 AND piece.composer_id = 100
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Prière

UPDATE pieces piece
SET piece.title = 'Prière', piece.title_en = 'Prière',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 9298 AND piece.composer_id = 100
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Prélude de la porte héroïque du ciel

UPDATE pieces piece
SET piece.title = 'Prélude de la porte héroïque du ciel', piece.title_en = 'Prélude de la porte héroïque du ciel',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 7522 AND piece.composer_id = 100
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Prélude en tapisserie

UPDATE pieces piece
SET piece.title = 'Prélude en tapisserie', piece.title_en = 'Prélude en tapisserie',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 10635 AND piece.composer_id = 100
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Quatre Ogives

UPDATE pieces piece
SET piece.title = 'Quatre Ogives', piece.title_en = 'Quatre Ogives',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 7648 AND piece.composer_id = 100
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'Première Ogive (à J.P. Contamine de Latour)', part.name_en = 'Quatre Ogives : I. Première Ogive (à J.P. Contamine de Latour)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 7648 AND p.composer_id = 100 AND part.part_key = 'musicbrainz:f798b7d5-8003-3c16-a1f8-767910b73df0' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:f798b7d5-8003-3c16-a1f8-767910b73df0', 1, 'I', 'Première Ogive (à J.P. Contamine de Latour)', 'Quatre Ogives : I. Première Ogive (à J.P. Contamine de Latour)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 7648 AND p.composer_id = 100
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:f798b7d5-8003-3c16-a1f8-767910b73df0'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'Seconde Ogive (à Charles Levade)', part.name_en = 'Quatre Ogives : II. Seconde Ogive (à Charles Levade)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 7648 AND p.composer_id = 100 AND part.part_key = 'musicbrainz:33fb434f-c5e1-33f7-b9ef-ae2add50b810' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:33fb434f-c5e1-33f7-b9ef-ae2add50b810', 2, 'II', 'Seconde Ogive (à Charles Levade)', 'Quatre Ogives : II. Seconde Ogive (à Charles Levade)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 7648 AND p.composer_id = 100
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:33fb434f-c5e1-33f7-b9ef-ae2add50b810'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = 'Troisième Ogive (à Madame Clément Le Breton)', part.name_en = 'Quatre Ogives : III. Troisième Ogive (à Madame Clément Le Breton)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 7648 AND p.composer_id = 100 AND part.part_key = 'musicbrainz:b646f75b-68c9-327d-bb11-a7635fa3aaff' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:b646f75b-68c9-327d-bb11-a7635fa3aaff', 3, 'III', 'Troisième Ogive (à Madame Clément Le Breton)', 'Quatre Ogives : III. Troisième Ogive (à Madame Clément Le Breton)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 7648 AND p.composer_id = 100
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:b646f75b-68c9-327d-bb11-a7635fa3aaff'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = 'IV',
    part.name_ko = 'Quatrième Ogive (à Conrad Satie)', part.name_en = 'Quatre Ogives : IV. Quatrième Ogive (à Conrad Satie)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 7648 AND p.composer_id = 100 AND part.part_key = 'musicbrainz:13edc047-303b-3054-b366-40f871f475b4' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:13edc047-303b-3054-b366-40f871f475b4', 4, 'IV', 'Quatrième Ogive (à Conrad Satie)', 'Quatre Ogives : IV. Quatrième Ogive (à Conrad Satie)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 7648 AND p.composer_id = 100
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:13edc047-303b-3054-b366-40f871f475b4'
);


-- None Quatre petites mélodies

UPDATE pieces piece
SET piece.title = 'Quatre petites mélodies', piece.title_en = 'Quatre petites mélodies',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 8344 AND piece.composer_id = 100
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'Élégie', part.name_en = 'Quatre petites mélodies: I. Élégie',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 8344 AND p.composer_id = 100 AND part.part_key = 'musicbrainz:da2f0c8f-e601-4060-8234-bf1cf74f8dfc' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:da2f0c8f-e601-4060-8234-bf1cf74f8dfc', 1, 'I', 'Élégie', 'Quatre petites mélodies: I. Élégie', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 8344 AND p.composer_id = 100
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:da2f0c8f-e601-4060-8234-bf1cf74f8dfc'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'Danseuse', part.name_en = 'Quatre petites mélodies: II. Danseuse',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 8344 AND p.composer_id = 100 AND part.part_key = 'musicbrainz:dd512d33-ff9f-4d43-872c-47d9f316019a' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:dd512d33-ff9f-4d43-872c-47d9f316019a', 2, 'II', 'Danseuse', 'Quatre petites mélodies: II. Danseuse', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 8344 AND p.composer_id = 100
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:dd512d33-ff9f-4d43-872c-47d9f316019a'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = 'Chanson', part.name_en = 'Quatre petites mélodies: III. Chanson',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 8344 AND p.composer_id = 100 AND part.part_key = 'musicbrainz:d350ac29-d1ec-4344-ba6c-06de89ae44c7' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:d350ac29-d1ec-4344-ba6c-06de89ae44c7', 3, 'III', 'Chanson', 'Quatre petites mélodies: III. Chanson', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 8344 AND p.composer_id = 100
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:d350ac29-d1ec-4344-ba6c-06de89ae44c7'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = 'IV',
    part.name_ko = 'Adieu', part.name_en = 'Quatre petites mélodies: IV. Adieu',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 8344 AND p.composer_id = 100 AND part.part_key = 'musicbrainz:56100325-3aba-485a-9f8e-58795e92a0d2' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:56100325-3aba-485a-9f8e-58795e92a0d2', 4, 'IV', 'Adieu', 'Quatre petites mélodies: IV. Adieu', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 8344 AND p.composer_id = 100
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:56100325-3aba-485a-9f8e-58795e92a0d2'
);


-- None Quatre préludes

UPDATE pieces piece
SET piece.title = 'Quatre préludes', piece.title_en = 'Quatre préludes',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 8403 AND piece.composer_id = 100
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'Fête donnée par des chevaliers normands en l’honneur d’une jeune demoiselle', part.name_en = 'Quatre Préludes : Fête donnée par des chevaliers normands en l’honneur d’une jeune demoiselle',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 8403 AND p.composer_id = 100 AND part.part_key = 'musicbrainz:eb394457-bab6-3734-9c0d-51162e149113' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:eb394457-bab6-3734-9c0d-51162e149113', 1, NULL, 'Fête donnée par des chevaliers normands en l’honneur d’une jeune demoiselle', 'Quatre Préludes : Fête donnée par des chevaliers normands en l’honneur d’une jeune demoiselle', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 8403 AND p.composer_id = 100
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:eb394457-bab6-3734-9c0d-51162e149113'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'Prélude d’Eginhard', part.name_en = 'Quatre Préludes : Prélude d’Eginhard',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 8403 AND p.composer_id = 100 AND part.part_key = 'musicbrainz:4efaa284-79e1-3fbf-bae1-b5c92100a3ab' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:4efaa284-79e1-3fbf-bae1-b5c92100a3ab', 2, NULL, 'Prélude d’Eginhard', 'Quatre Préludes : Prélude d’Eginhard', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 8403 AND p.composer_id = 100
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:4efaa284-79e1-3fbf-bae1-b5c92100a3ab'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = NULL,
    part.name_ko = '1er Prélude du Nazaréen', part.name_en = 'Quatre Préludes : 1er Prélude du Nazaréen',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 8403 AND p.composer_id = 100 AND part.part_key = 'musicbrainz:74f5cac7-1704-3d3f-9a26-08ca745f8eff' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:74f5cac7-1704-3d3f-9a26-08ca745f8eff', 3, NULL, '1er Prélude du Nazaréen', 'Quatre Préludes : 1er Prélude du Nazaréen', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 8403 AND p.composer_id = 100
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:74f5cac7-1704-3d3f-9a26-08ca745f8eff'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = NULL,
    part.name_ko = '2ème Prélude du Nazaréen', part.name_en = 'Quatre Préludes : 2ème Prélude du Nazaréen',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 8403 AND p.composer_id = 100 AND part.part_key = 'musicbrainz:7eface57-f282-314c-828c-76fbac1050d1' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:7eface57-f282-314c-828c-76fbac1050d1', 4, NULL, '2ème Prélude du Nazaréen', 'Quatre Préludes : 2ème Prélude du Nazaréen', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 8403 AND p.composer_id = 100
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:7eface57-f282-314c-828c-76fbac1050d1'
);


-- None 발레 <Relâche>

UPDATE pieces piece
SET piece.title = '발레 <Relâche>', piece.title_en = 'Relâche',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 7593 AND piece.composer_id = 100
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'premier acte : Ouverturette', part.name_en = 'Relâche, premier acte : Ouverturette',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 7593 AND p.composer_id = 100 AND part.part_key = 'musicbrainz:53fc86c9-8541-4edb-81d2-6573d82e0900' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:53fc86c9-8541-4edb-81d2-6573d82e0900', 1, NULL, 'premier acte : Ouverturette', 'Relâche, premier acte : Ouverturette', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 7593 AND p.composer_id = 100
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:53fc86c9-8541-4edb-81d2-6573d82e0900'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'premier acte : Projectionnette', part.name_en = 'Relâche, premier acte : Projectionnette',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 7593 AND p.composer_id = 100 AND part.part_key = 'musicbrainz:8fac4190-3e61-4779-b853-a2da2976ba8f' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:8fac4190-3e61-4779-b853-a2da2976ba8f', 2, NULL, 'premier acte : Projectionnette', 'Relâche, premier acte : Projectionnette', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 7593 AND p.composer_id = 100
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:8fac4190-3e61-4779-b853-a2da2976ba8f'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = NULL,
    part.name_ko = 'premier acte : Rideau', part.name_en = 'Relâche, premier acte : Rideau',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 7593 AND p.composer_id = 100 AND part.part_key = 'musicbrainz:20cf23a6-1ec7-4ef8-8768-fd893bc83ad1' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:20cf23a6-1ec7-4ef8-8768-fd893bc83ad1', 3, NULL, 'premier acte : Rideau', 'Relâche, premier acte : Rideau', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 7593 AND p.composer_id = 100
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:20cf23a6-1ec7-4ef8-8768-fd893bc83ad1'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = NULL,
    part.name_ko = 'premier acte : Entrée de la femme', part.name_en = 'Relâche, premier acte : Entrée de la femme',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 7593 AND p.composer_id = 100 AND part.part_key = 'musicbrainz:8e3b2818-94f5-42be-8487-4c1e3508259f' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:8e3b2818-94f5-42be-8487-4c1e3508259f', 4, NULL, 'premier acte : Entrée de la femme', 'Relâche, premier acte : Entrée de la femme', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 7593 AND p.composer_id = 100
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:8e3b2818-94f5-42be-8487-4c1e3508259f'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 5, part.movement_number = NULL,
    part.name_ko = 'premier acte : “Musique” entre l’entrée de la Femme et sa “Danse sans musique”', part.name_en = 'Relâche, premier acte : “Musique” entre l’entrée de la Femme et sa “Danse sans musique”',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 7593 AND p.composer_id = 100 AND part.part_key = 'musicbrainz:dd561e4c-ba52-4cbe-92a2-b3e4f49ecee7' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:dd561e4c-ba52-4cbe-92a2-b3e4f49ecee7', 5, NULL, 'premier acte : “Musique” entre l’entrée de la Femme et sa “Danse sans musique”', 'Relâche, premier acte : “Musique” entre l’entrée de la Femme et sa “Danse sans musique”', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 7593 AND p.composer_id = 100
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:dd561e4c-ba52-4cbe-92a2-b3e4f49ecee7'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 6, part.movement_number = NULL,
    part.name_ko = 'premier acte : Entrée de l’Homme', part.name_en = 'Relâche, premier acte : Entrée de l’Homme',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 7593 AND p.composer_id = 100 AND part.part_key = 'musicbrainz:427330c4-be74-4412-8057-9ae82b7d6e7c' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:427330c4-be74-4412-8057-9ae82b7d6e7c', 6, NULL, 'premier acte : Entrée de l’Homme', 'Relâche, premier acte : Entrée de l’Homme', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 7593 AND p.composer_id = 100
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:427330c4-be74-4412-8057-9ae82b7d6e7c'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 7, part.movement_number = NULL,
    part.name_ko = 'premier acte : Danse de la porte tournante e (l’Homme et la Femme)', part.name_en = 'Relâche, premier acte : Danse de la porte tournante e (l’Homme et la Femme)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 7593 AND p.composer_id = 100 AND part.part_key = 'musicbrainz:980f52bc-5f19-4938-9d59-2c1e9c02e6f9' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:980f52bc-5f19-4938-9d59-2c1e9c02e6f9', 7, NULL, 'premier acte : Danse de la porte tournante e (l’Homme et la Femme)', 'Relâche, premier acte : Danse de la porte tournante e (l’Homme et la Femme)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 7593 AND p.composer_id = 100
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:980f52bc-5f19-4938-9d59-2c1e9c02e6f9'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 8, part.movement_number = NULL,
    part.name_ko = 'premier acte : Entrée des hommes', part.name_en = 'Relâche, premier acte : Entrée des hommes',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 7593 AND p.composer_id = 100 AND part.part_key = 'musicbrainz:d992b88c-01aa-4bca-bdf7-42826f365a19' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:d992b88c-01aa-4bca-bdf7-42826f365a19', 8, NULL, 'premier acte : Entrée des hommes', 'Relâche, premier acte : Entrée des hommes', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 7593 AND p.composer_id = 100
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:d992b88c-01aa-4bca-bdf7-42826f365a19'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 9, part.movement_number = NULL,
    part.name_ko = 'premier acte : Danse des hommes', part.name_en = 'Relâche, premier acte : Danse des hommes',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 7593 AND p.composer_id = 100 AND part.part_key = 'musicbrainz:4d135b0d-014c-423e-aeb1-409923f5d7e7' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:4d135b0d-014c-423e-aeb1-409923f5d7e7', 9, NULL, 'premier acte : Danse des hommes', 'Relâche, premier acte : Danse des hommes', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 7593 AND p.composer_id = 100
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:4d135b0d-014c-423e-aeb1-409923f5d7e7'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 10, part.movement_number = NULL,
    part.name_ko = 'premier acte : Danse de la femme', part.name_en = 'Relâche, premier acte : Danse de la femme',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 7593 AND p.composer_id = 100 AND part.part_key = 'musicbrainz:fe954603-a3cd-4071-a32e-bc15813078bf' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:fe954603-a3cd-4071-a32e-bc15813078bf', 10, NULL, 'premier acte : Danse de la femme', 'Relâche, premier acte : Danse de la femme', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 7593 AND p.composer_id = 100
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:fe954603-a3cd-4071-a32e-bc15813078bf'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 11, part.movement_number = NULL,
    part.name_ko = 'premier acte : Final', part.name_en = 'Relâche, premier acte : Final',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 7593 AND p.composer_id = 100 AND part.part_key = 'musicbrainz:f1756903-956e-476a-927a-68638934c6a3' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:f1756903-956e-476a-927a-68638934c6a3', 11, NULL, 'premier acte : Final', 'Relâche, premier acte : Final', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 7593 AND p.composer_id = 100
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:f1756903-956e-476a-927a-68638934c6a3'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 12, part.movement_number = NULL,
    part.name_ko = 'deuxième acte : Musique de rentrée', part.name_en = 'Relâche, deuxième acte : Musique de rentrée',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 7593 AND p.composer_id = 100 AND part.part_key = 'musicbrainz:9aaf6313-a285-48d8-b173-e3871d8a6e43' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:9aaf6313-a285-48d8-b173-e3871d8a6e43', 12, NULL, 'deuxième acte : Musique de rentrée', 'Relâche, deuxième acte : Musique de rentrée', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 7593 AND p.composer_id = 100
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:9aaf6313-a285-48d8-b173-e3871d8a6e43'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 13, part.movement_number = NULL,
    part.name_ko = 'deuxième acte : Rentrée des hommes', part.name_en = 'Relâche, deuxième acte : Rentrée des hommes',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 7593 AND p.composer_id = 100 AND part.part_key = 'musicbrainz:fc1e9e57-e1d8-4257-b144-5b3245923f1c' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:fc1e9e57-e1d8-4257-b144-5b3245923f1c', 13, NULL, 'deuxième acte : Rentrée des hommes', 'Relâche, deuxième acte : Rentrée des hommes', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 7593 AND p.composer_id = 100
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:fc1e9e57-e1d8-4257-b144-5b3245923f1c'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 14, part.movement_number = NULL,
    part.name_ko = 'deuxième acte : Rentrée de la femme', part.name_en = 'Relâche, deuxième acte : Rentrée de la femme',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 7593 AND p.composer_id = 100 AND part.part_key = 'musicbrainz:3ddad34c-0afa-4474-b520-6ada7dc7dcf2' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:3ddad34c-0afa-4474-b520-6ada7dc7dcf2', 14, NULL, 'deuxième acte : Rentrée de la femme', 'Relâche, deuxième acte : Rentrée de la femme', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 7593 AND p.composer_id = 100
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:3ddad34c-0afa-4474-b520-6ada7dc7dcf2'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 15, part.movement_number = NULL,
    part.name_ko = 'deuxième acte : Les hommes se dévêtissent', part.name_en = 'Relâche, deuxième acte : Les hommes se dévêtissent',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 7593 AND p.composer_id = 100 AND part.part_key = 'musicbrainz:08d838d0-1f37-463e-89d3-d27a9fa1968b' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:08d838d0-1f37-463e-89d3-d27a9fa1968b', 15, NULL, 'deuxième acte : Les hommes se dévêtissent', 'Relâche, deuxième acte : Les hommes se dévêtissent', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 7593 AND p.composer_id = 100
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:08d838d0-1f37-463e-89d3-d27a9fa1968b'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 16, part.movement_number = NULL,
    part.name_ko = 'deuxième acte : Danse de Borlin et de la femme', part.name_en = 'Relâche, deuxième acte : Danse de Borlin et de la femme',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 7593 AND p.composer_id = 100 AND part.part_key = 'musicbrainz:3c23e2f1-5801-4fb7-8a4a-9c9b6fdcca5f' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:3c23e2f1-5801-4fb7-8a4a-9c9b6fdcca5f', 16, NULL, 'deuxième acte : Danse de Borlin et de la femme', 'Relâche, deuxième acte : Danse de Borlin et de la femme', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 7593 AND p.composer_id = 100
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:3c23e2f1-5801-4fb7-8a4a-9c9b6fdcca5f'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 17, part.movement_number = NULL,
    part.name_ko = 'deuxième acte : Les Hommes regagnent leur place et retrouvent leurs pardessus', part.name_en = 'Relâche, deuxième acte : Les Hommes regagnent leur place et retrouvent leurs pardessus',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 7593 AND p.composer_id = 100 AND part.part_key = 'musicbrainz:56285292-2010-4bad-8cec-b9fb665a8fbc' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:56285292-2010-4bad-8cec-b9fb665a8fbc', 17, NULL, 'deuxième acte : Les Hommes regagnent leur place et retrouvent leurs pardessus', 'Relâche, deuxième acte : Les Hommes regagnent leur place et retrouvent leurs pardessus', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 7593 AND p.composer_id = 100
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:56285292-2010-4bad-8cec-b9fb665a8fbc'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 18, part.movement_number = NULL,
    part.name_ko = 'deuxième acte : Danse de la brouette', part.name_en = 'Relâche, deuxième acte : Danse de la brouette',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 7593 AND p.composer_id = 100 AND part.part_key = 'musicbrainz:c321e940-17ea-4803-9b6e-3dbc5a2aaaac' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:c321e940-17ea-4803-9b6e-3dbc5a2aaaac', 18, NULL, 'deuxième acte : Danse de la brouette', 'Relâche, deuxième acte : Danse de la brouette', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 7593 AND p.composer_id = 100
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:c321e940-17ea-4803-9b6e-3dbc5a2aaaac'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 19, part.movement_number = NULL,
    part.name_ko = 'deuxième acte : Danse de la couronne', part.name_en = 'Relâche, deuxième acte : Danse de la couronne',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 7593 AND p.composer_id = 100 AND part.part_key = 'musicbrainz:6b7f9c14-7360-4888-a1f8-fd105e92f357' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:6b7f9c14-7360-4888-a1f8-fd105e92f357', 19, NULL, 'deuxième acte : Danse de la couronne', 'Relâche, deuxième acte : Danse de la couronne', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 7593 AND p.composer_id = 100
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:6b7f9c14-7360-4888-a1f8-fd105e92f357'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 20, part.movement_number = NULL,
    part.name_ko = 'deuxième acte : Le danseur repose la couronne sur la tête d’une spectatrice', part.name_en = 'Relâche, deuxième acte : Le danseur repose la couronne sur la tête d’une spectatrice',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 7593 AND p.composer_id = 100 AND part.part_key = 'musicbrainz:b251fc86-4dc1-4537-9bdf-4a5cc2f89270' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:b251fc86-4dc1-4537-9bdf-4a5cc2f89270', 20, NULL, 'deuxième acte : Le danseur repose la couronne sur la tête d’une spectatrice', 'Relâche, deuxième acte : Le danseur repose la couronne sur la tête d’une spectatrice', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 7593 AND p.composer_id = 100
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:b251fc86-4dc1-4537-9bdf-4a5cc2f89270'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 21, part.movement_number = NULL,
    part.name_ko = 'deuxième acte : La femme rejoint son fauteuil', part.name_en = 'Relâche, deuxième acte : La femme rejoint son fauteuil',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 7593 AND p.composer_id = 100 AND part.part_key = 'musicbrainz:255137b4-9c6c-4fbb-b8e9-f7aef69e2604' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:255137b4-9c6c-4fbb-b8e9-f7aef69e2604', 21, NULL, 'deuxième acte : La femme rejoint son fauteuil', 'Relâche, deuxième acte : La femme rejoint son fauteuil', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 7593 AND p.composer_id = 100
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:255137b4-9c6c-4fbb-b8e9-f7aef69e2604'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 22, part.movement_number = NULL,
    part.name_ko = 'deuxième acte : La “Queue” du chien (chanson mimée)', part.name_en = 'Relâche, deuxième acte : La “Queue” du chien (chanson mimée)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 7593 AND p.composer_id = 100 AND part.part_key = 'musicbrainz:f3770a29-c196-4c4a-b10f-c57f1f491455' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:f3770a29-c196-4c4a-b10f-c57f1f491455', 22, NULL, 'deuxième acte : La “Queue” du chien (chanson mimée)', 'Relâche, deuxième acte : La “Queue” du chien (chanson mimée)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 7593 AND p.composer_id = 100
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:f3770a29-c196-4c4a-b10f-c57f1f491455'
);


-- None Relâche: Entr’acte symphonique

UPDATE pieces piece
SET piece.title = 'Relâche: Entr’acte symphonique', piece.title_en = 'Relâche: Entr’acte symphonique',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 8996 AND piece.composer_id = 100
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Réflexion nocturne no. 3

UPDATE pieces piece
SET piece.title = 'Réflexion nocturne no. 3', piece.title_en = 'Réflexion nocturne no. 3',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 10449 AND piece.composer_id = 100
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Réflexions nocturnes nos. 1 & 2

UPDATE pieces piece
SET piece.title = 'Réflexions nocturnes nos. 1 & 2', piece.title_en = 'Réflexions nocturnes nos. 1 & 2',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 8454 AND piece.composer_id = 100
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Rêverie d’un plat

UPDATE pieces piece
SET piece.title = 'Rêverie d’un plat', piece.title_en = 'Rêverie d’un plat',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 10967 AND piece.composer_id = 100
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None San Bernardo

UPDATE pieces piece
SET piece.title = 'San Bernardo', piece.title_en = 'San Bernardo',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 8917 AND piece.composer_id = 100
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Sites auriculaires pour 2 pianos

UPDATE pieces piece
SET piece.title = 'Sites auriculaires pour 2 pianos', piece.title_en = 'Sites auriculaires pour 2 pianos',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 9029 AND piece.composer_id = 100
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'Habanera (En demi-teinte et d''un rythme las)', part.name_en = 'Sites auriculaires pour 2 pianos: I. Habanera (En demi-teinte et d''un rythme las)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 9029 AND p.composer_id = 100 AND part.part_key = 'musicbrainz:859da50e-832b-414b-b2fa-9d04453a40a7' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:859da50e-832b-414b-b2fa-9d04453a40a7', 1, 'I', 'Habanera (En demi-teinte et d''un rythme las)', 'Sites auriculaires pour 2 pianos: I. Habanera (En demi-teinte et d''un rythme las)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 9029 AND p.composer_id = 100
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:859da50e-832b-414b-b2fa-9d04453a40a7'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'Entre cloches (Allègrement)', part.name_en = 'Sites auriculaires pour 2 pianos: II. Entre cloches (Allègrement)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 9029 AND p.composer_id = 100 AND part.part_key = 'musicbrainz:6bddc0de-1b3e-48a6-a806-68aff8807ecd' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:6bddc0de-1b3e-48a6-a806-68aff8807ecd', 2, 'II', 'Entre cloches (Allègrement)', 'Sites auriculaires pour 2 pianos: II. Entre cloches (Allègrement)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 9029 AND p.composer_id = 100
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:6bddc0de-1b3e-48a6-a806-68aff8807ecd'
);


-- None Six Pièces de la période 1906–1913

UPDATE pieces piece
SET piece.title = 'Six Pièces de la période 1906–1913', piece.title_en = 'Six Pièces de la période 1906–1913',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 9149 AND piece.composer_id = 100
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'Désespoir agréable', part.name_en = 'Six Pièces de la période 1906–1913 : I. Désespoir agréable',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 9149 AND p.composer_id = 100 AND part.part_key = 'musicbrainz:fdf41bf7-e650-3884-933b-06416acd0464' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:fdf41bf7-e650-3884-933b-06416acd0464', 1, 'I', 'Désespoir agréable', 'Six Pièces de la période 1906–1913 : I. Désespoir agréable', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 9149 AND p.composer_id = 100
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:fdf41bf7-e650-3884-933b-06416acd0464'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'Effronterie', part.name_en = 'Six Pièces de la période 1906–1913 : II. Effronterie',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 9149 AND p.composer_id = 100 AND part.part_key = 'musicbrainz:1a1b5827-2234-3fde-a96e-87f8acb54daa' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:1a1b5827-2234-3fde-a96e-87f8acb54daa', 2, 'II', 'Effronterie', 'Six Pièces de la période 1906–1913 : II. Effronterie', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 9149 AND p.composer_id = 100
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:1a1b5827-2234-3fde-a96e-87f8acb54daa'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = 'Poésie', part.name_en = 'Six Pièces de la période 1906–1913 : III. Poésie',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 9149 AND p.composer_id = 100 AND part.part_key = 'musicbrainz:4d217654-e574-39ef-a3a1-8a65d1a63905' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:4d217654-e574-39ef-a3a1-8a65d1a63905', 3, 'III', 'Poésie', 'Six Pièces de la période 1906–1913 : III. Poésie', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 9149 AND p.composer_id = 100
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:4d217654-e574-39ef-a3a1-8a65d1a63905'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = 'IV',
    part.name_ko = 'Prélude Canin', part.name_en = 'Six Pièces de la période 1906–1913 : IV. Prélude Canin',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 9149 AND p.composer_id = 100 AND part.part_key = 'musicbrainz:8d8eb21f-a34d-32d2-92db-c6494a40b8cb' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:8d8eb21f-a34d-32d2-92db-c6494a40b8cb', 4, 'IV', 'Prélude Canin', 'Six Pièces de la période 1906–1913 : IV. Prélude Canin', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 9149 AND p.composer_id = 100
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:8d8eb21f-a34d-32d2-92db-c6494a40b8cb'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 5, part.movement_number = 'V',
    part.name_ko = 'Profondeur', part.name_en = 'Six Pièces de la période 1906–1913 : V. Profondeur',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 9149 AND p.composer_id = 100 AND part.part_key = 'musicbrainz:0dbc6886-c4c2-3fef-a360-2147812af50f' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:0dbc6886-c4c2-3fef-a360-2147812af50f', 5, 'V', 'Profondeur', 'Six Pièces de la période 1906–1913 : V. Profondeur', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 9149 AND p.composer_id = 100
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:0dbc6886-c4c2-3fef-a360-2147812af50f'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 6, part.movement_number = 'VI',
    part.name_ko = 'Songe Creux', part.name_en = 'Six Pièces de la période 1906–1913 : VI. Songe Creux',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 9149 AND p.composer_id = 100 AND part.part_key = 'musicbrainz:ab24a58d-5ebd-3127-b944-faf00ad243c1' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:ab24a58d-5ebd-3127-b944-faf00ad243c1', 6, 'VI', 'Songe Creux', 'Six Pièces de la période 1906–1913 : VI. Songe Creux', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 9149 AND p.composer_id = 100
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:ab24a58d-5ebd-3127-b944-faf00ad243c1'
);


-- None Sonatine bureaucratique

UPDATE pieces piece
SET piece.title = 'Sonatine bureaucratique', piece.title_en = 'Sonatine bureaucratique',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 7562 AND piece.composer_id = 100
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'Allegro', part.name_en = 'Sonatine bureaucratique : I. Allegro',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 7562 AND p.composer_id = 100 AND part.part_key = 'musicbrainz:a85732dc-016e-3603-afc9-a05174b9cb04' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:a85732dc-016e-3603-afc9-a05174b9cb04', 1, 'I', 'Allegro', 'Sonatine bureaucratique : I. Allegro', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 7562 AND p.composer_id = 100
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:a85732dc-016e-3603-afc9-a05174b9cb04'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'Andante', part.name_en = 'Sonatine bureaucratique : II. Andante',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 7562 AND p.composer_id = 100 AND part.part_key = 'musicbrainz:f23a5a0d-6021-3d2e-a53d-2bd3e4da7293' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:f23a5a0d-6021-3d2e-a53d-2bd3e4da7293', 2, 'II', 'Andante', 'Sonatine bureaucratique : II. Andante', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 7562 AND p.composer_id = 100
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:f23a5a0d-6021-3d2e-a53d-2bd3e4da7293'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = 'Vivache', part.name_en = 'Sonatine bureaucratique : III. Vivache',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 7562 AND p.composer_id = 100 AND part.part_key = 'musicbrainz:87c4f4f4-9e58-3901-8219-6b53071f1b19' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:87c4f4f4-9e58-3901-8219-6b53071f1b19', 3, 'III', 'Vivache', 'Sonatine bureaucratique : III. Vivache', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 7562 AND p.composer_id = 100
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:87c4f4f4-9e58-3901-8219-6b53071f1b19'
);


-- None Sonnerie pour réveiller le bon gros roi des singes

UPDATE pieces piece
SET piece.title = 'Sonnerie pour réveiller le bon gros roi des singes', piece.title_en = 'Sonnerie pour réveiller le bon gros roi des singes',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 7953 AND piece.composer_id = 100
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Soupirs fanés

UPDATE pieces piece
SET piece.title = 'Soupirs fanés', piece.title_en = 'Soupirs fanés',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 10594 AND piece.composer_id = 100
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'Poil – Recrudescence', part.name_en = 'Soupirs fanés : Poil – Recrudescence',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 10594 AND p.composer_id = 100 AND part.part_key = 'musicbrainz:2190c553-f685-4362-94c9-47902088a1d3' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:2190c553-f685-4362-94c9-47902088a1d3', 1, NULL, 'Poil – Recrudescence', 'Soupirs fanés : Poil – Recrudescence', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 10594 AND p.composer_id = 100
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:2190c553-f685-4362-94c9-47902088a1d3'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'Barbouillage', part.name_en = 'Soupirs fanés : Barbouillage',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 10594 AND p.composer_id = 100 AND part.part_key = 'musicbrainz:324a71e5-c069-4cae-8e19-0d3f396dd4ef' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:324a71e5-c069-4cae-8e19-0d3f396dd4ef', 2, NULL, 'Barbouillage', 'Soupirs fanés : Barbouillage', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 10594 AND p.composer_id = 100
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:324a71e5-c069-4cae-8e19-0d3f396dd4ef'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = NULL,
    part.name_ko = 'Familial désespoir', part.name_en = 'Soupirs fanés : Familial désespoir',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 10594 AND p.composer_id = 100 AND part.part_key = 'musicbrainz:a14561eb-40d7-4a11-b77e-bb29c4de1edf' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:a14561eb-40d7-4a11-b77e-bb29c4de1edf', 3, NULL, 'Familial désespoir', 'Soupirs fanés : Familial désespoir', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 10594 AND p.composer_id = 100
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:a14561eb-40d7-4a11-b77e-bb29c4de1edf'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = NULL,
    part.name_ko = 'Souvenirs fadasses', part.name_en = 'Soupirs fanés : Souvenirs fadasses',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 10594 AND p.composer_id = 100 AND part.part_key = 'musicbrainz:2b3f318f-35c1-442a-a3fc-e2daabdea4ad' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:2b3f318f-35c1-442a-a3fc-e2daabdea4ad', 4, NULL, 'Souvenirs fadasses', 'Soupirs fanés : Souvenirs fadasses', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 10594 AND p.composer_id = 100
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:2b3f318f-35c1-442a-a3fc-e2daabdea4ad'
);


-- None Sports et divertissements

UPDATE pieces piece
SET piece.title = 'Sports et divertissements', piece.title_en = 'Sports et divertissements',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 11133 AND piece.composer_id = 100
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'Choral inappétissant', part.name_en = 'Sports et divertissements : I. Choral inappétissant',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11133 AND p.composer_id = 100 AND part.part_key = 'musicbrainz:aa130c91-a6e1-36a3-9db3-76f279f37c0b' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:aa130c91-a6e1-36a3-9db3-76f279f37c0b', 1, 'I', 'Choral inappétissant', 'Sports et divertissements : I. Choral inappétissant', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 11133 AND p.composer_id = 100
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:aa130c91-a6e1-36a3-9db3-76f279f37c0b'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'La Balançoire', part.name_en = 'Sports et divertissements : II. La Balançoire',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11133 AND p.composer_id = 100 AND part.part_key = 'musicbrainz:224cda65-e033-33ed-bae4-7c631c6e125c' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:224cda65-e033-33ed-bae4-7c631c6e125c', 2, 'II', 'La Balançoire', 'Sports et divertissements : II. La Balançoire', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 11133 AND p.composer_id = 100
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:224cda65-e033-33ed-bae4-7c631c6e125c'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = 'La Chasse', part.name_en = 'Sports et divertissements : III. La Chasse',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11133 AND p.composer_id = 100 AND part.part_key = 'musicbrainz:2acd8a14-0f46-3450-8bc3-a0daf3b772a2' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:2acd8a14-0f46-3450-8bc3-a0daf3b772a2', 3, 'III', 'La Chasse', 'Sports et divertissements : III. La Chasse', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 11133 AND p.composer_id = 100
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:2acd8a14-0f46-3450-8bc3-a0daf3b772a2'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = 'IV',
    part.name_ko = 'La Comédie italienne', part.name_en = 'Sports et divertissements : IV. La Comédie italienne',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11133 AND p.composer_id = 100 AND part.part_key = 'musicbrainz:92a05c63-f98a-3ac1-bea8-196ff6da53e9' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:92a05c63-f98a-3ac1-bea8-196ff6da53e9', 4, 'IV', 'La Comédie italienne', 'Sports et divertissements : IV. La Comédie italienne', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 11133 AND p.composer_id = 100
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:92a05c63-f98a-3ac1-bea8-196ff6da53e9'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 5, part.movement_number = 'V',
    part.name_ko = 'Le Réveil de la mariée', part.name_en = 'Sports et divertissements : V. Le Réveil de la mariée',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11133 AND p.composer_id = 100 AND part.part_key = 'musicbrainz:59632a43-235c-350a-8925-e3d816e8abcf' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:59632a43-235c-350a-8925-e3d816e8abcf', 5, 'V', 'Le Réveil de la mariée', 'Sports et divertissements : V. Le Réveil de la mariée', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 11133 AND p.composer_id = 100
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:59632a43-235c-350a-8925-e3d816e8abcf'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 6, part.movement_number = 'VI',
    part.name_ko = 'Colin-maillard', part.name_en = 'Sports et divertissements : VI. Colin-maillard',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11133 AND p.composer_id = 100 AND part.part_key = 'musicbrainz:c3d6a265-01e7-3611-85a7-b57e4a83ef0d' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:c3d6a265-01e7-3611-85a7-b57e4a83ef0d', 6, 'VI', 'Colin-maillard', 'Sports et divertissements : VI. Colin-maillard', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 11133 AND p.composer_id = 100
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:c3d6a265-01e7-3611-85a7-b57e4a83ef0d'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 7, part.movement_number = 'VII',
    part.name_ko = 'La Pêche', part.name_en = 'Sports et divertissements : VII. La Pêche',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11133 AND p.composer_id = 100 AND part.part_key = 'musicbrainz:7f4104f6-0717-3e3d-a039-8823de99bc53' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:7f4104f6-0717-3e3d-a039-8823de99bc53', 7, 'VII', 'La Pêche', 'Sports et divertissements : VII. La Pêche', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 11133 AND p.composer_id = 100
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:7f4104f6-0717-3e3d-a039-8823de99bc53'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 8, part.movement_number = 'VIII',
    part.name_ko = 'Le Yachting', part.name_en = 'Sports et divertissements : VIII. Le Yachting',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11133 AND p.composer_id = 100 AND part.part_key = 'musicbrainz:92c24dcd-a0d3-3c11-a83d-8c65ea8c34ee' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:92c24dcd-a0d3-3c11-a83d-8c65ea8c34ee', 8, 'VIII', 'Le Yachting', 'Sports et divertissements : VIII. Le Yachting', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 11133 AND p.composer_id = 100
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:92c24dcd-a0d3-3c11-a83d-8c65ea8c34ee'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 9, part.movement_number = 'IX',
    part.name_ko = 'Le Bain de mer', part.name_en = 'Sports et divertissements : IX. Le Bain de mer',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11133 AND p.composer_id = 100 AND part.part_key = 'musicbrainz:a5392cc5-e6f2-3310-89c6-2cb6afd4c30b' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:a5392cc5-e6f2-3310-89c6-2cb6afd4c30b', 9, 'IX', 'Le Bain de mer', 'Sports et divertissements : IX. Le Bain de mer', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 11133 AND p.composer_id = 100
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:a5392cc5-e6f2-3310-89c6-2cb6afd4c30b'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 10, part.movement_number = 'X',
    part.name_ko = 'Le Carnaval', part.name_en = 'Sports et divertissements : X. Le Carnaval',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11133 AND p.composer_id = 100 AND part.part_key = 'musicbrainz:a9a72d6e-db98-3f36-a974-be148a46d84d' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:a9a72d6e-db98-3f36-a974-be148a46d84d', 10, 'X', 'Le Carnaval', 'Sports et divertissements : X. Le Carnaval', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 11133 AND p.composer_id = 100
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:a9a72d6e-db98-3f36-a974-be148a46d84d'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 11, part.movement_number = 'XI',
    part.name_ko = 'Le Golf', part.name_en = 'Sports et divertissements : XI. Le Golf',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11133 AND p.composer_id = 100 AND part.part_key = 'musicbrainz:089c94ac-cac5-32a5-89f3-08bf4a89eb10' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:089c94ac-cac5-32a5-89f3-08bf4a89eb10', 11, 'XI', 'Le Golf', 'Sports et divertissements : XI. Le Golf', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 11133 AND p.composer_id = 100
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:089c94ac-cac5-32a5-89f3-08bf4a89eb10'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 12, part.movement_number = 'XII',
    part.name_ko = 'La Pieuvre', part.name_en = 'Sports et divertissements : XII. La Pieuvre',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11133 AND p.composer_id = 100 AND part.part_key = 'musicbrainz:59037575-4ba5-3a46-bfd1-ba2155acec53' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:59037575-4ba5-3a46-bfd1-ba2155acec53', 12, 'XII', 'La Pieuvre', 'Sports et divertissements : XII. La Pieuvre', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 11133 AND p.composer_id = 100
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:59037575-4ba5-3a46-bfd1-ba2155acec53'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 13, part.movement_number = 'XIII',
    part.name_ko = 'Les Courses', part.name_en = 'Sports et divertissements : XIII. Les Courses',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11133 AND p.composer_id = 100 AND part.part_key = 'musicbrainz:105d7c04-ba59-3cb4-a857-fdd0f948181f' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:105d7c04-ba59-3cb4-a857-fdd0f948181f', 13, 'XIII', 'Les Courses', 'Sports et divertissements : XIII. Les Courses', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 11133 AND p.composer_id = 100
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:105d7c04-ba59-3cb4-a857-fdd0f948181f'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 14, part.movement_number = 'XIV',
    part.name_ko = 'Les Quatre-coins', part.name_en = 'Sports et divertissements : XIV. Les Quatre-coins',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11133 AND p.composer_id = 100 AND part.part_key = 'musicbrainz:d6aaf7b0-ef8f-38ee-8a9c-e0acd638d7a2' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:d6aaf7b0-ef8f-38ee-8a9c-e0acd638d7a2', 14, 'XIV', 'Les Quatre-coins', 'Sports et divertissements : XIV. Les Quatre-coins', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 11133 AND p.composer_id = 100
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:d6aaf7b0-ef8f-38ee-8a9c-e0acd638d7a2'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 15, part.movement_number = 'XV',
    part.name_ko = 'Le Pique-nique', part.name_en = 'Sports et divertissements : XV. Le Pique-nique',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11133 AND p.composer_id = 100 AND part.part_key = 'musicbrainz:04b7bb62-220f-375b-80c0-448005e1ac4e' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:04b7bb62-220f-375b-80c0-448005e1ac4e', 15, 'XV', 'Le Pique-nique', 'Sports et divertissements : XV. Le Pique-nique', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 11133 AND p.composer_id = 100
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:04b7bb62-220f-375b-80c0-448005e1ac4e'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 16, part.movement_number = 'XVI',
    part.name_ko = 'Le Water-Chute', part.name_en = 'Sports et divertissements : XVI. Le Water-Chute',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11133 AND p.composer_id = 100 AND part.part_key = 'musicbrainz:793ccda6-9faa-343e-bb79-247b8be4c6b1' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:793ccda6-9faa-343e-bb79-247b8be4c6b1', 16, 'XVI', 'Le Water-Chute', 'Sports et divertissements : XVI. Le Water-Chute', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 11133 AND p.composer_id = 100
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:793ccda6-9faa-343e-bb79-247b8be4c6b1'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 17, part.movement_number = 'XVII',
    part.name_ko = 'Le Tango', part.name_en = 'Sports et divertissements : XVII. Le Tango',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11133 AND p.composer_id = 100 AND part.part_key = 'musicbrainz:c366a3a9-1bff-3b96-bbf4-5139e0862003' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:c366a3a9-1bff-3b96-bbf4-5139e0862003', 17, 'XVII', 'Le Tango', 'Sports et divertissements : XVII. Le Tango', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 11133 AND p.composer_id = 100
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:c366a3a9-1bff-3b96-bbf4-5139e0862003'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 18, part.movement_number = 'XVIII',
    part.name_ko = 'Le Traîneau', part.name_en = 'Sports et divertissements : XVIII. Le Traîneau',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11133 AND p.composer_id = 100 AND part.part_key = 'musicbrainz:b85e44f9-9a26-3a1f-a723-21ed4187fad6' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:b85e44f9-9a26-3a1f-a723-21ed4187fad6', 18, 'XVIII', 'Le Traîneau', 'Sports et divertissements : XVIII. Le Traîneau', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 11133 AND p.composer_id = 100
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:b85e44f9-9a26-3a1f-a723-21ed4187fad6'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 19, part.movement_number = 'XIX',
    part.name_ko = 'Le Flirt', part.name_en = 'Sports et divertissements : XIX. Le Flirt',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11133 AND p.composer_id = 100 AND part.part_key = 'musicbrainz:304f3076-8077-3dd3-8408-22b5b997ff86' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:304f3076-8077-3dd3-8408-22b5b997ff86', 19, 'XIX', 'Le Flirt', 'Sports et divertissements : XIX. Le Flirt', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 11133 AND p.composer_id = 100
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:304f3076-8077-3dd3-8408-22b5b997ff86'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 20, part.movement_number = 'XX',
    part.name_ko = 'Le Feu d’artifice', part.name_en = 'Sports et divertissements : XX. Le Feu d’artifice',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11133 AND p.composer_id = 100 AND part.part_key = 'musicbrainz:d9b26dc5-0329-394b-b73d-182c5207f54c' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:d9b26dc5-0329-394b-b73d-182c5207f54c', 20, 'XX', 'Le Feu d’artifice', 'Sports et divertissements : XX. Le Feu d’artifice', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 11133 AND p.composer_id = 100
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:d9b26dc5-0329-394b-b73d-182c5207f54c'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 21, part.movement_number = 'XXI',
    part.name_ko = 'Le Tennis', part.name_en = 'Sports et divertissements : XXI. Le Tennis',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11133 AND p.composer_id = 100 AND part.part_key = 'musicbrainz:d43bcb15-f97e-3960-b00c-5c5c401f0831' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:d43bcb15-f97e-3960-b00c-5c5c401f0831', 21, 'XXI', 'Le Tennis', 'Sports et divertissements : XXI. Le Tennis', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 11133 AND p.composer_id = 100
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:d43bcb15-f97e-3960-b00c-5c5c401f0831'
);


-- None Trois Gnossiennes

UPDATE pieces piece
SET piece.title = 'Trois Gnossiennes', piece.title_en = 'Trois Gnossiennes',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 10942 AND piece.composer_id = 100
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = (SELECT linked.id FROM pieces linked WHERE linked.id = 379 AND linked.composer_id = 100),
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'Gnossienne no. 1 - Lent', part.name_en = 'Gnossienne no. 1 - Lent',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 10942 AND p.composer_id = 100 AND part.part_key = 'musicbrainz:eb07cf62-985a-3f73-9595-2c45b95e1004' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 379 AND linked.composer_id = 100), 'musicbrainz:eb07cf62-985a-3f73-9595-2c45b95e1004', 1, NULL, 'Gnossienne no. 1 - Lent', 'Gnossienne no. 1 - Lent', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 10942 AND p.composer_id = 100
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:eb07cf62-985a-3f73-9595-2c45b95e1004'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'Gnossienne no. 2', part.name_en = 'Gnossienne no. 2',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 10942 AND p.composer_id = 100 AND part.part_key = 'musicbrainz:821d7218-b581-3b7e-80f9-7a93bede5321' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:821d7218-b581-3b7e-80f9-7a93bede5321', 2, NULL, 'Gnossienne no. 2', 'Gnossienne no. 2', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 10942 AND p.composer_id = 100
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:821d7218-b581-3b7e-80f9-7a93bede5321'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = NULL,
    part.name_ko = 'Gnossienne no. 3', part.name_en = 'Gnossienne no. 3',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 10942 AND p.composer_id = 100 AND part.part_key = 'musicbrainz:9b36f664-2c21-34ba-ae5c-08d44e89fee2' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:9b36f664-2c21-34ba-ae5c-08d44e89fee2', 3, NULL, 'Gnossienne no. 3', 'Gnossienne no. 3', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 10942 AND p.composer_id = 100
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:9b36f664-2c21-34ba-ae5c-08d44e89fee2'
);


-- None Trois Sarabandes

UPDATE pieces piece
SET piece.title = 'Trois Sarabandes', piece.title_en = 'Trois Sarabandes',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 10447 AND piece.composer_id = 100
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'Première Sarabande', part.name_en = 'Première Sarabande',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 10447 AND p.composer_id = 100 AND part.part_key = 'musicbrainz:9f2bc158-38b2-3c77-9561-5e73b72c1324' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:9f2bc158-38b2-3c77-9561-5e73b72c1324', 1, NULL, 'Première Sarabande', 'Première Sarabande', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 10447 AND p.composer_id = 100
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:9f2bc158-38b2-3c77-9561-5e73b72c1324'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'Deuxième Sarabande', part.name_en = 'Deuxième Sarabande',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 10447 AND p.composer_id = 100 AND part.part_key = 'musicbrainz:d3d04831-2154-325d-81aa-421d66385555' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:d3d04831-2154-325d-81aa-421d66385555', 2, NULL, 'Deuxième Sarabande', 'Deuxième Sarabande', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 10447 AND p.composer_id = 100
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:d3d04831-2154-325d-81aa-421d66385555'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = NULL,
    part.name_ko = 'Troisième Sarabande', part.name_en = 'Troisième Sarabande',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 10447 AND p.composer_id = 100 AND part.part_key = 'musicbrainz:272e00ce-1aae-40a0-86bd-5141bbaca7d5' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:272e00ce-1aae-40a0-86bd-5141bbaca7d5', 3, NULL, 'Troisième Sarabande', 'Troisième Sarabande', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 10447 AND p.composer_id = 100
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:272e00ce-1aae-40a0-86bd-5141bbaca7d5'
);


-- None Trois Sonneries de la Rose+Croix

UPDATE pieces piece
SET piece.title = 'Trois Sonneries de la Rose+Croix', piece.title_en = 'Trois Sonneries de la Rose+Croix',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 8889 AND piece.composer_id = 100
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'Air de l’Ordre', part.name_en = 'Trois Sonneries de la Rose+Croix : I. Air de l’Ordre',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 8889 AND p.composer_id = 100 AND part.part_key = 'musicbrainz:b942cfd8-7f52-3f13-b19b-93924a7ad7b0' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:b942cfd8-7f52-3f13-b19b-93924a7ad7b0', 1, 'I', 'Air de l’Ordre', 'Trois Sonneries de la Rose+Croix : I. Air de l’Ordre', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 8889 AND p.composer_id = 100
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:b942cfd8-7f52-3f13-b19b-93924a7ad7b0'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'Air du Grand Maître (Le Sâr Joséphin Péladan)', part.name_en = 'Trois Sonneries de la Rose+Croix : II. Air du Grand Maître (Le Sâr Joséphin Péladan)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 8889 AND p.composer_id = 100 AND part.part_key = 'musicbrainz:6a19eb32-d507-326b-99d4-90cd062e0d64' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:6a19eb32-d507-326b-99d4-90cd062e0d64', 2, 'II', 'Air du Grand Maître (Le Sâr Joséphin Péladan)', 'Trois Sonneries de la Rose+Croix : II. Air du Grand Maître (Le Sâr Joséphin Péladan)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 8889 AND p.composer_id = 100
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:6a19eb32-d507-326b-99d4-90cd062e0d64'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = 'Air du Grand Prieur (Le Comte Antoine de la Rochefoucauld)', part.name_en = 'Trois Sonneries de la Rose+Croix : III. Air du Grand Prieur (Le Comte Antoine de la Rochefoucauld)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 8889 AND p.composer_id = 100 AND part.part_key = 'musicbrainz:b85fb10e-43e3-3ca8-972f-0a4fc5a47c58' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:b85fb10e-43e3-3ca8-972f-0a4fc5a47c58', 3, 'III', 'Air du Grand Prieur (Le Comte Antoine de la Rochefoucauld)', 'Trois Sonneries de la Rose+Croix : III. Air du Grand Prieur (Le Comte Antoine de la Rochefoucauld)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 8889 AND p.composer_id = 100
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:b85fb10e-43e3-3ca8-972f-0a4fc5a47c58'
);


-- None Trois mélodies sans paroles

UPDATE pieces piece
SET piece.title = 'Trois mélodies sans paroles', piece.title_en = 'Trois mélodies sans paroles',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 9915 AND piece.composer_id = 100
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'Rambouillet', part.name_en = 'Trois mélodies sans paroles: Rambouillet',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 9915 AND p.composer_id = 100 AND part.part_key = 'musicbrainz:06002868-44a4-48c8-ab56-1eadeb018247' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:06002868-44a4-48c8-ab56-1eadeb018247', 1, NULL, 'Rambouillet', 'Trois mélodies sans paroles: Rambouillet', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 9915 AND p.composer_id = 100
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:06002868-44a4-48c8-ab56-1eadeb018247'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'Marienbad', part.name_en = 'Trois mélodies sans paroles: Marienbad',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 9915 AND p.composer_id = 100 AND part.part_key = 'musicbrainz:1a1a65ed-790d-4360-9151-975d648bf220' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:1a1a65ed-790d-4360-9151-975d648bf220', 2, NULL, 'Marienbad', 'Trois mélodies sans paroles: Marienbad', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 9915 AND p.composer_id = 100
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:1a1a65ed-790d-4360-9151-975d648bf220'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = NULL,
    part.name_ko = 'Les Oiseaux', part.name_en = 'Trois mélodies sans paroles: Les Oiseaux',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 9915 AND p.composer_id = 100 AND part.part_key = 'musicbrainz:8328fea4-5189-4d45-8a60-cb89e4a9252d' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:8328fea4-5189-4d45-8a60-cb89e4a9252d', 3, NULL, 'Les Oiseaux', 'Trois mélodies sans paroles: Les Oiseaux', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 9915 AND p.composer_id = 100
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:8328fea4-5189-4d45-8a60-cb89e4a9252d'
);


-- None Trois nouvelles enfantines

UPDATE pieces piece
SET piece.title = 'Trois nouvelles enfantines', piece.title_en = 'Trois nouvelles enfantines',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 10786 AND piece.composer_id = 100
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'Le Vilain Petit Vaurien', part.name_en = 'Trois Nouvelles enfantines : I. Le Vilain Petit Vaurien',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 10786 AND p.composer_id = 100 AND part.part_key = 'musicbrainz:13618022-7ee9-40cb-b639-af7f61631f9a' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:13618022-7ee9-40cb-b639-af7f61631f9a', 1, 'I', 'Le Vilain Petit Vaurien', 'Trois Nouvelles enfantines : I. Le Vilain Petit Vaurien', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 10786 AND p.composer_id = 100
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:13618022-7ee9-40cb-b639-af7f61631f9a'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'Berceuse', part.name_en = 'Trois Nouvelles enfantines : II. Berceuse',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 10786 AND p.composer_id = 100 AND part.part_key = 'musicbrainz:cc9c4050-bce9-4d03-8670-006671c51d6f' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:cc9c4050-bce9-4d03-8670-006671c51d6f', 2, 'II', 'Berceuse', 'Trois Nouvelles enfantines : II. Berceuse', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 10786 AND p.composer_id = 100
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:cc9c4050-bce9-4d03-8670-006671c51d6f'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = 'La gentille toute petite Fille', part.name_en = 'Trois Nouvelles enfantines : III. La gentille toute petite Fille',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 10786 AND p.composer_id = 100 AND part.part_key = 'musicbrainz:85306087-3279-4f1b-8072-16a2ff341bfc' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:85306087-3279-4f1b-8072-16a2ff341bfc', 3, 'III', 'La gentille toute petite Fille', 'Trois Nouvelles enfantines : III. La gentille toute petite Fille', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 10786 AND p.composer_id = 100
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:85306087-3279-4f1b-8072-16a2ff341bfc'
);


-- None 연가곡집 <Trois poèmes d’amour>

UPDATE pieces piece
SET piece.title = '연가곡집 <Trois poèmes d’amour>', piece.title_en = 'Trois poèmes d’amour',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 8349 AND piece.composer_id = 100
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'Ne suis que grain de sable', part.name_en = 'Trois poèmes d’amour : No. 1. Ne suis que grain de sable',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 8349 AND p.composer_id = 100 AND part.part_key = 'musicbrainz:742d8c20-9ffa-444b-ae2e-2b9009989756' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:742d8c20-9ffa-444b-ae2e-2b9009989756', 1, NULL, 'Ne suis que grain de sable', 'Trois poèmes d’amour : No. 1. Ne suis que grain de sable', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 8349 AND p.composer_id = 100
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:742d8c20-9ffa-444b-ae2e-2b9009989756'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'Suis chauve de naissance', part.name_en = 'Trois poèmes d’amour : No. 2. Suis chauve de naissance',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 8349 AND p.composer_id = 100 AND part.part_key = 'musicbrainz:96893779-799d-4be8-90ac-1a348b8e084a' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:96893779-799d-4be8-90ac-1a348b8e084a', 2, NULL, 'Suis chauve de naissance', 'Trois poèmes d’amour : No. 2. Suis chauve de naissance', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 8349 AND p.composer_id = 100
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:96893779-799d-4be8-90ac-1a348b8e084a'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = NULL,
    part.name_ko = 'Ta parure est secrète', part.name_en = 'Trois poèmes d’amour : No. 3. Ta parure est secrète',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 8349 AND p.composer_id = 100 AND part.part_key = 'musicbrainz:94121fac-bf7d-4b34-8c1e-2387f0cda943' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:94121fac-bf7d-4b34-8c1e-2387f0cda943', 3, NULL, 'Ta parure est secrète', 'Trois poèmes d’amour : No. 3. Ta parure est secrète', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 8349 AND p.composer_id = 100
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:94121fac-bf7d-4b34-8c1e-2387f0cda943'
);


-- None 가곡 <Un dîner à l'Élysée>

UPDATE pieces piece
SET piece.title = '가곡 <Un dîner à l''Élysée>', piece.title_en = 'Un dîner à l''Élysée',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 8098 AND piece.composer_id = 100
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None 발레 <Uspud>

UPDATE pieces piece
SET piece.title = '발레 <Uspud>', piece.title_en = 'Uspud',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 10274 AND piece.composer_id = 100
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'Acte I', part.name_en = 'Uspud: Acte I',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 10274 AND p.composer_id = 100 AND part.part_key = 'musicbrainz:346efa68-122f-4c9b-931d-5ec12fe4a53c' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:346efa68-122f-4c9b-931d-5ec12fe4a53c', 1, NULL, 'Acte I', 'Uspud: Acte I', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 10274 AND p.composer_id = 100
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:346efa68-122f-4c9b-931d-5ec12fe4a53c'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'Acte II', part.name_en = 'Uspud: Acte II',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 10274 AND p.composer_id = 100 AND part.part_key = 'musicbrainz:366ef15f-5cd2-4ba2-9a90-e9cfc22efeb5' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:366ef15f-5cd2-4ba2-9a90-e9cfc22efeb5', 2, NULL, 'Acte II', 'Uspud: Acte II', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 10274 AND p.composer_id = 100
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:366ef15f-5cd2-4ba2-9a90-e9cfc22efeb5'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = NULL,
    part.name_ko = 'Acte III', part.name_en = 'Uspud: Acte III',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 10274 AND p.composer_id = 100 AND part.part_key = 'musicbrainz:a8568888-511a-4651-b522-e7cebcd4df37' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:a8568888-511a-4651-b522-e7cebcd4df37', 3, NULL, 'Acte III', 'Uspud: Acte III', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 10274 AND p.composer_id = 100
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:a8568888-511a-4651-b522-e7cebcd4df37'
);


-- None Uspud : Ballet chrétien en 3 actes

UPDATE pieces piece
SET piece.title = 'Uspud : Ballet chrétien en 3 actes', piece.title_en = 'Uspud : Ballet chrétien en 3 actes',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 7535 AND piece.composer_id = 100
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'Acte premier', part.name_en = 'Ballet chrétien : Acte premier',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 7535 AND p.composer_id = 100 AND part.part_key = 'musicbrainz:d436dd99-a5a9-485b-833c-5f0b83f6ab10' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:d436dd99-a5a9-485b-833c-5f0b83f6ab10', 1, NULL, 'Acte premier', 'Ballet chrétien : Acte premier', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 7535 AND p.composer_id = 100
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:d436dd99-a5a9-485b-833c-5f0b83f6ab10'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'Deuxieme acte', part.name_en = 'Ballet chrétien : Deuxieme acte',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 7535 AND p.composer_id = 100 AND part.part_key = 'musicbrainz:f21cd7c0-dada-4664-9c14-72ad920b8576' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:f21cd7c0-dada-4664-9c14-72ad920b8576', 2, NULL, 'Deuxieme acte', 'Ballet chrétien : Deuxieme acte', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 7535 AND p.composer_id = 100
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:f21cd7c0-dada-4664-9c14-72ad920b8576'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = NULL,
    part.name_ko = 'Troisieme acte', part.name_en = 'Ballet chrétien : Troisieme acte',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 7535 AND p.composer_id = 100 AND part.part_key = 'musicbrainz:de3fc9ee-76bb-431d-a665-0b35c4eee8c3' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:de3fc9ee-76bb-431d-a665-0b35c4eee8c3', 3, NULL, 'Troisieme acte', 'Ballet chrétien : Troisieme acte', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 7535 AND p.composer_id = 100
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:de3fc9ee-76bb-431d-a665-0b35c4eee8c3'
);


-- None 왈츠

UPDATE pieces piece
SET piece.title = '왈츠', piece.title_en = 'Valse',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 10472 AND piece.composer_id = 100
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- Op. 62 Valse-ballet

UPDATE pieces piece
SET piece.title = 'Valse-ballet', piece.title_en = 'Valse-ballet, op. 62',
    piece.type = 'song', piece.opus_number = 'Op. 62',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 7640 AND piece.composer_id = 100
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Verset laïque et somptueux

UPDATE pieces piece
SET piece.title = 'Verset laïque et somptueux', piece.title_en = 'Verset laïque et somptueux',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 8997 AND piece.composer_id = 100
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Vexations (version 1)

UPDATE pieces piece
SET piece.title = 'Vexations (version 1)', piece.title_en = 'Vexations (version 1)',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 8734 AND piece.composer_id = 100
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Vieux Sequins et Vieilles Cuirasses

UPDATE pieces piece
SET piece.title = 'Vieux Sequins et Vieilles Cuirasses', piece.title_en = 'Vieux Sequins et Vieilles Cuirasses',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 8457 AND piece.composer_id = 100
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'Chez le marchand d’or (Venise XIIIe siecle)', part.name_en = 'Vieux Sequins et Vieilles Cuirasses : I. Chez le marchand d’or (Venise XIIIe siecle)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 8457 AND p.composer_id = 100 AND part.part_key = 'musicbrainz:46301c54-359e-40c3-8ed1-f88f0302ae4f' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:46301c54-359e-40c3-8ed1-f88f0302ae4f', 1, 'I', 'Chez le marchand d’or (Venise XIIIe siecle)', 'Vieux Sequins et Vieilles Cuirasses : I. Chez le marchand d’or (Venise XIIIe siecle)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 8457 AND p.composer_id = 100
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:46301c54-359e-40c3-8ed1-f88f0302ae4f'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'Danse cuirassée (période grecque)', part.name_en = 'Vieux Sequins et Vieilles Cuirasses : II. Danse cuirassée (période grecque)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 8457 AND p.composer_id = 100 AND part.part_key = 'musicbrainz:b487984a-07c4-47ea-bcc7-c413c5dcf694' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:b487984a-07c4-47ea-bcc7-c413c5dcf694', 2, 'II', 'Danse cuirassée (période grecque)', 'Vieux Sequins et Vieilles Cuirasses : II. Danse cuirassée (période grecque)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 8457 AND p.composer_id = 100
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:b487984a-07c4-47ea-bcc7-c413c5dcf694'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = 'La défaite des Cimbres (cauchemar)', part.name_en = 'Vieux Sequins et Vieilles Cuirasses : III. La défaite des Cimbres (cauchemar)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 8457 AND p.composer_id = 100 AND part.part_key = 'musicbrainz:09daae51-b25f-47e9-8101-069676e899e9' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:09daae51-b25f-47e9-8101-069676e899e9', 3, 'III', 'La défaite des Cimbres (cauchemar)', 'Vieux Sequins et Vieilles Cuirasses : III. La défaite des Cimbres (cauchemar)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 8457 AND p.composer_id = 100
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:09daae51-b25f-47e9-8101-069676e899e9'
);


-- None [Hymne pour le] Salut drapeau !

UPDATE pieces piece
SET piece.title = '[Hymne pour le] Salut drapeau !', piece.title_en = '[Hymne pour le] Salut drapeau !',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 7644 AND piece.composer_id = 100
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Émergence du 4e Nocturne

UPDATE pieces piece
SET piece.title = 'Émergence du 4e Nocturne', piece.title_en = 'Émergence du 4e Nocturne',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 10242 AND piece.composer_id = 100
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Caresse

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, 'Caresse', 'Caresse', 'song', NULL, NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 100
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = 'Caresse'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '4dead613-6c02-3faa-9277-e3974750a583'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '4dead613-6c02-3faa-9277-e3974750a583'
FROM pieces p
WHERE p.composer_id = 100 AND p.title = 'Caresse' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '4dead613-6c02-3faa-9277-e3974750a583'
);


-- None Chanson barbare

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, 'Chanson barbare', 'Chanson barbare', 'song', NULL, NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 100
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = 'Chanson barbare'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'cad1f338-dd5e-43a2-9b77-419fc6fcc4f0'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'cad1f338-dd5e-43a2-9b77-419fc6fcc4f0'
FROM pieces p
WHERE p.composer_id = 100 AND p.title = 'Chanson barbare' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'cad1f338-dd5e-43a2-9b77-419fc6fcc4f0'
);


-- None Cinéma

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, 'Cinéma', 'Cinéma', 'song', NULL, NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 100
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = 'Cinéma'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '0cda336c-a856-3271-aacd-f9d6213e8d2b'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '0cda336c-a856-3271-aacd-f9d6213e8d2b'
FROM pieces p
WHERE p.composer_id = 100 AND p.title = 'Cinéma' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '0cda336c-a856-3271-aacd-f9d6213e8d2b'
);


-- None Danses gothiques

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, 'Danses gothiques', 'Danses gothiques', 'album', NULL, NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 100
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = 'Danses gothiques'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'b1f517fc-8f99-3e5e-af99-2e4cd585b125'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'b1f517fc-8f99-3e5e-af99-2e4cd585b125'
FROM pieces p
WHERE p.composer_id = 100 AND p.title = 'Danses gothiques' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'b1f517fc-8f99-3e5e-af99-2e4cd585b125'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:c59dcd8b-0ab5-3dfa-bbc7-6cc477c43886', 1, 'I', 'À l''occasion d''une grande peine', 'Danses gothiques : I. À l''occasion d''une grande peine', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 100 AND p.title = 'Danses gothiques' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:c59dcd8b-0ab5-3dfa-bbc7-6cc477c43886'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:f8485c8d-137a-4079-994f-5fd956d6937b', 2, 'II', 'Dans laquelle les Pères de la Très Véritable et Très Sainte Église sont invoqués', 'Danses gothiques : II. Dans laquelle les Pères de la Très Véritable et Très Sainte Église sont invoqués', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 100 AND p.title = 'Danses gothiques' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:f8485c8d-137a-4079-994f-5fd956d6937b'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:8e8833ae-6cc2-3120-b87d-9173bf1926b0', 3, 'III', 'En faveur d''un malheureux', 'Danses gothiques : III. En faveur d''un malheureux', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 100 AND p.title = 'Danses gothiques' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:8e8833ae-6cc2-3120-b87d-9173bf1926b0'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:0863ab05-822f-42dd-ae8a-901e246aad85', 4, 'IV', 'À propos de Saint-Bernard et de Sainte-Lucie', 'Danses gothiques : IV. À propos de Saint-Bernard et de Sainte-Lucie', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 100 AND p.title = 'Danses gothiques' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:0863ab05-822f-42dd-ae8a-901e246aad85'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:edaa5a2e-32b3-4e39-b381-07f69359e182', 5, 'V', 'Pour les pauvres trépassés', 'Danses gothiques : V. Pour les pauvres trépassés', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 100 AND p.title = 'Danses gothiques' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:edaa5a2e-32b3-4e39-b381-07f69359e182'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:ef722d19-c7ea-45e1-8ca1-878c8d44224c', 6, 'VI', 'Où il est question du pardon des injures reçues', 'Danses gothiques : VI. Où il est question du pardon des injures reçues', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 100 AND p.title = 'Danses gothiques' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:ef722d19-c7ea-45e1-8ca1-878c8d44224c'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:08363249-8245-4a24-a6ad-30fab46c812e', 7, 'VII', 'Par pitié pour les ivrognes, honteux, débauchés, imparfaits, dèsagréables et faussaires en tous genres', 'Danses gothiques : VII. Par pitié pour les ivrognes, honteux, débauchés, imparfaits, dèsagréables et faussaires en tous genres', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 100 AND p.title = 'Danses gothiques' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:08363249-8245-4a24-a6ad-30fab46c812e'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:fd70d77d-050c-48a5-9927-41a2a3070c47', 8, 'VIII', 'En le haut honneur du vénéré Saint Michel, le gracieux archange', 'Danses gothiques : VIII. En le haut honneur du vénéré Saint Michel, le gracieux archange', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 100 AND p.title = 'Danses gothiques' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:fd70d77d-050c-48a5-9927-41a2a3070c47'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:9784fd37-f2cc-4ef5-af5d-f203a8a70eb5', 9, 'IX', 'Après avoir obtenu la remise de ses fautes', 'Danses gothiques : IX. Après avoir obtenu la remise de ses fautes', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 100 AND p.title = 'Danses gothiques' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:9784fd37-f2cc-4ef5-af5d-f203a8a70eb5'
);


-- None En habit de cheval

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, 'En habit de cheval', 'En habit de cheval', 'album', NULL, NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 100
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = 'En habit de cheval'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '9acb0265-a690-4aed-8e5f-414e9ad38a8a'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '9acb0265-a690-4aed-8e5f-414e9ad38a8a'
FROM pieces p
WHERE p.composer_id = 100 AND p.title = 'En habit de cheval' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '9acb0265-a690-4aed-8e5f-414e9ad38a8a'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:d7d609e7-9040-3bcb-aa10-a79b411181d2', 1, 'I', 'Chorale', 'En habit de cheval: I. Chorale', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 100 AND p.title = 'En habit de cheval' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:d7d609e7-9040-3bcb-aa10-a79b411181d2'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:af0a76ad-ac2c-3e0b-b31c-258ce276420e', 2, 'II', 'Fugue litanique', 'En habit de cheval: II. Fugue litanique', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 100 AND p.title = 'En habit de cheval' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:af0a76ad-ac2c-3e0b-b31c-258ce276420e'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:4970387d-7312-31ea-9b68-ca9810ba439d', 3, 'III', 'Autre chorale', 'En habit de cheval: III. Autre chorale', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 100 AND p.title = 'En habit de cheval' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:4970387d-7312-31ea-9b68-ca9810ba439d'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:21ef57e5-c901-3563-aea6-87b2708ca8fa', 4, 'IV', 'Fugue de papier', 'En habit de cheval: IV. Fugue de papier', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 100 AND p.title = 'En habit de cheval' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:21ef57e5-c901-3563-aea6-87b2708ca8fa'
);


-- None 오페라 <Geneviève de Brabant>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '오페라 <Geneviève de Brabant>', 'Geneviève de Brabant', 'album', NULL, NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 100
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '오페라 <Geneviève de Brabant>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '8c9a6a24-efc3-4c8a-a926-8cadf90e91c1'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '8c9a6a24-efc3-4c8a-a926-8cadf90e91c1'
FROM pieces p
WHERE p.composer_id = 100 AND p.title = '오페라 <Geneviève de Brabant>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '8c9a6a24-efc3-4c8a-a926-8cadf90e91c1'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:1704e4d6-e2a9-4254-b7ae-f42724bbe864', 1, NULL, 'Prélude', 'Geneviève de Brabant : Prélude', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 100 AND p.title = '오페라 <Geneviève de Brabant>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:1704e4d6-e2a9-4254-b7ae-f42724bbe864'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:6bde475c-55f8-42c5-84cc-0fc75f03c5b4', 2, NULL, 'Premier acte', 'Geneviève de Brabant : Premier acte', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 100 AND p.title = '오페라 <Geneviève de Brabant>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:6bde475c-55f8-42c5-84cc-0fc75f03c5b4'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:195aa0d9-07ea-4845-b312-59905681d4df', 3, NULL, 'Deuxième acte', 'Geneviève de Brabant : Deuxième acte', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 100 AND p.title = '오페라 <Geneviève de Brabant>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:195aa0d9-07ea-4845-b312-59905681d4df'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:a97c7868-137b-4fed-9cfb-abacc10d5ea6', 1, NULL, 'Deuxième acte: Gendarmes Duet', 'Geneviève de Brabant: Deuxième acte: Gendarmes Duet', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:195aa0d9-07ea-4845-b312-59905681d4df'
WHERE p.composer_id = 100 AND p.title = '오페라 <Geneviève de Brabant>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:a97c7868-137b-4fed-9cfb-abacc10d5ea6'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:a4342e36-44b3-45b4-ba02-23c5125cbf86', 4, NULL, 'Troisième acte', 'Geneviève de Brabant : Troisième acte', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 100 AND p.title = '오페라 <Geneviève de Brabant>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:a4342e36-44b3-45b4-ba02-23c5125cbf86'
);


-- None Gnossienne no. 4

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, 'Gnossienne no. 4', 'Gnossienne no. 4', 'song', NULL, NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 100
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = 'Gnossienne no. 4'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '501f308d-0e5f-3e8d-8e17-9858ea3f0a5a'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '501f308d-0e5f-3e8d-8e17-9858ea3f0a5a'
FROM pieces p
WHERE p.composer_id = 100 AND p.title = 'Gnossienne no. 4' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '501f308d-0e5f-3e8d-8e17-9858ea3f0a5a'
);


-- None Gnossienne no. 5

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, 'Gnossienne no. 5', 'Gnossienne no. 5', 'song', NULL, NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 100
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = 'Gnossienne no. 5'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '64c35cb8-428b-34a7-9376-3333b27ae9bf'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '64c35cb8-428b-34a7-9376-3333b27ae9bf'
FROM pieces p
WHERE p.composer_id = 100 AND p.title = 'Gnossienne no. 5' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '64c35cb8-428b-34a7-9376-3333b27ae9bf'
);


-- None Gnossienne no. 6

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, 'Gnossienne no. 6', 'Gnossienne no. 6', 'song', NULL, NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 100
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = 'Gnossienne no. 6'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '1a085f20-121d-3426-bb88-868569783f9b'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '1a085f20-121d-3426-bb88-868569783f9b'
FROM pieces p
WHERE p.composer_id = 100 AND p.title = 'Gnossienne no. 6' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '1a085f20-121d-3426-bb88-868569783f9b'
);


-- None Gnossienne no. 7

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, 'Gnossienne no. 7', 'Gnossienne no. 7', 'song', NULL, NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 100
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = 'Gnossienne no. 7'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'd5128dba-a9c6-45f7-a0a1-a334d325c700'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'd5128dba-a9c6-45f7-a0a1-a334d325c700'
FROM pieces p
WHERE p.composer_id = 100 AND p.title = 'Gnossienne no. 7' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'd5128dba-a9c6-45f7-a0a1-a334d325c700'
);


-- None Gymnopédies

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, 'Gymnopédies', 'Gymnopédies', 'album', NULL, NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 100
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = 'Gymnopédies'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'c8dd2fee-9480-4c2f-89a2-eada0e3d5302'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'c8dd2fee-9480-4c2f-89a2-eada0e3d5302'
FROM pieces p
WHERE p.composer_id = 100 AND p.title = 'Gymnopédies' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'c8dd2fee-9480-4c2f-89a2-eada0e3d5302'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:c62b3c0e-fa80-3755-a675-ffd555cbd546', 1, NULL, 'Lent et douloureux', 'Première Gymnopédie : Lent et douloureux', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 100 AND p.title = 'Gymnopédies' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:c62b3c0e-fa80-3755-a675-ffd555cbd546'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:35f87863-b20a-3189-bd13-5b31de99dff9', 2, NULL, 'Lent et triste', 'Deuxième Gymnopédie : Lent et triste', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 100 AND p.title = 'Gymnopédies' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:35f87863-b20a-3189-bd13-5b31de99dff9'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:e634481c-3fb9-3ee3-ad96-b5e538cc11aa', 3, NULL, 'Lent et grave', 'Troisième Gymnopédie : Lent et grave', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 100 AND p.title = 'Gymnopédies' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:e634481c-3fb9-3ee3-ad96-b5e538cc11aa'
);


-- None Jack-in-the-Box

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, 'Jack-in-the-Box', 'Jack-in-the-Box', 'album', NULL, NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 100
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = 'Jack-in-the-Box'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'c1a30488-bb1e-4b51-9929-c1251fedf54d'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'c1a30488-bb1e-4b51-9929-c1251fedf54d'
FROM pieces p
WHERE p.composer_id = 100 AND p.title = 'Jack-in-the-Box' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'c1a30488-bb1e-4b51-9929-c1251fedf54d'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:b475fb5e-46a2-3f1a-ad0d-fbcd7180fcfe', 1, 'I', 'Prélude', 'Jack-in-the-Box : I. Prélude', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 100 AND p.title = 'Jack-in-the-Box' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:b475fb5e-46a2-3f1a-ad0d-fbcd7180fcfe'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:f85253b8-b444-37ea-a974-5fc3301fdbcb', 2, 'II', 'Entr''acte', 'Jack-in-the-Box : II. Entr''acte', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 100 AND p.title = 'Jack-in-the-Box' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:f85253b8-b444-37ea-a974-5fc3301fdbcb'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:d15ae8ab-9e06-3c40-9459-5c36e459b9b2', 3, 'III', 'Finale', 'Jack-in-the-Box : III. Finale', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 100 AND p.title = 'Jack-in-the-Box' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:d15ae8ab-9e06-3c40-9459-5c36e459b9b2'
);


-- None 가곡 <La Diva de l’Empire>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '가곡 <La Diva de l’Empire>', 'La Diva de l’Empire', 'song', NULL, NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 100
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '가곡 <La Diva de l’Empire>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'bd0e3917-9441-402c-bbcc-2fefdf3a4d8a'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'bd0e3917-9441-402c-bbcc-2fefdf3a4d8a'
FROM pieces p
WHERE p.composer_id = 100 AND p.title = '가곡 <La Diva de l’Empire>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'bd0e3917-9441-402c-bbcc-2fefdf3a4d8a'
);


-- None 미뉴에트

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '미뉴에트', 'Menuet', 'song', NULL, NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 100
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '미뉴에트'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'a5662704-95f8-45a3-907c-4c7e619de7da'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'a5662704-95f8-45a3-907c-4c7e619de7da'
FROM pieces p
WHERE p.composer_id = 100 AND p.title = '미뉴에트' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'a5662704-95f8-45a3-907c-4c7e619de7da'
);


-- None 발레 <Mercure>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '발레 <Mercure>', 'Mercure', 'album', NULL, NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 100
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '발레 <Mercure>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '097f45ff-2370-4a72-bc6a-2b18bbbdefe3'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '097f45ff-2370-4a72-bc6a-2b18bbbdefe3'
FROM pieces p
WHERE p.composer_id = 100 AND p.title = '발레 <Mercure>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '097f45ff-2370-4a72-bc6a-2b18bbbdefe3'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:df0844e3-d351-4a23-8fdb-fd47e1e04a61', 1, NULL, 'Marche‐ouverture', 'Mercure: Marche‐ouverture', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 100 AND p.title = '발레 <Mercure>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:df0844e3-d351-4a23-8fdb-fd47e1e04a61'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:c397b3c7-190d-4408-bdef-7b51d5bde6e0', 2, NULL, 'La Nuit', 'Mercure: La Nuit', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 100 AND p.title = '발레 <Mercure>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:c397b3c7-190d-4408-bdef-7b51d5bde6e0'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:c288e46a-6d11-4fe9-a151-4e05827fc186', 3, NULL, 'Danse de tendresse (Apollon et Vénus)', 'Mercure: Danse de tendresse (Apollon et Vénus)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 100 AND p.title = '발레 <Mercure>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:c288e46a-6d11-4fe9-a151-4e05827fc186'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:55528653-4bb6-4c3d-abb5-11297af25db3', 4, NULL, 'Signes du zodiaque', 'Mercure: Signes du zodiaque', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 100 AND p.title = '발레 <Mercure>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:55528653-4bb6-4c3d-abb5-11297af25db3'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:b18d8eb6-5375-4a60-8791-4bf51dfa7850', 5, NULL, 'Entrée et danse de Mercure', 'Mercure: Entrée et danse de Mercure', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 100 AND p.title = '발레 <Mercure>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:b18d8eb6-5375-4a60-8791-4bf51dfa7850'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:65f5da89-6a29-41f6-89ed-7b766520d56a', 6, NULL, 'Danse des grâces', 'Mercure: Danse des grâces', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 100 AND p.title = '발레 <Mercure>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:65f5da89-6a29-41f6-89ed-7b766520d56a'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:9007f36d-d4c1-476b-9d78-a59d4cd9aa3f', 7, NULL, 'Bain des grâces', 'Mercure: Bain des grâces', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 100 AND p.title = '발레 <Mercure>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:9007f36d-d4c1-476b-9d78-a59d4cd9aa3f'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:39a4672c-6e4f-48a9-a8c5-e6ee73c0b33f', 8, NULL, 'Fuite de Mercure', 'Mercure: Fuite de Mercure', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 100 AND p.title = '발레 <Mercure>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:39a4672c-6e4f-48a9-a8c5-e6ee73c0b33f'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:da650abf-89e8-44c4-b664-354e447ea929', 9, NULL, 'Colère de Cerbère', 'Mercure: Colère de Cerbère', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 100 AND p.title = '발레 <Mercure>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:da650abf-89e8-44c4-b664-354e447ea929'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:e1b30aa5-ddeb-42b3-a9c6-ee5b722fb84f', 10, NULL, 'Polka des lettres', 'Mercure: Polka des lettres', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 100 AND p.title = '발레 <Mercure>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:e1b30aa5-ddeb-42b3-a9c6-ee5b722fb84f'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:910a0b42-8a6e-48e7-8a55-f6024b25e070', 11, NULL, 'Nouvelle danse', 'Mercure: Nouvelle danse', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 100 AND p.title = '발레 <Mercure>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:910a0b42-8a6e-48e7-8a55-f6024b25e070'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:1e704df6-922c-4e9d-a059-ecaf7454313c', 12, NULL, 'Le Chaos', 'Mercure: Le Chaos', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 100 AND p.title = '발레 <Mercure>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:1e704df6-922c-4e9d-a059-ecaf7454313c'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:4c0e28ad-df71-401c-a383-ff829f38e753', 13, NULL, 'Final. Rapt de Proserpine', 'Mercure: Final. Rapt de Proserpine', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 100 AND p.title = '발레 <Mercure>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:4c0e28ad-df71-401c-a383-ff829f38e753'
);


-- None Musique d’ameublement

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, 'Musique d’ameublement', 'Musique d’ameublement', 'album', NULL, NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 100
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = 'Musique d’ameublement'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '40665c24-61a3-4fd5-899d-57e7290b7969'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '40665c24-61a3-4fd5-899d-57e7290b7969'
FROM pieces p
WHERE p.composer_id = 100 AND p.title = 'Musique d’ameublement' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '40665c24-61a3-4fd5-899d-57e7290b7969'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:830b9b27-7df7-3d67-b8db-6553eee962e8', 1, 'I', 'Tapisserie en fer forgé', 'Musique d’ameublement : I. Tapisserie en fer forgé', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 100 AND p.title = 'Musique d’ameublement' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:830b9b27-7df7-3d67-b8db-6553eee962e8'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:8442f957-8051-3d93-987a-c90dd60e3047', 2, 'II', 'Carrelage phonique', 'Musique d’ameublement : II. Carrelage phonique', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 100 AND p.title = 'Musique d’ameublement' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:8442f957-8051-3d93-987a-c90dd60e3047'
);


-- None Mélodie

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, 'Mélodie', 'Mélodie', 'song', NULL, NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 100
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = 'Mélodie'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '4caced9a-1371-44d8-a681-95463ea750d5'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '4caced9a-1371-44d8-a681-95463ea750d5'
FROM pieces p
WHERE p.composer_id = 100 AND p.title = 'Mélodie' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '4caced9a-1371-44d8-a681-95463ea750d5'
);


-- None 발레 <Parade>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '발레 <Parade>', 'Parade', 'album', NULL, NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 100
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '발레 <Parade>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '65775acf-95f0-350c-ba5d-60d9386e463f'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '65775acf-95f0-350c-ba5d-60d9386e463f'
FROM pieces p
WHERE p.composer_id = 100 AND p.title = '발레 <Parade>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '65775acf-95f0-350c-ba5d-60d9386e463f'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:7cbbafc1-5342-383a-a6c7-05c87d026d3f', 1, NULL, 'Choral', 'Parade: Choral', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 100 AND p.title = '발레 <Parade>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:7cbbafc1-5342-383a-a6c7-05c87d026d3f'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:6dc67c66-f18e-3763-9c92-43e2819137b1', 2, NULL, 'Prélude du rideau rouge', 'Parade: Prélude du rideau rouge', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 100 AND p.title = '발레 <Parade>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:6dc67c66-f18e-3763-9c92-43e2819137b1'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:5b2b6fe2-bf38-39ec-b697-52348a1386bf', 3, NULL, 'Prestidigitateur chinois', 'Parade: I. Prestidigitateur chinois', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 100 AND p.title = '발레 <Parade>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:5b2b6fe2-bf38-39ec-b697-52348a1386bf'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:e3ed04bd-3f3f-34cd-8bf6-d328cda55cff', 4, NULL, 'Petite fille américaine', 'Parade: II. Petite fille américaine', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 100 AND p.title = '발레 <Parade>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:e3ed04bd-3f3f-34cd-8bf6-d328cda55cff'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:50566066-71e9-3e6f-b988-8e6b98c87d74', 5, NULL, 'Ragtime du paquebot', 'Parade: Ragtime du paquebot', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 100 AND p.title = '발레 <Parade>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:50566066-71e9-3e6f-b988-8e6b98c87d74'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:1ac1b32f-c5ae-3755-8545-bdc21a60f752', 6, NULL, 'Acrobates', 'Parade: III. Acrobates', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 100 AND p.title = '발레 <Parade>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:1ac1b32f-c5ae-3755-8545-bdc21a60f752'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:d8d72e49-6e30-320f-93ec-6fe32f48d364', 7, NULL, 'Final', 'Parade: Final', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 100 AND p.title = '발레 <Parade>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:d8d72e49-6e30-320f-93ec-6fe32f48d364'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:5fcf3423-84ee-39bd-9a92-76ddc5271076', 8, NULL, 'Suite au "Prélude du rideau rouge"', 'Parade: Suite au "Prélude du rideau rouge"', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 100 AND p.title = '발레 <Parade>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:5fcf3423-84ee-39bd-9a92-76ddc5271076'
);


-- None Petite ouverture à danser

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, 'Petite ouverture à danser', 'Petite ouverture à danser', 'song', NULL, NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 100
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = 'Petite ouverture à danser'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '1556044c-54f2-3a6d-b955-829529a7aa76'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '1556044c-54f2-3a6d-b955-829529a7aa76'
FROM pieces p
WHERE p.composer_id = 100 AND p.title = 'Petite ouverture à danser' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '1556044c-54f2-3a6d-b955-829529a7aa76'
);


-- None 오페레타 <Pousse l’amour>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '오페레타 <Pousse l’amour>', 'Pousse l’amour', 'album', NULL, NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 100
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '오페레타 <Pousse l’amour>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'c9cd3a53-d5cd-4846-8954-8be706984f4f'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'c9cd3a53-d5cd-4846-8954-8be706984f4f'
FROM pieces p
WHERE p.composer_id = 100 AND p.title = '오페레타 <Pousse l’amour>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'c9cd3a53-d5cd-4846-8954-8be706984f4f'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:f4a8c22e-d3e3-4a09-92ae-89d6d13e99de', 1, NULL, 'De Féraudy. Valse', 'De Féraudy. Valse', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 100 AND p.title = '오페레타 <Pousse l’amour>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:f4a8c22e-d3e3-4a09-92ae-89d6d13e99de'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:4ee3eceb-e1af-4173-9a3e-814d0ab9925d', 2, NULL, 'Le Champagne. Valse', 'Le Champagne. Valse', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 100 AND p.title = '오페레타 <Pousse l’amour>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:4ee3eceb-e1af-4173-9a3e-814d0ab9925d'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:48b63723-b3c4-446c-8b97-92e1b748ca61', 3, NULL, 'Chanson andalouse (de "Pousse l''amour")', 'Chanson andalouse (de "Pousse l''amour")', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 100 AND p.title = '오페레타 <Pousse l’amour>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:48b63723-b3c4-446c-8b97-92e1b748ca61'
);


-- None Première pensée Rose+Croix

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, 'Première pensée Rose+Croix', 'Première pensée Rose+Croix', 'song', NULL, NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 100
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = 'Première pensée Rose+Croix'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '60925744-fe91-37cc-8596-6e88a72a4135'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '60925744-fe91-37cc-8596-6e88a72a4135'
FROM pieces p
WHERE p.composer_id = 100 AND p.title = 'Première pensée Rose+Croix' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '60925744-fe91-37cc-8596-6e88a72a4135'
);


-- None Préludes flasques (pour un chien)

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, 'Préludes flasques (pour un chien)', 'Préludes flasques (pour un chien)', 'album', NULL, NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 100
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = 'Préludes flasques (pour un chien)'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'ffd906d2-2d14-46d6-be44-ae70ec5ecc24'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'ffd906d2-2d14-46d6-be44-ae70ec5ecc24'
FROM pieces p
WHERE p.composer_id = 100 AND p.title = 'Préludes flasques (pour un chien)' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'ffd906d2-2d14-46d6-be44-ae70ec5ecc24'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:c333efaa-a0f4-3f58-99ed-2779a46818a5', 1, 'I', 'Voix d''intérieur', 'Préludes flasques (pour un chien) : I. Voix d''intérieur', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 100 AND p.title = 'Préludes flasques (pour un chien)' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:c333efaa-a0f4-3f58-99ed-2779a46818a5'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:6ca3982b-0e0f-3cf9-a78c-6e2fafcbfb52', 2, 'II', 'Idylle cynique', 'Préludes flasques (pour un chien) : II. Idylle cynique', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 100 AND p.title = 'Préludes flasques (pour un chien)' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:6ca3982b-0e0f-3cf9-a78c-6e2fafcbfb52'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:2ee7643f-ed96-3526-9436-7fd980bac228', 3, 'III', 'Chanson canine', 'Préludes flasques (pour un chien) : III. Chanson canine', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 100 AND p.title = 'Préludes flasques (pour un chien)' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:2ee7643f-ed96-3526-9436-7fd980bac228'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:fa08b5c1-b843-3b12-8972-99e4d32a73eb', 4, 'IV', 'Avec camaraderie', 'Préludes flasques (pour un chien) : IV. Avec camaraderie', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 100 AND p.title = 'Préludes flasques (pour un chien)' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:fa08b5c1-b843-3b12-8972-99e4d32a73eb'
);


-- None Socrate

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, 'Socrate', 'Socrate', 'album', NULL, NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 100
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = 'Socrate'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'd2f964d2-76ef-496d-b10d-1bc0a4cd9237'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'd2f964d2-76ef-496d-b10d-1bc0a4cd9237'
FROM pieces p
WHERE p.composer_id = 100 AND p.title = 'Socrate' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'd2f964d2-76ef-496d-b10d-1bc0a4cd9237'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:46f81390-11dc-4bf5-a232-29b83a18955f', 1, 'I', 'Portrait de Socrate', 'Socrate: I. Portrait de Socrate', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 100 AND p.title = 'Socrate' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:46f81390-11dc-4bf5-a232-29b83a18955f'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:f708f365-77ee-434a-87b5-d7670ad3738e', 2, 'II', 'Bords de l’llissus', 'Socrate: II. Bords de l’llissus', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 100 AND p.title = 'Socrate' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:f708f365-77ee-434a-87b5-d7670ad3738e'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:5739e6a4-1220-4aa7-80d4-3c1fee7d00d4', 3, 'III', 'Mort de Socrate', 'Socrate: III. Mort de Socrate', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 100 AND p.title = 'Socrate' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:5739e6a4-1220-4aa7-80d4-3c1fee7d00d4'
);


-- None Tendrement

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, 'Tendrement', 'Tendrement', 'song', NULL, NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 100
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = 'Tendrement'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '092f06be-ae86-4374-99f9-0a4c5b932e96'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '092f06be-ae86-4374-99f9-0a4c5b932e96'
FROM pieces p
WHERE p.composer_id = 100 AND p.title = 'Tendrement' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '092f06be-ae86-4374-99f9-0a4c5b932e96'
);


-- None The Angora Ox

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, 'The Angora Ox', 'The Angora Ox', 'song', NULL, NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 100
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = 'The Angora Ox'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '829d9777-fe31-4348-a0c2-78e1f60726cd'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '829d9777-fe31-4348-a0c2-78e1f60726cd'
FROM pieces p
WHERE p.composer_id = 100 AND p.title = 'The Angora Ox' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '829d9777-fe31-4348-a0c2-78e1f60726cd'
);


-- None Trois morceaux en forme de poire

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, 'Trois morceaux en forme de poire', 'Trois morceaux en forme de poire', 'album', NULL, NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 100
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = 'Trois morceaux en forme de poire'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'ce576ab1-8415-4bdd-9859-266467201876'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'ce576ab1-8415-4bdd-9859-266467201876'
FROM pieces p
WHERE p.composer_id = 100 AND p.title = 'Trois morceaux en forme de poire' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'ce576ab1-8415-4bdd-9859-266467201876'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:8186cea3-be16-33f4-bcf1-9e2b0d0325b0', 1, NULL, 'Manière de commencement', 'Trois morceaux en forme de poire : Manière de commencement', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 100 AND p.title = 'Trois morceaux en forme de poire' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:8186cea3-be16-33f4-bcf1-9e2b0d0325b0'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:fb0d2c3e-3125-4939-94d3-125d63a223eb', 2, NULL, 'Prolongation du même', 'Trois morceaux en forme de poire : Prolongation du même', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 100 AND p.title = 'Trois morceaux en forme de poire' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:fb0d2c3e-3125-4939-94d3-125d63a223eb'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:25bbd24d-85c6-44fc-b5ed-bae2bcff5f2f', 3, NULL, 'Lentement', 'Trois morceaux en forme de poire : I. Lentement', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 100 AND p.title = 'Trois morceaux en forme de poire' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:25bbd24d-85c6-44fc-b5ed-bae2bcff5f2f'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:dfaaaa39-6981-379f-9614-5e85bf92326e', 4, NULL, 'Enlevé — De moitié — Premier temps', 'Trois morceaux en forme de poire : II. Enlevé — De moitié — Premier temps', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 100 AND p.title = 'Trois morceaux en forme de poire' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:dfaaaa39-6981-379f-9614-5e85bf92326e'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:47278f8c-33ea-3ad1-9a1b-a4a43b5c2670', 5, NULL, 'Brutal — Modéré — Au temps', 'Trois morceaux en forme de poire : III. Brutal — Modéré — Au temps', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 100 AND p.title = 'Trois morceaux en forme de poire' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:47278f8c-33ea-3ad1-9a1b-a4a43b5c2670'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:53d4e2a8-23fe-3a71-a35a-28fbfa2ac82a', 6, NULL, 'En plus', 'Trois morceaux en forme de poire : En plus', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 100 AND p.title = 'Trois morceaux en forme de poire' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:53d4e2a8-23fe-3a71-a35a-28fbfa2ac82a'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:81227229-097e-3566-b993-475c146d4d62', 7, NULL, 'Redite', 'Trois morceaux en forme de poire : Redite', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 100 AND p.title = 'Trois morceaux en forme de poire' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:81227229-097e-3566-b993-475c146d4d62'
);


-- None Trois mélodies

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, 'Trois mélodies', 'Trois mélodies', 'album', NULL, NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 100
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = 'Trois mélodies'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '2e58ceaa-3b02-429b-856b-79abb3447be4'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '2e58ceaa-3b02-429b-856b-79abb3447be4'
FROM pieces p
WHERE p.composer_id = 100 AND p.title = 'Trois mélodies' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '2e58ceaa-3b02-429b-856b-79abb3447be4'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:4082621d-f3e1-38a9-b298-f82bca1537f8', 1, NULL, 'Les Anges', 'Les Anges', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 100 AND p.title = 'Trois mélodies' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:4082621d-f3e1-38a9-b298-f82bca1537f8'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:8cb5d0c2-6507-4431-a0c9-3942c94f47ec', 2, NULL, 'Les Fleurs', 'Les Fleurs', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 100 AND p.title = 'Trois mélodies' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:8cb5d0c2-6507-4431-a0c9-3942c94f47ec'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:50073624-9a08-4bba-a9f3-041ed4c17ed9', 3, NULL, 'Sylvie, op. 20', 'Sylvie, op. 20', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 100 AND p.title = 'Trois mélodies' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:50073624-9a08-4bba-a9f3-041ed4c17ed9'
);


-- None Trois petites pièces montées

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, 'Trois petites pièces montées', 'Trois petites pièces montées', 'album', NULL, NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 100
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = 'Trois petites pièces montées'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'ed78bef4-e5a0-468a-a5df-6718c2f4519e'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'ed78bef4-e5a0-468a-a5df-6718c2f4519e'
FROM pieces p
WHERE p.composer_id = 100 AND p.title = 'Trois petites pièces montées' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'ed78bef4-e5a0-468a-a5df-6718c2f4519e'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:98bc8ad4-f70e-4c58-bfc4-3049f160563f', 1, 'I', 'De l''enfance de Pantagruel (Rêverie)', 'Trois petites pièces montées: I. De l''enfance de Pantagruel (Rêverie)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 100 AND p.title = 'Trois petites pièces montées' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:98bc8ad4-f70e-4c58-bfc4-3049f160563f'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:495c7b3c-1651-4f0e-ab01-322f9d4e9c4c', 2, 'II', 'Marche de Cocagne (Démarche)', 'Trois petites pièces montées: II. Marche de Cocagne (Démarche)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 100 AND p.title = 'Trois petites pièces montées' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:495c7b3c-1651-4f0e-ab01-322f9d4e9c4c'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:4f12be35-4f3b-4ff0-bae7-d66a667feb6d', 3, 'III', 'Jeux de Gargantua (Coin de polka)', 'Trois petites pièces montées: III. Jeux de Gargantua (Coin de polka)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 100 AND p.title = 'Trois petites pièces montées' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:4f12be35-4f3b-4ff0-bae7-d66a667feb6d'
);


-- Op. 19 엘레지

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '엘레지', 'Élégie, op. 19', 'song', 'Op. 19', NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 100
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '엘레지'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '863531bb-a474-3376-9370-27d41509a0dc'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '863531bb-a474-3376-9370-27d41509a0dc'
FROM pieces p
WHERE p.composer_id = 100 AND p.title = '엘레지' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '863531bb-a474-3376-9370-27d41509a0dc'
);


-- 카탈로그에 대응이 없는 seed 작품 80개를 목록에서 숨긴다(지우지 않음).
UPDATE pieces piece
SET piece.hidden_reason = 'catalog_unmatched'
WHERE piece.composer_id = 100 AND piece.origin = 'seed' AND piece.hidden_reason IS NULL
  AND piece.id IN (
    1831, 7590, 7599, 7635, 7662, 7693, 7695, 7699, 7729, 7746, 7801, 7813, 7839, 7903, 8072, 8084, 8182, 8228, 8267, 8326,
    8493, 8523, 8653, 8665, 8677, 8683, 8705, 8769, 8788, 8817, 8850, 8896, 8908, 8956, 8979, 8982, 9101, 9221, 9277, 9289,
    9292, 9327, 9334, 9336, 9420, 9483, 9497, 9518, 9559, 9583, 9645, 9703, 9721, 9751, 9962, 10010, 10031, 10071, 10105, 10196,
    10283, 10296, 10315, 10349, 10432, 10504, 10617, 10621, 10655, 10721, 10799, 10802, 10947, 11026, 11055, 11074, 11081, 11185, 11219, 11232
  )
  AND NOT EXISTS (SELECT 1 FROM performance_sectors sector WHERE sector.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM piece_parts linking WHERE linking.linked_piece_id = piece.id);
