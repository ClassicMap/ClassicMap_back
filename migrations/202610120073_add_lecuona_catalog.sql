-- 에르네스토 레쿠오나 작품을 MusicBrainz 작품 구조로 다시 짠다(4차 자동). 작품 104개(묶음 6, 다악장 3, 낱곡 95),
-- 새 작품 5개, part 57개, 그 아래 0개.
-- seed 116개 중 99개를 작품·part 에 잇고, 14개를 숨기고, 3개는 그대로 둔다.
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
SET piece.title = 'Andalucía (Suite española) (중복 17235)'
WHERE piece.id = 17235 AND piece.composer_id = 307 AND piece.title = 'Andalucía (Suite española)'
  AND piece.origin = 'seed' AND piece.editor_locked = 0
  AND NOT EXISTS (SELECT 1 FROM performance_sectors sector WHERE sector.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM piece_parts linking WHERE linking.linked_piece_id = piece.id);


-- None 19-Century Cuban Dances

UPDATE pieces piece
SET piece.title = '19-Century Cuban Dances', piece.title_en = '19-Century Cuban Dances',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 16849 AND piece.composer_id = 307
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'La primera en la frente', part.name_en = '19-Century Cuban Dances: I. La primera en la frente',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 16849 AND p.composer_id = 307 AND part.part_key = 'musicbrainz:d57f5194-4c40-431a-a323-37d4d6300aeb' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:d57f5194-4c40-431a-a323-37d4d6300aeb', 1, 'I', 'La primera en la frente', '19-Century Cuban Dances: I. La primera en la frente', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 16849 AND p.composer_id = 307
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:d57f5194-4c40-431a-a323-37d4d6300aeb'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'A la antigua (El Tanguito de Mamá)', part.name_en = '19-Century Cuban Dances: II. A la antigua (El Tanguito de Mamá)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 16849 AND p.composer_id = 307 AND part.part_key = 'musicbrainz:e84b20b0-6b8d-4076-ae46-29be7be46b39' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:e84b20b0-6b8d-4076-ae46-29be7be46b39', 2, 'II', 'A la antigua (El Tanguito de Mamá)', '19-Century Cuban Dances: II. A la antigua (El Tanguito de Mamá)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 16849 AND p.composer_id = 307
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:e84b20b0-6b8d-4076-ae46-29be7be46b39'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = 'Impromptu', part.name_en = '19-Century Cuban Dances: III. Impromptu',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 16849 AND p.composer_id = 307 AND part.part_key = 'musicbrainz:f441ef7e-4eaf-4177-878f-5905e20ebad2' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:f441ef7e-4eaf-4177-878f-5905e20ebad2', 3, 'III', 'Impromptu', '19-Century Cuban Dances: III. Impromptu', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 16849 AND p.composer_id = 307
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:f441ef7e-4eaf-4177-878f-5905e20ebad2'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = 'IV',
    part.name_ko = 'La danza interrumpida', part.name_en = '19-Century Cuban Dances: IV. La danza interrumpida',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 16849 AND p.composer_id = 307 AND part.part_key = 'musicbrainz:936626fa-2e85-49a8-92e1-8df565c5b945' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:936626fa-2e85-49a8-92e1-8df565c5b945', 4, 'IV', 'La danza interrumpida', '19-Century Cuban Dances: IV. La danza interrumpida', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 16849 AND p.composer_id = 307
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:936626fa-2e85-49a8-92e1-8df565c5b945'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 5, part.movement_number = 'V',
    part.name_ko = 'La mulata', part.name_en = '19-Century Cuban Dances: V. La mulata',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 16849 AND p.composer_id = 307 AND part.part_key = 'musicbrainz:93854124-279d-435a-8ffa-b4a661b45acf' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:93854124-279d-435a-8ffa-b4a661b45acf', 5, 'V', 'La mulata', '19-Century Cuban Dances: V. La mulata', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 16849 AND p.composer_id = 307
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:93854124-279d-435a-8ffa-b4a661b45acf'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 6, part.movement_number = 'VI',
    part.name_ko = 'Arabesque', part.name_en = '19-Century Cuban Dances: VI. Arabesque',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 16849 AND p.composer_id = 307 AND part.part_key = 'musicbrainz:a0b5a2fb-35ad-45f4-8b58-fd5a0c93934f' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:a0b5a2fb-35ad-45f4-8b58-fd5a0c93934f', 6, 'VI', 'Arabesque', '19-Century Cuban Dances: VI. Arabesque', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 16849 AND p.composer_id = 307
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:a0b5a2fb-35ad-45f4-8b58-fd5a0c93934f'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 7, part.movement_number = 'VII',
    part.name_ko = 'Ella y Yo', part.name_en = '19-Century Cuban Dances: VII. Ella y Yo',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 16849 AND p.composer_id = 307 AND part.part_key = 'musicbrainz:b6e12710-6efe-465d-a39a-f0e4a47dc1df' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:b6e12710-6efe-465d-a39a-f0e4a47dc1df', 7, 'VII', 'Ella y Yo', '19-Century Cuban Dances: VII. Ella y Yo', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 16849 AND p.composer_id = 307
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:b6e12710-6efe-465d-a39a-f0e4a47dc1df'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 8, part.movement_number = 'VIII',
    part.name_ko = 'La cardenense', part.name_en = '19-Century Cuban Dances: VIII. La cardenense',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 16849 AND p.composer_id = 307 AND part.part_key = 'musicbrainz:71ba6fc9-3086-4705-ae1d-548bfa121990' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:71ba6fc9-3086-4705-ae1d-548bfa121990', 8, 'VIII', 'La cardenense', '19-Century Cuban Dances: VIII. La cardenense', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 16849 AND p.composer_id = 307
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:71ba6fc9-3086-4705-ae1d-548bfa121990'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 9, part.movement_number = 'IX',
    part.name_ko = '¡Al fin te ví!', part.name_en = '19-Century Cuban Dances: IX. ¡Al fin te ví!',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 16849 AND p.composer_id = 307 AND part.part_key = 'musicbrainz:84c2b0dc-4600-4fca-8241-d8e533da2bec' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:84c2b0dc-4600-4fca-8241-d8e533da2bec', 9, 'IX', '¡Al fin te ví!', '19-Century Cuban Dances: IX. ¡Al fin te ví!', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 16849 AND p.composer_id = 307
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:84c2b0dc-4600-4fca-8241-d8e533da2bec'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 10, part.movement_number = 'X',
    part.name_ko = 'Los Minstrels', part.name_en = '19-Century Cuban Dances: X. Los Minstrels',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 16849 AND p.composer_id = 307 AND part.part_key = 'musicbrainz:c3b62192-6781-4ae8-a2c2-bc775eaacd18' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:c3b62192-6781-4ae8-a2c2-bc775eaacd18', 10, 'X', 'Los Minstrels', '19-Century Cuban Dances: X. Los Minstrels', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 16849 AND p.composer_id = 307
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:c3b62192-6781-4ae8-a2c2-bc775eaacd18'
);


-- None A Media Noche

UPDATE pieces piece
SET piece.title = 'A Media Noche', piece.title_en = 'A Media Noche',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 19486 AND piece.composer_id = 307
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None A la antigua

UPDATE pieces piece
SET piece.title = 'A la antigua', piece.title_en = 'A la antigua',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 18655 AND piece.composer_id = 307
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Adiós a las trincheras (One-Step)

UPDATE pieces piece
SET piece.title = 'Adiós a las trincheras (One-Step)', piece.title_en = 'Adiós a las trincheras (One-Step)',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 19332 AND piece.composer_id = 307
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None 가곡 <Al fin>

UPDATE pieces piece
SET piece.title = '가곡 <Al fin>', piece.title_en = 'Al fin',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 18870 AND piece.composer_id = 307
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None 가곡 <Allá en la sierra (from "Córdoba">

UPDATE pieces piece
SET piece.title = '가곡 <Allá en la sierra (from "Córdoba">', piece.title_en = 'Allá en la sierra (from "Córdoba"',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 16168 AND piece.composer_id = 307
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None 가곡 <Amor tardio>

UPDATE pieces piece
SET piece.title = '가곡 <Amor tardio>', piece.title_en = 'Amor tardio',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 19298 AND piece.composer_id = 307
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Amorosa

UPDATE pieces piece
SET piece.title = 'Amorosa', piece.title_en = 'Amorosa',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 19187 AND piece.composer_id = 307
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Andalucía (Suite española)

UPDATE pieces piece
SET piece.title = 'Andalucía (Suite española)', piece.title_en = 'Andalucía (Suite española)',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 19587 AND piece.composer_id = 307
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'Córdoba', part.name_en = 'Andalucía (Suite española): I. Córdoba',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 19587 AND p.composer_id = 307 AND part.part_key = 'musicbrainz:6fda8f5c-5457-4541-a288-7bc9f93cb607' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:6fda8f5c-5457-4541-a288-7bc9f93cb607', 1, 'I', 'Córdoba', 'Andalucía (Suite española): I. Córdoba', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 19587 AND p.composer_id = 307
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:6fda8f5c-5457-4541-a288-7bc9f93cb607'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'Andaluza', part.name_en = 'Andalucía (Suite española): II. Andaluza',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 19587 AND p.composer_id = 307 AND part.part_key = 'musicbrainz:d7ecf3a1-e0a2-4452-8053-768a6838e4b7' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:d7ecf3a1-e0a2-4452-8053-768a6838e4b7', 2, 'II', 'Andaluza', 'Andalucía (Suite española): II. Andaluza', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 19587 AND p.composer_id = 307
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:d7ecf3a1-e0a2-4452-8053-768a6838e4b7'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = 'Alhambra', part.name_en = 'Andalucía (Suite española): III. Alhambra',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 19587 AND p.composer_id = 307 AND part.part_key = 'musicbrainz:685400b0-d9c8-42e1-9ecf-453ab2f2dffb' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:685400b0-d9c8-42e1-9ecf-453ab2f2dffb', 3, 'III', 'Alhambra', 'Andalucía (Suite española): III. Alhambra', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 19587 AND p.composer_id = 307
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:685400b0-d9c8-42e1-9ecf-453ab2f2dffb'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = 'IV',
    part.name_ko = 'Gitanerías', part.name_en = 'Andalucía (Suite española): IV. Gitanerías',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 19587 AND p.composer_id = 307 AND part.part_key = 'musicbrainz:36549b7e-400e-4f29-acc0-5dac7c987321' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:36549b7e-400e-4f29-acc0-5dac7c987321', 4, 'IV', 'Gitanerías', 'Andalucía (Suite española): IV. Gitanerías', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 19587 AND p.composer_id = 307
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:36549b7e-400e-4f29-acc0-5dac7c987321'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 5, part.movement_number = 'V',
    part.name_ko = 'Guadalquivír', part.name_en = 'Andalucía (Suite española): V. Guadalquivír',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 19587 AND p.composer_id = 307 AND part.part_key = 'musicbrainz:791f97c3-6587-4f16-b322-b35f2f815cb5' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:791f97c3-6587-4f16-b322-b35f2f815cb5', 5, 'V', 'Guadalquivír', 'Andalucía (Suite española): V. Guadalquivír', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 19587 AND p.composer_id = 307
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:791f97c3-6587-4f16-b322-b35f2f815cb5'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 6, part.movement_number = 'VI',
    part.name_ko = 'Malagueña', part.name_en = 'Andalucía (Suite española): VI. Malagueña',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 19587 AND p.composer_id = 307 AND part.part_key = 'musicbrainz:5691f2b2-a336-4fdf-877c-79012ae6dea6' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:5691f2b2-a336-4fdf-877c-79012ae6dea6', 6, 'VI', 'Malagueña', 'Andalucía (Suite española): VI. Malagueña', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 19587 AND p.composer_id = 307
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:5691f2b2-a336-4fdf-877c-79012ae6dea6'
);


-- None Ante el Escorial

UPDATE pieces piece
SET piece.title = 'Ante el Escorial', piece.title_en = 'Ante el Escorial',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 16046 AND piece.composer_id = 307
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Aragonesa

UPDATE pieces piece
SET piece.title = 'Aragonesa', piece.title_en = 'Aragonesa',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 16554 AND piece.composer_id = 307
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Aragón (vals España)

UPDATE pieces piece
SET piece.title = 'Aragón (vals España)', piece.title_en = 'Aragón (vals España)',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 17027 AND piece.composer_id = 307
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None 가곡 <At the Cross-Roads>

UPDATE pieces piece
SET piece.title = '가곡 <At the Cross-Roads>', piece.title_en = 'At the Cross-Roads',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 17285 AND piece.composer_id = 307
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Barba-Azul

UPDATE pieces piece
SET piece.title = 'Barba-Azul', piece.title_en = 'Barba-Azul',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 19881 AND piece.composer_id = 307
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Black Cat (One-Step)

UPDATE pieces piece
SET piece.title = 'Black Cat (One-Step)', piece.title_en = 'Black Cat (One-Step)',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 16298 AND piece.composer_id = 307
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Broken Blossoms

UPDATE pieces piece
SET piece.title = 'Broken Blossoms', piece.title_en = 'Broken Blossoms',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 19614 AND piece.composer_id = 307
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Bésame

UPDATE pieces piece
SET piece.title = 'Bésame', piece.title_en = 'Bésame',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 18696 AND piece.composer_id = 307
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None 가곡 <Canción del amor triste>

UPDATE pieces piece
SET piece.title = '가곡 <Canción del amor triste>', piece.title_en = 'Canción del amor triste',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 16272 AND piece.composer_id = 307
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None 가곡 <Canto Indio>

UPDATE pieces piece
SET piece.title = '가곡 <Canto Indio>', piece.title_en = 'Canto Indio',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 18590 AND piece.composer_id = 307
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Canto del guajiro

UPDATE pieces piece
SET piece.title = 'Canto del guajiro', piece.title_en = 'Canto del guajiro',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 19839 AND piece.composer_id = 307
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None 가곡 <Canto karabali>

UPDATE pieces piece
SET piece.title = '가곡 <Canto karabali>', piece.title_en = 'Canto karabali',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 16924 AND piece.composer_id = 307
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None 가곡 <Como el arrullo de palma>

UPDATE pieces piece
SET piece.title = '가곡 <Como el arrullo de palma>', piece.title_en = 'Como el arrullo de palma',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 18783 AND piece.composer_id = 307
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None 가곡 <Como presiento>

UPDATE pieces piece
SET piece.title = '가곡 <Como presiento>', piece.title_en = 'Como presiento',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 17964 AND piece.composer_id = 307
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None 가곡 <Conga Cuba>

UPDATE pieces piece
SET piece.title = '가곡 <Conga Cuba>', piece.title_en = 'Conga Cuba',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 19333 AND piece.composer_id = 307
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Crisantemo

UPDATE pieces piece
SET piece.title = 'Crisantemo', piece.title_en = 'Crisantemo',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 19423 AND piece.composer_id = 307
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Cuba and America (March and Two-Step)

UPDATE pieces piece
SET piece.title = 'Cuba and America (March and Two-Step)', piece.title_en = 'Cuba and America (March and Two-Step)',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 17543 AND piece.composer_id = 307
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Cuba at Arms (One-Step)

UPDATE pieces piece
SET piece.title = 'Cuba at Arms (One-Step)', piece.title_en = 'Cuba at Arms (One-Step)',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 17868 AND piece.composer_id = 307
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None 가곡 <Dame el amor>

UPDATE pieces piece
SET piece.title = '가곡 <Dame el amor>', piece.title_en = 'Dame el amor',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 18079 AND piece.composer_id = 307
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None 가곡 <Damisela encantadora>

UPDATE pieces piece
SET piece.title = '가곡 <Damisela encantadora>', piece.title_en = 'Damisela encantadora',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 16842 AND piece.composer_id = 307
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Danzas Cubanas

UPDATE pieces piece
SET piece.title = 'Danzas Cubanas', piece.title_en = 'Danzas Cubanas',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 19677 AND piece.composer_id = 307
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = '¡No hables más!', part.name_en = 'Danzas Cubanas: I. ¡No hables más!',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 19677 AND p.composer_id = 307 AND part.part_key = 'musicbrainz:9eb9465c-b0f3-45d0-8182-e368d186252e' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:9eb9465c-b0f3-45d0-8182-e368d186252e', 1, 'I', '¡No hables más!', 'Danzas Cubanas: I. ¡No hables más!', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 19677 AND p.composer_id = 307
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:9eb9465c-b0f3-45d0-8182-e368d186252e'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'No puedo contigo', part.name_en = 'Danzas Cubanas: II. No puedo contigo',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 19677 AND p.composer_id = 307 AND part.part_key = 'musicbrainz:65f5549f-2144-4a2b-a56d-c6f4d0a6090d' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:65f5549f-2144-4a2b-a56d-c6f4d0a6090d', 2, 'II', 'No puedo contigo', 'Danzas Cubanas: II. No puedo contigo', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 19677 AND p.composer_id = 307
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:65f5549f-2144-4a2b-a56d-c6f4d0a6090d'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = 'Ahí viene el chino', part.name_en = 'Danzas Cubanas: III. Ahí viene el chino',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 19677 AND p.composer_id = 307 AND part.part_key = 'musicbrainz:fe71c6f1-50b0-4bd5-9e86-2ab94881660b' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:fe71c6f1-50b0-4bd5-9e86-2ab94881660b', 3, 'III', 'Ahí viene el chino', 'Danzas Cubanas: III. Ahí viene el chino', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 19677 AND p.composer_id = 307
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:fe71c6f1-50b0-4bd5-9e86-2ab94881660b'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = 'IV',
    part.name_ko = '¿Por qué te vas?', part.name_en = 'Danzas Cubanas: IV. ¿Por qué te vas?',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 19677 AND p.composer_id = 307 AND part.part_key = 'musicbrainz:b0c8f722-df8c-4f34-92fb-7fb24557fa0c' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:b0c8f722-df8c-4f34-92fb-7fb24557fa0c', 4, 'IV', '¿Por qué te vas?', 'Danzas Cubanas: IV. ¿Por qué te vas?', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 19677 AND p.composer_id = 307
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:b0c8f722-df8c-4f34-92fb-7fb24557fa0c'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 5, part.movement_number = 'V',
    part.name_ko = 'Lola está de fiesta', part.name_en = 'Danzas Cubanas: V. Lola está de fiesta',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 19677 AND p.composer_id = 307 AND part.part_key = 'musicbrainz:47660d37-c867-4861-9264-6c9a12f5a21b' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:47660d37-c867-4861-9264-6c9a12f5a21b', 5, 'V', 'Lola está de fiesta', 'Danzas Cubanas: V. Lola está de fiesta', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 19677 AND p.composer_id = 307
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:47660d37-c867-4861-9264-6c9a12f5a21b'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 6, part.movement_number = 'VI',
    part.name_ko = 'En tres por cuatro', part.name_en = 'Danzas Cubanas: VI. En tres por cuatro',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 19677 AND p.composer_id = 307 AND part.part_key = 'musicbrainz:d1ef5dbe-280c-4ae2-a392-e8eff3d608b6' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:d1ef5dbe-280c-4ae2-a392-e8eff3d608b6', 6, 'VI', 'En tres por cuatro', 'Danzas Cubanas: VI. En tres por cuatro', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 19677 AND p.composer_id = 307
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:d1ef5dbe-280c-4ae2-a392-e8eff3d608b6'
);


-- None Danzas afro-cubanas

UPDATE pieces piece
SET piece.title = 'Danzas afro-cubanas', piece.title_en = 'Danzas afro-cubanas',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 16421 AND piece.composer_id = 307
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'Danza lucumí', part.name_en = 'Danzas afro-cubanas: Danza lucumí',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 16421 AND p.composer_id = 307 AND part.part_key = 'musicbrainz:0624f788-fa2c-4021-bc7f-7bb64033145f' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:0624f788-fa2c-4021-bc7f-7bb64033145f', 1, NULL, 'Danza lucumí', 'Danzas afro-cubanas: Danza lucumí', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 16421 AND p.composer_id = 307
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:0624f788-fa2c-4021-bc7f-7bb64033145f'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'La conga de media noche', part.name_en = 'La conga de media noche',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 16421 AND p.composer_id = 307 AND part.part_key = 'musicbrainz:28a7e802-f758-4b09-ba4e-02c624d73db0' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:28a7e802-f758-4b09-ba4e-02c624d73db0', 2, NULL, 'La conga de media noche', 'La conga de media noche', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 16421 AND p.composer_id = 307
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:28a7e802-f758-4b09-ba4e-02c624d73db0'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = NULL,
    part.name_ko = 'La comparsa', part.name_en = 'Danzas afro-cubanas: La comparsa',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 16421 AND p.composer_id = 307 AND part.part_key = 'musicbrainz:51088166-f76d-499a-8f69-a530030d7eff' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:51088166-f76d-499a-8f69-a530030d7eff', 3, NULL, 'La comparsa', 'Danzas afro-cubanas: La comparsa', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 16421 AND p.composer_id = 307
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:51088166-f76d-499a-8f69-a530030d7eff'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = NULL,
    part.name_ko = 'Danzas de los ñáñigos', part.name_en = 'Danzas afro-cubanas: Danzas de los ñáñigos',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 16421 AND p.composer_id = 307 AND part.part_key = 'musicbrainz:917fce74-c1c5-4947-a326-d9623b150705' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:917fce74-c1c5-4947-a326-d9623b150705', 4, NULL, 'Danzas de los ñáñigos', 'Danzas afro-cubanas: Danzas de los ñáñigos', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 16421 AND p.composer_id = 307
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:917fce74-c1c5-4947-a326-d9623b150705'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 5, part.movement_number = NULL,
    part.name_ko = '¡...y la negra bailaba!', part.name_en = 'Danzas afro-cubanas: ¡...y la negra bailaba!',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 16421 AND p.composer_id = 307 AND part.part_key = 'musicbrainz:b4850ead-377a-4e75-a907-373537396e55' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:b4850ead-377a-4e75-a907-373537396e55', 5, NULL, '¡...y la negra bailaba!', 'Danzas afro-cubanas: ¡...y la negra bailaba!', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 16421 AND p.composer_id = 307
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:b4850ead-377a-4e75-a907-373537396e55'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 6, part.movement_number = NULL,
    part.name_ko = 'Danza negra', part.name_en = 'Danzas afro-cubanas: Danza negra',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 16421 AND p.composer_id = 307 AND part.part_key = 'musicbrainz:d2c292a4-21b9-4102-883d-cdab9a49e938' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:d2c292a4-21b9-4102-883d-cdab9a49e938', 6, NULL, 'Danza negra', 'Danzas afro-cubanas: Danza negra', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 16421 AND p.composer_id = 307
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:d2c292a4-21b9-4102-883d-cdab9a49e938'
);


-- None Danzas cubanas al estilo del siglo XIX

UPDATE pieces piece
SET piece.title = 'Danzas cubanas al estilo del siglo XIX', piece.title_en = 'Danzas cubanas al estilo del siglo XIX',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 16239 AND piece.composer_id = 307
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'La cardenense', part.name_en = 'Danzas cubanas al estilo del siglo XIX (Excerpts): No. 8, La cardenense',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 16239 AND p.composer_id = 307 AND part.part_key = 'musicbrainz:61572eb5-4f08-4dff-a367-ec05dc7262b0' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:61572eb5-4f08-4dff-a367-ec05dc7262b0', 1, NULL, 'La cardenense', 'Danzas cubanas al estilo del siglo XIX (Excerpts): No. 8, La cardenense', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 16239 AND p.composer_id = 307
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:61572eb5-4f08-4dff-a367-ec05dc7262b0'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'Arabesque', part.name_en = 'Danzas cubanas al estilo del siglo XIX (Excerpts): No. 6, Arabesque',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 16239 AND p.composer_id = 307 AND part.part_key = 'musicbrainz:69fe91e0-0610-4235-a521-d53946bf0636' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:69fe91e0-0610-4235-a521-d53946bf0636', 2, NULL, 'Arabesque', 'Danzas cubanas al estilo del siglo XIX (Excerpts): No. 6, Arabesque', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 16239 AND p.composer_id = 307
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:69fe91e0-0610-4235-a521-d53946bf0636'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = NULL,
    part.name_ko = 'La mulata', part.name_en = 'Danzas cubanas al estilo del siglo XIX (Excerpts): No. 5, La mulata',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 16239 AND p.composer_id = 307 AND part.part_key = 'musicbrainz:82dec8ab-b847-4333-91a6-ce33d2a391cf' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:82dec8ab-b847-4333-91a6-ce33d2a391cf', 3, NULL, 'La mulata', 'Danzas cubanas al estilo del siglo XIX (Excerpts): No. 5, La mulata', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 16239 AND p.composer_id = 307
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:82dec8ab-b847-4333-91a6-ce33d2a391cf'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = NULL,
    part.name_ko = 'Al fin te vi', part.name_en = 'Danzas cubanas al estilo del siglo XIX (Excerpts): No. 9, Al fin te vi',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 16239 AND p.composer_id = 307 AND part.part_key = 'musicbrainz:cad807b2-58ec-47c8-9277-6514bf353137' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:cad807b2-58ec-47c8-9277-6514bf353137', 4, NULL, 'Al fin te vi', 'Danzas cubanas al estilo del siglo XIX (Excerpts): No. 9, Al fin te vi', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 16239 AND p.composer_id = 307
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:cad807b2-58ec-47c8-9277-6514bf353137'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 5, part.movement_number = NULL,
    part.name_ko = 'Minstrels', part.name_en = 'Danzas cubanas al estilo del siglo XIX (Excerpts): No. 10, Minstrels',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 16239 AND p.composer_id = 307 AND part.part_key = 'musicbrainz:ea80ac4b-f626-46b8-9500-bd9f5e9c1df4' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:ea80ac4b-f626-46b8-9500-bd9f5e9c1df4', 5, NULL, 'Minstrels', 'Danzas cubanas al estilo del siglo XIX (Excerpts): No. 10, Minstrels', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 16239 AND p.composer_id = 307
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:ea80ac4b-f626-46b8-9500-bd9f5e9c1df4'
);


-- None 가곡 <Devuélveme el corazón>

UPDATE pieces piece
SET piece.title = '가곡 <Devuélveme el corazón>', piece.title_en = 'Devuélveme el corazón',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 16956 AND piece.composer_id = 307
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Diary of a Child

UPDATE pieces piece
SET piece.title = 'Diary of a Child', piece.title_en = 'Diary of a Child',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 17807 AND piece.composer_id = 307
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'Good Morning (Buenos días)', part.name_en = 'Diary of a Child: Good Morning (Buenos días)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 17807 AND p.composer_id = 307 AND part.part_key = 'musicbrainz:ff1b4c72-e683-4b5f-8407-f7876731df0f' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:ff1b4c72-e683-4b5f-8407-f7876731df0f', 1, NULL, 'Good Morning (Buenos días)', 'Diary of a Child: Good Morning (Buenos días)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 17807 AND p.composer_id = 307
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:ff1b4c72-e683-4b5f-8407-f7876731df0f'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'The Puppet''s Dance (El baile de la muñeca)', part.name_en = 'Diary of a Child: The Puppet''s Dance (El baile de la muñeca)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 17807 AND p.composer_id = 307 AND part.part_key = 'musicbrainz:4f17a4a7-ccfa-4357-81de-fd7cdfddb1e6' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:4f17a4a7-ccfa-4357-81de-fd7cdfddb1e6', 2, NULL, 'The Puppet''s Dance (El baile de la muñeca)', 'Diary of a Child: The Puppet''s Dance (El baile de la muñeca)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 17807 AND p.composer_id = 307
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:4f17a4a7-ccfa-4357-81de-fd7cdfddb1e6'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = NULL,
    part.name_ko = 'Merry-Go-Round (Carrusel)', part.name_en = 'Diary of a Child: Merry-Go-Round (Carrusel)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 17807 AND p.composer_id = 307 AND part.part_key = 'musicbrainz:e32c5699-7f16-43ed-b775-184f87a4fdf1' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:e32c5699-7f16-43ed-b775-184f87a4fdf1', 3, NULL, 'Merry-Go-Round (Carrusel)', 'Diary of a Child: Merry-Go-Round (Carrusel)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 17807 AND p.composer_id = 307
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:e32c5699-7f16-43ed-b775-184f87a4fdf1'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = NULL,
    part.name_ko = 'The Moon Lights Up (Canción de luna)', part.name_en = 'Diary of a Child: The Moon Lights Up (Canción de luna)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 17807 AND p.composer_id = 307 AND part.part_key = 'musicbrainz:eb2068bc-421c-4759-abec-2d4f5c97d726' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:eb2068bc-421c-4759-abec-2d4f5c97d726', 4, NULL, 'The Moon Lights Up (Canción de luna)', 'Diary of a Child: The Moon Lights Up (Canción de luna)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 17807 AND p.composer_id = 307
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:eb2068bc-421c-4759-abec-2d4f5c97d726'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 5, part.movement_number = NULL,
    part.name_ko = 'The Dolls Have a Party (Bacanal de muñecos)', part.name_en = 'Diary of a Child: The Dolls Have a Party (Bacanal de muñecos)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 17807 AND p.composer_id = 307 AND part.part_key = 'musicbrainz:9904560a-7f3a-4d43-95c4-5dec7aa31c8c' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:9904560a-7f3a-4d43-95c4-5dec7aa31c8c', 5, NULL, 'The Dolls Have a Party (Bacanal de muñecos)', 'Diary of a Child: The Dolls Have a Party (Bacanal de muñecos)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 17807 AND p.composer_id = 307
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:9904560a-7f3a-4d43-95c4-5dec7aa31c8c'
);


-- None 가곡 <Eclipse>

UPDATE pieces piece
SET piece.title = '가곡 <Eclipse>', piece.title_en = 'Eclipse',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 17668 AND piece.composer_id = 307
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None 가곡 <El pregón de las flores>

UPDATE pieces piece
SET piece.title = '가곡 <El pregón de las flores>', piece.title_en = 'El pregón de las flores',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 19686 AND piece.composer_id = 307
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None 가곡 <En una noche así (from the film "Carnival in Costa Rica")>

UPDATE pieces piece
SET piece.title = '가곡 <En una noche así (from the film "Carnival in Costa Rica")>', piece.title_en = 'En una noche así (from the film "Carnival in Costa Rica")',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 18298 AND piece.composer_id = 307
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Gardenia

UPDATE pieces piece
SET piece.title = 'Gardenia', piece.title_en = 'Gardenia',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 19767 AND piece.composer_id = 307
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Granada

UPDATE pieces piece
SET piece.title = 'Granada', piece.title_en = 'Granada',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 18904 AND piece.composer_id = 307
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Havannan yö

UPDATE pieces piece
SET piece.title = 'Havannan yö', piece.title_en = 'Havannan yö',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 19017 AND piece.composer_id = 307
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None 즉흥곡

UPDATE pieces piece
SET piece.title = '즉흥곡', piece.title_en = 'Impromptu',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 16825 AND piece.composer_id = 307
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None 가곡 <Jungle Drums>

UPDATE pieces piece
SET piece.title = '가곡 <Jungle Drums>', piece.title_en = 'Jungle Drums',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 15914 AND piece.composer_id = 307
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None 가곡 <Juventud>

UPDATE pieces piece
SET piece.title = '가곡 <Juventud>', piece.title_en = 'Juventud',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 19141 AND piece.composer_id = 307
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None 가곡 <La Conga se va>

UPDATE pieces piece
SET piece.title = '가곡 <La Conga se va>', piece.title_en = 'La Conga se va',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 19774 AND piece.composer_id = 307
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None La habanera

UPDATE pieces piece
SET piece.title = 'La habanera', piece.title_en = 'La habanera',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 19233 AND piece.composer_id = 307
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Locura

UPDATE pieces piece
SET piece.title = 'Locura', piece.title_en = 'Locura',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 18621 AND piece.composer_id = 307
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Mazurka en glissando

UPDATE pieces piece
SET piece.title = 'Mazurka en glissando', piece.title_en = 'Mazurka en glissando',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 18994 AND piece.composer_id = 307
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None 가곡 <Me has dejado>

UPDATE pieces piece
SET piece.title = '가곡 <Me has dejado>', piece.title_en = 'Me has dejado',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 19450 AND piece.composer_id = 307
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None 가곡 <Mi amor fue una flor>

UPDATE pieces piece
SET piece.title = '가곡 <Mi amor fue una flor>', piece.title_en = 'Mi amor fue una flor',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 19571 AND piece.composer_id = 307
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None 가곡 <Mi corazón se fué>

UPDATE pieces piece
SET piece.title = '가곡 <Mi corazón se fué>', piece.title_en = 'Mi corazón se fué',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 18802 AND piece.composer_id = 307
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Musetta

UPDATE pieces piece
SET piece.title = 'Musetta', piece.title_en = 'Musetta',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 16904 AND piece.composer_id = 307
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None 가곡 <No me engañarás>

UPDATE pieces piece
SET piece.title = '가곡 <No me engañarás>', piece.title_en = 'No me engañarás',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 18053 AND piece.composer_id = 307
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None 가곡 <No me mires ni me hables>

UPDATE pieces piece
SET piece.title = '가곡 <No me mires ni me hables>', piece.title_en = 'No me mires ni me hables',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 17188 AND piece.composer_id = 307
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None 가곡 <Noche azul>

UPDATE pieces piece
SET piece.title = '가곡 <Noche azul>', piece.title_en = 'Noche azul',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 17022 AND piece.composer_id = 307
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Noche de estrellas

UPDATE pieces piece
SET piece.title = 'Noche de estrellas', piece.title_en = 'Noche de estrellas',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 19772 AND piece.composer_id = 307
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Noches de Primavera

UPDATE pieces piece
SET piece.title = 'Noches de Primavera', piece.title_en = 'Noches de Primavera',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 16485 AND piece.composer_id = 307
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Ojos triunfadores

UPDATE pieces piece
SET piece.title = 'Ojos triunfadores', piece.title_en = 'Ojos triunfadores',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 19765 AND piece.composer_id = 307
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Palomitas Blancas

UPDATE pieces piece
SET piece.title = 'Palomitas Blancas', piece.title_en = 'Palomitas Blancas',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 20053 AND piece.composer_id = 307
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None 가곡 <Para Vigo me voy>

UPDATE pieces piece
SET piece.title = '가곡 <Para Vigo me voy>', piece.title_en = 'Para Vigo me voy',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 15903 AND piece.composer_id = 307
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Parisiana

UPDATE pieces piece
SET piece.title = 'Parisiana', piece.title_en = 'Parisiana',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 16888 AND piece.composer_id = 307
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Polka de los enanos

UPDATE pieces piece
SET piece.title = 'Polka de los enanos', piece.title_en = 'Polka de los enanos',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 19804 AND piece.composer_id = 307
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Porcelana china (danza de muñecos)

UPDATE pieces piece
SET piece.title = 'Porcelana china (danza de muñecos)', piece.title_en = 'Porcelana china (danza de muñecos)',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 16621 AND piece.composer_id = 307
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Preludio en la noche

UPDATE pieces piece
SET piece.title = 'Preludio en la noche', piece.title_en = 'Preludio en la noche',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 17350 AND piece.composer_id = 307
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None 가곡 <Primavera de ilusión>

UPDATE pieces piece
SET piece.title = '가곡 <Primavera de ilusión>', piece.title_en = 'Primavera de ilusión',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 16333 AND piece.composer_id = 307
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Quasi bolero

UPDATE pieces piece
SET piece.title = 'Quasi bolero', piece.title_en = 'Quasi bolero',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 16890 AND piece.composer_id = 307
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None 가곡 <Que risa me da>

UPDATE pieces piece
SET piece.title = '가곡 <Que risa me da>', piece.title_en = 'Que risa me da',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 16917 AND piece.composer_id = 307
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Rapsodia argentina

UPDATE pieces piece
SET piece.title = 'Rapsodia argentina', piece.title_en = 'Rapsodia argentina',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 20066 AND piece.composer_id = 307
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Rapsodia cubana (On Cuban Airs)

UPDATE pieces piece
SET piece.title = 'Rapsodia cubana (On Cuban Airs)', piece.title_en = 'Rapsodia cubana (On Cuban Airs)',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 19769 AND piece.composer_id = 307
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Rapsodia negra

UPDATE pieces piece
SET piece.title = 'Rapsodia negra', piece.title_en = 'Rapsodia negra',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 16387 AND piece.composer_id = 307
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None 사르수엘라 <Rosa la China>

UPDATE pieces piece
SET piece.title = '사르수엘라 <Rosa la China>', piece.title_en = 'Rosa la China',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 19364 AND piece.composer_id = 307
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None 가곡 <Rumba mejoral>

UPDATE pieces piece
SET piece.title = '가곡 <Rumba mejoral>', piece.title_en = 'Rumba mejoral',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 16808 AND piece.composer_id = 307
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None San Francisco el Grande

UPDATE pieces piece
SET piece.title = 'San Francisco el Grande', piece.title_en = 'San Francisco el Grande',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 19934 AND piece.composer_id = 307
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None 가곡 <Se Fue>

UPDATE pieces piece
SET piece.title = '가곡 <Se Fue>', piece.title_en = 'Se Fue',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 16525 AND piece.composer_id = 307
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None 가곡 <Se abrieron las flores>

UPDATE pieces piece
SET piece.title = '가곡 <Se abrieron las flores>', piece.title_en = 'Se abrieron las flores',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 19107 AND piece.composer_id = 307
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None 가곡 <Siboney>

UPDATE pieces piece
SET piece.title = '가곡 <Siboney>', piece.title_en = 'Siboney',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 26017 AND piece.composer_id = 307
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None 가곡 <Siempre en mi corazón>

UPDATE pieces piece
SET piece.title = '가곡 <Siempre en mi corazón>', piece.title_en = 'Siempre en mi corazón',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 15808 AND piece.composer_id = 307
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Siete danzas cubanas típicas

UPDATE pieces piece
SET piece.title = 'Siete danzas cubanas típicas', piece.title_en = 'Siete danzas cubanas típicas',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 18403 AND piece.composer_id = 307
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'Mis tristezas', part.name_en = 'Siete danzas cubanas típicas: Mis tristezas',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 18403 AND p.composer_id = 307 AND part.part_key = 'musicbrainz:1776af75-8137-4ef2-8555-787a40997205' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:1776af75-8137-4ef2-8555-787a40997205', 1, NULL, 'Mis tristezas', 'Siete danzas cubanas típicas: Mis tristezas', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 18403 AND p.composer_id = 307
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:1776af75-8137-4ef2-8555-787a40997205'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'La 32', part.name_en = 'Siete danzas cubanas típicas: La 32',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 18403 AND p.composer_id = 307 AND part.part_key = 'musicbrainz:19f8eacf-9802-4ac5-bd6a-d264a4fdbd71' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:19f8eacf-9802-4ac5-bd6a-d264a4fdbd71', 2, NULL, 'La 32', 'Siete danzas cubanas típicas: La 32', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 18403 AND p.composer_id = 307
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:19f8eacf-9802-4ac5-bd6a-d264a4fdbd71'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = NULL,
    part.name_ko = 'Burlesca', part.name_en = 'Siete danzas cubanas típicas: Burlesca',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 18403 AND p.composer_id = 307 AND part.part_key = 'musicbrainz:1d9bd356-b84d-4cd8-bc74-746858d368bb' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:1d9bd356-b84d-4cd8-bc74-746858d368bb', 3, NULL, 'Burlesca', 'Siete danzas cubanas típicas: Burlesca', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 18403 AND p.composer_id = 307
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:1d9bd356-b84d-4cd8-bc74-746858d368bb'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = NULL,
    part.name_ko = '¡Cómo baila el muñeco!', part.name_en = 'Siete danzas cubanas típicas: ¡Cómo baila el muñeco!',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 18403 AND p.composer_id = 307 AND part.part_key = 'musicbrainz:36452192-8080-49f5-b32f-0715ec8e43fc' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:36452192-8080-49f5-b32f-0715ec8e43fc', 4, NULL, '¡Cómo baila el muñeco!', 'Siete danzas cubanas típicas: ¡Cómo baila el muñeco!', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 18403 AND p.composer_id = 307
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:36452192-8080-49f5-b32f-0715ec8e43fc'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 5, part.movement_number = NULL,
    part.name_ko = 'El miriñaque', part.name_en = 'Siete danzas cubanas típicas: El miriñaque',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 18403 AND p.composer_id = 307 AND part.part_key = 'musicbrainz:4db346cb-523f-4502-bc29-66c51699052d' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:4db346cb-523f-4502-bc29-66c51699052d', 5, NULL, 'El miriñaque', 'Siete danzas cubanas típicas: El miriñaque', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 18403 AND p.composer_id = 307
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:4db346cb-523f-4502-bc29-66c51699052d'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 6, part.movement_number = NULL,
    part.name_ko = 'Mientras yo comía maullaba un gato', part.name_en = 'Siete danzas cubanas típicas: Mientras yo comía maullaba un gato',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 18403 AND p.composer_id = 307 AND part.part_key = 'musicbrainz:5ec51a86-10d4-4514-ad28-ec2e0e7889b5' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:5ec51a86-10d4-4514-ad28-ec2e0e7889b5', 6, NULL, 'Mientras yo comía maullaba un gato', 'Siete danzas cubanas típicas: Mientras yo comía maullaba un gato', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 18403 AND p.composer_id = 307
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:5ec51a86-10d4-4514-ad28-ec2e0e7889b5'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 7, part.movement_number = NULL,
    part.name_ko = 'Ni tú, ni yo', part.name_en = 'Siete danzas cubanas típicas: Ni tú, ni yo',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 18403 AND p.composer_id = 307 AND part.part_key = 'musicbrainz:61b8ce4b-2da7-45d7-bcc4-a3a441cf14c2' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:61b8ce4b-2da7-45d7-bcc4-a3a441cf14c2', 7, NULL, 'Ni tú, ni yo', 'Siete danzas cubanas típicas: Ni tú, ni yo', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 18403 AND p.composer_id = 307
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:61b8ce4b-2da7-45d7-bcc4-a3a441cf14c2'
);


-- None Soñaba contigo

UPDATE pieces piece
SET piece.title = 'Soñaba contigo', piece.title_en = 'Soñaba contigo',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 18432 AND piece.composer_id = 307
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Suite from El sombrero de Yarey

UPDATE pieces piece
SET piece.title = 'Suite from El sombrero de Yarey', piece.title_en = 'Suite from El sombrero de Yarey',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 17086 AND piece.composer_id = 307
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'Prelude. Allegro moderato', part.name_en = 'Suite from El sombrero de Yarey: Prelude. Allegro moderato',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 17086 AND p.composer_id = 307 AND part.part_key = 'musicbrainz:b6dbac75-8a60-4c4f-8fc1-d3fb881ee9e6' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:b6dbac75-8a60-4c4f-8fc1-d3fb881ee9e6', 1, NULL, 'Prelude. Allegro moderato', 'Suite from El sombrero de Yarey: Prelude. Allegro moderato', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 17086 AND p.composer_id = 307
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:b6dbac75-8a60-4c4f-8fc1-d3fb881ee9e6'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'Allegro non troppo - Allegro - Moderato', part.name_en = 'Suite from El sombrero de Yarey: Allegro non troppo - Allegro - Moderato',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 17086 AND p.composer_id = 307 AND part.part_key = 'musicbrainz:8c5672f2-470b-4c27-9216-acfd9dcdfa70' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:8c5672f2-470b-4c27-9216-acfd9dcdfa70', 2, NULL, 'Allegro non troppo - Allegro - Moderato', 'Suite from El sombrero de Yarey: Allegro non troppo - Allegro - Moderato', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 17086 AND p.composer_id = 307
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:8c5672f2-470b-4c27-9216-acfd9dcdfa70'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = NULL,
    part.name_ko = 'Allegretto', part.name_en = 'Suite from El sombrero de Yarey: Allegretto',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 17086 AND p.composer_id = 307 AND part.part_key = 'musicbrainz:3018ce42-e683-4c5e-b876-51bfce698fc3' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:3018ce42-e683-4c5e-b876-51bfce698fc3', 3, NULL, 'Allegretto', 'Suite from El sombrero de Yarey: Allegretto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 17086 AND p.composer_id = 307
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:3018ce42-e683-4c5e-b876-51bfce698fc3'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = NULL,
    part.name_ko = 'Moderato', part.name_en = 'Suite from El sombrero de Yarey: Moderato',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 17086 AND p.composer_id = 307 AND part.part_key = 'musicbrainz:880bdb6c-1eef-4b84-9779-a6783512dc38' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:880bdb6c-1eef-4b84-9779-a6783512dc38', 4, NULL, 'Moderato', 'Suite from El sombrero de Yarey: Moderato', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 17086 AND p.composer_id = 307
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:880bdb6c-1eef-4b84-9779-a6783512dc38'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 5, part.movement_number = NULL,
    part.name_ko = 'Danza. Allegro', part.name_en = 'Suite from El sombrero de Yarey: Danza. Allegro',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 17086 AND p.composer_id = 307 AND part.part_key = 'musicbrainz:354f49c6-522a-4697-817f-1b82d78ad8f7' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:354f49c6-522a-4697-817f-1b82d78ad8f7', 5, NULL, 'Danza. Allegro', 'Suite from El sombrero de Yarey: Danza. Allegro', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 17086 AND p.composer_id = 307
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:354f49c6-522a-4697-817f-1b82d78ad8f7'
);


-- None 가곡 <Tabou>

UPDATE pieces piece
SET piece.title = '가곡 <Tabou>', piece.title_en = 'Tabou',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 18519 AND piece.composer_id = 307
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None 가곡 <The Angels Came Through>

UPDATE pieces piece
SET piece.title = '가곡 <The Angels Came Through>', piece.title_en = 'The Angels Came Through',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 17597 AND piece.composer_id = 307
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None 가곡 <Tu no tienes corazón>

UPDATE pieces piece
SET piece.title = '가곡 <Tu no tienes corazón>', piece.title_en = 'Tu no tienes corazón',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 19628 AND piece.composer_id = 307
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None 가곡 <Un amor vendrá>

UPDATE pieces piece
SET piece.title = '가곡 <Un amor vendrá>', piece.title_en = 'Un amor vendrá',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 17547 AND piece.composer_id = 307
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Vals Gitano

UPDATE pieces piece
SET piece.title = 'Vals Gitano', piece.title_en = 'Vals Gitano',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 18386 AND piece.composer_id = 307
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Vals azul

UPDATE pieces piece
SET piece.title = 'Vals azul', piece.title_en = 'Vals azul',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 19887 AND piece.composer_id = 307
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Vals de Danubio

UPDATE pieces piece
SET piece.title = 'Vals de Danubio', piece.title_en = 'Vals de Danubio',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 17696 AND piece.composer_id = 307
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Vals de la Mariposa

UPDATE pieces piece
SET piece.title = 'Vals de la Mariposa', piece.title_en = 'Vals de la Mariposa',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 16716 AND piece.composer_id = 307
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Vals de los mares

UPDATE pieces piece
SET piece.title = 'Vals de los mares', piece.title_en = 'Vals de los mares',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 17199 AND piece.composer_id = 307
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Vals del Nilo

UPDATE pieces piece
SET piece.title = 'Vals del Nilo', piece.title_en = 'Vals del Nilo',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 18943 AND piece.composer_id = 307
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Vals del Sena

UPDATE pieces piece
SET piece.title = 'Vals del Sena', piece.title_en = 'Vals del Sena',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 17934 AND piece.composer_id = 307
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Valses fantásticos

UPDATE pieces piece
SET piece.title = 'Valses fantásticos', piece.title_en = 'Valses fantásticos',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 17781 AND piece.composer_id = 307
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'Vals apasionado', part.name_en = 'Valses fantásticos: Vals apasionado',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 17781 AND p.composer_id = 307 AND part.part_key = 'musicbrainz:10001c35-4a9b-41c8-8fef-7b03e6fc3d2f' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:10001c35-4a9b-41c8-8fef-7b03e6fc3d2f', 1, NULL, 'Vals apasionado', 'Valses fantásticos: Vals apasionado', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 17781 AND p.composer_id = 307
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:10001c35-4a9b-41c8-8fef-7b03e6fc3d2f'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'Vals poético', part.name_en = 'Valses fantásticos: Vals poético',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 17781 AND p.composer_id = 307 AND part.part_key = 'musicbrainz:2ef6b363-9f40-4398-9f05-73fd760a8d2a' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:2ef6b363-9f40-4398-9f05-73fd760a8d2a', 2, NULL, 'Vals poético', 'Valses fantásticos: Vals poético', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 17781 AND p.composer_id = 307
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:2ef6b363-9f40-4398-9f05-73fd760a8d2a'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = NULL,
    part.name_ko = 'Vals patético', part.name_en = 'Valses fantásticos: Vals patético',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 17781 AND p.composer_id = 307 AND part.part_key = 'musicbrainz:8565c404-3b65-4eb4-8bc2-398718d5b5d3' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:8565c404-3b65-4eb4-8bc2-398718d5b5d3', 3, NULL, 'Vals patético', 'Valses fantásticos: Vals patético', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 17781 AND p.composer_id = 307
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:8565c404-3b65-4eb4-8bc2-398718d5b5d3'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = NULL,
    part.name_ko = 'Vals maravilloso', part.name_en = 'Valses fantásticos: Vals maravilloso',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 17781 AND p.composer_id = 307 AND part.part_key = 'musicbrainz:d3311f4f-12d3-4ddd-8e54-6194671dd553' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:d3311f4f-12d3-4ddd-8e54-6194671dd553', 4, NULL, 'Vals maravilloso', 'Valses fantásticos: Vals maravilloso', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 17781 AND p.composer_id = 307
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:d3311f4f-12d3-4ddd-8e54-6194671dd553'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 5, part.movement_number = NULL,
    part.name_ko = 'Vals romántico', part.name_en = 'Valses fantásticos: Vals romántico',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 17781 AND p.composer_id = 307 AND part.part_key = 'musicbrainz:e1786ae5-0c2f-4856-a3ad-80769b74c81a' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:e1786ae5-0c2f-4856-a3ad-80769b74c81a', 5, NULL, 'Vals romántico', 'Valses fantásticos: Vals romántico', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 17781 AND p.composer_id = 307
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:e1786ae5-0c2f-4856-a3ad-80769b74c81a'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 6, part.movement_number = NULL,
    part.name_ko = 'Vals brillante', part.name_en = 'Valses fantásticos: Vals brillante',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 17781 AND p.composer_id = 307 AND part.part_key = 'musicbrainz:e8133d6c-4da1-4f8c-826d-73ad965d8bb5' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:e8133d6c-4da1-4f8c-826d-73ad965d8bb5', 6, NULL, 'Vals brillante', 'Valses fantásticos: Vals brillante', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 17781 AND p.composer_id = 307
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:e8133d6c-4da1-4f8c-826d-73ad965d8bb5'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 7, part.movement_number = NULL,
    part.name_ko = 'Vals arabesque', part.name_en = 'Valses fantásticos: Vals arabesque',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 17781 AND p.composer_id = 307 AND part.part_key = 'musicbrainz:f8941264-880d-41b3-a2d2-7fbbff5be23b' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:f8941264-880d-41b3-a2d2-7fbbff5be23b', 7, NULL, 'Vals arabesque', 'Valses fantásticos: Vals arabesque', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 17781 AND p.composer_id = 307
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:f8941264-880d-41b3-a2d2-7fbbff5be23b'
);


-- None Voilà

UPDATE pieces piece
SET piece.title = 'Voilà', piece.title_en = 'Voilà',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 16620 AND piece.composer_id = 307
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None 가곡 <Yo te quiero siempre>

UPDATE pieces piece
SET piece.title = '가곡 <Yo te quiero siempre>', piece.title_en = 'Yo te quiero siempre',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 18282 AND piece.composer_id = 307
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Zambra

UPDATE pieces piece
SET piece.title = 'Zambra', piece.title_en = 'Zambra',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 19577 AND piece.composer_id = 307
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Zambra gitana

UPDATE pieces piece
SET piece.title = 'Zambra gitana', piece.title_en = 'Zambra gitana',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 17931 AND piece.composer_id = 307
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None 가곡 <¡Mira! (from "La Habanera")>

UPDATE pieces piece
SET piece.title = '가곡 <¡Mira! (from "La Habanera")>', piece.title_en = '¡Mira! (from "La Habanera")',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 17439 AND piece.composer_id = 307
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None 가곡 <¡No es por ti!>

UPDATE pieces piece
SET piece.title = '가곡 <¡No es por ti!>', piece.title_en = '¡No es por ti!',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 16373 AND piece.composer_id = 307
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None ¡Échate pa' allá, María!

UPDATE pieces piece
SET piece.title = '¡Échate pa'' allá, María!', piece.title_en = '¡Échate pa'' allá, María!',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 17518 AND piece.composer_id = 307
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None ¿Por qué te vas?

UPDATE pieces piece
SET piece.title = '¿Por qué te vas?', piece.title_en = '¿Por qué te vas?',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 16186 AND piece.composer_id = 307
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None 가곡 <Dame de tus rosas>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '가곡 <Dame de tus rosas>', 'Dame de tus rosas', 'song', NULL, NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 307
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '가곡 <Dame de tus rosas>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'b850f3c8-e42e-4d3f-8c35-fd2ea21b6c57'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'b850f3c8-e42e-4d3f-8c35-fd2ea21b6c57'
FROM pieces p
WHERE p.composer_id = 307 AND p.title = '가곡 <Dame de tus rosas>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'b850f3c8-e42e-4d3f-8c35-fd2ea21b6c57'
);


-- None Futurista

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, 'Futurista', 'Futurista', 'song', NULL, NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 307
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = 'Futurista'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '282eb8be-f565-4717-8fd5-46483c806a3c'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '282eb8be-f565-4717-8fd5-46483c806a3c'
FROM pieces p
WHERE p.composer_id = 307 AND p.title = 'Futurista' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '282eb8be-f565-4717-8fd5-46483c806a3c'
);


-- None 가곡 <La comparsa>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '가곡 <La comparsa>', 'La comparsa', 'song', NULL, NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 307
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '가곡 <La comparsa>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '18f077ba-d54a-4293-9199-1c2377becb57'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '18f077ba-d54a-4293-9199-1c2377becb57'
FROM pieces p
WHERE p.composer_id = 307 AND p.title = '가곡 <La comparsa>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '18f077ba-d54a-4293-9199-1c2377becb57'
);


-- None 가곡 <Malaguena>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '가곡 <Malaguena>', 'Malaguena', 'song', NULL, NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 307
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '가곡 <Malaguena>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '721c0d67-6de9-4a9e-aa29-16714dabc801'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '721c0d67-6de9-4a9e-aa29-16714dabc801'
FROM pieces p
WHERE p.composer_id = 307 AND p.title = '가곡 <Malaguena>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '721c0d67-6de9-4a9e-aa29-16714dabc801'
);


-- None 가곡 <Maria la O>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '가곡 <Maria la O>', 'Maria la O', 'song', NULL, NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 307
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '가곡 <Maria la O>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'f0c6d3cc-5c42-484b-b537-be8999f3b373'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'f0c6d3cc-5c42-484b-b537-be8999f3b373'
FROM pieces p
WHERE p.composer_id = 307 AND p.title = '가곡 <Maria la O>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'f0c6d3cc-5c42-484b-b537-be8999f3b373'
);


-- 카탈로그에 대응이 없는 seed 작품 14개를 목록에서 숨긴다(지우지 않음).
UPDATE pieces piece
SET piece.hidden_reason = 'catalog_unmatched'
WHERE piece.composer_id = 307 AND piece.origin = 'seed' AND piece.hidden_reason IS NULL
  AND piece.id IN (
    15824, 15849, 15900, 15918, 16199, 16393, 16618, 17038, 17079, 17235, 17287, 17576, 17890, 18587
  )
  AND NOT EXISTS (SELECT 1 FROM performance_sectors sector WHERE sector.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM piece_parts linking WHERE linking.linked_piece_id = piece.id);
