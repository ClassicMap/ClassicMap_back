-- 슈토크하우젠 작품을 MusicBrainz 작품 구조로 다시 짠다(4차 자동). 작품 54개(묶음 14, 다악장 3, 낱곡 37),
-- 새 작품 2개, part 113개, 그 아래 39개.
-- seed 62개 중 52개를 작품·part 에 잇고, 8개를 숨기고, 2개는 그대로 둔다.
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

-- None 3x Refrain 2000, Nr. 11½

UPDATE pieces piece
SET piece.title = '3x Refrain 2000, Nr. 11½', piece.title_en = '3x Refrain 2000, Nr. 11½',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 2715 AND piece.composer_id = 108
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Adieu, Nr. 21

UPDATE pieces piece
SET piece.title = 'Adieu, Nr. 21', piece.title_en = 'Adieu, Nr. 21',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 2701 AND piece.composer_id = 108
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Amour, Nr. 44

UPDATE pieces piece
SET piece.title = 'Amour, Nr. 44', piece.title_en = 'Amour, Nr. 44',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 1607 AND piece.composer_id = 108
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'Sei wieder fröhlich', part.name_en = 'Amour: I. Sei wieder fröhlich',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 1607 AND p.composer_id = 108 AND part.part_key = 'musicbrainz:c9c9707d-1256-4e6d-9f81-5322b52ad0fd' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:c9c9707d-1256-4e6d-9f81-5322b52ad0fd', 1, 'I', 'Sei wieder fröhlich', 'Amour: I. Sei wieder fröhlich', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 1607 AND p.composer_id = 108
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:c9c9707d-1256-4e6d-9f81-5322b52ad0fd'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'Dein Engel wacht wieder über Dir', part.name_en = 'Amour: II. Dein Engel wacht wieder über Dir',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 1607 AND p.composer_id = 108 AND part.part_key = 'musicbrainz:6fc2fa54-8158-42b6-8dd6-dfb11ea0e199' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:6fc2fa54-8158-42b6-8dd6-dfb11ea0e199', 2, 'II', 'Dein Engel wacht wieder über Dir', 'Amour: II. Dein Engel wacht wieder über Dir', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 1607 AND p.composer_id = 108
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:6fc2fa54-8158-42b6-8dd6-dfb11ea0e199'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = 'Die Schmetterlinge spielen', part.name_en = 'Amour: III. Die Schmetterlinge spielen',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 1607 AND p.composer_id = 108 AND part.part_key = 'musicbrainz:d284d85c-4b7b-453f-b1ee-e1bf465e6e55' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:d284d85c-4b7b-453f-b1ee-e1bf465e6e55', 3, 'III', 'Die Schmetterlinge spielen', 'Amour: III. Die Schmetterlinge spielen', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 1607 AND p.composer_id = 108
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:d284d85c-4b7b-453f-b1ee-e1bf465e6e55'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = 'IV',
    part.name_ko = 'Ein Vöglein singt an Deinem Fenster', part.name_en = 'Amour: IV. Ein Vöglein singt an Deinem Fenster',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 1607 AND p.composer_id = 108 AND part.part_key = 'musicbrainz:8d86cecd-b8c5-4696-92df-f91ee2cd53bf' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:8d86cecd-b8c5-4696-92df-f91ee2cd53bf', 4, 'IV', 'Ein Vöglein singt an Deinem Fenster', 'Amour: IV. Ein Vöglein singt an Deinem Fenster', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 1607 AND p.composer_id = 108
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:8d86cecd-b8c5-4696-92df-f91ee2cd53bf'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 5, part.movement_number = 'V',
    part.name_ko = 'Vier Steine weisen Dir den Weg', part.name_en = 'Amour: V. Vier Steine weisen Dir den Weg',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 1607 AND p.composer_id = 108 AND part.part_key = 'musicbrainz:7a974240-65f8-4b53-845e-15a213a9c18f' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:7a974240-65f8-4b53-845e-15a213a9c18f', 5, 'V', 'Vier Steine weisen Dir den Weg', 'Amour: V. Vier Steine weisen Dir den Weg', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 1607 AND p.composer_id = 108
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:7a974240-65f8-4b53-845e-15a213a9c18f'
);


-- None Aus den sieben Tagen, Nr. 26

UPDATE pieces piece
SET piece.title = 'Aus den sieben Tagen, Nr. 26', piece.title_en = 'Aus den sieben Tagen, Nr. 26',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 1436 AND piece.composer_id = 108
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'Verbindung', part.name_en = 'Aus den sieben Tagen, Nr. 26: 3. Verbindung',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 1436 AND p.composer_id = 108 AND part.part_key = 'musicbrainz:04aec6ee-aeef-4995-a913-e61cd887edce' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:04aec6ee-aeef-4995-a913-e61cd887edce', 1, NULL, 'Verbindung', 'Aus den sieben Tagen, Nr. 26: 3. Verbindung', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 1436 AND p.composer_id = 108
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:04aec6ee-aeef-4995-a913-e61cd887edce'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'Aufwärts', part.name_en = 'Aus den sieben Tagen, Nr. 26: 7. Aufwärts',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 1436 AND p.composer_id = 108 AND part.part_key = 'musicbrainz:0e6d36a7-9171-48f2-ad5a-a3af48885432' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:0e6d36a7-9171-48f2-ad5a-a3af48885432', 2, NULL, 'Aufwärts', 'Aus den sieben Tagen, Nr. 26: 7. Aufwärts', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 1436 AND p.composer_id = 108
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:0e6d36a7-9171-48f2-ad5a-a3af48885432'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = NULL,
    part.name_ko = 'Setz die Segel zur Sonne', part.name_en = 'Aus den sieben Tagen, Nr. 26: 10. Setz die Segel zur Sonne',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 1436 AND p.composer_id = 108 AND part.part_key = 'musicbrainz:1b417e1b-b077-4ca0-9c5f-cc465a260a5d' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:1b417e1b-b077-4ca0-9c5f-cc465a260a5d', 3, NULL, 'Setz die Segel zur Sonne', 'Aus den sieben Tagen, Nr. 26: 10. Setz die Segel zur Sonne', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 1436 AND p.composer_id = 108
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:1b417e1b-b077-4ca0-9c5f-cc465a260a5d'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = NULL,
    part.name_ko = 'Nachtmusik', part.name_en = 'Aus den sieben Tagen, Nr. 26: 5. Nachtmusik',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 1436 AND p.composer_id = 108 AND part.part_key = 'musicbrainz:3bd94683-1722-49f5-951c-d71feb18335b' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:3bd94683-1722-49f5-951c-d71feb18335b', 4, NULL, 'Nachtmusik', 'Aus den sieben Tagen, Nr. 26: 5. Nachtmusik', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 1436 AND p.composer_id = 108
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:3bd94683-1722-49f5-951c-d71feb18335b'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 5, part.movement_number = NULL,
    part.name_ko = 'Treffpunkt', part.name_en = 'Aus den sieben Tagen, Nr. 26: 4. Treffpunkt',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 1436 AND p.composer_id = 108 AND part.part_key = 'musicbrainz:6bbf1939-7eb6-4c4f-ad84-f537c0d2d8df' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:6bbf1939-7eb6-4c4f-ad84-f537c0d2d8df', 5, NULL, 'Treffpunkt', 'Aus den sieben Tagen, Nr. 26: 4. Treffpunkt', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 1436 AND p.composer_id = 108
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:6bbf1939-7eb6-4c4f-ad84-f537c0d2d8df'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 6, part.movement_number = NULL,
    part.name_ko = 'Intensität', part.name_en = 'Aus den sieben Tagen, Nr. 26: 9. Intensität',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 1436 AND p.composer_id = 108 AND part.part_key = 'musicbrainz:8690d781-064c-45c2-9621-f79684d0a788' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:8690d781-064c-45c2-9621-f79684d0a788', 6, NULL, 'Intensität', 'Aus den sieben Tagen, Nr. 26: 9. Intensität', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 1436 AND p.composer_id = 108
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:8690d781-064c-45c2-9621-f79684d0a788'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 7, part.movement_number = NULL,
    part.name_ko = 'Unbegrenzt', part.name_en = 'Aus den sieben Tagen, Nr. 26: 2. Unbegrenzt',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 1436 AND p.composer_id = 108 AND part.part_key = 'musicbrainz:f390d6d7-672e-4f2f-8d8c-774262e3a9f2' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:f390d6d7-672e-4f2f-8d8c-774262e3a9f2', 7, NULL, 'Unbegrenzt', 'Aus den sieben Tagen, Nr. 26: 2. Unbegrenzt', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 1436 AND p.composer_id = 108
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:f390d6d7-672e-4f2f-8d8c-774262e3a9f2'
);


-- None Carré, Nr. 10

UPDATE pieces piece
SET piece.title = 'Carré, Nr. 10', piece.title_en = 'Carré, Nr. 10',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 2144 AND piece.composer_id = 108
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Choral, Nr. 1/9

UPDATE pieces piece
SET piece.title = 'Choral, Nr. 1/9', piece.title_en = 'Choral, Nr. 1/9',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 1330 AND piece.composer_id = 108
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Chöre für Doris, Nr. 1/11

UPDATE pieces piece
SET piece.title = 'Chöre für Doris, Nr. 1/11', piece.title_en = 'Chöre für Doris, Nr. 1/11',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 2335 AND piece.composer_id = 108
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'Die Nachtigall', part.name_en = 'Chöre für Doris, Nr. 1/11: 1. Die Nachtigall',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 2335 AND p.composer_id = 108 AND part.part_key = 'musicbrainz:3d2a339a-d4c8-43b0-ab23-23d619b3f6b9' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:3d2a339a-d4c8-43b0-ab23-23d619b3f6b9', 1, NULL, 'Die Nachtigall', 'Chöre für Doris, Nr. 1/11: 1. Die Nachtigall', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 2335 AND p.composer_id = 108
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:3d2a339a-d4c8-43b0-ab23-23d619b3f6b9'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'Armer junger Hirt', part.name_en = 'Chöre für Doris, Nr. 1/11: 2. Armer junger Hirt',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 2335 AND p.composer_id = 108 AND part.part_key = 'musicbrainz:527d7d10-7ceb-41ec-a5ff-a61cd4ea82ea' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:527d7d10-7ceb-41ec-a5ff-a61cd4ea82ea', 2, NULL, 'Armer junger Hirt', 'Chöre für Doris, Nr. 1/11: 2. Armer junger Hirt', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 2335 AND p.composer_id = 108
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:527d7d10-7ceb-41ec-a5ff-a61cd4ea82ea'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = NULL,
    part.name_ko = 'Agnus Dei', part.name_en = 'Chöre für Doris, Nr. 1/11: 3. Agnus Dei',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 2335 AND p.composer_id = 108 AND part.part_key = 'musicbrainz:f06bf781-7cea-4486-8941-102934e2cb73' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:f06bf781-7cea-4486-8941-102934e2cb73', 3, NULL, 'Agnus Dei', 'Chöre für Doris, Nr. 1/11: 3. Agnus Dei', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 2335 AND p.composer_id = 108
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:f06bf781-7cea-4486-8941-102934e2cb73'
);


-- None Drei Lieder, Nr. 1/10

UPDATE pieces piece
SET piece.title = 'Drei Lieder, Nr. 1/10', piece.title_en = 'Drei Lieder, Nr. 1/10',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 2104 AND piece.composer_id = 108
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'Der Rebell', part.name_en = 'Drei Lieder, Nr. 1/10: 1. Der Rebell',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 2104 AND p.composer_id = 108 AND part.part_key = 'musicbrainz:63310033-f72f-4d65-8099-eddb2b22ab90' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:63310033-f72f-4d65-8099-eddb2b22ab90', 1, NULL, 'Der Rebell', 'Drei Lieder, Nr. 1/10: 1. Der Rebell', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 2104 AND p.composer_id = 108
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:63310033-f72f-4d65-8099-eddb2b22ab90'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'Frei', part.name_en = 'Drei Lieder, Nr. 1/10: 2. Frei',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 2104 AND p.composer_id = 108 AND part.part_key = 'musicbrainz:72b79dc6-b4df-42bc-9d03-658c2fedd110' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:72b79dc6-b4df-42bc-9d03-658c2fedd110', 2, NULL, 'Frei', 'Drei Lieder, Nr. 1/10: 2. Frei', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 2104 AND p.composer_id = 108
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:72b79dc6-b4df-42bc-9d03-658c2fedd110'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = NULL,
    part.name_ko = 'Der Saitenmann', part.name_en = 'Drei Lieder, Nr. 1/10: 3. Der Saitenmann',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 2104 AND p.composer_id = 108 AND part.part_key = 'musicbrainz:a4767fe2-777f-4302-add0-eeca97b9a8aa' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:a4767fe2-777f-4302-add0-eeca97b9a8aa', 3, NULL, 'Der Saitenmann', 'Drei Lieder, Nr. 1/10: 3. Der Saitenmann', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 2104 AND p.composer_id = 108
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:a4767fe2-777f-4302-add0-eeca97b9a8aa'
);


-- None Für kommende Zeiten, Nr. 33

UPDATE pieces piece
SET piece.title = 'Für kommende Zeiten, Nr. 33', piece.title_en = 'Für kommende Zeiten, Nr. 33',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 1324 AND piece.composer_id = 108
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'Vorahnung', part.name_en = 'Für kommende Zeiten: Vorahnung',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 1324 AND p.composer_id = 108 AND part.part_key = 'musicbrainz:1e423a85-0525-4804-b7b3-96ed47a7487f' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:1e423a85-0525-4804-b7b3-96ed47a7487f', 1, NULL, 'Vorahnung', 'Für kommende Zeiten: Vorahnung', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 1324 AND p.composer_id = 108
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:1e423a85-0525-4804-b7b3-96ed47a7487f'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'Wellen', part.name_en = 'Für kommende Zeiten: Wellen',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 1324 AND p.composer_id = 108 AND part.part_key = 'musicbrainz:2469947a-90d0-478a-a924-6301436996fc' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:2469947a-90d0-478a-a924-6301436996fc', 2, NULL, 'Wellen', 'Für kommende Zeiten: Wellen', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 1324 AND p.composer_id = 108
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:2469947a-90d0-478a-a924-6301436996fc'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = NULL,
    part.name_ko = 'Anhalt', part.name_en = 'Für kommende Zeiten: Anhalt',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 1324 AND p.composer_id = 108 AND part.part_key = 'musicbrainz:401b0d85-0858-4267-94bb-dae1529d74a3' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:401b0d85-0858-4267-94bb-dae1529d74a3', 3, NULL, 'Anhalt', 'Für kommende Zeiten: Anhalt', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 1324 AND p.composer_id = 108
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:401b0d85-0858-4267-94bb-dae1529d74a3'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = NULL,
    part.name_ko = 'Verkürzung', part.name_en = 'Für kommende Zeiten: Verkürzung',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 1324 AND p.composer_id = 108 AND part.part_key = 'musicbrainz:4ef51f27-c868-4004-bd63-38f2252319f7' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:4ef51f27-c868-4004-bd63-38f2252319f7', 4, NULL, 'Verkürzung', 'Für kommende Zeiten: Verkürzung', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 1324 AND p.composer_id = 108
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:4ef51f27-c868-4004-bd63-38f2252319f7'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 5, part.movement_number = NULL,
    part.name_ko = 'Wach', part.name_en = 'Für kommende Zeiten: Wach',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 1324 AND p.composer_id = 108 AND part.part_key = 'musicbrainz:6e4c7621-5edc-42a3-9e8c-1c808c5d9947' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:6e4c7621-5edc-42a3-9e8c-1c808c5d9947', 5, NULL, 'Wach', 'Für kommende Zeiten: Wach', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 1324 AND p.composer_id = 108
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:6e4c7621-5edc-42a3-9e8c-1c808c5d9947'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 6, part.movement_number = NULL,
    part.name_ko = 'Innerhalb', part.name_en = 'Für kommende Zeiten: Innerhalb',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 1324 AND p.composer_id = 108 AND part.part_key = 'musicbrainz:cd30063f-3f5b-40a1-a6f7-0d5910ea834b' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:cd30063f-3f5b-40a1-a6f7-0d5910ea834b', 6, NULL, 'Innerhalb', 'Für kommende Zeiten: Innerhalb', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 1324 AND p.composer_id = 108
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:cd30063f-3f5b-40a1-a6f7-0d5910ea834b'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 7, part.movement_number = NULL,
    part.name_ko = 'Japan', part.name_en = 'Für kommende Zeiten: Japan',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 1324 AND p.composer_id = 108 AND part.part_key = 'musicbrainz:e0ab8306-3a76-4e8f-8659-e1873205009b' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:e0ab8306-3a76-4e8f-8659-e1873205009b', 7, NULL, 'Japan', 'Für kommende Zeiten: Japan', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 1324 AND p.composer_id = 108
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:e0ab8306-3a76-4e8f-8659-e1873205009b'
);


-- None Gesang der Jünglinge, Nr. 8

UPDATE pieces piece
SET piece.title = 'Gesang der Jünglinge, Nr. 8', piece.title_en = 'Gesang der Jünglinge, Nr. 8',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 1256 AND piece.composer_id = 108
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Gruppen, Nr. 6

UPDATE pieces piece
SET piece.title = 'Gruppen, Nr. 6', piece.title_en = 'Gruppen, Nr. 6',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 2746 AND piece.composer_id = 108
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Harlekin

UPDATE pieces piece
SET piece.title = 'Harlekin', piece.title_en = 'Harlekin',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 1520 AND piece.composer_id = 108
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Hymnen, Nr. 22

UPDATE pieces piece
SET piece.title = 'Hymnen, Nr. 22', piece.title_en = 'Hymnen, Nr. 22',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 783 AND piece.composer_id = 108
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'Region I', part.name_en = 'Hymnen, Nr. 22, Region I',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 783 AND p.composer_id = 108 AND part.part_key = 'musicbrainz:c2ca1b73-8015-466f-9c94-e32de5934d2b' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:c2ca1b73-8015-466f-9c94-e32de5934d2b', 1, NULL, 'Region I', 'Hymnen, Nr. 22, Region I', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 783 AND p.composer_id = 108
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:c2ca1b73-8015-466f-9c94-e32de5934d2b'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'Region II', part.name_en = 'Hymnen, Nr. 22, Region II',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 783 AND p.composer_id = 108 AND part.part_key = 'musicbrainz:bf321f35-ee64-4eb8-b2ed-0fa40e89cff1' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:bf321f35-ee64-4eb8-b2ed-0fa40e89cff1', 2, NULL, 'Region II', 'Hymnen, Nr. 22, Region II', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 783 AND p.composer_id = 108
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:bf321f35-ee64-4eb8-b2ed-0fa40e89cff1'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = NULL,
    part.name_ko = 'Region III', part.name_en = 'Hymnen, Nr. 22, Region III',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 783 AND p.composer_id = 108 AND part.part_key = 'musicbrainz:18d3f1a6-9b02-4bdd-b1d1-8263d943e659' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:18d3f1a6-9b02-4bdd-b1d1-8263d943e659', 3, NULL, 'Region III', 'Hymnen, Nr. 22, Region III', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 783 AND p.composer_id = 108
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:18d3f1a6-9b02-4bdd-b1d1-8263d943e659'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = NULL,
    part.name_ko = 'Region IV', part.name_en = 'Hymnen, Nr. 22, Region IV',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 783 AND p.composer_id = 108 AND part.part_key = 'musicbrainz:65d7cb71-fa1a-4f25-bdb6-22e1ba4fe7db' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:65d7cb71-fa1a-4f25-bdb6-22e1ba4fe7db', 4, NULL, 'Region IV', 'Hymnen, Nr. 22, Region IV', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 783 AND p.composer_id = 108
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:65d7cb71-fa1a-4f25-bdb6-22e1ba4fe7db'
);


-- None In Freundschaft, Werk 46

UPDATE pieces piece
SET piece.title = 'In Freundschaft, Werk 46', piece.title_en = 'In Freundschaft, Werk 46',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 1970 AND piece.composer_id = 108
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None In Freundschaft, Werk 46 10/11

UPDATE pieces piece
SET piece.title = 'In Freundschaft, Werk 46 10/11', piece.title_en = 'In Freundschaft, Werk 46 10/11',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 2099 AND piece.composer_id = 108
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None In Freundschaft, Werk 46 12/13

UPDATE pieces piece
SET piece.title = 'In Freundschaft, Werk 46 12/13', piece.title_en = 'In Freundschaft, Werk 46 12/13',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 2114 AND piece.composer_id = 108
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None In Freundschaft, Werk 46 3/4

UPDATE pieces piece
SET piece.title = 'In Freundschaft, Werk 46 3/4', piece.title_en = 'In Freundschaft, Werk 46 3/4',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 2218 AND piece.composer_id = 108
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None In Freundschaft, Werk Nr. 46 9/10

UPDATE pieces piece
SET piece.title = 'In Freundschaft, Werk Nr. 46 9/10', piece.title_en = 'In Freundschaft, Werk Nr. 46 9/10',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 1291 AND piece.composer_id = 108
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Jubiläum, Nr. 45

UPDATE pieces piece
SET piece.title = 'Jubiläum, Nr. 45', piece.title_en = 'Jubiläum, Nr. 45',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 2199 AND piece.composer_id = 108
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Klang

UPDATE pieces piece
SET piece.title = 'Klang', piece.title_en = 'Klang',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 869 AND piece.composer_id = 108
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'Stunde – Cosmic Pulses, Nr. 93', part.name_en = 'Klang: 13. Stunde – Cosmic Pulses, Nr. 93',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 869 AND p.composer_id = 108 AND part.part_key = 'musicbrainz:586715d5-a4ad-4888-972c-fb45b78672b3' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:586715d5-a4ad-4888-972c-fb45b78672b3', 1, NULL, 'Stunde – Cosmic Pulses, Nr. 93', 'Klang: 13. Stunde – Cosmic Pulses, Nr. 93', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 869 AND p.composer_id = 108
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:586715d5-a4ad-4888-972c-fb45b78672b3'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'Stunde – Freude', part.name_en = 'Klang: 2. Stunde – Freude',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 869 AND p.composer_id = 108 AND part.part_key = 'musicbrainz:6d4e0e99-237e-4dcc-a28d-0be3b9129e82' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:6d4e0e99-237e-4dcc-a28d-0be3b9129e82', 2, NULL, 'Stunde – Freude', 'Klang: 2. Stunde – Freude', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 869 AND p.composer_id = 108
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:6d4e0e99-237e-4dcc-a28d-0be3b9129e82'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = NULL,
    part.name_ko = 'Stunde – Harmonien', part.name_en = 'Klang: 5. Stunde – Harmonien',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 869 AND p.composer_id = 108 AND part.part_key = 'musicbrainz:aac24f94-9467-4f3f-80ab-cfd91af699b7' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:aac24f94-9467-4f3f-80ab-cfd91af699b7', 3, NULL, 'Stunde – Harmonien', 'Klang: 5. Stunde – Harmonien', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 869 AND p.composer_id = 108
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:aac24f94-9467-4f3f-80ab-cfd91af699b7'
);


-- None Klavierstücke

UPDATE pieces piece
SET piece.title = 'Klavierstücke', piece.title_en = 'Klavierstücke',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 1925 AND piece.composer_id = 108
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'Klavierstücke I-IV, Nr. 2', part.name_en = 'Klavierstücke I-IV, Nr. 2',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 1925 AND p.composer_id = 108 AND part.part_key = 'musicbrainz:80149c19-ffe9-4743-b691-fbef0a56adca' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:80149c19-ffe9-4743-b691-fbef0a56adca', 1, NULL, 'Klavierstücke I-IV, Nr. 2', 'Klavierstücke I-IV, Nr. 2', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 1925 AND p.composer_id = 108
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:80149c19-ffe9-4743-b691-fbef0a56adca'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:80149c19-ffe9-4743-b691-fbef0a56adca'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'Klavierstück I', part.name_en = 'Klavierstück I',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 1925 AND p.composer_id = 108 AND part.part_key = 'musicbrainz:7999fd14-c35f-4731-8eae-e0a436b4e6d6' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:7999fd14-c35f-4731-8eae-e0a436b4e6d6', 1, NULL, 'Klavierstück I', 'Klavierstück I', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:80149c19-ffe9-4743-b691-fbef0a56adca'
WHERE p.id = 1925 AND p.composer_id = 108
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:7999fd14-c35f-4731-8eae-e0a436b4e6d6'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:80149c19-ffe9-4743-b691-fbef0a56adca'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'Klavierstück II', part.name_en = 'Klavierstück II',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 1925 AND p.composer_id = 108 AND part.part_key = 'musicbrainz:12031094-3a72-4182-aaba-af3874da8053' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:12031094-3a72-4182-aaba-af3874da8053', 2, NULL, 'Klavierstück II', 'Klavierstück II', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:80149c19-ffe9-4743-b691-fbef0a56adca'
WHERE p.id = 1925 AND p.composer_id = 108
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:12031094-3a72-4182-aaba-af3874da8053'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:80149c19-ffe9-4743-b691-fbef0a56adca'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = NULL,
    part.name_ko = 'Klavierstück III', part.name_en = 'Klavierstück III',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 1925 AND p.composer_id = 108 AND part.part_key = 'musicbrainz:5a9a1e5b-f20a-4d2c-868e-93a1134ee4fb' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:5a9a1e5b-f20a-4d2c-868e-93a1134ee4fb', 3, NULL, 'Klavierstück III', 'Klavierstück III', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:80149c19-ffe9-4743-b691-fbef0a56adca'
WHERE p.id = 1925 AND p.composer_id = 108
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:5a9a1e5b-f20a-4d2c-868e-93a1134ee4fb'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:80149c19-ffe9-4743-b691-fbef0a56adca'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = NULL,
    part.name_ko = 'Klavierstück IV', part.name_en = 'Klavierstück IV',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 1925 AND p.composer_id = 108 AND part.part_key = 'musicbrainz:7328fa45-2e65-4c55-92bc-b2c44cd47c88' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:7328fa45-2e65-4c55-92bc-b2c44cd47c88', 4, NULL, 'Klavierstück IV', 'Klavierstück IV', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:80149c19-ffe9-4743-b691-fbef0a56adca'
WHERE p.id = 1925 AND p.composer_id = 108
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:7328fa45-2e65-4c55-92bc-b2c44cd47c88'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'Klavierstücke V-X, Nr. 4', part.name_en = 'Klavierstücke V-X, Nr. 4',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 1925 AND p.composer_id = 108 AND part.part_key = 'musicbrainz:a5b63a56-4d10-43b9-a634-f4bcb5da4396' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:a5b63a56-4d10-43b9-a634-f4bcb5da4396', 2, NULL, 'Klavierstücke V-X, Nr. 4', 'Klavierstücke V-X, Nr. 4', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 1925 AND p.composer_id = 108
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:a5b63a56-4d10-43b9-a634-f4bcb5da4396'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:a5b63a56-4d10-43b9-a634-f4bcb5da4396'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'Klavierstück V', part.name_en = 'Klavierstück V',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 1925 AND p.composer_id = 108 AND part.part_key = 'musicbrainz:db03652c-67b8-4bf1-8e6f-d34d2eb9902d' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:db03652c-67b8-4bf1-8e6f-d34d2eb9902d', 1, NULL, 'Klavierstück V', 'Klavierstück V', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:a5b63a56-4d10-43b9-a634-f4bcb5da4396'
WHERE p.id = 1925 AND p.composer_id = 108
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:db03652c-67b8-4bf1-8e6f-d34d2eb9902d'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:a5b63a56-4d10-43b9-a634-f4bcb5da4396'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'Klavierstück VI', part.name_en = 'Klavierstück VI',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 1925 AND p.composer_id = 108 AND part.part_key = 'musicbrainz:d1ef6b67-9bdc-4b23-ba34-4decdea26e16' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:d1ef6b67-9bdc-4b23-ba34-4decdea26e16', 2, NULL, 'Klavierstück VI', 'Klavierstück VI', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:a5b63a56-4d10-43b9-a634-f4bcb5da4396'
WHERE p.id = 1925 AND p.composer_id = 108
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:d1ef6b67-9bdc-4b23-ba34-4decdea26e16'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:a5b63a56-4d10-43b9-a634-f4bcb5da4396'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = NULL,
    part.name_ko = 'Klavierstück VII', part.name_en = 'Klavierstück VII',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 1925 AND p.composer_id = 108 AND part.part_key = 'musicbrainz:a62f9570-1818-44f4-b4cd-b6980a0f03f9' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:a62f9570-1818-44f4-b4cd-b6980a0f03f9', 3, NULL, 'Klavierstück VII', 'Klavierstück VII', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:a5b63a56-4d10-43b9-a634-f4bcb5da4396'
WHERE p.id = 1925 AND p.composer_id = 108
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:a62f9570-1818-44f4-b4cd-b6980a0f03f9'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:a5b63a56-4d10-43b9-a634-f4bcb5da4396'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = NULL,
    part.name_ko = 'Klavierstück VIII', part.name_en = 'Klavierstück VIII',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 1925 AND p.composer_id = 108 AND part.part_key = 'musicbrainz:f1357eb6-c1ae-4a9a-bbba-e5a8244900fe' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:f1357eb6-c1ae-4a9a-bbba-e5a8244900fe', 4, NULL, 'Klavierstück VIII', 'Klavierstück VIII', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:a5b63a56-4d10-43b9-a634-f4bcb5da4396'
WHERE p.id = 1925 AND p.composer_id = 108
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:f1357eb6-c1ae-4a9a-bbba-e5a8244900fe'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:a5b63a56-4d10-43b9-a634-f4bcb5da4396'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 5, part.movement_number = NULL,
    part.name_ko = 'Klavierstück IX', part.name_en = 'Klavierstück IX',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 1925 AND p.composer_id = 108 AND part.part_key = 'musicbrainz:73095848-8dfd-4d2f-8e96-ed593d6f3903' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:73095848-8dfd-4d2f-8e96-ed593d6f3903', 5, NULL, 'Klavierstück IX', 'Klavierstück IX', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:a5b63a56-4d10-43b9-a634-f4bcb5da4396'
WHERE p.id = 1925 AND p.composer_id = 108
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:73095848-8dfd-4d2f-8e96-ed593d6f3903'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:a5b63a56-4d10-43b9-a634-f4bcb5da4396'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 6, part.movement_number = NULL,
    part.name_ko = 'Klavierstück X', part.name_en = 'Klavierstück X',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 1925 AND p.composer_id = 108 AND part.part_key = 'musicbrainz:2a161140-bdb4-4d1f-b2c3-57c077544b7a' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:2a161140-bdb4-4d1f-b2c3-57c077544b7a', 6, NULL, 'Klavierstück X', 'Klavierstück X', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:a5b63a56-4d10-43b9-a634-f4bcb5da4396'
WHERE p.id = 1925 AND p.composer_id = 108
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:2a161140-bdb4-4d1f-b2c3-57c077544b7a'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = NULL,
    part.name_ko = 'Klavierstück XI, Nr. 7', part.name_en = 'Klavierstück XI, Nr. 7',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 1925 AND p.composer_id = 108 AND part.part_key = 'musicbrainz:4b7ebf1a-ff24-4f47-980d-b4fd1a4ad148' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:4b7ebf1a-ff24-4f47-980d-b4fd1a4ad148', 3, NULL, 'Klavierstück XI, Nr. 7', 'Klavierstück XI, Nr. 7', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 1925 AND p.composer_id = 108
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:4b7ebf1a-ff24-4f47-980d-b4fd1a4ad148'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = NULL,
    part.name_ko = 'Klavierstück XII', part.name_en = 'Klavierstück XII',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 1925 AND p.composer_id = 108 AND part.part_key = 'musicbrainz:53f307f8-096a-477d-aa53-59999abad06a' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:53f307f8-096a-477d-aa53-59999abad06a', 4, NULL, 'Klavierstück XII', 'Klavierstück XII', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 1925 AND p.composer_id = 108
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:53f307f8-096a-477d-aa53-59999abad06a'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 5, part.movement_number = NULL,
    part.name_ko = 'Klavierstück XIII', part.name_en = 'Klavierstück XIII',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 1925 AND p.composer_id = 108 AND part.part_key = 'musicbrainz:e1a3d276-dbc5-458d-bc7d-49f8cfcc6645' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:e1a3d276-dbc5-458d-bc7d-49f8cfcc6645', 5, NULL, 'Klavierstück XIII', 'Klavierstück XIII', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 1925 AND p.composer_id = 108
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:e1a3d276-dbc5-458d-bc7d-49f8cfcc6645'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 6, part.movement_number = NULL,
    part.name_ko = 'Klavierstück XIV', part.name_en = 'Klavierstück XIV',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 1925 AND p.composer_id = 108 AND part.part_key = 'musicbrainz:4b4f8621-979b-4645-ae73-7393b3cf8c94' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:4b4f8621-979b-4645-ae73-7393b3cf8c94', 6, NULL, 'Klavierstück XIV', 'Klavierstück XIV', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 1925 AND p.composer_id = 108
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:4b4f8621-979b-4645-ae73-7393b3cf8c94'
);


-- None Kontakte, Nr. 12

UPDATE pieces piece
SET piece.title = 'Kontakte, Nr. 12', piece.title_en = 'Kontakte, Nr. 12',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 1148 AND piece.composer_id = 108
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'Struktur I', part.name_en = 'Kontakte: Struktur I',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 1148 AND p.composer_id = 108 AND part.part_key = 'musicbrainz:e1477235-a0e6-3613-be63-d20f41856dc1' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:e1477235-a0e6-3613-be63-d20f41856dc1', 1, NULL, 'Struktur I', 'Kontakte: Struktur I', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 1148 AND p.composer_id = 108
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:e1477235-a0e6-3613-be63-d20f41856dc1'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'Struktur II', part.name_en = 'Kontakte: Struktur II',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 1148 AND p.composer_id = 108 AND part.part_key = 'musicbrainz:c8acfc30-c0de-3ca5-877d-dc3c16c567ba' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:c8acfc30-c0de-3ca5-877d-dc3c16c567ba', 2, NULL, 'Struktur II', 'Kontakte: Struktur II', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 1148 AND p.composer_id = 108
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:c8acfc30-c0de-3ca5-877d-dc3c16c567ba'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = NULL,
    part.name_ko = 'Struktur III', part.name_en = 'Kontakte: Struktur III',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 1148 AND p.composer_id = 108 AND part.part_key = 'musicbrainz:ef4dab16-b271-3939-9580-db635fb11456' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:ef4dab16-b271-3939-9580-db635fb11456', 3, NULL, 'Struktur III', 'Kontakte: Struktur III', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 1148 AND p.composer_id = 108
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:ef4dab16-b271-3939-9580-db635fb11456'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = NULL,
    part.name_ko = 'Struktur IV', part.name_en = 'Kontakte: Struktur IV',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 1148 AND p.composer_id = 108 AND part.part_key = 'musicbrainz:27592fc7-d11c-3765-aacb-abb88e834ab7' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:27592fc7-d11c-3765-aacb-abb88e834ab7', 4, NULL, 'Struktur IV', 'Kontakte: Struktur IV', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 1148 AND p.composer_id = 108
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:27592fc7-d11c-3765-aacb-abb88e834ab7'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 5, part.movement_number = NULL,
    part.name_ko = 'Struktur V', part.name_en = 'Kontakte: Struktur V',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 1148 AND p.composer_id = 108 AND part.part_key = 'musicbrainz:cc8e369c-0fee-3343-a2b6-b669453ee2ed' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:cc8e369c-0fee-3343-a2b6-b669453ee2ed', 5, NULL, 'Struktur V', 'Kontakte: Struktur V', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 1148 AND p.composer_id = 108
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:cc8e369c-0fee-3343-a2b6-b669453ee2ed'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 6, part.movement_number = NULL,
    part.name_ko = 'Struktur VI', part.name_en = 'Kontakte: Struktur VI',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 1148 AND p.composer_id = 108 AND part.part_key = 'musicbrainz:99fc835a-7e75-30a2-a65b-0478a121430c' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:99fc835a-7e75-30a2-a65b-0478a121430c', 6, NULL, 'Struktur VI', 'Kontakte: Struktur VI', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 1148 AND p.composer_id = 108
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:99fc835a-7e75-30a2-a65b-0478a121430c'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 7, part.movement_number = NULL,
    part.name_ko = 'Struktur VII', part.name_en = 'Kontakte: Struktur VII',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 1148 AND p.composer_id = 108 AND part.part_key = 'musicbrainz:ae65c379-a23a-39e6-8606-905c6b9c3e92' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:ae65c379-a23a-39e6-8606-905c6b9c3e92', 7, NULL, 'Struktur VII', 'Kontakte: Struktur VII', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 1148 AND p.composer_id = 108
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:ae65c379-a23a-39e6-8606-905c6b9c3e92'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 8, part.movement_number = NULL,
    part.name_ko = 'Struktur VIII', part.name_en = 'Kontakte: Struktur VIII',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 1148 AND p.composer_id = 108 AND part.part_key = 'musicbrainz:8a630488-b05f-3fe0-86d1-20aa110f19ee' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:8a630488-b05f-3fe0-86d1-20aa110f19ee', 8, NULL, 'Struktur VIII', 'Kontakte: Struktur VIII', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 1148 AND p.composer_id = 108
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:8a630488-b05f-3fe0-86d1-20aa110f19ee'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 9, part.movement_number = NULL,
    part.name_ko = 'Struktur IX', part.name_en = 'Kontakte: Struktur IX',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 1148 AND p.composer_id = 108 AND part.part_key = 'musicbrainz:9f601674-c8af-3731-989c-5b952aef41d2' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:9f601674-c8af-3731-989c-5b952aef41d2', 9, NULL, 'Struktur IX', 'Kontakte: Struktur IX', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 1148 AND p.composer_id = 108
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:9f601674-c8af-3731-989c-5b952aef41d2'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 10, part.movement_number = NULL,
    part.name_ko = 'Struktur X', part.name_en = 'Kontakte: Struktur X',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 1148 AND p.composer_id = 108 AND part.part_key = 'musicbrainz:8c9fe1fe-8880-3e54-9839-090a702a9999' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:8c9fe1fe-8880-3e54-9839-090a702a9999', 10, NULL, 'Struktur X', 'Kontakte: Struktur X', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 1148 AND p.composer_id = 108
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:8c9fe1fe-8880-3e54-9839-090a702a9999'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 11, part.movement_number = NULL,
    part.name_ko = 'Struktur XI', part.name_en = 'Kontakte: Struktur XI',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 1148 AND p.composer_id = 108 AND part.part_key = 'musicbrainz:82b922f3-b93c-3082-b20d-bba27b1f5a07' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:82b922f3-b93c-3082-b20d-bba27b1f5a07', 11, NULL, 'Struktur XI', 'Kontakte: Struktur XI', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 1148 AND p.composer_id = 108
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:82b922f3-b93c-3082-b20d-bba27b1f5a07'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 12, part.movement_number = NULL,
    part.name_ko = 'Struktur XII', part.name_en = 'Kontakte: Struktur XII',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 1148 AND p.composer_id = 108 AND part.part_key = 'musicbrainz:d2b97667-2fce-344e-a3c1-fca116b406d6' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:d2b97667-2fce-344e-a3c1-fca116b406d6', 12, NULL, 'Struktur XII', 'Kontakte: Struktur XII', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 1148 AND p.composer_id = 108
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:d2b97667-2fce-344e-a3c1-fca116b406d6'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 13, part.movement_number = NULL,
    part.name_ko = 'Struktur XIII A', part.name_en = 'Kontakte: Struktur XIII A',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 1148 AND p.composer_id = 108 AND part.part_key = 'musicbrainz:3905013e-b66d-3f78-bb90-9ecd14135980' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:3905013e-b66d-3f78-bb90-9ecd14135980', 13, NULL, 'Struktur XIII A', 'Kontakte: Struktur XIII A', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 1148 AND p.composer_id = 108
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:3905013e-b66d-3f78-bb90-9ecd14135980'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 14, part.movement_number = NULL,
    part.name_ko = 'Struktur XIII B', part.name_en = 'Kontakte: Struktur XIII B',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 1148 AND p.composer_id = 108 AND part.part_key = 'musicbrainz:528050c0-19d7-3f28-9c4a-a979e3350865' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:528050c0-19d7-3f28-9c4a-a979e3350865', 14, NULL, 'Struktur XIII B', 'Kontakte: Struktur XIII B', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 1148 AND p.composer_id = 108
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:528050c0-19d7-3f28-9c4a-a979e3350865'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 15, part.movement_number = NULL,
    part.name_ko = 'Struktur XIII C', part.name_en = 'Kontakte: Struktur XIII C',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 1148 AND p.composer_id = 108 AND part.part_key = 'musicbrainz:41783dae-9130-39e6-8b1c-6f03fe6b4890' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:41783dae-9130-39e6-8b1c-6f03fe6b4890', 15, NULL, 'Struktur XIII C', 'Kontakte: Struktur XIII C', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 1148 AND p.composer_id = 108
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:41783dae-9130-39e6-8b1c-6f03fe6b4890'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 16, part.movement_number = NULL,
    part.name_ko = 'Struktur XIII D', part.name_en = 'Kontakte: Struktur XIII D',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 1148 AND p.composer_id = 108 AND part.part_key = 'musicbrainz:c504e483-65f2-3191-bbe2-7424d31000cd' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:c504e483-65f2-3191-bbe2-7424d31000cd', 16, NULL, 'Struktur XIII D', 'Kontakte: Struktur XIII D', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 1148 AND p.composer_id = 108
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:c504e483-65f2-3191-bbe2-7424d31000cd'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 17, part.movement_number = NULL,
    part.name_ko = 'Struktur XIII E', part.name_en = 'Kontakte: Struktur XIII E',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 1148 AND p.composer_id = 108 AND part.part_key = 'musicbrainz:56e5136b-69f2-3dcc-bf8d-450dc5935dde' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:56e5136b-69f2-3dcc-bf8d-450dc5935dde', 17, NULL, 'Struktur XIII E', 'Kontakte: Struktur XIII E', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 1148 AND p.composer_id = 108
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:56e5136b-69f2-3dcc-bf8d-450dc5935dde'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 18, part.movement_number = NULL,
    part.name_ko = 'Struktur XIII F', part.name_en = 'Kontakte: Struktur XIII F',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 1148 AND p.composer_id = 108 AND part.part_key = 'musicbrainz:33c2f76c-be01-36b4-9e3d-a0150ed70802' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:33c2f76c-be01-36b4-9e3d-a0150ed70802', 18, NULL, 'Struktur XIII F', 'Kontakte: Struktur XIII F', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 1148 AND p.composer_id = 108
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:33c2f76c-be01-36b4-9e3d-a0150ed70802'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 19, part.movement_number = NULL,
    part.name_ko = 'Struktur XIV', part.name_en = 'Kontakte: Struktur XIV',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 1148 AND p.composer_id = 108 AND part.part_key = 'musicbrainz:05a320c7-6ee5-33f9-87db-762a8eb08dcd' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:05a320c7-6ee5-33f9-87db-762a8eb08dcd', 19, NULL, 'Struktur XIV', 'Kontakte: Struktur XIV', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 1148 AND p.composer_id = 108
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:05a320c7-6ee5-33f9-87db-762a8eb08dcd'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 20, part.movement_number = NULL,
    part.name_ko = 'Struktur XV', part.name_en = 'Kontakte: Struktur XV',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 1148 AND p.composer_id = 108 AND part.part_key = 'musicbrainz:7b67926d-3c76-35ef-94d4-01994ef22b49' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:7b67926d-3c76-35ef-94d4-01994ef22b49', 20, NULL, 'Struktur XV', 'Kontakte: Struktur XV', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 1148 AND p.composer_id = 108
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:7b67926d-3c76-35ef-94d4-01994ef22b49'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 21, part.movement_number = NULL,
    part.name_ko = 'Struktur XVI A', part.name_en = 'Kontakte: Struktur XVI A',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 1148 AND p.composer_id = 108 AND part.part_key = 'musicbrainz:410d70ec-f48b-359c-8f59-4d4758d77e1d' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:410d70ec-f48b-359c-8f59-4d4758d77e1d', 21, NULL, 'Struktur XVI A', 'Kontakte: Struktur XVI A', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 1148 AND p.composer_id = 108
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:410d70ec-f48b-359c-8f59-4d4758d77e1d'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 22, part.movement_number = NULL,
    part.name_ko = 'Struktur XVI B', part.name_en = 'Kontakte: Struktur XVI B',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 1148 AND p.composer_id = 108 AND part.part_key = 'musicbrainz:d467d904-6813-3401-9ed5-a389fe5aa10f' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:d467d904-6813-3401-9ed5-a389fe5aa10f', 22, NULL, 'Struktur XVI B', 'Kontakte: Struktur XVI B', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 1148 AND p.composer_id = 108
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:d467d904-6813-3401-9ed5-a389fe5aa10f'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 23, part.movement_number = NULL,
    part.name_ko = 'Struktur XVI C', part.name_en = 'Kontakte: Struktur XVI C',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 1148 AND p.composer_id = 108 AND part.part_key = 'musicbrainz:751e5971-912c-3256-9ecf-b92581f814e1' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:751e5971-912c-3256-9ecf-b92581f814e1', 23, NULL, 'Struktur XVI C', 'Kontakte: Struktur XVI C', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 1148 AND p.composer_id = 108
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:751e5971-912c-3256-9ecf-b92581f814e1'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 24, part.movement_number = NULL,
    part.name_ko = 'Struktur XVI D', part.name_en = 'Kontakte: Struktur XVI D',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 1148 AND p.composer_id = 108 AND part.part_key = 'musicbrainz:b750dbd1-d904-366a-bbd7-8bcbce32ce26' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:b750dbd1-d904-366a-bbd7-8bcbce32ce26', 24, NULL, 'Struktur XVI D', 'Kontakte: Struktur XVI D', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 1148 AND p.composer_id = 108
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:b750dbd1-d904-366a-bbd7-8bcbce32ce26'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 25, part.movement_number = NULL,
    part.name_ko = 'Struktur XVI E', part.name_en = 'Kontakte: Struktur XVI E',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 1148 AND p.composer_id = 108 AND part.part_key = 'musicbrainz:7d645fc4-b0a9-398c-ae41-ce5165a94f2c' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:7d645fc4-b0a9-398c-ae41-ce5165a94f2c', 25, NULL, 'Struktur XVI E', 'Kontakte: Struktur XVI E', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 1148 AND p.composer_id = 108
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:7d645fc4-b0a9-398c-ae41-ce5165a94f2c'
);


-- None Kontra-Punkte, Nr. 1

UPDATE pieces piece
SET piece.title = 'Kontra-Punkte, Nr. 1', piece.title_en = 'Kontra-Punkte, Nr. 1',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 1938 AND piece.composer_id = 108
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Kreuzspiel, Nr. 1/7

UPDATE pieces piece
SET piece.title = 'Kreuzspiel, Nr. 1/7', piece.title_en = 'Kreuzspiel, Nr. 1/7',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 2313 AND piece.composer_id = 108
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'I', part.name_en = 'Kreuzspiel, Nr. 1/7: I.',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 2313 AND p.composer_id = 108 AND part.part_key = 'musicbrainz:c267c751-9abd-4d0d-b1b1-d91a8e170ce5' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:c267c751-9abd-4d0d-b1b1-d91a8e170ce5', 1, NULL, 'I', 'Kreuzspiel, Nr. 1/7: I.', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 2313 AND p.composer_id = 108
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:c267c751-9abd-4d0d-b1b1-d91a8e170ce5'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'II', part.name_en = 'Kreuzspiel, Nr. 1/7: II.',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 2313 AND p.composer_id = 108 AND part.part_key = 'musicbrainz:f77ecac2-01e1-42b7-8794-9ed5acc61814' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:f77ecac2-01e1-42b7-8794-9ed5acc61814', 2, NULL, 'II', 'Kreuzspiel, Nr. 1/7: II.', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 2313 AND p.composer_id = 108
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:f77ecac2-01e1-42b7-8794-9ed5acc61814'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = NULL,
    part.name_ko = 'III', part.name_en = 'Kreuzspiel, Nr. 1/7: III.',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 2313 AND p.composer_id = 108 AND part.part_key = 'musicbrainz:161faef5-79b0-4d8a-a647-b735cb50725b' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:161faef5-79b0-4d8a-a647-b735cb50725b', 3, NULL, 'III', 'Kreuzspiel, Nr. 1/7: III.', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 2313 AND p.composer_id = 108
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:161faef5-79b0-4d8a-a647-b735cb50725b'
);


-- None Kurzwellen, Nr. 25

UPDATE pieces piece
SET piece.title = 'Kurzwellen, Nr. 25', piece.title_en = 'Kurzwellen, Nr. 25',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 1757 AND piece.composer_id = 108
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None LICHT, Die sieben Tage der Woche

UPDATE pieces piece
SET piece.title = 'LICHT, Die sieben Tage der Woche', piece.title_en = 'LICHT, Die sieben Tage der Woche',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 1476 AND piece.composer_id = 108
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'MONTAG aus LICHT', part.name_en = 'MONTAG aus LICHT',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 1476 AND p.composer_id = 108 AND part.part_key = 'musicbrainz:11475699-62f4-49f4-9bb2-13728ab2b08e' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:11475699-62f4-49f4-9bb2-13728ab2b08e', 1, NULL, 'MONTAG aus LICHT', 'MONTAG aus LICHT', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 1476 AND p.composer_id = 108
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:11475699-62f4-49f4-9bb2-13728ab2b08e'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:11475699-62f4-49f4-9bb2-13728ab2b08e'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'MONTAGS‐GRUSS', part.name_en = 'MONTAGS‐GRUSS',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 1476 AND p.composer_id = 108 AND part.part_key = 'musicbrainz:a69a864c-1e36-4e11-95ae-24fed4d3a9b9' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:a69a864c-1e36-4e11-95ae-24fed4d3a9b9', 1, NULL, 'MONTAGS‐GRUSS', 'MONTAGS‐GRUSS', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:11475699-62f4-49f4-9bb2-13728ab2b08e'
WHERE p.id = 1476 AND p.composer_id = 108
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:a69a864c-1e36-4e11-95ae-24fed4d3a9b9'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:11475699-62f4-49f4-9bb2-13728ab2b08e'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'EVAs ERSTGEBURT', part.name_en = 'EVAs ERSTGEBURT',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 1476 AND p.composer_id = 108 AND part.part_key = 'musicbrainz:ac0fecbf-3884-49a7-8d26-b1ea8454aa16' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:ac0fecbf-3884-49a7-8d26-b1ea8454aa16', 2, NULL, 'EVAs ERSTGEBURT', 'EVAs ERSTGEBURT', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:11475699-62f4-49f4-9bb2-13728ab2b08e'
WHERE p.id = 1476 AND p.composer_id = 108
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:ac0fecbf-3884-49a7-8d26-b1ea8454aa16'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:11475699-62f4-49f4-9bb2-13728ab2b08e'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = NULL,
    part.name_ko = 'EVAs ZWEITGEBURT', part.name_en = 'EVAs ZWEITGEBURT',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 1476 AND p.composer_id = 108 AND part.part_key = 'musicbrainz:e680b6a2-741a-482b-afab-a1937ce92d2c' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:e680b6a2-741a-482b-afab-a1937ce92d2c', 3, NULL, 'EVAs ZWEITGEBURT', 'EVAs ZWEITGEBURT', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:11475699-62f4-49f4-9bb2-13728ab2b08e'
WHERE p.id = 1476 AND p.composer_id = 108
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:e680b6a2-741a-482b-afab-a1937ce92d2c'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:11475699-62f4-49f4-9bb2-13728ab2b08e'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = NULL,
    part.name_ko = 'EVAs ZAUBER', part.name_en = 'EVAs ZAUBER',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 1476 AND p.composer_id = 108 AND part.part_key = 'musicbrainz:4a3274fa-d253-4438-b729-1576cb39e0ce' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:4a3274fa-d253-4438-b729-1576cb39e0ce', 4, NULL, 'EVAs ZAUBER', 'EVAs ZAUBER', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:11475699-62f4-49f4-9bb2-13728ab2b08e'
WHERE p.id = 1476 AND p.composer_id = 108
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:4a3274fa-d253-4438-b729-1576cb39e0ce'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:11475699-62f4-49f4-9bb2-13728ab2b08e'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 5, part.movement_number = NULL,
    part.name_ko = 'MONTAGS‐ABSCHIED', part.name_en = 'MONTAGS‐ABSCHIED',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 1476 AND p.composer_id = 108 AND part.part_key = 'musicbrainz:1157996e-610e-4987-84bd-7d309946f600' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:1157996e-610e-4987-84bd-7d309946f600', 5, NULL, 'MONTAGS‐ABSCHIED', 'MONTAGS‐ABSCHIED', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:11475699-62f4-49f4-9bb2-13728ab2b08e'
WHERE p.id = 1476 AND p.composer_id = 108
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:1157996e-610e-4987-84bd-7d309946f600'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'DIENSTAG aus LICHT', part.name_en = 'DIENSTAG aus LICHT',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 1476 AND p.composer_id = 108 AND part.part_key = 'musicbrainz:0243a2b3-067b-4bfb-a5c8-e0eb09b5fb7c' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:0243a2b3-067b-4bfb-a5c8-e0eb09b5fb7c', 2, NULL, 'DIENSTAG aus LICHT', 'DIENSTAG aus LICHT', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 1476 AND p.composer_id = 108
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:0243a2b3-067b-4bfb-a5c8-e0eb09b5fb7c'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:0243a2b3-067b-4bfb-a5c8-e0eb09b5fb7c'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'Dienstags-Gruß', part.name_en = 'Dienstag aus Licht: Dienstags-Gruß',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 1476 AND p.composer_id = 108 AND part.part_key = 'musicbrainz:354bd5e3-ed73-4712-83ab-1a448ba4dd63' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:354bd5e3-ed73-4712-83ab-1a448ba4dd63', 1, NULL, 'Dienstags-Gruß', 'Dienstag aus Licht: Dienstags-Gruß', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:0243a2b3-067b-4bfb-a5c8-e0eb09b5fb7c'
WHERE p.id = 1476 AND p.composer_id = 108
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:354bd5e3-ed73-4712-83ab-1a448ba4dd63'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:0243a2b3-067b-4bfb-a5c8-e0eb09b5fb7c'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'Akt (Der Jahreslauf)', part.name_en = 'Dienstag aus Licht: I. Akt (Der Jahreslauf)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 1476 AND p.composer_id = 108 AND part.part_key = 'musicbrainz:eeebc8e4-95f9-4ae1-8719-6610dfc35839' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:eeebc8e4-95f9-4ae1-8719-6610dfc35839', 2, NULL, 'Akt (Der Jahreslauf)', 'Dienstag aus Licht: I. Akt (Der Jahreslauf)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:0243a2b3-067b-4bfb-a5c8-e0eb09b5fb7c'
WHERE p.id = 1476 AND p.composer_id = 108
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:eeebc8e4-95f9-4ae1-8719-6610dfc35839'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:0243a2b3-067b-4bfb-a5c8-e0eb09b5fb7c'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = NULL,
    part.name_ko = 'Akt (Invasion)', part.name_en = 'Dienstag aus Licht: II. Akt (Invasion)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 1476 AND p.composer_id = 108 AND part.part_key = 'musicbrainz:29f21639-2e55-41dd-8023-bd929b93d9ae' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:29f21639-2e55-41dd-8023-bd929b93d9ae', 3, NULL, 'Akt (Invasion)', 'Dienstag aus Licht: II. Akt (Invasion)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:0243a2b3-067b-4bfb-a5c8-e0eb09b5fb7c'
WHERE p.id = 1476 AND p.composer_id = 108
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:29f21639-2e55-41dd-8023-bd929b93d9ae'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = NULL,
    part.name_ko = 'MITTWOCH aus LICHT', part.name_en = 'MITTWOCH aus LICHT',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 1476 AND p.composer_id = 108 AND part.part_key = 'musicbrainz:f5d339b7-ae2a-4c8f-b65d-8729a31c1c9b' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:f5d339b7-ae2a-4c8f-b65d-8729a31c1c9b', 3, NULL, 'MITTWOCH aus LICHT', 'MITTWOCH aus LICHT', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 1476 AND p.composer_id = 108
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:f5d339b7-ae2a-4c8f-b65d-8729a31c1c9b'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:f5d339b7-ae2a-4c8f-b65d-8729a31c1c9b'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'Michaelion', part.name_en = 'Mittwoch aus Licht: Michaelion',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 1476 AND p.composer_id = 108 AND part.part_key = 'musicbrainz:3ff9a74e-4367-4c42-8318-d284bdef90a7' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:3ff9a74e-4367-4c42-8318-d284bdef90a7', 1, NULL, 'Michaelion', 'Mittwoch aus Licht: Michaelion', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:f5d339b7-ae2a-4c8f-b65d-8729a31c1c9b'
WHERE p.id = 1476 AND p.composer_id = 108
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:3ff9a74e-4367-4c42-8318-d284bdef90a7'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:f5d339b7-ae2a-4c8f-b65d-8729a31c1c9b'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'Welt-Parlament', part.name_en = 'Mittwoch aus Licht: Welt-Parlament',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 1476 AND p.composer_id = 108 AND part.part_key = 'musicbrainz:78d59911-c723-4f57-ad58-a3c354c8163a' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:78d59911-c723-4f57-ad58-a3c354c8163a', 2, NULL, 'Welt-Parlament', 'Mittwoch aus Licht: Welt-Parlament', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:f5d339b7-ae2a-4c8f-b65d-8729a31c1c9b'
WHERE p.id = 1476 AND p.composer_id = 108
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:78d59911-c723-4f57-ad58-a3c354c8163a'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:f5d339b7-ae2a-4c8f-b65d-8729a31c1c9b'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = NULL,
    part.name_ko = 'Helikopter-Streichquartett', part.name_en = 'Mittwoch aus Licht: Helikopter-Streichquartett',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 1476 AND p.composer_id = 108 AND part.part_key = 'musicbrainz:9b0d7c51-7e6c-4eb8-806b-982c2b4ea6c7' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:9b0d7c51-7e6c-4eb8-806b-982c2b4ea6c7', 3, NULL, 'Helikopter-Streichquartett', 'Mittwoch aus Licht: Helikopter-Streichquartett', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:f5d339b7-ae2a-4c8f-b65d-8729a31c1c9b'
WHERE p.id = 1476 AND p.composer_id = 108
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:9b0d7c51-7e6c-4eb8-806b-982c2b4ea6c7'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:f5d339b7-ae2a-4c8f-b65d-8729a31c1c9b'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = NULL,
    part.name_ko = 'Orchester-Finalisten', part.name_en = 'Mittwoch aus Licht: Orchester-Finalisten',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 1476 AND p.composer_id = 108 AND part.part_key = 'musicbrainz:f1587923-5c44-487f-9b78-36df8bf0441a' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:f1587923-5c44-487f-9b78-36df8bf0441a', 4, NULL, 'Orchester-Finalisten', 'Mittwoch aus Licht: Orchester-Finalisten', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:f5d339b7-ae2a-4c8f-b65d-8729a31c1c9b'
WHERE p.id = 1476 AND p.composer_id = 108
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:f1587923-5c44-487f-9b78-36df8bf0441a'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = NULL,
    part.name_ko = 'DONNERSTAG aus LICHT', part.name_en = 'DONNERSTAG aus LICHT',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 1476 AND p.composer_id = 108 AND part.part_key = 'musicbrainz:82c40a14-4de1-4feb-a4fa-9f75d84471d9' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:82c40a14-4de1-4feb-a4fa-9f75d84471d9', 4, NULL, 'DONNERSTAG aus LICHT', 'DONNERSTAG aus LICHT', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 1476 AND p.composer_id = 108
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:82c40a14-4de1-4feb-a4fa-9f75d84471d9'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:82c40a14-4de1-4feb-a4fa-9f75d84471d9'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'Donnerstags-Gruß', part.name_en = 'Donnerstag aus Licht: Donnerstags-Gruß',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 1476 AND p.composer_id = 108 AND part.part_key = 'musicbrainz:f868364b-0438-4898-8b27-f73afcb3e85a' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:f868364b-0438-4898-8b27-f73afcb3e85a', 1, NULL, 'Donnerstags-Gruß', 'Donnerstag aus Licht: Donnerstags-Gruß', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:82c40a14-4de1-4feb-a4fa-9f75d84471d9'
WHERE p.id = 1476 AND p.composer_id = 108
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:f868364b-0438-4898-8b27-f73afcb3e85a'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:82c40a14-4de1-4feb-a4fa-9f75d84471d9'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'Akt I. Michaels Jugend', part.name_en = 'Donnerstag aus Licht: Akt I. Michaels Jugend',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 1476 AND p.composer_id = 108 AND part.part_key = 'musicbrainz:627f07f2-f11c-4fbe-b047-c79a42f679a7' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:627f07f2-f11c-4fbe-b047-c79a42f679a7', 2, NULL, 'Akt I. Michaels Jugend', 'Donnerstag aus Licht: Akt I. Michaels Jugend', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:82c40a14-4de1-4feb-a4fa-9f75d84471d9'
WHERE p.id = 1476 AND p.composer_id = 108
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:627f07f2-f11c-4fbe-b047-c79a42f679a7'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:82c40a14-4de1-4feb-a4fa-9f75d84471d9'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = NULL,
    part.name_ko = 'Akt II. Michaels Reise um die Erde', part.name_en = 'Donnerstag aus Licht: Akt II. Michaels Reise um die Erde',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 1476 AND p.composer_id = 108 AND part.part_key = 'musicbrainz:1263f92e-7d55-4e99-87f0-963659a79b9f' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:1263f92e-7d55-4e99-87f0-963659a79b9f', 3, NULL, 'Akt II. Michaels Reise um die Erde', 'Donnerstag aus Licht: Akt II. Michaels Reise um die Erde', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:82c40a14-4de1-4feb-a4fa-9f75d84471d9'
WHERE p.id = 1476 AND p.composer_id = 108
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:1263f92e-7d55-4e99-87f0-963659a79b9f'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:82c40a14-4de1-4feb-a4fa-9f75d84471d9'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = NULL,
    part.name_ko = 'Akt III. Michaels Heimkehr', part.name_en = 'Donnerstag aus Licht: Akt III. Michaels Heimkehr',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 1476 AND p.composer_id = 108 AND part.part_key = 'musicbrainz:32b777e3-616d-4002-9a16-2c523e4c870b' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:32b777e3-616d-4002-9a16-2c523e4c870b', 4, NULL, 'Akt III. Michaels Heimkehr', 'Donnerstag aus Licht: Akt III. Michaels Heimkehr', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:82c40a14-4de1-4feb-a4fa-9f75d84471d9'
WHERE p.id = 1476 AND p.composer_id = 108
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:32b777e3-616d-4002-9a16-2c523e4c870b'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:82c40a14-4de1-4feb-a4fa-9f75d84471d9'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 5, part.movement_number = NULL,
    part.name_ko = 'Donnerstags-Abschied', part.name_en = 'Donnerstag aus Licht: Donnerstags-Abschied',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 1476 AND p.composer_id = 108 AND part.part_key = 'musicbrainz:440694c8-498a-4273-8001-bf480598263c' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:440694c8-498a-4273-8001-bf480598263c', 5, NULL, 'Donnerstags-Abschied', 'Donnerstag aus Licht: Donnerstags-Abschied', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:82c40a14-4de1-4feb-a4fa-9f75d84471d9'
WHERE p.id = 1476 AND p.composer_id = 108
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:440694c8-498a-4273-8001-bf480598263c'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 5, part.movement_number = NULL,
    part.name_ko = 'FREITAG aus LICHT', part.name_en = 'FREITAG aus LICHT',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 1476 AND p.composer_id = 108 AND part.part_key = 'musicbrainz:fa3eb70a-9f31-4577-9cff-100e6f764bcf' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:fa3eb70a-9f31-4577-9cff-100e6f764bcf', 5, NULL, 'FREITAG aus LICHT', 'FREITAG aus LICHT', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 1476 AND p.composer_id = 108
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:fa3eb70a-9f31-4577-9cff-100e6f764bcf'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 6, part.movement_number = NULL,
    part.name_ko = 'SAMSTAG aus LICHT', part.name_en = 'SAMSTAG aus LICHT',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 1476 AND p.composer_id = 108 AND part.part_key = 'musicbrainz:40f9c47d-ab6b-430c-8695-9f2a0f38b4bf' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:40f9c47d-ab6b-430c-8695-9f2a0f38b4bf', 6, NULL, 'SAMSTAG aus LICHT', 'SAMSTAG aus LICHT', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 1476 AND p.composer_id = 108
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:40f9c47d-ab6b-430c-8695-9f2a0f38b4bf'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:40f9c47d-ab6b-430c-8695-9f2a0f38b4bf'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'Samstags-Gruss', part.name_en = 'Samstag aus Licht: Samstags-Gruss',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 1476 AND p.composer_id = 108 AND part.part_key = 'musicbrainz:d1f3c0ff-dd31-4122-a70d-446cd90732f5' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:d1f3c0ff-dd31-4122-a70d-446cd90732f5', 1, NULL, 'Samstags-Gruss', 'Samstag aus Licht: Samstags-Gruss', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:40f9c47d-ab6b-430c-8695-9f2a0f38b4bf'
WHERE p.id = 1476 AND p.composer_id = 108
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:d1f3c0ff-dd31-4122-a70d-446cd90732f5'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:40f9c47d-ab6b-430c-8695-9f2a0f38b4bf'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'Szene (Luzifers Traum)', part.name_en = 'Samstag aus Licht: 1. Szene (Luzifers Traum)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 1476 AND p.composer_id = 108 AND part.part_key = 'musicbrainz:a44eed1f-4fd7-4637-aa27-d21c96ef6237' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:a44eed1f-4fd7-4637-aa27-d21c96ef6237', 2, NULL, 'Szene (Luzifers Traum)', 'Samstag aus Licht: 1. Szene (Luzifers Traum)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:40f9c47d-ab6b-430c-8695-9f2a0f38b4bf'
WHERE p.id = 1476 AND p.composer_id = 108
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:a44eed1f-4fd7-4637-aa27-d21c96ef6237'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:40f9c47d-ab6b-430c-8695-9f2a0f38b4bf'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = NULL,
    part.name_ko = 'Szene (Kathinkas Gesang)', part.name_en = 'Samstag aus Licht: 2. Szene (Kathinkas Gesang)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 1476 AND p.composer_id = 108 AND part.part_key = 'musicbrainz:10c48dd4-a814-4403-ab2d-bfb2a84fbe25' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:10c48dd4-a814-4403-ab2d-bfb2a84fbe25', 3, NULL, 'Szene (Kathinkas Gesang)', 'Samstag aus Licht: 2. Szene (Kathinkas Gesang)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:40f9c47d-ab6b-430c-8695-9f2a0f38b4bf'
WHERE p.id = 1476 AND p.composer_id = 108
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:10c48dd4-a814-4403-ab2d-bfb2a84fbe25'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:40f9c47d-ab6b-430c-8695-9f2a0f38b4bf'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = NULL,
    part.name_ko = 'Szene (Luzifers Tanz)', part.name_en = 'Samstag aus Licht: 3. Szene (Luzifers Tanz)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 1476 AND p.composer_id = 108 AND part.part_key = 'musicbrainz:52b5b036-56ad-45d9-b4c5-eea4990dadce' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:52b5b036-56ad-45d9-b4c5-eea4990dadce', 4, NULL, 'Szene (Luzifers Tanz)', 'Samstag aus Licht: 3. Szene (Luzifers Tanz)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:40f9c47d-ab6b-430c-8695-9f2a0f38b4bf'
WHERE p.id = 1476 AND p.composer_id = 108
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:52b5b036-56ad-45d9-b4c5-eea4990dadce'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:40f9c47d-ab6b-430c-8695-9f2a0f38b4bf'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 5, part.movement_number = NULL,
    part.name_ko = 'Szene (Luzifers Abschied)', part.name_en = 'Samstag aus Licht: 4. Szene (Luzifers Abschied)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 1476 AND p.composer_id = 108 AND part.part_key = 'musicbrainz:5f0a910a-b9ad-4729-ba40-fc3257d379bd' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:5f0a910a-b9ad-4729-ba40-fc3257d379bd', 5, NULL, 'Szene (Luzifers Abschied)', 'Samstag aus Licht: 4. Szene (Luzifers Abschied)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:40f9c47d-ab6b-430c-8695-9f2a0f38b4bf'
WHERE p.id = 1476 AND p.composer_id = 108
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:5f0a910a-b9ad-4729-ba40-fc3257d379bd'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 7, part.movement_number = NULL,
    part.name_ko = 'SONNTAG aus LICHT', part.name_en = 'SONNTAG aus LICHT',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 1476 AND p.composer_id = 108 AND part.part_key = 'musicbrainz:81a9fec6-66c0-4be0-b656-48396a370c56' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:81a9fec6-66c0-4be0-b656-48396a370c56', 7, NULL, 'SONNTAG aus LICHT', 'SONNTAG aus LICHT', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 1476 AND p.composer_id = 108
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:81a9fec6-66c0-4be0-b656-48396a370c56'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:81a9fec6-66c0-4be0-b656-48396a370c56'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'LICHTER–WASSER', part.name_en = 'LICHTER–WASSER',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 1476 AND p.composer_id = 108 AND part.part_key = 'musicbrainz:6a5ff664-dc29-4551-8808-12e53d1c668d' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:6a5ff664-dc29-4551-8808-12e53d1c668d', 1, NULL, 'LICHTER–WASSER', 'LICHTER–WASSER', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:81a9fec6-66c0-4be0-b656-48396a370c56'
WHERE p.id = 1476 AND p.composer_id = 108
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:6a5ff664-dc29-4551-8808-12e53d1c668d'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:81a9fec6-66c0-4be0-b656-48396a370c56'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'ENGEL-PROZESSIONEN', part.name_en = 'ENGEL-PROZESSIONEN',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 1476 AND p.composer_id = 108 AND part.part_key = 'musicbrainz:ad855c15-5c7f-4802-b3e3-79044580c8c5' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:ad855c15-5c7f-4802-b3e3-79044580c8c5', 2, NULL, 'ENGEL-PROZESSIONEN', 'ENGEL-PROZESSIONEN', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:81a9fec6-66c0-4be0-b656-48396a370c56'
WHERE p.id = 1476 AND p.composer_id = 108
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:ad855c15-5c7f-4802-b3e3-79044580c8c5'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:81a9fec6-66c0-4be0-b656-48396a370c56'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = NULL,
    part.name_ko = 'LICHT-BILDER', part.name_en = 'LICHT-BILDER',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 1476 AND p.composer_id = 108 AND part.part_key = 'musicbrainz:493918d8-c862-44e9-90c6-998e471ad54d' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:493918d8-c862-44e9-90c6-998e471ad54d', 3, NULL, 'LICHT-BILDER', 'LICHT-BILDER', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:81a9fec6-66c0-4be0-b656-48396a370c56'
WHERE p.id = 1476 AND p.composer_id = 108
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:493918d8-c862-44e9-90c6-998e471ad54d'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:81a9fec6-66c0-4be0-b656-48396a370c56'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = NULL,
    part.name_ko = 'DÛFTE–ZEICHEN', part.name_en = 'DÛFTE–ZEICHEN',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 1476 AND p.composer_id = 108 AND part.part_key = 'musicbrainz:21614f49-2fda-4b6d-b8cb-6c74866c1765' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:21614f49-2fda-4b6d-b8cb-6c74866c1765', 4, NULL, 'DÛFTE–ZEICHEN', 'DÛFTE–ZEICHEN', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:81a9fec6-66c0-4be0-b656-48396a370c56'
WHERE p.id = 1476 AND p.composer_id = 108
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:21614f49-2fda-4b6d-b8cb-6c74866c1765'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:81a9fec6-66c0-4be0-b656-48396a370c56'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 5, part.movement_number = NULL,
    part.name_ko = 'HOCH-ZEITEN für Orchester', part.name_en = 'HOCH-ZEITEN für Orchester',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 1476 AND p.composer_id = 108 AND part.part_key = 'musicbrainz:3d45345e-bcdf-4511-8abe-45047b4cfb56' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:3d45345e-bcdf-4511-8abe-45047b4cfb56', 5, NULL, 'HOCH-ZEITEN für Orchester', 'HOCH-ZEITEN für Orchester', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:81a9fec6-66c0-4be0-b656-48396a370c56'
WHERE p.id = 1476 AND p.composer_id = 108
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:3d45345e-bcdf-4511-8abe-45047b4cfb56'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:81a9fec6-66c0-4be0-b656-48396a370c56'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 6, part.movement_number = NULL,
    part.name_ko = 'HOCH-ZEITEN für Chor', part.name_en = 'HOCH-ZEITEN für Chor',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 1476 AND p.composer_id = 108 AND part.part_key = 'musicbrainz:bb0a4702-048d-4a08-a81e-4224f02a7991' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:bb0a4702-048d-4a08-a81e-4224f02a7991', 6, NULL, 'HOCH-ZEITEN für Chor', 'HOCH-ZEITEN für Chor', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:81a9fec6-66c0-4be0-b656-48396a370c56'
WHERE p.id = 1476 AND p.composer_id = 108
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:bb0a4702-048d-4a08-a81e-4224f02a7991'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:81a9fec6-66c0-4be0-b656-48396a370c56'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 7, part.movement_number = NULL,
    part.name_ko = 'SONNTAGS-ABSCHIED', part.name_en = 'SONNTAGS-ABSCHIED',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 1476 AND p.composer_id = 108 AND part.part_key = 'musicbrainz:4999adcc-d4c8-47a5-9bde-88890bb56a7c' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:4999adcc-d4c8-47a5-9bde-88890bb56a7c', 7, NULL, 'SONNTAGS-ABSCHIED', 'SONNTAGS-ABSCHIED', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:81a9fec6-66c0-4be0-b656-48396a370c56'
WHERE p.id = 1476 AND p.composer_id = 108
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:4999adcc-d4c8-47a5-9bde-88890bb56a7c'
);


-- None Mantra, Nr. 32

UPDATE pieces piece
SET piece.title = 'Mantra, Nr. 32', piece.title_en = 'Mantra, Nr. 32',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 1450 AND piece.composer_id = 108
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'XIII',
    part.name_ko = 'Sforzando (Fortepiano)', part.name_en = 'Mantra: XIII. Sforzando (Fortepiano)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 1450 AND p.composer_id = 108 AND part.part_key = 'musicbrainz:00b828eb-8aeb-4e6e-b32e-7207b654b814' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:00b828eb-8aeb-4e6e-b32e-7207b654b814', 1, 'XIII', 'Sforzando (Fortepiano)', 'Mantra: XIII. Sforzando (Fortepiano)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 1450 AND p.composer_id = 108
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:00b828eb-8aeb-4e6e-b32e-7207b654b814'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'X',
    part.name_ko = 'Staccato', part.name_en = 'Mantra: X. Staccato',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 1450 AND p.composer_id = 108 AND part.part_key = 'musicbrainz:0e91f625-1ddf-41be-914a-95cc2b6ccd7d' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:0e91f625-1ddf-41be-914a-95cc2b6ccd7d', 2, 'X', 'Staccato', 'Mantra: X. Staccato', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 1450 AND p.composer_id = 108
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:0e91f625-1ddf-41be-914a-95cc2b6ccd7d'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'XV',
    part.name_ko = 'Coda - Reprise de la formule', part.name_en = 'Mantra: XV. Coda - Reprise de la formule',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 1450 AND p.composer_id = 108 AND part.part_key = 'musicbrainz:139ba70c-93d6-4c3c-9a4b-fa0b0b583b16' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:139ba70c-93d6-4c3c-9a4b-fa0b0b583b16', 3, 'XV', 'Coda - Reprise de la formule', 'Mantra: XV. Coda - Reprise de la formule', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 1450 AND p.composer_id = 108
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:139ba70c-93d6-4c3c-9a4b-fa0b0b583b16'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = 'IX',
    part.name_ko = 'Liaison chromatique', part.name_en = 'Mantra: IX. Liaison chromatique',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 1450 AND p.composer_id = 108 AND part.part_key = 'musicbrainz:1ae468c1-5709-4f2a-b864-37333b1fa73c' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:1ae468c1-5709-4f2a-b864-37333b1fa73c', 4, 'IX', 'Liaison chromatique', 'Mantra: IX. Liaison chromatique', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 1450 AND p.composer_id = 108
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:1ae468c1-5709-4f2a-b864-37333b1fa73c'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 5, part.movement_number = 'XIV',
    part.name_ko = 'Lien en arpège', part.name_en = 'Mantra: XIV. Lien en arpège',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 1450 AND p.composer_id = 108 AND part.part_key = 'musicbrainz:24383f77-7098-47d7-b919-145d25f91e61' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:24383f77-7098-47d7-b919-145d25f91e61', 5, 'XIV', 'Lien en arpège', 'Mantra: XIV. Lien en arpège', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 1450 AND p.composer_id = 108
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:24383f77-7098-47d7-b919-145d25f91e61'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 6, part.movement_number = 'VII',
    part.name_ko = 'Accord marqué', part.name_en = 'Mantra: VII. Accord marqué',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 1450 AND p.composer_id = 108 AND part.part_key = 'musicbrainz:3f0d03ec-ff1a-4f6a-9977-a7f7e300a944' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:3f0d03ec-ff1a-4f6a-9977-a7f7e300a944', 6, 'VII', 'Accord marqué', 'Mantra: VII. Accord marqué', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 1450 AND p.composer_id = 108
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:3f0d03ec-ff1a-4f6a-9977-a7f7e300a944'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 7, part.movement_number = 'V',
    part.name_ko = 'Gruppetto autour d''une note centrale', part.name_en = 'Mantra: V. Gruppetto autour d''une note centrale',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 1450 AND p.composer_id = 108 AND part.part_key = 'musicbrainz:4958ff6f-869c-469e-b2ab-000cba7c23c3' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:4958ff6f-869c-469e-b2ab-000cba7c23c3', 7, 'V', 'Gruppetto autour d''une note centrale', 'Mantra: V. Gruppetto autour d''une note centrale', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 1450 AND p.composer_id = 108
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:4958ff6f-869c-469e-b2ab-000cba7c23c3'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 8, part.movement_number = 'XII',
    part.name_ko = 'Trille', part.name_en = 'Mantra: XII. Trille',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 1450 AND p.composer_id = 108 AND part.part_key = 'musicbrainz:8e652fd9-562c-4d6e-ac89-55ac77f57570' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:8e652fd9-562c-4d6e-ac89-55ac77f57570', 8, 'XII', 'Trille', 'Mantra: XII. Trille', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 1450 AND p.composer_id = 108
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:8e652fd9-562c-4d6e-ac89-55ac77f57570'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 9, part.movement_number = 'IV',
    part.name_ko = 'Son « normal »', part.name_en = 'Mantra: IV. Son « normal »',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 1450 AND p.composer_id = 108 AND part.part_key = 'musicbrainz:b17adaf6-8028-4ac3-9de8-edd74e2c620e' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:b17adaf6-8028-4ac3-9de8-edd74e2c620e', 9, 'IV', 'Son « normal »', 'Mantra: IV. Son « normal »', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 1450 AND p.composer_id = 108
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:b17adaf6-8028-4ac3-9de8-edd74e2c620e'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 10, part.movement_number = 'III',
    part.name_ko = 'Accent à la fin', part.name_en = 'Mantra: III. Accent à la fin',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 1450 AND p.composer_id = 108 AND part.part_key = 'musicbrainz:b76eb8ba-9c4f-48ae-aefe-28cf4aa1a553' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:b76eb8ba-9c4f-48ae-aefe-28cf4aa1a553', 10, 'III', 'Accent à la fin', 'Mantra: III. Accent à la fin', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 1450 AND p.composer_id = 108
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:b76eb8ba-9c4f-48ae-aefe-28cf4aa1a553'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 11, part.movement_number = 'I',
    part.name_ko = 'Introduction et formule', part.name_en = 'Mantra: I. Introduction et formule',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 1450 AND p.composer_id = 108 AND part.part_key = 'musicbrainz:b7b121d3-85e2-45c6-8f33-842c517a6722' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:b7b121d3-85e2-45c6-8f33-842c517a6722', 11, 'I', 'Introduction et formule', 'Mantra: I. Introduction et formule', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 1450 AND p.composer_id = 108
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:b7b121d3-85e2-45c6-8f33-842c517a6722'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 12, part.movement_number = 'XI',
    part.name_ko = 'Répétition irrégulière « morse »', part.name_en = 'Mantra: XI. Répétition irrégulière « morse »',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 1450 AND p.composer_id = 108 AND part.part_key = 'musicbrainz:c10436e8-b8b4-4967-b331-0f1716329e29' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:c10436e8-b8b4-4967-b331-0f1716329e29', 12, 'XI', 'Répétition irrégulière « morse »', 'Mantra: XI. Répétition irrégulière « morse »', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 1450 AND p.composer_id = 108
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:c10436e8-b8b4-4967-b331-0f1716329e29'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 13, part.movement_number = 'VI',
    part.name_ko = 'Trémolo', part.name_en = 'Mantra: VI. Trémolo',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 1450 AND p.composer_id = 108 AND part.part_key = 'musicbrainz:dcce9aea-2003-494c-bcfa-02990d75c78a' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:dcce9aea-2003-494c-bcfa-02990d75c78a', 13, 'VI', 'Trémolo', 'Mantra: VI. Trémolo', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 1450 AND p.composer_id = 108
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:dcce9aea-2003-494c-bcfa-02990d75c78a'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 14, part.movement_number = 'II',
    part.name_ko = 'Répétition régulière', part.name_en = 'Mantra: II. Répétition régulière',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 1450 AND p.composer_id = 108 AND part.part_key = 'musicbrainz:f7018b0d-796e-4726-91c3-81558e6497ca' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:f7018b0d-796e-4726-91c3-81558e6497ca', 14, 'II', 'Répétition régulière', 'Mantra: II. Répétition régulière', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 1450 AND p.composer_id = 108
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:f7018b0d-796e-4726-91c3-81558e6497ca'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 15, part.movement_number = 'VIII',
    part.name_ko = 'Accent au début', part.name_en = 'Mantra: VIII. Accent au début',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 1450 AND p.composer_id = 108 AND part.part_key = 'musicbrainz:fec235c2-6264-40c8-aae5-1046e71d1975' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:fec235c2-6264-40c8-aae5-1046e71d1975', 15, 'VIII', 'Accent au début', 'Mantra: VIII. Accent au début', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 1450 AND p.composer_id = 108
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:fec235c2-6264-40c8-aae5-1046e71d1975'
);


-- None Mikrophonie I für Tamtam, zwei Mikrophone, zwei Filter und Regler

UPDATE pieces piece
SET piece.title = 'Mikrophonie I für Tamtam, zwei Mikrophone, zwei Filter und Regler', piece.title_en = 'Mikrophonie I für Tamtam, zwei Mikrophone, zwei Filter und Regler',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 2804 AND piece.composer_id = 108
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Mikrophonie II für Chor, Hammondorgel und Ringmodulatoren

UPDATE pieces piece
SET piece.title = 'Mikrophonie II für Chor, Hammondorgel und Ringmodulatoren', piece.title_en = 'Mikrophonie II für Chor, Hammondorgel und Ringmodulatoren',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 959 AND piece.composer_id = 108
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Mixtur, Nr. 16

UPDATE pieces piece
SET piece.title = 'Mixtur, Nr. 16', piece.title_en = 'Mixtur, Nr. 16',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 1005 AND piece.composer_id = 108
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None 칸타타 <Momente, Nr. 13>

UPDATE pieces piece
SET piece.title = '칸타타 <Momente, Nr. 13>', piece.title_en = 'Momente, Nr. 13',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 2271 AND piece.composer_id = 108
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Musik im Bauch

UPDATE pieces piece
SET piece.title = 'Musik im Bauch', piece.title_en = 'Musik im Bauch',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 1288 AND piece.composer_id = 108
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'Formteil I', part.name_en = 'Musik im Bauch: Formteil I',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 1288 AND p.composer_id = 108 AND part.part_key = 'musicbrainz:76995ade-f7af-44e8-8e10-05449a7d02e4' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:76995ade-f7af-44e8-8e10-05449a7d02e4', 1, NULL, 'Formteil I', 'Musik im Bauch: Formteil I', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 1288 AND p.composer_id = 108
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:76995ade-f7af-44e8-8e10-05449a7d02e4'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'Formteil II', part.name_en = 'Musik im Bauch: Formteil II',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 1288 AND p.composer_id = 108 AND part.part_key = 'musicbrainz:764f67f7-2eb2-4497-b1f0-07aa9d44a209' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:764f67f7-2eb2-4497-b1f0-07aa9d44a209', 2, NULL, 'Formteil II', 'Musik im Bauch: Formteil II', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 1288 AND p.composer_id = 108
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:764f67f7-2eb2-4497-b1f0-07aa9d44a209'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = NULL,
    part.name_ko = 'Formteil III', part.name_en = 'Musik im Bauch: Formteil III',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 1288 AND p.composer_id = 108 AND part.part_key = 'musicbrainz:2e8aaeb0-53e6-4a3d-9e97-8e5659643771' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:2e8aaeb0-53e6-4a3d-9e97-8e5659643771', 3, NULL, 'Formteil III', 'Musik im Bauch: Formteil III', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 1288 AND p.composer_id = 108
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:2e8aaeb0-53e6-4a3d-9e97-8e5659643771'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = NULL,
    part.name_ko = 'Formteil IV', part.name_en = 'Musik im Bauch: Formteil IV',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 1288 AND p.composer_id = 108 AND part.part_key = 'musicbrainz:3afb8208-d8e6-47d4-87a1-2ecf8c23840f' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:3afb8208-d8e6-47d4-87a1-2ecf8c23840f', 4, NULL, 'Formteil IV', 'Musik im Bauch: Formteil IV', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 1288 AND p.composer_id = 108
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:3afb8208-d8e6-47d4-87a1-2ecf8c23840f'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 5, part.movement_number = NULL,
    part.name_ko = 'Formteil V', part.name_en = 'Musik im Bauch: Formteil V',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 1288 AND p.composer_id = 108 AND part.part_key = 'musicbrainz:731fba89-3892-4b48-aba9-0d6e4a890670' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:731fba89-3892-4b48-aba9-0d6e4a890670', 5, NULL, 'Formteil V', 'Musik im Bauch: Formteil V', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 1288 AND p.composer_id = 108
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:731fba89-3892-4b48-aba9-0d6e4a890670'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 6, part.movement_number = NULL,
    part.name_ko = 'Formteil VI', part.name_en = 'Musik im Bauch: Formteil VI',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 1288 AND p.composer_id = 108 AND part.part_key = 'musicbrainz:04d6e2a4-48c5-47e2-aaa3-3a5278089b97' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:04d6e2a4-48c5-47e2-aaa3-3a5278089b97', 6, NULL, 'Formteil VI', 'Musik im Bauch: Formteil VI', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 1288 AND p.composer_id = 108
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:04d6e2a4-48c5-47e2-aaa3-3a5278089b97'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 7, part.movement_number = NULL,
    part.name_ko = 'Formteil VII', part.name_en = 'Musik im Bauch: Formteil VII',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 1288 AND p.composer_id = 108 AND part.part_key = 'musicbrainz:c8961eb7-dcb4-44d6-90cf-4fc5cc0b7325' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:c8961eb7-dcb4-44d6-90cf-4fc5cc0b7325', 7, NULL, 'Formteil VII', 'Musik im Bauch: Formteil VII', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 1288 AND p.composer_id = 108
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:c8961eb7-dcb4-44d6-90cf-4fc5cc0b7325'
);


-- None Oktophonie

UPDATE pieces piece
SET piece.title = 'Oktophonie', piece.title_en = 'Oktophonie',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 1780 AND piece.composer_id = 108
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Plus-Minus, Nr. 14

UPDATE pieces piece
SET piece.title = 'Plus-Minus, Nr. 14', piece.title_en = 'Plus-Minus, Nr. 14',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 2220 AND piece.composer_id = 108
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Pole, Nr. 30

UPDATE pieces piece
SET piece.title = 'Pole, Nr. 30', piece.title_en = 'Pole, Nr. 30',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 2981 AND piece.composer_id = 108
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Punkte, Nr. 1/2

UPDATE pieces piece
SET piece.title = 'Punkte, Nr. 1/2', piece.title_en = 'Punkte, Nr. 1/2',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 1464 AND piece.composer_id = 108
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Refrain, Nr. 11

UPDATE pieces piece
SET piece.title = 'Refrain, Nr. 11', piece.title_en = 'Refrain, Nr. 11',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 1385 AND piece.composer_id = 108
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Schlagtrio, Nr. 1/3

UPDATE pieces piece
SET piece.title = 'Schlagtrio, Nr. 1/3', piece.title_en = 'Schlagtrio, Nr. 1/3',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 2204 AND piece.composer_id = 108
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Solo für Melodie-Instrument mit Rückkopplung

UPDATE pieces piece
SET piece.title = 'Solo für Melodie-Instrument mit Rückkopplung', piece.title_en = 'Solo für Melodie-Instrument mit Rückkopplung',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 1800 AND piece.composer_id = 108
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'II', part.name_en = 'Solo für Melodie‐Instrument mit Rückkopplung: II',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 1800 AND p.composer_id = 108 AND part.part_key = 'musicbrainz:4499014c-0bbf-48d4-bfc9-117332fd5277' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:4499014c-0bbf-48d4-bfc9-117332fd5277', 1, NULL, 'II', 'Solo für Melodie‐Instrument mit Rückkopplung: II', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 1800 AND p.composer_id = 108
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:4499014c-0bbf-48d4-bfc9-117332fd5277'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'I', part.name_en = 'Solo für Melodie‐Instrument mit Rückkopplung: I',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 1800 AND p.composer_id = 108 AND part.part_key = 'musicbrainz:cc5b0338-7134-4b44-9b74-15ef1f53d3ca' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:cc5b0338-7134-4b44-9b74-15ef1f53d3ca', 2, NULL, 'I', 'Solo für Melodie‐Instrument mit Rückkopplung: I', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 1800 AND p.composer_id = 108
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:cc5b0338-7134-4b44-9b74-15ef1f53d3ca'
);


-- None Solo, Nr. 19

UPDATE pieces piece
SET piece.title = 'Solo, Nr. 19', piece.title_en = 'Solo, Nr. 19',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 1331 AND piece.composer_id = 108
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None 소나티네 1번

UPDATE pieces piece
SET piece.title = '소나티네 1번', piece.title_en = 'Sonatine, Nr. 1/8',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 926 AND piece.composer_id = 108
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = '♩ = 50 | ♩ = 92-100 | ♩ = 50', part.name_en = 'Sonatine, Nr. 1/8: I. ♩ = 50 | ♩ = 92-100 | ♩ = 50',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 926 AND p.composer_id = 108 AND part.part_key = 'musicbrainz:6ae5c8d7-33f6-4135-96f6-482955e0b778' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:6ae5c8d7-33f6-4135-96f6-482955e0b778', 1, 'I', '♩ = 50 | ♩ = 92-100 | ♩ = 50', 'Sonatine, Nr. 1/8: I. ♩ = 50 | ♩ = 92-100 | ♩ = 50', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 926 AND p.composer_id = 108
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:6ae5c8d7-33f6-4135-96f6-482955e0b778'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = '♩ = 46', part.name_en = 'Sonatine, Nr. 1/8: II. ♩ = 46',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 926 AND p.composer_id = 108 AND part.part_key = 'musicbrainz:1c44b62d-4949-4e2b-92f4-8930f7410588' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:1c44b62d-4949-4e2b-92f4-8930f7410588', 2, 'II', '♩ = 46', 'Sonatine, Nr. 1/8: II. ♩ = 46', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 926 AND p.composer_id = 108
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:1c44b62d-4949-4e2b-92f4-8930f7410588'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = '♩ = 120', part.name_en = 'Sonatine, Nr. 1/8: III. ♩ = 120',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 926 AND p.composer_id = 108 AND part.part_key = 'musicbrainz:d7917f5a-788e-4253-86fd-6f76cfce1beb' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:d7917f5a-788e-4253-86fd-6f76cfce1beb', 3, 'III', '♩ = 120', 'Sonatine, Nr. 1/8: III. ♩ = 120', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 926 AND p.composer_id = 108
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:d7917f5a-788e-4253-86fd-6f76cfce1beb'
);


-- None Spiel

UPDATE pieces piece
SET piece.title = 'Spiel', piece.title_en = 'Spiel',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 2877 AND piece.composer_id = 108
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Spiral, Nr. 27

UPDATE pieces piece
SET piece.title = 'Spiral, Nr. 27', piece.title_en = 'Spiral, Nr. 27',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 2124 AND piece.composer_id = 108
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Stimmung, Nr. 24

UPDATE pieces piece
SET piece.title = 'Stimmung, Nr. 24', piece.title_en = 'Stimmung, Nr. 24',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 2431 AND piece.composer_id = 108
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Stop

UPDATE pieces piece
SET piece.title = 'Stop', piece.title_en = 'Stop',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 2936 AND piece.composer_id = 108
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Studie I

UPDATE pieces piece
SET piece.title = 'Studie I', piece.title_en = 'Studie I',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 1725 AND piece.composer_id = 108
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Studie II

UPDATE pieces piece
SET piece.title = 'Studie II', piece.title_en = 'Studie II',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 2711 AND piece.composer_id = 108
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Telemusik, Nr. 20

UPDATE pieces piece
SET piece.title = 'Telemusik, Nr. 20', piece.title_en = 'Telemusik, Nr. 20',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 1965 AND piece.composer_id = 108
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Tierkreis

UPDATE pieces piece
SET piece.title = 'Tierkreis', piece.title_en = 'Tierkreis',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 1184 AND piece.composer_id = 108
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'Aries', part.name_en = 'Tierkreis: Aries',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 1184 AND p.composer_id = 108 AND part.part_key = 'musicbrainz:06ffd9e9-9789-40d6-87dc-fe82c2421c3a' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:06ffd9e9-9789-40d6-87dc-fe82c2421c3a', 1, NULL, 'Aries', 'Tierkreis: Aries', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 1184 AND p.composer_id = 108
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:06ffd9e9-9789-40d6-87dc-fe82c2421c3a'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'Pisces', part.name_en = 'Tierkreis: Pisces',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 1184 AND p.composer_id = 108 AND part.part_key = 'musicbrainz:2483493d-7981-43c3-8467-1a551ce95c58' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:2483493d-7981-43c3-8467-1a551ce95c58', 2, NULL, 'Pisces', 'Tierkreis: Pisces', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 1184 AND p.composer_id = 108
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:2483493d-7981-43c3-8467-1a551ce95c58'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = NULL,
    part.name_ko = 'Capricorn', part.name_en = 'Tierkreis: Capricorn',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 1184 AND p.composer_id = 108 AND part.part_key = 'musicbrainz:34ee724b-1701-4134-86e4-96d1a6e9379b' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:34ee724b-1701-4134-86e4-96d1a6e9379b', 3, NULL, 'Capricorn', 'Tierkreis: Capricorn', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 1184 AND p.composer_id = 108
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:34ee724b-1701-4134-86e4-96d1a6e9379b'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = NULL,
    part.name_ko = 'Sagittarius', part.name_en = 'Tierkreis: Sagittarius',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 1184 AND p.composer_id = 108 AND part.part_key = 'musicbrainz:49621840-d5ce-4382-a18c-f95105f8631c' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:49621840-d5ce-4382-a18c-f95105f8631c', 4, NULL, 'Sagittarius', 'Tierkreis: Sagittarius', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 1184 AND p.composer_id = 108
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:49621840-d5ce-4382-a18c-f95105f8631c'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 5, part.movement_number = NULL,
    part.name_ko = 'Libra', part.name_en = 'Tierkreis: Libra',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 1184 AND p.composer_id = 108 AND part.part_key = 'musicbrainz:61385ee9-5e87-4f51-8d63-0d673ef06751' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:61385ee9-5e87-4f51-8d63-0d673ef06751', 5, NULL, 'Libra', 'Tierkreis: Libra', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 1184 AND p.composer_id = 108
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:61385ee9-5e87-4f51-8d63-0d673ef06751'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 6, part.movement_number = NULL,
    part.name_ko = 'Virgo', part.name_en = 'Tierkreis: Virgo',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 1184 AND p.composer_id = 108 AND part.part_key = 'musicbrainz:6af93926-c07c-44bf-8566-f337d9423c76' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:6af93926-c07c-44bf-8566-f337d9423c76', 6, NULL, 'Virgo', 'Tierkreis: Virgo', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 1184 AND p.composer_id = 108
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:6af93926-c07c-44bf-8566-f337d9423c76'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 7, part.movement_number = NULL,
    part.name_ko = 'Scorpio', part.name_en = 'Tierkreis: Scorpio',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 1184 AND p.composer_id = 108 AND part.part_key = 'musicbrainz:6e9fde99-4cbc-4dee-bbd6-9a4d2659c591' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:6e9fde99-4cbc-4dee-bbd6-9a4d2659c591', 7, NULL, 'Scorpio', 'Tierkreis: Scorpio', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 1184 AND p.composer_id = 108
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:6e9fde99-4cbc-4dee-bbd6-9a4d2659c591'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 8, part.movement_number = NULL,
    part.name_ko = 'Aquarius', part.name_en = 'Tierkreis: Aquarius',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 1184 AND p.composer_id = 108 AND part.part_key = 'musicbrainz:882968a8-e075-4dad-afbf-f12ed7b162c8' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:882968a8-e075-4dad-afbf-f12ed7b162c8', 8, NULL, 'Aquarius', 'Tierkreis: Aquarius', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 1184 AND p.composer_id = 108
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:882968a8-e075-4dad-afbf-f12ed7b162c8'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 9, part.movement_number = NULL,
    part.name_ko = 'Gemini', part.name_en = 'Tierkreis: Gemini',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 1184 AND p.composer_id = 108 AND part.part_key = 'musicbrainz:c064a6f4-818e-4931-8385-1c683976c845' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:c064a6f4-818e-4931-8385-1c683976c845', 9, NULL, 'Gemini', 'Tierkreis: Gemini', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 1184 AND p.composer_id = 108
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:c064a6f4-818e-4931-8385-1c683976c845'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 10, part.movement_number = NULL,
    part.name_ko = 'Taurus', part.name_en = 'Tierkreis: Taurus',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 1184 AND p.composer_id = 108 AND part.part_key = 'musicbrainz:df8e56c3-7114-4d16-bf73-8ac29a205656' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:df8e56c3-7114-4d16-bf73-8ac29a205656', 10, NULL, 'Taurus', 'Tierkreis: Taurus', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 1184 AND p.composer_id = 108
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:df8e56c3-7114-4d16-bf73-8ac29a205656'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 11, part.movement_number = NULL,
    part.name_ko = 'Leo', part.name_en = 'Tierkreis: Leo',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 1184 AND p.composer_id = 108 AND part.part_key = 'musicbrainz:e4bc9141-12ac-4bdd-a8e0-c26424c5a6e4' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:e4bc9141-12ac-4bdd-a8e0-c26424c5a6e4', 11, NULL, 'Leo', 'Tierkreis: Leo', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 1184 AND p.composer_id = 108
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:e4bc9141-12ac-4bdd-a8e0-c26424c5a6e4'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 12, part.movement_number = NULL,
    part.name_ko = 'Cancer', part.name_en = 'Tierkreis: Cancer',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 1184 AND p.composer_id = 108 AND part.part_key = 'musicbrainz:ed6eb519-9e3a-4753-995d-3b5f26c83e6e' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:ed6eb519-9e3a-4753-995d-3b5f26c83e6e', 12, NULL, 'Cancer', 'Tierkreis: Cancer', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 1184 AND p.composer_id = 108
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:ed6eb519-9e3a-4753-995d-3b5f26c83e6e'
);


-- None Zeitmasze, Nr. 5

UPDATE pieces piece
SET piece.title = 'Zeitmasze, Nr. 5', piece.title_en = 'Zeitmasze, Nr. 5',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 2774 AND piece.composer_id = 108
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Zyklus, Nr. 9

UPDATE pieces piece
SET piece.title = 'Zyklus, Nr. 9', piece.title_en = 'Zyklus, Nr. 9',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 1087 AND piece.composer_id = 108
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None 연습곡

UPDATE pieces piece
SET piece.title = '연습곡', piece.title_en = 'Étude',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 2413 AND piece.composer_id = 108
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None 오페라 <Dienstag aus Licht>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '오페라 <Dienstag aus Licht>', 'Dienstag aus Licht', 'song', NULL, NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 108
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '오페라 <Dienstag aus Licht>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'd1521f3b-4daa-4d84-ad36-5d19cf8ee005'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'd1521f3b-4daa-4d84-ad36-5d19cf8ee005'
FROM pieces p
WHERE p.composer_id = 108 AND p.title = '오페라 <Dienstag aus Licht>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'd1521f3b-4daa-4d84-ad36-5d19cf8ee005'
);


-- None 오페라 <Montag aus Licht>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '오페라 <Montag aus Licht>', 'Montag aus Licht', 'album', NULL, NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 108
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '오페라 <Montag aus Licht>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '98201b7f-6ecc-4be8-8f63-48a01d1800f6'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '98201b7f-6ecc-4be8-8f63-48a01d1800f6'
FROM pieces p
WHERE p.composer_id = 108 AND p.title = '오페라 <Montag aus Licht>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '98201b7f-6ecc-4be8-8f63-48a01d1800f6'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:39286927-5368-4290-b88f-fc42d57c0144', 1, NULL, 'Ave', 'Montag aus Licht: Ave', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 108 AND p.title = '오페라 <Montag aus Licht>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:39286927-5368-4290-b88f-fc42d57c0144'
);


-- 카탈로그에 대응이 없는 seed 작품 8개를 목록에서 숨긴다(지우지 않음).
UPDATE pieces piece
SET piece.hidden_reason = 'catalog_unmatched'
WHERE piece.composer_id = 108 AND piece.origin = 'seed' AND piece.hidden_reason IS NULL
  AND piece.id IN (
    1111, 1325, 1422, 1795, 1987, 2058, 2499, 2982
  )
  AND NOT EXISTS (SELECT 1 FROM performance_sectors sector WHERE sector.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM piece_parts linking WHERE linking.linked_piece_id = piece.id);
