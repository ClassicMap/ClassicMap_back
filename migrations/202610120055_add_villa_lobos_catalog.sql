-- 빌라로부스 작품을 MusicBrainz 작품 구조로 다시 짠다(4차 자동). 작품 201개(묶음 34, 다악장 87, 낱곡 80),
-- 새 작품 12개, part 550개, 그 아래 49개.
-- seed 238개 중 189개를 작품·part 에 잇고, 48개를 숨기고, 1개는 그대로 둔다.
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
SET piece.title = 'Choros nº 1 (편곡 9127)'
WHERE piece.id = 9127 AND piece.composer_id = 105 AND piece.title = 'Choros nº 1'
  AND piece.origin = 'seed' AND piece.editor_locked = 0
  AND NOT EXISTS (SELECT 1 FROM performance_sectors sector WHERE sector.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM piece_parts linking WHERE linking.linked_piece_id = piece.id);

UPDATE pieces piece
SET piece.title = 'Choros nº 5 "Alma brasileira" (편곡 9575)'
WHERE piece.id = 9575 AND piece.composer_id = 105 AND piece.title = 'Choros nº 5 "Alma brasileira"'
  AND piece.origin = 'seed' AND piece.editor_locked = 0
  AND NOT EXISTS (SELECT 1 FROM performance_sectors sector WHERE sector.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM piece_parts linking WHERE linking.linked_piece_id = piece.id);

UPDATE pieces piece
SET piece.title = 'Cortejo nupcial (중복 9769)'
WHERE piece.id = 9769 AND piece.composer_id = 105 AND piece.title = 'Cortejo nupcial'
  AND piece.origin = 'seed' AND piece.editor_locked = 0
  AND NOT EXISTS (SELECT 1 FROM performance_sectors sector WHERE sector.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM piece_parts linking WHERE linking.linked_piece_id = piece.id);

UPDATE pieces piece
SET piece.title = 'Martírio dos insetos (편곡 9849)'
WHERE piece.id = 9849 AND piece.composer_id = 105 AND piece.title = 'Martírio dos insetos'
  AND piece.origin = 'seed' AND piece.editor_locked = 0
  AND NOT EXISTS (SELECT 1 FROM performance_sectors sector WHERE sector.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM piece_parts linking WHERE linking.linked_piece_id = piece.id);


-- W 235 12 estudos W 235

UPDATE pieces piece
SET piece.title = '12 estudos W 235', piece.title_en = '12 estudos, W235',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = 'W', piece.catalogue_number = '235',
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 8355 AND piece.composer_id = 105
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'Allegro non troppo - arpejos', part.name_en = '12 estudos, W235, nº 1: Allegro non troppo - arpejos',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 8355 AND p.composer_id = 105 AND part.part_key = 'musicbrainz:f9a519eb-429a-3741-9fc1-568bc294b872' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:f9a519eb-429a-3741-9fc1-568bc294b872', 1, NULL, 'Allegro non troppo - arpejos', '12 estudos, W235, nº 1: Allegro non troppo - arpejos', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 8355 AND p.composer_id = 105
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:f9a519eb-429a-3741-9fc1-568bc294b872'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'Allegro - arpejos', part.name_en = '12 estudos, W235, nº 2: Allegro - arpejos',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 8355 AND p.composer_id = 105 AND part.part_key = 'musicbrainz:6022716a-dab6-3cc2-a2ab-5f99baca49de' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:6022716a-dab6-3cc2-a2ab-5f99baca49de', 2, NULL, 'Allegro - arpejos', '12 estudos, W235, nº 2: Allegro - arpejos', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 8355 AND p.composer_id = 105
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:6022716a-dab6-3cc2-a2ab-5f99baca49de'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = NULL,
    part.name_ko = 'Allegro moderato - arpejos', part.name_en = '12 estudos, W235, nº 3: Allegro moderato - arpejos',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 8355 AND p.composer_id = 105 AND part.part_key = 'musicbrainz:0c40768f-e1bf-3694-b7f8-56ebb9b49d6c' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:0c40768f-e1bf-3694-b7f8-56ebb9b49d6c', 3, NULL, 'Allegro moderato - arpejos', '12 estudos, W235, nº 3: Allegro moderato - arpejos', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 8355 AND p.composer_id = 105
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:0c40768f-e1bf-3694-b7f8-56ebb9b49d6c'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = NULL,
    part.name_ko = 'Un peu modéré - acordes repetidos', part.name_en = '12 estudos, W235, nº 4: Un peu modéré - acordes repetidos',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 8355 AND p.composer_id = 105 AND part.part_key = 'musicbrainz:cea864eb-846b-3cf2-8e75-1864289ad26f' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:cea864eb-846b-3cf2-8e75-1864289ad26f', 4, NULL, 'Un peu modéré - acordes repetidos', '12 estudos, W235, nº 4: Un peu modéré - acordes repetidos', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 8355 AND p.composer_id = 105
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:cea864eb-846b-3cf2-8e75-1864289ad26f'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 5, part.movement_number = NULL,
    part.name_ko = 'Andantino', part.name_en = '12 estudos, W235, nº 5: Andantino',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 8355 AND p.composer_id = 105 AND part.part_key = 'musicbrainz:6c1e9ec1-7afe-39a5-8c4c-8933006d38fa' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:6c1e9ec1-7afe-39a5-8c4c-8933006d38fa', 5, NULL, 'Andantino', '12 estudos, W235, nº 5: Andantino', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 8355 AND p.composer_id = 105
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:6c1e9ec1-7afe-39a5-8c4c-8933006d38fa'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 6, part.movement_number = NULL,
    part.name_ko = 'Poco allegro', part.name_en = '12 estudos, W235, nº 6: Poco allegro',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 8355 AND p.composer_id = 105 AND part.part_key = 'musicbrainz:f1c108d1-aca1-3af1-9c0c-6feb338fbde3' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:f1c108d1-aca1-3af1-9c0c-6feb338fbde3', 6, NULL, 'Poco allegro', '12 estudos, W235, nº 6: Poco allegro', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 8355 AND p.composer_id = 105
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:f1c108d1-aca1-3af1-9c0c-6feb338fbde3'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 7, part.movement_number = NULL,
    part.name_ko = 'Très animé', part.name_en = '12 estudos, W235, nº 7: Très animé',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 8355 AND p.composer_id = 105 AND part.part_key = 'musicbrainz:1faafd91-deaa-31d1-902e-d25d8fd370bc' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:1faafd91-deaa-31d1-902e-d25d8fd370bc', 7, NULL, 'Très animé', '12 estudos, W235, nº 7: Très animé', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 8355 AND p.composer_id = 105
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:1faafd91-deaa-31d1-902e-d25d8fd370bc'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 8, part.movement_number = NULL,
    part.name_ko = 'Modéré - Lent', part.name_en = '12 estudos, W235, nº 8: Modéré - Lent',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 8355 AND p.composer_id = 105 AND part.part_key = 'musicbrainz:93143806-2e7e-3652-9d21-af59bb8857e3' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:93143806-2e7e-3652-9d21-af59bb8857e3', 8, NULL, 'Modéré - Lent', '12 estudos, W235, nº 8: Modéré - Lent', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 8355 AND p.composer_id = 105
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:93143806-2e7e-3652-9d21-af59bb8857e3'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 9, part.movement_number = NULL,
    part.name_ko = 'Très peu animé', part.name_en = '12 estudos, W235, nº 9: Très peu animé',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 8355 AND p.composer_id = 105 AND part.part_key = 'musicbrainz:9a13cb9e-ceeb-3e20-85e9-ca86e5ae992d' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:9a13cb9e-ceeb-3e20-85e9-ca86e5ae992d', 9, NULL, 'Très peu animé', '12 estudos, W235, nº 9: Très peu animé', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 8355 AND p.composer_id = 105
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:9a13cb9e-ceeb-3e20-85e9-ca86e5ae992d'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 10, part.movement_number = NULL,
    part.name_ko = 'Très animé - Vif', part.name_en = '12 estudos, W235, nº 10: Très animé - Vif',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 8355 AND p.composer_id = 105 AND part.part_key = 'musicbrainz:44f64532-f35d-3062-b371-8c58cf05d16a' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:44f64532-f35d-3062-b371-8c58cf05d16a', 10, NULL, 'Très animé - Vif', '12 estudos, W235, nº 10: Très animé - Vif', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 8355 AND p.composer_id = 105
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:44f64532-f35d-3062-b371-8c58cf05d16a'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 11, part.movement_number = NULL,
    part.name_ko = 'Lent - Più mosso - Animé', part.name_en = '12 estudos, W235, nº 11: Lent - Più mosso - Animé',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 8355 AND p.composer_id = 105 AND part.part_key = 'musicbrainz:13c36b23-68f5-3b7f-8e2d-9d67c213d2bc' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:13c36b23-68f5-3b7f-8e2d-9d67c213d2bc', 11, NULL, 'Lent - Più mosso - Animé', '12 estudos, W235, nº 11: Lent - Più mosso - Animé', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 8355 AND p.composer_id = 105
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:13c36b23-68f5-3b7f-8e2d-9d67c213d2bc'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 12, part.movement_number = NULL,
    part.name_ko = 'Animé - Più mosso - Un peu plus animé', part.name_en = '12 estudos, W235, nº 12: Animé - Più mosso - Un peu plus animé',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 8355 AND p.composer_id = 105 AND part.part_key = 'musicbrainz:d578652f-7170-481c-8bcb-76669584a100' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:d578652f-7170-481c-8bcb-76669584a100', 12, NULL, 'Animé - Più mosso - Un peu plus animé', '12 estudos, W235, nº 12: Animé - Più mosso - Un peu plus animé', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 8355 AND p.composer_id = 105
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:d578652f-7170-481c-8bcb-76669584a100'
);


-- W 227 2 choros bis

UPDATE pieces piece
SET piece.title = '2 choros bis', piece.title_en = '2 choros bis, W227',
    piece.type = 'album', piece.opus_number = 'W 227',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 10142 AND piece.composer_id = 105
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'Modéré', part.name_en = '2 choros bis, W227: I. Modéré',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 10142 AND p.composer_id = 105 AND part.part_key = 'musicbrainz:8308e819-31ae-44f3-a7cb-47d5d4d6f440' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:8308e819-31ae-44f3-a7cb-47d5d4d6f440', 1, 'I', 'Modéré', '2 choros bis, W227: I. Modéré', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 10142 AND p.composer_id = 105
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:8308e819-31ae-44f3-a7cb-47d5d4d6f440'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'Lent', part.name_en = '2 choros bis, W227: II. Lent',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 10142 AND p.composer_id = 105 AND part.part_key = 'musicbrainz:317ee37a-beb6-4ebb-af41-def4ae8d5099' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:317ee37a-beb6-4ebb-af41-def4ae8d5099', 2, 'II', 'Lent', '2 choros bis, W227: II. Lent', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 10142 AND p.composer_id = 105
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:317ee37a-beb6-4ebb-af41-def4ae8d5099'
);


-- W 176 A fiandeira

UPDATE pieces piece
SET piece.title = 'A fiandeira', piece.title_en = 'A fiandeira, W176',
    piece.type = 'song', piece.opus_number = 'W 176',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 10754 AND piece.composer_id = 105
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- W 166 A lenda do caboclo

UPDATE pieces piece
SET piece.title = 'A lenda do caboclo', piece.title_en = 'A lenda do caboclo, W166',
    piece.type = 'song', piece.opus_number = 'W 166',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 8481 AND piece.composer_id = 105
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- W 540 오페라 <A menina das nuvens> W 540

UPDATE pieces piece
SET piece.title = '오페라 <A menina das nuvens> W 540', piece.title_en = 'A menina das nuvens, W540',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = 'W', piece.catalogue_number = '540',
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 9033 AND piece.composer_id = 105
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'Valsa', part.name_en = 'A menina das nuvens, W540: Valsa',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 9033 AND p.composer_id = 105 AND part.part_key = 'musicbrainz:e29438ad-9e1e-43e0-b0c1-8a9801d8107f' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:e29438ad-9e1e-43e0-b0c1-8a9801d8107f', 1, NULL, 'Valsa', 'A menina das nuvens, W540: Valsa', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 9033 AND p.composer_id = 105
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:e29438ad-9e1e-43e0-b0c1-8a9801d8107f'
);


-- W 513 Alvorada na floresta tropical

UPDATE pieces piece
SET piece.title = 'Alvorada na floresta tropical', piece.title_en = 'Alvorada na floresta tropical, W513',
    piece.type = 'song', piece.opus_number = 'W 513',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 7430 AND piece.composer_id = 105
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- W 118 발레 <Amazonas>

UPDATE pieces piece
SET piece.title = '발레 <Amazonas>', piece.title_en = 'Amazonas, W118',
    piece.type = 'song', piece.opus_number = 'W 118',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 9807 AND piece.composer_id = 105
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- W 135 가곡 <Amor y perfidia>

UPDATE pieces piece
SET piece.title = '가곡 <Amor y perfidia>', piece.title_en = 'Amor y perfidia, W135',
    piece.type = 'song', piece.opus_number = 'W 135',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 10026 AND piece.composer_id = 105
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- W 411 As três Marias W 411

UPDATE pieces piece
SET piece.title = 'As três Marias W 411', piece.title_en = 'As três Marias, W411',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = 'W', piece.catalogue_number = '411',
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 10249 AND piece.composer_id = 105
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'Alnitah', part.name_en = 'As três Marias, W411, nº 1: Alnitah',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 10249 AND p.composer_id = 105 AND part.part_key = 'musicbrainz:c1095f62-a5b2-3ad4-9713-304295d3ac89' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:c1095f62-a5b2-3ad4-9713-304295d3ac89', 1, NULL, 'Alnitah', 'As três Marias, W411, nº 1: Alnitah', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 10249 AND p.composer_id = 105
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:c1095f62-a5b2-3ad4-9713-304295d3ac89'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'Alnilam', part.name_en = 'As três Marias, W411, nº 2: Alnilam',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 10249 AND p.composer_id = 105 AND part.part_key = 'musicbrainz:8b894998-840e-30b3-b68c-861f38499481' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:8b894998-840e-30b3-b68c-861f38499481', 2, NULL, 'Alnilam', 'As três Marias, W411, nº 2: Alnilam', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 10249 AND p.composer_id = 105
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:8b894998-840e-30b3-b68c-861f38499481'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = NULL,
    part.name_ko = 'Mintika', part.name_en = 'As três Marias, W411, nº 3: Mintika',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 10249 AND p.composer_id = 105 AND part.part_key = 'musicbrainz:071ee3d3-55f9-337f-8b8e-512d8af36d1f' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:071ee3d3-55f9-337f-8b8e-512d8af36d1f', 3, NULL, 'Mintika', 'As três Marias, W411, nº 3: Mintika', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 10249 AND p.composer_id = 105
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:071ee3d3-55f9-337f-8b8e-512d8af36d1f'
);


-- W 493 Assobio a játo

UPDATE pieces piece
SET piece.title = 'Assobio a játo', piece.title_en = 'Assobio a játo, W493',
    piece.type = 'album', piece.opus_number = 'W 493',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 10375 AND piece.composer_id = 105
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'Allegro non troppo', part.name_en = 'Assobio a játo, W493: I. Allegro non troppo',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 10375 AND p.composer_id = 105 AND part.part_key = 'musicbrainz:d6af1af1-a379-46ce-9d1e-c57b5c21d207' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:d6af1af1-a379-46ce-9d1e-c57b5c21d207', 1, 'I', 'Allegro non troppo', 'Assobio a játo, W493: I. Allegro non troppo', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 10375 AND p.composer_id = 105
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:d6af1af1-a379-46ce-9d1e-c57b5c21d207'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'Adagio', part.name_en = 'Assobio a játo, W493: II. Adagio',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 10375 AND p.composer_id = 105 AND part.part_key = 'musicbrainz:966956e2-b182-4cb7-ad22-10ae015e1eee' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:966956e2-b182-4cb7-ad22-10ae015e1eee', 2, 'II', 'Adagio', 'Assobio a játo, W493: II. Adagio', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 10375 AND p.composer_id = 105
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:966956e2-b182-4cb7-ad22-10ae015e1eee'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = 'Vivo', part.name_en = 'Assobio a játo, W493: III. Vivo',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 10375 AND p.composer_id = 105 AND part.part_key = 'musicbrainz:4cb39e77-3579-4870-be02-dd8a0425561d' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:4cb39e77-3579-4870-be02-dd8a0425561d', 3, 'III', 'Vivo', 'Assobio a játo, W493: III. Vivo', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 10375 AND p.composer_id = 105
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:4cb39e77-3579-4870-be02-dd8a0425561d'
);


-- None Bachianas Brasileiras

UPDATE pieces piece
SET piece.title = 'Bachianas Brasileiras', piece.title_en = 'Bachianas Brasileiras',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 10243 AND piece.composer_id = 105
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'Bachianas Brasileiras nº 1, W246', part.name_en = 'Bachianas Brasileiras nº 1, W246',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 10243 AND p.composer_id = 105 AND part.part_key = 'musicbrainz:785739db-b30e-4eea-8408-3e09da889426' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:785739db-b30e-4eea-8408-3e09da889426', 1, NULL, 'Bachianas Brasileiras nº 1, W246', 'Bachianas Brasileiras nº 1, W246', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 10243 AND p.composer_id = 105
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:785739db-b30e-4eea-8408-3e09da889426'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:785739db-b30e-4eea-8408-3e09da889426'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'Introdução (Embolada)', part.name_en = 'Bachianas Brasileiras nº 1, W246: I. Introdução (Embolada)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 10243 AND p.composer_id = 105 AND part.part_key = 'musicbrainz:16be06ab-3296-4d8f-b95f-ddd52cf85780' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:16be06ab-3296-4d8f-b95f-ddd52cf85780', 1, NULL, 'Introdução (Embolada)', 'Bachianas Brasileiras nº 1, W246: I. Introdução (Embolada)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:785739db-b30e-4eea-8408-3e09da889426'
WHERE p.id = 10243 AND p.composer_id = 105
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:16be06ab-3296-4d8f-b95f-ddd52cf85780'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:785739db-b30e-4eea-8408-3e09da889426'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'Prelúdio (Modinha)', part.name_en = 'Bachianas Brasileiras nº 1, W246: II. Prelúdio (Modinha)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 10243 AND p.composer_id = 105 AND part.part_key = 'musicbrainz:ae139d92-9b63-3799-9937-1758b30f6ae9' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:ae139d92-9b63-3799-9937-1758b30f6ae9', 2, NULL, 'Prelúdio (Modinha)', 'Bachianas Brasileiras nº 1, W246: II. Prelúdio (Modinha)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:785739db-b30e-4eea-8408-3e09da889426'
WHERE p.id = 10243 AND p.composer_id = 105
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:ae139d92-9b63-3799-9937-1758b30f6ae9'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:785739db-b30e-4eea-8408-3e09da889426'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = NULL,
    part.name_ko = 'Fuga (Conversa)', part.name_en = 'Bachianas Brasileiras nº 1, W246: III. Fuga (Conversa)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 10243 AND p.composer_id = 105 AND part.part_key = 'musicbrainz:9bb805d8-6729-47b0-905b-5721797dfdf8' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:9bb805d8-6729-47b0-905b-5721797dfdf8', 3, NULL, 'Fuga (Conversa)', 'Bachianas Brasileiras nº 1, W246: III. Fuga (Conversa)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:785739db-b30e-4eea-8408-3e09da889426'
WHERE p.id = 10243 AND p.composer_id = 105
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:9bb805d8-6729-47b0-905b-5721797dfdf8'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'Bachianas Brasileiras nº 2, W247', part.name_en = 'Bachianas Brasileiras nº 2, W247',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 10243 AND p.composer_id = 105 AND part.part_key = 'musicbrainz:6e00461c-3b29-40c4-b26b-a82760945b67' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:6e00461c-3b29-40c4-b26b-a82760945b67', 2, NULL, 'Bachianas Brasileiras nº 2, W247', 'Bachianas Brasileiras nº 2, W247', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 10243 AND p.composer_id = 105
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:6e00461c-3b29-40c4-b26b-a82760945b67'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:6e00461c-3b29-40c4-b26b-a82760945b67'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'Prelúdio (O canto do capadócio)', part.name_en = 'Bachianas Brasileiras nº 2, W247: I. Prelúdio (O canto do capadócio)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 10243 AND p.composer_id = 105 AND part.part_key = 'musicbrainz:eaee50e6-2785-40c5-bf9a-42e88f2728a2' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:eaee50e6-2785-40c5-bf9a-42e88f2728a2', 1, NULL, 'Prelúdio (O canto do capadócio)', 'Bachianas Brasileiras nº 2, W247: I. Prelúdio (O canto do capadócio)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:6e00461c-3b29-40c4-b26b-a82760945b67'
WHERE p.id = 10243 AND p.composer_id = 105
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:eaee50e6-2785-40c5-bf9a-42e88f2728a2'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:6e00461c-3b29-40c4-b26b-a82760945b67'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'Ária (O canto da nossa terra)', part.name_en = 'Bachianas Brasileiras nº 2, W247: II. Ária (O canto da nossa terra)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 10243 AND p.composer_id = 105 AND part.part_key = 'musicbrainz:33d54437-294e-4aa3-a324-4fd44aeee372' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:33d54437-294e-4aa3-a324-4fd44aeee372', 2, NULL, 'Ária (O canto da nossa terra)', 'Bachianas Brasileiras nº 2, W247: II. Ária (O canto da nossa terra)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:6e00461c-3b29-40c4-b26b-a82760945b67'
WHERE p.id = 10243 AND p.composer_id = 105
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:33d54437-294e-4aa3-a324-4fd44aeee372'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:6e00461c-3b29-40c4-b26b-a82760945b67'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = NULL,
    part.name_ko = 'Dansa (Lembrança do sertão)', part.name_en = 'Bachianas Brasileiras nº 2, W247: III. Dansa (Lembrança do sertão)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 10243 AND p.composer_id = 105 AND part.part_key = 'musicbrainz:af9dfb8c-15bc-356e-b38b-9a23a84c5a76' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:af9dfb8c-15bc-356e-b38b-9a23a84c5a76', 3, NULL, 'Dansa (Lembrança do sertão)', 'Bachianas Brasileiras nº 2, W247: III. Dansa (Lembrança do sertão)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:6e00461c-3b29-40c4-b26b-a82760945b67'
WHERE p.id = 10243 AND p.composer_id = 105
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:af9dfb8c-15bc-356e-b38b-9a23a84c5a76'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:6e00461c-3b29-40c4-b26b-a82760945b67'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = NULL,
    part.name_ko = 'Toccata (O trenzinho do caipira)', part.name_en = 'Bachianas Brasileiras nº 2, W247: IV. Toccata (O trenzinho do caipira)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 10243 AND p.composer_id = 105 AND part.part_key = 'musicbrainz:d15e9ee3-90e4-4d05-b47d-e8dfb0380385' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:d15e9ee3-90e4-4d05-b47d-e8dfb0380385', 4, NULL, 'Toccata (O trenzinho do caipira)', 'Bachianas Brasileiras nº 2, W247: IV. Toccata (O trenzinho do caipira)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:6e00461c-3b29-40c4-b26b-a82760945b67'
WHERE p.id = 10243 AND p.composer_id = 105
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:d15e9ee3-90e4-4d05-b47d-e8dfb0380385'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = NULL,
    part.name_ko = 'Bachianas Brasileiras nº 3, W388', part.name_en = 'Bachianas Brasileiras nº 3, W388',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 10243 AND p.composer_id = 105 AND part.part_key = 'musicbrainz:151f329a-b3d9-4a37-a864-ae2be70dff4c' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:151f329a-b3d9-4a37-a864-ae2be70dff4c', 3, NULL, 'Bachianas Brasileiras nº 3, W388', 'Bachianas Brasileiras nº 3, W388', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 10243 AND p.composer_id = 105
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:151f329a-b3d9-4a37-a864-ae2be70dff4c'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:151f329a-b3d9-4a37-a864-ae2be70dff4c'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'Prelúdio (Ponteio)', part.name_en = 'Bachianas Brasileiras nº 3, W388: I. Prelúdio (Ponteio)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 10243 AND p.composer_id = 105 AND part.part_key = 'musicbrainz:770b7b55-2e3b-4c17-b892-9157b0403b18' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:770b7b55-2e3b-4c17-b892-9157b0403b18', 1, NULL, 'Prelúdio (Ponteio)', 'Bachianas Brasileiras nº 3, W388: I. Prelúdio (Ponteio)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:151f329a-b3d9-4a37-a864-ae2be70dff4c'
WHERE p.id = 10243 AND p.composer_id = 105
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:770b7b55-2e3b-4c17-b892-9157b0403b18'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:151f329a-b3d9-4a37-a864-ae2be70dff4c'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'Fantasia (Devaneio)', part.name_en = 'Bachianas Brasileiras nº 3, W388: II. Fantasia (Devaneio)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 10243 AND p.composer_id = 105 AND part.part_key = 'musicbrainz:131a4537-3af0-41e2-9101-a14def5722a6' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:131a4537-3af0-41e2-9101-a14def5722a6', 2, NULL, 'Fantasia (Devaneio)', 'Bachianas Brasileiras nº 3, W388: II. Fantasia (Devaneio)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:151f329a-b3d9-4a37-a864-ae2be70dff4c'
WHERE p.id = 10243 AND p.composer_id = 105
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:131a4537-3af0-41e2-9101-a14def5722a6'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:151f329a-b3d9-4a37-a864-ae2be70dff4c'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = NULL,
    part.name_ko = 'Ária (Modinha)', part.name_en = 'Bachianas Brasileiras nº 3, W388: III. Ária (Modinha)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 10243 AND p.composer_id = 105 AND part.part_key = 'musicbrainz:432d84c1-e1c8-49a7-a45d-14e60d2f7022' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:432d84c1-e1c8-49a7-a45d-14e60d2f7022', 3, NULL, 'Ária (Modinha)', 'Bachianas Brasileiras nº 3, W388: III. Ária (Modinha)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:151f329a-b3d9-4a37-a864-ae2be70dff4c'
WHERE p.id = 10243 AND p.composer_id = 105
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:432d84c1-e1c8-49a7-a45d-14e60d2f7022'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:151f329a-b3d9-4a37-a864-ae2be70dff4c'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = NULL,
    part.name_ko = 'Tocata (Picapau)', part.name_en = 'Bachianas Brasileiras nº 3, W388: IV. Tocata (Picapau)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 10243 AND p.composer_id = 105 AND part.part_key = 'musicbrainz:779f7cd9-d364-40cb-b16e-85852fc6d65d' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:779f7cd9-d364-40cb-b16e-85852fc6d65d', 4, NULL, 'Tocata (Picapau)', 'Bachianas Brasileiras nº 3, W388: IV. Tocata (Picapau)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:151f329a-b3d9-4a37-a864-ae2be70dff4c'
WHERE p.id = 10243 AND p.composer_id = 105
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:779f7cd9-d364-40cb-b16e-85852fc6d65d'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = NULL,
    part.name_ko = 'Bachianas Brasileiras nº 4, W264', part.name_en = 'Bachianas Brasileiras nº 4, W264',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 10243 AND p.composer_id = 105 AND part.part_key = 'musicbrainz:9f03473d-ca0d-4414-aa6a-cc3f8b6af1db' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:9f03473d-ca0d-4414-aa6a-cc3f8b6af1db', 4, NULL, 'Bachianas Brasileiras nº 4, W264', 'Bachianas Brasileiras nº 4, W264', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 10243 AND p.composer_id = 105
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:9f03473d-ca0d-4414-aa6a-cc3f8b6af1db'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:9f03473d-ca0d-4414-aa6a-cc3f8b6af1db'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'Prelúdio (Introdução)', part.name_en = 'Bachianas Brasileiras nº 4, W264: I. Prelúdio (Introdução)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 10243 AND p.composer_id = 105 AND part.part_key = 'musicbrainz:ffd95a2d-a040-4b3a-956a-0399f45a0a0b' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:ffd95a2d-a040-4b3a-956a-0399f45a0a0b', 1, NULL, 'Prelúdio (Introdução)', 'Bachianas Brasileiras nº 4, W264: I. Prelúdio (Introdução)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:9f03473d-ca0d-4414-aa6a-cc3f8b6af1db'
WHERE p.id = 10243 AND p.composer_id = 105
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:ffd95a2d-a040-4b3a-956a-0399f45a0a0b'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:9f03473d-ca0d-4414-aa6a-cc3f8b6af1db'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'Coral (Canto do sertão)', part.name_en = 'Bachianas Brasileiras nº 4, W264: II. Coral (Canto do sertão)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 10243 AND p.composer_id = 105 AND part.part_key = 'musicbrainz:10e2e000-6bd9-43d1-a3cf-d64e7271dce7' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:10e2e000-6bd9-43d1-a3cf-d64e7271dce7', 2, NULL, 'Coral (Canto do sertão)', 'Bachianas Brasileiras nº 4, W264: II. Coral (Canto do sertão)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:9f03473d-ca0d-4414-aa6a-cc3f8b6af1db'
WHERE p.id = 10243 AND p.composer_id = 105
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:10e2e000-6bd9-43d1-a3cf-d64e7271dce7'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:9f03473d-ca0d-4414-aa6a-cc3f8b6af1db'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = NULL,
    part.name_ko = 'Ária (Cantiga)', part.name_en = 'Bachianas Brasileiras nº 4, W264: III. Ária (Cantiga)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 10243 AND p.composer_id = 105 AND part.part_key = 'musicbrainz:30f8d009-a117-4ba4-9623-04de46b840fd' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:30f8d009-a117-4ba4-9623-04de46b840fd', 3, NULL, 'Ária (Cantiga)', 'Bachianas Brasileiras nº 4, W264: III. Ária (Cantiga)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:9f03473d-ca0d-4414-aa6a-cc3f8b6af1db'
WHERE p.id = 10243 AND p.composer_id = 105
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:30f8d009-a117-4ba4-9623-04de46b840fd'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:9f03473d-ca0d-4414-aa6a-cc3f8b6af1db'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = NULL,
    part.name_ko = 'Dança (Miudinho)', part.name_en = 'Bachianas Brasileiras nº 4, W264: IV. Dança (Miudinho)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 10243 AND p.composer_id = 105 AND part.part_key = 'musicbrainz:96a94cab-54e2-409f-a9c8-6fc3926a82ec' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:96a94cab-54e2-409f-a9c8-6fc3926a82ec', 4, NULL, 'Dança (Miudinho)', 'Bachianas Brasileiras nº 4, W264: IV. Dança (Miudinho)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:9f03473d-ca0d-4414-aa6a-cc3f8b6af1db'
WHERE p.id = 10243 AND p.composer_id = 105
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:96a94cab-54e2-409f-a9c8-6fc3926a82ec'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 5, part.movement_number = NULL,
    part.name_ko = 'Bachianas Brasileiras nº 5, W389', part.name_en = 'Bachianas Brasileiras nº 5, W389',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 10243 AND p.composer_id = 105 AND part.part_key = 'musicbrainz:1a694546-90c9-464d-baa4-bba9302c1b11' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:1a694546-90c9-464d-baa4-bba9302c1b11', 5, NULL, 'Bachianas Brasileiras nº 5, W389', 'Bachianas Brasileiras nº 5, W389', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 10243 AND p.composer_id = 105
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:1a694546-90c9-464d-baa4-bba9302c1b11'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:1a694546-90c9-464d-baa4-bba9302c1b11'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'Aria (Cantilena)', part.name_en = 'Bachianas Brasileiras nº 5, W389: I. Aria (Cantilena)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 10243 AND p.composer_id = 105 AND part.part_key = 'musicbrainz:4dd483da-e596-4a49-99d6-c6e2642660f8' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:4dd483da-e596-4a49-99d6-c6e2642660f8', 1, NULL, 'Aria (Cantilena)', 'Bachianas Brasileiras nº 5, W389: I. Aria (Cantilena)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:1a694546-90c9-464d-baa4-bba9302c1b11'
WHERE p.id = 10243 AND p.composer_id = 105
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:4dd483da-e596-4a49-99d6-c6e2642660f8'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:1a694546-90c9-464d-baa4-bba9302c1b11'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'Dansa (Martelo)', part.name_en = 'Bachianas Brasileiras nº 5, W389: II. Dansa (Martelo)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 10243 AND p.composer_id = 105 AND part.part_key = 'musicbrainz:049a0c4f-a7bd-410f-bfbc-6cbe2ee70834' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:049a0c4f-a7bd-410f-bfbc-6cbe2ee70834', 2, NULL, 'Dansa (Martelo)', 'Bachianas Brasileiras nº 5, W389: II. Dansa (Martelo)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:1a694546-90c9-464d-baa4-bba9302c1b11'
WHERE p.id = 10243 AND p.composer_id = 105
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:049a0c4f-a7bd-410f-bfbc-6cbe2ee70834'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 6, part.movement_number = NULL,
    part.name_ko = 'Bachianas Brasileiras nº 6, W392', part.name_en = 'Bachianas Brasileiras nº 6, W392',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 10243 AND p.composer_id = 105 AND part.part_key = 'musicbrainz:2574766b-dd0d-4f82-adcb-35288a4673ac' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:2574766b-dd0d-4f82-adcb-35288a4673ac', 6, NULL, 'Bachianas Brasileiras nº 6, W392', 'Bachianas Brasileiras nº 6, W392', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 10243 AND p.composer_id = 105
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:2574766b-dd0d-4f82-adcb-35288a4673ac'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:2574766b-dd0d-4f82-adcb-35288a4673ac'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'Ária (chôro)', part.name_en = 'Bachianas Brasileiras nº 6, W392: I. Ária (chôro)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 10243 AND p.composer_id = 105 AND part.part_key = 'musicbrainz:c17fd5a5-5d3d-4275-bf04-6ffe774f5817' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:c17fd5a5-5d3d-4275-bf04-6ffe774f5817', 1, NULL, 'Ária (chôro)', 'Bachianas Brasileiras nº 6, W392: I. Ária (chôro)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:2574766b-dd0d-4f82-adcb-35288a4673ac'
WHERE p.id = 10243 AND p.composer_id = 105
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:c17fd5a5-5d3d-4275-bf04-6ffe774f5817'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:2574766b-dd0d-4f82-adcb-35288a4673ac'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'Fantasia (Allegro)', part.name_en = 'Bachianas Brasileiras nº 6, W392: II. Fantasia (Allegro)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 10243 AND p.composer_id = 105 AND part.part_key = 'musicbrainz:95e09d3d-a33b-4a21-b4de-15857a4b2898' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:95e09d3d-a33b-4a21-b4de-15857a4b2898', 2, NULL, 'Fantasia (Allegro)', 'Bachianas Brasileiras nº 6, W392: II. Fantasia (Allegro)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:2574766b-dd0d-4f82-adcb-35288a4673ac'
WHERE p.id = 10243 AND p.composer_id = 105
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:95e09d3d-a33b-4a21-b4de-15857a4b2898'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 7, part.movement_number = NULL,
    part.name_ko = 'Bachianas Brasileiras nº 8, W444', part.name_en = 'Bachianas Brasileiras nº 8, W444',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 10243 AND p.composer_id = 105 AND part.part_key = 'musicbrainz:ce2bc419-b4ed-4071-844d-0ca7697cf26a' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:ce2bc419-b4ed-4071-844d-0ca7697cf26a', 7, NULL, 'Bachianas Brasileiras nº 8, W444', 'Bachianas Brasileiras nº 8, W444', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 10243 AND p.composer_id = 105
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:ce2bc419-b4ed-4071-844d-0ca7697cf26a'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:ce2bc419-b4ed-4071-844d-0ca7697cf26a'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'Prelúdio', part.name_en = 'Bachianas Brasileiras nº 8, W444: I. Prelúdio',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 10243 AND p.composer_id = 105 AND part.part_key = 'musicbrainz:773c8dd5-9de5-4926-a19f-9058ba37c330' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:773c8dd5-9de5-4926-a19f-9058ba37c330', 1, NULL, 'Prelúdio', 'Bachianas Brasileiras nº 8, W444: I. Prelúdio', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:ce2bc419-b4ed-4071-844d-0ca7697cf26a'
WHERE p.id = 10243 AND p.composer_id = 105
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:773c8dd5-9de5-4926-a19f-9058ba37c330'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:ce2bc419-b4ed-4071-844d-0ca7697cf26a'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'Ária (Modinha)', part.name_en = 'Bachianas Brasileiras nº 8, W444: II. Ária (Modinha)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 10243 AND p.composer_id = 105 AND part.part_key = 'musicbrainz:62d87ff5-4123-4a47-8506-7385b38a756c' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:62d87ff5-4123-4a47-8506-7385b38a756c', 2, NULL, 'Ária (Modinha)', 'Bachianas Brasileiras nº 8, W444: II. Ária (Modinha)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:ce2bc419-b4ed-4071-844d-0ca7697cf26a'
WHERE p.id = 10243 AND p.composer_id = 105
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:62d87ff5-4123-4a47-8506-7385b38a756c'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:ce2bc419-b4ed-4071-844d-0ca7697cf26a'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = NULL,
    part.name_ko = 'Tocata (Catira batida)', part.name_en = 'Bachianas Brasileiras nº 8, W444: III. Tocata (Catira batida)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 10243 AND p.composer_id = 105 AND part.part_key = 'musicbrainz:59ef5820-8e04-4b04-8945-6e8e0f01f7bf' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:59ef5820-8e04-4b04-8945-6e8e0f01f7bf', 3, NULL, 'Tocata (Catira batida)', 'Bachianas Brasileiras nº 8, W444: III. Tocata (Catira batida)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:ce2bc419-b4ed-4071-844d-0ca7697cf26a'
WHERE p.id = 10243 AND p.composer_id = 105
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:59ef5820-8e04-4b04-8945-6e8e0f01f7bf'
);


-- W 035 Bailado infantil

UPDATE pieces piece
SET piece.title = 'Bailado infantil', piece.title_en = 'Bailado infantil, W035',
    piece.type = 'song', piece.opus_number = 'W 035',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 11051 AND piece.composer_id = 105
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- W 543 Bendita sabedoria

UPDATE pieces piece
SET piece.title = 'Bendita sabedoria', piece.title_en = 'Bendita sabedoria, W 543',
    piece.type = 'album', piece.opus_number = 'W 543',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 9034 AND piece.composer_id = 105
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'Sapientia foris predicat. Adagio', part.name_en = 'Bendita sabedoria, W 543: I. Sapientia foris predicat. Adagio',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 9034 AND p.composer_id = 105 AND part.part_key = 'musicbrainz:d7121b1e-f727-4c7d-9e6e-17872e9b2fdd' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:d7121b1e-f727-4c7d-9e6e-17872e9b2fdd', 1, 'I', 'Sapientia foris predicat. Adagio', 'Bendita sabedoria, W 543: I. Sapientia foris predicat. Adagio', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 9034 AND p.composer_id = 105
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:d7121b1e-f727-4c7d-9e6e-17872e9b2fdd'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'Vas pretiosum. Andantino', part.name_en = 'Bendita sabedoria, W 543: II. Vas pretiosum. Andantino',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 9034 AND p.composer_id = 105 AND part.part_key = 'musicbrainz:b4e64977-43ed-4008-ae67-0279f9bd899d' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:b4e64977-43ed-4008-ae67-0279f9bd899d', 2, 'II', 'Vas pretiosum. Andantino', 'Bendita sabedoria, W 543: II. Vas pretiosum. Andantino', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 9034 AND p.composer_id = 105
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:b4e64977-43ed-4008-ae67-0279f9bd899d'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = 'Principium sapientiae. Quasi allegretto', part.name_en = 'Bendita sabedoria, W 543: III. Principium sapientiae. Quasi allegretto',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 9034 AND p.composer_id = 105 AND part.part_key = 'musicbrainz:1625ee30-7581-441a-bd69-e4e613bc53be' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:1625ee30-7581-441a-bd69-e4e613bc53be', 3, 'III', 'Principium sapientiae. Quasi allegretto', 'Bendita sabedoria, W 543: III. Principium sapientiae. Quasi allegretto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 9034 AND p.composer_id = 105
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:1625ee30-7581-441a-bd69-e4e613bc53be'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = 'IV',
    part.name_ko = 'Vir sapiens fortis est. Allegro', part.name_en = 'Bendita sabedoria, W 543: IV. Vir sapiens fortis est. Allegro',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 9034 AND p.composer_id = 105 AND part.part_key = 'musicbrainz:f046e392-9ebf-4098-a458-61f654d3b879' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:f046e392-9ebf-4098-a458-61f654d3b879', 4, 'IV', 'Vir sapiens fortis est. Allegro', 'Bendita sabedoria, W 543: IV. Vir sapiens fortis est. Allegro', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 9034 AND p.composer_id = 105
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:f046e392-9ebf-4098-a458-61f654d3b879'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 5, part.movement_number = 'V',
    part.name_ko = 'Beatus homo. Andante', part.name_en = 'Bendita sabedoria, W 543: V. Beatus homo. Andante',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 9034 AND p.composer_id = 105 AND part.part_key = 'musicbrainz:d87535ad-3382-4486-b1b9-d1ed97f40928' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:d87535ad-3382-4486-b1b9-d1ed97f40928', 5, 'V', 'Beatus homo. Andante', 'Bendita sabedoria, W 543: V. Beatus homo. Andante', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 9034 AND p.composer_id = 105
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:d87535ad-3382-4486-b1b9-d1ed97f40928'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 6, part.movement_number = 'VI',
    part.name_ko = 'Dexteram tuam. Largo', part.name_en = 'Bendita sabedoria, W 543: VI. Dexteram tuam. Largo',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 9034 AND p.composer_id = 105 AND part.part_key = 'musicbrainz:9f07c3dc-cf03-47e4-9c2a-340c509a3a49' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:9f07c3dc-cf03-47e4-9c2a-340c509a3a49', 6, 'VI', 'Dexteram tuam. Largo', 'Bendita sabedoria, W 543: VI. Dexteram tuam. Largo', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 9034 AND p.composer_id = 105
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:9f07c3dc-cf03-47e4-9c2a-340c509a3a49'
);


-- Op. 50 자장가

UPDATE pieces piece
SET piece.title = '자장가', piece.title_en = 'Berceuse, op. 50, W088',
    piece.type = 'song', piece.opus_number = 'Op. 50',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 9461 AND piece.composer_id = 105
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- W 045 Brinquedo de roda

UPDATE pieces piece
SET piece.title = 'Brinquedo de roda', piece.title_en = 'Brinquedo de roda, W045',
    piece.type = 'album', piece.opus_number = 'W 045',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 9990 AND piece.composer_id = 105
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'Tira o seu pezinho', part.name_en = 'Brinquedo de roda, W045: I. Tira o seu pezinho',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 9990 AND p.composer_id = 105 AND part.part_key = 'musicbrainz:ffd98f44-5fff-4d46-b150-6a32c9e923dc' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:ffd98f44-5fff-4d46-b150-6a32c9e923dc', 1, 'I', 'Tira o seu pezinho', 'Brinquedo de roda, W045: I. Tira o seu pezinho', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 9990 AND p.composer_id = 105
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:ffd98f44-5fff-4d46-b150-6a32c9e923dc'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'A moda da carranquinha', part.name_en = 'Brinquedo de roda, W045: II. A moda da carranquinha',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 9990 AND p.composer_id = 105 AND part.part_key = 'musicbrainz:c41849fd-6c46-4f6d-b14d-4c06b3861592' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:c41849fd-6c46-4f6d-b14d-4c06b3861592', 2, 'II', 'A moda da carranquinha', 'Brinquedo de roda, W045: II. A moda da carranquinha', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 9990 AND p.composer_id = 105
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:c41849fd-6c46-4f6d-b14d-4c06b3861592'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = 'Os três cavalheiros', part.name_en = 'Brinquedo de roda, W045: III. Os três cavalheiros',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 9990 AND p.composer_id = 105 AND part.part_key = 'musicbrainz:967ad43b-c7e0-49ff-af1f-0a63806cab99' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:967ad43b-c7e0-49ff-af1f-0a63806cab99', 3, 'III', 'Os três cavalheiros', 'Brinquedo de roda, W045: III. Os três cavalheiros', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 9990 AND p.composer_id = 105
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:967ad43b-c7e0-49ff-af1f-0a63806cab99'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = 'IV',
    part.name_ko = 'Uma, duas angolinhas', part.name_en = 'Brinquedo de roda, W045: IV. Uma, duas angolinhas',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 9990 AND p.composer_id = 105 AND part.part_key = 'musicbrainz:2f5942f5-c70c-41b7-9226-d25c4adf3b54' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:2f5942f5-c70c-41b7-9226-d25c4adf3b54', 4, 'IV', 'Uma, duas angolinhas', 'Brinquedo de roda, W045: IV. Uma, duas angolinhas', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 9990 AND p.composer_id = 105
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:2f5942f5-c70c-41b7-9226-d25c4adf3b54'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 5, part.movement_number = 'V',
    part.name_ko = 'Garibaldi foi à missa', part.name_en = 'Brinquedo de roda, W045: V. Garibaldi foi à missa',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 9990 AND p.composer_id = 105 AND part.part_key = 'musicbrainz:d6e02563-85b5-46b0-862f-ef5feabbc217' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:d6e02563-85b5-46b0-862f-ef5feabbc217', 5, 'V', 'Garibaldi foi à missa', 'Brinquedo de roda, W045: V. Garibaldi foi à missa', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 9990 AND p.composer_id = 105
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:d6e02563-85b5-46b0-862f-ef5feabbc217'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 6, part.movement_number = 'VI',
    part.name_ko = 'Vamos todos cirandar', part.name_en = 'Brinquedo de roda, W045: VI. Vamos todos cirandar',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 9990 AND p.composer_id = 105 AND part.part_key = 'musicbrainz:0a96f028-5275-43a6-9e2c-4447e9c71bc7' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:0a96f028-5275-43a6-9e2c-4447e9c71bc7', 6, 'VI', 'Vamos todos cirandar', 'Brinquedo de roda, W045: VI. Vamos todos cirandar', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 9990 AND p.composer_id = 105
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:0a96f028-5275-43a6-9e2c-4447e9c71bc7'
);


-- W 256 Caixinha de música quebrada

UPDATE pieces piece
SET piece.title = 'Caixinha de música quebrada', piece.title_en = 'Caixinha de música quebrada, W256',
    piece.type = 'song', piece.opus_number = 'W 256',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 10416 AND piece.composer_id = 105
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- W 500 Canto orfeônico, 2.º volume W 500

UPDATE pieces piece
SET piece.title = 'Canto orfeônico, 2.º volume W 500', piece.title_en = 'Canto orfeônico, 2.º volume, W500',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = 'W', piece.catalogue_number = '500',
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 10826 AND piece.composer_id = 105
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'n.º 22. Canide Ioune-Sabath', part.name_en = 'Canto orfeônico, 2.º volume, W500: n.º 22. Canide Ioune-Sabath',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 10826 AND p.composer_id = 105 AND part.part_key = 'musicbrainz:daaac714-d490-40c3-be6d-30c639f24b8a' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:daaac714-d490-40c3-be6d-30c639f24b8a', 1, NULL, 'n.º 22. Canide Ioune-Sabath', 'Canto orfeônico, 2.º volume, W500: n.º 22. Canide Ioune-Sabath', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 10826 AND p.composer_id = 105
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:daaac714-d490-40c3-be6d-30c639f24b8a'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'n.º 24. Xangô', part.name_en = 'Canto orfeônico, 2.º volume, W500: n.º 24. Xangô',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 10826 AND p.composer_id = 105 AND part.part_key = 'musicbrainz:62d34656-657f-4feb-b35d-15839da014c5' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:62d34656-657f-4feb-b35d-15839da014c5', 2, NULL, 'n.º 24. Xangô', 'Canto orfeônico, 2.º volume, W500: n.º 24. Xangô', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 10826 AND p.composer_id = 105
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:62d34656-657f-4feb-b35d-15839da014c5'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = NULL,
    part.name_ko = 'As costureiras, W329', part.name_en = 'As costureiras, W329',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 10826 AND p.composer_id = 105 AND part.part_key = 'musicbrainz:5a75441d-7de4-46a3-9ed5-74bb587fbe38' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:5a75441d-7de4-46a3-9ed5-74bb587fbe38', 3, NULL, 'As costureiras, W329', 'As costureiras, W329', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 10826 AND p.composer_id = 105
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:5a75441d-7de4-46a3-9ed5-74bb587fbe38'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = NULL,
    part.name_ko = 'n.º 37. Estrela é lua nova', part.name_en = 'Canto orfeônico, 2.º volume, W500: n.º 37. Estrela é lua nova',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 10826 AND p.composer_id = 105 AND part.part_key = 'musicbrainz:5bba28bb-92fd-4b1e-879c-2cb77bfaa73a' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:5bba28bb-92fd-4b1e-879c-2cb77bfaa73a', 4, NULL, 'n.º 37. Estrela é lua nova', 'Canto orfeônico, 2.º volume, W500: n.º 37. Estrela é lua nova', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 10826 AND p.composer_id = 105
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:5bba28bb-92fd-4b1e-879c-2cb77bfaa73a'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 5, part.movement_number = NULL,
    part.name_ko = 'n.º 38. Jaquibáu', part.name_en = 'Canto orfeônico, 2.º volume, W500: n.º 38. Jaquibáu',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 10826 AND p.composer_id = 105 AND part.part_key = 'musicbrainz:2df2943a-a980-4da4-a853-fc711a0f5091' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:2df2943a-a980-4da4-a853-fc711a0f5091', 5, NULL, 'n.º 38. Jaquibáu', 'Canto orfeônico, 2.º volume, W500: n.º 38. Jaquibáu', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 10826 AND p.composer_id = 105
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:2df2943a-a980-4da4-a853-fc711a0f5091'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 6, part.movement_number = NULL,
    part.name_ko = 'n.º 39. Bazzum', part.name_en = 'Canto orfeônico, 2.º volume, W500: n.º 39. Bazzum',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 10826 AND p.composer_id = 105 AND part.part_key = 'musicbrainz:5cf3015d-f761-4bf3-bcb9-02ec27f099ee' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:5cf3015d-f761-4bf3-bcb9-02ec27f099ee', 6, NULL, 'n.º 39. Bazzum', 'Canto orfeônico, 2.º volume, W500: n.º 39. Bazzum', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 10826 AND p.composer_id = 105
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:5cf3015d-f761-4bf3-bcb9-02ec27f099ee'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 7, part.movement_number = NULL,
    part.name_ko = 'n.º 40. Vira', part.name_en = 'Canto orfeônico, 2.º volume, W500: n.º 40. Vira',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 10826 AND p.composer_id = 105 AND part.part_key = 'musicbrainz:1011f4b8-900d-4c65-9a1a-a23bd9bdfe63' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:1011f4b8-900d-4c65-9a1a-a23bd9bdfe63', 7, NULL, 'n.º 40. Vira', 'Canto orfeônico, 2.º volume, W500: n.º 40. Vira', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 10826 AND p.composer_id = 105
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:1011f4b8-900d-4c65-9a1a-a23bd9bdfe63'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 8, part.movement_number = NULL,
    part.name_ko = 'n.º 44. Remeiro de São Francisco', part.name_en = 'Canto orfeônico, 2.º volume, W500: n.º 44. Remeiro de São Francisco',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 10826 AND p.composer_id = 105 AND part.part_key = 'musicbrainz:5f04630b-e76e-4d74-a9f6-28f909319b08' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:5f04630b-e76e-4d74-a9f6-28f909319b08', 8, NULL, 'n.º 44. Remeiro de São Francisco', 'Canto orfeônico, 2.º volume, W500: n.º 44. Remeiro de São Francisco', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 10826 AND p.composer_id = 105
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:5f04630b-e76e-4d74-a9f6-28f909319b08'
);


-- W 494 가곡 <Canção de cristal>

UPDATE pieces piece
SET piece.title = '가곡 <Canção de cristal>', piece.title_en = 'Canção de cristal, W494',
    piece.type = 'song', piece.opus_number = 'W 494',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 9109 AND piece.composer_id = 105
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- W 486 가곡 <Canção do poeta do século XVIII>

UPDATE pieces piece
SET piece.title = '가곡 <Canção do poeta do século XVIII>', piece.title_en = 'Canção do poeta do século XVIII, W486',
    piece.type = 'song', piece.opus_number = 'W 486',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 10791 AND piece.composer_id = 105
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Canções de cordialidade

UPDATE pieces piece
SET piece.title = 'Canções de cordialidade', piece.title_en = 'Canções de cordialidade',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 10658 AND piece.composer_id = 105
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'Feliz aniversário', part.name_en = 'Canções de cordialidade: I. Feliz aniversário',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 10658 AND p.composer_id = 105 AND part.part_key = 'musicbrainz:24315222-b068-4667-9ac4-054e7629f732' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:24315222-b068-4667-9ac4-054e7629f732', 1, 'I', 'Feliz aniversário', 'Canções de cordialidade: I. Feliz aniversário', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 10658 AND p.composer_id = 105
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:24315222-b068-4667-9ac4-054e7629f732'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'Boas-festas', part.name_en = 'Canções de cordialidade: II. Boas-festas',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 10658 AND p.composer_id = 105 AND part.part_key = 'musicbrainz:b13f1d56-4e68-4311-a0b9-81e0239c47cc' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:b13f1d56-4e68-4311-a0b9-81e0239c47cc', 2, 'II', 'Boas-festas', 'Canções de cordialidade: II. Boas-festas', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 10658 AND p.composer_id = 105
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:b13f1d56-4e68-4311-a0b9-81e0239c47cc'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = 'Feliz Natal', part.name_en = 'Canções de cordialidade: III. Feliz Natal',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 10658 AND p.composer_id = 105 AND part.part_key = 'musicbrainz:08a503cd-452c-44fd-b324-2fde3a63ef6f' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:08a503cd-452c-44fd-b324-2fde3a63ef6f', 3, 'III', 'Feliz Natal', 'Canções de cordialidade: III. Feliz Natal', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 10658 AND p.composer_id = 105
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:08a503cd-452c-44fd-b324-2fde3a63ef6f'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = 'IV',
    part.name_ko = 'Feliz ano novo', part.name_en = 'Canções de cordialidade: IV. Feliz ano novo',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 10658 AND p.composer_id = 105 AND part.part_key = 'musicbrainz:505cb442-36b6-49fd-9bc4-c49a2136e295' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:505cb442-36b6-49fd-9bc4-c49a2136e295', 4, 'IV', 'Feliz ano novo', 'Canções de cordialidade: IV. Feliz ano novo', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 10658 AND p.composer_id = 105
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:505cb442-36b6-49fd-9bc4-c49a2136e295'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 5, part.movement_number = 'V',
    part.name_ko = 'Boas-vindas', part.name_en = 'Canções de cordialidade: V. Boas-vindas',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 10658 AND p.composer_id = 105 AND part.part_key = 'musicbrainz:b954f24c-287d-4cce-a4a0-1a2dec6db3e8' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:b954f24c-287d-4cce-a4a0-1a2dec6db3e8', 5, 'V', 'Boas-vindas', 'Canções de cordialidade: V. Boas-vindas', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 10658 AND p.composer_id = 105
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:b954f24c-287d-4cce-a4a0-1a2dec6db3e8'
);


-- W 158 연가곡집 <Canções típicas brasileiras> W 158

UPDATE pieces piece
SET piece.title = '연가곡집 <Canções típicas brasileiras> W 158', piece.title_en = 'Canções típicas brasileiras, W158',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = 'W', piece.catalogue_number = '158',
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 7950 AND piece.composer_id = 105
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'Estrela é lua nova', part.name_en = 'Canções típicas brasileiras, W158: 4. Estrela é lua nova',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 7950 AND p.composer_id = 105 AND part.part_key = 'musicbrainz:b1b2998e-e244-43f1-92fb-85d54c64fd75' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:b1b2998e-e244-43f1-92fb-85d54c64fd75', 1, NULL, 'Estrela é lua nova', 'Canções típicas brasileiras, W158: 4. Estrela é lua nova', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 7950 AND p.composer_id = 105
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:b1b2998e-e244-43f1-92fb-85d54c64fd75'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'Xangô', part.name_en = 'Canções típicas brasileiras, W158: 3. Xangô',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 7950 AND p.composer_id = 105 AND part.part_key = 'musicbrainz:d1f9c5a7-d850-460b-af27-d0276031d798' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:d1f9c5a7-d850-460b-af27-d0276031d798', 2, NULL, 'Xangô', 'Canções típicas brasileiras, W158: 3. Xangô', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 7950 AND p.composer_id = 105
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:d1f9c5a7-d850-460b-af27-d0276031d798'
);


-- Op. 49 카프리치오

UPDATE pieces piece
SET piece.title = '카프리치오', piece.title_en = 'Capriccio, op. 49, W091',
    piece.type = 'song', piece.opus_number = 'Op. 49',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 8260 AND piece.composer_id = 105
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- W 157 Carnaval das crianças

UPDATE pieces piece
SET piece.title = 'Carnaval das crianças', piece.title_en = 'Carnaval das crianças, W157',
    piece.type = 'album', piece.opus_number = 'W 157',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 10848 AND piece.composer_id = 105
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'O ginete do Pierrozinho', part.name_en = 'Carnaval das crianças, W157: I. O ginete do Pierrozinho',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 10848 AND p.composer_id = 105 AND part.part_key = 'musicbrainz:e86c800f-8c1a-4b56-9114-58a780ffffce' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:e86c800f-8c1a-4b56-9114-58a780ffffce', 1, 'I', 'O ginete do Pierrozinho', 'Carnaval das crianças, W157: I. O ginete do Pierrozinho', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 10848 AND p.composer_id = 105
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:e86c800f-8c1a-4b56-9114-58a780ffffce'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'O chicote do diabinho', part.name_en = 'Carnaval das crianças, W157: II. O chicote do diabinho',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 10848 AND p.composer_id = 105 AND part.part_key = 'musicbrainz:46e13076-e026-414f-964b-05b7b44f493d' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:46e13076-e026-414f-964b-05b7b44f493d', 2, 'II', 'O chicote do diabinho', 'Carnaval das crianças, W157: II. O chicote do diabinho', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 10848 AND p.composer_id = 105
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:46e13076-e026-414f-964b-05b7b44f493d'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = 'A manha da Pierrete', part.name_en = 'Carnaval das crianças, W157: III. A manha da Pierrete',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 10848 AND p.composer_id = 105 AND part.part_key = 'musicbrainz:328b5b39-bbf2-4ed8-877c-a2636388ffeb' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:328b5b39-bbf2-4ed8-877c-a2636388ffeb', 3, 'III', 'A manha da Pierrete', 'Carnaval das crianças, W157: III. A manha da Pierrete', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 10848 AND p.composer_id = 105
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:328b5b39-bbf2-4ed8-877c-a2636388ffeb'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = 'IV',
    part.name_ko = 'Os guizos do dominozinho', part.name_en = 'Carnaval das crianças, W157: IV. Os guizos do dominozinho',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 10848 AND p.composer_id = 105 AND part.part_key = 'musicbrainz:062c1d64-f62f-4575-8f71-d6e5b90c8f76' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:062c1d64-f62f-4575-8f71-d6e5b90c8f76', 4, 'IV', 'Os guizos do dominozinho', 'Carnaval das crianças, W157: IV. Os guizos do dominozinho', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 10848 AND p.composer_id = 105
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:062c1d64-f62f-4575-8f71-d6e5b90c8f76'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 5, part.movement_number = 'V',
    part.name_ko = 'As peripécias do trapeirozinho', part.name_en = 'Carnaval das crianças, W157: V. As peripécias do trapeirozinho',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 10848 AND p.composer_id = 105 AND part.part_key = 'musicbrainz:bc48c66c-ef43-4324-9f5f-1967f8b72900' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:bc48c66c-ef43-4324-9f5f-1967f8b72900', 5, 'V', 'As peripécias do trapeirozinho', 'Carnaval das crianças, W157: V. As peripécias do trapeirozinho', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 10848 AND p.composer_id = 105
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:bc48c66c-ef43-4324-9f5f-1967f8b72900'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 6, part.movement_number = 'VI',
    part.name_ko = 'As traquinices do mascarado Mignon', part.name_en = 'Carnaval das crianças, W157: VI. As traquinices do mascarado Mignon',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 10848 AND p.composer_id = 105 AND part.part_key = 'musicbrainz:80655afc-eaef-4bf8-9bc1-1d37c7e3fb8f' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:80655afc-eaef-4bf8-9bc1-1d37c7e3fb8f', 6, 'VI', 'As traquinices do mascarado Mignon', 'Carnaval das crianças, W157: VI. As traquinices do mascarado Mignon', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 10848 AND p.composer_id = 105
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:80655afc-eaef-4bf8-9bc1-1d37c7e3fb8f'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 7, part.movement_number = 'VII',
    part.name_ko = 'A gaita de um precoce fantasiado', part.name_en = 'Carnaval das crianças, W157: VII. A gaita de um precoce fantasiado',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 10848 AND p.composer_id = 105 AND part.part_key = 'musicbrainz:9dc86bbb-2264-43ca-8efa-f88a3092dbf9' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:9dc86bbb-2264-43ca-8efa-f88a3092dbf9', 7, 'VII', 'A gaita de um precoce fantasiado', 'Carnaval das crianças, W157: VII. A gaita de um precoce fantasiado', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 10848 AND p.composer_id = 105
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:9dc86bbb-2264-43ca-8efa-f88a3092dbf9'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 8, part.movement_number = 'VIII',
    part.name_ko = 'A folia de um bloco infantil', part.name_en = 'Carnaval das crianças, W157: VIII. A folia de um bloco infantil',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 10848 AND p.composer_id = 105 AND part.part_key = 'musicbrainz:a51839ee-c7b8-454b-a109-8b08a01c66bc' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:a51839ee-c7b8-454b-a109-8b08a01c66bc', 8, 'VIII', 'A folia de um bloco infantil', 'Carnaval das crianças, W157: VIII. A folia de um bloco infantil', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 10848 AND p.composer_id = 105
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:a51839ee-c7b8-454b-a109-8b08a01c66bc'
);


-- Op. 66 첼로 소나타 2번

UPDATE pieces piece
SET piece.title = '첼로 소나타 2번', piece.title_en = 'Cello Sonata no. 2, op. 66, W103',
    piece.type = 'album', piece.opus_number = 'Op. 66',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 8315 AND piece.composer_id = 105
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'Allegro moderato', part.name_en = 'Cello Sonata no. 2, op. 66, W103: I. Allegro moderato',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 8315 AND p.composer_id = 105 AND part.part_key = 'musicbrainz:16f34a8b-1536-4105-aa7e-1c761aed93f6' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:16f34a8b-1536-4105-aa7e-1c761aed93f6', 1, 'I', 'Allegro moderato', 'Cello Sonata no. 2, op. 66, W103: I. Allegro moderato', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 8315 AND p.composer_id = 105
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:16f34a8b-1536-4105-aa7e-1c761aed93f6'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'Andante cantabile', part.name_en = 'Cello Sonata no. 2, op. 66, W103: II. Andante cantabile',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 8315 AND p.composer_id = 105 AND part.part_key = 'musicbrainz:bc2629dc-c097-4cfd-b340-4faa85921cd0' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:bc2629dc-c097-4cfd-b340-4faa85921cd0', 2, 'II', 'Andante cantabile', 'Cello Sonata no. 2, op. 66, W103: II. Andante cantabile', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 8315 AND p.composer_id = 105
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:bc2629dc-c097-4cfd-b340-4faa85921cd0'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = 'Scherzo (Allegro scherzando)', part.name_en = 'Cello Sonata no. 2, op. 66, W103: III. Scherzo (Allegro scherzando)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 8315 AND p.composer_id = 105 AND part.part_key = 'musicbrainz:ddd54e53-ff7a-4f8b-9c56-087085a1645a' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:ddd54e53-ff7a-4f8b-9c56-087085a1645a', 3, 'III', 'Scherzo (Allegro scherzando)', 'Cello Sonata no. 2, op. 66, W103: III. Scherzo (Allegro scherzando)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 8315 AND p.composer_id = 105
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:ddd54e53-ff7a-4f8b-9c56-087085a1645a'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = 'IV',
    part.name_ko = 'Allegro vivace sostenuto', part.name_en = 'Cello Sonata no. 2, op. 66, W103: IV. Allegro vivace sostenuto',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 8315 AND p.composer_id = 105 AND part.part_key = 'musicbrainz:40798bc1-9a72-4429-8e31-925ce2f55d55' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:40798bc1-9a72-4429-8e31-925ce2f55d55', 4, 'IV', 'Allegro vivace sostenuto', 'Cello Sonata no. 2, op. 66, W103: IV. Allegro vivace sostenuto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 8315 AND p.composer_id = 105
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:40798bc1-9a72-4429-8e31-925ce2f55d55'
);


-- None 가곡 <Choro typico>

UPDATE pieces piece
SET piece.title = '가곡 <Choro typico>', piece.title_en = 'Choro typico',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 7833 AND piece.composer_id = 105
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- W 228 Choros nº 11 W 228

UPDATE pieces piece
SET piece.title = 'Choros nº 11 W 228', piece.title_en = 'Choros nº 11, W228',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = 'W', piece.catalogue_number = '228',
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 8112 AND piece.composer_id = 105
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'I', part.name_en = 'Choros nº 11, W228: I.',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 8112 AND p.composer_id = 105 AND part.part_key = 'musicbrainz:9418ca1f-1028-4680-91e8-623dbe8fcc90' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:9418ca1f-1028-4680-91e8-623dbe8fcc90', 1, NULL, 'I', 'Choros nº 11, W228: I.', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 8112 AND p.composer_id = 105
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:9418ca1f-1028-4680-91e8-623dbe8fcc90'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'II', part.name_en = 'Choros nº 11, W228: II.',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 8112 AND p.composer_id = 105 AND part.part_key = 'musicbrainz:121b8266-4541-4813-9522-adaf1974026c' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:121b8266-4541-4813-9522-adaf1974026c', 2, NULL, 'II', 'Choros nº 11, W228: II.', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 8112 AND p.composer_id = 105
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:121b8266-4541-4813-9522-adaf1974026c'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = NULL,
    part.name_ko = 'III', part.name_en = 'Choros nº 11, W228: III.',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 8112 AND p.composer_id = 105 AND part.part_key = 'musicbrainz:f4696287-e6a4-41f2-b202-c0b9f521279f' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:f4696287-e6a4-41f2-b202-c0b9f521279f', 3, NULL, 'III', 'Choros nº 11, W228: III.', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 8112 AND p.composer_id = 105
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:f4696287-e6a4-41f2-b202-c0b9f521279f'
);


-- W 233 Choros nº 12

UPDATE pieces piece
SET piece.title = 'Choros nº 12', piece.title_en = 'Choros nº 12, W233',
    piece.type = 'song', piece.opus_number = 'W 233',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 11165 AND piece.composer_id = 105
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- W 206 Choros nº 3 "Picapau"

UPDATE pieces piece
SET piece.title = 'Choros nº 3 "Picapau"', piece.title_en = 'Choros nº 3 "Picapau", W206',
    piece.type = 'song', piece.opus_number = 'W 206',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 10309 AND piece.composer_id = 105
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- W 218 Choros nº 4

UPDATE pieces piece
SET piece.title = 'Choros nº 4', piece.title_en = 'Choros nº 4, W218',
    piece.type = 'song', piece.opus_number = 'W 218',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 10552 AND piece.composer_id = 105
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- W 207 Choros nº 5 "Alma brasileira"

UPDATE pieces piece
SET piece.title = 'Choros nº 5 "Alma brasileira"', piece.title_en = 'Choros nº 5 "Alma brasileira", W207',
    piece.type = 'song', piece.opus_number = 'W 207',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 8669 AND piece.composer_id = 105
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- W 219 Choros nº 6

UPDATE pieces piece
SET piece.title = 'Choros nº 6', piece.title_en = 'Choros nº 6, W219',
    piece.type = 'song', piece.opus_number = 'W 219',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 9756 AND piece.composer_id = 105
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- W 199 Choros nº 7

UPDATE pieces piece
SET piece.title = 'Choros nº 7', piece.title_en = 'Choros nº 7, W199',
    piece.type = 'song', piece.opus_number = 'W 199',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 9495 AND piece.composer_id = 105
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- W 208 Choros nº 8

UPDATE pieces piece
SET piece.title = 'Choros nº 8', piece.title_en = 'Choros nº 8, W208',
    piece.type = 'song', piece.opus_number = 'W 208',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 7760 AND piece.composer_id = 105
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- W 232 Choros nº 9

UPDATE pieces piece
SET piece.title = 'Choros nº 9', piece.title_en = 'Choros nº 9, W232',
    piece.type = 'song', piece.opus_number = 'W 232',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 11240 AND piece.composer_id = 105
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- W 374 Ciclo brasileiro

UPDATE pieces piece
SET piece.title = 'Ciclo brasileiro', piece.title_en = 'Ciclo brasileiro, W374',
    piece.type = 'album', piece.opus_number = 'W 374',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 8821 AND piece.composer_id = 105
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'Plantio do caboclo', part.name_en = 'Ciclo brasileiro, W374: I. Plantio do caboclo',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 8821 AND p.composer_id = 105 AND part.part_key = 'musicbrainz:0386ea1c-00e8-452e-be1a-840f630802b2' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:0386ea1c-00e8-452e-be1a-840f630802b2', 1, 'I', 'Plantio do caboclo', 'Ciclo brasileiro, W374: I. Plantio do caboclo', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 8821 AND p.composer_id = 105
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:0386ea1c-00e8-452e-be1a-840f630802b2'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'Impressões seresteiras', part.name_en = 'Ciclo brasileiro, W374: II. Impressões seresteiras',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 8821 AND p.composer_id = 105 AND part.part_key = 'musicbrainz:631f11ad-54b4-48c1-b4df-ca52fc186670' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:631f11ad-54b4-48c1-b4df-ca52fc186670', 2, 'II', 'Impressões seresteiras', 'Ciclo brasileiro, W374: II. Impressões seresteiras', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 8821 AND p.composer_id = 105
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:631f11ad-54b4-48c1-b4df-ca52fc186670'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = 'Festa no sertão', part.name_en = 'Ciclo brasileiro, W374: III. Festa no sertão',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 8821 AND p.composer_id = 105 AND part.part_key = 'musicbrainz:e0b07bd4-7018-4076-b72b-6960e91f5e61' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:e0b07bd4-7018-4076-b72b-6960e91f5e61', 3, 'III', 'Festa no sertão', 'Ciclo brasileiro, W374: III. Festa no sertão', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 8821 AND p.composer_id = 105
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:e0b07bd4-7018-4076-b72b-6960e91f5e61'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = 'IV',
    part.name_ko = 'Dança do índio branco', part.name_en = 'Ciclo brasileiro, W374: IV. Dança do índio branco',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 8821 AND p.composer_id = 105 AND part.part_key = 'musicbrainz:49ab5bb8-d9ec-4a63-9534-251ab1603504' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:49ab5bb8-d9ec-4a63-9534-251ab1603504', 4, 'IV', 'Dança do índio branco', 'Ciclo brasileiro, W374: IV. Dança do índio branco', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 8821 AND p.composer_id = 105
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:49ab5bb8-d9ec-4a63-9534-251ab1603504'
);


-- W 419 Cinco prelúdios W 419

UPDATE pieces piece
SET piece.title = 'Cinco prelúdios W 419', piece.title_en = 'Cinco prelúdios, W419',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = 'W', piece.catalogue_number = '419',
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 7573 AND piece.composer_id = 105
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'Andante espressivo', part.name_en = 'Cinco prelúdios, W419, nº 1: Andante espressivo',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 7573 AND p.composer_id = 105 AND part.part_key = 'musicbrainz:d6aad83d-5797-3fc0-a77f-e469cbf63679' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:d6aad83d-5797-3fc0-a77f-e469cbf63679', 1, NULL, 'Andante espressivo', 'Cinco prelúdios, W419, nº 1: Andante espressivo', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 7573 AND p.composer_id = 105
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:d6aad83d-5797-3fc0-a77f-e469cbf63679'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'Andantino', part.name_en = 'Cinco prelúdios, W419, nº 2: Andantino',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 7573 AND p.composer_id = 105 AND part.part_key = 'musicbrainz:3aaae858-9226-3f05-88e6-aefb9bfeb620' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:3aaae858-9226-3f05-88e6-aefb9bfeb620', 2, NULL, 'Andantino', 'Cinco prelúdios, W419, nº 2: Andantino', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 7573 AND p.composer_id = 105
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:3aaae858-9226-3f05-88e6-aefb9bfeb620'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = NULL,
    part.name_ko = 'Andante', part.name_en = 'Cinco prelúdios, W419, nº 3: Andante',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 7573 AND p.composer_id = 105 AND part.part_key = 'musicbrainz:09fb28e5-b98f-3507-ae6f-949c44ba563a' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:09fb28e5-b98f-3507-ae6f-949c44ba563a', 3, NULL, 'Andante', 'Cinco prelúdios, W419, nº 3: Andante', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 7573 AND p.composer_id = 105
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:09fb28e5-b98f-3507-ae6f-949c44ba563a'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = NULL,
    part.name_ko = 'Lento', part.name_en = 'Cinco prelúdios, W419, nº 4: Lento',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 7573 AND p.composer_id = 105 AND part.part_key = 'musicbrainz:2a581615-104f-3b28-bf92-e3af50c6e2d5' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:2a581615-104f-3b28-bf92-e3af50c6e2d5', 4, NULL, 'Lento', 'Cinco prelúdios, W419, nº 4: Lento', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 7573 AND p.composer_id = 105
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:2a581615-104f-3b28-bf92-e3af50c6e2d5'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 5, part.movement_number = NULL,
    part.name_ko = 'Poco animato', part.name_en = 'Cinco prelúdios, W419, nº 5: Poco animato',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 7573 AND p.composer_id = 105 AND part.part_key = 'musicbrainz:2b8f319a-0a3b-326d-9da4-c8e571c10ab9' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:2b8f319a-0a3b-326d-9da4-c8e571c10ab9', 5, NULL, 'Poco animato', 'Cinco prelúdios, W419, nº 5: Poco animato', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 7573 AND p.composer_id = 105
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:2b8f319a-0a3b-326d-9da4-c8e571c10ab9'
);


-- W 325 Ciranda das sete notas

UPDATE pieces piece
SET piece.title = 'Ciranda das sete notas', piece.title_en = 'Ciranda das sete notas, W325',
    piece.type = 'song', piece.opus_number = 'W 325',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 9447 AND piece.composer_id = 105
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- W 220 Cirandas W 220

UPDATE pieces piece
SET piece.title = 'Cirandas W 220', piece.title_en = 'Cirandas, W220',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = 'W', piece.catalogue_number = '220',
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 7963 AND piece.composer_id = 105
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'Terezinha de Jesus', part.name_en = 'Cirandas, W220, nº 1: Terezinha de Jesus',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 7963 AND p.composer_id = 105 AND part.part_key = 'musicbrainz:15309df3-8ff7-4c48-8458-01f10b36917d' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:15309df3-8ff7-4c48-8458-01f10b36917d', 1, NULL, 'Terezinha de Jesus', 'Cirandas, W220, nº 1: Terezinha de Jesus', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 7963 AND p.composer_id = 105
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:15309df3-8ff7-4c48-8458-01f10b36917d'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'A condessa', part.name_en = 'Cirandas, W220, nº 2: A condessa',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 7963 AND p.composer_id = 105 AND part.part_key = 'musicbrainz:c0de15b5-0fa2-33af-8c6d-1defbf582f43' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:c0de15b5-0fa2-33af-8c6d-1defbf582f43', 2, NULL, 'A condessa', 'Cirandas, W220, nº 2: A condessa', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 7963 AND p.composer_id = 105
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:c0de15b5-0fa2-33af-8c6d-1defbf582f43'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = NULL,
    part.name_ko = 'Senhora Dona Sancha', part.name_en = 'Cirandas, W220, nº 3: Senhora Dona Sancha',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 7963 AND p.composer_id = 105 AND part.part_key = 'musicbrainz:3df3cf68-0eab-4aee-aec7-9d7ee692d9ca' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:3df3cf68-0eab-4aee-aec7-9d7ee692d9ca', 3, NULL, 'Senhora Dona Sancha', 'Cirandas, W220, nº 3: Senhora Dona Sancha', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 7963 AND p.composer_id = 105
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:3df3cf68-0eab-4aee-aec7-9d7ee692d9ca'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = NULL,
    part.name_ko = 'O cravo brigou com a rosa', part.name_en = 'Cirandas, W220, nº 4: O cravo brigou com a rosa',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 7963 AND p.composer_id = 105 AND part.part_key = 'musicbrainz:608d0180-96b0-4c8d-95e9-267efdab5b4c' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:608d0180-96b0-4c8d-95e9-267efdab5b4c', 4, NULL, 'O cravo brigou com a rosa', 'Cirandas, W220, nº 4: O cravo brigou com a rosa', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 7963 AND p.composer_id = 105
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:608d0180-96b0-4c8d-95e9-267efdab5b4c'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 5, part.movement_number = NULL,
    part.name_ko = 'Pobre cega (Toada de rede)', part.name_en = 'Cirandas, W220, nº 5: Pobre cega (Toada de rede)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 7963 AND p.composer_id = 105 AND part.part_key = 'musicbrainz:b2f2d367-1212-4ed9-894e-b708a0b18f03' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:b2f2d367-1212-4ed9-894e-b708a0b18f03', 5, NULL, 'Pobre cega (Toada de rede)', 'Cirandas, W220, nº 5: Pobre cega (Toada de rede)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 7963 AND p.composer_id = 105
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:b2f2d367-1212-4ed9-894e-b708a0b18f03'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 6, part.movement_number = NULL,
    part.name_ko = 'Passa, passa gavião', part.name_en = 'Cirandas, W220, nº 6: Passa, passa gavião',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 7963 AND p.composer_id = 105 AND part.part_key = 'musicbrainz:6a44b222-ce84-42ab-b8da-5832e8cde4f7' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:6a44b222-ce84-42ab-b8da-5832e8cde4f7', 6, NULL, 'Passa, passa gavião', 'Cirandas, W220, nº 6: Passa, passa gavião', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 7963 AND p.composer_id = 105
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:6a44b222-ce84-42ab-b8da-5832e8cde4f7'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 7, part.movement_number = NULL,
    part.name_ko = 'Xô, xô, passarinho', part.name_en = 'Cirandas, W220, nº 7: Xô, xô, passarinho',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 7963 AND p.composer_id = 105 AND part.part_key = 'musicbrainz:510d40cd-67ed-4e3c-936f-32f2d65e164d' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:510d40cd-67ed-4e3c-936f-32f2d65e164d', 7, NULL, 'Xô, xô, passarinho', 'Cirandas, W220, nº 7: Xô, xô, passarinho', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 7963 AND p.composer_id = 105
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:510d40cd-67ed-4e3c-936f-32f2d65e164d'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 8, part.movement_number = NULL,
    part.name_ko = 'Vamos atrás da serra, Calunga', part.name_en = 'Cirandas, W220, nº 8: Vamos atrás da serra, Calunga',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 7963 AND p.composer_id = 105 AND part.part_key = 'musicbrainz:9a31697e-d02c-4163-b120-c07eb0fa844c' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:9a31697e-d02c-4163-b120-c07eb0fa844c', 8, NULL, 'Vamos atrás da serra, Calunga', 'Cirandas, W220, nº 8: Vamos atrás da serra, Calunga', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 7963 AND p.composer_id = 105
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:9a31697e-d02c-4163-b120-c07eb0fa844c'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 9, part.movement_number = NULL,
    part.name_ko = 'O pintor de Canahy', part.name_en = 'Cirandas, W220, nº 10: O pintor de Canahy',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 7963 AND p.composer_id = 105 AND part.part_key = 'musicbrainz:0cac1018-f54e-4b85-9149-9a52dd468327' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:0cac1018-f54e-4b85-9149-9a52dd468327', 9, NULL, 'O pintor de Canahy', 'Cirandas, W220, nº 10: O pintor de Canahy', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 7963 AND p.composer_id = 105
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:0cac1018-f54e-4b85-9149-9a52dd468327'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 10, part.movement_number = NULL,
    part.name_ko = 'Nesta rua, nesta rua', part.name_en = 'Cirandas, W220, nº 11: Nesta rua, nesta rua',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 7963 AND p.composer_id = 105 AND part.part_key = 'musicbrainz:bc9272f1-cef9-416e-b83e-ced403a7f97b' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:bc9272f1-cef9-416e-b83e-ced403a7f97b', 10, NULL, 'Nesta rua, nesta rua', 'Cirandas, W220, nº 11: Nesta rua, nesta rua', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 7963 AND p.composer_id = 105
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:bc9272f1-cef9-416e-b83e-ced403a7f97b'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 11, part.movement_number = NULL,
    part.name_ko = 'Olha o passarinho domine', part.name_en = 'Cirandas, W220, nº 12: Olha o passarinho domine',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 7963 AND p.composer_id = 105 AND part.part_key = 'musicbrainz:4984ad1f-6b9b-4efb-ae94-e1861c3a7f4b' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:4984ad1f-6b9b-4efb-ae94-e1861c3a7f4b', 11, NULL, 'Olha o passarinho domine', 'Cirandas, W220, nº 12: Olha o passarinho domine', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 7963 AND p.composer_id = 105
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:4984ad1f-6b9b-4efb-ae94-e1861c3a7f4b'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 12, part.movement_number = NULL,
    part.name_ko = 'À procura de uma agulha', part.name_en = 'Cirandas, W220, nº 13: À procura de uma agulha',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 7963 AND p.composer_id = 105 AND part.part_key = 'musicbrainz:892b4997-d928-4410-82cd-114803d88ad8' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:892b4997-d928-4410-82cd-114803d88ad8', 12, NULL, 'À procura de uma agulha', 'Cirandas, W220, nº 13: À procura de uma agulha', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 7963 AND p.composer_id = 105
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:892b4997-d928-4410-82cd-114803d88ad8'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 13, part.movement_number = NULL,
    part.name_ko = 'A canoa virou', part.name_en = 'Cirandas, W220, nº 14: A canoa virou',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 7963 AND p.composer_id = 105 AND part.part_key = 'musicbrainz:552ee864-abea-4101-a181-68a2dd228971' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:552ee864-abea-4101-a181-68a2dd228971', 13, NULL, 'A canoa virou', 'Cirandas, W220, nº 14: A canoa virou', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 7963 AND p.composer_id = 105
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:552ee864-abea-4101-a181-68a2dd228971'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 14, part.movement_number = NULL,
    part.name_ko = 'Que lindos olhos', part.name_en = 'Cirandas, W220, nº 15: Que lindos olhos',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 7963 AND p.composer_id = 105 AND part.part_key = 'musicbrainz:25451fb8-e206-44e5-af99-fc6b107f82f9' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:25451fb8-e206-44e5-af99-fc6b107f82f9', 14, NULL, 'Que lindos olhos', 'Cirandas, W220, nº 15: Que lindos olhos', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 7963 AND p.composer_id = 105
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:25451fb8-e206-44e5-af99-fc6b107f82f9'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 15, part.movement_number = NULL,
    part.name_ko = 'Có, có, có', part.name_en = 'Cirandas, W220, nº 16: Có, có, có',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 7963 AND p.composer_id = 105 AND part.part_key = 'musicbrainz:c6eef954-9b99-4d9d-8f4a-a62af92570ab' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:c6eef954-9b99-4d9d-8f4a-a62af92570ab', 15, NULL, 'Có, có, có', 'Cirandas, W220, nº 16: Có, có, có', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 7963 AND p.composer_id = 105
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:c6eef954-9b99-4d9d-8f4a-a62af92570ab'
);


-- W 210 Cirandinhas W 210

UPDATE pieces piece
SET piece.title = 'Cirandinhas W 210', piece.title_en = 'Cirandinhas, W210',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = 'W', piece.catalogue_number = '210',
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 10868 AND piece.composer_id = 105
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'Zangou-se o cravo com a rosa', part.name_en = 'Cirandinhas, W210, nº 1: Zangou-se o cravo com a rosa',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 10868 AND p.composer_id = 105 AND part.part_key = 'musicbrainz:b304d986-2808-466e-bcb3-8b46ea3b09d7' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:b304d986-2808-466e-bcb3-8b46ea3b09d7', 1, NULL, 'Zangou-se o cravo com a rosa', 'Cirandinhas, W210, nº 1: Zangou-se o cravo com a rosa', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 10868 AND p.composer_id = 105
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:b304d986-2808-466e-bcb3-8b46ea3b09d7'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'Adeus bela morena', part.name_en = 'Cirandinhas, W210, nº 2: Adeus bela morena',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 10868 AND p.composer_id = 105 AND part.part_key = 'musicbrainz:a5f1d7c5-f137-429c-baf4-a60049262284' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:a5f1d7c5-f137-429c-baf4-a60049262284', 2, NULL, 'Adeus bela morena', 'Cirandinhas, W210, nº 2: Adeus bela morena', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 10868 AND p.composer_id = 105
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:a5f1d7c5-f137-429c-baf4-a60049262284'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = NULL,
    part.name_ko = 'Vamos maninha', part.name_en = 'Cirandinhas, W210, nº 3: Vamos maninha',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 10868 AND p.composer_id = 105 AND part.part_key = 'musicbrainz:5583db1a-9835-4883-83b4-6a4058f4364a' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:5583db1a-9835-4883-83b4-6a4058f4364a', 3, NULL, 'Vamos maninha', 'Cirandinhas, W210, nº 3: Vamos maninha', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 10868 AND p.composer_id = 105
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:5583db1a-9835-4883-83b4-6a4058f4364a'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = NULL,
    part.name_ko = 'Olha aquela menina', part.name_en = 'Cirandinhas, W210, nº 4: Olha aquela menina',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 10868 AND p.composer_id = 105 AND part.part_key = 'musicbrainz:5cd76800-9369-457a-8a88-20d0e2bb2baa' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:5cd76800-9369-457a-8a88-20d0e2bb2baa', 4, NULL, 'Olha aquela menina', 'Cirandinhas, W210, nº 4: Olha aquela menina', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 10868 AND p.composer_id = 105
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:5cd76800-9369-457a-8a88-20d0e2bb2baa'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 5, part.movement_number = NULL,
    part.name_ko = 'Senhora pastora', part.name_en = 'Cirandinhas, W210, nº 5: Senhora pastora',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 10868 AND p.composer_id = 105 AND part.part_key = 'musicbrainz:b2f46b4d-db21-4165-a75d-e9258fdc015f' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:b2f46b4d-db21-4165-a75d-e9258fdc015f', 5, NULL, 'Senhora pastora', 'Cirandinhas, W210, nº 5: Senhora pastora', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 10868 AND p.composer_id = 105
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:b2f46b4d-db21-4165-a75d-e9258fdc015f'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 6, part.movement_number = NULL,
    part.name_ko = 'Todo mundo passa', part.name_en = 'Cirandinhas, W210, nº 7: Todo mundo passa',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 10868 AND p.composer_id = 105 AND part.part_key = 'musicbrainz:dae08c71-affa-48f8-b1c9-67ae295ca491' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:dae08c71-affa-48f8-b1c9-67ae295ca491', 6, NULL, 'Todo mundo passa', 'Cirandinhas, W210, nº 7: Todo mundo passa', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 10868 AND p.composer_id = 105
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:dae08c71-affa-48f8-b1c9-67ae295ca491'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 7, part.movement_number = NULL,
    part.name_ko = 'Vamos ver a mulatinha', part.name_en = 'Cirandinhas, W210, nº 8: Vamos ver a mulatinha',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 10868 AND p.composer_id = 105 AND part.part_key = 'musicbrainz:928deba2-802a-4524-a20a-73cb08779597' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:928deba2-802a-4524-a20a-73cb08779597', 7, NULL, 'Vamos ver a mulatinha', 'Cirandinhas, W210, nº 8: Vamos ver a mulatinha', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 10868 AND p.composer_id = 105
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:928deba2-802a-4524-a20a-73cb08779597'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 8, part.movement_number = NULL,
    part.name_ko = 'Carneirinho, carneirão', part.name_en = 'Cirandinhas, W210, nº 9: Carneirinho, carneirão',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 10868 AND p.composer_id = 105 AND part.part_key = 'musicbrainz:c2b8bde4-c6ba-441a-84a5-16ef2c696c9f' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:c2b8bde4-c6ba-441a-84a5-16ef2c696c9f', 8, NULL, 'Carneirinho, carneirão', 'Cirandinhas, W210, nº 9: Carneirinho, carneirão', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 10868 AND p.composer_id = 105
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:c2b8bde4-c6ba-441a-84a5-16ef2c696c9f'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 9, part.movement_number = NULL,
    part.name_ko = 'A canoa virou', part.name_en = 'Cirandinhas, W210, nº 10: A canoa virou',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 10868 AND p.composer_id = 105 AND part.part_key = 'musicbrainz:d4174b44-da65-4dd9-9e16-a3aa06fade64' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:d4174b44-da65-4dd9-9e16-a3aa06fade64', 9, NULL, 'A canoa virou', 'Cirandinhas, W210, nº 10: A canoa virou', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 10868 AND p.composer_id = 105
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:d4174b44-da65-4dd9-9e16-a3aa06fade64'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 10, part.movement_number = NULL,
    part.name_ko = 'Nésta rua tem um bosque', part.name_en = 'Cirandinhas, W210, nº 11: Nésta rua tem um bosque',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 10868 AND p.composer_id = 105 AND part.part_key = 'musicbrainz:fbd1c8b8-cef5-4b00-a759-f0c57bb05584' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:fbd1c8b8-cef5-4b00-a759-f0c57bb05584', 10, NULL, 'Nésta rua tem um bosque', 'Cirandinhas, W210, nº 11: Nésta rua tem um bosque', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 10868 AND p.composer_id = 105
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:fbd1c8b8-cef5-4b00-a759-f0c57bb05584'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 11, part.movement_number = NULL,
    part.name_ko = 'Lindos olhos que ela tem', part.name_en = 'Cirandinhas, W210, nº 12: Lindos olhos que ela tem',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 10868 AND p.composer_id = 105 AND part.part_key = 'musicbrainz:d36a0dd0-5fa3-4d0d-b769-bf41dbd4f352' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:d36a0dd0-5fa3-4d0d-b769-bf41dbd4f352', 11, NULL, 'Lindos olhos que ela tem', 'Cirandinhas, W210, nº 12: Lindos olhos que ela tem', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 10868 AND p.composer_id = 105
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:d36a0dd0-5fa3-4d0d-b769-bf41dbd4f352'
);


-- None Concerto Grosso for Woodwind Quartet and Wind Orchestra

UPDATE pieces piece
SET piece.title = 'Concerto Grosso for Woodwind Quartet and Wind Orchestra', piece.title_en = 'Concerto Grosso for Woodwind Quartet and Wind Orchestra',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 8448 AND piece.composer_id = 105
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'Allegro non troppo', part.name_en = 'Concerto Grosso for Woodwind Quartet and Wind Orchestra: I. Allegro non troppo',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 8448 AND p.composer_id = 105 AND part.part_key = 'musicbrainz:487aa5e6-7fda-4b43-a0d0-38bef253bb09' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:487aa5e6-7fda-4b43-a0d0-38bef253bb09', 1, 'I', 'Allegro non troppo', 'Concerto Grosso for Woodwind Quartet and Wind Orchestra: I. Allegro non troppo', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 8448 AND p.composer_id = 105
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:487aa5e6-7fda-4b43-a0d0-38bef253bb09'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'Allegretto scherzando', part.name_en = 'Concerto Grosso for Woodwind Quartet and Wind Orchestra: II. Allegretto scherzando',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 8448 AND p.composer_id = 105 AND part.part_key = 'musicbrainz:7f944402-3f1b-4b75-a40f-2bbb387b372c' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:7f944402-3f1b-4b75-a40f-2bbb387b372c', 2, 'II', 'Allegretto scherzando', 'Concerto Grosso for Woodwind Quartet and Wind Orchestra: II. Allegretto scherzando', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 8448 AND p.composer_id = 105
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:7f944402-3f1b-4b75-a40f-2bbb387b372c'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = 'Andante', part.name_en = 'Concerto Grosso for Woodwind Quartet and Wind Orchestra: III. Andante',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 8448 AND p.composer_id = 105 AND part.part_key = 'musicbrainz:9a369e0d-0a4a-4c19-9a31-356bef3e99a3' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:9a369e0d-0a4a-4c19-9a31-356bef3e99a3', 3, 'III', 'Andante', 'Concerto Grosso for Woodwind Quartet and Wind Orchestra: III. Andante', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 8448 AND p.composer_id = 105
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:9a369e0d-0a4a-4c19-9a31-356bef3e99a3'
);


-- W 515 Concerto para harpa e orquestra

UPDATE pieces piece
SET piece.title = 'Concerto para harpa e orquestra', piece.title_en = 'Concerto para harpa e orquestra, W515',
    piece.type = 'album', piece.opus_number = 'W 515',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 9535 AND piece.composer_id = 105
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'Allegro', part.name_en = 'Concerto para harpa e orquestra, W515: I. Allegro',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 9535 AND p.composer_id = 105 AND part.part_key = 'musicbrainz:5e90d2ca-07a3-4d03-b4cc-4ad7077729db' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:5e90d2ca-07a3-4d03-b4cc-4ad7077729db', 1, 'I', 'Allegro', 'Concerto para harpa e orquestra, W515: I. Allegro', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 9535 AND p.composer_id = 105
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:5e90d2ca-07a3-4d03-b4cc-4ad7077729db'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'Andante moderato', part.name_en = 'Concerto para harpa e orquestra, W515: II. Andante moderato',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 9535 AND p.composer_id = 105 AND part.part_key = 'musicbrainz:43fb55cb-c0ee-421a-a33b-95ac1f8f2c94' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:43fb55cb-c0ee-421a-a33b-95ac1f8f2c94', 2, 'II', 'Andante moderato', 'Concerto para harpa e orquestra, W515: II. Andante moderato', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 9535 AND p.composer_id = 105
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:43fb55cb-c0ee-421a-a33b-95ac1f8f2c94'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = 'Scherzo', part.name_en = 'Concerto para harpa e orquestra, W515: III. Scherzo',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 9535 AND p.composer_id = 105 AND part.part_key = 'musicbrainz:31f80d83-d4a5-42d2-9312-e3b96fbc015a' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:31f80d83-d4a5-42d2-9312-e3b96fbc015a', 3, 'III', 'Scherzo', 'Concerto para harpa e orquestra, W515: III. Scherzo', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 9535 AND p.composer_id = 105
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:31f80d83-d4a5-42d2-9312-e3b96fbc015a'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = 'IV',
    part.name_ko = 'Allegro', part.name_en = 'Concerto para harpa e orquestra, W515: IV. Allegro',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 9535 AND p.composer_id = 105 AND part.part_key = 'musicbrainz:0f33deb0-2f2a-4dcf-9441-b411552105fe' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:0f33deb0-2f2a-4dcf-9441-b411552105fe', 4, 'IV', 'Allegro', 'Concerto para harpa e orquestra, W515: IV. Allegro', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 9535 AND p.composer_id = 105
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:0f33deb0-2f2a-4dcf-9441-b411552105fe'
);


-- W 453 협주곡 1번

UPDATE pieces piece
SET piece.title = '협주곡 1번', piece.title_en = 'Concerto para piano nº 1, W453',
    piece.type = 'album', piece.opus_number = 'W 453',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 10230 AND piece.composer_id = 105
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'Allegro', part.name_en = 'Concerto para piano nº 1, W453: I. Allegro',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 10230 AND p.composer_id = 105 AND part.part_key = 'musicbrainz:8c66d5d7-2fdc-459e-81c5-69e40ccde462' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:8c66d5d7-2fdc-459e-81c5-69e40ccde462', 1, 'I', 'Allegro', 'Concerto para piano nº 1, W453: I. Allegro', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 10230 AND p.composer_id = 105
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:8c66d5d7-2fdc-459e-81c5-69e40ccde462'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'Allegro (poco scherzando)', part.name_en = 'Concerto para piano nº 1, W453: II. Allegro (poco scherzando)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 10230 AND p.composer_id = 105 AND part.part_key = 'musicbrainz:12b909d2-8fb6-468b-966a-92d709090415' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:12b909d2-8fb6-468b-966a-92d709090415', 2, 'II', 'Allegro (poco scherzando)', 'Concerto para piano nº 1, W453: II. Allegro (poco scherzando)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 10230 AND p.composer_id = 105
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:12b909d2-8fb6-468b-966a-92d709090415'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = 'Andante e cadenza', part.name_en = 'Concerto para piano nº 1, W453: III. Andante e cadenza',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 10230 AND p.composer_id = 105 AND part.part_key = 'musicbrainz:39c8077d-cfbc-4436-bd1a-c295a13802f0' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:39c8077d-cfbc-4436-bd1a-c295a13802f0', 3, 'III', 'Andante e cadenza', 'Concerto para piano nº 1, W453: III. Andante e cadenza', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 10230 AND p.composer_id = 105
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:39c8077d-cfbc-4436-bd1a-c295a13802f0'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = 'IV',
    part.name_ko = 'Allegro non troppo', part.name_en = 'Concerto para piano nº 1, W453: IV. Allegro non troppo',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 10230 AND p.composer_id = 105 AND part.part_key = 'musicbrainz:f54abf03-ed01-4c48-8ded-b7bd6182b620' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:f54abf03-ed01-4c48-8ded-b7bd6182b620', 4, 'IV', 'Allegro non troppo', 'Concerto para piano nº 1, W453: IV. Allegro non troppo', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 10230 AND p.composer_id = 105
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:f54abf03-ed01-4c48-8ded-b7bd6182b620'
);


-- W 487 협주곡 2번

UPDATE pieces piece
SET piece.title = '협주곡 2번', piece.title_en = 'Concerto para piano nº 2, W487',
    piece.type = 'album', piece.opus_number = 'W 487',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 9175 AND piece.composer_id = 105
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'Vivo', part.name_en = 'Concerto para piano nº 2, W487: I. Vivo',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 9175 AND p.composer_id = 105 AND part.part_key = 'musicbrainz:260766bc-78d9-450e-92a1-7b806ba31dd4' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:260766bc-78d9-450e-92a1-7b806ba31dd4', 1, 'I', 'Vivo', 'Concerto para piano nº 2, W487: I. Vivo', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 9175 AND p.composer_id = 105
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:260766bc-78d9-450e-92a1-7b806ba31dd4'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'Lento', part.name_en = 'Concerto para piano nº 2, W487: II. Lento',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 9175 AND p.composer_id = 105 AND part.part_key = 'musicbrainz:d95995ed-4a3a-4029-97ba-6e438b979896' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:d95995ed-4a3a-4029-97ba-6e438b979896', 2, 'II', 'Lento', 'Concerto para piano nº 2, W487: II. Lento', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 9175 AND p.composer_id = 105
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:d95995ed-4a3a-4029-97ba-6e438b979896'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = 'Cadência (quasi allegro)', part.name_en = 'Concerto para piano nº 2, W487: III. Cadência (quasi allegro)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 9175 AND p.composer_id = 105 AND part.part_key = 'musicbrainz:bac8c254-8bad-49a6-9e81-c77610eefa03' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:bac8c254-8bad-49a6-9e81-c77610eefa03', 3, 'III', 'Cadência (quasi allegro)', 'Concerto para piano nº 2, W487: III. Cadência (quasi allegro)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 9175 AND p.composer_id = 105
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:bac8c254-8bad-49a6-9e81-c77610eefa03'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = 'IV',
    part.name_ko = 'Allegro', part.name_en = 'Concerto para piano nº 2, W487: IV. Allegro',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 9175 AND p.composer_id = 105 AND part.part_key = 'musicbrainz:bcddfa76-3750-48e9-8a7d-d21a20615295' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:bcddfa76-3750-48e9-8a7d-d21a20615295', 4, 'IV', 'Allegro', 'Concerto para piano nº 2, W487: IV. Allegro', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 9175 AND p.composer_id = 105
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:bcddfa76-3750-48e9-8a7d-d21a20615295'
);


-- W 512 협주곡 3번

UPDATE pieces piece
SET piece.title = '협주곡 3번', piece.title_en = 'Concerto para piano nº 3, W512',
    piece.type = 'album', piece.opus_number = 'W 512',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 10809 AND piece.composer_id = 105
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'Allegro non troppo', part.name_en = 'Concerto para piano nº 3, W512: I. Allegro non troppo',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 10809 AND p.composer_id = 105 AND part.part_key = 'musicbrainz:01ee39f0-786d-4f4e-9056-3f2c8064bf7b' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:01ee39f0-786d-4f4e-9056-3f2c8064bf7b', 1, 'I', 'Allegro non troppo', 'Concerto para piano nº 3, W512: I. Allegro non troppo', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 10809 AND p.composer_id = 105
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:01ee39f0-786d-4f4e-9056-3f2c8064bf7b'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'Andante con moto', part.name_en = 'Concerto para piano nº 3, W512: II. Andante con moto',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 10809 AND p.composer_id = 105 AND part.part_key = 'musicbrainz:d798bb49-109c-47d8-8c4f-d0dfd47b3b42' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:d798bb49-109c-47d8-8c4f-d0dfd47b3b42', 2, 'II', 'Andante con moto', 'Concerto para piano nº 3, W512: II. Andante con moto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 10809 AND p.composer_id = 105
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:d798bb49-109c-47d8-8c4f-d0dfd47b3b42'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = 'Scherzo (Vivace)', part.name_en = 'Concerto para piano nº 3, W512: III. Scherzo (Vivace)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 10809 AND p.composer_id = 105 AND part.part_key = 'musicbrainz:5b7c355b-a77f-43c6-8074-b0a2dffbcc41' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:5b7c355b-a77f-43c6-8074-b0a2dffbcc41', 3, 'III', 'Scherzo (Vivace)', 'Concerto para piano nº 3, W512: III. Scherzo (Vivace)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 10809 AND p.composer_id = 105
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:5b7c355b-a77f-43c6-8074-b0a2dffbcc41'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = 'IV',
    part.name_ko = 'Allegro vivace (decisivo)', part.name_en = 'Concerto para piano nº 3, W512: IV. Allegro vivace (decisivo)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 10809 AND p.composer_id = 105 AND part.part_key = 'musicbrainz:95d403a6-1e15-452b-87ce-6ba3b12c903b' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:95d403a6-1e15-452b-87ce-6ba3b12c903b', 4, 'IV', 'Allegro vivace (decisivo)', 'Concerto para piano nº 3, W512: IV. Allegro vivace (decisivo)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 10809 AND p.composer_id = 105
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:95d403a6-1e15-452b-87ce-6ba3b12c903b'
);


-- W 505 협주곡 4번

UPDATE pieces piece
SET piece.title = '협주곡 4번', piece.title_en = 'Concerto para piano nº 4, W505',
    piece.type = 'album', piece.opus_number = 'W 505',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 8768 AND piece.composer_id = 105
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'Allegro non troppo', part.name_en = 'Concerto para piano nº 4, W505: I. Allegro non troppo',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 8768 AND p.composer_id = 105 AND part.part_key = 'musicbrainz:4173fcbb-502a-40e9-bce2-031c47637194' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:4173fcbb-502a-40e9-bce2-031c47637194', 1, 'I', 'Allegro non troppo', 'Concerto para piano nº 4, W505: I. Allegro non troppo', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 8768 AND p.composer_id = 105
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:4173fcbb-502a-40e9-bce2-031c47637194'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'Andante con moto', part.name_en = 'Concerto para piano nº 4, W505: II. Andante con moto',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 8768 AND p.composer_id = 105 AND part.part_key = 'musicbrainz:73e83116-058c-462d-88ab-0a1a9d931ea1' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:73e83116-058c-462d-88ab-0a1a9d931ea1', 2, 'II', 'Andante con moto', 'Concerto para piano nº 4, W505: II. Andante con moto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 8768 AND p.composer_id = 105
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:73e83116-058c-462d-88ab-0a1a9d931ea1'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = 'Scherzo (Allegro vivace)', part.name_en = 'Concerto para piano nº 4, W505: III. Scherzo (Allegro vivace)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 8768 AND p.composer_id = 105 AND part.part_key = 'musicbrainz:d5bc26d4-de05-4a2c-aa80-37e3f05082dc' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:d5bc26d4-de05-4a2c-aa80-37e3f05082dc', 3, 'III', 'Scherzo (Allegro vivace)', 'Concerto para piano nº 4, W505: III. Scherzo (Allegro vivace)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 8768 AND p.composer_id = 105
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:d5bc26d4-de05-4a2c-aa80-37e3f05082dc'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = 'IV',
    part.name_ko = 'Allegro moderato', part.name_en = 'Concerto para piano nº 4, W505: IV. Allegro moderato',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 8768 AND p.composer_id = 105 AND part.part_key = 'musicbrainz:d5f8da61-1a7a-40ef-82ff-7269a7dd828d' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:d5f8da61-1a7a-40ef-82ff-7269a7dd828d', 4, 'IV', 'Allegro moderato', 'Concerto para piano nº 4, W505: IV. Allegro moderato', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 8768 AND p.composer_id = 105
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:d5f8da61-1a7a-40ef-82ff-7269a7dd828d'
);


-- W 521 협주곡 5번

UPDATE pieces piece
SET piece.title = '협주곡 5번', piece.title_en = 'Concerto para piano nº 5, W521',
    piece.type = 'album', piece.opus_number = 'W 521',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 10583 AND piece.composer_id = 105
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'Allegro non troppo', part.name_en = 'Concerto para piano nº 5, W521: I. Allegro non troppo',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 10583 AND p.composer_id = 105 AND part.part_key = 'musicbrainz:d74db99b-b21d-4b92-8420-37a15236f38a' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:d74db99b-b21d-4b92-8420-37a15236f38a', 1, 'I', 'Allegro non troppo', 'Concerto para piano nº 5, W521: I. Allegro non troppo', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 10583 AND p.composer_id = 105
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:d74db99b-b21d-4b92-8420-37a15236f38a'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'Poco adagio', part.name_en = 'Concerto para piano nº 5, W521: II. Poco adagio',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 10583 AND p.composer_id = 105 AND part.part_key = 'musicbrainz:6c9048a2-aecf-4176-bbc4-a97e5056d5d3' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:6c9048a2-aecf-4176-bbc4-a97e5056d5d3', 2, 'II', 'Poco adagio', 'Concerto para piano nº 5, W521: II. Poco adagio', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 10583 AND p.composer_id = 105
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:6c9048a2-aecf-4176-bbc4-a97e5056d5d3'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = 'Allegretto scherzando', part.name_en = 'Concerto para piano nº 5, W521: III. Allegretto scherzando',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 10583 AND p.composer_id = 105 AND part.part_key = 'musicbrainz:e18296ad-e291-4104-a616-71c595f7733a' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:e18296ad-e291-4104-a616-71c595f7733a', 3, 'III', 'Allegretto scherzando', 'Concerto para piano nº 5, W521: III. Allegretto scherzando', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 10583 AND p.composer_id = 105
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:e18296ad-e291-4104-a616-71c595f7733a'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = 'IV',
    part.name_ko = 'Allegretto', part.name_en = 'Concerto para piano nº 5, W521: IV. Allegretto',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 10583 AND p.composer_id = 105 AND part.part_key = 'musicbrainz:192e7bd1-4e4b-41f6-8ad7-25eb0b0bb220' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:192e7bd1-4e4b-41f6-8ad7-25eb0b0bb220', 4, 'IV', 'Allegretto', 'Concerto para piano nº 5, W521: IV. Allegretto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 10583 AND p.composer_id = 105
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:192e7bd1-4e4b-41f6-8ad7-25eb0b0bb220'
);


-- W 095 협주곡 1번 W 095

UPDATE pieces piece
SET piece.title = '협주곡 1번 W 095', piece.title_en = 'Concerto para violoncello e orquestra nº 1, W095',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = 'W', piece.catalogue_number = '095',
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 10764 AND piece.composer_id = 105
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'Allegro con brio', part.name_en = 'Concerto para violoncello e orquestra nº 1, W095: I. Allegro con brio',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 10764 AND p.composer_id = 105 AND part.part_key = 'musicbrainz:1e49834d-b50a-38b8-9d24-d549de48d593' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:1e49834d-b50a-38b8-9d24-d549de48d593', 1, 'I', 'Allegro con brio', 'Concerto para violoncello e orquestra nº 1, W095: I. Allegro con brio', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 10764 AND p.composer_id = 105
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:1e49834d-b50a-38b8-9d24-d549de48d593'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'Assai moderato', part.name_en = 'Concerto para violoncello e orquestra nº 1, W095: II. Assai moderato',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 10764 AND p.composer_id = 105 AND part.part_key = 'musicbrainz:b3ce2ae5-81ee-32e7-b134-beb23ddf0a03' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:b3ce2ae5-81ee-32e7-b134-beb23ddf0a03', 2, 'II', 'Assai moderato', 'Concerto para violoncello e orquestra nº 1, W095: II. Assai moderato', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 10764 AND p.composer_id = 105
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:b3ce2ae5-81ee-32e7-b134-beb23ddf0a03'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = 'Allegro moderato', part.name_en = 'Concerto para violoncello e orquestra nº 1, W095: III. Allegro moderato',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 10764 AND p.composer_id = 105 AND part.part_key = 'musicbrainz:e2663c98-fec4-3bcb-8ca6-f9edeb5d71cb' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:e2663c98-fec4-3bcb-8ca6-f9edeb5d71cb', 3, 'III', 'Allegro moderato', 'Concerto para violoncello e orquestra nº 1, W095: III. Allegro moderato', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 10764 AND p.composer_id = 105
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:e2663c98-fec4-3bcb-8ca6-f9edeb5d71cb'
);


-- W 516 협주곡 2번 W 516

UPDATE pieces piece
SET piece.title = '협주곡 2번 W 516', piece.title_en = 'Concerto para violoncello e orquestra nº 2, W516',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = 'W', piece.catalogue_number = '516',
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 7775 AND piece.composer_id = 105
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'Allegro non troppo', part.name_en = 'Concerto para violoncello e orquestra nº 2, W516: I. Allegro non troppo',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 7775 AND p.composer_id = 105 AND part.part_key = 'musicbrainz:5261cfed-d8a1-3b74-ae0e-3d8400204b49' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:5261cfed-d8a1-3b74-ae0e-3d8400204b49', 1, 'I', 'Allegro non troppo', 'Concerto para violoncello e orquestra nº 2, W516: I. Allegro non troppo', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 7775 AND p.composer_id = 105
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:5261cfed-d8a1-3b74-ae0e-3d8400204b49'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'Molto andante cantabile', part.name_en = 'Concerto para violoncello e orquestra nº 2, W516: II. Molto andante cantabile',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 7775 AND p.composer_id = 105 AND part.part_key = 'musicbrainz:e36a8514-0293-39e5-9057-c5cf245c5a6a' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:e36a8514-0293-39e5-9057-c5cf245c5a6a', 2, 'II', 'Molto andante cantabile', 'Concerto para violoncello e orquestra nº 2, W516: II. Molto andante cantabile', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 7775 AND p.composer_id = 105
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:e36a8514-0293-39e5-9057-c5cf245c5a6a'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = 'Scherzo', part.name_en = 'Concerto para violoncello e orquestra nº 2, W516: III. Scherzo',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 7775 AND p.composer_id = 105 AND part.part_key = 'musicbrainz:318e6730-ea7f-3f19-bb8b-9ae921e96d39' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:318e6730-ea7f-3f19-bb8b-9ae921e96d39', 3, 'III', 'Scherzo', 'Concerto para violoncello e orquestra nº 2, W516: III. Scherzo', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 7775 AND p.composer_id = 105
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:318e6730-ea7f-3f19-bb8b-9ae921e96d39'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = 'IV',
    part.name_ko = 'Allegro energico', part.name_en = 'Concerto para violoncello e orquestra nº 2, W516: IV. Allegro energico',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 7775 AND p.composer_id = 105 AND part.part_key = 'musicbrainz:265bf07b-ca4c-38f7-b106-ca4692e1737d' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:265bf07b-ca4c-38f7-b106-ca4692e1737d', 4, 'IV', 'Allegro energico', 'Concerto para violoncello e orquestra nº 2, W516: IV. Allegro energico', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 7775 AND p.composer_id = 105
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:265bf07b-ca4c-38f7-b106-ca4692e1737d'
);


-- W 501 Concerto para violão e pequena orquestra

UPDATE pieces piece
SET piece.title = 'Concerto para violão e pequena orquestra', piece.title_en = 'Concerto para violão e pequena orquestra, W501',
    piece.type = 'album', piece.opus_number = 'W 501',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 7456 AND piece.composer_id = 105
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'Allegro preciso', part.name_en = 'Concerto para violão e pequena orquestra, W501: I. Allegro preciso',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 7456 AND p.composer_id = 105 AND part.part_key = 'musicbrainz:9952fbf2-2893-3e2b-966f-464143ad50d1' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:9952fbf2-2893-3e2b-966f-464143ad50d1', 1, 'I', 'Allegro preciso', 'Concerto para violão e pequena orquestra, W501: I. Allegro preciso', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 7456 AND p.composer_id = 105
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:9952fbf2-2893-3e2b-966f-464143ad50d1'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'Andantino e andante', part.name_en = 'Concerto para violão e pequena orquestra, W501: II. Andantino e andante',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 7456 AND p.composer_id = 105 AND part.part_key = 'musicbrainz:d91cb5e7-43b0-3aed-9cbf-8b647eb89e09' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:d91cb5e7-43b0-3aed-9cbf-8b647eb89e09', 2, 'II', 'Andantino e andante', 'Concerto para violão e pequena orquestra, W501: II. Andantino e andante', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 7456 AND p.composer_id = 105
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:d91cb5e7-43b0-3aed-9cbf-8b647eb89e09'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = 'Allegretto non troppo', part.name_en = 'Concerto para violão e pequena orquestra, W501: III. Allegretto non troppo',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 7456 AND p.composer_id = 105 AND part.part_key = 'musicbrainz:39600204-2e37-3bbc-beaa-6aeddb42c563' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:39600204-2e37-3bbc-beaa-6aeddb42c563', 3, 'III', 'Allegretto non troppo', 'Concerto para violão e pequena orquestra, W501: III. Allegretto non troppo', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 7456 AND p.composer_id = 105
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:39600204-2e37-3bbc-beaa-6aeddb42c563'
);


-- W 491 Cortejo nupcial

UPDATE pieces piece
SET piece.title = 'Cortejo nupcial', piece.title_en = 'Cortejo nupcial, W491',
    piece.type = 'song', piece.opus_number = 'W 491',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 10131 AND piece.composer_id = 105
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- W 187 Dança dos Mosquitos

UPDATE pieces piece
SET piece.title = 'Dança dos Mosquitos', piece.title_en = 'Dança dos Mosquitos, W187',
    piece.type = 'song', piece.opus_number = 'W 187',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 9190 AND piece.composer_id = 105
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- W 144 Dança frenética

UPDATE pieces piece
SET piece.title = 'Dança frenética', piece.title_en = 'Dança frenética, W144',
    piece.type = 'song', piece.opus_number = 'W 144',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 9380 AND piece.composer_id = 105
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- W 085 Danças características africanas

UPDATE pieces piece
SET piece.title = 'Danças características africanas', piece.title_en = 'Danças características africanas, W085',
    piece.type = 'album', piece.opus_number = 'W 085',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 8435 AND piece.composer_id = 105
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'Farrapós, op. 47', part.name_en = 'Danças características africanas, W085: I. Farrapós, op. 47',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 8435 AND p.composer_id = 105 AND part.part_key = 'musicbrainz:1d552d0c-8959-4eca-9a9a-0da1e74d46e5' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:1d552d0c-8959-4eca-9a9a-0da1e74d46e5', 1, 'I', 'Farrapós, op. 47', 'Danças características africanas, W085: I. Farrapós, op. 47', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 8435 AND p.composer_id = 105
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:1d552d0c-8959-4eca-9a9a-0da1e74d46e5'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'Kankukus, op. 57', part.name_en = 'Danças características africanas, W085: II. Kankukus, op. 57',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 8435 AND p.composer_id = 105 AND part.part_key = 'musicbrainz:7cee05f9-67f5-4793-a169-7611e9995ac3' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:7cee05f9-67f5-4793-a169-7611e9995ac3', 2, 'II', 'Kankukus, op. 57', 'Danças características africanas, W085: II. Kankukus, op. 57', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 8435 AND p.composer_id = 105
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:7cee05f9-67f5-4793-a169-7611e9995ac3'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = 'Kankikis, op. 65', part.name_en = 'Danças características africanas, W085: III. Kankikis, op. 65',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 8435 AND p.composer_id = 105 AND part.part_key = 'musicbrainz:d6871570-a554-4927-a4b0-e7fbebc29dcc' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:d6871570-a554-4927-a4b0-e7fbebc29dcc', 3, 'III', 'Kankikis, op. 65', 'Danças características africanas, W085: III. Kankikis, op. 65', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 8435 AND p.composer_id = 105
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:d6871570-a554-4927-a4b0-e7fbebc29dcc'
);


-- W 377 Descobrimento do Brasil nº 1

UPDATE pieces piece
SET piece.title = 'Descobrimento do Brasil nº 1', piece.title_en = 'Descobrimento do Brasil nº 1, W377',
    piece.type = 'album', piece.opus_number = 'W 377',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 9715 AND piece.composer_id = 105
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'Introdução (Largo)', part.name_en = 'Descobrimento do Brasil nº 1, W377: I. Introdução (Largo)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 9715 AND p.composer_id = 105 AND part.part_key = 'musicbrainz:e0df96fb-4436-4acd-8335-1e7fe2bad7eb' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:e0df96fb-4436-4acd-8335-1e7fe2bad7eb', 1, 'I', 'Introdução (Largo)', 'Descobrimento do Brasil nº 1, W377: I. Introdução (Largo)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 9715 AND p.composer_id = 105
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:e0df96fb-4436-4acd-8335-1e7fe2bad7eb'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'Alegria', part.name_en = 'Descobrimento do Brasil nº 1, W377: II. Alegria',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 9715 AND p.composer_id = 105 AND part.part_key = 'musicbrainz:c9f015f8-eb59-4aee-9941-06a0b0ebf1d7' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:c9f015f8-eb59-4aee-9941-06a0b0ebf1d7', 2, 'II', 'Alegria', 'Descobrimento do Brasil nº 1, W377: II. Alegria', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 9715 AND p.composer_id = 105
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:c9f015f8-eb59-4aee-9941-06a0b0ebf1d7'
);


-- W 378 Descobrimento do Brasil nº 2

UPDATE pieces piece
SET piece.title = 'Descobrimento do Brasil nº 2', piece.title_en = 'Descobrimento do Brasil nº 2, W378',
    piece.type = 'album', piece.opus_number = 'W 378',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 8659 AND piece.composer_id = 105
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'Impressão moura (Canção)', part.name_en = 'Descobrimento do Brasil nº 2, W378: I. Impressão moura (Canção)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 8659 AND p.composer_id = 105 AND part.part_key = 'musicbrainz:32871da8-060e-4881-8d20-3b973c2845a6' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:32871da8-060e-4881-8d20-3b973c2845a6', 1, 'I', 'Impressão moura (Canção)', 'Descobrimento do Brasil nº 2, W378: I. Impressão moura (Canção)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 8659 AND p.composer_id = 105
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:32871da8-060e-4881-8d20-3b973c2845a6'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'Adágio sentimental', part.name_en = 'Descobrimento do Brasil nº 2, W378: II. Adágio sentimental',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 8659 AND p.composer_id = 105 AND part.part_key = 'musicbrainz:ea401dbb-904d-4d8e-a1f2-4b3211ae68d1' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:ea401dbb-904d-4d8e-a1f2-4b3211ae68d1', 2, 'II', 'Adágio sentimental', 'Descobrimento do Brasil nº 2, W378: II. Adágio sentimental', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 8659 AND p.composer_id = 105
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:ea401dbb-904d-4d8e-a1f2-4b3211ae68d1'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = 'Cascavel', part.name_en = 'Descobrimento do Brasil nº 2, W378: III. Cascavel',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 8659 AND p.composer_id = 105 AND part.part_key = 'musicbrainz:32d1bbef-6c9b-4333-a33b-82b0e9df7ce1' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:32d1bbef-6c9b-4333-a33b-82b0e9df7ce1', 3, 'III', 'Cascavel', 'Descobrimento do Brasil nº 2, W378: III. Cascavel', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 8659 AND p.composer_id = 105
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:32d1bbef-6c9b-4333-a33b-82b0e9df7ce1'
);


-- W 379 Descobrimento do Brasil nº 3

UPDATE pieces piece
SET piece.title = 'Descobrimento do Brasil nº 3', piece.title_en = 'Descobrimento do Brasil nº 3, W379',
    piece.type = 'album', piece.opus_number = 'W 379',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 10493 AND piece.composer_id = 105
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'Impressão ibérica', part.name_en = 'Descobrimento do Brasil nº 3, W379: I. Impressão ibérica',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 10493 AND p.composer_id = 105 AND part.part_key = 'musicbrainz:82d779f4-339f-4798-8665-6fb205aabbe4' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:82d779f4-339f-4798-8665-6fb205aabbe4', 1, 'I', 'Impressão ibérica', 'Descobrimento do Brasil nº 3, W379: I. Impressão ibérica', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 10493 AND p.composer_id = 105
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:82d779f4-339f-4798-8665-6fb205aabbe4'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'Festa nas selvas', part.name_en = 'Descobrimento do Brasil nº 3, W379: II. Festa nas selvas',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 10493 AND p.composer_id = 105 AND part.part_key = 'musicbrainz:311acb71-612e-4d12-818f-3b35128a8eb5' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:311acb71-612e-4d12-818f-3b35128a8eb5', 2, 'II', 'Festa nas selvas', 'Descobrimento do Brasil nº 3, W379: II. Festa nas selvas', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 10493 AND p.composer_id = 105
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:311acb71-612e-4d12-818f-3b35128a8eb5'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = 'Ulalocê (Visão dos navegantes)', part.name_en = 'Descobrimento do Brasil nº 3, W379: III. Ulalocê (Visão dos navegantes)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 10493 AND p.composer_id = 105 AND part.part_key = 'musicbrainz:a0ea8f4a-c060-4508-aaef-b233beccd79d' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:a0ea8f4a-c060-4508-aaef-b233beccd79d', 3, 'III', 'Ulalocê (Visão dos navegantes)', 'Descobrimento do Brasil nº 3, W379: III. Ulalocê (Visão dos navegantes)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 10493 AND p.composer_id = 105
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:a0ea8f4a-c060-4508-aaef-b233beccd79d'
);


-- W 380 Descobrimento do Brasil nº 4

UPDATE pieces piece
SET piece.title = 'Descobrimento do Brasil nº 4', piece.title_en = 'Descobrimento do Brasil nº 4, W380',
    piece.type = 'album', piece.opus_number = 'W 380',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 8328 AND piece.composer_id = 105
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'Procissão da cruz', part.name_en = 'Descobrimento do Brasil nº 4, W380: I. Procissão da cruz',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 8328 AND p.composer_id = 105 AND part.part_key = 'musicbrainz:9283f457-b2f5-4207-afc6-221d99109de6' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:9283f457-b2f5-4207-afc6-221d99109de6', 1, 'I', 'Procissão da cruz', 'Descobrimento do Brasil nº 4, W380: I. Procissão da cruz', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 8328 AND p.composer_id = 105
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:9283f457-b2f5-4207-afc6-221d99109de6'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'Primeira missa no Brasil', part.name_en = 'Descobrimento do Brasil nº 4, W380: II. Primeira missa no Brasil',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 8328 AND p.composer_id = 105 AND part.part_key = 'musicbrainz:517606b1-187d-4d1c-a2a6-e595ceefbc9d' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:517606b1-187d-4d1c-a2a6-e595ceefbc9d', 2, 'II', 'Primeira missa no Brasil', 'Descobrimento do Brasil nº 4, W380: II. Primeira missa no Brasil', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 8328 AND p.composer_id = 105
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:517606b1-187d-4d1c-a2a6-e595ceefbc9d'
);


-- None 가곡 <Desejo>

UPDATE pieces piece
SET piece.title = '가곡 <Desejo>', piece.title_en = 'Desejo',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 9557 AND piece.composer_id = 105
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- W 381 Distribuição de flores

UPDATE pieces piece
SET piece.title = 'Distribuição de flores', piece.title_en = 'Distribuição de flores, W381',
    piece.type = 'song', piece.opus_number = 'W 381',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 10480 AND piece.composer_id = 105
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- W 461 Divagação

UPDATE pieces piece
SET piece.title = 'Divagação', piece.title_en = 'Divagação, W461',
    piece.type = 'song', piece.opus_number = 'W 461',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 10591 AND piece.composer_id = 105
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- W 506 Duas lendas ameríndias em nheengatu

UPDATE pieces piece
SET piece.title = 'Duas lendas ameríndias em nheengatu', piece.title_en = 'Duas lendas ameríndias em nheengatu, W506',
    piece.type = 'album', piece.opus_number = 'W 506',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 9815 AND piece.composer_id = 105
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'O iurupari e o menino', part.name_en = 'Duas lendas ameríndias em nheengatu, W506: I. O iurupari e o menino',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 9815 AND p.composer_id = 105 AND part.part_key = 'musicbrainz:063eb73b-f1e7-480e-b934-99e89f783517' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:063eb73b-f1e7-480e-b934-99e89f783517', 1, 'I', 'O iurupari e o menino', 'Duas lendas ameríndias em nheengatu, W506: I. O iurupari e o menino', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 9815 AND p.composer_id = 105
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:063eb73b-f1e7-480e-b934-99e89f783517'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'O iurupari e o caçador', part.name_en = 'Duas lendas ameríndias em nheengatu, W506: II. O iurupari e o caçador',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 9815 AND p.composer_id = 105 AND part.part_key = 'musicbrainz:6a1ac579-fefe-48a8-a16d-85cae35d9f1b' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:6a1ac579-fefe-48a8-a16d-85cae35d9f1b', 2, 'II', 'O iurupari e o caçador', 'Duas lendas ameríndias em nheengatu, W506: II. O iurupari e o caçador', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 9815 AND p.composer_id = 105
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:6a1ac579-fefe-48a8-a16d-85cae35d9f1b'
);


-- W 535 Duo para oboé e fagote

UPDATE pieces piece
SET piece.title = 'Duo para oboé e fagote', piece.title_en = 'Duo para oboé e fagote, W535',
    piece.type = 'album', piece.opus_number = 'W 535',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 10068 AND piece.composer_id = 105
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'Allegro', part.name_en = 'Duo para oboé e fagote, W535: I. Allegro',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 10068 AND p.composer_id = 105 AND part.part_key = 'musicbrainz:323e2ea5-ba4f-4a17-aecf-66de363edae9' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:323e2ea5-ba4f-4a17-aecf-66de363edae9', 1, 'I', 'Allegro', 'Duo para oboé e fagote, W535: I. Allegro', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 10068 AND p.composer_id = 105
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:323e2ea5-ba4f-4a17-aecf-66de363edae9'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'Lento', part.name_en = 'Duo para oboé e fagote, W535: II. Lento',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 10068 AND p.composer_id = 105 AND part.part_key = 'musicbrainz:b4089bb1-02fc-4b0e-b882-0549a500916e' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:b4089bb1-02fc-4b0e-b882-0549a500916e', 2, 'II', 'Lento', 'Duo para oboé e fagote, W535: II. Lento', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 10068 AND p.composer_id = 105
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:b4089bb1-02fc-4b0e-b882-0549a500916e'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = 'Allegro vivace', part.name_en = 'Duo para oboé e fagote, W535: III. Allegro vivace',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 10068 AND p.composer_id = 105 AND part.part_key = 'musicbrainz:f5e87288-89dd-4c18-ad19-e00001eecc19' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:f5e87288-89dd-4c18-ad19-e00001eecc19', 3, 'III', 'Allegro vivace', 'Duo para oboé e fagote, W535: III. Allegro vivace', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 10068 AND p.composer_id = 105
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:f5e87288-89dd-4c18-ad19-e00001eecc19'
);


-- W 463 Duo para violino e viola

UPDATE pieces piece
SET piece.title = 'Duo para violino e viola', piece.title_en = 'Duo para violino e viola, W463',
    piece.type = 'album', piece.opus_number = 'W 463',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 10438 AND piece.composer_id = 105
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'Allegro', part.name_en = 'Duo para violino e viola, W463: I. Allegro',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 10438 AND p.composer_id = 105 AND part.part_key = 'musicbrainz:f92884b8-dba4-498b-958c-93de731d5678' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:f92884b8-dba4-498b-958c-93de731d5678', 1, 'I', 'Allegro', 'Duo para violino e viola, W463: I. Allegro', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 10438 AND p.composer_id = 105
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:f92884b8-dba4-498b-958c-93de731d5678'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'Adagio', part.name_en = 'Duo para violino e viola, W463: II. Adagio',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 10438 AND p.composer_id = 105 AND part.part_key = 'musicbrainz:7674b1b1-1e36-49ba-aafd-5527e0a7a54e' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:7674b1b1-1e36-49ba-aafd-5527e0a7a54e', 2, 'II', 'Adagio', 'Duo para violino e viola, W463: II. Adagio', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 10438 AND p.composer_id = 105
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:7674b1b1-1e36-49ba-aafd-5527e0a7a54e'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = 'Allegro agitato', part.name_en = 'Duo para violino e viola, W463: III. Allegro agitato',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 10438 AND p.composer_id = 105 AND part.part_key = 'musicbrainz:2c426608-941c-4478-bdf2-026b83314f45' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:2c426608-941c-4478-bdf2-026b83314f45', 3, 'III', 'Allegro agitato', 'Duo para violino e viola, W463: III. Allegro agitato', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 10438 AND p.composer_id = 105
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:2c426608-941c-4478-bdf2-026b83314f45'
);


-- W 183 Epigramas irônicos e sentimentais W 183

UPDATE pieces piece
SET piece.title = 'Epigramas irônicos e sentimentais W 183', piece.title_en = 'Epigramas irônicos e sentimentais, W183',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = 'W', piece.catalogue_number = '183',
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 11264 AND piece.composer_id = 105
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'Verdade', part.name_en = 'Epigramas irônicos e sentimentais, W183: No. 8. Verdade',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11264 AND p.composer_id = 105 AND part.part_key = 'musicbrainz:1e6db166-7f14-4c13-a260-2a0e8f560de7' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:1e6db166-7f14-4c13-a260-2a0e8f560de7', 1, NULL, 'Verdade', 'Epigramas irônicos e sentimentais, W183: No. 8. Verdade', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 11264 AND p.composer_id = 105
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:1e6db166-7f14-4c13-a260-2a0e8f560de7'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'Pudor', part.name_en = 'Epigramas irônicos e sentimentais, W183: No. 6. Pudor',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11264 AND p.composer_id = 105 AND part.part_key = 'musicbrainz:308b1e67-96be-4b21-8a58-8e505a5ff556' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:308b1e67-96be-4b21-8a58-8e505a5ff556', 2, NULL, 'Pudor', 'Epigramas irônicos e sentimentais, W183: No. 6. Pudor', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 11264 AND p.composer_id = 105
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:308b1e67-96be-4b21-8a58-8e505a5ff556'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = NULL,
    part.name_ko = 'Eis a vida', part.name_en = 'Epigramas irônicos e sentimentais, W183: No. 1. Eis a vida',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11264 AND p.composer_id = 105 AND part.part_key = 'musicbrainz:58ba4b66-4b48-45fe-aef0-a3d3fb3cd200' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:58ba4b66-4b48-45fe-aef0-a3d3fb3cd200', 3, NULL, 'Eis a vida', 'Epigramas irônicos e sentimentais, W183: No. 1. Eis a vida', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 11264 AND p.composer_id = 105
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:58ba4b66-4b48-45fe-aef0-a3d3fb3cd200'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = NULL,
    part.name_ko = 'Inútil epigrama', part.name_en = 'Epigramas irônicos e sentimentais, W183: No. 2. Inútil epigrama',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11264 AND p.composer_id = 105 AND part.part_key = 'musicbrainz:6637b3b0-d134-4f78-a2fa-54334d2ae4d9' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:6637b3b0-d134-4f78-a2fa-54334d2ae4d9', 4, NULL, 'Inútil epigrama', 'Epigramas irônicos e sentimentais, W183: No. 2. Inútil epigrama', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 11264 AND p.composer_id = 105
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:6637b3b0-d134-4f78-a2fa-54334d2ae4d9'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 5, part.movement_number = NULL,
    part.name_ko = 'Perversidade', part.name_en = 'Epigramas irônicos e sentimentais, W183: No. 5. Perversidade',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11264 AND p.composer_id = 105 AND part.part_key = 'musicbrainz:76a76ea3-0896-4e1c-879f-2baacd20988d' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:76a76ea3-0896-4e1c-879f-2baacd20988d', 5, NULL, 'Perversidade', 'Epigramas irônicos e sentimentais, W183: No. 5. Perversidade', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 11264 AND p.composer_id = 105
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:76a76ea3-0896-4e1c-879f-2baacd20988d'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 6, part.movement_number = NULL,
    part.name_ko = 'Sonho de uma noite de verão', part.name_en = 'Epigramas irônicos e sentimentais, W183: No. 3. Sonho de uma noite de verão',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11264 AND p.composer_id = 105 AND part.part_key = 'musicbrainz:83903bd8-5fe2-401e-9bab-5e6863229cdc' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:83903bd8-5fe2-401e-9bab-5e6863229cdc', 6, NULL, 'Sonho de uma noite de verão', 'Epigramas irônicos e sentimentais, W183: No. 3. Sonho de uma noite de verão', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 11264 AND p.composer_id = 105
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:83903bd8-5fe2-401e-9bab-5e6863229cdc'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 7, part.movement_number = NULL,
    part.name_ko = 'Imagem', part.name_en = 'Epigramas irônicos e sentimentais, W183: No. 7. Imagem',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11264 AND p.composer_id = 105 AND part.part_key = 'musicbrainz:a29d5d02-269e-48a0-a447-3e82ddde6801' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:a29d5d02-269e-48a0-a447-3e82ddde6801', 7, NULL, 'Imagem', 'Epigramas irônicos e sentimentais, W183: No. 7. Imagem', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 11264 AND p.composer_id = 105
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:a29d5d02-269e-48a0-a447-3e82ddde6801'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 8, part.movement_number = NULL,
    part.name_ko = 'Epigrama', part.name_en = 'Epigramas irônicos e sentimentais, W183: No. 4. Epigrama',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11264 AND p.composer_id = 105 AND part.part_key = 'musicbrainz:b0f57a5c-6003-45fe-bd08-2c6d30003927' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:b0f57a5c-6003-45fe-bd08-2c6d30003927', 8, NULL, 'Epigrama', 'Epigramas irônicos e sentimentais, W183: No. 4. Epigrama', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 11264 AND p.composer_id = 105
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:b0f57a5c-6003-45fe-bd08-2c6d30003927'
);


-- W 495 Erosão

UPDATE pieces piece
SET piece.title = 'Erosão', piece.title_en = 'Erosão, W495',
    piece.type = 'song', piece.opus_number = 'W 495',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 7485 AND piece.composer_id = 105
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- W 549 Fantasia Concertante

UPDATE pieces piece
SET piece.title = 'Fantasia Concertante', piece.title_en = 'Fantasia Concertante, W549',
    piece.type = 'album', piece.opus_number = 'W 549',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 10680 AND piece.composer_id = 105
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'Allegro', part.name_en = 'Fantasia Concertante, W549: I. Allegro',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 10680 AND p.composer_id = 105 AND part.part_key = 'musicbrainz:6ce9ed6d-c7e3-4c73-a679-fa6ed8d4878f' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:6ce9ed6d-c7e3-4c73-a679-fa6ed8d4878f', 1, 'I', 'Allegro', 'Fantasia Concertante, W549: I. Allegro', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 10680 AND p.composer_id = 105
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:6ce9ed6d-c7e3-4c73-a679-fa6ed8d4878f'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'Lento', part.name_en = 'Fantasia Concertante, W549: II. Lento',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 10680 AND p.composer_id = 105 AND part.part_key = 'musicbrainz:06803dd2-c636-4c1e-8381-60813f0e1c67' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:06803dd2-c636-4c1e-8381-60813f0e1c67', 2, 'II', 'Lento', 'Fantasia Concertante, W549: II. Lento', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 10680 AND p.composer_id = 105
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:06803dd2-c636-4c1e-8381-60813f0e1c67'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = 'Allegretto scherzando – Molto allegro', part.name_en = 'Fantasia Concertante, W549: III. Allegretto scherzando – Molto allegro',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 10680 AND p.composer_id = 105 AND part.part_key = 'musicbrainz:f2f1a38b-4cba-4cd5-9133-e2b4ccde3e05' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:f2f1a38b-4cba-4cd5-9133-e2b4ccde3e05', 3, 'III', 'Allegretto scherzando – Molto allegro', 'Fantasia Concertante, W549: III. Allegretto scherzando – Molto allegro', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 10680 AND p.composer_id = 105
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:f2f1a38b-4cba-4cd5-9133-e2b4ccde3e05'
);


-- W 517 Fantasia concertante W 517

UPDATE pieces piece
SET piece.title = 'Fantasia concertante W 517', piece.title_en = 'Fantasia concertante, W517',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = 'W', piece.catalogue_number = '517',
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 9817 AND piece.composer_id = 105
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'Allegro non troppo', part.name_en = 'Fantasia concertante, W517: I. Allegro non troppo',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 9817 AND p.composer_id = 105 AND part.part_key = 'musicbrainz:126506b1-d80a-4676-a449-f545ee5cdb8a' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:126506b1-d80a-4676-a449-f545ee5cdb8a', 1, 'I', 'Allegro non troppo', 'Fantasia concertante, W517: I. Allegro non troppo', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 9817 AND p.composer_id = 105
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:126506b1-d80a-4676-a449-f545ee5cdb8a'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'Lento', part.name_en = 'Fantasia concertante, W517: II. Lento',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 9817 AND p.composer_id = 105 AND part.part_key = 'musicbrainz:6c300fb2-a957-4cea-b4af-894f765a76eb' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:6c300fb2-a957-4cea-b4af-894f765a76eb', 2, 'II', 'Lento', 'Fantasia concertante, W517: II. Lento', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 9817 AND p.composer_id = 105
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:6c300fb2-a957-4cea-b4af-894f765a76eb'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = 'Allegro impetuoso', part.name_en = 'Fantasia concertante, W517: III. Allegro impetuoso',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 9817 AND p.composer_id = 105 AND part.part_key = 'musicbrainz:e70a1d26-5545-4997-b6ee-227868fa821a' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:e70a1d26-5545-4997-b6ee-227868fa821a', 3, 'III', 'Allegro impetuoso', 'Fantasia concertante, W517: III. Allegro impetuoso', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 9817 AND p.composer_id = 105
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:e70a1d26-5545-4997-b6ee-227868fa821a'
);


-- None Fantasia em três movimentos em forma de chôros

UPDATE pieces piece
SET piece.title = 'Fantasia em três movimentos em forma de chôros', piece.title_en = 'Fantasia em três movimentos em forma de chôros',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 10063 AND piece.composer_id = 105
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'Andante quasi adagio', part.name_en = 'Fantasia em três movimentos em forma de chôros: I. Andante quasi adagio',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 10063 AND p.composer_id = 105 AND part.part_key = 'musicbrainz:93701365-43d0-46b9-a5b8-50393a7a0690' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:93701365-43d0-46b9-a5b8-50393a7a0690', 1, 'I', 'Andante quasi adagio', 'Fantasia em três movimentos em forma de chôros: I. Andante quasi adagio', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 10063 AND p.composer_id = 105
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:93701365-43d0-46b9-a5b8-50393a7a0690'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'Allegretto (Scherzando)', part.name_en = 'Fantasia em três movimentos em forma de chôros: II. Allegretto (Scherzando)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 10063 AND p.composer_id = 105 AND part.part_key = 'musicbrainz:13d6d165-2930-48f5-8ff0-d9bf45d124b8' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:13d6d165-2930-48f5-8ff0-d9bf45d124b8', 2, 'II', 'Allegretto (Scherzando)', 'Fantasia em três movimentos em forma de chôros: II. Allegretto (Scherzando)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 10063 AND p.composer_id = 105
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:13d6d165-2930-48f5-8ff0-d9bf45d124b8'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = 'Molto allegro', part.name_en = 'Fantasia em três movimentos em forma de chôros: III. Molto allegro',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 10063 AND p.composer_id = 105 AND part.part_key = 'musicbrainz:f281f44e-318b-44a9-b2a0-2fea41da639a' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:f281f44e-318b-44a9-b2a0-2fea41da639a', 3, 'III', 'Molto allegro', 'Fantasia em três movimentos em forma de chôros: III. Molto allegro', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 10063 AND p.composer_id = 105
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:f281f44e-318b-44a9-b2a0-2fea41da639a'
);


-- W 454 Fantasia para cello e orquestra

UPDATE pieces piece
SET piece.title = 'Fantasia para cello e orquestra', piece.title_en = 'Fantasia para cello e orquestra, W454',
    piece.type = 'album', piece.opus_number = 'W 454',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 8931 AND piece.composer_id = 105
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'Largo', part.name_en = 'Fantasia para cello e orquestra, W454: I. Largo',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 8931 AND p.composer_id = 105 AND part.part_key = 'musicbrainz:b1fac05e-02b3-32c2-a808-bd08342e8655' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:b1fac05e-02b3-32c2-a808-bd08342e8655', 1, 'I', 'Largo', 'Fantasia para cello e orquestra, W454: I. Largo', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 8931 AND p.composer_id = 105
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:b1fac05e-02b3-32c2-a808-bd08342e8655'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'Molto vivace', part.name_en = 'Fantasia para cello e orquestra, W454: II. Molto vivace',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 8931 AND p.composer_id = 105 AND part.part_key = 'musicbrainz:b7c57559-0f7e-3a6d-9bc0-29d8d9d24936' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:b7c57559-0f7e-3a6d-9bc0-29d8d9d24936', 2, 'II', 'Molto vivace', 'Fantasia para cello e orquestra, W454: II. Molto vivace', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 8931 AND p.composer_id = 105
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:b7c57559-0f7e-3a6d-9bc0-29d8d9d24936'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = 'Allegro espressivo', part.name_en = 'Fantasia para cello e orquestra, W454: III. Allegro espressivo',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 8931 AND p.composer_id = 105 AND part.part_key = 'musicbrainz:f7730ce9-9938-3d3a-956f-2cdd22482c32' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:f7730ce9-9938-3d3a-956f-2cdd22482c32', 3, 'III', 'Allegro espressivo', 'Fantasia para cello e orquestra, W454: III. Allegro espressivo', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 8931 AND p.composer_id = 105
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:f7730ce9-9938-3d3a-956f-2cdd22482c32'
);


-- W 490 Fantasia para saxophone e orquestra

UPDATE pieces piece
SET piece.title = 'Fantasia para saxophone e orquestra', piece.title_en = 'Fantasia para saxophone e orquestra, W490',
    piece.type = 'album', piece.opus_number = 'W 490',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 9225 AND piece.composer_id = 105
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'Animé', part.name_en = 'Fantasia para saxophone e orquestra, W490: I. Animé',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 9225 AND p.composer_id = 105 AND part.part_key = 'musicbrainz:94a75bdb-f4d7-43c0-bd96-7a0120bfb50e' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:94a75bdb-f4d7-43c0-bd96-7a0120bfb50e', 1, 'I', 'Animé', 'Fantasia para saxophone e orquestra, W490: I. Animé', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 9225 AND p.composer_id = 105
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:94a75bdb-f4d7-43c0-bd96-7a0120bfb50e'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'Lent', part.name_en = 'Fantasia para saxophone e orquestra, W490: II. Lent',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 9225 AND p.composer_id = 105 AND part.part_key = 'musicbrainz:cbe93330-b9f0-45dd-ba2b-0d8839bd5bf1' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:cbe93330-b9f0-45dd-ba2b-0d8839bd5bf1', 2, 'II', 'Lent', 'Fantasia para saxophone e orquestra, W490: II. Lent', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 9225 AND p.composer_id = 105
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:cbe93330-b9f0-45dd-ba2b-0d8839bd5bf1'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = 'Très animé', part.name_en = 'Fantasia para saxophone e orquestra, W490: III. Très animé',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 9225 AND p.composer_id = 105 AND part.part_key = 'musicbrainz:547cd383-b813-4745-84a3-1e57cc20a4bd' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:547cd383-b813-4745-84a3-1e57cc20a4bd', 3, 'III', 'Très animé', 'Fantasia para saxophone e orquestra, W490: III. Très animé', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 9225 AND p.composer_id = 105
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:547cd383-b813-4745-84a3-1e57cc20a4bd'
);


-- None Feijoada sem perigo

UPDATE pieces piece
SET piece.title = 'Feijoada sem perigo', piece.title_en = 'Feijoada sem perigo',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 8501 AND piece.composer_id = 105
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- W 551 Floresta do Amazonas W 551

UPDATE pieces piece
SET piece.title = 'Floresta do Amazonas W 551', piece.title_en = 'Floresta do Amazonas, W551',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = 'W', piece.catalogue_number = '551',
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 9002 AND piece.composer_id = 105
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'Ouverture', part.name_en = 'Floresta do Amazonas: Ouverture',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 9002 AND p.composer_id = 105 AND part.part_key = 'musicbrainz:8c067863-cda4-4a68-892c-91c48bd6c4db' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:8c067863-cda4-4a68-892c-91c48bd6c4db', 1, NULL, 'Ouverture', 'Floresta do Amazonas: Ouverture', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 9002 AND p.composer_id = 105
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:8c067863-cda4-4a68-892c-91c48bd6c4db'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'A Floresta', part.name_en = 'Floresta do Amazonas: A Floresta',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 9002 AND p.composer_id = 105 AND part.part_key = 'musicbrainz:668b11da-4205-41fd-93e0-b29409241230' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:668b11da-4205-41fd-93e0-b29409241230', 2, NULL, 'A Floresta', 'Floresta do Amazonas: A Floresta', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 9002 AND p.composer_id = 105
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:668b11da-4205-41fd-93e0-b29409241230'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = NULL,
    part.name_ko = 'Dança dos Índios', part.name_en = 'Floresta do Amazonas: Dança dos Índios',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 9002 AND p.composer_id = 105 AND part.part_key = 'musicbrainz:0d12e890-5b64-48e9-931c-60e0ec1a7d8a' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:0d12e890-5b64-48e9-931c-60e0ec1a7d8a', 3, NULL, 'Dança dos Índios', 'Floresta do Amazonas: Dança dos Índios', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 9002 AND p.composer_id = 105
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:0d12e890-5b64-48e9-931c-60e0ec1a7d8a'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = NULL,
    part.name_ko = 'Em Plena Floresta', part.name_en = 'Floresta do Amazonas: Em Plena Floresta',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 9002 AND p.composer_id = 105 AND part.part_key = 'musicbrainz:9d275945-1d89-4498-8c24-7d426663570c' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:9d275945-1d89-4498-8c24-7d426663570c', 4, NULL, 'Em Plena Floresta', 'Floresta do Amazonas: Em Plena Floresta', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 9002 AND p.composer_id = 105
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:9d275945-1d89-4498-8c24-7d426663570c'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 5, part.movement_number = NULL,
    part.name_ko = 'Pássaro da Floresta – Canto I', part.name_en = 'Floresta do Amazonas: Pássaro da Floresta – Canto I',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 9002 AND p.composer_id = 105 AND part.part_key = 'musicbrainz:16febad3-b867-4b3d-98d9-d6ec7ffa0ca9' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:16febad3-b867-4b3d-98d9-d6ec7ffa0ca9', 5, NULL, 'Pássaro da Floresta – Canto I', 'Floresta do Amazonas: Pássaro da Floresta – Canto I', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 9002 AND p.composer_id = 105
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:16febad3-b867-4b3d-98d9-d6ec7ffa0ca9'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 6, part.movement_number = NULL,
    part.name_ko = 'Dança da Natureza', part.name_en = 'Floresta do Amazonas: Dança da Natureza',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 9002 AND p.composer_id = 105 AND part.part_key = 'musicbrainz:8993157f-dd98-47ba-b6f3-0f4c41720259' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:8993157f-dd98-47ba-b6f3-0f4c41720259', 6, NULL, 'Dança da Natureza', 'Floresta do Amazonas: Dança da Natureza', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 9002 AND p.composer_id = 105
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:8993157f-dd98-47ba-b6f3-0f4c41720259'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 7, part.movement_number = NULL,
    part.name_ko = 'Pássaro da Floresta – Canto II', part.name_en = 'Floresta do Amazonas: Pássaro da Floresta – Canto II',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 9002 AND p.composer_id = 105 AND part.part_key = 'musicbrainz:5dc22113-2cb3-471b-b047-ec64a0858c71' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:5dc22113-2cb3-471b-b047-ec64a0858c71', 7, NULL, 'Pássaro da Floresta – Canto II', 'Floresta do Amazonas: Pássaro da Floresta – Canto II', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 9002 AND p.composer_id = 105
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:5dc22113-2cb3-471b-b047-ec64a0858c71'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 8, part.movement_number = NULL,
    part.name_ko = 'Canto na Floresta I', part.name_en = 'Floresta do Amazonas: Canto na Floresta I',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 9002 AND p.composer_id = 105 AND part.part_key = 'musicbrainz:0f727b28-ec20-41f8-be34-6962bafc0c71' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:0f727b28-ec20-41f8-be34-6962bafc0c71', 8, NULL, 'Canto na Floresta I', 'Floresta do Amazonas: Canto na Floresta I', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 9002 AND p.composer_id = 105
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:0f727b28-ec20-41f8-be34-6962bafc0c71'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 9, part.movement_number = NULL,
    part.name_ko = 'Conspiração e Dança Guerreira', part.name_en = 'Floresta do Amazonas: Conspiração e Dança Guerreira',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 9002 AND p.composer_id = 105 AND part.part_key = 'musicbrainz:93ee485b-5acf-40f6-8f00-28df770ccfee' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:93ee485b-5acf-40f6-8f00-28df770ccfee', 9, NULL, 'Conspiração e Dança Guerreira', 'Floresta do Amazonas: Conspiração e Dança Guerreira', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 9002 AND p.composer_id = 105
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:93ee485b-5acf-40f6-8f00-28df770ccfee'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 10, part.movement_number = NULL,
    part.name_ko = 'Veleiros', part.name_en = 'Floresta do Amazonas: Veleiros',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 9002 AND p.composer_id = 105 AND part.part_key = 'musicbrainz:7f8b15b6-9ef1-40bd-8af9-b94dbb4fda43' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:7f8b15b6-9ef1-40bd-8af9-b94dbb4fda43', 10, NULL, 'Veleiros', 'Floresta do Amazonas: Veleiros', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 9002 AND p.composer_id = 105
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:7f8b15b6-9ef1-40bd-8af9-b94dbb4fda43'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 11, part.movement_number = NULL,
    part.name_ko = 'Em Caminhos para a Caçada', part.name_en = 'Floresta do Amazonas: Em Caminhos para a Caçada',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 9002 AND p.composer_id = 105 AND part.part_key = 'musicbrainz:fcac8b6c-fa5e-4a30-a874-450518340350' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:fcac8b6c-fa5e-4a30-a874-450518340350', 11, NULL, 'Em Caminhos para a Caçada', 'Floresta do Amazonas: Em Caminhos para a Caçada', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 9002 AND p.composer_id = 105
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:fcac8b6c-fa5e-4a30-a874-450518340350'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 12, part.movement_number = NULL,
    part.name_ko = 'Pássaro da Floresta – Canto III', part.name_en = 'Floresta do Amazonas: Pássaro da Floresta – Canto III',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 9002 AND p.composer_id = 105 AND part.part_key = 'musicbrainz:f97b6d9f-4bf1-49ac-b57a-8e9e62e258d2' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:f97b6d9f-4bf1-49ac-b57a-8e9e62e258d2', 12, NULL, 'Pássaro da Floresta – Canto III', 'Floresta do Amazonas: Pássaro da Floresta – Canto III', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 9002 AND p.composer_id = 105
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:f97b6d9f-4bf1-49ac-b57a-8e9e62e258d2'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 13, part.movement_number = NULL,
    part.name_ko = 'Cair da Tarde', part.name_en = 'Floresta do Amazonas: Cair da Tarde',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 9002 AND p.composer_id = 105 AND part.part_key = 'musicbrainz:1ca130f8-b067-488a-a424-6197ae972fe5' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:1ca130f8-b067-488a-a424-6197ae972fe5', 13, NULL, 'Cair da Tarde', 'Floresta do Amazonas: Cair da Tarde', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 9002 AND p.composer_id = 105
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:1ca130f8-b067-488a-a424-6197ae972fe5'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 14, part.movement_number = NULL,
    part.name_ko = 'Os Índios em Busca da Moça', part.name_en = 'Floresta do Amazonas: Os Índios em Busca da Moça',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 9002 AND p.composer_id = 105 AND part.part_key = 'musicbrainz:b5cd2836-0268-4bb3-96bd-e7668a8b40b4' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:b5cd2836-0268-4bb3-96bd-e7668a8b40b4', 14, NULL, 'Os Índios em Busca da Moça', 'Floresta do Amazonas: Os Índios em Busca da Moça', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 9002 AND p.composer_id = 105
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:b5cd2836-0268-4bb3-96bd-e7668a8b40b4'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 15, part.movement_number = NULL,
    part.name_ko = 'Pássaro da Floresta – Canto IV', part.name_en = 'Floresta do Amazonas: Pássaro da Floresta – Canto IV',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 9002 AND p.composer_id = 105 AND part.part_key = 'musicbrainz:6dd62097-ac20-4ef6-b6fb-eb785407785f' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:6dd62097-ac20-4ef6-b6fb-eb785407785f', 15, NULL, 'Pássaro da Floresta – Canto IV', 'Floresta do Amazonas: Pássaro da Floresta – Canto IV', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 9002 AND p.composer_id = 105
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:6dd62097-ac20-4ef6-b6fb-eb785407785f'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 16, part.movement_number = NULL,
    part.name_ko = 'Dança Guerreira – repetição', part.name_en = 'Floresta do Amazonas: Dança Guerreira – repetição',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 9002 AND p.composer_id = 105 AND part.part_key = 'musicbrainz:823b155a-3f08-441c-8d63-edf3e052ebd2' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:823b155a-3f08-441c-8d63-edf3e052ebd2', 16, NULL, 'Dança Guerreira – repetição', 'Floresta do Amazonas: Dança Guerreira – repetição', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 9002 AND p.composer_id = 105
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:823b155a-3f08-441c-8d63-edf3e052ebd2'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 17, part.movement_number = NULL,
    part.name_ko = 'Interlúdio e Acalanto', part.name_en = 'Floresta do Amazonas: Interlúdio e Acalanto',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 9002 AND p.composer_id = 105 AND part.part_key = 'musicbrainz:e0e825cc-9657-43b1-8dda-becbb1e0bc23' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:e0e825cc-9657-43b1-8dda-becbb1e0bc23', 17, NULL, 'Interlúdio e Acalanto', 'Floresta do Amazonas: Interlúdio e Acalanto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 9002 AND p.composer_id = 105
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:e0e825cc-9657-43b1-8dda-becbb1e0bc23'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 18, part.movement_number = NULL,
    part.name_ko = 'Canto na Floresta II', part.name_en = 'Floresta do Amazonas: Canto na Floresta II',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 9002 AND p.composer_id = 105 AND part.part_key = 'musicbrainz:9926f7c1-e219-447b-aad7-7e62f12d5f13' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:9926f7c1-e219-447b-aad7-7e62f12d5f13', 18, NULL, 'Canto na Floresta II', 'Floresta do Amazonas: Canto na Floresta II', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 9002 AND p.composer_id = 105
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:9926f7c1-e219-447b-aad7-7e62f12d5f13'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 19, part.movement_number = NULL,
    part.name_ko = 'Caçadores de Cabeça', part.name_en = 'Floresta do Amazonas: Caçadores de Cabeça',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 9002 AND p.composer_id = 105 AND part.part_key = 'musicbrainz:2917f872-a130-4e2e-ab8e-1786d4195f93' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:2917f872-a130-4e2e-ab8e-1786d4195f93', 19, NULL, 'Caçadores de Cabeça', 'Floresta do Amazonas: Caçadores de Cabeça', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 9002 AND p.composer_id = 105
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:2917f872-a130-4e2e-ab8e-1786d4195f93'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 20, part.movement_number = NULL,
    part.name_ko = 'Canção do Amor', part.name_en = 'Floresta do Amazonas: Canção do Amor',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 9002 AND p.composer_id = 105 AND part.part_key = 'musicbrainz:a2a631a8-76f7-4e8d-918f-26ad4d745714' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:a2a631a8-76f7-4e8d-918f-26ad4d745714', 20, NULL, 'Canção do Amor', 'Floresta do Amazonas: Canção do Amor', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 9002 AND p.composer_id = 105
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:a2a631a8-76f7-4e8d-918f-26ad4d745714'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 21, part.movement_number = NULL,
    part.name_ko = 'Melodia sentimental', part.name_en = 'Floresta do Amazonas: Melodia sentimental',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 9002 AND p.composer_id = 105 AND part.part_key = 'musicbrainz:adba7e45-e698-46a4-bb87-7f86ee96f782' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:adba7e45-e698-46a4-bb87-7f86ee96f782', 21, NULL, 'Melodia sentimental', 'Floresta do Amazonas: Melodia sentimental', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 9002 AND p.composer_id = 105
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:adba7e45-e698-46a4-bb87-7f86ee96f782'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 22, part.movement_number = NULL,
    part.name_ko = 'O Fogo na Floresta', part.name_en = 'Floresta do Amazonas: O Fogo na Floresta',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 9002 AND p.composer_id = 105 AND part.part_key = 'musicbrainz:5850e21b-1c7c-4974-a5df-bde76463bd47' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:5850e21b-1c7c-4974-a5df-bde76463bd47', 22, NULL, 'O Fogo na Floresta', 'Floresta do Amazonas: O Fogo na Floresta', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 9002 AND p.composer_id = 105
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:5850e21b-1c7c-4974-a5df-bde76463bd47'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 23, part.movement_number = NULL,
    part.name_ko = 'Epílogo', part.name_en = 'Floresta do Amazonas: Epílogo',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 9002 AND p.composer_id = 105 AND part.part_key = 'musicbrainz:d08f5000-51c8-4dc4-aeb5-9295b6f88e7f' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:d08f5000-51c8-4dc4-aeb5-9295b6f88e7f', 23, NULL, 'Epílogo', 'Floresta do Amazonas: Epílogo', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 9002 AND p.composer_id = 105
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:d08f5000-51c8-4dc4-aeb5-9295b6f88e7f'
);


-- W 237 Francette et Pià W 237

UPDATE pieces piece
SET piece.title = 'Francette et Pià W 237', piece.title_en = 'Francette et Pià, W237',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = 'W', piece.catalogue_number = '237',
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 10006 AND piece.composer_id = 105
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'Pià est venu en France', part.name_en = 'Francette et Pià: No. 1. Pià est venu en France',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 10006 AND p.composer_id = 105 AND part.part_key = 'musicbrainz:ccbe754d-d8b7-4ae2-8bc7-24f80b862eb3' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:ccbe754d-d8b7-4ae2-8bc7-24f80b862eb3', 1, NULL, 'Pià est venu en France', 'Francette et Pià: No. 1. Pià est venu en France', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 10006 AND p.composer_id = 105
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:ccbe754d-d8b7-4ae2-8bc7-24f80b862eb3'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'Pià a vu la France', part.name_en = 'Francette et Pià: No. 2. Pià a vu la France',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 10006 AND p.composer_id = 105 AND part.part_key = 'musicbrainz:8f595e58-de46-4240-a0a9-85d7fbc90897' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:8f595e58-de46-4240-a0a9-85d7fbc90897', 2, NULL, 'Pià a vu la France', 'Francette et Pià: No. 2. Pià a vu la France', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 10006 AND p.composer_id = 105
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:8f595e58-de46-4240-a0a9-85d7fbc90897'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = NULL,
    part.name_ko = 'Pià a parlé à Francette', part.name_en = 'Francette et Pià: No. 3. Pià a parlé à Francette',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 10006 AND p.composer_id = 105 AND part.part_key = 'musicbrainz:a67721c4-b283-4605-83d3-f0bbe143e556' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:a67721c4-b283-4605-83d3-f0bbe143e556', 3, NULL, 'Pià a parlé à Francette', 'Francette et Pià: No. 3. Pià a parlé à Francette', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 10006 AND p.composer_id = 105
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:a67721c4-b283-4605-83d3-f0bbe143e556'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = NULL,
    part.name_ko = 'Pià et Francette jouent ensemble', part.name_en = 'Francette et Pià: No. 4. Pià et Francette jouent ensemble',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 10006 AND p.composer_id = 105 AND part.part_key = 'musicbrainz:39d1fa61-d970-4912-87e4-cd59d622ac53' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:39d1fa61-d970-4912-87e4-cd59d622ac53', 4, NULL, 'Pià et Francette jouent ensemble', 'Francette et Pià: No. 4. Pià et Francette jouent ensemble', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 10006 AND p.composer_id = 105
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:39d1fa61-d970-4912-87e4-cd59d622ac53'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 5, part.movement_number = NULL,
    part.name_ko = 'Francette est fâchée', part.name_en = 'Francette et Pià: No. 5. Francette est fâchée',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 10006 AND p.composer_id = 105 AND part.part_key = 'musicbrainz:8b08f34b-086d-4b17-bb24-d54cf9f31ad8' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:8b08f34b-086d-4b17-bb24-d54cf9f31ad8', 5, NULL, 'Francette est fâchée', 'Francette et Pià: No. 5. Francette est fâchée', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 10006 AND p.composer_id = 105
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:8b08f34b-086d-4b17-bb24-d54cf9f31ad8'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 6, part.movement_number = NULL,
    part.name_ko = 'Pià est parti pour la guerre', part.name_en = 'Francette et Pià: No. 6. Pià est parti pour la guerre',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 10006 AND p.composer_id = 105 AND part.part_key = 'musicbrainz:2c9694bc-de9e-499e-bc6f-a4a4ac3ac0de' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:2c9694bc-de9e-499e-bc6f-a4a4ac3ac0de', 6, NULL, 'Pià est parti pour la guerre', 'Francette et Pià: No. 6. Pià est parti pour la guerre', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 10006 AND p.composer_id = 105
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:2c9694bc-de9e-499e-bc6f-a4a4ac3ac0de'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 7, part.movement_number = NULL,
    part.name_ko = 'Francette est triste', part.name_en = 'Francette et Pià: No. 7. Francette est triste',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 10006 AND p.composer_id = 105 AND part.part_key = 'musicbrainz:2331c747-079e-46f6-9444-cd6abcd55894' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:2331c747-079e-46f6-9444-cd6abcd55894', 7, NULL, 'Francette est triste', 'Francette et Pià: No. 7. Francette est triste', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 10006 AND p.composer_id = 105
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:2331c747-079e-46f6-9444-cd6abcd55894'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 8, part.movement_number = NULL,
    part.name_ko = 'Pià revient de la guerre', part.name_en = 'Francette et Pià: No. 8. Pià revient de la guerre',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 10006 AND p.composer_id = 105 AND part.part_key = 'musicbrainz:923cf06c-a8d8-4456-8541-26c0ef65277e' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:923cf06c-a8d8-4456-8541-26c0ef65277e', 8, NULL, 'Pià revient de la guerre', 'Francette et Pià: No. 8. Pià revient de la guerre', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 10006 AND p.composer_id = 105
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:923cf06c-a8d8-4456-8541-26c0ef65277e'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 9, part.movement_number = NULL,
    part.name_ko = 'Francette est contente', part.name_en = 'Francette et Pià: No. 9. Francette est contente',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 10006 AND p.composer_id = 105 AND part.part_key = 'musicbrainz:7cf80570-61f3-4470-8177-04e0d844cd59' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:7cf80570-61f3-4470-8177-04e0d844cd59', 9, NULL, 'Francette est contente', 'Francette et Pià: No. 9. Francette est contente', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 10006 AND p.composer_id = 105
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:7cf80570-61f3-4470-8177-04e0d844cd59'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 10, part.movement_number = NULL,
    part.name_ko = 'Francette et Pià jouent pour toujours', part.name_en = 'Francette et Pià: No. 10. Francette et Pià jouent pour toujours',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 10006 AND p.composer_id = 105 AND part.part_key = 'musicbrainz:10313df9-7eda-400c-9326-167d4243d3c8' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:10313df9-7eda-400c-9326-167d4243d3c8', 10, NULL, 'Francette et Pià jouent pour toujours', 'Francette et Pià: No. 10. Francette et Pià jouent pour toujours', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 10006 AND p.composer_id = 105
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:10313df9-7eda-400c-9326-167d4243d3c8'
);


-- Op. 65 Fábulas características Op. 65

UPDATE pieces piece
SET piece.title = 'Fábulas características Op. 65', piece.title_en = 'Fábulas características, op. 65, W076',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = 'Op.', piece.catalogue_number = '65',
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 8291 AND piece.composer_id = 105
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'O cuco e o gato', part.name_en = 'Fábulas características, op. 65, W076, nº 1: O cuco e o gato',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 8291 AND p.composer_id = 105 AND part.part_key = 'musicbrainz:d23e94f0-cfe3-4223-9501-32ec76cb927b' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:d23e94f0-cfe3-4223-9501-32ec76cb927b', 1, NULL, 'O cuco e o gato', 'Fábulas características, op. 65, W076, nº 1: O cuco e o gato', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 8291 AND p.composer_id = 105
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:d23e94f0-cfe3-4223-9501-32ec76cb927b'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'A araponga e o irerê', part.name_en = 'Fábulas características, op. 65, W076, nº 2: A araponga e o irerê',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 8291 AND p.composer_id = 105 AND part.part_key = 'musicbrainz:c7508827-aeaf-4ebe-8b12-415170c92368' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:c7508827-aeaf-4ebe-8b12-415170c92368', 2, NULL, 'A araponga e o irerê', 'Fábulas características, op. 65, W076, nº 2: A araponga e o irerê', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 8291 AND p.composer_id = 105
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:c7508827-aeaf-4ebe-8b12-415170c92368'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = NULL,
    part.name_ko = 'O gato e o rato', part.name_en = 'Fábulas características, op. 65, W076, nº 3: O gato e o rato',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 8291 AND p.composer_id = 105 AND part.part_key = 'musicbrainz:7f723b8b-6944-4164-b683-32b72e66975c' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:7f723b8b-6944-4164-b683-32b72e66975c', 3, NULL, 'O gato e o rato', 'Fábulas características, op. 65, W076, nº 3: O gato e o rato', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 8291 AND p.composer_id = 105
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:7f723b8b-6944-4164-b683-32b72e66975c'
);


-- W 277 Guia prático nº 1 W 277

UPDATE pieces piece
SET piece.title = 'Guia prático nº 1 W 277', piece.title_en = 'Guia prático nº 1, W277',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = 'W', piece.catalogue_number = '277',
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 8558 AND piece.composer_id = 105
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'Acordei de madrugada', part.name_en = 'Guia prático nº 1, W277, nº 1: Acordei de madrugada',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 8558 AND p.composer_id = 105 AND part.part_key = 'musicbrainz:6eed5650-ae60-42a6-99c0-783ccbb779a6' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:6eed5650-ae60-42a6-99c0-783ccbb779a6', 1, NULL, 'Acordei de madrugada', 'Guia prático nº 1, W277, nº 1: Acordei de madrugada', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 8558 AND p.composer_id = 105
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:6eed5650-ae60-42a6-99c0-783ccbb779a6'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'A maré encheu', part.name_en = 'Guia prático nº 1, W277, nº 2: A maré encheu',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 8558 AND p.composer_id = 105 AND part.part_key = 'musicbrainz:f5ebe535-ec02-48a4-9f74-9933cc5b421e' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:f5ebe535-ec02-48a4-9f74-9933cc5b421e', 2, NULL, 'A maré encheu', 'Guia prático nº 1, W277, nº 2: A maré encheu', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 8558 AND p.composer_id = 105
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:f5ebe535-ec02-48a4-9f74-9933cc5b421e'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = NULL,
    part.name_ko = 'A roseira', part.name_en = 'Guia prático nº 1, W277, nº 3: A roseira',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 8558 AND p.composer_id = 105 AND part.part_key = 'musicbrainz:b81c069a-7c6c-44eb-9dc6-093a51718455' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:b81c069a-7c6c-44eb-9dc6-093a51718455', 3, NULL, 'A roseira', 'Guia prático nº 1, W277, nº 3: A roseira', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 8558 AND p.composer_id = 105
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:b81c069a-7c6c-44eb-9dc6-093a51718455'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = NULL,
    part.name_ko = 'Manquinha', part.name_en = 'Guia prático nº 1, W277, nº 4: Manquinha',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 8558 AND p.composer_id = 105 AND part.part_key = 'musicbrainz:72a9b00a-c57c-4a98-9747-b986e7e3762a' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:72a9b00a-c57c-4a98-9747-b986e7e3762a', 4, NULL, 'Manquinha', 'Guia prático nº 1, W277, nº 4: Manquinha', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 8558 AND p.composer_id = 105
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:72a9b00a-c57c-4a98-9747-b986e7e3762a'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 5, part.movement_number = NULL,
    part.name_ko = 'Na corda da viola', part.name_en = 'Guia prático nº 1, W277, nº 5: Na corda da viola',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 8558 AND p.composer_id = 105 AND part.part_key = 'musicbrainz:94d946d9-7857-419f-b402-af21223c6a39' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:94d946d9-7857-419f-b402-af21223c6a39', 5, NULL, 'Na corda da viola', 'Guia prático nº 1, W277, nº 5: Na corda da viola', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 8558 AND p.composer_id = 105
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:94d946d9-7857-419f-b402-af21223c6a39'
);


-- W 284 Guia prático nº 10 W 284

UPDATE pieces piece
SET piece.title = 'Guia prático nº 10 W 284', piece.title_en = 'Guia prático nº 10, W284',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = 'W', piece.catalogue_number = '284',
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 8022 AND piece.composer_id = 105
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'De flor em flor', part.name_en = 'Guia prático nº 10, W284, nº 1: De flor em flor',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 8022 AND p.composer_id = 105 AND part.part_key = 'musicbrainz:97cd58e4-98fb-44ac-9e63-a2abb6d30e46' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:97cd58e4-98fb-44ac-9e63-a2abb6d30e46', 1, NULL, 'De flor em flor', 'Guia prático nº 10, W284, nº 1: De flor em flor', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 8022 AND p.composer_id = 105
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:97cd58e4-98fb-44ac-9e63-a2abb6d30e46'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'Atché', part.name_en = 'Guia prático nº 10, W284, nº 2: Atché',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 8022 AND p.composer_id = 105 AND part.part_key = 'musicbrainz:ccd9fddc-ed17-422a-8d26-40da5ca16024' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:ccd9fddc-ed17-422a-8d26-40da5ca16024', 2, NULL, 'Atché', 'Guia prático nº 10, W284, nº 2: Atché', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 8022 AND p.composer_id = 105
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:ccd9fddc-ed17-422a-8d26-40da5ca16024'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = NULL,
    part.name_ko = 'Nesta rua', part.name_en = 'Guia prático nº 10, W284, nº 3: Nesta rua',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 8022 AND p.composer_id = 105 AND part.part_key = 'musicbrainz:34e33da0-3035-4431-8869-b3d092aeaf61' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:34e33da0-3035-4431-8869-b3d092aeaf61', 3, NULL, 'Nesta rua', 'Guia prático nº 10, W284, nº 3: Nesta rua', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 8022 AND p.composer_id = 105
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:34e33da0-3035-4431-8869-b3d092aeaf61'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = NULL,
    part.name_ko = 'Mariquita Muchacha', part.name_en = 'Guia prático nº 10, W284, nº 5: Mariquita Muchacha',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 8022 AND p.composer_id = 105 AND part.part_key = 'musicbrainz:3a6a05ea-6a3c-4f82-86bc-5e240b58ad45' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:3a6a05ea-6a3c-4f82-86bc-5e240b58ad45', 4, NULL, 'Mariquita Muchacha', 'Guia prático nº 10, W284, nº 5: Mariquita Muchacha', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 8022 AND p.composer_id = 105
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:3a6a05ea-6a3c-4f82-86bc-5e240b58ad45'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 5, part.movement_number = NULL,
    part.name_ko = 'No jardim celestial', part.name_en = 'Guia prático nº 10, W284, nº 6: No jardim celestial',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 8022 AND p.composer_id = 105 AND part.part_key = 'musicbrainz:4ba61f98-92ba-4ec7-8e7c-b2890fe9b9cb' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:4ba61f98-92ba-4ec7-8e7c-b2890fe9b9cb', 5, NULL, 'No jardim celestial', 'Guia prático nº 10, W284, nº 6: No jardim celestial', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 8022 AND p.composer_id = 105
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:4ba61f98-92ba-4ec7-8e7c-b2890fe9b9cb'
);


-- W 278 Guia prático nº 2 W 278

UPDATE pieces piece
SET piece.title = 'Guia prático nº 2 W 278', piece.title_en = 'Guia prático nº 2, W278',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = 'W', piece.catalogue_number = '278',
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 9545 AND piece.composer_id = 105
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'Brinquedo', part.name_en = 'Guia prático nº 2, W278, nº 1: Brinquedo',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 9545 AND p.composer_id = 105 AND part.part_key = 'musicbrainz:12fcc006-3930-4042-84f0-e51de61b682a' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:12fcc006-3930-4042-84f0-e51de61b682a', 1, NULL, 'Brinquedo', 'Guia prático nº 2, W278, nº 1: Brinquedo', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 9545 AND p.composer_id = 105
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:12fcc006-3930-4042-84f0-e51de61b682a'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'Machadinha', part.name_en = 'Guia prático nº 2, W278, nº 2: Machadinha',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 9545 AND p.composer_id = 105 AND part.part_key = 'musicbrainz:1faa85ca-6731-44c7-bb78-0d0723984795' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:1faa85ca-6731-44c7-bb78-0d0723984795', 2, NULL, 'Machadinha', 'Guia prático nº 2, W278, nº 2: Machadinha', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 9545 AND p.composer_id = 105
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:1faa85ca-6731-44c7-bb78-0d0723984795'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = NULL,
    part.name_ko = 'Espanha', part.name_en = 'Guia prático nº 2, W278, nº 3: Espanha',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 9545 AND p.composer_id = 105 AND part.part_key = 'musicbrainz:f88ef2a0-8738-4bfd-9154-dd08c5965089' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:f88ef2a0-8738-4bfd-9154-dd08c5965089', 3, NULL, 'Espanha', 'Guia prático nº 2, W278, nº 3: Espanha', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 9545 AND p.composer_id = 105
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:f88ef2a0-8738-4bfd-9154-dd08c5965089'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = NULL,
    part.name_ko = 'Senhora Dona Viúva', part.name_en = 'Guia prático nº 2, W278, nº 5: Senhora Dona Viúva',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 9545 AND p.composer_id = 105 AND part.part_key = 'musicbrainz:e3484e9a-32da-4377-99cf-d6d0ae31f04b' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:e3484e9a-32da-4377-99cf-d6d0ae31f04b', 4, NULL, 'Senhora Dona Viúva', 'Guia prático nº 2, W278, nº 5: Senhora Dona Viúva', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 9545 AND p.composer_id = 105
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:e3484e9a-32da-4377-99cf-d6d0ae31f04b'
);


-- W 279 Guia prático nº 3 W 279

UPDATE pieces piece
SET piece.title = 'Guia prático nº 3 W 279', piece.title_en = 'Guia prático nº 3, W279',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = 'W', piece.catalogue_number = '279',
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 8993 AND piece.composer_id = 105
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'O pastorzinho', part.name_en = 'Guia prático nº 3, W279, nº 1: O pastorzinho',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 8993 AND p.composer_id = 105 AND part.part_key = 'musicbrainz:ab1f2b92-a567-4e5f-9763-ec5cf2d90e04' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:ab1f2b92-a567-4e5f-9763-ec5cf2d90e04', 1, NULL, 'O pastorzinho', 'Guia prático nº 3, W279, nº 1: O pastorzinho', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 8993 AND p.composer_id = 105
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:ab1f2b92-a567-4e5f-9763-ec5cf2d90e04'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'João Cambuête', part.name_en = 'Guia prático nº 3, W279, nº 2: João Cambuête',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 8993 AND p.composer_id = 105 AND part.part_key = 'musicbrainz:9027e84f-1e4a-41ab-bd08-e07e9b83bd92' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:9027e84f-1e4a-41ab-bd08-e07e9b83bd92', 2, NULL, 'João Cambuête', 'Guia prático nº 3, W279, nº 2: João Cambuête', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 8993 AND p.composer_id = 105
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:9027e84f-1e4a-41ab-bd08-e07e9b83bd92'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = NULL,
    part.name_ko = 'A freira', part.name_en = 'Guia prático nº 3, W279, nº 3: A freira',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 8993 AND p.composer_id = 105 AND part.part_key = 'musicbrainz:35fd4f24-23d9-45cd-9a01-3a7f6caa2b7b' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:35fd4f24-23d9-45cd-9a01-3a7f6caa2b7b', 3, NULL, 'A freira', 'Guia prático nº 3, W279, nº 3: A freira', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 8993 AND p.composer_id = 105
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:35fd4f24-23d9-45cd-9a01-3a7f6caa2b7b'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = NULL,
    part.name_ko = 'Garibaldi foi à missa', part.name_en = 'Guia prático nº 3, W279, nº 4: Garibaldi foi à missa',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 8993 AND p.composer_id = 105 AND part.part_key = 'musicbrainz:b466c481-65bb-404c-a018-2ad9cd63b891' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:b466c481-65bb-404c-a018-2ad9cd63b891', 4, NULL, 'Garibaldi foi à missa', 'Guia prático nº 3, W279, nº 4: Garibaldi foi à missa', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 8993 AND p.composer_id = 105
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:b466c481-65bb-404c-a018-2ad9cd63b891'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 5, part.movement_number = NULL,
    part.name_ko = 'O pião', part.name_en = 'Guia prático nº 3, W279, nº 5: O pião',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 8993 AND p.composer_id = 105 AND part.part_key = 'musicbrainz:1cf695f4-5b17-4ab5-9c85-275cfdf6018b' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:1cf695f4-5b17-4ab5-9c85-275cfdf6018b', 5, NULL, 'O pião', 'Guia prático nº 3, W279, nº 5: O pião', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 8993 AND p.composer_id = 105
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:1cf695f4-5b17-4ab5-9c85-275cfdf6018b'
);


-- W 280 Guia prático nº 4 W 280

UPDATE pieces piece
SET piece.title = 'Guia prático nº 4 W 280', piece.title_en = 'Guia prático nº 4, W280',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = 'W', piece.catalogue_number = '280',
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 8061 AND piece.composer_id = 105
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'O pobre e o rico', part.name_en = 'Guia prático nº 4, W280, nº 1: O pobre e o rico',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 8061 AND p.composer_id = 105 AND part.part_key = 'musicbrainz:49c4663a-616b-4975-956b-5b1e4b871c4b' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:49c4663a-616b-4975-956b-5b1e4b871c4b', 1, NULL, 'O pobre e o rico', 'Guia prático nº 4, W280, nº 1: O pobre e o rico', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 8061 AND p.composer_id = 105
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:49c4663a-616b-4975-956b-5b1e4b871c4b'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'Rosa amarela', part.name_en = 'Guia prático nº 4, W280, nº 2: Rosa amarela',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 8061 AND p.composer_id = 105 AND part.part_key = 'musicbrainz:c5c63b12-4147-49be-933d-a7b6ba8b01f7' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:c5c63b12-4147-49be-933d-a7b6ba8b01f7', 2, NULL, 'Rosa amarela', 'Guia prático nº 4, W280, nº 2: Rosa amarela', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 8061 AND p.composer_id = 105
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:c5c63b12-4147-49be-933d-a7b6ba8b01f7'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = NULL,
    part.name_ko = 'Olha o passarinho, domine', part.name_en = 'Guia prático nº 4, W280, nº 3: Olha o passarinho, domine',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 8061 AND p.composer_id = 105 AND part.part_key = 'musicbrainz:1f6c2985-9ec6-453d-a062-6f444a266cd1' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:1f6c2985-9ec6-453d-a062-6f444a266cd1', 3, NULL, 'Olha o passarinho, domine', 'Guia prático nº 4, W280, nº 3: Olha o passarinho, domine', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 8061 AND p.composer_id = 105
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:1f6c2985-9ec6-453d-a062-6f444a266cd1'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = NULL,
    part.name_ko = 'O gato', part.name_en = 'Guia prático nº 4, W280, nº 4: O gato',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 8061 AND p.composer_id = 105 AND part.part_key = 'musicbrainz:9d23dff2-a414-4cf6-8baa-86454f5fd7b5' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:9d23dff2-a414-4cf6-8baa-86454f5fd7b5', 4, NULL, 'O gato', 'Guia prático nº 4, W280, nº 4: O gato', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 8061 AND p.composer_id = 105
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:9d23dff2-a414-4cf6-8baa-86454f5fd7b5'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 5, part.movement_number = NULL,
    part.name_ko = 'Ó sim', part.name_en = 'Guia prático nº 4, W280, nº 5: Ó sim',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 8061 AND p.composer_id = 105 AND part.part_key = 'musicbrainz:d864c987-398a-4260-bf9e-a4ea368c75bd' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:d864c987-398a-4260-bf9e-a4ea368c75bd', 5, NULL, 'Ó sim', 'Guia prático nº 4, W280, nº 5: Ó sim', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 8061 AND p.composer_id = 105
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:d864c987-398a-4260-bf9e-a4ea368c75bd'
);


-- W 281 Guia prático nº 5 W 281

UPDATE pieces piece
SET piece.title = 'Guia prático nº 5 W 281', piece.title_en = 'Guia prático nº 5, W281',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = 'W', piece.catalogue_number = '281',
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 10811 AND piece.composer_id = 105
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'Os pombinhos', part.name_en = 'Guia prático nº 5, W281, nº 1: Os pombinhos',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 10811 AND p.composer_id = 105 AND part.part_key = 'musicbrainz:c9d0cd49-dee6-4786-82a8-37d4ac81c4ac' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:c9d0cd49-dee6-4786-82a8-37d4ac81c4ac', 1, NULL, 'Os pombinhos', 'Guia prático nº 5, W281, nº 1: Os pombinhos', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 10811 AND p.composer_id = 105
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:c9d0cd49-dee6-4786-82a8-37d4ac81c4ac'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'Você diz que sabe tudo', part.name_en = 'Guia prático nº 5, W281, nº 2: Você diz que sabe tudo',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 10811 AND p.composer_id = 105 AND part.part_key = 'musicbrainz:e456ff65-7da1-4af8-9488-f947d65fc6d5' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:e456ff65-7da1-4af8-9488-f947d65fc6d5', 2, NULL, 'Você diz que sabe tudo', 'Guia prático nº 5, W281, nº 2: Você diz que sabe tudo', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 10811 AND p.composer_id = 105
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:e456ff65-7da1-4af8-9488-f947d65fc6d5'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = NULL,
    part.name_ko = 'Có-có-có', part.name_en = 'Guia prático nº 5, W281, nº 3: Có-có-có',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 10811 AND p.composer_id = 105 AND part.part_key = 'musicbrainz:10f87b17-c75d-4603-985d-b85a660f7fca' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:10f87b17-c75d-4603-985d-b85a660f7fca', 3, NULL, 'Có-có-có', 'Guia prático nº 5, W281, nº 3: Có-có-có', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 10811 AND p.composer_id = 105
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:10f87b17-c75d-4603-985d-b85a660f7fca'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = NULL,
    part.name_ko = 'O bastão ou mia gato', part.name_en = 'Guia prático nº 5, W281, nº 4: O bastão ou mia gato',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 10811 AND p.composer_id = 105 AND part.part_key = 'musicbrainz:416bda7f-27c2-4af0-b23c-801014c3152e' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:416bda7f-27c2-4af0-b23c-801014c3152e', 4, NULL, 'O bastão ou mia gato', 'Guia prático nº 5, W281, nº 4: O bastão ou mia gato', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 10811 AND p.composer_id = 105
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:416bda7f-27c2-4af0-b23c-801014c3152e'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 5, part.movement_number = NULL,
    part.name_ko = 'A condessa', part.name_en = 'Guia prático nº 5, W281, nº 5: A condessa',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 10811 AND p.composer_id = 105 AND part.part_key = 'musicbrainz:38222987-34a1-4c36-9210-34442bf97de6' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:38222987-34a1-4c36-9210-34442bf97de6', 5, NULL, 'A condessa', 'Guia prático nº 5, W281, nº 5: A condessa', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 10811 AND p.composer_id = 105
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:38222987-34a1-4c36-9210-34442bf97de6'
);


-- W 282 Guia prático nº 6 W 282

UPDATE pieces piece
SET piece.title = 'Guia prático nº 6 W 282', piece.title_en = 'Guia prático nº 6, W282',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = 'W', piece.catalogue_number = '282',
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 10925 AND piece.composer_id = 105
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'Sonho de uma criança', part.name_en = 'Guia prático nº 6, W282, nº 1: Sonho de uma criança',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 10925 AND p.composer_id = 105 AND part.part_key = 'musicbrainz:d4617095-a04c-434d-9f4c-374bc680f28e' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:d4617095-a04c-434d-9f4c-374bc680f28e', 1, NULL, 'Sonho de uma criança', 'Guia prático nº 6, W282, nº 1: Sonho de uma criança', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 10925 AND p.composer_id = 105
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:d4617095-a04c-434d-9f4c-374bc680f28e'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'O corcunda', part.name_en = 'Guia prático nº 6, W282, nº 2: O corcunda',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 10925 AND p.composer_id = 105 AND part.part_key = 'musicbrainz:d30ee442-674a-4180-9031-cd81f6b81380' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:d30ee442-674a-4180-9031-cd81f6b81380', 2, NULL, 'O corcunda', 'Guia prático nº 6, W282, nº 2: O corcunda', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 10925 AND p.composer_id = 105
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:d30ee442-674a-4180-9031-cd81f6b81380'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = NULL,
    part.name_ko = 'Caranguejo', part.name_en = 'Guia prático nº 6, W282, nº 3: Caranguejo',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 10925 AND p.composer_id = 105 AND part.part_key = 'musicbrainz:9391cf46-5b29-4224-b4df-1efdc20fe77a' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:9391cf46-5b29-4224-b4df-1efdc20fe77a', 3, NULL, 'Caranguejo', 'Guia prático nº 6, W282, nº 3: Caranguejo', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 10925 AND p.composer_id = 105
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:9391cf46-5b29-4224-b4df-1efdc20fe77a'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = NULL,
    part.name_ko = 'A pombinha voou', part.name_en = 'Guia prático nº 6, W282, nº 4: A pombinha voou',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 10925 AND p.composer_id = 105 AND part.part_key = 'musicbrainz:31d82671-d051-4d14-b348-67f274af87ad' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:31d82671-d051-4d14-b348-67f274af87ad', 4, NULL, 'A pombinha voou', 'Guia prático nº 6, W282, nº 4: A pombinha voou', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 10925 AND p.composer_id = 105
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:31d82671-d051-4d14-b348-67f274af87ad'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 5, part.movement_number = NULL,
    part.name_ko = 'Vamos atrás da serra, oh! Calunga!', part.name_en = 'Guia prático nº 6, W282, nº 5: Vamos atrás da serra, oh! Calunga!',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 10925 AND p.composer_id = 105 AND part.part_key = 'musicbrainz:4de34147-ed8f-4f99-9da1-cc74a759f515' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:4de34147-ed8f-4f99-9da1-cc74a759f515', 5, NULL, 'Vamos atrás da serra, oh! Calunga!', 'Guia prático nº 6, W282, nº 5: Vamos atrás da serra, oh! Calunga!', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 10925 AND p.composer_id = 105
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:4de34147-ed8f-4f99-9da1-cc74a759f515'
);


-- W 283 Guia prático nº 7 W 283

UPDATE pieces piece
SET piece.title = 'Guia prático nº 7 W 283', piece.title_en = 'Guia prático nº 7, W283',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = 'W', piece.catalogue_number = '283',
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 10014 AND piece.composer_id = 105
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'No fundo do meu quintal', part.name_en = 'Guia prático nº 7, W283, nº 1: No fundo do meu quintal',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 10014 AND p.composer_id = 105 AND part.part_key = 'musicbrainz:b8f21af3-7ed8-411e-a9eb-393b0421ce17' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:b8f21af3-7ed8-411e-a9eb-393b0421ce17', 1, NULL, 'No fundo do meu quintal', 'Guia prático nº 7, W283, nº 1: No fundo do meu quintal', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 10014 AND p.composer_id = 105
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:b8f21af3-7ed8-411e-a9eb-393b0421ce17'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'Vai, abóbora', part.name_en = 'Guia prático nº 7, W283, nº 2: Vai, abóbora',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 10014 AND p.composer_id = 105 AND part.part_key = 'musicbrainz:137218e3-eb37-4891-881c-521bd53d942e' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:137218e3-eb37-4891-881c-521bd53d942e', 2, NULL, 'Vai, abóbora', 'Guia prático nº 7, W283, nº 2: Vai, abóbora', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 10014 AND p.composer_id = 105
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:137218e3-eb37-4891-881c-521bd53d942e'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = NULL,
    part.name_ko = 'Vamos Maruca', part.name_en = 'Guia prático nº 7, W283, nº 3: Vamos Maruca',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 10014 AND p.composer_id = 105 AND part.part_key = 'musicbrainz:870a513d-0dc4-4bad-acc0-2122d38541e1' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:870a513d-0dc4-4bad-acc0-2122d38541e1', 3, NULL, 'Vamos Maruca', 'Guia prático nº 7, W283, nº 3: Vamos Maruca', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 10014 AND p.composer_id = 105
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:870a513d-0dc4-4bad-acc0-2122d38541e1'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = NULL,
    part.name_ko = 'Os pombinhos', part.name_en = 'Guia prático nº 7, W283, nº 4: Os pombinhos',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 10014 AND p.composer_id = 105 AND part.part_key = 'musicbrainz:6a209cee-c8d5-4568-868c-a152564ed7c7' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:6a209cee-c8d5-4568-868c-a152564ed7c7', 4, NULL, 'Os pombinhos', 'Guia prático nº 7, W283, nº 4: Os pombinhos', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 10014 AND p.composer_id = 105
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:6a209cee-c8d5-4568-868c-a152564ed7c7'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 5, part.movement_number = NULL,
    part.name_ko = 'Anda à roda', part.name_en = 'Guia prático nº 7, W283, nº 5: Anda à roda',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 10014 AND p.composer_id = 105 AND part.part_key = 'musicbrainz:97431d10-c1e9-4de1-9e97-2e68b40ed10f' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:97431d10-c1e9-4de1-9e97-2e68b40ed10f', 5, NULL, 'Anda à roda', 'Guia prático nº 7, W283, nº 5: Anda à roda', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 10014 AND p.composer_id = 105
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:97431d10-c1e9-4de1-9e97-2e68b40ed10f'
);


-- W 358 Guia prático nº 8 W 358

UPDATE pieces piece
SET piece.title = 'Guia prático nº 8 W 358', piece.title_en = 'Guia prático nº 8, W358',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = 'W', piece.catalogue_number = '358',
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 8911 AND piece.composer_id = 105
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'O limão', part.name_en = 'Guia prático nº 8, W358, nº 1: O limão',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 8911 AND p.composer_id = 105 AND part.part_key = 'musicbrainz:36dcb51a-3d56-43f5-827a-9a59964dd4de' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:36dcb51a-3d56-43f5-827a-9a59964dd4de', 1, NULL, 'O limão', 'Guia prático nº 8, W358, nº 1: O limão', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 8911 AND p.composer_id = 105
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:36dcb51a-3d56-43f5-827a-9a59964dd4de'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'Carambola', part.name_en = 'Guia prático nº 8, W358, nº 2: Carambola',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 8911 AND p.composer_id = 105 AND part.part_key = 'musicbrainz:5a7a0d6e-8879-4a27-b947-26601ec065c9' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:5a7a0d6e-8879-4a27-b947-26601ec065c9', 2, NULL, 'Carambola', 'Guia prático nº 8, W358, nº 2: Carambola', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 8911 AND p.composer_id = 105
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:5a7a0d6e-8879-4a27-b947-26601ec065c9'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = NULL,
    part.name_ko = 'Pobre cega', part.name_en = 'Guia prático nº 8, W358, nº 3: Pobre cega',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 8911 AND p.composer_id = 105 AND part.part_key = 'musicbrainz:52441164-5f15-47bd-98e7-d8aad406b2d1' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:52441164-5f15-47bd-98e7-d8aad406b2d1', 3, NULL, 'Pobre cega', 'Guia prático nº 8, W358, nº 3: Pobre cega', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 8911 AND p.composer_id = 105
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:52441164-5f15-47bd-98e7-d8aad406b2d1'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = NULL,
    part.name_ko = 'Pai Francisco', part.name_en = 'Guia prático nº 8, W358, nº 4: Pai Francisco',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 8911 AND p.composer_id = 105 AND part.part_key = 'musicbrainz:4ff40d2d-168a-45a5-8569-b6644c1414f1' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:4ff40d2d-168a-45a5-8569-b6644c1414f1', 4, NULL, 'Pai Francisco', 'Guia prático nº 8, W358, nº 4: Pai Francisco', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 8911 AND p.composer_id = 105
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:4ff40d2d-168a-45a5-8569-b6644c1414f1'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 5, part.movement_number = NULL,
    part.name_ko = 'Xô! Passarinho!', part.name_en = 'Guia prático nº 8, W358, nº 5: Xô! Passarinho!',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 8911 AND p.composer_id = 105 AND part.part_key = 'musicbrainz:eec2d505-b29f-4122-969b-93267eb58a15' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:eec2d505-b29f-4122-969b-93267eb58a15', 5, NULL, 'Xô! Passarinho!', 'Guia prático nº 8, W358, nº 5: Xô! Passarinho!', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 8911 AND p.composer_id = 105
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:eec2d505-b29f-4122-969b-93267eb58a15'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 6, part.movement_number = NULL,
    part.name_ko = 'Sinh''Aninha', part.name_en = 'Guia prático nº 8, W358, nº 6: Sinh''Aninha',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 8911 AND p.composer_id = 105 AND part.part_key = 'musicbrainz:9bb77bbe-2c76-451c-aced-db69dae09cca' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:9bb77bbe-2c76-451c-aced-db69dae09cca', 6, NULL, 'Sinh''Aninha', 'Guia prático nº 8, W358, nº 6: Sinh''Aninha', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 8911 AND p.composer_id = 105
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:9bb77bbe-2c76-451c-aced-db69dae09cca'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 7, part.movement_number = NULL,
    part.name_ko = 'Vestidinho branco', part.name_en = 'Guia prático nº 8, W358, nº 7: Vestidinho branco',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 8911 AND p.composer_id = 105 AND part.part_key = 'musicbrainz:a58dd673-0966-482b-b1cb-911386d8e05d' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:a58dd673-0966-482b-b1cb-911386d8e05d', 7, NULL, 'Vestidinho branco', 'Guia prático nº 8, W358, nº 7: Vestidinho branco', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 8911 AND p.composer_id = 105
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:a58dd673-0966-482b-b1cb-911386d8e05d'
);


-- W 359 Guia prático nº 9 W 359

UPDATE pieces piece
SET piece.title = 'Guia prático nº 9 W 359', piece.title_en = 'Guia prático nº 9, W359',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = 'W', piece.catalogue_number = '359',
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 8595 AND piece.composer_id = 105
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'Laranjeira pequenina', part.name_en = 'Guia prático nº 9, W359, nº 1: Laranjeira pequenina',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 8595 AND p.composer_id = 105 AND part.part_key = 'musicbrainz:e909d078-6e28-4b95-8a7b-fe085dbc2f37' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:e909d078-6e28-4b95-8a7b-fe085dbc2f37', 1, NULL, 'Laranjeira pequenina', 'Guia prático nº 9, W359, nº 1: Laranjeira pequenina', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 8595 AND p.composer_id = 105
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:e909d078-6e28-4b95-8a7b-fe085dbc2f37'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'Pombinha rolinha', part.name_en = 'Guia prático nº 9, W359, nº 2: Pombinha rolinha',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 8595 AND p.composer_id = 105 AND part.part_key = 'musicbrainz:6b2ab889-5629-457e-951e-8db49b448a61' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:6b2ab889-5629-457e-951e-8db49b448a61', 2, NULL, 'Pombinha rolinha', 'Guia prático nº 9, W359, nº 2: Pombinha rolinha', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 8595 AND p.composer_id = 105
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:6b2ab889-5629-457e-951e-8db49b448a61'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = NULL,
    part.name_ko = 'Ó ciranda, ó cirandinha', part.name_en = 'Guia prático nº 9, W359, nº 3: Ó ciranda, ó cirandinha',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 8595 AND p.composer_id = 105 AND part.part_key = 'musicbrainz:3790f766-be3e-41c3-b910-855f864dd5ce' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:3790f766-be3e-41c3-b910-855f864dd5ce', 3, NULL, 'Ó ciranda, ó cirandinha', 'Guia prático nº 9, W359, nº 3: Ó ciranda, ó cirandinha', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 8595 AND p.composer_id = 105
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:3790f766-be3e-41c3-b910-855f864dd5ce'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = NULL,
    part.name_ko = 'A velha que tinha nove filhas', part.name_en = 'Guia prático nº 9, W359, nº 4: A velha que tinha nove filhas',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 8595 AND p.composer_id = 105 AND part.part_key = 'musicbrainz:d8638c7a-96b2-4c20-80f9-14ae075758f7' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:d8638c7a-96b2-4c20-80f9-14ae075758f7', 4, NULL, 'A velha que tinha nove filhas', 'Guia prático nº 9, W359, nº 4: A velha que tinha nove filhas', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 8595 AND p.composer_id = 105
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:d8638c7a-96b2-4c20-80f9-14ae075758f7'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 5, part.movement_number = NULL,
    part.name_ko = 'Constante', part.name_en = 'Guia prático nº 9, W359, nº 5: Constante',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 8595 AND p.composer_id = 105 AND part.part_key = 'musicbrainz:a9a00883-950a-426c-a441-e98fb8dd3dc7' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:a9a00883-950a-426c-a441-e98fb8dd3dc7', 5, NULL, 'Constante', 'Guia prático nº 9, W359, nº 5: Constante', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 8595 AND p.composer_id = 105
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:a9a00883-950a-426c-a441-e98fb8dd3dc7'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 6, part.movement_number = NULL,
    part.name_ko = 'O castelo', part.name_en = 'Guia prático nº 9, W359, nº 6: O castelo',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 8595 AND p.composer_id = 105 AND part.part_key = 'musicbrainz:cfeddbce-8753-4c57-98fa-9d587517c14a' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:cfeddbce-8753-4c57-98fa-9d587517c14a', 6, NULL, 'O castelo', 'Guia prático nº 9, W359, nº 6: O castelo', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 8595 AND p.composer_id = 105
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:cfeddbce-8753-4c57-98fa-9d587517c14a'
);


-- None Guia prático, W276, nº 121: Sôdade

UPDATE pieces piece
SET piece.title = 'Guia prático, W276, nº 121: Sôdade', piece.title_en = 'Guia prático, W276, nº 121: Sôdade',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 8989 AND piece.composer_id = 105
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'Guia prático, W276', part.name_en = 'Guia prático, W276',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 8989 AND p.composer_id = 105 AND part.part_key = 'musicbrainz:30e8cc0b-657c-4fa3-91d2-61073730942b' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:30e8cc0b-657c-4fa3-91d2-61073730942b', 1, NULL, 'Guia prático, W276', 'Guia prático, W276', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 8989 AND p.composer_id = 105
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:30e8cc0b-657c-4fa3-91d2-61073730942b'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:30e8cc0b-657c-4fa3-91d2-61073730942b'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'Pai Francisco', part.name_en = 'Guia prático, W276, nº 87: Pai Francisco',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 8989 AND p.composer_id = 105 AND part.part_key = 'musicbrainz:1a04f0b4-1fb4-4b2d-a7fe-b4d49298561b' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:1a04f0b4-1fb4-4b2d-a7fe-b4d49298561b', 1, NULL, 'Pai Francisco', 'Guia prático, W276, nº 87: Pai Francisco', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:30e8cc0b-657c-4fa3-91d2-61073730942b'
WHERE p.id = 8989 AND p.composer_id = 105
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:1a04f0b4-1fb4-4b2d-a7fe-b4d49298561b'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:30e8cc0b-657c-4fa3-91d2-61073730942b'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'Senhora Dona Sancha', part.name_en = 'Guia prático, W276, nº 114: Senhora Dona Sancha',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 8989 AND p.composer_id = 105 AND part.part_key = 'musicbrainz:1d68cd82-c2c0-4525-8c50-a237856d3daa' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:1d68cd82-c2c0-4525-8c50-a237856d3daa', 2, NULL, 'Senhora Dona Sancha', 'Guia prático, W276, nº 114: Senhora Dona Sancha', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:30e8cc0b-657c-4fa3-91d2-61073730942b'
WHERE p.id = 8989 AND p.composer_id = 105
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:1d68cd82-c2c0-4525-8c50-a237856d3daa'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:30e8cc0b-657c-4fa3-91d2-61073730942b'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = NULL,
    part.name_ko = 'A mamãe estava doente', part.name_en = 'Guia prático, W276, nº 72: A mamãe estava doente',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 8989 AND p.composer_id = 105 AND part.part_key = 'musicbrainz:2a16a42d-f7d2-4622-b8c3-d63c74f9fb98' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:2a16a42d-f7d2-4622-b8c3-d63c74f9fb98', 3, NULL, 'A mamãe estava doente', 'Guia prático, W276, nº 72: A mamãe estava doente', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:30e8cc0b-657c-4fa3-91d2-61073730942b'
WHERE p.id = 8989 AND p.composer_id = 105
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:2a16a42d-f7d2-4622-b8c3-d63c74f9fb98'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:30e8cc0b-657c-4fa3-91d2-61073730942b'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = NULL,
    part.name_ko = 'Vem cá, siriri', part.name_en = 'Guia prático, W276, nº 130: Vem cá, siriri',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 8989 AND p.composer_id = 105 AND part.part_key = 'musicbrainz:3071b4b4-378f-401d-bcb3-5aef517fdf4c' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:3071b4b4-378f-401d-bcb3-5aef517fdf4c', 4, NULL, 'Vem cá, siriri', 'Guia prático, W276, nº 130: Vem cá, siriri', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:30e8cc0b-657c-4fa3-91d2-61073730942b'
WHERE p.id = 8989 AND p.composer_id = 105
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:3071b4b4-378f-401d-bcb3-5aef517fdf4c'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:30e8cc0b-657c-4fa3-91d2-61073730942b'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 5, part.movement_number = NULL,
    part.name_ko = 'Que lindos olhos!', part.name_en = 'Guia prático, W276, nº 107: Que lindos olhos!',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 8989 AND p.composer_id = 105 AND part.part_key = 'musicbrainz:32aec795-8fa7-4488-9256-faedfebf3363' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:32aec795-8fa7-4488-9256-faedfebf3363', 5, NULL, 'Que lindos olhos!', 'Guia prático, W276, nº 107: Que lindos olhos!', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:30e8cc0b-657c-4fa3-91d2-61073730942b'
WHERE p.id = 8989 AND p.composer_id = 105
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:32aec795-8fa7-4488-9256-faedfebf3363'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:30e8cc0b-657c-4fa3-91d2-61073730942b'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 6, part.movement_number = NULL,
    part.name_ko = 'Quando eu era pequenino', part.name_en = 'Guia prático, W276, nº 105: Quando eu era pequenino',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 8989 AND p.composer_id = 105 AND part.part_key = 'musicbrainz:3606df38-c40d-4d78-9f7c-743197e6a18c' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:3606df38-c40d-4d78-9f7c-743197e6a18c', 6, NULL, 'Quando eu era pequenino', 'Guia prático, W276, nº 105: Quando eu era pequenino', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:30e8cc0b-657c-4fa3-91d2-61073730942b'
WHERE p.id = 8989 AND p.composer_id = 105
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:3606df38-c40d-4d78-9f7c-743197e6a18c'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:30e8cc0b-657c-4fa3-91d2-61073730942b'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 7, part.movement_number = NULL,
    part.name_ko = 'O cravo', part.name_en = 'Guia prático, W276, nº 45: O cravo',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 8989 AND p.composer_id = 105 AND part.part_key = 'musicbrainz:36da0e2c-832e-473f-bba5-2980f9353529' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:36da0e2c-832e-473f-bba5-2980f9353529', 7, NULL, 'O cravo', 'Guia prático, W276, nº 45: O cravo', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:30e8cc0b-657c-4fa3-91d2-61073730942b'
WHERE p.id = 8989 AND p.composer_id = 105
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:36da0e2c-832e-473f-bba5-2980f9353529'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:30e8cc0b-657c-4fa3-91d2-61073730942b'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 8, part.movement_number = NULL,
    part.name_ko = 'Meu benzinho', part.name_en = 'Guia prático, W276, nº 80: Meu benzinho',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 8989 AND p.composer_id = 105 AND part.part_key = 'musicbrainz:3d13094b-7966-404a-8d77-fea07bb94868' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:3d13094b-7966-404a-8d77-fea07bb94868', 8, NULL, 'Meu benzinho', 'Guia prático, W276, nº 80: Meu benzinho', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:30e8cc0b-657c-4fa3-91d2-61073730942b'
WHERE p.id = 8989 AND p.composer_id = 105
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:3d13094b-7966-404a-8d77-fea07bb94868'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:30e8cc0b-657c-4fa3-91d2-61073730942b'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 9, part.movement_number = NULL,
    part.name_ko = 'Rosa amarela', part.name_en = 'Guia prático, W276, nº 108: Rosa amarela',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 8989 AND p.composer_id = 105 AND part.part_key = 'musicbrainz:3d4971ed-d30a-4a0e-8590-3c9ff81661e9' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:3d4971ed-d30a-4a0e-8590-3c9ff81661e9', 9, NULL, 'Rosa amarela', 'Guia prático, W276, nº 108: Rosa amarela', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:30e8cc0b-657c-4fa3-91d2-61073730942b'
WHERE p.id = 8989 AND p.composer_id = 105
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:3d4971ed-d30a-4a0e-8590-3c9ff81661e9'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:30e8cc0b-657c-4fa3-91d2-61073730942b'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 10, part.movement_number = NULL,
    part.name_ko = 'Ba, be, bi, bo, bu', part.name_en = 'Guia prático, W276, nº 11: Ba, be, bi, bo, bu',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 8989 AND p.composer_id = 105 AND part.part_key = 'musicbrainz:3ff2005c-6b26-4bac-bcc7-576bd10fbfc9' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:3ff2005c-6b26-4bac-bcc7-576bd10fbfc9', 10, NULL, 'Ba, be, bi, bo, bu', 'Guia prático, W276, nº 11: Ba, be, bi, bo, bu', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:30e8cc0b-657c-4fa3-91d2-61073730942b'
WHERE p.id = 8989 AND p.composer_id = 105
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:3ff2005c-6b26-4bac-bcc7-576bd10fbfc9'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:30e8cc0b-657c-4fa3-91d2-61073730942b'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 11, part.movement_number = NULL,
    part.name_ko = 'Bela pastora', part.name_en = 'Guia prático, W276, nº 15: Bela pastora',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 8989 AND p.composer_id = 105 AND part.part_key = 'musicbrainz:41550312-34e4-45aa-9197-0ffde2e3b7ec' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:41550312-34e4-45aa-9197-0ffde2e3b7ec', 11, NULL, 'Bela pastora', 'Guia prático, W276, nº 15: Bela pastora', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:30e8cc0b-657c-4fa3-91d2-61073730942b'
WHERE p.id = 8989 AND p.composer_id = 105
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:41550312-34e4-45aa-9197-0ffde2e3b7ec'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:30e8cc0b-657c-4fa3-91d2-61073730942b'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 12, part.movement_number = NULL,
    part.name_ko = 'Pirolito', part.name_en = 'Guia prático, W276, nº 95: Pirolito',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 8989 AND p.composer_id = 105 AND part.part_key = 'musicbrainz:48e75155-39bf-44dc-ab2d-aba6f8d2b3b9' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:48e75155-39bf-44dc-ab2d-aba6f8d2b3b9', 12, NULL, 'Pirolito', 'Guia prático, W276, nº 95: Pirolito', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:30e8cc0b-657c-4fa3-91d2-61073730942b'
WHERE p.id = 8989 AND p.composer_id = 105
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:48e75155-39bf-44dc-ab2d-aba6f8d2b3b9'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:30e8cc0b-657c-4fa3-91d2-61073730942b'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 13, part.movement_number = NULL,
    part.name_ko = 'Chora, menina, chora', part.name_en = 'Guia prático, W276, nº 34: Chora, menina, chora',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 8989 AND p.composer_id = 105 AND part.part_key = 'musicbrainz:536f29eb-4063-42d4-91c9-8b3030069c98' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:536f29eb-4063-42d4-91c9-8b3030069c98', 13, NULL, 'Chora, menina, chora', 'Guia prático, W276, nº 34: Chora, menina, chora', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:30e8cc0b-657c-4fa3-91d2-61073730942b'
WHERE p.id = 8989 AND p.composer_id = 105
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:536f29eb-4063-42d4-91c9-8b3030069c98'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:30e8cc0b-657c-4fa3-91d2-61073730942b'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 14, part.movement_number = NULL,
    part.name_ko = 'Cachorrinho', part.name_en = 'Guia prático, W276, nº 18: Cachorrinho',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 8989 AND p.composer_id = 105 AND part.part_key = 'musicbrainz:7d47dafd-04ae-4ed3-b708-241a5db2bff6' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:7d47dafd-04ae-4ed3-b708-241a5db2bff6', 14, NULL, 'Cachorrinho', 'Guia prático, W276, nº 18: Cachorrinho', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:30e8cc0b-657c-4fa3-91d2-61073730942b'
WHERE p.id = 8989 AND p.composer_id = 105
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:7d47dafd-04ae-4ed3-b708-241a5db2bff6'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:30e8cc0b-657c-4fa3-91d2-61073730942b'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 15, part.movement_number = NULL,
    part.name_ko = 'Meninas, ó meninas', part.name_en = 'Guia prático, W276, nº 79: Meninas, ó meninas',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 8989 AND p.composer_id = 105 AND part.part_key = 'musicbrainz:875c5bca-d5bd-45b9-8b57-6661b33486ca' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:875c5bca-d5bd-45b9-8b57-6661b33486ca', 15, NULL, 'Meninas, ó meninas', 'Guia prático, W276, nº 79: Meninas, ó meninas', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:30e8cc0b-657c-4fa3-91d2-61073730942b'
WHERE p.id = 8989 AND p.composer_id = 105
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:875c5bca-d5bd-45b9-8b57-6661b33486ca'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:30e8cc0b-657c-4fa3-91d2-61073730942b'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 16, part.movement_number = NULL,
    part.name_ko = 'Passa, passa gavião (Lá na ponte da vinhaça)', part.name_en = 'Guia prático, W276, nº 89: Passa, passa gavião (Lá na ponte da vinhaça)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 8989 AND p.composer_id = 105 AND part.part_key = 'musicbrainz:91d77abf-a710-4bc8-840f-948e9bccaad6' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:91d77abf-a710-4bc8-840f-948e9bccaad6', 16, NULL, 'Passa, passa gavião (Lá na ponte da vinhaça)', 'Guia prático, W276, nº 89: Passa, passa gavião (Lá na ponte da vinhaça)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:30e8cc0b-657c-4fa3-91d2-61073730942b'
WHERE p.id = 8989 AND p.composer_id = 105
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:91d77abf-a710-4bc8-840f-948e9bccaad6'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:30e8cc0b-657c-4fa3-91d2-61073730942b'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 17, part.movement_number = NULL,
    part.name_ko = 'Pobre peregrino', part.name_en = 'Guia prático, W276, nº 99: Pobre peregrino',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 8989 AND p.composer_id = 105 AND part.part_key = 'musicbrainz:9c0c6e6c-f108-4e90-8590-d6f2f782c74b' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:9c0c6e6c-f108-4e90-8590-d6f2f782c74b', 17, NULL, 'Pobre peregrino', 'Guia prático, W276, nº 99: Pobre peregrino', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:30e8cc0b-657c-4fa3-91d2-61073730942b'
WHERE p.id = 8989 AND p.composer_id = 105
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:9c0c6e6c-f108-4e90-8590-d6f2f782c74b'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:30e8cc0b-657c-4fa3-91d2-61073730942b'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 18, part.movement_number = NULL,
    part.name_ko = 'Constancia', part.name_en = 'Guia prático, W276, nº 41: Constancia',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 8989 AND p.composer_id = 105 AND part.part_key = 'musicbrainz:a74da532-1f9d-4748-8966-c18f923d1b96' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:a74da532-1f9d-4748-8966-c18f923d1b96', 18, NULL, 'Constancia', 'Guia prático, W276, nº 41: Constancia', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:30e8cc0b-657c-4fa3-91d2-61073730942b'
WHERE p.id = 8989 AND p.composer_id = 105
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:a74da532-1f9d-4748-8966-c18f923d1b96'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:30e8cc0b-657c-4fa3-91d2-61073730942b'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 19, part.movement_number = NULL,
    part.name_ko = 'Olha o bicho', part.name_en = 'Guia prático, W276, nº 84: Olha o bicho',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 8989 AND p.composer_id = 105 AND part.part_key = 'musicbrainz:a8a7b8d1-70d0-44ca-9ab6-8f22c2fc330f' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:a8a7b8d1-70d0-44ca-9ab6-8f22c2fc330f', 19, NULL, 'Olha o bicho', 'Guia prático, W276, nº 84: Olha o bicho', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:30e8cc0b-657c-4fa3-91d2-61073730942b'
WHERE p.id = 8989 AND p.composer_id = 105
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:a8a7b8d1-70d0-44ca-9ab6-8f22c2fc330f'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:30e8cc0b-657c-4fa3-91d2-61073730942b'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 20, part.movement_number = NULL,
    part.name_ko = 'Vitu', part.name_en = 'Guia prático, W276, nº 133: Vitu',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 8989 AND p.composer_id = 105 AND part.part_key = 'musicbrainz:bc6cf4b1-4894-486a-ac5e-5ec3d38e335f' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:bc6cf4b1-4894-486a-ac5e-5ec3d38e335f', 20, NULL, 'Vitu', 'Guia prático, W276, nº 133: Vitu', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:30e8cc0b-657c-4fa3-91d2-61073730942b'
WHERE p.id = 8989 AND p.composer_id = 105
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:bc6cf4b1-4894-486a-ac5e-5ec3d38e335f'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:30e8cc0b-657c-4fa3-91d2-61073730942b'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 21, part.movement_number = NULL,
    part.name_ko = 'Meu pai amarrou meus olhos', part.name_en = 'Guia prático, W276, nº 81: Meu pai amarrou meus olhos',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 8989 AND p.composer_id = 105 AND part.part_key = 'musicbrainz:c2f74d88-9c6b-47bf-80c2-2eaa607ec9ea' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:c2f74d88-9c6b-47bf-80c2-2eaa607ec9ea', 21, NULL, 'Meu pai amarrou meus olhos', 'Guia prático, W276, nº 81: Meu pai amarrou meus olhos', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:30e8cc0b-657c-4fa3-91d2-61073730942b'
WHERE p.id = 8989 AND p.composer_id = 105
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:c2f74d88-9c6b-47bf-80c2-2eaa607ec9ea'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:30e8cc0b-657c-4fa3-91d2-61073730942b'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 22, part.movement_number = NULL,
    part.name_ko = 'Margarida', part.name_en = 'Guia prático, W276, nº 77: Margarida',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 8989 AND p.composer_id = 105 AND part.part_key = 'musicbrainz:c6260f57-74b4-4a30-b81d-cc74d31c93cf' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:c6260f57-74b4-4a30-b81d-cc74d31c93cf', 22, NULL, 'Margarida', 'Guia prático, W276, nº 77: Margarida', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:30e8cc0b-657c-4fa3-91d2-61073730942b'
WHERE p.id = 8989 AND p.composer_id = 105
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:c6260f57-74b4-4a30-b81d-cc74d31c93cf'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:30e8cc0b-657c-4fa3-91d2-61073730942b'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 23, part.movement_number = NULL,
    part.name_ko = 'Carneirinho, carneirão', part.name_en = 'Guia prático, W276, nº 31: Carneirinho, carneirão',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 8989 AND p.composer_id = 105 AND part.part_key = 'musicbrainz:d89806f3-71aa-4684-80ab-b48b887dbe24' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:d89806f3-71aa-4684-80ab-b48b887dbe24', 23, NULL, 'Carneirinho, carneirão', 'Guia prático, W276, nº 31: Carneirinho, carneirão', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:30e8cc0b-657c-4fa3-91d2-61073730942b'
WHERE p.id = 8989 AND p.composer_id = 105
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:d89806f3-71aa-4684-80ab-b48b887dbe24'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:30e8cc0b-657c-4fa3-91d2-61073730942b'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 24, part.movement_number = NULL,
    part.name_ko = 'A maré encheu', part.name_en = 'Guia prático, W276, nº 76: A maré encheu',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 8989 AND p.composer_id = 105 AND part.part_key = 'musicbrainz:da8f872b-0201-4ce3-8d3b-9b7db6b75607' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:da8f872b-0201-4ce3-8d3b-9b7db6b75607', 24, NULL, 'A maré encheu', 'Guia prático, W276, nº 76: A maré encheu', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:30e8cc0b-657c-4fa3-91d2-61073730942b'
WHERE p.id = 8989 AND p.composer_id = 105
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:da8f872b-0201-4ce3-8d3b-9b7db6b75607'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:30e8cc0b-657c-4fa3-91d2-61073730942b'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 25, part.movement_number = NULL,
    part.name_ko = 'Na Bahia tem', part.name_en = 'Guia prático, W276, nº 12: Na Bahia tem',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 8989 AND p.composer_id = 105 AND part.part_key = 'musicbrainz:f07c7e95-a65b-40e8-862a-84f9fe78c9ea' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:f07c7e95-a65b-40e8-862a-84f9fe78c9ea', 25, NULL, 'Na Bahia tem', 'Guia prático, W276, nº 12: Na Bahia tem', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:30e8cc0b-657c-4fa3-91d2-61073730942b'
WHERE p.id = 8989 AND p.composer_id = 105
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:f07c7e95-a65b-40e8-862a-84f9fe78c9ea'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:30e8cc0b-657c-4fa3-91d2-61073730942b'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 26, part.movement_number = NULL,
    part.name_ko = 'Manda tiro, tiro lá', part.name_en = 'Guia prático, W276, nº 73: Manda tiro, tiro lá',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 8989 AND p.composer_id = 105 AND part.part_key = 'musicbrainz:f2beb42f-8d39-427d-8a3f-76bfcef9e951' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:f2beb42f-8d39-427d-8a3f-76bfcef9e951', 26, NULL, 'Manda tiro, tiro lá', 'Guia prático, W276, nº 73: Manda tiro, tiro lá', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:30e8cc0b-657c-4fa3-91d2-61073730942b'
WHERE p.id = 8989 AND p.composer_id = 105
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:f2beb42f-8d39-427d-8a3f-76bfcef9e951'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:30e8cc0b-657c-4fa3-91d2-61073730942b'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 27, part.movement_number = NULL,
    part.name_ko = 'Passarás, não passarás', part.name_en = 'Guia prático, W276, nº 90: Passarás, não passarás',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 8989 AND p.composer_id = 105 AND part.part_key = 'musicbrainz:fa8afbbe-dd5f-458f-9cd2-6fb52aeaf733' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:fa8afbbe-dd5f-458f-9cd2-6fb52aeaf733', 27, NULL, 'Passarás, não passarás', 'Guia prático, W276, nº 90: Passarás, não passarás', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:30e8cc0b-657c-4fa3-91d2-61073730942b'
WHERE p.id = 8989 AND p.composer_id = 105
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:fa8afbbe-dd5f-458f-9cd2-6fb52aeaf733'
);


-- W 473 Guia prático, nº 11 W 473

UPDATE pieces piece
SET piece.title = 'Guia prático, nº 11 W 473', piece.title_en = 'Guia prático, nº 11, W473',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = 'W', piece.catalogue_number = '473',
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 10991 AND piece.composer_id = 105
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'O anel', part.name_en = 'Guia prático, nº 11, W473, nº 1: O anel',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 10991 AND p.composer_id = 105 AND part.part_key = 'musicbrainz:cecec475-2db5-4650-b07f-1792c743e3fc' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:cecec475-2db5-4650-b07f-1792c743e3fc', 1, NULL, 'O anel', 'Guia prático, nº 11, W473, nº 1: O anel', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 10991 AND p.composer_id = 105
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:cecec475-2db5-4650-b07f-1792c743e3fc'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'Nigue ninhas', part.name_en = 'Guia prático, nº 11, W473, nº 2: Nigue ninhas',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 10991 AND p.composer_id = 105 AND part.part_key = 'musicbrainz:90dd4805-cf79-4e25-8a54-6496a9a6675f' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:90dd4805-cf79-4e25-8a54-6496a9a6675f', 2, NULL, 'Nigue ninhas', 'Guia prático, nº 11, W473, nº 2: Nigue ninhas', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 10991 AND p.composer_id = 105
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:90dd4805-cf79-4e25-8a54-6496a9a6675f'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = NULL,
    part.name_ko = 'Pobre cega', part.name_en = 'Guia prático, nº 11, W473, nº 3: Pobre cega',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 10991 AND p.composer_id = 105 AND part.part_key = 'musicbrainz:3022d58b-ce9c-4c2f-ae34-7b845e0cc5a1' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:3022d58b-ce9c-4c2f-ae34-7b845e0cc5a1', 3, NULL, 'Pobre cega', 'Guia prático, nº 11, W473, nº 3: Pobre cega', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 10991 AND p.composer_id = 105
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:3022d58b-ce9c-4c2f-ae34-7b845e0cc5a1'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = NULL,
    part.name_ko = 'A cotia', part.name_en = 'Guia prático, nº 11, W473, nº 4: A cotia',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 10991 AND p.composer_id = 105 AND part.part_key = 'musicbrainz:e362727e-21a1-45a9-8de9-9ea93a58ae5f' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:e362727e-21a1-45a9-8de9-9ea93a58ae5f', 4, NULL, 'A cotia', 'Guia prático, nº 11, W473, nº 4: A cotia', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 10991 AND p.composer_id = 105
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:e362727e-21a1-45a9-8de9-9ea93a58ae5f'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 5, part.movement_number = NULL,
    part.name_ko = 'Vida formosa', part.name_en = 'Guia prático, nº 11, W473, nº 5: Vida formosa',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 10991 AND p.composer_id = 105 AND part.part_key = 'musicbrainz:86acff67-2c5c-4e3f-853f-bd7a1122968c' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:86acff67-2c5c-4e3f-853f-bd7a1122968c', 5, NULL, 'Vida formosa', 'Guia prático, nº 11, W473, nº 5: Vida formosa', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 10991 AND p.composer_id = 105
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:86acff67-2c5c-4e3f-853f-bd7a1122968c'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 6, part.movement_number = NULL,
    part.name_ko = 'Viva o carnaval', part.name_en = 'Guia prático, nº 11, W473, nº 6: Viva o carnaval',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 10991 AND p.composer_id = 105 AND part.part_key = 'musicbrainz:25c85771-cecc-4426-bfc1-8ffbcd039c56' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:25c85771-cecc-4426-bfc1-8ffbcd039c56', 6, NULL, 'Viva o carnaval', 'Guia prático, nº 11, W473, nº 6: Viva o carnaval', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 10991 AND p.composer_id = 105
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:25c85771-cecc-4426-bfc1-8ffbcd039c56'
);


-- W 522 Gênesis

UPDATE pieces piece
SET piece.title = 'Gênesis', piece.title_en = 'Gênesis, W522',
    piece.type = 'song', piece.opus_number = 'W 522',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 9737 AND piece.composer_id = 105
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Harmonica Concerto

UPDATE pieces piece
SET piece.title = 'Harmonica Concerto', piece.title_en = 'Harmonica Concerto',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 8736 AND piece.composer_id = 105
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'Allegro moderato', part.name_en = 'Harmonica Concerto: I. Allegro moderato',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 8736 AND p.composer_id = 105 AND part.part_key = 'musicbrainz:86fd3d42-9631-4dc2-9863-1a63e1b35b18' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:86fd3d42-9631-4dc2-9863-1a63e1b35b18', 1, 'I', 'Allegro moderato', 'Harmonica Concerto: I. Allegro moderato', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 8736 AND p.composer_id = 105
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:86fd3d42-9631-4dc2-9863-1a63e1b35b18'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'Andante', part.name_en = 'Harmonica Concerto: II. Andante',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 8736 AND p.composer_id = 105 AND part.part_key = 'musicbrainz:552e98b0-15a0-4c2c-ba37-5570772be231' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:552e98b0-15a0-4c2c-ba37-5570772be231', 2, 'II', 'Andante', 'Harmonica Concerto: II. Andante', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 8736 AND p.composer_id = 105
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:552e98b0-15a0-4c2c-ba37-5570772be231'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = 'Allegro', part.name_en = 'Harmonica Concerto: III. Allegro',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 8736 AND p.composer_id = 105 AND part.part_key = 'musicbrainz:b6315977-34f7-4d41-997e-038550a07cf0' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:b6315977-34f7-4d41-997e-038550a07cf0', 3, 'III', 'Allegro', 'Harmonica Concerto: III. Allegro', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 8736 AND p.composer_id = 105
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:b6315977-34f7-4d41-997e-038550a07cf0'
);


-- W 148 Histórias da Carochinha

UPDATE pieces piece
SET piece.title = 'Histórias da Carochinha', piece.title_en = 'Histórias da Carochinha, W148',
    piece.type = 'album', piece.opus_number = 'W 148',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 9910 AND piece.composer_id = 105
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'No palacio encantado', part.name_en = 'Histórias da Carochinha, W148: I. No palacio encantado',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 9910 AND p.composer_id = 105 AND part.part_key = 'musicbrainz:0175078b-232c-47f4-83e9-12fa34a3f858' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:0175078b-232c-47f4-83e9-12fa34a3f858', 1, 'I', 'No palacio encantado', 'Histórias da Carochinha, W148: I. No palacio encantado', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 9910 AND p.composer_id = 105
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:0175078b-232c-47f4-83e9-12fa34a3f858'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'A cortesia do principezinho', part.name_en = 'Histórias da Carochinha, W148: II. A cortesia do principezinho',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 9910 AND p.composer_id = 105 AND part.part_key = 'musicbrainz:5245e381-ba07-477b-b886-1b0c9f3038ec' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:5245e381-ba07-477b-b886-1b0c9f3038ec', 2, 'II', 'A cortesia do principezinho', 'Histórias da Carochinha, W148: II. A cortesia do principezinho', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 9910 AND p.composer_id = 105
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:5245e381-ba07-477b-b886-1b0c9f3038ec'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = 'E o pastorzinho cantava', part.name_en = 'Histórias da Carochinha, W148: III. E o pastorzinho cantava',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 9910 AND p.composer_id = 105 AND part.part_key = 'musicbrainz:3904347e-3a3d-4c64-b5b3-d0fde497c609' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:3904347e-3a3d-4c64-b5b3-d0fde497c609', 3, 'III', 'E o pastorzinho cantava', 'Histórias da Carochinha, W148: III. E o pastorzinho cantava', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 9910 AND p.composer_id = 105
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:3904347e-3a3d-4c64-b5b3-d0fde497c609'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = 'IV',
    part.name_ko = 'E a princezinha dançava', part.name_en = 'Histórias da Carochinha, W148: IV. E a princezinha dançava',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 9910 AND p.composer_id = 105 AND part.part_key = 'musicbrainz:7a205068-8856-4bfe-8a1d-e969432fb462' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:7a205068-8856-4bfe-8a1d-e969432fb462', 4, 'IV', 'E a princezinha dançava', 'Histórias da Carochinha, W148: IV. E a princezinha dançava', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 9910 AND p.composer_id = 105
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:7a205068-8856-4bfe-8a1d-e969432fb462'
);


-- W 474 Homenagem a Chopin

UPDATE pieces piece
SET piece.title = 'Homenagem a Chopin', piece.title_en = 'Homenagem a Chopin, W474',
    piece.type = 'album', piece.opus_number = 'W 474',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 9235 AND piece.composer_id = 105
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'Noturno', part.name_en = 'Homenagem a Chopin, W474: I. Noturno',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 9235 AND p.composer_id = 105 AND part.part_key = 'musicbrainz:eaef49f9-7ded-4acb-8c4e-be923b1efd43' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:eaef49f9-7ded-4acb-8c4e-be923b1efd43', 1, 'I', 'Noturno', 'Homenagem a Chopin, W474: I. Noturno', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 9235 AND p.composer_id = 105
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:eaef49f9-7ded-4acb-8c4e-be923b1efd43'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'Ballada', part.name_en = 'Homenagem a Chopin, W474: II. Ballada',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 9235 AND p.composer_id = 105 AND part.part_key = 'musicbrainz:baee27e0-7aa5-474b-93da-8bfd79c6817b' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:baee27e0-7aa5-474b-93da-8bfd79c6817b', 2, 'II', 'Ballada', 'Homenagem a Chopin, W474: II. Ballada', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 9235 AND p.composer_id = 105
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:baee27e0-7aa5-474b-93da-8bfd79c6817b'
);


-- W 077 Ibericarabé

UPDATE pieces piece
SET piece.title = 'Ibericarabé', piece.title_en = 'Ibericarabé, W077',
    piece.type = 'song', piece.opus_number = 'W 077',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 7787 AND piece.composer_id = 105
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- W 096 Improviso

UPDATE pieces piece
SET piece.title = 'Improviso', piece.title_en = 'Improviso, W096',
    piece.type = 'song', piece.opus_number = 'W 096',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 11204 AND piece.composer_id = 105
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- W 239 Introdução aos choros

UPDATE pieces piece
SET piece.title = 'Introdução aos choros', piece.title_en = 'Introdução aos choros, W239',
    piece.type = 'song', piece.opus_number = 'W 239',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 8503 AND piece.composer_id = 105
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- W 439 Invocação em defesa da pátria

UPDATE pieces piece
SET piece.title = 'Invocação em defesa da pátria', piece.title_en = 'Invocação em defesa da pátria, W439',
    piece.type = 'song', piece.opus_number = 'W 439',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 10974 AND piece.composer_id = 105
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- W 455 José

UPDATE pieces piece
SET piece.title = 'José', piece.title_en = 'José, W455',
    piece.type = 'song', piece.opus_number = 'W 455',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 9546 AND piece.composer_id = 105
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- W 554 Magnificat Alleluia

UPDATE pieces piece
SET piece.title = 'Magnificat Alleluia', piece.title_en = 'Magnificat Alleluia, W554',
    piece.type = 'song', piece.opus_number = 'W 554',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 8587 AND piece.composer_id = 105
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- W 396 Marquesa de Santos

UPDATE pieces piece
SET piece.title = 'Marquesa de Santos', piece.title_en = 'Marquesa de Santos, W396',
    piece.type = 'album', piece.opus_number = 'W 396',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 8273 AND piece.composer_id = 105
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'Valsinha Brasileira', part.name_en = 'Marquesa de Santos, W396: I. Valsinha Brasileira',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 8273 AND p.composer_id = 105 AND part.part_key = 'musicbrainz:a4fd6a12-fb79-489f-a4f8-0a63247d94c3' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:a4fd6a12-fb79-489f-a4f8-0a63247d94c3', 1, 'I', 'Valsinha Brasileira', 'Marquesa de Santos, W396: I. Valsinha Brasileira', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 8273 AND p.composer_id = 105
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:a4fd6a12-fb79-489f-a4f8-0a63247d94c3'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'Gavota-choro', part.name_en = 'Marquesa de Santos, W396: II. Gavota-choro',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 8273 AND p.composer_id = 105 AND part.part_key = 'musicbrainz:b8d94cee-ebb6-490e-a36b-0402f923fc97' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:b8d94cee-ebb6-490e-a36b-0402f923fc97', 2, 'II', 'Gavota-choro', 'Marquesa de Santos, W396: II. Gavota-choro', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 8273 AND p.composer_id = 105
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:b8d94cee-ebb6-490e-a36b-0402f923fc97'
);


-- W 213 Martírio dos insetos

UPDATE pieces piece
SET piece.title = 'Martírio dos insetos', piece.title_en = 'Martírio dos insetos, W213',
    piece.type = 'album', piece.opus_number = 'W 213',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 8760 AND piece.composer_id = 105
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'A cigarra no inverno', part.name_en = 'Martírio dos insetos, W213: I. A cigarra no inverno',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 8760 AND p.composer_id = 105 AND part.part_key = 'musicbrainz:1018c1cb-eeba-47e8-8e48-ef75cc7742cb' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:1018c1cb-eeba-47e8-8e48-ef75cc7742cb', 1, 'I', 'A cigarra no inverno', 'Martírio dos insetos, W213: I. A cigarra no inverno', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 8760 AND p.composer_id = 105
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:1018c1cb-eeba-47e8-8e48-ef75cc7742cb'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'III',
    part.name_ko = 'Mariposa na luz', part.name_en = 'Martírio dos insetos, W213: III. Mariposa na luz',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 8760 AND p.composer_id = 105 AND part.part_key = 'musicbrainz:20970bf8-6404-4ee9-809d-0f8326a76eb2' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:20970bf8-6404-4ee9-809d-0f8326a76eb2', 2, 'III', 'Mariposa na luz', 'Martírio dos insetos, W213: III. Mariposa na luz', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 8760 AND p.composer_id = 105
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:20970bf8-6404-4ee9-809d-0f8326a76eb2'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'II',
    part.name_ko = 'O vagalume na claridade', part.name_en = 'Martírio dos insetos, W213: II. O vagalume na claridade',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 8760 AND p.composer_id = 105 AND part.part_key = 'musicbrainz:3ce37d98-52d4-4d8f-83d4-226623be406c' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:3ce37d98-52d4-4d8f-83d4-226623be406c', 3, 'II', 'O vagalume na claridade', 'Martírio dos insetos, W213: II. O vagalume na claridade', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 8760 AND p.composer_id = 105
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:3ce37d98-52d4-4d8f-83d4-226623be406c'
);


-- None Melodia da montanha (Serra da Piedade de Belo Horizonte)

UPDATE pieces piece
SET piece.title = 'Melodia da montanha (Serra da Piedade de Belo Horizonte)', piece.title_en = 'Melodia da montanha (Serra da Piedade de Belo Horizonte)',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 9541 AND piece.composer_id = 105
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- W 383 Missa São Sebastião

UPDATE pieces piece
SET piece.title = 'Missa São Sebastião', piece.title_en = 'Missa São Sebastião, W383',
    piece.type = 'album', piece.opus_number = 'W 383',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 8030 AND piece.composer_id = 105
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'Kyrie - Sebastian! The Virtuous', part.name_en = 'Missa São Sebastião, W383: I. Kyrie - Sebastian! The Virtuous',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 8030 AND p.composer_id = 105 AND part.part_key = 'musicbrainz:c13fc825-d18f-423d-aaa4-6e653bfb49df' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:c13fc825-d18f-423d-aaa4-6e653bfb49df', 1, 'I', 'Kyrie - Sebastian! The Virtuous', 'Missa São Sebastião, W383: I. Kyrie - Sebastian! The Virtuous', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 8030 AND p.composer_id = 105
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:c13fc825-d18f-423d-aaa4-6e653bfb49df'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'Gloria - Sebastian! The Roman Soldier', part.name_en = 'Missa São Sebastião, W383: II. Gloria - Sebastian! The Roman Soldier',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 8030 AND p.composer_id = 105 AND part.part_key = 'musicbrainz:700bce60-7317-4526-98a9-6bb73a27909f' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:700bce60-7317-4526-98a9-6bb73a27909f', 2, 'II', 'Gloria - Sebastian! The Roman Soldier', 'Missa São Sebastião, W383: II. Gloria - Sebastian! The Roman Soldier', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 8030 AND p.composer_id = 105
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:700bce60-7317-4526-98a9-6bb73a27909f'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = 'Credo - Sebastian! Defender of the Church', part.name_en = 'Missa São Sebastião, W383: III. Credo - Sebastian! Defender of the Church',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 8030 AND p.composer_id = 105 AND part.part_key = 'musicbrainz:430114d1-2d2d-4589-8b9f-ee7f14ca0808' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:430114d1-2d2d-4589-8b9f-ee7f14ca0808', 3, 'III', 'Credo - Sebastian! Defender of the Church', 'Missa São Sebastião, W383: III. Credo - Sebastian! Defender of the Church', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 8030 AND p.composer_id = 105
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:430114d1-2d2d-4589-8b9f-ee7f14ca0808'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = 'IV',
    part.name_ko = 'Sanctus - Sebastian! The Martyr', part.name_en = 'Missa São Sebastião, W383: IV. Sanctus - Sebastian! The Martyr',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 8030 AND p.composer_id = 105 AND part.part_key = 'musicbrainz:2182d170-53b8-42fd-8408-c6a61dc3a3ef' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:2182d170-53b8-42fd-8408-c6a61dc3a3ef', 4, 'IV', 'Sanctus - Sebastian! The Martyr', 'Missa São Sebastião, W383: IV. Sanctus - Sebastian! The Martyr', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 8030 AND p.composer_id = 105
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:2182d170-53b8-42fd-8408-c6a61dc3a3ef'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 5, part.movement_number = 'V',
    part.name_ko = 'Benedictus - Sebastian! The Saint', part.name_en = 'Missa São Sebastião, W383: V. Benedictus - Sebastian! The Saint',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 8030 AND p.composer_id = 105 AND part.part_key = 'musicbrainz:f47f26c5-2dce-4d4e-9426-d248256a3b05' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:f47f26c5-2dce-4d4e-9426-d248256a3b05', 5, 'V', 'Benedictus - Sebastian! The Saint', 'Missa São Sebastião, W383: V. Benedictus - Sebastian! The Saint', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 8030 AND p.composer_id = 105
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:f47f26c5-2dce-4d4e-9426-d248256a3b05'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 6, part.movement_number = 'VI',
    part.name_ko = 'Agnus Dei - Sebastian! Protector of Brazil', part.name_en = 'Missa São Sebastião, W383: VI. Agnus Dei - Sebastian! Protector of Brazil',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 8030 AND p.composer_id = 105 AND part.part_key = 'musicbrainz:eed9a616-1d28-4442-9954-b505560e7a43' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:eed9a616-1d28-4442-9954-b505560e7a43', 6, 'VI', 'Agnus Dei - Sebastian! Protector of Brazil', 'Missa São Sebastião, W383: VI. Agnus Dei - Sebastian! Protector of Brazil', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 8030 AND p.composer_id = 105
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:eed9a616-1d28-4442-9954-b505560e7a43'
);


-- W 365 연가곡집 <Modinhas e canções nº 1> W 365

UPDATE pieces piece
SET piece.title = '연가곡집 <Modinhas e canções nº 1> W 365', piece.title_en = 'Modinhas e canções nº 1, W365',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = 'W', piece.catalogue_number = '365',
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 7961 AND piece.composer_id = 105
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'Canção do marinheiro', part.name_en = 'Modinhas e canções nº 1, W365, nº 1: Canção do marinheiro',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 7961 AND p.composer_id = 105 AND part.part_key = 'musicbrainz:b87b4b37-8c2e-4966-b5ab-0958f9111cec' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:b87b4b37-8c2e-4966-b5ab-0958f9111cec', 1, NULL, 'Canção do marinheiro', 'Modinhas e canções nº 1, W365, nº 1: Canção do marinheiro', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 7961 AND p.composer_id = 105
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:b87b4b37-8c2e-4966-b5ab-0958f9111cec'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'Lundú da Marquesa de Santos', part.name_en = 'Modinhas e canções nº 1, W365, nº 2: Lundú da Marquesa de Santos',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 7961 AND p.composer_id = 105 AND part.part_key = 'musicbrainz:a34ed0d3-75df-41a5-8d29-2c673f3880ae' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:a34ed0d3-75df-41a5-8d29-2c673f3880ae', 2, NULL, 'Lundú da Marquesa de Santos', 'Modinhas e canções nº 1, W365, nº 2: Lundú da Marquesa de Santos', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 7961 AND p.composer_id = 105
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:a34ed0d3-75df-41a5-8d29-2c673f3880ae'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = NULL,
    part.name_ko = 'Cantilena (Um canto que saiu das senzalas)', part.name_en = 'Modinhas e canções nº 1, W365, nº 3: Cantilena (Um canto que saiu das senzalas)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 7961 AND p.composer_id = 105 AND part.part_key = 'musicbrainz:b679ffc6-8ece-4be6-84e7-4355626e494b' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:b679ffc6-8ece-4be6-84e7-4355626e494b', 3, NULL, 'Cantilena (Um canto que saiu das senzalas)', 'Modinhas e canções nº 1, W365, nº 3: Cantilena (Um canto que saiu das senzalas)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 7961 AND p.composer_id = 105
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:b679ffc6-8ece-4be6-84e7-4355626e494b'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = NULL,
    part.name_ko = 'A gatinha parda', part.name_en = 'Modinhas e canções nº 1, W365, nº 4: A gatinha parda',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 7961 AND p.composer_id = 105 AND part.part_key = 'musicbrainz:e0f074c8-602b-42de-ad30-1081d765e939' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:e0f074c8-602b-42de-ad30-1081d765e939', 4, NULL, 'A gatinha parda', 'Modinhas e canções nº 1, W365, nº 4: A gatinha parda', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 7961 AND p.composer_id = 105
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:e0f074c8-602b-42de-ad30-1081d765e939'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 5, part.movement_number = NULL,
    part.name_ko = 'Remeiro de São Francisco', part.name_en = 'Modinhas e canções nº 1, W365, nº 5: Remeiro de São Francisco',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 7961 AND p.composer_id = 105 AND part.part_key = 'musicbrainz:2225adfd-61e7-426b-8c2b-4b75035b670b' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:2225adfd-61e7-426b-8c2b-4b75035b670b', 5, NULL, 'Remeiro de São Francisco', 'Modinhas e canções nº 1, W365, nº 5: Remeiro de São Francisco', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 7961 AND p.composer_id = 105
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:2225adfd-61e7-426b-8c2b-4b75035b670b'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 6, part.movement_number = NULL,
    part.name_ko = 'Nhapopê', part.name_en = 'Modinhas e canções nº 1, W365, nº 6: Nhapopê',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 7961 AND p.composer_id = 105 AND part.part_key = 'musicbrainz:5cb3ea69-e44b-4f15-9f84-a5ade35571cb' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:5cb3ea69-e44b-4f15-9f84-a5ade35571cb', 6, NULL, 'Nhapopê', 'Modinhas e canções nº 1, W365, nº 6: Nhapopê', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 7961 AND p.composer_id = 105
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:5cb3ea69-e44b-4f15-9f84-a5ade35571cb'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 7, part.movement_number = NULL,
    part.name_ko = 'Evocação', part.name_en = 'Modinhas e canções nº 1, W365, nº 7: Evocação',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 7961 AND p.composer_id = 105 AND part.part_key = 'musicbrainz:ed81e1fd-8e76-4323-bbf1-1ddd6ea6a63d' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:ed81e1fd-8e76-4323-bbf1-1ddd6ea6a63d', 7, NULL, 'Evocação', 'Modinhas e canções nº 1, W365, nº 7: Evocação', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 7961 AND p.composer_id = 105
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:ed81e1fd-8e76-4323-bbf1-1ddd6ea6a63d'
);


-- W 441 연가곡집 <Modinhas e canções nº 2> W 441

UPDATE pieces piece
SET piece.title = '연가곡집 <Modinhas e canções nº 2> W 441', piece.title_en = 'Modinhas e canções nº 2, W441',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = 'W', piece.catalogue_number = '441',
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 11012 AND piece.composer_id = 105
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'Pobre peregrino', part.name_en = 'Modinhas e canções nº 2, W441, nº 1: Pobre peregrino',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11012 AND p.composer_id = 105 AND part.part_key = 'musicbrainz:db90f8ba-6fb6-43d2-9229-1b9618676a0b' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:db90f8ba-6fb6-43d2-9229-1b9618676a0b', 1, NULL, 'Pobre peregrino', 'Modinhas e canções nº 2, W441, nº 1: Pobre peregrino', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 11012 AND p.composer_id = 105
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:db90f8ba-6fb6-43d2-9229-1b9618676a0b'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'Vida formosa', part.name_en = 'Modinhas e canções nº 2, W441, nº 2: Vida formosa',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11012 AND p.composer_id = 105 AND part.part_key = 'musicbrainz:dc7eccd5-4d1f-4652-a9cb-11092885a9ed' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:dc7eccd5-4d1f-4652-a9cb-11092885a9ed', 2, NULL, 'Vida formosa', 'Modinhas e canções nº 2, W441, nº 2: Vida formosa', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 11012 AND p.composer_id = 105
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:dc7eccd5-4d1f-4652-a9cb-11092885a9ed'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = NULL,
    part.name_ko = 'Nésta rua', part.name_en = 'Modinhas e canções nº 2, W441, nº 3: Nésta rua',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11012 AND p.composer_id = 105 AND part.part_key = 'musicbrainz:0837ba5b-930e-4a4b-83e1-09d4ee111b99' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:0837ba5b-930e-4a4b-83e1-09d4ee111b99', 3, NULL, 'Nésta rua', 'Modinhas e canções nº 2, W441, nº 3: Nésta rua', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 11012 AND p.composer_id = 105
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:0837ba5b-930e-4a4b-83e1-09d4ee111b99'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = NULL,
    part.name_ko = 'Manda tiro, tiro lá', part.name_en = 'Modinhas e canções nº 2, W441, nº 4: Manda tiro, tiro lá',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11012 AND p.composer_id = 105 AND part.part_key = 'musicbrainz:15861cf5-0eb4-459f-b2e1-40ce8be7dc6e' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:15861cf5-0eb4-459f-b2e1-40ce8be7dc6e', 4, NULL, 'Manda tiro, tiro lá', 'Modinhas e canções nº 2, W441, nº 4: Manda tiro, tiro lá', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 11012 AND p.composer_id = 105
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:15861cf5-0eb4-459f-b2e1-40ce8be7dc6e'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 5, part.movement_number = NULL,
    part.name_ko = 'João Cambuête', part.name_en = 'Modinhas e canções nº 2, W441, nº 5: João Cambuête',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11012 AND p.composer_id = 105 AND part.part_key = 'musicbrainz:1f8655bd-d54e-409a-8fb9-61ad01cd7dcd' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:1f8655bd-d54e-409a-8fb9-61ad01cd7dcd', 5, NULL, 'João Cambuête', 'Modinhas e canções nº 2, W441, nº 5: João Cambuête', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 11012 AND p.composer_id = 105
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:1f8655bd-d54e-409a-8fb9-61ad01cd7dcd'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 6, part.movement_number = NULL,
    part.name_ko = 'Na corda da viola', part.name_en = 'Modinhas e canções nº 2, W441, nº 6: Na corda da viola',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11012 AND p.composer_id = 105 AND part.part_key = 'musicbrainz:6cacb499-eb82-4ede-a36a-4ea436fa1b83' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:6cacb499-eb82-4ede-a36a-4ea436fa1b83', 6, NULL, 'Na corda da viola', 'Modinhas e canções nº 2, W441, nº 6: Na corda da viola', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 11012 AND p.composer_id = 105
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:6cacb499-eb82-4ede-a36a-4ea436fa1b83'
);


-- W 240 Momoprecoce

UPDATE pieces piece
SET piece.title = 'Momoprecoce', piece.title_en = 'Momoprecoce, W240',
    piece.type = 'song', piece.opus_number = 'W 240',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 8296 AND piece.composer_id = 105
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- W 507 Música sacra W 507

UPDATE pieces piece
SET piece.title = 'Música sacra W 507', piece.title_en = 'Música sacra, W507',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = 'W', piece.catalogue_number = '507',
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 9263 AND piece.composer_id = 105
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'Sub Tuum Præsidium', part.name_en = 'Sub Tuum Præsidium',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 9263 AND p.composer_id = 105 AND part.part_key = 'musicbrainz:ba6c448e-fc45-4960-87a0-ec191e8fddb7' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:ba6c448e-fc45-4960-87a0-ec191e8fddb7', 1, NULL, 'Sub Tuum Præsidium', 'Sub Tuum Præsidium', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 9263 AND p.composer_id = 105
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:ba6c448e-fc45-4960-87a0-ec191e8fddb7'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'Ave Maria', part.name_en = 'Ave Maria',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 9263 AND p.composer_id = 105 AND part.part_key = 'musicbrainz:087c26bf-5382-4678-8060-796b10f0631f' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:087c26bf-5382-4678-8060-796b10f0631f', 2, NULL, 'Ave Maria', 'Ave Maria', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 9263 AND p.composer_id = 105
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:087c26bf-5382-4678-8060-796b10f0631f'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = NULL,
    part.name_ko = 'Ave Verum', part.name_en = 'Ave Verum',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 9263 AND p.composer_id = 105 AND part.part_key = 'musicbrainz:0bda3aee-6044-477f-ad9d-bf246f44aadd' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:0bda3aee-6044-477f-ad9d-bf246f44aadd', 3, NULL, 'Ave Verum', 'Ave Verum', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 9263 AND p.composer_id = 105
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:0bda3aee-6044-477f-ad9d-bf246f44aadd'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = NULL,
    part.name_ko = 'Ave Maria no. 18, W120', part.name_en = 'Ave Maria no. 18, W120',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 9263 AND p.composer_id = 105 AND part.part_key = 'musicbrainz:15215491-ef25-4d95-8423-b53d3773b358' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:15215491-ef25-4d95-8423-b53d3773b358', 4, NULL, 'Ave Maria no. 18, W120', 'Ave Maria no. 18, W120', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 9263 AND p.composer_id = 105
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:15215491-ef25-4d95-8423-b53d3773b358'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 5, part.movement_number = NULL,
    part.name_ko = 'Ave Maria', part.name_en = 'Ave Maria',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 9263 AND p.composer_id = 105 AND part.part_key = 'musicbrainz:97da730e-a818-4499-8bd9-9b36b746b286' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:97da730e-a818-4499-8bd9-9b36b746b286', 5, NULL, 'Ave Maria', 'Ave Maria', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 9263 AND p.composer_id = 105
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:97da730e-a818-4499-8bd9-9b36b746b286'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 6, part.movement_number = NULL,
    part.name_ko = 'Cor Dulce, Cor Amabile', part.name_en = 'Música Sacra, W507: No. 18, Cor Dulce, Cor Amabile',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 9263 AND p.composer_id = 105 AND part.part_key = 'musicbrainz:b19f93e1-8e2e-482c-84a8-2f017cc39baa' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:b19f93e1-8e2e-482c-84a8-2f017cc39baa', 6, NULL, 'Cor Dulce, Cor Amabile', 'Música Sacra, W507: No. 18, Cor Dulce, Cor Amabile', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 9263 AND p.composer_id = 105
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:b19f93e1-8e2e-482c-84a8-2f017cc39baa'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 7, part.movement_number = NULL,
    part.name_ko = 'Pater Noster', part.name_en = 'Pater Noster',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 9263 AND p.composer_id = 105 AND part.part_key = 'musicbrainz:ddb4e5a4-6d09-4531-a984-620c1ac03fb9' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:ddb4e5a4-6d09-4531-a984-620c1ac03fb9', 7, NULL, 'Pater Noster', 'Pater Noster', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 9263 AND p.composer_id = 105
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:ddb4e5a4-6d09-4531-a984-620c1ac03fb9'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 8, part.movement_number = NULL,
    part.name_ko = 'Praesepe', part.name_en = 'Praesepe',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 9263 AND p.composer_id = 105 AND part.part_key = 'musicbrainz:dfcd7c79-c6fe-4664-a700-18ed8f1c5f53' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:dfcd7c79-c6fe-4664-a700-18ed8f1c5f53', 8, NULL, 'Praesepe', 'Praesepe', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 9263 AND p.composer_id = 105
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:dfcd7c79-c6fe-4664-a700-18ed8f1c5f53'
);


-- W 111 Naufrágio de Kleônicos

UPDATE pieces piece
SET piece.title = 'Naufrágio de Kleônicos', piece.title_en = 'Naufrágio de Kleônicos, W111',
    piece.type = 'song', piece.opus_number = 'W 111',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 9184 AND piece.composer_id = 105
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- W 407 New York Skyline Melody

UPDATE pieces piece
SET piece.title = 'New York Skyline Melody', piece.title_en = 'New York Skyline Melody, W407',
    piece.type = 'song', piece.opus_number = 'W 407',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 7735 AND piece.composer_id = 105
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- W 191 Noneto

UPDATE pieces piece
SET piece.title = 'Noneto', piece.title_en = 'Noneto, W191',
    piece.type = 'song', piece.opus_number = 'W 191',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 8994 AND piece.composer_id = 105
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- W 101 O Salutaris Hostia

UPDATE pieces piece
SET piece.title = 'O Salutaris Hostia', piece.title_en = 'O Salutaris Hostia, W101',
    piece.type = 'song', piece.opus_number = 'W 101',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 8987 AND piece.composer_id = 105
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- W 302 O papagaio do moleque

UPDATE pieces piece
SET piece.title = 'O papagaio do moleque', piece.title_en = 'O papagaio do moleque, W302',
    piece.type = 'song', piece.opus_number = 'W 302',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 9083 AND piece.composer_id = 105
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- Op. 31 Ondulando

UPDATE pieces piece
SET piece.title = 'Ondulando', piece.title_en = 'Ondulando, op. 31, W082',
    piece.type = 'song', piece.opus_number = 'Op. 31',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 8310 AND piece.composer_id = 105
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- W 508 Ouverture de l'homme Tel

UPDATE pieces piece
SET piece.title = 'Ouverture de l''homme Tel', piece.title_en = 'Ouverture de l''homme Tel, W508',
    piece.type = 'song', piece.opus_number = 'W 508',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 9919 AND piece.composer_id = 105
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- W 509 Panis Angelicus

UPDATE pieces piece
SET piece.title = 'Panis Angelicus', piece.title_en = 'Panis Angelicus, W509',
    piece.type = 'song', piece.opus_number = 'W 509',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 10115 AND piece.composer_id = 105
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Pensées d'Enfant

UPDATE pieces piece
SET piece.title = 'Pensées d''Enfant', piece.title_en = 'Pensées d''Enfant',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 9214 AND piece.composer_id = 105
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- W 064 Pequena suíte

UPDATE pieces piece
SET piece.title = 'Pequena suíte', piece.title_en = 'Pequena suíte, W064',
    piece.type = 'album', piece.opus_number = 'W 064',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 10816 AND piece.composer_id = 105
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'Romancette', part.name_en = 'Pequena suíte, W064: I. Romancette',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 10816 AND p.composer_id = 105 AND part.part_key = 'musicbrainz:c41da9e7-0846-44ea-842e-833b0fa2557e' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:c41da9e7-0846-44ea-842e-833b0fa2557e', 1, 'I', 'Romancette', 'Pequena suíte, W064: I. Romancette', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 10816 AND p.composer_id = 105
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:c41da9e7-0846-44ea-842e-833b0fa2557e'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'Legendária', part.name_en = 'Pequena suíte, W064: II. Legendária',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 10816 AND p.composer_id = 105 AND part.part_key = 'musicbrainz:70e19347-04e0-4bc8-980a-00bfd0a0d581' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:70e19347-04e0-4bc8-980a-00bfd0a0d581', 2, 'II', 'Legendária', 'Pequena suíte, W064: II. Legendária', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 10816 AND p.composer_id = 105
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:70e19347-04e0-4bc8-980a-00bfd0a0d581'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = 'Harmonias soltas', part.name_en = 'Pequena suíte, W064: III. Harmonias soltas',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 10816 AND p.composer_id = 105 AND part.part_key = 'musicbrainz:8d3b6cc8-0827-4e73-a076-d89b82cab647' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:8d3b6cc8-0827-4e73-a076-d89b82cab647', 3, 'III', 'Harmonias soltas', 'Pequena suíte, W064: III. Harmonias soltas', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 10816 AND p.composer_id = 105
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:8d3b6cc8-0827-4e73-a076-d89b82cab647'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = 'IV',
    part.name_ko = 'Fugato (all''antica)', part.name_en = 'Pequena suíte, W064: IV. Fugato (all''antica)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 10816 AND p.composer_id = 105 AND part.part_key = 'musicbrainz:3579f139-5e75-4cbf-9807-2040aa279a77' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:3579f139-5e75-4cbf-9807-2040aa279a77', 4, 'IV', 'Fugato (all''antica)', 'Pequena suíte, W064: IV. Fugato (all''antica)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 10816 AND p.composer_id = 105
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:3579f139-5e75-4cbf-9807-2040aa279a77'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 5, part.movement_number = 'V',
    part.name_ko = 'Melodia', part.name_en = 'Pequena suíte, W064: V. Melodia',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 10816 AND p.composer_id = 105 AND part.part_key = 'musicbrainz:b7c1c1ce-e5ee-4af6-8d33-b8ba8c6cc6b4' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:b7c1c1ce-e5ee-4af6-8d33-b8ba8c6cc6b4', 5, 'V', 'Melodia', 'Pequena suíte, W064: V. Melodia', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 10816 AND p.composer_id = 105
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:b7c1c1ce-e5ee-4af6-8d33-b8ba8c6cc6b4'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 6, part.movement_number = 'VI',
    part.name_ko = 'Gavotte-scherzo', part.name_en = 'Pequena suíte, W064: VI. Gavotte-scherzo',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 10816 AND p.composer_id = 105 AND part.part_key = 'musicbrainz:98ba150f-93fa-4189-b165-237522629646' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:98ba150f-93fa-4189-b165-237522629646', 6, 'VI', 'Gavotte-scherzo', 'Pequena suíte, W064: VI. Gavotte-scherzo', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 10816 AND p.composer_id = 105
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:98ba150f-93fa-4189-b165-237522629646'
);


-- W 048 Petizada

UPDATE pieces piece
SET piece.title = 'Petizada', piece.title_en = 'Petizada, W048',
    piece.type = 'album', piece.opus_number = 'W 048',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 7764 AND piece.composer_id = 105
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'A mão direita tem uma roseira', part.name_en = 'Petizada, W048: I. A mão direita tem uma roseira',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 7764 AND p.composer_id = 105 AND part.part_key = 'musicbrainz:08b9becc-2968-46bf-ad7f-29a3b497a761' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:08b9becc-2968-46bf-ad7f-29a3b497a761', 1, 'I', 'A mão direita tem uma roseira', 'Petizada, W048: I. A mão direita tem uma roseira', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 7764 AND p.composer_id = 105
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:08b9becc-2968-46bf-ad7f-29a3b497a761'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'Assim ninava mamã', part.name_en = 'Petizada, W048: II. Assim ninava mamã',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 7764 AND p.composer_id = 105 AND part.part_key = 'musicbrainz:5b199b96-27c7-4135-bd29-a257379eaee8' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:5b199b96-27c7-4135-bd29-a257379eaee8', 2, 'II', 'Assim ninava mamã', 'Petizada, W048: II. Assim ninava mamã', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 7764 AND p.composer_id = 105
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:5b199b96-27c7-4135-bd29-a257379eaee8'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = 'A pobrezinha sertaneja', part.name_en = 'Petizada, W048: III. A pobrezinha sertaneja',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 7764 AND p.composer_id = 105 AND part.part_key = 'musicbrainz:fc7d4216-3197-4b29-8bbd-408364f14332' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:fc7d4216-3197-4b29-8bbd-408364f14332', 3, 'III', 'A pobrezinha sertaneja', 'Petizada, W048: III. A pobrezinha sertaneja', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 7764 AND p.composer_id = 105
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:fc7d4216-3197-4b29-8bbd-408364f14332'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = 'IV',
    part.name_ko = 'Vestidinho branco', part.name_en = 'Petizada, W048: IV. Vestidinho branco',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 7764 AND p.composer_id = 105 AND part.part_key = 'musicbrainz:c80de15c-13a7-4f63-9f96-e462d0fe6a54' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:c80de15c-13a7-4f63-9f96-e462d0fe6a54', 4, 'IV', 'Vestidinho branco', 'Petizada, W048: IV. Vestidinho branco', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 7764 AND p.composer_id = 105
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:c80de15c-13a7-4f63-9f96-e462d0fe6a54'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 5, part.movement_number = 'V',
    part.name_ko = 'Sací', part.name_en = 'Petizada, W048: V. Sací',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 7764 AND p.composer_id = 105 AND part.part_key = 'musicbrainz:1da07254-084a-4ba9-b877-9519d7ac414d' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:1da07254-084a-4ba9-b877-9519d7ac414d', 5, 'V', 'Sací', 'Petizada, W048: V. Sací', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 7764 AND p.composer_id = 105
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:1da07254-084a-4ba9-b877-9519d7ac414d'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 6, part.movement_number = 'VI',
    part.name_ko = 'A historia da caipirinha', part.name_en = 'Petizada, W048: VI. A historia da caipirinha',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 7764 AND p.composer_id = 105 AND part.part_key = 'musicbrainz:d26d1dc5-a1e4-4ebb-9b2c-18edd5fd2e88' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:d26d1dc5-a1e4-4ebb-9b2c-18edd5fd2e88', 6, 'VI', 'A historia da caipirinha', 'Petizada, W048: VI. A historia da caipirinha', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 7764 AND p.composer_id = 105
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:d26d1dc5-a1e4-4ebb-9b2c-18edd5fd2e88'
);


-- Op. 25 피아노 3중주 1번

UPDATE pieces piece
SET piece.title = '피아노 3중주 1번', piece.title_en = 'Piano Trio no. 1, op. 25, W042',
    piece.type = 'album', piece.opus_number = 'Op. 25',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 10059 AND piece.composer_id = 105
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'Allegro non troppo', part.name_en = 'Piano Trio no. 1, op. 25, W042: I. Allegro non troppo',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 10059 AND p.composer_id = 105 AND part.part_key = 'musicbrainz:c49d8baa-8c47-4abb-ae5a-50e0648efaf4' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:c49d8baa-8c47-4abb-ae5a-50e0648efaf4', 1, 'I', 'Allegro non troppo', 'Piano Trio no. 1, op. 25, W042: I. Allegro non troppo', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 10059 AND p.composer_id = 105
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:c49d8baa-8c47-4abb-ae5a-50e0648efaf4'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'Andante sostenuto', part.name_en = 'Piano Trio no. 1, op. 25, W042: II. Andante sostenuto',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 10059 AND p.composer_id = 105 AND part.part_key = 'musicbrainz:f51aa0f3-62d2-41a8-a657-75f62ed0b5c2' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:f51aa0f3-62d2-41a8-a657-75f62ed0b5c2', 2, 'II', 'Andante sostenuto', 'Piano Trio no. 1, op. 25, W042: II. Andante sostenuto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 10059 AND p.composer_id = 105
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:f51aa0f3-62d2-41a8-a657-75f62ed0b5c2'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = 'Scherzo. Vivace', part.name_en = 'Piano Trio no. 1, op. 25, W042: III. Scherzo. Vivace',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 10059 AND p.composer_id = 105 AND part.part_key = 'musicbrainz:faf2fa0e-461d-4977-b14b-6842c7fa8db6' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:faf2fa0e-461d-4977-b14b-6842c7fa8db6', 3, 'III', 'Scherzo. Vivace', 'Piano Trio no. 1, op. 25, W042: III. Scherzo. Vivace', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 10059 AND p.composer_id = 105
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:faf2fa0e-461d-4977-b14b-6842c7fa8db6'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = 'IV',
    part.name_ko = 'Allegro non troppo e rondo final', part.name_en = 'Piano Trio no. 1, op. 25, W042: IV. Allegro non troppo e rondo final',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 10059 AND p.composer_id = 105 AND part.part_key = 'musicbrainz:e4a44da2-6082-4b2c-96ae-0ffc7f555b09' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:e4a44da2-6082-4b2c-96ae-0ffc7f555b09', 4, 'IV', 'Allegro non troppo e rondo final', 'Piano Trio no. 1, op. 25, W042: IV. Allegro non troppo e rondo final', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 10059 AND p.composer_id = 105
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:e4a44da2-6082-4b2c-96ae-0ffc7f555b09'
);


-- W 105 피아노 3중주 2번

UPDATE pieces piece
SET piece.title = '피아노 3중주 2번', piece.title_en = 'Piano Trio no. 2, W105',
    piece.type = 'album', piece.opus_number = 'W 105',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 9480 AND piece.composer_id = 105
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'Allegro moderato', part.name_en = 'Piano Trio no. 2, W105: I. Allegro moderato',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 9480 AND p.composer_id = 105 AND part.part_key = 'musicbrainz:38561042-bb22-4401-8107-708f9b00ae36' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:38561042-bb22-4401-8107-708f9b00ae36', 1, 'I', 'Allegro moderato', 'Piano Trio no. 2, W105: I. Allegro moderato', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 9480 AND p.composer_id = 105
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:38561042-bb22-4401-8107-708f9b00ae36'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'Berceuse-Barcarolla (Andante calmo)', part.name_en = 'Piano Trio no. 2, W105: II. Berceuse-Barcarolla (Andante calmo)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 9480 AND p.composer_id = 105 AND part.part_key = 'musicbrainz:535e619a-d66b-4b22-a731-dd19e24a40b3' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:535e619a-d66b-4b22-a731-dd19e24a40b3', 2, 'II', 'Berceuse-Barcarolla (Andante calmo)', 'Piano Trio no. 2, W105: II. Berceuse-Barcarolla (Andante calmo)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 9480 AND p.composer_id = 105
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:535e619a-d66b-4b22-a731-dd19e24a40b3'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = 'Scherzo (Allegro spiritoso vivace)', part.name_en = 'Piano Trio no. 2, W105: III. Scherzo (Allegro spiritoso vivace)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 9480 AND p.composer_id = 105 AND part.part_key = 'musicbrainz:c103ec43-09fc-4f25-9b8f-0177095c022b' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:c103ec43-09fc-4f25-9b8f-0177095c022b', 3, 'III', 'Scherzo (Allegro spiritoso vivace)', 'Piano Trio no. 2, W105: III. Scherzo (Allegro spiritoso vivace)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 9480 AND p.composer_id = 105
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:c103ec43-09fc-4f25-9b8f-0177095c022b'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = 'IV',
    part.name_ko = 'Final (Molto allegro)', part.name_en = 'Piano Trio no. 2, W105: IV. Final (Molto allegro)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 9480 AND p.composer_id = 105 AND part.part_key = 'musicbrainz:5b41572a-2d63-4019-b846-35acb49e267f' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:5b41572a-2d63-4019-b846-35acb49e267f', 4, 'IV', 'Final (Molto allegro)', 'Piano Trio no. 2, W105: IV. Final (Molto allegro)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 9480 AND p.composer_id = 105
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:5b41572a-2d63-4019-b846-35acb49e267f'
);


-- W 142 피아노 3중주 3번

UPDATE pieces piece
SET piece.title = '피아노 3중주 3번', piece.title_en = 'Piano Trio no. 3, W142',
    piece.type = 'album', piece.opus_number = 'W 142',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 8921 AND piece.composer_id = 105
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'Allegro con moto', part.name_en = 'Piano Trio no. 3, W142: I. Allegro con moto',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 8921 AND p.composer_id = 105 AND part.part_key = 'musicbrainz:88fd01f2-02b0-44a0-90f6-c556f35ad743' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:88fd01f2-02b0-44a0-90f6-c556f35ad743', 1, 'I', 'Allegro con moto', 'Piano Trio no. 3, W142: I. Allegro con moto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 8921 AND p.composer_id = 105
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:88fd01f2-02b0-44a0-90f6-c556f35ad743'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'Assai moderato', part.name_en = 'Piano Trio no. 3, W142: II. Assai moderato',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 8921 AND p.composer_id = 105 AND part.part_key = 'musicbrainz:b492269f-9b1e-4b25-9c82-ab03c04f37fa' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:b492269f-9b1e-4b25-9c82-ab03c04f37fa', 2, 'II', 'Assai moderato', 'Piano Trio no. 3, W142: II. Assai moderato', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 8921 AND p.composer_id = 105
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:b492269f-9b1e-4b25-9c82-ab03c04f37fa'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = 'Allegretto spirituoso', part.name_en = 'Piano Trio no. 3, W142: III. Allegretto spirituoso',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 8921 AND p.composer_id = 105 AND part.part_key = 'musicbrainz:a05cca09-e869-436a-a612-271e3846ac19' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:a05cca09-e869-436a-a612-271e3846ac19', 3, 'III', 'Allegretto spirituoso', 'Piano Trio no. 3, W142: III. Allegretto spirituoso', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 8921 AND p.composer_id = 105
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:a05cca09-e869-436a-a612-271e3846ac19'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = 'IV',
    part.name_ko = 'Finale. Allegro animato', part.name_en = 'Piano Trio no. 3, W142: IV. Finale. Allegro animato',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 8921 AND p.composer_id = 105 AND part.part_key = 'musicbrainz:85343349-d1f6-435c-8f82-af951b6cc783' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:85343349-d1f6-435c-8f82-af951b6cc783', 4, 'IV', 'Finale. Allegro animato', 'Piano Trio no. 3, W142: IV. Finale. Allegro animato', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 8921 AND p.composer_id = 105
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:85343349-d1f6-435c-8f82-af951b6cc783'
);


-- W 434 Poema singelo

UPDATE pieces piece
SET piece.title = 'Poema singelo', piece.title_en = 'Poema singelo, W434',
    piece.type = 'song', piece.opus_number = 'W 434',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 8259 AND piece.composer_id = 105
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None 가곡 <Prelude / A Wedding Song>

UPDATE pieces piece
SET piece.title = '가곡 <Prelude / A Wedding Song>', piece.title_en = 'Prelude / A Wedding Song',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 7681 AND piece.composer_id = 105
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None 가곡 <Prelude Nº 5>

UPDATE pieces piece
SET piece.title = '가곡 <Prelude Nº 5>', piece.title_en = 'Prelude Nº 5',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 8143 AND piece.composer_id = 105
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- Op. 20 Prelúdio nº 2

UPDATE pieces piece
SET piece.title = 'Prelúdio nº 2', piece.title_en = 'Prelúdio nº 2, op. 20, W065',
    piece.type = 'song', piece.opus_number = 'Op. 20',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 8066 AND piece.composer_id = 105
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- W 140 Prole do bebê nº 1 W 140

UPDATE pieces piece
SET piece.title = 'Prole do bebê nº 1 W 140', piece.title_en = 'Prole do bebê nº 1, W140',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = 'W', piece.catalogue_number = '140',
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 10372 AND piece.composer_id = 105
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'Branquinha (A boneca de louça)', part.name_en = 'Prole do bebê nº 1, W140, nº 1: Branquinha (A boneca de louça)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 10372 AND p.composer_id = 105 AND part.part_key = 'musicbrainz:f3a98c11-082e-378a-801f-82d49203971d' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:f3a98c11-082e-378a-801f-82d49203971d', 1, NULL, 'Branquinha (A boneca de louça)', 'Prole do bebê nº 1, W140, nº 1: Branquinha (A boneca de louça)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 10372 AND p.composer_id = 105
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:f3a98c11-082e-378a-801f-82d49203971d'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'Moreninha (A boneca de massa)', part.name_en = 'Prole do bebê nº 1, W140, nº 2: Moreninha (A boneca de massa)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 10372 AND p.composer_id = 105 AND part.part_key = 'musicbrainz:e2df2392-2ee8-313b-90d9-46258f1bbea5' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:e2df2392-2ee8-313b-90d9-46258f1bbea5', 2, NULL, 'Moreninha (A boneca de massa)', 'Prole do bebê nº 1, W140, nº 2: Moreninha (A boneca de massa)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 10372 AND p.composer_id = 105
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:e2df2392-2ee8-313b-90d9-46258f1bbea5'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = NULL,
    part.name_ko = 'Caboclinha (A boneca de barro)', part.name_en = 'Prole do bebê nº 1, W140, nº 3: Caboclinha (A boneca de barro)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 10372 AND p.composer_id = 105 AND part.part_key = 'musicbrainz:57343a0d-10dd-33df-b814-8affc8069a07' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:57343a0d-10dd-33df-b814-8affc8069a07', 3, NULL, 'Caboclinha (A boneca de barro)', 'Prole do bebê nº 1, W140, nº 3: Caboclinha (A boneca de barro)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 10372 AND p.composer_id = 105
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:57343a0d-10dd-33df-b814-8affc8069a07'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = NULL,
    part.name_ko = 'Mulatinha (A boneca de borracha)', part.name_en = 'Prole do bebê nº 1, W140, nº 4: Mulatinha (A boneca de borracha)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 10372 AND p.composer_id = 105 AND part.part_key = 'musicbrainz:8691e245-7d3d-3223-b71b-6d82dfc1e84c' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:8691e245-7d3d-3223-b71b-6d82dfc1e84c', 4, NULL, 'Mulatinha (A boneca de borracha)', 'Prole do bebê nº 1, W140, nº 4: Mulatinha (A boneca de borracha)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 10372 AND p.composer_id = 105
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:8691e245-7d3d-3223-b71b-6d82dfc1e84c'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 5, part.movement_number = NULL,
    part.name_ko = 'Negrinha (A boneca de pau)', part.name_en = 'Prole do bebê nº 1, W140, nº 5: Negrinha (A boneca de pau)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 10372 AND p.composer_id = 105 AND part.part_key = 'musicbrainz:65dcbfeb-7a86-3993-824e-58847bebe802' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:65dcbfeb-7a86-3993-824e-58847bebe802', 5, NULL, 'Negrinha (A boneca de pau)', 'Prole do bebê nº 1, W140, nº 5: Negrinha (A boneca de pau)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 10372 AND p.composer_id = 105
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:65dcbfeb-7a86-3993-824e-58847bebe802'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 6, part.movement_number = NULL,
    part.name_ko = 'A pobrezinha (A boneca de trapo)', part.name_en = 'Prole do bebê nº 1, W140, nº 6: A pobrezinha (A boneca de trapo)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 10372 AND p.composer_id = 105 AND part.part_key = 'musicbrainz:df9252eb-7493-35ca-8bda-fbd0553b0b02' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:df9252eb-7493-35ca-8bda-fbd0553b0b02', 6, NULL, 'A pobrezinha (A boneca de trapo)', 'Prole do bebê nº 1, W140, nº 6: A pobrezinha (A boneca de trapo)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 10372 AND p.composer_id = 105
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:df9252eb-7493-35ca-8bda-fbd0553b0b02'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 7, part.movement_number = NULL,
    part.name_ko = 'O polichinelo', part.name_en = 'Prole do bebê nº 1, W140, nº 7: O polichinelo',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 10372 AND p.composer_id = 105 AND part.part_key = 'musicbrainz:abbaa7e7-016d-323d-8ad3-fdc49db86781' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:abbaa7e7-016d-323d-8ad3-fdc49db86781', 7, NULL, 'O polichinelo', 'Prole do bebê nº 1, W140, nº 7: O polichinelo', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 10372 AND p.composer_id = 105
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:abbaa7e7-016d-323d-8ad3-fdc49db86781'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 8, part.movement_number = NULL,
    part.name_ko = 'A bruxa (A boneca de pano)', part.name_en = 'Prole do bebê nº 1, W140, nº 8: A bruxa (A boneca de pano)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 10372 AND p.composer_id = 105 AND part.part_key = 'musicbrainz:261627de-250d-3f10-a77b-dd77f6cc4ff2' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:261627de-250d-3f10-a77b-dd77f6cc4ff2', 8, NULL, 'A bruxa (A boneca de pano)', 'Prole do bebê nº 1, W140, nº 8: A bruxa (A boneca de pano)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 10372 AND p.composer_id = 105
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:261627de-250d-3f10-a77b-dd77f6cc4ff2'
);


-- W 180 Prole do bebê nº 2 W 180

UPDATE pieces piece
SET piece.title = 'Prole do bebê nº 2 W 180', piece.title_en = 'Prole do bebê nº 2, W180',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = 'W', piece.catalogue_number = '180',
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 8417 AND piece.composer_id = 105
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'A baratinha de papel', part.name_en = 'Prole do bebê nº 2, W180, nº 1: A baratinha de papel',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 8417 AND p.composer_id = 105 AND part.part_key = 'musicbrainz:853e59d7-f267-3d42-a2a9-46eebab24cef' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:853e59d7-f267-3d42-a2a9-46eebab24cef', 1, NULL, 'A baratinha de papel', 'Prole do bebê nº 2, W180, nº 1: A baratinha de papel', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 8417 AND p.composer_id = 105
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:853e59d7-f267-3d42-a2a9-46eebab24cef'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'O gatinho de papelão', part.name_en = 'Prole do bebê nº 2, W180, nº 2: O gatinho de papelão',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 8417 AND p.composer_id = 105 AND part.part_key = 'musicbrainz:f2873cc9-0fb0-3f92-8248-932a1c150fb5' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:f2873cc9-0fb0-3f92-8248-932a1c150fb5', 2, NULL, 'O gatinho de papelão', 'Prole do bebê nº 2, W180, nº 2: O gatinho de papelão', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 8417 AND p.composer_id = 105
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:f2873cc9-0fb0-3f92-8248-932a1c150fb5'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = NULL,
    part.name_ko = 'O camundongo de massa', part.name_en = 'Prole do bebê nº 2, W180, nº 3: O camundongo de massa',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 8417 AND p.composer_id = 105 AND part.part_key = 'musicbrainz:1ff52455-0f43-3a44-96cc-15c406164309' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:1ff52455-0f43-3a44-96cc-15c406164309', 3, NULL, 'O camundongo de massa', 'Prole do bebê nº 2, W180, nº 3: O camundongo de massa', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 8417 AND p.composer_id = 105
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:1ff52455-0f43-3a44-96cc-15c406164309'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = NULL,
    part.name_ko = 'O cachorrinho de borracha', part.name_en = 'Prole do bebê nº 2, W180, nº 4: O cachorrinho de borracha',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 8417 AND p.composer_id = 105 AND part.part_key = 'musicbrainz:98b6ea02-8da6-3e91-a572-971857ffa273' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:98b6ea02-8da6-3e91-a572-971857ffa273', 4, NULL, 'O cachorrinho de borracha', 'Prole do bebê nº 2, W180, nº 4: O cachorrinho de borracha', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 8417 AND p.composer_id = 105
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:98b6ea02-8da6-3e91-a572-971857ffa273'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 5, part.movement_number = NULL,
    part.name_ko = 'O cavalinho de páu', part.name_en = 'Prole do bebê nº 2, W180, nº 5: O cavalinho de páu',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 8417 AND p.composer_id = 105 AND part.part_key = 'musicbrainz:4fc1d215-009a-366b-9b0f-1fc424058944' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:4fc1d215-009a-366b-9b0f-1fc424058944', 5, NULL, 'O cavalinho de páu', 'Prole do bebê nº 2, W180, nº 5: O cavalinho de páu', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 8417 AND p.composer_id = 105
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:4fc1d215-009a-366b-9b0f-1fc424058944'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 6, part.movement_number = NULL,
    part.name_ko = 'O boizinho de chumbo', part.name_en = 'Prole do bebê nº 2, W180, nº 6: O boizinho de chumbo',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 8417 AND p.composer_id = 105 AND part.part_key = 'musicbrainz:95a8870e-29c4-3054-b978-a5d7f1cd1dc1' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:95a8870e-29c4-3054-b978-a5d7f1cd1dc1', 6, NULL, 'O boizinho de chumbo', 'Prole do bebê nº 2, W180, nº 6: O boizinho de chumbo', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 8417 AND p.composer_id = 105
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:95a8870e-29c4-3054-b978-a5d7f1cd1dc1'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 7, part.movement_number = NULL,
    part.name_ko = 'O passarinho de pano', part.name_en = 'Prole do bebê nº 2, W180, nº 7: O passarinho de pano',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 8417 AND p.composer_id = 105 AND part.part_key = 'musicbrainz:b470e6df-c9fa-3c26-b853-27e8049644b8' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:b470e6df-c9fa-3c26-b853-27e8049644b8', 7, NULL, 'O passarinho de pano', 'Prole do bebê nº 2, W180, nº 7: O passarinho de pano', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 8417 AND p.composer_id = 105
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:b470e6df-c9fa-3c26-b853-27e8049644b8'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 8, part.movement_number = NULL,
    part.name_ko = 'O ursinho de algodão', part.name_en = 'Prole do bebê nº 2, W180, nº 8: O ursinho de algodão',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 8417 AND p.composer_id = 105 AND part.part_key = 'musicbrainz:4d501f9f-cb4a-3e18-a5bc-b8aedfa5abd8' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:4d501f9f-cb4a-3e18-a5bc-b8aedfa5abd8', 8, NULL, 'O ursinho de algodão', 'Prole do bebê nº 2, W180, nº 8: O ursinho de algodão', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 8417 AND p.composer_id = 105
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:4d501f9f-cb4a-3e18-a5bc-b8aedfa5abd8'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 9, part.movement_number = NULL,
    part.name_ko = 'O lobinho de vidro', part.name_en = 'Prole do bebê nº 2, W180, nº 9: O lobinho de vidro',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 8417 AND p.composer_id = 105 AND part.part_key = 'musicbrainz:92d6423b-1b40-3e21-a321-009fe015d13b' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:92d6423b-1b40-3e21-a321-009fe015d13b', 9, NULL, 'O lobinho de vidro', 'Prole do bebê nº 2, W180, nº 9: O lobinho de vidro', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 8417 AND p.composer_id = 105
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:92d6423b-1b40-3e21-a321-009fe015d13b'
);


-- None Préces sem palavras

UPDATE pieces piece
SET piece.title = 'Préces sem palavras', piece.title_en = 'Préces sem palavras',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 10494 AND piece.composer_id = 105
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- W 230 Quarteto para instrumentos de sopro

UPDATE pieces piece
SET piece.title = 'Quarteto para instrumentos de sopro', piece.title_en = 'Quarteto para instrumentos de sopro, W230',
    piece.type = 'album', piece.opus_number = 'W 230',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 9230 AND piece.composer_id = 105
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'Allegro non troppo', part.name_en = 'Quarteto para instrumentos de sopro, W230: I. Allegro non troppo',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 9230 AND p.composer_id = 105 AND part.part_key = 'musicbrainz:56fafb55-fa47-4aac-a64b-a634838db506' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:56fafb55-fa47-4aac-a64b-a634838db506', 1, 'I', 'Allegro non troppo', 'Quarteto para instrumentos de sopro, W230: I. Allegro non troppo', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 9230 AND p.composer_id = 105
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:56fafb55-fa47-4aac-a64b-a634838db506'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'Lento', part.name_en = 'Quarteto para instrumentos de sopro, W230: II. Lento',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 9230 AND p.composer_id = 105 AND part.part_key = 'musicbrainz:f0d9fbe2-da60-42cc-8237-60b48fcc007b' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:f0d9fbe2-da60-42cc-8237-60b48fcc007b', 2, 'II', 'Lento', 'Quarteto para instrumentos de sopro, W230: II. Lento', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 9230 AND p.composer_id = 105
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:f0d9fbe2-da60-42cc-8237-60b48fcc007b'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = 'Allegro molto vivace', part.name_en = 'Quarteto para instrumentos de sopro, W230: III. Allegro molto vivace',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 9230 AND p.composer_id = 105 AND part.part_key = 'musicbrainz:fd4e9082-8d37-4cde-83cc-82fa51cb2b10' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:fd4e9082-8d37-4cde-83cc-82fa51cb2b10', 3, 'III', 'Allegro molto vivace', 'Quarteto para instrumentos de sopro, W230: III. Allegro molto vivace', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 9230 AND p.composer_id = 105
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:fd4e9082-8d37-4cde-83cc-82fa51cb2b10'
);


-- W 181 Quarteto simbólico

UPDATE pieces piece
SET piece.title = 'Quarteto simbólico', piece.title_en = 'Quarteto simbólico, W181',
    piece.type = 'album', piece.opus_number = 'W 181',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 10782 AND piece.composer_id = 105
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'Allegro con moto', part.name_en = 'Quarteto simbólico, W181: I. Allegro con moto',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 10782 AND p.composer_id = 105 AND part.part_key = 'musicbrainz:391afe55-cc3d-431b-9cbe-243de66dfb6e' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:391afe55-cc3d-431b-9cbe-243de66dfb6e', 1, 'I', 'Allegro con moto', 'Quarteto simbólico, W181: I. Allegro con moto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 10782 AND p.composer_id = 105
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:391afe55-cc3d-431b-9cbe-243de66dfb6e'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'Andantino', part.name_en = 'Quarteto simbólico, W181: II. Andantino',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 10782 AND p.composer_id = 105 AND part.part_key = 'musicbrainz:c844e521-e491-4dd8-a710-e9ca412df870' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:c844e521-e491-4dd8-a710-e9ca412df870', 2, 'II', 'Andantino', 'Quarteto simbólico, W181: II. Andantino', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 10782 AND p.composer_id = 105
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:c844e521-e491-4dd8-a710-e9ca412df870'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = 'Allegro deciso', part.name_en = 'Quarteto simbólico, W181: III. Allegro deciso',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 10782 AND p.composer_id = 105 AND part.part_key = 'musicbrainz:8a399a07-56e2-40b9-9082-5e32bbe1e8c7' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:8a399a07-56e2-40b9-9082-5e32bbe1e8c7', 3, 'III', 'Allegro deciso', 'Quarteto simbólico, W181: III. Allegro deciso', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 10782 AND p.composer_id = 105
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:8a399a07-56e2-40b9-9082-5e32bbe1e8c7'
);


-- W 231 Quinteto em forma de chôros

UPDATE pieces piece
SET piece.title = 'Quinteto em forma de chôros', piece.title_en = 'Quinteto em forma de chôros, W231',
    piece.type = 'song', piece.opus_number = 'W 231',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 10106 AND piece.composer_id = 105
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- W 538 Quinteto instrumental

UPDATE pieces piece
SET piece.title = 'Quinteto instrumental', piece.title_en = 'Quinteto instrumental, W538',
    piece.type = 'album', piece.opus_number = 'W 538',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 10776 AND piece.composer_id = 105
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'Allegro non troppo', part.name_en = 'Quinteto instrumental, W538: I. Allegro non troppo',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 10776 AND p.composer_id = 105 AND part.part_key = 'musicbrainz:3f801a54-0248-42bc-9d9b-5197abc3b781' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:3f801a54-0248-42bc-9d9b-5197abc3b781', 1, 'I', 'Allegro non troppo', 'Quinteto instrumental, W538: I. Allegro non troppo', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 10776 AND p.composer_id = 105
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:3f801a54-0248-42bc-9d9b-5197abc3b781'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'Lento', part.name_en = 'Quinteto instrumental, W538: II. Lento',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 10776 AND p.composer_id = 105 AND part.part_key = 'musicbrainz:bba87c3d-98ad-45ed-a0dc-8ee94d95b820' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:bba87c3d-98ad-45ed-a0dc-8ee94d95b820', 2, 'II', 'Lento', 'Quinteto instrumental, W538: II. Lento', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 10776 AND p.composer_id = 105
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:bba87c3d-98ad-45ed-a0dc-8ee94d95b820'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = 'Allegro poco moderato', part.name_en = 'Quinteto instrumental, W538: III. Allegro poco moderato',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 10776 AND p.composer_id = 105 AND part.part_key = 'musicbrainz:313408e1-9b83-4206-9b12-967cad1fa9c0' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:313408e1-9b83-4206-9b12-967cad1fa9c0', 3, 'III', 'Allegro poco moderato', 'Quinteto instrumental, W538: III. Allegro poco moderato', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 10776 AND p.composer_id = 105
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:313408e1-9b83-4206-9b12-967cad1fa9c0'
);


-- W 184 Rudepoêma

UPDATE pieces piece
SET piece.title = 'Rudepoêma', piece.title_en = 'Rudepoêma, W184',
    piece.type = 'song', piece.opus_number = 'W 184',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 7770 AND piece.composer_id = 105
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None 발레 <Rudá>

UPDATE pieces piece
SET piece.title = '발레 <Rudá>', piece.title_en = 'Rudá',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 8157 AND piece.composer_id = 105
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'III',
    part.name_ko = 'Os incas', part.name_en = 'Rudá: III. Os incas',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 8157 AND p.composer_id = 105 AND part.part_key = 'musicbrainz:06268781-a14d-4b7a-afb6-af394c6a7d5b' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:06268781-a14d-4b7a-afb6-af394c6a7d5b', 1, 'III', 'Os incas', 'Rudá: III. Os incas', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 8157 AND p.composer_id = 105
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:06268781-a14d-4b7a-afb6-af394c6a7d5b'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'V',
    part.name_ko = 'La vittoria dell''amore nel tropico', part.name_en = 'Rudá: V. La vittoria dell''amore nel tropico',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 8157 AND p.composer_id = 105 AND part.part_key = 'musicbrainz:1d0ad2d1-69ea-4fce-8e89-c5dbf774b679' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:1d0ad2d1-69ea-4fce-8e89-c5dbf774b679', 2, 'V', 'La vittoria dell''amore nel tropico', 'Rudá: V. La vittoria dell''amore nel tropico', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 8157 AND p.composer_id = 105
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:1d0ad2d1-69ea-4fce-8e89-c5dbf774b679'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'VI',
    part.name_ko = 'Epílogo', part.name_en = 'Rudá: VI. Epílogo',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 8157 AND p.composer_id = 105 AND part.part_key = 'musicbrainz:3798e32d-e92d-4fcc-bd83-16bb38446ce7' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:3798e32d-e92d-4fcc-bd83-16bb38446ce7', 3, 'VI', 'Epílogo', 'Rudá: VI. Epílogo', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 8157 AND p.composer_id = 105
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:3798e32d-e92d-4fcc-bd83-16bb38446ce7'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = 'IV',
    part.name_ko = 'Os marajoaras', part.name_en = 'Rudá: IV. Os marajoaras',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 8157 AND p.composer_id = 105 AND part.part_key = 'musicbrainz:9827da38-5113-45e2-be39-e347597370a4' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:9827da38-5113-45e2-be39-e347597370a4', 4, 'IV', 'Os marajoaras', 'Rudá: IV. Os marajoaras', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 8157 AND p.composer_id = 105
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:9827da38-5113-45e2-be39-e347597370a4'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 5, part.movement_number = 'II',
    part.name_ko = 'Os aztecas', part.name_en = 'Rudá: II. Os aztecas',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 8157 AND p.composer_id = 105 AND part.part_key = 'musicbrainz:a19c94b8-279e-4742-ab09-9f264bec611c' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:a19c94b8-279e-4742-ab09-9f264bec611c', 5, 'II', 'Os aztecas', 'Rudá: II. Os aztecas', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 8157 AND p.composer_id = 105
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:a19c94b8-279e-4742-ab09-9f264bec611c'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 6, part.movement_number = 'I',
    part.name_ko = 'Os maias', part.name_en = 'Rudá: I. Os maias',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 8157 AND p.composer_id = 105 AND part.part_key = 'musicbrainz:ac87de9a-f16b-4b7b-a3f5-a92ebf0cf566' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:ac87de9a-f16b-4b7b-a3f5-a92ebf0cf566', 6, 'I', 'Os maias', 'Rudá: I. Os maias', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 8157 AND p.composer_id = 105
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:ac87de9a-f16b-4b7b-a3f5-a92ebf0cf566'
);


-- W 498 Samba clássico

UPDATE pieces piece
SET piece.title = 'Samba clássico', piece.title_en = 'Samba clássico, W498',
    piece.type = 'song', piece.opus_number = 'W 498',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 8187 AND piece.composer_id = 105
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- W 226 Saudades das selvas brasileiras

UPDATE pieces piece
SET piece.title = 'Saudades das selvas brasileiras', piece.title_en = 'Saudades das selvas brasileiras, W226',
    piece.type = 'album', piece.opus_number = 'W 226',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 11214 AND piece.composer_id = 105
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'Animado', part.name_en = 'Saudades das selvas brasileiras, W226: I. Animado',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11214 AND p.composer_id = 105 AND part.part_key = 'musicbrainz:5cf8a945-b905-3583-8923-a5c6ab4a146f' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:5cf8a945-b905-3583-8923-a5c6ab4a146f', 1, 'I', 'Animado', 'Saudades das selvas brasileiras, W226: I. Animado', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 11214 AND p.composer_id = 105
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:5cf8a945-b905-3583-8923-a5c6ab4a146f'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'Un poco animado', part.name_en = 'Saudades das selvas brasileiras, W226: II. Un poco animado',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11214 AND p.composer_id = 105 AND part.part_key = 'musicbrainz:a5c41101-7459-448e-92f5-cb89b497cb39' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:a5c41101-7459-448e-92f5-cb89b497cb39', 2, 'II', 'Un poco animado', 'Saudades das selvas brasileiras, W226: II. Un poco animado', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 11214 AND p.composer_id = 105
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:a5c41101-7459-448e-92f5-cb89b497cb39'
);


-- None 가곡 <Schottisch choro>

UPDATE pieces piece
SET piece.title = '가곡 <Schottisch choro>', piece.title_en = 'Schottisch choro',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 8464 AND piece.composer_id = 105
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- W 216 연가곡집 <Serestas> W 216

UPDATE pieces piece
SET piece.title = '연가곡집 <Serestas> W 216', piece.title_en = 'Serestas, W216',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = 'W', piece.catalogue_number = '216',
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 7981 AND piece.composer_id = 105
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'Pobre Cega', part.name_en = 'Serestas, W216: No. 1. Pobre Cega',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 7981 AND p.composer_id = 105 AND part.part_key = 'musicbrainz:38487614-813a-4e8c-a90a-04f4992bd301' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:38487614-813a-4e8c-a90a-04f4992bd301', 1, NULL, 'Pobre Cega', 'Serestas, W216: No. 1. Pobre Cega', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 7981 AND p.composer_id = 105
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:38487614-813a-4e8c-a90a-04f4992bd301'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'Anjo da guarda', part.name_en = 'Serestas, W216: No. 2. Anjo da guarda',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 7981 AND p.composer_id = 105 AND part.part_key = 'musicbrainz:c82c8b7f-dea8-400b-bf72-6a37294a1c5c' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:c82c8b7f-dea8-400b-bf72-6a37294a1c5c', 2, NULL, 'Anjo da guarda', 'Serestas, W216: No. 2. Anjo da guarda', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 7981 AND p.composer_id = 105
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:c82c8b7f-dea8-400b-bf72-6a37294a1c5c'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = NULL,
    part.name_ko = 'Canção da folha morta', part.name_en = 'Serestas, W216: No. 3. Canção da folha morta',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 7981 AND p.composer_id = 105 AND part.part_key = 'musicbrainz:e535be11-563a-40c4-9976-26e0274b2666' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:e535be11-563a-40c4-9976-26e0274b2666', 3, NULL, 'Canção da folha morta', 'Serestas, W216: No. 3. Canção da folha morta', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 7981 AND p.composer_id = 105
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:e535be11-563a-40c4-9976-26e0274b2666'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = NULL,
    part.name_ko = 'Saudade da minha vida', part.name_en = 'Serestas, W216: No. 4. Saudade da minha vida',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 7981 AND p.composer_id = 105 AND part.part_key = 'musicbrainz:fc70e69d-bf68-481c-ad30-601dc189b5cd' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:fc70e69d-bf68-481c-ad30-601dc189b5cd', 4, NULL, 'Saudade da minha vida', 'Serestas, W216: No. 4. Saudade da minha vida', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 7981 AND p.composer_id = 105
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:fc70e69d-bf68-481c-ad30-601dc189b5cd'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 5, part.movement_number = NULL,
    part.name_ko = 'Modinha', part.name_en = 'Serestas, W216: No. 5. Modinha',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 7981 AND p.composer_id = 105 AND part.part_key = 'musicbrainz:8f5a0cb2-cd7b-43ad-9c10-c8961398ed21' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:8f5a0cb2-cd7b-43ad-9c10-c8961398ed21', 5, NULL, 'Modinha', 'Serestas, W216: No. 5. Modinha', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 7981 AND p.composer_id = 105
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:8f5a0cb2-cd7b-43ad-9c10-c8961398ed21'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 6, part.movement_number = NULL,
    part.name_ko = 'Na paz do outono', part.name_en = 'Serestas, W216: No. 6. Na paz do outono',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 7981 AND p.composer_id = 105 AND part.part_key = 'musicbrainz:bc120739-6283-46d7-9287-a6ded7fd21b9' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:bc120739-6283-46d7-9287-a6ded7fd21b9', 6, NULL, 'Na paz do outono', 'Serestas, W216: No. 6. Na paz do outono', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 7981 AND p.composer_id = 105
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:bc120739-6283-46d7-9287-a6ded7fd21b9'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 7, part.movement_number = NULL,
    part.name_ko = 'Cantiga do viúvo', part.name_en = 'Serestas, W216: No. 7. Cantiga do viúvo',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 7981 AND p.composer_id = 105 AND part.part_key = 'musicbrainz:511af304-ae93-45f0-874e-6d49e837deba' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:511af304-ae93-45f0-874e-6d49e837deba', 7, NULL, 'Cantiga do viúvo', 'Serestas, W216: No. 7. Cantiga do viúvo', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 7981 AND p.composer_id = 105
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:511af304-ae93-45f0-874e-6d49e837deba'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 8, part.movement_number = NULL,
    part.name_ko = 'Canção do carreiro', part.name_en = 'Serestas, W216: No. 8. Canção do carreiro',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 7981 AND p.composer_id = 105 AND part.part_key = 'musicbrainz:99a57a88-0828-4a28-8849-102972d759c1' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:99a57a88-0828-4a28-8849-102972d759c1', 8, NULL, 'Canção do carreiro', 'Serestas, W216: No. 8. Canção do carreiro', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 7981 AND p.composer_id = 105
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:99a57a88-0828-4a28-8849-102972d759c1'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 9, part.movement_number = NULL,
    part.name_ko = 'Abril', part.name_en = 'Serestas, W216: No. 9. Abril',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 7981 AND p.composer_id = 105 AND part.part_key = 'musicbrainz:dffb8aa5-a930-4e88-a720-0545986fc99e' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:dffb8aa5-a930-4e88-a720-0545986fc99e', 9, NULL, 'Abril', 'Serestas, W216: No. 9. Abril', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 7981 AND p.composer_id = 105
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:dffb8aa5-a930-4e88-a720-0545986fc99e'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 10, part.movement_number = NULL,
    part.name_ko = 'Desejo', part.name_en = 'Serestas, W216: No. 10. Desejo',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 7981 AND p.composer_id = 105 AND part.part_key = 'musicbrainz:34cb0769-6242-4864-a385-15b927c22ce3' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:34cb0769-6242-4864-a385-15b927c22ce3', 10, NULL, 'Desejo', 'Serestas, W216: No. 10. Desejo', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 7981 AND p.composer_id = 105
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:34cb0769-6242-4864-a385-15b927c22ce3'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 11, part.movement_number = NULL,
    part.name_ko = 'Redondilha', part.name_en = 'Serestas, W216: No. 11. Redondilha',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 7981 AND p.composer_id = 105 AND part.part_key = 'musicbrainz:9b7716ba-9792-478f-85e2-cddedcc66f3f' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:9b7716ba-9792-478f-85e2-cddedcc66f3f', 11, NULL, 'Redondilha', 'Serestas, W216: No. 11. Redondilha', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 7981 AND p.composer_id = 105
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:9b7716ba-9792-478f-85e2-cddedcc66f3f'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 12, part.movement_number = NULL,
    part.name_ko = 'Realejo', part.name_en = 'Serestas, W216: No. 12. Realejo',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 7981 AND p.composer_id = 105 AND part.part_key = 'musicbrainz:22129727-8e94-4840-bd4f-359b7ce664da' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:22129727-8e94-4840-bd4f-359b7ce664da', 12, NULL, 'Realejo', 'Serestas, W216: No. 12. Realejo', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 7981 AND p.composer_id = 105
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:22129727-8e94-4840-bd4f-359b7ce664da'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 13, part.movement_number = NULL,
    part.name_ko = 'Vôo', part.name_en = 'Serestas, W216: No. 13. Vôo',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 7981 AND p.composer_id = 105 AND part.part_key = 'musicbrainz:aae1aeb2-3d7b-41f5-bf40-67ddef090421' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:aae1aeb2-3d7b-41f5-bf40-67ddef090421', 13, NULL, 'Vôo', 'Serestas, W216: No. 13. Vôo', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 7981 AND p.composer_id = 105
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:aae1aeb2-3d7b-41f5-bf40-67ddef090421'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 14, part.movement_number = NULL,
    part.name_ko = 'Serenata', part.name_en = 'Serestas, W216: No. 14. Serenata',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 7981 AND p.composer_id = 105 AND part.part_key = 'musicbrainz:89208f9f-53fa-4ae6-a2e1-4b4d5a4f9ea6' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:89208f9f-53fa-4ae6-a2e1-4b4d5a4f9ea6', 14, NULL, 'Serenata', 'Serestas, W216: No. 14. Serenata', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 7981 AND p.composer_id = 105
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:89208f9f-53fa-4ae6-a2e1-4b4d5a4f9ea6'
);


-- W 131 Sexteto místico

UPDATE pieces piece
SET piece.title = 'Sexteto místico', piece.title_en = 'Sexteto místico, W131',
    piece.type = 'song', piece.opus_number = 'W 131',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 8580 AND piece.composer_id = 105
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- W 134 Simples coletânea

UPDATE pieces piece
SET piece.title = 'Simples coletânea', piece.title_en = 'Simples coletânea, W134',
    piece.type = 'album', piece.opus_number = 'W 134',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 8519 AND piece.composer_id = 105
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'Valsa mística', part.name_en = 'Simples coletânea, W134: I. Valsa mística',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 8519 AND p.composer_id = 105 AND part.part_key = 'musicbrainz:dcd729dc-68cd-4c26-b870-82cb06f07aff' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:dcd729dc-68cd-4c26-b870-82cb06f07aff', 1, 'I', 'Valsa mística', 'Simples coletânea, W134: I. Valsa mística', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 8519 AND p.composer_id = 105
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:dcd729dc-68cd-4c26-b870-82cb06f07aff'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'Num berço encantado', part.name_en = 'Simples coletânea, W134: II. Num berço encantado',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 8519 AND p.composer_id = 105 AND part.part_key = 'musicbrainz:ab4ec2e1-9ff7-4e1a-96a9-0b0d3c9dfb58' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:ab4ec2e1-9ff7-4e1a-96a9-0b0d3c9dfb58', 2, 'II', 'Num berço encantado', 'Simples coletânea, W134: II. Num berço encantado', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 8519 AND p.composer_id = 105
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:ab4ec2e1-9ff7-4e1a-96a9-0b0d3c9dfb58'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = 'Rodante', part.name_en = 'Simples coletânea, W134: III. Rodante',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 8519 AND p.composer_id = 105 AND part.part_key = 'musicbrainz:a13661ef-7b1e-42e1-baf4-18f4c8e2c336' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:a13661ef-7b1e-42e1-baf4-18f4c8e2c336', 3, 'III', 'Rodante', 'Simples coletânea, W134: III. Rodante', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 8519 AND p.composer_id = 105
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:a13661ef-7b1e-42e1-baf4-18f4c8e2c336'
);


-- W 040 Simples

UPDATE pieces piece
SET piece.title = 'Simples', piece.title_en = 'Simples, W040',
    piece.type = 'song', piece.opus_number = 'W 040',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 10261 AND piece.composer_id = 105
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- W 115 신포니에타 1번 "Em memória de Mozart"

UPDATE pieces piece
SET piece.title = '신포니에타 1번 "Em memória de Mozart"', piece.title_en = 'Sinfonietta no. 1 "Em memória de Mozart", W115',
    piece.type = 'album', piece.opus_number = 'W 115',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 10860 AND piece.composer_id = 105
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'Allegro giusto', part.name_en = 'Sinfonietta no. 1 "Em memória de Mozart", W115: I. Allegro giusto',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 10860 AND p.composer_id = 105 AND part.part_key = 'musicbrainz:7c496fb7-3b0a-4158-b560-60992bd888e9' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:7c496fb7-3b0a-4158-b560-60992bd888e9', 1, 'I', 'Allegro giusto', 'Sinfonietta no. 1 "Em memória de Mozart", W115: I. Allegro giusto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 10860 AND p.composer_id = 105
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:7c496fb7-3b0a-4158-b560-60992bd888e9'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'Andante non troppo', part.name_en = 'Sinfonietta no. 1 "Em memória de Mozart", W115: II. Andante non troppo',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 10860 AND p.composer_id = 105 AND part.part_key = 'musicbrainz:9c6152f7-8ec5-489d-bdd3-83fc43251ddb' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:9c6152f7-8ec5-489d-bdd3-83fc43251ddb', 2, 'II', 'Andante non troppo', 'Sinfonietta no. 1 "Em memória de Mozart", W115: II. Andante non troppo', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 10860 AND p.composer_id = 105
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:9c6152f7-8ec5-489d-bdd3-83fc43251ddb'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = 'Andantino', part.name_en = 'Sinfonietta no. 1 "Em memória de Mozart", W115: III. Andantino',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 10860 AND p.composer_id = 105 AND part.part_key = 'musicbrainz:d3631be4-45da-4740-a80c-7983a41d1aee' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:d3631be4-45da-4740-a80c-7983a41d1aee', 3, 'III', 'Andantino', 'Sinfonietta no. 1 "Em memória de Mozart", W115: III. Andantino', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 10860 AND p.composer_id = 105
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:d3631be4-45da-4740-a80c-7983a41d1aee'
);


-- W 459 Solfejos, 2.º volume W 459

UPDATE pieces piece
SET piece.title = 'Solfejos, 2.º volume W 459', piece.title_en = 'Solfejos, 2.º volume, W459',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = 'W', piece.catalogue_number = '459',
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 9996 AND piece.composer_id = 105
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'Fuga IV sobre um tema de caráter popular brasileiro', part.name_en = 'Fuga IV sobre um tema de caráter popular brasileiro',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 9996 AND p.composer_id = 105 AND part.part_key = 'musicbrainz:1e8d7a3d-a6d1-41c5-b103-ed8fb9fcc355' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:1e8d7a3d-a6d1-41c5-b103-ed8fb9fcc355', 1, NULL, 'Fuga IV sobre um tema de caráter popular brasileiro', 'Fuga IV sobre um tema de caráter popular brasileiro', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 9996 AND p.composer_id = 105
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:1e8d7a3d-a6d1-41c5-b103-ed8fb9fcc355'
);


-- Op. 29 Sonata fantasia no. 2

UPDATE pieces piece
SET piece.title = 'Sonata fantasia no. 2', piece.title_en = 'Sonata fantasia no. 2, op. 29, W083',
    piece.type = 'album', piece.opus_number = 'Op. 29',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 8790 AND piece.composer_id = 105
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'Allegro non troppo', part.name_en = 'Sonata fantasia no. 2, op. 29, W083: I. Allegro non troppo',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 8790 AND p.composer_id = 105 AND part.part_key = 'musicbrainz:4a7e3807-1977-42ec-bbd6-541d6e2d46f4' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:4a7e3807-1977-42ec-bbd6-541d6e2d46f4', 1, 'I', 'Allegro non troppo', 'Sonata fantasia no. 2, op. 29, W083: I. Allegro non troppo', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 8790 AND p.composer_id = 105
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:4a7e3807-1977-42ec-bbd6-541d6e2d46f4'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'Largo – Moderato', part.name_en = 'Sonata fantasia no. 2, op. 29, W083: II. Largo – Moderato',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 8790 AND p.composer_id = 105 AND part.part_key = 'musicbrainz:f6f58e3d-f4a9-4f36-8297-c14cb92c024a' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:f6f58e3d-f4a9-4f36-8297-c14cb92c024a', 2, 'II', 'Largo – Moderato', 'Sonata fantasia no. 2, op. 29, W083: II. Largo – Moderato', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 8790 AND p.composer_id = 105
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:f6f58e3d-f4a9-4f36-8297-c14cb92c024a'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = 'Rondo. Allegro final', part.name_en = 'Sonata fantasia no. 2, op. 29, W083: III. Rondo. Allegro final',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 8790 AND p.composer_id = 105 AND part.part_key = 'musicbrainz:e175d94c-3024-47b2-8791-4ccb002607df' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:e175d94c-3024-47b2-8791-4ccb002607df', 3, 'III', 'Rondo. Allegro final', 'Sonata fantasia no. 2, op. 29, W083: III. Rondo. Allegro final', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 8790 AND p.composer_id = 105
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:e175d94c-3024-47b2-8791-4ccb002607df'
);


-- W 051 Sonate-fantaisie no. 1 "Désespérance"

UPDATE pieces piece
SET piece.title = 'Sonate-fantaisie no. 1 "Désespérance"', piece.title_en = 'Sonate-fantaisie no. 1 "Désespérance", W051',
    piece.type = 'song', piece.opus_number = 'W 051',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 7935 AND piece.composer_id = 105
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- Op. 14 Sonhar

UPDATE pieces piece
SET piece.title = 'Sonhar', piece.title_en = 'Sonhar, op. 14, W084',
    piece.type = 'song', piece.opus_number = 'Op. 14',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 8520 AND piece.composer_id = 105
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- Op. 14 Sonhar Op. 14

UPDATE pieces piece
SET piece.title = 'Sonhar Op. 14', piece.title_en = 'Sonhar, op. 14, W086',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = 'Op.', piece.catalogue_number = '14',
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 10341 AND piece.composer_id = 105
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- W 481 현악 4중주 11번

UPDATE pieces piece
SET piece.title = '현악 4중주 11번', piece.title_en = 'String Quartet No. 11, W481',
    piece.type = 'album', piece.opus_number = 'W 481',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 8670 AND piece.composer_id = 105
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'Allegro non troppo', part.name_en = 'String Quartet No. 11, W481: I. Allegro non troppo',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 8670 AND p.composer_id = 105 AND part.part_key = 'musicbrainz:fc4184ce-191f-4890-b5d2-ad02995fc56f' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:fc4184ce-191f-4890-b5d2-ad02995fc56f', 1, 'I', 'Allegro non troppo', 'String Quartet No. 11, W481: I. Allegro non troppo', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 8670 AND p.composer_id = 105
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:fc4184ce-191f-4890-b5d2-ad02995fc56f'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'Scherzo vivace', part.name_en = 'String Quartet No. 11, W481: II. Scherzo vivace',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 8670 AND p.composer_id = 105 AND part.part_key = 'musicbrainz:cf54e342-37d6-4aac-8706-4216bd1982b0' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:cf54e342-37d6-4aac-8706-4216bd1982b0', 2, 'II', 'Scherzo vivace', 'String Quartet No. 11, W481: II. Scherzo vivace', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 8670 AND p.composer_id = 105
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:cf54e342-37d6-4aac-8706-4216bd1982b0'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = 'Adagio', part.name_en = 'String Quartet No. 11, W481: III. Adagio',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 8670 AND p.composer_id = 105 AND part.part_key = 'musicbrainz:37c427a2-61f6-4eb3-9876-c10eb0d8894d' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:37c427a2-61f6-4eb3-9876-c10eb0d8894d', 3, 'III', 'Adagio', 'String Quartet No. 11, W481: III. Adagio', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 8670 AND p.composer_id = 105
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:37c427a2-61f6-4eb3-9876-c10eb0d8894d'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = 'IV',
    part.name_ko = 'Poco andantino (quasi allegro)', part.name_en = 'String Quartet No. 11, W481: IV. Poco andantino (quasi allegro)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 8670 AND p.composer_id = 105 AND part.part_key = 'musicbrainz:81e92b19-69e2-48db-b168-499ffe43c254' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:81e92b19-69e2-48db-b168-499ffe43c254', 4, 'IV', 'Poco andantino (quasi allegro)', 'String Quartet No. 11, W481: IV. Poco andantino (quasi allegro)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 8670 AND p.composer_id = 105
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:81e92b19-69e2-48db-b168-499ffe43c254'
);


-- W 503 현악 4중주 13번

UPDATE pieces piece
SET piece.title = '현악 4중주 13번', piece.title_en = 'String Quartet No. 13, W503',
    piece.type = 'album', piece.opus_number = 'W 503',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 7951 AND piece.composer_id = 105
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'IV',
    part.name_ko = 'Allegro vivace', part.name_en = 'String Quartet No. 13 (1951): IV. Allegro vivace',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 7951 AND p.composer_id = 105 AND part.part_key = 'musicbrainz:4f1d90bc-2662-46ef-a5ea-cbbdf602a5fe' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:4f1d90bc-2662-46ef-a5ea-cbbdf602a5fe', 1, 'IV', 'Allegro vivace', 'String Quartet No. 13 (1951): IV. Allegro vivace', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 7951 AND p.composer_id = 105
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:4f1d90bc-2662-46ef-a5ea-cbbdf602a5fe'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'I',
    part.name_ko = 'Allegro non troppo', part.name_en = 'String Quartet No. 13, W503: I. Allegro non troppo',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 7951 AND p.composer_id = 105 AND part.part_key = 'musicbrainz:61274932-b3f0-4545-b81a-4bf0d17f94cd' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:61274932-b3f0-4545-b81a-4bf0d17f94cd', 2, 'I', 'Allegro non troppo', 'String Quartet No. 13, W503: I. Allegro non troppo', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 7951 AND p.composer_id = 105
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:61274932-b3f0-4545-b81a-4bf0d17f94cd'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = 'Adagio', part.name_en = 'String Quartet No. 13, W503: III. Adagio',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 7951 AND p.composer_id = 105 AND part.part_key = 'musicbrainz:e11a816f-1cec-4d80-9256-e97800794678' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:e11a816f-1cec-4d80-9256-e97800794678', 3, 'III', 'Adagio', 'String Quartet No. 13, W503: III. Adagio', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 7951 AND p.composer_id = 105
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:e11a816f-1cec-4d80-9256-e97800794678'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = 'II',
    part.name_ko = 'Scherzo: Vivace', part.name_en = 'String Quartet No. 13, W503: II. Scherzo: Vivace',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 7951 AND p.composer_id = 105 AND part.part_key = 'musicbrainz:e63d3032-2ade-46f1-809a-6c96c9113e2e' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:e63d3032-2ade-46f1-809a-6c96c9113e2e', 4, 'II', 'Scherzo: Vivace', 'String Quartet No. 13, W503: II. Scherzo: Vivace', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 7951 AND p.composer_id = 105
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:e63d3032-2ade-46f1-809a-6c96c9113e2e'
);


-- None 현악 4중주 10번

UPDATE pieces piece
SET piece.title = '현악 4중주 10번', piece.title_en = 'String Quartet no. 10',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 10804 AND piece.composer_id = 105
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'Poco animato - Quasi allegro', part.name_en = 'String Quartet №10: I. Poco animato - Quasi allegro',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 10804 AND p.composer_id = 105 AND part.part_key = 'musicbrainz:bfd6f4fd-1a26-44a4-a198-154937f0ff17' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:bfd6f4fd-1a26-44a4-a198-154937f0ff17', 1, 'I', 'Poco animato - Quasi allegro', 'String Quartet №10: I. Poco animato - Quasi allegro', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 10804 AND p.composer_id = 105
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:bfd6f4fd-1a26-44a4-a198-154937f0ff17'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'Adagio - Piu mosso - Tempo I', part.name_en = 'String Quartet №10: II. Adagio - Piu mosso - Tempo I',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 10804 AND p.composer_id = 105 AND part.part_key = 'musicbrainz:e7410fc8-ac8b-4df8-9afc-7638b2c43d99' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:e7410fc8-ac8b-4df8-9afc-7638b2c43d99', 2, 'II', 'Adagio - Piu mosso - Tempo I', 'String Quartet №10: II. Adagio - Piu mosso - Tempo I', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 10804 AND p.composer_id = 105
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:e7410fc8-ac8b-4df8-9afc-7638b2c43d99'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = 'Scherzo; Allegro vivace - Vivo', part.name_en = 'String Quartet №10: III. Scherzo; Allegro vivace - Vivo',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 10804 AND p.composer_id = 105 AND part.part_key = 'musicbrainz:8be0d67d-18c0-4a40-a29a-bc36f2f456a7' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:8be0d67d-18c0-4a40-a29a-bc36f2f456a7', 3, 'III', 'Scherzo; Allegro vivace - Vivo', 'String Quartet №10: III. Scherzo; Allegro vivace - Vivo', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 10804 AND p.composer_id = 105
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:8be0d67d-18c0-4a40-a29a-bc36f2f456a7'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = 'IV',
    part.name_ko = 'Molto allegro - Piu mosso - Tempo I', part.name_en = 'String Quartet №10: IV. Molto allegro - Piu mosso - Tempo I',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 10804 AND p.composer_id = 105 AND part.part_key = 'musicbrainz:b81186f7-31b2-449d-a9fd-b9f68a23868a' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:b81186f7-31b2-449d-a9fd-b9f68a23868a', 4, 'IV', 'Molto allegro - Piu mosso - Tempo I', 'String Quartet №10: IV. Molto allegro - Piu mosso - Tempo I', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 10804 AND p.composer_id = 105
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:b81186f7-31b2-449d-a9fd-b9f68a23868a'
);


-- None 현악 4중주 12번

UPDATE pieces piece
SET piece.title = '현악 4중주 12번', piece.title_en = 'String Quartet no. 12',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 9836 AND piece.composer_id = 105
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'Allegro', part.name_en = 'String Quartet №12: I. Allegro',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 9836 AND p.composer_id = 105 AND part.part_key = 'musicbrainz:cd5a2d0e-2063-4be9-86f4-40f51e709c8b' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:cd5a2d0e-2063-4be9-86f4-40f51e709c8b', 1, 'I', 'Allegro', 'String Quartet №12: I. Allegro', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 9836 AND p.composer_id = 105
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:cd5a2d0e-2063-4be9-86f4-40f51e709c8b'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'Andante malinconico - Poco piu mosso - Tempo I', part.name_en = 'String Quartet №12: II. Andante malinconico - Poco piu mosso - Tempo I',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 9836 AND p.composer_id = 105 AND part.part_key = 'musicbrainz:270052fb-2627-4cf5-a6bb-f4c4c0f76459' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:270052fb-2627-4cf5-a6bb-f4c4c0f76459', 2, 'II', 'Andante malinconico - Poco piu mosso - Tempo I', 'String Quartet №12: II. Andante malinconico - Poco piu mosso - Tempo I', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 9836 AND p.composer_id = 105
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:270052fb-2627-4cf5-a6bb-f4c4c0f76459'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = 'Allegretto leggiero - Poco vivace - Tempo I - Quasi vivo', part.name_en = 'String Quartet №12: III. Allegretto leggiero - Poco vivace - Tempo I - Quasi vivo',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 9836 AND p.composer_id = 105 AND part.part_key = 'musicbrainz:eccc8249-7e23-42b3-9462-96f3789fdce6' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:eccc8249-7e23-42b3-9462-96f3789fdce6', 3, 'III', 'Allegretto leggiero - Poco vivace - Tempo I - Quasi vivo', 'String Quartet №12: III. Allegretto leggiero - Poco vivace - Tempo I - Quasi vivo', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 9836 AND p.composer_id = 105
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:eccc8249-7e23-42b3-9462-96f3789fdce6'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = 'IV',
    part.name_ko = 'Allegro ben ritmato - Poco meno - Allegro piu mosso', part.name_en = 'String Quartet №12: IV. Allegro ben ritmato - Poco meno - Allegro piu mosso',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 9836 AND p.composer_id = 105 AND part.part_key = 'musicbrainz:13ed791a-2b1d-45a7-a164-04ec3559b0de' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:13ed791a-2b1d-45a7-a164-04ec3559b0de', 4, 'IV', 'Allegro ben ritmato - Poco meno - Allegro piu mosso', 'String Quartet №12: IV. Allegro ben ritmato - Poco meno - Allegro piu mosso', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 9836 AND p.composer_id = 105
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:13ed791a-2b1d-45a7-a164-04ec3559b0de'
);


-- W 519 현악 4중주 14번

UPDATE pieces piece
SET piece.title = '현악 4중주 14번', piece.title_en = 'String Quartet no. 14, W519',
    piece.type = 'album', piece.opus_number = 'W 519',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 11007 AND piece.composer_id = 105
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'Allegro', part.name_en = 'String Quartet no. 14, W519: I. Allegro',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11007 AND p.composer_id = 105 AND part.part_key = 'musicbrainz:a9c0cfa6-deaf-4258-bd73-4da1fbfcc2a4' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:a9c0cfa6-deaf-4258-bd73-4da1fbfcc2a4', 1, 'I', 'Allegro', 'String Quartet no. 14, W519: I. Allegro', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 11007 AND p.composer_id = 105
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:a9c0cfa6-deaf-4258-bd73-4da1fbfcc2a4'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'Andante', part.name_en = 'String Quartet no. 14, W519: II. Andante',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11007 AND p.composer_id = 105 AND part.part_key = 'musicbrainz:19bdb4d4-8b8d-4166-9b77-0d02edf81961' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:19bdb4d4-8b8d-4166-9b77-0d02edf81961', 2, 'II', 'Andante', 'String Quartet no. 14, W519: II. Andante', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 11007 AND p.composer_id = 105
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:19bdb4d4-8b8d-4166-9b77-0d02edf81961'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = 'Scherzo - Vivace', part.name_en = 'String Quartet no. 14, W519: III. Scherzo - Vivace',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11007 AND p.composer_id = 105 AND part.part_key = 'musicbrainz:d442078f-a0d2-4e37-851f-b868152eff72' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:d442078f-a0d2-4e37-851f-b868152eff72', 3, 'III', 'Scherzo - Vivace', 'String Quartet no. 14, W519: III. Scherzo - Vivace', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 11007 AND p.composer_id = 105
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:d442078f-a0d2-4e37-851f-b868152eff72'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = 'IV',
    part.name_ko = 'Molto allegro', part.name_en = 'String Quartet no. 14, W519: IV. Molto allegro',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11007 AND p.composer_id = 105 AND part.part_key = 'musicbrainz:c7fb5ff0-1943-43fb-8459-401c0ecd37f4' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:c7fb5ff0-1943-43fb-8459-401c0ecd37f4', 4, 'IV', 'Molto allegro', 'String Quartet no. 14, W519: IV. Molto allegro', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 11007 AND p.composer_id = 105
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:c7fb5ff0-1943-43fb-8459-401c0ecd37f4'
);


-- W 523 현악 4중주 15번

UPDATE pieces piece
SET piece.title = '현악 4중주 15번', piece.title_en = 'String Quartet no. 15, W523',
    piece.type = 'album', piece.opus_number = 'W 523',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 9916 AND piece.composer_id = 105
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'Allegro non troppo', part.name_en = 'String Quartet no. 15, W523: I. Allegro non troppo',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 9916 AND p.composer_id = 105 AND part.part_key = 'musicbrainz:3680acea-7c79-4547-86b9-c1e2a9019a47' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:3680acea-7c79-4547-86b9-c1e2a9019a47', 1, 'I', 'Allegro non troppo', 'String Quartet no. 15, W523: I. Allegro non troppo', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 9916 AND p.composer_id = 105
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:3680acea-7c79-4547-86b9-c1e2a9019a47'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'Moderato', part.name_en = 'String Quartet no. 15, W523: II. Moderato',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 9916 AND p.composer_id = 105 AND part.part_key = 'musicbrainz:d903047e-0447-4280-aaa8-22f9b7109f66' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:d903047e-0447-4280-aaa8-22f9b7109f66', 2, 'II', 'Moderato', 'String Quartet no. 15, W523: II. Moderato', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 9916 AND p.composer_id = 105
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:d903047e-0447-4280-aaa8-22f9b7109f66'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = 'Scherzo - Vivo', part.name_en = 'String Quartet no. 15, W523: III. Scherzo - Vivo',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 9916 AND p.composer_id = 105 AND part.part_key = 'musicbrainz:4d00eaf9-bb1e-43ee-ac6f-6d2484c2a938' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:4d00eaf9-bb1e-43ee-ac6f-6d2484c2a938', 3, 'III', 'Scherzo - Vivo', 'String Quartet no. 15, W523: III. Scherzo - Vivo', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 9916 AND p.composer_id = 105
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:4d00eaf9-bb1e-43ee-ac6f-6d2484c2a938'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = 'IV',
    part.name_ko = 'Allegro', part.name_en = 'String Quartet no. 15, W523: IV. Allegro',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 9916 AND p.composer_id = 105 AND part.part_key = 'musicbrainz:a24f4a85-3867-4bf3-9161-eedcaf5e6fff' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:a24f4a85-3867-4bf3-9161-eedcaf5e6fff', 4, 'IV', 'Allegro', 'String Quartet no. 15, W523: IV. Allegro', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 9916 AND p.composer_id = 105
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:a24f4a85-3867-4bf3-9161-eedcaf5e6fff'
);


-- None 현악 4중주 16번

UPDATE pieces piece
SET piece.title = '현악 4중주 16번', piece.title_en = 'String Quartet no. 16',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 8479 AND piece.composer_id = 105
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'Allegro non troppo', part.name_en = 'String Quartet №16: I. Allegro non troppo',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 8479 AND p.composer_id = 105 AND part.part_key = 'musicbrainz:b20a0ef5-784d-408a-b25b-2e3d0284a122' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:b20a0ef5-784d-408a-b25b-2e3d0284a122', 1, 'I', 'Allegro non troppo', 'String Quartet №16: I. Allegro non troppo', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 8479 AND p.composer_id = 105
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:b20a0ef5-784d-408a-b25b-2e3d0284a122'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'Molto andante, quasi adagio', part.name_en = 'String Quartet №16: II. Molto andante, quasi adagio',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 8479 AND p.composer_id = 105 AND part.part_key = 'musicbrainz:afdc48ee-370a-40ef-98c9-6f6aa655b764' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:afdc48ee-370a-40ef-98c9-6f6aa655b764', 2, 'II', 'Molto andante, quasi adagio', 'String Quartet №16: II. Molto andante, quasi adagio', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 8479 AND p.composer_id = 105
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:afdc48ee-370a-40ef-98c9-6f6aa655b764'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = 'Scherzo: Vivace', part.name_en = 'String Quartet №16: III. Scherzo: Vivace',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 8479 AND p.composer_id = 105 AND part.part_key = 'musicbrainz:99820e7f-c3f3-4a95-8978-672959528f1e' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:99820e7f-c3f3-4a95-8978-672959528f1e', 3, 'III', 'Scherzo: Vivace', 'String Quartet №16: III. Scherzo: Vivace', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 8479 AND p.composer_id = 105
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:99820e7f-c3f3-4a95-8978-672959528f1e'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = 'IV',
    part.name_ko = 'Molto allegro', part.name_en = 'String Quartet №16: IV. Molto allegro',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 8479 AND p.composer_id = 105 AND part.part_key = 'musicbrainz:0a58a592-5f14-4cc4-a1b6-3cc4fe16d68d' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:0a58a592-5f14-4cc4-a1b6-3cc4fe16d68d', 4, 'IV', 'Molto allegro', 'String Quartet №16: IV. Molto allegro', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 8479 AND p.composer_id = 105
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:0a58a592-5f14-4cc4-a1b6-3cc4fe16d68d'
);


-- W 537 현악 4중주 17번

UPDATE pieces piece
SET piece.title = '현악 4중주 17번', piece.title_en = 'String Quartet no. 17, W537',
    piece.type = 'album', piece.opus_number = 'W 537',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 8796 AND piece.composer_id = 105
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'Allegro non troppo', part.name_en = 'String Quartet no. 17, W537: I. Allegro non troppo',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 8796 AND p.composer_id = 105 AND part.part_key = 'musicbrainz:41826a2c-0385-4033-8308-fb0da3af613f' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:41826a2c-0385-4033-8308-fb0da3af613f', 1, 'I', 'Allegro non troppo', 'String Quartet no. 17, W537: I. Allegro non troppo', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 8796 AND p.composer_id = 105
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:41826a2c-0385-4033-8308-fb0da3af613f'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'Molto lento', part.name_en = 'String Quartet no. 17, W537: II. Molto lento',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 8796 AND p.composer_id = 105 AND part.part_key = 'musicbrainz:6e75f434-8538-486a-9770-df53430e41d6' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:6e75f434-8538-486a-9770-df53430e41d6', 2, 'II', 'Molto lento', 'String Quartet no. 17, W537: II. Molto lento', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 8796 AND p.composer_id = 105
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:6e75f434-8538-486a-9770-df53430e41d6'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = 'Scherzo', part.name_en = 'String Quartet no. 17, W537: III. Scherzo',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 8796 AND p.composer_id = 105 AND part.part_key = 'musicbrainz:71141055-725d-4315-b35e-2167927339f7' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:71141055-725d-4315-b35e-2167927339f7', 3, 'III', 'Scherzo', 'String Quartet no. 17, W537: III. Scherzo', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 8796 AND p.composer_id = 105
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:71141055-725d-4315-b35e-2167927339f7'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = 'IV',
    part.name_ko = 'Allegro vivace', part.name_en = 'String Quartet no. 17, W537: IV. Allegro vivace',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 8796 AND p.composer_id = 105 AND part.part_key = 'musicbrainz:61faa194-9a9e-4671-b453-aeac16fdbf64' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:61faa194-9a9e-4671-b453-aeac16fdbf64', 4, 'IV', 'Allegro vivace', 'String Quartet no. 17, W537: IV. Allegro vivace', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 8796 AND p.composer_id = 105
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:61faa194-9a9e-4671-b453-aeac16fdbf64'
);


-- None 현악 4중주 2번

UPDATE pieces piece
SET piece.title = '현악 4중주 2번', piece.title_en = 'String Quartet no. 2',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 8571 AND piece.composer_id = 105
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'Allegro non troppo', part.name_en = 'String Quartet №2: I. Allegro non troppo',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 8571 AND p.composer_id = 105 AND part.part_key = 'musicbrainz:d0f40c74-ff8b-4008-82df-57c9819018cd' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:d0f40c74-ff8b-4008-82df-57c9819018cd', 1, 'I', 'Allegro non troppo', 'String Quartet №2: I. Allegro non troppo', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 8571 AND p.composer_id = 105
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:d0f40c74-ff8b-4008-82df-57c9819018cd'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'Scherzo: Allegro', part.name_en = 'String Quartet №2: II. Scherzo: Allegro',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 8571 AND p.composer_id = 105 AND part.part_key = 'musicbrainz:f19ed03b-9a9b-49d8-a5fb-c49187f410ba' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:f19ed03b-9a9b-49d8-a5fb-c49187f410ba', 2, 'II', 'Scherzo: Allegro', 'String Quartet №2: II. Scherzo: Allegro', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 8571 AND p.composer_id = 105
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:f19ed03b-9a9b-49d8-a5fb-c49187f410ba'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = 'Andante', part.name_en = 'String Quartet №2: III. Andante',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 8571 AND p.composer_id = 105 AND part.part_key = 'musicbrainz:e1e38733-f194-4105-8733-df37b779f12d' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:e1e38733-f194-4105-8733-df37b779f12d', 3, 'III', 'Andante', 'String Quartet №2: III. Andante', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 8571 AND p.composer_id = 105
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:e1e38733-f194-4105-8733-df37b779f12d'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = 'IV',
    part.name_ko = 'Allegro deciso - Presto - Prestissimo final', part.name_en = 'String Quartet №2: IV. Allegro deciso - Presto - Prestissimo final',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 8571 AND p.composer_id = 105 AND part.part_key = 'musicbrainz:b2a6dd36-82ef-4cdb-a9d6-84f5af303e36' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:b2a6dd36-82ef-4cdb-a9d6-84f5af303e36', 4, 'IV', 'Allegro deciso - Presto - Prestissimo final', 'String Quartet №2: IV. Allegro deciso - Presto - Prestissimo final', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 8571 AND p.composer_id = 105
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:b2a6dd36-82ef-4cdb-a9d6-84f5af303e36'
);


-- W 112 현악 4중주 3번

UPDATE pieces piece
SET piece.title = '현악 4중주 3번', piece.title_en = 'String Quartet no. 3, W112',
    piece.type = 'album', piece.opus_number = 'W 112',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 11288 AND piece.composer_id = 105
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'Allegro non troppo', part.name_en = 'String Quartet no. 3, W112: I. Allegro non troppo',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11288 AND p.composer_id = 105 AND part.part_key = 'musicbrainz:12e53355-5d85-42c8-8e14-19c3a5bd8736' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:12e53355-5d85-42c8-8e14-19c3a5bd8736', 1, 'I', 'Allegro non troppo', 'String Quartet no. 3, W112: I. Allegro non troppo', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 11288 AND p.composer_id = 105
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:12e53355-5d85-42c8-8e14-19c3a5bd8736'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'Molto vivo', part.name_en = 'String Quartet no. 3, W112: II. Molto vivo',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11288 AND p.composer_id = 105 AND part.part_key = 'musicbrainz:cc0c639d-5d1e-4215-9fa1-9ba6cfbc5261' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:cc0c639d-5d1e-4215-9fa1-9ba6cfbc5261', 2, 'II', 'Molto vivo', 'String Quartet no. 3, W112: II. Molto vivo', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 11288 AND p.composer_id = 105
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:cc0c639d-5d1e-4215-9fa1-9ba6cfbc5261'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = 'Molto adagio', part.name_en = 'String Quartet no. 3, W112: III. Molto adagio',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11288 AND p.composer_id = 105 AND part.part_key = 'musicbrainz:d6a100b1-cb49-49d5-a393-a94ebe8e86ea' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:d6a100b1-cb49-49d5-a393-a94ebe8e86ea', 3, 'III', 'Molto adagio', 'String Quartet no. 3, W112: III. Molto adagio', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 11288 AND p.composer_id = 105
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:d6a100b1-cb49-49d5-a393-a94ebe8e86ea'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = 'IV',
    part.name_ko = 'Allegro con fuoco', part.name_en = 'String Quartet no. 3, W112: IV. Allegro con fuoco',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11288 AND p.composer_id = 105 AND part.part_key = 'musicbrainz:2bc1402e-a440-4308-a20f-33f1d3302711' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:2bc1402e-a440-4308-a20f-33f1d3302711', 4, 'IV', 'Allegro con fuoco', 'String Quartet no. 3, W112: IV. Allegro con fuoco', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 11288 AND p.composer_id = 105
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:2bc1402e-a440-4308-a20f-33f1d3302711'
);


-- None 현악 4중주 4번

UPDATE pieces piece
SET piece.title = '현악 4중주 4번', piece.title_en = 'String Quartet no. 4',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 7875 AND piece.composer_id = 105
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'Allegro con moto', part.name_en = 'String Quartet №4: I. Allegro con moto',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 7875 AND p.composer_id = 105 AND part.part_key = 'musicbrainz:a11cfc8f-b67b-4a91-9852-88f6f882f708' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:a11cfc8f-b67b-4a91-9852-88f6f882f708', 1, 'I', 'Allegro con moto', 'String Quartet №4: I. Allegro con moto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 7875 AND p.composer_id = 105
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:a11cfc8f-b67b-4a91-9852-88f6f882f708'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'Andantino (tranquillo)', part.name_en = 'String Quartet №4: II. Andantino (tranquillo)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 7875 AND p.composer_id = 105 AND part.part_key = 'musicbrainz:7261b04f-500e-4296-bb64-db0d5e0ecf8f' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:7261b04f-500e-4296-bb64-db0d5e0ecf8f', 2, 'II', 'Andantino (tranquillo)', 'String Quartet №4: II. Andantino (tranquillo)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 7875 AND p.composer_id = 105
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:7261b04f-500e-4296-bb64-db0d5e0ecf8f'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = 'Scherzo - Allegro vivace', part.name_en = 'String Quartet №4: III. Scherzo - Allegro vivace',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 7875 AND p.composer_id = 105 AND part.part_key = 'musicbrainz:e3f31684-e190-4836-8e88-d5404acd5227' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:e3f31684-e190-4836-8e88-d5404acd5227', 3, 'III', 'Scherzo - Allegro vivace', 'String Quartet №4: III. Scherzo - Allegro vivace', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 7875 AND p.composer_id = 105
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:e3f31684-e190-4836-8e88-d5404acd5227'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = 'IV',
    part.name_ko = 'Allegro', part.name_en = 'String Quartet №4: IV. Allegro',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 7875 AND p.composer_id = 105 AND part.part_key = 'musicbrainz:7fbf4f9f-dfcc-4bfd-b1f8-363d4587c39c' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:7fbf4f9f-dfcc-4bfd-b1f8-363d4587c39c', 4, 'IV', 'Allegro', 'String Quartet №4: IV. Allegro', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 7875 AND p.composer_id = 105
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:7fbf4f9f-dfcc-4bfd-b1f8-363d4587c39c'
);


-- W 399 현악 4중주 6번

UPDATE pieces piece
SET piece.title = '현악 4중주 6번', piece.title_en = 'String Quartet no. 6, W399',
    piece.type = 'album', piece.opus_number = 'W 399',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 10325 AND piece.composer_id = 105
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'Poco animato', part.name_en = 'String Quartet no. 6, W399: I. Poco animato',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 10325 AND p.composer_id = 105 AND part.part_key = 'musicbrainz:a17c18c5-0f17-404b-a5ee-be5694018762' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:a17c18c5-0f17-404b-a5ee-be5694018762', 1, 'I', 'Poco animato', 'String Quartet no. 6, W399: I. Poco animato', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 10325 AND p.composer_id = 105
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:a17c18c5-0f17-404b-a5ee-be5694018762'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'Allegretto', part.name_en = 'String Quartet no. 6, W399: II. Allegretto',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 10325 AND p.composer_id = 105 AND part.part_key = 'musicbrainz:7395de9b-d63b-4520-9602-64f76ff9f589' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:7395de9b-d63b-4520-9602-64f76ff9f589', 2, 'II', 'Allegretto', 'String Quartet no. 6, W399: II. Allegretto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 10325 AND p.composer_id = 105
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:7395de9b-d63b-4520-9602-64f76ff9f589'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = 'Andante quasi adagio', part.name_en = 'String Quartet no. 6, W399: III. Andante quasi adagio',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 10325 AND p.composer_id = 105 AND part.part_key = 'musicbrainz:fede12f9-09b5-4fdd-b0b0-e05d8cfc2886' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:fede12f9-09b5-4fdd-b0b0-e05d8cfc2886', 3, 'III', 'Andante quasi adagio', 'String Quartet no. 6, W399: III. Andante quasi adagio', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 10325 AND p.composer_id = 105
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:fede12f9-09b5-4fdd-b0b0-e05d8cfc2886'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = 'IV',
    part.name_ko = 'Allegro vivace', part.name_en = 'String Quartet no. 6, W399: IV. Allegro vivace',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 10325 AND p.composer_id = 105 AND part.part_key = 'musicbrainz:7fb00edc-770b-43b5-bae1-12d426877bd6' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:7fb00edc-770b-43b5-bae1-12d426877bd6', 4, 'IV', 'Allegro vivace', 'String Quartet no. 6, W399: IV. Allegro vivace', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 10325 AND p.composer_id = 105
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:7fb00edc-770b-43b5-bae1-12d426877bd6'
);


-- W 435 현악 4중주 7번

UPDATE pieces piece
SET piece.title = '현악 4중주 7번', piece.title_en = 'String Quartet no. 7, W435',
    piece.type = 'album', piece.opus_number = 'W 435',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 10437 AND piece.composer_id = 105
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'Allegro', part.name_en = 'String Quartet no. 7, W435: I. Allegro',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 10437 AND p.composer_id = 105 AND part.part_key = 'musicbrainz:a2373136-caf0-4674-a2ac-c7f655ba64ab' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:a2373136-caf0-4674-a2ac-c7f655ba64ab', 1, 'I', 'Allegro', 'String Quartet no. 7, W435: I. Allegro', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 10437 AND p.composer_id = 105
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:a2373136-caf0-4674-a2ac-c7f655ba64ab'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'Andante', part.name_en = 'String Quartet no. 7, W435: II. Andante',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 10437 AND p.composer_id = 105 AND part.part_key = 'musicbrainz:ae52b1fa-d9fd-4e97-af73-836d7be12a69' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:ae52b1fa-d9fd-4e97-af73-836d7be12a69', 2, 'II', 'Andante', 'String Quartet no. 7, W435: II. Andante', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 10437 AND p.composer_id = 105
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:ae52b1fa-d9fd-4e97-af73-836d7be12a69'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = 'Scherzo - Allegro vivace', part.name_en = 'String Quartet no. 7, W435: III. Scherzo - Allegro vivace',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 10437 AND p.composer_id = 105 AND part.part_key = 'musicbrainz:7318ea75-c4d0-463b-a75c-9954efc0708a' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:7318ea75-c4d0-463b-a75c-9954efc0708a', 3, 'III', 'Scherzo - Allegro vivace', 'String Quartet no. 7, W435: III. Scherzo - Allegro vivace', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 10437 AND p.composer_id = 105
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:7318ea75-c4d0-463b-a75c-9954efc0708a'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = 'IV',
    part.name_ko = 'Allegro giusto', part.name_en = 'String Quartet no. 7, W435: IV. Allegro giusto',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 10437 AND p.composer_id = 105 AND part.part_key = 'musicbrainz:3ccde088-5269-4078-9815-1eab8bb4b9b9' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:3ccde088-5269-4078-9815-1eab8bb4b9b9', 4, 'IV', 'Allegro giusto', 'String Quartet no. 7, W435: IV. Allegro giusto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 10437 AND p.composer_id = 105
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:3ccde088-5269-4078-9815-1eab8bb4b9b9'
);


-- W 446 현악 4중주 8번

UPDATE pieces piece
SET piece.title = '현악 4중주 8번', piece.title_en = 'String Quartet no. 8, W446',
    piece.type = 'album', piece.opus_number = 'W 446',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 10445 AND piece.composer_id = 105
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'Allegro', part.name_en = 'String Quartet no. 8, W446: I. Allegro',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 10445 AND p.composer_id = 105 AND part.part_key = 'musicbrainz:7d02efbb-e8c4-46ba-9de9-408f99b80d4b' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:7d02efbb-e8c4-46ba-9de9-408f99b80d4b', 1, 'I', 'Allegro', 'String Quartet no. 8, W446: I. Allegro', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 10445 AND p.composer_id = 105
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:7d02efbb-e8c4-46ba-9de9-408f99b80d4b'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'Lento', part.name_en = 'String Quartet no. 8, W446: II. Lento',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 10445 AND p.composer_id = 105 AND part.part_key = 'musicbrainz:ff626943-ba0f-46af-9779-3d5e52aa8f3a' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:ff626943-ba0f-46af-9779-3d5e52aa8f3a', 2, 'II', 'Lento', 'String Quartet no. 8, W446: II. Lento', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 10445 AND p.composer_id = 105
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:ff626943-ba0f-46af-9779-3d5e52aa8f3a'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = 'Scherzo - Vivace', part.name_en = 'String Quartet no. 8, W446: III. Scherzo - Vivace',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 10445 AND p.composer_id = 105 AND part.part_key = 'musicbrainz:3c683f4c-2789-4c8f-bebf-f4ac0014f377' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:3c683f4c-2789-4c8f-bebf-f4ac0014f377', 3, 'III', 'Scherzo - Vivace', 'String Quartet no. 8, W446: III. Scherzo - Vivace', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 10445 AND p.composer_id = 105
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:3c683f4c-2789-4c8f-bebf-f4ac0014f377'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = 'IV',
    part.name_ko = 'Quasi allegro', part.name_en = 'String Quartet no. 8, W446: IV. Quasi allegro',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 10445 AND p.composer_id = 105 AND part.part_key = 'musicbrainz:1790f00b-b730-43ba-bd56-9b4067b7e2c0' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:1790f00b-b730-43ba-bd56-9b4067b7e2c0', 4, 'IV', 'Quasi allegro', 'String Quartet no. 8, W446: IV. Quasi allegro', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 10445 AND p.composer_id = 105
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:1790f00b-b730-43ba-bd56-9b4067b7e2c0'
);


-- None 현악 4중주 9번

UPDATE pieces piece
SET piece.title = '현악 4중주 9번', piece.title_en = 'String Quartet no. 9',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 10589 AND piece.composer_id = 105
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'Allegro - Allegro vivace', part.name_en = 'String Quartet №9: I. Allegro - Allegro vivace',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 10589 AND p.composer_id = 105 AND part.part_key = 'musicbrainz:ddef348d-2d60-4136-8441-606b42cee201' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:ddef348d-2d60-4136-8441-606b42cee201', 1, 'I', 'Allegro - Allegro vivace', 'String Quartet №9: I. Allegro - Allegro vivace', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 10589 AND p.composer_id = 105
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:ddef348d-2d60-4136-8441-606b42cee201'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'Andantino vagaroso - Quasi animato - Tempo I', part.name_en = 'String Quartet №9: II. Andantino vagaroso - Quasi animato - Tempo I',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 10589 AND p.composer_id = 105 AND part.part_key = 'musicbrainz:70d98d81-03f8-460d-9d90-f47a4d697710' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:70d98d81-03f8-460d-9d90-f47a4d697710', 2, 'II', 'Andantino vagaroso - Quasi animato - Tempo I', 'String Quartet №9: II. Andantino vagaroso - Quasi animato - Tempo I', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 10589 AND p.composer_id = 105
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:70d98d81-03f8-460d-9d90-f47a4d697710'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = 'Allegro poco moderato / com bravura - Piu mosso - Tempo I', part.name_en = 'String Quartet №9: III. Allegro poco moderato / com bravura - Piu mosso - Tempo I',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 10589 AND p.composer_id = 105 AND part.part_key = 'musicbrainz:8218fbd0-89ea-4469-8891-b519cd9326a6' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:8218fbd0-89ea-4469-8891-b519cd9326a6', 3, 'III', 'Allegro poco moderato / com bravura - Piu mosso - Tempo I', 'String Quartet №9: III. Allegro poco moderato / com bravura - Piu mosso - Tempo I', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 10589 AND p.composer_id = 105
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:8218fbd0-89ea-4469-8891-b519cd9326a6'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = 'IV',
    part.name_ko = 'Molto allegro', part.name_en = 'String Quartet №9: IV. Molto allegro',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 10589 AND p.composer_id = 105 AND part.part_key = 'musicbrainz:314c6de7-e08f-4b80-a8ed-064447bba411' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:314c6de7-e08f-4b80-a8ed-064447bba411', 4, 'IV', 'Molto allegro', 'String Quartet №9: IV. Molto allegro', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 10589 AND p.composer_id = 105
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:314c6de7-e08f-4b80-a8ed-064447bba411'
);


-- W 460 현악 3중주

UPDATE pieces piece
SET piece.title = '현악 3중주', piece.title_en = 'String Trio, W460',
    piece.type = 'album', piece.opus_number = 'W 460',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 8642 AND piece.composer_id = 105
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'Allegro', part.name_en = 'String Trio, W460: I. Allegro',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 8642 AND p.composer_id = 105 AND part.part_key = 'musicbrainz:1b9c4ba6-50b8-4864-989f-a0c05fc3ac81' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:1b9c4ba6-50b8-4864-989f-a0c05fc3ac81', 1, 'I', 'Allegro', 'String Trio, W460: I. Allegro', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 8642 AND p.composer_id = 105
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:1b9c4ba6-50b8-4864-989f-a0c05fc3ac81'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'Andante', part.name_en = 'String Trio, W460: II. Andante',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 8642 AND p.composer_id = 105 AND part.part_key = 'musicbrainz:7ebce51f-fa48-42d9-b528-e45c98ad1390' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:7ebce51f-fa48-42d9-b528-e45c98ad1390', 2, 'II', 'Andante', 'String Trio, W460: II. Andante', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 8642 AND p.composer_id = 105
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:7ebce51f-fa48-42d9-b528-e45c98ad1390'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = 'Scherzo. Vivace', part.name_en = 'String Trio, W460: III. Scherzo. Vivace',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 8642 AND p.composer_id = 105 AND part.part_key = 'musicbrainz:87f802f1-4987-4ca4-80e4-b2c4db1c2e9a' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:87f802f1-4987-4ca4-80e4-b2c4db1c2e9a', 3, 'III', 'Scherzo. Vivace', 'String Trio, W460: III. Scherzo. Vivace', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 8642 AND p.composer_id = 105
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:87f802f1-4987-4ca4-80e4-b2c4db1c2e9a'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = 'IV',
    part.name_ko = 'Allegro preciso e agitato', part.name_en = 'String Trio, W460: IV. Allegro preciso e agitato',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 8642 AND p.composer_id = 105 AND part.part_key = 'musicbrainz:92e2dfe2-8093-46cd-a074-2906a2eb2532' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:92e2dfe2-8093-46cd-a074-2906a2eb2532', 4, 'IV', 'Allegro preciso e agitato', 'String Trio, W460: IV. Allegro preciso e agitato', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 8642 AND p.composer_id = 105
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:92e2dfe2-8093-46cd-a074-2906a2eb2532'
);


-- W 053 모음곡 1번

UPDATE pieces piece
SET piece.title = '모음곡 1번', piece.title_en = 'Suite infantil nº 1, W053',
    piece.type = 'album', piece.opus_number = 'W 053',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 9398 AND piece.composer_id = 105
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'Bailando', part.name_en = 'Suite infantil nº 1, W053: I. Bailando',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 9398 AND p.composer_id = 105 AND part.part_key = 'musicbrainz:0f502fc7-9248-4a22-8bad-ddf6fc3c66d7' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:0f502fc7-9248-4a22-8bad-ddf6fc3c66d7', 1, 'I', 'Bailando', 'Suite infantil nº 1, W053: I. Bailando', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 9398 AND p.composer_id = 105
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:0f502fc7-9248-4a22-8bad-ddf6fc3c66d7'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'Nenê vai dormir', part.name_en = 'Suite infantil nº 1, W053: II. Nenê vai dormir',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 9398 AND p.composer_id = 105 AND part.part_key = 'musicbrainz:fa79e739-14aa-4bc2-b97e-6c8f155f5376' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:fa79e739-14aa-4bc2-b97e-6c8f155f5376', 2, 'II', 'Nenê vai dormir', 'Suite infantil nº 1, W053: II. Nenê vai dormir', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 9398 AND p.composer_id = 105
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:fa79e739-14aa-4bc2-b97e-6c8f155f5376'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = 'Artimanhas', part.name_en = 'Suite infantil nº 1, W053: III. Artimanhas',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 9398 AND p.composer_id = 105 AND part.part_key = 'musicbrainz:aac1accc-d1e2-4744-915b-2a647163a574' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:aac1accc-d1e2-4744-915b-2a647163a574', 3, 'III', 'Artimanhas', 'Suite infantil nº 1, W053: III. Artimanhas', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 9398 AND p.composer_id = 105
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:aac1accc-d1e2-4744-915b-2a647163a574'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = 'IV',
    part.name_ko = 'Reflexões', part.name_en = 'Suite infantil nº 1, W053: IV. Reflexões',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 9398 AND p.composer_id = 105 AND part.part_key = 'musicbrainz:05ebdb32-b29d-46ec-8c9a-979d090e2a8d' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:05ebdb32-b29d-46ec-8c9a-979d090e2a8d', 4, 'IV', 'Reflexões', 'Suite infantil nº 1, W053: IV. Reflexões', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 9398 AND p.composer_id = 105
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:05ebdb32-b29d-46ec-8c9a-979d090e2a8d'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 5, part.movement_number = 'V',
    part.name_ko = 'No balanço', part.name_en = 'Suite infantil nº 1, W053: V. No balanço',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 9398 AND p.composer_id = 105 AND part.part_key = 'musicbrainz:ad484b34-ab96-463a-9c8e-9f52394caa1a' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:ad484b34-ab96-463a-9c8e-9f52394caa1a', 5, 'V', 'No balanço', 'Suite infantil nº 1, W053: V. No balanço', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 9398 AND p.composer_id = 105
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:ad484b34-ab96-463a-9c8e-9f52394caa1a'
);


-- W 067 모음곡 2번

UPDATE pieces piece
SET piece.title = '모음곡 2번', piece.title_en = 'Suite infantil nº 2, W067',
    piece.type = 'album', piece.opus_number = 'W 067',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 10337 AND piece.composer_id = 105
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'Allegro', part.name_en = 'Suite infantil nº 2, W067: I. Allegro',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 10337 AND p.composer_id = 105 AND part.part_key = 'musicbrainz:c9930aca-b721-41ba-8fec-d9d9cf2cd1f9' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:c9930aca-b721-41ba-8fec-d9d9cf2cd1f9', 1, 'I', 'Allegro', 'Suite infantil nº 2, W067: I. Allegro', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 10337 AND p.composer_id = 105
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:c9930aca-b721-41ba-8fec-d9d9cf2cd1f9'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'Andantino', part.name_en = 'Suite infantil nº 2, W067: II. Andantino',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 10337 AND p.composer_id = 105 AND part.part_key = 'musicbrainz:5063d6b2-cf59-433f-b58c-ce9d3d7b75a3' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:5063d6b2-cf59-433f-b58c-ce9d3d7b75a3', 2, 'II', 'Andantino', 'Suite infantil nº 2, W067: II. Andantino', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 10337 AND p.composer_id = 105
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:5063d6b2-cf59-433f-b58c-ce9d3d7b75a3'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = 'Allegretto', part.name_en = 'Suite infantil nº 2, W067: III. Allegretto',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 10337 AND p.composer_id = 105 AND part.part_key = 'musicbrainz:c6581709-c0e2-4776-90e8-9071cddb5be8' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:c6581709-c0e2-4776-90e8-9071cddb5be8', 3, 'III', 'Allegretto', 'Suite infantil nº 2, W067: III. Allegretto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 10337 AND p.composer_id = 105
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:c6581709-c0e2-4776-90e8-9071cddb5be8'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = 'IV',
    part.name_ko = 'Allegro non troppo', part.name_en = 'Suite infantil nº 2, W067: IV. Allegro non troppo',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 10337 AND p.composer_id = 105 AND part.part_key = 'musicbrainz:e9d41ff2-7e65-47b8-a434-759240d33737' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:e9d41ff2-7e65-47b8-a434-759240d33737', 4, 'IV', 'Allegro non troppo', 'Suite infantil nº 2, W067: IV. Allegro non troppo', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 10337 AND p.composer_id = 105
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:e9d41ff2-7e65-47b8-a434-759240d33737'
);


-- W 020 Suite populaire brésilienne

UPDATE pieces piece
SET piece.title = 'Suite populaire brésilienne', piece.title_en = 'Suite populaire brésilienne, W020',
    piece.type = 'album', piece.opus_number = 'W 020',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 11112 AND piece.composer_id = 105
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'II',
    part.name_ko = 'Schottish‐Choro', part.name_en = 'Suite populaire brésilienne, W020: II. Schottish‐Choro',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11112 AND p.composer_id = 105 AND part.part_key = 'musicbrainz:43d594e9-3a53-31d0-9bdc-81109a8a59a7' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:43d594e9-3a53-31d0-9bdc-81109a8a59a7', 1, 'II', 'Schottish‐Choro', 'Suite populaire brésilienne, W020: II. Schottish‐Choro', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 11112 AND p.composer_id = 105
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:43d594e9-3a53-31d0-9bdc-81109a8a59a7'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'III',
    part.name_ko = 'Valsa-Choro', part.name_en = 'Suite populaire brésilienne, W020: III. Valsa-Choro',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11112 AND p.composer_id = 105 AND part.part_key = 'musicbrainz:346cb96e-b0f0-334e-a86e-2468a69ab135' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:346cb96e-b0f0-334e-a86e-2468a69ab135', 2, 'III', 'Valsa-Choro', 'Suite populaire brésilienne, W020: III. Valsa-Choro', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 11112 AND p.composer_id = 105
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:346cb96e-b0f0-334e-a86e-2468a69ab135'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'IV',
    part.name_ko = 'Gavota-Choro', part.name_en = 'Suite populaire brésilienne, W020: IV. Gavota-Choro',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11112 AND p.composer_id = 105 AND part.part_key = 'musicbrainz:94c369ad-7441-3124-91f2-a1e1ea426ec7' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:94c369ad-7441-3124-91f2-a1e1ea426ec7', 3, 'IV', 'Gavota-Choro', 'Suite populaire brésilienne, W020: IV. Gavota-Choro', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 11112 AND p.composer_id = 105
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:94c369ad-7441-3124-91f2-a1e1ea426ec7'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = 'V',
    part.name_ko = 'Chorinho', part.name_en = 'Suite populaire brésilienne, W020: V. Chorinho',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11112 AND p.composer_id = 105 AND part.part_key = 'musicbrainz:180b832b-d9f1-318d-a612-b6d2757c4206' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:180b832b-d9f1-318d-a612-b6d2757c4206', 4, 'V', 'Chorinho', 'Suite populaire brésilienne, W020: V. Chorinho', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 11112 AND p.composer_id = 105
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:180b832b-d9f1-318d-a612-b6d2757c4206'
);


-- W 217 Sul America

UPDATE pieces piece
SET piece.title = 'Sul America', piece.title_en = 'Sul America, W217',
    piece.type = 'song', piece.opus_number = 'W 217',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 10455 AND piece.composer_id = 105
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- Op. 97 Suíte floral

UPDATE pieces piece
SET piece.title = 'Suíte floral', piece.title_en = 'Suíte floral, op. 97, W117',
    piece.type = 'album', piece.opus_number = 'Op. 97',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 9465 AND piece.composer_id = 105
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'Idílio na rede', part.name_en = 'Suíte floral, op. 97, W117: I. Idílio na rede',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 9465 AND p.composer_id = 105 AND part.part_key = 'musicbrainz:05a18c88-e641-42d9-aef4-8bcb2f5ebe75' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:05a18c88-e641-42d9-aef4-8bcb2f5ebe75', 1, 'I', 'Idílio na rede', 'Suíte floral, op. 97, W117: I. Idílio na rede', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 9465 AND p.composer_id = 105
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:05a18c88-e641-42d9-aef4-8bcb2f5ebe75'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'Uma camponesa cantadeira', part.name_en = 'Suíte floral, op. 97, W117: II. Uma camponesa cantadeira',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 9465 AND p.composer_id = 105 AND part.part_key = 'musicbrainz:1e3d1d1e-1f40-4557-8831-8b3ce50d15d1' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:1e3d1d1e-1f40-4557-8831-8b3ce50d15d1', 2, 'II', 'Uma camponesa cantadeira', 'Suíte floral, op. 97, W117: II. Uma camponesa cantadeira', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 9465 AND p.composer_id = 105
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:1e3d1d1e-1f40-4557-8831-8b3ce50d15d1'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = 'Alegria na horta', part.name_en = 'Suíte floral, op. 97, W117: III. Alegria na horta',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 9465 AND p.composer_id = 105 AND part.part_key = 'musicbrainz:f4471951-2efd-4935-81d9-7b29de40e27a' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:f4471951-2efd-4935-81d9-7b29de40e27a', 3, 'III', 'Alegria na horta', 'Suíte floral, op. 97, W117: III. Alegria na horta', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 9465 AND p.composer_id = 105
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:f4471951-2efd-4935-81d9-7b29de40e27a'
);


-- None Suíte para canto e violino

UPDATE pieces piece
SET piece.title = 'Suíte para canto e violino', piece.title_en = 'Suíte para canto e violino',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 8250 AND piece.composer_id = 105
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'A menina e a canção', part.name_en = 'Suíte para canto e violino: I. A menina e a canção',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 8250 AND p.composer_id = 105 AND part.part_key = 'musicbrainz:9c8319a1-aa21-4329-ad48-b96c51d95943' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:9c8319a1-aa21-4329-ad48-b96c51d95943', 1, 'I', 'A menina e a canção', 'Suíte para canto e violino: I. A menina e a canção', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 8250 AND p.composer_id = 105
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:9c8319a1-aa21-4329-ad48-b96c51d95943'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'Quero ser alegre', part.name_en = 'Suíte para canto e violino: II. Quero ser alegre',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 8250 AND p.composer_id = 105 AND part.part_key = 'musicbrainz:ad443b16-6ef2-4e21-8e3e-246ccf57ff0b' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:ad443b16-6ef2-4e21-8e3e-246ccf57ff0b', 2, 'II', 'Quero ser alegre', 'Suíte para canto e violino: II. Quero ser alegre', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 8250 AND p.composer_id = 105
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:ad443b16-6ef2-4e21-8e3e-246ccf57ff0b'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = 'Sertaneja', part.name_en = 'Suíte para canto e violino: III. Sertaneja',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 8250 AND p.composer_id = 105 AND part.part_key = 'musicbrainz:450c9839-01fa-4d3b-b7bd-25dcb8822164' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:450c9839-01fa-4d3b-b7bd-25dcb8822164', 3, 'III', 'Sertaneja', 'Suíte para canto e violino: III. Sertaneja', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 8250 AND p.composer_id = 105
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:450c9839-01fa-4d3b-b7bd-25dcb8822164'
);


-- W 054 Suíte para quinteto duplo de cordas

UPDATE pieces piece
SET piece.title = 'Suíte para quinteto duplo de cordas', piece.title_en = 'Suíte para quinteto duplo de cordas, W054',
    piece.type = 'album', piece.opus_number = 'W 054',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 10602 AND piece.composer_id = 105
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'III',
    part.name_ko = 'Inquieta', part.name_en = 'Suíte para quinteto duplo de cordas, W054: III. Inquieta',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 10602 AND p.composer_id = 105 AND part.part_key = 'musicbrainz:74dd6180-025f-47fb-b3e1-534aa176d815' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:74dd6180-025f-47fb-b3e1-534aa176d815', 1, 'III', 'Inquieta', 'Suíte para quinteto duplo de cordas, W054: III. Inquieta', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 10602 AND p.composer_id = 105
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:74dd6180-025f-47fb-b3e1-534aa176d815'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'Misteriosa', part.name_en = 'Suíte para quinteto duplo de cordas, W054: II. Misteriosa',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 10602 AND p.composer_id = 105 AND part.part_key = 'musicbrainz:88a6befe-0369-4d51-9c55-65be43aff82b' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:88a6befe-0369-4d51-9c55-65be43aff82b', 2, 'II', 'Misteriosa', 'Suíte para quinteto duplo de cordas, W054: II. Misteriosa', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 10602 AND p.composer_id = 105
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:88a6befe-0369-4d51-9c55-65be43aff82b'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'I',
    part.name_ko = 'Tímida', part.name_en = 'Suíte para quinteto duplo de cordas, W054: I. Tímida',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 10602 AND p.composer_id = 105 AND part.part_key = 'musicbrainz:a0591cf8-9b0a-43f4-a911-798a9bbe9975' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:a0591cf8-9b0a-43f4-a911-798a9bbe9975', 3, 'I', 'Tímida', 'Suíte para quinteto duplo de cordas, W054: I. Tímida', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 10602 AND p.composer_id = 105
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:a0591cf8-9b0a-43f4-a911-798a9bbe9975'
);


-- None 교향곡 1번 "O Imprevisto"

UPDATE pieces piece
SET piece.title = '교향곡 1번 "O Imprevisto"', piece.title_en = 'Symphony no. 1 "O Imprevisto"',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 7855 AND piece.composer_id = 105
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'Allegro assai moderato', part.name_en = 'Symphony no. 1 "O Imprevisto": I. Allegro assai moderato',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 7855 AND p.composer_id = 105 AND part.part_key = 'musicbrainz:caaade7b-c081-4fb1-bcc5-4eccba756da3' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:caaade7b-c081-4fb1-bcc5-4eccba756da3', 1, 'I', 'Allegro assai moderato', 'Symphony no. 1 "O Imprevisto": I. Allegro assai moderato', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 7855 AND p.composer_id = 105
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:caaade7b-c081-4fb1-bcc5-4eccba756da3'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'Adagio', part.name_en = 'Symphony no. 1 "O Imprevisto": II. Adagio',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 7855 AND p.composer_id = 105 AND part.part_key = 'musicbrainz:7b975fbc-11e7-482f-a5d5-5f014ec0a0fe' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:7b975fbc-11e7-482f-a5d5-5f014ec0a0fe', 2, 'II', 'Adagio', 'Symphony no. 1 "O Imprevisto": II. Adagio', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 7855 AND p.composer_id = 105
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:7b975fbc-11e7-482f-a5d5-5f014ec0a0fe'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = 'Scherzo: Allegro vivace', part.name_en = 'Symphony no. 1 "O Imprevisto": III. Scherzo: Allegro vivace',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 7855 AND p.composer_id = 105 AND part.part_key = 'musicbrainz:9fea08cf-e201-47fc-bcda-09e1be4e597d' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:9fea08cf-e201-47fc-bcda-09e1be4e597d', 3, 'III', 'Scherzo: Allegro vivace', 'Symphony no. 1 "O Imprevisto": III. Scherzo: Allegro vivace', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 7855 AND p.composer_id = 105
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:9fea08cf-e201-47fc-bcda-09e1be4e597d'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = 'IV',
    part.name_ko = 'Allegro con brio', part.name_en = 'Symphony no. 1 "O Imprevisto": IV. Allegro con brio',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 7855 AND p.composer_id = 105 AND part.part_key = 'musicbrainz:3476f9e4-f379-4504-a011-f83432396bcf' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:3476f9e4-f379-4504-a011-f83432396bcf', 4, 'IV', 'Allegro con brio', 'Symphony no. 1 "O Imprevisto": IV. Allegro con brio', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 7855 AND p.composer_id = 105
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:3476f9e4-f379-4504-a011-f83432396bcf'
);


-- W 511 교향곡 10번 "Amerindia"

UPDATE pieces piece
SET piece.title = '교향곡 10번 "Amerindia"', piece.title_en = 'Symphony no. 10 "Amerindia", W511',
    piece.type = 'album', piece.opus_number = 'W 511',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 10436 AND piece.composer_id = 105
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'Allegro', part.name_en = 'Symphony no. 10 "Amerindia", W511: I. Allegro',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 10436 AND p.composer_id = 105 AND part.part_key = 'musicbrainz:27b28e1c-3c68-4d79-950c-034644261b60' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:27b28e1c-3c68-4d79-950c-034644261b60', 1, 'I', 'Allegro', 'Symphony no. 10 "Amerindia", W511: I. Allegro', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 10436 AND p.composer_id = 105
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:27b28e1c-3c68-4d79-950c-034644261b60'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'Lento', part.name_en = 'Symphony no. 10 "Amerindia", W511: II. Lento',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 10436 AND p.composer_id = 105 AND part.part_key = 'musicbrainz:ecb01a1d-3783-4a91-b95d-59ff057cc66b' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:ecb01a1d-3783-4a91-b95d-59ff057cc66b', 2, 'II', 'Lento', 'Symphony no. 10 "Amerindia", W511: II. Lento', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 10436 AND p.composer_id = 105
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:ecb01a1d-3783-4a91-b95d-59ff057cc66b'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = 'Scherzo allegretto scherzando', part.name_en = 'Symphony no. 10 "Amerindia", W511: III. Scherzo allegretto scherzando',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 10436 AND p.composer_id = 105 AND part.part_key = 'musicbrainz:20d4f8e9-ded8-4ffa-9380-60fcc3c037d3' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:20d4f8e9-ded8-4ffa-9380-60fcc3c037d3', 3, 'III', 'Scherzo allegretto scherzando', 'Symphony no. 10 "Amerindia", W511: III. Scherzo allegretto scherzando', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 10436 AND p.composer_id = 105
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:20d4f8e9-ded8-4ffa-9380-60fcc3c037d3'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = 'IV',
    part.name_ko = 'Lento', part.name_en = 'Symphony no. 10 "Amerindia", W511: IV. Lento',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 10436 AND p.composer_id = 105 AND part.part_key = 'musicbrainz:c7aa8653-e732-4ced-82b1-5e5d884487f2' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:c7aa8653-e732-4ced-82b1-5e5d884487f2', 4, 'IV', 'Lento', 'Symphony no. 10 "Amerindia", W511: IV. Lento', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 10436 AND p.composer_id = 105
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:c7aa8653-e732-4ced-82b1-5e5d884487f2'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 5, part.movement_number = 'V',
    part.name_ko = 'Poco allegro', part.name_en = 'Symphony no. 10 "Amerindia", W511: V. Poco allegro',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 10436 AND p.composer_id = 105 AND part.part_key = 'musicbrainz:5ccd971b-d969-43a5-8559-edf9cbede961' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:5ccd971b-d969-43a5-8559-edf9cbede961', 5, 'V', 'Poco allegro', 'Symphony no. 10 "Amerindia", W511: V. Poco allegro', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 10436 AND p.composer_id = 105
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:5ccd971b-d969-43a5-8559-edf9cbede961'
);


-- None 교향곡 12번

UPDATE pieces piece
SET piece.title = '교향곡 12번', piece.title_en = 'Symphony no. 12',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 9451 AND piece.composer_id = 105
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'Allegro non troppo', part.name_en = 'Symphony no. 12: I. Allegro non troppo',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 9451 AND p.composer_id = 105 AND part.part_key = 'musicbrainz:78e0ae32-651e-48cc-8bdc-b064945d5b63' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:78e0ae32-651e-48cc-8bdc-b064945d5b63', 1, 'I', 'Allegro non troppo', 'Symphony no. 12: I. Allegro non troppo', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 9451 AND p.composer_id = 105
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:78e0ae32-651e-48cc-8bdc-b064945d5b63'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'Adagio', part.name_en = 'Symphony no. 12: II. Adagio',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 9451 AND p.composer_id = 105 AND part.part_key = 'musicbrainz:dfa5bd39-d72e-4e52-bb24-5667910d2b56' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:dfa5bd39-d72e-4e52-bb24-5667910d2b56', 2, 'II', 'Adagio', 'Symphony no. 12: II. Adagio', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 9451 AND p.composer_id = 105
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:dfa5bd39-d72e-4e52-bb24-5667910d2b56'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = 'Scherzo', part.name_en = 'Symphony no. 12: III. Scherzo',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 9451 AND p.composer_id = 105 AND part.part_key = 'musicbrainz:b1cc88ae-3f29-4b15-aa8e-7e48e2ab5303' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:b1cc88ae-3f29-4b15-aa8e-7e48e2ab5303', 3, 'III', 'Scherzo', 'Symphony no. 12: III. Scherzo', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 9451 AND p.composer_id = 105
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:b1cc88ae-3f29-4b15-aa8e-7e48e2ab5303'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = 'IV',
    part.name_ko = 'Molto allegro', part.name_en = 'Symphony no. 12: IV. Molto allegro',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 9451 AND p.composer_id = 105 AND part.part_key = 'musicbrainz:12821fa1-9fe8-4023-afa1-9e613ed34cf4' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:12821fa1-9fe8-4023-afa1-9e613ed34cf4', 4, 'IV', 'Molto allegro', 'Symphony no. 12: IV. Molto allegro', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 9451 AND p.composer_id = 105
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:12821fa1-9fe8-4023-afa1-9e613ed34cf4'
);


-- None 교향곡 2번 "Ascensão"

UPDATE pieces piece
SET piece.title = '교향곡 2번 "Ascensão"', piece.title_en = 'Symphony no. 2 "Ascensão"',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 8154 AND piece.composer_id = 105
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'Allegro non troppo', part.name_en = 'Symphony no. 2 "Ascensão": I. Allegro non troppo',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 8154 AND p.composer_id = 105 AND part.part_key = 'musicbrainz:eaa97217-c4c0-4eed-81d4-3388f3f31959' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:eaa97217-c4c0-4eed-81d4-3388f3f31959', 1, 'I', 'Allegro non troppo', 'Symphony no. 2 "Ascensão": I. Allegro non troppo', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 8154 AND p.composer_id = 105
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:eaa97217-c4c0-4eed-81d4-3388f3f31959'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'Allegretto scherzando', part.name_en = 'Symphony no. 2 "Ascensão": II. Allegretto scherzando',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 8154 AND p.composer_id = 105 AND part.part_key = 'musicbrainz:668b545f-b3b8-44e9-8746-3cbcf5b7e6bd' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:668b545f-b3b8-44e9-8746-3cbcf5b7e6bd', 2, 'II', 'Allegretto scherzando', 'Symphony no. 2 "Ascensão": II. Allegretto scherzando', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 8154 AND p.composer_id = 105
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:668b545f-b3b8-44e9-8746-3cbcf5b7e6bd'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = 'Andante moderato', part.name_en = 'Symphony no. 2 "Ascensão": III. Andante moderato',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 8154 AND p.composer_id = 105 AND part.part_key = 'musicbrainz:00f045d1-5b6c-4a8a-aac3-8a7635e20d56' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:00f045d1-5b6c-4a8a-aac3-8a7635e20d56', 3, 'III', 'Andante moderato', 'Symphony no. 2 "Ascensão": III. Andante moderato', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 8154 AND p.composer_id = 105
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:00f045d1-5b6c-4a8a-aac3-8a7635e20d56'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = 'IV',
    part.name_ko = 'Allegro', part.name_en = 'Symphony no. 2 "Ascensão": IV. Allegro',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 8154 AND p.composer_id = 105 AND part.part_key = 'musicbrainz:c5a62c3f-6545-41c4-a884-5b2705c26d14' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:c5a62c3f-6545-41c4-a884-5b2705c26d14', 4, 'IV', 'Allegro', 'Symphony no. 2 "Ascensão": IV. Allegro', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 8154 AND p.composer_id = 105
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:c5a62c3f-6545-41c4-a884-5b2705c26d14'
);


-- None 교향곡 3번 "War"

UPDATE pieces piece
SET piece.title = '교향곡 3번 "War"', piece.title_en = 'Symphony no. 3 "War"',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 9504 AND piece.composer_id = 105
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'Life and Labour: Allegro quasi giusto', part.name_en = 'Symphony no. 3 "War": I. Life and Labour: Allegro quasi giusto',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 9504 AND p.composer_id = 105 AND part.part_key = 'musicbrainz:c720debb-139f-449c-817a-dd9fdd705508' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:c720debb-139f-449c-817a-dd9fdd705508', 1, 'I', 'Life and Labour: Allegro quasi giusto', 'Symphony no. 3 "War": I. Life and Labour: Allegro quasi giusto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 9504 AND p.composer_id = 105
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:c720debb-139f-449c-817a-dd9fdd705508'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'Intrigues and Rumours: Movimento vivo', part.name_en = 'Symphony no. 3 "War": II. Intrigues and Rumours: Movimento vivo',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 9504 AND p.composer_id = 105 AND part.part_key = 'musicbrainz:893735c7-31f7-4544-ab18-95ef3d6d2b21' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:893735c7-31f7-4544-ab18-95ef3d6d2b21', 2, 'II', 'Intrigues and Rumours: Movimento vivo', 'Symphony no. 3 "War": II. Intrigues and Rumours: Movimento vivo', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 9504 AND p.composer_id = 105
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:893735c7-31f7-4544-ab18-95ef3d6d2b21'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = 'Suffering: Lento e marcial', part.name_en = 'Symphony no. 3 "War": III. Suffering: Lento e marcial',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 9504 AND p.composer_id = 105 AND part.part_key = 'musicbrainz:8c597f81-e8d3-4e54-a028-ca6aedc11a71' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:8c597f81-e8d3-4e54-a028-ca6aedc11a71', 3, 'III', 'Suffering: Lento e marcial', 'Symphony no. 3 "War": III. Suffering: Lento e marcial', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 9504 AND p.composer_id = 105
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:8c597f81-e8d3-4e54-a028-ca6aedc11a71'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = 'IV',
    part.name_ko = 'The Battle: Allegro impetuoso', part.name_en = 'Symphony no. 3 "War": IV. The Battle: Allegro impetuoso',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 9504 AND p.composer_id = 105 AND part.part_key = 'musicbrainz:65e7b473-f5c9-405f-8d6d-2130502b6cff' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:65e7b473-f5c9-405f-8d6d-2130502b6cff', 4, 'IV', 'The Battle: Allegro impetuoso', 'Symphony no. 3 "War": IV. The Battle: Allegro impetuoso', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 9504 AND p.composer_id = 105
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:65e7b473-f5c9-405f-8d6d-2130502b6cff'
);


-- W 153 교향곡 4번 "A Vitória"

UPDATE pieces piece
SET piece.title = '교향곡 4번 "A Vitória"', piece.title_en = 'Symphony no. 4 "A Vitória", W153',
    piece.type = 'album', piece.opus_number = 'W 153',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 8409 AND piece.composer_id = 105
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'Allegro impetuoso', part.name_en = 'Symphony no. 4 "A Vitória", W153: I. Allegro impetuoso',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 8409 AND p.composer_id = 105 AND part.part_key = 'musicbrainz:b2abcc5a-f133-4d8f-9fdc-1edf23c14bbb' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:b2abcc5a-f133-4d8f-9fdc-1edf23c14bbb', 1, 'I', 'Allegro impetuoso', 'Symphony no. 4 "A Vitória", W153: I. Allegro impetuoso', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 8409 AND p.composer_id = 105
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:b2abcc5a-f133-4d8f-9fdc-1edf23c14bbb'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'Andantino', part.name_en = 'Symphony no. 4 "A Vitória", W153: II. Andantino',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 8409 AND p.composer_id = 105 AND part.part_key = 'musicbrainz:b281b051-cd02-4559-b360-39dbf9fbac08' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:b281b051-cd02-4559-b360-39dbf9fbac08', 2, 'II', 'Andantino', 'Symphony no. 4 "A Vitória", W153: II. Andantino', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 8409 AND p.composer_id = 105
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:b281b051-cd02-4559-b360-39dbf9fbac08'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = 'Andante', part.name_en = 'Symphony no. 4 "A Vitória", W153: III. Andante',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 8409 AND p.composer_id = 105 AND part.part_key = 'musicbrainz:a3dff8b5-d59d-4d0e-ac89-48969cf89ad4' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:a3dff8b5-d59d-4d0e-ac89-48969cf89ad4', 3, 'III', 'Andante', 'Symphony no. 4 "A Vitória", W153: III. Andante', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 8409 AND p.composer_id = 105
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:a3dff8b5-d59d-4d0e-ac89-48969cf89ad4'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = 'IV',
    part.name_ko = 'Lento – Allegro', part.name_en = 'Symphony no. 4 "A Vitória", W153: IV. Lento – Allegro',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 8409 AND p.composer_id = 105 AND part.part_key = 'musicbrainz:29e06d6b-eac4-430b-90f6-0b1ea8171a09' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:29e06d6b-eac4-430b-90f6-0b1ea8171a09', 4, 'IV', 'Lento – Allegro', 'Symphony no. 4 "A Vitória", W153: IV. Lento – Allegro', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 8409 AND p.composer_id = 105
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:29e06d6b-eac4-430b-90f6-0b1ea8171a09'
);


-- None 교향곡 6번 "On the Outline of the Mountains of Brazil"

UPDATE pieces piece
SET piece.title = '교향곡 6번 "On the Outline of the Mountains of Brazil"', piece.title_en = 'Symphony no. 6 "On the Outline of the Mountains of Brazil"',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 8203 AND piece.composer_id = 105
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'Allegro non troppo', part.name_en = 'Symphony no. 6 "On the Outline of the Mountains of Brazil": I. Allegro non troppo',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 8203 AND p.composer_id = 105 AND part.part_key = 'musicbrainz:893d345c-f3fe-4557-843a-9207d64a3019' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:893d345c-f3fe-4557-843a-9207d64a3019', 1, 'I', 'Allegro non troppo', 'Symphony no. 6 "On the Outline of the Mountains of Brazil": I. Allegro non troppo', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 8203 AND p.composer_id = 105
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:893d345c-f3fe-4557-843a-9207d64a3019'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'Lento', part.name_en = 'Symphony no. 6 "On the Outline of the Mountains of Brazil": II. Lento',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 8203 AND p.composer_id = 105 AND part.part_key = 'musicbrainz:312bdd99-3d34-4501-acd0-6e854778c089' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:312bdd99-3d34-4501-acd0-6e854778c089', 2, 'II', 'Lento', 'Symphony no. 6 "On the Outline of the Mountains of Brazil": II. Lento', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 8203 AND p.composer_id = 105
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:312bdd99-3d34-4501-acd0-6e854778c089'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = 'Allegretto quasi animato', part.name_en = 'Symphony no. 6 "On the Outline of the Mountains of Brazil": III. Allegretto quasi animato',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 8203 AND p.composer_id = 105 AND part.part_key = 'musicbrainz:493c9839-de24-4577-9cce-676bd5686c7f' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:493c9839-de24-4577-9cce-676bd5686c7f', 3, 'III', 'Allegretto quasi animato', 'Symphony no. 6 "On the Outline of the Mountains of Brazil": III. Allegretto quasi animato', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 8203 AND p.composer_id = 105
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:493c9839-de24-4577-9cce-676bd5686c7f'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = 'IV',
    part.name_ko = 'Allegro', part.name_en = 'Symphony no. 6 "On the Outline of the Mountains of Brazil": IV. Allegro',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 8203 AND p.composer_id = 105 AND part.part_key = 'musicbrainz:c4e4ef8a-69f8-4cb7-bbb8-92cb10b8c529' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:c4e4ef8a-69f8-4cb7-bbb8-92cb10b8c529', 4, 'IV', 'Allegro', 'Symphony no. 6 "On the Outline of the Mountains of Brazil": IV. Allegro', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 8203 AND p.composer_id = 105
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:c4e4ef8a-69f8-4cb7-bbb8-92cb10b8c529'
);


-- None 교향곡 7번

UPDATE pieces piece
SET piece.title = '교향곡 7번', piece.title_en = 'Symphony no. 7',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 8321 AND piece.composer_id = 105
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'Allegro vivace', part.name_en = 'Symphony no. 7: I. Allegro vivace',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 8321 AND p.composer_id = 105 AND part.part_key = 'musicbrainz:840b06ee-cc81-4392-b76b-319c52479e80' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:840b06ee-cc81-4392-b76b-319c52479e80', 1, 'I', 'Allegro vivace', 'Symphony no. 7: I. Allegro vivace', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 8321 AND p.composer_id = 105
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:840b06ee-cc81-4392-b76b-319c52479e80'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'Lento', part.name_en = 'Symphony no. 7: II. Lento',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 8321 AND p.composer_id = 105 AND part.part_key = 'musicbrainz:599e2051-5f76-410c-b36c-250664baccb5' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:599e2051-5f76-410c-b36c-250664baccb5', 2, 'II', 'Lento', 'Symphony no. 7: II. Lento', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 8321 AND p.composer_id = 105
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:599e2051-5f76-410c-b36c-250664baccb5'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = 'Scherzo: Allegro non troppo', part.name_en = 'Symphony no. 7: III. Scherzo: Allegro non troppo',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 8321 AND p.composer_id = 105 AND part.part_key = 'musicbrainz:5fc3a872-6927-4825-9526-e24ea23f978e' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:5fc3a872-6927-4825-9526-e24ea23f978e', 3, 'III', 'Scherzo: Allegro non troppo', 'Symphony no. 7: III. Scherzo: Allegro non troppo', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 8321 AND p.composer_id = 105
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:5fc3a872-6927-4825-9526-e24ea23f978e'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = 'IV',
    part.name_ko = 'Allegro preciso', part.name_en = 'Symphony no. 7: IV. Allegro preciso',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 8321 AND p.composer_id = 105 AND part.part_key = 'musicbrainz:0f6f1fce-2285-441a-ab8e-db9b1f673908' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:0f6f1fce-2285-441a-ab8e-db9b1f673908', 4, 'IV', 'Allegro preciso', 'Symphony no. 7: IV. Allegro preciso', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 8321 AND p.composer_id = 105
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:0f6f1fce-2285-441a-ab8e-db9b1f673908'
);


-- W 033 Tarantela

UPDATE pieces piece
SET piece.title = 'Tarantela', piece.title_en = 'Tarantela, W033',
    piece.type = 'song', piece.opus_number = 'W 033',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 8003 AND piece.composer_id = 105
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- W 531 부수음악 <The Emperor Jones>

UPDATE pieces piece
SET piece.title = '부수음악 <The Emperor Jones>', piece.title_en = 'The Emperor Jones, W531',
    piece.type = 'song', piece.opus_number = 'W 531',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 11262 AND piece.composer_id = 105
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None The Tide Came In

UPDATE pieces piece
SET piece.title = 'The Tide Came In', piece.title_en = 'The Tide Came In',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 8514 AND piece.composer_id = 105
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- W 182 Trio

UPDATE pieces piece
SET piece.title = 'Trio', piece.title_en = 'Trio, W182',
    piece.type = 'album', piece.opus_number = 'W 182',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 7762 AND piece.composer_id = 105
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'Animé', part.name_en = 'Trio, W182: I. Animé',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 7762 AND p.composer_id = 105 AND part.part_key = 'musicbrainz:cc69c9f7-4ce0-42a0-9c3c-4419436699e9' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:cc69c9f7-4ce0-42a0-9c3c-4419436699e9', 1, 'I', 'Animé', 'Trio, W182: I. Animé', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 7762 AND p.composer_id = 105
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:cc69c9f7-4ce0-42a0-9c3c-4419436699e9'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'Languissant', part.name_en = 'Trio, W182: II. Languissant',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 7762 AND p.composer_id = 105 AND part.part_key = 'musicbrainz:0262c72e-7664-42b2-bb7a-c5f57b5786a5' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:0262c72e-7664-42b2-bb7a-c5f57b5786a5', 2, 'II', 'Languissant', 'Trio, W182: II. Languissant', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 7762 AND p.composer_id = 105
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:0262c72e-7664-42b2-bb7a-c5f57b5786a5'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = 'Vif', part.name_en = 'Trio, W182: III. Vif',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 7762 AND p.composer_id = 105 AND part.part_key = 'musicbrainz:90dcb3e0-4163-4623-b3df-67b9a5d14709' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:90dcb3e0-4163-4623-b3df-67b9a5d14709', 3, 'III', 'Vif', 'Trio, W182: III. Vif', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 7762 AND p.composer_id = 105
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:90dcb3e0-4163-4623-b3df-67b9a5d14709'
);


-- W 034 Tristorosa

UPDATE pieces piece
SET piece.title = 'Tristorosa', piece.title_en = 'Tristorosa, W034',
    piece.type = 'song', piece.opus_number = 'W 034',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 10303 AND piece.composer_id = 105
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- W 133 Uirapurú

UPDATE pieces piece
SET piece.title = 'Uirapurú', piece.title_en = 'Uirapurú, W133',
    piece.type = 'song', piece.opus_number = 'W 133',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 10673 AND piece.composer_id = 105
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- W 316 Valsa da dor

UPDATE pieces piece
SET piece.title = 'Valsa da dor', piece.title_en = 'Valsa da dor, W316',
    piece.type = 'song', piece.opus_number = 'W 316',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 8539 AND piece.composer_id = 105
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- W 043 Valsa lenta

UPDATE pieces piece
SET piece.title = 'Valsa lenta', piece.title_en = 'Valsa lenta, W043',
    piece.type = 'song', piece.opus_number = 'W 043',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 8884 AND piece.composer_id = 105
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- W 016 Valsa romântica

UPDATE pieces piece
SET piece.title = 'Valsa romântica', piece.title_en = 'Valsa romântica, W016',
    piece.type = 'song', piece.opus_number = 'W 016',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 9824 AND piece.composer_id = 105
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- W 373 Valsa sentimental

UPDATE pieces piece
SET piece.title = 'Valsa sentimental', piece.title_en = 'Valsa sentimental, W373',
    piece.type = 'song', piece.opus_number = 'W 373',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 10087 AND piece.composer_id = 105
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- Op. 17 Valsa-scherzo

UPDATE pieces piece
SET piece.title = 'Valsa-scherzo', piece.title_en = 'Valsa-scherzo, op. 17, W070',
    piece.type = 'song', piece.opus_number = 'Op. 17',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 8976 AND piece.composer_id = 105
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Valse-Chôro

UPDATE pieces piece
SET piece.title = 'Valse-Chôro', piece.title_en = 'Valse-Chôro',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 9533 AND piece.composer_id = 105
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- W 171 바이올린 소나타 3번

UPDATE pieces piece
SET piece.title = '바이올린 소나타 3번', piece.title_en = 'Violin Sonata no. 3, W171',
    piece.type = 'album', piece.opus_number = 'W 171',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 10785 AND piece.composer_id = 105
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'Adagio non troppo', part.name_en = 'Violin Sonata no. 3, W171: I. Adagio non troppo',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 10785 AND p.composer_id = 105 AND part.part_key = 'musicbrainz:80640eba-1557-43a2-95cd-e978c9b44d35' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:80640eba-1557-43a2-95cd-e978c9b44d35', 1, 'I', 'Adagio non troppo', 'Violin Sonata no. 3, W171: I. Adagio non troppo', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 10785 AND p.composer_id = 105
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:80640eba-1557-43a2-95cd-e978c9b44d35'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'Allegro vivace scherzando', part.name_en = 'Violin Sonata no. 3, W171: II. Allegro vivace scherzando',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 10785 AND p.composer_id = 105 AND part.part_key = 'musicbrainz:ace12316-66a3-41df-882c-f9fbb1200e6c' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:ace12316-66a3-41df-882c-f9fbb1200e6c', 2, 'II', 'Allegro vivace scherzando', 'Violin Sonata no. 3, W171: II. Allegro vivace scherzando', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 10785 AND p.composer_id = 105
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:ace12316-66a3-41df-882c-f9fbb1200e6c'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = 'Molto animato e final', part.name_en = 'Violin Sonata no. 3, W171: III. Molto animato e final',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 10785 AND p.composer_id = 105 AND part.part_key = 'musicbrainz:402d2838-8d4d-402b-b230-44f4b3cb52c6' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:402d2838-8d4d-402b-b230-44f4b3cb52c6', 3, 'III', 'Molto animato e final', 'Violin Sonata no. 3, W171: III. Molto animato e final', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 10785 AND p.composer_id = 105
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:402d2838-8d4d-402b-b230-44f4b3cb52c6'
);


-- W 156 오페라 <Zoé> W 156

UPDATE pieces piece
SET piece.title = '오페라 <Zoé> W 156', piece.title_en = 'Zoé, W156',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = 'W', piece.catalogue_number = '156',
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 10565 AND piece.composer_id = 105
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'Ato I', part.name_en = 'Zoé, W156: Ato I',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 10565 AND p.composer_id = 105 AND part.part_key = 'musicbrainz:de3bfc06-4601-4bf0-9086-93298e664624' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:de3bfc06-4601-4bf0-9086-93298e664624', 1, NULL, 'Ato I', 'Zoé, W156: Ato I', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 10565 AND p.composer_id = 105
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:de3bfc06-4601-4bf0-9086-93298e664624'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'Ato II', part.name_en = 'Zoé, W156: Ato II',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 10565 AND p.composer_id = 105 AND part.part_key = 'musicbrainz:65629870-58e1-4869-b1fe-e90f71e7edf4' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:65629870-58e1-4869-b1fe-e90f71e7edf4', 2, NULL, 'Ato II', 'Zoé, W156: Ato II', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 10565 AND p.composer_id = 105
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:65629870-58e1-4869-b1fe-e90f71e7edf4'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = NULL,
    part.name_ko = 'Ato III', part.name_en = 'Zoé, W156: Ato III',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 10565 AND p.composer_id = 105 AND part.part_key = 'musicbrainz:432b2e53-5d0c-4e6c-989b-32347f515c6a' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:432b2e53-5d0c-4e6c-989b-32347f515c6a', 3, NULL, 'Ato III', 'Zoé, W156: Ato III', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 10565 AND p.composer_id = 105
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:432b2e53-5d0c-4e6c-989b-32347f515c6a'
);


-- W 449 Bachianas Brasileiras nº 9

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, 'Bachianas Brasileiras nº 9', 'Bachianas Brasileiras nº 9, W449', 'album', 'W 449', NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 105
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = 'Bachianas Brasileiras nº 9'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '22bbf88f-b7c6-470b-b8a0-5a544e174537'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '22bbf88f-b7c6-470b-b8a0-5a544e174537'
FROM pieces p
WHERE p.composer_id = 105 AND p.title = 'Bachianas Brasileiras nº 9' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '22bbf88f-b7c6-470b-b8a0-5a544e174537'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:df20a6a4-ded6-458b-82e4-3295c712dfe9', 1, 'I', 'Prelúdio', 'Bachianas Brasileiras nº 9, W449: I. Prelúdio', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 105 AND p.title = 'Bachianas Brasileiras nº 9' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:df20a6a4-ded6-458b-82e4-3295c712dfe9'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:61f86420-2bb1-41d0-8eef-934e1eb581e7', 2, 'II', 'Fuga', 'Bachianas Brasileiras nº 9, W449: II. Fuga', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 105 AND p.title = 'Bachianas Brasileiras nº 9' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:61f86420-2bb1-41d0-8eef-934e1eb581e7'
);


-- W 161 Choros nº 1

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, 'Choros nº 1', 'Choros nº 1, W161', 'song', 'W 161', NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 105
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = 'Choros nº 1'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'cc6ce264-f7c0-3dd0-a971-8ec9ae201651'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'cc6ce264-f7c0-3dd0-a971-8ec9ae201651'
FROM pieces p
WHERE p.composer_id = 105 AND p.title = 'Choros nº 1' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'cc6ce264-f7c0-3dd0-a971-8ec9ae201651'
);


-- W 209 Choros nº 10 "Rasga o coração"

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, 'Choros nº 10 "Rasga o coração"', 'Choros nº 10 "Rasga o coração", W209', 'song', 'W 209', NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 105
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = 'Choros nº 10 "Rasga o coração"'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '831c4f1a-e455-48b3-8372-5e3549575f32'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '831c4f1a-e455-48b3-8372-5e3549575f32'
FROM pieces p
WHERE p.composer_id = 105 AND p.title = 'Choros nº 10 "Rasga o coração"' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '831c4f1a-e455-48b3-8372-5e3549575f32'
);


-- W 197 Choros nº 2

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, 'Choros nº 2', 'Choros nº 2, W197', 'song', 'W 197', NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 105
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = 'Choros nº 2'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '9e3d9629-1512-37bd-93e2-d59bed141d3b'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '9e3d9629-1512-37bd-93e2-d59bed141d3b'
FROM pieces p
WHERE p.composer_id = 105 AND p.title = 'Choros nº 2' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '9e3d9629-1512-37bd-93e2-d59bed141d3b'
);


-- W 003 가곡 <Dime perché>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '가곡 <Dime perché>', 'Dime perché, W003', 'song', 'W 003', NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 105
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '가곡 <Dime perché>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'e45a970e-d87f-4e8f-a672-9134a9090b25'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'e45a970e-d87f-4e8f-a672-9134a9090b25'
FROM pieces p
WHERE p.composer_id = 105 AND p.title = '가곡 <Dime perché>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'e45a970e-d87f-4e8f-a672-9134a9090b25'
);


-- W 417 칸타타 <Mandu-Çarará>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '칸타타 <Mandu-Çarará>', 'Mandu-Çarará, W417', 'song', 'W 417', NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 105
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '칸타타 <Mandu-Çarará>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '88f18edc-2a9a-43dd-a1cd-93c36ecd78a8'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '88f18edc-2a9a-43dd-a1cd-93c36ecd78a8'
FROM pieces p
WHERE p.composer_id = 105 AND p.title = '칸타타 <Mandu-Çarará>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '88f18edc-2a9a-43dd-a1cd-93c36ecd78a8'
);


-- W 580 Motivos gregos

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, 'Motivos gregos', 'Motivos gregos, W580', 'song', 'W 580', NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 105
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = 'Motivos gregos'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'd5724409-6ee4-44ff-a7ca-b29392552e00'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'd5724409-6ee4-44ff-a7ca-b29392552e00'
FROM pieces p
WHERE p.composer_id = 105 AND p.title = 'Motivos gregos' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'd5724409-6ee4-44ff-a7ca-b29392552e00'
);


-- None 현악 4중주 5번

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '현악 4중주 5번', 'String Quartet no. 5', 'album', NULL, NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 105
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '현악 4중주 5번'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'a96eaee1-325f-4c6a-98bd-04e33eb3d9db'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'a96eaee1-325f-4c6a-98bd-04e33eb3d9db'
FROM pieces p
WHERE p.composer_id = 105 AND p.title = '현악 4중주 5번' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'a96eaee1-325f-4c6a-98bd-04e33eb3d9db'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:a2a5b2a5-835c-419d-a48d-248198c1ad4a', 1, 'I', 'Poco Andantino - Un poco vivo - Tempo Primo - Lento - Allegro vivace - Vivo - Presto', 'String Quartet №5: I. Poco Andantino - Un poco vivo - Tempo Primo - Lento - Allegro vivace - Vivo - Presto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 105 AND p.title = '현악 4중주 5번' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:a2a5b2a5-835c-419d-a48d-248198c1ad4a'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:c326379c-d07b-4ee7-b4c5-97510cdaa26b', 2, 'II', 'Vivo e energico - Lento - Tempo Primo - Molto lento', 'String Quartet №5: II. Vivo e energico - Lento - Tempo Primo - Molto lento', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 105 AND p.title = '현악 4중주 5번' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:c326379c-d07b-4ee7-b4c5-97510cdaa26b'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:65a65990-5b14-4021-88e6-dccbc4749b35', 3, 'III', 'Andantino - Tempo giusto e ben ritmato - Adagio - Andantino', 'String Quartet №5: III. Andantino - Tempo giusto e ben ritmato - Adagio - Andantino', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 105 AND p.title = '현악 4중주 5번' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:65a65990-5b14-4021-88e6-dccbc4749b35'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:064834a8-33ab-4ae7-b3bd-818cdbbeee89', 4, 'IV', 'Allegro', 'String Quartet №5: IV. Allegro', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 105 AND p.title = '현악 4중주 5번' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:064834a8-33ab-4ae7-b3bd-818cdbbeee89'
);


-- None 교향곡 11번

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '교향곡 11번', 'Symphony no. 11', 'album', NULL, NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 105
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '교향곡 11번'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '164a6ae4-635d-48fe-9348-c4769965aff1'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '164a6ae4-635d-48fe-9348-c4769965aff1'
FROM pieces p
WHERE p.composer_id = 105 AND p.title = '교향곡 11번' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '164a6ae4-635d-48fe-9348-c4769965aff1'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:a19f7888-a795-4b6e-aaa5-27895afddf10', 1, 'I', 'Allegro moderato', 'Symphony no. 11: I. Allegro moderato', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 105 AND p.title = '교향곡 11번' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:a19f7888-a795-4b6e-aaa5-27895afddf10'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:c9624ba3-983d-4c6f-90f9-f2dcc242e742', 2, 'II', 'Largo', 'Symphony no. 11: II. Largo', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 105 AND p.title = '교향곡 11번' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:c9624ba3-983d-4c6f-90f9-f2dcc242e742'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:11970ef6-f52c-4a98-8cf0-5d240774b1f5', 3, 'III', 'Scherzo: Molto vivace', 'Symphony no. 11: III. Scherzo: Molto vivace', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 105 AND p.title = '교향곡 11번' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:11970ef6-f52c-4a98-8cf0-5d240774b1f5'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:9beeddec-9179-4114-8c60-423cc540ae08', 4, 'IV', 'Molto allegro', 'Symphony no. 11: IV. Molto allegro', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 105 AND p.title = '교향곡 11번' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:9beeddec-9179-4114-8c60-423cc540ae08'
);


-- None 교향곡 8번

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '교향곡 8번', 'Symphony no. 8', 'album', NULL, NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 105
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '교향곡 8번'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'b1dd1297-5aed-41ea-820e-a320bdb11f02'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'b1dd1297-5aed-41ea-820e-a320bdb11f02'
FROM pieces p
WHERE p.composer_id = 105 AND p.title = '교향곡 8번' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'b1dd1297-5aed-41ea-820e-a320bdb11f02'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:89b1a86e-b1ae-4927-bc89-3d3aa5e07fce', 1, 'I', 'Andante', 'Symphony no. 8: I. Andante', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 105 AND p.title = '교향곡 8번' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:89b1a86e-b1ae-4927-bc89-3d3aa5e07fce'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:04da87e8-a783-4d38-ad8e-f4022bd32248', 2, 'II', 'Lento assai', 'Symphony no. 8: II. Lento assai', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 105 AND p.title = '교향곡 8번' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:04da87e8-a783-4d38-ad8e-f4022bd32248'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:809d6f9d-616a-4304-bef1-d8a6d53ea6a5', 3, 'III', 'Allegretto scherzando', 'Symphony no. 8: III. Allegretto scherzando', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 105 AND p.title = '교향곡 8번' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:809d6f9d-616a-4304-bef1-d8a6d53ea6a5'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:8178f315-6cf0-4e1c-ad10-86ee276896c4', 4, 'IV', 'Allegro giusto', 'Symphony no. 8: IV. Allegro giusto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 105 AND p.title = '교향곡 8번' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:8178f315-6cf0-4e1c-ad10-86ee276896c4'
);


-- None 교향곡 9번

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '교향곡 9번', 'Symphony no. 9', 'album', NULL, NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 105
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '교향곡 9번'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '1abce880-b63e-46d5-b117-42616c819440'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '1abce880-b63e-46d5-b117-42616c819440'
FROM pieces p
WHERE p.composer_id = 105 AND p.title = '교향곡 9번' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '1abce880-b63e-46d5-b117-42616c819440'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:16cede3c-7377-41bd-9ca3-2bc4f8204ed7', 1, 'I', 'Allegro', 'Symphony no. 9: I. Allegro', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 105 AND p.title = '교향곡 9번' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:16cede3c-7377-41bd-9ca3-2bc4f8204ed7'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:aa100e89-e7e2-467c-90d8-184458591600', 2, 'II', 'Adagio', 'Symphony no. 9: II. Adagio', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 105 AND p.title = '교향곡 9번' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:aa100e89-e7e2-467c-90d8-184458591600'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:10cb8120-6a48-41c4-9acc-3819a9762fbb', 3, 'III', 'Scherzo: Vivace', 'Symphony no. 9: III. Scherzo: Vivace', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 105 AND p.title = '교향곡 9번' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:10cb8120-6a48-41c4-9acc-3819a9762fbb'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:d4d5f241-bfdc-4f32-9ff2-82f092c55c44', 4, 'IV', 'Allegro giusto', 'Symphony no. 9: IV. Allegro giusto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 105 AND p.title = '교향곡 9번' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:d4d5f241-bfdc-4f32-9ff2-82f092c55c44'
);


-- Op. 87 엘레지

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '엘레지', 'Élégie, op. 87, W094', 'song', 'Op. 87', NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 105
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '엘레지'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '82dea84d-21dd-404d-8d0e-89bdb9757945'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '82dea84d-21dd-404d-8d0e-89bdb9757945'
FROM pieces p
WHERE p.composer_id = 105 AND p.title = '엘레지' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '82dea84d-21dd-404d-8d0e-89bdb9757945'
);


-- 카탈로그에 대응이 없는 seed 작품 48개를 목록에서 숨긴다(지우지 않음).
UPDATE pieces piece
SET piece.hidden_reason = 'catalog_unmatched'
WHERE piece.composer_id = 105 AND piece.origin = 'seed' AND piece.hidden_reason IS NULL
  AND piece.id IN (
    7616, 7777, 7820, 7889, 7891, 7977, 8091, 8092, 8129, 8405, 8508, 8545, 8607, 8698, 8710, 8728, 8990, 9066, 9127, 9247,
    9478, 9573, 9575, 9625, 9668, 9717, 9769, 9837, 9849, 9886, 9896, 9914, 9935, 9946, 9960, 10050, 10080, 10198, 10229, 10385,
    10462, 10742, 10753, 10773, 10838, 10931, 11006, 11186
  )
  AND NOT EXISTS (SELECT 1 FROM performance_sectors sector WHERE sector.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM piece_parts linking WHERE linking.linked_piece_id = piece.id);
