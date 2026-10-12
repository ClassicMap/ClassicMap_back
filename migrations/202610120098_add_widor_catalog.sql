-- 찰스 마리 비도르 작품을 MusicBrainz 작품 구조로 다시 짠다(4차 자동). 작품 64개(묶음 14, 다악장 23, 낱곡 27),
-- 새 작품 7개, part 158개, 그 아래 33개.
-- seed 62개 중 57개를 작품·part 에 잇고, 5개를 숨기고, 0개는 그대로 둔다.
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

-- Op. 31 12 feuillets d'album Op. 31

UPDATE pieces piece
SET piece.title = '12 feuillets d''album Op. 31', piece.title_en = '12 feuillets d''album, op. 31',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = 'Op.', piece.catalogue_number = '31',
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 19013 AND piece.composer_id = 263
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'Lilas, op. 31 no. 1', part.name_en = 'Lilas, op. 31 no. 1',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 19013 AND p.composer_id = 263 AND part.part_key = 'musicbrainz:3dab006c-61fa-40f5-a840-f11e45d30794' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:3dab006c-61fa-40f5-a840-f11e45d30794', 1, NULL, 'Lilas, op. 31 no. 1', 'Lilas, op. 31 no. 1', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 19013 AND p.composer_id = 263
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:3dab006c-61fa-40f5-a840-f11e45d30794'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'Papillons bleus, op. 31 no. 2', part.name_en = 'Papillons bleus, op. 31 no. 2',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 19013 AND p.composer_id = 263 AND part.part_key = 'musicbrainz:8626c65e-4e56-4c50-839a-faef67a8a706' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:8626c65e-4e56-4c50-839a-faef67a8a706', 2, NULL, 'Papillons bleus, op. 31 no. 2', 'Papillons bleus, op. 31 no. 2', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 19013 AND p.composer_id = 263
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:8626c65e-4e56-4c50-839a-faef67a8a706'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = NULL,
    part.name_ko = 'Chanson matinale, op. 31 no. 3', part.name_en = 'Chanson matinale, op. 31 no. 3',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 19013 AND p.composer_id = 263 AND part.part_key = 'musicbrainz:7a5262a7-9bbc-4220-af44-3809867510cd' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:7a5262a7-9bbc-4220-af44-3809867510cd', 3, NULL, 'Chanson matinale, op. 31 no. 3', 'Chanson matinale, op. 31 no. 3', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 19013 AND p.composer_id = 263
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:7a5262a7-9bbc-4220-af44-3809867510cd'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = NULL,
    part.name_ko = 'Drame, op. 31 no. 4', part.name_en = 'Drame, op. 31 no. 4',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 19013 AND p.composer_id = 263 AND part.part_key = 'musicbrainz:3861fd61-aafd-4000-a17a-0b7834a6fe13' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:3861fd61-aafd-4000-a17a-0b7834a6fe13', 4, NULL, 'Drame, op. 31 no. 4', 'Drame, op. 31 no. 4', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 19013 AND p.composer_id = 263
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:3861fd61-aafd-4000-a17a-0b7834a6fe13'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 5, part.movement_number = NULL,
    part.name_ko = 'Nuit sereine, op. 31 no. 5', part.name_en = 'Nuit sereine, op. 31 no. 5',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 19013 AND p.composer_id = 263 AND part.part_key = 'musicbrainz:a2839b74-1e66-475c-ae8d-724be3282bdf' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:a2839b74-1e66-475c-ae8d-724be3282bdf', 5, NULL, 'Nuit sereine, op. 31 no. 5', 'Nuit sereine, op. 31 no. 5', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 19013 AND p.composer_id = 263
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:a2839b74-1e66-475c-ae8d-724be3282bdf'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 6, part.movement_number = NULL,
    part.name_ko = 'Valse lente, op. 31 no. 6', part.name_en = 'Valse lente, op. 31 no. 6',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 19013 AND p.composer_id = 263 AND part.part_key = 'musicbrainz:50146d03-9eaa-4985-9e1f-b61376dbb3e3' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:50146d03-9eaa-4985-9e1f-b61376dbb3e3', 6, NULL, 'Valse lente, op. 31 no. 6', 'Valse lente, op. 31 no. 6', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 19013 AND p.composer_id = 263
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:50146d03-9eaa-4985-9e1f-b61376dbb3e3'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 7, part.movement_number = NULL,
    part.name_ko = 'Solitude, op. 31 no. 7', part.name_en = 'Solitude, op. 31 no. 7',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 19013 AND p.composer_id = 263 AND part.part_key = 'musicbrainz:74c07862-d2d7-4189-a303-6da75f75eac1' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:74c07862-d2d7-4189-a303-6da75f75eac1', 7, NULL, 'Solitude, op. 31 no. 7', 'Solitude, op. 31 no. 7', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 19013 AND p.composer_id = 263
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:74c07862-d2d7-4189-a303-6da75f75eac1'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 8, part.movement_number = NULL,
    part.name_ko = 'Bruits d''aîles, op. 31 no. 8', part.name_en = 'Bruits d''aîles, op. 31 no. 8',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 19013 AND p.composer_id = 263 AND part.part_key = 'musicbrainz:f8ca8fb6-0964-42c4-88c1-90e3f708f76a' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:f8ca8fb6-0964-42c4-88c1-90e3f708f76a', 8, NULL, 'Bruits d''aîles, op. 31 no. 8', 'Bruits d''aîles, op. 31 no. 8', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 19013 AND p.composer_id = 263
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:f8ca8fb6-0964-42c4-88c1-90e3f708f76a'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 9, part.movement_number = NULL,
    part.name_ko = 'Pensée, op. 31 no. 9', part.name_en = 'Pensée, op. 31 no. 9',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 19013 AND p.composer_id = 263 AND part.part_key = 'musicbrainz:ca4eb91a-fc27-4085-baa2-fb69dba45265' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:ca4eb91a-fc27-4085-baa2-fb69dba45265', 9, NULL, 'Pensée, op. 31 no. 9', 'Pensée, op. 31 no. 9', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 19013 AND p.composer_id = 263
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:ca4eb91a-fc27-4085-baa2-fb69dba45265'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 10, part.movement_number = NULL,
    part.name_ko = 'Ciel gris, op. 31 no. 10', part.name_en = 'Ciel gris, op. 31 no. 10',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 19013 AND p.composer_id = 263 AND part.part_key = 'musicbrainz:354a38be-7c93-46ae-9dcb-c035b0e7811f' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:354a38be-7c93-46ae-9dcb-c035b0e7811f', 10, NULL, 'Ciel gris, op. 31 no. 10', 'Ciel gris, op. 31 no. 10', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 19013 AND p.composer_id = 263
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:354a38be-7c93-46ae-9dcb-c035b0e7811f'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 11, part.movement_number = NULL,
    part.name_ko = 'Marche américaine, op. 31 no. 11', part.name_en = 'Marche américaine, op. 31 no. 11',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 19013 AND p.composer_id = 263 AND part.part_key = 'musicbrainz:452e7ca2-abd8-4706-a197-6e4368e38c48' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:452e7ca2-abd8-4706-a197-6e4368e38c48', 11, NULL, 'Marche américaine, op. 31 no. 11', 'Marche américaine, op. 31 no. 11', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 19013 AND p.composer_id = 263
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:452e7ca2-abd8-4706-a197-6e4368e38c48'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 12, part.movement_number = NULL,
    part.name_ko = 'Myosotis, op. 31 no. 12', part.name_en = 'Myosotis, op. 31 no. 12',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 19013 AND p.composer_id = 263 AND part.part_key = 'musicbrainz:b4587b77-a2f4-48eb-8b10-d4cbb802c4cb' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:b4587b77-a2f4-48eb-8b10-d4cbb802c4cb', 12, NULL, 'Myosotis, op. 31 no. 12', 'Myosotis, op. 31 no. 12', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 19013 AND p.composer_id = 263
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:b4587b77-a2f4-48eb-8b10-d4cbb802c4cb'
);


-- Op. 30 2 Duos Op. 30

UPDATE pieces piece
SET piece.title = '2 Duos Op. 30', piece.title_en = '2 Duos, op. 30',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = 'Op.', piece.catalogue_number = '30',
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 17074 AND piece.composer_id = 263
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'J''étais seul près des flots', part.name_en = 'Deux Duos, op. 30: No. 1. J''étais seul près des flots',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 17074 AND p.composer_id = 263 AND part.part_key = 'musicbrainz:dfaf8911-0b84-4f43-b2d1-a18888ce7c6d' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:dfaf8911-0b84-4f43-b2d1-a18888ce7c6d', 1, NULL, 'J''étais seul près des flots', 'Deux Duos, op. 30: No. 1. J''étais seul près des flots', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 17074 AND p.composer_id = 263
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:dfaf8911-0b84-4f43-b2d1-a18888ce7c6d'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'Je ne croyais pas au bonheur', part.name_en = 'Deux Duos, op. 30: No. 2. Je ne croyais pas au bonheur',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 17074 AND p.composer_id = 263 AND part.part_key = 'musicbrainz:ebc382c9-c11f-480a-8514-de5261ebbccf' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:ebc382c9-c11f-480a-8514-de5261ebbccf', 2, NULL, 'Je ne croyais pas au bonheur', 'Deux Duos, op. 30: No. 2. Je ne croyais pas au bonheur', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 17074 AND p.composer_id = 263
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:ebc382c9-c11f-480a-8514-de5261ebbccf'
);


-- Op. 40 2 Duos Op. 40

UPDATE pieces piece
SET piece.title = '2 Duos Op. 40', piece.title_en = '2 Duos, op. 40',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = 'Op.', piece.catalogue_number = '40',
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 18758 AND piece.composer_id = 263
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'Nocturne', part.name_en = 'Deux Duos, op. 40: No. 1. Nocturne',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 18758 AND p.composer_id = 263 AND part.part_key = 'musicbrainz:3424d2af-aeb8-4372-bb81-4b2113c31370' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:3424d2af-aeb8-4372-bb81-4b2113c31370', 1, NULL, 'Nocturne', 'Deux Duos, op. 40: No. 1. Nocturne', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 18758 AND p.composer_id = 263
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:3424d2af-aeb8-4372-bb81-4b2113c31370'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'Qu''un songe au ciel m''enlève', part.name_en = 'Deux Duos, op. 40: No. 2. Qu''un songe au ciel m''enlève',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 18758 AND p.composer_id = 263 AND part.part_key = 'musicbrainz:1f4ef9c5-b62d-4ad7-9856-9b867d7566cb' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:1f4ef9c5-b62d-4ad7-9856-9b867d7566cb', 2, NULL, 'Qu''un songe au ciel m''enlève', 'Deux Duos, op. 40: No. 2. Qu''un songe au ciel m''enlève', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 18758 AND p.composer_id = 263
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:1f4ef9c5-b62d-4ad7-9856-9b867d7566cb'
);


-- Op. 52 2 Duos Op. 52

UPDATE pieces piece
SET piece.title = '2 Duos Op. 52', piece.title_en = '2 Duos, op. 52',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = 'Op.', piece.catalogue_number = '52',
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 17258 AND piece.composer_id = 263
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'L''hiver', part.name_en = 'Deux Duos, op. 52: No. 1. L''hiver',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 17258 AND p.composer_id = 263 AND part.part_key = 'musicbrainz:87072bc0-186f-4799-a744-b9d2e27561c7' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:87072bc0-186f-4799-a744-b9d2e27561c7', 1, NULL, 'L''hiver', 'Deux Duos, op. 52: No. 1. L''hiver', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 17258 AND p.composer_id = 263
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:87072bc0-186f-4799-a744-b9d2e27561c7'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'Guitare', part.name_en = 'Deux Duos, op. 52: No. 2. Guitare',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 17258 AND p.composer_id = 263 AND part.part_key = 'musicbrainz:c4c1134f-089b-4cbe-b387-d490dea03bc8' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:c4c1134f-089b-4cbe-b387-d490dea03bc8', 2, NULL, 'Guitare', 'Deux Duos, op. 52: No. 2. Guitare', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 17258 AND p.composer_id = 263
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:c4c1134f-089b-4cbe-b387-d490dea03bc8'
);


-- Op. 21 3 Pièces Op. 21

UPDATE pieces piece
SET piece.title = '3 Pièces Op. 21', piece.title_en = '3 Pièces, op. 21',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = 'Op.', piece.catalogue_number = '21',
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 17835 AND piece.composer_id = 263
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'Appassionato', part.name_en = '3 Pieces, op. 21: No. 2. Appassionato',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 17835 AND p.composer_id = 263 AND part.part_key = 'musicbrainz:52e28600-81c9-4efb-8a8b-ea051395d3a6' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:52e28600-81c9-4efb-8a8b-ea051395d3a6', 1, NULL, 'Appassionato', '3 Pieces, op. 21: No. 2. Appassionato', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 17835 AND p.composer_id = 263
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:52e28600-81c9-4efb-8a8b-ea051395d3a6'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'Meditation', part.name_en = '3 Pieces, op. 21: No. 1. Meditation',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 17835 AND p.composer_id = 263 AND part.part_key = 'musicbrainz:88dec5b5-2971-4f1b-b246-184bd4a91af9' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:88dec5b5-2971-4f1b-b246-184bd4a91af9', 2, NULL, 'Meditation', '3 Pieces, op. 21: No. 1. Meditation', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 17835 AND p.composer_id = 263
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:88dec5b5-2971-4f1b-b246-184bd4a91af9'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = NULL,
    part.name_ko = 'Canzonetta', part.name_en = '3 Pieces, op. 21: No. 3. Canzonetta',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 17835 AND p.composer_id = 263 AND part.part_key = 'musicbrainz:cbd1e50f-f598-4ef8-add4-1b2e97f58c6e' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:cbd1e50f-f598-4ef8-add4-1b2e97f58c6e', 3, NULL, 'Canzonetta', '3 Pieces, op. 21: No. 3. Canzonetta', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 17835 AND p.composer_id = 263
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:cbd1e50f-f598-4ef8-add4-1b2e97f58c6e'
);


-- None Air en style ancien

UPDATE pieces piece
SET piece.title = 'Air en style ancien', piece.title_en = 'Air en style ancien',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 18902 AND piece.composer_id = 263
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Bach's Memento

UPDATE pieces piece
SET piece.title = 'Bach''s Memento', piece.title_en = 'Bach''s Memento',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 16884 AND piece.composer_id = 263
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'Pastorale, flûte et hautbois', part.name_en = 'Bach''s Memento: No. 1. Pastorale, flûte et hautbois',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 16884 AND p.composer_id = 263 AND part.part_key = 'musicbrainz:76de1bcd-131e-4d92-a8e4-55811fa026ba' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:76de1bcd-131e-4d92-a8e4-55811fa026ba', 1, NULL, 'Pastorale, flûte et hautbois', 'Bach''s Memento: No. 1. Pastorale, flûte et hautbois', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 16884 AND p.composer_id = 263
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:76de1bcd-131e-4d92-a8e4-55811fa026ba'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'Miserere mei Domine', part.name_en = 'Bach''s Memento: No. 2. Miserere mei Domine',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 16884 AND p.composer_id = 263 AND part.part_key = 'musicbrainz:ea4ecbdc-2a57-4e20-b3d4-732350ff3193' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:ea4ecbdc-2a57-4e20-b3d4-732350ff3193', 2, NULL, 'Miserere mei Domine', 'Bach''s Memento: No. 2. Miserere mei Domine', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 16884 AND p.composer_id = 263
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:ea4ecbdc-2a57-4e20-b3d4-732350ff3193'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = NULL,
    part.name_ko = 'Aria', part.name_en = 'Bach''s Memento: No. 3. Aria',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 16884 AND p.composer_id = 263 AND part.part_key = 'musicbrainz:ed56139a-350c-4560-b56e-3d0042225473' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:ed56139a-350c-4560-b56e-3d0042225473', 3, NULL, 'Aria', 'Bach''s Memento: No. 3. Aria', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 16884 AND p.composer_id = 263
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:ed56139a-350c-4560-b56e-3d0042225473'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = NULL,
    part.name_ko = 'Sicilienne', part.name_en = 'Bach''s Memento: No. 5. Sicilienne',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 16884 AND p.composer_id = 263 AND part.part_key = 'musicbrainz:99c9c217-4e6f-4d08-a315-f76bbc31553b' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:99c9c217-4e6f-4d08-a315-f76bbc31553b', 4, NULL, 'Sicilienne', 'Bach''s Memento: No. 5. Sicilienne', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 16884 AND p.composer_id = 263
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:99c9c217-4e6f-4d08-a315-f76bbc31553b'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 5, part.movement_number = NULL,
    part.name_ko = 'Mattheus-Final', part.name_en = 'Bach''s Memento: No. 6. Mattheus-Final',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 16884 AND p.composer_id = 263 AND part.part_key = 'musicbrainz:22e82bb6-0473-49af-abe9-d71dfcfb0042' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:22e82bb6-0473-49af-abe9-d71dfcfb0042', 5, NULL, 'Mattheus-Final', 'Bach''s Memento: No. 6. Mattheus-Final', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 16884 AND p.composer_id = 263
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:22e82bb6-0473-49af-abe9-d71dfcfb0042'
);


-- Op. 41 첼로 협주곡

UPDATE pieces piece
SET piece.title = '첼로 협주곡', piece.title_en = 'Cello Concerto, op. 41',
    piece.type = 'album', piece.opus_number = 'Op. 41',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 17009 AND piece.composer_id = 263
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'Allegro', part.name_en = 'Cello Concerto, op. 41: I. Allegro',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 17009 AND p.composer_id = 263 AND part.part_key = 'musicbrainz:4129806b-7514-49d2-8274-a3cc8c535fc2' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:4129806b-7514-49d2-8274-a3cc8c535fc2', 1, 'I', 'Allegro', 'Cello Concerto, op. 41: I. Allegro', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 17009 AND p.composer_id = 263
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:4129806b-7514-49d2-8274-a3cc8c535fc2'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'Andantino - Andante - Animato', part.name_en = 'Cello Concerto, op. 41: II. Andantino - Andante - Animato',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 17009 AND p.composer_id = 263 AND part.part_key = 'musicbrainz:f952008a-4dcd-479f-95c5-537fc9dd3d43' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:f952008a-4dcd-479f-95c5-537fc9dd3d43', 2, 'II', 'Andantino - Andante - Animato', 'Cello Concerto, op. 41: II. Andantino - Andante - Animato', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 17009 AND p.composer_id = 263
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:f952008a-4dcd-479f-95c5-537fc9dd3d43'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = 'Finale: Allegro vivace', part.name_en = 'Cello Concerto, op. 41: III. Finale: Allegro vivace',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 17009 AND p.composer_id = 263 AND part.part_key = 'musicbrainz:50e6f3df-dd0a-4798-a21c-cbbce1083a57' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:50e6f3df-dd0a-4798-a21c-cbbce1083a57', 3, 'III', 'Finale: Allegro vivace', 'Cello Concerto, op. 41: III. Finale: Allegro vivace', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 17009 AND p.composer_id = 263
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:50e6f3df-dd0a-4798-a21c-cbbce1083a57'
);


-- Op. 80 첼로 소나타 A장조

UPDATE pieces piece
SET piece.title = '첼로 소나타 A장조', piece.title_en = 'Cello Sonata in A major, op. 80',
    piece.type = 'album', piece.opus_number = 'Op. 80',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 19475 AND piece.composer_id = 263
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'Allegro moderato', part.name_en = 'Cello Sonata in A major, op. 80: I. Allegro moderato',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 19475 AND p.composer_id = 263 AND part.part_key = 'musicbrainz:ba5075b2-2871-4ede-8517-091bc9d6dc3e' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:ba5075b2-2871-4ede-8517-091bc9d6dc3e', 1, 'I', 'Allegro moderato', 'Cello Sonata in A major, op. 80: I. Allegro moderato', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 19475 AND p.composer_id = 263
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:ba5075b2-2871-4ede-8517-091bc9d6dc3e'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'Andante con moto', part.name_en = 'Cello Sonata in A major, op. 80: II. Andante con moto',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 19475 AND p.composer_id = 263 AND part.part_key = 'musicbrainz:753821ec-b889-4440-be84-811f4e0f975b' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:753821ec-b889-4440-be84-811f4e0f975b', 2, 'II', 'Andante con moto', 'Cello Sonata in A major, op. 80: II. Andante con moto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 19475 AND p.composer_id = 263
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:753821ec-b889-4440-be84-811f4e0f975b'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = 'Allegro vivace', part.name_en = 'Cello Sonata in A major, op. 80: III. Allegro vivace',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 19475 AND p.composer_id = 263 AND part.part_key = 'musicbrainz:aa0e587a-ee98-4f31-877c-023301988f6e' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:aa0e587a-ee98-4f31-877c-023301988f6e', 3, 'III', 'Allegro vivace', 'Cello Sonata in A major, op. 80: III. Allegro vivace', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 19475 AND p.composer_id = 263
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:aa0e587a-ee98-4f31-877c-023301988f6e'
);


-- Op. 75 Chansons de mer Op. 75

UPDATE pieces piece
SET piece.title = 'Chansons de mer Op. 75', piece.title_en = 'Chansons de mer, op. 75',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = 'Op.', piece.catalogue_number = '75',
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 19791 AND piece.composer_id = 263
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'La mer', part.name_en = 'Chansons de mer, op. 75: No. 1. La mer',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 19791 AND p.composer_id = 263 AND part.part_key = 'musicbrainz:aeb7f6b8-3575-44b2-88d3-243f06691a2e' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:aeb7f6b8-3575-44b2-88d3-243f06691a2e', 1, NULL, 'La mer', 'Chansons de mer, op. 75: No. 1. La mer', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 19791 AND p.composer_id = 263
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:aeb7f6b8-3575-44b2-88d3-243f06691a2e'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'A mi-voix', part.name_en = 'Chansons de mer, op. 75: No. 2. A mi-voix',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 19791 AND p.composer_id = 263 AND part.part_key = 'musicbrainz:b7349de6-c7d3-4d44-a171-9a76342bb05a' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:b7349de6-c7d3-4d44-a171-9a76342bb05a', 2, NULL, 'A mi-voix', 'Chansons de mer, op. 75: No. 2. A mi-voix', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 19791 AND p.composer_id = 263
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:b7349de6-c7d3-4d44-a171-9a76342bb05a'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = NULL,
    part.name_ko = 'Sérénade Italienne', part.name_en = 'Chansons de mer, op. 75: No. 3. Sérénade Italienne',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 19791 AND p.composer_id = 263 AND part.part_key = 'musicbrainz:9a37397e-1e20-475b-bf8c-b397715bba5d' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:9a37397e-1e20-475b-bf8c-b397715bba5d', 3, NULL, 'Sérénade Italienne', 'Chansons de mer, op. 75: No. 3. Sérénade Italienne', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 19791 AND p.composer_id = 263
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:9a37397e-1e20-475b-bf8c-b397715bba5d'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = NULL,
    part.name_ko = 'Encore un soir qui tombe', part.name_en = 'Chansons de mer, op. 75: No. 4. Encore un soir qui tombe',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 19791 AND p.composer_id = 263 AND part.part_key = 'musicbrainz:547bd1c9-4ef1-45fd-aa60-b9d04bf6582f' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:547bd1c9-4ef1-45fd-aa60-b9d04bf6582f', 4, NULL, 'Encore un soir qui tombe', 'Chansons de mer, op. 75: No. 4. Encore un soir qui tombe', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 19791 AND p.composer_id = 263
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:547bd1c9-4ef1-45fd-aa60-b9d04bf6582f'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 5, part.movement_number = NULL,
    part.name_ko = 'La petite couleuvre bleue', part.name_en = 'Chansons de mer, op. 75: No. 5. La petite couleuvre bleue',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 19791 AND p.composer_id = 263 AND part.part_key = 'musicbrainz:f56acc2f-1e4b-4978-bc8e-858d01d388b9' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:f56acc2f-1e4b-4978-bc8e-858d01d388b9', 5, NULL, 'La petite couleuvre bleue', 'Chansons de mer, op. 75: No. 5. La petite couleuvre bleue', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 19791 AND p.composer_id = 263
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:f56acc2f-1e4b-4978-bc8e-858d01d388b9'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 6, part.movement_number = NULL,
    part.name_ko = 'A l’aube', part.name_en = 'Chansons de mer, op. 75: No. 6. A l’aube',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 19791 AND p.composer_id = 263 AND part.part_key = 'musicbrainz:31bacebc-afcd-4030-b20c-1841ab225c7b' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:31bacebc-afcd-4030-b20c-1841ab225c7b', 6, NULL, 'A l’aube', 'Chansons de mer, op. 75: No. 6. A l’aube', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 19791 AND p.composer_id = 263
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:31bacebc-afcd-4030-b20c-1841ab225c7b'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 7, part.movement_number = NULL,
    part.name_ko = 'Ce monde meilleur', part.name_en = 'Chansons de mer, op. 75: No. 7. Ce monde meilleur',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 19791 AND p.composer_id = 263 AND part.part_key = 'musicbrainz:14659f0e-2138-4439-946b-0faa94d4651e' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:14659f0e-2138-4439-946b-0faa94d4651e', 7, NULL, 'Ce monde meilleur', 'Chansons de mer, op. 75: No. 7. Ce monde meilleur', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 19791 AND p.composer_id = 263
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:14659f0e-2138-4439-946b-0faa94d4651e'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 8, part.movement_number = NULL,
    part.name_ko = 'Rosa, la rose', part.name_en = 'Chansons de mer, op. 75: No. 8. Rosa, la rose',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 19791 AND p.composer_id = 263 AND part.part_key = 'musicbrainz:a74a409b-aaf2-43ab-a5a7-12c02f2f791e' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:a74a409b-aaf2-43ab-a5a7-12c02f2f791e', 8, NULL, 'Rosa, la rose', 'Chansons de mer, op. 75: No. 8. Rosa, la rose', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 19791 AND p.composer_id = 263
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:a74a409b-aaf2-43ab-a5a7-12c02f2f791e'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 9, part.movement_number = NULL,
    part.name_ko = 'Seul dans la nuit', part.name_en = 'Chansons de mer, op. 75: No. 9. Seul dans la nuit',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 19791 AND p.composer_id = 263 AND part.part_key = 'musicbrainz:f78020e3-fbba-4bce-b280-fdcf514bf124' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:f78020e3-fbba-4bce-b280-fdcf514bf124', 9, NULL, 'Seul dans la nuit', 'Chansons de mer, op. 75: No. 9. Seul dans la nuit', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 19791 AND p.composer_id = 263
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:f78020e3-fbba-4bce-b280-fdcf514bf124'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 10, part.movement_number = NULL,
    part.name_ko = 'Les nuages', part.name_en = 'Chansons de mer, op. 75: No. 10. Les nuages',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 19791 AND p.composer_id = 263 AND part.part_key = 'musicbrainz:f5bb11d9-7d0d-4f34-b7f0-7b4fcd6840cf' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:f5bb11d9-7d0d-4f34-b7f0-7b4fcd6840cf', 10, NULL, 'Les nuages', 'Chansons de mer, op. 75: No. 10. Les nuages', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 19791 AND p.composer_id = 263
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:f5bb11d9-7d0d-4f34-b7f0-7b4fcd6840cf'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 11, part.movement_number = NULL,
    part.name_ko = 'Douleur précoce', part.name_en = 'Chansons de mer, op. 75: No. 11. Douleur précoce',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 19791 AND p.composer_id = 263 AND part.part_key = 'musicbrainz:609760dd-7207-4ca2-893c-38d2356e8bd3' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:609760dd-7207-4ca2-893c-38d2356e8bd3', 11, NULL, 'Douleur précoce', 'Chansons de mer, op. 75: No. 11. Douleur précoce', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 19791 AND p.composer_id = 263
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:609760dd-7207-4ca2-893c-38d2356e8bd3'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 12, part.movement_number = NULL,
    part.name_ko = 'Le ciel d’hiver', part.name_en = 'Chansons de mer, op. 75: No. 12. Le ciel d’hiver',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 19791 AND p.composer_id = 263 AND part.part_key = 'musicbrainz:d3dd3dd1-bb89-47ee-aaaa-8a2d4a7732d8' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:d3dd3dd1-bb89-47ee-aaaa-8a2d4a7732d8', 12, NULL, 'Le ciel d’hiver', 'Chansons de mer, op. 75: No. 12. Le ciel d’hiver', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 19791 AND p.composer_id = 263
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:d3dd3dd1-bb89-47ee-aaaa-8a2d4a7732d8'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 13, part.movement_number = NULL,
    part.name_ko = 'Les yeux et la voix', part.name_en = 'Chansons de mer, op. 75: No. 13. Les yeux et la voix',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 19791 AND p.composer_id = 263 AND part.part_key = 'musicbrainz:9a480c8b-e661-40f6-a40f-c36ff76279b0' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:9a480c8b-e661-40f6-a40f-c36ff76279b0', 13, NULL, 'Les yeux et la voix', 'Chansons de mer, op. 75: No. 13. Les yeux et la voix', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 19791 AND p.composer_id = 263
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:9a480c8b-e661-40f6-a40f-c36ff76279b0'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 14, part.movement_number = NULL,
    part.name_ko = 'Repos éternel', part.name_en = 'Chansons de mer, op. 75: No. 14. Repos éternel',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 19791 AND p.composer_id = 263 AND part.part_key = 'musicbrainz:a5ca60af-291c-416a-9662-a1c9c20aa4e6' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:a5ca60af-291c-416a-9662-a1c9c20aa4e6', 14, NULL, 'Repos éternel', 'Chansons de mer, op. 75: No. 14. Repos éternel', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 19791 AND p.composer_id = 263
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:a5ca60af-291c-416a-9662-a1c9c20aa4e6'
);


-- Op. 64 부수음악 <Conte d'avril>

UPDATE pieces piece
SET piece.title = '부수음악 <Conte d''avril>', piece.title_en = 'Conte d''avril, op. 64',
    piece.type = 'song', piece.opus_number = 'Op. 64',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 19736 AND piece.composer_id = 263
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None 가곡 <Dormez, Mèlité…>

UPDATE pieces piece
SET piece.title = '가곡 <Dormez, Mèlité…>', piece.title_en = 'Dormez, Mèlité…',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 17712 AND piece.composer_id = 263
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- Op. 62 환상곡 A♭장조

UPDATE pieces piece
SET piece.title = '환상곡 A♭장조', piece.title_en = 'Fantaisie in A-flat major, op. 62',
    piece.type = 'song', piece.opus_number = 'Op. 62',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 18485 AND piece.composer_id = 263
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Fugue sur le nom d'Haydn

UPDATE pieces piece
SET piece.title = 'Fugue sur le nom d''Haydn', piece.title_en = 'Fugue sur le nom d''Haydn',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 16087 AND piece.composer_id = 263
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- Op. 60 La Nuit de Walpurgis

UPDATE pieces piece
SET piece.title = 'La Nuit de Walpurgis', piece.title_en = 'La Nuit de Walpurgis, op. 60',
    piece.type = 'album', piece.opus_number = 'Op. 60',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 17639 AND piece.composer_id = 263
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'Overture (Adagio - Allegro con fuoco)', part.name_en = 'La Nuit de Walpurgis, op. 60: I. Overture (Adagio - Allegro con fuoco)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 17639 AND p.composer_id = 263 AND part.part_key = 'musicbrainz:64075d42-5d3f-4d18-b8ce-20818f077b81' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:64075d42-5d3f-4d18-b8ce-20818f077b81', 1, 'I', 'Overture (Adagio - Allegro con fuoco)', 'La Nuit de Walpurgis, op. 60: I. Overture (Adagio - Allegro con fuoco)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 17639 AND p.composer_id = 263
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:64075d42-5d3f-4d18-b8ce-20818f077b81'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'Adagio ("Apparition of Helen and Faust")', part.name_en = 'La Nuit de Walpurgis, op. 60: II. Adagio ("Apparition of Helen and Faust")',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 17639 AND p.composer_id = 263 AND part.part_key = 'musicbrainz:456e2ac7-b3ce-40bb-b99e-59cb8c2b53cb' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:456e2ac7-b3ce-40bb-b99e-59cb8c2b53cb', 2, 'II', 'Adagio ("Apparition of Helen and Faust")', 'La Nuit de Walpurgis, op. 60: II. Adagio ("Apparition of Helen and Faust")', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 17639 AND p.composer_id = 263
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:456e2ac7-b3ce-40bb-b99e-59cb8c2b53cb'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = 'Bacchanale (Andante quasi adagio - Allegro con fuoco)', part.name_en = 'La Nuit de Walpurgis, op. 60: III. Bacchanale (Andante quasi adagio - Allegro con fuoco)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 17639 AND p.composer_id = 263 AND part.part_key = 'musicbrainz:4372c344-db0d-44e3-96b3-22c3abff6b6e' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:4372c344-db0d-44e3-96b3-22c3abff6b6e', 3, 'III', 'Bacchanale (Andante quasi adagio - Allegro con fuoco)', 'La Nuit de Walpurgis, op. 60: III. Bacchanale (Andante quasi adagio - Allegro con fuoco)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 17639 AND p.composer_id = 263
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:4372c344-db0d-44e3-96b3-22c3abff6b6e'
);


-- None 발레 <La korrigane>

UPDATE pieces piece
SET piece.title = '발레 <La korrigane>', piece.title_en = 'La korrigane',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 16241 AND piece.composer_id = 263
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None 가곡 <La nuit>

UPDATE pieces piece
SET piece.title = '가곡 <La nuit>', piece.title_en = 'La nuit',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 19434 AND piece.composer_id = 263
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None 오페라 <Les Pêcheurs de Saint-Jean>

UPDATE pieces piece
SET piece.title = '오페라 <Les Pêcheurs de Saint-Jean>', piece.title_en = 'Les Pêcheurs de Saint-Jean',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 18547 AND piece.composer_id = 263
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Marche nuptiale (Conte d'avril)

UPDATE pieces piece
SET piece.title = 'Marche nuptiale (Conte d''avril)', piece.title_en = 'Marche nuptiale (Conte d''avril)',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 19670 AND piece.composer_id = 263
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None 오페라 <Maître Ambros>

UPDATE pieces piece
SET piece.title = '오페라 <Maître Ambros>', piece.title_en = 'Maître Ambros',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 16536 AND piece.composer_id = 263
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- Op. 36 Messe à deux chœurs et deux orgues Op. 36

UPDATE pieces piece
SET piece.title = 'Messe à deux chœurs et deux orgues Op. 36', piece.title_en = 'Messe à deux chœurs et deux orgues, op. 36',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = 'Op.', piece.catalogue_number = '36',
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 18960 AND piece.composer_id = 263
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'Kyrie', part.name_en = 'Messe à deux chœurs et deux orgues, op. 36: Kyrie',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 18960 AND p.composer_id = 263 AND part.part_key = 'musicbrainz:322460f7-62dd-4f54-9a34-8700f9a26e49' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:322460f7-62dd-4f54-9a34-8700f9a26e49', 1, NULL, 'Kyrie', 'Messe à deux chœurs et deux orgues, op. 36: Kyrie', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 18960 AND p.composer_id = 263
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:322460f7-62dd-4f54-9a34-8700f9a26e49'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'Gloria', part.name_en = 'Messe à deux chœurs et deux orgues, op. 36: Gloria',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 18960 AND p.composer_id = 263 AND part.part_key = 'musicbrainz:74954976-66c1-40ce-abb0-b4f505d3fc8a' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:74954976-66c1-40ce-abb0-b4f505d3fc8a', 2, NULL, 'Gloria', 'Messe à deux chœurs et deux orgues, op. 36: Gloria', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 18960 AND p.composer_id = 263
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:74954976-66c1-40ce-abb0-b4f505d3fc8a'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = NULL,
    part.name_ko = 'Sanctus', part.name_en = 'Messe à deux chœurs et deux orgues, op. 36: Sanctus',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 18960 AND p.composer_id = 263 AND part.part_key = 'musicbrainz:0fcb79be-9363-411f-8fe8-b682b6e7b48c' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:0fcb79be-9363-411f-8fe8-b682b6e7b48c', 3, NULL, 'Sanctus', 'Messe à deux chœurs et deux orgues, op. 36: Sanctus', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 18960 AND p.composer_id = 263
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:0fcb79be-9363-411f-8fe8-b682b6e7b48c'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = NULL,
    part.name_ko = 'Benedictus', part.name_en = 'Messe à deux chœurs et deux orgues, op. 36: Benedictus',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 18960 AND p.composer_id = 263 AND part.part_key = 'musicbrainz:062ea341-4216-497c-830a-7a42046be0b1' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:062ea341-4216-497c-830a-7a42046be0b1', 4, NULL, 'Benedictus', 'Messe à deux chœurs et deux orgues, op. 36: Benedictus', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 18960 AND p.composer_id = 263
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:062ea341-4216-497c-830a-7a42046be0b1'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 5, part.movement_number = NULL,
    part.name_ko = 'Agnus Dei', part.name_en = 'Messe à deux chœurs et deux orgues, op. 36: Agnus Dei',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 18960 AND p.composer_id = 263 AND part.part_key = 'musicbrainz:9d9f41c0-5eb2-4e39-aa03-6207a8d63596' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:9d9f41c0-5eb2-4e39-aa03-6207a8d63596', 5, NULL, 'Agnus Dei', 'Messe à deux chœurs et deux orgues, op. 36: Agnus Dei', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 18960 AND p.composer_id = 263
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:9d9f41c0-5eb2-4e39-aa03-6207a8d63596'
);


-- None 가곡 <Nuit mystérieuse>

UPDATE pieces piece
SET piece.title = '가곡 <Nuit mystérieuse>', piece.title_en = 'Nuit mystérieuse',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 16105 AND piece.composer_id = 263
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- Op. 13 Organ Symphonies Op. 13

UPDATE pieces piece
SET piece.title = 'Organ Symphonies Op. 13', piece.title_en = 'Organ Symphonies, op. 13',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = 'Op.', piece.catalogue_number = '13',
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 16628 AND piece.composer_id = 263
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'Organ Symphony no. 1 in C minor, op. 13 no. 1', part.name_en = 'Organ Symphony no. 1 in C minor, op. 13 no. 1',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 16628 AND p.composer_id = 263 AND part.part_key = 'musicbrainz:1bb55cdd-3e53-481f-a90c-6a34633c91a8' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:1bb55cdd-3e53-481f-a90c-6a34633c91a8', 1, NULL, 'Organ Symphony no. 1 in C minor, op. 13 no. 1', 'Organ Symphony no. 1 in C minor, op. 13 no. 1', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 16628 AND p.composer_id = 263
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:1bb55cdd-3e53-481f-a90c-6a34633c91a8'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:1bb55cdd-3e53-481f-a90c-6a34633c91a8'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'Prélude (Moderato)', part.name_en = 'Organ Symphony no. 1 in C minor, op. 13 no. 1: I. Prélude (Moderato)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 16628 AND p.composer_id = 263 AND part.part_key = 'musicbrainz:fff1d412-b3cb-4b0f-b2c7-7432b7e34909' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:fff1d412-b3cb-4b0f-b2c7-7432b7e34909', 1, NULL, 'Prélude (Moderato)', 'Organ Symphony no. 1 in C minor, op. 13 no. 1: I. Prélude (Moderato)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:1bb55cdd-3e53-481f-a90c-6a34633c91a8'
WHERE p.id = 16628 AND p.composer_id = 263
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:fff1d412-b3cb-4b0f-b2c7-7432b7e34909'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:1bb55cdd-3e53-481f-a90c-6a34633c91a8'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'Intermezzo (Allegro)', part.name_en = 'Organ Symphony no. 1 in C minor, op. 13 no. 1: III. Intermezzo (Allegro)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 16628 AND p.composer_id = 263 AND part.part_key = 'musicbrainz:025010f2-5385-4c09-bebd-81ba567f3259' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:025010f2-5385-4c09-bebd-81ba567f3259', 2, NULL, 'Intermezzo (Allegro)', 'Organ Symphony no. 1 in C minor, op. 13 no. 1: III. Intermezzo (Allegro)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:1bb55cdd-3e53-481f-a90c-6a34633c91a8'
WHERE p.id = 16628 AND p.composer_id = 263
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:025010f2-5385-4c09-bebd-81ba567f3259'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:1bb55cdd-3e53-481f-a90c-6a34633c91a8'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = NULL,
    part.name_ko = 'Adagio', part.name_en = 'Organ Symphony no. 1 in C minor, op. 13 no. 1: IV. Adagio',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 16628 AND p.composer_id = 263 AND part.part_key = 'musicbrainz:609d3dbf-fb97-4c59-9604-c0bed341c006' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:609d3dbf-fb97-4c59-9604-c0bed341c006', 3, NULL, 'Adagio', 'Organ Symphony no. 1 in C minor, op. 13 no. 1: IV. Adagio', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:1bb55cdd-3e53-481f-a90c-6a34633c91a8'
WHERE p.id = 16628 AND p.composer_id = 263
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:609d3dbf-fb97-4c59-9604-c0bed341c006'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:1bb55cdd-3e53-481f-a90c-6a34633c91a8'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = NULL,
    part.name_ko = 'Marche pontificale', part.name_en = 'Organ Symphony no. 1 in C minor, op. 13 no. 1: V. Marche pontificale',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 16628 AND p.composer_id = 263 AND part.part_key = 'musicbrainz:a76ce604-f95c-4176-864b-cae7d0bb7a8d' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:a76ce604-f95c-4176-864b-cae7d0bb7a8d', 4, NULL, 'Marche pontificale', 'Organ Symphony no. 1 in C minor, op. 13 no. 1: V. Marche pontificale', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:1bb55cdd-3e53-481f-a90c-6a34633c91a8'
WHERE p.id = 16628 AND p.composer_id = 263
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:a76ce604-f95c-4176-864b-cae7d0bb7a8d'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:1bb55cdd-3e53-481f-a90c-6a34633c91a8'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 5, part.movement_number = NULL,
    part.name_ko = 'Méditation (Lento)', part.name_en = 'Organ Symphony no. 1 in C minor, op. 13 no. 1: VI. Méditation (Lento)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 16628 AND p.composer_id = 263 AND part.part_key = 'musicbrainz:6e651d4d-c963-4c80-85f8-81a51ee458db' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:6e651d4d-c963-4c80-85f8-81a51ee458db', 5, NULL, 'Méditation (Lento)', 'Organ Symphony no. 1 in C minor, op. 13 no. 1: VI. Méditation (Lento)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:1bb55cdd-3e53-481f-a90c-6a34633c91a8'
WHERE p.id = 16628 AND p.composer_id = 263
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:6e651d4d-c963-4c80-85f8-81a51ee458db'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'Organ Symphony no. 2 in D major, op. 13 no. 2', part.name_en = 'Organ Symphony no. 2 in D major, op. 13 no. 2',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 16628 AND p.composer_id = 263 AND part.part_key = 'musicbrainz:233bb4f3-525f-4762-bc0f-76f2571bbab7' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:233bb4f3-525f-4762-bc0f-76f2571bbab7', 2, NULL, 'Organ Symphony no. 2 in D major, op. 13 no. 2', 'Organ Symphony no. 2 in D major, op. 13 no. 2', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 16628 AND p.composer_id = 263
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:233bb4f3-525f-4762-bc0f-76f2571bbab7'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:233bb4f3-525f-4762-bc0f-76f2571bbab7'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'Pastorale (Moderato)', part.name_en = 'Organ Symphony no. 2 in D major, op. 13 no. 2: II. Pastorale (Moderato)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 16628 AND p.composer_id = 263 AND part.part_key = 'musicbrainz:db012abe-30e2-49a8-8e90-1dbdb2c27e5e' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:db012abe-30e2-49a8-8e90-1dbdb2c27e5e', 1, NULL, 'Pastorale (Moderato)', 'Organ Symphony no. 2 in D major, op. 13 no. 2: II. Pastorale (Moderato)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:233bb4f3-525f-4762-bc0f-76f2571bbab7'
WHERE p.id = 16628 AND p.composer_id = 263
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:db012abe-30e2-49a8-8e90-1dbdb2c27e5e'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:233bb4f3-525f-4762-bc0f-76f2571bbab7'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'Andante', part.name_en = 'Organ Symphony no. 2 in D major, op. 13 no. 2: III. Andante',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 16628 AND p.composer_id = 263 AND part.part_key = 'musicbrainz:55544abf-1eed-4545-b70a-62446f2d2069' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:55544abf-1eed-4545-b70a-62446f2d2069', 2, NULL, 'Andante', 'Organ Symphony no. 2 in D major, op. 13 no. 2: III. Andante', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:233bb4f3-525f-4762-bc0f-76f2571bbab7'
WHERE p.id = 16628 AND p.composer_id = 263
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:55544abf-1eed-4545-b70a-62446f2d2069'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:233bb4f3-525f-4762-bc0f-76f2571bbab7'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = NULL,
    part.name_ko = 'Salve Regina', part.name_en = 'Organ Symphony no. 2 in D major, op. 13 no. 2: IV. Salve Regina',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 16628 AND p.composer_id = 263 AND part.part_key = 'musicbrainz:6f469880-f6a4-40f8-8992-2e1d6e3ce4a7' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:6f469880-f6a4-40f8-8992-2e1d6e3ce4a7', 3, NULL, 'Salve Regina', 'Organ Symphony no. 2 in D major, op. 13 no. 2: IV. Salve Regina', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:233bb4f3-525f-4762-bc0f-76f2571bbab7'
WHERE p.id = 16628 AND p.composer_id = 263
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:6f469880-f6a4-40f8-8992-2e1d6e3ce4a7'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:233bb4f3-525f-4762-bc0f-76f2571bbab7'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = NULL,
    part.name_ko = 'Adagio (Andante)', part.name_en = 'Organ Symphony no. 2 in D major, op. 13 no. 2: V. Adagio (Andante)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 16628 AND p.composer_id = 263 AND part.part_key = 'musicbrainz:a13d690b-777d-4009-ab11-d9b7b824465c' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:a13d690b-777d-4009-ab11-d9b7b824465c', 4, NULL, 'Adagio (Andante)', 'Organ Symphony no. 2 in D major, op. 13 no. 2: V. Adagio (Andante)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:233bb4f3-525f-4762-bc0f-76f2571bbab7'
WHERE p.id = 16628 AND p.composer_id = 263
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:a13d690b-777d-4009-ab11-d9b7b824465c'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:233bb4f3-525f-4762-bc0f-76f2571bbab7'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 5, part.movement_number = NULL,
    part.name_ko = 'Finale (Allegro)', part.name_en = 'Organ Symphony no. 2 in D major, op. 13 no. 2: VI. Finale (Allegro)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 16628 AND p.composer_id = 263 AND part.part_key = 'musicbrainz:00899d83-7399-483f-98f1-60349cf430d2' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:00899d83-7399-483f-98f1-60349cf430d2', 5, NULL, 'Finale (Allegro)', 'Organ Symphony no. 2 in D major, op. 13 no. 2: VI. Finale (Allegro)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:233bb4f3-525f-4762-bc0f-76f2571bbab7'
WHERE p.id = 16628 AND p.composer_id = 263
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:00899d83-7399-483f-98f1-60349cf430d2'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:233bb4f3-525f-4762-bc0f-76f2571bbab7'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 6, part.movement_number = NULL,
    part.name_ko = 'Scherzo (Allegro)', part.name_en = 'Organ Symphony no. 2 in D major, op. 13 no. 2: VII. Scherzo (Allegro)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 16628 AND p.composer_id = 263 AND part.part_key = 'musicbrainz:1d230c1f-636d-48ef-8e87-10a1c206e213' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:1d230c1f-636d-48ef-8e87-10a1c206e213', 6, NULL, 'Scherzo (Allegro)', 'Organ Symphony no. 2 in D major, op. 13 no. 2: VII. Scherzo (Allegro)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:233bb4f3-525f-4762-bc0f-76f2571bbab7'
WHERE p.id = 16628 AND p.composer_id = 263
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:1d230c1f-636d-48ef-8e87-10a1c206e213'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = NULL,
    part.name_ko = 'Organ Symphony no. 4 in F minor, op. 13 no. 4', part.name_en = 'Organ Symphony no. 4 in F minor, op. 13 no. 4',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 16628 AND p.composer_id = 263 AND part.part_key = 'musicbrainz:fcffd618-a5d5-40e5-beb1-05bcdbd0a0b5' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:fcffd618-a5d5-40e5-beb1-05bcdbd0a0b5', 3, NULL, 'Organ Symphony no. 4 in F minor, op. 13 no. 4', 'Organ Symphony no. 4 in F minor, op. 13 no. 4', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 16628 AND p.composer_id = 263
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:fcffd618-a5d5-40e5-beb1-05bcdbd0a0b5'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:fcffd618-a5d5-40e5-beb1-05bcdbd0a0b5'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'Toccata', part.name_en = 'Organ Symphony no. 4 in F minor, op. 13 no. 4: I. Toccata',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 16628 AND p.composer_id = 263 AND part.part_key = 'musicbrainz:ac1088e2-d432-4ecc-99db-f20b49ec9439' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:ac1088e2-d432-4ecc-99db-f20b49ec9439', 1, NULL, 'Toccata', 'Organ Symphony no. 4 in F minor, op. 13 no. 4: I. Toccata', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:fcffd618-a5d5-40e5-beb1-05bcdbd0a0b5'
WHERE p.id = 16628 AND p.composer_id = 263
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:ac1088e2-d432-4ecc-99db-f20b49ec9439'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:fcffd618-a5d5-40e5-beb1-05bcdbd0a0b5'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'Fugue (Moderato assai)', part.name_en = 'Organ Symphony no. 4 in F minor, op. 13 no. 4: II. Fugue (Moderato assai)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 16628 AND p.composer_id = 263 AND part.part_key = 'musicbrainz:28d6bcb3-311c-439c-9563-2ef523c7f557' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:28d6bcb3-311c-439c-9563-2ef523c7f557', 2, NULL, 'Fugue (Moderato assai)', 'Organ Symphony no. 4 in F minor, op. 13 no. 4: II. Fugue (Moderato assai)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:fcffd618-a5d5-40e5-beb1-05bcdbd0a0b5'
WHERE p.id = 16628 AND p.composer_id = 263
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:28d6bcb3-311c-439c-9563-2ef523c7f557'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:fcffd618-a5d5-40e5-beb1-05bcdbd0a0b5'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = NULL,
    part.name_ko = 'Andante cantabile (Dolce)', part.name_en = 'Organ Symphony no. 4 in F minor, op. 13 no. 4: III. Andante cantabile (Dolce)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 16628 AND p.composer_id = 263 AND part.part_key = 'musicbrainz:4fbd1686-8c8b-4b34-afc8-cd93fbc73943' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:4fbd1686-8c8b-4b34-afc8-cd93fbc73943', 3, NULL, 'Andante cantabile (Dolce)', 'Organ Symphony no. 4 in F minor, op. 13 no. 4: III. Andante cantabile (Dolce)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:fcffd618-a5d5-40e5-beb1-05bcdbd0a0b5'
WHERE p.id = 16628 AND p.composer_id = 263
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:4fbd1686-8c8b-4b34-afc8-cd93fbc73943'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:fcffd618-a5d5-40e5-beb1-05bcdbd0a0b5'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = NULL,
    part.name_ko = 'Scherzo (Allegro vivace)', part.name_en = 'Organ Symphony no. 4 in F minor, op. 13 no. 4: IV. Scherzo (Allegro vivace)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 16628 AND p.composer_id = 263 AND part.part_key = 'musicbrainz:033efc9e-019a-4b40-ab6d-a7894e2c04c1' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:033efc9e-019a-4b40-ab6d-a7894e2c04c1', 4, NULL, 'Scherzo (Allegro vivace)', 'Organ Symphony no. 4 in F minor, op. 13 no. 4: IV. Scherzo (Allegro vivace)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:fcffd618-a5d5-40e5-beb1-05bcdbd0a0b5'
WHERE p.id = 16628 AND p.composer_id = 263
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:033efc9e-019a-4b40-ab6d-a7894e2c04c1'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:fcffd618-a5d5-40e5-beb1-05bcdbd0a0b5'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 5, part.movement_number = NULL,
    part.name_ko = 'Adagio', part.name_en = 'Organ Symphony no. 4 in F minor, op. 13 no. 4: V. Adagio',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 16628 AND p.composer_id = 263 AND part.part_key = 'musicbrainz:5974008a-13bd-4510-9c4d-ef0284133f0d' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:5974008a-13bd-4510-9c4d-ef0284133f0d', 5, NULL, 'Adagio', 'Organ Symphony no. 4 in F minor, op. 13 no. 4: V. Adagio', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:fcffd618-a5d5-40e5-beb1-05bcdbd0a0b5'
WHERE p.id = 16628 AND p.composer_id = 263
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:5974008a-13bd-4510-9c4d-ef0284133f0d'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:fcffd618-a5d5-40e5-beb1-05bcdbd0a0b5'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 6, part.movement_number = NULL,
    part.name_ko = 'Finale (Moderato)', part.name_en = 'Organ Symphony no. 4 in F minor, op. 13 no. 4: VI. Finale (Moderato)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 16628 AND p.composer_id = 263 AND part.part_key = 'musicbrainz:f737b7ea-f32c-494c-81c1-631a7c02799e' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:f737b7ea-f32c-494c-81c1-631a7c02799e', 6, NULL, 'Finale (Moderato)', 'Organ Symphony no. 4 in F minor, op. 13 no. 4: VI. Finale (Moderato)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:fcffd618-a5d5-40e5-beb1-05bcdbd0a0b5'
WHERE p.id = 16628 AND p.composer_id = 263
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:f737b7ea-f32c-494c-81c1-631a7c02799e'
);


-- None Organ Symphony no. 1 in C minor, op. 13 no. 1: II. Allegro

UPDATE pieces piece
SET piece.title = 'Organ Symphony no. 1 in C minor, op. 13 no. 1: II. Allegro', piece.title_en = 'Organ Symphony no. 1 in C minor, op. 13 no. 1: II. Allegro',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 17542 AND piece.composer_id = 263
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Organ Symphony no. 2 in D major, op. 13 no. 2: I. Prélude

UPDATE pieces piece
SET piece.title = 'Organ Symphony no. 2 in D major, op. 13 no. 2: I. Prélude', piece.title_en = 'Organ Symphony no. 2 in D major, op. 13 no. 2: I. Prélude',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 19455 AND piece.composer_id = 263
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None 가곡 <Oublieras-tu que d’heures douces>

UPDATE pieces piece
SET piece.title = '가곡 <Oublieras-tu que d’heures douces>', piece.title_en = 'Oublieras-tu que d’heures douces',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 19119 AND piece.composer_id = 263
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- Op. 39 피아노 협주곡 1번 F단조

UPDATE pieces piece
SET piece.title = '피아노 협주곡 1번 F단조', piece.title_en = 'Piano Concerto no. 1 in F minor, op. 39',
    piece.type = 'album', piece.opus_number = 'Op. 39',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 17763 AND piece.composer_id = 263
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'Allegro con fuoco', part.name_en = 'Piano Concerto no. 1 in F minor, op. 39: I. Allegro con fuoco',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 17763 AND p.composer_id = 263 AND part.part_key = 'musicbrainz:ab4e0ebc-99f7-4dc9-ba74-a6bc142c4699' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:ab4e0ebc-99f7-4dc9-ba74-a6bc142c4699', 1, 'I', 'Allegro con fuoco', 'Piano Concerto no. 1 in F minor, op. 39: I. Allegro con fuoco', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 17763 AND p.composer_id = 263
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:ab4e0ebc-99f7-4dc9-ba74-a6bc142c4699'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'Andante religioso', part.name_en = 'Piano Concerto no. 1 in F minor, op. 39: II. Andante religioso',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 17763 AND p.composer_id = 263 AND part.part_key = 'musicbrainz:4be55673-260a-4660-9904-04b3660dd87a' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:4be55673-260a-4660-9904-04b3660dd87a', 2, 'II', 'Andante religioso', 'Piano Concerto no. 1 in F minor, op. 39: II. Andante religioso', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 17763 AND p.composer_id = 263
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:4be55673-260a-4660-9904-04b3660dd87a'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = 'Allegro', part.name_en = 'Piano Concerto no. 1 in F minor, op. 39: III. Allegro',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 17763 AND p.composer_id = 263 AND part.part_key = 'musicbrainz:4ac9721b-9fd0-4bf6-9cd4-c5dc823ad50b' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:4ac9721b-9fd0-4bf6-9cd4-c5dc823ad50b', 3, 'III', 'Allegro', 'Piano Concerto no. 1 in F minor, op. 39: III. Allegro', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 17763 AND p.composer_id = 263
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:4ac9721b-9fd0-4bf6-9cd4-c5dc823ad50b'
);


-- Op. 77 피아노 협주곡 2번 C단조

UPDATE pieces piece
SET piece.title = '피아노 협주곡 2번 C단조', piece.title_en = 'Piano Concerto no. 2 in C minor, op. 77',
    piece.type = 'album', piece.opus_number = 'Op. 77',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 16018 AND piece.composer_id = 263
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'Allegro con moto patetico', part.name_en = 'Piano Concerto no. 2 in C minor, op. 77: I. Allegro con moto patetico',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 16018 AND p.composer_id = 263 AND part.part_key = 'musicbrainz:c5a89021-3f0d-4d41-9b37-d4f4f170fd57' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:c5a89021-3f0d-4d41-9b37-d4f4f170fd57', 1, 'I', 'Allegro con moto patetico', 'Piano Concerto no. 2 in C minor, op. 77: I. Allegro con moto patetico', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 16018 AND p.composer_id = 263
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:c5a89021-3f0d-4d41-9b37-d4f4f170fd57'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'Andante', part.name_en = 'Piano Concerto no. 2 in C minor, op. 77: II. Andante',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 16018 AND p.composer_id = 263 AND part.part_key = 'musicbrainz:47c8f609-b597-48da-be31-475f5e46210c' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:47c8f609-b597-48da-be31-475f5e46210c', 2, 'II', 'Andante', 'Piano Concerto no. 2 in C minor, op. 77: II. Andante', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 16018 AND p.composer_id = 263
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:47c8f609-b597-48da-be31-475f5e46210c'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = 'Tempo deciso', part.name_en = 'Piano Concerto no. 2 in C minor, op. 77: III. Tempo deciso',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 16018 AND p.composer_id = 263 AND part.part_key = 'musicbrainz:d5225e8e-86e7-4cf6-b875-8d62dad71e66' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:d5225e8e-86e7-4cf6-b875-8d62dad71e66', 3, 'III', 'Tempo deciso', 'Piano Concerto no. 2 in C minor, op. 77: III. Tempo deciso', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 16018 AND p.composer_id = 263
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:d5225e8e-86e7-4cf6-b875-8d62dad71e66'
);


-- Op. 7 피아노 5중주 D단조

UPDATE pieces piece
SET piece.title = '피아노 5중주 D단조', piece.title_en = 'Piano Quintet in D minor for Piano and Strings, op. 7',
    piece.type = 'album', piece.opus_number = 'Op. 7',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 18529 AND piece.composer_id = 263
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'Allegro', part.name_en = 'Piano Quintet in D minor for Piano and Strings, op. 7: I. Allegro',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 18529 AND p.composer_id = 263 AND part.part_key = 'musicbrainz:d85a9862-af52-30ab-af2c-480f8f6aef45' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:d85a9862-af52-30ab-af2c-480f8f6aef45', 1, 'I', 'Allegro', 'Piano Quintet in D minor for Piano and Strings, op. 7: I. Allegro', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 18529 AND p.composer_id = 263
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:d85a9862-af52-30ab-af2c-480f8f6aef45'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'Andante', part.name_en = 'Piano Quintet in D minor for Piano and Strings, op. 7: II. Andante',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 18529 AND p.composer_id = 263 AND part.part_key = 'musicbrainz:dfb6ac55-7780-350b-b625-bdccb1913784' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:dfb6ac55-7780-350b-b625-bdccb1913784', 2, 'II', 'Andante', 'Piano Quintet in D minor for Piano and Strings, op. 7: II. Andante', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 18529 AND p.composer_id = 263
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:dfb6ac55-7780-350b-b625-bdccb1913784'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = 'Molto vivace', part.name_en = 'Piano Quintet in D minor for Piano and Strings, op. 7: III. Molto vivace',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 18529 AND p.composer_id = 263 AND part.part_key = 'musicbrainz:7678944f-b232-35f4-85be-db827fa5bece' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:7678944f-b232-35f4-85be-db827fa5bece', 3, 'III', 'Molto vivace', 'Piano Quintet in D minor for Piano and Strings, op. 7: III. Molto vivace', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 18529 AND p.composer_id = 263
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:7678944f-b232-35f4-85be-db827fa5bece'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = 'IV',
    part.name_ko = 'Allegro con moto', part.name_en = 'Piano Quintet in D minor for Piano and Strings, op. 7: IV. Allegro con moto',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 18529 AND p.composer_id = 263 AND part.part_key = 'musicbrainz:b32f8d86-1e98-3a0e-b9fb-b48769b60c2f' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:b32f8d86-1e98-3a0e-b9fb-b48769b60c2f', 4, 'IV', 'Allegro con moto', 'Piano Quintet in D minor for Piano and Strings, op. 7: IV. Allegro con moto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 18529 AND p.composer_id = 263
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:b32f8d86-1e98-3a0e-b9fb-b48769b60c2f'
);


-- Op. 19 피아노 3중주 B♭장조

UPDATE pieces piece
SET piece.title = '피아노 3중주 B♭장조', piece.title_en = 'Piano Trio in B-flat major for Piano, Violin and Cello, op. 19',
    piece.type = 'album', piece.opus_number = 'Op. 19',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 18643 AND piece.composer_id = 263
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'Allegro', part.name_en = 'Piano Trio in B-flat major for Piano, Violin and Cello, op. 19: I. Allegro',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 18643 AND p.composer_id = 263 AND part.part_key = 'musicbrainz:9363ce91-18ce-3bde-a041-a0b57013513d' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:9363ce91-18ce-3bde-a041-a0b57013513d', 1, 'I', 'Allegro', 'Piano Trio in B-flat major for Piano, Violin and Cello, op. 19: I. Allegro', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 18643 AND p.composer_id = 263
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:9363ce91-18ce-3bde-a041-a0b57013513d'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'Andante con moto quasi moderato', part.name_en = 'Piano Trio in B-flat major for Piano, Violin and Cello, op. 19: II. Andante con moto quasi moderato',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 18643 AND p.composer_id = 263 AND part.part_key = 'musicbrainz:754dfd95-ab58-3f13-8194-564178ae8cb3' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:754dfd95-ab58-3f13-8194-564178ae8cb3', 2, 'II', 'Andante con moto quasi moderato', 'Piano Trio in B-flat major for Piano, Violin and Cello, op. 19: II. Andante con moto quasi moderato', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 18643 AND p.composer_id = 263
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:754dfd95-ab58-3f13-8194-564178ae8cb3'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = 'Scherzo', part.name_en = 'Piano Trio in B-flat major for Piano, Violin and Cello, op. 19: III. Scherzo',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 18643 AND p.composer_id = 263 AND part.part_key = 'musicbrainz:42e0b01f-2423-3d31-823d-c4be5940fdf0' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:42e0b01f-2423-3d31-823d-c4be5940fdf0', 3, 'III', 'Scherzo', 'Piano Trio in B-flat major for Piano, Violin and Cello, op. 19: III. Scherzo', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 18643 AND p.composer_id = 263
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:42e0b01f-2423-3d31-823d-c4be5940fdf0'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = 'IV',
    part.name_ko = 'Presto', part.name_en = 'Piano Trio in B-flat major for Piano, Violin and Cello, op. 19: IV. Presto',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 18643 AND p.composer_id = 263 AND part.part_key = 'musicbrainz:96175de2-0ee6-32ab-b5fa-44fd2a0fbbfe' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:96175de2-0ee6-32ab-b5fa-44fd2a0fbbfe', 4, 'IV', 'Presto', 'Piano Trio in B-flat major for Piano, Violin and Cello, op. 19: IV. Presto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 18643 AND p.composer_id = 263
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:96175de2-0ee6-32ab-b5fa-44fd2a0fbbfe'
);


-- Op. 23 No. 1 Psalm 83

UPDATE pieces piece
SET piece.title = 'Psalm 83', piece.title_en = 'Psalm 83, op. 23 no. 1',
    piece.type = 'song', piece.opus_number = 'Op. 23 No. 1',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 17389 AND piece.composer_id = 263
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Quatre Pièces en trio

UPDATE pieces piece
SET piece.title = 'Quatre Pièces en trio', piece.title_en = 'Quatre Pièces en trio',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 18454 AND piece.composer_id = 263
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'Humoresque', part.name_en = 'Quatre Pièces en trio: I. Humoresque',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 18454 AND p.composer_id = 263 AND part.part_key = 'musicbrainz:381c8dd7-37a9-4ee3-8744-206a149de84b' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:381c8dd7-37a9-4ee3-8744-206a149de84b', 1, 'I', 'Humoresque', 'Quatre Pièces en trio: I. Humoresque', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 18454 AND p.composer_id = 263
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:381c8dd7-37a9-4ee3-8744-206a149de84b'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'Cantabile', part.name_en = 'Quatre Pièces en trio: II. Cantabile',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 18454 AND p.composer_id = 263 AND part.part_key = 'musicbrainz:bbbea1ae-8f53-4fa9-afd2-df377827d85f' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:bbbea1ae-8f53-4fa9-afd2-df377827d85f', 2, 'II', 'Cantabile', 'Quatre Pièces en trio: II. Cantabile', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 18454 AND p.composer_id = 263
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:bbbea1ae-8f53-4fa9-afd2-df377827d85f'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = 'Nocturne', part.name_en = 'Quatre Pièces en trio: III. Nocturne',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 18454 AND p.composer_id = 263 AND part.part_key = 'musicbrainz:40a8cc7d-48a9-4600-80f9-4904abc3d06c' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:40a8cc7d-48a9-4600-80f9-4904abc3d06c', 3, 'III', 'Nocturne', 'Quatre Pièces en trio: III. Nocturne', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 18454 AND p.composer_id = 263
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:40a8cc7d-48a9-4600-80f9-4904abc3d06c'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = 'IV',
    part.name_ko = 'Sérénade', part.name_en = 'Quatre Pièces en trio: IV. Sérénade',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 18454 AND p.composer_id = 263 AND part.part_key = 'musicbrainz:07694198-edc5-4508-a5e5-9ce192eb0f09' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:07694198-edc5-4508-a5e5-9ce192eb0f09', 4, 'IV', 'Sérénade', 'Quatre Pièces en trio: IV. Sérénade', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 18454 AND p.composer_id = 263
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:07694198-edc5-4508-a5e5-9ce192eb0f09'
);


-- Op. 46 Romance pour violon et piano

UPDATE pieces piece
SET piece.title = 'Romance pour violon et piano', piece.title_en = 'Romance pour violon et piano, op. 46',
    piece.type = 'song', piece.opus_number = 'Op. 46',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 16216 AND piece.composer_id = 263
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- Op. 84 Salvum fac populum tuum

UPDATE pieces piece
SET piece.title = 'Salvum fac populum tuum', piece.title_en = 'Salvum fac populum tuum, op. 84',
    piece.type = 'song', piece.opus_number = 'Op. 84',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 15756 AND piece.composer_id = 263
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None 스케르초 E장조 "La Chasse"

UPDATE pieces piece
SET piece.title = '스케르초 E장조 "La Chasse"', piece.title_en = 'Scherzo in E major "La Chasse"',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 17411 AND piece.composer_id = 263
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- Op. 81 Sinfonia sacra

UPDATE pieces piece
SET piece.title = 'Sinfonia sacra', piece.title_en = 'Sinfonia sacra, op. 81',
    piece.type = 'album', piece.opus_number = 'Op. 81',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 19838 AND piece.composer_id = 263
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'Adagio', part.name_en = 'Sinfonia sacra: I. Adagio',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 19838 AND p.composer_id = 263 AND part.part_key = 'musicbrainz:7d24dbef-120b-479a-9cf3-8debb885c1e8' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:7d24dbef-120b-479a-9cf3-8debb885c1e8', 1, 'I', 'Adagio', 'Sinfonia sacra: I. Adagio', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 19838 AND p.composer_id = 263
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:7d24dbef-120b-479a-9cf3-8debb885c1e8'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'Adagio', part.name_en = 'Sinfonia sacra: II. Adagio',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 19838 AND p.composer_id = 263 AND part.part_key = 'musicbrainz:d00ae762-3b7b-4679-99df-3bf395148ef5' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:d00ae762-3b7b-4679-99df-3bf395148ef5', 2, 'II', 'Adagio', 'Sinfonia sacra: II. Adagio', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 19838 AND p.composer_id = 263
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:d00ae762-3b7b-4679-99df-3bf395148ef5'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = 'Andante con moto', part.name_en = 'Sinfonia sacra: III. Andante con moto',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 19838 AND p.composer_id = 263 AND part.part_key = 'musicbrainz:817e42c6-6813-4c7f-98d7-6f24ae45eed8' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:817e42c6-6813-4c7f-98d7-6f24ae45eed8', 3, 'III', 'Andante con moto', 'Sinfonia sacra: III. Andante con moto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 19838 AND p.composer_id = 263
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:817e42c6-6813-4c7f-98d7-6f24ae45eed8'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = 'IV',
    part.name_ko = 'Allegro moderato', part.name_en = 'Sinfonia sacra: IV. Allegro moderato',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 19838 AND p.composer_id = 263 AND part.part_key = 'musicbrainz:f004d164-b176-46bb-936f-74b97304e920' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:f004d164-b176-46bb-936f-74b97304e920', 4, 'IV', 'Allegro moderato', 'Sinfonia sacra: IV. Allegro moderato', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 19838 AND p.composer_id = 263
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:f004d164-b176-46bb-936f-74b97304e920'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 5, part.movement_number = 'V',
    part.name_ko = 'Tempo I ma un poco agitato', part.name_en = 'Sinfonia sacra: V. Tempo I ma un poco agitato ...',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 19838 AND p.composer_id = 263 AND part.part_key = 'musicbrainz:84a82827-f73d-4cea-9937-dbd37509efbf' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:84a82827-f73d-4cea-9937-dbd37509efbf', 5, 'V', 'Tempo I ma un poco agitato', 'Sinfonia sacra: V. Tempo I ma un poco agitato ...', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 19838 AND p.composer_id = 263
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:84a82827-f73d-4cea-9937-dbd37509efbf'
);


-- Op. 15 Six morceaux de salon Op. 15

UPDATE pieces piece
SET piece.title = 'Six morceaux de salon Op. 15', piece.title_en = 'Six morceaux de salon, op. 15',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = 'Op.', piece.catalogue_number = '15',
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 16699 AND piece.composer_id = 263
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'Scherzando', part.name_en = 'Six morceaux de salon, op. 15: No. 1. Scherzando',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 16699 AND p.composer_id = 263 AND part.part_key = 'musicbrainz:61cb2219-23b0-4901-ba8f-97bc735466ac' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:61cb2219-23b0-4901-ba8f-97bc735466ac', 1, NULL, 'Scherzando', 'Six morceaux de salon, op. 15: No. 1. Scherzando', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 16699 AND p.composer_id = 263
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:61cb2219-23b0-4901-ba8f-97bc735466ac'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'Allegro cantabile', part.name_en = 'Six morceaux de salon, op. 15: No. 2. Allegro cantabile',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 16699 AND p.composer_id = 263 AND part.part_key = 'musicbrainz:3e2c2a03-966f-4831-a8b4-f43995953848' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:3e2c2a03-966f-4831-a8b4-f43995953848', 2, NULL, 'Allegro cantabile', 'Six morceaux de salon, op. 15: No. 2. Allegro cantabile', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 16699 AND p.composer_id = 263
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:3e2c2a03-966f-4831-a8b4-f43995953848'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = NULL,
    part.name_ko = 'Andantino', part.name_en = 'Six morceaux de salon, op. 15: No. 3. Andantino',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 16699 AND p.composer_id = 263 AND part.part_key = 'musicbrainz:b3e27495-d714-41c3-81d7-c320b5cd5827' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:b3e27495-d714-41c3-81d7-c320b5cd5827', 3, NULL, 'Andantino', 'Six morceaux de salon, op. 15: No. 3. Andantino', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 16699 AND p.composer_id = 263
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:b3e27495-d714-41c3-81d7-c320b5cd5827'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = NULL,
    part.name_ko = 'Allegretto', part.name_en = 'Six morceaux de salon, op. 15: No. 4. Allegretto',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 16699 AND p.composer_id = 263 AND part.part_key = 'musicbrainz:3cbc04c2-c944-45af-86fe-cc04a3d3487f' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:3cbc04c2-c944-45af-86fe-cc04a3d3487f', 4, NULL, 'Allegretto', 'Six morceaux de salon, op. 15: No. 4. Allegretto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 16699 AND p.composer_id = 263
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:3cbc04c2-c944-45af-86fe-cc04a3d3487f'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 5, part.movement_number = NULL,
    part.name_ko = 'Moderato', part.name_en = 'Six morceaux de salon, op. 15: No. 5. Moderato',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 16699 AND p.composer_id = 263 AND part.part_key = 'musicbrainz:4099ad4a-b7d1-4fd2-836d-5eb48545504c' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:4099ad4a-b7d1-4fd2-836d-5eb48545504c', 5, NULL, 'Moderato', 'Six morceaux de salon, op. 15: No. 5. Moderato', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 16699 AND p.composer_id = 263
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:4099ad4a-b7d1-4fd2-836d-5eb48545504c'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 6, part.movement_number = NULL,
    part.name_ko = 'Valse-Impromptu', part.name_en = 'Six morceaux de salon, op. 15: No. 6. Valse-Impromptu',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 16699 AND p.composer_id = 263 AND part.part_key = 'musicbrainz:4e3b7db1-84cb-48e9-ac49-2ec8b562e852' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:4e3b7db1-84cb-48e9-ac49-2ec8b562e852', 6, NULL, 'Valse-Impromptu', 'Six morceaux de salon, op. 15: No. 6. Valse-Impromptu', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 16699 AND p.composer_id = 263
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:4e3b7db1-84cb-48e9-ac49-2ec8b562e852'
);


-- None Six valses caractéristiques

UPDATE pieces piece
SET piece.title = 'Six valses caractéristiques', piece.title_en = 'Six valses caractéristiques',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 18817 AND piece.composer_id = 263
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = '1e Rhapsodie-valse', part.name_en = 'Six valses caractéristiques: No. 1. 1e Rhapsodie-valse',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 18817 AND p.composer_id = 263 AND part.part_key = 'musicbrainz:86bc9be3-61be-4595-a5fb-873c20a41da7' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:86bc9be3-61be-4595-a5fb-873c20a41da7', 1, NULL, '1e Rhapsodie-valse', 'Six valses caractéristiques: No. 1. 1e Rhapsodie-valse', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 18817 AND p.composer_id = 263
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:86bc9be3-61be-4595-a5fb-873c20a41da7'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'Valse romance', part.name_en = 'Six valses caractéristiques: No. 2. Valse romance',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 18817 AND p.composer_id = 263 AND part.part_key = 'musicbrainz:45c6768b-baa3-42b0-b9b1-4831c20a7ae8' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:45c6768b-baa3-42b0-b9b1-4831c20a7ae8', 2, NULL, 'Valse romance', 'Six valses caractéristiques: No. 2. Valse romance', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 18817 AND p.composer_id = 263
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:45c6768b-baa3-42b0-b9b1-4831c20a7ae8'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = NULL,
    part.name_ko = 'Valse rêverie', part.name_en = 'Six valses caractéristiques: No. 3. Valse rêverie',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 18817 AND p.composer_id = 263 AND part.part_key = 'musicbrainz:1965167d-9bb3-4d1e-abe5-a7d027205d84' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:1965167d-9bb3-4d1e-abe5-a7d027205d84', 3, NULL, 'Valse rêverie', 'Six valses caractéristiques: No. 3. Valse rêverie', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 18817 AND p.composer_id = 263
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:1965167d-9bb3-4d1e-abe5-a7d027205d84'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = NULL,
    part.name_ko = 'Valse slave', part.name_en = 'Six valses caractéristiques: No. 4. Valse slave',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 18817 AND p.composer_id = 263 AND part.part_key = 'musicbrainz:8b42c3b3-ae62-4f98-8617-2ceb1db6220f' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:8b42c3b3-ae62-4f98-8617-2ceb1db6220f', 4, NULL, 'Valse slave', 'Six valses caractéristiques: No. 4. Valse slave', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 18817 AND p.composer_id = 263
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:8b42c3b3-ae62-4f98-8617-2ceb1db6220f'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 5, part.movement_number = NULL,
    part.name_ko = 'Valse élégante', part.name_en = 'Six valses caractéristiques: No. 5. Valse élégante',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 18817 AND p.composer_id = 263 AND part.part_key = 'musicbrainz:9818d9fa-bd13-4b57-ae65-55913ed04a20' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:9818d9fa-bd13-4b57-ae65-55913ed04a20', 5, NULL, 'Valse élégante', 'Six valses caractéristiques: No. 5. Valse élégante', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 18817 AND p.composer_id = 263
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:9818d9fa-bd13-4b57-ae65-55913ed04a20'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 6, part.movement_number = NULL,
    part.name_ko = '2e Rhapsodie-valse', part.name_en = 'Six valses caractéristiques: No. 6. 2e Rhapsodie-valse',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 18817 AND p.composer_id = 263 AND part.part_key = 'musicbrainz:396ba1af-afdd-4ff8-b552-d4bff624dd6b' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:396ba1af-afdd-4ff8-b552-d4bff624dd6b', 6, NULL, '2e Rhapsodie-valse', 'Six valses caractéristiques: No. 6. 2e Rhapsodie-valse', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 18817 AND p.composer_id = 263
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:396ba1af-afdd-4ff8-b552-d4bff624dd6b'
);


-- Op. 52 Soirs d'Alsace

UPDATE pieces piece
SET piece.title = 'Soirs d''Alsace', piece.title_en = 'Soirs d''Alsace, op. 52',
    piece.type = 'album', piece.opus_number = 'Op. 52',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 19215 AND piece.composer_id = 263
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'En route!', part.name_en = 'Soirs d''Alsace, op. 52: I. En route!',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 19215 AND p.composer_id = 263 AND part.part_key = 'musicbrainz:45c72870-224c-442b-ad43-5001d343d53b' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:45c72870-224c-442b-ad43-5001d343d53b', 1, 'I', 'En route!', 'Soirs d''Alsace, op. 52: I. En route!', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 19215 AND p.composer_id = 263
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:45c72870-224c-442b-ad43-5001d343d53b'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'Ciel d''orage', part.name_en = 'Soirs d''Alsace, op. 52: II. Ciel d''orage',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 19215 AND p.composer_id = 263 AND part.part_key = 'musicbrainz:85930505-ea52-4357-92ed-46a12057e41e' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:85930505-ea52-4357-92ed-46a12057e41e', 2, 'II', 'Ciel d''orage', 'Soirs d''Alsace, op. 52: II. Ciel d''orage', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 19215 AND p.composer_id = 263
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:85930505-ea52-4357-92ed-46a12057e41e'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = 'Le calme renaît', part.name_en = 'Soirs d''Alsace, op. 52: III. Le calme renaît',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 19215 AND p.composer_id = 263 AND part.part_key = 'musicbrainz:8f17f8df-ca86-4d7d-9d00-f24a4744f61f' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:8f17f8df-ca86-4d7d-9d00-f24a4744f61f', 3, 'III', 'Le calme renaît', 'Soirs d''Alsace, op. 52: III. Le calme renaît', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 19215 AND p.composer_id = 263
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:8f17f8df-ca86-4d7d-9d00-f24a4744f61f'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = 'IV',
    part.name_ko = 'Promenade sentimentale', part.name_en = 'Soirs d''Alsace, op. 52: IV. Promenade sentimentale',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 19215 AND p.composer_id = 263 AND part.part_key = 'musicbrainz:074d78eb-7234-4e4f-8f49-6dcb9eae24f7' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:074d78eb-7234-4e4f-8f49-6dcb9eae24f7', 4, 'IV', 'Promenade sentimentale', 'Soirs d''Alsace, op. 52: IV. Promenade sentimentale', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 19215 AND p.composer_id = 263
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:074d78eb-7234-4e4f-8f49-6dcb9eae24f7'
);


-- Op. 86 Suite Latine

UPDATE pieces piece
SET piece.title = 'Suite Latine', piece.title_en = 'Suite Latine, op. 86',
    piece.type = 'album', piece.opus_number = 'Op. 86',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 16740 AND piece.composer_id = 263
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'Praeludium (Moderato)', part.name_en = 'Suite Latine, op. 86: I. Praeludium (Moderato)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 16740 AND p.composer_id = 263 AND part.part_key = 'musicbrainz:d8cae524-b44e-4322-85e0-144207995357' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:d8cae524-b44e-4322-85e0-144207995357', 1, 'I', 'Praeludium (Moderato)', 'Suite Latine, op. 86: I. Praeludium (Moderato)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 16740 AND p.composer_id = 263
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:d8cae524-b44e-4322-85e0-144207995357'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'Beatus vir (Andante)', part.name_en = 'Suite Latine, op. 86: II. Beatus vir (Andante)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 16740 AND p.composer_id = 263 AND part.part_key = 'musicbrainz:f8b00de8-178d-4338-95ea-dd8b5fe200be' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:f8b00de8-178d-4338-95ea-dd8b5fe200be', 2, 'II', 'Beatus vir (Andante)', 'Suite Latine, op. 86: II. Beatus vir (Andante)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 16740 AND p.composer_id = 263
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:f8b00de8-178d-4338-95ea-dd8b5fe200be'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = 'Lamento (Allegro moderato)', part.name_en = 'Suite Latine, op. 86: III. Lamento (Allegro moderato)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 16740 AND p.composer_id = 263 AND part.part_key = 'musicbrainz:7410e4c2-7a4f-4304-9ef5-2f5327ecdef5' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:7410e4c2-7a4f-4304-9ef5-2f5327ecdef5', 3, 'III', 'Lamento (Allegro moderato)', 'Suite Latine, op. 86: III. Lamento (Allegro moderato)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 16740 AND p.composer_id = 263
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:7410e4c2-7a4f-4304-9ef5-2f5327ecdef5'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = 'IV',
    part.name_ko = 'Ave Maris Stella (Andante moderato molto)', part.name_en = 'Suite Latine, op. 86: IV. Ave Maris Stella (Andante moderato molto)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 16740 AND p.composer_id = 263 AND part.part_key = 'musicbrainz:ddb1c8f8-b665-44ed-abb9-f38e0f60d470' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:ddb1c8f8-b665-44ed-abb9-f38e0f60d470', 4, 'IV', 'Ave Maris Stella (Andante moderato molto)', 'Suite Latine, op. 86: IV. Ave Maris Stella (Andante moderato molto)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 16740 AND p.composer_id = 263
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:ddb1c8f8-b665-44ed-abb9-f38e0f60d470'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 5, part.movement_number = 'V',
    part.name_ko = 'Adagio (Adagio quasi andante)', part.name_en = 'Suite Latine, op. 86: V. Adagio (Adagio quasi andante)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 16740 AND p.composer_id = 263 AND part.part_key = 'musicbrainz:77736b4c-8fa1-4edd-99df-b01332d9f15d' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:77736b4c-8fa1-4edd-99df-b01332d9f15d', 5, 'V', 'Adagio (Adagio quasi andante)', 'Suite Latine, op. 86: V. Adagio (Adagio quasi andante)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 16740 AND p.composer_id = 263
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:77736b4c-8fa1-4edd-99df-b01332d9f15d'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 6, part.movement_number = 'VI',
    part.name_ko = 'Lauda Sion (Tempo di Marcia)', part.name_en = 'Suite Latine, op. 86: VI. Lauda Sion (Tempo di Marcia)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 16740 AND p.composer_id = 263 AND part.part_key = 'musicbrainz:ee48aa2b-4aaf-4ab5-ba2c-e2eddc0ab7ec' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:ee48aa2b-4aaf-4ab5-ba2c-e2eddc0ab7ec', 6, 'VI', 'Lauda Sion (Tempo di Marcia)', 'Suite Latine, op. 86: VI. Lauda Sion (Tempo di Marcia)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 16740 AND p.composer_id = 263
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:ee48aa2b-4aaf-4ab5-ba2c-e2eddc0ab7ec'
);


-- Op. 34 Suite pour flûte et piano

UPDATE pieces piece
SET piece.title = 'Suite pour flûte et piano', piece.title_en = 'Suite pour flûte et piano, op. 34',
    piece.type = 'album', piece.opus_number = 'Op. 34',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 16048 AND piece.composer_id = 263
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'Moderato', part.name_en = 'Suite pour flûte et piano, op. 34: I. Moderato',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 16048 AND p.composer_id = 263 AND part.part_key = 'musicbrainz:96aab9bb-0e1d-47eb-80f5-c4e61db9b709' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:96aab9bb-0e1d-47eb-80f5-c4e61db9b709', 1, 'I', 'Moderato', 'Suite pour flûte et piano, op. 34: I. Moderato', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 16048 AND p.composer_id = 263
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:96aab9bb-0e1d-47eb-80f5-c4e61db9b709'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'Scherzo. Allegro vivace', part.name_en = 'Suite pour flûte et piano, op. 34: II. Scherzo. Allegro vivace',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 16048 AND p.composer_id = 263 AND part.part_key = 'musicbrainz:e99ad523-a423-49c0-bdbe-43049413d6e0' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:e99ad523-a423-49c0-bdbe-43049413d6e0', 2, 'II', 'Scherzo. Allegro vivace', 'Suite pour flûte et piano, op. 34: II. Scherzo. Allegro vivace', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 16048 AND p.composer_id = 263
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:e99ad523-a423-49c0-bdbe-43049413d6e0'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = 'Romance. Andantino', part.name_en = 'Suite pour flûte et piano, op. 34: III. Romance. Andantino',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 16048 AND p.composer_id = 263 AND part.part_key = 'musicbrainz:a66a53d5-1c32-4f69-bcf0-fb29ac80713d' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:a66a53d5-1c32-4f69-bcf0-fb29ac80713d', 3, 'III', 'Romance. Andantino', 'Suite pour flûte et piano, op. 34: III. Romance. Andantino', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 16048 AND p.composer_id = 263
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:a66a53d5-1c32-4f69-bcf0-fb29ac80713d'
);


-- Op. 23 No. 3 Surrexit a mortuis

UPDATE pieces piece
SET piece.title = 'Surrexit a mortuis', piece.title_en = 'Surrexit a mortuis, op. 23 no. 3',
    piece.type = 'song', piece.opus_number = 'Op. 23 No. 3',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 18349 AND piece.composer_id = 263
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- Op. 83 Symphonie antique

UPDATE pieces piece
SET piece.title = 'Symphonie antique', piece.title_en = 'Symphonie antique, op. 83',
    piece.type = 'album', piece.opus_number = 'Op. 83',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 16165 AND piece.composer_id = 263
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'Allegro moderato (Te Deum)', part.name_en = 'Symphonie antique, op. 83: I. Allegro moderato (Te Deum)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 16165 AND p.composer_id = 263 AND part.part_key = 'musicbrainz:80cf31c8-d5e4-4582-8341-2e9bb6a7082f' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:80cf31c8-d5e4-4582-8341-2e9bb6a7082f', 1, 'I', 'Allegro moderato (Te Deum)', 'Symphonie antique, op. 83: I. Allegro moderato (Te Deum)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 16165 AND p.composer_id = 263
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:80cf31c8-d5e4-4582-8341-2e9bb6a7082f'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'Adagio', part.name_en = 'Symphonie antique, op. 83: II. Adagio',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 16165 AND p.composer_id = 263 AND part.part_key = 'musicbrainz:04cfc306-1b51-4a1c-b2ff-13e3a4e210ec' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:04cfc306-1b51-4a1c-b2ff-13e3a4e210ec', 2, 'II', 'Adagio', 'Symphonie antique, op. 83: II. Adagio', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 16165 AND p.composer_id = 263
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:04cfc306-1b51-4a1c-b2ff-13e3a4e210ec'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = 'Moderato – Allegro (Laude Sion)', part.name_en = 'Symphonie antique, op. 83: III. Moderato – Allegro (Laude Sion)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 16165 AND p.composer_id = 263 AND part.part_key = 'musicbrainz:ca5ca7a8-dbec-4309-8862-4d14b3058912' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:ca5ca7a8-dbec-4309-8862-4d14b3058912', 3, 'III', 'Moderato – Allegro (Laude Sion)', 'Symphonie antique, op. 83: III. Moderato – Allegro (Laude Sion)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 16165 AND p.composer_id = 263
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:ca5ca7a8-dbec-4309-8862-4d14b3058912'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = 'IV',
    part.name_ko = 'Moderato. "Te Deum Laudamus"', part.name_en = 'Symphonie antique, op. 83: IV. Moderato. "Te Deum Laudamus"',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 16165 AND p.composer_id = 263 AND part.part_key = 'musicbrainz:5824dcf7-78d2-4a12-b3ab-73c31694145c' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:5824dcf7-78d2-4a12-b3ab-73c31694145c', 4, 'IV', 'Moderato. "Te Deum Laudamus"', 'Symphonie antique, op. 83: IV. Moderato. "Te Deum Laudamus"', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 16165 AND p.composer_id = 263
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:5824dcf7-78d2-4a12-b3ab-73c31694145c'
);


-- None 교향곡 10번 "Symphonie romane"

UPDATE pieces piece
SET piece.title = '교향곡 10번 "Symphonie romane"', piece.title_en = 'Symphonie pour orgue nº 10 en re majeur, op. 73 "Symphonie romane"',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 17471 AND piece.composer_id = 263
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'Moderato', part.name_en = 'Symphonie pour orgue nº 10 en re majeur, op. 73 "Symphonie romane": I. Moderato',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 17471 AND p.composer_id = 263 AND part.part_key = 'musicbrainz:323a80b3-2f84-4269-afba-ad282403c899' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:323a80b3-2f84-4269-afba-ad282403c899', 1, 'I', 'Moderato', 'Symphonie pour orgue nº 10 en re majeur, op. 73 "Symphonie romane": I. Moderato', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 17471 AND p.composer_id = 263
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:323a80b3-2f84-4269-afba-ad282403c899'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'Choral. Adagio', part.name_en = 'Symphonie pour orgue nº 10 en re majeur, op. 73 "Symphonie romane": II. Choral. Adagio',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 17471 AND p.composer_id = 263 AND part.part_key = 'musicbrainz:d23f195d-058f-4f8d-9646-de3e675f9e74' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:d23f195d-058f-4f8d-9646-de3e675f9e74', 2, 'II', 'Choral. Adagio', 'Symphonie pour orgue nº 10 en re majeur, op. 73 "Symphonie romane": II. Choral. Adagio', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 17471 AND p.composer_id = 263
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:d23f195d-058f-4f8d-9646-de3e675f9e74'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = 'Cantilene. Lento', part.name_en = 'Symphonie pour orgue nº 10 en re majeur, op. 73 "Symphonie romane": III. Cantilene. Lento',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 17471 AND p.composer_id = 263 AND part.part_key = 'musicbrainz:7df758fe-2d29-4853-890a-75fb79ce9b41' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:7df758fe-2d29-4853-890a-75fb79ce9b41', 3, 'III', 'Cantilene. Lento', 'Symphonie pour orgue nº 10 en re majeur, op. 73 "Symphonie romane": III. Cantilene. Lento', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 17471 AND p.composer_id = 263
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:7df758fe-2d29-4853-890a-75fb79ce9b41'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = 'IV',
    part.name_ko = 'Final. Allegro', part.name_en = 'Symphonie pour orgue nº 10 en re majeur, op. 73 "Symphonie romane": IV. Final. Allegro',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 17471 AND p.composer_id = 263 AND part.part_key = 'musicbrainz:3659f7a2-7e6f-488b-9648-93e19bad971c' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:3659f7a2-7e6f-488b-9648-93e19bad971c', 4, 'IV', 'Final. Allegro', 'Symphonie pour orgue nº 10 en re majeur, op. 73 "Symphonie romane": IV. Final. Allegro', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 17471 AND p.composer_id = 263
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:3659f7a2-7e6f-488b-9648-93e19bad971c'
);


-- None 교향곡 9번 "Symphonie gothique"

UPDATE pieces piece
SET piece.title = '교향곡 9번 "Symphonie gothique"', piece.title_en = 'Symphonie pour orgue nº 9 en ut mineur, op. 70 "Symphonie gothique"',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 16805 AND piece.composer_id = 263
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'Moderato', part.name_en = 'Symphonie pour orgue nº 9 en ut mineur, op. 70 "Symphonie gothique": I. Moderato',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 16805 AND p.composer_id = 263 AND part.part_key = 'musicbrainz:a1c403d7-d0d7-4c41-83d8-7e4d7ebf65aa' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:a1c403d7-d0d7-4c41-83d8-7e4d7ebf65aa', 1, 'I', 'Moderato', 'Symphonie pour orgue nº 9 en ut mineur, op. 70 "Symphonie gothique": I. Moderato', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 16805 AND p.composer_id = 263
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:a1c403d7-d0d7-4c41-83d8-7e4d7ebf65aa'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'Andante sostenuto', part.name_en = 'Symphonie pour orgue nº 9 en ut mineur, op. 70 "Symphonie gothique": II. Andante sostenuto',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 16805 AND p.composer_id = 263 AND part.part_key = 'musicbrainz:4319730b-e31f-41a9-b710-c459610e3268' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:4319730b-e31f-41a9-b710-c459610e3268', 2, 'II', 'Andante sostenuto', 'Symphonie pour orgue nº 9 en ut mineur, op. 70 "Symphonie gothique": II. Andante sostenuto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 16805 AND p.composer_id = 263
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:4319730b-e31f-41a9-b710-c459610e3268'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = 'Allegro', part.name_en = 'Symphonie pour orgue nº 9 en ut mineur, op. 70 "Symphonie gothique": III. Allegro',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 16805 AND p.composer_id = 263 AND part.part_key = 'musicbrainz:60f94377-023e-4edc-aa12-e680cdf9a2eb' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:60f94377-023e-4edc-aa12-e680cdf9a2eb', 3, 'III', 'Allegro', 'Symphonie pour orgue nº 9 en ut mineur, op. 70 "Symphonie gothique": III. Allegro', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 16805 AND p.composer_id = 263
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:60f94377-023e-4edc-aa12-e680cdf9a2eb'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = 'IV',
    part.name_ko = 'Moderato (Variationen)', part.name_en = 'Symphonie pour orgue nº 9 en ut mineur, op. 70 "Symphonie gothique": IV. Moderato (Variationen)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 16805 AND p.composer_id = 263 AND part.part_key = 'musicbrainz:31a15dea-fe64-4399-a282-80820c365b91' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:31a15dea-fe64-4399-a282-80820c365b91', 4, 'IV', 'Moderato (Variationen)', 'Symphonie pour orgue nº 9 en ut mineur, op. 70 "Symphonie gothique": IV. Moderato (Variationen)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 16805 AND p.composer_id = 263
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:31a15dea-fe64-4399-a282-80820c365b91'
);


-- Op. 42 Symphonies pour orgue Op. 42

UPDATE pieces piece
SET piece.title = 'Symphonies pour orgue Op. 42', piece.title_en = 'Symphonies pour orgue, op. 42',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = 'Op.', piece.catalogue_number = '42',
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 16766 AND piece.composer_id = 263
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'Symphonie pour orgue n° 5 en fa mineur, op. 42 n° 1', part.name_en = 'Symphonie pour orgue n° 5 en fa mineur, op. 42 n° 1',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 16766 AND p.composer_id = 263 AND part.part_key = 'musicbrainz:b474efce-6458-4fdd-a983-23688495ecc9' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:b474efce-6458-4fdd-a983-23688495ecc9', 1, NULL, 'Symphonie pour orgue n° 5 en fa mineur, op. 42 n° 1', 'Symphonie pour orgue n° 5 en fa mineur, op. 42 n° 1', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 16766 AND p.composer_id = 263
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:b474efce-6458-4fdd-a983-23688495ecc9'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:b474efce-6458-4fdd-a983-23688495ecc9'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'Allegro vivace', part.name_en = 'Symphonie pour orgue n° 5 en fa mineur, op. 42 n° 1: I. Allegro vivace',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 16766 AND p.composer_id = 263 AND part.part_key = 'musicbrainz:435d9b19-b909-4f6f-aae1-45ec71bf9929' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:435d9b19-b909-4f6f-aae1-45ec71bf9929', 1, NULL, 'Allegro vivace', 'Symphonie pour orgue n° 5 en fa mineur, op. 42 n° 1: I. Allegro vivace', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:b474efce-6458-4fdd-a983-23688495ecc9'
WHERE p.id = 16766 AND p.composer_id = 263
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:435d9b19-b909-4f6f-aae1-45ec71bf9929'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:b474efce-6458-4fdd-a983-23688495ecc9'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'Allegro cantabile', part.name_en = 'Symphonie pour orgue n° 5 en fa mineur, op. 42 n° 1: II. Allegro cantabile',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 16766 AND p.composer_id = 263 AND part.part_key = 'musicbrainz:d116f303-aab1-45d1-8bbb-f85572b8b2fe' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:d116f303-aab1-45d1-8bbb-f85572b8b2fe', 2, NULL, 'Allegro cantabile', 'Symphonie pour orgue n° 5 en fa mineur, op. 42 n° 1: II. Allegro cantabile', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:b474efce-6458-4fdd-a983-23688495ecc9'
WHERE p.id = 16766 AND p.composer_id = 263
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:d116f303-aab1-45d1-8bbb-f85572b8b2fe'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:b474efce-6458-4fdd-a983-23688495ecc9'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = NULL,
    part.name_ko = 'Andantino quasi allegretto', part.name_en = 'Symphonie pour orgue n° 5 en fa mineur, op. 42 n° 1: III. Andantino quasi allegretto',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 16766 AND p.composer_id = 263 AND part.part_key = 'musicbrainz:73e30fd0-e715-4d9f-8f51-18dc9f2c345a' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:73e30fd0-e715-4d9f-8f51-18dc9f2c345a', 3, NULL, 'Andantino quasi allegretto', 'Symphonie pour orgue n° 5 en fa mineur, op. 42 n° 1: III. Andantino quasi allegretto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:b474efce-6458-4fdd-a983-23688495ecc9'
WHERE p.id = 16766 AND p.composer_id = 263
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:73e30fd0-e715-4d9f-8f51-18dc9f2c345a'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:b474efce-6458-4fdd-a983-23688495ecc9'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = NULL,
    part.name_ko = 'Adagio', part.name_en = 'Symphonie pour orgue n° 5 en fa mineur, op. 42 n° 1: IV. Adagio',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 16766 AND p.composer_id = 263 AND part.part_key = 'musicbrainz:d3d99e4f-4796-4873-b37a-168f93522fcd' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:d3d99e4f-4796-4873-b37a-168f93522fcd', 4, NULL, 'Adagio', 'Symphonie pour orgue n° 5 en fa mineur, op. 42 n° 1: IV. Adagio', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:b474efce-6458-4fdd-a983-23688495ecc9'
WHERE p.id = 16766 AND p.composer_id = 263
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:d3d99e4f-4796-4873-b37a-168f93522fcd'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:b474efce-6458-4fdd-a983-23688495ecc9'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 5, part.movement_number = NULL,
    part.name_ko = 'Toccata', part.name_en = 'Symphonie pour orgue n° 5 en fa mineur, op. 42 n° 1: V. Toccata',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 16766 AND p.composer_id = 263 AND part.part_key = 'musicbrainz:b23e87fa-0d84-4631-9079-7e361cb96513' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:b23e87fa-0d84-4631-9079-7e361cb96513', 5, NULL, 'Toccata', 'Symphonie pour orgue n° 5 en fa mineur, op. 42 n° 1: V. Toccata', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:b474efce-6458-4fdd-a983-23688495ecc9'
WHERE p.id = 16766 AND p.composer_id = 263
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:b23e87fa-0d84-4631-9079-7e361cb96513'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'Symphonie pour orgue N° 6 en Sol mineur, op. 42 N° 2', part.name_en = 'Symphonie pour orgue N° 6 en Sol mineur, op. 42 N° 2',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 16766 AND p.composer_id = 263 AND part.part_key = 'musicbrainz:7d202c3a-080f-4458-b6f7-93d6435cb855' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:7d202c3a-080f-4458-b6f7-93d6435cb855', 2, NULL, 'Symphonie pour orgue N° 6 en Sol mineur, op. 42 N° 2', 'Symphonie pour orgue N° 6 en Sol mineur, op. 42 N° 2', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 16766 AND p.composer_id = 263
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:7d202c3a-080f-4458-b6f7-93d6435cb855'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:7d202c3a-080f-4458-b6f7-93d6435cb855'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'Allegro', part.name_en = 'Symphonie pour orgue N° 6 en Sol mineur, op. 42 N° 2: I. Allegro',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 16766 AND p.composer_id = 263 AND part.part_key = 'musicbrainz:b7e9fa44-c4ed-39e4-acd7-0cef516e01c0' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:b7e9fa44-c4ed-39e4-acd7-0cef516e01c0', 1, NULL, 'Allegro', 'Symphonie pour orgue N° 6 en Sol mineur, op. 42 N° 2: I. Allegro', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:7d202c3a-080f-4458-b6f7-93d6435cb855'
WHERE p.id = 16766 AND p.composer_id = 263
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:b7e9fa44-c4ed-39e4-acd7-0cef516e01c0'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:7d202c3a-080f-4458-b6f7-93d6435cb855'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'Adagio', part.name_en = 'Symphonie pour orgue N° 6 en Sol mineur, op. 42 N° 2: II. Adagio',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 16766 AND p.composer_id = 263 AND part.part_key = 'musicbrainz:ff55f243-0041-4380-8c7e-5b80b2d35e61' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:ff55f243-0041-4380-8c7e-5b80b2d35e61', 2, NULL, 'Adagio', 'Symphonie pour orgue N° 6 en Sol mineur, op. 42 N° 2: II. Adagio', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:7d202c3a-080f-4458-b6f7-93d6435cb855'
WHERE p.id = 16766 AND p.composer_id = 263
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:ff55f243-0041-4380-8c7e-5b80b2d35e61'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:7d202c3a-080f-4458-b6f7-93d6435cb855'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = NULL,
    part.name_ko = 'Intermezzo', part.name_en = 'Symphonie pour orgue N° 6 en Sol mineur, op. 42 N° 2: III. Intermezzo',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 16766 AND p.composer_id = 263 AND part.part_key = 'musicbrainz:062bddf0-8f6b-4f1d-87ef-fce0fbf8b558' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:062bddf0-8f6b-4f1d-87ef-fce0fbf8b558', 3, NULL, 'Intermezzo', 'Symphonie pour orgue N° 6 en Sol mineur, op. 42 N° 2: III. Intermezzo', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:7d202c3a-080f-4458-b6f7-93d6435cb855'
WHERE p.id = 16766 AND p.composer_id = 263
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:062bddf0-8f6b-4f1d-87ef-fce0fbf8b558'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:7d202c3a-080f-4458-b6f7-93d6435cb855'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = NULL,
    part.name_ko = 'Cantabile', part.name_en = 'Symphonie pour orgue N° 6 en Sol mineur, op. 42 N° 2: IV. Cantabile',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 16766 AND p.composer_id = 263 AND part.part_key = 'musicbrainz:b8b03247-1d73-43e1-8c8d-3b07fb197c04' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:b8b03247-1d73-43e1-8c8d-3b07fb197c04', 4, NULL, 'Cantabile', 'Symphonie pour orgue N° 6 en Sol mineur, op. 42 N° 2: IV. Cantabile', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:7d202c3a-080f-4458-b6f7-93d6435cb855'
WHERE p.id = 16766 AND p.composer_id = 263
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:b8b03247-1d73-43e1-8c8d-3b07fb197c04'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:7d202c3a-080f-4458-b6f7-93d6435cb855'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 5, part.movement_number = NULL,
    part.name_ko = 'Finale', part.name_en = 'Symphonie pour orgue N° 6 en Sol mineur, op. 42 N° 2: V. Finale',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 16766 AND p.composer_id = 263 AND part.part_key = 'musicbrainz:8551503c-665d-482d-8a1d-47703d4b1db3' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:8551503c-665d-482d-8a1d-47703d4b1db3', 5, NULL, 'Finale', 'Symphonie pour orgue N° 6 en Sol mineur, op. 42 N° 2: V. Finale', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:7d202c3a-080f-4458-b6f7-93d6435cb855'
WHERE p.id = 16766 AND p.composer_id = 263
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:8551503c-665d-482d-8a1d-47703d4b1db3'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = NULL,
    part.name_ko = 'Organ Symphony no. 7 in A minor, op. 42 no. 3', part.name_en = 'Organ Symphony no. 7 in A minor, op. 42 no. 3',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 16766 AND p.composer_id = 263 AND part.part_key = 'musicbrainz:866099b4-225a-446a-ba78-573bd191d015' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:866099b4-225a-446a-ba78-573bd191d015', 3, NULL, 'Organ Symphony no. 7 in A minor, op. 42 no. 3', 'Organ Symphony no. 7 in A minor, op. 42 no. 3', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 16766 AND p.composer_id = 263
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:866099b4-225a-446a-ba78-573bd191d015'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:866099b4-225a-446a-ba78-573bd191d015'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'Moderato', part.name_en = 'Organ Symphony no. 7 in A minor, op. 42 no. 3: I. Moderato',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 16766 AND p.composer_id = 263 AND part.part_key = 'musicbrainz:bf95913f-883c-461e-be42-00506f79148a' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:bf95913f-883c-461e-be42-00506f79148a', 1, NULL, 'Moderato', 'Organ Symphony no. 7 in A minor, op. 42 no. 3: I. Moderato', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:866099b4-225a-446a-ba78-573bd191d015'
WHERE p.id = 16766 AND p.composer_id = 263
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:bf95913f-883c-461e-be42-00506f79148a'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:866099b4-225a-446a-ba78-573bd191d015'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'Choral', part.name_en = 'Organ Symphony no. 7 in A minor, op. 42 no. 3: II. Choral',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 16766 AND p.composer_id = 263 AND part.part_key = 'musicbrainz:1d004555-b24a-4a3f-acdd-86ea66408846' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:1d004555-b24a-4a3f-acdd-86ea66408846', 2, NULL, 'Choral', 'Organ Symphony no. 7 in A minor, op. 42 no. 3: II. Choral', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:866099b4-225a-446a-ba78-573bd191d015'
WHERE p.id = 16766 AND p.composer_id = 263
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:1d004555-b24a-4a3f-acdd-86ea66408846'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:866099b4-225a-446a-ba78-573bd191d015'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = NULL,
    part.name_ko = 'Andante', part.name_en = 'Organ Symphony no. 7 in A minor, op. 42 no. 3: III. Andante',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 16766 AND p.composer_id = 263 AND part.part_key = 'musicbrainz:713e0eca-4705-421e-8d8f-12be7cd6b35d' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:713e0eca-4705-421e-8d8f-12be7cd6b35d', 3, NULL, 'Andante', 'Organ Symphony no. 7 in A minor, op. 42 no. 3: III. Andante', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:866099b4-225a-446a-ba78-573bd191d015'
WHERE p.id = 16766 AND p.composer_id = 263
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:713e0eca-4705-421e-8d8f-12be7cd6b35d'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:866099b4-225a-446a-ba78-573bd191d015'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = NULL,
    part.name_ko = 'Allegro ma non troppo', part.name_en = 'Organ Symphony no. 7 in A minor, op. 42 no. 3: IV. Allegro ma non troppo',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 16766 AND p.composer_id = 263 AND part.part_key = 'musicbrainz:0a1ab5a6-1359-4790-9981-45b348f725ed' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:0a1ab5a6-1359-4790-9981-45b348f725ed', 4, NULL, 'Allegro ma non troppo', 'Organ Symphony no. 7 in A minor, op. 42 no. 3: IV. Allegro ma non troppo', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:866099b4-225a-446a-ba78-573bd191d015'
WHERE p.id = 16766 AND p.composer_id = 263
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:0a1ab5a6-1359-4790-9981-45b348f725ed'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:866099b4-225a-446a-ba78-573bd191d015'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 5, part.movement_number = NULL,
    part.name_ko = 'Lento', part.name_en = 'Organ Symphony no. 7 in A minor, op. 42 no. 3: V. Lento',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 16766 AND p.composer_id = 263 AND part.part_key = 'musicbrainz:f2429269-c3c6-4475-8dd0-c994a22ffd5e' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:f2429269-c3c6-4475-8dd0-c994a22ffd5e', 5, NULL, 'Lento', 'Organ Symphony no. 7 in A minor, op. 42 no. 3: V. Lento', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:866099b4-225a-446a-ba78-573bd191d015'
WHERE p.id = 16766 AND p.composer_id = 263
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:f2429269-c3c6-4475-8dd0-c994a22ffd5e'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:866099b4-225a-446a-ba78-573bd191d015'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 6, part.movement_number = NULL,
    part.name_ko = 'Finale. Allegro vivace', part.name_en = 'Organ Symphony no. 7 in A minor, op. 42 no. 3: VI. Finale. Allegro vivace',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 16766 AND p.composer_id = 263 AND part.part_key = 'musicbrainz:cb7a9900-a435-37cf-a8e7-6e5673bcce6d' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:cb7a9900-a435-37cf-a8e7-6e5673bcce6d', 6, NULL, 'Finale. Allegro vivace', 'Organ Symphony no. 7 in A minor, op. 42 no. 3: VI. Finale. Allegro vivace', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:866099b4-225a-446a-ba78-573bd191d015'
WHERE p.id = 16766 AND p.composer_id = 263
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:cb7a9900-a435-37cf-a8e7-6e5673bcce6d'
);


-- Op. 16 교향곡 1번

UPDATE pieces piece
SET piece.title = '교향곡 1번', piece.title_en = 'Symphony no. 1, op. 16',
    piece.type = 'album', piece.opus_number = 'Op. 16',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 19713 AND piece.composer_id = 263
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'Allegro con moto', part.name_en = 'Symphony no. 1, op. 16: I. Allegro con moto',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 19713 AND p.composer_id = 263 AND part.part_key = 'musicbrainz:35d08fbc-1692-4bcf-b1f1-4b02832126c9' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:35d08fbc-1692-4bcf-b1f1-4b02832126c9', 1, 'I', 'Allegro con moto', 'Symphony no. 1, op. 16: I. Allegro con moto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 19713 AND p.composer_id = 263
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:35d08fbc-1692-4bcf-b1f1-4b02832126c9'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'Andante', part.name_en = 'Symphony no. 1, op. 16: II. Andante',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 19713 AND p.composer_id = 263 AND part.part_key = 'musicbrainz:b4cf859c-9f93-4c6b-9ccb-02bb6f3b2bc6' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:b4cf859c-9f93-4c6b-9ccb-02bb6f3b2bc6', 2, 'II', 'Andante', 'Symphony no. 1, op. 16: II. Andante', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 19713 AND p.composer_id = 263
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:b4cf859c-9f93-4c6b-9ccb-02bb6f3b2bc6'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = 'Presto', part.name_en = 'Symphony no. 1, op. 16: III. Presto',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 19713 AND p.composer_id = 263 AND part.part_key = 'musicbrainz:54f88e35-c8f4-4c31-acae-efe725f7ef94' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:54f88e35-c8f4-4c31-acae-efe725f7ef94', 3, 'III', 'Presto', 'Symphony no. 1, op. 16: III. Presto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 19713 AND p.composer_id = 263
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:54f88e35-c8f4-4c31-acae-efe725f7ef94'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = 'IV',
    part.name_ko = 'Allegro con brio', part.name_en = 'Symphony no. 1, op. 16: IV. Allegro con brio',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 19713 AND p.composer_id = 263 AND part.part_key = 'musicbrainz:74bc7735-50d1-4df2-b8c8-d317d9a81b26' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:74bc7735-50d1-4df2-b8c8-d317d9a81b26', 4, 'IV', 'Allegro con brio', 'Symphony no. 1, op. 16: IV. Allegro con brio', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 19713 AND p.composer_id = 263
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:74bc7735-50d1-4df2-b8c8-d317d9a81b26'
);


-- Op. 54 교향곡 2번 A장조

UPDATE pieces piece
SET piece.title = '교향곡 2번 A장조', piece.title_en = 'Symphony no. 2 in A major, op. 54',
    piece.type = 'album', piece.opus_number = 'Op. 54',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 16401 AND piece.composer_id = 263
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'Allegro vivace', part.name_en = 'Symphony no. 2 in A major, op. 54: I. Allegro vivace',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 16401 AND p.composer_id = 263 AND part.part_key = 'musicbrainz:61aa7231-d928-46e0-8cff-c342460e92e8' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:61aa7231-d928-46e0-8cff-c342460e92e8', 1, 'I', 'Allegro vivace', 'Symphony no. 2 in A major, op. 54: I. Allegro vivace', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 16401 AND p.composer_id = 263
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:61aa7231-d928-46e0-8cff-c342460e92e8'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'Moderato', part.name_en = 'Symphony no. 2 in A major, op. 54: II. Moderato',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 16401 AND p.composer_id = 263 AND part.part_key = 'musicbrainz:76519c5f-dee1-4535-8189-8de49446a724' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:76519c5f-dee1-4535-8189-8de49446a724', 2, 'II', 'Moderato', 'Symphony no. 2 in A major, op. 54: II. Moderato', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 16401 AND p.composer_id = 263
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:76519c5f-dee1-4535-8189-8de49446a724'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = 'Andante con moto', part.name_en = 'Symphony no. 2 in A major, op. 54: III. Andante con moto',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 16401 AND p.composer_id = 263 AND part.part_key = 'musicbrainz:8ddda9b3-ba45-4cf0-83b9-c06beaf6361b' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:8ddda9b3-ba45-4cf0-83b9-c06beaf6361b', 3, 'III', 'Andante con moto', 'Symphony no. 2 in A major, op. 54: III. Andante con moto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 16401 AND p.composer_id = 263
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:8ddda9b3-ba45-4cf0-83b9-c06beaf6361b'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = 'IV',
    part.name_ko = 'Vivace - Scherzando - Allegro con brio', part.name_en = 'Symphony no. 2 in A major, op. 54: IV. Vivace - Scherzando - Allegro con brio',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 16401 AND p.composer_id = 263 AND part.part_key = 'musicbrainz:cdb2fbc9-12fb-4c5a-852b-18dde2f0e305' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:cdb2fbc9-12fb-4c5a-852b-18dde2f0e305', 4, 'IV', 'Vivace - Scherzando - Allegro con brio', 'Symphony no. 2 in A major, op. 54: IV. Vivace - Scherzando - Allegro con brio', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 16401 AND p.composer_id = 263
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:cdb2fbc9-12fb-4c5a-852b-18dde2f0e305'
);


-- Op. 69 교향곡 3번

UPDATE pieces piece
SET piece.title = '교향곡 3번', piece.title_en = 'Symphony no. 3 for Organ and Orchestra, op. 69',
    piece.type = 'album', piece.opus_number = 'Op. 69',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 19868 AND piece.composer_id = 263
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'Adagio - Andante - Allegro', part.name_en = 'Symphony no. 3 for Organ and Orchestra, op. 69: I. Adagio - Andante - Allegro',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 19868 AND p.composer_id = 263 AND part.part_key = 'musicbrainz:efa5908c-a7e9-4ca1-8af1-cc47c5a7c515' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:efa5908c-a7e9-4ca1-8af1-cc47c5a7c515', 1, 'I', 'Adagio - Andante - Allegro', 'Symphony no. 3 for Organ and Orchestra, op. 69: I. Adagio - Andante - Allegro', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 19868 AND p.composer_id = 263
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:efa5908c-a7e9-4ca1-8af1-cc47c5a7c515'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'Vivace - Tranquillamente - Allegro - Largo', part.name_en = 'Symphony no. 3 for Organ and Orchestra, op. 69: II. Vivace - Tranquillamente - Allegro - Largo',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 19868 AND p.composer_id = 263 AND part.part_key = 'musicbrainz:29fdb90e-fb47-44fb-af44-23d93ef08f95' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:29fdb90e-fb47-44fb-af44-23d93ef08f95', 2, 'II', 'Vivace - Tranquillamente - Allegro - Largo', 'Symphony no. 3 for Organ and Orchestra, op. 69: II. Vivace - Tranquillamente - Allegro - Largo', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 19868 AND p.composer_id = 263
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:29fdb90e-fb47-44fb-af44-23d93ef08f95'
);


-- Op. 10 세레나데

UPDATE pieces piece
SET piece.title = '세레나데', piece.title_en = 'Sérénade, op. 10',
    piece.type = 'song', piece.opus_number = 'Op. 10',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 16607 AND piece.composer_id = 263
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- Op. 18 No. 1 Tantum ergo

UPDATE pieces piece
SET piece.title = 'Tantum ergo', piece.title_en = 'Tantum ergo, op. 18 no. 1',
    piece.type = 'song', piece.opus_number = 'Op. 18 No. 1',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 16873 AND piece.composer_id = 263
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None 가곡 <Tristesse infinie>

UPDATE pieces piece
SET piece.title = '가곡 <Tristesse infinie>', piece.title_en = 'Tristesse infinie',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 19037 AND piece.composer_id = 263
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- Op. 87 Trois Nouvelles Pieces

UPDATE pieces piece
SET piece.title = 'Trois Nouvelles Pieces', piece.title_en = 'Trois Nouvelles Pieces, op. 87',
    piece.type = 'album', piece.opus_number = 'Op. 87',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 16448 AND piece.composer_id = 263
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'Classique d''hier', part.name_en = 'Trois Nouvelles Pieces, op. 87: I. Classique d''hier',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 16448 AND p.composer_id = 263 AND part.part_key = 'musicbrainz:eb1e1e8c-7fc3-4344-9ba0-9ba3424dd508' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:eb1e1e8c-7fc3-4344-9ba0-9ba3424dd508', 1, 'I', 'Classique d''hier', 'Trois Nouvelles Pieces, op. 87: I. Classique d''hier', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 16448 AND p.composer_id = 263
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:eb1e1e8c-7fc3-4344-9ba0-9ba3424dd508'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'Mystique', part.name_en = 'Trois Nouvelles Pieces, op. 87: II. Mystique',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 16448 AND p.composer_id = 263 AND part.part_key = 'musicbrainz:b33781e5-24b9-4d3b-b59b-b15da71d6017' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:b33781e5-24b9-4d3b-b59b-b15da71d6017', 2, 'II', 'Mystique', 'Trois Nouvelles Pieces, op. 87: II. Mystique', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 16448 AND p.composer_id = 263
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:b33781e5-24b9-4d3b-b59b-b15da71d6017'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = 'Classique d'' aujourd''hui', part.name_en = 'Trois Nouvelles Pieces, op. 87: III. Classique d'' aujourd''hui',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 16448 AND p.composer_id = 263 AND part.part_key = 'musicbrainz:4f010ba7-12e8-4ac7-8b47-a6f0c216c346' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:4f010ba7-12e8-4ac7-8b47-a6f0c216c346', 3, 'III', 'Classique d'' aujourd''hui', 'Trois Nouvelles Pieces, op. 87: III. Classique d'' aujourd''hui', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 16448 AND p.composer_id = 263
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:4f010ba7-12e8-4ac7-8b47-a6f0c216c346'
);


-- Op. 32 Trois mélodies italiennes Op. 32

UPDATE pieces piece
SET piece.title = 'Trois mélodies italiennes Op. 32', piece.title_en = 'Trois mélodies italiennes, op. 32',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = 'Op.', piece.catalogue_number = '32',
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 17173 AND piece.composer_id = 263
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'Lia è morta, op. 32 no. 1', part.name_en = 'Lia è morta, op. 32 no. 1',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 17173 AND p.composer_id = 263 AND part.part_key = 'musicbrainz:b7d238b3-ab8b-4a74-a2aa-be9d4e15ead2' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:b7d238b3-ab8b-4a74-a2aa-be9d4e15ead2', 1, NULL, 'Lia è morta, op. 32 no. 1', 'Lia è morta, op. 32 no. 1', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 17173 AND p.composer_id = 263
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:b7d238b3-ab8b-4a74-a2aa-be9d4e15ead2'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'Il tempo passato, op. 32 no. 2', part.name_en = 'Il tempo passato, op. 32 no. 2',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 17173 AND p.composer_id = 263 AND part.part_key = 'musicbrainz:88db85d2-59ef-470a-93ab-07d32d260997' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:88db85d2-59ef-470a-93ab-07d32d260997', 2, NULL, 'Il tempo passato, op. 32 no. 2', 'Il tempo passato, op. 32 no. 2', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 17173 AND p.composer_id = 263
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:88db85d2-59ef-470a-93ab-07d32d260997'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = NULL,
    part.name_ko = 'Il primo amore, op. 32 no. 3', part.name_en = 'Il primo amore, op. 32 no. 3',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 17173 AND p.composer_id = 263 AND part.part_key = 'musicbrainz:6db746e0-fcb4-45be-9ba4-63631e657adf' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:6db746e0-fcb4-45be-9ba4-63631e657adf', 3, NULL, 'Il primo amore, op. 32 no. 3', 'Il primo amore, op. 32 no. 3', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 17173 AND p.composer_id = 263
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:6db746e0-fcb4-45be-9ba4-63631e657adf'
);


-- Op. 35 Trois mélodies italiennes Op. 35

UPDATE pieces piece
SET piece.title = 'Trois mélodies italiennes Op. 35', piece.title_en = 'Trois mélodies italiennes, op. 35',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = 'Op.', piece.catalogue_number = '35',
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 16845 AND piece.composer_id = 263
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'Dimmi perchè, op. 35 no. 1', part.name_en = 'Dimmi perchè, op. 35 no. 1',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 16845 AND p.composer_id = 263 AND part.part_key = 'musicbrainz:417952e0-1cca-414b-87ca-57e91023c380' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:417952e0-1cca-414b-87ca-57e91023c380', 1, NULL, 'Dimmi perchè, op. 35 no. 1', 'Dimmi perchè, op. 35 no. 1', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 16845 AND p.composer_id = 263
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:417952e0-1cca-414b-87ca-57e91023c380'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'Rude maëstro, op. 35 no. 2', part.name_en = 'Rude maëstro, op. 35 no. 2',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 16845 AND p.composer_id = 263 AND part.part_key = 'musicbrainz:662f9dc1-1cc2-4bfb-938b-07c418833965' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:662f9dc1-1cc2-4bfb-938b-07c418833965', 2, NULL, 'Rude maëstro, op. 35 no. 2', 'Rude maëstro, op. 35 no. 2', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 16845 AND p.composer_id = 263
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:662f9dc1-1cc2-4bfb-938b-07c418833965'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = NULL,
    part.name_ko = 'La bianchina, op. 35 no. 3', part.name_en = 'La bianchina, op. 35 no. 3',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 16845 AND p.composer_id = 263 AND part.part_key = 'musicbrainz:2afab915-f33e-4d58-9b56-e6291e72b444' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:2afab915-f33e-4d58-9b56-e6291e72b444', 3, NULL, 'La bianchina, op. 35 no. 3', 'La bianchina, op. 35 no. 3', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 16845 AND p.composer_id = 263
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:2afab915-f33e-4d58-9b56-e6291e72b444'
);


-- Op. 23 No. 2 Tu es Petrus

UPDATE pieces piece
SET piece.title = 'Tu es Petrus', piece.title_en = 'Tu es Petrus, op. 23 no. 2',
    piece.type = 'song', piece.opus_number = 'Op. 23 No. 2',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 19895 AND piece.composer_id = 263
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- Op. 50 바이올린 소나타 1번

UPDATE pieces piece
SET piece.title = '바이올린 소나타 1번', piece.title_en = 'Violin Sonata no. 1, op. 50',
    piece.type = 'album', piece.opus_number = 'Op. 50',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 17681 AND piece.composer_id = 263
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'Allegro con fuoco', part.name_en = 'Violin Sonata no. 1, op. 50: I. Allegro con fuoco',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 17681 AND p.composer_id = 263 AND part.part_key = 'musicbrainz:626bc6ff-7f22-46e5-a152-a351ad7a306c' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:626bc6ff-7f22-46e5-a152-a351ad7a306c', 1, 'I', 'Allegro con fuoco', 'Violin Sonata no. 1, op. 50: I. Allegro con fuoco', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 17681 AND p.composer_id = 263
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:626bc6ff-7f22-46e5-a152-a351ad7a306c'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'Andante', part.name_en = 'Violin Sonata no. 1, op. 50: II. Andante',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 17681 AND p.composer_id = 263 AND part.part_key = 'musicbrainz:95582f46-ede6-419f-8a26-fa89b533188b' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:95582f46-ede6-419f-8a26-fa89b533188b', 2, 'II', 'Andante', 'Violin Sonata no. 1, op. 50: II. Andante', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 17681 AND p.composer_id = 263
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:95582f46-ede6-419f-8a26-fa89b533188b'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = 'Allegro vivace', part.name_en = 'Violin Sonata no. 1, op. 50: III. Allegro vivace',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 17681 AND p.composer_id = 263 AND part.part_key = 'musicbrainz:5bc0c221-f65d-4c0f-815a-ecdd7c5a341d' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:5bc0c221-f65d-4c0f-815a-ecdd7c5a341d', 3, 'III', 'Allegro vivace', 'Violin Sonata no. 1, op. 50: III. Allegro vivace', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 17681 AND p.composer_id = 263
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:5bc0c221-f65d-4c0f-815a-ecdd7c5a341d'
);


-- Op. 72 Introduction et rondo

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, 'Introduction et rondo', 'Introduction et rondo, op. 72', 'song', 'Op. 72', NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 263
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = 'Introduction et rondo'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '7bed68fe-85a7-4b77-a3c9-964082329af0'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '7bed68fe-85a7-4b77-a3c9-964082329af0'
FROM pieces p
WHERE p.composer_id = 263 AND p.title = 'Introduction et rondo' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '7bed68fe-85a7-4b77-a3c9-964082329af0'
);


-- None Organ Symphony no. 1 in C minor, op. 13 no. 1: VII. Finale (Allegro)

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, 'Organ Symphony no. 1 in C minor, op. 13 no. 1: VII. Finale (Allegro)', 'Organ Symphony no. 1 in C minor, op. 13 no. 1: VII. Finale (Allegro)', 'song', NULL, NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 263
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = 'Organ Symphony no. 1 in C minor, op. 13 no. 1: VII. Finale (Allegro)'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'e529e5ae-8f95-4634-8384-75f335cf75a7'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'e529e5ae-8f95-4634-8384-75f335cf75a7'
FROM pieces p
WHERE p.composer_id = 263 AND p.title = 'Organ Symphony no. 1 in C minor, op. 13 no. 1: VII. Finale (Allegro)' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'e529e5ae-8f95-4634-8384-75f335cf75a7'
);


-- Op. 13 No. 3 Organ Symphony no. 3 in E minor

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, 'Organ Symphony no. 3 in E minor', 'Organ Symphony no. 3 in E minor, op. 13 no. 3', 'album', 'Op. 13 No. 3', NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 263
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = 'Organ Symphony no. 3 in E minor'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '70995dc6-d851-46e0-8d18-5688e101ec7f'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '70995dc6-d851-46e0-8d18-5688e101ec7f'
FROM pieces p
WHERE p.composer_id = 263 AND p.title = 'Organ Symphony no. 3 in E minor' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '70995dc6-d851-46e0-8d18-5688e101ec7f'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:a16f16db-86c5-4179-bb6e-ac8488945666', 1, 'I', 'Prélude (Moderato)', 'Organ Symphony no. 3 in E minor, op. 13 no. 3: I. Prélude (Moderato)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 263 AND p.title = 'Organ Symphony no. 3 in E minor' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:a16f16db-86c5-4179-bb6e-ac8488945666'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:9bcdd17c-c521-488a-8292-9479447c7b10', 2, 'II', 'Minuetto', 'Organ Symphony no. 3 in E minor, op. 13 no. 3: II. Minuetto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 263 AND p.title = 'Organ Symphony no. 3 in E minor' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:9bcdd17c-c521-488a-8292-9479447c7b10'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:f1372560-8519-4d20-a345-61f90cc0aa61', 3, 'IV', 'Adagio', 'Organ Symphony no. 3 in E minor, op. 13 no. 3: IV. Adagio', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 263 AND p.title = 'Organ Symphony no. 3 in E minor' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:f1372560-8519-4d20-a345-61f90cc0aa61'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:a445e4f7-8f83-4b04-9e5c-d9b699a45077', 4, 'V', 'Fugue (Moderato assai)', 'Organ Symphony no. 3 in E minor, op. 13 no. 3: V. Fugue (Moderato assai)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 263 AND p.title = 'Organ Symphony no. 3 in E minor' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:a445e4f7-8f83-4b04-9e5c-d9b699a45077'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:ea4cbded-05cd-44f9-bc1e-1d4319d28861', 5, 'VI', 'Final (Allegro molto quasi presto)', 'Organ Symphony no. 3 in E minor, op. 13 no. 3: VI. Final (Allegro molto quasi presto)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 263 AND p.title = 'Organ Symphony no. 3 in E minor' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:ea4cbded-05cd-44f9-bc1e-1d4319d28861'
);


-- None Organ Symphony no. 3 in E minor, op. 13 no. 3: III. Marcia

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, 'Organ Symphony no. 3 in E minor, op. 13 no. 3: III. Marcia', 'Organ Symphony no. 3 in E minor, op. 13 no. 3: III. Marcia', 'song', NULL, NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 263
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = 'Organ Symphony no. 3 in E minor, op. 13 no. 3: III. Marcia'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '6eb98135-fea3-4ae1-aabd-048521369b73'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '6eb98135-fea3-4ae1-aabd-048521369b73'
FROM pieces p
WHERE p.composer_id = 263 AND p.title = 'Organ Symphony no. 3 in E minor, op. 13 no. 3: III. Marcia' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '6eb98135-fea3-4ae1-aabd-048521369b73'
);


-- Op. 42 No. 4 Organ Symphony no. 8 in B major

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, 'Organ Symphony no. 8 in B major', 'Organ Symphony no. 8 in B major, op. 42 no. 4', 'album', 'Op. 42 No. 4', NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 263
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = 'Organ Symphony no. 8 in B major'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '88f9d927-84d1-4592-8f60-221527872800'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '88f9d927-84d1-4592-8f60-221527872800'
FROM pieces p
WHERE p.composer_id = 263 AND p.title = 'Organ Symphony no. 8 in B major' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '88f9d927-84d1-4592-8f60-221527872800'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:b9161c3e-e826-4e74-8e88-dd9338a9b1f2', 1, 'I', 'Allegro risoluto', 'Organ Symphony no. 8 in B major, op. 42 no. 4: I. Allegro risoluto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 263 AND p.title = 'Organ Symphony no. 8 in B major' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:b9161c3e-e826-4e74-8e88-dd9338a9b1f2'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:f97e4083-df84-42d1-94fd-fa89b8428761', 2, 'II', 'Moderato cantabile', 'Organ Symphony no. 8 in B major, op. 42 no. 4: II. Moderato cantabile', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 263 AND p.title = 'Organ Symphony no. 8 in B major' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:f97e4083-df84-42d1-94fd-fa89b8428761'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:924f916b-920d-4ef8-b020-b3ab21b12b74', 3, 'III', 'Allegro', 'Organ Symphony no. 8 in B major, op. 42 no. 4: III. Allegro', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 263 AND p.title = 'Organ Symphony no. 8 in B major' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:924f916b-920d-4ef8-b020-b3ab21b12b74'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:a021b5ac-0a2a-428c-8d5e-bbee658bcba8', 4, 'IV', 'Allegro', 'Organ Symphony no. 8 in B major, op. 42 no. 4: IV. Allegro', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 263 AND p.title = 'Organ Symphony no. 8 in B major' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:a021b5ac-0a2a-428c-8d5e-bbee658bcba8'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:86c2f059-c5be-4cce-b7d2-f6bb3b032331', 5, 'IV', 'Variations. Andante', 'Organ Symphony no. 8 in B major, op. 42 no. 4: IV. Variations. Andante', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 263 AND p.title = 'Organ Symphony no. 8 in B major' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:86c2f059-c5be-4cce-b7d2-f6bb3b032331'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:b60dd17e-be88-4217-8698-feb48df23711', 6, 'V', 'Adagio', 'Organ Symphony no. 8 in B major, op. 42 no. 4: V. Adagio', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 263 AND p.title = 'Organ Symphony no. 8 in B major' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:b60dd17e-be88-4217-8698-feb48df23711'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:98b3e631-3c45-416f-ae61-1845e72f0a95', 7, 'VI', 'Finale. Tempo giusto', 'Organ Symphony no. 8 in B major, op. 42 no. 4: VI. Finale. Tempo giusto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 263 AND p.title = 'Organ Symphony no. 8 in B major' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:98b3e631-3c45-416f-ae61-1845e72f0a95'
);


-- None Suite florentine

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, 'Suite florentine', 'Suite florentine', 'album', NULL, NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 263
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = 'Suite florentine'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'ae160748-1a93-4021-8720-43dc7a2c20d1'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'ae160748-1a93-4021-8720-43dc7a2c20d1'
FROM pieces p
WHERE p.composer_id = 263 AND p.title = 'Suite florentine' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'ae160748-1a93-4021-8720-43dc7a2c20d1'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:11411746-7401-4aa7-916e-d4151d626bab', 1, 'I', 'Cantilena', 'Suite florentine: I. Cantilena', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 263 AND p.title = 'Suite florentine' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:11411746-7401-4aa7-916e-d4151d626bab'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:7be69583-68ea-4d7b-b9be-31ecd358eb64', 2, 'II', 'Alle Cascine', 'Suite florentine: II. Alle Cascine', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 263 AND p.title = 'Suite florentine' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:7be69583-68ea-4d7b-b9be-31ecd358eb64'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:93d32f0f-f537-4062-9535-38115a73fe77', 3, 'III', 'Morbidezza', 'Suite florentine: III. Morbidezza', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 263 AND p.title = 'Suite florentine' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:93d32f0f-f537-4062-9535-38115a73fe77'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:0d21bcc2-acab-4179-a69a-17f919a67688', 4, 'IV', 'Tragica', 'Suite florentine: IV. Tragica', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 263 AND p.title = 'Suite florentine' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:0d21bcc2-acab-4179-a69a-17f919a67688'
);


-- None 바이올린 협주곡

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '바이올린 협주곡', 'Violin Concerto', 'song', NULL, NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 263
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '바이올린 협주곡'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '92cd01b7-7ee4-450d-bee1-eea8faed8356'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '92cd01b7-7ee4-450d-bee1-eea8faed8356'
FROM pieces p
WHERE p.composer_id = 263 AND p.title = '바이올린 협주곡' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '92cd01b7-7ee4-450d-bee1-eea8faed8356'
);


-- 카탈로그에 대응이 없는 seed 작품 5개를 목록에서 숨긴다(지우지 않음).
UPDATE pieces piece
SET piece.hidden_reason = 'catalog_unmatched'
WHERE piece.composer_id = 263 AND piece.origin = 'seed' AND piece.hidden_reason IS NULL
  AND piece.id IN (
    16918, 17752, 18099, 18894, 19779
  )
  AND NOT EXISTS (SELECT 1 FROM performance_sectors sector WHERE sector.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM piece_parts linking WHERE linking.linked_piece_id = piece.id);
