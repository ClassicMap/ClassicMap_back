-- 프랑수아 쿠프랭 작품을 MusicBrainz 작품 구조로 다시 짠다(4차 자동). 작품 60개(묶음 8, 다악장 11, 낱곡 41),
-- 새 작품 4개, part 106개, 그 아래 190개.
-- seed 104개 중 56개를 작품·part 에 잇고, 8개를 숨기고, 40개는 그대로 둔다.
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

-- None 1re Suite de viole en mi mineur

UPDATE pieces piece
SET piece.title = '1re Suite de viole en mi mineur', piece.title_en = '1re Suite de viole en mi mineur',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 24592 AND piece.composer_id = 431
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'Prélude', part.name_en = '1re Suite de viole en mi mineur: I. Prélude',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 24592 AND p.composer_id = 431 AND part.part_key = 'musicbrainz:a843d6ad-e2cb-453d-a928-3ff1c862a361' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:a843d6ad-e2cb-453d-a928-3ff1c862a361', 1, 'I', 'Prélude', '1re Suite de viole en mi mineur: I. Prélude', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 24592 AND p.composer_id = 431
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:a843d6ad-e2cb-453d-a928-3ff1c862a361'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'Allemande Légère', part.name_en = '1re Suite de viole en mi mineur: II. Allemande Légère',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 24592 AND p.composer_id = 431 AND part.part_key = 'musicbrainz:191a8727-2896-4104-a468-41bfc88b0a6f' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:191a8727-2896-4104-a468-41bfc88b0a6f', 2, 'II', 'Allemande Légère', '1re Suite de viole en mi mineur: II. Allemande Légère', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 24592 AND p.composer_id = 431
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:191a8727-2896-4104-a468-41bfc88b0a6f'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = 'Courante', part.name_en = '1re Suite de viole en mi mineur: III. Courante',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 24592 AND p.composer_id = 431 AND part.part_key = 'musicbrainz:5c2c7ecf-c820-4376-9c45-48058a4cb92b' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:5c2c7ecf-c820-4376-9c45-48058a4cb92b', 3, 'III', 'Courante', '1re Suite de viole en mi mineur: III. Courante', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 24592 AND p.composer_id = 431
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:5c2c7ecf-c820-4376-9c45-48058a4cb92b'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = 'IV',
    part.name_ko = 'Sarabande grave', part.name_en = '1re Suite de viole en mi mineur: IV. Sarabande grave',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 24592 AND p.composer_id = 431 AND part.part_key = 'musicbrainz:afab922c-5d48-48eb-b61c-47d2614239e8' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:afab922c-5d48-48eb-b61c-47d2614239e8', 4, 'IV', 'Sarabande grave', '1re Suite de viole en mi mineur: IV. Sarabande grave', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 24592 AND p.composer_id = 431
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:afab922c-5d48-48eb-b61c-47d2614239e8'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 5, part.movement_number = 'V',
    part.name_ko = 'Gavotte', part.name_en = '1re Suite de viole en mi mineur: V. Gavotte',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 24592 AND p.composer_id = 431 AND part.part_key = 'musicbrainz:02d257d6-a8e2-4592-bea8-b7e0daaff253' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:02d257d6-a8e2-4592-bea8-b7e0daaff253', 5, 'V', 'Gavotte', '1re Suite de viole en mi mineur: V. Gavotte', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 24592 AND p.composer_id = 431
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:02d257d6-a8e2-4592-bea8-b7e0daaff253'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 6, part.movement_number = 'VI',
    part.name_ko = 'Gigue', part.name_en = '1re Suite de viole en mi mineur: VI. Gigue',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 24592 AND p.composer_id = 431 AND part.part_key = 'musicbrainz:56aaffca-c396-4c34-a30a-37d85d470626' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:56aaffca-c396-4c34-a30a-37d85d470626', 6, 'VI', 'Gigue', '1re Suite de viole en mi mineur: VI. Gigue', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 24592 AND p.composer_id = 431
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:56aaffca-c396-4c34-a30a-37d85d470626'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 7, part.movement_number = 'VII',
    part.name_ko = 'Passacaille ou Chaconne', part.name_en = '1re Suite de viole en mi mineur: VII. Passacaille ou Chaconne',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 24592 AND p.composer_id = 431 AND part.part_key = 'musicbrainz:16e533e4-25f4-460c-92b9-f6c39307f36a' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:16e533e4-25f4-460c-92b9-f6c39307f36a', 7, 'VII', 'Passacaille ou Chaconne', '1re Suite de viole en mi mineur: VII. Passacaille ou Chaconne', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 24592 AND p.composer_id = 431
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:16e533e4-25f4-460c-92b9-f6c39307f36a'
);


-- None 2e Suite de viole en la majeur

UPDATE pieces piece
SET piece.title = '2e Suite de viole en la majeur', piece.title_en = '2e Suite de viole en la majeur',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 23802 AND piece.composer_id = 431
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'Prélude', part.name_en = '2e Suite de viole en la majeur: I. Prélude',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 23802 AND p.composer_id = 431 AND part.part_key = 'musicbrainz:5129dcee-4056-4207-bfad-7ea192dc0bbc' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:5129dcee-4056-4207-bfad-7ea192dc0bbc', 1, 'I', 'Prélude', '2e Suite de viole en la majeur: I. Prélude', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 23802 AND p.composer_id = 431
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:5129dcee-4056-4207-bfad-7ea192dc0bbc'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'Fuguète', part.name_en = '2e Suite de viole en la majeur: II. Fuguète',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 23802 AND p.composer_id = 431 AND part.part_key = 'musicbrainz:e9f8b512-6f72-4c28-a6e5-8f0d79813397' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:e9f8b512-6f72-4c28-a6e5-8f0d79813397', 2, 'II', 'Fuguète', '2e Suite de viole en la majeur: II. Fuguète', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 23802 AND p.composer_id = 431
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:e9f8b512-6f72-4c28-a6e5-8f0d79813397'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = 'Pompe funèbre', part.name_en = '2e Suite de viole en la majeur: III. Pompe funèbre',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 23802 AND p.composer_id = 431 AND part.part_key = 'musicbrainz:9bf1ddf5-80dd-43ca-95f5-7d761169c71e' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:9bf1ddf5-80dd-43ca-95f5-7d761169c71e', 3, 'III', 'Pompe funèbre', '2e Suite de viole en la majeur: III. Pompe funèbre', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 23802 AND p.composer_id = 431
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:9bf1ddf5-80dd-43ca-95f5-7d761169c71e'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = 'IV',
    part.name_ko = 'La Chemise-blanche', part.name_en = '2e Suite de viole en la majeur: IV. La Chemise-blanche',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 23802 AND p.composer_id = 431 AND part.part_key = 'musicbrainz:7efbfabb-6f41-4813-9e8f-319f64c879b3' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:7efbfabb-6f41-4813-9e8f-319f64c879b3', 4, 'IV', 'La Chemise-blanche', '2e Suite de viole en la majeur: IV. La Chemise-blanche', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 23802 AND p.composer_id = 431
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:7efbfabb-6f41-4813-9e8f-319f64c879b3'
);


-- None 모테트 <Ad te levavi oculos meos>

UPDATE pieces piece
SET piece.title = '모테트 <Ad te levavi oculos meos>', piece.title_en = 'Ad te levavi oculos meos',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 25573 AND piece.composer_id = 431
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Allemande 'L'Auguste'

UPDATE pieces piece
SET piece.title = 'Allemande ''L''Auguste''', piece.title_en = 'Allemande ''L''Auguste''',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 25096 AND piece.composer_id = 431
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Ariane consolée par Bacchus

UPDATE pieces piece
SET piece.title = 'Ariane consolée par Bacchus', piece.title_en = 'Ariane consolée par Bacchus',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 24233 AND piece.composer_id = 431
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'II',
    part.name_ko = 'Air ''Amour, vante cette fois''', part.name_en = 'Ariane consolée par Bacchus: II. Air ''Amour, vante cette fois''',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 24233 AND p.composer_id = 431 AND part.part_key = 'musicbrainz:4b5912d1-9079-4cc7-a59a-51433a77429a' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:4b5912d1-9079-4cc7-a59a-51433a77429a', 1, 'II', 'Air ''Amour, vante cette fois''', 'Ariane consolée par Bacchus: II. Air ''Amour, vante cette fois''', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 24233 AND p.composer_id = 431
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:4b5912d1-9079-4cc7-a59a-51433a77429a'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'III',
    part.name_ko = 'Récitatif ''Ariane en cette langueur''', part.name_en = 'Ariane consolée par Bacchus: III. Récitatif ''Ariane en cette langueur''',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 24233 AND p.composer_id = 431 AND part.part_key = 'musicbrainz:9b51b3b4-aea1-4dfc-a3f9-3003553f31a2' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:9b51b3b4-aea1-4dfc-a3f9-3003553f31a2', 2, 'III', 'Récitatif ''Ariane en cette langueur''', 'Ariane consolée par Bacchus: III. Récitatif ''Ariane en cette langueur''', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 24233 AND p.composer_id = 431
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:9b51b3b4-aea1-4dfc-a3f9-3003553f31a2'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'VI',
    part.name_ko = 'Air ''Chantons sans fin''', part.name_en = 'Ariane consolée par Bacchus: VI. Air ''Chantons sans fin''',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 24233 AND p.composer_id = 431 AND part.part_key = 'musicbrainz:9c45a29c-a951-4c7f-b213-c5a1b9fdb19a' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:9c45a29c-a951-4c7f-b213-c5a1b9fdb19a', 3, 'VI', 'Air ''Chantons sans fin''', 'Ariane consolée par Bacchus: VI. Air ''Chantons sans fin''', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 24233 AND p.composer_id = 431
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:9c45a29c-a951-4c7f-b213-c5a1b9fdb19a'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = 'V',
    part.name_ko = 'Récitatif ''Tandis qu''il parle ainsi, la princesse en soi-même''', part.name_en = 'Ariane consolée par Bacchus: V. Récitatif ''Tandis qu''il parle ainsi, la princesse en soi-même''',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 24233 AND p.composer_id = 431 AND part.part_key = 'musicbrainz:c1eeb36f-8f46-4a4e-b82f-9d8f9ae6ddd0' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:c1eeb36f-8f46-4a4e-b82f-9d8f9ae6ddd0', 4, 'V', 'Récitatif ''Tandis qu''il parle ainsi, la princesse en soi-même''', 'Ariane consolée par Bacchus: V. Récitatif ''Tandis qu''il parle ainsi, la princesse en soi-même''', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 24233 AND p.composer_id = 431
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:c1eeb36f-8f46-4a4e-b82f-9d8f9ae6ddd0'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 5, part.movement_number = 'IV',
    part.name_ko = 'Air ''Pouvez-vous pleurer un barbare ?''', part.name_en = 'Ariane consolée par Bacchus: IV. Air ''Pouvez-vous pleurer un barbare ?''',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 24233 AND p.composer_id = 431 AND part.part_key = 'musicbrainz:da6c943a-92eb-45d1-9bc4-027bda4da09d' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:da6c943a-92eb-45d1-9bc4-027bda4da09d', 5, 'IV', 'Air ''Pouvez-vous pleurer un barbare ?''', 'Ariane consolée par Bacchus: IV. Air ''Pouvez-vous pleurer un barbare ?''', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 24233 AND p.composer_id = 431
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:da6c943a-92eb-45d1-9bc4-027bda4da09d'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 6, part.movement_number = 'I',
    part.name_ko = 'Récitatif ''Sur les bords d''une île sauvage''', part.name_en = 'Ariane consolée par Bacchus: I. Récitatif ''Sur les bords d''une île sauvage''',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 24233 AND p.composer_id = 431 AND part.part_key = 'musicbrainz:ea28cb6d-3722-474c-ba89-60165c7bf632' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:ea28cb6d-3722-474c-ba89-60165c7bf632', 6, 'I', 'Récitatif ''Sur les bords d''une île sauvage''', 'Ariane consolée par Bacchus: I. Récitatif ''Sur les bords d''une île sauvage''', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 24233 AND p.composer_id = 431
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:ea28cb6d-3722-474c-ba89-60165c7bf632'
);


-- None Audite omnes et expavescite

UPDATE pieces piece
SET piece.title = 'Audite omnes et expavescite', piece.title_en = 'Audite omnes et expavescite',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 23211 AND piece.composer_id = 431
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Chaconne En Rondeau 'La Favourite'

UPDATE pieces piece
SET piece.title = 'Chaconne En Rondeau ''La Favourite''', piece.title_en = 'Chaconne En Rondeau ''La Favourite''',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 25969 AND piece.composer_id = 431
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Concerts Royaux

UPDATE pieces piece
SET piece.title = 'Concerts Royaux', piece.title_en = 'Concerts Royaux',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 25718 AND piece.composer_id = 431
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'Premier concert', part.name_en = 'Concerts Royaux, Premier concert',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 25718 AND p.composer_id = 431 AND part.part_key = 'musicbrainz:e5d53700-d304-4c0f-9de1-6cbf00028daa' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:e5d53700-d304-4c0f-9de1-6cbf00028daa', 1, NULL, 'Premier concert', 'Concerts Royaux, Premier concert', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 25718 AND p.composer_id = 431
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:e5d53700-d304-4c0f-9de1-6cbf00028daa'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:e5d53700-d304-4c0f-9de1-6cbf00028daa'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'Prélude', part.name_en = 'Concerts Royaux, Premier concert: Prélude',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 25718 AND p.composer_id = 431 AND part.part_key = 'musicbrainz:6fb88d73-23a5-4d34-96c2-dd833e10211c' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:6fb88d73-23a5-4d34-96c2-dd833e10211c', 1, NULL, 'Prélude', 'Concerts Royaux, Premier concert: Prélude', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:e5d53700-d304-4c0f-9de1-6cbf00028daa'
WHERE p.id = 25718 AND p.composer_id = 431
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:6fb88d73-23a5-4d34-96c2-dd833e10211c'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:e5d53700-d304-4c0f-9de1-6cbf00028daa'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'Allemande', part.name_en = 'Concerts Royaux, Premier concert: Allemande',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 25718 AND p.composer_id = 431 AND part.part_key = 'musicbrainz:8ee9d9ed-a869-443a-bb31-df42bce7980f' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:8ee9d9ed-a869-443a-bb31-df42bce7980f', 2, NULL, 'Allemande', 'Concerts Royaux, Premier concert: Allemande', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:e5d53700-d304-4c0f-9de1-6cbf00028daa'
WHERE p.id = 25718 AND p.composer_id = 431
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:8ee9d9ed-a869-443a-bb31-df42bce7980f'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:e5d53700-d304-4c0f-9de1-6cbf00028daa'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = NULL,
    part.name_ko = 'Sarabande', part.name_en = 'Concerts Royaux, Premier concert: Sarabande',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 25718 AND p.composer_id = 431 AND part.part_key = 'musicbrainz:05272192-62fe-4a8d-a35c-26bf879e5413' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:05272192-62fe-4a8d-a35c-26bf879e5413', 3, NULL, 'Sarabande', 'Concerts Royaux, Premier concert: Sarabande', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:e5d53700-d304-4c0f-9de1-6cbf00028daa'
WHERE p.id = 25718 AND p.composer_id = 431
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:05272192-62fe-4a8d-a35c-26bf879e5413'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:e5d53700-d304-4c0f-9de1-6cbf00028daa'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = NULL,
    part.name_ko = 'Gavotte', part.name_en = 'Concerts Royaux, Premier concert: Gavotte',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 25718 AND p.composer_id = 431 AND part.part_key = 'musicbrainz:ad63bad7-7332-4fbb-a857-0209b08a006d' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:ad63bad7-7332-4fbb-a857-0209b08a006d', 4, NULL, 'Gavotte', 'Concerts Royaux, Premier concert: Gavotte', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:e5d53700-d304-4c0f-9de1-6cbf00028daa'
WHERE p.id = 25718 AND p.composer_id = 431
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:ad63bad7-7332-4fbb-a857-0209b08a006d'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:e5d53700-d304-4c0f-9de1-6cbf00028daa'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 5, part.movement_number = NULL,
    part.name_ko = 'Gigue', part.name_en = 'Concerts Royaux, Premier concert: Gigue',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 25718 AND p.composer_id = 431 AND part.part_key = 'musicbrainz:a15290de-b091-41bd-b1a7-ec38adf8d9f9' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:a15290de-b091-41bd-b1a7-ec38adf8d9f9', 5, NULL, 'Gigue', 'Concerts Royaux, Premier concert: Gigue', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:e5d53700-d304-4c0f-9de1-6cbf00028daa'
WHERE p.id = 25718 AND p.composer_id = 431
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:a15290de-b091-41bd-b1a7-ec38adf8d9f9'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:e5d53700-d304-4c0f-9de1-6cbf00028daa'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 6, part.movement_number = NULL,
    part.name_ko = 'Menuet en trio', part.name_en = 'Concerts Royaux, Premier concert: Menuet en trio',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 25718 AND p.composer_id = 431 AND part.part_key = 'musicbrainz:a9204ba5-ea41-4786-8822-711caac0b4cc' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:a9204ba5-ea41-4786-8822-711caac0b4cc', 6, NULL, 'Menuet en trio', 'Concerts Royaux, Premier concert: Menuet en trio', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:e5d53700-d304-4c0f-9de1-6cbf00028daa'
WHERE p.id = 25718 AND p.composer_id = 431
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:a9204ba5-ea41-4786-8822-711caac0b4cc'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'Deuxième concert', part.name_en = 'Concerts Royaux, Deuxième concert',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 25718 AND p.composer_id = 431 AND part.part_key = 'musicbrainz:dc6aaa8d-7f9b-46e6-b458-390373f86828' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:dc6aaa8d-7f9b-46e6-b458-390373f86828', 2, NULL, 'Deuxième concert', 'Concerts Royaux, Deuxième concert', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 25718 AND p.composer_id = 431
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:dc6aaa8d-7f9b-46e6-b458-390373f86828'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:dc6aaa8d-7f9b-46e6-b458-390373f86828'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'Prélude', part.name_en = 'Concerts Royaux, Deuxième concert: Prélude',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 25718 AND p.composer_id = 431 AND part.part_key = 'musicbrainz:5505d079-4c46-4fdf-a76d-5c370ffb356c' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:5505d079-4c46-4fdf-a76d-5c370ffb356c', 1, NULL, 'Prélude', 'Concerts Royaux, Deuxième concert: Prélude', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:dc6aaa8d-7f9b-46e6-b458-390373f86828'
WHERE p.id = 25718 AND p.composer_id = 431
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:5505d079-4c46-4fdf-a76d-5c370ffb356c'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:dc6aaa8d-7f9b-46e6-b458-390373f86828'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'Allemande fuguée', part.name_en = 'Concerts Royaux, Deuxième concert: Allemande fuguée',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 25718 AND p.composer_id = 431 AND part.part_key = 'musicbrainz:d596e81d-9e27-4679-92cd-ab4fecc4ba70' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:d596e81d-9e27-4679-92cd-ab4fecc4ba70', 2, NULL, 'Allemande fuguée', 'Concerts Royaux, Deuxième concert: Allemande fuguée', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:dc6aaa8d-7f9b-46e6-b458-390373f86828'
WHERE p.id = 25718 AND p.composer_id = 431
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:d596e81d-9e27-4679-92cd-ab4fecc4ba70'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:dc6aaa8d-7f9b-46e6-b458-390373f86828'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = NULL,
    part.name_ko = 'Air tendre', part.name_en = 'Concerts Royaux, Deuxième concert: Air tendre',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 25718 AND p.composer_id = 431 AND part.part_key = 'musicbrainz:ea7cb18a-d661-42fc-b3f9-8a360e919bce' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:ea7cb18a-d661-42fc-b3f9-8a360e919bce', 3, NULL, 'Air tendre', 'Concerts Royaux, Deuxième concert: Air tendre', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:dc6aaa8d-7f9b-46e6-b458-390373f86828'
WHERE p.id = 25718 AND p.composer_id = 431
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:ea7cb18a-d661-42fc-b3f9-8a360e919bce'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:dc6aaa8d-7f9b-46e6-b458-390373f86828'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = NULL,
    part.name_ko = 'Air contrefugué', part.name_en = 'Concerts Royaux, Deuxième concert: Air contrefugué',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 25718 AND p.composer_id = 431 AND part.part_key = 'musicbrainz:fe383fd3-2be4-47f0-8772-72b946ca73e6' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:fe383fd3-2be4-47f0-8772-72b946ca73e6', 4, NULL, 'Air contrefugué', 'Concerts Royaux, Deuxième concert: Air contrefugué', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:dc6aaa8d-7f9b-46e6-b458-390373f86828'
WHERE p.id = 25718 AND p.composer_id = 431
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:fe383fd3-2be4-47f0-8772-72b946ca73e6'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:dc6aaa8d-7f9b-46e6-b458-390373f86828'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 5, part.movement_number = NULL,
    part.name_ko = 'Echos', part.name_en = 'Concerts Royaux, Deuxième concert: Echos',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 25718 AND p.composer_id = 431 AND part.part_key = 'musicbrainz:702f846a-51f4-4778-8cc3-7ebd1764f26e' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:702f846a-51f4-4778-8cc3-7ebd1764f26e', 5, NULL, 'Echos', 'Concerts Royaux, Deuxième concert: Echos', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:dc6aaa8d-7f9b-46e6-b458-390373f86828'
WHERE p.id = 25718 AND p.composer_id = 431
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:702f846a-51f4-4778-8cc3-7ebd1764f26e'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = NULL,
    part.name_ko = 'Troisième concert', part.name_en = 'Concerts Royaux, Troisième concert',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 25718 AND p.composer_id = 431 AND part.part_key = 'musicbrainz:32695f4a-5dca-4321-93ce-96cf94c1c487' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:32695f4a-5dca-4321-93ce-96cf94c1c487', 3, NULL, 'Troisième concert', 'Concerts Royaux, Troisième concert', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 25718 AND p.composer_id = 431
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:32695f4a-5dca-4321-93ce-96cf94c1c487'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:32695f4a-5dca-4321-93ce-96cf94c1c487'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'Prélude', part.name_en = 'Concerts Royaux, Troisième concert: Prélude',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 25718 AND p.composer_id = 431 AND part.part_key = 'musicbrainz:f6c1d286-ad2e-44fb-9f37-b72bde9b5d8e' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:f6c1d286-ad2e-44fb-9f37-b72bde9b5d8e', 1, NULL, 'Prélude', 'Concerts Royaux, Troisième concert: Prélude', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:32695f4a-5dca-4321-93ce-96cf94c1c487'
WHERE p.id = 25718 AND p.composer_id = 431
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:f6c1d286-ad2e-44fb-9f37-b72bde9b5d8e'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:32695f4a-5dca-4321-93ce-96cf94c1c487'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'Allemande', part.name_en = 'Concerts Royaux, Troisième concert: Allemande',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 25718 AND p.composer_id = 431 AND part.part_key = 'musicbrainz:3b8fb5d4-a469-4b03-9dd8-ee1a13071311' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:3b8fb5d4-a469-4b03-9dd8-ee1a13071311', 2, NULL, 'Allemande', 'Concerts Royaux, Troisième concert: Allemande', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:32695f4a-5dca-4321-93ce-96cf94c1c487'
WHERE p.id = 25718 AND p.composer_id = 431
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:3b8fb5d4-a469-4b03-9dd8-ee1a13071311'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:32695f4a-5dca-4321-93ce-96cf94c1c487'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = NULL,
    part.name_ko = 'Courante', part.name_en = 'Concerts Royaux, Troisième concert: Courante',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 25718 AND p.composer_id = 431 AND part.part_key = 'musicbrainz:61706d28-c008-401c-be32-ca3e99103fb9' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:61706d28-c008-401c-be32-ca3e99103fb9', 3, NULL, 'Courante', 'Concerts Royaux, Troisième concert: Courante', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:32695f4a-5dca-4321-93ce-96cf94c1c487'
WHERE p.id = 25718 AND p.composer_id = 431
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:61706d28-c008-401c-be32-ca3e99103fb9'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:32695f4a-5dca-4321-93ce-96cf94c1c487'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = NULL,
    part.name_ko = 'Sarabande grave', part.name_en = 'Concerts Royaux, Troisième concert: Sarabande grave',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 25718 AND p.composer_id = 431 AND part.part_key = 'musicbrainz:2d987b48-6582-4689-abd2-788364e7ec63' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:2d987b48-6582-4689-abd2-788364e7ec63', 4, NULL, 'Sarabande grave', 'Concerts Royaux, Troisième concert: Sarabande grave', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:32695f4a-5dca-4321-93ce-96cf94c1c487'
WHERE p.id = 25718 AND p.composer_id = 431
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:2d987b48-6582-4689-abd2-788364e7ec63'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:32695f4a-5dca-4321-93ce-96cf94c1c487'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 5, part.movement_number = NULL,
    part.name_ko = 'Gavotte', part.name_en = 'Concerts Royaux, Troisième concert: Gavotte',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 25718 AND p.composer_id = 431 AND part.part_key = 'musicbrainz:4c65b6a1-953a-42e7-adfd-42eaae0f6438' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:4c65b6a1-953a-42e7-adfd-42eaae0f6438', 5, NULL, 'Gavotte', 'Concerts Royaux, Troisième concert: Gavotte', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:32695f4a-5dca-4321-93ce-96cf94c1c487'
WHERE p.id = 25718 AND p.composer_id = 431
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:4c65b6a1-953a-42e7-adfd-42eaae0f6438'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:32695f4a-5dca-4321-93ce-96cf94c1c487'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 6, part.movement_number = NULL,
    part.name_ko = 'Muzette', part.name_en = 'Concerts Royaux, Troisième concert: Muzette',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 25718 AND p.composer_id = 431 AND part.part_key = 'musicbrainz:d1bc1b23-8886-44e4-88d7-65c48f76fba7' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:d1bc1b23-8886-44e4-88d7-65c48f76fba7', 6, NULL, 'Muzette', 'Concerts Royaux, Troisième concert: Muzette', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:32695f4a-5dca-4321-93ce-96cf94c1c487'
WHERE p.id = 25718 AND p.composer_id = 431
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:d1bc1b23-8886-44e4-88d7-65c48f76fba7'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:32695f4a-5dca-4321-93ce-96cf94c1c487'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 7, part.movement_number = NULL,
    part.name_ko = 'Chaconne légère', part.name_en = 'Concerts Royaux, Troisième concert: Chaconne légère',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 25718 AND p.composer_id = 431 AND part.part_key = 'musicbrainz:750b977d-309d-41b8-8c11-1c7ef8d3aa0f' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:750b977d-309d-41b8-8c11-1c7ef8d3aa0f', 7, NULL, 'Chaconne légère', 'Concerts Royaux, Troisième concert: Chaconne légère', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:32695f4a-5dca-4321-93ce-96cf94c1c487'
WHERE p.id = 25718 AND p.composer_id = 431
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:750b977d-309d-41b8-8c11-1c7ef8d3aa0f'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = NULL,
    part.name_ko = 'Quatrième concert', part.name_en = 'Concerts Royaux, Quatrième concert',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 25718 AND p.composer_id = 431 AND part.part_key = 'musicbrainz:dcd38795-cdc0-4d71-9b25-6f0dd32e549a' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:dcd38795-cdc0-4d71-9b25-6f0dd32e549a', 4, NULL, 'Quatrième concert', 'Concerts Royaux, Quatrième concert', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 25718 AND p.composer_id = 431
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:dcd38795-cdc0-4d71-9b25-6f0dd32e549a'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:dcd38795-cdc0-4d71-9b25-6f0dd32e549a'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'Prélude', part.name_en = 'Concerts Royaux, Quatrième concert: Prélude',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 25718 AND p.composer_id = 431 AND part.part_key = 'musicbrainz:d1465b84-ef2f-444b-a121-2ab7bcd32309' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:d1465b84-ef2f-444b-a121-2ab7bcd32309', 1, NULL, 'Prélude', 'Concerts Royaux, Quatrième concert: Prélude', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:dcd38795-cdc0-4d71-9b25-6f0dd32e549a'
WHERE p.id = 25718 AND p.composer_id = 431
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:d1465b84-ef2f-444b-a121-2ab7bcd32309'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:dcd38795-cdc0-4d71-9b25-6f0dd32e549a'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'Allemande', part.name_en = 'Concerts Royaux, Quatrième concert: Allemande',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 25718 AND p.composer_id = 431 AND part.part_key = 'musicbrainz:32c6ab66-3c6f-450b-a876-60f8e6a497df' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:32c6ab66-3c6f-450b-a876-60f8e6a497df', 2, NULL, 'Allemande', 'Concerts Royaux, Quatrième concert: Allemande', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:dcd38795-cdc0-4d71-9b25-6f0dd32e549a'
WHERE p.id = 25718 AND p.composer_id = 431
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:32c6ab66-3c6f-450b-a876-60f8e6a497df'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:dcd38795-cdc0-4d71-9b25-6f0dd32e549a'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = NULL,
    part.name_ko = 'Courante françoise', part.name_en = 'Concerts Royaux, Quatrième concert: Courante françoise',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 25718 AND p.composer_id = 431 AND part.part_key = 'musicbrainz:98e14edc-7ef9-41a7-bec4-178827310350' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:98e14edc-7ef9-41a7-bec4-178827310350', 3, NULL, 'Courante françoise', 'Concerts Royaux, Quatrième concert: Courante françoise', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:dcd38795-cdc0-4d71-9b25-6f0dd32e549a'
WHERE p.id = 25718 AND p.composer_id = 431
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:98e14edc-7ef9-41a7-bec4-178827310350'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:dcd38795-cdc0-4d71-9b25-6f0dd32e549a'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = NULL,
    part.name_ko = 'Courante à l''italiéne', part.name_en = 'Concerts Royaux, Quatrième concert: Courante à l''italiéne',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 25718 AND p.composer_id = 431 AND part.part_key = 'musicbrainz:92be2b4d-3836-4e89-86ff-caf2502af95b' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:92be2b4d-3836-4e89-86ff-caf2502af95b', 4, NULL, 'Courante à l''italiéne', 'Concerts Royaux, Quatrième concert: Courante à l''italiéne', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:dcd38795-cdc0-4d71-9b25-6f0dd32e549a'
WHERE p.id = 25718 AND p.composer_id = 431
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:92be2b4d-3836-4e89-86ff-caf2502af95b'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:dcd38795-cdc0-4d71-9b25-6f0dd32e549a'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 5, part.movement_number = NULL,
    part.name_ko = 'Sarabande', part.name_en = 'Concerts Royaux, Quatrième concert: Sarabande',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 25718 AND p.composer_id = 431 AND part.part_key = 'musicbrainz:28b994e8-31e1-4e3f-8eba-050fb714abdb' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:28b994e8-31e1-4e3f-8eba-050fb714abdb', 5, NULL, 'Sarabande', 'Concerts Royaux, Quatrième concert: Sarabande', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:dcd38795-cdc0-4d71-9b25-6f0dd32e549a'
WHERE p.id = 25718 AND p.composer_id = 431
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:28b994e8-31e1-4e3f-8eba-050fb714abdb'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:dcd38795-cdc0-4d71-9b25-6f0dd32e549a'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 6, part.movement_number = NULL,
    part.name_ko = 'Rigaudon', part.name_en = 'Concerts Royaux, Quatrième concert: Rigaudon',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 25718 AND p.composer_id = 431 AND part.part_key = 'musicbrainz:f7c31256-3ac7-4b5e-a5cc-678ea052463b' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:f7c31256-3ac7-4b5e-a5cc-678ea052463b', 6, NULL, 'Rigaudon', 'Concerts Royaux, Quatrième concert: Rigaudon', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:dcd38795-cdc0-4d71-9b25-6f0dd32e549a'
WHERE p.id = 25718 AND p.composer_id = 431
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:f7c31256-3ac7-4b5e-a5cc-678ea052463b'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:dcd38795-cdc0-4d71-9b25-6f0dd32e549a'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 7, part.movement_number = NULL,
    part.name_ko = 'Forlane', part.name_en = 'Concerts Royaux, Quatrième concert: Forlane',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 25718 AND p.composer_id = 431 AND part.part_key = 'musicbrainz:45a23d35-cd72-4ddf-bd75-fd95f0dd9766' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:45a23d35-cd72-4ddf-bd75-fd95f0dd9766', 7, NULL, 'Forlane', 'Concerts Royaux, Quatrième concert: Forlane', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:dcd38795-cdc0-4d71-9b25-6f0dd32e549a'
WHERE p.id = 25718 AND p.composer_id = 431
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:45a23d35-cd72-4ddf-bd75-fd95f0dd9766'
);


-- None Dialogus inter Jesum et hominem

UPDATE pieces piece
SET piece.title = 'Dialogus inter Jesum et hominem', piece.title_en = 'Dialogus inter Jesum et hominem',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 25873 AND piece.composer_id = 431
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None 모테트 <Domine salvum fac regem>

UPDATE pieces piece
SET piece.title = '모테트 <Domine salvum fac regem>', piece.title_en = 'Domine salvum fac regem',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 23827 AND piece.composer_id = 431
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None 아리아 <Doux liens de mon cœur>

UPDATE pieces piece
SET piece.title = '아리아 <Doux liens de mon cœur>', piece.title_en = 'Doux liens de mon cœur',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 25471 AND piece.composer_id = 431
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None 모테트 <Exultent superi, "Motet for Ste Suzanne">

UPDATE pieces piece
SET piece.title = '모테트 <Exultent superi, "Motet for Ste Suzanne">', piece.title_en = 'Exultent superi, "Motet for Ste Suzanne"',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 25788 AND piece.composer_id = 431
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None 가보트

UPDATE pieces piece
SET piece.title = '가보트', piece.title_en = 'Gavotte',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 24822 AND piece.composer_id = 431
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Gigue 'La Milordine'

UPDATE pieces piece
SET piece.title = 'Gigue ''La Milordine''', piece.title_en = 'Gigue ''La Milordine''',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 25916 AND piece.composer_id = 431
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None 모테트 <Jucunda vox Ecclesiae>

UPDATE pieces piece
SET piece.title = '모테트 <Jucunda vox Ecclesiae>', piece.title_en = 'Jucunda vox Ecclesiae',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 23749 AND piece.composer_id = 431
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None L'Apothéose de Lully

UPDATE pieces piece
SET piece.title = 'L''Apothéose de Lully', piece.title_en = 'L''Apothéose de Lully',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 23851 AND piece.composer_id = 431
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'Lully aux Champs Elysés... Gravement', part.name_en = 'Concert instrumental sur le titre d''Apotheose : I. Lully aux Champs Elysés... Gravement',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 23851 AND p.composer_id = 431 AND part.part_key = 'musicbrainz:a68ee05a-f6bf-4565-b8b4-846345118ef6' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:a68ee05a-f6bf-4565-b8b4-846345118ef6', 1, 'I', 'Lully aux Champs Elysés... Gravement', 'Concert instrumental sur le titre d''Apotheose : I. Lully aux Champs Elysés... Gravement', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 23851 AND p.composer_id = 431
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:a68ee05a-f6bf-4565-b8b4-846345118ef6'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'Air pour les mêmes; Gracieusement', part.name_en = 'Concert instrumental sur le titre d''Apotheose : II. Air pour les mêmes; Gracieusement',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 23851 AND p.composer_id = 431 AND part.part_key = 'musicbrainz:7cbd3ba3-16be-4b3d-b39f-3dfe44fc6990' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:7cbd3ba3-16be-4b3d-b39f-3dfe44fc6990', 2, 'II', 'Air pour les mêmes; Gracieusement', 'Concert instrumental sur le titre d''Apotheose : II. Air pour les mêmes; Gracieusement', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 23851 AND p.composer_id = 431
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:7cbd3ba3-16be-4b3d-b39f-3dfe44fc6990'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = 'Vol de Mercure aux Champs Elisés; Tres viste', part.name_en = 'Concert instrumental sur le titre d''Apotheose : III. Vol de Mercure aux Champs Elisés; Tres viste',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 23851 AND p.composer_id = 431 AND part.part_key = 'musicbrainz:7eef9597-1ba8-4bac-9f44-5e2fbf5a3d57' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:7eef9597-1ba8-4bac-9f44-5e2fbf5a3d57', 3, 'III', 'Vol de Mercure aux Champs Elisés; Tres viste', 'Concert instrumental sur le titre d''Apotheose : III. Vol de Mercure aux Champs Elisés; Tres viste', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 23851 AND p.composer_id = 431
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:7eef9597-1ba8-4bac-9f44-5e2fbf5a3d57'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = 'IV',
    part.name_ko = 'Descente d''Apollon; Noblement', part.name_en = 'Concert instrumental sur le titre d''Apotheose : IV. Descente d''Apollon; Noblement',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 23851 AND p.composer_id = 431 AND part.part_key = 'musicbrainz:bb9e4a39-66d5-4ef8-8e17-e362195f4684' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:bb9e4a39-66d5-4ef8-8e17-e362195f4684', 4, 'IV', 'Descente d''Apollon; Noblement', 'Concert instrumental sur le titre d''Apotheose : IV. Descente d''Apollon; Noblement', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 23851 AND p.composer_id = 431
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:bb9e4a39-66d5-4ef8-8e17-e362195f4684'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 5, part.movement_number = 'V',
    part.name_ko = 'Rumeur souterraine; Viste', part.name_en = 'Concert instrumental sur le titre d''Apotheose : V. Rumeur souterraine; Viste',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 23851 AND p.composer_id = 431 AND part.part_key = 'musicbrainz:d2099dc0-1c0d-44ac-87fa-b71c37ce2951' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:d2099dc0-1c0d-44ac-87fa-b71c37ce2951', 5, 'V', 'Rumeur souterraine; Viste', 'Concert instrumental sur le titre d''Apotheose : V. Rumeur souterraine; Viste', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 23851 AND p.composer_id = 431
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:d2099dc0-1c0d-44ac-87fa-b71c37ce2951'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 6, part.movement_number = 'VI',
    part.name_ko = 'Plainte des mêmes...; Dolemment', part.name_en = 'Concert instrumental sur le titre d''Apotheose : VI. Plainte des mêmes...; Dolemment',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 23851 AND p.composer_id = 431 AND part.part_key = 'musicbrainz:09bd9029-cb01-4744-8908-470fd451e971' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:09bd9029-cb01-4744-8908-470fd451e971', 6, 'VI', 'Plainte des mêmes...; Dolemment', 'Concert instrumental sur le titre d''Apotheose : VI. Plainte des mêmes...; Dolemment', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 23851 AND p.composer_id = 431
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:09bd9029-cb01-4744-8908-470fd451e971'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 7, part.movement_number = 'VII',
    part.name_ko = 'Enlèvement de Lulli ; Tres legerement', part.name_en = 'Concert instrumental sur le titre d''Apotheose : VII. Enlèvement de Lulli ; Tres legerement',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 23851 AND p.composer_id = 431 AND part.part_key = 'musicbrainz:2ece1970-88bb-425e-bb1a-0bda607c0791' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:2ece1970-88bb-425e-bb1a-0bda607c0791', 7, 'VII', 'Enlèvement de Lulli ; Tres legerement', 'Concert instrumental sur le titre d''Apotheose : VII. Enlèvement de Lulli ; Tres legerement', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 23851 AND p.composer_id = 431
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:2ece1970-88bb-425e-bb1a-0bda607c0791'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 8, part.movement_number = 'VIII',
    part.name_ko = 'Accueil entre doux et agard ; Largo', part.name_en = 'Concert instrumental sur le titre d''Apotheose : VIII. Accueil entre doux et agard ; Largo',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 23851 AND p.composer_id = 431 AND part.part_key = 'musicbrainz:b16af2dd-b8de-4538-bdea-d94123183117' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:b16af2dd-b8de-4538-bdea-d94123183117', 8, 'VIII', 'Accueil entre doux et agard ; Largo', 'Concert instrumental sur le titre d''Apotheose : VIII. Accueil entre doux et agard ; Largo', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 23851 AND p.composer_id = 431
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:b16af2dd-b8de-4538-bdea-d94123183117'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 9, part.movement_number = 'IX',
    part.name_ko = 'Remerciment de Lulli ; Gracieusement', part.name_en = 'Concert instrumental sur le titre d''Apotheose : IX. Remerciment de Lulli ; Gracieusement',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 23851 AND p.composer_id = 431 AND part.part_key = 'musicbrainz:173a8e21-ac9f-457d-bd03-9e0eb37293f1' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:173a8e21-ac9f-457d-bd03-9e0eb37293f1', 9, 'IX', 'Remerciment de Lulli ; Gracieusement', 'Concert instrumental sur le titre d''Apotheose : IX. Remerciment de Lulli ; Gracieusement', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 23851 AND p.composer_id = 431
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:173a8e21-ac9f-457d-bd03-9e0eb37293f1'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 10, part.movement_number = 'X',
    part.name_ko = 'Apollon persuade Lulli ; Elegamment, sans lenteur', part.name_en = 'Concert instrumental sur le titre d''Apotheose : X. Apollon persuade Lulli ; Elegamment, sans lenteur',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 23851 AND p.composer_id = 431 AND part.part_key = 'musicbrainz:d8dd870b-483f-48b2-890d-00fd4545ee5c' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:d8dd870b-483f-48b2-890d-00fd4545ee5c', 10, 'X', 'Apollon persuade Lulli ; Elegamment, sans lenteur', 'Concert instrumental sur le titre d''Apotheose : X. Apollon persuade Lulli ; Elegamment, sans lenteur', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 23851 AND p.composer_id = 431
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:d8dd870b-483f-48b2-890d-00fd4545ee5c'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 11, part.movement_number = 'XI',
    part.name_ko = 'Lulli, jouant le sujet - et Corelli l''acompagnant', part.name_en = 'Concert instrumental sur le titre d''Apotheose : XI. Lulli, jouant le sujet - et Corelli l''acompagnant',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 23851 AND p.composer_id = 431 AND part.part_key = 'musicbrainz:97a854fe-43dd-43f1-8ef1-b465fb2fffee' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:97a854fe-43dd-43f1-8ef1-b465fb2fffee', 11, 'XI', 'Lulli, jouant le sujet - et Corelli l''acompagnant', 'Concert instrumental sur le titre d''Apotheose : XI. Lulli, jouant le sujet - et Corelli l''acompagnant', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 23851 AND p.composer_id = 431
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:97a854fe-43dd-43f1-8ef1-b465fb2fffee'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 12, part.movement_number = 'XII',
    part.name_ko = 'Corelli, jouant le sujet à son tour, que Lulli acompagne', part.name_en = 'Concert instrumental sur le titre d''Apotheose : XII. Corelli, jouant le sujet à son tour, que Lulli acompagne',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 23851 AND p.composer_id = 431 AND part.part_key = 'musicbrainz:918658f0-401f-42c7-a372-9b13ac88053e' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:918658f0-401f-42c7-a372-9b13ac88053e', 12, 'XII', 'Corelli, jouant le sujet à son tour, que Lulli acompagne', 'Concert instrumental sur le titre d''Apotheose : XII. Corelli, jouant le sujet à son tour, que Lulli acompagne', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 23851 AND p.composer_id = 431
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:918658f0-401f-42c7-a372-9b13ac88053e'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 13, part.movement_number = 'XIII',
    part.name_ko = 'La Paix du Parnasse : Sonade en Trio ; Gravement', part.name_en = 'Concert instrumental sur le titre d''Apotheose : XIII. La Paix du Parnasse : Sonade en Trio ; Gravement',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 23851 AND p.composer_id = 431 AND part.part_key = 'musicbrainz:8019c943-525b-4c06-87a6-5698d31c8049' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:8019c943-525b-4c06-87a6-5698d31c8049', 13, 'XIII', 'La Paix du Parnasse : Sonade en Trio ; Gravement', 'Concert instrumental sur le titre d''Apotheose : XIII. La Paix du Parnasse : Sonade en Trio ; Gravement', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 23851 AND p.composer_id = 431
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:8019c943-525b-4c06-87a6-5698d31c8049'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:8019c943-525b-4c06-87a6-5698d31c8049'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'La Paix du Parnasse:IV. Vivement', part.name_en = 'La Paix du Parnasse:IV. Vivement',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 23851 AND p.composer_id = 431 AND part.part_key = 'musicbrainz:3c644a9d-8b13-42a9-a3bb-3ac758e4fb98' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:3c644a9d-8b13-42a9-a3bb-3ac758e4fb98', 1, NULL, 'La Paix du Parnasse:IV. Vivement', 'La Paix du Parnasse:IV. Vivement', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:8019c943-525b-4c06-87a6-5698d31c8049'
WHERE p.id = 23851 AND p.composer_id = 431
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:3c644a9d-8b13-42a9-a3bb-3ac758e4fb98'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:8019c943-525b-4c06-87a6-5698d31c8049'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'La Paix du Parnasse:II. Saillie Vivement', part.name_en = 'La Paix du Parnasse:II. Saillie Vivement',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 23851 AND p.composer_id = 431 AND part.part_key = 'musicbrainz:3ee1fd52-f301-4c33-a72b-047a243a1424' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:3ee1fd52-f301-4c33-a72b-047a243a1424', 2, NULL, 'La Paix du Parnasse:II. Saillie Vivement', 'La Paix du Parnasse:II. Saillie Vivement', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:8019c943-525b-4c06-87a6-5698d31c8049'
WHERE p.id = 23851 AND p.composer_id = 431
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:3ee1fd52-f301-4c33-a72b-047a243a1424'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:8019c943-525b-4c06-87a6-5698d31c8049'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = NULL,
    part.name_ko = 'La Paix du Parnasse:III. Rondement', part.name_en = 'La Paix du Parnasse:III. Rondement',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 23851 AND p.composer_id = 431 AND part.part_key = 'musicbrainz:72e221b3-065a-4540-a6b7-f3014166d122' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:72e221b3-065a-4540-a6b7-f3014166d122', 3, NULL, 'La Paix du Parnasse:III. Rondement', 'La Paix du Parnasse:III. Rondement', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:8019c943-525b-4c06-87a6-5698d31c8049'
WHERE p.id = 23851 AND p.composer_id = 431
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:72e221b3-065a-4540-a6b7-f3014166d122'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:8019c943-525b-4c06-87a6-5698d31c8049'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = NULL,
    part.name_ko = 'La Paix du Parnasse:I. Gravement', part.name_en = 'La Paix du Parnasse:I. Gravement',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 23851 AND p.composer_id = 431 AND part.part_key = 'musicbrainz:8348f99b-1a79-4354-b86c-8baffbfcc725' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:8348f99b-1a79-4354-b86c-8baffbfcc725', 4, NULL, 'La Paix du Parnasse:I. Gravement', 'La Paix du Parnasse:I. Gravement', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:8019c943-525b-4c06-87a6-5698d31c8049'
WHERE p.id = 23851 AND p.composer_id = 431
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:8348f99b-1a79-4354-b86c-8baffbfcc725'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 14, part.movement_number = 'XIV',
    part.name_ko = 'La Paix du Parnasse : Saillie. Vivement – Rondement – Vivement', part.name_en = 'Concert instrumental sur le titre d''Apotheose : XIV. La Paix du Parnasse : Saillie. Vivement – Rondement – Vivement',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 23851 AND p.composer_id = 431 AND part.part_key = 'musicbrainz:ab1f4353-b191-42e8-9f7f-82a2eaee6340' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:ab1f4353-b191-42e8-9f7f-82a2eaee6340', 14, 'XIV', 'La Paix du Parnasse : Saillie. Vivement – Rondement – Vivement', 'Concert instrumental sur le titre d''Apotheose : XIV. La Paix du Parnasse : Saillie. Vivement – Rondement – Vivement', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 23851 AND p.composer_id = 431
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:ab1f4353-b191-42e8-9f7f-82a2eaee6340'
);


-- None La Ménétou

UPDATE pieces piece
SET piece.title = 'La Ménétou', piece.title_en = 'La Ménétou',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 25033 AND piece.composer_id = 431
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None La Steinkerque

UPDATE pieces piece
SET piece.title = 'La Steinkerque', piece.title_en = 'La Steinkerque',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 23457 AND piece.composer_id = 431
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'II',
    part.name_ko = 'Air', part.name_en = 'La Steinkerque : II. Air',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 23457 AND p.composer_id = 431 AND part.part_key = 'musicbrainz:0f439cea-0025-44ff-a3c5-95653ba09b8e' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:0f439cea-0025-44ff-a3c5-95653ba09b8e', 1, 'II', 'Air', 'La Steinkerque : II. Air', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 23457 AND p.composer_id = 431
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:0f439cea-0025-44ff-a3c5-95653ba09b8e'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'IV',
    part.name_ko = 'Légèrement ; fanfares ; lentement ; gravement', part.name_en = 'La Steinkerque : IV. Légèrement ; fanfares ; lentement ; gravement',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 23457 AND p.composer_id = 431 AND part.part_key = 'musicbrainz:52c4c3bd-d4ef-4037-bb71-3198662303e7' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:52c4c3bd-d4ef-4037-bb71-3198662303e7', 2, 'IV', 'Légèrement ; fanfares ; lentement ; gravement', 'La Steinkerque : IV. Légèrement ; fanfares ; lentement ; gravement', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 23457 AND p.composer_id = 431
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:52c4c3bd-d4ef-4037-bb71-3198662303e7'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'V',
    part.name_ko = 'Gaiment ; lentement', part.name_en = 'La Steinkerque : V. Gaiment ; lentement',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 23457 AND p.composer_id = 431 AND part.part_key = 'musicbrainz:76095426-f958-4503-83c5-5613e697d2e0' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:76095426-f958-4503-83c5-5613e697d2e0', 3, 'V', 'Gaiment ; lentement', 'La Steinkerque : V. Gaiment ; lentement', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 23457 AND p.composer_id = 431
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:76095426-f958-4503-83c5-5613e697d2e0'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = 'I',
    part.name_ko = 'Gaiment', part.name_en = 'La Steinkerque : I. Gaiment',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 23457 AND p.composer_id = 431 AND part.part_key = 'musicbrainz:7f6db032-ab00-41a6-a71c-4d3a06d80d68' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:7f6db032-ab00-41a6-a71c-4d3a06d80d68', 4, 'I', 'Gaiment', 'La Steinkerque : I. Gaiment', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 23457 AND p.composer_id = 431
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:7f6db032-ab00-41a6-a71c-4d3a06d80d68'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 5, part.movement_number = 'III',
    part.name_ko = 'Gravement', part.name_en = 'La Steinkerque : III. Gravement',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 23457 AND p.composer_id = 431 AND part.part_key = 'musicbrainz:c5da4f03-6c9a-428c-b061-a00c5e9dd213' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:c5da4f03-6c9a-428c-b061-a00c5e9dd213', 5, 'III', 'Gravement', 'La Steinkerque : III. Gravement', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 23457 AND p.composer_id = 431
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:c5da4f03-6c9a-428c-b061-a00c5e9dd213'
);


-- None La Sultanne

UPDATE pieces piece
SET piece.title = 'La Sultanne', piece.title_en = 'La Sultanne',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 24765 AND piece.composer_id = 431
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None La Superbe

UPDATE pieces piece
SET piece.title = 'La Superbe', piece.title_en = 'La Superbe',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 24556 AND piece.composer_id = 431
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = '[no tempo marking]', part.name_en = 'La Superbe: I. [no tempo marking]',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 24556 AND p.composer_id = 431 AND part.part_key = 'musicbrainz:014a2890-e1c2-4ce3-8a4e-07cff3a6f653' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:014a2890-e1c2-4ce3-8a4e-07cff3a6f653', 1, 'I', '[no tempo marking]', 'La Superbe: I. [no tempo marking]', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 24556 AND p.composer_id = 431
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:014a2890-e1c2-4ce3-8a4e-07cff3a6f653'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = '[Légèrement]', part.name_en = 'La Superbe: II. [Légèrement]',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 24556 AND p.composer_id = 431 AND part.part_key = 'musicbrainz:99766272-88cb-4647-bbe6-e828384b63cd' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:99766272-88cb-4647-bbe6-e828384b63cd', 2, 'II', '[Légèrement]', 'La Superbe: II. [Légèrement]', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 24556 AND p.composer_id = 431
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:99766272-88cb-4647-bbe6-e828384b63cd'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = 'Très lentement', part.name_en = 'La Superbe: III. Très lentement',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 24556 AND p.composer_id = 431 AND part.part_key = 'musicbrainz:8b8cbfc0-c583-4da7-9977-c4fcf65b0aec' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:8b8cbfc0-c583-4da7-9977-c4fcf65b0aec', 3, 'III', 'Très lentement', 'La Superbe: III. Très lentement', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 24556 AND p.composer_id = 431
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:8b8cbfc0-c583-4da7-9977-c4fcf65b0aec'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = 'IV',
    part.name_ko = 'Légèrement', part.name_en = 'La Superbe: IV. Légèrement',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 24556 AND p.composer_id = 431 AND part.part_key = 'musicbrainz:b4a27995-de38-4bc6-901a-28e9320a82c6' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:b4a27995-de38-4bc6-901a-28e9320a82c6', 4, 'IV', 'Légèrement', 'La Superbe: IV. Légèrement', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 24556 AND p.composer_id = 431
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:b4a27995-de38-4bc6-901a-28e9320a82c6'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 5, part.movement_number = 'V',
    part.name_ko = 'Air tendre', part.name_en = 'La Superbe: V. Air tendre',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 24556 AND p.composer_id = 431 AND part.part_key = 'musicbrainz:467c9ff6-75c6-4c53-b022-0d7c387b5f8f' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:467c9ff6-75c6-4c53-b022-0d7c387b5f8f', 5, 'V', 'Air tendre', 'La Superbe: V. Air tendre', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 24556 AND p.composer_id = 431
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:467c9ff6-75c6-4c53-b022-0d7c387b5f8f'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 6, part.movement_number = 'VI',
    part.name_ko = 'Gayement', part.name_en = 'La Superbe: VI. Gayement',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 24556 AND p.composer_id = 431 AND part.part_key = 'musicbrainz:474fe781-02cd-4217-9a7f-79daf9e332c8' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:474fe781-02cd-4217-9a7f-79daf9e332c8', 6, 'VI', 'Gayement', 'La Superbe: VI. Gayement', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 24556 AND p.composer_id = 431
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:474fe781-02cd-4217-9a7f-79daf9e332c8'
);


-- None 모테트 <Laetentur coeli (Motet de Saint Barthélemy)>

UPDATE pieces piece
SET piece.title = '모테트 <Laetentur coeli (Motet de Saint Barthélemy)>', piece.title_en = 'Laetentur coeli (Motet de Saint Barthélemy)',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 24093 AND piece.composer_id = 431
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Lauda Sion Salvatorem

UPDATE pieces piece
SET piece.title = 'Lauda Sion Salvatorem', piece.title_en = 'Lauda Sion Salvatorem',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 23925 AND piece.composer_id = 431
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Laudate pueri Dominum

UPDATE pieces piece
SET piece.title = 'Laudate pueri Dominum', piece.title_en = 'Laudate pueri Dominum',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 23693 AND piece.composer_id = 431
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Le Parnasse, ou l'apothéose de Corelli - Grande Sonade en Trio

UPDATE pieces piece
SET piece.title = 'Le Parnasse, ou l''apothéose de Corelli - Grande Sonade en Trio', piece.title_en = 'Le Parnasse, ou l''apothéose de Corelli - Grande Sonade en Trio',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 25323 AND piece.composer_id = 431
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'Corelli, au pied du Parnasse, prie les Muses de le recevoir parmi elles', part.name_en = 'Le Parnasse, ou l''apothéose de Corelli - Grande Sonade en Trio: I. Corelli, au pied du Parnasse, prie les Muses de le recevoir parmi elles.',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 25323 AND p.composer_id = 431 AND part.part_key = 'musicbrainz:17bc3b7e-b51c-40b2-8c9e-eb2a2cd5d4fb' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:17bc3b7e-b51c-40b2-8c9e-eb2a2cd5d4fb', 1, 'I', 'Corelli, au pied du Parnasse, prie les Muses de le recevoir parmi elles', 'Le Parnasse, ou l''apothéose de Corelli - Grande Sonade en Trio: I. Corelli, au pied du Parnasse, prie les Muses de le recevoir parmi elles.', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 25323 AND p.composer_id = 431
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:17bc3b7e-b51c-40b2-8c9e-eb2a2cd5d4fb'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'Corelli, charmé de la bonne réception qu''on lui fait au Parnasse, en marque sa joie ! Il continue avec ceux qui l''accompagnent', part.name_en = 'Le Parnasse, ou l''apothéose de Corelli - Grande Sonade en Trio: II. Corelli, charmé de la bonne réception qu''on lui fait au Parnasse, en marque sa joie ! Il continue avec ceux qui l''accompagnent.',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 25323 AND p.composer_id = 431 AND part.part_key = 'musicbrainz:1ec21e18-d17d-4029-8035-2088c98de879' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:1ec21e18-d17d-4029-8035-2088c98de879', 2, 'II', 'Corelli, charmé de la bonne réception qu''on lui fait au Parnasse, en marque sa joie ! Il continue avec ceux qui l''accompagnent', 'Le Parnasse, ou l''apothéose de Corelli - Grande Sonade en Trio: II. Corelli, charmé de la bonne réception qu''on lui fait au Parnasse, en marque sa joie ! Il continue avec ceux qui l''accompagnent.', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 25323 AND p.composer_id = 431
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:1ec21e18-d17d-4029-8035-2088c98de879'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = 'Corelli, buvant à la source d''Hyppocrène, sa troupe continue', part.name_en = 'Le Parnasse, ou l''apothéose de Corelli - Grande Sonade en Trio: III. Corelli, buvant à la source d''Hyppocrène, sa troupe continue.',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 25323 AND p.composer_id = 431 AND part.part_key = 'musicbrainz:8ccc8b1d-3a85-4cfd-9551-109092eb9290' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:8ccc8b1d-3a85-4cfd-9551-109092eb9290', 3, 'III', 'Corelli, buvant à la source d''Hyppocrène, sa troupe continue', 'Le Parnasse, ou l''apothéose de Corelli - Grande Sonade en Trio: III. Corelli, buvant à la source d''Hyppocrène, sa troupe continue.', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 25323 AND p.composer_id = 431
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:8ccc8b1d-3a85-4cfd-9551-109092eb9290'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = 'IV',
    part.name_ko = 'Entousiasme de Corelli causé par les eaux d''Hyppocrène', part.name_en = 'Le Parnasse, ou l''apothéose de Corelli - Grande Sonade en Trio: IV. Entousiasme de Corelli causé par les eaux d''Hyppocrène',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 25323 AND p.composer_id = 431 AND part.part_key = 'musicbrainz:aafef294-94e0-456f-b36b-360fd3c49050' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:aafef294-94e0-456f-b36b-360fd3c49050', 4, 'IV', 'Entousiasme de Corelli causé par les eaux d''Hyppocrène', 'Le Parnasse, ou l''apothéose de Corelli - Grande Sonade en Trio: IV. Entousiasme de Corelli causé par les eaux d''Hyppocrène', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 25323 AND p.composer_id = 431
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:aafef294-94e0-456f-b36b-360fd3c49050'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 5, part.movement_number = 'V',
    part.name_ko = 'Corelli, après son enthousiasme, s''endort, et sa troupe joue le sommeil suivant très doux', part.name_en = 'Le Parnasse, ou l''apothéose de Corelli - Grande Sonade en Trio: V. Corelli, après son enthousiasme, s''endort, et sa troupe joue le sommeil suivant très doux.',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 25323 AND p.composer_id = 431 AND part.part_key = 'musicbrainz:a5ca6a8f-7b2c-4cbb-a774-a0b6fdeeb1de' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:a5ca6a8f-7b2c-4cbb-a774-a0b6fdeeb1de', 5, 'V', 'Corelli, après son enthousiasme, s''endort, et sa troupe joue le sommeil suivant très doux', 'Le Parnasse, ou l''apothéose de Corelli - Grande Sonade en Trio: V. Corelli, après son enthousiasme, s''endort, et sa troupe joue le sommeil suivant très doux.', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 25323 AND p.composer_id = 431
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:a5ca6a8f-7b2c-4cbb-a774-a0b6fdeeb1de'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 6, part.movement_number = 'VI',
    part.name_ko = 'Les Muses réveillent Corelli, et le placent auprès d''Apollon', part.name_en = 'Le Parnasse, ou l''apothéose de Corelli - Grande Sonade en Trio: VI. Les Muses réveillent Corelli, et le placent auprès d''Apollon.',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 25323 AND p.composer_id = 431 AND part.part_key = 'musicbrainz:f67dc695-1c82-4710-a3a4-7dbeb646cbab' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:f67dc695-1c82-4710-a3a4-7dbeb646cbab', 6, 'VI', 'Les Muses réveillent Corelli, et le placent auprès d''Apollon', 'Le Parnasse, ou l''apothéose de Corelli - Grande Sonade en Trio: VI. Les Muses réveillent Corelli, et le placent auprès d''Apollon.', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 25323 AND p.composer_id = 431
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:f67dc695-1c82-4710-a3a4-7dbeb646cbab'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 7, part.movement_number = 'VII',
    part.name_ko = 'Remerciement de Corelli', part.name_en = 'Le Parnasse, ou l''apothéose de Corelli - Grande Sonade en Trio: VII. Remerciement de Corelli.',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 25323 AND p.composer_id = 431 AND part.part_key = 'musicbrainz:6ae8d6c8-4bb6-4822-8fa8-b3f9f36ceba3' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:6ae8d6c8-4bb6-4822-8fa8-b3f9f36ceba3', 7, 'VII', 'Remerciement de Corelli', 'Le Parnasse, ou l''apothéose de Corelli - Grande Sonade en Trio: VII. Remerciement de Corelli.', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 25323 AND p.composer_id = 431
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:6ae8d6c8-4bb6-4822-8fa8-b3f9f36ceba3'
);


-- None Les Nations

UPDATE pieces piece
SET piece.title = 'Les Nations', piece.title_en = 'Les Nations',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 24677 AND piece.composer_id = 431
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'Premier Ordre, « La Francoise »', part.name_en = 'Les Nations : Premier Ordre, « La Francoise »',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 24677 AND p.composer_id = 431 AND part.part_key = 'musicbrainz:6cf61f81-d9c2-4984-9ce1-d70070865486' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:6cf61f81-d9c2-4984-9ce1-d70070865486', 1, NULL, 'Premier Ordre, « La Francoise »', 'Les Nations : Premier Ordre, « La Francoise »', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 24677 AND p.composer_id = 431
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:6cf61f81-d9c2-4984-9ce1-d70070865486'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:6cf61f81-d9c2-4984-9ce1-d70070865486'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'Premier Ordre, « La Francoise » : I. Sonade', part.name_en = 'Les Nations : Premier Ordre, « La Francoise » : I. Sonade',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 24677 AND p.composer_id = 431 AND part.part_key = 'musicbrainz:909bea96-adf6-4905-b312-76a80116c46c' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:909bea96-adf6-4905-b312-76a80116c46c', 1, NULL, 'Premier Ordre, « La Francoise » : I. Sonade', 'Les Nations : Premier Ordre, « La Francoise » : I. Sonade', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:6cf61f81-d9c2-4984-9ce1-d70070865486'
WHERE p.id = 24677 AND p.composer_id = 431
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:909bea96-adf6-4905-b312-76a80116c46c'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:6cf61f81-d9c2-4984-9ce1-d70070865486'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'Premier Ordre, « La Francoise » : II. Allemande', part.name_en = 'Les Nations : Premier Ordre, « La Francoise » : II. Allemande',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 24677 AND p.composer_id = 431 AND part.part_key = 'musicbrainz:981ce082-455a-4611-8dd1-cc0d8e52b2ce' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:981ce082-455a-4611-8dd1-cc0d8e52b2ce', 2, NULL, 'Premier Ordre, « La Francoise » : II. Allemande', 'Les Nations : Premier Ordre, « La Francoise » : II. Allemande', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:6cf61f81-d9c2-4984-9ce1-d70070865486'
WHERE p.id = 24677 AND p.composer_id = 431
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:981ce082-455a-4611-8dd1-cc0d8e52b2ce'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:6cf61f81-d9c2-4984-9ce1-d70070865486'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = NULL,
    part.name_ko = 'Premier Ordre, « La Francoise » : III. Première Courante', part.name_en = 'Les Nations : Premier Ordre, « La Francoise » : III. Première Courante',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 24677 AND p.composer_id = 431 AND part.part_key = 'musicbrainz:4e9b9e00-5388-428e-9162-0b38e5dc491b' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:4e9b9e00-5388-428e-9162-0b38e5dc491b', 3, NULL, 'Premier Ordre, « La Francoise » : III. Première Courante', 'Les Nations : Premier Ordre, « La Francoise » : III. Première Courante', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:6cf61f81-d9c2-4984-9ce1-d70070865486'
WHERE p.id = 24677 AND p.composer_id = 431
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:4e9b9e00-5388-428e-9162-0b38e5dc491b'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:6cf61f81-d9c2-4984-9ce1-d70070865486'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = NULL,
    part.name_ko = 'Premier Ordre, « La Francoise » : IV. Seconde Courante', part.name_en = 'Les Nations : Premier Ordre, « La Francoise » : IV. Seconde Courante',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 24677 AND p.composer_id = 431 AND part.part_key = 'musicbrainz:2b491fdf-52e0-4e17-835c-63248eb1433e' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:2b491fdf-52e0-4e17-835c-63248eb1433e', 4, NULL, 'Premier Ordre, « La Francoise » : IV. Seconde Courante', 'Les Nations : Premier Ordre, « La Francoise » : IV. Seconde Courante', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:6cf61f81-d9c2-4984-9ce1-d70070865486'
WHERE p.id = 24677 AND p.composer_id = 431
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:2b491fdf-52e0-4e17-835c-63248eb1433e'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:6cf61f81-d9c2-4984-9ce1-d70070865486'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 5, part.movement_number = NULL,
    part.name_ko = 'Premier Ordre, « La Francoise » : V. Sarabande', part.name_en = 'Les Nations : Premier Ordre, « La Francoise » : V. Sarabande',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 24677 AND p.composer_id = 431 AND part.part_key = 'musicbrainz:db98f6f3-ac7e-488f-809a-83ab5d68aea5' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:db98f6f3-ac7e-488f-809a-83ab5d68aea5', 5, NULL, 'Premier Ordre, « La Francoise » : V. Sarabande', 'Les Nations : Premier Ordre, « La Francoise » : V. Sarabande', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:6cf61f81-d9c2-4984-9ce1-d70070865486'
WHERE p.id = 24677 AND p.composer_id = 431
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:db98f6f3-ac7e-488f-809a-83ab5d68aea5'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:6cf61f81-d9c2-4984-9ce1-d70070865486'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 6, part.movement_number = NULL,
    part.name_ko = 'Premier Ordre, « La Francoise » : VI. Gigue', part.name_en = 'Les Nations : Premier Ordre, « La Francoise » : VI. Gigue',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 24677 AND p.composer_id = 431 AND part.part_key = 'musicbrainz:7b9b6b1b-4cef-47d2-8a33-a835e781be8d' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:7b9b6b1b-4cef-47d2-8a33-a835e781be8d', 6, NULL, 'Premier Ordre, « La Francoise » : VI. Gigue', 'Les Nations : Premier Ordre, « La Francoise » : VI. Gigue', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:6cf61f81-d9c2-4984-9ce1-d70070865486'
WHERE p.id = 24677 AND p.composer_id = 431
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:7b9b6b1b-4cef-47d2-8a33-a835e781be8d'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:6cf61f81-d9c2-4984-9ce1-d70070865486'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 7, part.movement_number = NULL,
    part.name_ko = 'Premier Ordre, « La Francoise » : VII. Chaconne ou Passacaille', part.name_en = 'Les Nations : Premier Ordre, « La Francoise » : VII. Chaconne ou Passacaille',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 24677 AND p.composer_id = 431 AND part.part_key = 'musicbrainz:fcb08e4d-4d45-415e-bf67-9d57d4844c34' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:fcb08e4d-4d45-415e-bf67-9d57d4844c34', 7, NULL, 'Premier Ordre, « La Francoise » : VII. Chaconne ou Passacaille', 'Les Nations : Premier Ordre, « La Francoise » : VII. Chaconne ou Passacaille', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:6cf61f81-d9c2-4984-9ce1-d70070865486'
WHERE p.id = 24677 AND p.composer_id = 431
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:fcb08e4d-4d45-415e-bf67-9d57d4844c34'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:6cf61f81-d9c2-4984-9ce1-d70070865486'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 8, part.movement_number = NULL,
    part.name_ko = 'Premier Ordre, « La Francoise » : VIII. Gavotte', part.name_en = 'Les Nations : Premier Ordre, « La Francoise » : VIII. Gavotte',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 24677 AND p.composer_id = 431 AND part.part_key = 'musicbrainz:a636f7e6-4038-4b73-906d-5e4f404fce83' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:a636f7e6-4038-4b73-906d-5e4f404fce83', 8, NULL, 'Premier Ordre, « La Francoise » : VIII. Gavotte', 'Les Nations : Premier Ordre, « La Francoise » : VIII. Gavotte', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:6cf61f81-d9c2-4984-9ce1-d70070865486'
WHERE p.id = 24677 AND p.composer_id = 431
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:a636f7e6-4038-4b73-906d-5e4f404fce83'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:6cf61f81-d9c2-4984-9ce1-d70070865486'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 9, part.movement_number = NULL,
    part.name_ko = 'Premier Ordre, « La Francoise » : IX. Menuet', part.name_en = 'Les Nations : Premier Ordre, « La Francoise » : IX. Menuet',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 24677 AND p.composer_id = 431 AND part.part_key = 'musicbrainz:86c1700b-93b7-4cd8-bdad-0c2e1405d7ce' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:86c1700b-93b7-4cd8-bdad-0c2e1405d7ce', 9, NULL, 'Premier Ordre, « La Francoise » : IX. Menuet', 'Les Nations : Premier Ordre, « La Francoise » : IX. Menuet', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:6cf61f81-d9c2-4984-9ce1-d70070865486'
WHERE p.id = 24677 AND p.composer_id = 431
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:86c1700b-93b7-4cd8-bdad-0c2e1405d7ce'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'Second Ordre, « L''Espagnole »', part.name_en = 'Les Nations : Second Ordre, « L''Espagnole »',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 24677 AND p.composer_id = 431 AND part.part_key = 'musicbrainz:f595bff8-967b-4fd5-afb5-5019424d7251' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:f595bff8-967b-4fd5-afb5-5019424d7251', 2, NULL, 'Second Ordre, « L''Espagnole »', 'Les Nations : Second Ordre, « L''Espagnole »', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 24677 AND p.composer_id = 431
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:f595bff8-967b-4fd5-afb5-5019424d7251'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:f595bff8-967b-4fd5-afb5-5019424d7251'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'Second Ordre, « L''Espagnole » : I. Sonade', part.name_en = 'Les Nations : Second Ordre, « L''Espagnole » : I. Sonade',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 24677 AND p.composer_id = 431 AND part.part_key = 'musicbrainz:10351d73-565c-485f-88c2-309f8f93c0f7' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:10351d73-565c-485f-88c2-309f8f93c0f7', 1, NULL, 'Second Ordre, « L''Espagnole » : I. Sonade', 'Les Nations : Second Ordre, « L''Espagnole » : I. Sonade', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:f595bff8-967b-4fd5-afb5-5019424d7251'
WHERE p.id = 24677 AND p.composer_id = 431
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:10351d73-565c-485f-88c2-309f8f93c0f7'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:f595bff8-967b-4fd5-afb5-5019424d7251'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'Second Ordre, « L''Espagnole » : II. Allemande', part.name_en = 'Les Nations : Second Ordre, « L''Espagnole » : II. Allemande',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 24677 AND p.composer_id = 431 AND part.part_key = 'musicbrainz:e219f2b8-ae30-4ddb-8b89-bc4badc1d9ed' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:e219f2b8-ae30-4ddb-8b89-bc4badc1d9ed', 2, NULL, 'Second Ordre, « L''Espagnole » : II. Allemande', 'Les Nations : Second Ordre, « L''Espagnole » : II. Allemande', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:f595bff8-967b-4fd5-afb5-5019424d7251'
WHERE p.id = 24677 AND p.composer_id = 431
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:e219f2b8-ae30-4ddb-8b89-bc4badc1d9ed'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:f595bff8-967b-4fd5-afb5-5019424d7251'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = NULL,
    part.name_ko = 'Second Ordre, « L''Espagnole » : III. Courante', part.name_en = 'Les Nations : Second Ordre, « L''Espagnole » : III. Courante',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 24677 AND p.composer_id = 431 AND part.part_key = 'musicbrainz:948773ff-25cc-4ad6-a650-5a184bf20a43' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:948773ff-25cc-4ad6-a650-5a184bf20a43', 3, NULL, 'Second Ordre, « L''Espagnole » : III. Courante', 'Les Nations : Second Ordre, « L''Espagnole » : III. Courante', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:f595bff8-967b-4fd5-afb5-5019424d7251'
WHERE p.id = 24677 AND p.composer_id = 431
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:948773ff-25cc-4ad6-a650-5a184bf20a43'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:f595bff8-967b-4fd5-afb5-5019424d7251'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = NULL,
    part.name_ko = 'Second Ordre, « L''Espagnole » : IV. Seconde courante', part.name_en = 'Les Nations : Second Ordre, « L''Espagnole » : IV. Seconde courante',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 24677 AND p.composer_id = 431 AND part.part_key = 'musicbrainz:a40b32ca-606a-4f31-9968-384625807cc6' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:a40b32ca-606a-4f31-9968-384625807cc6', 4, NULL, 'Second Ordre, « L''Espagnole » : IV. Seconde courante', 'Les Nations : Second Ordre, « L''Espagnole » : IV. Seconde courante', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:f595bff8-967b-4fd5-afb5-5019424d7251'
WHERE p.id = 24677 AND p.composer_id = 431
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:a40b32ca-606a-4f31-9968-384625807cc6'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:f595bff8-967b-4fd5-afb5-5019424d7251'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 5, part.movement_number = NULL,
    part.name_ko = 'Second Ordre, « L''Espagnole » : V. Sarabande', part.name_en = 'Les Nations : Second Ordre, « L''Espagnole » : V. Sarabande',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 24677 AND p.composer_id = 431 AND part.part_key = 'musicbrainz:b2a7135f-66be-486d-a7ba-6233705b7a67' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:b2a7135f-66be-486d-a7ba-6233705b7a67', 5, NULL, 'Second Ordre, « L''Espagnole » : V. Sarabande', 'Les Nations : Second Ordre, « L''Espagnole » : V. Sarabande', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:f595bff8-967b-4fd5-afb5-5019424d7251'
WHERE p.id = 24677 AND p.composer_id = 431
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:b2a7135f-66be-486d-a7ba-6233705b7a67'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:f595bff8-967b-4fd5-afb5-5019424d7251'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 6, part.movement_number = NULL,
    part.name_ko = 'Second Ordre, « L''Espagnole » : VI. Gigue Lourée', part.name_en = 'Les Nations : Second Ordre, « L''Espagnole » : VI. Gigue Lourée',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 24677 AND p.composer_id = 431 AND part.part_key = 'musicbrainz:a1ef3516-a449-4088-b116-e34d25c000c7' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:a1ef3516-a449-4088-b116-e34d25c000c7', 6, NULL, 'Second Ordre, « L''Espagnole » : VI. Gigue Lourée', 'Les Nations : Second Ordre, « L''Espagnole » : VI. Gigue Lourée', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:f595bff8-967b-4fd5-afb5-5019424d7251'
WHERE p.id = 24677 AND p.composer_id = 431
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:a1ef3516-a449-4088-b116-e34d25c000c7'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:f595bff8-967b-4fd5-afb5-5019424d7251'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 7, part.movement_number = NULL,
    part.name_ko = 'Second Ordre, « L''Espagnole » : VII. Gavotte', part.name_en = 'Les Nations : Second Ordre, « L''Espagnole » : VII. Gavotte',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 24677 AND p.composer_id = 431 AND part.part_key = 'musicbrainz:08525022-cb83-4ed1-bc5a-4a15b50eac61' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:08525022-cb83-4ed1-bc5a-4a15b50eac61', 7, NULL, 'Second Ordre, « L''Espagnole » : VII. Gavotte', 'Les Nations : Second Ordre, « L''Espagnole » : VII. Gavotte', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:f595bff8-967b-4fd5-afb5-5019424d7251'
WHERE p.id = 24677 AND p.composer_id = 431
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:08525022-cb83-4ed1-bc5a-4a15b50eac61'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:f595bff8-967b-4fd5-afb5-5019424d7251'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 8, part.movement_number = NULL,
    part.name_ko = 'Second Ordre, « L''Espagnole » : VIII. Rondeau', part.name_en = 'Les Nations : Second Ordre, « L''Espagnole » : VIII. Rondeau',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 24677 AND p.composer_id = 431 AND part.part_key = 'musicbrainz:9a990ea7-d603-4a90-8e42-12a869617386' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:9a990ea7-d603-4a90-8e42-12a869617386', 8, NULL, 'Second Ordre, « L''Espagnole » : VIII. Rondeau', 'Les Nations : Second Ordre, « L''Espagnole » : VIII. Rondeau', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:f595bff8-967b-4fd5-afb5-5019424d7251'
WHERE p.id = 24677 AND p.composer_id = 431
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:9a990ea7-d603-4a90-8e42-12a869617386'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:f595bff8-967b-4fd5-afb5-5019424d7251'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 9, part.movement_number = NULL,
    part.name_ko = 'Second Ordre, « L''Espagnole » : IX. Bourée. Double de la Bourée précédente', part.name_en = 'Les Nations : Second Ordre, « L''Espagnole » : IX. Bourée. Double de la Bourée précédente',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 24677 AND p.composer_id = 431 AND part.part_key = 'musicbrainz:5e9e90ee-b852-4faf-88bf-b10302f51a42' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:5e9e90ee-b852-4faf-88bf-b10302f51a42', 9, NULL, 'Second Ordre, « L''Espagnole » : IX. Bourée. Double de la Bourée précédente', 'Les Nations : Second Ordre, « L''Espagnole » : IX. Bourée. Double de la Bourée précédente', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:f595bff8-967b-4fd5-afb5-5019424d7251'
WHERE p.id = 24677 AND p.composer_id = 431
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:5e9e90ee-b852-4faf-88bf-b10302f51a42'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:f595bff8-967b-4fd5-afb5-5019424d7251'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 10, part.movement_number = NULL,
    part.name_ko = 'Second Ordre, « L''Espagnole » : X. Passacaille', part.name_en = 'Les Nations : Second Ordre, « L''Espagnole » : X. Passacaille',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 24677 AND p.composer_id = 431 AND part.part_key = 'musicbrainz:75007d9d-f32e-4f2c-a014-f9d95338c875' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:75007d9d-f32e-4f2c-a014-f9d95338c875', 10, NULL, 'Second Ordre, « L''Espagnole » : X. Passacaille', 'Les Nations : Second Ordre, « L''Espagnole » : X. Passacaille', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:f595bff8-967b-4fd5-afb5-5019424d7251'
WHERE p.id = 24677 AND p.composer_id = 431
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:75007d9d-f32e-4f2c-a014-f9d95338c875'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = NULL,
    part.name_ko = 'Troisième Ordre, « L''Impériale »', part.name_en = 'Les Nations : Troisième Ordre, « L''Impériale »',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 24677 AND p.composer_id = 431 AND part.part_key = 'musicbrainz:740c8611-60d8-4a8b-a252-9720f580082c' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:740c8611-60d8-4a8b-a252-9720f580082c', 3, NULL, 'Troisième Ordre, « L''Impériale »', 'Les Nations : Troisième Ordre, « L''Impériale »', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 24677 AND p.composer_id = 431
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:740c8611-60d8-4a8b-a252-9720f580082c'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:740c8611-60d8-4a8b-a252-9720f580082c'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'Troisième Ordre, « L''Impériale » : I. Sonade. Gravement - Vivement et marqué - Gravement, et marqué - Très lentement - Légèrement - Rondement - Vivement', part.name_en = 'Les Nations : Troisième Ordre, « L''Impériale » : I. Sonade. Gravement - Vivement et marqué - Gravement, et marqué - Très lentement - Légèrement - Rondement - Vivement',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 24677 AND p.composer_id = 431 AND part.part_key = 'musicbrainz:c9883209-29d6-4adc-9a8c-e28da0f049f6' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:c9883209-29d6-4adc-9a8c-e28da0f049f6', 1, NULL, 'Troisième Ordre, « L''Impériale » : I. Sonade. Gravement - Vivement et marqué - Gravement, et marqué - Très lentement - Légèrement - Rondement - Vivement', 'Les Nations : Troisième Ordre, « L''Impériale » : I. Sonade. Gravement - Vivement et marqué - Gravement, et marqué - Très lentement - Légèrement - Rondement - Vivement', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:740c8611-60d8-4a8b-a252-9720f580082c'
WHERE p.id = 24677 AND p.composer_id = 431
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:c9883209-29d6-4adc-9a8c-e28da0f049f6'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:740c8611-60d8-4a8b-a252-9720f580082c'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'Troisième Ordre, « L''Impériale » : II. Allemande. Sans lenteur', part.name_en = 'Les Nations : Troisième Ordre, « L''Impériale » : II. Allemande. Sans lenteur',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 24677 AND p.composer_id = 431 AND part.part_key = 'musicbrainz:782e4532-0f7f-408e-863e-dda4a6211b2e' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:782e4532-0f7f-408e-863e-dda4a6211b2e', 2, NULL, 'Troisième Ordre, « L''Impériale » : II. Allemande. Sans lenteur', 'Les Nations : Troisième Ordre, « L''Impériale » : II. Allemande. Sans lenteur', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:740c8611-60d8-4a8b-a252-9720f580082c'
WHERE p.id = 24677 AND p.composer_id = 431
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:782e4532-0f7f-408e-863e-dda4a6211b2e'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:740c8611-60d8-4a8b-a252-9720f580082c'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = NULL,
    part.name_ko = 'Troisième Ordre, « L''Impériale » : III. Courante', part.name_en = 'Les Nations : Troisième Ordre, « L''Impériale » : III. Courante',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 24677 AND p.composer_id = 431 AND part.part_key = 'musicbrainz:a991673a-5417-4878-aa06-e48a930560f0' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:a991673a-5417-4878-aa06-e48a930560f0', 3, NULL, 'Troisième Ordre, « L''Impériale » : III. Courante', 'Les Nations : Troisième Ordre, « L''Impériale » : III. Courante', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:740c8611-60d8-4a8b-a252-9720f580082c'
WHERE p.id = 24677 AND p.composer_id = 431
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:a991673a-5417-4878-aa06-e48a930560f0'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:740c8611-60d8-4a8b-a252-9720f580082c'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = NULL,
    part.name_ko = 'Troisième Ordre, « L''Impériale » : IV. Seconde Courante', part.name_en = 'Les Nations : Troisième Ordre, « L''Impériale » : IV. Seconde Courante',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 24677 AND p.composer_id = 431 AND part.part_key = 'musicbrainz:672adea1-5691-4841-9037-59c1f43a8946' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:672adea1-5691-4841-9037-59c1f43a8946', 4, NULL, 'Troisième Ordre, « L''Impériale » : IV. Seconde Courante', 'Les Nations : Troisième Ordre, « L''Impériale » : IV. Seconde Courante', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:740c8611-60d8-4a8b-a252-9720f580082c'
WHERE p.id = 24677 AND p.composer_id = 431
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:672adea1-5691-4841-9037-59c1f43a8946'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:740c8611-60d8-4a8b-a252-9720f580082c'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 5, part.movement_number = NULL,
    part.name_ko = 'Troisième Ordre, « L''Impériale » : V. Sarabande. Tendrement', part.name_en = 'Les Nations : Troisième Ordre, « L''Impériale » : V. Sarabande. Tendrement',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 24677 AND p.composer_id = 431 AND part.part_key = 'musicbrainz:eac038c6-b147-464f-9879-675b1d92aa61' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:eac038c6-b147-464f-9879-675b1d92aa61', 5, NULL, 'Troisième Ordre, « L''Impériale » : V. Sarabande. Tendrement', 'Les Nations : Troisième Ordre, « L''Impériale » : V. Sarabande. Tendrement', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:740c8611-60d8-4a8b-a252-9720f580082c'
WHERE p.id = 24677 AND p.composer_id = 431
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:eac038c6-b147-464f-9879-675b1d92aa61'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:740c8611-60d8-4a8b-a252-9720f580082c'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 6, part.movement_number = NULL,
    part.name_ko = 'Troisième Ordre, « L''Impériale » : VI. Bourée. Gayement', part.name_en = 'Les Nations : Troisième Ordre, « L''Impériale » : VI. Bourée. Gayement',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 24677 AND p.composer_id = 431 AND part.part_key = 'musicbrainz:c9fd8ab4-9ece-4226-979e-307e177123b8' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:c9fd8ab4-9ece-4226-979e-307e177123b8', 6, NULL, 'Troisième Ordre, « L''Impériale » : VI. Bourée. Gayement', 'Les Nations : Troisième Ordre, « L''Impériale » : VI. Bourée. Gayement', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:740c8611-60d8-4a8b-a252-9720f580082c'
WHERE p.id = 24677 AND p.composer_id = 431
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:c9fd8ab4-9ece-4226-979e-307e177123b8'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:740c8611-60d8-4a8b-a252-9720f580082c'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 7, part.movement_number = NULL,
    part.name_ko = 'Troisième Ordre, « L''Impériale » : VII. Gigue. D''une légèreté modérée', part.name_en = 'Les Nations : Troisième Ordre, « L''Impériale » : VII. Gigue. D''une légèreté modérée',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 24677 AND p.composer_id = 431 AND part.part_key = 'musicbrainz:7be8e95a-8a33-4976-89ae-52cd370191cc' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:7be8e95a-8a33-4976-89ae-52cd370191cc', 7, NULL, 'Troisième Ordre, « L''Impériale » : VII. Gigue. D''une légèreté modérée', 'Les Nations : Troisième Ordre, « L''Impériale » : VII. Gigue. D''une légèreté modérée', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:740c8611-60d8-4a8b-a252-9720f580082c'
WHERE p.id = 24677 AND p.composer_id = 431
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:7be8e95a-8a33-4976-89ae-52cd370191cc'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:740c8611-60d8-4a8b-a252-9720f580082c'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 8, part.movement_number = NULL,
    part.name_ko = 'Troisième Ordre, « L''Impériale » : VIII. Rondeau. Gayement', part.name_en = 'Les Nations : Troisième Ordre, « L''Impériale » : VIII. Rondeau. Gayement',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 24677 AND p.composer_id = 431 AND part.part_key = 'musicbrainz:bc3574bf-d27c-4c28-a487-5ce8bbb0fe28' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:bc3574bf-d27c-4c28-a487-5ce8bbb0fe28', 8, NULL, 'Troisième Ordre, « L''Impériale » : VIII. Rondeau. Gayement', 'Les Nations : Troisième Ordre, « L''Impériale » : VIII. Rondeau. Gayement', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:740c8611-60d8-4a8b-a252-9720f580082c'
WHERE p.id = 24677 AND p.composer_id = 431
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:bc3574bf-d27c-4c28-a487-5ce8bbb0fe28'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:740c8611-60d8-4a8b-a252-9720f580082c'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 9, part.movement_number = NULL,
    part.name_ko = 'Troisième Ordre, « L''Impériale » : IX. Chaconne', part.name_en = 'Les Nations : Troisième Ordre, « L''Impériale » : IX. Chaconne',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 24677 AND p.composer_id = 431 AND part.part_key = 'musicbrainz:8bd9802b-8a12-40fe-a57a-9cf7ea554ca0' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:8bd9802b-8a12-40fe-a57a-9cf7ea554ca0', 9, NULL, 'Troisième Ordre, « L''Impériale » : IX. Chaconne', 'Les Nations : Troisième Ordre, « L''Impériale » : IX. Chaconne', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:740c8611-60d8-4a8b-a252-9720f580082c'
WHERE p.id = 24677 AND p.composer_id = 431
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:8bd9802b-8a12-40fe-a57a-9cf7ea554ca0'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:740c8611-60d8-4a8b-a252-9720f580082c'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 10, part.movement_number = NULL,
    part.name_ko = 'Troisième Ordre, « L''Impériale » : X. Menuet', part.name_en = 'Les Nations : Troisième Ordre, « L''Impériale » : X. Menuet',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 24677 AND p.composer_id = 431 AND part.part_key = 'musicbrainz:fe6f56f3-5fdf-438f-8bfa-b1fa738b6358' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:fe6f56f3-5fdf-438f-8bfa-b1fa738b6358', 10, NULL, 'Troisième Ordre, « L''Impériale » : X. Menuet', 'Les Nations : Troisième Ordre, « L''Impériale » : X. Menuet', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:740c8611-60d8-4a8b-a252-9720f580082c'
WHERE p.id = 24677 AND p.composer_id = 431
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:fe6f56f3-5fdf-438f-8bfa-b1fa738b6358'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = NULL,
    part.name_ko = 'Quatrième Ordre, « La Piémontoise »', part.name_en = 'Les Nations : Quatrième Ordre, « La Piémontoise »',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 24677 AND p.composer_id = 431 AND part.part_key = 'musicbrainz:6c20fa30-387a-4b94-a796-59eec71a024c' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:6c20fa30-387a-4b94-a796-59eec71a024c', 4, NULL, 'Quatrième Ordre, « La Piémontoise »', 'Les Nations : Quatrième Ordre, « La Piémontoise »', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 24677 AND p.composer_id = 431
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:6c20fa30-387a-4b94-a796-59eec71a024c'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:6c20fa30-387a-4b94-a796-59eec71a024c'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'Quatrième Ordre, « La Piémontoise » : I. Sonade', part.name_en = 'Les Nations : Quatrième Ordre, « La Piémontoise » : I. Sonade',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 24677 AND p.composer_id = 431 AND part.part_key = 'musicbrainz:25394a23-0649-481a-a5c3-ea174afecfd4' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:25394a23-0649-481a-a5c3-ea174afecfd4', 1, NULL, 'Quatrième Ordre, « La Piémontoise » : I. Sonade', 'Les Nations : Quatrième Ordre, « La Piémontoise » : I. Sonade', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:6c20fa30-387a-4b94-a796-59eec71a024c'
WHERE p.id = 24677 AND p.composer_id = 431
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:25394a23-0649-481a-a5c3-ea174afecfd4'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:6c20fa30-387a-4b94-a796-59eec71a024c'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'Quatrième Ordre, « La Piémontoise » : II. Allemande', part.name_en = 'Les Nations : Quatrième Ordre, « La Piémontoise » : II. Allemande',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 24677 AND p.composer_id = 431 AND part.part_key = 'musicbrainz:12319dc7-a502-43ce-ac42-d399af874306' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:12319dc7-a502-43ce-ac42-d399af874306', 2, NULL, 'Quatrième Ordre, « La Piémontoise » : II. Allemande', 'Les Nations : Quatrième Ordre, « La Piémontoise » : II. Allemande', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:6c20fa30-387a-4b94-a796-59eec71a024c'
WHERE p.id = 24677 AND p.composer_id = 431
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:12319dc7-a502-43ce-ac42-d399af874306'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:6c20fa30-387a-4b94-a796-59eec71a024c'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = NULL,
    part.name_ko = 'Quatrième Ordre, « La Piémontoise » : III. Courante', part.name_en = 'Les Nations : Quatrième Ordre, « La Piémontoise » : III. Courante',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 24677 AND p.composer_id = 431 AND part.part_key = 'musicbrainz:12d12325-eb3f-4704-ac78-37bac58f7651' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:12d12325-eb3f-4704-ac78-37bac58f7651', 3, NULL, 'Quatrième Ordre, « La Piémontoise » : III. Courante', 'Les Nations : Quatrième Ordre, « La Piémontoise » : III. Courante', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:6c20fa30-387a-4b94-a796-59eec71a024c'
WHERE p.id = 24677 AND p.composer_id = 431
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:12d12325-eb3f-4704-ac78-37bac58f7651'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:6c20fa30-387a-4b94-a796-59eec71a024c'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = NULL,
    part.name_ko = 'Quatrième Ordre, « La Piémontoise » : IV. Seconde Courante', part.name_en = 'Les Nations : Quatrième Ordre, « La Piémontoise » : IV. Seconde Courante',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 24677 AND p.composer_id = 431 AND part.part_key = 'musicbrainz:46f95c5f-a10b-4783-9815-c9831379213c' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:46f95c5f-a10b-4783-9815-c9831379213c', 4, NULL, 'Quatrième Ordre, « La Piémontoise » : IV. Seconde Courante', 'Les Nations : Quatrième Ordre, « La Piémontoise » : IV. Seconde Courante', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:6c20fa30-387a-4b94-a796-59eec71a024c'
WHERE p.id = 24677 AND p.composer_id = 431
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:46f95c5f-a10b-4783-9815-c9831379213c'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:6c20fa30-387a-4b94-a796-59eec71a024c'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 5, part.movement_number = NULL,
    part.name_ko = 'Quatrième Ordre, « La Piémontoise » : V. Sarabande', part.name_en = 'Les Nations : Quatrième Ordre, « La Piémontoise » : V. Sarabande',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 24677 AND p.composer_id = 431 AND part.part_key = 'musicbrainz:a7e8d672-f280-4a49-b2cc-1dd2b89c7957' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:a7e8d672-f280-4a49-b2cc-1dd2b89c7957', 5, NULL, 'Quatrième Ordre, « La Piémontoise » : V. Sarabande', 'Les Nations : Quatrième Ordre, « La Piémontoise » : V. Sarabande', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:6c20fa30-387a-4b94-a796-59eec71a024c'
WHERE p.id = 24677 AND p.composer_id = 431
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:a7e8d672-f280-4a49-b2cc-1dd2b89c7957'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:6c20fa30-387a-4b94-a796-59eec71a024c'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 6, part.movement_number = NULL,
    part.name_ko = 'Quatrième Ordre, « La Piémontoise » : VI. Rondeau', part.name_en = 'Les Nations : Quatrième Ordre, « La Piémontoise » : VI. Rondeau',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 24677 AND p.composer_id = 431 AND part.part_key = 'musicbrainz:206dbf35-0821-42b8-ada0-ea70f13516b2' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:206dbf35-0821-42b8-ada0-ea70f13516b2', 6, NULL, 'Quatrième Ordre, « La Piémontoise » : VI. Rondeau', 'Les Nations : Quatrième Ordre, « La Piémontoise » : VI. Rondeau', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:6c20fa30-387a-4b94-a796-59eec71a024c'
WHERE p.id = 24677 AND p.composer_id = 431
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:206dbf35-0821-42b8-ada0-ea70f13516b2'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:6c20fa30-387a-4b94-a796-59eec71a024c'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 7, part.movement_number = NULL,
    part.name_ko = 'Quatrième Ordre, « La Piémontoise » : VII. Gigue', part.name_en = 'Les Nations : Quatrième Ordre, « La Piémontoise » : VII. Gigue',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 24677 AND p.composer_id = 431 AND part.part_key = 'musicbrainz:0625958b-a88e-4dee-b0b9-94a29fdf0a72' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:0625958b-a88e-4dee-b0b9-94a29fdf0a72', 7, NULL, 'Quatrième Ordre, « La Piémontoise » : VII. Gigue', 'Les Nations : Quatrième Ordre, « La Piémontoise » : VII. Gigue', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:6c20fa30-387a-4b94-a796-59eec71a024c'
WHERE p.id = 24677 AND p.composer_id = 431
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:0625958b-a88e-4dee-b0b9-94a29fdf0a72'
);


-- None Les goûts-réunis, ou Nouveaux concerts

UPDATE pieces piece
SET piece.title = 'Les goûts-réunis, ou Nouveaux concerts', piece.title_en = 'Les goûts-réunis, ou Nouveaux concerts',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 23637 AND piece.composer_id = 431
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'Cinquième Concert', part.name_en = 'Les gouts réunis: Cinquième Concert',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 23637 AND p.composer_id = 431 AND part.part_key = 'musicbrainz:92ab4d1f-ad51-48fb-92c3-afc8a3da4b13' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:92ab4d1f-ad51-48fb-92c3-afc8a3da4b13', 1, NULL, 'Cinquième Concert', 'Les gouts réunis: Cinquième Concert', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 23637 AND p.composer_id = 431
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:92ab4d1f-ad51-48fb-92c3-afc8a3da4b13'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:92ab4d1f-ad51-48fb-92c3-afc8a3da4b13'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'Prelude', part.name_en = 'Les gouts réunis: Cinquième Concert: I. Prelude',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 23637 AND p.composer_id = 431 AND part.part_key = 'musicbrainz:736b59bb-0688-4b93-aba8-46393057a24a' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:736b59bb-0688-4b93-aba8-46393057a24a', 1, NULL, 'Prelude', 'Les gouts réunis: Cinquième Concert: I. Prelude', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:92ab4d1f-ad51-48fb-92c3-afc8a3da4b13'
WHERE p.id = 23637 AND p.composer_id = 431
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:736b59bb-0688-4b93-aba8-46393057a24a'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:92ab4d1f-ad51-48fb-92c3-afc8a3da4b13'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'Allemande', part.name_en = 'Les gouts réunis: Cinquième Concert: II. Allemande',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 23637 AND p.composer_id = 431 AND part.part_key = 'musicbrainz:92e8c238-bf11-47ec-8cf8-a755390d4339' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:92e8c238-bf11-47ec-8cf8-a755390d4339', 2, NULL, 'Allemande', 'Les gouts réunis: Cinquième Concert: II. Allemande', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:92ab4d1f-ad51-48fb-92c3-afc8a3da4b13'
WHERE p.id = 23637 AND p.composer_id = 431
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:92e8c238-bf11-47ec-8cf8-a755390d4339'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:92ab4d1f-ad51-48fb-92c3-afc8a3da4b13'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = NULL,
    part.name_ko = 'Sarabande', part.name_en = 'Les gouts réunis: Cinquième Concert: III. Sarabande',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 23637 AND p.composer_id = 431 AND part.part_key = 'musicbrainz:610a7c0c-5eab-4f45-8c0d-27ef2dd64ae6' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:610a7c0c-5eab-4f45-8c0d-27ef2dd64ae6', 3, NULL, 'Sarabande', 'Les gouts réunis: Cinquième Concert: III. Sarabande', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:92ab4d1f-ad51-48fb-92c3-afc8a3da4b13'
WHERE p.id = 23637 AND p.composer_id = 431
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:610a7c0c-5eab-4f45-8c0d-27ef2dd64ae6'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:92ab4d1f-ad51-48fb-92c3-afc8a3da4b13'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = NULL,
    part.name_ko = 'Gavote', part.name_en = 'Les gouts réunis: Cinquième Concert: IV. Gavote',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 23637 AND p.composer_id = 431 AND part.part_key = 'musicbrainz:6aa623b5-2638-41eb-8255-c4d2a418a303' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:6aa623b5-2638-41eb-8255-c4d2a418a303', 4, NULL, 'Gavote', 'Les gouts réunis: Cinquième Concert: IV. Gavote', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:92ab4d1f-ad51-48fb-92c3-afc8a3da4b13'
WHERE p.id = 23637 AND p.composer_id = 431
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:6aa623b5-2638-41eb-8255-c4d2a418a303'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:92ab4d1f-ad51-48fb-92c3-afc8a3da4b13'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 5, part.movement_number = NULL,
    part.name_ko = 'Muséte', part.name_en = 'Les gouts réunis: Cinquième Concert: V. Muséte',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 23637 AND p.composer_id = 431 AND part.part_key = 'musicbrainz:0b679772-b19d-4435-9865-443a0651b828' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:0b679772-b19d-4435-9865-443a0651b828', 5, NULL, 'Muséte', 'Les gouts réunis: Cinquième Concert: V. Muséte', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:92ab4d1f-ad51-48fb-92c3-afc8a3da4b13'
WHERE p.id = 23637 AND p.composer_id = 431
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:0b679772-b19d-4435-9865-443a0651b828'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'Sixième Concert', part.name_en = 'Les goûts-réunis: Sixième Concert',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 23637 AND p.composer_id = 431 AND part.part_key = 'musicbrainz:b571b8e4-de38-4ca1-bb6d-aa8324c83665' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:b571b8e4-de38-4ca1-bb6d-aa8324c83665', 2, NULL, 'Sixième Concert', 'Les goûts-réunis: Sixième Concert', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 23637 AND p.composer_id = 431
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:b571b8e4-de38-4ca1-bb6d-aa8324c83665'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:b571b8e4-de38-4ca1-bb6d-aa8324c83665'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'Gravement et mesure', part.name_en = 'Les goûts-réunis, Sixième Concert: I. Gravement et mesure',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 23637 AND p.composer_id = 431 AND part.part_key = 'musicbrainz:b50c9103-2ead-44c3-ae97-aa430725ad63' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:b50c9103-2ead-44c3-ae97-aa430725ad63', 1, NULL, 'Gravement et mesure', 'Les goûts-réunis, Sixième Concert: I. Gravement et mesure', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:b571b8e4-de38-4ca1-bb6d-aa8324c83665'
WHERE p.id = 23637 AND p.composer_id = 431
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:b50c9103-2ead-44c3-ae97-aa430725ad63'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:b571b8e4-de38-4ca1-bb6d-aa8324c83665'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'Allemande', part.name_en = 'Les goûts-réunis, Sixième Concert: II. Allemande',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 23637 AND p.composer_id = 431 AND part.part_key = 'musicbrainz:54aa0551-54dd-49eb-bd10-ca9ffb480218' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:54aa0551-54dd-49eb-bd10-ca9ffb480218', 2, NULL, 'Allemande', 'Les goûts-réunis, Sixième Concert: II. Allemande', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:b571b8e4-de38-4ca1-bb6d-aa8324c83665'
WHERE p.id = 23637 AND p.composer_id = 431
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:54aa0551-54dd-49eb-bd10-ca9ffb480218'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:b571b8e4-de38-4ca1-bb6d-aa8324c83665'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = NULL,
    part.name_ko = 'Sarabande', part.name_en = 'Les goûts-réunis, Sixième Concert: III. Sarabande',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 23637 AND p.composer_id = 431 AND part.part_key = 'musicbrainz:32419589-3670-49d0-8765-a3a489d4cbb0' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:32419589-3670-49d0-8765-a3a489d4cbb0', 3, NULL, 'Sarabande', 'Les goûts-réunis, Sixième Concert: III. Sarabande', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:b571b8e4-de38-4ca1-bb6d-aa8324c83665'
WHERE p.id = 23637 AND p.composer_id = 431
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:32419589-3670-49d0-8765-a3a489d4cbb0'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:b571b8e4-de38-4ca1-bb6d-aa8324c83665'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = NULL,
    part.name_ko = 'Air de Diable', part.name_en = 'Les goûts-réunis, Sixième Concert: IV. Air de Diable',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 23637 AND p.composer_id = 431 AND part.part_key = 'musicbrainz:1ab013b8-86e8-45ef-8042-31827519cd99' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:1ab013b8-86e8-45ef-8042-31827519cd99', 4, NULL, 'Air de Diable', 'Les goûts-réunis, Sixième Concert: IV. Air de Diable', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:b571b8e4-de38-4ca1-bb6d-aa8324c83665'
WHERE p.id = 23637 AND p.composer_id = 431
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:1ab013b8-86e8-45ef-8042-31827519cd99'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:b571b8e4-de38-4ca1-bb6d-aa8324c83665'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 5, part.movement_number = NULL,
    part.name_ko = 'Siciliéne', part.name_en = 'Les goûts-réunis, Sixième Concert: V. Siciliéne',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 23637 AND p.composer_id = 431 AND part.part_key = 'musicbrainz:35040323-3bd0-497d-9fa2-e818084490f4' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:35040323-3bd0-497d-9fa2-e818084490f4', 5, NULL, 'Siciliéne', 'Les goûts-réunis, Sixième Concert: V. Siciliéne', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:b571b8e4-de38-4ca1-bb6d-aa8324c83665'
WHERE p.id = 23637 AND p.composer_id = 431
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:35040323-3bd0-497d-9fa2-e818084490f4'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = NULL,
    part.name_ko = 'Septième Concert', part.name_en = 'Les goûts-réunis: Septième Concert',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 23637 AND p.composer_id = 431 AND part.part_key = 'musicbrainz:8ff2d4fb-0f09-444d-b238-338496c52785' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:8ff2d4fb-0f09-444d-b238-338496c52785', 3, NULL, 'Septième Concert', 'Les goûts-réunis: Septième Concert', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 23637 AND p.composer_id = 431
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:8ff2d4fb-0f09-444d-b238-338496c52785'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:8ff2d4fb-0f09-444d-b238-338496c52785'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'Gravement et gracieusement', part.name_en = 'Les goûts-réunis, Septième Concert: I. Gravement et gracieusement',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 23637 AND p.composer_id = 431 AND part.part_key = 'musicbrainz:0c042566-72a6-4b53-ac3d-3e6e2f94f522' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:0c042566-72a6-4b53-ac3d-3e6e2f94f522', 1, NULL, 'Gravement et gracieusement', 'Les goûts-réunis, Septième Concert: I. Gravement et gracieusement', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:8ff2d4fb-0f09-444d-b238-338496c52785'
WHERE p.id = 23637 AND p.composer_id = 431
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:0c042566-72a6-4b53-ac3d-3e6e2f94f522'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:8ff2d4fb-0f09-444d-b238-338496c52785'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'Allemande', part.name_en = 'Les goûts-réunis, Septième Concert: II. Allemande',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 23637 AND p.composer_id = 431 AND part.part_key = 'musicbrainz:a8439a00-d25d-4038-9fcd-867a736e6718' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:a8439a00-d25d-4038-9fcd-867a736e6718', 2, NULL, 'Allemande', 'Les goûts-réunis, Septième Concert: II. Allemande', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:8ff2d4fb-0f09-444d-b238-338496c52785'
WHERE p.id = 23637 AND p.composer_id = 431
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:a8439a00-d25d-4038-9fcd-867a736e6718'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:8ff2d4fb-0f09-444d-b238-338496c52785'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = NULL,
    part.name_ko = 'Sarabande', part.name_en = 'Les goûts-réunis, Septième Concert: III. Sarabande',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 23637 AND p.composer_id = 431 AND part.part_key = 'musicbrainz:a4b1f484-f6c8-4bcb-9b94-724d9c1c14c1' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:a4b1f484-f6c8-4bcb-9b94-724d9c1c14c1', 3, NULL, 'Sarabande', 'Les goûts-réunis, Septième Concert: III. Sarabande', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:8ff2d4fb-0f09-444d-b238-338496c52785'
WHERE p.id = 23637 AND p.composer_id = 431
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:a4b1f484-f6c8-4bcb-9b94-724d9c1c14c1'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:8ff2d4fb-0f09-444d-b238-338496c52785'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = NULL,
    part.name_ko = 'Fuguéte', part.name_en = 'Les goûts-réunis, Septième Concert: IV. Fuguéte',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 23637 AND p.composer_id = 431 AND part.part_key = 'musicbrainz:3ee3e9fa-989c-47dd-aa6a-a6556175e4ec' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:3ee3e9fa-989c-47dd-aa6a-a6556175e4ec', 4, NULL, 'Fuguéte', 'Les goûts-réunis, Septième Concert: IV. Fuguéte', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:8ff2d4fb-0f09-444d-b238-338496c52785'
WHERE p.id = 23637 AND p.composer_id = 431
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:3ee3e9fa-989c-47dd-aa6a-a6556175e4ec'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:8ff2d4fb-0f09-444d-b238-338496c52785'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 5, part.movement_number = NULL,
    part.name_ko = 'Gavote', part.name_en = 'Les goûts-réunis, Septième Concert: V. Gavote',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 23637 AND p.composer_id = 431 AND part.part_key = 'musicbrainz:ecd58d80-f5a3-4d8e-9d9a-afa89754f732' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:ecd58d80-f5a3-4d8e-9d9a-afa89754f732', 5, NULL, 'Gavote', 'Les goûts-réunis, Septième Concert: V. Gavote', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:8ff2d4fb-0f09-444d-b238-338496c52785'
WHERE p.id = 23637 AND p.composer_id = 431
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:ecd58d80-f5a3-4d8e-9d9a-afa89754f732'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:8ff2d4fb-0f09-444d-b238-338496c52785'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 6, part.movement_number = NULL,
    part.name_ko = 'Siciliéne', part.name_en = 'Les goûts-réunis, Septième Concert: VI. Siciliéne',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 23637 AND p.composer_id = 431 AND part.part_key = 'musicbrainz:2538c4cc-5428-4a67-a0ce-b792b73ac733' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:2538c4cc-5428-4a67-a0ce-b792b73ac733', 6, NULL, 'Siciliéne', 'Les goûts-réunis, Septième Concert: VI. Siciliéne', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:8ff2d4fb-0f09-444d-b238-338496c52785'
WHERE p.id = 23637 AND p.composer_id = 431
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:2538c4cc-5428-4a67-a0ce-b792b73ac733'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = NULL,
    part.name_ko = 'Huitième Concert', part.name_en = 'Les goûts-réunis: Huitième Concert',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 23637 AND p.composer_id = 431 AND part.part_key = 'musicbrainz:2dd7f45f-6ccb-42d1-bfc1-e62e600fcd64' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:2dd7f45f-6ccb-42d1-bfc1-e62e600fcd64', 4, NULL, 'Huitième Concert', 'Les goûts-réunis: Huitième Concert', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 23637 AND p.composer_id = 431
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:2dd7f45f-6ccb-42d1-bfc1-e62e600fcd64'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:2dd7f45f-6ccb-42d1-bfc1-e62e600fcd64'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'Ouverture', part.name_en = 'Les goûts-réunis: Huitième Concert: I. Ouverture',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 23637 AND p.composer_id = 431 AND part.part_key = 'musicbrainz:668d7a84-6bca-4e67-9629-70056e7728ab' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:668d7a84-6bca-4e67-9629-70056e7728ab', 1, NULL, 'Ouverture', 'Les goûts-réunis: Huitième Concert: I. Ouverture', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:2dd7f45f-6ccb-42d1-bfc1-e62e600fcd64'
WHERE p.id = 23637 AND p.composer_id = 431
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:668d7a84-6bca-4e67-9629-70056e7728ab'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:2dd7f45f-6ccb-42d1-bfc1-e62e600fcd64'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'Grande Ritournéle. Gravement', part.name_en = 'Les goûts-réunis: Huitième Concert: II. Grande Ritournéle. Gravement',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 23637 AND p.composer_id = 431 AND part.part_key = 'musicbrainz:056ac927-f8ac-4520-b1a6-7b5926796862' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:056ac927-f8ac-4520-b1a6-7b5926796862', 2, NULL, 'Grande Ritournéle. Gravement', 'Les goûts-réunis: Huitième Concert: II. Grande Ritournéle. Gravement', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:2dd7f45f-6ccb-42d1-bfc1-e62e600fcd64'
WHERE p.id = 23637 AND p.composer_id = 431
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:056ac927-f8ac-4520-b1a6-7b5926796862'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:2dd7f45f-6ccb-42d1-bfc1-e62e600fcd64'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = NULL,
    part.name_ko = 'Air. Noblement', part.name_en = 'Les goûts-réunis: Huitième Concert: III. Air. Noblement',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 23637 AND p.composer_id = 431 AND part.part_key = 'musicbrainz:911a192d-6789-47aa-afba-74f2528a4e14' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:911a192d-6789-47aa-afba-74f2528a4e14', 3, NULL, 'Air. Noblement', 'Les goûts-réunis: Huitième Concert: III. Air. Noblement', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:2dd7f45f-6ccb-42d1-bfc1-e62e600fcd64'
WHERE p.id = 23637 AND p.composer_id = 431
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:911a192d-6789-47aa-afba-74f2528a4e14'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:2dd7f45f-6ccb-42d1-bfc1-e62e600fcd64'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = NULL,
    part.name_ko = 'Air tendre. Rondeau – Air léger', part.name_en = 'Les goûts-réunis: Huitième Concert: IV. Air tendre. Rondeau – Air léger',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 23637 AND p.composer_id = 431 AND part.part_key = 'musicbrainz:240efdf9-8e00-42c9-a1a1-798816ccc3e0' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:240efdf9-8e00-42c9-a1a1-798816ccc3e0', 4, NULL, 'Air tendre. Rondeau – Air léger', 'Les goûts-réunis: Huitième Concert: IV. Air tendre. Rondeau – Air léger', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:2dd7f45f-6ccb-42d1-bfc1-e62e600fcd64'
WHERE p.id = 23637 AND p.composer_id = 431
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:240efdf9-8e00-42c9-a1a1-798816ccc3e0'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:2dd7f45f-6ccb-42d1-bfc1-e62e600fcd64'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 5, part.movement_number = NULL,
    part.name_ko = 'Loure. Pesament', part.name_en = 'Les goûts-réunis: Huitième Concert: V. Loure. Pesament',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 23637 AND p.composer_id = 431 AND part.part_key = 'musicbrainz:91b3ff12-6e31-4687-b4d9-618e9bff38ff' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:91b3ff12-6e31-4687-b4d9-618e9bff38ff', 5, NULL, 'Loure. Pesament', 'Les goûts-réunis: Huitième Concert: V. Loure. Pesament', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:2dd7f45f-6ccb-42d1-bfc1-e62e600fcd64'
WHERE p.id = 23637 AND p.composer_id = 431
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:91b3ff12-6e31-4687-b4d9-618e9bff38ff'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:2dd7f45f-6ccb-42d1-bfc1-e62e600fcd64'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 6, part.movement_number = NULL,
    part.name_ko = 'Air. Animé et léger – Sarabande. Grave et tendre', part.name_en = 'Les goûts-réunis: Huitième Concert: VI. Air. Animé et léger – Sarabande. Grave et tendre',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 23637 AND p.composer_id = 431 AND part.part_key = 'musicbrainz:bfb9a922-b1e3-4689-b9c1-b79081120299' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:bfb9a922-b1e3-4689-b9c1-b79081120299', 6, NULL, 'Air. Animé et léger – Sarabande. Grave et tendre', 'Les goûts-réunis: Huitième Concert: VI. Air. Animé et léger – Sarabande. Grave et tendre', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:2dd7f45f-6ccb-42d1-bfc1-e62e600fcd64'
WHERE p.id = 23637 AND p.composer_id = 431
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:bfb9a922-b1e3-4689-b9c1-b79081120299'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:2dd7f45f-6ccb-42d1-bfc1-e62e600fcd64'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 7, part.movement_number = NULL,
    part.name_ko = 'Air léger – Air tendre. Lentement', part.name_en = 'Les goûts-réunis: Huitième Concert: VII. Air léger – Air tendre. Lentement',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 23637 AND p.composer_id = 431 AND part.part_key = 'musicbrainz:88ad7ea3-b96a-490e-a92b-a3a4825e8e0d' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:88ad7ea3-b96a-490e-a92b-a3a4825e8e0d', 7, NULL, 'Air léger – Air tendre. Lentement', 'Les goûts-réunis: Huitième Concert: VII. Air léger – Air tendre. Lentement', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:2dd7f45f-6ccb-42d1-bfc1-e62e600fcd64'
WHERE p.id = 23637 AND p.composer_id = 431
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:88ad7ea3-b96a-490e-a92b-a3a4825e8e0d'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:2dd7f45f-6ccb-42d1-bfc1-e62e600fcd64'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 8, part.movement_number = NULL,
    part.name_ko = 'Air de Baccantes. Très animé', part.name_en = 'Les goûts-réunis: Huitième Concert: VIII. Air de Baccantes. Très animé',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 23637 AND p.composer_id = 431 AND part.part_key = 'musicbrainz:2b52b3a3-b159-4f41-a918-7266ca9971f0' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:2b52b3a3-b159-4f41-a918-7266ca9971f0', 8, NULL, 'Air de Baccantes. Très animé', 'Les goûts-réunis: Huitième Concert: VIII. Air de Baccantes. Très animé', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:2dd7f45f-6ccb-42d1-bfc1-e62e600fcd64'
WHERE p.id = 23637 AND p.composer_id = 431
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:2b52b3a3-b159-4f41-a918-7266ca9971f0'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 5, part.movement_number = NULL,
    part.name_ko = 'Neuvième Concert', part.name_en = 'Les goûts-réunis: Neuvième Concert',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 23637 AND p.composer_id = 431 AND part.part_key = 'musicbrainz:a57334c2-03cf-4cce-9df8-69b4afc96b34' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:a57334c2-03cf-4cce-9df8-69b4afc96b34', 5, NULL, 'Neuvième Concert', 'Les goûts-réunis: Neuvième Concert', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 23637 AND p.composer_id = 431
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:a57334c2-03cf-4cce-9df8-69b4afc96b34'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:a57334c2-03cf-4cce-9df8-69b4afc96b34'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'Le charmé', part.name_en = 'Les goûts-réunis: Neuvième Concert: I. Le charmé',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 23637 AND p.composer_id = 431 AND part.part_key = 'musicbrainz:80feaef0-aa35-4539-9aef-f51d173a61fc' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:80feaef0-aa35-4539-9aef-f51d173a61fc', 1, NULL, 'Le charmé', 'Les goûts-réunis: Neuvième Concert: I. Le charmé', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:a57334c2-03cf-4cce-9df8-69b4afc96b34'
WHERE p.id = 23637 AND p.composer_id = 431
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:80feaef0-aa35-4539-9aef-f51d173a61fc'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:a57334c2-03cf-4cce-9df8-69b4afc96b34'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'L''enjoüement', part.name_en = 'Les goûts-réunis: Neuvième Concert: II. L''enjoüement',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 23637 AND p.composer_id = 431 AND part.part_key = 'musicbrainz:89e1b54f-7090-4b51-bcff-1e006892b0f0' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:89e1b54f-7090-4b51-bcff-1e006892b0f0', 2, NULL, 'L''enjoüement', 'Les goûts-réunis: Neuvième Concert: II. L''enjoüement', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:a57334c2-03cf-4cce-9df8-69b4afc96b34'
WHERE p.id = 23637 AND p.composer_id = 431
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:89e1b54f-7090-4b51-bcff-1e006892b0f0'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:a57334c2-03cf-4cce-9df8-69b4afc96b34'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = NULL,
    part.name_ko = 'Les graces', part.name_en = 'Les goûts-réunis: Neuvième Concert: III. Les graces',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 23637 AND p.composer_id = 431 AND part.part_key = 'musicbrainz:73e27a37-13eb-4fc8-9964-ffe71ff3cc53' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:73e27a37-13eb-4fc8-9964-ffe71ff3cc53', 3, NULL, 'Les graces', 'Les goûts-réunis: Neuvième Concert: III. Les graces', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:a57334c2-03cf-4cce-9df8-69b4afc96b34'
WHERE p.id = 23637 AND p.composer_id = 431
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:73e27a37-13eb-4fc8-9964-ffe71ff3cc53'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:a57334c2-03cf-4cce-9df8-69b4afc96b34'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = NULL,
    part.name_ko = 'Le je-ne Scay-quoy', part.name_en = 'Les goûts-réunis: Neuvième Concert: IV. Le je-ne Scay-quoy',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 23637 AND p.composer_id = 431 AND part.part_key = 'musicbrainz:8724291f-1dd3-4278-9155-e02fd699daea' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:8724291f-1dd3-4278-9155-e02fd699daea', 4, NULL, 'Le je-ne Scay-quoy', 'Les goûts-réunis: Neuvième Concert: IV. Le je-ne Scay-quoy', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:a57334c2-03cf-4cce-9df8-69b4afc96b34'
WHERE p.id = 23637 AND p.composer_id = 431
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:8724291f-1dd3-4278-9155-e02fd699daea'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:a57334c2-03cf-4cce-9df8-69b4afc96b34'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 5, part.movement_number = NULL,
    part.name_ko = 'La vivacité', part.name_en = 'Les goûts-réunis: Neuvième Concert: V. La vivacité',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 23637 AND p.composer_id = 431 AND part.part_key = 'musicbrainz:24ebb5c3-3f50-4e0b-9cdb-cd50985f01c1' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:24ebb5c3-3f50-4e0b-9cdb-cd50985f01c1', 5, NULL, 'La vivacité', 'Les goûts-réunis: Neuvième Concert: V. La vivacité', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:a57334c2-03cf-4cce-9df8-69b4afc96b34'
WHERE p.id = 23637 AND p.composer_id = 431
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:24ebb5c3-3f50-4e0b-9cdb-cd50985f01c1'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:a57334c2-03cf-4cce-9df8-69b4afc96b34'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 6, part.movement_number = NULL,
    part.name_ko = 'La noble fierté', part.name_en = 'Les goûts-réunis: Neuvième Concert: VI. La noble fierté',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 23637 AND p.composer_id = 431 AND part.part_key = 'musicbrainz:b19192ac-ed81-448e-b8c6-491721ac40d1' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:b19192ac-ed81-448e-b8c6-491721ac40d1', 6, NULL, 'La noble fierté', 'Les goûts-réunis: Neuvième Concert: VI. La noble fierté', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:a57334c2-03cf-4cce-9df8-69b4afc96b34'
WHERE p.id = 23637 AND p.composer_id = 431
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:b19192ac-ed81-448e-b8c6-491721ac40d1'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:a57334c2-03cf-4cce-9df8-69b4afc96b34'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 7, part.movement_number = NULL,
    part.name_ko = 'La douceur', part.name_en = 'Les goûts-réunis: Neuvième Concert: VII. La douceur',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 23637 AND p.composer_id = 431 AND part.part_key = 'musicbrainz:fc9eb85b-479a-4384-b9e6-609a9aa4aaad' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:fc9eb85b-479a-4384-b9e6-609a9aa4aaad', 7, NULL, 'La douceur', 'Les goûts-réunis: Neuvième Concert: VII. La douceur', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:a57334c2-03cf-4cce-9df8-69b4afc96b34'
WHERE p.id = 23637 AND p.composer_id = 431
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:fc9eb85b-479a-4384-b9e6-609a9aa4aaad'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:a57334c2-03cf-4cce-9df8-69b4afc96b34'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 8, part.movement_number = NULL,
    part.name_ko = 'L'' et Coetera', part.name_en = 'Les goûts-réunis: Neuvième Concert: VIII. L'' et Coetera',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 23637 AND p.composer_id = 431 AND part.part_key = 'musicbrainz:d1dca87c-370e-481f-b10d-7d59b1104cc4' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:d1dca87c-370e-481f-b10d-7d59b1104cc4', 8, NULL, 'L'' et Coetera', 'Les goûts-réunis: Neuvième Concert: VIII. L'' et Coetera', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:a57334c2-03cf-4cce-9df8-69b4afc96b34'
WHERE p.id = 23637 AND p.composer_id = 431
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:d1dca87c-370e-481f-b10d-7d59b1104cc4'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 6, part.movement_number = NULL,
    part.name_ko = 'Dixième Concert', part.name_en = 'Les goûts-réunis: Dixième Concert',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 23637 AND p.composer_id = 431 AND part.part_key = 'musicbrainz:0ae9dfd8-d9a1-47d9-8bfd-216e1ef7d2c5' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:0ae9dfd8-d9a1-47d9-8bfd-216e1ef7d2c5', 6, NULL, 'Dixième Concert', 'Les goûts-réunis: Dixième Concert', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 23637 AND p.composer_id = 431
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:0ae9dfd8-d9a1-47d9-8bfd-216e1ef7d2c5'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:0ae9dfd8-d9a1-47d9-8bfd-216e1ef7d2c5'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'Gravement et mesure', part.name_en = 'Les goûts-réunis, Dixième Concert: I. Gravement et mesure',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 23637 AND p.composer_id = 431 AND part.part_key = 'musicbrainz:c9475158-b08f-4616-b455-668005908628' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:c9475158-b08f-4616-b455-668005908628', 1, NULL, 'Gravement et mesure', 'Les goûts-réunis, Dixième Concert: I. Gravement et mesure', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:0ae9dfd8-d9a1-47d9-8bfd-216e1ef7d2c5'
WHERE p.id = 23637 AND p.composer_id = 431
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:c9475158-b08f-4616-b455-668005908628'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:0ae9dfd8-d9a1-47d9-8bfd-216e1ef7d2c5'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'Plainte pour les violes', part.name_en = 'Les goûts-réunis, Dixième Concert: II. Plainte pour les violes',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 23637 AND p.composer_id = 431 AND part.part_key = 'musicbrainz:e4fc8406-aa23-48d9-9409-27e664ef61ea' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:e4fc8406-aa23-48d9-9409-27e664ef61ea', 2, NULL, 'Plainte pour les violes', 'Les goûts-réunis, Dixième Concert: II. Plainte pour les violes', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:0ae9dfd8-d9a1-47d9-8bfd-216e1ef7d2c5'
WHERE p.id = 23637 AND p.composer_id = 431
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:e4fc8406-aa23-48d9-9409-27e664ef61ea'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:0ae9dfd8-d9a1-47d9-8bfd-216e1ef7d2c5'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = NULL,
    part.name_ko = 'La tromba', part.name_en = 'Les goûts-réunis, Dixième Concert: III. La tromba',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 23637 AND p.composer_id = 431 AND part.part_key = 'musicbrainz:83119dfd-dbe4-4ba2-9332-9c53ec54c0cb' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:83119dfd-dbe4-4ba2-9332-9c53ec54c0cb', 3, NULL, 'La tromba', 'Les goûts-réunis, Dixième Concert: III. La tromba', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:0ae9dfd8-d9a1-47d9-8bfd-216e1ef7d2c5'
WHERE p.id = 23637 AND p.composer_id = 431
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:83119dfd-dbe4-4ba2-9332-9c53ec54c0cb'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 7, part.movement_number = NULL,
    part.name_ko = 'Onzième Concert', part.name_en = 'Les goûts-réunis: Onzième Concert',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 23637 AND p.composer_id = 431 AND part.part_key = 'musicbrainz:9de97c11-6b4e-4b6d-a218-9d9879f76cbc' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:9de97c11-6b4e-4b6d-a218-9d9879f76cbc', 7, NULL, 'Onzième Concert', 'Les goûts-réunis: Onzième Concert', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 23637 AND p.composer_id = 431
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:9de97c11-6b4e-4b6d-a218-9d9879f76cbc'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:9de97c11-6b4e-4b6d-a218-9d9879f76cbc'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'Majestuesement', part.name_en = 'Les goûts-réunis: Onzième Concert: I. Majestuesement',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 23637 AND p.composer_id = 431 AND part.part_key = 'musicbrainz:b1229a25-8966-4893-a71a-f9b77085a219' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:b1229a25-8966-4893-a71a-f9b77085a219', 1, NULL, 'Majestuesement', 'Les goûts-réunis: Onzième Concert: I. Majestuesement', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:9de97c11-6b4e-4b6d-a218-9d9879f76cbc'
WHERE p.id = 23637 AND p.composer_id = 431
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:b1229a25-8966-4893-a71a-f9b77085a219'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:9de97c11-6b4e-4b6d-a218-9d9879f76cbc'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'Allemande', part.name_en = 'Les goûts-réunis: Onzième Concert: II. Allemande',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 23637 AND p.composer_id = 431 AND part.part_key = 'musicbrainz:eda8eb1c-e4bb-42af-a1c0-b16231b70cdd' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:eda8eb1c-e4bb-42af-a1c0-b16231b70cdd', 2, NULL, 'Allemande', 'Les goûts-réunis: Onzième Concert: II. Allemande', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:9de97c11-6b4e-4b6d-a218-9d9879f76cbc'
WHERE p.id = 23637 AND p.composer_id = 431
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:eda8eb1c-e4bb-42af-a1c0-b16231b70cdd'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:9de97c11-6b4e-4b6d-a218-9d9879f76cbc'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = NULL,
    part.name_ko = 'Second Allemande', part.name_en = 'Les goûts-réunis: Onzième Concert: III. Second Allemande',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 23637 AND p.composer_id = 431 AND part.part_key = 'musicbrainz:fe9655d7-4f45-4f59-a893-d226e74302e8' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:fe9655d7-4f45-4f59-a893-d226e74302e8', 3, NULL, 'Second Allemande', 'Les goûts-réunis: Onzième Concert: III. Second Allemande', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:9de97c11-6b4e-4b6d-a218-9d9879f76cbc'
WHERE p.id = 23637 AND p.composer_id = 431
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:fe9655d7-4f45-4f59-a893-d226e74302e8'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:9de97c11-6b4e-4b6d-a218-9d9879f76cbc'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = NULL,
    part.name_ko = 'Courante', part.name_en = 'Les goûts-réunis: Onzième Concert: IV. Courante',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 23637 AND p.composer_id = 431 AND part.part_key = 'musicbrainz:a936943d-c096-448a-b91f-05d19ed7f815' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:a936943d-c096-448a-b91f-05d19ed7f815', 4, NULL, 'Courante', 'Les goûts-réunis: Onzième Concert: IV. Courante', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:9de97c11-6b4e-4b6d-a218-9d9879f76cbc'
WHERE p.id = 23637 AND p.composer_id = 431
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:a936943d-c096-448a-b91f-05d19ed7f815'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:9de97c11-6b4e-4b6d-a218-9d9879f76cbc'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 5, part.movement_number = NULL,
    part.name_ko = 'Sarabande', part.name_en = 'Les goûts-réunis: Onzième Concert: V. Sarabande',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 23637 AND p.composer_id = 431 AND part.part_key = 'musicbrainz:431f8f7c-2395-44da-a78e-5ec4168b5be2' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:431f8f7c-2395-44da-a78e-5ec4168b5be2', 5, NULL, 'Sarabande', 'Les goûts-réunis: Onzième Concert: V. Sarabande', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:9de97c11-6b4e-4b6d-a218-9d9879f76cbc'
WHERE p.id = 23637 AND p.composer_id = 431
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:431f8f7c-2395-44da-a78e-5ec4168b5be2'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:9de97c11-6b4e-4b6d-a218-9d9879f76cbc'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 6, part.movement_number = NULL,
    part.name_ko = 'Gigue', part.name_en = 'Les goûts-réunis: Onzième Concert: VI. Gigue',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 23637 AND p.composer_id = 431 AND part.part_key = 'musicbrainz:c2a83138-a37a-4545-80a6-839f8f2e41d4' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:c2a83138-a37a-4545-80a6-839f8f2e41d4', 6, NULL, 'Gigue', 'Les goûts-réunis: Onzième Concert: VI. Gigue', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:9de97c11-6b4e-4b6d-a218-9d9879f76cbc'
WHERE p.id = 23637 AND p.composer_id = 431
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:c2a83138-a37a-4545-80a6-839f8f2e41d4'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:9de97c11-6b4e-4b6d-a218-9d9879f76cbc'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 7, part.movement_number = NULL,
    part.name_ko = 'Rondeau', part.name_en = 'Les goûts-réunis: Onzième Concert: VII. Rondeau',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 23637 AND p.composer_id = 431 AND part.part_key = 'musicbrainz:4a46cdc8-68b3-4c7d-aae3-cf6ab7d77a9c' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:4a46cdc8-68b3-4c7d-aae3-cf6ab7d77a9c', 7, NULL, 'Rondeau', 'Les goûts-réunis: Onzième Concert: VII. Rondeau', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:9de97c11-6b4e-4b6d-a218-9d9879f76cbc'
WHERE p.id = 23637 AND p.composer_id = 431
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:4a46cdc8-68b3-4c7d-aae3-cf6ab7d77a9c'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 8, part.movement_number = NULL,
    part.name_ko = 'Douzième Concert', part.name_en = 'Les goûts-réunis: Douzième Concert',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 23637 AND p.composer_id = 431 AND part.part_key = 'musicbrainz:fe784a09-a64b-4a23-968f-7bb7f7b9619f' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:fe784a09-a64b-4a23-968f-7bb7f7b9619f', 8, NULL, 'Douzième Concert', 'Les goûts-réunis: Douzième Concert', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 23637 AND p.composer_id = 431
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:fe784a09-a64b-4a23-968f-7bb7f7b9619f'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:fe784a09-a64b-4a23-968f-7bb7f7b9619f'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = '[no tempo given]', part.name_en = 'Les goûts-réunis: Douzième Concert: I. [no tempo given]',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 23637 AND p.composer_id = 431 AND part.part_key = 'musicbrainz:8cec694a-ef4a-4d35-b673-d981134e7ab2' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:8cec694a-ef4a-4d35-b673-d981134e7ab2', 1, NULL, '[no tempo given]', 'Les goûts-réunis: Douzième Concert: I. [no tempo given]', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:fe784a09-a64b-4a23-968f-7bb7f7b9619f'
WHERE p.id = 23637 AND p.composer_id = 431
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:8cec694a-ef4a-4d35-b673-d981134e7ab2'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:fe784a09-a64b-4a23-968f-7bb7f7b9619f'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'Badinage', part.name_en = 'Les goûts-réunis: Douzième Concert: II. Badinage',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 23637 AND p.composer_id = 431 AND part.part_key = 'musicbrainz:42c72238-2994-4d7a-ad85-1bb82f7b69af' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:42c72238-2994-4d7a-ad85-1bb82f7b69af', 2, NULL, 'Badinage', 'Les goûts-réunis: Douzième Concert: II. Badinage', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:fe784a09-a64b-4a23-968f-7bb7f7b9619f'
WHERE p.id = 23637 AND p.composer_id = 431
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:42c72238-2994-4d7a-ad85-1bb82f7b69af'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:fe784a09-a64b-4a23-968f-7bb7f7b9619f'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = NULL,
    part.name_ko = 'Lentement et pathétiquement', part.name_en = 'Les goûts-réunis: Douzième Concert: III. Lentement et pathétiquement',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 23637 AND p.composer_id = 431 AND part.part_key = 'musicbrainz:4c407ba2-ca6b-4247-af60-265f16307336' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:4c407ba2-ca6b-4247-af60-265f16307336', 3, NULL, 'Lentement et pathétiquement', 'Les goûts-réunis: Douzième Concert: III. Lentement et pathétiquement', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:fe784a09-a64b-4a23-968f-7bb7f7b9619f'
WHERE p.id = 23637 AND p.composer_id = 431
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:4c407ba2-ca6b-4247-af60-265f16307336'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:fe784a09-a64b-4a23-968f-7bb7f7b9619f'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = NULL,
    part.name_ko = 'Air', part.name_en = 'Les goûts-réunis: Douzième Concert: IV. Air',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 23637 AND p.composer_id = 431 AND part.part_key = 'musicbrainz:6b6d005e-25e2-41e3-af20-620558667835' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:6b6d005e-25e2-41e3-af20-620558667835', 4, NULL, 'Air', 'Les goûts-réunis: Douzième Concert: IV. Air', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:fe784a09-a64b-4a23-968f-7bb7f7b9619f'
WHERE p.id = 23637 AND p.composer_id = 431
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:6b6d005e-25e2-41e3-af20-620558667835'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 9, part.movement_number = NULL,
    part.name_ko = 'Treizième Concert', part.name_en = 'Les goûts-réunis: Treizième Concert',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 23637 AND p.composer_id = 431 AND part.part_key = 'musicbrainz:74349b6d-b399-4abf-b642-d98522a11159' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:74349b6d-b399-4abf-b642-d98522a11159', 9, NULL, 'Treizième Concert', 'Les goûts-réunis: Treizième Concert', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 23637 AND p.composer_id = 431
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:74349b6d-b399-4abf-b642-d98522a11159'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:74349b6d-b399-4abf-b642-d98522a11159'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'Treizième Concert in G major: I. Prélude', part.name_en = 'Les Goûts-réunis: Treizième Concert in G major: I. Prélude',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 23637 AND p.composer_id = 431 AND part.part_key = 'musicbrainz:7dc0249d-2e2b-3af4-974e-803d10bf21ed' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:7dc0249d-2e2b-3af4-974e-803d10bf21ed', 1, NULL, 'Treizième Concert in G major: I. Prélude', 'Les Goûts-réunis: Treizième Concert in G major: I. Prélude', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:74349b6d-b399-4abf-b642-d98522a11159'
WHERE p.id = 23637 AND p.composer_id = 431
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:7dc0249d-2e2b-3af4-974e-803d10bf21ed'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:74349b6d-b399-4abf-b642-d98522a11159'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'Treizième Concert in G major: II. Air', part.name_en = 'Les Goûts-réunis: Treizième Concert in G major: II. Air',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 23637 AND p.composer_id = 431 AND part.part_key = 'musicbrainz:79a01ca6-596c-3cd9-b75e-27c37784ffcd' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:79a01ca6-596c-3cd9-b75e-27c37784ffcd', 2, NULL, 'Treizième Concert in G major: II. Air', 'Les Goûts-réunis: Treizième Concert in G major: II. Air', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:74349b6d-b399-4abf-b642-d98522a11159'
WHERE p.id = 23637 AND p.composer_id = 431
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:79a01ca6-596c-3cd9-b75e-27c37784ffcd'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:74349b6d-b399-4abf-b642-d98522a11159'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = NULL,
    part.name_ko = 'Treizième Concert in G major: III. Sarabande', part.name_en = 'Les Goûts-réunis: Treizième Concert in G major: III. Sarabande',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 23637 AND p.composer_id = 431 AND part.part_key = 'musicbrainz:9a615dcb-5b24-36a2-95d0-05dfd5a2c2e3' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:9a615dcb-5b24-36a2-95d0-05dfd5a2c2e3', 3, NULL, 'Treizième Concert in G major: III. Sarabande', 'Les Goûts-réunis: Treizième Concert in G major: III. Sarabande', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:74349b6d-b399-4abf-b642-d98522a11159'
WHERE p.id = 23637 AND p.composer_id = 431
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:9a615dcb-5b24-36a2-95d0-05dfd5a2c2e3'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:74349b6d-b399-4abf-b642-d98522a11159'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = NULL,
    part.name_ko = 'Treizième Concert in G major: IV. Chaconne légère', part.name_en = 'Les Goûts-réunis: Treizième Concert in G major: IV. Chaconne légère',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 23637 AND p.composer_id = 431 AND part.part_key = 'musicbrainz:c13bff4e-5eeb-3074-a4e9-9df4c4f67f10' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:c13bff4e-5eeb-3074-a4e9-9df4c4f67f10', 4, NULL, 'Treizième Concert in G major: IV. Chaconne légère', 'Les Goûts-réunis: Treizième Concert in G major: IV. Chaconne légère', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:74349b6d-b399-4abf-b642-d98522a11159'
WHERE p.id = 23637 AND p.composer_id = 431
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:c13bff4e-5eeb-3074-a4e9-9df4c4f67f10'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 10, part.movement_number = NULL,
    part.name_ko = 'Quatorzième Concert', part.name_en = 'Les goûts-réunis: Quatorzième Concert',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 23637 AND p.composer_id = 431 AND part.part_key = 'musicbrainz:1b3edbac-de0a-4d69-b58c-b9ca3242a27f' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:1b3edbac-de0a-4d69-b58c-b9ca3242a27f', 10, NULL, 'Quatorzième Concert', 'Les goûts-réunis: Quatorzième Concert', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 23637 AND p.composer_id = 431
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:1b3edbac-de0a-4d69-b58c-b9ca3242a27f'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:1b3edbac-de0a-4d69-b58c-b9ca3242a27f'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'Gravement', part.name_en = 'Les goûts-réunis, Quatorzième Concert: I. Gravement',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 23637 AND p.composer_id = 431 AND part.part_key = 'musicbrainz:e57444df-cd4a-4985-8924-f236691ecbb6' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:e57444df-cd4a-4985-8924-f236691ecbb6', 1, NULL, 'Gravement', 'Les goûts-réunis, Quatorzième Concert: I. Gravement', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:1b3edbac-de0a-4d69-b58c-b9ca3242a27f'
WHERE p.id = 23637 AND p.composer_id = 431
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:e57444df-cd4a-4985-8924-f236691ecbb6'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:1b3edbac-de0a-4d69-b58c-b9ca3242a27f'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'Allemande', part.name_en = 'Les goûts-réunis, Quatorzième Concert: II. Allemande',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 23637 AND p.composer_id = 431 AND part.part_key = 'musicbrainz:46a870c1-1288-40e0-a878-5c5f5558c4fe' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:46a870c1-1288-40e0-a878-5c5f5558c4fe', 2, NULL, 'Allemande', 'Les goûts-réunis, Quatorzième Concert: II. Allemande', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:1b3edbac-de0a-4d69-b58c-b9ca3242a27f'
WHERE p.id = 23637 AND p.composer_id = 431
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:46a870c1-1288-40e0-a878-5c5f5558c4fe'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:1b3edbac-de0a-4d69-b58c-b9ca3242a27f'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = NULL,
    part.name_ko = 'Sarabande', part.name_en = 'Les goûts-réunis, Quatorzième Concert: III. Sarabande',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 23637 AND p.composer_id = 431 AND part.part_key = 'musicbrainz:456fc2f6-0258-4ef8-a51d-e4fde92a3a31' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:456fc2f6-0258-4ef8-a51d-e4fde92a3a31', 3, NULL, 'Sarabande', 'Les goûts-réunis, Quatorzième Concert: III. Sarabande', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:1b3edbac-de0a-4d69-b58c-b9ca3242a27f'
WHERE p.id = 23637 AND p.composer_id = 431
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:456fc2f6-0258-4ef8-a51d-e4fde92a3a31'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:1b3edbac-de0a-4d69-b58c-b9ca3242a27f'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = NULL,
    part.name_ko = 'Fuguéte', part.name_en = 'Les goûts-réunis, Quatorzième Concert: IV. Fuguéte',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 23637 AND p.composer_id = 431 AND part.part_key = 'musicbrainz:667d2899-2d08-48c0-9f0c-a2b905b1dec0' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:667d2899-2d08-48c0-9f0c-a2b905b1dec0', 4, NULL, 'Fuguéte', 'Les goûts-réunis, Quatorzième Concert: IV. Fuguéte', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:1b3edbac-de0a-4d69-b58c-b9ca3242a27f'
WHERE p.id = 23637 AND p.composer_id = 431
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:667d2899-2d08-48c0-9f0c-a2b905b1dec0'
);


-- None Leçons de ténèbres

UPDATE pieces piece
SET piece.title = 'Leçons de ténèbres', piece.title_en = 'Leçons de ténèbres',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 24400 AND piece.composer_id = 431
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'Première leçon de ténèbres', part.name_en = 'Première leçon de ténèbres',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 24400 AND p.composer_id = 431 AND part.part_key = 'musicbrainz:270846b6-9c90-39f2-aedd-548bb4e98cc9' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:270846b6-9c90-39f2-aedd-548bb4e98cc9', 1, NULL, 'Première leçon de ténèbres', 'Première leçon de ténèbres', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 24400 AND p.composer_id = 431
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:270846b6-9c90-39f2-aedd-548bb4e98cc9'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:270846b6-9c90-39f2-aedd-548bb4e98cc9'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'Incipit Lamentatio Jeremiae Prophetae', part.name_en = 'Première leçon de ténèbres: Incipit Lamentatio Jeremiae Prophetae',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 24400 AND p.composer_id = 431 AND part.part_key = 'musicbrainz:dab78d9b-1b64-4432-9bf1-afab87c18266' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:dab78d9b-1b64-4432-9bf1-afab87c18266', 1, NULL, 'Incipit Lamentatio Jeremiae Prophetae', 'Première leçon de ténèbres: Incipit Lamentatio Jeremiae Prophetae', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:270846b6-9c90-39f2-aedd-548bb4e98cc9'
WHERE p.id = 24400 AND p.composer_id = 431
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:dab78d9b-1b64-4432-9bf1-afab87c18266'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:270846b6-9c90-39f2-aedd-548bb4e98cc9'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'ALEPH', part.name_en = 'Première leçon de ténèbres: ALEPH',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 24400 AND p.composer_id = 431 AND part.part_key = 'musicbrainz:fe82ce72-d07c-4063-bcda-afcfedfc20c0' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:fe82ce72-d07c-4063-bcda-afcfedfc20c0', 2, NULL, 'ALEPH', 'Première leçon de ténèbres: ALEPH', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:270846b6-9c90-39f2-aedd-548bb4e98cc9'
WHERE p.id = 24400 AND p.composer_id = 431
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:fe82ce72-d07c-4063-bcda-afcfedfc20c0'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:270846b6-9c90-39f2-aedd-548bb4e98cc9'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = NULL,
    part.name_ko = 'BETH', part.name_en = 'Première leçon de ténèbres: BETH',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 24400 AND p.composer_id = 431 AND part.part_key = 'musicbrainz:9e85612a-3051-432d-8bb1-c4207d515325' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:9e85612a-3051-432d-8bb1-c4207d515325', 3, NULL, 'BETH', 'Première leçon de ténèbres: BETH', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:270846b6-9c90-39f2-aedd-548bb4e98cc9'
WHERE p.id = 24400 AND p.composer_id = 431
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:9e85612a-3051-432d-8bb1-c4207d515325'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:270846b6-9c90-39f2-aedd-548bb4e98cc9'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = NULL,
    part.name_ko = 'GIMEL', part.name_en = 'Première leçon de ténèbres: GIMEL',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 24400 AND p.composer_id = 431 AND part.part_key = 'musicbrainz:70341cfa-c5d8-4b7b-861b-bf433e710774' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:70341cfa-c5d8-4b7b-861b-bf433e710774', 4, NULL, 'GIMEL', 'Première leçon de ténèbres: GIMEL', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:270846b6-9c90-39f2-aedd-548bb4e98cc9'
WHERE p.id = 24400 AND p.composer_id = 431
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:70341cfa-c5d8-4b7b-861b-bf433e710774'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:270846b6-9c90-39f2-aedd-548bb4e98cc9'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 5, part.movement_number = NULL,
    part.name_ko = 'DALETH', part.name_en = 'Première leçon de ténèbres: DALETH',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 24400 AND p.composer_id = 431 AND part.part_key = 'musicbrainz:9d7ef0a7-03bc-4292-9c7d-f43c02e021d0' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:9d7ef0a7-03bc-4292-9c7d-f43c02e021d0', 5, NULL, 'DALETH', 'Première leçon de ténèbres: DALETH', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:270846b6-9c90-39f2-aedd-548bb4e98cc9'
WHERE p.id = 24400 AND p.composer_id = 431
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:9d7ef0a7-03bc-4292-9c7d-f43c02e021d0'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:270846b6-9c90-39f2-aedd-548bb4e98cc9'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 6, part.movement_number = NULL,
    part.name_ko = 'HETH', part.name_en = 'Première leçon de ténèbres: HETH',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 24400 AND p.composer_id = 431 AND part.part_key = 'musicbrainz:4440e789-1851-4e31-bda4-808cd34bb719' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:4440e789-1851-4e31-bda4-808cd34bb719', 6, NULL, 'HETH', 'Première leçon de ténèbres: HETH', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:270846b6-9c90-39f2-aedd-548bb4e98cc9'
WHERE p.id = 24400 AND p.composer_id = 431
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:4440e789-1851-4e31-bda4-808cd34bb719'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:270846b6-9c90-39f2-aedd-548bb4e98cc9'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 7, part.movement_number = NULL,
    part.name_ko = 'Jerusalem, convertere ad Dominum Deum tuum', part.name_en = 'Première leçon de ténèbres: Jerusalem, convertere ad Dominum Deum tuum',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 24400 AND p.composer_id = 431 AND part.part_key = 'musicbrainz:44a8ba0c-8e32-4b84-901a-2a60d5573b4f' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:44a8ba0c-8e32-4b84-901a-2a60d5573b4f', 7, NULL, 'Jerusalem, convertere ad Dominum Deum tuum', 'Première leçon de ténèbres: Jerusalem, convertere ad Dominum Deum tuum', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:270846b6-9c90-39f2-aedd-548bb4e98cc9'
WHERE p.id = 24400 AND p.composer_id = 431
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:44a8ba0c-8e32-4b84-901a-2a60d5573b4f'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'Seconde leçon de ténèbres', part.name_en = 'Seconde leçon de ténèbres',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 24400 AND p.composer_id = 431 AND part.part_key = 'musicbrainz:ebf24372-8dbd-3c12-9c1b-60b572d4a469' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:ebf24372-8dbd-3c12-9c1b-60b572d4a469', 2, NULL, 'Seconde leçon de ténèbres', 'Seconde leçon de ténèbres', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 24400 AND p.composer_id = 431
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:ebf24372-8dbd-3c12-9c1b-60b572d4a469'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:ebf24372-8dbd-3c12-9c1b-60b572d4a469'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'VAU', part.name_en = 'Seconde leçon de ténèbres: VAU',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 24400 AND p.composer_id = 431 AND part.part_key = 'musicbrainz:0bf0a509-9782-44b5-8a4c-8fd9293524df' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:0bf0a509-9782-44b5-8a4c-8fd9293524df', 1, NULL, 'VAU', 'Seconde leçon de ténèbres: VAU', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:ebf24372-8dbd-3c12-9c1b-60b572d4a469'
WHERE p.id = 24400 AND p.composer_id = 431
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:0bf0a509-9782-44b5-8a4c-8fd9293524df'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:ebf24372-8dbd-3c12-9c1b-60b572d4a469'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'ZAIN', part.name_en = 'Seconde leçon de ténèbres: ZAIN',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 24400 AND p.composer_id = 431 AND part.part_key = 'musicbrainz:1d9f7acf-3452-44f3-b3e0-1fa2832e973b' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:1d9f7acf-3452-44f3-b3e0-1fa2832e973b', 2, NULL, 'ZAIN', 'Seconde leçon de ténèbres: ZAIN', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:ebf24372-8dbd-3c12-9c1b-60b572d4a469'
WHERE p.id = 24400 AND p.composer_id = 431
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:1d9f7acf-3452-44f3-b3e0-1fa2832e973b'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:ebf24372-8dbd-3c12-9c1b-60b572d4a469'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = NULL,
    part.name_ko = 'HETH', part.name_en = 'Seconde leçon de ténèbres: HETH',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 24400 AND p.composer_id = 431 AND part.part_key = 'musicbrainz:ece266f1-6aeb-4320-adf7-741484a25af5' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:ece266f1-6aeb-4320-adf7-741484a25af5', 3, NULL, 'HETH', 'Seconde leçon de ténèbres: HETH', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:ebf24372-8dbd-3c12-9c1b-60b572d4a469'
WHERE p.id = 24400 AND p.composer_id = 431
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:ece266f1-6aeb-4320-adf7-741484a25af5'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:ebf24372-8dbd-3c12-9c1b-60b572d4a469'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = NULL,
    part.name_ko = 'TETH', part.name_en = 'Seconde leçon de ténèbres: TETH',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 24400 AND p.composer_id = 431 AND part.part_key = 'musicbrainz:a0d9beaa-ddaf-43ab-8935-6d0e2fbd840b' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:a0d9beaa-ddaf-43ab-8935-6d0e2fbd840b', 4, NULL, 'TETH', 'Seconde leçon de ténèbres: TETH', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:ebf24372-8dbd-3c12-9c1b-60b572d4a469'
WHERE p.id = 24400 AND p.composer_id = 431
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:a0d9beaa-ddaf-43ab-8935-6d0e2fbd840b'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:ebf24372-8dbd-3c12-9c1b-60b572d4a469'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 5, part.movement_number = NULL,
    part.name_ko = 'Jerusalem, convertere ad Dominum Deum tuum', part.name_en = 'Seconde leçon de ténèbres: Jerusalem, convertere ad Dominum Deum tuum',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 24400 AND p.composer_id = 431 AND part.part_key = 'musicbrainz:54a70387-d77c-42b7-b003-97fff510fbb8' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:54a70387-d77c-42b7-b003-97fff510fbb8', 5, NULL, 'Jerusalem, convertere ad Dominum Deum tuum', 'Seconde leçon de ténèbres: Jerusalem, convertere ad Dominum Deum tuum', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:ebf24372-8dbd-3c12-9c1b-60b572d4a469'
WHERE p.id = 24400 AND p.composer_id = 431
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:54a70387-d77c-42b7-b003-97fff510fbb8'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = NULL,
    part.name_ko = 'Troisième leçon de ténèbres', part.name_en = 'Troisième leçon de ténèbres',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 24400 AND p.composer_id = 431 AND part.part_key = 'musicbrainz:bb26162b-56c7-3ad8-9406-852432bc44e1' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:bb26162b-56c7-3ad8-9406-852432bc44e1', 3, NULL, 'Troisième leçon de ténèbres', 'Troisième leçon de ténèbres', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 24400 AND p.composer_id = 431
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:bb26162b-56c7-3ad8-9406-852432bc44e1'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:bb26162b-56c7-3ad8-9406-852432bc44e1'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'JOD', part.name_en = 'Troisième leçon de ténèbres: JOD',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 24400 AND p.composer_id = 431 AND part.part_key = 'musicbrainz:eb98bc40-5f88-4b04-939f-e480d5459212' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:eb98bc40-5f88-4b04-939f-e480d5459212', 1, NULL, 'JOD', 'Troisième leçon de ténèbres: JOD', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:bb26162b-56c7-3ad8-9406-852432bc44e1'
WHERE p.id = 24400 AND p.composer_id = 431
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:eb98bc40-5f88-4b04-939f-e480d5459212'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:bb26162b-56c7-3ad8-9406-852432bc44e1'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'CAPH', part.name_en = 'Troisième leçon de ténèbres: CAPH',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 24400 AND p.composer_id = 431 AND part.part_key = 'musicbrainz:ddedc6ec-be2c-4cad-a2ca-f28dbb7ae1c3' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:ddedc6ec-be2c-4cad-a2ca-f28dbb7ae1c3', 2, NULL, 'CAPH', 'Troisième leçon de ténèbres: CAPH', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:bb26162b-56c7-3ad8-9406-852432bc44e1'
WHERE p.id = 24400 AND p.composer_id = 431
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:ddedc6ec-be2c-4cad-a2ca-f28dbb7ae1c3'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:bb26162b-56c7-3ad8-9406-852432bc44e1'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = NULL,
    part.name_ko = 'LAMED', part.name_en = 'Troisième leçon de ténèbres: LAMED',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 24400 AND p.composer_id = 431 AND part.part_key = 'musicbrainz:976a9214-79a9-4b5c-9194-bffeb20b88e8' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:976a9214-79a9-4b5c-9194-bffeb20b88e8', 3, NULL, 'LAMED', 'Troisième leçon de ténèbres: LAMED', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:bb26162b-56c7-3ad8-9406-852432bc44e1'
WHERE p.id = 24400 AND p.composer_id = 431
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:976a9214-79a9-4b5c-9194-bffeb20b88e8'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:bb26162b-56c7-3ad8-9406-852432bc44e1'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = NULL,
    part.name_ko = 'MEM', part.name_en = 'Troisième leçon de ténèbres: MEM',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 24400 AND p.composer_id = 431 AND part.part_key = 'musicbrainz:b07191e1-b0a1-4c34-916e-0b06666fa27a' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:b07191e1-b0a1-4c34-916e-0b06666fa27a', 4, NULL, 'MEM', 'Troisième leçon de ténèbres: MEM', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:bb26162b-56c7-3ad8-9406-852432bc44e1'
WHERE p.id = 24400 AND p.composer_id = 431
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:b07191e1-b0a1-4c34-916e-0b06666fa27a'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:bb26162b-56c7-3ad8-9406-852432bc44e1'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 5, part.movement_number = NULL,
    part.name_ko = 'NUN', part.name_en = 'Troisième leçon de ténèbres: NUN',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 24400 AND p.composer_id = 431 AND part.part_key = 'musicbrainz:4c4f5ea9-d126-4484-a71e-70cfd5479290' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:4c4f5ea9-d126-4484-a71e-70cfd5479290', 5, NULL, 'NUN', 'Troisième leçon de ténèbres: NUN', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:bb26162b-56c7-3ad8-9406-852432bc44e1'
WHERE p.id = 24400 AND p.composer_id = 431
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:4c4f5ea9-d126-4484-a71e-70cfd5479290'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:bb26162b-56c7-3ad8-9406-852432bc44e1'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 6, part.movement_number = NULL,
    part.name_ko = 'Jerusalem, convertere ad Dominum Deum tuum', part.name_en = 'Troisième leçon de ténèbres: Jerusalem, convertere ad Dominum Deum tuum',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 24400 AND p.composer_id = 431 AND part.part_key = 'musicbrainz:b2a1ddc0-82c9-457c-b0e8-70683ba1e29e' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:b2a1ddc0-82c9-457c-b0e8-70683ba1e29e', 6, NULL, 'Jerusalem, convertere ad Dominum Deum tuum', 'Troisième leçon de ténèbres: Jerusalem, convertere ad Dominum Deum tuum', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:bb26162b-56c7-3ad8-9406-852432bc44e1'
WHERE p.id = 24400 AND p.composer_id = 431
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:b2a1ddc0-82c9-457c-b0e8-70683ba1e29e'
);


-- None Livres de pièces de Clavecin

UPDATE pieces piece
SET piece.title = 'Livres de pièces de Clavecin', piece.title_en = 'Livres de pièces de Clavecin',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 25819 AND piece.composer_id = 431
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'Premier livre de pièces de clavecin', part.name_en = 'Premier livre de pièces de clavecin',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 25819 AND p.composer_id = 431 AND part.part_key = 'musicbrainz:4901c925-bf26-41b1-84df-39bc17fd77a2' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:4901c925-bf26-41b1-84df-39bc17fd77a2', 1, NULL, 'Premier livre de pièces de clavecin', 'Premier livre de pièces de clavecin', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 25819 AND p.composer_id = 431
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:4901c925-bf26-41b1-84df-39bc17fd77a2'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:4901c925-bf26-41b1-84df-39bc17fd77a2'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'Premier ordre de clavecin en sol mineur', part.name_en = 'Premier ordre de clavecin en sol mineur',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 25819 AND p.composer_id = 431 AND part.part_key = 'musicbrainz:ffb37bc4-43c9-4db0-af6e-a84ecd1e1994' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:ffb37bc4-43c9-4db0-af6e-a84ecd1e1994', 1, NULL, 'Premier ordre de clavecin en sol mineur', 'Premier ordre de clavecin en sol mineur', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:4901c925-bf26-41b1-84df-39bc17fd77a2'
WHERE p.id = 25819 AND p.composer_id = 431
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:ffb37bc4-43c9-4db0-af6e-a84ecd1e1994'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:4901c925-bf26-41b1-84df-39bc17fd77a2'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'Deuxième ordre de clavecin en ré majeur', part.name_en = 'Deuxième ordre de clavecin en ré majeur',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 25819 AND p.composer_id = 431 AND part.part_key = 'musicbrainz:34ff6e35-e7d8-4a99-9ba7-5ffb4357952e' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:34ff6e35-e7d8-4a99-9ba7-5ffb4357952e', 2, NULL, 'Deuxième ordre de clavecin en ré majeur', 'Deuxième ordre de clavecin en ré majeur', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:4901c925-bf26-41b1-84df-39bc17fd77a2'
WHERE p.id = 25819 AND p.composer_id = 431
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:34ff6e35-e7d8-4a99-9ba7-5ffb4357952e'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:4901c925-bf26-41b1-84df-39bc17fd77a2'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = NULL,
    part.name_ko = 'Troisième ordre de clavecin en do mineur', part.name_en = 'Troisième ordre de clavecin en do mineur',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 25819 AND p.composer_id = 431 AND part.part_key = 'musicbrainz:cbd7a9d7-38b3-48cd-b20d-82687e1aa0dd' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:cbd7a9d7-38b3-48cd-b20d-82687e1aa0dd', 3, NULL, 'Troisième ordre de clavecin en do mineur', 'Troisième ordre de clavecin en do mineur', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:4901c925-bf26-41b1-84df-39bc17fd77a2'
WHERE p.id = 25819 AND p.composer_id = 431
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:cbd7a9d7-38b3-48cd-b20d-82687e1aa0dd'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:4901c925-bf26-41b1-84df-39bc17fd77a2'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = NULL,
    part.name_ko = 'Quatrième ordre de clavecin en fa majeur', part.name_en = 'Quatrième ordre de clavecin en fa majeur',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 25819 AND p.composer_id = 431 AND part.part_key = 'musicbrainz:952e4a56-4472-45e1-a11e-a362f44185fd' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:952e4a56-4472-45e1-a11e-a362f44185fd', 4, NULL, 'Quatrième ordre de clavecin en fa majeur', 'Quatrième ordre de clavecin en fa majeur', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:4901c925-bf26-41b1-84df-39bc17fd77a2'
WHERE p.id = 25819 AND p.composer_id = 431
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:952e4a56-4472-45e1-a11e-a362f44185fd'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:4901c925-bf26-41b1-84df-39bc17fd77a2'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 5, part.movement_number = NULL,
    part.name_ko = 'Cinquième ordre de clavecin en la majeur', part.name_en = 'Cinquième ordre de clavecin en la majeur',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 25819 AND p.composer_id = 431 AND part.part_key = 'musicbrainz:85c48f62-f69e-469d-bef3-cb0fb141b4b7' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:85c48f62-f69e-469d-bef3-cb0fb141b4b7', 5, NULL, 'Cinquième ordre de clavecin en la majeur', 'Cinquième ordre de clavecin en la majeur', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:4901c925-bf26-41b1-84df-39bc17fd77a2'
WHERE p.id = 25819 AND p.composer_id = 431
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:85c48f62-f69e-469d-bef3-cb0fb141b4b7'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'Second livre de pièces de clavecin', part.name_en = 'Second livre de pièces de clavecin',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 25819 AND p.composer_id = 431 AND part.part_key = 'musicbrainz:d3c461e6-3f3a-43b3-a449-2f275a8882dc' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:d3c461e6-3f3a-43b3-a449-2f275a8882dc', 2, NULL, 'Second livre de pièces de clavecin', 'Second livre de pièces de clavecin', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 25819 AND p.composer_id = 431
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:d3c461e6-3f3a-43b3-a449-2f275a8882dc'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:d3c461e6-3f3a-43b3-a449-2f275a8882dc'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'Sixième ordre de clavecin en si bémol majeur', part.name_en = 'Sixième ordre de clavecin en si bémol majeur',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 25819 AND p.composer_id = 431 AND part.part_key = 'musicbrainz:34e6f366-d57a-4720-8ea2-c4e0dc609a34' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:34e6f366-d57a-4720-8ea2-c4e0dc609a34', 1, NULL, 'Sixième ordre de clavecin en si bémol majeur', 'Sixième ordre de clavecin en si bémol majeur', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:d3c461e6-3f3a-43b3-a449-2f275a8882dc'
WHERE p.id = 25819 AND p.composer_id = 431
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:34e6f366-d57a-4720-8ea2-c4e0dc609a34'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:d3c461e6-3f3a-43b3-a449-2f275a8882dc'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'Septième ordre de clavecin en sol majeur', part.name_en = 'Septième ordre de clavecin en sol majeur',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 25819 AND p.composer_id = 431 AND part.part_key = 'musicbrainz:839a1b22-9e34-4b4a-b6dc-5b5afbc90ee6' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:839a1b22-9e34-4b4a-b6dc-5b5afbc90ee6', 2, NULL, 'Septième ordre de clavecin en sol majeur', 'Septième ordre de clavecin en sol majeur', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:d3c461e6-3f3a-43b3-a449-2f275a8882dc'
WHERE p.id = 25819 AND p.composer_id = 431
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:839a1b22-9e34-4b4a-b6dc-5b5afbc90ee6'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:d3c461e6-3f3a-43b3-a449-2f275a8882dc'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = NULL,
    part.name_ko = 'Huitiême ordre de clavecin en si mineur', part.name_en = 'Huitiême ordre de clavecin en si mineur',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 25819 AND p.composer_id = 431 AND part.part_key = 'musicbrainz:f3bbb1c4-1c48-44df-801b-17f0123371d2' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:f3bbb1c4-1c48-44df-801b-17f0123371d2', 3, NULL, 'Huitiême ordre de clavecin en si mineur', 'Huitiême ordre de clavecin en si mineur', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:d3c461e6-3f3a-43b3-a449-2f275a8882dc'
WHERE p.id = 25819 AND p.composer_id = 431
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:f3bbb1c4-1c48-44df-801b-17f0123371d2'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:d3c461e6-3f3a-43b3-a449-2f275a8882dc'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = NULL,
    part.name_ko = 'Neuxiême ordre de clavecin en la majeur', part.name_en = 'Neuxiême ordre de clavecin en la majeur',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 25819 AND p.composer_id = 431 AND part.part_key = 'musicbrainz:ddd74744-a958-4257-a282-62a2d7151515' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:ddd74744-a958-4257-a282-62a2d7151515', 4, NULL, 'Neuxiême ordre de clavecin en la majeur', 'Neuxiême ordre de clavecin en la majeur', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:d3c461e6-3f3a-43b3-a449-2f275a8882dc'
WHERE p.id = 25819 AND p.composer_id = 431
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:ddd74744-a958-4257-a282-62a2d7151515'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:d3c461e6-3f3a-43b3-a449-2f275a8882dc'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 5, part.movement_number = NULL,
    part.name_ko = 'Dixiême ordre de clavecin en ré majeur', part.name_en = 'Dixiême ordre de clavecin en ré majeur',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 25819 AND p.composer_id = 431 AND part.part_key = 'musicbrainz:afaf527c-b671-40c7-9d09-72c86983bce4' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:afaf527c-b671-40c7-9d09-72c86983bce4', 5, NULL, 'Dixiême ordre de clavecin en ré majeur', 'Dixiême ordre de clavecin en ré majeur', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:d3c461e6-3f3a-43b3-a449-2f275a8882dc'
WHERE p.id = 25819 AND p.composer_id = 431
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:afaf527c-b671-40c7-9d09-72c86983bce4'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:d3c461e6-3f3a-43b3-a449-2f275a8882dc'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 6, part.movement_number = NULL,
    part.name_ko = 'Onziême ordre de clavecin en do majeur', part.name_en = 'Onziême ordre de clavecin en do majeur',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 25819 AND p.composer_id = 431 AND part.part_key = 'musicbrainz:9c9986dd-9a5b-4bd3-8baf-141834dc3324' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:9c9986dd-9a5b-4bd3-8baf-141834dc3324', 6, NULL, 'Onziême ordre de clavecin en do majeur', 'Onziême ordre de clavecin en do majeur', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:d3c461e6-3f3a-43b3-a449-2f275a8882dc'
WHERE p.id = 25819 AND p.composer_id = 431
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:9c9986dd-9a5b-4bd3-8baf-141834dc3324'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:d3c461e6-3f3a-43b3-a449-2f275a8882dc'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 7, part.movement_number = NULL,
    part.name_ko = 'Douzième ordre de clavecin en mi majeur', part.name_en = 'Douzième ordre de clavecin en mi majeur',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 25819 AND p.composer_id = 431 AND part.part_key = 'musicbrainz:a6b135c2-719f-4c90-bad8-5363da82ec0b' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:a6b135c2-719f-4c90-bad8-5363da82ec0b', 7, NULL, 'Douzième ordre de clavecin en mi majeur', 'Douzième ordre de clavecin en mi majeur', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:d3c461e6-3f3a-43b3-a449-2f275a8882dc'
WHERE p.id = 25819 AND p.composer_id = 431
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:a6b135c2-719f-4c90-bad8-5363da82ec0b'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = NULL,
    part.name_ko = 'Troisième livre de pièces de clavecin', part.name_en = 'Troisième livre de pièces de clavecin',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 25819 AND p.composer_id = 431 AND part.part_key = 'musicbrainz:b4d0b12f-ee3c-46b2-909b-c75a854336f3' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:b4d0b12f-ee3c-46b2-909b-c75a854336f3', 3, NULL, 'Troisième livre de pièces de clavecin', 'Troisième livre de pièces de clavecin', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 25819 AND p.composer_id = 431
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:b4d0b12f-ee3c-46b2-909b-c75a854336f3'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:b4d0b12f-ee3c-46b2-909b-c75a854336f3'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'Treizième ordre de clavecin en si mineur', part.name_en = 'Treizième ordre de clavecin en si mineur',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 25819 AND p.composer_id = 431 AND part.part_key = 'musicbrainz:efc4817e-9ef6-4e3e-b106-37e2c5f6cbef' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:efc4817e-9ef6-4e3e-b106-37e2c5f6cbef', 1, NULL, 'Treizième ordre de clavecin en si mineur', 'Treizième ordre de clavecin en si mineur', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:b4d0b12f-ee3c-46b2-909b-c75a854336f3'
WHERE p.id = 25819 AND p.composer_id = 431
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:efc4817e-9ef6-4e3e-b106-37e2c5f6cbef'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:b4d0b12f-ee3c-46b2-909b-c75a854336f3'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'Quatorzième ordre de clavecin en ré majeur', part.name_en = 'Quatorzième ordre de clavecin en ré majeur',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 25819 AND p.composer_id = 431 AND part.part_key = 'musicbrainz:973c9814-e68b-4e99-a14f-ab0e829d958c' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:973c9814-e68b-4e99-a14f-ab0e829d958c', 2, NULL, 'Quatorzième ordre de clavecin en ré majeur', 'Quatorzième ordre de clavecin en ré majeur', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:b4d0b12f-ee3c-46b2-909b-c75a854336f3'
WHERE p.id = 25819 AND p.composer_id = 431
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:973c9814-e68b-4e99-a14f-ab0e829d958c'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:b4d0b12f-ee3c-46b2-909b-c75a854336f3'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = NULL,
    part.name_ko = 'Quinzième ordre de clavecin en la majeur', part.name_en = 'Quinzième ordre de clavecin en la majeur',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 25819 AND p.composer_id = 431 AND part.part_key = 'musicbrainz:644cb951-a590-4dbf-94f7-a8e6cffed91c' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:644cb951-a590-4dbf-94f7-a8e6cffed91c', 3, NULL, 'Quinzième ordre de clavecin en la majeur', 'Quinzième ordre de clavecin en la majeur', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:b4d0b12f-ee3c-46b2-909b-c75a854336f3'
WHERE p.id = 25819 AND p.composer_id = 431
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:644cb951-a590-4dbf-94f7-a8e6cffed91c'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:b4d0b12f-ee3c-46b2-909b-c75a854336f3'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = NULL,
    part.name_ko = 'Seizième ordre de clavecin en sol majeur', part.name_en = 'Seizième ordre de clavecin en sol majeur',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 25819 AND p.composer_id = 431 AND part.part_key = 'musicbrainz:c084ec5a-c698-446d-81cf-84044ea13660' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:c084ec5a-c698-446d-81cf-84044ea13660', 4, NULL, 'Seizième ordre de clavecin en sol majeur', 'Seizième ordre de clavecin en sol majeur', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:b4d0b12f-ee3c-46b2-909b-c75a854336f3'
WHERE p.id = 25819 AND p.composer_id = 431
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:c084ec5a-c698-446d-81cf-84044ea13660'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:b4d0b12f-ee3c-46b2-909b-c75a854336f3'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 5, part.movement_number = NULL,
    part.name_ko = 'Dix-septième ordre de clavecin en mi mineur', part.name_en = 'Dix-septième ordre de clavecin en mi mineur',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 25819 AND p.composer_id = 431 AND part.part_key = 'musicbrainz:878c79ac-1bc3-499d-be85-dcc1932d93bc' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:878c79ac-1bc3-499d-be85-dcc1932d93bc', 5, NULL, 'Dix-septième ordre de clavecin en mi mineur', 'Dix-septième ordre de clavecin en mi mineur', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:b4d0b12f-ee3c-46b2-909b-c75a854336f3'
WHERE p.id = 25819 AND p.composer_id = 431
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:878c79ac-1bc3-499d-be85-dcc1932d93bc'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:b4d0b12f-ee3c-46b2-909b-c75a854336f3'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 6, part.movement_number = NULL,
    part.name_ko = 'Dix-huitième ordre de clavecin en fa majeur', part.name_en = 'Dix-huitième ordre de clavecin en fa majeur',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 25819 AND p.composer_id = 431 AND part.part_key = 'musicbrainz:cf4b9808-7432-458b-bb27-6fdc422f5538' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:cf4b9808-7432-458b-bb27-6fdc422f5538', 6, NULL, 'Dix-huitième ordre de clavecin en fa majeur', 'Dix-huitième ordre de clavecin en fa majeur', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:b4d0b12f-ee3c-46b2-909b-c75a854336f3'
WHERE p.id = 25819 AND p.composer_id = 431
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:cf4b9808-7432-458b-bb27-6fdc422f5538'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:b4d0b12f-ee3c-46b2-909b-c75a854336f3'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 7, part.movement_number = NULL,
    part.name_ko = 'Dix-neuvième ordre de clavecin en ré majeur', part.name_en = 'Dix-neuvième ordre de clavecin en ré majeur',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 25819 AND p.composer_id = 431 AND part.part_key = 'musicbrainz:a2768491-432d-4366-878c-bee525bdd8b1' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:a2768491-432d-4366-878c-bee525bdd8b1', 7, NULL, 'Dix-neuvième ordre de clavecin en ré majeur', 'Dix-neuvième ordre de clavecin en ré majeur', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:b4d0b12f-ee3c-46b2-909b-c75a854336f3'
WHERE p.id = 25819 AND p.composer_id = 431
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:a2768491-432d-4366-878c-bee525bdd8b1'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = NULL,
    part.name_ko = 'Quatrième livre de pièces de clavecin', part.name_en = 'Quatrième livre de pièces de clavecin',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 25819 AND p.composer_id = 431 AND part.part_key = 'musicbrainz:f9b77b53-e5d9-465b-bccf-a3913fefb94d' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:f9b77b53-e5d9-465b-bccf-a3913fefb94d', 4, NULL, 'Quatrième livre de pièces de clavecin', 'Quatrième livre de pièces de clavecin', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 25819 AND p.composer_id = 431
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:f9b77b53-e5d9-465b-bccf-a3913fefb94d'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:f9b77b53-e5d9-465b-bccf-a3913fefb94d'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'Vingtième ordre de clavecin en sol majeur', part.name_en = 'Vingtième ordre de clavecin en sol majeur',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 25819 AND p.composer_id = 431 AND part.part_key = 'musicbrainz:9c18b369-b684-4faa-a66c-dc7a172f7381' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:9c18b369-b684-4faa-a66c-dc7a172f7381', 1, NULL, 'Vingtième ordre de clavecin en sol majeur', 'Vingtième ordre de clavecin en sol majeur', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:f9b77b53-e5d9-465b-bccf-a3913fefb94d'
WHERE p.id = 25819 AND p.composer_id = 431
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:9c18b369-b684-4faa-a66c-dc7a172f7381'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:f9b77b53-e5d9-465b-bccf-a3913fefb94d'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'Vingt-et-unième ordre de clavecin en mi mineur', part.name_en = 'Vingt-et-unième ordre de clavecin en mi mineur',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 25819 AND p.composer_id = 431 AND part.part_key = 'musicbrainz:2c9e1182-b98d-4bfa-b586-e3719f195210' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:2c9e1182-b98d-4bfa-b586-e3719f195210', 2, NULL, 'Vingt-et-unième ordre de clavecin en mi mineur', 'Vingt-et-unième ordre de clavecin en mi mineur', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:f9b77b53-e5d9-465b-bccf-a3913fefb94d'
WHERE p.id = 25819 AND p.composer_id = 431
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:2c9e1182-b98d-4bfa-b586-e3719f195210'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:f9b77b53-e5d9-465b-bccf-a3913fefb94d'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = NULL,
    part.name_ko = 'Vingt-deuxième ordre de clavecin en ré majeur', part.name_en = 'Vingt-deuxième ordre de clavecin en ré majeur',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 25819 AND p.composer_id = 431 AND part.part_key = 'musicbrainz:4a6a0a44-0a45-4682-8dbe-8ae2c4a485a1' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:4a6a0a44-0a45-4682-8dbe-8ae2c4a485a1', 3, NULL, 'Vingt-deuxième ordre de clavecin en ré majeur', 'Vingt-deuxième ordre de clavecin en ré majeur', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:f9b77b53-e5d9-465b-bccf-a3913fefb94d'
WHERE p.id = 25819 AND p.composer_id = 431
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:4a6a0a44-0a45-4682-8dbe-8ae2c4a485a1'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:f9b77b53-e5d9-465b-bccf-a3913fefb94d'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = NULL,
    part.name_ko = 'Vingt-troisième ordre de clavecin en fa majeur', part.name_en = 'Vingt-troisième ordre de clavecin en fa majeur',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 25819 AND p.composer_id = 431 AND part.part_key = 'musicbrainz:62ab107a-3f5f-47cf-b102-08a58433fbf1' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:62ab107a-3f5f-47cf-b102-08a58433fbf1', 4, NULL, 'Vingt-troisième ordre de clavecin en fa majeur', 'Vingt-troisième ordre de clavecin en fa majeur', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:f9b77b53-e5d9-465b-bccf-a3913fefb94d'
WHERE p.id = 25819 AND p.composer_id = 431
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:62ab107a-3f5f-47cf-b102-08a58433fbf1'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:f9b77b53-e5d9-465b-bccf-a3913fefb94d'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 5, part.movement_number = NULL,
    part.name_ko = 'Vingt-quatrième ordre de clavecin en la majeur', part.name_en = 'Vingt-quatrième ordre de clavecin en la majeur',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 25819 AND p.composer_id = 431 AND part.part_key = 'musicbrainz:394639e5-df1e-401f-a85f-406673b237a4' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:394639e5-df1e-401f-a85f-406673b237a4', 5, NULL, 'Vingt-quatrième ordre de clavecin en la majeur', 'Vingt-quatrième ordre de clavecin en la majeur', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:f9b77b53-e5d9-465b-bccf-a3913fefb94d'
WHERE p.id = 25819 AND p.composer_id = 431
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:394639e5-df1e-401f-a85f-406673b237a4'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:f9b77b53-e5d9-465b-bccf-a3913fefb94d'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 6, part.movement_number = NULL,
    part.name_ko = 'Vingt-cinquième ordre de clavecin en mi bémol majeur / do mineur', part.name_en = 'Vingt-cinquième ordre de clavecin en mi bémol majeur / do mineur',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 25819 AND p.composer_id = 431 AND part.part_key = 'musicbrainz:83b115ce-f232-49ec-9f65-baf3541c8768' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:83b115ce-f232-49ec-9f65-baf3541c8768', 6, NULL, 'Vingt-cinquième ordre de clavecin en mi bémol majeur / do mineur', 'Vingt-cinquième ordre de clavecin en mi bémol majeur / do mineur', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:f9b77b53-e5d9-465b-bccf-a3913fefb94d'
WHERE p.id = 25819 AND p.composer_id = 431
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:83b115ce-f232-49ec-9f65-baf3541c8768'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:f9b77b53-e5d9-465b-bccf-a3913fefb94d'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 7, part.movement_number = NULL,
    part.name_ko = 'Vingt-sixième ordre de clavecin en fa dièse mineur', part.name_en = 'Vingt-sixième ordre de clavecin en fa dièse mineur',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 25819 AND p.composer_id = 431 AND part.part_key = 'musicbrainz:d0c683de-50ea-4e17-8edf-92fe51bdfc91' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:d0c683de-50ea-4e17-8edf-92fe51bdfc91', 7, NULL, 'Vingt-sixième ordre de clavecin en fa dièse mineur', 'Vingt-sixième ordre de clavecin en fa dièse mineur', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:f9b77b53-e5d9-465b-bccf-a3913fefb94d'
WHERE p.id = 25819 AND p.composer_id = 431
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:d0c683de-50ea-4e17-8edf-92fe51bdfc91'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:f9b77b53-e5d9-465b-bccf-a3913fefb94d'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 8, part.movement_number = NULL,
    part.name_ko = 'Vingt-septième ordre de clavecin en si mineur', part.name_en = 'Vingt-septième ordre de clavecin en si mineur',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 25819 AND p.composer_id = 431 AND part.part_key = 'musicbrainz:5d54accf-9880-4217-bb60-a752195e3cc7' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:5d54accf-9880-4217-bb60-a752195e3cc7', 8, NULL, 'Vingt-septième ordre de clavecin en si mineur', 'Vingt-septième ordre de clavecin en si mineur', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:f9b77b53-e5d9-465b-bccf-a3913fefb94d'
WHERE p.id = 25819 AND p.composer_id = 431
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:5d54accf-9880-4217-bb60-a752195e3cc7'
);


-- None L’art de toucher le clavecin

UPDATE pieces piece
SET piece.title = 'L’art de toucher le clavecin', piece.title_en = 'L’art de toucher le clavecin',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 24438 AND piece.composer_id = 431
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'C장조', part.name_en = 'L''art de toucher le clavecin: I. Prelude in C major',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 24438 AND p.composer_id = 431 AND part.part_key = 'musicbrainz:6cb4ad23-dbd1-4866-a73e-d58185465b9d' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:6cb4ad23-dbd1-4866-a73e-d58185465b9d', 1, 'I', 'C장조', 'L''art de toucher le clavecin: I. Prelude in C major', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 24438 AND p.composer_id = 431
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:6cb4ad23-dbd1-4866-a73e-d58185465b9d'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'D단조', part.name_en = 'L’art de toucher le clavecin: II. Prelude in D minor',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 24438 AND p.composer_id = 431 AND part.part_key = 'musicbrainz:5a8d962b-450c-45f4-a121-37dcf759051c' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:5a8d962b-450c-45f4-a121-37dcf759051c', 2, 'II', 'D단조', 'L’art de toucher le clavecin: II. Prelude in D minor', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 24438 AND p.composer_id = 431
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:5a8d962b-450c-45f4-a121-37dcf759051c'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = 'G단조', part.name_en = 'L''art de toucher le clavecin: III. Prelude in G minor',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 24438 AND p.composer_id = 431 AND part.part_key = 'musicbrainz:543870fd-f9e8-4280-ba6c-84b2b3b80d8f' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:543870fd-f9e8-4280-ba6c-84b2b3b80d8f', 3, 'III', 'G단조', 'L''art de toucher le clavecin: III. Prelude in G minor', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 24438 AND p.composer_id = 431
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:543870fd-f9e8-4280-ba6c-84b2b3b80d8f'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = 'IV',
    part.name_ko = 'F장조', part.name_en = 'L''art de toucher le clavecin: IV. Prelude in F major',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 24438 AND p.composer_id = 431 AND part.part_key = 'musicbrainz:2bd3368a-d5a1-4d9f-bbd3-ada94098b92b' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:2bd3368a-d5a1-4d9f-bbd3-ada94098b92b', 4, 'IV', 'F장조', 'L''art de toucher le clavecin: IV. Prelude in F major', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 24438 AND p.composer_id = 431
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:2bd3368a-d5a1-4d9f-bbd3-ada94098b92b'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 5, part.movement_number = 'V',
    part.name_ko = 'A장조', part.name_en = 'L''art de toucher le clavecin: V. Prelude in A major',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 24438 AND p.composer_id = 431 AND part.part_key = 'musicbrainz:e0231f6a-4e4a-4f32-8152-8002ce71d668' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:e0231f6a-4e4a-4f32-8152-8002ce71d668', 5, 'V', 'A장조', 'L''art de toucher le clavecin: V. Prelude in A major', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 24438 AND p.composer_id = 431
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:e0231f6a-4e4a-4f32-8152-8002ce71d668'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 6, part.movement_number = 'VI',
    part.name_ko = 'D단조', part.name_en = 'L''art de toucher le clavecin: VI. Prelude in D minor',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 24438 AND p.composer_id = 431 AND part.part_key = 'musicbrainz:f5184d09-d37c-47b9-8df4-0b689c3956ba' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:f5184d09-d37c-47b9-8df4-0b689c3956ba', 6, 'VI', 'D단조', 'L''art de toucher le clavecin: VI. Prelude in D minor', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 24438 AND p.composer_id = 431
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:f5184d09-d37c-47b9-8df4-0b689c3956ba'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 7, part.movement_number = 'VII',
    part.name_ko = 'B♭장조', part.name_en = 'L''art de toucher le clavecin: VII. Prelude in B-flat major',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 24438 AND p.composer_id = 431 AND part.part_key = 'musicbrainz:363ac620-fdc3-4407-93f6-c0fd1f314352' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:363ac620-fdc3-4407-93f6-c0fd1f314352', 7, 'VII', 'B♭장조', 'L''art de toucher le clavecin: VII. Prelude in B-flat major', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 24438 AND p.composer_id = 431
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:363ac620-fdc3-4407-93f6-c0fd1f314352'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 8, part.movement_number = 'VIII',
    part.name_ko = 'E단조', part.name_en = 'L''art de toucher le clavecin: VIII. Prelude in E minor',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 24438 AND p.composer_id = 431 AND part.part_key = 'musicbrainz:e285d2d1-63c8-4d8a-81fd-f4cc7ea493ed' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:e285d2d1-63c8-4d8a-81fd-f4cc7ea493ed', 8, 'VIII', 'E단조', 'L''art de toucher le clavecin: VIII. Prelude in E minor', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 24438 AND p.composer_id = 431
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:e285d2d1-63c8-4d8a-81fd-f4cc7ea493ed'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 9, part.movement_number = 'IX',
    part.name_ko = 'Allemande', part.name_en = 'L''art de toucher le clavecin: IX. Allemande',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 24438 AND p.composer_id = 431 AND part.part_key = 'musicbrainz:4dbd9bcd-830d-4d4d-bcbf-bb0c2fe0e112' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:4dbd9bcd-830d-4d4d-bcbf-bb0c2fe0e112', 9, 'IX', 'Allemande', 'L''art de toucher le clavecin: IX. Allemande', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 24438 AND p.composer_id = 431
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:4dbd9bcd-830d-4d4d-bcbf-bb0c2fe0e112'
);


-- None Messe Grecque de Saint Denis

UPDATE pieces piece
SET piece.title = 'Messe Grecque de Saint Denis', piece.title_en = 'Messe Grecque de Saint Denis',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 24532 AND piece.composer_id = 431
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'Introitus', part.name_en = 'Messe Grecque de Saint Denis: I. Introitus',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 24532 AND p.composer_id = 431 AND part.part_key = 'musicbrainz:5d86a437-bbaa-42b6-a813-4a1f381dac54' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:5d86a437-bbaa-42b6-a813-4a1f381dac54', 1, 'I', 'Introitus', 'Messe Grecque de Saint Denis: I. Introitus', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 24532 AND p.composer_id = 431
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:5d86a437-bbaa-42b6-a813-4a1f381dac54'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'Kyrie', part.name_en = 'Messe Grecque de Saint Denis: II. Kyrie',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 24532 AND p.composer_id = 431 AND part.part_key = 'musicbrainz:a85aa6f1-c429-4693-8455-4f1708f435da' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:a85aa6f1-c429-4693-8455-4f1708f435da', 2, 'II', 'Kyrie', 'Messe Grecque de Saint Denis: II. Kyrie', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 24532 AND p.composer_id = 431
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:a85aa6f1-c429-4693-8455-4f1708f435da'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = 'Gloria', part.name_en = 'Messe Grecque de Saint Denis: III. Gloria',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 24532 AND p.composer_id = 431 AND part.part_key = 'musicbrainz:4503e530-5b4f-4383-a61c-518e9592231d' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:4503e530-5b4f-4383-a61c-518e9592231d', 3, 'III', 'Gloria', 'Messe Grecque de Saint Denis: III. Gloria', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 24532 AND p.composer_id = 431
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:4503e530-5b4f-4383-a61c-518e9592231d'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = 'IV',
    part.name_ko = 'Epitre', part.name_en = 'Messe Grecque de Saint Denis: IV. Epitre',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 24532 AND p.composer_id = 431 AND part.part_key = 'musicbrainz:6c3e63aa-c3c2-4483-8b7b-7444cdb21e40' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:6c3e63aa-c3c2-4483-8b7b-7444cdb21e40', 4, 'IV', 'Epitre', 'Messe Grecque de Saint Denis: IV. Epitre', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 24532 AND p.composer_id = 431
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:6c3e63aa-c3c2-4483-8b7b-7444cdb21e40'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 5, part.movement_number = 'V',
    part.name_ko = 'Alleluia', part.name_en = 'Messe Grecque de Saint Denis: V. Alleluia',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 24532 AND p.composer_id = 431 AND part.part_key = 'musicbrainz:92bf2bd8-3461-4ed5-90fe-aeab0951ff06' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:92bf2bd8-3461-4ed5-90fe-aeab0951ff06', 5, 'V', 'Alleluia', 'Messe Grecque de Saint Denis: V. Alleluia', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 24532 AND p.composer_id = 431
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:92bf2bd8-3461-4ed5-90fe-aeab0951ff06'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 6, part.movement_number = 'VI',
    part.name_ko = 'Sequentia', part.name_en = 'Messe Grecque de Saint Denis: VI. Sequentia',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 24532 AND p.composer_id = 431 AND part.part_key = 'musicbrainz:b17c4c93-d8a3-4415-97e3-806de28e1b31' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:b17c4c93-d8a3-4415-97e3-806de28e1b31', 6, 'VI', 'Sequentia', 'Messe Grecque de Saint Denis: VI. Sequentia', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 24532 AND p.composer_id = 431
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:b17c4c93-d8a3-4415-97e3-806de28e1b31'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 7, part.movement_number = 'VII',
    part.name_ko = 'Offertorium', part.name_en = 'Messe Grecque de Saint Denis: VII. Offertorium',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 24532 AND p.composer_id = 431 AND part.part_key = 'musicbrainz:39daa8de-0b27-4d85-add2-b75231a76b30' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:39daa8de-0b27-4d85-add2-b75231a76b30', 7, 'VII', 'Offertorium', 'Messe Grecque de Saint Denis: VII. Offertorium', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 24532 AND p.composer_id = 431
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:39daa8de-0b27-4d85-add2-b75231a76b30'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 8, part.movement_number = 'VIII',
    part.name_ko = 'Sanctus', part.name_en = 'Messe Grecque de Saint Denis: VIII. Sanctus',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 24532 AND p.composer_id = 431 AND part.part_key = 'musicbrainz:774fad8a-9637-4274-9be0-3b92b45bf85a' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:774fad8a-9637-4274-9be0-3b92b45bf85a', 8, 'VIII', 'Sanctus', 'Messe Grecque de Saint Denis: VIII. Sanctus', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 24532 AND p.composer_id = 431
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:774fad8a-9637-4274-9be0-3b92b45bf85a'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 9, part.movement_number = 'IX',
    part.name_ko = 'Ad elevationem', part.name_en = 'Messe Grecque de Saint Denis: IX. Ad elevationem',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 24532 AND p.composer_id = 431 AND part.part_key = 'musicbrainz:eaee53e0-a982-4bca-bb03-cb41d5e6be58' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:eaee53e0-a982-4bca-bb03-cb41d5e6be58', 9, 'IX', 'Ad elevationem', 'Messe Grecque de Saint Denis: IX. Ad elevationem', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 24532 AND p.composer_id = 431
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:eaee53e0-a982-4bca-bb03-cb41d5e6be58'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 10, part.movement_number = 'X',
    part.name_ko = 'Agnus Dei', part.name_en = 'Messe Grecque de Saint Denis: X. Agnus Dei',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 24532 AND p.composer_id = 431 AND part.part_key = 'musicbrainz:aa2f4637-a43d-4b49-b72e-632447cecef6' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:aa2f4637-a43d-4b49-b72e-632447cecef6', 10, 'X', 'Agnus Dei', 'Messe Grecque de Saint Denis: X. Agnus Dei', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 24532 AND p.composer_id = 431
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:aa2f4637-a43d-4b49-b72e-632447cecef6'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 11, part.movement_number = 'XI',
    part.name_ko = 'Communio', part.name_en = 'Messe Grecque de Saint Denis: XI. Communio',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 24532 AND p.composer_id = 431 AND part.part_key = 'musicbrainz:f08dad11-e653-4bcb-bd23-16548fe5f7f9' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:f08dad11-e653-4bcb-bd23-16548fe5f7f9', 11, 'XI', 'Communio', 'Messe Grecque de Saint Denis: XI. Communio', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 24532 AND p.composer_id = 431
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:f08dad11-e653-4bcb-bd23-16548fe5f7f9'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 12, part.movement_number = 'XII',
    part.name_ko = 'Deo gratias', part.name_en = 'Messe Grecque de Saint Denis: XII. Deo gratias',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 24532 AND p.composer_id = 431 AND part.part_key = 'musicbrainz:4306668b-e29c-4fdc-87ca-ec15d4b3d0b7' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:4306668b-e29c-4fdc-87ca-ec15d4b3d0b7', 12, 'XII', 'Deo gratias', 'Messe Grecque de Saint Denis: XII. Deo gratias', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 24532 AND p.composer_id = 431
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:4306668b-e29c-4fdc-87ca-ec15d4b3d0b7'
);


-- None 모테트 <Motet de Sainte Suzanne>

UPDATE pieces piece
SET piece.title = '모테트 <Motet de Sainte Suzanne>', piece.title_en = 'Motet de Sainte Suzanne',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 24255 AND piece.composer_id = 431
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'Jubilemus, exultemus', part.name_en = 'Motet de Sainte Suzanne: Jubilemus, exultemus',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 24255 AND p.composer_id = 431 AND part.part_key = 'musicbrainz:111cd784-470c-48e2-8db0-e509b6d34b59' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:111cd784-470c-48e2-8db0-e509b6d34b59', 1, NULL, 'Jubilemus, exultemus', 'Motet de Sainte Suzanne: Jubilemus, exultemus', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 24255 AND p.composer_id = 431
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:111cd784-470c-48e2-8db0-e509b6d34b59'
);


-- None Motet pour le jour de Pâques

UPDATE pieces piece
SET piece.title = 'Motet pour le jour de Pâques', piece.title_en = 'Motet pour le jour de Pâques',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 24741 AND piece.composer_id = 431
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'Sic Jesus pastor bonus', part.name_en = 'Motet pour le jour de Pâques: II. Sic Jesus pastor bonus',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 24741 AND p.composer_id = 431 AND part.part_key = 'musicbrainz:2cfc31bd-fcdd-48d0-990c-241a494476ea' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:2cfc31bd-fcdd-48d0-990c-241a494476ea', 1, NULL, 'Sic Jesus pastor bonus', 'Motet pour le jour de Pâques: II. Sic Jesus pastor bonus', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 24741 AND p.composer_id = 431
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:2cfc31bd-fcdd-48d0-990c-241a494476ea'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'I.Victoria! Christo resurgenti', part.name_en = 'Motet pour le jour de Pâques: I.Victoria! Christo resurgenti',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 24741 AND p.composer_id = 431 AND part.part_key = 'musicbrainz:3024b5a9-0bd7-4f52-96c8-bd861904e2f9' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:3024b5a9-0bd7-4f52-96c8-bd861904e2f9', 2, NULL, 'I.Victoria! Christo resurgenti', 'Motet pour le jour de Pâques: I.Victoria! Christo resurgenti', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 24741 AND p.composer_id = 431
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:3024b5a9-0bd7-4f52-96c8-bd861904e2f9'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = NULL,
    part.name_ko = 'O Jesu salus lux et vita', part.name_en = 'Motet pour le jour de Pâques: III. O Jesu salus lux et vita',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 24741 AND p.composer_id = 431 AND part.part_key = 'musicbrainz:82d54eb6-f5ed-4ab6-b6db-f170d9a5dc5e' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:82d54eb6-f5ed-4ab6-b6db-f170d9a5dc5e', 3, NULL, 'O Jesu salus lux et vita', 'Motet pour le jour de Pâques: III. O Jesu salus lux et vita', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 24741 AND p.composer_id = 431
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:82d54eb6-f5ed-4ab6-b6db-f170d9a5dc5e'
);


-- None 모테트 <O Domine quia refugiam>

UPDATE pieces piece
SET piece.title = '모테트 <O Domine quia refugiam>', piece.title_en = 'O Domine quia refugiam',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 23483 AND piece.composer_id = 431
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None 모테트 <O misterium ineffabile, "Elevation">

UPDATE pieces piece
SET piece.title = '모테트 <O misterium ineffabile, "Elevation">', piece.title_en = 'O misterium ineffabile, "Elevation"',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 25541 AND piece.composer_id = 431
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None 모테트 <Ornate aras>

UPDATE pieces piece
SET piece.title = '모테트 <Ornate aras>', piece.title_en = 'Ornate aras',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 25277 AND piece.composer_id = 431
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Pièces d'orgue

UPDATE pieces piece
SET piece.title = 'Pièces d''orgue', piece.title_en = 'Pièces d''orgue',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 23594 AND piece.composer_id = 431
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'Messe à l''usage des Paroisses', part.name_en = 'Messe à l''usage des Paroisses',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 23594 AND p.composer_id = 431 AND part.part_key = 'musicbrainz:21037c0a-e66b-471a-b0a8-69ac68d0f97d' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:21037c0a-e66b-471a-b0a8-69ac68d0f97d', 1, NULL, 'Messe à l''usage des Paroisses', 'Messe à l''usage des Paroisses', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 23594 AND p.composer_id = 431
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:21037c0a-e66b-471a-b0a8-69ac68d0f97d'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:21037c0a-e66b-471a-b0a8-69ac68d0f97d'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'Plein chant de l''Agnus Dei, en Basse et en Taille alternativement', part.name_en = 'Messe à l''usage des Paroisses: Plein chant de l''Agnus Dei, en Basse et en Taille alternativement',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 23594 AND p.composer_id = 431 AND part.part_key = 'musicbrainz:00e0b655-7f18-4ee4-a57d-93223329399d' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:00e0b655-7f18-4ee4-a57d-93223329399d', 1, NULL, 'Plein chant de l''Agnus Dei, en Basse et en Taille alternativement', 'Messe à l''usage des Paroisses: Plein chant de l''Agnus Dei, en Basse et en Taille alternativement', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:21037c0a-e66b-471a-b0a8-69ac68d0f97d'
WHERE p.id = 23594 AND p.composer_id = 431
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:00e0b655-7f18-4ee4-a57d-93223329399d'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:21037c0a-e66b-471a-b0a8-69ac68d0f97d'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'Dialogue sur la Voix humaine. 7e Couplet', part.name_en = 'Messe à l''usage des Paroisses: Dialogue sur la Voix humaine. 7e Couplet',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 23594 AND p.composer_id = 431 AND part.part_key = 'musicbrainz:0392da13-ebfd-413d-a145-004f73211860' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:0392da13-ebfd-413d-a145-004f73211860', 2, NULL, 'Dialogue sur la Voix humaine. 7e Couplet', 'Messe à l''usage des Paroisses: Dialogue sur la Voix humaine. 7e Couplet', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:21037c0a-e66b-471a-b0a8-69ac68d0f97d'
WHERE p.id = 23594 AND p.composer_id = 431
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:0392da13-ebfd-413d-a145-004f73211860'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:21037c0a-e66b-471a-b0a8-69ac68d0f97d'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = NULL,
    part.name_ko = 'Tierce en Taille. 6e Couplet', part.name_en = 'Messe à l''usage des Paroisses: Tierce en Taille. 6e Couplet',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 23594 AND p.composer_id = 431 AND part.part_key = 'musicbrainz:1786ac50-09bd-4b1a-9153-3de25d6b3b76' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:1786ac50-09bd-4b1a-9153-3de25d6b3b76', 3, NULL, 'Tierce en Taille. 6e Couplet', 'Messe à l''usage des Paroisses: Tierce en Taille. 6e Couplet', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:21037c0a-e66b-471a-b0a8-69ac68d0f97d'
WHERE p.id = 23594 AND p.composer_id = 431
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:1786ac50-09bd-4b1a-9153-3de25d6b3b76'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:21037c0a-e66b-471a-b0a8-69ac68d0f97d'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = NULL,
    part.name_ko = 'Petitte fugue sur le Chromhorne. 2e Couplet du Gloria', part.name_en = 'Messe à l''usage des Paroisses: Petitte fugue sur le Chromhorne. 2e Couplet du Gloria',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 23594 AND p.composer_id = 431 AND part.part_key = 'musicbrainz:1d87d7b1-f9d4-4a03-9960-0acc1350cd86' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:1d87d7b1-f9d4-4a03-9960-0acc1350cd86', 4, NULL, 'Petitte fugue sur le Chromhorne. 2e Couplet du Gloria', 'Messe à l''usage des Paroisses: Petitte fugue sur le Chromhorne. 2e Couplet du Gloria', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:21037c0a-e66b-471a-b0a8-69ac68d0f97d'
WHERE p.id = 23594 AND p.composer_id = 431
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:1d87d7b1-f9d4-4a03-9960-0acc1350cd86'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:21037c0a-e66b-471a-b0a8-69ac68d0f97d'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 5, part.movement_number = NULL,
    part.name_ko = 'Recit de Cornet. 2e Couplet', part.name_en = 'Messe à l''usage des Paroisses: Recit de Cornet. 2e Couplet',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 23594 AND p.composer_id = 431 AND part.part_key = 'musicbrainz:41c69335-7bff-4649-a761-99f864c38a3f' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:41c69335-7bff-4649-a761-99f864c38a3f', 5, NULL, 'Recit de Cornet. 2e Couplet', 'Messe à l''usage des Paroisses: Recit de Cornet. 2e Couplet', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:21037c0a-e66b-471a-b0a8-69ac68d0f97d'
WHERE p.id = 23594 AND p.composer_id = 431
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:41c69335-7bff-4649-a761-99f864c38a3f'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:21037c0a-e66b-471a-b0a8-69ac68d0f97d'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 6, part.movement_number = NULL,
    part.name_ko = 'Recit de Chromhorne. 3d. Couplet', part.name_en = 'Messe à l''usage des Paroisses: Recit de Chromhorne. 3d. Couplet',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 23594 AND p.composer_id = 431 AND part.part_key = 'musicbrainz:4aa3243e-4789-49ec-a1a1-131ccc1d731d' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:4aa3243e-4789-49ec-a1a1-131ccc1d731d', 6, NULL, 'Recit de Chromhorne. 3d. Couplet', 'Messe à l''usage des Paroisses: Recit de Chromhorne. 3d. Couplet', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:21037c0a-e66b-471a-b0a8-69ac68d0f97d'
WHERE p.id = 23594 AND p.composer_id = 431
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:4aa3243e-4789-49ec-a1a1-131ccc1d731d'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:21037c0a-e66b-471a-b0a8-69ac68d0f97d'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 7, part.movement_number = NULL,
    part.name_ko = 'Dialogue sur les Grands jeux. 3e Couplet de l''Agnus', part.name_en = 'Messe à l''usage des Paroisses: Dialogue sur les Grands jeux. 3e Couplet de l''Agnus',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 23594 AND p.composer_id = 431 AND part.part_key = 'musicbrainz:4deb360b-ead9-4f9d-8071-8ab0ee582ae9' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:4deb360b-ead9-4f9d-8071-8ab0ee582ae9', 7, NULL, 'Dialogue sur les Grands jeux. 3e Couplet de l''Agnus', 'Messe à l''usage des Paroisses: Dialogue sur les Grands jeux. 3e Couplet de l''Agnus', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:21037c0a-e66b-471a-b0a8-69ac68d0f97d'
WHERE p.id = 23594 AND p.composer_id = 431
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:4deb360b-ead9-4f9d-8071-8ab0ee582ae9'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:21037c0a-e66b-471a-b0a8-69ac68d0f97d'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 8, part.movement_number = NULL,
    part.name_ko = 'Duo sur les Tierces. 3e Couplet', part.name_en = 'Messe à l''usage des Paroisses: Duo sur les Tierces. 3e Couplet',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 23594 AND p.composer_id = 431 AND part.part_key = 'musicbrainz:527dbe09-cc60-43f0-b9b6-4d0e852dfc57' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:527dbe09-cc60-43f0-b9b6-4d0e852dfc57', 8, NULL, 'Duo sur les Tierces. 3e Couplet', 'Messe à l''usage des Paroisses: Duo sur les Tierces. 3e Couplet', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:21037c0a-e66b-471a-b0a8-69ac68d0f97d'
WHERE p.id = 23594 AND p.composer_id = 431
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:527dbe09-cc60-43f0-b9b6-4d0e852dfc57'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:21037c0a-e66b-471a-b0a8-69ac68d0f97d'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 9, part.movement_number = NULL,
    part.name_ko = 'Dialogue sur la Trompette et le Chromhorner. 4e Couplet', part.name_en = 'Messe à l''usage des Paroisses: Dialogue sur la Trompette et le Chromhorner. 4e Couplet',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 23594 AND p.composer_id = 431 AND part.part_key = 'musicbrainz:62e95a59-b2ee-4f7e-bbcc-3aacedf7e527' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:62e95a59-b2ee-4f7e-bbcc-3aacedf7e527', 9, NULL, 'Dialogue sur la Trompette et le Chromhorner. 4e Couplet', 'Messe à l''usage des Paroisses: Dialogue sur la Trompette et le Chromhorner. 4e Couplet', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:21037c0a-e66b-471a-b0a8-69ac68d0f97d'
WHERE p.id = 23594 AND p.composer_id = 431
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:62e95a59-b2ee-4f7e-bbcc-3aacedf7e527'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:21037c0a-e66b-471a-b0a8-69ac68d0f97d'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 10, part.movement_number = NULL,
    part.name_ko = 'Pleint chant. 5e et dernier Couplet', part.name_en = 'Messe à l''usage des Paroisses: Pleint chant. 5e et dernier Couplet',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 23594 AND p.composer_id = 431 AND part.part_key = 'musicbrainz:67b49945-67bd-467a-8db4-f0396e492e6b' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:67b49945-67bd-467a-8db4-f0396e492e6b', 10, NULL, 'Pleint chant. 5e et dernier Couplet', 'Messe à l''usage des Paroisses: Pleint chant. 5e et dernier Couplet', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:21037c0a-e66b-471a-b0a8-69ac68d0f97d'
WHERE p.id = 23594 AND p.composer_id = 431
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:67b49945-67bd-467a-8db4-f0396e492e6b'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:21037c0a-e66b-471a-b0a8-69ac68d0f97d'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 11, part.movement_number = NULL,
    part.name_ko = 'Deo gratias. Petit plein jeu', part.name_en = 'Messe à l''usage des Paroisses: Deo gratias. Petit plein jeu',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 23594 AND p.composer_id = 431 AND part.part_key = 'musicbrainz:a0eaafb8-9ccf-4463-8efb-95238049463e' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:a0eaafb8-9ccf-4463-8efb-95238049463e', 11, NULL, 'Deo gratias. Petit plein jeu', 'Messe à l''usage des Paroisses: Deo gratias. Petit plein jeu', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:21037c0a-e66b-471a-b0a8-69ac68d0f97d'
WHERE p.id = 23594 AND p.composer_id = 431
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:a0eaafb8-9ccf-4463-8efb-95238049463e'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:21037c0a-e66b-471a-b0a8-69ac68d0f97d'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 12, part.movement_number = NULL,
    part.name_ko = 'Fugue sur les jeux d''Anches. 2e Couplet', part.name_en = 'Messe à l''usage des Paroisses: Fugue sur les jeux d''Anches. 2e Couplet',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 23594 AND p.composer_id = 431 AND part.part_key = 'musicbrainz:af77d49b-e471-432e-9503-5cd626cc9fb2' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:af77d49b-e471-432e-9503-5cd626cc9fb2', 12, NULL, 'Fugue sur les jeux d''Anches. 2e Couplet', 'Messe à l''usage des Paroisses: Fugue sur les jeux d''Anches. 2e Couplet', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:21037c0a-e66b-471a-b0a8-69ac68d0f97d'
WHERE p.id = 23594 AND p.composer_id = 431
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:af77d49b-e471-432e-9503-5cd626cc9fb2'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:21037c0a-e66b-471a-b0a8-69ac68d0f97d'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 13, part.movement_number = NULL,
    part.name_ko = 'Plein chant du premier Kyrie, en Taille', part.name_en = 'Messe à l''usage des Paroisses: Plein chant du premier Kyrie, en Taille',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 23594 AND p.composer_id = 431 AND part.part_key = 'musicbrainz:afff4c9b-c9ef-4833-ab9b-ed65ed506eeb' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:afff4c9b-c9ef-4833-ab9b-ed65ed506eeb', 13, NULL, 'Plein chant du premier Kyrie, en Taille', 'Messe à l''usage des Paroisses: Plein chant du premier Kyrie, en Taille', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:21037c0a-e66b-471a-b0a8-69ac68d0f97d'
WHERE p.id = 23594 AND p.composer_id = 431
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:afff4c9b-c9ef-4833-ab9b-ed65ed506eeb'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:21037c0a-e66b-471a-b0a8-69ac68d0f97d'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 14, part.movement_number = NULL,
    part.name_ko = 'Pleint chant du premier Sanctus en Canon', part.name_en = 'Messe à l''usage des Paroisses: Pleint chant du premier Sanctus en Canon',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 23594 AND p.composer_id = 431 AND part.part_key = 'musicbrainz:b58b823c-9b35-41e7-9420-fbe55baee5f5' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:b58b823c-9b35-41e7-9420-fbe55baee5f5', 14, NULL, 'Pleint chant du premier Sanctus en Canon', 'Messe à l''usage des Paroisses: Pleint chant du premier Sanctus en Canon', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:21037c0a-e66b-471a-b0a8-69ac68d0f97d'
WHERE p.id = 23594 AND p.composer_id = 431
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:b58b823c-9b35-41e7-9420-fbe55baee5f5'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:21037c0a-e66b-471a-b0a8-69ac68d0f97d'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 15, part.movement_number = NULL,
    part.name_ko = 'Dialogue sur les Grands jeux. 9e et dernier Couplet', part.name_en = 'Messe à l''usage des Paroisses: Dialogue sur les Grands jeux. 9e et dernier Couplet',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 23594 AND p.composer_id = 431 AND part.part_key = 'musicbrainz:bacc4941-3dd6-40d2-aac1-4aca8f9093c7' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:bacc4941-3dd6-40d2-aac1-4aca8f9093c7', 15, NULL, 'Dialogue sur les Grands jeux. 9e et dernier Couplet', 'Messe à l''usage des Paroisses: Dialogue sur les Grands jeux. 9e et dernier Couplet', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:21037c0a-e66b-471a-b0a8-69ac68d0f97d'
WHERE p.id = 23594 AND p.composer_id = 431
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:bacc4941-3dd6-40d2-aac1-4aca8f9093c7'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:21037c0a-e66b-471a-b0a8-69ac68d0f97d'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 16, part.movement_number = NULL,
    part.name_ko = 'Plein jeu Et in Terra Pax', part.name_en = 'Messe à l''usage des Paroisses: Plein jeu Et in Terra Pax',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 23594 AND p.composer_id = 431 AND part.part_key = 'musicbrainz:c8f849e3-c3d4-4fc7-935d-c362e372751a' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:c8f849e3-c3d4-4fc7-935d-c362e372751a', 16, NULL, 'Plein jeu Et in Terra Pax', 'Messe à l''usage des Paroisses: Plein jeu Et in Terra Pax', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:21037c0a-e66b-471a-b0a8-69ac68d0f97d'
WHERE p.id = 23594 AND p.composer_id = 431
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:c8f849e3-c3d4-4fc7-935d-c362e372751a'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:21037c0a-e66b-471a-b0a8-69ac68d0f97d'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 17, part.movement_number = NULL,
    part.name_ko = 'Benedictus. Chromhorne en Taille', part.name_en = 'Messe à l''usage des Paroisses: Benedictus. Chromhorne en Taille',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 23594 AND p.composer_id = 431 AND part.part_key = 'musicbrainz:ce82e9df-1770-438a-8d61-2e4448fdf72b' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:ce82e9df-1770-438a-8d61-2e4448fdf72b', 17, NULL, 'Benedictus. Chromhorne en Taille', 'Messe à l''usage des Paroisses: Benedictus. Chromhorne en Taille', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:21037c0a-e66b-471a-b0a8-69ac68d0f97d'
WHERE p.id = 23594 AND p.composer_id = 431
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:ce82e9df-1770-438a-8d61-2e4448fdf72b'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:21037c0a-e66b-471a-b0a8-69ac68d0f97d'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 18, part.movement_number = NULL,
    part.name_ko = 'Dialogue sur les Trompettes Clairon et Tiernes du GC. et le bourdon avec le larigot du positif. 4e Couplet', part.name_en = 'Messe à l''usage des Paroisses: Dialogue sur les Trompettes Clairon et Tiernes du GC. et le bourdon avec le larigot du positif. 4e Couplet',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 23594 AND p.composer_id = 431 AND part.part_key = 'musicbrainz:e8719210-b8da-4f04-8ae7-e97d33f219c1' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:e8719210-b8da-4f04-8ae7-e97d33f219c1', 18, NULL, 'Dialogue sur les Trompettes Clairon et Tiernes du GC. et le bourdon avec le larigot du positif. 4e Couplet', 'Messe à l''usage des Paroisses: Dialogue sur les Trompettes Clairon et Tiernes du GC. et le bourdon avec le larigot du positif. 4e Couplet', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:21037c0a-e66b-471a-b0a8-69ac68d0f97d'
WHERE p.id = 23594 AND p.composer_id = 431
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:e8719210-b8da-4f04-8ae7-e97d33f219c1'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:21037c0a-e66b-471a-b0a8-69ac68d0f97d'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 19, part.movement_number = NULL,
    part.name_ko = 'Dialogue en trio du Cornet et de la Tierce. 8e Couplet', part.name_en = 'Messe à l''usage des Paroisses: Dialogue en trio du Cornet et de la Tierce. 8e Couplet',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 23594 AND p.composer_id = 431 AND part.part_key = 'musicbrainz:fd99c4fe-3d9a-4457-b9a5-c44d09008340' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:fd99c4fe-3d9a-4457-b9a5-c44d09008340', 19, NULL, 'Dialogue en trio du Cornet et de la Tierce. 8e Couplet', 'Messe à l''usage des Paroisses: Dialogue en trio du Cornet et de la Tierce. 8e Couplet', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:21037c0a-e66b-471a-b0a8-69ac68d0f97d'
WHERE p.id = 23594 AND p.composer_id = 431
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:fd99c4fe-3d9a-4457-b9a5-c44d09008340'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:21037c0a-e66b-471a-b0a8-69ac68d0f97d'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 20, part.movement_number = NULL,
    part.name_ko = 'Offertoire sur les Grands jeux', part.name_en = 'Messe à l''usage des Paroisses: Offertoire sur les Grands jeux',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 23594 AND p.composer_id = 431 AND part.part_key = 'musicbrainz:fe643146-cef7-4c96-8a67-fe815ef18033' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:fe643146-cef7-4c96-8a67-fe815ef18033', 20, NULL, 'Offertoire sur les Grands jeux', 'Messe à l''usage des Paroisses: Offertoire sur les Grands jeux', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:21037c0a-e66b-471a-b0a8-69ac68d0f97d'
WHERE p.id = 23594 AND p.composer_id = 431
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:fe643146-cef7-4c96-8a67-fe815ef18033'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:21037c0a-e66b-471a-b0a8-69ac68d0f97d'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 21, part.movement_number = NULL,
    part.name_ko = 'Trio a 2 Dessus de Chromhorne et la basse de Tierce. 5e Couplet', part.name_en = 'Messe à l''usage des Paroisses: Trio a 2 Dessus de Chromhorne et la basse de Tierce. 5e Couplet',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 23594 AND p.composer_id = 431 AND part.part_key = 'musicbrainz:fed32100-5d4e-40f0-aab1-55743684bafe' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:fed32100-5d4e-40f0-aab1-55743684bafe', 21, NULL, 'Trio a 2 Dessus de Chromhorne et la basse de Tierce. 5e Couplet', 'Messe à l''usage des Paroisses: Trio a 2 Dessus de Chromhorne et la basse de Tierce. 5e Couplet', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:21037c0a-e66b-471a-b0a8-69ac68d0f97d'
WHERE p.id = 23594 AND p.composer_id = 431
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:fed32100-5d4e-40f0-aab1-55743684bafe'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'Messe pour les Couvents', part.name_en = 'Messe pour les Couvents',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 23594 AND p.composer_id = 431 AND part.part_key = 'musicbrainz:d816e5e3-41bf-4b33-818c-e5b1bea2a85e' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:d816e5e3-41bf-4b33-818c-e5b1bea2a85e', 2, NULL, 'Messe pour les Couvents', 'Messe pour les Couvents', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 23594 AND p.composer_id = 431
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:d816e5e3-41bf-4b33-818c-e5b1bea2a85e'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:d816e5e3-41bf-4b33-818c-e5b1bea2a85e'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'Kyrie', part.name_en = 'Messe pour les Couvents: I. Kyrie',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 23594 AND p.composer_id = 431 AND part.part_key = 'musicbrainz:5aa12f19-bb4a-45c1-9205-91014665d0bf' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:5aa12f19-bb4a-45c1-9205-91014665d0bf', 1, NULL, 'Kyrie', 'Messe pour les Couvents: I. Kyrie', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:d816e5e3-41bf-4b33-818c-e5b1bea2a85e'
WHERE p.id = 23594 AND p.composer_id = 431
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:5aa12f19-bb4a-45c1-9205-91014665d0bf'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:d816e5e3-41bf-4b33-818c-e5b1bea2a85e'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'Gloria', part.name_en = 'Messe pour les Couvents: II. Gloria',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 23594 AND p.composer_id = 431 AND part.part_key = 'musicbrainz:64f07cf7-0af1-4900-80f3-27546a5f83a7' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:64f07cf7-0af1-4900-80f3-27546a5f83a7', 2, NULL, 'Gloria', 'Messe pour les Couvents: II. Gloria', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:d816e5e3-41bf-4b33-818c-e5b1bea2a85e'
WHERE p.id = 23594 AND p.composer_id = 431
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:64f07cf7-0af1-4900-80f3-27546a5f83a7'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:d816e5e3-41bf-4b33-818c-e5b1bea2a85e'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = NULL,
    part.name_ko = 'Offertoire sur les Grands Jeux', part.name_en = 'Messe pour les Couvents: III. Offertoire sur les Grands Jeux',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 23594 AND p.composer_id = 431 AND part.part_key = 'musicbrainz:84b2b704-b7b6-4213-95c4-13eaae4cf5e5' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:84b2b704-b7b6-4213-95c4-13eaae4cf5e5', 3, NULL, 'Offertoire sur les Grands Jeux', 'Messe pour les Couvents: III. Offertoire sur les Grands Jeux', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:d816e5e3-41bf-4b33-818c-e5b1bea2a85e'
WHERE p.id = 23594 AND p.composer_id = 431
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:84b2b704-b7b6-4213-95c4-13eaae4cf5e5'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:d816e5e3-41bf-4b33-818c-e5b1bea2a85e'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = NULL,
    part.name_ko = 'Sanctus', part.name_en = 'Messe pour les Couvents: IV. Sanctus',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 23594 AND p.composer_id = 431 AND part.part_key = 'musicbrainz:c7532e13-981b-49a6-81e8-1f33d3912d6b' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:c7532e13-981b-49a6-81e8-1f33d3912d6b', 4, NULL, 'Sanctus', 'Messe pour les Couvents: IV. Sanctus', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:d816e5e3-41bf-4b33-818c-e5b1bea2a85e'
WHERE p.id = 23594 AND p.composer_id = 431
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:c7532e13-981b-49a6-81e8-1f33d3912d6b'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:d816e5e3-41bf-4b33-818c-e5b1bea2a85e'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 5, part.movement_number = NULL,
    part.name_ko = 'Agnus Dei', part.name_en = 'Messe pour les Couvents: V. Agnus Dei',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 23594 AND p.composer_id = 431 AND part.part_key = 'musicbrainz:403e4dc1-79c5-4ff4-b87a-4555b975a7a2' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:403e4dc1-79c5-4ff4-b87a-4555b975a7a2', 5, NULL, 'Agnus Dei', 'Messe pour les Couvents: V. Agnus Dei', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:d816e5e3-41bf-4b33-818c-e5b1bea2a85e'
WHERE p.id = 23594 AND p.composer_id = 431
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:403e4dc1-79c5-4ff4-b87a-4555b975a7a2'
);


-- None Pièces de violes

UPDATE pieces piece
SET piece.title = 'Pièces de violes', piece.title_en = 'Pièces de violes',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 24884 AND piece.composer_id = 431
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'Prélude', part.name_en = '1re Suite de viole en mi mineur: I. Prélude',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 24884 AND p.composer_id = 431 AND part.part_key = 'musicbrainz:a843d6ad-e2cb-453d-a928-3ff1c862a361' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:a843d6ad-e2cb-453d-a928-3ff1c862a361', 1, 'I', 'Prélude', '1re Suite de viole en mi mineur: I. Prélude', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 24884 AND p.composer_id = 431
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:a843d6ad-e2cb-453d-a928-3ff1c862a361'
);


-- None Precatio ad Deum

UPDATE pieces piece
SET piece.title = 'Precatio ad Deum', piece.title_en = 'Precatio ad Deum',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 23568 AND piece.composer_id = 431
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None 전주곡

UPDATE pieces piece
SET piece.title = '전주곡', piece.title_en = 'Prélude',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 25496 AND piece.composer_id = 431
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Quid retribuam tibi Domine

UPDATE pieces piece
SET piece.title = 'Quid retribuam tibi Domine', piece.title_en = 'Quid retribuam tibi Domine',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 25900 AND piece.composer_id = 431
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None 아리아 <Qu’on ne me dise plus que c’est la seule absence>

UPDATE pieces piece
SET piece.title = '아리아 <Qu’on ne me dise plus que c’est la seule absence>', piece.title_en = 'Qu’on ne me dise plus que c’est la seule absence',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 23751 AND piece.composer_id = 431
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None 모테트 <Resonent organa, "Motet for Ste Cecile">

UPDATE pieces piece
SET piece.title = '모테트 <Resonent organa, "Motet for Ste Cecile">', piece.title_en = 'Resonent organa, "Motet for Ste Cecile"',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 24525 AND piece.composer_id = 431
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Respice in me

UPDATE pieces piece
SET piece.title = 'Respice in me', piece.title_en = 'Respice in me',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 25408 AND piece.composer_id = 431
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Rondeau, BWV Anh. 183

UPDATE pieces piece
SET piece.title = 'Rondeau, BWV Anh. 183', piece.title_en = 'Rondeau, BWV Anh. 183',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 23558 AND piece.composer_id = 431
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Salve Regina

UPDATE pieces piece
SET piece.title = 'Salve Regina', piece.title_en = 'Salve Regina',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 23692 AND piece.composer_id = 431
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Sarabande 'La Majestueuse'

UPDATE pieces piece
SET piece.title = 'Sarabande ''La Majestueuse''', piece.title_en = 'Sarabande ''La Majestueuse''',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 25157 AND piece.composer_id = 431
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None 소나타 "La Sultane"

UPDATE pieces piece
SET piece.title = '소나타 "La Sultane"', piece.title_en = 'Sonate "La Sultane"',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 23681 AND piece.composer_id = 431
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Sonate «L'Astrée»

UPDATE pieces piece
SET piece.title = 'Sonate «L''Astrée»', piece.title_en = 'Sonate «L''Astrée»',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 24143 AND piece.composer_id = 431
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Sonate «La Convalescente»

UPDATE pieces piece
SET piece.title = 'Sonate «La Convalescente»', piece.title_en = 'Sonate «La Convalescente»',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 24557 AND piece.composer_id = 431
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Sonate «La Pucelle»

UPDATE pieces piece
SET piece.title = 'Sonate «La Pucelle»', piece.title_en = 'Sonate «La Pucelle»',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 24717 AND piece.composer_id = 431
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Sonate «La Steinquerque»

UPDATE pieces piece
SET piece.title = 'Sonate «La Steinquerque»', piece.title_en = 'Sonate «La Steinquerque»',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 23812 AND piece.composer_id = 431
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Sonate «La Visionnaire»

UPDATE pieces piece
SET piece.title = 'Sonate «La Visionnaire»', piece.title_en = 'Sonate «La Visionnaire»',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 23801 AND piece.composer_id = 431
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None 모테트 <Tantum ergo sacramentum>

UPDATE pieces piece
SET piece.title = '모테트 <Tantum ergo sacramentum>', piece.title_en = 'Tantum ergo sacramentum',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 24120 AND piece.composer_id = 431
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Usquequo, Domine

UPDATE pieces piece
SET piece.title = 'Usquequo, Domine', piece.title_en = 'Usquequo, Domine',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 25013 AND piece.composer_id = 431
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Venite exultemus Domino

UPDATE pieces piece
SET piece.title = 'Venite exultemus Domino', piece.title_en = 'Venite exultemus Domino',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 24038 AND piece.composer_id = 431
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None 아리아 <Zephire, modère en ces lieux>

UPDATE pieces piece
SET piece.title = '아리아 <Zephire, modère en ces lieux>', piece.title_en = 'Zephire, modère en ces lieux',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 24865 AND piece.composer_id = 431
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Chaconne en sol majeur

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, 'Chaconne en sol majeur', 'Chaconne en sol majeur', 'song', NULL, NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 431
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = 'Chaconne en sol majeur'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '30bcea70-806b-4382-a447-70dde90f39dd'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '30bcea70-806b-4382-a447-70dde90f39dd'
FROM pieces p
WHERE p.composer_id = 431 AND p.title = 'Chaconne en sol majeur' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '30bcea70-806b-4382-a447-70dde90f39dd'
);


-- None 마니피카트

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '마니피카트', 'Magnificat', 'album', NULL, NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 431
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '마니피카트'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '16d60b09-ffdc-4310-b52d-2f728db0b591'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '16d60b09-ffdc-4310-b52d-2f728db0b591'
FROM pieces p
WHERE p.composer_id = 431 AND p.title = '마니피카트' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '16d60b09-ffdc-4310-b52d-2f728db0b591'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:2798f07c-d288-4383-be1f-72bb60e334a7', 1, 'III', 'Suscepit Israel puerum suum', 'Magnificat anima mea: III. Suscepit Israel puerum suum', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 431 AND p.title = '마니피카트' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:2798f07c-d288-4383-be1f-72bb60e334a7'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:9dd17bc3-203c-4a69-a0da-9433441348bd', 2, 'I', 'Magnificat anima mea Dominum', 'Magnificat anima mea: I. Magnificat anima mea Dominum', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 431 AND p.title = '마니피카트' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:9dd17bc3-203c-4a69-a0da-9433441348bd'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:b01bc991-3dce-4e8a-89ec-c20e67aec507', 3, 'II', 'Et misericordia ejus a progenie', 'Magnificat anima mea: II. Et misericordia ejus a progenie', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 431 AND p.title = '마니피카트' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:b01bc991-3dce-4e8a-89ec-c20e67aec507'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:bca959b1-b80e-4423-ad34-644bc46e037a', 4, 'IV', 'Gloria Patri, et Filio', 'Magnificat anima mea: IV. Gloria Patri, et Filio', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 431 AND p.title = '마니피카트' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:bca959b1-b80e-4423-ad34-644bc46e037a'
);


-- None 모테트 <Regina coeli laetare>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '모테트 <Regina coeli laetare>', 'Regina coeli laetare', 'song', NULL, NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 431
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '모테트 <Regina coeli laetare>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '500c1f80-d557-4e88-ae63-7bd6efe37504'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '500c1f80-d557-4e88-ae63-7bd6efe37504'
FROM pieces p
WHERE p.composer_id = 431 AND p.title = '모테트 <Regina coeli laetare>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '500c1f80-d557-4e88-ae63-7bd6efe37504'
);


-- None Sicilienne

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, 'Sicilienne', 'Sicilienne', 'song', NULL, NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 431
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = 'Sicilienne'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'c6496edc-7705-4406-b095-92b96e0f0c59'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'c6496edc-7705-4406-b095-92b96e0f0c59'
FROM pieces p
WHERE p.composer_id = 431 AND p.title = 'Sicilienne' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'c6496edc-7705-4406-b095-92b96e0f0c59'
);


-- 카탈로그에 대응이 없는 seed 작품 8개를 목록에서 숨긴다(지우지 않음).
UPDATE pieces piece
SET piece.hidden_reason = 'catalog_unmatched'
WHERE piece.composer_id = 431 AND piece.origin = 'seed' AND piece.hidden_reason IS NULL
  AND piece.id IN (
    23071, 23237, 23347, 23437, 23651, 23684, 25020, 25498
  )
  AND NOT EXISTS (SELECT 1 FROM performance_sectors sector WHERE sector.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM piece_parts linking WHERE linking.linked_piece_id = piece.id);
