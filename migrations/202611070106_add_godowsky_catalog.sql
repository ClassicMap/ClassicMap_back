-- 레오폴드 고도프스키 작품을 MusicBrainz 작품 구조로 다시 짠다(5차 자동). 작품 28개(묶음 11, 다악장 3, 낱곡 14),
-- 새 작품 0개, part 118개, 그 아래 0개.
-- seed 52개 중 28개를 작품·part 에 잇고, 11개를 숨기고, 13개는 그대로 둔다.
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

-- 숨길 seed 가 쥔 카탈로그 제목을 비운다
UPDATE pieces piece
SET piece.title = '6 Waltz-Poems (중복 19834)'
WHERE piece.id = 19834 AND piece.composer_id = 331 AND piece.title = '6 Waltz-Poems'
  AND piece.origin = 'seed' AND piece.editor_locked = 0
  AND NOT EXISTS (SELECT 1 FROM performance_sectors sector WHERE sector.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM piece_parts linking WHERE linking.linked_piece_id = piece.id);


-- None 12 Impressions for Violin and Piano

UPDATE pieces piece
SET piece.title = '12 Impressions for Violin and Piano', piece.title_en = '12 Impressions for Violin and Piano',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 16709 AND piece.composer_id = 331
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'Larghetto lamentoso', part.name_en = '12 Impressions for Violin and Piano: Larghetto lamentoso',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 16709 AND p.composer_id = 331 AND part.part_key = 'musicbrainz:8a7bf39b-d737-44bc-aed8-76e0da9cb8d0' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:8a7bf39b-d737-44bc-aed8-76e0da9cb8d0', 1, NULL, 'Larghetto lamentoso', '12 Impressions for Violin and Piano: Larghetto lamentoso', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 16709 AND p.composer_id = 331
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:8a7bf39b-d737-44bc-aed8-76e0da9cb8d0'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'Profile (Chopin)', part.name_en = '12 Impressions for Violin and Piano: Profile (Chopin)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 16709 AND p.composer_id = 331 AND part.part_key = 'musicbrainz:b00883bf-92f6-4368-bfa2-ca24e08427f4' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:b00883bf-92f6-4368-bfa2-ca24e08427f4', 2, NULL, 'Profile (Chopin)', '12 Impressions for Violin and Piano: Profile (Chopin)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 16709 AND p.composer_id = 331
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:b00883bf-92f6-4368-bfa2-ca24e08427f4'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = NULL,
    part.name_ko = 'Légende', part.name_en = '12 Impressions for Violin and Piano: Légende',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 16709 AND p.composer_id = 331 AND part.part_key = 'musicbrainz:f1c583ed-25e9-486e-bd79-2e3223969429' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:f1c583ed-25e9-486e-bd79-2e3223969429', 3, NULL, 'Légende', '12 Impressions for Violin and Piano: Légende', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 16709 AND p.composer_id = 331
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:f1c583ed-25e9-486e-bd79-2e3223969429'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = NULL,
    part.name_ko = 'Tyrolean (Schuhplattler)', part.name_en = '12 Impressions for Violin and Piano: Tyrolean (Schuhplattler)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 16709 AND p.composer_id = 331 AND part.part_key = 'musicbrainz:f03206ba-aadc-4dbc-b4d9-85197d3664cb' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:f03206ba-aadc-4dbc-b4d9-85197d3664cb', 4, NULL, 'Tyrolean (Schuhplattler)', '12 Impressions for Violin and Piano: Tyrolean (Schuhplattler)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 16709 AND p.composer_id = 331
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:f03206ba-aadc-4dbc-b4d9-85197d3664cb'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 5, part.movement_number = NULL,
    part.name_ko = 'Poème (Andante cantabile)', part.name_en = '12 Impressions for Violin and Piano: Poème (Andante cantabile)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 16709 AND p.composer_id = 331 AND part.part_key = 'musicbrainz:ac659a07-d4cb-4e05-a726-8f735dfe65fc' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:ac659a07-d4cb-4e05-a726-8f735dfe65fc', 5, NULL, 'Poème (Andante cantabile)', '12 Impressions for Violin and Piano: Poème (Andante cantabile)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 16709 AND p.composer_id = 331
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:ac659a07-d4cb-4e05-a726-8f735dfe65fc'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 6, part.movement_number = NULL,
    part.name_ko = 'Perpetuum mobile', part.name_en = '12 Impressions for Violin and Piano: Perpetuum mobile',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 16709 AND p.composer_id = 331 AND part.part_key = 'musicbrainz:0a967829-b866-4152-8f70-89c3a0184673' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:0a967829-b866-4152-8f70-89c3a0184673', 6, NULL, 'Perpetuum mobile', '12 Impressions for Violin and Piano: Perpetuum mobile', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 16709 AND p.composer_id = 331
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:0a967829-b866-4152-8f70-89c3a0184673'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 7, part.movement_number = NULL,
    part.name_ko = 'Élégie', part.name_en = '12 Impressions for Violin and Piano: Élégie',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 16709 AND p.composer_id = 331 AND part.part_key = 'musicbrainz:ed95c786-4944-4a70-8477-5b3dcfb95ce5' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:ed95c786-4944-4a70-8477-5b3dcfb95ce5', 7, NULL, 'Élégie', '12 Impressions for Violin and Piano: Élégie', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 16709 AND p.composer_id = 331
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:ed95c786-4944-4a70-8477-5b3dcfb95ce5'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 8, part.movement_number = NULL,
    part.name_ko = 'Valse', part.name_en = '12 Impressions for Violin and Piano: Valse',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 16709 AND p.composer_id = 331 AND part.part_key = 'musicbrainz:8eabadbb-623a-4752-af74-292cf9399394' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:8eabadbb-623a-4752-af74-292cf9399394', 8, NULL, 'Valse', '12 Impressions for Violin and Piano: Valse', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 16709 AND p.composer_id = 331
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:8eabadbb-623a-4752-af74-292cf9399394'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 9, part.movement_number = NULL,
    part.name_ko = 'Valse macabre', part.name_en = '12 Impressions for Violin and Piano: Valse macabre',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 16709 AND p.composer_id = 331 AND part.part_key = 'musicbrainz:821a0d18-e255-4f31-926f-797ccbe9041d' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:821a0d18-e255-4f31-926f-797ccbe9041d', 9, NULL, 'Valse macabre', '12 Impressions for Violin and Piano: Valse macabre', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 16709 AND p.composer_id = 331
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:821a0d18-e255-4f31-926f-797ccbe9041d'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 10, part.movement_number = NULL,
    part.name_ko = 'Oriental', part.name_en = '12 Impressions for Violin and Piano: Oriental',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 16709 AND p.composer_id = 331 AND part.part_key = 'musicbrainz:17f8463c-1149-4dcc-bd4b-f09211fcb7d9' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:17f8463c-1149-4dcc-bd4b-f09211fcb7d9', 10, NULL, 'Oriental', '12 Impressions for Violin and Piano: Oriental', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 16709 AND p.composer_id = 331
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:17f8463c-1149-4dcc-bd4b-f09211fcb7d9'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 11, part.movement_number = NULL,
    part.name_ko = 'Saga', part.name_en = '12 Impressions for Violin and Piano: Saga',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 16709 AND p.composer_id = 331 AND part.part_key = 'musicbrainz:c5eab383-b3a8-4281-b37f-5e2e6bd7c6f6' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:c5eab383-b3a8-4281-b37f-5e2e6bd7c6f6', 11, NULL, 'Saga', '12 Impressions for Violin and Piano: Saga', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 16709 AND p.composer_id = 331
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:c5eab383-b3a8-4281-b37f-5e2e6bd7c6f6'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 12, part.movement_number = NULL,
    part.name_ko = 'Viennese (Wienerisch)', part.name_en = '12 Impressions for Violin and Piano: Viennese (Wienerisch)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 16709 AND p.composer_id = 331 AND part.part_key = 'musicbrainz:71d55056-aa5d-44b8-8f7c-9f19e4eae575' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:71d55056-aa5d-44b8-8f7c-9f19e4eae575', 12, NULL, 'Viennese (Wienerisch)', '12 Impressions for Violin and Piano: Viennese (Wienerisch)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 16709 AND p.composer_id = 331
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:71d55056-aa5d-44b8-8f7c-9f19e4eae575'
);


-- Op. 15 3개의 소품 Op. 15

UPDATE pieces piece
SET piece.title = '3개의 소품 Op. 15', piece.title_en = '3 Pieces, op. 15',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = 'Op.', piece.catalogue_number = '15',
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 16830 AND piece.composer_id = 331
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'Mélodie méditative, op. 15 no. 1', part.name_en = 'Mélodie méditative, op. 15 no. 1',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 16830 AND p.composer_id = 331 AND part.part_key = 'musicbrainz:ab9d5318-f275-42d2-b1be-3788002a639c' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:ab9d5318-f275-42d2-b1be-3788002a639c', 1, NULL, 'Mélodie méditative, op. 15 no. 1', 'Mélodie méditative, op. 15 no. 1', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 16830 AND p.composer_id = 331
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:ab9d5318-f275-42d2-b1be-3788002a639c'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'Frühlingsnacht, op. 15 no. 2', part.name_en = 'Frühlingsnacht, op. 15 no. 2',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 16830 AND p.composer_id = 331 AND part.part_key = 'musicbrainz:d66aa4bf-f40d-4bf8-b425-311201eb509e' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:d66aa4bf-f40d-4bf8-b425-311201eb509e', 2, NULL, 'Frühlingsnacht, op. 15 no. 2', 'Frühlingsnacht, op. 15 no. 2', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 16830 AND p.composer_id = 331
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:d66aa4bf-f40d-4bf8-b425-311201eb509e'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = NULL,
    part.name_ko = 'Capriccio, op. 15 no. 3', part.name_en = 'Capriccio, op. 15 no. 3',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 16830 AND p.composer_id = 331 AND part.part_key = 'musicbrainz:d271ce74-4e56-48e3-abb5-958e4dcea767' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:d271ce74-4e56-48e3-abb5-958e4dcea767', 3, NULL, 'Capriccio, op. 15 no. 3', 'Capriccio, op. 15 no. 3', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 16830 AND p.composer_id = 331
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:d271ce74-4e56-48e3-abb5-958e4dcea767'
);


-- Op. 16 4개의 소품 Op. 16

UPDATE pieces piece
SET piece.title = '4개의 소품 Op. 16', piece.title_en = '4 Pieces, op.16',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = 'Op.', piece.catalogue_number = '16',
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 19047 AND piece.composer_id = 331
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'Arabesque, op. 16 no. 2', part.name_en = 'Arabesque, op. 16 no. 2',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 19047 AND p.composer_id = 331 AND part.part_key = 'musicbrainz:43d90f87-dca1-4b44-b221-79b19276ffd3' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:43d90f87-dca1-4b44-b221-79b19276ffd3', 1, NULL, 'Arabesque, op. 16 no. 2', 'Arabesque, op. 16 no. 2', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 19047 AND p.composer_id = 331
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:43d90f87-dca1-4b44-b221-79b19276ffd3'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'Barcarolle-Valse, op. 16 no. 4', part.name_en = 'Barcarolle-Valse, op. 16 no. 4',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 19047 AND p.composer_id = 331 AND part.part_key = 'musicbrainz:99cb772f-d8a2-4e13-b9bf-48beb42bf78d' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:99cb772f-d8a2-4e13-b9bf-48beb42bf78d', 2, NULL, 'Barcarolle-Valse, op. 16 no. 4', 'Barcarolle-Valse, op. 16 no. 4', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 19047 AND p.composer_id = 331
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:99cb772f-d8a2-4e13-b9bf-48beb42bf78d'
);


-- None 6 Waltz-Poems

UPDATE pieces piece
SET piece.title = '6 Waltz-Poems', piece.title_en = '6 Waltz-Poems',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 16033 AND piece.composer_id = 331
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'B♭장조', part.name_en = '6 Waltz-Poems: No. 2 in B-flat major',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 16033 AND p.composer_id = 331 AND part.part_key = 'musicbrainz:fa605530-c6dc-444a-b00d-272c7c07f494' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:fa605530-c6dc-444a-b00d-272c7c07f494', 1, NULL, 'B♭장조', '6 Waltz-Poems: No. 2 in B-flat major', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 16033 AND p.composer_id = 331
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:fa605530-c6dc-444a-b00d-272c7c07f494'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'G장조', part.name_en = '6 Waltz-Poems: No. 3 in G major',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 16033 AND p.composer_id = 331 AND part.part_key = 'musicbrainz:c44529c6-bf4c-4d90-8028-ebc828a6e747' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:c44529c6-bf4c-4d90-8028-ebc828a6e747', 2, NULL, 'G장조', '6 Waltz-Poems: No. 3 in G major', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 16033 AND p.composer_id = 331
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:c44529c6-bf4c-4d90-8028-ebc828a6e747'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = NULL,
    part.name_ko = 'E♭장조', part.name_en = '6 Waltz-Poems: No. 4 in E-flat major',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 16033 AND p.composer_id = 331 AND part.part_key = 'musicbrainz:d1c945c7-7e45-41fc-af99-6085bdf5e7b5' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:d1c945c7-7e45-41fc-af99-6085bdf5e7b5', 3, NULL, 'E♭장조', '6 Waltz-Poems: No. 4 in E-flat major', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 16033 AND p.composer_id = 331
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:d1c945c7-7e45-41fc-af99-6085bdf5e7b5'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = NULL,
    part.name_ko = 'C장조', part.name_en = '6 Waltz-Poems: No. 6 in C major',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 16033 AND p.composer_id = 331 AND part.part_key = 'musicbrainz:8ce635ab-8e47-4d98-a681-7c3ce8b48e0c' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:8ce635ab-8e47-4d98-a681-7c3ce8b48e0c', 4, NULL, 'C장조', '6 Waltz-Poems: No. 6 in C major', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 16033 AND p.composer_id = 331
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:8ce635ab-8e47-4d98-a681-7c3ce8b48e0c'
);


-- Op. 12 No. 3 쿠랑트

UPDATE pieces piece
SET piece.title = '쿠랑트', piece.title_en = 'Courante, op. 12 no. 3',
    piece.type = 'song', piece.opus_number = 'Op. 12 No. 3',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 18826 AND piece.composer_id = 331
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Elegy for the left hand alone

UPDATE pieces piece
SET piece.title = 'Elegy for the left hand alone', piece.title_en = 'Elegy for the left hand alone',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 16237 AND piece.composer_id = 331
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- Op. 14 4개의 소품 Op. 14

UPDATE pieces piece
SET piece.title = '4개의 소품 Op. 14', piece.title_en = 'Four Pieces, op. 14',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = 'Op.', piece.catalogue_number = '14',
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 16807 AND piece.composer_id = 331
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'Ein Dämmerungsbild, op. 14 no. 1', part.name_en = 'Ein Dämmerungsbild, op. 14 no. 1',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 16807 AND p.composer_id = 331 AND part.part_key = 'musicbrainz:a861b185-d947-4b89-ad75-09363fcbbdca' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:a861b185-d947-4b89-ad75-09363fcbbdca', 1, NULL, 'Ein Dämmerungsbild, op. 14 no. 1', 'Ein Dämmerungsbild, op. 14 no. 1', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 16807 AND p.composer_id = 331
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:a861b185-d947-4b89-ad75-09363fcbbdca'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'Valse-Idylle, op. 14 no. 3', part.name_en = 'Valse-Idylle, op. 14 no. 3',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 16807 AND p.composer_id = 331 AND part.part_key = 'musicbrainz:bf81c1eb-a448-4a64-865b-45a43abed145' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:bf81c1eb-a448-4a64-865b-45a43abed145', 2, NULL, 'Valse-Idylle, op. 14 no. 3', 'Valse-Idylle, op. 14 no. 3', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 16807 AND p.composer_id = 331
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:bf81c1eb-a448-4a64-865b-45a43abed145'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = NULL,
    part.name_ko = 'Scherzino, op. 14 no. 4', part.name_en = 'Scherzino, op. 14 no. 4',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 16807 AND p.composer_id = 331 AND part.part_key = 'musicbrainz:5238d39b-bc7e-4137-a096-539c4f56e515' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:5238d39b-bc7e-4137-a096-539c4f56e515', 3, NULL, 'Scherzino, op. 14 no. 4', 'Scherzino, op. 14 no. 4', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 16807 AND p.composer_id = 331
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:5238d39b-bc7e-4137-a096-539c4f56e515'
);


-- None Four Poems

UPDATE pieces piece
SET piece.title = 'Four Poems', piece.title_en = 'Four Poems',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 18064 AND piece.composer_id = 331
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'Devotion', part.name_en = 'Four Poems: No. 1. Devotion',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 18064 AND p.composer_id = 331 AND part.part_key = 'musicbrainz:ebbf9835-5ac2-4539-bebf-7718fef3607d' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:ebbf9835-5ac2-4539-bebf-7718fef3607d', 1, NULL, 'Devotion', 'Four Poems: No. 1. Devotion', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 18064 AND p.composer_id = 331
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:ebbf9835-5ac2-4539-bebf-7718fef3607d'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'Avowal', part.name_en = 'Four Poems: No. 2. Avowal',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 18064 AND p.composer_id = 331 AND part.part_key = 'musicbrainz:eb3e460c-0d7c-463b-b133-f23885552c4c' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:eb3e460c-0d7c-463b-b133-f23885552c4c', 2, NULL, 'Avowal', 'Four Poems: No. 2. Avowal', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 18064 AND p.composer_id = 331
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:eb3e460c-0d7c-463b-b133-f23885552c4c'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = NULL,
    part.name_ko = 'Adoration', part.name_en = 'Four Poems: No. 3. Adoration',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 18064 AND p.composer_id = 331 AND part.part_key = 'musicbrainz:ee344b2a-0e24-45a7-933e-6e62120bcc96' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:ee344b2a-0e24-45a7-933e-6e62120bcc96', 3, NULL, 'Adoration', 'Four Poems: No. 3. Adoration', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 18064 AND p.composer_id = 331
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:ee344b2a-0e24-45a7-933e-6e62120bcc96'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = NULL,
    part.name_ko = 'Yearning', part.name_en = 'Four Poems: No. 4. Yearning',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 18064 AND p.composer_id = 331 AND part.part_key = 'musicbrainz:ccf60968-1440-4946-b53a-c80ab26105de' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:ccf60968-1440-4946-b53a-c80ab26105de', 4, NULL, 'Yearning', 'Four Poems: No. 4. Yearning', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 18064 AND p.composer_id = 331
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:ccf60968-1440-4946-b53a-c80ab26105de'
);


-- None Grande Valse romantique

UPDATE pieces piece
SET piece.title = 'Grande Valse romantique', piece.title_en = 'Grande Valse romantique',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 20078 AND piece.composer_id = 331
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Java Suite

UPDATE pieces piece
SET piece.title = 'Java Suite', piece.title_en = 'Java Suite',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 18273 AND piece.composer_id = 331
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'Part I: Gamelan', part.name_en = 'Java Suite, Part I: Gamelan',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 18273 AND p.composer_id = 331 AND part.part_key = 'musicbrainz:9708a190-c777-4010-94f0-6584fda2d7dd' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:9708a190-c777-4010-94f0-6584fda2d7dd', 1, NULL, 'Part I: Gamelan', 'Java Suite, Part I: Gamelan', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 18273 AND p.composer_id = 331
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:9708a190-c777-4010-94f0-6584fda2d7dd'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'Part I: Wayang-Purwa: Puppet Shadow Plays', part.name_en = 'Java Suite, Part I: Wayang-Purwa: Puppet Shadow Plays',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 18273 AND p.composer_id = 331 AND part.part_key = 'musicbrainz:0384b0a3-1b91-49a0-9313-c9497d3ccf52' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:0384b0a3-1b91-49a0-9313-c9497d3ccf52', 2, NULL, 'Part I: Wayang-Purwa: Puppet Shadow Plays', 'Java Suite, Part I: Wayang-Purwa: Puppet Shadow Plays', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 18273 AND p.composer_id = 331
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:0384b0a3-1b91-49a0-9313-c9497d3ccf52'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = NULL,
    part.name_ko = 'Part I: Hari Besaar: The Great Day', part.name_en = 'Java Suite, Part I: Hari Besaar: The Great Day',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 18273 AND p.composer_id = 331 AND part.part_key = 'musicbrainz:79681772-3eaa-471c-8a66-79f23e6548c7' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:79681772-3eaa-471c-8a66-79f23e6548c7', 3, NULL, 'Part I: Hari Besaar: The Great Day', 'Java Suite, Part I: Hari Besaar: The Great Day', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 18273 AND p.composer_id = 331
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:79681772-3eaa-471c-8a66-79f23e6548c7'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = NULL,
    part.name_ko = 'Part II: Chattering Monkeys at the Sacred Lake of Wendit', part.name_en = 'Java Suite, Part II: Chattering Monkeys at the Sacred Lake of Wendit',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 18273 AND p.composer_id = 331 AND part.part_key = 'musicbrainz:5c165961-3e5c-4a26-a821-984ffb3b19a4' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:5c165961-3e5c-4a26-a821-984ffb3b19a4', 4, NULL, 'Part II: Chattering Monkeys at the Sacred Lake of Wendit', 'Java Suite, Part II: Chattering Monkeys at the Sacred Lake of Wendit', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 18273 AND p.composer_id = 331
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:5c165961-3e5c-4a26-a821-984ffb3b19a4'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 5, part.movement_number = NULL,
    part.name_ko = 'Part II: Boro Budur in Moonlight', part.name_en = 'Java Suite, Part II: Boro Budur in Moonlight',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 18273 AND p.composer_id = 331 AND part.part_key = 'musicbrainz:ae4d90aa-611b-4296-b9a2-7643f4da1940' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:ae4d90aa-611b-4296-b9a2-7643f4da1940', 5, NULL, 'Part II: Boro Budur in Moonlight', 'Java Suite, Part II: Boro Budur in Moonlight', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 18273 AND p.composer_id = 331
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:ae4d90aa-611b-4296-b9a2-7643f4da1940'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 6, part.movement_number = NULL,
    part.name_ko = 'Part II: The Bromo Volcano and the Sand Sea at Daybreak', part.name_en = 'Java Suite, Part II: The Bromo Volcano and the Sand Sea at Daybreak',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 18273 AND p.composer_id = 331 AND part.part_key = 'musicbrainz:bbf53d19-884f-4df8-9619-44d23f776848' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:bbf53d19-884f-4df8-9619-44d23f776848', 6, NULL, 'Part II: The Bromo Volcano and the Sand Sea at Daybreak', 'Java Suite, Part II: The Bromo Volcano and the Sand Sea at Daybreak', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 18273 AND p.composer_id = 331
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:bbf53d19-884f-4df8-9619-44d23f776848'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 7, part.movement_number = NULL,
    part.name_ko = 'Part III: Three Dances', part.name_en = 'Java Suite, Part III: Three Dances',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 18273 AND p.composer_id = 331 AND part.part_key = 'musicbrainz:930919bd-35b0-4533-88b5-c379b28bed54' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:930919bd-35b0-4533-88b5-c379b28bed54', 7, NULL, 'Part III: Three Dances', 'Java Suite, Part III: Three Dances', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 18273 AND p.composer_id = 331
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:930919bd-35b0-4533-88b5-c379b28bed54'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 8, part.movement_number = NULL,
    part.name_ko = 'Part III: The Gardens of Buitenzorg', part.name_en = 'Java Suite, Part III: The Gardens of Buitenzorg',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 18273 AND p.composer_id = 331 AND part.part_key = 'musicbrainz:a1032b7d-b9df-46f1-b041-1fae65e25776' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:a1032b7d-b9df-46f1-b041-1fae65e25776', 8, NULL, 'Part III: The Gardens of Buitenzorg', 'Java Suite, Part III: The Gardens of Buitenzorg', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 18273 AND p.composer_id = 331
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:a1032b7d-b9df-46f1-b041-1fae65e25776'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 9, part.movement_number = NULL,
    part.name_ko = 'Part III: In the Streets of Old Batavia', part.name_en = 'Java Suite, Part III: In the Streets of Old Batavia',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 18273 AND p.composer_id = 331 AND part.part_key = 'musicbrainz:12d48296-c061-4038-bd09-ae9dbeb1222a' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:12d48296-c061-4038-bd09-ae9dbeb1222a', 9, NULL, 'Part III: In the Streets of Old Batavia', 'Java Suite, Part III: In the Streets of Old Batavia', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 18273 AND p.composer_id = 331
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:12d48296-c061-4038-bd09-ae9dbeb1222a'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 10, part.movement_number = NULL,
    part.name_ko = 'Part IV: In the Kraton', part.name_en = 'Java Suite, Part IV: In the Kraton',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 18273 AND p.composer_id = 331 AND part.part_key = 'musicbrainz:a4f218ee-e982-4df7-875d-dc63ffa32913' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:a4f218ee-e982-4df7-875d-dc63ffa32913', 10, NULL, 'Part IV: In the Kraton', 'Java Suite, Part IV: In the Kraton', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 18273 AND p.composer_id = 331
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:a4f218ee-e982-4df7-875d-dc63ffa32913'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 11, part.movement_number = NULL,
    part.name_ko = 'Part IV: In the Ruined Water Castle at Djokja', part.name_en = 'Java Suite, Part IV: In the Ruined Water Castle at Djokja',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 18273 AND p.composer_id = 331 AND part.part_key = 'musicbrainz:81680654-c052-454c-823b-7f8773f92270' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:81680654-c052-454c-823b-7f8773f92270', 11, NULL, 'Part IV: In the Ruined Water Castle at Djokja', 'Java Suite, Part IV: In the Ruined Water Castle at Djokja', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 18273 AND p.composer_id = 331
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:81680654-c052-454c-823b-7f8773f92270'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 12, part.movement_number = NULL,
    part.name_ko = 'Part IV: A Court Pageant in Solo', part.name_en = 'Java Suite, Part IV: A Court Pageant in Solo',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 18273 AND p.composer_id = 331 AND part.part_key = 'musicbrainz:f404d790-05fd-4cd8-8948-a86e6b6d82d4' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:f404d790-05fd-4cd8-8948-a86e6b6d82d4', 12, NULL, 'Part IV: A Court Pageant in Solo', 'Java Suite, Part IV: A Court Pageant in Solo', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 18273 AND p.composer_id = 331
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:f404d790-05fd-4cd8-8948-a86e6b6d82d4'
);


-- None 미뉴에트 1번 E장조

UPDATE pieces piece
SET piece.title = '미뉴에트 1번 E장조', piece.title_en = 'Menuet no. 1 in E major',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 17750 AND piece.composer_id = 331
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- Op. 12 No. 2 미뉴에트

UPDATE pieces piece
SET piece.title = '미뉴에트', piece.title_en = 'Menuet, op. 12 no. 2',
    piece.type = 'song', piece.opus_number = 'Op. 12 No. 2',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 19588 AND piece.composer_id = 331
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Moto perpetuo

UPDATE pieces piece
SET piece.title = 'Moto perpetuo', piece.title_en = 'Moto perpetuo',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 16723 AND piece.composer_id = 331
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Märchen

UPDATE pieces piece
SET piece.title = 'Märchen', piece.title_en = 'Märchen',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 19273 AND piece.composer_id = 331
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None 피아노 소나타 E단조

UPDATE pieces piece
SET piece.title = '피아노 소나타 E단조', piece.title_en = 'Piano Sonata in E minor',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 15922 AND piece.composer_id = 331
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'Allegro no troppo, ma appassionato', part.name_en = 'Piano Sonata in E minor: I. Allegro no troppo, ma appassionato',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 15922 AND p.composer_id = 331 AND part.part_key = 'musicbrainz:8b108a15-ff3c-42b2-897f-fc388275c4e5' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:8b108a15-ff3c-42b2-897f-fc388275c4e5', 1, 'I', 'Allegro no troppo, ma appassionato', 'Piano Sonata in E minor: I. Allegro no troppo, ma appassionato', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 15922 AND p.composer_id = 331
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:8b108a15-ff3c-42b2-897f-fc388275c4e5'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'Andante cantabile', part.name_en = 'Piano Sonata in E minor: II. Andante cantabile',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 15922 AND p.composer_id = 331 AND part.part_key = 'musicbrainz:d8bb1d3b-46f7-4844-8fc1-174357a4518d' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:d8bb1d3b-46f7-4844-8fc1-174357a4518d', 2, 'II', 'Andante cantabile', 'Piano Sonata in E minor: II. Andante cantabile', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 15922 AND p.composer_id = 331
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:d8bb1d3b-46f7-4844-8fc1-174357a4518d'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = 'Allegro vivace e scherzando', part.name_en = 'Piano Sonata in E minor: III. Allegro vivace e scherzando',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 15922 AND p.composer_id = 331 AND part.part_key = 'musicbrainz:f3322bae-b014-4f59-b23d-7817f390dae5' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:f3322bae-b014-4f59-b23d-7817f390dae5', 3, 'III', 'Allegro vivace e scherzando', 'Piano Sonata in E minor: III. Allegro vivace e scherzando', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 15922 AND p.composer_id = 331
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:f3322bae-b014-4f59-b23d-7817f390dae5'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = 'IV',
    part.name_ko = 'Allegretto grazioso e dolce', part.name_en = 'Piano Sonata in E minor: IV. Allegretto grazioso e dolce',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 15922 AND p.composer_id = 331 AND part.part_key = 'musicbrainz:aa273b89-72b9-4883-ae68-9d558508b31f' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:aa273b89-72b9-4883-ae68-9d558508b31f', 4, 'IV', 'Allegretto grazioso e dolce', 'Piano Sonata in E minor: IV. Allegretto grazioso e dolce', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 15922 AND p.composer_id = 331
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:aa273b89-72b9-4883-ae68-9d558508b31f'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 5, part.movement_number = 'V',
    part.name_ko = 'Retrospect. Lento, mesto - Larghetto lamentoso - Fuga, Molto espressivo - Maestoso, lugubre', part.name_en = 'Piano Sonata in E minor: V. Retrospect. Lento, mesto - Larghetto lamentoso - Fuga, Molto espressivo - Maestoso, lugubre',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 15922 AND p.composer_id = 331 AND part.part_key = 'musicbrainz:d22341a2-7ad7-4a2f-ab29-727c8e6e5c23' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:d22341a2-7ad7-4a2f-ab29-727c8e6e5c23', 5, 'V', 'Retrospect. Lento, mesto - Larghetto lamentoso - Fuga, Molto espressivo - Maestoso, lugubre', 'Piano Sonata in E minor: V. Retrospect. Lento, mesto - Larghetto lamentoso - Fuga, Molto espressivo - Maestoso, lugubre', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 15922 AND p.composer_id = 331
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:d22341a2-7ad7-4a2f-ab29-727c8e6e5c23'
);


-- None 폴로네즈 C장조

UPDATE pieces piece
SET piece.title = '폴로네즈 C장조', piece.title_en = 'Polonaise in C major',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 16938 AND piece.composer_id = 331
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Prelude and Fugue for the Left Hand

UPDATE pieces piece
SET piece.title = 'Prelude and Fugue for the Left Hand', piece.title_en = 'Prelude and Fugue for the Left Hand',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 18844 AND piece.composer_id = 331
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'Prelude', part.name_en = 'Prelude and Fugue for the Left Hand: Prelude',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 18844 AND p.composer_id = 331 AND part.part_key = 'musicbrainz:a1a3ee5f-25cc-4ace-b697-6cb7b1c31caf' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:a1a3ee5f-25cc-4ace-b697-6cb7b1c31caf', 1, NULL, 'Prelude', 'Prelude and Fugue for the Left Hand: Prelude', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 18844 AND p.composer_id = 331
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:a1a3ee5f-25cc-4ace-b697-6cb7b1c31caf'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'Fugue', part.name_en = 'Prelude and Fugue for the Left Hand: Fugue',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 18844 AND p.composer_id = 331 AND part.part_key = 'musicbrainz:84fc06d3-6d86-4688-a1ba-b71ae45e7448' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:84fc06d3-6d86-4688-a1ba-b71ae45e7448', 2, NULL, 'Fugue', 'Prelude and Fugue for the Left Hand: Fugue', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 18844 AND p.composer_id = 331
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:84fc06d3-6d86-4688-a1ba-b71ae45e7448'
);


-- Op. 12 No. 1 사라반드

UPDATE pieces piece
SET piece.title = '사라반드', piece.title_en = 'Sarabande, op. 12 no. 1',
    piece.type = 'song', piece.opus_number = 'Op. 12 No. 1',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 18383 AND piece.composer_id = 331
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Studies on Chopin’s Études

UPDATE pieces piece
SET piece.title = 'Studies on Chopin’s Études', piece.title_en = 'Studies on Chopin’s Études',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 17496 AND piece.composer_id = 331
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Suite for the Left Hand Alone

UPDATE pieces piece
SET piece.title = 'Suite for the Left Hand Alone', piece.title_en = 'Suite for the Left Hand Alone',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 16650 AND piece.composer_id = 331
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'Allemande', part.name_en = 'Suite for the Left Hand Alone: I. Allemande',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 16650 AND p.composer_id = 331 AND part.part_key = 'musicbrainz:55f13f91-35e7-40df-913d-6b1e6df29715' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:55f13f91-35e7-40df-913d-6b1e6df29715', 1, 'I', 'Allemande', 'Suite for the Left Hand Alone: I. Allemande', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 16650 AND p.composer_id = 331
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:55f13f91-35e7-40df-913d-6b1e6df29715'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'Courante', part.name_en = 'Suite for the Left Hand Alone: II. Courante',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 16650 AND p.composer_id = 331 AND part.part_key = 'musicbrainz:c6092b5d-dd29-4a73-9f22-55519d38b3e3' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:c6092b5d-dd29-4a73-9f22-55519d38b3e3', 2, 'II', 'Courante', 'Suite for the Left Hand Alone: II. Courante', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 16650 AND p.composer_id = 331
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:c6092b5d-dd29-4a73-9f22-55519d38b3e3'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = 'Gavotte', part.name_en = 'Suite for the Left Hand Alone: III. Gavotte',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 16650 AND p.composer_id = 331 AND part.part_key = 'musicbrainz:4ca98c4d-e159-40ad-bc66-fa9aeca8923a' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:4ca98c4d-e159-40ad-bc66-fa9aeca8923a', 3, 'III', 'Gavotte', 'Suite for the Left Hand Alone: III. Gavotte', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 16650 AND p.composer_id = 331
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:4ca98c4d-e159-40ad-bc66-fa9aeca8923a'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = 'IV',
    part.name_ko = 'Sarabande', part.name_en = 'Suite for the Left Hand Alone: IV. Sarabande',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 16650 AND p.composer_id = 331 AND part.part_key = 'musicbrainz:db380b40-65e4-437b-9997-2d4f1260f7e3' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:db380b40-65e4-437b-9997-2d4f1260f7e3', 4, 'IV', 'Sarabande', 'Suite for the Left Hand Alone: IV. Sarabande', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 16650 AND p.composer_id = 331
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:db380b40-65e4-437b-9997-2d4f1260f7e3'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 5, part.movement_number = 'V',
    part.name_ko = 'Bourree', part.name_en = 'Suite for the Left Hand Alone: V. Bourree',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 16650 AND p.composer_id = 331 AND part.part_key = 'musicbrainz:cbd34444-f39d-43db-a06b-03befeea3cd2' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:cbd34444-f39d-43db-a06b-03befeea3cd2', 5, 'V', 'Bourree', 'Suite for the Left Hand Alone: V. Bourree', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 16650 AND p.composer_id = 331
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:cbd34444-f39d-43db-a06b-03befeea3cd2'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 6, part.movement_number = 'VI',
    part.name_ko = 'Sicilienne', part.name_en = 'Suite for the Left Hand Alone: VI. Sicilienne',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 16650 AND p.composer_id = 331 AND part.part_key = 'musicbrainz:cf0c4b37-fbb0-4738-b5ef-d7cac4dc7bc4' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:cf0c4b37-fbb0-4738-b5ef-d7cac4dc7bc4', 6, 'VI', 'Sicilienne', 'Suite for the Left Hand Alone: VI. Sicilienne', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 16650 AND p.composer_id = 331
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:cf0c4b37-fbb0-4738-b5ef-d7cac4dc7bc4'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 7, part.movement_number = 'VII',
    part.name_ko = 'Menuet', part.name_en = 'Suite for the Left Hand Alone: VII. Menuet',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 16650 AND p.composer_id = 331 AND part.part_key = 'musicbrainz:f039cbff-7fbf-4c87-b796-4b2b7db536a4' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:f039cbff-7fbf-4c87-b796-4b2b7db536a4', 7, 'VII', 'Menuet', 'Suite for the Left Hand Alone: VII. Menuet', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 16650 AND p.composer_id = 331
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:f039cbff-7fbf-4c87-b796-4b2b7db536a4'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 8, part.movement_number = 'VIII',
    part.name_ko = 'Gigue', part.name_en = 'Suite for the Left Hand Alone: VIII. Gigue',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 16650 AND p.composer_id = 331 AND part.part_key = 'musicbrainz:3629b206-ef76-47b9-8a3d-8ca787152948' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:3629b206-ef76-47b9-8a3d-8ca787152948', 8, 'VIII', 'Gigue', 'Suite for the Left Hand Alone: VIII. Gigue', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 16650 AND p.composer_id = 331
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:3629b206-ef76-47b9-8a3d-8ca787152948'
);


-- None Symphonische Metamorphosen Johann Strauss’scher Themen

UPDATE pieces piece
SET piece.title = 'Symphonische Metamorphosen Johann Strauss’scher Themen', piece.title_en = 'Symphonische Metamorphosen Johann Strauss’scher Themen',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 18176 AND piece.composer_id = 331
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None The Gardens of Buitenzorg

UPDATE pieces piece
SET piece.title = 'The Gardens of Buitenzorg', piece.title_en = 'The Gardens of Buitenzorg',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 19566 AND piece.composer_id = 331
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- Op. 11 Three Concert Studies Op. 11

UPDATE pieces piece
SET piece.title = 'Three Concert Studies Op. 11', piece.title_en = 'Three Concert Studies, op. 11',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = 'Op.', piece.catalogue_number = '11',
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 16169 AND piece.composer_id = 331
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'Grottesco', part.name_en = 'Three Concert Studies, op. 11: No. 1. Grottesco',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 16169 AND p.composer_id = 331 AND part.part_key = 'musicbrainz:6dd8cc26-18ff-441d-a900-9eaaf71659db' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:6dd8cc26-18ff-441d-a900-9eaaf71659db', 1, NULL, 'Grottesco', 'Three Concert Studies, op. 11: No. 1. Grottesco', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 16169 AND p.composer_id = 331
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:6dd8cc26-18ff-441d-a900-9eaaf71659db'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'No. 2', part.name_en = 'Three Concert Studies, op. 11: No. 2',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 16169 AND p.composer_id = 331 AND part.part_key = 'musicbrainz:d0eb3857-11fa-45b4-9669-e04341353710' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:d0eb3857-11fa-45b4-9669-e04341353710', 2, NULL, 'No. 2', 'Three Concert Studies, op. 11: No. 2', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 16169 AND p.composer_id = 331
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:d0eb3857-11fa-45b4-9669-e04341353710'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = NULL,
    part.name_ko = 'No. 3', part.name_en = 'Three Concert Studies, op. 11: No. 3',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 16169 AND p.composer_id = 331 AND part.part_key = 'musicbrainz:745e151f-84b1-4b7f-921d-6e0a0de025f3' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:745e151f-84b1-4b7f-921d-6e0a0de025f3', 3, NULL, 'No. 3', 'Three Concert Studies, op. 11: No. 3', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 16169 AND p.composer_id = 331
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:745e151f-84b1-4b7f-921d-6e0a0de025f3'
);


-- Op. 13 토카타 G♭장조

UPDATE pieces piece
SET piece.title = '토카타 G♭장조', piece.title_en = 'Toccata in G-flat major, op. 13',
    piece.type = 'song', piece.opus_number = 'Op. 13',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 19876 AND piece.composer_id = 331
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Triakontameron, Thirty Moods and Scenes in Triple Measure

UPDATE pieces piece
SET piece.title = 'Triakontameron, Thirty Moods and Scenes in Triple Measure', piece.title_en = 'Triakontameron, Thirty Moods and Scenes in Triple Measure',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 16384 AND piece.composer_id = 331
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'Nocturnal Tangier', part.name_en = 'Triakontameron, Thirty Moods and Scenes in Triple Measure: No. 1. Nocturnal Tangier',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 16384 AND p.composer_id = 331 AND part.part_key = 'musicbrainz:bfd130a8-d669-4ce4-8761-0a2a126556c1' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:bfd130a8-d669-4ce4-8761-0a2a126556c1', 1, NULL, 'Nocturnal Tangier', 'Triakontameron, Thirty Moods and Scenes in Triple Measure: No. 1. Nocturnal Tangier', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 16384 AND p.composer_id = 331
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:bfd130a8-d669-4ce4-8761-0a2a126556c1'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'Sylvan Tyrol', part.name_en = 'Triakontameron, Thirty Moods and Scenes in Triple Measure: No. 2. Sylvan Tyrol',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 16384 AND p.composer_id = 331 AND part.part_key = 'musicbrainz:f9e3264e-029b-4ddd-8509-025cf18ce288' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:f9e3264e-029b-4ddd-8509-025cf18ce288', 2, NULL, 'Sylvan Tyrol', 'Triakontameron, Thirty Moods and Scenes in Triple Measure: No. 2. Sylvan Tyrol', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 16384 AND p.composer_id = 331
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:f9e3264e-029b-4ddd-8509-025cf18ce288'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = NULL,
    part.name_ko = 'Paradoxical Mood', part.name_en = 'Triakontameron, Thirty Moods and Scenes in Triple Measure: No. 3. Paradoxical Mood',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 16384 AND p.composer_id = 331 AND part.part_key = 'musicbrainz:4123bd14-02c1-4675-bc49-e876fe2c5f48' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:4123bd14-02c1-4675-bc49-e876fe2c5f48', 3, NULL, 'Paradoxical Mood', 'Triakontameron, Thirty Moods and Scenes in Triple Measure: No. 3. Paradoxical Mood', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 16384 AND p.composer_id = 331
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:4123bd14-02c1-4675-bc49-e876fe2c5f48'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = NULL,
    part.name_ko = 'Rendez-Vous', part.name_en = 'Triakontameron, Thirty Moods and Scenes in Triple Measure: No. 4. Rendez-Vous',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 16384 AND p.composer_id = 331 AND part.part_key = 'musicbrainz:b517c375-6cee-4ecf-970f-092323a2d888' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:b517c375-6cee-4ecf-970f-092323a2d888', 4, NULL, 'Rendez-Vous', 'Triakontameron, Thirty Moods and Scenes in Triple Measure: No. 4. Rendez-Vous', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 16384 AND p.composer_id = 331
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:b517c375-6cee-4ecf-970f-092323a2d888'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 5, part.movement_number = NULL,
    part.name_ko = 'Twilight Phantasms', part.name_en = 'Triakontameron, Thirty Moods and Scenes in Triple Measure: No. 5. Twilight Phantasms',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 16384 AND p.composer_id = 331 AND part.part_key = 'musicbrainz:26ff1014-9643-44f3-94b7-430d5b41f207' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:26ff1014-9643-44f3-94b7-430d5b41f207', 5, NULL, 'Twilight Phantasms', 'Triakontameron, Thirty Moods and Scenes in Triple Measure: No. 5. Twilight Phantasms', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 16384 AND p.composer_id = 331
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:26ff1014-9643-44f3-94b7-430d5b41f207'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 6, part.movement_number = NULL,
    part.name_ko = 'The Pleading Troubadour', part.name_en = 'Triakontameron, Thirty Moods and Scenes in Triple Measure: No. 6. The Pleading Troubadour',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 16384 AND p.composer_id = 331 AND part.part_key = 'musicbrainz:45bc5590-243b-43e2-85cb-58f6e34dbafb' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:45bc5590-243b-43e2-85cb-58f6e34dbafb', 6, NULL, 'The Pleading Troubadour', 'Triakontameron, Thirty Moods and Scenes in Triple Measure: No. 6. The Pleading Troubadour', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 16384 AND p.composer_id = 331
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:45bc5590-243b-43e2-85cb-58f6e34dbafb'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 7, part.movement_number = NULL,
    part.name_ko = 'Yesteryear', part.name_en = 'Triakontameron, Thirty Moods and Scenes in Triple Measure: No. 7. Yesteryear...',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 16384 AND p.composer_id = 331 AND part.part_key = 'musicbrainz:1933684d-4a6c-4679-8953-88fc3fb3a392' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:1933684d-4a6c-4679-8953-88fc3fb3a392', 7, NULL, 'Yesteryear', 'Triakontameron, Thirty Moods and Scenes in Triple Measure: No. 7. Yesteryear...', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 16384 AND p.composer_id = 331
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:1933684d-4a6c-4679-8953-88fc3fb3a392'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 8, part.movement_number = NULL,
    part.name_ko = 'A Watteau Paysage', part.name_en = 'Triakontameron, Thirty Moods and Scenes in Triple Measure: No. 8. A Watteau Paysage',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 16384 AND p.composer_id = 331 AND part.part_key = 'musicbrainz:a5662e0d-2d08-4438-84e8-e6c1bba4f835' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:a5662e0d-2d08-4438-84e8-e6c1bba4f835', 8, NULL, 'A Watteau Paysage', 'Triakontameron, Thirty Moods and Scenes in Triple Measure: No. 8. A Watteau Paysage', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 16384 AND p.composer_id = 331
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:a5662e0d-2d08-4438-84e8-e6c1bba4f835'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 9, part.movement_number = NULL,
    part.name_ko = 'Enchanted Glen', part.name_en = 'Triakontameron, Thirty Moods and Scenes in Triple Measure: No. 9. Enchanted Glen',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 16384 AND p.composer_id = 331 AND part.part_key = 'musicbrainz:9c2c0b64-11b1-4e89-8099-41f965707988' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:9c2c0b64-11b1-4e89-8099-41f965707988', 9, NULL, 'Enchanted Glen', 'Triakontameron, Thirty Moods and Scenes in Triple Measure: No. 9. Enchanted Glen', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 16384 AND p.composer_id = 331
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:9c2c0b64-11b1-4e89-8099-41f965707988'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 10, part.movement_number = NULL,
    part.name_ko = 'Resignation', part.name_en = 'Triakontameron, Thirty Moods and Scenes in Triple Measure: No. 10. Resignation',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 16384 AND p.composer_id = 331 AND part.part_key = 'musicbrainz:398c97c9-d0e8-422e-a49b-b2fee84c1f1f' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:398c97c9-d0e8-422e-a49b-b2fee84c1f1f', 10, NULL, 'Resignation', 'Triakontameron, Thirty Moods and Scenes in Triple Measure: No. 10. Resignation', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 16384 AND p.composer_id = 331
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:398c97c9-d0e8-422e-a49b-b2fee84c1f1f'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 11, part.movement_number = NULL,
    part.name_ko = 'Alt-Wien, ''Whose Yesterdays Look Backwards With a Smile Through Tears''', part.name_en = 'Triakontameron, Thirty Moods and Scenes in Triple Measure: No. 11. Alt-Wien, ''Whose Yesterdays Look Backwards With a Smile Through Tears''',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 16384 AND p.composer_id = 331 AND part.part_key = 'musicbrainz:3ec97fc6-1504-47ae-94c9-205e8eb7e05c' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:3ec97fc6-1504-47ae-94c9-205e8eb7e05c', 11, NULL, 'Alt-Wien, ''Whose Yesterdays Look Backwards With a Smile Through Tears''', 'Triakontameron, Thirty Moods and Scenes in Triple Measure: No. 11. Alt-Wien, ''Whose Yesterdays Look Backwards With a Smile Through Tears''', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 16384 AND p.composer_id = 331
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:3ec97fc6-1504-47ae-94c9-205e8eb7e05c'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 12, part.movement_number = NULL,
    part.name_ko = 'Ethiopian Serenade', part.name_en = 'Triakontameron, Thirty Moods and Scenes in Triple Measure: No. 12. Ethiopian Serenade',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 16384 AND p.composer_id = 331 AND part.part_key = 'musicbrainz:c10545ee-fb0e-4dbe-a523-f7ba24946676' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:c10545ee-fb0e-4dbe-a523-f7ba24946676', 12, NULL, 'Ethiopian Serenade', 'Triakontameron, Thirty Moods and Scenes in Triple Measure: No. 12. Ethiopian Serenade', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 16384 AND p.composer_id = 331
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:c10545ee-fb0e-4dbe-a523-f7ba24946676'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 13, part.movement_number = NULL,
    part.name_ko = 'Terpsichorean Vindobona', part.name_en = 'Triakontameron, Thirty Moods and Scenes in Triple Measure: No. 13. Terpsichorean Vindobona',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 16384 AND p.composer_id = 331 AND part.part_key = 'musicbrainz:ef82797a-e09c-4c65-b6ed-2670eff01268' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:ef82797a-e09c-4c65-b6ed-2670eff01268', 13, NULL, 'Terpsichorean Vindobona', 'Triakontameron, Thirty Moods and Scenes in Triple Measure: No. 13. Terpsichorean Vindobona', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 16384 AND p.composer_id = 331
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:ef82797a-e09c-4c65-b6ed-2670eff01268'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 14, part.movement_number = NULL,
    part.name_ko = 'Whitecaps', part.name_en = 'Triakontameron, Thirty Moods and Scenes in Triple Measure: No. 14. Whitecaps',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 16384 AND p.composer_id = 331 AND part.part_key = 'musicbrainz:870f69bf-a9be-4e66-bdd9-3b7383117fd2' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:870f69bf-a9be-4e66-bdd9-3b7383117fd2', 14, NULL, 'Whitecaps', 'Triakontameron, Thirty Moods and Scenes in Triple Measure: No. 14. Whitecaps', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 16384 AND p.composer_id = 331
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:870f69bf-a9be-4e66-bdd9-3b7383117fd2'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 15, part.movement_number = NULL,
    part.name_ko = 'The Temptress', part.name_en = 'Triakontameron, Thirty Moods and Scenes in Triple Measure: No. 15. The Temptress',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 16384 AND p.composer_id = 331 AND part.part_key = 'musicbrainz:07762190-001f-40a7-9105-6024242e19d2' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:07762190-001f-40a7-9105-6024242e19d2', 15, NULL, 'The Temptress', 'Triakontameron, Thirty Moods and Scenes in Triple Measure: No. 15. The Temptress', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 16384 AND p.composer_id = 331
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:07762190-001f-40a7-9105-6024242e19d2'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 16, part.movement_number = NULL,
    part.name_ko = 'An Old Ballade', part.name_en = 'Triakontameron, Thirty Moods and Scenes in Triple Measure: No. 16. An Old Ballade',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 16384 AND p.composer_id = 331 AND part.part_key = 'musicbrainz:592fa112-89f8-437c-87a1-79c008680f1a' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:592fa112-89f8-437c-87a1-79c008680f1a', 16, NULL, 'An Old Ballade', 'Triakontameron, Thirty Moods and Scenes in Triple Measure: No. 16. An Old Ballade', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 16384 AND p.composer_id = 331
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:592fa112-89f8-437c-87a1-79c008680f1a'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 17, part.movement_number = NULL,
    part.name_ko = 'An American Idyll', part.name_en = 'Triakontameron, Thirty Moods and Scenes in Triple Measure: No. 17. An American Idyll',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 16384 AND p.composer_id = 331 AND part.part_key = 'musicbrainz:7652aaff-3827-49ce-a5f0-9dc0fccec03d' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:7652aaff-3827-49ce-a5f0-9dc0fccec03d', 17, NULL, 'An American Idyll', 'Triakontameron, Thirty Moods and Scenes in Triple Measure: No. 17. An American Idyll', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 16384 AND p.composer_id = 331
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:7652aaff-3827-49ce-a5f0-9dc0fccec03d'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 18, part.movement_number = NULL,
    part.name_ko = 'Anachronisms', part.name_en = 'Triakontameron, Thirty Moods and Scenes in Triple Measure: No. 18. Anachronisms',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 16384 AND p.composer_id = 331 AND part.part_key = 'musicbrainz:15b56828-bba0-49ec-b670-992b2e8f0c5e' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:15b56828-bba0-49ec-b670-992b2e8f0c5e', 18, NULL, 'Anachronisms', 'Triakontameron, Thirty Moods and Scenes in Triple Measure: No. 18. Anachronisms', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 16384 AND p.composer_id = 331
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:15b56828-bba0-49ec-b670-992b2e8f0c5e'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 19, part.movement_number = NULL,
    part.name_ko = 'A Little Tango Rag', part.name_en = 'Triakontameron, Thirty Moods and Scenes in Triple Measure: No. 19. A Little Tango Rag',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 16384 AND p.composer_id = 331 AND part.part_key = 'musicbrainz:cdc9e719-875e-4d54-aad9-9a7ccf5a65a9' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:cdc9e719-875e-4d54-aad9-9a7ccf5a65a9', 19, NULL, 'A Little Tango Rag', 'Triakontameron, Thirty Moods and Scenes in Triple Measure: No. 19. A Little Tango Rag', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 16384 AND p.composer_id = 331
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:cdc9e719-875e-4d54-aad9-9a7ccf5a65a9'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 20, part.movement_number = NULL,
    part.name_ko = 'Whirling Dervishes', part.name_en = 'Triakontameron, Thirty Moods and Scenes in Triple Measure: No. 20. Whirling Dervishes',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 16384 AND p.composer_id = 331 AND part.part_key = 'musicbrainz:b093713b-f8d9-4a50-8663-7994f69a51a4' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:b093713b-f8d9-4a50-8663-7994f69a51a4', 20, NULL, 'Whirling Dervishes', 'Triakontameron, Thirty Moods and Scenes in Triple Measure: No. 20. Whirling Dervishes', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 16384 AND p.composer_id = 331
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:b093713b-f8d9-4a50-8663-7994f69a51a4'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 21, part.movement_number = NULL,
    part.name_ko = 'The Salon', part.name_en = 'Triakontameron, Thirty Moods and Scenes in Triple Measure: No. 21. The Salon',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 16384 AND p.composer_id = 331 AND part.part_key = 'musicbrainz:28a9896e-7683-4801-a269-d44ad6e2a238' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:28a9896e-7683-4801-a269-d44ad6e2a238', 21, NULL, 'The Salon', 'Triakontameron, Thirty Moods and Scenes in Triple Measure: No. 21. The Salon', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 16384 AND p.composer_id = 331
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:28a9896e-7683-4801-a269-d44ad6e2a238'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 22, part.movement_number = NULL,
    part.name_ko = 'An Epic', part.name_en = 'Triakontameron, Thirty Moods and Scenes in Triple Measure: No. 22. An Epic',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 16384 AND p.composer_id = 331 AND part.part_key = 'musicbrainz:a9d37ab1-0199-4fbd-8cbb-9668116d7b8a' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:a9d37ab1-0199-4fbd-8cbb-9668116d7b8a', 22, NULL, 'An Epic', 'Triakontameron, Thirty Moods and Scenes in Triple Measure: No. 22. An Epic', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 16384 AND p.composer_id = 331
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:a9d37ab1-0199-4fbd-8cbb-9668116d7b8a'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 23, part.movement_number = NULL,
    part.name_ko = 'The Music-Box', part.name_en = 'Triakontameron, Thirty Moods and Scenes in Triple Measure: No. 23. The Music-Box',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 16384 AND p.composer_id = 331 AND part.part_key = 'musicbrainz:d10d921d-34e8-4aff-903c-5c1aed59c9e7' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:d10d921d-34e8-4aff-903c-5c1aed59c9e7', 23, NULL, 'The Music-Box', 'Triakontameron, Thirty Moods and Scenes in Triple Measure: No. 23. The Music-Box', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 16384 AND p.composer_id = 331
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:d10d921d-34e8-4aff-903c-5c1aed59c9e7'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 24, part.movement_number = NULL,
    part.name_ko = 'Lullaby', part.name_en = 'Triakontameron, Thirty Moods and Scenes in Triple Measure: No. 24. Lullaby',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 16384 AND p.composer_id = 331 AND part.part_key = 'musicbrainz:67fe118d-6cf2-425e-a922-35ad702f088b' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:67fe118d-6cf2-425e-a922-35ad702f088b', 24, NULL, 'Lullaby', 'Triakontameron, Thirty Moods and Scenes in Triple Measure: No. 24. Lullaby', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 16384 AND p.composer_id = 331
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:67fe118d-6cf2-425e-a922-35ad702f088b'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 25, part.movement_number = NULL,
    part.name_ko = 'Memories', part.name_en = 'Triakontameron, Thirty Moods and Scenes in Triple Measure: No. 25. Memories',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 16384 AND p.composer_id = 331 AND part.part_key = 'musicbrainz:17b18393-7383-4161-a1b1-74422cd3e2be' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:17b18393-7383-4161-a1b1-74422cd3e2be', 25, NULL, 'Memories', 'Triakontameron, Thirty Moods and Scenes in Triple Measure: No. 25. Memories', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 16384 AND p.composer_id = 331
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:17b18393-7383-4161-a1b1-74422cd3e2be'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 26, part.movement_number = NULL,
    part.name_ko = 'The Cuckoo Clock', part.name_en = 'Triakontameron, Thirty Moods and Scenes in Triple Measure: No. 26. The Cuckoo Clock',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 16384 AND p.composer_id = 331 AND part.part_key = 'musicbrainz:eacaaa14-8458-4946-9cf0-9d5b70416149' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:eacaaa14-8458-4946-9cf0-9d5b70416149', 26, NULL, 'The Cuckoo Clock', 'Triakontameron, Thirty Moods and Scenes in Triple Measure: No. 26. The Cuckoo Clock', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 16384 AND p.composer_id = 331
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:eacaaa14-8458-4946-9cf0-9d5b70416149'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 27, part.movement_number = NULL,
    part.name_ko = 'Lament', part.name_en = 'Triakontameron, Thirty Moods and Scenes in Triple Measure: No. 27. Lament',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 16384 AND p.composer_id = 331 AND part.part_key = 'musicbrainz:18556c4d-81a1-4e20-8820-72826ff74cef' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:18556c4d-81a1-4e20-8820-72826ff74cef', 27, NULL, 'Lament', 'Triakontameron, Thirty Moods and Scenes in Triple Measure: No. 27. Lament', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 16384 AND p.composer_id = 331
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:18556c4d-81a1-4e20-8820-72826ff74cef'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 28, part.movement_number = NULL,
    part.name_ko = 'Quixotic Errantry', part.name_en = 'Triakontameron, Thirty Moods and Scenes in Triple Measure: No. 28. Quixotic Errantry',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 16384 AND p.composer_id = 331 AND part.part_key = 'musicbrainz:23e944fa-3ebf-467a-a347-4dda26c9796f' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:23e944fa-3ebf-467a-a347-4dda26c9796f', 28, NULL, 'Quixotic Errantry', 'Triakontameron, Thirty Moods and Scenes in Triple Measure: No. 28. Quixotic Errantry', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 16384 AND p.composer_id = 331
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:23e944fa-3ebf-467a-a347-4dda26c9796f'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 29, part.movement_number = NULL,
    part.name_ko = 'Poeme Macabre', part.name_en = 'Triakontameron, Thirty Moods and Scenes in Triple Measure: No. 29. Poeme Macabre',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 16384 AND p.composer_id = 331 AND part.part_key = 'musicbrainz:6559c087-d217-49c2-be91-2d873d26baaa' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:6559c087-d217-49c2-be91-2d873d26baaa', 29, NULL, 'Poeme Macabre', 'Triakontameron, Thirty Moods and Scenes in Triple Measure: No. 29. Poeme Macabre', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 16384 AND p.composer_id = 331
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:6559c087-d217-49c2-be91-2d873d26baaa'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 30, part.movement_number = NULL,
    part.name_ko = 'Requiem - Epilogue', part.name_en = 'Triakontameron, Thirty Moods and Scenes in Triple Measure: No. 30. Requiem - Epilogue',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 16384 AND p.composer_id = 331 AND part.part_key = 'musicbrainz:86ed6d75-4a97-492e-a73d-0201a8123303' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:86ed6d75-4a97-492e-a73d-0201a8123303', 30, NULL, 'Requiem - Epilogue', 'Triakontameron, Thirty Moods and Scenes in Triple Measure: No. 30. Requiem - Epilogue', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 16384 AND p.composer_id = 331
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:86ed6d75-4a97-492e-a73d-0201a8123303'
);


-- None Twilight Thoughts

UPDATE pieces piece
SET piece.title = 'Twilight Thoughts', piece.title_en = 'Twilight Thoughts',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 16024 AND piece.composer_id = 331
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'Impressions sur le fleuve de Hudson', part.name_en = 'Twilight Thoughts: 1. Impressions sur le fleuve de Hudson',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 16024 AND p.composer_id = 331 AND part.part_key = 'musicbrainz:1b21ec90-6a45-4d96-9167-c0024819b30d' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:1b21ec90-6a45-4d96-9167-c0024819b30d', 1, NULL, 'Impressions sur le fleuve de Hudson', 'Twilight Thoughts: 1. Impressions sur le fleuve de Hudson', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 16024 AND p.composer_id = 331
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:1b21ec90-6a45-4d96-9167-c0024819b30d'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'Une nuit de printemps', part.name_en = 'Twilight Thoughts: 2. Une nuit de printemps',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 16024 AND p.composer_id = 331 AND part.part_key = 'musicbrainz:b1b82de7-49b4-495b-bf0c-4cc6936d0afc' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:b1b82de7-49b4-495b-bf0c-4cc6936d0afc', 2, NULL, 'Une nuit de printemps', 'Twilight Thoughts: 2. Une nuit de printemps', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 16024 AND p.composer_id = 331
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:b1b82de7-49b4-495b-bf0c-4cc6936d0afc'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = NULL,
    part.name_ko = 'Au jardin des fleurs', part.name_en = 'Twilight Thoughts: 3. Au jardin des fleurs',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 16024 AND p.composer_id = 331 AND part.part_key = 'musicbrainz:41a709dc-6b57-4542-bce1-b45102e75adf' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:41a709dc-6b57-4542-bce1-b45102e75adf', 3, NULL, 'Au jardin des fleurs', 'Twilight Thoughts: 3. Au jardin des fleurs', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 16024 AND p.composer_id = 331
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:41a709dc-6b57-4542-bce1-b45102e75adf'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = NULL,
    part.name_ko = 'Devotion', part.name_en = 'Twilight Thoughts: 4. Devotion',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 16024 AND p.composer_id = 331 AND part.part_key = 'musicbrainz:b525f86a-a349-4fe3-9c2d-798c6838109b' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:b525f86a-a349-4fe3-9c2d-798c6838109b', 4, NULL, 'Devotion', 'Twilight Thoughts: 4. Devotion', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 16024 AND p.composer_id = 331
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:b525f86a-a349-4fe3-9c2d-798c6838109b'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 5, part.movement_number = NULL,
    part.name_ko = 'Sérénade', part.name_en = 'Twilight Thoughts: 5. Sérénade',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 16024 AND p.composer_id = 331 AND part.part_key = 'musicbrainz:5cb1d039-e068-4802-91fa-111e5534f966' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:5cb1d039-e068-4802-91fa-111e5534f966', 5, NULL, 'Sérénade', 'Twilight Thoughts: 5. Sérénade', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 16024 AND p.composer_id = 331
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:5cb1d039-e068-4802-91fa-111e5534f966'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 6, part.movement_number = NULL,
    part.name_ko = 'Rêverie du soir', part.name_en = 'Twilight Thoughts: 6. Rêverie du soir',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 16024 AND p.composer_id = 331 AND part.part_key = 'musicbrainz:6b866dce-96b7-4744-8307-1d57a39c915e' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:6b866dce-96b7-4744-8307-1d57a39c915e', 6, NULL, 'Rêverie du soir', 'Twilight Thoughts: 6. Rêverie du soir', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 16024 AND p.composer_id = 331
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:6b866dce-96b7-4744-8307-1d57a39c915e'
);


-- None Valse-Scherzo

UPDATE pieces piece
SET piece.title = 'Valse-Scherzo', piece.title_en = 'Valse-Scherzo',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 19798 AND piece.composer_id = 331
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Walzermasken

UPDATE pieces piece
SET piece.title = 'Walzermasken', piece.title_en = 'Walzermasken',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 19026 AND piece.composer_id = 331
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'Karneval. Maestoso, con brio', part.name_en = 'Walzermasken: Nr. 1. Karneval. Maestoso, con brio',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 19026 AND p.composer_id = 331 AND part.part_key = 'musicbrainz:78eec3c1-9a81-4453-8f50-504ccd1fa808' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:78eec3c1-9a81-4453-8f50-504ccd1fa808', 1, NULL, 'Karneval. Maestoso, con brio', 'Walzermasken: Nr. 1. Karneval. Maestoso, con brio', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 19026 AND p.composer_id = 331
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:78eec3c1-9a81-4453-8f50-504ccd1fa808'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'Pastell (Fr. Sch.). Allegro', part.name_en = 'Walzermasken: Nr. 2. Pastell (Fr. Sch.). Allegro',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 19026 AND p.composer_id = 331 AND part.part_key = 'musicbrainz:5a3fb7e0-7b63-4820-a434-8bf2c022af6b' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:5a3fb7e0-7b63-4820-a434-8bf2c022af6b', 2, NULL, 'Pastell (Fr. Sch.). Allegro', 'Walzermasken: Nr. 2. Pastell (Fr. Sch.). Allegro', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 19026 AND p.composer_id = 331
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:5a3fb7e0-7b63-4820-a434-8bf2c022af6b'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = NULL,
    part.name_ko = 'Skizze (Joh. B.). Con spirito', part.name_en = 'Walzermasken: Nr. 3. Skizze (Joh. B.). Con spirito',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 19026 AND p.composer_id = 331 AND part.part_key = 'musicbrainz:3f068aae-efb7-477e-8a3d-d39557dd0f90' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:3f068aae-efb7-477e-8a3d-d39557dd0f90', 3, NULL, 'Skizze (Joh. B.). Con spirito', 'Walzermasken: Nr. 3. Skizze (Joh. B.). Con spirito', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 19026 AND p.composer_id = 331
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:3f068aae-efb7-477e-8a3d-d39557dd0f90'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = NULL,
    part.name_ko = 'Momento capriccioso. Allegreto', part.name_en = 'Walzermasken: Nr. 4. Momento capriccioso. Allegreto',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 19026 AND p.composer_id = 331 AND part.part_key = 'musicbrainz:ed725424-b830-4fc2-97f5-6591c0e91395' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:ed725424-b830-4fc2-97f5-6591c0e91395', 4, NULL, 'Momento capriccioso. Allegreto', 'Walzermasken: Nr. 4. Momento capriccioso. Allegreto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 19026 AND p.composer_id = 331
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:ed725424-b830-4fc2-97f5-6591c0e91395'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 5, part.movement_number = NULL,
    part.name_ko = 'Berceuse. Moderato, con moto', part.name_en = 'Walzermasken: Nr. 5. Berceuse. Moderato, con moto',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 19026 AND p.composer_id = 331 AND part.part_key = 'musicbrainz:5ebd7b7c-0238-48dc-a042-7e78a4121ffe' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:5ebd7b7c-0238-48dc-a042-7e78a4121ffe', 5, NULL, 'Berceuse. Moderato, con moto', 'Walzermasken: Nr. 5. Berceuse. Moderato, con moto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 19026 AND p.composer_id = 331
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:5ebd7b7c-0238-48dc-a042-7e78a4121ffe'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 6, part.movement_number = NULL,
    part.name_ko = 'Kontraste. Allegro vivace', part.name_en = 'Walzermasken: Nr. 6. Kontraste. Allegro vivace',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 19026 AND p.composer_id = 331 AND part.part_key = 'musicbrainz:db15633e-bb41-4c54-bd95-d7d2e4f7c69c' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:db15633e-bb41-4c54-bd95-d7d2e4f7c69c', 6, NULL, 'Kontraste. Allegro vivace', 'Walzermasken: Nr. 6. Kontraste. Allegro vivace', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 19026 AND p.composer_id = 331
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:db15633e-bb41-4c54-bd95-d7d2e4f7c69c'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 7, part.movement_number = NULL,
    part.name_ko = 'Profil (Fr. Ch.). Molto moderato', part.name_en = 'Walzermasken: Nr. 7. Profil (Fr. Ch.). Molto moderato',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 19026 AND p.composer_id = 331 AND part.part_key = 'musicbrainz:f86104f1-eb6b-4b72-a54c-0f86cf378bd5' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:f86104f1-eb6b-4b72-a54c-0f86cf378bd5', 7, NULL, 'Profil (Fr. Ch.). Molto moderato', 'Walzermasken: Nr. 7. Profil (Fr. Ch.). Molto moderato', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 19026 AND p.composer_id = 331
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:f86104f1-eb6b-4b72-a54c-0f86cf378bd5'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 8, part.movement_number = NULL,
    part.name_ko = 'Silhouette (Fr. L.). Allegro impetuoso', part.name_en = 'Walzermasken: Nr. 8. Silhouette (Fr. L.). Allegro impetuoso',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 19026 AND p.composer_id = 331 AND part.part_key = 'musicbrainz:0026d94a-5ddb-42b0-bbb5-c1d73e5c2b6a' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:0026d94a-5ddb-42b0-bbb5-c1d73e5c2b6a', 8, NULL, 'Silhouette (Fr. L.). Allegro impetuoso', 'Walzermasken: Nr. 8. Silhouette (Fr. L.). Allegro impetuoso', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 19026 AND p.composer_id = 331
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:0026d94a-5ddb-42b0-bbb5-c1d73e5c2b6a'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 9, part.movement_number = NULL,
    part.name_ko = 'Satire. Moderato', part.name_en = 'Walzermasken: Nr. 9. Satire. Moderato',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 19026 AND p.composer_id = 331 AND part.part_key = 'musicbrainz:1b4c24c3-58ba-4c5d-8c9b-7be8d15dd6d7' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:1b4c24c3-58ba-4c5d-8c9b-7be8d15dd6d7', 9, NULL, 'Satire. Moderato', 'Walzermasken: Nr. 9. Satire. Moderato', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 19026 AND p.composer_id = 331
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:1b4c24c3-58ba-4c5d-8c9b-7be8d15dd6d7'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 10, part.movement_number = NULL,
    part.name_ko = 'Karikatur. Molto moderato', part.name_en = 'Walzermasken: Nr. 10. Karikatur. Molto moderato',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 19026 AND p.composer_id = 331 AND part.part_key = 'musicbrainz:b185fc92-0ae3-4087-bd4c-fdc3de7f245a' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:b185fc92-0ae3-4087-bd4c-fdc3de7f245a', 10, NULL, 'Karikatur. Molto moderato', 'Walzermasken: Nr. 10. Karikatur. Molto moderato', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 19026 AND p.composer_id = 331
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:b185fc92-0ae3-4087-bd4c-fdc3de7f245a'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 11, part.movement_number = NULL,
    part.name_ko = 'Tyll Ulenspegel. Allegro con brio', part.name_en = 'Walzermasken: Nr. 11. Tyll Ulenspegel. Allegro con brio',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 19026 AND p.composer_id = 331 AND part.part_key = 'musicbrainz:1186a42f-d89a-4e9c-9e89-212146bf80ff' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:1186a42f-d89a-4e9c-9e89-212146bf80ff', 11, NULL, 'Tyll Ulenspegel. Allegro con brio', 'Walzermasken: Nr. 11. Tyll Ulenspegel. Allegro con brio', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 19026 AND p.composer_id = 331
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:1186a42f-d89a-4e9c-9e89-212146bf80ff'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 12, part.movement_number = NULL,
    part.name_ko = 'Legende. Moderato', part.name_en = 'Walzermasken: Nr. 12. Legende. Moderato',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 19026 AND p.composer_id = 331 AND part.part_key = 'musicbrainz:fa9a612e-738a-490a-b942-55073ce9265b' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:fa9a612e-738a-490a-b942-55073ce9265b', 12, NULL, 'Legende. Moderato', 'Walzermasken: Nr. 12. Legende. Moderato', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 19026 AND p.composer_id = 331
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:fa9a612e-738a-490a-b942-55073ce9265b'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 13, part.movement_number = NULL,
    part.name_ko = 'Humoreske (on 4 notes). Allegro con brio', part.name_en = 'Walzermasken: Nr. 13. Humoreske (on 4 notes). Allegro con brio',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 19026 AND p.composer_id = 331 AND part.part_key = 'musicbrainz:5adaba4d-6ac4-42e0-8933-82988eb4a0d2' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:5adaba4d-6ac4-42e0-8933-82988eb4a0d2', 13, NULL, 'Humoreske (on 4 notes). Allegro con brio', 'Walzermasken: Nr. 13. Humoreske (on 4 notes). Allegro con brio', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 19026 AND p.composer_id = 331
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:5adaba4d-6ac4-42e0-8933-82988eb4a0d2'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 14, part.movement_number = NULL,
    part.name_ko = 'Französisch. Moderato e grazioso', part.name_en = 'Walzermasken: Nr. 14. Französisch. Moderato e grazioso',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 19026 AND p.composer_id = 331 AND part.part_key = 'musicbrainz:68765681-9b08-41c1-a3c7-20ec623d0fb0' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:68765681-9b08-41c1-a3c7-20ec623d0fb0', 14, NULL, 'Französisch. Moderato e grazioso', 'Walzermasken: Nr. 14. Französisch. Moderato e grazioso', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 19026 AND p.composer_id = 331
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:68765681-9b08-41c1-a3c7-20ec623d0fb0'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 15, part.movement_number = NULL,
    part.name_ko = 'Elegie. Molto moderato', part.name_en = 'Walzermasken: Nr. 15. Elegie. Molto moderato',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 19026 AND p.composer_id = 331 AND part.part_key = 'musicbrainz:dc21b105-33df-4b77-9611-b77f659d6ca4' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:dc21b105-33df-4b77-9611-b77f659d6ca4', 15, NULL, 'Elegie. Molto moderato', 'Walzermasken: Nr. 15. Elegie. Molto moderato', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 19026 AND p.composer_id = 331
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:dc21b105-33df-4b77-9611-b77f659d6ca4'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 16, part.movement_number = NULL,
    part.name_ko = 'Perpetuum mobile. Allegro vivace', part.name_en = 'Walzermasken: Nr. 16. Perpetuum mobile. Allegro vivace',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 19026 AND p.composer_id = 331 AND part.part_key = 'musicbrainz:263c4991-b0b0-4b24-b0a9-cdebc60e10e7' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:263c4991-b0b0-4b24-b0a9-cdebc60e10e7', 16, NULL, 'Perpetuum mobile. Allegro vivace', 'Walzermasken: Nr. 16. Perpetuum mobile. Allegro vivace', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 19026 AND p.composer_id = 331
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:263c4991-b0b0-4b24-b0a9-cdebc60e10e7'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 17, part.movement_number = NULL,
    part.name_ko = 'Menuett. Tempo di menuetto', part.name_en = 'Walzermasken: Nr. 17. Menuett. Tempo di menuetto',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 19026 AND p.composer_id = 331 AND part.part_key = 'musicbrainz:125cf9fa-1486-4389-9742-48e5610f46b0' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:125cf9fa-1486-4389-9742-48e5610f46b0', 17, NULL, 'Menuett. Tempo di menuetto', 'Walzermasken: Nr. 17. Menuett. Tempo di menuetto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 19026 AND p.composer_id = 331
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:125cf9fa-1486-4389-9742-48e5610f46b0'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 18, part.movement_number = NULL,
    part.name_ko = 'Schuhplattler. Allegro, con amore', part.name_en = 'Walzermasken: Nr. 18. Schuhplattler. Allegro, con amore',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 19026 AND p.composer_id = 331 AND part.part_key = 'musicbrainz:fac77968-c04e-4739-b595-266c44803a67' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:fac77968-c04e-4739-b595-266c44803a67', 18, NULL, 'Schuhplattler. Allegro, con amore', 'Walzermasken: Nr. 18. Schuhplattler. Allegro, con amore', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 19026 AND p.composer_id = 331
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:fac77968-c04e-4739-b595-266c44803a67'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 19, part.movement_number = NULL,
    part.name_ko = 'Valse macabre. Moderato', part.name_en = 'Walzermasken: Nr. 19. Valse macabre. Moderato',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 19026 AND p.composer_id = 331 AND part.part_key = 'musicbrainz:9c84fa03-ddfb-41ef-8505-ce672b1be9c7' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:9c84fa03-ddfb-41ef-8505-ce672b1be9c7', 19, NULL, 'Valse macabre. Moderato', 'Walzermasken: Nr. 19. Valse macabre. Moderato', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 19026 AND p.composer_id = 331
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:9c84fa03-ddfb-41ef-8505-ce672b1be9c7'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 20, part.movement_number = NULL,
    part.name_ko = 'Abendglocken (Angelus). Moderato', part.name_en = 'Walzermasken: Nr. 20. Abendglocken (Angelus). Moderato',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 19026 AND p.composer_id = 331 AND part.part_key = 'musicbrainz:a47c7df6-bb86-46d7-82a1-5bd627d93c83' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:a47c7df6-bb86-46d7-82a1-5bd627d93c83', 20, NULL, 'Abendglocken (Angelus). Moderato', 'Walzermasken: Nr. 20. Abendglocken (Angelus). Moderato', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 19026 AND p.composer_id = 331
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:a47c7df6-bb86-46d7-82a1-5bd627d93c83'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 21, part.movement_number = NULL,
    part.name_ko = 'Orientale. Andante cantabile', part.name_en = 'Walzermasken: Nr. 21. Orientale. Andante cantabile',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 19026 AND p.composer_id = 331 AND part.part_key = 'musicbrainz:e6c7969b-3e1a-4a52-a3ed-8e093549b949' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:e6c7969b-3e1a-4a52-a3ed-8e093549b949', 21, NULL, 'Orientale. Andante cantabile', 'Walzermasken: Nr. 21. Orientale. Andante cantabile', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 19026 AND p.composer_id = 331
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:e6c7969b-3e1a-4a52-a3ed-8e093549b949'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 22, part.movement_number = NULL,
    part.name_ko = 'Wienerisch. Allegretto grazioso', part.name_en = 'Walzermasken: Nr. 22. Wienerisch. Allegretto grazioso',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 19026 AND p.composer_id = 331 AND part.part_key = 'musicbrainz:62e82e10-781b-4fa2-bc23-ffddfb8bc655' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:62e82e10-781b-4fa2-bc23-ffddfb8bc655', 22, NULL, 'Wienerisch. Allegretto grazioso', 'Walzermasken: Nr. 22. Wienerisch. Allegretto grazioso', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 19026 AND p.composer_id = 331
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:62e82e10-781b-4fa2-bc23-ffddfb8bc655'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 23, part.movement_number = NULL,
    part.name_ko = 'Eine Sage. Moderato', part.name_en = 'Walzermasken: Nr. 23. Eine Sage. Moderato',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 19026 AND p.composer_id = 331 AND part.part_key = 'musicbrainz:a5a62f97-6288-4bf2-a1b2-2b93fbc0f9fb' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:a5a62f97-6288-4bf2-a1b2-2b93fbc0f9fb', 23, NULL, 'Eine Sage. Moderato', 'Walzermasken: Nr. 23. Eine Sage. Moderato', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 19026 AND p.composer_id = 331
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:a5a62f97-6288-4bf2-a1b2-2b93fbc0f9fb'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 24, part.movement_number = NULL,
    part.name_ko = 'Portrait (Joh. S.). Allegro con fuoco', part.name_en = 'Walzermasken: Nr. 24. Portrait (Joh. S.). Allegro con fuoco',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 19026 AND p.composer_id = 331 AND part.part_key = 'musicbrainz:8f402648-e9cc-49f2-bf0d-1dbfd1b0bfab' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:8f402648-e9cc-49f2-bf0d-1dbfd1b0bfab', 24, NULL, 'Portrait (Joh. S.). Allegro con fuoco', 'Walzermasken: Nr. 24. Portrait (Joh. S.). Allegro con fuoco', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 19026 AND p.composer_id = 331
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:8f402648-e9cc-49f2-bf0d-1dbfd1b0bfab'
);


-- 카탈로그에 대응이 없는 seed 작품 11개를 목록에서 숨긴다(지우지 않음).
UPDATE pieces piece
SET piece.hidden_reason = 'catalog_unmatched'
WHERE piece.composer_id = 331 AND piece.origin = 'seed' AND piece.hidden_reason IS NULL
  AND piece.id IN (
    15810, 16184, 16752, 17708, 17963, 19406, 19709, 19734, 19821, 19834, 20063
  )
  AND NOT EXISTS (SELECT 1 FROM performance_sectors sector WHERE sector.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM piece_parts linking WHERE linking.linked_piece_id = piece.id);
